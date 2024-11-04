Return-Path: <linux-kernel+bounces-394567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F599BB13D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16FBB281E17
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 10:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD871B0F39;
	Mon,  4 Nov 2024 10:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DgkOIerc"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615F71B0F26
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 10:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730716609; cv=none; b=TUNXKUtuMxkqLKDpujDvgOa1NWlgXq+VOki/nmP4C+DvV3MPq52usG/sV5svN5AV69aZn835r6IB0arQrrBux64QG7w8Rj53I1qBoYDgxTwedV/S80TSW3IHgICxVteVjDZzLUYAhKi3vTWtDqEgYV0J95rY8w//MQnl9YvDW6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730716609; c=relaxed/simple;
	bh=Wj5gggdeYzEjCnVBew0g5YpKNUekAOZRaPwsxwSFdmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YuUUgjoLgOzXpPTgxbijfIgD7HnMb0OpmFkzvsGG9BSbudfXznJx7MTr5STjm+6OerBQjda1NZGRn2ZddxaVOVWT/I449WNDvzcduvCg1KON2ct8jUSgcXtMiDz/BApZZByJGaJA5cqTNQuS6HipgX0vcGdrOUKLiHfilcYIiLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DgkOIerc; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539f72c8fc1so2972096e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 02:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730716605; x=1731321405; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TKlFXeIC34rVSQnExMnhDgBmpwuC5ST5KfwyRCd5E7A=;
        b=DgkOIercczbEyNU3b9sk7qYriTciAmumb5QUskOhs87bro3WqFHFHoWA4zl4d0WvOq
         5RhMIniMmmCZL5TvhVhiiIt7Ooy2UeHxl1gXzKrnGAY9453xy1h1EhmrqFpPK57+Y+WB
         Ka1e7JMy+NaeYqTq5wtbnMtiAURK4pzCm8m3QxrTjqlViHqJOyxFS2ohJzYe8w40PYbB
         wCMK9v0+AyW7RcyJRghnjG1Q0cjynxHSJGudj2+sJLgk/vUp3VbhS9DEF2yPYFmDhEMe
         ie2qBCsHykhZMPqhiDAn2eZXotmdZldpaExcx6esVbfL3syecE/0QbjlRbPt2qCjTjX2
         ed3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730716606; x=1731321406;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TKlFXeIC34rVSQnExMnhDgBmpwuC5ST5KfwyRCd5E7A=;
        b=UK6/3GEmnfok5bhVKk8qsCkpxBdVKF7E0/UBfGzgwyP8tA7j05XBUKG+vlzt21/0TJ
         xN5l5Z1JUC/AitBMGAp2+hNVYEF7HMxYBJttVsOazxneE0GQa+4PMSMp5/6EqbiO8zma
         FWz+/Z+mi0ZbzuT/8ejXUnKa7XBUz8/8R1r0DFPrjiM/ZnNVKb34nipOVCg/14tKoU3j
         8TzHz4wZg7dcs04cpxeg4Z27fsRV426Q4KbzBV1bOvlTBpTIVsjPNbUrm2Uxz29qK9v1
         DSGlkLWFsabwo7aeo9EvxOKiKgCPqaC2Q1QnAC+Ix4ROcd8cme/jY/zDDTwqx05kZrcY
         tmQA==
X-Forwarded-Encrypted: i=1; AJvYcCXJ53y1hHPQTT8smkV6fHvnjiSNNjzWbcZAiEA9fKhL/6l1McH8JxFg2aCwBqY/4qMK69PW/UW+exP70hs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPyX1xIk03kO6pMsbjdoNHo4J00yhGZ/8SHwAmY5hjuC1XRmxd
	zVS6rwZJ4kMsra7+0cetXSSBey9GO5cFc+ct4HbNyXQhivlIKVf+Y95xkQhgSC0=
X-Google-Smtp-Source: AGHT+IHUiKfaL/2V3aBfXeKUEynKB4rZn4hrd3BIHYTrk9/0aa1Y5FhiZEZ8bsRWuRbEEfuaJaHSgg==
X-Received: by 2002:a05:6512:158e:b0:539:e6fc:4172 with SMTP id 2adb3069b0e04-53b7ece1702mr10001911e87.21.1730716605475;
        Mon, 04 Nov 2024 02:36:45 -0800 (PST)
Received: from linaro.org ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd8e7d31sm179750665e9.9.2024.11.04.02.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 02:36:45 -0800 (PST)
Date: Mon, 4 Nov 2024 12:36:43 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-arm-msm@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Johan Hovold <johan@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Trilok Soni <quic_tsoni@quicinc.com>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 2/4] usb: typec: Add support for Parade PS8830 Type-C
 Retimer
Message-ID: <Zyiju749PMFIL4aa@linaro.org>
References: <20241101-x1e80100-ps8830-v4-0-f0f7518b263e@linaro.org>
 <20241101-x1e80100-ps8830-v4-2-f0f7518b263e@linaro.org>
 <90ff31e5-3bed-40d2-8476-1ebb772c03f3@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90ff31e5-3bed-40d2-8476-1ebb772c03f3@wanadoo.fr>

