Return-Path: <linux-kernel+bounces-237686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EA7923CA9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D69F5B24302
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 11:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D2516FF2A;
	Tue,  2 Jul 2024 11:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Aij3nAQ4"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE1616F260
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 11:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719920481; cv=none; b=bV5dg7jfxTLN9nFzOGpfsjGejNZJy/mCQscbDf8GhuUPMW7DTJIz6puWtVzhT3uqdHpY7hvZIGff66kPGQjM/75s8Z8sE+v0g4NNZmGI7QbjJWQHtRRgxglry8jJLUDfhg0Pf9tl2XmpBk+2eEbvjf8bEfv0FoadA7hYjQHltUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719920481; c=relaxed/simple;
	bh=NSroMKxF+iEaFAVVz8p4WKV4y7ZnU+9j/v7aX3NGInk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VntbLqQ/znAgbcEUk3VwQ75UIDlqwyGxFEZg1wfVQa4IvgUqz93WLjNfQNka5rCIBbXs5sE07hGwqwmxliRf6c4COOizwfa/IhpeXYaI2g38Bqj2n9g8fyIp8se/UHgI34GYYUHxBEx0W19lRKmahKOsy8p6BKXV5E2xTtxbflY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Aij3nAQ4; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52cdb9526e2so2970317e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 04:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719920477; x=1720525277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kQVFB1Ory94czUgWNWBlgE/4b9Cm7QVvjGoDYPQAvFo=;
        b=Aij3nAQ4/WoczJMW9ELIykb7PgDVYwmKQNslgdLDcCNq3ovTXxWXWiMPEnHClQK09p
         d57wVRh5N9Cb7ntZiRS5DpMKXIplps01PMBZK4oZWv4Go66ZygPGFtjOV5Yr+++2Hl/v
         0+o8JH5joKLqCvve+7Zfjvga2iy4oNV1t4biEv/D385YM11yfdFa4Bqq9uHOKnBFdsKS
         1HIvQuwUCIEuxI6XYnYjeUTxGifaDefBI44GI1KV7bDWvK5d2pny/fmNBB/Ha6d36cvv
         AA6xy+BkGEFPAcuxW5dpOzNaVD8b87+RGmV0Oxi/eeNRXpgNr5o5Xj9QZ2erIwvF0KAC
         qyig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719920477; x=1720525277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQVFB1Ory94czUgWNWBlgE/4b9Cm7QVvjGoDYPQAvFo=;
        b=TktePQ7DN+viJoqYiVrIHN5ISKSZHMw3b695+lkrrGaHkH5UrYl6oj4Yf2C6RfOiPE
         SaXnkn50zXajU7ro9reZ5zEn0zQq81EPu6zyiKclZAFLG7eHFEKez5q6p8W7jYYTgpKo
         ZKI+J/44Rsk83I1SmE4u5rS7INmMkyCxIXKlWg3DcFGRML0A4GCpkXCk46aiYfYgGE8b
         +wL4jYLYM2VBpJSfn2eJKEzR1ystzXQ+22K0wOIdE/uWVHq2TEsmWMeUes/2P7mqsaI4
         5yUrKwCXwYQNuFS/i2mN1NkgiGYbfrJr6fAT2CA3+MVzgG02oRunWdMOlc8xLnjyJQM0
         fJZg==
X-Forwarded-Encrypted: i=1; AJvYcCW2CvEuzx9fu+B/yb2GHNsHwdlIuk7YHGKYkz+A+fon2PRwpKVoUZKcpSYwk0/FRiFZHLNgTeoJsetDqFL17jzSHTTayXN973LzvdWA
X-Gm-Message-State: AOJu0YzOTN0WqU8lO7cu/6AEqu2kma9qxM6f/UOQPW9wwQs1X3D+D4RZ
	eW2SUdoWxvianvkHKbya4HNCFk1s5vwR7uoxhtq6dAES5hOKmDODoN4UkbKydlg=
X-Google-Smtp-Source: AGHT+IFqRDyr09Nd7VDWumaaV4++hDJsHKTRvx5HWWdlWqBKX6NlFxjkCBaAtoRxcjfUWhxGiOhj5A==
X-Received: by 2002:a19:e017:0:b0:52c:81ba:aeba with SMTP id 2adb3069b0e04-52e8259ff12mr1988718e87.14.1719920477367;
        Tue, 02 Jul 2024 04:41:17 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab2f8b5sm1774583e87.233.2024.07.02.04.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 04:41:17 -0700 (PDT)
Date: Tue, 2 Jul 2024 14:41:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] drm/bridge: Silence error messages upon probe
 deferral
Message-ID: <5f2qg7cidl6rchculjzw52sfadwoprcptkhz2ikvo43kyny42s@o2ejrvqg7xjg>
References: <20240628115131.2903251-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628115131.2903251-1-alexander.stein@ew.tq-group.com>

On Fri, Jun 28, 2024 at 01:51:30PM GMT, Alexander Stein wrote:
> When -EPROBE_DEFER is returned do not raise an error, but silently return
> this error instead. Fixes error like this:
> [drm:drm_bridge_attach] *ERROR* failed to attach bridge
>   /soc@0/bus@30800000/mipi-dsi@30a00000 to encoder None-34: -517
> [drm:drm_bridge_attach] *ERROR* failed to attach bridge
>   /soc@0/bus@30800000/mipi-dsi@30a00000 to encoder None-34: -517
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Reviewed-by: Robert Foss <rfoss@kernel.org>
> ---
> Changes in v4:
> * Rebased to next-20240628
> 
>  drivers/gpu/drm/drm_bridge.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index d44f055dbe3e7..3e72dfd941577 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -353,8 +353,9 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
>  	bridge->encoder = NULL;
>  	list_del(&bridge->chain_node);
>  
> -	DRM_ERROR("failed to attach bridge %pOF to encoder %s: %d\n",
> -		  bridge->of_node, encoder->name, ret);
> +	if (ret != -EPROBE_DEFER)
> +		DRM_ERROR("failed to attach bridge %pOF to encoder %s: %d\n",
> +			  bridge->of_node, encoder->name, ret);

Maybe?

else
   dev_err_probe(encoder->dev->dev, -EPROBE_DEFER, "failed to attach...\n");

>  
>  	return ret;
>  }
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

