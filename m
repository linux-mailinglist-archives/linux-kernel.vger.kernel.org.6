Return-Path: <linux-kernel+bounces-293770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C7E958455
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0FC7B27E64
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2086518CC1F;
	Tue, 20 Aug 2024 10:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B3q68MO+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE1718CBEA;
	Tue, 20 Aug 2024 10:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724149425; cv=none; b=YfMUyRfuDslpMgmMfV6WLt6Kk9Zn3HM0he/gwqDKJB/gfte23/yosiIEyWgykbi8nik1BPhL0B1/NOrkyn7+rK/jzemfpbx1s8Wg8Rx1bRBw3LsmHL/5Cn6wK7gBfDnQ3jabMRFH3CTVVAXZ+ryrAwqV11UhmhIxQFAaK09RVeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724149425; c=relaxed/simple;
	bh=Mh4/fpGN5ZPUpaPzZDGUGUsQfXLGPzN6NmUqzUNDJwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFzU+EzgzzZcMhMrHbTjfEpv0o46zzsmC3aT/q5F1gGqRJ0PXcGSJ3NyW1QEedUfppMIoD2Q6/9kpVlVtEahTyUTiD84YdeaVrOPLrFeNdQ+wUmEkJdktB16SikoBYRNP1sfyQKBaKXXeJiDc7kGwlcKDpnfHvh56O2uQuN1Kps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B3q68MO+; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724149425; x=1755685425;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Mh4/fpGN5ZPUpaPzZDGUGUsQfXLGPzN6NmUqzUNDJwk=;
  b=B3q68MO+P+qZBrRwsQsqd52x5EcIZvGcy/fDfDmcAU6kBfGplnhUiZRQ
   7aey7ZyzOPNVFfGRUzKxoun2Bn2VJxP5baOqvYTGuR7NJR2HGCs+ejfGu
   xAZ1hL3zYDfh6zY0gZzNV59ve9oBZKuj5+8MuXMqHumaBdL38K2V2CeVL
   egm8baN50ksrrLpX3Ul/840TBx91lYqxZA4WpSrKRq1MYbc7tYM7C30AB
   91DGpAHJXMgYOQUrcdWv2zbGrkrbMnV8lGGwInUoyYiKjC8nTyrx7f2vP
   LmXFqlNK5cnKGxI0BKb2iSZyDhgLro6SMohPzL9jIrpGqKK5iouIFTxFS
   Q==;
X-CSE-ConnectionGUID: vzbxUJ7rTsKcSaoERBb4Fw==
X-CSE-MsgGUID: qA1ENOP7T2+733Ob8FYDjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="33010727"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="33010727"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 03:23:43 -0700
X-CSE-ConnectionGUID: c3zLvXOXTCq7yKaRKRxwWg==
X-CSE-MsgGUID: K+l7Nfd8RU2adZ/vrTeYEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="65642325"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 03:23:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sgM1X-0000000HGJy-1vnR;
	Tue, 20 Aug 2024 13:23:35 +0300
Date: Tue, 20 Aug 2024 13:23:35 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com, tursulin@ursulin.net, airlied@gmail.com,
	daniel@ffwll.ch, linux@roeck-us.net, andi.shyti@linux.intel.com,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	anshuman.gupta@intel.com, badal.nilawar@intel.com,
	riana.tauro@intel.com, ashutosh.dixit@intel.com,
	karthik.poosa@intel.com
Subject: Re: [PATCH v6] drm/i915/hwmon: expose fan speed
Message-ID: <ZsRup8uKiqUvADFl@smile.fi.intel.com>
References: <20240820062010.2000873-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820062010.2000873-1-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Aug 20, 2024 at 11:50:10AM +0530, Raag Jadav wrote:
> Add hwmon support for fan1_input attribute, which will expose fan speed
> in RPM. With this in place we can monitor fan speed using lm-sensors tool.
> 
> $ sensors
> i915-pci-0300
> Adapter: PCI adapter
> in0:         653.00 mV
> fan1:        3833 RPM
> power1:           N/A  (max =  43.00 W)
> energy1:      32.02 kJ

> v2: Handle overflow, add mutex protection and ABI documentation
>     Aesthetic adjustments (Riana)
> v3: Change rotations data type, ABI date and version
> v4: Fix wakeref leak
>     Drop switch case and simplify hwm_fan_xx() (Andi)
> v5: Rework time calculation, aesthetic adjustments (Andy)
> v6: Drop overflow logic (Andy)
>     Aesthetic adjustments (Badal)

But it still has an issue with 64-bit division on 32-bit platforms, right?

...

> +	/*
> +	 * Calculate fan speed in RPM by time averaging two subsequent
> +	 * readings in minutes.
> +	 * RPM = number of rotations * msecs per minute / time in msecs
> +	 */
> +	*val = DIV_ROUND_UP(rotations * (MSEC_PER_SEC * 60), time);

...somewhere here?

-- 
With Best Regards,
Andy Shevchenko



