Return-Path: <linux-kernel+bounces-527127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDBDA407B5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 11:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 944F3177707
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 10:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C16320ADF8;
	Sat, 22 Feb 2025 10:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvS3dm01"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E0E20A5C2;
	Sat, 22 Feb 2025 10:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740221863; cv=none; b=IxH6tmk4xCfv5m4/+T0J5vqIl6SOS60+yUI33wflEvkOex3be3cY9+SPi0dFQQylUfVkCTrON9IUm4aI9N3anxx/kkwNWdcGNoxjQ/G2/KjvPu6fA4CRNTeysmqR8Ql9+r28+igZSDlfGZz41buQZo8cLHKazrnJWHOR4a4N1Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740221863; c=relaxed/simple;
	bh=sjhCpWHDs5bWXCiK6YdXjW8IscQrQTfZoLLhrEpATX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UgIwOeQm9xT/JWAh00C3w41NSPtTwPwOmbZQNXBCDvq9mwaRDb3lrlPZIiPtlbuZVqnwYijv9acoh3eOXQoerQJGwjFi2Xp86oNLlD2ICM/2NuDQjTaSq6mGD/sJ0umPV2Nv3WkFDpCGQ+hXNyAKxb/kAXENnMMYEA3qZRAV29g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvS3dm01; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e033c2f106so3810633a12.3;
        Sat, 22 Feb 2025 02:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740221860; x=1740826660; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Aw6pR2f8aOsPeIBUPQxbT1NRYua1Nx6Z20tWv/SkYUs=;
        b=EvS3dm01PdbqsRxI81dGRDa17kHWFS5xdUBWPexv9pHazCj7D9cnyjEgL13BkyMhxg
         K7CSpo4bNbECfhPHHz0r0U9V4WPUKcVRCKhe9YEmwEi7kR0bHU0y+TG3z93HfqGaMFJI
         MJblkC4pvgwaJEedjp5M4mUbUoDTGqCtSRoSuvZJDveoh9K/OSkb0zSFY7hyKKbUx4GA
         MXF7jFrGriWgKAYt9hxBrFGQRqTYkNqihuxTMQOWO3hWTYXEXdNoeVG2A0lAaw/0oTYC
         /dKj5Z0H0U8oYSxOJpBzDiDhnK1snv7eTEDAhHowxmg7dUCEU+EwbvVlBD+YGcmm79LG
         Bmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740221860; x=1740826660;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aw6pR2f8aOsPeIBUPQxbT1NRYua1Nx6Z20tWv/SkYUs=;
        b=EnGQmHK5HVZtKa/imL8JoD1e4Azw1uccwCTUHgP/+bMMNQZKaL5nVh1B/Bp+m2RKbL
         u/vRmE79X3i1wSF9OL5Y62kYI5tLf6sApcXT4dv2dLUz3/d8vPJv/U0yb06u6vW03iej
         5vdPURG8Y7cbKhC3V7XGHNafDli0iXRzthxdnRIpyb7uT0TVj/9UNdEfKRNoch+seatg
         J08a1gFdCvbkHzLI7ESJzhkfQB+nOHlwN4RkjHOrngIoXySMDRLqgeOFrdSldhlX3vbE
         pxzgXU7HH/u59+YzxD4C7Z9qDY7pHGAinASgihu9zqdnscLrDkOLP2ckMB7iL2uLQJcJ
         /ixA==
X-Forwarded-Encrypted: i=1; AJvYcCVSdXecJfuTMQKVxToSs9gT1IQNrM9P3FP2UsnGo+7ZrOa7Qumf+A/v72sF5jnPOeqNE180Qx/SAO5j@vger.kernel.org, AJvYcCWMQbBtgPQhvoJy86bOpk2XoEFjJAhYD45Fi4fkjFXNszbDkTI6JodvZ82M41qHvrvtKKq8wnpIwD1seUmQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxGXomcU4977a0RRfB9rRPF6Vbtn/dDyoEdk1R9fBqjhYpsMID/
	FdharXA0S6RRQsdon+9QfeucqZzTgiEqr8RWG8r1KFb4dCc6zRtV
