Return-Path: <linux-kernel+bounces-336286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBD197F197
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 22:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB1BF1C21843
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 20:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173AF1A08C1;
	Mon, 23 Sep 2024 20:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nb0eMe6r"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D7615E88
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 20:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727122584; cv=none; b=JGNCGTIz0NJsA/eUPxouvjIZP6KgsJ3XhN8JJEFNKxgnEkJI7FpWHGM3/J1oXMOkEBxFYCtWmE6YVGfVRNTiwiWCfavlmXRUyX7JiQC/RR7oG67yMXzwzUeECdcisDKagoih+ByL4Bhx79o9EFa3xUWh/DHbPtFolXveFA/Ix3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727122584; c=relaxed/simple;
	bh=7ByuSUR3v/7rowQ5mE8hDX4XS47cie88a3cz54QjmPI=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=I+9+UOXdbb6tboQuvlSFYGF7zw9aBhh0YQzANfQYTxbF9MlW2TqvjTtYeSnWgAPaPRJ1ynPv8FISgejVcnYjn31r3GIVpQvv0Ll2vyw/QobMf3VLS1BlGxJ9qbrx5+9Mb8KRy332z8ikfeQx6wf1XHDil71zFlaJVRK+y+onzb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nb0eMe6r; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so61536835e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 13:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727122581; x=1727727381; darn=vger.kernel.org;
        h=mime-version:date:references:organization:in-reply-to:subject:cc:to
         :from:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ODlh4cLidNTSOTpYrIetwaeNVa192xg+fpWel7GtfsI=;
        b=Nb0eMe6rIiQF+d+6yTWV2Rk70tmOfUvWx4AAo/AN9qyp3OGlBmPoKLg4MsP16vg+dN
         QIXV+rFMbk9l+BQ6wB4KVM5cztuKXa8k3CV5PPVT+/iJSwQ3H6StNtrId6MQ7CAsadXF
         /LzF7VrzRyQgkPZa0/EDhQmNOzuyx1RsIem9M9Y6sJZiWgaKkGAwdieg3oYsZFmwVHyK
         FHqoU6LQ0iIu9WhqGXMMKMK9wOwizSTFiRWfgEThAMkFYFtDPohKY1W+xRoxKwTQukcp
         fY2vKtffcXdp/byErk/yS+Xg24qQJJ6u7KqiXrmwv4C5R4j/DvbXZ/YC7zxWi1YbLa+Y
         SwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727122581; x=1727727381;
        h=mime-version:date:references:organization:in-reply-to:subject:cc:to
         :from:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODlh4cLidNTSOTpYrIetwaeNVa192xg+fpWel7GtfsI=;
        b=ExenGh7uVPcC0vY/etiMknZezss9bktx5PEZE3OIkAdtPGbbIrpT3aeBZ0LoLXyGYd
         6pK6VEDF9qJ/f/XH732ajpa+iyXNEu1VwMPRAvdeBoVl+hf8VNzIdmktbzzGRWsjzNJW
         vckbOwh1QgkSJ6WtXlWlnjfRFrkO/h2anDfx074A0hWL0KpXJ0+QDSw48KUCtW/80Tr2
         EwELpjZ0Bm5/0NA1m7CH2YkUf88z9NNaG31jJf1U4oVrttgthZEJ2JJR7JGDtYvHqH0a
         vlVi5hgqongmTo5lFWESuYfjadYrSfbNQJi/GZueX3MzYS75E5bu+P3E5INxznMKee5x
         ZAkg==
X-Forwarded-Encrypted: i=1; AJvYcCXhwDKYQajNQr6dJOlv6ADuyMGgug1yupkrGVlbQBU17HECeSClS777j/5PMHl9aeASW4W6L7c7FVUZ3rk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyti65lhHuBiix+2AYO59JDiYLbUar2BL6guu03K6C8X3czi7Ox
	pAgvhNNVPsU4xI7RMdS69l+tdHIVqoLr9nrZ/ZXxBz+IUxTTGgfR
X-Google-Smtp-Source: AGHT+IFQ0Daau+k02GY2peTPcjNMZzS1+gRzCWmOB4DwjaGNyaEsEnxxLlRtIb+TxVm6KRweUfRK4A==
X-Received: by 2002:a05:600c:1987:b0:42c:bae0:f05f with SMTP id 5b1f17b1804b1-42e7ac2f2a5mr137826935e9.13.1727122580623;
        Mon, 23 Sep 2024 13:16:20 -0700 (PDT)
