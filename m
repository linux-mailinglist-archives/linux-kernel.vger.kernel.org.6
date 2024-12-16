Return-Path: <linux-kernel+bounces-447370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3129F3145
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 14:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5457318839A6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77866205E11;
	Mon, 16 Dec 2024 13:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fbli0Etb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D56205AAF
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 13:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734354574; cv=none; b=LkBTDU+SwIOJzocaqe1E8wbsoBXv/53HH7Gl872rMyFkQpg0n63uY4xUPz2twCjLBCeWRPJqUWLf2E3bsEuZU14Yi6TUT50UGiZ7VPS/2FaaCvaqhjuD2O8kotxHhmqlcby5h+KYVP3NH6TyibShea4x2by+hZANCzm44/ePoiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734354574; c=relaxed/simple;
	bh=T70vG6L8jn8l8he2hnx4huyfOdSMAiIoBEhRIs90Qaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b3/nduBzwDt1oce4AqKCQwQ8fMEqtsjR3ccgQ+fksFc/Fftj/7owsvERNSYw/roaWU1MolQdnrsjxZFALjgj0VTb+Wae8vEd4q9x01qc0AYi6+r/bK6x9oatpoiRDG+T2rqJ18UUlrtaUi0SHNe93cJMjdYsSrLyPtsCz4gc8Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fbli0Etb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734354572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uZtDN64Xh2i1EouKa8fldcRUrzUUze6qMnOFRIwRqYA=;
	b=fbli0Etb69xd47RyS7Jvx34l+cvwN+zS0JYqfzeyqmPvxpLa0zJ3IsEnTJ21xAMGC4MGGj
	UQ6IeuVFaRRDsg2qlG54wsSnH5u4IuecA/a8kTzolY5dZaN6ApksGiTXPR8fODP1Rq4qsi
	/KwT2t/5h3DudZVg0VARVDvjqZbRfD0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-MiaLR4PnNt-nwN18nbzrrQ-1; Mon,
 16 Dec 2024 08:09:29 -0500
X-MC-Unique: MiaLR4PnNt-nwN18nbzrrQ-1
X-Mimecast-MFC-AGG-ID: MiaLR4PnNt-nwN18nbzrrQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 101CD19560B3;
	Mon, 16 Dec 2024 13:09:28 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.39.193.102])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E51BA1956052;
	Mon, 16 Dec 2024 13:09:24 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH v3 3/3] rseq/selftests: Add test for mm_cid compaction
Date: Mon, 16 Dec 2024 14:09:09 +0100
Message-ID: <20241216130909.240042-4-gmonaco@redhat.com>
In-Reply-To: <20241216130909.240042-1-gmonaco@redhat.com>
References: <20241216130909.240042-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

A task in the kernel (task_mm_cid_work) runs somewhat periodically to
compact the mm_cid for each process, this test tries to validate that
it runs correctly and timely.

The test spawns 1 thread pinned to each CPU, then each thread, including
the main one, runs in short bursts for some time. During this period, the
mm_cids should be spanning all numbers between 0 and nproc.

At the end of this phase, a thread with high enough mm_cid (>= nproc/2)
is selected to be the new leader, all other threads terminate.

After some time, the only running thread should see 0 as mm_cid, if that
doesn't happen, the compaction mechanism didn't work and the test fails.

The test never fails if only 1 core is available, in which case, we
cannot test anything as the only available mm_cid is 0.

To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/testing/selftests/rseq/.gitignore       |   1 +
 tools/testing/selftests/rseq/Makefile         |   2 +-
 .../selftests/rseq/mm_cid_compaction_test.c   | 190 ++++++++++++++++++
 3 files changed, 192 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/rseq/mm_cid_compaction_test.c

