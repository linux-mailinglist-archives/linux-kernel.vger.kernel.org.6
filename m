Return-Path: <linux-kernel+bounces-324364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 629AE974BA9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFE8128D49C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 07:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A367A13CFA1;
	Wed, 11 Sep 2024 07:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eBBCVD31"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C553CF6A
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 07:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726040495; cv=none; b=NQ1DuLvJK3cB0jMM+TxXtHos0/tJBrU91obF7UcptaFa25v2wsFhEy3ovxO3CsaR+uvV4+pCda4evGWtHzNPhZ0m1/Wi92jRpYmAKLuCT/wpSfEJbZMkWURabgFEN1yeuJmhJBANTbC21wkvJDvHAhNgzjIt68DURzbJexIusv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726040495; c=relaxed/simple;
	bh=joVqENx1ELR5BZDlrF3KM3WajgRpYJSbt9DI9rjGeGU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=np/k+PM+M5Kmi8IRkOsZVuU5SiWy9SlZcNZFUaIo8UPrOVrVBltPdVxkhmJsYIEY5ctEFysNlL7GW/v6Tt/GYvO3wHndJAsBdLOLQzwq6F9wy3q22JNkTE1uerJUkwKi2V88nO0+/l8UvnsMa6lvRayvPNZEGt+p4B9w8XeiRZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eBBCVD31; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-374c1963cb6so4082862f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 00:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726040492; x=1726645292; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6z34Zlt3Q4zjZ37hMcQIHQZDLBbn26U33a/y1R7bWK8=;
        b=eBBCVD31xUmxT+M4M+6aynDEI6S69DaP2PkhzY9E5cA1RokpHxBnNO5wFCeB6egVZI
         q9I2+Z9pcxRuw1AVyvsdQaIPHIoVJkudj8QYmcyZAIJXpzdcygViWU+Oi2xqmQXy7thL
         /WjIxPR7HkkQR3sN4bZNca1q5ALTVZGUMMLxxUep3OJ4Umb9v1zV2+9pHy0/muqGV18i
         TgCIVKmfo6n0XM6tGz4YJUmxr18SVd8sSZo1x3n1ayB3TUWe8GSYWklACO88TTJyMRI8
         +vBRukrlUZW4oW6cw+Jw6+4n6Maiz0FJIsZSRioYEYXZlEXGK/FNkJx7p0fIfhi8ezHX
         micA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726040492; x=1726645292;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6z34Zlt3Q4zjZ37hMcQIHQZDLBbn26U33a/y1R7bWK8=;
        b=oIeYBMAf1jWJCEIA6C3T2YWLwLY4+tYl228H1s2KhT57fe3keDnyu1dXoPkMetcDof
         Q4MmR9VC2vYOli7Eh1WYC+0dqImqCAxVNqiSOJyqXsL9HrpYB6jXJ4jgqwbn1qjusKak
         ZZH5s0tuCjoix9NCx/UMrKOtYPhuK3mAai+cNR9bbqW1JW8eUsOdyMNOgKAyXlRYVb/n
         DHQ+F+gylCIS03Ank7pKW5PUd6tZETYuRMzyoB5ji9AgPxKLPQjd+bSfavJLt2KTcPMo
         xc5h+zJKYTABc1Y7FTkwC4Z3mjHWndfVi5U53ugUe7zPuxsWs9d0avhGlr3V5kB9vJL8
         bWXA==
X-Forwarded-Encrypted: i=1; AJvYcCWsBLYzX1D+fZ+bgxGYLqC5lnf+7izcSM6kd5ewpG/vq8lwlyWKPHZ+BtivO7zQHAJvryF00InphaHY5tI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0bR9Y/MclFNHxu0Nx61c6WbCaJeowH0gOyEbIdDVNwEujTXPh
	bufam9Nvwxoka7JL5JLK+0iMx5GckxNl7vXWWDnXr2937Ng4BRJqMA59BJuDPyQ=
