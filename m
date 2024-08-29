Return-Path: <linux-kernel+bounces-306981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28172964662
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ABBAB23264
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09071A76A4;
	Thu, 29 Aug 2024 13:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4GVMvnix";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k+4S6Cg6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3804193083
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 13:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724937872; cv=none; b=OpR6rVpiIUNmwFiTXg4WelS4bdm0Ix/wvG2fMxatPsnZKLF59eI2ANB7YhA4zLP9Avn48hSlyLHabjt933yJdqlMlOAiBr6MNDmq97Zx/u9/OvvCeGPEYRPx1wlc7ZNxU7rdVEuQVCAGUImUgSdgv/EVad9RPmmgYAgkjK53DqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724937872; c=relaxed/simple;
	bh=t2xJjf9oycnyMNa/2LYb2pI0Z9dIen9tXBhQb0G6BTk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aEEVfG7biV231jWHrvNUpsKix58PXYIvq6tK0YkTHgEuJDVguHyakKnorWLbeTVKkOiAPrRtr5pFSBYXBWh97ASbDlBqDEBG84Ttgs6u+lN5QHLVg+0hxELLqu3Cb+w180Dt+1lQDnRbRXBB9UXdqM/w4kvJNXuqQjP7VvfHMU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4GVMvnix; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k+4S6Cg6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724937868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8dzX3Yx47edY0gv4DLRfcqGz4T3eOWao8WtfV7cpFOw=;
	b=4GVMvnixxr/E7KG+MNQJ2YFXZFmAB+x8w/oyOU9GQNIdGReGVVQhXyGuX7djUXrajRuGLX
	+tZNmDDK6tOCbMN1kscATob86q7iSoV/ls+mOpIGYH8R7Ri1D82AiPvBVU8jWZFSyKv/HK
	ximHYwRNGlGQ+59zOjnr05zfaGhIQ3PndowX3KFKJPjgFSfsa3nVJSDVjykOnIbaRuvmGg
	k8tXseLAgpZmQE8ZfsJlMlhWf3q1yGmVOtY8+dmYLLuE+/0ZHzwkndaEn7GVovu6jvGdnd
	jKw92EwpHR8F09n+X4qJegJ5tmP/SN0HU75WLc2vCTFO0BbDk3RJEKcHgUoG6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724937868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8dzX3Yx47edY0gv4DLRfcqGz4T3eOWao8WtfV7cpFOw=;
	b=k+4S6Cg6IRCLKM0k7O8re2PfsnMRYB9cXbgWLFFPbo+0bGvbE92FZTVc1W5qSTDFFRICVh
	6Z1dTOACkYiyxqAw==
To: Yangtao Li <frank.li@vivo.com>
Cc: Yangtao Li <frank.li@vivo.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Jonathan Cameron
 <Jonathan.Cameron@Huawei.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/22] genirq/devres: Add
 devm_request_threaded_irq_probe() and devm_request_irq_probe()
In-Reply-To: <20230721094641.77189-1-frank.li@vivo.com>
References: <20230721094641.77189-1-frank.li@vivo.com>
Date: Thu, 29 Aug 2024 15:24:27 +0200
Message-ID: <87r0a7a2d0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jul 21 2023 at 17:46, Yangtao Li wrote:
> +/**
> + *	devm_request_threaded_irq_probe - allocate an interrupt line for a managed device(recommended)

What does device(recommended) mean? This short description should
explain comprehensivly what this function does. You chose the name
_probe() for a reason, no?

> + *	@dev: device to request interrupt for
> + *	@irq: Interrupt line to allocate
> + *	@handler: Function to be called when the IRQ occurs
> + *	@thread_fn: function to be called in a threaded interrupt context. NULL
> + *		    for devices which handle everything in @handler
> + *	@irqflags: Interrupt type flags
> + *	@devname: An ascii name for the claiming device, dev_name(dev) if NULL
> + *	@dev_id: A cookie passed back to the handler function
> + *	@info: Optional additional error log

Please make the argument doc tabular.

	@dev:		Device to request interrupt for
	@irq: 		Interrupt line to allocate
        ....
	@irqflags:	Interrupt type flags
        ...

> + *
> + *	This is a variant of the devm_request_threaded_irq function.
> + *	It will print an error message by default when the request fails,
> + *	and the consumer can add a special error msg.
> + *
> + *	Except for the extra @info argument, this function takes the
> + *	same arguments and performs the same function as
> + *	devm_request_threaded_irq(). IRQs requested with this function will be
> + *	automatically freed on driver detach.
> + *
> + *	If an IRQ allocated with this function needs to be freed
> + *	separately, devm_free_irq() must be used.

Lacks documentation of the return value.

> + */
> +int devm_request_threaded_irq_probe(struct device *dev, unsigned int irq,
> +				    irq_handler_t handler, irq_handler_t thread_fn,
> +				    unsigned long irqflags, const char *devname,
> +				    void *dev_id, const char *info)
> +{
> +	int rc;
> +
> +	rc = devm_request_threaded_irq(dev, irq, handler, NULL, irqflags, devname, dev_id);
> +	if (rc)
> +		return dev_err_probe(dev, rc, "Failed to request %sinterrupt %u %s %s\n",
> +				     thread_fn ? "threaded " : "", irq, devname ? : dev_name(dev),
> +				     info ? : "");

        if (rc) {
        	return ....;
        }

See https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#bracket-rules

> +	return 0;
> +}
> +EXPORT_SYMBOL(devm_request_threaded_irq_probe);

EXPORT_SYMBOL_GPL();

> +
>  /**
>   *	devm_request_any_context_irq - allocate an interrupt line for a managed device
>   *	@dev: device to request interrupt for

Thanks,

        tglx

