Return-Path: <linux-kernel+bounces-414069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B139D229C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 10:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6464628332C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 09:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB581C0DD6;
	Tue, 19 Nov 2024 09:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nlQW+30a"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AED19B59C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 09:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732009316; cv=none; b=s9VU18s4ByAbIGGIWKuuC4XnKp2BLftHXrd0ppTe2eNlAe5RIRD5rV2YQilcVEiglVrFkpNQOcXAp9LZPstzAsR91Ke+a8+52T5ta2Ay0KWsr8yervD7Bj3yedIZXyT7vErffvGks6P+yiRIP2rSWYq8/V3he4rXJhQ2YKfx4bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732009316; c=relaxed/simple;
	bh=9fp3cv77qU/QYFjcC3FPIu9J6Muc4MXxtiOqHpmiUDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ewxz7u3uruqI3ILQqoAb/14oh23meuqsSUMPZkWPuk+7MiGEDliUyDUmoqqJ+m0S+14qfUylmbDefiM5PhvldAlkEdloY2PmmOhvqAYs1Jv+iPJxhUtP5SkEKSXQu1jq1IyNScY6lRq3etXI5FqvJIWj/10z74MROJXGUkm7LOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nlQW+30a; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732009315; x=1763545315;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9fp3cv77qU/QYFjcC3FPIu9J6Muc4MXxtiOqHpmiUDU=;
  b=nlQW+30aKd4IOE4Oa5jal6t0NOl0dhQtzKhi+GT8t5WEDOMZigaJgcAL
   Xr81L1ZsSsbfRyt90gz/ezzt8eRsi0lPMCaP52Hu5JxQjBJriSFyFB3ak
   kmmdGuIh/MeS0lmKBGffkpfIg0sfoNv26fg1gfwuBy/9LlqSOfpcb5Ntx
   E8aLZVT3oMXSY+Sqw9Q4j41L8GpjAPCJVF+qd+yzYyMS/UsYuU0EUYUmi
   Ig4cOtsrSKiNv1XYGW/jYgU5M1B1P3jOMKzUPSS61Tv6Fc/NmX4giuWWP
   O8cht62DABT47hhfsF5ZI71IkAjmlebuU9cSGABvywGMr6NKxdkB4QjY/
   g==;
X-CSE-ConnectionGUID: UmfVj9CcT0+fuynRCK2bxA==
X-CSE-MsgGUID: Og+mxo6fQpiEz2YqMs69DA==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="42628616"
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="42628616"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 01:41:55 -0800
X-CSE-ConnectionGUID: eI6HBrCqRB6w8Ak05IvUDw==
X-CSE-MsgGUID: PYLtHHmbSVywAlxHqpnUSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="89915655"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 01:41:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tDKk1-0000000GJ4i-3HNa;
	Tue, 19 Nov 2024 11:41:49 +0200
Date: Tue, 19 Nov 2024 11:41:49 +0200
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
Message-ID: <ZzxdXa-IsfHv2IFc@smile.fi.intel.com>
References: <ZzdhTsuRNk1YWg8p@goliath>
 <5qjbimedzeertdham2smgktt54gzdc7yg4dwgiz7eezt2tf5a2@szhhpvzo3uhj>
 <Zzs1rw1YcoEEeW7+@goliath>
 <ZztABO3TyJBekZRs@smile.fi.intel.com>
 <ZztCB5hN2NBnPgiR@goliath>
 <ZztF7FKaBwZKs5dk@smile.fi.intel.com>
 <ZztQwLpoZDZzbi6O@goliath>
 <ZztjcntEj5Eo0Rw9@smile.fi.intel.com>
 <df1fa47f-7efb-4b0c-8ef6-100b12ab1523@redhat.com>
 <Zzt2JNchK9A0pSlZ@goliath>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zzt2JNchK9A0pSlZ@goliath>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Nov 18, 2024 at 05:15:17PM +0000, Daniel Walker (danielwa) wrote:
> On Mon, Nov 18, 2024 at 05:00:52PM +0100, Hans de Goede wrote:
> > On 18-Nov-24 4:55 PM, Andy Shevchenko wrote:
> > > On Mon, Nov 18, 2024 at 02:35:44PM +0000, Daniel Walker (danielwa) wrote:
> > >> On Mon, Nov 18, 2024 at 03:49:32PM +0200, Andy Shevchenko wrote:
> > >>> On Mon, Nov 18, 2024 at 01:32:55PM +0000, Daniel Walker (danielwa) wrote:
> > >>>> On Mon, Nov 18, 2024 at 03:24:20PM +0200, Andy Shevchenko wrote:
> > >>>>> On Mon, Nov 18, 2024 at 12:40:16PM +0000, Daniel Walker (danielwa) wrote:

