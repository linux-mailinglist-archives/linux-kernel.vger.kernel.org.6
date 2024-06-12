Return-Path: <linux-kernel+bounces-212176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 172A7905C5E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 21:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9DEB283289
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 19:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8F27E110;
	Wed, 12 Jun 2024 19:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DDCwvYHy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887D8381C4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 19:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718222109; cv=none; b=LoEDKsLVU6XajI1nsr6KZ1tMpc9C31L+lUEe/7m7DU911m1zY76LUh0PLxGOhEQkUUdmT/9+ENhNa9YUp8znWNHJnLLkHE7t0E1zrqkpJaVyNtXkhsAOFgw/GvevcqWBOj7+V3ATwJhd5sOV+zP2hjszJGY0HbGUPJB1eAV2cPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718222109; c=relaxed/simple;
	bh=lAiuT2H0ZpL6CYGuPE2qv6qz9QdBfxioDaU4gY9nmiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMXB2ULQrbggHq4vsOAz49SeC+b7tA/n8mB6XRjfr0rDxm2bJLGNqf+1wgVLCF6mkwdoA8zXiGv0ZhhLXXGQ1dllvTTxkpFZbAUyaN71/810PtvNluoseseg5aV6RHj8MvIRArQEnQZ94faAGmDLNVl/GoD04Ic9SqYAjf6iKJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DDCwvYHy; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718222107; x=1749758107;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lAiuT2H0ZpL6CYGuPE2qv6qz9QdBfxioDaU4gY9nmiE=;
  b=DDCwvYHyNjcGumT9nWDdBz3TvnTyRUv71bMUtUi9l4AQgAIfOTkyMABL
   +41Wbu/5Nt0Lmv5akO1aar2rGl+ryUev199DN5XcAZZeSJ7DxbNS80coa
   2iSJ5zAdfkSKRxxTC0j6z2RDRgIv0wHcAvt5B7KDoyCQRkCFa3KkZCH5n
   0bB/3RyeVYrAVA3iswb7DHDQMlUepgfIKSQYOP5hhqZsGpak3A/niSSMT
   524PFIep2MBn1W1M3rjsds/gIDxmZHnVV8cMYjOj9ujlxQLUuJOqnz+wN
   hlakV2Zc8JQd7afOA46HCWqdbmIoZxEy4vyYo0z1z3NdYv9EEQ7ccOOl2
   A==;
X-CSE-ConnectionGUID: 6bNzoYPURTSXRQlE22h7FQ==
X-CSE-MsgGUID: iU0nJEc5QgmQ2DMp7kf4vw==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="40415414"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="40415414"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 12:55:06 -0700
X-CSE-ConnectionGUID: HMUvc0fjSMur9HBLGzBIug==
X-CSE-MsgGUID: PPNktQK9SR6WqHxi1uZyLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="39845552"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 12 Jun 2024 12:55:02 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 12 Jun 2024 22:55:01 +0300
Date: Wed, 12 Jun 2024 22:55:01 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
	alexander.deucher@amd.com, christian.koenig@amd.com,
	Simon Ser <contact@emersion.fr>,
	Pekka Paalanen <ppaalanen@gmail.com>, daniel@ffwll.ch,
	Daniel Stone <daniel@fooishbar.org>,
	'Marek =?utf-8?B?T2zFocOhayc=?= <maraeo@gmail.com>,
	Dave Airlie <airlied@gmail.com>, Xaver Hugl <xaver.hugl@gmail.com>,
	Joshua Ashton <joshua@froggi.es>,
	Michel =?iso-8859-1?Q?D=E4nzer?= <michel.daenzer@mailbox.org>
Subject: Re: [PATCH v5 2/3] drm: Allow drivers to choose plane types to async
 flip
Message-ID: <Zmn9FdyMh-tyGTQg@intel.com>
References: <20240612193713.167448-1-andrealmeid@igalia.com>
 <20240612193713.167448-3-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240612193713.167448-3-andrealmeid@igalia.com>
X-Patchwork-Hint: comment

On Wed, Jun 12, 2024 at 04:37:12PM -0300, André Almeida wrote:
> Different planes may have different capabilities of doing async flips,
> so create a field to let drivers allow async flip per plane type.
> 
> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> ---
>  drivers/gpu/drm/drm_atomic_uapi.c | 4 ++--
>  drivers/gpu/drm/drm_plane.c       | 3 +++
>  include/drm/drm_plane.h           | 5 +++++
>  3 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> index 2e1d9391febe..dd4b1578f141 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -1079,9 +1079,9 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
>  			break;
>  		}
>  
> -		if (async_flip && plane_state->plane->type != DRM_PLANE_TYPE_PRIMARY) {
> +		if (async_flip && !plane_state->plane->async_flip) {

You alreayd have 'plane', no need to dog it out again.

>  			drm_dbg_atomic(prop->dev,
> -				       "[OBJECT:%d] Only primary planes can be changed during async flip\n",
> +				       "[OBJECT:%d] This type of plane cannot be changed during async flip\n",
>  				       obj->id);

"[PLANE:%d:%s] does not support async flips"
or something like it would make more sense to me.

>  			ret = -EINVAL;
>  			break;
> diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
> index 57662a1fd345..bbcec3940636 100644
> --- a/drivers/gpu/drm/drm_plane.c
> +++ b/drivers/gpu/drm/drm_plane.c
> @@ -385,6 +385,9 @@ static int __drm_universal_plane_init(struct drm_device *dev,
>  
>  	drm_modeset_lock_init(&plane->mutex);
>  
> +	if (type == DRM_PLANE_TYPE_PRIMARY)
> +		plane->async_flip = true;

Setting that would be the job of the driver.

You could probably just nuke mode_config.async_page_flip
and replace it fully with plane.async_flip checks.

> +
>  	plane->base.properties = &plane->properties;
>  	plane->dev = dev;
>  	plane->funcs = funcs;
> diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
> index 9507542121fa..0bebc72af5c3 100644
> --- a/include/drm/drm_plane.h
> +++ b/include/drm/drm_plane.h
> @@ -786,6 +786,11 @@ struct drm_plane {
>  	 * @kmsg_panic: Used to register a panic notifier for this plane
>  	 */
>  	struct kmsg_dumper kmsg_panic;
> +
> +	/**
> +	 * @async_flip: indicates if a plane can do async flips
> +	 */
> +	bool async_flip;
>  };
>  
>  #define obj_to_plane(x) container_of(x, struct drm_plane, base)
> -- 
> 2.45.2

-- 
Ville Syrjälä
Intel

