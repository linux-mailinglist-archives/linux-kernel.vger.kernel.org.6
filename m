Return-Path: <linux-kernel+bounces-414507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 094C59D2952
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87E6CB31473
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4F41D0BB2;
	Tue, 19 Nov 2024 15:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ag9212lF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED33F1CCB35
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 15:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732028642; cv=none; b=AGJYvUE4t4a74jyW/+F5cRfDy2PlFylX4BHvOf33ZvY4vyyZPB9BPE6qBOj0DH2vpkfGzM+kawLuWYhK4tmVwPqvAl59154UZM6rn2YRE81Pr6BcyuSO4Q9iz3RSk/iGnUq/fCLEowY0LfAiF46LZQm1WIsEIubL840I8FOiv1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732028642; c=relaxed/simple;
	bh=i1alU7lHmbgG3VGy49BKd148rHLHMO5hGOs7fa4M1pA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HM29lNyb07Oj0iSqVnPsGLhTBmfrPGgyMnRjudlDhpopKEeW539lgJ+IE0NyGtKN38xZH5KP/crTrrVOkfo81WLmLMB0JQJ5/JLPyq97293YdjqZxVXimst/iECGih4/CJHX3wuVFvUYBSw4OYQVuRAeXepmP1qFhnzpIuJz1iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ag9212lF; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732028641; x=1763564641;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i1alU7lHmbgG3VGy49BKd148rHLHMO5hGOs7fa4M1pA=;
  b=Ag9212lFgs8DuUs68ecBc79gYKz4YthUfRTCpJx+aRJYFr8XsYZ7ZwA4
   zVeu8FYvTvWG9uMz/co9dBVqcc0KkKGHuJI+cufcgisSw54Hbt71GPCkK
   nHvfzwjFTJINxhoWEkb6rpmKGIPbdQ5dwiFZ2Xg4YS/P27uv17kJvMK8L
   z3OCQOmNily/X4DQH0gtgJGz7s4P16hH5F7JYqyJXhOtTR9moIT0jtaQD
   CH1y5N5hxFYbNoNnjXfThioXRhj8IEUwWaiidB/rZJN/w2C4yySa/xled
   mKcZiI4dutVSJZDqwWxjmiqEeRmSb9xmlz/iKRoAQBtNH98EVtJtQ7MSo
   g==;
X-CSE-ConnectionGUID: Az3DNS49QqqmL8t/NYlL5A==
X-CSE-MsgGUID: 8maD8HMBQ2CUEjQXYL1DdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="57441953"
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="57441953"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 07:03:46 -0800
X-CSE-ConnectionGUID: gwm4oApOTomy+SUCr+5lkQ==
X-CSE-MsgGUID: +nolhN74RUKYkj6dVyJbLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="127109017"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 07:03:43 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tDPlV-0000000GOOp-09Js;
	Tue, 19 Nov 2024 17:03:41 +0200
Date: Tue, 19 Nov 2024 17:03:40 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Daniel Walker (danielwa)" <danielwa@cisco.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Ilpo =?utf-8?Q?J=EF=BF=BDrvinen?= <ilpo.jarvinen@linux.intel.com>,
	Klara Modin <klarasmodin@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danil Rybakov <danilrybakov249@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xe-linux-external(mailer list)" <xe-linux-external@cisco.com>
Subject: Re: platform/x86: p2sb: Allow p2sb_bar() calls during PCI device
 probe
Message-ID: <ZzyozPi86r4iEFPQ@smile.fi.intel.com>
References: <Zzs1rw1YcoEEeW7+@goliath>
 <ZztABO3TyJBekZRs@smile.fi.intel.com>
 <ZztCB5hN2NBnPgiR@goliath>
 <ZztF7FKaBwZKs5dk@smile.fi.intel.com>
 <ZztQwLpoZDZzbi6O@goliath>
 <ZztjcntEj5Eo0Rw9@smile.fi.intel.com>
 <df1fa47f-7efb-4b0c-8ef6-100b12ab1523@redhat.com>
 <Zzt2JNchK9A0pSlZ@goliath>
 <ZzxdXa-IsfHv2IFc@smile.fi.intel.com>
 <Zzyk5r22AS/Feg7z@goliath>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zzyk5r22AS/Feg7z@goliath>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Nov 19, 2024 at 02:47:02PM +0000, Daniel Walker (danielwa) wrote:
> On Tue, Nov 19, 2024 at 11:41:49AM +0200, Andy Shevchenko wrote:
> > On Mon, Nov 18, 2024 at 05:15:17PM +0000, Daniel Walker (danielwa) wrote:
> > > On Mon, Nov 18, 2024 at 05:00:52PM +0100, Hans de Goede wrote:
> > > > On 18-Nov-24 4:55 PM, Andy Shevchenko wrote:
> > > > > On Mon, Nov 18, 2024 at 02:35:44PM +0000, Daniel Walker (danielwa) wrote:
> > > > >> On Mon, Nov 18, 2024 at 03:49:32PM +0200, Andy Shevchenko wrote:
> > > > >>> On Mon, Nov 18, 2024 at 01:32:55PM +0000, Daniel Walker (danielwa) wrote:
> > > > >>>> On Mon, Nov 18, 2024 at 03:24:20PM +0200, Andy Shevchenko wrote:
> > > > >>>>> On Mon, Nov 18, 2024 at 12:40:16PM +0000, Daniel Walker (danielwa) wrote:

