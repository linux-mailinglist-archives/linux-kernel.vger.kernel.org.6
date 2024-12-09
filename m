Return-Path: <linux-kernel+bounces-437863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E0E9E99C9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F99F1889491
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CB31BEF84;
	Mon,  9 Dec 2024 14:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="eoA+AkUe"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797CD21571D
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 14:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733756251; cv=none; b=RFDBPdSc+02xf864jDEMmCaOAl61oC1ortn4YBdj632QMrmqX6hvQ03JgSOEYLuRPHc4q/16F73RqWoef001+9anepBKr4o4yvSpPPRTvwaEgQM0HQZFRzgtvir2mnC0g1TI6hkCavKoufEmaafHiZQrFD09pqVqOuIG08WWyEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733756251; c=relaxed/simple;
	bh=ELI9HBsqk/zjwhTKYufKEjD5YYG1FET9VtdFSNj4R3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eeEmWFUFO3NlgA71fMomzxgqqMil2YSVWPh6lJS0kyXLodjSLlrAdfnqPgIRFG4mvKbZEwjeceqXuTxdFOs5IAzQgKc49PoDh1VuzI462rlJ6sE7/bq9Fayb/EgEKXTW2SYgzD2DV0a3Y46VwlTQPWH3DGP9JoLNbsx9YG0Cjk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=eoA+AkUe; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ef89dbd8eeso1302036a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 06:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733756245; x=1734361045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjsTCR+5RxYGrWL4qskLBf96ASK6QM6vt0yQXaMf9Lw=;
        b=eoA+AkUeqjW/HXPt0iZ2YD1ZJATKJZz/4Fm6m/nPGJx97HsOVSRzLlTC/9zn3nEDa2
         oQpDLTHoGC+3j5z0gawoU1bwQy82O3KkGXrWC+PagnIU7BJsjK3Gp9UT378LvU8U1fiE
         ajNips1YrCMDD9CAfsssKfmUl+ilz41cX3iP87We6Lt1p9JBx41kNwgJECSK1UvcTRxQ
         pv45e1o+7zYy8M425bBrT7EukFfTC/VQGCJHwqtRiy6sAr0AQH00GQOrPYJLSw4rlmc6
         GOyRqVXZaOkOi6K43lz1bKAVro1oxVZiPHFfPtYbma4fO98rfstO/Ajaf1X/7TZ3OkWD
         DudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733756245; x=1734361045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sjsTCR+5RxYGrWL4qskLBf96ASK6QM6vt0yQXaMf9Lw=;
        b=Fb0BVjtgP2aKLbAduuQaygTnz04dor1aMvb9ZWexstgLZEzsKVi9ivofdHTjinvspP
         UWpEd/nFQdRoraX8nCE9ousJXeiko70hE3ovdfJEPrGdfN6kt3pbjrpYxg3l0Ua/a7gp
         bG0parbT93PNpqUVIuzevximWMidNzqRsmvMbS6jxc4QjscNX7WJfSaaeFgRNmyGQXwC
         Y0Hllug6C3n0l0B5khW1qs7MQT9oXgqsTE60QJzr0vYxYiyOnL3GU1Isr/6JcQGuFyp9
         MDUSZvH2u+SWbQUcr43OrAY9gxWK451tlZVOp8KnMEkEGvCYTtzA4hCCL7/WQcPW5itX
         9oxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOcMeJTLz24qTvJwOwKOEhxCoRsXWE8Hzo+lAhT5AqBCYFMt7dtzz40hh6GHK2zzvyIcXWRJCOTxfbEss=@vger.kernel.org
X-Gm-Message-State: AOJu0YzupXQqV1hqaqEkTWkZ8sTp/aAVtaecUjtuMS6uy3zwxZlp0vYV
	wggKinPYRPc019leVsfWvMf31ezIe27GmaReq2NWHrz3uNrI6wAmNrCkM2zDQyYoy2DEGJKmjnI
	8XFPNDtT6OvUchQ50Wrl9B9CUvXRjxZHkbXwzxA==
X-Gm-Gg: ASbGncu74SQHIxNnSm7ffc7HBHgcjkutuoglZXFMkac9uyctTP/yEJRetdYkVmg6v97
	9bzhb8iJvx1dgujtOMG4fbmaAvFesMhJJ8FnPchKSRPhId/j4kSQUX/k8krQ3BN5B
