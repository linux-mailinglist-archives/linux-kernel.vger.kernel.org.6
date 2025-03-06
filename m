Return-Path: <linux-kernel+bounces-549233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA212A54F5B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD2953AC626
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0927720E6FD;
	Thu,  6 Mar 2025 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="lEes4RZE"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F74A148FF5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 15:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741275691; cv=none; b=oWHeKW6Nanyc5iFrGjtsOUzB3YrThxj1/HKk2bycOtLyvCe1uAj2enmhQq4lTEGrPSwH9CeidbhBGIzgVqEr6y9IAkArkStOIiBIya0ZmthGkcHI7WUyPgD/xZ0gbE72kehwRZ7604EnPZGHeDR9PCoyxVwMq7h/ZXew/vTz0DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741275691; c=relaxed/simple;
	bh=3DmVVu7DQIQKIIp4t8lsKAIOMSSQUzyJkbGFxd4z+EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZW2Vn9QeV2mj4+b2GWl9gA1r/n1RQcLpDoyb8D6+GBwJlj/xF7+xZ0JcS7Uk2rLBgwm38B8z8zHgd+f2QUo+Xgy7dh8agHeDqpUYttGAMMRoWB7ghlKZTV8MZuf04vpKqj18Igz9wke2SGFPK0aU8xvLL0w3JQL1bG4UzW7G8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=lEes4RZE; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39127512371so622294f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 07:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1741275687; x=1741880487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KfAw/lWzC06xKDDTRZDupFFimlwRpNal8Mn/TGIr/gI=;
        b=lEes4RZE74EDulSKVUFk507AMUr9xOG66RoMEI5k+u5QMVCsSyFBZPzWtN+SIKC4Lu
         uZ9nO7lH1FrLT+hbfiY+Det7XMXrmjukaCHjKB+QrNlvm7msyDdDQbw8w6Lvin3qj+Xh
         RENxxxhHfdiMhFiUvgIxJBwT1PKClqBXLuxJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741275687; x=1741880487;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KfAw/lWzC06xKDDTRZDupFFimlwRpNal8Mn/TGIr/gI=;
        b=fFg+Z3q7H+0Ln6lkMDuYc4ou52x0bRS4xx6Kf+9Eyva75O0Z8P8ls/LSrEki4aBxbA
         IFbC9OrCEYXjNU+AI/jiL/whUchNWYSS2vrDD6dRYc1UBX015Do3p8cKLjCT2B2Wwbls
         ETPIeo4evyeU6sZIITrVjBtqsoy1F4SrU9iNmEnwonLM8nSNKzMGah+3aDYUFADFDChk
         EdIzVRllzzpZjIypBq1ASrEyA4ufcraA54RQjgijhOzD6YYvpM05OiDX9gwf2yxJyTRT
         0NE0xHErus3MnP0gWmHgTzaA5qczhV7qP/sGMy2MaPS+Lx1hX+nA+O76WJORm4UEZOz8
         fnjA==
X-Forwarded-Encrypted: i=1; AJvYcCUBEKUKrGu8BiVHNb4FByEDIhKKJxAHJC/zAa+USjWQlm6IG/s+xMrERNj3QQXv6+YhpxrsCo5hoUluLr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNM/oEqZgmujuMF2N1LhYlVS/mycWULqlST/g+tSpelaSEivaf
	XtRRPyLDF9WF2t3A44jzfRW1O8XiF0vfDL0ZqS3/NtV08Bh+Nummd4dFWe+6lDg=
X-Gm-Gg: ASbGncvT4QEgZXZvUqDjaGKnK44TUAVo+4EjDQpLlTWT0EeInEpPsAOD1ZCqTS6LfC5
	i1kELqiv7IJqjtLUCuiWK+E0Y2ftDYSQaMVT4Ig90y77k6cufwdbgK0BZvuYx/8LoFO0UvVs8XX
	n52Yf1oYQFdmLN5f7LB3hiumMRaj/JSVqd+VXX0DuqvxlYkuV7fRN7fKyUy/qHh/wF5bXaxSRdZ
	7b4kYpRCOWVzRzpBYFxgxnbeHD/bEwsTpQi0pRZ2C7P/6l8UcbZ6DYsvksABtlnnicOZ6UvbHl4
	B0AkqvAAqbyzV9wR+iBVx2JDiegY/t2Vv0Hs5o7I3QnqMWRx6qIj6wol
