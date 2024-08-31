Return-Path: <linux-kernel+bounces-309827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2439670C8
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 12:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C7951C2157F
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 10:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B257F17A583;
	Sat, 31 Aug 2024 10:21:28 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB01C16A940
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 10:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725099688; cv=none; b=R3UUAbFb5IFcAFdAIw+MwPw/HEIAmkBnK7L/Y/sEXywnr3FwEUQ3+s2ceowscdx4a5A7MnSwJoUf3ewK+dL37GxTc7W+tRjE3LSA5HL780iHhCE5BCKqmgO5NV5r45BulhpRe4SEy0/ElykNaLwPRP9y+o/SYdYVR80o6jPXSvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725099688; c=relaxed/simple;
	bh=ww07WZYU6Z8GXNVq6eqDCCDgPB1ih3yQo5VzV7ldO6o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GO7nZeTnZ1GlNwh+PBpt4fy9QbigLHaYSQthZlT15/KVoHOjmi7C+USWK7GOgGjlFmGFXvEuGakpH5o2HWMvSsAKCHDjQl3tJvcwmVLRjBjttbRYGO1yXUNnA8KQjquXndI7SMK3XrgG7Nf9M8pUKh20n6nav3ycU59qt5hOKTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WwrX83Yt6z20nBR;
	Sat, 31 Aug 2024 18:16:24 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 247B81400D7;
	Sat, 31 Aug 2024 18:21:17 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 31 Aug
 2024 18:21:16 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <frank.binns@imgtec.com>, <matt.coster@imgtec.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] drm/imagination: Use memdup_user() helper to simplify code
Date: Sat, 31 Aug 2024 18:29:30 +0800
Message-ID: <20240831102930.97502-1-ruanjinjie@huawei.com>
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
 drivers/gpu/drm/imagination/pvr_job.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_job.c b/drivers/gpu/drm/imagination/pvr_job.c
index 78c2f3c6dce0..618503a212a7 100644
--- a/drivers/gpu/drm/imagination/pvr_job.c
+++ b/drivers/gpu/drm/imagination/pvr_job.c
@@ -90,20 +90,13 @@ static int pvr_fw_cmd_init(struct pvr_device *pvr_dev, struct pvr_job *job,
 	void *stream;
 	int err;
 
-	stream = kzalloc(stream_len, GFP_KERNEL);
-	if (!stream)
-		return -ENOMEM;
-
-	if (copy_from_user(stream, u64_to_user_ptr(stream_userptr), stream_len)) {
-		err = -EFAULT;
-		goto err_free_stream;
-	}
+	stream = memdup_user(u64_to_user_ptr(stream_userptr), stream_len);
+	if (IS_ERR(stream))
+		return PTR_ERR(stream);
 
 	err = pvr_job_process_stream(pvr_dev, stream_def, stream, stream_len, job);
 
-err_free_stream:
 	kfree(stream);
-
 	return err;
 }
 
-- 
2.34.1


