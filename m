Return-Path: <linux-kernel+bounces-437955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6D89E9AEF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B0F81887E2B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53F0132122;
	Mon,  9 Dec 2024 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ykr7Zkxq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mEGMYqFq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4897B12AAE2
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 15:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733759614; cv=none; b=mxL+L34/G5jfDeBe3wvvFdWA487Q60xrPa+FRftjj3qWP4jEvlD1rdgi+hyLau7Cx/IIoNUM2mbb7PcY/8uG/5BM1r4bZiEv04EhnMLIOf5m/OhuwMvu5fAi6ihWScZMWkeL59u4Mk9L9aVGxVoXMqZNYaWi+70+4RaHQyI+S38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733759614; c=relaxed/simple;
	bh=2kEgOq4YANYlbymoL67UkWgy+GutWR7wZUgWNXf9d30=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ejKHqvvO2zvOekseGR4a/S9KGKzmsojR7M/Cf/1zwLuYhWpFec1/XcWiaQi8ehfWZROyEHd2CO50EFxzTd+ivY+FWgL+kahDPcHPdyFUIwpd8r3e4UlCPnlqsuSsVaxaQWlERCkc63Eu1N6jLTQj7PAJ+TldBGYSl7J/WjXX5m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ykr7Zkxq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mEGMYqFq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733759610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oa/eRmj9sytyxrud4O4mAvjeRx/S9NypgThFLDmDcCE=;
	b=Ykr7ZkxqH+rHf85Xrj7aG+Lm+COeUJB7sSvEhIQX7r7g0TwE81qtfgtCxTODRzFZ+NGi7D
	+SK6ikPzhzfRcle7vTYH8T3Rz11u4xVeLGYboZuoDf/GtrUW0YWdKmcbXyZiuuSPB/i/Gs
	0cYTX0XvY3sw9SlgygwKpdp7QkhThC5xVdcppxnbCVOAc6QJ5/o5BckCrtPd1O8PdQ8opn
	mz2pVwzYBL//F6pNBm4DopJCTDMseN2OsoVWmDyqxoa6tFQ28yshIkhV9mPjTD5hv74ERv
	HOoCreIJah+0eKDO6mwPcDMEyXHV9TUvoyB6Zi8LEsLa2WRxH8P6hGM7yFHS1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733759610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oa/eRmj9sytyxrud4O4mAvjeRx/S9NypgThFLDmDcCE=;
	b=mEGMYqFqXVsV1WU4zD3oERVxJV8xPiOpwHIShLDSIpc44nxTYpe8IO6Y5H/V3ZQV8ipTLT
	/X781OAzFoM2DGCw==
To: Anup Patel <apatel@ventanamicro.com>
Cc: Marc Zyngier <maz@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement
 <gregory.clement@bootlin.com>, Sebastian Hesselbarth
 <sebastian.hesselbarth@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Atish Patra
 <atishp@atishpatra.org>, Andrew Jones <ajones@ventanamicro.com>, Sunil V L
 <sunilvl@ventanamicro.com>, Anup Patel <anup@brainfault.org>,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 1/4] irqchip/riscv-imsic: Handle non-atomic MSI updates
 for device
In-Reply-To: <CAK9=C2VqU2mdLL-R20bdgvDHi0WcuNyUSqRo7Pztsu-8X1wVvw@mail.gmail.com>
References: <20241208150711.297624-1-apatel@ventanamicro.com>
 <20241208150711.297624-2-apatel@ventanamicro.com> <875xnuq6dc.ffs@tglx>
 <CAK9=C2VqU2mdLL-R20bdgvDHi0WcuNyUSqRo7Pztsu-8X1wVvw@mail.gmail.com>
Date: Mon, 09 Dec 2024 16:53:29 +0100
Message-ID: <87r06gq2di.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Anup!

On Mon, Dec 09 2024 at 17:38, Anup Patel wrote:
> On Mon, Dec 9, 2024 at 1:44=E2=80=AFAM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>> There is no guarantee that set_affinity() runs on the original target
>> CPU (CPU 1). Your scheme only works, when CPU1 vector 0x20 is not used
>> by some other device. If it's used, you lost as CPU1 will consume the
>> vector and your pending check is not seeing anything.
>>
>> x86 ensures CPU locality by deferring the affinity move to the next
>> device interrupt on the original target CPU (CPU1 in the above
>> example). See CONFIG_GENERIC_IRQ_PENDING.
>
> I agree with you.
>
> The IMSIC driver must do the affinity move upon the next device
> interrupt on the old CPU. I will update this patch in the next revision.
>
> BTW, I did not find CONFIG_GENERIC_IRQ_PENDING. Is the
> name correct ?

CONFIG_GENERIC_PENDING_IRQ is close enough :)

