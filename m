Return-Path: <linux-kernel+bounces-408760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 861D59C833B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBD4EB257EB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 06:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46591EABB7;
	Thu, 14 Nov 2024 06:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AU3oic3U"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2A51E25F7
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 06:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731566247; cv=none; b=rvkPWebBVkHxpWmLbI/7Q+vECozfcYTfOevgAWe1Y2RXq1F/xPAtHRlt0ae9hN9JzAQ25UVZiRVpdAVzkE4mqPvdMKCbvfFLp7K36Tpfn6DXyJejhPC4UL74zCQ9ish+f0qxdogLuEJltGaEDLJlAlH0AKMdjS720kx+WR5XGzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731566247; c=relaxed/simple;
	bh=D7eafpNvziDosCf4eV8sdCGrPsd+nnKz0xCbmS5UA88=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=qb09hitsqo3hxT9tYHOoP7jUIsUHX1nr4+U94wO1SxOW40V2NGdN6i68b0cVhllekJFnwcEHKETodKN58lxu3J1FcTusCpWY6LkyBH1KRhfi6xvY/erGzsNvJCr7Cpx8hh8uaZp6jo7/EgVvBcc+FOZZH9E8rFRMv7UkeMzZCV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AU3oic3U; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43169902057so2549675e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 22:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731566243; x=1732171043; darn=vger.kernel.org;
        h=mime-version:date:user-agent:references:organization:in-reply-to
         :subject:cc:to:from:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OzA2oQZMAdaKXqd5iiIFp8MvCWhHHpRVX4RNggE14po=;
        b=AU3oic3UkDNqVHw+QwaQ3onOObqXv0x0OmxH2oqx+Z5hkhfarevUr19M+ZXaGmNb7m
         HaRZyHq411SAn5ZPhFte2J8wAW8Md9RvLE9HJOu69Lh6VdO/dOoyxsF82rUr4RjjaFdn
         d5cFMs9KBlxGdFmKk46npnXShN5wu+pCrC2RDSLWAGN/2HbZHCq10Ww5f2O883iYgWvX
         JjgS1hIEt8ld4T3nYgXlc/hlLp0dmHRd9SmIaRGK7VzDFd79iq/IPzMtgaE6+0RcgFT9
         kQa/weO3KXNI56TOwIecraofilCdgPHUZnewcPVQugn0TtxGz1oXAueM1DLqTjanE9jv
         rtXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731566243; x=1732171043;
        h=mime-version:date:user-agent:references:organization:in-reply-to
         :subject:cc:to:from:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OzA2oQZMAdaKXqd5iiIFp8MvCWhHHpRVX4RNggE14po=;
        b=Uw7sY/3gvjM/XgfGGNySzqOeLhPeBbGgILYaTGleaWo+GvknbkMk1RD5S83b4cmZi0
         P3ZBO2uFV0rW5mDbf/LJcPtecnLeX4fL5DhcYPRSUPk84kmnfPvjwKA3m8EQyutnHoH9
         MGOWdaOQe+jTNonvb5icEvf48zQcYe69iP/vuCt2MtTf4vYXnQmdJkTVxHhLFnJPbyWi
         YXo9fFC0oncLC0OFz9k23B32Cxk5bAyJSGK34KNz5uKt5ndd+bjrngTq1WIbJ5aKzIwl
         bP/FVcpKVbRLzau2Ddmo97WQD5oWc0HjAd6mPoRDWP0qFAHSxxv8CORssPsGRXnm6pi7
         FgYw==
X-Forwarded-Encrypted: i=1; AJvYcCVNrzB0y61Z+0vhBqi3TjhbyTY9j/oF2986whUgVgH+6X6T3vnP4p1ycKWaq4+JlxfDUx3gv69igeWoO7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+qcgR+Q7G3SR/3B1LoALRKMM63SUpI/P6EpvkyZ3ClknOI2dQ
	41Snxznw91lfO6cUOIvuuJzUf/sZDgGFV43+0isBtITpguyRmi1w
