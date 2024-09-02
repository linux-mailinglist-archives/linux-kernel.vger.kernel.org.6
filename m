Return-Path: <linux-kernel+bounces-310498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FD6967DC8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 04:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 856101F2234B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 02:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1346428DD1;
	Mon,  2 Sep 2024 02:24:45 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4246125DB
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 02:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725243884; cv=none; b=OZwNl8S8NCi48IiWL7E9AXVjYBJskUNL06Mw25Np6YliKP/xFVlPHFcOpBQWv6ZGatK/sOk7cBdPH3HlB1rrYfzxayfcaFrTx7u7GOruLZBxDRrJwOXFN02hdPK7ZiG73yFg+8yaEFa/7b7lTi3/tk6KzOV14g2XHanm9YLgAuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725243884; c=relaxed/simple;
	bh=DbnB/77JD3PvxECKqFqF1mhRi0Nld/ggLyEXaYpySec=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AlCZTxJpsUux155W6mvqLslUpQXcwiyTA/vgIKDGjnLt222htmuJNOhY6mbvHWDieZhw+nSKja/4YT7YkVDUSLB80Qt0xZYle5t6lh4Y8evMZ0lqlTi+5hLVBqgBv4tJzUyr6FSfSbIcB3L+OzbkfwED3PANmgwuaPY8mEU6Wuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Wxsxr4rhVz1BK36;
	Mon,  2 Sep 2024 10:23:44 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id F0C2D1800FE;
	Mon,  2 Sep 2024 10:24:38 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 2 Sep
 2024 10:24:38 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <frank.binns@imgtec.com>, <matt.coster@imgtec.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next v2] drm/imagination: Use memdup_user() helper
Date: Mon, 2 Sep 2024 10:33:00 +0800
Message-ID: <20240902023300.1214753-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Switching to memdup_user(), which combines kmalloc() and copy_from_user(),
and it can simplfy code.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v2:
- Add suggested-by.
- Simplify the code.
---
 drivers/gpu/drm/imagination/pvr_context.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_context.c b/drivers/gpu/drm/imagination/pvr_context.c
index eded5e955cc0..98327f9bbd9c 100644
--- a/drivers/gpu/drm/imagination/pvr_context.c
+++ b/drivers/gpu/drm/imagination/pvr_context.c
@@ -69,24 +69,12 @@ process_static_context_state(struct pvr_device *pvr_dev, const struct pvr_stream
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
-
-	kfree(stream);
-
-	return 0;
 
-err_free:
 	kfree(stream);
 
 	return err;
-- 
2.34.1


