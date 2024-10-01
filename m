Return-Path: <linux-kernel+bounces-345818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A70998BB79
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EC661C23659
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACDC1C1725;
	Tue,  1 Oct 2024 11:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SY4DzbBC"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24011BF804
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 11:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727783074; cv=none; b=lGf4c/HoMz8GMuNt22NPeggVgWeROysPKnoeDVrwdhb4GONVJSoQv4Mc4k76CfGo3GHUvDuCm/4mh2pYSECP/ItBgUudjUKayIdzFAu0h2iPgONaP3y42C740jX1mhr2ClRTmArjFJFHWX4N8ueOMe4nOJ3P7WFJdYQH0F4d9Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727783074; c=relaxed/simple;
	bh=UfCZ5OSllqSeXGlaYqhvmmSzhNtxhix8wAxk4b0oSdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M9EvKVZ3JKAc88bRNu/7LE4Te2ql6l0WqmOy57mlMrWgcLaWmv58fPLLfuPVnJ/+xjyD4nULj519qKnSEttBWweonY+lbwNEJY6Wo3yIm6TzuGOml8L+D0eM+0vGuPmegvKWG9UDeWApEFotALwaWeCIrW4P8WoBYMKq+CxVOls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SY4DzbBC; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42ca5447142so7447005e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 04:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727783069; x=1728387869; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u0xt74XDtLYLrzwMux2kzWqyPPKPQra8xynuSJjZWCI=;
        b=SY4DzbBCW8JE3dzrcEMqZP9Y+o0QKwbxZkgpCpzZVnRo8gGE/v6a1iyUgISuLoCZ6v
         mVZLdVQR8N3lA13jlgak1JGXZs++fQsJmcKQC9Zo6wP2kptjspVUlHTIKxKr/4CYYrSB
         3o26IsMp3BOVwTf0C5QfqlOidM2oxpfBk65X67/p+bqCeYx/youfj2bsiLnit/8QCQyH
         d01VcUnggT8dcJqbA4VerWoARm2yFSHss3C1HUMj/CMvLKO3qDzPHaZq9OuI+8O1kbN5
         HRa+kUsYsKRFQh+ahKewCLIpWzP2trWw/vwTyI8QnZojdhvs+2h3EPI2nvF2NW69UK1W
         GWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727783069; x=1728387869;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u0xt74XDtLYLrzwMux2kzWqyPPKPQra8xynuSJjZWCI=;
        b=m1oWLiiv1DWW2gGNyVKn0mVvmIKJ7TsLQZrEBRWfZ3DvPmPjQDKGoBIIgmoUvMdGIK
         QxDvyRbROeDr0jMuqRX5+BOWuA5wgfkqHjLSVV5lbh6ePbe2hN+kG6CnQ+xJYPjre5yr
         T6qtJtvVFmcsMaDiVnN1He+sFewkVg8XAI6aZYa4ibYham88TOHS4SZbB/gm7g3pk+LN
         Dp7+mr/jgtTDO24XA14UpCuKsM6ydm85yo39icoPclSIlelNJbWzqgApmdcENJDXfU31
         CVjy+WnIa5euF+qVvRJYORShxHR70VM+Ztzp2rvqZZpTt8twU7bNO4jVSdOOOE475HPb
         ozPw==
X-Forwarded-Encrypted: i=1; AJvYcCXc2q0B4I0XU6Cj0YbJC/Guzme59ta+eCQjHik0Ca1JEnouB0CB+RPSMZxZYYfvoBPGNSJQFuKevGeftAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXrIp+wpe/MHngKxqfWC+dbdq2PUxxiloB9uGCRtmVSzxtIBiY
	1Y2EfrXhNyIre+Axc7dqV3F81yOvFq21jTwyNmJghL6g/Wb0OYby/wrpHwog2/A=
X-Google-Smtp-Source: AGHT+IHtoLqojStvAJOJ7nyS7a/BdZb7ENOyCHLj5dQfWmE97We1en6aMHdLyrXhGV7uqMLcNZscrg==
X-Received: by 2002:a05:600c:350f:b0:42c:ba61:d20b with SMTP id 5b1f17b1804b1-42f58416273mr51174925e9.3.1727783068944;
        Tue, 01 Oct 2024 04:44:28 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd57427fbsm11535366f8f.100.2024.10.01.04.44.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 04:44:28 -0700 (PDT)
Message-ID: <e009fba7-7881-433a-9e33-f4c5f9d0fd86@linaro.org>
Date: Tue, 1 Oct 2024 13:44:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: microchip: sam9x7: Add missing usart-mode
 property
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>, claudiu.beznea@tuxon.dev,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 conor+dt@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240930202639.37606-1-jihed.chaibi.dev@gmail.com>
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
In-Reply-To: <20240930202639.37606-1-jihed.chaibi.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/09/2024 22:26, Jihed Chaibi wrote:
> Add the atmel,usart-mode property to UART nodes in Microchip SAM9X75
> boards' device trees (boards which inherit sam9x7.dtsi). This ensures
> compliance with the atmel at91-usart.yaml schema and resolves errors
> that occur during DT validation, such as:

That's redundant statement.

> 
> arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: serial@200:
> serial@200' does not match '^spi(@.*|-([0-9]|[1-9][0-9]+))?$'
> from schema: http://devicetree.org/schemas/serial/atmel,at91-usart.yaml#
> 
> arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb:
> serial@200: atmel,use-dma-rx: False schema does not allow True
> from schema: http://devicetree.org/schemas/serial/atmel,at91-usart.yaml#
> 
> arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb:
> serial@200: atmel,fifo-size: False schema does not allow 16
> from schema: http://devicetree.org/schemas/serial/atmel,at91-usart.yaml#

And why is this a property of SoC? Does not look right, at least nothing
here explains this.

Trim the commit msg to relevant logs and statements. You do not have to
explain everyone what dtbs_check is.

> 
> 
> By adding "atmel,usart-mode = <AT91_USART_MODE_SERIAL>" to UART nodes
> 0 up until 12, these errors are resolved, ensuring proper DTB validation.

But in the same time you entirely skipped relevant information: why is
this a correct fix for the issue.

> 
> This issue has been tested on the sam9x75 (sam9x75eb & sam9x75_curiosity)
> boards, both of which inherit the sam9x7.dtsi file.
> 
> Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>

I think you work on some really old Linux kernel, judging by CC list.

Please rebase on latest next or mainline kernel.

Best regards,
Krzysztof


