Return-Path: <linux-kernel+bounces-238980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D5892546C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 09:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1AE81F24DFF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 07:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49099136982;
	Wed,  3 Jul 2024 07:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PvfoMB/H"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C9913541F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 07:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719990753; cv=none; b=IS8bmB7U77bCLW+SE+4FXJUHiIfq3hCuO9GbXrGe/wFrm3CTZs1CsvZ9EsSwXRVVUdF4GZQ0pmOlwwFzEP1CB2j7APmK9ySxtiy0ctVzEIGEh8PUpZitwMJp5x1Oj9WJnQjwgpWjvEFOw+nGikIoZWwMkafrpShJLkqnJn1LCK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719990753; c=relaxed/simple;
	bh=Am2Zj/XbygcHJL6hbzAQW9hpTqGyzduNdAbYwSyiygc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bbPpxqSOM2gQ2Cl8nWLznGT9t0XLjGtf1fUJuFu3nDxvRSWY9Crb72/Z24L83IaHkqJKjZLyISGB82yM83hzaqt7vjsPuz7fMi53IPcRdeYNpyc4HdhDxJjnjY38cX4wDPkgAcFosc79XYR5N++hPVGkKeofjFeJ89VCyO2OOsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PvfoMB/H; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42564316479so30729655e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 00:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719990749; x=1720595549; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cWFXhnc8BcIFYpGOuy3wR7zVOKjADb3HoA8bSX4OUFg=;
        b=PvfoMB/HlJ07HPiHIxBvbOSNFMhxzGLTLozYJJM9WvZM/tuWX4qqemrLFS51oQ9QA0
         emqQ8KgM7UMORndQ07qy1gOtBFAWz+Je3cpu/EHLGc0jVFj1Xyn8lNR+ZG2tchwysNay
         cqLPes80i91tiLbfHdWbWLRotqp+mBcHpJqKOe6dIxwe8k36dHgSSAoRkNrsbMRpKYhF
         Syj9+Or/KkQqq/KufW5jhhJwJf17iUQK5gkFYQ28cwZmmQ1cTcFG6ae+xWhoRjzInWlI
         eFy3uNwJ8bnin7M3qYSMCArrO/yKxLUUhJ7S30j4wHTRXHqGAdfsJaZ5HMB7jFk5/tpx
         m/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719990749; x=1720595549;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cWFXhnc8BcIFYpGOuy3wR7zVOKjADb3HoA8bSX4OUFg=;
        b=R1FoDCL3Uui7/IqlRgoAliO04IVy30UMu2iD0TiIy75E93Ml6QGBB78tFcQ73KAxWO
         9pKgazRaD4qFb5JlfCarKPmuI1qlnhy4750kt/lzuFb0C4YkhE9mdWFcB0vFrZmcjbCH
         RJyaU+piV/evnjZpuEKVq7txnrR/SE3T329+zu6uoTyNp1Oef3AWqrSDe4DaLgnFEgxj
         HYQR8Cfx/7ENxp0FQkd7s0cS0MOj8CtgmqGFjSiMisQxJSRmLXdS+bLGienVGv5zkL8o
         ZvzPjpRi7X34YK+7yHKJ+K9lnTmNxBjcYrXnx1FmvmONU2J86V/c2PLoXXq3ipkwjL3o
         +Ceg==
X-Forwarded-Encrypted: i=1; AJvYcCUSHGFbUEBBqPelK3ewPdpVduttVvUVlwXaUcL4woJSFp2OlVkltsUz9KSjxS1tyyVQ2Hix1xzuJi///GvqeAp6734y3mp485XCmFil
X-Gm-Message-State: AOJu0Yx/5DbIiDhi5cpDIpWsxnCnPCf2pd7CsgLg19vMUMu1Szcpw7XO
	7cyu3TJOu2dxv5awNqnGsFXgcA4VwIi6XITkfRUtjsuFtn4dEtUl8eaT4Amloyxt0B7Z7G/GAg4
	h
X-Google-Smtp-Source: AGHT+IG9f45pPmVIrZS9vDFdht9aYCNia3Hfpo5hnorRWBlA6hyQsUb2I/AfJKRIbrngILxY1miQzQ==
X-Received: by 2002:a7b:cc96:0:b0:424:8ef1:816a with SMTP id 5b1f17b1804b1-4257a0257c1mr68440145e9.5.1719990749099;
        Wed, 03 Jul 2024 00:12:29 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b068d1fsm225431835e9.23.2024.07.03.00.12.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 00:12:28 -0700 (PDT)
Message-ID: <9b45cc73-2251-4085-af95-7ccd00dd6d3b@linaro.org>
Date: Wed, 3 Jul 2024 08:12:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] dt-bindings: mtd: macronix,mx25l12833f: add
 SPI-NOR chip
To: Erez <erezgeva2@gmail.com>, Jaime Liao <jaimeliao@mxic.com.tw>,
 leoyu@mxic.com.tw, Alvin Zhou <alvinzhou@mxic.com.tw>,
 Julien Su <juliensu@mxic.com.tw>
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
 <3bafcbea-6aa5-43ca-9d12-3916be3fe03d@linaro.org>
 <CANeKEMM02-Jvb8Pd0fZJFnRg-hsAW+hckYWm11tZZXNMPSPJ=w@mail.gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CANeKEMM02-Jvb8Pd0fZJFnRg-hsAW+hckYWm11tZZXNMPSPJ=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/3/24 12:16 AM, Erez wrote:
