Return-Path: <linux-kernel+bounces-559715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34858A5F872
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 970DD421373
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DFD26B2C3;
	Thu, 13 Mar 2025 14:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QBZeRW88";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3nLa01jS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F742690D7
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876289; cv=none; b=Eg2MOUke0leaGt7vqsQGT/zqaz6DhS9x4/cIzWNl37Rp5+sAFnh6nt58XPKE4fSuaxeQgQIbMiAxtSzsWqeicif3RkVf1lLYRDPSINvFwh+hHSaoOvpCmAmyJbj0FlX45d2rVhzW6j1APhKzVTOMJ5ytYuuxH4PB/zdkG46UAYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876289; c=relaxed/simple;
	bh=R/tbVQX4irVKizht3N6CAf60t+XpVFHCf8549iWeQ2c=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=AzQvlxe6vcC+vVkqwLXDdba5Glg19NSLILkO/Veb86RMnwkKpQvDUaGB0F+v0v/+BmKgAIRZc4cIzSPa1gSuyJhmI76pyOsTwBP/2ZicGxje1/PwfN1nX0Xu8ZGBdNfPFbUsAFeaoBree6Fmsqg68PDRgvXFnJWl7Ibhvf6SzcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QBZeRW88; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3nLa01jS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313142524.262678485@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741876286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=2M7Q8pgd1DfVFDda6qhY86N7xmWT5erMVHn5T+YvIAA=;
	b=QBZeRW88RUJNNZ1vDnn0AXalgTOfQpECA35V7KXyZ+fPasH6FFZOUPMf9N2Gs9BJnPMJah
	ksmk7Foet2NeSPIgeHbZEnjN1EfhDWhEAYePRqEfe1b92BNLtHBTEYRRnizNFjhBzd/s6k
	seUCg6JlOAPU3OQ02sZAxGdBVwNwRGNVcgwNtqOd3t1nyiT9qj3si+m21GDFSdzi+Azdfh
	8ayKvlplKf+2idyzO9UtN6oYEHo5DmHREVKmWF9RiNyS9NuXSrcFG8lJm4cBOXP7na1gVP
	dYlQpIJ3lOtqtah8v5nRyVRAN86fF7d8krxbmvMtmdl2BI7L2w4SGTIMOpxONA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741876286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=2M7Q8pgd1DfVFDda6qhY86N7xmWT5erMVHn5T+YvIAA=;
	b=3nLa01jSlUdlKK1L/ejOZJ7Cu4JE2q0ujmnyskgNILBCbC9HKh9ytBGSfUCyZBLT8991OC
	fMCmlYrU3DQd/2Dw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>,
 Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Talel Shenhar <talel@amazon.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Guo Ren <guoren@kernel.org>,
 Herve Codina <herve.codina@bootlin.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>
Subject: [patch 5/7] gpio: mvebu: Convert generic irqchip locking to guard()
References: <20250313142404.896902416@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 15:31:25 +0100 (CET)

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "Uwe Kleine-König" <ukleinek@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/gpio/gpio-mvebu.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -407,9 +407,8 @@ static void mvebu_gpio_irq_ack(struct ir
 	struct mvebu_gpio_chip *mvchip = gc->private;
 	u32 mask = d->mask;
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	mvebu_gpio_write_edge_cause(mvchip, ~mask);
-	irq_gc_unlock(gc);
 }
 
 static void mvebu_gpio_edge_irq_mask(struct irq_data *d)
@@ -419,10 +418,9 @@ static void mvebu_gpio_edge_irq_mask(str
 	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	u32 mask = d->mask;
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	ct->mask_cache_priv &= ~mask;
 	mvebu_gpio_write_edge_mask(mvchip, ct->mask_cache_priv);
-	irq_gc_unlock(gc);
 }
 
 static void mvebu_gpio_edge_irq_unmask(struct irq_data *d)
@@ -432,11 +430,10 @@ static void mvebu_gpio_edge_irq_unmask(s
 	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	u32 mask = d->mask;
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	mvebu_gpio_write_edge_cause(mvchip, ~mask);
 	ct->mask_cache_priv |= mask;
 	mvebu_gpio_write_edge_mask(mvchip, ct->mask_cache_priv);
-	irq_gc_unlock(gc);
 }
 
 static void mvebu_gpio_level_irq_mask(struct irq_data *d)
@@ -446,10 +443,9 @@ static void mvebu_gpio_level_irq_mask(st
 	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	u32 mask = d->mask;
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	ct->mask_cache_priv &= ~mask;
 	mvebu_gpio_write_level_mask(mvchip, ct->mask_cache_priv);
-	irq_gc_unlock(gc);
 }
 
 static void mvebu_gpio_level_irq_unmask(struct irq_data *d)
@@ -459,10 +455,9 @@ static void mvebu_gpio_level_irq_unmask(
 	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	u32 mask = d->mask;
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	ct->mask_cache_priv |= mask;
 	mvebu_gpio_write_level_mask(mvchip, ct->mask_cache_priv);
-	irq_gc_unlock(gc);
 }
 
 /*****************************************************************************


