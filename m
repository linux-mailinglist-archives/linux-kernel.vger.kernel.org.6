Return-Path: <linux-kernel+bounces-345869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0E798BC27
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17D59B232B4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046991C2DB1;
	Tue,  1 Oct 2024 12:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DMF1+/yr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1N/X5Pri"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015DE1C2DB2
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 12:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727785992; cv=none; b=sIvbA3DeBC/YB3CiiJFWQT8y0B9sB9Nx8rOvBHnwn6fgRKmSQbk+aHSBS1AnCyT2VT7IjA7RJL8pkT1dgZsLc7Q+DiohTXC+dxtB2Tok1GfZWp3ajupF+uABjlc6tTRIr3q+ARWeFnYfG9vzBPRWaNpLU7qaoIg82fexiaLCSAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727785992; c=relaxed/simple;
	bh=5MrYlsryO9DyW+f6YhuNgihMOlIp0dj251treliLUbM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IhEuJDm1SDrZBIbx4NUhFTtIgauZZ7nVZhJFGnAiKthgczcNm4m37t7mlZu/26jjtnz5yQM3FD0woOsWtkGSTAXQjwIjAuXV2qKEAMyYaV3IGas+sB9nW4rzw+Y6mIzv4FXMpZLDXTYoFHG/281IFYy86IaAZoRbEq3WOJJvjL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DMF1+/yr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1N/X5Pri; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727785983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U1Ysj8ha5ntJle7w3acvDm6aMN37rYFth4LF/GUDPbQ=;
	b=DMF1+/yrx/fy5KCdrS5z2c+VyfSgLZCdzf1au13Fby/yN6dLs5yk+ORbfajpK5vFS2Rjix
	mIqHkN9F2W2RE+V2gffZIN9++KVIEIqmVH94ysrf4Rb6Dm8RYoE34VMuDWJLB9fyLKBX0u
	0IC4KVNfw+tz2FPT5oFbli1JeqjLGcwnT7fAED9iyFHxXKJ1rTJ14qaZMGqJrcKEpT+1uh
	1HriqpVqkjRcAoh3jzhvF2RLPUYartO3hMT+k8T3AF0NL+jN8zxuHaOLk8OLmtepQWw1/+
	P5AaWUH2snBcJw1S43fF+01gcwyvhodfJMf4XYrJ4XeZr3n6y9jgCpG9cmH5+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727785983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U1Ysj8ha5ntJle7w3acvDm6aMN37rYFth4LF/GUDPbQ=;
	b=1N/X5Priwbtk69oG8POZJJ4GpyHzL4sYsd23kneCPM3cYqKrOz/9oTr0HqdQE53iRUdZhJ
	2BnjcIAXgo/TJsAQ==
To: Bart Van Assche <bvanassche@acm.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King
 <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Bart Van Assche
 <bvanassche@acm.org>
Subject: Re: [PATCH 01/21] genirq: Introduce number_of_interrupts() and
 set_number_of_interrupts()
In-Reply-To: <20240930181600.1684198-2-bvanassche@acm.org>
References: <20240930181600.1684198-1-bvanassche@acm.org>
 <20240930181600.1684198-2-bvanassche@acm.org>
Date: Tue, 01 Oct 2024 14:33:03 +0200
Message-ID: <875xqcypds.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 30 2024 at 11:15, Bart Van Assche wrote:
> This patch prepares for changing 'nr_irqs' from an exported global
> variable

git grep 'This patch' Documentation/process/

> into a variable with file scope.

Also what's the rationale for this?

>  
>  extern int nr_irqs;
> +int number_of_interrupts(void) __pure;
> +int set_number_of_interrupts(int nr);

Please use a proper name space prefix for the functions
irq_.....(). These random names are horrible.

>  extern struct irq_desc *irq_to_desc(unsigned int irq);
>  unsigned int irq_get_next_irq(unsigned int offset);
>  
> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
> index 1dee88ba0ae4..8c6280843964 100644
> --- a/kernel/irq/irqdesc.c
> +++ b/kernel/irq/irqdesc.c
> @@ -141,6 +141,20 @@ static void desc_set_defaults(unsigned int irq, struct irq_desc *desc, int node,
>  int nr_irqs = NR_IRQS;
>  EXPORT_SYMBOL_GPL(nr_irqs);
>  
> +int number_of_interrupts(void)
> +{
> +	return nr_irqs;

Why is this int? The number of interrupts is strictly positive, no?


