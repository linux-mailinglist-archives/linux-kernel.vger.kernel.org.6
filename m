Return-Path: <linux-kernel+bounces-532465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D08A44E19
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEE8C1765A2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED6C20D517;
	Tue, 25 Feb 2025 20:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hEnpq2bB"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CD2DF59
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 20:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740517034; cv=none; b=jN1pMMbeoDTHiI5isrpO8zquBHW0oxHz+NFtMLCvSv+nkdLkxt0VfqRFMMt107ChWtURP5XSFOpat0MeAeHN4Rq8D2duEx9GpZkfjirX4lnJ+uSZM+R7AxrJbgUCq/1hNJplHBOZSzWOdvgo3omhJU4XjYbO+/djmr2LcSeyxek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740517034; c=relaxed/simple;
	bh=Ho2tqjl8RDylbwgCGJsLcMFxwZUteXNFVsZvLqhv/J4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrADpcijLOMwHjmvljg52sBQ3YAzA50R3serdFS5ikUXJ+oN+IfhS6PHKXL2HWkNPorvfODFzG6l+ycqDqSW7fjmvkvy5gzS/kugmupOW7IhCgCcPZzly5043ND5UimH4I4zwx16vW2PE7uxJbZ9RbrqNbsaERuKwW+f71p5WCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hEnpq2bB; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5493b5bc6e8so441773e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 12:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740517031; x=1741121831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RC4nwCVky+xPc0uxnaEdDnOXaTOZCldxGM13yaUgyKU=;
        b=hEnpq2bBclErB10VRewV/heBsllNtj/RkNZP3JbPvS9U8DZafDKwiXKxSflRHLKFsO
         aSWI9IzFXm1/KU4W2o7f5tzgkPdwlp2TyUknllJC2KAsg0qPuZYVYHRM9ImBDLxceX96
         g9QK0iZRo2vJP2QDj8vNpBG6aHY+ehoZjwaN1Kq4Qn6We20+DbAw8RZYRs5fsYMi6uCZ
         cqkUbEp7nA44lzwGcmXgT9/IUdD32q1sXW8H2yP8oXiq8bTtTlWWBKg6B/tziVG5s15b
         xkna29tSQM58+4JS7Ho8ZswatUjgJaWPeQQ+cPH8ib1H3fZacqlC/n6WXrJFJVlzkzzU
         GTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740517031; x=1741121831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RC4nwCVky+xPc0uxnaEdDnOXaTOZCldxGM13yaUgyKU=;
        b=FV9/Q6WetEuukJX6xP4mIes8PI0YeOhzD4zSmGq5qAYKdkihQ+WdZYLWNKV8n/lLYR
         Iwh12w1p6kf3rP+I8xtgxkYXvVR0xFqkIC1ZUlQDdCw3pGKX8Lj7VQgSSCtDABEvAT63
         n5fuxk6GZtO7OZHWJ9RWQwZY54hpPZI3eFRIfreMdCGbd9XSvscRB8zmtr+eM2f8yUXV
         H5HuyC3+96qiNddXVaYpXnl6s8Q6LpNrUkeXhLR+/HvQozr4IZ5QOL+4LFk3jN1zTult
         2vkgY+czi2dplTdIC98jsmncIdx9R59CtX97t3W/eZtht++vqulmO0/GsNalYNTHA59p
         +WBA==
X-Forwarded-Encrypted: i=1; AJvYcCXNHlUYn7hTQsQKjpZf6ghmJlCSjRJlVjoPEu1Q3FbQ9zF4yGGcY7ERBbIzshdsp1QFp4movVYvBYhByoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbefS8jBzk14dhe6tG5cuNr8uZH3TrHHig5MQRg1hWkwMvqPOl
	2n023nuUzQmdYrSbWD80BgB5oB5mmWd+ZhNyPCXKEGdEaMvyFIviF+WDMSUEMLs=
X-Gm-Gg: ASbGncvUhW969gHS+QyIaTsKjd8eBJfsTCmxRzlHG+eMw72RO+uaLN3w9xYssjviWUl
	uWBrcp+m9s2wkLSt/a/RUUu1XbRQ29t1WIg6jKynHeTMl4PmWU6qhyA8fLnOgg0S7DRlBfziWbA
	H0zLZTcYLbBcVFDrKL4Ad+cyW4KADtDEDwUybdXZ281rsod4igNcb9ycC34bK6PfKFAUsQ43ST9
	AySzT5e4x1JT+0ITXFFAf/s6bBiUmXrVf6J46I3T+52toYelVihE2xveA5qxUHwYpXF2QhiTarM
	WrbWC4wpvzLqvdISuY5Vh34jspGrkjMtE3B0ryqBuEMwmVIKlmMdvXedJy6SRkbym2XhZ5QO1jb
	2qD35Bw==
X-Google-Smtp-Source: AGHT+IHRv8mh/QNtBZyrnliPjjpkMnU2s4zUsA7EqzstzJNaDy/fNbCuH+kkInHHb1dD5QukYC4paA==
X-Received: by 2002:a05:6512:130c:b0:545:2953:1667 with SMTP id 2adb3069b0e04-5493c57a2eamr788746e87.13.1740517031002;
        Tue, 25 Feb 2025 12:57:11 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514b9d78sm271652e87.79.2025.02.25.12.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 12:57:10 -0800 (PST)
