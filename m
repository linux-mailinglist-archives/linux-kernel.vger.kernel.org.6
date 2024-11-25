Return-Path: <linux-kernel+bounces-420695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 527FE9D823C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1817F2820E2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDFB190661;
	Mon, 25 Nov 2024 09:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h77z6FrV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A5519007F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732526936; cv=none; b=q9PZXoRplfTyYOjmNgy5uUmjOfB1RLtJYFsi0P7hugxaorfrNZ2ZwGj1zIykhLSvO73LLJBYuQBb9mflikEroxjZksal/6ZDRrMfi0ApELR2B1L0ds3ErSXqULHBQhnWjKRDQMLjgIYvxbGHKcDoN35s7GY9D2dZXhtzAz4A6jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732526936; c=relaxed/simple;
	bh=jT1D3Zn8az8eiWph3b8NMgGwTVOZfRsofkxmcWzwRQ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p+JBrtv6PYV3jbLAOoU4dO2qAyzwlAcTsn0xy4qBwZrzut4l04HYo2oO1u+OAOGMxxXPSAem3zpDBVOepF4J0HeqmaJxEMmxb9scthAso2Lc9kducGp2nvw9pTX9Mequv6qG2ZNMZuvKfhHXXTshvTSlXMNCzXoyRNrIeGcHBcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h77z6FrV; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732526935; x=1764062935;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=jT1D3Zn8az8eiWph3b8NMgGwTVOZfRsofkxmcWzwRQ0=;
  b=h77z6FrVKnG6Vp/5rrHgsBkEFZ221LyF63HY0VpNomdGIjm9GmSUJXZ5
   LD3dzYoYa7iQuVKsxZHvLzqehw6zTxYs7N5L1prifLgyka89wJ56TvYYF
   hTpkH0/qc+UXQuAdLPlhC7zlo2sn3KqGs+ZsSDPcc55+5ZT+oyGvWwmSf
   aE2j+CACzgWaYgNaCZIyF9aTHeo3wSCmX9Ul5o6MXE/jTyKFIOvcXM2C8
   SjDn5Vp6DkTZVOTneR+zzPedmF4SN31K7mgRmVIogvy7fig0pWjM7YJ5x
   Q/WSOgY50Vm4mjwRdRp/NENvbpQBisqkleVISkkwGeTgAFT7rzGCcYftg
   Q==;
X-CSE-ConnectionGUID: Pwl/ZyD3Rk6KOJdGf6qomQ==
X-CSE-MsgGUID: iWoMRNbaR7ClB9A/VsGGiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11266"; a="44002134"
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="44002134"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 01:28:54 -0800
X-CSE-ConnectionGUID: 6xwJc5UeRWeVfJ0Sjh6cfg==
X-CSE-MsgGUID: nchpINuHTwOctLRQCYOQcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="96266214"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.243])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 01:28:47 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>, =?utf-8?Q?Ma=C3=ADra?= Canal
 <mairacanal@riseup.net>, Haneen Mohammed <hamohammed.sa@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Melissa Wen <melissa.srw@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>
Cc: arthurgrillo@riseup.net, jeremie.dautheribes@bootlin.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 seanpaul@google.com, nicolejadeyee@google.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Louis
 Chauvet <louis.chauvet@bootlin.com>
Subject: Re: [PATCH RFC v2 10/18] drm/vkms: Introduce config for encoder name
In-Reply-To: <20241122-google-remove-crtc-index-from-parameter-v2-10-81540742535a@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20241122-google-remove-crtc-index-from-parameter-v2-0-81540742535a@bootlin.com>
 <20241122-google-remove-crtc-index-from-parameter-v2-10-81540742535a@bootlin.com>
Date: Mon, 25 Nov 2024 11:28:44 +0200
Message-ID: <87ttbvy84z.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, 22 Nov 2024, Louis Chauvet <louis.chauvet@bootlin.com> wrote:
> As an encoder will be a directory in ConfigFS, add the configuration for
> encoder name so we will be able to reflect the configfs directory name in
> the drm name.
>
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/vkms/vkms_config.c | 6 ++++++
>  drivers/gpu/drm/vkms/vkms_config.h | 2 ++
>  drivers/gpu/drm/vkms/vkms_output.c | 2 +-
>  3 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
> index e44ed904cefb97b8b6ab8fc27623e315397e0106..a2539fb56b602569b75748fdf9c4784f104b0bff 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.c
> +++ b/drivers/gpu/drm/vkms/vkms_config.c
> @@ -41,6 +41,10 @@ struct vkms_config *vkms_config_alloc_default(bool enable_writeback, bool enable
>  	encoder = vkms_config_create_encoder(vkms_config);
>  	if (!encoder)
>  		goto err_alloc;
> +	encoder->name = kzalloc(sizeof("Main Encoder"), GFP_KERNEL);
> +	if (!encoder->name)
> +		goto err_alloc;
> +	sprintf(encoder->name, "Main Encoder");

Drive-by comment, maybe kstrdup()?

>  
>  	if (vkms_config_encoder_attach_crtc(encoder, crtc))
>  		goto err_alloc;
> @@ -238,6 +242,7 @@ void vkms_config_delete_encoder(struct vkms_config_encoder *vkms_config_encoder,
>  		}
>  	}
>  
> +	kfree(vkms_config_encoder->name);
>  	kfree(vkms_config_encoder);
>  }
>  
> @@ -403,6 +408,7 @@ static int vkms_config_show(struct seq_file *m, void *data)
>  
>  	list_for_each_entry(config_encoder, &vkmsdev->config->encoders, link) {
>  		seq_puts(m, "encoder:\n");
> +		seq_printf(m, "\tname: %s\n", config_encoder->name);
>  	}
>  
>  	list_for_each_entry(config_crtc, &vkmsdev->config->crtcs, link) {
> diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
> index 8f247fc09373fb2c8145e83be05c6afec1ffac1c..4223edd94ec270915dd658c0b5efd489554d33a5 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.h
> +++ b/drivers/gpu/drm/vkms/vkms_config.h
> @@ -50,6 +50,7 @@ struct vkms_config_crtc {
>   * struct vkms_config_encoder
>   *
>   * @link: Link to the others encoders
> + * @name: Name of the encoder
>   * @possible_crtcs: List of CRTC that can be used with this encoder
>   * @encoder: Internal usage. This pointer should never be considered as valid. It can be used to
>   *         store a temporary reference to a vkms encoder during device creation. This pointer is
> @@ -58,6 +59,7 @@ struct vkms_config_crtc {
>  struct vkms_config_encoder {
>  	struct list_head link;
>  
> +	char *name;
>  	struct xarray possible_crtcs;
>  
>  	/* Internal usage */
> diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> index 03498a20d78dd8a66f9fc66b360c5ea57fc48d88..6277ad72fdd476d1eff52ad037389bdb1a254f5e 100644
> --- a/drivers/gpu/drm/vkms/vkms_output.c
> +++ b/drivers/gpu/drm/vkms/vkms_output.c
> @@ -92,7 +92,7 @@ int vkms_output_init(struct vkms_device *vkmsdev)
>  		if (!config_encoder->encoder)
>  			return -ENOMEM;
>  		ret = drmm_encoder_init(dev, config_encoder->encoder, NULL,
> -					DRM_MODE_ENCODER_VIRTUAL, NULL);
> +					DRM_MODE_ENCODER_VIRTUAL, config_encoder->name);
>  		if (ret) {
>  			DRM_ERROR("Failed to init encoder\n");
>  			return ret;

-- 
Jani Nikula, Intel

