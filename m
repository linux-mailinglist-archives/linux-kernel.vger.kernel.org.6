Return-Path: <linux-kernel+bounces-573153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C65A6D3A5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 05:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D06F81680EE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 04:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9127218A93F;
	Mon, 24 Mar 2025 04:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElVkj4ox"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBC2188591
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 04:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742792013; cv=none; b=WvKl2csT36kqkDq6Up5naBAjQF7u/KB1DPu/vnGVzzPhdrAttJ929fXAoEXIerccMSFDqo54S5sJyACUmZOixkRBwAHVpKTs94YI/4RxoXT21ho/oPFzPZUB4NlQJLiiFQvxKhwiyLm0D16hIZKX1FddQ7AsN6u+9iYuK6NNW7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742792013; c=relaxed/simple;
	bh=3/x51t1fgMs7fG3nO/H3wOuj/LwA71vuP96gmtfJ5N8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EtFQnu2/gj6zXuudfxwkggwCX3Efqbnlp04SyTg+g6340EWgYxvURy8svgl/yMK/IN6t5kKsfx0HY9o9Q8G2PDoe3EUME0xt3AuN6kM8UXNAI0L+bEu5J8rsACGaN6MauXmbh22B1fewLbeK0hFs/6lGAInYmWvhmW0eo/vGVLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElVkj4ox; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50850C4CEDD
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 04:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742792013;
	bh=3/x51t1fgMs7fG3nO/H3wOuj/LwA71vuP96gmtfJ5N8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ElVkj4oxjiUDE8Jf2TYni4mqvrZOUVEa1H9YBl3mV9p9XOpM3IyDItAZIkAGn2rjU
	 gaDZKdj4KqGk//s4+KRejPQ0NVLyfjc3gTmJec9bmB134nZZooAsV17le8EKy7MdtE
	 bHAAKiqUPY2WRzxOpwkB5B5x9OlXOxxmhj+qnesTkZZEoANqmXXDsYfhLlnSKGLXz0
	 SRvhyqdsuO/FCbUSKUxkSN2Nl7wBHeDhOUAyH9FBGw75P9qo7J/qKINVMpW6mEqTEx
	 WoHysty7OuDKGpxX8HxypRFuwHMocSI6//GJkYU5x1y5wm+Vagw3/p889YuFkosLJF
	 6FJs0Noss4A1Q==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e5e34f4e89so7283165a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 21:53:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXCPFyndQcETDxw4tZai+0sPUOGTkeYWcZSaTvXhs1uOKSxnsiIJ1vtzvbfFcFeF+sIBXjmnsQr6jZdiz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCynavB5OW+PFt0OqYQzcIxyc8aR/6Bj6aGDdclbvyuhLltyBw
	t4GPfnsiY28Cu0CC4uyKmtvX+UvU+V57zF/M74JD0/eQ8iLvZfMNcEUOX3JM3Yy6GxLww0fT5BZ
	GcPdEWgtI2xNF0T9po0/vvPsnRPQ=
X-Google-Smtp-Source: AGHT+IEP1ircE6G4cPMByDubGspMRhA3CZjhb9zKhyd+06Q3bN0hXbP3l0NU/iTEQh8CQD9cE52Bcm4omqeeQ4pkr/c=
X-Received: by 2002:a17:907:f508:b0:ac4:16a:1863 with SMTP id
 a640c23a62f3a-ac4016a41ebmr785684866b.26.1742792011930; Sun, 23 Mar 2025
 21:53:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <943E06D656E4E707+20250321141001.109916-1-wangyuli@uniontech.com>
 <CAAhV-H71aEKj2V8mAqbUuAe1JiHngWHW3rSaJ_Dx_CzoQC7TgQ@mail.gmail.com>
 <545ed081-bec3-395c-e0dd-a45146e00cd1@loongson.cn> <CAAhV-H51AxAjhhge=w4Y=p0XnuW-RyuvA5dPpPc-F0N9YPYHrg@mail.gmail.com>
 <30b25aa7-106f-7ebf-296d-0e05d7da75eb@loongson.cn>
In-Reply-To: <30b25aa7-106f-7ebf-296d-0e05d7da75eb@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 24 Mar 2025 12:53:22 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7vg=Vh40phqu4btsZU39o+Rfo0mAsrKF9P0nX=UvaO_g@mail.gmail.com>
X-Gm-Features: AQ5f1Jr8QjD_hmfBUlBT0UGfcl7wC9EzAeqvktoYVEve1vvUXDYM6tLiQn51sMw
Message-ID: <CAAhV-H7vg=Vh40phqu4btsZU39o+Rfo0mAsrKF9P0nX=UvaO_g@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: KGDB: Rework arch_kgdb_breakpoint() implementation
To: Jinyang He <hejinyang@loongson.cn>
Cc: WangYuli <wangyuli@uniontech.com>, kernel@xen0n.name, guanwentao@uniontech.com, 
	wentao@uniontech.com, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	zhoubinbin@loongson.cn, lihui@loongson.cn, rdunlap@infradead.org, 
	chenhuacai@loongson.cn, zhanjun@uniontech.com, niecheng1@uniontech.com, 
	Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 12:31=E2=80=AFPM Jinyang He <hejinyang@loongson.cn>=
 wrote:
