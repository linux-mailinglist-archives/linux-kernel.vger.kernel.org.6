Return-Path: <linux-kernel+bounces-447750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB419F36A6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95EF81635C8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B7120B207;
	Mon, 16 Dec 2024 16:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bXQMh5TL"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D877920B1F7
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 16:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367669; cv=none; b=Dx9yclpAqjZkUbFxYEgBdgiTxNjBzTxHr0vb/tcSApIQcLOi+GX/zlPhI9NOfZmnfFUd+iQfjIkYJ6NliTb8dJOsUjfqa9zdSHeBUvwkG4cPhTri4oQ4NsEFp7cP8hQnDlNqi+ZetHB4+8XdQJ4Ao0PwSXMdpepb8qJwxHOTsyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367669; c=relaxed/simple;
	bh=CiugntSp+3NRmV8UVUmhpRG0LKrLStABLs9PbVUfb3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBEAOkVfbjJSvbb192kDTJpy/JjKXoguaCQeu2Pvz6OjLGLRN4AFJqGgOzq0qBMGZKj0D1fV2/5hp2kGdt8Sg25Wy9gkA3lAahVZLuMrTMmaEt/tPS9znAB1T7yXq/bNjbJM6vCsu1YDOykYY4Ay1H+zoKqQumoUCgcn0zl/kxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bXQMh5TL; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 06B14C0004;
	Mon, 16 Dec 2024 16:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734367665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+07CD4fY5x2B4CMxa+xHnzg0KR8i+mbynhseDFBUxRs=;
	b=bXQMh5TLnYxpUUDpy5CMqGm9fuSW/tMoAqTtjC6GxIxKjP4uAVgGJxnvfN+zgGYfeXRSEb
	sKlw0WJvsEqvnYJfJnSqUARqcTODcXh9q2VLtJsEIO8lbk9UFw70Em1PFbeySG3XS3cfM/
	loNaB8Ie52xQ5/2mEg7t36qbq4gxLMmwiIxmMl3RkQCpWGQghHifnbKaTNlT+PK0lj1up2
	vsXe5wFL1zCIEd3TTCDtDjFtpnP0DyI9kkddexiKYv+ZUTA8s0jX/rlIxCeY83NeAKnRSS
	PNJ6RipEEpa954eDQmknMRYJal9CA0WBd8+XUves1NXlQDtWsks1gEAqnl4UXA==
Date: Mon, 16 Dec 2024 17:47:42 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3 3/4] drm/mode_object: add
 drm_mode_object_read_refcount()
Message-ID: <Z2BZrpx9Bhr6q1C8@louis-chauvet-laptop>
Mail-Followup-To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20241216-drm-small-improvements-v3-0-78bbc95ac776@bootlin.com>
 <20241216-drm-small-improvements-v3-3-78bbc95ac776@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216-drm-small-improvements-v3-3-78bbc95ac776@bootlin.com>
X-GND-Sasl: louis.chauvet@bootlin.com

On 16/12/24 - 17:40, Luca Ceresoli wrote:
> Add a wrapper to kref_read() just like the ones already in place for
> kref_get() and kref_put(). This will be used for sanity checks on object
> lifetime.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Acked-by: Louis Chauvet <louis.chauvet@bootlin.com>

Thanks,
Louis Chauvet
 
> ---
> 
> Changed in v3:
> 
>  * use conventions for 'Returns' doc syntax
>  * ditch DRM_DEBUG() and as a consequence rework and simplify the entire
>    function
>  * fix function name in kerneldoc
> ---
>  drivers/gpu/drm/drm_mode_object.c | 17 +++++++++++++++++
>  include/drm/drm_mode_object.h     |  1 +
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_mode_object.c b/drivers/gpu/drm/drm_mode_object.c
> index df4cc0e8e263d5887a799cf1a61d998234be7158..b9a16aceb926782eb033434eb6967ce9fd2e94f7 100644
> --- a/drivers/gpu/drm/drm_mode_object.c
> +++ b/drivers/gpu/drm/drm_mode_object.c
> @@ -217,6 +217,23 @@ void drm_mode_object_get(struct drm_mode_object *obj)
>  }
>  EXPORT_SYMBOL(drm_mode_object_get);
>  
> +/**
> + * drm_mode_object_read_refcount - read the refcount for a mode object
> + * @obj: DRM mode object
> + *
> + * Returns:
> + * The current object refcount if it is a refcounted modeset object, or 0
> + * for any other object.
> + */
> +unsigned int drm_mode_object_read_refcount(struct drm_mode_object *obj)
> +{
> +	if (obj->free_cb)
> +		return kref_read(&obj->refcount);
> +
> +	return 0;
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
> 
> -- 
> 2.34.1
> 

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

