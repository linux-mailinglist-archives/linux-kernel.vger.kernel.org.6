Return-Path: <linux-kernel+bounces-531127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8235A43C91
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CCEF3BD3F3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30999266B6A;
	Tue, 25 Feb 2025 10:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="CfcZyu0d"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A031267708
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481162; cv=none; b=onjSqpZoSLMR2HrNvzGf5GuTT1d2u4H1A4VHJSVp+OdWxcnUHrnKg3d46pOdPi0YZckpjQRHZAHEshcQCOeuIRAAyX0M1KwSymNdNCUYvs0SbmkJeUgeUdKI+Gof2u3Vo3odEPmig1J0tt0NdGsd3gwsx+v81bl10wTP2lgY5VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481162; c=relaxed/simple;
	bh=PAej6HiOIJnD3H8JGnZM2j0gT+XUHSn7Hk7wBnY1sPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oMqVIXeUwl3zX4RpI87hg5iiWNkFgt2kFTFUdiGWsTQJIT3SEkfirobN7QlpDXSrPK+lYSFQAt6DXGUC/A0GQ1YpFU9stEfEaEnLhPf9MGX3ZjlIK+mAdmMryfoDnKwVlvgXEzeePvLW5OGuQYQq9qhMj+F7gSgcRzAgA6RFWo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=CfcZyu0d; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-439350f1a0bso32350025e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 02:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1740481159; x=1741085959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxEGGaill+3QT6cynJkChqHPKlrdFel9L50qblkRAYs=;
        b=CfcZyu0dk9q2jRI/p/58XExd/N3XT+5Zsy58XWFOKHO2TMlVw171i+CZAWD8k6QIlk
         4v8e+WeP5eJYHFWQjafzgEwwXkuVnbre9tIArSE9dAHifBjxk0EkujkFjnf9YwjtjSxy
         fKpUWc7ORklQtnQKhqDDaHUOFTQvWlU+RAYsbgTWYHnv58uIcb2Ij2fJo/IswO/oape8
         FYp75p7+thl7LwsZHV9dEKSqkY+lsxYa9k6KzuXz6yejFzI68IhVyD971hSo0OOcglyP
         cIwxE7CmFG/pKd4biQQMes/hSqhVgQLFyJsEfz2xJJuo2LEuPbJyXafpFShSBzyY5zn8
         /59w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740481159; x=1741085959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BxEGGaill+3QT6cynJkChqHPKlrdFel9L50qblkRAYs=;
        b=kpJ0KrWxrxbHgGCmLK7PFaXAg6JWjME86DID1W0XKEst9YKuaklG7a4jPjl0guMEw8
         VMRwsYErR3AS4qT1eYtI6W+bmpg6Aqoq4+cE5hqOuwHR+enlnfKYSkCIVhJF3WenXB2G
         XNip/SRFMpySHY3L3XjMCNKvkzrvNOU5/3EkxsUuULTLKimEKVa3iO9JE3GEvCk24uWj
         4kK1FaOuDfmYqoZKPNSKNLjjWw0yz3Si3Xh5AEq4hu4fbDxDcfqXa+hRwsSxEIJsnUeC
         H91dk2dCYRAGRLkNyE3XmS4vUHMt2GtbBGePGju5jtm7zRyn8bj9REy1Tp6D19fXsPXU
         akpg==
X-Forwarded-Encrypted: i=1; AJvYcCUySYLDYtGBb44PL4ZMCOyAE0cq4vKhFDHeAFP2f01Dumuo8mo42GAt0d6Y7sYWB0XnLJfi8nZ3AcwBlak=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB4/pu+nDDZhR1PYomNkpRttroPiVJBzIIWyh/I6+gzPt6biiB
	l5d6rwPpRkHj6Y8iRinFJmrnMl2vWQWwMBYdk2ZoN6b/OgeSN8PWy9WQ568QzSk=
X-Gm-Gg: ASbGncuFOrVbHxkwGFxX3poCmb8sEehBVyYvcSENioXCnSD0vfQLxRaxfKxv7u8WePB
	W1CRx1YTruXUjRdAqJZ+gMDfMRQClCyqLixvhzdKgalskaV5k9Wp3YaHWX2dZKprunSZDW6iSz7
	MQhX2SJNPDNZZCXYReBHoMedzfB8/EqfvvOf+ZP0pFlzy9tE0YeVmyzNwFlm7RPIguOccZxqw9w
	0tgG+msKwkKnvdq3gcFUeYSiacTWCrC6nFz7v2zNd8nMbbTxoiFLGLrbbEpGsAwquEFORIG/bVh
	4FJmw2L4qv48ewqAZt+5pJVNR8pADYKNqfaiN450p9r1QJw9WrQrqbE=
