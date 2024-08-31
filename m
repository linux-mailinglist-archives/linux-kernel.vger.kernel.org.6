Return-Path: <linux-kernel+bounces-309829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BC49670CB
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 12:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2DACB22558
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 10:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5279179970;
	Sat, 31 Aug 2024 10:22:37 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F08B16F0F0
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 10:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725099757; cv=none; b=i4+1cgLFkSSKeobhJnhpKrb612IQ8XjmK0PUD1Xo05qGcTvwsSPbIUbEUprjfeAS0SYHcsa/ikMSod1MCnXPj+vO/TiApb1Zi7II/jJCAyQI0KzaBEKF+M7jJAc1r4V+QZbO5+bjvS9M2wVEK0OssafUhbZm9lpM1nZfVS2rzVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725099757; c=relaxed/simple;
	bh=1ixH9OkzJ/KGFfbODxkUO32eTSdnQApugAkffkOzqYc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OGq1EXi5sOUXZNd7xQ4yLq3SqfmCnxbTlagenNfA6i7Eg2pWpNAn7IK3OuAmgE+ZsoPIalcawbL9Qe8bsZ5fiaOtBJRTf19AsLo/pRp8twjY8lg+sAyB9Xucy6f+XYJWlduVAHatoIYf2B2AZm7aHiogsnElRQEZFC3HPl22Y38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WwrfD2SlPzyQxW;
	Sat, 31 Aug 2024 18:21:40 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id B52B61400FD;
	Sat, 31 Aug 2024 18:22:32 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 31 Aug
 2024 18:22:32 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <frank.binns@imgtec.com>, <matt.coster@imgtec.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] drm/imagination: Use memdup_user() helper
Date: Sat, 31 Aug 2024 18:30:47 +0800
Message-ID: <20240831103047.99499-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Switching to memdup_user(), which combines kmalloc() and copy_from_user(),
and it can simplfy code.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/gpu/drm/imagination/pvr_context.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_context.c b/drivers/gpu/drm/imagination/pvr_context.c
index eded5e955cc0..e75fd50a4d9f 100644
--- a/drivers/gpu/drm/imagination/pvr_context.c
+++ b/drivers/gpu/drm/imagination/pvr_context.c
@@ -69,27 +69,19 @@ process_static_context_state(struct pvr_device *pvr_dev, const struct pvr_stream
 	void *stream;
 	int err;
 
-	stream = kzalloc(stream_size, GFP_KERNEL);
-	if (!stream)
-		return -ENOMEM;
-
-	if (copy_from_user(stream, u64_to_user_ptr(stream_user_ptr), stream_size)) {
-		err = -EFAULT;
-		goto err_free;
-	}
+	stream = memdup_user(u64_to_user_ptr(stream_user_ptr), stream_size);
+	if (IS_ERR(stream))
+		return PTR_ERR(stream);
 
 	err = pvr_stream_process(pvr_dev, cmd_defs, stream, stream_size, dest);
-	if (err)
-		goto err_free;
+	if (err) {
+		kfree(stream);
+		return err;
+	}
 
 	kfree(stream);
 
 	return 0;
-
-err_free:
-	kfree(stream);
-
-	return err;
 }
 
 static int init_render_fw_objs(struct pvr_context *ctx,
-- 
2.34.1


