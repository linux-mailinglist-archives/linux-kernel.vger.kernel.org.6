Return-Path: <linux-kernel+bounces-545038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24301A4E83C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42EB67A2036
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA0529614C;
	Tue,  4 Mar 2025 16:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxstBH+y"
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE3C29C328
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107073; cv=fail; b=DcMJw8HRMW/++OliOkWxkYZEhIh5JnfkU2xsXtNhkQ4NDWxJWzHh9ecgHhKuSx9VA9sR34yh9CCbKRhI2d+rae04vTYEqMfTZWTBdbEPaAdYdLetjo+4ej4m1y4BiXfWbpjrTdUyx3gMseteD205dyGvgN0p4BI+Kq5roR+dcHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107073; c=relaxed/simple;
	bh=zzu3+NsAuV5qtNkK5ybD4CbOvMLBdmovgESCJWiVumY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aALeDfF5EhLx5qYxSJPMyi2tNg6AGS6s+h8K1aU7qb/sqnMygFp7HbSMkSPuxNFryXQIiZWyNZKCctgrjl3UWFuMHphEDYjuRIlAmzzxyp/tf39cKEx8eK8GkDvTkZ4GMGo/rhyOE8qjkdhL3uFoaamsczW06TyICAOaTKmGnD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxstBH+y reason="signature verification failed"; arc=none smtp.client-ip=209.85.219.54; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=fail smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id 30EE140CCF22
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:51:10 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=TxstBH+y
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6gzZ02lPzG3CJ
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:26:18 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 6F0B542743; Tue,  4 Mar 2025 19:25:11 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxstBH+y
X-Envelope-From: <linux-kernel+bounces-541557-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxstBH+y
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id D0E3B42CD5
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:21:05 +0300 (+03)
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 217C93063EFC
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:21:04 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BBF67A64B0
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3511F9A90;
	Mon,  3 Mar 2025 11:17:29 +0000 (UTC)
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
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6gzZ02lPzG3CJ
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741711743.8854@yQlVeApmoSY1MgAxSh8z6A
X-ITU-MailScanner-SpamCheck: not spam

Add support for Sophgo SG2044 MSI interrupt controller.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/irqchip/irq-sg2042-msi.c | 86 ++++++++++++++++++++++++++++++--
 1 file changed, 82 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-sg2042-msi.c b/drivers/irqchip/irq-sg204=
2-msi.c
index 9c0a5f2777a4..4b3992821797 100644
--- a/drivers/irqchip/irq-sg2042-msi.c
+++ b/drivers/irqchip/irq-sg2042-msi.c
@@ -21,6 +21,11 @@
=20
 #define SG2042_MAX_MSI_VECTOR	32
=20
+struct sg2042_msi_of_data {
+	const struct irq_chip		*irqchip;
+	const struct msi_parent_ops	*parent_ops;
+};
+
 struct sg2042_msi_chipdata {
 	void __iomem	*reg_clr;	// clear reg, see TRM, 10.1.33, GP_INTR0_CLR
=20
@@ -29,8 +34,10 @@ struct sg2042_msi_chipdata {
 	u32		irq_first;	// The vector number that MSIs starts
 	u32		num_irqs;	// The number of vectors for MSIs
=20
-	DECLARE_BITMAP(msi_map, SG2042_MAX_MSI_VECTOR);
+	unsigned long	*msi_map;
 	struct mutex	msi_map_lock;	// lock for msi_map
+
+	const struct sg2042_msi_of_data	*data;
 };
=20
 static int sg2042_msi_allocate_hwirq(struct sg2042_msi_chipdata *data, i=
nt num_req)
@@ -81,6 +88,37 @@ static const struct irq_chip sg2042_msi_middle_irq_chi=
p =3D {
 	.irq_compose_msi_msg	=3D sg2042_msi_irq_compose_msi_msg,
 };
=20
+static void sg2044_msi_irq_ack(struct irq_data *d)
+{
+	struct sg2042_msi_chipdata *data =3D irq_data_get_irq_chip_data(d);
+
+	writel(0, (unsigned int *)data->reg_clr + d->hwirq);
+
+	irq_chip_ack_parent(d);
+}
+
+static void sg2044_msi_irq_compose_msi_msg(struct irq_data *d,
+					   struct msi_msg *msg)
+{
+	struct sg2042_msi_chipdata *data =3D irq_data_get_irq_chip_data(d);
+	phys_addr_t doorbell =3D data->doorbell_addr +  4 * (d->hwirq / 32);
+
+	msg->address_lo =3D lower_32_bits(doorbell);
+	msg->address_hi =3D upper_32_bits(doorbell);
+	msg->data =3D d->hwirq % 32;
+}
+
+static struct irq_chip sg2044_msi_middle_irq_chip =3D {
+	.name			=3D "SG2044 MSI",
+	.irq_ack		=3D sg2044_msi_irq_ack,
+	.irq_mask		=3D irq_chip_mask_parent,
+	.irq_unmask		=3D irq_chip_unmask_parent,
+#ifdef CONFIG_SMP
+	.irq_set_affinity	=3D irq_chip_set_affinity_parent,
+#endif
+	.irq_compose_msi_msg	=3D sg2044_msi_irq_compose_msi_msg,
+};
+
 static int sg2042_msi_parent_domain_alloc(struct irq_domain *domain,
 					  unsigned int virq, int hwirq)
 {
@@ -119,7 +157,7 @@ static int sg2042_msi_middle_domain_alloc(struct irq_=
domain *domain,
 			goto err_hwirq;
=20
 		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
-					      &sg2042_msi_middle_irq_chip, data);
+					      data->data->irqchip, data);
 	}
