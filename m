Return-Path: <linux-kernel+bounces-243986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7520929D64
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 008FC1F226CC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 07:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B85F2D058;
	Mon,  8 Jul 2024 07:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aJapcpik"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59A737703
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 07:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720424594; cv=none; b=BkbABOGDnKMdIyx7gtKddKR3hVYU49kqR8C9QjykB7jhEYoXqgLhnaNF7sv1WJHr8FfRVxK5IaNSMdMDnCIxGmvnh44mNcxgRNDUvsJojDJA1SJ4hbIlYeRy3g3LRCrFD0rgasNa6weyCs7wE32OJGzYLFaI9nxgB6OB7y1AzEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720424594; c=relaxed/simple;
	bh=wYmmf7xp2Ptm8+U/g7Lae1jTTLA9N8Z16R8tRpTvrVM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=sC2yRHKOcn8IYUYR2BXwlvp3rLKHxGamZOiC4sAChB07LnI6b6ovU7h2efFUCf5QU26JFj/NfAySwBgM4PAzUE+aZzqz0iyRitZScQOZpzpOT4sCyhZ5hsTfZ8prEngPTM1uiRFJJyONNSwkuGqNsmQPHWkNiVMs4TLDb2TVkbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aJapcpik; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52ea2f58448so4358534e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 00:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720424589; x=1721029389; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zOlydTqDeVlzL2dB2IugWsMftt/eEre30gS8rU/QDh0=;
        b=aJapcpikEookI/uCuBGVGmWnW9LoTFV7gOpw8BqdDKh0OWavo5kBmJ9mtILF58gsdW
         SWrLaA1rmGUD69/sRWmaeYTOZTf2DV+GW3XPZ2M7Lji97T4sazAgle6L73bFlTPn5HhZ
         Tmt3zdRz+ZLTEo5fSk8BkAttWhkXYNd7FYEqqUTevYSJhl+c50nF0G5dhiia/7iKgtCb
         6TH8STiShm3ptY//biYFlM/70AEQX/Bhf4RRoZnQ3Uhaos6ibmN+FzuQRw9X2w8r4pEu
         V9C7bi2+QKveE1QAZBjzVMke0toWbbCPRLuTG4WBCTs7NMsvq36SL5RsYxGZuNZtWy0v
         sjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720424589; x=1721029389;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zOlydTqDeVlzL2dB2IugWsMftt/eEre30gS8rU/QDh0=;
        b=mVdO+3W2hZaCbuQLCW8VZbcT6qfu8f/5YnUm9uMBI/VB0Dz8ytHc9otViZ5zxBCGkE
         3VRhP6ti0/3L+b5rUoAqLQEQFjM3i2hb5GNP8EE/2V/mGqZwoHVszK5gsH2+rM0TzbD+
         LN4vDbEXLXXdohmb9Cu85bteW2OKpzV72RTVp9NAU3boRhFGEYXK6Clao2b5ZyWwX5q8
         oQtZhbdgt2XsT8Ry24HaJo/4UjcxvYo9wANRo+GA3Mi6blj6qsd1K8JvL3nAgPfSc0KX
         KSJIwFhN4anaEhciU7f3Qcki+BbP/+6XSlMn0PE6Hk9YjakeYAf0/0KMCjKvlUloESqa
         UtMA==
X-Forwarded-Encrypted: i=1; AJvYcCVR953o2CQOvdoEQKbo6Cc8MAOCv89hSes4BGjuZ1/azgb7757xXwISdo9DkMXENtjzPOs/93a9UTMhTu1ARYFfEZBMYrVX3IRWiKtE
X-Gm-Message-State: AOJu0Yx3t6qwSUVOq81aXyiiteid2Sj3AhW+xeXOCE0vvq82rER1vgEw
	kFb78ntpLrDsWBjCUxW23YAKu8CMBnIBFiXPsQKssAk+Z2pRIZjom5+xjerh9EY=
