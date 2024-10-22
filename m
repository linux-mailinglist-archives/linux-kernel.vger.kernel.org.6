Return-Path: <linux-kernel+bounces-375958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C38E9A9DC7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2B4A283721
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9511F194ADB;
	Tue, 22 Oct 2024 09:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M+JzADzm"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A34186E3A
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 09:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729587679; cv=none; b=AjuD4q2isDnCpMSyGPxbT2aItZusrYowBca2HSFWnGA3egZi2n9eBtH7GDBOPjOlAGMCBLdbKNnHb5SnxjWoU97GvIuTwSRvASvavlJVRCGPiY/iO79zTzWkBqxJB2Q/B2RLuVA7doxZwnooSgMMnktr3ThWT7xjtTtFrn4Z/Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729587679; c=relaxed/simple;
	bh=YHNeQy+Gb09kRog+hJNRWpW815XE2iQrmhqT0ezNi08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJY9PyDW80Z9R1yvgkSeLgAp9yO94eU+immZraXnCE2jsKUCiSBal3GgCP/s0w86HG3f5ISc4RxNVruLmUzv9k1fMJMMp6kI0+tE5Wewyx9c1qO708wvfjcGDg5KNsa9XsnPby11wl5tmsAJuFHAQ5teYy5f6DjAsYRBzu3jmSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M+JzADzm; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4316e9f4a40so27595755e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 02:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729587676; x=1730192476; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6/0uwFU7QS3ULtUk30D33huoCZ8wSxBsNaZesrFmH4Y=;
        b=M+JzADzmDy2kAnnpswLitxMSSeerj8rJ6C24+9jOc5ruTMEcEzk+H3FVTWvp218Bc+
         6hgyhenJ8FvYE6MoOtgroGRPV76BaeqU2mOA8UhcJMmIDH6YJTwvcTHG7GKdEnm3GqNT
         VodKBJX/CiU2mU5kX9ANojWdmL1OUTrKlh78H9/avyUbn+ctpru5fPjLAGNZd0Nl5K4s
         UPfbWb/MAw5VQP2kgo83KveozzOxwu43HPdp/QYQAIZjAVoMyLS9/jNgm1itfIwcarj5
         YPu7yyzgv9U1fAFlKHEGyHrf9++Bx/93sbGMZz5ZVXJYsqXaOMwChFp4O0MmxjD9L+e8
         srJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729587676; x=1730192476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/0uwFU7QS3ULtUk30D33huoCZ8wSxBsNaZesrFmH4Y=;
        b=qOgquF6XnrLJsEytNk7+LIrZ0oZ40OaSB7iLB2XLCJBvEKBoHMRJKrf01BmHaXNdDI
         Ra1hoCpINzWvSxURIOIhID6ZFDpduNNvkj5lh+zjLWUuFBjKmRk9Ovb4y9NJX3wnT1pc
         +SYzPVpNFK3+m8KBUZtdiSA9qiONF1igwLlE2BR77JwDp5QAkv7c4CGFsq3aV56aOL12
         hWlbOjSYAXmQQ3dfbzAGoJjvrBgwS1T/25i5E+VxnoTRynn8VemhvgHetXd/6ktfu2Iz
         kz81Ishkq1jfK9bzbG5ZTl3ra33Wspt2keOJDATDM9w8WZb2ypYcmWzEXSxKxmmPzpnO
         WMkg==
X-Forwarded-Encrypted: i=1; AJvYcCXt1PMbBSRG7pAdikI6AidKdIzM0TgbNyCkTod2jQ3LKUdNkx4qbDqPVEg/SRwF8egaShapKe7+55z5GnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6AMDS6eQEm/FZKIfUz9t1VM+Ty9Y4yNeY+3TOr65gs1pc8ZHh
	u7UfXXMiu9ICHC6h7G8Mt5HwM4D90+nA8EZqhELhX99ZnMs2LlB+hobflJHxH9tWOku/b98/4yY
	g
