Return-Path: <linux-kernel+bounces-312351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D95F969552
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A29331C230DF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 07:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E171D6DB6;
	Tue,  3 Sep 2024 07:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qEMwhIS7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2041D6C48;
	Tue,  3 Sep 2024 07:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725348451; cv=none; b=QUuFeZB+2NT+QqGu+kkdfeEtgw4sJ0/Ca46Sx/N+wufeNZ0N5RmMmBIM885/wqNvGlShGdON7/xqqdI3CY4GgbeACfNM/GVD8PQAjASJT0/OI5U5zm+nAFWtbMmniCEa2hylfH20cReo5IDZoYMYTYeJxbO1fqsrWkH5XXfhKkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725348451; c=relaxed/simple;
	bh=FBTyhTz0hfnBO0ZeXv3g1ysGP0vjKBQSdRHL/Bw0uSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Foolh6Xwtw0hqUHCLRvuaFnRkkLeFIeQPBVU/K7aYWpOv8ELldQCBFKypIn/iJbzZ3zk0Pw9rc6Gp2TF4iqWJt7qbMph1xKzMtAkWFtEewcdPwNk9Mt5GT7TGorvW47ZLME/1wezfdlMouKiyha8nHobQs3jGsC6Tsj/9dKbALk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qEMwhIS7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A70CC4CEC5;
	Tue,  3 Sep 2024 07:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725348450;
	bh=FBTyhTz0hfnBO0ZeXv3g1ysGP0vjKBQSdRHL/Bw0uSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qEMwhIS7tPVZSCRuOKmZpeVkDHNc8Abam4blS4rR9cH3VLUD2zWHfpON3mXItbijT
	 wrMGkm4buyBNjzfMSV4Qjj725DDJ8OYZfUxCZj8lUOt17aNYsvLvytU3ptt3wfifvF
	 7NLGGkT6nlcFHbPWPhioQzFtIcRWNv45Y9P5sGcs81hSCvDFOOoix19Ok45QfXx197
	 nINEVtSxGZNfSUpoDngeYwxqL18piKEjVFfOSL9/hNZ3Eu1P1imSpiE+YeblWBX97z
	 mpOKcGg20UTcE3KRwVmcVh1bax7s9alBjHheF9S7VLnMLbZK6JEjacWqx5fmenOaMS
	 e44csNOypKuGg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1slNx2-0000000019Y-3NuM;
	Tue, 03 Sep 2024 09:27:45 +0200
Date: Tue, 3 Sep 2024 09:27:44 +0200
From: Johan Hovold <johan@kernel.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Trilok Soni <quic_tsoni@quicinc.com>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] usb: typec: Add support for Parade PS8830 Type-C
 Retimer
Message-ID: <Zta6cBq881Ju7r7H@hovoldconsulting.com>
References: <20240829-x1e80100-ps8830-v1-0-bcc4790b1d45@linaro.org>
 <20240829-x1e80100-ps8830-v1-2-bcc4790b1d45@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829-x1e80100-ps8830-v1-2-bcc4790b1d45@linaro.org>

On Thu, Aug 29, 2024 at 09:44:26PM +0300, Abel Vesa wrote:
> The Parade PS8830 is a Type-C muti-protocol retimer controlled over I2C.
> It provides both altmode and orientation handling.
> 
> Add a driver with support for the following modes:
>  - DP 4lanes
>  - USB3
>  - DP 2lanes + USB3
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

