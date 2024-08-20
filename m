Return-Path: <linux-kernel+bounces-293236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C59AF957C57
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F1F21F23F2C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 04:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBDF487A7;
	Tue, 20 Aug 2024 04:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d40eVsA1"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C344C3D0
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 04:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724127430; cv=none; b=BJ3W48vWGheRedeMajMUFgqEWyfHa/mHt09N5bLny3uJauJYCOxhKoIhiBhxCGUjH0S7bmvL0+NTz8PYYHkAEw5OMJ8uYRd3q+F97Q+jzKX0H+l0WTOcOUFKJrnTdih5MD3wmxvdQ/pk1gUi+cPdDaZVpA14h3YJKBT04RditgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724127430; c=relaxed/simple;
	bh=xDDDYeFx3N5m48mtrXvAoz4/Mu1SyZHhPISgi2U5pEA=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=b0gebjt5RJDs4nPOMO4VTKwJ9umPl0J8fYeSg6UBjeP3uOcItf4puyrYofSrPGnRzug6nDegAqNZM/8zkSClEWLyLhROJ11wLhJcf/fuKEwMQ8Fb3dK8eRhbhpyLhNwcvDv5/dJMBEXttLX/x6Lz7leXV8Y7Ftzn0imdxpAZ2MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d40eVsA1; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-428e1915e18so38042255e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 21:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724127426; x=1724732226; darn=vger.kernel.org;
        h=mime-version:date:references:organization:in-reply-to:subject:cc:to
         :from:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6nYfQ+o335s4lQFgidQZ6kpGNIQuA2JJ4wgm0P608e4=;
        b=d40eVsA1V9JolzDzugBVazfi1hkdW1f8gFhBHN6VgfdPCdlcEzenFnuJtz0kEN8Q4j
         ziodt2iKfE6DQzaPRZMSEsiGJJBI2/WTC3I5YDqNKo+kjW+2VVQRHPb1oSuHnk3wwKBi
         vu/CyqEo93X1+ec2NGA57dDMZ4ut9YZkFkjMTH/6DPJ19oF7TvOAAvDRiIKnexR+CX8+
         R2YucJAXU/VqTj7evQvM9oN05eXscBMAfG2CJrBgdicbEAMxw7pJPafhcRC+UY2b+XVg
         t0a3blOifAznGP3qhUV9Owdrh1GoNs23jiENloxyoCYYR8LLpflevb3ZFPBt+xanIpsi
         pAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724127426; x=1724732226;
        h=mime-version:date:references:organization:in-reply-to:subject:cc:to
         :from:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6nYfQ+o335s4lQFgidQZ6kpGNIQuA2JJ4wgm0P608e4=;
        b=eS4lgNaN6w8+XOZQHm1k5FEDx5wKU6GbBobubThRGXKunFj1i4YS1LGlEHH2/rPiN0
         HoGt6WvtnSyYyVhSNoqxCGY86oaA0xQTXT221kQUJGc/EDTVhRbgTe1XViQOjKdCdQVy
         pW1jiD7tKdeseMhb7Y8zN0wja63zjKob1k3kXf34iWEo5AQlneF43xaw0EaJjWt16D6c
         UWhwsZeXX8ZBIKSgVNrqWOeg/UbbEsxg+q6Bmo4rcRKJJgiYCHRh04SInOhcXEXIvpfG
         JIZ7420eak6eAN5KlfRI68PX78coQMqcBSAhibo4WhDi9XrMkz3JxiJMl3qg43y8cKtU
         2UCw==
X-Forwarded-Encrypted: i=1; AJvYcCXwHVGqvOOADxrtOHOmsvhUFIuhx3imbZXDV5m0tpFG+qMzXsOboLNwG80ngg3mfU+RJZTCbVsNrFyOpu5bCLgdEr1cP9TZurSzaEuT
X-Gm-Message-State: AOJu0YwNtzAj+SyRAWZTTnr5ByilnceWyENpvyVEgs2uGaRiybEVMJI9
	WpfMmA0OXIGLNsEnedVYMIvzN5R28HmcBWp51iNWpBxUhek0neGW
