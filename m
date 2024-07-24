Return-Path: <linux-kernel+bounces-261129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A3093B305
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94662B24BD2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F6E16B752;
	Wed, 24 Jul 2024 14:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R5Qe12w2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9F216C685
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 14:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832367; cv=none; b=c/+QBXuI1LG6cIF6oTci25neyskBIkGXkvuaddU5m2YN0XhHjqJSmSeEkwo18AWLTciwgmFGb+BAkk6zFyTS9MXCqkt5efwv9/9EeRumFIKls8y+hNGKR+YRCQ2GbuPZXROlmOz7LG8RfS/YVuUBTLKW0H3WQ8Ycf6ROU6mOx7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832367; c=relaxed/simple;
	bh=+J0wB86qpfyvRMt66KLg/gt6uWTnso5KmEGC5grWpXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J0rJG2FxLdq49O3TM59gwSE0gQpX2Nwo3hPu/Z2DPFy/sWoL2ye7tXKY/3o06bUAd0mYJYubxTdEVLEw6G4fLpBW9sgTlCmquUCbvZCq2w38JqgsMiw9L8CyZnOmyunv/oVxspCy+3wM92T6O2klVNZ9XR9qIDvCxZRvLAk5cyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R5Qe12w2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721832364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7z60zM+SQRXxDqKuJZoRzq0oy53ItT6FQQA50hZ8Rc0=;
	b=R5Qe12w2g6QCOgJcQ/afYZlC/JLutq2PiFaAqOpI0kTaOY6QA+Sgk1iB67JdsW0d/S50pK
	JySi0y7ByO262YEO9aZImKKs5BySrwSGnTC0HENWX576lVkkUm1BFILISC6mjwPHA0Gz9k
	Ytfv6wVGZCglr64NSoomN3PnPcVm/14=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-VPmkoAC6OIKfO7IfmZ0NEw-1; Wed,
 24 Jul 2024 10:46:00 -0400
X-MC-Unique: VPmkoAC6OIKfO7IfmZ0NEw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D0011955F77;
	Wed, 24 Jul 2024 14:45:58 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.192.125])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1D9731955F3B;
	Wed, 24 Jul 2024 14:45:53 +0000 (UTC)
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
Subject: [PATCH v3 18/25] rcu: Rename rcu_dynticks_zero_in_eqs() into rcu_watching_zero_in_eqs()
Date: Wed, 24 Jul 2024 16:43:18 +0200
Message-ID: <20240724144325.3307148-19-vschneid@redhat.com>
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
RCU_WATCHING, reflect that change in the related helpers.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/rcu.h   | 4 ++--
 kernel/rcu/tasks.h | 2 +-
 kernel/rcu/tree.c  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 38238e595a61a..5564402af4cbd 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -606,7 +606,7 @@ void srcutorture_get_gp_data(struct srcu_struct *sp, int *flags,
 #endif
 
 #ifdef CONFIG_TINY_RCU
-static inline bool rcu_dynticks_zero_in_eqs(int cpu, int *vp) { return false; }
+static inline bool rcu_watching_zero_in_eqs(int cpu, int *vp) { return false; }
 static inline unsigned long rcu_get_gp_seq(void) { return 0; }
 static inline unsigned long rcu_exp_batches_completed(void) { return 0; }
 static inline unsigned long
@@ -619,7 +619,7 @@ static inline void rcu_fwd_progress_check(unsigned long j) { }
 static inline void rcu_gp_slow_register(atomic_t *rgssp) { }
 static inline void rcu_gp_slow_unregister(atomic_t *rgssp) { }
 #else /* #ifdef CONFIG_TINY_RCU */
-bool rcu_dynticks_zero_in_eqs(int cpu, int *vp);
+bool rcu_watching_zero_in_eqs(int cpu, int *vp);
 unsigned long rcu_get_gp_seq(void);
 unsigned long rcu_exp_batches_completed(void);
 unsigned long srcu_batches_completed(struct srcu_struct *sp);
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index ba3440a45b6dd..2484c1a8e051a 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1613,7 +1613,7 @@ static int trc_inspect_reader(struct task_struct *t, void *bhp_in)
 		// However, we cannot safely change its state.
 		n_heavy_reader_attempts++;
 		// Check for "running" idle tasks on offline CPUs.
-		if (!rcu_dynticks_zero_in_eqs(cpu, &t->trc_reader_nesting))
+		if (!rcu_watching_zero_in_eqs(cpu, &t->trc_reader_nesting))
 			return -EINVAL; // No quiescent state, do it the hard way.
 		n_heavy_reader_updates++;
 		nesting = 0;
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 3fd9f0fc4d558..d05bd65fbfdc2 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -333,7 +333,7 @@ static bool rcu_watching_snap_stopped_since(struct rcu_data *rdp, int snap)
  * Return true if the referenced integer is zero while the specified
  * CPU remains within a single extended quiescent state.
  */
-bool rcu_dynticks_zero_in_eqs(int cpu, int *vp)
+bool rcu_watching_zero_in_eqs(int cpu, int *vp)
 {
 	int snap;
 
-- 
2.43.0


