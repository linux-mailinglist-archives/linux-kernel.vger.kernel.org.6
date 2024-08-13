Return-Path: <linux-kernel+bounces-285332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F36950C2B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 20:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C44AD285755
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BD61A38D5;
	Tue, 13 Aug 2024 18:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEehcSPu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B9235894
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 18:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723573593; cv=none; b=PRxa59c5SXqbJ4992ut4B/P09JrMIptHE9N7RyIHfDfUl6JEkesXt2lyw0WdFqSJCWhi9ZQda+3Fwgu/E+CuTIFu9neeRHzFCjMWm+CVAX0Ieij0zr2O1nL0SssBJjllhF+C3CSSpLvTLYEfiR1q/n42/pWmLnthaWz1lnF6Mic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723573593; c=relaxed/simple;
	bh=PIiGnmzc+A6sckKGHJxXz1bfdoMHMEy2aBNf2hkDvwU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qSxez02qfGXuX7is2iXyImPRdnXfsyKuV+NOUrIiWwGfGMbaoLeczEJ7SYbkKB4pjX5J5ht30kVczZ3FecKR+ZxaxlMiptgox6xy83d2cRfoIaPuQ7pwrWIBTQCYjWGKRvPq+BPu5DF2mazwO/Ii3z8/g4CaE+G9p3uOzyF35jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEehcSPu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71E48C32782;
	Tue, 13 Aug 2024 18:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723573592;
	bh=PIiGnmzc+A6sckKGHJxXz1bfdoMHMEy2aBNf2hkDvwU=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=MEehcSPuG7zpZzGxfzwM8P2k8fThb0XZgr/bk+7kCaDyOC8lVQ5zIdWWB7eLwz+2V
	 fschJdbPUGscswYRZVMmbKwFUE7mW3pCwVUgufXp2AExQRcdRIX5ZKImS+QTVA0e21
	 5v2AJju9NktE9i5KkJ6SEifGeEXV7mnuTlc2qsVF8LERV2D/M/eXqtIhPVEcwaupTH
	 HTNvlSjROLefZNDdeMfqfzqyHwpgPz3kfxT9Y0y0sTbzNngXEjXFm4JkV2ZL0Q48lH
	 pAG3PYKiq4m2s6TXQT8TbLrKfzQ/J0+UD+FKADRdIBq0IML/1qoF+JpsaPSb4Y2eda
	 Q0mnKxt8sGdYQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661BCC52D7B;
	Tue, 13 Aug 2024 18:26:32 +0000 (UTC)
From: Christoph Lameter via B4 Relay <devnull+cl.gentwo.org@kernel.org>
Date: Tue, 13 Aug 2024 11:26:17 -0700
Subject: [PATCH RFC] Avoid memory barrier in read_seqcount() through load
 acquire
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-seq_optimize-v1-1-84d57182e6a7@gentwo.org>
X-B4-Tracking: v=1; b=H4sIAEilu2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDC0Nj3eLUwvj8gpLM3MyqVF0zi2QTCzNLs2RzSwsloJaCotS0zAqwcdG
 xtbUAbA2//14AAAA=
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, 
 Boqun Feng <boqun.feng@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 "Christoph Lameter (Ampere)" <cl@gentwo.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723573592; l=4580;
 i=cl@gentwo.org; s=20240811; h=from:subject:message-id;
 bh=3Nopmj43IyKUcz7M69aLBmi74hfW/6pSaf4yxvR7/js=;
 b=orwijZITJDz6E0KNga7pCM4Wi5DczM6Xc1j7fdfFedU1/4pZqMoo3LPIQ2AWagSJhdaNGyKoB
 Cce6zJOs4Y8B/NK8tdDYEhFbS+c7qm+ZZOFwalWJiYhiPkhn2rVgfn3
X-Developer-Key: i=cl@gentwo.org; a=ed25519;
 pk=I7gqGwDi9drzCReFIuf2k9de1FI1BGibsshXI0DIvq8=
X-Endpoint-Received: by B4 Relay for cl@gentwo.org/20240811 with
 auth_id=194
X-Original-From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Reply-To: cl@gentwo.org

From: "Christoph Lameter (Ampere)" <cl@gentwo.org>

Some architectures support load acquire which can save us a memory
barrier and save some cycles.