X-Google-Smtp-Source: AGHT+IGbTxVltMIpKusffszCMrx2cQCERYqFZQ0ZCSyKXHeb3hnPDeVY0ws2Q4gsdOXA2juRIrXnIA==
X-Received: by 2002:a05:600c:5949:b0:439:8345:17a6 with SMTP id 5b1f17b1804b1-439a30d38e9mr150779135e9.12.1740481158679;
        Tue, 25 Feb 2025 02:59:18 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab2c50dcfsm12588815e9.0.2025.02.25.02.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 02:59:18 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: yoshihiro.shimoda.uh@renesas.com,
	vkoul@kernel.org,
	kishon@kernel.org,
	horms+renesas@verge.net.au,
	fabrizio.castro.jz@renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/5] phy: renesas: rcar-gen3-usb2: Lock around hardware registers and driver data
Date: Tue, 25 Feb 2025 12:59:05 +0200
Message-ID: <20250225105907.845347-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225105907.845347-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250225105907.845347-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The phy-rcar-gen3-usb2 driver exposes four individual PHYs that are
requested and configured by PHY users. The struct phy_ops APIs access the
same set of registers to configure all PHYs. Additionally, PHY settings can
be modified through sysfs or an IRQ handler. While some struct phy_ops APIs
are protected by a driver-wide mutex, others rely on individual
PHY-specific mutexes.

This approach can lead to various issues, including:
1/ the IRQ handler may interrupt PHY settings in progress, racing with
   hardware configuration protected by a mutex lock
2/ due to msleep(20) in rcar_gen3_init_otg(), while a configuration thread
   suspends to wait for the delay, another thread may try to configure
   another PHY (with phy_init() + phy_power_on()); re-running the
   phy_init() goes to the exact same configuration code, re-running the
   same hardware configuration on the same set of registers (and bits)
   which might impact the result of the msleep for the 1st configuring
   thread
3/ sysfs can configure the hardware (though role_store()) and it can
   still race with the phy_init()/phy_power_on() APIs calling into the
   drivers struct phy_ops

To address these issues, add a spinlock to protect hardware register access
and driver private data structures (e.g., calls to
rcar_gen3_is_any_rphy_initialized()). Checking driver-specific data remains
necessary as all PHY instances share common settings. With this change,
the existing mutex protection is removed and the cleanup.h helpers are
used.

While at it, to keep the code simpler, do not skip
regulator_enable()/regulator_disable() APIs in
rcar_gen3_phy_usb2_power_on()/rcar_gen3_phy_usb2_power_off() as the
regulators enable/disable operations are reference counted anyway.

Fixes: f3b5a8d9b50d ("phy: rcar-gen3-usb2: Add R-Car Gen3 USB2 PHY driver")
Cc: stable@vger.kernel.org
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- collected tags

 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 49 +++++++++++++-----------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 826c9c4dd4c0..5c0ceba09b67 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -9,6 +9,7 @@
  * Copyright (C) 2014 Cogent Embedded, Inc.
  */
 
+#include <linux/cleanup.h>
 #include <linux/extcon-provider.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -118,7 +119,7 @@ struct rcar_gen3_chan {
 	struct regulator *vbus;
 	struct reset_control *rstc;
 	struct work_struct work;
-	struct mutex lock;	/* protects rphys[...].powered */
+	spinlock_t lock;	/* protects access to hardware and driver data structure. */
 	enum usb_dr_mode dr_mode;
 	u32 obint_enable_bits;
 	bool extcon_host;
@@ -348,6 +349,8 @@ static ssize_t role_store(struct device *dev, struct device_attribute *attr,
 	bool is_b_device;
 	enum phy_mode cur_mode, new_mode;
 
+	guard(spinlock_irqsave)(&ch->lock);
+
 	if (!ch->is_otg_channel || !rcar_gen3_is_any_otg_rphy_initialized(ch))
 		return -EIO;
 
@@ -415,7 +418,7 @@ static void rcar_gen3_init_otg(struct rcar_gen3_chan *ch)
 		val = readl(usb2_base + USB2_ADPCTRL);
 		writel(val | USB2_ADPCTRL_IDPULLUP, usb2_base + USB2_ADPCTRL);
 	}
