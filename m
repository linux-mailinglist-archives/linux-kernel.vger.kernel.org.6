Return-Path: <linux-kernel+bounces-512836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E952A33E44
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19B623A5C85
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F862147F7;
	Thu, 13 Feb 2025 11:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d57BgG1V"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A76F20B1E0
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739446888; cv=none; b=oZiNKxjaZnYnJCUEb+Mu6FmVcPVj85sOPjEARhsoLb0NxkxJUhG2NvtoZIsJUo6RHfeOz6Fvw9tzhlMsTkdJ7IkEd72wMqV1mq/d0JB72grvI+haGX+cUpenNavJOBSgFwmtW1OwsGAzItPzs/jtpV6ZZ82wzVnGpWHVKtcFfIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739446888; c=relaxed/simple;
	bh=AAST4Rrgx14tFe6TIsKMjVEfORXUknDgZqdYADcgjOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zhw5scwYrhHQzLi7O3EUCzgavR0JwpCjtS32dkv00Z39dXtP3E/bmuhCmcZ1gln4q7o/a0u35G4IGmXMa/XJF0oa3/kATMKXiyOMuH0kF2ErK4Oured0tAyFkp+Yo+394xtnDaSQbUjbsjud4AdUfYUbbOEa6CAYDCh3PVc/+8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d57BgG1V; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220e0575f5bso47285ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 03:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739446885; x=1740051685; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vcTbBDmPuXAkneoxzG7APyhlttHMdDVjsF9iXGMU9/s=;
        b=d57BgG1VSpC2KW+acgeQc2LtJ/ZIg+Z4J7dX2Zz7SvhbQGVAnL1NCD9zexWUL9lOUp
         yuQjSGt4ExBwr2s0mHdm2Yk8K07Y/YnjUNHQeEmtznrKhLv4Gb+K4VsI2HSJ6pyvG8oI
         XJ9+2avIJdLLpq2LxWFZMlNgR7XZ2I+oJcJXFZ9I+WEzeBVBHuRB5ouHr8k5pQbIy83O
         oiynroPyMiGAymTsd5YJYGQXN0zW0/W5fh51C7/SFFE6fdLz+TU2/LAh2sMNwS1kIQXl
         GmdaD0l5DUZlC+NIaisj7zTm/LwTvMbQ+ZQZ8NCIkHLH8mAuVPTfVr4Agxkf6neXy3WU
         t/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739446885; x=1740051685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcTbBDmPuXAkneoxzG7APyhlttHMdDVjsF9iXGMU9/s=;
        b=JXDjRCwddFDCdn5JabkRDzjdqiwvqD3lK/6k9kzNvUftc4SsYQzfOe4TNtCZE6xMak
         lN+P+5RyEfyb/bGUZKQLoxECzhnDbWexKUsCT4C5sS2iVY1KMTZqTUW5qGHRM4/VMhJ1
         MZd69K5IDyTMjET9giZvEhzjeO9b5Q7H1UJPVl+kO6JKJ0/NSqAcCM/Us9XtikYpVTlK
         dGLjjCqF0PVoPHw12TYLeAK+QRNDKwdQW6hqWkeN+0hfjGG7VA0p60Pp8y3+h5r5uE+p
         fUo98my87u2GhhMZL+E8yA/5OKgC22osWgxEl1p5OZUOdYtsF7jR5N5ziA2Upu8Yx7gh
         Zb2A==
X-Forwarded-Encrypted: i=1; AJvYcCW2wWhl4I6lBdaVW2Jicl6KjQ29A/SH7lKbUQabGsaGmtg34k0+vrYVPSyB+CnuvdyrnHn/Lm8vYP+kdQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZWkbBiId68iiwG4AJ1Zyn8bil+yPbLP/L9qRmRtzvIT7YYIBm
	M9C7jsVbwx4Lvj4i6cUHpEcN8fZWw07pjDPZFJlrvFLGmDUgKIE8ICVsXEP4pA==
X-Gm-Gg: ASbGncv4CIvedepQ2Y1SlKRy6C46yoAt6f4fSBb2+BIpNSDCff5I7Pvc3G4NSK978xj
	CeONUESFBYkfgAPcmVn2Z8wskGDTLwsOlRuLf1kfwRk4ZLQqTpWmrItUxrnQdNzGK4ek7oZ2Dma
	A5eJMHptd3FiIB4OVde52ZtA8JzXdMhNgZVK/GI9XFKWIg5TS59JzqWO7Ed3MfW5S6TKKFsWGDQ
	gZL3cXDNvSSXNq2spJ0/DwFh3oYv/xWawnLTy3PT5ndLtb/rw+CgS7lHEZVlIQZBcEe5N7c3V0M
	FyPj07FD7uY5wRdaN8XAWe92vCSpv3Sj8dHaUfZuYq3wq2bIZCHVeQ==
