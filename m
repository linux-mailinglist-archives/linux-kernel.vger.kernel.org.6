Return-Path: <linux-kernel+bounces-433901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E029E5E8D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 20:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22C2A166D54
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 19:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B2E226EDC;
	Thu,  5 Dec 2024 19:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AKRFRzeb"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028EF1990A2
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 19:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733425318; cv=none; b=BwDs1VDkY7ZoT/g/aBgpYBsUFTezt1RiVBqDjvDFMqRpKmbxycMkncj7skTPkrJ6ydo2li9znBT7OK6n6TJKpCGvmpjZOivUK8dB43QpV8T18pEbEqTjQvv5XESlVmWlrRsvkpJW+dr2t73jvfxIKqCiRvG0qGwvrQMK7uEs6q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733425318; c=relaxed/simple;
	bh=8ik38w9GU2WtkRtkZaXq6QpH4+Y0ahI6eayxAGSMAWg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FJrfKBmIiznO0t9FEATmNHBxiKluJu8k2nUoKkD9VzfNgvb7Y8XfnQj3BQVm+cLUNDQR2vbqtoh12wYlnxQn8RswT+t0hDGiBuQYPZGOfCzeMnC6UVOPYO49FZuMaG6iAvz3lLCe2kKfA/ewoEVGv811WqSPGeLXGpplxvhgLkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AKRFRzeb; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3ea52520327so791140b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 11:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733425315; x=1734030115; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IaFOO/mfjUBixXAYtvSMoA7J8PbrmSflkGjEoxaTBzw=;
        b=AKRFRzebX8wl24LMA9NWbIz+LXBGvL4732lXcCo1vADffGbQikUR/1Gy7pBWnlHzMx
         xusjQ1rAvMLVqgSeaRsx5HXRNlsAB4ty7EgKeqOIWwFnb9FsFIQB+dvrdvo9sYJfyWCf
         ynWO066KlOKGcceoUnubch0Kut/rnrV3UBWyHlGQBh5mTsQBU9/5FGdd528nj9ax/vB4
         h7CUliDmd7GXfsD5bpYdtaQgJBH9hY/KvGabfSORU+WIIJa702H3+e+N0AdccrdpR3l8
         8/zMa3qhr1yhpOWvBzHvzkMsplQcnQigy3A7MMWtc4l934YkosBuDN4y/St6rxW31Hma
         /g0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733425315; x=1734030115;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IaFOO/mfjUBixXAYtvSMoA7J8PbrmSflkGjEoxaTBzw=;
        b=Rlqb9FyVn76CI5UTBa6LZzU+QG2SuJDk2pCPZi5lf9FFKA18H5JLhI/LsVetaFiuFx
         P+gFO+HBTWNWy4TcTZYhZnbc+thpVk8DufIoyg3vx/AM2nSp7PuksOWZ8cg4AszC0ipq
         HTPbMjzQ2hCSSUwktHiewBrsxesHrbn0GQE2aOQ7RvFqPuL4dgFLTd6O08F85woKrwxU
         VChpeyWVIJjSyl7i+d1HdW8vpShRDZU41BV1MQleIpTrT8HeVdHhc0ajkrgeO9x6YIlZ
         AXB5Kq7erN5kuqUbYeceBXg3wt81y2lkQHKqR1B3K2ippYoDfuZTQYfdU5t8cuDRpVYX
         y59g==
X-Forwarded-Encrypted: i=1; AJvYcCWYYACBToMSJlS/irD5vJY4Bc4RLCZrGNYKi2MxobQt/hWRGdPEEyOvollilW4OdgjbCmf+kFE6Yv+wlpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUdgcS0jJhg+05vA9hgr9FM6DXiQGVNd4qO+ObWpALhtJRZ/1W
	9UAghE3bVTVGP+w4pTWrVC+0hafx892cUIDh30/Ugc1PW9xLDwPqRJSIFW7YMqI=
