Return-Path: <linux-kernel+bounces-389020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCBD9B67A3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 415571F225BD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A08E21FD9C;
	Wed, 30 Oct 2024 15:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VsU4B5Kk"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F42F21F4A5
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 15:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730301472; cv=none; b=ML5Pla7N4uIKo6HFdsmL+Yik3PR7KtNW1s4bIKe0LGvMxWLY6wIs9ppTwKhJqZO4wif2Vbl8oNeYs/KfMKOZsDCIf4okB30lde/YbHvY3dUlT6ETQtB8mOqNOFkD1JcVQSlscAlJbE6aRQ7tD7O/J4E2Pmkx1f5/FTK4kFG/Ncs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730301472; c=relaxed/simple;
	bh=KMe95Oav9UUtjQ8KxL+YP0fkRFrOhYva3HOMiL+GHlw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BnH1xPHz+kK5kibpZq6/FXaRPZkRb3xJxIyueOh8fsSpUzV2JPPjdQhHDLGMU8ZS2EEf2SwF+Rnz9Rt8STQgBxua8V1fxdkl7GrYWeAvKuGWbNNAjam+MkNm8ECCH9/i/y+2McC+qRySJbqrdvb7zH20R2J8jwhAHDwq+ccChgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VsU4B5Kk; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4314f38d274so86016365e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 08:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730301467; x=1730906267; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nld+5lX6B0RPTIruuP0JriChCtvGT9xr3rmugHCDdIU=;
        b=VsU4B5KkufbIveTwAIZCMTC+E6rWHejo9rdJ9duXUxAjWaYy+4k93C6Bxt+PgSrsJx
         408+wsaMRT3yRTP/EW94ZWsDUrX/co8V2ZQQJS8SXPDkJnykMJOy5W0S2ZNpV/d04bm1
         U9i/5Kii0QhFKCbBzHvqc1yUAVod1+qmvG8Ke+CSt96Zt4vyM9dZiO5nhtaUUyud31PW
         nDn5WBl5JqhZUUuthAc3aStPK6yGJ2Bk2LRrvV6qy/0aCtC8D1nQh+nc0KeEokrUsK7r
         hinOAgqwV4OGmZADMsnZH7Q1FhdI8veUkqS07nOOj0wWDOFCHO0GwdSltkcHTXwgiQKq
         MHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730301467; x=1730906267;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nld+5lX6B0RPTIruuP0JriChCtvGT9xr3rmugHCDdIU=;
        b=tupxVeMZt32dXDypUVlYWsZ4Pn+XYO1KNwEV08YGiAXUzgyOBPyIaeMVwn5/KLebnD
         mY88s/ikoA3RctT8CjNMnHYEw3AI1E+nP1AuJfksttK8Zh+vQW1yCFKvkGzx1qAhtgkw
         HnZjJ2NIqVU7v5jm4YO5gB2NL9IGWI6hmbvRQZA2i58W+dMfqMaQcex4rO/l4i8q74wX
         /G/UM2Fe0MNk9PvYIxiIDJcEKTIdTQJL4cGiWg2UheNIOLGv5HsicERTV3INx8xC2blQ
         sjgmYtU9OY1EzkYh9jwCVUmhUPSzhc4SbezH5ujG4a9YCKzyigsEbX5+bHOnryOtmlxx
         NS3Q==
X-Forwarded-Encrypted: i=1; AJvYcCX9PYpluJsNrDR+S1vy71kEpzZ0ndmvZ6VPMo4xOelUQhLcGpZXo140WiZhVxVv94fhZ0e02/znkOfD3Vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP6N7BpU5IHr8Ibqz1Wo5XmCnfEpEdpAVwarI+Jxs3JTjFJqXB
	QDrXBf8feFSh+crQOTntlfHuIOYERWX1Xld8F7AdUKsRB+6m26taAXMMLM7Jeb0=
X-Google-Smtp-Source: AGHT+IFMEIV+VkKJg+SIopG7mLkdPPD/4rj1St9eYxgEzLUvExSb5n0MdRjl9vUGWFWdoQemIFIVzA==
X-Received: by 2002:adf:fe91:0:b0:37d:3f5f:9191 with SMTP id ffacd0b85a97d-380611d983cmr14962200f8f.33.1730301466911;
        Wed, 30 Oct 2024 08:17:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:201:dd6:9287:c715? ([2a01:e0a:982:cbb0:201:dd6:9287:c715])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b70c91sm15556802f8f.85.2024.10.30.08.17.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 08:17:46 -0700 (PDT)
