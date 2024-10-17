Return-Path: <linux-kernel+bounces-369204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874159A1A46
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 07:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BFE52884D8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 05:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C92716BE23;
	Thu, 17 Oct 2024 05:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngkLjROe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA191388
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 05:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729144454; cv=none; b=LIFD6HFOm82ACibpNmvcaH7mRE6nS0R2YV61dI/DiGD6ceWGLZvlfbVYlK71Qm3kzVGXaEP71zuYw8hmPQ28x60Rsv4PNbBTJe6G+XgVFPYcZIQgE66G21b71KaOSpp2zNsXoSjBF5tGIb6kwQ+UNPcBMMzTxj7tgN34z0/9H/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729144454; c=relaxed/simple;
	bh=rf9ilj578leRVSdBOA3jdQ7Vm8kKGM+K24C3lNxNn8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LAnCt0aUJr+Ic+GmjYy1aVh5crV0cu3Ut6nO2hDFcGIHpzlQqOXKzNigPf1Qm3To1Nt5Fv9/nE8Lj5McocN3vi+6myyHS60YY5jc2ODBa5sqV5KVLU5UQEBmTvRb3JtukMrBfzxHNggAoLyZENJX9MY9e5mqwymobgBge9+8ih4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngkLjROe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACEEC4CECE
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 05:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729144453;
	bh=rf9ilj578leRVSdBOA3jdQ7Vm8kKGM+K24C3lNxNn8s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ngkLjROeLbybFUogtTtdGZQuULfHzkcoot0qI3DJZK4v+Zf+yjCm2UI8piyTiM5FX
	 UaUjNdawOu1lamUhQ8wzpe+Hbz9rgUDdQXWBagUpXCcYCT7W/wooldlc0tV8A9NwRO
	 3j0kNdydJkNyzI/aZ/QL6J5DNIlgkr7MXJs4H7XlbjFKvzkK7GlxOOTL+zrFlml+cS
	 xDuU1H5loV4zvzYgi85MG8sntQ7diRBNlceTxaaMPa8wiE1rPunTN1OWsD9Z05ldgk
	 recqzgOLCkEqGMSWiFaa8zsevPwjYUnYDOnoI+0nxlcD66n8Y9KKpDzJoIOQh34mk4
	 N6Uo5ELyJh0dw==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a26a5d6bfso82774866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 22:54:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVpdUoO28EeXxAd7vnTXsgMMXOiIIkWMgEhdCetXfnXFXmhq8KfkSiLQvhDjPty1TbuvhKLVW4v/8zudEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhnrE+N/1DmfRp1wmXTosteI5n7iLmaEFZrXveO7MB3cmdqNql
	qu7riqOPWZUwWyiJLidZAEHPTS7UMWKo8sUHpewio5eRiRwyA+DM9IqfmYsqZLydTkpzz9cX9JF
	mCpGYDwQC3rJs7qBfQIgbabVAx3k=
X-Google-Smtp-Source: AGHT+IHQPSw+9LSERgrudwoQwlV8Gyq55s+wiQ8rDc2iFREFlO16JC84fvdsqs/7jJwLLb9FfypcfY0W3RnLAZwUFVo=
X-Received: by 2002:a17:907:80b:b0:a99:375f:4523 with SMTP id
 a640c23a62f3a-a99e3e4ca7amr1699443166b.44.1729144451796; Wed, 16 Oct 2024
 22:54:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016083625.136311-1-alexghiti@rivosinc.com> <20241016083625.136311-3-alexghiti@rivosinc.com>
In-Reply-To: <20241016083625.136311-3-alexghiti@rivosinc.com>
From: Guo Ren <guoren@kernel.org>
Date: Thu, 17 Oct 2024 13:54:00 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT5AzU0kPz1NeAyWAohNbWC4Dp_PVdu5A2s_ytN4djQYA@mail.gmail.com>
Message-ID: <CAJF2gTT5AzU0kPz1NeAyWAohNbWC4Dp_PVdu5A2s_ytN4djQYA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] riscv: Check that vdso does not contain any
 dynamic relocations
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Vladimir Isaev <vladimir.isaev@syntacore.com>, 
	Roman Artemev <roman.artemev@syntacore.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 4:38=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> Like other architectures, use the common cmd_vdso_check to make sure of
> that.
>
> Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> Tested-by: Vladimir Isaev <vladimir.isaev@syntacore.com>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/kernel/vdso/Makefile | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Mak=
efile
> index 3f1c4b2d0b06..9a1b555e8733 100644
> --- a/arch/riscv/kernel/vdso/Makefile
> +++ b/arch/riscv/kernel/vdso/Makefile
> @@ -45,7 +45,7 @@ $(obj)/vdso.o: $(obj)/vdso.so
>
>  # link rule for the .so file, .lds has to be first
>  $(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) FORCE
> -       $(call if_changed,vdsold)
> +       $(call if_changed,vdsold_and_check)
>  LDFLAGS_vdso.so.dbg =3D -shared -soname=3Dlinux-vdso.so.1 \
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
Following other architectures to append a $(cmd_vdso_check) is okay.

Reviewed-by: Guo Ren <guoren@kernel.org>

> --
> 2.39.2
>


--=20
Best Regards
 Guo Ren

