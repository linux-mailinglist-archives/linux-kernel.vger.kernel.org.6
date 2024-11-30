Return-Path: <linux-kernel+bounces-426434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 897849DF2EE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 21:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77E66B207C6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 20:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEE01AA1F0;
	Sat, 30 Nov 2024 20:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DEa/sRn3"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6487117BD3
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 20:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732997656; cv=none; b=oeqjifTp6j7IElcI32QUJeEunzCcxW5zKkwrFimIaP/0fpZ0R1K6oRnbgmUPnvjVrICyExuLRkyC1ZtswVLNXHriJTOn5e4xmTMAFmWZdHsGOBRc8I1ndeyVdKD/1sKqt8IZ9fcU6EGLHkBu9ggyEJdCt5cyX4bIBuLqSCqPLeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732997656; c=relaxed/simple;
	bh=gzcaby2HyJAHKdOSuPzNnIo9c9OQwgNevAUxBsyaaxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ct0PscTgD6FsLoXn7ywn0sO5dy50vqC8/TX/wuEGdy05lARD1uAQYXL9E973n4KSQhfm6QG/hDs6pWtrAvPXqt6y+SKhiySMZQJipPpUr2rhqd4Hg3RDrSkkP7F5sxQy090xIierawka8PULLDJOQFrl18E8V/CdRI8EeSKxHjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DEa/sRn3; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53df7f6a133so3071313e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 12:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732997652; x=1733602452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YQnwH/LUU+Smj6DytGhxhh3Q/k+FhhcvJy+0gsHfMM0=;
        b=DEa/sRn3NCSdHXMAOdsrvN1ofEXA8xIiiH15S/vQ7qSzoVKlyjp/R73nqxnhl3WRLY
         qjiusjrHXQFHMR/eQ2+kBxAjqnYVoTS7BY08L2e8DSjWhy+APLP6PFmQ6JSj9ekVwTLI
         IJTnozftwQuvLtlpLnx/wT4VrNQ2MUS54aMnT7yFYh3d62n9Y5SAUhhzSXs6sqfcQSow
         LzYEStzvHLB0qhUgKSsJ/G6Q2MBGT0mefXU94B5lnnDAUPnsU6Tq2yuQlYzYgnJxsvxQ
         xgkIPkKEebXbq4nIv83TOUIC2EBGoHmMV11bNJAod+6B6wAvJRaWwQjSYeU0ntQsIN+f
         wRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732997652; x=1733602452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQnwH/LUU+Smj6DytGhxhh3Q/k+FhhcvJy+0gsHfMM0=;
        b=fuBNTRNzpahprjCvxppSx5vo/BYO2aeT2MKACnruryp3QbuT3tdSJQgiJ0lcOQB/bJ
         PjsyU+vWbcggzmt2MdVxAxUytxxyTzSksqjQ+aWK6WgN4lR0uZEfAO7gaWtJmT8TU0zO
         P1Rxdii7hIgJucRNdO3jDP+16Q9Aah8mMF5PCSC6qBRgQyTxBxBJ6NbOTvzqvJR03MMQ
         sbhVH+pZGWckpmLgmz3/hlX6viJLk1MhBqN6zsxP1+jrEb/U6+SDNsHyPhcIJ8sFYdZh
         9E7TK+JAgoCO6Z7Gyx82CTd/7Q95yfSr1jxSQfQ/T7vzvngn55wcUrcHQtr7x4mWulUI
         ak5g==
X-Forwarded-Encrypted: i=1; AJvYcCVNytw/tTTjPhZzrVJ2XGd6gm4aqKev5TfUnFnA9AYSlxeKm6YTAd9zF9bRp0lL99SXVVtOaoN4g8Hw5dg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNEWjfo3EqLxlPp0HSH+oFOtquUUw969OEuD8wfUn3TRbGJqNu
	yvVWlAUUsizuHfE/CNWDB4Ff+Xu36zu5fmKe+8DvkUPZG+lJN+/n7DQcQ9rk+w4=
