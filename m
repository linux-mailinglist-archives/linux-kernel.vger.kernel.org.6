Return-Path: <linux-kernel+bounces-447116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA7A9F2D8A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BEEA163776
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A905202C3A;
	Mon, 16 Dec 2024 09:56:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4A9202C38
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 09:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734342998; cv=none; b=px215ckkbJ7sTWdNhpEP2V82+ckkuAV/cW0NUoy/7gmA2nXIY4Fv5zRVvFBa8R84y43wdtA9mk7kM1McajQ9k2/uEOzOBYa6ObAP54ZLDE+8u241Tfv84QIwlCNPB5ZbaH3QeBemxXljtM7Txzckit6LFm1LAftRrPz8+4rRpFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734342998; c=relaxed/simple;
	bh=aEj/tEPFimDiql9OrT4C14tkZ0CGLwsMEiwFtKvo/vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVphcppS0vq7zhZ/VnZqSi0u7Vpd6fYjTNxvz2lAc2Xg+KTIQcmwfQqzTIfFLZ2LLdq54SH9uNDZYy7wnF1eZ8MGu27WqMBy+1ZeRcVq+VKOFrhGHsviZnISCQQA5+iU+EZN/UvoTX8IAyM2t5QHPLYlINyJxZlajK6TOzJ/FqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF870113E;
	Mon, 16 Dec 2024 01:57:02 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33B8E3F58B;
	Mon, 16 Dec 2024 01:56:33 -0800 (PST)
Date: Mon, 16 Dec 2024 09:56:30 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Kai-Heng Feng <kaihengf@nvidia.com>
Cc: Marc Zyngier <maz@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Carol Soto <csoto@nvidia.com>
Subject: Re: [PATCH] irqchip/gic-v3: Allow unused SGIs for drivers/modules
Message-ID: <Z1_5TjlvyZl5ynGz@bogus>
References: <20240813033925.925947-1-sdonthineni@nvidia.com>
 <86zfpgztmt.wl-maz@kernel.org>
 <Zrs2i9Iyrlqc-a4K@bogus>
 <1885f74b-5bfb-46a3-a65f-521d974d023f@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1885f74b-5bfb-46a3-a65f-521d974d023f@nvidia.com>