Received: from localhost ([37.72.3.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f99ebsm25280575f8f.63.2024.09.23.13.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 13:16:19 -0700 (PDT)
Message-ID: <66f1cc93.050a0220.bf7a0.30f3@mx.google.com>
X-Google-Original-Message-ID: <87h6a6gm7i.fsf@>
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mikisabate@gmail.com>
To: paul.walmsley@sifive.com
Cc: palmer@dabbelt.com,  aou@eecs.berkeley.edu,
  linux-riscv@lists.infradead.org,  linux-kernel@vger.kernel.org,  Jesse
 Taube <jesse@rivosinc.com>,  Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [RESEND PATCH v2] riscv: hwprobe: export Zicntr and Zihpm
 extensions
In-Reply-To: <20240913051324.8176-1-mikisabate@gmail.com> ("Miquel
 =?utf-8?Q?Sabat=C3=A9=09Sol=C3=A0=22's?= message of "Fri, 13 Sep 2024
 07:13:24 +0200")
Organization: Linux Private Site
References: <20240913051324.8176-1-mikisabate@gmail.com>
Date: Mon, 23 Sep 2024 22:16:17 +0200
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

On dv., de set. 13 2024, Miquel Sabat=C3=A9 Sol=C3=A0 wrote:

> Export Zicntr and Zihpm ISA extensions through the hwprobe syscall.
>
> Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mikisabate@gmail.com>
> Acked-by: Jesse Taube <jesse@rivosinc.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> This is a resend because I sent v2 as a reply to the original thread and
> it most probably was lost by most people. Fortunately Conor picked it up
> and gave it a review.
>
> I am resending this so it can be properly applied. Thank you for your tim=
e and
> sorry for the inconvenience.
>
> Changes since v1 [1]: the EXT_KEY instructions have been written in order.
>
> [1] https://lore.kernel.org/linux-riscv/20240817075629.262318-1-mikisabat=
e@gmail.com/
>
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
>
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
>
> +  * :c:macro:`RISCV_HWPROBE_EXT_ZIHPM`: The Zihpm extension version 2.0
> +       is supported as defined in the RISC-V ISA manual.
> +
>    * :c:macro:`RISCV_HWPROBE_EXT_ZVE32X`: The Vector sub-extension Zve32x=
 is
>      supported, as defined by version 1.0 of the RISC-V Vector extension =
manual.
>
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

Hello,

Gently ping :) Can we get this merged for 6.12?

Thanks!
Miquel

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJJBAEBCgAzFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmbxzJEVHG1pa2lzYWJh
dGVAZ21haWwuY29tAAoJEJa+jG/YnWVlbkUP/0FCi4UpJgRtrVl5dDUqdaHjpBh0
Un2ADisIcSFK92mP4NV7fDpsR+8wBb2rY0YNC6nNgSF0giyHTnuXliNaLG7QejSC
iiZtqXVsztctSsB5DYJ2KnqoGsec8xf7rX8fbwksGmwXI4idQwv1xy/JVyi8YYht
0QncnRXbX36w7Sv6D8Zo1An8xw9wv07mhBOgffUoVNJqtWU4LeuxOTwR2zs5XOkJ
1Sv1odbAkiQPACPE8/pJgfKgQry78uBaB90Nq7w0tQrswbXUAa5Lf0zeuiCt0XTD
aFWO9HRoQ2INlLlpZr6gsc7ejpZ1KXQYVr9sGhlydv+TCIqkVyNGQaYtmrmB5JYY
JOKMotB/PQSBKCV9X1C/UnK13l9sfRWLxENv6OUXDZ39P6s+CNFJXkW4ClxbWGIk
uJuP/o108qHBYK6YpYOSNa4EuJR35LJZoVknawyBJOVnHJw+aOJT91XypkfAyFde
zHsof2xtRmOP/SjXi0I6+paIV9ZX4/MXE524/FUcjbd2FjdM2DqbOPVI4qS4uIdK
l6G6lIMykrHK1zCdssCFE3j7MrLx6op4dKOj95wtg2DsfusN3IppP1+yoAbnIAvR
GlrfX8SuP1DwXxviLRaz8HivEuUV8M+U7/bdksha1K9q31EVfjTL0Pnz6L1samcM
r2ydSikhuBxycwry
=U4SI
-----END PGP SIGNATURE-----
--=-=-=--

