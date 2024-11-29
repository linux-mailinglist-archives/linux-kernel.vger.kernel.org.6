Return-Path: <linux-kernel+bounces-425603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E8E9DE791
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 14:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41566164406
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 13:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0594819D8A9;
	Fri, 29 Nov 2024 13:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YZd0bUlE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wrWncmeL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3861990C1
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 13:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732887045; cv=none; b=peLf81A/1IamyJSJfem9qXy3w1lAf5lSPzJM/k+cQLAw7cwFvGb18XFEv0Ul/v+MBJQ3wtMFB/onCh91YcmK8R7gud7vcQmgOGSuvKQ61BNbhBchJIHZsbncxSBal2FxbfiOfHpJK9agzOn1SFBF4XllungUkXbw+PiD0kl543Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732887045; c=relaxed/simple;
	bh=FHdnGuZBTuKPq9x2/jt1fw8DN1Ik/TsNrC2qXay8KAw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BG/N3rrs3SSksLg0ytDdSSVVTx6o0Bl/76noVN100cZOW6DuIqs2tNFUuClnb9CpcYeQn8ffCZL87yw/1IT1pQRlmUzPrEASjo+41RApHftWnJYORvG7FpHhg/5kNB1Oxmei8smetQ+WgjD6dKVpsixCscwnYpxVEBiwGYgwyzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YZd0bUlE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wrWncmeL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732887041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=icaSftmPoFs3oPqGohm7R/vQ0cSrUMEsdq65mpHvRVA=;
	b=YZd0bUlE0xZWKejtIH/8b1Xqio5SfbdWK/5fXWh1rcU+HTZHZqztwv5kJcUBmq52ppdrJy
	1Ep4+fruQcQWa6mXw/p8/wsLzsNObq5sVcv+kWT0aSkor/PqAIo/AF1SvX8kussOXip9jW
	H6sdGyfghjxb6Y3ZPxDxq2Zsq4wbPAx6Rg7A9IX3NMquMO61hFmKPU+wHyFSZHsGZB4706
	parfYH3VpxhtyxyRSUbXKOzFpsOPMQbyXJeDVpuYL/lQkIA/k1Nw2c5rfjJznTWNfjY1ca
	JSyIKNKyfdTbY8dtmOcn45qcazynk3AfLKl/TLDh1aj50MMzlJU/wBAxGVRaEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732887041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=icaSftmPoFs3oPqGohm7R/vQ0cSrUMEsdq65mpHvRVA=;
	b=wrWncmeLIabkTOlhwz7jViyBBp/tltQNLjqOmhFxdSu/hqrEOzPSlAZ4Wcir7LF0WMDQzx
	JiqHMj25fRo9EECQ==
To: Eliav Farber <farbere@amazon.com>, linux@armlinux.org.uk,
 catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au,
 npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org,
 maddy@linux.ibm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, ebiederm@xmission.com, akpm@linux-foundation.org,
 bhe@redhat.com, farbere@amazon.com, hbathini@linux.ibm.com,
 sourabhjain@linux.ibm.com, adityag@linux.ibm.com,
 songshuaishuai@tinylab.org, takakura@valinux.co.jp,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 kexec@lists.infradead.org, Marc Zyngier <maz@kernel.org>
Cc: jonnyc@amazon.com
Subject: Re: [PATCH v4 1/2] kexec: Consolidate
 machine_kexec_mask_interrupts() implementation
In-Reply-To: <20241129113119.26669-2-farbere@amazon.com>
References: <20241129113119.26669-1-farbere@amazon.com>
 <20241129113119.26669-2-farbere@amazon.com>
Date: Fri, 29 Nov 2024 14:30:41 +0100
Message-ID: <87zfliw4ji.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Nov 29 2024 at 11:31, Eliav Farber wrote:
> Move the machine_kexec_mask_interrupts function to a common location in
> kernel/kexec_core.c, removing duplicate implementations from architecture
> specific files (arch/arm, arch/arm64, arch/powerpc, and arch/riscv).

Can you please move this into kernel/irq/kexec.c?

It's pure interrupt core internal code and there is no point to make
core internal functions visible to random other code just because.

> +void machine_kexec_mask_interrupts(void)
> +{
> +	unsigned int i;
> +	struct irq_desc *desc;

	struct irq_desc *desc;
        unsigned int i;

please

> +	for_each_irq_desc(i, desc) {
> +		struct irq_chip *chip;
> +		int check_eoi = 1;
> +
> +		chip = irq_desc_get_chip(desc);
> +		if (!chip)
> +			continue;
> +
> +		if (IS_ENABLED(CONFIG_ARM64)) {

This should not be CONFIG_ARM64. Add something like:

config GENERIC_IRQ_KEXEC_CLEAR_VM_FORWARD
	bool

and select this from ARM64?

> +			/*
> +			 * First try to remove the active state. If this fails, try to EOI the
> +			 * interrupt.

This comment does not really explain what this is about. I know you
copied it from the ARM64 implementation, but it should explain what this
actually means. Something like:

         First try to remove the active state from an interrupt which is
         forwarded to a VM. If the interrupt is not forwarded, try to
         EOI the interrupt.

or something like that.

> +			 */
> +			check_eoi = irq_set_irqchip_state(i, IRQCHIP_STATE_ACTIVE, false);

Looking deeper. This function actually cannot be called from this
context. It does:

          irq_get_desc_buslock(irq, &flags, 0);

which means for any interrupt which has an actual buslock implementation
it will end up in a sleepable function and deadlock in the worst case.

Marc?

> +		}
> +
> +		if (check_eoi && chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
> +			chip->irq_eoi(&desc->irq_data);

Thanks,

        tglx

