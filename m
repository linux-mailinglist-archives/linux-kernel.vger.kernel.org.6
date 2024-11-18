Return-Path: <linux-kernel+bounces-413187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EBE9D14E5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5594EB282F0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 15:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B5C1A9B3D;
	Mon, 18 Nov 2024 15:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="INyRbXfI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095F3148FE6
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731945339; cv=none; b=mWg0ItD47REMnJJ4i5QFMNZSxDJSbe4v2qfPrKWsVb0pAAPkFLLzKnfiGb/ur3LCFwJgNcfTrYWevSj3F5f3HcPeZvnRbFlxEsFTMj89pnTSuq6nl9V8AeK0gcY0ikew1thPjmLMe2Yxnp+ftP74cEw8o1RMIAf5KxPq1F+EWTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731945339; c=relaxed/simple;
	bh=zir8hakDkyMI0HxAyo+ufjhm3nz0MJ1zHD5s8XoSlxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPtcn8mzm6567wQZjyaxpSXliRiv26ApUGuKkckwuJpBcJBK0dcCu4nb3HeW9aARjTLSP+JjvaqoVGVNbODXw7FUyzaFKb7nhAqTZwlewLMU/lcfRwe5+Cr8zQoL0zQTS/Tr6reYJf8MSe4tKpNaZMJTVJ8NPLxEB2rMyhkVdmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=INyRbXfI; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731945338; x=1763481338;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zir8hakDkyMI0HxAyo+ufjhm3nz0MJ1zHD5s8XoSlxA=;
  b=INyRbXfIl9O4lCOJlF+WUCgiq6cpt/o4pXtZ/Jy4l5AnL2xdD4ToW6Sd
   /WyjWHFwQ5u+GG7y6HPMkmBOOIDoeHfxqw/PwXd+RbR5HyjiSZNLUiozn
   16pDrWI8d8WbcrxO63Xjv0BZQLlV7BOWZmCMEG9LARIM2Fezc/2HV7n5P
   EazN/dMmeaJdOINb7RmnUM98AzaXc5mWPXAxh5Z2S744Y/cfJ+dPStWG8
   KI/C18QFd6oStgkNxr5Ji6LIDODBCNhYzlZw15bkQKR8n4tlpvVhAsUX+
   wz5spAM1INeOaV1+XUnvxOxTvHGqt/RXIpXLgTp0cFoQI1dxjle91GHXM
   Q==;
X-CSE-ConnectionGUID: qPXAi+lbQ9eDKMo2uPaTrQ==
X-CSE-MsgGUID: YVAVxR2iSdmuPdrftFngLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="34770973"
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="34770973"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 07:55:36 -0800
X-CSE-ConnectionGUID: p+N/JDGkSWKAROamBVUuLQ==
X-CSE-MsgGUID: 1kHzIQ/mR32Yotgb4MMMkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="94303462"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 07:55:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tD467-0000000G45q-0iMY;
	Mon, 18 Nov 2024 17:55:31 +0200
Date: Mon, 18 Nov 2024 17:55:30 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Daniel Walker (danielwa)" <danielwa@cisco.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?utf-8?Q?J=EF=BF=BDrvinen?= <ilpo.jarvinen@linux.intel.com>,
	Klara Modin <klarasmodin@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danil Rybakov <danilrybakov249@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xe-linux-external(mailer list)" <xe-linux-external@cisco.com>
Subject: Re: platform/x86: p2sb: Allow p2sb_bar() calls during PCI device
 probe
Message-ID: <ZztjcntEj5Eo0Rw9@smile.fi.intel.com>
References: <ZzTk5kyPa5kUxA+f@goliath>
 <a5bafe87-e8f6-40d9-a5d8-34cf6aa576a4@redhat.com>
 <wxb4hmju5jknxr2bclxlu5gujgmb3vvqwub7jrt4wofllqp7li@pdvthto4jf47>
 <ZzdhTsuRNk1YWg8p@goliath>
 <5qjbimedzeertdham2smgktt54gzdc7yg4dwgiz7eezt2tf5a2@szhhpvzo3uhj>
 <Zzs1rw1YcoEEeW7+@goliath>
 <ZztABO3TyJBekZRs@smile.fi.intel.com>
 <ZztCB5hN2NBnPgiR@goliath>
 <ZztF7FKaBwZKs5dk@smile.fi.intel.com>
 <ZztQwLpoZDZzbi6O@goliath>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZztQwLpoZDZzbi6O@goliath>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Nov 18, 2024 at 02:35:44PM +0000, Daniel Walker (danielwa) wrote:
> On Mon, Nov 18, 2024 at 03:49:32PM +0200, Andy Shevchenko wrote:
> > On Mon, Nov 18, 2024 at 01:32:55PM +0000, Daniel Walker (danielwa) wrote:
> > > On Mon, Nov 18, 2024 at 03:24:20PM +0200, Andy Shevchenko wrote:
> > > > On Mon, Nov 18, 2024 at 12:40:16PM +0000, Daniel Walker (danielwa) wrote:

...

> > > > Are you referring to LPC GPIO?
> > >  
> > >  I don't know the hardware well enough to say for certain. It's whatever device 8086:19dd is.
> > 
> > This is device which represents p2sb. It's not a GPIO device you are talking
> > about for sure. You can send privately more detailed info in case this is shouldn't
> > be on public to me to understand what would be the best approach to fix your issue.
> 
> Here's a comment,
> 
> /* INTEL Denverton GPIO registers are accessible using SBREG_BAR(bar 0) as base */
> 
> We have gpio wired to an FPGA and I believe the gpio line is used to reset the
> fpga.
> 
> So the pci resources attached to 8086:19dd can be used to access gpio of some
> type. 
> 
> I'm not a pci expert but on the 19bb device bar 0 we use the below offset to manipulate
> the gpio,
> 
> #define INTEL_GPIO_REG_RESET_OFFSET          0xC50578
> 
> The comments suggest this is gpio 6. I would seems your reaction would be that
> there is no gpio on the 19dd device. Maybe our driver is access gpio thru p2sb
> or something like that.
> 
> Does the offset above make sense to you in the context of the p2sb ?

Yes, everything makes sense. Please, enable lpc_ich driver and forget about
talking to the p2sb memory mapped IO.

/* Offset data for Denverton GPIO controllers */
static const resource_size_t dnv_gpio_offsets[DNV_GPIO_NR_RESOURCES] = {
	[DNV_GPIO_NORTH] = 0xc20000,
	[DNV_GPIO_SOUTH] = 0xc50000,
};

So, you are using a pin from the Community "South" of the on-die Denverton GPIO.

In EDS this called GPIO_6, while in the driver it's pin 88, i.e. SMB3_IE0_DATA.

You will need to
- enable lpc_ich driver (CONFIG_LPC_ICH)
- enable Intel Denverton pin control driver (CONFIG_PINCTRL_DENVERTON)
- replace your custom approach to:
  - GPIO lookup table
  - proper GPIO APIs, as gpiod_get() or alike

See how it was done in the current kernel code:

8241b55f1ded ("drm/i915/dsi: Replace poking of VLV GPIOs behind the driver's back")
a6c80bec3c93 ("leds: simatic-ipc-leds-gpio: Add GPIO version of Siemens driver")

Hans, there will be no need to fix anything if they implement correct access
to the GPIO, i.e. via driver and board code with GPIO lookup tables.

-- 
With Best Regards,
Andy Shevchenko



