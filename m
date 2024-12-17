Return-Path: <linux-kernel+bounces-448805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D933C9F45BA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E5EE188F0DA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25F91DA61E;
	Tue, 17 Dec 2024 08:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OZY/NElX"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B931D63C4
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734423094; cv=none; b=TrzU20cMaThGN3m2YUMxdQMqfKkG5VlR6CM8BDzR7aTPFRZaNAieZVDqeed1cvQNCWNr2+TLMZfBYTfU5UgVCnUzHPmf/LkbLMwCn9TrI5OP+ljOdWRyWvoh2mf+q9K+oWDLn3N8ddgN6ksNELzAoo9KtoWrMLDkD71CS/3eC/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734423094; c=relaxed/simple;
	bh=BwTdRkfL9p+CHVTFhPWYoUnq2tginRiXuuFRjW7ogK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QsccKdaS2tg2kHIfxyUUw00X72ufa89uk5k4zbNwSWs8y8/iq8MC8kefHpIY71JZlS/CtrRYMqPZOoKnz/Um6OOUMthRb28yTBoUlHclOIeA/moB27Df7venXSn5KqQUrnCt15AjxITyVzOYSK3BIvrXYhFMr38DT9wHbEcPgP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OZY/NElX; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43616bf3358so5791675e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 00:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734423090; x=1735027890; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nthmpXTtFMXj3N/ySisQvj0S19J6SBGsdVEyQ2k86vg=;
        b=OZY/NElXLvI/OKYcFLyKl0B59hjI5H0oARLBInOD6n8s5D/4opag2GBywqO52ghmzp
         5UqzNNQWp9YNphKrUF3wvcYWctGT6RFRtlelOPETWpsUF9F1oHe3ppzuwLwmbNecgw8F
         3xDVZJx8wJAlM8wAtI5DzQEs5KS9T9BMGBHi499UnQ8/tHNxIRDxjBREfEfEJ5xblpG5
         UMZh5a7bGXt70q0E39A4yi5lVpeBKjhJ9et9mgMoh5Ogww0+L3mrSb5xiLdyMvNhvGtJ
         /5NTW/OiTWKxYsNqHitfscDjefYYzFvFtwjCTpmMD92nGxCf8zQdp7B4/NyKPSwj7wmj
         RlzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734423090; x=1735027890;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nthmpXTtFMXj3N/ySisQvj0S19J6SBGsdVEyQ2k86vg=;
        b=lzCAlB2Z8mp3a+m1OlbgQ8+TPtEWuZnfnSvPMfjBEHAZXXRUk6v9tj4/Oj4IQMJgKn
         /qmTpxsAkgP0E64f4RPXr+Oxq2dJK23iQHJx4YMg3r2wj3MANb8m+tVpF/HvUFUjjlZ2
         PzAE7cCHhh0A7oNzjXLDW0WU1wy+R5Kd+1vUWfx0JQWq+SVMSb2DLG7JMqd9pfV9T4xV
         mQakzhbZjPbFr3VTeGR8Su04DM/HoX6D+jaTego6JP/QD19EW2BmA0YLZHElKWn9bKBM
         /IhUUBeBsAyb02H3LSBqVhTTTJrFlf+cuMGlN+OZMADULoHye0VNGiDdFokyeJve+RAE
         zXZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVi0VaNucyx/daits3cxNXNltM97RRxBWdO36iN8iZdkRYa+t5ZJPTYcupAwlYThvFV038q2QwfgJsoi+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBKVzqg3pA3WCeNwEf+H3I1gKVHdqeFFIdvaMbp4o9Xag8I0zf
	L0yR9hXLQEsAd5lcTphvmz1aS1s5Lio5gikut+fHKBaaxMo/cdKD1yOWTfFp9So=
X-Gm-Gg: ASbGncsZXHGOKCC8tHhJPvgfK1ipQS75B28fw0txOjpYmvBkpz2QHjrTWatWDClI19P
	mSDqTDIe0/v1CSTHW29LvARTnqEAtGv7CiWrhTjlu6PcGbVbp0N9ivMJLBTDLOFyPIy9XtEPmeU
	4cNCgKRaEnUuftwchR5ERUKRc5y3YAYOYVjrS2Pv2Nm1ZrLh/2Y7T7QogqAAT/dwCn/cL5UIxgL
	OL4Q2jAIlopM+5InIcdsptf3TfCkW8Yf0eW3hs405QWyWQD8lBButiDUUPg1ipVxSDBXyMLn0I4
X-Google-Smtp-Source: AGHT+IFNjMfCjYPMbwJa6u6I/a4umsR3FtryZ3WtTwR6Ct1skiAV9JApKQ+YQLcillNxT8neWTVriA==
X-Received: by 2002:a5d:5f88:0:b0:376:2e3e:e6d4 with SMTP id ffacd0b85a97d-3888e0acb25mr4663085f8f.5.1734423090293;
        Tue, 17 Dec 2024 00:11:30 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c801ad9asm10286086f8f.58.2024.12.17.00.11.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 00:11:29 -0800 (PST)
Message-ID: <07cc40a5-8b4c-4f5c-8ecb-cbc67b916858@linaro.org>
Date: Tue, 17 Dec 2024 09:11:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] arm64: defconfig: Enable STM protocol and source
 configs
To: Jinlong Mao <quic_jinlmao@quicinc.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Bjorn Andersson <quic_bjorande@quicinc.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241101084558.36948-1-quic_jinlmao@quicinc.com>
 <e7ca1f47-8ccd-44b4-bfdd-707a1f8aef13@quicinc.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
In-Reply-To: <e7ca1f47-8ccd-44b4-bfdd-707a1f8aef13@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/12/2024 08:47, Jinlong Mao wrote:
> 
> 
> On 2024/11/1 16:45, Mao Jinlong wrote:
>> STM is used for logging useful softevens from various entities.
>> With STM and TMC sink enabled, there will be more buffer size to store
>> the logs. STM source and STM protocol need to be configured along with
>> STM device for STM function refer to Documentation/trace/stm.rst.
>> CONFIG_CORESIGHT_STM is already added as module. Add Coresight STM
>> source and Protocol configs as module so that STM functions can be
>> used.
>>
>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>> ---
>> Changes in v5:
>> - Update commit message.
>>
>> Changes in v4:
>> - Remove Ftrace config.
>>
>> Changes in v3:
>> - update commit message.
>>
>> Changes in v2:
>> - select ftrace config explicitly.
>>   arch/arm64/configs/defconfig | 5 +++++
>>   1 file changed, 5 insertions(+)
> 
> Gentle reminder for the review.
No need to ping for this. It's pending deliberately - on you. If you
want this to be merged, you need to funnel it through SoC maintainer's
tree. get_maintainers.pl (explained also in SoC maintainer profile).

To be clear: I do not object this patch, but I also do not see that many
benefits in having it in defconfig, thus no ack from me.


Best regards,
Krzysztof

