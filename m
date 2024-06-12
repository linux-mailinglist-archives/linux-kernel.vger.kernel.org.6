Return-Path: <linux-kernel+bounces-211908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 319069058C0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5B5DB240BC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7160181301;
	Wed, 12 Jun 2024 16:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ls+p5WWI"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B16017DE35
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 16:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718209539; cv=none; b=IgD2tXrvgdECt8MHY9t3bwZPOub3C9QQeKCAspicLCKk2ambV4EJp3Qqt4k8O/+jRbGCpIVPx88cLx1SJx2LVRMKZ/3Uc2s6epObjy1fE8xdORufIWklETGsVEa8kjohpQvmsPAjrlcHDXH7IiHmjA3aU9M7iMKJ+vtDmX0smMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718209539; c=relaxed/simple;
	bh=FT83dq8fnS6WPxhKs0Oumh8BckGwGE03RYf9ON83b5A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=E5ZM53qALjkeGdftkOqbKramDcf2TRv//kXFQ2YchOiojc+Ulxmr32kYepFubWXJsHYrOSGSibSzidmIekkb7MGL1H6rIJ6uYejaZVRMgrsP1cxZ4e53Tqy4xLi8RlLOmfdEXSN/joxDunjpjYTXaWUBquS/1Q+BkGwOOlTrWPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ls+p5WWI; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-35f24fabb81so57092f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718209535; x=1718814335; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m1ANCcJt2zk9p6VuqBRwi7LO5EhRrUpz8kaigFnpgMY=;
        b=Ls+p5WWIEMMEfRZ7TnDNbz/yPoy6Zh+xqE/8g1qxxbXSZfBmJcCrV2w9in65JNKBWZ
         SXAuh6LxkEtiH3dJ6yKZdnFTfTBIeK8O7I5JAWkKUZW4jFAaMfNolpEm6XpELNcrZ4Zv
         mjctOcuR/pv6Ercyh4kRoPMaUX3+ZDArb/wb71/ylmW2AneQl6yjyH6IVgZ2eq0+k68T
         Xzft5YK+e4XqnAa0AMaTrOTbEewDX8txz7PLmCtbNNVtx2NMgrwP4vchgMHf/JLSl9K+
         NUjFfn0G/2L30KHtzS+L8gPKhAs0wow96spedNrNGARloLaQ+cz7Z5iU1kTw78+A2r3k
         WHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718209535; x=1718814335;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m1ANCcJt2zk9p6VuqBRwi7LO5EhRrUpz8kaigFnpgMY=;
        b=VFPDOvTRql0CX09uPnaxltigz1W+9bQV0TjnEOtbUemw80nMoaaNUtOBrUlIS8V93H
         Pj4oyNH7V8V2U6Gv6ylOSRsK+d0IuEL0OH5jzrqn3GnKSDlbh9i+ZvHPdtfoJkju/zKR
         B3YHSmOkYStinxLj1CgeHAdHv9esbOHCVpWXMLWRt/GuaCRJiqLvq2N/JaBcmM7QMe8N
         2mUFVYCdjbZtPW2IfH8mEdBMNXMZPl7z/W47xm2louEwEI1po94FyuHl7z/2mHo8tfPx
         FGZ6aeQ3NyOWweA3eVS5ymFpbe8P4H+MjsO5U1lVILQvs1zv5xJUU2Ul+u/AkoWq4Zqm
         VJQw==
X-Forwarded-Encrypted: i=1; AJvYcCV0pMApj25q1fLLG27QjGXIbIl/H03aefuoUlpbwBliEiFJi0hhkjydpTFPWw+Ouzfi0JEq6VXtJStE1qUmCYGkY/vGiG1VWNyN60vB
X-Gm-Message-State: AOJu0YwfOtKargchlyNv8y/+YVM+E6wK8zmEJUeknu3dxgzHPWRrBoQ4
	IQMZd3n45WQ/zTf1pskGRqnYnrBGwx2HNahruwPH98zwH80iqhKIBUJ/MvW3L78=
