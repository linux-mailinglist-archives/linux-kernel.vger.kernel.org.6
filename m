Return-Path: <linux-kernel+bounces-236283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1873091DFEF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0FFF2837C9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D14915A869;
	Mon,  1 Jul 2024 12:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gjqsJMiZ"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFBA158DAC
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 12:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719838409; cv=none; b=kdPGCmWtNl5+3vmkoXX5vLoCB7jot3ogmZoe7vYx+CQBgpae+ZrflB7PW3gk1HeVHgpHnRMkyPzUoRu3gmtog0w1hrrGy/HYLtAfT3Hwvt/7EEhjKSIpZ9V5IpfiyAse4TezK74dwpjZx61ct/QYqM6hR152UB+RNmq/4XMz6Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719838409; c=relaxed/simple;
	bh=ggHcRrATCWawOIFv3hL6A8ohViqNbuc5DfUNEHb7Ezc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GRcbo2DE8X2gAhyGeePHZ+18b9x/jTS3FRaP56yc9nPt9XbT/ayeZZHiveXwKZ29NWDkdZzLlZzJDVHGUTTZE0t/9hOMFO0V3RIBxu1FOurayRZliYhLSXj7I/q+52l5t6Tp4EzlG+aCj9UIK0xtey0eO80i3N9A+q0DDuLwzlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gjqsJMiZ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-364ff42999eso967837f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 05:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719838406; x=1720443206; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/8E2zTSxKsdYTXl/eFQJuC6tkBg5mMtLfz++9IP/rJs=;
        b=gjqsJMiZBSDhn2JkcmwzQJB98qzb6Qag56g2Y6flJY//iGGVpwlLzsMwhPb7SuEN0O
         nc0SdhYcEFC2QIyzanZPn1lE5reR/EnZynCmfX9SCatI620G5fkYLGW4F3TCgK/fML1W
         e0gdUbB9Ly8PiTCRzCOZOEAN51n29r8abmmToCdJ6hmFdcFIMPRVXn6HycEaq8XE1EWT
         0HdOVBkdt1DSCr+Jd5HwThM6GiFrmGpA73hkC8irNKQm1N0uMMpqzeDkugwkaRzNNCdW
         s7olWh4T/P1u8Ywd01hXRbau3WPQ02XwDps+T5iHuePSl9AfaNS0FiSxWy6yYlIFwvdB
         qkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719838406; x=1720443206;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/8E2zTSxKsdYTXl/eFQJuC6tkBg5mMtLfz++9IP/rJs=;
        b=E0tjiBt88GMRBoOzblFwDe3YbIziCFi+TZWpjMYCfCoRP/WOI3ysH8FwGQmJPzu28g
         FWzUsuMQ12SPF0va+KTsQvB9iuYGBV5SfREZnmSWuRGjB3iC+afcokTZwRh1zd5LjK0i
         9OVp1W0Nt9WU8FfYd06MnPV7GqExqH2MsVwU2iDEeeXSpaZH4MSFf7a3qb5K+JN32jDM
         zbc3+c+Cc9VWfPkSZQNSyXMMovWtrFSBCAHNv4rj6iY//BqMdt/K+8rQigTUsOa7ShCX
         fd/Hu+3PB0Wh0pwW6rtyOtGE6LelzfLwVQM0pk//y4qInZPHGQug/bTZ3uLQP9HBrssX
         Pmtw==
X-Forwarded-Encrypted: i=1; AJvYcCWO/zgaaGGCh7sRgrhU3jgvbPnhVBsf9LBKpR/eKdvXUfMpOpxndVS/ARXADDZDDZSyFN2EUryKEoAIo7C9bIVKzX2PYXzk03vNpQaK
X-Gm-Message-State: AOJu0YzK/SvKd7fiY/NKTPvcpgpW/XHtv8S+NDch0kW1r9LJvPj3HQ/2
	2fxliFK64R6xA+zjAFKbh707S3twWXFKrm9wLzmKih/o1sfUZeffXyy6E9ojw5kHbN1HYytgAqT
	b
