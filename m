Return-Path: <linux-kernel+bounces-306946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE709645D2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A672B1F27648
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC321A4F06;
	Thu, 29 Aug 2024 13:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y6DKYe1B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0+ogEiSf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08E91946CA;
	Thu, 29 Aug 2024 13:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724936941; cv=none; b=O7o1TYS6Mjwdqxpn1dfW+vMNmZwWAvFJOQS5co1WvzUmWod5Fd3eI2HchurZWM8oD2owz6GcrREjHDUAVLmV7wLV84jF6XmCc8z6ol00LZDIg1omtIaqf4iQoyr7jxdfQXwrzi9cv+VodV0sDlkxn0ZZ2ihd/xoYlOddNy//xcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724936941; c=relaxed/simple;
	bh=/YcGSJSFqAmJKaRaXk1qyozjgO4RWkKRcPvMEGIUug4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r1vcrqZ8MYjw/4GclYkAouEMnwV1b/HNpcqR0drKxfSNf7/dZVb0PoQQpLUl7KX4sc6mTIczVdfj3LiI2SofjNoxdfj3ur2EeS0khQezqAoY+Kf1WnklDGED+doPij8OsHLlDnZ8HMLlry5hhNwvFXmhRGYlw0Fxtwi+mKxlTkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y6DKYe1B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0+ogEiSf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724936937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ieTWdV07NbZ9ssB6zICmV4vVPLCi22h5v9KXYRgJRfI=;
	b=y6DKYe1BhMBKW41WL4EOd63wZnaD0fJ1IpF6wrr5Q4Vn1uE4xO4sMCucVnUA/J06x1lmOJ
	Sjn0tKydI7oN/f0SjMQ1GbD/3Pebu/FCaGg1C2qdGooBYK6j1Xa4K2uCgZR5fuRuR30DHT
	AXnGpKreUpDsFOtPeNEBp/p4z15HgumgwA1fno/rvX6oLwF5niUdKkQ/4JYtfvy1cczDlv
	LLhpkmAj5qFoSUS42XTBgX0gGST+c8khK3OWFmP6OOtRVtLHTX+WgLVd8BbIJoD7mpckv4
	xp5KDSKSAuOd99pgycNAO47RHs47CPOSqHT1ZZPHyRfE8mgRfrhsb1Rp3wBxEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724936937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ieTWdV07NbZ9ssB6zICmV4vVPLCi22h5v9KXYRgJRfI=;
	b=0+ogEiSfY2/9fY30bXDJSxyQ0l/lS2woiv32ZEitRAJVeGgiruE4wgvuBWpYN+84/UpiOs
	bSrO+tnV8JmgG8AQ==
To: Nick Chan <towinchenmi@gmail.com>, Hector Martin <marcan@marcan.st>,
 Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: ~postmarketos/upstreaming@lists.sr.ht, Nick Chan
 <towinchenmi@gmail.com>, Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH RESEND 2/3] irqchip/apple-aic: Only access IPI sysregs
 when use_fast_ipi is true
In-Reply-To: <20240829110436.46052-3-towinchenmi@gmail.com>
References: <20240829110436.46052-1-towinchenmi@gmail.com>
 <20240829110436.46052-3-towinchenmi@gmail.com>
Date: Thu, 29 Aug 2024 15:08:57 +0200
Message-ID: <87zfova32u.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 29 2024 at 19:02, Nick Chan wrote:
> Starting from the A11 (T8015) SoC, Apple introuced system registers for
> fast IPI and UNCORE PMC control. These sysregs do not exist on earlier
> A7-A10 SoCs and trying to access them results in an instant crash.
>
> Restrict sysreg access within the AIC driver to configurations where
> use_fast_ipi is true to allow AIC to function properly on A7-A10 SoCs.

use_fast_ipi is an implementation detail and does not mean anything
here. It's sufficient to say:

   Only access system registers on SoCs which provide them.

Hmm?

> While at it, remove the IPI-always-ack path on aic_handle_fiq.

It's not while at it. It's part of handling this correctly.

> If we are able to reach there, we are on an IPI-capable system and
> should be using one of the IPI-capable compatibles, anyway.

'we' can't reach that code ever.

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog


> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>

This Signed-off-by chain is invalid. If Konrad authored the patch then
you need to have a 'From: Konrad ...' line at the top of the change log.

If you worked together on this then this needs a Co-developed-by
tag. See Documentation/process/...

>  
> -	if (read_sysreg_s(SYS_IMP_APL_IPI_SR_EL1) & IPI_SR_PENDING) {
> -		if (static_branch_likely(&use_fast_ipi)) {
> -			aic_handle_ipi(regs);
> -		} else {
> -			pr_err_ratelimited("Fast IPI fired. Acking.\n");
> -			write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
> -		}
> +	if (static_branch_likely(&use_fast_ipi) &&
> +	    (read_sysreg_s(SYS_IMP_APL_IPI_SR_EL1) & IPI_SR_PENDING)) {
> +		aic_handle_ipi(regs);
>  	}
>  
>  	if (TIMER_FIRING(read_sysreg(cntp_ctl_el0)))
> @@ -574,8 +571,9 @@ static void __exception_irq_entry aic_handle_fiq(struct pt_regs *regs)
>  					  AIC_FIQ_HWIRQ(irq));
>  	}
>  
> -	if (FIELD_GET(UPMCR0_IMODE, read_sysreg_s(SYS_IMP_APL_UPMCR0_EL1)) == UPMCR0_IMODE_FIQ &&
> -			(read_sysreg_s(SYS_IMP_APL_UPMSR_EL1) & UPMSR_IACT)) {
> +	if (static_branch_likely(&use_fast_ipi) &&
> +	    (FIELD_GET(UPMCR0_IMODE, read_sysreg_s(SYS_IMP_APL_UPMCR0_EL1)) == UPMCR0_IMODE_FIQ) &&
> +	    (read_sysreg_s(SYS_IMP_APL_UPMSR_EL1) & UPMSR_IACT)) {
>  		/* Same story with uncore PMCs */
>  		pr_err_ratelimited("Uncore PMC FIQ fired. Masking.\n");
>  		sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
> @@ -811,7 +809,8 @@ static int aic_init_cpu(unsigned int cpu)
>  	/* Mask all hard-wired per-CPU IRQ/FIQ sources */
>  
>  	/* Pending Fast IPI FIQs */
> -	write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
> +	if (static_branch_likely(&use_fast_ipi))
> +		write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
>  
>  	/* Timer FIQs */
>  	sysreg_clear_set(cntp_ctl_el0, 0, ARCH_TIMER_CTRL_IT_MASK);
> @@ -832,8 +831,9 @@ static int aic_init_cpu(unsigned int cpu)
>  			   FIELD_PREP(PMCR0_IMODE, PMCR0_IMODE_OFF));
>  
>  	/* Uncore PMC FIQ */
> -	sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
> -			   FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
> +	if (static_branch_likely(&use_fast_ipi))
> +		sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
> +				   FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));

Please see the bracket rules in the tip maintainers doc.

Thanks,

        tglx

