Return-Path: <linux-kernel+bounces-332354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C3B97B8C6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 09:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A64F1F22AD5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 07:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CFA16F0F0;
	Wed, 18 Sep 2024 07:49:40 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5738A78C7E
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 07:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726645780; cv=none; b=YaNDfWa5w/EL2bmukoza4jfnrPg7OXLKxiDXKrU2y/dz/ELAk2kJ3hu3TPPBuMD+UOFwKUQ4ygvjfJSuEsYRXdFXc9/bUbC4PTHpjRqEVsKjyJUXOBRix65I84ElqgqWPjaCWRGMMUUHtUZrPt8eUPUIx3RUxQ0bQcDMJ46dEHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726645780; c=relaxed/simple;
	bh=NmZOu2nqPJbkiCwqMI1t8qHCn9/V/DZclwaXeguR5K8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kfaqMlGnME1Gkr/r4sYVDI8upzFUjsahyVCZzUtmoRHIV1HJUuNDXDZTns0nPM12IgaU9jq+FeCQAq2hK2lUFssul+EXC53lBE96HEUpQjzY8K0IgIg4THsPEugxeeGOq6k8Y1jzFAbr+f0GvIqN9CBDBVNY+rdTW2EUa1FhyPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowAAnLKD_hepmM4VgBA--.9368S2;
	Wed, 18 Sep 2024 15:49:19 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: stefan@agner.ch,
	alison.wang@nxp.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] drm/fsl-dcu: Remove redundant dev_err()
Date: Wed, 18 Sep 2024 15:48:41 +0800
Message-Id: <20240918074841.2221210-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAnLKD_hepmM4VgBA--.9368S2
X-Coremail-Antispam: 1UD129KBjvdXoWrur17Zr1kZw1DCw4xJF47Jwb_yoWDGFcEga
	48Zr97Ww1DCr1DZrnrAr4fAFyj93Wq9a1fXw1qqa43t3s8Aw48X340vFWUWwn8Z3ySkFy5
	Ja1xur1akF1fGjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbTkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW8CwCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUGFAJUUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

There is no need to call the dev_err() function directly to print a
custom message when handling an error from platform_get_irq() function
as it is going to display an appropriate error message in case of a
failure.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
index ab6c0c6cd0e2..ad026d77a051 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
@@ -272,10 +272,8 @@ static int fsl_dcu_drm_probe(struct platform_device *pdev)
 	}
 
 	fsl_dev->irq = platform_get_irq(pdev, 0);
-	if (fsl_dev->irq < 0) {
-		dev_err(dev, "failed to get irq\n");
+	if (fsl_dev->irq < 0)
 		return fsl_dev->irq;
-	}
 
 	fsl_dev->regmap = devm_regmap_init_mmio(dev, base,
 			&fsl_dcu_regmap_config);
-- 
2.25.1


