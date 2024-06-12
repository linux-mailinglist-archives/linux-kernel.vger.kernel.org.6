Return-Path: <linux-kernel+bounces-211390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFD6905107
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FF82B20C2B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7D516F0C7;
	Wed, 12 Jun 2024 11:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TBc1DMwB"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C3812E5E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 11:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718190235; cv=none; b=dKDe8KWFelmDQltfvExPzm0HMMmETBacNt/jirq9R1GAqntCKA68mwv7+JiVZGaREWZVHe9jOIYdd8pd/z+MZGc299bqcxrc35UThBYdCInXPuqEJBpizCg8FPN2gqn1U2dq4Cr+l5q67tAFC+oSpbiFTJAvJSVE+YtMhYAX1Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718190235; c=relaxed/simple;
	bh=HYh3s1ct3Rad1dyAm/HGXS8O5+sK0UyYD20gm07rQ0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C4Gz/BOxKvAIgCOTjTXmbiq40S3gNwSS4ZPQF8h7dtGDvZrUgpHqBVkSIp5tpokRsIyC/UoqA2HCLdnrYxOPYtCXeaPy9LWEGfcZTa1rfWG+x2hJKbG8gzkFRXuqCCsZ1bQugRNuP22fjVctIw3xTVjNLY4cIJZ2aBgUHvaYexQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TBc1DMwB; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-421d32fda86so31569565e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 04:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718190232; x=1718795032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Yzx68WXQPcRHZuPL6yk6giuAj4gsGRC/XQ0A6Em3Yxc=;
        b=TBc1DMwBofskpQZ69tlT0LFWiSSnQngn0savu6fKF0AyiwmO4jJd4tpkxiqE3fQ2F2
         ghM7qL9H1sXFnwPVXjsRU5pB3cQDIpOpJeWLxecuCBJkaCU/VdkMT5UhLHPS6eVNtx8b
         ewwKGGvJs9AtsKsa3/q69zweOIluSxl6RV1OiuV+TJBE6140AwVrZU1lf9TGC9MQpLmQ
         M/VJK4q7+NOFaGgN5Rh+5C0adSuwadq3Ld6CG2mMIT/GMMBLOseZPAom07FHPEmmq+Uf
         azD2TQKl7SwYSdZWugo1Hti+xMygwBxCelSgEo6L9jv4INy23t7CA4GsOs46rZ7FuMXT
         sWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718190232; x=1718795032;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yzx68WXQPcRHZuPL6yk6giuAj4gsGRC/XQ0A6Em3Yxc=;
        b=MRw+iEbZNbGeumTcPxi8HwNpqJOLj0xCvZt1Yo3F00YeRYU64csMiTtPTOIW493tCb
         FVNtWtETQzzcbCId61cHzsxFY2DR7vcM4t+VPqpih/6ABlk8Jj+rRgtgzo0kPf8kfOF7
         7Dod5FoLuQ8fJEgOTptt6Hy/epL7pezA8PVJd76+AyxvbMh9fhCVuUjNeiJj/6qyouph
         f0GOhlslSiqKaVfQBMTwsSOQ+QCyDspid/gvObEc3OuB0hjv1cG4kartNBdTDhf+n/kL
         GTmulfirmg4/AdeevixzWJGDl/nFwkkZwkfVMEAynMEBCUnxZbyWOZf9Ey9VsE7D/6te
         ihBw==
X-Forwarded-Encrypted: i=1; AJvYcCXwMtUfQsPRtjCol4cBhI7W2ifKBZmCY4FwOyBVBUqFQVrxw3EbnnJsuz33vOS9NUEFuXTncysnwvZnK/lAZIwb77GqZOvV+IQoLI6N
X-Gm-Message-State: AOJu0YzxolcqH71A3XDadEqT1U857ciwVFhypTYCc+tnjRXDgAF34pgv
	B1/htfoyHyiCM8aBlsV2QaT7IOcW+a3NFCYPovOdWj/9nOhbt/pewGAP/JCRCDI=
X-Google-Smtp-Source: AGHT+IF0V8Qw+m0PU9JVMz2gUMKV4+1qOaV6OTsZ/41uvLlkeRW55Q7/5QUW8p/AgwkicXhRoSAAvA==
X-Received: by 2002:a05:600c:42c4:b0:422:6755:17de with SMTP id 5b1f17b1804b1-422867c90f9mr14753155e9.41.1718190232062;
        Wed, 12 Jun 2024 04:03:52 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422899b0cdbsm12280665e9.0.2024.06.12.04.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 04:03:51 -0700 (PDT)
Message-ID: <7ba55f65-8f3a-4c4b-8985-c89a1c35e2ea@linaro.org>
Date: Wed, 12 Jun 2024 13:03:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: vt8500: replace "uhci" nodename with generic
 name "usb"
To: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240423150728.91527-1-sheharyaar48@gmail.com>
 <f60aac7f-dbba-4cba-8bb6-302b5c911b8c@linaro.org>
 <CAHTLo_=Gg-KN2zOtjOBCxQURq+Ap913Miph2FMhvkoV+GybFNA@mail.gmail.com>
 <106b6911-3097-487e-85db-f8de5958adcb@linaro.org>
 <CAHTLo_kf5+3hW1NytA7tD64MSFOUEfkb71cNARkHb95Qhm=W2Q@mail.gmail.com>
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
In-Reply-To: <CAHTLo_kf5+3hW1NytA7tD64MSFOUEfkb71cNARkHb95Qhm=W2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/06/2024 12:50, Mohammad Shehar Yaar Tausif wrote:
> On Wed, Jun 12, 2024 at 1:44 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 15/05/2024 06:53, Mohammad Shehar Yaar Tausif wrote:
>>> On Tue, Apr 23, 2024 at 8:46 PM Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 23/04/2024 17:07, Mohammad Shehar Yaar Tausif wrote:
>>>>> Replace "uhci" nodenames with "usb" as it's generic and aligns with
>>>>> the schema binding.
>>>>>
>>>>> Signed-off-by: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
>>>>> ---
>>>>>  arch/arm/boot/dts/vt8500/vt8500.dtsi | 2 +-
>>>>>  arch/arm/boot/dts/vt8500/wm8505.dtsi | 2 +-
>>>>>  arch/arm/boot/dts/vt8500/wm8650.dtsi | 2 +-
>>>>>  arch/arm/boot/dts/vt8500/wm8750.dtsi | 4 ++--
>>>>>  arch/arm/boot/dts/vt8500/wm8850.dtsi | 4 ++--
>>>>>  5 files changed, 7 insertions(+), 7 deletions(-)
>>>>
>>>>
>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>>
>>>
>>> Hi,
>>>
>>> Is there any further feedback or update for this ? This patch is not
>>> yet merged but the related dt-binding patch that has been merged :
>>> https://lore.kernel.org/all/20240423150550.91055-1-sheharyaar48@gmail.com/.
>>> I understand that this is a trivial patch and the maintainers may be
>>> busy with important work.
>>
>> I don't see you Cc any maintainers, so no one will pick it up.
> 
> Sorry for the mistake, I used b4 and it gave me this list of
> maintainers for the patch, the other recipients were commit_signers.
> Please guide me for my next steps. Should I add them to the list 

Uh, you are right. The platform got orphaned.

I'll take the patch.


Best regards,
Krzysztof


