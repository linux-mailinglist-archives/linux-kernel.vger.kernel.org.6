Return-Path: <linux-kernel+bounces-218240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED85490BBA0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 22:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 714E7285CE6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C7718FDD1;
	Mon, 17 Jun 2024 20:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eiVRXLWt"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135D7EEB3
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 20:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718654438; cv=none; b=uanS0EdcWvxFhF35wvsK2RbBOMdRv8FglVWt0lnp16YDvAP5mkk/zz0fVbLzXT3mUaILu29CSqrLgF+5JmXluhfL+eSPtY4JL0IlrJ+oJJ9MY97YcQdu3dqOF1cjMLxVcsudTMhNvsmaAiEWIsEDcrLKCruYp5BK3VuQF3cgEC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718654438; c=relaxed/simple;
	bh=EqkXfrkP3gPWSS5BM/zdIIbEjuJc6A1pmdfuyj5xnAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mHoUp6PRaYqVErlH+xp+2NNVPK0y2JzO/mll5I0p5UZk3X1ZrKK6Fal7kY0qssVTLUlPcmG+JWVvp5D8CNR2dz/gvcdfYuqUZgxys770mRRpUVphQ55I22hOgBHG7NnzfveviszT+yQO1SxrVRsVoKe5NF4NhRPk3xAdgOiFY0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eiVRXLWt; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6f361af4cb6so1422312a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718654436; x=1719259236; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iYek31CMWeGWStaRdAqqq52yGHBws7Yomjqrz+qAjRQ=;
        b=eiVRXLWtSjFukC5Og08EWyIRUiOmS/IdS19BKUtV0ccbNs/z4FQueIVH6iJtum3fp7
         Xygv9wxWof3JBzz2IEQPoI7FSOZHTWcR/6MEFWp7z+C8LCNLtd3jcNWoaqXZHv6qHNrO
         3L2Mzq0rNcctDgt4rfPDb6b3cgJTBjv+J8Y9au5JXLy8EuBzvLXZkXfTXerwVs0PbRaq
         4ayn7G+yfHS1Xj5AjA9a7WW2lWC4slWPVFK9KbztW8uAQ4m2H2cHGKf2MR/RJLu4dbVy
         rXAB6gBKuLjoVRBsUQnosbXDgpAaW2m/mqKzFRE/ibSApQnacYT7LukyYURG8isG1IaY
         vZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718654436; x=1719259236;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iYek31CMWeGWStaRdAqqq52yGHBws7Yomjqrz+qAjRQ=;
        b=X2Yf9PeSip3NXwsaC+fTnBsepI1Aix7m3yX0dOsXsL9oB8XwkiSCa0qPN6eSTjGv3p
         jx7k2oNakefCYd48KlSudNDMMTN7CJ0HxzMhDCv2Bivahwkk5to7UtjVYI14aKHl0pzh
         010g3K9KhWUpfsZ8L7EV5uL8wEZvfbyIms+J9yt730de9M3nFwyoV40Ftue+t6C1T1t+
         uEWFSsJ8i/jjWmFomq4cxkW+PEKYgjVZlMsahldDb+6VQVtgiudfpA3eGxyCUP3Q2NE4
         +NiQoGHBHMUsdqDTrAiZIplXk2iAEGntKvW0nHDqO7mXODD3b/yuu4i+5sKTp+ivsW+k
         /LFA==
X-Forwarded-Encrypted: i=1; AJvYcCWmHtD2P4Sm/utHBg6flAB4yWcaT0gnmn1KRTWJdZdKKnzXwh2b5peGN3N33w4C3/TViA2hrfKgAB05MBcsByIPXjN+XofIJH5OxAHS
X-Gm-Message-State: AOJu0YzP54qshwC8Ui0ikZEap815VLVWvWJTDgziTbL41omLnyuh0Cix
	0ffi58QqRcREVGtW98+MVUuxSa1DNlg0yeVFmt91e5aUVYdCuLtpt6WckWPmxVU=
X-Google-Smtp-Source: AGHT+IFMjlP+SVw1E4LmDkxm7P2UoCTWoaRJ4n+SsjcmixURN8uVC4n27kpVn99kklmXI/wCzYSI/A==
X-Received: by 2002:a05:6830:154c:b0:6eb:7d32:ead4 with SMTP id 46e09a7af769-6fb9376615fmr12941380a34.9.1718654435891;
        Mon, 17 Jun 2024 13:00:35 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6fb801b0443sm1544134a34.49.2024.06.17.13.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 13:00:35 -0700 (PDT)
Message-ID: <4ff58005-4a71-491f-9400-cdecf2c25d66@baylibre.com>
Date: Mon, 17 Jun 2024 15:00:34 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] iio: adc: ad7192: use
 devm_regulator_get_enable_read_voltage
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240612-iio-adc-ref-supply-refactor-v2-0-fa622e7354e9@baylibre.com>
 <20240612-iio-adc-ref-supply-refactor-v2-1-fa622e7354e9@baylibre.com>
 <20240615130858.22043725@jic23-huawei>
 <dbf947a3-3d3b-4686-a707-a813b6a4ce5a@gmail.com>
 <CAMknhBFJ01Xu69Arvd3S=dbADGFmzaYKm2XBtw_CtnjtYwnnew@mail.gmail.com>
 <2d47aeef-5ee0-4e6f-a408-ba5d737d2c5a@gmail.com>
 <8dd5f4b9-809f-43d8-ba5c-5f7be23107a4@baylibre.com>
 <15a0c2d8-9df4-4a26-bdf4-01f9c3f76ca7@gmail.com>
 <CAMknhBE=fEDdYPe1VeZwWWuvqf5TcUdM_LQGOugHCxGhSGP8-w@mail.gmail.com>
 <bbc2f159-d673-4652-a6b9-a528f905b67c@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <bbc2f159-d673-4652-a6b9-a528f905b67c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/17/24 11:01 AM, Alisa-Dariana Roman wrote:
