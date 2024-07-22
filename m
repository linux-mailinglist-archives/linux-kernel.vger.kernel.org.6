Return-Path: <linux-kernel+bounces-259360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B663A9394BA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 22:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CB6FB21A33
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 20:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A114338394;
	Mon, 22 Jul 2024 20:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IOi5c60b"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BA02E634
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 20:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721679914; cv=none; b=C+OzZEj64z2hQ00MkztS0+GsSb+MlMLSBQ53iFSMa3tQiBHkfaB/8aV9e8P+6DEdfiBdPi5f08DemgjrugyofY32IQKSuaMhpY3a3qNeokPX7qf0I5/AoA+Id7si+vAwN7o14qSDkNl0y/QDTjdQRBV96YBQvStwCvN+g8AZfS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721679914; c=relaxed/simple;
	bh=cP4uK2f73YKAXf/GUuOq+uz/UsePNWboKvj76t+0ByU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F+pHE+0JLF+JkiXhQ83w4oEQqs32+pebK/YxzWc48wdiIlCvlai6JyMRotETL+R0Ere3t/+tUv1oUUFHIaSq4CmFTcMo3BYwUywxvq9iCvvYRcGUF0L1DboxX86HdOfOgxzCx0dS5A8TKuNZHsIj5NhbcOTjfHnC6TVWRMDryz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IOi5c60b; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: dvyukov@google.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721679910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8/k2ZwHfUaSJhfPH5Zkk+TCGlgAiYiwAht3Bf0GZAMY=;
	b=IOi5c60blghNxdAKiJv2T7ykwod346m3RprJaQT200nmUaMO4fYCJO3KbwAVxgZju4yFwQ
	Xo0d3AKE6QGLODNleLlLwNTUUgXZKXqVwsR2n7u1aGNNeZQ8qd4gqD2pjLGnpiVu4+Mi9Q
	MYJqmuNWVxP3QuLnvrCFTSQPipqGDcQ=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: andreyknvl@gmail.com
X-Envelope-To: nogikh@google.com
X-Envelope-To: elver@google.com
X-Envelope-To: glider@google.com
X-Envelope-To: kasan-dev@googlegroups.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: tglx@linutronix.de
X-Envelope-To: mingo@redhat.com
X-Envelope-To: bp@alien8.de
X-Envelope-To: dave.hansen@linux.intel.com
X-Envelope-To: x86@kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: andrey.konovalov@linux.dev
To: Dmitry Vyukov <dvyukov@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Aleksandr Nogikh <nogikh@google.com>,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86, kcov: ignore stack trace coverage
Date: Mon, 22 Jul 2024 22:25:02 +0200
Message-Id: <20240722202502.70301-1-andrey.konovalov@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Andrey Konovalov <andreyknvl@gmail.com>

When a multitude of kernel debugging options are enabled, they often
collect and save the current stack trace. The coverage produced by the
related routines is not relevant for the KCOV's intended use case
(guiding the fuzzing process).

Thus, disable instrumentation of the x86 stack trace collection code.

