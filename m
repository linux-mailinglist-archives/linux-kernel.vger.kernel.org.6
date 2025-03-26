Return-Path: <linux-kernel+bounces-576684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4990DA71304
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C2B91889AA3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F29A1A2860;
	Wed, 26 Mar 2025 08:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vtdfgdsm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05503D6A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 08:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742978882; cv=none; b=ErcoOYIMya6osqjHGVTks8NDkLMcHPz1SfFKz2KEq+dCpgEDOEr3GJYnD1IEwrRUKq9dxxyneT3iteBdGUPEmdRHvHB/T3tKs4CQ3ntK0VgF9YpJYd+BMjHOT+8tGA+RLWtlumuBcSKWc1lNzbLGzC9s3gJlQ31zWnqVma/ESgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742978882; c=relaxed/simple;
	bh=mat+8/FxE+NX07JNoYJiF2mWZIrg/gu+SimMIdPoEWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RWFqGoEXLhwxxENeKq5y93gQMTiBCpU/6ehTiRs138lxgj2syAYBgo+6y5bMSRwtfO+Pf5GEY0Sr45KPjkpDAra2wKTkeGKLJOqB81TSKyy4qheC8oJqYVeYfBbL1gcZ6HSE+IP2A5aFtrYxJi8K8y5YsjWdFqoKFhWhocylcMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vtdfgdsm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080BFC4CEE2;
	Wed, 26 Mar 2025 08:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742978882;
	bh=mat+8/FxE+NX07JNoYJiF2mWZIrg/gu+SimMIdPoEWE=;
	h=From:To:Cc:Subject:Date:From;
	b=VtdfgdsmDqpIg68IXAhbmpAXyHC4YLddsCQLnP71fU0COXrMRJ42fhOaAOQIyktgD
	 adFnFchrNm8wSd8OFcW1ocED4E6RVDhchOol8332byrANgbxS3T36Mn/07u/N4wLiF
	 +/doKLrNSuQpnf0TX2mC8T/4bpu1NUqweHTUcTBeFMF2f2Ym4F/zpwrcmzLCIZDKc9
	 UAccppxch8ZiafaeQxYeys+stDma5XwW1l7x1buzjFAgy6qCi3uKJgw/3kXcCaw4Ko
	 EfkALH6V5kIWQ8ATvHu7C4Jc/VAjB0lhFUqEDc7gPNqnrF7NJ5/iACRb9aeFNlsEsT
	 Y3xS4j1j0VvKw==
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/5] Improve WARN_ON_ONCE() output by adding the condition string
Date: Wed, 26 Mar 2025 09:47:45 +0100
Message-ID: <20250326084751.2260634-1-mingo@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series improves the current WARN_ON_ONCE() output from:

  WARN_ON_ONCE(idx < 0 && ptr);
  ...

  WARNING: CPU: 0 PID: 0 at kernel/sched/core.c:8511 sched_init+0x20/0x410
  CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.14.0-01616-g94d7af2844aa #4 PREEMPT(undef)

to (on x86):

  WARNING: [idx < 0 && ptr] kernel/sched/core.c:8511 sched_init+0x20/0x410
  CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.14.0-01616-g94d7af2844aa #4 PREEMPT(undef)

and on non-x86 architectures (the CPU/PID fields in the WARNING line are skipped):

  WARNING: kernel/sched/core.c:8511 sched_init+0x20/0x410
  CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.14.0-01616-g94d7af2844aa #4 PREEMPT(undef)

The motivation is the SCHED_WARN_ON() primitive that got removed in this
merge window:

  f7d2728cc032 ("sched/debug: Change SCHED_WARN_ON() to WARN_ON_ONCE()")

... which produced more informative debug output, as it included the
WARN_ON_ONCE() condition string - at the expense of worse code generation.

This series, based on Linus's latest Git tree, merges the code generation
benefits of modern WARN_ON_ONCE() bug_entry architecture code with the expanded
information content of SCHED_WARN_ON().

The cost is about +100K more .data on a defconfig kernel, and no runtime
code generation impact:

       text       data        bss         dec        hex    filename
   29523998    7926322    1389904    38840224    250a7a0    vmlinux.x86.defconfig.before
   29523998    8024626    1389904    38938528    25227a0    vmlinue.x86.defconfig.after

The series was build and boot tested on x86, with an expectation for it to
work on other architectures (with no testing at the moment to back up that
expectation).

Thanks,

    Ingo

================>
Ingo Molnar (5):
  bugs/core: Extend __WARN_FLAGS() with the 'cond_str' parameter
  bugs/core: Pass down the condition string of WARN_ON_ONCE(cond) warnings to __WARN_FLAGS()
  bugs/x86: Extend _BUG_FLAGS() with the 'cond_str' parameter
  bugs/x86: Augment warnings output by concatenating 'cond_str' with the regular __FILE__ string in _BUG_FLAGS()
  bugs/core: Do not print CPU and PID values in__warn() output

 arch/arm64/include/asm/bug.h     |  2 +-
 arch/loongarch/include/asm/bug.h |  2 +-
 arch/parisc/include/asm/bug.h    |  4 ++--
 arch/powerpc/include/asm/bug.h   |  2 +-
 arch/riscv/include/asm/bug.h     |  2 +-
 arch/s390/include/asm/bug.h      |  2 +-
 arch/sh/include/asm/bug.h        |  2 +-
 arch/x86/include/asm/bug.h       | 14 +++++++-------
 include/asm-generic/bug.h        |  7 ++++---
 kernel/panic.c                   |  7 ++-----
 10 files changed, 21 insertions(+), 23 deletions(-)

-- 
2.45.2


