Return-Path: <linux-kernel+bounces-341823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 164F89886AD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 16:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89F38B212C9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 14:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9535D477;
	Fri, 27 Sep 2024 14:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FTFAg0gk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8554D8DA
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 14:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727446042; cv=none; b=NERnSvFxmQQ9427kHnofl/FLdaPgjPo+p/RQQz5oaPB0Y1T/ikNNCaof4ycwTPozCTSBOIcK8Qt/8kDXwOCXGiFisW4OTRFv/K+9gTHrVXkuT5kjV94pKS24ydGzGhhK5/uKvbfpII2nR8wZd4JgvgffeaIbP4AwsEeo4Pl+x4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727446042; c=relaxed/simple;
	bh=CLo9OzVwUZsZ0uIWth/rFORlhVysacKJrF8TOBj8qI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6ryk7f6OMomHmgMueghktx0/2ijPkNqbAwesOBnVDAXHTEScAhLtAXeVWICKMjRwzk3vRmOIKmJh80CoGhCA2D8QsOKgLLcoJeFmRA2H5bEHrOMpKSSlIzAS66P1hRI8I1dWL7xJcMVB86LKxEEOQ00KA6naXsIutNdMGlEnD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FTFAg0gk; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727446041; x=1758982041;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=CLo9OzVwUZsZ0uIWth/rFORlhVysacKJrF8TOBj8qI0=;
  b=FTFAg0gkZ0VkQs1zHyrMOi4g+kuEY8HtVqRhRKYPEJp50L/fErjc7pet
   RW2Gmf1aJ6bKv6zm8BughGkN6HLIUYVepOw7kOwV0elsj6QC1dF4WK5CC
   YqIEF6el18UuhUwCIjnNWelryzYe12pv/0l1Jvp/ECdKcqCppKl9N6d2V
   zOoqChNn5gYLVvG/pyicq0gqzid3fxm4isfZ8/ooiXFa5eYzswyGndFRp
   ZwghbYWhtBsjhHXnWTsarCa+00YdR4bbx5kvNKg3MqKv8xx77YoDFySgX
   SL7KOF7sKFOiUF1tmyKAwxCTylZMPBzJKWf00tehoASKIngFfseDk+bko
   g==;
X-CSE-ConnectionGUID: tAU4GNUUS66EhMJpckZH6A==
X-CSE-MsgGUID: n8AdVdXiRt+c+c2pzJDtFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="37262392"
X-IronPort-AV: E=Sophos;i="6.11,158,1725346800"; 
   d="scan'208";a="37262392"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 07:07:20 -0700
X-CSE-ConnectionGUID: pYcf9pL4QQyGlpwN2L8OuQ==
X-CSE-MsgGUID: xIrr8pHUQhedg+DyPQcs/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,158,1725346800"; 
   d="scan'208";a="72706953"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 27 Sep 2024 07:07:16 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 27 Sep 2024 17:07:15 +0300
Date: Fri, 27 Sep 2024 17:07:15 +0300
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
Message-ID: <Zva8E_L9yUN6IWlW@intel.com>
References: <20240927000146.50830-1-alessandro.zanni87@gmail.com>
 <87tte1zewf.fsf@intel.com>
 <ZvaduhDERL-zvED3@intel.com>
 <87tte1xmqe.fsf@intel.com>
 <Zva3CAewBl8NBL91@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zva3CAewBl8NBL91@intel.com>
X-Patchwork-Hint: comment

