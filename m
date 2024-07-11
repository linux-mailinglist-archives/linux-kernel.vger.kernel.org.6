Return-Path: <linux-kernel+bounces-249241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF04892E8C3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D2431C21AE9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2BE15FA92;
	Thu, 11 Jul 2024 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RvljnccQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2241E15F402
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720702863; cv=none; b=tWEYHJfX1T3yyvqR7qNYn45Fi3tpWlVKmjXaveYyNz63BIX8dxAhrEOgyxf75yBzl2DsQ7ogtowlXqCvayoWGAv/hHTdWT0iTA90AsS4mYsHvqDSP0c4QWikpu95X98BR5AKMePK/TF4z9rc7Q7U57JYo3Yfwj0HzR/hGHWSZR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720702863; c=relaxed/simple;
	bh=j48GshrK4SLyYIYU/4TmYMncSjreC5NozFzjgMwZI9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kkzMaNDkjkOmGw1aJQJS5vHIbBauxYYMFvq9mT6nWVJ2IB2l1ou23xBEUNcN7lp9Aj7N0t80lf/HIHW17HBdJyUq0RDaZCQxb2qIcBRCAMUd3s8s1todLBce4iCwFCUydMo4S1+TAP2cy6qTVl5FnP5jNPA3R7prDWEPMblhbEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RvljnccQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720702861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+8MT3JoxFoj9B2SXJDisOC/gnRr4MwegwcdGr6Z7BqM=;
	b=RvljnccQIMAES5QpoLsqLlQ7uc/4MVfQr9C8uNRnG6Ano8OToeF/Jt/DRGlU/CN6FIifwp
	LI2UsEnpkUs5W/I/mdmVq9SSbZ5+kdBrd3+sdZmhXn5FIfEG3U45BLDno5sibxZPZ2xlXK
	M+f0IY453s7COBUf6iBwqR1S9UAXjQs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-490-E1QTop2-MIW3fGQv61nn-A-1; Thu,
 11 Jul 2024 09:00:58 -0400
X-MC-Unique: E1QTop2-MIW3fGQv61nn-A-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D42011955EAA;
	Thu, 11 Jul 2024 13:00:53 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.192.211])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 736A91955E85;
	Thu, 11 Jul 2024 13:00:45 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Phil Auld <pauld@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Guo Ren <guoren@kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [RFC PATCH v3 02/10] irq_work: Split type definition to its own header
Date: Thu, 11 Jul 2024 14:59:56 +0200
Message-ID: <20240711130004.2157737-3-vschneid@redhat.com>
In-Reply-To: <20240711130004.2157737-1-vschneid@redhat.com>
References: <20240711130004.2157737-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

A later commit will add a struct irq_work member to struct task_struct, which
would require <linux/sched.h> to include the definition of struct
irq_work.

Thanks to header dependency hell, incudling <linux/irq_work.h> in <linux/sched.h>
results in defining inline helpers using not-yet-defined fields (mm_struct,
task_struct, various task states...).

Break off the definition of struct irq_work into its own header file.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/linux/irq_work.h       |  8 ++------
 include/linux/irq_work_types.h | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 6 deletions(-)
 create mode 100644 include/linux/irq_work_types.h

diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
index 136f2980cba30..7f6d2af360d91 100644
--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -5,6 +5,8 @@
 #include <linux/smp_types.h>
 #include <linux/rcuwait.h>
 
+#include <linux/irq_work_types.h>
+
 /*
  * An entry can be in one of four states:
  *
@@ -14,12 +16,6 @@
  * busy      NULL, 2 -> {free, claimed} : callback in progress, can be claimed
  */
 
-struct irq_work {
-	struct __call_single_node node;
-	void (*func)(struct irq_work *);
-	struct rcuwait irqwait;
-};
-
 #define __IRQ_WORK_INIT(_func, _flags) (struct irq_work){	\
 	.node = { .u_flags = (_flags), },			\
 	.func = (_func),					\
diff --git a/include/linux/irq_work_types.h b/include/linux/irq_work_types.h
new file mode 100644
index 0000000000000..108cbc514733b
--- /dev/null
+++ b/include/linux/irq_work_types.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_IRQ_WORK_TYPES_H
+#define _LINUX_IRQ_WORK_TYPES_H
+
+#include <linux/smp_types.h>
+#include <linux/rcuwait_types.h>
+
+struct irq_work {
+	struct __call_single_node node;
+	void (*func)(struct irq_work *);
+	struct rcuwait irqwait;
+};
+
+#endif
-- 
2.43.0


