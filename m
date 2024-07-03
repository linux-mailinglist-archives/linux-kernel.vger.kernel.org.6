Return-Path: <linux-kernel+bounces-239467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E555E92606B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B0DE287935
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCB0178CCD;
	Wed,  3 Jul 2024 12:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mfmP2bPK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ga+ErfbM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E1C176AA4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 12:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010015; cv=none; b=uy5OzbOFAVSJ8Y7VGYjlyEhXVVtToHCg/bC79KYF5IzRkyQ0mfNEoA6MYsX3uy9u6wEZbIKmyI+o/joF9E85vqHVKRCanHV8vlDNH+DdIibevNGgrQ/sPDm/tkrVbTUBJ7GaWsATbNZpAP5hDPEHdG4WwYikhLsNqHhhOuM0Oik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010015; c=relaxed/simple;
	bh=7nWZtJ4jUfhl4AZ06ZgpDta/MsU32ukhIMy8clmx4Jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ee9UK+zA/RjiJ7cf9ovP0lfxVUl8i5rF02RsBfJDh9fNfDrCOKzvv0+pqAT3ulUAj20SmoR2Wlglqt5MQ+7kxjoxDVEFzWRhoOQcvbIBmUWh7px/ES8oYJyUpEorW4EuNDgZ+XieQalaNyJVIhuoWTpiz3eYiu8feeEdKXS4Sn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mfmP2bPK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ga+ErfbM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 3 Jul 2024 14:33:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720010011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vDPoLxI9NH/aFITSbCBsDGXY1dOCvCtqoSXbykJCa0c=;
	b=mfmP2bPKHWJoowzLNkm74Vig2mbb+Vzj3OqMHpv4RhltkyCiL0P18PVWQcZMS46PnvM37W
	o1KwoOppFuvndqXeTilmxoVnsRoXt80g0CEk4a5w9twbgqVCFgn8JPZCC5YvWW8jPebnJP
	lO77aBCKWycybtBMtYCsN9w9ycnssi6tHnzYXfBuSReab9UDuoYQ2BaYmTVb77lWRJOj6u
	nIV3Vho0RFD42SmnY5CwBkXvv64NeGFDnZPQ1Ri+obumSWJquPaWdFd9HQL5ngRr82m4WF
	zdBOZAFelA7x+RyQPzjTFIe9BkflltEhgyrdIP66xhBchJDgyWNXLNFy24Qdpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720010011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vDPoLxI9NH/aFITSbCBsDGXY1dOCvCtqoSXbykJCa0c=;
	b=ga+ErfbMWebK9O1GxU2wc/vhhIwk8YtNz6H0DVC/gUeoNdMRrmGhvFx+6sQW1C6q9z6WkQ
	GQE5ko4H0HHy2lBw==
From: Nam Cao <namcao@linutronix.de>
To: Anup Patel <anup@brainfault.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	b.spranger@linutronix.de, Christoph Hellwig <hch@lst.de>,
	Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH] irqchip/sifive-plic: Fix plic_set_affinity() only
 enables 1 cpu
Message-ID: <20240703123327.CvOiP2Jb@linutronix.de>
References: <20240703072659.1427616-1-namcao@linutronix.de>
 <CAAhSdy0ZGD-p0iBVPqHF0RKTwvAAMWwYZ0ufioRrO75JzSh1qQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhSdy0ZGD-p0iBVPqHF0RKTwvAAMWwYZ0ufioRrO75JzSh1qQ@mail.gmail.com>

On Wed, Jul 03, 2024 at 05:28:23PM +0530, Anup Patel wrote:
> On Wed, Jul 3, 2024 at 12:57 PM Nam Cao <namcao@linutronix.de> wrote:
> >
> > plic_set_affinity() only enables interrupt for the first possible CPU in
> > the mask. The point is to prevent all CPUs trying to claim an interrupt,
> > but only one CPU succeeds and the other CPUs wasted some clock cycles for
> > nothing.
> >
> > However, there are two problems with that:
> > 1. Users cannot enable interrupt on multiple CPUs (for example, to minimize
> > interrupt latency).
> 
> Well, you are assuming that multiple CPUs are always idle or available
> to process interrupts. In other words, if the system is loaded running
> some workload on each CPU then performance on multiple CPUs
> will degrade since multiple CPUs will wastefully try to claim interrupt.
> 
> In reality, we can't make such assumptions and it is better to target a
> particular CPU for processing interrupts (just like various other interrupt
> controllers). For balancing interrupt processing load, we have software
> irq balancers running in user-space (or kernel space) which do a
> reasonably fine job of picking appropriate CPU for interrupt processing.

Then we should leave the job of distributing interrupts to those tools,
right? Not all use cases want minimally wasted CPU cycles. For example, if
a particular interrupt does not arrive very often, but when it does, it
needs to be handled fast; in this example, clearly enabling this interrupt
for all CPUs is superior.

But I am sure there are users who don't use something like irqbalance and
just let the system do the default behavior. So I see your point of not
wasting CPU cycles. So, how about we keep this patch, but also add a
"default policy" which evenly distributes the interrupts to individually
CPUs (best effort only). Something like the un-tested patch below?

Best regards,
Nam

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index f30bdb94ceeb..953f375835b0 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -312,7 +312,7 @@ static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
 	irq_domain_set_info(d, irq, hwirq, &plic_chip, d->host_data,
 			    handle_fasteoi_irq, NULL, NULL);
 	irq_set_noprobe(irq);
-	irq_set_affinity(irq, &priv->lmask);
+	irq_set_affinity(irq, cpumask_of(cpumask_any_distribute(&priv->lmask)));
 	return 0;
 }
 

