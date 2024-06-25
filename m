Return-Path: <linux-kernel+bounces-229111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3AA916B0F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76C1A282FF9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EE216E863;
	Tue, 25 Jun 2024 14:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tHKozgwm"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704A716D4C4
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327155; cv=none; b=i2MIzhUL0j85IDyUIshRh/Qdy2RNFqecmVb3wtzidinikz3PZEVXQSsUcves+TBBDvRi0wY5b6J6XyIZ01IUkgIu2heLjUKw66H9whxznXqco3rnwWv++JbXWrLIwiMi/jjhTgJ4aML934yQSa4GW8uXoSoGRmEKV/9GNqzFLpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327155; c=relaxed/simple;
	bh=uuF3GfxSCV+MtvdZsSJalXKic5RbtHK8tNxMMPIEwNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bw8mv10TY97UBfJFejNvpjf1HYCt4/XMyd/l8WDofKIypT3VTZc5B2eT1G1EMj3P956ghy+YTae4eYx2rjadznYLQznICx/jB3mTI/4TjZWJ4hhw5VqXSI+eJyHJoi0hzVoaWxMkmWlh0U3HBtAWPDge+X+T+qrb0Qo689wsKXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tHKozgwm; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-700cc8e447aso191733a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 07:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719327152; x=1719931952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eFCwqpYMAlOae3Wq7kaGE7/Xc9Z4VICKduGMP+d5BYA=;
        b=tHKozgwmOuIl+fWV8IqubGqMLkcbaOtqKp1CGGE8YlTONwn9q9kwbr1sJXFwzbPiEm
         D1LFtTk+1A7hJnjEzmCeQxHG5UCyiFGfKhjOzbU0TcpfwbLQWxNO1szW20V2PLUIIOok
         +Yaaq+wSxYRDYzNv6ngDvu3W4Yn22lUKM21rPjYaRbP8AVVcEObd/cvzfbxWFjoVrBZJ
         K0ASO2fADPmS1zjXmL0A9Y2+M3/KPpcV06mgxJ0bSD3ilj5/q8XNzG/ZtaLm+V80TAKG
         aS4RgJifyoDo5F7EExtZFdu+LabLwV6bdIfYXTCzwN9b9md14uCN3X17bFvXEv23v6l1
         5VqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719327152; x=1719931952;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eFCwqpYMAlOae3Wq7kaGE7/Xc9Z4VICKduGMP+d5BYA=;
        b=WH8N74WlQ+64NO4wDt+qkjRgk8MC6x7pS90x6b2QvpW2LnhgLDEkQXK5jlcNJNOZWK
         NESBn1WOw+VkknEUk5JVbRFY3+gfZfGkWx4XCJWKQ8tlLHVXzRZz1wpX5ACgtj02j22u
         UrIQEvXj16nMu426HnhF9+GSNuL/vL3n+aXF4Y7WewFNdnxtDQT1gfZm4YQiVm23z/b4
         v1SSRw1YzzlMt+4zkuaQ79k7mih+EwvO8Zd1O3skgb5VnEoxATpfK1jV9qLXbX778WdL
         zJIkxC9iU5O11R/IUmduK61vP/nqTPwUbcvFizRG9rKDX4PVsh0+GEON5dIH9QUoj4Zo
         9sKw==
X-Forwarded-Encrypted: i=1; AJvYcCUBIVDSpJunVicTyBDk4DFIcaOGZL41jL3bBSb18gc8g2KzoracVsi2ZY+DmEMJjTYbuycImrn4PbsBGjetAEYVwU9awB+5NIgLTj8L
X-Gm-Message-State: AOJu0YyfYpzWVcYCE9Ve288m9rEc0ox+c8Mb4Aa3UdANXAr19UKz1JP9
	prV+3IdME0GquNZ9UtFWZeFxkNLfLOCOeqe8UknX2IEVA/7iobDXPkGGr/1+8gE=
X-Google-Smtp-Source: AGHT+IGAyScvGTE83h+JooU2cToGFhIBseTN8NyFXWYnKyCjKQdamcC43ssWI2w6tTw3/ElSuMmRsA==
X-Received: by 2002:a05:6830:1e27:b0:6fc:3204:1244 with SMTP id 46e09a7af769-700af92396fmr8893804a34.19.1719327152376;
        Tue, 25 Jun 2024 07:52:32 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7009c6773aasm1557626a34.74.2024.06.25.07.52.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 07:52:31 -0700 (PDT)
