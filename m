Return-Path: <linux-kernel+bounces-171502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C46808BE53C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F0C3B28178
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC77A15EFAC;
	Tue,  7 May 2024 14:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TlSZCfhx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031D914EC64
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 14:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715090850; cv=none; b=Z88PnQRCZNa/CgpOmjku4jVpkKWm3UuHek//jZjsLWprHOfOyUZ43wRJCIGrjy2jX4PkC/9Nd2s8kt+LrqGvOUK6pmiyxghZbFdtWrxdQ6jCLPSPn31x2dRI8MH9I7NS9QltlUa75tT9b/RaVdATUsXT7R+mkFNDgkEwsikWEuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715090850; c=relaxed/simple;
	bh=Wgua9hwlpKleBWvYByFTlHo94DWXbiaBJrkWmQcDYFM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lZXSviVFh/mVFHuey1vPOwVvFyJLb65ZgfLrsflEa9bfgA2+ehhhONIg5wW8OGCyz0XshPkozXO+KctgGMP2bGcwrursRu/mO+9MihTQvnFzBmcaYo9VByPrne4SsoyWbeZ1sGy8R+hL9ecT2tweEKn/AE81LClKlaMMwpjDCDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TlSZCfhx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555C4C2BBFC;
	Tue,  7 May 2024 14:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715090849;
	bh=Wgua9hwlpKleBWvYByFTlHo94DWXbiaBJrkWmQcDYFM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TlSZCfhxErCpepOvO60RmpT/hc0bdnvgA1gyd50l1azuDZ8Id5DHvFDT3ilzI7BTf
	 nk9t0C2KWKbna/vv9WTjJUJDGHfxdkWTu8VmGz1ukLKMcsqKu8bIYPw+vbBj0ipkMh
	 lH0QD/zU94ChC7E5sENRK2nUfwOlbjx20Bc+L4yBq3qAwZ7HI7J4P31E+YZ2PFjTvF
	 hRHuxDsp3Dn/BJr1rmoJ96iG5aRVoglkfwLgMWOIGWMHU7ZwbZFobdCydda8dEh0fD
	 F61r5mfgZDXRJ11K4zI6kNpZzFkG5C5x9fnuS5Y5vno0f1bCEYwj0wQFR1RZAyDWn2
	 QZ4b3dML5q/Zg==
From: Puranjay Mohan <puranjay@kernel.org>
To: Andrea Parri <parri.andrea@gmail.com>, Daniel Lustig <dlustig@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] riscv/atomic.h: optimize ops with acquire/release ordering
In-Reply-To: <ZjgLAKlWC2HQzWfU@andrea>
References: <20240505123340.38495-1-puranjay@kernel.org>
 <ZjgLAKlWC2HQzWfU@andrea>
Date: Tue, 07 May 2024 14:07:26 +0000
Message-ID: <mb61p4jb91zs1.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrea Parri <parri.andrea@gmail.com> writes:

> Hi Puranjay,
>
> On Sun, May 05, 2024 at 12:33:40PM +0000, Puranjay Mohan wrote:
>> Currently, atomic ops with acquire or release ordering are implemented
>> as atomic ops with relaxed ordering followed by or preceded by an
>> acquire fence or a release fence.
>>=20
>> Section 8.1 of the "The RISC-V Instruction Set Manual Volume I:
>> Unprivileged ISA", titled, "Specifying Ordering of Atomic Instructions"
>> says:
>>=20
>> | To provide more efficient support for release consistency [5], each
>> | atomic instruction has two bits, aq and rl, used to specify additional
>> | memory ordering constraints as viewed by other RISC-V harts.
>>=20
>> and
>>=20
>> | If only the aq bit is set, the atomic memory operation is treated as
>> | an acquire access.
>> | If only the rl bit is set, the atomic memory operation is treated as a
>> | release access.
>>=20
>> So, rather than using two instructions (relaxed atomic op + fence), use
>> a single atomic op instruction with acquire/release ordering.
>>=20
>> Example program:
>>=20
>>   atomic_t cnt =3D ATOMIC_INIT(0);
>>   atomic_fetch_add_acquire(1, &cnt);
>>   atomic_fetch_add_release(1, &cnt);
>>=20
>> Before:
>>=20
>>   amoadd.w        a4,a5,(a4)  // Atomic add with relaxed ordering
>>   fence   r,rw                // Fence to force Acquire ordering
>>=20
>>   fence   rw,w                // Fence to force Release ordering
>>   amoadd.w        a4,a5,(a4)  // Atomic add with relaxed ordering
>>=20
>> After:
>>=20
>>   amoadd.w.aq     a4,a5,(a4)  // Atomic add with Acquire ordering
>>=20
>>   amoadd.w.rl     a4,a5,(a4)  // Atomic add with Release ordering
>>=20
>> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
>
> Your changes are effectively partially reverting:
>
>   5ce6c1f3535fa ("riscv/atomic: Strengthen implementations with fences")
>
> Can you please provide (and possibly include in the changelog of v2) a mo=
re
> thoughtful explanation for the correctness of such revert?
>
> (Anticipating a somewhat non-trivial analysis...)

