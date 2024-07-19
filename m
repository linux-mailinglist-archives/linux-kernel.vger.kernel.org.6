Return-Path: <linux-kernel+bounces-256923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D11493728F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 04:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 408B41C20D45
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 02:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65532168D0;
	Fri, 19 Jul 2024 02:40:18 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D395111AD
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 02:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721356817; cv=none; b=m02Sa+IlId3kiWxysB6QIfvsNXcRUf5mrVB3j5pbwqs/IJ0GlJlwwr20gamMu+TEcv4433kb6sSOYQ8mSFJvTXwWLzw6VzpY53+BhaEAQ0KX7cLyzvbJaiFkIGRC+tr630z6cFfF8hkkr9sA89EyuIiY+cWcAuDtEZGsWfF1Ej0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721356817; c=relaxed/simple;
	bh=9PGdc9yXjqr5VPvJBiRp7h/ChaUGFUYpjrxTkEGeAFo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=antZNSPtPqzfoZfy2JgE2zziuDbeRwJiJLOMeU/eDhnAAFHqApy8I55QI8tsazYtjgFl0iS+7k1Ydr1bQy25CVWT6uj7NNfL7Z7hngolf+pVRcCZm69Dtd7A9FCaj71mOAEx37JV0lCKjUXx+RFQ6e2nsHcLpZQw91hOXq3pEtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Ax3eoM0plm+d8AAA--.4571S3;
	Fri, 19 Jul 2024 10:40:12 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxWcYL0plmiutOAA--.45516S2;
	Fri, 19 Jul 2024 10:40:11 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] locking/atomic: scripts: Fix type error in macro try_cmpxchg
Date: Fri, 19 Jul 2024 10:40:10 +0800
Message-Id: <20240719024010.3296488-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxWcYL0plmiutOAA--.45516S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

When porting pv spinlock function on LoongArch system, there is
compiling error such as:
                 from linux/include/linux/smp.h:13,
                 from linux/kernel/locking/qspinlock.c:16:
linux/kernel/locking/qspinlock_paravirt.h: In function 'pv_kick_node':
linux/include/linux/atomic/atomic-arch-fallback.h:242:34: error: initialization of 'u8 *' {aka 'unsigned char *'} from incompatible pointer type 'enum vcpu_state *' [-Wincompatible-pointer-types]
  242 |         typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
      |                                  ^
linux/atomic/atomic-instrumented.h:4908:9: note: in expansion of macro 'raw_try_cmpxchg_relaxed'
 4908 |         raw_try_cmpxchg_relaxed(__ai_ptr, __ai_oldp, __VA_ARGS__); \
      |         ^~~~~~~~~~~~~~~~~~~~~~~
linux/kernel/locking/qspinlock_paravirt.h:377:14: note: in expansion of macro 'try_cmpxchg_relaxed'
  377 |         if (!try_cmpxchg_relaxed(&pn->state, &old, vcpu_hashed))
      |              ^~~~~~~~~~~~~~~~~~~
In file included from linux/kernel/locking/qspinlock.c:583:
linux/kernel/locking/qspinlock_paravirt.h: At top level:
linux/kernel/locking/qspinlock_paravirt.h:499:1: warning: no previous prototype for '__pv_queued_spin_unlock_slowpath' [-Wmissing-prototypes]
  499 | __pv_queued_spin_unlock_slowpath(struct qspinlock *lock, u8 locked)

Macro try_cmpxchg_relaxed() is used by paravirt qspinlock, on LoongArch
it is defined as raw_try_cmpxchg_relaxed(). And there is different type
conversion in marco raw_try_cmpxchg_relaxed(). Here type declaration is
added beore type conversion.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 include/linux/atomic/atomic-arch-fallback.h | 50 ++++++++++++++-------
 scripts/atomic/gen-atomic-fallback.sh       |  3 +-
 2 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
