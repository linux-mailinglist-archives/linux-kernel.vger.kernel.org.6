Return-Path: <linux-kernel+bounces-523483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAC6A3D76B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ABFB179549
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF4E1F0E34;
	Thu, 20 Feb 2025 10:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SC+E7NOm"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE67D1C6FE9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740048817; cv=none; b=MB1x8vQglsENmURQ+OCFTKPh/03Fatq1eLxbLhPggj3RNCY07a2cgHfK3t3boz5WXSiQcYWoNZTJ5LXUgdGSCUThT3MWFRmEz7lw/zod8DukhXiyDGt2DgT27szCiK4eAOz388p5cxD33OWgZ8EBcU72PURklIK8HPvdlOzej1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740048817; c=relaxed/simple;
	bh=YaF6r2FXlfQ0DsVDdfJuMoslOCpKrnWhv6zdNCgK1mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mR4uKmZxtjPHmjJAxYCafjxp0g8lZe8OoQBaC4uiuwd9QkmbEDtkkmbEpfegNUl1rTDes70dnSc4iw6xSUJFsmkqf7LBL7G3A+m2+xyngSXa+5FeRZD01kXsXsUPs7/mG02zvARENAD8tGIGcIz3V6DiHLiY5kF5pfSx3NAB/uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SC+E7NOm; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30615661f98so7461171fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 02:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740048814; x=1740653614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i4cNa1KAWhPy2izhnLaEb+31HFajh22g8Y95z+oCBBY=;
        b=SC+E7NOmaP59JSoDUIFpLZAuGfW6GsHXFdvGfoDhRyYFKNXhILzRPDBmFQp+yMlXj0
         j/Qz+HQX2dQB1aXVZprXY/uYx5XLmrk+OGdEdoirDBQhY7fTf/Ithp65gqdXJYP5ckWJ
         BW8ML1kQUwRTQmCv6NwiCJyr76aRA/8a59rEF2qgST803vGXBuhyC5K3/Hcg4dtb12es
         mgUwVkLVqr5cvqVIW6TwMXRlrdfwB/sopKPE8aprQFduVI787XWQy7q+SwxBcy0N6ToI
         besAbc3Wpw6XdJSHYtamxQ8Z66x7zOjv9EEixyhQRk/felQUSJcoAIf2w0S4qMJ92qHJ
         8Zqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740048814; x=1740653614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4cNa1KAWhPy2izhnLaEb+31HFajh22g8Y95z+oCBBY=;
        b=P3BghnsHRQXiAbpcbXBEVMH5x40AX7kEC1ZNqgVtod8ykDJbZC2aH7HYRPfaFHTwhd
         priNh5UxsygigmEkVY7V+oqsinb3oDVBFb8birsaRUXCeQmVCCLhlFfzaLykDaw8RUxM
         TqooAo4CO0flqhmFHOBWtmSr3AvuOyxz8zdBMttuMXRvymt7ymZiVAKq1LlalS+i2VQs
         FA62Ip2Y2t5SPqGfOm8u0kiOi1mMPYgbdUJWacRisTiN8Y5DeZju7b+jIODo5gD3N4bI
         c51Zea58IrSVIVxK1ugwqmfOV77fvO8dhPWanKm4YuYZXjyJemtRDabDaSbzTP6v3AZT
         ucmA==
X-Forwarded-Encrypted: i=1; AJvYcCVxYaDhALVmXE5oZpv6MrxtoLaF6VhPHSkFdjpdr3u0s+Rmx0JZVMveTtzfdp8qsmIP5+6M5K3/LsnZwJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkJ3Kz+9YcTdKUB5BYgO7pLmjkWxgHHl6NJVehTZN5dmhaXxno
	qdFG3wzpfxJAW0hrOW3NjuE5Yq1uK5ZkEXXu4T5RzKc204BaBaOxMIakDZ8oYWA=
X-Gm-Gg: ASbGnctLYvIenOXm9DpeeyE/w/htIju58pOqbC90CG1Gh+7Y5VOLB0M0FsFeEVfvA2q
	TVyJDFJsb0d0Zbi2YDoso1k64wdPfYD/8MjdaW3EZqo7Qp7ROhv0Oce+cJHWdrb9HGbAXkenbI3
	SNaFdR1fk5Z79dROylA5l+4NdOo4iBdjgJpcmDaskTYEfeXNWKKVkRm9uXLTFKLbN3spfTwnf3g
	XYI4Ai0uOLZMS+QDcczn9ykR1oRktLJ1EjTUpyQjvz9HY9sbWdbYYs+p9TWrehaorCbQ1C7+pE+
	7hAyil4V1l2PcMiZlYqUBW3ZbLzKckKKX5ZuAx1fTD18xU5QAfYSvuHyuJZ60mjVFTFCugc=
X-Google-Smtp-Source: AGHT+IGUa93DzQBNfWAgZCCcEoZ80+sJq5+WQjklkO36XME+Wd2aJ2kzORb+MvS9U9E5VlLr6XgUwQ==
X-Received: by 2002:a19:5e58:0:b0:546:2ff9:1539 with SMTP id 2adb3069b0e04-5462ff91883mr1947710e87.52.1740048813729;
        Thu, 20 Feb 2025 02:53:33 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54530a91179sm1748351e87.33.2025.02.20.02.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 02:53:32 -0800 (PST)
Date: Thu, 20 Feb 2025 12:53:30 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxim Schwalm <maxim.schwalm@gmail.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] dt-bindigs: display: extend the simple bridge
 with MStar TSUMU88ADT3-LF-1
Message-ID: <fqnaxziho63smog2adn27ypwoqrknbgbpe4xtgmj6xdbcavp3u@djbitfumfc6d>
References: <20250220094456.32818-1-clamor95@gmail.com>
 <20250220094456.32818-3-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220094456.32818-3-clamor95@gmail.com>

On Thu, Feb 20, 2025 at 11:44:55AM +0200, Svyatoslav Ryhel wrote:
> A simple bridge used in ASUS Transformer AiO P1801-T.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../devicetree/bindings/display/bridge/simple-bridge.yaml        | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml b/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
> index 43cf4df9811a..8308e833938d 100644
> --- a/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
> @@ -31,6 +31,7 @@ properties:
>            - ti,opa362
>            - ti,ths8134
>            - ti,ths8135
> +          - mstar,tsumu88adt3-lf-1

Please keep the list sorted.

>  
>    ports:
>      $ref: /schemas/graph.yaml#/properties/ports
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry

