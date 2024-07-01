Return-Path: <linux-kernel+bounces-235658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD9A91D811
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B7511C2234F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 06:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6614EB51;
	Mon,  1 Jul 2024 06:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="if4eq+V0"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74F536126
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 06:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719815007; cv=none; b=bRZ5b7K1igqt9WEqMvK1Birz89qWWfVIxe8VYe7cUSUxEUpHIW2a/GqtTFQ1uaJkYHxbL5XxN1WYGy0J4Zx5s9Iar7jvqmwjks0ln9s1HawgDd/DpXI1akZY1tFvCxcJbIGofjudJ4iyiexqi9kNi8JGsR4efvrMf0N77YvmhZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719815007; c=relaxed/simple;
	bh=S8QAPEaZ/AW53KetFI7ee6+68AhnfVFdFu51eX5d/XM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I8AxM/zDH21RWEilBmpVaMBA2ZyhRMeakwCwXdzUs8wRBgqQ66X1f6B9mpyaaf5ZQe1bX1MeShBx+FLtoaftaEcHU7zTUzd8zcAT54G5Tf0ehFscgq4LTfw1vfhpQdBdaUDBjyififU79Q88Q3QdVV46A9mjcYc/J0f5xgvPL/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=if4eq+V0; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719814997; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=K0ZmPMNyaItxarb5ePgYH1LDi6uPvP8+DUmCHVAnCI8=;
	b=if4eq+V0R2/6qWw/AApANfd0N/ikhC05UyP07MaMlNks33lljQAFw23DhWlMVhogPI2pyPbjxowjdXmT03KYC1Pe2nDrnayc3FqzEBpalgpleK54h9Zw+xy0/UDIdarjUKQol6/cIuhHMhUsABFqBm7ZQPblrN1MUJV4lWEdtaI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W9ZzIKT_1719814985;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W9ZzIKT_1719814985)
          by smtp.aliyun-inc.com;
          Mon, 01 Jul 2024 14:23:15 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: yannick.fertre@foss.st.com
Cc: raphael.gallais-pou@foss.st.com,
	philippe.cornu@foss.st.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	dri-devel@lists.freedesktop.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] drm/stm: Remove unnecessary .owner for lvds_platform_driver
Date: Mon,  1 Jul 2024 14:23:04 +0800
Message-Id: <20240701062304.42844-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove .owner field if calls are used which set it automatically.

./drivers/gpu/drm/stm/lvds.c:1213:3-8: No need to set .owner here. The core will do it.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9457
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/stm/lvds.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/stm/lvds.c b/drivers/gpu/drm/stm/lvds.c
index 2fa2c81784e9..06f2d7a56cc9 100644
--- a/drivers/gpu/drm/stm/lvds.c
+++ b/drivers/gpu/drm/stm/lvds.c
@@ -1210,7 +1210,6 @@ static struct platform_driver lvds_platform_driver = {
 	.remove = lvds_remove,
 	.driver = {
 		.name = "stm32-display-lvds",
-		.owner = THIS_MODULE,
 		.of_match_table = lvds_dt_ids,
 	},
 };
-- 
2.20.1.7.g153144c


