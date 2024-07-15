Return-Path: <linux-kernel+bounces-253147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3581931D50
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 00:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB6A1B20FD3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 22:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C49513D533;
	Mon, 15 Jul 2024 22:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="t76uOPkv"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487D73BBC2;
	Mon, 15 Jul 2024 22:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721083772; cv=none; b=XhRV/1kJ9zKAVaxZ3nR0rG8eAfF4DBgo+NXKC0L0U8fj9E7RNz4bJb0wJ09eR/ZEFrWq9/IzOgUHaGcWm0ZNJXbFM6HR+Lb4vyh2K2z1REkN8mepEWk8MZcu7qNP0tHLuIs/yPiFlXCu1GnlTrWYGbKhkcOypeevDQzG74GELwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721083772; c=relaxed/simple;
	bh=RRmx9ZfTgWIKG1f2ltDhoT7ufCCWhhdGor/QGS/lbRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=n3SaYXPPbF+aGXMq0FeJGjXDbye4o3a0AWbGLarWZwnzKk8cDMEmo6KXHMaiAZ1aN9CT7KpSAqTc36anFyMqWJKgaPpGIDvpC+U0T8ZnuwAbBgN94fd230pOmyJ6frVHd9FH7gC/Uu10tSuU4O87Ywc+R9ee6OK5NgJF8EPakks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=t76uOPkv; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 38A91100006;
	Tue, 16 Jul 2024 01:49:27 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 38A91100006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1721083767;
	bh=WND29VorzY0w6bH7gEw1lRw9RzKDdjhK4hntDg+MDfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=t76uOPkvAdYgM49AoCJmc+0tAobQ5RLEXgwjOlE7jnPTLdQ+rVKkqfE3jZA5+9l8B
	 uWmWcmNZgiivULJrjuzyDwtRITvu4iZVB8qcuXa++izOZ66jYYDB4n5f+tzldD4unp
	 6zIcBFaGxIR8QRjaagfqK3VVIVyvUJ0CVbbGIfZdbCz2xmfZU72w1HjBy2QhkJarJu
	 dfydv20/PxYAmSNSOI7jMXz3X8nHeoWJbgw5ZjgkMbmeThSICD5DKFN0hVdToDW56z
	 /HOOL0A45t95eT23PRIqIOhNlMo8aiYhym58tlwTbnxkHWGCb/Ly2fUnSMiN84PFyc
	 uvefHo2M1RRJw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 16 Jul 2024 01:49:27 +0300 (MSK)
Received: from [172.28.128.6] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 16 Jul 2024 01:49:26 +0300
Message-ID: <66ef4ff5-b472-44ee-a4fc-a68ceacea159@salutedevices.com>
Date: Tue, 16 Jul 2024 01:48:18 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] reset: amlogic: split the device and platform probe
To: Jerome Brunet <jbrunet@baylibre.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>, Neil Armstrong
	<neil.armstrong@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-clk@vger.kernel.org>
References: <20240710162526.2341399-1-jbrunet@baylibre.com>
 <20240710162526.2341399-4-jbrunet@baylibre.com>
Content-Language: en-US
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
In-Reply-To: <20240710162526.2341399-4-jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186528 [Jul 16 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 24 0.3.24 186c4d603b899ccfd4883d230c53f273b80e467f, {Tracking_smtp_not_equal_from}, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/07/15 21:24:00 #26011023
X-KSMG-AntiVirus-Status: Clean, skipped



On 7/10/24 19:25, Jerome Brunet wrote:
> To prepare the addition of the auxiliary device support, split
> out the device probe from the probe of the platform device.
> 
> The device probe will be common to both the platform and auxiliary
> driver.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/reset/reset-meson.c | 55 +++++++++++++++++++++++--------------
>  1 file changed, 34 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
> index 59126c9f194a..fec55321b52b 100644
> --- a/drivers/reset/reset-meson.c
> +++ b/drivers/reset/reset-meson.c
> @@ -87,6 +87,27 @@ static const struct reset_control_ops meson_reset_ops = {
>  	.deassert	= meson_reset_deassert,
>  };
>  
> +static int meson_reset_probe(struct device *dev, struct regmap *map,
> +			     const struct meson_reset_param *param)
> +{
> +	unsigned int stride = regmap_get_reg_stride(map);
> +	struct meson_reset *data;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->param = param;
> +	data->map = map;
> +	data->rcdev.owner = dev->driver->owner;
> +	data->rcdev.nr_resets = param->reg_count * BITS_PER_BYTE
> +		* stride;
> +	data->rcdev.ops = &meson_reset_ops;
> +	data->rcdev.of_node = dev->of_node;

It will be good to add here something like this. Later it would help in
reset debugging.

data->rcdev.dev = dev;

> +
> +	return devm_reset_controller_register(dev, &data->rcdev);
> +}
> +
>  static const struct meson_reset_param meson8b_param = {
>  	.reg_count	= 8,
>  	.reset_offset	= 0x0,
> @@ -125,46 +146,38 @@ static const struct regmap_config regmap_config = {
>  	.reg_stride = 4,
>  };
>  
> -static int meson_reset_probe(struct platform_device *pdev)
> +static int meson_reset_pltf_probe(struct platform_device *pdev)
>  {
> +
> +	const struct meson_reset_param *param;
>  	struct device *dev = &pdev->dev;
> -	struct meson_reset *data;
> +	struct regmap *map;
>  	void __iomem *base;
>  
> -	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> -	if (!data)
> -		return -ENOMEM;
> -
>  	base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
>  
> -	data->param = of_device_get_match_data(dev);
> -	if (!data->param)
> +	param = of_device_get_match_data(dev);
> +	if (!param)
>  		return -ENODEV;
>  
> -	data->map = devm_regmap_init_mmio(dev, base, &regmap_config);
> -	if (IS_ERR(data->map))
> -		return dev_err_probe(dev, PTR_ERR(data->map),
> +	map = devm_regmap_init_mmio(dev, base, &regmap_config);
> +	if (IS_ERR(map))
> +		return dev_err_probe(dev, PTR_ERR(map),
>  				     "can't init regmap mmio region\n");
>  
> -	data->rcdev.owner = THIS_MODULE;
> -	data->rcdev.nr_resets = data->param->reg_count * BITS_PER_BYTE
> -		* regmap_config.reg_stride;
> -	data->rcdev.ops = &meson_reset_ops;
> -	data->rcdev.of_node = dev->of_node;
> -
> -	return devm_reset_controller_register(dev, &data->rcdev);
> +	return meson_reset_probe(dev, map, param);
>  }
>  
> -static struct platform_driver meson_reset_driver = {
> -	.probe	= meson_reset_probe,
> +static struct platform_driver meson_reset_pltf_driver = {
> +	.probe	= meson_reset_pltf_probe,
>  	.driver = {
>  		.name		= "meson_reset",
>  		.of_match_table	= meson_reset_dt_ids,
>  	},
>  };
> -module_platform_driver(meson_reset_driver);
> +module_platform_driver(meson_reset_pltf_driver);
>  
>  MODULE_DESCRIPTION("Amlogic Meson Reset Controller driver");
>  MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");

-- 
Best regards
Jan Dakinevich

