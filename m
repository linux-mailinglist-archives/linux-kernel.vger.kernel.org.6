Return-Path: <linux-kernel+bounces-173375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2BF8BFF9E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7419928EC6E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4873C84D3C;
	Wed,  8 May 2024 13:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6sm3MY1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0D084A3C
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 13:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715176742; cv=none; b=laGEy7q2GolK545ZGMEAEuM1Wz7/NVhGNmNa1aGduPpHjpagCMZxHlPIvdNdpXyDDr7t1vLIGvUbNkpTTaAO8KfqzCaVGiPhIs5hgnbNvLMEMwAaWhnAjPQjgYpp+VE9XJWbp4ZTn87LIzsB2fh5O5Q/Mf/SicG5wKGIQOUQDtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715176742; c=relaxed/simple;
	bh=utHb+Gnn40+ooa4sOyCKwBsal3Y3TBegAvM5IB8a7bw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eeu3T2+34FAZMW7WdXGE/LQnC9tJ9gPGfFdoY2jzrkRVCT/LqFkpMpheC0+C2t4fV30+89dcYWiMH90DuZVnrmFFPvrK0DbvOEt6D/UvIJ20kC08shSDpszTNwr/wM5JRlUv4NpXE55oZYjxrDAjLf4WCb0DtDNpdOeoyaidUOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6sm3MY1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ACC0C113CC;
	Wed,  8 May 2024 13:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715176741;
	bh=utHb+Gnn40+ooa4sOyCKwBsal3Y3TBegAvM5IB8a7bw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=G6sm3MY1wfWeucVcijKvZc2VZjsSXNXNsQFJMpgURuHhSQXEnstVoiL5K456uJJs7
	 hDwtFLkZTDFb2dbkR8j3N6VDiYXjFens2f4DxPG0K0dcD0VRsCqoRpDbfCMNepphE0
	 t9QB7mjK7H2IdEwaomAC4sfXtSK2WedzTCvB2NMWS0eNxvPcdDPolOM9Q8terq60mO
	 +bhz48+VBaM+xvTcQcQnx6lJkG7n96QHIQg51UUxucHCysliKrC5lX92XLWp90jsJV
	 y1HGYuxSgCsvzyXdphH5gC42uGmJL8qTKW33HEFhH+Mit30A+y7T8ijxwXrWjoaWON
	 PidWu7Xyt7pHw==
From: Puranjay Mohan <puranjay@kernel.org>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Daniel Lustig <dlustig@nvidia.com>, Will Deacon <will@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Mark
 Rutland <mark.rutland@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] riscv/atomic.h: optimize ops with acquire/release ordering
In-Reply-To: <Zjqqu6RN1kRXw/WT@andrea>
References: <20240505123340.38495-1-puranjay@kernel.org>
 <ZjgLAKlWC2HQzWfU@andrea> <mb61p4jb91zs1.fsf@kernel.org>
 <Zjqqu6RN1kRXw/WT@andrea>
Date: Wed, 08 May 2024 13:58:58 +0000
Message-ID: <mb61pttj8z9p9.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrea Parri <parri.andrea@gmail.com> writes:

