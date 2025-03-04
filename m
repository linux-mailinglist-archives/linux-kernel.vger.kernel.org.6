Return-Path: <linux-kernel+bounces-543527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F96A4D6C9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 390D73A912E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D18E1FCFC0;
	Tue,  4 Mar 2025 08:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MfQwYS2F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1151FCF6D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741077703; cv=none; b=ozGJ9kufyASX3L6+Wuo0eraTTx98xbXuEmXVQr8AYIbXcqWWDeeBn6NbBnRHzHlSr53kR33ma/tEDe081r1uKkOUxdGc6Iu4XHSXdhcxinCoNTD+ZK6dseq9xsWRvro8EImpm5+OpkxeXxIpS2ARbsK6lP4A++BC0MIEJRgWknA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741077703; c=relaxed/simple;
	bh=yOMmG4F+0IRyt05rEQipisgEioriUYETBt8L3slir/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/aLDkPYgeQNKVC4bw/7eNgY/cvyvFrWY2be2FGtQcTGSo90tdCdnr95mdEFRxXYwDFE0Qxq68TVA9EmgbVA8sGHg+L9LZ6ww6QvaUVZlaVC9O9kjkc5ewmx/v1vObYURYWtmCgKtVBxp6Y1zio54JNGwVg65hOUC18Ylm/bMJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MfQwYS2F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741077700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f+Iw2z/BRuGJ7vkBn/7Z4Zbuxcza/Q4iTwJq/UC45V0=;
	b=MfQwYS2FAeyrAqB5RXlelQwZTGORbL4VBHWoSduWEOaonwZ2wFkvXLy0tNkhVkRiwZKz33
	RM6udGAbhPY/huKTum3HEiBZNrMPrIh6r47V1uqCHl49y7/prL32d52y1/o86rItJ/rF1N
	CKSV0+7WiHVf/HO/hFQTvJfu6GkChVE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-fazlRea5M6CxW-Tb7iVlnA-1; Tue, 04 Mar 2025 03:41:27 -0500
X-MC-Unique: fazlRea5M6CxW-Tb7iVlnA-1
X-Mimecast-MFC-AGG-ID: fazlRea5M6CxW-Tb7iVlnA_1741077687
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c0c1025adbso1345709985a.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 00:41:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741077684; x=1741682484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f+Iw2z/BRuGJ7vkBn/7Z4Zbuxcza/Q4iTwJq/UC45V0=;
        b=qyYI/rpgjNm97s58lgGpSFCYmveKANZ+MsGBVNHEcfUaQkYUL+D6vvHZffDefLtP0z
         UKAMU4OYCKqKnfpL95opFhSrIpzQBtQLVdckJYYq4nNwthrz3QdpoLwk+5e2qChCNNh6
         FLqCl/Srt2hXm4lOqOhuimwYjALxAImlH4XlGnKDC3yS8lmVyF34jdBQ8xCgx2WuVAJP
         IvIgb2UND0qUTvwj9i3RalfVvvstpWyOG31DLhedSWtI0j8gPjuOJH5umi9Xp0abcPj5
         0sSmmg7lzizaKz2ouBDBqN9dQ2sPKzsTQFrnKMRbQlW1k5xbjXj9k/vj6hHUj63OBOjz
         lHEw==
X-Gm-Message-State: AOJu0YwekrbzRmRonvBEXA1G3yjyEfZgJ9oB6B9zOANohqqyV/61s2sS
	vmUw8U9k0CVlAIwIYQUZXn24Z0oUCPVrJQkLHbubyaMoYvZgo9Ns9GpEqt+T6Ujk4u2SuswBVOh
	xF6I0QCudLCnbrzyPdmtbXcCJsgJKWK0ObWtOX3BxqIAZs06Rsz4J8QaSGH61vMkccR31sQplrK
	bbCleoy9hX0pFwvqBuQwCYe3Rk79CMUQ45noeeRVXJGgtXsKuzSdML3g==
