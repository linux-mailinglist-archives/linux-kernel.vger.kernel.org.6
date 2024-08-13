Return-Path: <linux-kernel+bounces-284853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E629505E5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FB8E1C20EB9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88D919ADA8;
	Tue, 13 Aug 2024 13:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GqpTOnQb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33674206D;
	Tue, 13 Aug 2024 13:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723554445; cv=none; b=OKKZQQ9xGkZ6kkGM6/j0QbNr+oCcGLrPiZlWzw1NaADI0a1CXVFJ8RaZeGVKeKcltLMmZdv1I5/wZkKYo7Ei/wFHzkHFEhxaQSroeqrSmBD7uphro21vOPOQUdNFfgu3Naq5751fU9PY/cs5WO0pKRwqKGjGxjAGHfaQTBXJtC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723554445; c=relaxed/simple;
	bh=1SsjcRHn8DjWskGdveSNsQlKaaFlgtYez08ulurzBwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b987bi52dmGPmJ6JxzUW2SzuC4S3aXKgriJntyzIEKEBKKMx/hjrJTWI6AhFV1ZIn5FPMmJJjxHwEG0R06ZUKwdxGu7shix83A11AV+eEOcdudNVKL+j6xGTDgM9YbkV9fbtce/G1T4XNlWqI7JQP6jr8aSH7x9j3KNL1Q2bces=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GqpTOnQb; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723554444; x=1755090444;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1SsjcRHn8DjWskGdveSNsQlKaaFlgtYez08ulurzBwM=;
  b=GqpTOnQbFx6/+iJMqz/O95uWKXxvBV66DD6oM3UQ93tFORm0gEn1BdFF
   RRseEECw1MuoLEeQ01wLtBsKjLWi943DvdkJt/VkdEyakIHFoPI4s+7TU
   sjUREVO27mAt3eM6WaI6swGkc+nYg/4FTYnncYhVioqfAHvnw30YLpwLy
   oU3FD7hHmlMzulRWHT3e0FKnSTwUEcFQNwgCZ7QwKQIMsvr4sj5/+Vc2B
   fpWfy0aD5o960UedoA2JyiwLl3TLSLbDOSCrXfa1SWcDmGMaFx5Hq09n9
   uJwQJhq2zXxD1tlEoDFbE+P1SiW8N30V4ZKzgcnGCBknLFAUV4Hxyb/+2
   Q==;
X-CSE-ConnectionGUID: SV0JfnlPSqi1O6IS0Js1Aw==
X-CSE-MsgGUID: 43amjeKtRn6Q0blrvJAZEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21576990"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="21576990"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 06:07:23 -0700
X-CSE-ConnectionGUID: U9SN55OaQxG0TKcDYafbeQ==
X-CSE-MsgGUID: yVuekMmaQvydIIHB4aIdVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="63604817"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 06:07:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sdrF5-0000000Ejnv-3Bk5;
	Tue, 13 Aug 2024 16:07:15 +0300
Date: Tue, 13 Aug 2024 16:07:15 +0300
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
Subject: Re: [PATCH v4] drm/i915/hwmon: expose fan speed
Message-ID: <Zrtag2qgxsCNiocc@smile.fi.intel.com>
References: <20240809061525.1368153-1-raag.jadav@intel.com>
 <ZrYB-GI9L2RSc2bt@smile.fi.intel.com>
 <ZrtCIU8On4ZKILmh@black.fi.intel.com>
 <ZrtHz1aY_Lf_XIsL@smile.fi.intel.com>
 <ZrtXReujITKx4rHH@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrtXReujITKx4rHH@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Aug 13, 2024 at 03:53:25PM +0300, Raag Jadav wrote:
> On Tue, Aug 13, 2024 at 02:47:27PM +0300, Andy Shevchenko wrote:
> > On Tue, Aug 13, 2024 at 02:23:13PM +0300, Raag Jadav wrote:
> > > On Fri, Aug 09, 2024 at 02:48:08PM +0300, Andy Shevchenko wrote:
> > > > On Fri, Aug 09, 2024 at 11:45:25AM +0530, Raag Jadav wrote:

...

> > > > > +	/*
> > > > > +	 * HW register value is accumulated count of pulses from
> > > > > +	 * PWM fan with the scale of 2 pulses per rotation.
> > > > > +	 */
> > > > > +	rotations = pulses >> 1;
> > > > 
> > > > In accordance with the comment the
> > > > 
> > > > 	rotations = pulses / 2;
> > > > 
> > > > looks better.
> > > 
> > > This change seems to cause a build error in v5.
> > > Something to do with __udivdi3 on i386.
> > 
> > No, it's not this change.
> > Please, read report carefully.
> 
> CI seems to point to DIV_ROUND_UP(), but it's been there since v1.
> So not sure if I entirely understand.

Yes, that's the issue. You always can reproduce on your side. LKP sent you
comprehensive information about their setup.

-- 
With Best Regards,
Andy Shevchenko



