Return-Path: <linux-kernel+bounces-389144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D72049B6917
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52B961F21D3D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F4A2141C7;
	Wed, 30 Oct 2024 16:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PT4yAgI4"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33B41E573B
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 16:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730305579; cv=none; b=pNjjMDV0RrDNrEB9lwBvylAcYp7c4oWy7Gnho/bg4T7goh4NnmTqw5yhNXutyvCBtIsMwTCL58OurAj3riKcOX5a4PHru26F2DI1QTryz/EJQe0l+7QUoC59nDXh4iyaiWveQWlWe/J/xQ9lQ/p5QRDqZ2LkVOIO4dycdyy+GFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730305579; c=relaxed/simple;
	bh=sDJYx4DfBWZJ9NCFQ1OJHLVtnyW937UdYk2MBzJwE4M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rkVXy5umnrfmFnksNij8lTvUQhnhq87j6iGmUULIJHhDZ9FB15X97bhIxxzCowRl+M9T8hkZoXF54tzIqDY/1YoXexEg1nBfIKDwnhSgCAhsR2W+i95Rydw04Xd7DjWejuhuwxKDGoWtS2bjs83XXDEbAe/Q7AsjsCAgm+jKyOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PT4yAgI4; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d518f9abcso37667f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 09:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730305575; x=1730910375; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nRQIzE56a78f3UCXKUKwjgBDwr7TVubijgfr1LJ07ho=;
        b=PT4yAgI4CXrX1ndP+ksIHOvq9OLcuMtcTZXnkMMO5Qd5Qbd9gG0JNAOQIa4ckk69LR
         LWnCfhygf+700CEvmzC749nGzAFnsX0l1S3BkhyGOzsW71foOxEHSayKpMNDqNB967XR
         ALNGVVhuYU0uU9yzoIB71z8P7ma2x8ty5G177RSA/XXVcuOcD1US9ZXJoiv8XKI6RKyn
         GnW5MQwtH33zW5RwobOjdnZDML6fkilNJOmnkGnYEPlboWfwGL5gtXjDm8Zw2ExVFOdO
         +8OV8hsm2TUyDiWFjFnWJrP+DhSzLYyP0T7YXlAWlvX4quYUJ/eqTLjupE13AlrzTYr/
         803A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730305575; x=1730910375;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nRQIzE56a78f3UCXKUKwjgBDwr7TVubijgfr1LJ07ho=;
        b=O+KW66gkuH+hY6PHtfJSNnlW9iqaRqVQFo4Cptk1a1CFgjYEvlb2lPx8Ewia6eFN3h
         E2YxcyI8ozWBg4ZFNfQ2RZyMnUmX0RFoEwsJRpuQiyp0k1lSt98eMAKqF02V4O56JlIn
         z4p+oX6pOOvWJ27HVjR4i6nDadDab3Z68Oe5PYEenraoHYbMruEWxJaedJtGChMJlnn+
         Oz2/oN0PutfKmxB/eEAkEOqaLS6e1iIn9hKbv6mQFlgHqL4kXUNTnCXcKqoRKIUPzAiC
         FLYtbdUP+VssC7gT9cHxRySJzcyFCqRMSqo86ATW1C4tQaqkuHwREAJw1+zUfqLNDRiC
         q+gg==
X-Forwarded-Encrypted: i=1; AJvYcCWQ8uBdOXr8xupUsPzne17YU9lDjf8SWvJZtWk8OIan3rOsXWXexGaHAuVr4CJmAQ9SrRjiqmpAQw3Hdn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7KefwD9aMOE34dg4o+WBfWZqLE5ZA/Erq4FawK7csHSKm9vk0
	Haj1jy5P+/LzvutIue4KPT9QUFHJ5XGWdfVxJ/BuddkCXr+TTUWCRRL5TQmx6tI=
X-Google-Smtp-Source: AGHT+IGQ8G7g4zNKZcy/h19K3HYfsFs0a2mnCjVa1TLoKI8avaYE7I8PLXucpWqzh2b6kF4aX23e1w==
X-Received: by 2002:adf:e304:0:b0:37d:3a2d:8577 with SMTP id ffacd0b85a97d-3806115a2e6mr12142255f8f.33.1730305574942;
        Wed, 30 Oct 2024 09:26:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:201:dd6:9287:c715? ([2a01:e0a:982:cbb0:201:dd6:9287:c715])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b479a4sm15664996f8f.55.2024.10.30.09.26.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 09:26:14 -0700 (PDT)
Message-ID: <ea885b7d-e44b-4fdd-bada-ae368bb7c1b7@linaro.org>
Date: Wed, 30 Oct 2024 17:26:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/panel: leadtek-ltk050h3146w: transition to mipi_dsi
 wrapped functions
To: Tejas Vipin <tejasvipin76@gmail.com>,
 Doug Anderson <dianders@chromium.org>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 quic_jesszhan@quicinc.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20241026035928.183454-1-tejasvipin76@gmail.com>
 <CAD=FV=Vps5vWD72O_kYhuKudduYed41+tZrVRB6x+FiaZrm-EA@mail.gmail.com>
 <c389ea3e-70cb-46c5-8cf1-878a99f771ec@gmail.com>
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
In-Reply-To: <c389ea3e-70cb-46c5-8cf1-878a99f771ec@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30/10/2024 08:24, Tejas Vipin wrote:
> 
> 
> On 10/29/24 12:24 AM, Doug Anderson wrote:
>> Hi,
>>
>> On Fri, Oct 25, 2024 at 9:00 PM Tejas Vipin <tejasvipin76@gmail.com> wrote:
>>>
>>> @@ -418,79 +398,42 @@ static const struct ltk050h3146w_desc ltk050h3146w_data = {
>>>                  MIPI_DSI_MODE_LPM | MIPI_DSI_MODE_NO_EOT_PACKET,
>>>   };
>>>
>>> -static int ltk050h3146w_a2_select_page(struct ltk050h3146w *ctx, int page)
>>> +static void ltk050h3146w_a2_select_page(struct mipi_dsi_multi_context *dsi_ctx, int page)
>>>   {
>>> -       struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
>>> -       u8 d[3] = { 0x98, 0x81, page };
>>> +       u8 d[4] = { 0xff, 0x98, 0x81, page };
>>>
>>> -       return mipi_dsi_dcs_write(dsi, 0xff, d, ARRAY_SIZE(d));
>>> +       mipi_dsi_dcs_write_buffer_multi(dsi_ctx, d, ARRAY_SIZE(d));
>>
>> FWIW: the above might be slightly better as:
>>
>> mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x98, 0x81, page);
>>
>> That would make it more documenting that the 0xff is the "cmd", has
>> fewer lines of code, and also gets the array marked as "static const"
>> which might make the compiler slightly more efficient. ;-)
>>
>> Not really a huge deal, though.
>>
> 
> I did try this initially, but got an error because of page not being a
> compile time constant. Not sure how I should handle this.

I think the current version is fine:

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

> 
>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> 