X-Google-Smtp-Source: AGHT+IHILhgpH9qsFMyPlni2g1PV1h6rdNmhtz7SSlpztS/80IfakxCQlbtDJtFSlQ77i0LW0AVdJw==
X-Received: by 2002:a05:6000:2ca:b0:391:454:5eb8 with SMTP id ffacd0b85a97d-3911f7c83f0mr7652632f8f.48.1741275687342;
        Thu, 06 Mar 2025 07:41:27 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c015a29sm2342134f8f.42.2025.03.06.07.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 07:41:26 -0800 (PST)
Date: Thu, 6 Mar 2025 16:41:24 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Maxime Ripard <mripard@kernel.org>
Cc: Andy Yan <andyshrk@163.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Herve Codina <herve.codina@bootlin.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Simona Vetter <simona.vetter@ffwll.ch>
Subject: Re: [PATCH v5 04/16] drm/atomic: Introduce helper to lookup
 connector by encoder
Message-ID: <Z8nCJACBmcUNvQB8@phenom.ffwll.local>
Mail-Followup-To: Maxime Ripard <mripard@kernel.org>,
	Andy Yan <andyshrk@163.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Herve Codina <herve.codina@bootlin.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250304-bridge-connector-v5-0-aacf461d2157@kernel.org>
 <20250304-bridge-connector-v5-4-aacf461d2157@kernel.org>
 <5180089f.a640.19566290538.Coremail.andyshrk@163.com>
 <20250305-ruddy-nightingale-of-wealth-db100a@houat>
 <mqh4wedfokuta2tmyctoi6jrzol7mqzm27nj3ylu6yj2vjy22j@mexke5x2o7a2>
 <7c1c61e7.10e1.19569067029.Coremail.andyshrk@163.com>
 <20250306-able-wonderful-saluki-aacd1d@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306-able-wonderful-saluki-aacd1d@houat>
X-Operating-System: Linux phenom 6.12.11-amd64 