Message-ID: <ff90fb92-ab4a-4719-b9c4-7b21245207b1@linaro.org>
Date: Wed, 30 Oct 2024 16:17:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 3/3] iio: magnetometer: add Allegro MicroSystems
 ALS31300 3-D Linear Hall Effect driver
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20241029-topic-input-upstream-als31300-v3-0-147926dd63b3@linaro.org>
 <20241029-topic-input-upstream-als31300-v3-3-147926dd63b3@linaro.org>
 <CAHp75VdH7bxuPW6Fx4Mcq18hQfr1sDhBYDwGn8OeurQOAar2kg@mail.gmail.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <CAHp75VdH7bxuPW6Fx4Mcq18hQfr1sDhBYDwGn8OeurQOAar2kg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29/10/2024 20:48, Andy Shevchenko wrote:
> On Tue, Oct 29, 2024 at 4:13 PM Neil Armstrong
> <neil.armstrong@linaro.org> wrote:
>>
>> The Allegro MicroSystems ALS31300 is a 3-D Linear Hall Effect Sensor
>> mainly used for 3D head-on motion sensing applications.
>>
>> The device is configured over I2C, and as part of the Sensor data the
>> temperature core is also provided.
>>
>> While the device provides an IRQ gpio, it depends on a configuration
>> programmed into the internal EEPROM, thus only the default mode is
>> supported and buffered input via trigger is also supported to allow
>> streaming values with the same sensing timestamp.
>>
>> The device can be configured with different sensitivities in factory,
>> but the sensitivity value used to calculate value into the Gauss
>> unit is not available from registers, thus the sensitivity is provided
>> by the compatible/device-id string which is based on the part number
>> as described in the datasheet page 2.
> 
> Thank you for an update, this looks more or less good. I have a few
> nit-picks below. With them addressed,
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> 
> ...
> 
>> +#include <linux/types.h>
>> +#include <linux/units.h>
> 
> It's a bit of an unusual order. Do you mean to put them after the
> regulator/*.h one?

Ack

> 
>> +#include <linux/bits.h>
>> +#include <linux/bitfield.h>
>> +#include <linux/delay.h>
>> +#include <linux/module.h>
>> +#include <linux/i2c.h>
>> +#include <linux/regmap.h>
>> +#include <linux/pm.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/regulator/consumer.h>
> 
> ...
> 
>> +#define ALS31300_DATA_X_GET(b)         \
>> +               sign_extend32(FIELD_GET(ALS31300_VOL_MSB_X_AXIS, b[0]) << 4 | \
>> +                             FIELD_GET(ALS31300_VOL_LSB_X_AXIS, b[1]), 11)
>> +#define ALS31300_DATA_Y_GET(b)         \
>> +               sign_extend32(FIELD_GET(ALS31300_VOL_MSB_Y_AXIS, b[0]) << 4 | \
>> +                             FIELD_GET(ALS31300_VOL_LSB_Y_AXIS, b[1]), 11)
>> +#define ALS31300_DATA_Z_GET(b)         \
>> +               sign_extend32(FIELD_GET(ALS31300_VOL_MSB_Z_AXIS, b[0]) << 4 | \
>> +                             FIELD_GET(ALS31300_VOL_LSB_Z_AXIS, b[1]), 11)
>> +#define ALS31300_TEMPERATURE_GET(b)    \
>> +               (FIELD_GET(ALS31300_VOL_MSB_TEMPERATURE, b[0]) << 6 | \
>> +                FIELD_GET(ALS31300_VOL_LSB_TEMPERATURE, b[1]))
> 
> Yeah, I have got that the data is interlaced, and it's still possible
> to use the __be64, but the resulting code might be too overengineered
> for this simple case (as it would require bitmap operations to remap
> interlaced bits and an additional churn on top of u64 to be
> represented as set of unsigned long:s).
> 
> ...
> 
>> +/* The whole measure is split into 2x32bit registers, we need to read them both at once */
> 
> 32-bit

Ack

