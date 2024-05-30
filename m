Return-Path: <linux-kernel+bounces-195078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D898D4751
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 10:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E73B01F21AFA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 08:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9812C1761AD;
	Thu, 30 May 2024 08:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NJIGStRC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568AC17618F;
	Thu, 30 May 2024 08:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717058378; cv=none; b=KrhvlnIlotMI9r0zB5kzbNZxROsCEBqj6X9SOeg/SsxhHMaypTdgZOntesziLdpwq5hQPOsOCCVTEWZDdAffuvajaxLOwuKLJTWjbEQg6UBjt6nXBrwBofsjXZ2COqm/2siD1GC+8A5gQbGNjrdt+IqB7GmMZBW8jsQzH98nzxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717058378; c=relaxed/simple;
	bh=+6wqFV+fVmgT6YJ8xvq3emSM9txSCJKU/7cgriphvwA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=c4WyVpUAx7N67C1jWxlQEijM2/rBBWhkOvLaudwZ6MtUg+j4wOXcFXoAqIv04W54SKSip7KSceD0EeMEuRg7mJtHFTnMvl4Qd8oWyiQPhcAj4sQ6RtLXE0A8y7VmvjTAbPxsRY9cvS/L4ZHtVhbiCm9GlATdbYvPUNE/cKVS8Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NJIGStRC; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717058377; x=1748594377;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+6wqFV+fVmgT6YJ8xvq3emSM9txSCJKU/7cgriphvwA=;
  b=NJIGStRCyiUObcSI6VtmGxtzAW95bLeKwLysZHjxGDtwWESe8tq7NNNb
   BWu9qQur2LNGJxuHTm2jQ5qS+gRRF2WfzOLgtF25SsA+y+RS03oUyKQNa
   ZIHvNorUUHkufvxTFel31JP7RLGzjFKq2zFYgGvKblU9wtllU1Iq2geTL
   Gj5Smg5fNwIP8w16oRVmDZu9nOvhP9rzwEC8fZlVPeDC62PuvVcI5+WHe
   fnfquJmyGr17F2r1Jz02K068LnFwR669ztHH1IVihl+fH06MnhS185KsN
   4TdrHzZaY5MmDXpvEiASD0aJMLF0Efmokpb+zFTF+/kbQ55TBKQCXmj1I
   w==;
X-CSE-ConnectionGUID: Sm4Rzu91T96xeqFyd4MbVg==
X-CSE-MsgGUID: 4MFxCdhlQ7CmwFyBzgU89A==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13684370"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="13684370"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 01:39:37 -0700
X-CSE-ConnectionGUID: A/hUfKVDQdOZXjpD85tTIA==
X-CSE-MsgGUID: rFPcwyvNToqyHguBiDrLrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="66937674"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.150])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 01:39:32 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 30 May 2024 11:39:27 +0300 (EEST)
To: Lyndon Sanche <lsanche@lyndeno.ca>
cc: mario.limonciello@amd.com, pali@kernel.org, W_Armin@gmx.de, 
    srinivas.pandruvada@linux.intel.com, lkp@intel.com, 
    Hans de Goede <hdegoede@redhat.com>, Yijun.Shen@dell.com, 
    Matthew Garrett <mjg59@srcf.ucam.org>, 
    Vegard Nossum <vegard.nossum@oracle.com>, 
    AceLan Kao <acelan.kao@canonical.com>, 
    Heiner Kallweit <hkallweit1@gmail.com>, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, 
    Dell.Client.Kernel@dell.com
Subject: Re: [PATCH v8 3/3] platform/x86: dell-pc: Implement
 platform_profile
In-Reply-To: <20240529174843.13226-4-lsanche@lyndeno.ca>
Message-ID: <db3191b5-2f42-5075-a493-dedb34e578ad@linux.intel.com>
References: <20240425172758.67831-1-lsanche@lyndeno.ca> <20240529174843.13226-1-lsanche@lyndeno.ca> <20240529174843.13226-4-lsanche@lyndeno.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 29 May 2024, Lyndon Sanche wrote:

