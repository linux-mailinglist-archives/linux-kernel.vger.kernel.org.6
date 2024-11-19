Return-Path: <linux-kernel+bounces-414064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB099D2294
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 10:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCBADB21916
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 09:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE681AA1C2;
	Tue, 19 Nov 2024 09:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IhmblY1L"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C881D19AD8B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 09:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732009056; cv=none; b=ImVAOMtU3HHZWIEK13HNQYr00vZNKRkBmLz4aWiYOKvh7dRvewHKmMpSk5Duz2fdFGxrvi3YJ951B++vCjxwobG/uvb6sNrnzNzbJNjlu1poIcPKykLEwBA74/Qv4Lgemz+mHMb53x6gh9TaTi4f1J7f5bYZR++AJHFapUDyIq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732009056; c=relaxed/simple;
	bh=VKPdf/Yob99HrwitNkvoX8Vs94ZO5w5fnpQV8OneuY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9IbprsJAh/JLB1IvmOw25RcPhbRCgMOuGg78X0nepXsQsLpWFTd5wgTAHkfMP829iReMcmGdHMj0tvaBqorSRu3FU8E4kw57tb1L4MHpSDQdQs7TnEt+qUy0IROv5WbLnD2W4RrlekWs5gOPzYXPyWQyed5UdD7p0Rz0Xyqk/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IhmblY1L; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732009055; x=1763545055;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VKPdf/Yob99HrwitNkvoX8Vs94ZO5w5fnpQV8OneuY8=;
  b=IhmblY1L7lpu7KFBX2xToESIwJjRtNKp//WKKX3ozT3HJODtJHjfvAPX
   /82a7vcdPG2eHSV314ragTmimazRTBp/FEc17JJli6eWHLHn+7UmT7KXj
   zgR5Yv0EPnykgxarKXCxfT6+sob4Iic5mAmwd6B5DJIuU8itOPUelobQ4
   57HS1i/R9xTPPB9fco1rXAMkdbAHNyR/Or2pUvrJCxu80PPxBzFfIYZaS
   +yEGM2qz3ijNmf3IEpHrCPrhDzppE8BPDEYiJiDUHBUFPs30IGu9Obt6f
   6i1AQQSlDWFjiAGJhh+Nc+utdGVGs4mjMU9TWIgWvtskuFkgwYVkB3X9/
   g==;
X-CSE-ConnectionGUID: WnCECoamQh6jv00VpvWvQw==
X-CSE-MsgGUID: +i42lqvJTSqfHMTunX/yzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="32145748"
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="32145748"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 01:37:33 -0800
X-CSE-ConnectionGUID: tYoukgWHSQam8rJgPt5ufw==
X-CSE-MsgGUID: MTYwJRhGQLGMkoK3R9bjfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="94436328"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 01:37:31 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tDKfn-0000000GJ08-4C37;
	Tue, 19 Nov 2024 11:37:28 +0200
Date: Tue, 19 Nov 2024 11:37:27 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "Daniel Walker (danielwa)" <danielwa@cisco.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?utf-8?Q?J=EF=BF=BDrvinen?= <ilpo.jarvinen@linux.intel.com>,
	Klara Modin <klarasmodin@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danil Rybakov <danilrybakov249@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xe-linux-external(mailer list)" <xe-linux-external@cisco.com>
Subject: Re: platform/x86: p2sb: Allow p2sb_bar() calls during PCI device
 probe
Message-ID: <ZzxcV7F32K1_Oo8X@smile.fi.intel.com>
References: <5qjbimedzeertdham2smgktt54gzdc7yg4dwgiz7eezt2tf5a2@szhhpvzo3uhj>
 <Zzs1rw1YcoEEeW7+@goliath>
 <ZztABO3TyJBekZRs@smile.fi.intel.com>
 <ZztCB5hN2NBnPgiR@goliath>
 <ZztF7FKaBwZKs5dk@smile.fi.intel.com>
 <ZztQwLpoZDZzbi6O@goliath>
 <ZztjcntEj5Eo0Rw9@smile.fi.intel.com>
 <df1fa47f-7efb-4b0c-8ef6-100b12ab1523@redhat.com>
 <Zzt2JNchK9A0pSlZ@goliath>
 <p3lt3psoxenwlvxu6yjpjk4yskrplagj54vk4vxkg6biudghus@go6hpoakvfwh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p3lt3psoxenwlvxu6yjpjk4yskrplagj54vk4vxkg6biudghus@go6hpoakvfwh>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Nov 19, 2024 at 02:20:48AM +0000, Shinichiro Kawasaki wrote:
> On Nov 18, 2024 / 17:15, Daniel Walker (danielwa) wrote:
> > On Mon, Nov 18, 2024 at 05:00:52PM +0100, Hans de Goede wrote:

[...]

> > > > Hans, there will be no need to fix anything if they implement correct access
> > > > to the GPIO, i.e. via driver and board code with GPIO lookup tables.
> > > 
> > > Agreed, still I'm not sure how I feel about us hiding the previously unhidden P2SB.
> > > 
> > > OTOH I guess it may have only been unhidden in the BIOS to make the hack they
> > > are using possible in the first place.
> > 
> > From a flexibility POV I would suggest if you can not hide it if it's not already
> > hidden by the BIOS that would be better since some company may have a good
> > reason to make a custom driver or to export the pci device to userspace thru
> > UIO. The current situation is you can't make a custom driver if p2sb is enable
> > with this additional patch even if you unhide the device inside the BIOS.
> > 
> > In our case it seems like we could use the already existing solution with
> > pinctrl, but others may not be able to do that or may not want to for different
> > reasons.
> 
> I don't have strong opinion about the choice, but I wonder how the p2sb code
> will be if we keep the unhidden P2SB. I created a trial patch below. If the
> device is not hidden, it does not call pci_scan_single_device() and
> pci_stop_and_remove_bus_device(). Instead, it calls pci_get_slot() and
> pci_dev_put(). I don't have the environment which unhides P2SB. Daniel, if you
> have time to afford, please try it out.

...

> -	ret = p2sb_scan_and_cache(bus, devfn_p2sb);
> +	ret = p2sb_scan_and_cache(bus, devfn_p2sb, hidden);


If you still want to implement this, rather make the two different calls here

	if (hidden)
		ret = p2sb_scan_and_cache(bus, devfn_p2sb);
	else
		ret = p2sb_read_and_cache(...);

otherwise the code looks much uglier... :-(

-- 
With Best Regards,
Andy Shevchenko



