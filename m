Return-Path: <linux-kernel+bounces-533892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B97A45FED
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7C00168758
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA332192F0;
	Wed, 26 Feb 2025 12:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NkPpCSe2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF4D21B1AC
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740574795; cv=none; b=Ct7nhsZDMLbnQdHl7E1rjbkFy4Bj815wuwCam2to92WNtuA8m4BKpeS4v1LobjHU2tDLR+k6+NC560/x2iB8/tjtmCDoZ8r3GUeJencCWF1rtIBfB2i5uyMKbJzOMG5EG9bk8BtrtYb00Wds0FITnJavZJ1M3GxKj1WgrN86tco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740574795; c=relaxed/simple;
	bh=hRjSahBWqR/k26T9IBRygUmf7RLbBHNYRRan8vTSqUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYv37AHi3nQMIyYGMwrdOmBQ+v6Ec3WmdG7ifLR/9x6BqhJS0XLIRlZY0CtCD2jAs1QgTTygDVlprK/3rgZpv89p4mvmGu4No4j1nd+gFoCw1vkNDib5ZqDOXn7A+j/bVTEF/QXmrI3TZYgersEwny7EdXjsWNWedh+vUyXwYLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NkPpCSe2; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740574794; x=1772110794;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hRjSahBWqR/k26T9IBRygUmf7RLbBHNYRRan8vTSqUY=;
  b=NkPpCSe2rkA3X5kFVtfTHHwaOZqHX+Dshe7p5wkw2Q/jEYJGupJ28dkl
   8MqYRj/e5TRnDrc7R4cxihukBVZntfWZEATF8dE2i8BCFSoMaBnQvzg0b
   /HGv8MX4F9EZ99qX2SNLL21e5/xC4yhN01k4NGgQkmUn2PaWHJSg3+x6D
   rakFPxQMirzDmkE6P7ihnMCnMFpolwSV2ZuMpTdyCTyFIkUXVoy44R6fg
   orvgcTUGY5DYJ7JfQLwmbBMDSaptME0jGhNrxQj0VDV4eCoKor/CLJQZL
   N0NhuiDGoDmUq5nxlJzi7iMGIAhakVIltZBbYw8lA6Xx9ofV4GUyoT96o
   Q==;
X-CSE-ConnectionGUID: Set4n+k5QxiqhXkLIT/Zig==
X-CSE-MsgGUID: 7Fub+ZbFSEGl5+EB3oGW0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="41261298"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="41261298"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 04:59:53 -0800
X-CSE-ConnectionGUID: ERhHvArPSmqUxieblpUvfg==
X-CSE-MsgGUID: 49yIGAVnTWi7DN8UTwggNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="147609306"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 04:59:51 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tnH0u-0000000FKNR-2q1c;
	Wed, 26 Feb 2025 14:59:48 +0200
Date: Wed, 26 Feb 2025 14:59:48 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: lee@kernel.org, giometti@enneenne.com, gregkh@linuxfoundation.org,
	raymond.tan@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] pps: generators: tio: move to match_data() model
Message-ID: <Z78QRLG7iHlf_gEr@smile.fi.intel.com>
References: <20250226061527.3031250-1-raag.jadav@intel.com>
 <20250226061527.3031250-3-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226061527.3031250-3-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 26, 2025 at 11:45:25AM +0530, Raag Jadav wrote:
> Use device_get_match_data() which allows configuring platform
> specific data like number of pins and MMIO registers for TIO.

...

> +static const struct pps_tio_data pmc_data = {
> +	.regs = {
> +		.ctl = TIOCTL_PMC,
> +		.compv = TIOCOMPV_PMC,
> +		.ec = TIOEC_PMC,
> +	},
> +};

Move this closer to its' user, i.e...

...somewhere here.


>  static const struct acpi_device_id intel_pmc_tio_acpi_match[] = {
> -	{ "INTC1021" },
> -	{ "INTC1022" },
> -	{ "INTC1023" },
> -	{ "INTC1024" },
> +	{ "INTC1021", (kernel_ulong_t)&pmc_data },
> +	{ "INTC1022", (kernel_ulong_t)&pmc_data },
> +	{ "INTC1023", (kernel_ulong_t)&pmc_data },
> +	{ "INTC1024", (kernel_ulong_t)&pmc_data },
>  	{}
>  };

-- 
With Best Regards,
Andy Shevchenko



