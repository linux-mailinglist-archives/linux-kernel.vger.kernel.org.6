Return-Path: <linux-kernel+bounces-181108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B479F8C7782
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C996281403
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E202146D59;
	Thu, 16 May 2024 13:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="jJg5XmTI"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBC86BB4E
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 13:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715865728; cv=none; b=R3OcJbMB4pHrIwa4EFLu+FY1XBxkrV/dQDoSauVaNf3FzQcogrZnzWnHtrUcVJR7h+aVEVlhd/NUrchXJL/jSUjItfdE2RSwnOX6dJ+PKHDZqPx0t/6EWzbtMA1CWvdgb9hwo9Rf7VvPj2rLEqY+niWGAFYz8XN+Q6car9JwE2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715865728; c=relaxed/simple;
	bh=k/XwXGbLcApeZc9DGMDvFG65ooCYnmW1wsKZLKAGacA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKu5D4jc6o0dFXq3w9DOgW8qvsU5ltz34UlQ0M7GkKxSdHubveKFn/5yw9vKLgBcepEy8gVUQVTO4l6gVo52Ux+/cS0W1XXhcbrnjAWTRYXTnHo8MJZ99Edws2U6NyLB1f5ut+7jNFAvX8P/UtwlAIyiPGY/LKAjYoUbxzyobBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=jJg5XmTI; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-574ea613b4fso428622a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 06:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1715865725; x=1716470525; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nbQzqHxIP6KG/lZzEJaOb6JfbxQkJJtK+amOHat2cF0=;
        b=jJg5XmTIlb/hqKE328IHuDqMmlVj9T+glnLGfNDgy268A/2ZU5BoY8kNDUyx+2051Q
         toPVUePFkxW3tF1xp9F6wMSxRgnwBmXbp9dJKueSM1Islp/rKcT0Tvf+xTUVxE9F3EG7
         LtNhW0qtxJRpw99+H8iwkTDcrLPLkpBz4j9ng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715865725; x=1716470525;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nbQzqHxIP6KG/lZzEJaOb6JfbxQkJJtK+amOHat2cF0=;
        b=JyUk6dm4nuP/Gvvrlro7BXw37M0CDMKS6SMS3mYG3EWaQjNMia/3qlKlPhH+tLwjiZ
         4diJRMvPmLmnynMR2XZ3RrDMNbI+iUUhSkE9AmpWo+7jw48PhX0pEHWSA1upxD898tsO
         Na39Tgu0Hc3cOe9XXtNMraC1cPJQC9BpYz88/2uyEGZ9Z5Euj+bJ6WCbky9DmnFnUpfw
         D7+/JDIjqDV5KT8XkMT5P5ra9dhqSmsP1KLwHiqftJQAhCy9SrDN8cuOwgmF+9UKd5Lm
         qJA6lxXEJvRTn0V+UspncnmSNoLVm05TXzfjBH4QvA+zsmfJiPY+Y0+g4hvniPGeMs6w
         eXYA==
X-Forwarded-Encrypted: i=1; AJvYcCUurv219QF9y6cQSUocFGGX60+aZ1wCxeLzr/h/AzsE2ldmg3JwWl8AL5AFPusmv8r0P1/g7YSpfKx8puq01j41YGLR/MAzrAgTgzXE
X-Gm-Message-State: AOJu0Yxjs6fOR414bzkMIoFuGvZj35IJoBcDNMuIi5m7t2TLNOKz3a+i
	AQYF5RlRp22dzFnUMBwk6goEbWuHlEMd4rQIwb7Ap78D3WYDpUfUKETSiYsiBOw=
X-Google-Smtp-Source: AGHT+IG/GbdAA1hnZI5HX8ckZhx9yyUo5RCiVYZCkkh9dmJJkpcbYE9NbAPi4OkErRr7QoWUCfwebQ==
X-Received: by 2002:a50:fb16:0:b0:572:5a35:4824 with SMTP id 4fb4d7f45d1cf-5734d441a2bmr11951080a12.0.1715865724828;
        Thu, 16 May 2024 06:22:04 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-575058cd7casm1219130a12.65.2024.05.16.06.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 06:22:03 -0700 (PDT)
Date: Thu, 16 May 2024 15:22:01 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>,
	Paul Kocialkowski <contact@paulk.fr>,
	=?iso-8859-1?Q?Herv=E9?= Codina <herve.codina@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v2 0/5] Add support for GE SUNH hot-pluggable connector
 (was: "drm: add support for hot-pluggable bridges")
Message-ID: <ZkYIeWzYyxkURS79@phenom.ffwll.local>
Mail-Followup-To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>,
	Paul Kocialkowski <contact@paulk.fr>,
	=?iso-8859-1?Q?Herv=E9?= Codina <herve.codina@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>
References: <20240510-hotplug-drm-bridge-v2-0-ec32f2c66d56@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510-hotplug-drm-bridge-v2-0-ec32f2c66d56@bootlin.com>
X-Operating-System: Linux phenom 6.6.15-amd64 

Apologies for missing v1 ...

