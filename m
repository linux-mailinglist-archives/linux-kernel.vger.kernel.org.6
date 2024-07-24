Return-Path: <linux-kernel+bounces-261121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9996293B2FD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54C08283F7C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C4C15B54B;
	Wed, 24 Jul 2024 14:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dH9KdiJh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E637815B546
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 14:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832340; cv=none; b=P+evq6MDDnVOkUQXYGqtv8tVYaYc1eVsAlbDPEkbVtMjM7KRCVQ4f8i4UqYF7JYQbz2PecBR7KIxWKyAN59vOIifdqCos/4o8odeseVO1yvTlqWr0DDQGcgxqDF0dPE23tE6TcYHZWeqFC0CEaaN5fikv33QzEcE9Q77uiZO0iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832340; c=relaxed/simple;
	bh=YqB/W8+dC4LUv9efcrt9LnJi9WP8A8zZyAXTYUQgADA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qvQHPF7S8KeD0pVw2B+7Ekcb9diqCMczHliaP+AG5QWfRK2KVvhKVkfHdUoQMmWPGiojH8sZp33Nu7s89BZVhQsSEFlBn2gcjW/62L5fwHKxLXhYtBLb9SVyPnI5wuGC4Dx/1ZNnK2GZrMZT/HW/E/vTUoC54QSYVeRgZHMkHQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dH9KdiJh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721832337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hPk7xiOk3VNi8FrRN4AAE3PmurspYCttXyJwJ1UrXiU=;
	b=dH9KdiJh7wiom/b1NC7Xin5MNibAUGJE7VGxFgrlNt5WiE2mwVhcM0wwfvWkIy6ovSODgN
	wg7tooIFVUKhbTZM/C6Hy/F5pJhhM/niWpQAQUsfpfxD2WwO0rD4fVwTVli/uPavKBlMef
	XfHvNGbz6qaGBK/JCXFi5+WaV31u+vI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-_x2m9z4QPKqPxjilWxeFug-1; Wed,
 24 Jul 2024 10:45:32 -0400
X-MC-Unique: _x2m9z4QPKqPxjilWxeFug-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2A6DA1955F3B;
	Wed, 24 Jul 2024 14:45:30 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.192.125])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0536A1955F3B;
	Wed, 24 Jul 2024 14:45:25 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH v3 12/25] context_tracking, rcu: Rename DYNTICK_IRQ_NONIDLE into CT_NESTING_IRQ_NONIDLE
Date: Wed, 24 Jul 2024 16:43:12 +0200
Message-ID: <20240724144325.3307148-13-vschneid@redhat.com>
In-Reply-To: <20240724144325.3307148-1-vschneid@redhat.com>
References: <20240724144325.3307148-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
RCU_WATCHING, and the 'dynticks' prefix can be dropped without losing any
meaning.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/context_tracking_state.h | 2 +-
 kernel/context_tracking.c              | 8 ++++----
 kernel/rcu/tree.c                      | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index 34fd504e53a86..0dbda59c9f372 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -7,7 +7,7 @@
 #include <linux/context_tracking_irq.h>
 
 /* Offset to allow distinguishing irq vs. task-based idle entry/exit. */
-#define DYNTICK_IRQ_NONIDLE	((LONG_MAX / 2) + 1)
+#define CT_NESTING_IRQ_NONIDLE	((LONG_MAX / 2) + 1)
 
 enum ctx_state {
 	CT_STATE_DISABLED	= -1,	/* returned by ct_state() if unknown */
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 115843eeb0309..8262f57a43636 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -29,7 +29,7 @@
 DEFINE_PER_CPU(struct context_tracking, context_tracking) = {
 #ifdef CONFIG_CONTEXT_TRACKING_IDLE
 	.nesting = 1,
-	.nmi_nesting = DYNTICK_IRQ_NONIDLE,
+	.nmi_nesting = CT_NESTING_IRQ_NONIDLE,
 #endif
 	.state = ATOMIC_INIT(CT_RCU_WATCHING),
 };
@@ -125,7 +125,7 @@ static void noinstr ct_kernel_exit(bool user, int offset)
 {
 	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
 
-	WARN_ON_ONCE(ct_nmi_nesting() != DYNTICK_IRQ_NONIDLE);
+	WARN_ON_ONCE(ct_nmi_nesting() != CT_NESTING_IRQ_NONIDLE);
 	WRITE_ONCE(ct->nmi_nesting, 0);
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
 		     ct_nesting() == 0);
@@ -156,7 +156,7 @@ static void noinstr ct_kernel_exit(bool user, int offset)
  * Exit an RCU extended quiescent state, which can be either the
  * idle loop or adaptive-tickless usermode execution.
  *
- * We crowbar the ->nmi_nesting field to DYNTICK_IRQ_NONIDLE to
+ * We crowbar the ->nmi_nesting field to CT_NESTING_IRQ_NONIDLE to
  * allow for the possibility of usermode upcalls messing up our count of
  * interrupt nesting level during the busy period that is just now starting.
  */
@@ -186,7 +186,7 @@ static void noinstr ct_kernel_enter(bool user, int offset)
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	WRITE_ONCE(ct->nesting, 1);
 	WARN_ON_ONCE(ct_nmi_nesting());
-	WRITE_ONCE(ct->nmi_nesting, DYNTICK_IRQ_NONIDLE);
+	WRITE_ONCE(ct->nmi_nesting, CT_NESTING_IRQ_NONIDLE);
 	instrumentation_end();
 }
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 22322387cefb7..8a88d278e198e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -591,7 +591,7 @@ void rcu_irq_exit_check_preempt(void)
 	RCU_LOCKDEP_WARN(ct_nesting() <= 0,
 			 "RCU nesting counter underflow/zero!");
 	RCU_LOCKDEP_WARN(ct_nmi_nesting() !=
-			 DYNTICK_IRQ_NONIDLE,
+			 CT_NESTING_IRQ_NONIDLE,
 			 "Bad RCU  nmi_nesting counter\n");
 	RCU_LOCKDEP_WARN(rcu_dynticks_curr_cpu_in_eqs(),
 			 "RCU in extended quiescent state!");
-- 
2.43.0


