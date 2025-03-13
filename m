Return-Path: <linux-kernel+bounces-559713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E93AA5F87B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D9228829E0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B828926B097;
	Thu, 13 Mar 2025 14:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4BJHWMMF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+JGC1e/W"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18EA26AAAB
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876285; cv=none; b=ftb9vQheXv5TD+djR+OziccuQyGtZ2Yh0J99S+AcvVitQ5mW3k7lzQb3qZwZOwlLcF8e5LMrLFmwB+j/K9JL8Xjbr4z9F1vHMmqmmiKZik8uX/Ow0rwJOquEpzXfE7wBk383FTDLyIYMgQIrpbTjt8de2fmpG66K0TTxb6/Z/So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876285; c=relaxed/simple;
	bh=+JB9Ocsn0N2uorbOemG2UPiOduyPmgQApN2d3X4aVhc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=AVavji2VgHhgXWjf7Qa5KXBNZKT75karzmEtMVmbad6TtMWyE4nilj0HG84tuNGtMXNxw9qLosyGl97mNh57yvosG+UnyVLZMsoZUkyIJeAbvSiOfsOr1QNdsWvCeRu9ECttXM/dUKI5vS1tkqgI02oZtite0Jv8+eNGcdywioo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4BJHWMMF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+JGC1e/W; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313142524.137040686@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741876282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=A0Y3nQwiTGknc15vMfS4EhndGBYyh9HpDOM/blEDOO8=;
	b=4BJHWMMF1BibSWqsqWwwwIkIeOgtpoIKyLp8vCqCOPkSH3VRooBO9yvW3jT9rMmniQL9kb
	8Prbik/3KXSG/E4QOYOAmOBwk869G/z1yYP0J6bsl5Gsg/EAfGF2LohcHYaUBizQTxzrcP
	Dkk9n7EEIGmQyGBLRPkyalyCre2NwzzRFfivJY+kG8qzyo1+ix/xIgA17CrRE3gAik/U6U
	zRh5y4pgqfP7qWT+6mf30e5//cBN2DQUkXPbRfF4RYOq3/jVysZy6/McWOEQFs7s9pJb/l
	IrDCOBqlCXLi+rVZNoMX8z+8OeYU+mhpJy3KoUwxB3HOG9w+l2izbjn0iSLuCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741876282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=A0Y3nQwiTGknc15vMfS4EhndGBYyh9HpDOM/blEDOO8=;
	b=+JGC1e/WpkbKDC9sqX/LxiseXYyGxcyX7WP/rsYpG/2vhvmsry4CmlTDysCCyCsqa6jJIU
	OX8IqURgqfRusiAw==
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
Subject: [patch 3/7] soc: dove: Convert generic irqchip locking to guard()
References: <20250313142404.896902416@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 15:31:21 +0100 (CET)

Conversion was done with Coccinelle. No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Gregory Clement <gregory.clement@bootlin.com>
---
 drivers/soc/dove/pmu.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/soc/dove/pmu.c
+++ b/drivers/soc/dove/pmu.c
@@ -257,10 +257,9 @@ static void pmu_irq_handler(struct irq_d
 	 * So, let's structure the code so that the window is as small as
 	 * possible.
 	 */
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	done &= readl_relaxed(base + PMC_IRQ_CAUSE);
 	writel_relaxed(done, base + PMC_IRQ_CAUSE);
-	irq_gc_unlock(gc);
 }
 
 static int __init dove_init_pmu_irq(struct pmu_data *pmu, int irq)