X-Google-Smtp-Source: AGHT+IEHKlqLcFQlrPjzXIY6tJZZYZacdFx3e/nKjGNluiUR0wQprBep81Cu1SZ9Y9N7lTgTPlW1z1CM4msl9KJOX2k=
X-Received: by 2002:a17:90b:17c2:b0:2ee:44ec:e524 with SMTP id
 98e67ed59e1d1-2ef6aadde15mr19179341a91.35.1733756245426; Mon, 09 Dec 2024
 06:57:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127172908.17149-1-andybnac@gmail.com> <20241127172908.17149-4-andybnac@gmail.com>
 <87v7vxf7t6.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87v7vxf7t6.fsf@all.your.base.are.belong.to.us>
From: Robbin Ehn <rehn@rivosinc.com>
Date: Mon, 9 Dec 2024 15:57:13 +0100
Message-ID: <CAEEvPLBi24RQ5gG3NCR4B2f5wEpnoYu_YSki6yo5=PZgoKcuzg@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] riscv: ftrace: prepare ftrace for atomic code patching
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Andy Chiu <andybnac@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	bjorn@rivosinc.com, puranjay12@gmail.com, alexghiti@rivosinc.com, 
	yongxuan.wang@sifive.com, greentime.hu@sifive.com, nick.hu@sifive.com, 
	nylon.chen@sifive.com, tommy.wu@sifive.com, eric.lin@sifive.com, 
	viccent.chen@sifive.com, zong.li@sifive.com, samuel.holland@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 11:02=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> Adding Robbin for input, who's doing much more crazy text patching in
> JVM, than what we do in the kernel. ;-)
>
> Andy Chiu <andybnac@gmail.com> writes:
>
> > From: Andy Chiu <andy.chiu@sifive.com>
> >
> > We use an AUIPC+JALR pair to jump into a ftrace trampoline. Since
> > instruction fetch can break down to 4 byte at a time, it is impossible
> > to update two instructions without a race. In order to mitigate it, we
> > initialize the patchable entry to AUIPC + NOP4. Then, the run-time code
> > patching can change NOP4 to JALR to eable/disable ftrcae from a
> > function. This limits the reach of each ftrace entry to +-2KB displacin=
g
> > from ftrace_caller.
> >
> > Starting from the trampoline, we add a level of indirection for it to
> > reach ftrace caller target. Now, it loads the target address from a
> > memory location, then perform the jump. This enable the kernel to updat=
e
> > the target atomically.
> >
> > The ordering of reading/updating the targert address should be guarded
> > by generic ftrace code, where it sends smp_rmb ipi.
>
> Let's say we're tracing "f". Previously w/ stop_machine() it was
> something like:
>
> f:
> 1: nop
>    nop
>    ...
>    ...
>
> ftrace_caller:
>    ...
>    auipc        a2, function_trace_op
>    ld           a2, function_trace_op(a2)
>    ...
> 2: auipc    ra, ftrace_stub
>    jalr     ftrace_stub(ra)
>
> The text was patched by ftrace in 1 and 2.
>
> ...and now:
> f:
>    auipc    t0, ftrace_caller
> A: nop
>    ...
>    ...
>
> ftrace_caller:
>    ...
>    auipc    a2, function_trace_op
>    ld       a2, function_trace_op(a2)
>    ...
>    auipc    ra, ftrace_call_dest
>    ld       ra, ftrace_call_dest(ra)
>    jalr     ra
>
> The text is only patched in A, and the tracer func is loaded via
> ftrace_call_dest.
>
> Today, when we enable trace "f" the following is done by ftrace:
>   Text patch 2: call ftrace_stub -> call arch_ftrace_ops_list_func
>   Text patch 1: nop,nop -> call ftrace_caller
>   store function_trace_op
>   smp_wmb()
>   IPI: smp_rmb()
>   Text patch 2: call arch_ftrace_ops_list_func -> call function_trace_cal=
l
>
> Disable, would be something like:
>   Text patch 2: call function_trace_call -> call arch_ftrace_ops_list_fun=
c
>   Text patch 1: call ftrace_caller -> nop,nop
>   store function_trace_op
>   smp_wmb()
>   IPI: smp_rmb()
>   Text patch 2: call arch_ftrace_ops_list_func -> call ftrace_stub
>
> Now with this change, enable would be:
>   store ftrace_call_dest (was: Text patch 2: call ftrace_stub -> call arc=
h_ftrace_ops_list_func)
>   <<ORDERING>>
>   Text patch A: nop -> jalr ftrace_caller(t0)
>   store function_trace_op
>   smp_wmb()
>   IPI: smp_rmb()
>   store ftrace_call_dest (was: Text patch 2: call arch_ftrace_ops_list_fu=
nc -> call function_trace_call)
>
> Seems like we're missing some data ordering in "<<ORDERING>>", wrt to
> the text patching A (The arch specific ftrace_update_ftrace_func())? Or
> are we OK with reordering there? Maybe add what's done for
> function_trace_op?
>
> [...]
>

