Return-Path: <linux-kernel+bounces-571835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3C0A6C2EF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 20:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A60E3BA9A0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 19:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C0B22CBE8;
	Fri, 21 Mar 2025 19:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j3NVhe17";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hxyVbO1u"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F0E1DE2C2
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 19:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742583824; cv=none; b=WRz2aEJPhaFBJuwbtMXfJ8c2CMIdJjfCO52C93HxyjtqcJPn9BpP2TyBQQsF+Mrkoq4Mxn30fxlhKbFD7r60su8Xqdz+zgvyBpP4jaTKl9k6+q5DsYbGuxnVPxjwgliA7fitEp0FpAbT8nmJr8nSKgXtwjBIJOsBs6Jhh66vKWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742583824; c=relaxed/simple;
	bh=KruAje7rMFf8RZtS9gFqLMmjvNt+i2RZdcVe4Dxv8bw=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LW68Dluop5w2csV8Varz8pjlMCfcOJr89zglDWay+jLnsN6dDhb5ytaUwleB0AtS/ZVoBGZMKgiLhYGpZbGA1ZeLPSaT88bSVtH03RlbT9rpel60FV+OFKCJu0XjLMyPus9u9J4sqUrmqaj/wuKXz3nZ9wOimXyYFtqUSlImsjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j3NVhe17; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hxyVbO1u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742583821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YwZAkrEa8j11uXqpJRjuVU9Y7DaFvItgBEzgIsHeFEI=;
	b=j3NVhe17q4chFiLaoGAeTmKYQIAaSZEZNAkx4/3k7yrDS0TjU8a8ZIRcS8/cWNJQ7KIi1D
	b62NlqLYCqnsGN6YfQ91YE9EZV+aA60Kxgh6SCRGAnDKlE9fFM8LOuFOWh6kX73D9pxYGR
	TUFPOmapVA3pm5wdGbChvGAAmp9Ct9c7WnvkMJ4WDB4RiyII10whv3usaqDUvAgWD0Lyip
	ZQjxaVp5UsT8dRRakU5pngoJdrJE76dtvgdxEL2C/ZXhPcFsgqXywbKRltVwTiOuBzHNh0
	P4wOH4wqq+UnjI3qg4PR5lWjvcBYh1RxeIXCop8bB0MgsnBNpHVsSB9xQy2PIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742583821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YwZAkrEa8j11uXqpJRjuVU9Y7DaFvItgBEzgIsHeFEI=;
	b=hxyVbO1u0gvWpJntZf85zSYMM2HOlmt/VbF77u3sIgYMnSwGfusRCCFmkgMraSkSPxjMot
	NxQ5ov9yyRxaODBw==
To: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, pmladek@suse.com, Andrew
 Morton <akpm@linux-foundation.org>, jani.nikula@intel.com, open list
 <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, takakura@valinux.co.jp,
 john.ogness@linutronix.de
Subject: Re: [RFC] panic: reduce CPU consumption when finished handling panic
In-Reply-To: <f2272f04-510e-4c92-be5e-fedcbb445eb0@gmail.com>
References: <f2272f04-510e-4c92-be5e-fedcbb445eb0@gmail.com>
Date: Fri, 21 Mar 2025 20:03:40 +0100
Message-ID: <87wmci1a0j.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17 2025 at 17:01, Carlos Bilbao wrote:
> After the kernel has finished handling a panic, it enters a busy-wait loo=
p.
> But, this unnecessarily consumes CPU power and electricity. Plus, in VMs,
> this negatively impacts the throughput of other VM guests running on the
> same hypervisor.
>
> I propose introducing a function cpu_halt_end_panic() to halt the CPU
> during this state while still allowing interrupts to be processed. See my
> commit below.

That's not the way how change logs are written. You explain the problem
and then briefly how it is addressed.

No proposal, no 'see below'. Such wording does not make any sense in a
git commit. See Documentation/process/

> @@ -276,6 +276,21 @@ static void panic_other_cpus_shutdown(bool crash_kex=
ec)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 crash_smp_send_stop();

Your patch is malformed due to white space damage:

  patch: **** malformed patch at line 31: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 crash_smp_send_stop();

> +static void cpu_halt_end_panic(void)
> +{
> +#ifdef CONFIG_X86
> +=C2=A0=C2=A0=C2=A0 native_safe_halt();
> +#elif defined(CONFIG_ARM)
> +=C2=A0=C2=A0=C2=A0 cpu_do_idle();
> +#else
> +=C2=A0=C2=A0=C2=A0 /*
> +=C2=A0=C2=A0=C2=A0=C2=A0 * Default to a simple busy-wait if no architect=
ure-specific halt is
> +=C2=A0=C2=A0=C2=A0=C2=A0 * defined above
> +=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=C2=A0=C2=A0=C2=A0 mdelay(PANIC_TIMER_STEP);
> +#endif

Architecture specific #ifdefs in core code are not the right way to
go. Split this into three patches:

1) Add a weak fallback function

void __weak cpu_halt_after_panic(void)
{
        mdelay(PANIC_TIMER_STEP);
}

2) Add non weak implementation in arch/x86

    native_safe_halt() is wrong vs. paravirtualization.

    safe_halt() is what you want.
=20=20
3) Add non weak implementation for arch/arm

   Not my playground, so no comment

Thanks,

        tglx

=20=20=20=20

