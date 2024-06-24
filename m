Return-Path: <linux-kernel+bounces-226968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7055A914685
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA6B61F2438B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 09:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC34131BDD;
	Mon, 24 Jun 2024 09:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cCVdnP2K";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p5aeRWzX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0336879DE
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 09:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719221764; cv=none; b=RFyOfT9yGKR3YZV+RsTVkxSCz4rXK1ywkp+CN4GbSle608CvRsd4I5+iTY+1rVtNpkUOWHsKPRL4ffIbDnf2FarLp0AN6rjlSuHCDhDOB4ac4+1GMNFfACVYgN/ny0Hj9/lUgrFf1YUZY91rvdkYJaPRfvCi1LNljJCegn44SV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719221764; c=relaxed/simple;
	bh=sQjpCsJwaCU+ZRhstVytz6oXBN6Iu2LAHHNEIiqtHyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=duaNNAMoz4y7jpvj2OQaeSWLrr3lYYD/VmpzsS/I7lqENCtdknHHT58iu1W+PkVmBnW5bFXj+xfidGMTXsuGWXiK0WwX9tm3DtRKof+Lw1EvbLW9t53KQehq3ldrzWrnfOmvO2Ip0K/gGyyJiONR/bJ9PItl15UfctRjJRIQVNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cCVdnP2K; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p5aeRWzX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Jun 2024 11:35:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719221761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lexuk++UGQy+LV2MaJjmecp6me8bsRDaxD2ODTFKJLg=;
	b=cCVdnP2KtpLESxd1di9/V+qQhOA3a/s6D4CEespGvdx0RBlY1iA51qDvoRU+0LszgGptpN
	1sxoytVAOeVpAFuIRPa6ft+24r7rs4nZK3iaH1fvKhktAwwanU9LzvvCdoHJc72iGzlzDb
	ZlAXxE2YOB0jWqLuRt92Cy9AGXvu72nndloKxdVOg1ZJJQX32RyUeP3nhkOF9LBqMvO62f
	7WwmPkXNzTvuPyhV6Wktrd1mpRuH+M5QzTBTRcafhF9DCJfOxVpcN0UiXQuV+nWZkPvLPq
	S9vLnRsmahW5G2toJpsWD/F1W8/+ZHKujch9HNtw6bATuhJWVsCo1alTJuPFEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719221761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lexuk++UGQy+LV2MaJjmecp6me8bsRDaxD2ODTFKJLg=;
	b=p5aeRWzXqA26JkmodL3pFeF9lLRKLOna7p2PmxdrvSLWtxr2mQVt/c9/+sR0hMNZBhA2iD
	zmezS89HUjMkKwCw==
From: Nam Cao <namcao@linutronix.de>
To: zhengyan <zhengyan@asrmicro.com>
Cc: tglx@linutronix.de, maz@kernel.org, linux-kernel@vger.kernel.org,
	paul.walmsley@sifive.com, samuel.holland@sifive.com,
	linux-riscv@lists.infradead.org, qiaozhou@asrmicro.com
Subject: Re: [PATCH] irqchip/sifive-plic: ensure interrupt is enable before
 EOI
Message-ID: <20240624093556.ZcZgu2GF@linutronix.de>
References: <20240624085341.3935-1-zhengyan@asrmicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624085341.3935-1-zhengyan@asrmicro.com>

On Mon, Jun 24, 2024 at 08:53:41AM +0000, zhengyan wrote:
> RISC-V PLIC cannot "end-of-interrupt" (EOI) disabled interrupts, as
> explained in the description of Interrupt Completion in the PLIC spec:
> "The PLIC signals it has completed executing an interrupt handler by
> writing the interrupt ID it received from the claim to the claim/complete
> register. The PLIC does not check whether the completion ID is the same
> as the last claim ID for that target. If the completion ID does not match
> an interrupt source that *is currently enabled* for the target, the
> completion is silently ignored."
> 
> Commit 9c92006b896c ("irqchip/sifive-plic: Enable interrupt if needed
> before EOI")
> ensured that EOI is enable when irqd IRQD_IRQ_DISABLED is set, before
> EOI
> 
> Commit 69ea463021be ("irqchip/sifive-plic: Fixup EOI failed when masked")
> ensured that EOI is successful by enabling interrupt first, before EOI.
> 
> Commit a1706a1c5062 ("irqchip/sifive-plic: Separate the enable and mask
> operations") removed the interrupt enabling code from the previous
> commit, because it assumes that interrupt should already be enabled at the
> point of EOI.
> 
> However, here still miss a corner case that if SMP is enabled. When
> someone need to set affinity from a cpu to another (Maybe like
> boardcast-tick) the original cpu when handle the EOI meanwhile the IE is
> disabled by plic_set_affinity
> 
> So this patch ensure that won't happened
> 
> Signed-off-by: zhengyan <zhengyan@asrmicro.com>
> ---
>  drivers/irqchip/irq-sifive-plic.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index 9e22f7e378f5..e6acd134a691 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -149,8 +149,10 @@ static void plic_irq_mask(struct irq_data *d)
>  static void plic_irq_eoi(struct irq_data *d)
>  {
>  	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
> +	void __iomem *reg = handler->enable_base + (d->hwirq / 32) * sizeof(u32);
> +	u32 hwirq_mask = 1 << (d->hwirq % 32);
>  
> -	if (unlikely(irqd_irq_disabled(d))) {
> +	if (unlikely(irqd_irq_disabled(d)) || (readl(reg) & hwirq_mask) == 0) {

If we read interrupt enable state from hardware, then reading the
software state (irqd_irq_disabled) is redundant.

>  		plic_toggle(handler, d->hwirq, 1);
>  		writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
>  		plic_toggle(handler, d->hwirq, 0);

I have no knowledge about affinity stuff, so I don't really understand this
patch. But there is another idea regarding this "ignored EOI" problem:
always "complete" the interrupt while enabling. That would move this extra
complication out of the hot path, and also looks simpler in my opinion.

Something like the patch below. Would this solve this "affinity problem"
too?

Best regards,
Nam

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 0a233e9d9607..63f2111ced4a 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -122,7 +122,15 @@ static inline void plic_irq_toggle(const struct cpumask *mask,
 
 static void plic_irq_enable(struct irq_data *d)
 {
+	struct plic_priv *priv = irq_data_get_irq_chip_data(d);
+
+	writel(0, priv->regs + PRIORITY_BASE + d->hwirq * PRIORITY_PER_ID);
+
+	writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
+
 	plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 1);
+
+	writel(1, priv->regs + PRIORITY_BASE + d->hwirq * PRIORITY_PER_ID);
 }
 
 static void plic_irq_disable(struct irq_data *d)
@@ -148,13 +156,7 @@ static void plic_irq_eoi(struct irq_data *d)
 {
 	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
 
-	if (unlikely(irqd_irq_disabled(d))) {
-		plic_toggle(handler, d->hwirq, 1);
-		writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
-		plic_toggle(handler, d->hwirq, 0);
-	} else {
-		writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
-	}
+	writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
 }
 
 #ifdef CONFIG_SMP

