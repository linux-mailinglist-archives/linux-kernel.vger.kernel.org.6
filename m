Return-Path: <linux-kernel+bounces-302317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC1095FC7D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 00:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4947C2826A9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B010C19D06C;
	Mon, 26 Aug 2024 22:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mYqIGOfp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D7E19CCE6
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 22:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724710327; cv=none; b=d37DSQWNZLoq6y/OWxa2hjqkf8b+8ZV7bzJ37i/SZIXxByuYu91enlspiJVPWFWb3FTDZE4GzqPr+TgWQtlIJg/9VutHc6O0d5IqkauAa1ioTKSca3lxKdE0p46fQtHFlZcYRE6tImuPSpE+aSx65guq9s7x3ejzvoDhCOoVWlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724710327; c=relaxed/simple;
	bh=vHTWezTDg3VjLJ9BJa7omSY9dIg3RiuEC6mMMyKLquY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbQV9zOn/G8ySDFEC6cWxbW5WOvNFnyPaLs1deLmTNln7ipzUAbGpyL41zW9Wy4dTB9WYpTMcIDsHBAETbkxuMkQqg3ABSbBIdn0FWeYflh/Ncbe17tYnfHl40ydZZsEEKTKwxCRzKkKGfINDP765qjEcaeJYtI9D7dZx8wOL+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mYqIGOfp; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724710325; x=1756246325;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vHTWezTDg3VjLJ9BJa7omSY9dIg3RiuEC6mMMyKLquY=;
  b=mYqIGOfpqejq6XQ9slnOrRQOHZCXsuFKHDRrXk2EpTsULwNf0mJCMJhL
   aWualSImbvMetFiCTcUC9vY0zzpNPSPHIRXdApK6aZ3hKhG6iIp4aktJz
   dJ9bIatKZQ0pi/np2UOGOIRyFuEiOhjREbvy+mh7MEATZh2GhBCNBkQoW
   YMpCqDrnQWv7ii+0U0AClyI2oFblBpbm6laGniTqDHTIOA7XVczmvqDnu
   bRfZJ30QuP5N1+ySxDxfEAMEbBhlMdhdAJfFqKQLxCB1WgwzkymFoFPhj
   9gYqIEuMH+gFXzwKcU+IhmASVPWu5lxesvbl8ir0A1tETKlPBiP9jJxGV
   Q==;
X-CSE-ConnectionGUID: oG8fmIAQQ6WgH2NzOO5cfw==
X-CSE-MsgGUID: jR9KrNzUTPC+EGbZNqsslg==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="26059719"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="26059719"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 15:12:03 -0700
X-CSE-ConnectionGUID: pV5z/GHRQKWpL2Z3L6N29g==
X-CSE-MsgGUID: h8vg/mEyT82OaKbHTAPF9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="62700903"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO intel.com) ([10.245.246.180])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 15:11:55 -0700
Date: Tue, 27 Aug 2024 00:11:51 +0200
From: Andi Shyti <andi.shyti@linux.intel.com>
To: renjun wang <renjunw0@foxmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
	jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com, tursulin@ursulin.net, lyude@redhat.com,
	imre.deak@intel.com, Wayne.Lin@amd.com,
	ville.syrjala@linux.intel.com, vidya.srinivas@intel.com,
	jouni.hogander@intel.com, andi.shyti@linux.intel.com,
	janusz.krzysztofik@linux.intel.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm: Fix kerneldoc for "Returns" section
Message-ID: <Zsz9pwQ3m9zHrjo-@ashyti-mobl2.lan>
References: <tencent_37A873672B5CD20DECAF99DEDAC5E45C3106@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_37A873672B5CD20DECAF99DEDAC5E45C3106@qq.com>

Hi Renjun,

On Sat, Aug 24, 2024 at 04:36:34PM +0800, renjun wang wrote:
> The blank line between title "Returns:" and detail description is not
> allowed, otherwise the title will goes under the description block in
> generated .html file after running `make htmldocs`.
> 
> There are a few examples for current kerneldoc:
> https://www.kernel.org/doc/html/latest/gpu/drm-kms.html#c.drm_crtc_commit_wait
> https://www.kernel.org/doc/html/latest/gpu/drm-kms.html#c.drm_atomic_get_crtc_state
> https://www.kernel.org/doc/html/latest/gpu/i915.html#c.i915_vma_pin_fence
> 
> Signed-off-by: renjun wang <renjunw0@foxmail.com>
> ---
>  drivers/gpu/drm/display/drm_dp_mst_topology.c | 4 ----
>  drivers/gpu/drm/drm_atomic.c                  | 6 ------
>  drivers/gpu/drm/drm_atomic_helper.c           | 2 --
>  drivers/gpu/drm/drm_file.c                    | 7 -------
>  drivers/gpu/drm/drm_gem.c                     | 7 ++-----
>  drivers/gpu/drm/drm_modes.c                   | 1 -
>  drivers/gpu/drm/drm_rect.c                    | 1 -
>  drivers/gpu/drm/drm_vblank.c                  | 2 --
>  drivers/gpu/drm/i915/gem/i915_gem_object.h    | 1 -
>  drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c  | 1 -
>  drivers/gpu/drm/i915/i915_vma.h               | 1 -
>  11 files changed, 2 insertions(+), 31 deletions(-)

next time, please, split the series so that each component goes
to the right branch.

Andi

