Return-Path: <linux-kernel+bounces-204511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C998FEFF0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6BE51C222FA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554A41B580D;
	Thu,  6 Jun 2024 14:41:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED861B4C39;
	Thu,  6 Jun 2024 14:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684873; cv=none; b=WSHkwm59rF+g7l11NsCTm+Y42QWJjTA90cp3Sv519SwtzXSxv8jGbinLspvMqxNIQ49/MNGzhfS+tkPB877Okc8BRB7QMSTjJElzoZhr/b+7WpM1noLDLNmP9U4UBG15Qbxjw5dapbpu3ZjbzGRMvBqqVNUQAf9v4uPecr0eJM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684873; c=relaxed/simple;
	bh=YiuwC0oKHjhlIUUagY/XBVaj0Z56MxBbTJJsUKSWu9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=duU51qv9U/Vdsv21x9vfS1mOnu7gCTppvKp8+Ch6GgNXuA/wcobJ0WFI5BJaVeF3b5+Eld9DmReJ+weot0eAoDqES1Z56vBSMnkUZZCq7ussx7KYDwYHC6QaXh94KelZXZX9HHWnUeUbaxbw9aKWRxBUre17Cex9Rbo/jKs8dQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E62AD1042;
	Thu,  6 Jun 2024 07:41:35 -0700 (PDT)
Received: from e126817.cambridge.arm.com (e126817.cambridge.arm.com [10.2.3.5])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D2E293F64C;
	Thu,  6 Jun 2024 07:41:09 -0700 (PDT)
From: Ben Gainey <ben.gainey@arm.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: james.clark@arm.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ben Gainey <ben.gainey@arm.com>
Subject: [PATCH v7 3/4] tools/perf: Correctly calculate sample period for inherited SAMPLE_READ values
Date: Thu,  6 Jun 2024 15:40:58 +0100
Message-ID: <20240606144059.365633-4-ben.gainey@arm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606144059.365633-1-ben.gainey@arm.com>
References: <20240606144059.365633-1-ben.gainey@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sample period calculation is updated to take into account the fact that
events with inherit+PERF_SAMPLE_READ+PERF_SAMPLE_TID should use
the TID in combination with the ID field in the read_format data to
identify which value represents the previous accumulated counter total used to
calculate the period delta since the last sample.

perf_sample_id is modified to support tracking per-thread
values, along with the existing global per-id values. In the
per-thread case, values are stored in a hash by TID within the
perf_sample_id, and are dynamically allocated as the number is not known
ahead of time.

deliver_sample_value is modified to correctly locate the previous
sample storage based on the attribute, stream id and thread id.

Signed-off-by: Ben Gainey <ben.gainey@arm.com>
---
 tools/lib/perf/evsel.c                  | 41 ++++++++++++++++++++++
 tools/lib/perf/include/internal/evsel.h | 45 +++++++++++++++++++++++--
 tools/perf/util/session.c               | 11 ++++--
 3 files changed, 92 insertions(+), 5 deletions(-)

diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index f7abb879f416..26f3d7ba0f26 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -5,6 +5,7 @@
 #include <perf/evsel.h>
 #include <perf/cpumap.h>
 #include <perf/threadmap.h>
+#include <linux/hash.h>
 #include <linux/list.h>
 #include <internal/evsel.h>
 #include <linux/zalloc.h>
@@ -23,6 +24,7 @@ void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr,
 		      int idx)
 {
 	INIT_LIST_HEAD(&evsel->node);
+	INIT_LIST_HEAD(&evsel->per_stream_periods);
 	evsel->attr = *attr;
 	evsel->idx  = idx;
 	evsel->leader = evsel;
@@ -531,10 +533,17 @@ int perf_evsel__alloc_id(struct perf_evsel *evsel, int ncpus, int nthreads)
 
 void perf_evsel__free_id(struct perf_evsel *evsel)
 {
+	struct perf_sample_id_period *pos, *n;
+
 	xyarray__delete(evsel->sample_id);
 	evsel->sample_id = NULL;
 	zfree(&evsel->id);
 	evsel->ids = 0;
+
+	perf_evsel_for_each_per_thread_period_safe(evsel, n, pos) {
+		list_del_init(&pos->node);
+		free(pos);
+	}
 }
 
 bool perf_evsel__attr_has_per_thread_sample_period(struct perf_evsel *evsel)
@@ -544,6 +553,38 @@ bool perf_evsel__attr_has_per_thread_sample_period(struct perf_evsel *evsel)
 		&& evsel->attr.inherit;
 }
 