X-Google-Smtp-Source: AGHT+IFsN5M7EmHtq0/p5K+Huwk+NrUQg51/5m34mJW9idpCbT3p95cPzf2wdQfK7yooDdM0biGapw==
X-Received: by 2002:adf:fe51:0:b0:367:40e6:46a7 with SMTP id ffacd0b85a97d-367756aaceemr3735232f8f.28.1719838406050;
        Mon, 01 Jul 2024 05:53:26 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.178])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0d9ef3sm10034544f8f.46.2024.07.01.05.53.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 05:53:25 -0700 (PDT)
Message-ID: <be8daf89-14a9-41ad-9403-8e550e5ae284@linaro.org>
Date: Mon, 1 Jul 2024 13:53:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] dt-bindings: mtd: macronix,mx25l12833f: add
 SPI-NOR chip
To: Erez <erezgeva2@gmail.com>
Cc: Esben Haabendal <esben@geanix.com>, Erez Geva <erezgeva@nwtime.org>,
 linux-mtd@lists.infradead.org, Pratyush Yadav <pratyush@kernel.org>,
 Michael Walle <mwalle@kernel.org>, linux-kernel@vger.kernel.org,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
References: <20240629103914.161530-1-erezgeva@nwtime.org>
 <20240629103914.161530-4-erezgeva@nwtime.org>
 <1c457520-07b7-4bde-b040-e8bca959a4f5@linaro.org>
 <CANeKEMOODBNZA6efh0E0Ga_KaVs5Y3WLcUftRhNwYHhnXO=GNw@mail.gmail.com>
 <CANeKEMO42rJt5Ob4_HDcZ3eEMvuMOPvRaFaLwL8SA65NtxSV7A@mail.gmail.com>
 <1d56c3b2-7adf-45b9-a509-956340f3f17b@linaro.org>
 <04f5162d-8a95-45ce-a891-3f711b27a469@linaro.org>
 <CANeKEMPAng8K1Gbab-MXP0KodS=r1Bzstsvg4zadWdu1O7wqWg@mail.gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CANeKEMPAng8K1Gbab-MXP0KodS=r1Bzstsvg4zadWdu1O7wqWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/1/24 12:03 PM, Erez wrote:
> On Mon, 1 Jul 2024 at 12:23, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>>
>>
>>
>> On 7/1/24 11:15 AM, Tudor Ambarus wrote:
>>>
>>>
>>> On 7/1/24 10:46 AM, Erez wrote:
>>>> When using mx25l12805d, we do not read SFDP.
>>>> As it uses the no-SFDP flags.
>>>> When using mx25l12833f hardware with mx25l12805d driver, it did not
>>>> try to read the SFDP.
>>>> Yet mx25l12833f does have SFDP, when I remove the no-SFDP flags, the
>>>> driver fetch the SFDP.
>>>>
>>>> Secondly SFDP does not contain OTP information.
>>>>
>>>> mx25l12805d has two OTP regions of 128 KiB and 384 KiB (yes asymmetric).
>>>> While mx25l12833f has two OTP regions of 512 KiB.
>>>>
>>>> How do we handle it?
>>>
>>> You would first try to parse SFDP and initialize the flash based on
>>> SFDP. If there's no SFDP then you fallback to the flags declared at
>>> flash declaration. Esben had a try recently, see [1]. I don't know if
>>> there's any progress in that direction.
>>>
>>
>> And you can then decide which OTP org to use based on whether SFDP is
>> present or not.
> 
> That can work, but sound like a hack.

It's not a hack, we're just doing our best to dynamically identify the
flash.

> Is that really that important to hack?

we push really hard against new compatibles. Users shouldn't care about
what SPI NOR flash is there.

> Just for OTP, that very few use?
> And if in the future Macronix adds a newer one with the same JEDEC ID,
> but a different OTP size?

we'll compare SFDP data and choose based on the differences. This is not
encouraged. Instead ask for unique IDs or choose other flash.

> Macronix does not consult with the Linux Kernel on these matters.
> 

I'm complaining about unique flash IDs for years now. Hopefully vendors
have learnt their lesson. I didn't see new flash designs reusing old IDs.

> Anyhow as I do not have the hardware anymore, I can not do more
> changes and test them.
> 

Be aware that we're not queuing patches without some minimal tests. If
you don't have the hardware, contact mchp and see if they care,
otherwise we're wasting our time. Here are the minimum testing requirements:
https://docs.kernel.org/driver-api/mtd/spi-nor.html#minimum-testing-requirements
For OTP we'll also need some OTP tests.

Cheers,
ta

