Return-Path: <linux-kernel+bounces-277328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59605949F4F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D6B21C22B40
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 05:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F71196C6C;
	Wed,  7 Aug 2024 05:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kqJKIweK"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0465E1957FD
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 05:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723009493; cv=none; b=SnTYtREdujw34L0PWAgxq18bLnIOUvWEzjU+QLgqDaDzkHrJwGeIsno6EQNH8jjfVAtWPXqvle0msTS2+7Pn9y/Ak7MyVmz0Kf6XBKzc3LAtCEhl5JnFG299I2yRyPGcglE/7k6Hj8OcMqFMC4J4jHU1tTKgI/6unk0Exl1s82o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723009493; c=relaxed/simple;
	bh=JE/r6oRaW9pWCNR+Vxh7Jmv7Eddt6ZRPoHulVg+7nwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bvpJWrcQMYzdDAYqUC0RDNrFyvESUsiCVPxvCU9JIXRA80nHDEPtU4twUJ6IIVwLmX6/BjY/kiCzCF4oQkyXq24ThUSvnTI9SOrwk2aveC6FH2he1q4qiLrLC9hh9pAUw7vPjXSQ2fcohOjXvBpZm5UvIZ8LyUmjX7JzkcCFtjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kqJKIweK; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3687fd09251so744510f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 22:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723009490; x=1723614290; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G0OWf6ez8Gxgf5JPBmv/oBu1hvtNwPXnbUW+1HDzI78=;
        b=kqJKIweKmt4hkelJubP0mCtDJqX+FY1dzAIfRDO1XxCdPQpc7J+GyR2ko8XsQNazfo
         GadUeFLPItLCwRQVaM0W8W3Tk0pVZnCygHSGGMVXd7OkS2yHQCn3yeXdIwUYgn4QopVt
         BfSnTKlT75+YNLly+W4aGz3V0jSlePAmxBAhv2iFSlZDCBiEObJufwPzgLae+jR6W8NQ
         CHg2zm7aL35Wsgy6T2fYCG8tNjsPln3e5jpxsgiHkI4PkbyCzomhVpYLZrtAK6pzuCfn
         hdPZEg5FJMcWZF5LIkLh8g3m4n6SPrKRfTpOweC5Bp4Xq3oLRImb9KhpJzFw5qP/qOUZ
         Vdyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723009490; x=1723614290;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G0OWf6ez8Gxgf5JPBmv/oBu1hvtNwPXnbUW+1HDzI78=;
        b=vYpeUc0LLWKAyh1d8Y1VT60vNzC3wtwfP+J5WTQpx5S/Be4zxj3uM2EuDQWk0cHyuY
         bdqIwUohJf956Ulsz28ZF+bpNyRf3BRmRU5y+BLG+k4RkBrcm+4qGKhcdMwFisrU3E3d
         bdtl1+IcoGHTps0g74hDaRXdlAzhw4+hdtVa8SC0ErqakUcUR7+82vVcbnvk8UUlRtC9
         n4id5AWZA/yG9XqvG4QABR6iXjOYcZEj69Nwy+EOqHAiQ5dmnM1AZOy5NRPLmY6b5C9c
         8M9Z1lNozkG03yQUotVE7ZVHPGgjxrI8aweYkdWGlzGoB2+wLuIVESySQpfFICsrJZDl
         FhYg==
X-Forwarded-Encrypted: i=1; AJvYcCXP1s4vdVrm1QwT+jGH+aSKtYqiiIbmS9gElos5N9WcziEaGQheeJnAcO+FR5RdoyhO8ObQb6LI8DstZWYb2aY3AmLpVAC8ltVU2G3b
X-Gm-Message-State: AOJu0YznU8yqiklDp7mug8lb3tHwkXYJKXnCdM7zsEb8x9aNkSa7v+nH
	86kJ9+8mQFHp3WK13Y3ISwafN8MvT9tPLk1qBdjkHFQA/L3jS1pWPLM6v9zrA/4=
X-Google-Smtp-Source: AGHT+IHc5vuzTBW4h6d1QGoBakXdzthyZ6QBCEOqs6EeG+t7ZawahJ0UefaucaaNo9LxA4PEzcg4DA==
X-Received: by 2002:a5d:64a1:0:b0:367:43ce:9c91 with SMTP id ffacd0b85a97d-36bbc0f9fb6mr13352499f8f.27.1723009490152;
        Tue, 06 Aug 2024 22:44:50 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd06d7dasm14685983f8f.97.2024.08.06.22.44.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 22:44:49 -0700 (PDT)
Message-ID: <6ff63eb7-81f4-4d3e-b96f-890432ec184a@linaro.org>
Date: Wed, 7 Aug 2024 07:44:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: amlogic: add C3 AW419 board
To: Xianwei Zhao <xianwei.zhao@amlogic.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chuan Liu <chuan.liu@amlogic.com>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240806-c3_add_node-v1-0-c0de41341632@amlogic.com>
 <20240806-c3_add_node-v1-3-c0de41341632@amlogic.com>
 <c82b6e70-8f2f-4b37-9186-7c49aea019bd@kernel.org>
 <59f37c77-d57b-4568-ad9e-6d50791ae5f7@amlogic.com>
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
In-Reply-To: <59f37c77-d57b-4568-ad9e-6d50791ae5f7@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/08/2024 04:37, Xianwei Zhao wrote:
>>> +#include "amlogic-c3.dtsi"
>>> +
>>> +/ {
>>> +     model = "Amlogic C308l aw419 Development Board";
>>> +     compatible = "amlogic,aw419", "amlogic,c3";
>>
>> Where are the bindings? Why do you add bindings without boards? Or
>> boards without bindings?
>>
> The bindings of board aw419 was submitted with board aw409.
> The commit number is cb3f4e8cacfa7b32ed8b9dff1282c0d4aaf42e88.

Why are you adding bindings separate from DTS?

Best regards,
Krzysztof


