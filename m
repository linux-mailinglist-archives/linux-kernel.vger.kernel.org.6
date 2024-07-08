Return-Path: <linux-kernel+bounces-244341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B0692A2E9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA53CB24F36
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4980A824A3;
	Mon,  8 Jul 2024 12:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V13oI9n7"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD68823A3
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 12:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720442229; cv=none; b=hRvc+oWFHPRPMGzvyDqx75Gfi3gUxnvFOgZQ+jvx2gp4IbNXluTUWwGC91iyowL9jkkYIJ6ej1fPwFyXu6KSUO3jA+jIy8zaRn77tw8lUhfBG0WfDIKP/xP11uP3tuK3zgefO+pd1tfrgiHElLMV8wTatUyt/kN50qkpSdR0cUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720442229; c=relaxed/simple;
	bh=aVjQp6hkSR6FL1HObsbs0Y1zAipIsbyyB8oSdT3lhyE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=We+Yk3IqD8Mw0elj4UoGm/AitYkziWvCErw8lUR5ggJdD4OGTOd3IAgRm9vKQoPwhOg3eQ7vIlqZe7HJhl7oarrBz74foa3aXDKbNhyIdjEvzYwyM0VLgBhq4GiRaajdv8nJoHyl4w1tZ2EsQzi4srti/RanlU7sbRV87wRUSaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V13oI9n7; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4265921b0f6so16783635e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 05:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720442226; x=1721047026; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=96TJNAco6UswomCuF7kl+MAcyBf4on/lL0AOzmc2lek=;
        b=V13oI9n7vtCl3yGxnyRibyp1aLJueVHPrVwklmJHawxFYSJi/EBcHPG6ksBILZ77OA
         qYoqofQ+Sv42rj0RZPRtelC2+8/1XoVp06/0AaTIzesmifBStaNNgOzZQ67GhhwIehGB
         s3IYOT1WVcYDlh3vL8YNK1plPFEx9ngLai/aLhefucl4CCwYIlmGwTZlqmsX4yahLIOv
         TPc0PrIyQo0lStTxA/x2R0teXeLtFHryjwiwm7nzH6pvTgvKk9k5bBRDB4YhwDaAYFQe
         POKLx6mPc2R8dXVXq71ZFt8MuZN7h1MA5DwCOtfU1J4zVM61zV+8lpCXWU6p0h6VwAJK
         WGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720442226; x=1721047026;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=96TJNAco6UswomCuF7kl+MAcyBf4on/lL0AOzmc2lek=;
        b=wk5c+S2/V3JDRxkZmEcN0JipNGkbca1OLqO9XH3CP+ql3ERVHHEJaspvfsZXPfsTnV
         VGm8NL1/3C79YJ/HCwcRcFM9yTY+f5o0fL0il0a+GOOs4NYJjVj62ajeaLSVsVOQzIP6
         vXQQeFkkcf4FI++RMWQdTC0d9ffSU91XIjZZBJxbMF7AKL0y9dgxG5lHVeDi6Z/E3P2y
         0iBK7g/6r9k/Z8tOMcIX7n41pnb9RFAVZnPFxJee1GAT+rn97otcxmAche0cbiwfXf1L
         Jdl9lwfvvFp6MkgEwGoSAPRp0nIltVkEAY+C+NfY2n6dvY2CYPC4ygZkB7rI1vFcKB+G
         1k3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7M0bwOsGVtdAzpGFyEwMIpfpoKX3xiUon8mHYz2hNCG7gM1zzY9jF+9mvlwrz5tHBQCdso2N2Mp8LfqMiNxBaFfkSyHQaOBXaVSSC
X-Gm-Message-State: AOJu0YwqssBrTlA1uzzID+K4UZ9W5RTJlSu1uu529dHtjcK1wusKhp1v
	kiKNEIXeQrZLyHp8xSwHxv3kBt5Q307x+gaY0zLnmF955fhhjeVKbTlcESs9yaw=
X-Google-Smtp-Source: AGHT+IHIUGHCJQHdqzNxOo2k+mrRHFj4Rg40rb/Uq0fOelGFJdpvW+XuLNcPwM5LrV9+ssCLjGxIjQ==
X-Received: by 2002:a05:600c:33a9:b0:426:5b29:b5c8 with SMTP id 5b1f17b1804b1-4265b29bd52mr52831365e9.28.1720442226128;
        Mon, 08 Jul 2024 05:37:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:f482:8fc6:e8d0:6d7c? ([2a01:e0a:cad:2140:f482:8fc6:e8d0:6d7c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2518f9sm164932565e9.31.2024.07.08.05.37.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 05:37:05 -0700 (PDT)
Message-ID: <861c8b22-8842-4eb6-8905-1e1a6467e661@linaro.org>
Date: Mon, 8 Jul 2024 14:37:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v5 2/5] drm/panel: boe-th101mb31ig002: switch to
 devm_gpiod_get_optional() for reset_gpio
To: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 airlied@gmail.com, daniel@ffwll.ch, mripard@kernel.org, dianders@google.com,
 hsinyi@google.com, awarnecke002@hotmail.com, quic_jesszhan@quicinc.com,
 dmitry.baryshkov@linaro.org
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240704072958.27876-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240704072958.27876-3-lvzhaoxiong@huaqin.corp-partner.google.com>
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
In-Reply-To: <20240704072958.27876-3-lvzhaoxiong@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/07/2024 09:29, Zhaoxiong Lv wrote:
> Switch the driver to use devm_gpiod_get_optional() on reset_gpio to avoid
> driver probe issues when reset line is not specified.
> 
> Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
> ---
>   drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
> index 159e401ad0e6..9f225c15b21c 100644
> --- a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
> +++ b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
> @@ -286,7 +286,7 @@ static int boe_th101mb31ig002_dsi_probe(struct mipi_dsi_device *dsi)
>   		return dev_err_probe(&dsi->dev, PTR_ERR(ctx->enable),
>   				     "Failed to get enable GPIO\n");
>   
> -	ctx->reset = devm_gpiod_get(&dsi->dev, "reset", GPIOD_OUT_HIGH);
> +	ctx->reset = devm_gpiod_get_optional(&dsi->dev, "reset", GPIOD_OUT_HIGH);
>   	if (IS_ERR(ctx->reset))
>   		return dev_err_probe(&dsi->dev, PTR_ERR(ctx->reset),
>   				     "Failed to get reset GPIO\n");

Hmm, the reset gpio is not in the bindings, please fix that!

Neil

