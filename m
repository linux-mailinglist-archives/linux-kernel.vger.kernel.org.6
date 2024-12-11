Return-Path: <linux-kernel+bounces-442310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AA79EDA71
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43C5F28262D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FD01DD885;
	Wed, 11 Dec 2024 22:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CMXTdhTN"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FD4195
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733957665; cv=none; b=leB0qyJroWO5kUvZ+2d2UHyxbQBq6MtYXSvx05UfWHrf1E9E68G/yQ2tm1b2nsfCjarxYOl8h0eh2VfT6pTpf1QX8FkSKXWDav0P700A8gexSJhdXkq6N08zXi98imEkMzdyiLO2m5lbvGNRVVN4UxfhTs8vZC33kk3+K66VBLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733957665; c=relaxed/simple;
	bh=SDI061vXr1bXjeVvB4yWoqqSZ3UUm8tPpjRbBRy6MiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2pRf0/qP7em2V9LAK7By3D53IwWkssMp+DiOKb/Cw+OkHRNS7X9cLGFWg3V0UNzNqt6jS+16sLV+/UDAwPsSXiLik9WkManmE8HzpL3t4lT02t494TUAq+sDqXKsIUDNlgJkGokxIM8QR4JYkdjaqDWuNLWX+cNA8mJMKgx9Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CMXTdhTN; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3003d7ca01cso48300311fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 14:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733957661; x=1734562461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wFlcrcuOuJge6epCV9BrB4p6q6J+XOMRFHObrsI8uJk=;
        b=CMXTdhTNs+WJKCbiL9ch7cnKnC96HeItCoJjUz+nCYU2BL0PCGkP42vU9M3VOT6UYR
         6ciR4A3T4l+MqXy5vURpIF/b2eF0xi7oGKZLji39gO2H59awY+jJWSt4o+kAjAaLepQJ
         TEZ76XCiUIvl3r2ypMroJJTNJx6D77ucl2EwaNjp2OXOBaKt7COYWbXt9xEBns9vBTta
         BPGc53Vz6MbEr3czlcjsYGneZc+Ksl75RmtjInB5rMgrm6xUrKA79xVDxh2INPb4ynK8
         kMFcJqJ3laYpxpNXbmUbGXidGUh4ZaeGD6K1Oa5D78Av3f2+5NaZQerBsq0U2EHkm3ix
         drnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733957661; x=1734562461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFlcrcuOuJge6epCV9BrB4p6q6J+XOMRFHObrsI8uJk=;
        b=wORH+AIsjJXHRvsAkwicVHUMsiAXZyupmoB1uGRTrA2AA8GyCW/7xAcdtJRiOeQApW
         YbYK4qTx9R6FSUxtwWa8/9X7+Jul18gpkDrQFJ3+SK6L1Z04csIdKjgoRSs8a+XzdnxZ
         2k5L4+RyYxLZE+YoRIVhOaZ3XY3T55rOD1MQQBaZOAjMyOp1H7fq7GUjDrXEYugeDlF6
         eIswEW9LlJyW+qQOztXszpp6nfSF8d8x8Yb/geC+TceEgSgX1PpNwCsLIM6SatqfMiii
         xHypp/HLQC9cpjG8SEwv4p7fK0CWGz56TmXhnkhHXeYSkklssBjk5QPGCVMQWAiX/ikE
         VECQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRAAARyVaNVN6gwa9AgENJQOQQojyd//iqb9lIFFr6Kgw/wvMBgQrOzXBHn7OhrYznAXExb2qU8mSD+II=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa9cd2J8uYuT9qtqOK5kYmsec+I9sAyU08Vjy5rEAlvofWPvd0
	Jug/+yelErYtX/Pu8jftjt6RDyqPY6V5VuH7+ApZM8yZE5dvdVRDO7RDCUTBWpQ=
X-Gm-Gg: ASbGncvXBKvxUKbslnPyoSiYcmcRwePi0BNsyREWwvQ27ZzjpCll1tBXuP7qt+d1BAM
	osigXgaw1N6ZF3memPXJw2prsz4ePA3L6pY8VQPxFwIyLZS6Xy0qCbqeizQKD9DtBo1i7HvDorv
	6rcP4W4M6iPTQJXVPbkztmy0Ln/FKdzd0F8g97XU+iSKWs08VGbSnrXIZrYf4rmcI5eyP24GY2q
	vo4hcTLPwr5iGOneDQCa+g4KcRqCqaEPXAqYfTMd1/VVtu0sVWZ2SOj/EdFpghPpkHwb/z5bxTq
	O6LBRgJWydUJdF5paPXy179ypFlNx+AO3w==
X-Google-Smtp-Source: AGHT+IF2beMPPMfOHzFimzjUPxZBuU5TVMSgXepIkr14Wvtkhl9EzlpO//mQAjLbZ5PlDOZrQQhhMg==
X-Received: by 2002:a05:6512:4022:b0:540:2122:faeb with SMTP id 2adb3069b0e04-5402a605bc8mr1358587e87.50.1733957661382;
        Wed, 11 Dec 2024 14:54:21 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5401a5360bcsm1378389e87.174.2024.12.11.14.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 14:54:20 -0800 (PST)
Date: Thu, 12 Dec 2024 00:54:17 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] drm: bridge: adv7511: remove s32 format from i2s
 capabilities
Message-ID: <ctecu2iqn4nsm2wy45ca7vt6bdj5334wafnyq32quaydjs7yf6@x4avipho6xcf>
References: <20241210134254.2967524-1-olivier.moysan@foss.st.com>
 <20241210134254.2967524-3-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210134254.2967524-3-olivier.moysan@foss.st.com>

On Tue, Dec 10, 2024 at 02:42:53PM +0100, Olivier Moysan wrote:
> The ADV7511 chip allows 24 bits samples max in I2S mode, excepted for
> direct AES3 mode (SNDRV_PCM_FORMAT_IEC958_SUBFRAME_LE format).
> However the HDMI codec exposes S32_LE format as supported.
> Adapt ADV7511 HDMI I2S format list to expose formats actually supported.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>  drivers/gpu/drm/bridge/adv7511/adv7511_audio.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
> index 28ae81ca3651..ce6eda87bfe0 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
> @@ -232,6 +232,9 @@ static const struct hdmi_codec_ops adv7511_codec_ops = {
>  
>  static const struct hdmi_codec_pdata codec_data = {
>  	.ops = &adv7511_codec_ops,
> +	.i2s_formats = (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |
> +			SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S24_LE |
> +			SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE),

This will break w/o patch 3. Please change the order of the patches so
that after each commit the kernel can still be built and work correctly.

>  	.max_i2s_channels = 2,
>  	.i2s = 1,
>  	.no_i2s_capture = 1,
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

