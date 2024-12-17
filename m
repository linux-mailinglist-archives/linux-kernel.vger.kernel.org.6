Return-Path: <linux-kernel+bounces-449850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D9B9F56E9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 20:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CE74188C8E6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 19:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114371F1917;
	Tue, 17 Dec 2024 19:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onEg18Nn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB2A1F755F
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 19:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734463982; cv=none; b=HXySjSij+Sys33UY2IuoJCW65XldngJrmYQrN3g4bMxRbxJmAeXoSn4Em39uYeMDL313QzkLoUJi8MdfpI8BePi2yu00LU89c94ZC9mWy6WgoOCPNX6G51nfoxUYrjaAHDUwltTXPpV/kl7ShBVRhRvA+vDtSJdJ/JtpF6Im+hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734463982; c=relaxed/simple;
	bh=e2YrZjLArluhmb8+JmMfiPXk/JLNW/aRP3FmZIUVljk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDUNfGSG4ByRgSzQu7saI9+NNyTXcTPbSTc9BiHjK0wNU7aJXOPZq4hZxidGVfiaK05cn4b+l14RpXHKuqzD/IJkPm2hG3Yz1Yb0g57COMsOcPhQA58PlC5yu2qJ2Amt396N5oOh9BWoHIrNgv0FZPjRnGUDphUM8H2yjouxy2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onEg18Nn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CACA2C4CED3;
	Tue, 17 Dec 2024 19:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734463982;
	bh=e2YrZjLArluhmb8+JmMfiPXk/JLNW/aRP3FmZIUVljk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=onEg18NnIHYtiWfTHILeCluApxvZAfPtzdGciRVXOrRipoQMB3XejoCjuGCsXA29x
	 ILoZlaytP0BWI0kWHB13npVrGyIzywmrIhy08Dz/ktRo2eIfQfGklAdUD7fJn59Ts1
	 4tebtZviBbY2EtbRdz1v2Tmtm0Y5V+Y3mcFsJM2lAskKHd8e+uQJQOWzRXtaeeaXAX
	 XAVc+RE461DjdFW4pl1kUKKHMqIUVMrcHQ+028/Ce88ZGDyN4+WBKJlBna3DoE4b8s
	 IAvc7fepjvyMaNsdcuR0o7e12uAXs6jEVOh1FU4gXfG87mPEd92kBAXRBNOSeWZyfM
	 q5Z071bZumyyg==
Date: Tue, 17 Dec 2024 19:33:00 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	Anup Patel <apatel@ventanamicro.com>, Wei Liu <wei.liu@kernel.org>,
	Steve Wahl <steve.wahl@hpe.com>, Joerg Roedel <joro@8bytes.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Juergen Gross <jgross@suse.com>, Vineet Gupta <vgupta@kernel.org>,
	Brian Cain <bcain@quicinc.com>
Subject: Re: [patch 4/5] x86/apic: Convert to IRQCHIP_MOVE_DEFERRED
Message-ID: <Z2HR7BAP1pFY5PDD@liuwe-devbox-debian-v2>
References: <20241210102148.760383417@linutronix.de>
 <20241210103335.563277044@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210103335.563277044@linutronix.de>

On Tue, Dec 10, 2024 at 11:34:15AM +0100, Thomas Gleixner wrote:
> Instead of marking individual interrupts as safe to be migrated in
> arbitrary contexts, mark the interrupt chips, which require the interrupt
> to be moved in actual interrupt context, with the new IRQCHIP_MOVE_DEFERRED
> flag. This makes more sense because this is a per interrupt chip property
> and not restricted to individual interrupts.
> 
> That flips the logic from the historical opt-out to a opt-in model. This is
> simpler to handle for other architectures, which default to unrestricted
> affinity setting. It also allows to cleanup the redundant core logic
> significantly.
> 
> All interrupt chips, which belong to a top-level domain sitting directly on
> top of the x86 vector domain are marked accordingly, unless the related
> setup code marks the interrupts with IRQ_MOVE_PCNTXT, i.e. XEN.
> 
> No functional change intended.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[...]
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -2053,6 +2053,7 @@ static struct irq_chip hv_msi_irq_chip =
>  	.irq_set_affinity	= irq_chip_set_affinity_parent,
>  #ifdef CONFIG_X86
>  	.irq_ack		= irq_chip_ack_parent,
> +	.flags			= IRQCHIP_MOVE_DEFERRED,
>  #elif defined(CONFIG_ARM64)
>  	.irq_eoi		= irq_chip_eoi_parent,
>  #endif

Acked-by: Wei Liu <wei.liu@kernel.org>