KCOV instrumentaion of the generic kernel/stacktrace.c was already
disabled in commit 43e76af85fa7 ("kcov: ignore fault-inject and
stacktrace"). This patch is an x86-specific addition.

In addition to freeing up the KCOV buffer capacity for holding more
relevant coverage, this patch also speeds up the kernel boot time with
the config from the syzbot USB fuzzing instance by ~25%.

Fixes: 43e76af85fa7 ("kcov: ignore fault-inject and stacktrace")
Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>

---

I'm not sure whether it makes sense to backport this patch to stable
kernels, but I do think that it makes sense to take it into mainline
as a fix: currently, the USB fuzzing instance is choking on the amount
of coverage produced by KCOV and thus doesn't perform well.

For reference, without this patch, for the following program:

r0 = syz_usb_connect_ath9k(0x3, 0x5a, &(0x7f0000000080)={{0x12, 0x1,
0x200, 0xff, 0xff, 0xff, 0x40, 0xcf3, 0x9271, 0x108, 0x1, 0x2, 0x3, 0x1,
[{{0x9, 0x2, 0x48, 0x1, 0x1, 0x0, 0x80, 0xfa, {{0x9, 0x4, 0x0, 0x0, 0x6,
0xff, 0x0, 0x0, 0x0, "", {{0x9, 0x5, 0x1, 0x2, 0x200, 0x0, 0x0, 0x0, ""},
{0x9, 0x5, 0x82, 0x2, 0x200, 0x0, 0x0, 0x0, ""}, {0x9, 0x5, 0x83, 0x3,
0x40, 0x1, 0x0, 0x0, ""}, {0x9, 0x5, 0x4, 0x3, 0x40, 0x1, 0x0, 0x0, ""},
{0x9, 0x5, 0x5, 0x2, 0x200, 0x0, 0x0, 0x0, ""}, {0x9, 0x5, 0x6, 0x2,
0x200, 0x0, 0x0, 0x0, ""}}}}}}]}}, 0x0)

KCOV produces ~500k coverage entries.

Here are the top ones sorted by the number of occurrences:

  23027 /home/user/src/arch/x86/kernel/unwind_orc.c:99
  17335 /home/user/src/arch/x86/kernel/unwind_orc.c:100
  16460 /home/user/src/arch/x86/include/asm/stacktrace.h:60 (discriminator 3)
  16460 /home/user/src/arch/x86/include/asm/stacktrace.h:60
  16191 /home/user/src/security/tomoyo/domain.c:183 (discriminator 1)
  16128 /home/user/src/security/tomoyo/domain.c:184 (discriminator 8)
  11384 /home/user/src/arch/x86/kernel/unwind_orc.c:109
  11155 /home/user/src/arch/x86/include/asm/stacktrace.h:59
  10997 /home/user/src/arch/x86/kernel/unwind_orc.c:665
  10768 /home/user/src/include/asm-generic/rwonce.h:67
   9994 /home/user/src/arch/x86/kernel/unwind_orc.c:390
   9994 /home/user/src/arch/x86/kernel/unwind_orc.c:389
  ...

With this patch, the number of entries drops to ~140k.

(For reference, here are the top entries with this patch applied:

  16191 /home/user/src/security/tomoyo/domain.c:183 (discriminator 1)
  16128 /home/user/src/security/tomoyo/domain.c:184 (discriminator 8)
   3528 /home/user/src/security/tomoyo/domain.c:173 (discriminator 2)
   3528 /home/user/src/security/tomoyo/domain.c:173
   3528 /home/user/src/security/tomoyo/domain.c:171 (discriminator 5)
   2877 /home/user/src/lib/vsprintf.c:646
   2672 /home/user/src/lib/vsprintf.c:651
   2672 /home/user/src/lib/vsprintf.c:649
   2230 /home/user/src/lib/vsprintf.c:2559
   ...

I'm not sure why tomoyo produces such a large number of entries, but
that will require a separate fix anyway if it's unintended.)
---
 arch/x86/kernel/Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 20a0dd51700a..241e21723fa5 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -40,6 +40,14 @@ KMSAN_SANITIZE_sev.o					:= n
 KCOV_INSTRUMENT_head$(BITS).o				:= n
 KCOV_INSTRUMENT_sev.o					:= n
 
+# These produce large amounts of uninteresting coverage.
+KCOV_INSTRUMENT_dumpstack.o				:= n
+KCOV_INSTRUMENT_dumpstack_$(BITS).o			:= n
+KCOV_INSTRUMENT_stacktrace.o				:= n
+KCOV_INSTRUMENT_unwind_orc.o				:= n
+KCOV_INSTRUMENT_unwind_frame.o				:= n
+KCOV_INSTRUMENT_unwind_guess.o				:= n
+
 CFLAGS_irq.o := -I $(src)/../include/asm/trace
 
 obj-y			+= head_$(BITS).o
-- 
2.25.1


