Return-Path: <linux-kernel+bounces-235660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C06791D816
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A1001F2186B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 06:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AC252F70;
	Mon,  1 Jul 2024 06:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JLYuIdUl"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278A936126
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 06:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719815382; cv=none; b=oSYnBwYKPBSaR/+HwFO2ymUzW57Ea9U1gpoD+f7M3pS2ZdH43/mv4Dl/TCtvtl8Nt09PCVkYSl2fzcMjamfLDTZXRfolsm99kkEqHuCyevUE1CBu81wMWlRohaBj7WSDNTSzZXcUPF5ijVK6U4lt3lJJEWyeMlhmUVhIGLpOpNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719815382; c=relaxed/simple;
	bh=vwcflbuSSFSwLf/CpDhlvWISNUTd9C1LejWrrepemnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VJBI1SEmSd498x+xr4Zw5SK1jav/QnMz8QC54JdLzpRVjU8JZsYIvyxeNmKT9K8XEWN7/QGNFnw64gmV1BprxMoxVv6zLFW7LD9O6vhHEcDbJ9GU8yCPVU+RF92YrCFxL8zjDutVgeJKL/rYB+zvPXEGCB3FzoKw5Aj7Uzp0AF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JLYuIdUl; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57cbc2a2496so2956203a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 23:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719815379; x=1720420179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8KI73HaIZKPtA6tUNhbdnUVOjQwMiDbmpvyBy7MyR40=;
        b=JLYuIdUl3U+j9tVpNyWNyYWNkUVli1yBbs7j3Tx3cf8BKsj5W4iD9pHdGWp5uD953B
         8PEzp6HnRgUd6WGNyAGUqUIGTJFcnF6iO/PUAtHr3fMPNUgR6k/+ltptHmalplutkB2m
         vyUmxqZA3rUmzc/o6UmydIpP2v3z40NT2eg8XG4qw0Yi61ZftJ9b8cWsmNpwAvA/EsT0
         eTyJn/fzlpfoqeOz6+EK3USnbbC9faiKZx4MasSID8zc2YKY86HFsoWVjsxqUEtugKPR
         jGsWRB9XexLR04yxo9JXwbfgDTqZ+CW/28ENZWa11JJI/A5Z0r0HCbNH7IWdToBzLxmw
         rCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719815379; x=1720420179;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8KI73HaIZKPtA6tUNhbdnUVOjQwMiDbmpvyBy7MyR40=;
        b=Op+eC1SM1JyPbtByxMS5hmuwDp2NamU37UlT6cUKZ3J1PLdHzg37naXb/sjZ7vi7m2
         MNdEewlD6HLzg/5baKiNeXt+CEkL9ZnCNQyLucj6QkZ4yJJAmOwEyYSbN2tDv2zZvNDy
         V2xge3PocuqJA1c0PNpmCrI2iC7AoIyxtnK4ddIpmimgU+1xKEpCG5aB5zPjFhvfNdPJ
         6MG/6OQxkiALlPMWrFwU2UXcwTblSxgg16jLJdmMrDAJrIvZsH5xJk1eK2BcFmJrtslI
         fn/Rlx49/zY9B29Y3wA/FBIuc8Ad9RFOWL8XWcAwbY1PfyyNaeS5j5wjEynyYulxTQ/u
         8ZNw==
X-Forwarded-Encrypted: i=1; AJvYcCWNhGIBEa3q0DwAINpJ/xI/b5m08UpRc3Vr8oxcD9S7ZrA596PC2SjhwDEhOrAntsjxpqzym0u8wM+JvsU6tx/7EbFCtt11gm7mamLo
X-Gm-Message-State: AOJu0YywF0qJakaFOb1EXeG+2PHR8X9P0w6BF0xGoAlRnktK9lmTPgI6
	n+g8DPyDnVLCa9tbPP+aOHoxcoVr4nfPYUc3VDpPA5OsoxYAYBLWqclH4eEi49s=
X-Google-Smtp-Source: AGHT+IHwGKsRVShXGsslXlNb+wdgx+/t7H8J1mjqUgapp5brp8WyE93jr5C/X9AvXUda+6ZxZmDH0A==
X-Received: by 2002:a17:906:6a0d:b0:a6f:af8e:b75d with SMTP id a640c23a62f3a-a751446749bmr422138566b.8.1719815379548;
        Sun, 30 Jun 2024 23:29:39 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf603d6sm300841266b.62.2024.06.30.23.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jun 2024 23:29:39 -0700 (PDT)
Message-ID: <bc254432-47da-49b6-ab5c-cec731273e28@linaro.org>
Date: Mon, 1 Jul 2024 08:29:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] ASoC: codecs: lpass-rx-macro: Simplify with
 cleanup.h
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240628-b4-qcom-audio-lpass-codec-cleanups-v2-0-e9741143e485@linaro.org>
 <20240628-b4-qcom-audio-lpass-codec-cleanups-v2-1-e9741143e485@linaro.org>
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
In-Reply-To: <20240628-b4-qcom-audio-lpass-codec-cleanups-v2-1-e9741143e485@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/06/2024 12:10, Krzysztof Kozlowski wrote:
> Allocate the default register values array with scoped/cleanup.h to
> reduce number of error paths and make code a bit simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Not adding Dmitry's Rb tag, because of major change devm->cleanup.h.
> ---
>  sound/soc/codecs/lpass-rx-macro.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
> index d47c49c90de3..4cf030760d74 100644
> --- a/sound/soc/codecs/lpass-rx-macro.c
> +++ b/sound/soc/codecs/lpass-rx-macro.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  // Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
>  
> +#include <linux/cleanup.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
> @@ -3764,7 +3765,6 @@ static const struct snd_soc_component_driver rx_macro_component_drv = {
>  
>  static int rx_macro_probe(struct platform_device *pdev)
>  {
> -	struct reg_default *reg_defaults;
>  	struct device *dev = &pdev->dev;
>  	kernel_ulong_t flags;
>  	struct rx_macro *rx;
> @@ -3809,6 +3809,8 @@ static int rx_macro_probe(struct platform_device *pdev)
>  		goto err;

I got now LKP report about build warning on clang (which I did not build
with).

note: jump bypasses initialization of variable with __attribute__((cleanup))

This needs new version.

Best regards,
Krzysztof