...

> > >>>>> Are you referring to LPC GPIO?
> > >>>>  
> > >>>>  I don't know the hardware well enough to say for certain. It's whatever device 8086:19dd is.
> > >>>
> > >>> This is device which represents p2sb. It's not a GPIO device you are talking
> > >>> about for sure. You can send privately more detailed info in case this is shouldn't
> > >>> be on public to me to understand what would be the best approach to fix your issue.
> > >>
> > >> Here's a comment,
> > >>
> > >> /* INTEL Denverton GPIO registers are accessible using SBREG_BAR(bar 0) as base */
> > >>
> > >> We have gpio wired to an FPGA and I believe the gpio line is used to reset the
> > >> fpga.
> > >>
> > >> So the pci resources attached to 8086:19dd can be used to access gpio of some
> > >> type. 
> > >>
> > >> I'm not a pci expert but on the 19bb device bar 0 we use the below offset to manipulate
> > >> the gpio,
> > >>
> > >> #define INTEL_GPIO_REG_RESET_OFFSET          0xC50578
> > >>
> > >> The comments suggest this is gpio 6. I would seems your reaction would be that
> > >> there is no gpio on the 19dd device. Maybe our driver is access gpio thru p2sb
> > >> or something like that.
> > >>
> > >> Does the offset above make sense to you in the context of the p2sb ?
> > > 
> > > Yes, everything makes sense. Please, enable lpc_ich driver and forget about
> > > talking to the p2sb memory mapped IO.
> > > 
> > > /* Offset data for Denverton GPIO controllers */
> > > static const resource_size_t dnv_gpio_offsets[DNV_GPIO_NR_RESOURCES] = {
> > > 	[DNV_GPIO_NORTH] = 0xc20000,
> > > 	[DNV_GPIO_SOUTH] = 0xc50000,
> > > };
> > > 
> > > So, you are using a pin from the Community "South" of the on-die Denverton GPIO.
> > > 
> > > In EDS this called GPIO_6, while in the driver it's pin 88, i.e. SMB3_IE0_DATA.
> > > 
> > > You will need to
> > > - enable lpc_ich driver (CONFIG_LPC_ICH)
> > > - enable Intel Denverton pin control driver (CONFIG_PINCTRL_DENVERTON)
> > > - replace your custom approach to:
> > >   - GPIO lookup table
> > >   - proper GPIO APIs, as gpiod_get() or alike
> > > 
> > > See how it was done in the current kernel code:
> > > 
> > > 8241b55f1ded ("drm/i915/dsi: Replace poking of VLV GPIOs behind the driver's back")
> > > a6c80bec3c93 ("leds: simatic-ipc-leds-gpio: Add GPIO version of Siemens driver")
> > > 
> > > Hans, there will be no need to fix anything if they implement correct access
> > > to the GPIO, i.e. via driver and board code with GPIO lookup tables.
> > 
> > Agreed, still I'm not sure how I feel about us hiding the previously unhidden P2SB.
> > 
> > OTOH I guess it may have only been unhidden in the BIOS to make the hack they
> > are using possible in the first place.
> 
> From a flexibility POV I would suggest if you can not hide it if it's not already
> hidden by the BIOS that would be better since some company may have a good
> reason to make a custom driver or to export the pci device to userspace thru
> UIO.

The previous emails used wrong terminology, the hidden device is left hidden, and
all the opposite: unhidden is not touched in this sense.

The problem there that for the initially unhidden devices we call pci_stop_...
which seems incorrect and needs to be fixed, indeed.

> The current situation is you can't make a custom driver if p2sb is enable
> with this additional patch even if you unhide the device inside the BIOS.

Yeah, but I do not consider that is anyhow related to upstream.

> In our case it seems like we could use the already existing solution with
> pinctrl, but others may not be able to do that or may not want to for different
> reasons.

Please, please, go with the pin control approach, let's not increase
the surface of the untested fields. Feel free to ask for a help from me
(and possibly Hans) if you need a such.

-- 
With Best Regards,
Andy Shevchenko



