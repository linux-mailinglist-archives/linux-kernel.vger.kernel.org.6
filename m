Return-Path: <linux-kernel+bounces-440310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C34809EBBA2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A96E28451A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9381323236B;
	Tue, 10 Dec 2024 21:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b/c/Jamj"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B7B230278
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 21:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733865057; cv=none; b=p8EoxyG1eVJN34Cua/920BsstoSK2UeBIs7i8ZfXN/ISfxg90XruQ1TQylOc3X2rBCKje4oXEO7RmEuwoGqiLUbeRyIvhhPojgjlO8yN/gJ22wMn9PTRH3zRjyHW4x/DBw+V8niSgKnla1d50o6UPEhR/ZCPt/eb+Cp/kV9xDj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733865057; c=relaxed/simple;
	bh=dc4V13SAML9zfGYbghDgHi2b7t8YywHKCNHbfBb1NtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHPFIUVUqH6tWH6xSWETpPOWLTpEZAwcBNwQYyg3xbmd56v3O9f2gnBtvv7sZC+l4YmuQNqLkVqDm8DMsjoMGXhdyqtV+ywUrcATqj9lBf+nmLpYXftRP3V/7DH51Ktm/fz7TSdNqKQh4Zlv8fdRYgAICmyE81VSRp6UndNmMU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b/c/Jamj; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5401e6efffcso2789117e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 13:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733865053; x=1734469853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4avOkLXXt+xxKkyvs53K/A4cLhmGU1rYalWmIxSH5lY=;
        b=b/c/JamjbvygFYr/+oL9UVc0SILRuv44rPQpQshOlYLGjNueXXPFyL75iQHbDjo4g9
         e4cEkk6pyUCHUp1S6+8ydJPypH63ObQOR7oTCp+Xz9kv2wUIqoTUOu0pwPQOYyWCqbIL
         h8gSLHYAJYlMw0H56dzcU0ba3xsCLvymDe3W0NRs1N0uT1LiLZpHwyrxt/gA3ufHIN0h
         u+QEkXanHD1p/HGbpX7cz1i5tRvL7h8Z2mtgM7BxO+ejihQVUbfITJ0ZKthX/RFC4xhF
         5ajLy4BzqjjK1b+HfzBk5KRkq1Nb+AWT9wqTYnpa8XtehlAwkVuqe+5TFVJmQpsnZ0HK
         FGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733865053; x=1734469853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4avOkLXXt+xxKkyvs53K/A4cLhmGU1rYalWmIxSH5lY=;
        b=URzIBIP4QUSljI2lp+D/040Fni73bs6oGINlEoa1iBwBMxB55ANDgihTC6OYbJY+Ly
         BqhGedRLcV2xCPCzACKPjqPXYHyLQWrwuS11MjLNNBzHhxHUquXWj3wapK5/1HpRxaSh
         yjPV/mOUxNxXfSfGBMv5imVppc1hFsC//hiOA98jsq5K8lruEbTHoNeHEOLzsHC6zwsS
         uk6x9f4OcuhZ27/74z0sr7km3TinRwVvjHoy5DhB1ThF4rOIhiORX42oleBPvIVY+YuV
         G5jkCjBGtaXS74YQUcLArUCvrUv1R0AYRY9hvIHEJf1ZBIufcfBidTAcwbxtI+dHRCsh
         DJJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtbeG9yeGtECzY3AZNmjFKmQD3HTuYBfrgQTToAXIQbaknQclJEZm0NMG9fxvqPGJg41quwck5f574pDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4DG+wFoNggADl2eAITJXBEhbNFoEnZEZZRsoODDIL/fnKvWZr
	yaAkfwD6QHaxiRTPsCVyFLHKT7zGgidFjYddjMJERhwhrGht0sH1WihPIAcjP6o=
