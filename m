Return-Path: <linux-kernel+bounces-179060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2F48C5B19
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 20:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EBF21F22C3D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 18:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67043180A80;
	Tue, 14 May 2024 18:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="gN7mctjF"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A67144D3E;
	Tue, 14 May 2024 18:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715711640; cv=none; b=qU7E+Ld0C/37vW0SLUYicORefglaboXrf0KuVkpmuDUiuzdayDnNEfzAJqYF5jeBt31alwlnzCGDb9w3EHRV9xYImYDG52joTjpGyMDUBPAgZm1wFhH0x92YePEyKdiVFKhcFDZv30sDpqHSeCs1QyrSvLJ0oqJzjfFavGsybEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715711640; c=relaxed/simple;
	bh=1N5qRp34kjnnxhN90uEqwEl33CZPRlIPG+iyiSnZOLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=urA9xNOBRgEHyHNoczs7AFy2eFoE2VK31P0UsL6j7BauR4ZveAlkcOcqr+BF+XAGqwMMNEl1Lrp0a0XxstsabSQ02ToTUBimjyW4h7htAINyl63lpORbpuSJXsR4N+cg5Fp86B6KrSdpMexE82RxuF4KwHwfkfbYrlIp/vqlyNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=gN7mctjF; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 034EF12001D;
	Tue, 14 May 2024 21:33:49 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 034EF12001D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1715711629;
	bh=Xf0rp2z6RWB8A7jw+gQ0k7R5uIp5z8rMQsLDxIyOnGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=gN7mctjFb6jxMKefpJoF3Imp/vg88131RgtYJaNEZZ5R5n9qMY+LrIZL+vz2Pa4vW
	 QXulTl90Y5GPZg94/2e8WPnLY0lupbFzsr7s8S9J09Mgp+rKq8d+B8DZrL+FCU7k/Y
	 2gXass6t6AGuzs3nQKshrOChwf0sWJIO3ICs9jiqXNVylrZNRTS92La+ApQqOYgzlW
	 8CMiyvJJlhVHyuuSCrOebRt/ZHi7kJLF3U7xNHxPbjkUz2hP8c4KrCxKaFkpVlD91h
	 dtz0dwLsk3yLP2Cq58JBFSRbXUIwHkfLLZ6vWXgOW5tOdHMJBe9nxi7dFeGjqYervX
	 fuLX/zz6OicpQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 14 May 2024 21:33:48 +0300 (MSK)
Received: from [172.28.128.189] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 14 May 2024 21:33:47 +0300
Message-ID: <7860cbce-053d-4eb2-aee8-c7c233392cf7@salutedevices.com>
Date: Tue, 14 May 2024 21:33:05 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 1/6] reset: reset-meson-audio: introduce separate
 driver
Content-Language: en-US
To: Jerome Brunet <jbrunet@baylibre.com>
CC: Neil Armstrong <neil.armstrong@linaro.org>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, Jiucheng Xu <jiucheng.xu@amlogic.com>,
	<linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
References: <20240419125812.983409-1-jan.dakinevich@salutedevices.com>
 <20240419125812.983409-2-jan.dakinevich@salutedevices.com>
 <1j8r15bzqa.fsf@starbuckisacylon.baylibre.com>
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
In-Reply-To: <1j8r15bzqa.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185229 [May 14 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_smtp_not_equal_from}, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2;sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/05/14 15:44:00 #25213880
X-KSMG-AntiVirus-Status: Clean, skipped



On 4/22/24 10:46, Jerome Brunet wrote:
> 
> On Fri 19 Apr 2024 at 15:58, Jan Dakinevich <jan.dakinevich@salutedevices.com> wrote:
> 
>> Typically, Amlogic Meson SoCs have a couple a reset registers lost in
>> middle of audio clock controller. Reset controller on top of them was
>> implemented inside audio clock controller driver. This patch moves reset
>> functionality of this controller to auxiliary driver. There are at least
>> two reasons for this:
>>
>>   - architecturally it is more convenient;
>>
>>   - reusing the code of reset controller for new SoCs becomes easier.
>>
>> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
>> ---
>>  drivers/clk/meson/Kconfig               |   2 +
>>  drivers/clk/meson/axg-audio.c           | 106 +------------
>>  drivers/reset/Kconfig                   |   7 +
>>  drivers/reset/Makefile                  |   1 +
>>  drivers/reset/reset-meson-audio.c       | 197 ++++++++++++++++++++++++
>>  include/soc/amlogic/meson-audio-reset.h |  10 ++
> 
> You must an effort to touch a single subsystem per series.
> Making a series about a single subsystem makes like a lot easier for
> maintainers. clk, reset and dt and different subsystems
> 
> That constraints relaxed for RFCs but mixing subsystems within a single
> patch is a red flag, unless you really have a good reason ... and you
> don't have one here.
> 
> Nothing blocks introducting support in reset, then use it in clocks.
> 
> You could also have allowed a bit more time before reposting since I
> said I would look at the reset issue.
> 

