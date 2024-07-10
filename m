Return-Path: <linux-kernel+bounces-246845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B7192C7EC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 03:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E23A1F242B2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 01:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921144A0F;
	Wed, 10 Jul 2024 01:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/GPVjrP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AFF161
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 01:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720574683; cv=none; b=du1VwaWhGWpPDar9TzAn0SAZDeodvgWfdz2Mkq5AUYCwgjFKaUUK67PWTHSmofOsK1Q97LRF8vwundTbqGukYLDx+vgMBvWJ0VQe8EAygqWLsmOW9VzM6d9aLvhaM4U5orDvgYaxoYdNUVoHyo4dzYWR9peC0ap6IHHETSyQg9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720574683; c=relaxed/simple;
	bh=q5dWwx7Hau72uDTD4WM4Gz0XSuFn9V5fFjx9SvVggLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oqg8DuYI5bw3oNseV8ND9g8mmlzohTyxDknDyO/dqzdwI1uKBNnvngcd6kmuOohGa1vNKW+z9w+DxJ4b7GYHer/t3PoU/u1KkRScK9LARpTWRRqO+iz0wR3y0p45vjLItBug5KkYy/OuDTlJPmQ8h4jOq7JamRI9L+4E/zr2y2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/GPVjrP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDCCC4AF0A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 01:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720574683;
	bh=q5dWwx7Hau72uDTD4WM4Gz0XSuFn9V5fFjx9SvVggLc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=j/GPVjrPSBsWn8n9iuHzCfF+eVrvSmr3jbSyAL5SBMI1IAyWqpOZTy15xzyyszjQs
	 fUmpG4g/zLmeb1brcyybgmMHioElp5LtF+YQkyi+HnzYkCfKDpauB06R40AeAuQQBd
	 ulhj/IBDdxCaHYS6K2glagCEqJuwpYT83VpGzhV2ljbDLSHBSIuRU4M6X2KiQVtZk1
	 Id4pwUSONsGDH5m1OGOS5Vzl/wtilVUnxkQhacdhFa7prsQ6jEgh2B6qDs/ImiOVOl
	 gCjcMlGbETkCiftF+Ko7WiKtf3foQJMUGeae5j+Ij2nkgGXSEGgC45wu4jZ5Zn8n3e
	 8CZEpsjZFsrqg==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52eafec1e84so3181569e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 18:24:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU4Xz1yCZ8UG1YyM3nQvXik+DH9Gaqg8JP9SM0OiOON17Jj4+g9ZK89evlUD3l5FSUq2DzekjCMrepzn5N+MbIv7OJcMPGMuMx/xQmN
X-Gm-Message-State: AOJu0Ywi4nCSXz30ZGCtO915ebi/fKp8BFavF+mgKbEWY0cXe1Eiqmou
	p133DcC8ghJ58/KMLXq9UWWzO5EU5b/aYXBH9GVdA5IFAFrz927trZ/E+oYcLbufUzVqEOuN4Qy
	uU+PQMUMObjFEB9PJYCTeRW2QXy4=
X-Google-Smtp-Source: AGHT+IHuTEPpNnUYONCOpl+IWfuxcUj4f1EvwyV+OdovXyRGZ117REW3NpBuG1nTgBn5sDZOTO2Pr3187olb/f18ADA=
X-Received: by 2002:a05:6512:15a0:b0:52b:c089:4579 with SMTP id
 2adb3069b0e04-52eb99d1504mr2876768e87.49.1720574681757; Tue, 09 Jul 2024
 18:24:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705060902.113294-1-alexghiti@rivosinc.com> <20240705060902.113294-3-alexghiti@rivosinc.com>
In-Reply-To: <20240705060902.113294-3-alexghiti@rivosinc.com>
From: Guo Ren <guoren@kernel.org>
Date: Wed, 10 Jul 2024 09:24:30 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRPk_1b8gLQn4cmNT62Cdo2sKpXHB7vK2wDo74-NgZSPg@mail.gmail.com>
Message-ID: <CAJF2gTRPk_1b8gLQn4cmNT62Cdo2sKpXHB7vK2wDo74-NgZSPg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] riscv: Check that vdso does not contain any
 dynamic relocations
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Vladimir Isaev <vladimir.isaev@syntacore.com>, 
	Roman Artemev <roman.artemev@syntacore.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 2:11=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc.=
com> wrote:
>
> Like other architectures, use the common cmd_vdso_check to make sure of
> that.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/kernel/vdso/Makefile | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Mak=
efile
> index c7e40bf36371..b5c73084e554 100644
> --- a/arch/riscv/kernel/vdso/Makefile
> +++ b/arch/riscv/kernel/vdso/Makefile
> @@ -45,7 +45,7 @@ $(obj)/vdso.o: $(obj)/vdso.so
>
>  # link rule for the .so file, .lds has to be first
>  $(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) FORCE
> -       $(call if_changed,vdsold)
> +       $(call if_changed,vdsold_and_check)
>  LDFLAGS_vdso.so.dbg =3D -shared -S -soname=3Dlinux-vdso.so.1 \
>         --build-id=3Dsha1 --hash-style=3Dboth --eh-frame-hdr
>
> @@ -65,7 +65,8 @@ include/generated/vdso-offsets.h: $(obj)/vdso.so.dbg FO=
RCE
>  # actual build commands
>  # The DSO images are built using a special linker script
>  # Make sure only to export the intended __vdso_xxx symbol offsets.
> -quiet_cmd_vdsold =3D VDSOLD  $@
> -      cmd_vdsold =3D $(LD) $(ld_flags) -T $(filter-out FORCE,$^) -o $@.t=
mp && \
> +quiet_cmd_vdsold_and_check =3D VDSOLD  $@
> +      cmd_vdsold_and_check =3D $(LD) $(ld_flags) -T $(filter-out FORCE,$=
^) -o $@.tmp && \
>                     $(OBJCOPY) $(patsubst %, -G __vdso_%, $(vdso-syms)) $=
@.tmp $@ && \
> -                   rm $@.tmp
> +                   rm $@.tmp && \
> +                   $(cmd_vdso_check)
This check is helpful for future development on riscv vdso. LGTM!

Reviewed-by: Guo Ren <guoren@kernel.org>

> --
> 2.39.2
>


--=20
Best Regards
 Guo Ren