X-Gm-Gg: ASbGncu9gwL3ToCu9A8h9VU6RTN87TsYL21evMbhJHWpYWzkWoXMKulzdqu1b/pJq8T
	kCur/o7NoA1MmM0rx8Xf9MH0egk+lBVdriIJj2LWOFbfs5vUc6kADgaNFCyCxPPGW7morFOZSGG
	TBQFjyRN0B2KJsS6yeexqKEolSYYvluB1dMw1o3W2jMM84KeabTlW7sfqXwfpzk262db3ZH1ePn
	LStylAOEXsbda0bAdmj9gb2nWL9u2W6A1l2+SUIKNNZrkTGBdmL9jqin34WOxzlv2wXGPEfeU/f
	rEq81Ar6LDfvztF7f8e1sLNhAslDWeP84Mifdh52wBLR+wUaHtAIi9wdjQEWP4rrHaCRFYs2B0F
	pT53H
X-Received: by 2002:a05:620a:31a8:b0:7c0:be25:96b2 with SMTP id af79cd13be357-7c39c4cf214mr1890138585a.29.1741077684225;
        Tue, 04 Mar 2025 00:41:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2dv8oocEYlP7qNDy6OtgnQyJS5jsjJUGl9HCqO84LUslvKxlY2F6e312WErj0Wi6SerUOhw==
X-Received: by 2002:a05:620a:31a8:b0:7c0:be25:96b2 with SMTP id af79cd13be357-7c39c4cf214mr1890134785a.29.1741077683762;
        Tue, 04 Mar 2025 00:41:23 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3c0a94fbbsm218395285a.1.2025.03.04.00.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 00:41:20 -0800 (PST)
From: Juri Lelli <juri.lelli@redhat.com>
To: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Phil Auld <pauld@redhat.com>,
	luca.abeni@santannapisa.it,
	tommaso.cucinotta@santannapisa.it,
	Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 3/5] sched/deadline: Generalize unique visiting of root domains
Date: Tue,  4 Mar 2025 08:40:43 +0000
Message-ID: <20250304084045.62554-4-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304084045.62554-1-juri.lelli@redhat.com>
References: <20250304084045.62554-1-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bandwidth checks and updates that work on root domains currently employ
a cookie mechanism for efficiency. This mechanism is very much tied to
when root domains are first created and initialized.

Generalize the cookie mechanism so that it can be used also later at
runtime while updating root domains. Also, additionally guard it with
sched_domains_mutex, since domains need to be stable while updating them
(and it will be required for further dynamic changes).

Reported-by: Jon Hunter <jonathanh@nvidia.com>
Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 include/linux/sched/deadline.h |  3 +++
 kernel/sched/deadline.c        | 23 +++++++++++++----------
 kernel/sched/rt.c              |  2 ++
 kernel/sched/sched.h           |  2 +-
 kernel/sched/topology.c        |  2 +-
 5 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
index 3a912ab42bb5..6ec578600b24 100644
--- a/include/linux/sched/deadline.h
+++ b/include/linux/sched/deadline.h
@@ -37,4 +37,7 @@ extern void dl_clear_root_domain(struct root_domain *rd);
 
 #endif /* CONFIG_SMP */
 
+extern u64 dl_cookie;
+extern bool dl_bw_visited(int cpu, u64 cookie);
+
 #endif /* _LINUX_SCHED_DEADLINE_H */
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index ab565a151355..339434271cba 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -166,14 +166,14 @@ static inline unsigned long dl_bw_capacity(int i)
 	}
 }
 
-static inline bool dl_bw_visited(int cpu, u64 gen)
+static inline bool dl_bw_visited(int cpu, u64 cookie)
 {
 	struct root_domain *rd = cpu_rq(cpu)->rd;
 
-	if (rd->visit_gen == gen)
+	if (rd->visit_cookie == cookie)
 		return true;
 
-	rd->visit_gen = gen;
+	rd->visit_cookie = cookie;
 	return false;
 }
 
