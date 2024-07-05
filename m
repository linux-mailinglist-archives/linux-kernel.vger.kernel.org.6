Return-Path: <linux-kernel+bounces-242295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4F7928656
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 12:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 891E0284F5A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F67145B29;
	Fri,  5 Jul 2024 10:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u0Dp7u2K"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C891474B8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 10:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720173874; cv=none; b=i8gNDt9nSJLLYtDa6AQ8DNaiCwVwZSkCaJDJVe3s2VqDDF4eaf+/hdhL8betDS21F1QQTcIlmkDqCYhr6FQGFuoNgG/MRqw3E9Ju0fhAq240rpt413imvOtfhsGQI2ok9mk7MqKk4n76jzTmx9tlOKeoDuD3+/lEGYYhK4KMt5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720173874; c=relaxed/simple;
	bh=zPoycvBLjhR66XUzDoBH1CxwdETxsokS7Hz2a8Scgvs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=CzQg8WQMHDxG5Y8GRnmM0CalP3OxEIA39bTr+5IxP8YLTIHzH7vl2sNk5T86bx3qIpSeHHJlh7HGz5uyEEtydbR/QesDq25rxYwqq641zJyvp4Wegxau63AxwQz4QTIbiCpr36w30GfaLlTiL59DmTvv6ymndr86IOwS4vXI2I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u0Dp7u2K; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-426526d30aaso2668735e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 03:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720173870; x=1720778670; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UbCAcXarF28AQprPLdMta3JF6IOVP+8+qFcSHwrGOMo=;
        b=u0Dp7u2KMrBtApVpOkRqpy8H7XeGr8bRH8hijkYXr98l/2P9yI91rewy2VzIlmD/5M
         ODjnT4ikD+h9GKwpcT7qDVibjpMwuh5g7a/iEQe4pT8lAZZxwNeYoA8CVnZFrsULwk2Y
         fGnO1DzNIJvEcWsoDLi9PUa/EyYrAlDqmwlIt/7idiln8tv3+JZVhFHS+/BvHq45WYM+
         Vl5v+ucUV8ORpMkeytUg9gM9UI/6vZSAJyuLi67VxDiAG+PywvKBdzLBOJb31wkV3JkN
         QE35O54qGt6mIL1SiF4z5E+nNXvt5QUI9t+ggS2+A0sOJAvS7UKhsUTa8mtRuavzqdIk
         qnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720173870; x=1720778670;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UbCAcXarF28AQprPLdMta3JF6IOVP+8+qFcSHwrGOMo=;
        b=u2deKS8Iwe3OudaGtvLAnYSoDvD9glew2lIycto9UqCt2ZfawgEP/3ne03lGT27Bep
         4GBBEi8dhthwYtgkiJOhBWgk/7M8MJ2+T3wBKdouAvyKO0pwnLBNeTp7ey3nI36HAXaG
         ditzYBPGGvnCCMwuvxlM0yfiPK6M3LNABhoAZkDemLCkSqi10LWPe9a2mYeXhcQuYvPQ
         Sa3pG0JJnfRk1yX9xXjTwEBStOMehrTEnpYnfmj/LHK7gnjSvUbjDYnWsINeyOT2h0Oj
         h191KZ9EqrI0q4tDHcVjlGdtW0+P6fyYAhq085FnBeEnoiwrTt254Y2jhxLjHSbKCGjr
         mSqw==
X-Forwarded-Encrypted: i=1; AJvYcCVPClbS0L0paklivMoXai3uCbG7gCvC+CWz1g5gbGtUlgW87nMFWcwwTBObFxlIHcjv8n9gNzyHF001oK2HqAsNdb+tfDcUG4Ii2cX9
X-Gm-Message-State: AOJu0YxFcNs70qXmrdzAaOantJeYyfrbeZRAGxm3KEBfJ8ROKtL4Uxa+
	SLp5fZir4cS0bVz7ntTevDp6EbFAZxJAZ9aKgyhOHSyA3SRm41CcLD096FQPnmE=
X-Google-Smtp-Source: AGHT+IHbi2e7o5MJ57LqdFk1YRbNnDm6GdtbR0DxY6a9utZXNSBkFzBn5q73IFqENACWFO9t82KPoQ==
X-Received: by 2002:a05:600c:5116:b0:425:6851:8172 with SMTP id 5b1f17b1804b1-4264a3d8045mr31874165e9.3.1720173869478;
        Fri, 05 Jul 2024 03:04:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:9a73:20dd:5505:b164? ([2a01:e0a:982:cbb0:9a73:20dd:5505:b164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d510bsm55867875e9.3.2024.07.05.03.04.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 03:04:29 -0700 (PDT)
Message-ID: <78384e57-4139-47c9-ae5a-480c0d6b9daa@linaro.org>
Date: Fri, 5 Jul 2024 12:04:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 5/6] drm/sti: hdmi: drop driver owner assignment
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20240330203831.87003-1-krzysztof.kozlowski@linaro.org>
 <20240330205722.93801-1-krzysztof.kozlowski@linaro.org>
 <20240527144700.GC713992@gnbcxd0016.gnb.st.com>
 <77b4e4ad-2b1e-4b6d-bc3b-0c7b339bc295@linaro.org>
 <f207b481-f530-4f54-a482-218908869050@linaro.org>
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
In-Reply-To: <f207b481-f530-4f54-a482-218908869050@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/07/2024 11:59, Krzysztof Kozlowski wrote:
> On 04/06/2024 15:18, Krzysztof Kozlowski wrote:
>> On 27/05/2024 16:47, Alain Volmat wrote:
>>> Hi Krzysztof,
>>>
>>> thanks for your patch, sorry for the delay.
>>>
>>> On Sat, Mar 30, 2024 at 09:57:21PM +0100, Krzysztof Kozlowski wrote:
>>>> Core in platform_driver_register() already sets the .owner, so driver
>>>> does not need to.  Whatever is set here will be anyway overwritten by
>>>> main driver calling platform_driver_register().
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> ---
>>>>
>>>> I forgot two drivers.
>>>>   drivers/gpu/drm/sti/sti_hdmi.c | 1 -
>>>>   1 file changed, 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
>>>> index 500936d5743c..b0d84440a87b 100644
>>>> --- a/drivers/gpu/drm/sti/sti_hdmi.c
>>>> +++ b/drivers/gpu/drm/sti/sti_hdmi.c
>>>> @@ -1485,7 +1485,6 @@ static void sti_hdmi_remove(struct platform_device *pdev)
>>>>   struct platform_driver sti_hdmi_driver = {
>>>>   	.driver = {
>>>>   		.name = "sti-hdmi",
>>>> -		.owner = THIS_MODULE,
>>>>   		.of_match_table = hdmi_of_match,
>>>>   	},
>>>>   	.probe = sti_hdmi_probe,
>>>> -- 
>>>> 2.34.1
>>>>
>>>
>>> Acked-by: Alain Volmat <alain.volmat@foss.st.com>
>>
>> What does this ack mean? You are the maintainer, so what is supposed to
>> happen now? If maintainer does not take patches, then the DRM STI looks
>> orphaned.
> 
> +Cc Neil, Dmitry,
> 
> I pinged and pinged and wanted some sort of clarification here but one
> month passed and nothing was clarified.
> 
> I could be understanding the DRM process wrong, but if no one picks up
> trivial cleanups for 1.5 months, then to me subsystem is orphaned. I
> will send respective MAINTAINERS update.

Let's do that, if Alain doesn't take his own patches that were reviewed
then it should either be orphaned  or moved to drm-misc.

Neil

> 
> Best regards,
> Krzysztof
> 


