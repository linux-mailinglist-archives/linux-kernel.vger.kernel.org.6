Return-Path: <linux-kernel+bounces-531893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1131BA4467F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C60EB860B9B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A6414A60A;
	Tue, 25 Feb 2025 16:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eKvv1cIf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B1215383D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501413; cv=none; b=pqZdFKf/64BvGlsj1RJqoS8kS0TPAFwVenVcvFLNxf8eI5tfacEKJEo4xg85lRLXm6oPCEvkCWfcyigMbOv3M7LjSQGvjNGy256/62G4PCc2n961f/Qc3pbGuchuIJ+1GVbl4RvFPFvKubFZb2H/yW8mIEige2yMFEd9qC4k5yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501413; c=relaxed/simple;
	bh=ajMeBsRypk2qfz3LU0HDlFR+UI4BN17crahO5/D0Ljk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RmRtFKjl1fIozHOus58NczgYdDpg/25+bxmhjXWHfGn8hmkykDCGr7VCbQYvTK1BnJNoB0+EFvo2oKksEnsNZrdwEUSb41TeUeKkwpDAAWy53DOkXnkM6U9z3duHcCrtU+lwtyi0WK6QbRYis1DhB9oFL7I3ivxrWVHilV9zUZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eKvv1cIf; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740501411; x=1772037411;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ajMeBsRypk2qfz3LU0HDlFR+UI4BN17crahO5/D0Ljk=;
  b=eKvv1cIfMQOVj8glYKxpyak818vSnxmYSZcLnzSPQk0Y5PNCoe42v7Va
   cjyGzwM7maykbMUWFgOlkImhD4pCPqSuzb1SLtS2OTHBu2qYOJpYyZ8/r
   RmVEd2S3BgEn8iqU5KNbSsDCLmmvmnozHgJEfTwPEvAEre3qbNjDIPLGR
   GMtA0js3Q2J6bena8ifGmfAX8uAEPCHrQo+5NqIzbZKaqalk/g/nTlYmE
   sG9D5BEt8puPnWYWjwwlL27kZan44kP9dgDVOgfSMtz/Pl41DK4mAZElw
   UfSB2dM5CUxGuML1snoVy/Bor4NrHrG4AsH3WMH/CWsGzQqFv31qUBr8x
   A==;
X-CSE-ConnectionGUID: synM/JGPS5OWel9HIAG7TA==
X-CSE-MsgGUID: bEE/LWLRSE2ht3TVgbT1Lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52740029"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52740029"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 08:36:50 -0800
X-CSE-ConnectionGUID: 0XPBIbJkTqmi19/ZfbCgsQ==
X-CSE-MsgGUID: UMXQ0kGKTbCvktN37fhdaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121688693"
Received: from monicael-mobl3 (HELO localhost) ([10.245.246.246])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 08:36:44 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v7 1/2] drm/bridge: move bridges_show logic from
 drm_debugfs.c
In-Reply-To: <20250225-drm-debugfs-show-all-bridges-v7-1-8826037ada37@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250225-drm-debugfs-show-all-bridges-v7-0-8826037ada37@bootlin.com>
 <20250225-drm-debugfs-show-all-bridges-v7-1-8826037ada37@bootlin.com>
Date: Tue, 25 Feb 2025 18:36:41 +0200
Message-ID: <878qpu56cm.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 25 Feb 2025, Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:
> In preparation to expose more info about bridges in debugfs, which will
> require more insight into drm_bridge data structures, move the bridges_show
> code to drm_bridge.c.
>
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

I hate myself for doing this on a patch that's at v7... but here goes.

Perhaps consider moving the bridges debugfs creation and fops to
drm_bridge.c instead of just adding
drm_bridge_debugfs_show_encoder_bridges().

For example, add drm_bridge_debugfs_add(struct drm_encoder *encoder),
which then contains the debugfs_create_file() call.

Interestingly, this lets you drop a lot of #ifdef CONFIG_DEBUG_FS. The
compiler optimizes the fops struct and the functions away when
debugfs_create_file() becomes a stub for CONFIG_DEBUG_FS=n. It becomes
all around cleaner.


BR,
Jani.


