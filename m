Return-Path: <linux-kernel+bounces-511743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A41E6A32F0A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 19:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93F897A19DD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7F226137F;
	Wed, 12 Feb 2025 18:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TiuiBGKs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C2525EF88;
	Wed, 12 Feb 2025 18:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739386744; cv=none; b=hVC5/XYEQyty+wHC1OzHQ5kepiyR6F5e39RwewYYIbDvmB5SPp02JplnvxxaJc+bpIiFhehIlf9+KTIRi6SePAwA1/ta+6vkNxyXqqbldLCHrh0VvbsbprANlcNcKKbHxddKQ9oRzAzk1hS0PpDMdlfFoJ0BmiLxjgz+efhN23w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739386744; c=relaxed/simple;
	bh=Zk7FJ7btxlw0hRfaHcGkLDDih6cY2ZE/wjh7BK0O+og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgDSnTOS4GK5RNEor1pXjR0/UY0JPEfFdSqWhkgSNAV1FNE9tAiEqB4snx7a0rM1d6JuKjZInsC/KftYmkfshTImwMmvM33Z5EaJnn6vYtzN1Jjmx1A7x3sN1zgMXXwXLZhIE0v5z/i8LskpCUH4RGRqEi5AvzhW8MBvjDlaY2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TiuiBGKs; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739386743; x=1770922743;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zk7FJ7btxlw0hRfaHcGkLDDih6cY2ZE/wjh7BK0O+og=;
  b=TiuiBGKspa7UFLC5qeXvaAIRCNFpNaRtZtWff5IvrOe93dWq6qlHxL8p
   Ff/tvNDfxj4QGmiAbeplHFAq+d2Y0nh7CoDGycwX288p7X4vpdCBHYTEb
   8Eazi8osa+o6HHPCCPetujtwsESdD3n2xYFNw14Wfq9UBxHasBzcSQSGF
   8nP7VvLBIpfdHWNbGM0bchxpe6qP074FMduBBjzqda6E3DdP+o5Nfj6cq
   NqKKG6Dk7Y9jIpvQSMOUqvhxSe2wxRsDuMr+fB91i8CcjY1W2Vdp87jbu
   /8sRr3EP6om1Sh3CDdwR2Xuepy/pRixevcX5MF2giG5QhJ6XqoFq91D92
   A==;
X-CSE-ConnectionGUID: Ed7F1ZSYTay5BzvI2AihIQ==
X-CSE-MsgGUID: Dh+MJT84RDqg9Dz31lLPZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="39296644"
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="39296644"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 10:59:02 -0800
X-CSE-ConnectionGUID: xVFuoFdNQt+dXmAz5x+bfw==
X-CSE-MsgGUID: uvfo8LCzQS66qVy3BnI7dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="113428685"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 10:59:00 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tiHwn-0000000Avkf-1ae5;
	Wed, 12 Feb 2025 20:58:57 +0200
Date: Wed, 12 Feb 2025 20:58:57 +0200
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
Message-ID: <Z6zvcF1oe4TklTlK@smile.fi.intel.com>
References: <20250203191524.3730346-1-andriy.shevchenko@linux.intel.com>
 <20250203191524.3730346-3-andriy.shevchenko@linux.intel.com>
 <20250212011013.xumqgguhluxdslpz@synopsys.com>
 <Z6x5lB4hGpz-9IzS@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6x5lB4hGpz-9IzS@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 12, 2025 at 12:36:04PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 12, 2025 at 01:10:17AM +0000, Thinh Nguyen wrote:
> > On Mon, Feb 03, 2025, Andy Shevchenko wrote:

...

> > > static bool dwc3_gadget_endpoint_trbs_complete(struct dwc3_ep *dep,
> 
> > >  		for (i = 0; i < DWC3_ENDPOINTS_NUM; i++) {
> > >  			dep = dwc->eps[i];
> > > +			if (!dep)
> > > +				continue;
> > 
> > It should be fine to ignore this check here. Something must be really
> > wrong if there's an interrupt pointing to an endpoint that we shouldn't
> > be touching. If we do add a check, we should print a warn or something
> > here. But that should be a patch separate from this.
> 
> Theoretically everything is possible as it may be HW integration bug,
> for example. But are you asking about separate patch even from the rest
> of the checks? Please, elaborate what do you want to see.

Re-reading the code again, I don't understand. If we get to this loop
ever (theoretically it might be an old IP with the reserved endpoints),
we crash the kernel on the first gap in the array. And since the function
is called on an endpoint, it doesn't mean that all endpoints are allocated,
so I do not see the justification to issue a warning here.
Or do you imply that DWC3_VER_IS_PRIOR(DWC3, 183A) may not have an HW
integration similar to what we have on Intel Merrifield?

For now I'm going to leave this check as is.

...

> > > static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
> 
> > >  	dep = dwc->eps[epnum];
> > > +	if (!dep)
> > > +		return;
> > 
> > Same here.

Here I agree and I will add a warning message. Indeed, if we get and interrupt
for undefined endpoint, something is not correct.

-- 
With Best Regards,
Andy Shevchenko



