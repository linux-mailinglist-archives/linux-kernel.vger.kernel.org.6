Return-Path: <linux-kernel+bounces-391214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BDC9B83E3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9BB21C2139E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 19:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105661CBEA0;
	Thu, 31 Oct 2024 19:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m8ztcsIj"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA016347C7
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 19:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730404774; cv=none; b=P+h4xv3IxFQGfPUsr65j8DWIH8M4xyqSmkzgrKAyRv5pS+tq0sr/4ERNeyxMGUI24JrRcirM5dyPL26y8fRvkHtTnM1hHZFp8KL4J/Dhmwc0nlKVcKcg6hA/e3FgM2LrUkkX2r4H5epwvjuIQGx3gKUZ4hA+jN62ykg35x3uOCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730404774; c=relaxed/simple;
	bh=5p4Mk678GuitXuuECGJ5e05Cm7ocEQTQPS952K3CUw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEvu1uPo4MtjIeEzGZ4xFDWF5DsqLUq5HLnpmz0HZOw374VWfgP8oGc7qtjkF/+UYU9T0xPDOYD8G7RALS6MowXndAntFOSpVcWAg3JY75/dNHEwwSIwHlXaSilViPiyQE+4qE/jOG5s3ZSFiYUfxZ8V15MyZmGKhHZkPGJEKu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m8ztcsIj; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb59652cb9so13242691fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 12:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730404769; x=1731009569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r2xSFooj3LTMdkPz8EDCzvFWM6rUJZfX8/xlhCllXOs=;
        b=m8ztcsIj8lRYPW3OJzKX98epVi7p7Fo9uOn09BMSfHBZ4m+vS1ePlknlpHNmQX2Q/7
         QXajJPKEKoXbRZtOuWd2pqjI9JAaHIpwjRHjqAZD+ZxJfza3jTCMZ6qqIt50xaMdmJKS
         De/9t8FtUzl0fV7qMglKLIuWG4GSWWPOGVxatYlOaejyiylxDH0CUDsYiWzOqDz7c5QY
         tUlP2rY8tLeN0sEpoCHT87tuvy1tV4Pno36iWgGcu663L+DTDntHfxbp8+pEb3V2ptoX
         LDtipOOhcR4CwPiKCfsQm+yH/4noXjel7iDBt4UebxLY77W6gEe5jZ4oT/8fhXA/r6U2
         1IvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730404769; x=1731009569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2xSFooj3LTMdkPz8EDCzvFWM6rUJZfX8/xlhCllXOs=;
        b=s2UAj/7FPCPGJClsKtvmxVBfWj9RCK5rtHXCDgkzZuRpfyt8LirVxoeifpMneMt/xp
         WGy0SAoVQHEWW8U9zWdhsJ5aJ6uLQ655RdYaS+xUThQpaURrnNandBMroeev0G2FSOPS
         n4Aoc7nf9LwdlXD7yqxw6tmkXr8gqin1yPd9l84E9cfXkAz+cuqohVCEIvWUGSoLY9zz
         qG/Fh0maZ061v7/7LTHgHF+xohBPJreOZvmJtpz6GZR/gPITAXqqTK6ytK9w/mcPDQtB
         PzmC7O21XRGukmCb/fS/iUch5LZO5zaj8nu/OEI9KX9ijQyVItVkIGDjR7CT3PKLU/pH
         Woug==
X-Forwarded-Encrypted: i=1; AJvYcCU2ai4MljNeF+TQ8yRDlYMLXNcnOgawtXf9fX7K65ISoGPOYtDyRe/qXmyTTB+LFG59HBBpRIdWUyBgqVo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/7MRdHhOzRzxRPmja26lsLvAbfSQcHT/svSxnamMlWM35cpFs
	tSYRCBOIcWw0c39kgJiHeZhvxAZvTD00YN7Q7dS0gjKml3gRQZoWe5F70dPgxzM=
X-Google-Smtp-Source: AGHT+IHDY9mv/LMyrOcAiV/L1FzFmSewuJQRy7gy5xJKrH90HggjEEuq5c/C64nK+qTpVwhpZjhxzg==
X-Received: by 2002:a05:651c:556:b0:2f6:649e:bf5c with SMTP id 38308e7fff4ca-2fdec726444mr22632061fa.17.1730404768964;
        Thu, 31 Oct 2024 12:59:28 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fdef3b8ed5sm3238001fa.13.2024.10.31.12.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 12:59:27 -0700 (PDT)
Date: Thu, 31 Oct 2024 21:59:26 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Guido =?utf-8?Q?G=C3=BAnther?= <agx@sigxcpu.org>, 
	Robert Chiras <robert.chiras@nxp.com>, "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: display: nwl-dsi: Allow 'data-lanes'
 property for port@1
Message-ID: <gz3ifraqt7ga4isxhx6negcmfngen5jmhmcecnvy7gu7mpfffw@j65umo6arwc7>
References: <20241031194714.2398527-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031194714.2398527-1-Frank.Li@nxp.com>

On Thu, Oct 31, 2024 at 03:47:14PM -0400, Frank Li wrote:
> Change $ref of port@1 from 'port' to 'port-base' and add 'endpoint'
> property referencing video-interfaces.yaml. Allow 'data-lanes' values
> 1, 2, 3, and 4 for port@1.
> 
> Fix below CHECK_DTB warnings:
> arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx-lvds-tm070jvhg33.dtb:
>  dsi@30a00000: ports:port@1:endpoint: Unevaluated properties are not allowed ('data-lanes' was unexpected)
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/display/bridge/nwl-dsi.yaml       | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml b/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
> index 350fb8f400f02..5952e6448ed47 100644
> --- a/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
> @@ -111,11 +111,27 @@ properties:
>          unevaluatedProperties: false
>  
>        port@1:
> -        $ref: /schemas/graph.yaml#/properties/port
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
>          description:
>            DSI output port node to the panel or the next bridge
>            in the chain
>  
> +        properties:
> +          endpoint:
> +            $ref: /schemas/media/video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              data-lanes:
> +                description: array of physical DSI data lane indexes.
> +                minItems: 1
> +                items:
> +                  - const: 1
> +                  - const: 2
> +                  - const: 3
> +                  - const: 4

Why are they indexed starting from 1?

> +
>      required:
>        - port@0
>        - port@1
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

