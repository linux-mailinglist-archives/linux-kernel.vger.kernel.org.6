Return-Path: <linux-kernel+bounces-398682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A666D9BF4A0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA3B51C234B6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 17:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC5C20896A;
	Wed,  6 Nov 2024 17:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="izl5UNHz"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23D8207218
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 17:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730915470; cv=none; b=EqPnRFMNHmL7iIItA8UvYWI8KEiIztTVzc6WicSs6n2aa1we+R6MCcoXVldD2rjcurU1w9Xipmqk/3rHTdc1L8lxl0ptuAkGR1On5PZYXgkaP28jZMjxUw6GcXg1WIT6kjYfWE7ilb77a8iNMVKQ91WNeXlYwTnQxW0EvZJ+KbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730915470; c=relaxed/simple;
	bh=dIWVb2g9QRqcXTaV1s47gMyEVtB2onyQwlrAJa4Jj1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJPGw2ENeBGiQSc2Mm51nubqwnyDUIN7c4ybmHmOUKHYACrO9PKcimVxV6J0YHhmOk0mQWLuGCAMISAyP7AivulR94K06cn8qXCe9SwqTmaxOpKYIecy57iM0/kggQz6zS+pcAVLSmpsDLRln5EPjEFiz1Cw2eEwG1INNgwY2u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=izl5UNHz; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9ec86a67feso2664766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 09:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1730915467; x=1731520267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49hG3lsHGrJySpAEzyxRduAfSvP7r1BXPqy63OvAnoQ=;
        b=izl5UNHzJoVBRdT0WPqM1KjQkaDwaVf2oLbbE5zexih4M36jpqW/mHnuy/l8+QPW6D
         hthQchDEsWH+Ap3YT2C45VN8GlHwqa4HdotDvc8QxmTKIMOF6VUdU/xa7yZMO+PnDwTe
         601EJsHo73/ojX4ldLoCfnn4vioPdJF/qTfnNOt2NfD6aq6GxV6RNIDqRXJ4+et9lwHS
         pWB8BgBZlqrwnbg4boFIRv4lVducSSlFgPWGX+28PuUNXanCDUNlD4gLrGkyx21C8LZ1
         mQmWr2wncCkbWOpoaqoln3WptTyNwJy5nJpdKul2ZrMTOXUBUVPX+QW1PKNoXcvE/eJR
         rkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730915467; x=1731520267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=49hG3lsHGrJySpAEzyxRduAfSvP7r1BXPqy63OvAnoQ=;
        b=jSpjm5+FdC1fSp4xvNIbc2rKJgOuJpWcEzJpm+UJmjpOZ+RAw7C1OV2mWzcM43yWZj
         EJv0QF597GxGJsjVRbdyqWTbcQWd2veJTh15mslE0xdcWu4NNyLQErU0y3ttWC8V56Bw
         6smsWHgGHC+eiuPbmnmOOzLawx2x0xHVH7C5iYnCzxNKDqBzycuzXj2L4Lz1/c+M7aSp
         sS4aUwijr4LqjZJ0cISeP6QplRUMJZ3ZJ2sKEyDQ9qVAVbrZm6rq2BAr9YAlYsBo2Js2
         j2cjUTl9v5bF7Gf08ZuCF49GYykn+GrySC0SaSM+md+j/cyRlnh+NNSuEZ0rr8CEA3y/
         tglg==
X-Forwarded-Encrypted: i=1; AJvYcCWvgbqIDz5RNS2NrmPKvYnBYrPapGRbX6bfyp11XVbkwm2boXji614ULpkNIbKzpqQLGo2i+a1XhDzBxrk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Fzcgv6q2mu+BHZDQBL9mJ1cutpd2HL1H/w0uHNqInFY2U7WS
	YwNJxcRXvD+Nssa0mFKrUKKS7wqE2JiBKsjiZAXNzxSLiI40W8FHVXgh3hu9V+M=