X-Google-Smtp-Source: AGHT+IG9nn8Y+opUXK/jzmtyqOYnvXx/g5R4ITP+6pKF3OzW0Yk5PYNV4zNyh5rh+oEJ4F1hZ59ooA==
X-Received: by 2002:a05:600c:1e28:b0:42c:b750:1a1e with SMTP id 5b1f17b1804b1-431615991f4mr115572795e9.0.1729587676087;
        Tue, 22 Oct 2024 02:01:16 -0700 (PDT)
Received: from linaro.org ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f570b99sm83040255e9.2.2024.10.22.02.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 02:01:15 -0700 (PDT)
Date: Tue, 22 Oct 2024 12:01:14 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Trilok Soni <quic_tsoni@quicinc.com>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] usb: typec: Add support for Parade PS8830 Type-C
 Retimer
Message-ID: <Zxdp2vHzREJAFkwj@linaro.org>
References: <20241004-x1e80100-ps8830-v2-0-5cd8008c8c40@linaro.org>
 <20241004-x1e80100-ps8830-v2-2-5cd8008c8c40@linaro.org>
 <Zw5oEyMj6cPGFDEI@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw5oEyMj6cPGFDEI@hovoldconsulting.com>

On 24-10-15 15:03:15, Johan Hovold wrote:
> On Fri, Oct 04, 2024 at 04:57:38PM +0300, Abel Vesa wrote:
> 
> > +static int ps8830_enable_vregs(struct ps8830_retimer *retimer)
> > +{
> 
> > +	return 0;
> > +
> > +err_vddat_disable:
> > +	regulator_disable(retimer->vddat_supply);
> > +
> 
> Nit: I'd drop the empty lines between the errors cases here.

Will drop.

> 
> > +err_vddar_disable:
> > +	regulator_disable(retimer->vddar_supply);
> > +
> > +err_vdd_disable:
> > +	regulator_disable(retimer->vdd_supply);
> > +
> > +err_vdd33_cap_disable:
> > +	regulator_disable(retimer->vdd33_cap_supply);
> > +
> > +err_vdd33_disable:
> > +	regulator_disable(retimer->vdd33_supply);
> > +
> > +	return ret;
> > +}
> 
> > +static int ps8830_retimer_probe(struct i2c_client *client)
> > +{
> > +	struct device *dev = &client->dev;
> > +	struct typec_switch_desc sw_desc = { };
> > +	struct typec_retimer_desc rtmr_desc = { };
> > +	struct ps8830_retimer *retimer;
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
> > +	retimer->regmap = devm_regmap_init_i2c(client, &ps8830_retimer_regmap);
> > +	if (IS_ERR(retimer->regmap)) {
> > +		dev_err(dev, "failed to allocate register map\n");
> 
> Please make sure to log the errno as well here and below.

Will add.

> 
> > +		return PTR_ERR(retimer->regmap);
> > +	}
> > +
> > +	ret = ps8830_get_vregs(retimer);
> > +	if (ret)
> > +		return ret;
> > +
> > +	retimer->xo_clk = devm_clk_get(dev, "xo");
> > +	if (IS_ERR(retimer->xo_clk))
> > +		return dev_err_probe(dev, PTR_ERR(retimer->xo_clk),
> > +				     "failed to get xo clock\n");
> > +
> > +	retimer->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> 
> The reset line is active low and should be described as such in DT. So
> here you want to request it as logically low if you want to deassert
> reset.

This is being reworked in v3 as we need to support cases where the
retimer has been left enabled and initialized by bootloader and we want
to keep that state until unplug event for the cold-plug orientation
to work properly.

On top of that, we don't want to deassert the reset here. We do that
via gpiod_set_value() call below, after the clocks and regulators have
been enabled.

> 
> Is there now timing requirements on when you deassert reset after
> enabling the supplies?

So based on my comment above, this is actually asserting the reset.
No timing requirements for that.

> 
> > +	if (IS_ERR(retimer->reset_gpio))
> > +		return dev_err_probe(dev, PTR_ERR(retimer->reset_gpio),
> > +				     "failed to get reset gpio\n");
> > +
> > +	retimer->typec_switch = fwnode_typec_switch_get(dev->fwnode);
> > +	if (IS_ERR(retimer->typec_switch)) {
> > +		dev_err(dev, "failed to acquire orientation-switch\n");
> 
> I saw the driver fail here once, but not sure what the errno was since
> it was not printed. Presumably it was a probe deferral and then this
> should be a dev_err_probe() as well:
> 
> 	ps8830_retimer 2-0008: failed to acquire orientation-switch

Will use dev_err_probe.

> 
> > +		return PTR_ERR(retimer->typec_switch);
> > +	}
> > +
> > +	retimer->typec_mux = fwnode_typec_mux_get(dev->fwnode);
> > +	if (IS_ERR(retimer->typec_mux)) {
> > +		dev_err(dev, "failed to acquire mode-mux\n");
> 
> Similar here perhaps?

Same.

> 
> > +		goto err_switch_put;
> > +	}
> > +
> > +	sw_desc.drvdata = retimer;
> > +	sw_desc.fwnode = dev_fwnode(dev);
> > +	sw_desc.set = ps8830_sw_set;
> > +
> > +	ret = drm_aux_bridge_register(dev);
> > +	if (ret)
> > +		goto err_mux_put;
> > +
> > +	retimer->sw = typec_switch_register(dev, &sw_desc);
> > +	if (IS_ERR(retimer->sw)) {
> > +		dev_err(dev, "failed to register typec switch\n");
> > +		goto err_aux_bridge_unregister;
> > +	}
> > +
> > +	rtmr_desc.drvdata = retimer;
> > +	rtmr_desc.fwnode = dev_fwnode(dev);
> > +	rtmr_desc.set = ps8830_retimer_set;
> > +
> > +	retimer->retimer = typec_retimer_register(dev, &rtmr_desc);
> > +	if (IS_ERR(retimer->retimer)) {
> > +		dev_err(dev, "failed to register typec retimer\n");
> > +		goto err_switch_unregister;
> > +	}
> > +
> > +	ret = clk_prepare_enable(retimer->xo_clk);
> > +	if (ret) {
> > +		dev_err(dev, "failed to enable XO: %d\n", ret);
> > +		goto err_retimer_unregister;
> > +	}
> 
> Should you really enable the clock before the regulators?

So maybe in this case it might not really matter. But in principle,
the HW might be affected by clock glitches and such when IP block
is powered up but unclocked. Even more so if the clock enabling
(prepare, to be more exact) involves switching to a new PLL.

So clock first, then power up. At least that's my understanding of HW
in general.

> 
> > +
> > +	ret = ps8830_enable_vregs(retimer);
> > +	if (ret)
> > +		goto err_clk_disable;
> > +
> > +	/* delay needed as per datasheet */
> > +	usleep_range(4000, 14000);
> > +
> > +	gpiod_set_value(retimer->reset_gpio, 1);
> 
> Here you only deassert reset in case the line is incorrectly described
> as active high in DT.

Yes, this needs to be 0 instead of 1. And in v3 it will depend on
a DT property called ps8830,boot-on, meaning if we want to keep it
enabled and configured as left by bootloader, by using that property
we will skip the resetting altogether.

> 
> > +	return 0;
> > +
> > +err_clk_disable:
> > +	clk_disable_unprepare(retimer->xo_clk);
> > +
> > +err_retimer_unregister:
> > +	typec_retimer_unregister(retimer->retimer);
> > +
> > +err_switch_unregister:
> > +	typec_switch_unregister(retimer->sw);
> > +
> > +err_aux_bridge_unregister:
> > +	gpiod_set_value(retimer->reset_gpio, 0);
> > +	clk_disable_unprepare(retimer->xo_clk);
> > +
> > +err_mux_put:
> > +	typec_mux_put(retimer->typec_mux);
> > +
> > +err_switch_put:
> > +	typec_switch_put(retimer->typec_switch);
> 
> Drop newlines before labels?

Will do.

> 
> > +
> > +	return ret;
> > +}
> 
> Johan

Thanks for reviewing.

Abel


