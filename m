Return-Path: <linux-kernel+bounces-544624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6174FA4E348
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 943FE17F91C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17BF27D79C;
	Tue,  4 Mar 2025 15:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="31CVwZAa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oLzq2OcF"
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A2F265CA0
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101365; cv=pass; b=eKqnv7hA8df04R+abO3Wa4KQl0GfjOl62UjkbiW+R3Ocyk09JLurZhs3cwnhJrMSvpvhqBe133/J0AxxbyX0/VryoXUK3OLONZvARTsSxR1imtUUxdLH9QEAbahIMVvckTAtlui1fpgb+2jCVSTOid7TRjyl0iSp4o7qGPDrsc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101365; c=relaxed/simple;
	bh=29vKuSxFvBiNucjPfut9HKw36PNpgECcDRigNDSu8rQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Yl872D0dcjQJv1RrX4XRnyXBb7aDr9Xg0M6lY2wftK43gLQ3RTYI+oWf0V+On6gf/3cG90bnBIu7yCcQYfTMTVCG5E9MnWdzwTDaDFpx8vzup0VtkfcZUi96Uriso2XhRqu19SIoIZJmWzyG+tL+1d875e5xjtfZ2P28KwbcGK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=31CVwZAa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oLzq2OcF; arc=none smtp.client-ip=193.142.43.55; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; arc=pass smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (unknown [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id 6BF4140F1CED
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:16:02 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=temperror header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=31CVwZAa;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=oLzq2OcF
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fNh6pHTzFys3
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:14:28 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 337104272C; Tue,  4 Mar 2025 18:14:27 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=31CVwZAa;
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oLzq2OcF
X-Envelope-From: <linux-kernel+bounces-541703-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=31CVwZAa;
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oLzq2OcF
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 5EEB841CA1
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 15:29:59 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 35D673063EFC
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 15:29:59 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B6E018959C0
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC7F21129F;
	Mon,  3 Mar 2025 12:29:38 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5D51FF602;
	Mon,  3 Mar 2025 12:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741004974; cv=none; b=JOMDuBKGED9rnGI9NZqApzNCUnSTLgydtJDXSLf4ostolCnp/EzVPJA45q3hIt0NXykeAfgtVp9VYw4cdtiwvqSnswxDUAKS2Zf+x7Aq4NtP9KLM6OtoMbIg0l1Jm1Q18t+W7SqIdXr7psPjuE6ao8zz2RudOv+4dkL++opdWF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741004974; c=relaxed/simple;
	bh=29vKuSxFvBiNucjPfut9HKw36PNpgECcDRigNDSu8rQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ij702eqzXDKJFmkkC1gkB29lkXM/RVR9jZoDxOXEslWsG4VOemHmEZsbEJMQlODrjvTsxD/DaP4xE3smG8Pg0SbqQ6SADPB2zXaKhdbgmimx6yL0rwKKwQMzpxMO47PzcCfZLFL37goghlqw8e5giLaFKtPoLuuKR9zHU0hl3UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=31CVwZAa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oLzq2OcF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 12:29:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741004971;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jrf4aZqmcHUA7SyBAF6oygLynG7+fZqWMGqGUVEioQk=;
	b=31CVwZAadzUUiRBbJor2mPkNmXFtG5W/V+ogUjUIbLzU63/GAry9BohJWL2NnBJNkzymYn
	ajuYvcBUd7pUyyxu1YNo0GELGPxtwWW/BDHv8/OWG3JKAtb0Uce8vv6fSS2Mxyd3Q+I0Ng
	u31ido2yQU9x6Lo4DoH4YPxwzSjQ9wxlh1ZkqgvhcgnO4OuMhS/mF1D5mfJFGaoF1N4WEc
	rgSAldNfC578ygZWX34soYdGusjuW0rfRIIipfBk3TFSm3lt4dwTghu25heOOnefBctEH9
	vzQYTwARN3bwWv4CFFS791RzR6wZAr2f6DPTkoo5+pVNrAfLDSOAFUxRtaWIOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741004971;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jrf4aZqmcHUA7SyBAF6oygLynG7+fZqWMGqGUVEioQk=;
	b=oLzq2OcFbIR4QeDhk5djILidvkPNxywbrVMuX4Mevr/PdFH2bhNb7ij5PGqFENK3d6/yLv
	a7H+ME130KIj2zAA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Detach 'struct perf_cpu_pmu_context' and
 'struct pmu' lifetimes
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241104135518.760214287@infradead.org>
References: <20241104135518.760214287@infradead.org>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174100497060.10177.13409371343847213450.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fNh6pHTzFys3
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741706088.86215@579SFHW2bvMLo0z0rFU6EQ
X-ITU-MailScanner-SpamCheck: not spam

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     f67d1ffd841f31bc4a1314bc7f0a973ba77f39a5
Gitweb:        https://git.kernel.org/tip/f67d1ffd841f31bc4a1314bc7f0a973ba77f39a5
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 04 Nov 2024 14:39:20 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 03 Mar 2025 13:24:12 +01:00

perf/core: Detach 'struct perf_cpu_pmu_context' and 'struct pmu' lifetimes

In prepration for being able to unregister a PMU with existing events,
it becomes important to detach struct perf_cpu_pmu_context lifetimes
from that of struct pmu.

Notably struct perf_cpu_pmu_context embeds a struct perf_event_pmu_context
that can stay referenced until the last event goes.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20241104135518.760214287@infradead.org
---
 include/linux/perf_event.h |  4 +--
 kernel/events/core.c       | 56 +++++++++++++++++++++++++++++++------
 2 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 5f293e6..76f4265 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -343,7 +343,7 @@ struct pmu {
 	 */
 	unsigned int			scope;
 
-	struct perf_cpu_pmu_context __percpu *cpu_pmu_context;
+	struct perf_cpu_pmu_context __percpu **cpu_pmu_context;
 	atomic_t			exclusive_cnt; /* < 0: cpu; > 0: tsk */
 	int				task_ctx_nr;
 	int				hrtimer_interval_ms;
@@ -922,7 +922,7 @@ struct perf_event_pmu_context {
 	struct list_head		pinned_active;
 	struct list_head		flexible_active;
 
-	/* Used to avoid freeing per-cpu perf_event_pmu_context */
+	/* Used to identify the per-cpu perf_event_pmu_context */
 	unsigned int			embedded : 1;
 
 	unsigned int			nr_events;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 773875a..8b2a8c3 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1219,7 +1219,7 @@ static int perf_mux_hrtimer_restart_ipi(void *arg)
 
 static __always_inline struct perf_cpu_pmu_context *this_cpc(struct pmu *pmu)
 {
-	return this_cpu_ptr(pmu->cpu_pmu_context);
+	return *this_cpu_ptr(pmu->cpu_pmu_context);
 }
 
 void perf_pmu_disable(struct pmu *pmu)
@@ -5007,11 +5007,14 @@ find_get_pmu_context(struct pmu *pmu, struct perf_event_context *ctx,
 		 */
 		struct perf_cpu_pmu_context *cpc;
 
-		cpc = per_cpu_ptr(pmu->cpu_pmu_context, event->cpu);
+		cpc = *per_cpu_ptr(pmu->cpu_pmu_context, event->cpu);
 		epc = &cpc->epc;
 		raw_spin_lock_irq(&ctx->lock);
 		if (!epc->ctx) {
-			atomic_set(&epc->refcount, 1);
+			/*
+			 * One extra reference for the pmu; see perf_pmu_free().
+			 */
+			atomic_set(&epc->refcount, 2);
 			epc->embedded = 1;
 			list_add(&epc->pmu_ctx_entry, &ctx->pmu_ctx_list);
 			epc->ctx = ctx;
@@ -5087,6 +5090,15 @@ static void get_pmu_ctx(struct perf_event_pmu_context *epc)
 	WARN_ON_ONCE(!atomic_inc_not_zero(&epc->refcount));
 }
 
+static void free_cpc_rcu(struct rcu_head *head)
+{
+	struct perf_cpu_pmu_context *cpc =
+		container_of(head, typeof(*cpc), epc.rcu_head);
+
+	kfree(cpc->epc.task_ctx_data);
+	kfree(cpc);
+}
+
 static void free_epc_rcu(struct rcu_head *head)
 {
 	struct perf_event_pmu_context *epc = container_of(head, typeof(*epc), rcu_head);
@@ -5121,8 +5133,10 @@ static void put_pmu_ctx(struct perf_event_pmu_context *epc)
 
 	raw_spin_unlock_irqrestore(&ctx->lock, flags);
 
-	if (epc->embedded)
+	if (epc->embedded) {
+		call_rcu(&epc->rcu_head, free_cpc_rcu);
 		return;
+	}
 
 	call_rcu(&epc->rcu_head, free_epc_rcu);
 }
@@ -11752,7 +11766,7 @@ perf_event_mux_interval_ms_store(struct device *dev,
 	cpus_read_lock();
 	for_each_online_cpu(cpu) {
 		struct perf_cpu_pmu_context *cpc;
-		cpc = per_cpu_ptr(pmu->cpu_pmu_context, cpu);
+		cpc = *per_cpu_ptr(pmu->cpu_pmu_context, cpu);
 		cpc->hrtimer_interval = ns_to_ktime(NSEC_PER_MSEC * timer);
 
 		cpu_function_call(cpu, perf_mux_hrtimer_restart_ipi, cpc);
@@ -11925,7 +11939,25 @@ static void perf_pmu_free(struct pmu *pmu)
 		device_del(pmu->dev);
 		put_device(pmu->dev);
 	}
-	free_percpu(pmu->cpu_pmu_context);
+
+	if (pmu->cpu_pmu_context) {
+		int cpu;
+
+		for_each_possible_cpu(cpu) {
+			struct perf_cpu_pmu_context *cpc;
+
+			cpc = *per_cpu_ptr(pmu->cpu_pmu_context, cpu);
+			if (!cpc)
+				continue;
+			if (cpc->epc.embedded) {
+				/* refcount managed */
+				put_pmu_ctx(&cpc->epc);
+				continue;
+			}
+			kfree(cpc);
+		}
+		free_percpu(pmu->cpu_pmu_context);
+	}
 }
 
 DEFINE_FREE(pmu_unregister, struct pmu *, if (_T) perf_pmu_free(_T))
@@ -11964,14 +11996,20 @@ int perf_pmu_register(struct pmu *_pmu, const char *name, int type)
 			return ret;
 	}
 
-	pmu->cpu_pmu_context = alloc_percpu(struct perf_cpu_pmu_context);
+	pmu->cpu_pmu_context = alloc_percpu(struct perf_cpu_pmu_context *);
 	if (!pmu->cpu_pmu_context)
 		return -ENOMEM;
 
 	for_each_possible_cpu(cpu) {
-		struct perf_cpu_pmu_context *cpc;
+		struct perf_cpu_pmu_context *cpc =
+			kmalloc_node(sizeof(struct perf_cpu_pmu_context),
+				     GFP_KERNEL | __GFP_ZERO,
+				     cpu_to_node(cpu));
+
+		if (!cpc)
+			return -ENOMEM;
 
-		cpc = per_cpu_ptr(pmu->cpu_pmu_context, cpu);
+		*per_cpu_ptr(pmu->cpu_pmu_context, cpu) = cpc;
 		__perf_init_event_pmu_context(&cpc->epc, pmu);
 		__perf_mux_hrtimer_init(cpc, cpu);
 	}