>
> On 2025-03-24 12:09, Huacai Chen wrote:
>
> > Hi, Jinyang,
> >
> > On Mon, Mar 24, 2025 at 9:42=E2=80=AFAM Jinyang He <hejinyang@loongson.=
cn> wrote:
> >> On 2025-03-22 20:51, Huacai Chen wrote:
> >>
> >>> Hi, Tiezhu & Jinyang,
> >>>
> >>> On Fri, Mar 21, 2025 at 10:11=E2=80=AFPM WangYuli <wangyuli@uniontech=
.com> wrote:
> >>>> The arch_kgdb_breakpoint() function defines the kgdb_breakinst
> >>>> symbol using inline assembly.
> >>>>
> >>>> There's a potential issue where the compiler might inline
> >>>> arch_kgdb_breakpoint(), which would then define the kgdb_breakinst
> >>>> symbol multiple times, leading to a linker error.
> >>>>
> >>>> To prevent this, declare arch_kgdb_breakpoint() as noline.
> >>>>
> >>>> Fix follow error with LLVM-19 *only* when LTO_CLANG_FULL:
> >>>>       LD      vmlinux.o
> >>>>     ld.lld-19: error: ld-temp.o <inline asm>:3:1: symbol 'kgdb_break=
inst' is already defined
> >>>>     kgdb_breakinst: break 2
> >>>>     ^
> >>>>
> >>>> Additionally, remove "nop" here because it's meaningless for LoongAr=
ch
> >>>> here.
> >>>>
> >>>> Fixes: e14dd076964e ("LoongArch: Add basic KGDB & KDB support")
> >>>> Co-developed-by: Winston Wen <wentao@uniontech.com>
> >>>> Signed-off-by: Winston Wen <wentao@uniontech.com>
> >>>> Co-developed-by: Wentao Guan <guanwentao@uniontech.com>
> >>>> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
> >>>> Co-developed-by: Huacai Chen <chenhuacai@loongson.cn>
> >>>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> >>>> Tested-by: Yuli Wang <wangyuli@uniontech.com>
> >>>> Tested-by: Binbin Zhou <zhoubinbin@loongson.cn>
> >>>> Signed-off-by: Yuli Wang <wangyuli@uniontech.com>
> >>>> ---
> >>>> Changelog:
> >>>>    *v1->v2:
> >>>>       1. Drop the nop which is no effect for LoongArch here.
> >>>>       2. Add "STACK_FRAME_NON_STANDARD" for arch_kgdb_breakpoint() t=
o
> >>>> avoid the objtool warning.
> >>>> ---
> >>>>    arch/loongarch/kernel/kgdb.c | 4 ++--
> >>>>    1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/arch/loongarch/kernel/kgdb.c b/arch/loongarch/kernel/kg=
db.c
> >>>> index 445c452d72a7..38bd0561d7d5 100644
> >>>> --- a/arch/loongarch/kernel/kgdb.c
> >>>> +++ b/arch/loongarch/kernel/kgdb.c
> >>>> @@ -224,13 +224,13 @@ void kgdb_arch_set_pc(struct pt_regs *regs, un=
signed long pc)
> >>>>           regs->csr_era =3D pc;
> >>>>    }
> >>>>
> >>>> -void arch_kgdb_breakpoint(void)
> >>>> +noinline void arch_kgdb_breakpoint(void)
> >>>>    {
> >>>>           __asm__ __volatile__ (                  \
> >>>>                   ".globl kgdb_breakinst\n\t"     \
> >>>> -               "nop\n"                         \
> >>>>                   "kgdb_breakinst:\tbreak 2\n\t"); /* BRK_KDB =3D 2 =
*/
> >>>>    }
> >>>> +STACK_FRAME_NON_STANDARD(arch_kgdb_breakpoint);
> >>> Is there a better solution than STACK_FRAME_NON_STANDARD()? In the
> >>> past we can use annotate_reachable() in arch_kgdb_breakpoint(), but
> >>> annotate_reachable() is no longer exist.
> >> Maybe we can parse the imm-code of `break` and set diffrent insn_type =
in
> >> objtool.
> >> The BRK_KDB imply the PC will go head, while the BRK_BUG imply PC stop=
.
> >> (arch/loongarch/include/uapi/asm/break.h)
> >>
> >> Tiezhu, how do you think?
> > Touching objtool may be a little complicated, is ANNOTATE_REACHABLE()
> > the successor of annotate_reachable()? I tried
> > ANNOTATE_REACHABLE(kgdb_breakinst) but there was still a warning.
> Should it annotate to the next insn of `break`?
> Like,
>
>      kgdb_breakinst:
>      break 2
>      another_label:
>
> ANNOTATE_REACHABLE(another_label)
Still no help.

Huacai

>
> Jinyang
> >
> > Huacai
> >
> >>
> >>> Huacai
> >>>
> >>>>    /*
> >>>>     * Calls linux_debug_hook before the kernel dies. If KGDB is enab=
led,
> >>>> --
> >>>> 2.49.0
> >>>>
>