Hi, so we allow reordering of the following 3 stores (set via
ftrace_modify_all_code()):

ftrace_call_dest =3D ftrace_ops_list_func
Instruction patch NOP -> JALR
function_trace_op =3D set_function_trace_op
<data-ordering>
ftrace_call_dest =3D ftrace_trace_function
<ins-ordering>

From what I can tell all combinations will be fine as trace OP is not
read and ftrace_call_dest should be ftrace_stub in such reordering
case.
It looks like, as we do this under lock (should be an lockdep assert
in ftrace_modify_all_code for ftrace_lock), we only go from:
n tracers =3D> 0 tracers
0 tracers =3D> n tracers

Meaning we never add and remove tracers in the same update, so this
reordering seems fine.
Otherwise we could pass an OP for an old tracer into a new tracer.
(function_trace_op happens before ftrace_call_dest store)

As the function_trace_op can be concurrently loaded via ftrace_caller
it should thus be stored with WRITE_ONCE for good measure.

> > Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
> > ---
> >  arch/riscv/include/asm/ftrace.h |  4 ++
> >  arch/riscv/kernel/ftrace.c      | 80 +++++++++++++++++++++------------
> >  arch/riscv/kernel/mcount-dyn.S  |  9 ++--
> >  3 files changed, 62 insertions(+), 31 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/f=
trace.h
> > index 4ca7ce7f34d7..36734d285aad 100644
> > --- a/arch/riscv/include/asm/ftrace.h
> > +++ b/arch/riscv/include/asm/ftrace.h
> > @@ -80,6 +80,7 @@ struct dyn_arch_ftrace {
> >  #define JALR_T0                      (0x000282e7)
> >  #define AUIPC_T0             (0x00000297)
> >  #define NOP4                 (0x00000013)
> > +#define JALR_RANGE           (JALR_SIGN_MASK - 1)
> >
> >  #define to_jalr_t0(offset)                                           \
> >       (((offset & JALR_OFFSET_MASK) << JALR_SHIFT) | JALR_T0)
> > @@ -117,6 +118,9 @@ do {                                               =
                       \
> >   * Let auipc+jalr be the basic *mcount unit*, so we make it 8 bytes he=
re.
> >   */
> >  #define MCOUNT_INSN_SIZE 8
> > +#define MCOUNT_AUIPC_SIZE    4
> > +#define MCOUNT_JALR_SIZE     4
> > +#define MCOUNT_NOP4_SIZE     4
>
> Align please.
>
> >
> >  #ifndef __ASSEMBLY__
> >  struct dyn_ftrace;
> > diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> > index 4b95c574fd04..5ebe412280ef 100644
> > --- a/arch/riscv/kernel/ftrace.c
> > +++ b/arch/riscv/kernel/ftrace.c
> > @@ -64,42 +64,64 @@ static int ftrace_check_current_call(unsigned long =
hook_pos,
> >       return 0;
> >  }
> >
> > -static int __ftrace_modify_call(unsigned long hook_pos, unsigned long =
target,
> > -                             bool enable, bool ra)
> > +static int __ftrace_modify_call(unsigned long hook_pos, unsigned long =
target, bool validate)
>
> While we're updating this function; Can we rename hook_pos to something
> that makes sense from an ftrace perspective?
>
> >  {
> >       unsigned int call[2];
> > -     unsigned int nops[2] =3D {NOP4, NOP4};
> > +     unsigned int replaced[2];
> > +
> > +     make_call_t0(hook_pos, target, call);

If you use to_jalr_t0 it's easier to read. (maybe remove make_call_t0).

> >
> > -     if (ra)
> > -             make_call_ra(hook_pos, target, call);
> > -     else
> > -             make_call_t0(hook_pos, target, call);
> > +     if (validate) {
> > +             /*
> > +              * Read the text we want to modify;
> > +              * return must be -EFAULT on read error
> > +              */

Use to_auipc_t0 for validation.

> > +             if (copy_from_kernel_nofault(replaced, (void *)hook_pos,
> > +                                          MCOUNT_INSN_SIZE))
>
> Don't wrap this line.
>
> > +                     return -EFAULT;
> > +
> > +             if (replaced[0] !=3D call[0]) {
> > +                     pr_err("%p: expected (%08x) but got (%08x)\n",
> > +                            (void *)hook_pos, call[0], replaced[0]);
> > +                     return -EINVAL;
> > +             }
> > +     }
> >
> > -     /* Replace the auipc-jalr pair at once. Return -EPERM on write er=
ror. */
> > -     if (patch_insn_write((void *)hook_pos, enable ? call : nops, MCOU=
NT_INSN_SIZE))
> > +     /* Replace the jalr at once. Return -EPERM on write error. */
> > +     if (patch_insn_write((void *)(hook_pos + MCOUNT_AUIPC_SIZE), call=
 + 1, MCOUNT_JALR_SIZE))
> >               return -EPERM;
> >
> >       return 0;
> >  }
> >
> > -int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
> > +static int __ftrace_modify_call_site(ftrace_func_t *hook_pos, ftrace_f=
unc_t target, bool enable)

As the bool value enable is hardcoded to true/false I would just have
two functions.
IMHO the name ftrace_modify_call_site() makes little sense, especially
since there is a ftrace_modify_call().

> >  {
> > -     unsigned int call[2];
> > +     ftrace_func_t call =3D target;
> > +     ftrace_func_t nops =3D &ftrace_stub;
>
> Confusing to call nops. This is not nops. This is the ftrace_stub. Also
> the __ftrace_modify_call_site is not super clear to me. Maybe just ditch
> the enable flag, and have two functions? Or just or inline it?
>
> >
> > -     make_call_t0(rec->ip, addr, call);
> > -
> > -     if (patch_insn_write((void *)rec->ip, call, MCOUNT_INSN_SIZE))
> > -             return -EPERM;
> > +     WRITE_ONCE(*hook_pos, enable ? call : nops);
> >
> >       return 0;
> >  }
> >
> > +int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
> > +{
> > +     unsigned long distance, orig_addr;
> > +
> > +     orig_addr =3D (unsigned long)&ftrace_caller;
> > +     distance =3D addr > orig_addr ? addr - orig_addr : orig_addr - ad=
dr;
> > +     if (distance > JALR_RANGE)
> > +             return -EINVAL;
> > +
> > +     return __ftrace_modify_call(rec->ip, addr, false);
> > +}
> > +
> >  int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
> >                   unsigned long addr)
> >  {
> > -     unsigned int nops[2] =3D {NOP4, NOP4};
> > +     unsigned int nops[1] =3D {NOP4};
>
> It's just one nop, not nops. No biggie, but why array?
>
> >
> > -     if (patch_insn_write((void *)rec->ip, nops, MCOUNT_INSN_SIZE))
> > +     if (patch_insn_write((void *)(rec->ip + MCOUNT_AUIPC_SIZE), nops,=
 MCOUNT_NOP4_SIZE))
> >               return -EPERM;
> >
> >       return 0;
> > @@ -114,21 +136,23 @@ int ftrace_make_nop(struct module *mod, struct dy=
n_ftrace *rec,
> >   */
> >  int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
> >  {
> > +     unsigned int nops[2];
> >       int out;
> >
> > +     make_call_t0(rec->ip, &ftrace_caller, nops);
> > +     nops[1] =3D NOP4;

Use to_auipc_t0.

> > +
> >       mutex_lock(&text_mutex);
> > -     out =3D ftrace_make_nop(mod, rec, MCOUNT_ADDR);
> > +     out =3D patch_insn_write((void *)rec->ip, nops, MCOUNT_INSN_SIZE)=
;
> >       mutex_unlock(&text_mutex);
> >
> >       return out;
> >  }
> >
> > +ftrace_func_t ftrace_call_dest =3D ftrace_stub;
> >  int ftrace_update_ftrace_func(ftrace_func_t func)
> >  {
> > -     int ret =3D __ftrace_modify_call((unsigned long)&ftrace_call,
> > -                                    (unsigned long)func, true, true);
> > -
> > -     return ret;
> > +     return __ftrace_modify_call_site(&ftrace_call_dest, func, true);
> >  }
> >
> >  struct ftrace_modify_param {
> > @@ -182,7 +206,7 @@ int ftrace_modify_call(struct dyn_ftrace *rec, unsi=
gned long old_addr,
> >       if (ret)
> >               return ret;
> >
> > -     return __ftrace_modify_call(caller, addr, true, false);
> > +     return __ftrace_modify_call(caller, addr, true);
> >  }
> >  #endif
> >
> > @@ -217,17 +241,17 @@ void ftrace_graph_func(unsigned long ip, unsigned=
 long parent_ip,
> >       prepare_ftrace_return(&fregs->ra, ip, fregs->s0);
> >  }
> >  #else /* CONFIG_DYNAMIC_FTRACE_WITH_ARGS */
> > -extern void ftrace_graph_call(void);
> > +ftrace_func_t ftrace_graph_call_dest =3D ftrace_stub;
> >  int ftrace_enable_ftrace_graph_caller(void)
> >  {
> > -     return __ftrace_modify_call((unsigned long)&ftrace_graph_call,
> > -                                 (unsigned long)&prepare_ftrace_return=
, true, true);
> > +     return __ftrace_modify_call_site(&ftrace_graph_call_dest,
> > +                                      &prepare_ftrace_return, true);
> >  }
> >
> >  int ftrace_disable_ftrace_graph_caller(void)
> >  {
> > -     return __ftrace_modify_call((unsigned long)&ftrace_graph_call,
> > -                                 (unsigned long)&prepare_ftrace_return=
, false, true);
> > +     return __ftrace_modify_call_site(&ftrace_graph_call_dest,
> > +                                      &prepare_ftrace_return, false);
> >  }
> >  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_ARGS */
> >  #endif /* CONFIG_DYNAMIC_FTRACE */
> > diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-=
dyn.S
> > index e988bd26b28b..bc06e8ab81cf 100644
> > --- a/arch/riscv/kernel/mcount-dyn.S
> > +++ b/arch/riscv/kernel/mcount-dyn.S
> > @@ -162,7 +162,8 @@ SYM_FUNC_START(ftrace_caller)
> >       mv      a3, sp
> >
> >  SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
> > -     call    ftrace_stub
> > +     REG_L   ra, ftrace_call_dest
> > +     jalr    0(ra)

I would write these as  "jalr    ra,0(ra)", as it may not be obvious.

Nice improvement, thanks!

/Robbin

> >
> >  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
> >       addi    a0, sp, ABI_RA
> > @@ -172,7 +173,8 @@ SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
> >       mv      a2, s0
> >  #endif
> >  SYM_INNER_LABEL(ftrace_graph_call, SYM_L_GLOBAL)
> > -     call    ftrace_stub
> > +     REG_L   ra, ftrace_graph_call_dest
> > +     jalr    0(ra)
> >  #endif
> >       RESTORE_ABI
> >       jr      t0
> > @@ -185,7 +187,8 @@ SYM_FUNC_START(ftrace_caller)
> >       PREPARE_ARGS
> >
> >  SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
>
> Not used, please remove.
>
> > -     call    ftrace_stub
> > +     REG_L   ra, ftrace_call_dest
> > +     jalr    0(ra)
> >
> >       RESTORE_ABI_REGS
> >       bnez    t1, .Ldirect
> > --
> > 2.39.3 (Apple Git-145)
>
>
>
> Bj=C3=B6rn