On Mon, Dec 16, 2024 at 10:25:29AM +0800, Kai-Heng Feng wrote:
> Hi Sudeep,
> 
> On 2024/8/13 6:33 PM, Sudeep Holla wrote:
> > On Tue, Aug 13, 2024 at 09:58:34AM +0100, Marc Zyngier wrote:
> > > On Tue, 13 Aug 2024 04:39:25 +0100,
> > > Shanker Donthineni <sdonthineni@nvidia.com> wrote:
> > > > 
> > > > The commit 897e9e60c016 ("firmware: arm_ffa: Initial support for scheduler
> > > > receiver interrupt") adds support for SGI interrupts in the FFA driver.
> > > > However, the validation for SGIs in the GICv3 is too strict, causing the
> > > > driver probe to fail.
> > > 
> > > It probably is a good thing that I wasn't on Cc for this patch,
> > > because I would have immediately NAK'd it. Sudeep, please consider
> > > this a retrospective NAK!
> > > 
> > 
> > Sure, I am happy to work on any suggestions to replace it with better/cleaner
> > solution.
> > 
> > > > 
> > > > This patch relaxes the SGI validation check, allowing callers to use SGIs
> > > > if the requested SGI number is greater than or equal to MAX_IPI, which
> > > > fixes the TFA driver probe failure.
> > > > 
> > > > This issue is observed on NVIDIA server platform with FFA-v1.1.
> > > >   [    7.918099] PTP clock support registered
> > > >   [    7.922110] EDAC MC: Ver: 3.0.0
> > > >   [    7.945063] ARM FF-A: Driver version 1.1
> > > >   [    7.949068] ARM FF-A: Firmware version 1.1 found
> > > >   [    7.977832] GICv3: [Firmware Bug]: Illegal GSI8 translation request
> > > >   [    7.984237] ARM FF-A: Failed to create IRQ mapping!
> > > >   [    7.989220] ARM FF-A: Notification setup failed -61, not enabled
> > > >   [    8.000198] ARM FF-A: Failed to register driver sched callback -95
> > > >   [    8.011322] scmi_core: SCMI protocol bus registered
> > > > 
> > > > Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
> > > > ---
> > > >   arch/arm64/include/asm/arch_gicv3.h | 17 +++++++++++++++++
> > > >   arch/arm64/kernel/smp.c             | 17 -----------------
> > > >   drivers/irqchip/irq-gic-v3.c        |  2 +-
> > > >   3 files changed, 18 insertions(+), 18 deletions(-)
> > > > 
> > > > diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
> > > > index 9e96f024b2f19..ecf81df2915c7 100644
> > > > --- a/arch/arm64/include/asm/arch_gicv3.h
> > > > +++ b/arch/arm64/include/asm/arch_gicv3.h
> > > > @@ -188,5 +188,22 @@ static inline bool gic_has_relaxed_pmr_sync(void)
> > > >   	return cpus_have_cap(ARM64_HAS_GIC_PRIO_RELAXED_SYNC);
> > > >   }
> > > > +enum ipi_msg_type {
> > > > +	IPI_RESCHEDULE,
> > > > +	IPI_CALL_FUNC,
> > > > +	IPI_CPU_STOP,
> > > > +	IPI_CPU_CRASH_STOP,
> > > > +	IPI_TIMER,
> > > > +	IPI_IRQ_WORK,
> > > > +	NR_IPI,
> > > > +	/*
> > > > +	 * Any enum >= NR_IPI and < MAX_IPI is special and not tracable
> > > > +	 * with trace_ipi_*
> > > > +	 */
> > > > +	IPI_CPU_BACKTRACE = NR_IPI,
> > > > +	IPI_KGDB_ROUNDUP,
> > > > +	MAX_IPI
> > > > +};
> > > > +
> > > >   #endif /* __ASSEMBLY__ */
> > > >   #endif /* __ASM_ARCH_GICV3_H */
> > > > diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> > > > index 5e18fbcee9a20..373cd815d9a43 100644
> > > > --- a/arch/arm64/kernel/smp.c
> > > > +++ b/arch/arm64/kernel/smp.c
> > > > @@ -64,23 +64,6 @@ struct secondary_data secondary_data;
> > > >   /* Number of CPUs which aren't online, but looping in kernel text. */
> > > >   static int cpus_stuck_in_kernel;
> > > > -enum ipi_msg_type {
> > > > -	IPI_RESCHEDULE,
> > > > -	IPI_CALL_FUNC,
> > > > -	IPI_CPU_STOP,
> > > > -	IPI_CPU_CRASH_STOP,
> > > > -	IPI_TIMER,
> > > > -	IPI_IRQ_WORK,
> > > > -	NR_IPI,
> > > > -	/*
> > > > -	 * Any enum >= NR_IPI and < MAX_IPI is special and not tracable
> > > > -	 * with trace_ipi_*
> > > > -	 */
> > > > -	IPI_CPU_BACKTRACE = NR_IPI,
> > > > -	IPI_KGDB_ROUNDUP,
> > > > -	MAX_IPI
> > > > -};
> > > > -
> > > >   static int ipi_irq_base __ro_after_init;
> > > >   static int nr_ipi __ro_after_init = NR_IPI;
> > > >   static struct irq_desc *ipi_desc[MAX_IPI] __ro_after_init;
> > > > diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> > > > index c19083bfb9432..0d2038d8cd311 100644
> > > > --- a/drivers/irqchip/irq-gic-v3.c
> > > > +++ b/drivers/irqchip/irq-gic-v3.c
> > > > @@ -1655,7 +1655,7 @@ static int gic_irq_domain_translate(struct irq_domain *d,
> > > >   		if(fwspec->param_count != 2)
> > > >   			return -EINVAL;
> > > > 
> > > > -		if (fwspec->param[0] < 16) {
> > > > +		if (fwspec->param[0] < MAX_IPI) {
> > > >   			pr_err(FW_BUG "Illegal GSI%d translation request\n",
> > > >   			       fwspec->param[0]);
> > > >   			return -EINVAL;
> > > 
> > > No. This is the wrong approach, and leads to inconsistent behaviour if
> > > we ever change this MAX_IPI value. It also breaks 32 bit builds, and
> > > makes things completely inconsistent between ACPI and DT.
> > > 
> > > I don't know how the FFA code was tested, because I cannot see how it
> > > can work.
> > > 
> > > *IF* we are going to allow random SGIs being requested by random
> > > drivers, we need to be able to do it properly. Not as a side hack like
> > > this.
> > 
> > I am open for any ideas as FF-A spec authors/architects decided to allow
> > secure world to donate one of its SGI to the normal world for FF-A
> > notifications.
> 
> Is there any progression on this issue? Do you think it's reasonable to
> revert commit 897e9e60c016 as a temporary measure?
> 

I haven't started on this yet, but I plan to do that in a week or so.
Revert may not be trivial at this point. We can disable it until it is
fixed properly instead of all possible conflicts with reverts.

-- 
Regards,
Sudeep

