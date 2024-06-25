Return-Path: <linux-kernel+bounces-228996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D340C916983
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10366B224C6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DF9163A9B;
	Tue, 25 Jun 2024 13:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="rdoeJrgL"
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0957E17C98;
	Tue, 25 Jun 2024 13:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719323687; cv=none; b=aPBD5nf456HOfkORbNABT/6NsbyzHLqtdJCuRiBrc2an1XmJzlymyyo++tsyHnriekXpGDJgsU5bkENyl3ANdKUlU2i83zWaQkjBF2EuqQa8I9cpaY61K1OP4jLvoH6Z4LCMO6lbbPWA2KE2iAt2QeEQ5Qr3g2M7Es/X6fiC0dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719323687; c=relaxed/simple;
	bh=BZP7wIc5pf7C1Ls1gm5g1uqTHaYtrk/njLx/PYW/Qeg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdxML4v3tm9rlq2rdpgZAqa5tX7ZhhMbEeGyRRMb/qR33W3rav17PUt6OVyE8uE3LUcxLSxSMkdifJpdepV8MbG0smoUcPxauQOjyLNlY8wAnZh2v84CRWtD046UnLLScQOQ9CP8lhi+8IVwpsZxHVXKQmLO5WdAn3gH0WFG0rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=rdoeJrgL; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1719323686; x=1750859686;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oGCfWHyy2ugxDFebpY3wrACjPmfk419vbwqJZjgreDg=;
  b=rdoeJrgLexL9/Bd4mkxEcGKsAL9yG/+MCihdcfHgce8siK7beer/ZNHu
   H6mimKYM+D+ZFcyUNzQXTTc+j7HGgyt2Io+uMPzxlKN9VfLBimV/FtHV1
   onyypaJGA7x/XzQzkA7HTxkxz7PXFLwsNfA7fbfjz4PhYd1saUWYewsGq
   s=;
X-IronPort-AV: E=Sophos;i="6.08,264,1712620800"; 
   d="scan'208";a="410016268"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 13:54:42 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.17.79:57826]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.41.15:2525] with esmtp (Farcaster)
 id 5e7838ba-3b35-4f22-af46-8afabcdb3ea2; Tue, 25 Jun 2024 13:54:40 +0000 (UTC)
X-Farcaster-Flow-ID: 5e7838ba-3b35-4f22-af46-8afabcdb3ea2
Received: from EX19D033EUC004.ant.amazon.com (10.252.61.133) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 25 Jun 2024 13:54:37 +0000
Received: from u40bc5e070a0153.ant.amazon.com (10.106.82.20) by
 EX19D033EUC004.ant.amazon.com (10.252.61.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 25 Jun 2024 13:54:34 +0000
Date: Tue, 25 Jun 2024 15:54:28 +0200
From: Roman Kagan <rkagan@amazon.de>
To: Marc Zyngier <maz@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	<nh-open-source@amazon.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] irqchip/gicv3-its: Workaround for GIC-700 erratum 2195890
Message-ID: <ZnrMFIEyr8SKLDKk@u40bc5e070a0153.ant.amazon.com>
Mail-Followup-To: Roman Kagan <rkagan@amazon.de>,
	Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, nh-open-source@amazon.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Jonathan Corbet <corbet@lwn.net>
References: <20240624165541.1286227-1-rkagan@amazon.de>
 <86v81xif6l.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <86v81xif6l.wl-maz@kernel.org>
X-ClientProxiedBy: EX19D038UWB001.ant.amazon.com (10.13.139.148) To
 EX19D033EUC004.ant.amazon.com (10.252.61.133)

On Tue, Jun 25, 2024 at 09:45:22AM +0100, Marc Zyngier wrote:
> On Mon, 24 Jun 2024 17:55:41 +0100,
> Roman Kagan <rkagan@amazon.de> wrote:
> >
> > According to Arm CoreLink GIC-700 erratum 2195890, on GIC revisions
> > r0p0, r0p1, r1p0 under certain conditions LPIs may remain in the Pending
> > Table until one of a number of external events occurs.
> 
> Please add a link to the errata document.

https://developer.arm.com/documentation/SDEN-1769194/
Will include when respinning.

> >
> > No LPIs are lost but they may not be delivered in a finite time.
> >
> > The workaround is to issue an INV using GICR_INVLPIR to an unused, in
> > range LPI ID to retrigger the search.
> >
> > Add this workaround to the quirk table.  When the quirk is applicable,
> > carve out one LPI ID from the available range and run periodic work to
> > do INV to it, in order to prevent GIC from stalling.
> 
> The errata document says a lot more:
> 
> <quote>
> For physical LPIs the workaround is to issue an INV using GICR_INVLPIR
> to an unused, in range LPI ID to retrigger the search. This could be
> done periodically, for example, in line with a residency change, or as
> part of servicing LPIs.  If using LPIs as the event, then the
> GICR_INVLPIR write could be issued after servicing every LPI.
> 
> However, it only needs to be issued if:
> 
> * At least 4 interrupts in the block of 32 are enabled and mapped to
>   the current PE or, if easier,
> 
> * At least 4 interrupts in the block of 32 are enabled and mapped to
>   any PE
> </quote>