Jerome, do you have any updates? I'm still waiting to send the new
version of the clock driver.

> I doubt introducing a separate driver for this is required since since
> the current amlogic reset driver is fairly close.
> 
>>  6 files changed, 224 insertions(+), 99 deletions(-)
>>  create mode 100644 drivers/reset/reset-meson-audio.c
>>  create mode 100644 include/soc/amlogic/meson-audio-reset.h
>>
>> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
>> index 29ffd14d267b..33614f8b8cf7 100644
>> --- a/drivers/clk/meson/Kconfig
>> +++ b/drivers/clk/meson/Kconfig
>> @@ -101,6 +101,8 @@ config COMMON_CLK_AXG_AUDIO
>>  	select COMMON_CLK_MESON_PHASE
>>  	select COMMON_CLK_MESON_SCLK_DIV
>>  	select COMMON_CLK_MESON_CLKC_UTILS
>> +	select RESET_CONTROLLER
>> +	select RESET_MESON_AUDIO
>>  	select REGMAP_MMIO
>>  	help
>>  	  Support for the audio clock controller on AmLogic A113D devices,
>> diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
>> index ac3482960903..9cd6b5c3aa7e 100644
>> --- a/drivers/clk/meson/axg-audio.c
>> +++ b/drivers/clk/meson/axg-audio.c
>> @@ -12,9 +12,10 @@
>>  #include <linux/platform_device.h>
>>  #include <linux/regmap.h>
>>  #include <linux/reset.h>
>> -#include <linux/reset-controller.h>
>>  #include <linux/slab.h>
>>  
>> +#include <soc/amlogic/meson-audio-reset.h>
>> +
>>  #include "meson-clkc-utils.h"
>>  #include "axg-audio.h"
>>  #include "clk-regmap.h"
>> @@ -1648,84 +1649,6 @@ static struct clk_regmap *const sm1_clk_regmaps[] = {
>>  	&sm1_sysclk_b_en,
>>  };
>>  
>> -struct axg_audio_reset_data {
>> -	struct reset_controller_dev rstc;
>> -	struct regmap *map;
>> -	unsigned int offset;
>> -};
>> -
>> -static void axg_audio_reset_reg_and_bit(struct axg_audio_reset_data *rst,
>> -					unsigned long id,
>> -					unsigned int *reg,
>> -					unsigned int *bit)
>> -{
>> -	unsigned int stride = regmap_get_reg_stride(rst->map);
>> -
>> -	*reg = (id / (stride * BITS_PER_BYTE)) * stride;
>> -	*reg += rst->offset;
>> -	*bit = id % (stride * BITS_PER_BYTE);
>> -}
>> -
>> -static int axg_audio_reset_update(struct reset_controller_dev *rcdev,
>> -				unsigned long id, bool assert)
>> -{
>> -	struct axg_audio_reset_data *rst =
>> -		container_of(rcdev, struct axg_audio_reset_data, rstc);
>> -	unsigned int offset, bit;
>> -
>> -	axg_audio_reset_reg_and_bit(rst, id, &offset, &bit);
>> -
>> -	regmap_update_bits(rst->map, offset, BIT(bit),
>> -			assert ? BIT(bit) : 0);
>> -
>> -	return 0;
>> -}
>> -
>> -static int axg_audio_reset_status(struct reset_controller_dev *rcdev,
>> -				unsigned long id)
>> -{
>> -	struct axg_audio_reset_data *rst =
>> -		container_of(rcdev, struct axg_audio_reset_data, rstc);
>> -	unsigned int val, offset, bit;
>> -
>> -	axg_audio_reset_reg_and_bit(rst, id, &offset, &bit);
>> -
>> -	regmap_read(rst->map, offset, &val);
>> -
>> -	return !!(val & BIT(bit));
>> -}
>> -
>> -static int axg_audio_reset_assert(struct reset_controller_dev *rcdev,
>> -				unsigned long id)
>> -{
>> -	return axg_audio_reset_update(rcdev, id, true);
>> -}
>> -
>> -static int axg_audio_reset_deassert(struct reset_controller_dev *rcdev,
>> -				unsigned long id)
>> -{
>> -	return axg_audio_reset_update(rcdev, id, false);
>> -}
>> -
>> -static int axg_audio_reset_toggle(struct reset_controller_dev *rcdev,
>> -				unsigned long id)
>> -{
>> -	int ret;
>> -
>> -	ret = axg_audio_reset_assert(rcdev, id);
>> -	if (ret)
>> -		return ret;
>> -
>> -	return axg_audio_reset_deassert(rcdev, id);
>> -}
>> -
>> -static const struct reset_control_ops axg_audio_rstc_ops = {
>> -	.assert = axg_audio_reset_assert,
>> -	.deassert = axg_audio_reset_deassert,
>> -	.reset = axg_audio_reset_toggle,
>> -	.status = axg_audio_reset_status,
>> -};
>> -
>>  static const struct regmap_config axg_audio_regmap_cfg = {
>>  	.reg_bits	= 32,
>>  	.val_bits	= 32,
>> @@ -1737,15 +1660,13 @@ struct audioclk_data {
>>  	struct clk_regmap *const *regmap_clks;
>>  	unsigned int regmap_clk_num;
>>  	struct meson_clk_hw_data hw_clks;
>> -	unsigned int reset_offset;
>> -	unsigned int reset_num;
>> +	const char *reset_name;
>>  };
>>  
>>  static int axg_audio_clkc_probe(struct platform_device *pdev)
>>  {
>>  	struct device *dev = &pdev->dev;
>>  	const struct audioclk_data *data;
>> -	struct axg_audio_reset_data *rst;
>>  	struct regmap *map;
>>  	void __iomem *regs;
>>  	struct clk_hw *hw;
>> @@ -1804,21 +1725,10 @@ static int axg_audio_clkc_probe(struct platform_device *pdev)
>>  		return ret;
>>  
>>  	/* Stop here if there is no reset */
>> -	if (!data->reset_num)
>> +	if (!data->reset_name)
>>  		return 0;
>>  
>> -	rst = devm_kzalloc(dev, sizeof(*rst), GFP_KERNEL);
>> -	if (!rst)
>> -		return -ENOMEM;
>> -
>> -	rst->map = map;
>> -	rst->offset = data->reset_offset;
>> -	rst->rstc.nr_resets = data->reset_num;
>> -	rst->rstc.ops = &axg_audio_rstc_ops;
>> -	rst->rstc.of_node = dev->of_node;
>> -	rst->rstc.owner = THIS_MODULE;
>> -
>> -	return devm_reset_controller_register(dev, &rst->rstc);
>> +	return meson_audio_reset_register(dev, data->reset_name);
>>  }
>>  
>>  static const struct audioclk_data axg_audioclk_data = {
>> @@ -1837,8 +1747,7 @@ static const struct audioclk_data g12a_audioclk_data = {
>>  		.hws = g12a_audio_hw_clks,
>>  		.num = ARRAY_SIZE(g12a_audio_hw_clks),
>>  	},
>> -	.reset_offset = AUDIO_SW_RESET,
>> -	.reset_num = 26,
>> +	.reset_name = "g12a",
>>  };
>>  
>>  static const struct audioclk_data sm1_audioclk_data = {
>> @@ -1848,8 +1757,7 @@ static const struct audioclk_data sm1_audioclk_data = {
>>  		.hws = sm1_audio_hw_clks,
>>  		.num = ARRAY_SIZE(sm1_audio_hw_clks),
>>  	},
>> -	.reset_offset = AUDIO_SM1_SW_RESET0,
>> -	.reset_num = 39,
>> +	.reset_name = "sm1",
>>  };
>>  
>>  static const struct of_device_id clkc_match_table[] = {
>> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
>> index 7112f5932609..98106694566f 100644
>> --- a/drivers/reset/Kconfig
>> +++ b/drivers/reset/Kconfig
>> @@ -138,6 +138,13 @@ config RESET_MESON
>>  	help
>>  	  This enables the reset driver for Amlogic Meson SoCs.
>>  
>> +config RESET_MESON_AUDIO
>> +	tristate "Meson Audio Reset Driver"
>> +	depends on ARCH_MESON || COMPILE_TEST
>> +	select AUXILIARY_BUS
>> +	help
>> +	  This enables the audio reset driver for Amlogic Meson SoCs.
>> +
>>  config RESET_MESON_AUDIO_ARB
>>  	tristate "Meson Audio Memory Arbiter Reset Driver"
>>  	depends on ARCH_MESON || COMPILE_TEST
>> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
>> index fd8b49fa46fc..8ee7a57ccf03 100644
>> --- a/drivers/reset/Makefile
>> +++ b/drivers/reset/Makefile
>> @@ -20,6 +20,7 @@ obj-$(CONFIG_RESET_LANTIQ) += reset-lantiq.o
>>  obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
>>  obj-$(CONFIG_RESET_MCHP_SPARX5) += reset-microchip-sparx5.o
>>  obj-$(CONFIG_RESET_MESON) += reset-meson.o
>> +obj-$(CONFIG_RESET_MESON_AUDIO) += reset-meson-audio.o
>>  obj-$(CONFIG_RESET_MESON_AUDIO_ARB) += reset-meson-audio-arb.o
>>  obj-$(CONFIG_RESET_NPCM) += reset-npcm.o
>>  obj-$(CONFIG_RESET_NUVOTON_MA35D1) += reset-ma35d1.o
>> diff --git a/drivers/reset/reset-meson-audio.c b/drivers/reset/reset-meson-audio.c
>> new file mode 100644
>> index 000000000000..aaea9931cfe2
>> --- /dev/null
>> +++ b/drivers/reset/reset-meson-audio.c
>> @@ -0,0 +1,197 @@
>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>> +/*
>> + * Copyright (c) 2018 BayLibre, SAS.
>> + * Author: Jerome Brunet <jbrunet@baylibre.com>
>> + */
>> +
>> +#include <linux/regmap.h>
>> +#include <linux/auxiliary_bus.h>
>> +#include <linux/reset-controller.h>
>> +
>> +#include <soc/amlogic/meson-audio-reset.h>
>> +
>> +struct meson_audio_reset_data {
>> +	struct reset_controller_dev rstc;
>> +	struct regmap *map;
>> +	unsigned int offset;
>> +};
>> +
>> +struct meson_audio_reset_info {
>> +	unsigned int reset_offset;
>> +	unsigned int reset_num;
>> +};
>> +
>> +static void meson_audio_reset_reg_and_bit(struct meson_audio_reset_data *rst,
>> +					  unsigned long id,
>> +					  unsigned int *reg,
>> +					  unsigned int *bit)
>> +{
>> +	unsigned int stride = regmap_get_reg_stride(rst->map);
>> +
>> +	*reg = (id / (stride * BITS_PER_BYTE)) * stride;
>> +	*reg += rst->offset;
>> +	*bit = id % (stride * BITS_PER_BYTE);
>> +}
>> +
>> +static int meson_audio_reset_update(struct reset_controller_dev *rcdev,
>> +				    unsigned long id, bool assert)
>> +{
>> +	struct meson_audio_reset_data *rst =
>> +		container_of(rcdev, struct meson_audio_reset_data, rstc);
>> +	unsigned int offset, bit;
>> +
>> +	meson_audio_reset_reg_and_bit(rst, id, &offset, &bit);
>> +
>> +	regmap_update_bits(rst->map, offset, BIT(bit),
>> +			assert ? BIT(bit) : 0);
>> +
>> +	return 0;
>> +}
>> +
>> +static int meson_audio_reset_status(struct reset_controller_dev *rcdev,
>> +				    unsigned long id)
>> +{
>> +	struct meson_audio_reset_data *rst =
>> +		container_of(rcdev, struct meson_audio_reset_data, rstc);
>> +	unsigned int val, offset, bit;
>> +
>> +	meson_audio_reset_reg_and_bit(rst, id, &offset, &bit);
>> +
>> +	regmap_read(rst->map, offset, &val);
>> +
>> +	return !!(val & BIT(bit));
>> +}
>> +
>> +static int meson_audio_reset_assert(struct reset_controller_dev *rcdev,
>> +				    unsigned long id)
>> +{
>> +	return meson_audio_reset_update(rcdev, id, true);
>> +}
>> +
>> +static int meson_audio_reset_deassert(struct reset_controller_dev *rcdev,
>> +				      unsigned long id)
>> +{
>> +	return meson_audio_reset_update(rcdev, id, false);
>> +}
>> +
>> +static int meson_audio_reset_toggle(struct reset_controller_dev *rcdev,
>> +				    unsigned long id)
>> +{
>> +	int ret;
>> +
>> +	ret = meson_audio_reset_assert(rcdev, id);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return meson_audio_reset_deassert(rcdev, id);
>> +}
>> +
>> +static const struct reset_control_ops meson_audio_reset_ops = {
>> +	.assert = meson_audio_reset_assert,
>> +	.deassert = meson_audio_reset_deassert,
>> +	.reset = meson_audio_reset_toggle,
>> +	.status = meson_audio_reset_status,
>> +};
>> +
>> +static int meson_audio_reset_probe(struct auxiliary_device *adev,
>> +				  const struct auxiliary_device_id *id)
>> +{
>> +	struct device *dev = &adev->dev;
>> +	struct meson_audio_reset_info *info =
>> +		(struct meson_audio_reset_info *)id->driver_data;
>> +	struct meson_audio_reset_data *rst;
>> +
>> +	dev_info(dev, "%s, reset_offset = %#x, reset_num = %u", __func__,
>> +		 info->reset_offset, info->reset_num);
>> +
>> +	rst = devm_kzalloc(dev, sizeof(*rst), GFP_KERNEL);
>> +	if (!rst)
>> +		return -ENOMEM;
>> +
>> +	rst->map = dev_get_regmap(dev->parent, NULL);
>> +	if (!rst->map)
>> +		return -ENODEV;
>> +
>> +	rst->offset = info->reset_offset;
>> +	rst->rstc.ops = &meson_audio_reset_ops;
>> +	rst->rstc.of_node = dev->parent->of_node;
>> +	rst->rstc.nr_resets = info->reset_num;
>> +	rst->rstc.owner = THIS_MODULE;
>> +
>> +	return devm_reset_controller_register(dev, &rst->rstc);
>> +}
>> +
>> +static void meson_audio_reset_adev_release(struct device *dev)
>> +{
>> +	struct auxiliary_device *adev = to_auxiliary_dev(dev);
>> +
>> +	kfree(adev);
>> +}
>> +
>> +static void meson_audio_reset_adev_unregister(void *_adev)
>> +{
>> +	struct auxiliary_device *adev = _adev;
>> +
>> +	auxiliary_device_delete(adev);
>> +	auxiliary_device_uninit(adev);
>> +}
>> +
>> +static const struct meson_audio_reset_info meson_audio_reset_info_g12a = {
>> +	.reset_offset = 0x024,
>> +	.reset_num = 26,
>> +};
>> +
>> +static const struct meson_audio_reset_info meson_audio_reset_info_sm1 = {
>> +	.reset_offset = 0x028,
>> +	.reset_num = 39,
>> +};
>> +static const struct auxiliary_device_id meson_audio_reset_id[] = {
>> +	{
>> +		.name = "reset_meson_audio.g12a",
>> +		.driver_data = (kernel_ulong_t)&meson_audio_reset_info_g12a,
>> +	},
>> +	{
>> +		.name = "reset_meson_audio.sm1",
>> +		.driver_data = (kernel_ulong_t)&meson_audio_reset_info_sm1,
>> +	},
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(auxiliary, meson_audio_reset_id);
>> +
>> +static struct auxiliary_driver meson_audio_reset_driver = {
>> +	.probe = meson_audio_reset_probe,
>> +	.id_table = meson_audio_reset_id,
>> +};
>> +
>> +module_auxiliary_driver(meson_audio_reset_driver);
>> +
>> +int meson_audio_reset_register(struct device *dev, const char *name)
>> +{
>> +	struct auxiliary_device *adev;
>> +	int ret;
>> +
>> +	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
>> +	if (!adev)
>> +		return -ENOMEM;
>> +
>> +	adev->name = name;
>> +	adev->dev.parent = dev;
>> +	adev->dev.release = meson_audio_reset_adev_release;
>> +	adev->id = 0;
>> +
>> +	ret = auxiliary_device_init(adev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = auxiliary_device_add(adev);
>> +	if (ret) {
>> +		auxiliary_device_uninit(adev);
>> +		return ret;
>> +	}
>> +
>> +	return devm_add_action_or_reset(dev, meson_audio_reset_adev_unregister,
>> +					adev);
>> +}
>> +EXPORT_SYMBOL_GPL(meson_audio_reset_register);
>> +
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/include/soc/amlogic/meson-audio-reset.h b/include/soc/amlogic/meson-audio-reset.h
>> new file mode 100644
>> index 000000000000..279c6a2197ec
>> --- /dev/null
>> +++ b/include/soc/amlogic/meson-audio-reset.h
>> @@ -0,0 +1,10 @@
>> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
>> +
>> +#ifndef __MESON_AUDIO_RESET_H
>> +#define __MESON_AUDIO_RESET_H
>> +
>> +#include <linux/device.h>
>> +
>> +int meson_audio_reset_register(struct device *dev, const char *name);
>> +
>> +#endif /* __MESON_AUDIO_RESET_H */
> 
> 

-- 
Best regards
Jan Dakinevich

