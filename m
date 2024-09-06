Return-Path: <linux-kernel+bounces-319068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A33496F746
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53173287129
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E0F1D1F57;
	Fri,  6 Sep 2024 14:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fFz8oeze"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0611D1D174E
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725634004; cv=none; b=LYyx6VP6u2leXVXcPLDCGJrQWRpvQbN32T0yCUIeUwxaKnVW11+0t7pft25nBb1dkipOBJQPMJiEIXNPUVBnp3YRsbsU60XLqFK3/h7YyP2cN0bp+xX7iFqHMW2O1R2J3212RGJRL3HF2RYeN7AJDPDbrZiOwkTcPdYQTtDvtCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725634004; c=relaxed/simple;
	bh=YsP9Jx+iFrZxqLbV56LuuvSuclfgADQuCWYNO6TiAkI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JHSkAW4/pJP3CPQPyP3Z4OSOyipmoYLucqEw7rDwu+jPW6LdujMnlyoioxwdTkj4ABqaMb0y2ESMrEUxbSa58mrQZuwoDyLBMmwlHI/n/Kq/feMfse7af4zBRBT+ttAOYY8093rUuVW0bCD9BclNqbutS6j/zAWst+oGixQwJLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fFz8oeze; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42ca573fd5aso4734915e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 07:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725633998; x=1726238798; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qDas7/3GnB3gI3FiQmSZkr4FI1Dk7Pb5iN0NPlHwcvo=;
        b=fFz8oeze106EdCjyJ9Slz6+/6NLVF2InudtWL1HmccIqLpVKyQjBOT4XxmKZ8eLFfc
         Pylf9ICx5RRJbNaD9h8E8lUKszhtFKFkKfmbN8IjjoiaHaaDbB3EPOLhC382bOhrYhiN
         QfgWh20s6u5Ht/9jDFfwTvMRvgh90kcgoCupOgoEnb6EDcU311cj5NF3ZRdPu+Cp46IK
         biPFUkOhhpNLKpoBgZZz6pLYdB7xoufIR7pCj0yNAYHnhrofrWDY9JZDL0xfsn8v0IL+
         WEejMOfL3KyIeBDTKWnQvNx2FgP+c/pc1Bx8CTpbadcLgCKPVSSFViP5Bs7mq9OBPBYh
         J8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725633998; x=1726238798;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qDas7/3GnB3gI3FiQmSZkr4FI1Dk7Pb5iN0NPlHwcvo=;
        b=BQwjKltEkwFfeBRQ1LM6UFpUZux8hfHSkSeJlODLepGe9OBvWa7z+TQE58u/d+y5vy
         tG/W8BU/Eizztpy2HahEwdq/jCVVmJQthiJhnddqIEspHwxQiP8OphfWcYUP2P0a10xe
         rS/fB+7nfGgHcKgBV2Ou3L+PjeeQMvr9LXvOAPmRPSkTanGO5MHRTkj/CPbXHKKt1joR
         q5cZXATCP2cDTFyHlOMg3RRhZat/FsTtLIpLlpueYLxm48UL8PX0DPkB557hPfeeimlO
         pG3OgpTNOEYyqSEzCbK3x0BQ61EVAr1N/GSkqcM25L7c+C4Q69T2wpxvBbhoJjCiunyV
         qxdw==
X-Forwarded-Encrypted: i=1; AJvYcCWiPvAFPQ7evo/lSj4yvQHKCtGD2d07wQIH/EHdbCCtk1sjHIpn9hBIHobaxb7cRr+DQ/omuV7etAWHhwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLiocYFgvd5tiaqDb6F036GYR+v9xHNiaPL3NrbwWYCNbE1LlX
	BV0grb2OG72D1l75gtZd7mLXOHZXoiFIA/e8NSRPYZTvSqkrFEDsG9IpG8mXKNI=
