Return-Path: <linux-kernel+bounces-433800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 697019E5D33
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E429162704
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CB1227B90;
	Thu,  5 Dec 2024 17:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Zb0b/aJf"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B05225768
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 17:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733419986; cv=none; b=XFH+oFQymFpMexOu4jvPvy0IhV2YbXMeWDqinoMYTL+0UX78dsMh9+QEYEY2dOn2HNVNhX5selrAN5bOWpa69A58ufziuNRyjhx4glagaPCqrnPOpDvtwyQ1KwgdMebF/VaJ9/CHDzbYGwEsi7/Co4S+gdyBS93nxDRXJmsj88U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733419986; c=relaxed/simple;
	bh=pcGST3wm/InNaxoDiSpyDKCRoDBHLZsm4khTLb6UpZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rm0CSMx481BwXhGifCx8kqQu5JRFZFIsGZDEUKU0/G2v2M6/e6Yg+uHb2mxxHZShNV7TUmZjOYdjBJNUtLXrmReMoyPpM8M7+wOaWyiCXLlLvRhDqP9nbrOfXy+GL8V/F8Yaxjtd8n5LyBE5vrBlrxgu0X13VrEXSFjEuW7s0uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=Zb0b/aJf; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e399936829eso1238306276.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 09:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1733419983; x=1734024783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHD/7k8cmjWVExLtL6GEx4rcMk6Enmjj3aT0U29A/UU=;
        b=Zb0b/aJfgyU4Vd4NyNdKDqgW0z8cqpylhbSfwfq/2KSygsL5MlYYyeq2pRmhd6SZ+X
         Z/pGzRuSvcjCpmsz/VB1Wa+nem/nm4FSY0Xdf5PGi3+aO+8YkyyWrZkwiepU7MZCj6Be
         Td7bsVo0F4JDhk+H22ZOhvqbxHdgWtwWJuHIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733419983; x=1734024783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RHD/7k8cmjWVExLtL6GEx4rcMk6Enmjj3aT0U29A/UU=;
        b=O2ftY31yQeG8mkM23EgWJwusvL8PvpYckmHyeIgmpOQCXfBQnShwu+/MHhSsVu1sk/
         SNX1cCyLWhGtaDmiP5XY8d9fSE7+cusFuhOn/47e57PEIN5C/WRpRsqIJDjYHWLugCwH
         NQsNBqkqKhhsfELZifQl2FpkJbBwPWMSgOs99cXckHX9G2QaI2tm1cVln/JhEmr4IfCP
         qgXeB4lCkh7b+1jDwZzfi/NkcRNNID9dMiYQtWKr5KzncHMG0F6C+bsWPMUcpMPvtkWB
         0b8bGy+h0gUwCKrnFfTilCvj23IRfIVkwXHbnM56Lr/4w9JKjPscivRE3l1BbG/bQXLU
         jRbQ==
X-Gm-Message-State: AOJu0YxZZbV87xrroOucsvifaJwUhV34tDsO2fQJ2ANJP7Vl//nQNtUJ
	qkfyMjmqNWsIhcHzFBXtR/rXzbXmOMSzUHUcLaGkfyEbMJ0iYFIACf59Tz/o5/ncQzq2iFZ957v
	je5bj4sX9QMRbK7fKjeomPwlNiJH1rLgqIVAuO1/tnhbHjitJ
X-Gm-Gg: ASbGncsAlu0VW1RfbaM1W7eGJXfp2CEM+zV5r7Bxa9gGWApVkMofB8asXvvZJd5KucZ
	6ZTwbcv+dtmf8sCPSNKhE5T3KRGm9SA==
X-Google-Smtp-Source: AGHT+IGX43OOIUy2tottHo9JlyFncjagkF8gWruc0Hp1Zvk9yXPa1s+GJapFI6+pp7IGIZbq0dhsQxmf2vDUbe+/yrQ=
X-Received: by 2002:a05:6902:124e:b0:e39:a780:d104 with SMTP id
 3f1490d57ef6-e39d3e1a9e2mr11432171276.24.1733419983206; Thu, 05 Dec 2024
 09:33:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003181629.36209057@gandalf.local.home>
