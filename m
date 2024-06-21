Return-Path: <linux-kernel+bounces-224718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7275C912604
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91CE31C256A8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 12:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A26153BDE;
	Fri, 21 Jun 2024 12:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dTwxAVVv"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C79915383B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 12:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718974347; cv=none; b=U4tHW1ryw5ObQ0DbjNPKD99KXIXOtv4k3HQSQJBhbJO7cDwQkt8HnSMb94hc7rHRiGiuaEPse/WQXGk7mWndRdtDKC4A5nUv94jguGlZq670Q57WrsI3jlv/CBbgmbIzGFQJDn2Brc6VrXzPTb5jB/M7EJXAJgmDWsguGANyqs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718974347; c=relaxed/simple;
	bh=9ExI3HMc8dpikZS14KdMf2VTfo2Gm4D9Du3Ad8hswa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iTVnU3sDkTykUd7Oxq3NGXt6Yk3C5/SCnRr+zf3lq/zET3LBp1WCmfvA6vrZP7QC6by+xzfkh96SZfqAGv+cBdONPxCWXt4KM5kGwQIbiqtorEa2blrc++pw/P0JE3Mya6MIW+lz7NusrJ6C5dNYB96ZgO0Nkr+kgkQsQUgmcw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dTwxAVVv; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7046211e455so1369033b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 05:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718974345; x=1719579145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFikssrTKZjRo9rjV6X1YnKRcFeJcrLtumLLhBthri8=;
        b=dTwxAVVvG50novP6VF9UJ4zxxi3/kn2Qm/RuCRSGH6hF9+fGk4+lxd8Ts1FqPzm3dc
         TNLnGhqmv7uchPdWDS+dM1lZLxaOCbBdW6WgnygnPxblfrgdo5IChA51HTkI12IQG/is
         0h2Gqx5pNlccTuls0xwhHYtRZVbuRRItSow1ThOoQrT3C0jLepMAzKHEOwuLpgAtX3uk
         5crDRly5mSLFxUu1smW6B66qa7qBAyp4f+iJozeZdpCj8VSXKe6egAOQni4qEPPAveLq
         ZvGVrcaVu9Y7Vc8vCW22gO7E3O8DFODHFhyvtY/CjokQF9o4iBjPzsBf29maRwj6MZcy
         dv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718974345; x=1719579145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jFikssrTKZjRo9rjV6X1YnKRcFeJcrLtumLLhBthri8=;
        b=rnoqd7i34Bp3r/Fkr3WNjYu8iT1ATupNXD9k5QjDil6cYkkHu12pgbH95u4n+bpvoR
         LjhnBvcRi+2LJ2uowHEKuYhN7IwtJd80avAPuynLScCevx/ljlvH7mS0zAoAf7LCtfWo
         6iHOqPyVt60JAlyF8X/2eLPONUEleNcz1ta3fYMjiXg6WYZmmbSEYqAviqAbdDoAHIfj
         8T5O5yrHuPpmXkVRByvbRdYvpdOJoqc/g6723IKHzkLOX8YP8F+BSAjdexIM9XM6hamO
         /vH7MFKX8flWy3XYXTjVxnCq+xK45eLJOEg4x1sLIBXH9fmuOKVVvdVYJKidh9HVASek
         QbQw==
X-Forwarded-Encrypted: i=1; AJvYcCV9mhwaPENiUakNrDFNrxltqbqExhwGBc1yG/w1fpxLUa3dGDXaxZMwfp3y3+EoJe9O0T9XvMr1m8lxkEu60J+bGaGgakK2olCqpbve
X-Gm-Message-State: AOJu0YzSLyTqITUFtiPmf0o1J1TN/2yRZOblnlzzc8HWJ2Hu7jH27sQl
	bUC8i+xOfjo0pE7g9XrrrBKo6pNitcZt9dYFgx6b6szjY1gLABktx4DynJRc+qe/LaNF8hj+Qr2
	VJoto6MERfDdLXe5tMAdyQpoqPywz5dsqXQzL
X-Google-Smtp-Source: AGHT+IHLbxh5gnZYE3Ij3eJIOL1ReH1iHe0C7faIKhDLxkg3+UYsqYWbYf6Q8dpYIbAjVW26QeLxKyYtHQr3AWRtJa0=
X-Received: by 2002:a05:6a20:7283:b0:1af:bd03:3222 with SMTP id
 adf61e73a8af0-1bcbb5f75cbmr9905522637.45.1718974345162; Fri, 21 Jun 2024
 05:52:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621-tracepoint-v3-0-9e44eeea2b85@google.com> <20240621-tracepoint-v3-2-9e44eeea2b85@google.com>
