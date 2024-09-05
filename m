Return-Path: <linux-kernel+bounces-316517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6100396D096
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFB691F2584D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4427119309A;
	Thu,  5 Sep 2024 07:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YP6FLuvq"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB75C18A94F
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 07:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725522020; cv=none; b=bwiEstkWfmiOazzprcB66wyQCzmQJHb6qSaWs6kU+cv/O2U4OH38u2X+YNCSTkyM0CXTN7Gp/+d9RF+5vZtdKqZTTTsR1bPtQNTBV1+Wqm9yNR6BK5L08iMhhB5gbc1C0JkaLwR73+Gvby+9tHfxpvQL1xtQo2SsU+w289ti4g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725522020; c=relaxed/simple;
	bh=OuA0w9UitDAIn6GNgpqj54KRLShT8d7FPg1uRQgiukA=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=Nczn8b8/VXfqFPbyc2lq3liI14IyPSTjP8W6lgajOvXUZd5SGjd0DOAukKeT00wuG2LgGSMb/UGoCPIBYkaprFzeYbPzNu8k/EgS5LOndLurxiZoAxhjDp/bGuFXTtkfD+FVprLb5nKwfZxIET7V4+obft4e/9jt4JiqkDkfpGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YP6FLuvq; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42bb8c6e250so3000135e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 00:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725522017; x=1726126817; darn=vger.kernel.org;
        h=mime-version:date:references:organization:in-reply-to:subject:cc:to
         :from:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BrJWzT+oqpfYL0FaPO0Aylp3pJEr+z8sjt0+5/naJYU=;
        b=YP6FLuvqXyFOxLct2vvtLxLi/7Q8yUSIb7gaaBl2SnvECchTJMRcKIc4jLkdZD9wgY
         1g/X/kZYeagqTH9wP+WVsH4KHsdG/dDGi0Sjufb4A489eYISt4W6H7jOg5y3NobzUq4x
         CuarxXUR3EcZ5+ugal+GOMDi1sMvfEIQueIJ7KcvFV8Wzt/LF38jeTRX6CH0/id/Xpe+
         wb00WBqW3F+Zy7GqepKxgTHuwCXzOwQSvOfVRS679HKu/jL2gd5PTJ01ckNDjbKySoEA
         xOft4Kd/MJOEbsFCM5zeT+DcVo2/7n+1Jo2UYXB4y1KjPOZAeVwAhXNG7Zi+JU6DCtCF
         JEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725522017; x=1726126817;
        h=mime-version:date:references:organization:in-reply-to:subject:cc:to
         :from:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BrJWzT+oqpfYL0FaPO0Aylp3pJEr+z8sjt0+5/naJYU=;
        b=MafnbrGErK9uy7iVQsUYrwwHT7PwvVoX9+13mM6zzmq6W5fFjZByQ0Ev2Rc8QVWYuK
         dyGVaV78ufz5THzQXWDCpo0RY/ybnUvwvEjlg5q6YJXzIHsk22Wm9HiJZqliPVH2f2EW
         VvCOpnOvUQIo7RhfUlHhKCgvOB9M4JDjIe9TXTdqS+BkvOGNOEB8IlaUijXxjRIGFAbV
         zqbE/U1GkJQA/yq8e6KOkfqvtqx5wKKa/9a+nqo7gNFaDoiiBZa2xsVYSSy9fYqEQq4d
         4UtI/8IEAo/LT2yYWsuyaJrOd9eViMkgAyt3INQkpcdtMhBBGUodpV1Mv/61XLA6T1NW
         F0HA==
X-Forwarded-Encrypted: i=1; AJvYcCX+ZWrJi3uN+TWDjxc51jZh+SSLMoMAe+DaIKvoEQbxT4shwzl/jrxVRP3UYzaMGUU8TjL8GnWDa8vAwZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2F9JgDPX57afZ9SIPkKNgmyeb7tNDpixbrV5iEbQGJGRTmOK8
	zJKmte5h/sEF7urPrFmyT+63dKaDtTCSpXklAlEd4h+F9Dx1GnhC
X-Google-Smtp-Source: AGHT+IHhY+hjD4ev3F0K4g/Zu8goQEHzNXqZkyZnaPvkXywWr1n17U3NOrSqtqZv4mj7W4/7YnTZHg==
X-Received: by 2002:a05:600c:4691:b0:426:4978:65f0 with SMTP id 5b1f17b1804b1-42c9545e5bbmr37987805e9.18.1725522016842;
        Thu, 05 Sep 2024 00:40:16 -0700 (PDT)
