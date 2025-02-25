Return-Path: <linux-kernel+bounces-530934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D51A43A54
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 197913B4FB5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECE926157E;
	Tue, 25 Feb 2025 09:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nQQEd6gE"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AEA26138C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740476985; cv=none; b=mbVWB3GB3ZR7iKLHoKDL1AmsDkCpfbP5CmJq9hFRb78bN44iZrGksS6+SMB+VVKrOl6fCt1BjnjdDBItAX5K9giOfHHniVxsvBF252fLB8qNBw3FaR4SkEEWTN3O3azBNgsXLFsKnktE4MpHAeRqfL71a9+iqUPNX3EMESkI34s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740476985; c=relaxed/simple;
	bh=wL3PdThfznU+ssmT8Zjs11BbPOAuu8A4VcaI5t/5CWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btQ3jUNPJy8RdJOpeMHIQnWxg9FrHqVeMioD1FPpAeIpSW+2UhjOK3SNOK6ng9WYpv4r5QuZgNmzsDvsDsYM0XLidcvZ4QYBWhmDqmaCD8AUzW+DFWYRPmYI0ZQ97zO6rcnApnENviKvt/cgrKcKzioVx1KNnMSCQ4+Y0qrQOTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nQQEd6gE; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4394036c0efso33454735e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740476981; x=1741081781; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ly0Mss/tFEwBQunMihP20nUWX/1m9yFcz2xqz8x9JMw=;
        b=nQQEd6gEAxfzhwduJyEbJWZX32s2iln8wnFHQmmX8o402q5Gbx2xptjupc1ux5OPAV
         a76FXeIcHsJwE1aSEN9P2HJPy4qWN0r2R+CtYOtSPqCBAadLHCoaxmliYDoBKnI2iYDs
         cYUVEaE+euRUcdvHut6ZUTD849lv82hnonATR3n///whbrqlMek7gEHYvPS4GE74XKBF
         Ok6/gPPcRg7qkoONHwP6aI1eutOn6BFg4qCxGlQLe71WuW95+y/4/pA4m3CPZUXlVEN1
         Rlyq/k+qZhGKNraRt2s4dHKuval/LtGmHwVtAqEjHzPSBK+lyFpG5yjLDtbqdYb3KNmI
         x1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740476981; x=1741081781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ly0Mss/tFEwBQunMihP20nUWX/1m9yFcz2xqz8x9JMw=;
        b=oQ8+dLThVczBsfX+YpslNvBjI34znVxYbA1jEAxnJ5f4f4X7Fi2uiUXQCJQ4LBx43/
         Axia7wBrRHCe/+/w/b+5JohfFz9FNUiNl01VWU/jH0HySe6hERLbSQiueLBypIMgxvlA
         Z4oIHBw7tMRLooy4kOcKD0OaxGI9iE2HLWnH8tNeyPSrrcYBIewAuvW5+/099i0AsJe+
         CbZLWBP1jEbZZDbvecCH0g/wQ1c3+IiON+EUqhROcrFzpsuqTaVC+Lyg/xS7S+w64ouh
         9YOdDoYbjDHWY9q7lfZYJMo74uzTimn+/iCIq96TCsVOmGJL40DTwhBjo1gAtCWNbLEi
         YHcA==
X-Forwarded-Encrypted: i=1; AJvYcCUG6ctx8HKLYLKj9/c87HujPiDT3ZvclsQ/DZKrlwL8tpYqc0X0/WyNOGQJ8D9DxLsNQkl6wnoig8hPPVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI0XbAd+HvTzyINbJYQqHgVC/tMz4DsyhNA8hXZd5Ydk8aV/9s
	T1MU4japScHLGwq4H3X7p6TWWmoMDsRIKuOPR1A0a1+5FcD0bIHDPCS7/5VTbzE=
X-Gm-Gg: ASbGnctCX/IEoD8IoP/vV+iEPVw+fLFnzuJ83Lri/bRXcrVPGfFO2ce6SjLB5KKroyo
	/WXDfnqvvzMJ7BaA6sIFsdMgu6vzeix1JSDXXoRDrcuxTHR2qBIQDuq53D5xo5hrSdHzff0TysU
	dvx2qpzM4ol3AfXO5ZS/muj0fX4CA85UaLG/9SwWaLnPVqlFFXgDiPshgtSDBVx8C07ezf1dmAC
	f5B8UuD/qchjMnsFxNJayV13jXeEszPxpyVK6t5V8LqHgDi6RgCyGPtIkFx50qqYn8/2Dt9NChQ
	hU5IQFTvkJNiMqMqECWBPnFGd/rGIVPMBGlAZRKzP+aZKZJYqVx3qh0ZbP6jjVA=
X-Google-Smtp-Source: AGHT+IHDpACS1MnrA3tOIvm+mE84/YCNTQv6apljqfHYR6JMn0FuV3pFbWZzIk6oKljI24iAYt3pig==
X-Received: by 2002:a05:600c:4e8c:b0:439:932c:e0d9 with SMTP id 5b1f17b1804b1-439ae1e62efmr151996865e9.10.1740476980709;
        Tue, 25 Feb 2025 01:49:40 -0800 (PST)
