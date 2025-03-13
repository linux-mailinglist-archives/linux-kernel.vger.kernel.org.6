Return-Path: <linux-kernel+bounces-559710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DD7A5F86A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F51E1773CC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CAF268FCF;
	Thu, 13 Mar 2025 14:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1VTbWIpA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ac+215+9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6862673A4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876279; cv=none; b=rKB3WxLPSVWNumwJc38O8Gfulth+jjTnuEmkzMAJWsv5wDgilV40PQ7Dz5kH1sWVCTbsPg7rIhXRqgqsQeufeP1OY3dKxmMYg6/oGw6Je9GEk+CugMDY5AXNElB6PFfWYrdIF4LdXE7uUyfsSH79TJRY8LHi4Gjee2TguZCv6NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876279; c=relaxed/simple;
	bh=/fLFxTB9ecUfpGVHxQKM8igbD0q4i9ltUHKLTA5+JtE=;
	h=Message-ID:From:To:Cc:Subject:Date; b=Mb0TlPmFkJwC98ELA9PaGuXo2CSvHVi5PWXL8wtPIqEl8mjop9Cbw1LZHw5cX1Kwr54c9y7bgeF2+WB5PhwBCgeaner39LBR0hoceBKj5LU97WauXutas/xZkV6lqAVzNbItw7id51gV0foVVTHDNQxdFLAsQUKDjR+nzVYjkb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1VTbWIpA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ac+215+9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313142404.896902416@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741876274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=Yzx5UpHw8V/PL6J/OMWpobt6OE0fTBIGAVQq59P+n4w=;
	b=1VTbWIpAz37X8Wuh3qAnqMVC8op0a8EVcgnp8Vf4AGCPRbUaa3GGudo0/Y0zgMJDHzpGmn
	jCQV7pdF6cX3YiYkqE+EW0fK/+zhDpjTMEQ277ozwvb1vxymNIwj2TWNMYgAUhOpADO35u
	j2UAuP+lzLjAnXM0xYlu7BxHdUfdF6XBDXbqsejnwIEQ8VJ7itn1Y5ceeTatykSbFaCS04
	7YlhrJR01qL/xhd0JfNAWRZqdSO/WdJXoGqWoZ+1dW3gY+lwO29imwS8x9SxUrUEacF81t
	QdLZnkrm9Om7Q2WXgVa033Xu9ripLI8QLH+bvlJKOCFfG5NF+GEuxCkzqrXkFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741876274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=Yzx5UpHw8V/PL6J/OMWpobt6OE0fTBIGAVQq59P+n4w=;
	b=Ac+215+9uSUVrVSKoJKgJgzoHhrlS1dafaKyrlEybOn32svlQ4GzN1zrcUuYaWW3WmXr4B
	PE1eDhVRFaVFlUCQ==
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
Subject: [patch 0/7] genirq/generic_chip: Convert locking to guards
Date: Thu, 13 Mar 2025 15:31:13 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following series converts the generic chip locking to lock guards,
which reduces code size and improves readability.

The conversion was largely done with Coccinelle.

The series applies on Linus tree and is available from git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git irq/generic-chip

Thanks,

	tglx
---
 arch/arm/plat-orion/gpio.c             |    6 +---
 drivers/gpio/gpio-mvebu.c              |   15 +++-------
 drivers/irqchip/irq-al-fic.c           |   18 +++---------
 drivers/irqchip/irq-atmel-aic.c        |   19 ++++---------
 drivers/irqchip/irq-atmel-aic5.c       |   28 +++++--------------
 drivers/irqchip/irq-bcm7120-l2.c       |   22 ++++++---------
 drivers/irqchip/irq-brcmstb-l2.c       |    8 +----
 drivers/irqchip/irq-csky-apb-intc.c    |    3 --
 drivers/irqchip/irq-dw-apb-ictl.c      |    3 --
 drivers/irqchip/irq-ingenic-tcu.c      |    9 ++----
 drivers/irqchip/irq-lan966x-oic.c      |   18 ++++--------
 drivers/irqchip/irq-loongson-liointc.c |    9 +-----
 drivers/irqchip/irq-mscc-ocelot.c      |    3 --
 drivers/irqchip/irq-stm32-exti.c       |   21 ++++----------
 drivers/irqchip/irq-sunxi-nmi.c        |    9 +-----
 drivers/irqchip/irq-tb10x.c            |   13 ++-------
 drivers/soc/dove/pmu.c                 |    3 --
 include/linux/irq.h                    |   25 -----------------
 kernel/irq/generic-chip.c              |   47 +++++++++++----------------------
 19 files changed, 80 insertions(+), 199 deletions(-)

