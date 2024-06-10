Return-Path: <linux-kernel+bounces-208665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 560769027DF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 19:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A14C4B21A6D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804B9147C6E;
	Mon, 10 Jun 2024 17:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aIaizZjE"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52E313C3CA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 17:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718041037; cv=none; b=pHTE9FAgQvDAh42XwCEt9FX5onll0ElF1y6FdESPun3qNe5eAFizARBbqb1diI/fEr5jhf+EjwmHeGn6O/NVivJmOalUv6ebj84z2SjSMcH0rtv7lOCMVtnlYtYUOIMBPcVyobU+jIemL+hWhGC2s+rzFcMAk3CYOfUhOhAGp+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718041037; c=relaxed/simple;
	bh=ac3CvuBKpoN77b884nN2OQAAZJ10/y/+4ngGccg1GgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9RmcHguNx7r3CYfSgYL2aSz1nrq9gobJ02E1kZ5Qe/jtxfahV9lDcOLjwDeFvhVC8Rgh2RhI6gbVFb1aR/rksmqqWIccyYUmBL8zdsLzs7xQfo17i1V9Ji4P8Bzw79Z+kzjecZZj0BONp2vubhZLjKo37CxJp2YLLz/K5K9+/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aIaizZjE; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52c8ddc2b29so249412e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 10:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718041034; x=1718645834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TEEh5KUewfmYnZ3Q1Chus2HvKgHcn8j4nfiNpTmt2M4=;
        b=aIaizZjEpj69P3/l2AIj3LJNE1dbmdZgvs0zEsdg1eyGRGj+tizAlR2v8OQka/axwS
         hNXVeghRrIzusBFWD8NTFdcZOaX81sUSXIUnd8i40017FZPBP+cvIE+f1Q7lA67n2QHT
         z56M/jfnOKf0kqCXiXjwqLHgl+HSXVbH2MNi/o8DwON0oInmVGDGYGuPkG7riXuF49zv
         V9pOwDy1nfdY2yMS4qpbVHMr8VrFwAkV4GDHhtExyu9EB07+VyPuvIoAzJcYwSEXxO5T
         DUve1bJ6rNNNbitbj72ZL48LaTICp2XexxYn3jBNhGNQYF6UZRpMhWMAXQe7udC5V5v8
         hBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718041034; x=1718645834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TEEh5KUewfmYnZ3Q1Chus2HvKgHcn8j4nfiNpTmt2M4=;
        b=KtEat61ks+lZo65VKLF56KKzg4fMlnFKQbh9vDAqyiWlFjlG8Z6OrDbXkywcf8PgbW
         Wv05IOp49U3IQD0uzXWkTLa2lIgq+nt2uSa3NzFaVf9xkywua0FWM9UjIQok4z3b00MO
         8y0AUf56lIr9/tspuUB7Q9nfVGHAaXWZ+10I0K3SC0Ki7kVLiciViOF3rUyAPxOngIJq
         pR8GcRsT1tV6XAfWmHWpBJz9L1quMubUjFjGIbLpcNyCESOF5oZ6TApC7C432hqZNTyQ
         JDGD8Oq2gcpgqbaujm82mMDOZgWwLB5BcxXl0pvt90RMWLI+bYdk03kTl0JIMYDzX91o
         DhDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPQncEyf2xLUzwf+EQEo52mVqQjMdfNqup+9TDQnwrgY72LwcqVL2hgaCWQIXwRcBMloZ+zFaoG98FngbDSSk/2YIRvW5jH3lQLaWt
X-Gm-Message-State: AOJu0YwuCICDqZsUhH1zbxkldf0+jST1XDME6F/irnBIO7TtVmCgimRX
	G5PsJeMQlIG6frCDWxvoQNyvpcxmhCkcZ8+mw3f8R+0SlNLr0RvScUSWpHjAeFA=
X-Google-Smtp-Source: AGHT+IEwN5GXDdCSSPBpIsgaZw66Nb9x4NckjGz5YCW6eYhsHn+R7JHRmJZAvzVcvknfacTENnz8sg==
X-Received: by 2002:a05:6512:61b:b0:52c:73be:f14a with SMTP id 2adb3069b0e04-52c73bef481mr5193626e87.33.1718041033710;
        Mon, 10 Jun 2024 10:37:13 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52c8970d282sm776839e87.221.2024.06.10.10.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 10:37:13 -0700 (PDT)
Date: Mon, 10 Jun 2024 20:37:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Aradhya Bhatia <a-bhatia1@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Jyri Sarha <jyri.sarha@iki.fi>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	DRI Development List <dri-devel@lists.freedesktop.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, 
	Sam Ravnborg <sam@ravnborg.org>, Thierry Reding <treding@nvidia.com>, 
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Praneeth Bajjuri <praneeth@ti.com>, Udit Kumar <u-kumar1@ti.com>, 
	Devarsh Thakkar <devarsht@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
	Jai Luthra <j-luthra@ti.com>
