Return-Path: <linux-kernel+bounces-270601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E635C9441F1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 05:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2472284302
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 03:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AC413DDC6;
	Thu,  1 Aug 2024 03:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AnKZ0mpl"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF89413D60B
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 03:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722483453; cv=none; b=n0LKWF8w4gAKXOrFFCxkXGIfUJqkzs5VdA3pYw71K54tlI2drjYMep0PcKtArNHs0JzFpwwa7Tq2fRIbRMf7MwMVrlFKY/HPgXIaiqsfGiJc/BFRGK4ur4bLAUqbovYAJ0FlvyQKIuHb2v5vQ4yOoy/cpaSr/+SrXSBFgg3yEME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722483453; c=relaxed/simple;
	bh=6wCU6BSNF4M973kE1vh030crOI9lGgN6DTdeCXfjRro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qwyA5n1EvN3ph5tXksmzFM5ia3WzvdBNf/Wogj4xbQrnY3KWPyyj8W8axo9N6dRlLsSYYJgbDGA+m7+Z0uoUsP2/IdqcJs7a1bA/3YYH3+xgr5nS1Qlg0DOYvHTJnyxY8dvYxCCWhKwINbXVKQUPJ3Vq36kuK/BaEvZFH41Qs/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=AnKZ0mpl; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7093d565310so5185736a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 20:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1722483450; x=1723088250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msVGAs2Ent9MgPGCzZ9Uq7gVj0jWgfLK/XRk8zdKP5o=;
        b=AnKZ0mplWNl1fFngI/qoApOzuEcdtxW7dtnFvxrb7zhzVlAXw9UdN5vMX7Azd4MkQN
         4lxRHC/nyiPEQ4+Cx8ubQX+Vr8zRqcTUSzCgqM25aDWIsT0kKp8+3oJ+6k8A0rQMG5AY
         VsOBaJQW36Q2zGaw4Jp58HLAZt45PxrDwv3ltI/WBe5GTfe98oz9YvmgNDWM8uuRIcDu
         7a9qnf9eX9XLfkzlCECimjJ0w6ROeOR44XE0hsmptIE5nzABaQe0fbvRNo2WPAJsrjoZ
         DgVl8xMgJoKWVXz+BaX2kWaa1exgb/QhxVwbbCOSgGF+YnnZOcZW0enWrKFy7qQ0J97/
         Aufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722483450; x=1723088250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=msVGAs2Ent9MgPGCzZ9Uq7gVj0jWgfLK/XRk8zdKP5o=;
        b=FAkUiMG2Y8z0EPnJMbwFKA8gQ2xtJvm2CY9dScpiB/RHPTebS8Muy+qBewSb+lrUIr
         kLDZIyAj0aEj5KdHkK4OKVcVxUyPhe9T6XepiS5MtLlGllAj+uudGNDTTQDF9h/LZJa0
         8wT9XRdQ1Xu0CVNK7BYdYZJlZf7X0WW3djA0ACxsqBpHX4ENSi6wbMTut2Qt4/cdJME9
         wDqh8AhDkamW67+S/LTk0Mx1V7YuUNjV5It/xJeRBUuQEmTQkpTDzSYkFGVDUDsSOwui
         mK13FrRGWcJb2KldKMF3XgjxLrXdrCte3YE/HUSNQpe+wGHwvpWcEqN7Ex/fIqxbuOyz
         OtRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOMCoh15mrD8AjguZMiKNj4piQiNANggLdUfNtknWzourYZyDV6OJO8uKdeR/z0rwfE20ncUG/LuDowBx7c9Kn7GY2/dcnJf3+IyRy
X-Gm-Message-State: AOJu0YzKBN04D587woisGiqrOjaWpHtlpceH4AbOJ13xb6kJPBlHqmPv
	fY5YUBEdmVTJiztVNri9GloU7XkN+gFN19haxcheolCjK+zUV8xx5dNKIkYsHbo=
X-Google-Smtp-Source: AGHT+IGP40Ax3lzWFlCGU0aTP1HPnWbwedEDfA5dMJhXTXtH06+s5sdbGtwoQDQnLakNYH4zfh8i/Q==
X-Received: by 2002:a05:6830:6189:b0:702:1dec:c8a0 with SMTP id 46e09a7af769-7096b7ae351mr1395710a34.6.1722483450554;
        Wed, 31 Jul 2024 20:37:30 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead72ae3asm10954457b3a.91.2024.07.31.20.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 20:37:30 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 2/2] riscv: Enable bitops instrumentation
Date: Wed, 31 Jul 2024 20:37:00 -0700
Message-ID: <20240801033725.28816-3-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240801033725.28816-1-samuel.holland@sifive.com>
References: <20240801033725.28816-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of implementing the bitops functions directly in assembly,
provide the arch_-prefixed versions and use the wrappers from
asm-generic to add instrumentation. This improves KASAN coverage and
fixes the kasan_bitops_generic() unit test.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/include/asm/bitops.h | 43 ++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
index 71af9ecfcfcb..fae152ea0508 100644
--- a/arch/riscv/include/asm/bitops.h
+++ b/arch/riscv/include/asm/bitops.h
@@ -222,44 +222,44 @@ static __always_inline int variable_fls(unsigned int x)
 #define __NOT(x)	(~(x))
 
 /**
- * test_and_set_bit - Set a bit and return its old value
+ * arch_test_and_set_bit - Set a bit and return its old value
  * @nr: Bit to set
  * @addr: Address to count from
  *
  * This operation may be reordered on other architectures than x86.
  */
