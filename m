Return-Path: <linux-kernel+bounces-344838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDA898AEC5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 22:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E337283B16
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14661A0BDA;
	Mon, 30 Sep 2024 20:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMp7o1bg"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9496C17BB38
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 20:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727729896; cv=none; b=CHh/A7H7fVrtmGZKfDOC+Hu3vwlDx3L0ctJlQKrtYE/wqCDaw6WP7F7H8g9qz739P9eHX7PC2Rn4hQdVOq0KlvID+IBrYrwv02nGv/5KkpojyG80DtT65RHQpYepeC8tcCPNIGLLp1h9JRU2/N3ulpc2D5VyCjwL7Z89jqBRf+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727729896; c=relaxed/simple;
	bh=glYqUcIpzfsKVj7ppiqTip3g0yCnhfX3t5X9scU5618=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TQtcIMJQ09GFVbWLWGaPt4glIKi32louDjpvDHYgdG8bxQ5v+W/PDQfu5P6I2AvcCa8qNgmr2Jl6lwDWPCY15Ims0IGvWlUsIhjvjyaaF+2w3EI4dwbRLR9n44o6PTPNw1kocNR9SdObBsXgGEc3Ywm0BlLqoz+u5ub3W8QxIAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMp7o1bg; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e09fe0a878so3175390a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 13:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727729894; x=1728334694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEbXvT4SnqQhvnH+qIpz2xvP+hEnbU9w8hvLakcDGNg=;
        b=hMp7o1bgkMqO98od7fIgir1n6dIgh9f1mZj7KhnNGyxZH/gcu24rFer5lqItz77Zii
         jsOjWsX+6syUe4Ai0gIsKIFBU6g9gbRtJ6/EnBWOx+Pclgz9CfYiUkUwT7E28qUgZWWe
         vfXDMMXHfZMgXVH1i8MLcr++P/SaQFlwqswXIhj8LYBY9El+IJDq/rs96wWsDBMJlbGW
         MCgNr2k0qpSKs6/KFlextmMCkL9ZfO1q+jJZdj5p6NC3fQ5P6le+shJKMD9zKOHXuHAX
         sg608uKePhz0GdSVDnf0/KBPWdEQc23bNA8pdKSdb+TmBVu9sYcReZ8fDRnCq1Ux4gLd
         UdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727729894; x=1728334694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YEbXvT4SnqQhvnH+qIpz2xvP+hEnbU9w8hvLakcDGNg=;
        b=t9PWOLd0L8iUlhOmIriuN25z9Zkg/rAkFuEuCNVMsAcNYmMqX68Eww09g1rhAAM7/e
         mLpevTtOWLlZI8KTYD8+RFxssllJjngSG/kQEWEyceS2LqB8VKINhfGQ5y0+BVqTpFSF
         RE8dmR18SGSojVfOA20A0qjhOkU9DC2+/FeKc4lZJgSzTBRpu5ozNiS0aXKpPhfnOFGG
         El7IwCo9lGfKbMobTmbR0gEsQbedBzBeZ6t7O3LeoLdf6pKQNHNPoMA/esUDprnA9DyT
         7U1sg2dzVjZeXJUWmwHAu+7nOiljr3j4mgbx02tcF4zCbOHVmULaMgDEb58IQs+MuQXs
         Cn7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU927JYHIv6fclIpu2ns+oFsfU9YJ672N86u7Oz4+DDYS3SII+8gTHsH6832Ifet4cZJvRyPVqcwdEX4ms=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkPD5l7wNneGXH1rWWokXS6sO9mmoz1A2Du3r0eNB1Wnlo7kTC
	LRLW5SYyILa5S3otdl4LktknDChwjzeL3Tw6MwCy2shVeShuyEe1UUaewHLIgLsXrz8pi8bVZH+
	T1ajujdujKW9ukgU8riHH0FbnYlE=