Received: from localhost ([37.72.3.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749eea60e2sm18611100f8f.62.2024.09.05.00.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 00:40:15 -0700 (PDT)
Message-ID: <66d9605f.5d0a0220.3dabb6.3586@mx.google.com>
X-Google-Original-Message-ID: <87plpilfa9.fsf@>
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mikisabate@gmail.com>
To: paul.walmsley@sifive.com
Cc: palmer@dabbelt.com,  aou@eecs.berkeley.edu,
  linux-riscv@lists.infradead.org,  linux-kernel@vger.kernel.org,
  jesse@rivosinc.com,  conor@kernel.org
Subject: Re: [PATCH v2] riscv: hwprobe: export Zicntr and Zihpm extensions
In-Reply-To: <20240820044749.557349-1-mikisabate@gmail.com> ("Miquel
 =?utf-8?Q?Sabat=C3=A9=09Sol=C3=A0=22's?= message of "Tue, 20 Aug 2024
 06:47:49 +0200")
Organization: Linux Private Site
References: <20240817075629.262318-1-mikisabate@gmail.com>
	<20240820044749.557349-1-mikisabate@gmail.com>
Date: Thu, 05 Sep 2024 09:40:14 +0200
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

On dt., d=E2=80=99ag. 20 2024, Miquel Sabat=C3=A9 Sol=C3=A0 wrote:

> Export Zicntr and Zihpm ISA extensions through the hwprobe syscall.
>
> Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mikisabate@gmail.com>
> ---
>  Documentation/arch/riscv/hwprobe.rst  | 6 ++++++
>  arch/riscv/include/uapi/asm/hwprobe.h | 2 ++
>  arch/riscv/kernel/sys_hwprobe.c       | 2 ++
>  3 files changed, 10 insertions(+)
>
> diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/ri=
scv/hwprobe.rst
> index 3db60a0911df..cfd2929d0562 100644
> --- a/Documentation/arch/riscv/hwprobe.rst
> +++ b/Documentation/arch/riscv/hwprobe.rst
> @@ -183,6 +183,9 @@ The following keys are defined:
>         defined in the Atomic Compare-and-Swap (CAS) instructions manual =
starting
>         from commit 5059e0ca641c ("update to ratified").
>=20=20
> +  * :c:macro:`RISCV_HWPROBE_EXT_ZICNTR`: The Zicntr extension version 2.0
> +       is supported as defined in the RISC-V ISA manual.
> +
>    * :c:macro:`RISCV_HWPROBE_EXT_ZICOND`: The Zicond extension is support=
ed as
>         defined in the RISC-V Integer Conditional (Zicond) operations ext=
ension
>         manual starting from commit 95cf1f9 ("Add changes requested by Ved
> @@ -192,6 +195,9 @@ The following keys are defined:
>         supported as defined in the RISC-V ISA manual starting from commit
>         d8ab5c78c207 ("Zihintpause is ratified").
>=20=20
> +  * :c:macro:`RISCV_HWPROBE_EXT_ZIHPM`: The Zihpm extension version 2.0
> +       is supported as defined in the RISC-V ISA manual.
> +
>    * :c:macro:`RISCV_HWPROBE_EXT_ZVE32X`: The Vector sub-extension Zve32x=
 is
>      supported, as defined by version 1.0 of the RISC-V Vector extension =
manual.
>=20=20
> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/u=
api/asm/hwprobe.h
> index b706c8e47b02..098a815b3fd4 100644
> --- a/arch/riscv/include/uapi/asm/hwprobe.h
> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> @@ -72,6 +72,8 @@ struct riscv_hwprobe {
>  #define		RISCV_HWPROBE_EXT_ZCF		(1ULL << 46)
>  #define		RISCV_HWPROBE_EXT_ZCMOP		(1ULL << 47)
>  #define		RISCV_HWPROBE_EXT_ZAWRS		(1ULL << 48)
> +#define		RISCV_HWPROBE_EXT_ZICNTR	(1ULL << 49)
> +#define		RISCV_HWPROBE_EXT_ZIHPM		(1ULL << 50)
>  #define RISCV_HWPROBE_KEY_CPUPERF_0	5
>  #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
>  #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwpr=
obe.c
> index 8d1b5c35d2a7..910b41b6a7ab 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -107,9 +107,11 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *p=
air,
>  		EXT_KEY(ZCB);
>  		EXT_KEY(ZCMOP);
>  		EXT_KEY(ZICBOZ);
> +		EXT_KEY(ZICNTR);
>  		EXT_KEY(ZICOND);
>  		EXT_KEY(ZIHINTNTL);
>  		EXT_KEY(ZIHINTPAUSE);
> +		EXT_KEY(ZIHPM);
>  		EXT_KEY(ZIMOP);
>  		EXT_KEY(ZKND);
>  		EXT_KEY(ZKNE);
>
> base-commit: dc1c8034e31b14a2e5e212104ec508aec44ce1b9

Hello,

Can I get a review on this version of this patchset?

Thanks,
Miquel

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJJBAEBCgAzFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmbZYF4VHG1pa2lzYWJh
dGVAZ21haWwuY29tAAoJEJa+jG/YnWVluYoP/A1lDIQtj5Md7JVB1iPmxF/VAfeV
+sW5RsLPOGlPiU+yMTrjNN4cht2zcW49rC9EdQwEE0rRMcX6PzaCW0l+k8N+OZ0e
FAKng3GGRMPOcTgGogz1kB2ZqpT7Sg/kUB2+6m+aJniUDTvX6VoqcRtHyWFUsaz7
mHra0/Cos/1tfl80blyv0Rk5sGXJTDYAjS+K01YzLrJiLqQ1/WbEAFerBde2M8Vh
8WV3tmofbtUs40gD0Kc6hO29RdXAzXr3NzeSlyIVmpNDaK+rUEYbMcwugdUoCR5S
EHM5o7Ky4rr0SmjsDpepp/gr9CEjwInj6PAZNm7TXh4Ebc/WoalQ67SYQyWGbPOQ
z1266zxcAooOcWXAbquyzHnbONrLc9VxSCBazb9/n9Kcv9CZrhFSmGsoleHsoyND
0euA4nUF1/2oGg2VGpdWutArhBbOfTsLBAB+DGmBhfMlKELOpbGm+G8DcbjTMF4d
sxvDDcmV4VBHWFORCc61xmkVhhGGqd5zR7ouj2lZEVIBYTOel9PY9nNR7gD6I/98
h8RECViJIEEtCAkeqi1Y5ue0g0i84Zuor7QD6SgXc3kCJfq/oYNikviSGOqEwX9T
R4e15GBU5NKCUKKpMydlec/eJ4Iocu3mMJ3tfHv2rpAubnyacObV2mSvgVX/cAPh
pQBNJvV014ek1Gnn
=4v9i
-----END PGP SIGNATURE-----
--=-=-=--

