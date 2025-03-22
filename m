Return-Path: <linux-kernel+bounces-572421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6A9A6CA2E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 13:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 613ED1893A39
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 12:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA532253FE;
	Sat, 22 Mar 2025 12:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ub1wsW0n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C0527470
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 12:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742647901; cv=none; b=jjxNfmwnyXJ9AZeG0/M/dDtVTDEyG1FngaEuDruSC1U/NTpaOxj6HJQACJDHE4cE/gc7xcCUOVwSIr2EJCBDrItJvJMKqNFLKLIw6B+83Og4p5DfxIKemQj4PTwLxCmadMMac4jmj5UREdZO/+wDzYGyDE4yeHJ+cMOVvkK0nPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742647901; c=relaxed/simple;
	bh=hYoLkjYnSu3Pw29O6IvXkhQKoHWKVSkRDq8h8zKxLoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WerbWJPt6GFPZDv31I7XizOe0S8QEUCQRAij/lPEoD9wg6dZ7hzOVGe/f0Q1jL3i2DwfySxTrkz/+1Mell75JdjSSgB+CIAp739jFg6yyZz8XGU3DfUOzDprV1q3F1+lOHu66x0bsBkRgW0ENYWomB9L189dRZHbnfo2Xcn/dPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ub1wsW0n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E737C4CEEF
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 12:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742647900;
	bh=hYoLkjYnSu3Pw29O6IvXkhQKoHWKVSkRDq8h8zKxLoU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ub1wsW0nrFS1q4WSrFAEr8o1v6sZyf4JGVOHzfAoHGfttm+EbSS9zIYkuCS1diE6O
	 lmlk/BQuaRiE5aVL8iJu5jB9ThIlfsg+NPOlmvOOusehus30Fcc58AYqvm1eexGTPX
	 HWiC7falfBrTZ3h4frNdYdSzvuRKc3uh+rJ2l0Vb3iw3Nn1COYkx9DgSHe6Ip4NLSA
	 sdO8kl+W28ZIyLttl1X1YDUiJ5Xnb2fPyCMTaielPo1fCLEE6ItVryW10ZM2FudED2
	 sxSU4IVtEvp3s78k+EGufLHqRFE39PzrAnSE7jfzyOEkl2fRI35kklc9gP0yVMdQL3
	 ub8oA0F7bQWqw==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e6167d0536so5580528a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 05:51:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWNm1fvIiwBVHDT3az3SDymo1eNDbs0tKXWuYuTi/Shy0DDoRjEIVeFQ1AvHI06sG43NmQbVrH4QbBca8c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr0VvQtlQcK47CVCujTbKVLCnl2SBhZlsJIv4N6aokMA/1fVtx
	DLAcNtUj2AAvqcTl1k4yybxPkycIMQJFc5P+C+q/MZNxp37YctFuhqqayULcncjZd14/9e6u363
	j4fIIwMxA3ukFge8qdN+yAMWquKA=
X-Google-Smtp-Source: AGHT+IE0FhtEywcmqjzKYe+3HHjsyIO0OSjv7ylUWX3XFfF5rNNY+yXPmHZ1Wf1C9810aYAn1dIBl9CWoQDM/xPbZaE=
X-Received: by 2002:a05:6402:51ce:b0:5e5:bb58:d6bd with SMTP id
 4fb4d7f45d1cf-5ebcd431464mr5156634a12.10.1742647899048; Sat, 22 Mar 2025
 05:51:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <943E06D656E4E707+20250321141001.109916-1-wangyuli@uniontech.com>