On Fri, Sep 27, 2024 at 04:45:44PM +0300, Ville Syrjälä wrote:
> On Fri, Sep 27, 2024 at 04:14:17PM +0300, Jani Nikula wrote:
> > On Fri, 27 Sep 2024, Ville Syrjälä <ville.syrjala@linux.intel.com> wrote:
> > > On Fri, Sep 27, 2024 at 11:20:32AM +0300, Jani Nikula wrote:
> > >> On Fri, 27 Sep 2024, Alessandro Zanni <alessandro.zanni87@gmail.com> wrote:
> > >> > This fix solves multiple Smatch errors:
> > >> >
> > >> > drivers/gpu/drm/i915/display/intel_atomic_plane.c:660
> > >> > intel_plane_atomic_check_with_state() error:
> > >> > we previously assumed 'fb' could be null (see line 648)
> > >> >
> > >> > drivers/gpu/drm/i915/display/intel_atomic_plane.c:664
> > >> > intel_plane_atomic_check_with_state()
> > >> > error: we previously assumed 'fb' could be null (see line 659)
> > >> >
> > >> > drivers/gpu/drm/i915/display/intel_atomic_plane.c:671
> > >> > intel_plane_atomic_check_with_state()
> > >> > error: we previously assumed 'fb' could be null (see line 663)
> > >> >
> > >> > We should check first if fb is not null before to access its properties.
> > >> 
> > >> new_plane_state->uapi.visible && !fb should not be possible, but it's
> > >> probably too hard for smatch to figure out. It's not exactly trivial for
> > >> humans to figure out either.
> > >> 
> > >> I'm thinking something like below to help both.
> > >> 
> > >> Ville, thoughts?
> > >> 
> > >> 
> > >> BR,
> > >> Jani.
> > >> 
> > >> 
> > >> diff --git a/drivers/gpu/drm/i915/display/intel_atomic_plane.c b/drivers/gpu/drm/i915/display/intel_atomic_plane.c
> > >> index 3505a5b52eb9..d9da47aed55d 100644
> > >> --- a/drivers/gpu/drm/i915/display/intel_atomic_plane.c
> > >> +++ b/drivers/gpu/drm/i915/display/intel_atomic_plane.c
> > >> @@ -629,6 +629,9 @@ int intel_plane_atomic_check_with_state(const struct intel_crtc_state *old_crtc_
> > >>  	if (ret)
> > >>  		return ret;
> > >>  
> > >> +	if (drm_WARN_ON(display->drm, new_plane_state->uapi.visible && !fb))
> > >> +		return -EINVAL;
> > >> +
> > >
> > > We have probably 100 places that would need this. So it's going
> > > to be extremely ugly.
> > >
> > > One approach I could maybe tolerate is something like
> > > intel_plane_is_visible(plane_state) 
> > > {
> > > 	if (drm_WARN_ON(visible && !fb))
> > > 		return false;
> > >
> > > 	return plane_state->visible;
> > > }
> > >
> > > + s/plane_state->visible/intel_plane_is_visible(plane_state)/
> > >
> > > But is that going to help these obtuse tools?
> > 
> > That does help people, which is more important. :)
> > 
> > I think the problem is first checking if fb is NULL, and then
> > dereferencing it anyway.
> > 
> > visible always means fb != NULL, but I forget, is the reverse true? Can
> > we have fb != NULL and !visible? I mean could we change the fb check to
> > visible check?
> 
> No, the reverse does not hold. A plane can be invisible
> while still having a valid fb. Eg. the plane could be
> positioned completely offscreen, or the entire crtc may
> be inactive (DPMS off).
> 
> And whenever we have an fb we want to do all the check to make sure
> it satisfies all the requirements, whether the plane is visible or
> not. Otherwise we could end up confusing userspace with something
> like this:
> 
> 1. Usespace assigns some unsupported fb to the plane
>    but positions the plane offscreen -> success
> 2. Userspace moves the plane to somewhere onscreen -> fail


Basically planes should have three different "enabled" states:

logically_enabled: fb!=NULL (also the crtc must be logically enabled,
                             but drm_atomic_plane_check() guarantees
			     this for us)
visible: logically_enabled && dst rectangle is at least
         partially within pipe_src rectangle
active: visible && crtc_is_active

Currently we try to make the proper distinction between
logically_enabled vs. invisible, but we do not properly
handle the visible vs. active case. That is, we currently
mark the plane as invisible if the crtc is inactive.

That means we eg. calculate watermarks as if the plane was
invisible. That may cause a subsequent "DPMS on" operation
to fail unexpectedly because all of a sudden we realize 
that we don't have enough FIFO space for this particular
plane configuration. There's a FIXME somewhere in the plane
code about this.

-- 
Ville Syrjälä
Intel

