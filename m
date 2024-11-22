Return-Path: <linux-kernel+bounces-418412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4555A9D615A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2807B246E3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 15:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC9D4207F;
	Fri, 22 Nov 2024 15:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fv1XDMqg";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fv1XDMqg"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA3DBA20
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 15:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732289346; cv=none; b=CCD+2nACrOzZrLy/YhcL8GhiQy3iOQjwIrPSB2T1CVvLvkpl8eozRA4q0gMiJrkDOfpsPShwOC0u9d+PqExWKmZPG7fy6rGt7PB2K0bVRqGKg2kdZ8hkA5X0wmwiyBwN30d1cZxgIQgxSx6OunxcT9lQ0IG2pp5NfL9y58sS154=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732289346; c=relaxed/simple;
	bh=CvWQomH5tQ6WDIkRGoA7mGBzdXNqYounsIFzF/JVQoY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I3jKTihwQrdvO5MO1Xpft2ILoubdzi3h5O4c9eEJkQAxg13co2N83HadlMi7uInPvO/elMwexaK6U3/REDvZqxYS9tu1KhQsfGuvaBv7G2mxcZT/L7r7jhos6nGXSYs1Cqxnelabu2KnYEUrd6m2IdgcroliSf28PfUVoG1lw8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fv1XDMqg; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fv1XDMqg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3E1391F37E;
	Fri, 22 Nov 2024 15:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1732289342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dctTZVVrxmtSkDVloqVLA9R/1bskoOXpW2WzccMFbw0=;
	b=fv1XDMqglSodbAkVca1VFf/PFrCypquUYX+Kp0bW2T2QUx89yiP91WxG9Q5cGoZxiGQSYO
	pwNZz8cpuMoLIZIfxkJ5rBXJpb2Yqcd3jsiWVroT//JH1+vdRe1JFwa0USWx/HEhWhmmAT
	wnIuOxX2KysyE9vyoICRcNeIULT5Ta4=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=fv1XDMqg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1732289342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dctTZVVrxmtSkDVloqVLA9R/1bskoOXpW2WzccMFbw0=;
	b=fv1XDMqglSodbAkVca1VFf/PFrCypquUYX+Kp0bW2T2QUx89yiP91WxG9Q5cGoZxiGQSYO
	pwNZz8cpuMoLIZIfxkJ5rBXJpb2Yqcd3jsiWVroT//JH1+vdRe1JFwa0USWx/HEhWhmmAT
	wnIuOxX2KysyE9vyoICRcNeIULT5Ta4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1709813998;
	Fri, 22 Nov 2024 15:29:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HrbgBD6jQGfqewAAD6G6ig
	(envelope-from <neelx@suse.com>); Fri, 22 Nov 2024 15:29:02 +0000
From: Daniel Vacek <neelx@suse.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: Daniel Vacek <neelx@suse.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched/fair: properly serialize the cfs_rq h_load calculation
Date: Fri, 22 Nov 2024 16:28:55 +0100
Message-ID: <20241122152856.3533625-1-neelx@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3E1391F37E
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Make sure the given cfs_rq's h_load is always correctly updated. This
prevents a race between more CPUs eventually updating the same hierarchy
of h_load_next return pointers.

Signed-off-by: Daniel Vacek <neelx@suse.com>
---
 kernel/sched/fair.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2d16c8545c71..50794ba0db75 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9786,6 +9786,8 @@ static bool __update_blocked_fair(struct rq *rq, bool *done)
 	return decayed;
 }
 
+static DEFINE_PER_CPU(raw_spinlock_t, h_load_lock);
+
 /*
  * Compute the hierarchical load factor for cfs_rq and all its ascendants.
  * This needs to be done in a top-down fashion because the load of a child
@@ -9793,18 +9795,26 @@ static bool __update_blocked_fair(struct rq *rq, bool *done)
  */
 static void update_cfs_rq_h_load(struct cfs_rq *cfs_rq)
 {
-	struct rq *rq = rq_of(cfs_rq);
-	struct sched_entity *se = cfs_rq->tg->se[cpu_of(rq)];
+	int cpu = cpu_of(rq_of(cfs_rq));
+	struct sched_entity *se = cfs_rq->tg->se[cpu];
+	raw_spinlock_t * lock;
 	unsigned long now = jiffies;
 	unsigned long load;
 
 	if (cfs_rq->last_h_load_update == now)
 		return;
 
-	WRITE_ONCE(cfs_rq->h_load_next, NULL);
+	/* Protects cfs_rq->h_load_next and cfs_rq->last_h_load_update */
+	raw_spin_lock(lock = &per_cpu(h_load_lock, cpu));
+
+	now = jiffies;
+	if (cfs_rq->last_h_load_update == now)
+		goto unlock;
+
+	cfs_rq->h_load_next = NULL;
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
-		WRITE_ONCE(cfs_rq->h_load_next, se);
+		cfs_rq->h_load_next = se;
 		if (cfs_rq->last_h_load_update == now)
 			break;
 	}
@@ -9814,7 +9824,7 @@ static void update_cfs_rq_h_load(struct cfs_rq *cfs_rq)
 		cfs_rq->last_h_load_update = now;
 	}
 
-	while ((se = READ_ONCE(cfs_rq->h_load_next)) != NULL) {
+	while ((se = cfs_rq->h_load_next) != NULL) {
 		load = cfs_rq->h_load;
 		load = div64_ul(load * se->avg.load_avg,
 			cfs_rq_load_avg(cfs_rq) + 1);
@@ -9822,6 +9832,8 @@ static void update_cfs_rq_h_load(struct cfs_rq *cfs_rq)
 		cfs_rq->h_load = load;
 		cfs_rq->last_h_load_update = now;
 	}
+unlock:
+	raw_spin_unlock(lock);
 }
 
 static unsigned long task_h_load(struct task_struct *p)
@@ -13665,6 +13677,9 @@ __init void init_sched_fair_class(void)
 		zalloc_cpumask_var_node(&per_cpu(should_we_balance_tmpmask, i),
 					GFP_KERNEL, cpu_to_node(i));
 
+#ifdef CONFIG_FAIR_GROUP_SCHED
+		raw_spin_lock_init(&per_cpu(h_load_lock, i));
+#endif
 #ifdef CONFIG_CFS_BANDWIDTH
 		INIT_CSD(&cpu_rq(i)->cfsb_csd, __cfsb_csd_unthrottle, cpu_rq(i));
 		INIT_LIST_HEAD(&cpu_rq(i)->cfsb_csd_list);
-- 
2.45.2