X-Gm-Gg: ASbGncskjsrnIBicZwNJMEPRN/bM83L1W+idmJqLOLNbZ9Yurf57xfhqyfY4isaxFVz
	4ELw0KHiWvtkK+GnKFhBWMTRon0z2V8fzM3wFXeUUf3LALyZPxrTBwhwdmaEAHGVMmCC3SoRmJv
	dgEr0mvl/wpgqsoSDphFpw6Vgs4Kf/1Vfb5FjNQKYfpdU0bRIhOZrara5l3CXQVXoj8o8aD8bD/
	YrWg0nbxLvdHOgsXz8yOGAIyP0dlENkMBQo8MMyo6UfU8JMKCyEo4FN3UIFW9PHqh0vUWsrKdnJ
	4xjfyazc9gIIOLoy6/XOJIT/WjYkkgiJzw==
X-Google-Smtp-Source: AGHT+IFFvq/bDvJFQWj/RJV8NnDDnUx6uh/s42rQWFV832Y0J28JnsbjtLh7Yu04SEXsTDrb8MHlXw==
X-Received: by 2002:ac2:5bc8:0:b0:540:2a6e:372b with SMTP id 2adb3069b0e04-5402a6e37edmr56673e87.9.1733865053468;
        Tue, 10 Dec 2024 13:10:53 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5401c7e8333sm879893e87.40.2024.12.10.13.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 13:10:52 -0800 (PST)
Date: Tue, 10 Dec 2024 23:10:50 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, quic_abhinavk@quicinc.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, robdclark@gmail.com
Subject: Re: [PATCH v2 2/2] drm/tests: Add test for
 drm_atomic_helper_commit_modeset_disables()
Message-ID: <bgtv3oql63btxeqliauvnjtow4ca2m22qana5v3qudaspvejme@ts6jwuggg63x>
References: <20241209-abhinavk-modeset-fix-v2-0-4d008f6ea8d0@quicinc.com>
 <20241209-abhinavk-modeset-fix-v2-2-4d008f6ea8d0@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209-abhinavk-modeset-fix-v2-2-4d008f6ea8d0@quicinc.com>

On Mon, Dec 09, 2024 at 05:09:25PM -0800, Jessica Zhang wrote:
> Add a subtest to check that modeset is called when the connector is
> changed
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/tests/Makefile                |   1 +
>  drivers/gpu/drm/tests/drm_atomic_state_test.c | 242 ++++++++++++++++++++++++++
>  2 files changed, 243 insertions(+)
> 
> diff --git a/drivers/gpu/drm/tests/Makefile b/drivers/gpu/drm/tests/Makefile
> index 56dab563abd7a7ee7c147bd6b4927e2436b82e1d..0109bcf7faa54993cce337f522eae78f0fa6ffcb 100644
> --- a/drivers/gpu/drm/tests/Makefile
> +++ b/drivers/gpu/drm/tests/Makefile
> @@ -4,6 +4,7 @@ obj-$(CONFIG_DRM_KUNIT_TEST_HELPERS) += \
>  	drm_kunit_helpers.o
>  
>  obj-$(CONFIG_DRM_KUNIT_TEST) += \
> +	drm_atomic_state_test.o \
>  	drm_buddy_test.o \
>  	drm_cmdline_parser_test.o \
>  	drm_connector_test.o \
> diff --git a/drivers/gpu/drm/tests/drm_atomic_state_test.c b/drivers/gpu/drm/tests/drm_atomic_state_test.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..ffc1198ccc9ce103b9bc4c5ca8c83ca7f6ab19cc
> --- /dev/null
> +++ b/drivers/gpu/drm/tests/drm_atomic_state_test.c
> @@ -0,0 +1,242 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Test cases for the drm_atomic_state helpers
> + *
> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <drm/drm_atomic.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_atomic_uapi.h>
> +#include <drm/drm_kunit_helpers.h>
> +#include <drm/drm_probe_helper.h>
> +
> +#define DRM_TEST_ENC_0 BIT(0)
> +#define DRM_TEST_ENC_1 BIT(1)
> +#define DRM_TEST_ENC_2 BIT(2)
> +
> +#define DRM_TEST_CONN_0 BIT(0)
> +
> +static const struct drm_display_mode drm_atomic_test_mode = {
> +	DRM_MODE("1024x768", 0, 65000, 1024, 1048,
> +		 1184, 1344, 0, 768, 771, 777, 806, 0,
> +		 DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC)
> +};
> +
> +struct drm_atomic_check_priv {
> +	struct drm_device drm;
> +	struct drm_plane *plane;
> +	struct drm_crtc *crtc;
> +	struct drm_encoder encoders[3];
> +	struct drm_connector connectors[2];
> +};
> +
> +static int modeset_counter;
> +
> +static void drm_test_encoder_mode_set(struct drm_encoder *encoder,
> +				      struct drm_crtc_state *crtc_state,
> +				      struct drm_connector_state *conn_state)
> +{
> +	modeset_counter++;
> +}
> +
> +static const struct drm_encoder_helper_funcs drm_test_encoder_funcs = {

Name is too generic, please use something more test-suite specific.

> +	.atomic_mode_set	= drm_test_encoder_mode_set,
> +};
> +
> +static const struct drm_connector_funcs dummy_connector_funcs = {
> +	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
> +	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
> +	.reset			= drm_atomic_helper_connector_reset,
> +};
> +
> +static int drm_atomic_test_dummy_get_modes(struct drm_connector *connector)
> +{
> +	drm_connector_helper_get_modes_fixed(connector, &drm_atomic_test_mode);
> +	return 1;

return drm_connector_helper_get_modes_fixed()

> +}
> +
> +static const struct drm_connector_helper_funcs dummy_connector_helper_funcs = {
> +	.get_modes	= drm_atomic_test_dummy_get_modes,
> +};
> +
> +static struct drm_atomic_check_priv *
> +drm_test_init_drm_components(struct kunit *test, bool has_connectors)

