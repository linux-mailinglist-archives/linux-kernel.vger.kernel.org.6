Return-Path: <linux-kernel+bounces-401477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 384FA9C1AEB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC36EB23CA9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3551E3DF7;
	Fri,  8 Nov 2024 10:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xdgOfCvu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VHh+O/Et"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA981E2827
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 10:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731062548; cv=none; b=loPkWmdItSPPOSFQptLTDQqb05ZjZVgXf9kTvbH+6kFa5FNgndHwWwIiuldmJLvm8c75S9vYPI7WdJk39t7nNvroPDn9ooRoGJ9Uy8OMbNn/EhwJ6VXUckGYYQov+gfNsCtKoKo5AMVR0gfeAj+chTJwa1hgYUoDypTmOAVhCLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731062548; c=relaxed/simple;
	bh=JFVR1zGFp7skboDzHve0FaCWnfWzqjqAx8p6gEqk04Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sd1tdPJ9VAlleVNuAyui6lAJFnzgzLTcAkG9EHPixLRCumP1OnXpvLLdyzaqSQGpk/CgR2wi4FsmBNe6VjJnzU3smtvcrrxkc98h1W7Ds2k6UE/ar1nm0gU7CbB3RW8aFxlkb/+YJWtCuLEMXEq+xY6cG8nyZCMkCIlbIzzLNZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xdgOfCvu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VHh+O/Et; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731062544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5s/mGxOR1k0iGJwjIgx4Nn5xFVAEP6Fy1K6QavY6cWI=;
	b=xdgOfCvuilQldzQOMpNfqbhLBJWQ8hWgfi7YAXGqIUVsXt8dH2HKhMMZK1UbFE9QY6fyIt
	Ndu0wL+sCgqAC/jf70Ab7g3JUc+RIBuysBK44EcaCDJDT6QpDFHGFZyaI9tYZrJRVNE0lH
	1rvDfnBEtTP6crwTrkM2orUoU4mRhm015yD54+bkX+3gmce+fqFYPLFiSYlI4gn3V7gkBc
	X843XtQxebo2ejvgd4+2eT99hArk1xL+U1CP8B3rFM4QTQx9MG1wmepd/myNImYUo38nYr
	SB702ECMD7Wr1hbu4ix/ZGEtwoN9OAKQ5fZgPEdov9XmG257QZwRqDb8c9qcPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731062544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5s/mGxOR1k0iGJwjIgx4Nn5xFVAEP6Fy1K6QavY6cWI=;
	b=VHh+O/EtWZ3A16mOSU7KTf672Jd4VxY+gi5vSUz+Zg2VvhVa/0tjSabgMacEJVyXoKHUPJ
	JWW3RE0D3a8cazBw==
To: kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Marco Elver <elver@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	akpm@linux-foundation.org,
	cl@linux.com,
	iamjoonsoo.kim@lge.com,
	longman@redhat.com,
	penberg@kernel.org,
	rientjes@google.com,
	sfr@canb.auug.org.au,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 4/4] scftorture: Use a lock-less list to free memory.
Date: Fri,  8 Nov 2024 11:39:34 +0100
Message-ID: <20241108104217.3759904-5-bigeasy@linutronix.de>
In-Reply-To: <20241108104217.3759904-1-bigeasy@linutronix.de>
References: <20241108104217.3759904-1-bigeasy@linutronix.de>
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
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/scftorture.c | 40 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index e3c60f6dd5477..eeafd3fc16820 100644
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
@@ -148,6 +150,31 @@ static DEFINE_TORTURE_RANDOM_PERCPU(scf_torture_rand);
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
+
+	pool =3D &per_cpu(scf_free_pool, cpu);
+	node =3D llist_del_all(pool);
+	while (node) {
+		scfcp =3D llist_entry(node, struct scf_check, scf_node);
+		node =3D node->next;
+		kfree(scfcp);
+	}
+}
+
 // Print torture statistics.  Caller must ensure serialization.
 static void scf_torture_stats_print(void)
 {
@@ -296,7 +323,7 @@ static void scf_handler(void *scfc_in)
 		if (scfcp->scfc_rpc)
 			complete(&scfcp->scfc_completion);
 	} else {
-		kfree(scfcp);
+		scf_add_to_free_list(scfcp);
 	}
 }
=20
@@ -363,7 +390,7 @@ static void scftorture_invoke_one(struct scf_statistics=
 *scfp, struct torture_ra
 				scfp->n_single_wait_ofl++;
 			else
 				scfp->n_single_ofl++;
-			kfree(scfcp);
+			scf_add_to_free_list(scfcp);
 			scfcp =3D NULL;
 		}
 		break;
@@ -391,7 +418,7 @@ static void scftorture_invoke_one(struct scf_statistics=
 *scfp, struct torture_ra
 				preempt_disable();
 		} else {
 			scfp->n_single_rpc_ofl++;
-			kfree(scfcp);
+			scf_add_to_free_list(scfcp);
 			scfcp =3D NULL;
 		}
 		break;
@@ -428,7 +455,7 @@ static void scftorture_invoke_one(struct scf_statistics=
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
@@ -479,6 +506,8 @@ static int scftorture_invoker(void *arg)
 	VERBOSE_SCFTORTOUT("scftorture_invoker %d started", scfp->cpu);
=20
 	do {
+		scf_cleanup_free_list(cpu);
+
 		scftorture_invoke_one(scfp, &rand);
 		while (cpu_is_offline(cpu) && !torture_must_stop()) {
 			schedule_timeout_interruptible(HZ / 5);
@@ -529,6 +558,9 @@ static void scf_torture_cleanup(void)
 	kfree(scf_stats_p);  // -After- the last stats print has completed!
 	scf_stats_p =3D NULL;
=20
+	for (i =3D 0; i < nr_cpu_ids; i++)
+		scf_cleanup_free_list(i);
+
 	if (atomic_read(&n_errs) || atomic_read(&n_mb_in_errs) || atomic_read(&n_=
mb_out_errs))
 		scftorture_print_module_parms("End of test: FAILURE");
 	else if (torture_onoff_failures())
--=20
2.45.2


