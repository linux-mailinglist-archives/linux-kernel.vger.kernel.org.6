Return-Path: <linux-kernel+bounces-250461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 654AD92F81A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 11:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8815F1C21F70
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 09:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC75314D282;
	Fri, 12 Jul 2024 09:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8YhYKUj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9121494BC
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 09:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720777236; cv=none; b=NAc0Mwg6/WAVemxsHHAz7IJUFr9Wl/7KwJKUf1mErQhy/RLNr+QaqRwXg0f86vaUJkiIlY9hisF7dtFeLwwCftV1G2G2Nb4MXTGZC614a0L3O0tJNrNxx0OstDXxu5NeO3V6e4n4fcrmYVaISp7TuiTi5dR4ZZa5gNEhNCBM3C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720777236; c=relaxed/simple;
	bh=bdil4uP/Y1K/s8nVUqnOIAceh5fft63Q5jINgGxdLpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YbgoWKQGNWkL/9pmzS8WygrkAuwvcgFUPZIylSQWRdSGt1yNPWRU+f0F7M+9HN1o2xN9veLEUTVuN/GJ4qZt/mX0tyJH0xyXwuwD5CMv8VzGBpCTFpFhQRstoCt9g2IaiXg0lM2Sf3GOA5TOGembAEekmg8z+fgZSTrV0jYzdv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8YhYKUj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A133FC32782
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 09:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720777235;
	bh=bdil4uP/Y1K/s8nVUqnOIAceh5fft63Q5jINgGxdLpY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=F8YhYKUjPKxjDUNF8SW6mJfGo7hwe2lVL3NxKCc+qKZ2163AR6A7qhwYNBKljbw2O
	 a0eoqvfr7UTpW/rUJ7SkmhneHGLwxwuXX6VDdRkQC3RshzdWdrrjhP8D1K3NbEXEb3
	 3//W2ZrpyIoq9C8p+EjsBCec/JNemFsSyNcRcx4TOFfN4VTmO6OtwjvEakXYjWXjyY
	 ZNPMxDhZKufB/kvdbyie+7z05o6dCopnLpXRc4BSLfpxwf8UavZGcw1E2wG3i1nyQM
	 sp0xyX2+8LsTppQbbeOprLRkNYmtUdLo23krMC48evf/SF71zs1Y3jWB2/5wwRRpHQ
	 Qsp8SyMGrP7zQ==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-595856e2336so3023971a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 02:40:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW7Q5UL6O1KvbvSTc4/uPtsst59S5VaxTxgYBsWOIJlxzrVZGYtqCMK1Z1YWC3dEwUqiIH9HbImrMFbcC8xFCMTeCE3ZwxSDrN8gwor
X-Gm-Message-State: AOJu0YxxEqP7dWPEZJb0piec/6dHYvaBc4zZYMLyv0F9sFOrBBKHgA3c
	VTpmBlkI2BA1/LXMVqRLwrOcxItebEaFefaV9dLYKb8zUa7h3+TOcTfWct3iTJDOKQIeD7NR/ox
	v8MMvh1d5yEE+zXq/i5xhNSKkQ0Y=
X-Google-Smtp-Source: AGHT+IENvC5KTbUrIoAa+LJp6jkAzFzcRy/GBh7O8aXK9H4i7J17bzLGyt2VeHNvl3QFh3I+ShXrGe2b+gD96H2r85k=
X-Received: by 2002:a50:d744:0:b0:57c:a8e5:35f0 with SMTP id
 4fb4d7f45d1cf-59963bf4683mr1476060a12.2.1720777234300; Fri, 12 Jul 2024
 02:40:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712091506.28140-1-yangtiezhu@loongson.cn> <20240712091506.28140-5-yangtiezhu@loongson.cn>
In-Reply-To: <20240712091506.28140-5-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 12 Jul 2024 17:40:22 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4oi1mpP8JSG1D+8CQVojGtPOpzVybCn8y8mWuMPT=zxQ@mail.gmail.com>
Message-ID: <CAAhV-H4oi1mpP8JSG1D+8CQVojGtPOpzVybCn8y8mWuMPT=zxQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] LoongArch: Remove -fno-jump-tables for objtool
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Xi Ruoyao <xry111@xry111.site>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Tiezhu,

On Fri, Jul 12, 2024 at 5:15=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/loongarch/Kconfig  | 8 +++++++-
>  arch/loongarch/Makefile | 6 ++----
>  2 files changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index ddc042895d01..57f28450a2ed 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -143,7 +143,7 @@ config LOONGARCH
>         select HAVE_LIVEPATCH
>         select HAVE_MOD_ARCH_SPECIFIC
>         select HAVE_NMI
> -       select HAVE_OBJTOOL if AS_HAS_EXPLICIT_RELOCS && AS_HAS_THIN_ADD_=
SUB && !CC_IS_CLANG
> +       select HAVE_OBJTOOL if TOOLCHAIN_SUPPORTS_OBJTOOL && !CC_IS_CLANG
>         select HAVE_PCI
>         select HAVE_PERF_EVENTS
>         select HAVE_PERF_REGS
> @@ -276,6 +276,12 @@ config AS_HAS_LBT_EXTENSION
>  config AS_HAS_LVZ_EXTENSION
>         def_bool $(as-instr,hvcl 0)
>
> +config CC_HAS_ANNOTATE_TABLEJUMP
> +       def_bool $(cc-option,-mannotate-tablejump)
> +
> +config TOOLCHAIN_SUPPORTS_OBJTOOL
> +       def_bool AS_HAS_EXPLICIT_RELOCS && AS_HAS_THIN_ADD_SUB && CC_HAS_=
ANNOTATE_TABLEJUMP
Can AS_HAS_THIN_ADD_SUB be removed now?

Huacai

> +
>  menu "Kernel type and options"
>
>  source "kernel/Kconfig.hz"
> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> index 8674e7e24c4a..186c75c80daa 100644
> --- a/arch/loongarch/Makefile
> +++ b/arch/loongarch/Makefile
> @@ -99,10 +99,8 @@ KBUILD_AFLAGS                        +=3D $(call cc-op=
tion,-mno-relax) $(call cc-option,-Wa$(comma)-mno
>  KBUILD_CFLAGS                  +=3D $(call cc-option,-mno-relax) $(call =
cc-option,-Wa$(comma)-mno-relax)
>  KBUILD_AFLAGS                  +=3D $(call cc-option,-mthin-add-sub) $(c=
all cc-option,-Wa$(comma)-mthin-add-sub)
>  KBUILD_CFLAGS                  +=3D $(call cc-option,-mthin-add-sub) $(c=
all cc-option,-Wa$(comma)-mthin-add-sub)
> -
> -ifdef CONFIG_OBJTOOL
> -KBUILD_CFLAGS                  +=3D -fno-jump-tables
> -endif
> +KBUILD_AFLAGS                  +=3D $(call cc-option,-mannotate-tablejum=
p) $(call cc-option,-Wa$(comma)-mannotate-tablejump)
> +KBUILD_CFLAGS                  +=3D $(call cc-option,-mannotate-tablejum=
p) $(call cc-option,-Wa$(comma)-mannotate-tablejump)
>
>  KBUILD_RUSTFLAGS               +=3D --target=3Dloongarch64-unknown-none-=
softfloat
>  KBUILD_RUSTFLAGS_MODULE                +=3D -Crelocation-model=3Dpic
> --
> 2.42.0
>
>