X-Google-Smtp-Source: AGHT+IFfCwyaClKnReIWxUZd0iEfNRrNS6oO6x2m/KaQtRbS25PxoEe6F/CuTCRBg5p3XO9EVv7f2A==
X-Received: by 2002:a17:907:7d93:b0:a9a:8a4:e079 with SMTP id a640c23a62f3a-a9de5edea84mr4205271366b.31.1730915467354;
        Wed, 06 Nov 2024 09:51:07 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb17d7328sm312443566b.129.2024.11.06.09.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 09:51:06 -0800 (PST)
From: Andrew Jones <ajones@ventanamicro.com>
To: iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Subject: [PATCH 2/2] iommu/riscv: Add support for platform msi
Date: Wed,  6 Nov 2024 18:51:05 +0100
Message-ID: <20241106175102.219923-6-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106175102.219923-4-ajones@ventanamicro.com>
References: <20241106175102.219923-4-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apply platform_device_msi_init_and_alloc_irqs() to add support for
MSIs when the IOMMU is a platform device.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/iommu/riscv/iommu-platform.c | 102 ++++++++++++++++++++++-----
 1 file changed, 84 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/riscv/iommu-platform.c b/drivers/iommu/riscv/iommu-platform.c
index da336863f152..89aa622bcbde 100644
--- a/drivers/iommu/riscv/iommu-platform.c
+++ b/drivers/iommu/riscv/iommu-platform.c
@@ -11,18 +11,41 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/msi.h>
 
 #include "iommu-bits.h"
 #include "iommu.h"
 
