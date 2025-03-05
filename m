Return-Path: <linux-kernel+bounces-547679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B78FEA50C4E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E21CD169CAC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FC3255237;
	Wed,  5 Mar 2025 20:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QVxZCsP6"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB3019D06A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 20:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741205641; cv=none; b=VsWXCjfmWxbEyjDKIT2HsW0oPcLzrMUMGcZRoDD0n1Ff9x4hComQm0LtRaGuU/r8BPmssJAGrNEf9o6ZT/rCiGs/0zuXz1kjA/636i1OZO//TRwFzjq3Uo/QUuruQsszQglJOG7jdoCBzlaMNTcUkT0KaCZSePOiYhOcQPcE9dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741205641; c=relaxed/simple;
	bh=oto+r93ips5SQf9gDBBk+mR+AJTpZQ4hpWmBsYmLyBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8JhWh0K4N2tEJ0VFRfTN7GW0WSOkUkUpntx49GxoP7nGLDxS5VVbaQSZsNWLbLcm9MexHmaiZnHlWGHzpbRt4TCp3LY5Oo8bCkgAZ6oOWTe4sizN00C5wD54O51Qgd+08VRThfKYIaXF8h+RROpaDd7L2d9MrVBhPxxYvY3Udw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QVxZCsP6; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54298ec925bso10851456e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 12:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741205638; x=1741810438; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ur8Gy0umiWGU/zRuogWAi9qm20TVsSYV1MmXLXIgc2U=;
        b=QVxZCsP6WUsqYzR2rMy+8eR8ls6vdfsiwTcSZFeVBY8JAmJVMy5894JrCX1Y2No5Wx
         qot/fuDQ+eKULZ0dmLsmaV2VU7tMZaMdVhvG0UIPD0nlLBvawVIOVEIxk+S/TQbbwiQX
         k5mq1a88JUXrShF9geGcFiMElA60OHIp12/QMy+f6Ym3q+imTh/Mtrs9hy4pVf/s5hVF
         rNYc7sp9FUpbLcDnowsZAY+JKeAzn7apqnsmYHiXVPVANIPwuX3ZQA7jmoiqM2ea2j4y
         aUAwhbl0VUJSI77dJvzer61lg91vO4qt+shePeDmhiCPGGrKGtts11tMSfhVGVFiuOMV
         jyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741205638; x=1741810438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ur8Gy0umiWGU/zRuogWAi9qm20TVsSYV1MmXLXIgc2U=;
        b=Juueg0Y3+7aQw9FqMOo+p8d3ysOo9vcTnzgFt7CnVjkQmMDst88eIGqPcx0JpR6WHE
         FSjMtFip4cIZ7zGZcX0h1P0yPXw9wgbVKlsFvjudGl4cBaUbuOKK1zmFgcY9+HYsS2sc
         4QXGiFao5ImTfygL3wB2qIWs8LndTP7iXXDVOqyLspITV7yB9eW/XTnisN0d800uWiHz
         olr4aTx9tkLe4OdBoIjF3Pyz50Ixg2XLOQu1x/cNCyNP7duRqWrfxQiSDc3tpPavsaMp
         ujZQIU8WN8zTeWbWE8bB2rj4Oh1okZlQLQta6R9dsLCDQf2P7Ezf5gtnYeprR/BEmyU2
         oPpw==
X-Forwarded-Encrypted: i=1; AJvYcCWvChOIUgY7MaY+cEFCBWw1wVtR7QUGOgE72adEKiebgb0XJwY5PRD+PteYmlYZk40hrhAdy6p46gx3cdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YySpQb9PooUSuXkJcHsZ7VH/o4tiloEYnU4hEKCpD5Z1NQcpO5M
	l9sVgH5AXjLTtzyYHziTM4ln0ZJlyC3VVDpFUEJiGPXqjHBigSOArQKJzVMWKxc=
X-Gm-Gg: ASbGncs6ViAfr4Nf06Tt9hzHrhMqsHvWXllQNigiyl1xXbIKY1QCPLBeeQu321vp95g
	o76iPR7WOQkqETYfEwLYtjxfQW5qCCCYlSutGC7wQSnKyNPoiFQXhbYjfpynBnZcHdfW+9nwbvL
	7sWG5/xD83SLVaegkR1sefNV6Uw7pfT0cYIOU9XWxNnTBWRC07DFpXyOSEwUhwfvtAXw/6DAwWX
	/AeI+LkAmyvAd24HCqZ9XOXxq7BWCf456DyCObbaEiMqBxWD/v55MUo+sySeYyF3TcYd//RhuOc
	IlGk7m0Lv3A2JXxpglD+HqY4PW9IiwmVThLHXfaf5wW4sLbaO73lm3VUExuWEXCf/L50HqIIQgz
	Nmg5wMr1J0E7dQHgqknVYNXjg
X-Google-Smtp-Source: AGHT+IEAAQPMZhciffBUFfTbRedj5hNBNyknT+VL3Qo1wCR6z4FsNvWZEfzxe2rXJO+c+wB64CTqUw==
X-Received: by 2002:a05:6512:3994:b0:549:74a7:12de with SMTP id 2adb3069b0e04-5497d3830dfmr1632742e87.48.1741205637709;
        Wed, 05 Mar 2025 12:13:57 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5495c5a2f18sm1273328e87.14.2025.03.05.12.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 12:13:56 -0800 (PST)
Date: Wed, 5 Mar 2025 22:13:53 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Andy Yan <andyshrk@163.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Douglas Anderson <dianders@chromium.org>, Herve Codina <herve.codina@bootlin.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Simona Vetter <simona.vetter@ffwll.ch>
Subject: Re: [PATCH v5 04/16] drm/atomic: Introduce helper to lookup
 connector by encoder
