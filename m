Return-Path: <linux-kernel+bounces-402384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 878BF9C26F1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 22:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 466F8285168
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 21:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049B11EF09F;
	Fri,  8 Nov 2024 21:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bj3sJ7RO"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58B61AA1F9;
	Fri,  8 Nov 2024 21:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731100350; cv=none; b=cz2de4ZjelhLPxVU8B/GMyeZmybhtp+0RbCDuskKGoo/U2Men6OtCZl3bpSNJSZaOu2470h/T0DLCWhz/WahlA6PvU1WwD0QLGo/X4G9YYTvccwfmE28fA2f8TLOL0XK9BXJGEGwjhJ8fJrEANabcAUZLLXWhX/X+0MxhI/mhoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731100350; c=relaxed/simple;
	bh=T/stVXICg98DOnc3JpDNC41ApEmpylgwGf9hoMWxUMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L8OAZTapJn9FOdLDIX6ZubCFQ3xEpZy7pmunpIvofDPf7gXmelq/CvF1T/tUuz606bd4lM4i7AmUhHfaf7kkCQpy/xTOhfb/fIvtC5Bv4NT4r5g3mbStmA11+2Nt8ZYB3nqOHuXe6cG6lVzakwEWwObH2QBiBqpGbEeUbHCy6jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bj3sJ7RO; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a86e9db75b9so416516266b.1;
        Fri, 08 Nov 2024 13:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731100347; x=1731705147; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GRdQwIjYTXd+4NEuzioQ9bORHEAmWVZm97bkocK9N00=;
        b=Bj3sJ7ROuVxbNOs5xKcX3IBawxgbwiFgHevZbVH9/O3kooL5GcfLI1fQGig/J49MOj
         uiSYHP/AumK1eNMg1thziFDkJa2f36R8qpih/gyt0JQsW2f9Yq9OguxRmGiE3P0pL3do
         f5Ntg4AOo1WPfGvVllvJpnwaDxB8g2RHAO6ctWJ7DuHc0nBa6bTTe5SEQPmjwy5k4cZ3
         0sVxQ27RRqfoVSt9Z/HDf/R/na9B76KwUzL2+LVeEpTLAhqMiVHXPQ9/0cEb2O0i8vZJ
         4U2dJJykAo9pl+2xZO1Uj7C9giYk6q7d8ZY9rSfOdmImp2S7RQtCtLbdtRcSw4vVkteZ
         QFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731100347; x=1731705147;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GRdQwIjYTXd+4NEuzioQ9bORHEAmWVZm97bkocK9N00=;
        b=hfgDLLkOQuLwB4irh75LU6kJbPlj0dy77OVxQkTX10dFtdGFcCfMm02PYjU1oP6N/O
         9H0yXkXkR0xHvRfnwN2nHf8FzayqwZJRmHX84X4MQMHMVteeeQnFTE2ovqMJMRRZmqbY
         jjlNENx+/zIPhC7ZVrmlmk+cyBdBl/KULfZMo42foJP8OySduCeHH5NxDnqlJNIevbOR
         RZLbT7yDq/U4lvsuWm453FE86jQMQmyitYFcBEm1HI1dmjwYmjkClPD0FtyuQxRMI+J1
         5T/nFXc+zPZVa2evJ+PaRuwZkzCviknCje8rjxmQkf8wsWblVMDxUKHqt9cJ4M9WiEiZ
         z/aA==
X-Forwarded-Encrypted: i=1; AJvYcCVWykZFLUjs/MdPvhxcWlrO9IxpS8UdQAcHodyJF8177bGvHu0pg5e/rDWS38MQ728pLCybXkpO0g+d@vger.kernel.org, AJvYcCXrtWXLP0p9QumGz8vGvAaDND1g8/gXx9KseLqW2vAxpF+pnB8ey5U6CdTM9AHSMr1sSifB59TfXVsPcukh@vger.kernel.org, AJvYcCXxbCr9F7dFytdq2nbdCErkZTl6ev/fqFgjmyAim5ICHBIEYSpHww/ze4pUNSWshhxL/sD29E3J9pEX@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu6NSQwNzld3RKnRaSNKFAxFNkj+xguzQEQrVVhYJ1EqiAhVrg
	x2QBC/sm2r5hLhny/Aqt+umjadaizNIJcJ6gFr7tmMhITUq+062Z
