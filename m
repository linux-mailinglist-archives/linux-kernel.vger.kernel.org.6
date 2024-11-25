Return-Path: <linux-kernel+bounces-420697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 116579D8248
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57180B2750F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A33190485;
	Mon, 25 Nov 2024 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HuJqErMZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9014319006B
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732526970; cv=none; b=jCZOq+OpyMbldIntYHNwsnXWQ+d+DpsF5sSNhetIb6teKtc7EjWgPflxK3lkdbENefC5rGN7/1RUQTviPAqz+cI6ehpJrjRBWy/8QId/fgUlKc0jyEPfnwOj2Cnj3qlg9o87NregEKBP+UQvedU+AjM9VauVSsw8GciEzDxJaVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732526970; c=relaxed/simple;
	bh=l/q2gxxyKo7+bYwAJ2zy18y5mBbZiypPDofxassGcHA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A2PF4Dl6eAOhryQIDMNXxcgbA+IehUA6apKgQtXnPBnvukiR/npP13QRn2ltEQzFJGkbRuY4JRhp+tXqm3l2beDZB0csQNKd5Uq6v9KZEDUGfz6W/3AK0IRmtnecC2bUALnbgon3iHRAxQfcCBL6tRR09ShBBDlAiqDvQzCPyLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HuJqErMZ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732526969; x=1764062969;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=l/q2gxxyKo7+bYwAJ2zy18y5mBbZiypPDofxassGcHA=;
  b=HuJqErMZZxi3MvugqAARWP73dko8UxpIZsOZ3ybaZu5YdPGJs5TGTR42
   AZtbdbbW4DDuONUUiBmDFiqYdeAvbYdX+4jemcLhaGKVYa5KU1WR5FYI4
   WKEdd2KnxYKRlvoDLuHxW73imRtbbv3g8uTKL7Fbw/PEdwZDvW1RsfGsq
   5yo+7Qqt97JAFUs0bH6W2LRpIjPAzXmvbtEru/rsEMutQhkWQGCGvaCNE
   TJzgxE+4+NVihg/0yKXgAEm5b9krSWdvoB77ZUALqo6hr03B2rKA4sQ+9
   sDgehZREGIzMtflIr/eX/ejG1qaEtY88KFAnZStFh90EQ2OQ7zhjG2ZAf
   A==;
X-CSE-ConnectionGUID: aHmpZeNcSwqZ4EEJkF+yYQ==
X-CSE-MsgGUID: v4uQWPeeQPGR81uqVpbOXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11266"; a="50032649"
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="50032649"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 01:29:27 -0800
X-CSE-ConnectionGUID: 7QBII2+CSEi2FEIoGsVC1w==
X-CSE-MsgGUID: vhG3nDZhRvSETyB5fdRrUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="91167848"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.243])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 01:29:21 -0800
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
Subject: Re: [PATCH RFC v2 11/18] drm/vkms: Introduce config for CRTC name
In-Reply-To: <20241122-google-remove-crtc-index-from-parameter-v2-11-81540742535a@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20241122-google-remove-crtc-index-from-parameter-v2-0-81540742535a@bootlin.com>
 <20241122-google-remove-crtc-index-from-parameter-v2-11-81540742535a@bootlin.com>
Date: Mon, 25 Nov 2024 11:29:17 +0200
Message-ID: <87r06zy842.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, 22 Nov 2024, Louis Chauvet <louis.chauvet@bootlin.com> wrote:
> As a CRTC will be a directory in ConfigFS, add the name configuration for
> CRTC name so we will be able to reflect the configfs directory name in the
> drm name.
>
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/vkms/vkms_config.c | 5 +++++
>  drivers/gpu/drm/vkms/vkms_config.h | 2 ++
>  drivers/gpu/drm/vkms/vkms_crtc.c   | 2 +-
>  3 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
> index a2539fb56b602569b75748fdf9c4784f104b0bff..3252f657ce515c0193a8c0e709bfe861feba0aca 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.c
> +++ b/drivers/gpu/drm/vkms/vkms_config.c
> @@ -37,6 +37,10 @@ struct vkms_config *vkms_config_alloc_default(bool enable_writeback, bool enable
>  	if (!crtc)
>  		goto err_alloc;
>  	crtc->writeback = enable_writeback;
> +	crtc->name = kzalloc(sizeof("Main CRTC"), GFP_KERNEL);
> +	if (!crtc->name)
> +		goto err_alloc;
> +	sprintf(crtc->name, "Main CRTC");

Ditto, kstrdup()

>  
>  	encoder = vkms_config_create_encoder(vkms_config);
>  	if (!encoder)
> @@ -219,6 +223,7 @@ void vkms_config_delete_crtc(struct vkms_config_crtc *vkms_config_crtc,
>  		}
>  	}
>  
> +	kfree(vkms_config_crtc->name);
>  	kfree(vkms_config_crtc);
>  }
>  
> diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
> index 4223edd94ec270915dd658c0b5efd489554d33a5..4a4c16dea7855cf36060986ef247be698974fafc 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.h
> +++ b/drivers/gpu/drm/vkms/vkms_config.h
> @@ -29,6 +29,7 @@ struct vkms_config {
>   * struct vkms_config_crtc
>   *
>   * @link: Link to the others CRTCs
> + * @name: Name of the CRTC
>   * @possible_planes: List of planes that can be used with this CRTC
>   * @possible_encoders: List of encoders that can be used with this CRTC
>   * @crtc: Internal usage. This pointer should never be considered as valid. It can be used to
> @@ -38,6 +39,7 @@ struct vkms_config {
>  struct vkms_config_crtc {
>  	struct list_head link;
>  
> +	char *name;
>  	bool writeback;
>  	struct xarray possible_planes;
>  	struct xarray possible_encoders;
> diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
> index 3825fba57c012f84cbe67114e053dcd7fcfa283d..25a3d97a362afd0d40f3e023d9cce985d447a880 100644
> --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> @@ -292,7 +292,7 @@ struct vkms_crtc *vkms_crtc_init(struct vkms_device *vkms_device,
>  
>  	vkms_crtc = drmm_crtc_alloc_with_planes(dev, struct vkms_crtc, base,
>  						primary, cursor,
> -						&vkms_crtc_funcs, NULL);
> +						&vkms_crtc_funcs, config->name);
>  	if (IS_ERR(vkms_crtc)) {
>  		DRM_DEV_ERROR(dev->dev, "Failed to init CRTC\n");
>  		return vkms_crtc;

-- 
Jani Nikula, Intel