> Some Dell laptops support configuration of preset fan modes through
> smbios tables.
> 
> If the platform supports these fan modes, set up platform_profile to
> change these modes. If not supported, skip enabling platform_profile.
> 
> Signed-off-by: Lyndon Sanche <lsanche@lyndeno.ca>
> ---
>  MAINTAINERS                                  |   6 +
>  drivers/platform/x86/dell/Kconfig            |  13 +
>  drivers/platform/x86/dell/Makefile           |   1 +
>  drivers/platform/x86/dell/dell-pc.c          | 307 +++++++++++++++++++
>  drivers/platform/x86/dell/dell-smbios-base.c |   1 +
>  drivers/platform/x86/dell/dell-smbios.h      |   1 +
>  6 files changed, 329 insertions(+)
>  create mode 100644 drivers/platform/x86/dell/dell-pc.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d6c90161c7bf..09ff0dfd65cb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6116,6 +6116,12 @@ F:	Documentation/ABI/obsolete/procfs-i8k
>  F:	drivers/hwmon/dell-smm-hwmon.c
>  F:	include/uapi/linux/i8k.h
>  
> +DELL PC DRIVER
> +M:	Lyndon Sanche <lsanche@lyndeno.ca>
> +L:	platform-driver-x86@vger.kernel.org
> +S:	Maintained
> +F:	drivers/platform/x86/dell/dell-pc.c
> +
>  DELL REMOTE BIOS UPDATE DRIVER
>  M:	Stuart Hayes <stuart.w.hayes@gmail.com>
>  L:	platform-driver-x86@vger.kernel.org
> diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/dell/Kconfig
> index 195a8bf532cc..85a78ef91182 100644
> --- a/drivers/platform/x86/dell/Kconfig
> +++ b/drivers/platform/x86/dell/Kconfig
> @@ -91,6 +91,19 @@ config DELL_RBTN
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called dell-rbtn.
>  
> +config DELL_PC
> +	tristate "Dell PC Extras"
> +	default m
> +	depends on ACPI
> +	depends on DMI
> +	depends on DELL_SMBIOS
> +	select ACPI_PLATFORM_PROFILE
> +	help
> +	This driver adds support for controlling the fan modes via platform_profile
> +	on supported Dell systems regardless of formfactor.
> +	Module will simply do nothing if thermal management commands are not
> +	supported.
> +
>  #
>  # The DELL_SMBIOS driver depends on ACPI_WMI and/or DCDBAS if those
>  # backends are selected. The "depends" line prevents a configuration
> diff --git a/drivers/platform/x86/dell/Makefile b/drivers/platform/x86/dell/Makefile
> index 8176a257d9c3..79d60f1bf4c1 100644
> --- a/drivers/platform/x86/dell/Makefile
> +++ b/drivers/platform/x86/dell/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_DCDBAS)			+= dcdbas.o
>  obj-$(CONFIG_DELL_LAPTOP)		+= dell-laptop.o
>  obj-$(CONFIG_DELL_RBTN)			+= dell-rbtn.o
>  obj-$(CONFIG_DELL_RBU)			+= dell_rbu.o
> +obj-$(CONFIG_DELL_PC)			+= dell-pc.o
>  obj-$(CONFIG_DELL_SMBIOS)		+= dell-smbios.o
>  dell-smbios-objs			:= dell-smbios-base.o
>  dell-smbios-$(CONFIG_DELL_SMBIOS_WMI)	+= dell-smbios-wmi.o
> diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
> new file mode 100644
> index 000000000000..a86ad921d4ee
> --- /dev/null
> +++ b/drivers/platform/x86/dell/dell-pc.c
> @@ -0,0 +1,307 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + *  Driver for Dell laptop extras
> + *
> + *  Copyright (c) Lyndon Sanche <lsanche@lyndeno.ca>
> + *
> + *  Based on documentation in the libsmbios package:
> + *  Copyright (C) 2005-2014 Dell Inc.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/err.h>
> +#include <linux/dmi.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/platform_profile.h>
> +#include <linux/slab.h>

Thanks for the update. I've now applied this into review-ilpo branch.

I reordered those headers into alphabetical order while applying. In 
future, when adding new headers, try adhere to the alphabetical order.

-- 
 i.


