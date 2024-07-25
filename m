Return-Path: <linux-kernel+bounces-262116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4D293C0F6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FE4E282F38
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CED19A2A4;
	Thu, 25 Jul 2024 11:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FPFdhMSc"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9447919A295
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 11:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721907240; cv=none; b=RE2W1dMa6ky12a7MqRvd+JhvyEQZCYKp8R2Jo1QufpBbPMd/PyL0Fo/Tmz5u3cOIbF8FfmYrZHWbVzKg5+++xjDJCbXgKz2S2uYF27Y6KodCHxHyDfeaWOPFB6oUkTczk1byMKAnIpLGJ+kt7bGU3rkFD06ZDTyPtA2bFBqgCt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721907240; c=relaxed/simple;
	bh=cW5ZvjTFp9QMMbuRE6DfM3wpej4qRsHk8x555Jvlk/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b3kVMtEmHpOQ5WiFLU086O8aT8yJ67JV5gDMZfwoWfBroPQPcjX0x3SNXUTcD3y/vaJBjti8kGPgsy0YgDsqYegR85v1xUHp6lrSIQpkcs3A1eVr7Sm0LOlTCvJg+LdNdoONQE1RhQLAgKYBlN5/wkjpmqzdiaPPwp3QQZRBGs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FPFdhMSc; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-427ffae0b91so8278305e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 04:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721907237; x=1722512037; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ajkRzROrWUKZXCM3O3C1vGQ9zBSMeLqDSvVIu44rirA=;
        b=FPFdhMSc9PPhZGoft5XeBmqCcoHAJ6H52hLCVGfsLesoqAZNwvB98zXnCwB+lfSxdy
         YCUG14PclU+1SstRBicUuytcEzfHSGq2DbeLRALc8d46h7JQjG5BYeXnZEXzdzgH2Cpe
         Ekgn049C3F67u94U3IQAqD65NFBNzv6cPHenjn3DtMmKiugVPn8zQxQLZat3joA8bibI
         p21bmopFcZXK3GlMg+abDNKzIQzJPf/FCI+HlHv8tSjXmp0nUGWMjptZRbCLKVVcGYTf
         kvf+F6qCKQQPbtyQEnLo5m0Ls8BLb02Nurvu/30pA0DJQ/3HruCVvmQiEIqmuCec5VBv
         6/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721907237; x=1722512037;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ajkRzROrWUKZXCM3O3C1vGQ9zBSMeLqDSvVIu44rirA=;
        b=WkTpbsFGo5xQKaXLULb4QYHYWpSUfsMho1rzhxs1BnyCoqtyhLVrYg2pr40dTE9Fur
         ueQUZ3eWMkIi+nQvpGMTgM6D6Qj+tr7gZY5hFv+7YY0m3Doc6MsVw/I7zMN0SiVhyj5Y
         87I+wo4tbYcZewbbji/fVRdmCm52y4LWeFN2VSQOZBsyK2t66YzmtcnZM1fzqs4kZZ7X
         9uL8TqK+Suq4I2c8P0FCP0+KUt0ZfxyqPboAl+VrPAjHVb+iaaJ/wDyCLsc2sLoBcZRQ
         XhBJUpB/iBvEFqgjvfh5LMXijMbLea78NRJ1GTS5USuBRyRRtHslHySMdP4cPAhqqG6R
         9fqA==
X-Forwarded-Encrypted: i=1; AJvYcCV+wR5/K32fUNCjZ0oFvghxVJ7m1iGRVmMRwWFs4Xe6k9shJh2WuurbAx4bUA0XcE8AXSNIJcsZO+oZ8tlzoQYs/oAAwE564hhCcHs4
X-Gm-Message-State: AOJu0YzXQxMo0XJFO9sa8KLON3+TfPm8WPngRF1mn8CmBkOhR8x/pavD
	eFDIvuEAgmEp1w2WHSSaGrRSuI5BvOq3t0smCGiYxyobARhDf04OV1KrAch3O9s=
X-Google-Smtp-Source: AGHT+IEh5R7bJYti2xB8a6+ggHUrmdFLSTlVVS+5PJCkQQ8BNXKn1Oyhkq36T7V14RnGqrsuXv4U9g==
X-Received: by 2002:a05:600c:4684:b0:427:d735:193d with SMTP id 5b1f17b1804b1-42806bf3c7cmr16007775e9.31.1721907236936;
        Thu, 25 Jul 2024 04:33:56 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428057b7274sm31037475e9.40.2024.07.25.04.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 04:33:56 -0700 (PDT)
Message-ID: <57020795-0b37-4640-967e-4fe3619d744a@linaro.org>
Date: Thu, 25 Jul 2024 13:33:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: imx93-11x11-evk: Add audio XCVR sound
 card
To: Shengjiu Wang <shengjiu.wang@nxp.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 linux-imx@nxp.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: shengjiu.wang@gmail.com
References: <1721897948-6306-1-git-send-email-shengjiu.wang@nxp.com>
 <1721897948-6306-4-git-send-email-shengjiu.wang@nxp.com>
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
In-Reply-To: <1721897948-6306-4-git-send-email-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/07/2024 10:59, Shengjiu Wang wrote:
> Add audio XCVR sound card, which supports SPDIF TX & RX only,
> eARC RX, ARC RX are not supported.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../boot/dts/freescale/imx93-11x11-evk.dts    | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)


>  };
>  
>  &adc1 {
> @@ -469,6 +482,19 @@ &wdog3 {
>  	status = "okay";
>  };
>  
> +&xcvr {
> +	#sound-dai-cells = <0>;

Why this is not a property of the SoC? This applies to other patches as
well.

Best regards,
Krzysztof