+static void riscv_iommu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
+{
+	struct device *dev = msi_desc_to_dev(desc);
+	struct riscv_iommu_device *iommu = dev_get_drvdata(dev);
+	u16 idx = desc->msi_index;
+	u64 addr;
+
+	addr = ((u64)msg->address_hi << 32) | msg->address_lo;
+
+	if (addr != (addr & RISCV_IOMMU_MSI_CFG_TBL_ADDR))
+		pr_warn_once("uh oh, the IOMMU can't send MSIs to 0x%llx, sending to 0x%llx instead\n",
+			     addr, addr & RISCV_IOMMU_MSI_CFG_TBL_ADDR);
+
+	addr &= RISCV_IOMMU_MSI_CFG_TBL_ADDR;
+
+	riscv_iommu_writeq(iommu, RISCV_IOMMU_REG_MSI_CFG_TBL_ADDR(idx), addr);
+	riscv_iommu_writel(iommu, RISCV_IOMMU_REG_MSI_CFG_TBL_DATA(idx), msg->data);
+	riscv_iommu_writel(iommu, RISCV_IOMMU_REG_MSI_CFG_TBL_CTRL(idx), 0);
+}
+
 static int riscv_iommu_platform_probe(struct platform_device *pdev)
 {
+	enum riscv_iommu_igs_settings igs;
 	struct device *dev = &pdev->dev;
 	struct riscv_iommu_device *iommu = NULL;
 	struct resource *res = NULL;
-	int vec;
+	int vec, ret;
 
 	iommu = devm_kzalloc(dev, sizeof(*iommu), GFP_KERNEL);
 	if (!iommu)
@@ -40,16 +63,6 @@ static int riscv_iommu_platform_probe(struct platform_device *pdev)
 	iommu->caps = riscv_iommu_readq(iommu, RISCV_IOMMU_REG_CAPABILITIES);
 	iommu->fctl = riscv_iommu_readl(iommu, RISCV_IOMMU_REG_FCTL);
 
-	/* For now we only support WSI */
-	switch (FIELD_GET(RISCV_IOMMU_CAPABILITIES_IGS, iommu->caps)) {
-	case RISCV_IOMMU_CAPABILITIES_IGS_WSI:
-	case RISCV_IOMMU_CAPABILITIES_IGS_BOTH:
-		break;
-	default:
-		return dev_err_probe(dev, -ENODEV,
-				     "unable to use wire-signaled interrupts\n");
-	}
-
 	iommu->irqs_count = platform_irq_count(pdev);
 	if (iommu->irqs_count <= 0)
 		return dev_err_probe(dev, -ENODEV,
@@ -57,13 +70,60 @@ static int riscv_iommu_platform_probe(struct platform_device *pdev)
 	if (iommu->irqs_count > RISCV_IOMMU_INTR_COUNT)
 		iommu->irqs_count = RISCV_IOMMU_INTR_COUNT;
 
-	for (vec = 0; vec < iommu->irqs_count; vec++)
-		iommu->irqs[vec] = platform_get_irq(pdev, vec);
+	igs = FIELD_GET(RISCV_IOMMU_CAPABILITIES_IGS, iommu->caps);
+	switch (igs) {
+	case RISCV_IOMMU_CAPABILITIES_IGS_BOTH:
+	case RISCV_IOMMU_CAPABILITIES_IGS_MSI:
+		if (is_of_node(dev->fwnode))
+			of_msi_configure(dev, to_of_node(dev->fwnode));
+
+		if (!dev_get_msi_domain(dev)) {
+			dev_warn(dev, "failed to find an MSI domain");
+			goto msi_fail;
+		}
+
+		ret = platform_device_msi_init_and_alloc_irqs(dev, iommu->irqs_count,
+							      riscv_iommu_write_msi_msg);
+		if (ret) {
+			dev_warn(dev, "failed to allocate MSIs");
+			goto msi_fail;
+		}
+
+		for (vec = 0; vec < iommu->irqs_count; vec++)
+			iommu->irqs[vec] = msi_get_virq(dev, vec);
+
+		/* Enable message-signaled interrupts, fctl.WSI */
+		if (iommu->fctl & RISCV_IOMMU_FCTL_WSI) {
+			iommu->fctl ^= RISCV_IOMMU_FCTL_WSI;
+			riscv_iommu_writel(iommu, RISCV_IOMMU_REG_FCTL, iommu->fctl);
+		}
+
+		dev_info(dev, "using MSIs\n");
+		break;
+
+msi_fail:
+		if (igs != RISCV_IOMMU_CAPABILITIES_IGS_BOTH) {
+			dev_warn(dev, "\n");
+			return dev_err_probe(dev, -ENODEV,
+					     "unable to use wire-signaled interrupts\n");
+		}
+
+		dev_warn(dev, " - falling back to wired irqs\n");
+		fallthrough;
 
-	/* Enable wire-signaled interrupts, fctl.WSI */
-	if (!(iommu->fctl & RISCV_IOMMU_FCTL_WSI)) {
-		iommu->fctl |= RISCV_IOMMU_FCTL_WSI;
-		riscv_iommu_writel(iommu, RISCV_IOMMU_REG_FCTL, iommu->fctl);
+	case RISCV_IOMMU_CAPABILITIES_IGS_WSI:
+		for (vec = 0; vec < iommu->irqs_count; vec++)
+			iommu->irqs[vec] = platform_get_irq(pdev, vec);
+
+		/* Enable wire-signaled interrupts, fctl.WSI */
+		if (!(iommu->fctl & RISCV_IOMMU_FCTL_WSI)) {
+			iommu->fctl |= RISCV_IOMMU_FCTL_WSI;
+			riscv_iommu_writel(iommu, RISCV_IOMMU_REG_FCTL, iommu->fctl);
+		}
+		dev_info(dev, "using wire-signaled interrupts\n");
+		break;
+	default:
+		return dev_err_probe(dev, -ENODEV, "invalid IGS\n");
 	}
 
 	return riscv_iommu_init(iommu);
@@ -71,7 +131,13 @@ static int riscv_iommu_platform_probe(struct platform_device *pdev)
 
 static void riscv_iommu_platform_remove(struct platform_device *pdev)
 {
-	riscv_iommu_remove(dev_get_drvdata(&pdev->dev));
+	struct riscv_iommu_device *iommu = dev_get_drvdata(&pdev->dev);
+	bool msi = !(iommu->fctl & RISCV_IOMMU_FCTL_WSI);
+
+	riscv_iommu_remove(iommu);
+
+	if (msi)
+		platform_device_msi_free_irqs_all(&pdev->dev);
 };
 
 static const struct of_device_id riscv_iommu_of_match[] = {
-- 
2.47.0


