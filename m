Return-Path: <linux-kernel+bounces-531074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EF2A43BE0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 070181888693
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CB7260A3D;
	Tue, 25 Feb 2025 10:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KA74OT2U"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF441C8625
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740479630; cv=none; b=Bneq56LQG9o2gcqMST4S076qadT6zpD1gzfxb3Z0d66eUlYN5Kgb+3jXi6ociIUiEHc5y/0E9KM+TYOH4MDcMkAD9KjJ4z8s9tMUilq1YNKmgzrXHo998jFgOwdxA3x7uOOB1QkRz45kcTkc1F2xIjGITeDN8qUZ+TM0UjYmI6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740479630; c=relaxed/simple;
	bh=xDtEhN1Z+pJ+VKbDwekrT0fQS2yTec4QWfwd4POyIVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVOqmy8jjILCY2IgzovPKyaGAgDRjETk/UsQU2BwV18GlTbPTgYe4k7qu25mEkzLjIK8nrMQEFguI5RkjRNFhvWtxvAGy0JFxJeEHSPj8/x5tACsGVK5D5A/pZrDTtcS+ft3LZ84RBanjcnB+3tnhWI2rCLsoEkoZO3chOpHg44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KA74OT2U; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740479629; x=1772015629;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xDtEhN1Z+pJ+VKbDwekrT0fQS2yTec4QWfwd4POyIVM=;
  b=KA74OT2UmALD+uqUh8pev2uwL354ec7iAWEtVYvohlr2fcc4xHFEf5bQ
   n5Zlqgpl7sDhca7t8nhNvtgQ/GS5rlWSN8FrnkJE6LbqRlJPixiThPEH6
   GKgnpiSvZJafSpeuf62U5GiVRKApXsWfZmV7S1YUdlr7EbasjdkrpBnBR
   mLsUImja4aC8d4BOOhZ76ZTQC8aKIABbbs7ejAP0G671weCZ6wYEkYoUn
   NLA7wZvPcZtdhiNWMn/2JxHGZss52dqkh9VmpuYrkeM1GsaHyWqBSn116
   NcgIMGxIQrTzuWD+HVOAMkxvgDCKLtL9XEDWnD5eV5W/Jhrg9exMLphFm
   Q==;
X-CSE-ConnectionGUID: o0BsO8IvTVm77PtcONvk8g==
X-CSE-MsgGUID: gnEP1JhNR/+F3mQ9Bizl2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="41412499"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="41412499"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 02:33:48 -0800
X-CSE-ConnectionGUID: TmKLdnSVTkCUMbCIqENeyw==
X-CSE-MsgGUID: 84RCDiuURBW2Y8gDTdIwew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="116144291"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 02:33:46 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tmsFy-0000000ExYS-2dxt;
	Tue, 25 Feb 2025 12:33:42 +0200
Date: Tue, 25 Feb 2025 12:33:42 +0200
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
Message-ID: <Z72chunE_vvxtjLQ@smile.fi.intel.com>
References: <3457BF95-0E50-4B70-86DE-EE5EE95D3ACE@live.com>
 <4D7C00B4-7B75-4715-8D37-0059B22C030D@live.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D7C00B4-7B75-4715-8D37-0059B22C030D@live.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 25, 2025 at 10:09:42AM +0000, Aditya Garg wrote:
> From: Kerem Karabay <kekrby@gmail.com>
> 
> The Touch Bars found on x86 Macs support two USB configurations: one
> where the device presents itself as a HID keyboard and can display
> predefined sets of keys, and one where the operating system has full
> control over what is displayed.
> 
> This commit adds support for the display functionality of the second
> configuration. Functionality for the first configuration has been
> merged in the HID tree.
> 
> Note that this driver has only been tested on T2 Macs, and only includes
> the USB device ID for these devices. Testing on T1 Macs would be
> appreciated.
> 
> Credit goes to Ben (Bingxing) Wang on GitHub for reverse engineering
> most of the protocol.
> 
> Also, as requested by Andy, I would like to clarify the use of __packed
> structs in this driver:
> 
> - All the packed structs are aligned except for appletbdrm_msg_information.
> - We have to pack appletbdrm_msg_information since it is requirement of
>   the protocol.
> - We compared binaries compiled by keeping the rest structs __packed and
>   not __packed using bloat-o-meter, and __packed was not affecting code
>   generation.
> - To maintain consistency, rest structs have been kept __packed.
> 
> I would also like to point out that since the driver was reverse-engineered
> the actual data types of the protocol might be different, including, but
> not limited to, endianness.

...

> +static int appletbdrm_probe(struct usb_interface *intf,
> +			    const struct usb_device_id *id)
> +{
> +	struct usb_endpoint_descriptor *bulk_in, *bulk_out;
> +	struct device *dev = &intf->dev;
> +	struct appletbdrm_device *adev;
> +	struct drm_device *drm;
> +	int ret;
> +
> +	ret = usb_find_common_endpoints(intf->cur_altsetting, &bulk_in, &bulk_out, NULL, NULL);
> +	if (ret) {
> +		drm_err(drm, "Failed to find bulk endpoints\n");

This is simply wrong (and in this case even lead to crash in some circumstances).
drm_err() may not be used here. That's my point in previous discussions.
Independently on the subsystem the ->probe() for the sake of consistency and
being informative should only rely on struct device *dev,

> +		return ret;
> +	}
> +
> +	adev = devm_drm_dev_alloc(dev, &appletbdrm_drm_driver, struct appletbdrm_device, drm);
> +	if (IS_ERR(adev))
> +		return PTR_ERR(adev);
> +
> +	adev->in_ep = bulk_in->bEndpointAddress;
> +	adev->out_ep = bulk_out->bEndpointAddress;
> +	adev->dmadev = dev;
> +
> +	drm = &adev->drm;
> +
> +	usb_set_intfdata(intf, adev);
> +
> +	ret = appletbdrm_get_information(adev);
> +	if (ret) {
> +		drm_err(drm, "Failed to get display information\n");
> +		return ret;
> +	}
> +
> +	ret = appletbdrm_signal_readiness(adev);
> +	if (ret) {
> +		drm_err(drm, "Failed to signal readiness\n");
> +		return ret;
> +	}
> +
> +	ret = appletbdrm_setup_mode_config(adev);
> +	if (ret) {
> +		drm_err(drm, "Failed to setup mode config\n");
> +		return ret;
> +	}
> +
> +	ret = drm_dev_register(drm, 0);
> +	if (ret) {
> +		drm_err(drm, "Failed to register DRM device\n");
> +		return ret;
> +	}
> +
> +	ret = appletbdrm_clear_display(adev);
> +	if (ret) {
> +		drm_err(drm, "Failed to clear display\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko



