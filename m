Return-Path: <linux-kernel+bounces-573140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FFEA6D380
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 05:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83B9716DB50
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 04:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808C3189BAF;
	Mon, 24 Mar 2025 04:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfMj/hbr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B86185B73
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 04:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742789409; cv=none; b=rSNDy4/weeT+1wt4JjtmJ7mwbn0YAl8WEqe+D/o0i152rtcQ+U33HrKna7b0ltl8PGt33K9yySgARD+rnRGMyYvKfcGtYai5UhP3ZYEzwPcvMTigeXnkigobWJj3Z0SoPSRo/7EWJ+Oi6bBWSHwjjmXz+Bt/sRRLwXfsB+YP/Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742789409; c=relaxed/simple;
	bh=SjMbRJQYqIQDGC5FlD8k7K65GLMPOGIwt+8BWth1Kqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eYkiXjrxsoR9eUq8H3b1suFTlvGNh2YjlSfCQREbQihAuRl+AGnySMZleSUL+pCjJzaaXrV68PcFuDyEsQKcjrVjiCglKIiTbN7iWQpghfgAwH3h6HTDQkFcLRnEtRXWS7zIrg4dibfGTIlCbMsH7pDOsOTQgruZnFgMYdBdDFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfMj/hbr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FBA4C4CEEE
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 04:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742789409;
	bh=SjMbRJQYqIQDGC5FlD8k7K65GLMPOGIwt+8BWth1Kqc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sfMj/hbrq0NH++uBtxzlF6/f6I/+Pn8oKquIPUoBNF3A1vL7uz83VKiF/UaxrF4aS
	 L7fd1W7+M31qs9MEQdlPzSEer40ZF6BCqY+ul5FcHayoC7/qyAV82mdFddR4Wa1FLb
	 tZqZvOiF5T2QcTyffoR4HDzrMs+tHNCG9lfbrDp8e21QEghBScakwIZPgsYFMHBGla
	 /vqUXnTWY3PaEJcU5OZF5Qz7b1ewIgcILMNOTh58QvrUPUoFsZWMZ/uMpZkV9TUDTL
	 o12A/zCi4rf3EQcfa6A/5RiKmZAX39Tcs9MoenSxMDkPZAl5LsPoFGJEzDy/V8M2uD
	 WnJNKbohJHaDQ==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abbb12bea54so461747566b.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 21:10:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUc81WtABCALPjtdbF2fv97T+TLp6q+/fYMX1RXaKnxDa1upArrgTKmenNWQ4ltXxGuzKhu7j7pNLHjfbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQAIcht8evo+MoWGwythw7awsK47Gxsx+xCltPLSOhemg2lI5T
	AkrwPfXFnvGmOASwd90IxjrXUmDTGPTTUvTr3D+4JO8difo7WwKy1nX+/l+GgXlFA31LrgxSNWE
	6HfhrMPuRO6ljJj7hhIFYUoPDmMk=
X-Google-Smtp-Source: AGHT+IEbe98Fviv+3ZJooiybHPzSdwoChxAEAhfVEIWk75mGx7wuQYzR8Ll7Bc1bNXwDF3kuOrrOYLLTM96SVAp2b6Q=
X-Received: by 2002:a17:907:3eaa:b0:abe:fa18:1fc6 with SMTP id
 a640c23a62f3a-ac3f20b89camr1027018866b.10.1742789407766; Sun, 23 Mar 2025
 21:10:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <943E06D656E4E707+20250321141001.109916-1-wangyuli@uniontech.com>
 <CAAhV-H71aEKj2V8mAqbUuAe1JiHngWHW3rSaJ_Dx_CzoQC7TgQ@mail.gmail.com> <545ed081-bec3-395c-e0dd-a45146e00cd1@loongson.cn>
In-Reply-To: <545ed081-bec3-395c-e0dd-a45146e00cd1@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 24 Mar 2025 12:09:58 +0800
X-Gmail-Original-Message-ID: <CAAhV-H51AxAjhhge=w4Y=p0XnuW-RyuvA5dPpPc-F0N9YPYHrg@mail.gmail.com>
X-Gm-Features: AQ5f1JogmAftQM828gQD5DTQzREcF5CPt-xZ4-n5oV_lse2MVClC0pEsHdy8rSQ
Message-ID: <CAAhV-H51AxAjhhge=w4Y=p0XnuW-RyuvA5dPpPc-F0N9YPYHrg@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: KGDB: Rework arch_kgdb_breakpoint() implementation
To: Jinyang He <hejinyang@loongson.cn>
Cc: WangYuli <wangyuli@uniontech.com>, kernel@xen0n.name, guanwentao@uniontech.com, 
	wentao@uniontech.com, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	zhoubinbin@loongson.cn, lihui@loongson.cn, rdunlap@infradead.org, 
	chenhuacai@loongson.cn, zhanjun@uniontech.com, niecheng1@uniontech.com, 
	Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Jinyang,

On Mon, Mar 24, 2025 at 9:42=E2=80=AFAM Jinyang He <hejinyang@loongson.cn> =
wrote:
>
> On 2025-03-22 20:51, Huacai Chen wrote:
>
> > Hi, Tiezhu & Jinyang,
> >
> > On Fri, Mar 21, 2025 at 10:11=E2=80=AFPM WangYuli <wangyuli@uniontech.c=
om> wrote:
> >> The arch_kgdb_breakpoint() function defines the kgdb_breakinst
> >> symbol using inline assembly.
> >>
> >> There's a potential issue where the compiler might inline
> >> arch_kgdb_breakpoint(), which would then define the kgdb_breakinst
> >> symbol multiple times, leading to a linker error.
> >>
> >> To prevent this, declare arch_kgdb_breakpoint() as noline.
> >>
> >> Fix follow error with LLVM-19 *only* when LTO_CLANG_FULL:
> >>      LD      vmlinux.o
> >>    ld.lld-19: error: ld-temp.o <inline asm>:3:1: symbol 'kgdb_breakins=
t' is already defined
> >>    kgdb_breakinst: break 2
> >>    ^
> >>
> >> Additionally, remove "nop" here because it's meaningless for LoongArch
> >> here.
> >>
> >> Fixes: e14dd076964e ("LoongArch: Add basic KGDB & KDB support")
> >> Co-developed-by: Winston Wen <wentao@uniontech.com>
> >> Signed-off-by: Winston Wen <wentao@uniontech.com>
> >> Co-developed-by: Wentao Guan <guanwentao@uniontech.com>
> >> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
> >> Co-developed-by: Huacai Chen <chenhuacai@loongson.cn>
> >> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> >> Tested-by: Yuli Wang <wangyuli@uniontech.com>
> >> Tested-by: Binbin Zhou <zhoubinbin@loongson.cn>
> >> Signed-off-by: Yuli Wang <wangyuli@uniontech.com>
> >> ---
> >> Changelog:
> >>   *v1->v2:
> >>      1. Drop the nop which is no effect for LoongArch here.
> >>      2. Add "STACK_FRAME_NON_STANDARD" for arch_kgdb_breakpoint() to
> >> avoid the objtool warning.
> >> ---
> >>   arch/loongarch/kernel/kgdb.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/loongarch/kernel/kgdb.c b/arch/loongarch/kernel/kgdb=
.c
> >> index 445c452d72a7..38bd0561d7d5 100644
> >> --- a/arch/loongarch/kernel/kgdb.c
> >> +++ b/arch/loongarch/kernel/kgdb.c
> >> @@ -224,13 +224,13 @@ void kgdb_arch_set_pc(struct pt_regs *regs, unsi=
gned long pc)
> >>          regs->csr_era =3D pc;
> >>   }
> >>
> >> -void arch_kgdb_breakpoint(void)
> >> +noinline void arch_kgdb_breakpoint(void)
> >>   {
> >>          __asm__ __volatile__ (                  \
> >>                  ".globl kgdb_breakinst\n\t"     \
> >> -               "nop\n"                         \
> >>                  "kgdb_breakinst:\tbreak 2\n\t"); /* BRK_KDB =3D 2 */
> >>   }
> >> +STACK_FRAME_NON_STANDARD(arch_kgdb_breakpoint);
> > Is there a better solution than STACK_FRAME_NON_STANDARD()? In the
> > past we can use annotate_reachable() in arch_kgdb_breakpoint(), but
> > annotate_reachable() is no longer exist.
>
> Maybe we can parse the imm-code of `break` and set diffrent insn_type in
> objtool.
> The BRK_KDB imply the PC will go head, while the BRK_BUG imply PC stop.
> (arch/loongarch/include/uapi/asm/break.h)
>
> Tiezhu, how do you think?
Touching objtool may be a little complicated, is ANNOTATE_REACHABLE()
the successor of annotate_reachable()? I tried
ANNOTATE_REACHABLE(kgdb_breakinst) but there was still a warning.

Huacai

>
>
> >
> > Huacai
> >
> >>   /*
> >>    * Calls linux_debug_hook before the kernel dies. If KGDB is enabled=
,
> >> --
> >> 2.49.0
> >>
>

