Return-Path: <linux-kernel+bounces-527714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20128A40E72
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 12:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 810411899C77
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 11:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D93A205AD5;
	Sun, 23 Feb 2025 11:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pAsaSH6Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93458202C40;
	Sun, 23 Feb 2025 11:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740311178; cv=none; b=K7C+KknOXQCqJ1Hr9H+CX5QHuW7VY8Ov9pTtuOm8uRR02ZWEn7ilD+JWEjBELEaxXoU7b/qF3W00o1jgxJ8VSJVrmk4m9Aw4+iTi4pqm2LYNG9YSROQICZQo77B162Y8gHIYvL1fuVr7vWiv8gDjNlr26uzFnzHyE5snj7OvieE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740311178; c=relaxed/simple;
	bh=nAbja8HoHc7FV9fbU4e1eHEna2Z/28F9vllkkY2dU/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLx4ZNPnzTqGIdeoMEI2wU+w7MfRga7p/XAW/PvBN58nfhZi+dy4qWROpdUGxrW5sQ3sg0pdG7hBhti/zVcDiuTAg3w8Ob7IsPXo7yR4eYw+mOiYJeFMa4ahGib9T29HalkV3ior5sZXFu0sIeXJbCsydcdmdtaWGHOoXUo+V3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pAsaSH6Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D7BC4CEDD;
	Sun, 23 Feb 2025 11:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740311177;
	bh=nAbja8HoHc7FV9fbU4e1eHEna2Z/28F9vllkkY2dU/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pAsaSH6QSZ5kjsiL36nrWTB0upJ0U5laUfp2NrZ6GqDkeUzv+AsHZawCs8c9Qivf/
	 IR0ZPO6SjDR5A10gj7URcnMP1v01ySNgw51DbWz/0GVVSuI1zlqwuB3a71QvoNvy8K
	 dFe1AM71LQsVxyZCFMFZ1jiaOJFRY5qRx4MsKU1Ny0mus/1RwoklIYAuJR9YpAlmBA
	 sVSiMpToKrB0CBGlhtTIMvkupjiqWL8jBP6FWsFvFgYJxzTBN7X1CuXSSrPxOTmusc
	 ftCOjoDaEqNi5gscgQ9slQcR0dLOeESCu2WDSIo5D1WmXqIm4gnG5Dcx/V84GGb40n
	 cKBFAuFr7vjLw==
Date: Sun, 23 Feb 2025 12:46:14 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: wangweidong.a@awinic.com
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, perex@perex.cz, tiwai@suse.com, 
	rf@opensource.cirrus.com, jack.yu@realtek.com, ivprusov@salutedevices.com, 
	zhoubinbin@loongson.cn, quic_pkumpatl@quicinc.com, paulha@opensource.cirrus.com, 
	nuno.sa@analog.com, linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yijiangtao@awinic.com
Subject: Re: [PATCH V1 2/2] ASoC: codecs: Add aw88166 amplifier driver
Message-ID: <20250223-vigilant-cooperative-snake-2d810b@krzk-bin>
References: <20250221102623.369435-1-wangweidong.a@awinic.com>
 <20250221102623.369435-3-wangweidong.a@awinic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250221102623.369435-3-wangweidong.a@awinic.com>

On Fri, Feb 21, 2025 at 06:26:23PM +0800, wangweidong.a@awinic.com wrote:
> +
> +static void aw88166_hw_reset(struct aw88166 *aw88166)
> +{
> +	if (aw88166->reset_gpio) {
> +		gpiod_set_value_cansleep(aw88166->reset_gpio, 1);
> +		usleep_range(AW88166_1000_US, AW88166_1000_US + 10);
> +		gpiod_set_value_cansleep(aw88166->reset_gpio, 0);
> +		usleep_range(AW88166_1000_US, AW88166_1000_US + 10);
> +		gpiod_set_value_cansleep(aw88166->reset_gpio, 1);

Why do you keep reset as active after reset? How is it suppose to work?

> +		usleep_range(AW88166_1000_US, AW88166_1000_US + 10);
> +	}
> +}
> +
> +static void aw88166_parse_channel_dt(struct aw88166 *aw88166)
> +{
> +	struct aw_device *aw_dev = aw88166->aw_pa;
> +	struct device_node *np = aw_dev->dev->of_node;
> +	u32 channel_value;
> +
> +	of_property_read_u32(np, "awinic,audio-channel", &channel_value);
> +	aw_dev->channel = channel_value;
> +	aw88166->phase_sync = of_property_read_bool(np, "awinic,sync-flag");
> +}
> +
> +static int aw88166_init(struct aw88166 *aw88166, struct i2c_client *i2c, struct regmap *regmap)
> +{
> +	struct aw_device *aw_dev;
> +	unsigned int chip_id;
> +	int ret;
> +
> +	ret = regmap_read(regmap, AW88166_ID_REG, &chip_id);
> +	if (ret) {
> +		dev_err(&i2c->dev, "%s read chipid error. ret = %d\n", __func__, ret);
> +		return ret;
> +	}
> +
> +	aw_dev = devm_kzalloc(&i2c->dev, sizeof(*aw_dev), GFP_KERNEL);
> +	if (!aw_dev)
> +		return -ENOMEM;
> +	aw88166->aw_pa = aw_dev;
> +
> +	aw_dev->i2c = i2c;
> +	aw_dev->dev = &i2c->dev;
> +	aw_dev->regmap = regmap;
> +	mutex_init(&aw_dev->dsp_lock);
> +
> +	aw_dev->chip_id = chip_id;
> +	aw_dev->acf = NULL;
> +	aw_dev->prof_info.prof_desc = NULL;
> +	aw_dev->prof_info.count = 0;
> +	aw_dev->prof_info.prof_type = AW88395_DEV_NONE_TYPE_ID;
> +	aw_dev->channel = AW88166_DEV_DEFAULT_CH;
> +	aw_dev->fw_status = AW88166_DEV_FW_FAILED;
> +
> +	aw_dev->fade_step = AW88166_VOLUME_STEP_DB;
> +	aw_dev->volume_desc.ctl_volume = AW88166_VOL_DEFAULT_VALUE;
> +
> +	aw88166_parse_channel_dt(aw88166);
> +
> +	return 0;
> +}
> +
> +static int aw88166_i2c_probe(struct i2c_client *i2c)
> +{
> +	struct aw88166 *aw88166;
> +	int ret;
> +
> +	if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_I2C))
> +		return dev_err_probe(&i2c->dev, -ENXIO, "check_functionality failed\n");
> +
> +	aw88166 = devm_kzalloc(&i2c->dev, sizeof(*aw88166), GFP_KERNEL);
> +	if (!aw88166)
> +		return -ENOMEM;
> +
> +	mutex_init(&aw88166->lock);
> +
> +	i2c_set_clientdata(i2c, aw88166);
> +
> +	aw88166->reset_gpio = devm_gpiod_get_optional(&i2c->dev, "reset", GPIOD_OUT_LOW);


So here reset is low...

> +	if (IS_ERR(aw88166->reset_gpio))
> +		return dev_err_probe(&i2c->dev, PTR_ERR(aw88166->reset_gpio),
> +							"reset gpio not defined\n");
> +	aw88166_hw_reset(aw88166);

and here is high afterwards?

Best regards,
Krzysztof


