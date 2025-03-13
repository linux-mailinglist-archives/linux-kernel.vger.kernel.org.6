Return-Path: <linux-kernel+bounces-559714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E59B9A5F880
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C069882D53
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C016626B2A3;
	Thu, 13 Mar 2025 14:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zRHDiLUY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+/GR2xJn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C199926B09A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876287; cv=none; b=JyFg1touD/SydRGA4Vaagg/rx/jZ4D+gSYOldxuD0bQxJviwJpJpfFJl9zyECqiwMqZh5mVoxD/sZTP8uaG39h4qahkVIJqbAn/XjXoG+Kdjz5shm6FeYYapEvHMgzvxMOyZN2vZqBTGK+kc6TERTKpH6nKtV7aZabKotnue79M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876287; c=relaxed/simple;
	bh=WzPlEzkz/4dQUiaViKPTEHdTWix1qz0LninNbgUeLCo=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=OOMXzzG3pXRKkGXr+g2spEjSABqw3iCguMxkp0Nism4IdhyK3rDnh7IsqdTf59aO/CpAYig5ZHgzFFDe977d3IMYaYAmF8asMY1XODD5zqkTJ/mniZYDC2qz/QPGu5dw80XH6JcL7bFCUgb+Oih9w74hYkaksvJ9bNTpwFQ1Z7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zRHDiLUY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+/GR2xJn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313142524.200515896@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741876284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=BRHGQxdmButnD0h4dgcR8icVvakqQ54h6/za0dNjYUA=;
	b=zRHDiLUYoBHQXxxJZE/2IiT1bLCMS+q07ZuZkCbzUKrUvLldZbPUjDVj3JHakG0LNWAlwC
	SdZgZkoC8QjRnMboem96wPQLAkWxYYbhF7OupzcsineIheYVGrE8foXnNldt4u2gcnxkP4
	6y8mUlOAv4dUJ4Ini3y3c9YSBenyFj58vzQPeRO+kFkDlFwM46ZtJ9sE9e+dQqXbqzQ4oD
	BLp8tZjprFGQu8XvZ08LY3fjWGAQXr/XWz3Vm2w2Qjr08Z7obgiuo7QKcTGloWiqi6JqjN
	409aMhQTg0nUnpz10vavLuKEYntZ5Z0JfSwwII3zFC+epm2QHxsMSGMlMFFnbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741876284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=BRHGQxdmButnD0h4dgcR8icVvakqQ54h6/za0dNjYUA=;
	b=+/GR2xJnrmclNdX+D20Qx/CkKzQDjKWLYK9EWpHpVkcWOXjCYoMWF7z4w8rRtbRJSwRwRd
	9loOJYxVi9uV48DQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>,
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
Subject: [patch 4/7] ARM: orion/gpio:: Convert generic irqchip locking to
 guard()
References: <20250313142404.896902416@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 15:31:23 +0100 (CET)

Conversion was done with Coccinelle. No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Gregory Clement <gregory.clement@bootlin.com>
---
 arch/arm/plat-orion/gpio.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/arch/arm/plat-orion/gpio.c
+++ b/arch/arm/plat-orion/gpio.c
@@ -496,11 +496,10 @@ static void orion_gpio_unmask_irq(struct
 	u32 reg_val;
 	u32 mask = d->mask;
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	reg_val = irq_reg_readl(gc, ct->regs.mask);
 	reg_val |= mask;
 	irq_reg_writel(gc, reg_val, ct->regs.mask);
-	irq_gc_unlock(gc);
 }
 
 static void orion_gpio_mask_irq(struct irq_data *d)
@@ -510,11 +509,10 @@ static void orion_gpio_mask_irq(struct i
 	u32 mask = d->mask;
 	u32 reg_val;
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	reg_val = irq_reg_readl(gc, ct->regs.mask);
 	reg_val &= ~mask;
 	irq_reg_writel(gc, reg_val, ct->regs.mask);
-	irq_gc_unlock(gc);
 }
 
 void __init orion_gpio_init(int gpio_base, int ngpio,