> On 17.06.2024 18:28, David Lechner wrote:
>> On Mon, Jun 17, 2024 at 9:10 AM Alisa-Dariana Roman
>> <alisadariana@gmail.com> wrote:
>>>
>>> On 17.06.2024 16:48, David Lechner wrote:
>>>> On 6/17/24 8:38 AM, Alisa-Dariana Roman wrote:
>>>>> On 17.06.2024 16:22, David Lechner wrote:
>>>>>> On Mon, Jun 17, 2024 at 4:35 AM Alisa-Dariana Roman
>>>>>> <alisadariana@gmail.com> wrote:
>>>>>>>
>>>>>>> On 15.06.2024 15:08, Jonathan Cameron wrote:
>>>>>>>> On Wed, 12 Jun 2024 16:03:05 -0500
>>>>>>>> David Lechner <dlechner@baylibre.com> wrote:
>>>>>>>>
>>>>>>>>> This makes use of the new devm_regulator_get_enable_read_voltage()
>>>>>>>>> function to reduce boilerplate code.
>>>>>>>>>
>>>>>>>>> Error messages have changed slightly since there are now fewer places
>>>>>>>>> where we print an error. The rest of the logic of selecting which
>>>>>>>>> supply to use as the reference voltage remains the same.
>>>>>>>>>
>>>>>>>>> Also 1000 is replaced by MILLI in a few places for consistency.
>>>>>>>>>
>>>>>>>>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>>>>>>>>
>>>>>>>> Complicated bit of code, but seems correct.
>>>>>>>> However, it crossed with Alisa-Dariana switching adding a
>>>>>>>> struct device *dev = &spi->dev to probe() that I picked up earlier
>>>>>>>> today.
>>>>>>>>
>>>>>>>> I could unwind that but given Alisa-Dariana has a number of
>>>>>>>> other patches on this driver in flight, I'd like the two of you
>>>>>>>> to work out the best resolution between you.  Maybe easiest option
>>>>>>>> is that Alisa-Dariana sends this a first patch of the next
>>>>>>>> series I should pick up.
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>>
>>>>>>>> Jonathan
>>>>>>> I will add this patch to my series and send it shortly.
>>>>>>>
>>>>>>> Kind regards,
>>>>>>> Alisa-Dariana Roman.
>>>>>>
>>>>>> Great, thanks!
>>>>>
>>>>> Just one quick question:
>>>>>
>>>>> I am getting two such warnings when running the checkpatch script:
>>>>>
>>>>> WARNING: else is not generally useful after a break or return
>>>>> #1335: FILE: ./drivers/iio/adc/ad7192.c:1335:
>>>>> +        return dev_err_probe(dev, ret, "Failed to get AVDD voltage\n");
>>>>> +    } else {
>>>>>
>>>>> Should I switch the last two branches to get rid of the warnings or just ignore them?
>>>>>
>>>>
>>>> In the other patches, I was able to reorder things to avoid this
>>>> warning, but since this one was more complicated, I just ignored
>>>> this warning.
>>>>
>>>> We can't just remove the else in this case because the return
>>>> is inside of an `else if`.
>>>
>>>          /* AVDD can optionally be used as reference voltage */
>>>          ret = devm_regulator_get_enable_read_voltage(dev, "avdd");
>>>          if (ret == -ENODEV || ret == -EINVAL) {
>>>                  /*
>>>                   * We get -EINVAL if avdd is a supply with unknown voltage. We
>>>                   * still need to enable it since it is also a power supply.
>>>                   */
>>>                  ret = devm_regulator_get_enable(dev, "avdd");
>>>                  if (ret)
>>>                          return dev_err_probe(dev, ret,
>>>                                               "Failed to enable AVDD supply\n");
>>>
>>>                  avdd_mv = 0;
>>>          } else if (ret >= 0) {
>>>                  avdd_mv = ret / MILLI;
>>>          } else {
>>>                  return dev_err_probe(dev, ret, "Failed to get AVDD voltage\n");
>>>          }
>>>
>>> Would switching the last two branches, in order to get rid of the
>>> warnings, make the code harder to understand?
>>>
>>
>> I did it in the other order because usually we like to handle the
>> error case first.
>>
>> To make it more like the other patches, we could do something like
>> this. The only thing i don't like about it is that `ret` on the very
>> last line could come from two different places. But it is logically
>> sound in the current form.
>>
>>      /* AVDD can optionally be used as reference voltage */
>>      ret = devm_regulator_get_enable_read_voltage(dev, "avdd");
>>      if (ret == -ENODEV || ret == -EINVAL) {
>>          /*
>>           * We get -EINVAL if avdd is a supply with unknown voltage. We
>>           * still need to enable it since it is also a power supply.
>>           */
>>          ret = devm_regulator_get_enable(dev, "avdd");
>>          if (ret)
>>              return dev_err_probe(dev, ret,
>>                           "Failed to enable AVDD supply\n");
>>      } else if (ret < 0) {
>>          return dev_err_probe(dev, ret, "Failed to get AVDD voltage\n");
>>      }
>>
>>      avdd_mv = ret <= 0 ? 0 : ret / MILLI;
> 
> Maybe this would make it a bit clearer, but yes, the ret == 0 could still come from two different places :(.
> 
> avdd_mv = ret == 0 ? 0 : ret / MILLI;
> 

We could make a ret2 local variable inside of the if block to avoid writing over ret.