=20
 	return 0;
@@ -162,6 +200,21 @@ static const struct msi_parent_ops sg2042_msi_parent=
_ops =3D {
 	.init_dev_msi_info	=3D msi_lib_init_dev_msi_info,
 };
=20
+#define SG2044_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS |	\
+				   MSI_FLAG_USE_DEF_CHIP_OPS)
+
+#define SG2044_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |	\
+				    MSI_FLAG_PCI_MSIX)
+
+static const struct msi_parent_ops sg2044_msi_parent_ops =3D {
+	.required_flags		=3D SG2044_MSI_FLAGS_REQUIRED,
+	.supported_flags	=3D SG2044_MSI_FLAGS_SUPPORTED,
+	.bus_select_mask	=3D MATCH_PCI_MSI,
+	.bus_select_token	=3D DOMAIN_BUS_NEXUS,
+	.prefix			=3D "SG2044-",
+	.init_dev_msi_info	=3D msi_lib_init_dev_msi_info,
+};
+
 static int sg2042_msi_init_domains(struct sg2042_msi_chipdata *data,
 				   struct irq_domain *plic_domain,
 				   struct device *dev)
@@ -181,7 +234,7 @@ static int sg2042_msi_init_domains(struct sg2042_msi_=
chipdata *data,
 	irq_domain_update_bus_token(middle_domain, DOMAIN_BUS_NEXUS);
=20
 	middle_domain->flags |=3D IRQ_DOMAIN_FLAG_MSI_PARENT;
-	middle_domain->msi_parent_ops =3D &sg2042_msi_parent_ops;
+	middle_domain->msi_parent_ops =3D data->data->parent_ops;
=20
 	return 0;
 }
@@ -199,6 +252,12 @@ static int sg2042_msi_probe(struct platform_device *=
pdev)
 	if (!data)
 		return -ENOMEM;
=20
+	data->data =3D device_get_match_data(&pdev->dev);
+	if (!data->data) {
+		dev_err(&pdev->dev, "Failed to get irqchip\n");
+		return -EINVAL;
+	}
+
 	data->reg_clr =3D devm_platform_ioremap_resource_byname(pdev, "clr");
 	if (IS_ERR(data->reg_clr)) {
 		dev_err(dev, "Failed to map clear register\n");
@@ -240,11 +299,30 @@ static int sg2042_msi_probe(struct platform_device =
*pdev)
=20
 	mutex_init(&data->msi_map_lock);
=20
+	data->msi_map =3D devm_bitmap_zalloc(&pdev->dev, data->num_irqs, GFP_KE=
RNEL);
+	if (!data->msi_map) {
+		dev_err(&pdev->dev, "Unable to allocate msi mapping\n");
+		return -ENOMEM;
+	}
+
 	return sg2042_msi_init_domains(data, plic_domain, dev);
 }
=20
+static const struct sg2042_msi_of_data sg2042_of_data =3D {
+	.irqchip	=3D &sg2042_msi_middle_irq_chip,
+	.parent_ops	=3D &sg2042_msi_parent_ops,
+};
+
+static const struct sg2042_msi_of_data sg2044_of_data =3D {
+	.irqchip	=3D &sg2044_msi_middle_irq_chip,
+	.parent_ops	=3D &sg2044_msi_parent_ops,
+};
+
 static const struct of_device_id sg2042_msi_of_match[] =3D {
-	{ .compatible	=3D "sophgo,sg2042-msi" },
+	{ .compatible	=3D "sophgo,sg2042-msi",
+	  .data		=3D &sg2042_of_data },
+	{ .compatible	=3D "sophgo,sg2044-msi",
+	  .data		=3D &sg2044_of_data },
 	{}
 };
=20
--=20
2.48.1



