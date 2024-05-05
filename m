Return-Path: <linux-kernel+bounces-168971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A178BC063
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 14:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B1B01C20A6F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 12:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC241804A;
	Sun,  5 May 2024 12:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cl/2yQvF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27858A21
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 12:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714912454; cv=none; b=cViRS8feEptdgoarzAi03FL2OyhFLtbE5QqBj0jLeX73HsURDuEaa+Oz3cqYkaAYQ9E1PtSBspLiYXXE5kVWpEeHzRyb2oaJEryH5tOhSVUXxZh+9i69V5UOOsFNBubAGa/iocWBOsEptPhLeYlVF0cTyDiYzV/0vgIiAj66tYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714912454; c=relaxed/simple;
	bh=wz+6IsEcn6LI+h0NmGwwasc9Ns0cbM/wBeFTv4gFEqU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p+V49EERUWyIqsbxfO5BD1c5UInZ98+n23+kx22EKBx87yPf/FUQZPGebTuBltApguLowMvMLOa1qifXqss5QZDfIxodBXCsPL/fHBLue+pYcYipnyHohLLXRysX9TTojta1EW1SNaLnZ39Zv2CwO5gK4CEaGpixV4B4tqlqIB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cl/2yQvF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1ABC113CC;
	Sun,  5 May 2024 12:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714912453;
	bh=wz+6IsEcn6LI+h0NmGwwasc9Ns0cbM/wBeFTv4gFEqU=;
	h=From:To:Cc:Subject:Date:From;
	b=cl/2yQvF5CdVSqf3VIXcreHrM3u0luplWToFnRESPNukpIo0tZEH4F/YwnOyxYKDR
	 Gd/ljuiwSa1AeA8F0Ake2FPTph4coQz7GUbyvgp67NwmDJ5glGt1gxHGoD1cXCykhl
	 2QiEG29gcIHfsOLZ/ka7Zl0YBPSeoH+1Z1CBNJLBQI1KrJEoA4MYv4ZvMxoJCWAwpO
	 9AmceNDq7a3tyOg/nIZwpjx3rE8kmGMDxkQot2nbgR6ZI1cZGUN/Xs0h3mvwVPTp06
	 tmvXqocbUg7ZGA2hj77GWz6zjL7COqrkeb/pXNeDMu+45MmVy/f5Mnpi6n8k9pOA3H
	 /GhWbdC6dAPyw==
From: Puranjay Mohan <puranjay@kernel.org>
To: Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: puranjay12@gmail.com
Subject: [PATCH] riscv/atomic.h: optimize ops with acquire/release ordering
Date: Sun,  5 May 2024 12:33:40 +0000
Message-Id: <20240505123340.38495-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, atomic ops with acquire or release ordering are implemented
as atomic ops with relaxed ordering followed by or preceded by an
acquire fence or a release fence.

Section 8.1 of the "The RISC-V Instruction Set Manual Volume I:
Unprivileged ISA", titled, "Specifying Ordering of Atomic Instructions"
says:

| To provide more efficient support for release consistency [5], each
| atomic instruction has two bits, aq and rl, used to specify additional
| memory ordering constraints as viewed by other RISC-V harts.

and

| If only the aq bit is set, the atomic memory operation is treated as
| an acquire access.
| If only the rl bit is set, the atomic memory operation is treated as a
| release access.

So, rather than using two instructions (relaxed atomic op + fence), use
a single atomic op instruction with acquire/release ordering.

Example program:

  atomic_t cnt = ATOMIC_INIT(0);
  atomic_fetch_add_acquire(1, &cnt);
  atomic_fetch_add_release(1, &cnt);

Before:

  amoadd.w        a4,a5,(a4)  // Atomic add with relaxed ordering
  fence   r,rw                // Fence to force Acquire ordering

  fence   rw,w                // Fence to force Release ordering
  amoadd.w        a4,a5,(a4)  // Atomic add with relaxed ordering

