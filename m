Return-Path: <linux-kernel+bounces-249173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 607EF92E7F3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 14:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8446F1C226A3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 12:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4B215B147;
	Thu, 11 Jul 2024 12:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vh0NLzJT"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B8115B0F9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 12:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720699679; cv=none; b=jtj7O72zIEYx4yKx5HigUbOUas1pjB21/d3sj7sfOqb/8YVud8Y4AvGI8Lx32Ir8YGHwclU0QM5CAwx8BIDzpuD9r7nDumH7Ocwnu6LfXPhJTU5pKNK+aMvSVcyIWKanZuLVKTITAhLQVlz2JYegoR5ggxVUKSCxUMyXBrgjIqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720699679; c=relaxed/simple;
	bh=gVSuCUIz2Z2/0VqE+99PMIe1HaK/lI3WbgYX5U4KY3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lo6bYxVyqi8JSoUhd3tPq6osnCZB2wYsnhRzngGlaHxV/H3/Iz8jc8yS1z8OoV0fYmGsh7UnqeWRD+l6f2Zb6j+6OMykwA0mtQnBFSS6DIl1YaSiuvtQJSv+jEQ2yKz29WcB2kIo3KwhjtE/szpR1Tlw+2wjDxgED5QuDs2OKFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vh0NLzJT; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-367a3d1a378so578223f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 05:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720699675; x=1721304475; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d5Kf+LZ6LcKjPGvwztwrxahCZ1crQoEjZZ58rS5ITkg=;
        b=Vh0NLzJTMM1NkbLQAiUpAPwNm7TmVAmbM/jOeqgcbt3bLZvqyMsDI/D33nSDRGwUae
         t5Z0CCDrVmSM8bq23i82U1qBiGui+jCmBMqpyiug7aN4UjtwV6DjnYJtwCWKak2LFoCA
         LvDLtuMcXrrSmyE7Le/eSCMaTacSrsEa2h6PpwEuVkQKMKK9nomwM3Cm9ADrz2QEj5iz
         Sh25ZuEEQUyklHAunVm/THR/JlgXhOa5YZWPmqw5XODjMulTNUJJ5ZGax7BiApVjbdLb
         wmWiP/EIGCcVxapxDBTDxEyeuvBM/n/vhOcDow4VIg77Zo26LxsNznp+73+5p0yyzHEO
         gftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720699675; x=1721304475;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d5Kf+LZ6LcKjPGvwztwrxahCZ1crQoEjZZ58rS5ITkg=;
        b=YgyMsy13KPCzGMiyUFMQFXCWb00CZsqpaM+bc7qeAmzpDiUcjFeaeLzG47I2zMF8iW
         YG2WfJXJUqaCKacek23QGZ5ysExlRNpSvTKSyDyUkCo3uZM4B6+IBXMMj/oryAMZWajL
         LH/ls+NNDIfFZJXZ3ty9kqDNZx9Lp+Zyxa3gIXiF6Pc6I2rwhBv7tHw7OSj9VIOMH3NA
         5oz/2GGz0refV0GlVWMWWrMWP8EYR9pbPng2YkuYWi5L8OiMGVAT8YPYlFNB1yKXABAH
         ZnQTJD7Nxdk1hTiolYcWyIhkgGv+GC8I1gt0p8JNJ4qTeW0hGoDgnIXTvB7hbFQ0wfDj
         NtLA==
X-Forwarded-Encrypted: i=1; AJvYcCUEIatbcF6f6q+WFFsORKh6rNck2XsFIy1ZaPWQOQkmj1JAUzbwecmFlYFAfOBRQwKMNgUkZxOlsVRaW8MuCbxCsTd1sSMjXPMvOvyq
X-Gm-Message-State: AOJu0Yy3QBb9y0VIAisF8jDCrJpq9UCDzRvJL2N+MLg8Ucoa0Q/PgLEo
	lzVJ7+Vh3T0v38nlbSQ9nrjYrlJ5TS9UhOEpdnN+DXnp/s3Nmn751TLM8iZs8dM=
X-Google-Smtp-Source: AGHT+IEkZ2YyIuhpkv7q6iFMSzaFax5UIB73+wc1A85RGjyzVvq2b/ZxNk8pJyv9Q+Rd+1ZLLWFVHQ==
X-Received: by 2002:a05:6000:156d:b0:367:f054:620a with SMTP id ffacd0b85a97d-367f0546307mr2260708f8f.30.1720699675282;
        Thu, 11 Jul 2024 05:07:55 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfab11csm7572156f8f.102.2024.07.11.05.07.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 05:07:54 -0700 (PDT)
Message-ID: <078e3274-f592-4ce0-a938-d58a0f88cf84@linaro.org>
Date: Thu, 11 Jul 2024 13:07:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] media: ov5675: Elongate reset to first transaction
 minimum gap
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Jacopo Mondi <jacopo@jmondi.org>
Cc: Johan Hovold <johan@kernel.org>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, dave.stevenson@raspberrypi.com
References: <20240711-linux-next-ov5675-v1-0-69e9b6c62c16@linaro.org>
 <20240711-linux-next-ov5675-v1-2-69e9b6c62c16@linaro.org>
 <fcd0db64-6104-47a6-a482-6aa3eec702bc@cherry.de>
 <aa20591f-3939-4776-9025-b8d7159f4c63@linaro.org>
 <1051b88e-d6af-4361-a4de-95a28ddfad69@cherry.de>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <1051b88e-d6af-4361-a4de-95a28ddfad69@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/07/2024 12:41, Quentin Schulz wrote:
