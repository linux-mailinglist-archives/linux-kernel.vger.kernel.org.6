Return-Path: <linux-kernel+bounces-574020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E31CCA6DFAB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 605C8171520
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DB6263F39;
	Mon, 24 Mar 2025 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YryIBtIe"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E1C263C97
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 16:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742833742; cv=none; b=Jq2t2B18M0OLlkAGbMYdSZ71zzYFcQea9eiX0RRbbjhwi8atWxb67vMEjokqibwulXVkg4qnDKJl1Olj0N0eZ/0z/fuv8ySf0yerpwJU9TyIkIE3xRPtLfYNMPP9xCNAejrwLxtqjiI28qHbxtzwkcV3G8V/bUq1r/mrn/mkQ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742833742; c=relaxed/simple;
	bh=Of9YMko5FbZoOy2finDHkvUohPxZbv+U79/wtMxZLIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YDIghYAg1YiQ0yMxWK+YtbeDbF7DjKHtBkSVDfgbEWQOmnElDRArPgWSmntu4MhXoRk4QTAc8XiVXoddy7Rve5MDPCdYfRtS6HdzfeeHxKbJXRxr+4nS4mFyTFDHuD9cJTl3TDuVHnTdVmlkpXsWK143QVvFsm8aWqJgsqDyO7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YryIBtIe; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43938828d02so6926595e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 09:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742833737; x=1743438537; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wZEReYFBLgPBx6msQMgi21dW4Zu9uLX2ewii7o9t6CM=;
        b=YryIBtIej1Y50MkDUx62vV3i4P+H/NpbLdUAiuHKLsV8WF0iTPrcSmHCv6ymOycmAc
         iXJr+YkESaQxdIhAT2/tMjsf95E9VP9XwXh9MPd72fpzdASihRFi/E9cj3t31Opl+0qB
         NKmQhIDhqL9sDPODrnOsTEmaWTW1alLcavUoTv9x4hkYiOHGeeGr7Cr1AAyw3EhA/Ld9
         pKOaUCmj79nTUoKuk/BXm8MI+JcWMdCoy/9e0h99P4u+gcjFhk9xj5f2OM8aIK8dKZNp
         EERCw7czy3Get9s+OMpgk3cRpkFZZx3384qbhrImLlg3+fabx33podE5iPuwMVDgn5kZ
         5S0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742833737; x=1743438537;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wZEReYFBLgPBx6msQMgi21dW4Zu9uLX2ewii7o9t6CM=;
        b=GKC9zZH+6IbintE/AwYrGMsiX1pdNoeM8g0GTROjgZ37q87CTAE2DLD/0j8M5sSZQg
         Trw8RILb+ZrWm682TpYizJuAkJX7Z7APz1aTiTAWfe7LLXYjZ6xYdW4Q1NHxhOfLh6SM
         VojkBm0xhcF3TgH+5/F2B4wgu1JE3wiU+77DWoqAna1AOlg6NodQOJjMqq0jznl59sCa
         w5v5daRNq3I0O4KthtFfdErDK3bCe0xaXSMQqyeEtDNa/w4wInr7L8r94KPWrH46L74q
         5c4FlwMVUnFuMuJqifap+MdFj80zhuvgpPRfMeu83GGQJVUJ0OzEzF5m17iRrkY4WUZo
         jTJg==
X-Forwarded-Encrypted: i=1; AJvYcCWO8fiemdyLYDDLRG8WqIrk6I8BGNj9EcnzpaOcouG4wTOD5B2abyEF4i+cdxrgmnUWnTqjqrJ+OS9u5pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJzWErzUgV3+uOgsRwrITj+8tCs8alT88qu/JnQVf8LPfoUaaD
	vP0o1Fzr2SEkOFFtvpzyYNG5WQQSKuPeMPs8oiNwYNe/FbN5iacQBBjfWbwQsiE=
X-Gm-Gg: ASbGncvQC3jh4ja+xZ8vp4cfLpp3MovgY7hYHKm+AHS/JUhrE+KeK4nWsDqnzFLsg4H
	vTe7CEbFZo156R0EaWUMqR+TEwHMS7F9Z/4UlpYqQO8OCb/wvnYnxbg6HfdwsuxGILEPsDfYyuX
	/WSpuVgpB/FEcv1auqdbxTNNNLEjzflMgOAagNnAoPtBxbKAOh6rIcGsWS+LG1VUmka4sevoVPd
	JrOct2JL9zpyiK1xjSpcBmlgOsG3qi6xdE5B6apupSs03XZibz7daefUuSzuEfl8+EvbfdXRzsn
	SMmWkqowDT+Ah4j0X7IKOR78D9Zq4IbDjY2gFtzdh53PSN/9mZjXcC8UnF8InG0=
X-Google-Smtp-Source: AGHT+IFJIYkh8vR9dlTNbyS66WVsmBjsvJ1GO0jTZ0q/rIGpNF+C4dmPmFyT8t4LO/JNW4kAQQ/RpQ==
X-Received: by 2002:a05:600c:4e93:b0:43b:c0fa:f9c4 with SMTP id 5b1f17b1804b1-43d5100ad46mr44338935e9.4.1742833737453;
        Mon, 24 Mar 2025 09:28:57 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd26cecsm124700985e9.17.2025.03.24.09.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 09:28:56 -0700 (PDT)
Message-ID: <86a15b6d-6195-4b4a-9820-081f07fd72cc@linaro.org>
Date: Mon, 24 Mar 2025 17:28:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] spi: dt-bindings: st,stm32mp25-ospi: Make "resets"
 a required property
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: christophe.kerello@foss.st.com, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250324-upstream_ospi_required_resets-v2-0-85a48afcedec@foss.st.com>
 <20250324-upstream_ospi_required_resets-v2-1-85a48afcedec@foss.st.com>
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
In-Reply-To: <20250324-upstream_ospi_required_resets-v2-1-85a48afcedec@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/03/2025 10:40, Patrice Chotard wrote:
> On STM32MP2x SoC's family, OSPI is child of Octo Memory Manager which
> must have asccess to OSPI's reset to ensure its initialization.
> Make "resets" a required property.
> 
> Fixes: bed97e35786a ("dt-bindings: spi: Add STM32 OSPI controller")
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

