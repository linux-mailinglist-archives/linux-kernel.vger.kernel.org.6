Return-Path: <linux-kernel+bounces-172248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BADC8BEFC4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 00:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C9D31C215AD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 22:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524F6154434;
	Tue,  7 May 2024 22:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoLy50lf"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B08573501
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 22:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715120836; cv=none; b=d8InhQVH3t+YPdwkU1JZu/sytAxS2/f6jjC53Q+vDBIMmtQqRfeMBxYXifb73hz6R5dlgbKYSRQBEXbmPx/J512M9nvILwtu8Z5Qei8l7MgsfEuJmiZ3R5S6mh/osq9kCEdzlTcTNqUMOnZz2A/4VEUapNyii9f1vSF06G6iZw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715120836; c=relaxed/simple;
	bh=0efTHVhIh3K+r1MMfOgJz9UobYrm24PwMP34xStqPRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5VNTC8IMV8Uslsw+P6me56NJnSqVYFkJRn0SlDFsvRCNHCFGQ9vJUbyozSIIGsXQV+ibJfJ7XasA8dscQ18ugYeiM6k0YgRYpKzQKRqsLO3wOkQ2EVfkHAXoFpKFZorzn809z+P2ddMjgG9u3XljO17E74n5WyVelbXTg9cd9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UoLy50lf; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a59b81d087aso800674066b.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 15:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715120833; x=1715725633; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RB6AQTKTdPmqFjCjRUrQJ4zCg+hiNu9TQFMR429ldJI=;
        b=UoLy50lfkWd0iayIevU8dvGAnx52h7tDMsZXkoyf0Ogpr6/ANxc3wefqcRd2WE2foL
         PsQu5z4drvPtZHv/S2OOQvBmel9SGDS7eMz03R4WM1WmrQho5IytEKYNdbdTaz8S30+S
         BmEzMjDNU0deAkmc0hjivZsqXGrXaWK6W1g0c+UHber7u8Cwp54jnLk0tzN89LYABpsL
         dzXILF2m1QvPf6iWo4SapcmhCpQfyivJL9kJ1aRbZ+yYt27KsEzCH7c7DFE8be5gEF9c
         0T2Yx40neb2Ae5UHH3SDuRFR8zG/4gZMP7h+bVufxo99UEjrN/StZd925Aq4Y3TNUurT
         0UBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715120833; x=1715725633;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RB6AQTKTdPmqFjCjRUrQJ4zCg+hiNu9TQFMR429ldJI=;
        b=GSSu/z3wGa4YhIHrnqX6+ROtbsrv2/UQPSgkCv8nSVTNZkKLJLObO4d+nEWcDZoIxF
         nGqP/BEzB9hI3rrDkvSd1nW4vwUXdFxfXQomgTgdsrygC87PZWwtix+SmU5/QW855cxm
         lI+RtntijRGhbTYuP+f6QnSOJ/7AUfmAnf5YjqWQkUOXxvZD0o9ceeO/NbGztPEgQRad
         5mS81bGg41qmaW19RzJzeMmksZK4Ud8832M0WHWCIiwZjjqE4U1jzl5y+PR5TKN1m6yj
         WELWQbEDSDdpkbQW+47T9MuxaUliOjCXXN/VsWUZ4xdKi0jWHp11hyHOVM8KQl5oWEFU
         EU+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVNDoc0UyM4AFWbw4nizs4vTTw3rN14p+JB9VCjKAHw4I1zGKBfIlOGl2duSAPS1zis5KgnW1MAi59CbcLJ/b1GzJoihci7JJY2s1z6
X-Gm-Message-State: AOJu0Yz+NDokZsNYavnH/CSgu/rsGygv9DwcAyd0iRNNtgBJMZ8fUSKa
	oHMvIp3e53vU4djWSCUdZY0yN8HQYZkOyCbfWmSCkyOperucPyql
X-Google-Smtp-Source: AGHT+IF1XM2IMzkuLH4K43waTvY4Oz3Nvs3MB067potE7EKqGSOebU3Iq04EcH55HAzC4MT8vSdfig==
X-Received: by 2002:a50:8d41:0:b0:572:a6ec:2396 with SMTP id 4fb4d7f45d1cf-5731da9ab3bmr752991a12.35.1715120832735;
        Tue, 07 May 2024 15:27:12 -0700 (PDT)
Received: from andrea ([31.189.114.81])
        by smtp.gmail.com with ESMTPSA id s3-20020aa7cb03000000b00572958eae83sm2160948edt.58.2024.05.07.15.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 15:27:12 -0700 (PDT)
