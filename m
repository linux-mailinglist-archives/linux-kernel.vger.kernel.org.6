Return-Path: <linux-kernel+bounces-541557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3290A4BE76
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67BCF3A4AD1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8D21F9EC1;
	Mon,  3 Mar 2025 11:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxstBH+y"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EF11F9406;
	Mon,  3 Mar 2025 11:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000645; cv=none; b=jXwbGXSXn/qDe4eRvXHl7liLXpc1Qu3MULnnyTHdUT/DIi2UWQwVZV5gXI4DB7IqMGsS20xqJRakG58MeRc2qhW9Y92z0wIshwpe+/By4tMYY+YDCeT6bRNfbl3ec3hbYlw4jeQCYKHy5KrZvOgAxzbxVnvL3JjWOv17XvXSF7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000645; c=relaxed/simple;
	bh=vs77aUJcijnJ0GNIGtqT5sfhnBoIxjPqvhmlisw6XU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WMZcM78U2htDur513GS3J2NatvOIfKGFlo6AxliiuGBSf7J074VHT/GQVW3Zjv5HfqMBzR+Ka1ZuCwBfIYRG34OokKyZowmraD/4ckKFTrt0Ll1gcClp+G8VPi8uICty2+QumqHvUy6m1hk1oiCezE5d+/i0ZiDmBl9E3DoGY2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxstBH+y; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e88f3159e3so35899926d6.2;
        Mon, 03 Mar 2025 03:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741000642; x=1741605442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYoAzmCu0vns5tkw7HmXXaJNkE1M+oV59kCo2vApjko=;
        b=TxstBH+yHt3iuI4pDRJyUyQdFIqVwISRoq1/czzfpnQH7++V4/gZigNxi4r/0I26WQ
         YVNOsNGoB11o4BBboMVUXOFFxeUHREPjDiO4VMZ4MZTdpsPRKRncmeQsM0XQs2oRcH1h
         YL56tXwSIuKEX62HHkGpVE2f7kVebF+g8hbaJd1fr5k7Dw9wCk+zH4zdkVTS2SHtalnz
         +kXqaB3kMNelqarHitdWyYTWxFaHi1mKgl+wHbH4LTePnOCZyxpbOVReCg4AkMrBHKob
         KCE+qJyyHs4hvQR3A896pnsdWiyI70f7W1DKFfNiugJU6lREyT+MBYDXHXtBY9aSllpK
         DG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741000642; x=1741605442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eYoAzmCu0vns5tkw7HmXXaJNkE1M+oV59kCo2vApjko=;
        b=Chjg7F8CpzrJ2Xs31Lz/4F8R0l5Q8CzT4aOdtUrsWoE+X84p3s+ybOp2LOp7BhGTWX
         Di40x7CYbvU2cu863ff3GfqpSEErV7ayIYv25P0zvjddL8TNEUoWgQoizb+HtqGB3i4C
         MJzzu725E0ojC5OMjkJAcZ/tExMbQWvlGUNaaVsG/F8Cx0Xb16c+6hYrkr9Z5CZknAZZ
         c7yizHGSF3e5gb3mvDyH8f9LETVeqY26/QLnhbXW5hD4pOLS9dQKRaWTGpRhbzj0MhZj
         QWSsbWExAb3+qR25RxZ4MNTSi+Eyt/qH9uQZxcR1UV2OODGS22HzZppmpBVAf67II7yc
         IBpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVM/RfzNdHD75wfThFjdd0rC3fBKck8fHRxCS0/GXu4PLl404QnMqV9Kz/m0pQrwErxHkc/B83+6J0n@vger.kernel.org
X-Gm-Message-State: AOJu0Yylqn2Koc+uTyxppSbK6tgNRBeis3oQK12mf6uueSgve24jGjuC
	gbBRSu/d7J9XSZvXIn+uuv27sypoUTdgmbFouCL4YKZXvzgmhEWD
