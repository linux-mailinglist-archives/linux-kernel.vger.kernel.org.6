Return-Path: <linux-kernel+bounces-292428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21921956F5A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73E9BB23B79
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 15:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897E0139D04;
	Mon, 19 Aug 2024 15:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MSg4jziL"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F924779F
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 15:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724082942; cv=none; b=NLehdUz1pBS/e6HoErmJ2IVAEx0Py1RCrB3EbQthNf4Zv/a/cqV9U+/71zMQDBqHKV3h05OLbojNvHW5m7ZZXyC5tGnJozPgBCTCRSUU23/YLpigW+eDuMM7F1MdV+tkt2WlIiYvZdEIDO9QfFUcYVkAiKK+bb3iqRbwOzh2izk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724082942; c=relaxed/simple;
	bh=0ZPZcSBz0GA9QaquCLoHbf0kkp4RlgHigycxyhrDtvY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=a1GAzsOphNFWz4Oc/GriGzUw0bryQw/siqg3LbRlhXAHPuipdWN7pVTHAp/YmvyUsIigcLcITZkcbCV59o2O/cUwUHTFe/YmD1J8NogfAkD/CfgbxTEU+B5QfKXSe1MXYYef0/3cQ4Sn7ymQWV9je356Ipj18NwxtYHHpEe+9h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MSg4jziL; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3718706cf8aso2860503f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724082939; x=1724687739; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qs5fWzggfiB2jX0FmUYwMsZ2TSBuyP8FCNq135EUvH4=;
        b=MSg4jziLCvXOSnPZanNzd6Z8HKUtx4BKoyuV5feb7JAQYX3pDXSFmQ28s3leqm1CgE
         mNQHQzklmKpsU85VOUH1kvvjxyl96nNrx7GX+lt1JL6aJe5hAzl7FajCeAOtI0NK3xhS
         ksQw9Li1uMACCEGESMpWz/roxXxjDhft5IjIP+vCfNILiqmB2azArux8ERuE1v5WOixn
         d9lRPuwyQopV/jropfELrLoqLdNCL1Eh58uD2IWeJfXymBcYW3k+1mfJNVUvwOfyNh4C
         uRaXDQFrs1SIS9SX1mc6xXSvjw9T5rLVTs4fPrXfHzf7x+jobsQCPGWe/ESKvrpFVOPr
         kJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724082939; x=1724687739;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qs5fWzggfiB2jX0FmUYwMsZ2TSBuyP8FCNq135EUvH4=;
        b=lLLkqQtZcfhumet4EjyOfz5kyVWvdcswGs2aBmwzPmuaN+R7umI+6NX6EYwUy1P+yB
         Hiur0o2KSe0iIalqIyv/KU2YvvJ9EB3gsIFIC+RjDob6p6fnDmlU98YXYRVLocTunMwl
         vTxUkOPbrOiCPdaGvmioXuGtwtb7UIRTGrC4EGVxyAu3pIVVKdYCfVevkTMsUAMAktwS
         bxROKLE+lt9oVwgpr0Pc8XKpFbyTXs1W7xfcW6zpXVvTVs6akoCQFuMh+96BJY0Sd+vd
         mngP0LbIf493pC7mcAzPPgB49UOmqpG47v2Yyi2Sm4ApNmbR6xfdiTN+EpxowMpJXuKV
         qU1g==
X-Gm-Message-State: AOJu0Yy+OF77it3z5zhwVVB4g9huLPVUG1W0dJFiqzJna+s/OyoVxXlg
	8p8zrml1rWB20+ck1kcy8laD3/9k1/nZnw7PPWqsy87HokQCYkHHR9hvd/9Cn6QSRCIjbF/YfR5
	w
X-Google-Smtp-Source: AGHT+IFJxTbaOFBT1xGu5oUq8Y1BTlG6M875inLI3Fd91V0wqoE+DkDHRodBrHYLtdnMm6jXgZ4Y4w==
X-Received: by 2002:a05:6000:1289:b0:371:8845:a3af with SMTP id ffacd0b85a97d-371946a3f3dmr6254795f8f.39.1724082938471;
        Mon, 19 Aug 2024 08:55:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f54e:4b0a:5175:5727? ([2a01:e0a:982:cbb0:f54e:4b0a:5175:5727])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189849697sm10840891f8f.37.2024.08.19.08.55.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 08:55:38 -0700 (PDT)
