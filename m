Return-Path: <linux-kernel+bounces-430928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 797A39E3765
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78920B2BCD9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CCA1AF0AB;
	Wed,  4 Dec 2024 10:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tvBlw8SK"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F55F18595B
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733307430; cv=none; b=qo25c9Yymk+/XgousdkB/ht0NclWAelWGSGMcPVqU965Dcakaly8czetBqB2iYb5C5kOdJo7foDcPM+DaCOrrgYyF0/UlClo9MHrCz7TBcjLoSDZag+ZqGskVlsU5vKU92NnKeUYApIQwioWwwK39NKYSwG+l/QzuEK7KfHTHpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733307430; c=relaxed/simple;
	bh=jBI72p1G4aC+JP1xOK/m0VIInB1bR7rMPs063MVIUgU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cx1ys2h+qOjUSphXASTD1Dbr61oScb8PdbGQSZ0WL8TWouKt4zjaLV/6TihZeC174FhtpzfmTYEfvlnRtmH7ZNy2XDQmFYXlWEs+dWZh6huteNGCEFAmBIObjob9aDEF0srMJuwFq51YaWqP7CPTJXX5g8x29WJQeaoAZSFYtGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tvBlw8SK; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385e87b25f0so413852f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 02:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733307426; x=1733912226; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IwYGoE0lwYluIalBShQtlG9f9t82GiZ00OYlWPwUtzU=;
        b=tvBlw8SKR4zGVMREsTDMmsk9jqQ4lS67A4kdLwKkhrG3EWCWty3T3yBn1l2sFO+kiP
         9X5jcc8MzKBY8M6+C8J/prId7MZ4THyJUenQc7mcCQhsJSuhA3uMAIJUTxFjMMIXp4da
         mIqZpYphhKChTvN0RoYmuVlES4ag8kcibqeFbpKnGQzi+jxNG6gnRCZff4V/SU8a2LLa
         UiO5xoNh+6CJ4Z5NAYc+K+sGX48cvyKARXXOpeAe+kwJONfjsdfY3NjOgL/BOf/k0IgT
         FufkjAaFKC7zemr57Gbbi6jixDv+L6yMgqtoZBXFIfy/wcabJ8kVBCQa8pxQabd8qCJT
         Fr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733307426; x=1733912226;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IwYGoE0lwYluIalBShQtlG9f9t82GiZ00OYlWPwUtzU=;
        b=Vd7uzZCsdi6M3vr7XKbAs9hbl4+qqVtr5z9jB8ET4GCIJC3pQMRWUSkRyjS2ba0Xdm
         JWBJ79hHPg84rn1iLiBwVfhB28yAeVpvlfrjRpeRObAadCjiHC5kRCaz0rJqUFyqladW
         7yB2c2VUSl4r8mvFsxOpaO/HFp4GsJTSd3Dp33eSve0na5hVPwDCAV2CxSagPvoR0uD4
         HF7aSDYz3gQEAVd3uosOkSuQ00GSN9VYPlsxnHm/rcq9CYimJWallAzch2ApA8PJRQ6X
         gSV6mfyqdhYgTA/UxORnvvtk6DGNdlcaYx7NlVmYHVq9+vc3qYxTdcIWG7TVTlontWk3
         kluQ==
X-Forwarded-Encrypted: i=1; AJvYcCXE6YEHIzu4Y4xQwpPHup3oBBZKw40v1HJAwmkAmPQf4yCmLU7ZbYygMMm2o1jVk1x1sq3VdcfYHtUrRMw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0ANrLDqkCW/3CLRfB6nn4pioUHYpm+JjYu1jPl7m8Ed5dRSsN
	zMlwLaZXLbLI+mm0GfpLFI9PAIlAbxDC0otJ7BDjFvrHwMSzx/6RMK28B2Fx2f4=
X-Gm-Gg: ASbGnctUcE3tgK3tnHXvlgz+Z86wfD17gHhz8oakZ48BUv1vAc6UKXi4vKpCyw2TW0S
	YaH3yli/0EfYR56FzBs0/wLPzBzMir8gKY8ZHUQJx6Id8qljkpJDVMq8AZfp4TjIWGeTsaufu4u
	UNiT8q3aUyUqIXAywYrVboouG8bYlnUWbx3VHwUrFFccy0JBlRTVBZznnqOn3Sg+xJRCscwBMWU
	F5VB2MLl80lBi/8JsTsBYush//KqSsRN7hY/34VYd2BKRRZiJSq7pjmP7JH9LTEK/Nefe92pmt0
	lHDz+2RMH5EQiZ49vTyoY9OI
