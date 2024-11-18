Return-Path: <linux-kernel+bounces-412862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAA39D104D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B4E0B2263B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1289198A2C;
	Mon, 18 Nov 2024 12:02:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AEC13A89A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 12:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731931341; cv=none; b=SUlEnrh73uELq93rU4TlZOXWGax7E+SyolJXOKXMtKvAOdwf4qIH099+ZMEe7MLVf7MLs3i7dq3FW1ab/sOzJwWHvJW1j8Ki1jicqrLtVmOMXEatLsUNdqFE6mFnvzXIsAaZISzt0HR0LYPS+Iid3unXpx3Q31Xg+gQQGvKG3pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731931341; c=relaxed/simple;
	bh=+PjQxtJvb4AsfjJpba7uHcmdQeioKxW3twF+Ef9r0eo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CyoyJ7lLtSgNQWyMjYu1mZz94I2k3fr3HXpFhqTPC4esexcBletFKEexHtG8r5U7uIZUIJRsl2a5TQ5mzsXgfzaccEMbfuamIHTD0A6zqXD715DFfDqjLo/MJ+u4IFS4vt/DiB66pVtp7t6/qadwjeQvAvgVHygA7LQ5wh93YZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1AB201682;
	Mon, 18 Nov 2024 04:02:48 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D3F0F3F6A8;
	Mon, 18 Nov 2024 04:02:15 -0800 (PST)
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: ardb@kernel.org,
	broonie@kernel.org,
	catalin.marinas@arm.com,
	jpoimboe@kernel.org,
	kaleshsingh@google.com,
	kristina.martsenko@arm.com,
	linux-kernel@vger.kernel.org,
	madvenka@linux.microsoft.com,
	mark.rutland@arm.com,
	maz@kernel.org,
	mbenes@suse.cz,
	mhiramat@kernel.org,
	puranjay12@gmail.com,
	rostedt@goodmis.org,
	will@kernel.org
Subject: [PATCH] arm64: disable ARCH_CORRECT_STACKTRACE_ON_KRETPROBE tests
Date: Mon, 18 Nov 2024 12:02:04 +0000
Message-Id: <20241118120204.3961548-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kprobes_test suite's test_stacktrace_on_nested_kretprobe() test
currently fails on arm64, e.g.

| KTAP version 1
| 1..1
|     KTAP version 1
|     # Subtest: kprobes_test
|     # module: test_kprobes
|     1..7
|     ok 1 test_kprobe
|     ok 2 test_kprobes
|     ok 3 test_kprobe_missed
|     ok 4 test_kretprobe
|     ok 5 test_kretprobes
|     ok 6 test_stacktrace_on_kretprobe
|     # test_stacktrace_on_nested_kretprobe: EXPECTATION FAILED at lib/test_kprobes.c:327
|     Expected stack_buf[i + 1] == target_return_address[1], but
|         stack_buf[i + 1] == -96519936577004 (0xffffa83733777214)
|         target_return_address[1] == -96519936577136 (0xffffa83733777190)
|     # test_stacktrace_on_nested_kretprobe: EXPECTATION FAILED at lib/test_kprobes.c:338
|     Expected stack_buf[1] == target_return_address[1], but
|         stack_buf[1] == -96519936577004 (0xffffa83733777214)
|         target_return_address[1] == -96519936577136 (0xffffa83733777190)
|     not ok 7 test_stacktrace_on_nested_kretprobe
| # kprobes_test: pass:6 fail:1 skip:0 total:7
| # Totals: pass:6 fail:1 skip:0 total:7
| not ok 1 kprobes_test

The test assumes that when a stacktrace straddles an exception boundary,
no necessary entries will be omitted and no extraneous entries will be
reported, and when unwinding from a kretprobed callee, the next entry in
the trace will be its immediate caller (whether kretprobed or not).

Recently the arm64 stacktrace code was changed to always report the LR
at an exception boundary, where we don't know whether the LR is live.
In the case of the kretprobe trampoline the LR is not live at the time
the stacktrace is performed, and so the entry in the trace for the LR is
extraneous. This can be seen if a call to show_stack() is added to
stacktrace_internal_return_handler():

| Call trace:
|  show_stack+0x18/0x30 (C)
|  stacktrace_internal_return_handler+0x130/0x43c
|  __kretprobe_trampoline_handler+0xa0/0x130
|  kretprobe_breakpoint_handler+0x50/0x70
|  call_break_hook+0x74/0x8c
|  brk_handler+0x1c/0x60
|  do_debug_exception+0x68/0x114
|  el1_dbg+0x70/0x94
|  el1h_64_sync_handler+0xc4/0xe4
|  el1h_64_sync+0x6c/0x70
|  kprobe_stacktrace_target+0x34/0x48 (P)
|  kprobe_stacktrace_target+0x34/0x48 (LK) <-------- extra entry here
|  kprobe_stacktrace_driver+0x24/0x40 (K)
|  test_stacktrace_on_nested_kretprobe+0x84/0x160
|  kunit_try_run_case+0x6c/0x160
|  kunit_generic_run_threadfn_adapter+0x28/0x4c
|  kthread+0x110/0x114
|  ret_from_fork+0x10/0x20

This breaks test_stacktrace_on_nested_kretprobe() because while the
caller (kprobe_stacktrace_driver()) appears in the trace, it doesn't
occur *immediately* after the first instance of callee
(kprobe_stacktrace_target()).

While this behaviour is unfortunate for the kretprobes tests, the
behaviour is desirable elsewhere (e.g. anywhere a human will read the
trace), and is otherwise not harmful.

For the moment, deselect ARCH_CORRECT_STACKTRACE_ON_KRETPROBE on arm64
to disable the tests which depend on this behaviour. With
ARCH_CORRECT_STACKTRACE_ON_KRETPROBE deselected, the remaining tests
work as expected, e.g.

| KTAP version 1
| 1..1
|     KTAP version 1
|     # Subtest: kprobes_test
|     # module: test_kprobes
|     1..5
|     ok 1 test_kprobe
|     ok 2 test_kprobes
|     ok 3 test_kprobe_missed
|     ok 4 test_kretprobe
|     ok 5 test_kretprobes
| # kprobes_test: pass:5 fail:0 skip:0 total:5
| # Totals: pass:5 fail:0 skip:0 total:5
| ok 1 kprobes_test

In future we have several options to improve matters, e.g.

* Add metadata and update arm64's unwinder to skip the LR in this case.
  This is likely to happen as part of work for RELIABLE_STACKTRACE for
  other reasons, and might solve this case by coincidence.

* Modify the kretprobes tests to only require that the caller appears in
  the trace after the callee, rather than requiring that it is
  *immediately* after the callee. We might want separate
  strict/not-strict options for this.

* Use reliable stacktrace for these tests, so that architectures which
  cannot unwind across exception boundaries can explicitly handle this
  by returning an error.

Fixes: c2c6b27b5aa1 ("arm64: stacktrace: unwind exception boundaries")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reported-by: Kristina Martsenko <kristina.martsenko@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Kalesh Singh <kaleshsingh@google.com>
Cc: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Miroslav Benes <mbenes@suse.cz>
Cc: Puranjay Mohan <puranjay12@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3e29b44d2d7bd..234d926290731 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -14,7 +14,6 @@ config ARM64
 	select ARCH_HAS_DEBUG_WX
 	select ARCH_BINFMT_ELF_EXTRA_PHDRS
 	select ARCH_BINFMT_ELF_STATE
-	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
 	select ARCH_ENABLE_MEMORY_HOTPLUG
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
-- 
2.30.2


