Return-Path: <linux-kernel+bounces-572264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1683A6C863
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 09:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F3073B0225
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 08:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74971D5173;
	Sat, 22 Mar 2025 08:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LD9Shthh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E8741760
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 08:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742633324; cv=none; b=hHXPEyU3e2JoskIrMBkMCcHiPp2coZLvwikEsRH81VQ1CJFXnho2CBolQkNAGJsNHfDKnjTaOz7EYZqZQILPtDLwomTnUc+gffL0lDTJUTWKfmal3QXkvRZ/hlm2WvFhBCRNXoprZE/wQd1vCt9b91+dPxTmdag/gC1Z4SwKpwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742633324; c=relaxed/simple;
	bh=Mg7CoJ36wS1S9Z91TB/5G45uF/7bSTpwB/G1GxmgE4k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QP9CP0PrurAhj/+/QXcw9ivBwU6KBvSdN6nrQTEaNdvkqvnaBNzIPmfSeuwZu0DO2kk3TtNcq5ATJLFWJwLnoJKJfHeWXEPHsABjDZebDpnz3DTGkvJP4l5gGaPi9qjJZr+TJCwE1L1At/c36KsQDBbDkW9Z6xfto2vDd5PJ/jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LD9Shthh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6414AC4CEDD;
	Sat, 22 Mar 2025 08:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742633323;
	bh=Mg7CoJ36wS1S9Z91TB/5G45uF/7bSTpwB/G1GxmgE4k=;
	h=Date:From:To:Cc:Subject:From;
	b=LD9ShthhJ/ReFT7QCtGpQk2wszA/rw/j7AwK9lHbLDBSUYxAcON1XiEFkiQDJFgtJ
	 cw9ITVTgRfnEBYfT2S1LcB2Jom+FHu8nZEHG/2s/DPyJnWs7fRjjG6aMgXNdwbYjnW
	 nR2aMWHFyf4V+VlY7qqZtpI3cM2J0utfrguZ2Z/Gx+VgwgxP9zG06m38x5zZ2MSAM0
	 Rb4iLh1vUCO6+0py9SexQx75x8PfzscaobEge+F4enew+DTBQ8frt9Dn0wMCEDDzOR
	 18SmQNanONfSc3N+X/rmkPL5//i+UHbxzOD6vxBPs5R0EGQdiWzNXSBei/fxCn5fTe
	 VWgFO2VII4JzA==
Date: Sat, 22 Mar 2025 09:48:39 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Borislav Petkov <bp@alien8.de>, Uros Bizjak <ubizjak@gmail.com>
Subject: [GIT PULL] locking changes for v6.15
Message-ID: <Z955ZyIi-tum55pL@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest locking/core Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2025-03-22

   # HEAD: 35e6b537af85d97e0aafd8f2829dfa884a22df20 lockdep: Remove disable_irq_lockdep()

Locking changes for v6.15:

  Locking primitives:

    - Micro-optimize percpu_{,try_}cmpxchg{64,128}_op() and {,try_}cmpxchg{64,128}
      on x86 (Uros Bizjak)

    - mutexes: extend debug checks in mutex_lock() (Yunhui Cui)

    - Misc cleanups (Uros Bizjak)

  Lockdep:

    - Fix might_fault() lockdep check of current->mm->mmap_lock (Peter Zijlstra)

    - Don't disable interrupts on RT in disable_irq_nosync_lockdep.*()
      (Sebastian Andrzej Siewior)

    - Disable KASAN instrumentation of lockdep.c (Waiman Long)

    - Add kasan_check_byte() check in lock_acquire() (Waiman Long)

    - Misc cleanups (Sebastian Andrzej Siewior)

  Rust runtime integration:

    - Use Pin for all LockClassKey usages (Mitchell Levy)
    - sync: Add accessor for the lock behind a given guard (Alice Ryhl)
    - sync: condvar: Add wait_interruptible_freezable() (Alice Ryhl)
    - sync: lock: Add an example for Guard:: Lock_ref() (Boqun Feng)

  Split-lock detection feature (x86):

    - Fix warning mode with disabled mitigation mode (Maksim Davydov)

  Locking events:

    - Add locking events for rtmutex slow paths (Waiman Long)
    - Add locking events for lockdep (Waiman Long)

 Thanks,

	Ingo

------------------>
Alice Ryhl (2):
      rust: sync: Add accessor for the lock behind a given guard
      rust: sync: condvar: Add wait_interruptible_freezable()

Boqun Feng (1):
      rust: sync: lock: Add an example for Guard:: Lock_ref()

Maksim Davydov (1):
      x86/split_lock: Fix the delayed detection logic

Mitchell Levy (1):
      rust: lockdep: Use Pin for all LockClassKey usages

Peter Zijlstra (1):
      lockdep/mm: Fix might_fault() lockdep check of current->mm->mmap_lock

Sebastian Andrzej Siewior (2):
      lockdep: Don't disable interrupts on RT in disable_irq_nosync_lockdep.*()
      lockdep: Remove disable_irq_lockdep()

Uros Bizjak (3):
      x86/locking: Use ALT_OUTPUT_SP() for percpu_{,try_}cmpxchg{64,128}_op()
      x86/locking: Use asm_inline for {,try_}cmpxchg{64,128} emulations
      x86/locking: Remove semicolon from "lock" prefix

Waiman Long (4):
      locking/lock_events: Add locking events for rtmutex slow paths
      locking/lock_events: Add locking events for lockdep
      locking/lockdep: Disable KASAN instrumentation of lockdep.c
      locking/lockdep: Add kasan_check_byte() check in lock_acquire()

Yunhui Cui (1):
      locking/mutex: Add MUTEX_WARN_ON() into fast path


 arch/x86/include/asm/alternative.h |  2 +-
 arch/x86/include/asm/barrier.h     |  8 ++--
 arch/x86/include/asm/cmpxchg.h     |  4 +-
 arch/x86/include/asm/cmpxchg_32.h  | 36 ++++++++++--------
 arch/x86/include/asm/edac.h        |  2 +-
 arch/x86/include/asm/percpu.h      | 77 ++++++++++++++++++--------------------
 arch/x86/include/asm/sync_bitops.h | 12 +++---
 arch/x86/kernel/cpu/bus_lock.c     | 20 ++++++++--
 include/linux/interrupt.h          | 16 ++------
 kernel/locking/Makefile            |  3 +-
 kernel/locking/lock_events_list.h  | 28 ++++++++++++++
 kernel/locking/lockdep.c           | 17 ++++++++-
 kernel/locking/mutex.c             |  2 +
 kernel/locking/rtmutex.c           | 29 +++++++++++---
 mm/memory.c                        |  2 -
 rust/helpers/helpers.c             |  1 +
 rust/helpers/sync.c                | 13 +++++++
 rust/kernel/sync.rs                | 57 ++++++++++++++++++++++++++--
 rust/kernel/sync/condvar.rs        | 28 ++++++++++++--
 rust/kernel/sync/lock.rs           | 35 +++++++++++++++--
 rust/kernel/sync/lock/global.rs    |  5 ++-
 rust/kernel/sync/poll.rs           |  2 +-
 rust/kernel/task.rs                |  2 +
 rust/kernel/workqueue.rs           |  2 +-
 24 files changed, 294 insertions(+), 109 deletions(-)
 create mode 100644 rust/helpers/sync.c

