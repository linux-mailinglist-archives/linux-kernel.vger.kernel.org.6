Return-Path: <linux-kernel+bounces-533942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DEEA46095
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDBE71897000
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245DD21930F;
	Wed, 26 Feb 2025 13:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qc+h+CDs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DAF258CCB
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740576042; cv=none; b=KEumx8Fx4x6uKL8gMDO6SLMrnvbSaIbKW0oLmzQto7NqO3ifZWJKHirlf5vVLV3a2yGP8Rgl+3wDvsSGaT9hkX64u/93D2TzJmZP9d1WJCLjkiyuoaGqD+qLal/Wy8JSHDyWmiWdIix6WF1Uy3v572IiOW0KkFLhhssGEOp/u4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740576042; c=relaxed/simple;
	bh=6BfjhoH6aMczwqZo8UAT1FQGa8zCOkTocnreQlptzQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FS1bZwD6xLhCb9Pn06hKJ+OFzKrU4SziGyutr8FrQNvhk/YwEiV7apkJyVHBcU0R1D7MlD58JM45AwdDN0lcHw46zBVcQ+++exqN9kQit2/W6jD/cFI1j2mDkWTiVVnL1aDK9jQYBcin+Y1EcThIE51cOU76kstUK+BpyqGMpCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qc+h+CDs; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740576041; x=1772112041;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6BfjhoH6aMczwqZo8UAT1FQGa8zCOkTocnreQlptzQs=;
  b=Qc+h+CDsecvjMXqOQTi7Q2Rcl2oDd9gBeBCqA4psDdnWicoryXhEqB9p
   7jCy1k0X+CKeadMcHx0a1BjzcxV+qCktvyW6V5YDJrtrw3ar4e660F24J
   wneUx3w53HGPykEJmPmJE1oYYrxtP9q2HTwTauBEIVSMxGdr266RAIuvr
   9DseV6QxMoEbP7DDkJmpyEgqvdl26LW1MRPFjQk6ijY/rQQJFFn4eqgg4
   S2HflOBZ4NCLMuZXpYY/k4mAaa3/aNsxeAs8ve6TpbCwzLhvOTCJuMU/Z
   nbn3azvXKtDuEqtZPB0bkUwQLLH33A/2vP4pBEzzldjMtf4uYUT8AsxlQ
   Q==;
X-CSE-ConnectionGUID: nnGMhUEbSoywOTeHuVygMg==
X-CSE-MsgGUID: YnhILkRFQB65gguGCp9mpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="52053228"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="52053228"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 05:20:40 -0800
X-CSE-ConnectionGUID: qR2OMIfjSoyUr7+IyJ0Lsg==
X-CSE-MsgGUID: Gx2deoTQSQWVcP7H42l0GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117194353"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 05:20:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tnHL1-0000000FKgo-09t8;
	Wed, 26 Feb 2025 15:20:35 +0200
Date: Wed, 26 Feb 2025 15:20:34 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: lee@kernel.org, giometti@enneenne.com, gregkh@linuxfoundation.org,
	raymond.tan@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/4] mfd: intel-ehl: Introduce Intel Elkhart Lake PSE
 GPIO and TIO
Message-ID: <Z78VIjgkzf_GlauU@smile.fi.intel.com>
References: <20250226061527.3031250-1-raag.jadav@intel.com>
 <20250226061527.3031250-5-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226061527.3031250-5-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 26, 2025 at 11:45:27AM +0530, Raag Jadav wrote:
> Intel Elkhart Lake Programmable Service Engine (PSE) includes two PCI
> devices that expose two different capabilities of GPIO and Timed I/O
> as a single PCI function through shared MMIO.

...

> +config MFD_INTEL_EHL_PSE_GPIO
> +	tristate "Intel Elkhart Lake PSE GPIO MFD"
> +	depends on PCI && (X86 || COMPILE_TEST)
> +	select MFD_CORE
> +	help
> +	  This MFD provides support for GPIO and TIO that exist on Intel
> +	  Elkhart Lake PSE as a single PCI device. It splits the two I/O
> +	  devices to their respective I/O drivers.

Can you add a module name here?

...

> +++ b/drivers/mfd/intel-ehl-gpio.c

We are usually align the file name and Kconfig option, and I like Kconfig
choice, so intel_ehl_pse_gpio.c (also note the style with other intel_$SOC_*
files in the folder.

...

> +#include <linux/array_size.h>
> +#include <linux/ioport.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pci.h>

+ stddef.h // for NULL

...

> +	return mfd_add_devices(&pci->dev, PLATFORM_DEVID_AUTO, ehl_pse_gpio_devs,
> +			       ARRAY_SIZE(ehl_pse_gpio_devs), &pci->resource[0],

We have a helper pci_resource_n().

> +			       pci_irq_vector(pci, 0), NULL);

-- 
With Best Regards,
Andy Shevchenko