Message-ID: <7c598260-513a-4aad-962f-34e5de6731dd@linaro.org>
Date: Mon, 19 Aug 2024 17:55:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 1/9] reset: amlogic: convert driver to regmap
To: Jerome Brunet <jbrunet@baylibre.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-clk@vger.kernel.org
References: <20240808102742.4095904-1-jbrunet@baylibre.com>
 <20240808102742.4095904-2-jbrunet@baylibre.com>
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
In-Reply-To: <20240808102742.4095904-2-jbrunet@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/08/2024 12:27, Jerome Brunet wrote:
> To allow using the same driver for the main reset controller and the
> auxiliary ones embedded in the clock controllers, convert the
> the Amlogic reset driver to regmap.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>   drivers/reset/reset-meson.c | 79 ++++++++++++++++++++-----------------
>   1 file changed, 43 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
> index f78be97898bc..b47431a21b86 100644
> --- a/drivers/reset/reset-meson.c
> +++ b/drivers/reset/reset-meson.c
> @@ -11,36 +11,43 @@
>   #include <linux/of.h>
>   #include <linux/module.h>
>   #include <linux/platform_device.h>
> +#include <linux/regmap.h>
>   #include <linux/reset-controller.h>
>   #include <linux/slab.h>
>   #include <linux/types.h>
>   
> -#define BITS_PER_REG	32
> -
>   struct meson_reset_param {
>   	int reg_count;
>   	int level_offset;
>   };
>   
>   struct meson_reset {
> -	void __iomem *reg_base;
>   	const struct meson_reset_param *param;
>   	struct reset_controller_dev rcdev;
> -	spinlock_t lock;
> +	struct regmap *map;
>   };
>   
> +static void meson_reset_offset_and_bit(struct meson_reset *data,
> +				       unsigned long id,
> +				       unsigned int *offset,
> +				       unsigned int *bit)
> +{
> +	unsigned int stride = regmap_get_reg_stride(data->map);
> +
> +	*offset = (id / (stride * BITS_PER_BYTE)) * stride;
> +	*bit = id % (stride * BITS_PER_BYTE);
> +}
> +
>   static int meson_reset_reset(struct reset_controller_dev *rcdev,
> -			      unsigned long id)
> +			     unsigned long id)
>   {
>   	struct meson_reset *data =
>   		container_of(rcdev, struct meson_reset, rcdev);
> -	unsigned int bank = id / BITS_PER_REG;
> -	unsigned int offset = id % BITS_PER_REG;
> -	void __iomem *reg_addr = data->reg_base + (bank << 2);
> +	unsigned int offset, bit;
>   
> -	writel(BIT(offset), reg_addr);
> +	meson_reset_offset_and_bit(data, id, &offset, &bit);
>   
> -	return 0;
> +	return regmap_write(data->map, offset, BIT(bit));
>   }
>   
>   static int meson_reset_level(struct reset_controller_dev *rcdev,
> @@ -48,25 +55,13 @@ static int meson_reset_level(struct reset_controller_dev *rcdev,
>   {
>   	struct meson_reset *data =
>   		container_of(rcdev, struct meson_reset, rcdev);
> -	unsigned int bank = id / BITS_PER_REG;
> -	unsigned int offset = id % BITS_PER_REG;
> -	void __iomem *reg_addr;
> -	unsigned long flags;
> -	u32 reg;
> +	unsigned int offset, bit;
>   
> -	reg_addr = data->reg_base + data->param->level_offset + (bank << 2);
> +	meson_reset_offset_and_bit(data, id, &offset, &bit);
> +	offset += data->param->level_offset;
>   
> -	spin_lock_irqsave(&data->lock, flags);
> -
> -	reg = readl(reg_addr);
> -	if (assert)
> -		writel(reg & ~BIT(offset), reg_addr);
> -	else
> -		writel(reg | BIT(offset), reg_addr);
> -
> -	spin_unlock_irqrestore(&data->lock, flags);
> -
> -	return 0;
> +	return regmap_update_bits(data->map, offset,
> +				  BIT(bit), assert ? 0 : BIT(bit));
>   }
>   
>   static int meson_reset_assert(struct reset_controller_dev *rcdev,
> @@ -113,30 +108,42 @@ static const struct of_device_id meson_reset_dt_ids[] = {
>   };
>   MODULE_DEVICE_TABLE(of, meson_reset_dt_ids);
>   
> +static const struct regmap_config regmap_config = {
> +	.reg_bits   = 32,
> +	.val_bits   = 32,
> +	.reg_stride = 4,
> +};
> +
>   static int meson_reset_probe(struct platform_device *pdev)
>   {
> +	struct device *dev = &pdev->dev;
>   	struct meson_reset *data;
> +	void __iomem *base;
>   
> -	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>   	if (!data)
>   		return -ENOMEM;
>   
> -	data->reg_base = devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(data->reg_base))
> -		return PTR_ERR(data->reg_base);
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
>   
> -	data->param = of_device_get_match_data(&pdev->dev);
> +	data->param = of_device_get_match_data(dev);
>   	if (!data->param)
>   		return -ENODEV;
>   
> -	spin_lock_init(&data->lock);
> +	data->map = devm_regmap_init_mmio(dev, base, &regmap_config);
> +	if (IS_ERR(data->map))
> +		return dev_err_probe(dev, PTR_ERR(data->map),
> +				     "can't init regmap mmio region\n");
>   
>   	data->rcdev.owner = THIS_MODULE;
> -	data->rcdev.nr_resets = data->param->reg_count * BITS_PER_REG;
> +	data->rcdev.nr_resets = data->param->reg_count * BITS_PER_BYTE
> +		* regmap_config.reg_stride;
>   	data->rcdev.ops = &meson_reset_ops;
> -	data->rcdev.of_node = pdev->dev.of_node;
> +	data->rcdev.of_node = dev->of_node;
>   
> -	return devm_reset_controller_register(&pdev->dev, &data->rcdev);
> +	return devm_reset_controller_register(dev, &data->rcdev);
>   }
>   
>   static struct platform_driver meson_reset_driver = {

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