X-Google-Smtp-Source: AGHT+IFiZ0mm2FQhbHm611cF4I2LYPqNYqrELrQqrRF69RgkMEnaahSfB7lwFpMNJUfHVpjrxmCXOQ==
X-Received: by 2002:adf:f30a:0:b0:377:27f1:d54f with SMTP id ffacd0b85a97d-3788967e268mr12536337f8f.45.1726040491556;
        Wed, 11 Sep 2024 00:41:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:1680:3625:e94b:7c21? ([2a01:e0a:982:cbb0:1680:3625:e94b:7c21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895675c1dsm10791369f8f.58.2024.09.11.00.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 00:41:31 -0700 (PDT)
Message-ID: <8f0227fb-1457-4464-810a-c6b915d9349a@linaro.org>
Date: Wed, 11 Sep 2024 09:41:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/panel: himax-hx83112a: transition to mipi_dsi wrapped
 functions
To: Doug Anderson <dianders@chromium.org>,
 Tejas Vipin <tejasvipin76@gmail.com>,
 Abhishek Tamboli <abhishektamboli9@gmail.com>
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Javier Martinez Canillas <javierm@redhat.com>
References: <20240904141521.554451-1-tejasvipin76@gmail.com>
 <0bb94cc0-dd72-4da7-b0b6-9e1fe712709b@quicinc.com>
 <0e3bf87b-7d82-44eb-88d2-fddc8e33dd25@quicinc.com>
 <330174f9-bead-4411-b05e-ea9c009f765c@gmail.com>
 <CAD=FV=XsHuhprN-ijw8-ZmOKV6CnCrR=s4X4L57p9J8e02MTBg@mail.gmail.com>
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
In-Reply-To: <CAD=FV=XsHuhprN-ijw8-ZmOKV6CnCrR=s4X4L57p9J8e02MTBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/09/2024 23:19, Doug Anderson wrote:
> Hi,
> 
> On Sat, Sep 7, 2024 at 1:32 AM Tejas Vipin <tejasvipin76@gmail.com> wrote:
>>
>> On 9/7/24 3:53 AM, Jessica Zhang wrote:
>>>
>>>
>>> On 9/6/2024 3:14 PM, Jessica Zhang wrote:
>>>>
>>>>
>>>> On 9/4/2024 7:15 AM, Tejas Vipin wrote:
>>>>> Changes the himax-hx83112a panel to use multi style functions for
>>>>> improved error handling.
>>>>>
>>>>> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
>>>>
>>>> Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
>>>
>>> Hi Tejas,
>>>
>>> Just a heads up, it seems that this might be a duplicate of this change [1]?
>>>
>>> Thanks,
>>>
>>> Jessica Zhang
>>>
>>> [1] https://patchwork.freedesktop.org/patch/612367/?series=138155&rev=1
>>
>> Ah, thanks for letting me know. I hadn't realized someone else had
>> started working on this too.
>>
>> However, I would argue that my patch [2] is a better candidate for merging
>> because of the following reasons:
>>
>> 1) Removes unnecessary error printing:
>> The mipi_dsi_*_multi() functions all have inbuilt error printing which
>> makes printing errors after hx83112a_on unnecessary as is addressed in
>> [2] like so:
>>
>>> -     ret = hx83112a_on(ctx);
>>> +     ret = hx83112a_on(ctx->dsi);
>>>        if (ret < 0) {
>>> -             dev_err(dev, "Failed to initialize panel: %d\n", ret);
>>>                gpiod_set_value_cansleep(ctx->reset_gpio, 1);
>>>                regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
>>> -             return ret;
>>>        }
>>
>> [2] also removes the unnecessary dev_err after regulator_bulk_enable as was
>> addressed in [3] like so:
>>
>>>        ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
>>> -     if (ret < 0) {
>>> -             dev_err(dev, "Failed to enable regulators: %d\n", ret);
>>> +     if (ret < 0)
>>>                return ret;
>>> -     }
>>
>> 2) Better formatting
>>
>> The mipi_dsi_dcs_write_seq_multi statements in [1] aren't formatted
>> quite right according to what has been done so far. They are written as
>> such in [1]:
>>
>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETTP1,
>>>                               0x02, 0x00, 0xa8, 0x01, 0xa8, 0x0d, 0xa4, 0x0e);
>>
>> Where they should be written as such in [2]:
>>
>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETTP1,
>>> +                                  0x02, 0x00, 0xa8, 0x01, 0xa8, 0x0d, 0xa4, 0x0e);
>>
>> All in all, the module generated using my patch ends up being a teensy
>> bit smaller (1% smaller). But if chronology is what is important, then
>> it would at least be nice to see the above changes as part of Abhishek's
>> patch too. And I'll be sure to look at the mail in the drm inbox now
>> onwards :p
>>
>> [1] https://patchwork.freedesktop.org/patch/612367/?series=138155&rev=1
>> [2] https://lore.kernel.org/all/20240904141521.554451-1-tejasvipin76@gmail.com/
>> [3] https://lore.kernel.org/all/CAD=FV=XRZKL_ppjUKDK61fQkWhHiQCJLfmVBS7wSo4sUux2g8Q@mail.gmail.com/
> 
> I would tend to agree that Tejas's patch looks slightly better, but
> Abhishek's patch appears to have been posted first.
> 
> Neil: any idea what to do here? Maybe a Co-Developed-by or something?
> ...or we could land Abhishek and Tejas could post a followup for the
> extra cleanup?

Yeah usually I take the first one when they are equal, but indeed Tejas
cleanup up a little further and better aligned the parameters so I think
Tejas's one is a better looking version.

In this case we should apply Teja's one, nothing personal Abhishek!

> 
> Abhishek: are you planning to post more _multi cleanups? If so, please
> make sure to CC Tejas (who has been posting a bunch of them) and
> perhaps me since I've been helping to review them a bit.
> 
> -Doug


