Return-Path: <linux-kernel+bounces-448246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FE39F3D6E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 23:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17811188F6EB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 22:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539ED1D618E;
	Mon, 16 Dec 2024 22:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ki6o7Y22"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D102A1D61BF
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 22:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734387897; cv=none; b=CKbLjlpCK4auieW02XWLTmWie07owk3ZyZkQasP5KuudIOd3mBRaHjGmLdcYIOH2cSrAmSogOl/3tlKb0KeFjpC4NVwsuvcg7vQz8+i48PCHaDDWbIHTfLy12ytTnMJJI54daXNCZsrwUUzUjTmd/sV6LLp1U1z+tCKPGjDOzB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734387897; c=relaxed/simple;
	bh=Gigplh9uNnG2VybEpHpX1m/kbyDyOv21lQUSjXfIiGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmBqA8i7IoYqmWrVIsemZdWYCV7QbId7/WHFIWHtRmv52mPt2AyHB+wlbF0ow1xq3R0U1UQm9U14KPBd4GQ21bY2tV/WOdIv+4/O4jL+wyF8/qzvDmE1yEw+wNCbWIOJmTPBq6RahpvK7zJn2bd/tXHLB7TX9LZv6DtsLNyt800=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ki6o7Y22; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5401bd6cdb7so4741872e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 14:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734387894; x=1734992694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4lUKNdC2kAAGBCwC8ulcU+ZnvIc3yXrgdr0jrnZTuug=;
        b=ki6o7Y22vheRHceEJn+jysciejPloQ95plf5J+9O8L5QLPpYbS7g44AH6Cp6GhF343
         n/V6/Svx3awplh5uV7Kz5N8MNQ4APd1BWEE0ZLvlj+shM8C9N4eHFiNOL8GklKn9JFys
         gJmPASwwbI4SWM+19dPV0kubGAnvF77LmQm1p0Nhg6xjB7THk1BtdzDw8W0obQl/Vd3x
         k3Lvm5O2TFv4ABhPlWDjp4zPYIgp/+DG7k7U0gHKMALb1QD60Xjbi1/6ExkQxHTG6YsZ
         kuiCcgTEyektOK/C8EQp9Bt6Ret0SKzNj8pA1XXYGE5XUCpQgquJoZB7OfGmmfBlkj0R
         k2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734387894; x=1734992694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4lUKNdC2kAAGBCwC8ulcU+ZnvIc3yXrgdr0jrnZTuug=;
        b=dLHhQ/Dq4XXCCKWK1E1vYmVy/9fqk4LilRB9QSiFsAVVZJAs2oR6jqFlM6jL1ubckP
         ldu7Vb4qNkUdrlsam0k2oRBmz0Ck+TqZSqwO8m2ip/C7DYAFtf2Fjm3NHOSZPHnH6AN2
         ha9Q7AYM/bMzwzc4ol/XpVM9pG3FAfv5gd+N3fyFc+fo49XVFk+ykxsrAjTOIpXufn4j
         XXSKRpgyr4uVjn+9lwZXySZvUlkOcQmjWraGZsmtw4QfOl7dhrct/PVGHp5MLh6o7EMl
         WVNddlrKLRg6M0iwEb/vH9vd5XdaKb2UBUrOvDqLWkjtQMqiyK0qcYlG6RMUdqO4a6iT
         zj8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUToYBPyWOYhExY2G5adw+Mcz8m012feubUyYeRzFigB/LBkr8TWH4slLJAbz1aGKQMlpZQKKVWhz5u+AA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5dJNGFfznGCuhKu53RUrJ5/4/wOi8YXxBwMEdhIq9FYsG7hpU
	E8T+L59Uon4DwiTZd8zkr22DqLr8Dv+oPA+prmaG1ICtZ8L/r7Rg1ezO0DSGaD0=
X-Gm-Gg: ASbGnct0aRNo66QYq2DxwI248XRfAao4oo/cayW6b2ArYQd8coz1/jidCgvgfbKtoP0
	S0hxZDKmPH+n0gdEP9HH4YWgf5Kw/oSQ8AuphYE7eZ8F9jGLaj6AdD6KMcZI+u5b1fQmpT8YTlr
	jjx77udnIxsT5ZL28W1mNN9Qn8i1jgFr1/WU7ScMF+dkB0eD0j+OLTfAK2dBw+nZB106bQYG21I
	0Mzu/zl0eOo8MuK4Yx02IYp8LSHJ0dm/m4mlE1foCsHH28aEMkJ18epzM41hfux05a0hG07WGr/
	J0XAt2ldV6wXvhyYybZ8Ydn0bAXoKqU4TjgO
X-Google-Smtp-Source: AGHT+IGeM80+qzSI85ogwxR7TJc35MFGjDldBmFT9FD2cLdQVLMDcDnI76ZKZkotwpop5fLoExBoFw==
X-Received: by 2002:a05:6512:3b89:b0:53f:afae:7364 with SMTP id 2adb3069b0e04-540905a6f62mr4232404e87.40.1734387893905;
        Mon, 16 Dec 2024 14:24:53 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120bffd77sm972047e87.136.2024.12.16.14.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 14:24:52 -0800 (PST)
