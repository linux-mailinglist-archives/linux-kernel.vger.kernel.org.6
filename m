Return-Path: <linux-kernel+bounces-194252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D948D38F1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 956FCB27D9C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FAA5579A;
	Wed, 29 May 2024 14:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hRFRYPhZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCFC13792B
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 14:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716992094; cv=none; b=P3qkTcVsUC1caqTsaLAfO52FwcaC2kPjQNw9Ov2oZtQ/lk0kMMc2CPJ2EQ8JiLF/jVdC6uba1vC8rL3IfGhvURfz+RvFjQhyl76IxoiSrpCmmDi9hEhBu9R4KmZeQsKnDxMrQh0iP+KdWrJEyYbor6s/Ngeg5q4jsNlCQFTmdlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716992094; c=relaxed/simple;
	bh=91LqUhcqm7aQDNXFER1289HrXrJMi31z3CJTTjdUUdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQH7onyCXg7lqJHtWtBYKiwLmNT5y0B37L8gWpvRS5L7dwda+xC/pSxoWOHI/ud+PnkroPF4o2rrp/M1Qo7huADwxNXZaH8jEIYeCj/CM7QmAW9CB3bl0UADrfGMLA1BFb8bpMxIODp3hPYnZR9S5by43ECxj5XqWsxKlKMuHNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hRFRYPhZ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716992093; x=1748528093;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=91LqUhcqm7aQDNXFER1289HrXrJMi31z3CJTTjdUUdg=;
  b=hRFRYPhZPi7l0/Caa2Kw/Nv9CQF/+KE2j82zvK2YPqR+2Xe3oQs0hGVM
   aBA4XqUGYfFrvlHiZ8J8JpP1dm5vjnqy/GENxJLYQ019Kjayr7bjtqLsA
   yvHXUYBobEEYHLtAheJ+NVh6G1+XgCnvR/QHTD423rRHFvo5W21IqE7+A
   Nhh0+V7KS3C6fWDxo5DhjN9//4QYsvrKxdNPVREq4+OumgfIpYu3i/IUg
   ADbtNQz3Jx9DjIb9CGBe2H74z93zurr+Lrf2hgTMXE175nTWCUxipiIdD
   ab48kS4pctrjnLsYtgKTJkXJTrr8JRcFBoQgGG80hSPt7F/PHm0TxI0OS
   Q==;
X-CSE-ConnectionGUID: tfV5zf5VRt+f9fd53aIJrg==
X-CSE-MsgGUID: aud1bOnDSHiEzehezjGyCw==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13346251"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="13346251"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 07:14:52 -0700
X-CSE-ConnectionGUID: gfjwUD+ETqqOi74aEUnPvw==
X-CSE-MsgGUID: TKPn6DtTQy2SMKQYEMVB8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="35419053"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 29 May 2024 07:14:48 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 29 May 2024 17:14:47 +0300
Date: Wed, 29 May 2024 17:14:47 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	linux-kernel@vger.kernel.org,
	Chris Bainbridge <chris.bainbridge@gmail.com>, hughsient@gmail.com
Subject: Re: [PATCH v2] drm/client: Detect when ACPI lid is closed during
 initialization
Message-ID: <Zlc4V1goFvU2antl@intel.com>
References: <20240528210319.1242-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240528210319.1242-1-mario.limonciello@amd.com>
X-Patchwork-Hint: comment

On Tue, May 28, 2024 at 04:03:19PM -0500, Mario Limonciello wrote:
> If the lid on a laptop is closed when eDP connectors are populated
> then it remains enabled when the initial framebuffer configuration
> is built.
> 
> When creating the initial framebuffer configuration detect the ACPI
> lid status and if it's closed disable any eDP connectors.
> 
> Reported-by: Chris Bainbridge <chris.bainbridge@gmail.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3349
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> Cc: hughsient@gmail.com
> v1->v2:
>  * Match LVDS as well
> ---
>  drivers/gpu/drm/drm_client_modeset.c | 30 ++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
> index 31af5cf37a09..0b0411086e76 100644
> --- a/drivers/gpu/drm/drm_client_modeset.c
> +++ b/drivers/gpu/drm/drm_client_modeset.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #include "drm/drm_modeset_lock.h"
> +#include <acpi/button.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/slab.h>
> @@ -257,6 +258,34 @@ static void drm_client_connectors_enabled(struct drm_connector **connectors,
>  		enabled[i] = drm_connector_enabled(connectors[i], false);
>  }
>  
> +static void drm_client_match_edp_lid(struct drm_device *dev,
> +				     struct drm_connector **connectors,
> +				     unsigned int connector_count,
> +				     bool *enabled)
> +{
> +	int i;
> +
> +	for (i = 0; i < connector_count; i++) {
> +		struct drm_connector *connector = connectors[i];
> +
> +		switch (connector->connector_type) {
> +		case DRM_MODE_CONNECTOR_LVDS:
> +		case DRM_MODE_CONNECTOR_eDP:
> +			if (!enabled[i])
> +				continue;
> +			break;
> +		default:
> +			continue;
> +		}
> +
> +		if (!acpi_lid_open()) {
> +			drm_dbg_kms(dev, "[CONNECTOR:%d:%s] lid is closed, disabling\n",
> +				    connector->base.id, connector->name);
> +			enabled[i] = false;
> +		}
> +	}
> +}

If you don't hook into some lid notify event how is one supposed to get
the display back to life after opening the lid?

> +
>  static bool drm_client_target_cloned(struct drm_device *dev,
>  				     struct drm_connector **connectors,
>  				     unsigned int connector_count,
> @@ -844,6 +873,7 @@ int drm_client_modeset_probe(struct drm_client_dev *client, unsigned int width,
>  		memset(crtcs, 0, connector_count * sizeof(*crtcs));
>  		memset(offsets, 0, connector_count * sizeof(*offsets));
>  
> +		drm_client_match_edp_lid(dev, connectors, connector_count, enabled);
>  		if (!drm_client_target_cloned(dev, connectors, connector_count, modes,
>  					      offsets, enabled, width, height) &&
>  		    !drm_client_target_preferred(dev, connectors, connector_count, modes,
> -- 
> 2.43.0

-- 
Ville Syrjälä
Intel

