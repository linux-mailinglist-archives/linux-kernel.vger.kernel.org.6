Return-Path: <linux-kernel+bounces-179714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C09F8C63DC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 11:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8072B23155
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 09:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6DC58AC4;
	Wed, 15 May 2024 09:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QDnMwim4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD0A1DFFD
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 09:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715765986; cv=none; b=U8wEVCWVmHIW82jlnpTj/jN3I1M9CsaG2ILOsI2ntRjpdOj7Sl/JqMpkMrzqMoiwxMU8/f4GVxajYG45H8oZgudNnW/SoUazGktQj2b45zfJeVMhhdiDtsm7mGLgmfqI/A8Z9A0yOwY4H/hm+pCI6FieDAOcWFOiK6DMPu0kjrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715765986; c=relaxed/simple;
	bh=9uh3zKLDMxB2n7lOvq1zpArtcYEgDMl2J1QTDfbEfUo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hyyLGyNecRU/fCJaBc1x+LIwoVVjHYkqad2MaNmzxODtCPNaH+o/UuD6X0ExIpXrdNmvM0Ak/yBqiutVkvFo/PV+aZCK6TT6VdJzcYFM/Y5yvpOoJtr9ECY0H64wdZ7aMedalamupJTt5mvCSQkAlb6XCNcZY/RFuFdei1u8kGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QDnMwim4; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715765984; x=1747301984;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=9uh3zKLDMxB2n7lOvq1zpArtcYEgDMl2J1QTDfbEfUo=;
  b=QDnMwim4bdeadtccnZ2fzZErf98fyKugCpGEJPutFssz4FDKphlIK7Yh
   DLALaoamIcSWgdLpGdeY3FHr3DFdiA1y2C6EJ7U32DZAVqUN9PpR7jion
   HY/wgNSMw7v8B+x8xul/lTI+ZNp5GOJ455QCQEhn/TDbB0BZJ0N5iA3Jb
   +J9/NaqQogcTPEao+Zf7VM8rkACaFLHNHaiAcdRhiG1LEe8t8CLqw1q80
   0rMYZOUcE5FTxa2qMI14u9bO5nB8NBXtoZrDCix4JeeL/oewTUq6fxelB
   8oJ/2LvbeyjHvfNBkGWmokJMcKva3JC5qZ8rJkFU9TokOBcdedxS4AYw9
   g==;
X-CSE-ConnectionGUID: m9NocOVUSeenZbwCsssSYw==
X-CSE-MsgGUID: /Nt1xBn7S6qjNQHTpXnQrg==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="11933985"
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="11933985"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 02:39:44 -0700
X-CSE-ConnectionGUID: xDPFVd8oTUKsi3PxrpFcNQ==
X-CSE-MsgGUID: JXGHlvzkRhmuVWa9MkEVrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="35693516"
Received: from mwiniars-desk2.ger.corp.intel.com (HELO localhost) ([10.245.246.141])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 02:39:41 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Sui Jingfeng <sui.jingfeng@linux.dev>, Neil Armstrong
 <neil.armstrong@linaro.org>, Maxime Ripard <mripard@kernel.org>, Dmitry
 Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Sui
 Jingfeng <sui.jingfeng@linux.dev>
Subject: Re: [PATCH 1/2] drm/bridge: Support finding bridge with struct device
In-Reply-To: <20240514154045.309925-2-sui.jingfeng@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240514154045.309925-1-sui.jingfeng@linux.dev>
 <20240514154045.309925-2-sui.jingfeng@linux.dev>
