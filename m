Return-Path: <linux-kernel+bounces-208793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A499D902937
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 21:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B706F1C21B08
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 19:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861C414D70E;
	Mon, 10 Jun 2024 19:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IlhXHSOh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zna2BmKA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17816147C6E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 19:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718047548; cv=none; b=Okfxeh2IvROX8rAHt02XN4k9hU9lnfjoXEDeN5aKN9tPBEblm8qkkIbYN2c7wvV70uOLOCRqfiIxs+Xeekyqv9e6DIteapcZh/IqwfHCCZaYQvX/cis7rcSgOAfJlo8Zvqv8gqzDtfi/3E5Xw1ZQ8RcrbecWCaGY6SiGigvMxw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718047548; c=relaxed/simple;
	bh=DReATjJoT0Z7EmcEOoRiUxp+pwQWIV8qe+F7SKa/pjQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tnsn3/CVZuZbXlaEm71gbYWxyTtnJLiEn2pADiOJbSFKL9ou14DjaVyw3JB5f1YDvstrZDqFQ+KGM9ZBPcL018eAhYubxb4F6KPzxIRTSq6+gOLIRlXZqgk6gAlNRj0hzZVXRrH2s+yw/aeQLg+nQeDp0NubysdyqRIHh/+mNPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IlhXHSOh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zna2BmKA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718047545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HBt4RKo9/sSLehurMEIcT3Dh56M0u1PHePIeTS7hnRw=;
	b=IlhXHSOhzceeTs+KjqgGWcnB+tOL37d0XkoH8KGcl/f3auE9ZvOToE+Lbp6SAZ/XFnSnVI
	PyRbDjVl4jVNvOL1y7W91ukJHWojaiylWJd07nf6TC8GvXM+OKzqbZUULFSFyZW6/zGT81
	RKZoUexhvZm0yFH/k+nJM+dq0UMtLuNvxj8JSN9re5jyCuqut/N2HnhPEo7+ZpQrzN3CTP
	0vW23/rH0ohHL8WckTg/rz5fYAZzf2aESAYE2V21S7Ou4WJqS4b5qmQCFXhxebUfhfPoSp
	OB3+AlAzAFrDPqvYEha4qNAKeealma7njvduKyw9eaLpAmZLfRCspjI8Hfm/fw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718047545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HBt4RKo9/sSLehurMEIcT3Dh56M0u1PHePIeTS7hnRw=;
	b=Zna2BmKAdndDlYeKlXEgBvUsgTOfwew9M1RwrvppBwLbNBn8eD53c1ji68YBheQyJdAvB3
	9lom/nbu33KsSkDw==
To: Zhenze Zhuang <luuiiruo@163.com>
Cc: linux-kernel@vger.kernel.org, Zhenze Zhuang <luuiiruo@163.com>
Subject: Re: [PATCH] genirq: Fix gpio irq will fail to be resend under
 certain conditions
In-Reply-To: <20240608163620.89028-1-luuiiruo@163.com>
References: <20240608163620.89028-1-luuiiruo@163.com>
Date: Mon, 10 Jun 2024 21:25:44 +0200
Message-ID: <874ja0wqfb.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Zhenze!

On Sun, Jun 09 2024 at 00:36, Zhenze Zhuang wrote:

This has nothing to do with GPIO interrupts. It's a general problem
vs. resend, no?

> When a gpio irq is disable and the wakeup function is enable, and
> the device enters suspend, the irq wakeup is triggered but then enters
> suspend, the IRQS_REPLAY flag will be set, but the IRQS_REPLAY will
> not be cleared because the irq_may_run() condition is not met. After
> the gpio irq is enabled and the suspend is entered again, after the
> gpio irq is triggered, the check_irq_resend() execution will fail
> because the IRQS_REPLAY is asserted, resulting in the interrupt not
> being resned.

The concept of separate sentences and paragrahs exists for a reason.

  https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog

No let me break that world salad apart and digest it.

> When a gpio irq is disable and the wakeup function is enable, and
> the device enters suspend, the irq wakeup is triggered but then enters
> suspend, the IRQS_REPLAY flag will be set, but the IRQS_REPLAY will
> not be cleared because the irq_may_run() condition is not met.

So what you are saying is:

An interrupt is disabled, but the wakeup function of the interrupt is
enabled, right?

Now the system enters suspend and the interrupt is raised, which
triggers the wakeup function, right?

Now the system enters suspend nevertheless. How can that happen?

Due to that the IRQS_REPLAY flag will be set. How so? IRQS_REPLAY is
only set from the resend function.

Due to that IRQS_REPLAY will not be cleared because the irq_may_run()
condition is not cleared. Sure, but how does any of this happen in the
first place?

> After the gpio irq is enabled and the suspend is entered again, after
> the gpio irq is triggered, the check_irq_resend() execution will fail
> because the IRQS_REPLAY is asserted, resulting in the interrupt not
> being resned.

This sentence really makes my brain go in circles. None of this change
log makes any sense.

Before you send me a decipherable description of the problem, let me ask
you a few obvious questions:

  1) Why is the interrupt disabled _and_ marked as wakeup interrupt?

  2) If it should still wakeup the system even if disabled, then the
     interrupt chip should have the IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND
     flag set. That's not the case, right?

Thanks,

        tglx


