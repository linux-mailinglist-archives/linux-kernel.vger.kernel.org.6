Return-Path: <linux-kernel+bounces-554428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8EFA59795
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 677751887674
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8D922C322;
	Mon, 10 Mar 2025 14:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BMNtm+K6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BC022B8AC;
	Mon, 10 Mar 2025 14:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741616975; cv=none; b=Vyx6lAGyFXx3OXkaQk4xDUsu7jGUr/B4o7OhyFuJt8NPBEePrFdngr79iSAnkoFUCaNIA3td9g0TkNyTPanu0RlB0G6VwZx73erYNBUMhFIDA0mts/YI+bZjX0XO+Tgn/3HcTgul0BrMrPH1s+Y9hSs6N+Ij78AyxApWYCSEaFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741616975; c=relaxed/simple;
	bh=QcQAVlR3d+4z/SqzQ7XrMFA5rIaLvH9CQcsoJSD1/E0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NYEZk+8n2fzLYiVpiFq2BMmoCfmkXriDNgaHq8jN4PAEYj+uABxh8cDUEXt0CKUVqio+7wLdmX3tpD/HkUZv/XH0tBoRbjXaPZ0zWqcdSzD4nw5/9bQWMyfpkpAUwPWGCNA2JMI4pE7H4VZQ0v0fCxOZAyjQaGWyu1mBVuSNRzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BMNtm+K6; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741616975; x=1773152975;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=QcQAVlR3d+4z/SqzQ7XrMFA5rIaLvH9CQcsoJSD1/E0=;
  b=BMNtm+K6Sy6p4UydVUM5UPzth4KPvHjRenug8xNk7rRVagj9J3PWQTae
   /vtJCtEbN5F6L23hs9iaA841YmhozSnpLRnAp+KR3Rr6ySBgnpO9rJ/6C
   nRhD6aT9Qq6sBhKmq/jSiVnVMPMEf3Ayz8j2QwG61sPOqGdvd9ErZZYfo
   4NuiCdHGdTAIS2/p4vbqQ2OeqpSKr5sle3HLXhVr6uUV3d1Ayewi4PO3W
   wYNRhsMz/IAUB4WHZOSl4frPXQGpi+VxjmmfNrB3P8+kh28mZ3HW10i03
   3khxtluV9OQ+tIWkluM60TIqgkXVd290+UyP0cpPZJC/eMYXkWxZRrqoX
   g==;
X-CSE-ConnectionGUID: giTXtxhbQtKoh8SYL0+gKw==
X-CSE-MsgGUID: OC6WgndzQqqnHSDOIDVnxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="52821220"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="52821220"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 07:29:34 -0700
X-CSE-ConnectionGUID: /bVsumjnQYygFKID+TAJgA==
X-CSE-MsgGUID: Vq99QtjVRXWmX7sDQ+joTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="119847706"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.59])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 07:29:30 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 10 Mar 2025 16:29:27 +0200 (EET)
To: Kurt Borja <kuurtb@gmail.com>
cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] platform/x86: dell: Fix ALIENWARE_WMI dependencies
In-Reply-To: <20250309-dell-kconfig-fix-v1-1-38a2308d0ac6@gmail.com>
Message-ID: <8d219429-b13f-2610-960e-58851d53696f@linux.intel.com>
References: <20250309-dell-kconfig-fix-v1-1-38a2308d0ac6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 9 Mar 2025, Kurt Borja wrote:

> If ACPI_PLATFORM_PROFILE is selected by ALIENWARE_WMI_WMAX, the former
> is forced to be at least =m, because the latter is a bool.
> 
> This allows the following config:
> 
> 	CONFIG_ALIENWARE_WMI=y
> 	CONFIG_ACPI_PLATFORM_PROFILE=m

Hi,

selecting from =y should not result in =m for the other symbol. This is 
a bug in Kconfig infrastructure.

I ran across this a few years back and even had a test case to prove the 
select bug but back then the original problem eventually was solved in a 
different way which no longer hit the problem. I never could figure out
how to fix the kconfig logic though without breaking something and it 
ended up into low priority bin and never got solved.

Sadly, it seems I've lost the test case patch that exhibits the bug 
somewhere... I'll try to look for it from my archived files.

> which causes a linking error, because ALIENWARE_WMI_WMAX is only used to
> conditionally link alienware-wmi-wmax.c to the alienware-wmi kernel
> object, which might not be a module.
> 
> Move the ACPI_PLATFORM_PROFILE reverse dependency to ALIENWARE_WMI to
> fix this issue.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202503051819.bQ9P70Og-lkp@intel.com/
> Fixes: b1b8fcf6e677 ("platform/x86: Update alienware-wmi config entries")
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>  drivers/platform/x86/dell/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/dell/Kconfig
> index f8a0dffcaab7c3b423472c5b9093011334a698c8..87c2ceb12d48d610c85fa739abbc4f0d88e33ec8 100644
> --- a/drivers/platform/x86/dell/Kconfig
> +++ b/drivers/platform/x86/dell/Kconfig
> @@ -22,6 +22,7 @@ config ALIENWARE_WMI
>  	depends on DMI
>  	depends on LEDS_CLASS
>  	depends on NEW_LEDS
> +	select ACPI_PLATFORM_PROFILE
>  	help
>  	 This is a driver for controlling Alienware WMI driven features.
>  
> @@ -43,7 +44,6 @@ config ALIENWARE_WMI_WMAX
>  	bool "Alienware WMAX WMI device driver"
>  	default y
>  	depends on ALIENWARE_WMI
> -	select ACPI_PLATFORM_PROFILE
>  	help
>  	 Alienware WMI driver with AlienFX LED, HDMI, amplifier, deep sleep and
>  	 AWCC thermal control capabilities.
> 
> ---
> base-commit: e57eabe2fb044950e6ffdfe01803895043dec0b7
> change-id: 20250309-dell-kconfig-fix-4d3daedaedbf
> 
> Best regards,
> 

-- 
 i.