Date: Wed, 15 May 2024 12:39:37 +0300
Message-ID: <87v83fct2e.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 14 May 2024, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
> The pointer of 'struct device' can also be used as a key to search drm
> bridge instance from the global bridge list, traditionally, fwnode and
> 'OF' based APIs requires the system has decent fwnode/OF Graph support.
> While the drm_find_bridge_by_dev() function introduced in this series
> don't has such a restriction. It only require you has a pointer to the
> backing device. Hence, it may suitable for some small and/or limited
> display subsystems.
>
> Also add the drm_bridge_add_with_dev() as a helper, which automatically
> set the .of_node field of drm_bridge instances if you call it. But it
> suitable for simple bridge drivers which one device backing one drm_bridge
> instance.
>
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> ---
>  drivers/gpu/drm/drm_bridge.c | 39 ++++++++++++++++++++++++++++++++++++
>  include/drm/drm_bridge.h     |  5 +++++
>  2 files changed, 44 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 584d109330ab..1928d9d0dd3c 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -213,6 +213,23 @@ void drm_bridge_add(struct drm_bridge *bridge)
>  }
>  EXPORT_SYMBOL(drm_bridge_add);
>  
> +/**
> + * drm_bridge_add_with_dev - add the given bridge to the global bridge list
> + *
> + * @bridge: bridge control structure
> + * @dev: pointer to the kernel device that this bridge is backed.
> + */
> +void drm_bridge_add_with_dev(struct drm_bridge *bridge, struct device *dev)
> +{
> +	if (dev) {
> +		bridge->kdev = dev;
> +		bridge->of_node = dev->of_node;
> +	}
> +
> +	drm_bridge_add(bridge);
> +}
> +EXPORT_SYMBOL_GPL(drm_bridge_add_with_dev);

I don't actually have an opinion on whether the dev parameter is useful
or not.

But please don't add a drm_bridge_add_with_dev() and then convert more
than half the drm_bridge_add() users to that. Please just add a struct
device *dev parameter to drm_bridge_add(), and pass NULL if it's not
relevant.

BR,
Jani.


> +
>  static void drm_bridge_remove_void(void *bridge)
>  {
>  	drm_bridge_remove(bridge);
> @@ -1334,6 +1351,27 @@ void drm_bridge_hpd_notify(struct drm_bridge *bridge,
>  }
>  EXPORT_SYMBOL_GPL(drm_bridge_hpd_notify);
>  
> +struct drm_bridge *drm_find_bridge_by_dev(struct device *kdev)
> +{
> +	struct drm_bridge *bridge;
> +
> +	if (!kdev)
> +		return NULL;
> +
> +	mutex_lock(&bridge_lock);
> +
> +	list_for_each_entry(bridge, &bridge_list, list) {
> +		if (bridge->kdev == kdev) {
> +			mutex_unlock(&bridge_lock);
> +			return bridge;
> +		}
> +	}
> +
> +	mutex_unlock(&bridge_lock);
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(drm_find_bridge_by_dev);
> +
>  #ifdef CONFIG_OF
>  /**
>   * of_drm_find_bridge - find the bridge corresponding to the device node in
> @@ -1361,6 +1399,7 @@ struct drm_bridge *of_drm_find_bridge(struct device_node *np)
>  	return NULL;
>  }
>  EXPORT_SYMBOL(of_drm_find_bridge);
> +
>  #endif
>  
>  MODULE_AUTHOR("Ajay Kumar <ajaykumar.rs@samsung.com>");
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 4baca0d9107b..70d8393bbd9c 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -715,6 +715,8 @@ struct drm_bridge {
>  	struct drm_private_obj base;
>  	/** @dev: DRM device this bridge belongs to */
>  	struct drm_device *dev;
> +	/** @kdev: pointer to the kernel device backing this bridge */
> +	struct device *kdev;
>  	/** @encoder: encoder to which this bridge is connected */
>  	struct drm_encoder *encoder;
>  	/** @chain_node: used to form a bridge chain */
> @@ -782,12 +784,15 @@ drm_priv_to_bridge(struct drm_private_obj *priv)
>  }
>  
>  void drm_bridge_add(struct drm_bridge *bridge);
> +void drm_bridge_add_with_dev(struct drm_bridge *bridge, struct device *dev);
>  int devm_drm_bridge_add(struct device *dev, struct drm_bridge *bridge);
>  void drm_bridge_remove(struct drm_bridge *bridge);
>  int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
>  		      struct drm_bridge *previous,
>  		      enum drm_bridge_attach_flags flags);
>  
> +struct drm_bridge *drm_find_bridge_by_dev(struct device *kdev);
> +
>  #ifdef CONFIG_OF
>  struct drm_bridge *of_drm_find_bridge(struct device_node *np);
>  #else

-- 
Jani Nikula, Intel

