Return-Path: <linux-kernel+bounces-355306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF88A99504E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BF67B2494A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF621DF275;
	Tue,  8 Oct 2024 13:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOm0zczD"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C121DF25C
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 13:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728394723; cv=none; b=fCz0rmTZzsie94TTSe6XrPfEUmpuwlI7JQoZhRntNjWPjX8JLzifD9PdxM666Q4hW1Cvzf4nb8IOADp5SkPhFKAwXzYYAS5L17fIYT0tHfun6sFfwsUf3ZY3LRJQrzhdxe9e5ypJvsORb8ESPLIyiXLdtbVoOhvyt54v9Hu1C/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728394723; c=relaxed/simple;
	bh=O7F7DkDszVBtPnYmO6I8/XSm7j/bxdQC2/RJ5SWCkVg=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=a0sAv5HNduroernWgHur/81pqzrKQ7R8suVFBlgodILoyb7nR1ZvRJsdPfZyOLPzu3qBgQLIx9ocTAe24LuYQVOL0u6RoM0Ft9xR7lpaL09exzSpVADFk0/koR2Un707z6Oj+uhVxoaBk94jVYUDB4AUnpMIGpA0pNHU4Yv2FqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOm0zczD; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cb1e623d1so58087525e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 06:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728394720; x=1728999520; darn=vger.kernel.org;
        h=mime-version:date:references:organization:in-reply-to:subject:cc:to
         :from:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1wZp2tHXRVj599n6jKilEGvmOpN8GImObZN9K6SfAbU=;
        b=DOm0zczDF+wQq+vFxCAjycRlDXWB8m0Tx/3j5m2PvyRjJPd59X9crmm9fKkd7hzT7D
         PuKacGeDAHOH9NFT9dNCpdGXNqHE61f6MkiyoGOydLVyhP7WiBucwR3NipSizE/yN9vl
         JWoaIJjS+5qaJ3uGTlVMwrh276NPL5BdyeHOnvZE4aWJ3FOo9w2LJ55hm+2P6cFFDD61
         8V1LmaxuefeZMv1bTyMZW0xCa16/o12C8uVt4VL0TD8/JNaDpHRCeOAO3CoysPWNZxXw
         2ssBEGXbuVFwwRasB235jfpqtvBqr/o8sxeRTASkot39cHtHGdq6I6IZFe6oqb1g+qJm
         vuPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728394720; x=1728999520;
        h=mime-version:date:references:organization:in-reply-to:subject:cc:to
         :from:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wZp2tHXRVj599n6jKilEGvmOpN8GImObZN9K6SfAbU=;
        b=S+WnZVmRKIS94AtSJwR1MhYvo5ZyncJht2QUQ+ZbQW3yafYoetXsFUvflK/1faeIoU
         gSz9UzBw59FEuFxu6aIYlX9LmIkYJQT3O9bzzFEszjuYN3XfViCyk5t+mdqkufMCFtkG
         pOcIEEyYEDDaTsasH8HIJWUXEMKTpfRF0nlok7PrBy4MoY97Xb9OjY5ml1nr+ctG9B3j
         o2qrkIyUjNDpl5C/1pDnOgrLdr/DKWob0VsvT/w9qC49QmUnndONL15CUldflfP8WW8R
         CJtwhpm5FAT6V5LxzmZA4bGxIvA2kMpQEiVgN+aTUNh4t8H+mp52MTxFx/VapHDchC8w
         Pl6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWL7BC7/ZtQvgPRJx6X9MBqpkCG1WJUQjy299F0jkJI9w0j2bVgo+M74mwSFxAb3KnjnoVY7ZDKtpykZPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDi4PaBd+ShSxq4qCuBklb1svCBqIB342UsjOLhW+hFs11FztC
	iGSP+kB4vtc5Ohl2o0Fda9P8RxZryGBqdrV2vh5LW2gmAI76CjjwvUzhtGke
X-Google-Smtp-Source: AGHT+IE++4YsCN9P2R//nqGMop2IR/HKa2Sn4szClB5M0V4BBfQD2EJOaMhQG7nfvuwe1zbfVXyzxg==
X-Received: by 2002:a05:600c:1907:b0:42e:d463:3ea8 with SMTP id 5b1f17b1804b1-42f85aefaeamr139847595e9.34.1728394719619;
        Tue, 08 Oct 2024 06:38:39 -0700 (PDT)