X-Google-Smtp-Source: AGHT+IHfY3W1P44D/+5X9Mv0Lkn3gsjpDpWQ1OX+M+X9kDBgfznn45mROOfa6ZjrBV4O4N507XYBgA==
X-Received: by 2002:a17:907:1c20:b0:a9a:558:3929 with SMTP id a640c23a62f3a-a9eefff12d2mr426112266b.48.1731100346738;
        Fri, 08 Nov 2024 13:12:26 -0800 (PST)
Received: from [172.20.10.2] ([37.63.10.207])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0dc4ca5sm279171866b.95.2024.11.08.13.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 13:12:26 -0800 (PST)
Message-ID: <ce5d812c-9d92-4ad5-8111-106968dbdd70@gmail.com>
Date: Fri, 8 Nov 2024 23:12:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: clock: actions,owl-cmu: convert to YAML
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Andreas_F=C3=A4rber?=
 <afaerber@suse.de>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241107143431.728669-1-ivo.ivanov.ivanov1@gmail.com>
 <a4begcrmbtotl2imd3eaxpdveagvwridy6ev5zmwzvjqt3ovfq@wyj2dj73xe3e>
 <d5d3f934-4f1c-43d9-aaf9-8de194d1f3b7@gmail.com>
 <CAL_JsqLkdXKGve5tB_cdO9bG9ge923Hbmkz+1BghLc+KkkDo+Q@mail.gmail.com>
Content-Language: en-US
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
In-Reply-To: <CAL_JsqLkdXKGve5tB_cdO9bG9ge923Hbmkz+1BghLc+KkkDo+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit




On 11/8/24 22:56, Rob Herring wrote:
> On Fri, Nov 8, 2024 at 2:31 PM Ivaylo Ivanov
> <ivo.ivanov.ivanov1@gmail.com> wrote:
>>
>>
>>
>> On 11/8/24 14:16, Krzysztof Kozlowski wrote:
>>> On Thu, Nov 07, 2024 at 04:34:31PM +0200, Ivaylo Ivanov wrote:
>>>> Convert the Actions Semi Owl CMU bindings to DT schema.
>>>>
>>>> Changes during conversion:
>>>>  - Since all Actions Semi Owl SoCs utilize the internal low frequency
>>>>    oscillator as a parent for some clocks, require it.
>>>>
>>>> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
>>> <form letter>
>>> This is a friendly reminder during the review process.
>>>
>>> It looks like you received a tag and forgot to add it.
>>>
>>> If you do not know the process, here is a short explanation: Please add
>>> Acked-by/Reviewed-by/Tested-by tags when posting new versions, under
>>> or above your Signed-off-by tag. Tag is "received", when provided
>>> in a message replied to you on the mailing list. Tools like b4 can help
>>> here. However, there's no need to repost patches *only* to add the tags.
>>> The upstream maintainer will do that for tags received on the version
>>> they apply.
>>>
>>> https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577
>>>
>>> If a tag was not added on purpose, please state why and what changed.
>>> </form letter>
>>>
>>> I cannot add other people's tags - toolsets ignore it.
>>>
>>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>>>
>>> ...
>>>
>>>> +maintainers:
>>>> +  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>>> +
>>>> +description: |
>>>> +  The Actions Semi Owl Clock Management Unit generates and supplies clock
>>>> +  to various controllers within the SoC.
>>>> +
>>>> +  See also::
>>> Single ':'.
>> $ rg --files-with-matches "See also:" | wc -l
>> 110
>>
>> $ rg --files-with-matches "See also::" | wc -l
>> 94
>>
>> Having 94 matches of that out of all 110 definitely leads me to
>> think that this has been done on purpose, and is still being done.
> 91 are QCom and 82 are QCom clock bindings... They tend to be
> annoyingly consistent sometimes with whatever was their downstream
> coding standards.
>
> The double colon is needed in rSt documents to escape a colon. We
> don't need that in YAML though. There were some thoughts on embedding
> rSt into the bindings for generating documentation from the bindings,
> but that's never been more than some experiments. This just looks like
> the first QCom clock binding did this and all the others just
> copy-n-pasted it.

I see, thanks for the explanation!

>> Could you elaborate a bit more? If it's wrong, then shouldn't we
>> clean all the other bindings from that mistake?
> Patches welcome...

Will look further into it the following weeks. For now I'll send a v4
of this patch with the issue fixed.

Best regards, Ivo.

>
> Rob


