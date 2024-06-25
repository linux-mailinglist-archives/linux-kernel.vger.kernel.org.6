Return-Path: <linux-kernel+bounces-228362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCD8915ED3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 08:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F18611F23061
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 06:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AF0145FE5;
	Tue, 25 Jun 2024 06:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YAnLVk2l"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB26143889
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 06:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719296500; cv=none; b=irjuOwo7vSL5JjRrIKRblOaT6a/ToLbstwWWwxygEs/eCPqtr2Ur64hQmChJjCXmqBVPme0LsdPPWxRLPMIb9aAfKmGcZ9gBwSkx+vEXwU4IR8nQQ5evbjneHvCM6FTXskeJuoGO12bxwGF5WXV5hoYAWRAsDSCJTMdu+ElPnSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719296500; c=relaxed/simple;
	bh=kAfwh5gzgxt0EW6r8Fn9CS9SSFL4R/qfOsvvYvQ27Us=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FW5jCM6770S95Kc8n55yt7TrrfAGwD5bkHQYxIpXsR7yAQNOHtEqbqvnobGiolT2Hlcv6zbvFaV7ZNYiR9n9QBYavmP2OxzIZv1CTAAww+bHymrs0wTNwXBhRzQ3fDdHM/HYAOh8DV6q2km1YweZotLru+GufIA0FuZ5BFTA108=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YAnLVk2l; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-63bd10df78dso47941937b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 23:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719296498; x=1719901298; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E8h+QAt+AnCIi8f4bWuVBQN+cusYRxI2Lf5DdexkiOQ=;
        b=YAnLVk2lBEyA3IyFJcUcu5xhJjvYj2pGDdR/2JAHjMnAdlwjiRWGQh3vz7wnDN/xPa
         kGFQOXlVjNefINWinXz1krF7LtLmJtXTAmMMjY7MqGWRNteTdCak6pK/29GLX4eEteXi
         ebj/35kXz10ZSNQOkMVqhyUL6ANUVzmAtavHDExz3Lpag5z4fJidH5TfAG47u/qsyd0A
         jZW5gn+9wyTYFr8SRp55r2lsybbhWnXZ5DmjW7uxF2UEW2DLBRVahoc0I/RBKt7UNhU8
         FJp+EZx+v+y16ajsYPul4kMrVbOX+9OM/fmr1tvCFCE/2VeF0ieBCLaNQ1WoStOfWWZi
         kU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719296498; x=1719901298;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E8h+QAt+AnCIi8f4bWuVBQN+cusYRxI2Lf5DdexkiOQ=;
        b=gCpMqrILdDTP6g/wmewT/PgK4Xq53Dm5oZZlMgZJaL8xeWb6YkbVdTPKyDN0F9Q+KZ
         8RoFRqVadx6cxJgGHuWvW8B31ieneS3TISzS4WTHzz1W/WNkc+dozrzS+jg1zcCOQNGG
         r9rld7e9NXSxWA5Q/tvWMrEsUxTZezzpiLMN1oEmVrJoHgaHYyMwNkgkJtGdruchBCWl
         29Q9+bX6fP0XZSQWi1Q11Zr081Ta/b4DJNDLMzQab1kraDPOA7hJZWbGJ6Xv2rged85D
         1krMjoWnFB/rDNtwxDKRyWga3YJTqG/S2jQm899bySneUmHwOUmiA+l6JEUu0wqsgAXH
         Il4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUg8HGrmp7CiWJijuWziKmcEFtUioG7ccdPaR8MmgteiMCIbGnXcYrAK22i+EV9gpPsREyetyp6eyNR+XQ8YtUekBMd7iuHu+pjJAAZ
X-Gm-Message-State: AOJu0Yw6fDp4lM/gL1f/ocXkS8zdbEijfMxxv5t+nF0mF2CwPTxpzdJh
	fQRHLsDqysChuxRhtJzxpQ4gd+wroMk4crNdVqnpSfnnu+/T+/H56BGn6x3nZRb+i02UdkujSNA
	mW8+BOmpWQ1dzy84gXLM2uHDis9xpb6JoVr2P0A==
