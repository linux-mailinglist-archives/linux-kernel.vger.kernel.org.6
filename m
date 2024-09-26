Return-Path: <linux-kernel+bounces-340096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E17986E83
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51E551C23C2A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7442145B10;
	Thu, 26 Sep 2024 08:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A8bChklp"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6604A1C6A1
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 08:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727338035; cv=none; b=tsSFPAer8qbYdF/8MrkaC40vv14YMWKIXBw6ZGsZkhOopYMrZbI1l6yOhawkrB+u+02mu70+/tyUb3gocEgtaz1Wn+d3kkisZVhAgBGZRlMK4Q+hmdRbJ3ERK8s8EKn9KVyXjolbSR1tG8vuJb3ic7YZnFk7fwsxczCH8eTkYfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727338035; c=relaxed/simple;
	bh=GA3cZN8ozjGkz+owpD+9KyfzOLIloLO2AfCfV5QOsw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcPLSHcEokB/S5A0SgBUFIUGf9mHQRFLj3uQmqe/Aq25NH3NgqM3eN54zqjrav0CAOg1hlfWbR/fnxRi4UVRsTGfnIjvOX06iFOPWhrlp4+8kUKwlO9eTDQza0/K69S08+iTnyOfU7620EQ/GkceBCPw6craFWUlezxFYHFuBc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A8bChklp; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f77fe7ccc4so7704811fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 01:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727338031; x=1727942831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qcdZF6UL2UXjFioy7LxFleeVQgy9EQrE3cGYWKNYiKA=;
        b=A8bChklpdc1LtBwJxsFEEYREendj1H2e+CHiYYUHOY1wk1jyQEAql0cTUVey5kuwD9
         hRhoGMkJsjEyF5wtiB3rAZlqIikQTKWw4RLvKFi2uGofP55F/Nrf91rjZW0QM5xntSfH
         9sTE9Z3tFD1JL0aGnCLF/KYOfP7HTvt2wkx0d8UdpRASRII0PnyggOJ31OrXX94jRvV1
         AWgqi2DPq69Ojjb8EYPEY1Vn+ejISu1moBiwoW/oGqN63I9BrWn+XIqkwSsEv1y3CG0M
         JnZJRwNvgP79iOy2gb2uL+BxKy4n4c/KUdGw4abiWRoXQO5V2czA+CT+6TlNlwco/qCV
         zXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727338031; x=1727942831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcdZF6UL2UXjFioy7LxFleeVQgy9EQrE3cGYWKNYiKA=;
        b=LMJZLT00EVKgxut1/rLSuAm3pKnrE11hrpFtcg/gD1bz94aU2LYaUR5sSGenfYEPFk
         sdCjWvIl8vxXy+oyTnXNtmZqCGdYTxyDCxZfJtRgWuB5Mn2MoelYuZTSiuPzsuAPibu0
         rf96cT/+2OJqfob6nnT3ZjY0e435N+x83GPEOJQJaF22ijlQA7doD3D6y5Zi/3clMrqU
         2wtkHx1H4fz8TE/If/QqJ65Z0y2CDm/IUr+WY87QfH/d8weUvr6WG72GoO61T+hjO+hV
         4LrQ/Qet2j0quAxLqTcK92vdmu262S/n3hDJunGGADvkzZBFbCMHENn3seonV2gRjS3E
         BNNQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8r0A3gzHhy1WW07rcgdlswkeC1sc9DL3/1rO+/hsix4ed/FWglbgiZcldCI2WyIzKisQWopu86TEaPDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLrCJzlYtUKXvyio9fL4Stwy010ccO5S0YC4HtBgJaSMpUlvea
	o4dLUMu4XlGW++QeWocNWIyUU+Lml3k/5QZHH0ZIZxnuxMHWmRKFM8TeIN+DRRE=
X-Google-Smtp-Source: AGHT+IGxp5j7kEG4FZr2p9qw6+rAb8iblxhC96ppPWbog+IP2oHA+mgvxre4KxK20PKOjaCpfzsqxQ==
X-Received: by 2002:a05:651c:19a9:b0:2f7:603c:ef99 with SMTP id 38308e7fff4ca-2f915ff8578mr38803891fa.16.1727338031383;
        Thu, 26 Sep 2024 01:07:11 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f8d288e1d5sm7511261fa.90.2024.09.26.01.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 01:07:10 -0700 (PDT)
Date: Thu, 26 Sep 2024 11:07:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Hermes Wu <Hermes.Wu@ite.com.tw>
Cc: Kenneth Hung <Kenneth.hung@ite.com.tw>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Allen Chen <allen.chen@ite.com.tw>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 05/11] drm/bridge: it6505: increase supports of HDCP
 repeater ksv devices
Message-ID: <xyi4czye2dwqmh6iaschacduwxm52oaipbt5ulvlmalamkzwbc@6gt5endjo6gl>
References: <20240926075018.22328-1-Hermes.Wu@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926075018.22328-1-Hermes.Wu@ite.com.tw>

On Thu, Sep 26, 2024 at 03:50:14PM GMT, Hermes Wu wrote:
> From: Hermes Wu <Hermes.wu@ite.com.tw>
> 
> A HDCP source shall support max downstream device to 127.
> 
> Change definition of MAX_HDCP_DOWN_STREAM_COUNT to 127

This results in struct it6505 growth by ~0.5 KiB. Please mention it in
the commit message.

Is it really required to have sha1_input in the constantly allocated
structure? I think it's a temporary data, which isn't necessary after
processing.

> 
> Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
> index d1f5220e04a6..5d5ce12cd054 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -296,7 +296,7 @@
>  #define MAX_LANE_COUNT 4
>  #define MAX_LINK_RATE HBR
>  #define AUTO_TRAIN_RETRY 3
> -#define MAX_HDCP_DOWN_STREAM_COUNT 10
> +#define MAX_HDCP_DOWN_STREAM_COUNT 127
>  #define MAX_CR_LEVEL 0x03
>  #define MAX_EQ_LEVEL 0x03
>  #define AUX_WAIT_TIMEOUT_MS 15
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

