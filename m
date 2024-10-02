Return-Path: <linux-kernel+bounces-347990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 420BD98E12D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65A981C234E7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594061D0E3E;
	Wed,  2 Oct 2024 16:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAoMhmVK"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291BF1D0B8B
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 16:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727887739; cv=none; b=XZ49nedfu8W852a0+6Crys+lBUT91z33PzyoYfFEnJHPRHhLcAd+PnFQuydqEfcf+hkm/Bf4W+Oj3avihKsFB0AWN1H+3V9+lMnblzrCdXWvnvfu64kLfH1oOn5uwB9lHO7V5wDIUjgt9WPMAOYUQ3imFPKoJ8s6bMFpPOJYAjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727887739; c=relaxed/simple;
	bh=TUlw2C1UjnagJ1WBkxSmvCk6IQMDp07mX4oyaSPK+9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=owhQ+Pn48MNb1KTaTTpmnwtIKfyWym60g0vuDIrUQ3dkTvOj+SUynt27FG1ziTPKfYMfSWRysOWjIdKQ35/slz5TdO4z7Nqo9iqxtoSKwAlfIrMFRaG13PzhLQ1NEL4ylbsr0D8fzkfpc4Sq6iJAxwwpYUcmbRvuXVga2HM5lI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAoMhmVK; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42ca4e0299eso57490885e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 09:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727887736; x=1728492536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ZGVQtbaA/8ykkF7JsMAdMByPT8rWZi2JY97j4o0j7M=;
        b=FAoMhmVKW8lFkfewY4j7xu5btej83+b/wY6OOYHDmvLRnwp20+nm1EZQSsfs7D/oa3
         iQ6p+8hBPhbUO5cQF1YiQ49tvxg5yPuuj3CjuyX+Xk/vNn6qvPaxEhn6fZNv/O7X93E5
         CIPyeLayFI279JwBFMWxD3Dkq1wcY6kCskk2hwScp1WI2S96QK3W1OxtBpApG0cnlUIY
         cXU0AkO+LtxI4Oi/Gfitggyhn413bj3JNoZRNoz2+wjV9ux6178NPftKSJztXKamslPv
         eLInv6+D0bdjjxI0XZ29QVlAB+2aCvEyIbiPSGR2k8blP9ejiVw3K0bm8FSa3u4uM5SF
         EgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727887736; x=1728492536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ZGVQtbaA/8ykkF7JsMAdMByPT8rWZi2JY97j4o0j7M=;
        b=VAnAiooJ9/6Yfp1MADoO313dFi1t7PDT09D1MkKS6kexv7jbSJ6VXhjW5pgMjIOLa7
         2qIPZtsnthE0TyGGTtX4zs81s+BUQZUI6aDg+FxTBgfIrJVWZie2mcs1hMoZrW6yRw8H
         S0LBeaW2NelKeZbEKS9riNSOn38ZyOa58RpuBVTJ7dHKw6jP6iT/jVspgVM2T88jx3H3
         +Czoh2ddukCyF7S7eAoUsGLzJAU1u55v8dl0Piqi9VM1UtVUR6Atu4sgfKec43s4gxpv
         l2xUwUsFTl5bc2+0EG3p1BOz5p+Vuh48hK94nY9JbY6bVssA4gHioY8JnwzJMfhFiLfw
         CfgA==
X-Forwarded-Encrypted: i=1; AJvYcCV04o+WJZPHui4uXEsRspbN78rgOGMUqWNKeV5QNKZuiIEpGmywgagXL8OWImwrvhxhpdt48v83pThuZP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEf3BPMjkLLbMDTMft/gHXgfHmjWbf5br2tKug+pbn9tFdE8nP
	sUosgsEGOwhzDF83CPCEMTm7f1qyJM6dhvDmm/vjIa9UdL/LNfNCdQ4xPzDOWNYvA1wMEUjSdNd
	9wzzD93rfmszjELpBvo0tiUcq1WUF5y0b
X-Google-Smtp-Source: AGHT+IE3B5LIKyo81LPaNkq3q+4h8v0zQ1n8tUHJRYDzk68ajkI3CLDqGo2ZzF6BUfiu/CNl/OOQomo1i3PTIyolwAE=
X-Received: by 2002:a05:600c:1c04:b0:42b:a88f:f872 with SMTP id
 5b1f17b1804b1-42f778f13d3mr29026945e9.32.1727887736056; Wed, 02 Oct 2024
 09:48:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927194856.096003183@infradead.org> <20240927194925.498161564@infradead.org>
 <CAADnVQKQED2pit_DcpDWPuueHH3RLXe4pB++tU888EU=8UrNpA@mail.gmail.com>
 <20240930082726.GF5594@noisy.programming.kicks-ass.net> <CAADnVQK8s4N_W_BH5zPZ7V-NW9FRegK27Nk-67UqiJzCxrdtxQ@mail.gmail.com>
 <20241001102120.GL5594@noisy.programming.kicks-ass.net>
