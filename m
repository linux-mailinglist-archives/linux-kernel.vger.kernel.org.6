Return-Path: <linux-kernel+bounces-225693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F10579133DE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 14:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2266A1C20E07
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 12:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA21168C20;
	Sat, 22 Jun 2024 12:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BolkzI6R"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D4014A098
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 12:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719058747; cv=none; b=G/vqLLxQfWBPObQ653biK4gPDApbPjKexjx9XccMVHqsrYirDiPpfQM3i9WqG8lkfAj1rWZuXlpASMh8am1OEGAX9QL611NJB2JiSPmH1qhgXoHCa1oL24LPIgLwuHstvHPHZL9old36EMw1RmmZEis7zpT0gtHHVekqI7kvxho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719058747; c=relaxed/simple;
	bh=k8aMDXsWbVz9pTZQeBRFT3NJhCu6Vr9XszQ/ikvpHqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qr+H+q4Bus8gFlNtHz8gTVEADrvXY3AB02C2pNrdx5npqVvIblVL+X1rX9rQ4xXla05IZmxL+4jj2iatJ24j90Rk0+L2ZLSzxn/GescF/M4CmLzKBtRSyInJO9Rh3YFn8oeDwrfaB3+bmI0u/qzA8iexMVM2lQqkwBru30gDhu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BolkzI6R; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ec1620a956so32573081fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 05:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719058743; x=1719663543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uFTJWPHoWIzzZYySQj01J40y/z9s/zNsE0TqSi/ZOOw=;
        b=BolkzI6RpoVk4z1Lak+yLUfbBRcXgi8GrvSUWGIr+ibVU3kuZHpcCjhqisJE03ej8V
         4MfhESQ1ZuRp3nR5TDx5+lW/xKlzyGUlSVXq5TcKgKze0euly32MaNBue4X0wrLjbJks
         ACRWURKJ8PDuo2Jh0zgifl8uudsoyHRsghIA4e4uUjKk9YQFhp5KIZ1CK75G7O2OYiFP
         mNftVVx5lHrzgVeHTfASzPaZ/jyMJ6RWP6LbrOUDXkuWiD5EvnQgF1PJfWL9L6tulIZh
         O0YYtJRKmqzs3T7kbnuLe/dKGpnp0Cf2JIDIm1Kk7x+7VGMMLofErFmNKhfIBtPcbrqF
         r0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719058743; x=1719663543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFTJWPHoWIzzZYySQj01J40y/z9s/zNsE0TqSi/ZOOw=;
        b=GYVrhteaIaf8V31Y9D7A+RuVSD9p98ra1aDVThJAZOa14NDJh/HbKZFlDbK+bKERWr
         SjRPDL46j9jVr5FR+4BnPZNqnlwjBNOP7LNag4TpUVyQPHLKtqXmpZOHprM3fVUCVegY
         kH2o+ta4GbWIpBOItBIFidXjcoXfzpP8xVJMGuOGGrAMylwin/CeGTto62do9vDhHBiV
         eJxp71M3LtOG5I7KAGNAFRn5w6XtLtPU17W2AYsztDqxbLruVNLlWScmxHXwffzPjWso
         hAs0CCKQ+Ntz8JrUT+6YeYLWGxhvdrZX65RZ8VF9k9CTVLTYf1it78ImcNXZn2SvkHp8
         SzgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAoXsGnCxVFl5oxAGyakZvXuZOpTGacwgUorOkZa05Ux0qDB/WtAAsPu05AibN/He8R1RqpAyqaeK+6avDKRR3oD9u23kq8u7qkWvw
X-Gm-Message-State: AOJu0Yy0cJmft3dztuxw5T84tSz4tPdfVqougE/XRY1sgOlkDdd5FlW8
	BrwFeSoA2KAJYmwd+zHpjX80ieRoHfeFSF8DZ6CWh0RIiwQj8X0ZUbbPena8r9k=