After:

  amoadd.w.aq     a4,a5,(a4)  // Atomic add with Acquire ordering

  amoadd.w.rl     a4,a5,(a4)  // Atomic add with Release ordering

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/riscv/include/asm/atomic.h | 64 +++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index 5b96c2f61adb..024e83936910 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -98,6 +98,30 @@ c_type arch_atomic##prefix##_fetch_##op##_relaxed(c_type i,		\
 	return ret;							\
 }									\
 static __always_inline							\
+c_type arch_atomic##prefix##_fetch_##op##_acquire(c_type i,		\
+					     atomic##prefix##_t *v)	\
+{									\
+	register c_type ret;						\
+	__asm__ __volatile__ (						\
+		"	amo" #asm_op "." #asm_type ".aq %1, %2, %0"	\
+		: "+A" (v->counter), "=r" (ret)				\
+		: "r" (I)						\
+		: "memory");						\
+	return ret;							\
+}									\
+static __always_inline							\
+c_type arch_atomic##prefix##_fetch_##op##_release(c_type i,		\
+					     atomic##prefix##_t *v)	\
+{									\
+	register c_type ret;						\
+	__asm__ __volatile__ (						\
+		"	amo" #asm_op "." #asm_type ".rl %1, %2, %0"	\
+		: "+A" (v->counter), "=r" (ret)				\
+		: "r" (I)						\
+		: "memory");						\
+	return ret;							\
+}									\
+static __always_inline							\
 c_type arch_atomic##prefix##_fetch_##op(c_type i, atomic##prefix##_t *v)	\
 {									\
 	register c_type ret;						\
@@ -117,6 +141,18 @@ c_type arch_atomic##prefix##_##op##_return_relaxed(c_type i,		\
         return arch_atomic##prefix##_fetch_##op##_relaxed(i, v) c_op I;	\
 }									\
 static __always_inline							\
