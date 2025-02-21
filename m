Return-Path: <linux-kernel+bounces-525809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E50A3F5B2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F987862970
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4BE2A1A4;
	Fri, 21 Feb 2025 13:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oV58woYz"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F36020AF84
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 13:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740143792; cv=none; b=jXQWhBugIck2s9okJ0Cq3UeU2avADLHcp6wnoVdoMYmY/Z3yVKYUpDMzB5C2kOXtjD/Pi5umU1RY2s4F3bCOBGpVlcEdtaDG6UyKQnkVS0rK/D4HWUrmZ/6O9uoEREgQXYPoSlXMelUFde9HXTFoxpgPxJ6vWJ69sARjPVivC54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740143792; c=relaxed/simple;
	bh=usxW3iALsfPZDjvbzJfu4kB+HuQ7zuH5NyXbX1jKYVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bkyvn+XNXEbO97DByLkl4VfH6nZtIL4CrPasUC67Mr4asu/Bsl1Txiwd6FPkg5qKzu2z+6iWzNaUmXac4O0LdvhNSxtoKptxGhD1nOBIvuCvA0t8dc9+3JtHs8ML/Ldrma0gMjJVQPDSlwK9JL6Pyt3D81YL1Bs2d/UIP4bsrqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oV58woYz; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5ded7cb613eso356342a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 05:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740143788; x=1740748588; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HuLqhu3JmGBzjCZvULGc+vY++b5XygaCEKMmQr8WksA=;
        b=oV58woYzFdP7qYAJdp4tB9uAk0AEMIUOQmE/1nhvqgVVia48onkmRHGIvkpN3co7Mb
         mTW7pk2ABwIUWyRRR3MrGnVw3W3LZrUxPKjwzPfh1DOwHzE3NXb5u3EBHAgohKfEOTy5
         CfpWI/EMX0jlMwOOcoVb1WNh7s0yAn88vm3+QrvrGoadU7w/7BW1iO4Wvvsx+IotpzDN
         5nTv3O8BjhhymmAsHvME22evT1HJfnYaGxM+DrrDgRUq3cctPKSrRPSo5fl/mIn2iqJB
         rPfsdE/X+NiJ+5S9tiVP6SXWlpv+AVDrBos/kTvGjmrHUNGCYGEoGM5ThUwHNgTiLjnq
         dhrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740143788; x=1740748588;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HuLqhu3JmGBzjCZvULGc+vY++b5XygaCEKMmQr8WksA=;
        b=J9SQatgk+BsL+WdnqRP2UgOo1IvFn6mm2v9yNHxWiLsi4pmzORSFVGYbKQsOYvMY8k
         OCnucY5U7at1EJM6ZNrOI69yx/wOkroKBoiJERfu6J+jg4PIE4/L1Ah6UQFj4IkzJYRO
         GoRs7sdVZltvjybzmBLe+7fHdqUxfgBLCc3RbUULrdWh4HGD26lSZBllEula8A+e2okN
         jF5bK8WAf1dYzdtC+1yjic5jDyIGIgA3TKaDobZhMxZThRmq7XBHyxEl2PYRp8QwlsIh
         2GZmlF0J/O+Jgxz15b2J7xxFyMHv5kkNLSJ0yQQbUFvRLbv81UlHHPrvy7eW1VFLM4LX
         BbuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhSQ0qLyc0Vqy6Bbn0sFHQIhZwoAMblR/3n5RStbnPlWI1WG8Tn6J5W2CbkWGuz/31VVTdNLRlVsl0qZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YycrPx+14G9Z3QHr5ZQO9LOdawUx7vnNTZPDckmWLwvS7L7PELI
	TMzaerY2bY2lUFfNUxZzKktndp80PHpDIRx4epTRpVvUeG5IBl3YgmsWc256k0Q=
X-Gm-Gg: ASbGncuE4SctCDJ4pdtLW9bTaFfqXpsF9+NxacBVMWk6ciSwYzSPlepPW7g90JvEEM6
	9PvzTTdrWvAZyQlVzc3/Ajk2WYauoswaUkCJResyuFjfg0GDp812XsdxthL4vOzFnVd2IASo7WB
	Z0fFty0FfPYZOZlMM2ENkJUgarhkqMV1XCbXrXpRsVJt3yOde4Y4vpxmC0YYLjGUEGzOQaVlstU
	w+jOIDeWiD+QVNTLe21TQtF1H28jSJWI2oaz9ZWJ/oOOKh2+mbTnIW/fu8oHo45HiSu6E7bY+6l
	tzuMI/8T9m1a2hX8RXVesDO0fAQOSky8KW9wHr9jZXuHfvjO+ghTf4tdb7irWnKoNfdCK+JZNiT
	1Q1DQ
X-Google-Smtp-Source: AGHT+IHyaoSfFlo9oiTbzWYLyufNzsCGgbvwOOWfLPnqyUL86Ms80Ejowilrbj3d5d81IAwIA2+XSA==
X-Received: by 2002:a05:6402:2108:b0:5de:3b3c:d02d with SMTP id 4fb4d7f45d1cf-5e0b724a9ccmr1004101a12.9.1740143787453;
        Fri, 21 Feb 2025 05:16:27 -0800 (PST)
Received: from [192.168.0.18] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5decdfe758asm13670691a12.0.2025.02.21.05.16.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 05:16:25 -0800 (PST)
Message-ID: <ebf41227-a0c5-44eb-b6a7-53e30b24e298@linaro.org>
Date: Fri, 21 Feb 2025 14:16:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: display/msm: qcom,sa8775p-mdss: Add missing
 eDP phy
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Clark <robdclark@gmail.com>, devicetree@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 dri-devel@lists.freedesktop.org, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 linux-arm-msm@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Mahadevan <quic_mahap@quicinc.com>
References: <20250221121703.72230-1-krzysztof.kozlowski@linaro.org>
 <174014368122.2668239.11304901481263017777.robh@kernel.org>
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
In-Reply-To: <174014368122.2668239.11304901481263017777.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/02/2025 14:14, Rob Herring (Arm) wrote:
> 
> On Fri, 21 Feb 2025 13:17:03 +0100, Krzysztof Kozlowski wrote:
>> The Qualcomm SA8775p MDSS display block comes with eDP phy, already used
>> in DTS and already documented in phy/qcom,edp-phy.yaml binding.  Add the
>> missing device node in the binding and extend example to silence
>> dtbs_check warnings like:
>>
>>   sa8775p-ride.dtb: display-subsystem@ae00000: Unevaluated properties are not allowed ('phy@aec2a00', 'phy@aec5a00' were unexpected)
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  .../display/msm/qcom,sa8775p-mdss.yaml        | 32 +++++++++++++++++--
>>  1 file changed, 30 insertions(+), 2 deletions(-)
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.example.dtb: phy@aec2a00: reg: [[0, 183249408], [0, 512], [0, 183247360], [0, 208], [0, 183248384], [0, 208], [0, 183246848], [0, 456]] is too long
> 	from schema $id: http://devicetree.org/schemas/phy/qcom,edp-phy.yaml#
> 
Insufficient testing. I'll send v2.

Best regards,
Krzysztof