>
> ---
>
> This patch was added in v7.
> ---
>  drivers/gpu/drm/drm_bridge.c  | 33 +++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/drm_debugfs.c | 27 ++-------------------------
>  include/drm/drm_bridge.h      |  8 ++++++++
>  3 files changed, 43 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 241a384ebce39b4a3db58c208af27960904fc662..6e1e02c1cf443fbaa764765ad369b7a34cc03f2d 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -1335,6 +1335,39 @@ struct drm_bridge *of_drm_find_bridge(struct device_node *np)
>  EXPORT_SYMBOL(of_drm_find_bridge);
>  #endif
>  
> +#ifdef CONFIG_DEBUG_FS
> +void drm_bridge_debugfs_show_encoder_bridges(struct drm_printer *p,
> +					     struct drm_encoder *encoder)
> +{
> +	struct drm_bridge *bridge;
> +	unsigned int idx = 0;
> +
> +	drm_for_each_bridge_in_chain(encoder, bridge) {
> +		drm_printf(p, "bridge[%u]: %ps\n", idx++, bridge->funcs);
> +		drm_printf(p, "\ttype: [%d] %s\n",
> +			   bridge->type,
> +			   drm_get_connector_type_name(bridge->type));
> +
> +		if (bridge->of_node)
> +			drm_printf(p, "\tOF: %pOFfc\n", bridge->of_node);
> +
> +		drm_printf(p, "\tops: [0x%x]", bridge->ops);
> +		if (bridge->ops & DRM_BRIDGE_OP_DETECT)
> +			drm_puts(p, " detect");
> +		if (bridge->ops & DRM_BRIDGE_OP_EDID)
> +			drm_puts(p, " edid");
> +		if (bridge->ops & DRM_BRIDGE_OP_HPD)
> +			drm_puts(p, " hpd");
> +		if (bridge->ops & DRM_BRIDGE_OP_MODES)
> +			drm_puts(p, " modes");
> +		if (bridge->ops & DRM_BRIDGE_OP_HDMI)
> +			drm_puts(p, " hdmi");
> +		drm_puts(p, "\n");
> +	}
> +}
> +EXPORT_SYMBOL(drm_bridge_debugfs_show_encoder_bridges);
> +#endif
> +
>  MODULE_AUTHOR("Ajay Kumar <ajaykumar.rs@samsung.com>");
>  MODULE_DESCRIPTION("DRM bridge infrastructure");
>  MODULE_LICENSE("GPL and additional rights");
> diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
> index 6b2178864c7ee12db9aa1f562e106b2f604439f8..a625c0c9a9aa076af19c8ba47564dbb24ba71c9a 100644
> --- a/drivers/gpu/drm/drm_debugfs.c
> +++ b/drivers/gpu/drm/drm_debugfs.c
> @@ -744,31 +744,8 @@ static int bridges_show(struct seq_file *m, void *data)
>  {
>  	struct drm_encoder *encoder = m->private;
>  	struct drm_printer p = drm_seq_file_printer(m);
> -	struct drm_bridge *bridge;
> -	unsigned int idx = 0;
> -
> -	drm_for_each_bridge_in_chain(encoder, bridge) {
> -		drm_printf(&p, "bridge[%u]: %ps\n", idx++, bridge->funcs);
> -		drm_printf(&p, "\ttype: [%d] %s\n",
> -			   bridge->type,
> -			   drm_get_connector_type_name(bridge->type));
> -
> -		if (bridge->of_node)
> -			drm_printf(&p, "\tOF: %pOFfc\n", bridge->of_node);
> -
> -		drm_printf(&p, "\tops: [0x%x]", bridge->ops);
> -		if (bridge->ops & DRM_BRIDGE_OP_DETECT)
> -			drm_puts(&p, " detect");
> -		if (bridge->ops & DRM_BRIDGE_OP_EDID)
> -			drm_puts(&p, " edid");
> -		if (bridge->ops & DRM_BRIDGE_OP_HPD)
> -			drm_puts(&p, " hpd");
> -		if (bridge->ops & DRM_BRIDGE_OP_MODES)
> -			drm_puts(&p, " modes");
> -		if (bridge->ops & DRM_BRIDGE_OP_HDMI)
> -			drm_puts(&p, " hdmi");
> -		drm_puts(&p, "\n");
> -	}
> +
> +	drm_bridge_debugfs_show_encoder_bridges(&p, encoder);
>  
>  	return 0;
>  }
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 496dbbd2ad7edff7f091adfbe62de1e33ef0cf07..23c062853e7bb42d8d73af35ef7f16fb37345a37 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -1108,4 +1108,12 @@ static inline struct drm_bridge *drmm_of_get_bridge(struct drm_device *drm,
>  }
>  #endif
>  
> +#ifdef CONFIG_DEBUG_FS
> +void drm_bridge_debugfs_show_encoder_bridges(struct drm_printer *p,
> +					     struct drm_encoder *encoder);
> +#else
> +static inline void drm_bridge_debugfs_show_encoder_bridges(struct drm_printer *p,
> +							   struct drm_encoder *encoder) {}
> +#endif
> +
>  #endif

-- 
Jani Nikula, Intel

