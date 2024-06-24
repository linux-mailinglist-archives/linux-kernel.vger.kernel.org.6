Return-Path: <linux-kernel+bounces-227161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F69914935
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37BCD28126D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACC913B2AF;
	Mon, 24 Jun 2024 11:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t5U0Nfiu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n6MlwxdA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4741132120
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719230197; cv=none; b=IyLUkJxjanOkWw9tJGvbbxIX7a0TmQYYbGvIUzP/aDsDVUv27eQdeONwNneCBlTI0iLPG3gY808O1ysjDjE49ZvFwlmwbq1l/oSaMKhC1E2ODj6DGN9wVPORVyQTHR0QQDvAYPQ/PfQhlCKB1VUcj/ZPe/MAX92MjJJFhoIAIZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719230197; c=relaxed/simple;
	bh=VdG5PTa2fJHiiQDIFrYEJO4DZz1JK0KYbKAkOBQxVMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OcBBl0ingt9sTYZE6zHQEWt1i2ycuSvLend+MnLMYxsZRGKqtRZguyeVT00VElrtHwKp+pxWjmzyzt9W469J6l7taZeV4RBox8sshnIIy8yzcTI/XV4MPWjSG/7Q9aNKHUDLVEw8gjubxsybUI3HBemIz6Qi5WEJQ/NOOSkJC6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t5U0Nfiu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n6MlwxdA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Jun 2024 13:56:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719230193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G6fIpTYEbw/5Hg01e4xNPhrpp1XjqqkIHjd4UFwopHk=;
	b=t5U0NfiuR7u57BbfVS/yadPrUNyyDwdLLmqidlRg90p8qMVUlb3jTh9zUHMdnKBGKsoRwy
	QgK7bGd5u7XDxtkTwzBKq/DbEbvGlzOm3e90fpTHLRKzByqnfRMu53feMa06aVRhQEWREJ
	OgW9YMimLffgbjYc2TyB6x/Yc8sIzO53sSD11JX1kNlLUSrZXnj+QVwKDAfl1v9Tde3+ei
	XHuPCmBd+cUXtzXIRBbkf6KEbhO0XLvf4JrEdhiUZc6KqBbqXBrLwYe5hLugrzgr/LfDFj
	j9KDDNeaRTRwU/7S1+WqGGVsSoBxOCYzHK6wOyyAvvG597SivwbpXEZHFpbC6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719230193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G6fIpTYEbw/5Hg01e4xNPhrpp1XjqqkIHjd4UFwopHk=;
	b=n6MlwxdATeQpHasM93pVJ3E5phkWKWlXvIScXe4ANepN8ex+pMYmSLw2twG9VVHh1qUarj
	3f25R45vKotvhJDw==
From: Nam Cao <namcao@linutronix.de>
To: Yan =?utf-8?B?WmhlbmfvvIjkuKXmlL/vvIk=?= <zhengyan@asrmicro.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
	"maz@kernel.org" <maz@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"samuel.holland@sifive.com" <samuel.holland@sifive.com>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	Zhou =?utf-8?B?UWlhbyjlkajkvqgp?= <qiaozhou@asrmicro.com>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQ0g=?= =?utf-8?Q?=5D?=
 irqchip/sifive-plic: ensure interrupt is enable before EOI
Message-ID: <20240624115629.6vSA6hQE@linutronix.de>
References: <20240624085341.3935-1-zhengyan@asrmicro.com>
 <20240624093556.ZcZgu2GF@linutronix.de>
 <69174a28eff44ad1b069887aa514971e@exch03.asrmicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69174a28eff44ad1b069887aa514971e@exch03.asrmicro.com>

On Mon, Jun 24, 2024 at 11:14:47AM +0000, Yan Zheng（严政） wrote:
> > I have no knowledge about affinity stuff, so I don't really understand this
> > patch. But there is another idea regarding this "ignored EOI" problem:
> > always "complete" the interrupt while enabling. That would move this extra
> > complication out of the hot path, and also looks simpler in my opinion.
> > 
> > Something like the patch below. Would this solve this "affinity problem"
> > too?
> > 
> No, I'm afraid the following patch can't solve this corner case. I thought it's because the core
> Who executes plic_irq_enable is not the core who missing a write claim.
> So if we want to do it in enable it might be something like follows :
> static void plic_toggle(struct plic_handler *handler, int hwirq, int enable)
>  {
>         raw_spin_lock(&handler->enable_lock);
> -       __plic_toggle(handler->enable_base, hwirq, enable);
> +       if (enable) {
> +               writel(hwirq, handler->hart_base + CONTEXT_CLAIM);
> +               __plic_toggle(handler->enable_base, hwirq, enable);
> +       }
>         raw_spin_unlock(&handler->enable_lock);
>  }

Again, I don't know anything about interrupt affinity thingy, so I may be
saying something dumb here:

I think this wouldn't work either. In plic_set_affinity(), I see the
interrupt is disabled, then enabled again. With your new proposed solution,
the interrupt would also be marked completed within plic_set_affinity().
So, the interrupt may be asserted again, earlier than it is supposed to (it
is not supposed to be asserted again until plic_irq_eoi() is called). It's
rare, but I think it's a possible race.

I don't have a better idea, at least for now. So probably we should stick
to your current solution.
> 
> But there is a little difference:
> a. check whether it's enabled  when do write claim
> b. write claim anyway before enable 
> 
> sounds like a. is better?
> 
> And I'd like to illustrate more about this case:
> For example, broadcast tick is working, cpu0 is about to response, cpu1 is the next
> 1. cpu0  response the timer irq, read the claim REG, and do timer isr event, 
> 2.  during the timer isr it will set next event 
> tick_broadcast_set_event ->  irq_set_affinity-> xxx-> plic_set_affinity -> plic_irq_enable
> 3. in plic_set_affinity  disable cpu0's IE and enable cpu1'IE
> 4. cpu0 do the write claim to finish this irq, while cpu0's IE is disabled , left an active state in plic

This is useful information, you may want to add it in your commit message.
> 
> Best regards,
> zhengyan
> 
> > diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> > index 0a233e9d9607..63f2111ced4a 100644
> > --- a/drivers/irqchip/irq-sifive-plic.c
> > +++ b/drivers/irqchip/irq-sifive-plic.c
> > @@ -122,7 +122,15 @@ static inline void plic_irq_toggle(const struct
> > cpumask *mask,
> > 
> >  static void plic_irq_enable(struct irq_data *d)  {
> > +	struct plic_priv *priv = irq_data_get_irq_chip_data(d);
> 	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
> missing a definition? If adds like this will cause a problem.

Sorry, should have mentioned I didn't build this patch. Just wanted to
throw out ideas..

> > +
> > +	writel(0, priv->regs + PRIORITY_BASE + d->hwirq * PRIORITY_PER_ID);
> > +
> > +	writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
> > +
> >  	plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 1);
> > +
> > +	writel(1, priv->regs + PRIORITY_BASE + d->hwirq * PRIORITY_PER_ID);
> >  }
> > 
> >  static void plic_irq_disable(struct irq_data *d) @@ -148,13 +156,7 @@ static
> > void plic_irq_eoi(struct irq_data *d)  {
> >  	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
> > 
> > -	if (unlikely(irqd_irq_disabled(d))) {
> > -		plic_toggle(handler, d->hwirq, 1);
> > -		writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
> > -		plic_toggle(handler, d->hwirq, 0);
> > -	} else {
> > -		writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
> > -	}
> > +	writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
> >  }
> > 
> >  #ifdef CONFIG_SMP

