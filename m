Return-Path: <linux-kernel+bounces-208236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 093EE9022B5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E708282783
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D16824BB;
	Mon, 10 Jun 2024 13:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgtdTudY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C7F74048;
	Mon, 10 Jun 2024 13:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718026184; cv=none; b=lchpmUtjLFJUBfLihSbE/Eh8pzgOv6XojHa3b2i2mPKqfos0xBBnjhvqydZlCSNdB2lyiDIkPHSCAYz/32TCt1/IoZMXaeyvxHptj1ddzfE/QvQTiHT0ldk0snkYvA00HojQmVV7z6KJpiBFMvCv4ugSLzoz419YvVOGjPd4jLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718026184; c=relaxed/simple;
	bh=D/A37FeOcM3AFIwnZJ4YD0OpZPJ+P4kW0Fs+sqCR0ho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kt6B1lzrQoiIcl1mVwN2pS85nIe0c3Kqp6iaz4XPn2F/EMlh5c6PauJmktm7oW7kYpjiKE+BO8xfdx9/M2F5X/qUpcrNRrIVI3tN2rY6WxzLCw3fARbrot8KvZhi8Eh/WACMiIMwvBkgNp17vjzfe78pv4mP8SohAIMPxU/oj7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgtdTudY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C54EC2BBFC;
	Mon, 10 Jun 2024 13:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718026183;
	bh=D/A37FeOcM3AFIwnZJ4YD0OpZPJ+P4kW0Fs+sqCR0ho=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bgtdTudYgkDnJy4JYVgZ2IAIClCbEPtz4RTcn1s7l84b3o2EILwrkc9Yf4ofztBDZ
	 ltuZn/I/PJFzQ+O8IQEA+HejniKPc0GFXFOuA00sh6WVfeZEdOfz7LAWf8e9sVegpE
	 GXWhk9x4m4qcImnKTc7T5ktoJPORNs/sfQLgl0o8X5JVQInntrmEWDUv3YJ3CRlR/2
	 1WRQCMABJt95eB6TvyO30WA93pAWMcrNOsmr5YLHVjt0Jy2l5A9l6bTwAzvex4uq4J
	 KLizo3IMxTwXP/rNU63SA6Juse1BCDhZOFSdCTH/jL20idPy64jNflsTDYUoKKdvIo
	 EXLAAusuzA2fw==
Message-ID: <572c35c8-3a37-452d-a9cf-ba726d7e9eab@kernel.org>
Date: Mon, 10 Jun 2024 15:29:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: fsl: Add i2s and pcm drivers for LPC32xx CPUs
To: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Vladimir Zapolskiy <vz@mleia.com>,
 Russell King <linux@armlinux.org.uk>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240610102415.79740-1-piotr.wojtaszczyk@timesys.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240610102415.79740-1-piotr.wojtaszczyk@timesys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/06/2024 12:24, Piotr Wojtaszczyk wrote:
> This driver was ported from an old version in linux 2.6.27 and adjusted
> for the new ASoC framework and DMA API.
> 
> Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
> ---
>  .../bindings/sound/nxp,lpc3220-i2s.yaml       |  50 +++
>  arch/arm/boot/dts/lpc32xx.dtsi                |   4 +
>  arch/arm/mach-lpc32xx/phy3250.c               |  60 +++
>  sound/soc/fsl/Kconfig                         |   7 +
>  sound/soc/fsl/Makefile                        |   2 +
>  sound/soc/fsl/lpc3xxx-i2s.c                   | 411 ++++++++++++++++++
>  sound/soc/fsl/lpc3xxx-i2s.h                   |  94 ++++
>  sound/soc/fsl/lpc3xxx-pcm.c                   |  75 ++++
>  8 files changed, 703 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/nxp,lpc3220-i2s.yaml
>  create mode 100644 sound/soc/fsl/lpc3xxx-i2s.c
>  create mode 100644 sound/soc/fsl/lpc3xxx-i2s.h
>  create mode 100644 sound/soc/fsl/lpc3xxx-pcm.c
> 
> diff --git a/Documentation/devicetree/bindings/sound/nxp,lpc3220-i2s.yaml b/Documentation/devicetree/bindings/sound/nxp,lpc3220-i2s.yaml
> new file mode 100644

