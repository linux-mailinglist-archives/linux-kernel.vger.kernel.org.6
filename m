Return-Path: <linux-kernel+bounces-341684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5400988397
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 13:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D2642877D2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 11:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3B9185B72;
	Fri, 27 Sep 2024 11:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IrF+K5ZB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4807143C4C
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 11:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727438285; cv=none; b=Va8mPvonI3a5woXiGFfRt8pBantCnxw/FJl3qQQTNilLVCgFtbhRarkSdfmUtG7qWky1VMCfsS/CHryfXYKncd/d2+uHmxaiApxyJm/mIsYh2mO2tGUGjkuDNE6HkpH4S0KAucwhKAeT0kQ7C3XAQCFQ7PYAadKgVz5k33m3kzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727438285; c=relaxed/simple;
	bh=cE3DSOxu2KhQ4VUt6KjdR+DUz74JcXwEdHUB+LUYDoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O9VKVEYYA5Waa3cGBPvTosnkiedVuDiCicMJAA672Mzpyp1UOV/6MemvqntcpIeR8abBYcyiS7LwcUc1BC0F+BHD0obzDR5IfubnfIuzxsUj02iaNEL94TaJfV0naPBNxQ0oxpWYLKXbM3+5m13etGTuQxZnohO3KiaBn/QkyYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IrF+K5ZB; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727438283; x=1758974283;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=cE3DSOxu2KhQ4VUt6KjdR+DUz74JcXwEdHUB+LUYDoU=;
  b=IrF+K5ZBehI0uaI9hRt/L+KdXLdONRC8fYq3KVihSDcLLZ2V+Ajm8Cf7
   Y09y4ibb0x0PE5bB8sz263entVfYhrDtN3xgyCkCpAbSd8ug7eEFV/8rg
   ALXQyV3vMcA9Mzt0+djeKJ8l6F2O3Wy0ach08KdtFAl7Sx7ANMZVRjcEI
   LgHnkYD82wxSQnEdATcCFtl38wKvBXvreuNemBjk6RuoG9CPY9ka+nBO7
   jObImmIHROSOdafWcWjI1Vh8xDiZginTtvUy8uitw7lb65p6Ptz/c9EHR
   zk/WwwGbdO4g8FelNF7c9wujQ46sIpv3JgiUPM2s+K2hYkx1Uulp6Z7Hd
   A==;
X-CSE-ConnectionGUID: BFKJ3JWcS06xwztI4X6WcA==
X-CSE-MsgGUID: 5K9hgKaBTO69G6HJuKTqkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="30289420"
X-IronPort-AV: E=Sophos;i="6.11,158,1725346800"; 
   d="scan'208";a="30289420"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 04:58:03 -0700
X-CSE-ConnectionGUID: fOl91vxBR5Cr1bV1f6e8BA==
X-CSE-MsgGUID: 5VSTsa3zTTu7LE+v2lKtJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,158,1725346800"; 
   d="scan'208";a="72688311"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 27 Sep 2024 04:57:47 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 27 Sep 2024 14:57:46 +0300
Date: Fri, 27 Sep 2024 14:57:46 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>, rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com, tursulin@ursulin.net,
	airlied@gmail.com, simona@ffwll.ch, intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	anupnewsmail@gmail.com
Subject: Re: [PATCH] gpu: drm: i915: display: Avoid null values
 intel_plane_atomic_check_with_state
Message-ID: <ZvaduhDERL-zvED3@intel.com>
References: <20240927000146.50830-1-alessandro.zanni87@gmail.com>
 <87tte1zewf.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tte1zewf.fsf@intel.com>
X-Patchwork-Hint: comment

