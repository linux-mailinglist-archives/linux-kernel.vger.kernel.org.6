Return-Path: <linux-kernel+bounces-238563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35989924C1F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 01:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1CFD28317E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 23:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AF6158853;
	Tue,  2 Jul 2024 23:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gfr5C1Kf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2881DA320
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 23:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719963192; cv=none; b=sVxJ6W1Whqy0bMMfYpcJB5HYLROcw4MfKBq8fom7sQCBo+KErwmpODPxm3dEfl+R4V389W5h1q5bxtKZboK5wAn2cLbBMovu4HDcd2GzeBoZvA2otIrRLwpJV94vZIfkHcf3QBhhj9EpfA62eJ0jrXgJZlk1lQgxuJTCdlzqgkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719963192; c=relaxed/simple;
	bh=yzH45tjsH2DZUqSlBKr2pzDg/aEQ+EnDG+CHzo/H0lA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTByPIZkjJKqp+ms5LYri0GyjR4+iIKBOIlUhHRS2SiEkP/+zTgUqw22T1QoA/xb06g2pGkx/PUu2lX8nHzJy4S3p4XVThWS487t2qVigIh/83ZMki/5csQ8VteWopq3qN+zm9yOIRLR10Hd4YPMoGBPkREw234cBzDfTQ9d5OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gfr5C1Kf; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719963192; x=1751499192;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=yzH45tjsH2DZUqSlBKr2pzDg/aEQ+EnDG+CHzo/H0lA=;
  b=Gfr5C1Kf6BD83aCgyA1Bs7ytb9gNLXwp4g+d5W5Iql8jV5N/tAD5KHLj
   nOOzx8bLLW5xRoJyh2OeahJB+Mma/pqlK+Cjhv2Q2E7PzngqgUSOf7kJ6
   cFttl/CEa8gGs+O0x8j7s5sdIOwn3bN3b1WPAmBTompSGMGUo3SrzfLt7
   KGWnA6A8JBu0sRJBc/k/nqz4zRDLX0T9NWn7bFfNd+oEha2FLkEyiLivb
   a4eExJvXZNdVosY7LW/TQOcvxhhZibqDokZo0VFC2LAkWK8BN2P5ZAq+e
   r6/Cm6jR1vHCEBk1lNXARhzR6Kw04wGq8ph0twJtO+GItp/mgLQriQvhY
   g==;
X-CSE-ConnectionGUID: 7m5kQzBwQMuF52KSj01Q6g==
X-CSE-MsgGUID: NxB65gB7RGifgjY25ur3Jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="28560117"
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="28560117"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 16:33:10 -0700
X-CSE-ConnectionGUID: wlmUeZSkQiKsUdeM5/hFnA==
X-CSE-MsgGUID: mtMT8fVyREWBfB1jcOhZ8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="46044198"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 02 Jul 2024 16:33:05 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 03 Jul 2024 02:33:04 +0300
Date: Wed, 3 Jul 2024 02:33:04 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Jim Cromie <jim.cromie@gmail.com>
Cc: daniel.vetter@ffwll.ch, tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com, jbaron@akamai.com,
	gregkh@linuxfoundation.org, ukaszb@chromium.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, linux@rasmusvillemoes.dk,
	joe@perches.com, mcgrof@kernel.org
Subject: Re: [PATCH v9 30/52] drm-dyndbg: adapt drm core to use dyndbg
 classmaps-v2
Message-ID: <ZoSOMClB0MeWeokU@intel.com>
References: <20240702215804.2201271-1-jim.cromie@gmail.com>
 <20240702215804.2201271-31-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240702215804.2201271-31-jim.cromie@gmail.com>
X-Patchwork-Hint: comment

On Tue, Jul 02, 2024 at 03:57:20PM -0600, Jim Cromie wrote:
> dyndbg's CLASSMAP-v1 api was broken; DECLARE_DYNDBG_CLASSMAP tried to
> do too much.  Its replaced by DRM_CLASSMAP_DEFINE, which creates &
> EXPORTs the classmap when CONFIG_DRM_USE_DYNAMIC_DEBUG=y, for direct
> reference by drivers.
> 
> The drivers still use DECLARE_DYNDBG_CLASSMAP for now, so they still
> redundantly re-declare the classmap, but we can convert the drivers
> later to DYNDBG_CLASSMAP_USE
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
>  drivers/gpu/drm/drm_print.c | 25 +++++++++++++------------
>  include/drm/drm_print.h     |  8 ++++++++
>  2 files changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
> index 699b7dbffd7b..4a5f2317229b 100644
> --- a/drivers/gpu/drm/drm_print.c
> +++ b/drivers/gpu/drm/drm_print.c
> @@ -55,18 +55,19 @@ MODULE_PARM_DESC(debug, "Enable debug output, where each bit enables a debug cat
>  #if !defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
>  module_param_named(debug, __drm_debug, ulong, 0600);
>  #else
> -/* classnames must match vals of enum drm_debug_category */
> -DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
> -			"DRM_UT_CORE",
> -			"DRM_UT_DRIVER",
> -			"DRM_UT_KMS",
> -			"DRM_UT_PRIME",
> -			"DRM_UT_ATOMIC",
> -			"DRM_UT_VBL",
> -			"DRM_UT_STATE",
> -			"DRM_UT_LEASE",
> -			"DRM_UT_DP",
> -			"DRM_UT_DRMRES");
> +/* classnames must match value-symbols of enum drm_debug_category */
> +DRM_CLASSMAP_DEFINE(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS,
> +		    DRM_UT_CORE,
> +		    "DRM_UT_CORE",
> +		    "DRM_UT_DRIVER",
> +		    "DRM_UT_KMS",
> +		    "DRM_UT_PRIME",
> +		    "DRM_UT_ATOMIC",
> +		    "DRM_UT_VBL",
> +		    "DRM_UT_STATE",
> +		    "DRM_UT_LEASE",
> +		    "DRM_UT_DP",
> +		    "DRM_UT_DRMRES");

Looks like this stuff just ends up in an array, so presumably
it should be possible to use designated initializers to make this
less fragile?

-- 
Ville Syrjälä
Intel