X-Gm-Gg: ASbGncvxv99d/BSY5sLgQi90k1yN9VNs5RjUraI3xj64AuzuMY2SkZnD98ZLCUOFjy1
	f+/0TzMroXRPnxwSAW29r/nrqoGRkK4ndr5G/yPfW3js5ktYA5bNkOKrFxiRI2l/s0TRIVEKMSO
	DRqmTXADgToRtzDf0W5Neh+lI4iSugzw5UmOJr+bxl0HmUCiSttkYroIyqelrsxQ32iCjl9n0ky
	SREZVv68Da4J/J7Z3UrbcrekllEgci//wXsKookTDQxxHNyP0ipGIZ3VIcDaGEviN0BCyG1D7YC
	biSug/LOt46Rs7zks/eb
X-Google-Smtp-Source: AGHT+IFnzI5yYMUwpgzC+CtqnF8PkSTTAOhLnziiXOW13TnV/5ZF1J9/Py1jNWLdgQBT5OjaRQ4YPg==
X-Received: by 2002:a05:6214:5193:b0:6e6:6048:f42c with SMTP id 6a1803df08f44-6e8a0cd3f2emr192488796d6.8.1741000642572;
        Mon, 03 Mar 2025 03:17:22 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e8a1aba663sm39485296d6.50.2025.03.03.03.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:17:22 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH 2/2] irqchip/sg2042-msi: Add the Sophgo SG2044 MSI interrupt controller
Date: Mon,  3 Mar 2025 19:16:47 +0800
Message-ID: <20250303111648.1337543-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303111648.1337543-1-inochiama@gmail.com>
References: <20250303111648.1337543-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Sophgo SG2044 MSI interrupt controller.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/irqchip/irq-sg2042-msi.c | 86 ++++++++++++++++++++++++++++++--
 1 file changed, 82 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-sg2042-msi.c b/drivers/irqchip/irq-sg2042-msi.c
index 9c0a5f2777a4..4b3992821797 100644
--- a/drivers/irqchip/irq-sg2042-msi.c
+++ b/drivers/irqchip/irq-sg2042-msi.c
@@ -21,6 +21,11 @@
 
 #define SG2042_MAX_MSI_VECTOR	32
 
+struct sg2042_msi_of_data {
+	const struct irq_chip		*irqchip;
+	const struct msi_parent_ops	*parent_ops;
+};
+
 struct sg2042_msi_chipdata {
 	void __iomem	*reg_clr;	// clear reg, see TRM, 10.1.33, GP_INTR0_CLR
 
@@ -29,8 +34,10 @@ struct sg2042_msi_chipdata {
 	u32		irq_first;	// The vector number that MSIs starts
 	u32		num_irqs;	// The number of vectors for MSIs
 
-	DECLARE_BITMAP(msi_map, SG2042_MAX_MSI_VECTOR);
+	unsigned long	*msi_map;
 	struct mutex	msi_map_lock;	// lock for msi_map
+
+	const struct sg2042_msi_of_data	*data;
 };
 
 static int sg2042_msi_allocate_hwirq(struct sg2042_msi_chipdata *data, int num_req)
@@ -81,6 +88,37 @@ static const struct irq_chip sg2042_msi_middle_irq_chip = {
 	.irq_compose_msi_msg	= sg2042_msi_irq_compose_msi_msg,
 };
 
+static void sg2044_msi_irq_ack(struct irq_data *d)
+{
+	struct sg2042_msi_chipdata *data = irq_data_get_irq_chip_data(d);
+
+	writel(0, (unsigned int *)data->reg_clr + d->hwirq);
+
+	irq_chip_ack_parent(d);
+}
+
+static void sg2044_msi_irq_compose_msi_msg(struct irq_data *d,
+					   struct msi_msg *msg)
+{
+	struct sg2042_msi_chipdata *data = irq_data_get_irq_chip_data(d);
+	phys_addr_t doorbell = data->doorbell_addr +  4 * (d->hwirq / 32);
+
+	msg->address_lo = lower_32_bits(doorbell);
+	msg->address_hi = upper_32_bits(doorbell);
+	msg->data = d->hwirq % 32;
+}
+
+static struct irq_chip sg2044_msi_middle_irq_chip = {
+	.name			= "SG2044 MSI",
+	.irq_ack		= sg2044_msi_irq_ack,
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+#ifdef CONFIG_SMP
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+#endif
+	.irq_compose_msi_msg	= sg2044_msi_irq_compose_msi_msg,
+};
+
 static int sg2042_msi_parent_domain_alloc(struct irq_domain *domain,
 					  unsigned int virq, int hwirq)
 {
@@ -119,7 +157,7 @@ static int sg2042_msi_middle_domain_alloc(struct irq_domain *domain,
 			goto err_hwirq;
 
 		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
-					      &sg2042_msi_middle_irq_chip, data);
+					      data->data->irqchip, data);
 	}
 
 	return 0;
