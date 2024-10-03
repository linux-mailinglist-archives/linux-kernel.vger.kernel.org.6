Return-Path: <linux-kernel+bounces-349281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F6A98F3B5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 18:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 528A91F221D4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 16:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6847D1A7060;
	Thu,  3 Oct 2024 16:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nxvnu8uf"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234631A4F3B
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 16:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727971959; cv=none; b=m0urQ9kmjt3dq53zaGJ+H+kd73LVuqu+LHGi0l8+IKj4T53sWvE86jrDKvbD2f/04zD69/6qtYp800F7tc+NAVtajP6P8JRt3laLu07wducTR7oc1edcOhz+yweyFqFrVSSAN/RvkQMTHfUWOvXuwBa3ftLfjA+iE1Zhi3QtDF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727971959; c=relaxed/simple;
	bh=aUz27La3VLNjvbKwTNA8ZJkmaLVF8kbkGwNqqZkdqaE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=X6OZD3iMBc9L2GLSuG2RACrRYkVgPY3w6ZwbFh5l7gW4IQw7wTd3z+SPZAbVf0QyQMp3O6gryzZ0/3GTSov45DBwjeQj+hcCtay0qwuWXHSijw8+7MKT4XPJ8TAS6InFom8iLPZ/hxu7dKjpyAcrnElVwJ6+4FWzji+yzS69EPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nxvnu8uf; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cd46f3a26so10216875e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 09:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727971956; x=1728576756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nxjal9NLxsSrsdx2DROpNELieYh4/8tITxuoItEclxk=;
        b=Nxvnu8ufcoC9iiRM1zvGkSm6TUlGhnEspGVDkrfofl9PUvBQu+TA++hW9hXdc+P3Wb
         ngNolvdJx5ToITKflXA1Jsre6RBA9CkYhDikOQ1oaowhGO/+sigGqflRUUlLO8AdT5+o
         S0UTjF+ainBjf93obIg3U+Z9l5oMtV8ZILzxVegCDz4KrP59FSXEy6ECCSxHr8A026Zv
         3Cy0HxbcVXyJMzFnOcZbB2zaUqHJJeOaT2q+dX5YFgWtPkPL/JF3mf5M66UAQO0mdX6x
         6SK+rR2Y2VN4pm2m1M0WotcpcuOhId6nMWJHxWbRA+Sm2IvBkqaS+0/GGcN90cuwfRZy
         j0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727971956; x=1728576756;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Nxjal9NLxsSrsdx2DROpNELieYh4/8tITxuoItEclxk=;
        b=DQZ6+2jmG7S1zQfODKLbBKc6Lmv+/E5h6Cm5bRBk1XdeRYdCxStZx3COs7ImT6QX2m
         IA21mxlqGqpBRxJLjy7DUNcffF0q36rQAMc77S/ivjZQlKQHvB6Ur60l0Oa+0w+6gEW9
         ccTDKP+s1Ir/KXdbqB/HpjB8lb1SLqerMI8cugeTbwmC9K6Yr+dYbidd/f98Zrmkl4XP
         zTEgOMpEQYZgWlAUkHWC98PAWiZ8F6OOVDN3R41AzqSQZhDQleNx7BdidU5nnSlklXkg
         OCuBEbd9Vn+vXBrsjGpe62dxSJteQz5xyL6sHu2DE0D2JS868sWlZMgKSvHqFlEGZ0RC
         O5VQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIbgdHlOwcwF0LyLcdHjxVI6Dx+AHsElbSfLwQESsLktrwE454Vr9G+Cc1czbHlQX9weRLHwHcFyUZs8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuc9beH2jIY6t35sguZaAALR9ps6LgVBblqHF5cqBgOicLLbIw
	JomgQahqAlWI4chZ8hMItf6Z5WI2Lc8HiCGM+N+XldO6myurvrKqWnmgGYp/ZX8=
X-Google-Smtp-Source: AGHT+IFFl6f96MyLoOvbN+EXoMYpotmRTEsZw6HH9lEWLuCWHWMFwO37IdTl7WToRn7LoUvbJrF1uA==
X-Received: by 2002:a05:600c:1f0f:b0:42c:b22e:fbfa with SMTP id 5b1f17b1804b1-42f819ff766mr16435075e9.21.1727971956492;
        Thu, 03 Oct 2024 09:12:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:e534:c027:e113:29a1? ([2a01:e0a:982:cbb0:e534:c027:e113:29a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f802a01f2sm18982715e9.30.2024.10.03.09.12.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 09:12:36 -0700 (PDT)
Message-ID: <62bdc55b-8620-407b-a6b8-cce2f120a933@linaro.org>
Date: Thu, 3 Oct 2024 18:12:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/2] dt-bindings: display: bridge: tc358768: switch to
 bus-width
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241003133904.69244-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20241003133904.69244-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/10/2024 15:39, Krzysztof Kozlowski wrote:
> "data-lines" property is way too similar to "data-lanes".  It is also
> duplicating "bus-width" from video-interfaces.yaml schema.  Deprecate
> "data-lines" and use the common property.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   .../devicetree/bindings/display/bridge/toshiba,tc358768.yaml  | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
> index 779d8c57f854..bb5d3b543800 100644
> --- a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
> @@ -60,6 +60,10 @@ properties:
>                 data-lines:
>                   $ref: /schemas/types.yaml#/definitions/uint32
>                   enum: [ 16, 18, 24 ]
> +                deprecated: true
> +
> +              bus-width:
> +                enum: [ 16, 18, 24 ]
>   
>         port@1:
>           $ref: /schemas/graph.yaml#/properties/port

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

