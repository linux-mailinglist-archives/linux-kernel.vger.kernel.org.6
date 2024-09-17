Return-Path: <linux-kernel+bounces-331893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F0097B287
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 18:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B74B1C21AE0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 16:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C152817B4ED;
	Tue, 17 Sep 2024 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIgZmPiK"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F02181329
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 16:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726588960; cv=none; b=e8wVMFkzvGUr7Nxq8+X5dZxI3qRK5+0OL47QBEzmgLmfm0uRETn0PH4BedxZsvpG3NWPqwE3o9vnwGEqNsQwubenrYHG/vYiqAoiAakUv6OIqqVGIylNdcamxX3UNwc/B2hUS30bcRV69w+1Qb/pozzi2U3oc4aiuCBGwes/Tms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726588960; c=relaxed/simple;
	bh=IzsfkJ2euzm3ZmAlTVcxGGeV4DyjYHry6P5qgOPKGKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mVk8exuYNw60b0J4VeGQSARO3ZB7pZ4OX5CzPExlCYOPNMiwa9vQ0ghHMy10gcHQtW7xDtzXhLNzyOO7+sdlVH/wB6uhfjRopNeAAkBOlMQcrIBSZbtiyuclJOaWKZZS2iymjJi8Q1qh9JyOOV1IQuVgKQ908eRYTic3ECRxGGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIgZmPiK; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f74e468aa8so60804531fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 09:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726588957; x=1727193757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Prb/XuntYvwW1szk7e/6s0gPqiKMdYwpWPFawPrBQg0=;
        b=PIgZmPiKeE2PVHBhjNDCEZ63UU93AnYWmSaOzn8dtgNkPfmL6YgXNPPR0Ez2xzNown
         ESzdxiIk89AIWtA8UdHxn1p7SxGp9qMoYtHRJ/4PP7NDX4l8M5IgOOK1gb9VghHmIo/S
         WpzA+u7O8CZBmlgeKAMXsqtb67IfenhbXlJF1cJVvmj58NhLpwGBlE5P05ypSFPX3pQe
         StBRucDMVvnp2iKsrG2v4HckIDPC1uvHHvVrDpWzsVQW+8VBFzkiiCvtoblCak0NJQo+
         dV+SjxIRagvcB3FiMvIVGxFCdA3J979JEu0rRag3nZd5HPe5VHNYkIPboNq8edMNLkco
         rrzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726588957; x=1727193757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Prb/XuntYvwW1szk7e/6s0gPqiKMdYwpWPFawPrBQg0=;
        b=DIQ2iCplzNIKHUMShSrD35+dPWUMKHueJsfIuMC4ed72Lv+116awvclZcb9shU1qlX
         5g1ZYkFhVTh65ObJ5ybYmOcEUVwWaAKPtLVb26XrnDvrj14rGdgg3Z6Uu6Q+/4cgyzaZ
         kqUSSn+vzWAUgHGDTQcJljhvY9xRfZ1if4b0ZGCT6KMJeF5cw+gSb6MSl2VdHDdX7MVb
         cVrXClh0+RpYfzpjrDJfu4sOT5ccivt1PSMVLYmTg6cqf6wr4DstGh3HFn6VkeFyCSZE
         P2RBBGovGAJDNYpbXw9GkLyRBtCwx5ot0SjbJxhVFXJGTd76yQit/O1RtkznJnoQQ5Ax
         3qOg==
X-Forwarded-Encrypted: i=1; AJvYcCVAYmEZsKhZYvDpT1//MiaYNpKNjN/6RkXJMusV9iRuKAfLUe32HONygWH+5EXOoH0Q3XDOWhVqclHWeIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKy1000EKbyBjgMstIL0109g+yeIAbRaKBzZ109ULBsg/gkFhG
	lLOzzXrhwcdqF5Is5mgtiK+hBF6GcKpZMXMI/8xW92DsHHnlHyrG