Please run scripts/checkpatch.pl and fix reported warnings. Then please
run `scripts/checkpatch.pl --strict` and (probably) fix more warnings.
Some warnings can be ignored, especially from --strict run, but the code
here looks like it needs a fix. Feel free to get in touch if the warning
is not clear.


> index 000000000000..e41330b6775c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/nxp,lpc3220-i2s.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/nxp,lpc3220-i2s.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP LPC32XX I2S Controller
> +
> +description:
> +  The block adds I2S and PCM drivers for LPC32XX

Please describe the hardware. What is "this block"? What is a driver?
Like a Linux driver? Then not, describe the hardware.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - nxp,lpc3220-i2s
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: input clock of the peripheral.
> +
> +  clock-names:
> +    items:
> +      - const: i2s_clk

Drop _clk. Or actually drop entire clock-names, obvious and not needed.

> +
> +  interrupts:
> +    maxItems: 1

That's not a DAI?

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/lpc32xx-clock.h>
> +
> +    i2s0: i2s@20094000 {
> +      compatible = "nxp,lpc3220-i2s";
> +      reg = <0x20094000 0x1000>;
> +      clocks = <&clk LPC32XX_CLK_I2S0>;
> +      clock-names = "i2s_clk";

Make the example complete - missing interrupts.


> +    };
> +
> +...
> diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
> index c87066d6c995..dc5738f2b42d 100644
> --- a/arch/arm/boot/dts/lpc32xx.dtsi
> +++ b/arch/arm/boot/dts/lpc32xx.dtsi


? DTS is not ASoC. This MUST go via entirely different tree.


