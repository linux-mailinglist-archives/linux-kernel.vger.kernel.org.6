Return-Path: <linux-kernel+bounces-335836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D28F097EB56
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 14:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01A7A1C214E7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 12:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4871C198E6C;
	Mon, 23 Sep 2024 12:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ee/+bOlg"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C132E19882B
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 12:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727093257; cv=none; b=cUXJMhYXkwjqbAvKLkA3qmcsvFeo/VDu3PohP7+4bh6bqgo9sJ4KlfUAZQL0grEIQOO7GGdF0uYY6fMWL+rKuBlRd3vRz0DfiPdJuTri+Vuoy8o+7IJ5BgD6p7uZilfu5YI5QEYm4BzLUuOIF8q1IKe78JlDERH7NAeoTjiI9Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727093257; c=relaxed/simple;
	bh=jsFaJdRU7csPgLct8YOiSBbZklln8JKRpXIkrIMfqSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R395cuLON3YryICEfYYE6otsPUz/VTqelBqPqkWKHB7c4BvdkqyOJlefGoSMgjepNUOa77WQH8iBKxNZJpj7ZJbHGoFnpFmotn/gL9Ro2qptFxrB5aHmZhyMjf7HwE56JdO6ceiHzkgUOiEwu1zeV1iswWKkr1i/cbCFSx8Iww0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ee/+bOlg; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-535694d67eeso4395639e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 05:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727093254; x=1727698054; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uITKFHsG45qX3SEwmrkI/jlizm58nr2czIUA71r1rLY=;
        b=Ee/+bOlggqqWZZQD8Vvt6P0k7vw8x581oEIfPJlJaZbkby4om2nnQgikhb93zFtAJZ
         vMDL/KYOgUrQ+cgaLpOSAR7dJ9yhdNYzX3MAkRxgM4clCSl8sjtJsLbpdtp1DpHuqB0z
         OeJ5hy7RCE1XAa8OpNFmmVsbqrGTeJvSLvpwp8bXX2glwVhhs2RyfBMXi5ia3bcH9kU3
         1QlyrnTnNcFUcbsCdNYHouc+lZAV2Fhgg9Wq/Df5WsrngfkIn3ixEqPYXa6lvlcDfRsu
         pzJdDKUQIJDdKE5Krk9RsRW4yaa86qx0krzHBKIYv54SzAXoJvVY60gNimJld/Jg+YMG
         f3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727093254; x=1727698054;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uITKFHsG45qX3SEwmrkI/jlizm58nr2czIUA71r1rLY=;
        b=rNwGQZ1iI5VRDRYQFcq0Cr1qaMIeufvYe/1ySFskmh92lgbxKyWcuEMcKb6NjUzhyR
         eqSFG4DUkapWQXyiFBMN44MzlLKPFMybQ0svThqO2nDLTixPYlrPBvPU1xo0Fkc1hLjM
         iQH7tG+O0k4xDqh8d5RV9eYDONW2Yf3WD+CQ7WQWiqikibK1rcNJabXg0MG/XHJyMiwu
         6xOJm1imMqd41Q4L3YdphH+nwR+qEQZ1y4eVuhFnvhR4tx3DcCLCNi0WybwiTihLVNm4
         qERfI7QtyyDQu8GtrtwY2RI6ljY3eDomVwFC2HnVqP3GJYknx+BcdzNdKRh0yTA79tOc
         cEKg==
X-Forwarded-Encrypted: i=1; AJvYcCUGzfGEpAHyN90B4Fk2yvav7oWKjY3stwqcVmJlGBw5JIHGzaB95OUx5erWBBx/2pUGXiiRYdGCaEeLGzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwUV9d2ezyh+lwx97vM0BEqLpO0yVZOu9HilmTMjMRMk3xX70J
	mRC5IpUmTm8ISjVZrlrobI4CY1Yxigu6cBMvvkS/aei8nf3Bx/AP+1xDWZZhMks=
X-Google-Smtp-Source: AGHT+IFNx3alq9qp6GjujjWykYrIjuZcFpCTCcLn/Id2delQNZ6kI974LK25jq1p/gKrcRDCvi7/GQ==
X-Received: by 2002:a05:6512:281c:b0:535:5eb2:5281 with SMTP id 2adb3069b0e04-536a563e90bmr4901526e87.17.1727093253748;
        Mon, 23 Sep 2024 05:07:33 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536870b8ee6sm3249990e87.296.2024.09.23.05.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 05:07:32 -0700 (PDT)