On 24-11-01 17:56:04, Christophe JAILLET wrote:
> Le 01/11/2024 à 17:29, Abel Vesa a écrit :
> > The Parade PS8830 is a USB4, DisplayPort and Thunderbolt 4 retimer,
> > controlled over I2C. It usually sits between a USB/DisplayPort PHY
> > and the Type-C connector, and provides orientation and altmode handling.
> > 
> > The boards that use this retimer are the ones featuring the Qualcomm
> > Snapdragon X Elite SoCs.
> > 
> > Add a driver with support for the following modes:
> >   - DisplayPort 4-lanes
> >   - DisplayPort 2-lanes + USB3
> >   - USB3
> > 
> > There is another variant of this retimer which is called PS8833. It seems
> > to be really similar to the PS8830, so future-proof this driver by
> > naming it ps883x.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > ---
> 
> Hi,
> 
> ...
> 
> > +static void ps883x_disable_vregs(struct ps883x_retimer *retimer)
> > +{
> > +	regulator_disable(retimer->vddio_supply);
> > +	regulator_disable(retimer->vddat_supply);
> > +	regulator_disable(retimer->vddar_supply);
> > +	regulator_disable(retimer->vdd_supply);
> > +	regulator_disable(retimer->vdd33_cap_supply);
> > +	regulator_disable(retimer->vdd33_supply);
> > +}
> > +
> > +static int ps883x_get_vregs(struct ps883x_retimer *retimer)
> 
> This could maybe be replaced by a
> devm_regulator_bulk_get() call?
> (and use the bulk API in other places)

Nope, look in the ps883x_enable_vregs. There are some delays needed between
enabling them, according to spec.

