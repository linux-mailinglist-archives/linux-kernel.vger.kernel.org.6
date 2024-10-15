Return-Path: <linux-kernel+bounces-365410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCDD99E1EA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 11:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76D4AB2484B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C5E1DD55A;
	Tue, 15 Oct 2024 08:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="T4a7KZSi"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF891CF296
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 08:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728982766; cv=none; b=foMoIXh58l6azIqnNPiBAtaxmyRRX8gvAI0W5a1YE8Av8dqBzluwl563S0d2b5zDDmT+Va6aL/S8FdGEfoKMGE2ziHiRz9wDz1MrDaN5/TM8WURd830gv7Ae64LTUD+Mt7cXDIDID2wcVOWLBwn9eXvuwDMSVrOkQy3pe/t88Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728982766; c=relaxed/simple;
	bh=nZQjwHxFXc5TNInVFRa6M6tc5uTcI1wi+8z+B4nTl70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tamWjDhYAyTnOu0d+R8T9km2pkS4r4VKCXXX0OSXa5WjEsaM5mSTW4RJKi0a+EENm54mQYFvVxzPuEpEnM0QrdLXRSPDRSbm752VS0SyPbhp20og4Sl0XhNkKSSKB6i3nEPllrnr7Xg/wTar38Ij/JXCV0I88oud7l9k2QVpQEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=T4a7KZSi; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43056d99a5aso39823655e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728982762; x=1729587562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wfukOCI10eVa5g7vthNsGZEREJ7/VN2tRr/4XCQTZsg=;
        b=T4a7KZSi7YJ32uv2iteFlL/v9YGaACKppUdG8SVQOgZ5ZnXULY+fKaolVQgNkTQIj7
         /+4WUVVFoZazLhgw48dLCoKZ8zQBOLUeyQXs2chveLdIKHklYc1Hl9z1PtXrsrY3gCNo
         A2dLl3QDlteFwvdhiG+yogUu543C2CR/1dkoLWgTHe436zEBFJqnxkBxA0VMDrwH5bVX
         /MnenCC9GUlFa3t28w2ZyrHc18T/4BGL4kQIlf7B8Srfiuozp9rHNXXdsJaR26B/tdKg
         MsJlvzgNTPS67RpUW/ImyJpXDwwaeTxvQbqvFHqmi56QcbCzM/30PaEkDYEv5o9X8R2e
         gKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728982762; x=1729587562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wfukOCI10eVa5g7vthNsGZEREJ7/VN2tRr/4XCQTZsg=;
        b=VWldjo8Glo+hnxYamrda7EAlDPA9sjaqGt0jRoyoKjPWmE9HEZUbQLShQ3Vixh/bHL
         KYfU+MM2sDJQU8agkLmgAQMZlIq4MbUgpA9tOmaYANXzR8XkcmlnzhaNqyQwzLZOQm5L
         U9pPCJANbUZyrmY73bMmj0gLDm+RiM5UJ8n7CoEvZ7BQQeGOX9j+1sI7Q3EbbQ9wg7cx
         d7vNPFFe9X8qSjARdXZkW/dWzEk6wGjX5SnvxKNboAeub1j1OMxbcz5i2aMsE6H4NcPy
         XQgSHLf2oKrm0wMpPYl9LSQFPHceV6uiJTxcw27JOyqkwLKoHgAqYgjFaZK8uyRJtmZf
         Ilaw==
X-Forwarded-Encrypted: i=1; AJvYcCUELtwcbg4w+UsPT3j9lbzOR4QtBwiNVWaC30OZRYgh1eGaRglefO/1wA0RN4N0UhVoxED5NVX0lqRiZ9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAwWHCBf90BXp8SpTSQwuKCxsrJuYST3gqT+KQ/oDKWWPIXa4T
	5QordSE8LGqk93rVJzavJmO2rz9SWOH20LfLS+v1uncm5yYw3uEWvxjgdXSmuH4=
