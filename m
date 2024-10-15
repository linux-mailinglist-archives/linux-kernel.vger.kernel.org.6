Return-Path: <linux-kernel+bounces-365342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE06A99E0D9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2648CB25094
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AEB1D0B91;
	Tue, 15 Oct 2024 08:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j8rNIhzv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B771C68AA;
	Tue, 15 Oct 2024 08:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728980465; cv=none; b=MiNkR5uut6ol5McatbAEAVBLOtEOscUtzwuul/ZwPWkEwJuUJppCH/ZB19aw4x982Vr5YZY/NmZQhU71Go4M7r5h6970Ew0jSftGjKHYBVanT8FRDC/nfa4HE36V3bwQe45ywaCUIwf3sRIvR6fUcgWhixj/Fsr/IU7C0KEFIks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728980465; c=relaxed/simple;
	bh=jQONjEO3Dvgc9q9uTAPqUYVLyxVvsquQ1uaea/VM9QY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=M7wwxBzChxf6sC0DGNUCcWn0qEirlS/tFp5xZSr0Q+33p3/hCvlQEElEQ5Xa81Q1EeN0aB9IaYid3Qv9Ryy48oKyG51LRFXppLSKO9jYWDJdyLNzoOtUsdVO2+/+wbgR5GM038te21r0fHozcaabwyPNPdCf/PyXpFrmK/Nw138=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j8rNIhzv; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728980465; x=1760516465;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=jQONjEO3Dvgc9q9uTAPqUYVLyxVvsquQ1uaea/VM9QY=;
  b=j8rNIhzvbAh2tBNeILYkUiiJRWX3P6hFg6yxSfo5YzUQ4Z14Ut0xvjBf
   GBRM1lvsQ3MBIw5P1l1OetG5L9ulYZ0wrY+jVtdJA2yx+Rtj71DQxOXi3
   oeGMqIYgVdcg94xYzppEXgaV9Bee8bFLKPLVfOVYXwo7ublHfe5vNgz2F
   MMIwBeI76Z4qZzc0RSSbFoweUyoSpMNEwGhoymIk6Z3k0jzfAfaFGxeq6
   nVGzGvHoJu/nCWcoaqwuXlBqYuWMOiVVtSaoLY6lfDbBJtAnNPLu27Flx
   4DnKWz4gNnjoqszXtE/bgh7bmUPbW6ysq+0z6doOVn9X71DAMZDyjaSBl
   Q==;
X-CSE-ConnectionGUID: p1BOMSWuQ2yCKtb4ss7dUg==
X-CSE-MsgGUID: HM7fEz+fSsmKEzf0qjDNOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="45831188"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="45831188"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 01:21:04 -0700
X-CSE-ConnectionGUID: AMKXXzI1R1uF3cgCdLgJvg==
X-CSE-MsgGUID: YVtNiue1QmOGgHguPnKJdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="77763195"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.12])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 01:21:01 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 15 Oct 2024 11:20:58 +0300 (EEST)
To: Kurt Borja <kuurtb@gmail.com>
cc: Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v5 3/4] alienware-wmi: added platform profile support
In-Reply-To: <20241012020237.20057-2-kuurtb@gmail.com>
Message-ID: <9a2ce7a9-9c8c-4279-aa9c-de9fa879f38b@linux.intel.com>
References: <20241012015849.19036-3-kuurtb@gmail.com> <20241012020237.20057-2-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 11 Oct 2024, Kurt Borja wrote:

> Implements platform profile support for Dell laptops with new WMAX
> thermal interface, present on some Alienware X-Series, Alienware
> M-Series and Dell's G-Series laptops. This implementation supports two
> sets of thermal profile codes, namely *thermal* and *thermal_ustt*, plus
> additional quirk *gmode* for Dell's G-Series laptops.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>  drivers/platform/x86/dell/Kconfig         |   1 +
>  drivers/platform/x86/dell/alienware-wmi.c | 236 ++++++++++++++++++++++
>  2 files changed, 237 insertions(+)
> 
> diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/dell/Kconfig
> index 68a49788a..b06d634cd 100644
> --- a/drivers/platform/x86/dell/Kconfig
> +++ b/drivers/platform/x86/dell/Kconfig
> @@ -21,6 +21,7 @@ config ALIENWARE_WMI
>  	depends on LEDS_CLASS
>  	depends on NEW_LEDS
>  	depends on ACPI_WMI
> +	select ACPI_PLATFORM_PROFILE
>  	help
>  	 This is a driver for controlling Alienware BIOS driven
>  	 features.  It exposes an interface for controlling the AlienFX
> diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
> index b27f3b64c..6e30e9376 100644
> --- a/drivers/platform/x86/dell/alienware-wmi.c
> +++ b/drivers/platform/x86/dell/alienware-wmi.c
> @@ -8,8 +8,11 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <linux/acpi.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/platform_profile.h>
>  #include <linux/dmi.h>
>  #include <linux/leds.h>
>  
> @@ -25,6 +28,12 @@
>  #define WMAX_METHOD_AMPLIFIER_CABLE	0x6
>  #define WMAX_METHOD_DEEP_SLEEP_CONTROL	0x0B
>  #define WMAX_METHOD_DEEP_SLEEP_STATUS	0x0C
> +#define WMAX_METHOD_THERMAL_INFORMATION	0x14
> +#define WMAX_METHOD_THERMAL_CONTROL	0x15
> +
> +#define WMAX_ARG_GET_CURRENT_PROF	0x0B
> +
> +#define WMAX_FAILURE_CODE		0xFFFFFFFF
>  
>  MODULE_AUTHOR("Mario Limonciello <mario.limonciello@outlook.com>");
>  MODULE_DESCRIPTION("Alienware special feature control");
> @@ -49,11 +58,27 @@ enum WMAX_CONTROL_STATES {
>  	WMAX_SUSPEND = 3,
>  };
>  
> +enum WMAX_THERMAL_PROFILE {
> +	WMAX_THERMAL_QUIET = 0x96,
> +	WMAX_THERMAL_BALANCED = 0x97,
> +	WMAX_THERMAL_BALANCED_PERFORMANCE = 0x98,
> +	WMAX_THERMAL_PERFORMANCE = 0x99,
> +	WMAX_THERMAL_USTT_LOW_POWER = 0xA5,
> +	WMAX_THERMAL_USTT_QUIET = 0xA3,
> +	WMAX_THERMAL_USTT_BALANCED = 0xA0,
> +	WMAX_THERMAL_USTT_BALANCED_PERFORMANCE = 0xA1,
> +	WMAX_THERMAL_USTT_PERFORMANCE = 0xA4,
> +	WMAX_THERMAL_GMODE = 0xAB,

While doing the next version, could also align these values please.

-- 
 i.

