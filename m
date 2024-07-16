Return-Path: <linux-kernel+bounces-254097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BBB932ECF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97F8FB22F2F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 17:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B537219E7D3;
	Tue, 16 Jul 2024 17:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tw8pRxu0"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F8F12B7F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 17:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721149282; cv=none; b=OpkshkIA4GDDesJUWkRm1DjTJTttdt4g4vNTzav/2NRvkGEVEzB58r1xEvHA6e5PB3qrIgrPU1Sh/7p1JQhQIbNdIs+jtzZQ2WvGK5TgdF+lT1/u6hFJO5unPA0iyFTb3KWapCTcuwxEOTLyeNVPEEgPUdpfHcpSzkAlAzBYfK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721149282; c=relaxed/simple;
	bh=aMqJugMTKIuXb5RuRQqKniLGa4G7WSQsOWUcC4fy8uA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQl5k0EN2GPK4Fk261fAupdSlTr+ItuuU0/J2QyVNqQIeL6MZPwlJIEHOiiNfRdTMqchsZq+/ZgTRr3wSiDPTbL2dGnYMTF+MfO1nvjZZYxHf3tk0Ecl0g0bJ4YjMXyz0tKq1yxUyjK4mUTrDCv9vX2xIEMaBO9lN1quoH6uZxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tw8pRxu0; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2eec7e431d9so74631581fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 10:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721149278; x=1721754078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ojyLoEn72jNNSfiPNc8alfjrCiqwwyPI9yuQ8RPWAmY=;
        b=Tw8pRxu0HehXoPsdyCG43cQWM5NqfwrNbmhkDYjZvwXMZ1+yybAYqS4BR68P5T3mQO
         OuTE9aEY+3OBD9ygUGG6PYx8ooar+AHQ4J/6SMHN/Da0w+GK5Op8aupRzqryWIJ7hYgv
         t9Cqal7SDPwr3XMGTI03lFfbfiYPAoj8ow0N8vcr1/vql2aMbLRrZK27HBV4ZPYNPPJc
         D1nszUKf39nEJdlHsbwSFpCzUsMuws+Yr0Os9JQyy72PdNwWZXKnGaTJXzBs8CvVBBwh
         Yj66DH+/VGaIcR+WWvtoSL9ON5p7AmsgqOGGGXP4yxsfZK2u2UlP/M61Ge67nWACnfBc
         riiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721149278; x=1721754078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojyLoEn72jNNSfiPNc8alfjrCiqwwyPI9yuQ8RPWAmY=;
        b=mU/PZjoG7gUGnQ5irmnXqAINIVg2FwJonJjWCBsrkQ6hj522X2LTu9Ceyfb3Ta72DK
         TG8y6NiDVXw7aiAiCe9kH0gEJmpgtFrnOY4Tn6KM/sKEPOXXW4mbp0kLVL/4hKqSi0TE
         AY7WK+jiVi89UtWOY3V7BG2jlXzjjwI2tkkXMHER8kC8nQS5xn+G7mSWS/EXFYXwJm+k
         loqJetfIWJ+UTa+rPOAof0B1PoCLpmEPsC3/S0EnBw/QSgBpdOgvScB+wIOY8stZ6d4F
         pQKfsRSG/JEiCSntQ2CBpRjGSEGchMfvesOD/XcgIGUVN3xifYyrqXOV8iBfBcMe8Cwb
         xYXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWizcaOui/nvu9UZuNAh+w+DpKwuXosY3DdiUyFwQzFP1KN91bg7W54hp2HFNW8n11XFSPTQ5XvIEMAFS8fQxf8c1/cqqlPccZ17ym9
X-Gm-Message-State: AOJu0YzMW4PIMMcwSLhLHs62MU6GJ70AiSZQ/n4s3A9zKHynei/vACTU
	ZgZQSOB4AmlOEOzwHYWDAAc94J6ZZYDVHdnaLIcqcXk94Q7u2ackP7Xf75xYJ2TP5K+F+wxjjnf
	+
