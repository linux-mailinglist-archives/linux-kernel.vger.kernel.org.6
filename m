Return-Path: <linux-kernel+bounces-256072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B28BA9348A8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67DEE1F22205
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 07:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8F2745CB;
	Thu, 18 Jul 2024 07:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSEiit4q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC5A487A5
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 07:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721287201; cv=none; b=DlPtvm8BB7ZVCkUD4HmHnnpEa1Fohcw4RGeoAQP9NkQM7d3bNVI4oBd9NHXRXXmBR9KQibl5pw1bsxBCsCWfgerkDza7BGK0i69x/FgtvETdYBSL8R6RAUPaGoUDRXkD1QQk4VoejvyTGAP1dWafemPu+hwpGkfRls7aezN9b5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721287201; c=relaxed/simple;
	bh=mUNyAVXTHaeweTwKXTUMP8K2f4gS8rET1vARTXK7EFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jasae7GA7H2fri1tkpLViZqiWbqQn9vfzOpCZkW8rxbkluQ5oyni/0C2ZVmO4iARdOEmwajq1EI2O96gNZQn3FY5ONm3jHdb5DMJ4vV4a0Kbz0SLlsXiB/LQGZtCECFNV/CfWX+RVEjSfpbaIwdqr2jkpc5+S4oscN8R7b9Q/O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSEiit4q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04399C116B1;
	Thu, 18 Jul 2024 07:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721287201;
	bh=mUNyAVXTHaeweTwKXTUMP8K2f4gS8rET1vARTXK7EFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VSEiit4qKsC1okLufvCfWt2DfetfqNbp+A0pYZxdaAF1lh19XFXaUMdbhead0uJ/j
	 aA8tHubjVnbcJm6Bvlo72lIKUVDfb0e3Tzv6xKbnV6OMRquLn3QbAEn9kzzqR8EfHX
	 K0FecPkbh2hwoXj10+GirXNQSAyFbrtywXglZBIrX0OVpMXuoRrMphNP5TsqGKZ1e8
	 lKBZZtM3a0IaooYsRLKn3QlHBfetrRj0Kyr7eU+yh0UYj9RxbQE1pGyNRSc4O0vNG9
	 2KB3DffI06hN7VmfpMc1CJgP7k6yaF92Cn2rmZTaxQeh/wopayrUKWD54wyT+wSaw3
	 Vkk7FnFlVWgHQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sULQq-0000000042j-2pGT;
	Thu, 18 Jul 2024 09:20:05 +0200
Date: Thu, 18 Jul 2024 09:20:04 +0200
From: Johan Hovold <johan@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] irqchip/gic-v3-its: Correctly honor the RID remapping
Message-ID: <ZpjCJLH3EEUELS2n@hovoldconsulting.com>
References: <20240717195937.2240400-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717195937.2240400-1-maz@kernel.org>

On Wed, Jul 17, 2024 at 08:59:37PM +0100, Marc Zyngier wrote:
> Since 6adb35ff43a16 ("irqchip/gic-v3-its: Provide MSI parent for
> PCI/MSI[-X]"), the primary domain a PCI device allocates its interrupts
> from is the one that is directly attached to the device itself.
> 
> By virtue of being a PCI device, it has no OF node.
> 
> This domain is (through more layer than it is worth describing)
> passed to its_pci_msi_prepare(), which tries to compute the
> full RID that is presented to the ITS by the device. This is ultimately
> done by calling pci_msi_domain_get_msi_rid(), passing both the
> domain and the PCI device as arguments.
> 
> The baked-in assumption is that either the domain that is passed
> to pci_msi_domain_get_msi_rid() describes an interrupt controller
> with either an OF node or an entry in an ACPI IORT table.
> In our case, it is *neither*. This domain is does not represent

nit: stray "is"

> anything firmware-based, but just an allocation unit for the device.
> 
> As a result, we fail to provide the full RID (which requires inspecting
> the msi-map/msi-mask properties in the DT), and stick to the BDF,
> which isn't very useful.
> 
> Tragedy follows with a litany of devices that randomly die as
> they fail to see any MSI (because the RID is wrong) or fail to
> get an allocation (because they try to steal LPIs from their
> neighbour's pool).
> 
> This will happen on any system where a single ITS is shared by
> multiple root ports and end-points with overlapping BDF numbers,
> and has the topology described in the device-tree.  Simpler DT
> topologies will luckily work, and so will ACPI-based systems.
> 
> Solve it by pointing pci_msi_domain_get_msi_rid() at the *parent*
> domain, which is the ITS, resulting in a correct mapping and a
> restored happiness in my personal zoo.
> 
> Fixes: 6adb35ff43a16 ("irqchip/gic-v3-its: Provide MSI parent for PCI/MSI[-X]")
> Reported-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>

This fixes the regression for the Qualcomm machines I ran into this
with:

Tested-by: Johan Hovold <johan+linaro@kernel.org>

Thanks!

Johan