X-Google-Smtp-Source: AGHT+IFVvVB9rmAXRhSjeD7eoEgheQfsMenQ4xk0qEZ5eR827HzNC70srwXJZ+FpEXW9sEv39nqPHA==
X-Received: by 2002:a05:6512:258b:b0:536:9f72:c43a with SMTP id 2adb3069b0e04-5369f72c5a9mr129577e87.36.1726588956215;
        Tue, 17 Sep 2024 09:02:36 -0700 (PDT)
Received: from fedora.. ([213.94.26.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b194005sm140757665e9.40.2024.09.17.09.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 09:02:35 -0700 (PDT)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: louis.chauvet@bootlin.com
Cc: airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	jani.nikula@linux.intel.com,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	thomas.petazzoni@bootlin.com,
	tzimmermann@suse.de
Subject: [PATCH] drm: writeback: Introduce drm managed helpers
Date: Tue, 17 Sep 2024 18:02:35 +0200
Message-ID: <20240917160235.2947-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240906-writeback-drmm-v1-1-01ede328182c@bootlin.com>
References: <20240906-writeback-drmm-v1-1-01ede328182c@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey Louis,

> Currently drm_writeback_connector are created by
> drm_writeback_connector_init or drm_writeback_connector_init_with_encoder.
> Both of the function uses drm_connector_init and drm_encoder_init, but
> there is no way to properly clean those structure from outside. By using
> drm managed variants, we can ensure that the writeback connector is
> properly cleaned.
> 
> This patch introduce drmm_writeback_connector_init, an helper to initialize
> a writeback connector using drm managed helpers. This function allows the
> caller to use its own encoder.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
> Hi Maxime, Jani,
> 
> I tried with this commit to implement the drm-managed version of writeback 
> connector initialization. I tested with the current vkms driver, and it 
> seems to works (at least no crash/warns).
> 
> As suggested by Jani, I only created one function, which takes a 
> NULL-able pointer for encoder/encoder functions/possible_crtc. What do you 
> think about it?
> 
> Regarding the documentation, I think I repeated too much, can I simply add 
> comments like "see documentation of @... for the details / requirements"?
> 
> Good weekend,
> Louis Chauvet
> ---
>  drivers/gpu/drm/drm_writeback.c | 224 ++++++++++++++++++++++++++++++++++------
>  include/drm/drm_writeback.h     |   7 ++
>  2 files changed, 201 insertions(+), 30 deletions(-)
> 
> 
> ---
> base-commit: a6bb1f77a94335de67dba12e7f52651c115b82d2
> change-id: 20240829-writeback-drmm-b9b85dcdaf7b
> 
> Best regards,
> 
> diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
> index a031c335bdb9..a161deeea908 100644
> --- a/drivers/gpu/drm/drm_writeback.c
> +++ b/drivers/gpu/drm/drm_writeback.c
> @@ -18,6 +18,7 @@
>  #include <drm/drm_modeset_helper_vtables.h>
>  #include <drm/drm_property.h>
>  #include <drm/drm_writeback.h>
> +#include <drm/drm_managed.h>

Includes are sort alphabetically, you might want to move this one up.

>  
>  /**
>   * DOC: overview
> @@ -202,13 +203,12 @@ int drm_writeback_connector_init(struct drm_device *dev,
>  EXPORT_SYMBOL(drm_writeback_connector_init);
>  
>  /**
> - * drm_writeback_connector_init_with_encoder - Initialize a writeback connector with
> - * a custom encoder
> + * __drm_writeback_connector_init - Common initialization code for writeback
> + * connector
>   *
>   * @dev: DRM device
>   * @wb_connector: Writeback connector to initialize
>   * @enc: handle to the already initialized drm encoder
> - * @con_funcs: Connector funcs vtable
>   * @formats: Array of supported pixel formats for the writeback engine
>   * @n_formats: Length of the formats array
>   *
> @@ -224,41 +224,31 @@ EXPORT_SYMBOL(drm_writeback_connector_init);
>   * assigning the encoder helper functions, possible_crtcs and any other encoder
>   * specific operation.
>   *
> - * Drivers should always use this function instead of drm_connector_init() to
> - * set up writeback connectors if they want to manage themselves the lifetime of the
> - * associated encoder.
> - *
>   * Returns: 0 on success, or a negative error code
>   */
> -int drm_writeback_connector_init_with_encoder(struct drm_device *dev,
> -		struct drm_writeback_connector *wb_connector, struct drm_encoder *enc,
> -		const struct drm_connector_funcs *con_funcs, const u32 *formats,
> -		int n_formats)
> +static int __drm_writeback_connector_init(
> +	struct drm_device *dev, struct drm_writeback_connector *wb_connector,
> +	struct drm_encoder *enc, const u32 *formats, int n_formats)

Not a big deal, but ./scripts/checkpatch.pl complains about this
ideantation:

    CHECK: Lines should not end with a '('
    CHECK: Alignment should match open parenthesis

You can fix it with:

static int __drm_writeback_connector_init(struct drm_device *dev,
					  struct drm_writeback_connector *wb_connector,
					  struct drm_encoder *enc,
					  const u32 *formats,
					  int n_formats)

>  {
> -	struct drm_property_blob *blob;
>  	struct drm_connector *connector = &wb_connector->base;
>  	struct drm_mode_config *config = &dev->mode_config;
> -	int ret = create_writeback_properties(dev);
> -
> -	if (ret != 0)
> -		return ret;
> -
> -	blob = drm_property_create_blob(dev, n_formats * sizeof(*formats),
> -					formats);
> -	if (IS_ERR(blob))
> -		return PTR_ERR(blob);
> -
> +	struct drm_property_blob *blob;
> +	int ret;
>  
>  	connector->interlace_allowed = 0;
>  
> -	ret = drm_connector_init(dev, connector, con_funcs,
> -				 DRM_MODE_CONNECTOR_WRITEBACK);
> +	ret = create_writeback_properties(dev);
>  	if (ret)
> -		goto connector_fail;
> +		return ret;
>  
>  	ret = drm_connector_attach_encoder(connector, enc);
>  	if (ret)
> -		goto attach_fail;
> +		return ret;
> +
> +	blob = drm_property_create_blob(dev, n_formats * sizeof(*formats),
> +					formats);
> +	if (IS_ERR(blob))
> +		return PTR_ERR(blob);
>  
>  	INIT_LIST_HEAD(&wb_connector->job_queue);
>  	spin_lock_init(&wb_connector->job_lock);
> @@ -281,15 +271,189 @@ int drm_writeback_connector_init_with_encoder(struct drm_device *dev,
>  	wb_connector->pixel_formats_blob_ptr = blob;
>  
>  	return 0;
> +}
> +
> +/**
> + * drm_writeback_connector_init_with_encoder - Initialize a writeback connector with
> + * a custom encoder
> + *
> + * @dev: DRM device
> + * @wb_connector: Writeback connector to initialize
> + * @enc: handle to the already initialized drm encoder
> + * @con_funcs: Connector funcs vtable
> + * @formats: Array of supported pixel formats for the writeback engine
> + * @n_formats: Length of the formats array
> + *
> + * This function creates the writeback-connector-specific properties if they
> + * have not been already created, initializes the connector as
> + * type DRM_MODE_CONNECTOR_WRITEBACK, and correctly initializes the property
> + * values.
> + *
> + * This function assumes that the drm_writeback_connector's encoder has already been
> + * created and initialized before invoking this function.
> + *
> + * In addition, this function also assumes that callers of this API will manage
> + * assigning the encoder helper functions, possible_crtcs and any other encoder
> + * specific operation.
> + *
> + * Drivers should always use this function instead of drm_connector_init() to
> + * set up writeback connectors if they want to manage themselves the lifetime of the
> + * associated encoder.
> + *
> + * Returns: 0 on success, or a negative error code
> + */
> +int drm_writeback_connector_init_with_encoder(struct drm_device *dev,
> +		struct drm_writeback_connector *wb_connector, struct drm_encoder *enc,
> +		const struct drm_connector_funcs *con_funcs, const u32 *formats,
> +		int n_formats)
> +{
> +	struct drm_connector *connector = &wb_connector->base;
> +	int ret;
> +
> +	ret = drm_connector_init(dev, connector, con_funcs,
> +				 DRM_MODE_CONNECTOR_WRITEBACK);
> +	if (ret)
> +		return ret;
> +
> +	ret = __drm_writeback_connector_init(dev, wb_connector, enc, formats,
> +					     n_formats);
> +	if (ret)
> +		drm_connector_cleanup(connector);
>  
> -attach_fail:
> -	drm_connector_cleanup(connector);
> -connector_fail:
> -	drm_property_blob_put(blob);
>  	return ret;
>  }
>  EXPORT_SYMBOL(drm_writeback_connector_init_with_encoder);
>  
> +/**
> + * drm_writeback_connector_cleanup - Cleanup the writeback connector
> + * @dev: DRM device
> + * @data: Opaque pointer to the writeback connector
> + *
> + * This will decrement the reference counter of blobs and it will clean the
> + * remaining jobs in this writeback connector.
> + */
> +static void drm_writeback_connector_cleanup(struct drm_device *dev, void *data)
> +{
> +	struct drm_writeback_connector *wb_connector = data;
> +	unsigned long flags;
> +	struct drm_writeback_job *pos, *n;
> +
> +	drm_property_blob_put(wb_connector->pixel_formats_blob_ptr);
> +
> +	spin_lock_irqsave(&wb_connector->job_lock, flags);
> +	list_for_each_entry_safe(pos, n, &wb_connector->job_queue, list_entry) {
> +		drm_writeback_cleanup_job(pos);
> +		list_del(&pos->list_entry);
> +	}
> +	spin_unlock_irqrestore(&wb_connector->job_lock, flags);
> +}
> +
> +/**
> + * __drmm_writeback_connector_init - Initialize a writeback connector with
> + * a custom encoder
> + *
> + * @dev: DRM device
> + * @wb_connector: Writeback connector to initialize
> + * @con_funcs: Connector funcs vtable
> + * @enc: handle to the already initialized drm encoder
> + * @formats: Array of supported pixel formats for the writeback engine
> + * @n_formats: Length of the formats array
> + *
> + * This function initialize a writeback connector and register its cleanup.
> + * It uses the common helper @__drm_writeback_connector_init to do the
> + * general initialization.
> + *
> + * This function assumes that @enc has already been created and initialized
> + * before invoking this function.
> + *
> + * In addition, this function also assumes that callers of this API will manage
> + * assigning the encoder helper functions, possible_crtcs and any other encoder
> + * specific operation.
> + *
> + * Returns: 0 on success, or a negative error code
> + */
> +static int __drmm_writeback_connector_init(
> +	struct drm_device *dev, struct drm_writeback_connector *wb_connector,
> +	const struct drm_connector_funcs *con_funcs, struct drm_encoder *enc,
> +	const u32 *formats, int n_formats)

checkpatch warnings here as well.

> +{
> +	struct drm_connector *connector = &wb_connector->base;
> +	int ret;
> +
> +	ret = drmm_connector_init(dev, connector, con_funcs,
> +				  DRM_MODE_CONNECTOR_WRITEBACK, NULL);
> +	if (ret)
> +		return ret;
> +
> +	ret = __drm_writeback_connector_init(dev, wb_connector, enc, formats,
> +					     n_formats);
> +	if (ret) {
> +		drm_writeback_connector_cleanup(dev, &wb_connector);

Is it safe to call drm_writeback_connector_cleanup() without initializing
the job_queue and job_lock?

> +		return ret;
> +	}
> +
> +	ret = drmm_add_action_or_reset(dev, &drm_writeback_connector_cleanup,
> +				       wb_connector);
> +	if (ret)

Missing call to drm_writeback_connector_cleanup()?

> +		return ret;
> +
> +	return 0;
> +}
> +
> +/**
> + * drmm_writeback_connector_init - Initialize a writeback connector with
> + * a custom encoder
> + *
> + * @dev: DRM device
> + * @wb_connector: Writeback connector to initialize
> + * @con_funcs: Connector funcs vtable
> + * @enc: handle to the already initialized drm encoder, optional
> + * @enc_funcs: Encoder funcs vtable, optional

I think that this is only used if @enc is NULL, it'd be nice to clarify
it like you did with @possible_crtcs.

> + * @formats: Array of supported pixel formats for the writeback engine
> + * @n_formats: Length of the formats array
> + * @possible_crtcs: if @enc is NULL, this will set the possible_crtc for the
> + *		    newly created encoder
> + *
> + * This function initialize a writeback connector and register its cleanup.
> + *
> + * This function creates the writeback-connector-specific properties if they
> + * have not been already created, initializes the connector as
> + * type DRM_MODE_CONNECTOR_WRITEBACK, and correctly initializes the property
> + * values.
> + *
> + * If @enc is NULL, a drm-managed encoder is created and used.
> + * If @enc_funcs is not NULL, this vtable is attached to @enc or this new
> + * encoder.

Isn't it only attached when @enc is NULL?

> + *
> + * Returns: 0 on success, or a negative error code
> + */
> +int drmm_writeback_connector_init(
> +	struct drm_device *dev, struct drm_writeback_connector *wb_connector,
> +	const struct drm_connector_funcs *con_funcs,
> +	struct drm_encoder *enc,
> +	const struct drm_encoder_helper_funcs *enc_funcs, const u32 *formats,
> +	int n_formats, u32 possible_crtcs)

Same checkpatch issues.

> +{
> +	int ret;
> +
> +	if (!enc) {
> +		ret = drmm_encoder_init(dev, &wb_connector->encoder,
> +					NULL, DRM_MODE_ENCODER_VIRTUAL, NULL);
> +		if (ret)
> +			return ret;
> +
> +		enc = &wb_connector->encoder;

This modifies an input function parameter, not sure if it's intended
but undocumented.

> +		enc->possible_crtcs |= possible_crtcs;
> +		if (enc_funcs)
> +			drm_encoder_helper_add(enc, enc_funcs);
> +	}
> +
> +	return __drmm_writeback_connector_init(dev, wb_connector, con_funcs,
> +					       &wb_connector->encoder, formats,
> +					       n_formats);
> +}
> +EXPORT_SYMBOL(drmm_writeback_connector_init);
> +
>  int drm_writeback_set_fb(struct drm_connector_state *conn_state,
>  			 struct drm_framebuffer *fb)
>  {
> diff --git a/include/drm/drm_writeback.h b/include/drm/drm_writeback.h
> index 17e576c80169..88abfd3d4564 100644
> --- a/include/drm/drm_writeback.h
> +++ b/include/drm/drm_writeback.h
> @@ -161,6 +161,13 @@ int drm_writeback_connector_init_with_encoder(struct drm_device *dev,
>  				const struct drm_connector_funcs *con_funcs, const u32 *formats,
>  				int n_formats);
>  
> +int drmm_writeback_connector_init(
> +	struct drm_device *dev, struct drm_writeback_connector *wb_connector,
> +	const struct drm_connector_funcs *con_funcs,
> +	struct drm_encoder *enc,
> +	const struct drm_encoder_helper_funcs *enc_funcs, const u32 *formats,
> +	int n_formats, u32 possible_crtcs);
> +

This indentation make checkpatch happy:

int drmm_writeback_connector_init(struct drm_device *dev,
				  struct drm_writeback_connector *wb_connector,
				  const struct drm_connector_funcs *con_funcs,
				  struct drm_encoder *enc,
				  const struct drm_encoder_helper_funcs *enc_funcs,
				  const u32 *formats,
				  int n_formats,
				  u32 possible_crtcs);

>  int drm_writeback_set_fb(struct drm_connector_state *conn_state,
>  			 struct drm_framebuffer *fb);
>  
> 