Date: Tue, 17 Dec 2024 00:24:50 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Paloma Arellano <quic_parellan@quicinc.com>, 
	Douglas Anderson <dianders@chromium.org>, Stephen Boyd <swboyd@chromium.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/16] drm/msm/dp: split MMSS_DP_DSC_DTO register
 write to a separate function
Message-ID: <6nt7cacoik4nxbjpgpidmovzilxf7q2gld64ch2p7ltatkzl4p@sg4ltm7jt47c>
References: <20241216-fd-dp-audio-fixup-v4-0-f8d1961cf22f@linaro.org>
 <20241216-fd-dp-audio-fixup-v4-6-f8d1961cf22f@linaro.org>
 <9fb5986b-f375-4300-b50c-92bb9c0b4399@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fb5986b-f375-4300-b50c-92bb9c0b4399@quicinc.com>

On Mon, Dec 16, 2024 at 11:46:21AM -0800, Abhinav Kumar wrote:
> 
> 
> On 12/15/2024 2:44 PM, Dmitry Baryshkov wrote:
> > It's the dp_panel's duty to clear the MMSS_DP_DSC_DTO register. Once DP
> > driver gets DSC support, it will handle that register in other places
> > too. Split a call to write 0x0 to that register to a separate function.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >   drivers/gpu/drm/msm/dp/dp_catalog.c | 8 ++++++++
> >   drivers/gpu/drm/msm/dp/dp_catalog.h | 2 ++
> >   drivers/gpu/drm/msm/dp/dp_ctrl.c    | 2 ++
> >   3 files changed, 12 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
> > index 7b7eadb2f83b169d8df27ee93589abe05b38f3ae..354ec834f9357c4797fc08a4532e69acc67b4317 100644
> > --- a/drivers/gpu/drm/msm/dp/dp_catalog.c
> > +++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
> > @@ -1039,6 +1039,14 @@ void msm_dp_catalog_panel_tpg_disable(struct msm_dp_catalog *msm_dp_catalog)
> >   	msm_dp_write_p0(catalog, MMSS_DP_TIMING_ENGINE_EN, 0x0);
> >   }
> > +void msm_dp_catalog_panel_clear_dsc_dto(struct msm_dp_catalog *msm_dp_catalog)
> > +{
> > +	struct msm_dp_catalog_private *catalog = container_of(msm_dp_catalog,
> > +				struct msm_dp_catalog_private, msm_dp_catalog);
> > +
> > +	msm_dp_write_p0(catalog, MMSS_DP_DSC_DTO, 0x0);
> > +}
> 
> This is already done msm_dp_catalog_ctrl_config_msa(), this is either a
> duplicate or redundant.
> 
> void msm_dp_catalog_ctrl_config_msa(..........)
> {
> 	**********
>         msm_dp_write_link(catalog, REG_DP_SOFTWARE_NVID, nvid);
>         msm_dp_write_p0(catalog, MMSS_DP_DSC_DTO, 0x0);
> }

The chunk to remove it got squashed into a different patch.

> 
> > +
> >   static void __iomem *msm_dp_ioremap(struct platform_device *pdev, int idx, size_t *len)
> >   {
> >   	struct resource *res;
> > diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.h b/drivers/gpu/drm/msm/dp/dp_catalog.h
> > index 6678b0ac9a67881244884d59487fa288d33d1be7..08bb42e91b779633875dbeb4130bc55a6571cfb1 100644
> > --- a/drivers/gpu/drm/msm/dp/dp_catalog.h
> > +++ b/drivers/gpu/drm/msm/dp/dp_catalog.h
> > @@ -92,6 +92,8 @@ void msm_dp_catalog_panel_tpg_enable(struct msm_dp_catalog *msm_dp_catalog,
> >   				struct drm_display_mode *drm_mode);
> >   void msm_dp_catalog_panel_tpg_disable(struct msm_dp_catalog *msm_dp_catalog);
> > +void msm_dp_catalog_panel_clear_dsc_dto(struct msm_dp_catalog *msm_dp_catalog);
> > +
> >   struct msm_dp_catalog *msm_dp_catalog_get(struct device *dev);
> >   /* DP Audio APIs */
> > diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > index 9c463ae2f8fae916661fef1c7e225f55c1026478..b9c461fee96f8fae9259ce03a32e1155b42d17bb 100644
> > --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > @@ -2011,6 +2011,8 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train
> >   		pixel_rate_orig,
> >   		ctrl->panel->msm_dp_mode.out_fmt_is_yuv_420);
> > +	msm_dp_catalog_panel_clear_dsc_dto(ctrl->catalog);
> > +
> >   	msm_dp_ctrl_setup_tr_unit(ctrl);
> >   	msm_dp_catalog_ctrl_state_ctrl(ctrl->catalog, DP_STATE_CTRL_SEND_VIDEO);
> > 

-- 
With best wishes
Dmitry

