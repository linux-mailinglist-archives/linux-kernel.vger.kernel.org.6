Return-Path: <linux-kernel+bounces-340064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0F4986E3C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24B1B2864A8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 07:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AEF1925A2;
	Thu, 26 Sep 2024 07:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vwDHolJV"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499A739AD6
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 07:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727337082; cv=none; b=KsmI4s1hcf2OFP+6wGUbQOzr39ObBYKwF8zIeu5PDjHKcWVRrqjCEHB0r+OWWQEigwe7ZcYB2i7iOWH3sq/4J07kkY+R7NcW1vLdH3/GxsxbSjsZ45VM0uMk7Zr/jMhvsuToCiZScbDWJX846bHTk+Nmg1dOE72wSpO5Rcb2Rio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727337082; c=relaxed/simple;
	bh=m3yk4PX4aDBnAGBazX/D7ESE0aEJmB06+3azJ3iYtvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IkGIjZSPn+lTAzqWUEho2H25PrtIXlv6hfckhj/zFq6DiUO95TlnQRxytvgfZ4Y59TsuUW5gV7TJtej9iTepKgFecAxP+1FlwUfoXvqxvm1+PJjoZgzsL5ecHwuyxOUXCqrzAbDwVbwhvGRt9F2kAJPGNgpZ/WcVNztcH/1VY6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vwDHolJV; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53568ffc525so842975e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 00:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727337078; x=1727941878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NHAvOI9KtDOsvvoP0nLPdvZRSpWG4zkKmMmJKwdeN1g=;
        b=vwDHolJVCsK8R3TcdQe3a6VUzfQuZ4GCaFx3mF9iMibGxhXXgFshH/mf4dvWws1KMR
         epHmO65Hv+8uu8qtfvqtKGqvd2CG4m1GPQZg3QCc8ymTcLbcewQB4/diKmAQudG2XjwN
         mNci1poEwN2u/SvIbCiXpwBsdy834HY9Bo9+ljbPPGVu8o765FojqjICDu6ont8H1CR9
         6rSS/uqvZ8a4LwXMOe0jZZQCAqCJ5CdBWXIlBs2cGe/QZtOvP8NyBwj6IwTPrXe5mZVX
         H2jPXEwhdHLeNVTU9bqIMxjOpyObaLoXkJ1j7EZ3PJxrBoKxZNuj5iJ2V0hN61JbREXY
         7nnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727337078; x=1727941878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHAvOI9KtDOsvvoP0nLPdvZRSpWG4zkKmMmJKwdeN1g=;
        b=iEqBm0duyzh3/r2YmabIvdnmyJCXebSKRJ6tUOzxsxKLiQSzxYxHg3ZOV8bFXm305Y
         Wyr2wUkPNDzXwacH69YBKpNS+s1wmvtuTwlRn0mothRYVd32uiARgRGAHA6zbJSOZLka
         s+paY9AILxLVQpHNeFaenV9hGD9hQfVDlnsVaNXHi0jVjQbZJWtTo9YUvs7u0CuxBv2T
         Vo1qiPfnxZ4Dp8Iww/aa2cU2+V2LgdRb6hYeP8/RYiLLClQm1za9iLe9CaPQ2BvhpcQY
         6LN0ElQpoLlC7mA3ont5Y/mJMfKZCbiSyqm7V1hj8X8PZXUFgFPQ+sU/Gt0+JtVHYyYN
         ZN+A==
X-Forwarded-Encrypted: i=1; AJvYcCUfHFN2b2bDBYY1ph3T5WqHJ55DliKltjcTUFsurfWAQl7CyzIVCqTOiy8wQsseDJA36ubkFG0HEBql7tQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiYFPY9T0TopONV1sVhSJLEGSWZucZYgkfiYAi4dBxG2kj9Chq
	rOyHKjKlk65+WlsNPcFw21TVNro/8FEmPbixzq7tY3mLw5G8Tqs1+IGMtGLqplQ=
X-Google-Smtp-Source: AGHT+IE+7m6XCC6v6ZYiN9hpBuRWnJx0f4RfFAHw9nxz2LmGjqyw0t5+Pl7rzPZhQiLQH5hnMVD8Bg==
X-Received: by 2002:a05:6512:3a8b:b0:530:abec:9a1b with SMTP id 2adb3069b0e04-5387049804cmr3430821e87.13.1727337078217;
        Thu, 26 Sep 2024 00:51:18 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a85e6356sm728310e87.89.2024.09.26.00.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 00:51:16 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:51:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Hermes Wu <Hermes.Wu@ite.com.tw>
Cc: Kenneth Hung <Kenneth.hung@ite.com.tw>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Allen Chen <allen.chen@ite.com.tw>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 01/11] drm/bridge: it6505: change aux max fifo size
Message-ID: <o4ecmdk52j46sa47cfah564b44rvwvebgf4fhegrefehghhve3@v6yrj7nkzpbt>
References: <20240926074755.22176-1-Hermes.Wu@ite.com.tw>
 <20240926074755.22176-2-Hermes.Wu@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926074755.22176-2-Hermes.Wu@ite.com.tw>

On Thu, Sep 26, 2024 at 03:47:51PM GMT, Hermes Wu wrote:
> From: Hermes Wu <Hermes.wu@ite.com.tw>
> 
> The hardware aux fifo is 16 byte

Nit: AUX, FIFO

> 
> Change definition of AUX_FIFO_MAX_SIZE to 16
> 
> 
> 

Nit: no need for so many empty lines.


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
> index f372c05360f2..28a8043229d3 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -300,7 +300,7 @@
>  #define MAX_CR_LEVEL 0x03
>  #define MAX_EQ_LEVEL 0x03
>  #define AUX_WAIT_TIMEOUT_MS 15
> -#define AUX_FIFO_MAX_SIZE 32
> +#define AUX_FIFO_MAX_SIZE 16
>  #define PIXEL_CLK_DELAY 1
>  #define PIXEL_CLK_INVERSE 0
>  #define ADJUST_PHASE_THRESHOLD 80000
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

