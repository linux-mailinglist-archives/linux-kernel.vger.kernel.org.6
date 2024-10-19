Return-Path: <linux-kernel+bounces-372897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B689A4EF1
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 17:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 249781F25D98
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 15:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912FD58222;
	Sat, 19 Oct 2024 15:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DQiasaRV"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BE3646
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 15:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729350129; cv=none; b=UJkED6W7PLUoXQsrjJycWW06ehC9gRnquIWurvdaz26nlb3PfqiDWsMUwcsrwDYWOygdizpoVnPZJcheO4d28tDZUsxiv3aAqbRH62F1e5jw1wMnK38SC4zUV3WwhdvE4dkt90UGE0bNeZQTmNDNoghphMvWFsTxP0XCuwJ6/ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729350129; c=relaxed/simple;
	bh=L81Uwg5QAwGyLWqG6oakgNAZY5JuTRVlih06p7pC4H4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMH80oQbfkVZry1T6/3Niv5glQgcbhJe2AuN6qavDXvx4c6pDlPw3jEKhdiZvZfb8X8+q/awoAX6mihVDxnO9/SsjCLFx2UJtz5H/ZtPZF3aCoQj9YDrd7RLsvgU+i/umNAK+5WbE/XcoGRx7bhHWahfuukCTaKM/1Z/RhxD4Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DQiasaRV; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539f4d8ef84so3298665e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 08:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729350126; x=1729954926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=guYBgtCfnmt51vtq+wHLI7UJ/djLSpHCurYx8X+7pZI=;
        b=DQiasaRVSMYgUnguOr1DZw2QanqcMplUL2uO36j/qTWPo79G/YwRYLtXVxqLK7A1o8
         OQvLhln4sQlBLijlEXlb/QE7oJp00Mt06M1X0rmENFayMicX/3mIoeuY5zc+Pt3mhBnd
         EdKnZWrRUkEP4jhvFCgfTMXIZ+xftRg/M3zAQA0TPktM0kViMYGtvzBuAKfckxWxEG21
         Ek2HthB+0G3MLJDeO8wfsft0VBkxKKfBF9uFgidFVAd1bqrM1GJ1M9UFsIj+aQiNigGQ
         g7HAaIXOwjZzRkf+v3RhLka4oKlcBKQouDLJNsqvUbqatd3zv7ThM38+Gt7Ac0XpEFuW
         tXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729350126; x=1729954926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=guYBgtCfnmt51vtq+wHLI7UJ/djLSpHCurYx8X+7pZI=;
        b=JlLDGADumQeJwPUkmJhVZjNZGNi9zn4SwyvBcB2GtKSEjJ6iQujhd6i7WVF7wRq/wT
         JZ3M1fw1nF59HAOlpvDsGmfdFuPkKoQSnKcC4ip5fDebl7wDUn854Wzyq6/z9Y7q6ff3
         vuwmY5rsbhelSJ91LYTucUBwUA75t6fBqOlYkCjfTgLCsSi431IhPTigyocwTKEBZuIo
         4mJaqn6A6GgRpQLs/LBCqGFlY7roa7O9S+nm2Ud8CVTfrGRGX1EjKls1QjHLkxAR3tQf
         sTLVM7FPGDvxYT7yZxItDibsZMDCiaH1565uFQDvCovpYgOy08oqfD4a99CMueE2Dx5L
         YAvA==
X-Forwarded-Encrypted: i=1; AJvYcCX+6vB7uZoR8rRmf5MRqMoD75Vo+7Vwq0w+ibidubJ5+zhkYVREiKIlpdPULwP2vWZYT1C3mOaCPV0qdG8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4k7pmDLxpTpzeZ6MjVa50/0Xxr1U/SYJmzokVO6hdNFCuBqbm
	//vr08lhBZpOCaroZahGFHxHfHfK0CYpp86HxhFLohEQFVE8ZFVL0W6Lka3cfAs=
X-Google-Smtp-Source: AGHT+IFbD6430EduLAIFbkBXC5OVAGAbpWnd5KeVwCBq+BGsG53L9SnFx86xDc2NemUuq1czLOzHlw==
X-Received: by 2002:a05:6512:b1a:b0:539:f2b9:560d with SMTP id 2adb3069b0e04-53a15512b16mr2803980e87.61.1729350125699;
        Sat, 19 Oct 2024 08:02:05 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a151b02e4sm552705e87.29.2024.10.19.08.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 08:02:04 -0700 (PDT)
Date: Sat, 19 Oct 2024 18:02:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Sandor Yu <sandor.yu@nxp.com>, 
	"andrzej.hajda@intel.com" <andrzej.hajda@intel.com>, "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "jonas@kwiboo.se" <jonas@kwiboo.se>, 
	"jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>, "airlied@gmail.com" <airlied@gmail.com>, 
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "robh+dt@kernel.org" <robh+dt@kernel.org>, 
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>, 
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, 
	"vkoul@kernel.org" <vkoul@kernel.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, 
	dl-linux-imx <linux-imx@nxp.com>, Oliver Brown <oliver.brown@nxp.com>, 
	"alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>, "sam@ravnborg.org" <sam@ravnborg.org>