X-Google-Smtp-Source: AGHT+IFa5O3qI/O3a1pmL/zJlrIrTISpfHzoSNo9no9vBFGzyQLakuLu7bSel3CoZx32dgrBswTlpA==
X-Received: by 2002:a05:600c:4f89:b0:426:5c9b:dee6 with SMTP id 5b1f17b1804b1-429ed7e42f9mr82235865e9.26.1724127426322;
        Mon, 19 Aug 2024 21:17:06 -0700 (PDT)
Received: from localhost ([2a01:57a0:1620:4000::1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed650759sm127209705e9.14.2024.08.19.21.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 21:17:05 -0700 (PDT)
Message-ID: <66c418c1.7b0a0220.6faf8.1929@mx.google.com>
X-Google-Original-Message-ID: <87bk1n7rr3.fsf@>
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mikisabate@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Jesse Taube <jesse@rivosinc.com>,  paul.walmsley@sifive.com,
  palmer@dabbelt.com,  aou@eecs.berkeley.edu,
  linux-riscv@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: hwprobe: export Zicntr and Zihpm extensions
In-Reply-To: <20240819-unclamped-cheek-9b4851bed13f@spud> (Conor Dooley's
	message of "Mon, 19 Aug 2024 18:34:09 +0100")
Organization: Linux Private Site
References: <20240817075629.262318-1-mikisabate@gmail.com>
	<CALSpo=ZsZWNm_cXG_4GXyZ9invSS_eKH=9Q-mdoM2XV=HwzOXA@mail.gmail.com>
	<20240819-unclamped-cheek-9b4851bed13f@spud>
Date: Tue, 20 Aug 2024 06:17:04 +0200
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

> On Mon, Aug 19, 2024 at 01:29:16PM -0400, Jesse Taube wrote:
>> On Sat, Aug 17, 2024 at 3:58=E2=80=AFAM Miquel Sabat=C3=A9 Sol=C3=A0 <mi=
kisabate@gmail.com> wrote:
>> >
>> > Export Zicntr and Zihpm ISA extensions through the hwprobe syscall.
>> >
>> > Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mikisabate@gmail.com>
>> > ---
>> >  Documentation/arch/riscv/hwprobe.rst  | 6 ++++++
>> >  arch/riscv/include/uapi/asm/hwprobe.h | 2 ++
>> >  arch/riscv/kernel/sys_hwprobe.c       | 2 ++
>> >  3 files changed, 10 insertions(+)
>> >
>> > diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch=
/riscv/hwprobe.rst
>> > index 3db60a0911df..5bb69c985cce 100644
>> > --- a/Documentation/arch/riscv/hwprobe.rst
>> > +++ b/Documentation/arch/riscv/hwprobe.rst
>> > @@ -188,10 +188,16 @@ The following keys are defined:
>> >         manual starting from commit 95cf1f9 ("Add changes requested by=
 Ved
>> >         during signoff")
>> >
>> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZICNTR`: The Zicntr extension version=
 2.0
>> > +       is supported as defined in the RISC-V ISA manual.
>> > +
>> >    * :c:macro:`RISCV_HWPROBE_EXT_ZIHINTPAUSE`: The Zihintpause extensi=
on is
>> >         supported as defined in the RISC-V ISA manual starting from co=
mmit
>> >         d8ab5c78c207 ("Zihintpause is ratified").
>> >
>> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZIHPM`: The Zihpm extension version 2=
.0
>> > +       is supported as defined in the RISC-V ISA manual.
>> > +
>> >    * :c:macro:`RISCV_HWPROBE_EXT_ZVE32X`: The Vector sub-extension Zve=
32x is
>> >      supported, as defined by version 1.0 of the RISC-V Vector extensi=
on manual.
>> >
>> > diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/includ=
e/uapi/asm/hwprobe.h
>> > index b706c8e47b02..098a815b3fd4 100644
>> > --- a/arch/riscv/include/uapi/asm/hwprobe.h
>> > +++ b/arch/riscv/include/uapi/asm/hwprobe.h
>> > @@ -72,6 +72,8 @@ struct riscv_hwprobe {
>> >  #define                RISCV_HWPROBE_EXT_ZCF           (1ULL << 46)
>> >  #define                RISCV_HWPROBE_EXT_ZCMOP         (1ULL << 47)
>> >  #define                RISCV_HWPROBE_EXT_ZAWRS         (1ULL << 48)
>> > +#define                RISCV_HWPROBE_EXT_ZICNTR        (1ULL << 49)
>> > +#define                RISCV_HWPROBE_EXT_ZIHPM         (1ULL << 50)
>> >  #define RISCV_HWPROBE_KEY_CPUPERF_0    5
>> >  #define                RISCV_HWPROBE_MISALIGNED_UNKNOWN        (0 << =
0)
>> >  #define                RISCV_HWPROBE_MISALIGNED_EMULATED       (1 << =
0)
>
> The sort here, by number, is fine.
>
>> > diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_h=
wprobe.c
>> > index 8d1b5c35d2a7..30aede1c90ff 100644
>> > --- a/arch/riscv/kernel/sys_hwprobe.c
>> > +++ b/arch/riscv/kernel/sys_hwprobe.c
>> > @@ -118,6 +118,8 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe =
*pair,
>> >                 EXT_KEY(ZKSH);
>> >                 EXT_KEY(ZKT);
>> >                 EXT_KEY(ZTSO);
>> > +               EXT_KEY(ZICNTR);
>> > +               EXT_KEY(ZIHPM);
>>=20
>> Conor, do we care about ordering?
>
> I would rather that they were sorted alphabetically. Adding to the end
> is nothing but a conflict generator and makes it harder to see what is
> and what is not in the list. IIRC Palmer applied the patch I sent a few
> weeks ago that sorted the entries in all of these EXT_KEY() lists.

Makes a lot of sense. Let me send a new version of the patch with they
keys sorted.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJJBAEBCgAzFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmbEGMAVHG1pa2lzYWJh
dGVAZ21haWwuY29tAAoJEJa+jG/YnWVlcfIP+QEn+d6Py1HGavJblP1Osp5Q3kVS
jv0ay7yWo0uUftbQ/G45D1b/mKyEByEaKIDoNVic0i3jwlEkoGmyom/oqQw4NagC
5tNemOsZ2Z5HpYMfaSPM/qPfDRlmAXLJl+ltJUa8oNRQ8LK45Fg7FfDNNj5S2K22
JuYpTFP+EwqbxFP/ELlSLm4L/djLL95tWnNIgiS5CPrJHPtKD0TU05d/jQRVT2vm
xAcK+/zC1G5sZ9vwHvg6AsXr/5U+8g8vbVD91O4xg8H5E7gETKXSrHi9+jcseDtg
DiQLBkwFdVX9q0VUxCudDjJWmJv6G9K2nNW+GHMQjmzvLQaZAETF8lW5jvJxcMe6
smHKxDFtof1b5CHYJBDfBLptfH2/Lg4Uvg4yyQlou/nnrjQKXeWXkWJtwVkvuPx2
G1GZuarbi2PuPMnZ9zlJ2c1v4T+p4hkTL3B0oFqxmw3ZeCHqtoW1UsOtTLi9IcHI
y5F5GY4M/x5wOamFJcQJ9wPGxvIPjNFvmJospOQv7ULWdj5WHtequcT9SHFJ1VTz
o8u9YfIkhQGTpWtTOeuBdfdhmZSOCJ+oc+7g/R7r3ouxmulaCfCxCwNJofI40prM
sjBV/WsjaKV7bSARzhnZIA7mFn1jrxqHiq1G9NzUwYEjdRaYEBR9pr1c4cJCPKzi
eTNDHaVUxOu1eGJz
=aMf2
-----END PGP SIGNATURE-----
--=-=-=--

