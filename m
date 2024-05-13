Return-Path: <linux-kernel+bounces-177183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1131F8C3B20
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 08:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B52FB20D05
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 06:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8C0146596;
	Mon, 13 May 2024 06:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWXPryrZ"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52D54C81
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 06:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715580251; cv=none; b=HeUIPgW6gYCtnBg11ferRGjbXOxvFGwDO+cYOfEEbfTTUXrLJdy5FIW9eBraqGuXfEki+0rYHCxWBHDvn3zS8VYdMZDBC7E1ZMvr32jguwbTkfKqf+EuT9xaMrH/aKSMe90outj7UHDmJjhTv1fRbTit9wiFmm44KiwoNzuttHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715580251; c=relaxed/simple;
	bh=Xt9S8dlMCW3NtruodoS/LYAH8F0QezoIIzxVV2k5IBw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=vFlTiTp0QENQeCz2w8/wz+EKbiEKEic2iI3QLdJ+eCVYL18deptDSyfztKLEoA0/NZ6CfFEc77vRhRxEwBfaaxBpUNnMwt6W2fOWARDRTx7jO0Q0Vr6H4+2YICFCbRPMns4SGhAGDngnZ7PREGS7tpI2hBCvcjheRLJPa67y4f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWXPryrZ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a599eedc8eeso948134566b.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 23:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715580248; x=1716185048; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=XSDmacJrSEsyXiAs3orP3K7bhFVWvidj4v4FY7X5UGk=;
        b=AWXPryrZcW5pH16rJeAUWmvOxRkfPQJqm5zj2a7ISFpBVpDXJE5dOxiPaAJNeyvFSp
         nnb5JDdbe++1msSDwGhj2AoIP+fBDzVzMRgD1FIQKmSq4CfrVv+KCjHO3np7kVjUQawt
         o0GulS6Jzu/Bik1OS99PZ+PWFekA9fThokFZdVV5PJkhm8o8O+CDEVFifOHwJlwiJ3YU
         /I2WCnQVc3MW3xyusTQ6YuWsh4/2xVC1ayD9PBZmavpt1glFhJ7BRIPAOtXDJ3zB43c7
         IPSB+d3Z4a2iVkSmv5uBOLr61j2Xzllq66vp0Lubdj93ZVu8E+EGSoG70Ck5YVewZ85V
         Ctdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715580248; x=1716185048;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XSDmacJrSEsyXiAs3orP3K7bhFVWvidj4v4FY7X5UGk=;
        b=h4ugGifK8zkRcVUkZngHCGoXJq4bP6/CPN8QY+Zms9bRdGotJUczWPZNrflrUmBXb7
         2kHwg4FsDXzC8DmnptJB1nGZlDnfdS0DNGZZBlmWB8Amn6WSRJQzNKZnPLhDGlLdLycO
         qArDkFC8MyaHiCs255tEqeTK6FblFtfTelEaHESX8ZTB5necw2I0cd5k4AJq+F1pT4lk
         cd90jWHzV2JDlUkYqRT4iXfiIyjlYXLxsmW5AjE39GU5s181gbgq+KKE0g46tqZ59Jvx
         9zVvucrCTAeK3ELQB0IhulSaEADGuDg+FGU4d8M1VhCMKvlfpujA/49ETs+uZ6M0+TtM
         b/7w==
X-Gm-Message-State: AOJu0Yx/cNFzaTHZ4JedmVN0gw67K/NqvhyKWQL44hBg7YGnU2c0MGX/
	L0EnbEiWKvA9X2pmN5qJ9Jbb1lDJai2VlOBCwSdUiLfHQY+F0p72
X-Google-Smtp-Source: AGHT+IHRGGUlO/uwMw3XoAWtzjqDPkkW1PpYK8cRCjzTAhgLeNEpTrRIdL1zIQRzzsIacky4WqteqA==
X-Received: by 2002:a50:d69b:0:b0:572:7280:89db with SMTP id 4fb4d7f45d1cf-5734d6edcc1mr5316928a12.30.1715580247493;
        Sun, 12 May 2024 23:04:07 -0700 (PDT)