> On Tue, 2 Jul 2024 at 07:00, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>>
>>
>>
>> On 7/1/24 6:08 PM, Erez wrote:
>>> On Mon, 1 Jul 2024 at 12:15, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>>>>
>>>>
>>>>
>>>> On 7/1/24 10:46 AM, Erez wrote:
>>>>> When using mx25l12805d, we do not read SFDP.
>>>>> As it uses the no-SFDP flags.
>>>>> When using mx25l12833f hardware with mx25l12805d driver, it did not
>>>>> try to read the SFDP.
>>>>> Yet mx25l12833f does have SFDP, when I remove the no-SFDP flags, the
>>>>> driver fetch the SFDP.
>>>>>
>>>>> Secondly SFDP does not contain OTP information.
>>>>>
>>>>> mx25l12805d has two OTP regions of 128 KiB and 384 KiB (yes asymmetric).
>>>>> While mx25l12833f has two OTP regions of 512 KiB.
>>>>>
>>>>> How do we handle it?
>>>>
>>>> You would first try to parse SFDP and initialize the flash based on
>>>> SFDP. If there's no SFDP then you fallback to the flags declared at
>>>> flash declaration. Esben had a try recently, see [1]. I don't know if
>>>> there's any progress in that direction.
>>>>
>>>> Also, you haven't mentioned anything about the testing. Do you have the
>>>> flash?
>>>>
>>>> [1]
>>>> https://lore.kernel.org/linux-mtd/20240603-macronix-mx25l3205d-fixups-v2-0-ff98da26835c@geanix.com/
>>>
>>> Looking at "mtd: spi-nor: macronix: workaround for device id re-use"
>>> I guess it can be applied to all Macronix devices.
>>
>> No, no, we're going to do it individually just where it's needed.
>> Issuing unsupported commands is not that great.
> 
> Would be nice if we could ask Macronix directly.

we did. They said it's not ideal, but it's okay.
> 
> Looking on their web site and reading some spec. and status reports.
> Using the IDs with  'no_sfdp_flags' in drivers/mtd/spi-nor/macronix.c
> I did not search for new chips reusing IDs of chips at end of life.
> But we found 3 already:
> MX25U51245G appears in the table with the same ID as MX66U51235F.

is there an extension ID that differentiate the two?

> Esben Haabendal found MX25L3233F which reuses  MX25L3205D ID.
> And I found MX25L12833F reuses MX25L12805D ID.

Yes. And we already have a plan for these. We need someone that cares
about them to implement it.

> Chips that are not in end of life do support SFDP, at least the new
> versions of the chips according to their spec.
> It seems quite systematic.
> 

maybe

> By the way, the chip MX25L2005A part number is 'MX25L2005' without the 'A'.

feel free to propose a patch

> 
> We can support Macronix chips that are not in the table, just by
> reading the SFDP.
> In that case we can name them like "mx-szNN".

We don't care about the flash name.

If all the flash settings that we care about can be discovered by SFDP
then one won't need to declare a flash entry at all, and instead rely on
the driver to setup the flash settings solely based on the SFDP tables.
See spi-nor-generic handling.

> 
> The table below uses fixed width characters.
> 
> ID      Part.         Size              Status          SFDP status
> according to spec.
>                                                         New chip with
> SFDP for EOL
> c22012  MX25L2005(A)  SZ_256K =  2Mb    EOL             MX25L2006E
> c22532  MX25U2033E    SZ_256K =  2Mb    EOL
> c22013  MX25L4005A    SZ_512K =  4Mb    EOL
> c22533  MX25U4035     SZ_512K =  4Mb    EOL
> c22534  MX25U8035     SZ_1M   =  8Mb    EOL
> c22016  MX25L3205D    SZ_4M   =  32Mb   EOL             MX25L3233F
> c29e16  MX25L3255E    SZ_4M   =  32Mb   EOL
> c22017  MX25L6405D    SZ_8M   =  64Mb   EOL
> c22018  MX25L12805D   SZ_16M  =  128Mb  EOL             MX25L12833F
> c22538  MX25U12835F   SZ_16M  =  128Mb  EOL
> c2253a  MX66U51235F   SZ_64M  =  512Mb  EOL             MX25U51245G
> c22010  MX25L512E     SZ_64K  =  512Kb  NO_REC          Have-SFDP!
> c22015  MX25L1606E    SZ_2M   =  16Mb   NO_REC          Have-SFDP!
> c22536  MX25U3235F    SZ_4M   =  32Mb   NO_REC          Have-SFDP!
> c22816  MX25R3235F    SZ_4M   =  32Mb   NO_REC          Have-SFDP!
> c22537  MX25U6435F    SZ_8M   =  64Mb   NO_REC          Have-SFDP!
> c22019  MX25L25635E   SZ_32M  =  256Mb  NO_REC          Have-SFDP!
> c22539  MX25U25635F   SZ_32M  =  256Mb  NO_REC          Have-SFDP!
> c2201a  MX66L51235F   SZ_64M  =  512Mb  NO_REC          Have-SFDP!
> c2261b  MX66L1G55G    SZ_128M =  1Gb    NO_REC          Spec. is not public
> c22314  MX25V8035F    SZ_1M   =  8Mb    PROD            Have-SFDP!
> c22815  MX25R1635F    SZ_2M   =  16Mb   PROD            Have-SFDP!
> c2201b  MX66L1G45G    SZ_128M =  1Gb    PROD            Have-SFDP!
> c2253c  MX66U2G45G    SZ_256M =  2Gb    PROD            Have-SFDP!
> c2253a  MX25U51245G   SZ_64M  =  512Mb  PROD            Have-SFDP!
> 
> EOL     End of Life
> PROD    Normal Production
> NO_REC  Not recommend for new design
> 
> 

not sure what you want me to do with these.

Cheers,
ta

