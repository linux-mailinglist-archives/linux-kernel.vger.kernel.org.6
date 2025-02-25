Return-Path: <linux-kernel+bounces-531461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C78AA440C8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45223177751
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4139B269CEC;
	Tue, 25 Feb 2025 13:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FIL69+8t"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1324269AE0
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740489936; cv=none; b=FPSaY+9oVGqIX9uJN+ZxRMI+vMeJfLlObxxoy51AToHAomFmEzC3TYhVTyb2dTq4EvKZqLzVSOGXXM5P5AaBBkKGMX8PCtOP41nqlPiiQDXtRNffejibmc5yHMAZzY8C6zkjhRzny9r8iFwYBW0MUkNI+mqyFIvDXCzqNITRXsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740489936; c=relaxed/simple;
	bh=qEEiXRmbmH15S7cSjAiyYqtzG/R8Me/5JqNxRGlCemk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMrYmitc6dm1QinykyCbT6ABIOHok3HIOPEOEXKLRis4EJn4tIebpWgwQhgx1btf54crEzh1Xc+1ogTi+QqgG8Xqq4vRAPO2xvn0Bak3g2iWGmcGUqJLQ+Ix+ObBGtN3OsIjoBeLk/Qa4Nwr8X+wDD8MZ4YZ2ST/noJckCgX1CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FIL69+8t; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740489936; x=1772025936;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qEEiXRmbmH15S7cSjAiyYqtzG/R8Me/5JqNxRGlCemk=;
  b=FIL69+8tVqmvnpDmgu4tPjIQTV4ycGHQAxfQ1ZcuPohaYhWxdTiiQO5z
   vyHTDxmQiNiyQE+wqWGiIy8JAiHppmKYq35ef+8f2UEvMMEGbjCSBiI74
   BoHVjdQ0NlXShpCTkvn12CeX/qN3uHtW/mJoPdJATSKw4x9uen+b9MMct
   TchjqU/D3m3fqTbHI8sJ+s2JxbwttulkiDJm8S9pAaqIjg4j6wzmu+2k8
   rKogfZEOS9KM/r3W7oN72kx65nRRqrOz8sGKE7sBdTjwE2ieI2E6dekgO
   A8mUFf0ryamssEpLq4pshtGvQsN0ktJsP4u1YY7EIwoEvzpbZhDWwcuPl
   w==;
X-CSE-ConnectionGUID: SoW40jCmQZ6IwwNFMW0V3Q==
X-CSE-MsgGUID: IbtSx0/uQWijGpl6MSVYyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="58716561"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="58716561"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 05:25:34 -0800
X-CSE-ConnectionGUID: u360bJP2QKSSwuDGNw0hLA==
X-CSE-MsgGUID: pxn6umOwRN2Mi/+YYbpfzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121638078"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 05:25:30 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tmuwA-0000000F0Dy-2Lx5;
	Tue, 25 Feb 2025 15:25:26 +0200
Date: Tue, 25 Feb 2025 15:25:26 +0200
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
Message-ID: <Z73ExmFOcOoozjxS@smile.fi.intel.com>
References: <3457BF95-0E50-4B70-86DE-EE5EE95D3ACE@live.com>
 <4D7C00B4-7B75-4715-8D37-0059B22C030D@live.com>
 <Z72chunE_vvxtjLQ@smile.fi.intel.com>
 <c0249cd8-68e4-4860-b5c3-e054df10ae30@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0249cd8-68e4-4860-b5c3-e054df10ae30@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 25, 2025 at 12:58:17PM +0100, Thomas Zimmermann wrote:
> Am 25.02.25 um 11:33 schrieb andriy.shevchenko@linux.intel.com:
> > On Tue, Feb 25, 2025 at 10:09:42AM +0000, Aditya Garg wrote:

...

> > > +static int appletbdrm_probe(struct usb_interface *intf,
> > > +			    const struct usb_device_id *id)
> > > +{
> > > +	struct usb_endpoint_descriptor *bulk_in, *bulk_out;
> > > +	struct device *dev = &intf->dev;
> > > +	struct appletbdrm_device *adev;
> > > +	struct drm_device *drm;
> > > +	int ret;
> > > +
> > > +	ret = usb_find_common_endpoints(intf->cur_altsetting, &bulk_in, &bulk_out, NULL, NULL);
> > > +	if (ret) {
> > > +		drm_err(drm, "Failed to find bulk endpoints\n");
> > This is simply wrong (and in this case even lead to crash in some circumstances).
> > drm_err() may not be used here. That's my point in previous discussions.
> > Independently on the subsystem the ->probe() for the sake of consistency and
> > being informative should only rely on struct device *dev,
> 
> That's never going to work with DRM. There's so much code in a DRM probe
> function that uses the DRM error functions.

> This specific instance here is wrong, as the drm pointer hasn't been
> initialized. But as soon as it is, it's much better to use drm_err() and
> friends. It will do the right thing and give consistent output across
> drivers.

Okay and my question was how is it possible to create drm_err_probe() for such
cases?

> > > +		return ret;
> > > +	}

-- 
With Best Regards,
Andy Shevchenko