Message-ID: <mqh4wedfokuta2tmyctoi6jrzol7mqzm27nj3ylu6yj2vjy22j@mexke5x2o7a2>
References: <20250304-bridge-connector-v5-0-aacf461d2157@kernel.org>
 <20250304-bridge-connector-v5-4-aacf461d2157@kernel.org>
 <5180089f.a640.19566290538.Coremail.andyshrk@163.com>
 <20250305-ruddy-nightingale-of-wealth-db100a@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305-ruddy-nightingale-of-wealth-db100a@houat>

On Wed, Mar 05, 2025 at 02:19:36PM +0100, Maxime Ripard wrote:
> Hi Andy,
> 
> On Wed, Mar 05, 2025 at 07:55:19PM +0800, Andy Yan wrote:
> > At 2025-03-04 19:10:47, "Maxime Ripard" <mripard@kernel.org> wrote:
> > >With the bridges switching over to drm_bridge_connector, the direct
> > >association between a bridge driver and its connector was lost.
> > >
> > >This is mitigated for atomic bridge drivers by the fact you can access
> > >the encoder, and then call drm_atomic_get_old_connector_for_encoder() or
> > >drm_atomic_get_new_connector_for_encoder() with drm_atomic_state.
> > >
> > >This was also made easier by providing drm_atomic_state directly to all
> > >atomic hooks bridges can implement.
> > >
> > >However, bridge drivers don't have a way to access drm_atomic_state
> > >outside of the modeset path, like from the hotplug interrupt path or any
> > >interrupt handler.
> > >
> > >Let's introduce a function to retrieve the connector currently assigned
> > >to an encoder, without using drm_atomic_state, to make these drivers'
> > >life easier.
> > >
> > >Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > >Co-developed-by: Simona Vetter <simona.vetter@ffwll.ch>
> > >Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > >---
> > > drivers/gpu/drm/drm_atomic.c | 45 ++++++++++++++++++++++++++++++++++++++++++++
> > > include/drm/drm_atomic.h     |  3 +++
> > > 2 files changed, 48 insertions(+)
> > >
> > >diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> > >index 9ea2611770f43ce7ccba410406d5f2c528aab022..b926b132590e78f8d41d48eb4da4bccf170ee236 100644
> > >--- a/drivers/gpu/drm/drm_atomic.c
> > >+++ b/drivers/gpu/drm/drm_atomic.c
> > >@@ -985,10 +985,55 @@ drm_atomic_get_new_connector_for_encoder(const struct drm_atomic_state *state,
> > > 
> > > 	return NULL;
> > > }
> > > EXPORT_SYMBOL(drm_atomic_get_new_connector_for_encoder);
> > > 
> > >+/**
> > >+ * drm_atomic_get_connector_for_encoder - Get connector currently assigned to an encoder
> > >+ * @encoder: The encoder to find the connector of
> > >+ * @ctx: Modeset locking context
> > >+ *
> > >+ * This function finds and returns the connector currently assigned to
> > >+ * an @encoder.
> > >+ *
> > >+ * Returns:
> > >+ * The connector connected to @encoder, or an error pointer otherwise.
> > >+ * When the error is EDEADLK, a deadlock has been detected and the
> > >+ * sequence must be restarted.
> > >+ */
> > >+struct drm_connector *
> > >+drm_atomic_get_connector_for_encoder(const struct drm_encoder *encoder,
> > >+				     struct drm_modeset_acquire_ctx *ctx)
> > >+{
> > >+	struct drm_connector_list_iter conn_iter;
> > >+	struct drm_connector *out_connector = ERR_PTR(-EINVAL);
> > >+	struct drm_connector *connector;
> > >+	struct drm_device *dev = encoder->dev;
> > >+	int ret;
> > >+
> > >+	ret = drm_modeset_lock(&dev->mode_config.connection_mutex, ctx);
> > >+	if (ret)
> > >+		return ERR_PTR(ret);
> > 
> > It seems that this will cause a deadlock when called from a hotplug
> > handling path, I have a WIP DP diver[0], which suggested by Dmitry to
> > use this API from a &drm_bridge_funcs.detect callback to get the
> > connector, as detect is called by drm_helper_probe_detect, which will
> > hold connection_mutex first, so the deaklock happens:
> >
> > drm_helper_probe_detect(struct drm_connector *connector,
> >                         struct drm_modeset_acquire_ctx *ctx,
> >                         bool force)
> > {
> >         const struct drm_connector_helper_funcs *funcs = connector->helper_private;
> >         struct drm_device *dev = connector->dev;
> >         int ret;
> > 
> >         if (!ctx)
> >                 return drm_helper_probe_detect_ctx(connector, force);
> > 
> >         ret = drm_modeset_lock(&dev->mode_config.connection_mutex, ctx);
> >         if (ret)
> >                 return ret;
> > 
> >         if (funcs->detect_ctx)
> >                 ret = funcs->detect_ctx(connector, ctx, force);
> >         else if (connector->funcs->detect)
> >                 ret = connector->funcs->detect(connector, force);
> >         else
> >                 ret = connector_status_connected;
> > 
> >         if (ret != connector->status)
> >                 connector->epoch_counter += 1;
> > 
> > So I wonder can we let drm_bridge_funcs.detect pass a connector for
> > this case ?
> 
> Do you actually see a deadlock occurring? AFAIK, drm_modeset_lock is
> fine with reentrancy from the same context, so it should work just fine.

Andy, that probably means that you should use .detect_ctx() and pass the
context to drm_atomic_get_connector_for_encoder().

-- 
With best wishes
Dmitry

