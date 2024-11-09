Return-Path: <linux-kernel+bounces-402722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E86D49C2AF7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 08:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D15A7B21794
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 07:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2D813D886;
	Sat,  9 Nov 2024 07:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wrUGHDd7"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22C73B192
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 07:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731136413; cv=none; b=GUJ18bscQ1bgolMgX1uocwallIS2hbA64EeoYb2L+LQl1hu8vBN1bGTIOSGkROkVKdHGR3X2Y84Ibgl5O67K6CXo4gA1fbsWSdNertSvtD+xGVD/2AKKz/1/1ehR9V1eZggzIRI/zWyDQPDixhSUzmrCOGJqBddEhWLDs4nFIL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731136413; c=relaxed/simple;
	bh=fw0t7F43BCDmKFgkQLLpKFHdfhjFZH2PaDqUrdOyHv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJzsyYQXh9NkIR01nHNJ8RRSGCMCcRHrjCB4S27SgrQglktTlIZySCjdrt/gr07ESfG4ddx9I9OeW/xaMyqoANPKrD7KyG0VOLa6c08ZQxbiVHWapgCppZMzPTMZ/ydJK7b9xA99kS9zCLIsSR4Z5YQdX6wPmPUWbdJmszU9B0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wrUGHDd7; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539f72c8fc1so4941107e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 23:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731136410; x=1731741210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zNUHUNW3N94KhZGI0JJqHmpslwXn3uHqqi//pMXWTvY=;
        b=wrUGHDd73swQfv0AJNPIBuB6PLt6Jf5n2NicnCM8nOuw43tGwJqRf1e7VadkHFqsCg
         /oGGlFiQvKNC9+KCJLtm5zr642E7Fhrhkvo0Ok5WwnlO+kz7wXZV2niAz4hQL/hXssuP
         aq2AohJEz1mtfxjwHN7ATeXbnMsMEtouB9nBzhrj5oaokKqCaqQZl968PIM97Tmi8ihB
         LdYrC/tHMZreJggM9zOVLZ3gixXZphWpbluYPF9llHE+qwriWy4h236DblznejtOVbvy
         a3hOFzGoD+Mwn+0u5s8UAYn1Kk0i0h8ojbf4GMhq6P/wu0XNf4oJainCFOoRktPbB1Uo
         wRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731136410; x=1731741210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNUHUNW3N94KhZGI0JJqHmpslwXn3uHqqi//pMXWTvY=;
        b=ddnjZZM2qS7hzfSp3xVYtfpBnOL/Xm4DQjnufBaTMeHjl+G62CmqsNd0KGtE6yeBnS
         ECetie0NpsQmplCcOxKua4zavXFbSrawCZ+KqyTzOLZHTwHj6t42h0d0KWH3zKZuNFlZ
         /fOlCBwvEPAlLpcwu+425KdOW6PKenamvrKjBk7GQ3JlL7yrC4ujFjGggDK1TPowcymF
         G+rgeKVSymaEQTW0rYXNHrYKOb3OnEn7vkNo7t2iKcjsn1C8J911KkjG9DyIJyhYyKJx
         P7CNAPUISLiOkYKsZVnfNbDy7Cx+k7rFOQxs7IC7Y2r3OJkEI0chb5t8QWEK0lJiKIcs
         A1Ig==
X-Forwarded-Encrypted: i=1; AJvYcCXmTFupH6lPjdCpHIxijEOMaPBWmWvBppI7dRqR3bYWKrDOIVEqTTqb9Y78x56qnQrCLVDpvFO3Xc4sfxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUDFJNWdJ7sY4m5U5pmPU3UIymnfKa9rblL9WwZ0OASMMtytIG
	Oc74v23E2HHBp1hFcKCZ+MMF5RORGxG3HsR0YcT/QSd4GvanBJ1EHE6/qD9Trxg=