Subject: Re: [PATCH v17 4/8] drm: bridge: Cadence: Add MHDP8501 DP/HDMI driver
Message-ID: <l27rc2lo4pt3mfwknjyy755li3q7vgqesoev25ulapwsenkkuj@w26ts47a2llz>
References: <cover.1727159906.git.Sandor.yu@nxp.com>
 <8bdf573bfd7e3feb45d7ccb53765a978a685ce2d.1727159906.git.Sandor.yu@nxp.com>
 <20240924-mottled-psychedelic-lorikeet-ef8f4c@houat>
 <DB9PR04MB945284B95FAE4FE127E6568FF4752@DB9PR04MB9452.eurprd04.prod.outlook.com>
 <wdelo4zco6v5qchdupfvbrqin4n7fyjyo6yaqbpfihdkkhceoi@ja4zxmhk5isq>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wdelo4zco6v5qchdupfvbrqin4n7fyjyo6yaqbpfihdkkhceoi@ja4zxmhk5isq>

On Mon, Sep 30, 2024 at 10:18:06AM +0200, Maxime Ripard wrote:
> On Sun, Sep 29, 2024 at 02:34:36AM GMT, Sandor Yu wrote:
> > > > +static void cdns_hdmi_sink_config(struct cdns_mhdp8501_device *mhdp)
> > > > +{
> > > > +	struct drm_display_info *display = &mhdp->curr_conn->display_info;
> > > > +	struct drm_connector_state *conn_state = mhdp->curr_conn->state;
> > > 
> > > That looks a bit hackish to me. We should probably provide a helper to get the
> > > connector state the bridge is attached to.
> > 
> > How about code change to followed, is it more clear?
> > 370         struct drm_connector *connector = mhdp->curr_conn;
> > 371         struct drm_connector_state *conn_state = connector->state;
> > 372         struct drm_display_info *display = &connector->display_info;
> > 373         struct drm_scdc *scdc = &display->hdmi.scdc;
> 
> What I meant was that I wish bridges had a way to get their connector
> pointer. It doesn't look like it's possible with drm_bridge_connector,
> and we don't have access to drm_display_info anymore.
> 
> I don't really see a good way to do this yet, so maybe that kind of
> workaround is ok. Eventually, I guess we'll have the scrambler setup in
> the HDMI connector helpers anyway.
> 
> Dmitry, any idea?

Unfortunately nothing significant, I didn't have time to look at the
scrambler yet. The platforms that I'm working with either do not support
HDMI 2.0 or require no additional setup there.

Regarding the drm_connector_state, I had to go via the bridge->encoder,
then drm_atomic_get_new_connector_for_encoder() and finally
drm_atomic_get_new_connector_state(). I don't like the idea of storing
the connector in drm_bridge driver data, it seems like a bad idea to me.

> 
> > > > +static enum drm_mode_status
> > > > +cdns_hdmi_tmds_char_rate_valid(const struct drm_bridge *bridge,
> > > > +			       const struct drm_display_mode *mode,
> > > > +			       unsigned long long tmds_rate) {
> > > > +	struct cdns_mhdp8501_device *mhdp = bridge->driver_private;
> > > > +	union phy_configure_opts phy_cfg;
> > > > +	int ret;
> > > > +
> > > > +	phy_cfg.hdmi.tmds_char_rate = tmds_rate;
> > > > +
> > > > +	ret = phy_validate(mhdp->phy, PHY_MODE_HDMI, 0, &phy_cfg);
> > > > +	if (ret < 0)
> > > > +		return MODE_CLOCK_RANGE;
> > > > +
> > > > +	return MODE_OK;
> > > > +}
> > > > +
> > > > +static enum drm_mode_status
> > > > +cdns_hdmi_bridge_mode_valid(struct drm_bridge *bridge,
> > > > +			    const struct drm_display_info *info,
> > > > +			    const struct drm_display_mode *mode) {
> > > > +	unsigned long long tmds_rate;
> > > > +
> > > > +	/* We don't support double-clocked and Interlaced modes */
> > > > +	if (mode->flags & DRM_MODE_FLAG_DBLCLK ||
> > > > +	    mode->flags & DRM_MODE_FLAG_INTERLACE)
> > > > +		return MODE_BAD;
> > > > +
> > > > +	if (mode->hdisplay > 3840)
> > > > +		return MODE_BAD_HVALUE;
> > > > +
> > > > +	if (mode->vdisplay > 2160)
> > > > +		return MODE_BAD_VVALUE;
> > > > +
> > > > +	tmds_rate = mode->clock * 1000ULL;
> > > > +	return cdns_hdmi_tmds_char_rate_valid(bridge, mode, tmds_rate); }
> > > 
> > > Didn't we agree on creating a mode_valid helper?
> > 
> > In fact, now I'm no idea where should add the mode_valid helper function.
> > 
> > In struct drm_bridge_funcs, it had mode_valid() and hdmi_tmds_char_rate_valid().
> > 
> > If create a new mode_valid helper function in struct drm_connector_hdmi_funcs,
> > Is it appropriate to call another API function(tmds_char_rate_valid)
> > at the same level within this API function?
> 
> I'm not quite sure what you mean, but a reasonable approach to me would
> be to turn drm_hdmi_state_helper.c hdmi_clock_valid into a public
> function, and then call it from drm_bridge_connector mode_valid hook.
> 
> It's a similar discussion to the previous one really: in order to
> implement it properly, we need access to drm_display_info.

I've sent a proposal, [1]. I don't think we should be using
hdmi_clock_valid() directly (at least not before sorting out the EDID /
hotplug handling in the HDMI Connector code) exactly because of the
info->max_tmds_clock. If it gets stale, we might filter modes
incorrectly. Also, I'm not sure if it should be left at 0 by default (or
in drm_parse_hdmi_forum_scds()).

[1] https://lore.kernel.org/dri-devel/20241018-hdmi-mode-valid-v1-0-6e49ae4801f7@linaro.org/

-- 
With best wishes
Dmitry

