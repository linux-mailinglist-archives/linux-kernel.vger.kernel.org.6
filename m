Return-Path: <linux-kernel+bounces-394598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0676A9BB1A6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA5F82821FD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 10:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2C71B21A8;
	Mon,  4 Nov 2024 10:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SukzN7T5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fCl8CyFO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65661BBBD6
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717468; cv=none; b=GbJ9Lz9toYuEJ8HjdEL3ChfryZf33GVPyUTf/LNskAYRRSecgJmva7ypEEHJgB44KVdsp2+X0WGHyCqQzXTS+r9Luis3Ypzt7GK00+eiMKs+a6Aql8M20pJsPvDmJyQk9kQXS0GTw16QLSOdUKzO3uH8vqEecruWH8sZOFlI8nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717468; c=relaxed/simple;
	bh=1jLW/RPjllSAXW7cI0PEwo2jmu2ZhQAAcGhunD/PcI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X8yzckKgtVm9nUkR6P67EeohpxJLrHz4knTT4htOt/AyRzdGHWOucNVncp4591E8HTpZOp4IY9uW/In46hTXUhCBa4su7fyMhPweVBSeIKh1NVMmks7cL3osxmBlKgLI+6TCDpTk9wWhj42rJ60l0C5ep01Pq1aJcp83Pty7tp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SukzN7T5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fCl8CyFO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730717465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GcwZ4Huf0ok76UUKQ+LdAyCTe3RrRb5PN85tcNXwRJk=;
	b=SukzN7T56lKOuc5BCaY4Ynl/qdZao8MieTHRiEXijI2MnIrgIToBYEpOHHXsdcO++nkZZF
	9TMuGCJdxfx63iMHNfe749R/jnPifDtMQtqKl7TjVh1nnayxLmyRaaxcI38GaNalNd7muB
	CMi5uYuAfjaYWlVOKvfdgrN6iuJ5Ii0NeqHH5jB85aRS2RTHF4xw9pblNqz5da1oxC1Gar
	VUhb1oQh0w1qibmatIVC0Fa13+XbpEPIxw/BnLXWB5/i7MHfGN1o06C8fp0qXSGJBW3b43
	9QvA81w7yiZwQxjM+OWR981o9LNTBGxH8XsUjyc9pa/zJzKMGDx1kMqYDwFGEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730717465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GcwZ4Huf0ok76UUKQ+LdAyCTe3RrRb5PN85tcNXwRJk=;
	b=fCl8CyFOfq10gmJzfuJPKQEqviDpShgUqL5Ok5IGRTcxCmYKQWLlV2l8VujV+hSx0WzucP
	iP+UhqhAZb/D62AA==
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Marco Elver <elver@google.com>,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	sfr@canb.auug.org.au,
	longman@redhat.com,
	cl@linux.com,
	penberg@kernel.org,
	rientjes@google.com,
	iamjoonsoo.kim@lge.com,
	akpm@linux-foundation.org,
	Tomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/2] scftorture: Use a lock-less list to free memory.
Date: Mon,  4 Nov 2024 11:50:53 +0100
Message-ID: <20241104105053.2182833-2-bigeasy@linutronix.de>
In-Reply-To: <20241104105053.2182833-1-bigeasy@linutronix.de>
References: <88694240-1eea-4f4c-bb7b-80de25f252e7@paulmck-laptop>
 <20241104105053.2182833-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

scf_handler() is used as a SMP function call. This function is always
invoked in IRQ-context even with forced-threading enabled. This function
frees memory which not allowed on PREEMPT_RT because the locking
underneath is using sleeping locks.

Add a per-CPU scf_free_pool where each SMP functions adds its memory to
be freed. This memory is then freed by scftorture_invoker() on each
iteration. On the majority of invocations the number of items is less
than five. If the thread sleeps/ gets delayed the number exceed 350 but
did not reach 400 in testing. These were the spikes during testing.
The bulk free of 64 pointers at once should improve the give-back if the
list grows. The list size is ~1.3 items per invocations.

Having one global scf_free_pool with one cleaning thread let the list
grow to over 10.000 items with 32 CPUs (again, spikes not the average)
especially if the CPU went to sleep. The per-CPU part looks like a good
compromise.

