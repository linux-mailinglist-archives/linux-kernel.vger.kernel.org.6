Return-Path: <linux-kernel+bounces-443855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6124E9EFCC5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9E5E1882CF9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46753190497;
	Thu, 12 Dec 2024 19:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EwQQl462";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nRSIBmKO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE60B18A6A3
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 19:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734033078; cv=none; b=uvohWemtg002WXgjrXXIeACE5gtVd8/CwFotC/LqWfBKZZhSQhpGnhs4QqnRbVDZ0kU+P5HL33kw/wizhoPHbbhawPNhZgLBrJFHydhuGNgiAI4m697pLm5UC8VdOPNr57PQsDzDlLYyVmgAMgMhg8kGA1Aw9XdXth9gnW1/Tig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734033078; c=relaxed/simple;
	bh=y3nPpKp7C7XA7ppIrEMXsO7MnVivpaTLya/lvnxc0DU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JfqV3MSIONX0EThgrIWYC7jxtvBawcqSaoNQ+5yAw+b5LR5pG3DlKQAHUdhFGVpQcO+EspyVwPwFY2y6gI9hQqg/8bYqfImbinKBQvioX3lWy06kqpOnPp5+SU7fPut7uD3gZB3ib9tJ0rl6mA2mXmCBgd3u6Hnh2uCmWNByB/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EwQQl462; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nRSIBmKO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734033074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yKDQJpTRFu3+KgGxhqTH4mLREYb5/OF2yZ5YcR8q86M=;
	b=EwQQl462TwmW12Fa0HrvaDXIO4Vr6mVq7kh76oTpOl6+58IJ2zr9OSR6en9SVBe7n48iqz
	zhtQ2e/Z8f/736P10Y0VQufETsZRK3MpkdN0vf58KJXqtjmebUGdjFir0gy9igmKALcH8l
	G8xx5ZEcbADAeOjONhxC7oy4L5Xumm0GAWn4Ev6JIhEBhjHGpdqKta0ZjO6mUI2SvlwNmb
	bFDgQtONNCdzTWIP4y4oPLsRmipJFFHUPevPVekcN3MdkrcAe2CzuhfE4iMqgoAd2SMykQ
	o1oqKzkpNzggwVFUlJu0k6JYhFhHXcOdZj2BJNYPXfZ6IM9ZBpAnU7t6ojjzQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734033074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yKDQJpTRFu3+KgGxhqTH4mLREYb5/OF2yZ5YcR8q86M=;
	b=nRSIBmKOJsIWm1vKA+byWzwCOqL7uTD6Gwqh/fIzqbH0RwijulwepNUt7Ucc75lS3yjWOc
	GawF7JcNeJdOrwAA==
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
In-Reply-To: <CAK9=C2XEhtB00y6WTMaO0X=7K820T_BSCLA5bw6hJbfvQAD+Pw@mail.gmail.com>
References: <20241208150711.297624-1-apatel@ventanamicro.com>
 <20241208150711.297624-2-apatel@ventanamicro.com> <875xnuq6dc.ffs@tglx>
 <CAK9=C2VqU2mdLL-R20bdgvDHi0WcuNyUSqRo7Pztsu-8X1wVvw@mail.gmail.com>
 <87r06gq2di.ffs@tglx>
 <CAK9=C2XEhtB00y6WTMaO0X=7K820T_BSCLA5bw6hJbfvQAD+Pw@mail.gmail.com>
Date: Thu, 12 Dec 2024 20:51:13 +0100
Message-ID: <877c84ade6.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Dec 12 2024 at 22:11, Anup Patel wrote:
>> --- a/kernel/irq/chip.c
>> +++ b/kernel/irq/chip.c
>> @@ -47,6 +47,13 @@ int irq_set_chip(unsigned int irq, const
>>                 return -EINVAL;
>>
>>         desc->irq_data.chip = (struct irq_chip *)(chip ?: &no_irq_chip);
>> +
>> +       if (IS_ENABLED(CONFIG_GENERIC_PENDING_IRQ_CHIPFLAGS) && chip) {
>> +               if (chip->flags & IRQCHIP_MOVE_DEFERRED)
>> +                       irqd_clear(&desc->irq_data, IRQD_MOVE_PCNTXT);
>> +               else
>> +                       irqd_set(&desc->irq_data, IRQD_MOVE_PCNTXT);
>> +       }
>
> We need similar changes in irq_domain_set_hwirq_and_chip()
> because we use IRQ_DOMAIN_HIERARCHY in RISC-V.

Grr, you are right. Let me add that to the base patch.

>>         irq_put_desc_unlock(desc, flags);
>>         /*
>>          * For !CONFIG_SPARSE_IRQ make the irq show up in
>> @@ -1114,16 +1121,21 @@ void irq_modify_status(unsigned int irq,
>>         trigger = irqd_get_trigger_type(&desc->irq_data);
>>
>>         irqd_clear(&desc->irq_data, IRQD_NO_BALANCING | IRQD_PER_CPU |
>> -                  IRQD_TRIGGER_MASK | IRQD_LEVEL | IRQD_MOVE_PCNTXT);
>> +                  IRQD_TRIGGER_MASK | IRQD_LEVEL);
>>         if (irq_settings_has_no_balance_set(desc))
>>                 irqd_set(&desc->irq_data, IRQD_NO_BALANCING);
>>         if (irq_settings_is_per_cpu(desc))
>>                 irqd_set(&desc->irq_data, IRQD_PER_CPU);
>> -       if (irq_settings_can_move_pcntxt(desc))
>> -               irqd_set(&desc->irq_data, IRQD_MOVE_PCNTXT);
>>         if (irq_settings_is_level(desc))
>>                 irqd_set(&desc->irq_data, IRQD_LEVEL);
>>
>> +       /* Keep this around until x86 is converted over */
>> +       if (!IS_ENABLED(CONFIG_GENERIC_PENDING_IRQ_CHIPFLAGS)) {
>> +               irqd_clear(&desc->irq_data, IRQD_MOVE_PCNTXT);
>> +               if (irq_settings_can_move_pcntxt(desc))
>> +                       irqd_set(&desc->irq_data, IRQD_MOVE_PCNTXT);
>> +       }
>> +
>
> These changes in irq_modify_status() need to be dropped to support
> the above changes in irq_domain_set_hwirq_and_chip().

Why? With CONFIG_GENERIC_PENDING_IRQ_CHIPFLAGS enabled this hunk is
compiled out. So nothing is modifying PCNTXT here. That's the whole
point.

Thanks,

        tglx



