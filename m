Return-Path: <linux-kernel+bounces-444976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C0F9F0F71
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16C871882195
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0131E1A35;
	Fri, 13 Dec 2024 14:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lXV2bbiZ"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4731DEFC1
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101126; cv=none; b=abduFGSR5WV/GTs45BTuKqpI1D1NzV3J35f88X4wdclXMKtWHZIdaKf6tk6QiRt1Z+5gF9Lczd4pmGtEfD5ycv7OGRRgAFeKZYxp1A3XH862lWSDxjDFx6UX0Ir2wLBaH/okheQKvCCZgqLOBaJqT9fxCkECBCVVhouoaov2I5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101126; c=relaxed/simple;
	bh=wsjq53tN9X3E2vd6ChcRBXvCUBErMqkOdMcwSBo+Qa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gI5ZpgKEqLW6hM83MM0q4ki1ybHPMMi6QYp1vgfJgCQRGmRjlIf8CBZz/byBVCnL3PpJDLMyybBH03kbtpyzQzgeUXRGJ7kQ9UlTapzuK4iCS4hooGLUR28kQ02FfeOKXYkYu/nP1iLf4vRPpUmuLPzvQy28Iat7iuwP6BpLB0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lXV2bbiZ; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4678c9310afso213561cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 06:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734101124; x=1734705924; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S0WatgwCXgaiexp3EUWavIB0qKEFBmaEgS2C+Zdx+jU=;
        b=lXV2bbiZ+P//ul3TheZ9vwgQ9CqFZA6G6XEpvTfo/223BTwnzWv/IxSc5ZwHfutyyQ
         s6rxYsoHA/tAhxldYpujt1sRVLr9QjA8EkNB7dKv9Qczs99IzCCU3PAiC88Gb60BegSc
         a2AiAteYQ9tShT7fHqQyEBXclqaYrazL+qiUnXJ+Gno77I6G7w3/NpeddAoF/Fq14lI6
         zJa37dwURA7FLMDIGHTPIjYahOx72kqGbxnOWPsJpwN9Qez/mypabyVgwqbJzVma0EAW
         e5LKAUgdLfuJg+Ka7BLX9GrKydA2gyoYUxHP+UUrt11YtWOB8W3Wr52CpomPHjSblquu
         nAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734101124; x=1734705924;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S0WatgwCXgaiexp3EUWavIB0qKEFBmaEgS2C+Zdx+jU=;
        b=pHWfgW5YmGmTDJULoctCWDNICprsgc3sNic4H/QmA/MvkifN/qD+wtPF6xe4zs06u5
         +6647uiIjuj/y0/ERMowzbSTJ0WMOH/OY9O9GsLhjuhDJM6I528aBMoV9tmjIH5OiPGi
         LXtfekOY8NY3551+CpdFimrDqwiRQymaN2KdFVgdh+M5NG7HvPYR3ct/xjRBjSYpy/o6
         ZgTCufKUe7gBsNjj3CX3OaLLdOw0nWj+QfgECgKhV83j/ktMX0/aN2VKNktrxUWyhMcV
         ibQk9Dz6o7YbmpIXlYOgPtkmlQPuY4Ur6417F0kphmJ5QGhk0MlRASkG9e2wKFcvcC/6
         ja3A==
X-Forwarded-Encrypted: i=1; AJvYcCXP/DxnlbTCB5xkfOZhi0fr0fkJO8CAWkevd5bRC3GcgiqGqBlretZG81clHArEJ0sDHZiCg6UOn5hpaEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsk7yzSpfFF3eChUlqErDKrsdN5BSJaSj34m8h7wBmjRP3SCf2
	khF27e51qEFEyrneTiluth+MRgCxZPx5xphMXttF3iFP0kLn0TVzQqrlzZAyxdnsarO+Z0uurhH
	uf17ICtFZCxcFMpsf9W2UtmOS0Ew29pweUe4q
X-Gm-Gg: ASbGncvtWgM2Wc2neDTiFDFxmbp3bV1c6HpYY5zkVXkeUNDblE75s+W6kZeG9E4SUra
	pZIXMnFmnSUmrblnCuX2oNHXh343/BfUfNxKMr/s0vDHfE6aJg0eOqhXn3c6YuL3BAGhq
