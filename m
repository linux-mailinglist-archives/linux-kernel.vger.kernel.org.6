Return-Path: <linux-kernel+bounces-200115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 534948FAAFB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 08:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05B41F238C9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 06:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2C813DDAB;
	Tue,  4 Jun 2024 06:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zUb1jnId"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4149F130488
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 06:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717483432; cv=none; b=t7DVfFRemgsMJlbckEUFV4DPYGhmolIKBmcsNa/UCw54/ZYfDNu480QxN7PVSSPnSViacaZT98syuyKb/6Y4CF7BwqEi5FSKzwNbCOBwS4WwNqU905iKc8CGmIt4971WzxFbhY1A6qsDeuruslVmIlr8M8b5kNUO7D0zo6A2YxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717483432; c=relaxed/simple;
	bh=MRgoQDvDkJicFSrBsjwFZZ3IdehjdBtaPOKmVbj4cvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=if8eFO3gNkO6hPh57QqYCnmUDEnMIkr2teip+tclI3buUOULtnblv3vEP7giNWgpqww5cgzLdZIxHxS4jFmUbcq5YpGpwBREcdP7ik7yYg+C/DQbTUUqQoYziLmlwLFTr01o3VEd3DMKFR6KslDBHzj2QqFl092W1LspHKdymZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zUb1jnId; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42148c0cb1aso6442415e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 23:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717483429; x=1718088229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=46NZCsaw/Yp5QHNYSFkfK0pkxc//c/PYouHi7YwJ++U=;
        b=zUb1jnIdpIgxbnGipzSgQhQ0mj7RJ3UgnDYtyLefSWd01NJQWuK6PiXwr5eJbQNihB
         7qHy2byCVj3ICgYrBQbGPZ5lVoi9sddz4bx/QIZ76Fs0/dT6vyiUqX9ACpZDWhkRrm2x
         fmxL72NZ6jeAup9UL6jV7ImvVCF/iM6LIakiR+fgMxnw1vlg4X30qh+M/Vmu5EzjBM57
         1p9Fzm0gnnWhumvhOgR+h2DSgoPue2YslRcu9ZUJAboOKDjIOy1RFKfFkjqR+E8HzL9K
         qfw/vbKT5T6E29ws0EG0ovbr930jWiUQ33ZO3G95z3jDMJPZgQ1pbmUltMhzqde0tBs7
         NbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717483429; x=1718088229;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=46NZCsaw/Yp5QHNYSFkfK0pkxc//c/PYouHi7YwJ++U=;
        b=cr7orf0vznqv/3G45Z1bhh2WYLaWFPNHoIwwTMz88/7jbsu+KJE5Jc/ZuO/qlhI9+Q
         nef5oATkHncHzUECizcRxp/BuDNKasnGnC//ukXE/V5Jy6caFwCqhOAxtt/BSiDB6/WR
         wTIzHyRO2KQJsvN9BQA+MOeAy2aEkPYiNc+CSGz1eF0dMwzJwIjCzwWhGjpnMgcFLyl7
         MF+i6bospSFWhrwGgcmCPCVqVcjzfMG4Yqcxx1lekpMKiYcWHlv1BjtZfsaSe5mh6s68
         FF04LsZGaYkYRpbiuiPexIpNqP3iaeThbhTwy7YKl4ssjb+X6WM6CozPaZap4FUZum47
         /0Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUKWY94dOy1LaBn8GEgeFPf0fl9aIVKcY6uMqK4FZW1u8rduTH1enUuHmMoBiZ5lJUDJqx6bmAT9kE+u0g2peswTdhgoawgbmUZbE45
X-Gm-Message-State: AOJu0Yy3414uFIUfdf33jwW3dFGgTV03bp5WHMPU466O/HOqZAmzVFSC
	1IltcGaYB6DZSwqq2JXhPrSNVK/TAZZGz1vXMRAHfnHfJoA+c1pL5Q/oA8gqyoc=
X-Google-Smtp-Source: AGHT+IFcyVFI819SCILStwHAIhXZ6qsX58xkNd9egtc8LY9lrssQyuBHWJXgkwyZc6YrYEMxro4D6A==
X-Received: by 2002:a05:600c:198b:b0:41b:e0e5:a525 with SMTP id 5b1f17b1804b1-4212e0620c5mr100351905e9.17.1717483429491;
        Mon, 03 Jun 2024 23:43:49 -0700 (PDT)
Received: from [192.168.2.24] ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b83d479sm142217975e9.3.2024.06.03.23.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 23:43:48 -0700 (PDT)
Message-ID: <af9dc472-0d9d-4a31-8f44-5f21cf411668@linaro.org>
Date: Tue, 4 Jun 2024 08:43:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/8] dt-bindings: clock: qcom: Update SM8450 videocc
 header file name
To: Jagadeesh Kona <quic_jkona@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Taniya Das <quic_tdas@quicinc.com>,
 Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
 Ajit Pandey <quic_ajipan@quicinc.com>,
 Imran Shaik <quic_imrashai@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20240602114439.1611-1-quic_jkona@quicinc.com>
 <20240602114439.1611-2-quic_jkona@quicinc.com>
 <921bb7cb-3630-4d08-827f-b5a9315316f9@linaro.org>
 <4c0c2cfe-c287-489b-944d-c909de4fefd1@quicinc.com>
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
In-Reply-To: <4c0c2cfe-c287-489b-944d-c909de4fefd1@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/06/2024 15:27, Jagadeesh Kona wrote:
> 
> 
> On 6/2/2024 8:54 PM, Krzysztof Kozlowski wrote:
>> On 02/06/2024 13:44, Jagadeesh Kona wrote:
>>> Correct the videocc header file name in SM8450 videocc bindings.
>>>
>>> Fixes: 1e910b2ba0ed ("dt-bindings: clock: qcom: Add SM8450 video clock controller")
>>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>>> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>
>> Where did this review happen? Can you provide lore link?
>>
>> Best regards,
>> Krzysztof
>>
> 
> Please find the lore link for this review:-
> https://lore.kernel.org/all/e9109e46-4e72-4b3b-a995-4b2af3c31e45@linaro.org/#t

Indeed, thanks. I could not find it.

Best regards,
Krzysztof


