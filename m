Return-Path: <linux-kernel+bounces-549068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5990A54CCC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07ADE3A1DEC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9EB823DE;
	Thu,  6 Mar 2025 14:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qP0l/wbB"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9637428F1
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 14:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741269696; cv=none; b=sLxqow4Jof92OV6mhlv0RROtRMNBhtA3Za0TxwAwklxrBJjvr8uWJositP9rH0p0DsCMR+LpUMXTwkLdVgjvHtZjjcJMpFdi3Tm02XNtkZv1fDw6Yj0kdfEg/A2wk8ikgoVgU8l7j6uVa0v0fbfugg44hGgUqu8P18+6GwEOX0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741269696; c=relaxed/simple;
	bh=KjZiy42YljZ2AtrFvlblTtCW2edD1CD9VuJeuhOuuVo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lI8CSH3u6Cdaez5CofSLbHZfeWoWdvYU4jlyEclSt98E/7SxF4s3p0IBZd7LI/WGOnFwiPPtZEd9txadebNjd9oaSvG4HlZT3elaghin4rzw3QPeCMeRfvgrevd6scV3UR/5OkLNePjsoNop0Pvi/r3C3Zwvyx1+TlyrrJMccCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qP0l/wbB; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso4264515e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 06:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741269693; x=1741874493; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4u+yD+L8SkoBuycxt7wpDjWCkCg00Nv1+CGnM5syVQo=;
        b=qP0l/wbBqmsGWrvkJyKbPMvTnQdaUB1zLHHZGkxPN4Y+XtR0wsiyocApddYBLdgMpj
         NxRoQS71g/SkWGZ+XgmD0tR+wvrzrAmtaOqD9EF3wwsGBsFZ6ers7ENuHhKK0Qucw4J4
         nI8yRvJL/0KL/whtGeYogmjxCKYlW5xH7IjOvLfbnYHSoOw3rqw12ALV6eyOql+WhYt8
         mvwkdc4Iwoy3JSudbThraA7oogaeFgITPyKhESmbZP7ArU+KIRebp/7es8aATNYvndrl
         Y/+ueT0e5ZwmGp28eLOrNc8OBe+QOJUGmhkKxvMkZCmsBe1V2xZ1uMuNWAxUoj7SRyci
         DREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741269693; x=1741874493;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4u+yD+L8SkoBuycxt7wpDjWCkCg00Nv1+CGnM5syVQo=;
        b=AoRjx9xnkxlK/5lu4iyDweOsCBqG40ak/07NTqby/tEjMhbjvYOajAcUkkIeZFndyX
         2wzw7mGHQ2Zwa6PQ2PH5CkGttzblGrTZX4vDuz6EEKhNG620hkwv/8gcbC9EiXEfBn/v
         m58ERQEdPrDHIqL3COgOVIZz8lXswGJxlXnyCsD3Z/MPhpqx9vlj33i3oexcraylDKTA
         quJAbQ2es+sjxpaAMJhBQxTkkCTYQK+dDofFlpjf/LtgcVJf1P9baEF62zay638Yvwdq
         5NTSC7IlCJohuvq8Uhj14hdQ3oVd2TykYGheJ9CFCRQVvyHLfG3Nd7AytmgLS8mmNe+C
         wMqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5LjwlSKx73NvwUqHgPGXo4xQr6JKQguyPxFB+1Ea2FICzwr6kWYbYikblMpBjVFzQEAI4BNL5T3Fq2u4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHba63uqwcda/V1tSXfZ3zQUzJyH8vqHzPZ9jZPWeF5T+C+HTW
	4lOKYR9uq6R8eZs6LjtRlAuh3KCOl6u2VUQenoANXGGcWUllKLXDmwyodPk/jXA=
X-Gm-Gg: ASbGncuqY6tD+GDqjkzdnbLGgeu9DyWVBEdu8vAHfsYvoOM1C/+0rkN2x0EG7DSGps8
	7h3uKuD8XXaFxYfocar/iu/7ful67guXC1Nngmq3c9571oPiWC/Eyu8xZVQAaUJV3o1aApOmGGm
	1FQ/ATt4AevfUaSVYAduIppPYQTFAiClIAXX3YoWt5A1BsFQmAqcTGjylldximKJ1EZudSf6+HA
	V6MaKuqn9bhp9j7vnu7lUg5a6jNhAhOBIRqMSQE+McMV6oF0tnFCvsYo9blyYx7+aJTraTxaOcC
	AnFhWRTZmEG7/AF9YizrfZkXxwmtJBZuEhhEUsQTVnSz8sNGYFwpbWFhz+cKf4fgk0fDYatyID7
	eVBCgwhzLbf+OzySwX9E=
X-Google-Smtp-Source: AGHT+IFO4rfzomCLNmADCAKVmM3ka5dd5/nPpW1p4/Cl3JYo+9BNI7+poWnrhRYHc3uKC6SQbkscOQ==
X-Received: by 2002:a05:600c:1c9f:b0:43b:c0fa:f9c5 with SMTP id 5b1f17b1804b1-43bd2aed752mr48353045e9.21.1741269692653;
        Thu, 06 Mar 2025 06:01:32 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:d77f:d3a:3ea1:f8c9? ([2a01:e0a:982:cbb0:d77f:d3a:3ea1:f8c9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd8c28f5sm20931555e9.9.2025.03.06.06.01.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 06:01:32 -0800 (PST)
Message-ID: <afe1589b-81dc-488e-95ee-ce617213cbd1@linaro.org>
Date: Thu, 6 Mar 2025 15:01:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/bridge: dw-hdmi-cec: fix inconsistent indenting
 warning
To: Charles Han <hanchunchao@inspur.com>, andrzej.hajda@intel.com,
 rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 festevam@denx.de
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250305103541.3207-1-hanchunchao@inspur.com>
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
In-Reply-To: <20250305103541.3207-1-hanchunchao@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/03/2025 11:35, Charles Han wrote:
> Fix below inconsistent indenting smatch warning.
> smatch warnings:
> drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c:336 dw_hdmi_cec_suspend() warn: inconsistent indenting
> 
> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> ---
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
> index 9549dabde941..9d5bded54e8b 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
> @@ -333,9 +333,9 @@ static int dw_hdmi_cec_suspend(struct device *dev)
>   	struct dw_hdmi_cec *cec = dev_get_drvdata(dev);
>   
>   	/* store interrupt status/mask registers */
> -	 cec->regs_polarity = dw_hdmi_read(cec, HDMI_CEC_POLARITY);
> -	 cec->regs_mask = dw_hdmi_read(cec, HDMI_CEC_MASK);
> -	 cec->regs_mute_stat0 = dw_hdmi_read(cec, HDMI_IH_MUTE_CEC_STAT0);
> +	cec->regs_polarity = dw_hdmi_read(cec, HDMI_CEC_POLARITY);
> +	cec->regs_mask = dw_hdmi_read(cec, HDMI_CEC_MASK);
> +	cec->regs_mute_stat0 = dw_hdmi_read(cec, HDMI_IH_MUTE_CEC_STAT0);
>   
>   	return 0;
>   }

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

