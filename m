Return-Path: <linux-kernel+bounces-394563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2217D9BB133
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FE99B20E97
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 10:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E403C1B218D;
	Mon,  4 Nov 2024 10:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EowmVmWd"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B641B0F3F
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 10:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730716449; cv=none; b=uuz9UwU2Q78ddL28iR1BOCF44BgONp3+KlN2Ix7hlZgUeKb1sNL1Xzf2cKNR7K8Z9vewZ/Z3tgneWR/RMOwVofOgddIzxf/WyAtva78bAogobIO8J6X75y9Ma/sIRLqJWB1i6EhNNU/qxYu4eqiE5F0ZQZCQU4Hxi8oiAWDGvxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730716449; c=relaxed/simple;
	bh=ds7VaLV3CLZCOlxw1/dW8bJgf4WdFZ5SQff89MnWOjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfOfiSdfPvDJ8aavFHgetu6a4RogqqxyVlR4WBhEbb6kECKGJ53AmT2CmvR1WleIiWmaFySU0OGTux62rdmW1/oC7iO8ST714xVh+1Ek9o21IcLvi7PXLeIAjHh97PVkT4h6JitF0y5Ha1rR+iJLHK6oJfFId8M3Wgp2fwNqQbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EowmVmWd; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d4821e6b4so2451432f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 02:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730716445; x=1731321245; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LdBQL0+iSYtrAl5XR5Wfl7qDSVbeEuoT364HYKrX1Lo=;
        b=EowmVmWdOH3r4VWDbxzf1PIBmI90z70S11vVfh/14UF3/ALzNhkslKpvkQb6boMLPh
         KANMqRh+3aTEUh6tGmhPows7iP3G7saXLIJkTQGtAq9TACUXIrIKL+QVGKixEzucRxd6
         hqgkZ1MhEtvZQJUfvsFP/7Y9IBoL6ZkrThVrilb6JRMDBBiUrqCENRech78u/kcPi4x3
         U8uQbHgcuvNY41wGZ7Fn2MEwss44Np/mi8Ig76W2yIeknrpwnrPYiiOavdQUc801yDi8
         FLtK1nja8Iptb5L8gg3WcW/eXZljD6bcFn9Ea9KeXRl8WyiAI0tzYJbkIT/4dn8Y9zkI
         NzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730716445; x=1731321245;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LdBQL0+iSYtrAl5XR5Wfl7qDSVbeEuoT364HYKrX1Lo=;
        b=Kbvihl2YExmVRHTUgemRTjnHxlftNSjYiydHItuU3Rlyzp5lAm6AOm6XpnFKwTPqxd
         vVxx08o59Zb2HUO/FTw8/FECoJnhgNCT/o1dYqSw2YqT5y/sPXwvEmkdYwEWU9nTyFJb
         RDIFNArhvS7wHCswxE/cd+rwGo7ZqehQmqI7VC34WeHierRcn4B+zBkY79Sd7u1uj0Au
         vRZeHG95+UOdf1cMW8kMHRlYRi5+juazzZ65/MSZjOMonCN1nWqAXYS5sGRpr/qMI3fr
         PLWhHOuCnCNYzR/D6b0RZrfKIF0lzQgOn73ddkqxBmQKagF/wzuRN6gUp/oFjOmXUbA8
         lgBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2oY8NNb3Fbv5UX/ayQSGm+e3Dx1KNx++ABc7dqbLPQ/7aTAK5IEqTAA3TVVmPgA2us6jq+QMJ5Oxwibg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBFz+wAxsJFRX8t8hyq6HVRry2xFRzzYwvOfMqxESUp8gNcOl3
	sUCqSs/kvzmyzyOhaJzlXluxn9DRwfeoiGwqbFj5VBktbV8xuM3UqQG18oRNGis=
X-Google-Smtp-Source: AGHT+IEK9tiSaY4RconKrWdvz2GbFXC+yQ8DXTi0bk2m3Zq2OMyXLJFrFD2Li7cJZ4WlD95pGsAKbQ==
X-Received: by 2002:a5d:6083:0:b0:37d:2db5:b50c with SMTP id ffacd0b85a97d-380610f2d67mr20536901f8f.8.1730716444621;
        Mon, 04 Nov 2024 02:34:04 -0800 (PST)