Subject: Re: [PATCH v2 7/9] drm/bridge: cdns-dsi: Support atomic bridge APIs
Message-ID: <hofs67cb2oylwdkuazdzukswbi5t7v7e6frhv52zaz4p2lgwro@vr3muasxj4mw>
References: <20240530093621.1925863-1-a-bhatia1@ti.com>
 <20240530093621.1925863-8-a-bhatia1@ti.com>
 <4fsu5fa5zbrqgc5bepxscoenrax5c6p5b4eyomavioy3bhwuq3@rjjbur3v52e3>
 <a78d5ddf-38d8-4b54-a9b3-7a8745d3b537@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a78d5ddf-38d8-4b54-a9b3-7a8745d3b537@ti.com>

On Mon, Jun 10, 2024 at 06:02:41PM +0530, Aradhya Bhatia wrote:
> Hi Dmitry,
> 
> Thank you for reviewing the patches.
> 
> On 31/05/24 04:51, Dmitry Baryshkov wrote:
> > On Thu, May 30, 2024 at 03:06:19PM +0530, Aradhya Bhatia wrote:
> >> Change the existing (and deprecated) bridge hooks, to the bridge
> >> atomic APIs.
> >>
> >> Add drm helpers for duplicate_state, destroy_state, and bridge_reset
> >> bridge hooks.
> >>
> >> Further add support for the input format negotiation hook.
> >>
> >> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> >> ---
> >>  .../gpu/drm/bridge/cadence/cdns-dsi-core.c    | 70 ++++++++++++++++---
> >>  1 file changed, 62 insertions(+), 8 deletions(-)
> > 
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > 
> > Minor nit below.
> > 
> >>
> >> @@ -915,13 +920,62 @@ static void cdns_dsi_bridge_pre_enable(struct drm_bridge *bridge)
> >>  	cdns_dsi_hs_init(dsi);
> >>  }
> >>  
> >> +static u32 *cdns_dsi_bridge_get_input_bus_fmts(struct drm_bridge *bridge,
> >> +					       struct drm_bridge_state *bridge_state,
> >> +					       struct drm_crtc_state *crtc_state,
> >> +					       struct drm_connector_state *conn_state,
> >> +					       u32 output_fmt,
> >> +					       unsigned int *num_input_fmts)
> >> +{
> > 
> > This code below looks pretty generic. Would be logical to extract it to
> > a helper and allow it to be used by other DSI host bridges?
> 
> I agree, it would indeed make sense.
> 
> I just tried to make a helper function that could directly be passed to
> the drm_bridge_funcs list - like we do with
> "drm_atomic_helper_bridge_propagate_bus_fmt". This would have been ideal
> in my opinion.
> 
> But, that doesn't seem possible today. The parameter "output_fmt"
> doesn't describe any of the DSI pixel formats from "enum
> mipi_dsi_pixel_format", which is what's required to ascertain the input
> bus format for dsi hosts. Neither do the drm_bridge{_state} help with
> that.
> 
> For now, I am thinking to just add a common function that accepts the
> dsi bus output format and returns the corresponding input bus format.
> With this, every dsi host will still need to implement their own
> get_input_fmt hook and call that function.
> 
> If you had something else in mind, do let me know! =)

No, the code that you have described looks pretty good. Please proceed
with the implementation!

> 
> Regards
> Aradhya
> 
> > 
> >> +	struct cdns_dsi_input *input = bridge_to_cdns_dsi_input(bridge);
> >> +	struct cdns_dsi *dsi = input_to_dsi(input);
> >> +	struct cdns_dsi_output *output = &dsi->output;
> >> +	u32 *input_fmts;
> >> +
> >> +	*num_input_fmts = 0;
> >> +
> >> +	input_fmts = kzalloc(sizeof(*input_fmts), GFP_KERNEL);
> >> +	if (!input_fmts)
> >> +		return NULL;
> >> +
> >> +	switch (output->dev->format) {
> >> +	case MIPI_DSI_FMT_RGB888:
> >> +		input_fmts[0] = MEDIA_BUS_FMT_RGB888_1X24;
> >> +		break;
> >> +
> >> +	case MIPI_DSI_FMT_RGB666:
> >> +		input_fmts[0] = MEDIA_BUS_FMT_RGB666_1X24_CPADHI;
> >> +		break;
> >> +
> >> +	case MIPI_DSI_FMT_RGB666_PACKED:
> >> +		input_fmts[0] = MEDIA_BUS_FMT_RGB666_1X18;
> >> +		break;
> >> +
> >> +	case MIPI_DSI_FMT_RGB565:
> >> +		input_fmts[0] = MEDIA_BUS_FMT_RGB565_1X16;
> >> +		break;
> >> +
> >> +	default:
> >> +		/* Unsupported DSI Format */
> >> +		return NULL;
> >> +	}
> >> +
> >> +	*num_input_fmts = 1;
> >> +
> >> +	return input_fmts;
> >> +}
> >> +
> > 

-- 
With best wishes
Dmitry

