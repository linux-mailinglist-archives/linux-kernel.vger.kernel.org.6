Return-Path: <linux-kernel+bounces-235696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E7E91D885
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA18AB20BEC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 07:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680785E093;
	Mon,  1 Jul 2024 07:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Sp9Rc4Gi"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221C51B809
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 07:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719817516; cv=none; b=VcQxa3iKz8GJHuzecSXqgJpVl2lyrAS1/0gtDBGFzUBM4uFDhQU1xi5mCyMthce/hyw8AETDFCcj/uGEUS7Ka65Ccd8B7qtBeUt/w+dT0vYNfrOerMqG8viEB50RKxMzOck89Xf6eYXmV8gteShMLoeAkYgeqC2o9Z/EcLsKj9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719817516; c=relaxed/simple;
	bh=PsH9Fpe7LGj/EZh8w39j4UAdg7AZ/zH83fEkMkHc5Rs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RNuhxbzydYfLvtHw+0ghSLVkGc259IQ8E4nKDj3bqRpErJH3904AgSJpZCi3vdGBD8Fsnw5Caefk6p7jO9nnzrV6QoGRd2uq0IdW+bNJmw6w7WZgUFbzYeJ+4ftJl7UmHcU9iaYxn951FJ/WU1Dfj9HzZZPFGRx4erPxxC/8AgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Sp9Rc4Gi; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719817505; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Ro+y49h2mI9evwzbu3a0ljOO28mWlRwukG8jvcAoNYM=;
	b=Sp9Rc4GiQnCJgQT0zNiXPLc8rmsJkPNDhAN4FTq++wW8GvONjBfbE8OA9hUyerg2OS8EZ/UE67VsIsxPxuDw9CBvu7+Ztl4XxItAfXsa220JMt/LY8MzX0fpAMQQEyB21ONldpekYNocjLp1B+Z9GfmGnSIdBKB2z77AgdIN/88=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W9avnxq_1719817496;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W9avnxq_1719817496)
          by smtp.aliyun-inc.com;
          Mon, 01 Jul 2024 15:05:04 +0800
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
Subject: [PATCH 4/4] drm/amd/display: Fix warning comparing pointer to 0
Date: Mon,  1 Jul 2024 15:04:51 +0800
Message-Id: <20240701070454.106083-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid pointer type value compared with 0 to make code clear.

./drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_factory.c:14:12-13: WARNING comparing pointer to 0.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9458
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 .../amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_factory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_factory.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_factory.c
index 1a0da8c6df5a..f56abe9ab919 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_factory.c
@@ -11,7 +11,7 @@ bool dml2_core_create(enum dml2_project_id project_id, struct dml2_core_instance
 {
 	bool result = false;
 
-	if (out == 0)
+	if (!out)
 		return false;
 
 	memset(out, 0, sizeof(struct dml2_core_instance));
-- 
2.20.1.7.g153144c