Date: Tue, 25 Feb 2025 22:57:08 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ayushi Makhija <quic_amakhija@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	robdclark@gmail.com, sean@poorly.run, marijn.suijten@somainline.org, 
	andersson@kernel.org, robh@kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org, 
	konradybcio@kernel.org, conor+dt@kernel.org, andrzej.hajda@intel.com, 
	neil.armstrong@linaro.org, rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, 
	jonas@kwiboo.se, jernej.skrabec@gmail.com, quic_abhinavk@quicinc.com, 
	quic_rajeevny@quicinc.com, quic_vproddut@quicinc.com, quic_jesszhan@quicinc.com
Subject: Re: [PATCH 10/11] drm/bridge: anx7625: update bridge_ops and sink
 detect logic
Message-ID: <yvjb7sd42uhvomsw2svotyxrvdxihsa3qch3lfynpaoap6g3hp@dcqmaw65zsk2>
References: <20250225121824.3869719-1-quic_amakhija@quicinc.com>
 <20250225121824.3869719-11-quic_amakhija@quicinc.com>
 <ne35ljkudi5jta2cby7fgjzqsd5sjpwcjpwhv6kmedq6nomho5@txynsflvtc6f>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ne35ljkudi5jta2cby7fgjzqsd5sjpwcjpwhv6kmedq6nomho5@txynsflvtc6f>

On Tue, Feb 25, 2025 at 07:58:24PM +0200, Dmitry Baryshkov wrote:
> On Tue, Feb 25, 2025 at 05:48:23PM +0530, Ayushi Makhija wrote:
> > The anx7625_link_bridge() checks if a device is a not a panel
> > bridge and add DRM_BRIDGE_OP_HPD and DRM_BRIDGE_OP_DETECT to
> > the bridge operations. However, on port 1 of the anx7625
> > bridge, any device added is always treated as a panel
> > bridge, preventing connector_detect function from being
> > called. To resolve this, instead of just checking if it is a
> > panel bridge, we should verify the type of panel bridge
> > whether it is a DisplayPort or eDP panel. If the panel
> > bridge is of the DisplayPort type, we should add
> > DRM_BRIDGE_OP_HPD or DRM_BRIDGE_OP_DETECT to the bridge
> > operations.
> > 
> > In the anx7625_sink_detect(), the device is checked to see
> > if it is a panel bridge, and it always sends a "connected"
> > status to the connector. When adding the DP port on port 1 of the
> > anx7625, it incorrectly treats it as a panel bridge and sends an
> > always "connected" status. Instead of checking the status on the
> > panel bridge, it's better to check the hpd_status for connectors
> > like DisplayPort. This way, it verifies the hpd_status variable
> > before sending the status to the connector.
> > 
> > Signed-off-by: Ayushi Makhija <quic_amakhija@quicinc.com>
> > ---
> >  drivers/gpu/drm/bridge/analogix/anx7625.c | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > index d2655bf46842..9b6303267924 100644
> > --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > @@ -1814,9 +1814,6 @@ static enum drm_connector_status anx7625_sink_detect(struct anx7625_data *ctx)
> >  
> >  	DRM_DEV_DEBUG_DRIVER(dev, "sink detect\n");
> >  
> > -	if (ctx->pdata.panel_bridge)
> > -		return connector_status_connected;
> > -
> >  	return ctx->hpd_status ? connector_status_connected :
> >  				     connector_status_disconnected;
> >  }
> > @@ -2596,9 +2593,10 @@ static int anx7625_link_bridge(struct drm_dp_aux *aux)
> >  	platform->bridge.of_node = dev->of_node;
> >  	if (!anx7625_of_panel_on_aux_bus(dev))
> >  		platform->bridge.ops |= DRM_BRIDGE_OP_EDID;
> > -	if (!platform->pdata.panel_bridge)
> > -		platform->bridge.ops |= DRM_BRIDGE_OP_HPD |
> > -					DRM_BRIDGE_OP_DETECT;
> > +	if (!platform->pdata.panel_bridge ||
> > +	    platform->pdata.panel_bridge->type == DRM_MODE_CONNECTOR_DisplayPort) {
> 
> This is incorrect, because there can be other kinds of bridges in the DP
> chain. I think it's better to check for !eDP instead.

Another option comes from the aux-bus bindings. If there is an aux-bus
node, it is an eDP. If there is none, it is most likely DP (well, unless
anybody has been using the bridge with eDP panels defclared using
platform devices rather than the aux-bus.

> 
> > +		platform->bridge.ops |= DRM_BRIDGE_OP_HPD | DRM_BRIDGE_OP_DETECT;
> > +	}
> >  	platform->bridge.type = platform->pdata.panel_bridge ?
> >  				    DRM_MODE_CONNECTOR_eDP :
> >  				    DRM_MODE_CONNECTOR_DisplayPort;
> > -- 
> > 2.34.1
> > 
> 
> -- 
> With best wishes
> Dmitry

-- 
With best wishes
Dmitry