On Fri, Sep 27, 2024 at 11:20:32AM +0300, Jani Nikula wrote:
> On Fri, 27 Sep 2024, Alessandro Zanni <alessandro.zanni87@gmail.com> wrote:
> > This fix solves multiple Smatch errors:
> >
> > drivers/gpu/drm/i915/display/intel_atomic_plane.c:660
> > intel_plane_atomic_check_with_state() error:
> > we previously assumed 'fb' could be null (see line 648)
> >
> > drivers/gpu/drm/i915/display/intel_atomic_plane.c:664
> > intel_plane_atomic_check_with_state()
> > error: we previously assumed 'fb' could be null (see line 659)
> >
> > drivers/gpu/drm/i915/display/intel_atomic_plane.c:671
> > intel_plane_atomic_check_with_state()
> > error: we previously assumed 'fb' could be null (see line 663)
> >
> > We should check first if fb is not null before to access its properties.
> 
> new_plane_state->uapi.visible && !fb should not be possible, but it's
> probably too hard for smatch to figure out. It's not exactly trivial for
> humans to figure out either.
> 
> I'm thinking something like below to help both.
> 
> Ville, thoughts?
> 
> 
> BR,
> Jani.
> 
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_atomic_plane.c b/drivers/gpu/drm/i915/display/intel_atomic_plane.c
> index 3505a5b52eb9..d9da47aed55d 100644
> --- a/drivers/gpu/drm/i915/display/intel_atomic_plane.c
> +++ b/drivers/gpu/drm/i915/display/intel_atomic_plane.c
> @@ -629,6 +629,9 @@ int intel_plane_atomic_check_with_state(const struct intel_crtc_state *old_crtc_
>  	if (ret)
>  		return ret;
>  
> +	if (drm_WARN_ON(display->drm, new_plane_state->uapi.visible && !fb))
> +		return -EINVAL;
> +

We have probably 100 places that would need this. So it's going
to be extremely ugly.

One approach I could maybe tolerate is something like
intel_plane_is_visible(plane_state) 
{
	if (drm_WARN_ON(visible && !fb))
		return false;

	return plane_state->visible;
}

+ s/plane_state->visible/intel_plane_is_visible(plane_state)/

But is that going to help these obtuse tools?

>  	if (fb)
>  		new_crtc_state->enabled_planes |= BIT(plane->id);
>  
> 
> 
> >
> > Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
> > ---
> >  drivers/gpu/drm/i915/display/intel_atomic_plane.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/i915/display/intel_atomic_plane.c b/drivers/gpu/drm/i915/display/intel_atomic_plane.c
> > index e979786aa5cf..1606f79b39e6 100644
> > --- a/drivers/gpu/drm/i915/display/intel_atomic_plane.c
> > +++ b/drivers/gpu/drm/i915/display/intel_atomic_plane.c
> > @@ -656,18 +656,18 @@ int intel_plane_atomic_check_with_state(const struct intel_crtc_state *old_crtc_
> >  	    intel_plane_is_scaled(new_plane_state))
> >  		new_crtc_state->scaled_planes |= BIT(plane->id);
> >  
> > -	if (new_plane_state->uapi.visible &&
> > +	if (new_plane_state->uapi.visible && fb &&
> >  	    intel_format_info_is_yuv_semiplanar(fb->format, fb->modifier))
> >  		new_crtc_state->nv12_planes |= BIT(plane->id);
> >  
> > -	if (new_plane_state->uapi.visible &&
> > +	if (new_plane_state->uapi.visible && fb &&
> >  	    fb->format->format == DRM_FORMAT_C8)
> >  		new_crtc_state->c8_planes |= BIT(plane->id);
> >  
> >  	if (new_plane_state->uapi.visible || old_plane_state->uapi.visible)
> >  		new_crtc_state->update_planes |= BIT(plane->id);
> >  
> > -	if (new_plane_state->uapi.visible &&
> > +	if (new_plane_state->uapi.visible && fb &&
> >  	    intel_format_info_is_yuv_semiplanar(fb->format, fb->modifier)) {
> >  		new_crtc_state->data_rate_y[plane->id] =
> >  			intel_plane_data_rate(new_crtc_state, new_plane_state, 0);
> 
> -- 
> Jani Nikula, Intel

-- 
Ville Syrjälä
Intel

