Return-Path: <linux-kernel+bounces-531463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC08A440CF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA4CC17CB3C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482032690DB;
	Tue, 25 Feb 2025 13:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Za31iVHS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49469257420
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740490065; cv=none; b=VrS359UqKym96XHkNPSDRu+PbkxWDf/wSVTvmIjh2f9QXXN7USHfQSCHPjkRD4iH66v9rvXusOLzBLkm59fXFs/PsRtrBDwA34bzr6TBor3dv91wxsC5Rdg2CEfEbbJOP2t2Auvysi2hwoMPxbN2I/RUurisC2sFaPI7BmSgpFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740490065; c=relaxed/simple;
	bh=mJnA5aAmxnqHG+2rcYlUIZpPZ7IF7x7N2NK1L0XW7wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/2Rv5lGehob1phcVbYNgJDVO9JLiXD174sy4hYaM0M5W58sPC2zaKYzLqIxZVtADwPT2oPqwKOCK3GCwkCwg9xOpkCmqcAyZEG0hAcMli3/LVWL33yG3yhacQri5V2iy/7Soo9twUpjopevyLzslsHwQRqIEZf/BLkSAKNnFxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Za31iVHS; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740490064; x=1772026064;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=mJnA5aAmxnqHG+2rcYlUIZpPZ7IF7x7N2NK1L0XW7wc=;
  b=Za31iVHSyJAmeLAHKnHZ+6wD1J1KL3V9ICs9nnHPQbcTtRPVH77YhG5p
   zzK44MCrSz57cYZ6gaquDhL8Og5ypuTu0APJKIVNACGJlsR9PJKU2qNDo
   WO3D32rCU33XA0g9K0fiKeQSs5bMZEWIZowAd/WKhZ4nGFAifFIadVHLU
   /mGlcdk8Yue16Lor4aO0Ms6WK2dMSnHzKwAo9t2XU3EnvTQOLPT95+lUO
   Pq99MZoZ+J88Khs3UoTUwHU/iphLcJDbqqjPmhFUelk9g4OsbBo4nOlNG
   RUBUxrjEN1PubqE42KjaLIr5YWN3eF3AC86R5cFWOltuyE3G+ZXXuG3ew
   g==;
X-CSE-ConnectionGUID: vyKEmAnTTKyqZiBEWELhIA==
X-CSE-MsgGUID: U3yjnFI4RZ2JGpg6/F2yOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="66664583"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="66664583"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 05:27:44 -0800
X-CSE-ConnectionGUID: zYGRsw6iQ02HhvkI3Jyuxg==
X-CSE-MsgGUID: IqOF8utiQryVkT8yG7JZmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="121339614"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 05:27:40 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tmuyH-0000000F0Fx-1zvT;
	Tue, 25 Feb 2025 15:27:37 +0200
Date: Tue, 25 Feb 2025 15:27:37 +0200
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
Message-ID: <Z73FSWR-DK0HxMb2@smile.fi.intel.com>
References: <3457BF95-0E50-4B70-86DE-EE5EE95D3ACE@live.com>
 <4D7C00B4-7B75-4715-8D37-0059B22C030D@live.com>
 <Z72chunE_vvxtjLQ@smile.fi.intel.com>
 <PN3PR01MB9597BF95EC490951D75748F1B8C32@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <Z72foRL3diil9icd@smile.fi.intel.com>
 <PN3PR01MB9597B5ECF47B04E3201DD56BB8C32@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <Z72jHeCG6-ByMyhh@smile.fi.intel.com>
 <9efdb233-2bca-4a5d-a6bc-de81fa96efb3@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9efdb233-2bca-4a5d-a6bc-de81fa96efb3@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 25, 2025 at 12:59:43PM +0100, Thomas Zimmermann wrote:
> Am 25.02.25 um 12:01 schrieb andriy.shevchenko@linux.intel.com:
> > On Tue, Feb 25, 2025 at 10:48:53AM +0000, Aditya Garg wrote:
> > > > On 25 Feb 2025, at 4:17 PM, andriy.shevchenko@linux.intel.com wrote:
> > > > On Tue, Feb 25, 2025 at 10:36:03AM +0000, Aditya Garg wrote:
> > > > > > > On 25 Feb 2025, at 4:03 PM, andriy.shevchenko@linux.intel.com wrote:
> > > > > > On Tue, Feb 25, 2025 at 10:09:42AM +0000, Aditya Garg wrote:

 ...

> > > > > > > +static int appletbdrm_probe(struct usb_interface *intf,
> > > > > > > +                const struct usb_device_id *id)
> > > > > > > +{
> > > > > > > +    struct usb_endpoint_descriptor *bulk_in, *bulk_out;
> > > > > > > +    struct device *dev = &intf->dev;
> > > > > > > +    struct appletbdrm_device *adev;
> > > > > > > +    struct drm_device *drm;
> > > > > > > +    int ret;
> > > > > > > +
> > > > > > > +    ret = usb_find_common_endpoints(intf->cur_altsetting, &bulk_in, &bulk_out, NULL, NULL);
> > > > > > > +    if (ret) {
> > > > > > > +        drm_err(drm, "Failed to find bulk endpoints\n");
> > > > > > This is simply wrong (and in this case even lead to crash in some circumstances).
> > > > > > drm_err() may not be used here. That's my point in previous discussions.
> > > > > > Independently on the subsystem the ->probe() for the sake of consistency and
> > > > > > being informative should only rely on struct device *dev,
> > > > > I'm not sure how drm_err works,
> > > > It's a macro.
> > > > 
> > > > > but struct drm_device does have a struct device *dev as well.
> > > > Yes, but only when it's initialized.
> > > > 
> > > > > Anyways, this is something I'll leave for Thomas to reply.
> > > > The code above is wrong independently on his reply :-)
> > > I'm kinda stuck between contrasting views of 2 kernel maintainers lol,
> > > so I said let Thomas reply.
> > Sure. I also want him to clarify my question about potential drm_err_probe().
> 
> These threads get a little lengthy. What is the question?

How drm_err_probe() can be (consistently) implemented as there are and will be
cases when we want to return an error code with the message and having DRM devce
not being available, please?

Also, drm_err() has a downside of not checking for deferred probe and
potentially leads to the noisy log floods.

-- 
With Best Regards,
Andy Shevchenko



