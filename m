Return-Path: <linux-kernel+bounces-173783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E03D28C054D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 21:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95DDA1F22A0E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E46D130AC7;
	Wed,  8 May 2024 19:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NGL+6Gcb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773BF130A48
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 19:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715198209; cv=none; b=iTFRzyJw7QK1yELb/Vh0jYWu8f5kTc4vY1GQy6vNrUzxmEayLkfwMWybHW9WNNe0ZawCHDjntW4/dCIpVLsKzaWxaBxkzHAiXpyWKSx3D5XpubQHiUUhzsJaFD7iymXnvssp0Q55a7Z80rM14JXrJoan7clH2111fsDbGd1FIno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715198209; c=relaxed/simple;
	bh=JUYK14yf13OFljwh7Fkp50F+nLJd6ilr3LJXbhfPMz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbqK86ZroDi4WWWdGWE/ECGfQaYMnFctcf2QuHPOerKRVsMz5jNMSmO9ejSsGhCqdFrZFJDHYU3KcQ8hWJx5b9GajwP2C4Wy3WNTpqE5pgksJ+iDQhV84m1rKrBUqUFhf4IzJHhETXKhZSlOhqYrHpOEaV3tzJnd/10Qj0fy1j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NGL+6Gcb; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715198206; x=1746734206;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JUYK14yf13OFljwh7Fkp50F+nLJd6ilr3LJXbhfPMz4=;
  b=NGL+6GcbuFKJT+MWXMVr8hyYix/KzFLb5FWgaLyc58HGW3l9Xhev8kqC
   1Xdo8eDAFa/LdbTTPTabxU33VHYe8JdeN+S7laZiBrvniYdFSBg4JHtrO
   I2j/jRuDSJEMmXS5MkkZw+2otVNCg61xZyzqXEj+nyFr6H8RH/BasMG95
   37CiwLthjOhDd3PY5R6B87c8fyzAn2U39MMOWmqqapzNnU9zQHjKCnJck
   vIRIeP/i6R5jL8k8Z9lbHP8GO5UvEsZPS2pUvS+xzlddsScBfC/FX3m5K
   SLw9HtoEfmRw3Ild6VisrNTNsaFOOoXJa38uKHH8+HxHCUF3DiQQqt6U/
   Q==;
X-CSE-ConnectionGUID: VzbIf+n7RwST4BMZgc1ZKw==
X-CSE-MsgGUID: JgYBnkYCT6Ci5rQwHWJHjw==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="28598133"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28598133"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 12:56:46 -0700
X-CSE-ConnectionGUID: exVjfBluR0qxXwvRQD+XYQ==
X-CSE-MsgGUID: VmMb/7PzRWCj/EI4T0uylw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28938967"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 08 May 2024 12:56:41 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 08 May 2024 22:56:40 +0300
Date: Wed, 8 May 2024 22:56:40 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Fangzhi Zuo <jerry.zuo@amd.com>,
	Tyler Schneider <tyler.schneider@amd.com>
Subject: Re: [PATCH 1/2] drm: Allow mode object properties to be added after
 a device is registered
Message-ID: <ZjvY-B_VG0uBTiJO@intel.com>
References: <20240508194308.48366-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240508194308.48366-1-mario.limonciello@amd.com>
X-Patchwork-Hint: comment

On Wed, May 08, 2024 at 02:43:07PM -0500, Mario Limonciello wrote:
> When the colorspace property is registered on MST devices there is
> no `obj_free_cb` callback for it in drm_mode_object_add().
> 
> Don't show a warning trace for __drm_mode_object_add() calls for
> DRM_MODE_OBJECT_PROPERTY.

You need to create the property ahead of time. See eg.
commit 1b9bd09630d4 ("drm/i915: Do not create a new max_bpc prop for MST
connectors")

> 
> Reported-and-tested-by: Tyler Schneider <tyler.schneider@amd.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3353
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/drm_mode_object.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_mode_object.c b/drivers/gpu/drm/drm_mode_object.c
> index 0e8355063eee..b077547a2db4 100644
> --- a/drivers/gpu/drm/drm_mode_object.c
> +++ b/drivers/gpu/drm/drm_mode_object.c
> @@ -42,7 +42,7 @@ int __drm_mode_object_add(struct drm_device *dev, struct drm_mode_object *obj,
>  {
>  	int ret;
>  
> -	WARN_ON(!dev->driver->load && dev->registered && !obj_free_cb);
> +	WARN_ON(!dev->driver->load && dev->registered && !obj_free_cb && obj_type != DRM_MODE_OBJECT_PROPERTY);
>  
>  	mutex_lock(&dev->mode_config.idr_mutex);
>  	ret = idr_alloc(&dev->mode_config.object_idr, register_obj ? obj : NULL,
> -- 
> 2.43.0

-- 
Ville Syrjälä
Intel