>> The interrupt domains which are not affected (remap) set the
>> IRQ_MOVE_PCNTXT flag to avoid that dance and don't use that affinity
>> setter code path at all.
>
> Yes, setting the IRQ_MOVE_PCNTXT flag in the remap domain
> makes perfect sense.
>
> I suggest adding IRQ_MOVE_PCNTXT usage as part of Drew's
> irqbypass series which adds a remap domain in the IOMMU
> driver. Unless you insist on having it as part of this series ?

You need to look at the other RISC-V controllers. Those which do not
need this should set it. That's historically backwards.

I think we can reverse the logic here. As this needs backporting, I
can't make a full cleanup of this, but for your problem the patch below
should just work.

Select GENERIC_PENDING_IRQ and GENERIC_PENDING_IRQ_CHIPFLAGS and set the
IRQCHIP_MOVE_DEFERRED flag on your interrrupt chip and the core logic
takes care of the PCNTXT bits.

I'll convert x86 in a seperate step and remove the PCNTXT leftovers and
the new config knob once the dust has settled.

Thanks,

        tglx
---
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -567,6 +567,7 @@ struct irq_chip {
  *                                    in the suspend path if they are in d=
isabled state
  * IRQCHIP_AFFINITY_PRE_STARTUP:      Default affinity update before start=
up
  * IRQCHIP_IMMUTABLE:		      Don't ever change anything in this chip
+ * IRQCHIP_MOVE_DEFERRED:	      Move the interrupt in actual interrupt con=
text
  */
 enum {
 	IRQCHIP_SET_TYPE_MASKED			=3D (1 <<  0),
@@ -581,6 +582,7 @@ enum {
 	IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND	=3D (1 <<  9),
 	IRQCHIP_AFFINITY_PRE_STARTUP		=3D (1 << 10),
 	IRQCHIP_IMMUTABLE			=3D (1 << 11),
+	IRQCHIP_MOVE_DEFERRED			=3D (1 << 12),
 };
=20
 #include <linux/irqdesc.h>
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -31,6 +31,10 @@ config GENERIC_IRQ_EFFECTIVE_AFF_MASK
 config GENERIC_PENDING_IRQ
 	bool
=20
+# Deduce delayed migration from top-level interrupt chip flags
+config GENERIC_PENDING_IRQ_CHIPFLAGS
+	bool
+
 # Support for generic irq migrating off cpu before the cpu is offline.
 config GENERIC_IRQ_MIGRATION
 	bool
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -47,6 +47,13 @@ int irq_set_chip(unsigned int irq, const
 		return -EINVAL;
=20
 	desc->irq_data.chip =3D (struct irq_chip *)(chip ?: &no_irq_chip);
+
+	if (IS_ENABLED(CONFIG_GENERIC_PENDING_IRQ_CHIPFLAGS) && chip) {
+		if (chip->flags & IRQCHIP_MOVE_DEFERRED)
+			irqd_clear(&desc->irq_data, IRQD_MOVE_PCNTXT);
+		else
+			irqd_set(&desc->irq_data, IRQD_MOVE_PCNTXT);
+	}
 	irq_put_desc_unlock(desc, flags);
 	/*
 	 * For !CONFIG_SPARSE_IRQ make the irq show up in
@@ -1114,16 +1121,21 @@ void irq_modify_status(unsigned int irq,
 	trigger =3D irqd_get_trigger_type(&desc->irq_data);
=20
 	irqd_clear(&desc->irq_data, IRQD_NO_BALANCING | IRQD_PER_CPU |
-		   IRQD_TRIGGER_MASK | IRQD_LEVEL | IRQD_MOVE_PCNTXT);
+		   IRQD_TRIGGER_MASK | IRQD_LEVEL);
 	if (irq_settings_has_no_balance_set(desc))
 		irqd_set(&desc->irq_data, IRQD_NO_BALANCING);
 	if (irq_settings_is_per_cpu(desc))
 		irqd_set(&desc->irq_data, IRQD_PER_CPU);
-	if (irq_settings_can_move_pcntxt(desc))
-		irqd_set(&desc->irq_data, IRQD_MOVE_PCNTXT);
 	if (irq_settings_is_level(desc))
 		irqd_set(&desc->irq_data, IRQD_LEVEL);
=20
+	/* Keep this around until x86 is converted over */
+	if (!IS_ENABLED(CONFIG_GENERIC_PENDING_IRQ_CHIPFLAGS)) {
+		irqd_clear(&desc->irq_data, IRQD_MOVE_PCNTXT);
+		if (irq_settings_can_move_pcntxt(desc))
+			irqd_set(&desc->irq_data, IRQD_MOVE_PCNTXT);
+	}
+
 	tmp =3D irq_settings_get_trigger_mask(desc);
 	if (tmp !=3D IRQ_TYPE_NONE)
 		trigger =3D tmp;




