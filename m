Return-Path: <linux-kernel+bounces-380794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBAF9AF632
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 02:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C74BC1C217A8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 00:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76330AD21;
	Fri, 25 Oct 2024 00:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="iabFei46"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0773F6FC5
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 00:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729816187; cv=none; b=WdV/nU9WHcC9kMYmhHF50gklROlk0jwHL+IwI176sp0OnwNUYBFicJOSGLtQG/734XLesyr+hmbnrTulqjIE6q9kwQvxhWQAOE7GoXLhSAx6J9nedTGOq9MKNENajfD+YKBu81oLcpaCp5S6Oie0sl77BiUA3s4ZxFwiEonw9YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729816187; c=relaxed/simple;
	bh=LB817QyFJvPBhuyk3cvh2gd2ab0x5mcnlPSDdXFAXhg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DsjM8JjgyPxqw2NPoRe81feGjE8FRGdW6P+aD7gUvpC6aZKSnVdtWdwBGluvtcD3iyhNL8nZTN+hlNU2tGLPsoPliA9vTz4ni9C226b5Kg7UxVAWKFLJlSDtto3CzDyNYXVr0XrK0oU0gGKsocpiBV2aYgptf2TCeemQMW93Kas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=iabFei46; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1729816180;
	bh=EnB2ce/rVYDY5AA6/sx9y4i1CZuXEVtDGbu8N7gt0+U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=iabFei46eTD/ZABVvZ6sJZ8FoaRnbZc0gsNTN7ITADjc8l4Isggqg8L8ZZm2BQw2G
	 hZhVqbbbO5Abiy+EBJ8OLftUG7OYK7V57k0+qm20ipD+Xpiq88+l7NLLWKscAbZB/X
	 3StMn1YeJGl0pvUG/KOHJViw0qbhWvdMD+GFq0NhRnCgk+uPNmxLD7HkDDJojf2PmU
	 0Phdv4G2lFFeeDxZdPQk40AIutU5DJfklA8tnxUNaoKh17PNsRLT2SyK4kqfF2HYIk
	 nK7/g1OT4qt4LJGqzdMi0/RK+HzwyV9C2QFv0vgSuQFBX92bnnmY+Yagksy+sGz1VA
	 go5DInxlYiB9Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XZNvl59fLz4x2g;
	Fri, 25 Oct 2024 11:29:39 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Nysal Jan K.A." <nysal@linux.ibm.com>, Andrew Morton
 <akpm@linux-foundation.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Cc: linuxppc-dev@lists.ozlabs.org, "Nysal Jan K.A" <nysal@linux.ibm.com>,
 Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
 <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
 <justinstitt@google.com>, Vlastimil Babka <vbabka@suse.cz>, Kent
 Overstreet <kent.overstreet@linux.dev>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, Roman Gushchin <roman.gushchin@linux.dev>,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] sched/membarrier: Fix redundant load of membarrier_state
In-Reply-To: <20241007053936.833392-1-nysal@linux.ibm.com>
References: <20241007053936.833392-1-nysal@linux.ibm.com>
Date: Fri, 25 Oct 2024 11:29:38 +1100
Message-ID: <87frolja8d.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

[To += Mathieu]

"Nysal Jan K.A." <nysal@linux.ibm.com> writes:
> From: "Nysal Jan K.A" <nysal@linux.ibm.com>
>
> On architectures where ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
> is not selected, sync_core_before_usermode() is a no-op.
> In membarrier_mm_sync_core_before_usermode() the compiler does not
> eliminate redundant branches and the load of mm->membarrier_state
> for this case as the atomic_read() cannot be optimized away.

I was wondering if this was caused by powerpc's arch_atomic_read() which
uses asm volatile.

But replacing arch_atomic_read() with READ_ONCE() makes no difference,
presumably because the compiler still can't see that the READ_ONCE() is
unnecessary (which is kind of by design).

> Here's a snippet of the code generated for finish_task_switch() on powerpc:
>
> 1b786c:   ld      r26,2624(r30)   # mm = rq->prev_mm;
> .......
> 1b78c8:   cmpdi   cr7,r26,0
> 1b78cc:   beq     cr7,1b78e4 <finish_task_switch+0xd0>
> 1b78d0:   ld      r9,2312(r13)    # current
> 1b78d4:   ld      r9,1888(r9)     # current->mm
> 1b78d8:   cmpd    cr7,r26,r9
> 1b78dc:   beq     cr7,1b7a70 <finish_task_switch+0x25c>
> 1b78e0:   hwsync
> 1b78e4:   cmplwi  cr7,r27,128
> .......
> 1b7a70:   lwz     r9,176(r26)     # atomic_read(&mm->membarrier_state)
> 1b7a74:   b       1b78e0 <finish_task_switch+0xcc>
>
> This was found while analyzing "perf c2c" reports on kernels prior
> to commit c1753fd02a00 ("mm: move mm_count into its own cache line")
> where mm_count was false sharing with membarrier_state.

So it was causing a noticable performance blip? But isn't anymore?

> There is a minor improvement in the size of finish_task_switch().
> The following are results from bloat-o-meter:
>
> GCC 7.5.0:
> ----------
> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-32 (-32)
> Function                                     old     new   delta
> finish_task_switch                           884     852     -32
>
> GCC 12.2.1:
> -----------
> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-32 (-32)
> Function                                     old     new   delta
> finish_task_switch.isra                      852     820     -32

GCC 12 is a couple of years old, I assume GCC 14 behaves similarly?

> LLVM 17.0.6:
> ------------
> add/remove: 0/0 grow/shrink: 0/2 up/down: 0/-36 (-36)
> Function                                     old     new   delta
> rt_mutex_schedule                            120     104     -16
> finish_task_switch                           792     772     -20
>
> Signed-off-by: Nysal Jan K.A <nysal@linux.ibm.com>
> ---
>  include/linux/sched/mm.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index 07bb8d4181d7..042e60ab853a 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -540,6 +540,8 @@ enum {
>  
>  static inline void membarrier_mm_sync_core_before_usermode(struct mm_struct *mm)
>  {
> +	if (!IS_ENABLED(CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE))
> +		return;
>  	if (current->mm != mm)
>  		return;
>  	if (likely(!(atomic_read(&mm->membarrier_state) &

The other option would be to have a completely separate stub, eg:

  #ifdef CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
  static inline void membarrier_mm_sync_core_before_usermode(struct mm_struct *mm)
  {
          if (current->mm != mm)
                  return;
          if (likely(!(atomic_read(&mm->membarrier_state) &
                       MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE)))
                  return;
          sync_core_before_usermode();
  }
  #else
  static inline void membarrier_mm_sync_core_before_usermode(struct mm_struct *mm) { }
  #endif

Not sure what folks prefer.

In either case I think it's probably worth a short comment explaining
why it's worth the trouble (ie. that the atomic_read() prevents the
compiler from doing DCE).

cheers

