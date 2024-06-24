Return-Path: <linux-kernel+bounces-228039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C700E9159E9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 00:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA6061C221AA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864591A01BD;
	Mon, 24 Jun 2024 22:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uaOFpn2P"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F298845C1C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 22:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719268310; cv=none; b=nw4mWWcoP/Kc5YwppEJV4EmlJ63To/eXWEHmhN/jJ+NrgGtH+iREE/ZYv1i0mVyoLk/9NKVJMLokbYld8RhZ9vJyrX2/mfmBaRpY2TxUgSbvEG1pqZE/CorlmEPqQsDIBlkfW4UnQdtKoDONX6e2klVbFFwSTZ1I4X+v2LXb6xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719268310; c=relaxed/simple;
	bh=/wYeukcGYOYua/ccS0QL/OjPELVgVI7MwJbjQh5Xmw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cHwmk07JpYs015qfj5erJ+X9n2en+984rSc4uGEx4gpis/nZKwtcKBcM9d4DCk5zgq/iAjFSLsNJ8gK780MSpDzCeMAtkaqgr7o6OSbkE5B2YCKvUvy4Dcd2SKvAzYCM1hWGzF9wwS6Wg+CQOw4aOHGZhILaiHk32dCU5bjYX/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uaOFpn2P; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-63174692a02so45243807b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719268308; x=1719873108; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qIO6L8ZwDHVir4TCZfhgf68ODGhPU8MUrulhinehcl0=;
        b=uaOFpn2PLpAZ5ghAHEzNPjK8Ao+NzUx3C/c9m6MaMjPxXEL+ChQa6EjSlU6JhX1Ico
         4wXICwOcMRzJt6CCrId+t099ve2DjY9AKVDiQS8jKL5sWQqQCzwNS5GzIaWQbm38l2nq
         l3kfnRvn7gbeRNfd7zkN4pe/uXlT7of46pPexPtKjoeojLpSpZvDzhbtfK1lCHKyxRjc
         nVKE9RyxlNkoKBjzwFw+5WDLhvgdS2b2Ej96Fuy6Wk7ZlvV2WDqAf1iue3uiQZI04Kp9
         yCkZ1xsIKBMBcYkQStBnGM/LxgQZHpX4gvc0J0lLUjgX76zAVhKsvLKZTHATSGoGvqiJ
         cJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719268308; x=1719873108;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qIO6L8ZwDHVir4TCZfhgf68ODGhPU8MUrulhinehcl0=;
        b=vU4JvtU8Dwc8NtacY7sYCeUQn8IbrFBNZKOt+q2D1tJIwxIL4HLEZS71rgwJCmKYqP
         OGPoVkI1J8nSbEjXKGG9QcmlsoCNPKLdYDIyF51TUOEi8KK3UXB88J37oBuQcS9KgqN7
         QvMz0uYXEW0lpMc/tDPqMlnaF76UxRzrhtG5yKHe8mm8rshc8HG8vfj+xnoZlC9Q9Am9
         jBcceqWJ+FbIcTrsmJAWYUX7qTm/83vL3qXjUXAAWf4Pm7qDGI78gBY7pFF1AR6rbdWm
         WYkD3wAAg1iCQqmQy+ZS2NPi6+MQTtrQ1see9j+DTkJG9rEAOZg47MASwHNiJ/g0BsvH
         YESw==
X-Forwarded-Encrypted: i=1; AJvYcCUqZItKGRB1UhitdR74UHCaqXJCswFJ43yoOSmYWZRHu5Jq+wdfplFVpC2IMO9Z8Rumnyk5CIcLWVBpYBl6rjy31A2f8bTV6Q4t5h0f
X-Gm-Message-State: AOJu0YwkKMYPMKfrO8WqMCDMx2lzY1GBifjK4SiJwPSD5NQB1Q04vesf
	A/1jbEXc4aghxepIJJlP63Xgq9cno4eLnKUJA56UWKAaUNBT37iNoXtOMZ92YM+HlkR8IjyZoz9
	3P9qdYsZbed5u9BRCzIwpQAlHMj9XDY4sdgb0FQ==
X-Google-Smtp-Source: AGHT+IHxeTzr4PcR5ms4PmjBj1L6UTmm+uRxD7cBU4erUoCBxFr06g42k6Ip0LggYP5LsFyQTU9FM1W8fWsJyQZNlSc=
X-Received: by 2002:a05:690c:6c0d:b0:643:9a13:fae2 with SMTP id
 00721157ae682-6439a13fd13mr77354467b3.28.1719268307956; Mon, 24 Jun 2024
 15:31:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240623-drm-bridge-connector-fix-hdmi-reset-v2-0-8590d44912ce@linaro.org>
 <20240623-drm-bridge-connector-fix-hdmi-reset-v2-1-8590d44912ce@linaro.org> <45c25e4b-d64d-549f-6711-7b753d24e2f9@quicinc.com>