> +struct ps8830_retimer {
> +	struct i2c_client *client;
> +	struct regulator_bulk_data supplies[4];
> +	struct gpio_desc *reset_gpio;
> +	struct regmap *regmap;
> +	struct typec_switch_dev *sw;
> +	struct typec_retimer *retimer;
> +	struct clk *xo_clk;
> +
> +	bool needs_update;
> +	struct typec_switch *typec_switch;
> +	struct typec_mux *typec_mux;
> +
> +	struct mutex lock; /* protect non-concurrent retimer & switch */
> +
> +	enum typec_orientation orientation;
> +	unsigned long mode;
> +	int cfg[3];
> +

Stray newline.

> +};
> +
> +static int ps8830_configure(struct ps8830_retimer *retimer, int cfg0, int cfg1, int cfg2)
> +{
> +	if (cfg0 == retimer->cfg[0] &&
> +	    cfg1 == retimer->cfg[1] &&
> +	    cfg2 == retimer->cfg[2])
> +		return 0;
> +
> +	retimer->cfg[0] = cfg0;
> +	retimer->cfg[1] = cfg1;
> +	retimer->cfg[2] = cfg2;
> +
> +	regmap_write(retimer->regmap, 0x0, cfg0);
> +	regmap_write(retimer->regmap, 0x1, cfg1);
> +	regmap_write(retimer->regmap, 0x2, cfg2);
> +
> +	return 0;
> +}

You always return 0 here so should this be a void function?

> +
> +static int ps8380_set(struct ps8830_retimer *retimer)
> +{
> +	int cfg0 = 0x00, cfg1 = 0x00, cfg2 = 0x00;

Please avoid doing multiple initialisations like this (one per line is
more readable).

> +	int ret;
> +
> +	retimer->needs_update = false;
> +
> +	switch (retimer->orientation) {
> +	/* Safe mode */
> +	case TYPEC_ORIENTATION_NONE:
> +		cfg0 = 0x01;
> +		cfg1 = 0x00;
> +		cfg2 = 0x00;
> +		break;
> +	case TYPEC_ORIENTATION_NORMAL:
> +		cfg0 = 0x01;
> +		break;
> +	case TYPEC_ORIENTATION_REVERSE:
> +		cfg0 = 0x03;
> +		break;
> +	}
> +
> +	switch (retimer->mode) {
> +	/* Safe mode */
> +	case TYPEC_STATE_SAFE:
> +		cfg0 = 0x01;
> +		cfg1 = 0x00;
> +		cfg2 = 0x00;
> +		break;
> +
> +	/* USB3 Only */
> +	case TYPEC_STATE_USB:
> +		cfg0 |= 0x20;
> +		break;
> +
> +	/* DP Only */
> +	case TYPEC_DP_STATE_C:
> +	case TYPEC_DP_STATE_E:
> +		cfg0 &= 0x0f;
> +		cfg1 = 0x85;
> +		break;
> +
> +	/* DP + USB */
> +	case TYPEC_DP_STATE_D:
> +	case TYPEC_DP_STATE_F:
> +		cfg0 |= 0x20;
> +		cfg1 = 0x85;
> +		break;
> +
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	gpiod_set_value(retimer->reset_gpio, 0);
> +	msleep(20);
> +	gpiod_set_value(retimer->reset_gpio, 1);
> +
> +	msleep(60);
> +
> +	ret = ps8830_configure(retimer, 0x01, 0x00, 0x00);
> +
> +	msleep(30);
> +
> +	return ps8830_configure(retimer, cfg0, cfg1, cfg2);

As the build bots pointed out, ret is never used, and the configure
function always returns 0. Make the function type void and return 0
explicitly here instead?

> +}

> +static int ps8830_retimer_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct typec_switch_desc sw_desc = { };
> +	struct typec_retimer_desc rtmr_desc = { };
> +	struct ps8830_retimer *retimer;
> +	int ret;
> +
> +	retimer = devm_kzalloc(dev, sizeof(*retimer), GFP_KERNEL);
> +	if (!retimer)
> +		return -ENOMEM;
> +
> +	retimer->client = client;
> +
> +	retimer->regmap = devm_regmap_init_i2c(client, &ps8830_retimer_regmap);
> +	if (IS_ERR(retimer->regmap)) {
> +		dev_err(dev, "Failed to allocate register map\n");
> +		return PTR_ERR(retimer->regmap);
> +	}
> +
> +	retimer->supplies[0].supply = "vdd33";
> +	retimer->supplies[1].supply = "vdd18";
> +	retimer->supplies[2].supply = "vdd15";

vdd115?

> +	retimer->supplies[3].supply = "vcc";
> +	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(retimer->supplies),
> +				      retimer->supplies);
> +	if (ret)
> +		return ret;
> +
> +	retimer->xo_clk = devm_clk_get(dev, "xo");
> +	if (IS_ERR(retimer->xo_clk))
> +		return PTR_ERR(retimer->xo_clk);
> +
> +	retimer->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(retimer->reset_gpio))
> +		return PTR_ERR(retimer->reset_gpio);
> +
> +	retimer->typec_switch = fwnode_typec_switch_get(dev->fwnode);
> +	if (IS_ERR(retimer->typec_switch))
> +		return dev_err_probe(dev, PTR_ERR(retimer->typec_switch),
> +				     "failed to acquire orientation-switch\n");
> +
> +	retimer->typec_mux = fwnode_typec_mux_get(dev->fwnode);
> +	if (IS_ERR(retimer->typec_mux)) {
> +		ret = dev_err_probe(dev, PTR_ERR(retimer->typec_mux),
> +				    "failed to acquire mode-mux\n");
> +		goto err_switch_put;
> +	}
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(retimer->supplies),
> +				    retimer->supplies);
> +	if (ret < 0) {
> +		dev_err(dev, "cannot enable regulators %d\n", ret);

Please add a colon after "regulators" to maintain a consistent style of
error messages. 

> +		goto err_mux_put;
> +	}
> +
> +	ret = clk_prepare_enable(retimer->xo_clk);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable XO: %d\n", ret);

