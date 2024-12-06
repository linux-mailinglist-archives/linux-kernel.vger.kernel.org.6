Return-Path: <linux-kernel+bounces-434704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D999E69F5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEF99281D89
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7387F1EE02E;
	Fri,  6 Dec 2024 09:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="COxAS6TA"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060A71E1322
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 09:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733476934; cv=none; b=UDplrCR7/mkcW1pNEJu24MEReL5qAsjBFrf0pODx63tvyNPp6RYVm/70/BJzoicQmWm5VZsdKH+FnikOFH+ZI0HmFiMDykAi13KTWNtHNQUTKBHvQkV4o5V2/5J4KJOotpWzBfsD5SQPgCmNf6wI6vAXg5UbmT9ofYYeTW40Op8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733476934; c=relaxed/simple;
	bh=3TzHUklU+x8y23N2d2Ko1lJMWGqRfx2SVa1/zlhM/tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I4rx0JlT5I8VfwaWUTkCy3120F6g+1PQeiy8JJWwZOz4HV8tTPVj8zDBdVk6YpGsOlRzdaFBDDbcF32I38uMC3PbTsuyeaj1gLIEGh6eUoYeTEB3QRxaKZtiUOCm6SW9HQjejFohek+TJe11/OyjQrRRrTY9qcdIxrBKEwZye6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=COxAS6TA; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434a0300d4cso1973825e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 01:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733476930; x=1734081730; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XRdOx+zo0jplOeBc/ZvBXWu4laRz8I4SHuVyG1dEGEI=;
        b=COxAS6TANLZxBl717daWR/QvwV92Bz0GULy7skS1yWj2Mxy0wz3ADRFERTcqOsRA/l
         JEs4juEAsnwk0TY5D5sNK4jKsXdnZu3+Hkeqf4Y5iPdXR0SDs1I5vfR/ouy6oQ73+8fs
         QiKXlF7Ey5nLqytkRhw2rs4HFQsbM/oyB6hnDmB6qBjFhW5hw+iQpXrZr/P2iVdaO4jW
         UKW/2gnj843fl7sGI+cFRRzL8GVW/w07ze9lmgXOzgHjqQMZG+UfSNccNSFkaS6lxntS
         ZIviIWZdSAo8xujikUwFCKL4cXgo1BqMEe/GlGgBQ7MvmZNKpdk/7KjmvxHRGfR+L8W7
         qWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733476930; x=1734081730;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XRdOx+zo0jplOeBc/ZvBXWu4laRz8I4SHuVyG1dEGEI=;
        b=HjIp2Er2FBcLjk2pUbV4wFuPSiKp0Xj/dM9RUeI/CHL528LGtaIGR/Q5RH214TLOQm
         fLkeGZ+bh8xzHMuyaZPxHB/MryB6bt1qZnfY5Vzf3BJCmZc/HdoIp+DZa4yvNzIp8GcV
         piXezdUOX8djx2nEi/KsU74yP7xDVmqQqNy5nXedzZvQgmah/TUKAuBfN9mEnObGw3yi
         5fgM1y0pa7UvB6LhTZEiGYJIW0Y7y/eIYHBIr6/dce9fM7aQtmh3ApQ3mO/ZKyC9YjTR
         hT5yzwQuWhPHiVIPYcnIcl/FnVwVPNT+8+ccoST7fYXD+KJLsZztj7R0pbeli0EiVJEF
         yWDA==
X-Forwarded-Encrypted: i=1; AJvYcCXqVRA5Jn4qQDHb18HxOXIh4uZUbKGAwFMZS8/6qKhzkJ3vsgdJ7LODi7twSo972vsogwSes8aCvEozvjg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6hhxkAGx1QFGUc6nA1trbkf+ImiQRkoKGYguzRR2aAsNwmo+R
	JhB7gT6HLBVPi35zq7W3OBSLIRUlJAp89fcO4dwcFr/M5uJXlbI5vgNbdr5ysKI=
X-Gm-Gg: ASbGncvN0ti8sM+87SKMrQVOQs5xBAM9NRh8EbpBI8ICcq8xEDRgHIxEzRm81aSAlr8
	JN0tcrtQCVhyDQcyMylXrb1KAWzn3JBVasw0VBjq5AJtj8z+8naw1/ClEZ7LvXLk/gqjY/Cbpcp
	y2VOpOCwGa7xVvPnsCO/gwLZ54mQpbcHJRGr3XP8Ng5ya+exkzQ3G0GM3aQLN22cJyo6ELfyqfW
	WmiBLsVMRLmScOLbP4/Vqyu4fEeK8pJzwF/y8be3TY3YGbpfNttdRdc2RM0JX1VK+un7w==
X-Google-Smtp-Source: AGHT+IHFmsPxPDKr+57ClyHXQ24d1OlqnEgYm+jKKrkZbuei0eOs5Jp84DPGWgGP4Vpbt4Ri7iToTQ==
X-Received: by 2002:a05:600c:138c:b0:434:941c:9df2 with SMTP id 5b1f17b1804b1-434dded98a6mr7812595e9.8.1733476930248;
        Fri, 06 Dec 2024 01:22:10 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da0dab9esm50714455e9.22.2024.12.06.01.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 01:22:09 -0800 (PST)
Message-ID: <bbf73ff7-1f7a-40a8-a313-f8b70e661f78@linaro.org>
Date: Fri, 6 Dec 2024 10:22:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: dts: qcom: sm8750: Add Modem / MPSS
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241122-b4-sm8750-cdsp-v1-0-9a69a889d1b7@linaro.org>
 <20241122-b4-sm8750-cdsp-v1-2-9a69a889d1b7@linaro.org>
 <4e6ec861-ef4f-4384-aab9-107c710987af@oss.qualcomm.com>
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
In-Reply-To: <4e6ec861-ef4f-4384-aab9-107c710987af@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/12/2024 18:34, Konrad Dybcio wrote:
> On 22.11.2024 4:26 PM, Krzysztof Kozlowski wrote:
>> Add nodes for the MPSS and its SMP2P.  These are compatible with earlier
>> SM8650 with difference in lack of fifth memory region for Qlink Logging.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
> 
> [...]
> 
>> +
>> +		remoteproc_mpss: remoteproc@4080000 {
>> +			compatible = "qcom,sm8750-mpss-pas";
>> +			reg = <0x0 0x04080000 0x0 0x4040>;
> 
> This also seems to be 0x100000-long

Oh, we all love to copy code, starting from sm8150, I think. Depends
which block we actually assign here - this should be 0x10000 (downstream
DTS) or 0x100000.

Older PIL remoteproc loaders (qcom_q6v5_adsp.c) seem to access only the
smaller 0x10000 region.

Best regards,
Krzysztof

