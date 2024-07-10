Return-Path: <linux-kernel+bounces-247573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6877392D15E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3C5C1F25332
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A4B19149E;
	Wed, 10 Jul 2024 12:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h36zUb7v"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B61D156C7B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 12:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720613783; cv=none; b=PnoVpEnJaOU+rCD1DCpUdvSxXZyNQTPw5zKGfK8dmHFA2ddlgKLEm7UlhzqOTJO1EBo6TpVVL7o/wVcOpTQoP5jTJqS1xsJDLpWLN8udcpYT2pX+0XrIa1iyxDAHwvUh8sZzNyT2kuL2ZIFBZ/34L8RrK3EDErYAwtFilyJwju0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720613783; c=relaxed/simple;
	bh=y0qjDnLJyo/X2DNmXM+T7MdDK6BJMvAV3BAux5grKmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mcDhT/lAg69H21WJaOEPcb2nX5RqY/3DE4YIdvK1PgfMk2Nfw9n60lBllUQwDPnrNZLAQ1sG7w5Zf21V6DMYbeNwpbyLsoQm3wzjmva6tIeq2OlLDWgIO7SAl28Fgg17t3UvGKLGMO9V5PRDaGKCHThY6fwJ1tVHXZRJvF5iMWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h36zUb7v; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720613781; x=1752149781;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=y0qjDnLJyo/X2DNmXM+T7MdDK6BJMvAV3BAux5grKmA=;
  b=h36zUb7vuJ5mfaPjlA3zpB/HAZTzTHeO/cQT/GRLwU6YZVl0KNIJ9UWV
   Gxm3O2mcwXBi7tKPG9b7vw9Rmtiru55cP6SKfNaXeOsMWejVmBPRnelH1
   voMXuY9qIvGWpyVzNTWRnkH4yoKxmJ2nTzbMD9xDxERixf+WhL4KWiC6U
   rpIc8r8b3gxzKUcPEbzm+fsTOe12vVaPKGCTGeihOqjXWNwMFJ1ZWMrYK
   +Uai7tk4szWiyHnBcrfqJBvR8I8ACm04MDA5HeOMTz1b/tjLeJ5agXeO/
   9I4AZFPxM87xYzHW7S7w8y5r8KBh93MVj7dbo+XIcL5VC1kbbe/RT7Ofr
   g==;
X-CSE-ConnectionGUID: sxKZlXk7Spi23yblNFcajQ==
X-CSE-MsgGUID: yrxTEt7DTFe17CNn3KhMrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="17627651"
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="17627651"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 05:16:20 -0700
X-CSE-ConnectionGUID: j0qe4MdASMWZ4BjJSkehMg==
X-CSE-MsgGUID: hKD5bWzhTgqbJxpf2THtuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="48177915"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 10 Jul 2024 05:16:17 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 10 Jul 2024 15:16:15 +0300
Date: Wed, 10 Jul 2024 15:16:15 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com, tursulin@ursulin.net, airlied@gmail.com,
	daniel@ffwll.ch, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915: Explicitly cast divisor to fix Coccinelle
 warning
Message-ID: <Zo57j8G2AQbhpORB@intel.com>
References: <20240710074650.419902-2-thorsten.blum@toblux.com>
 <Zo5yvk69FB-jEgd8@intel.com>
 <77194DC0-AA53-4CF9-8BDB-93E212B9FA72@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77194DC0-AA53-4CF9-8BDB-93E212B9FA72@toblux.com>
X-Patchwork-Hint: comment

On Wed, Jul 10, 2024 at 01:55:32PM +0200, Thorsten Blum wrote:
> On 10. Jul 2024, at 13:38, Ville Syrjälä <ville.syrjala@linux.intel.com> wrote:
> > On Wed, Jul 10, 2024 at 09:46:51AM +0200, Thorsten Blum wrote:
> >> As the comment explains, the if check ensures that the divisor oa_period
> >> is a u32. Explicitly cast oa_period to u32 to remove the following
> >> Coccinelle/coccicheck warning reported by do_div.cocci:
> >> 
> >>  WARNING: do_div() does a 64-by-32 division, please consider using div64_u64 instead
> >> 
> >> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> >> ---
> >> drivers/gpu/drm/i915/i915_perf.c | 2 +-
> >> 1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
> >> index 0b1cd4c7a525..24722e758aaf 100644
> >> --- a/drivers/gpu/drm/i915/i915_perf.c
> >> +++ b/drivers/gpu/drm/i915/i915_perf.c
> >> @@ -4103,7 +4103,7 @@ static int read_properties_unlocked(struct i915_perf *perf,
> >>  */
> >> if (oa_period <= NSEC_PER_SEC) {
> >> u64 tmp = NSEC_PER_SEC;
> >> - do_div(tmp, oa_period);
> >> + do_div(tmp, (u32)oa_period);
> > 
> > Why is this code even using do_div() when it doesn't need the
> > remainder?
> 
> do_div() is an optimized 64-by-32 division and the compiler should
> automatically remove the remainder if it's not used.

The point is that do_div() is a bad API because it magically
changes the divided in place. There are more sensible 64bit
division helpers in math64.h that can be used instead.

oa_exponent_to_ns() also hand rolls a DIV_ROUND_UP_ULL()
for some reason...

-- 
Ville Syrjälä
Intel

