Return-Path: <linux-kernel+bounces-264168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D15193DFB3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 16:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ABAA281F7F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 14:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A693917D88B;
	Sat, 27 Jul 2024 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CBQlM9zI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UaswQpxJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0732D17D37B
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722090670; cv=none; b=fcyBKDNTKVr4DsBuKChjahRbB2TsT8k0seAtktK7Od20dN4qqn5gvgv/YUQw0pkfxuzW7GksZB5x1pTuSkhnBRq5wja7motWmsiAfHGRjJ8YcDOHfefV5KFJ9h6KtY4Ftm3OrvZY7bz+RS+y2cgwadQkw/h7DWt+/J/oukFPLh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722090670; c=relaxed/simple;
	bh=yDNOfo65lSg/ryVatCsNCVsXeTBco7Dh+fiSlXXxcjw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jd6x+z9wvayxpysZbqgw/caOZ1V+sDS8+OMww1pU5Acn5/6zwuNcCqc9p7SytvcbbieIBmUGr/UXKdOgBQaqMKpQsNSBHqsNser/Mn56YGdc6p9tDEcZS/ZFWSMIqNV33YzpFLGXnMHcg4SHAk0XgKzqMKA/OUggwODOeX5p5yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CBQlM9zI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UaswQpxJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722090666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xao3J8L8Ao1HqCYYpEiR/UfMIfSL8Yam6FBaFcbEMHk=;
	b=CBQlM9zIVc6lDOmYg9XcTYSL91bTvQ26lAqIUutfmP/BjTamaCmGzYW0k2xpi0ymxGdZH4
	uhvfybl2HBahlYSZTHDoVTMioghPcuMxjx2XIkYilzfsvDmW01VOzXpa3bSrKpHEos/U3g
	taFqHIERdzhINHPwWsMPvDthldeUJbH5D4O3yIizu1SVaeotQCFRKeat0GKmLTpd7IhApE
	Kder4hKu7/2fdhbUAyOCkTnki/ExJ0jgtV2w8ekGfuI/bqb+xGGjkdAa19HuOhZgF6VA2s
	xrLaUqgQWIH91okGHeGHNFk39L6IvNrXk2hqgFP2FhLBj12p9wjBCpJUFvNrHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722090666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xao3J8L8Ao1HqCYYpEiR/UfMIfSL8Yam6FBaFcbEMHk=;
	b=UaswQpxJUeX2Z0FML5xROqlBG2siWcDlBH0ees8K4pXwHCn+5S4gUq4q2vR6nHQZBLoBrE
	R9mnKANWmJhNEIBA==
To: ysionneau@kalrayinc.com, linux-kernel@vger.kernel.org
Cc: Jonathan Borne <jborne@kalrayinc.com>, Julian Vetter
 <jvetter@kalrayinc.com>, Yann Sionneau <ysionneau@kalrayinc.com>, Alex
 Michon <amichon@kalrayinc.com>, Clement Leger <clement@clement-leger.fr>,
 Guillaume Missonnier <gmissonnier@kalrayinc.com>, Guillaume Thouvenin
 <thouveng@gmail.com>, Jules Maselbas <jmaselbas@zdiv.net>, Julien Hascoet
 <jhascoet@kalrayinc.com>, Julien Villette <julien.villette@gmail.com>,
 Marc
 =?utf-8?Q?Poulhi=C3=A8s?= <dkm@kataplop.net>, Luc Michel <luc@lmichel.fr>,
 Marius Gligor
 <mgligor@kalrayinc.com>
Subject: Re: [RFC PATCH v3 17/37] kvx: Add boot and setup routines
In-Reply-To: <20240722094226.21602-18-ysionneau@kalrayinc.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-18-ysionneau@kalrayinc.com>
Date: Sat, 27 Jul 2024 16:31:05 +0200
Message-ID: <87frruuct2.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jul 22 2024 at 11:41, ysionneau@kalrayinc.com wrote:
> diff --git a/arch/kvx/kernel/time.c b/arch/kvx/kernel/time.c

Any reason why this is not in drivers/clocksource/ ?

> +static unsigned int kvx_timer_frequency;
> +static unsigned int kvx_periodic_timer_value;
> +static unsigned int kvx_timer_irq;
> +
> +static void kvx_timer_set_value(unsigned long value, unsigned long reload_value)
> +{
> +	kvx_sfr_set(T0R, reload_value);
> +	kvx_sfr_set(T0V, value);
> +	/* Enable timer */
> +	kvx_sfr_set_field(TCR, T0CE, 1);
> +}
> +
> +static int kvx_clkevent_set_next_event(unsigned long cycles,
> +				      struct clock_event_device *dev)
> +{
> +	/*
> +	 * Hardware does not support oneshot mode.
> +	 * In order to support it, set a really high reload value.
> +	 * Then, during the interrupt handler, disable the timer if
> +	 * in oneshot mode
> +	 */
> +	kvx_timer_set_value(cycles - 1, KVX_TIMER_MAX_VALUE);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t kvx_timer_irq_handler(int irq, void *dev_id)
> +{
> +	struct clock_event_device *evt = this_cpu_ptr(&kvx_clockevent_device);
> +
> +	/* Disable timer if in oneshot mode before reloading */

The timer has already reloaded KVX_TIMER_MAX_VALUE, no?

> +
> +static int kvx_timer_dying_cpu(unsigned int cpu)
> +{
> +	disable_percpu_irq(kvx_timer_irq);

What disables the timer itself?

> +	return 0;
> +}

Thanks,

        tglx