Date: Wed, 8 May 2024 00:27:07 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Daniel Lustig <dlustig@nvidia.com>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH] riscv/atomic.h: optimize ops with acquire/release
 ordering
Message-ID: <Zjqqu6RN1kRXw/WT@andrea>
References: <20240505123340.38495-1-puranjay@kernel.org>
 <ZjgLAKlWC2HQzWfU@andrea>
 <mb61p4jb91zs1.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mb61p4jb91zs1.fsf@kernel.org>

> I think Guo Ren sent a patch[1] like this earlier but it did not get
> comments yet. I will reply on that thread[1] as well.

TBF, those changes appeared in a later submission/series,

  https://lore.kernel.org/lkml/20220505035526.2974382-1-guoren@kernel.org/

a submission that received a similar feedback from the ATOMIC INFRASTRUCTURE
maintainers and myself: in short, "please explain _why_ you are doing what
you are doing".


> I saw the commit 5ce6c1f3535fa ("riscv/atomic: Strengthen
> implementations with fences") and all the related discussions.
> 
> This is what I understand from the discussions:
> 
> RISCV's LR.aq/SC.rl were following RCpc ordering but the LKMM expected
> RCsc ordering from lock() and unlock(). So you added fences to force RCsc
> ordering in the locks/atomics.

Appreciate the effort.  Some corrections/clarifications:

When 5ce6c1f3535fa was developed, the LKMM expected "less-than-RCsc" ordering
from the lock operations.  Some of those properties were illustrated by the
unlock-lock-read-ordering litmus test you reported (and included in

  0123f4d76ca63 ("riscv/spinlock: Strengthen implementations with fences") ).

It's also worth mentioning that, when 5ce6c1f3535fa was discussed, the LKMM
expected similar read-read ordering properties to hold for ordinary acquire
and release operations, i.e. not necessary a lock operation.

Later changes to the LKMM relaxed those properties for ordinary acquires and
releases, and added extra ordering for locks, cf.

  6e89e831a9017 ("tools/memory-model: Add extra ordering for locks and remove it for ordinary release/acquire")
  ddfe12944e848 ("tools/memory-model: Provide extra ordering for unlock+lock pair on the same CPU") 

Roughly speaking, such changes made the LKMM's locks RCtso, and this matches
the current LKMM's approach.  (Yes I know, there is code assuming/wishing RCsc
locks... long story, not strictly related to this discussion/thread: IAC, for
completeness, I'll say more about that in my comments below.)

My changes/the current implementations provides RCtso (not RCsc) ordering for
RISCV's locks and atomics; in fact, by their very design, this RCtso is pretty
easy to see/prove:

  (1) every release op provides RW to W order (or stronger);

  (2) every acquire op provides more than R to R order (typically R to RW
      order, but in atomic_cond_load_acquire() & co. that R-to-W order is
      limited to the "R" associated with the acquire op itself).

Put together, (1-2) give R-to-R, R-to-W and W-to-W order (aka RCtso) as claimed.
Notice that this argument holds for every locks operations and types (spinlock,
rwlock, mutex, rt_mutex, semaphore, rw_semaphore, etc.) and that it does _not_
require any audit of the locking code.  More on this point below.


> An experiment with LKMM and RISCV MM:
> 
> The following litmus test should not reach (1:r0=1 /\ 1:r1=0) with LKMM:
> 
> C unlock-lock-read-ordering
> 
> {}
> /* s initially owned by P1 */
> 
> P0(int *x, int *y)
> {
>         WRITE_ONCE(*x, 1);
>         smp_wmb();
>         WRITE_ONCE(*y, 1);
> }
> 
> P1(int *x, int *y, spinlock_t *s)
> {
>         int r0;
>         int r1;
> 
>         r0 = READ_ONCE(*y);
>         spin_unlock(s);
>         spin_lock(s);
>         r1 = READ_ONCE(*x);
> }
> 
> exists (1:r0=1 /\ 1:r1=0)
> 
> Which is indeed true:
> 
> Test unlock-lock-read-ordering Allowed
> States 3
> 1:r0=0; 1:r1=0;
> 1:r0=0; 1:r1=1;
> 1:r0=1; 1:r1=1;
> No
> Witnesses
> Positive: 0 Negative: 3
> Flag unmatched-unlock
> Condition exists (1:r0=1 /\ 1:r1=0)
> Observation unlock-lock-read-ordering Never 0 3
> Time unlock-lock-read-ordering 0.01
> Hash=ab0cfdcde54d1bb1faa731533980f424
> 
> And when I map this test to RISC-V:
> 
> RISCV RISCV-unlock-lock-read-ordering
> {
> 0:x2=x;
> 0:x4=y;
> 
> 1:x2=x;
> 1:x4=y;
> 1:x6=s;
> }
>  P0           |  P1                      ;
>  ori x1,x0,1  | lw x1,0(x4)              ;
>  sw x1,0(x2)  | amoswap.w.rl x0,x0,(x6)  ;
>  fence w,w    | ori x5,x0,1              ;
>  ori x3,x0,1  | amoswap.w.aq x0,x5,(x6)  ;
>  sw x3,0(x4)  | lw x3,0(x2)              ;
> exists (1:x1=1 /\ 1:x3=0)
> 
> This also doesn't reach the condition:
> 
> Test RISCV-unlock-lock-read-ordering Allowed
> States 3
> 1:x1=0; 1:x3=0;
> 1:x1=0; 1:x3=1;
> 1:x1=1; 1:x3=1;
> No
> Witnesses
> Positive: 0 Negative: 3
> Condition exists (1:x1=1 /\ 1:x3=0)
> Observation RISCV-unlock-lock-read-ordering Never 0 3
> Time RISCV-unlock-lock-read-ordering 0.01
> Hash=d845d36e2a8480165903870d135dd81e

Which "mapping" did you use for this experiment/analysis?  Looking at the
current spinlock code for RISCV (and including the atomic changes at stake)
P1 seems to be better described by something like:

  fence rw,w		// arch_spin_unlock --> smp_store_release
  sw

  lr.w 			// arch_spin_trylock --> arch_try_cmpxchg
  bne
  sc.w.rl
  bnez
  fence rw,rw

or

  amoadd.w.aqrl		// arch_spin_lock --> atomic_fetch_add

or

  lw			// arch_spin_lock --> atomic_cond_read_acquire ; smp_mb  (??)
  bne
  fence r,r

  fence rw,rw

Looking at the rwlock code (for which the same RCtso property is expected to
hold, even though that hasn't been formalized in the LKMM yet), I see (again,
including your atomic changes):

  amoadd.w.rl		// queued_read_unlock --> atomic_sub_return_release
  amoadd.w.aq		// queued_read_lock --> atomic_add_return_acquire

and

  fence rw,w		// queue_write_unlock --> smp_store_release
  sw
  lr.w 			// queue_write_lock --> atomic_try_cmpxchg_acquire
  bne
  sc.w
  bnez
  fence r,rw

I won't list the slowpath scenarios.  Or even the mutex, semaphore, etc.  I
believe you got the point...


> Your commit mentioned that the above test would reach the exists
> condition for RISCV.
> 
> So, maybe the model has been modified to make .aq and .rl RCsc now?

Yes.  .aq and .rl are RCsc.  They were considered RCpc when 5ce6c1f3535fa
0123f4d76ca63 were discussed (which happened _before_ the RISC-V's memory
model was ratified) as clearly remarked in their commit messages.

The ATOMIC maintainers went as far as "bisecting" the RISC-V ISA spec in

  https://lore.kernel.org/lkml/YrPei6q4rIAx6Ymf@boqun-archlinux/

but, as they say, it's hard to help people who don't want to be helped...


> This presentation[2] by Dan Lustig says on page 31:
> 
>  | PPO RULES 5-7
>  | A release that precedes an acquire in program
>  | order also precedes it in global memory order
>  | • i.e., the RCsc variant of release consistency
> 
> If above is true, removing the weak fences and using LR, SC, AMOs with
> aq, rl, and aqrl bits could be used in the kernel AMOs and locks.

The problem with this argument is that it relies on all lock ops to come with
an RCsc annotation, which is simply not true in the current/RISCV code as the
few snippets above also suggested.

BTW, arm64 uses a similar argument, except all its releases/acquires come with
RCsc annotations (which greatly simplifies the analysis).  The argument could
be easily made to work in RISCV _provided_ its ISA were augmented with lw.aq
and sw.rl, but it's been ~6 years...

Said this, maybe we're "lucky" and all the unlock+lock pairs will just work w/
your changes.  I haven't really checked, and I probably won't until the only
motivation for such changes will be "lower inst count in qemu".

On such regard, remark that Section A.5, "Code porting and mapping guidelines"
of the RISCV ISA spec provides alternative mapping for our atomics, including
AMO mapping w/ .aq and .rl annotations: I'm sure those mappings were subject
to a fair amount of review and formal analysis (although I was not involved in
that work/review at the time): if inst count is so important to you, why not
simply follow those guidelines?  (Notice that such re-write would require some
modification to non-AMO mappings, cf. smp_store_release() and LR/SC mappings.)

  Andrea