X-Google-Smtp-Source: AGHT+IEPiZB7T4421evaJ+D1Bg1sTg6wo0Gaqcm1Z3vT15MhBtbY3CUV+oleSiDoEplTzjQ50BNHHabrzYUb1gjrMkM=
X-Received: by 2002:a17:90a:398e:b0:2d8:8c82:10a with SMTP id
 98e67ed59e1d1-2e0b8865133mr14885570a91.5.1727729893734; Mon, 30 Sep 2024
 13:58:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927194856.096003183@infradead.org> <20240927194925.069013308@infradead.org>
 <CAADnVQ+BASJ7kcW4Kz_NsXM0U1+GrMHNVBOro8aO0-OyEry4Ww@mail.gmail.com>
 <20240930083026.GG5594@noisy.programming.kicks-ass.net> <20240930093302.GB33184@noisy.programming.kicks-ass.net>
In-Reply-To: <20240930093302.GB33184@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 30 Sep 2024 13:58:01 -0700
Message-ID: <CAEf4BzZx5iCAwS0iZv_0S1cADw840S8Ra=_PHPZhnW9cOYhFOQ@mail.gmail.com>
Subject: Re: [PATCH 07/14] x86/ibt: Clean up is_endbr()
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	alyssa.milburn@intel.com, scott.d.constable@intel.com, 
	Joao Moreira <joao@overdrivepizza.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, "Jose E. Marchesi" <jose.marchesi@oracle.com>, 
	"H.J. Lu" <hjl.tools@gmail.com>, Nick Desaulniers <ndesaulniers@google.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Nathan Chancellor <nathan@kernel.org>, ojeda@kernel.org, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 2:33=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Sep 30, 2024 at 10:30:26AM +0200, Peter Zijlstra wrote:
> > On Sun, Sep 29, 2024 at 10:32:38AM -0700, Alexei Starovoitov wrote:
> > > On Fri, Sep 27, 2024 at 12:50=E2=80=AFPM Peter Zijlstra <peterz@infra=
dead.org> wrote:
> >
> > > > --- a/kernel/trace/bpf_trace.c
> > > > +++ b/kernel/trace/bpf_trace.c
> > > > @@ -1027,19 +1027,9 @@ static const struct bpf_func_proto bpf_g
> > > >  #ifdef CONFIG_X86_KERNEL_IBT
> > > >  static unsigned long get_entry_ip(unsigned long fentry_ip)
> > > >  {
> > > > -       u32 instr;
> > > > +       if (is_endbr((void *)(fentry_ip - ENDBR_INSN_SIZE)))
> > > > +               return fentry_ip - ENDBR_INSN_SIZE;
> > > >
> > > > -       /* We want to be extra safe in case entry ip is on the page=
 edge,
> > > > -        * but otherwise we need to avoid get_kernel_nofault()'s ov=
erhead.
> > > > -        */
> > > > -       if ((fentry_ip & ~PAGE_MASK) < ENDBR_INSN_SIZE) {
> > > > -               if (get_kernel_nofault(instr, (u32 *)(fentry_ip - E=
NDBR_INSN_SIZE)))
> > > > -                       return fentry_ip;
> > > > -       } else {
> > > > -               instr =3D *(u32 *)(fentry_ip - ENDBR_INSN_SIZE);
> > > > -       }
> > > > -       if (is_endbr(instr))
> > > > -               fentry_ip -=3D ENDBR_INSN_SIZE;
> > > >         return fentry_ip;
> > >
> > > Pls don't.
> > >
> > > This re-introduces the overhead that we want to avoid.
> > >
> > > Just call __is_endbr() here and keep the optimization.
> >
> > Well, I could do that ofcourse, but as I wrote elsewhere, the right
> > thing to do is to optimize get_kernel_nofault(), its current
> > implementation is needlessly expensive. All we really need is a load
> > with an exception entry, the STAC/CLAC and speculation nonsense should
> > not be needed.
>
> Looking at things, something like the below actually generates sane
> code:
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index a582cd25ca87..84f65ee9736c 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1029,17 +1029,10 @@ static unsigned long get_entry_ip(unsigned long f=
entry_ip)
>  {
>         u32 instr;
>
> -       /* We want to be extra safe in case entry ip is on the page edge,
> -        * but otherwise we need to avoid get_kernel_nofault()'s overhead=
.
> -        */
> -       if ((fentry_ip & ~PAGE_MASK) < ENDBR_INSN_SIZE) {
> -               if (get_kernel_nofault(instr, (u32 *)(fentry_ip - ENDBR_I=
NSN_SIZE)))
> -                       return fentry_ip;
> -       } else {
> -               instr =3D *(u32 *)(fentry_ip - ENDBR_INSN_SIZE);
> -       }
> +       __get_kernel_nofault(&instr, (u32 *)(fentry_ip - ENDBR_INSN_SIZE)=
, u32, Efault);
>         if (is_endbr(instr))
>                 fentry_ip -=3D ENDBR_INSN_SIZE;
> +Efault:
>         return fentry_ip;
>  }
>  #else
>
>
> Which then leads to me rewriting the proposed patch as...
>
> ---
> Subject: x86/ibt: Clean up is_endbr()
> From: Peter Zijlstra <peterz@infradead.org>
>
> Pretty much every caller of is_endbr() actually wants to test something a=
t an
> address and ends up doing get_kernel_nofault(). Fold the lot into a more
> convenient helper.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/events/core.c         |    2 +-
>  arch/x86/include/asm/ibt.h     |    5 +++--
>  arch/x86/kernel/alternative.c  |   20 ++++++++++++++------
>  arch/x86/kernel/kprobes/core.c |   11 +----------
>  arch/x86/net/bpf_jit_comp.c    |    4 ++--
>  kernel/trace/bpf_trace.c       |   14 ++------------
>  6 files changed, 23 insertions(+), 33 deletions(-)
>
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2845,7 +2845,7 @@ static bool is_uprobe_at_func_entry(stru
>                 return true;
>
>         /* endbr64 (64-bit only) */
> -       if (user_64bit_mode(regs) && is_endbr(*(u32 *)auprobe->insn))
> +       if (user_64bit_mode(regs) && is_endbr((u32 *)auprobe->insn))
>                 return true;
>
>         return false;
> --- a/arch/x86/include/asm/ibt.h
> +++ b/arch/x86/include/asm/ibt.h
> @@ -65,7 +65,7 @@ static __always_inline __attribute_const
>         return 0x001f0f66; /* osp nopl (%rax) */
>  }
>
> -static inline bool is_endbr(u32 val)
> +static inline bool __is_endbr(u32 val)
>  {
>         if (val =3D=3D gen_endbr_poison())
>                 return true;
> @@ -74,6 +74,7 @@ static inline bool is_endbr(u32 val)
>         return val =3D=3D gen_endbr();
>  }
>
> +extern __noendbr bool is_endbr(u32 *val);
>  extern __noendbr u64 ibt_save(bool disable);
>  extern __noendbr void ibt_restore(u64 save);
>
> @@ -102,7 +103,7 @@ extern bool __do_kernel_cp_fault(struct
>
>  #define __noendbr
>
> -static inline bool is_endbr(u32 val) { return false; }
> +static inline bool is_endbr(u32 *val) { return false; }
>
>  static inline u64 ibt_save(bool disable) { return 0; }
>  static inline void ibt_restore(u64 save) { }
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -852,16 +852,24 @@ void __init_or_module noinline apply_ret
>
>  #ifdef CONFIG_X86_KERNEL_IBT
>
> +__noendbr bool is_endbr(u32 *val)
> +{
> +       u32 endbr;
> +
> +       __get_kernel_nofault(&endbr, val, u32, Efault);
> +       return __is_endbr(endbr);
> +
> +Efault:
> +       return false;
> +}
> +
>  static void poison_cfi(void *addr);
>
>  static void __init_or_module poison_endbr(void *addr, bool warn)
>  {
> -       u32 endbr, poison =3D gen_endbr_poison();
> -
> -       if (WARN_ON_ONCE(get_kernel_nofault(endbr, addr)))
> -               return;
> +       u32 poison =3D gen_endbr_poison();
>
> -       if (!is_endbr(endbr)) {
> +       if (!is_endbr(addr)) {
>                 WARN_ON_ONCE(warn);
>                 return;
>         }
> @@ -988,7 +996,7 @@ static u32  cfi_seed __ro_after_init;
>  static u32 cfi_rehash(u32 hash)
>  {
>         hash ^=3D cfi_seed;
> -       while (unlikely(is_endbr(hash) || is_endbr(-hash))) {
> +       while (unlikely(__is_endbr(hash) || __is_endbr(-hash))) {
>                 bool lsb =3D hash & 1;
>                 hash >>=3D 1;
>                 if (lsb)
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -373,16 +373,7 @@ static bool can_probe(unsigned long padd
>  kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned lo=
ng offset,
>                                          bool *on_func_entry)
>  {
> -       u32 insn;
> -
> -       /*
> -        * Since 'addr' is not guaranteed to be safe to access, use
> -        * copy_from_kernel_nofault() to read the instruction:
> -        */
> -       if (copy_from_kernel_nofault(&insn, (void *)addr, sizeof(u32)))
> -               return NULL;
> -
> -       if (is_endbr(insn)) {
> +       if (is_endbr((u32 *)addr)) {
>                 *on_func_entry =3D !offset || offset =3D=3D 4;
>                 if (*on_func_entry)
>                         offset =3D 4;
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -625,7 +625,7 @@ int bpf_arch_text_poke(void *ip, enum bp
>          * See emit_prologue(), for IBT builds the trampoline hook is pre=
ceded
>          * with an ENDBR instruction.
>          */
> -       if (is_endbr(*(u32 *)ip))
> +       if (is_endbr(ip))
>                 ip +=3D ENDBR_INSN_SIZE;
>
>         return __bpf_arch_text_poke(ip, t, old_addr, new_addr);
> @@ -2971,7 +2971,7 @@ static int __arch_prepare_bpf_trampoline
>                 /* skip patched call instruction and point orig_call to a=
ctual
>                  * body of the kernel function.
>                  */
> -               if (is_endbr(*(u32 *)orig_call))
> +               if (is_endbr(orig_call))
>                         orig_call +=3D ENDBR_INSN_SIZE;
>                 orig_call +=3D X86_PATCH_SIZE;
>         }
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1027,19 +1027,9 @@ static const struct bpf_func_proto bpf_g
>  #ifdef CONFIG_X86_KERNEL_IBT
>  static unsigned long get_entry_ip(unsigned long fentry_ip)
>  {
> -       u32 instr;
> +       if (is_endbr((void *)(fentry_ip - ENDBR_INSN_SIZE)))
> +               return fentry_ip - ENDBR_INSN_SIZE;
>
> -       /* We want to be extra safe in case entry ip is on the page edge,
> -        * but otherwise we need to avoid get_kernel_nofault()'s overhead=
.
> -        */
> -       if ((fentry_ip & ~PAGE_MASK) < ENDBR_INSN_SIZE) {
> -               if (get_kernel_nofault(instr, (u32 *)(fentry_ip - ENDBR_I=
NSN_SIZE)))
> -                       return fentry_ip;
> -       } else {
> -               instr =3D *(u32 *)(fentry_ip - ENDBR_INSN_SIZE);
> -       }
> -       if (is_endbr(instr))
> -               fentry_ip -=3D ENDBR_INSN_SIZE;
>         return fentry_ip;
>  }
>  #else

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

