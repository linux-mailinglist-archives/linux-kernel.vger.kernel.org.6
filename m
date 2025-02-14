Return-Path: <linux-kernel+bounces-515270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28052A362AF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A9BB1892DA2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1566E267396;
	Fri, 14 Feb 2025 16:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ck+GR09B"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C6770831
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 16:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739549166; cv=none; b=IubA/c/ia0QAH7x/8QMYYujfLWO7yfNTHfQlnJq+1fTveg5vUkffdMUKtrXdiJOdS+wyZa8pLiOg1d8/aW/4uHdKGJ12Lhv+/w/9dcs5iqSIWwAKYu54zdKS5N2k+rGOfmkcm9FpvURb2SIjDN7PrkeImX3c2FhvyoGod6iaXec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739549166; c=relaxed/simple;
	bh=+FqZ/1MhpJlCMBgu00n2IgemqkNH9utadvTPq8ETZ+4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JohAD3SM2bM+cCdFL/0gMNF5YJHHMNJpemYr8pSG2SK4NFQlXa11evKKu3bzNWqBhlTa6GC1vuf73sklTKCH/KQ9TRHTh6oIN8AIBhCAXesg5K9RrwRAIgI65n4H6cQayAJvpX5SZffKL+N60dXaaqc+NPbw99/EOHWwxQMEBgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ck+GR09B; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739549165; x=1771085165;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=+FqZ/1MhpJlCMBgu00n2IgemqkNH9utadvTPq8ETZ+4=;
  b=ck+GR09B7YqwOWXRsyF0Fjqx0HIlJfq426XfJK381HMxRRyhe94TRKA/
   Dp2qtEQOZb2FpCLasnaMHdKd+rwI/0N7dz5NHFJmYt5T09X7uQN4O+S9f
   Q6c7eOT14g4U2etPpTRpqFRWCNp/x/I8SyoHV5VCLe1vOwOCdqGCIiPhd
   HEhWZS3/rBbYL6soc3JJ7FXo5wsMF0k205VldKR8WTVhprrJQL2+zg6ab
   EAoJ3LbtrKM04B8P4G9PhQT8CNEQ2EOPmWc7t+E0Vhepp49y9ABWh+wfX
   0zNjpuhhZmAEWer3I6WM1m1nvLSBDFRI7Hra19SqHFB860rHVsle4IMvf
   w==;
X-CSE-ConnectionGUID: QwmdhtiRSai3H9LHNLouIw==
X-CSE-MsgGUID: 4itehgaKQkm2erJC6ZDOkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="44232711"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="44232711"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 08:06:04 -0800
X-CSE-ConnectionGUID: 9nd+vtQFROCMWTagu+QArw==
X-CSE-MsgGUID: OHzK/V+OQd+gJ9x74FVHVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="113691153"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.110])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 08:06:01 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Egor Vorontsov <sdoregor@sdore.me>, linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Egor Vorontsov
 <sdoregor@sdore.me>
Subject: Re: [PATCH v3 2/2] drm/edid: Refactor DisplayID timing block structs
In-Reply-To: <20250214110643.506740-2-sdoregor@sdore.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250214110643.506740-1-sdoregor@sdore.me>
 <20250214110643.506740-2-sdoregor@sdore.me>
Date: Fri, 14 Feb 2025 18:05:53 +0200
Message-ID: <87v7tcv7dq.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, 14 Feb 2025, Egor Vorontsov <sdoregor@sdore.me> wrote:
> Using le16 instead of u8[2].
>
> Suggested-by: Jani Nikula <jani.nikula@linux.intel.com>
> Signed-off-by: Egor Vorontsov <sdoregor@sdore.me>

The vsync and hsync having high bit indicate polarity makes this less
than perfect, but I think it's fine.

Reviewed-by: Jani Nikula <jani.nikula@intel.com>