X-Google-Smtp-Source: AGHT+IE+hPsnqRrxvUEK/lDnk62xZtQsZKqDpaowdgDDlT6ocbFhNfJnHF1nQyY0YgiVL/7XWxu0RPc4/5enaupC53s=
X-Received: by 2002:a81:8547:0:b0:631:8274:1611 with SMTP id
 00721157ae682-6433dd74338mr64895967b3.20.1719296498073; Mon, 24 Jun 2024
 23:21:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240623-drm-bridge-connector-fix-hdmi-reset-v2-0-8590d44912ce@linaro.org>
 <20240623-drm-bridge-connector-fix-hdmi-reset-v2-2-8590d44912ce@linaro.org>
 <99ff549c-f5c4-dc9c-42f3-396dc3d29d6b@quicinc.com> <CAA8EJppcH-z275m6xDQaigsxmVhnfJkLVsq68GHLFoAq_p_2GA@mail.gmail.com>
 <30fa4e53-5a03-4030-2be5-f383a1c60077@quicinc.com>
In-Reply-To: <30fa4e53-5a03-4030-2be5-f383a1c60077@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 25 Jun 2024 09:21:27 +0300
Message-ID: <CAA8EJpo_dBDqLUVH-SkufhFchu64rhC+vkhVBFdt++E4pdCrQg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/connector: automatically set immutable flag
 for max_bpc property
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	"igt-dev@lists.freedesktop.org" <igt-dev@lists.freedesktop.org>, Petri Latvala <adrinael@adrinael.net>, 
	Kamil Konieczny <kamil.konieczny@linux.intel.com>, 
	=?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
	Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Jun 2024 at 01:56, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 6/24/2024 3:46 PM, Dmitry Baryshkov wrote:
> > On Tue, 25 Jun 2024 at 01:39, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> >>
> >> + IGT dev
> >>
> >> On 6/22/2024 10:40 PM, Dmitry Baryshkov wrote:
> >>> With the introduction of the HDMI Connector framework the driver might
> >>> end up creating the max_bpc property with min = max = 8. IGT insists
> >>> that such properties carry the 'immutable' flag. Automatically set the
> >>> flag if the driver asks for the max_bpc property with min == max.
> >>>
> >>
> >> This change does not look right to me.
> >>
> >> I wonder why we need this check because DRM_MODE_PROP_IMMUTABLE means
> >> that as per the doc, userspace cannot change the property.
> >>
> >>            * DRM_MODE_PROP_IMMUTABLE
> >>            *     Set for properties whose values cannot be changed by
> >>            *     userspace. The kernel is allowed to update the value of
> >> these
> >>            *     properties. This is generally used to expose probe state to
> >>            *     userspace, e.g. the EDID, or the connector path property
> >> on DP
> >>            *     MST sinks. Kernel can update the value of an immutable
> >> property
> >>            *     by calling drm_object_property_set_value().
> >>            */
> >>
> >> Here we are allowing userspace to change max_bpc
> >>
> >>
> >> drm_atomic_connector_set_property()
> >> {
> >>          **********
> >>
> >>           } else if (property == connector->max_bpc_property) {
> >>                   state->max_requested_bpc = val;
> >>
> >>          **********
> >> }
> >>
> >> I believe you are referring to this IGT check right?
> >>
> >> https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/blob/master/tests/kms_properties.c#L428
> >
> > Yes
> >
> >>
> >> I think we should fix IGT in this case unless there is some reason we
> >> are missing. Because just because it has the same min and max does not
> >> mean its immutable by the doc of the IMMUTABLE flag.
> >
> > Well, having the same min and max means that it is impossible to
> > change the property. So the property is immutable, but doesn't have
> > the flag.
> >
>
> True, then does DRM_MODE_PROP_IMMUTABLE need a doc update too indicating
> that even if the min and max is same, property will be interpreted as
> immutable.

Granted that I'm only doing it for max_bpc property I don't think so.

>
> >>
> >>
> >>> Fixes: aadb3e16b8f3 ("drm/connector: hdmi: Add output BPC to the connector state")
> >>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >>> ---
> >>>    drivers/gpu/drm/drm_connector.c | 7 ++++++-
> >>>    1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > With best wishes
> > Dmitry



-- 
With best wishes
Dmitry

