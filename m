Return-Path: <linux-kernel+bounces-334944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D204D97DEB0
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 22:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73E95B2150C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 20:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4E53D556;
	Sat, 21 Sep 2024 20:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l1uNoTzD"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428B7179BD
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 20:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726948944; cv=none; b=pXhJLDkf7jXX3nHL65qG2zgkGZ0MQxztV1inh67EjzYwLj9wzuZfwMpTdx7aOpxPxA4VhSBdPETjr0pkuT9bspFrv6g2Zu36Cr8UA53CC8W2b8OXpH/Ur9ATEm0St1Seyj2lhMkfa36gY7u4uYECZJSMKSiGgbaL0i4ogiUJPkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726948944; c=relaxed/simple;
	bh=cw+QtSHhLrewoprxKaGC5OJwziVpW/LTgWb1hcd7w68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uILpzq2UHr2d8yCRccdnNu/MpLR7+jP7/bty8yjK/+GLwyyPoISLuLP+beb1j3zpebvfcQXcUQoNeOGPhzwnP9cgopZm2Z+UAYKIABJ5tCIapNzIgz7l8VQU3qoLCyeABOdENm//y0fUmRyGE6QHwmT6grgYrtvpsduFUnBkpns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l1uNoTzD; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53661ac5ba1so3251478e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 13:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726948940; x=1727553740; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kTuF7VDXjW3MP//Do+X4ZOnzlFNZp1xwHs6Kru9/7Nk=;
        b=l1uNoTzDKlcyw7rNg7NUPCt5RMMzphJ7GaVIZx3RfZz+SXpl0NqvZMTNys5yjCj1Vj
         ORXgRkgr+zd9CkZTrXo9UamuMFgzV1QvmppY4+kgBG6M4mieRYMWftqdfCouWGcn5l5h
         Lp3lsq/GCn3VNcoZVx0ztnG1yeppUivbUex3+fnVJOP3CCxmfzUPqwDi1l0qUb0hfz/q
         +UhZC2+E0m8mU2hHeUl8SVUERF0BXIaSsc3W8mh9rHebYte7Csb9qPK95epd9k0h4fEX
         uLiMOwpPP7YYA555ccwW9c395YsAPTmg3eaG7y3/5LY1Ae8NPBA4pe+lyzhOo4i6unwo
         zB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726948940; x=1727553740;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kTuF7VDXjW3MP//Do+X4ZOnzlFNZp1xwHs6Kru9/7Nk=;
        b=lpa1OlvcY76gywHXvHnuFcQDlU0JZuIF5Z9MgrcYqxzB3y+1kt/06g1CYzsxHlwDbJ
         JnU9/XcHpZaVip0cypYdyoLJQJRQVsDq4xz4CFPtaTuCucT+7gCjqacZH37KUEIeSJij
         avz8mVxT+mO1YzI6Fv6eSz8Uuqaua7FSvzkfCLa/lUNpVGcbvu6egiy/CEuK4tgM6XjQ
         xH44ddeDZikFnf9YZ9ma0baZB7lvFhFeyyEblrNBjdSidexxmz6hBdUMtWLQOa91/m/Z
         40yzRQ+xO/jt9+z25xsGHUUjk295YfRlZa29jMX7+g1S0OC+lVuXZHe3fFH3a03GshBZ
         M1bg==
X-Forwarded-Encrypted: i=1; AJvYcCUbirF+kgAYY6qwcR3/xrpuniIjOUkBhjGQj0+DDbzHsBdhAr1L6h7fHymydvvl7eEpdEDXsb/Q43QAqV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBFNDzkZ1BaKnQC3+DJlhhsA5ck5zGV454X8S5/O1icEkv4mVs
	pCfpivTn0tbe3HwFbk2VaxUb8t/i9jaR3AbagCaYUdheWqS/kdvktruIoTZxVlM=
X-Google-Smtp-Source: AGHT+IEDzyk+nJzl32SGwrI75keSU5xM11P46cZbubinLNPy/qZYltSBZ5PHAiu73gulR1QeFvg7+g==
X-Received: by 2002:a05:6512:114b:b0:52b:bf8e:ffea with SMTP id 2adb3069b0e04-536ac320139mr3789472e87.40.1726948940203;
        Sat, 21 Sep 2024 13:02:20 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536870b8cc0sm2685207e87.271.2024.09.21.13.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 13:02:18 -0700 (PDT)
Date: Sat, 21 Sep 2024 23:02:16 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: tjakobi@math.uni-bielefeld.de
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	=?utf-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>, "Derek J . Clark" <derekjohn.clark@gmail.com>, 
	Denis Benato <benato.denis96@gmail.com>, Hans de Goede <hdegoede@redhat.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drm: panel-orientation-quirks: Add quirk for AYA NEO
 2 model
Message-ID: <gnllphvuffajfbh3aczda5z7t3ytjexf5a6wuuzsz6pla6e2kz@m564uc2ogn4q>
References: <cover.1726492131.git.tjakobi@math.uni-bielefeld.de>
 <2b35545b77a9fd8c9699b751ca282226dcecb1dd.1726492131.git.tjakobi@math.uni-bielefeld.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b35545b77a9fd8c9699b751ca282226dcecb1dd.1726492131.git.tjakobi@math.uni-bielefeld.de>

On Mon, Sep 16, 2024 at 03:18:51PM GMT, tjakobi@math.uni-bielefeld.de wrote:
> From: Joaquín Ignacio Aramendía <samsagax@gmail.com>
> 
> Add quirk orientation for AYA NEO 2. The name appears without spaces in
> DMI strings. That made it difficult to reuse the 2021 match. Also the
> display is larger in resolution.
> 
> Tested by the JELOS team that has been patching their own kernel for a
> while now and confirmed by users in the AYA NEO and ChimeraOS discord
> servers.
> 
> Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>
> Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> ---
>  drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> index 2166208a961d..3044927c0c5c 100644
> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> @@ -184,6 +184,12 @@ static const struct dmi_system_id orientation_data[] = {
>  		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T103HAF"),
>  		},
>  		.driver_data = (void *)&lcd800x1280_rightside_up,
> +	}, {	/* AYA NEO AYANEO 2 */
> +		.matches = {
> +		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYANEO"),
> +		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "AYANEO 2"),
> +		},
> +		.driver_data = (void *)&lcd1200x1920_rightside_up,

I thought that AYANEO should come after AYADEVICE, but the array doesn't
seem really sorted. Thus:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

If I hear no objections and if noone beats me, I'll apply the series
within few days.


>  	}, {	/* AYA NEO 2021 */
>  		.matches = {
>  		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYADEVICE"),
> -- 
> 2.44.2
> 

-- 
With best wishes
Dmitry