X-Gm-Gg: ASbGncvGuqEo9QONPXPkzSQzPyfO28NeNrMD2nxdApU/DPVjSHNNiV6PVse0077WNUq
	U9ipAvcq1R6srfb2hI29NEGyTdwOSVk7jiXfntK+ubvHUFo9dy8Y9RQ5Ln2lNAIKOaFBzhUTGT0
	W+tfhU7ud1tg8vOs8yW6JH/7l0dqqbcuxDNEGc1w65Zy3fZCmTDDg/eJw4psNaSv6DgCysUxUTg
	6fWSawuPfwBNCeyIQbM5orGV/ACNaQ8c8hvbInGOPO0CIhuzSP98t1vX/I5i00YmnRFW5VDAuIM
	zCaIyyHpOsWXpMFb3qnYlA2y8VNeEQ==
X-Google-Smtp-Source: AGHT+IGfLTfcEm+aaMxybBxbVKL1US/VY5OZiq/tUksfQrDmttijCUwRwCJjRKEGbqDV/mDp0pZhPw==
X-Received: by 2002:a05:6512:b14:b0:53d:dda4:8b0c with SMTP id 2adb3069b0e04-53df00d0332mr10008210e87.18.1732997650904;
        Sat, 30 Nov 2024 12:14:10 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df6496467sm858800e87.187.2024.11.30.12.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 12:14:09 -0800 (PST)
Date: Sat, 30 Nov 2024 22:14:07 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Nikolaus Voss <nv@vosn.de>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>, 
	Liu Ying <victor.liu@nxp.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Fabio Estevam <festevam@denx.de>, Marek Vasut <marex@denx.de>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>, 
	nikolaus.voss@haag-streit.com
Subject: Re: [PATCH] drm: bridge: fsl-ldb: fixup mode on freq mismatch
Message-ID: <ljxbp7e6ywj2btbo22gvh3ijuwq6hzaahcph2vcsh6xiyzdyla@vuz437cyxe3e>
References: <20241126172610.AD8B51622C@mail.steuer-voss.de>
 <lio6natmz5d5hdmdxwuj5ghfbpl4medb2orhw2m27m6g3rvaga@tanmydgbufg2>
 <c05e762f-a9c3-4655-7b21-8490d91fd858@vosn.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c05e762f-a9c3-4655-7b21-8490d91fd858@vosn.de>

On Sat, Nov 30, 2024 at 07:57:17PM +0100, Nikolaus Voss wrote:
> Hi Dmitry,
> 
> On Sat, 30 Nov 2024, Dmitry Baryshkov wrote:
> > On Tue, Nov 26, 2024 at 04:45:54PM +0100, Nikolaus Voss wrote:
> > > LDB clock has to be a fixed multiple of the pixel clock.
> > > As LDB and pixel clock are derived from different clock sources
> > > (at least on imx8mp), this constraint cannot be satisfied for
> > > any pixel clock, which leads to flickering and incomplete
> > > lines on the attached display.
> > > 
> > > To overcome this, check this condition in mode_fixup() and
> > > adapt the pixel clock accordingly.
> > > 
> > > Cc: <stable@vger.kernel.org>
> > > 
> > > Signed-off-by: Nikolaus Voss <nv@vosn.de>
> > > ---
> > >  drivers/gpu/drm/bridge/fsl-ldb.c | 40 ++++++++++++++++++++++++++++----
> > >  1 file changed, 36 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/bridge/fsl-ldb.c b/drivers/gpu/drm/bridge/fsl-ldb.c
> > > index 0e4bac7dd04ff..e341341b8c600 100644
> > > --- a/drivers/gpu/drm/bridge/fsl-ldb.c
> > > +++ b/drivers/gpu/drm/bridge/fsl-ldb.c
> > > @@ -104,12 +104,14 @@ static inline struct fsl_ldb *to_fsl_ldb(struct drm_bridge *bridge)
> > >  	return container_of(bridge, struct fsl_ldb, bridge);
> > >  }
> > > 
> > > +static unsigned int fsl_ldb_link_freq_factor(const struct fsl_ldb *fsl_ldb)
> > > +{
> > > +	return fsl_ldb_is_dual(fsl_ldb) ? 3500 : 7000;
> > > +}
> > > +
> > >  static unsigned long fsl_ldb_link_frequency(struct fsl_ldb *fsl_ldb, int clock)
> > >  {
> > > -	if (fsl_ldb_is_dual(fsl_ldb))
> > > -		return clock * 3500;
> > > -	else
> > > -		return clock * 7000;
> > > +	return clock * fsl_ldb_link_freq_factor(fsl_ldb);
> > >  }
> > > 
> > >  static int fsl_ldb_attach(struct drm_bridge *bridge,
> > > @@ -121,6 +123,35 @@ static int fsl_ldb_attach(struct drm_bridge *bridge,
> > >  				 bridge, flags);
> > >  }
> > > 
> > > +static bool fsl_ldb_mode_fixup(struct drm_bridge *bridge,
> > > +				const struct drm_display_mode *mode,
> > > +				struct drm_display_mode *adjusted_mode)
> > 
> > The driver uses atomic callbacks. Please use .atomic_check() instead.
> 
> So it is okay to modify drm_crtc_state->adjusted_mode in .atomic_check()? I

