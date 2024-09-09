Return-Path: <linux-kernel+bounces-321617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D2A971CF1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EC9E1C233DA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47E91BAEE9;
	Mon,  9 Sep 2024 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="L1GSHfwc"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886681B12FB
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725892915; cv=none; b=OheUXu7ipphKcOUwQd5InmdifSWOQDT0vv8ZbXopScUqbQTP9I5pgluYEdFKfVZTu892ON4O46j8QyGT/Fj/U5dylVEBTmQNK0nXA+EPFMLLVkt/c4qAInpGlkreBOlO9HFpVUar0MdS7KjavNn/Cc8q3hZQOh3j6k9K9y+Rdac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725892915; c=relaxed/simple;
	bh=hlwuCoMiTFjOvGjDzFfNBiaciFK9W3358+LrmXZ3MZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RQCdEOHdI9HyrBt+fhtKK9IBN9iUDN5tWnQdiBrOHF0mTbdL3aLM7JvxVxWomtH8Td7GW7yq9GzHVGXLJRD+FFDKRePFFWvN/4J066Nywge0QmKIIJ8hjVTw9Y6NZ0c9Ugdlglhw7C2dceuCfY9CkV0imo/wYd2JFWlcnujrolQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=L1GSHfwc; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5e1c49f9b9aso879801eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 07:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725892913; x=1726497713; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ergTFrc3hkuKd2AyBuJCZyB8TPkciUiO0ypONM2rJEQ=;
        b=L1GSHfwcwi/aR/JCVguQxIn3qbsIFw46x2I7eVLlEX/kN4mEjA45NY3hdCK857Ju6p
         2SFbtbQPcLhg+iKySWS1E4jDGIzLhLJHiipCxfTeAsF2qxuVQADCOPsR2pytp+qwTkUy
         8ecwNVBlMTzCV88EPYkXwg88noSyu9ZZGDlKvOVEbrcP7VnWRpPFBy5QYMNexclcyEGy
         VZrltnHbq/kXQ2HsXko2fvblNEoTc80KYX6BR2h0iwgDGdaveuJfdgcn5/KeJp0GqAIC
         7V1GOxYKeQX1wrdLHa7GWDgvTRrq2ZsvZwaj29me4AvHNatLzIl4oZOag+VFG9sJEujM
         Lzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725892913; x=1726497713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ergTFrc3hkuKd2AyBuJCZyB8TPkciUiO0ypONM2rJEQ=;
        b=d0t4PB7xHiIS6W+cI2BrhzO6ENpxdw4c5kKuXWN46ql3eAJ2S/87UAzErLpyF2/hMc
         qzx70twmD2FJTPeCvpSAeBRKyWagOLhVDgKp6G2EDXWnieIi1vSFVwh10xhsfAHdD9VD
         joUOBxzsJ7iBZe0k+5Br32RO0JpXK6ErAONEfBEqmfC0ISToGcRZQTIofo6efZSoYNmi
         x9lOHx1s9Xzqll4TG10/KMKduGzltBLCpL0zdnEjixRZbcpJNKnpk8HEzRRtJgliko6e
         Hef66i+dIdT2i3bzB4xYmAQUQtcCQisIQZq42KlYWgaMlaSgV4tteGAUHyfnKYjq75K0
         UsZA==
X-Forwarded-Encrypted: i=1; AJvYcCU4iaBL+Qu2jf39jxI9vMmX5w51mNdHppAWbiYQKubCcOez8R+wBOw/E5hYOu62ym0olUUST6sO8PNcovI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaTJwqCKJ70IieprGBAdArYuNIKC+jRusp67DVmyjArwRgGPlL
	siFRjyy1KQcbUfWhxTW5LcIwFqJNzAKp7Dek2iRW7n801FzrAfdPED0Fh8iMXBI=
X-Google-Smtp-Source: AGHT+IH14XO4FnzbwUxso+GMg4/c5FgtdhuuI9KHVd9+tevCm359YHQIjLcWutCFzG7p9HdVx3jurQ==
X-Received: by 2002:a05:6820:220f:b0:5dc:a733:d98a with SMTP id 006d021491bc7-5e1a9d3deaemr13156525eaf.7.1725892912675;
        Mon, 09 Sep 2024 07:41:52 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5e1bf2f5bfbsm1127180eaf.30.2024.09.09.07.41.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 07:41:52 -0700 (PDT)
Message-ID: <35b927a2-aef4-4d9f-9d8c-b12ad0f600a5@baylibre.com>
Date: Mon, 9 Sep 2024 09:41:51 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] iio: dac: support the ad8460 Waveform DAC
To: "Tinaco, Mariel" <Mariel.Tinaco@analog.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Dimitri Fedrau <dima.fedrau@gmail.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <noname.nuno@gmail.com>
References: <20240904023040.23352-1-Mariel.Tinaco@analog.com>
 <20240904023040.23352-3-Mariel.Tinaco@analog.com>
 <20240907181449.1453bd41@jic23-huawei>
 <SJ0PR03MB62241B8DAC3C45C192819ED391992@SJ0PR03MB6224.namprd03.prod.outlook.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <SJ0PR03MB62241B8DAC3C45C192819ED391992@SJ0PR03MB6224.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/24 3:22 AM, Tinaco, Mariel wrote:
> 
> 

...

>>> +	if (IS_ERR(state->regmap))
>>> +		return dev_err_probe(dev, PTR_ERR(state->regmap),
>>> +				     "Failed to initialize regmap");
>>> +
>>> +	state->sync_clk = devm_clk_get_enabled(dev, NULL);
>>> +	if (IS_ERR(state->sync_clk))
>>> +		return dev_err_probe(dev, PTR_ERR(state->sync_clk),
>>> +				     "Failed to get sync clk\n");
>>> +
>>> +	state->tmp_adc_channel = devm_iio_channel_get(dev, "ad8460-
>> tmp");
>>> +	if (IS_ERR_OR_NULL(state->tmp_adc_channel)) {
>>> +		indio_dev->channels = ad8460_channels;
>>> +		indio_dev->num_channels = ARRAY_SIZE(ad8460_channels);
>>> +	} else {
>>> +		indio_dev->channels = ad8460_channels_with_tmp_adc;
>>> +		indio_dev->num_channels =
>> ARRAY_SIZE(ad8460_channels_with_tmp_adc);
>>> +	}
>>> +
>> Add and enable the various other supplies. They are probably always on in
>> which case the regulator framework will work it's magic to avoid use having to
>> care that they aren't in the dts.
> 
> If the other supplies are added, do they need to be tied up as well to the
> Private structure just like ref_1p2v? Or do I just apply the 
> devm_regulator_get_enable_read_voltage to it?
> 
> ret = devm_regulator_get_enable_read_voltage(&client->dev, "vdd");
> If (ret < 0 && ret != -ENODEV)
> 	return dev_err_probe(ltc2309->dev, ret,
> 				"failed to get vref voltage\n");
> 

For supplies that just supply power, we usually don't worry
about the voltage, so just use devm_regulator_get_enable().
Or if there are lots of supplies, you can use
devm_regulator_bulk_get_enable() to do them all at once.

They don't need to be added to the private structure.

Also, lots of chips have to have supplies turned on in a
certain order. This one is no exception, so be sure to
have a look at the "POWER SUPPLY SEQUENCING" section in
the datasheet to make sure the driver turns things on in
the right order.

