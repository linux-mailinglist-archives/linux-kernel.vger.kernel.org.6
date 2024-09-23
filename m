Return-Path: <linux-kernel+bounces-336171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A28B97F017
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 20:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A58B42826BD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EFE19E99B;
	Mon, 23 Sep 2024 18:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jp/lA6us"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C268816419
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 18:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727114670; cv=none; b=qlY0M5jIjJwRqE1x+LdtBnFjut7t0EgPy3QZEWIug4IwRy47ncKvJEsn8GK/rd9oeT4zgWIn/f/Oac9Ekd9u2Dj0sbI03keCmdQeEI1BQ7IP8j6OVt6EUreVuyYFNSQcrT6jFHCA3MvDX1/QspBLP6MTuQjrN4BwiQUzOOMUMA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727114670; c=relaxed/simple;
	bh=j0dLNzzLvh6t14rPuKkZ9aTrMv/l4bq7wCWCny6hG/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dmPArR6NYfoWRNhilxsaHRiBjdcgjbeZ9rrJEA6AdLijumHcaF9jtaJonN+/HPbXTssnbSq9LnTTdPldRNYo3DqUN2qARqUwHfWgo3leNF2iNPJ2xE2pPFhwlb+u0E4MxSaecvikjmE4T4XZ8Uo3wtyO+NYbL5/cieakBW934k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jp/lA6us; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cd46f3a26so39950945e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 11:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727114667; x=1727719467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LO+W9KvBIp2SrrQN0yFY2AGl1nSxbm0owTQrCSAJb1Q=;
        b=jp/lA6ustuaIYp3AbrYrwW4QZk5DAVQNgj69RGP/jcEMSln0ndGRK621vr6rRamAjB
         2AU5H3942pbMD1AzEHxAIiZs9UM6XPrnJYHKKlI8VOn6WviFzX8FNjBx5vqLr3UNB4qE
         3iMnoa5B51moE2uEqk+s+ht0rw+8Uwy5VDBl/FBt8c3j1IRzKXF6EsGZ2IaJpO4kXfQ6
         pq6Fmm3P9RiKWe9jhiRQ3JFlV6FUPFbOWJEXXxBTfAQ80UO/jiAOIF2o4B55Wk/ajY47
         HTJ3cqkOXVVCkvkq/MchNvIwQr6qKoDCsvclb7207nT7wUr8UxkOOOgiseaRJ+vpnKSG
         nSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727114667; x=1727719467;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LO+W9KvBIp2SrrQN0yFY2AGl1nSxbm0owTQrCSAJb1Q=;
        b=B55zYnDekIiVb+uSOo4M6WPBC0N8vBF74RkpBHf0kncMOwGftIIFqWrhs+dTigewHE
         evlAcmC88hyR9yexILFc+qSBIIU8zG+McBAG3UzNSauvayMDgxwaD/gIQMHz46qqpxz6
         ZkUJ+nCUcYg0U7j6TyaO/U7ycVHjgeJnTHggJ4vSoc1LJdiNUSRMKZmj9xcr30GG11ck
         aUbEKsJBXPHlXhvvtHvw1fGgewb9FjZ+hJRHXnEv8/tAvwWqxq/W5GMHP29UdS8/8WNW
         S6SefgvJCoMiuPGwbm0+8wQnDn6g4AKk6dTye/TIbsVoQpmmk8qudKnkJYxX1IcEaKLa
         2Hyg==
X-Forwarded-Encrypted: i=1; AJvYcCV2DAT1lQQdP7QDE0Z796/3efjUTSWZEMJW9X452IltvCKKSiPLp7IypqsjK8UUiv6gF/2NFJw4Aj0asD0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1dLtvrfATJds5gD6YLB4pvFp7FoSXIRxd51ZE4rjyb8MXBJ6Y
	CfQ9QSYWBYBLufgnCEWnQyd+TIitcQxiVoOzUO/sGfI2cGkACq8zKnxWrd4eeKU=
