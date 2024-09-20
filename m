Return-Path: <linux-kernel+bounces-334324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C162097D5BF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 14:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2030CB23B75
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 12:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6674816BE23;
	Fri, 20 Sep 2024 12:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CT5QkNIK"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070E916A957
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726836494; cv=none; b=SUD3w6Ko+JS8IGk/9nII3A4Fl1SPNzYskwl0rjCS6jmkQkqdgZ3ybV+aLoSdG/INzDG1Z5I23YLiazh2HobKy9oP+hUNvPPm6wfBnJ1dkz1lXyIRusnnG4jeSma+qrvtlE8KtppmKsw9cfUixJwEE7HqnAUgynTQcZMRToA3MIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726836494; c=relaxed/simple;
	bh=AclRvldpatLgSSIEgQdKGzYslxoxSDWheM7zZr9XXNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F6dl2Zf59yQkcgjXomdTaqeXQmnCDdMXOq7w2HyroiGb2P00Iwt8kf4XBjM4IUW7vfKhSy55gJkECcJeWmcqfNwDJpDysvax/nykmykOpzQJNLM/rLIKy7plv6KB87T9+O9jnz8OgcgAGbPYy9fNv5YTXtWPhALhS+HLdfpN4q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CT5QkNIK; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-374b9c74aa9so153703f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 05:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726836491; x=1727441291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7ndjuzcBb3KczM0OtIVNQY8792/H5OZdu/ATsA551N0=;
        b=CT5QkNIKj838HV99+yPYlNwBLu/lFEIegDOQDKWhGr+6xfe231KO8uq0oKe+0/mTst
         r0eZFJb8RbKvnnrkDHpl7w8tT0daOA1xekDnSLUmiR3cXzUH+GbaVvPQIGY2JB+1bCc3
         SPNgRJV5GMtzrLcBf1zZtoZDf+QewDHVsY3gcawYMOsKJeny77g8EYvNOgJ2tMb2OjSQ
         b6HwqL3KploPHtmKUji/0LAXza/auQ5prT0YhA8WPuJ2eI87c5a4nJ1RhrtMSNQaEIWA
         miDXzN8OFRYLCn6edL4fyIgvKvG3eZD+DzmV7FQ5ycJMm7LhXffbn5upXYYfUtIAy+fF
         ncww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726836491; x=1727441291;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ndjuzcBb3KczM0OtIVNQY8792/H5OZdu/ATsA551N0=;
        b=GwLOvyLnqH9DaXBb14cXAnscdP+skr2QD8x1x5PmbqEUCTi7GQ8+aA9E5GRIOrzUBS
         mOndVwt+eTIBmVo619z3xje3l0+IR6W7bxRLubK1unoNXsMmidP6Rhh7TANZnokIB5DD
         rpDtfgpK+dBW5Vld+028rSnReb03XhOalOnR63ZiLxlJxgen1Vs92PZdZWN33nwZZdLH
         pqzrtnJqLB5hLitcsCQStwNY1IeOTpCqmWAP2LKVewn1NLq+0TGj7IwQ92iFcPGwOXnh
         53v0hSPfBhGq1vWkmcy2zQegbBdyEjgmGpZUJtF766Ia808OxD3UeJUN26QDl5UIlTGA
         4aVw==
X-Forwarded-Encrypted: i=1; AJvYcCVI+Gu5E//k64dTRw92eFadQG9ZPIEJWfyuzL63zSZX/Fi18FOc4cTHi1x3G6OzuCQ32zivo8Vs4hd7E2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN04SR0FYCJz+Uk33hbgkSuizDlh3DSpkNQnZCh7HH522TKeeE
	Qd4gbvfQLhn5NJa9CWP7yY4AkzYJPlYH2ruP23sqKyHcUv6v0RLYyFU1pUq+aa8=
X-Google-Smtp-Source: AGHT+IEjRqf7ROMNAOcdynOQ2m0TfxnrLbHdAL0pf+Mm1v9dYgC+waJqWQnT3hNm0L/fE6v6z1cIPQ==
X-Received: by 2002:a5d:64ce:0:b0:374:ca43:ac00 with SMTP id ffacd0b85a97d-37a422722c4mr903863f8f.4.1726836491250;
        Fri, 20 Sep 2024 05:48:11 -0700 (PDT)
Received: from [10.138.0.47] ([83.68.141.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb495besm7191325a12.4.2024.09.20.05.48.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 05:48:10 -0700 (PDT)
Message-ID: <dd4c1956-cf6e-442b-9119-12f63fb95db8@linaro.org>
Date: Fri, 20 Sep 2024 14:48:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: defconfig: Enable Ftrace and STM configs
To: Mao Jinlong <quic_jinlmao@quicinc.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Bjorn Andersson <quic_bjorande@quicinc.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 =?UTF-8?B?J07DrWNvbGFzIEYgLiBSIC4gQSAuIFByYWRvJw==?=
 <nfraprado@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240920075905.19441-1-quic_jinlmao@quicinc.com>
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
In-Reply-To: <20240920075905.19441-1-quic_jinlmao@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/09/2024 09:59, Mao Jinlong wrote:
> Ftrace logs can be captured by STM over TMC sink path. We can enable
> ftrace logs along with HW trace of coresight component. The timestamp
> of ftrace logs and hw traces will be in sync which helps to debug.
> 
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  arch/arm64/configs/defconfig | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 

I am pretty sure I saw this and even commented on. So you miss changelog
and proper patch versioning... unless you duplicate someone's else work?

Best regards,
Krzysztof