In-Reply-To: <20241001102120.GL5594@noisy.programming.kicks-ass.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 2 Oct 2024 09:48:44 -0700
Message-ID: <CAADnVQJ3ZAZEMuBJs_3qMjU4dFy-NYr_bm0T9k7oqpwwVjZoBg@mail.gmail.com>
Subject: Re: [PATCH 11/14] llvm: kCFI pointer stuff
To: Peter Zijlstra <peterz@infradead.org>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	alyssa.milburn@intel.com, scott.d.constable@intel.com, 
	Joao Moreira <joao@overdrivepizza.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, "Jose E. Marchesi" <jose.marchesi@oracle.com>, 
	"H.J. Lu" <hjl.tools@gmail.com>, Nick Desaulniers <ndesaulniers@google.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Nathan Chancellor <nathan@kernel.org>, ojeda@kernel.org, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 3:21=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
>
> Does something like this help?

Yep. Thanks.

> diff --git a/arch/x86/include/asm/cfi.h b/arch/x86/include/asm/cfi.h
> index 31d19c815f99..b6e7e79e79c6 100644
> --- a/arch/x86/include/asm/cfi.h
> +++ b/arch/x86/include/asm/cfi.h
> @@ -44,11 +44,28 @@
>   *   call *%r11
>   *
>   *
> + * IBT+:
> + *
> + * foo:
> + *   endbr64 / ud1 0(%eax), %edx
> + *   ... code here ...
> + *   ret
> + *
> + * direct caller:
> + *   call foo+4
> + *
> + * indirect caller:
> + *   lea foo(%rip), %r11
> + *   ...
> + *   call *%r11
> + *
> + *
>   * kCFI:
>   *
>   * __cfi_foo:
>   *   movl $0x12345678, %eax    # kCFI signature hash
> - *                             # 11 nops when CONFIG_CALL_PADDING
> + *   movb $0x12, %al           # kCFI pointer argument mask
> + *                             # 9 nops when CONFIG_CALL_PADDING
>   * foo:
>   *   endbr64                   # when IBT
>   *   ... code here ...
> @@ -91,6 +108,57 @@
>   *   nop4
>   *   call *%r11
>   *
> + *
> + * FineIBT+:
> + *
> + * __cfi_foo:
> + *   endbr64
> + *   subl 0x12345678, %r10d
> + *   jz   foo

should it be 'jz foo_4' ?
Otherwise it will trap after endbr64 sealing.

> + *   ud2
> + *   nop
> + * foo:
> + *   ud1 0(%eax), %edx         # was endbr64
> + * foo_4:
> + *   ... code here ...
> + *   ret
> + *
> + * direct caller:
> + *   call foo+4
> + *
> + * indirect caller:
> + *   lea foo(%rip), %r11
> + *   ...
> + *   movl $0x12345678, %r10d
> + *   subl $16, %r11
> + *   nop4
> + *   call *%r11
> + *
> + *
> + * FineIBT-BHI:
> + *
> + * __cfi_foo:
> + *   endbr64
> + *   subl 0x12345678, %r10d
> + *   jz   foo-1
> + *   ud2
> + * foo-1:
> + *   call __bhi_args_XXX       # depends on kCFI pointer argument mask
> + * foo+4:
> + *   ... code here ...
> + *   ret
> + *
> + * direct caller:
> + *   call foo+4
> + *
> + * indirect caller:
> + *   lea foo(%rip), %r11
> + *   ...
> + *   movl $0x12345678, %r10d
> + *   subl $16, %r11
> + *   nop4
> + *   call *%r11
> + *
>   */
>  enum cfi_mode {
>         CFI_AUTO,       /* FineIBT if hardware has IBT, otherwise kCFI */
>
>
>
>
> > I wonder whether this whole complexity is worth it vs
> > always calling __bhi_args_all()
>
> That's one for Scott to answer; I think always doing _all will hurt
> especially bad because it includes rsp.

But why cmovne %rsp ?
Because some pointers are passed on the stack ?
but %rsp itself isn't involved in speculation.
load/store from stack can still speculate regardless of cmovne %rsp ?
Or is it acting like a barrier for all subsequent access from stack
including things like 'push rbp' in the function prologue?

Overall it feels like a lot of complexity for a 'security checkbox'.
If it hurts perf so much regardless the extra % here and there will
be ignored by security obsessed people and folks who care about
performance won't be enabling it anyway.

btw the alternative to hacking compilers is to get information
about pointers in function arguments from BTF.
It's all there. No need to encode it via movb $0x12, %al.

$ bpftool btf dump file vmlinux format c|grep pick_next_task
    struct task_struct * (*pick_next_task)(struct rq *, struct task_struct =
*);