X-Google-Smtp-Source: AGHT+IH4mIcSMeCsit/sQntDVwQ0Uc+MyXpCNWyrH63qvRncMa4pqbi8DXt4OST3RUWma7bFYxiwCA==
X-Received: by 2002:a05:600c:3591:b0:42c:b63e:fe8f with SMTP id 5b1f17b1804b1-42e7abfc4d8mr96428835e9.13.1727114667138;
        Mon, 23 Sep 2024 11:04:27 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7afd598dsm107400605e9.25.2024.09.23.11.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 11:04:25 -0700 (PDT)
Message-ID: <906df2b1-2827-444f-9de2-9b59f4d49b5c@linaro.org>
Date: Mon, 23 Sep 2024 19:04:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] mtd: spi-nor: core: add manufacturer flags
To: Erez <erezgeva2@gmail.com>, Michael Walle <mwalle@kernel.org>
Cc: Erez Geva <erezgeva@nwtime.org>, linux-mtd@lists.infradead.org,
 Pratyush Yadav <pratyush@kernel.org>, linux-kernel@vger.kernel.org,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Esben Haabendal <esben@geanix.com>
References: <20240920181231.20542-1-erezgeva@nwtime.org>
 <20240920181231.20542-2-erezgeva@nwtime.org>
 <4e0cf43c-4843-451c-ac6f-86775dbccb2b@linaro.org>
 <CANeKEMOmhAPM1j1_ihzcC2wL6jKsWXPCGfZs+euS8mRvtqgE5A@mail.gmail.com>
 <D4DLQGLJSKPB.3OOW4RU9Q3K5O@kernel.org>
 <CANeKEMPSoUu7GW5bL8nuyC5xCKG7Tt0=SvWTL_CcX5oebqN_YA@mail.gmail.com>
 <D4DSTDA3HE2B.20ACE70SQAL7A@kernel.org>
 <CANeKEMO1nyzEKGCt8N8_UCmAcQ3L53=H8U07AdJzcnFaVuwjGQ@mail.gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CANeKEMO1nyzEKGCt8N8_UCmAcQ3L53=H8U07AdJzcnFaVuwjGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/23/24 5:31 PM, Erez wrote:
> On Mon, 23 Sept 2024 at 18:19, Michael Walle <mwalle@kernel.org> wrote:
>>
>> Hi,
>>
>>>>> I would gladly remove the obsolete mx25l12805d.
>>>> Why? I don't see any need for that.
>>> Maybe because we do not want compatibility table?
>>
>> I don't get this? Anyway, we do not remove support for older
>> flashes for no reason.
> 
> I did not insist, you asked.
> Macronix stopped selling these chips 15 year ago.
> How long do you want to support old chips?
> 

as long as there's at least a user in the kernel.
>>
>>> No, reading the SFDP is great.
>>> Except for OTP parameters/configuration.
>>> As there is not way to find OTP parameters using JEDEC ID/SFDP
>>> So as I understand there are only 2 ways to set the OTP parameters:
>>> * Use a compatibility.
>>> * Use dynamic OTP configuration, through DT, sysfs,
>>
>> * Use the in-kernel database to look up the parameters as it is done
>>   with any other flash device. If the id is reused, look for
> 
> All IDs in table are reused.
> The change I suggest is to read SFDP to all Macronix chips.
> As today, we skip the RDSFDP. "to avoid no-op".
> 
>>   differences in the SFDP to figure out the correct flash device,
> 
> You can not do that unless you actually read the SFDP.
> 
>>   then add some .fixups to manually add the OTP flags and
>>   parameters.
> 
> I am in favour.
> As we can not use JEDEC ID or SFDP for OTP parameters.
> How do you suggest manually OTP parameters?

Michael literally just said how to do it. Here it is again:
```
* Use the in-kernel database to look up the parameters as it is done
  with any other flash device. If the id is reused, look for
  differences in the SFDP to figure out the correct flash device,
  then add some .fixups to manually add the OTP flags and
  parameters.
```
> Tudor Ambarus rejected my proposal.
> I am open to implementing your suggestion.
> 
> I will split the two patches to avoid confusion.
> So I will submit 2 patches:
> * Always read Macronix chips SFDP, as Macronix replaced all old chips
> in the Manufacture table.

I'll NACK it unless you prove that the old flavors of flashes are not
used anymore in the kernel.
> * Support Macronix OTP.

Hopefully this time you describe your problem in the commit message and
convince us it is worth fixing and that it makes sense for us to read
past the first paragraph.

