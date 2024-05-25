Return-Path: <linux-kernel+bounces-189512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 130738CF110
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 20:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9D3EB20FAB
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 18:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA272127E25;
	Sat, 25 May 2024 18:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wIgmQ2wD"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E83B86653
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 18:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716663523; cv=none; b=f5Qyh6BOhWBTl6w5w7CvcKB47A46EI7WN/XwIYWSWrUh2jcweKgc12C+3fQ+UH7Cx0a4hTbM0s4Ixhiv+2kX7udymHwVfFSVfFvaC64w1Bc8Fm8OoMHAWZWxBuyVbWg0j+UEFKVhC8YQ1tYwDb90raeGdoxHHJMJSFiQSGhC9zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716663523; c=relaxed/simple;
	bh=iKEIVO+4VmSS9Oc5MntKhaJZ/iGMcGlkEC+aUBukEHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ixPY4pCgRqXrQEmSn/2Ya04/Xs5NDnDxyjYNmDOVgrCX+76wHBIAOOplW7BE6w3yEJMsGGQ8mBoEs6qQptgRy/h3F3L1aappjQa2g3M1PVhC/DLEMEICcgWEmq17ngFaFpY0DciWEsgSoP2a6OtmQ2X0XjObkJgjxVTUlqn3CYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wIgmQ2wD; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4202ca70289so71194045e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 11:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716663520; x=1717268320; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t7he0sZ2GZcZ4jN7OuNxSgoGWU8clRyZzA1mrnUKwrw=;
        b=wIgmQ2wD9cwXdPB00KF2TNgBPy2LfhiyvHlQwzrhihPP3mzT7nrG1YKd6cVJf4PrwC
         z8XzH1viKmIDqk5nCRJPCFVxC8J1egiIcuihWH6XniW+2/6235r2YRpTimw840+lvOwg
         iyHEggY1aBUwTK2Xv50ZuiEWIqU8POFI9kgu2vKTPXPKF+41avskEZ2uUp3GRg9JoMEz
         c8nLH/v8zgA9ld9kUMWQ4ojo4RgJc4cscNWovY/ZfcOPLyXhMUzqpk5KdOnVmw6KmEM9
         NkYVnpTzHW8jRA/goq7kPXmZ4erUvBVlcCzmixsq2JbfgFaPnNEVBIY97Sre26xIjR4c
         9TbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716663520; x=1717268320;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t7he0sZ2GZcZ4jN7OuNxSgoGWU8clRyZzA1mrnUKwrw=;
        b=QRUCn8+x52P4DOBPS4AKI6ukrCd0OTuhIEwpBFYsnxGCokiR3p+xEd2ksh07Zr/jKH
         JU+4ptsdL8uuQN1zWYhwiz0X08IMPVArGIV4iTnofWMqqSP9cDknZgi94zCMXcQPF9V0
         jixUYfautY2HeMra40j4Jw+fA3Tw0u/dB0OObywQTpzvjwmy/mD557wJbuyIpV0/jNy1
         3A5Rmle6RfhGq9Md/GrNhpoM0GpOlgqQuUsXvsqi0dlaRPvNE1wtUTWWCMXrhnteQkGE
         l5X+3Okbw7At3QWsfbPCZXYkBzlCjl9RTUkkJ0jiUJO25fO4rs+SQjjLRflbruPYRMIr
         vPqA==
X-Forwarded-Encrypted: i=1; AJvYcCXvR57aIIBZ/w0uFKangbcHcO2pLSmQ0VEPtbYSlL6SK8tFI7gT5j0wUea+rfx20gi5TkYPAMZ4ZZwr5qVsMbA+w6jPZnXvtYUdPRhk
X-Gm-Message-State: AOJu0Yw+3WKKlJ35tCLOc1Oh5HcRg2O8iCUaPGFS7S6bphpyOQn6MbUy
	eKs+TqT/GqYDZ+zTpidx0KfmgFn0XK+jNQXUeWnDdZIqcY/tHx+sI4bJtRM0QEU=
X-Google-Smtp-Source: AGHT+IG+6KpN0Pe/v3SLZ8mnBfNrJmJz9mBszytORzY3EJM2Uw7jCaB0GzXeJ11/zaPwbSB6qOj0kg==
X-Received: by 2002:a05:600c:35c5:b0:420:1db0:53c1 with SMTP id 5b1f17b1804b1-42108a17b9fmr33015355e9.41.1716663519804;
        Sat, 25 May 2024 11:58:39 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-356c8daef27sm2426626f8f.115.2024.05.25.11.58.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 May 2024 11:58:39 -0700 (PDT)
Message-ID: <bdb78a67-ec6b-4178-81a0-212796f9738a@linaro.org>
Date: Sat, 25 May 2024 20:58:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v24 4/4] dt-binding: clock: remove nuvoton npcm845-clk
 bindings
To: Tomer Maimon <tmaimon77@gmail.com>, Rob Herring <robh@kernel.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
 krzysztof.kozlowski+dt@linaro.org, tali.perry1@gmail.com, joel@jms.id.au,
 venture@google.com, yuenn@google.com, benjaminfair@google.com,
 openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240509192411.2432066-1-tmaimon77@gmail.com>
 <20240509192411.2432066-5-tmaimon77@gmail.com>
 <20240513155330.GA2676859-robh@kernel.org>
 <CAP6Zq1hRw6xfNKKfBFGuKbZk0su3ys6+hnMzqRWrZeKzDoKLEw@mail.gmail.com>
 <CAP6Zq1gKp+Hu93CK=78chvNk70WtKMKUv8ny0Mzkw47wn7Af2g@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAP6Zq1gKp+Hu93CK=78chvNk70WtKMKUv8ny0Mzkw47wn7Af2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/05/2024 18:34, Tomer Maimon wrote:
> Hi Rob,
> 
> Kind reminder about the question in the mail thread below.
> Your response would be greatly appreciated.
> 
> Thanks,
> 
> Tomer
> 
> On Thu, 16 May 2024 at 12:44, Tomer Maimon <tmaimon77@gmail.com> wrote:
>>
>> Hi Rob,
>>
>> Thanks for your comment.
>>
>> On Mon, 13 May 2024 at 18:53, Rob Herring <robh@kernel.org> wrote:
>>>
>>> On Thu, May 09, 2024 at 10:24:11PM +0300, Tomer Maimon wrote:
>>>> Remove nuvoton,npcm845-clk binding since the NPCM8xx clock driver
>>>> using the auxiliary device framework and not the device tree framework.
>>>
>>> Again, this is an ABI break. Changing driver architecture for 1 OS is
>>> not a reason to change DT.
>> Is it an ABI break even if the NPCM8xx clock driver hasn't upstream
>> the kernel vanilla yet?
>>
>> I thought that since the NPCM8xx clock driver hasn't upstream the
>> kernel vanilla yet and and in the latest NPCM8xx clock driver patch
>> the NPCM8xx clock driver.
>> using auxiliary device framework instead of DT we should remove the
>> nuvoton,npcm845-clk.yaml file.
>> https://patchwork.kernel.org/project/linux-clk/patch/20240509192411.2432066-4-tmaimon77@gmail.com/
>>

Binding goes with the driver, so I wonder how did it happen that driver
is not in mainline but binding is?

Anyway, once binding is released other users might start to use it, so
yeah, could still be ABI break.


Best regards,
Krzysztof