I think this is too generic, please use a file-specific name.

> +{
> +	struct drm_atomic_check_priv *priv;
> +	struct drm_encoder *enc;
> +	struct drm_device *drm;
> +	struct device *dev;
> +	int ret;
> +
> +	dev = drm_kunit_helper_alloc_device(test);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
> +
> +	priv = drm_kunit_helper_alloc_drm_device(test, dev,
> +						 struct drm_atomic_check_priv,
> +						 drm,
> +						 DRIVER_MODESET | DRIVER_ATOMIC);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
> +	test->priv = priv;
> +
> +	drm = &priv->drm;
> +	priv->plane = drm_kunit_helper_create_primary_plane(test, drm,
> +							    NULL,
> +							    NULL,
> +							    NULL, 0,
> +							    NULL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->plane);
> +
> +	priv->crtc = drm_kunit_helper_create_crtc(test, drm,
> +						  priv->plane, NULL,
> +						  NULL,
> +						  NULL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->crtc);
> +
> +	for (int i = 0; i < ARRAY_SIZE(priv->encoders); i++) {
> +		enc = &priv->encoders[i];
> +
> +		ret = drmm_encoder_init(drm, enc, NULL,
> +					DRM_MODE_ENCODER_DSI, NULL);
> +		KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +		enc->possible_crtcs = drm_crtc_mask(priv->crtc);
> +	}
> +
> +	priv->encoders[0].possible_clones = DRM_TEST_ENC_0 | DRM_TEST_ENC_1;
> +	priv->encoders[1].possible_clones = DRM_TEST_ENC_0 | DRM_TEST_ENC_1;
> +	priv->encoders[2].possible_clones = DRM_TEST_ENC_2;
> +
> +	if (!has_connectors)
> +		goto done;
> +
> +	struct drm_connector *conn;

Please move next ot other variable definitions.

> +
> +	KUNIT_ASSERT_LE(test, ARRAY_SIZE(priv->connectors),
> +			ARRAY_SIZE(priv->encoders));

I'd say it's BUILD_BUG_ON

> +
> +
> +	for (int i = 0; i < ARRAY_SIZE(priv->connectors); i++) {
> +		conn = &priv->connectors[i];
> +
> +		ret = drmm_connector_init(drm, conn, &dummy_connector_funcs,
> +					  DRM_MODE_CONNECTOR_DSI, NULL);
> +		KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +		drm_connector_helper_add(conn, &dummy_connector_helper_funcs);
> +		drm_encoder_helper_add(&priv->encoders[i], &drm_test_encoder_funcs);
> +
> +		drm_connector_attach_encoder(conn, &priv->encoders[i]);
> +	}
> +
> +done:
> +	drm_mode_config_reset(drm);
> +
> +	return priv;
> +}
> +
> +static int set_up_atomic_state(struct kunit *test,
> +			       struct drm_atomic_check_priv *priv,
> +			       struct drm_connector *connector,
> +			       struct drm_modeset_acquire_ctx *ctx)
> +{
> +	struct drm_device *drm = &priv->drm;
> +	struct drm_crtc *crtc = priv->crtc;
> +	struct drm_atomic_state *state;
> +	struct drm_connector_state *conn_state;
> +	struct drm_crtc_state *crtc_state;
> +	int ret;
> +
> +	state = drm_kunit_helper_atomic_state_alloc(test, drm, ctx);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
> +
> +	if (connector) {
> +		conn_state = drm_atomic_get_connector_state(state, connector);
> +		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
> +
> +		ret = drm_atomic_set_crtc_for_connector(conn_state, crtc);
> +		KUNIT_EXPECT_EQ(test, ret, 0);
> +	}
> +
> +	crtc_state = drm_atomic_get_crtc_state(state, crtc);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
> +
> +	ret = drm_atomic_set_mode_for_crtc(crtc_state, &drm_atomic_test_mode);
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +
> +	crtc_state->enable = true;
> +	crtc_state->active = true;
> +
> +	if (connector) {
> +		ret = drm_atomic_commit(state);
> +		KUNIT_ASSERT_EQ(test, ret, 0);
> +	} else {
> +		// dummy connector mask
> +		crtc_state->connector_mask = DRM_TEST_CONN_0;
> +	}
> +
> +	return 0;
> +}
> +

