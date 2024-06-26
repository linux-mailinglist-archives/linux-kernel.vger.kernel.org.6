Return-Path: <linux-kernel+bounces-230344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 229BD917B84
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 544B71C23E14
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 08:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7751684A3;
	Wed, 26 Jun 2024 08:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EljuUJOG"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DFE143C70
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 08:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719392283; cv=none; b=IKWRkuILOfIqO+kt+JYGjIspQqpGp2cEJpNstvdm7S0K5S6/GW5xQnjCaPNGMfHA6JtyPXMT6NQEngNSGA+QRdALbkVQDRCiBEXhKq8lihxs3OzybS4g0TFPYWjAkjQJ/6oTlYKNs5gRGxWTe58VkcsmR8NElQ9rVlqOFVXzEGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719392283; c=relaxed/simple;
	bh=vfrXRAbFZqMo3woEeYmPIkHFiBhWzLhdnjSy55HmdpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYBYOOueqVLGC6ghBlzbVFElXShkqaXLhZWCYbRtqsLdDzduZ57ollQT3kU5eMedFDm6Admh/I9qRRGBBSkd0mzEsLcrm33Ydu3rSietzC+MTZeOqQx8yVdqhDkJb2TUbPTNhrMWMbUD9qh6QVYCTk6Q585PItb07fjINSDw1t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EljuUJOG; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=c55CHPi2kcTRcsfp+2hg5MOW5UaLFYITtMG7g7iadt0=; b=EljuUJOGKoAeaU+wJym6grYK7w
	vtfBwB3FBLnWHkkW0aaOZT5HY5PAe71/c2ZkAiv4uiXEk5Tu9Fk9EpV+jWxxVtwVJuMZxDT4wZD+C
	OgzcQI+YfIuKuW7E5yG249OJEMQbybPj4Hf6XW5zV5lCgXd+AOrb4jDtmNH8QvSfoSsBOOZIHf4zu
	LruI6N2DgNs4nYFo+fW2XsyWm2ESBENGJWk/k5f1xr2FKl3t1Ze5ROBM2byOolbgNZ+lLSDvrXY2i
	HUW529605MkK8Ew8FFV092FJLFXfv/xP00FRbSni+KhvPZlizc87RYNQOKrqTGbsDLEIVbqnsccQ4
	IPaKt9BA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMOSu-00000008YMV-01fV;
	Wed, 26 Jun 2024 08:57:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5C20D30057C; Wed, 26 Jun 2024 10:57:17 +0200 (CEST)
Date: Wed, 26 Jun 2024 10:57:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: jgross@suse.com, boris.ostrovsky@oracle.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, jeremy@goop.org,
	xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xen: Fix null pointer dereference in xen_init_lock_cpu()
Message-ID: <20240626085717.GB31592@noisy.programming.kicks-ass.net>
References: <20240626074339.2820381-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626074339.2820381-1-make24@iscas.ac.cn>

On Wed, Jun 26, 2024 at 03:43:39PM +0800, Ma Ke wrote:
> kasprintf() is used for formatting strings and dynamically allocating
> memory space. If memory allocation fails, kasprintf() will return NULL.
> We should add a check to ensure that failure does not occur.

Did you also consider what happens to the machine if you omit the rest
of this function at init?

As is, it is *extremely* unlikely the machine will fail the allocation
at boot (it has all the memory unused after all) and if for some
mysterious reason it does fail, we get a nice bug halting the boot and
telling us where shit hit fan.

Now we silently continue with undefined state and will likely run into
trouble later because we failed to setup things, like that irqhandler.
At which point everybody will be needing to buy a new WTF'o'meter to
figure out WTF happened to get in that insane position.



> Fixes: d5de8841355a ("x86: split spinlock implementations out into their own files")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Found this error through static analysis.

Just because your tool found something, doesn't mean you have to be a
tool and also not think about things.

Please use brain don't be a tool.

> ---
>  arch/x86/xen/spinlock.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
> index 5c6fc16e4b92..fe3cd95c1604 100644
> --- a/arch/x86/xen/spinlock.c
> +++ b/arch/x86/xen/spinlock.c
> @@ -75,6 +75,8 @@ void xen_init_lock_cpu(int cpu)
>  	     cpu, per_cpu(lock_kicker_irq, cpu));
>  
>  	name = kasprintf(GFP_KERNEL, "spinlock%d", cpu);
> +	if (!name)
> +		return;
>  	per_cpu(irq_name, cpu) = name;
>  	irq = bind_ipi_to_irqhandler(XEN_SPIN_UNLOCK_VECTOR,
>  				     cpu,
> -- 
> 2.25.1
> 

