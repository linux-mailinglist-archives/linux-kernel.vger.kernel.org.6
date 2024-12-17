Return-Path: <linux-kernel+bounces-449328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AECE9F4D41
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28A137A82D0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111C71F7071;
	Tue, 17 Dec 2024 14:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UQCTsnao"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33E71F540D
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 14:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734444598; cv=none; b=FmqEHRnF8eCCVWYXhI693SntMy5PJwa6OmHZi/IPgtU9V20I8D24ETrHCASS2/inVJeK4dTKwcT3mGX6vEu8uBkmF6sb74vG2iJfPVmUr7GCp2QrYh2kaVvFTkXD+vvciT52uBf97sVhJ/M31YAlB1CHqaYulYMAsprK3Ksit4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734444598; c=relaxed/simple;
	bh=DTVaSDi1vlTbB2vKF1jfNBqEXNtrKAZiazfohZg5+fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNjY/LF2Fn9gmG2YU+KZdcTgkhQDYZezJtP+cc6XI8BLQ1o12z+/3ud5YjbNDcVfPmncC+uqLr64ojnoLHoJOThWbXMdNYVFbsabjLh3u7UBzZEiX2TfyB6HX8yQwiw3DnAgmhc3ex3KVOpinxMAuAp3PPl+pwRtZd4sLyl1+AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UQCTsnao; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-540215984f0so6013691e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 06:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734444595; x=1735049395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mV9n8rD9lCXVFxHRKSb6HxnIcMmuUp+M9EhLoSWf19Q=;
        b=UQCTsnaoIPaghcR45Bn6jeRU4UIGXrAhQVeWxbySq/rKYvxCz4DHWGNLI56MnoIht7
         VAy2umfmf1+pGUBgRrAYv3KM11db/AHKiFnc0QGM8AjnGaHZ0wLZ1qDIEsXkew4nlcwl
         vvR2Llp+MqcunvR+fDAT+LfRQH1+zpmPzyaA4XHMrb7ysk/WKrU7QAcknFyo/OjEa8LV
         mkPJ8NJE385KgNpDVvLenhqmCsmlUy+jaAGDm4GXD094UFAErm8h4a7fccEFsvEFwMvu
         7ygZwwUSpAf36JhkK2X3TM8wxJR7I+F1vs0jWV+XtkdGX/FOl3bE2FNW9Tomk5Lwd/FK
         iNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734444595; x=1735049395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mV9n8rD9lCXVFxHRKSb6HxnIcMmuUp+M9EhLoSWf19Q=;
        b=ssM+lY6dFUVRkYmg/jOgcAG66CM+dfBWpiQIxS1fWzHTfitLpupOLTt448r6rZmPpZ
         fjVREeColEZR4o3g5sB6gqFZjJJgqLXD/i9lrf6LzP0vGi6gnuDMEAq1nwKPjC6W6uLB
         iPhj0w6DWo0D2vQMpPy4g1ifHqerf5hFjh43tjqlAa+oTtL1DzrlaGMI/TPFZCFQ1Mvq
         1uGxpuE7JRq8DKvZJdah4Ji2aYfDn1TPJMpKyEA9td338Lely2+QfeFdUHk9anVF9BFc
         TMbMr2r9OTajry5ag1g+0PfPBdRYeCfs7pa80T7G6Db21jvIgX3P1TzmsgPOUEWheeW6
         KEaA==
X-Forwarded-Encrypted: i=1; AJvYcCWq2yWLjZ2IpRwe/38gogbaC9aLRjC/PQiyUWhnPQlu/VU9M7Wp6z5yPsiL8HxNVof+1Eoc5Kam+HeIa8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOM+F/Aki+VoHuQJ+ClTziRwfClru7OT626rrjMXUhB7WW7Rvk
	BHVqj1ilUAwpTZkGKWnI7dFtZr4aMD5mAkOPqmeujdNt/H6OUtRyzt5sUErfgH0=
X-Gm-Gg: ASbGncsF6sm5NbWVFDb7AJC7Biu+gIlVtH7ATZIRwtKvfOu7mLPnpon8O0pwJWrS76T
	sHtaJJpL4ptQWoznF0Xisnp0necpM4//VyXXVBYD7mMyPhhVWXmriN2/hO461HhQTEO4NzBHeXX
	awkvI1LxWErWnzKJZoQnWP2j5ctskUhe/ujADkU8sOBFXEJizUXIyxQShF/w1CvDI9qIZ/OLsQN
	zKKWmrSIQLn2uv73eCMw/t3TSuARF3CxEm9Nkv/lNHB8EmrqI+o/jA+8BT6b9duKCEHTkQoquMa
	JOAhSSixQYBtS1FPs8kYpjg4AjafkyEyJ8+T
X-Google-Smtp-Source: AGHT+IHTf5dvyD0mHW1jS/2vTroVhCSJd6opzQzzWVJuSVJWGrT5Dsv7wwpXGqTnNzyEJctFejbUSg==
X-Received: by 2002:a05:6512:3189:b0:53e:3a01:cf4d with SMTP id 2adb3069b0e04-5409055dff5mr6856692e87.31.1734444594653;
        Tue, 17 Dec 2024 06:09:54 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120ba9dcbsm1166017e87.73.2024.12.17.06.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 06:09:53 -0800 (PST)
Date: Tue, 17 Dec 2024 16:09:50 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
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
Subject: Re: [PATCH v7 00/10] drm: add DRM HDMI Codec framework
Message-ID: <kyytu3nofrjkajwatmxdyav7oekkeigrhx5amddgjtlpsdl2m5@3moqad3gfds5>
References: <20241217-drm-bridge-hdmi-connector-v7-0-cb9df2b6a515@linaro.org>
 <D6DZB443IQ7A.3P1135M6DMF2S@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D6DZB443IQ7A.3P1135M6DMF2S@cknow.org>

On Tue, Dec 17, 2024 at 01:36:29PM +0100, Diederik de Haas wrote:
> On Tue Dec 17, 2024 at 1:40 AM CET, Dmitry Baryshkov wrote:
> > This series depends on the ELD mutex series [1]
> >
> > [1] https://lore.kernel.org/r/20241201-drm-connector-eld-mutex-v1-0-ba56a6545c03@linaro.org
> 
> There's a v2 of that patch series here:
> https://lore.kernel.org/all/20241206-drm-connector-eld-mutex-v2-0-c9bce1ee8bea@linaro.org/

... and it's even merged to drm-misc-next. I dropped it from b4 deps,
but I forgot to update the cover letter.

-- 
With best wishes
Dmitry

