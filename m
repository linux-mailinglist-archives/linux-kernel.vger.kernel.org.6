Return-Path: <linux-kernel+bounces-531594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE52BA4427A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208853B6D08
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A2326A091;
	Tue, 25 Feb 2025 14:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LbSTngRZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3441C20F076
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740493057; cv=none; b=j44juNkgybvJ6EuSfiJezbIvgLw/dwBsqcw1yduwP3PkKAt/WB5kXNRdP9+C1g1IiCbYeqxqmhTuDFm0erFtkAqSsJOHmDknz7OkG6ROPlY4mkoNB6YOJmdWZ4O2GzKylfT55N7FBSrMGze5zptpv3r0U6M0FooB7IK0myRQeuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740493057; c=relaxed/simple;
	bh=yTbYCkPyDs9HJxuZtoE4K/vi15XYDIgffTPgZMP+G3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzfV9Hft5MfmLg/p59gvAktkf78E4Dgq4luss06ayPTQrhaIF0EYLYqoBIH6HUX8HmBjjgMZKcq3/WeQpV/zsQQyA6J7hRuMtaRfSv9MEQJ2wP9Y8CPvyWlVF54mTkLG+ssXFuy7DLckcEONOe3P0fYc0pMokEzxZWWty5ZPb0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LbSTngRZ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740493056; x=1772029056;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=yTbYCkPyDs9HJxuZtoE4K/vi15XYDIgffTPgZMP+G3w=;
  b=LbSTngRZ6C4u4+WNYKdzItxw4EWg/q3kA0pgL74YrYLBIWP4avRvY8D7
   nPLWmrXMlwkI+Wz02D9Okf5bMjOpZsTQwOZXirdskqszqY72x0Ou8f0zq
   9M1gW3aFs2byjObORrWl3zFWu9XzBBHtm6LO6dD8iDopafaW+cJHgJSSH
   8Wzp/+kiar8Jv1xjdKw5wIxLJau3L0ki9FpxGH6awtPyxf3UNIiYPZVS0
   dOZLjQHZdzhhQuUPWfkwUVV7eGDlJd+tNVFe3zDKFON5c7QUif0jBlOjX
   TbCDRV4ev3oDBTFQUECbBDC3bE1Sx5e3P0DFvVWv0zJJ+Wct5uOFicQXR
   g==;
X-CSE-ConnectionGUID: kODELuPoTq2tIvF3JaS0EA==
X-CSE-MsgGUID: hW1XqzrzRWCHAoc01dvOyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="58721191"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="58721191"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 06:17:35 -0800
X-CSE-ConnectionGUID: RZ3Uz0IuSXqYNtv0TCeFew==
X-CSE-MsgGUID: VjTSyfcwSc2zxpxaTWjU/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="147219225"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 06:17:31 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tmvkW-0000000F0yK-03rr;
	Tue, 25 Feb 2025 16:17:28 +0200
Date: Tue, 25 Feb 2025 16:17:27 +0200
From: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Aditya Garg <gargaditya08@live.com>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"mripard@kernel.org" <mripard@kernel.org>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"simona@ffwll.ch" <simona@ffwll.ch>,
	Kerem Karabay <kekrby@gmail.com>,
	Atharva Tiwari <evepolonium@gmail.com>,
	Aun-Ali Zaidi <admin@kodeit.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v5 2/2] drm/tiny: add driver for Apple Touch Bars in x86
 Macs
Message-ID: <Z73Q99khFU9pvoNx@smile.fi.intel.com>
References: <3457BF95-0E50-4B70-86DE-EE5EE95D3ACE@live.com>
 <4D7C00B4-7B75-4715-8D37-0059B22C030D@live.com>
 <Z72chunE_vvxtjLQ@smile.fi.intel.com>
 <PN3PR01MB9597BF95EC490951D75748F1B8C32@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <Z72foRL3diil9icd@smile.fi.intel.com>
 <PN3PR01MB9597B5ECF47B04E3201DD56BB8C32@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <Z72jHeCG6-ByMyhh@smile.fi.intel.com>
 <9efdb233-2bca-4a5d-a6bc-de81fa96efb3@suse.de>
 <Z73FSWR-DK0HxMb2@smile.fi.intel.com>
 <71123020-f345-4de3-9044-ad58f8066d86@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71123020-f345-4de3-9044-ad58f8066d86@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 25, 2025 at 02:53:15PM +0100, Thomas Zimmermann wrote:
> Am 25.02.25 um 14:27 schrieb andriy.shevchenko@linux.intel.com:
> > On Tue, Feb 25, 2025 at 12:59:43PM +0100, Thomas Zimmermann wrote:
> > > Am 25.02.25 um 12:01 schrieb andriy.shevchenko@linux.intel.com:
> > > > On Tue, Feb 25, 2025 at 10:48:53AM +0000, Aditya Garg wrote:
> > > > > > On 25 Feb 2025, at 4:17 PM, andriy.shevchenko@linux.intel.com wrote:
> > > > > > On Tue, Feb 25, 2025 at 10:36:03AM +0000, Aditya Garg wrote:
> > > > > > > > > On 25 Feb 2025, at 4:03 PM, andriy.shevchenko@linux.intel.com wrote:
> > > > > > > > On Tue, Feb 25, 2025 at 10:09:42AM +0000, Aditya Garg wrote:

...

> > > > > > > > > +static int appletbdrm_probe(struct usb_interface *intf,
> > > > > > > > > +                const struct usb_device_id *id)
> > > > > > > > > +{
> > > > > > > > > +    struct usb_endpoint_descriptor *bulk_in, *bulk_out;
> > > > > > > > > +    struct device *dev = &intf->dev;
> > > > > > > > > +    struct appletbdrm_device *adev;
> > > > > > > > > +    struct drm_device *drm;
> > > > > > > > > +    int ret;
> > > > > > > > > +
> > > > > > > > > +    ret = usb_find_common_endpoints(intf->cur_altsetting, &bulk_in, &bulk_out, NULL, NULL);
> > > > > > > > > +    if (ret) {
> > > > > > > > > +        drm_err(drm, "Failed to find bulk endpoints\n");
> > > > > > > > This is simply wrong (and in this case even lead to crash in some circumstances).
> > > > > > > > drm_err() may not be used here. That's my point in previous discussions.
> > > > > > > > Independently on the subsystem the ->probe() for the sake of consistency and
> > > > > > > > being informative should only rely on struct device *dev,
> > > > > > > I'm not sure how drm_err works,
> > > > > > It's a macro.
> > > > > > 
> > > > > > > but struct drm_device does have a struct device *dev as well.
> > > > > > Yes, but only when it's initialized.
> > > > > > 
> > > > > > > Anyways, this is something I'll leave for Thomas to reply.
> > > > > > The code above is wrong independently on his reply :-)
> > > > > I'm kinda stuck between contrasting views of 2 kernel maintainers lol,
> > > > > so I said let Thomas reply.
> > > > Sure. I also want him to clarify my question about potential drm_err_probe().
> > > These threads get a little lengthy. What is the question?
> > How drm_err_probe() can be (consistently) implemented as there are and will be
> > cases when we want to return an error code with the message and having DRM devce
> > not being available, please?
> 
> The DRM logging works with a DRM device pointer of NULL. It'll simply leave
> out device infos.

Right and that's what makes it less informative than pure dev_*() macros.
For the probe it should really take the struct device instead of struct drm
in my opinion. Otherwise we may end up with the code like above, which has
hidden bugs.

> > Also, drm_err() has a downside of not checking for deferred probe and
> > potentially leads to the noisy log floods.
> 
> I think it should be possible to export __dev_probe_failed() [1] from the
> core and write drm_err_probe() and drm_warn_probe() around this.

Yep, we can do that

> The output then looks like a DRM logging, but behaves like dev-based logging.
> Note that DRM logging already is an elaborate wrapper around the dev-based
> logging, so it will be more of the same.

Okay, this sounds promising. My only worries are the possibilities of misuse of
the API and/or leaving it non- or less informative (in comparison to the existing
helpers).

> [1] https://elixir.bootlin.com/linux/v6.13.4/source/drivers/base/core.c#L5008

-- 
With Best Regards,
Andy Shevchenko