> @@ -221,6 +221,8 @@ spi2: spi@20090000 {


> +
> +const struct snd_soc_dai_ops lpc3xxx_i2s_dai_ops = {
> +	.startup = lpc3xxx_i2s_startup,
> +	.shutdown = lpc3xxx_i2s_shutdown,
> +	.prepare = lpc3xxx_i2s_prepare,
> +	.trigger = lpc3xxx_i2s_trigger,
> +	.hw_params = lpc3xxx_i2s_hw_params,
> +	.set_sysclk = lpc3xxx_i2s_set_dai_sysclk,
> +	.set_fmt = lpc3xxx_i2s_set_dai_fmt,
> +};
> +
> +static int lpc3xxx_i2s_dai_probe(struct snd_soc_dai *dai)
> +{
> +	struct lpc3xxx_i2s_info *i2s_info_p = snd_soc_dai_get_drvdata(dai);
> +
> +	snd_soc_dai_init_dma_data(dai, &i2s_info_p->playback_dma_config,
> +							&i2s_info_p->capture_dma_config);
> +	return 0;
> +}
> +
> +struct snd_soc_dai_driver lpc3xxx_i2s_dai_driver = {
> +	 .probe	= lpc3xxx_i2s_dai_probe,
> +	 .playback = {
> +		      .channels_min = 1,
> +		      .channels_max = 2,
> +		      .rates = LPC3XXX_I2S_RATES,
> +		      .formats = LPC3XXX_I2S_FORMATS,
> +		      },
> +	 .capture = {
> +		     .channels_min = 1,
> +		     .channels_max = 2,
> +		     .rates = LPC3XXX_I2S_RATES,
> +		     .formats = LPC3XXX_I2S_FORMATS,
> +		     },
> +	 .ops = &lpc3xxx_i2s_dai_ops,
> +	 .symmetric_rate = 1,
> +	 .symmetric_channels = 1,
> +	 .symmetric_sample_bits = 1,
> +};
> +
> +static const struct snd_soc_component_driver lpc32xx_i2s_component = {
> +	.name = "lpc32xx-i2s",
> +};
> +
> +static const struct regmap_config lpc32xx_i2s_regconfig = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.max_register = I2S_RX_RATE,
> +};
> +
> +static int lpc32xx_i2s_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct lpc3xxx_i2s_info *i2s_info_p;
> +	struct resource *res;
> +	void __iomem *iomem;
> +	int ret;
> +
> +	i2s_info_p = devm_kzalloc(dev, sizeof(*i2s_info_p), GFP_KERNEL);
> +	if (!i2s_info_p)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, i2s_info_p);
> +	i2s_info_p->dev = dev;
> +
> +	iomem = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> +	if (IS_ERR(iomem)) {
> +		dev_err(dev, "Can't map registers\n");

return dev_err_probe()

> +		return PTR_ERR(iomem);
> +	}
> +
> +	i2s_info_p->regs = devm_regmap_init_mmio(dev, iomem, &lpc32xx_i2s_regconfig);
> +	if (IS_ERR(i2s_info_p->regs)) {
> +		ret = PTR_ERR(i2s_info_p->regs);
> +		dev_err(dev, "failed to init register map: %d\n", ret);

return dev_err_probe()

> +		return ret;
> +	}
> +
> +	i2s_info_p->clk = devm_clk_get(dev, "i2s_clk");
> +	if (IS_ERR(i2s_info_p->clk)) {
> +		dev_err(dev, "Can't get clock\n");

return dev_err_probe()


> +		return PTR_ERR(i2s_info_p->clk);
> +	}
> +
> +	i2s_info_p->clkrate = clk_get_rate(i2s_info_p->clk);
> +	if (i2s_info_p->clkrate == 0) {
> +		dev_err(dev, "Invalid returned clock rate\n");
> +		goto err_clk_disable;
> +	}
> +
> +	mutex_init(&i2s_info_p->lock);
> +
> +	ret = devm_snd_soc_register_component(dev, &lpc32xx_i2s_component,
> +					 &lpc3xxx_i2s_dai_driver, 1);
> +	if (ret) {
> +		dev_err(dev, "Can't register cpu_dai component\n");
> +		goto err_clk_disable;

Where is the clock disable? It's just return dev_err_probe.

> +	}
> +
> +	i2s_info_p->playback_dma_config.addr = (dma_addr_t)(res->start + I2S_TX_FIFO);
> +	i2s_info_p->playback_dma_config.maxburst = 4;
> +	i2s_info_p->playback_dma_config.filter_data = "i2s-tx";
> +	i2s_info_p->capture_dma_config.addr = (dma_addr_t)(res->start + I2S_RX_FIFO);
> +	i2s_info_p->capture_dma_config.maxburst = 4;
> +	i2s_info_p->capture_dma_config.filter_data = "i2s-rx";
> +
> +	ret = lpc3xxx_pcm_register(pdev);
> +	if (ret) {
> +		dev_err(dev, "Can't register pcm component\n");
> +		goto err_clk_disable;
> +	}
> +
> +	return 0;
> +
> +err_clk_disable:
> +	return ret;


> +}
> +
> +static int lpc32xx_i2s_remove(struct platform_device *pdev)
> +{
> +	return 0;
> +}

Why do you need empty function?

> +
> +static const struct of_device_id lpc32xx_i2s_match[] = {
> +	{ .compatible = "nxp,lpc3220-i2s" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, lpc32xx_i2s_match);
> +
> +static struct platform_driver lpc32xx_i2s_driver = {
> +	.probe = lpc32xx_i2s_probe,
> +	.remove = lpc32xx_i2s_remove,
> +	.driver		= {
> +		.name	= "lpc3xxx-i2s",
> +		.of_match_table = of_match_ptr(lpc32xx_i2s_match),

Drop of_match_ptr, you will have here warnings.

> +	},
> +};
> +
> +module_platform_driver(lpc32xx_i2s_driver);
> +
> +MODULE_AUTHOR("Kevin Wells <kevin.wells@nxp.com>");
> +MODULE_AUTHOR("Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>");
> +MODULE_DESCRIPTION("ASoC LPC3XXX I2S interface");
> +MODULE_LICENSE("GPL");
> diff --git a/sound/soc/fsl/lpc3xxx-i2s.h b/sound/soc/fsl/lpc3xxx-i2s.h
> new file mode 100644
> index 000000000000..f88ab74cfe41


Best regards,
Krzysztof