A typical sequence

	do {
		seq = read_seqcount_begin(&s);
		<something>
	} while (read_seqcount_retry(&s, seq);

requires 13 cycles on ARM64 for an empty loop. Two read memory barriers are
needed. One for each of the seqcount_* functions.

We can replace the first read barrier with a load acquire of
the seqcount which saves us one barrier.

On ARM64 doing so reduces the cycle count from 13 to 8.

Signed-off-by: Christoph Lameter (Ampere) <cl@gentwo.org>
---
 arch/Kconfig            |  5 +++++
 arch/arm64/Kconfig      |  1 +
 include/linux/seqlock.h | 41 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 975dd22a2dbd..3f8867110a57 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1600,6 +1600,11 @@ config ARCH_HAS_KERNEL_FPU_SUPPORT
 	  Architectures that select this option can run floating-point code in
 	  the kernel, as described in Documentation/core-api/floating-point.rst.
 
+config ARCH_HAS_ACQUIRE_RELEASE
+	bool
+	help
+	  Architectures that support acquire / release can avoid memory fences
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a2f8ff354ca6..19e34fff145f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -39,6 +39,7 @@ config ARM64
 	select ARCH_HAS_PTE_DEVMAP
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_HW_PTE_YOUNG
+	select ARCH_HAS_ACQUIRE_RELEASE
 	select ARCH_HAS_SETUP_DMA_OPS
 	select ARCH_HAS_SET_DIRECT_MAP
 	select ARCH_HAS_SET_MEMORY
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index d90d8ee29d81..353fcf32b800 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -176,6 +176,28 @@ __seqprop_##lockname##_sequence(const seqcount_##lockname##_t *s)	\
 	return seq;							\
 }									\
 									\
+static __always_inline unsigned						\
+__seqprop_##lockname##_sequence_acquire(const seqcount_##lockname##_t *s) \
+{									\
+	unsigned seq = smp_load_acquire(&s->seqcount.sequence);		\
+									\
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))				\
+		return seq;						\
+									\
+	if (preemptible && unlikely(seq & 1)) {				\
+		__SEQ_LOCK(lockbase##_lock(s->lock));			\
+		__SEQ_LOCK(lockbase##_unlock(s->lock));			\
+									\
+		/*							\
+		 * Re-read the sequence counter since the (possibly	\
+		 * preempted) writer made progress.			\
+		 */							\
+		seq = smp_load_acquire(&s->seqcount.sequence);		\
+	}								\
+									\
+	return seq;							\
+}									\
+									\
 static __always_inline bool						\
 __seqprop_##lockname##_preemptible(const seqcount_##lockname##_t *s)	\
 {									\
@@ -211,6 +233,11 @@ static inline unsigned __seqprop_sequence(const seqcount_t *s)
 	return READ_ONCE(s->sequence);
 }
 
+static inline unsigned __seqprop_sequence_acquire(const seqcount_t *s)
+{
+	return smp_load_acquire(&s->sequence);
+}
+
 static inline bool __seqprop_preemptible(const seqcount_t *s)
 {
 	return false;
@@ -259,6 +286,7 @@ SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     mutex)
 #define seqprop_ptr(s)			__seqprop(s, ptr)(s)
 #define seqprop_const_ptr(s)		__seqprop(s, const_ptr)(s)
 #define seqprop_sequence(s)		__seqprop(s, sequence)(s)
+#define seqprop_sequence_acquire(s)	__seqprop(s, sequence_acquire)(s)
 #define seqprop_preemptible(s)		__seqprop(s, preemptible)(s)
 #define seqprop_assert(s)		__seqprop(s, assert)(s)
 
@@ -293,6 +321,18 @@ SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     mutex)
  *
  * Return: count to be passed to read_seqcount_retry()
  */
+#ifdef CONFIG_ARCH_HAS_ACQUIRE_RELEASE
+#define raw_read_seqcount_begin(s)					\
+({									\
+	unsigned _seq;							\
+									\
+	while ((_seq = seqprop_sequence_acquire(s)) & 1)		\
+		cpu_relax();						\
+									\
+	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);			\
+	_seq;								\
+})
+#else
 #define raw_read_seqcount_begin(s)					\
 ({									\
 	unsigned _seq = __read_seqcount_begin(s);			\
@@ -300,6 +340,7 @@ SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     mutex)
 	smp_rmb();							\
 	_seq;								\
 })
+#endif
 
 /**
  * read_seqcount_begin() - begin a seqcount_t read critical section

---
base-commit: 6b4aa469f04999c3f244515fa7491b4d093c5167
change-id: 20240813-seq_optimize-68c48696c798

Best regards,
-- 
Christoph Lameter <cl@gentwo.org>



