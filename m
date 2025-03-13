Return-Path: <linux-kernel+bounces-559711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 304DBA5F871
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4516C1883D84
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415A026AA96;
	Thu, 13 Mar 2025 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1y4psH+T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ALni7YM0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AA0268FDB
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876281; cv=none; b=sNsJhc0nOXZuY7Wsog2yq8zQb8Hpj3UdPq0URf5UxDc3H0axVp2pk/8EZLFPoZsEL1A81jSxw7Kx3Wnr6jYj6zEhKvn1vbR4pnRHT6c8D197xNPuRmppIQ5e2ns6mB2yNc/pLfaFLIG/4jhqxqddWzk3pIQQj998b8L9FhqfmQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876281; c=relaxed/simple;
	bh=fmZM/Tqk1HIzM9b/e4bge9cj6Urf+WrwD6iNfE9s9ZA=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=IT3Moy/jt7yppkBYyDKBlGVDoGZHYBCiYHd7TVSPdQZ8lZ7ml6v4SwWOiyM4wq2Q0Xq+4e5aCkisUJrmSMbQ9emzh/MsDDi8GekBBj9JpkVPfa9An/iOoU5oH/4iSGqldcf7Xajrx4hkX9NkEWvQPKjNoYC65pLpOxasIueCPDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1y4psH+T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ALni7YM0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313142524.011345765@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741876276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=ln5jjtCvUVe3PK03Um5y8ZdmP9RcNRi7U0gcE3nH0yU=;
	b=1y4psH+TdMaT6dXpNkdOVnR0j9WPCM5XPjRcyWaQ6ePpotYmKKs3Jwp0yOIfhUgW7EJkTu
	Y8Pje/KNR4tSOL9nnHncNyWLXJQfVTy6IltxE9QUTF54J3DQmfGKINoN4A9Dt08wHGhit0
	g8L9OB6xejdq0ZVWJNw/RHGF8Cloa68iCt9D2qT3KWczIvDO+pUSXnrkV0x+Zv2L6WM5ex
	X1oAP6BHs3NLD2rUnyrlN36R2rPo1vyvfWKyupCPPudErTnYhYRcbK/YwtoEQ1yNMnAwxa
	IbCstOW7Kik15Gn+v+UR1MTXrmOWcW2KEW8B42Ko2hRRzu/KqD7uoSSFIZqphg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741876276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=ln5jjtCvUVe3PK03Um5y8ZdmP9RcNRi7U0gcE3nH0yU=;
	b=ALni7YM0mzBSHlDPF4fVPeR7fy6Mc6J7uS+9HkBM5h1oTsj+1fCvUkcT8cEuFWHyDmguNx
	NxvNry07RwzewzCA==
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
Subject: [patch 1/7] genirq/generic-chip: Make locking unconditional
References: <20250313142404.896902416@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 15:31:15 +0100 (CET)

The SMP conditional wrappers around raw_spin_[un]lock() have no real
value. On !SMP kernels the lock operations are NOOPs except for a
preempt_disable/enable() pair on PREEMPT enabled kernels, which are not
really worth to optimize for. Aside of that this evades lockdep on !SMP
kernels.

Remove the !SMP stubs and make it unconditional.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irq.h |    5 -----
 1 file changed, 5 deletions(-)

--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -1219,7 +1219,6 @@ static inline struct irq_chip_type *irq_
 
 #define IRQ_MSK(n) (u32)((n) < 32 ? ((1 << (n)) - 1) : UINT_MAX)
 
-#ifdef CONFIG_SMP
 static inline void irq_gc_lock(struct irq_chip_generic *gc)
 {
 	raw_spin_lock(&gc->lock);
@@ -1229,10 +1228,6 @@ static inline void irq_gc_unlock(struct
 {
 	raw_spin_unlock(&gc->lock);
 }
-#else
-static inline void irq_gc_lock(struct irq_chip_generic *gc) { }
-static inline void irq_gc_unlock(struct irq_chip_generic *gc) { }
-#endif
 
 /*
  * The irqsave variants are for usage in non interrupt code. Do not use