In-Reply-To: <20241003181629.36209057@gandalf.local.home>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Thu, 5 Dec 2024 12:32:52 -0500
Message-ID: <CAEXW_YQQGoXHQhwCu+m6z_O_0r=qj05KLqsQOF36sP-NP88JqQ@mail.gmail.com>
Subject: Re: [PATCH v2] tracing: Remove definition of trace_*_rcuidle()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 6:15=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> From: Steven Rostedt <rostedt@goodmis.org>
>
> The trace_*_rcuidle() variant of a tracepoint was to handle places where =
a
> tracepoint was located but RCU was not "watching". All those locations
> have been removed, and RCU should be watching where all tracepoints are
> located. We can now remove the trace_*_rcuidle() variant.
>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel



> ---
> Changes since v1: https://lore.kernel.org/20241003173051.6b178bb3@gandalf=
.local.home
>
> - Silly me didn't remove the rcuidle logic from __DO_TRACE()
>
>  include/linux/tracepoint.h        | 50 ++-----------------------------
>  include/trace/events/preemptirq.h |  8 -----
>  kernel/trace/trace_preemptirq.c   | 26 ++++------------
>  scripts/tags.sh                   |  2 --
>  4 files changed, 8 insertions(+), 78 deletions(-)
>
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 93a9f3070b48..9b85a02b8575 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -196,67 +196,25 @@ static inline struct tracepoint *tracepoint_ptr_der=
ef(tracepoint_ptr_t *p)
>  #define __DO_TRACE_CALL(name, args)    __traceiter_##name(NULL, args)
>  #endif /* CONFIG_HAVE_STATIC_CALL */
>
> -/*
> - * ARCH_WANTS_NO_INSTR archs are expected to have sanitized entry and id=
le
> - * code that disallow any/all tracing/instrumentation when RCU isn't wat=
ching.
> - */
> -#ifdef CONFIG_ARCH_WANTS_NO_INSTR
> -#define RCUIDLE_COND(rcuidle)  (rcuidle)
> -#else
> -/* srcu can't be used from NMI */
> -#define RCUIDLE_COND(rcuidle)  (rcuidle && in_nmi())
> -#endif
> -
>  /*
>   * it_func[0] is never NULL because there is at least one element in the=
 array
>   * when the array itself is non NULL.
>   */
> -#define __DO_TRACE(name, args, cond, rcuidle)                          \
> +#define __DO_TRACE(name, args, cond)                                   \
>         do {                                                            \
>                 int __maybe_unused __idx =3D 0;                          =
 \
>                                                                         \
>                 if (!(cond))                                            \
>                         return;                                         \
>                                                                         \
> -               if (WARN_ONCE(RCUIDLE_COND(rcuidle),                    \
> -                             "Bad RCU usage for tracepoint"))          \
> -                       return;                                         \
> -                                                                       \
>                 /* keep srcu and sched-rcu usage consistent */          \
>                 preempt_disable_notrace();                              \
>                                                                         \
> -               /*                                                      \
> -                * For rcuidle callers, use srcu since sched-rcu        \
> -                * doesn't work from the idle path.                     \
> -                */                                                     \
> -               if (rcuidle) {                                          \
> -                       __idx =3D srcu_read_lock_notrace(&tracepoint_srcu=
);\
> -                       ct_irq_enter_irqson();                          \
> -               }                                                       \
> -                                                                       \
>                 __DO_TRACE_CALL(name, TP_ARGS(args));                   \
>                                                                         \
> -               if (rcuidle) {                                          \
> -                       ct_irq_exit_irqson();                           \
> -                       srcu_read_unlock_notrace(&tracepoint_srcu, __idx)=
;\
> -               }                                                       \
> -                                                                       \
>                 preempt_enable_notrace();                               \
>         } while (0)
>
> -#ifndef MODULE
> -#define __DECLARE_TRACE_RCU(name, proto, args, cond)                   \
> -       static inline void trace_##name##_rcuidle(proto)                \
> -       {                                                               \
> -               if (static_key_false(&__tracepoint_##name.key))         \
> -                       __DO_TRACE(name,                                \
> -                               TP_ARGS(args),                          \
> -                               TP_CONDITION(cond), 1);                 \
> -       }
> -#else
> -#define __DECLARE_TRACE_RCU(name, proto, args, cond)
> -#endif
> -
>  /*
>   * Make sure the alignment of the structure in the __tracepoints section=
 will
>   * not add unwanted padding between the beginning of the section and the
> @@ -277,14 +235,12 @@ static inline struct tracepoint *tracepoint_ptr_der=
ef(tracepoint_ptr_t *p)
>                 if (static_key_false(&__tracepoint_##name.key))         \
>                         __DO_TRACE(name,                                \
>                                 TP_ARGS(args),                          \
> -                               TP_CONDITION(cond), 0);                 \
> +                               TP_CONDITION(cond));                    \
>                 if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {             \
>                         WARN_ONCE(!rcu_is_watching(),                   \
>                                   "RCU not watching for tracepoint");   \
>                 }                                                       \
>         }                                                               \
> -       __DECLARE_TRACE_RCU(name, PARAMS(proto), PARAMS(args),          \
> -                           PARAMS(cond))                               \
>         static inline int                                               \
>         register_trace_##name(void (*probe)(data_proto), void *data)    \
>         {                                                               \
> @@ -375,8 +331,6 @@ static inline struct tracepoint *tracepoint_ptr_deref=
(tracepoint_ptr_t *p)
>  #define __DECLARE_TRACE(name, proto, args, cond, data_proto)           \
>         static inline void trace_##name(proto)                          \
>         { }                                                             \
> -       static inline void trace_##name##_rcuidle(proto)                \
> -       { }                                                             \
>         static inline int                                               \
>         register_trace_##name(void (*probe)(data_proto),                \
>                               void *data)                               \
> diff --git a/include/trace/events/preemptirq.h b/include/trace/events/pre=
emptirq.h
> index 3f249e150c0c..f99562d2b496 100644
> --- a/include/trace/events/preemptirq.h
> +++ b/include/trace/events/preemptirq.h
> @@ -43,8 +43,6 @@ DEFINE_EVENT(preemptirq_template, irq_enable,
>  #else
>  #define trace_irq_enable(...)
>  #define trace_irq_disable(...)
> -#define trace_irq_enable_rcuidle(...)
> -#define trace_irq_disable_rcuidle(...)
>  #endif
>
>  #ifdef CONFIG_TRACE_PREEMPT_TOGGLE
> @@ -58,8 +56,6 @@ DEFINE_EVENT(preemptirq_template, preempt_enable,
>  #else
>  #define trace_preempt_enable(...)
>  #define trace_preempt_disable(...)
> -#define trace_preempt_enable_rcuidle(...)
> -#define trace_preempt_disable_rcuidle(...)
>  #endif
>
>  #endif /* _TRACE_PREEMPTIRQ_H */
> @@ -69,10 +65,6 @@ DEFINE_EVENT(preemptirq_template, preempt_enable,
>  #else /* !CONFIG_PREEMPTIRQ_TRACEPOINTS */
>  #define trace_irq_enable(...)
>  #define trace_irq_disable(...)
> -#define trace_irq_enable_rcuidle(...)
> -#define trace_irq_disable_rcuidle(...)
>  #define trace_preempt_enable(...)
>  #define trace_preempt_disable(...)
> -#define trace_preempt_enable_rcuidle(...)
> -#define trace_preempt_disable_rcuidle(...)
>  #endif
> diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preempt=
irq.c
> index e37446f7916e..5c03633316a6 100644
> --- a/kernel/trace/trace_preemptirq.c
> +++ b/kernel/trace/trace_preemptirq.c
> @@ -15,20 +15,6 @@
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/preemptirq.h>
>
> -/*
> - * Use regular trace points on architectures that implement noinstr
> - * tooling: these calls will only happen with RCU enabled, which can
> - * use a regular tracepoint.
> - *
> - * On older architectures, use the rcuidle tracing methods (which
> - * aren't NMI-safe - so exclude NMI contexts):
> - */
> -#ifdef CONFIG_ARCH_WANTS_NO_INSTR
> -#define trace(point)   trace_##point
> -#else
> -#define trace(point)   if (!in_nmi()) trace_##point##_rcuidle
> -#endif
> -
>  #ifdef CONFIG_TRACE_IRQFLAGS
>  /* Per-cpu variable to prevent redundant calls when IRQs already off */
>  static DEFINE_PER_CPU(int, tracing_irq_cpu);
> @@ -42,7 +28,7 @@ static DEFINE_PER_CPU(int, tracing_irq_cpu);
>  void trace_hardirqs_on_prepare(void)
>  {
>         if (this_cpu_read(tracing_irq_cpu)) {
> -               trace(irq_enable)(CALLER_ADDR0, CALLER_ADDR1);
> +               trace_irq_enable(CALLER_ADDR0, CALLER_ADDR1);
>                 tracer_hardirqs_on(CALLER_ADDR0, CALLER_ADDR1);
>                 this_cpu_write(tracing_irq_cpu, 0);
>         }
> @@ -53,7 +39,7 @@ NOKPROBE_SYMBOL(trace_hardirqs_on_prepare);
>  void trace_hardirqs_on(void)
>  {
>         if (this_cpu_read(tracing_irq_cpu)) {
> -               trace(irq_enable)(CALLER_ADDR0, CALLER_ADDR1);
> +               trace_irq_enable(CALLER_ADDR0, CALLER_ADDR1);
>                 tracer_hardirqs_on(CALLER_ADDR0, CALLER_ADDR1);
>                 this_cpu_write(tracing_irq_cpu, 0);
>         }
> @@ -75,7 +61,7 @@ void trace_hardirqs_off_finish(void)
>         if (!this_cpu_read(tracing_irq_cpu)) {
>                 this_cpu_write(tracing_irq_cpu, 1);
>                 tracer_hardirqs_off(CALLER_ADDR0, CALLER_ADDR1);
> -               trace(irq_disable)(CALLER_ADDR0, CALLER_ADDR1);
> +               trace_irq_disable(CALLER_ADDR0, CALLER_ADDR1);
>         }
>
>  }
> @@ -89,7 +75,7 @@ void trace_hardirqs_off(void)
>         if (!this_cpu_read(tracing_irq_cpu)) {
>                 this_cpu_write(tracing_irq_cpu, 1);
>                 tracer_hardirqs_off(CALLER_ADDR0, CALLER_ADDR1);
> -               trace(irq_disable)(CALLER_ADDR0, CALLER_ADDR1);
> +               trace_irq_disable(CALLER_ADDR0, CALLER_ADDR1);
>         }
>  }
>  EXPORT_SYMBOL(trace_hardirqs_off);
> @@ -100,13 +86,13 @@ NOKPROBE_SYMBOL(trace_hardirqs_off);
>
>  void trace_preempt_on(unsigned long a0, unsigned long a1)
>  {
> -       trace(preempt_enable)(a0, a1);
> +       trace_preempt_enable(a0, a1);
>         tracer_preempt_on(a0, a1);
>  }
>
>  void trace_preempt_off(unsigned long a0, unsigned long a1)
>  {
> -       trace(preempt_disable)(a0, a1);
> +       trace_preempt_disable(a0, a1);
>         tracer_preempt_off(a0, a1);
>  }
>  #endif
> diff --git a/scripts/tags.sh b/scripts/tags.sh
> index 191e0461d6d5..0d01c1cafb70 100755
> --- a/scripts/tags.sh
> +++ b/scripts/tags.sh
> @@ -152,9 +152,7 @@ regex_c=3D(
>         '/^BPF_CALL_[0-9]([[:space:]]*\([[:alnum:]_]*\).*/\1/'
>         '/^COMPAT_SYSCALL_DEFINE[0-9]([[:space:]]*\([[:alnum:]_]*\).*/com=
pat_sys_\1/'
>         '/^TRACE_EVENT([[:space:]]*\([[:alnum:]_]*\).*/trace_\1/'
> -       '/^TRACE_EVENT([[:space:]]*\([[:alnum:]_]*\).*/trace_\1_rcuidle/'
>         '/^DEFINE_EVENT([^,)]*,[[:space:]]*\([[:alnum:]_]*\).*/trace_\1/'
> -       '/^DEFINE_EVENT([^,)]*,[[:space:]]*\([[:alnum:]_]*\).*/trace_\1_r=
cuidle/'
>         '/^DEFINE_INSN_CACHE_OPS([[:space:]]*\([[:alnum:]_]*\).*/get_\1_s=
lot/'
>         '/^DEFINE_INSN_CACHE_OPS([[:space:]]*\([[:alnum:]_]*\).*/free_\1_=
slot/'
>         '/^PAGEFLAG([[:space:]]*\([[:alnum:]_]*\).*/Page\1/'
> --
> 2.45.2
>