Hi Andrea,

I think Guo Ren sent a patch[1] like this earlier but it did not get
comments yet. I will reply on that thread[1] as well.

I saw the commit 5ce6c1f3535fa ("riscv/atomic: Strengthen
implementations with fences") and all the related discussions.

This is what I understand from the discussions:

RISCV's LR.aq/SC.rl were following RCpc ordering but the LKMM expected
RCsc ordering from lock() and unlock(). So you added fences to force RCsc
ordering in the locks/atomics.

An experiment with LKMM and RISCV MM:

The following litmus test should not reach (1:r0=3D1 /\ 1:r1=3D0) with LKMM:

C unlock-lock-read-ordering

{}
/* s initially owned by P1 */

P0(int *x, int *y)
{
        WRITE_ONCE(*x, 1);
        smp_wmb();
        WRITE_ONCE(*y, 1);
}

P1(int *x, int *y, spinlock_t *s)
{
        int r0;
        int r1;

        r0 =3D READ_ONCE(*y);
        spin_unlock(s);
        spin_lock(s);
        r1 =3D READ_ONCE(*x);
}

exists (1:r0=3D1 /\ 1:r1=3D0)

Which is indeed true:

Test unlock-lock-read-ordering Allowed
States 3
1:r0=3D0; 1:r1=3D0;
1:r0=3D0; 1:r1=3D1;
1:r0=3D1; 1:r1=3D1;
No
Witnesses
Positive: 0 Negative: 3
Flag unmatched-unlock
Condition exists (1:r0=3D1 /\ 1:r1=3D0)
Observation unlock-lock-read-ordering Never 0 3
Time unlock-lock-read-ordering 0.01
Hash=3Dab0cfdcde54d1bb1faa731533980f424

And when I map this test to RISC-V:

RISCV RISCV-unlock-lock-read-ordering
{
0:x2=3Dx;
0:x4=3Dy;

1:x2=3Dx;
1:x4=3Dy;
1:x6=3Ds;
}
 P0           |  P1                      ;
 ori x1,x0,1  | lw x1,0(x4)              ;
 sw x1,0(x2)  | amoswap.w.rl x0,x0,(x6)  ;
 fence w,w    | ori x5,x0,1              ;
 ori x3,x0,1  | amoswap.w.aq x0,x5,(x6)  ;
 sw x3,0(x4)  | lw x3,0(x2)              ;
exists (1:x1=3D1 /\ 1:x3=3D0)

This also doesn't reach the condition:

Test RISCV-unlock-lock-read-ordering Allowed
States 3
1:x1=3D0; 1:x3=3D0;
1:x1=3D0; 1:x3=3D1;
1:x1=3D1; 1:x3=3D1;
No
Witnesses
Positive: 0 Negative: 3
Condition exists (1:x1=3D1 /\ 1:x3=3D0)
Observation RISCV-unlock-lock-read-ordering Never 0 3
Time RISCV-unlock-lock-read-ordering 0.01
Hash=3Dd845d36e2a8480165903870d135dd81e

Your commit mentioned that the above test would reach the exists
condition for RISCV.

So, maybe the model has been modified to make .aq and .rl RCsc now?

This presentation[2] by Dan Lustig says on page 31:

 | PPO RULES 5-7
 | A release that precedes an acquire in program
 | order also precedes it in global memory order
 | =E2=80=A2 i.e., the RCsc variant of release consistency

If above is true, removing the weak fences and using LR, SC, AMOs with
aq, rl, and aqrl bits could be used in the kernel AMOs and locks.

[1] https://lore.kernel.org/all/20220420144417.2453958-3-guoren@kernel.org/
[2] https://riscv.org/wp-content/uploads/2018/05/14.25-15.00-RISCVMemoryMod=
elTutorial.pdf

Thanks,
Puranjay

