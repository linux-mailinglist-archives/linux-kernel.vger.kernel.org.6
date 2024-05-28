Return-Path: <linux-kernel+bounces-192646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C7A8D2020
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25ADC286AF9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E867171E68;
	Tue, 28 May 2024 15:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="B/2cJVLe"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110D6282FA
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 15:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716909363; cv=none; b=Q6KDnSktW4FcPZq5u+mAYJg31++68LQDiGh71dw5qocILA4QOXLis1/CPMGdwMkHb3Q2yHsfUOZ4lvRG0Z1/zgzjM4QnoEp2mF6b3YKawECsm0fjwE0qdby8R6P8y0vTbtAzRvw6V73EGxQUsdQvluiAZP25gUAI47QrIXwSgaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716909363; c=relaxed/simple;
	bh=zIctHSF8s4ycH2M1Xuee5DajFIDyCPEPGL7Vxs9tOR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TDETqNBATFR+vhY/Vt3x6xBU6UzmMIIb0/d5ixk4dDSaJQ9nFP9XGb2aQ71Ya5RobHfp2IZ72QwLRlt3FTU+IsqMkw03sFksgI1Nqw7NEVc0JgEeLSmCvfoezL0dGYUBBw8F6gmwFc93haMhUsZCYNDnZkX9HZmXHDjpYzDfq1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=B/2cJVLe; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42121d27861so248885e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 08:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716909360; x=1717514160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=heAbIXv1oMx4SoDoWG1mJ8ALiEwmwn+mI3czPDKQjFY=;
        b=B/2cJVLeRvjhR6DtdsavZO5f1aH9SugqzUFIN6bfi7wqkO7BbNkCgyuud9c/WcgcFB
         DNo6vfe3CsksekPdbp+cp00dihZqdQgf0fSLPkKpEJ3su1vbVGAxMtMzsJIGJNWFU7ww
         zSCw0uMIltcXh/TtfIk+becgE2awNSoxLPMpn5pTJnEsLQod1RIsyuknJPprOsEF1W4X
         Kt2xWSWD3iTXsS5ORWV3QEEM2/X3/jAGisD+6p2TR1rmyzSxzqrF1kf5ealpxywFmkEK
         N3mDi5rqgucKvpUu0PNNkZGFM+JC0dKv2V9W3++exx18BTHiwg2a4syRW4GI7R6iUvdr
         7zzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716909360; x=1717514160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=heAbIXv1oMx4SoDoWG1mJ8ALiEwmwn+mI3czPDKQjFY=;
        b=VMwNx/XeNo/iOTOqr7UAi/hVT8xTZykXJiBxkmB3sgRcmL4/zWyx7NNuy4BQYcOYSc
         EkIYSWYrlYtbfzPgYHuX7IRF/AqDwUnDP1f6uy8Hpj69fUuAcXz9jbomHzhKgilqKmNB
         DL8nTe2ZdOZt1cfjLG11Y/KuAfMvoRH+/mlsfa4wkKVynhmuw+Ci9N7Tu2t1b1Wx6zbZ
         sbfF4EZUgszvUHhTCXVXLXZ2LsmSPFVA+TmPhgCf9RUm5U2tkQgwDY1m8r/XEVeNlSDW
         0vdJ6gAwLORc+91BvTMOWsxMRpc89vdJ/6CjiCNGJehgZReADnIhfYGftx9kpiy3x8uE
         2LWg==
X-Forwarded-Encrypted: i=1; AJvYcCViQQoPiMH3UXfor65XG9GebkxbJxGHnVW8IVB/GDWly9JWfpZgwNxQWuXsjnIIxdkhEsa/DMpckle7K09GG1jvzs2oogh4Vmlzzxc0
X-Gm-Message-State: AOJu0Yw4PJBpOjv9nbKI9oUw7cE2NL/+sCqWR3Dm1J2DVkkangEatwLq
	pGkVrN8FWOK6biqWTfZu9g2egAq+mGlLHmJhdXlQQlBpt9HLcKqbNWrPK1ElRR4=
X-Google-Smtp-Source: AGHT+IFjBUzptjD+yaaIGtCtzbT9/u6NhvlOiOfogXGTAn3lVdgJuuRzm1ZS7bzwllyXZTKIP0WObg==
X-Received: by 2002:a05:600c:45cd:b0:420:29dd:84db with SMTP id 5b1f17b1804b1-42108a26c56mr116889895e9.35.1716909360501;
        Tue, 28 May 2024 08:16:00 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108970b4esm146682755e9.14.2024.05.28.08.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 08:16:00 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org
