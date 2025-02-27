Return-Path: <linux-kernel+bounces-536666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A60E0A482D0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52D061644CC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705AD26AABB;
	Thu, 27 Feb 2025 15:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gwtj2mKv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F8324E00D;
	Thu, 27 Feb 2025 15:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740669509; cv=none; b=ry0CsM/eauJEduIutbRjtwN6eaXNwugJX1lZKmNC05jQgsQkwFStFZVi5Nb1WAwbM3jd1uQPa7wk/FAcgLtC6HZ9qZMGjpyFDc9yGfbFtI848t4CtFKdjmKlI+sT2nw4ZMPmuwNX70dvQhZnZt95Z0lgoW0JjIYwnbej8cQCA+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740669509; c=relaxed/simple;
	bh=mSWt4b4ZxXi0KA9FBMo646RcxHQZCFNqS+JJR+o5VK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7ZDEkZssBmfOqIxIp90JmsHJqcFvaVPkuLE5ODEGsthIkeLfxfU1kHRXrjmpwD/7tCYrdkGrp9sRtKGIgsx2YM5q5CTDmJlJHkyyI70bDFdBL6BYjbrJ4dcFWYj0/jcUObAe45ftkwxNFcnTHJQAwwz6aegfSfaEYGGuG0TuNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gwtj2mKv; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740669509; x=1772205509;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=mSWt4b4ZxXi0KA9FBMo646RcxHQZCFNqS+JJR+o5VK8=;
  b=gwtj2mKv7QxCBskdXVBB/Y9TzifwnM4PJyyc0kTGByDYBukP5X5RVPqY
   cqomEg0XTnu57b+hiEzOtU8tQszzPjnSHscbsK6OTccqA7EdvEpwGxRv3
   JlGDk1NDX6SVR/75/9543rgPB63FEeQUPhBLUbC8cD2p587xHwWVGeynG
   jNui7pDyS8cicNJsgEKDIsJQMn4khPwUiMf0uY567cjVxKscnmbakOITl
   iNjzko8nftbq1nPU0a8sY6mxWTIsemO/Hhehv5XIaQ9hfnWxqlkCjzjaR
   XzZKTZuuOIZpudwHne8EXdIjiEtTmHC6nPf/MdHhjclCu73ZWfhs99jF6
   A==;
X-CSE-ConnectionGUID: N/RJTBv3TVGGeTouL6v7Cg==
X-CSE-MsgGUID: Iplg1hfYToSEcLrpwxHTqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="64032279"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="64032279"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 07:18:28 -0800
X-CSE-ConnectionGUID: 42btFfALSlOSBTUcCnaUxg==
X-CSE-MsgGUID: YOti/ze+SqG/lhBilM5wOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="147972350"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 07:18:23 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tnfeW-0000000Fd9t-1ddb;
	Thu, 27 Feb 2025 17:18:20 +0200
Date: Thu, 27 Feb 2025 17:18:20 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Lukas Wunner <lukas@wunner.de>,
	Mark Brown <broonie@kernel.org>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Robin Murphy <robin.murphy@arm.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Zijun Hu <quic_zijuhu@quicinc.com>, linux-usb@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	=?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Subject: Re: [PATCH v4 0/9] Driver core: Add faux bus devices
Message-ID: <Z8CCPIoeNoG6m7FT@smile.fi.intel.com>
References: <2025021023-sandstorm-precise-9f5d@gregkh>
 <7d196a91-220a-41a5-8577-198b436d8440@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d196a91-220a-41a5-8577-198b436d8440@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 27, 2025 at 02:06:21PM +0100, Louis Chauvet wrote:
> Le 10/02/2025 à 13:30, Greg Kroah-Hartman a écrit :
> > For years/decades now, I've been complaining when I see people use
> > platform devices for things that are obviously NOT platform devices.
> > To finally fix this up, here is a "faux bus" that should be used instead
> > of a platform device for these tiny and "fake" devices that people
> > create all over the place.
> > 
> > The api is even simpler than the normal platform device api, just two
> > functions, one to create a device and one to remove it.  When a device
> > is created, if a probe/release callback is offered, they will be called
> > at the proper time in the device's lifecycle.  When finished with the
> > device, just destroy it and all should be good.
> > 
> > This simple api should also hopefully provide for a simple rust binding
> > to it given the simple rules and lifecycle of the pointer passed back
> > from the creation function (i.e. it is alive and valid for as long as
> > you have not called destroy on it.)
> > 
> > I've also converted four different examples of platform device abuse, the
> > dummy regulator driver, the USB phy code, the x86 microcode dvice, and
> > the "regulator" device that wifi uses to load the firmware tables, to
> > use this api.  In all cases, the logic either was identical, or became
> > simpler, than before, a good sign (side note, a bug was fixed in the usb
> > phy code that no one ever noticed before).
> > 
> > Note, unless there are major objections, I'm leaning toward getting
> > patch 1 and 2 of this series merged during this -rc cycle so that all of
> > the individual driver subsystem cleanups can go through those subsystems
> > as needed, as well as allowing the rust developers to create a binding
> > and get that merged easier.  Having patch 1 merged on its own isn't
> > going to cause any changes if no one uses it, so that should be fine.
> 
> Hi all,
> 
> I have a maybe dumb question regarding the patches 3..9: do they break the
> UAPI?
> 
> With a platform device, the drivers appear under /sys/bus/platform, but with
> faux device, they appear under /sys/bus/faux.
> 
> I ask because I found out that one (see my reply to [2]) of the main drm
> library expects to find all the devices under pci, usb, platform, virtio and
> host1x buses [1], so at least for the vgem and vkms driver, this library
> will be broken (it will not crash, but previously detected devices will
> suddenly disappear).
> 
> I don't know what are the rules for /sys/bus, but changing a device from one
> bus to another seems to break userspace programs. How should we handle this
> situation? Should we fix the existing drivers? Or only new drivers should
> use it?
> 
> +CC: José Expósito

My 2 cents is that. The library should be prepared for the change. AFAIU
the concept of sys/bus the user space is supposed to check all as the same
device theoretically may float from one bus to another.

-- 
With Best Regards,
Andy Shevchenko