Yes. samsung-dsim, anx7625 do that (I stopped checking after the second
one).

> chose .mode_fixup() because the function name and args make it more obvious
> what is done there. Btw, the API reference doesn't say this call is
> deprecated.

It's not deprecated. But as the driver is using atomic calls (vs legacy
calls) it makes more sense to use atomic_check() too.

> A second thought:
> Maybe it would be a good idea to reject modes which result in an adjusted
> mode pclk that is not within certain boundaries, even if this patch doesn't
> do it yet. As I see it, that would be only possible in mode_fixup().

atomic_check() can definitely reject whatever is being stuffed to it.

> 
> > 
> > > +{
> > > +	const struct fsl_ldb *fsl_ldb = to_fsl_ldb(bridge);
> > > +	unsigned long requested_link_freq =
> > > +		mode->clock * fsl_ldb_link_freq_factor(fsl_ldb);
> > > +	unsigned long freq = clk_round_rate(fsl_ldb->clk, requested_link_freq);
> > > +
> > > +	if (freq != requested_link_freq) {
> > > +		/*
> > > +		 * this will lead to flicker and incomplete lines on
> > > +		 * the attached display, adjust the CRTC clock
> > > +		 * accordingly.
> > > +		 */
> > > +		int pclk = freq / fsl_ldb_link_freq_factor(fsl_ldb);
> > > +
> > > +		if (adjusted_mode->clock != pclk) {
> > > +			dev_warn(fsl_ldb->dev, "Adjusted pixel clk to match LDB clk (%d kHz -> %d kHz)!\n",
> > > +				 adjusted_mode->clock, pclk);
> > > +
> > > +			adjusted_mode->clock = pclk;
> > > +			adjusted_mode->crtc_clock = pclk;
> > > +		}
> > > +	}
> > > +
> > > +	return true;
> > > +}
> > > +
> > >  static void fsl_ldb_atomic_enable(struct drm_bridge *bridge,
> > >  				  struct drm_bridge_state *old_bridge_state)
> > >  {
> > > @@ -280,6 +311,7 @@ fsl_ldb_mode_valid(struct drm_bridge *bridge,
> > > 
> > >  static const struct drm_bridge_funcs funcs = {
> > >  	.attach = fsl_ldb_attach,
> > > +	.mode_fixup = fsl_ldb_mode_fixup,
> > >  	.atomic_enable = fsl_ldb_atomic_enable,
> > >  	.atomic_disable = fsl_ldb_atomic_disable,
> > >  	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
> > > --
> > > 2.43.0
> > > 
> > 
> > 
> 
> -- 
> Nikolaus Voss
> 

-- 
With best wishes
Dmitry

