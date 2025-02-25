Return-Path: <linux-kernel+bounces-531095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A95F6A43C21
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 966DD1887DB3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB5C263C82;
	Tue, 25 Feb 2025 10:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WhDLYPfT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FBF19C54F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740480425; cv=none; b=bJTOlNVr+0Eewvkhf2IR/AU6v7SweUKBh2YK1se1gTG5u7zU2u2ema3sIxGycOv9epcS5ulx8HCzkxis0DkZxquHmX/0M0b3WZiL+xf6SQYdNpqI0rrOJQ4KtoMoA33H4fTZD0bej8Tf7FHE46BH3k7mFbwfPSPFTQjONQs9mDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740480425; c=relaxed/simple;
	bh=HeA23Fblfe8AuqDknPqy/QZb+v6/Cv+7JHe3jUfuCVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDWJKMOs58MmIq0RARPomezFYuVVh9ucK85UIQZB/ednJgm+JXo+BITAYp56iAfqHXODYGTYEXQsGws7TQewoOMAdt9ZGOGRlcvTXQ4C3Ode2ySKHzH7McJ2rRnpELgQcDzCo6iO7N8CU69GSK1B+5ss4CA6tMNp1IbPEX6NVn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WhDLYPfT; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740480424; x=1772016424;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=HeA23Fblfe8AuqDknPqy/QZb+v6/Cv+7JHe3jUfuCVc=;
  b=WhDLYPfTam3vL5fz3S8KvaAdZv/zMkJrRKwPpOz2Z2IjEbUBqhBdwi1e
   AElGu7AP1+R7rOZa6xozURTZC5INNDL5FfoUaEdwlrNt8ayPosvmr4OWD
   h68AWNGFOgVMrV2EKdpvfTvTDhV70F5GboqaeXc5W4/Gdqj3Q4GuqDXuU
   QjjTsM8p7TDvzA3/i8uSZQVyelSLJjRgHPiirS25lbtHjLeCG/UlchR5A
   haI2ijLlKMAngcl9Yw+Bq2kGkKC0GVMnVPkvnjK92VT8X+lWVeTHd8U//
   FCiJmdentkWXYJYOTdvFu1v+6yB7tINTbQojh4t2gpUZFizDf73W2u4rA
   Q==;
X-CSE-ConnectionGUID: KxZGHAEWQR2G9DeZoNN/8Q==
X-CSE-MsgGUID: w1nHj54XRTm16jif0RVPaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="58702593"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="58702593"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 02:47:04 -0800
X-CSE-ConnectionGUID: LXLpCp75TQ+IoemliAV8+g==
X-CSE-MsgGUID: TKTEqMkwRP2TNs6UWQCmnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="139596556"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 02:47:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tmsSn-0000000Exi7-3rEA;
	Tue, 25 Feb 2025 12:46:57 +0200
Date: Tue, 25 Feb 2025 12:46:57 +0200
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
Message-ID: <Z72foRL3diil9icd@smile.fi.intel.com>
References: <3457BF95-0E50-4B70-86DE-EE5EE95D3ACE@live.com>
 <4D7C00B4-7B75-4715-8D37-0059B22C030D@live.com>
 <Z72chunE_vvxtjLQ@smile.fi.intel.com>
 <PN3PR01MB9597BF95EC490951D75748F1B8C32@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PN3PR01MB9597BF95EC490951D75748F1B8C32@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 25, 2025 at 10:36:03AM +0000, Aditya Garg wrote:
> > On 25 Feb 2025, at 4:03 PM, andriy.shevchenko@linux.intel.com wrote:
> > On Tue, Feb 25, 2025 at 10:09:42AM +0000, Aditya Garg wrote:

...

> >> +static int appletbdrm_probe(struct usb_interface *intf,
> >> +                const struct usb_device_id *id)
> >> +{
> >> +    struct usb_endpoint_descriptor *bulk_in, *bulk_out;
> >> +    struct device *dev = &intf->dev;
> >> +    struct appletbdrm_device *adev;
> >> +    struct drm_device *drm;
> >> +    int ret;
> >> +
> >> +    ret = usb_find_common_endpoints(intf->cur_altsetting, &bulk_in, &bulk_out, NULL, NULL);
> >> +    if (ret) {
> >> +        drm_err(drm, "Failed to find bulk endpoints\n");
> > 
> > This is simply wrong (and in this case even lead to crash in some circumstances).
> > drm_err() may not be used here. That's my point in previous discussions.
> > Independently on the subsystem the ->probe() for the sake of consistency and
> > being informative should only rely on struct device *dev,
> 
> I'm not sure how drm_err works,

It's a macro.

> but struct drm_device does have a struct device *dev as well.

Yes, but only when it's initialized.

> Anyways, this is something I'll leave for Thomas to reply.

The code above is wrong independently on his reply :-)

-- 
With Best Regards,
Andy Shevchenko