+u64 *perf_sample_id__get_period_storage(struct perf_sample_id *sid, u32 tid)
+{
+	struct hlist_head *head;
+	struct perf_sample_id_period *res;
+	int hash;
+
+	if (!sid->period_per_thread)
+		return &sid->period;
+
+	hash = hash_32(tid, PERF_SAMPLE_ID__HLIST_BITS);
+	head = &sid->periods[hash];
+
+	hlist_for_each_entry(res, head, hnode)
+		if (res->tid == tid)
+			return &res->period;
+
+	if (sid->evsel == NULL)
+		return NULL;
+
+	res = zalloc(sizeof(struct perf_sample_id_period));
+	if (res == NULL)
+		return NULL;
+
+	INIT_LIST_HEAD(&res->node);
+	res->tid = tid;
+
+	list_add_tail(&res->node, &sid->evsel->per_stream_periods);
+	hlist_add_head(&res->hnode, &sid->periods[hash]);
+
+	return &res->period;
+}
+
 void perf_counts_values__scale(struct perf_counts_values *count,
 			       bool scale, __s8 *pscaled)
 {
diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
index f8de2bf89c76..797dc9d78254 100644
--- a/tools/lib/perf/include/internal/evsel.h
+++ b/tools/lib/perf/include/internal/evsel.h
@@ -11,6 +11,32 @@
 struct perf_thread_map;
 struct xyarray;
 
+/**
+ * The per-thread accumulated period storage node.
+ */
+struct perf_sample_id_period {
+	struct list_head	node;
+	struct hlist_node	hnode;
+	/* Holds total ID period value for PERF_SAMPLE_READ processing. */
+	u64			period;
+	/* The TID that the values belongs to */
+	u32			tid;
+};
+
+/**
+ * perf_evsel_for_each_per_thread_period_safe - safely iterate thru all the
+ * per_stream_periods
+ * @evlist:perf_evsel instance to iterate
+ * @item: struct perf_sample_id_period iterator
+ * @tmp: struct perf_sample_id_period temp iterator
+ */
+#define perf_evsel_for_each_per_thread_period_safe(evsel, tmp, item) \
+	list_for_each_entry_safe(item, tmp, &(evsel)->per_stream_periods, node)
+
+
+#define PERF_SAMPLE_ID__HLIST_BITS 4
+#define PERF_SAMPLE_ID__HLIST_SIZE (1 << PERF_SAMPLE_ID__HLIST_BITS)
+
 /*
  * Per fd, to map back from PERF_SAMPLE_ID to evsel, only used when there are
  * more than one entry in the evlist.
@@ -34,8 +60,18 @@ struct perf_sample_id {
 	pid_t			 machine_pid;
 	struct perf_cpu		 vcpu;
 
-	/* Holds total ID period value for PERF_SAMPLE_READ processing. */
-	u64			 period;
+	union {
+		/*
+		 * Holds total ID period value for PERF_SAMPLE_READ processing
+		 * (when period is not per-thread).
+		 */
+		u64			period;
+		/*
+		 * Holds total ID period value for PERF_SAMPLE_READ processing
+		 * (when period is per-thread).
+		 */
+		struct hlist_head	periods[PERF_SAMPLE_ID__HLIST_SIZE];
+	};
 
 	/*
 	 * When inherit is combined with PERF_SAMPLE_READ, the period value is
@@ -65,6 +101,9 @@ struct perf_evsel {
 	u32			 ids;
 	struct perf_evsel	*leader;
 
+	/* Where period_per_thread is true, stores the per-thread values */
+	struct list_head	per_stream_periods;
+
 	/* parse modifier helper */
 	int			 nr_members;
 	/*
@@ -97,4 +136,6 @@ void perf_evsel__free_id(struct perf_evsel *evsel);
 
 bool perf_evsel__attr_has_per_thread_sample_period(struct perf_evsel *evsel);
 
+u64 *perf_sample_id__get_period_storage(struct perf_sample_id *sid, u32 tid);
+
 #endif /* __LIBPERF_INTERNAL_EVSEL_H */
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index a10343b9dcd4..cf5dbe075674 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1478,14 +1478,19 @@ static int deliver_sample_value(struct evlist *evlist,
 {
 	struct perf_sample_id *sid = evlist__id2sid(evlist, v->id);
 	struct evsel *evsel;
+	u64 *storage = NULL;
 
 	if (sid) {
+		storage  = perf_sample_id__get_period_storage(sid, sample->tid);
+	}
+
+	if (storage) {
 		sample->id     = v->id;
-		sample->period = v->value - sid->period;
-		sid->period    = v->value;
+		sample->period = v->value - *storage;
+		*storage       = v->value;
 	}
 
-	if (!sid || sid->evsel == NULL) {
+	if (!storage || sid->evsel == NULL) {
 		++evlist->stats.nr_unknown_id;
 		return 0;
 	}
-- 
2.45.2