Reported-by: "Paul E. McKenney" <paulmck@kernel.org>
Closes: https://lore.kernel.org/lkml/41619255-cdc2-4573-a360-7794fc3614f7@p=
aulmck-laptop/
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/scftorture.c | 47 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index e5546fe256329..ba9f1125821b8 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -97,6 +97,7 @@ struct scf_statistics {
 static struct scf_statistics *scf_stats_p;
 static struct task_struct *scf_torture_stats_task;
 static DEFINE_PER_CPU(long long, scf_invoked_count);
+static DEFINE_PER_CPU(struct llist_head, scf_free_pool);
=20
 // Data for random primitive selection
 #define SCF_PRIM_RESCHED	0
@@ -133,6 +134,7 @@ struct scf_check {
 	bool scfc_wait;
 	bool scfc_rpc;
 	struct completion scfc_completion;
+	struct llist_node scf_node;
 };
=20
 // Use to wait for all threads to start.
@@ -148,6 +150,40 @@ static DEFINE_TORTURE_RANDOM_PERCPU(scf_torture_rand);
=20
 extern void resched_cpu(int cpu); // An alternative IPI vector.
=20
+static void scf_add_to_free_list(struct scf_check *scfcp)
+{
+	struct llist_head *pool;
+	unsigned int cpu;
+
+	cpu =3D raw_smp_processor_id() % nthreads;
+	pool =3D &per_cpu(scf_free_pool, cpu);
+	llist_add(&scfcp->scf_node, pool);
+}
+
+static void scf_cleanup_free_list(unsigned int cpu)
+{
+	struct llist_head *pool;
+	struct llist_node *node;
+	struct scf_check *scfcp;
+	unsigned int slot =3D 0;
+	void *free_pool[64];
+
+	pool =3D &per_cpu(scf_free_pool, cpu);
+	node =3D llist_del_all(pool);
+	while (node) {
+		scfcp =3D llist_entry(node, struct scf_check, scf_node);
+		node =3D node->next;
+		free_pool[slot] =3D scfcp;
+		slot++;
+		if (slot =3D=3D ARRAY_SIZE(free_pool)) {
+			kfree_bulk(slot, free_pool);
+			slot =3D 0;
+		}
+	}
+	if (slot)
+		kfree_bulk(slot, free_pool);
+}
+
 // Print torture statistics.  Caller must ensure serialization.
 static void scf_torture_stats_print(void)
 {
@@ -296,7 +332,7 @@ static void scf_handler(void *scfc_in)
 		if (scfcp->scfc_rpc)
 			complete(&scfcp->scfc_completion);
 	} else {
-		kfree(scfcp);
+		scf_add_to_free_list(scfcp);
 	}
 }
=20
@@ -363,7 +399,7 @@ static void scftorture_invoke_one(struct scf_statistics=
 *scfp, struct torture_ra
 				scfp->n_single_wait_ofl++;
 			else
 				scfp->n_single_ofl++;
-			kfree(scfcp);
+			scf_add_to_free_list(scfcp);
 			scfcp =3D NULL;
 		}
 		break;
@@ -391,7 +427,7 @@ static void scftorture_invoke_one(struct scf_statistics=
 *scfp, struct torture_ra
 				preempt_disable();
 		} else {
 			scfp->n_single_rpc_ofl++;
-			kfree(scfcp);
+			scf_add_to_free_list(scfcp);
 			scfcp =3D NULL;
 		}
 		break;
@@ -428,7 +464,7 @@ static void scftorture_invoke_one(struct scf_statistics=
 *scfp, struct torture_ra
 			pr_warn("%s: Memory-ordering failure, scfs_prim: %d.\n", __func__, scfs=
p->scfs_prim);
 			atomic_inc(&n_mb_out_errs); // Leak rather than trash!
 		} else {
-			kfree(scfcp);
+			scf_add_to_free_list(scfcp);
 		}
 		barrier(); // Prevent race-reduction compiler optimizations.
 	}
@@ -442,6 +478,7 @@ static void scftorture_invoke_one(struct scf_statistics=
 *scfp, struct torture_ra
 		schedule_timeout_uninterruptible(1);
 }
=20
+
 // SCF test kthread.  Repeatedly does calls to members of the
 // smp_call_function() family of functions.
 static int scftorture_invoker(void *arg)
@@ -479,6 +516,8 @@ static int scftorture_invoker(void *arg)
 	VERBOSE_SCFTORTOUT("scftorture_invoker %d started", scfp->cpu);
=20
 	do {
+		scf_cleanup_free_list(scfp->cpu);
+
 		scftorture_invoke_one(scfp, &rand);
 		while (cpu_is_offline(cpu) && !torture_must_stop()) {
 			schedule_timeout_interruptible(HZ / 5);
--=20
2.45.2


