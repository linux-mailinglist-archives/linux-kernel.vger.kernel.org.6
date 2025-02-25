Return-Path: <linux-kernel+bounces-531140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EE9A43CB6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FFB93AFD33
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C978E2676F9;
	Tue, 25 Feb 2025 11:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MZC6MxVf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C327B33CFC
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481318; cv=none; b=ceCF+k3Cqj6VMbiZW+udfhsV7BipSZDH+pTIyaQYvVczasPC6UNOblL2zQBTcTo41jVyg6VFQhZQ17h7xleF9xLwvxTcJ9KsmKP7Camo1VRw43bb7DqnBPbXZ9zi0Epl8RROIjd2WhoowJrnhXDgY0W8y324V8SdoOk1xTg7bFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481318; c=relaxed/simple;
	bh=D4qXsJKyQFq239rUx6rnyJ+fSvCSHO7MpMmBs3oh1ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCeChnUhphupQGGzPO6CaTpwqNj5hUEP6OGJPirIsdca/JbG2D65kCAg9yNCByvq1fsVcvgSvRlEc7ywfYlpzA/ws0uUh3qpZ4tGLgR/19eq4oTW1cgGbbrHr7Fm2hbnhfJ49Ij1dEpqJIxkCSH3SNt05dce4rj5hpR3EnJm7C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MZC6MxVf; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740481316; x=1772017316;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=D4qXsJKyQFq239rUx6rnyJ+fSvCSHO7MpMmBs3oh1ew=;
  b=MZC6MxVfIg+ZIt0sxotGfRkbHFoMhhmnfmOOkxhMpBsI5O2R7UcrCglK
   hCk/LaF46riXdiWhxR5g3hP0QutjNMV0EaykIWeDxQS/oEjRuZAlebSyT
   wQ93jCn6fc3OFIKRD40l6zQGgaeVe/Y16PcezVExN/9mc05bIvMYMcvqN
   Ydpg7yrPiEBvPgIRMXzV3QO94BRsBX40l9jAlhQNfzeST5a7HIcHfSWpq
   hApmUCI+oaGj7NiI4tS/FZCQb7fnfjJgTOqvHprZNeXsRxRejGypw0LKV
   lFqoUnk2JQ2EH3KYkf454MHHiaCphvdsyfCu4MUybilRhp3Fm3mG2uLXa
   g==;
X-CSE-ConnectionGUID: wyPm0AnsTOqo66DvjwI0Qw==
X-CSE-MsgGUID: 0j18B6FgRJyDiEs2I6pEVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="44935392"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="44935392"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 03:01:56 -0800
X-CSE-ConnectionGUID: Ncn+hCRgRHe+qusVAxKmWA==
X-CSE-MsgGUID: 9dNJgE7NRDCIuSZ14ws9vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="116127774"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 03:01:54 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tmshB-0000000Extv-3xHr;
	Tue, 25 Feb 2025 13:01:49 +0200
Date: Tue, 25 Feb 2025 13:01:49 +0200
From: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"mripard@kernel.org" <mripard@kernel.org>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"simona@ffwll.ch" <simona@ffwll.ch>,
	Kerem Karabay <kekrby@gmail.com>,
	Atharva Tiwari <evepolonium@gmail.com>,
	Aun-Ali Zaidi <admin@kodeit.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v5 2/2] drm/tiny: add driver for Apple Touch Bars in x86
 Macs
Message-ID: <Z72jHeCG6-ByMyhh@smile.fi.intel.com>
References: <3457BF95-0E50-4B70-86DE-EE5EE95D3ACE@live.com>
 <4D7C00B4-7B75-4715-8D37-0059B22C030D@live.com>
 <Z72chunE_vvxtjLQ@smile.fi.intel.com>
 <PN3PR01MB9597BF95EC490951D75748F1B8C32@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <Z72foRL3diil9icd@smile.fi.intel.com>
 <PN3PR01MB9597B5ECF47B04E3201DD56BB8C32@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PN3PR01MB9597B5ECF47B04E3201DD56BB8C32@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 25, 2025 at 10:48:53AM +0000, Aditya Garg wrote:
> > On 25 Feb 2025, at 4:17 PM, andriy.shevchenko@linux.intel.com wrote:
> > On Tue, Feb 25, 2025 at 10:36:03AM +0000, Aditya Garg wrote:
> >>>> On 25 Feb 2025, at 4:03 PM, andriy.shevchenko@linux.intel.com wrote:
> >>> On Tue, Feb 25, 2025 at 10:09:42AM +0000, Aditya Garg wrote:

...

> >>>> +static int appletbdrm_probe(struct usb_interface *intf,
> >>>> +                const struct usb_device_id *id)
> >>>> +{
> >>>> +    struct usb_endpoint_descriptor *bulk_in, *bulk_out;
> >>>> +    struct device *dev = &intf->dev;
> >>>> +    struct appletbdrm_device *adev;
> >>>> +    struct drm_device *drm;
> >>>> +    int ret;
> >>>> +
> >>>> +    ret = usb_find_common_endpoints(intf->cur_altsetting, &bulk_in, &bulk_out, NULL, NULL);
> >>>> +    if (ret) {
> >>>> +        drm_err(drm, "Failed to find bulk endpoints\n");
> >>> 
> >>> This is simply wrong (and in this case even lead to crash in some circumstances).
> >>> drm_err() may not be used here. That's my point in previous discussions.
> >>> Independently on the subsystem the ->probe() for the sake of consistency and
> >>> being informative should only rely on struct device *dev,
> >> 
> >> I'm not sure how drm_err works,
> > 
> > It's a macro.
> > 
> >> but struct drm_device does have a struct device *dev as well.
> > 
> > Yes, but only when it's initialized.
> > 
> >> Anyways, this is something I'll leave for Thomas to reply.
> > 
> > The code above is wrong independently on his reply :-)
> 
> I'm kinda stuck between contrasting views of 2 kernel maintainers lol,
> so I said let Thomas reply.

Sure. I also want him to clarify my question about potential drm_err_probe().

-- 
With Best Regards,
Andy Shevchenko



