Return-Path: <linux-kernel+bounces-213422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6231907523
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 457A0283891
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D55145B1C;
	Thu, 13 Jun 2024 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XbCepkLo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4261459F8
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 14:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718289001; cv=none; b=jsAZTLehami0ZKwpYhKil8j2imbP3ASo85lFH3BCjSgQ6Wu+x36ELZhpTLMMIH/TFruiiX6UgNZFGRuvr/SYi70cpdc9JY91/0R4OJg1ecmtw3WW/7OZmmP3Tb4blBNUBZYbVMYwnO0A3m2WRWMlndrTc5QurOglCZBNawMNIuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718289001; c=relaxed/simple;
	bh=xUVTyWuTVKmTjQ2YdXnQuOob7z7DwzJlQef0QmuqyCw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QScdzljV21eTpy1m0qoMRUwrxs+pE9JAmcLSrrI18k83wFiOh+rB6RDLeP7xvn1GasSLgYCvdYheLzHFV4PRHk20hw8QmGnBbWUAuM5lfCrfxDRsVXYaeG3mknU9QsAZL1ryHtFnz4QHJsfan9EXf3EDu9pjbzeWDAYh0WJ+/2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XbCepkLo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718288998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jPXsqIQyMQX7O2m51coSvI9OOYuBzrhgiTnaWnpoqNc=;
	b=XbCepkLoXShiXmSb0lTi2idM2QJQ8gfwwbpFAjMkeUnP5act2qsimvjyiIjFjX45BJvIf/
	fKx2i7wF2dzPaRtzhN012yOXum4XeDVlPWoPwJek4tk8zTzYWsTlRh8G/oN7fwtiFnS2B7
	Wtnw6/+U3fSyIB6L8meiXpiMH60NTi4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-LNSKgYr0PnyMbauAFMXPbw-1; Thu,
 13 Jun 2024 10:29:55 -0400
X-MC-Unique: LNSKgYr0PnyMbauAFMXPbw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 637BE1955F2A;
	Thu, 13 Jun 2024 14:29:54 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.195])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A61F31956050;
	Thu, 13 Jun 2024 14:29:52 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will.deacon@arm.com>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	David Arcari <darcari@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] lockdep: Improve consistency between lockdep and hardware hardirqs states
Date: Thu, 13 Jun 2024 10:29:29 -0400
Message-Id: <20240613142929.132220-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

There are occasional instances where a lockdep splat complains about
incorrect hardirqs state even when the hardware hardirqs state as
shown in the flags register is correct.  This can happen when a
local_irq_disable() is followed by a raw_local_irq_enable(), for
instance.

It can be hard to catch this kind of mismatch as the offending call
site can be far apart from the place where the lockdep splat happens.
Add more lockdep checks into local_irq_disable() and local_irq_save()
when trace_hardirqs_off() is not being called with the hope that lockdep
splat can happen closer to the offending site.

The irqflags related lockdep code in lockdep.h are extracted into a
separate lockdep_irqflags.h header file that can be included by
irqflags.h safely to make that possible.

There shouldn't be any overhead if CONFIG_PROVE_LOCKING isn't set.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/irqflags.h         |  6 +++
 include/linux/lockdep.h          | 64 +--------------------------
 include/linux/lockdep_irqflags.h | 76 ++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+), 63 deletions(-)
 create mode 100644 include/linux/lockdep_irqflags.h

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 3f003d5fde53..89c951c34a6a 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -191,6 +191,8 @@ extern void warn_bogus_irq_restore(void);
  */
 #ifdef CONFIG_TRACE_IRQFLAGS
 
+#include <linux/lockdep_irqflags.h>
+
 #define local_irq_enable()				\
 	do {						\
 		trace_hardirqs_on();			\
@@ -203,6 +205,8 @@ extern void warn_bogus_irq_restore(void);
 		raw_local_irq_disable();		\
 		if (!was_disabled)			\
 			trace_hardirqs_off();		\
+		else					\
+			lockdep_assert_irqs_disabled();	\
 	} while (0)
 
 #define local_irq_save(flags)				\
@@ -210,6 +214,8 @@ extern void warn_bogus_irq_restore(void);
 		raw_local_irq_save(flags);		\
 		if (!raw_irqs_disabled_flags(flags))	\
 			trace_hardirqs_off();		\
+		else					\
+			lockdep_assert_irqs_disabled();	\
 	} while (0)
 
 #define local_irq_restore(flags)			\
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 08b0d1d9d78b..8a2b288bc866 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -11,8 +11,8 @@
 #define __LINUX_LOCKDEP_H
 
 #include <linux/lockdep_types.h>
+#include <linux/lockdep_irqflags.h>
 #include <linux/smp.h>
-#include <asm/percpu.h>
 
 struct task_struct;
 
@@ -547,72 +547,10 @@ do {									\
 	lock_release(&(lock)->dep_map, _THIS_IP_);			\
 } while (0)
 
