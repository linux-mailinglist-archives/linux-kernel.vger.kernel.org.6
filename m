Return-Path: <linux-kernel+bounces-309918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB009671D4
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 15:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9333B2218C
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 13:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4AB12E78;
	Sat, 31 Aug 2024 13:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="oloo6lRa"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CD15227
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 13:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725111165; cv=none; b=KWjzEbijlxmIruh6Zvgv6e0tKFp7SeG93KtbuTW28777LP7tdL/VgbViFSITcV6cIrxuaku77vFbpDfMv0G2hokeQqIBpm05WGAM0Y2lolsssdsE0WybLksdxWqFA7O49AW3uFfE9WHjtQ7dEfDv6I5FShmOZSrjVeahGF75H3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725111165; c=relaxed/simple;
	bh=5ZV+3l8c2Ov9JRuodqJ9l0PCuEMCWZ/CJ8ukjbSL0Ng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=atuK7LIz2nuBSToF8bvfsiviUDWBIHhTmoDT8+/lYrmrYH5g+7Mt+e1qz2nvtR0gxctBr2BS03d+/5NLcYRO7ZOV28aqeTM7ZX1638JQacLIOAsWRZ5wEYRka/YMXiHCpAEEzz0WnmRWxb6rU9G1WGWXEaD6vKhkPbZ8iEKxwFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=oloo6lRa; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3719f0758c6so1892433f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 06:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1725111161; x=1725715961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cFA5cHVrCYbuMnxG2Yr+lCNh1E7e+JscJmhgi8KeHwQ=;
        b=oloo6lRac96aozdwEE8ZMcu33tpcdW8jHUHFWD5JoNtDi2l4Ra7gwt76vq9B8YOtkL
         Gilb1HTsYQYTcWF1clFRqRqSiBoECYj4RXTjZZLZ0LjsGEYzq+Km5RbGFb0MeivIGlUq
         sFJtNSquQgZsJBry1nmWq/VZv/7Or9DTUq+llRtmxm4IUGDPj4RYgw2mqQhygFZ04T4a
         vKjMFnsc+nXHZEjFQsjHEtTwMRiy4kM2149OmayI78XoAXuReHlw73NiARtNd7waD6a0
         eB0OEN/P9OkeSs3f8HR8wwv2YCY3s/2szWNUGFmy8s7eNlNr8Vy6nITF2Bj1bZMWDzhL
         oiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725111161; x=1725715961;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cFA5cHVrCYbuMnxG2Yr+lCNh1E7e+JscJmhgi8KeHwQ=;
        b=k60ojfawueg40ekLm0g4D/eVhdphRokKPsaVliPCIOnOjEGYYl0+6XLCcyzg3ahSOr
         xmqx22/v2j8AGyU9CeyxpKJmcRAj2098qzSO4zzywjgTUPii+0W0CqtmMVrROAByUoe7
         4uyXVaueAq01oTOP2gy4Ldqr3KpTH45SI5E++NuCVkb5C3/GE+vWgWzS4/jETaRMhfhH
         /y8bOW7UPHSr6u0nNqSIxwPaVc3NxslGLy6Qp2mFvj0tx6sLIgVZzj+5tXHBNpV8ha37
         3SNbfBa5xek2eDF27vl8lCjcuWdbPi/9k8qeLGQLIGniitOW50tgFmyYSpb0Fu6wdHZN
         ERUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVk4Fnm3xrl/ILnfAeM4QeUwJwp530kbiMirT0IhAT3IfSDaD/+ZFjxZMPLF7N8lPYoJXBeVkmo/+NnEVg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtbvw7IFYo96fM4yZ07GtBUVjSWfXBE8Wce3u7sm65Lu2tqt6B
	VaWEW1ZRgDTgTHiwuaQSGiXkhymQnZ3kO444TTWG8CMyEgfRp82X+lDUqRzP8o8=
X-Google-Smtp-Source: AGHT+IHknTcekKLxNYFyFH1SpJ0QujPtjHA1CNaSNCcSSUh5NNLKhm6npBadJ3CC2mIwHzZ8oF7MWA==
X-Received: by 2002:adf:8b52:0:b0:374:baeb:2ec with SMTP id ffacd0b85a97d-374baeb0b84mr1764071f8f.19.1725111161146;
        Sat, 31 Aug 2024 06:32:41 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee71650sm6540647f8f.40.2024.08.31.06.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Aug 2024 06:32:40 -0700 (PDT)
Message-ID: <5b803d4a-ffba-485d-b1c0-0691a8fa9542@tuxon.dev>
Date: Sat, 31 Aug 2024 16:32:39 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: clock: Add SAMA7D65 PMC compatible string
Content-Language: en-US
To: Dharma Balasubiramani <dharma.b@microchip.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240829-sama7d65-next-v1-1-53d4e50b550d@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240829-sama7d65-next-v1-1-53d4e50b550d@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 29.08.2024 12:38, Dharma Balasubiramani wrote:
> Add the `microchip,sama7d65-pmc` compatible string to the existing binding,
> since the SAMA7D65 PMC shares the same properties and clock requirements
> as the SAMA7G5.

Looks a bit odd to me to publish bindings and driver chances by 2 different
people, at exactly the same time. Maybe coordinate and publish it together
(at least for the future).

Other than this:

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>


> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> ---
>  Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml b/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
> index c9eb60776b4d..885d47dd5724 100644
> --- a/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
> +++ b/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
> @@ -43,6 +43,7 @@ properties:
>                - atmel,sama5d4-pmc
>                - microchip,sam9x60-pmc
>                - microchip,sam9x7-pmc
> +              - microchip,sama7d65-pmc
>                - microchip,sama7g5-pmc
>            - const: syscon
>  
> @@ -90,6 +91,7 @@ allOf:
>              enum:
>                - microchip,sam9x60-pmc
>                - microchip,sam9x7-pmc
> +              - microchip,sama7d65-pmc
>                - microchip,sama7g5-pmc
>      then:
>        properties:
> 
> ---
> base-commit: b18bbfc14a38b5234e09c2adcf713e38063a7e6e
> change-id: 20240829-sama7d65-next-a91d089b56a3
> 
> Best regards,

