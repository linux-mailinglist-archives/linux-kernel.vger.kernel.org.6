Return-Path: <linux-kernel+bounces-349417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 642AE98F59B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 19:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87BC01C21A8A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 17:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFF21AAE19;
	Thu,  3 Oct 2024 17:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="M43EGiNH"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A8F1AAE2E
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 17:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727978046; cv=none; b=qJAMvcsTT0QvERyqI/1Ff9T+mszEPAd0ztx7+fJ4xGvRiWdrdE40BwssWVZ+gLyj9Zpy7u11C2dKU1aLMDzX6GfWarI/u0MY4OtvZaedvNSreJGJFazEI4HmK7RBgJ6UW6Bi14RHAYc3ffkP5wOGJfGTCN0d2SkF8fMSpjsObvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727978046; c=relaxed/simple;
	bh=yaG6/Pwbjb3iYAZXvRneGO21Acgm95spWkcRGQvk4kg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Maoib737R9OmYgfXOJddzkRfzZi80XOYAiVrki0KHtyjqv+LquRJ0IC2DaqlwJUHxPqwOkMOs+c45orAivxSusHnGZy/K7gqEC1oUXqjAWNXm2Wat7eUb5j5gNnpcP2eJcbXZNxB8ZIFVPK1EbTBCl4f5Uuyjhe21DfB/b3l82Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=M43EGiNH; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727978042;
	bh=yaG6/Pwbjb3iYAZXvRneGO21Acgm95spWkcRGQvk4kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M43EGiNHQo4wEP2GrGySVCAosCz9j7C8gwRX3NASFaPNldLJTggGnDufgsOoB/nSN
	 Hk9YgpAHUqvtMbLV13Kvs92B0PiJtqpdqSAvUav/qvHslFY72/zt/pKIgYbnAmcCie
	 DanbD3m+SyEXpZSQ2vERC9RHtmcptSLy/vBWmtmmdYcmjuJIC1RjnBQpmNn7JChHJ2
	 bKqKsJ5sxLtRxrN1gNW2v2EFUnMLrY0SwJpR4Uds/f8BxvbcymTNL+lHPF11sabRYB
	 lc88m4/DlRwRPtlY6sJt8/c0gbr1lAbbn2pCRo1Vt1sX+i5jh9NeX4BkKZzSDW7pdb
	 t1Q0HsMRdk0+Q==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XKK6y4CMvz7fd;
	Thu,  3 Oct 2024 13:54:02 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Mel Gorman <mgorman@suse.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Carlos O'Donell <carlos@redhat.com>,
	Florian Weimer <fweimer@redhat.com>
Subject: [PATCH 2/2] selftests/rseq: Adapt to glibc __rseq_size feature detection
Date: Thu,  3 Oct 2024 13:51:57 -0400
Message-Id: <20241003175157.1634301-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241003175157.1634301-1-mathieu.desnoyers@efficios.com>
References: <20241003175157.1634301-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adapt the rseq.c/rseq.h code to follow GNU C library changes introduced by:

commit 2e456ccf0c34 ("Linux: Make __rseq_size useful for feature detection (bug 31965)")

Wihout this fix, rseq selftests for mm_cid fail:

./run_param_test.sh
Default parameters
Running test spinlock
Running compare-twice test spinlock
Running mm_cid test spinlock
Error: cpu id getter unavailable

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
CC: Carlos O'Donell <carlos@redhat.com>
CC: Florian Weimer <fweimer@redhat.com>
---
 tools/testing/selftests/rseq/rseq.c | 109 +++++++++++++++++++---------
 tools/testing/selftests/rseq/rseq.h |  10 +--
 2 files changed, 76 insertions(+), 43 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index 96e812bdf8a4..3797bb0881da 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -60,12 +60,6 @@ unsigned int rseq_size = -1U;
 /* Flags used during rseq registration.  */
 unsigned int rseq_flags;
 
-/*
- * rseq feature size supported by the kernel. 0 if the registration was
- * unsuccessful.
- */
-unsigned int rseq_feature_size = -1U;
-
 static int rseq_ownership;
 static int rseq_reg_success;	/* At least one rseq registration has succeded. */
 