Please provide a description of what the test does and what it checks
(and why). See how other tests are described.

> +static void drm_test_modeset(struct kunit *test)
> +{
> +	struct drm_atomic_check_priv *priv;
> +	struct drm_modeset_acquire_ctx *ctx;
> +	struct drm_connector *old_conn, *new_conn;
> +	struct drm_atomic_state *state;
> +	struct drm_device *drm;
> +	struct drm_connector_state *new_conn_state, *old_conn_state;
> +	int ret, initial_modeset_count;
> +
> +	priv = drm_test_init_drm_components(test, true);
> +	KUNIT_ASSERT_NOT_NULL(test, priv);
> +
> +	drm = &priv->drm;
> +	old_conn = &priv->connectors[0];
> +	new_conn = &priv->connectors[1];
> +
> +	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
> +
> +	// first modeset to enable
> +	ret = set_up_atomic_state(test, priv, old_conn, ctx);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	state = drm_kunit_helper_atomic_state_alloc(test, drm, ctx);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
> +
> +	new_conn_state = drm_atomic_get_connector_state(state, new_conn);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, new_conn_state);
> +
> +	old_conn_state = drm_atomic_get_connector_state(state, old_conn);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, old_conn_state);
> +
> +	ret = drm_atomic_set_crtc_for_connector(old_conn_state, NULL);
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +
> +	ret = drm_atomic_set_crtc_for_connector(new_conn_state, priv->crtc);
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +
> +	initial_modeset_count = modeset_counter;
> +
> +	// modeset_disables is called as part of the atomic commit tail
> +	ret = drm_atomic_commit(state);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +	KUNIT_ASSERT_EQ(test, modeset_counter, initial_modeset_count + 1);
> +}
> +
> +static struct kunit_case drm_test_check_modeset_test[] = {
> +	KUNIT_CASE(drm_test_modeset),
> +	{}
> +};
> +
> +static struct kunit_suite drm_test_check_modeset_test_suite = {
> +	.name = "drm_validate_modeset",
> +	.test_cases = drm_test_check_modeset_test,
> +};
> +
> +kunit_test_suite(drm_test_check_modeset_test_suite);
> +
> +MODULE_AUTHOR("Jessica Zhang <quic_jesszhan@quicinc.com");
> +MODULE_DESCRIPTION("Test cases for the drm_atomic_helper functions");
> +MODULE_LICENSE("GPL");
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