Lower case "failed" for consistency.

> +		goto err_disable_vreg;
> +	}
> +
> +	gpiod_set_value(retimer->reset_gpio, 0);
> +	msleep(20);
> +	gpiod_set_value(retimer->reset_gpio, 1);
> +
> +	msleep(60);
> +	mutex_init(&retimer->lock);

I'd initialise resources like this before resetting the device (e.g.
move above regmap init).

> +
> +	sw_desc.drvdata = retimer;
> +	sw_desc.fwnode = dev_fwnode(dev);
> +	sw_desc.set = ps8830_sw_set;
> +
> +	ret = drm_aux_bridge_register(dev);
> +	if (ret)
> +		goto err_disable_gpio;
> +
> +	retimer->sw = typec_switch_register(dev, &sw_desc);
> +	if (IS_ERR(retimer->sw)) {
> +		ret = dev_err_probe(dev, PTR_ERR(retimer->sw),
> +				    "Error registering typec switch\n");

Switch registration cannot return EPROBE_DEFER so I suggest using
dev_err() for clarity (e.g. as you must not call functions that can
defer probe after registering child devices like the aux bridge).

> +		goto err_disable_gpio;
> +	}
> +
> +	rtmr_desc.drvdata = retimer;
> +	rtmr_desc.fwnode = dev_fwnode(dev);
> +	rtmr_desc.set = ps8830_retimer_set;
> +
> +	retimer->retimer = typec_retimer_register(dev, &rtmr_desc);
> +	if (IS_ERR(retimer->retimer)) {
> +		ret = dev_err_probe(dev, PTR_ERR(retimer->retimer),
> +				    "Error registering typec retimer\n");

Same here.

> +		goto err_switch_unregister;
> +	}
> +
> +	dev_info(dev, "Registered Parade PS8830 retimer\n");

Drop this, drivers shouldn't spam the logs on success.

> +	return 0;
> +
> +err_switch_unregister:
> +	typec_switch_unregister(retimer->sw);
> +
> +err_disable_gpio:
> +	gpiod_set_value(retimer->reset_gpio, 0);
> +	clk_disable_unprepare(retimer->xo_clk);
> +
> +err_disable_vreg:
> +	regulator_bulk_disable(ARRAY_SIZE(retimer->supplies),
> +			       retimer->supplies);
> +err_mux_put:
> +	typec_mux_put(retimer->typec_mux);
> +
> +err_switch_put:
> +	typec_switch_put(retimer->typec_switch);
> +
> +	return ret;
> +}

> +static const struct i2c_device_id ps8830_retimer_table[] = {
> +	{ "parade,ps8830" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, ps8830_retimer_table);

This one should not be needed, right?

> +static const struct of_device_id ps8830_retimer_of_table[] = {
> +	{ .compatible = "parade,ps8830" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ps8830_retimer_of_table);

Johan

