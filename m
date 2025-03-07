Return-Path: <linux-kernel+bounces-550214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F49A55CA5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 02:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 532333AB368
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 01:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C88A154C00;
	Fri,  7 Mar 2025 01:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5+JJg7m"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E9413D897;
	Fri,  7 Mar 2025 01:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741309625; cv=none; b=sOMM/vkhjE2+071zfvA/AFk6YJyN141CBZjC+/hiQvlr0hvO0Q4Vv4BmNMMQG2KcnELUX7bG25X6zOLPSytKpQMh+iRREf0DG6jTBaPsQbEklniIAA8duSkmsg6X4poH9EkCUQeH4Q1V6ARSw2l1pMROhpY1hvC1ATtcrYxL4SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741309625; c=relaxed/simple;
	bh=KR8lC6Qsle61j6BlTClmDFwleIUFcBXbcgasZy+w/fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ku9ByHFA0PDGTgRdr7zgcPozBP9HrhDwETK6lQJSLe7anQye2tVYioSkF2alD9lsQN0Cizm+mv9pJcXOv/2mvUkPdGvVy7KQYd+7nkBbe+Zg7F706KqWGMso2alwWm+/MWrNtTnfG5vGqvkGgrBXFH/+wbWhxeGRI6186WbzNKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5+JJg7m; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c3b63dfebfso142772085a.3;
        Thu, 06 Mar 2025 17:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741309623; x=1741914423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/yI/mYh1BO6ZQtegp2P8x4XGECKz1PXqKW0/8fDFBc=;
        b=J5+JJg7mgRYxnMna8hDdTOCnhaoEJQvyWaAb6rZMHNjfxmsa1bTd875Dg1/Zymk5IX
         nPj/SBx6NYpJhsO7EfFL2ApmYvIuGMcpyETFlYLg2tv3NHKbsTxpHbGuc4T4R9XT5/eV
         J7OrSASfAbYarF6lXJ9YOSXciCw4+KqojuQ9GMv0VQpX68GLVcYNjMz6sRtz4WUvWvwU
         jY5CK4grFZprmsz698191HKFlzT+pDwJ5fpfVL8T18OIhl30sv4GjWzZ+YVzH2tXsEOj
         19xidwwMODa1IrPfXas2sxljSGSqtiIfnObrN5qaYhaMwI60ZrAXLjPnt7cf2FZxNaLa
         AXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741309623; x=1741914423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/yI/mYh1BO6ZQtegp2P8x4XGECKz1PXqKW0/8fDFBc=;
        b=jFaTq/nq6q4JdTZuKS/Xo9T/NzGk5X0cIjJ2Y3J7+7PUeDgxZyMMUtgPF1630WRiIG
         BKHt/naEh31JfSQ4R+hulL5nwv6T4wO6uTbAFLWsZDsM9laWKTDIL6aISjgmiDesjkQ8
         l1NHqDX9GME+gcHz/0uN3MX5ZTRcHH+4xpPd/yJJTJYY+St63Y5aS0LW0xsCbcwBORyC
         GaWZE6oa+5O8qyEWo1gn6geSNugzhVQM0Wy3sdtbuMWhPekbyR1pkxB2xzRw9ZwcYq2+
         4EdhzRUDeAVKXU1bsA653pqJpc1O4/PPGhAyOEaT4/utGI/ld4WUHJdYYu65wrklGaqd
         bNhQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4HHoaqCBi9UQCLbAtQkUAGgwMXoUTJe9LYQcZ+c9JpJNFB9e25fFq5BK1qhy+yt/aWER8983U3y3l@vger.kernel.org
X-Gm-Message-State: AOJu0Yzku6a9WLLa/7rleztS6dGohBd7bJoms+xtYEhtDCvwW86xp5+L
	LQQyAcHLFJ+HhIJwUiAO/073ciSc8BBJJ7nR6KEvpeKWA5HoVL6SVj1inF8o
X-Gm-Gg: ASbGncssw3E/TTXXt89YrCDFCKb7O6tEUTDS9Ps/+mq+D200FC8VpINx2nRJeBSVyyH
	i+Pv/MpCo7DrPG+YsB0hYp52ossdnQJs/Fp88WOFG//PpQngv4MWC5uJnhmkigBg6uOwv3/hi/D
	wBFFPqBhgPA89pGv7uTR1OIzbo5SGl1/YbH5y6LgWHQ+1BSOC9fCKwf0rrK+qzWSbAwbqSQbbHR
	2NLSRnW/sw7oSW/MhYbQfRNOqPNML9lNctPo9tcflzUWXxKJTQ5K9tjVlE4X08xEBJ2d8Kue2LN
	/B8/Ky+6q4qWvmMBiVgk