On Thu, Mar 06, 2025 at 08:10:16AM +0100, Maxime Ripard wrote:
> On Thu, Mar 06, 2025 at 09:16:24AM +0800, Andy Yan wrote:
> > 
> > Hi Maxime and Dmitry:
> > 
> > At 2025-03-06 04:13:53, "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org> wrote:
> > >On Wed, Mar 05, 2025 at 02:19:36PM +0100, Maxime Ripard wrote:
> > >> Hi Andy,
> > >> 
> > >> On Wed, Mar 05, 2025 at 07:55:19PM +0800, Andy Yan wrote:
> > >> > At 2025-03-04 19:10:47, "Maxime Ripard" <mripard@kernel.org> wrote:
> > >> > >With the bridges switching over to drm_bridge_connector, the direct
> > >> > >association between a bridge driver and its connector was lost.
> > >> > >
> > >> > >This is mitigated for atomic bridge drivers by the fact you can access
> > >> > >the encoder, and then call drm_atomic_get_old_connector_for_encoder() or
> > >> > >drm_atomic_get_new_connector_for_encoder() with drm_atomic_state.
> > >> > >
> > >> > >This was also made easier by providing drm_atomic_state directly to all
> > >> > >atomic hooks bridges can implement.
> > >> > >
> > >> > >However, bridge drivers don't have a way to access drm_atomic_state
> > >> > >outside of the modeset path, like from the hotplug interrupt path or any
> > >> > >interrupt handler.
> > >> > >
> > >> > >Let's introduce a function to retrieve the connector currently assigned
> > >> > >to an encoder, without using drm_atomic_state, to make these drivers'
> > >> > >life easier.
> > >> > >
> > >> > >Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > >> > >Co-developed-by: Simona Vetter <simona.vetter@ffwll.ch>
> > >> > >Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > >> > >---
> > >> > > drivers/gpu/drm/drm_atomic.c | 45 ++++++++++++++++++++++++++++++++++++++++++++
> > >> > > include/drm/drm_atomic.h     |  3 +++
> > >> > > 2 files changed, 48 insertions(+)
> > >> > >
> > >> > >diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> > >> > >index 9ea2611770f43ce7ccba410406d5f2c528aab022..b926b132590e78f8d41d48eb4da4bccf170ee236 100644
> > >> > >--- a/drivers/gpu/drm/drm_atomic.c
> > >> > >+++ b/drivers/gpu/drm/drm_atomic.c
> > >> > >@@ -985,10 +985,55 @@ drm_atomic_get_new_connector_for_encoder(const struct drm_atomic_state *state,
> > >> > > 
> > >> > > 	return NULL;
> > >> > > }
> > >> > > EXPORT_SYMBOL(drm_atomic_get_new_connector_for_encoder);
> > >> > > 
> > >> > >+/**
> > >> > >+ * drm_atomic_get_connector_for_encoder - Get connector currently assigned to an encoder
> > >> > >+ * @encoder: The encoder to find the connector of
> > >> > >+ * @ctx: Modeset locking context
> > >> > >+ *
> > >> > >+ * This function finds and returns the connector currently assigned to
> > >> > >+ * an @encoder.
> > >> > >+ *
> > >> > >+ * Returns:
> > >> > >+ * The connector connected to @encoder, or an error pointer otherwise.
> > >> > >+ * When the error is EDEADLK, a deadlock has been detected and the
> > >> > >+ * sequence must be restarted.
> > >> > >+ */
> > >> > >+struct drm_connector *
> > >> > >+drm_atomic_get_connector_for_encoder(const struct drm_encoder *encoder,
> > >> > >+				     struct drm_modeset_acquire_ctx *ctx)
> > >> > >+{
> > >> > >+	struct drm_connector_list_iter conn_iter;
> > >> > >+	struct drm_connector *out_connector = ERR_PTR(-EINVAL);
> > >> > >+	struct drm_connector *connector;
> > >> > >+	struct drm_device *dev = encoder->dev;
> > >> > >+	int ret;
> > >> > >+
> > >> > >+	ret = drm_modeset_lock(&dev->mode_config.connection_mutex, ctx);
> > >> > >+	if (ret)
> > >> > >+		return ERR_PTR(ret);
> > >> > 
> > >> > It seems that this will cause a deadlock when called from a hotplug
> > >> > handling path, I have a WIP DP diver[0], which suggested by Dmitry to
> > >> > use this API from a &drm_bridge_funcs.detect callback to get the
> > >> > connector, as detect is called by drm_helper_probe_detect, which will
> > >> > hold connection_mutex first, so the deaklock happens:
> > >> >
> > >> > drm_helper_probe_detect(struct drm_connector *connector,
> > >> >                         struct drm_modeset_acquire_ctx *ctx,
> > >> >                         bool force)
> > >> > {
> > >> >         const struct drm_connector_helper_funcs *funcs = connector->helper_private;
> > >> >         struct drm_device *dev = connector->dev;
> > >> >         int ret;
> > >> > 
> > >> >         if (!ctx)
> > >> >                 return drm_helper_probe_detect_ctx(connector, force);
> > >> > 
> > >> >         ret = drm_modeset_lock(&dev->mode_config.connection_mutex, ctx);
> > >> >         if (ret)
> > >> >                 return ret;
> > >> > 
> > >> >         if (funcs->detect_ctx)
> > >> >                 ret = funcs->detect_ctx(connector, ctx, force);
> > >> >         else if (connector->funcs->detect)
> > >> >                 ret = connector->funcs->detect(connector, force);
> > >> >         else
> > >> >                 ret = connector_status_connected;
> > >> > 
> > >> >         if (ret != connector->status)
> > >> >                 connector->epoch_counter += 1;
> > >> > 
> > >> > So I wonder can we let drm_bridge_funcs.detect pass a connector for
> > >> > this case ?
> > >> 
> > >> Do you actually see a deadlock occurring? AFAIK, drm_modeset_lock is
> > >> fine with reentrancy from the same context, so it should work just fine.
> > >
> > >Andy, that probably means that you should use .detect_ctx() and pass the
> > >context to drm_atomic_get_connector_for_encoder().
> > 
> > Unfortunately, the drm_bridge_funcs does not have a .detect_ctx()  version .
> > The call chain is:
> >  drm_helper_probe_detect 
> >  --> drm_bridge_connector_detect(struct drm_connector *connector, bool force)
> > --> drm_bridge_funcs.detect(bridge)
> > The ctx got dropped when drm_helper_probe_detect call  drm_bridge_connector_detect
> > The connector got dropped  when connector call it's bridege.detect
> > 
> > So I think the simplest solution is to have drm_bridge_funcs.detect
> > directly pass the connector
> 
> I don't disagree on principle, but I think a better first step would be
> to provide a detect_ctx hook to bridges.

Yup. There's other reasons you really want to get at the locking context
in detect callbacks, doing this special case by passing something for
everyone doesn't sound like the right approach to me.
-Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