X-Google-Smtp-Source: AGHT+IHiCpiwO8rjZ0htUoeJgpfV/+P+mkbfZbe70bQAoD70zJuFqjvQXKFf8ezzilfK8kEIP12apg==
X-Received: by 2002:ac2:4c52:0:b0:52e:9762:2ba4 with SMTP id 2adb3069b0e04-52edef1eb90mr2131099e87.25.1721149278075;
        Tue, 16 Jul 2024 10:01:18 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ed252d6cesm1197833e87.149.2024.07.16.10.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 10:01:17 -0700 (PDT)
Date: Tue, 16 Jul 2024 20:01:16 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, dianders@chromium.org, airlied@gmail.com, daniel@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/mipi-dsi: Introduce macros to create
 mipi_dsi_*_multi functions
Message-ID: <p7fahem6egnooi5org4lv3gtz2elafylvlnyily7buvzcpv2qh@vssvpfci3lwn>
References: <20240716133117.483514-1-tejasvipin76@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716133117.483514-1-tejasvipin76@gmail.com>

On Tue, Jul 16, 2024 at 07:01:17PM GMT, Tejas Vipin wrote:
> Introduce 2 new macros, DSI_CTX_NO_OP and MIPI_DSI_ADD_MULTI_VARIANT.
> 
> DSI_CTX_NO_OP calls a function only if the context passed to it hasn't
> encountered any errors. It is a generic form of what mipi_dsi_msleep
> does.
> 
> MIPI_DSI_ADD_MULTI_VARIANT defines a multi style function of any
> mipi_dsi function that follows a certain style. This allows us to
> greatly reduce the amount of redundant code written for each multi
> function. It reduces the overhead for a developer introducing new
> mipi_dsi_*_multi functions.
> 
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
>  drivers/gpu/drm/drm_mipi_dsi.c | 286 ++++++++++-----------------------
>  1 file changed, 83 insertions(+), 203 deletions(-)
> 

[...]

> -void mipi_dsi_dcs_set_tear_on_multi(struct mipi_dsi_multi_context *ctx,
> -				    enum mipi_dsi_dcs_tear_mode mode)
> -{
> -	struct mipi_dsi_device *dsi = ctx->dsi;
> -	struct device *dev = &dsi->dev;
> -	ssize_t ret;
> -
> -	if (ctx->accum_err)
> -		return;
> -
> -	ret = mipi_dsi_dcs_set_tear_on(dsi, mode);
> -	if (ret < 0) {
> -		ctx->accum_err = ret;
> -		dev_err(dev, "sending DCS SET_TEAR_ON failed: %d\n",
> -			ctx->accum_err);
> -	}
> -}
> -EXPORT_SYMBOL(mipi_dsi_dcs_set_tear_on_multi);
> +#define MIPI_DSI_ADD_MULTI_VARIANT(proto, err, inner_func, ...)	\
> +proto {								\
> +	struct mipi_dsi_device *dsi = ctx->dsi;			\
> +	struct device *dev = &dsi->dev;				\
> +	int ret;						\
> +	\
> +	if (ctx->accum_err)					\
> +		return;						\
> +	\
> +	ret = inner_func(dsi, ##__VA_ARGS__);			\
> +	if (ret < 0) {						\
> +		ctx->accum_err = ret;				\
> +		dev_err(dev, err, ctx->accum_err);		\
> +	}							\
> +}								\
> +EXPORT_SYMBOL(inner_func##_multi);
> +
> +MIPI_DSI_ADD_MULTI_VARIANT(
> +	void mipi_dsi_picture_parameter_set_multi(
> +	struct mipi_dsi_multi_context *ctx,
> +	const struct drm_dsc_picture_parameter_set *pps),
> +	"sending PPS failed: %d\n",
> +	mipi_dsi_picture_parameter_set, pps);

I'd say that having everything wrapped in the macro looks completely
unreadable.

If you really insist, it can become something like:

MIPI_DSI_ADD_MULTI_VARIANT(mipi_dsi_picture_parameter_set
	MULTI_PROTO(const struct drm_dsc_picture_parameter_set *pps),
	MULTI_ARGS(pps),
	"sending PPS failed");

(note, I dropped the obvious parts: that the funciton is foo_multi, its
return type is void, first parameter is context, etc).

However it might be better to go other way arround.
Do we want for all the drivers to migrate to _multi()-kind of API? If
so, what about renaming the multi and non-multi functions accordingly
and making the old API a wrapper around the multi() function?

-- 
With best wishes
Dmitry