Message-ID: <190ccd62-0803-46fa-87ee-0f9cef5a784e@baylibre.com>
Date: Tue, 25 Jun 2024 09:52:30 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: frequency: add amlogic clock measure support
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-iio@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
References: <20240624173105.909554-1-jbrunet@baylibre.com>
 <20240624173105.909554-3-jbrunet@baylibre.com>
 <04254d15-2f6e-435d-ba4c-8e2e87766b9b@baylibre.com>
 <1j4j9hift4.fsf@starbuckisacylon.baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <1j4j9hift4.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/25/24 3:31 AM, Jerome Brunet wrote:
> On Mon 24 Jun 2024 at 17:51, David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 6/24/24 12:31 PM, Jerome Brunet wrote:
>>> Add support for the HW found in most Amlogic SoC dedicated to measure
>>> system clocks.
>>>
>>
>>
>>
>>> +static int cmsr_read_raw(struct iio_dev *indio_dev,
>>> +			 struct iio_chan_spec const *chan,
>>> +			 int *val, int *val2, long mask)
>>> +{
>>> +	struct amlogic_cmsr *cm = iio_priv(indio_dev);
>>> +
>>> +	guard(mutex)(&cm->lock);
>>> +
>>> +	switch (mask) {
>>> +	case IIO_CHAN_INFO_RAW:
>>> +		*val = cmsr_measure_unlocked(cm, chan->channel);
>>
>> Is this actually returning an alternating voltage magnitutde?
>> Most frequency drivers don't have a raw value, only frequency.
> 
> No it is not the magnitude, it is the clock rate (frequency) indeed.
> Maybe altvoltage was not the right pick for that but nothing obvious
> stands out for Hz measurements

I'm certainly not an expert on the subject, but looking at the other
frequency drivers, using altvoltage looks correct.

But, we in those drivers, nearly all only have a "frequency" attribute
but don't have a "raw" attribute. The ones that do have a "raw" attribute
are frequency generators that use the raw attribute determine the output
voltage.

> 
>>
>>> +		if (*val < 0)
>>> +			return *val;
>>> +		return IIO_VAL_INT;
>>> +
>>> +	case IIO_CHAN_INFO_PROCESSED: /* Result in Hz */
>>
>> Shouldn't this be IIO_CHAN_INFO_FREQUENCY?
> 
> How would I get raw / processed / scale with IIO_CHAN_INFO_FREQUENCY ?
> 
>>
>> Processed is just (raw + offset) * scale which would be a voltage
>> in this case since the channel type is IIO_ALTVOLTAGE.
> 
> This is was Processed does here, along with selecting the most
> appropriate scale to perform the measurement.
> 
>>
>>> +		*val = cmsr_measure_processed_unlocked(cm, chan->channel, val2);
>>> +		if (*val < 0)
>>> +			return *val;
>>> +		return IIO_VAL_INT_64;
>>> +
>>> +	case IIO_CHAN_INFO_SCALE:
>>
>> What is this attribute being used for?
> 
> Hz
> 
>>
>> (clearly not used to convert the raw value to millivolts :-) )
>>
>> Maybe IIO_CHAN_INFO_INT_TIME is the right one for this? Although
>> so far, that has only been used with light sensors.
> 
> I think you are mixing up channel info and type here.
> I do want the info
>  * IIO_CHAN_INFO_RAW
>  * IIO_CHAN_INFO_PROCESSED
>  * IIO_CHAN_INFO_SCALE
> 
> I want those info to represent an alternate voltage frequency in Hz.
> I thought type 'IIO_ALTVOLTAGE' was the right pick for that. Apparently
> it is not. What is the appropriate type then ? Should I add a new one ?


The documentation at Documentation/ABI/testing/sysfs-bus-iio explains
what the combination of a channel type and info means.

For example, out_altvoltageY_raw is defined as it used for the frequency
generator case that I mentioned above. in_altvoltageY_raw is not defined
which means probably no one has needed it yet. But it would still be the
voltage value, not the frequency.

There also isn't a in_altvoltageY_input defined ("_input" is the sysfs
name for IIO_CHAN_INFO_PROCESSED). But in general, "input" (processed) in
IIO just means the value in standard units instead of a raw value. It
doesn't mean that any extra signal processing was done. And "scale" is
just a way to convert "raw" to "input" (processed). So channels will either
have "raw" and "scale" or only have "input" (processed), but not both.

Could you describe at a higher level what the use case for the various
values being exposed here are? I think that would be helpful in figuring
out where they actually fit in to the standard IIO attributes.

> 
>>
>>> +		*val2 = cmsr_get_time_unlocked(cm);
>>> +		*val = 1000000;
>>> +		return IIO_VAL_FRACTIONAL;
>>> +
>>> +	default:
>>> +		return -EINVAL;
>>> +	}
>>> +}
>>> +
> 


