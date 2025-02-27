Return-Path: <linux-kernel+bounces-535874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 305E4A47861
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 065061890983
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C19227B9A;
	Thu, 27 Feb 2025 08:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bcVSPr5A"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B69B225779
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740646581; cv=none; b=Wiyc+ydkz2j11aBkknsXLSjgvs0WdwnC77A0kvg0f+DXhVpQpUK1ZCYCTYbf19E9uqpaPZN/ZBPxbsI2rCIsigf2w+BPZKWn0rQ+QGThRSBynoOE774mswgXxfjwUElU56h9IwLe1CibscfR7Wm8hlIYDbmiycIM1yuHZ3A/fsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740646581; c=relaxed/simple;
	bh=NmyNVpOEA4NZSPEjTXVxjMre3p87YQf4hY+AnwQy/MU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mdhKIkyJVWs09XppqWD7WoHUsyspTIXPTPfBUmH1orAh6LoouZw0csE5qs6nuYf8egLD4jTB163OCPllvbuYaP+Kk9YAVPyYOmE9PTFqMKu8MbR9hpZ6ThxtZSFNSWRzeTQzUxeJrDICI5BJtFVMvWpunKNZ8Qa0cQMrYvV8W+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bcVSPr5A; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740646579; x=1772182579;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=NmyNVpOEA4NZSPEjTXVxjMre3p87YQf4hY+AnwQy/MU=;
  b=bcVSPr5AlY4LJ1oOBxKArH/KegLn4rY5KO4syL8ij1qd1cAF0qHmoj2k
   tY/ofNRkLeuIlU8eUz8BSBQDjsj90e92pxQwuakFgQnRfeD0S+beYc96B
   GkCGLm7lFWa8Yw8ta1YoV7okKHUm7SlYgMHy2O5i/6ZYxGlLNiRW6jL/N
   TYWQpt8MHO2lm8YSq6pnSfyOenWqD3d/wdooV0oUdVSdwx0cAZG1UxVTQ
   0+F+46lEphhifC8dBMwhLmR0qA7nZf2Ihjt3fj1wbamQovMPaQeYxfF97
   48o0a1503PQT+5t185vCQY9xA6H21H0NWIl8S/2GEoeNlSU87PpS/6WSp
   g==;
X-CSE-ConnectionGUID: 45zOVVgnR/20RPkQU/Lg0w==
X-CSE-MsgGUID: 5eZFnjQXQlCY33L2GTj0qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="45438619"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="45438619"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 00:56:18 -0800
X-CSE-ConnectionGUID: NZGzfWmKQyqX2S402WngRw==
X-CSE-MsgGUID: 3oh0WbbgTpWB3Vs/QIfuiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="121973960"
Received: from lfiedoro-mobl.ger.corp.intel.com (HELO localhost) ([10.245.246.181])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 00:56:13 -0800
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
Subject: Re: [PATCH v8 1/2] drm/bridge: move bridges_show logic from
 drm_debugfs.c
In-Reply-To: <20250226-drm-debugfs-show-all-bridges-v8-1-bb511cc49d83@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250226-drm-debugfs-show-all-bridges-v8-0-bb511cc49d83@bootlin.com>
 <20250226-drm-debugfs-show-all-bridges-v8-1-bb511cc49d83@bootlin.com>