X-Google-Smtp-Source: AGHT+IF38oPewAxJQarlRWok90qUejv7y6pFhlJfLl2mo778r1ARIUx3zo/JvESxDzeivTNMfzjcYQ==
X-Received: by 2002:a05:620a:8001:b0:7c3:bc90:a472 with SMTP id af79cd13be357-7c4e1668962mr245005985a.9.1741309622682;
        Thu, 06 Mar 2025 17:07:02 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c3e5511334sm162257285a.103.2025.03.06.17.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 17:07:01 -0800 (PST)
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
Subject: [PATCH v2 2/2] irqchip/sg2042-msi: Add the Sophgo SG2044 MSI interrupt controller
Date: Fri,  7 Mar 2025 09:06:47 +0800
Message-ID: <20250307010649.422359-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307010649.422359-1-inochiama@gmail.com>
References: <20250307010649.422359-1-inochiama@gmail.com>
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
 drivers/irqchip/irq-sg2042-msi.c | 124 +++++++++++++++++++++++++------
 1 file changed, 103 insertions(+), 21 deletions(-)

diff --git a/drivers/irqchip/irq-sg2042-msi.c b/drivers/irqchip/irq-sg2042-msi.c
index ee682e87eb8b..183002efd86c 100644
--- a/drivers/irqchip/irq-sg2042-msi.c
+++ b/drivers/irqchip/irq-sg2042-msi.c
@@ -19,21 +19,36 @@
 
 #include "irq-msi-lib.h"
 
