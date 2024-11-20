Return-Path: <linux-kernel+bounces-416384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7109D440A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 23:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B14D62822F0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 22:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7651BDA84;
	Wed, 20 Nov 2024 22:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0HHVXIl"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830F816EBEE;
	Wed, 20 Nov 2024 22:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732143226; cv=none; b=t1v3x+ZfDEet7YRsE1w9/zzT61cVXz5wCQmUf/D+97zwImroGDEKfNNXWcmYdypVR/SwZ4tM8mljlrQ4VOIhmX0I8vmto0bbEozC3FiHmqXlEFINrmcN7Myrxi902HYNf1jyGP1xq6Xl/uFlktw/mxwzRRN0p5sza9nbcx+ZQ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732143226; c=relaxed/simple;
	bh=U5mlwYngCJSzwalPkrojT/KkruaUO5ObHTRyXy1Llds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BcE3FlzFnITptfSDBhSgia6ULA9OQqJ2eKn524PFIthRzkPNvBmoJwnEl8dh9jMYw2Ci7Cofh9gSMlk5K4Qg2dRcuudQI9E/1tQQpJp2D6M538V2DrRPHWF5UySlVb6we+9L+dW8j+wIAPrIGrOyOdaufH+j4g8GGvn3hvmrRt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0HHVXIl; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-431616c23b5so1277215e9.0;
        Wed, 20 Nov 2024 14:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732143223; x=1732748023; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IsMj39NZqnVLxxCEfy2ZtKXA+QzcGZ/qO30hFJl13Ug=;
        b=X0HHVXIl0cNujzgwsKuPez8/w5vkgQ56MNpz81iTZDZBFewDodMgKqfQdOkbolvIog
         rxMULdZGiYCZAvbIgZSfm+T1w0tOpqgKPP/dtRe810Uj+8GOTHO/TTUYL7JX3vw+184I
         1z4xAXi2bTx96vZhk7tsvAEODgpkkP+TM14jx6xWvFW+0iIJxvB6lYLDTpOPRtya36Ou
         80/lPG1zPnFLHSM545pe2hkLM6+BGpwutwBTdseIV4KjpQJqG2mj2Zd58F+kpyvjZ4vl
         klW15kxqtb48rOGlwDSJWuf/OBFnwXVBTW9rNSnncwSZ4X11VO1EPOXdRoC+XXjEjAOp
         aMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732143223; x=1732748023;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IsMj39NZqnVLxxCEfy2ZtKXA+QzcGZ/qO30hFJl13Ug=;
        b=f2V6VTxfVrQI60oB8+kWVZUkzRV7Rt7YDvfNbpdKFbqTcQ4MzC5CXQ2kAaPTl6DWsQ
         pCJvQ1iSFvL340NYtN097VW2PJ1w0J/q3whuO8fBpeoAjDhCR5Im78PgqdRKz+7B+Bkg
         SGALYY5190Uc3DpEcWWIByQv7YrP88cdYoG6p7QNd7jxDJ5IiNlXywemEJFerGlbguc9
         pByh7bgMe0BEYT+Ou+zYXTPKBmsEQ1x03SllmTHucM0R8GtEw2GiKSXuOnUyA942fbp0
         xlPwhOg0SVRMzE4lvClKsOb9FcVT4l2ZNo0I3SgVLa3K1fmG1RjtpJD9fqprP94mC0RY
         Gbew==
X-Forwarded-Encrypted: i=1; AJvYcCVqyvXGeDeYIQyCayKNfDZMNEptRYRcRQLn1eC3I3WIH7VnInpDrcu517eKpzrIhQjAXibXbwDz98F5@vger.kernel.org, AJvYcCWiIqY20Vl3wLQ07ld8bEzEeKrCHNaEXHdv8pqIlXXVT22VKCLQyVtTfC9/Vn1ZQFkOI/clb0mxgmwEQhpT@vger.kernel.org
X-Gm-Message-State: AOJu0YzR8Am3gldenpu83FWJTaB9F7WtKnBMr6mQTCKStX+29o0btHT9
	8LWmLnkeSw5E+/yLqvQNBznCk3GADmFlF/rVVbfKdwnt9QZhef6YlzAHE0R9
