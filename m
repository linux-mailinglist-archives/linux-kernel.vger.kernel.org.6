Return-Path: <linux-kernel+bounces-201659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 768A28FC171
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 03:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 304AF285320
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 01:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143125916B;
	Wed,  5 Jun 2024 01:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVd3Fof0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481C855769
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 01:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717552356; cv=none; b=TloAmOL/hVgbq7icH5T3scxSFNo75QV87SePx3aRV+pivvCCs1W5SqyPPCuvp34opU7b/uS95aWNAkujqHQBNQUD35moszuM7Wr7FrQmMj9+dmkRITHHW4XIOwT1qEZL1OGcaUKYDI3SCtZXlUrnM0mnOwMLetVJusq/zqVgFvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717552356; c=relaxed/simple;
	bh=CxC5Siz2EwYJkmy2c6bMNSLW4Zz2VgkST85W+vaTB8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZV30Sjk9dsd5RplWLXULCfsnMllwzWkmaMuaWID2t1HzlibWWC5jWIykGfCL4aFHjnrXdAAcdzCtW3RSv16RnNYoi7W0agPSIPS2g6HeK4HsGLkTrikA7goTCpM+ALyJsSCd39ogEy+eezAbO1xHwXfwm6SJfcP3ZFAnAsRZjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVd3Fof0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E35C4AF08
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 01:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717552355;
	bh=CxC5Siz2EwYJkmy2c6bMNSLW4Zz2VgkST85W+vaTB8E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QVd3Fof0Xov4zp76ezEnn0K2GY3wdzLSXY71H1dbjZMarfp/BCTClLq7ak0gEfRZP
	 8CgebLxnH+m7g//Qb0UWEQZ2J0W9qwUwj6HPqcmnZ35r9Ai5IQyzVfYeoSDSs38hgi
	 FWLrKAi0Gw5T0xGXNbVpYrOFPOZ+7wAeFaZW0wwBIuaOrLn2Q5+fEqB3+gzO1FlFr8
	 4krdExcNYpCCeQ9bjHOxqDSw7LxSn9wLAGHdiM5HdwOFukUTsujMCA48Bv4w6TVucM
	 hWKyMMHr4mb2JO7825Y1aTJ0HYAAjgX2xvu7ZSXYUTG5+97kbcUo3/q7IMeTp0m7aL
	 tmSGAjUXkVNHg==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a68a9a4e9a6so409419466b.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 18:52:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWrKidnqemFRSfRiI+IH9MUoRFZtn4iaRWGMmpArC7Zsei37x4M9d/HoX6g/+PLGYhmuokk0MF8+t/jakS79OOEvKiE7jb7ZqPHZuO2
X-Gm-Message-State: AOJu0YxMbIa4xAyntmnI2pQTjm6VvR0OJS/cX/O+9hlZPEwLx6p6OT2W
	X8DBVBNDVIQ3u3qYu3PwChpp/X7sxHob9eznukQJCvocWptydnMj1n9jUMmNs3jZL0rzmWLU757
	38FOZ2Xctpok0T4dp5yoKX1eoktI=
X-Google-Smtp-Source: AGHT+IE4b3yf9p6USfzE9jEmzB05l3qegRhZxUBpf9jHqVZRyyTocqNF4Zexjq4STbS6DsrUhMoeURbUpZCcnUD1BDQ=
X-Received: by 2002:a17:906:700f:b0:a62:c238:b229 with SMTP id
 a640c23a62f3a-a69a002b89amr76766666b.74.1717552354325; Tue, 04 Jun 2024
 18:52:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604150741.30252-1-xry111@xry111.site>
In-Reply-To: <20240604150741.30252-1-xry111@xry111.site>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 5 Jun 2024 09:52:24 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7CF5wUSj5qfSs-+YTUrB2R9STO7LLu7LG2RpsYE719Og@mail.gmail.com>
Message-ID: <CAAhV-H7CF5wUSj5qfSs-+YTUrB2R9STO7LLu7LG2RpsYE719Og@mail.gmail.com>
Subject: Re: [PATCH] loongarch: Only select HAVE_OBJTOOL and allow ORC
 unwinder if the inline assembler supports R_LARCH_{32,64}_PCREL