Date: Mon, 23 Sep 2024 15:07:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: zhaoxiong lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, sam@ravnborg.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	simona@ffwll.ch, dianders@chromium.org, hsinyi@google.com, 
	awarnecke002@hotmail.com, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] drm/panel: boe-th101mb31ig002: Modify Starry
 panel timing
Message-ID: <ovmleeivshtixncuxwv3dink6l4fi242rcspklicl3u4qp73rx@km3nu4co4hen>
References: <20240915080830.11318-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240915080830.11318-3-lvzhaoxiong@huaqin.corp-partner.google.com>
 <CAA8EJpqC5tQ45gj8-0bDutinCs7CoxiQVL1EAzwDK9RJTXYMcQ@mail.gmail.com>
 <CA+6=WdR6+nh9e2HCuCVdR6uw3vuJoWfKCG4gPjJMp9db+Quimw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+6=WdR6+nh9e2HCuCVdR6uw3vuJoWfKCG4gPjJMp9db+Quimw@mail.gmail.com>

On Mon, Sep 23, 2024 at 05:22:20PM GMT, zhaoxiong lv wrote:
> On Mon, Sep 16, 2024 at 1:15 PM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > Same comment as the one that I've provided to the other patch, plus:
> >
> > On Sun, 15 Sept 2024 at 10:11, Zhaoxiong Lv
> > <lvzhaoxiong@huaqin.corp-partner.google.com> wrote:
> > >
> > > In order to meet the timing, remove the delay between "backlight off"
> > > and "display off", and reduce the delay between "display_off" and
> > > "enter_sleep"
> >
> > Separate commit, separate _justification_. Why, not what.
> >
> > >
> > > Removing variables: display_off_to_enter_sleep_delay_ms
> >
> > This phrase is useless.
> >
> hi Dmitry
> 
> As in another patch reply, in order to solve a black screen problem,
> the delay is reduced.
> The panel spec:
> 1. https://github.com/Vme5o/power-on-off-sequential

It should be described in the commit message(s). You have removed one
delay and added another one. Is that a single fix or two separate fixes?

> 
> > >
> > > Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
> > > ---
> > >  drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c | 11 +++++------
> > >  1 file changed, 5 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
> > > index 0b87f1e6ecae..c2d0ec199829 100644
> > > --- a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
> > > +++ b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
> > > @@ -29,7 +29,7 @@ struct panel_desc {
> > >         bool lp11_before_reset;
> > >         unsigned int vcioo_to_lp11_delay_ms;
> > >         unsigned int lp11_to_reset_delay_ms;
> > > -       unsigned int backlight_off_to_display_off_delay_ms;
> > > +       unsigned int display_off_to_enter_sleep_delay_ms;
> > >         unsigned int enter_sleep_to_reset_down_delay_ms;
> > >         unsigned int power_off_delay_ms;
> > >  };
> > > @@ -184,12 +184,10 @@ static int boe_th101mb31ig002_disable(struct drm_panel *panel)
> > >                                                       panel);
> > >         struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
> > >
> > > -       if (ctx->desc->backlight_off_to_display_off_delay_ms)
> > > -               mipi_dsi_msleep(&dsi_ctx, ctx->desc->backlight_off_to_display_off_delay_ms);
> > > -
> > >         mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> > >
> > > -       mipi_dsi_msleep(&dsi_ctx, 120);
> > > +       if (ctx->desc->display_off_to_enter_sleep_delay_ms)
> > > +               mipi_dsi_msleep(&dsi_ctx, ctx->desc->display_off_to_enter_sleep_delay_ms);
> > >
> > >         mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> > >
> > > @@ -275,6 +273,7 @@ static const struct panel_desc boe_th101mb31ig002_desc = {
> > >                           MIPI_DSI_MODE_NO_EOT_PACKET |
> > >                           MIPI_DSI_MODE_LPM,
> > >         .init = boe_th101mb31ig002_enable,
> > > +       .display_off_to_enter_sleep_delay_ms = 120,
> > >  };
> > >
> > >  static const struct drm_display_mode starry_er88577_default_mode = {
> > > @@ -302,7 +301,7 @@ static const struct panel_desc starry_er88577_desc = {
> > >         .lp11_before_reset = true,
> > >         .vcioo_to_lp11_delay_ms = 5,
> > >         .lp11_to_reset_delay_ms = 50,
> > > -       .backlight_off_to_display_off_delay_ms = 100,
> > > +       .display_off_to_enter_sleep_delay_ms = 50,
> > >         .enter_sleep_to_reset_down_delay_ms = 100,
> > >         .power_off_delay_ms = 1000,
> > >  };
> > > --
> > > 2.17.1
> > >
> >
> >
> > --
> > With best wishes
> > Dmitry

-- 
With best wishes
Dmitry