> ---
>  drivers/gpu/drm/drm_displayid_internal.h | 18 +++++++--------
>  drivers/gpu/drm/drm_edid.c               | 28 ++++++++++++------------
>  2 files changed, 23 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_displayid_internal.h b/drivers/gpu/drm/drm_displayid_internal.h
> index 84831ecfdb6e..957dd0619f5c 100644
> --- a/drivers/gpu/drm/drm_displayid_internal.h
> +++ b/drivers/gpu/drm/drm_displayid_internal.h
> @@ -115,20 +115,20 @@ struct displayid_tiled_block {
>  struct displayid_detailed_timings_1 {
>  	u8 pixel_clock[3];
>  	u8 flags;
> -	u8 hactive[2];
> -	u8 hblank[2];
> -	u8 hsync[2];
> -	u8 hsw[2];
> -	u8 vactive[2];
> -	u8 vblank[2];
> -	u8 vsync[2];
> -	u8 vsw[2];
> +	__le16 hactive;
> +	__le16 hblank;
> +	__le16 hsync;
> +	__le16 hsw;
> +	__le16 vactive;
> +	__le16 vblank;
> +	__le16 vsync;
> +	__le16 vsw;
>  } __packed;
>  
>  struct displayid_detailed_timing_block {
>  	struct displayid_block base;
>  	struct displayid_detailed_timings_1 timings[];
> -};
> +} __packed;
>  
>  struct displayid_formula_timings_9 {
>  	u8 flags;
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 03edf0e1598e..32807cefc819 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -6760,23 +6760,23 @@ static void update_display_info(struct drm_connector *connector,
>  }
>  
>  static struct drm_display_mode *drm_mode_displayid_detailed(struct drm_device *dev,
> -							    struct displayid_detailed_timings_1 *timings,
> +							    const struct displayid_detailed_timings_1 *timings,
>  							    bool type_7)
>  {
>  	struct drm_display_mode *mode;
> -	unsigned pixel_clock = (timings->pixel_clock[0] |
> -				(timings->pixel_clock[1] << 8) |
> -				(timings->pixel_clock[2] << 16)) + 1;
> -	unsigned hactive = (timings->hactive[0] | timings->hactive[1] << 8) + 1;
> -	unsigned hblank = (timings->hblank[0] | timings->hblank[1] << 8) + 1;
> -	unsigned hsync = (timings->hsync[0] | (timings->hsync[1] & 0x7f) << 8) + 1;
> -	unsigned hsync_width = (timings->hsw[0] | timings->hsw[1] << 8) + 1;
> -	unsigned vactive = (timings->vactive[0] | timings->vactive[1] << 8) + 1;
> -	unsigned vblank = (timings->vblank[0] | timings->vblank[1] << 8) + 1;
> -	unsigned vsync = (timings->vsync[0] | (timings->vsync[1] & 0x7f) << 8) + 1;
> -	unsigned vsync_width = (timings->vsw[0] | timings->vsw[1] << 8) + 1;
> -	bool hsync_positive = (timings->hsync[1] >> 7) & 0x1;
> -	bool vsync_positive = (timings->vsync[1] >> 7) & 0x1;
> +	unsigned int pixel_clock = (timings->pixel_clock[0] |
> +				    (timings->pixel_clock[1] << 8) |
> +				    (timings->pixel_clock[2] << 16)) + 1;
> +	unsigned int hactive = le16_to_cpu(timings->hactive) + 1;
> +	unsigned int hblank = le16_to_cpu(timings->hblank) + 1;
> +	unsigned int hsync = (le16_to_cpu(timings->hsync) & 0x7fff) + 1;
> +	unsigned int hsync_width = le16_to_cpu(timings->hsw) + 1;
> +	unsigned int vactive = le16_to_cpu(timings->vactive) + 1;
> +	unsigned int vblank = le16_to_cpu(timings->vblank) + 1;
> +	unsigned int vsync = (le16_to_cpu(timings->vsync) & 0x7fff) + 1;
> +	unsigned int vsync_width = le16_to_cpu(timings->vsw) + 1;
> +	bool hsync_positive = le16_to_cpu(timings->hsync) & (1 << 15);
> +	bool vsync_positive = le16_to_cpu(timings->vsync) & (1 << 15);
>  
>  	mode = drm_mode_create(dev);
>  	if (!mode)

-- 
Jani Nikula, Intel

