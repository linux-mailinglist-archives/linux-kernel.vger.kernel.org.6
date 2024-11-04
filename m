Return-Path: <linux-kernel+bounces-394433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E3B9BAF18
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 10:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D1352825ED
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 09:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6491ABEC1;
	Mon,  4 Nov 2024 09:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G8I+GZjB"
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A57189F47
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 09:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730711276; cv=none; b=lJL0Z9V0CPL8/3B732YOks9E8YUizFLBqdZ9teXzz2KEif0L6R1U9iJVWjr/JLvgxhF6Lq6li6UDa2/XO7Ui8OzCx++Wi6G596X/nfUE6BjLzOan+S+jjJ3WeLz1uvr/GvDCUuVwOLHOaOdD19QVMMeZgUYln1HFHhSVFEh6HFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730711276; c=relaxed/simple;
	bh=7AG4qVUkwZFOIyYdh/9T0tnmHf4IKmUf8QBaqSFwuwY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dAdYJMsfmU2ZUJ2ZGL4E8+RP9Wz2LkgMY5t9T3kJUHhc/K/SaG7Hm77YElilXooj/TXF+p2tpLL10L4Ch7CTdbTOTFuZztOOzr5iz3ce59bWNA1eR52T+ChWCHefJo0z6bbk8mhmVIkt8eIcP8Mo+daL2+O0nwyybreC47FgpKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G8I+GZjB; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730711270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Mh+uxOp22bgHxfo2q4H0OrdD7oJsIQLnF9VKJ19HjM4=;
	b=G8I+GZjBuRR17ujuAjfw/1wJ9OIktEqIzoWeUIJDSxh3VBkxqqRhtWaQ+dNlOldR7dYCYE
	BS9mEpCIPyjREFvNZ7ZJaprEZP7p/cfBzF+dN1FrZHMBJKDCRiB8gfRhvd5tXAnTE1OyTq
	R5dVcCEtZCxE5X6awlY6NOo2aLlHPas=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Rob Clark <robdclark@gmail.com>,
	Sean Paul <sean@poorly.run>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH] drm/msm: Check return value of of_dma_configure()
Date: Mon,  4 Nov 2024 17:07:38 +0800
Message-Id: <20241104090738.529848-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Because the of_dma_configure() will returns '-EPROBE_DEFER' if the probe
procedure of the specific platform IOMMU driver is not finished yet. It
can also return other error code for various reasons.

Stop pretending that it will always suceess, quit if it fail.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 37927bdd6fbe..b26dfe0a76c5 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1605,7 +1605,9 @@ int a6xx_gmu_wrapper_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 
 	gmu->dev = &pdev->dev;
 
-	of_dma_configure(gmu->dev, node, true);
+	ret = of_dma_configure(gmu->dev, node, true);
+	if (ret)
+		return ret;
 
 	pm_runtime_enable(gmu->dev);
 
@@ -1670,7 +1672,9 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 
 	gmu->dev = &pdev->dev;
 
-	of_dma_configure(gmu->dev, node, true);
+	ret = of_dma_configure(gmu->dev, node, true);
+	if (ret)
+		return ret;
 
 	/* Fow now, don't do anything fancy until we get our feet under us */
 	gmu->idle_level = GMU_IDLE_STATE_ACTIVE;
-- 
2.34.1