Date: Thu, 27 Feb 2025 10:56:09 +0200
Message-ID: <87a5a74vh2.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 26 Feb 2025, Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:
> In preparation to expose more info about bridges in debugfs, which will
> require more insight into drm_bridge data structures, move the bridges_show
> code to drm_bridge.c.
>
> Suggested-by: Jani Nikula <jani.nikula@linux.intel.com>
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>
> ---
>
> Changed in v8:
>  - add the file in drm_bridge.c, which avois the added #if CONFIG_DEBUG_FS
>
> This patch was added in v7.
> ---
>  drivers/gpu/drm/drm_bridge.c  | 42 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/drm_debugfs.c | 38 +-------------------------------------
>  include/drm/drm_bridge.h      |  2 ++
>  3 files changed, 45 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 241a384ebce39b4a3db58c208af27960904fc662..a6bf1a565e3c3a8d24de60448972849f6d86ba72 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -21,6 +21,7 @@
>   * DEALINGS IN THE SOFTWARE.
>   */
>  
> +#include <linux/debugfs.h>
>  #include <linux/err.h>
>  #include <linux/media-bus-format.h>
>  #include <linux/module.h>
> @@ -1335,6 +1336,47 @@ struct drm_bridge *of_drm_find_bridge(struct device_node *np)
>  EXPORT_SYMBOL(of_drm_find_bridge);
>  #endif
>  
> +static int encoder_bridges_show(struct seq_file *m, void *data)
> +{
> +	struct drm_encoder *encoder = m->private;
> +	struct drm_printer p = drm_seq_file_printer(m);
> +	struct drm_bridge *bridge;
> +	unsigned int idx = 0;
> +
> +	drm_for_each_bridge_in_chain(encoder, bridge) {
> +		drm_printf(&p, "bridge[%u]: %ps\n", idx++, bridge->funcs);
> +		drm_printf(&p, "\ttype: [%d] %s\n",
> +			   bridge->type,
> +			   drm_get_connector_type_name(bridge->type));
> +
> +		if (bridge->of_node)
> +			drm_printf(&p, "\tOF: %pOFfc\n", bridge->of_node);
> +
> +		drm_printf(&p, "\tops: [0x%x]", bridge->ops);
> +		if (bridge->ops & DRM_BRIDGE_OP_DETECT)
> +			drm_puts(&p, " detect");
> +		if (bridge->ops & DRM_BRIDGE_OP_EDID)
> +			drm_puts(&p, " edid");
> +		if (bridge->ops & DRM_BRIDGE_OP_HPD)
> +			drm_puts(&p, " hpd");
> +		if (bridge->ops & DRM_BRIDGE_OP_MODES)
> +			drm_puts(&p, " modes");
> +		if (bridge->ops & DRM_BRIDGE_OP_HDMI)
> +			drm_puts(&p, " hdmi");
> +		drm_puts(&p, "\n");
> +	}
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(encoder_bridges);
> +
> +void drm_bridge_debugfs_encoder_params(struct dentry *root,
> +				       struct drm_encoder *encoder)
> +{
> +	/* bridges list */
> +	debugfs_create_file("bridges", 0444, root, encoder, &encoder_bridges_fops);

The function could look at encoder->debugfs_entry instead of requiring
the root parameter, but that's neither here nor there.

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> +}
> +
>  MODULE_AUTHOR("Ajay Kumar <ajaykumar.rs@samsung.com>");
>  MODULE_DESCRIPTION("DRM bridge infrastructure");
>  MODULE_LICENSE("GPL and additional rights");
> diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
> index 6b2178864c7ee12db9aa1f562e106b2f604439f8..3dfd8b34dceb7a5b8f11e3072a1eaef430869722 100644
> --- a/drivers/gpu/drm/drm_debugfs.c
> +++ b/drivers/gpu/drm/drm_debugfs.c
> @@ -740,40 +740,6 @@ void drm_debugfs_crtc_remove(struct drm_crtc *crtc)
>  	crtc->debugfs_entry = NULL;
>  }
>  
> -static int bridges_show(struct seq_file *m, void *data)
> -{
> -	struct drm_encoder *encoder = m->private;
> -	struct drm_printer p = drm_seq_file_printer(m);
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
> -
> -	return 0;
> -}
> -DEFINE_SHOW_ATTRIBUTE(bridges);
> -
>  void drm_debugfs_encoder_add(struct drm_encoder *encoder)
>  {
>  	struct drm_minor *minor = encoder->dev->primary;
> @@ -789,9 +755,7 @@ void drm_debugfs_encoder_add(struct drm_encoder *encoder)
>  
>  	encoder->debugfs_entry = root;
>  
> -	/* bridges list */
> -	debugfs_create_file("bridges", 0444, root, encoder,
> -			    &bridges_fops);
> +	drm_bridge_debugfs_encoder_params(root, encoder);
>  
>  	if (encoder->funcs && encoder->funcs->debugfs_init)
>  		encoder->funcs->debugfs_init(encoder, root);
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 496dbbd2ad7edff7f091adfbe62de1e33ef0cf07..0890acfe04b99b1ccbbff10b507cb8c2b2705e06 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -1108,4 +1108,6 @@ static inline struct drm_bridge *drmm_of_get_bridge(struct drm_device *drm,
>  }
>  #endif
>  
> +void drm_bridge_debugfs_encoder_params(struct dentry *root, struct drm_encoder *encoder);
> +
>  #endif

-- 
Jani Nikula, Intel