-DECLARE_PER_CPU(int, hardirqs_enabled);
-DECLARE_PER_CPU(int, hardirq_context);
-DECLARE_PER_CPU(unsigned int, lockdep_recursion);
-
-#define __lockdep_enabled	(debug_locks && !this_cpu_read(lockdep_recursion))
-
-#define lockdep_assert_irqs_enabled()					\
-do {									\
-	WARN_ON_ONCE(__lockdep_enabled && !this_cpu_read(hardirqs_enabled)); \
-} while (0)
-
-#define lockdep_assert_irqs_disabled()					\
-do {									\
-	WARN_ON_ONCE(__lockdep_enabled && this_cpu_read(hardirqs_enabled)); \
-} while (0)
-
-#define lockdep_assert_in_irq()						\
-do {									\
-	WARN_ON_ONCE(__lockdep_enabled && !this_cpu_read(hardirq_context)); \
-} while (0)
-
-#define lockdep_assert_no_hardirq()					\
-do {									\
-	WARN_ON_ONCE(__lockdep_enabled && (this_cpu_read(hardirq_context) || \
-					   !this_cpu_read(hardirqs_enabled))); \
-} while (0)
-
-#define lockdep_assert_preemption_enabled()				\
-do {									\
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
-		     __lockdep_enabled			&&		\
-		     (preempt_count() != 0		||		\
-		      !this_cpu_read(hardirqs_enabled)));		\
-} while (0)
-
-#define lockdep_assert_preemption_disabled()				\
-do {									\
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
-		     __lockdep_enabled			&&		\
-		     (preempt_count() == 0		&&		\
-		      this_cpu_read(hardirqs_enabled)));		\
-} while (0)
-
-/*
- * Acceptable for protecting per-CPU resources accessed from BH.
- * Much like in_softirq() - semantics are ambiguous, use carefully.
- */
-#define lockdep_assert_in_softirq()					\
-do {									\
-	WARN_ON_ONCE(__lockdep_enabled			&&		\
-		     (!in_softirq() || in_irq() || in_nmi()));		\
-} while (0)
-
 #else
 # define might_lock(lock) do { } while (0)
 # define might_lock_read(lock) do { } while (0)
 # define might_lock_nested(lock, subclass) do { } while (0)
-
-# define lockdep_assert_irqs_enabled() do { } while (0)
-# define lockdep_assert_irqs_disabled() do { } while (0)
-# define lockdep_assert_in_irq() do { } while (0)
-# define lockdep_assert_no_hardirq() do { } while (0)
-
-# define lockdep_assert_preemption_enabled() do { } while (0)
-# define lockdep_assert_preemption_disabled() do { } while (0)
-# define lockdep_assert_in_softirq() do { } while (0)
 #endif
 
 #ifdef CONFIG_PROVE_RAW_LOCK_NESTING
diff --git a/include/linux/lockdep_irqflags.h b/include/linux/lockdep_irqflags.h
new file mode 100644
index 000000000000..d8633c1839d9
--- /dev/null
+++ b/include/linux/lockdep_irqflags.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_LOCKDEP_IRQFLAGS_H
+#define __LINUX_LOCKDEP_IRQFLAGS_H
+
+#include <linux/debug_locks.h>
+#include <linux/kconfig.h>
+#include <linux/preempt.h>
+#include <asm/bug.h>
+#include <asm/percpu.h>
+
+#ifdef CONFIG_PROVE_LOCKING
+DECLARE_PER_CPU(int, hardirqs_enabled);
+DECLARE_PER_CPU(int, hardirq_context);
+DECLARE_PER_CPU(unsigned int, lockdep_recursion);
+
+#define __lockdep_enabled	(debug_locks && !this_cpu_read(lockdep_recursion))
+
+#define lockdep_assert_irqs_enabled()					\
+do {									\
+	WARN_ON_ONCE(__lockdep_enabled && !this_cpu_read(hardirqs_enabled)); \
+} while (0)
+
+#define lockdep_assert_irqs_disabled()					\
+do {									\
+	WARN_ON_ONCE(__lockdep_enabled && this_cpu_read(hardirqs_enabled)); \
+} while (0)
+
+#define lockdep_assert_in_irq()						\
+do {									\
+	WARN_ON_ONCE(__lockdep_enabled && !this_cpu_read(hardirq_context)); \
+} while (0)
+
+#define lockdep_assert_no_hardirq()					\
+do {									\
+	WARN_ON_ONCE(__lockdep_enabled && (this_cpu_read(hardirq_context) || \
+					   !this_cpu_read(hardirqs_enabled))); \
+} while (0)
+
+#define lockdep_assert_preemption_enabled()				\
+do {									\
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
+		     __lockdep_enabled			&&		\
+		     (preempt_count() != 0		||		\
+		      !this_cpu_read(hardirqs_enabled)));		\
+} while (0)
+
+#define lockdep_assert_preemption_disabled()				\
+do {									\
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
+		     __lockdep_enabled			&&		\
+		     (preempt_count() == 0		&&		\
+		      this_cpu_read(hardirqs_enabled)));		\
+} while (0)
+
+/*
+ * Acceptable for protecting per-CPU resources accessed from BH.
+ * Much like in_softirq() - semantics are ambiguous, use carefully.
+ */
+#define lockdep_assert_in_softirq()					\
+do {									\
+	WARN_ON_ONCE(__lockdep_enabled			&&		\
+		     (!in_softirq() || in_irq() || in_nmi()));		\
+} while (0)
+
+#else
+# define lockdep_assert_irqs_enabled() do { } while (0)
+# define lockdep_assert_irqs_disabled() do { } while (0)
+# define lockdep_assert_in_irq() do { } while (0)
+# define lockdep_assert_no_hardirq() do { } while (0)
+
+# define lockdep_assert_preemption_enabled() do { } while (0)
+# define lockdep_assert_preemption_disabled() do { } while (0)
+# define lockdep_assert_in_softirq() do { } while (0)
+#endif
+
+#endif /* __LINUX_LOCKDEP_IRQFLAGS_H */
-- 
2.39.3


