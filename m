Return-Path: <linux-kernel+bounces-175183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A028C1BD3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 02:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 450D6B2107F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 00:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB8A1FB4;
	Fri, 10 May 2024 00:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bBqbZYPp"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB7F173
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 00:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715302571; cv=none; b=uw8v6CouiQEvU+JeZ5GCpqeHJ9jgnnrR2mWSbmDD8aSZrzzHkVx8PBegaJTBjsa2N3A5rJ3jF7Mkvd5LMG6PBTilxUIjm2nnjn9+a8rKRia1DYn1PqxFLBzpiGkr/ppj6UX57Nw6vXPxcNns20P4gg1u0Nt6WFVMnlsSStQPf88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715302571; c=relaxed/simple;
	bh=epH8GYzjkuUGau3B3Pcs2RzpwmWTn5EGiER102tL/lU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgvZlt7i7p2/dWIGbF6/vjarKRC7SQLeeBV5edNE5Jo2QKRqba6+qj/0DO0SFqjygzLfrHXp2GZ/jImHoxOflxBBl6j9Ez2Rr0YW+yW7Be6FnfpkNdX/iqekDz+s1wyLBm/OcRNSrjmCvYkgrCMYSx8PosuckKidpulyw14jQ/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bBqbZYPp; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51f0602bc58so2390671e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 17:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715302567; x=1715907367; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lXqP1Ltv+f2Bj5fMlF5qjaDyVYcHhqES0nW1HquL4V8=;
        b=bBqbZYPpBvMcHZvQvHrWJTaB9yq05ekOR2vU5pdNycE2lRMblPMTdHbvFVC60c15Xb
         7Of/JpNRkgnLLvrCLe9M0EVbc9El9+Q5TTHBg+osMOlEbcY6o9mgEfc9xNOOQUNuCmzr
         mijOMkuh/Nkx2hi3wvnCE9/xQtDfvoGShDhFArwl4aqpaXAygz4WBQSx8USEvUIqC7x7
         NiAXM5I1roxq14B3AeOXjv0v8DIjrSiDx8EX96cfX1h5I3FvepMRBANaXzEKaJgtqhFw
         R4Fh7/xqVDG2iVlLHODthxKAZ7ewU0mux9sRJ4MdMFPydbRMUhX0Uauw8ru4IasQN3IG
         KMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715302567; x=1715907367;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lXqP1Ltv+f2Bj5fMlF5qjaDyVYcHhqES0nW1HquL4V8=;
        b=BtxHONnhaZG4P/2HBdAxXN9H7THsnCdG/qIHrnfPPrDA3GosbVgof8TH9Viz16QGX2
         /NPdNiqcuqX+KVmIpR7UPDYdHP/JpsqS1jg39jSLirMU+tt2KW35dij72ngwTuRws3yT
         sLweIYFeM6pD0Tfh7VcImzvc+fXBAdaXuPO8lrHrTJNybRTFlxbYb47U05gwL0bSV+g0
         Yu/6qgT249/UR4fWGnyOOH2Xlgs0XEgXHQYo9jy9Ry0AFiII1cl4NS0jRjmFjBCFus1e
         wY//M6m1xO+zYEEQ3OKvwoJqSDKJAiNN4dzrciYy3S4RMGYoRPMSOOatob9S4ANLbrEi
         +BWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXikNJfwgW3cXjN5dcfS8Lj1pU7YrSYuCOiMCAH1EjIrX+PzZLbYzzo530bHZi5xzKfX4gqsBURKtTy4DrxMgmhFyMyZsYRjj2LMhZi
X-Gm-Message-State: AOJu0YzFcUBQNeJk33xqO5EVWk0TyPszvQnwwb91C86OCWGsw0s2XEeo
	flcpuCfyUQdt6lm6W7ZD4BoItyJ06AM8AY3n4g9syzNAYPywmRJhcegOWOCYbPU=
X-Google-Smtp-Source: AGHT+IFoZTY4mV6hLkPNd/kgjZ7IP6+sOZ2PGQRzw2JpMkjYwk/CdOhvAaxKg1w2k0ngX+YIi0IDUg==
X-Received: by 2002:a19:8c46:0:b0:51f:9a88:be2a with SMTP id 2adb3069b0e04-521e126c339mr1231384e87.23.1715302566866;
        Thu, 09 May 2024 17:56:06 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::8a5])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f35baacesm491795e87.90.2024.05.09.17.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 17:56:06 -0700 (PDT)
Date: Fri, 10 May 2024 03:56:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <trabarni@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panel: jdi-fhd-r63452: move DCS off commands to
 disable
Message-ID: <rpita5o6za64p7tamasssb2fja6h6ipr5cibh6gs7klkijyk6r@mausrcet2ycx>
References: <20240509-jdi-use-disable-v1-1-5c175b2ea1ee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240509-jdi-use-disable-v1-1-5c175b2ea1ee@gmail.com>

On Thu, May 09, 2024 at 08:14:07PM +0200, Barnabás Czémán wrote:
> Move DCS off commands from .unprepare to .disable so that they
> actually reach the DSI host.
> 
> Signed-off-by: Barnabás Czémán <trabarni@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

I don't think this is correct. If the driver sends enable commands in
prepare, it should be able to send commands during unprepare too.

> 
> diff --git a/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c b/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
> index 483dc88d16d8..f7222974d6ed 100644
> --- a/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
> +++ b/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
> @@ -169,6 +169,15 @@ static int jdi_fhd_r63452_prepare(struct drm_panel *panel)
>  }
>  
>  static int jdi_fhd_r63452_unprepare(struct drm_panel *panel)
> +{
> +	struct jdi_fhd_r63452 *ctx = to_jdi_fhd_r63452(panel);
> +
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +
> +	return 0;
> +}
> +
> +static int jdi_fhd_r63452_disable(struct drm_panel *panel)
>  {
>  	struct jdi_fhd_r63452 *ctx = to_jdi_fhd_r63452(panel);
>  	struct device *dev = &ctx->dsi->dev;
> @@ -178,8 +187,6 @@ static int jdi_fhd_r63452_unprepare(struct drm_panel *panel)
>  	if (ret < 0)
>  		dev_err(dev, "Failed to un-initialize panel: %d\n", ret);
>  
> -	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> -
>  	return 0;
>  }
>  
> @@ -219,6 +226,7 @@ static int jdi_fhd_r63452_get_modes(struct drm_panel *panel,
>  static const struct drm_panel_funcs jdi_fhd_r63452_panel_funcs = {
>  	.prepare = jdi_fhd_r63452_prepare,
>  	.unprepare = jdi_fhd_r63452_unprepare,
> +	.disable = jdi_fhd_r63452_disable,
>  	.get_modes = jdi_fhd_r63452_get_modes,
>  };
>  
> 
> ---
> base-commit: 704ba27ac55579704ba1289392448b0c66b56258
> change-id: 20240509-jdi-use-disable-ee29098d9c81
> 
> Best regards,
> -- 
> Barnabás Czémán <trabarni@gmail.com>
> 

-- 
With best wishes
Dmitry