@@ -162,6 +200,21 @@ static const struct msi_parent_ops sg2042_msi_parent_ops = {
 	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
 };
 
+#define SG2044_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS |	\
+				   MSI_FLAG_USE_DEF_CHIP_OPS)
+
+#define SG2044_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |	\
+				    MSI_FLAG_PCI_MSIX)
+
+static const struct msi_parent_ops sg2044_msi_parent_ops = {
+	.required_flags		= SG2044_MSI_FLAGS_REQUIRED,
+	.supported_flags	= SG2044_MSI_FLAGS_SUPPORTED,
+	.bus_select_mask	= MATCH_PCI_MSI,
+	.bus_select_token	= DOMAIN_BUS_NEXUS,
+	.prefix			= "SG2044-",
+	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
+};
+
 static int sg2042_msi_init_domains(struct sg2042_msi_chipdata *data,
 				   struct irq_domain *plic_domain,
 				   struct device *dev)
@@ -181,7 +234,7 @@ static int sg2042_msi_init_domains(struct sg2042_msi_chipdata *data,
 	irq_domain_update_bus_token(middle_domain, DOMAIN_BUS_NEXUS);
 
 	middle_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
-	middle_domain->msi_parent_ops = &sg2042_msi_parent_ops;
+	middle_domain->msi_parent_ops = data->data->parent_ops;
 
 	return 0;
 }
@@ -199,6 +252,12 @@ static int sg2042_msi_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
+	data->data = device_get_match_data(&pdev->dev);
+	if (!data->data) {
+		dev_err(&pdev->dev, "Failed to get irqchip\n");
+		return -EINVAL;
+	}
+
 	data->reg_clr = devm_platform_ioremap_resource_byname(pdev, "clr");
 	if (IS_ERR(data->reg_clr)) {
 		dev_err(dev, "Failed to map clear register\n");
@@ -240,11 +299,30 @@ static int sg2042_msi_probe(struct platform_device *pdev)
 
 	mutex_init(&data->msi_map_lock);
 
+	data->msi_map = devm_bitmap_zalloc(&pdev->dev, data->num_irqs, GFP_KERNEL);
+	if (!data->msi_map) {
+		dev_err(&pdev->dev, "Unable to allocate msi mapping\n");
+		return -ENOMEM;
+	}
+
 	return sg2042_msi_init_domains(data, plic_domain, dev);
 }
 
+static const struct sg2042_msi_of_data sg2042_of_data = {
+	.irqchip	= &sg2042_msi_middle_irq_chip,
+	.parent_ops	= &sg2042_msi_parent_ops,
+};
+
+static const struct sg2042_msi_of_data sg2044_of_data = {
+	.irqchip	= &sg2044_msi_middle_irq_chip,
+	.parent_ops	= &sg2044_msi_parent_ops,
+};
+
 static const struct of_device_id sg2042_msi_of_match[] = {
-	{ .compatible	= "sophgo,sg2042-msi" },
+	{ .compatible	= "sophgo,sg2042-msi",
+	  .data		= &sg2042_of_data },
+	{ .compatible	= "sophgo,sg2044-msi",
+	  .data		= &sg2044_of_data },
 	{}
 };
 
-- 
2.48.1


