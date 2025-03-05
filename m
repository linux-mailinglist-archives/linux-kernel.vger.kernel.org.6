Return-Path: <linux-kernel+bounces-545950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29386A4F459
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 03:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6495F3AB0DB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 02:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786E5143736;
	Wed,  5 Mar 2025 02:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Z9KU1cqC"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2901096F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 02:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741140367; cv=none; b=JvCq1tBVMNM2Ztk8R1SByk3iUWWIZOHC+ax1QzoRZhLu+F9A75SasbOoHtvmqWAcnzsDAumixaiqViMQvW3l2zM68KPPi+c1fmMyhoX85M1hrIPwgvlb6i+t2CPlbS1KCWf8ursoqXRXOjnGaMVF2a2Lmcv+M4RUwU3AgRgHAS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741140367; c=relaxed/simple;
	bh=t8x48EmF0+TpzK71MnOEzqfXvvnmv1F8xzBHAsJqg5A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UBkJTEW3smC3o0ePaFvItWbExYAEBdo2CQLieMisW8bcddbYG5prazDw/R+jyVFAdJQUz9AJcsPMPXL2fX4t8KXsasIXPXA53rw431cOFbCbiz+pPPgJ9C2xmkEyJfLFEmsImqKRFox3tJnwP31jA6tSTxIIszSYtRWzmzYJkUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Z9KU1cqC; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741140358; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=pRK4bd+Uu1FKHV8nOIix+G9vPECpr4JTmDRvSH2QUF0=;
	b=Z9KU1cqCEKo717iGkN5F0Qtumgmqo0Ma+iIlZgbtdV0/sR7r7A9xjg3J+cPi4INEOuszAxvWsOgD5F4BKKPBP+xX7QL3Wkvq2p30YzvsNXINHDxt/oOUXwlT4wIGhfpZBN7PrY8o1PUdxaQUYGdxQMKr4CBPYfRTZraTiCxOR+M=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WQjmW2l_1741140347 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 05 Mar 2025 10:05:58 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: fnkl.kernel@gmail.com
Cc: j@jannau.net,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	asahi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] drm: adp: Remove unnecessary print function dev_err()
Date: Wed,  5 Mar 2025 10:05:46 +0800
Message-Id: <20250305020546.96564-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The print function dev_err() is redundant because platform_get_irq_byname()
already prints an error.

./drivers/gpu/drm/adp/adp_drv.c:470:2-9: line 470 is redundant because platform_get_irq() already prints an error.
./drivers/gpu/drm/adp/adp_drv.c:476:2-9: line 476 is redundant because platform_get_irq() already prints an error.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=19211
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/adp/adp_drv.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/adp/adp_drv.c b/drivers/gpu/drm/adp/adp_drv.c
index 0a39abdc9238..0eeb9e5fab26 100644
--- a/drivers/gpu/drm/adp/adp_drv.c
+++ b/drivers/gpu/drm/adp/adp_drv.c
@@ -466,16 +466,12 @@ static int adp_parse_of(struct platform_device *pdev, struct adp_drv_private *ad
 	}
 
 	adp->be_irq = platform_get_irq_byname(pdev, "be");
-	if (adp->be_irq < 0) {
-		dev_err(dev, "failed to find be irq");
+	if (adp->be_irq < 0)
 		return adp->be_irq;
-	}
 
 	adp->fe_irq = platform_get_irq_byname(pdev, "fe");
-	if (adp->fe_irq < 0) {
-		dev_err(dev, "failed to find fe irq");
+	if (adp->fe_irq < 0)
 		return adp->fe_irq;
-	}
 
 	return 0;
 }
-- 
2.32.0.3.g01195cf9f