X-Google-Smtp-Source: AGHT+IFhMwP5lG09eUiy8MoGZ1rExMjc2AZS5qrzOF9s8D16MP3iao/73UkXEF2N1awGUq3vIppn4w==
X-Received: by 2002:a17:902:c40b:b0:216:21cb:2e06 with SMTP id d9443c01a7336-220d55bf74cmr1995625ad.19.1739446885219;
        Thu, 13 Feb 2025 03:41:25 -0800 (PST)
Received: from google.com (147.141.16.34.bc.googleusercontent.com. [34.16.141.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5364351sm10758605ad.76.2025.02.13.03.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 03:41:24 -0800 (PST)
Date: Thu, 13 Feb 2025 11:41:19 +0000
From: Peilin Ye <yepeilin@google.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	bpf@ietf.org, Xu Kuohai <xukuohai@huaweicloud.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	David Vernet <void@manifault.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Quentin Monnet <qmo@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Yingchi Long <longyingchi24s@ict.ac.cn>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
	Neel Natu <neelnatu@google.com>,
	Benjamin Segall <bsegall@google.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 4/9] bpf: Introduce load-acquire and
 store-release instructions
Message-ID: <Z63aX0Tv_zdw8LOQ@google.com>
References: <cover.1738888641.git.yepeilin@google.com>
 <d03d8c3305e311c6cb29924119b5eecae8370bbc.1738888641.git.yepeilin@google.com>
 <CAADnVQ+L0h8qXfYkC3+ORyQkXFJ2MgO8FDHr_Ha0QMAtS_ujag@mail.gmail.com>
 <Z6gRHDLfA7cjnlSn@google.com>
 <CAADnVQLkHA9LGv99k2TZOJEGUU=dw=q6nVurJ=aoh0v6cFS6zQ@mail.gmail.com>
 <Z6qC303CzfUMN8nV@google.com>
 <Z60dO2sV6VIVNE6t@google.com>
 <CAADnVQ+OyoBPOJk6dcUFozTt0RD-o-hHdR4Dgy+dK2r0uHyC7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQ+OyoBPOJk6dcUFozTt0RD-o-hHdR4Dgy+dK2r0uHyC7Q@mail.gmail.com>

Hi Alexei,

On Wed, Feb 12, 2025 at 09:55:43PM -0800, Alexei Starovoitov wrote:
> > > > >   #define BPF_LOAD_ACQ   0x10
> > > > >   #define BPF_STORE_REL  0x20
> 
> so that was broken then,
> since BPF_SUB 0x10 ?
> 
> And original thing was also completely broken for
> BPF_ATOMIC_LOAD | BPF_RELAXED == 0x10 == BPF_SUB ?
> 
> so much for "lets define relaxed, acquire,
> release, acq_rel for completeness".
> :(
> 
> > > > why not 1 and 2 ?
> > >
> > > I just realized

To clarify, by "just realized" I meant I forgot BPF_ADD equals 0x00
until (I had coffee on) Monday :-)

I wouldn't call it completely broken though.  For full context,
initially I picked [1] 0x1 and 0xb in imm<4-7> because:

  * 0x1 is BPF_SUB in BPFArithOp<>, and atomic SUB is implemented using
    NEG + ADD, quoting a comment in LLVM source:

    // atomic_load_sub can be represented as a neg followed
    // by an atomic_load_add.

    Though admittedly atomic SUB _could_ have its own insn.

  * 0xb is BPF_MOV, which is not applicable for atomic (memory)
    operations, as already discussed

After discussing [2] this with Yonghong, I changed it to 0x1 and 0x2,
because 0x2 is BPF_MUL and we are unlikely to support atomic
multiplication.  Then, following your suggestion to discuss the encoding
on-list, I left this as an open topic in RFC v1 cover letter (then
documented it in PATCH v1 8/8 and v2 9/9).

TL;DR: I wasn't aware that you were against having "aliases" (I do still
believe it's safe to pick 0xb).

> > > that we can't do 1 and 2 because BPF_ADD | BPF_FETCH also equals
> > > 1.
> > >
> > > > All other bits are reserved and the verifier will make sure they're zero
> > >
> > > IOW, we can't tell if imm<4-7> is reserved or BPF_ADD (0x00).  What
> > > would you suggest?  Maybe:
> > >
> > >   #define BPF_ATOMIC_LD_ST 0x10
> > >
> > >   #define BPF_LOAD_ACQ      0x1
> > >   #define BPF_STORE_REL     0x2
> 
> This is also broken, since
> BPF_ATOMIC_LD_ST | BPF_LOAD_ACQ == 0x11 == BPF_SUB | BPF_FETCH.
> 
> BPF_SUB | BPF_FETCH is invalid at the moment,
> but such aliasing is bad.
> 
> > > ?
> >
> > Or, how about reusing 0xb in imm<4-7>:
> >
> >   #define BPF_ATOMIC_LD_ST 0xb0
> >
> >   #define BPF_LOAD_ACQ      0x1
> >   #define BPF_STORE_REL     0x2
> >
> > 0xb is BPF_MOV in BPFArithOp<>, and we'll never need it for BPF_ATOMIC.
> > Instead of moving values between registers, we now "move" values from/to
> > the memory - if I can think of it that way.
> 
> and BPF_ATOMIC_LD_ST | BPF_LOAD_ACQ would == BPF_MOV | BPF_FETCH ?
> 
> Not pretty and confusing.
> 
> BPF_FETCH modifier means that "do whatever opcode says to do,
> like add in memory, but also return the value into insn->src_reg"
> 
> Which doesn't fit this BPF_ATOMIC_LD_ST | BPF_LOAD_ACQ semantics
> which loads into _dst_reg_.

I think we can have different imm<0-3> "namespace"s depending on
different imm<4-7> values?  So that 0x1 in imm<0-3> means BPF_FETCH for
existing RMW operations, and BPF_LOAD_ACQ for loads/stores.

Just like (browsing instruction-set.rst) for "64-bit immediate
instructions", the imm field means different things depending on the
value in src_reg?

If I change PATCH v2 9/9 to say the following in instruction-set.rst:

  ```
  These operations are categorized based on the second lowest nibble
  (bits 4-7) of the 'imm' field:

  * ``ATOMIC_LD_ST`` indicates an atomic load or store operation (see
    `Atomic load and store operations`_).

  * All other defined values indicate an atomic read-modify-write
    operation, as described in the following section.
  ```

The section for loads/stores will have its own table explaining what
imm<0-3> means.

> How about:
> #define BPF_LOAD_ACQ 2
> #define BPF_STORE_REL 3
> 
> and only use them with BPF_MOV like
> 
> imm = BPF_MOV | BPF_LOAD_ACQ - is actual load acquire
> imm = BPF_MOV | BPF_STORE_REL - release
> 
> Thought 2 stands on its own,
> it's also equal to BPF_ADD | BPF_LOAD_ACQ
> which is kinda ugly,

> so I don't like to use 2 alone.

Totally agree - if we use 2 and 3 alone, zero in imm<4-7> would mean
"reserved" for load_acq/store_rel, and "BPF_ADD" for add/fetch_add.

> > Or, do we want to start to use the remaining bits of the imm field (i.e.
> > imm<8-31>) ?
> 
> Maybe.
> Sort-of.
> Since #define BPF_CMPXCHG     (0xf0 | BPF_FETCH)
> another option would be:
> 
> #define BPF_LOAD_ACQ 0x100
> #define BPF_STORE_REL 0x110
> 
> essentially extending op type to:
> BPF_ATOMIC_TYPE(imm)    ((imm) & 0x1f0)

Why, it sounds like a great idea!  If we extend the op_type field from
imm<4-7> to imm<4-11>, 256 numbers is more than we'll ever need?

After all we'd still need to worry about e.g. cmpwait_relaxed you
mentioned earlier.  I am guessing that we'll want to put it under
BPF_ATOMIC as well, since XCHG and CMPXCHG are here.  If we take your
approach, cmpwait_relaxed can be easily defined as e.g.:

  #define BPF_CMPWAIT_RELAXED   0x120

(FWIW, I was imagining a subtype/subclass flag in maybe imm<8-11> or
 imm<28-31> (or make it 8 bits for 256 subtypes/subclasses), so that 0x0
 means read-modify-write subclass, then 0x1 means maybe load/store
 subclass" etc.)

> All options are not great.
> I feel we need to step back.
> Is there an architecture that has sign extending load acquire ?

IIUC, if I grep the LLVM source like:

  $ git grep -B 100 -A 100 getExtendForAtomicOps -- llvm/lib/Target/ \
	| grep ISD::SIGN_EXTEND
  llvm/lib/Target/LoongArch/LoongArchISelLowering.h-    return ISD::SIGN_EXTEND;
  llvm/lib/Target/Mips/MipsISelLowering.h-      return ISD::SIGN_EXTEND;
  llvm/lib/Target/RISCV/RISCVISelLowering.h-    return ISD::SIGN_EXTEND;

So LoongArch, Mips and RISCV it seems?

Semi-related, but it would be non-trivial (if not infeasible) to support
both zext and sext load-acquire for LLVM BPF backend, because LLVM core
expects each arch to pick from SIGN_EXTEND, ZERO_EXTEND and ANY_EXTEND
for its atomic ops.  See my earlier investigation:

  https://github.com/llvm/llvm-project/pull/108636#issuecomment-2433844760

> Looks like arm doesn't, and I couldn't find any arch that does.
> Then maybe we should reconsider BPF_LDX/STX and use BPF_MODE
> to distinguish from normal ldx/stx
> 
> #define BPF_ACQ_REL 0xe0
> 
> BPF_LDX | BPF_ACQ_REL | BPF_W
> BPF_STX | BPF_ACQ_REL | BPF_W
> 
> ?

[1] https://github.com/llvm/llvm-project/pull/108636#issuecomment-2398916882
[2] https://github.com/llvm/llvm-project/pull/108636#discussion_r1815927568

Thanks,
Peilin Ye


