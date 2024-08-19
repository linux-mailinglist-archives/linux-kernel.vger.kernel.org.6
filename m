Return-Path: <linux-kernel+bounces-292901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 735A695761B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 22:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E15CA1F23928
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 20:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCC9159598;
	Mon, 19 Aug 2024 20:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ORA5oBoc"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5668815E96
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 20:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724101107; cv=none; b=ZwF6hjT/8Ub2xCuw1T++OuChGK8Y4H+TbJjwf8RP/j3+Ue4ouwTHTUiU3/g8pk2Y+NJYeK8pCNN97Zg5BW3j+ZV5YPV5fqaXQJmSvZ4egFRDGRZia4sJZiwBxpG52GWk25mgZMtxxf+KJjp2d31HFBG0RBL0xcCtQKmMMDW3OOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724101107; c=relaxed/simple;
	bh=cQlmtNtWnYThGStLNJozTpwwFOhigNgOAg5dM7tMLBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g7dSI6xVkHaYmFURGmnx+IxAfYc51OIysGZENhUspxX4KC+OKxRRDeuym5m/2zi704hta74/pKM8Psr42sPm1HgYets2srBIqal27YQXHaVch0O4zz4pkUOCBRdMpV28OaSVSW5ENRI3aOKZsIpHlIHOXP5RGuyVWn306k6WDgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ORA5oBoc; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-428163f7635so41813135e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 13:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724101104; x=1724705904; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Oon3fKQYby1zliKtw8dXd2+/iyjWaxccxkC9zh24vbU=;
        b=ORA5oBoc2Zh8vNxxxJDbvx7cst+OYbAGzLAi/0z4vyWW8qGlXQ7+Yw6XCe0UqGj6LG
         Wmkzc69WGb4S2UtMLJxW0HmEifMBFCwbaAeVkfv86dbh15LGtECpNUhhnscoGroDPBHX
         oACQUogRjk78D7+HmYLFh6zC219VcRESL0iPILe/qycubfE6PWkJOoLS81s/RtLeMvmz
         axJQ69c8jBDXgAqjIxcKvm9Lm5Yvk6k1/PG/N4tyoGKkVi6KzuOK70XnCG3WZlIDBCIN
         Ukk7Wbi8IuNGpvrbg7snumLuChWdEineVYw0NZ+bI2Y7WSlStgqfC6DagVfXpcP7RrWE
         H/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724101104; x=1724705904;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oon3fKQYby1zliKtw8dXd2+/iyjWaxccxkC9zh24vbU=;
        b=X4/nWlJNyr9gTp3ryeePihKIFe9Ddk5WuNTi18TBGZy+lvRzvp7LTQm2JG50zDRsps
         ugg6vIZiqtdw5J4Ia1MB0UArzIj5DRUQHSjZ52cagjPEpo8LKfW11o9tB4tHYbidRyzZ
         T7CcDWziqqSdmZZeTromNWcYlP05GK7NrsJp4n9GJ8njIlxA8joMh7JSEfWlgojA/Cqx
         Oys6AC4PKL/tnitRzYKIjWW1zMQaQvoc4Fl8H9qz7blm88xCV/bpPjhK5nWZFD9C8+mG
         yPejL6Mv6GT5Ku+9WZnOXPrNAr8n93TrYklvyOjLd9jVw9gDgoCo37qH4Q3PiCvVYrBh
         kF2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVmt0nes7XktUeV6s2YQQtPndCHKe36tH7vaHh3d2M3PCy2O/IUmjC4lOs43FQMRFg/vYoTWNgkpRUhO6MLFBwsTqziTptBANK2lP8m
X-Gm-Message-State: AOJu0YwY60cyn3YElAV24NGACYsOsZEWptyINSlJIk5apkkeJkVYI8cz
	V+4OiRwlw/qbDd2WwdHZqlXO5ETGVQjpJ1kS7wNAwZnr/BH97KY79lf6yFZS1pY=
X-Google-Smtp-Source: AGHT+IFWXBaJdv0VH8w1HFj0SseVoMOg4cicWk4Tc7MJT7JUmRw0amR4cFP7c7TlNE3FF11A4XyF/g==
X-Received: by 2002:a05:600c:3b27:b0:426:59fe:ac2e with SMTP id 5b1f17b1804b1-429ed7cee39mr98784185e9.29.1724101103587;
        Mon, 19 Aug 2024 13:58:23 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ab6e7c8e6sm1594935e9.0.2024.08.19.13.58.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 13:58:22 -0700 (PDT)
Message-ID: <f4a9c58e-a7cb-4786-9293-85e1a3f538ad@linaro.org>
Date: Mon, 19 Aug 2024 22:58:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Missing documentation for Audioreach topology files
To: Jens Reidel <adrian@travitia.xyz>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux@mainlining.org, ~postmarketos/upstreaming@lists.sr.ht
References: <7721158.EvYhyI6sBW@ceres>
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
In-Reply-To: <7721158.EvYhyI6sBW@ceres>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/08/2024 22:53, Jens Reidel wrote:
> Hi everyone,
> 
> I am currently bringing up Xiaomi SM8450/SM8475 mobile phones and have a few 
> working well enough to try and get the WCD and audio in general working. All 
> is fine, until this:
> 
> [   35.366229] qcom-apm gprsvc:service:2:1: Direct firmware load for qcom/
> sm8450/Xiaomi 12-tplg.bin failed with error -2
> [   35.366244] qcom-apm gprsvc:service:2:1: tplg firmware loading qcom/sm8450/
> Xiaomi 12-tplg.bin failed -2
> [   35.366250] qcom-apm gprsvc:service:2:1: ASoC: error at 
> snd_soc_component_probe on gprsvc:service:2:1: -2
> 
> After searching around a bit, I stumbled across this Linaro repository: 
> https://git.codelinaro.org/linaro/qcomlt/audioreach-topology
> Apparently you're supposed to write the topology in a M4-preprocessed file that 
> gets turned into an ALSA UCM topology config and then compiled with alsatplg.
> However, there is zero documentation on the preprocessor macros and how you're 
> actually supposed to write the topology file. Am I missing something or is 
> there no public documentation and tooling for how to use this kernel 
> interface?

Hi Jens,

I am not aware of any documentation related to audioreach topology. I
used existing code as example/starting point and then with learning of
internals and digging I managed to get some grasp, but it was all
without any docs.

If your platform uses reference Qualcomm components, like WSA speakers
on Soundwire bus, then most likely you can re-use HDK8450 topology or
anything newer.

Best regards,
Krzysztof