diff --git a/tools/testing/selftests/rseq/.gitignore b/tools/testing/selftests/rseq/.gitignore
index 16496de5f6ce..2c89f97e4f73 100644
--- a/tools/testing/selftests/rseq/.gitignore
+++ b/tools/testing/selftests/rseq/.gitignore
@@ -3,6 +3,7 @@ basic_percpu_ops_test
 basic_percpu_ops_mm_cid_test
 basic_test
 basic_rseq_op_test
+mm_cid_compaction_test
 param_test
 param_test_benchmark
 param_test_compare_twice
diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
index 5a3432fceb58..ce1b38f46a35 100644
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -16,7 +16,7 @@ OVERRIDE_TARGETS = 1
 
 TEST_GEN_PROGS = basic_test basic_percpu_ops_test basic_percpu_ops_mm_cid_test param_test \
 		param_test_benchmark param_test_compare_twice param_test_mm_cid \
-		param_test_mm_cid_benchmark param_test_mm_cid_compare_twice
+		param_test_mm_cid_benchmark param_test_mm_cid_compare_twice mm_cid_compaction_test
 
 TEST_GEN_PROGS_EXTENDED = librseq.so
 
diff --git a/tools/testing/selftests/rseq/mm_cid_compaction_test.c b/tools/testing/selftests/rseq/mm_cid_compaction_test.c
new file mode 100644
index 000000000000..e5557b38a4e9
--- /dev/null
+++ b/tools/testing/selftests/rseq/mm_cid_compaction_test.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: LGPL-2.1
+#define _GNU_SOURCE
+#include <assert.h>
+#include <pthread.h>
+#include <sched.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stddef.h>
+
+#include "../kselftest.h"
+#include "rseq.h"
+
+#define VERBOSE 0
+#define printf_verbose(fmt, ...)                    \
+	do {                                        \
+		if (VERBOSE)                        \
+			printf(fmt, ##__VA_ARGS__); \
+	} while (0)
+
+/* 0.5 s */
+#define RUNNER_PERIOD 500000
+/* Number of runs before we terminate or get the token */
+#define THREAD_RUNS 5
+
+/*
+ * Number of times we check that the mm_cid were compacted.
+ * Checks are repeated every RUNNER_PERIOD
+ */
+#define MM_CID_COMPACT_TIMEOUT 10
+
+struct thread_args {
+	int cpu;
+	int num_cpus;
+	pthread_mutex_t *token;
+	pthread_t *tinfo;
+	struct thread_args *args_head;
+};
+
+static void *thread_runner(void *arg)
+{
+	struct thread_args *args = arg;
+	int i, ret, curr_mm_cid;
+	cpu_set_t affinity;
+
+	CPU_ZERO(&affinity);
+	CPU_SET(args->cpu, &affinity);
+	ret = pthread_setaffinity_np(pthread_self(), sizeof(affinity), &affinity);
+	if (ret) {
+		fprintf(stderr,
+			"Error: failed to set affinity to thread %d (%d): %s\n",
+			args->cpu, ret, strerror(ret));
+		assert(ret == 0);
+	}
+	for (i = 0; i < THREAD_RUNS; i++)
+		usleep(RUNNER_PERIOD);
+	curr_mm_cid = rseq_current_mm_cid();
+	/*
+	 * We select one thread with high enough mm_cid to be the new leader
+	 * all other threads (including the main thread) will terminate
+	 * After some time, the mm_cid of the only remaining thread should
+	 * converge to 0, if not, the test fails
+	 */
+	if (curr_mm_cid >= args->num_cpus / 2 &&
+	    !pthread_mutex_trylock(args->token)) {
+		printf_verbose("cpu%d has %d and will be the new leader\n",
+			       sched_getcpu(), curr_mm_cid);
+		for (i = 0; i < args->num_cpus; i++) {
+			if (args->tinfo[i] == pthread_self())
+				continue;
+			ret = pthread_join(args->tinfo[i], NULL);
+			if (ret) {
+				fprintf(stderr,
+					"Error: failed to join thread %d (%d): %s\n",
+					i, ret, strerror(ret));
+				assert(ret == 0);
+			}
+		}
+		free(args->tinfo);
+		free(args->token);
+		free(args->args_head);
+
+		for (i = 0; i < MM_CID_COMPACT_TIMEOUT; i++) {
+			curr_mm_cid = rseq_current_mm_cid();
+			printf_verbose("run %d: mm_cid %d on cpu%d\n", i,
+				       curr_mm_cid, sched_getcpu());
+			if (curr_mm_cid == 0) {
+				printf_verbose(
+					"mm_cids successfully compacted, exiting\n");
+				pthread_exit(NULL);
+			}
+			usleep(RUNNER_PERIOD);
+		}
+		assert(false);
+	}
+	printf_verbose("cpu%d has %d and is going to terminate\n",
+		       sched_getcpu(), curr_mm_cid);
+	pthread_exit(NULL);
+}
+
+void test_mm_cid_compaction(void)
+{
+	cpu_set_t affinity;
+	int i, j, ret, num_threads;
+	pthread_t *tinfo;
+	pthread_mutex_t *token;
+	struct thread_args *args;
+
+	sched_getaffinity(0, sizeof(affinity), &affinity);
+	num_threads = CPU_COUNT(&affinity);
+	tinfo = calloc(num_threads, sizeof(*tinfo));
+	if (!tinfo) {
+		fprintf(stderr, "Error: failed to allocate tinfo(%d): %s\n",
+			errno, strerror(errno));
+		assert(ret == 0);
+	}
+	args = calloc(num_threads, sizeof(*args));
+	if (!args) {
+		fprintf(stderr, "Error: failed to allocate args(%d): %s\n",
+			errno, strerror(errno));
+		assert(ret == 0);
+	}
+	token = calloc(num_threads, sizeof(*token));
+	if (!token) {
+		fprintf(stderr, "Error: failed to allocate token(%d): %s\n",
+			errno, strerror(errno));
+		assert(ret == 0);
+	}
+	if (num_threads == 1) {
+		printf_verbose(
+			"Running on a single cpu, cannot test anything\n");
+		return;
+	}
+	pthread_mutex_init(token, NULL);
+	/* The main thread runs on CPU0 */
+	for (i = 0, j = 0; i < CPU_SETSIZE && j < num_threads; i++) {
+		if (CPU_ISSET(i, &affinity)) {
+			args[j].num_cpus = num_threads;
+			args[j].tinfo = tinfo;
+			args[j].token = token;
+			args[j].cpu = i;
+			args[j].args_head = args;
+			if (!j) {
+				/* The first thread is the main one */
+				tinfo[0] = pthread_self();
+				++j;
+				continue;
+			}
+			ret = pthread_create(&tinfo[j], NULL, thread_runner,
+					     &args[j]);
+			if (ret) {
+				fprintf(stderr,
+					"Error: failed to create thread(%d): %s\n",
+					ret, strerror(ret));
+				assert(ret == 0);
+			}
+			++j;
+		}
+	}
+	printf_verbose("Started %d threads\n", num_threads);
+
+	/* Also main thread will terminate if it is not selected as leader */
+	thread_runner(&args[0]);
+}
+
+int main(int argc, char **argv)
+{
+	if (rseq_register_current_thread()) {
+		fprintf(stderr,
+			"Error: rseq_register_current_thread(...) failed(%d): %s\n",
+			errno, strerror(errno));
+		goto error;
+	}
+	if (!rseq_mm_cid_available()) {
+		fprintf(stderr, "Error: rseq_mm_cid unavailable\n");
+		goto error;
+	}
+	test_mm_cid_compaction();
+	if (rseq_unregister_current_thread()) {
+		fprintf(stderr,
+			"Error: rseq_unregister_current_thread(...) failed(%d): %s\n",
+			errno, strerror(errno));
+		goto error;
+	}
+	return 0;
+
+error:
+	return -1;
+}
-- 
2.47.1