X-Google-Smtp-Source: AGHT+IELVyqCmpJuWdmxqNJGcDVWXJacjDsFRR3SZdVXZ+ml1eAxfT8jopEjNHnnwf1zbuasIuxsXg==
X-Received: by 2002:a05:6512:401d:b0:539:f922:bd4e with SMTP id 2adb3069b0e04-53d86231852mr2709861e87.23.1731136409613;
        Fri, 08 Nov 2024 23:13:29 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d8267847fsm861315e87.2.2024.11.08.23.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 23:13:29 -0800 (PST)
Date: Sat, 9 Nov 2024 09:13:26 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 1/6] drm/display: hdmi: add generic mode_valid helper
Message-ID: <vilmhcvixztpseh2uo5sdc7zzhfmexctfnd4aeahy2pui76ntr@kbswbxi347zg>
References: <20241101-hdmi-mode-valid-v2-0-a6478fd20fa6@linaro.org>
 <20241101-hdmi-mode-valid-v2-1-a6478fd20fa6@linaro.org>
 <20241108-certain-kickass-goshawk-a3c596@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108-certain-kickass-goshawk-a3c596@houat>

On Fri, Nov 08, 2024 at 03:17:22PM +0100, Maxime Ripard wrote:
> Hi,
> 
> On Fri, Nov 01, 2024 at 02:25:04AM +0200, Dmitry Baryshkov wrote:
> > Add drm_hdmi_connector_mode_valid(), generic helper for HDMI connectors.
> > It can be either used directly or as a part of the .mode_valid callback.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  drivers/gpu/drm/display/drm_hdmi_helper.c          |  45 ++++++
> >  drivers/gpu/drm/display/drm_hdmi_helper_internal.h |  11 ++
> >  drivers/gpu/drm/display/drm_hdmi_state_helper.c    |  26 +---
> >  drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 168 ++++++++++++++++++++-
> >  include/drm/display/drm_hdmi_helper.h              |   4 +
> >  5 files changed, 229 insertions(+), 25 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/display/drm_hdmi_helper.c b/drivers/gpu/drm/display/drm_hdmi_helper.c
> > index 74dd4d01dd9bb2c9e69ec1c60b0056bd69417e8a..560c5d4365ca54d3f669395349cedfd6f75fa033 100644
> > --- a/drivers/gpu/drm/display/drm_hdmi_helper.c
> > +++ b/drivers/gpu/drm/display/drm_hdmi_helper.c
> > @@ -9,6 +9,8 @@
> >  #include <drm/drm_print.h>
> >  #include <drm/drm_property.h>
> >  
> > +#include "drm_hdmi_helper_internal.h"
> > +
> >  static inline bool is_eotf_supported(u8 output_eotf, u8 sink_eotf)
> >  {
> >  	return sink_eotf & BIT(output_eotf);
> > @@ -256,3 +258,46 @@ drm_hdmi_compute_mode_clock(const struct drm_display_mode *mode,
> >  	return DIV_ROUND_CLOSEST_ULL(clock * bpc, 8);
> >  }
> >  EXPORT_SYMBOL(drm_hdmi_compute_mode_clock);
> > +
> > +enum drm_mode_status
> > +__drm_hdmi_connector_clock_valid(const struct drm_connector *connector,
> > +				 const struct drm_display_mode *mode,
> > +				 unsigned long long clock)
> > +{
> > +	const struct drm_connector_hdmi_funcs *funcs = connector->hdmi.funcs;
> > +	const struct drm_display_info *info = &connector->display_info;
> > +
> > +	if (info->max_tmds_clock && clock > info->max_tmds_clock * 1000)
> > +		return MODE_CLOCK_HIGH;
> > +
> > +	if (funcs && funcs->tmds_char_rate_valid) {
> > +		enum drm_mode_status status;
> > +
> > +		status = funcs->tmds_char_rate_valid(connector, mode, clock);
> > +		if (status != MODE_OK)
> > +			return status;
> > +	}
> > +
> > +	return MODE_OK;
> > +}
> > +
> > +/**
> > + * drm_hdmi_connector_mode_valid() - Check if mode is valid for HDMI connector
> > + * @connector: DRM connector to validate the mode
> > + * @mode: Display mode to validate
> > + *
> > + * Generic .mode_valid implementation for HDMI connectors.
> > + */
> > +enum drm_mode_status
> > +drm_hdmi_connector_mode_valid(struct drm_connector *connector,
> > +			      struct drm_display_mode *mode)
> > +{
> > +	unsigned long long clock;
> > +
> > +	clock = drm_hdmi_compute_mode_clock(mode, 8, HDMI_COLORSPACE_RGB);
> > +	if (!clock)
> > +		return MODE_ERROR;
> > +
> > +	return __drm_hdmi_connector_clock_valid(connector, mode, clock);
> > +}
> > +EXPORT_SYMBOL(drm_hdmi_connector_mode_valid);
> 
> It's not clear to me why you want to place it in drm_hdmi_helper? It's
> relying quite heavily on the HDMI infrastructure, so it would make more
> sense to me that it would be part of drm_hdmi_state_helper.c.

Yeah, I hesitated a bit. I selected drm_hdmi_helper.c because it doesn't
use state-related functions. As such it is usable even by the drivers
which imlement just the basic HDMI Connector functions and don't use the
reset of the framework.

ANyway, I'll move it to drm_hdmi_state_helper.c.

> 
> > diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
> > index 34ee95d41f2966ab23a60deb37d689430f6b0985..8640e7280053bd95852f53b92159f493b141f2bf 100644
> > --- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
> > +++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
> > @@ -43,10 +43,12 @@ struct drm_atomic_helper_connector_hdmi_priv {
> >  static struct drm_display_mode *find_preferred_mode(struct drm_connector *connector)
> >  {
> >  	struct drm_device *drm = connector->dev;
> > -	struct drm_display_mode *mode, *preferred;
> > +	struct drm_display_mode *mode, *preferred = NULL;
> >  
> >  	mutex_lock(&drm->mode_config.mutex);
> > -	preferred = list_first_entry(&connector->modes, struct drm_display_mode, head);
> > +	if (!list_empty(&connector->modes))
> > +		preferred = list_first_entry(&connector->modes, struct drm_display_mode, head);
> > +
> 
> What is this fixing?

If connector->modes is empty (e.g. because of the tmds_char_rate_valid()
rejecting all of them) then just list_first_entry() will result in an
invalid mode being assigned to preferred.

> 
> >  	list_for_each_entry(mode, &connector->modes, head)
> >  		if (mode->type & DRM_MODE_TYPE_PREFERRED)
> >  			preferred = mode;
> > @@ -125,6 +127,18 @@ static const struct drm_connector_hdmi_funcs reject_connector_hdmi_funcs = {
> >  	.tmds_char_rate_valid	= reject_connector_tmds_char_rate_valid,
> >  };
> >  
> > +static enum drm_mode_status
> > +reject_100MHz_connector_tmds_char_rate_valid(const struct drm_connector *connector,
> > +					     const struct drm_display_mode *mode,
> > +					     unsigned long long tmds_rate)
> > +{
> > +	return (tmds_rate > 100ULL * 1000 * 1000) ? MODE_BAD : MODE_OK;
> > +}
> > +
> > +static const struct drm_connector_hdmi_funcs reject_100_MHz_connector_hdmi_funcs = {
> > +	.tmds_char_rate_valid	= reject_100MHz_connector_tmds_char_rate_valid,
> > +};
> > +
> >  static int dummy_connector_get_modes(struct drm_connector *connector)
> >  {
> >  	struct drm_atomic_helper_connector_hdmi_priv *priv =
> > @@ -147,6 +161,33 @@ static int dummy_connector_get_modes(struct drm_connector *connector)
> >  static const struct drm_connector_helper_funcs dummy_connector_helper_funcs = {
> >  	.atomic_check	= drm_atomic_helper_connector_hdmi_check,
> >  	.get_modes	= dummy_connector_get_modes,
> > +	.mode_valid		= drm_hdmi_connector_mode_valid,
> > +};
> > +
> > +static int dummy_connector_get_modes_100MHz_max_clock(struct drm_connector *connector)
> > +{
> > +	struct drm_atomic_helper_connector_hdmi_priv *priv =
> > +		connector_to_priv(connector);
> > +	const struct drm_edid *edid;
> > +	unsigned int num_modes;
> > +
> > +	edid = drm_edid_alloc(priv->current_edid, priv->current_edid_len);
> > +	if (!edid)
> > +		return -EINVAL;
> > +
> > +	drm_edid_connector_update(connector, edid);
> > +	connector->display_info.max_tmds_clock = 100 * 1000;
> > +	num_modes = drm_edid_connector_add_modes(connector);
> > +
> > +	drm_edid_free(edid);
> > +
> > +	return num_modes;
> > +}
> > +
> > +static const struct drm_connector_helper_funcs dummy_connector_helper_funcs_max_tmds_clock = {
> > +	.atomic_check	= drm_atomic_helper_connector_hdmi_check,
> > +	.get_modes	= dummy_connector_get_modes_100MHz_max_clock,
> > +	.mode_valid		= drm_hdmi_connector_mode_valid,
> >  };
> >  
> >  static void dummy_hdmi_connector_reset(struct drm_connector *connector)
> > @@ -1734,9 +1775,132 @@ static struct kunit_suite drm_atomic_helper_connector_hdmi_reset_test_suite = {
> >  	.test_cases	= drm_atomic_helper_connector_hdmi_reset_tests,
> >  };
> >  
> > +static void drm_test_check_mode_valid(struct kunit *test)
> > +{
> > +	struct drm_atomic_helper_connector_hdmi_priv *priv;
> > +	struct drm_connector *conn;
> > +	struct drm_display_mode *preferred;
> > +
> > +	priv = drm_atomic_helper_connector_hdmi_init(test,
> > +						     BIT(HDMI_COLORSPACE_RGB),
> > +						     8);
> > +	KUNIT_ASSERT_NOT_NULL(test, priv);
> > +
> > +	conn = &priv->connector;
> > +	preferred = find_preferred_mode(conn);
> > +	KUNIT_ASSERT_NOT_NULL(test, preferred);
> > +
> > +	KUNIT_EXPECT_EQ(test, preferred->hdisplay, 1920);
> > +	KUNIT_EXPECT_EQ(test, preferred->vdisplay, 1080);
> > +	KUNIT_EXPECT_EQ(test, preferred->clock, 148500);
> > +}
> > +
> > +static void drm_test_check_mode_valid_reject(struct kunit *test)
> > +{
> > +	struct drm_atomic_helper_connector_hdmi_priv *priv;
> > +	struct drm_connector *conn;
> > +	struct drm_display_mode *preferred;
> > +	struct drm_device *drm;
> > +	int ret;
> > +
> > +	priv = drm_atomic_helper_connector_hdmi_init(test,
> > +						     BIT(HDMI_COLORSPACE_RGB),
> > +						     8);
> > +	KUNIT_ASSERT_NOT_NULL(test, priv);
> > +
> > +	conn = &priv->connector;
> > +
> > +	/* You shouldn't be doing that at home. */
> > +	conn->hdmi.funcs = &reject_connector_hdmi_funcs;
> > +
> > +	priv->current_edid = test_edid_hdmi_1080p_rgb_max_200mhz;
> > +	priv->current_edid_len = ARRAY_SIZE(test_edid_hdmi_1080p_rgb_max_200mhz);
> > +
> > +	drm = &priv->drm;
> > +
> > +	mutex_lock(&drm->mode_config.mutex);
> > +	ret = conn->funcs->fill_modes(conn, 4096, 4096);
> > +	mutex_unlock(&drm->mode_config.mutex);
> > +	KUNIT_ASSERT_EQ(test, ret, 0);
> > +
> > +	preferred = find_preferred_mode(conn);
> > +	KUNIT_ASSERT_NULL(test, preferred);
> > +}
> > +
> > +static void drm_test_check_mode_valid_reject_rate(struct kunit *test)
> > +{
> > +	struct drm_atomic_helper_connector_hdmi_priv *priv;
> > +	struct drm_connector *conn;
> > +	struct drm_display_mode *preferred;
> > +	int ret;
> > +
> > +	priv = drm_atomic_helper_connector_hdmi_init(test,
> > +						     BIT(HDMI_COLORSPACE_RGB),
> > +						     8);
> > +	KUNIT_ASSERT_NOT_NULL(test, priv);
> > +
> > +	conn = &priv->connector;
> > +
> > +	/* You shouldn't be doing that at home. */
> > +	conn->hdmi.funcs = &reject_100_MHz_connector_hdmi_funcs;
> > +
> > +	ret = set_connector_edid(test, conn,
> > +				 test_edid_hdmi_1080p_rgb_max_200mhz,
> > +				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_max_200mhz));
> > +	KUNIT_ASSERT_EQ(test, ret, 0);
> > +
> > +	preferred = find_preferred_mode(conn);
> > +	KUNIT_ASSERT_NOT_NULL(test, preferred);
> > +	KUNIT_EXPECT_EQ(test, preferred->hdisplay, 640);
> > +	KUNIT_EXPECT_EQ(test, preferred->vdisplay, 480);
> > +	KUNIT_EXPECT_EQ(test, preferred->clock, 25200);
> > +}
> > +
> > +static void drm_test_check_mode_valid_reject_max_clock(struct kunit *test)
> > +{
> > +	struct drm_atomic_helper_connector_hdmi_priv *priv;
> > +	struct drm_connector *conn;
> > +	struct drm_display_mode *preferred;
> > +	int ret;
> > +
> > +	priv = drm_atomic_helper_connector_hdmi_init(test,
> > +						     BIT(HDMI_COLORSPACE_RGB),
> > +						     8);
> > +	KUNIT_ASSERT_NOT_NULL(test, priv);
> > +
> > +	conn = &priv->connector;
> > +
> > +	drm_connector_helper_add(conn, &dummy_connector_helper_funcs_max_tmds_clock);
> > +
> > +	ret = set_connector_edid(test, conn,
> > +				 test_edid_hdmi_1080p_rgb_max_200mhz,
> > +				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_max_200mhz));
> > +	KUNIT_ASSERT_EQ(test, ret, 0);
> > +
> > +	preferred = find_preferred_mode(conn);
> > +	KUNIT_ASSERT_NOT_NULL(test, preferred);
> > +	KUNIT_EXPECT_EQ(test, preferred->hdisplay, 640);
> > +	KUNIT_EXPECT_EQ(test, preferred->vdisplay, 480);
> > +	KUNIT_EXPECT_EQ(test, preferred->clock, 25200);
> > +}
> > +
> > +static struct kunit_case drm_atomic_helper_connector_hdmi_mode_valid_tests[] = {
> > +	KUNIT_CASE(drm_test_check_mode_valid),
> > +	KUNIT_CASE(drm_test_check_mode_valid_reject),
> > +	KUNIT_CASE(drm_test_check_mode_valid_reject_rate),
> > +	KUNIT_CASE(drm_test_check_mode_valid_reject_max_clock),
> > +	{ }
> > +};
> > +
> > +static struct kunit_suite drm_atomic_helper_connector_hdmi_mode_valid_test_suite = {
> > +	.name		= "drm_atomic_helper_connector_hdmi_mode_valid",
> > +	.test_cases	= drm_atomic_helper_connector_hdmi_mode_valid_tests,
> > +};
> > +
> 
> We need some documentation for these tests too, and what you're trying
> to test exactly with that 100MHz cutout.

I'll add a comment. Basically, I'm checking that
drm_hdmi_connector_mode_valid() actually rejects modes based on the
tmds_char_rate_valid() or on the info->max_tmds_clock.

> 
> Maxime



-- 
With best wishes
Dmitry

