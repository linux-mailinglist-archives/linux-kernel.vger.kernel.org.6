Return-Path: <linux-kernel+bounces-272091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C74489456D6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 06:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02CDEB236CE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 04:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0DD1803E;
	Fri,  2 Aug 2024 04:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nl2f2fRW"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70A71EB4AE
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 04:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722571531; cv=none; b=ilzhawz2ZFoKZXSerB8PbDcbHq7JPPMol3sdGE1G0OHLQuLM2STURguRVJ+rZJ1wsCAeznjhzecNsI98PrCdh4FoP8CrVp6i2UW7+f5jGP8UsExJAHvkxCPYk+6xThzIPHLV5SGM7aO4wZ/x0WVQIP4rxGscCtFtaRXwAK/On74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722571531; c=relaxed/simple;
	bh=GpdLUP/O/bKTnyFsSci0JeQBzftgzymmALiLcNSy4Ms=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t3ABr4AyDY98VSBdn0T2DpY6ahClXhaFNzsBkOyFwNv12dmdnsxvmzTdCJeKWoxMtvENfMd2VPYv0Wt94pM5qg0Nyxu+13FDGB6rdZbwAbRBvwlVZauBvrWdEama7gZvXHBH3MJRc4zqIg/NEEChmkt5J24MRFmJMgCkYzHzmC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nl2f2fRW; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-709428a9469so4338815a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 21:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722571529; x=1723176329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vCaSe5jBDmfLQ7UtNKeC+GSnHOUZU+L2Md+6S25fGyc=;
        b=nl2f2fRWQA+QxPUJYqVSugLzKfdvkhZXdiyYKw/8juBhF8g904sTVOGueiLwFdJYWc
         l/oqPA5crSdLkKT4c2K0bLZ8hen6kcy60it2ZfBR4p9FWjdAIygd6YiWDxjliezM3Myt
         E8rM3afd6RiJgqVWWQGO4J8IU4/6c2uOJo4w26UoAf7rWP4WHa/lwurJNmwlzTIzmFZr
         8VWzef56UF565MI/D+yVEeLQrD2JmMBlxTPSRKd8nCHiotV07IQ1PEtybLkWVWy6nSgn
         ys2A2zxZ9RHrIGyEAde4coMZH7BLcb1R1r+7LMnZ1K9hZ3PDL07Rlf/VnbngbL7WnOaF
         Smbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722571529; x=1723176329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vCaSe5jBDmfLQ7UtNKeC+GSnHOUZU+L2Md+6S25fGyc=;
        b=XW1fJLiN+ECeDRW5BOnj61fuyjPU2vbDrj5fqfk01fnoqO5P7pvxqBnyEHcqPOvvvJ
         A0bUMDN8dnBHFc6mlMH3mLG0PXuD+txwVL3IUz7ZIcxR/9uSqB4prCQ1yj4v6/xiQwrM
         Pv/Cl8MGcGMfc6s8rd1N+5BrkzHkFSlfa26Vy1lAwMAH4wjW2vpxsaak9ZtlSnuC/BgX
         5D4n2JZTYQsipATQZQZv55UkUjoXBvX9cOUQAsU5NtN8C7iRTf4yJHpn/X8POGqY0hMn
         3WO+4H9ZQpyXWvjJokyzWeluace8Vo/AH+G+oAXZ6elblj5pwr+enARpzxmXVL6wpJHZ
         X6Pw==
X-Forwarded-Encrypted: i=1; AJvYcCWhhcldoTxEK8/ohWhPaaWHfiIwTcvh1XHZWzp58CVWkCWJQJqlg1ej/kFSAtWJaIbEbBvS+/bL6/YQU6Xseoew6qFRKllJrlHjXgzx
X-Gm-Message-State: AOJu0YywRo8Ea5R2ln7+wVvenw06VCsxPYx4WjEWrgYbAcQeVqhzxnCA
	G7qrbJ71CZPrwpxcDh5Dj1EJZDgw+4OQsKvOqvc2SXR6h7rsBq+/
X-Google-Smtp-Source: AGHT+IG7pVxT5JsqTRcIcEFhSeMR1Ue5oY3cdSzXsrIAPd10/0lOhP13GCp/O4x0EAT3+0JAPj1qLw==
X-Received: by 2002:a05:6830:f89:b0:708:b46d:5c76 with SMTP id 46e09a7af769-709b3245aefmr2143230a34.17.1722571528735;
        Thu, 01 Aug 2024 21:05:28 -0700 (PDT)
Received: from gmail.com ([2a09:bac5:80c9:78::c:349])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b7654beb1csm554813a12.93.2024.08.01.21.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 21:05:28 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: Qingfang Deng <qingfang.deng@siflower.com.cn>
Subject: [PATCH] riscv: support KASAN instrumentation of bitops
Date: Fri,  2 Aug 2024 12:05:06 +0800
Message-Id: <20240802040506.712-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qingfang Deng <qingfang.deng@siflower.com.cn>

The arch-specific bitops are not being picked up by the KASAN test
suite.

Instrumentation is done via the bitops/instrumented-{atomic,lock}.h
headers. They require that arch-specific versions of bitop functions
are renamed to arch_*. Do this renaming.

As most comments are identical to the ones in the instrumented headers,
remove them.

Signed-off-by: Qingfang Deng <qingfang.deng@siflower.com.cn>
---
 arch/riscv/include/asm/bitops.h | 100 +++++---------------------------
 1 file changed, 15 insertions(+), 85 deletions(-)

diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
index 71af9ecfcfcb..44ff3114c112 100644
--- a/arch/riscv/include/asm/bitops.h
+++ b/arch/riscv/include/asm/bitops.h
@@ -221,134 +221,62 @@ static __always_inline int variable_fls(unsigned int x)
 #define __NOP(x)	(x)
 #define __NOT(x)	(~(x))
 
-/**
- * test_and_set_bit - Set a bit and return its old value
- * @nr: Bit to set
- * @addr: Address to count from
- *
- * This operation may be reordered on other architectures than x86.
- */
-static inline int test_and_set_bit(int nr, volatile unsigned long *addr)
+static inline int arch_test_and_set_bit(int nr, volatile unsigned long *addr)
 {
 	return __test_and_op_bit(or, __NOP, nr, addr);
 }
 
-/**
- * test_and_clear_bit - Clear a bit and return its old value
- * @nr: Bit to clear
- * @addr: Address to count from
- *
- * This operation can be reordered on other architectures other than x86.
- */
-static inline int test_and_clear_bit(int nr, volatile unsigned long *addr)
+static inline int arch_test_and_clear_bit(int nr, volatile unsigned long *addr)
 {
 	return __test_and_op_bit(and, __NOT, nr, addr);
 }
 
-/**
- * test_and_change_bit - Change a bit and return its old value
- * @nr: Bit to change
- * @addr: Address to count from
- *
- * This operation is atomic and cannot be reordered.
- * It also implies a memory barrier.
- */
-static inline int test_and_change_bit(int nr, volatile unsigned long *addr)
+static inline int arch_test_and_change_bit(int nr, volatile unsigned long *addr)
 {
 	return __test_and_op_bit(xor, __NOP, nr, addr);
 }
 
-/**
- * set_bit - Atomically set a bit in memory
- * @nr: the bit to set
- * @addr: the address to start counting from
- *
- * Note: there are no guarantees that this function will not be reordered
- * on non x86 architectures, so if you are writing portable code,
- * make sure not to rely on its reordering guarantees.
- *
- * Note that @nr may be almost arbitrarily large; this function is not
- * restricted to acting on a single-word quantity.
- */
-static inline void set_bit(int nr, volatile unsigned long *addr)
+static inline void arch_set_bit(int nr, volatile unsigned long *addr)
 {
 	__op_bit(or, __NOP, nr, addr);
 }
 
-/**
- * clear_bit - Clears a bit in memory
- * @nr: Bit to clear
- * @addr: Address to start counting from
- *
- * Note: there are no guarantees that this function will not be reordered
- * on non x86 architectures, so if you are writing portable code,
- * make sure not to rely on its reordering guarantees.
- */
-static inline void clear_bit(int nr, volatile unsigned long *addr)
+static inline void arch_clear_bit(int nr, volatile unsigned long *addr)
 {
 	__op_bit(and, __NOT, nr, addr);
 }
 
-/**
- * change_bit - Toggle a bit in memory
- * @nr: Bit to change
- * @addr: Address to start counting from
- *
- * change_bit()  may be reordered on other architectures than x86.
- * Note that @nr may be almost arbitrarily large; this function is not
- * restricted to acting on a single-word quantity.
- */
-static inline void change_bit(int nr, volatile unsigned long *addr)
+static inline void arch_change_bit(int nr, volatile unsigned long *addr)
 {
 	__op_bit(xor, __NOP, nr, addr);
 }
 
-/**
- * test_and_set_bit_lock - Set a bit and return its old value, for lock
- * @nr: Bit to set
- * @addr: Address to count from
- *
- * This operation is atomic and provides acquire barrier semantics.
- * It can be used to implement bit locks.
- */
-static inline int test_and_set_bit_lock(
+static inline int arch_test_and_set_bit_lock(
 	unsigned long nr, volatile unsigned long *addr)
 {
 	return __test_and_op_bit_ord(or, __NOP, nr, addr, .aq);
 }
 
-/**
- * clear_bit_unlock - Clear a bit in memory, for unlock
- * @nr: the bit to set
- * @addr: the address to start counting from
- *
- * This operation is atomic and provides release barrier semantics.
- */
-static inline void clear_bit_unlock(
+static inline void arch_clear_bit_unlock(
 	unsigned long nr, volatile unsigned long *addr)
 {
 	__op_bit_ord(and, __NOT, nr, addr, .rl);
 }
 
 /**
- * __clear_bit_unlock - Clear a bit in memory, for unlock
- * @nr: the bit to set
- * @addr: the address to start counting from
+ * arch___clear_bit_unlock - Clear a bit in memory, for unlock
  *
- * This operation is like clear_bit_unlock, however it is not atomic.
- * It does provide release barrier semantics so it can be used to unlock
- * a bit lock, however it would only be used if no other CPU can modify
- * any bits in the memory until the lock is released (a good example is
- * if the bit lock itself protects access to the other bits in the word).
+ * This should not be used directly, use the instrumented __clear_bit_unlock
+ * instead. See asm-generic/bitops/instrumented-lock.h
  *
  * On RISC-V systems there seems to be no benefit to taking advantage of the
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
 
 static inline bool xor_unlock_is_negative_byte(unsigned long mask,
@@ -369,6 +297,8 @@ static inline bool xor_unlock_is_negative_byte(unsigned long mask,
 #undef __NOT
 #undef __AMO
 
+#include <asm-generic/bitops/instrumented-atomic.h>
+#include <asm-generic/bitops/instrumented-lock.h>
 #include <asm-generic/bitops/non-atomic.h>
 #include <asm-generic/bitops/le.h>
 #include <asm-generic/bitops/ext2-atomic.h>
-- 
2.34.1


