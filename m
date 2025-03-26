Return-Path: <linux-kernel+bounces-576822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CD5A714D2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C70291895B6E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1261B87C9;
	Wed, 26 Mar 2025 10:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XPPhUaHM"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34A11A8405
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 10:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742984772; cv=none; b=Mt9qL7ev24VEaO/B9PQavi2qiL34VJ4yrEB0JD3wkaxaiYR1onL4kNNArXSDvLysCNofZHFno7E0JjHcVPxYZHKSVSIggRmq6+8s0JUxRy0+9EluNFfvErOnfU8AmSOBswmL8Mb5mTl4s/ib4ZtqOzIDVaWkvYCTf3jgAwt8f+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742984772; c=relaxed/simple;
	bh=VmZW3dYOkE+WcIdW+rTFDYurYECcNeudvlHZ1LESI8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FwTKJ35wTsCKi3fBgAsq+IWmjdjcoSgc2duZWUdod10vNraDB41mhEkgbT+3JtCvBzQN3YWF0myukBSfM1+myx4NPDVxd6nM59pkhLp1FfF6mIRB384v+8PcpEYuqC+QImPykXhHxrGrHuihKAg5I8Ib6XgLoXwq00PcTnqQdWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XPPhUaHM; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so63824295e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 03:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742984769; x=1743589569; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=98hcAito2MMtQTY1iL6KWHxMYRyo687ywiMmqIh+p7A=;
        b=XPPhUaHMMHildxl7E/pGbg3LqEdcenwWvdjeuLPj1f8OT7a6BYtjs2bu24XtbAnFFY
         s9+jVhzzy9BFkI3JMO+QBwfdpCUz6XYuPUqDbZPhh1GKp+3K27W5+fCppeyI/7od9GV5
         scsDjSsDhiRkFPWlWeter1dzRKgY0BJ24tX0Zakn7d3gRB/jl78ONFJba5+ry4db+fqB
         w+6iIB3FLjU3RMJ99bkzWnP317J2KjottjvJYV3+hj66I0kjq40id1xBzpo5I2EkX5wd
         w/9qMcNz3WXfeWm2gcUcFe6Pwo2OXAUJ2wzYK+dfZXPPfP1ln1vMQLy1bUed15eH795l
         DSVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742984769; x=1743589569;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=98hcAito2MMtQTY1iL6KWHxMYRyo687ywiMmqIh+p7A=;
        b=JqfMAMrP3KDlTn9ae30bJRufJ8wtu5AU86gp54UnwRAk8LYG7zABRi9R0RJw5tpGY/
         dp+l2yvr20BZOU/KjKt46gKEcYR1k8m5ngmXWP5XChHEYS4kukdkhkWHpc/2Vxa8DfhS
         BFMA6e1Kvr6qyzp0meo++ZFH0jsag4/hnf0wzNYmV3OYQIEWW+sP/eBHJNWI1bMIGjJa
         cjfFYTcse1aIYL1+GyCyT25AUR4jeR3BZHLqXgmETC0U6I2iQigj82CB3O1j5WBypvTS
         VVeIBlDYKH2CgFlKrIX6QgpcokT0BFFJsNw+cMLyMbcYcui4XA/JF9Eay/+Dm4KqPMMi
         I5Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUp9df03tpplqlSnzqTWszojsbTg0uoLsY6Z+bEMd4xmiZX87klB88z2hjma28M3ryF2bh5obXNrhnES0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPUZg7iaq5pvHH53SMk9rpgi+6o4yJek6Bh2mIv0auwSDgL8qz
	11RSuK6+M06Cy0gI3hGCST0+X+bP/rQM5FsoPlCWWapvoQF377XMfRk+Tt3OQxMvck03GilZPrq
	IxjM=
X-Gm-Gg: ASbGncv7BP9GpqojDPzrOQjWnkckhdEZonBPJ+R9YeMH3bza/Un16gbv8bMvDyOc2ja
	RYcjFksTfudepteqKP9C78H+uI7xRPwlaU/+ZwRH2ZZXQBAnv8dL6JYLh8jtM1fP+oX7T95+Nma
	/IPLnZeVhjjga7YBmoHCBWtrY0mQq0wH98ma7Q0nU26mta+Kxl35mbXxSAUPXb4dbtyX6eofVEL
	g6t1suj1PKSOCqTJ0//t7hU6Uyg86rRUNNvnxwKX5lAb6wgk09KRvg1VXihdOarwKhCGJhAX3Bx
	0A82d7uwsc4HBzRatneusUxZxLVxqxyDc0kjM/oY8KJ0q5RgBYzWN8QhlSHV+e2y+Pb8TBuw3go
	=
