Return-Path: <linux-kernel+bounces-182739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FD78C8F38
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 03:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8DF51F2217A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 01:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6ED4C85;
	Sat, 18 May 2024 01:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="CTp6WVLh"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF8D65C;
	Sat, 18 May 2024 01:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715996070; cv=none; b=ftuUZipCGr7jN071YLT6zAYEG1N9yIsNy36UfdggO/ztJj8ZRWn/7C0ITymlzJ/6WdPKaTtima1kvR6aBKELwb/XVTkPVuXtfD3lRwXg3NCxl7aslYkfrMJAe3QEl7yrBO9UZhR3bz2bh7El1e5QbrPChhFS7bmeiRI0McynmIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715996070; c=relaxed/simple;
	bh=fXYUM2mCm8y7Jxa4G86iI0YwKArJABxXtwbK2haZ76M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oCflvvj2B5w/I3OcSb/FHTr3YgHgR+X+1DR5iaCmOuwsUh0zg8nQhHDb5JZUZJfekUZJ27rJ4Q4hJ8INCK4u6orhbHkRp7W5lDUrif35KQtRtApLMY6sfmYqZHPW3A1w/nqjlRgQDhBw2GYjlco5WSkZq81v0AQzqhWFtoOSj6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=CTp6WVLh; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 794D5100008;
	Sat, 18 May 2024 04:34:18 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 794D5100008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1715996058;
	bh=Ejkyj4uClP3eAF1EWomDkE9xur1TurM408veIEcSrug=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=CTp6WVLh/OQ0aeCQ65EvW4VaTbf+VhCNEYIkItEADXzKBDU7rPtp+yPbr1Zy0mTkl
	 s7WxCSbz9sk5hQdvDtT2H2u8TLLxyr1XP2jo0+BeiaXWmh0sX37A7krFFLBipmhdHF
	 mU3bCx//JbnnlLWvzdI8/hhjQJWM9dD5oy6XDR58W+Kp4zC3ugaXjki8OljSAN015j
	 I4P5+yxfLgrmUp1XvdL9wcmSYJqzD2SyC9lANN/HTyLH9IxsV5n+eynaURgDTi7XxU
	 lOND++ikQedBaDDu/9kYjKkv6vqSFgGg4Nw0AvXM5rh1T61mhNKHnQOnE++DqyB42v
	 69mdcae0K6pHw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sat, 18 May 2024 04:34:17 +0300 (MSK)
Received: from [192.168.20.2] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 18 May 2024 04:34:16 +0300
Message-ID: <6944f440-9029-4c08-80f7-b67e23f13dae@salutedevices.com>
Date: Sat, 18 May 2024 04:33:25 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 9/9] clk: amlogic: axg-audio: use the auxiliary reset
 driver
Content-Language: en-US
To: Jerome Brunet <jbrunet@baylibre.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>, Neil Armstrong
	<neil.armstrong@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-clk@vger.kernel.org>
References: <20240516150842.705844-1-jbrunet@baylibre.com>
 <20240516150842.705844-10-jbrunet@baylibre.com>
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
In-Reply-To: <20240516150842.705844-10-jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185325 [May 18 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_smtp_not_equal_from}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1;100.64.160.123:7.1.2;salutedevices.com:7.1.1;sberdevices.ru:7.1.1,5.0.1, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/05/17 20:54:00 #25244128
X-KSMG-AntiVirus-Status: Clean, skipped

May be I'm doing something wrong, but "git am" fails on this patch on
tag next-20240517.