In-Reply-To: <20240621-tracepoint-v3-2-9e44eeea2b85@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 21 Jun 2024 14:52:10 +0200
Message-ID: <CAH5fLghb6oVkgy3ckf=dUk9S4VdCeWin+yDBW1ffBoxu=HqBKw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] rust: add tracepoint support
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>
Cc: linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 12:35=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> Make it possible to have Rust code call into tracepoints defined by C
> code. It is still required that the tracepoint is declared in a C
> header, and that this header is included in the input to bindgen.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  include/linux/tracepoint.h      | 18 +++++++++++++++-
>  include/trace/define_trace.h    |  7 ++++++
>  rust/bindings/bindings_helper.h |  1 +
>  rust/kernel/lib.rs              |  1 +
>  rust/kernel/tracepoint.rs       | 47 +++++++++++++++++++++++++++++++++++=
++++++
>  5 files changed, 73 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 689b6d71590e..d82af4d77c9f 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -238,6 +238,20 @@ static inline struct tracepoint *tracepoint_ptr_dere=
f(tracepoint_ptr_t *p)
>  #define __DECLARE_TRACE_RCU(name, proto, args, cond)
>  #endif
>
> +/*
> + * Declare an exported function that Rust code can call to trigger this
> + * tracepoint. This function does not include the static branch; that is=
 done
> + * in Rust to avoid a function call when the tracepoint is disabled.
> + */
> +#define DEFINE_RUST_DO_TRACE(name, proto, args)
> +#define DEFINE_RUST_DO_TRACE_REAL(name, proto, args)                   \
> +       notrace void rust_do_trace_##name(proto)                        \
> +       {                                                               \
> +               __DO_TRACE(name,                                        \
> +                       TP_ARGS(args),                                  \
> +                       cpu_online(raw_smp_processor_id()), 0);         \
> +       }
> +
>  /*
>   * Make sure the alignment of the structure in the __tracepoints section=
 will
>   * not add unwanted padding between the beginning of the section and the
> @@ -253,6 +267,7 @@ static inline struct tracepoint *tracepoint_ptr_deref=
(tracepoint_ptr_t *p)
>         extern int __traceiter_##name(data_proto);                      \
>         DECLARE_STATIC_CALL(tp_func_##name, __traceiter_##name);        \
>         extern struct tracepoint __tracepoint_##name;                   \
> +       extern void rust_do_trace_##name(proto);                        \
>         static inline void trace_##name(proto)                          \
>         {                                                               \
>                 if (static_key_false(&__tracepoint_##name.key))         \
> @@ -337,7 +352,8 @@ static inline struct tracepoint *tracepoint_ptr_deref=
(tracepoint_ptr_t *p)
>         void __probestub_##_name(void *__data, proto)                   \
>         {                                                               \
>         }                                                               \
> -       DEFINE_STATIC_CALL(tp_func_##_name, __traceiter_##_name);
> +       DEFINE_STATIC_CALL(tp_func_##_name, __traceiter_##_name);       \
> +       DEFINE_RUST_DO_TRACE(_name, TP_PROTO(proto), TP_ARGS(args))
>
>  #define DEFINE_TRACE(name, proto, args)                \
>         DEFINE_TRACE_FN(name, NULL, NULL, PARAMS(proto), PARAMS(args));
> diff --git a/include/trace/define_trace.h b/include/trace/define_trace.h
> index 00723935dcc7..b47cc036acba 100644
> --- a/include/trace/define_trace.h
> +++ b/include/trace/define_trace.h
> @@ -72,6 +72,13 @@
>  #define DECLARE_TRACE(name, proto, args)       \
>         DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
>
> +/* If requested, create helpers for calling these tracepoints from Rust.=
 */
> +#ifdef CREATE_RUST_TRACE_POINTS
> +#undef DEFINE_RUST_DO_TRACE
> +#define DEFINE_RUST_DO_TRACE(name, proto, args)        \
> +       DEFINE_RUST_DO_TRACE_REAL(name, PARAMS(proto), PARAMS(args))
> +#endif
> +
>  #undef TRACE_INCLUDE
>  #undef __TRACE_INCLUDE
>
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h

Hmm, I tried using the support where I have both events and hooks:

#define CREATE_TRACE_POINTS
#define CREATE_RUST_TRACE_POINTS
#include <trace/hooks/rust_binder.h>
#include <trace/events/rust_binder.h>

But it's not really working. Initially I thought that it's because I
need to undef DEFINE_RUST_DO_TRACE at the end of this file, but even
when I added that, I still get this error:

    error: redefinition of 'str__rust_binder__trace_system_name'

Is the Rust support missing something, or is the answer just that you
can't have two files of the same name like this? Or am I doing
something else wrong?

Alice

