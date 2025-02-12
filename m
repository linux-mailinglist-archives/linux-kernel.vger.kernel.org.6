Return-Path: <linux-kernel+bounces-511870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDD5A330D8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 21:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91B88188A703
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95B4201017;
	Wed, 12 Feb 2025 20:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yOzo2QTi"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422F4134A8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 20:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739392245; cv=none; b=Kin3ujiOY8MAsCBw48S3uccvTguY0QS5mZQ8nV3BQzWkNAlu0E61NSWqmxkD6gPNJFVg0bnMOwWIe3FNirhGmHTnJvKCv2Seg99/pcQRauGkvsMHvZbheiagwimJvMSizAGazOc91T7ww9SnSXbTgJSWVtPCNc+9jWFOqyNBeFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739392245; c=relaxed/simple;
	bh=62XOCJaY/t66luJFF5h5rOCgBVw9Y8phtjVL6ga39Eo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Hb5oZuniQO3si/Qa1tBkjKIsZzvS8v9XS0V58NJbI/ZlYurdw8gSd7sHuyKzsxtGEZX64kZ8iObrSV0vA5n0ANMeR7rDUHJj2LtxohpRL3J3pNArezbaHxqoLFC4xUAVInQ3ZXN7A0Fq3E9cfd72UjX+qhVQpCO5DQcsL9cE+10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yOzo2QTi; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab7bf29883aso3484266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 12:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739392242; x=1739997042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cmRXcdjEFTtwWErLiczOTSh5GDvvFaZtrg8q8bv4gpA=;
        b=yOzo2QTieNe9e85IT4nrDmnumISeOAf2Ae1ccHRMydfnrJ/lJ6kT71Ls5ukYy899ZC
         /Nxj9MgWBbwzr95eYRC9ePjV90FAHRDy2nihBub85hroVX6encYP6v8RpKRKORIdnUeL
         iVro+ehIrjueiGiol3DXP99Be1Y3/WlIS91hgKVqCuzIpBt/KRfL1+FaSU3li8+9cmEh
         D3wZji0ihem+/swDNPetJGTr8GnJBOqzcAkrnQti1XivkvKsqjtcZjHjbg6oLuG2qb8t
         uguuweL/7slcPG0anFKkyk0k7dKRNngy1GEgSwa+H/tF/8ZQy+isYk2w+AoI8gE1+XPv
         lyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739392242; x=1739997042;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cmRXcdjEFTtwWErLiczOTSh5GDvvFaZtrg8q8bv4gpA=;
        b=wF58kujQYXcZ1bv5HnzoUF9wBdM86ql5zb7E7VfM5Hpy+1h2deDgjmBDuWrbUoeI2T
         okdxu3AyU7BP//qcmp8UWCBAGiYFZUPHGaFN3UH++BXgGSvJrxzceVfyo/cwS5AvUBa1
         Oaz9Z5G1/A6zTugQpAPFrvQs89RdHzUIU3aYbopWBU8wyFhq7gU99OphtQE1QlI9nKH7
         XiNd228LujQNUBvV98YRjjvWR0cv6eUntwBy9k+s/qIpUndHGKaFYfMfOjB67F0+4CL1
         FLa3ZILPIW6YLcaGq5YJzbeX4eLLjAJ5czIKkupedycMoaiAc/p6Kh5MnWXNHuuT6aaQ
         NRJA==
X-Forwarded-Encrypted: i=1; AJvYcCUYcke1BwMyTbVJFSIeJdGJRTWe1GmEk5HPkceK5REe1fnHQQDB2oPQTBfUNZlT+WPNxO6aPKOmIS9rwJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoNDrQynzcg7RhjaYKIDiXj5uOd4KQ+1CecypR269e155yj8op
	hjjov1dcZWr+T+lENjCyN/2HgxdtQsRqDvGvGK4liLkoJVWPCbYYSyC7qAAByxg=
X-Gm-Gg: ASbGnctj5CXjYy9Uaij62EaE4YZSCye0SePy+P/Pqys09Fp1PbXY4lmhUvZQ+1gTGa4
	ltoJhg/6S5vpbTWJuOqA49JsW8A9+mBvtTMhzveI9ryfgtz6L51h4enJfcspASgevE4Cthd0q3V
	y+snzvcbwecGf29psJ6TGqKuEaUTG+1E1PszPhoG02I7p63sVmKNPetDE9gTOCoi36pd8OmX9bL
	q00pe05ABqTns0NHK2Z023JJW2kFDXG0ROE7SccmuMB4ERdHhMz6y/LwbgX6A/Vgs+T7KjW8TzB
	SVQMs7U0Vw7NHc1iRoYuy0hhT8L1A6Nf0b4=
X-Google-Smtp-Source: AGHT+IEy5MNFfUhE4KoXzS+0qnWcf+fR/v9TpWdLTk4yS/53co/Ga9Puko1DFJtx4WWKhW6Sl6TL2w==
X-Received: by 2002:a17:907:da5:b0:ab6:6176:9dff with SMTP id a640c23a62f3a-ab7f31a654amr186338666b.0.1739392241639;
        Wed, 12 Feb 2025 12:30:41 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7dd77c151sm418897366b.57.2025.02.12.12.30.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 12:30:40 -0800 (PST)
Message-ID: <55aed776-ebee-4b0a-a6e0-17732fdd5191@linaro.org>
Date: Wed, 12 Feb 2025 21:30:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: stih407-usb: Use
 syscon_regmap_lookup_by_phandle_args
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250111185407.183855-1-krzysztof.kozlowski@linaro.org>
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
In-Reply-To: <20250111185407.183855-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/01/2025 19:54, Krzysztof Kozlowski wrote:
> Use syscon_regmap_lookup_by_phandle_args() which is a wrapper over
> syscon_regmap_lookup_by_phandle() combined with getting the syscon
> argument.  Except simpler code this annotates within one line that given
> phandle has arguments, so grepping for code would be easier.
> 
> There is also no real benefit in printing errors on missing syscon
> argument, because this is done just too late: runtime check on
> static/build-time data.  Dtschema and Devicetree bindings offer the
> static/build-time check for this already.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/phy/st/phy-stih407-usb.c | 24 +++++++-----------------
>  1 file changed, 7 insertions(+), 17 deletions(-)

Vinod, was this patch lost?

There is review and patch should still apply. Let me know if you need
resend.

Best regards,
Krzysztof