Received: from dfj (host-79-54-50-21.retail.telecomitalia.it. [79.54.50.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02ce651sm133990665e9.8.2025.02.25.01.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:49:40 -0800 (PST)
Date: Tue, 25 Feb 2025 10:48:25 +0100
From: Angelo Dureghello <adureghello@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: ad7380: add support for SPI offload
Message-ID: <ypaiae3flszokbvrk773pzcqxx53j6amjnhbkwq3oeopnmlyv5@2b3wfzqlpqtd>
References: <20250220-wip-bl-spi-offload-ad7380-v1-1-838aa873e62a@baylibre.com>
 <7b64c6a9-0606-45ba-be45-7ae11c4fdf39@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b64c6a9-0606-45ba-be45-7ae11c4fdf39@baylibre.com>

Hi,

On 22.02.2025 11:31, David Lechner wrote:
> On 2/20/25 12:03 PM, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> > 
> > Add support for SPI offload to the ad7380 driver. SPI offload allows
> > sampling data at the max sample rate (2MSPS with one SDO line).
> > 
> > This is developed and tested against the ADI example FPGA design for
> > this family of ADCs [1].
> > 
> > [1]: http://analogdevicesinc.github.io/hdl/projects/ad738x_fmc/index.html
> > 
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > ---
> 
> We forgot to also update Documentation/iio/ad7380.rst. We can follow up
> with a separate patch later though.
> 
> >  drivers/iio/adc/Kconfig  |   2 +
> >  drivers/iio/adc/ad7380.c | 509 +++++++++++++++++++++++++++++++++++++++++++----
> >  2 files changed, 475 insertions(+), 36 deletions(-)
> > 
> 
> ...
> 
> >  #define _AD7380_CHANNEL(index, bits, diff, sign, gain) {			\
> >  	.type = IIO_VOLTAGE,							\
> >  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
> > @@ -237,48 +335,123 @@ static const struct iio_scan_type ad7380_scan_type_16_u[] = {
> >  	.num_event_specs = ARRAY_SIZE(ad7380_events),				\
> >  }
> >  
> > +#define _AD7380_OFFLOAD_CHANNEL(index, bits, diff, sign, gain) {		\
> > +	.type = IIO_VOLTAGE,							\
> > +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |                          \
> > +		((gain) ? BIT(IIO_CHAN_INFO_SCALE) : 0) |			\
> > +		((diff) ? 0 : BIT(IIO_CHAN_INFO_OFFSET)),			\
> > +	.info_mask_shared_by_type = ((gain) ? 0 : BIT(IIO_CHAN_INFO_SCALE)) |   \
> > +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |				\
> > +		BIT(IIO_CHAN_INFO_SAMP_FREQ),					\
> 
> Not sure if this is worth troubling with, but it might make more sense to make
> IIO_CHAN_INFO_SAMP_FREQ info_mask_separate instead of info_mask_shared_by_type,
> at least in the case of the single-ended chips.
> 
> This family of chips does simultaneous conversions so shared_by_type (or shared_by_all)
> would typically be the right thing to do here. However, the single-ended versions
> of these chips also have a multiplexer, so there are 2 banks of simultaneously
> sampled inputs. So the effective sample rate as far as IIO is concerned would
> actually be 1/2 of the sampling_frequency attribute value.
> 
> Since we have a channel mask restriction where we force all channels in a bank
> to be enabled at once, I think it would work to make IIO_CHAN_INFO_SAMP_FREQ
> info_mask_separate where the reported sampling frequency is the conversion rate
> divided by the number of channels in a bank.
>

so if i understand properly,

for ad7386/7/8 i should use info_mask_separate, so that if a single bank
(called st->ch in the driver) is enabled, user can control that specific
bank sample rate. But user can also set the device in sequencer mode, so in this
case the sample rate is unique. So we could find 2 different sample rates in use
and the management of this seems probably unusual.

Could have sense to stay as we are now ?
 
> > +	.info_mask_shared_by_type_available =					\
> > +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |				\
> > +		BIT(IIO_CHAN_INFO_SAMP_FREQ),					\
> > +	.indexed = 1,                                                           \
> > +	.differential = (diff),                                                 \
> > +	.channel = (diff) ? (2 * (index)) : (index),                            \
> > +	.channel2 = (diff) ? (2 * (index) + 1) : 0,                             \
> > +	.scan_index = (index),                                                  \
> > +	.has_ext_scan_type = 1,                                                 \
> > +	.ext_scan_type = ad7380_scan_type_##bits##_##sign##_offload,            \
> > +	.num_ext_scan_type =                                                    \
> > +		ARRAY_SIZE(ad7380_scan_type_##bits##_##sign##_offload),		\
> > +	.event_spec = ad7380_events,                                            \
> > +	.num_event_specs = ARRAY_SIZE(ad7380_events),                           \
> > +}
> > +