X-Google-Smtp-Source: AGHT+IFNIgbM5SxndZJ31+RxAuvmVblk7zrUQEK1IUI9dhFX9c6aTpE7fdxiqMV2lHxT/eOf35nkUw==
X-Received: by 2002:a05:600c:c0d:b0:43d:738:4a9 with SMTP id 5b1f17b1804b1-43d50a33d03mr154416225e9.27.1742984768921;
        Wed, 26 Mar 2025 03:26:08 -0700 (PDT)
Received: from [192.168.1.38] (i5E863BED.versanet.de. [94.134.59.237])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9e6651sm16436745f8f.75.2025.03.26.03.26.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 03:26:08 -0700 (PDT)
Message-ID: <5060c248-3160-4d52-81ec-8e06bbd246bf@linaro.org>
Date: Wed, 26 Mar 2025 11:26:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] dt-bindings: input: syna,rmi4: document
 syna,pdt-fallback-desc
To: Krzysztof Kozlowski <krzk@kernel.org>, David Heidelberg <david@ixit.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Vincent Huang <vincent.huang@tw.synaptics.com>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20250308-synaptics-rmi4-v3-0-215d3e7289a2@ixit.cz>
 <20250308-synaptics-rmi4-v3-1-215d3e7289a2@ixit.cz>
 <20250310-hissing-vagabond-pegasus-cc8aed@krzk-bin>
 <3c5e12fc-eb91-46e8-a558-9896f0bdcab4@ixit.cz>
 <b3a5ec89-0125-4b01-8cca-69b9985b6089@kernel.org>
 <48bb62eb-8aa9-465c-9e77-c0b375df0c9f@linaro.org>
 <492da0ab-3a5c-4ee9-bc37-d66b007ffd81@kernel.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <492da0ab-3a5c-4ee9-bc37-d66b007ffd81@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/26/25 07:57, Krzysztof Kozlowski wrote:
> On 25/03/2025 14:23, Caleb Connolly wrote:
>>
>>
>> On 3/25/25 08:36, Krzysztof Kozlowski wrote:
>>> On 24/03/2025 19:00, David Heidelberg wrote:
>>>> On 10/03/2025 10:45, Krzysztof Kozlowski wrote:
>>>>> On Sat, Mar 08, 2025 at 03:08:37PM +0100, David Heidelberg wrote:
>>>>>> From: Caleb Connolly <caleb.connolly@linaro.org>
>>>>>>
>>>>>> This new property allows devices to specify some register values which
>>>>>> are missing on units with third party replacement displays. These
>>>>>> displays use unofficial touch ICs which only implement a subset of the
>>>>>> RMI4 specification.
>>>>>
>>>>> These are different ICs, so they have their own compatibles. Why this
>>>>> cannot be deduced from the compatible?
>>>>
>>>> Yes, but these identify as the originals.
>>>
>>>
>>> It does not matter how they identify. You have the compatible for them.
>>> If you cannot add compatible for them, how can you add dedicated
>>> property for them?
>>
>> Hi Krzysztof,
>>
>> There are an unknown number of knock-off RMI4 chips which are sold in
>> cheap replacement display panels from multiple vendors. We suspect
>> there's more than one implementation.
>>
>> A new compatible string wouldn't help us, since we use the same DTB on
>> fully original hardware as on hardware with replacement parts.
>>
>> The proposed new property describes configuration registers which are
>> present on original RMI4 chips but missing on the third party ones, the
>> contents of the registers is static.
> 
> 
> So you want to add redundant information for existing compatible, while
> claiming you cannot deduce it from that existing compatible... Well,
> no.. you cannot be sure that only chosen boards will have touchscreens
> replaced, thus you will have to add this property to every board using
> this compatible making it equal to the compatible and we are back at my
> original comment. This is deducible from the compatible. If not the new
> one, then from old one.

hmm I see, so instead we should add a compatible for the specific 
variant (S3320 or something) of RMI4 in this device and handle this in 
the driver? I think that makes sense.

> 
> Best regards,
> Krzysztof

-- 
Caleb (they/them)