X-Google-Smtp-Source: AGHT+IEt9adl38+rPBcAyvkBbtEE2lBB+786T4qK/MbyMcZteoFeu+yFd7ZsF7LPjhxqlZHMKZEMpw==
X-Received: by 2002:a19:7501:0:b0:52c:c9cd:ebc3 with SMTP id 2adb3069b0e04-52ea06e3e43mr7092274e87.63.1720424588719;
        Mon, 08 Jul 2024 00:43:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:f482:8fc6:e8d0:6d7c? ([2a01:e0a:cad:2140:f482:8fc6:e8d0:6d7c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4265f84cd44sm79491165e9.18.2024.07.08.00.43.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 00:43:08 -0700 (PDT)
Message-ID: <c17f6b3d-9195-4448-b251-8766f922abf4@linaro.org>
Date: Mon, 8 Jul 2024 09:43:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 1/5] drm/panel: st7701: Rename macros
To: Hironori KIKUCHI <kikuchan98@gmail.com>, linux-kernel@vger.kernel.org
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
References: <20240706102338.99231-1-kikuchan98@gmail.com>
 <20240706102338.99231-2-kikuchan98@gmail.com>
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
In-Reply-To: <20240706102338.99231-2-kikuchan98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/07/2024 12:23, Hironori KIKUCHI wrote:
> Rename DSI_CMD* macros to ST7701_CMD*, and ST7701_DSI macro to
> ST7701_WRITE, because they do not belong to DSI.
> 
> Signed-off-by: Hironori KIKUCHI <kikuchan98@gmail.com>
> ---
>   drivers/gpu/drm/panel/panel-sitronix-st7701.c | 736 +++++++++---------
>   1 file changed, 368 insertions(+), 368 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7701.c b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
> index 421eb4592b6..a9a8fd85057 100644
> --- a/drivers/gpu/drm/panel/panel-sitronix-st7701.c
> +++ b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
> @@ -18,75 +18,75 @@
>   #include <video/mipi_display.h>
>   
>   /* Command2 BKx selection command */
> -#define DSI_CMD2BKX_SEL			0xFF
> -#define DSI_CMD1			0
> -#define DSI_CMD2			BIT(4)
> -#define DSI_CMD2BK_MASK			GENMASK(3, 0)
> +#define ST7701_CMD2BKX_SEL			0xFF
> +#define ST7701_CMD1				0
> +#define ST7701_CMD2				BIT(4)
> +#define ST7701_CMD2BK_MASK			GENMASK(3, 0)
>   
>   /* Command2, BK0 commands */
> -#define DSI_CMD2_BK0_PVGAMCTRL		0xB0 /* Positive Voltage Gamma Control */
> -#define DSI_CMD2_BK0_NVGAMCTRL		0xB1 /* Negative Voltage Gamma Control */
> -#define DSI_CMD2_BK0_LNESET		0xC0 /* Display Line setting */
> -#define DSI_CMD2_BK0_PORCTRL		0xC1 /* Porch control */
> -#define DSI_CMD2_BK0_INVSEL		0xC2 /* Inversion selection, Frame Rate Control */
> +#define ST7701_CMD2_BK0_PVGAMCTRL		0xB0 /* Positive Voltage Gamma Control */
> +#define ST7701_CMD2_BK0_NVGAMCTRL		0xB1 /* Negative Voltage Gamma Control */
> +#define ST7701_CMD2_BK0_LNESET			0xC0 /* Display Line setting */
> +#define ST7701_CMD2_BK0_PORCTRL			0xC1 /* Porch control */
> +#define ST7701_CMD2_BK0_INVSEL			0xC2 /* Inversion selection, Frame Rate Control */
>   
>   /* Command2, BK1 commands */
> -#define DSI_CMD2_BK1_VRHS		0xB0 /* Vop amplitude setting */
> -#define DSI_CMD2_BK1_VCOM		0xB1 /* VCOM amplitude setting */
> -#define DSI_CMD2_BK1_VGHSS		0xB2 /* VGH Voltage setting */
> -#define DSI_CMD2_BK1_TESTCMD		0xB3 /* TEST Command Setting */
> -#define DSI_CMD2_BK1_VGLS		0xB5 /* VGL Voltage setting */
> -#define DSI_CMD2_BK1_PWCTLR1		0xB7 /* Power Control 1 */
> -#define DSI_CMD2_BK1_PWCTLR2		0xB8 /* Power Control 2 */
> -#define DSI_CMD2_BK1_SPD1		0xC1 /* Source pre_drive timing set1 */
> -#define DSI_CMD2_BK1_SPD2		0xC2 /* Source EQ2 Setting */
> -#define DSI_CMD2_BK1_MIPISET1		0xD0 /* MIPI Setting 1 */
> +#define ST7701_CMD2_BK1_VRHS			0xB0 /* Vop amplitude setting */
> +#define ST7701_CMD2_BK1_VCOM			0xB1 /* VCOM amplitude setting */
> +#define ST7701_CMD2_BK1_VGHSS			0xB2 /* VGH Voltage setting */
> +#define ST7701_CMD2_BK1_TESTCMD			0xB3 /* TEST Command Setting */
> +#define ST7701_CMD2_BK1_VGLS			0xB5 /* VGL Voltage setting */
> +#define ST7701_CMD2_BK1_PWCTLR1			0xB7 /* Power Control 1 */
> +#define ST7701_CMD2_BK1_PWCTLR2			0xB8 /* Power Control 2 */
> +#define ST7701_CMD2_BK1_SPD1			0xC1 /* Source pre_drive timing set1 */
> +#define ST7701_CMD2_BK1_SPD2			0xC2 /* Source EQ2 Setting */
> +#define ST7701_CMD2_BK1_MIPISET1		0xD0 /* MIPI Setting 1 */
>   
>   /* Command2, BK0 bytes */
> -#define DSI_CMD2_BK0_GAMCTRL_AJ_MASK	GENMASK(7, 6)
> -#define DSI_CMD2_BK0_GAMCTRL_VC0_MASK	GENMASK(3, 0)
> -#define DSI_CMD2_BK0_GAMCTRL_VC4_MASK	GENMASK(5, 0)
> -#define DSI_CMD2_BK0_GAMCTRL_VC8_MASK	GENMASK(5, 0)
> -#define DSI_CMD2_BK0_GAMCTRL_VC16_MASK	GENMASK(4, 0)
> -#define DSI_CMD2_BK0_GAMCTRL_VC24_MASK	GENMASK(4, 0)
> -#define DSI_CMD2_BK0_GAMCTRL_VC52_MASK	GENMASK(3, 0)
> -#define DSI_CMD2_BK0_GAMCTRL_VC80_MASK	GENMASK(5, 0)
> -#define DSI_CMD2_BK0_GAMCTRL_VC108_MASK	GENMASK(3, 0)
> -#define DSI_CMD2_BK0_GAMCTRL_VC147_MASK	GENMASK(3, 0)
> -#define DSI_CMD2_BK0_GAMCTRL_VC175_MASK	GENMASK(5, 0)
> -#define DSI_CMD2_BK0_GAMCTRL_VC203_MASK	GENMASK(3, 0)
> -#define DSI_CMD2_BK0_GAMCTRL_VC231_MASK	GENMASK(4, 0)
> -#define DSI_CMD2_BK0_GAMCTRL_VC239_MASK	GENMASK(4, 0)
> -#define DSI_CMD2_BK0_GAMCTRL_VC247_MASK	GENMASK(5, 0)
> -#define DSI_CMD2_BK0_GAMCTRL_VC251_MASK	GENMASK(5, 0)
> -#define DSI_CMD2_BK0_GAMCTRL_VC255_MASK	GENMASK(4, 0)
> -#define DSI_CMD2_BK0_LNESET_LINE_MASK	GENMASK(6, 0)
> -#define DSI_CMD2_BK0_LNESET_LDE_EN	BIT(7)
> -#define DSI_CMD2_BK0_LNESET_LINEDELTA	GENMASK(1, 0)
> -#define DSI_CMD2_BK0_PORCTRL_VBP_MASK	GENMASK(7, 0)
> -#define DSI_CMD2_BK0_PORCTRL_VFP_MASK	GENMASK(7, 0)
> -#define DSI_CMD2_BK0_INVSEL_ONES_MASK	GENMASK(5, 4)
> -#define DSI_CMD2_BK0_INVSEL_NLINV_MASK	GENMASK(2, 0)
> -#define DSI_CMD2_BK0_INVSEL_RTNI_MASK	GENMASK(4, 0)
> +#define ST7701_CMD2_BK0_GAMCTRL_AJ_MASK		GENMASK(7, 6)
> +#define ST7701_CMD2_BK0_GAMCTRL_VC0_MASK	GENMASK(3, 0)
> +#define ST7701_CMD2_BK0_GAMCTRL_VC4_MASK	GENMASK(5, 0)
> +#define ST7701_CMD2_BK0_GAMCTRL_VC8_MASK	GENMASK(5, 0)
> +#define ST7701_CMD2_BK0_GAMCTRL_VC16_MASK	GENMASK(4, 0)
> +#define ST7701_CMD2_BK0_GAMCTRL_VC24_MASK	GENMASK(4, 0)
> +#define ST7701_CMD2_BK0_GAMCTRL_VC52_MASK	GENMASK(3, 0)
> +#define ST7701_CMD2_BK0_GAMCTRL_VC80_MASK	GENMASK(5, 0)
> +#define ST7701_CMD2_BK0_GAMCTRL_VC108_MASK	GENMASK(3, 0)
> +#define ST7701_CMD2_BK0_GAMCTRL_VC147_MASK	GENMASK(3, 0)
> +#define ST7701_CMD2_BK0_GAMCTRL_VC175_MASK	GENMASK(5, 0)
> +#define ST7701_CMD2_BK0_GAMCTRL_VC203_MASK	GENMASK(3, 0)
> +#define ST7701_CMD2_BK0_GAMCTRL_VC231_MASK	GENMASK(4, 0)
> +#define ST7701_CMD2_BK0_GAMCTRL_VC239_MASK	GENMASK(4, 0)
> +#define ST7701_CMD2_BK0_GAMCTRL_VC247_MASK	GENMASK(5, 0)
> +#define ST7701_CMD2_BK0_GAMCTRL_VC251_MASK	GENMASK(5, 0)
> +#define ST7701_CMD2_BK0_GAMCTRL_VC255_MASK	GENMASK(4, 0)
> +#define ST7701_CMD2_BK0_LNESET_LINE_MASK	GENMASK(6, 0)
> +#define ST7701_CMD2_BK0_LNESET_LDE_EN		BIT(7)
> +#define ST7701_CMD2_BK0_LNESET_LINEDELTA	GENMASK(1, 0)
> +#define ST7701_CMD2_BK0_PORCTRL_VBP_MASK	GENMASK(7, 0)
> +#define ST7701_CMD2_BK0_PORCTRL_VFP_MASK	GENMASK(7, 0)
> +#define ST7701_CMD2_BK0_INVSEL_ONES_MASK	GENMASK(5, 4)
> +#define ST7701_CMD2_BK0_INVSEL_NLINV_MASK	GENMASK(2, 0)
> +#define ST7701_CMD2_BK0_INVSEL_RTNI_MASK	GENMASK(4, 0)
>   
>   /* Command2, BK1 bytes */
> -#define DSI_CMD2_BK1_VRHA_MASK		GENMASK(7, 0)
> -#define DSI_CMD2_BK1_VCOM_MASK		GENMASK(7, 0)
> -#define DSI_CMD2_BK1_VGHSS_MASK		GENMASK(3, 0)
> -#define DSI_CMD2_BK1_TESTCMD_VAL	BIT(7)
> -#define DSI_CMD2_BK1_VGLS_ONES		BIT(6)
> -#define DSI_CMD2_BK1_VGLS_MASK		GENMASK(3, 0)
> -#define DSI_CMD2_BK1_PWRCTRL1_AP_MASK	GENMASK(7, 6)
> -#define DSI_CMD2_BK1_PWRCTRL1_APIS_MASK	GENMASK(3, 2)
> -#define DSI_CMD2_BK1_PWRCTRL1_APOS_MASK	GENMASK(1, 0)
> -#define DSI_CMD2_BK1_PWRCTRL2_AVDD_MASK	GENMASK(5, 4)
> -#define DSI_CMD2_BK1_PWRCTRL2_AVCL_MASK	GENMASK(1, 0)
> -#define DSI_CMD2_BK1_SPD1_ONES_MASK	GENMASK(6, 4)
> -#define DSI_CMD2_BK1_SPD1_T2D_MASK	GENMASK(3, 0)
> -#define DSI_CMD2_BK1_SPD2_ONES_MASK	GENMASK(6, 4)
> -#define DSI_CMD2_BK1_SPD2_T3D_MASK	GENMASK(3, 0)
> -#define DSI_CMD2_BK1_MIPISET1_ONES	BIT(7)
> -#define DSI_CMD2_BK1_MIPISET1_EOT_EN	BIT(3)
> +#define ST7701_CMD2_BK1_VRHA_MASK		GENMASK(7, 0)
> +#define ST7701_CMD2_BK1_VCOM_MASK		GENMASK(7, 0)
> +#define ST7701_CMD2_BK1_VGHSS_MASK		GENMASK(3, 0)
> +#define ST7701_CMD2_BK1_TESTCMD_VAL		BIT(7)
> +#define ST7701_CMD2_BK1_VGLS_ONES		BIT(6)
> +#define ST7701_CMD2_BK1_VGLS_MASK		GENMASK(3, 0)
> +#define ST7701_CMD2_BK1_PWRCTRL1_AP_MASK	GENMASK(7, 6)
> +#define ST7701_CMD2_BK1_PWRCTRL1_APIS_MASK	GENMASK(3, 2)
> +#define ST7701_CMD2_BK1_PWRCTRL1_APOS_MASK	GENMASK(1, 0)
> +#define ST7701_CMD2_BK1_PWRCTRL2_AVDD_MASK	GENMASK(5, 4)
> +#define ST7701_CMD2_BK1_PWRCTRL2_AVCL_MASK	GENMASK(1, 0)
> +#define ST7701_CMD2_BK1_SPD1_ONES_MASK		GENMASK(6, 4)
> +#define ST7701_CMD2_BK1_SPD1_T2D_MASK		GENMASK(3, 0)
> +#define ST7701_CMD2_BK1_SPD2_ONES_MASK		GENMASK(6, 4)
> +#define ST7701_CMD2_BK1_SPD2_T3D_MASK		GENMASK(3, 0)
> +#define ST7701_CMD2_BK1_MIPISET1_ONES		BIT(7)
> +#define ST7701_CMD2_BK1_MIPISET1_EOT_EN		BIT(3)
>   
>   #define CFIELD_PREP(_mask, _val)					\
>   	(((typeof(_mask))(_val) << (__builtin_ffsll(_mask) - 1)) & (_mask))
> @@ -149,7 +149,7 @@ static inline int st7701_dsi_write(struct st7701 *st7701, const void *seq,
>   	return mipi_dsi_dcs_write_buffer(st7701->dsi, seq, len);
>   }
>   
> -#define ST7701_DSI(st7701, seq...)				\
> +#define ST7701_WRITE(st7701, seq...)				\
>   	{							\
>   		const u8 d[] = { seq };				\
>   		st7701_dsi_write(st7701, d, ARRAY_SIZE(d));	\
> @@ -185,11 +185,11 @@ static void st7701_switch_cmd_bkx(struct st7701 *st7701, bool cmd2, u8 bkx)
>   	u8 val;
>   
>   	if (cmd2)
> -		val = DSI_CMD2 | FIELD_PREP(DSI_CMD2BK_MASK, bkx);
> +		val = ST7701_CMD2 | FIELD_PREP(ST7701_CMD2BK_MASK, bkx);
>   	else
> -		val = DSI_CMD1;
> +		val = ST7701_CMD1;
>   
> -	ST7701_DSI(st7701, DSI_CMD2BKX_SEL, 0x77, 0x01, 0x00, 0x00, val);
> +	ST7701_WRITE(st7701, ST7701_CMD2BKX_SEL, 0x77, 0x01, 0x00, 0x00, val);
>   }
>   
>   static void st7701_init_sequence(struct st7701 *st7701)
> @@ -199,21 +199,21 @@ static void st7701_init_sequence(struct st7701 *st7701)
>   	const u8 linecount8 = mode->vdisplay / 8;
>   	const u8 linecountrem2 = (mode->vdisplay % 8) / 2;
>   
> -	ST7701_DSI(st7701, MIPI_DCS_SOFT_RESET, 0x00);
> +	ST7701_WRITE(st7701, MIPI_DCS_SOFT_RESET, 0x00);
>   
>   	/* We need to wait 5ms before sending new commands */
>   	msleep(5);
>   
> -	ST7701_DSI(st7701, MIPI_DCS_EXIT_SLEEP_MODE, 0x00);
> +	ST7701_WRITE(st7701, MIPI_DCS_EXIT_SLEEP_MODE, 0x00);
>   
>   	msleep(st7701->sleep_delay);
>   
>   	/* Command2, BK0 */
>   	st7701_switch_cmd_bkx(st7701, true, 0);
>   
> -	mipi_dsi_dcs_write(st7701->dsi, DSI_CMD2_BK0_PVGAMCTRL,
> +	mipi_dsi_dcs_write(st7701->dsi, ST7701_CMD2_BK0_PVGAMCTRL,
>   			   desc->pv_gamma, ARRAY_SIZE(desc->pv_gamma));
> -	mipi_dsi_dcs_write(st7701->dsi, DSI_CMD2_BK0_NVGAMCTRL,
> +	mipi_dsi_dcs_write(st7701->dsi, ST7701_CMD2_BK0_NVGAMCTRL,
>   			   desc->nv_gamma, ARRAY_SIZE(desc->nv_gamma));
>   	/*
>   	 * Vertical line count configuration:
> @@ -226,14 +226,14 @@ static void st7701_init_sequence(struct st7701 *st7701)
>   	 * Total number of vertical lines:
>   	 * LN = ((Line[6:0] + 1) * 8) + (LDE_EN ? Line_delta[1:0] * 2 : 0)
>   	 */
> -	ST7701_DSI(st7701, DSI_CMD2_BK0_LNESET,
> -		   FIELD_PREP(DSI_CMD2_BK0_LNESET_LINE_MASK, linecount8 - 1) |
> -		   (linecountrem2 ? DSI_CMD2_BK0_LNESET_LDE_EN : 0),
> -		   FIELD_PREP(DSI_CMD2_BK0_LNESET_LINEDELTA, linecountrem2));
> -	ST7701_DSI(st7701, DSI_CMD2_BK0_PORCTRL,
> -		   FIELD_PREP(DSI_CMD2_BK0_PORCTRL_VBP_MASK,
> +	ST7701_WRITE(st7701, ST7701_CMD2_BK0_LNESET,
> +		   FIELD_PREP(ST7701_CMD2_BK0_LNESET_LINE_MASK, linecount8 - 1) |
> +		   (linecountrem2 ? ST7701_CMD2_BK0_LNESET_LDE_EN : 0),
> +		   FIELD_PREP(ST7701_CMD2_BK0_LNESET_LINEDELTA, linecountrem2));
> +	ST7701_WRITE(st7701, ST7701_CMD2_BK0_PORCTRL,
> +		   FIELD_PREP(ST7701_CMD2_BK0_PORCTRL_VBP_MASK,
>   			      mode->vtotal - mode->vsync_end),
> -		   FIELD_PREP(DSI_CMD2_BK0_PORCTRL_VFP_MASK,
> +		   FIELD_PREP(ST7701_CMD2_BK0_PORCTRL_VFP_MASK,
>   			      mode->vsync_start - mode->vdisplay));
>   	/*
>   	 * Horizontal pixel count configuration:
> @@ -241,70 +241,70 @@ static void st7701_init_sequence(struct st7701 *st7701)
>   	 * The PCLK is number of pixel clock per line, which matches
>   	 * mode htotal. The minimum is 512 PCLK.
>   	 */
> -	ST7701_DSI(st7701, DSI_CMD2_BK0_INVSEL,
> -		   DSI_CMD2_BK0_INVSEL_ONES_MASK |
> -		   FIELD_PREP(DSI_CMD2_BK0_INVSEL_NLINV_MASK, desc->nlinv),
> -		   FIELD_PREP(DSI_CMD2_BK0_INVSEL_RTNI_MASK,
> +	ST7701_WRITE(st7701, ST7701_CMD2_BK0_INVSEL,
> +		   ST7701_CMD2_BK0_INVSEL_ONES_MASK |
> +		   FIELD_PREP(ST7701_CMD2_BK0_INVSEL_NLINV_MASK, desc->nlinv),
> +		   FIELD_PREP(ST7701_CMD2_BK0_INVSEL_RTNI_MASK,
>   			      (clamp((u32)mode->htotal, 512U, 1008U) - 512) / 16));
>   
>   	/* Command2, BK1 */
>   	st7701_switch_cmd_bkx(st7701, true, 1);
>   
>   	/* Vop = 3.5375V + (VRHA[7:0] * 0.0125V) */
> -	ST7701_DSI(st7701, DSI_CMD2_BK1_VRHS,
> -		   FIELD_PREP(DSI_CMD2_BK1_VRHA_MASK,
> +	ST7701_WRITE(st7701, ST7701_CMD2_BK1_VRHS,
> +		   FIELD_PREP(ST7701_CMD2_BK1_VRHA_MASK,
>   			      DIV_ROUND_CLOSEST(desc->vop_uv - 3537500, 12500)));
>   
>   	/* Vcom = 0.1V + (VCOM[7:0] * 0.0125V) */
> -	ST7701_DSI(st7701, DSI_CMD2_BK1_VCOM,
> -		   FIELD_PREP(DSI_CMD2_BK1_VCOM_MASK,
> +	ST7701_WRITE(st7701, ST7701_CMD2_BK1_VCOM,
> +		   FIELD_PREP(ST7701_CMD2_BK1_VCOM_MASK,
>   			      DIV_ROUND_CLOSEST(desc->vcom_uv - 100000, 12500)));
>   
>   	/* Vgh = 11.5V + (VGHSS[7:0] * 0.5V) */
> -	ST7701_DSI(st7701, DSI_CMD2_BK1_VGHSS,
> -		   FIELD_PREP(DSI_CMD2_BK1_VGHSS_MASK,
> +	ST7701_WRITE(st7701, ST7701_CMD2_BK1_VGHSS,
> +		   FIELD_PREP(ST7701_CMD2_BK1_VGHSS_MASK,
>   			      DIV_ROUND_CLOSEST(clamp(desc->vgh_mv,
>   						      (u16)11500,
>   						      (u16)17000) - 11500,
>   						500)));
>   
> -	ST7701_DSI(st7701, DSI_CMD2_BK1_TESTCMD, DSI_CMD2_BK1_TESTCMD_VAL);
> +	ST7701_WRITE(st7701, ST7701_CMD2_BK1_TESTCMD, ST7701_CMD2_BK1_TESTCMD_VAL);
>   
>   	/* Vgl is non-linear */
> -	ST7701_DSI(st7701, DSI_CMD2_BK1_VGLS,
> -		   DSI_CMD2_BK1_VGLS_ONES |
> -		   FIELD_PREP(DSI_CMD2_BK1_VGLS_MASK, st7701_vgls_map(st7701)));
> +	ST7701_WRITE(st7701, ST7701_CMD2_BK1_VGLS,
> +		   ST7701_CMD2_BK1_VGLS_ONES |
> +		   FIELD_PREP(ST7701_CMD2_BK1_VGLS_MASK, st7701_vgls_map(st7701)));
>   
> -	ST7701_DSI(st7701, DSI_CMD2_BK1_PWCTLR1,
> -		   FIELD_PREP(DSI_CMD2_BK1_PWRCTRL1_AP_MASK,
> +	ST7701_WRITE(st7701, ST7701_CMD2_BK1_PWCTLR1,
> +		   FIELD_PREP(ST7701_CMD2_BK1_PWRCTRL1_AP_MASK,
>   			      desc->gamma_op_bias) |
> -		   FIELD_PREP(DSI_CMD2_BK1_PWRCTRL1_APIS_MASK,
> +		   FIELD_PREP(ST7701_CMD2_BK1_PWRCTRL1_APIS_MASK,
>   			      desc->input_op_bias) |
> -		   FIELD_PREP(DSI_CMD2_BK1_PWRCTRL1_APOS_MASK,
> +		   FIELD_PREP(ST7701_CMD2_BK1_PWRCTRL1_APOS_MASK,
>   			      desc->output_op_bias));
>   
>   	/* Avdd = 6.2V + (AVDD[1:0] * 0.2V) , Avcl = -4.4V - (AVCL[1:0] * 0.2V) */
> -	ST7701_DSI(st7701, DSI_CMD2_BK1_PWCTLR2,
> -		   FIELD_PREP(DSI_CMD2_BK1_PWRCTRL2_AVDD_MASK,
> +	ST7701_WRITE(st7701, ST7701_CMD2_BK1_PWCTLR2,
> +		   FIELD_PREP(ST7701_CMD2_BK1_PWRCTRL2_AVDD_MASK,
>   			      DIV_ROUND_CLOSEST(desc->avdd_mv - 6200, 200)) |
> -		   FIELD_PREP(DSI_CMD2_BK1_PWRCTRL2_AVCL_MASK,
> +		   FIELD_PREP(ST7701_CMD2_BK1_PWRCTRL2_AVCL_MASK,
>   			      DIV_ROUND_CLOSEST(-4400 - desc->avcl_mv, 200)));
>   
>   	/* T2D = 0.2us * T2D[3:0] */
> -	ST7701_DSI(st7701, DSI_CMD2_BK1_SPD1,
> -		   DSI_CMD2_BK1_SPD1_ONES_MASK |
> -		   FIELD_PREP(DSI_CMD2_BK1_SPD1_T2D_MASK,
> +	ST7701_WRITE(st7701, ST7701_CMD2_BK1_SPD1,
> +		   ST7701_CMD2_BK1_SPD1_ONES_MASK |
> +		   FIELD_PREP(ST7701_CMD2_BK1_SPD1_T2D_MASK,
>   			      DIV_ROUND_CLOSEST(desc->t2d_ns, 200)));
>   
>   	/* T3D = 4us + (0.8us * T3D[3:0]) */
> -	ST7701_DSI(st7701, DSI_CMD2_BK1_SPD2,
> -		   DSI_CMD2_BK1_SPD2_ONES_MASK |
> -		   FIELD_PREP(DSI_CMD2_BK1_SPD2_T3D_MASK,
> +	ST7701_WRITE(st7701, ST7701_CMD2_BK1_SPD2,
> +		   ST7701_CMD2_BK1_SPD2_ONES_MASK |
> +		   FIELD_PREP(ST7701_CMD2_BK1_SPD2_T3D_MASK,
>   			      DIV_ROUND_CLOSEST(desc->t3d_ns - 4000, 800)));
>   
> -	ST7701_DSI(st7701, DSI_CMD2_BK1_MIPISET1,
> -		   DSI_CMD2_BK1_MIPISET1_ONES |
> -		   (desc->eot_en ? DSI_CMD2_BK1_MIPISET1_EOT_EN : 0));
> +	ST7701_WRITE(st7701, ST7701_CMD2_BK1_MIPISET1,
> +		   ST7701_CMD2_BK1_MIPISET1_ONES |
> +		   (desc->eot_en ? ST7701_CMD2_BK1_MIPISET1_EOT_EN : 0));
>   }
>   
>   static void ts8550b_gip_sequence(struct st7701 *st7701)
> @@ -313,89 +313,89 @@ static void ts8550b_gip_sequence(struct st7701 *st7701)
>   	 * ST7701_SPEC_V1.2 is unable to provide enough information above this
>   	 * specific command sequence, so grab the same from vendor BSP driver.
>   	 */
> -	ST7701_DSI(st7701, 0xE0, 0x00, 0x00, 0x02);
> -	ST7701_DSI(st7701, 0xE1, 0x0B, 0x00, 0x0D, 0x00, 0x0C, 0x00, 0x0E,
> +	ST7701_WRITE(st7701, 0xE0, 0x00, 0x00, 0x02);
> +	ST7701_WRITE(st7701, 0xE1, 0x0B, 0x00, 0x0D, 0x00, 0x0C, 0x00, 0x0E,
>   		   0x00, 0x00, 0x44, 0x44);
> -	ST7701_DSI(st7701, 0xE2, 0x33, 0x33, 0x44, 0x44, 0x64, 0x00, 0x66,
> +	ST7701_WRITE(st7701, 0xE2, 0x33, 0x33, 0x44, 0x44, 0x64, 0x00, 0x66,
>   		   0x00, 0x65, 0x00, 0x67, 0x00, 0x00);
> -	ST7701_DSI(st7701, 0xE3, 0x00, 0x00, 0x33, 0x33);
> -	ST7701_DSI(st7701, 0xE4, 0x44, 0x44);
> -	ST7701_DSI(st7701, 0xE5, 0x0C, 0x78, 0x3C, 0xA0, 0x0E, 0x78, 0x3C,
> +	ST7701_WRITE(st7701, 0xE3, 0x00, 0x00, 0x33, 0x33);
> +	ST7701_WRITE(st7701, 0xE4, 0x44, 0x44);
> +	ST7701_WRITE(st7701, 0xE5, 0x0C, 0x78, 0x3C, 0xA0, 0x0E, 0x78, 0x3C,
>   		   0xA0, 0x10, 0x78, 0x3C, 0xA0, 0x12, 0x78, 0x3C, 0xA0);
> -	ST7701_DSI(st7701, 0xE6, 0x00, 0x00, 0x33, 0x33);
> -	ST7701_DSI(st7701, 0xE7, 0x44, 0x44);
> -	ST7701_DSI(st7701, 0xE8, 0x0D, 0x78, 0x3C, 0xA0, 0x0F, 0x78, 0x3C,
> +	ST7701_WRITE(st7701, 0xE6, 0x00, 0x00, 0x33, 0x33);
> +	ST7701_WRITE(st7701, 0xE7, 0x44, 0x44);
> +	ST7701_WRITE(st7701, 0xE8, 0x0D, 0x78, 0x3C, 0xA0, 0x0F, 0x78, 0x3C,
>   		   0xA0, 0x11, 0x78, 0x3C, 0xA0, 0x13, 0x78, 0x3C, 0xA0);
> -	ST7701_DSI(st7701, 0xEB, 0x02, 0x02, 0x39, 0x39, 0xEE, 0x44, 0x00);
> -	ST7701_DSI(st7701, 0xEC, 0x00, 0x00);
> -	ST7701_DSI(st7701, 0xED, 0xFF, 0xF1, 0x04, 0x56, 0x72, 0x3F, 0xFF,
> +	ST7701_WRITE(st7701, 0xEB, 0x02, 0x02, 0x39, 0x39, 0xEE, 0x44, 0x00);
> +	ST7701_WRITE(st7701, 0xEC, 0x00, 0x00);
> +	ST7701_WRITE(st7701, 0xED, 0xFF, 0xF1, 0x04, 0x56, 0x72, 0x3F, 0xFF,
>   		   0xFF, 0xFF, 0xFF, 0xF3, 0x27, 0x65, 0x40, 0x1F, 0xFF);
>   }
>   
>   static void dmt028vghmcmi_1a_gip_sequence(struct st7701 *st7701)
>   {
> -	ST7701_DSI(st7701, 0xEE, 0x42);
> -	ST7701_DSI(st7701, 0xE0, 0x00, 0x00, 0x02);
> +	ST7701_WRITE(st7701, 0xEE, 0x42);
> +	ST7701_WRITE(st7701, 0xE0, 0x00, 0x00, 0x02);
>   
> -	ST7701_DSI(st7701, 0xE1,
> +	ST7701_WRITE(st7701, 0xE1,
>   		   0x04, 0xA0, 0x06, 0xA0,
>   			   0x05, 0xA0, 0x07, 0xA0,
>   			   0x00, 0x44, 0x44);
> -	ST7701_DSI(st7701, 0xE2,
> +	ST7701_WRITE(st7701, 0xE2,
>   		   0x00, 0x00, 0x00, 0x00,
>   			   0x00, 0x00, 0x00, 0x00,
>   			   0x00, 0x00, 0x00, 0x00);
> -	ST7701_DSI(st7701, 0xE3,
> +	ST7701_WRITE(st7701, 0xE3,
>   		   0x00, 0x00, 0x22, 0x22);
> -	ST7701_DSI(st7701, 0xE4, 0x44, 0x44);
> -	ST7701_DSI(st7701, 0xE5,
> +	ST7701_WRITE(st7701, 0xE4, 0x44, 0x44);
> +	ST7701_WRITE(st7701, 0xE5,
>   		   0x0C, 0x90, 0xA0, 0xA0,
>   			   0x0E, 0x92, 0xA0, 0xA0,
>   			   0x08, 0x8C, 0xA0, 0xA0,
>   			   0x0A, 0x8E, 0xA0, 0xA0);
> -	ST7701_DSI(st7701, 0xE6,
> +	ST7701_WRITE(st7701, 0xE6,
>   		   0x00, 0x00, 0x22, 0x22);
> -	ST7701_DSI(st7701, 0xE7, 0x44, 0x44);
> -	ST7701_DSI(st7701, 0xE8,
> +	ST7701_WRITE(st7701, 0xE7, 0x44, 0x44);
> +	ST7701_WRITE(st7701, 0xE8,
>   		   0x0D, 0x91, 0xA0, 0xA0,
>   			   0x0F, 0x93, 0xA0, 0xA0,
>   			   0x09, 0x8D, 0xA0, 0xA0,
>   			   0x0B, 0x8F, 0xA0, 0xA0);
> -	ST7701_DSI(st7701, 0xEB,
> +	ST7701_WRITE(st7701, 0xEB,
>   		   0x00, 0x00, 0xE4, 0xE4,
>   			   0x44, 0x00, 0x00);
> -	ST7701_DSI(st7701, 0xED,
> +	ST7701_WRITE(st7701, 0xED,
>   		   0xFF, 0xF5, 0x47, 0x6F,
>   			   0x0B, 0xA1, 0xAB, 0xFF,
>   			   0xFF, 0xBA, 0x1A, 0xB0,
>   			   0xF6, 0x74, 0x5F, 0xFF);
> -	ST7701_DSI(st7701, 0xEF,
> +	ST7701_WRITE(st7701, 0xEF,
>   		   0x08, 0x08, 0x08, 0x40,
>   			   0x3F, 0x64);
>   
>   	st7701_switch_cmd_bkx(st7701, false, 0);
>   
>   	st7701_switch_cmd_bkx(st7701, true, 3);
> -	ST7701_DSI(st7701, 0xE6, 0x7C);
> -	ST7701_DSI(st7701, 0xE8, 0x00, 0x0E);
> +	ST7701_WRITE(st7701, 0xE6, 0x7C);
> +	ST7701_WRITE(st7701, 0xE8, 0x00, 0x0E);
>   
>   	st7701_switch_cmd_bkx(st7701, false, 0);
> -	ST7701_DSI(st7701, 0x11);
> +	ST7701_WRITE(st7701, 0x11);
>   	msleep(120);
>   
>   	st7701_switch_cmd_bkx(st7701, true, 3);
> -	ST7701_DSI(st7701, 0xE8, 0x00, 0x0C);
> +	ST7701_WRITE(st7701, 0xE8, 0x00, 0x0C);
>   	msleep(10);
> -	ST7701_DSI(st7701, 0xE8, 0x00, 0x00);
> +	ST7701_WRITE(st7701, 0xE8, 0x00, 0x00);
>   
>   	st7701_switch_cmd_bkx(st7701, false, 0);
> -	ST7701_DSI(st7701, 0x11);
> +	ST7701_WRITE(st7701, 0x11);
>   	msleep(120);
> -	ST7701_DSI(st7701, 0xE8, 0x00, 0x00);
> +	ST7701_WRITE(st7701, 0xE8, 0x00, 0x00);
>   
>   	st7701_switch_cmd_bkx(st7701, false, 0);
>   
> -	ST7701_DSI(st7701, 0x3A, 0x70);
> +	ST7701_WRITE(st7701, 0x3A, 0x70);
>   }
>   
>   static void kd50t048a_gip_sequence(struct st7701 *st7701)
> @@ -404,58 +404,58 @@ static void kd50t048a_gip_sequence(struct st7701 *st7701)
>   	 * ST7701_SPEC_V1.2 is unable to provide enough information above this
>   	 * specific command sequence, so grab the same from vendor BSP driver.
>   	 */
> -	ST7701_DSI(st7701, 0xE0, 0x00, 0x00, 0x02);
> -	ST7701_DSI(st7701, 0xE1, 0x08, 0x00, 0x0A, 0x00, 0x07, 0x00, 0x09,
> +	ST7701_WRITE(st7701, 0xE0, 0x00, 0x00, 0x02);
> +	ST7701_WRITE(st7701, 0xE1, 0x08, 0x00, 0x0A, 0x00, 0x07, 0x00, 0x09,
>   		   0x00, 0x00, 0x33, 0x33);
> -	ST7701_DSI(st7701, 0xE2, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	ST7701_WRITE(st7701, 0xE2, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>   		   0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
> -	ST7701_DSI(st7701, 0xE3, 0x00, 0x00, 0x33, 0x33);
> -	ST7701_DSI(st7701, 0xE4, 0x44, 0x44);
> -	ST7701_DSI(st7701, 0xE5, 0x0E, 0x60, 0xA0, 0xA0, 0x10, 0x60, 0xA0,
> +	ST7701_WRITE(st7701, 0xE3, 0x00, 0x00, 0x33, 0x33);
> +	ST7701_WRITE(st7701, 0xE4, 0x44, 0x44);
> +	ST7701_WRITE(st7701, 0xE5, 0x0E, 0x60, 0xA0, 0xA0, 0x10, 0x60, 0xA0,
>   		   0xA0, 0x0A, 0x60, 0xA0, 0xA0, 0x0C, 0x60, 0xA0, 0xA0);
> -	ST7701_DSI(st7701, 0xE6, 0x00, 0x00, 0x33, 0x33);
> -	ST7701_DSI(st7701, 0xE7, 0x44, 0x44);
> -	ST7701_DSI(st7701, 0xE8, 0x0D, 0x60, 0xA0, 0xA0, 0x0F, 0x60, 0xA0,
> +	ST7701_WRITE(st7701, 0xE6, 0x00, 0x00, 0x33, 0x33);
> +	ST7701_WRITE(st7701, 0xE7, 0x44, 0x44);
> +	ST7701_WRITE(st7701, 0xE8, 0x0D, 0x60, 0xA0, 0xA0, 0x0F, 0x60, 0xA0,
>   		   0xA0, 0x09, 0x60, 0xA0, 0xA0, 0x0B, 0x60, 0xA0, 0xA0);
> -	ST7701_DSI(st7701, 0xEB, 0x02, 0x01, 0xE4, 0xE4, 0x44, 0x00, 0x40);
> -	ST7701_DSI(st7701, 0xEC, 0x02, 0x01);
> -	ST7701_DSI(st7701, 0xED, 0xAB, 0x89, 0x76, 0x54, 0x01, 0xFF, 0xFF,
> +	ST7701_WRITE(st7701, 0xEB, 0x02, 0x01, 0xE4, 0xE4, 0x44, 0x00, 0x40);
> +	ST7701_WRITE(st7701, 0xEC, 0x02, 0x01);
> +	ST7701_WRITE(st7701, 0xED, 0xAB, 0x89, 0x76, 0x54, 0x01, 0xFF, 0xFF,
>   		   0xFF, 0xFF, 0xFF, 0xFF, 0x10, 0x45, 0x67, 0x98, 0xBA);
>   }
>   
>   static void rg_arc_gip_sequence(struct st7701 *st7701)
>   {
>   	st7701_switch_cmd_bkx(st7701, true, 3);
> -	ST7701_DSI(st7701, 0xEF, 0x08);
> +	ST7701_WRITE(st7701, 0xEF, 0x08);
>   	st7701_switch_cmd_bkx(st7701, true, 0);
> -	ST7701_DSI(st7701, 0xC7, 0x04);
> -	ST7701_DSI(st7701, 0xCC, 0x38);
> +	ST7701_WRITE(st7701, 0xC7, 0x04);
> +	ST7701_WRITE(st7701, 0xCC, 0x38);
>   	st7701_switch_cmd_bkx(st7701, true, 1);
> -	ST7701_DSI(st7701, 0xB9, 0x10);
> -	ST7701_DSI(st7701, 0xBC, 0x03);
> -	ST7701_DSI(st7701, 0xC0, 0x89);
> -	ST7701_DSI(st7701, 0xE0, 0x00, 0x00, 0x02);
> -	ST7701_DSI(st7701, 0xE1, 0x04, 0x00, 0x00, 0x00, 0x05, 0x00, 0x00,
> +	ST7701_WRITE(st7701, 0xB9, 0x10);
> +	ST7701_WRITE(st7701, 0xBC, 0x03);
> +	ST7701_WRITE(st7701, 0xC0, 0x89);
> +	ST7701_WRITE(st7701, 0xE0, 0x00, 0x00, 0x02);
> +	ST7701_WRITE(st7701, 0xE1, 0x04, 0x00, 0x00, 0x00, 0x05, 0x00, 0x00,
>   		   0x00, 0x00, 0x20, 0x20);
> -	ST7701_DSI(st7701, 0xE2, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	ST7701_WRITE(st7701, 0xE2, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>   		   0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
> -	ST7701_DSI(st7701, 0xE3, 0x00, 0x00, 0x33, 0x00);
> -	ST7701_DSI(st7701, 0xE4, 0x22, 0x00);
> -	ST7701_DSI(st7701, 0xE5, 0x04, 0x5C, 0xA0, 0xA0, 0x06, 0x5C, 0xA0,
> +	ST7701_WRITE(st7701, 0xE3, 0x00, 0x00, 0x33, 0x00);
> +	ST7701_WRITE(st7701, 0xE4, 0x22, 0x00);
> +	ST7701_WRITE(st7701, 0xE5, 0x04, 0x5C, 0xA0, 0xA0, 0x06, 0x5C, 0xA0,
>   		   0xA0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
> -	ST7701_DSI(st7701, 0xE6, 0x00, 0x00, 0x33, 0x00);
> -	ST7701_DSI(st7701, 0xE7, 0x22, 0x00);
> -	ST7701_DSI(st7701, 0xE8, 0x05, 0x5C, 0xA0, 0xA0, 0x07, 0x5C, 0xA0,
> +	ST7701_WRITE(st7701, 0xE6, 0x00, 0x00, 0x33, 0x00);
> +	ST7701_WRITE(st7701, 0xE7, 0x22, 0x00);
> +	ST7701_WRITE(st7701, 0xE8, 0x05, 0x5C, 0xA0, 0xA0, 0x07, 0x5C, 0xA0,
>   		   0xA0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
> -	ST7701_DSI(st7701, 0xEB, 0x02, 0x00, 0x40, 0x40, 0x00, 0x00, 0x00);
> -	ST7701_DSI(st7701, 0xEC, 0x00, 0x00);
> -	ST7701_DSI(st7701, 0xED, 0xFA, 0x45, 0x0B, 0xFF, 0xFF, 0xFF, 0xFF,
> +	ST7701_WRITE(st7701, 0xEB, 0x02, 0x00, 0x40, 0x40, 0x00, 0x00, 0x00);
> +	ST7701_WRITE(st7701, 0xEC, 0x00, 0x00);
> +	ST7701_WRITE(st7701, 0xED, 0xFA, 0x45, 0x0B, 0xFF, 0xFF, 0xFF, 0xFF,
>   		   0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xB0, 0x54, 0xAF);
> -	ST7701_DSI(st7701, 0xEF, 0x08, 0x08, 0x08, 0x45, 0x3F, 0x54);
> +	ST7701_WRITE(st7701, 0xEF, 0x08, 0x08, 0x08, 0x45, 0x3F, 0x54);
>   	st7701_switch_cmd_bkx(st7701, false, 0);
> -	ST7701_DSI(st7701, MIPI_DCS_SET_ADDRESS_MODE, 0x17);
> -	ST7701_DSI(st7701, MIPI_DCS_SET_PIXEL_FORMAT, 0x77);
> -	ST7701_DSI(st7701, MIPI_DCS_EXIT_SLEEP_MODE, 0x00);
> +	ST7701_WRITE(st7701, MIPI_DCS_SET_ADDRESS_MODE, 0x17);
> +	ST7701_WRITE(st7701, MIPI_DCS_SET_PIXEL_FORMAT, 0x77);
> +	ST7701_WRITE(st7701, MIPI_DCS_EXIT_SLEEP_MODE, 0x00);
>   	msleep(120);
>   }
>   
> @@ -490,7 +490,7 @@ static int st7701_enable(struct drm_panel *panel)
>   {
>   	struct st7701 *st7701 = panel_to_st7701(panel);
>   
> -	ST7701_DSI(st7701, MIPI_DCS_SET_DISPLAY_ON, 0x00);
> +	ST7701_WRITE(st7701, MIPI_DCS_SET_DISPLAY_ON, 0x00);
>   
>   	return 0;
>   }
> @@ -499,7 +499,7 @@ static int st7701_disable(struct drm_panel *panel)
>   {
>   	struct st7701 *st7701 = panel_to_st7701(panel);
>   
> -	ST7701_DSI(st7701, MIPI_DCS_SET_DISPLAY_OFF, 0x00);
> +	ST7701_WRITE(st7701, MIPI_DCS_SET_DISPLAY_OFF, 0x00);
>   
>   	return 0;
>   }
> @@ -508,7 +508,7 @@ static int st7701_unprepare(struct drm_panel *panel)
>   {
>   	struct st7701 *st7701 = panel_to_st7701(panel);
>   
> -	ST7701_DSI(st7701, MIPI_DCS_ENTER_SLEEP_MODE, 0x00);
> +	ST7701_WRITE(st7701, MIPI_DCS_ENTER_SLEEP_MODE, 0x00);
>   
>   	msleep(st7701->sleep_delay);
>   
> @@ -602,62 +602,62 @@ static const struct st7701_panel_desc ts8550b_desc = {
>   	.panel_sleep_delay = 80, /* panel need extra 80ms for sleep out cmd */
>   
>   	.pv_gamma = {
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC0_MASK, 0),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC4_MASK, 0xe),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC8_MASK, 0x15),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC16_MASK, 0xf),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC0_MASK, 0),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC4_MASK, 0xe),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC8_MASK, 0x15),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC16_MASK, 0xf),
>   
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC24_MASK, 0x11),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC52_MASK, 0x8),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC80_MASK, 0x8),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC108_MASK, 0x8),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC24_MASK, 0x11),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC52_MASK, 0x8),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC80_MASK, 0x8),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC108_MASK, 0x8),
>   
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC147_MASK, 0x8),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC175_MASK, 0x23),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC203_MASK, 0x4),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC231_MASK, 0x13),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC147_MASK, 0x8),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC175_MASK, 0x23),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC203_MASK, 0x4),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC231_MASK, 0x13),
>   
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC239_MASK, 0x12),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC247_MASK, 0x2b),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC251_MASK, 0x34),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC255_MASK, 0x1f)
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC239_MASK, 0x12),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC247_MASK, 0x2b),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC251_MASK, 0x34),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC255_MASK, 0x1f)
>   	},
>   	.nv_gamma = {
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC0_MASK, 0),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC4_MASK, 0xe),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0x2) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC8_MASK, 0x15),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC16_MASK, 0xf),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC0_MASK, 0),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC4_MASK, 0xe),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0x2) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC8_MASK, 0x15),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC16_MASK, 0xf),
>   
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC24_MASK, 0x13),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC52_MASK, 0x7),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC80_MASK, 0x9),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC108_MASK, 0x8),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC24_MASK, 0x13),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC52_MASK, 0x7),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC80_MASK, 0x9),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC108_MASK, 0x8),
>   
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC147_MASK, 0x8),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC175_MASK, 0x22),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC203_MASK, 0x4),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC231_MASK, 0x10),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC147_MASK, 0x8),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC175_MASK, 0x22),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC203_MASK, 0x4),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC231_MASK, 0x10),
>   
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC239_MASK, 0xe),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC247_MASK, 0x2c),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC251_MASK, 0x34),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC255_MASK, 0x1f)
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC239_MASK, 0xe),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC247_MASK, 0x2c),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC251_MASK, 0x34),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC255_MASK, 0x1f)
>   	},
>   	.nlinv = 7,
>   	.vop_uv = 4400000,
> @@ -703,62 +703,62 @@ static const struct st7701_panel_desc dmt028vghmcmi_1a_desc = {
>   	.panel_sleep_delay = 5, /* panel need extra 5ms for sleep out cmd */
>   
>   	.pv_gamma = {
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC0_MASK, 0),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC4_MASK, 0x10),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC8_MASK, 0x17),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC16_MASK, 0xd),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC0_MASK, 0),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC4_MASK, 0x10),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC8_MASK, 0x17),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC16_MASK, 0xd),
>   
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC24_MASK, 0x11),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC52_MASK, 0x6),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC80_MASK, 0x5),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC108_MASK, 0x8),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC24_MASK, 0x11),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC52_MASK, 0x6),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC80_MASK, 0x5),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC108_MASK, 0x8),
>   
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC147_MASK, 0x7),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC175_MASK, 0x1f),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC203_MASK, 0x4),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC231_MASK, 0x11),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC147_MASK, 0x7),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC175_MASK, 0x1f),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC203_MASK, 0x4),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC231_MASK, 0x11),
>   
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC239_MASK, 0xe),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC247_MASK, 0x29),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC251_MASK, 0x30),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC255_MASK, 0x1f)
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC239_MASK, 0xe),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC247_MASK, 0x29),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC251_MASK, 0x30),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC255_MASK, 0x1f)
>   	},
>   	.nv_gamma = {
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC0_MASK, 0),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC4_MASK, 0xd),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC8_MASK, 0x14),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC16_MASK, 0xe),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC0_MASK, 0),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC4_MASK, 0xd),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC8_MASK, 0x14),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC16_MASK, 0xe),
>   
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC24_MASK, 0x11),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC52_MASK, 0x6),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC80_MASK, 0x4),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC108_MASK, 0x8),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC24_MASK, 0x11),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC52_MASK, 0x6),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC80_MASK, 0x4),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC108_MASK, 0x8),
>   
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC147_MASK, 0x8),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC175_MASK, 0x20),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC203_MASK, 0x5),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC231_MASK, 0x13),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC147_MASK, 0x8),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC175_MASK, 0x20),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC203_MASK, 0x5),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC231_MASK, 0x13),
>   
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC239_MASK, 0x13),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC247_MASK, 0x26),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC251_MASK, 0x30),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC255_MASK, 0x1f)
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC239_MASK, 0x13),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC247_MASK, 0x26),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC251_MASK, 0x30),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC255_MASK, 0x1f)
>   	},
>   	.nlinv = 1,
>   	.vop_uv = 4800000,
> @@ -802,62 +802,62 @@ static const struct st7701_panel_desc kd50t048a_desc = {
>   	.panel_sleep_delay = 0,
>   
>   	.pv_gamma = {
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC0_MASK, 0),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC4_MASK, 0xd),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC8_MASK, 0x14),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC16_MASK, 0xd),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC0_MASK, 0),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC4_MASK, 0xd),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC8_MASK, 0x14),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC16_MASK, 0xd),
>   
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC24_MASK, 0x10),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC52_MASK, 0x5),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC80_MASK, 0x2),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC108_MASK, 0x8),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC24_MASK, 0x10),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC52_MASK, 0x5),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC80_MASK, 0x2),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC108_MASK, 0x8),
>   
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC147_MASK, 0x8),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC175_MASK, 0x1e),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC203_MASK, 0x5),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC231_MASK, 0x13),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC147_MASK, 0x8),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC175_MASK, 0x1e),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC203_MASK, 0x5),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC231_MASK, 0x13),
>   
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC239_MASK, 0x11),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 2) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC247_MASK, 0x23),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC251_MASK, 0x29),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC255_MASK, 0x18)
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC239_MASK, 0x11),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 2) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC247_MASK, 0x23),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC251_MASK, 0x29),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC255_MASK, 0x18)
>   	},
>   	.nv_gamma = {
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC0_MASK, 0),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC4_MASK, 0xc),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC8_MASK, 0x14),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC16_MASK, 0xc),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC0_MASK, 0),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC4_MASK, 0xc),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC8_MASK, 0x14),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC16_MASK, 0xc),
>   
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC24_MASK, 0x10),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC52_MASK, 0x5),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC80_MASK, 0x3),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC108_MASK, 0x8),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC24_MASK, 0x10),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC52_MASK, 0x5),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC80_MASK, 0x3),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC108_MASK, 0x8),
>   
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC147_MASK, 0x7),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC175_MASK, 0x20),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC203_MASK, 0x5),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC231_MASK, 0x13),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC147_MASK, 0x7),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC175_MASK, 0x20),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC203_MASK, 0x5),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC231_MASK, 0x13),
>   
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC239_MASK, 0x11),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 2) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC247_MASK, 0x24),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC251_MASK, 0x29),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC255_MASK, 0x18)
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC239_MASK, 0x11),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 2) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC247_MASK, 0x24),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC251_MASK, 0x29),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC255_MASK, 0x18)
>   	},
>   	.nlinv = 1,
>   	.vop_uv = 4887500,
> @@ -901,62 +901,62 @@ static const struct st7701_panel_desc rg_arc_desc = {
>   	.panel_sleep_delay = 80,
>   
>   	.pv_gamma = {
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0x01) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC0_MASK, 0),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC4_MASK, 0x16),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC8_MASK, 0x1d),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC16_MASK, 0x0e),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0x01) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC0_MASK, 0),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC4_MASK, 0x16),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC8_MASK, 0x1d),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC16_MASK, 0x0e),
>   
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC24_MASK, 0x12),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC52_MASK, 0x06),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC80_MASK, 0x0c),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC108_MASK, 0x0a),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC24_MASK, 0x12),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC52_MASK, 0x06),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC80_MASK, 0x0c),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC108_MASK, 0x0a),
>   
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC147_MASK, 0x09),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC175_MASK, 0x25),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC203_MASK, 0x00),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC231_MASK, 0x03),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC147_MASK, 0x09),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC175_MASK, 0x25),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC203_MASK, 0x00),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC231_MASK, 0x03),
>   
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC239_MASK, 0x00),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC247_MASK, 0x3f),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC251_MASK, 0x3f),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC255_MASK, 0x1c)
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC239_MASK, 0x00),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC247_MASK, 0x3f),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC251_MASK, 0x3f),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC255_MASK, 0x1c)
>   	},
>   	.nv_gamma = {
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0x01) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC0_MASK, 0),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC4_MASK, 0x16),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC8_MASK, 0x1e),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC16_MASK, 0x0e),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0x01) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC0_MASK, 0),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC4_MASK, 0x16),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC8_MASK, 0x1e),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC16_MASK, 0x0e),
>   
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC24_MASK, 0x11),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC52_MASK, 0x06),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC80_MASK, 0x0c),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC108_MASK, 0x08),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC24_MASK, 0x11),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC52_MASK, 0x06),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC80_MASK, 0x0c),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC108_MASK, 0x08),
>   
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC147_MASK, 0x09),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC175_MASK, 0x26),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC203_MASK, 0x00),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC231_MASK, 0x15),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC147_MASK, 0x09),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC175_MASK, 0x26),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC203_MASK, 0x00),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC231_MASK, 0x15),
>   
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC239_MASK, 0x00),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC247_MASK, 0x3f),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC251_MASK, 0x3f),
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> -		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC255_MASK, 0x1c)
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC239_MASK, 0x00),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC247_MASK, 0x3f),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC251_MASK, 0x3f),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC255_MASK, 0x1c)
>   	},
>   	.nlinv = 0,
>   	.vop_uv = 4500000,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