X-Gm-Gg: ASbGncvaadTkSdbNhgSfrgdXI+5StKG9TTf8d4QRFjRE50If5byBNvKDZ5FccsTIrXF
	eMbTm3/StoyIW+FziBy8TZWuipPVQWx0FZeut2BmMXzQZetOzhfZ8cCrpMrYkTcMKgcPMVH7uRv
	J2xAdkULvc8vnukq5AWUgMNw0suemo/TpLY/RfhT94P78+2RB4po8q59C1Xcx1NlXiwlz/s/GXi
	7OvxjX/NTUqQww7XRZBSkSQoEjXIhowKI6zzyC6fo2iDjEJc5Up/yR4p4+R9dVw1qUNjJLGx3QB
	ytIIM/EDHck=
X-Google-Smtp-Source: AGHT+IFUDmVuFaNfj2c7OVLcgWFCxMQtCVuhMU/p4FrORrns3HwZaKiwq8nLNxh6O55/Euxmzx2I2w==
X-Received: by 2002:a05:6808:1898:b0:3e6:2772:2a4b with SMTP id 5614622812f47-3eb19c168a3mr59071b6e.9.1733425314900;
        Thu, 05 Dec 2024 11:01:54 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3eb07869655sm408646b6e.50.2024.12.05.11.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 11:01:53 -0800 (PST)
Message-ID: <a4cd4d74-93bc-4c63-a9ee-aa25957b96d9@baylibre.com>
Date: Thu, 5 Dec 2024 13:01:51 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: adc: add Nuvoton NCT720x ADC driver
From: David Lechner <dlechner@baylibre.com>
To: Eason Yang <j2anfernee@gmail.com>, avifishman70@gmail.com,
 tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com,
 yuenn@google.com, benjaminfair@google.com, jic23@kernel.org,
 lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 nuno.sa@analog.com, javier.carrasco.cruz@gmail.com,
 andriy.shevchenko@linux.intel.com, marcelo.schmitt@analog.com,
 olivier.moysan@foss.st.com, mitrutzceclan@gmail.com, tgamblin@baylibre.com,
 matteomartelli3@gmail.com, alisadariana@gmail.com, gstols@baylibre.com,
 thomas.bonnefille@bootlin.com, ramona.nechita@analog.com,
 mike.looijmans@topic.nl, chanh@os.amperecomputing.com, KWLIU@nuvoton.com,
 yhyang2@nuvoton.com
Cc: openbmc@lists.ozlabs.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241203091540.3695650-1-j2anfernee@gmail.com>
 <20241203091540.3695650-3-j2anfernee@gmail.com>
 <8f5ca298-54ba-4274-a35d-83be868fcfc8@baylibre.com>
Content-Language: en-US
In-Reply-To: <8f5ca298-54ba-4274-a35d-83be868fcfc8@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/5/24 12:22 PM, David Lechner wrote:
> On 12/3/24 3:15 AM, Eason Yang wrote:


>> +static int nct720x_read_raw(struct iio_dev *indio_dev,
>> +			    struct iio_chan_spec const *chan,
>> +			    int *val, int *val2, long mask)
>> +{
>> +	int index = nct720x_chan_to_index[chan->address];
>> +	u16 volt;
>> +	unsigned int value;
>> +	int err;
>> +	struct nct720x_chip_info *chip = iio_priv(indio_dev);
>> +
>> +	if (chan->type != IIO_VOLTAGE)
>> +		return -EOPNOTSUPP;
>> +
>> +	guard(mutex)(&chip->access_lock);
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		err = regmap_read(chip->regmap16, REG_VIN[index], &value);
>> +		if (err < 0)
>> +			return err;
>> +		volt = (u16)value;
>> +		*val = volt >> 3;
> 
> It seems strange that this is 13 bits when the chips are 8 and 12 bit.
> 
>> +		return IIO_VAL_INT;
>> +	case IIO_CHAN_INFO_SCALE:
>> +		/* From the datasheet, we have to multiply by 0.0004995 */
> 
> The scale is the same for both 8 bit and 12 bit chips?
> 
>> +		*val = 0;
>> +		*val2 = 499500;
>> +		return IIO_VAL_INT_PLUS_NANO;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +

Sorry, I got confused. The difference between the two chips is the
number of channels, not the number of bits. Please ignore these two
comments.

