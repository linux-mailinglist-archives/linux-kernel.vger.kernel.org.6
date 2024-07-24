Return-Path: <linux-kernel+bounces-261127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7BF93B303
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF066283E51
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817D116B3B6;
	Wed, 24 Jul 2024 14:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DXVqP1qf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432F716B388
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 14:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832357; cv=none; b=lOWhZQqZLorO1nBKmJXwsdcVfz/VKiolvXHWOXZB1YPdv6XUO5B4oGDQqo6dquQe+Prc/r1u2E0cPvMFElIFh3eNdKaAnHLyiKstQ5NhOrhOJo6DNNQSZfve/vPrPOPZgcamuR5y5d8KTuCRbl1sy1XMWwENMYQ3QyDYcndx5pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832357; c=relaxed/simple;
	bh=sTNI9+Wu8xBu+Zp4gnU5GpdpzOCtsxslBR/3OM4ions=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TRZVz1jb9D7rbRvIir3QuEVB/geA3G3IivXvPwJI3vMwgcRvej4l8Aj668HhTXidmJhhDWPEFtBt1VozEwCbV16qdU11bKPEHB7SqHvya8ThN8l1ZoxG2KsfsTPSzXnoUfRBd5gs98L1YOHKLXSANUANNZKCOdMnTc6KiTQI1VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DXVqP1qf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721832355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=00VSyTlF8HleoRX9yFWUqCvwFsZDjW8sRSc4QTF1NYc=;
	b=DXVqP1qffeII6XyFAh9MZtxsaHVeHjWWegkjJADnQ63Z2rqLOLT9/i0p+BdoYa0FDMAmB0
	w4PRnbsit31a0ehfpxC5fxyin0l74DdV5abl2PvlpV7XwG3sJgJSscCxNsS1aUVJiVHtF4
	kqINbSUwR6c+VafQbnG8nzNG5B9Opb8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-Lcd0vCguOGiNE3genk13xA-1; Wed,
 24 Jul 2024 10:45:50 -0400
X-MC-Unique: Lcd0vCguOGiNE3genk13xA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C55F71955D42;
	Wed, 24 Jul 2024 14:45:48 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.192.125])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 847BF1955F40;
	Wed, 24 Jul 2024 14:45:44 +0000 (UTC)
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
Subject: [PATCH v3 16/25] rcu: Rename rcu_dynticks_in_eqs() into rcu_watching_snap_in_eqs()
Date: Wed, 24 Jul 2024 16:43:16 +0200
Message-ID: <20240724144325.3307148-17-vschneid@redhat.com>
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

While at it, update a comment that still refers to rcu_dynticks_snap(),
which was removed by commit:

  7be2e6323b9b ("rcu: Remove full memory barrier on RCU stall printout")

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c       | 8 ++++----
 kernel/rcu/tree_exp.h   | 2 +-
 kernel/rcu/tree_stall.h | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ffec0e7513466..7c2bd7e511579 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -300,10 +300,10 @@ static void rcu_watching_online(void)
 }
 
 /*
- * Return true if the snapshot returned from rcu_dynticks_snap()
+ * Return true if the snapshot returned from ct_rcu_watching()
  * indicates that RCU is in an extended quiescent state.
  */
-static bool rcu_dynticks_in_eqs(int snap)
+static bool rcu_watching_snap_in_eqs(int snap)
 {
 	return !(snap & CT_RCU_WATCHING);
 }
@@ -769,7 +769,7 @@ static int dyntick_save_progress_counter(struct rcu_data *rdp)
 	 * with chained smp_mb__after_unlock_lock().
 	 */
 	rdp->dynticks_snap = ct_rcu_watching_cpu_acquire(rdp->cpu);
-	if (rcu_dynticks_in_eqs(rdp->dynticks_snap)) {
+	if (rcu_watching_snap_in_eqs(rdp->dynticks_snap)) {
 		trace_rcu_fqs(rcu_state.name, rdp->gp_seq, rdp->cpu, TPS("dti"));
 		rcu_gpnum_ovf(rdp->mynode, rdp);
 		return 1;
@@ -4793,7 +4793,7 @@ rcu_boot_init_percpu_data(int cpu)
 	rdp->grpmask = leaf_node_cpu_bit(rdp->mynode, cpu);
 	INIT_WORK(&rdp->strict_work, strict_work_handler);
 	WARN_ON_ONCE(ct->nesting != 1);
-	WARN_ON_ONCE(rcu_dynticks_in_eqs(ct_rcu_watching_cpu(cpu)));
+	WARN_ON_ONCE(rcu_watching_snap_in_eqs(ct_rcu_watching_cpu(cpu)));
 	rdp->barrier_seq_snap = rcu_state.barrier_sequence;
 	rdp->rcu_ofl_gp_seq = rcu_state.gp_seq;
 	rdp->rcu_ofl_gp_state = RCU_GP_CLEANED;
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 89cbadb15a4e7..8453da73a7df2 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -369,7 +369,7 @@ static void __sync_rcu_exp_select_node_cpus(struct rcu_exp_work *rewp)
 			 * smp_mb__after_unlock_lock().
 			 */
 			snap = ct_rcu_watching_cpu_acquire(cpu);
-			if (rcu_dynticks_in_eqs(snap))
+			if (rcu_watching_snap_in_eqs(snap))
 				mask_ofl_test |= mask;
 			else
 				rdp->exp_dynticks_snap = snap;
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index ec49f0155becc..e933c6a58d5fd 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -501,7 +501,7 @@ static void print_cpu_stall_info(int cpu)
 	}
 	delta = rcu_seq_ctr(rdp->mynode->gp_seq - rdp->rcu_iw_gp_seq);
 	falsepositive = rcu_is_gp_kthread_starving(NULL) &&
-			rcu_dynticks_in_eqs(ct_rcu_watching_cpu(cpu));
+			rcu_watching_snap_in_eqs(ct_rcu_watching_cpu(cpu));
 	rcuc_starved = rcu_is_rcuc_kthread_starving(rdp, &j);
 	if (rcuc_starved)
 		// Print signed value, as negative values indicate a probable bug.
-- 
2.43.0