-static inline int test_and_set_bit(int nr, volatile unsigned long *addr)
+static inline int arch_test_and_set_bit(int nr, volatile unsigned long *addr)
 {
 	return __test_and_op_bit(or, __NOP, nr, addr);
 }
 
 /**
- * test_and_clear_bit - Clear a bit and return its old value
+ * arch_test_and_clear_bit - Clear a bit and return its old value
  * @nr: Bit to clear
  * @addr: Address to count from
  *
  * This operation can be reordered on other architectures other than x86.
  */
-static inline int test_and_clear_bit(int nr, volatile unsigned long *addr)
+static inline int arch_test_and_clear_bit(int nr, volatile unsigned long *addr)
 {
 	return __test_and_op_bit(and, __NOT, nr, addr);
 }
 
 /**
- * test_and_change_bit - Change a bit and return its old value
+ * arch_test_and_change_bit - Change a bit and return its old value
  * @nr: Bit to change
  * @addr: Address to count from
  *
  * This operation is atomic and cannot be reordered.
  * It also implies a memory barrier.
  */
-static inline int test_and_change_bit(int nr, volatile unsigned long *addr)
+static inline int arch_test_and_change_bit(int nr, volatile unsigned long *addr)
 {
 	return __test_and_op_bit(xor, __NOP, nr, addr);
 }
 
 /**
- * set_bit - Atomically set a bit in memory
+ * arch_set_bit - Atomically set a bit in memory
  * @nr: the bit to set
  * @addr: the address to start counting from
  *
@@ -270,13 +270,13 @@ static inline int test_and_change_bit(int nr, volatile unsigned long *addr)
  * Note that @nr may be almost arbitrarily large; this function is not
  * restricted to acting on a single-word quantity.
  */
-static inline void set_bit(int nr, volatile unsigned long *addr)
+static inline void arch_set_bit(int nr, volatile unsigned long *addr)
 {
 	__op_bit(or, __NOP, nr, addr);
 }
 
 /**
- * clear_bit - Clears a bit in memory
+ * arch_clear_bit - Clears a bit in memory
  * @nr: Bit to clear
  * @addr: Address to start counting from
  *
@@ -284,13 +284,13 @@ static inline void set_bit(int nr, volatile unsigned long *addr)
  * on non x86 architectures, so if you are writing portable code,
  * make sure not to rely on its reordering guarantees.
  */
-static inline void clear_bit(int nr, volatile unsigned long *addr)
+static inline void arch_clear_bit(int nr, volatile unsigned long *addr)
 {
 	__op_bit(and, __NOT, nr, addr);
 }
 
 /**
- * change_bit - Toggle a bit in memory
+ * arch_change_bit - Toggle a bit in memory
  * @nr: Bit to change
  * @addr: Address to start counting from
  *
@@ -298,40 +298,40 @@ static inline void clear_bit(int nr, volatile unsigned long *addr)
  * Note that @nr may be almost arbitrarily large; this function is not
  * restricted to acting on a single-word quantity.
  */
-static inline void change_bit(int nr, volatile unsigned long *addr)
+static inline void arch_change_bit(int nr, volatile unsigned long *addr)
 {
 	__op_bit(xor, __NOP, nr, addr);
 }
 
 /**
- * test_and_set_bit_lock - Set a bit and return its old value, for lock
+ * arch_test_and_set_bit_lock - Set a bit and return its old value, for lock
  * @nr: Bit to set
  * @addr: Address to count from
  *
  * This operation is atomic and provides acquire barrier semantics.
  * It can be used to implement bit locks.
  */
-static inline int test_and_set_bit_lock(
+static inline int arch_test_and_set_bit_lock(
 	unsigned long nr, volatile unsigned long *addr)
 {
 	return __test_and_op_bit_ord(or, __NOP, nr, addr, .aq);
 }
 
 /**
- * clear_bit_unlock - Clear a bit in memory, for unlock
+ * arch_clear_bit_unlock - Clear a bit in memory, for unlock
  * @nr: the bit to set
  * @addr: the address to start counting from
  *
  * This operation is atomic and provides release barrier semantics.
  */
-static inline void clear_bit_unlock(
+static inline void arch_clear_bit_unlock(
 	unsigned long nr, volatile unsigned long *addr)
 {
 	__op_bit_ord(and, __NOT, nr, addr, .rl);
 }
 
 /**
- * __clear_bit_unlock - Clear a bit in memory, for unlock
+ * arch___clear_bit_unlock - Clear a bit in memory, for unlock
  * @nr: the bit to set
  * @addr: the address to start counting from
  *
@@ -345,13 +345,13 @@ static inline void clear_bit_unlock(
  * non-atomic property here: it's a lot more instructions and we still have to
  * provide release semantics anyway.
  */
-static inline void __clear_bit_unlock(
+static inline void arch___clear_bit_unlock(
 	unsigned long nr, volatile unsigned long *addr)
 {
-	clear_bit_unlock(nr, addr);
+	arch_clear_bit_unlock(nr, addr);
 }
 
-static inline bool xor_unlock_is_negative_byte(unsigned long mask,
+static inline bool arch_xor_unlock_is_negative_byte(unsigned long mask,
 		volatile unsigned long *addr)
 {
 	unsigned long res;
@@ -369,6 +369,9 @@ static inline bool xor_unlock_is_negative_byte(unsigned long mask,
 #undef __NOT
 #undef __AMO
 
+#include <asm-generic/bitops/instrumented-atomic.h>
+#include <asm-generic/bitops/instrumented-lock.h>
+
 #include <asm-generic/bitops/non-atomic.h>
 #include <asm-generic/bitops/le.h>
 #include <asm-generic/bitops/ext2-atomic.h>
-- 
2.45.1