> 
> ...
> 
>> +       /*
>> +        * Loop until data is valid, new data should have the
>> +        * ALS31300_VOL_MSB_NEW_DATA bit set to 1.
>> +        * Max update rate is 2KHz, wait up to 1ms
> 
> Missing period at the end.

Ack

> 
>> +        */
> 
> ...
> 
>> +       switch (mask) {
>> +       case IIO_CHAN_INFO_PROCESSED:
>> +       case IIO_CHAN_INFO_RAW:
>> +               ret = als31300_get_measure(data, &t, &x, &y, &z);
>> +               if (ret)
>> +                       return ret;
>> +
>> +               switch (chan->address) {
>> +               case TEMPERATURE:
>> +                       *val = t;
>> +                       return IIO_VAL_INT;
>> +               case AXIS_X:
>> +                       *val = x;
>> +                       return IIO_VAL_INT;
>> +               case AXIS_Y:
>> +                       *val = y;
>> +                       return IIO_VAL_INT;
>> +               case AXIS_Z:
>> +                       *val = z;
>> +                       return IIO_VAL_INT;
>> +               default:
>> +                       return -EINVAL;
>> +               }
>> +       case IIO_CHAN_INFO_SCALE:
>> +               switch (chan->type) {
>> +               case IIO_TEMP:
>> +                       /*
>> +                        * Fractional part of:
>> +                        *         1000 * 302 * (value - 1708)
>> +                        * temp = ----------------------------
>> +                        *             4096
>> +                        * to convert temperature in millicelcius
> 
>   Missing period at the end.

Ack

> 
>> +                        */
>> +                       *val = MILLI * 302;
>> +                       *val2 = 4096;
>> +                       return IIO_VAL_FRACTIONAL;
>> +               case IIO_MAGN:
>> +                       /*
>> +                        * Devices are configured in factory
>> +                        * with different sensitivities:
>> +                        * - 500 GAUSS <-> 4 LSB/Gauss
>> +                        * - 1000 GAUSS <-> 2 LSB/Gauss
>> +                        * - 2000 GAUSS <-> 1 LSB/Gauss
>> +                        * with translates by a division of the returned
>> +                        * value to get Gauss value.
>> +                        * The sensisitivity cannot be read at runtime
> 
> sensitivity

Good catch

> 
>> +                        * so the value depends on the model compatible
>> +                        * or device id.
>> +                        */
>> +                       *val = 1;
>> +                       *val2 = data->variant_info->sensitivity;
>> +                       return IIO_VAL_FRACTIONAL;
>> +               default:
>> +                       return -EINVAL;
>> +               }
>> +       case IIO_CHAN_INFO_OFFSET:
>> +               switch (chan->type) {
>> +               case IIO_TEMP:
>> +                       *val = -1708;
>> +                       return IIO_VAL_INT;
>> +               default:
>> +                       return -EINVAL;
>> +               }
> 
>> +
> 
> Seems like a stray blank line here.

Ack

> 
>> +       default:
>> +               return -EINVAL;
>> +       }
>> +}
> 
> ...
> 
>> +static int als31300_set_operating_mode(struct als31300_data *data,
>> +                                      unsigned int val)
>> +{
>> +       int ret;
>> +
>> +       ret = regmap_update_bits(data->map, ALS31300_VOL_MODE,
>> +                                ALS31300_VOL_MODE_SLEEP, val);
>> +       if (ret) {
>> +               dev_err(data->dev, "failed to set operating mode (%pe)\n", ERR_PTR(ret));
>> +               return ret;
>> +       }
>> +
>> +       /* The time it takes to exit sleep mode is equivalent to Power-On Delay Time */
>> +       if (val == ALS31300_VOL_MODE_ACTIVE_MODE)
>> +               usleep_range(600, 650);
> 
> fsleep() ?

Sure

> 
>> +       return 0;
>> +}
> 
> ...
> 
>> +       devm_mutex_init(dev, &data->mutex);
> 
> Hmm... While not critical, this may still return an error. There were
> only two (out of ~15) users that ignored the error code, in v6.12
> there are two more in IIO, while one is checking for it. I would like
> to check for an error and bail out (and maybe I'll update the other
> drivers in IIO to follow, including one GPIO module that ignores it).
> 

Ack, thanks for the review!

Neil



