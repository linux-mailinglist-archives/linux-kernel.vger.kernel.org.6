Return-Path: <linux-kernel+bounces-512457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EF6A33990
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014EE1885622
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 08:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470E620B213;
	Thu, 13 Feb 2025 08:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fCqQtozR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE6A1FCFE2;
	Thu, 13 Feb 2025 08:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739433783; cv=none; b=F5YyAcBVY8Hk/Deq9QdhE/DRK7wRz7ad22OUT8g0Pz2QiKrQnv+BVa3K6/HWm4UeIKBOJmcYnOT35veqNWoEGvkPbR7T9pIj8GJX9AphcXD1ZRk8mi5bZ3LSAUK3joSwGdAn8XcLEtlM8zoV6IGblFFnFCJVeH8wHbYZXUTPqGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739433783; c=relaxed/simple;
	bh=pfT5sc7hzajU5onSqToJLvsnBMeoQjI5q0FLEyT7wkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8nM0qhWoYmUVPToVwKNJSYbWyJX9pfSW6B+hT33nEtbwY2vABGtskywjvx7YqLaXbSiMolabRIrY2yGSDzsxk5vIDeJ6bMI1Hd52O132YqF71fSs6sJ+wb6RYdbZgaCOmb9A9y2ax+18zi6ySrGsPVxq8zCS+AysIDhdlb5VOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fCqQtozR; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739433782; x=1770969782;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pfT5sc7hzajU5onSqToJLvsnBMeoQjI5q0FLEyT7wkk=;
  b=fCqQtozR2iusV9bGs3EHobVvYYMMJ+4vm4TYCnJy7MBql8JbG7AOx8y9
   b3EGn8ObNjaql3YNW3Azvgx9axSkv2ej9XHo+Z/t3BpmKQ2kWIjpmQjc5
   qAJLB4ejY15KSx+tWCg+MPNwWxd6+MhnsFhz3eEimdE8emvpy57DEkH6J
   +UGn43Pak9uQBqLpW+aBnjpppi1THjS0z7gSRVzgvWSXkUKhtR3ULMbyw
   kFcH6BwE1SthxqKMpZHH1soRKEIvq136wN4gExPoD57Qsrr2YEggz8bzX
   52mLlgQ3qUzdlwSRdK7T5abOmWeYYqXh4r6PjAaQBtpWuA0dyDvPSzKn4
   g==;
X-CSE-ConnectionGUID: UbvZ8aKzTrm3HTG1KP5h1g==
X-CSE-MsgGUID: 1Iol/4BnSmadv8EV9CsbvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="51516696"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="51516696"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 00:03:01 -0800
X-CSE-ConnectionGUID: ArrV/TiYTpa5i+1/kH3lCA==
X-CSE-MsgGUID: +SZ3HFKERlGPAbVLzdZ7Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118257002"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 00:02:56 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tiUBR-0000000B6BT-25ED;
	Thu, 13 Feb 2025 10:02:53 +0200
Date: Thu, 13 Feb 2025 10:02:53 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Felipe Balbi <balbi@kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ferry Toth <fntoth@gmail.com>
Subject: Re: [PATCH v2 2/3] usb: dwc3: gadget: Add support for
 snps,reserved-endpoints property
Message-ID: <Z62nLY_m_FG1Phc7@smile.fi.intel.com>
References: <20250203191524.3730346-1-andriy.shevchenko@linux.intel.com>
 <20250203191524.3730346-3-andriy.shevchenko@linux.intel.com>
 <20250212011013.xumqgguhluxdslpz@synopsys.com>
 <Z6x5lB4hGpz-9IzS@smile.fi.intel.com>
 <20250213011610.ov3q2rq6bfzdzqlk@synopsys.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213011610.ov3q2rq6bfzdzqlk@synopsys.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 13, 2025 at 01:16:15AM +0000, Thinh Nguyen wrote:
> On Wed, Feb 12, 2025, Andy Shevchenko wrote:
> > On Wed, Feb 12, 2025 at 01:10:17AM +0000, Thinh Nguyen wrote:
> > > On Mon, Feb 03, 2025, Andy Shevchenko wrote:

...

> > > >  	/* Reset resource allocation flags */
> > > > -	for (i = resource_index; i < dwc->num_eps && dwc->eps[i]; i++)
> > > > -		dwc->eps[i]->flags &= ~DWC3_EP_RESOURCE_ALLOCATED;
> > > > +	for (i = resource_index; i < dwc->num_eps; i++) {
> > > > +		dep = dwc->eps[i];
> > > > +		if (!dep)
> > > > +			continue;
> > > > +
> > > > +		dep->flags &= ~DWC3_EP_RESOURCE_ALLOCATED;
> > > > +	}
> > > 
> > > Please keep code refactoring as a separate patch.
> > 
> > It's induced by the change you asked for, it's not a simple refactoring.
> > 
> > Or do you want me to have the patch to check eps against NULL to be separated
> > from this one (see (1) above)?
> 
> The condition "i < dwc->num && dwc->eps[i]" already does the NULL check.
> The change here only move things around.

Yes, but the problem is that the loop will stop on the first gap, but we would
like to continue.

> > > >  	return 0;

-- 
With Best Regards,
Andy Shevchenko