X-Google-Smtp-Source: AGHT+IF2q3VqNO6Ts4z+fwKPab8GgAycbFF5/LX6gjOIErWMjr82/KJwaZJbaL4+i+amj2qWDxcl7Q==
X-Received: by 2002:a05:600c:3b93:b0:431:2460:5574 with SMTP id 5b1f17b1804b1-432cd47d785mr74090465e9.27.1731566243334;
        Wed, 13 Nov 2024 22:37:23 -0800 (PST)
Received: from localhost ([37.72.3.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da28b76fsm12031765e9.28.2024.11.13.22.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 22:37:22 -0800 (PST)
Message-ID: <67359aa2.050a0220.cc412.2c60@mx.google.com>
X-Google-Original-Message-ID: <87y11m5nj3.fsf@>
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mikisabate@gmail.com>
To: paul.walmsley@sifive.com
Cc: palmer@dabbelt.com,  aou@eecs.berkeley.edu,
  linux-riscv@lists.infradead.org,  linux-kernel@vger.kernel.org,  Jesse
 Taube <jesse@rivosinc.com>,  Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [RESEND PATCH v2] riscv: hwprobe: export Zicntr and Zihpm
 extensions
In-Reply-To: <66f1cc93.050a0220.bf7a0.30f3@mx.google.com> ("Miquel
 =?utf-8?Q?Sabat=C3=A9=09Sol=C3=A0=22's?= message of "Mon, 23 Sep 2024
 22:16:17 +0200")
Organization: Linux Private Site
References: <20240913051324.8176-1-mikisabate@gmail.com>
	<66f1cc93.050a0220.bf7a0.30f3@mx.google.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 14 Nov 2024 07:37:20 +0100
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

On dl., de set. 23 2024, Miquel Sabat=C3=A9 Sol=C3=A0 wrote:

> On dv., de set. 13 2024, Miquel Sabat=C3=A9 Sol=C3=A0 wrote:
>
>> Export Zicntr and Zihpm ISA extensions through the hwprobe syscall.
>>
>> Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mikisabate@gmail.com>
>> Acked-by: Jesse Taube <jesse@rivosinc.com>
>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>> ---
>> This is a resend because I sent v2 as a reply to the original thread and
>> it most probably was lost by most people. Fortunately Conor picked it up
>> and gave it a review.
>>
>> I am resending this so it can be properly applied. Thank you for your ti=
me and
>> sorry for the inconvenience.
>>
>> Changes since v1 [1]: the EXT_KEY instructions have been written in orde=
r.
>>
>> [1] https://lore.kernel.org/linux-riscv/20240817075629.262318-1-mikisaba=
te@gmail.com/
>>
>>  Documentation/arch/riscv/hwprobe.rst  | 6 ++++++
>>  arch/riscv/include/uapi/asm/hwprobe.h | 2 ++
>>  arch/riscv/kernel/sys_hwprobe.c       | 2 ++
>>  3 files changed, 10 insertions(+)
>>
>> diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/r=
iscv/hwprobe.rst
>> index 3db60a0911df..cfd2929d0562 100644
>> --- a/Documentation/arch/riscv/hwprobe.rst
>> +++ b/Documentation/arch/riscv/hwprobe.rst
>> @@ -183,6 +183,9 @@ The following keys are defined:
>>         defined in the Atomic Compare-and-Swap (CAS) instructions manual=
 starting
>>         from commit 5059e0ca641c ("update to ratified").
>>
>> +  * :c:macro:`RISCV_HWPROBE_EXT_ZICNTR`: The Zicntr extension version 2=
.0
>> +       is supported as defined in the RISC-V ISA manual.
>> +
>>    * :c:macro:`RISCV_HWPROBE_EXT_ZICOND`: The Zicond extension is suppor=
ted as
>>         defined in the RISC-V Integer Conditional (Zicond) operations ex=
tension
>>         manual starting from commit 95cf1f9 ("Add changes requested by V=
ed
>> @@ -192,6 +195,9 @@ The following keys are defined:
>>         supported as defined in the RISC-V ISA manual starting from comm=
it
>>         d8ab5c78c207 ("Zihintpause is ratified").
>>
>> +  * :c:macro:`RISCV_HWPROBE_EXT_ZIHPM`: The Zihpm extension version 2.0
>> +       is supported as defined in the RISC-V ISA manual.
>> +
>>    * :c:macro:`RISCV_HWPROBE_EXT_ZVE32X`: The Vector sub-extension Zve32=
x is
>>      supported, as defined by version 1.0 of the RISC-V Vector extension=
 manual.
>>
>> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/=
uapi/asm/hwprobe.h
>> index b706c8e47b02..098a815b3fd4 100644
>> --- a/arch/riscv/include/uapi/asm/hwprobe.h
>> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
>> @@ -72,6 +72,8 @@ struct riscv_hwprobe {
>>  #define		RISCV_HWPROBE_EXT_ZCF		(1ULL << 46)
>>  #define		RISCV_HWPROBE_EXT_ZCMOP		(1ULL << 47)
>>  #define		RISCV_HWPROBE_EXT_ZAWRS		(1ULL << 48)
>> +#define		RISCV_HWPROBE_EXT_ZICNTR	(1ULL << 49)
>> +#define		RISCV_HWPROBE_EXT_ZIHPM		(1ULL << 50)
>>  #define RISCV_HWPROBE_KEY_CPUPERF_0	5
>>  #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
>>  #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
>> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwp=
robe.c
>> index 8d1b5c35d2a7..910b41b6a7ab 100644
>> --- a/arch/riscv/kernel/sys_hwprobe.c
>> +++ b/arch/riscv/kernel/sys_hwprobe.c
>> @@ -107,9 +107,11 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *=
pair,
>>  		EXT_KEY(ZCB);
>>  		EXT_KEY(ZCMOP);
>>  		EXT_KEY(ZICBOZ);
>> +		EXT_KEY(ZICNTR);
>>  		EXT_KEY(ZICOND);
>>  		EXT_KEY(ZIHINTNTL);
>>  		EXT_KEY(ZIHINTPAUSE);
>> +		EXT_KEY(ZIHPM);
>>  		EXT_KEY(ZIMOP);
>>  		EXT_KEY(ZKND);
>>  		EXT_KEY(ZKNE);
>
> Hello,
>
> Gently ping :) Can we get this merged for 6.12?
>
> Thanks!
> Miquel

Hello,

Gently ping :)

This will certainly not be included for 6.12, but is there a chance to
get it for 6.13?

Thanks,
Miquel

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJJBAEBCgAzFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmc1mqAVHG1pa2lzYWJh
dGVAZ21haWwuY29tAAoJEJa+jG/YnWVlV4wP/j4y+PeqDrmHtMXHGYzlooujiz2X
JtyKFhrkaPEhQMfTtA8DCoCWIVEsM66UL/waok64NO0/K8fCRRXzAcfJCiweSj4r
mb5T0YqqFdUEKmaxJBPnEW7yTcTspBI+zj1A4iE7MMqR+3OKTnI0bhSKBjobLyTj
HYSZj5RiLcdl/hAxiQ7j3L32l2OrIO32aXzte3zy5IRmt/y875OJgThdrlG8fFC7
AcyyxatezTcmcZW3j2xybWlkEh6/uOqUJeVbYT1XEa+gkUTNJyqrw/jVo3GYzmYL
OZP5BiWqdt93eAs55r7uCTQf1lO8dWUOEdx1Ebti33vjj2LSfRHq6XYSmdtTFgSU
qlz6UTSSrYepyHf5N9KzEXbBdZKzUFxq+Nql3tgIh2r1H0q/Un6F33Xfjjyuu/21
cTyD/wRSHt0D6za+/7heAZTOMVFD2OhpcUhONmxZ8l8RB3a1JYiLXiZkJ2PebKVb
Ls6ZG4XSVYeqMiQhjdYsT9Y0fnTuO2bSu2rYHHwjXSI9rx9w2CHT9b/tKrb6/o9G
FV9qj7rPZd2NBeRiOtTxqEXrcfKaB4tm7OnUcXWhoEgtuEgowKGyo+rMHjgcPBQv
shdBDyp07hm459wWGOV/Xza38P/QROfvwhrGZU++smBruoMQT4ZlNMcduXs72tej
/uQblIPKbMoQuaBE
=s9HY
-----END PGP SIGNATURE-----
--=-=-=--

