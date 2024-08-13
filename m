Return-Path: <linux-kernel+bounces-284564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD4F950283
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0578028377B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB01B18DF62;
	Tue, 13 Aug 2024 10:33:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12571208AD
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723545235; cv=none; b=WdtCIc6dkHzPJO0NA00XC2cEyO3ObjjbbluTJ9nEpwdKoRs5Hc9LUqQt0Lh0/c50Eb9T5xJUtobr8iN5VI7Esnpq8Q65FuF5klGi45aVP2OhOsr2AlAls83yCoH6pUVE9JdNIzTeK+kkBoqkECey+0yhe81IHCpiFnkKgz2HMpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723545235; c=relaxed/simple;
	bh=ghhay0nSTOR2VeeoKC6zV8Bsw0OP6qhUaCYCYxF+1Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INt5IoiY9kPg4swwVeu3QVCxIrx+8jyzkK71UgrQBOBr/LnKnYg2wU0exJDIuhyBAprXVw+XKUWADn97sEc5KvUDE8Y84zWE13W2zRhJlb4ITjG6IUE6dpx2rPGlAq1WOLlRzRfFGKZPCgsEtFqlMyIckYft22PMf8BB29rxnSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3410312FC;
	Tue, 13 Aug 2024 03:34:18 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D0F073F587;
	Tue, 13 Aug 2024 03:33:50 -0700 (PDT)
Date: Tue, 13 Aug 2024 11:33:47 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Shanker Donthineni <sdonthineni@nvidia.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Sudeep Holla <sudeep.holla@arm.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] irqchip/gic-v3: Allow unused SGIs for drivers/modules
Message-ID: <Zrs2i9Iyrlqc-a4K@bogus>
References: <20240813033925.925947-1-sdonthineni@nvidia.com>
 <86zfpgztmt.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86zfpgztmt.wl-maz@kernel.org>

On Tue, Aug 13, 2024 at 09:58:34AM +0100, Marc Zyngier wrote:
> On Tue, 13 Aug 2024 04:39:25 +0100,
> Shanker Donthineni <sdonthineni@nvidia.com> wrote:
> > 
> > The commit 897e9e60c016 ("firmware: arm_ffa: Initial support for scheduler
> > receiver interrupt") adds support for SGI interrupts in the FFA driver.
> > However, the validation for SGIs in the GICv3 is too strict, causing the
> > driver probe to fail.
> 
> It probably is a good thing that I wasn't on Cc for this patch,
> because I would have immediately NAK'd it. Sudeep, please consider
> this a retrospective NAK!
>

Sure, I am happy to work on any suggestions to replace it with better/cleaner
solution.

> > 
> > This patch relaxes the SGI validation check, allowing callers to use SGIs
> > if the requested SGI number is greater than or equal to MAX_IPI, which
> > fixes the TFA driver probe failure.
> > 
> > This issue is observed on NVIDIA server platform with FFA-v1.1.
> >  [    7.918099] PTP clock support registered
> >  [    7.922110] EDAC MC: Ver: 3.0.0
> >  [    7.945063] ARM FF-A: Driver version 1.1
> >  [    7.949068] ARM FF-A: Firmware version 1.1 found
> >  [    7.977832] GICv3: [Firmware Bug]: Illegal GSI8 translation request
> >  [    7.984237] ARM FF-A: Failed to create IRQ mapping!
> >  [    7.989220] ARM FF-A: Notification setup failed -61, not enabled
> >  [    8.000198] ARM FF-A: Failed to register driver sched callback -95
> >  [    8.011322] scmi_core: SCMI protocol bus registered
> > 
> > Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
> > ---
> >  arch/arm64/include/asm/arch_gicv3.h | 17 +++++++++++++++++
> >  arch/arm64/kernel/smp.c             | 17 -----------------
> >  drivers/irqchip/irq-gic-v3.c        |  2 +-
> >  3 files changed, 18 insertions(+), 18 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
> > index 9e96f024b2f19..ecf81df2915c7 100644
> > --- a/arch/arm64/include/asm/arch_gicv3.h
> > +++ b/arch/arm64/include/asm/arch_gicv3.h
> > @@ -188,5 +188,22 @@ static inline bool gic_has_relaxed_pmr_sync(void)
> >  	return cpus_have_cap(ARM64_HAS_GIC_PRIO_RELAXED_SYNC);
> >  }
> >  
> > +enum ipi_msg_type {
> > +	IPI_RESCHEDULE,
> > +	IPI_CALL_FUNC,
> > +	IPI_CPU_STOP,
> > +	IPI_CPU_CRASH_STOP,
> > +	IPI_TIMER,
> > +	IPI_IRQ_WORK,
> > +	NR_IPI,
> > +	/*
> > +	 * Any enum >= NR_IPI and < MAX_IPI is special and not tracable
> > +	 * with trace_ipi_*
> > +	 */
> > +	IPI_CPU_BACKTRACE = NR_IPI,
> > +	IPI_KGDB_ROUNDUP,
> > +	MAX_IPI
> > +};
> > +
> >  #endif /* __ASSEMBLY__ */
> >  #endif /* __ASM_ARCH_GICV3_H */
> > diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> > index 5e18fbcee9a20..373cd815d9a43 100644
> > --- a/arch/arm64/kernel/smp.c
> > +++ b/arch/arm64/kernel/smp.c
> > @@ -64,23 +64,6 @@ struct secondary_data secondary_data;
> >  /* Number of CPUs which aren't online, but looping in kernel text. */
> >  static int cpus_stuck_in_kernel;
> >  
> > -enum ipi_msg_type {
> > -	IPI_RESCHEDULE,
> > -	IPI_CALL_FUNC,
> > -	IPI_CPU_STOP,
> > -	IPI_CPU_CRASH_STOP,
> > -	IPI_TIMER,
> > -	IPI_IRQ_WORK,
> > -	NR_IPI,
> > -	/*
> > -	 * Any enum >= NR_IPI and < MAX_IPI is special and not tracable
> > -	 * with trace_ipi_*
> > -	 */
> > -	IPI_CPU_BACKTRACE = NR_IPI,
> > -	IPI_KGDB_ROUNDUP,
> > -	MAX_IPI
> > -};
> > -
> >  static int ipi_irq_base __ro_after_init;
> >  static int nr_ipi __ro_after_init = NR_IPI;
> >  static struct irq_desc *ipi_desc[MAX_IPI] __ro_after_init;
> > diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> > index c19083bfb9432..0d2038d8cd311 100644
> > --- a/drivers/irqchip/irq-gic-v3.c
> > +++ b/drivers/irqchip/irq-gic-v3.c
> > @@ -1655,7 +1655,7 @@ static int gic_irq_domain_translate(struct irq_domain *d,
> >  		if(fwspec->param_count != 2)
> >  			return -EINVAL;
> >
> > -		if (fwspec->param[0] < 16) {
> > +		if (fwspec->param[0] < MAX_IPI) {
> >  			pr_err(FW_BUG "Illegal GSI%d translation request\n",
> >  			       fwspec->param[0]);
> >  			return -EINVAL;
>
> No. This is the wrong approach, and leads to inconsistent behaviour if
> we ever change this MAX_IPI value. It also breaks 32 bit builds, and
> makes things completely inconsistent between ACPI and DT.
>
> I don't know how the FFA code was tested, because I cannot see how it
> can work.
>
> *IF* we are going to allow random SGIs being requested by random
> drivers, we need to be able to do it properly. Not as a side hack like
> this.

I am open for any ideas as FF-A spec authors/architects decided to allow
secure world to donate one of its SGI to the normal world for FF-A
notifications.

--
Regards,
Sudeep

