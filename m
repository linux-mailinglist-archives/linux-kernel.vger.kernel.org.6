Return-Path: <linux-kernel+bounces-515404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC88A36463
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4DB61709FC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D807A269AFC;
	Fri, 14 Feb 2025 17:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Amg8E2wk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AF2269AF6
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553606; cv=none; b=cBTbxMybkcbt6G/5Wat+fPh5hmClCDIvbZcLhz68w/XmgaWsPZU7mAZUc5Y7k19xmwBgoWfF4NWMAgrSGD6oRaL67qsqoyxNchltIhF+MEdp3M9bIdg8d8wnR6HGl3fRVx+AuzW9vnZuzFujwf7y6zHHrGgzV0+dElsVjGZnrug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553606; c=relaxed/simple;
	bh=ImR/H03Fz4Z1T2OIgnxXyz5cLfo4flLh8ujWylDSZOI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=O41U78yA72Ep1CWCKFbuVj/MPVSaA5IeIzIWHb+mTP8gPe1+AJw98z4mLM6Knriy7byn/WlAptx7H36gsG+wU6jAdfQdN2qtasoVEPqMP1MdwAaIBR1nr9fYQqvDbC1MTcDO3yoriMDnLD9N+RPoX8b4yIForCqzcl4/eIIlzUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Amg8E2wk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B756C4CED1;
	Fri, 14 Feb 2025 17:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739553605;
	bh=ImR/H03Fz4Z1T2OIgnxXyz5cLfo4flLh8ujWylDSZOI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Amg8E2wkP2edVPx90dl1V4QZWeCCFvQAnVtFuo5FdCOEeLORk9Sb92pwX/C0wqik+
	 epcIvD8Xb1cBdG6ZyGesb3tXveqGFWjCZc6zggt8QLa/E4IiqLn5c/+QpI1MKr6mW4
	 UfQziHO8zAiZuB9QiXjVFlb1P25DnYkaqOTycTzE9a2n+WqK1ouRIPtm/IXYsaUz6j
	 PM0Yyjl5hXpQE6MV6bUEguAx3GbgbiDXdtQtnadDJtSNXYwGWMY+2ThVvgNY0ObboC
	 mUjyXJg0bGstlcqz93a5xHioEwjt4V4Q9bROOqEq/Lo+MPD/ST/MBnJo3SMwEQP63N
	 gOPapvo3J6erA==
Date: Fri, 14 Feb 2025 11:20:02 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Roger Pau Monne <roger.pau@citrix.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: Re: [PATCH v2 1/3] xen/pci: do not register devices with segments >=
 0x10000
Message-ID: <20250214172002.GA157276@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250114103315.51328-2-roger.pau@citrix.com>

It looks like the convention for this file is to capitalize the
subject, e.g.,

  xen/pci: Do not register ...

On Tue, Jan 14, 2025 at 11:33:11AM +0100, Roger Pau Monne wrote:
> The current hypercall interface for doing PCI device operations always uses
> a segment field that has a 16 bit width.  However on Linux there are buses
> like VMD that hook up devices into the PCI hierarchy at segment >= 0x10000,
> after the maximum possible segment enumerated in ACPI.
> 
> Attempting to register or manage those devices with Xen would result in
> errors at best, or overlaps with existing devices living on the truncated
> equivalent segment values.  Note also that the VMD segment numbers are
> arbitrarily assigned by the OS, and hence there would need to be some
> negotiation between Xen and the OS to agree on how to enumerate VMD
> segments and devices behind them.
> 
> Skip notifying Xen about those devices.  Given how VMD bridges can
> multiplex interrupts on behalf of devices behind them there's no need for
> Xen to be aware of such devices for them to be usable by Linux.
> 
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> ---
> Changes since v1:
>  - Adjust commit message width to 75 columns.
>  - Expand commit message.
> ---
>  drivers/xen/pci.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/xen/pci.c b/drivers/xen/pci.c
> index 416f231809cb..08e82fd1263e 100644
> --- a/drivers/xen/pci.c
> +++ b/drivers/xen/pci.c
> @@ -43,6 +43,13 @@ static int xen_add_device(struct device *dev)
>  		pci_mcfg_reserved = true;
>  	}
>  #endif
> +

I think a brief comment here would be helpful so people don't have to
dig out the commit log to understand why this is invalid for Xen.

> +	if (pci_domain_nr(pci_dev->bus) >> 16) {
> +		dev_info(dev,
> +			 "not registering with Xen: invalid PCI segment\n");
> +		return 0;
> +	}
> +
>  	if (pci_seg_supported) {
>  		DEFINE_RAW_FLEX(struct physdev_pci_device_add, add, optarr, 1);
>  
> @@ -149,6 +156,12 @@ static int xen_remove_device(struct device *dev)
>  	int r;
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
>  
> +	if (pci_domain_nr(pci_dev->bus) >> 16) {
> +		dev_info(dev,
> +			 "not unregistering with Xen: invalid PCI segment\n");
> +		return 0;
> +	}
> +
>  	if (pci_seg_supported) {
>  		struct physdev_pci_device device = {
>  			.seg = pci_domain_nr(pci_dev->bus),
> @@ -182,6 +195,12 @@ int xen_reset_device(const struct pci_dev *dev)
>  		.flags = PCI_DEVICE_RESET_FLR,
>  	};
>  
> +	if (pci_domain_nr(dev->bus) >> 16) {
> +		dev_info(&dev->dev,
> +			 "unable to notify Xen of device reset: invalid PCI segment\n");
> +		return 0;
> +	}
> +
>  	return HYPERVISOR_physdev_op(PHYSDEVOP_pci_device_reset, &device);
>  }
>  EXPORT_SYMBOL_GPL(xen_reset_device);
> -- 
> 2.46.0
> 

