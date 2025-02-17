Return-Path: <linux-kernel+bounces-517191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AF6A37D87
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A77416CAB0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 08:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5BD19E7FA;
	Mon, 17 Feb 2025 08:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jESugXih"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B90168B1
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739782405; cv=none; b=sSgsxO7yMFa43DCghMyWpQf/CmeaQ3qaUYdPa8LYmnOVi7snE7KXR9Fd4aAXUWxbGHRjuyZQ7CH7QG2KLtSLiCwGZIbwcB9XOZVcbiLNNnTf9B+Wl8kKxSSFvVGTL6KZOMsctXQ9Nh0b8xGUZp8sTrS21A1LehloHqxgfU80x8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739782405; c=relaxed/simple;
	bh=qu/3K+SbsA9VLOzbSKu1qsZ3WdSo3ICrFa2oxsGDqmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSubi4xPmnwIdAF6mej6a2naUeRyV+pqsLReWZBlqNm4WFRST5sewV5V4v4t0Wh9j0W0DmzB/sROLZYQXF1aIpW+M6T0LBrTjb540CRj0FnyiiTQfLgX1Tth7eQldf19mqRC3XS6Mipi5BD08cbAYTgMCREDEP5nEOGoZGamXSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jESugXih; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739782404; x=1771318404;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qu/3K+SbsA9VLOzbSKu1qsZ3WdSo3ICrFa2oxsGDqmw=;
  b=jESugXihqP7Os1do+loLZxdHIKdQi0pOStoZ6+WJ6qLinTJnUwNxbgaw
   unPb3atyE+CGDmT1poQxNqvu2qCOPR6QaYrApQu8diOVfHgBIs6pWcHu5
   BbOwJJV+r5Nuggx1iz/mdlHoXHqLDQFyZtAvktMCO4Fw4ywi6Rbb0jv8k
   6MJKa7Q3fx8yqFDIx/UMCrSY8SFKm3x5Y1YlBuHZVHcMVPPD0qtqxVay0
   t6TBBZmfoVcdF6xcljGrmSjLcVg79Pig09qUYBOZwZnGE2exSekf1mKN8
   ZrK0o6tyQY+mEeP9Xqu/nwaf66ulQWuz+e8RuHwUblyrZCxIwTjSDCan3
   g==;
X-CSE-ConnectionGUID: LixetzCKRIygM6hB9pzBVA==
X-CSE-MsgGUID: lM2et9slRuCvbXVKPr8ALw==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="40720404"
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="40720404"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 00:53:23 -0800
X-CSE-ConnectionGUID: AB6Kyz33RRGIBYcHbav3Sg==
X-CSE-MsgGUID: D/mb9oHATf6FOT1t0Epeng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="119072773"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.245.97.15])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 00:53:21 -0800
Date: Mon, 17 Feb 2025 09:53:13 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Wentong Wu <wentong.wu@intel.com>, Jason Chen <jason.z.chen@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mei: vsc: Use "wakeuphostint" when getting the host
 wakeup GPIO
Message-ID: <Z7L4+YJcUaaz1kyG@linux.intel.com>
References: <20250214212425.84021-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214212425.84021-1-hdegoede@redhat.com>

Hi Hans,

Thanks for working on this, this issue annoyed lots of people.

On Fri, Feb 14, 2025 at 10:24:25PM +0100, Hans de Goede wrote:
> The _CRS ACPI resources table has 2 entries for the host wakeup GPIO,
> the first one being a regular GpioIo () resource while the second one
> is a GpioInt () resource for the same pin.
> 
> The acpi_gpio_mapping table used by vsc-tp.c maps the first Gpio ()
> resource to "wakeuphost-gpios" where as the second GpioInt () entry
> is mapped to "wakeuphostint-gpios".
> 
> Using "wakeuphost" to request the GPIO as was done until now, means
> that the gpiolib-acpi code does not know that the GPIO is active-low
> as that info is only available in the GpioInt () entry.
> 
> Things were still working before due to the following happening:
> 
> 1. Since the 2 entries point to the same pin they share a struct gpio_desc
> 2. The SPI core creates the SPI device vsc-tp.c binds to and calls
>    acpi_dev_gpio_irq_get(). This does use the second entry and sets
>    FLAG_ACTIVE_LOW in gpio_desc.flags .
> 3. vsc_tp_probe() requests the "wakeuphost" GPIO and inherits the
>    active-low flag set by acpi_dev_gpio_irq_get()
> 
> But there is a possible scenario where things do not work:
> 
> 1. - 3. happen as above
> 4. After requesting the "wakeuphost" GPIO, the "resetfw" GPIO is requested
>    next, but its USB GPIO controller is not available yet, so this call
>    returns -EPROBE_DEFER.
> 5. The gpio_desc for "wakeuphost" is put() and during this the active-low
>    flag is cleared from gpio_desc.flags .
> 6. Later on vsc_tp_probe() requests the "wakeuphost" GPIO again, but now it
>    is not marked active-low.
> 
> The difference can also be seen in /sys/kernel/debug/gpio, which contains
> the following line for this GPIO:
> 
>  gpio-535 (                    |wakeuphost          ) in  hi IRQ ACTIVE LOW
> 
> If the second scenario is hit the "ACTIVE LOW" at the end disappears and
> things do not work.
> 
> Fix this by requesting the GPIO through the "wakeuphostint" mapping instead
> which provides active-low info without relying on acpi_dev_gpio_irq_get()
> pre-populating this info in the gpio_desc.
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2316918
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

The problem explanation and the fix looks good to me.

Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

Regards
Stanislaw

> ---
>  drivers/misc/mei/vsc-tp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
> index 35d349fee769..7be1649b1972 100644
> --- a/drivers/misc/mei/vsc-tp.c
> +++ b/drivers/misc/mei/vsc-tp.c
> @@ -502,7 +502,7 @@ static int vsc_tp_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> -	tp->wakeuphost = devm_gpiod_get(dev, "wakeuphost", GPIOD_IN);
> +	tp->wakeuphost = devm_gpiod_get(dev, "wakeuphostint", GPIOD_IN);
>  	if (IS_ERR(tp->wakeuphost))
>  		return PTR_ERR(tp->wakeuphost);
>  
> -- 
> 2.48.1
> 

