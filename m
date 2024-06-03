Return-Path: <linux-kernel+bounces-198970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 102BC8D7FD9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422541C21DE5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF3381730;
	Mon,  3 Jun 2024 10:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bQa9BT0H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S8zkiw8f"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACE3B67D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 10:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717410046; cv=none; b=XwaXprn8FLviV6reyY6dpYDynNPJzU4Da+hdSn8fRMv/3gMfQH+d87H09aXVVLhR0CBNBtcXwihVWATK8w5SIxaUBi2chK95V3n8hRcbIqcx6Zi2/LpRFOfU+fskEpz0m4ckQy24C1ruou2J9wYqnkAWioWZF5mtzWVhlGqbUMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717410046; c=relaxed/simple;
	bh=7ZmJUqIGmcHSnQIcGtjJNg6y8Nka6CIExrPh79bpqDU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=InR7n/msLiNrvfwAIY5I4egPai1noRXVMWmr8MZ/26Uo7Ge40zmOOiHthDbwQ7fhj3zxGzSrmrIaHwvkcpGOEd+QrERaV05dhcANgwPcgEgcZSC8jnrikjFfIjPuRuW8lqy6OeiUcxcRFFsDfNw9OpletUYRqOPbMad12ZWdnzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bQa9BT0H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S8zkiw8f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717410043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v2TuznxaiQqatUVP3+q9egbv86wKVadFJkWHgEqa3NE=;
	b=bQa9BT0HnqfZ+fKrR2E2fjSPIqUefROJCNMcvie95B5TGK4QsgIz9eOM6HHHz0FBdK5nEt
	cIA8w4m3RAmYYOqNfzsqtQs013lREfP2wbwNuu7lMuPT9JFqRXNY0xTw3l6KreLITKKhPE
	jz5+4ofrn87Q1AgUugxBjN3x1hYr1eMDgUBgFKzFGGD3HFU0i7cFn0UEz3T0N6jeJ5Shtn
	mGPXNNJbh0/vzkhNu+Sk1NejFe10AZp65+YJTCwsim7+IaADSiN5z9k/qyBpiaQ5UKJwfl
	zqu7Iporgd0Xh8Q+HNx53IG/+P0EYNHlVFCU6fRu94KWsLdixB49XWxhYQv9tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717410043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v2TuznxaiQqatUVP3+q9egbv86wKVadFJkWHgEqa3NE=;
	b=S8zkiw8fq215SCHO96U3+2WUDVA5ZmJKdoixZo0Wped7J3E5yNAZGCR6h8P/KOvq6/p/M1
	asId8T0BfWoKJIDA==
To: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/10] irqdomain: Allow giving name suffix for domain
In-Reply-To: <2ea1749587d9e5a74a80a8eee7caf58c3e954a6e.1716533790.git.mazziesaccount@gmail.com>
References: <cover.1716533790.git.mazziesaccount@gmail.com>
 <2ea1749587d9e5a74a80a8eee7caf58c3e954a6e.1716533790.git.mazziesaccount@gmail.com>
Date: Mon, 03 Jun 2024 12:20:42 +0200
Message-ID: <87h6ea72f9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, May 24 2024 at 11:18, Matti Vaittinen wrote:
> When multiple IRQ domains are created from same device-tree node they

s/IRQ/interrupt/

Also most of your sentences lack a substantial amount of articles.

> will get same name based on the device-tree path. This will cause a
> naming collision in debugFS when IRQ domain specific entries are
> created.
>
> One use-case for being able to create multiple IRQ domains / single
> device node is using regmap-IRQ controller code for devices which
> provide more than one physical IRQ.

This does not make sense. Why do you need multiple interrupt domains if
there is more than one physical interrupt?

> It seems much cleaner to instantiate

'It seems' is not a technical argument.

> own regmap-IRQ controller for each parent IRQ because most of the regmap
> IRQ properties are really specific to parent IRQ.

Now you start talking about parent interrupts. Can you please make your
mind up and concisely explain what this is about?

> -struct irq_domain *irq_domain_create_legacy(struct fwnode_handle *fwnode,
> +struct irq_domain *irq_domain_create_legacy_named(struct fwnode_handle *fwnode,
>  					 unsigned int size,
>  					 unsigned int first_irq,
>  					 irq_hw_number_t first_hwirq,
>  					 const struct irq_domain_ops *ops,
> -					 void *host_data)
> +					 void *host_data, const char *name_suffix)
>  {
>  	struct irq_domain *domain;
>  
> -	domain = __irq_domain_add(fwnode, first_hwirq + size, first_hwirq + size, 0, ops, host_data);
> +	domain = __irq_domain_add(fwnode, first_hwirq + size, first_hwirq + size,
> +				  0, ops, host_data, name_suffix);
>  	if (domain)
>  		irq_domain_associate_many(domain, first_irq, first_hwirq, size);
>  
>  	return domain;
>  }
> +EXPORT_SYMBOL_GPL(irq_domain_create_legacy_named);

What for? This new stuff is not going to be used for legacy setups with
hard coded Linux interrupt numbers. So there is no point to add a
function plus an export which is never used.

Thanks,

        tglx

