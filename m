Return-Path: <linux-kernel+bounces-510912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40748A3238B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5ED43A34A0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08615208965;
	Wed, 12 Feb 2025 10:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WhrjfjhQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF761F9A83;
	Wed, 12 Feb 2025 10:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739356572; cv=none; b=EOcGjwmhCxMNSal61Ze8hUe9nqXiMjQ9GIe9C1aZNbe7Y1BPAtfLX2waTgokPy1oKJPdhAiOQTrl4fKv4tdm2DlyHOJRzIAr7Htf38bmbJsjZAnp4mfL/Ds3C02AjwriFCB0YrOtEjCYTt2GZYWdN/tWxIXGBKWXH87aqg83DDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739356572; c=relaxed/simple;
	bh=U+c+IUesQkxYjvnR8zFinWB/EQGDYXNhX1r/1VZq/90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thR57lRMNpjknVGTRJGddLaSzWivDLU3t7Ux5TrqQEPLYAxnlvviV+GSYl+VKJzYl0NOcNURL9QTu2bOPAbHmyFaTYJhydXBUs/5WjUZt/2dJKDZ8AK/qNOKCEG2nfhJqW3fBENw1yoaQLTtJoNmoNOEd7vMgcPEwAD7KLz4ofM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WhrjfjhQ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739356570; x=1770892570;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U+c+IUesQkxYjvnR8zFinWB/EQGDYXNhX1r/1VZq/90=;
  b=WhrjfjhQWWn2q6/76i5lNqeK9xKOothc5klws1igxbASpgpl+ta0rNRw
   61uf1K58BFrpgaR/MGG5wwJel9XHXSCbZdQeL01I63ogXHDFgkFJUji/1
   qtMULAma4H74NWDm5dqsJXxDbQlrbKdvgE2hrklxl6jL+7Pnjvx/TaGFG
   CehT3Y+RZtZ6Trm//bym9r0IexrZ3VAxJtFmaxFs4VyJYb7MyLzO3AVEN
   WIOzekmGHdDzMZxSV6Ruu0XIpB8Zesb0/SraigTgN+lVe2riD5wQTd8x0
   DmoqgqYeX8odE/gJwooDjjmbmJM86BsmDoBnHGx+9b6Ohn2GqDIfk1VnL
   g==;
X-CSE-ConnectionGUID: jo3EgtJ9RiKlFsHKbvxvyQ==
X-CSE-MsgGUID: t91MvRu0RymvMZEb7Ex+KA==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="50229048"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="50229048"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 02:36:10 -0800
X-CSE-ConnectionGUID: b9QEK0mWTSSiC354VRZ84w==
X-CSE-MsgGUID: yuaYBeT9RWSiK4YYAVlyRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="117799074"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 02:36:07 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tiA68-0000000Anyl-3KQh;
	Wed, 12 Feb 2025 12:36:04 +0200
Date: Wed, 12 Feb 2025 12:36:04 +0200
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
Message-ID: <Z6x5lB4hGpz-9IzS@smile.fi.intel.com>
References: <20250203191524.3730346-1-andriy.shevchenko@linux.intel.com>
 <20250203191524.3730346-3-andriy.shevchenko@linux.intel.com>
 <20250212011013.xumqgguhluxdslpz@synopsys.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212011013.xumqgguhluxdslpz@synopsys.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 12, 2025 at 01:10:17AM +0000, Thinh Nguyen wrote:
> On Mon, Feb 03, 2025, Andy Shevchenko wrote:
> > The snps,reserved-endpoints property lists the reserved endpoints
> > that shouldn't be used for normal transfers. Add support for that
> > to the driver.

> > While at it, make sure we don't crash by a sudden access to those
> > endpoints in the gadget driver.

^^^ (1)

...

> >  	/* Reset resource allocation flags */
> > -	for (i = resource_index; i < dwc->num_eps && dwc->eps[i]; i++)
> > -		dwc->eps[i]->flags &= ~DWC3_EP_RESOURCE_ALLOCATED;
> > +	for (i = resource_index; i < dwc->num_eps; i++) {
> > +		dep = dwc->eps[i];
> > +		if (!dep)
> > +			continue;
> > +
> > +		dep->flags &= ~DWC3_EP_RESOURCE_ALLOCATED;
> > +	}
> 
> Please keep code refactoring as a separate patch.

It's induced by the change you asked for, it's not a simple refactoring.

Or do you want me to have the patch to check eps against NULL to be separated
from this one (see (1) above)?

> >  
> >  	return 0;

...

> > +static int dwc3_gadget_parse_reserved_endpoints(struct dwc3 *dwc, const char *propname,
> > +						u8 *eps, u8 num)
> > +{
> > +	u8 count;
> > +	int ret;
> > +
> > +	if (!device_property_present(dwc->dev, propname))
> > +		return 0;
> > +
> > +	ret = device_property_count_u8(dwc->dev, propname);
> > +	if (ret < 0)
> > +		return ret;
> > +	count = ret;
> > +
> > +	ret = device_property_read_u8_array(dwc->dev, propname, eps, min(num, count));
> 
> Why do min(num, count)? Can we just put the size of the eps array as
> specified by the function doc.

No, we can't ask more than there is. The call will fail in such a case.
In case you wonder, the similar OF call also behaves in the same way.

> > +	if (ret)
> > +		return ret;
> > +
> > +	return count;
> > +}

...

> >  static int dwc3_gadget_init_endpoints(struct dwc3 *dwc, u8 total)
> >  {
> > +	const char			*propname = "snps,reserved-endpoints";
> >  	u8				epnum;
> > +	u8				eps[DWC3_ENDPOINTS_NUM];
> 
> Can we rename eps to reserved_eps.

Sure.

> > +	u8				count;
> > +	u8				num;
> > +	int				ret;
> >  
> >  	INIT_LIST_HEAD(&dwc->gadget->ep_list);
> >  
> > +	ret = dwc3_gadget_parse_reserved_endpoints(dwc, propname, eps, ARRAY_SIZE(eps));
> 
> Base on the name of this function, I would expect the return value
> to be a status and not a count. Since we are not really parsing but
> getting the property array. Can we rename this to
> dwc3_gadget_get_reserved_endpoints()?

Sure.

> > +	if (ret < 0) {
> > +		dev_err(dwc->dev, "failed to read %s\n", propname);
> > +		return ret;
> > +	}
> > +	count = ret;

...

> > static bool dwc3_gadget_endpoint_trbs_complete(struct dwc3_ep *dep,

> >  		for (i = 0; i < DWC3_ENDPOINTS_NUM; i++) {
> >  			dep = dwc->eps[i];
> > +			if (!dep)
> > +				continue;
> 
> It should be fine to ignore this check here. Something must be really
> wrong if there's an interrupt pointing to an endpoint that we shouldn't
> be touching. If we do add a check, we should print a warn or something
> here. But that should be a patch separate from this.

Theoretically everything is possible as it may be HW integration bug,
for example. But are you asking about separate patch even from the rest
of the checks? Please, elaborate what do you want to see.

...

> > static void dwc3_endpoint_interrupt(struct dwc3 *dwc,

> >  	dep = dwc->eps[epnum];
> > +	if (!dep)
> > +		return;
> 
> Same here.
> 
> Looks like the only NULL check needed is in
> dwc3_gadget_clear_tx_fifos().

Seems more, see above.

-- 
With Best Regards,
Andy Shevchenko



