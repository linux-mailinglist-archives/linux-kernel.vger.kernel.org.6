Return-Path: <linux-kernel+bounces-343084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3433989696
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 19:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C0DFB20D63
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 17:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F36138396;
	Sun, 29 Sep 2024 17:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPqGQ8Qb"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2511D3D9E
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 17:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727631172; cv=none; b=G4HOnV5Pw4TLMhDwwFRWkDQgkUkCIPyOt4Obp6fHyM2RdZec+oS8BoxRR5tfjlLh7W4TPDx3Mm31EE6mJBw5Yqac+4y3doQ5SU/Y3sy9BSNAasqgTtomKmbm13PCOuWacEmsqqfZ02YJ4R6mCD1NwTeqFlDOQwzD8I0tNShdDXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727631172; c=relaxed/simple;
	bh=X8A2Tz56LNzlGwH5/XtCpwhX1OU48AovGc/OWSI/Bv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d2/eGc4ONnrpPbUCDIZ7APtOhwi2TRVRTuqfH/eXbjH0gynMfC1XF/Qf3mpYtmt4LvoFENqS5CMbxoYEyaCICi8cjw4hnh+gxe8q/hVOpua7ariucrg6hV6fXlJZrHM/J5QySiKSDkSfsab9CXMIlSxvBNK+PtG/008QIR2pJh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPqGQ8Qb; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42e748f78d6so29491695e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 10:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727631169; x=1728235969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZURtQeetov8NFfcV2gSpCNd276ZYtO2gOfuHJPNEEg=;
        b=lPqGQ8Qb9UxvcUSRN37D3ArRhLsnhli3T94ENcQzpqr8tVr8lnnIeL9BhZgJ5RD6Cx
         PMkvaTPlgRDtFFDkbs/Pe4A/ctl+/YTpT9sDYsi3XkyUKBvXeaEnmoHzCM3w/caJyLyA
         SO8vCZ4LliEsEZKx8bYt+aOaj4BKodPrbFVfppM9+oD+94ACuyc49S/3EKJkSaPDvURt
         bHuh6yzChHmJte3QCUE/qd3gni5PojYvFnl4o3/ooOdoeWwFrswtO/9suKKY2bsHg6xf
         k7raz2KgN0sQf8b5uABMcKp/QT8/kaBr1AUUm7uFNDR6wH1JcVqeux4blpgVzhIegp3W
         LkqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727631169; x=1728235969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZURtQeetov8NFfcV2gSpCNd276ZYtO2gOfuHJPNEEg=;
        b=C083d/ZjUPX0HUg2lmzsFNTCBtLJvmNEjV2PDy7M0cw1ZiRE01KGfVuWfAKi4z1doe
         FRQkCdTrJxN5AzQL06EZ0Dl/bK8Pjzul9JO10mV6VIi/NmiI/fLx9vomUMBNWxFUg/mF
         JDT0ukLqDruV9xl8n/SYNH46CkNOF5zbrNz5wS3mgT3G/C9NuCNOlYXspND4mF2vTTfi
         o3BKvBsanuOdC3iA15MvZrqSoyAJbMbjNk1gbQvt22FHmam4FWNCk9jJBhbgFwQ8ARnj
         nWEPdyAjCzky7l7XLD/PeNIKlMKbGkeUATbD0nrkZ/wRmWCAayVrro2Uw72XqJ2+OI/c
         3hhg==
X-Forwarded-Encrypted: i=1; AJvYcCWpwzqHZ5B1zKYsN5Sou8Zyfp1qaiJ55a5I79cVHV5usl1YSG3Y05gXPDliKLJE1mUI3TqZ/PZFWr0gGeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUtCJOnps7Wzk6F2flC7AHRSwq1OrXWKaStM30hmno8N3a4077
	Qb5bWAQ88awRwV8pZnS6As0a4F1l+SD4jKCErBlxcXhn6/e3SJQEXI+wKHLAbTIIQIO+jdnUdSc
	aXQ70cNhia7QxNj/FwOOx9dhpVyXT+rxr
X-Google-Smtp-Source: AGHT+IE3L/jlrckw29i3ENwTsWIIWDV2E29i2ybKfLtC7XmFCu1afhB1d0I5cjj6c4PdQV2YQ2c4a+rMuOhb69Cj/6Q=
X-Received: by 2002:a05:600c:1e17:b0:42b:a88f:f872 with SMTP id
 5b1f17b1804b1-42f584993aamr67945575e9.32.1727631169335; Sun, 29 Sep 2024
 10:32:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927194856.096003183@infradead.org> <20240927194925.069013308@infradead.org>
In-Reply-To: <20240927194925.069013308@infradead.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 29 Sep 2024 10:32:38 -0700
Message-ID: <CAADnVQ+BASJ7kcW4Kz_NsXM0U1+GrMHNVBOro8aO0-OyEry4Ww@mail.gmail.com>
Subject: Re: [PATCH 07/14] x86/ibt: Clean up is_endbr()
To: Peter Zijlstra <peterz@infradead.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	alyssa.milburn@intel.com, scott.d.constable@intel.com, 
	Joao Moreira <joao@overdrivepizza.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, "Jose E. Marchesi" <jose.marchesi@oracle.com>, 
	"H.J. Lu" <hjl.tools@gmail.com>, Nick Desaulniers <ndesaulniers@google.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Nathan Chancellor <nathan@kernel.org>, ojeda@kernel.org, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 12:50=E2=80=AFPM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> Pretty much every caller of is_endbr() actually wants to test something a=
t an
> address and ends up doing get_kernel_nofault(). Fold the lot into a more
> convenient helper.
>
> Note: this effectively reverts commit a8497506cd2c ("bpf: Avoid
> get_kernel_nofault() to fetch kprobe entry IP") which was entirely the
> wrong way to go about doing things. The right solution is to optimize
> get_kernel_nofault() itself, it really doesn't need STAC/CLAC nor the
> speculation barrier. Using __get_user is a historical hack, not a
> requirement.
>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/events/core.c         |    2 +-
>  arch/x86/include/asm/ibt.h     |    5 +++--
>  arch/x86/kernel/alternative.c  |   19 +++++++++++++------
>  arch/x86/kernel/kprobes/core.c |   11 +----------
>  arch/x86/net/bpf_jit_comp.c    |    4 ++--
>  kernel/trace/bpf_trace.c       |   14 ++------------
>  6 files changed, 22 insertions(+), 33 deletions(-)
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
> @@ -852,16 +852,23 @@ void __init_or_module noinline apply_ret
>
>  #ifdef CONFIG_X86_KERNEL_IBT
>
> +__noendbr bool is_endbr(u32 *val)
> +{
> +       u32 endbr;
> +
> +       if (get_kernel_nofault(endbr, val))
> +               return false;
> +
> +       return __is_endbr(endbr);
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
> @@ -988,7 +995,7 @@ static u32  cfi_seed __ro_after_init;
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

Pls don't.

This re-introduces the overhead that we want to avoid.

Just call __is_endbr() here and keep the optimization.

