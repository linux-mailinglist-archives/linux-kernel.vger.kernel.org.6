Return-Path: <linux-kernel+bounces-235697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD1791D886
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC1F42826A5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 07:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A096F076;
	Mon,  1 Jul 2024 07:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BAbqoD+p"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C795474A
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 07:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719817517; cv=none; b=e3ADfkq1BmZ8YcoNPHy+1jcZNDK5NTe+0xYcHNTdfBLrkwSXp/lAHnrMj5S+jsFjhazwoLAuRMZSUqpBdzzGIiNzqPtq627hwnn2kc093DAEsK4Skde1ob1pmRpBp9xmoFQal+TCKSJABctDQAVYZKls7B9wN9v7LzNb6nYlyI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719817517; c=relaxed/simple;
	bh=Ix/GO3Q5z9x+TpwGcA9AkfVWPhlDy4H4k40+7cgSo5o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mQmWhuX4Tc8Wp6BzcNavV+x1XMmb6GYRgh85quIc4Q6BOkJU7jzzbToQpWeoV7Dqo9tapNJvzHj5ZnESD3uve/+F1uslA7focWG7gf03gcbp4Po0i1oKEuQNflWUnWPwi6oe4GZj7hGd8CWN/evqanLrq5KusGgXrpX+vlqO1bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BAbqoD+p; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719817507; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=+3F2YI0rv/tNSFI3epy5cyCJC8K4OCSe+UT1lTp7dqg=;
	b=BAbqoD+pxp9KjWKbrbzUsWQqdP2zLgG05TPCG8Y3P0syUKE9+GKdjmAZDhZXtzS4sVcuS4xsDK8gJut2flI/DiMJHWS4E0ornu1d/bGPqGgXU12yxTQGHE5Z1cPaHtilR+eybb5yPvCwI5cTLomftsBc3Dvl2kItEaMDCJFZDhw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W9b27tZ_1719817504;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W9b27tZ_1719817504)
          by smtp.aliyun-inc.com;
          Mon, 01 Jul 2024 15:05:06 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: harry.wentland@amd.com
Cc: sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 3/4] drm/amd/display: Fix warning comparing pointer to 0
Date: Mon,  1 Jul 2024 15:04:52 +0800
Message-Id: <20240701070454.106083-2-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20240701070454.106083-1-jiapeng.chong@linux.alibaba.com>
References: <20240701070454.106083-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid pointer type value compared with 0 to make code clear.

./drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_dpmm/dml2_dpmm_factory.c:24:12-13: WARNING comparing pointer to 0.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9458
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 .../amd/display/dc/dml2/dml21/src/dml2_dpmm/dml2_dpmm_factory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_dpmm/dml2_dpmm_factory.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_dpmm/dml2_dpmm_factory.c
index 657ec2e1b119..2c983daf2dad 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_dpmm/dml2_dpmm_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_dpmm/dml2_dpmm_factory.c
@@ -21,7 +21,7 @@ bool dml2_dpmm_create(enum dml2_project_id project_id, struct dml2_dpmm_instance
 {
 	bool result = false;
 
-	if (out == 0)
+	if (!out)
 		return false;
 
 	memset(out, 0, sizeof(struct dml2_dpmm_instance));
-- 
2.20.1.7.g153144c