Received: from localhost ([37.72.3.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b1d7aasm126435085e9.27.2024.10.08.06.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 06:38:38 -0700 (PDT)
Message-ID: <670535de.7b0a0220.311e0d.f680@mx.google.com>
X-Google-Original-Message-ID: <875xq2af4y.fsf@>
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mikisabate@gmail.com>
To: paul.walmsley@sifive.com
Cc: palmer@dabbelt.com,  aou@eecs.berkeley.edu,  cuiyunhui@bytedance.com,
  sudeep.holla@arm.com,  jeremy.linton@arm.com,  sunilvl@ventanamicro.com,
  linux-riscv@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Prevent a bad reference count on CPU nodes
In-Reply-To: <66fa9afe.5d0a0220.323a97.bfb6@mx.google.com> ("Miquel
 =?utf-8?Q?Sabat=C3=A9=09Sol=C3=A0=22's?= message of "Mon, 30 Sep 2024
 14:35:05 +0200")
Organization: Linux Private Site
References: <20240913080053.36636-1-mikisabate@gmail.com>
	<66fa9afe.5d0a0220.323a97.bfb6@mx.google.com>
Date: Tue, 08 Oct 2024 15:38:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On dl., de set. 30 2024, Miquel Sabat=C3=A9 Sol=C3=A0 wrote:

> On dv., de set. 13 2024, Miquel Sabat=C3=A9 Sol=C3=A0 wrote:
>
>> When populating cache leaves we previously fetched the CPU device node
>> at the very beginning. But when ACPI is enabled we go through a
>> specific branch which returns early and does not call 'of_node_put' for
>> the node that was acquired.
>>
>> Since we are not using a CPU device node for the ACPI code anyways, we
>> can simply move the initialization of it just passed the ACPI block, and
>> we are guaranteed to have an 'of_node_put' call for the acquired node.
>> This prevents a bad reference count of the CPU device node.
>>
>> Moreover, the previous function did not check for errors when acquiring
>> the device node, so a return -ENOENT has been added for that case.
>>
>> Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mikisabate@gmail.com>
>> ---
>> I was wondering if this should also be sent to stable, but  I have not s=
een
>> a report on it, and this is not responsible for an oops or anything like=
 that.
>> So in the end I decided not to, but maybe you consider otherwise.
>>
>>  arch/riscv/kernel/cacheinfo.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo=
.c
>> index d6c108c50cba..d32dfdba083e 100644
>> --- a/arch/riscv/kernel/cacheinfo.c
>> +++ b/arch/riscv/kernel/cacheinfo.c
>> @@ -75,8 +75,7 @@ int populate_cache_leaves(unsigned int cpu)
>>  {
>>  	struct cpu_cacheinfo *this_cpu_ci =3D get_cpu_cacheinfo(cpu);
>>  	struct cacheinfo *this_leaf =3D this_cpu_ci->info_list;
>> -	struct device_node *np =3D of_cpu_device_node_get(cpu);
>> -	struct device_node *prev =3D NULL;
>> +	struct device_node *np, *prev;
>>  	int levels =3D 1, level =3D 1;
>>
>>  	if (!acpi_disabled) {
>> @@ -100,6 +99,10 @@ int populate_cache_leaves(unsigned int cpu)
>>  		return 0;
>>  	}
>>
>> +	np =3D of_cpu_device_node_get(cpu);
>> +	if (!np)
>> +		return -ENOENT;
>> +
>>  	if (of_property_read_bool(np, "cache-size"))
>>  		ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
>>  	if (of_property_read_bool(np, "i-cache-size"))
>
> Gently ping :)
>
> Could you take a look at this fix?
>
> Thanks,
> Miquel

Hello,

Would it make sense to have this fix for rc3?

Thanks,
Miquel

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJJBAEBCgAzFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmcFNd0VHG1pa2lzYWJh
dGVAZ21haWwuY29tAAoJEJa+jG/YnWVlViIP/iA9tLidyLAf2yzky8Evu0OzkyBC
UKkB23+kmV4FXcFJdqSXfoe2kcoE71WABu8YouvkqULVppZ9L0SqAfREkPK1OX4b
i2EF0Yo8yv7Ws8nLDskp9waIhqOkNL7pZUw+bSkkd4Gt13sob6tR6AMCgG3AzkzJ
StAXxOtNy2+CCc7SUxFiaZJ/bSfTC8onZCSyqP8DmIOY0k5vkux+Lb9Cu2IINDAl
fp5rmg7vSAzgxOSmRJTMgklO58ty5U3oyp9JphIILT7IB76hmhKlMtRzqej++DP3
3H0b47S6xoYWfNrSzzi91Qz/VM0VxXHWh/GBsiA25uVtKnbGPBMUOC4dQucO+ItJ
Fle5BkGV1UE/ewNaZOtGP0VuvdTJkFy1S2HAoAK7WIkelxxYrLji20tHty7EO++/
GphVSFccmW9NTz6c9ViSDIg0dFxPUpwXIEqvtllfsOl+yLN4pvyIzSTQU3+Uc7CH
AqqIg7C2XqunZHQK/R+qN3eSbbQDoPdosSqsU1PIXAVF2Ct3pALpqOmadDXX9uw5
mH2Ap6daxU7/0P8XGOsgNc6EN/i70VN3ykRwCpMePyeJZmFnAlf+tv7zaqMaKsuR
9StTYIi3Purg5AjBk1AJFaWWUMIOrl0inMGBMBebeYEYtf3Dd0Yjcn4Y0+T0ofTY
Xh455iygLvLieuL3
=5wnw
-----END PGP SIGNATURE-----
--=-=-=--