X-Gm-Gg: ASbGncuXdM4/hK0mKb/5EZzj8v2S4/nMCw79k6SKU2iqoOhbefY77KQHqaa5/0HctLe
	1hgELYekhqmvQXtWB9I7qLaoZaZHCwH6wotE6g8mY+2pkWizoxL+T73uf1aYKDXgx4NDS3j7w8d
	h/d4x39QsHBsbuva6JjHHz44b7Ylr6ms0cbItJWal/1uJb0xc5l4jUZ8Kyx/Bu0quLxSEJ+Ij+S
	HHWtovAaM+SV5Ysfte51RE+oP1OxmF/8B70PkBe+pdO7YrQ8xSUaTQix2YfbF7cNlSnTAd4Guxj
	Aee5o0EmnAVZThVTEoS16D9VJaJ1/QHTCvYD8Sf1cRTzGWeGubwoMN3PY8bsc1yKtmeXLAAijhg
	b
X-Google-Smtp-Source: AGHT+IGnhvm54Vik2CF39bEJRoMEQ5ix1N9FJYonN4QOztOqVwTssq2Iz96ESOuZiaBNAxHqfsX97g==
X-Received: by 2002:a05:6402:234f:b0:5df:b6e1:4690 with SMTP id 4fb4d7f45d1cf-5e0b7106a9cmr14970904a12.12.1740221859769;
        Sat, 22 Feb 2025 02:57:39 -0800 (PST)
Received: from [192.168.50.244] (83.8.202.192.ipv4.supernova.orange.pl. [83.8.202.192])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5323225fsm1813486166b.24.2025.02.22.02.57.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2025 02:57:39 -0800 (PST)
Message-ID: <d68e179d-73ac-48d0-acb1-aab644cdf8c6@gmail.com>
Date: Sat, 22 Feb 2025 11:57:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/9] dt-bindings: mfd: brcm,bcm59056: Convert to YAML
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Stanislav Jakubek <stano.jakubek@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20250221-bcm59054-v5-0-065f516a9042@gmail.com>
 <20250221-bcm59054-v5-1-065f516a9042@gmail.com>
 <20250222-orthodox-black-mayfly-984ffc@krzk-bin>
From: Artur Weber <aweber.kernel@gmail.com>
Content-Language: en-US
In-Reply-To: <20250222-orthodox-black-mayfly-984ffc@krzk-bin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.02.2025 10:43, Krzysztof Kozlowski wrote:
> On Fri, Feb 21, 2025 at 09:16:23PM +0100, Artur Weber wrote:
>> Convert devicetree bindings for the Broadcom BCM59056 PMU MFD from
>> TXT to YAML format. This patch does not change any functionality;
>> the bindings remain the same.
>>
>> The bindings have been split into two parts: the MFD binding and
>> a separate binding for the regulator node, to simplify the addition
>> of other models later (which have different regulators).
>>
>> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
>> ---
>> Changes in v5:
>> - Replace mfd/brcm,bcm59056.yaml with mfd/brcm,bcm590xx.yaml in
>>    regulator binding description
>>
>> Changes in v4:
>> - Made $ref use full schema path
>> - Cleaned up example
>> - Dropped regulator name list comment
>> - Changed description of regulator binding to mention BCM59056
>>    explicitly
>> - Changed "Power Management IC" to "Power Management Unit" to match
>>    official Broadcom naming
>> - Renamed mfd/brcm,bcm59056.yaml to mfd/brcm,bcm590xx.yaml
> 
> I don't understand why the name became "xx", instead of matching exactly
> compatible. It wasn't like this when I reviewed it last time and this is
> really unexpected change.
> 
> Please follow standard rules: filename must match compatible.

The change was mostly to make it more generic; it felt a bit weird that
the BCM59054 regulator binding (added in the next patch) referenced a
binding named after BCM59056. But if this is not a problem, and a
concrete model number is required (even if it is only one of the
supported devices), then I'll switch back to the bcm59056 name.

Best regards
Artur