Received: from gmail.com (1F2EF402.unconfigured.pool.telekom.hu. [31.46.244.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c2c7d3esm5733817a12.73.2024.05.12.23.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 23:04:06 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 13 May 2024 08:04:04 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] locking changes for v6.10
Message-ID: <ZkGtVO7uhcFXEeX6@gmail.com>
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

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2024-05-13

   # HEAD: 532453e7aa78f3962fb4d86caf40ff81ebf62160 locking/pvqspinlock/x86: Use _Q_LOCKED_VAL in PV_UNLOCK_ASM macro

Locking changes for v6.10:

 - Over a dozen code generation micro-optimizations for the atomic
   and spinlock code.

 - Add more __ro_after_init attributes

 - Robustify the lockdevent_*() macros

 Thanks,

	Ingo

------------------>
Peter Zijlstra (1):
      jump_label,module: Don't alloc static_key_mod for __ro_after_init keys

Uros Bizjak (15):
      locking/atomic/x86: Correct the definition of __arch_try_cmpxchg128()
      locking/atomic/x86: Modernize x86_32 arch_{,try_}_cmpxchg64{,_local}()
      locking/atomic/x86: Introduce arch_try_cmpxchg64() for !CONFIG_X86_CMPXCHG64
      locking/atomic/x86: Introduce arch_atomic64_try_cmpxchg() to x86_32
      locking/atomic/x86: Introduce arch_atomic64_read_nonatomic() to x86_32
      locking/atomic/x86: Rewrite x86_32 arch_atomic64_{,fetch}_{and,or,xor}() functions
      locking/atomic/x86: Define arch_atomic_sub() family using arch_atomic_add() functions
      locking/qspinlock: Use atomic_try_cmpxchg_relaxed() in xchg_tail()
      locking/pvqspinlock: Use try_cmpxchg_acquire() in trylock_clear_pending()
      locking/pvqspinlock: Use try_cmpxchg() in qspinlock_paravirt.h
      locking/pvqspinlock/x86: Remove redundant CMP after CMPXCHG in __raw_callee_save___pv_queued_spin_unlock()
      locking/atomic/x86: Introduce arch_try_cmpxchg64_local()
      locking/atomic/x86: Merge __arch{,_try}_cmpxchg64_emu_local() with __arch{,_try}_cmpxchg64_emu()
      locking/qspinlock/x86: Micro-optimize virt_spin_lock()
      locking/pvqspinlock/x86: Use _Q_LOCKED_VAL in PV_UNLOCK_ASM macro

Valentin Schneider (3):
      context_tracking: Make context_tracking_key __ro_after_init
      x86/kvm: Make kvm_async_pf_enabled __ro_after_init
      x86/tsc: Make __use_tsc __ro_after_init

Waiman Long (1):
      locking/qspinlock: Always evaluate lockevent* non-event parameter once


 arch/x86/include/asm/atomic.h             |  12 +-
 arch/x86/include/asm/atomic64_32.h        |  79 +++++++----
 arch/x86/include/asm/atomic64_64.h        |  12 +-
 arch/x86/include/asm/cmpxchg_32.h         | 209 ++++++++++++++++++------------
 arch/x86/include/asm/cmpxchg_64.h         |   8 +-
 arch/x86/include/asm/qspinlock.h          |  13 +-
 arch/x86/include/asm/qspinlock_paravirt.h |   7 +-
 arch/x86/kernel/kvm.c                     |   2 +-
 arch/x86/kernel/tsc.c                     |   2 +-
 include/asm-generic/sections.h            |   5 +
 include/linux/jump_label.h                |   3 +
 init/main.c                               |   1 +
 kernel/context_tracking.c                 |   2 +-
 kernel/jump_label.c                       |  53 ++++++++
 kernel/locking/lock_events.h              |   4 +-
 kernel/locking/qspinlock.c                |  13 +-
 kernel/locking/qspinlock_paravirt.h       |  49 ++++---
 17 files changed, 297 insertions(+), 177 deletions(-)

