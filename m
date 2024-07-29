Return-Path: <linux-kernel+bounces-265680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4209093F459
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0DF7B210B6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BAD145B25;
	Mon, 29 Jul 2024 11:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n22WLO2L"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C457679B8E;
	Mon, 29 Jul 2024 11:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722253468; cv=none; b=V4J1G9X9bKfKaOt/pa7iM1eNXUZTfV3gONYvfu4FUHbl1JjGbtip6hSddaon53Qh7Hz1xMS/ueVfuJWSBI9AZyWTVj0EDNd8UBPh6kGIrDKCxbT0zv9rSN2ogfEZjOUBbJbjYFfdIOhiu4/Vl9fMPU3vPnUO5/a5cGGXkXU96es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722253468; c=relaxed/simple;
	bh=f/z97bYp+EMwQiuCzp5i4xhQ//NcC+Qmw5S7TSllxug=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DZsj+5bKuw95dXYmF5oTURdvc9lW9IW4WbFONrF6WNmHiO+TowYexy6WvKuNzi2Vni9snlYhqOg64Ai29YfTLcNCkXijYuy1GH+p47IWTGyGzp+NMx8T2gheIraToRTKX8p1z51mC/46utuZaB+R3NAaM64SFtUFmWN6b2Pp3/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n22WLO2L; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722253467; x=1753789467;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=f/z97bYp+EMwQiuCzp5i4xhQ//NcC+Qmw5S7TSllxug=;
  b=n22WLO2LCzq/EBWgvFpZbuBVqwAhpznEOdyitWjKsjY8F/vdBBcyRbhU
   zDFTJciM0NGJr9qQvXBWRK7HtUGHwx5LElFa1LrzqRf0YYkVBX3ZAhFT2
   iHXgA/3HTXwglvj9paiF6Kvc+9WtLj0FOL8xZU5oim7PFKAYX1ZETEhUO
   wwN15qsXukwZB0CCPrpldv0V3nOS4jJ3XjRIIphhQRAjv+paS7AyJnJhl
   uOoEWNL4zey51ZD5r6OrYB6KAc8ZxXXGsv0HBTx5BQCHPOX+ym24Ys/Sk
   v34f6p7mgC9MS6z32TRQiyDJi1acUQhiCOb8uYmEbB8SxedIvVsvCucuL
   w==;
X-CSE-ConnectionGUID: 6xF9m0jySxaIzp/zXJjcWw==
X-CSE-MsgGUID: Gv+yv1BLQ7O4nRFu8oIQtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="12767550"
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="12767550"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 04:44:25 -0700
X-CSE-ConnectionGUID: dzU/h+CNRd2ko/XJdg40RQ==
X-CSE-MsgGUID: yRv5a/V0QUG1ElkQdtzyjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="77186600"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.151])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 04:44:23 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 29 Jul 2024 14:44:20 +0300 (EEST)
To: "Luke D. Jones" <luke@ljones.dev>
cc: platform-driver-x86@vger.kernel.org, corentin.chary@gmail.com, 
    Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: asus-wmi: Add quirk for ROG Ally X
In-Reply-To: <20240724222852.44378-1-luke@ljones.dev>
Message-ID: <056b599c-4d29-a743-ad7b-055e951e9e39@linux.intel.com>
References: <20240724222852.44378-1-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 25 Jul 2024, Luke D. Jones wrote:

> The new ROG Ally X functions the same as the previus model so we can use
> the same method to ensure the MCU USB devices wake and reconnect
> correctly.
> 
> Given that two devices marks the start of a trend, this patch also adds
> a quirk table to make future additions easier if the MCU is the same.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/platform/x86/asus-wmi.c            |  2 +-
>  include/linux/platform_data/x86/asus-wmi.h | 15 +++++++++++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 2b968003cb9b..bac2945b0e48 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -4694,7 +4694,7 @@ static int asus_wmi_add(struct platform_device *pdev)
>  	asus->dgpu_disable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_DGPU);
>  	asus->kbd_rgb_state_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_STATE);
>  	asus->ally_mcu_usb_switch = acpi_has_method(NULL, ASUS_USB0_PWR_EC0_CSEE)
> -						&& dmi_match(DMI_BOARD_NAME, "RC71L");
> +						&& dmi_check_system(asus_ally_mcu_quirk);
>  
>  	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MINI_LED_MODE))
>  		asus->mini_led_dev_id = ASUS_WMI_DEVID_MINI_LED_MODE;
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index 74b32e1d6735..fba9751cda5b 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -196,4 +196,19 @@ static const struct dmi_system_id asus_use_hid_led_dmi_ids[] = {
>  	{ },
>  };
>  
> +/* To be used by both hid-asus and asus-wmi to determine which controls kbd_brightness */
> +static const struct dmi_system_id asus_ally_mcu_quirk[] = {
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "RC71L"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "RC72L"),
> +		},
> +	},
> +	{ },
> +};

Why is this in the header? I see your comment but this means every file 
which includes asus-wmi.h will have a duplicate copy of this array.


-- 
 i.