On Fri, May 10, 2024 at 09:10:36AM +0200, Luca Ceresoli wrote:
> DRM hotplug bridge driver
> =========================
> 
> DRM natively supports pipelines whose display can be removed, but all the
> components preceding it (all the display controller and any bridges) are
> assumed to be fixed and cannot be plugged, removed or modified at runtime.
> 
> This series adds support for DRM pipelines having a removable part after
> the encoder, thus also allowing bridges to be removed and reconnected at
> runtime, possibly with different components.
> 
> This picture summarizes the  DRM structure implemented by this series:
> 
>  .------------------------.
>  |   DISPLAY CONTROLLER   |
>  | .---------.   .------. |
>  | | ENCODER |<--| CRTC | |
>  | '---------'   '------' |
>  '------|-----------------'
>         |
>         |DSI            HOTPLUG
>         V              CONNECTOR
>    .---------.        .--.    .-.        .---------.         .-------.
>    | 0 to N  |        | _|   _| |        | 1 to N  |         |       |
>    | BRIDGES |--DSI-->||_   |_  |--DSI-->| BRIDGES |--LVDS-->| PANEL |
>    |         |        |  |    | |        |         |         |       |
>    '---------'        '--'    '-'        '---------'         '-------'
> 
>  [--- fixed components --]  [----------- removable add-on -----------]
> 
> Fixed components include:
> 
>  * all components up to the DRM encoder, usually part of the SoC
>  * optionally some bridges, in the SoC and/or as external chips
> 
> Components on the removable add-on include:
> 
>  * one or more bridges
>  * a fixed connector (not one natively supporting hotplug such as HDMI)
>  * the panel

So I think at a high level this design approach makes sense, but the
implementation needs some serious thought. One big thing upfront though,
we need to have a clear plan for the overlay hotunload issues, otherwise
trying to make drm bridges hotpluggable makes no sense to me. Hotunload is
very, very tricky, full of lifetime issues, and those need to be sorted
out first or we're just trying to build a castle on quicksand.

For bridges itself I don't think the current locking works. You're trying
to really cleverly hide it all behind a normal-looking bridge driver, but
there's many things beyond that which will blow up if bridges just
disappear. Most importantly the bridge states part of an atomic update.

Now in drm we have drm_connector as the only hotunpluggable thing, and it
took years to sort out all the issues. I think we should either model the
bridge hotunplug locking after that, or just outright reuse the connector
locking and lifetime rules. I much prefer the latter personally.

Anyway the big issues:

- We need to refcount the hotpluggable bridges, because software (like
  atomic state updates) might hang onto pointers for longer than the
  bridge physically exists. Assuming that you can all tear it down
  synchronously will not work.

  If we reuse connector locking/lifetime then we could put the
  hotpluggable part of the bridge chain into the drm_connector, since that
  already has refcounting as needed. It would mean that finding the next
  bridge in the chain becomes a lot more tricky though. With that model
  we'd create a new connector every time the bridge is hotplugged, which I
  think is also the cleaner model (because you might plug in a hdmi
  connector after a panel, so things like the connector type change).
  
- No notifiers please. The create a locking mess with inversions, and
  especially for hotunplug they create the illusion that you can
  synchronously keep up to date with hardware state. That's not possible.
  Fundamentally all bridge drivers which might be hotunplugged need to be
  able to cope with the hardware disappearing any momemnt.

  Most likely changes/fixes we need to make overlay hotunload work will
  impact how exactly this works all ...

  Also note that the entire dance around correctly stopping userspace from
  doing modesets on, see all the relevant changes in
  update_connector_routing(). Relying on hotplugging connectors will sort
  out a lot of these issues in a consistent way.

- Related to this: You're not allowed to shut down hardware behind the
  user's back with drm_atomic_helper_shutdown. We've tried that approach
  with dp mst, it really pisses off userspace when a page_flip that it
  expected to work doesn't work.

- There's also the design aspect that in atomic, only atomic_check is
  allowed to fail, atomic_commit must succeed, even when the hardware is
  gone. Using connectors and their refcounting should help with that.

- Somewhat aside, but I noticed that the bridge->atomic_reset is in
  drm_bridge_attach, and that's kinda the wrong place. It should be in
  drm_mode_config_reset, like all the other ->atomic_reset hooks. That
  would make it a lot clearer that we need to figure out who/when
  ->atomic_reset should be called for hotplugged bridges, maybe as part of
  connector registration when the entire bridge and it's new connector is
  assembled?

- Finally this very much means we need to rethink who/how the connector
  for a bridge is created. The new design is that the main driver creates
  this connector, once the entire bridge exists. But with hotplugging this
  gets a lot more complicated, so we might want to extract a pile of that
  encoder related code from drivers (same way dp mst helpers take care of
  connector creation too, it's just too much of a mess otherwise).

  The current bridge chaining infrastructure requires a lot of hand-rolled
  code in each bridge driver and the encoder, so that might be a good
  thing anyway.

- Finally I think the entire bridge hotplug infrastructure should be
  irrespective of the underlying bus. Which means for the mipi dsi case we
  might also want to look into what's missing to make mipi dsi
  hotunpluggable, at least for the case where it's a proper driver. I
  think we should ignore the old bridge model where driver's stitched it
  all toghether using the component framework, in my opinion that approach
  should be deprecated.

- Finally I think we should have a lot of safety checks, like only bridges
  which declare themselve to be hotunplug safe should be allowed as a part
  of the hotpluggable bridge chain part. All others must still be attached
  before the entire driver is registered with drm_dev_register.

  Or that we only allow bridges with the NO_CONNECTOR flag for
  drm_bridge_attach.

There's probably a pile more fundamental issues I've missed, but this
should get a good discussion started.
-Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