X-Google-Smtp-Source: AGHT+IHZ/lhd6X/rx/n+EobIKJogWOuMNlLQQQqYQAVR2+BTc252BAZ4shFesdOp1i9t2/g4du319A==
X-Received: by 2002:a2e:9dc1:0:b0:2ec:4d48:75ec with SMTP id 38308e7fff4ca-2ec4d487811mr24681611fa.22.1719058743543;
        Sat, 22 Jun 2024 05:19:03 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec4d76e950sm4266561fa.107.2024.06.22.05.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 05:19:03 -0700 (PDT)
Date: Sat, 22 Jun 2024 15:19:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Aradhya Bhatia <a-bhatia1@ti.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Marek Vasut <marex@denx.de>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] drm/bridge: tc358767: Fix
 DRM_BRIDGE_ATTACH_NO_CONNECTOR case
Message-ID: <bebvl4vycvpkdqjlz3xi33t7qtb4oj7mriywxmahfemyee3uxk@m3nbraynomg2>
References: <20231108-tc358767-v2-0-25c5f70a2159@ideasonboard.com>
 <f6af46e0-aadb-450a-9349-eec1337ea870@ti.com>
 <2f3bb86b-6f8c-4807-985e-344a0c47864c@siemens.com>
 <3277848.aeNJFYEL58@steina-w>
 <b2052bc9-b2da-489b-9e5b-3c9b4f6c1c99@ideasonboard.com>
 <bc96c6b5-a7f8-4ef3-a89b-bf577943f11c@denx.de>
 <36ef53b6-57a3-42e4-95ef-a10eef4ca1c9@siemens.com>
 <o4bwopeuyxm6344oqqm3e7p3xcx76aw2trsiuhhfyhel2e7po7@sz2jaj6i7kqd>
 <71e809fa-b471-4bb3-8f7d-e497397c0de4@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71e809fa-b471-4bb3-8f7d-e497397c0de4@ti.com>

On Sat, Jun 22, 2024 at 05:16:58PM GMT, Aradhya Bhatia wrote:
> 
> 
> On 17-Jun-24 13:41, Dmitry Baryshkov wrote:
> > On Mon, Jun 17, 2024 at 07:40:32AM GMT, Jan Kiszka wrote:
> >> On 16.02.24 15:57, Marek Vasut wrote:
> >>> On 2/16/24 10:10, Tomi Valkeinen wrote:
> >>>> Ok. Does anyone have a worry that these patches make the situation
> >>>> worse for the DSI case than it was before? Afaics, if the DSI lanes
> >>>> are not set up early enough by the DSI host, the driver would break
> >>>> with and without these patches.
> >>>>
> >>>> These do fix the driver for DRM_BRIDGE_ATTACH_NO_CONNECTOR and DPI, so
> >>>> I'd like to merge these unless these cause a regression with the DSI
> >>>> case.
> >>>
> >>> 1/2 looks good to me, go ahead and apply .
> 
> Isn't there any way for the second patch to move forward as well though?
> The bridge device (under DPI to (e)DP mode) cannot really work without
> it, and the patches have been pending idle for a long time. =)
> 
> >>
> >> My local patches still apply on top of 6.10-rc4, so I don't think this
> >> ever happened. What's still holding up this long-pending fix (at least
> >> for our devices)?
> > 
> > Neither of the patches contains Fixes tags. If the first patch fixes an
> > issue in previous kernels, please consider following the stable process.
> > 
> > If we are unsure about the second patch, please send the first patch
> > separately, adding proper tags.
> > 
> 
> Thanks Dmitry! I can send the patches again with the required fixes
> tags (or just patch-1 if we cannot do anything about patch-2).

The problem with the second patch is that it get mixed reviews. I can
ack the first patch, but for the second one I'd need a confirmation from
somebody else. I'll go on and apply the first patch later today.

-- 
With best wishes
Dmitry