In-Reply-To: <943E06D656E4E707+20250321141001.109916-1-wangyuli@uniontech.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 22 Mar 2025 20:51:28 +0800
X-Gmail-Original-Message-ID: <CAAhV-H71aEKj2V8mAqbUuAe1JiHngWHW3rSaJ_Dx_CzoQC7TgQ@mail.gmail.com>
X-Gm-Features: AQ5f1Johy1ud_FUpN0wg1kc1goHIkqqzOcJs_N-J9BQhzJY5TN-iEQ_Uqgzcjds
Message-ID: <CAAhV-H71aEKj2V8mAqbUuAe1JiHngWHW3rSaJ_Dx_CzoQC7TgQ@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: KGDB: Rework arch_kgdb_breakpoint() implementation
To: WangYuli <wangyuli@uniontech.com>
Cc: kernel@xen0n.name, guanwentao@uniontech.com, wentao@uniontech.com, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	zhoubinbin@loongson.cn, lihui@loongson.cn, rdunlap@infradead.org, 
	chenhuacai@loongson.cn, zhanjun@uniontech.com, niecheng1@uniontech.com, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Jinyang He <hejinyang@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Tiezhu & Jinyang,

On Fri, Mar 21, 2025 at 10:11=E2=80=AFPM WangYuli <wangyuli@uniontech.com> =
wrote:
>
> The arch_kgdb_breakpoint() function defines the kgdb_breakinst
> symbol using inline assembly.
>
> There's a potential issue where the compiler might inline
> arch_kgdb_breakpoint(), which would then define the kgdb_breakinst
> symbol multiple times, leading to a linker error.
>
> To prevent this, declare arch_kgdb_breakpoint() as noline.
>
> Fix follow error with LLVM-19 *only* when LTO_CLANG_FULL:
>     LD      vmlinux.o
>   ld.lld-19: error: ld-temp.o <inline asm>:3:1: symbol 'kgdb_breakinst' i=
s already defined
>   kgdb_breakinst: break 2
>   ^
>
> Additionally, remove "nop" here because it's meaningless for LoongArch
> here.
>
> Fixes: e14dd076964e ("LoongArch: Add basic KGDB & KDB support")
> Co-developed-by: Winston Wen <wentao@uniontech.com>
> Signed-off-by: Winston Wen <wentao@uniontech.com>
> Co-developed-by: Wentao Guan <guanwentao@uniontech.com>
> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
> Co-developed-by: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> Tested-by: Yuli Wang <wangyuli@uniontech.com>
> Tested-by: Binbin Zhou <zhoubinbin@loongson.cn>
> Signed-off-by: Yuli Wang <wangyuli@uniontech.com>
> ---
> Changelog:
>  *v1->v2:
>     1. Drop the nop which is no effect for LoongArch here.
>     2. Add "STACK_FRAME_NON_STANDARD" for arch_kgdb_breakpoint() to
> avoid the objtool warning.
> ---
>  arch/loongarch/kernel/kgdb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/loongarch/kernel/kgdb.c b/arch/loongarch/kernel/kgdb.c
> index 445c452d72a7..38bd0561d7d5 100644
> --- a/arch/loongarch/kernel/kgdb.c
> +++ b/arch/loongarch/kernel/kgdb.c
> @@ -224,13 +224,13 @@ void kgdb_arch_set_pc(struct pt_regs *regs, unsigne=
d long pc)
>         regs->csr_era =3D pc;
>  }
>
> -void arch_kgdb_breakpoint(void)
> +noinline void arch_kgdb_breakpoint(void)
>  {
>         __asm__ __volatile__ (                  \
>                 ".globl kgdb_breakinst\n\t"     \
> -               "nop\n"                         \
>                 "kgdb_breakinst:\tbreak 2\n\t"); /* BRK_KDB =3D 2 */
>  }
> +STACK_FRAME_NON_STANDARD(arch_kgdb_breakpoint);
Is there a better solution than STACK_FRAME_NON_STANDARD()? In the
past we can use annotate_reachable() in arch_kgdb_breakpoint(), but
annotate_reachable() is no longer exist.

Huacai

>
>  /*
>   * Calls linux_debug_hook before the kernel dies. If KGDB is enabled,
> --
> 2.49.0
>

