Return-Path: <linux-kernel+bounces-233633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D26C91BA7F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 10:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DC161C223BF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 08:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC1814D719;
	Fri, 28 Jun 2024 08:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wCuThPYa"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B6514D6E9
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 08:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719564996; cv=none; b=Gi6gEvVPDEhBl+z4Lecxw/sGs5MNFvfvMRXadLZt8pdYxkv3sIt2CcSMHIpigMcctON2BGipPmRgFj6eJfd4s04W2oCPc4/GKst6lgoN8IM08onDVQGJ0Nl9sRJaQAFICNsdfWkxujvtvsvKvwLve2Qg7dWW12SdMjo3rc/homg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719564996; c=relaxed/simple;
	bh=FF4+D0PGWlh0IHOd7VsCwU6mYFinCXspYRIP9HSpwpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5wlzLbhB09QxkE1a+cHRIU9D1IWh59kXWZDXLe3Nx6bVgl+iucSEVewjwe5T/HpzlHFIh+2yobXtGNZJRaph+gLWbmKPTOkA/W/bCroW9x19RiptqtynzuIpyX9PkUMH7duBZzw0kWCzwZ1jBbfmiWU5ATRB1ymSTLL54rz+Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wCuThPYa; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52cdf2c7454so661509e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 01:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719564993; x=1720169793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G0/fXtxHzxiSZJyy61Hud7FSSfRF9PobKUFTEvqKe8E=;
        b=wCuThPYa30yrvRaSXSG+ljueTwGlcn16BVw2lKaNntlGwGmTQJoZT3XdZlGAZe62Hg
         PGTp+9HEMZKTtjplXYzyUtZfVeqDVROx0zgB8nUwpWjdYU4sSmwuzycSihG+LBVjeZi8
         5YdIY8a88Egy/YS69IkA4nUxuPuSbwg/fVXthAQvJBfbg2beRiWkx58AulLWJWHjk9YW
         XBB8fdDcAutnGc8W0Oeu8ZgJXgSFyoT/eeqyP0IVMXP2YckPpYtFkOYBqnNFOieeynnR
         pVeGrJp0rxcd5cJTcgfYBc5q7SmvMTIO5ztHoLmVz1ZGuQpF4IeQ39XygqFKmuK7I7xb
         YCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719564993; x=1720169793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0/fXtxHzxiSZJyy61Hud7FSSfRF9PobKUFTEvqKe8E=;
        b=lahxN1Y/AS6Lv0cB7Yn99iGrlaXXH4gBamvnUA05uqfX4eGllUd4aHzPYwNWATcy3R
         RbRcouxLzscFnSEHGcI5ErSTFF5t/ZhNidnbUDhWAgJlnO6UN6ORGdlQvtEB2pykWLDo
         S871ilQdwx0uYutj0+24BnrcvUOpUrktGlMrMwEDmJm8B6n2lyobeFZIwqtB4OTzbH9G
         /pyN7fVSa42sAck910gCY6u8hW+SJB79EyTVHTCAjF+HyUGGNzikzYEai3gSNMD1cFjN
         vAN4O6lTGu7IJVVEZ22zJz2qH37a0XNA4lPGcBzPY4l9CAjQyBcB9WpXdNx64cIzxEIZ
         JO1A==
X-Forwarded-Encrypted: i=1; AJvYcCU6qOb2xd15oTRPanNnGMMGbvPNi1EB+IzB4J0WiMnJnalTxrFKkkrPeKbnEhRg/uAuD5cVhsHLT/0emoAtwyW0Cb9C01buG6ocOt2B
X-Gm-Message-State: AOJu0Yz0q3WnN7x4dSJhgBCFmXLXaFsTXlOEUI91Qn7Ub2vl5kuH+416
	H1JIcmlOGB5kw35Zoqq73TCqDAtjVeh5xuXoJgLi9jhNj08YWWlcF00SAl1z65w=
X-Google-Smtp-Source: AGHT+IGyMkgUnh6bttOHSTc8HADwe9dEhAxSgr60CTSFMQWZlDbk/VecTjiLPbTW2itaDM+uq+3S3w==
X-Received: by 2002:a05:6512:ea4:b0:52b:c33a:aa7c with SMTP id 2adb3069b0e04-52ce185ced0mr15126638e87.65.1719564992926;
        Fri, 28 Jun 2024 01:56:32 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab2eabfsm211556e87.199.2024.06.28.01.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 01:56:32 -0700 (PDT)
Date: Fri, 28 Jun 2024 11:56:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Paul Gerber <paul.gerber@ew.tq-group.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm/panel: simple: Add AUO G104STN01 panel entry
Message-ID: <koapph3wqmkwovyjp4ms5flfbaoip642c3nzg5gt4e5czq7tal@pwy2o3zt45tk>
References: <20240627084446.3197196-1-paul.gerber@ew.tq-group.com>
 <20240627084446.3197196-3-paul.gerber@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627084446.3197196-3-paul.gerber@ew.tq-group.com>

On Thu, Jun 27, 2024 at 10:44:44AM GMT, Paul Gerber wrote:
> Add support for the AUO G104STN01 10.4" (800x600) LCD-TFT panel.
> 
> Signed-off-by: Paul Gerber <paul.gerber@ew.tq-group.com>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Tested on TQ TQMa8MPxL on MBa8MPxL.
> 
>  drivers/gpu/drm/panel/panel-simple.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index dcb6d0b6ced0..5eacd2085a53 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -1081,6 +1081,30 @@ static const struct panel_desc auo_g104sn02 = {
>  	.connector_type = DRM_MODE_CONNECTOR_LVDS,
>  };
>  
> +static const struct drm_display_mode auo_g104stn01_mode = {
> +	.clock = 40000,

Nit: could you please express this as (800 + 40 + 88 + 128) * (600 + 1 + 23 + 4) * 60 / 1000 ?

LGTM otherwise.

> +	.hdisplay = 800,
> +	.hsync_start = 800 + 40,
> +	.hsync_end = 800 + 40 + 88,
> +	.htotal = 800 + 40 + 88 + 128,
> +	.vdisplay = 600,
> +	.vsync_start = 600 + 1,
> +	.vsync_end = 600 + 1 + 23,
> +	.vtotal = 600 + 1 + 23 + 4,
> +};
> +
> +static const struct panel_desc auo_g104stn01 = {
> +	.modes = &auo_g104stn01_mode,
> +	.num_modes = 1,
> +	.bpc = 8,
> +	.size = {
> +		.width = 211,
> +		.height = 158,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
> +	.connector_type = DRM_MODE_CONNECTOR_LVDS,
> +};
> +
>  static const struct display_timing auo_g121ean01_timing = {
>  	.pixelclock = { 60000000, 74400000, 90000000 },
>  	.hactive = { 1280, 1280, 1280 },
> @@ -4434,6 +4458,9 @@ static const struct of_device_id platform_of_match[] = {
>  	}, {
>  		.compatible = "auo,g104sn02",
>  		.data = &auo_g104sn02,
> +	}, {
> +		.compatible = "auo,g104stn01",
> +		.data = &auo_g104stn01,
>  	}, {
>  		.compatible = "auo,g121ean01",
>  		.data = &auo_g121ean01,
> -- 
> 2.44.1
> 

-- 
With best wishes
Dmitry