To: Xi Ruoyao <xry111@xry111.site>
Cc: WANG Xuerui <kernel@xen0n.name>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Youling Tang <tangyouling@kylinos.cn>, Jinyang He <hejinyang@loongson.cn>, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	mengqinggang@loongson.cn, cailulu@loongson.cn, wanglei@loongson.cn, 
	luweining@loongson.cn, Yujie Liu <yujie.liu@intel.com>, 
	Heng Qi <hengqi@linux.alibaba.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Ruoyao,

On Tue, Jun 4, 2024 at 11:08=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrot=
e:
>
> GAS <=3D 2.41 does not support generating R_LARCH_{32,64}_PCREL for
> "label - ." and it generates R_LARCH_{ADD,SUB}{32,64} pairs instead.
> objtool cannot handle R_LARCH_{ADD,SUB}{32,64} pair in __jump_table
> (static key implementation) and etc. so it will produce some warnings.
> This is causing the kernel CI systems to complain everywhere.
>
> For GAS we can check if -mthin-add-sub option is available to know if
> R_LARCH_{32,64}_PCREL are supported.
I think we should give a chance to toolchains without the
-mthin-add-sub option, so I hope Tiezhu can resubmit this patch to
solve this problem.
https://lore.kernel.org/loongarch/1690272910-11869-6-git-send-email-yangtie=
zhu@loongson.cn/

Huacai

>
> For Clang, we require Clang >=3D 18 and Clang >=3D 17 already supports
> R_LARCH_{32,64}_PCREL, so we can always assume Clang is fine for
> objtool.
>
> Note that __jump_table is not generated by the compiler so
> -fno-jump-table is completely irrelevant for this issue.
>
> Fixes: cb8a2ef0848c ("LoongArch: Add ORC stack unwinder support")
> Closes: https://lore.kernel.org/loongarch/Zl5m1ZlVmGKitAof@yujie-X299/
> Closes: https://lore.kernel.org/loongarch/ZlY1gDDPi_mNrwJ1@slm.duckdns.or=
g/
> Closes: https://lore.kernel.org/loongarch/1717478006.038663-1-hengqi@linu=
x.alibaba.com/
> Link: https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dcommitdiff;h=
=3D816029e06768
> Link: https://github.com/llvm/llvm-project/commit/42cb3c6346fc
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
>  arch/loongarch/Kconfig       | 5 ++++-
>  arch/loongarch/Kconfig.debug | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index e38139c576ee..e461a6c59f15 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -143,7 +143,7 @@ config LOONGARCH
>         select HAVE_LIVEPATCH
>         select HAVE_MOD_ARCH_SPECIFIC
>         select HAVE_NMI
> -       select HAVE_OBJTOOL if AS_HAS_EXPLICIT_RELOCS
> +       select HAVE_OBJTOOL if AS_HAS_EXPLICIT_RELOCS && AS_HAS_THIN_ADD_=
SUB
>         select HAVE_PCI
>         select HAVE_PERF_EVENTS
>         select HAVE_PERF_REGS
> @@ -273,6 +273,9 @@ config AS_HAS_LBT_EXTENSION
>  config AS_HAS_LVZ_EXTENSION
>         def_bool $(as-instr,hvcl 0)
>
> +config AS_HAS_THIN_ADD_SUB
> +       def_bool $(cc-option,-Wa$(comma)-mthin-add-sub) || CC_IS_CLANG
> +
>  menu "Kernel type and options"
>
>  source "kernel/Kconfig.hz"
> diff --git a/arch/loongarch/Kconfig.debug b/arch/loongarch/Kconfig.debug
> index 98d60630c3d4..8b2ce5b5d43e 100644
> --- a/arch/loongarch/Kconfig.debug
> +++ b/arch/loongarch/Kconfig.debug
> @@ -28,6 +28,7 @@ config UNWINDER_PROLOGUE
>
>  config UNWINDER_ORC
>         bool "ORC unwinder"
> +       depends on HAVE_OBJTOOL
>         select OBJTOOL
>         help
>           This option enables the ORC (Oops Rewind Capability) unwinder f=
or
> --
> 2.45.2
>