...

> > > > >>>>> Are you referring to LPC GPIO?
> > > > >>>>  
> > > > >>>>  I don't know the hardware well enough to say for certain. It's whatever device 8086:19dd is.
> > > > >>>
> > > > >>> This is device which represents p2sb. It's not a GPIO device you are talking
> > > > >>> about for sure. You can send privately more detailed info in case this is shouldn't
> > > > >>> be on public to me to understand what would be the best approach to fix your issue.
> > > > >>
> > > > >> Here's a comment,
> > > > >>
> > > > >> /* INTEL Denverton GPIO registers are accessible using SBREG_BAR(bar 0) as base */
> > > > >>
> > > > >> We have gpio wired to an FPGA and I believe the gpio line is used to reset the
> > > > >> fpga.
> > > > >>
> > > > >> So the pci resources attached to 8086:19dd can be used to access gpio of some
> > > > >> type. 
> > > > >>
> > > > >> I'm not a pci expert but on the 19bb device bar 0 we use the below offset to manipulate
> > > > >> the gpio,
> > > > >>
> > > > >> #define INTEL_GPIO_REG_RESET_OFFSET          0xC50578
> > > > >>
> > > > >> The comments suggest this is gpio 6. I would seems your reaction would be that
> > > > >> there is no gpio on the 19dd device. Maybe our driver is access gpio thru p2sb
> > > > >> or something like that.
> > > > >>
> > > > >> Does the offset above make sense to you in the context of the p2sb ?
> > > > > 
> > > > > Yes, everything makes sense. Please, enable lpc_ich driver and forget about
> > > > > talking to the p2sb memory mapped IO.
> > > > > 
> > > > > /* Offset data for Denverton GPIO controllers */
> > > > > static const resource_size_t dnv_gpio_offsets[DNV_GPIO_NR_RESOURCES] = {
> > > > > 	[DNV_GPIO_NORTH] = 0xc20000,
> > > > > 	[DNV_GPIO_SOUTH] = 0xc50000,
> > > > > };
> > > > > 
> > > > > So, you are using a pin from the Community "South" of the on-die Denverton GPIO.
> > > > > 
> > > > > In EDS this called GPIO_6, while in the driver it's pin 88, i.e. SMB3_IE0_DATA.
> > > > > 
> > > > > You will need to
> > > > > - enable lpc_ich driver (CONFIG_LPC_ICH)
> > > > > - enable Intel Denverton pin control driver (CONFIG_PINCTRL_DENVERTON)
> > > > > - replace your custom approach to:
> > > > >   - GPIO lookup table
> > > > >   - proper GPIO APIs, as gpiod_get() or alike
> > > > > 
> > > > > See how it was done in the current kernel code:
> > > > > 
> > > > > 8241b55f1ded ("drm/i915/dsi: Replace poking of VLV GPIOs behind the driver's back")
> > > > > a6c80bec3c93 ("leds: simatic-ipc-leds-gpio: Add GPIO version of Siemens driver")
> > > > > 
> > > > > Hans, there will be no need to fix anything if they implement correct access
> > > > > to the GPIO, i.e. via driver and board code with GPIO lookup tables.
> > > > 
> > > > Agreed, still I'm not sure how I feel about us hiding the previously unhidden P2SB.
> > > > 
> > > > OTOH I guess it may have only been unhidden in the BIOS to make the hack they
> > > > are using possible in the first place.
> > > 
> > > From a flexibility POV I would suggest if you can not hide it if it's not already
> > > hidden by the BIOS that would be better since some company may have a good
> > > reason to make a custom driver or to export the pci device to userspace thru
> > > UIO.
> > 
> > The previous emails used wrong terminology, the hidden device is left hidden, and
> > all the opposite: unhidden is not touched in this sense.
> > 
> > The problem there that for the initially unhidden devices we call pci_stop_...
> > which seems incorrect and needs to be fixed, indeed.
> > 
> > > The current situation is you can't make a custom driver if p2sb is enable
> > > with this additional patch even if you unhide the device inside the BIOS.
> > 
> > Yeah, but I do not consider that is anyhow related to upstream.
> 
> Not true. Have you used the UIO system ? You can make a custom userspace driver
> for a pci device with zero kernel changes. We have a custom LKM , but we could
> easily have done it with UIO. With the PCI device completely gone, there is no
> way to use UIO to make a userspace driver.

Is that what you are using with p2sb, or is it just a general remark?
Because if it's the former, it's already double slippery slope.
If you are talking in general, yes, that might be a case. And note,
I am not against fixing p2sb case here, however it sounds like people
want to seek for a problem...

-- 
With Best Regards,
Andy Shevchenko



