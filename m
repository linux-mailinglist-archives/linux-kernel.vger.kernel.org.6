Return-Path: <linux-kernel+bounces-321289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D13A19717EF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE6231C225AE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CB71B5833;
	Mon,  9 Sep 2024 11:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SexZVzDP"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93E31B3725
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 11:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725881939; cv=none; b=ZDkqufvaFyB5EqfYwZb+U2KzKupEnYfC+qSm/cU2iHmk2KcyNwoXuhRCrXMEwCZkdXYG4b06aHeCB1LcufMcCrOF0sT7B46Wqraul8KWfV62XXa7MgZD5w0CzCkJ/FrPqH9cNNXUE0OJzBrT3a/RLKy3Z46aWdKc440o+5+wVdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725881939; c=relaxed/simple;
	bh=SjN/w/Z+jAtEcgHEKtPQfqWw4dlsbVVGSNQ7LZriUQo=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=sshawedK71IAQPq3VPjlcNERr4cxjk5UpF7QwciczU4foibNwAaxsa2zHnCziUQgNNH/E+VkYzT+MIXbR+OsZyX4oqX2xLwbQjy9SEcKAYW3tetWfAs5QcEIhyrTh79ZFZB0msmGVhu/ofIvFrWWzp/kSIZp3CB0my5tz7I+TjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SexZVzDP; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cacabd2e0so21357505e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 04:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725881936; x=1726486736; darn=vger.kernel.org;
        h=mime-version:date:references:organization:in-reply-to:subject:cc:to
         :from:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W26nZdJnLBsIfHz/s3jK5jdIhMQf+KGV6UKCsoG9vuM=;
        b=SexZVzDPmf5Ir/Iank1wG/AB2r5g/9UvAiuUA80k/bUSeP/Q9Vr1oJq+eUSbzo+tTE
         0zOA6u4plLMyD/r/LIm9UvX/OCwRlqAujtpdx0/bcJTEVIhK4bzXf3lrOOhF3PWA5Xfp
         TwuK8Brl3dq+ILSXdglEKAZjf1WUJe2W6wQ4EWcmIraaQd5YnXEmfqdLessA9NDW+kU4
         JLuBGQiln/GOiJP8Ew8E642wnmI2/gU6NtR3095WAQvgjXMhfqziHr+emFCktvQNQOe6
         3QyRBY7mVVHvgEmWRN9HS6AhCDXsYyn/PhuUNXxEiAk5EvdfPKr1n36UkKumTZANB5up
         pFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725881936; x=1726486736;
        h=mime-version:date:references:organization:in-reply-to:subject:cc:to
         :from:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W26nZdJnLBsIfHz/s3jK5jdIhMQf+KGV6UKCsoG9vuM=;
        b=bDlG+w7CJwqxQI6oaKAbjMZuSSY25hAGCVL5HDaB0eOqGZ/xdlRpr94S2Vlqv/5DD1
         tzpw6J6bQFV2UJ/se5acbXVHbo6Ziq/Ef06+XZuwIMEFlQFw287/dgorFpDL/Lccovdu
         60xRH+9nTUTMPD/cpYSuWzkEE4sHn9fPoPJyS2J309K4qMM5QV/DEJI4LyN6ea21iwz5
         +gzQs8OCqYAmv+PYOxxlHTRnJcHu7n1qWECtmmcCf7CzztfVOdER0XVgVmW7jcMbkpQj
         DazecWFQUvpkCBGCPxhKzKhA1Vo1cMj3OySY3BlY9GsaczRdi9MLDnbTnSsrWjb7OcWd
         2lqA==
X-Forwarded-Encrypted: i=1; AJvYcCX4WpTJWvkIIs+A4oTda04VmpbbFBlqpuZHVVYaGA6lbG7IU5gDmaf3XxkQuZyCcOyU0kW8DVY1eIukTPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YycPhKWkAuCv65H/F5Egi+fIXdJOBSxc0TI4Xm+i3CTBNEUpu5m
	jutUDdFh9Tzhui31vvZ3NZEuyxrrujKz449KFN0RpI+qWreXzFMJ