In-Reply-To: <45c25e4b-d64d-549f-6711-7b753d24e2f9@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 25 Jun 2024 01:31:36 +0300
Message-ID: <CAA8EJpr+fB4P=X_ufkggizqk5AW5P+HKsQO5FvjqXxg6x+m5vA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/bridge-connector: reset the HDMI connector state
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, Rob Clark <robdclark@gmail.com>, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Jun 2024 at 01:28, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 6/22/2024 10:40 PM, Dmitry Baryshkov wrote:
> > On HDMI connectors which use drm_bridge_connector and DRM_BRIDGE_OP_HDMI
> > IGT chokes on the max_bpc property in several kms_properties tests due
> > to the the drm_bridge_connector failing to reset HDMI-related
> > properties.
> >
> > Call __drm_atomic_helper_connector_hdmi_reset() if there is a
> > the drm_bridge_connector has bridge_hdmi.
> >
> > Note, the __drm_atomic_helper_connector_hdmi_reset() is moved to
> > drm_atomic_state_helper.c because drm_bridge_connector.c can not depend
> > on DRM_DISPLAY_HDMI_STATE_HELPER. At the same time it is impossible to
> > call this function from HDMI bridges, there is is no function that
> > corresponds to the drm_connector_funcs::reset().
> >
> > Fixes: 6b4468b0c6ba ("drm/bridge-connector: implement glue code for HDMI connector")
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >   drivers/gpu/drm/display/drm_hdmi_state_helper.c | 21 ---------------------
> >   drivers/gpu/drm/drm_atomic_state_helper.c       | 21 +++++++++++++++++++++
> >   drivers/gpu/drm/drm_bridge_connector.c          | 13 ++++++++++++-
> >   include/drm/display/drm_hdmi_state_helper.h     |  3 ---
> >   include/drm/drm_atomic_state_helper.h           |  2 ++
> >   5 files changed, 35 insertions(+), 25 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> > index 2dab3ad8ce64..67f39857b0b4 100644
> > --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> > +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> > @@ -8,27 +8,6 @@
> >   #include <drm/display/drm_hdmi_helper.h>
> >   #include <drm/display/drm_hdmi_state_helper.h>
> >
> > -/**
> > - * __drm_atomic_helper_connector_hdmi_reset() - Initializes all HDMI @drm_connector_state resources
> > - * @connector: DRM connector
> > - * @new_conn_state: connector state to reset
> > - *
> > - * Initializes all HDMI resources from a @drm_connector_state without
> > - * actually allocating it. This is useful for HDMI drivers, in
> > - * combination with __drm_atomic_helper_connector_reset() or
> > - * drm_atomic_helper_connector_reset().
> > - */
> > -void __drm_atomic_helper_connector_hdmi_reset(struct drm_connector *connector,
> > -                                           struct drm_connector_state *new_conn_state)
> > -{
> > -     unsigned int max_bpc = connector->max_bpc;
> > -
> > -     new_conn_state->max_bpc = max_bpc;
> > -     new_conn_state->max_requested_bpc = max_bpc;
> > -     new_conn_state->hdmi.broadcast_rgb = DRM_HDMI_BROADCAST_RGB_AUTO;
> > -}
> > -EXPORT_SYMBOL(__drm_atomic_helper_connector_hdmi_reset);
> > -
> >   static const struct drm_display_mode *
> >   connector_state_get_mode(const struct drm_connector_state *conn_state)
> >   {
> > diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
> > index 519228eb1095..1518ada81b45 100644
> > --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> > +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> > @@ -478,6 +478,27 @@ void drm_atomic_helper_connector_reset(struct drm_connector *connector)
> >   }
> >   EXPORT_SYMBOL(drm_atomic_helper_connector_reset);
> >
> > +/**
> > + * __drm_atomic_helper_connector_hdmi_reset() - Initializes all HDMI @drm_connector_state resources
> > + * @connector: DRM connector
> > + * @new_conn_state: connector state to reset
> > + *
> > + * Initializes all HDMI resources from a @drm_connector_state without
> > + * actually allocating it. This is useful for HDMI drivers, in
> > + * combination with __drm_atomic_helper_connector_reset() or
> > + * drm_atomic_helper_connector_reset().
> > + */
> > +void __drm_atomic_helper_connector_hdmi_reset(struct drm_connector *connector,
> > +                                           struct drm_connector_state *new_conn_state)
> > +{
> > +     unsigned int max_bpc = connector->max_bpc;
> > +
> > +     new_conn_state->max_bpc = max_bpc;
> > +     new_conn_state->max_requested_bpc = max_bpc;
>
> I understand this is just code propagation but do we need a max_bpc
> local variable?
>
> We can just do
>
> new_conn_state->max_bpc = connector->max_bpc;
> new_conn_state->max_requested_bpc = connector->max_bpc;

Possible implementation, but I was really just doing code move.

>
> But apart from that nit, this LGTM.
>
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>



-- 
With best wishes
Dmitry