+c_type arch_atomic##prefix##_##op##_return_acquire(c_type i,		\
+					      atomic##prefix##_t *v)	\
+{									\
+	return arch_atomic##prefix##_fetch_##op##_acquire(i, v) c_op I;	\
+}									\
+static __always_inline							\
+c_type arch_atomic##prefix##_##op##_return_release(c_type i,		\
+					      atomic##prefix##_t *v)	\
+{									\
+	return arch_atomic##prefix##_fetch_##op##_release(i, v) c_op I;	\
+}									\
+static __always_inline							\
 c_type arch_atomic##prefix##_##op##_return(c_type i, atomic##prefix##_t *v)	\
 {									\
         return arch_atomic##prefix##_fetch_##op(i, v) c_op I;		\
@@ -138,23 +174,39 @@ ATOMIC_OPS(add, add, +,  i)
 ATOMIC_OPS(sub, add, +, -i)
 
 #define arch_atomic_add_return_relaxed	arch_atomic_add_return_relaxed
+#define arch_atomic_add_return_acquire	arch_atomic_add_return_acquire
+#define arch_atomic_add_return_release	arch_atomic_add_return_release
 #define arch_atomic_sub_return_relaxed	arch_atomic_sub_return_relaxed
+#define arch_atomic_sub_return_acquire	arch_atomic_sub_return_acquire
+#define arch_atomic_sub_return_release	arch_atomic_sub_return_release
 #define arch_atomic_add_return		arch_atomic_add_return
 #define arch_atomic_sub_return		arch_atomic_sub_return
 
 #define arch_atomic_fetch_add_relaxed	arch_atomic_fetch_add_relaxed
+#define arch_atomic_fetch_add_acquire	arch_atomic_fetch_add_acquire
+#define arch_atomic_fetch_add_release	arch_atomic_fetch_add_release
 #define arch_atomic_fetch_sub_relaxed	arch_atomic_fetch_sub_relaxed
+#define arch_atomic_fetch_sub_acquire	arch_atomic_fetch_sub_acquire
+#define arch_atomic_fetch_sub_release	arch_atomic_fetch_sub_release
 #define arch_atomic_fetch_add		arch_atomic_fetch_add
 #define arch_atomic_fetch_sub		arch_atomic_fetch_sub
 
 #ifndef CONFIG_GENERIC_ATOMIC64
 #define arch_atomic64_add_return_relaxed	arch_atomic64_add_return_relaxed
+#define arch_atomic64_add_return_acquire	arch_atomic64_add_return_acquire
+#define arch_atomic64_add_return_release	arch_atomic64_add_return_release
 #define arch_atomic64_sub_return_relaxed	arch_atomic64_sub_return_relaxed
+#define arch_atomic64_sub_return_acquire	arch_atomic64_sub_return_acquire
+#define arch_atomic64_sub_return_release	arch_atomic64_sub_return_release
 #define arch_atomic64_add_return		arch_atomic64_add_return
 #define arch_atomic64_sub_return		arch_atomic64_sub_return
 
 #define arch_atomic64_fetch_add_relaxed	arch_atomic64_fetch_add_relaxed
+#define arch_atomic64_fetch_add_acquire	arch_atomic64_fetch_add_acquire
+#define arch_atomic64_fetch_add_release	arch_atomic64_fetch_add_release
 #define arch_atomic64_fetch_sub_relaxed	arch_atomic64_fetch_sub_relaxed
+#define arch_atomic64_fetch_sub_acquire	arch_atomic64_fetch_sub_acquire
+#define arch_atomic64_fetch_sub_release	arch_atomic64_fetch_sub_release
 #define arch_atomic64_fetch_add		arch_atomic64_fetch_add
 #define arch_atomic64_fetch_sub		arch_atomic64_fetch_sub
 #endif
@@ -175,16 +227,28 @@ ATOMIC_OPS( or,  or, i)
 ATOMIC_OPS(xor, xor, i)
 
 #define arch_atomic_fetch_and_relaxed	arch_atomic_fetch_and_relaxed
+#define arch_atomic_fetch_and_acquire	arch_atomic_fetch_and_acquire
+#define arch_atomic_fetch_and_release	arch_atomic_fetch_and_release
 #define arch_atomic_fetch_or_relaxed	arch_atomic_fetch_or_relaxed
+#define arch_atomic_fetch_or_acquire	arch_atomic_fetch_or_acquire
+#define arch_atomic_fetch_or_release	arch_atomic_fetch_or_release
 #define arch_atomic_fetch_xor_relaxed	arch_atomic_fetch_xor_relaxed
+#define arch_atomic_fetch_xor_acquire	arch_atomic_fetch_xor_acquire
+#define arch_atomic_fetch_xor_release	arch_atomic_fetch_xor_release
 #define arch_atomic_fetch_and		arch_atomic_fetch_and
 #define arch_atomic_fetch_or		arch_atomic_fetch_or
 #define arch_atomic_fetch_xor		arch_atomic_fetch_xor
 
 #ifndef CONFIG_GENERIC_ATOMIC64
 #define arch_atomic64_fetch_and_relaxed	arch_atomic64_fetch_and_relaxed
+#define arch_atomic64_fetch_and_acquire	arch_atomic64_fetch_and_acquire
+#define arch_atomic64_fetch_and_release	arch_atomic64_fetch_and_release
 #define arch_atomic64_fetch_or_relaxed	arch_atomic64_fetch_or_relaxed
+#define arch_atomic64_fetch_or_acquire	arch_atomic64_fetch_or_acquire
+#define arch_atomic64_fetch_or_release	arch_atomic64_fetch_or_release
 #define arch_atomic64_fetch_xor_relaxed	arch_atomic64_fetch_xor_relaxed
+#define arch_atomic64_fetch_xor_acquire	arch_atomic64_fetch_xor_acquire
+#define arch_atomic64_fetch_xor_release	arch_atomic64_fetch_xor_release
 #define arch_atomic64_fetch_and		arch_atomic64_fetch_and
 #define arch_atomic64_fetch_or		arch_atomic64_fetch_or
 #define arch_atomic64_fetch_xor		arch_atomic64_fetch_xor
-- 
2.40.1


