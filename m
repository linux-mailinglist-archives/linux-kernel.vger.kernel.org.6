Return-Path: <linux-kernel+bounces-436338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 903CE9E8495
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 12:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B12C1884ABA
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 11:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0696142E7C;
	Sun,  8 Dec 2024 11:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N8Cvh9HY"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4027602D
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 11:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733656016; cv=none; b=Yn3akUCpIfo9fKjcLGU+y5YwigLui0LuDr7ql4e3ATShqTuuWaBNPjsdIXXd2vFpLZq5tlfy0xScvUbrGoZzLTQ3ey5q0uDWjEdFaN2b9F1nfBKDUZ5D38+4xmEiXOJfA93fS47OwbLQGKR0iooK4j5uNUUP+dJOdFA1fkUWYbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733656016; c=relaxed/simple;
	bh=PwAoSFiz15fssqKwl/0oxPB7GVuAPX1ERfj0WmPEonY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmigOAKvoE+/P9TIla9/TxqkvDChlaHn3BXb6OE32N3uUbDK/ouH11nvgqikvDnS/kbBaxlgTe6xjNhUzGwvwQtQp3/bKy8uqr5ZGye8moHpubBugEPGA2EKjnhZtfiwGpvGe4S99QqEdNvL/XP4J9WEwtqY15g64Egh7e4No9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N8Cvh9HY; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5401be44b58so257068e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 03:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733656011; x=1734260811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MgmDh4KwwG/UnaAkdqryGTFKEgNCKuqZpZNBZIAjct8=;
        b=N8Cvh9HYjOM7os9dakPUFmWU37sZ9uMar2If0sPtqzirnBKChKJ7NbeQFUbJMSzboT
         uUL+B92hZ9pnMydkgzrDQbHeFe8C+L05VxUUKQ6sK8Q1DpVhkN2uhLuySDwuhDzaDcZH
         KSA+pXaZiXfE32FV/7JyDlsFqMSwKyfQ9jyVCW8l4JVmz/x43Brp0Xr40Ik31HhEBF2C
         v3ogZ4LBQ3q0P2E0WArFzvjjyOWUMQ9zJMHhbew9vwli89l8aLS4F+daqD2owh//uLWu
         ZNtfFTlwAo1qQl58aXqI6mtoLZ07so9DcLfXWk6VjGfAzLVZot6Xtu9FLQ3fxtTJbXnJ
         Q3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733656011; x=1734260811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgmDh4KwwG/UnaAkdqryGTFKEgNCKuqZpZNBZIAjct8=;
        b=SADoZAVrkWasSTV6mEHhQjxj6tO0baYhkVtXhvSdNOo+wyKMWkhxaZvt/gvS2zGKHh
         K22mMA7DYh0IRW6Whpvyg9ZX360CV/OUGWt1T5WbCuNKZsCGarkUXgqGgHx3Yuq+qe1d
         4Iiv8Q4XbWv5t7AU8Ffj7pjJ0qxbHfNLh7AAQ6I8HyhACAeMQQ/992og9Zz6n38sbi0h
         5QGtlwUjg/IW1uugAAZTS9JXzH86n75zx8Nz93H4GRohiRTxzriBelPv7ETBpRJT0Kiy
         Ap19x8jaIk5fqFw/Xx0/gjD6VJ2EPuYd2xPh5Do8Ipwdubl+nNzTY2WHR8/nUqDcxRWT
         qpsA==
X-Forwarded-Encrypted: i=1; AJvYcCVU+2jfcnpVwzbOnWnv+/VH89zTmqx3cYdhb3AkcTkLVAinRNwb/LFFxorjU6BS/9y20A3B4l1UVZls0Qs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ugfNYRuTf3Zgt57Ga+7Lh7I3rvVwV0N1OGM5P9uN7hZSo3HW
	3W2rv0hKebhDz1K71cqzk/yJeNqGWVhcHkmYHpskTf73uoZ0LGbhlEVhLDrvzv0=
X-Gm-Gg: ASbGncu3GPJ5vDIi54QodIt814duK4dPNy600A6LBu4WEkPuKf0EK4u7VPI2twdVa0O
	GT654AHExXpti/GYYumphSXlScgBMh1+puCYqxBS40Rau4MoLL1/HBDGZIDmZcyqKlTOcgON66+
	2TLcpm2Ebz8D4/XoK+1aGh1idabFGkGb6G/LJrnOYaWSARfa5uGWhvqC3CchYlvEOfExnVC5M6k
	qG77Gugk7VYeUq7JrQFhOFC84k6acozjkAqvjjY4erljZhmXN9e6bM+MYceUN8gqsKfwcwx/mOq
	GUJm1GI3ML4znqt1X9OnCJJbCq0o6g==