Cc: Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 5/7] asm-generic: ticket-lock: Reuse arch_spinlock_t of qspinlock
Date: Tue, 28 May 2024 17:10:50 +0200
Message-Id: <20240528151052.313031-6-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240528151052.313031-1-alexghiti@rivosinc.com>
References: <20240528151052.313031-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guo Ren <guoren@linux.alibaba.com>

The arch_spinlock_t of qspinlock has contained the atomic_t val, which
satisfies the ticket-lock requirement. Thus, unify the arch_spinlock_t
into qspinlock_types.h. This is the preparation for the next combo
spinlock.

Reviewed-by: Leonardo Bras <leobras@redhat.com>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/linux-riscv/CAK8P3a2rnz9mQqhN6-e0CGUUv9rntRELFdxt_weiD7FxH7fkfQ@mail.gmail.com/
Signed-off-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 include/asm-generic/spinlock.h       | 14 +++++++-------
 include/asm-generic/spinlock_types.h | 12 ++----------
 2 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinlock.h
index 90803a826ba0..4773334ee638 100644
--- a/include/asm-generic/spinlock.h
+++ b/include/asm-generic/spinlock.h
@@ -32,7 +32,7 @@
 
 static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
 {
-	u32 val = atomic_fetch_add(1<<16, lock);
+	u32 val = atomic_fetch_add(1<<16, &lock->val);
 	u16 ticket = val >> 16;
 
 	if (ticket == (u16)val)
@@ -46,31 +46,31 @@ static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
 	 * have no outstanding writes due to the atomic_fetch_add() the extra
 	 * orderings are free.
 	 */
-	atomic_cond_read_acquire(lock, ticket == (u16)VAL);
+	atomic_cond_read_acquire(&lock->val, ticket == (u16)VAL);
 	smp_mb();
 }
 
 static __always_inline bool arch_spin_trylock(arch_spinlock_t *lock)
 {
-	u32 old = atomic_read(lock);
+	u32 old = atomic_read(&lock->val);
 
 	if ((old >> 16) != (old & 0xffff))
 		return false;
 
-	return atomic_try_cmpxchg(lock, &old, old + (1<<16)); /* SC, for RCsc */
+	return atomic_try_cmpxchg(&lock->val, &old, old + (1<<16)); /* SC, for RCsc */
 }
 
 static __always_inline void arch_spin_unlock(arch_spinlock_t *lock)
 {
 	u16 *ptr = (u16 *)lock + IS_ENABLED(CONFIG_CPU_BIG_ENDIAN);
-	u32 val = atomic_read(lock);
+	u32 val = atomic_read(&lock->val);
 
 	smp_store_release(ptr, (u16)val + 1);
 }
 
 static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
 {
-	u32 val = lock.counter;
+	u32 val = lock.val.counter;
 
 	return ((val >> 16) == (val & 0xffff));
 }
@@ -84,7 +84,7 @@ static __always_inline int arch_spin_is_locked(arch_spinlock_t *lock)
 
 static __always_inline int arch_spin_is_contended(arch_spinlock_t *lock)
 {
-	u32 val = atomic_read(lock);
+	u32 val = atomic_read(&lock->val);
 
 	return (s16)((val >> 16) - (val & 0xffff)) > 1;
 }
diff --git a/include/asm-generic/spinlock_types.h b/include/asm-generic/spinlock_types.h
index 8962bb730945..f534aa5de394 100644
--- a/include/asm-generic/spinlock_types.h
+++ b/include/asm-generic/spinlock_types.h
@@ -3,15 +3,7 @@
 #ifndef __ASM_GENERIC_SPINLOCK_TYPES_H
 #define __ASM_GENERIC_SPINLOCK_TYPES_H
 
-#include <linux/types.h>
-typedef atomic_t arch_spinlock_t;
-
-/*
- * qrwlock_types depends on arch_spinlock_t, so we must typedef that before the
- * include.
- */
-#include <asm/qrwlock_types.h>
-
-#define __ARCH_SPIN_LOCK_UNLOCKED	ATOMIC_INIT(0)
+#include <asm-generic/qspinlock_types.h>
+#include <asm-generic/qrwlock_types.h>
 
 #endif /* __ASM_GENERIC_SPINLOCK_TYPES_H */
-- 
2.39.2