On 5/16/24 18:08, Jerome Brunet wrote:
> Remove the implementation of the reset driver in axg audio
> clock driver and migrate to the one provided by reset framework
> on auxiliary bus
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/clk/meson/Kconfig     |   1 +
>  drivers/clk/meson/axg-audio.c | 108 +++-------------------------------
>  2 files changed, 9 insertions(+), 100 deletions(-)
> 
> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> index 6905aa2f080c..b89e769a6362 100644
> --- a/drivers/clk/meson/Kconfig
> +++ b/drivers/clk/meson/Kconfig
> @@ -110,6 +110,7 @@ config COMMON_CLK_AXG_AUDIO
>  	select COMMON_CLK_MESON_PHASE
>  	select COMMON_CLK_MESON_SCLK_DIV
>  	select COMMON_CLK_MESON_CLKC_UTILS
> +	select COMMON_CLK_MESON_CLK_RST_AUX
>  	select REGMAP_MMIO
>  	help
>  	  Support for the audio clock controller on AmLogic A113D devices,
> diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
> index 93e6a6d321be..dc9191a9ab0f 100644
> --- a/drivers/clk/meson/axg-audio.c
> +++ b/drivers/clk/meson/axg-audio.c
> @@ -15,6 +15,7 @@
>  #include <linux/reset-controller.h>
>  #include <linux/slab.h>
>  
> +#include "meson-clk-rst-aux.h"
>  #include "meson-clkc-utils.h"
>  #include "axg-audio.h"
>  #include "clk-regmap.h"
> @@ -1678,84 +1679,6 @@ static struct clk_regmap *const sm1_clk_regmaps[] = {
>  	&sm1_earcrx_dmac_clk,
>  };
>  
> -struct axg_audio_reset_data {
> -	struct reset_controller_dev rstc;
> -	struct regmap *map;
> -	unsigned int offset;
> -};
> -
> -static void axg_audio_reset_reg_and_bit(struct axg_audio_reset_data *rst,
> -					unsigned long id,
> -					unsigned int *reg,
> -					unsigned int *bit)
> -{
> -	unsigned int stride = regmap_get_reg_stride(rst->map);
> -
> -	*reg = (id / (stride * BITS_PER_BYTE)) * stride;
> -	*reg += rst->offset;
> -	*bit = id % (stride * BITS_PER_BYTE);
> -}
> -
> -static int axg_audio_reset_update(struct reset_controller_dev *rcdev,
> -				unsigned long id, bool assert)
> -{
> -	struct axg_audio_reset_data *rst =
> -		container_of(rcdev, struct axg_audio_reset_data, rstc);
> -	unsigned int offset, bit;
> -
> -	axg_audio_reset_reg_and_bit(rst, id, &offset, &bit);
> -
> -	regmap_update_bits(rst->map, offset, BIT(bit),
> -			assert ? BIT(bit) : 0);
> -
> -	return 0;
> -}
> -
> -static int axg_audio_reset_status(struct reset_controller_dev *rcdev,
> -				unsigned long id)
> -{
> -	struct axg_audio_reset_data *rst =
> -		container_of(rcdev, struct axg_audio_reset_data, rstc);
> -	unsigned int val, offset, bit;
> -
> -	axg_audio_reset_reg_and_bit(rst, id, &offset, &bit);
> -
> -	regmap_read(rst->map, offset, &val);
> -
> -	return !!(val & BIT(bit));
> -}
> -
> -static int axg_audio_reset_assert(struct reset_controller_dev *rcdev,
> -				unsigned long id)
> -{
> -	return axg_audio_reset_update(rcdev, id, true);
> -}
> -
> -static int axg_audio_reset_deassert(struct reset_controller_dev *rcdev,
> -				unsigned long id)
> -{
> -	return axg_audio_reset_update(rcdev, id, false);
> -}
> -
> -static int axg_audio_reset_toggle(struct reset_controller_dev *rcdev,
> -				unsigned long id)
> -{
> -	int ret;
> -
> -	ret = axg_audio_reset_assert(rcdev, id);
> -	if (ret)
> -		return ret;
> -
> -	return axg_audio_reset_deassert(rcdev, id);
> -}
> -
> -static const struct reset_control_ops axg_audio_rstc_ops = {
> -	.assert = axg_audio_reset_assert,
> -	.deassert = axg_audio_reset_deassert,
> -	.reset = axg_audio_reset_toggle,
> -	.status = axg_audio_reset_status,
> -};
> -
>  static const struct regmap_config axg_audio_regmap_cfg = {
>  	.reg_bits	= 32,
>  	.val_bits	= 32,
> @@ -1766,15 +1689,13 @@ struct audioclk_data {
>  	struct clk_regmap *const *regmap_clks;
>  	unsigned int regmap_clk_num;
>  	struct meson_clk_hw_data hw_clks;
> -	unsigned int reset_offset;
> -	unsigned int reset_num;
> +	const char *rst_drvname;
>  };
>  
>  static int axg_audio_clkc_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	const struct audioclk_data *data;
> -	struct axg_audio_reset_data *rst;
>  	struct regmap *map;
>  	void __iomem *regs;
>  	struct clk_hw *hw;
> @@ -1832,22 +1753,11 @@ static int axg_audio_clkc_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	/* Stop here if there is no reset */
> -	if (!data->reset_num)
> -		return 0;
> -
> -	rst = devm_kzalloc(dev, sizeof(*rst), GFP_KERNEL);
> -	if (!rst)
> -		return -ENOMEM;
> -
> -	rst->map = map;
> -	rst->offset = data->reset_offset;
> -	rst->rstc.nr_resets = data->reset_num;
> -	rst->rstc.ops = &axg_audio_rstc_ops;
> -	rst->rstc.of_node = dev->of_node;
> -	rst->rstc.owner = THIS_MODULE;
> +	/* Register auxiliary reset driver when applicable */
> +	if (data->rst_drvname)
> +		ret = devm_meson_clk_rst_aux_register(dev, map, data->rst_drvname);
>  
> -	return devm_reset_controller_register(dev, &rst->rstc);
> +	return ret;
>  }
>  
>  static const struct audioclk_data axg_audioclk_data = {
> @@ -1866,8 +1776,7 @@ static const struct audioclk_data g12a_audioclk_data = {
>  		.hws = g12a_audio_hw_clks,
>  		.num = ARRAY_SIZE(g12a_audio_hw_clks),
>  	},
> -	.reset_offset = AUDIO_SW_RESET,
> -	.reset_num = 26,
> +	.rst_drvname = "rst-g12a",
>  };
>  
>  static const struct audioclk_data sm1_audioclk_data = {
> @@ -1877,8 +1786,7 @@ static const struct audioclk_data sm1_audioclk_data = {
>  		.hws = sm1_audio_hw_clks,
>  		.num = ARRAY_SIZE(sm1_audio_hw_clks),
>  	},
> -	.reset_offset = AUDIO_SM1_SW_RESET0,
> -	.reset_num = 39,
> +	.rst_drvname = "rst-sm1",
>  };
>  
>  static const struct of_device_id clkc_match_table[] = {

-- 
Best regards
Jan Dakinevich