index 2f9d36b72bd8..8273c53321c3 100644
--- a/include/linux/atomic/atomic-arch-fallback.h
+++ b/include/linux/atomic/atomic-arch-fallback.h
@@ -188,7 +188,8 @@ extern void raw_cmpxchg128_relaxed_not_implemented(void);
 #else
 #define raw_try_cmpxchg(_ptr, _oldp, _new) \
 ({ \
-	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	typeof((_ptr)) ___op = (typeof((_ptr)))(_oldp); \
+	typeof(*(_ptr)) ___o = *___op, ___r; \
 	___r = raw_cmpxchg((_ptr), ___o, (_new)); \
 	if (unlikely(___r != ___o)) \
 		*___op = ___r; \
@@ -206,7 +207,8 @@ extern void raw_cmpxchg128_relaxed_not_implemented(void);
 #else
 #define raw_try_cmpxchg_acquire(_ptr, _oldp, _new) \
 ({ \
-	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	typeof((_ptr)) ___op = (typeof((_ptr)))(_oldp); \
+	typeof(*(_ptr)) ___o = *___op, ___r; \
 	___r = raw_cmpxchg_acquire((_ptr), ___o, (_new)); \
 	if (unlikely(___r != ___o)) \
 		*___op = ___r; \
@@ -224,7 +226,8 @@ extern void raw_cmpxchg128_relaxed_not_implemented(void);
 #else
 #define raw_try_cmpxchg_release(_ptr, _oldp, _new) \
 ({ \
-	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	typeof((_ptr)) ___op = (typeof((_ptr)))(_oldp); \
+	typeof(*(_ptr)) ___o = *___op, ___r; \
 	___r = raw_cmpxchg_release((_ptr), ___o, (_new)); \
 	if (unlikely(___r != ___o)) \
 		*___op = ___r; \
@@ -239,7 +242,8 @@ extern void raw_cmpxchg128_relaxed_not_implemented(void);
 #else
 #define raw_try_cmpxchg_relaxed(_ptr, _oldp, _new) \
 ({ \
-	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	typeof((_ptr)) ___op = (typeof((_ptr)))(_oldp); \
+	typeof(*(_ptr)) ___o = *___op, ___r; \
 	___r = raw_cmpxchg_relaxed((_ptr), ___o, (_new)); \
 	if (unlikely(___r != ___o)) \
 		*___op = ___r; \
@@ -255,7 +259,8 @@ extern void raw_cmpxchg128_relaxed_not_implemented(void);
 #else
 #define raw_try_cmpxchg64(_ptr, _oldp, _new) \
 ({ \
-	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	typeof((_ptr)) ___op = (typeof((_ptr)))(_oldp); \
+	typeof(*(_ptr)) ___o = *___op, ___r; \
 	___r = raw_cmpxchg64((_ptr), ___o, (_new)); \
 	if (unlikely(___r != ___o)) \
 		*___op = ___r; \
@@ -273,7 +278,8 @@ extern void raw_cmpxchg128_relaxed_not_implemented(void);
 #else
 #define raw_try_cmpxchg64_acquire(_ptr, _oldp, _new) \
 ({ \
-	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	typeof((_ptr)) ___op = (typeof((_ptr)))(_oldp); \
+	typeof(*(_ptr)) ___o = *___op, ___r; \
 	___r = raw_cmpxchg64_acquire((_ptr), ___o, (_new)); \
 	if (unlikely(___r != ___o)) \
 		*___op = ___r; \
@@ -291,7 +297,8 @@ extern void raw_cmpxchg128_relaxed_not_implemented(void);
 #else
 #define raw_try_cmpxchg64_release(_ptr, _oldp, _new) \
 ({ \
-	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	typeof((_ptr)) ___op = (typeof((_ptr)))(_oldp); \
+	typeof(*(_ptr)) ___o = *___op, ___r; \
 	___r = raw_cmpxchg64_release((_ptr), ___o, (_new)); \
 	if (unlikely(___r != ___o)) \
 		*___op = ___r; \
@@ -306,7 +313,8 @@ extern void raw_cmpxchg128_relaxed_not_implemented(void);
 #else
 #define raw_try_cmpxchg64_relaxed(_ptr, _oldp, _new) \
 ({ \
-	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	typeof((_ptr)) ___op = (typeof((_ptr)))(_oldp); \
+	typeof(*(_ptr)) ___o = *___op, ___r; \
 	___r = raw_cmpxchg64_relaxed((_ptr), ___o, (_new)); \
 	if (unlikely(___r != ___o)) \
 		*___op = ___r; \
@@ -322,7 +330,8 @@ extern void raw_cmpxchg128_relaxed_not_implemented(void);
 #else
 #define raw_try_cmpxchg128(_ptr, _oldp, _new) \
 ({ \
-	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	typeof((_ptr)) ___op = (typeof((_ptr)))(_oldp); \
+	typeof(*(_ptr)) ___o = *___op, ___r; \
 	___r = raw_cmpxchg128((_ptr), ___o, (_new)); \
 	if (unlikely(___r != ___o)) \
 		*___op = ___r; \
@@ -340,7 +349,8 @@ extern void raw_cmpxchg128_relaxed_not_implemented(void);
 #else
 #define raw_try_cmpxchg128_acquire(_ptr, _oldp, _new) \
 ({ \
-	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	typeof((_ptr)) ___op = (typeof((_ptr)))(_oldp); \
+	typeof(*(_ptr)) ___o = *___op, ___r; \
 	___r = raw_cmpxchg128_acquire((_ptr), ___o, (_new)); \
 	if (unlikely(___r != ___o)) \
 		*___op = ___r; \
@@ -358,7 +368,8 @@ extern void raw_cmpxchg128_relaxed_not_implemented(void);
 #else
 #define raw_try_cmpxchg128_release(_ptr, _oldp, _new) \
 ({ \
-	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	typeof((_ptr)) ___op = (typeof((_ptr)))(_oldp); \
+	typeof(*(_ptr)) ___o = *___op, ___r; \
 	___r = raw_cmpxchg128_release((_ptr), ___o, (_new)); \
 	if (unlikely(___r != ___o)) \
 		*___op = ___r; \
@@ -373,7 +384,8 @@ extern void raw_cmpxchg128_relaxed_not_implemented(void);
 #else
 #define raw_try_cmpxchg128_relaxed(_ptr, _oldp, _new) \
 ({ \
-	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	typeof((_ptr)) ___op = (typeof((_ptr)))(_oldp); \
+	typeof(*(_ptr)) ___o = *___op, ___r; \
 	___r = raw_cmpxchg128_relaxed((_ptr), ___o, (_new)); \
 	if (unlikely(___r != ___o)) \
 		*___op = ___r; \
@@ -388,7 +400,8 @@ extern void raw_cmpxchg128_relaxed_not_implemented(void);
 #else
 #define raw_try_cmpxchg_local(_ptr, _oldp, _new) \
 ({ \
-	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	typeof((_ptr)) ___op = (typeof((_ptr)))(_oldp); \
+	typeof(*(_ptr)) ___o = *___op, ___r; \
 	___r = raw_cmpxchg_local((_ptr), ___o, (_new)); \
 	if (unlikely(___r != ___o)) \
 		*___op = ___r; \
@@ -403,7 +416,8 @@ extern void raw_cmpxchg128_relaxed_not_implemented(void);
 #else
 #define raw_try_cmpxchg64_local(_ptr, _oldp, _new) \
 ({ \
-	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	typeof((_ptr)) ___op = (typeof((_ptr)))(_oldp); \
+	typeof(*(_ptr)) ___o = *___op, ___r; \
 	___r = raw_cmpxchg64_local((_ptr), ___o, (_new)); \
 	if (unlikely(___r != ___o)) \
 		*___op = ___r; \
@@ -418,7 +432,8 @@ extern void raw_cmpxchg128_relaxed_not_implemented(void);
 #else
 #define raw_try_cmpxchg128_local(_ptr, _oldp, _new) \
 ({ \
-	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	typeof((_ptr)) ___op = (typeof((_ptr)))(_oldp); \
+	typeof(*(_ptr)) ___o = *___op, ___r; \
 	___r = raw_cmpxchg128_local((_ptr), ___o, (_new)); \
 	if (unlikely(___r != ___o)) \
 		*___op = ___r; \
@@ -433,7 +448,8 @@ extern void raw_cmpxchg128_relaxed_not_implemented(void);
 #else
 #define raw_sync_try_cmpxchg(_ptr, _oldp, _new) \
 ({ \
-	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	typeof((_ptr)) ___op = (typeof((_ptr)))(_oldp); \
+	typeof(*(_ptr)) ___o = *___op, ___r; \
 	___r = raw_sync_cmpxchg((_ptr), ___o, (_new)); \
 	if (unlikely(___r != ___o)) \
 		*___op = ___r; \
@@ -4690,4 +4706,4 @@ raw_atomic64_dec_if_positive(atomic64_t *v)
 }
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// b565db590afeeff0d7c9485ccbca5bb6e155749f
+// 7b23ddca3c50c5869e68ded50748ffe111123156
diff --git a/scripts/atomic/gen-atomic-fallback.sh b/scripts/atomic/gen-atomic-fallback.sh
index f80d69cfeb1f..f3a9b084a176 100755
--- a/scripts/atomic/gen-atomic-fallback.sh
+++ b/scripts/atomic/gen-atomic-fallback.sh
@@ -230,7 +230,8 @@ gen_try_cmpxchg_fallback()
 cat <<EOF
 #define raw_${prefix}try_${cmpxchg}${suffix}(_ptr, _oldp, _new) \\
 ({ \\
-	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \\
+	typeof((_ptr)) ___op = (typeof((_ptr)))(_oldp); \\
+	typeof(*(_ptr)) ___o = *___op, ___r; \\
 	___r = raw_${prefix}${cmpxchg}${suffix}((_ptr), ___o, (_new)); \\
 	if (unlikely(___r != ___o)) \\
 		*___op = ___r; \\

base-commit: 720261cfc7329406a50c2a8536e0039b9dd9a4e5
-- 
2.39.3


