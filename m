Return-Path: <linux-kernel+bounces-291185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F92955E8D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 20:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55961F213A9
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 18:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD1214A61A;
	Sun, 18 Aug 2024 18:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QHjz6hjF"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C95C208CA
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 18:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724006941; cv=none; b=I9ZIr+mdSwbUVDBukeAtkAktd/zfKjzbqDzK5Gfe+zIsab6Lf8TKUcTzd4ZFHH0dK+kp9Iso9Fw5+DuIHsQ45aNaaZ6Ifc9nP/tMYWvASb9JR6xqgtxQxv6Y0K77kt0+fAy7XInB+J/pGL3hYtGpsOyFukA8z3ZgoDIs/cEvJ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724006941; c=relaxed/simple;
	bh=t10v0v9dLWsk9gV0B7bLGN+MoC4XU0HyTygfHBVThYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZSmSRtO4kJQaa1IMVyDJD+csHA6T0BdodxpyX+j9h8yfiHHEf9gkUHZ6NI/oZ2AaQIC5z0Dovl1a1RJedwPu83ZTcrfxbkq8S2iQgUluZhjp2A2Mz7+vLyLYcx+qzst8OlJDc2yvfeYm2UJulxmbYdokITbOl1N9xxa7/lOcXVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QHjz6hjF; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-371ba7e46easo295274f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 11:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724006938; x=1724611738; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4+ZVP0Q6mYnMoBlZBM0BE6acICxLb0FvKrUD3jvzYGg=;
        b=QHjz6hjFH3QA2GCy/Rxi60Ypt+JIRysFjXzLbc49Ra89Y4IK3zmN2KFqb9tUo1EFK5
         Jw7JmhQSkAvihJ76oHJ1233qsjZIATLU9YIfqNDYuTVQX6/wrUfNASgTcJfxChm0vMUA
         2tFNGIa6BDXw1mH9Fo/b4pmAxQa5Iy2pagLj8qMCBl9+uVe401F7b23BH3+IA9alc0ZG
         zJHn5azmXmhTt94a6cTT4oCsaqy68f9lc8sAoLq639jCGslAEuYwR1zKlMDdVs1WYIGQ
         Een3izzNMv7IKYBwtCIly0s2l3cTcMdTzUmlFrjfeWJa7lrdizN8eVe7zjxHeI24fPef
         h+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724006938; x=1724611738;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4+ZVP0Q6mYnMoBlZBM0BE6acICxLb0FvKrUD3jvzYGg=;
        b=j86xx0P9koFHwcIuIkodPcbsKqngvrJ10TiHAkaCnEVYzZreU1lRH7K1sXwjoE0kul
         8D9Lbi+QIazyIHjX9dzPcu5mjLpwoC6++AZEdZnhYkvXIxSrCjdv+t2PzQGltLXsqTIS
         h6qLHClP/ushuic/r9aCSm7xu9YkFyVd6d1OUI7aJ9zDnq44HZKHFZ4MTKhjOkaC+lgr
         NzQOx0s4kzhQgjAW1gEwykOYbFsdnvGe4AqR8hwOV0KkREJf9eXMxDa04a4WWyquZK7T
         HAx93tD7dHuGOxeLViWxV21FpZDDV+C1aarFm2FzCvwDwEu7mSL3LAYZmSVxeFGax/87
         FitQ==
X-Forwarded-Encrypted: i=1; AJvYcCV76YYOde7wHST+Z2w+Rt1KDgrjebsGG5DD1gbIJ9Tg+JieX2D4pVgYBhE2im5oWCnLvBTK3p0lC+vxmt9UBseDIWh+RAhxhAugp933
X-Gm-Message-State: AOJu0Ywt2wfPaBhnLDQTi/Vi2wFyE9sgtqz9d/jBR9H5+19U2UGeVAON
	S7XT5tmEacLblxnYMUgi6vCoPMAEcwFCEUOeNgpFr2qRJzgiRNMA6pn3PqHifSA=
