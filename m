Return-Path: <linux-kernel+bounces-510945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B460A323EA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4ACB162C6E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0E420967B;
	Wed, 12 Feb 2025 10:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gquvLvKX"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23DA2AF19
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739357516; cv=none; b=n4k3L278g8U7PhrUE46qqPvDCil+87xHV9RSo7UTxirGf+vOb+bkmgkm86ZCxh/S9HHHfanld4s8/WxP2kyzRT+8g4imjxe4bWGv8/1JMTLb2rVWDDG9YBeRNBUNfP/ZLkzmL7LiTVFYmN/+o4ad1n0pHnX4XhO7i5+a+mlQPYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739357516; c=relaxed/simple;
	bh=WlUr0MD4QXtNFABFVLVDJgWWsMyTBjkVt2yig3FyYTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5WOCx14eCH6rUfmgmRQXqDpdFBV5jH3+OxoinLMIaceXYiiNTba1CJQXJaR0ZD3x6kkk3KRRm0BrzdF2q1V/5oSVM5bL27lCI82+7T1Uus+w90f1MXHv+ZECiAy1UQ/k7YjdQQFTtGSMCTP4sAtX9UvUtX7YXTOEfVfseHl2iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gquvLvKX; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-307bc125e2eso61811721fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 02:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739357513; x=1739962313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uwMEgQxoUHmLZtuKQ7OktGqb6xfp8P5Cp0GfVd//gwo=;
        b=gquvLvKXIfnTZo/vpMYqmPjxMnxSOBMNBZblxZrg5zfQ5Vxxx+b6/V6OHdJW/d2mAx
         5olNC3m6ZW2wscKrAgNUrBBQqjWpl3fUaBnmrNcU8XiaBsD3ZZY23/1YkU6slkd95UOX
         lkRocNUjwjDlTN7n2AGovi65L35UvHdfKOvvdxRjruJqxLNozU8gLVCYc4NCDXE4GurD
         kj9GnHBbnK8uBroJFTlz8tyE2cDwVR3aQeC3BPsFngiWw6uz5spWGdhkJuV1UM9AKVKw
         pF1ktyMPdsTj1qiTxNOdGyn/QTGF5YEahQXJWAl94bzBtz7vP2avRTqnXvZFLoyJ3eUI
         Ca4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739357513; x=1739962313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwMEgQxoUHmLZtuKQ7OktGqb6xfp8P5Cp0GfVd//gwo=;
        b=UVUxFPkMZRGxkHrG38tGazwERKHY31duC2pTpfkhVF7H/9EvzzKfoFia2Pf5aqzA2L
         /n5L11KXCexD7FF0rKPzb8Ul/YEmZcC7/kdO3ZYSmrWiwLF/qY44glt+aZ4zG0yBUt+v
         3VkeEkZ3pb5tWrZn2CH3xiDdk+GcKXWTYWHnSI2PukTBAfkQSuumwmvjl/PBdK/Yp8KG
         7HEhBedJXPO2kwHZaMTXdQysDuernUQ7vOXK3WEVFF6FXFYjbLz70c3ZZx3Wn+iFglsh
         ekqsLYPQ38M5zN25t2IC0uUVqjOFgdNglGZXWLwj1Vr00SJoZLH+06UZXKW1zjBztDP9
         crzA==
X-Forwarded-Encrypted: i=1; AJvYcCUAlL8d2XXwjXIe96McYDZolZaPpe6GvON1hvnzypIMdmbtqjucQwt8YTSuixDqXq1F934lkkgMT2W/sY4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3eAxcSu3vg3KRjZuu7WHLUZvve2It3ZNcg1iVK4atwflgCVQu
	pc0KniSSoQ+2ebfKWXHkv0mLib/D1gMVGfkRMMFgafCoZnKSkZbxl0t05uL9JiE=
X-Gm-Gg: ASbGncsbFCijCAZjLEB10LJggM33voTM9hL6Ls7g/1IYJ2heAEE/ZyOHXQU6bnp/ODF
	3aKmQlAfYSBUJsPsFsdPNiYR43Doy/LDd7/qTXLUvCOJYY98jt0sNytq++nsTNtsq/DVrsV8LoT
	mGg3+J/ix7x8QD/WN8gWUBH61fofNEvLMAYL9q8wa0Qx3CP1NgwCxgLIhF6MsfGi1axpKn7S5hH
	55vfsUG/ri1b5779xoiAffZhHV/6myG37WAso9xEM3VPTTBog7tmefJplw5TDYgLwhVlb7F/EVy
	SMucT/ZJWcTa7PQRsmGXYETIofRGokQ4nUuuTiXoKv2hS3mSNKmshVCSAmg3W/m4P7/3p8s=