It didn't feel like worth optimizing for.  I'll reconsider.

> > TT: https://t.corp.amazon.com/D82032616
> 
> Gniii????

Indeed Q-/

> > Signed-off-by: Elad Rosner <eladros@amazon.com>
> > Signed-off-by: Mohamed Mediouni <mediou@amazon.com>
> > Signed-off-by: Roman Kagan <rkagan@amazon.de>
> 
> Who is the author?

Joint effort aka inherited ownership.  Will fix according to the
process doc.

> > +static void __maybe_unused its_quirk_gic700_2195890_work_handler(struct work_struct *work)
> > +{
> > +     int cpu;
> > +     void __iomem *rdbase;
> > +     u64 gicr_invlpir_val;
> > +
> > +     for_each_online_cpu(cpu) {
> 
> The errata document doesn't say that this need to happen for *every*
> RD. Can you please clarify this?

(Digging out a year-old comms with ARM)
> > In multi-chip GIC system, does this write have to happen in each
> > chip or would a write to a single GICR trigger the search in all
> > GICDs?
> The write needs to occur for each physical PE - in other words, to
> each individual GICR that the search needs to be re-triggered for.

> > +             raw_spin_lock(&gic_data_rdist_cpu(cpu)->rd_lock);
> > +             gic_write_lpir(gicr_invlpir_val, rdbase + GICR_INVLPIR);
> > +             raw_spin_unlock(&gic_data_rdist_cpu(cpu)->rd_lock);
> 
> No synchronisation? How is that supposed to work?
> 
> Also, if you need to dig into the internals of the driver, extract a
> helper from __direct_lpi_inv().

ACK

> > +     }
> > +
> > +     schedule_delayed_work(&its_quirk_gic700_2195890_data.work,
> > +             msecs_to_jiffies(ITS_QUIRK_GIC700_2195890_PERIOD_MSEC));
> 
> It would be pretty easy to detect whether an LPI was ack'ed since the
> last pass, and not issue the invalidate.

Makes sense, will look into it.

Overall, do you think this approach with a global work looping over cpus
is the right one, or we should better try and implement something
per-cpu?

> > +}
> > +
> > +static bool __maybe_unused its_enable_quirk_gic700_2195890(void *data)
> > +{
> > +     struct its_node *its = data;
> > +
> > +     if (its_quirk_gic700_2195890_data.lpi)
> > +             return true;
> > +
> > +     /*
> > +      * Use one LPI INTID from the start of the LPI range for GIC prodding,
> > +      * and make it unavailable for regular LPI use later.
> > +      */
> > +     its_quirk_gic700_2195890_data.lpi = lpi_id_base++;
> > +
> > +     INIT_DELAYED_WORK(&its_quirk_gic700_2195890_data.work,
> > +                       its_quirk_gic700_2195890_work_handler);
> > +     schedule_delayed_work(&its_quirk_gic700_2195890_data.work, 0);
> > +
> > +     return true;
> > +}
> 
> It is a bit odd to hook this on an ITS being probed when the ITS isn't
> really involved. Not a big deal, but a bit clumsy.

True, but the LPI allocation lives in this file so it looked easier to
wire it all up here.  Where do you think it's more appropriate?

> >  static const struct gic_quirk its_quirks[] = {
> >  #ifdef CONFIG_CAVIUM_ERRATUM_22375
> >       {
> > @@ -4822,6 +4879,17 @@ static const struct gic_quirk its_quirks[] = {
> >               .property = "dma-noncoherent",
> >               .init   = its_set_non_coherent,
> >       },
> > +#ifdef CONFIG_ARM64_ERRATUM_2195890
> > +     {
> > +             .desc   = "ITS: GIC-700 erratum 2195890",
> > +             /*
> > +              * Applies to r0p0, r0p1, r1p0: iidr_var(bits 16..19) == 0 or 1
> > +              */
> > +             .iidr   = 0x0400043b,
> > +             .mask   = 0xfffeffff,
> > +             .init   = its_enable_quirk_gic700_2195890,
> 
> This catches r0p0 and r1p0, but not r0p1 (you require that bits 15:12
> are 0).

Ouch, right.  Given the erratum exact wording

> Fault Status: Present in: r0p0, r0p1, r1p0 Fixed in: r2p0

I guess I should match everything below r2p0 and allow arbitrary bits
15:12 (i.e. set the third nibble in the mask to 0).

> Overall, this requires a bit of rework. Notably, this could be
> significantly relaxed to match the requirements of the published
> workaround.

Thanks for the propmpt review!  Will rework and respin.
Roman.



Amazon Web Services Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