@@ -111,6 +105,43 @@ int rseq_available(void)
 	}
 }
 
+/* The rseq areas need to be at least 32 bytes. */
+static
+unsigned get_rseq_min_alloc_size(void)
+{
+	unsigned int alloc_size = rseq_size;
+
+	if (alloc_size < ORIG_RSEQ_ALLOC_SIZE)
+		alloc_size = ORIG_RSEQ_ALLOC_SIZE;
+	return alloc_size;
+}
+
+/*
+ * Return the feature size supported by the kernel.
+ *
+ * Depending on the value returned by getauxval(AT_RSEQ_FEATURE_SIZE):
+ *
+ * 0:   Return ORIG_RSEQ_FEATURE_SIZE (20)
+ * > 0: Return the value from getauxval(AT_RSEQ_FEATURE_SIZE).
+ *
+ * It should never return a value below ORIG_RSEQ_FEATURE_SIZE.
+ */
+static
+unsigned int get_rseq_kernel_feature_size(void)
+{
+	unsigned long auxv_rseq_feature_size, auxv_rseq_align;
+
+	auxv_rseq_align = getauxval(AT_RSEQ_ALIGN);
+	assert(!auxv_rseq_align || auxv_rseq_align <= RSEQ_THREAD_AREA_ALLOC_SIZE);
+
+	auxv_rseq_feature_size = getauxval(AT_RSEQ_FEATURE_SIZE);
+	assert(!auxv_rseq_feature_size || auxv_rseq_feature_size <= RSEQ_THREAD_AREA_ALLOC_SIZE);
+	if (auxv_rseq_feature_size)
+		return auxv_rseq_feature_size;
+	else
+		return ORIG_RSEQ_FEATURE_SIZE;
+}
+
 int rseq_register_current_thread(void)
 {
 	int rc;
@@ -119,7 +150,7 @@ int rseq_register_current_thread(void)
 		/* Treat libc's ownership as a successful registration. */
 		return 0;
 	}
-	rc = sys_rseq(&__rseq_abi, rseq_size, 0, RSEQ_SIG);
+	rc = sys_rseq(&__rseq_abi, get_rseq_min_alloc_size(), 0, RSEQ_SIG);
 	if (rc) {
 		if (RSEQ_READ_ONCE(rseq_reg_success)) {
 			/* Incoherent success/failure within process. */
@@ -140,28 +171,12 @@ int rseq_unregister_current_thread(void)
 		/* Treat libc's ownership as a successful unregistration. */
 		return 0;
 	}
-	rc = sys_rseq(&__rseq_abi, rseq_size, RSEQ_ABI_FLAG_UNREGISTER, RSEQ_SIG);
+	rc = sys_rseq(&__rseq_abi, get_rseq_min_alloc_size(), RSEQ_ABI_FLAG_UNREGISTER, RSEQ_SIG);
 	if (rc)
 		return -1;
 	return 0;
 }
 