X-Google-Smtp-Source: AGHT+IEnnBeTi4rkAq3RJvKv2sDTzPVMvHzLRXRbi8PGwwB6IaU0jmg6KgC+yuOAOUHizPIfNPeD9A==
X-Received: by 2002:a05:6000:1f84:b0:385:e90a:b7ea with SMTP id ffacd0b85a97d-385e90abbd6mr12256289f8f.3.1733307426515;
        Wed, 04 Dec 2024 02:17:06 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:740:b323:3531:5c75? ([2a01:e0a:982:cbb0:740:b323:3531:5c75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e391656csm12702156f8f.47.2024.12.04.02.17.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 02:17:06 -0800 (PST)
Message-ID: <f727834f-b178-4a85-aeae-54826cbbde42@linaro.org>
Date: Wed, 4 Dec 2024 11:17:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/9] crypto: qce - unregister previously registered algos
 in error path
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Thara Gopinath <thara.gopinath@gmail.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Stanimir Varbanov <svarbanov@mm-sol.com>, linux-crypto@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, stable@vger.kernel.org
References: <20241203-crypto-qce-refactor-v1-0-c5901d2dd45c@linaro.org>
 <20241203-crypto-qce-refactor-v1-2-c5901d2dd45c@linaro.org>
 <b3e5184d-19bc-45ed-92e3-a751842839b3@linaro.org>
 <CAMRc=Mc+hKeAwyvm_aaWe_r07iXuBMy0hRQrXSQjpy0irKzvMw@mail.gmail.com>
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
In-Reply-To: <CAMRc=Mc+hKeAwyvm_aaWe_r07iXuBMy0hRQrXSQjpy0irKzvMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03/12/2024 16:05, Bartosz Golaszewski wrote:
> On Tue, Dec 3, 2024 at 2:55 PM <neil.armstrong@linaro.org> wrote:
>>
>> On 03/12/2024 10:19, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>
>>> If we encounter an error when registering alorithms with the crypto
>>> framework, we just bail out and don't unregister the ones we
>>> successfully registered in prior iterations of the loop.
>>>
>>> Add code that goes back over the algos and unregisters them before
>>> returning an error from qce_register_algs().
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: ec8f5d8f6f76 ("crypto: qce - Qualcomm crypto engine driver")
>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>> ---
>>>    drivers/crypto/qce/core.c | 11 +++++++----
>>>    1 file changed, 7 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
>>> index 58ea93220f015..848e5e802b92b 100644
>>> --- a/drivers/crypto/qce/core.c
>>> +++ b/drivers/crypto/qce/core.c
>>> @@ -51,16 +51,19 @@ static void qce_unregister_algs(struct qce_device *qce)
>>>    static int qce_register_algs(struct qce_device *qce)
>>>    {
>>>        const struct qce_algo_ops *ops;
>>> -     int i, ret = -ENODEV;
>>> +     int i, j, ret = -ENODEV;
>>>
>>>        for (i = 0; i < ARRAY_SIZE(qce_ops); i++) {
>>>                ops = qce_ops[i];
>>>                ret = ops->register_algs(qce);
>>> -             if (ret)
>>> -                     break;
>>> +             if (ret) {
>>> +                     for (j = i - 1; j >= 0; j--)
>>> +                             ops->unregister_algs(qce);
>>> +                     return ret;
>>> +             }
>>>        }
>>>
>>> -     return ret;
>>> +     return 0;
>>>    }
>>>
>>>    static int qce_handle_request(struct crypto_async_request *async_req)
>>>
>>
>> Perhaps you can also use the devm trick here aswell ?
>>
> 
> I wanted to keep this one brief for backporting but I also think that
> scheduling a separate action here for every algo would be a bit
> overkill. This is quite concise so I'd keep it this way.

Sure understandable!

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

> 
> Bart


