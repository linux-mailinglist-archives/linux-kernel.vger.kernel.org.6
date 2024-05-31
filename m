Return-Path: <linux-kernel+bounces-196463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5AC8D5C9A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EB361C20EA4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F4442071;
	Fri, 31 May 2024 08:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Aqs2jdLH"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D903733993
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 08:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717143559; cv=none; b=DhGTBAsE6qKy3C3zE9X9XInQpVyJBadrOrK26wmjlpQr57gKves3DVfjKySBLhHcQcNYIiz3G7kPzPICMxqLrcuParHGkjZeOtZnFg/dTnFoMHt/1s5Wf+7ZNVys/xB7v9sS9pB1D33qIPdWi33KhSPS9SeJ432ideUkF5bJ9WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717143559; c=relaxed/simple;
	bh=/1LErDsp0dac+5zXSqBZN4+xwJ3at4BsPOQIvMtW9+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UwUMOR2EABBRY2OWr7sDY/Xl3plX7unnF7fjvPlwJQiWwased2EJkBfedssEFNw2gR1cgU2GLdi9EeeuiSa2BFSlM4HgTJ31FVk3/If4IQG99kPvnL64ki3dRkkfgbohN9Yj2TRN1+gT09TJX/xMYguq2QUI0DZY1YoTJ27aZQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Aqs2jdLH; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-35dcc681f70so632939f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 01:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717143556; x=1717748356; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uekMz47pKS3vx9ijIAmITr9JeXRjL7yHxGIu+2L4LrM=;
        b=Aqs2jdLHYajOdB7MIaAdalyhJ0hSQEExOTMiOpzA3UmDQgkN1owVxJveNEA98KvcZ/
         hx3CueJLyMW0S+hOhGgMEQ5c1JSMXAfksHmuNxv4Zhtw5cVl4C9wi7buKFdig/eaX6Fg
         R7O4uZGLn5TSARtRYVjBrtdtkqhIcUp3amg63F/ue57U3tHny1F0IvjdhSEYg1wTD8rm
         9Qo0uoTWuC819WLGmfUKovaOXLjieTvVeQV0f+2VMlJcmA80dBrARIWogsL0aCGr5ey1
         kLrDeeWoDdnmEnQKQdtbkAXTaLGSbhKJeC94BItTbDXZQZx7xrXfRPSofSKZKk9CkUmK
         tXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717143556; x=1717748356;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uekMz47pKS3vx9ijIAmITr9JeXRjL7yHxGIu+2L4LrM=;
        b=gWGXPf/voI6NOlvlx7iH8P2GBoymolHsBvTM2nkXsPINgjbreCD9wwEKG0hZzvpgd8
         0B3NI1rdL1buN5OV1CXRIjeXtFqy+/Ruzbgf5v5fUcPotVmi7Yc4H90B+KKDl8qwTSsJ
         mu7675YhRyPkn/OX7AOXaJetkhy6BlZMlH1h93sTvQ1Y9F7M3B3vbwtGufxpOj1xO+c+
         DbE9eQwaMYiRjWc1ZiyY+VIhf2CksGZyiiF4MRk94pO9L1kUTQAk5vjjPeiYYpAE4F8E
         LCTAiDzRgKbYgMrw6+MfZjmHynjnEZFUPYsQ8jXvC04c/tPiXv28JF8yZ1P6R6JZOsBK
         Yqrg==
X-Forwarded-Encrypted: i=1; AJvYcCWRzbjW2c4zXyXJhx3eG6t0EjN5SYM6hUyI9YZyjQ1bB1Myke1MwEDqx8JlaV7XciGTGBPr9hsyn6OoT/mo2DzZLEh/aZC0H57Aeppi
X-Gm-Message-State: AOJu0Yz++bIn5U3quCKRIutohZaQqo8AUG1n3jYLleZPOWOIPnquEAbP
	Zn6UBx7Slh1fyZGHfgFiAZY8Y7cQc86APXWLHyrxMGHjx8YjRLFIhnsEGAA8SgE=
X-Google-Smtp-Source: AGHT+IHbY4akhnUCtegHUqtEGrBvCHmy2V2qMqt+Q8CZOSLydrghUIK0J+EoTajINJ9zjr1hWHoWVA==
X-Received: by 2002:adf:f704:0:b0:354:f984:3b83 with SMTP id ffacd0b85a97d-35e0f33e90cmr696625f8f.63.1717143556304;
        Fri, 31 May 2024 01:19:16 -0700 (PDT)
Received: from [192.168.2.24] ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c0f57sm1303386f8f.12.2024.05.31.01.19.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 01:19:15 -0700 (PDT)
Message-ID: <dd695535-8aef-4bc6-814e-27db9e4a697d@linaro.org>
Date: Fri, 31 May 2024 10:19:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: remoteproc: k3-dsp: correct optional sram
 properties for AM62A SoCs
To: Hari Nagalla <hnagalla@ti.com>, andersson@kernel.org,
 mathieu.poirier@linaro.org, robh+dt@kernel.org, devarsht@ti.com,
 s-anna@ti.com, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <20240530164816.1051-1-hnagalla@ti.com>
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
In-Reply-To: <20240530164816.1051-1-hnagalla@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/05/2024 18:48, Hari Nagalla wrote:
> The C7xv-dsp on AM62A have 32KB L1 I-cache and a 64KB L1 D-cache. It
> does not have an addressable l1dram . So, remove this optional sram
> property from the bindings to fix device tree build warnings.
> 
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> ---
> Changes from v1 to v2:
> *) Kept back memory-regions property, as it is unrelated to this patch
>    correcting the sram property for AM62A C7xv-dsp nodes.
> 
> DT binding check log:
> https://paste.sr.ht/~hnagalla/cb26237560a572a17c0874b687353e00b400285a
> 
> v1: https://lore.kernel.org/all/20230810110545.11644-1-hnagalla@ti.com/
> 
>  .../bindings/remoteproc/ti,k3-dsp-rproc.yaml      | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
> index 9768db8663eb..771cfceb5458 100644
> --- a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
> @@ -111,7 +111,6 @@ else:
>      properties:
>        compatible:
>          enum:
> -          - ti,am62a-c7xv-dsp
>            - ti,j721e-c71-dsp
>            - ti,j721s2-c71-dsp
>    then:
> @@ -124,6 +123,20 @@ else:
>          items:
>            - const: l2sram
>            - const: l1dram
> +  else:
> +    if:

Please use allOf (move top one to bottom) and define separate ifs for
each variant instead of nesting them.

Best regards,
Krzysztof


