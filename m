Return-Path: <linux-kernel+bounces-561911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBFAA61873
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 334BD7A3EA2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EC61A83F2;
	Fri, 14 Mar 2025 17:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HwHuEeno"
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EF92629F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741974443; cv=none; b=B5I/9eCmBoetRnzhR1/axEjySuU44A/N9GB5q8ZN40phFIhK6HP5Cnx0YkxSXbZbr/duEeO1CBwIMJYjLQ6XcFYVHBrtUWJa+esMR22cM3aZO84drlXtbNsPH7UqQ5qCI2b05Tj9O2bcBpE2vRASrhF5SfYcyMLk9rHCst4eg60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741974443; c=relaxed/simple;
	bh=wt1lH51hTnTeeT5fjQGT+ik3ISJ6o9LFL6rizue55As=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a+jUz/E0htQtkepb7w/VT/Kr6pRLLmHe2OqnQRkkzZcMxukM5d9LoVNs9hCHVla5y6joI0xYP8ZVaKh5Is+OhfIbKlDcTgtOSwbVTv5k2jiQpz2Zv5JcgWy902lzS55dgWTPMyS5h4WOmdEmMpUjVm3bucdNxHSW0ocyzlDuPdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HwHuEeno; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 5C983585AC9
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:20:32 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C3D3B441AC;
	Fri, 14 Mar 2025 17:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741972825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dz92ensrpxVSM7fMt32cCZh0aTsUrjUlVQb3SuJK0yE=;
	b=HwHuEenoCD61eyekb80GlroGhyN/wbbTc4gh9v40p/qBZn/b0zhas+dCwxqKXbSi6s1Awq
	UZo9SIa2dSFpG9iQmZfkiI50MqdV9kAe1yYOsbvZgPfcvWpudHS1GcZsusKOCq/+b8Zgid
	hzpLtDWcocFrK272qxwgitqOsItoD8A6UAqnb0gbIQxJdH/xEXAwaczp7o//NafETm3tnW
	q+xZogSH57JrNCJtgNStsOiSuIDefCcUn70bMWytHOPqi3mU92sB1baYR+Z0eyvudU/9va
	bXC2HT5mb3nN3cqppP4iY1UA+3xLlpwcxPifs3bIFj9aigFgmBgZyDJKv27Oyg==
Date: Fri, 14 Mar 2025 18:20:21 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
 Talel Shenhar <talel@amazon.com>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Guo Ren
 <guoren@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Chen-Yu Tsai
 <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth
 <sebastian.hesselbarth@gmail.com>, Gregory Clement
 <gregory.clement@bootlin.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <ukleinek@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>
Subject: Re: [patch 6/7] irqchip: Convert generic irqchip locking to guards
Message-ID: <20250314182021.3f6024c5@bootlin.com>
In-Reply-To: <20250313142524.325627746@linutronix.de>
References: <20250313142404.896902416@linutronix.de>
	<20250313142524.325627746@linutronix.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedugeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtkeertdertdejnecuhfhrohhmpefjvghrvhgvucevohguihhnrgcuoehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepveeiffefgeeitdelleeigefhjeelueeuveekveetgeffheeltdekgeduiefggfdvnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhephhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvvddprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjihhrihhslhgrsgihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtrghlvghlsegrmhgriihonhdrtghomhdprhgtphhtthhopehnihgtohhlrghsrdhfvghrrhgvsehmihgtrhhotghhihhprdgtohhmpdhrt
 ghpthhtoheprghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegtlhgruhguihhurdgsvgiinhgvrgesthhugihonhdruggvvhdprhgtphhtthhopehflhhorhhirghnrdhfrghinhgvlhhlihessghrohgruggtohhmrdgtohhm
X-GND-Sasl: herve.codina@bootlin.com

Hi Thomas,

On Thu, 13 Mar 2025 15:31:27 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:

> Conversion was done with Coccinelle and a few manual fixups.
> 
> In a few interrupt chip callbacks this changes replaces
> raw_spin_lock_irqsave() with a guard(raw_spinlock). That's intended and
> correct because those interrupt chip callbacks are invoked with the
> interrupt descriptor lock held and interrupts disabled. No point in using
> the irqsave variant.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Talel Shenhar <talel@amazon.com>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Cc: Florian Fainelli <florian.fainelli@broadcom.com>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: Herve Codina <herve.codina@bootlin.com>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Samuel Holland <samuel@sholland.org>
> ---
>  drivers/irqchip/irq-al-fic.c           |   18 +++++-------------
>  drivers/irqchip/irq-atmel-aic.c        |   19 ++++++-------------
>  drivers/irqchip/irq-atmel-aic5.c       |   28 ++++++++--------------------
>  drivers/irqchip/irq-bcm7120-l2.c       |   22 +++++++++-------------
>  drivers/irqchip/irq-brcmstb-l2.c       |    8 ++------
>  drivers/irqchip/irq-csky-apb-intc.c    |    3 +--
>  drivers/irqchip/irq-dw-apb-ictl.c      |    3 +--
>  drivers/irqchip/irq-ingenic-tcu.c      |    9 +++------
>  drivers/irqchip/irq-lan966x-oic.c      |   18 +++++++-----------
>  drivers/irqchip/irq-loongson-liointc.c |    9 ++-------
>  drivers/irqchip/irq-mscc-ocelot.c      |    3 +--
>  drivers/irqchip/irq-stm32-exti.c       |   21 ++++++---------------
>  drivers/irqchip/irq-sunxi-nmi.c        |    9 ++-------
>  drivers/irqchip/irq-tb10x.c            |   13 +++----------
>  14 files changed, 56 insertions(+), 127 deletions(-)
> 

...

> --- a/drivers/irqchip/irq-lan966x-oic.c
> +++ b/drivers/irqchip/irq-lan966x-oic.c
> @@ -71,14 +71,12 @@ static unsigned int lan966x_oic_irq_star
>  	struct lan966x_oic_chip_regs *chip_regs = gc->private;
>  	u32 map;
>  
> -	irq_gc_lock(gc);
> -
> -	/* Map the source interrupt to the destination */
> -	map = irq_reg_readl(gc, chip_regs->reg_off_map);
> -	map |= data->mask;
> -	irq_reg_writel(gc, map, chip_regs->reg_off_map);
> -
> -	irq_gc_unlock(gc);
> +	scoped_guard (raw_spinlock, &gc->lock) {
> +		/* Map the source interrupt to the destination */
> +		map = irq_reg_readl(gc, chip_regs->reg_off_map);
> +		map |= data->mask;
> +		irq_reg_writel(gc, map, chip_regs->reg_off_map);
> +	}
>  
>  	ct->chip.irq_ack(data);
>  	ct->chip.irq_unmask(data);
> @@ -95,14 +93,12 @@ static void lan966x_oic_irq_shutdown(str
>  
>  	ct->chip.irq_mask(data);
>  
> -	irq_gc_lock(gc);
> +	guard(raw_spinlock)(&gc->lock);
>  
>  	/* Unmap the interrupt */
>  	map = irq_reg_readl(gc, chip_regs->reg_off_map);
>  	map &= ~data->mask;
>  	irq_reg_writel(gc, map, chip_regs->reg_off_map);
> -
> -	irq_gc_unlock(gc);
>  }

Here, I would really prefer a scoped_guard() to clearly identify what is
protected such as:

	scoped_guard (raw_spinlock, &gc->lock) {
		/* Unmap the interrupt */
		map = irq_reg_readl(gc, chip_regs->reg_off_map);
		map &= ~data->mask;
 		irq_reg_writel(gc, map, chip_regs->reg_off_map);
	}

IMHO, guard() is nice when it protects an entire function but it can be
missed when it is present in a middle of code (looks too much like a
simple C function call).

Best regards,
Hervé