-#define SG2042_MAX_MSI_VECTOR	32
+struct sg2042_msi_chip_info {
+	const struct irq_chip		*irqchip;
+	const struct msi_parent_ops	*parent_ops;
+};
+
+/**
+ * struct sg204x_msi_chipdata - chip data for the SG204x MSI IRQ controller
+ * @reg_clr:		clear reg, see TRM, 10.1.33, GP_INTR0_CLR
+ * @doorbell_addr:	see TRM, 10.1.32, GP_INTR0_SET
+ * @irq_first:		First vectors number that MSIs starts
+ * @num_irqs:		Number of vectors for MSIs
+ * @msi_map:		mapping for allocated MSI vectors.
+ * @msi_map_lock:	Lock for msi_map
+ * @chip_info:		chip specific infomations
+ */
+struct sg204x_msi_chipdata {
+	void __iomem				*reg_clr;
 
-struct sg2042_msi_chipdata {
-	void __iomem	*reg_clr;	// clear reg, see TRM, 10.1.33, GP_INTR0_CLR
+	phys_addr_t				doorbell_addr;
 
-	phys_addr_t	doorbell_addr;	// see TRM, 10.1.32, GP_INTR0_SET
+	u32					irq_first;
+	u32					num_irqs;
 
-	u32		irq_first;	// The vector number that MSIs starts
-	u32		num_irqs;	// The number of vectors for MSIs
+	unsigned long				*msi_map;
+	struct mutex				msi_map_lock;
 
-	DECLARE_BITMAP(msi_map, SG2042_MAX_MSI_VECTOR);
-	struct mutex	msi_map_lock;	// lock for msi_map
+	const struct sg2042_msi_chip_info	*chip_info;
 };
 
-static int sg2042_msi_allocate_hwirq(struct sg2042_msi_chipdata *data, int num_req)
+static int sg2042_msi_allocate_hwirq(struct sg204x_msi_chipdata *data, int num_req)
 {
 	int first;
 
@@ -43,7 +58,7 @@ static int sg2042_msi_allocate_hwirq(struct sg2042_msi_chipdata *data, int num_r
 	return first >= 0 ? first : -ENOSPC;
 }
 
-static void sg2042_msi_free_hwirq(struct sg2042_msi_chipdata *data, int hwirq, int num_req)
+static void sg2042_msi_free_hwirq(struct sg204x_msi_chipdata *data, int hwirq, int num_req)
 {
 	guard(mutex)(&data->msi_map_lock);
 	bitmap_release_region(data->msi_map, hwirq, get_count_order(num_req));
@@ -51,7 +66,7 @@ static void sg2042_msi_free_hwirq(struct sg2042_msi_chipdata *data, int hwirq, i
 
 static void sg2042_msi_irq_ack(struct irq_data *d)
 {
-	struct sg2042_msi_chipdata *data  = irq_data_get_irq_chip_data(d);
+	struct sg204x_msi_chipdata *data  = irq_data_get_irq_chip_data(d);
 	int bit_off = d->hwirq;
 
 	writel(1 << bit_off, data->reg_clr);
@@ -61,7 +76,7 @@ static void sg2042_msi_irq_ack(struct irq_data *d)
 
 static void sg2042_msi_irq_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
 {
-	struct sg2042_msi_chipdata *data = irq_data_get_irq_chip_data(d);
+	struct sg204x_msi_chipdata *data = irq_data_get_irq_chip_data(d);
 
 	msg->address_hi = upper_32_bits(data->doorbell_addr);
 	msg->address_lo = lower_32_bits(data->doorbell_addr);
@@ -79,9 +94,38 @@ static const struct irq_chip sg2042_msi_middle_irq_chip = {
 	.irq_compose_msi_msg	= sg2042_msi_irq_compose_msi_msg,
 };
 
+static void sg2044_msi_irq_ack(struct irq_data *d)
+{
+	struct sg204x_msi_chipdata *data = irq_data_get_irq_chip_data(d);
+
+	writel(0, (unsigned int *)data->reg_clr + d->hwirq);
+	irq_chip_ack_parent(d);
+}
+
+static void sg2044_msi_irq_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
+{
+	struct sg204x_msi_chipdata *data = irq_data_get_irq_chip_data(d);
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
 static int sg2042_msi_parent_domain_alloc(struct irq_domain *domain, unsigned int virq, int hwirq)
 {
-	struct sg2042_msi_chipdata *data = domain->host_data;
+	struct sg204x_msi_chipdata *data = domain->host_data;
 	struct irq_fwspec fwspec;
 	struct irq_data *d;
 	int ret;
@@ -102,7 +146,7 @@ static int sg2042_msi_parent_domain_alloc(struct irq_domain *domain, unsigned in
 static int sg2042_msi_middle_domain_alloc(struct irq_domain *domain, unsigned int virq,
 					  unsigned int nr_irqs, void *args)
 {
-	struct sg2042_msi_chipdata *data = domain->host_data;
+	struct sg204x_msi_chipdata *data = domain->host_data;
 	int hwirq, err, i;
 
 	hwirq = sg2042_msi_allocate_hwirq(data, nr_irqs);
@@ -115,7 +159,7 @@ static int sg2042_msi_middle_domain_alloc(struct irq_domain *domain, unsigned in
 			goto err_hwirq;
 
 		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
-					      &sg2042_msi_middle_irq_chip, data);
+					      data->chip_info->irqchip, data);
 	}
 
 	return 0;
@@ -131,7 +175,7 @@ static void sg2042_msi_middle_domain_free(struct irq_domain *domain, unsigned in
 					  unsigned int nr_irqs)
 {
 	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
-	struct sg2042_msi_chipdata *data = irq_data_get_irq_chip_data(d);
+	struct sg204x_msi_chipdata *data = irq_data_get_irq_chip_data(d);
 
 	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
 	sg2042_msi_free_hwirq(data, d->hwirq, nr_irqs);
@@ -157,7 +201,22 @@ static const struct msi_parent_ops sg2042_msi_parent_ops = {
 	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
 };
 
-static int sg2042_msi_init_domains(struct sg2042_msi_chipdata *data,
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
+static int sg2042_msi_init_domains(struct sg204x_msi_chipdata *data,
 				   struct irq_domain *plic_domain, struct device *dev)
 {
 	struct fwnode_handle *fwnode = dev_fwnode(dev);
@@ -173,7 +232,7 @@ static int sg2042_msi_init_domains(struct sg2042_msi_chipdata *data,
 	irq_domain_update_bus_token(middle_domain, DOMAIN_BUS_NEXUS);
 
 	middle_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
-	middle_domain->msi_parent_ops = &sg2042_msi_parent_ops;
+	middle_domain->msi_parent_ops = data->chip_info->parent_ops;
 
 	return 0;
 }
@@ -181,16 +240,22 @@ static int sg2042_msi_init_domains(struct sg2042_msi_chipdata *data,
 static int sg2042_msi_probe(struct platform_device *pdev)
 {
 	struct fwnode_reference_args args = { };
-	struct sg2042_msi_chipdata *data;
+	struct sg204x_msi_chipdata *data;
 	struct device *dev = &pdev->dev;
 	struct irq_domain *plic_domain;
 	struct resource *res;
 	int ret;
 
-	data = devm_kzalloc(dev, sizeof(struct sg2042_msi_chipdata), GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(struct sg204x_msi_chipdata), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
+	data->chip_info = device_get_match_data(&pdev->dev);
+	if (!data->chip_info) {
+		dev_err(&pdev->dev, "Failed to get irqchip\n");
+		return -EINVAL;
+	}
+
 	data->reg_clr = devm_platform_ioremap_resource_byname(pdev, "clr");
 	if (IS_ERR(data->reg_clr)) {
 		dev_err(dev, "Failed to map clear register\n");
@@ -231,11 +296,28 @@ static int sg2042_msi_probe(struct platform_device *pdev)
 
 	mutex_init(&data->msi_map_lock);
 
+	data->msi_map = devm_bitmap_zalloc(&pdev->dev, data->num_irqs, GFP_KERNEL);
+	if (!data->msi_map) {
+		dev_err(&pdev->dev, "Unable to allocate msi mapping\n");
+		return -ENOMEM;
+	}
+
 	return sg2042_msi_init_domains(data, plic_domain, dev);
 }
 
+static const struct sg2042_msi_chip_info sg2042_of_data = {
+	.irqchip	= &sg2042_msi_middle_irq_chip,
+	.parent_ops	= &sg2042_msi_parent_ops,
+};
+
+static const struct sg2042_msi_chip_info sg2044_of_data = {
+	.irqchip	= &sg2044_msi_middle_irq_chip,
+	.parent_ops	= &sg2044_msi_parent_ops,
+};
+
 static const struct of_device_id sg2042_msi_of_match[] = {
-	{ .compatible	= "sophgo,sg2042-msi" },
+	{ .compatible	= "sophgo,sg2042-msi", .data	= &sg2042_of_data },
+	{ .compatible	= "sophgo,sg2044-msi", .data	= &sg2044_of_data },
 	{ }
 };
 
-- 
2.48.1


