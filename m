Return-Path: <linux-kernel+bounces-335866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9809997EBBB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 14:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C95B31C20DCC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 12:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6555C1991AA;
	Mon, 23 Sep 2024 12:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l32Hvrc9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1747A80C0C;
	Mon, 23 Sep 2024 12:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727096006; cv=none; b=UlaL6BVOekyIGBN8sjch92BeMrvIwlQPiblbCGSYiOUU3AoHZKIm02roHviJYWyFh3/js9/hDpqHe+jyBcC0HIE/esfNj4RrqgnV7aoDPXu8mo5URgwTOr+x1XyXoMiNX8QbVDvsHCoNBywzUjlG3K7mYL3XRk1hARYttHJXG2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727096006; c=relaxed/simple;
	bh=U85natxC5lKU5jfLHXEMyFt+8HVrr2Afqb2PHGISf48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJSOwQ+JvoQq0fxJ3TIO89uYPhxA1QhCLcJ8+vIRgS1ScEvdGPuaID8WlakAe/KBUyRHIEO9dQ3XCrdrYApJA1QmxHOBQAY4/STQei3qFTg3cyDXuZFKlnTPC67Tq0+7wJU93f7MSZAq2NTdDGxKkQtmNg1bD2ENW/dp/7dGUzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l32Hvrc9; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727096005; x=1758632005;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U85natxC5lKU5jfLHXEMyFt+8HVrr2Afqb2PHGISf48=;
  b=l32Hvrc9iFSrYlMetHxTLeY6IlXlK//GM82le+PJdujv4L08+DDCdw1T
   71vtDm8wWIlXxvLZBUllC70iFETH7ReMu9U6cdLgCVPM7uyPsw1eSiDlz
   dOLxSp145a5b5/2aOiccLPLcG1L7Epe3snPi8D+nc8gP1irVKdsrs9LLm
   6X4V1v0fPbGfTXtpV1zfr3uA/ODaLAVXlWF1wVWPiDCn/sKFQVY4bwNzh
   yBsrGC32h+fkmuFH8/6Vz3Fx1uStyS1mdw3vvYHNV5X+hiOiGv8CXmVx0
   EqM7TtClE1CWMXi0RLkRrFnQ6Lb1DfVq3yz+gKFk+2l5z7sqZOdCaZh1Y
   A==;
X-CSE-ConnectionGUID: 2RnFhkflS5ecRmij+rRyFg==
X-CSE-MsgGUID: fHjezW+GR7WnlCTXIOR2zQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="37413303"
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="37413303"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 05:53:24 -0700
X-CSE-ConnectionGUID: 5zE+S9xjQg+xOlbaNc96dQ==
X-CSE-MsgGUID: BBTLqyh9QSaCn0jBQvQwcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="70646530"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 05:53:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ssiZ6-0000000Bzph-1uDI;
	Mon, 23 Sep 2024 15:53:20 +0300
Date: Mon, 23 Sep 2024 15:53:19 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Chen <peter.chen@kernel.org>,
	Pawel Laszczak <pawell@cadence.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 1/1] sub: cdns3: Use predefined PCI vendor ID constant
Message-ID: <ZvFkv-xrs1ul7-oI@smile.fi.intel.com>
References: <20240913131710.3630560-1-andriy.shevchenko@linux.intel.com>
 <d6ec3b8b-9405-49fa-ba39-a0bf6311a489@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6ec3b8b-9405-49fa-ba39-a0bf6311a489@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Sep 23, 2024 at 03:42:20PM +0300, Roger Quadros wrote:
> On 13/09/2024 16:17, Andy Shevchenko wrote:
> > The PCI vendor ID for Cadence is defined in pci_ids.h. Use it.
> > While at it, move to PCI_DEVICE() macro and usual pattern for
> > PCI class and device IDs.

...

> > +#define PCI_DEVICE_ID_CDNS_USB3	0x0100
> 
> Why do we need to change this? You did not explain in commit log.

It's explained: "...usual pattern for PCI class and device IDs."

> I would call this PCI_DEVICE_ID_CDNS_USBSS3. Also see later why to differentiate with USBSSP.

It's good to know that there are semantic differences,
but it is already applied, feel free to update.

...

> > -	{ PCI_DEVICE(CDNS_VENDOR_ID, CDNS_DEVICE_ID), },
> > +	{ PCI_VDEVICE(CDNS, PCI_DEVICE_ID_CDNS_USB3) },
> 
> For better readability I still prefer
> 	PCI_DEVICE(PCI_VENDOR_ID_CDNS, PCI_DEVICE_ID_CDNS_USBSS3)

I disagree. The PCI_VDEVICE() has less letters and much easier to get
the vendor from the (less power to parse and decode is required).

...

> > -#define CDNS_DEVICE_ID		0x0200
> > -#define CDNS_DRD_ID		0x0100
> > -#define CDNS_DRD_IF		(PCI_CLASS_SERIAL_USB << 8 | 0x80)
> > +#define PCI_DEVICE_ID_CDNS_USB3		0x0100
> 
> This is an entirely different card who's device ID should be 0x200?
> Also I don't think this card supports USB3 so it is a wrong name choice.

Are you stating that 0x0100 in both cases points to the *different* devices?!
This is unbelievable, however possible abuse of PCI IDs.

> I would call this PCI_DEVICE_ID_CDNS_USBSSP	0x200	to match with PCI driver name.
> 
> > +#define PCI_DEVICE_ID_CDNS_UDC		0x0200
> 
> UDC is used for Peripheral controller only. Is that really the case here?
> originally it was called DRD. 
> So how about?
> 	PCI_DEVICE_ID_CDNS_DRD		0x0100

I strongly disagree. The same PCI IDs should be named the same independently on
how many drivers use them.

The only possibility to have what you propose is the complete screwed up PCI
IDs allocations done by vendor (I do not believe this is the case with Cadence).

-- 
With Best Regards,
Andy Shevchenko