X-Google-Smtp-Source: AGHT+IEKUeDThVJ/lnz2Tru7gCIU188oezABVqDXzxKcHI8yaF3qfkwLQfpmjpdp11HB4DwHxistqw==
X-Received: by 2002:a05:6512:e9e:b0:545:e2e:8425 with SMTP id 2adb3069b0e04-5451818b3b0mr773873e87.39.1739357512796;
        Wed, 12 Feb 2025 02:51:52 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5450654c5d6sm1230593e87.34.2025.02.12.02.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 02:51:52 -0800 (PST)
Date: Wed, 12 Feb 2025 12:51:50 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas Anderson <dianders@chromium.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 34/35] drm/bridge: tc358768: Convert to atomic helpers
Message-ID: <pbeqsf7buhgbrxybexhcxzdwitcb2ioa3as7itp2mxj2hybuji@sbh744trp3au>
References: <20250204-bridge-connector-v2-0-35dd6c834e08@kernel.org>
 <20250204-bridge-connector-v2-34-35dd6c834e08@kernel.org>
 <nbghrrl74xsuzomp7d6qjfosxfiooezipppjhxkx2ibnlpi6rj@b6ovgosmpuhl>
 <20250211-solemn-meticulous-angelfish-85d1ce@houat>
 <btehhpvkv6iqd4pofumspqbxzr5gxwp6vs5oh7vflbcmzqj5wz@s6yem2ryw6vs>
 <20250212-versatile-donkey-of-thunder-0894ec@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212-versatile-donkey-of-thunder-0894ec@houat>

On Wed, Feb 12, 2025 at 09:24:21AM +0100, Maxime Ripard wrote:
> On Wed, Feb 12, 2025 at 02:38:52AM +0200, Dmitry Baryshkov wrote:
> > On Tue, Feb 11, 2025 at 03:33:58PM +0100, Maxime Ripard wrote:
> > > On Sun, Feb 09, 2025 at 09:13:36AM +0200, Dmitry Baryshkov wrote:
> > > > On Tue, Feb 04, 2025 at 03:58:02PM +0100, Maxime Ripard wrote:
> > > > > The tc358768 driver follows the drm_encoder->crtc pointer that is
> > > > > deprecated and shouldn't be used by atomic drivers.
> > > > > 
> > > > > This was due to the fact that we did't have any other alternative to
> > > > > retrieve the CRTC pointer. Fortunately, the crtc pointer is now provided
> > > > > in the bridge state, so we can move to atomic callbacks and drop that
> > > > > deprecated pointer usage.
> > > > > 
> > > > > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > > > > ---
> > > > >  drivers/gpu/drm/bridge/tc358768.c | 30 +++++++++++++++++++++++-------
> > > > >  1 file changed, 23 insertions(+), 7 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
> > > > > index 6db18d1e8824dd7d387211d6d1e668645cf88bbe..6ff6b29e8075d7c6fa0b74b4fec83c5230512d96 100644
> > > > > --- a/drivers/gpu/drm/bridge/tc358768.c
> > > > > +++ b/drivers/gpu/drm/bridge/tc358768.c
> > > > > @@ -601,17 +601,29 @@ static void tc358768_bridge_disable(struct drm_bridge *bridge)
> > > > >  	ret = tc358768_clear_error(priv);
> > > > >  	if (ret)
> > > > >  		dev_warn(priv->dev, "Software disable failed: %d\n", ret);
> > > > >  }
> > > > >  
> > > > > +static void tc358768_bridge_atomic_disable(struct drm_bridge *bridge,
> > > > > +					   struct drm_atomic_state *state)
> > > > > +{
> > > > > +	tc358768_bridge_disable(bridge);
> > > > > +}
> > > > > +
> > > > 
> > > > Please change corresponding functions into atomic_disable() and
> > > > atomic_post_disable(). Calling sites have access to the atomic state, so
> > > > there is no need to have yet another wrapper.
> > > 
> > > It's pretty hard to do (at least without the hardware), both
> > > tc358768_bridge_disable() and tc358768_bridge_post_disable() have
> > > multiple call sites in the driver, and passing a state enabling the
> > > bridge doesn't make sense for those.
> > 
> > I think it makes sense. The function knows that the bridge needs to be
> > disabled. The state is totally unused (or it can be used to get
> > connectors / CRTC / etc).
> 
> That's the thing though, if we were to pass the state, it would be a
> state where the bridge is enabled, like, it would have an active CRTC.
> In a disable path, you wouldn't have it.
> 
> Another idea would be to just drop the call to disable the bridge, the
> assumption is that we can't fail in atomic_enable, so no driver actually
> tries to mitigate a failure. I'm not sure why this one would need to.

SGTM too.

-- 
With best wishes
Dmitry