-static
-unsigned int get_rseq_feature_size(void)
-{
-	unsigned long auxv_rseq_feature_size, auxv_rseq_align;
-
-	auxv_rseq_align = getauxval(AT_RSEQ_ALIGN);
-	assert(!auxv_rseq_align || auxv_rseq_align <= RSEQ_THREAD_AREA_ALLOC_SIZE);
-
-	auxv_rseq_feature_size = getauxval(AT_RSEQ_FEATURE_SIZE);
-	assert(!auxv_rseq_feature_size || auxv_rseq_feature_size <= RSEQ_THREAD_AREA_ALLOC_SIZE);
-	if (auxv_rseq_feature_size)
-		return auxv_rseq_feature_size;
-	else
-		return ORIG_RSEQ_FEATURE_SIZE;
-}
-
 static __attribute__((constructor))
 void rseq_init(void)
 {
@@ -178,28 +193,53 @@ void rseq_init(void)
 	}
 	if (libc_rseq_size_p && libc_rseq_offset_p && libc_rseq_flags_p &&
 			*libc_rseq_size_p != 0) {
+		unsigned int libc_rseq_size;
+
 		/* rseq registration owned by glibc */
 		rseq_offset = *libc_rseq_offset_p;
-		rseq_size = *libc_rseq_size_p;
+		libc_rseq_size = *libc_rseq_size_p;
 		rseq_flags = *libc_rseq_flags_p;
-		rseq_feature_size = get_rseq_feature_size();
-		if (rseq_feature_size > rseq_size)
-			rseq_feature_size = rseq_size;
+
+		/*
+		 * Previous versions of glibc expose the value
+		 * 32 even though the kernel only supported 20
+		 * bytes initially. Therefore treat 32 as a
+		 * special-case. glibc 2.40 exposes a 20 bytes
+		 * __rseq_size without using getauxval(3) to
+		 * query the supported size, while still allocating a 32
+		 * bytes area. Also treat 20 as a special-case.
+		 *
+		 * Special-cases are handled by using the following
+		 * value as active feature set size:
+		 *
+		 *   rseq_size = min(32, get_rseq_kernel_feature_size())
+		 */
+		switch (libc_rseq_size) {
+		case ORIG_RSEQ_FEATURE_SIZE:	/* Fallthrough. */
+		case ORIG_RSEQ_ALLOC_SIZE:
+		{
+			unsigned int rseq_kernel_feature_size = get_rseq_kernel_feature_size();
+
+			if (rseq_kernel_feature_size < ORIG_RSEQ_ALLOC_SIZE)
+				rseq_size = rseq_kernel_feature_size;
+			else
+				rseq_size = ORIG_RSEQ_ALLOC_SIZE;
+			break;
+		}
+		default:
+			/* Otherwise just use the __rseq_size from libc as rseq_size. */
+			rseq_size = libc_rseq_size;
+			break;
+		}
 		return;
 	}
 	rseq_ownership = 1;
 	if (!rseq_available()) {
 		rseq_size = 0;
-		rseq_feature_size = 0;
 		return;
 	}
 	rseq_offset = (void *)&__rseq_abi - rseq_thread_pointer();
 	rseq_flags = 0;
-	rseq_feature_size = get_rseq_feature_size();
-	if (rseq_feature_size == ORIG_RSEQ_FEATURE_SIZE)
-		rseq_size = ORIG_RSEQ_ALLOC_SIZE;
-	else
-		rseq_size = RSEQ_THREAD_AREA_ALLOC_SIZE;
 }
 
 static __attribute__((destructor))
@@ -209,7 +249,6 @@ void rseq_exit(void)
 		return;
 	rseq_offset = 0;
 	rseq_size = -1U;
-	rseq_feature_size = -1U;
 	rseq_ownership = 0;
 }
 
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index d7364ea4d201..4e217b620e0c 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -68,12 +68,6 @@ extern unsigned int rseq_size;
 /* Flags used during rseq registration. */
 extern unsigned int rseq_flags;
 
-/*
- * rseq feature size supported by the kernel. 0 if the registration was
- * unsuccessful.
- */
-extern unsigned int rseq_feature_size;
-
 enum rseq_mo {
 	RSEQ_MO_RELAXED = 0,
 	RSEQ_MO_CONSUME = 1,	/* Unused */
@@ -193,7 +187,7 @@ static inline uint32_t rseq_current_cpu(void)
 
 static inline bool rseq_node_id_available(void)
 {
-	return (int) rseq_feature_size >= rseq_offsetofend(struct rseq_abi, node_id);
+	return (int) rseq_size >= rseq_offsetofend(struct rseq_abi, node_id);
 }
 
 /*
@@ -207,7 +201,7 @@ static inline uint32_t rseq_current_node_id(void)
 
 static inline bool rseq_mm_cid_available(void)
 {
-	return (int) rseq_feature_size >= rseq_offsetofend(struct rseq_abi, mm_cid);
+	return (int) rseq_size >= rseq_offsetofend(struct rseq_abi, mm_cid);
 }
 
 static inline uint32_t rseq_current_mm_cid(void)
-- 
2.39.2