X-Google-Smtp-Source: AGHT+IGBp5CXxO1Cz/MWXSVihQ78PUCPNkBdTASWvuzcisu42OYSf9+4lRH/N7xuULPL4aQq+w95aQ==
X-Received: by 2002:a5d:6982:0:b0:35f:159e:5ec2 with SMTP id ffacd0b85a97d-35fe1c0a096mr1403952f8f.39.1718209535199;
        Wed, 12 Jun 2024 09:25:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:30bd:bf21:eed1:8aeb? ([2a01:e0a:982:cbb0:30bd:bf21:eed1:8aeb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f2a73fb13sm5968484f8f.105.2024.06.12.09.25.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 09:25:34 -0700 (PDT)
Message-ID: <ce7eaacc-c5f8-479a-b4f5-9f83515e47d1@linaro.org>
Date: Wed, 12 Jun 2024 18:25:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 20/23] ASoC: codecs: wcd939x: Constify static data
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240612-asoc-wcd9xxx-wide-cleanups-v1-0-0d15885b2a06@linaro.org>
 <20240612-asoc-wcd9xxx-wide-cleanups-v1-20-0d15885b2a06@linaro.org>
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
In-Reply-To: <20240612-asoc-wcd9xxx-wide-cleanups-v1-20-0d15885b2a06@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/06/2024 18:15, Krzysztof Kozlowski wrote:
> Driver does not modify few static data (MBHC reg fields, IRQ chip), so
> make them const for code safety.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   sound/soc/codecs/wcd939x.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/wcd939x.c b/sound/soc/codecs/wcd939x.c
> index 72d8a6a35052..1f94f49f9829 100644
> --- a/sound/soc/codecs/wcd939x.c
> +++ b/sound/soc/codecs/wcd939x.c
> @@ -220,7 +220,7 @@ static const SNDRV_CTL_TLVD_DECLARE_DB_MINMAX(ear_pa_gain, 600, -1800);
>   static const DECLARE_TLV_DB_SCALE(line_gain, 0, 7, 1);
>   static const DECLARE_TLV_DB_SCALE(analog_gain, 0, 25, 1);
>   
> -static struct wcd_mbhc_field wcd_mbhc_fields[WCD_MBHC_REG_FUNC_MAX] = {
> +static const struct wcd_mbhc_field wcd_mbhc_fields[WCD_MBHC_REG_FUNC_MAX] = {
>   	WCD_MBHC_FIELD(WCD_MBHC_L_DET_EN, WCD939X_ANA_MBHC_MECH, 0x80),
>   	WCD_MBHC_FIELD(WCD_MBHC_GND_DET_EN, WCD939X_ANA_MBHC_MECH, 0x40),
>   	WCD_MBHC_FIELD(WCD_MBHC_MECH_DETECTION_TYPE, WCD939X_ANA_MBHC_MECH, 0x20),
> @@ -291,7 +291,7 @@ static const struct regmap_irq wcd939x_irqs[WCD939X_NUM_IRQS] = {
>   	REGMAP_IRQ_REG(WCD939X_IRQ_HPHR_SURGE_DET_INT, 2, 0x08),
>   };
>   
> -static struct regmap_irq_chip wcd939x_regmap_irq_chip = {
> +static const struct regmap_irq_chip wcd939x_regmap_irq_chip = {
>   	.name = "wcd939x",
>   	.irqs = wcd939x_irqs,
>   	.num_irqs = ARRAY_SIZE(wcd939x_irqs),
> @@ -2957,7 +2957,7 @@ static irqreturn_t wcd939x_wd_handle_irq(int irq, void *data)
>    *     \- regmap_irq_thread()
>    *         \- handle_nested_irq(i)
>    */
> -static struct irq_chip wcd_irq_chip = {
> +static const struct irq_chip wcd_irq_chip = {
>   	.name = "WCD939x",
>   };
>   
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

