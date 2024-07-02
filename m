Return-Path: <linux-kernel+bounces-237262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E1791EE03
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 07:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E19AC281A68
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 05:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2616E433A6;
	Tue,  2 Jul 2024 05:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GXogSPsN"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3CE63D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 05:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719896455; cv=none; b=kfjSopMPRywaIyeB7VM3xpsj3X8MIF/XnIq5mNifhxnWqITcXbxwHz6nX/j1njQiXzsFt2CPosQYskynYe8Fk38CE5lrAXvcx822PESuz7oMK1Wq59bOUvhFm7GDtSAsBrsCbUu11XDMADxU8tdq4Le9xK4eh1L850TRj3T9zsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719896455; c=relaxed/simple;
	bh=dFheDiLhIaI57YogQUyG+EpL5SkPPbKUv/2WG6RhHmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Feq9VEAYd3EdwPIMZ2mE/SrapCGyJmzN4FBjLZ9EsJaaf4GMJcncBw2yPfbytgQK3dJXptNn3vWrXGKdkl1BeeRqvXZvpfbidt29IhEl5fnkXxK0Bv87orE32JrwWecc4PmvZm3AJP+18w7UDY8Njlv+UwRmLivtkTHNyFsBgjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GXogSPsN; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-36279cf6414so2126606f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 22:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719896452; x=1720501252; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rnm24fX3ACp6jY+bm6Eu7uHx1/D3EkceBo3lQmEL8aQ=;
        b=GXogSPsN79NYnuBYZdhmmqQqmHCefYN/Rc9DOR4Pl80XsyDk2nwf0+Rv5R9imzyAE3
         /PIkeaCSp3hktKhip1aikUJFZMU9//D1dTWH373gJjZc2YlnypGccGaA8rvltTx4P8Fq
         cN9dWnmrTGgpPpl2OAOciaT8tslRts474IaIq5XBTyvSN1QBXLJvJoUkoBRAQQfHowm0
         uwnAhq/pk/TAGQ94NvVqMvhFXjuVxc6VKrCFfeHQEYibh8DLAgrqIdYroc7zk6ROo8tq
         6416BbPbw19bcJ+rkWOsvUrB08qoikmth3t+rDjxFlb6nMvdYsFLfsyP13TLppnwaWSk
         PJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719896452; x=1720501252;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rnm24fX3ACp6jY+bm6Eu7uHx1/D3EkceBo3lQmEL8aQ=;
        b=E7g9FrPKrKmi0MEb6ptV8YjSxTLuSwfkqk6sAMzP9WGvwiZTjIkkTL8Z/NbrS4vH7n
         1S4LwlldV83VohNTBqxh+S4kJ2J7pBCrRLLqywEPevppjyLdAdBs6ZCpgOvO8uD7uMWu
         teE69DP+xRDAGRfqA0GhmPBJKuO4gFDQiahstfMFxYFpXKAD5WkWUfiueZgeJdURRS7e
         NZduvnbA5Epk0OeNUnHuzmjb59xf9mkW8UDbt/6K5f0afEae8t7x9NN0dR7mYqwPk/wF
         RCMGBSa4JPWCm1cEqmaiTbPTwaqJ4KIUsAo3pn6OZ2vCdnxp2RF4zdTAtXV+o4S3O5bE
         R5QA==
X-Forwarded-Encrypted: i=1; AJvYcCXT0KEgMAF2z1TQveCjjDS68gZ57BldVnslNkS4uzJ9zAGWPEFOPZxhieUc22V8uYAF2mur6hYDtCha7MannhdIa1fFThATn7aTvjhf
X-Gm-Message-State: AOJu0YxLx7k4CT9wioOeYAqFeINP2iL++qeRZSsypCwHQcbKsLJx4pVN
	1n1Orrjif4+Hb+XwngBdx6CvRg78MQBl5bdx91TbTFEEnfBZHcAApuSC17Rkqd0=
X-Google-Smtp-Source: AGHT+IEcg+p7l64JGDDwcQheoiWKVppnJcQN5fXI7KKnVigl7fXrrsPqoGfLQMv4M+WgyBBjDPqvCA==
X-Received: by 2002:a05:6000:1b04:b0:35f:2550:e276 with SMTP id ffacd0b85a97d-367756a3afdmr4042716f8f.5.1719896451663;
        Mon, 01 Jul 2024 22:00:51 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.178])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a10305fsm11871090f8f.96.2024.07.01.22.00.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 22:00:51 -0700 (PDT)
Message-ID: <3bafcbea-6aa5-43ca-9d12-3916be3fe03d@linaro.org>
Date: Tue, 2 Jul 2024 06:00:48 +0100
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
 <CANeKEMMe-Onpn7xWQHgWz1Ps_uQPEMa7HrKA00HpoKjG+DCJNQ@mail.gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CANeKEMMe-Onpn7xWQHgWz1Ps_uQPEMa7HrKA00HpoKjG+DCJNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/1/24 6:08 PM, Erez wrote:
> On Mon, 1 Jul 2024 at 12:15, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>>
>>
>>
>> On 7/1/24 10:46 AM, Erez wrote:
>>> When using mx25l12805d, we do not read SFDP.
>>> As it uses the no-SFDP flags.
>>> When using mx25l12833f hardware with mx25l12805d driver, it did not
>>> try to read the SFDP.
>>> Yet mx25l12833f does have SFDP, when I remove the no-SFDP flags, the
>>> driver fetch the SFDP.
>>>
>>> Secondly SFDP does not contain OTP information.
>>>
>>> mx25l12805d has two OTP regions of 128 KiB and 384 KiB (yes asymmetric).
>>> While mx25l12833f has two OTP regions of 512 KiB.
>>>
>>> How do we handle it?
>>
>> You would first try to parse SFDP and initialize the flash based on
>> SFDP. If there's no SFDP then you fallback to the flags declared at
>> flash declaration. Esben had a try recently, see [1]. I don't know if
>> there's any progress in that direction.
>>
>> Also, you haven't mentioned anything about the testing. Do you have the
>> flash?
>>
>> [1]
>> https://lore.kernel.org/linux-mtd/20240603-macronix-mx25l3205d-fixups-v2-0-ff98da26835c@geanix.com/
> 
> Looking at "mtd: spi-nor: macronix: workaround for device id re-use"
> I guess it can be applied to all Macronix devices.

No, no, we're going to do it individually just where it's needed.
Issuing unsupported commands is not that great.

> Adding something like the following in macronix_nor_default_init():
> 
> if (info>no_sfdp_flags)
>     info>no_sfdp_flags |= SPI_NOR_TRY_SFDP
> 
> It seems Macronix did many reuse of IDs.
> I saw it with "mx25l12833f" reusing "mx25l12805d".
> And Esben saw it with MX25L3233F reusing "MX25L3205D".
> 
> The only thing I notice is the flash using the same size.
> A sort of "backward" compatible.
> 
> Erez