X-Google-Smtp-Source: AGHT+IEGeIzBSBnr7TPWOE+RFt3Bxl7/u8wxu6JoWx2W06vU993cayEWH0d1yjJvBoxU3/Ef6ZYzDQ==
X-Received: by 2002:a05:600c:4707:b0:426:5dd0:a1ee with SMTP id 5b1f17b1804b1-42c9f97bc2amr79572585e9.2.1725881935677;
        Mon, 09 Sep 2024 04:38:55 -0700 (PDT)
Received: from localhost ([37.72.3.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d3743sm5846883f8f.79.2024.09.09.04.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 04:38:55 -0700 (PDT)
Message-ID: <66dede4f.5d0a0220.1ef0e1.c922@mx.google.com>
X-Google-Original-Message-ID: <87mskhjbue.fsf@>
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mikisabate@gmail.com>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: <paul.walmsley@sifive.com>,  <palmer@dabbelt.com>,
  <aou@eecs.berkeley.edu>,  <linux-riscv@lists.infradead.org>,
  <linux-kernel@vger.kernel.org>,  <jesse@rivosinc.com>,
  <conor@kernel.org>
Subject: Re: [PATCH v2] riscv: hwprobe: export Zicntr and Zihpm extensions
In-Reply-To: <20240909-raving-reproach-74431f57896d@wendy> (Conor Dooley's
	message of "Mon, 9 Sep 2024 12:11:46 +0100")
Organization: Linux Private Site
References: <20240817075629.262318-1-mikisabate@gmail.com>
	<20240820044749.557349-1-mikisabate@gmail.com>
	<66d9605f.5d0a0220.3dabb6.3586@mx.google.com>
	<20240909-raving-reproach-74431f57896d@wendy>
Date: Mon, 09 Sep 2024 13:38:49 +0200
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

On dl., de set. 09 2024, Conor Dooley wrote:

> On Thu, Sep 05, 2024 at 09:40:14AM +0200, Miquel Sabat=C3=A9 Sol=C3=A0 wr=
ote:
>> On dt., d=E2=80=99ag. 20 2024, Miquel Sabat=C3=A9 Sol=C3=A0 wrote:
>>=20
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
>> > index 3db60a0911df..cfd2929d0562 100644
>> > --- a/Documentation/arch/riscv/hwprobe.rst
>> > +++ b/Documentation/arch/riscv/hwprobe.rst
>> > @@ -183,6 +183,9 @@ The following keys are defined:
>> >         defined in the Atomic Compare-and-Swap (CAS) instructions manu=
al starting
>> >         from commit 5059e0ca641c ("update to ratified").
>> >=20=20
>> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZICNTR`: The Zicntr extension version=
 2.0
>> > +       is supported as defined in the RISC-V ISA manual.
>> > +
>> >    * :c:macro:`RISCV_HWPROBE_EXT_ZICOND`: The Zicond extension is supp=
orted as
>> >         defined in the RISC-V Integer Conditional (Zicond) operations =
extension
>> >         manual starting from commit 95cf1f9 ("Add changes requested by=
 Ved
>> > @@ -192,6 +195,9 @@ The following keys are defined:
>> >         supported as defined in the RISC-V ISA manual starting from co=
mmit
>> >         d8ab5c78c207 ("Zihintpause is ratified").
>> >=20=20
>> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZIHPM`: The Zihpm extension version 2=
.0
>> > +       is supported as defined in the RISC-V ISA manual.
>> > +
>> >    * :c:macro:`RISCV_HWPROBE_EXT_ZVE32X`: The Vector sub-extension Zve=
32x is
>> >      supported, as defined by version 1.0 of the RISC-V Vector extensi=
on manual.
>> >=20=20
>> > diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/includ=
e/uapi/asm/hwprobe.h
>> > index b706c8e47b02..098a815b3fd4 100644
>> > --- a/arch/riscv/include/uapi/asm/hwprobe.h
>> > +++ b/arch/riscv/include/uapi/asm/hwprobe.h
>> > @@ -72,6 +72,8 @@ struct riscv_hwprobe {
>> >  #define		RISCV_HWPROBE_EXT_ZCF		(1ULL << 46)
>> >  #define		RISCV_HWPROBE_EXT_ZCMOP		(1ULL << 47)
>> >  #define		RISCV_HWPROBE_EXT_ZAWRS		(1ULL << 48)
>> > +#define		RISCV_HWPROBE_EXT_ZICNTR	(1ULL << 49)
>> > +#define		RISCV_HWPROBE_EXT_ZIHPM		(1ULL << 50)
>> >  #define RISCV_HWPROBE_KEY_CPUPERF_0	5
>> >  #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
>> >  #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
>> > diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_h=
wprobe.c
>> > index 8d1b5c35d2a7..910b41b6a7ab 100644
>> > --- a/arch/riscv/kernel/sys_hwprobe.c
>> > +++ b/arch/riscv/kernel/sys_hwprobe.c
>> > @@ -107,9 +107,11 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe=
 *pair,
>> >  		EXT_KEY(ZCB);
>> >  		EXT_KEY(ZCMOP);
>> >  		EXT_KEY(ZICBOZ);
>> > +		EXT_KEY(ZICNTR);
>> >  		EXT_KEY(ZICOND);
>> >  		EXT_KEY(ZIHINTNTL);
>> >  		EXT_KEY(ZIHINTPAUSE);
>> > +		EXT_KEY(ZIHPM);
>> >  		EXT_KEY(ZIMOP);
>> >  		EXT_KEY(ZKND);
>> >  		EXT_KEY(ZKNE);
>> >
>> > base-commit: dc1c8034e31b14a2e5e212104ec508aec44ce1b9
>>=20
>> Hello,
>>=20
>> Can I get a review on this version of this patchset?
>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>
> By the way, I totally missed this first time around because the v2 was
> sent as a reply to v1 - it's pretty common for people to view their
> mailbox sorted by thread, and sending new versions as a reply will bury
> it.
>
> Cheers,
> Conor.

Thanks for the review!

This is my first contribution to the Linux kernel, as you can tell :)
Will keep in mind next time!

Thanks,
Miquel

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJJBAEBCgAzFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmbe3kkVHG1pa2lzYWJh
dGVAZ21haWwuY29tAAoJEJa+jG/YnWVlj+sP/iAqt4EMHI+8kZlVyGUdndX5I0hP
ABdwK8prk09tVOkt7VBEjQI61Ibn/ZimfrRLaGwZB+UYmpb2kXBZzO/CLUhaya2f
Lsj/cr8Cr5sqlZiRoYGDVOUfVdNoQSn7vqURb1KWHHTMLdg8jgFJVCDRTudROCn9
vyWxmNuVWiZRoBvK61alPwHJYbVqCEJN+vIz8bw3yv5fZgRsGqxQM/L0ZUmI52gZ
eHFfoKQEFYoWxKVypTV/wn4jtl2VwOJJQ5iT6sEnKfyWh84XF0phBbQPpQz9S/8S
Aa2/eE+w/frmwo3Nh+43aCwvtUXGRxc147nQ6CuY68flW4SUnayndQlYindTBQDw
Nq6NgkXpj3Pixa/Ntw7dTHgVbFAeWcuuQWgBXwXgyyd26bFXcETLR4TkV/ANHWKi
eEG9+cRTF9LqB5FxDFfBtddtnVhnMiZBeXmwA1PCy3nZaBghhN+ctWgXDvu4f27U
JXn9BzpTH8VwDMzi4+cIsgeQCZiPdZ4JOIP5LhOXNRHaZHi+JceBhVUIMHYd7urB
KRtSrau5O1p6WyEi+JdF0ydafkRx2Gmc5MpVpXB9gBCeT0/jurS62oL4aXP4D4Np
cQthVm2Xirq3XitRMylGKt2iOOz8Uks1BKnBKHB1xAGcdnTZvM2/Pwv7LicxCHnh
827assRBdYKjkbgR
=MCFy
-----END PGP SIGNATURE-----
--=-=-=--

