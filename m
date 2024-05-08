Return-Path: <linux-kernel+bounces-173526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9232C8C01B5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B520D1C225FD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 16:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0D6129E8E;
	Wed,  8 May 2024 16:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jw4txY8l"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D473F85633
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 16:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715184777; cv=none; b=VXAJpBkBs/pvPEDxEXDgnH8SE5+1BOnNe31hBlXQsmXj5Pxko0NU8Db76LCDhoP4yeENXW1w+OJMyMrb+T4XxSpr3DFJh3tUW5a1025lcW+E8U3wL2bq1yXpOmLni910HgACBm5aEpUua+2fXuSLHhQDQfyZ3J0pSTfWFTBawHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715184777; c=relaxed/simple;
	bh=3RC/slltpYapY2F0z6uYYs46/YRPjHS6+iJKdyjPMSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H3wu3z2ZnXKUx5F7BmfcE4x2PBfXkwtxE6oQaRGQZrV6YmmLh69s4yBiFNToAlf4efNKo1pg5Ow260voGDj/vYf59dawuIqh0ZdN//XSjPULNGiBn5jE2Nq9kmHANCkYLyOFV3uImW5MRYBItan9Z5gKDOi7nsC6ICYUU3rn3yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jw4txY8l; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41dc9c83e57so6088205e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 09:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715184773; x=1715789573; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4GjzdAdHEKtNKnAx1lGW3dqaD5snc+8WTy5ik2iGruw=;
        b=jw4txY8lnQNVRM41kVyo00Z0nAwO/j6Dhyjv1JktTUcmmA/j6YyC5hWVI98gzIzSra
         offBNSVRC1N8MwLFCBaARTuBjPmu2qZgqBHbNQp2wKMOqOzJm++cj/NPH2UIPpukachN
         2h9mm7i8fupyJk/il8SXSGuP0Tz4gJcdgvU5z2PlBxlpEr6Z1L0hbxsxSkP+OWQmSiTD
         U4fVrf67hMHsSG9iH+no3WWxWFgbE7/udcw2LfphO8UUVLgLFtiUea73kNQ5naT0IzhB
         eJUD/RYfmVCFV2zvXUrEuNrr09Txcu/W+Ja5Tva5/vVOMMncTi8v/3HzW+v6nplnrBJq
         nIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715184773; x=1715789573;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4GjzdAdHEKtNKnAx1lGW3dqaD5snc+8WTy5ik2iGruw=;
        b=xJQzwyAxZg+ZzVHLPXiCbJp8qI0sOzs/bDAebxV2kF5YPEFZPn3vJzD1Sp3qnLrguL
         bwKLQKBPBq7MrUPyLfgWQMKtmvCZmG4nlp+KMF3VHMIhkFRSdVbR4vieeUOlCQGXTKLo
         IgwsGfFtXtghEJHobLCs4BQJSVxf5JHEFv6lsSN+1ZIHNdzkS4ogmoeKcqwIt2n2VS/c
         V+/ZK6lG0ADdf+nyCGNTkV98leeC81J8W79Ym2wEI7WAYiSUYzllvhHw8Oh4GM40Hi8X
         vw68ZbJ77rQOPQlSjuFz8zv8U+Yzt9BsP35d5lJ778H970ZIYJQkdHMvYvy82Ipr2ao8
         vBMw==
X-Forwarded-Encrypted: i=1; AJvYcCVBRdfS+zIw+TI+kHYmfLE67BjzZ+EruxuHLSA2Ttrw+4gEGJlQVw7OBUSOJjsjLZ4vmN+0rA2NjFXYtHigZ5Ix2D8dxhwa9zMw5k4I
X-Gm-Message-State: AOJu0Yyc2azi2Xkv06ep7sP+Bx3YKqtI8E4c0FGIdB9i3J/Ul3cDcpYy
	V+9Bh0gHXxHoqZW1JUekhCoqF/aO4fWKbT92gLf/auZ79mmJ+/EN3v9R1z5/CA4=
X-Google-Smtp-Source: AGHT+IH5Yksnpu8AA/SPMXll9db6J8MO+PCbYpEJpY3+2AVAvGf2IFN2hUFiazwk32/adRLFStXFTQ==
X-Received: by 2002:a05:600c:3585:b0:418:2ab6:7123 with SMTP id 5b1f17b1804b1-41fbcc5f63bmr1147015e9.10.1715184773147;
        Wed, 08 May 2024 09:12:53 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id g18-20020a5d5412000000b00346bda84bf9sm15725249wrv.78.2024.05.08.09.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 09:12:52 -0700 (PDT)
Message-ID: <4468becb-dc03-4832-aa03-5f597023fcb2@linaro.org>
Date: Wed, 8 May 2024 17:12:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] mfd: pm8008: deassert reset on probe
To: Johan Hovold <johan+linaro@kernel.org>, Lee Jones <lee@kernel.org>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Das Srinagesh <quic_gurus@quicinc.com>,
 Satya Priya <quic_c_skakit@quicinc.com>, Stephen Boyd <swboyd@chromium.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20240506150830.23709-1-johan+linaro@kernel.org>
 <20240506150830.23709-4-johan+linaro@kernel.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240506150830.23709-4-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/05/2024 16:08, Johan Hovold wrote:
> Request and deassert any (optional) reset gpio during probe in case it
> has been left asserted by the boot firmware.
> 
> Note the reset line is not asserted to avoid reverting to the default
> I2C address in case the firmware has configured an alternate address.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/mfd/qcom-pm8008.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
> index d53c987b0d49..d0f190c2ea2b 100644
> --- a/drivers/mfd/qcom-pm8008.c
> +++ b/drivers/mfd/qcom-pm8008.c
> @@ -4,6 +4,7 @@
>    */
>   
>   #include <linux/bitops.h>
> +#include <linux/gpio/consumer.h>
>   #include <linux/i2c.h>
>   #include <linux/interrupt.h>
>   #include <linux/irq.h>
> @@ -158,6 +159,7 @@ static struct regmap_config qcom_mfd_regmap_cfg = {
>   static int pm8008_probe(struct i2c_client *client)
>   {
>   	struct regmap_irq_chip_data *irq_data;
> +	struct gpio_desc *reset;
>   	int rc;
>   	struct device *dev;
>   	struct regmap *regmap;
> @@ -169,6 +171,10 @@ static int pm8008_probe(struct i2c_client *client)
>   
>   	i2c_set_clientdata(client, regmap);
>   
> +	reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(reset))
> +		return PTR_ERR(reset);
> +
>   	if (of_property_read_bool(dev->of_node, "interrupt-controller")) {
>   		rc = devm_regmap_add_irq_chip(dev, regmap, client->irq,
>   				IRQF_SHARED, 0, &pm8008_irq_chip, &irq_data);

So not resetting is fine and I understand you want to retain the address 
given by the firmware, I think that's the right thing to do.

You can add this now

Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

In addition to adding a small delay suggested by Andy - a few 
microseconds pick a number, I think you should verify the chip is out of 
reset as we would do with many other i2c devices.

A common pattern with i2c devices is take the device out of reset then 
read back an identity register as a smoke test.

Take drivers/media/i2c/ov8856.c::ov8856_identify_module() as an example.

In this case, suggest reading REVID_PERPH_TYPE @ 0x104 and 
REVID_PERPH_SUBTYPE @ 0x105

REVID_PERPH_TYPE @ 0x104 == 0x51 (PMIC)
REVID_PERPH_SUBYTE @ 0x105 == 0x2C (PM8008)

You can then add my

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

---
bod

