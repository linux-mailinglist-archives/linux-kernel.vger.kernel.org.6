Return-Path: <linux-kernel+bounces-260733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E02FD93AD86
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FBBE1C21D60
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 07:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C081613792B;
	Wed, 24 Jul 2024 07:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oCIfiGUy"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C415A130E4B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 07:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721807645; cv=none; b=T3Vq94QeqoGTOx3aVp80h21UWHc1jDpkUHi8eoseGH1O62NggDNUQMDErPtUGkeekpbBFgib1e75n1nTFkV7/4X3PJ4fzDfKjiKfofcvDm2aOc3S/N/86v+sMaE3/ilU3AFfT6P9h5UkY4FHkJMRgb8Q3n7X9i8vUo5VNXUd2k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721807645; c=relaxed/simple;
	bh=XQpfvYgegD8PoJ6PiUH7vxAZP95OyJmUHA17zKYaf/A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=b08eDdRmHhl/YHRyO56CALpROdyz+vCvPvhMtmVBcLUL6Bi8DTNMDkIkw1iOlxBAsfmtlzzpQhc2zbF2f0Ne3aPqt2KLXr2py2EBPy14KlyDm05+OVKPzjx9ZYmp3nNE3KCz9P8A+TM1k6roGH9LDIyvFkChOLV7vt2A1DZWdXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oCIfiGUy; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ef2cce8be8so38311781fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 00:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721807642; x=1722412442; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vP0qto6AtbpqbEEODbflqyeI8tfbqmdr60YxUrHC9l4=;
        b=oCIfiGUyxNZkm2ehE2vvWjqpMeVXNRB8QnuWzf4fMbnS8PIc5lXucCqZijbYOf6jXe
         6sdASxRw3TrKssBEcMDUHhFraPwOdt8T8LkutFrnOBKSUj5qYZbAT2WF14/AgG/wqTM/
         k24r7F5ahKhH0YGhndWKw0tMxrqwJUxF2pp/t2ZvbWQJFut1qbKimliS7ka7pvX1HXL1
         2oLoTVOofnZJBEP7Z7HW27LmCLrYU0exUT4GV8bYCcFRXzbcVIiHrCQFNUxtKR1WYm1P
         iAm+S9a5TyjYTfz7R51qP5sI7S5kVav9DBPA/lygYEG41M/7cAE9g6FCI3LQR5q7N4WU
         smtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721807642; x=1722412442;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vP0qto6AtbpqbEEODbflqyeI8tfbqmdr60YxUrHC9l4=;
        b=WupleJctF+5l4pd/0Wa1ba21SSBpvDRN2YqbCmsDssJ+dNzo053eMM4Fmc6BBWIVXB
         NJ/gZYeQEu3wtvqO/rHuu/+Nk/MEs9NLiDMSKn/6u69b4V+njPvdtFi/lbcZ3e4W0WyA
         IPaYuXMS5MGUI4HNx+BqHJwRYscn9Z46G8jsFFbGElSEXqXupAeMW2nQ9w+Vac5JfYA/
         A+agz6S4kS5cl0fqRDcbk6RMaUCc3dni5vEawn9TwsTBmFOrmIPFgoO4lU7hj+dcjNsy
         CvCXeaN8a4eb3FFPhQaHXuj/RxYkh9R6Vq7/7hRDHLDD38dC9ka979ktTY6KbdHY4/LM
         J8MA==
X-Forwarded-Encrypted: i=1; AJvYcCV07LiV2/Ap4NbJB/Hly6vwt2U3F7Fls9yoTDsHIC7U07ttdCGuUonWVfIqBQfEsHH8cC58XP9+dKrusyQDOERLXDBOSV/jGeNZflia
X-Gm-Message-State: AOJu0YywybulLjgKn7/jSeZfKKCr2ZDa1BNVVyciEQIi+hKq80mzAlYR
	5yjU/IGZHJJbw9h+Lfsyhn98kNSvlNBw5qm0adue50260WzFLGCYYOxFuAz/X0s=