Received: from dfj (host-95-245-34-85.retail.telecomitalia.it. [95.245.34.85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d4bc8sm12865130f8f.39.2024.11.04.02.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 02:34:03 -0800 (PST)
Date: Mon, 4 Nov 2024 11:32:45 +0100
From: Angelo Dureghello <adureghello@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>, 
	Angelo Dureghello <angelo@kernel-space.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dlechner@baylibre.com, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v9 4/8] iio: dac: adi-axi-dac: extend features
Message-ID: <npdnblj3cygmb5oxulebnifnqk5y6hgeldfykvzcdz6peoq6wx@vd4dnl744ktq>
References: <20241028-wip-bl-ad3552r-axi-v0-iio-testing-v9-0-f6960b4f9719@kernel-space.org>
 <20241028-wip-bl-ad3552r-axi-v0-iio-testing-v9-4-f6960b4f9719@kernel-space.org>
 <51afb385d291d27ea4e5d8b1f5f3389573b119d5.camel@gmail.com>
 <20241029211737.6486e0d6@jic23-huawei>
 <2e343f2da60b8ad4da9f24d0d42a961abf2dc30f.camel@gmail.com>
 <20241031212209.3d94c18c@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241031212209.3d94c18c@jic23-huawei>

On 31.10.2024 21:22, Jonathan Cameron wrote:
> On Thu, 31 Oct 2024 07:35:41 +0100
> Nuno Sá <noname.nuno@gmail.com> wrote:
> 
> > On Tue, 2024-10-29 at 21:17 +0000, Jonathan Cameron wrote:
> > > On Tue, 29 Oct 2024 09:13:42 +0100
> > > Nuno Sá <noname.nuno@gmail.com> wrote:
> > >   
> > > > On Mon, 2024-10-28 at 22:45 +0100, Angelo Dureghello wrote:  
> > > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > > > 
> > > > > Extend AXI-DAC backend with new features required to interface
> > > > > to the ad3552r DAC. Mainly, a new compatible string is added to
> > > > > support the ad3552r-axi DAC IP, very similar to the generic DAC
> > > > > IP but with some customizations to work with the ad3552r.
> > > > > 
> > > > > Then, a series of generic functions has been added to match with
> > > > > ad3552r needs. Function names has been kept generic as much as
> > > > > possible, to allow re-utilization from other frontend drivers.
> > > > > 
> > > > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > > > ---    
> > > > 
> > > > Hi Angelo,
> > > > 
> > > > Small stuff that Jonathan might be able to change while applying... With that:
> > > > 
> > > > Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> > > >   
> > > > >  drivers/iio/dac/adi-axi-dac.c | 256 +++++++++++++++++++++++++++++++++++++++--
> > > > > -
> > > > >  1 file changed, 242 insertions(+), 14 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
> > > > > index 04193a98616e..155d04ca2315 100644
> > > > > --- a/drivers/iio/dac/adi-axi-dac.c
> > > > > +++ b/drivers/iio/dac/adi-axi-dac.c
> > > > > @@ -46,9 +46,28 @@
> > > > >  #define AXI_DAC_CNTRL_1_REG			0x0044
> > > > >  #define   AXI_DAC_CNTRL_1_SYNC			BIT(0)
> > > > >  #define AXI_DAC_CNTRL_2_REG			0x0048
> > > > > +#define   AXI_DAC_CNTRL_2_SDR_DDR_N		BIT(16)
> > > > > +#define   AXI_DAC_CNTRL_2_SYMB_8B		BIT(14)
> > > > >  #define   ADI_DAC_CNTRL_2_R1_MODE		BIT(5)
> > > > > +#define   AXI_DAC_CNTRL_2_UNSIGNED_DATA		BIT(4)
> > > > > +#define AXI_DAC_STATUS_1_REG			0x0054
> > > > > +#define AXI_DAC_STATUS_2_REG			0x0058
> > > > >  #define AXI_DAC_DRP_STATUS_REG			0x0074
> > > > >  #define   AXI_DAC_DRP_STATUS_DRP_LOCKED		BIT(17)
> > > > > +#define AXI_DAC_CUSTOM_RD_REG			0x0080
> > > > > +#define AXI_DAC_CUSTOM_WR_REG			0x0084
> > > > > +#define   AXI_DAC_CUSTOM_WR_DATA_8		GENMASK(23, 16)
> > > > > +#define   AXI_DAC_CUSTOM_WR_DATA_16		GENMASK(23, 8)
> > > > > +#define AXI_DAC_UI_STATUS_REG			0x0088
> > > > > +#define   AXI_DAC_UI_STATUS_IF_BUSY		BIT(4)
> > > > > +#define AXI_DAC_CUSTOM_CTRL_REG			0x008C
> > > > > +#define   AXI_DAC_CUSTOM_CTRL_ADDRESS		GENMASK(31, 24)
> > > > > +#define   AXI_DAC_CUSTOM_CTRL_SYNCED_TRANSFER	BIT(2)
> > > > > +#define   AXI_DAC_CUSTOM_CTRL_STREAM		BIT(1)
> > > > > +#define   AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA	BIT(0)
> > > > > +
> > > > > +#define
> > > > > AXI_DAC_CUSTOM_CTRL_STREAM_ENABLE	(AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA | \
> > > > > +						 AXI_DAC_CUSTOM_CTRL_STREAM)
> > > > >  
> > > > >  /* DAC Channel controls */
> > > > >  #define AXI_DAC_CHAN_CNTRL_1_REG(c)		(0x0400 + (c) * 0x40)
> > > > > @@ -63,12 +82,21 @@
> > > > >  #define AXI_DAC_CHAN_CNTRL_7_REG(c)		(0x0418 + (c) * 0x40)
> > > > >  #define   AXI_DAC_CHAN_CNTRL_7_DATA_SEL		GENMASK(3, 0)
> > > > >  
> > > > > +#define AXI_DAC_RD_ADDR(x)			(BIT(7) | (x))
> > > > > +
> > > > >  /* 360 degrees in rad */
> > > > >  #define AXI_DAC_2_PI_MEGA			6283190
> > > > >  
> > > > >  enum {
> > > > >  	AXI_DAC_DATA_INTERNAL_TONE,
> > > > >  	AXI_DAC_DATA_DMA = 2,
> > > > > +	AXI_DAC_DATA_INTERNAL_RAMP_16BIT = 11,
> > > > > +};
> > > > > +
> > > > > +struct axi_dac_info {
> > > > > +	unsigned int version;
> > > > > +	const struct iio_backend_info *backend_info;
> > > > > +	bool has_dac_clk;
> > > > >  };
> > > > >  
> > > > >  struct axi_dac_state {
> > > > > @@ -79,9 +107,11 @@ struct axi_dac_state {
> > > > >  	 * data/variables.
> > > > >  	 */
> > > > >  	struct mutex lock;
> > > > > +	const struct axi_dac_info *info;
> > > > >  	u64 dac_clk;
> > > > >  	u32 reg_config;
> > > > >  	bool int_tone;
> > > > > +	int dac_clk_rate;
> > > > >  };
> > > > >  
> > > > >  static int axi_dac_enable(struct iio_backend *back)
> > > > > @@ -471,6 +501,11 @@ static int axi_dac_data_source_set(struct iio_backend
> > > > > *back, unsigned int chan,
> > > > >  					  AXI_DAC_CHAN_CNTRL_7_REG(chan),
> > > > >  					  AXI_DAC_CHAN_CNTRL_7_DATA_SEL,
> > > > >  					  AXI_DAC_DATA_DMA);
> > > > > +	case IIO_BACKEND_INTERNAL_RAMP_16BIT:
> > > > > +		return regmap_update_bits(st->regmap,
> > > > > +					  AXI_DAC_CHAN_CNTRL_7_REG(chan),
> > > > > +					  AXI_DAC_CHAN_CNTRL_7_DATA_SEL,
> > > > > +					  AXI_DAC_DATA_INTERNAL_RAMP_16BIT);
> > > > >  	default:
> > > > >  		return -EINVAL;
> > > > >  	}
> > > > > @@ -528,6 +563,154 @@ static int axi_dac_reg_access(struct iio_backend *back,
> > > > > unsigned int reg,
> > > > >  	return regmap_write(st->regmap, reg, writeval);
> > > > >  }
> > > > >  
> > > > > +static int axi_dac_ddr_enable(struct iio_backend *back)
> > > > > +{
> > > > > +	struct axi_dac_state *st = iio_backend_get_priv(back);
> > > > > +
> > > > > +	return regmap_clear_bits(st->regmap, AXI_DAC_CNTRL_2_REG,
> > > > > +				 AXI_DAC_CNTRL_2_SDR_DDR_N);
> > > > > +}
> > > > > +
> > > > > +static int axi_dac_ddr_disable(struct iio_backend *back)
> > > > > +{
> > > > > +	struct axi_dac_state *st = iio_backend_get_priv(back);
> > > > > +
> > > > > +	return regmap_set_bits(st->regmap, AXI_DAC_CNTRL_2_REG,
> > > > > +			       AXI_DAC_CNTRL_2_SDR_DDR_N);
> > > > > +}
> > > > > +
> > > > > +static int axi_dac_data_stream_enable(struct iio_backend *back)
> > > > > +{
> > > > > +	struct axi_dac_state *st = iio_backend_get_priv(back);
> > > > > +
> > > > > +	return regmap_set_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
> > > > > +			       AXI_DAC_CUSTOM_CTRL_STREAM_ENABLE);
> > > > > +}
> > > > > +
> > > > > +static int axi_dac_data_stream_disable(struct iio_backend *back)
> > > > > +{
> > > > > +	struct axi_dac_state *st = iio_backend_get_priv(back);
> > > > > +
> > > > > +	return regmap_clear_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
> > > > > +				 AXI_DAC_CUSTOM_CTRL_STREAM_ENABLE);
> > > > > +}
> > > > > +
> > > > > +static int axi_dac_data_transfer_addr(struct iio_backend *back, u32 address)
> > > > > +{
> > > > > +	struct axi_dac_state *st = iio_backend_get_priv(back);
> > > > > +
> > > > > +	if (address > FIELD_MAX(AXI_DAC_CUSTOM_CTRL_ADDRESS))
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	/*
> > > > > +	 * Sample register address, when the DAC is configured, or stream
> > > > > +	 * start address when the FSM is in stream state.
> > > > > +	 */
> > > > > +	return regmap_update_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
> > > > > +				  AXI_DAC_CUSTOM_CTRL_ADDRESS,
> > > > > +				  FIELD_PREP(AXI_DAC_CUSTOM_CTRL_ADDRESS,
> > > > > +				  address));
> > > > > +}
> > > > > +
> > > > > +static int axi_dac_data_format_set(struct iio_backend *back, unsigned int ch,
> > > > > +				   const struct iio_backend_data_fmt *data)
> > > > > +{
> > > > > +	struct axi_dac_state *st = iio_backend_get_priv(back);
> > > > > +
> > > > > +	switch (data->type) {
> > > > > +	case IIO_BACKEND_DATA_UNSIGNED:
> > > > > +		return regmap_clear_bits(st->regmap, AXI_DAC_CNTRL_2_REG,
> > > > > +					 AXI_DAC_CNTRL_2_UNSIGNED_DATA);
> > > > > +	default:
> > > > > +		return -EINVAL;
> > > > > +	}
> > > > > +}
> > > > > +
> > > > > +static int axi_dac_bus_reg_write_locked(struct iio_backend *back, u32 reg,
> > > > > +					u32 val, size_t data_size)    
> > > > 
> > > > nit: this is actually unlocked and needs to be locked from the outside. So,
> > > > unlocked could be a better suffix. But more importantly is the extra call to
> > > > iio_backend_get_priv(). We can just pass *st directly from the outer function.  
> > > 
> > > This naming always gets confusing. Are we naming the state, or what happens?
> > > 
> > > A lockdep marking just inside the function can be used to make it obvious
> > > or the old __ prefix to say 'special, check the rules'.
> > >   
> > 
> > 
> > Yeah, personally I would prefer the __ prefix...
> I've tweaked it to __axi_dac_bus_reg_write() whilst applying.
> 

so really happy, thanks a lot everybody for the support,
following if there's anything to fix.

> 
> > 
> > - Nuno Sá
> > 
> > 
> > 
> 

Regards,
  angelo

