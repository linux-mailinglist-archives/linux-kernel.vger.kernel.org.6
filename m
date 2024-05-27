Return-Path: <linux-kernel+bounces-190363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DF98CFD4A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D8421F2628C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AD413AA40;
	Mon, 27 May 2024 09:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QA1B3iuM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C6826AFA;
	Mon, 27 May 2024 09:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716802803; cv=none; b=ggUoYlkuvAEXV6EI8Ozo1REew4MtACr5K1bNbH6xSpLU+X0x8c33yujjTmnjZZ3tDiXElxiAu/Acxzqct6gxKAc5goVifFy1h8FTqebXQvqokzwvGHXJwWUFRn45wqqPOPuxtJzEGflJ93wt/28yj1JpFunC8LRsOyQDbI+lECw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716802803; c=relaxed/simple;
	bh=HnVmm+698RUzmkUl4MnUgvQ39GhxmP5FLl9/9HZ7s/4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XVaHXF2QfHhduVEkQwiVYPqM8LW4b/+/t2aTSTD/TENm1fai+ZkziUAy+oy/TANQxEsyyZmr/mE19RWF9W6pztfE5uvW+giyTtbmLTbh4eZpGidTR64tBHaI7pbmfrNmYAE3jbgbcWhFcWYxSSio/5Uukos/hNbORCft4J8nr1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QA1B3iuM; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716802800; x=1748338800;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=HnVmm+698RUzmkUl4MnUgvQ39GhxmP5FLl9/9HZ7s/4=;
  b=QA1B3iuM6oTpYFqzkR8XPHKZJTNy1E9KCdg9h2uqLIsuQsimbq/EmUym
   beDfR0Dp8Zx2tX4LlEw1+OtV8dTsHEbuU0ELWh5sJ69fyIeiHzmyeD9KC
   oh5H55jGauwNxdjJt7cFqaBB3uzdUlvkoEyltR8WvPth7mIF0fr9ePFk2
   AdMU2bdVZ3PtMur01zQsq3QLopLMPKrcGpY+ZGZsgCwExOvOFOypvKJf2
   /jyFZjms38d3dOgZ0ughpvsBJWHL7WtHm839tErl4ROTts8MF4eiuOWB7
   8XlgwlmIzIy8Us2hl4J0+NP+qKfdmym/dxtSocN4I/tgl6STaL7Z/e9sY
   w==;
X-CSE-ConnectionGUID: k8jmGt2ZQGKQAuJOEE0MTQ==
X-CSE-MsgGUID: ijG2ks9GSoi5A/Gf/ECLRQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="23676539"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="23676539"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 02:39:59 -0700
X-CSE-ConnectionGUID: +BLEuM0CSn6AYBs8YehL4g==
X-CSE-MsgGUID: A5dAA6iXSfSxBtmb2GpLZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="34792827"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.138])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 02:39:55 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 27 May 2024 12:39:51 +0300 (EEST)
To: Lyndon Sanche <lsanche@lyndeno.ca>
cc: mario.limonciello@amd.com, pali@kernel.org, W_Armin@gmx.de, 
    srinivas.pandruvada@linux.intel.com, lkp@intel.com, 
    Hans de Goede <hdegoede@redhat.com>, Yijun.Shen@dell.com, 
    Matthew Garrett <mjg59@srcf.ucam.org>, 
    Vegard Nossum <vegard.nossum@oracle.com>, Jonathan Corbet <corbet@lwn.net>, 
    Heiner Kallweit <hkallweit1@gmail.com>, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, 
    Dell.Client.Kernel@dell.com
Subject: Re: [PATCH v7 3/3] platform/x86: dell-pc: Implement
 platform_profile
In-Reply-To: <20240517224323.10045-4-lsanche@lyndeno.ca>
Message-ID: <c971cfae-e7d5-fbde-f77b-1a936c6e1ee7@linux.intel.com>
References: <20240425172758.67831-1-lsanche@lyndeno.ca> <20240517224323.10045-1-lsanche@lyndeno.ca> <20240517224323.10045-4-lsanche@lyndeno.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 17 May 2024, Lyndon Sanche wrote:

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
>  drivers/platform/x86/dell/dell-pc.c          | 310 +++++++++++++++++++
>  drivers/platform/x86/dell/dell-smbios-base.c |   1 +
>  drivers/platform/x86/dell/dell-smbios.h      |   1 +
>  6 files changed, 332 insertions(+)
>  create mode 100644 drivers/platform/x86/dell/dell-pc.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ebf03f5f0619..69c582b72a08 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5961,6 +5961,12 @@ F:	Documentation/ABI/obsolete/procfs-i8k
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
> index bd9f445974cc..0732850a3dd6 100644
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


> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/err.h>
> +#include <linux/dmi.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/platform_profile.h>
> +#include <linux/slab.h>
> +#include "dell-smbios.h"

Add empty line between <> and "" includes.

> +static const struct dmi_system_id dell_device_table[] __initconst = {
> +	{
> +		.ident = "Dell Inc.",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +		},
> +	},
> +	{
> +		.ident = "Dell Computer Corporation",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
> +		},
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(dmi, dell_device_table);

> +enum thermal_mode_bits {
> +	DELL_BALANCED = BIT(0),
> +	DELL_COOL_BOTTOM = BIT(1),
> +	DELL_QUIET = BIT(2),
> +	DELL_PERFORMANCE = BIT(3),

A few nits still to address.

Can you please align these so that the values align (IIRC, I asked this 
earlier but perhaps my request was too unclear):

	DELL_XX			= BIT(X),
	DELL_YYYYYYYYY		= BIT(Y),

> +static int thermal_get_supported_modes(int *supported_bits)
> +{
> +	struct calling_interface_buffer buffer;
> +	int ret;
> +
> +	dell_fill_request(&buffer, 0x0, 0, 0, 0);
> +	ret = dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEMENT);
> +	if (ret) {
> +		/* Thermal function not supported */
> +		if (ret == -ENXIO) {
> +			*supported_bits = 0;
> +			return 0;
> +		} else {

Drop else because the previous block ends into return.

> +			return ret;
> +		}
> +	}

Remove the outer if (ret) block and put the inner ones directly on the 
main level as two if () conditions.

> +	*supported_bits = FIELD_GET(DELL_THERMAL_SUPPORTED, buffer.output[1]);
> +	return 0;
> +}
> +
> +static int thermal_get_acc_mode(int *acc_mode)
> +{
> +	struct calling_interface_buffer buffer;
> +	int ret;
> +
> +	dell_fill_request(&buffer, 0x0, 0, 0, 0);
> +	ret = dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEMENT);
> +	if (ret)
> +		return ret;
> +	*acc_mode = FIELD_GET(DELL_ACC_GET_FIELD, buffer.output[3]);
> +	return 0;
> +}
> +
> +static int thermal_set_mode(enum thermal_mode_bits state)
> +{
> +	struct calling_interface_buffer buffer;
> +	int ret;
> +	int acc_mode;
> +
> +	ret = thermal_get_acc_mode(&acc_mode);
> +	if (ret)
> +		return ret;
> +
> +	dell_fill_request(&buffer, 0x1, FIELD_PREP(DELL_ACC_SET_FIELD, acc_mode) | state, 0, 0);
> +	ret = dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEMENT);
> +	return ret;

Return directly on the previous line.

> +static int thermal_platform_profile_get(struct platform_profile_handler *pprof,
> +					enum platform_profile_option *profile)
> +{
> +	int ret;
> +
> +	ret = thermal_get_mode();
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (ret) {
> +	case DELL_BALANCED:
> +		*profile = PLATFORM_PROFILE_BALANCED;
> +		break;
> +	case DELL_PERFORMANCE:
> +		*profile = PLATFORM_PROFILE_PERFORMANCE;
> +		break;
> +	case DELL_COOL_BOTTOM:
> +		*profile = PLATFORM_PROFILE_COOL;
> +		break;
> +	case DELL_QUIET:
> +		*profile = PLATFORM_PROFILE_QUIET;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int thermal_init(void)
> +{
> +	int ret;
> +	int supported_modes;
> +
> +	/* If thermal commands not supported, exit without error */

Fix grammar, you're perhaps missing "are".

> +	if (!dell_smbios_class_is_supported(CLASS_INFO))
> +		return 0;
> +
> +	/* If thermal modes not supported, exit without error */

Ditto.

-- 
 i.