X-Google-Smtp-Source: AGHT+IHMg7y0aw1m8lQnqNRNlNkZBuLXMZvJfNBbKP0BuiZSWuVA7JEZ4Ct05EbZan7vjpnXQFX2og==
X-Received: by 2002:a05:600c:35ce:b0:42b:8a35:1ade with SMTP id 5b1f17b1804b1-42c9f9d648dmr17095365e9.27.1725633997508;
        Fri, 06 Sep 2024 07:46:37 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:4d9f:a9a2:6f41:699f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05cc3dbsm22410485e9.20.2024.09.06.07.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 07:46:36 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>,  Neil Armstrong
 <neil.armstrong@linaro.org>,  Kevin Hilman <khilman@baylibre.com>,  Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>,  Jiucheng Xu
 <jiucheng.xu@amlogic.com>,  linux-arm-kernel@lists.infradead.org,
  linux-amlogic@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/9] reset: amlogic: convert driver to regmap
In-Reply-To: <984d928a37b3db11ae53c07da672ccae0d79734f.camel@pengutronix.de>
	(Philipp Zabel's message of "Fri, 06 Sep 2024 16:19:00 +0200")
References: <20240906-meson-rst-aux-v4-0-08824c3d108b@baylibre.com>
	<20240906-meson-rst-aux-v4-1-08824c3d108b@baylibre.com>
	<984d928a37b3db11ae53c07da672ccae0d79734f.camel@pengutronix.de>
Date: Fri, 06 Sep 2024 16:46:36 +0200
Message-ID: <1jfrqcrgab.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri 06 Sep 2024 at 16:19, Philipp Zabel <p.zabel@pengutronix.de> wrote:

> On Fr, 2024-09-06 at 15:34 +0200, Jerome Brunet wrote:
>> To allow using the same driver for the main reset controller and the
>> auxiliary ones embedded in the clock controllers, convert the
>> the Amlogic reset driver to regmap.
>> 
>> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  drivers/reset/reset-meson.c | 79 ++++++++++++++++++++++++---------------------
>
> This patch should also make RESET_MESON select REGMAP.

Indeed

>
>>  1 file changed, 43 insertions(+), 36 deletions(-)
>> 
>> diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
>> index 1e9fca3e30e8..9dd38cc209e2 100644
>> --- a/drivers/reset/reset-meson.c
>> +++ b/drivers/reset/reset-meson.c
>> @@ -11,36 +11,43 @@
>>  #include <linux/of.h>
>>  #include <linux/module.h>
>>  #include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>>  #include <linux/reset-controller.h>
>>  #include <linux/slab.h>
>>  #include <linux/types.h>
>>  
>> -#define BITS_PER_REG	32
>> -
>>  struct meson_reset_param {
>>  	int reg_count;
>>  	int level_offset;
>>  };
>>  
>>  struct meson_reset {
>> -	void __iomem *reg_base;
>>  	const struct meson_reset_param *param;
>>  	struct reset_controller_dev rcdev;
>> -	spinlock_t lock;
>> +	struct regmap *map;
>>  };
>>  
>> +static void meson_reset_offset_and_bit(struct meson_reset *data,
>> +				       unsigned long id,
>> +				       unsigned int *offset,
>> +				       unsigned int *bit)
>> +{
>> +	unsigned int stride = regmap_get_reg_stride(data->map);
>
> You know this is always 4. Having a #define for this (that is also used
> to initialize regmap_config.reg_stride, and for now nr_resets, below)
> instead of going through an exported function would allow the compiler
> to optimize this all away:

Yes, for now. However, with the auxiliary you may get a regmap with
different value. I've seen example with stride = 1. 

I'll admit is very unlikely but I does not really worth it considering
how often we'll get through this and how difficult it will be to debug
if stride ever get different.

>
>> +
>> +	*offset = (id / (stride * BITS_PER_BYTE)) * stride;
>> +	*bit = id % (stride * BITS_PER_BYTE);
>> +}
>> +
>>  static int meson_reset_reset(struct reset_controller_dev *rcdev,
>> -			      unsigned long id)
>> +			     unsigned long id)
>>  {
>>  	struct meson_reset *data =
>>  		container_of(rcdev, struct meson_reset, rcdev);
>> -	unsigned int bank = id / BITS_PER_REG;
>> -	unsigned int offset = id % BITS_PER_REG;
>> -	void __iomem *reg_addr = data->reg_base + (bank << 2);
>> +	unsigned int offset, bit;
>>  
>> -	writel(BIT(offset), reg_addr);
>> +	meson_reset_offset_and_bit(data, id, &offset, &bit);
>>  
>> -	return 0;
>> +	return regmap_write(data->map, offset, BIT(bit));
>>  }
>>  
>>  static int meson_reset_level(struct reset_controller_dev *rcdev,
>> @@ -48,25 +55,13 @@ static int meson_reset_level(struct reset_controller_dev *rcdev,
>>  {
>>  	struct meson_reset *data =
>>  		container_of(rcdev, struct meson_reset, rcdev);
>> -	unsigned int bank = id / BITS_PER_REG;
>> -	unsigned int offset = id % BITS_PER_REG;
>> -	void __iomem *reg_addr;
>> -	unsigned long flags;
>> -	u32 reg;
>> +	unsigned int offset, bit;
>>  
>> -	reg_addr = data->reg_base + data->param->level_offset + (bank << 2);
>> +	meson_reset_offset_and_bit(data, id, &offset, &bit);
>> +	offset += data->param->level_offset;
>>  
>> -	spin_lock_irqsave(&data->lock, flags);
>> -
>> -	reg = readl(reg_addr);
>> -	if (assert)
>> -		writel(reg & ~BIT(offset), reg_addr);
>> -	else
>> -		writel(reg | BIT(offset), reg_addr);
>> -
>> -	spin_unlock_irqrestore(&data->lock, flags);
>> -
>> -	return 0;
>> +	return regmap_update_bits(data->map, offset,
>> +				  BIT(bit), assert ? 0 : BIT(bit));
>
> Matter of taste, perhaps, but the BIT() could be moved into
> meson_reset_offset_and_bit().

It's not really related to this particular patch which is about moving
to regmap.

I can add it to another patch if you want

>
>>  }
>>  
>>  static int meson_reset_assert(struct reset_controller_dev *rcdev,
>> @@ -119,30 +114,42 @@ static const struct of_device_id meson_reset_dt_ids[] = {
>>  };
>>  MODULE_DEVICE_TABLE(of, meson_reset_dt_ids);
>>  
>> +static const struct regmap_config regmap_config = {
>> +	.reg_bits   = 32,
>> +	.val_bits   = 32,
>> +	.reg_stride = 4,
>> +};
>> +
>>  static int meson_reset_probe(struct platform_device *pdev)
>>  {
>> +	struct device *dev = &pdev->dev;
>>  	struct meson_reset *data;
>> +	void __iomem *base;
>>  
>> -	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
>> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>>  	if (!data)
>>  		return -ENOMEM;
>>  
>> -	data->reg_base = devm_platform_ioremap_resource(pdev, 0);
>> -	if (IS_ERR(data->reg_base))
>> -		return PTR_ERR(data->reg_base);
>> +	base = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(base))
>> +		return PTR_ERR(base);
>>  
>> -	data->param = of_device_get_match_data(&pdev->dev);
>> +	data->param = of_device_get_match_data(dev);
>>  	if (!data->param)
>>  		return -ENODEV;
>>  
>> -	spin_lock_init(&data->lock);
>> +	data->map = devm_regmap_init_mmio(dev, base, &regmap_config);
>> +	if (IS_ERR(data->map))
>> +		return dev_err_probe(dev, PTR_ERR(data->map),
>> +				     "can't init regmap mmio region\n");
>>  
>>  	data->rcdev.owner = THIS_MODULE;
>> -	data->rcdev.nr_resets = data->param->reg_count * BITS_PER_REG;
>> +	data->rcdev.nr_resets = data->param->reg_count * BITS_PER_BYTE
>> +		* regmap_config.reg_stride;
>>  	data->rcdev.ops = &meson_reset_ops;
>> -	data->rcdev.of_node = pdev->dev.of_node;
>> +	data->rcdev.of_node = dev->of_node;
>>  
>> -	return devm_reset_controller_register(&pdev->dev, &data->rcdev);
>> +	return devm_reset_controller_register(dev, &data->rcdev);
>>  }
>>  
>>  static struct platform_driver meson_reset_driver = {
>
> regards
> Philipp

-- 
Jerome

