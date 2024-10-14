Return-Path: <linux-kernel+bounces-363534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EA099C39D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBA8EB222AC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3D7153824;
	Mon, 14 Oct 2024 08:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="plXLBuKR"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A05614EC5D
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728895265; cv=none; b=tP+Tuj2at4dqWOvK01l5adIY6DssBfvhiSHC6l5uJ1BnEU1rx+dNFQh+s2afQAag1CpGA2qjuzhddBUjsK0Ras2o9AWe6o/MAUJLUQH/Ulw/HyeX3OHYb1OyW8ZNBrMCQFHvnfUe7YK7jBD4Ef/G9be6kxG69eCY+bZaMJE7dDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728895265; c=relaxed/simple;
	bh=gMRiss8+URvBCdZN2fsxCivFSZQB4ggd40oQLzHSYG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ufhxXK6d/8WiE4WdoyYnnYM5u7dSZygz3zavKCsm+UAZNpmQIIfm9Fajo3VIbnDOUF97CirSRx/Ezt/Z27sEYFI3NCu2IkO1UKkrvbv8Z93QKD7BEYC5rMbbi7OYOEEixyTZye00JixWwvLLQnq/QRGhGcGV+9Mcm7TmSwtUJ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=plXLBuKR; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c933d5bdf1so847910a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 01:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728895261; x=1729500061; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LQjuCqjuaTofTHyH3yd8Ja9w1U9h0/UES4YgfGdXExE=;
        b=plXLBuKR6cotXCg0qtm7JmNNLMRNhYSlyY03uplfdHLah0UufiUfbagKBTbNEzwG36
         ZTW4r7Fj2N9dmmyqI5L2NKFg8QhISERNgPQS+5Gn2lFBzeBnmtentJkQ7x70kQmRXwpu
         wYdgCAJ9vKQSi1R+b4MEwaLRk53w7LfIUwJHncq2rHzjP4oNxu1y43ZrG9AcPTm2v226
         hbDQvRZ3kSTckFl9l+rY4AXPe7zhY64seuEWSPXBtS1a2MtIWwuLMoRDdanhD6hgMwMu
         MOhQqXEGpt4vcTico0nM8JdOmnBEAtlG0Bn3Ae5vUJQVMLtPif3w9upTDgS+jOgcidhc
         bllw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728895261; x=1729500061;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LQjuCqjuaTofTHyH3yd8Ja9w1U9h0/UES4YgfGdXExE=;
        b=DfbCxRjTpvdbCk0xv31cYg8wG7KW9hF3Xkvv+KGNbRV6A/2OrGoZIWuSd7k5tJ6NMr
         mW8O1Uxk6+l4+CXmz6LJsiFX6cVdyIhuch8+RTHuPo1MoaUC9Rgre8OsWb8yCees4tr5
         b7IxDbOv4zZkKHCteiTAUVYYv7JB+uDxmw4fOjdoINyKHUXtZhi8os/FqI+jP5C/b4CH
         MKOOlW0DmrpB7qMydOtT6cWUsz174H7ZiREwf8BUxsiqcrSY6j/Qn5MMYgFUu9/ClSvl
         pf7Qlv9wNFfvJTuzP/7aImRu+chlRZYwa/MZhlMtZvNVGVo0vsI/i9qJUqm8hHACShAe
         kvnw==
X-Forwarded-Encrypted: i=1; AJvYcCXZS0a+PzYw7LiKRRFXaXmRkjmeDO91nkg0BRXuFJZkLgnRQ8pj85e1PhuZ+WL1/z+U8+gTbC/EIkK3GnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6s4n6gD7gZIcBlnpT6J9NPlqYRTD4+aI25y/ImbqJdtN0Hztv
	pc1hbTm8fk9oehj1R1nWcpteyNie4aZALI8qfkTnOhBag7mWncORfxAUMurQ2MQ=
X-Google-Smtp-Source: AGHT+IHAjRAMNoLt6D9gNT2mzUONw6jajPJtcqK2z0xcVvyXlU3mFFqhadg062dcEDDHFQHgOScZlQ==
X-Received: by 2002:a17:906:3941:b0:a99:f3a5:a310 with SMTP id a640c23a62f3a-a99f3a5a49fmr218095666b.4.1728895260734;
        Mon, 14 Oct 2024 01:41:00 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a16dfafbcsm54195766b.137.2024.10.14.01.40.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 01:41:00 -0700 (PDT)
