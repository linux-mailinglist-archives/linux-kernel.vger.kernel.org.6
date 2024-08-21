Return-Path: <linux-kernel+bounces-294858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5325959373
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 05:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DBB5B22717
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 03:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C6915855F;
	Wed, 21 Aug 2024 03:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ahQ3B0di"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C41E18E34F;
	Wed, 21 Aug 2024 03:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724212340; cv=none; b=uS5JmxWO+6s/PXeCZN737EQTe7BoBM2OihhmPZfqDnIY9SXAntPHBqNklszIx1FfnLlVTxkh2+FoC/r4ZO/X/i8QJElAjxi89j0Y5oQwUzopp0Ty+L8N64dTiGHl8SIJ6Ed1QokxE1Zoqoqfjn0I5+wor4kNCWgHbR27dh5V70E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724212340; c=relaxed/simple;
	bh=xWGpi3FNTVpDRYtQlGQLl9i3kf/YdCCoa/UwitYL1FE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgeGB4ArgN5lusOLqVeUiZGRVUBJptiOJ5zCVBXl8tJ1EeBvsLU6zCrJXIPGCHDeodHWtBek+fNpvaI++CQc/GX2g7z+Di/9czX5bRMlN9xVofBHy2DYi4EKAK4Y20bOZFQipPeVtREkoeazz+CM4kSdy+7ghXyi6L3PIL4sIEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ahQ3B0di; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724212338; x=1755748338;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xWGpi3FNTVpDRYtQlGQLl9i3kf/YdCCoa/UwitYL1FE=;
  b=ahQ3B0diDIkYFym1Gg+JYt4hzMsDpbgiUyec5Xz1XnU4JODp615CCYus
   fGJhIP1nq/iiM/S3CTWUYqPpq6ANSxrlYNlQO36dRAzcU2VTBbJ5u+HGO
   IIiiL9UTrqc5upgWkqTeN1BS5MJFjhiSz1kW121KxSp5tn3J5qX4cyQJg
   q5LSMpfTwG3qigtG8wMWwF0BKY9njyP7t+odkSR9i9rlFzHfSbQ6v+nxL
   +A/ByuNqH91g3i0QvEjV2iL2eiB4ckgz5OU+FuVY+/JlsxFWqZTgLc4Pa
   XjX99hMQhj9RiJpttTI2ellPoFUB2L1XAwIMqY/L083Sy+ZvHHbEI2QP7
   Q==;
X-CSE-ConnectionGUID: VF2Qg5f5SZmPvajGmfXGSw==
X-CSE-MsgGUID: BfpaGfpHSXWLaQyKrMvvLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="33936393"
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="33936393"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 20:52:17 -0700
X-CSE-ConnectionGUID: Vofor6GeT9arpAjPlJXtmw==
X-CSE-MsgGUID: H3o51Ve/T16jJIAkXacFSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="65647472"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 20:52:13 -0700
Date: Wed, 21 Aug 2024 06:52:10 +0300
From: Raag Jadav <raag.jadav@intel.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
	tursulin@ursulin.net, airlied@gmail.com, daniel@ffwll.ch,
	linux@roeck-us.net, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, anshuman.gupta@intel.com,
	badal.nilawar@intel.com, riana.tauro@intel.com,
	ashutosh.dixit@intel.com, karthik.poosa@intel.com
Subject: Re: [PATCH v4] drm/i915/hwmon: expose fan speed
Message-ID: <ZsVkapETDCTtx2_F@black.fi.intel.com>
References: <20240809061525.1368153-1-raag.jadav@intel.com>
 <ZrYB-GI9L2RSc2bt@smile.fi.intel.com>
 <ZrYEQqs0IwDHWkGx@ashyti-mobl2.lan>
 <ZsRbK8TEk5GZDl0C@black.fi.intel.com>
 <ZsUPY4zJwEGAf_t_@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsUPY4zJwEGAf_t_@intel.com>

On Tue, Aug 20, 2024 at 05:49:23PM -0400, Rodrigo Vivi wrote:
> On Tue, Aug 20, 2024 at 12:00:27PM +0300, Raag Jadav wrote:
> > On Fri, Aug 09, 2024 at 12:57:54PM +0100, Andi Shyti wrote:
> > > On Fri, Aug 09, 2024 at 02:48:08PM +0300, Andy Shevchenko wrote:
> > > > On Fri, Aug 09, 2024 at 11:45:25AM +0530, Raag Jadav wrote:
> > > > > Add hwmon support for fan1_input attribute, which will expose fan speed
> > > > > in RPM. With this in place we can monitor fan speed using lm-sensors tool.
> > > > > 
> > > > > $ sensors
> > > > > i915-pci-0300
> > > > > Adapter: PCI adapter
> > > > > in0:         653.00 mV
> > > > > fan1:        3833 RPM
> > > > > power1:           N/A  (max =  43.00 W)
> > > > > energy1:      32.02 kJ
> > > > 
> > > > > v2:
> > > > > - Add mutex protection
> > > > > - Handle overflow
> > > > > - Add ABI documentation
> > > > > - Aesthetic adjustments (Riana)
> > > > > 
> > > > > v3:
> > > > > - Declare rotations as "long" and drop redundant casting
> > > > > - Change date and version in ABI documentation
> > > > > - Add commenter name in changelog (Riana)
> > > > > 
> > > > > v4:
> > > > > - Fix wakeref leak
> > > > > - Drop switch case and simplify hwm_fan_xx() (Andi)
> > > > 
> > > > I do not understand why we pollute Git history with changelogs, but it's
> > > > probably the ugly atavism in DRM workflow.
> > > 
> > > I never liked it! Besides it should even be against the
> > > submitting patches recommendation.
> > > 
> > > I don't understand what interest might have someone in a couple
> > > of years, reading this commit, knowing an unintellegible list of
> > > differences between v2 and v3.
> > > 
> > > I consider it a random pollution of the commit log.
> 
> I agree it is ugly. But I don't agree it is just a 'random polution'.
> 
> I consider a valid and very useful information of the patch history.
> Very useful for a later cross check to know what exactly version
> of that patch got merged.
> Useful for distros on backports as well.

Isn't this why we have 'Link' as part of commit which points to
actual ML submission?

> > 
> > Isn't it already documented?
> > Documentation/process/submitting-patches.rst
> 
> I think it is:
> 
> "Be sure to tell the reviewers what changes you are making and to thank them
>  for their time.  Code review is a tiring and time-consuming process, and
>  reviewers sometimes get grumpy.  Even in that case, though, respond
>  politely and address the problems they have pointed out.  When sending a next
>  version, add a ``patch changelog`` to the cover letter or to individual patches
>  explaining difference against previous submission
> "
> 
> Then:
> 
> '''
> Example of a patch submitted by the From: author::
> '''
> 
> defines 'changelog' as the block above the signatures.
> 
> And
> 
> 'The canonical patch format'
> 
> also tells that anything after '---' marker line is for
> "Any additional comments not suitable for the changelog."
> 
> But well, the important part is to have the version information
> available for reviewers.

Can still be available below '---' marker.

Raag