X-Google-Smtp-Source: AGHT+IF5QEJjlcVoMCHYbEL9bkvB8NPE0fGP+5uB3Gu8Bcq90JNJIBJcqtP7X6LzerdMng+XvLTRkw==
X-Received: by 2002:a05:6512:ac4:b0:53e:3a43:9245 with SMTP id 2adb3069b0e04-53e3a4393c1mr2104284e87.28.1733656010740;
        Sun, 08 Dec 2024 03:06:50 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54019dc9a76sm309093e87.274.2024.12.08.03.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 03:06:49 -0800 (PST)
Date: Sun, 8 Dec 2024 13:06:46 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Phong LE <ple@baylibre.com>, 
	Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Russell King <linux@armlinux.org.uk>, 
	Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sandy Huang <hjc@rock-chips.com>, 
	Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>, 
	Alain Volmat <alain.volmat@foss.st.com>, Raphael Gallais-Pou <rgallaispou@gmail.com>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v6 09/10] drm/vc4: hdmi: stop rereading EDID in
 get_modes()
Message-ID: <73xdxb575n4ncmadffkwqzczoewbadq3forpvqt4vp7zfln2nq@o2wmbbbepwgg>
References: <20241206-drm-bridge-hdmi-connector-v6-0-50dc145a9c06@linaro.org>
 <20241206-drm-bridge-hdmi-connector-v6-9-50dc145a9c06@linaro.org>
 <20241206-caped-proficient-rattlesnake-c882f3@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206-caped-proficient-rattlesnake-c882f3@houat>

On Fri, Dec 06, 2024 at 03:34:52PM +0100, Maxime Ripard wrote:
> Hi,
> 
> On Fri, Dec 06, 2024 at 12:16:03PM +0200, Dmitry Baryshkov wrote:
> > The vc4_hdmi_connector_detect_ctx() via vc4_hdmi_handle_hotplug()
> > already reads EDID and propagates it to the drm_connector. Stop
> > rereading EDID as a part of the .get_modes() callback and just update
> > the list of modes. This matches the behaviour of the i915 driver.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  drivers/gpu/drm/vc4/vc4_hdmi.c | 21 ---------------------
> >  1 file changed, 21 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> > index e5ab42f72f618b90f956482db6c9c8074c1e3bf1..3364ef90968dad3074800f02926300ffceb75c69 100644
> > --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> > +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> > @@ -470,31 +470,10 @@ static int vc4_hdmi_connector_detect_ctx(struct drm_connector *connector,
> >  
> >  static int vc4_hdmi_connector_get_modes(struct drm_connector *connector)
> >  {
> > -	struct vc4_hdmi *vc4_hdmi = connector_to_vc4_hdmi(connector);
> >  	struct vc4_dev *vc4 = to_vc4_dev(connector->dev);
> > -	const struct drm_edid *drm_edid;
> >  	int ret = 0;
> >  
> > -	/*
> > -	 * NOTE: This function should really take vc4_hdmi->mutex, but doing so
> > -	 * results in reentrancy issues since cec_s_phys_addr() might call
> > -	 * .adap_enable, which leads to that funtion being called with our mutex
> > -	 * held.
> > -	 *
> > -	 * Concurrency isn't an issue at the moment since we don't share
> > -	 * any state with any of the other frameworks so we can ignore
> > -	 * the lock for now.
> > -	 */
> > -
> > -	drm_edid = drm_edid_read_ddc(connector, vc4_hdmi->ddc);
> > -	drm_edid_connector_update(connector, drm_edid);
> > -	cec_s_phys_addr(vc4_hdmi->cec_adap,
> > -			connector->display_info.source_physical_address, false);
> > -	if (!drm_edid)
> > -		return 0;
> > -
> >  	ret = drm_edid_connector_add_modes(connector);
> > -	drm_edid_free(drm_edid);
> 
> I don't think that works though, for mostly two reasons:
> 
>  1) We're not sure we'll even have an hotplug interrupt if the system
>     boots with the connector plugged in for example.
> 
>  2) afaik, the get_modes ioctl directly calls get_modes too.

I think both paths use .fill_modes, not get_modes. And fill_modes
explicitly calls .detect / .detect_ctx. It would be nice if somebody can
verify the change on the acual hw. But as I wrote, i915 driver does
exactly the same: the EDID is read / updated in .detect_ctx(), while
.get_modes() only performs drm_edid_connector_add_modes().
Okay, there is one significant difference which we should probably patch
out: the .force() is also implemented to update EDID in the forced case.
I should probably do the same for the drivers being handled in this
patchset.

-- 
With best wishes
Dmitry