@@ -207,7 +207,7 @@ static inline unsigned long dl_bw_capacity(int i)
 	return SCHED_CAPACITY_SCALE;
 }
 
-static inline bool dl_bw_visited(int cpu, u64 gen)
+static inline bool dl_bw_visited(int cpu, u64 cookie)
 {
 	return false;
 }
@@ -3171,15 +3171,18 @@ DEFINE_SCHED_CLASS(dl) = {
 #endif
 };
 
-/* Used for dl_bw check and update, used under sched_rt_handler()::mutex */
-static u64 dl_generation;
+/*
+ * Used for dl_bw check and update, used under sched_rt_handler()::mutex and
+ * sched_domains_mutex.
+ */
+u64 dl_cookie;
 
 int sched_dl_global_validate(void)
 {
 	u64 runtime = global_rt_runtime();
 	u64 period = global_rt_period();
 	u64 new_bw = to_ratio(period, runtime);
-	u64 gen = ++dl_generation;
+	u64 cookie = ++dl_cookie;
 	struct dl_bw *dl_b;
 	int cpu, cpus, ret = 0;
 	unsigned long flags;
@@ -3192,7 +3195,7 @@ int sched_dl_global_validate(void)
 	for_each_possible_cpu(cpu) {
 		rcu_read_lock_sched();
 
-		if (dl_bw_visited(cpu, gen))
+		if (dl_bw_visited(cpu, cookie))
 			goto next;
 
 		dl_b = dl_bw_of(cpu);
@@ -3229,7 +3232,7 @@ static void init_dl_rq_bw_ratio(struct dl_rq *dl_rq)
 void sched_dl_do_global(void)
 {
 	u64 new_bw = -1;
-	u64 gen = ++dl_generation;
+	u64 cookie = ++dl_cookie;
 	struct dl_bw *dl_b;
 	int cpu;
 	unsigned long flags;
@@ -3240,7 +3243,7 @@ void sched_dl_do_global(void)
 	for_each_possible_cpu(cpu) {
 		rcu_read_lock_sched();
 
-		if (dl_bw_visited(cpu, gen)) {
+		if (dl_bw_visited(cpu, cookie)) {
 			rcu_read_unlock_sched();
 			continue;
 		}
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 4b8e33c615b1..8cebe71d2bb1 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2910,6 +2910,7 @@ static int sched_rt_handler(const struct ctl_table *table, int write, void *buff
 	int ret;
 
 	mutex_lock(&mutex);
+	sched_domains_mutex_lock();
 	old_period = sysctl_sched_rt_period;
 	old_runtime = sysctl_sched_rt_runtime;
 
@@ -2936,6 +2937,7 @@ static int sched_rt_handler(const struct ctl_table *table, int write, void *buff
 		sysctl_sched_rt_period = old_period;
 		sysctl_sched_rt_runtime = old_runtime;
 	}
+	sched_domains_mutex_unlock();
 	mutex_unlock(&mutex);
 
 	return ret;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c8512a9fb022..c978abe38c07 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -998,7 +998,7 @@ struct root_domain {
 	 * Also, some corner cases, like 'wrap around' is dangerous, but given
 	 * that u64 is 'big enough'. So that shouldn't be a concern.
 	 */
-	u64 visit_gen;
+	u64 visit_cookie;
 
 #ifdef HAVE_RT_PUSH_IPI
 	/*
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index e2b879ec9458..b70d6002bb93 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -573,7 +573,7 @@ static int init_rootdomain(struct root_domain *rd)
 	rd->rto_push_work = IRQ_WORK_INIT_HARD(rto_push_irq_work_func);
 #endif
 
-	rd->visit_gen = 0;
+	rd->visit_cookie = 0;
 	init_dl_bw(&rd->dl_bw);
 	if (cpudl_init(&rd->cpudl) != 0)
 		goto free_rto_mask;
-- 
2.48.1