> 
> > +{
> > +	struct device *dev = &retimer->client->dev;
> > +
> > +	retimer->vdd_supply = devm_regulator_get(dev, "vdd");
> > +	if (IS_ERR(retimer->vdd_supply))
> > +		return dev_err_probe(dev, PTR_ERR(retimer->vdd_supply),
> > +				     "failed to get VDD\n");
> > +
> > +	retimer->vdd33_supply = devm_regulator_get(dev, "vdd33");
> > +	if (IS_ERR(retimer->vdd33_supply))
> > +		return dev_err_probe(dev, PTR_ERR(retimer->vdd33_supply),
> > +				     "failed to get VDD 3.3V\n");
> > +
> > +	retimer->vdd33_cap_supply = devm_regulator_get(dev, "vdd33-cap");
> > +	if (IS_ERR(retimer->vdd33_cap_supply))
> > +		return dev_err_probe(dev, PTR_ERR(retimer->vdd33_cap_supply),
> > +				     "failed to get VDD CAP 3.3V\n");
> > +
> > +	retimer->vddat_supply = devm_regulator_get(dev, "vddat");
> > +	if (IS_ERR(retimer->vddat_supply))
> > +		return dev_err_probe(dev, PTR_ERR(retimer->vddat_supply),
> > +				     "failed to get VDD AT\n");
> > +
> > +	retimer->vddar_supply = devm_regulator_get(dev, "vddar");
> > +	if (IS_ERR(retimer->vddar_supply))
> > +		return dev_err_probe(dev, PTR_ERR(retimer->vddar_supply),
> > +				     "failed to get VDD AR\n");
> > +
> > +	retimer->vddio_supply = devm_regulator_get(dev, "vddio");
> > +	if (IS_ERR(retimer->vddio_supply))
> > +		return dev_err_probe(dev, PTR_ERR(retimer->vddio_supply),
> > +				     "failed to get VDD IO\n");
> > +
> > +	return 0;
> > +}
> 
> ...
> 
> > +static int ps883x_retimer_probe(struct i2c_client *client)
> > +{
> > +	struct device *dev = &client->dev;
> > +	struct typec_switch_desc sw_desc = { };
> > +	struct typec_retimer_desc rtmr_desc = { };
> > +	struct ps883x_retimer *retimer;
> > +	int ret;
> > +
> > +	retimer = devm_kzalloc(dev, sizeof(*retimer), GFP_KERNEL);
> > +	if (!retimer)
> > +		return -ENOMEM;
> > +
> > +	retimer->client = client;
> > +
> > +	mutex_init(&retimer->lock);
> > +
> > +	retimer->regmap = devm_regmap_init_i2c(client, &ps883x_retimer_regmap);
> > +	if (IS_ERR(retimer->regmap)) {
> > +		ret = PTR_ERR(retimer->regmap);
> > +		dev_err(dev, "failed to allocate register map: %d\n", ret);
> 
> Maybe dev_err_probe() as below?

Sure, even though this one here doesn't return EPROBE_DEFER.

But will help with stringifying the error code nonetheless.

So will do that in the next version.

> 
> > +		return ret;
> > +	}
> > +
> > +	ret = ps883x_get_vregs(retimer);
> > +	if (ret)
> > +		return ret;
> > +
> > +	retimer->xo_clk = devm_clk_get(dev, NULL);
> > +	if (IS_ERR(retimer->xo_clk))
> > +		return dev_err_probe(dev, PTR_ERR(retimer->xo_clk),
> > +				     "failed to get xo clock\n");
> > +
> > +	retimer->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_ASIS);
> > +	if (IS_ERR(retimer->reset_gpio))
> > +		return dev_err_probe(dev, PTR_ERR(retimer->reset_gpio),
> > +				     "failed to get reset gpio\n");
> > +
> > +	retimer->typec_switch = typec_switch_get(dev);
> > +	if (IS_ERR(retimer->typec_switch))
> > +		return dev_err_probe(dev, PTR_ERR(retimer->typec_switch),
> > +				     "failed to acquire orientation-switch\n");
> > +
> > +	retimer->typec_mux = typec_mux_get(dev);
> > +	if (IS_ERR(retimer->typec_mux)) {
> > +		ret = dev_err_probe(dev, PTR_ERR(retimer->typec_mux),
> > +				    "failed to acquire mode-mux\n");
> > +		goto err_switch_put;
> > +	}
> > +
> > +	ret = drm_aux_bridge_register(dev);
> > +	if (ret)
> > +		goto err_mux_put;
> > +
> > +	ret = clk_prepare_enable(retimer->xo_clk);
> > +	if (ret) {
> > +		dev_err(dev, "failed to enable XO: %d\n", ret);
> > +		goto err_mux_put;
> > +	}
> > +
> > +	ret = ps883x_enable_vregs(retimer);
> > +	if (ret)
> > +		goto err_clk_disable;
> > +
> > +	sw_desc.drvdata = retimer;
> > +	sw_desc.fwnode = dev_fwnode(dev);
> > +	sw_desc.set = ps883x_sw_set;
> > +
> > +	retimer->sw = typec_switch_register(dev, &sw_desc);
> > +	if (IS_ERR(retimer->sw)) {
> > +		ret = PTR_ERR(retimer->sw);
> > +		dev_err(dev, "failed to register typec switch: %d\n", ret);
> 
> Maybe dev_err_probe() as above?

Yep.

> 
> > +		goto err_vregs_disable;
> > +	}
> > +
> > +	rtmr_desc.drvdata = retimer;
> > +	rtmr_desc.fwnode = dev_fwnode(dev);
> > +	rtmr_desc.set = ps883x_retimer_set;
> > +
> > +	retimer->retimer = typec_retimer_register(dev, &rtmr_desc);
> > +	if (IS_ERR(retimer->retimer)) {
> > +		ret = PTR_ERR(retimer->retimer);
> > +		dev_err(dev, "failed to register typec retimer: %d\n", ret);
> 
> Maybe dev_err_probe() as above?

Yep.

> 
> > +		goto err_switch_unregister;
> > +	}
> > +
> > +	/* skip resetting if already configured */
> > +	if (regmap_test_bits(retimer->regmap, 0x00, BIT(0)))
> > +		return 0;
> > +
> > +	gpiod_direction_output(retimer->reset_gpio, 1);
> > +
> > +	/* VDD IO supply enable to reset release delay */
> > +	usleep_range(4000, 14000);
> > +
> > +	gpiod_set_value(retimer->reset_gpio, 0);
> > +
> > +	/* firmware initialization delay */
> > +	msleep(60);
> > +
> > +	return 0;
> > +
> > +err_switch_unregister:
> > +	typec_switch_unregister(retimer->sw);
> > +err_vregs_disable:
> > +	ps883x_disable_vregs(retimer);
> > +err_clk_disable:
> > +	clk_disable_unprepare(retimer->xo_clk);
> > +err_mux_put:
> > +	typec_mux_put(retimer->typec_mux);
> > +err_switch_put:
> > +	typec_switch_put(retimer->typec_switch);
> > +
> > +	return ret;
> > +}
> > +
> > +static void ps883x_retimer_remove(struct i2c_client *client)
> > +{
> > +	struct ps883x_retimer *retimer = i2c_get_clientdata(client);
> > +
> > +	typec_retimer_unregister(retimer->retimer);
> > +	typec_switch_unregister(retimer->sw);
> > +
> > +	gpiod_set_value(retimer->reset_gpio, 1);
> > +
> > +	regulator_disable(retimer->vddio_supply);
> > +	regulator_disable(retimer->vddat_supply);
> > +	regulator_disable(retimer->vddar_supply);
> > +	regulator_disable(retimer->vdd_supply);
> > +	regulator_disable(retimer->vdd33_cap_supply);
> > +	regulator_disable(retimer->vdd33_supply);
> 
> ps883x_disable_vregs()?

Makes sense. Will do

> 
> > +
> > +	clk_disable_unprepare(retimer->xo_clk);
> > +
> > +	typec_mux_put(retimer->typec_mux);
> > +	typec_switch_put(retimer->typec_switch);
> > +}
> 
> ...
> 
> CJ

Thanks for reviewing.

Abel