X-Google-Smtp-Source: AGHT+IH3c4veHYI0ZJD3fRBduUwFbvfib/5vZCZMCh4qdULb4lh60PtskJlqCBKNuuweGamkvAgvqA==
X-Received: by 2002:a2e:b019:0:b0:2ef:25be:ebeb with SMTP id 38308e7fff4ca-2ef25beef6fmr77239271fa.10.1721807641574;
        Wed, 24 Jul 2024 00:54:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:deff:4fa8:5076:b4c7? ([2a01:e0a:982:cbb0:deff:4fa8:5076:b4c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3687869439esm13416638f8f.52.2024.07.24.00.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 00:54:01 -0700 (PDT)
Message-ID: <6f5f7169-b3e4-4663-bb83-f5a1439d1321@linaro.org>
Date: Wed, 24 Jul 2024 09:54:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 5/5] drm/panel: st7701: Add Anbernic RG28XX panel
 support
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
 <20240706102338.99231-6-kikuchan98@gmail.com>
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
In-Reply-To: <20240706102338.99231-6-kikuchan98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/07/2024 12:23, Hironori KIKUCHI wrote:
> The Anbernic RG28XX is a handheld gaming device with a 2.8 inch 480x640
> display. Add support for the display panel.
> 
> This panel is driven by a variant of ST7701 driver IC internally,
> confirmed by dumping and analyzing its BSP initialization sequence
> by using a logic analyzer. It is very similar to the existing
> densitron,dmt028vghmcmi-1a panel, but differs in some unknown
> register values. Besides, it is connected via SPI, so add a new entry
> for the panel.
> 
> Signed-off-by: Hironori KIKUCHI <kikuchan98@gmail.com>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/gpu/drm/panel/panel-sitronix-st7701.c | 151 ++++++++++++++++++
>   1 file changed, 151 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7701.c b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
> index 9e83a760a8a..eef03d04e0c 100644
> --- a/drivers/gpu/drm/panel/panel-sitronix-st7701.c
> +++ b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
> @@ -471,6 +471,55 @@ static void rg_arc_gip_sequence(struct st7701 *st7701)
>   	msleep(120);
>   }
>   
> +static void rg28xx_gip_sequence(struct st7701 *st7701)
> +{
> +	st7701_switch_cmd_bkx(st7701, true, 3);
> +	ST7701_WRITE(st7701, 0xEF, 0x08);
> +
> +	st7701_switch_cmd_bkx(st7701, true, 0);
> +	ST7701_WRITE(st7701, 0xC3, 0x02, 0x10, 0x02);
> +	ST7701_WRITE(st7701, 0xC7, 0x04);
> +	ST7701_WRITE(st7701, 0xCC, 0x10);
> +
> +	st7701_switch_cmd_bkx(st7701, true, 1);
> +	ST7701_WRITE(st7701, 0xEE, 0x42);
> +	ST7701_WRITE(st7701, 0xE0, 0x00, 0x00, 0x02);
> +
> +	ST7701_WRITE(st7701, 0xE1, 0x04, 0xA0, 0x06, 0xA0, 0x05, 0xA0, 0x07, 0xA0,
> +		   0x00, 0x44, 0x44);
> +	ST7701_WRITE(st7701, 0xE2, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +		   0x00, 0x00, 0x00, 0x00);
> +	ST7701_WRITE(st7701, 0xE3, 0x00, 0x00, 0x22, 0x22);
> +	ST7701_WRITE(st7701, 0xE4, 0x44, 0x44);
> +	ST7701_WRITE(st7701, 0xE5, 0x0C, 0x90, 0xA0, 0xA0, 0x0E, 0x92, 0xA0, 0xA0,
> +		   0x08, 0x8C, 0xA0, 0xA0, 0x0A, 0x8E, 0xA0, 0xA0);
> +	ST7701_WRITE(st7701, 0xE6, 0x00, 0x00, 0x22, 0x22);
> +	ST7701_WRITE(st7701, 0xE7, 0x44, 0x44);
> +	ST7701_WRITE(st7701, 0xE8, 0x0D, 0x91, 0xA0, 0xA0, 0x0F, 0x93, 0xA0, 0xA0,
> +		   0x09, 0x8D, 0xA0, 0xA0, 0x0B, 0x8F, 0xA0, 0xA0);
> +	ST7701_WRITE(st7701, 0xEB, 0x00, 0x00, 0xE4, 0xE4, 0x44, 0x00, 0x40);
> +	ST7701_WRITE(st7701, 0xED, 0xFF, 0xF5, 0x47, 0x6F, 0x0B, 0xA1, 0xBA, 0xFF,
> +		   0xFF, 0xAB, 0x1A, 0xB0, 0xF6, 0x74, 0x5F, 0xFF);
> +	ST7701_WRITE(st7701, 0xEF, 0x08, 0x08, 0x08, 0x45, 0x3F, 0x54);
> +
> +	st7701_switch_cmd_bkx(st7701, false, 0);
> +
> +	st7701_switch_cmd_bkx(st7701, true, 3);
> +	ST7701_WRITE(st7701, 0xE6, 0x16);
> +	ST7701_WRITE(st7701, 0xE8, 0x00, 0x0E);
> +
> +	st7701_switch_cmd_bkx(st7701, false, 0);
> +	ST7701_WRITE(st7701, MIPI_DCS_SET_ADDRESS_MODE, 0x10);
> +	ST7701_WRITE(st7701, MIPI_DCS_EXIT_SLEEP_MODE);
> +	msleep(120);
> +
> +	st7701_switch_cmd_bkx(st7701, true, 3);
> +	ST7701_WRITE(st7701, 0xE8, 0x00, 0x0C);
> +	msleep(10);
> +	ST7701_WRITE(st7701, 0xE8, 0x00, 0x00);
> +	st7701_switch_cmd_bkx(st7701, false, 0);
> +}
> +
>   static int st7701_prepare(struct drm_panel *panel)
>   {
>   	struct st7701 *st7701 = panel_to_st7701(panel);
> @@ -986,6 +1035,106 @@ static const struct st7701_panel_desc rg_arc_desc = {
>   	.gip_sequence = rg_arc_gip_sequence,
>   };
>   
> +static const struct drm_display_mode rg28xx_mode = {
> +	.clock		= 22325,
> +
> +	.hdisplay	= 480,
> +	.hsync_start	= 480 + 40,
> +	.hsync_end	= 480 + 40 + 4,
> +	.htotal		= 480 + 40 + 4 + 20,
> +
> +	.vdisplay	= 640,
> +	.vsync_start	= 640 + 2,
> +	.vsync_end	= 640 + 2 + 40,
> +	.vtotal		= 640 + 2 + 40 + 16,
> +
> +	.width_mm	= 44,
> +	.height_mm	= 58,
> +
> +	.flags		= DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
> +
> +	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
> +};
> +
> +static const struct st7701_panel_desc rg28xx_desc = {
> +	.mode = &rg28xx_mode,
> +
> +	.panel_sleep_delay = 80,
> +
> +	.pv_gamma = {
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC0_MASK, 0),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC4_MASK, 0x10),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC8_MASK, 0x17),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC16_MASK, 0xd),
> +
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC24_MASK, 0x11),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC52_MASK, 0x6),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC80_MASK, 0x5),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC108_MASK, 0x8),
> +
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC147_MASK, 0x7),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC175_MASK, 0x1f),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC203_MASK, 0x4),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC231_MASK, 0x11),
> +
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC239_MASK, 0xe),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC247_MASK, 0x29),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC251_MASK, 0x30),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC255_MASK, 0x1f)
> +	},
> +	.nv_gamma = {
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC0_MASK, 0),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC4_MASK, 0xd),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC8_MASK, 0x14),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC16_MASK, 0xe),
> +
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC24_MASK, 0x11),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC52_MASK, 0x6),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC80_MASK, 0x4),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC108_MASK, 0x8),
> +
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC147_MASK, 0x8),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC175_MASK, 0x20),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC203_MASK, 0x5),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC231_MASK, 0x13),
> +
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC239_MASK, 0x13),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC247_MASK, 0x26),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC251_MASK, 0x30),
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
> +		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC255_MASK, 0x1f)
> +	},
> +	.nlinv = 7,
> +	.vop_uv = 4800000,
> +	.vcom_uv = 1512500,
> +	.vgh_mv = 15000,
> +	.vgl_mv = -11730,
> +	.avdd_mv = 6600,
> +	.avcl_mv = -4400,
> +	.gamma_op_bias = OP_BIAS_MIDDLE,
> +	.input_op_bias = OP_BIAS_MIN,
> +	.output_op_bias = OP_BIAS_MIN,
> +	.t2d_ns = 1600,
> +	.t3d_ns = 10400,
> +	.eot_en = true,
> +	.gip_sequence = rg28xx_gip_sequence,
> +};
> +
>   static void st7701_cleanup(void *data)
>   {
>   	struct st7701 *st7701 = (struct st7701 *)data;
> @@ -1120,11 +1269,13 @@ static const struct of_device_id st7701_dsi_of_match[] = {
>   MODULE_DEVICE_TABLE(of, st7701_dsi_of_match);
>   
>   static const struct of_device_id st7701_spi_of_match[] = {
> +	{ .compatible = "anbernic,rg28xx-panel", .data = &rg28xx_desc },
>   	{ /* sentinel */ }
>   };
>   MODULE_DEVICE_TABLE(of, st7701_spi_of_match);
>   
>   static const struct spi_device_id st7701_spi_ids[] = {
> +	{ "rg28xx-panel" },
>   	{ /* sentinel */ }
>   };
>   MODULE_DEVICE_TABLE(spi, st7701_spi_ids);

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