Message-ID: <b0d622cd-0d58-44e8-b168-8c69e46859a7@linaro.org>
Date: Mon, 14 Oct 2024 10:40:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] thermal: scope/cleanup.h improvements
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Amit Kucheria <amitk@kernel.org>,
 Thara Gopinath <thara.gopinath@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li <tiny.windzz@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20241010-b4-cleanup-h-of-node-put-thermal-v4-0-bfbe29ad81f4@linaro.org>
 <CAGXv+5FgLQMG=tA6d_gT71j5ZxWPa56rW1UmfUgKot4uCj56+g@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzTRLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+wsGUBBMBCgA+FiEE
 m9B+DgxR+NWWd7dUG5NDfTtBYpsFAmI+BxMCGwMFCRRfreEFCwkIBwIGFQoJCAsCBBYCAwEC
 HgECF4AACgkQG5NDfTtBYptgbhAAjAGunRoOTduBeC7V6GGOQMYIT5n3OuDSzG1oZyM4kyvO
 XeodvvYv49/ng473E8ZFhXfrre+c1olbr1A8pnz9vKVQs9JGVa6wwr/6ddH7/yvcaCQnHRPK
 mnXyP2BViBlyDWQ71UC3N12YCoHE2cVmfrn4JeyK/gHCvcW3hUW4i5rMd5M5WZAeiJj3rvYh
 v8WMKDJOtZFXxwaYGbvFJNDdvdTHc2x2fGaWwmXMJn2xs1ZyFAeHQvrp49mS6PBQZzcx0XL5
 cU9ZjhzOZDn6Apv45/C/lUJvPc3lo/pr5cmlOvPq1AsP6/xRXsEFX/SdvdxJ8w9KtGaxdJuf
 rpzLQ8Ht+H0lY2On1duYhmro8WglOypHy+TusYrDEry2qDNlc/bApQKtd9uqyDZ+rx8bGxyY
 qBP6bvsQx5YACI4p8R0J43tSqWwJTP/R5oPRQW2O1Ye1DEcdeyzZfifrQz58aoZrVQq+innR
 aDwu8qDB5UgmMQ7cjDSeAQABdghq7pqrA4P8lkA7qTG+aw8Z21OoAyZdUNm8NWJoQy8m4nUP
 gmeeQPRc0vjp5JkYPgTqwf08cluqO6vQuYL2YmwVBIbO7cE7LNGkPDA3RYMu+zPY9UUi/ln5
 dcKuEStFZ5eqVyqVoZ9eu3RTCGIXAHe1NcfcMT9HT0DPp3+ieTxFx6RjY3kYTGLOwU0EVUNc
 NAEQAM2StBhJERQvgPcbCzjokShn0cRA4q2SvCOvOXD+0KapXMRFE+/PZeDyfv4dEKuCqeh0
 hihSHlaxTzg3TcqUu54w2xYskG8Fq5tg3gm4kh1Gvh1LijIXX99ABA8eHxOGmLPRIBkXHqJY
 oHtCvPc6sYKNM9xbp6I4yF56xVLmHGJ61KaWKf5KKWYgA9kfHufbja7qR0c6H79LIsiYqf92
 H1HNq1WlQpu/fh4/XAAaV1axHFt/dY/2kU05tLMj8GjeQDz1fHas7augL4argt4e+jum3Nwt
 yupodQBxncKAUbzwKcDrPqUFmfRbJ7ARw8491xQHZDsP82JRj4cOJX32sBg8nO2N5OsFJOcd
 5IE9v6qfllkZDAh1Rb1h6DFYq9dcdPAHl4zOj9EHq99/CpyccOh7SrtWDNFFknCmLpowhct9
 5ZnlavBrDbOV0W47gO33WkXMFI4il4y1+Bv89979rVYn8aBohEgET41SpyQz7fMkcaZU+ok/
 +HYjC/qfDxT7tjKXqBQEscVODaFicsUkjheOD4BfWEcVUqa+XdUEciwG/SgNyxBZepj41oVq
 FPSVE+Ni2tNrW/e16b8mgXNngHSnbsr6pAIXZH3qFW+4TKPMGZ2rZ6zITrMip+12jgw4mGjy
 5y06JZvA02rZT2k9aa7i9dUUFggaanI09jNGbRA/ABEBAAHCwXwEGAEKACYCGwwWIQSb0H4O
 DFH41ZZ3t1Qbk0N9O0FimwUCYDzvagUJFF+UtgAKCRAbk0N9O0Fim9JzD/0auoGtUu4mgnna
 oEEpQEOjgT7l9TVuO3Qa/SeH+E0m55y5Fjpp6ZToc481za3xAcxK/BtIX5Wn1mQ6+szfrJQ6
 59y2io437BeuWIRjQniSxHz1kgtFECiV30yHRgOoQlzUea7FgsnuWdstgfWi6LxstswEzxLZ
 Sj1EqpXYZE4uLjh6dW292sO+j4LEqPYr53hyV4I2LPmptPE9Rb9yCTAbSUlzgjiyyjuXhcwM
 qf3lzsm02y7Ooq+ERVKiJzlvLd9tSe4jRx6Z6LMXhB21fa5DGs/tHAcUF35hSJrvMJzPT/+u
 /oVmYDFZkbLlqs2XpWaVCo2jv8+iHxZZ9FL7F6AHFzqEFdqGnJQqmEApiRqH6b4jRBOgJ+cY
 qc+rJggwMQcJL9F+oDm3wX47nr6jIsEB5ZftdybIzpMZ5V9v45lUwmdnMrSzZVgC4jRGXzsU
 EViBQt2CopXtHtYfPAO5nAkIvKSNp3jmGxZw4aTc5xoAZBLo0OV+Ezo71pg3AYvq0a3/oGRG
 KQ06ztUMRrj8eVtpImjsWCd0bDWRaaR4vqhCHvAG9iWXZu4qh3ipie2Y0oSJygcZT7H3UZxq
 fyYKiqEmRuqsvv6dcbblD8ZLkz1EVZL6djImH5zc5x8qpVxlA0A0i23v5QvN00m6G9NFF0Le
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAGXv+5FgLQMG=tA6d_gT71j5ZxWPa56rW1UmfUgKot4uCj56+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14/10/2024 10:32, Chen-Yu Tsai wrote:
> On Fri, Oct 11, 2024 at 2:06 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> Changes in v4:
>> - Patch 2: rewrite, significant change: kzalloc() also with
>>   scoped-handling so the entire error handling could be removed.
>>   Due to above, drop review-tags (Chen-Yu, Jonathan).
>> - Add Rb tags for other patches.
>> - Link to v3: https://lore.kernel.org/r/20241008-b4-cleanup-h-of-node-put-thermal-v3-0-825122398f71@linaro.org
>>
>> Changes in v3:
>> - Rebase, because there was bigger rework in thermal code.
>>   This made two patches obsolete, but brought new one:
>>   1/6: thermal: of: Simplify thermal_of_should_bind with scoped for each OF child
>> - Link to v2: https://lore.kernel.org/r/20240816-b4-cleanup-h-of-node-put-thermal-v2-0-cee9fc490478@linaro.org
>>
>> Changes in v2:
>> - Drop left-over of_node_put in regular exit path (Chen-Yu)
>> - Link to v1: https://lore.kernel.org/r/20240814-b4-cleanup-h-of-node-put-thermal-v1-0-7a1381e1627e@linaro.org
>>
>> Few code simplifications with scope/cleanup.h.
>>
>> Best regards,
>> Krzysztof
>>
>> ---
>> Krzysztof Kozlowski (6):
>>       thermal: of: Simplify thermal_of_should_bind with scoped for each OF child
> 
> I couldn't find this in my inbox. But since I already reviewed all the other
> patches, and I looked at this one on lore, consider the whole series is now

Sorry for that. Your wens@csie.org was cc-ed, but not the chromium. If I
respin, I will add both on Cc.

> 
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>


Best regards,
Krzysztof


