Return-Path: <linux-kernel+bounces-398168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 575899BE6B9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 13:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D60C1F27636
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 12:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804811DF721;
	Wed,  6 Nov 2024 12:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z+732Y3V"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8791DF729
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 12:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730894596; cv=none; b=EVbBCW4egPGdEal1Hf8FhVG3aIH87QraODyMbBTvuaX3eWLNrgqn1Eseh8EayojyWXeUQZhzDZ8hx4vDfUUpUWVtm8drNtoiYdqWJxiD3ji7uRUOMg8a4ciWXZwcQdLbUMrwCEgADDhH5vmcGMIbSrPZJ0WLsBG5nK+x5Ei7S6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730894596; c=relaxed/simple;
	bh=8ACCdXKSb4x9ULEg/UokXvVNenOb3X8u4nBOhsfFsqo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mz8lX3WrJ5Tm7idNrvjEnZNjTdbWszui+XGNdSVhzAlTYB+9UZtM693CgBjje3j7t1CJjdk4JeJFVflebqfukXBY2m88FOhqyKSQ0B3vB9RvZ2rqibf6Q5ouXl15UyOJCAE+lP7brStG05B31p3jl2ZlpktkcqmBc3faXm2FJqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z+732Y3V; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730894595; x=1762430595;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=8ACCdXKSb4x9ULEg/UokXvVNenOb3X8u4nBOhsfFsqo=;
  b=Z+732Y3VyzKlB6QeY4x8SRz8xYz00CvKYNEJD46eT01qjpW7DLy5I7I1
   ti84A868ujfu+0bjymzmOYWZ513Ii7gaW6Ycx908+dDrMx+01mhKXtUC7
   bX9qlcvBXcmn8lzJw2jlFsWG9tiWiICIuY4UWuD1SHHvDFBYJcQMaLiFz
   qjTgvNO4pEkMUBfuf+f31VTfYxE2N6FHKLXSx6FrINIjLfBiOm2xO9q05
   z284u4inEj1n4yBJApcDI8KO2+Vct69ki4moOaIpUq2g4Gzv+TCgniA5l
   EY5yCEarmjeMPAsXmhbliAz8MnpjdBYD7ZcXWeTmTSVLWLVXWFYGdSYlg
   g==;
X-CSE-ConnectionGUID: RuPk+4MXQNatH138MrFoAg==
X-CSE-MsgGUID: qruIbCK4RkmaaOOHO2g0JQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30850741"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30850741"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 04:03:14 -0800
X-CSE-ConnectionGUID: dZX4gZZiTDi2h/NHcD26XQ==
X-CSE-MsgGUID: m0f2rt31QtOqI5qY9Wfu1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="84671686"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.246.143])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 04:03:10 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Luca
 Ceresoli <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v2 3/4] drm/mode_object: add
 drm_mode_object_read_refcount()
In-Reply-To: <20241106-drm-small-improvements-v2-3-f6e2aef86719@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20241106-drm-small-improvements-v2-0-f6e2aef86719@bootlin.com>
 <20241106-drm-small-improvements-v2-3-f6e2aef86719@bootlin.com>
Date: Wed, 06 Nov 2024 14:03:08 +0200
Message-ID: <87wmhgfu2r.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 06 Nov 2024, Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:
> Add a wrapper to kref_read() just like the ones already in place for
> kref_get() and kref_put(). This will be used for sanity checks on object
> lifetime.
>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/gpu/drm/drm_mode_object.c | 20 ++++++++++++++++++++
>  include/drm/drm_mode_object.h     |  1 +
>  2 files changed, 21 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_mode_object.c b/drivers/gpu/drm/drm_mode_object.c
> index df4cc0e8e263d5887a799cf1a61d998234be7158..f990cc7e9b5d3bda3453123593314fa1ea2bf923 100644
> --- a/drivers/gpu/drm/drm_mode_object.c
> +++ b/drivers/gpu/drm/drm_mode_object.c
> @@ -217,6 +217,26 @@ void drm_mode_object_get(struct drm_mode_object *obj)
>  }
>  EXPORT_SYMBOL(drm_mode_object_get);
>  
> +/**
> + * drm_mode_object_get - read the refcount for a mode object
> + * @obj: DRM mode object
> + *
> + * This function returns the current object's refcount if it is a
> + * refcounted modeset object, or 0 on any other object.

Returns: The current object's ...

> + */
> +unsigned int drm_mode_object_read_refcount(struct drm_mode_object *obj)
> +{
> +	unsigned int refcount = 0;
> +
> +	if (obj->free_cb) {
> +		refcount = kref_read(&obj->refcount);
> +		DRM_DEBUG("OBJ ID: %d (%d)\n", obj->id, refcount);

Please ditch the debug.

> +	}
> +
> +	return refcount;
> +}
> +EXPORT_SYMBOL(drm_mode_object_read_refcount);
> +
>  /**
>   * drm_object_attach_property - attach a property to a modeset object
>   * @obj: drm modeset object
> diff --git a/include/drm/drm_mode_object.h b/include/drm/drm_mode_object.h
> index c68edbd126d04d51221f50aa2b4166475543b59f..3d2c739e703888bf4520c61594d480f128d50e56 100644
> --- a/include/drm/drm_mode_object.h
> +++ b/include/drm/drm_mode_object.h
> @@ -123,6 +123,7 @@ struct drm_mode_object *drm_mode_object_find(struct drm_device *dev,
>  					     uint32_t id, uint32_t type);
>  void drm_mode_object_get(struct drm_mode_object *obj);
>  void drm_mode_object_put(struct drm_mode_object *obj);
> +unsigned int drm_mode_object_read_refcount(struct drm_mode_object *obj);
>  
>  int drm_object_property_set_value(struct drm_mode_object *obj,
>  				  struct drm_property *property,

-- 
Jani Nikula, Intel