>> I think Guo Ren sent a patch[1] like this earlier but it did not get
>> comments yet. I will reply on that thread[1] as well.
>
> TBF, those changes appeared in a later submission/series,
>
>   https://lore.kernel.org/lkml/20220505035526.2974382-1-guoren@kernel.org/
>
> a submission that received a similar feedback from the ATOMIC INFRASTRUCT=
URE
> maintainers and myself: in short, "please explain _why_ you are doing what
> you are doing".
>
>
>> I saw the commit 5ce6c1f3535fa ("riscv/atomic: Strengthen
>> implementations with fences") and all the related discussions.
>>=20
>> This is what I understand from the discussions:
>>=20
>> RISCV's LR.aq/SC.rl were following RCpc ordering but the LKMM expected
>> RCsc ordering from lock() and unlock(). So you added fences to force RCsc
>> ordering in the locks/atomics.
>
> Appreciate the effort.  Some corrections/clarifications:
>
> When 5ce6c1f3535fa was developed, the LKMM expected "less-than-RCsc" orde=
ring
> from the lock operations.  Some of those properties were illustrated by t=
he
> unlock-lock-read-ordering litmus test you reported (and included in
>
>   0123f4d76ca63 ("riscv/spinlock: Strengthen implementations with fences"=
) ).
>
> It's also worth mentioning that, when 5ce6c1f3535fa was discussed, the LK=
MM
> expected similar read-read ordering properties to hold for ordinary acqui=
re
> and release operations, i.e. not necessary a lock operation.
>
> Later changes to the LKMM relaxed those properties for ordinary acquires =
and
> releases, and added extra ordering for locks, cf.
>
>   6e89e831a9017 ("tools/memory-model: Add extra ordering for locks and re=
move it for ordinary release/acquire")
>   ddfe12944e848 ("tools/memory-model: Provide extra ordering for unlock+l=
ock pair on the same CPU")=20
>
> Roughly speaking, such changes made the LKMM's locks RCtso, and this matc=
hes
> the current LKMM's approach.  (Yes I know, there is code assuming/wishing=
 RCsc
> locks... long story, not strictly related to this discussion/thread: IAC,=
 for
> completeness, I'll say more about that in my comments below.)
>
> My changes/the current implementations provides RCtso (not RCsc) ordering=
 for
> RISCV's locks and atomics; in fact, by their very design, this RCtso is p=
retty
> easy to see/prove:
>
>   (1) every release op provides RW to W order (or stronger);
>
>   (2) every acquire op provides more than R to R order (typically R to RW
>       order, but in atomic_cond_load_acquire() & co. that R-to-W order is
>       limited to the "R" associated with the acquire op itself).
>
> Put together, (1-2) give R-to-R, R-to-W and W-to-W order (aka RCtso) as c=
laimed.
> Notice that this argument holds for every locks operations and types (spi=
nlock,
> rwlock, mutex, rt_mutex, semaphore, rw_semaphore, etc.) and that it does =
_not_
> require any audit of the locking code.  More on this point below.
>
>
>> An experiment with LKMM and RISCV MM:
>>=20
>> The following litmus test should not reach (1:r0=3D1 /\ 1:r1=3D0) with L=
KMM:
>>=20
>> C unlock-lock-read-ordering
>>=20
>> {}
>> /* s initially owned by P1 */
>>=20
>> P0(int *x, int *y)
>> {
>>         WRITE_ONCE(*x, 1);
>>         smp_wmb();
>>         WRITE_ONCE(*y, 1);
>> }
>>=20
>> P1(int *x, int *y, spinlock_t *s)
>> {
>>         int r0;
>>         int r1;
>>=20
>>         r0 =3D READ_ONCE(*y);
>>         spin_unlock(s);
>>         spin_lock(s);
>>         r1 =3D READ_ONCE(*x);
>> }
>>=20
>> exists (1:r0=3D1 /\ 1:r1=3D0)
>>=20
>> Which is indeed true:
>>=20
>> Test unlock-lock-read-ordering Allowed
>> States 3
>> 1:r0=3D0; 1:r1=3D0;
>> 1:r0=3D0; 1:r1=3D1;
>> 1:r0=3D1; 1:r1=3D1;
>> No
>> Witnesses
>> Positive: 0 Negative: 3
>> Flag unmatched-unlock
>> Condition exists (1:r0=3D1 /\ 1:r1=3D0)
>> Observation unlock-lock-read-ordering Never 0 3
>> Time unlock-lock-read-ordering 0.01
>> Hash=3Dab0cfdcde54d1bb1faa731533980f424
>>=20
>> And when I map this test to RISC-V:
>>=20
>> RISCV RISCV-unlock-lock-read-ordering
>> {
>> 0:x2=3Dx;
>> 0:x4=3Dy;
>>=20
>> 1:x2=3Dx;
>> 1:x4=3Dy;
>> 1:x6=3Ds;
>> }
>>  P0           |  P1                      ;
>>  ori x1,x0,1  | lw x1,0(x4)              ;
>>  sw x1,0(x2)  | amoswap.w.rl x0,x0,(x6)  ;
>>  fence w,w    | ori x5,x0,1              ;
>>  ori x3,x0,1  | amoswap.w.aq x0,x5,(x6)  ;
>>  sw x3,0(x4)  | lw x3,0(x2)              ;
>> exists (1:x1=3D1 /\ 1:x3=3D0)
>>=20
>> This also doesn't reach the condition:
>>=20
>> Test RISCV-unlock-lock-read-ordering Allowed
>> States 3
>> 1:x1=3D0; 1:x3=3D0;
>> 1:x1=3D0; 1:x3=3D1;
>> 1:x1=3D1; 1:x3=3D1;
>> No
>> Witnesses
>> Positive: 0 Negative: 3
>> Condition exists (1:x1=3D1 /\ 1:x3=3D0)
>> Observation RISCV-unlock-lock-read-ordering Never 0 3
>> Time RISCV-unlock-lock-read-ordering 0.01
>> Hash=3Dd845d36e2a8480165903870d135dd81e
>
> Which "mapping" did you use for this experiment/analysis?  Looking at the

Actually, by mapping I meant:

R1
amoswap.w.rl
amoswap.w.aq
R2

will provide R1->R2 ordering like:

R1
spin_unlock()
spin_lock()
R2

That test is for read->read ordering enforced by unlock()->lock() and I
just wanted to say that the current RISC-V memory model provides that
with all(amo/lr/sc) .rl -> .aq operations.

> current spinlock code for RISCV (and including the atomic changes at stak=
e)
> P1 seems to be better described by something like:
>
>   fence rw,w		// arch_spin_unlock --> smp_store_release
>   sw
>
>   lr.w 			// arch_spin_trylock --> arch_try_cmpxchg
>   bne
>   sc.w.rl
>   bnez
>   fence rw,rw
>
> or
>
>   amoadd.w.aqrl		// arch_spin_lock --> atomic_fetch_add
>
> or
>
>   lw			// arch_spin_lock --> atomic_cond_read_acquire ; smp_mb  (??)
>   bne
>   fence r,r
>
>   fence rw,rw
>
> Looking at the rwlock code (for which the same RCtso property is expected=
 to
> hold, even though that hasn't been formalized in the LKMM yet), I see (ag=
ain,
> including your atomic changes):
>
>   amoadd.w.rl		// queued_read_unlock --> atomic_sub_return_release
>   amoadd.w.aq		// queued_read_lock --> atomic_add_return_acquire
>
> and
>
>   fence rw,w		// queue_write_unlock --> smp_store_release
>   sw
>   lr.w 			// queue_write_lock --> atomic_try_cmpxchg_acquire
>   bne
>   sc.w
>   bnez
>   fence r,rw
>
> I won't list the slowpath scenarios.  Or even the mutex, semaphore, etc. =
 I
> believe you got the point...

Thanks for these details, I will do more testing with this on herd7.


Something out of curiosity?:

From my understanding of the current version of the RV memory model:

aq provides .aq -> all ordering
rl provides all -> .rl ordering
and because this is RCsc variant of release consistency
rl -> .aq

which means

R/W
amoswap.w.rl
amoswap.w.aq
R/W

Should act as a full fence? R/W -> rl -> aq -> R/W

>
>> Your commit mentioned that the above test would reach the exists
>> condition for RISCV.
>>=20
>> So, maybe the model has been modified to make .aq and .rl RCsc now?
>
> Yes.  .aq and .rl are RCsc.  They were considered RCpc when 5ce6c1f3535fa
> 0123f4d76ca63 were discussed (which happened _before_ the RISC-V's memory
> model was ratified) as clearly remarked in their commit messages.
>
> The ATOMIC maintainers went as far as "bisecting" the RISC-V ISA spec in
>
>   https://lore.kernel.org/lkml/YrPei6q4rIAx6Ymf@boqun-archlinux/
>
> but, as they say, it's hard to help people who don't want to be helped...
>
>
>> This presentation[2] by Dan Lustig says on page 31:
>>=20
>>  | PPO RULES 5-7
>>  | A release that precedes an acquire in program
>>  | order also precedes it in global memory order
>>  | =E2=80=A2 i.e., the RCsc variant of release consistency
>>=20
>> If above is true, removing the weak fences and using LR, SC, AMOs with
>> aq, rl, and aqrl bits could be used in the kernel AMOs and locks.
>
> The problem with this argument is that it relies on all lock ops to come =
with
> an RCsc annotation, which is simply not true in the current/RISCV code as=
 the
> few snippets above also suggested.
>
> BTW, arm64 uses a similar argument, except all its releases/acquires come=
 with
> RCsc annotations (which greatly simplifies the analysis).  The argument c=
ould
> be easily made to work in RISCV _provided_ its ISA were augmented with lw=
aq
> and sw.rl, but it's been ~6 years...
>
> Said this, maybe we're "lucky" and all the unlock+lock pairs will just wo=
rk w/
> your changes.  I haven't really checked, and I probably won't until the o=
nly
> motivation for such changes will be "lower inst count in qemu".
>
> On such regard, remark that Section A.5, "Code porting and mapping guidel=
ines"
> of the RISCV ISA spec provides alternative mapping for our atomics, inclu=
ding
> AMO mapping w/ .aq and .rl annotations: I'm sure those mappings were subj=
ect
> to a fair amount of review and formal analysis (although I was not involv=
ed in
> that work/review at the time): if inst count is so important to you, why =
not
> simply follow those guidelines?  (Notice that such re-write would require=
 some
> modification to non-AMO mappings, cf. smp_store_release() and LR/SC mappi=
ngs.)

So, I will do the following now:

1. Do some benchmarking on real hardware and find out how much overhead
   these weak fences add.
2. Study the LKMM and the RVWMO for the next few weeks/months or however
   much time it takes me to confidently reason about things written in
   these two models.
3. Study the locking / related code of RISC-V to see what could break if
   we change all these operations in accordance with "Code Porting and
   Mapping Guidelines" of RISCV ISA.
4. I will use the herd7 models of LKMM and RVWMO and see if everything
   works as expected after these changes.


And If I am convinced after all this, I will send a patch to implement
"Code Porting and Mapping Guidelines" + provide performance numbers from
real hardware.

Thanks for the detailed explainations and especially regarding how the
LKMM evolved.


Puranjay

