Return-Path: <linux-kernel+bounces-439109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D539A9EAAE7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8E2C165DDC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF12E2309B8;
	Tue, 10 Dec 2024 08:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sUT2obbg"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7724519D897
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 08:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733820270; cv=none; b=ldp/kams6eAZfF4W5lK/Hex5Ad9qpg1kj5agMueBnQfKG7gWyr0r5Sz8dJ+lUxpOH+JS1jW4pHOzrJcrVNHNHOFlRgoYYbGhxV+UkYf0ja+kKWaa/rqROha9uV7QCUQFeIqa1tMOyGJCSC61HKDsuU+w4x7AaRH4bwJ0U6DEUSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733820270; c=relaxed/simple;
	bh=gtkbOnbOImJWM921EqNDpx2/bp81PNUuwOmgAcMVe0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CCFUuDgNbAtS8vPekMpezalNenJdEr3ZdagAiqFIhclQ/jaSbduhE14GsJP5AkwAwmg+THMGuWQ3WHhcn2rDe8CUxTYxQuMdjnLvnaJOXpjXr37lihAi4239c0xmkrrhNJouW4L8XeCtkrqimfQSGZcPuhCIBeye617VIWbplaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sUT2obbg; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434f1e5e77dso2014845e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 00:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733820267; x=1734425067; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gtkbOnbOImJWM921EqNDpx2/bp81PNUuwOmgAcMVe0c=;
        b=sUT2obbg0XXKhTdFNvpXAm2bYwKu6aUK2hbaqqL8WJBOXr5/3XNGPcqHQsmG8IPkft
         KT47znP9R97HjPLmwgz0xcDad7odaUeifs/nQcwdbHsPfaRRWaz8yOB79NH9tkMo8lOK
         I6Y7qHJYzD/pv+2Z33IgebG0rU2NXP55htTYfY504YprrGUwxWv3dW+zBtMjz3mbCgot
         eBsqS6zSnr9CRFCAxiKfUt4uXck53FfQGUxjfaMmSiJ1v7hqNomDBFtNMIjiEBzihQnX
         OpixsuEHCp2Nce5S6cAQaZXCo2z0EaljQS3B6RdT/8jqSkx98OdcBKsBf914kg1pFOVT
         2v9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733820267; x=1734425067;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gtkbOnbOImJWM921EqNDpx2/bp81PNUuwOmgAcMVe0c=;
        b=Pj6oMgLn36VdzOpuWYLBcV2SG6pvYgKOXDYlZ2IF+aaq0yD4t+5CucVFRnIGkIhf9y
         tY4pDTNyxyTWdl+RqeKBxlBZ251ng8g55VzU85WzpUNEji/1lso1uZxK8LOzZEtUFeuP
         8AyOSbuir/dc6zYzfiYUavWWqiQAvAyJ0OQa41iujzx9Wji0BhwGF8xMrUBRidZsMUVo
         8WLLDwZeWdSNp0phsx2azJNF/7b9q9JHA+tUzyYqhv7j45iScXVbKos8HbTmWj6BzKFm
         MOQj7M4eEnVXw3rLQqIiKyGySLAm+c825/h7hhvHV1qSyVKxfYLh9sSFw3U8jSXzikNt
         HepQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKq18vwbMJpDr8MpICeTRb2JUtKhyEKfyRjcW5H/tY8fTOlJHl4A1+B4wD8aaykjLPETWNI/dKvS7bF/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoHXHyakak+8arFiXv668b0mPhkAjPdHizNfO/aFcupzuyqsaL
	KCDVPkFUajzushSYEj1bMRbhxkRtiLkXjLLSjfcjEb3nMMSckQUcsJrWLVCNluQ=
X-Gm-Gg: ASbGncvb2KmxbyUdjLGo+rlg3dJS/Kt/zcJE/pRyNSpwpXwn7vKketz51wzga+bRhv4
	QQ/DxmtLG9Kxtt4IFApxiN7i8EhNvDt+atSEcDMMKSub/7lvMdGAL27qPBq6e7lzlEWRmoNScHB
	HS6WKowx7HOKAi4sQ90GykPRmZwZNHaIBJZz9wMaYExoOqM3KearvcOZfE2YzVR8ziFzIKNcN13
	ors1Tqg1vj65j7CAW23s49xWllEf7Q8Yc7nTLzjdivW7kY/xbA7ACg1u/nnljDrwnvI4Vn3fw==
X-Google-Smtp-Source: AGHT+IGPo+343UL/XQMovJpUM2fs2wVtTJ2f6VeXfpBxnUXzR6Wmli37wiQCf2jAuAJMbmj0bMBcWA==
X-Received: by 2002:a05:600c:1c28:b0:434:a0fd:95d0 with SMTP id 5b1f17b1804b1-435019a81abmr8538055e9.4.1733820266783;
        Tue, 10 Dec 2024 00:44:26 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43502fef1f9sm17875605e9.1.2024.12.10.00.44.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 00:44:26 -0800 (PST)
Message-ID: <0d23ccf9-3420-45bf-aac7-5c1a075e031f@linaro.org>
Date: Tue, 10 Dec 2024 09:44:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] mailbox: mediatek: Add mtk-apu-mailbox driver
To: =?UTF-8?B?S2FybCBMaSAo5p2O5pm65ZiJKQ==?= <Karl.Li@mediatek.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: =?UTF-8?B?Q2h1bmd5aW5nIEx1ICjlkYLlv6DnqY4p?= <Chungying.Lu@mediatek.com>,
 =?UTF-8?B?QW5keSBUZW5nICjphKflpoLlro8p?= <Andy.Teng@mediatek.com>,
 Project_Global_Chrome_Upstream_Group
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "robh@kernel.org" <robh@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 =?UTF-8?B?Q2hpZW4tQ2hpaCBUc2VuZyAo5pu+5bu65pm6KQ==?=
 <Chien-Chih.Tseng@mediatek.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "wenst@chromium.org" <wenst@chromium.org>
References: <20241024092608.431581-1-karl.li@mediatek.com>
 <20241024092608.431581-4-karl.li@mediatek.com>
 <083c8f7b-0969-4ca3-8a91-35f5767c5f32@collabora.com>
 <CAGXv+5Fw+qZhTTgJq0QdiQHgiQP2ByR1tgae2+k4erx+0fp61g@mail.gmail.com>
 <a3c3280478bf86eb97a422782ce60ec4eaa35224.camel@mediatek.com>
 <0f98405c40530d81c342af06dea593e7babedeac.camel@mediatek.com>
 <cf75f3c3932ddc50f5697bc4f394bd77fc16cd39.camel@mediatek.com>
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
In-Reply-To: <cf75f3c3932ddc50f5697bc4f394bd77fc16cd39.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/12/2024 08:32, Karl Li (李智嘉) wrote:
> On Thu, 2024-12-05 at 07:05 +0000, Karl Li (李智嘉) wrote:
>> Dead maintainers,
> "Dear" maintainers. Really sorry for the typo...
>>
>> I hope you're doing well. Just a warm reminder that we're following
>> up
>> on these patch and really appreciate any feedback you might have.
>>

You received like 6 or 7 reviews/replies for your patchset. What are you
implying here if feedback was not enough?

Respond and implement the feedback instead ignoring it.

NAK

Best regards,
Krzysztof