> Hi Bryan and Dave,
> 
> On 7/11/24 1:22 PM, Bryan O'Donoghue wrote:
>> On 11/07/2024 11:40, Quentin Schulz wrote:
>>> Hi Bryan,
>>>
>>> On 7/11/24 12:20 PM, Bryan O'Donoghue wrote:
>>>> The ov5675 specification says that the gap between XSHUTDN deassert 
>>>> and the
>>>> first I2C transaction should be a minimum of 8192 XVCLK cycles.
>>>>
>>>> Right now we use a usleep_rage() that gives a sleep time of between 
>>>> about
>>>> 430 and 860 microseconds.
>>>>
>>>> On the Lenovo X13s we have observed that in about 1/20 cases the 
>>>> current
>>>> timing is too tight and we start transacting before the ov5675's reset
>>>> cycle completes, leading to I2C bus transaction failures.
>>>>
>>>> The reset racing is sometimes triggered at initial chip probe but, more
>>>> usually on a subsequent power-off/power-on cycle e.g.
>>>>
>>>> [   71.451662] ov5675 24-0010: failed to write reg 0x0103. error = -5
>>>> [   71.451686] ov5675 24-0010: failed to set plls
>>>>
>>>> The current quiescence period we have is too tight, doubling the 
>>>> minimum
>>>> appears to fix the issue observed on X13s.
>>>>
>>>> Fixes: 49d9ad719e89 ("media: ov5675: add device-tree support and 
>>>> support runtime PM")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>>> ---
>>>>   drivers/media/i2c/ov5675.c | 9 +++++++--
>>>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/media/i2c/ov5675.c b/drivers/media/i2c/ov5675.c
>>>> index 92bd35133a5d..0498f8f3064d 100644
>>>> --- a/drivers/media/i2c/ov5675.c
>>>> +++ b/drivers/media/i2c/ov5675.c
>>>> @@ -1018,8 +1018,13 @@ static int ov5675_power_on(struct device *dev)
>>>>       gpiod_set_value_cansleep(ov5675->reset_gpio, 0);
>>>> -    /* 8192 xvclk cycles prior to the first SCCB transation */
>>>> -    usleep_range(delay_us, delay_us * 2);
>>>> +    /* The spec calls for a minimum delay of 8192 XVCLK cycles 
>>>> prior to
>>>> +     * transacting on the I2C bus, which translates to about 430
>>>> +     * microseconds at 19.2 MHz.
>>>> +     * Testing shows the range 8192 - 16384 cycles to be unreliable.
>>>> +     * Grant a more liberal 2x -3x clock cycle grace time.
>>>> +     */
>>>> +    usleep_range(delay_us * 2, delay_us * 3);
>>>
>>> Would it make sense to have power_off have the same logic? We do a 
>>> usleep_range of those same values currently, so keeping them in sync 
>>> seems to make sense to me.
>>
>> I have no evidence to suggest there's a problem on the shutdown path, 
>> that's why I left the quiescence period as-is there.
>>
>>> Also, I'm wondering if it isn't an issue with the gpio not being high 
>>> right after gpoiod_set_value_cansleep() returns, i.e. the time it 
>>> actually takes for the HW to reach the IO level that means "high" for 
>>> the camera. And that this increased sleep is just a way to mitigate 
>>> that?
>>
>> No, that's not what I found.
>>
>> I tried changing
>>
>>          usleep_range(2000, 2200);
>>
>> to
>>          usleep_range(200000, 220000);
>>
>> but could still elicit the I2C transaction failure. If the time it 
>> took for the GPIO to hit logical 1 were the issue then multiplying the 
>> reset time by 100 would certainly account for that.
>>
>> // BOD set the chip into reset
>>          gpiod_set_value_cansleep(ov5675->reset_gpio, 1);
>>
>> // BOD apply power
>>          ret = regulator_bulk_enable(OV5675_NUM_SUPPLIES, 
>> ov5675->supplies);
>>          if (ret) {
>>                  clk_disable_unprepare(ov5675->xvclk);
>>                  return ret;
>>          }
>>
>>          /* Reset pulse should be at least 2ms and reset gpio released 
>> only once
>>           * regulators are stable.
>>           */
>>
>> // BOD spec specifies 2 milliseconds here not a count of XVCLKs
>>          usleep_range(2000, 2200);
>>
>>          gpiod_set_value_cansleep(ov5675->reset_gpio, 0);
>>
> 
> I meant to say this gpiod_set_value_cansleep(), which is logical LOW and 
> not HIGH, brain not braining today sorry. But the question remains the 
> same.

Ah right yes I get you, you mean how can I prove the sensor has come out 
of reset by the time we start counting for the first I2C transaction delay ?

There's no way to prove that, the only thing we can do is elongate the 
post reset delay by X, whatever X we choose.

> So, maybe this is all too complex for something that could be as simple 
> as 8192 XVCLK cycles for 6MHz as Dave suggested I believe. And have some 
> wiggle room added in case we ever support 6MHz and it has the same issue 
> as you encountered with 19.2MHz (or whatever was that rate you were 
> running the camera at). 1/6MHz * 8192 * 2 ~= 2.7ms if I'm not mistaken. 
> So maybe go with that with a comment just above to justify why we are 
> doing this with hardcoded values?

2.7 milliseconds is alot.

Worst case XVCLK period is 1.365 milliseconds.

If your theory on the GPIO is correct, its still difficult to see how @ 
6MHz - which we don't yet support and probably never will, that 1.5 
milliseconds would be insufficient.

So - I'm happy enough to throw out the first patch and give a range of 
1.5 to 1.6 milliseconds instead.

---
bod