X-Google-Smtp-Source: AGHT+IFRav4z1cOkCzYCYXk1rIn5A7PhHN81ImgrIxKlyZcUUavYCy4suGo9g782eOcqWEkJhrxMqw==
X-Received: by 2002:a05:600c:3ba0:b0:431:52da:9d89 with SMTP id 5b1f17b1804b1-433c5c9157bmr8608755e9.1.1732143222559;
        Wed, 20 Nov 2024 14:53:42 -0800 (PST)
Received: from [192.168.0.100] (85-193-33-171.rib.o2.cz. [85.193.33.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b45d395asm33728405e9.19.2024.11.20.14.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 14:53:41 -0800 (PST)
Message-ID: <f824fcb5-8c04-4a39-887c-64fed2439cef@gmail.com>
Date: Wed, 20 Nov 2024 23:53:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] dt-bindings: w1: ds2482: Add vcc-supply property
To: Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Stefan Wahren <stefan.wahren@chargebyte.com>,
 Ben Gardner <bgardner@wabtec.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20241115-ds2482-add-reg-v1-0-cc84b9aba126@gmail.com>
 <20241115-ds2482-add-reg-v1-3-cc84b9aba126@gmail.com>
 <20241115-happy-garter-2cf65f4b1290@spud>
 <83c8487c-2c50-4315-8244-ff80632165e9@gmail.com>
 <9896a38f-4b68-46a9-83b8-bf76abea47ba@kernel.org>
Content-Language: cs
From: =?UTF-8?B?S3J5xaF0b2YgxIxlcm7DvQ==?= <cleverline1mc@gmail.com>
In-Reply-To: <9896a38f-4b68-46a9-83b8-bf76abea47ba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

> On 20/11/2024 09:34, Kryštof Černý wrote:
>> Hello,
>>
>>> On Fri, Nov 15, 2024 at 03:58:06PM +0100, Kryštof Černý via B4 Relay wrote:
>>>> From: Kryštof Černý <cleverline1mc@gmail.com>
>>>>
>>>> Adds the newly added vcc-supply property to bindings.
>>>
>>> This commit message is a circular argument. You're adding it to the
>>> binding, which of course means it is newly added.
>>
>> You are right, I will replace with "Adds the vcc-supply property to
>> bindings." in the next version.
> 
> No, please say why, e.g. because it was missing and device has it
> according to datasheet.

Right, what about:

Adds the optional vcc-supply property to bindings, informs if the device 
needs a regulator to be turned on for its operation.


>>
>>>>
>>>> Signed-off-by: Kryštof Černý <cleverline1mc@gmail.com>
>>>> ---
>>>>    Documentation/devicetree/bindings/w1/maxim,ds2482.yaml | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/w1/maxim,ds2482.yaml b/Documentation/devicetree/bindings/w1/maxim,ds2482.yaml
>>>> index 422becc6e1fa8d58665c5586ebdc611cd0b2c760..a6b9e0658ec858cb24b21cf64443a061bb43e4ef 100644
>>>> --- a/Documentation/devicetree/bindings/w1/maxim,ds2482.yaml
>>>> +++ b/Documentation/devicetree/bindings/w1/maxim,ds2482.yaml
>>>> @@ -25,6 +25,9 @@ properties:
>>>>      reg:
>>>>        maxItems: 1
>>>>    
>>>> +  vcc-supply:
>>>> +    description: phandle of the regulator that provides the supply voltage.
>>>
>>> "vcc-supply: true" should suffice.
>>>
>>
>> Right, I suppose you mean to remove the description and just have
>> "vcc-supply: true".
>> If so, could you explain why no description? Is it some standard property
>> or because the name is self-explanatory? If you mean to keep both,
>> please reply.
> 
> It's almost self-explanatory and your description does not give any more
> information. git grep for existing code - you will find also examples
> which give actual information, e.g. detailed PIN name and accepted voltages.
> 

Thanks for the tip, best description I have come up with:

   vcc-supply:
     description:
       Regulator that drives the VCC pin (2.9-5.5 V). Depending on the 
hardware
       design, it may set the vcc voltage of 3 wire 1-Wire bus variant.

Would be glad for feedback if you think it's a good idea to use it, or
just keep "vcc-supply: true".

> 
> Best regards,
> Krzysztof

Thank you,
Kryštof Černý

