Return-Path: <linux-kernel+bounces-248745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7290C92E16A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 276B22825A2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 07:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DACF14D283;
	Thu, 11 Jul 2024 07:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WzMJQ9Xa"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD5E4CB23
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 07:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720684681; cv=none; b=rvNV44Fi3fF1jHlb1ThhRYtY5roLwmBeMrcv0a9llZxD8wo4His3rIyc/PztTDHt7w71urHpNtci9Tfk/qXZIvKlXbfJ3mGHilLhpxAA4I8CDcANGsPUYkMaXOw6JQQqeTnKs50sN5P+SAo5AJhnK0DYkPDP1+8WZlPA1wBryZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720684681; c=relaxed/simple;
	bh=Jl7LbtNor/AZBViMkDaQwErv9uJgZebfqcmGpbq16aM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jaBCtU9jHDLW/d9i9Wczhtlr1FggQwB6Pj5WoxuXIDo3W8JVXgpvqzD0ny8hsdYycl1YOkVOD5jcuICJSb1yNHCWc+uItxTCdj+MQFc9TA4K9Nn95La+TQzK6YEWcvJMjgglDOvYFTiKxIdr/E9DLD3bJ4bo0KxTrRxt1xUz5kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WzMJQ9Xa; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so3323315e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 00:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720684678; x=1721289478; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AgM361BYAq0iGbtkT3hQE7bNR8KxM3q/tLCmdGxIpCw=;
        b=WzMJQ9Xanv3Ei7VL7UUI0vBdZAdHdaxJUKYTbV2fZnUy+8w3V+KhGiHgdaSbK7Yscx
         pFwasuMTOiH0E9EtDYUuk+VAfbgaI8jlkFRshD4cGATOhXwOtUtQeIFB+l7+UMAdLj1Y
         7xdO+cfoA7OQ8SxcNn4W2/uLog22hhGfc7JQrO6JONXW2q09xq6cVs/DxyJb9azweduR
         /H1yv/Mcso3stU+bj+97tWLLAK89wNOZYMCtrodUHpgHUv5qNpQjyxWLUTRCCZkQlUFu
         5c/dP+FurVvWmFQXZCCe4gYUm60Z2KD2KaqJT4rWzrBeUIJLyvTFrGJ5ZDNdsprAl4hs
         Umnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720684678; x=1721289478;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AgM361BYAq0iGbtkT3hQE7bNR8KxM3q/tLCmdGxIpCw=;
        b=Y1KBb2ThxyNUNThFPbCto0vbhnNz3wlr6oBGe02z4M0z3vCuo02646E3n+J7iMG8Pi
         fYQljP0SGZWMpfQ4J4iLSN5XHedV6wVrNowhw+JhLLYWZLj0ygbUxwZK2Ww3tDrkP4ne
         Q2cSmu14fsEtK+JtRGu3OImFDzhPQ0WpEzvbj6+TtJRsqO8OoGcUDFCLcaHiXSeVSO+6
         Oy2l/DcKWMu38pEgndmd2Ogj7geKygMTe2yCwaKiQj6nqO3D9YtdUtZagYrLkhwQFqcM
         8d+VlFb8HOdGomXM4cn7aDgJIqL5ipcHtJ+xp5uuZGDnbHkMuMcTOtCRHx12VhwKYIas
         fTzg==
X-Forwarded-Encrypted: i=1; AJvYcCVQhnycXZqxWb8UCidRbKDauKmNpslmbsJp874O3RtuPe+5Xa2Qm/0miYaB5aQCK5ne8kt5ZY54aQFNhq6M4auFocvWsoRH/t1eU+og
X-Gm-Message-State: AOJu0YxIs8vSmrCcQTI8q3DCUHTCDUXhMCZsQ/xYnM06WB0Q3IU2a0c/
	yNoQJv34Vp31vJm+078QNE2gb8dPqwD09Z9zpw7VDgTdoqnr7nYd7fVDHTxXUvdNtw+BHLxmbaK
	e
X-Google-Smtp-Source: AGHT+IHB0si76JZ9j6zbyRH35zyC5sWwKCluZCNVAxjobcDbOXwmVjBdrHMP2I2PmEw7TjfC4Y+S2Q==
X-Received: by 2002:a05:600c:5584:b0:426:6252:61d9 with SMTP id 5b1f17b1804b1-427981c524amr13627265e9.11.1720684678022;
        Thu, 11 Jul 2024 00:57:58 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6f07dasm107187775e9.12.2024.07.11.00.57.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 00:57:57 -0700 (PDT)
Message-ID: <b288d373-a1bc-46b9-9a08-4d949d1bd2bc@linaro.org>
Date: Thu, 11 Jul 2024 09:57:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: non-dt-devices: document ltr,ltrf216a used
 via ACPI PRP0001
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Marek Vasut <marex@denx.de>,
 Jonathan Cameron <jic23@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20240709084401.21108-1-krzysztof.kozlowski@linaro.org>
 <20240709170248.GA3803124-robh@kernel.org>
 <CAL_JsqL-wLzHmYN9Lntth3TKgpjfj3jxoGD5T49gSkDSMR=S_Q@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAL_JsqL-wLzHmYN9Lntth3TKgpjfj3jxoGD5T49gSkDSMR=S_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09/07/2024 22:48, Rob Herring wrote:
> On Tue, Jul 9, 2024 at 11:15 AM Rob Herring <robh@kernel.org> wrote:
>>
>> On Tue, Jul 09, 2024 at 10:44:01AM +0200, Krzysztof Kozlowski wrote:
>>> There is a device in the wild with non-updatable firmware coming with
>>> ACPI tables with rejected "ltr,ltrf216a" compatible.  Linux kernel still
>>> supports this device via ACPI PRP0001, however the compatible was never
>>> accepted to bindings.  Lack of bindings causes checkpatch.pl warning
>>> about undocumented compatible.
>>
>> Why do we care? For checkpatch.pl I really don't. That hack check I
>> wrote makes any string in binding docs a documented compatible. I have a
>> better check using the schema written, but that would make checkpatch
>> dependent on dtschema tools. So maybe just time to drop this check from
>> checkpatch as we have other ways to check and track this.

People still use checkpatch - both to actually test patches before
sending and also to fix random existing issues.

>>
>> However, I do care about 'make dt_compatible_check'. Besides these ACPI
>> cases, there's a bunch of cases that we'll never have schemas for. Like
>> everything from Sparc... Old PowerMac stuff... So I would like to
>> 'document' them just to exclude from dt_compatible_check. So perhaps
>> this should be generalized.

Sure, I can rewrite it to more generic.

> 
> Here's my list of what's really not documented. It's just a grep of
> the bindings of each compatible found by 'make dt_compatible_check'.
> Probably anything with SUNW, ibm, amcc, or mpc5 is never going to be
> documented.
> 
> There are some false positives such as cases documented like "fsl,<chip>-guts".

I'll come with something, maybe incomplete but it could grow later.

Best regards,
Krzysztof