X-Google-Smtp-Source: AGHT+IESnyITEigHVIdYr0IHEM1d7yk95FqEmcR6fxax/khd9TklT9FNZO8tTCFSIuTTutwGCGgmSg==
X-Received: by 2002:adf:a111:0:b0:374:bcfe:e73 with SMTP id ffacd0b85a97d-37d552cdf30mr10867670f8f.28.1728982761866;
        Tue, 15 Oct 2024 01:59:21 -0700 (PDT)
Received: from dfj (host-79-50-238-21.retail.telecomitalia.it. [79.50.238.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa87c4fsm1019253f8f.31.2024.10.15.01.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 01:59:21 -0700 (PDT)
Date: Tue, 15 Oct 2024 10:57:53 +0200
From: Angelo Dureghello <adureghello@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 4/8] iio: dac: adi-axi-dac: extend features
Message-ID: <bw2ldm54tg6klzfod5t5y6eb34dr4mcttojz4uulxqm5stk2hw@rmgpibnx6xsd>
References: <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-0-eeef0c1e0e56@baylibre.com>
 <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-4-eeef0c1e0e56@baylibre.com>
 <ab559026-7e95-4adc-9978-6db30982b2a6@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab559026-7e95-4adc-9978-6db30982b2a6@baylibre.com>

On 14.10.2024 16:14, David Lechner wrote:
> On 10/14/24 5:08 AM, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> > 
> > Extend AXI-DAC backend with new features required to interface
> > to the ad3552r DAC. Mainly, a new compatible string is added to
> > support the ad3552r-axi DAC IP, very similar to the generic DAC
> > IP but with some customizations to work with the ad3552r.
> > 
> > Then, a serie of generic functions has been added to match with
> 
> spelling: series
> 
> > ad3552r needs. Function names has been kept generic as much as
> > possible, to allow re-utilization from other frontend drivers.
> > 
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > ---
> 
> ...
> 
> > +static int axi_dac_read_raw(struct iio_backend *back,
> > +			    struct iio_chan_spec const *chan,
> > +			    int *val, int *val2, long mask)
> > +{
> > +	struct axi_dac_state *st = iio_backend_get_priv(back);
> > +	int err, reg;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_FREQUENCY:
> > +
> > +		if (!st->info->has_dac_clk)
> > +			return -EOPNOTSUPP;
> > +
> > +		/*
> > +		 * As from ad3552r AXI IP documentation,
> > +		 * returning the SCLK depending on the stream mode.
> > +		 */
> > +		err = regmap_read(st->regmap, AXI_DAC_CUSTOM_CTRL_REG, &reg);
> > +		if (err)
> > +			return err;
> > +
> > +		if (reg & AXI_DAC_CUSTOM_CTRL_STREAM)
> > +			*val = st->dac_clk_rate / 2;
> > +		else
> > +			*val = st->dac_clk_rate / 8;
> 
> To get the DAC sample rate, we only care about the streaming mode
> rate, so this should just always be / 2 and not / 8. Otherwise
> the sampling_frequency attribute in the DAC driver will return
> the wrong value when the buffer is not enabled. We never do buffered
> writes without enabling streaming mode.
> 
> > +
> > +		return IIO_VAL_INT;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int axi_dac_bus_reg_write(struct iio_backend *back, u32 reg, u32 val,
> > +				 size_t data_size)
> > +{
> > +	struct axi_dac_state *st = iio_backend_get_priv(back);
> > +	int ret;
> > +	u32 ival;
> > +
> > +	if (data_size == sizeof(u16))
> > +		ival = FIELD_PREP(AXI_DAC_CUSTOM_WR_DATA_16, val);
> > +	else
> > +		ival = FIELD_PREP(AXI_DAC_CUSTOM_WR_DATA_8, val);
> > +
> > +	ret = regmap_write(st->regmap, AXI_DAC_CUSTOM_WR_REG, ival);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * Both REG_CNTRL_2 and AXI_DAC_CNTRL_DATA_WR need to know
> 
> I'm guessing these got renamed. REG_CNTRL_2 = AXI_DAC_CNTRL_2_REG
> and AXI_DAC_CNTRL_DATA_WR = AXI_DAC_CUSTOM_WR_REG?
> 
> > +	 * the data size. So keeping data size control here only,
> > +	 * since data size is mandatory for the current transfer.
> > +	 * DDR state handled separately by specific backend calls,
> > +	 * generally all raw register writes are SDR.
> > +	 */
> > +	if (data_size == sizeof(u8))
> > +		ret = regmap_set_bits(st->regmap, AXI_DAC_CNTRL_2_REG,
> > +				      AXI_DAC_CNTRL_2_SYMB_8B);
> > +	else
> > +		ret = regmap_clear_bits(st->regmap, AXI_DAC_CNTRL_2_REG,
> > +					AXI_DAC_CNTRL_2_SYMB_8B);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_update_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
> > +				 AXI_DAC_CUSTOM_CTRL_ADDRESS,
> > +				 FIELD_PREP(AXI_DAC_CUSTOM_CTRL_ADDRESS, reg));
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_update_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
> > +				 AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA,
> > +				 AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_read_poll_timeout(st->regmap,
> > +				       AXI_DAC_CUSTOM_CTRL_REG, ival,
> > +				       ival & AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA,
> > +				       10, 100 * KILO);
> > +	if (ret)
> > +		return ret;
> 
> Should we also clear AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA on timeout
> so that we don't leave things in a bad state?
>

just realized this poll is wrong and unuseful.
It's a check on a bit we just set.
Check must be done in AXI_MSK_BUSY of AXI_REG_UI_STATUS.

If it fails after 100msecs, looks like things are seriously blocked,
not sure clearing any bit would help.


> > +
> > +	return regmap_clear_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
> > +				 AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA);
> > +}
> > +
> 
> ...
> 
> >  static int axi_dac_probe(struct platform_device *pdev)
> >  {
> > -	const unsigned int *expected_ver;
> >  	struct axi_dac_state *st;
> >  	void __iomem *base;
> >  	unsigned int ver;
> > @@ -566,15 +793,26 @@ static int axi_dac_probe(struct platform_device *pdev)
> >  	if (!st)
> >  		return -ENOMEM;
> >  
> > -	expected_ver = device_get_match_data(&pdev->dev);
> > -	if (!expected_ver)
> > +	st->info = device_get_match_data(&pdev->dev);
> > +	if (!st->info)
> >  		return -ENODEV;
> >  
> > -	clk = devm_clk_get_enabled(&pdev->dev, NULL);
> > +	clk = devm_clk_get_enabled(&pdev->dev, "s_axi_aclk");
> 
> This will break existing users that don't have clock-names
> in the DT. It should be fine to leave it as NULL in which
> case it will get the clock at index 0 in the clocks array
> even if there is more than one clock.
>

mm, are there existing users except this hs driver right now ?

Clock names are actually described in the example, and if missing,
also retrieving "dac_clk" would fail.

> >  	if (IS_ERR(clk))
> >  		return dev_err_probe(&pdev->dev, PTR_ERR(clk),
> >  				     "failed to get clock\n");
> >  
> > +	if (st->info->has_dac_clk) {
> > +		struct clk *dac_clk;
> > +
> > +		dac_clk = devm_clk_get_enabled(&pdev->dev, "dac_clk");
> > +		if (IS_ERR(dac_clk))
> > +			return dev_err_probe(&pdev->dev, PTR_ERR(dac_clk),
> > +					     "failed to get dac_clk clock\n");
> > +
> > +		st->dac_clk_rate = clk_get_rate(dac_clk);
> > +	}
> > +
> >  	base = devm_platform_ioremap_resource(pdev, 0);
> >  	if (IS_ERR(base))
> >  		return PTR_ERR(base);

