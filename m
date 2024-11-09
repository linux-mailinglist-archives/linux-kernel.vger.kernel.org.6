Return-Path: <linux-kernel+bounces-402723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7809C2AFB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 08:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D636AB21A60
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 07:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1462913AA4C;
	Sat,  9 Nov 2024 07:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tVnoYLrH"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CBC233D62
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 07:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731136653; cv=none; b=mSFJ0dhfXbsvEizAt29seKAt0gCxXiUCLmMQFedALY2D3Oh/2Udy3YUOiBS0l0nUgCYcxyhWoy2zCz4N+1w68M4qJpoB7Dnn6363/9874Q3SiTJQSitcn7i1qgT3jZxJTCIEGb1o9fDW+c38x5iZdI9Dd9Wh3AdtvaIKyJFNNvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731136653; c=relaxed/simple;
	bh=MqwezRtVpXJisZtFhFHmfeLKjC/Yn9facChnJ0XXgLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQH4S7smKK4pYpwSQ+n6viE6gsyIGv0Pdg9IPITmCAjafqc56h7VL3j30pDgkibPbwdkkQf/5idKUNDyo+d1R/DOsZ9wyCVzwH/r8uU8p3xpNgDyuiPsGvvxW3i5bPSwrp3BaFo6dhpcXP23l2SRAcHcSuyja+FdGTynbQHZkGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tVnoYLrH; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539f4d8ef84so3776534e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 23:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731136650; x=1731741450; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EHUaeS9e58wupBTZi+unSe1iCTz6zWdP/n4haz6XM6g=;
        b=tVnoYLrHjRwj3Pu33x5zi/gwVT5Zi5gMn/w/vhw3sk9QIHoeKqL0ms0oYBq2Y7EKfl
         G9rKZMLcPjh7E562h2AoEVK+yvvf+YwnvUPU3fxydVLq9UcEIS6Rz976bxy2lvmYMNxG
         g24jCnwUAzrqcH1bUH5RXLmDj0vnps0eWu/MN/G3JjwVecaIkVaWVoo5EYcCRAllCZpr
         3ZHeoC3UxUyySyrhn9uGMzBd0QBMi548Q8mWM1k9QwmMiig2aOzriyEZfdYAhO6bJIFt
         T7MqWh7WjjDE2YIWApYh4S7qGZA/dwvwMJPh8TH5eBXYAgxYk8EeydshQ6cQiJU39Tz4
         SDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731136650; x=1731741450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHUaeS9e58wupBTZi+unSe1iCTz6zWdP/n4haz6XM6g=;
        b=hliDN5iWF179RCiulOAaBMj5K0DmxZsmiaOMS9T+cBQX3mKUB9llzuBX2v8+LBG0Sl
         a4ydUue8h6i2ivt84fCf9dpYYf5Jpi+szhqi8yNFxa0gFi7rw05dTjPz4JuPeN5UbDTF
         g4THXv53HQP3rv67kNv4K52P6hL1v3XwKZhp0Dqp5m8TUn4wsCn+8nnA3Sw10KWWy248
         16kpcNfwKj0jzJfV4xo8boU2B/Yt0efWLMIYGTw4ySv+z6sfp9cwMiarQRRG6XxJr9ws
         8aLyz0W4hVNlAFu4p9R3RrXfAyUAz/ww6jWx5MthQdjUduGb/59U3zPOK1KU1dCGEgOM
         Ef4g==
X-Forwarded-Encrypted: i=1; AJvYcCW3Q+7Up+XeumKeDn6JDx+Kni9IdsY8SDCYvluYEnwX/HtAZHAZ07TuxQ+J9/I23HGkvXG/dDR6foAf+XM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgoHtff1QYet2sxaxgYT9BI92mBRf+wvk8vP8x5JDtACiWN05z
	1vGuzKrvulFFMXvRf+tckMlw52szrIQ3RA5ILsm7oYnC3DicxP2Twqayz7/Zbk8=
X-Google-Smtp-Source: AGHT+IF6pPVyHIuCfkrHbrnoRwNG36vLEw644YibuKEFHAGwh0LXfQaZBO+/vLKGW0b7AToo6GiOmw==
X-Received: by 2002:a05:6512:3f11:b0:539:ec87:bc7f with SMTP id 2adb3069b0e04-53d86231c05mr2939389e87.19.1731136649659;
        Fri, 08 Nov 2024 23:17:29 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d8268654dsm858927e87.72.2024.11.08.23.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 23:17:28 -0800 (PST)
Date: Sat, 9 Nov 2024 09:17:26 +0200
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
Subject: Re: [PATCH v2 2/6] drm/sun4i: use drm_hdmi_connector_mode_valid()
Message-ID: <gbn7qal7pbeizuse3ge4ecvxuwcnhuauxyb5xist27uwi7ydyw@zeqvg4j26sxn>
References: <20241101-hdmi-mode-valid-v2-0-a6478fd20fa6@linaro.org>
 <20241101-hdmi-mode-valid-v2-2-a6478fd20fa6@linaro.org>
 <20241108-gainful-lionfish-of-progress-758dcb@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108-gainful-lionfish-of-progress-758dcb@houat>

On Fri, Nov 08, 2024 at 03:20:48PM +0100, Maxime Ripard wrote:
> On Fri, Nov 01, 2024 at 02:25:05AM +0200, Dmitry Baryshkov wrote:
> > Use new drm_hdmi_connector_mode_valid() helper instead of a
> > module-specific copy.
> > 
> > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 12 +-----------
> >  1 file changed, 1 insertion(+), 11 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> > index b3649449de3026784ae2f3466906403a0b6e3b47..54b72fe220afacc208b3fd48d5160031127ea14a 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> > @@ -205,16 +205,6 @@ static int sun4i_hdmi_connector_atomic_check(struct drm_connector *connector,
> >  	return 0;
> >  }
> >  
> > -static enum drm_mode_status
> > -sun4i_hdmi_connector_mode_valid(struct drm_connector *connector,
> > -				struct drm_display_mode *mode)
> > -{
> > -	unsigned long long rate = drm_hdmi_compute_mode_clock(mode, 8,
> > -							      HDMI_COLORSPACE_RGB);
> > -
> > -	return sun4i_hdmi_connector_clock_valid(connector, mode, rate);
> > -}
> > -
> >  static int sun4i_hdmi_get_modes(struct drm_connector *connector)
> >  {
> >  	struct sun4i_hdmi *hdmi = drm_connector_to_sun4i_hdmi(connector);
> > @@ -269,7 +259,7 @@ static const struct drm_connector_hdmi_funcs sun4i_hdmi_hdmi_connector_funcs = {
> >  
> >  static const struct drm_connector_helper_funcs sun4i_hdmi_connector_helper_funcs = {
> >  	.atomic_check	= sun4i_hdmi_connector_atomic_check,
> > -	.mode_valid	= sun4i_hdmi_connector_mode_valid,
> > +	.mode_valid	= drm_hdmi_connector_mode_valid,
> >  	.get_modes	= sun4i_hdmi_get_modes,
> >  };
> 
> It's only slightly related, but the atomic_check implementation that
> will be the last (direct) user of sun4i_hdmi_clock_valid is wrong and
> doesn't call drm_atomic_helper_connector_hdmi_check

I can send a patch fixing this, but I can't test it.

-- 
With best wishes
Dmitry