X-Google-Smtp-Source: AGHT+IGdY03TPYHjen0YAzZR6SdVE9U3GU2ptlbdonStmceL8AePz4MTAvqlUNsmy/NvuKmbJIFU5g==
X-Received: by 2002:a5d:6784:0:b0:371:7c71:9ab2 with SMTP id ffacd0b85a97d-371946bf3f5mr5056266f8f.52.1724006937330;
        Sun, 18 Aug 2024 11:48:57 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189849606sm8696349f8f.32.2024.08.18.11.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Aug 2024 11:48:56 -0700 (PDT)
Message-ID: <526b6f56-7807-4bb6-9365-077b1cc490b2@linaro.org>
Date: Sun, 18 Aug 2024 20:48:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: display: renesas,du: narrow interrupts
 and resets per variants
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240818173003.122025-1-krzysztof.kozlowski@linaro.org>
 <20240818174137.GC29465@pendragon.ideasonboard.com>
 <4615f52b-4e4c-4fe4-bfef-a66e196410d7@linaro.org>
 <20240818175118.GF29465@pendragon.ideasonboard.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240818175118.GF29465@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/08/2024 19:51, Laurent Pinchart wrote:
> On Sun, Aug 18, 2024 at 07:44:22PM +0200, Krzysztof Kozlowski wrote:
>> On 18/08/2024 19:41, Laurent Pinchart wrote:
>>> Hi Krzysztof,
>>>
>>> Thank you for the patch.
>>>
>>> On Sun, Aug 18, 2024 at 07:30:02PM +0200, Krzysztof Kozlowski wrote:
>>>> Each variable-length property like interrupts or resets must have fixed
>>>> constraints on number of items for given variant in binding.  The
>>>> clauses in "if:then:" block should define both limits: upper and lower.
>>>
>>> I thought that, when only one of minItems or maxItems was specified, the
>>> other automatically defaulted to the same value. I'm pretty sure I
>>> recall Rob asking me to drop one of the two in some bindings. Has the
>>> rule changes ? Is it documented somewhere ?
>>
>> New dtschema changed it and, even if previous behavior is restored, the
>> size in if:then: always had to be constrained. You could have skipped
>> one side of limit if it was equal to outer/top-level limit, e.g:
>>
>> properties:
>>   clocks:
>>     minItems: 1
>>     maxItems: 2
>>
>>
>> if:then:properties:
>>   clocks:
>>     minItems: 2
> 
> Where can I find a description of the behaviour of the new dtschema
> (hopefully with some documentation) ?

No clue, but I feel there is some core concept missing. Your earlier
statement:
"I thought that, when only one of minItems or maxItems was specified, the"

was never logically correct for the "if:then", except for the case I
mentioned above. That's why all schema used as examples had it explicit:

My talk from 2022, page 30:
https://static.sched.com/hosted_files/osseu2022/bd/How%20to%20Get%20Your%20DT%20Schema%20Bindings%20Accepted%20in%20Less%20than%2010%20Iterations%20-%20Krzysztof%20Kozlowski%2C%20Linaro.pdf?_gl=1*kmzqmt*_gcl_au*MTU2MzQ1MjY0Mi4xNzIxNzE0NDc1
all constraints defined,.

My talk from 2023, page 34:
https://static.sched.com/hosted_files/eoss2023/a8/How%20to%20Get%20Your%20DT%20Schema%20Bindings%20Accepted%20in%20Less%20than%2010%20Iterations%20-%20Krzysztof%20Kozlowski%2C%20Linaro%20-%20ELCE%202023.pdf?_gl=1*1jgx6d3*_gcl_au*MTU2MzQ1MjY0Mi4xNzIxNzE0NDc1

Recently, I started using other example as "useful reference":
https://elixir.bootlin.com/linux/v6.8/source/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml#L132

That's nothing. All three above reference examples I keep giving are
already there and repeated in emails all the time.

So aren't you confusing the entire "skip one limit" for top-level
properties? This patch is not about it all and dtschema did not change.

Best regards,
Krzysztof