-	msleep(20);
+	mdelay(20);
 
 	writel(0xffffffff, usb2_base + USB2_OBINTSTA);
 	writel(ch->obint_enable_bits, usb2_base + USB2_OBINTEN);
@@ -436,12 +439,14 @@ static irqreturn_t rcar_gen3_phy_usb2_irq(int irq, void *_ch)
 	if (pm_runtime_suspended(dev))
 		goto rpm_put;
 
-	status = readl(usb2_base + USB2_OBINTSTA);
-	if (status & ch->obint_enable_bits) {
-		dev_vdbg(dev, "%s: %08x\n", __func__, status);
-		writel(ch->obint_enable_bits, usb2_base + USB2_OBINTSTA);
-		rcar_gen3_device_recognition(ch);
-		ret = IRQ_HANDLED;
+	scoped_guard(spinlock, &ch->lock) {
+		status = readl(usb2_base + USB2_OBINTSTA);
+		if (status & ch->obint_enable_bits) {
+			dev_vdbg(dev, "%s: %08x\n", __func__, status);
+			writel(ch->obint_enable_bits, usb2_base + USB2_OBINTSTA);
+			rcar_gen3_device_recognition(ch);
+			ret = IRQ_HANDLED;
+		}
 	}
 
 rpm_put:
@@ -456,6 +461,8 @@ static int rcar_gen3_phy_usb2_init(struct phy *p)
 	void __iomem *usb2_base = channel->base;
 	u32 val;
 
+	guard(spinlock_irqsave)(&channel->lock);
+
 	/* Initialize USB2 part */
 	val = readl(usb2_base + USB2_INT_ENABLE);
 	val |= USB2_INT_ENABLE_UCOM_INTEN | rphy->int_enable_bits;
@@ -479,6 +486,8 @@ static int rcar_gen3_phy_usb2_exit(struct phy *p)
 	void __iomem *usb2_base = channel->base;
 	u32 val;
 
+	guard(spinlock_irqsave)(&channel->lock);
+
 	rphy->initialized = false;
 
 	val = readl(usb2_base + USB2_INT_ENABLE);
@@ -498,16 +507,17 @@ static int rcar_gen3_phy_usb2_power_on(struct phy *p)
 	u32 val;
 	int ret = 0;
 
-	mutex_lock(&channel->lock);
-	if (!rcar_gen3_are_all_rphys_power_off(channel))
-		goto out;
-
 	if (channel->vbus) {
 		ret = regulator_enable(channel->vbus);
 		if (ret)
-			goto out;
+			return ret;
 	}
 
+	guard(spinlock_irqsave)(&channel->lock);
+
+	if (!rcar_gen3_are_all_rphys_power_off(channel))
+		goto out;
+
 	val = readl(usb2_base + USB2_USBCTR);
 	val |= USB2_USBCTR_PLL_RST;
 	writel(val, usb2_base + USB2_USBCTR);
@@ -517,7 +527,6 @@ static int rcar_gen3_phy_usb2_power_on(struct phy *p)
 out:
 	/* The powered flag should be set for any other phys anyway */
 	rphy->powered = true;
-	mutex_unlock(&channel->lock);
 
 	return 0;
 }
@@ -528,18 +537,12 @@ static int rcar_gen3_phy_usb2_power_off(struct phy *p)
 	struct rcar_gen3_chan *channel = rphy->ch;
 	int ret = 0;
 
-	mutex_lock(&channel->lock);
-	rphy->powered = false;
-
-	if (!rcar_gen3_are_all_rphys_power_off(channel))
-		goto out;
+	scoped_guard(spinlock_irqsave, &channel->lock)
+		rphy->powered = false;
 
 	if (channel->vbus)
 		ret = regulator_disable(channel->vbus);
 
-out:
-	mutex_unlock(&channel->lock);
-
 	return ret;
 }
 
@@ -750,7 +753,7 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 	if (phy_data->no_adp_ctrl)
 		channel->obint_enable_bits = USB2_OBINT_IDCHG_EN;
 
-	mutex_init(&channel->lock);
+	spin_lock_init(&channel->lock);
 	for (i = 0; i < NUM_OF_PHYS; i++) {
 		channel->rphys[i].phy = devm_phy_create(dev, NULL,
 							phy_data->phy_usb2_ops);
-- 
2.43.0