X-Google-Smtp-Source: AGHT+IEulUNhWHEGdVnNmWeLRkX9kVqow/MtXl0sKlndp32zeoeYmhYBDZQU3OnF3mEh0MhlawQpXGzdXkpWw1k/Cvc=
X-Received: by 2002:a05:622a:4d43:b0:466:8618:90df with SMTP id
 d75a77b69052e-467a40f3bf2mr4195931cf.2.1734101124142; Fri, 13 Dec 2024
 06:45:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712-asi-rfc-24-v1-0-144b319a40d8@google.com>
 <20240712-asi-rfc-24-v1-1-144b319a40d8@google.com> <20241025113455.GMZxuCX2Tzu8ulwN3o@fat_crate.local>
 <CA+i-1C3SZ4FEPJyvbrDfE-0nQtB_8L_H_i67dQb5yQ2t8KJF9Q@mail.gmail.com>
 <ab8ef5ef-f51c-4940-9094-28fbaa926d37@google.com> <878qu6205g.ffs@tglx>
 <d0a38982-b811-4429-8b89-81e5da3aaf72@google.com> <87cyjevgx4.ffs@tglx>
In-Reply-To: <87cyjevgx4.ffs@tglx>
From: Brendan Jackman <jackmanb@google.com>
Date: Fri, 13 Dec 2024 15:45:13 +0100
X-Gm-Features: AbW1kvYeFSt9oq4jpITmiWkujPAqQ3h82SGc6hTAa_TaGY28cvqrpIH9-qf3xtU
Message-ID: <CA+i-1C1z35M8wA_4AwMq7--c1OgjNoLGTkn4+Td5gKg7QQAzWw@mail.gmail.com>
Subject: Re: [PATCH 01/26] mm: asi: Make some utility functions noinstr compatible
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Junaid Shahid <junaids@google.com>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Alexandre Chartre <alexandre.chartre@oracle.com>, Liran Alon <liran.alon@oracle.com>, 
	Jan Setje-Eilers <jan.setjeeilers@oracle.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Michal Hocko <mhocko@kernel.org>, Khalid Aziz <khalid.aziz@oracle.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Valentin Schneider <vschneid@redhat.com>, Paul Turner <pjt@google.com>, Reiji Watanabe <reijiw@google.com>, 
	Ofir Weisse <oweisse@google.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Patrick Bellasi <derkling@google.com>, KP Singh <kpsingh@google.com>, 
	Alexandra Sandulescu <aesa@google.com>, Matteo Rizzo <matteorizzo@google.com>, Jann Horn <jannh@google.com>, 
	x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kvm@vger.kernel.org, linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Nov 2024 at 21:27, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Thu, Oct 31 2024 at 18:44, Junaid Shahid wrote:
> What actually works by some definition of "works" is:
>
>        static __always_inline void __foo(void) { }
>
>        static inline void foo(void)
>        {
>                 __(foo);
>        }
>
>        static inline noinstr void foo_noinstr(void)
>        {
>                 __(foo);
>        }
>
> The problem is that both GCC and clang optimize foo[_noinstr]() away and
> then follow the __always_inline directive of __foo() even if I make
> __foo() insanely large and have a gazillion of different functions
> marked noinline invoking foo() or foo_noinstr(), unless I add -fno-inline
> to the command line.

In this experiment did you modify the definition of noinstr to remove
noinline? Otherwise I always get out-of-line calls (as you'd expect
from the noinline).

> Which means it's not much different from just having '__always_inline
> foo()' without the wrappers....
>
> Compilers clearly lack a --do-what-I-mean command line option.
>
> Now if I'm truly nasty then both compilers do what I mean even without a
> magic command line option:
>
>        static __always_inline void __foo(void) { }
>
>        static __maybe_unused void foo(void)
>        {
>                 __(foo);
>        }
>
>        static __maybe_unused noinstr void foo_noinstr(void)
>        {
>                 __(foo);
>        }

I don't see any difference with __maybe_unused: if the noinline is
there it's never inlined, otherwise with the wrapper technique it's
always inlined regardless of __maybe_unused:

static __always_inline void __big(void)
{
        asm volatile(
                "nop; nop; nop; nop; nop; nop; nop; nop; nop;"
                // and so on
                "nop; nop; nop; nop; nop; nop; nop; nop; nop;"
        );
}

static inline __section(".noinstr.text") void big_noinstr(void)
{
        __big();
}

When I call big_noinstr() from a noinstr function I see:

Dump of assembler code for function asi_exit:
   0xffffffff811e0080 <+0>:     endbr64
   0xffffffff811e0084 <+4>:     nop
   0xffffffff811e0085 <+5>:     nop
...and so on

I'm using GCC 14.2.0.

(I thought maybe this was because I used asm volatile nops to embiggen
the function but I see the same thing with a big stream of volatile C
statements).

I think we might have no choice but to always use
__always_inline/noinline for code that's called from both sections -
seems there's no way to tell the compiler "I don't care if you inline
it, but it we can't cross a section boundary". Am I missing anything?

