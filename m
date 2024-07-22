Return-Path: <linux-kernel+bounces-258840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE10E938D4A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 12:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2F6A2851DC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3053016C873;
	Mon, 22 Jul 2024 10:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YRH/OQvq"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7356416C862
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 10:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721643163; cv=none; b=FjQXIac/zHFDok+NmCTPoFOcmVgJqn6xNZh6PjA2XCX6SzYePEzdJ8zqeY37SUkZ6ZcsA8aEmFOACfDhpbxlSt4uwpjeFw0BLTqVWmoM/1oNVqV88ayFSe4dn5RBc6XRRSn89S1lDhdXWu/6qqBsNzC0CWAe4jYbr5OQXTLDz6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721643163; c=relaxed/simple;
	bh=eRIR9xQeEVs7k6Eqc3JsCa1Z9aGiRv7GF7Hc8wdGC+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EGjmZR0iXYXc/BC4ev5IP7oe5vchbMMkI0xTtlwUKHlRfCZewXw/SeiEH5/IfKtXr9eCVnjCnoD1cGce1CC5IsJ+kPsm8vHc6rJ4glwwYrnR6X8f45bbCSjQiJYagka5h72YbcXYv5b0AA6deItANfqWEvn4hLy7baw5/jbA5fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YRH/OQvq; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42660b8dd27so28647975e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 03:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721643159; x=1722247959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9iPuIpPcZYNo1rwaMPAEpkXxIdxba4+Bjx0lIMzmeIc=;
        b=YRH/OQvqzRrg0IzLbsmrg5a4BOzyfe1N8Ed+f2Jj0eNxp0ZtMSvzgb6fIkOYIrugNq
         UhYJH3+jJj5zg1LcDBSSgUEV6y4TnGGcPVzyAng7F+Yb4h6xEGBYFuL8ipGoaEY+zMQ5
         L9Nxno4Tdn5qwB1m4+dpgTyd1ZOgR/Hg9/yR0+YUkDFUw+7Gk4+rCR+kg6oOYqk/DbgO
         4V5pdNndzjfx7KZf7LAkUDLIHEhpuTeYQP1k81Z93SaOJYd5bUkw/lVqfcL8hXuDqKrF
         0vxx2/7NY6E3w9WFESAG/eDPz6btG66TsRx3X8evgfFmYbwo82r+RMFYUNjrtb7ByvRc
         Z/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721643159; x=1722247959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9iPuIpPcZYNo1rwaMPAEpkXxIdxba4+Bjx0lIMzmeIc=;
        b=X8jT0jw1cnqLyn0EPwB3V0cx4r03R3C5rtxpYdUkpjF5IBbcN6xPem0pVjML0bcLUz
         PK2duz08WFjjpSFEBSS+rSp0CxQyKIG/Mbd1S6JFMdX1Uq/UhFNJi/WH/ObtKRs7OpVU
         CfBZ28jMYVFs+q4fwSfQ6BSkF4M2Evkh0HfjVq9bjMlipFGgRPFXUVSVO4vw86Noqd3R
         uvI4XbYXsH2WBO7Wi2JBYcY8+5ZAh6njT4HbA8nVd49pnMrqZWG6Z3A8JPal+APPa3Hk
         LfbxJ5IFg8bf0U/U0I0ORoERNKs/4Z2k/Hh7mgv1nGvef6uURt5MQNfS+bJKYNicwbbv
         VStg==
X-Forwarded-Encrypted: i=1; AJvYcCV9/GFqYh6uW74unuVWPELZu8AvLnf8khyrGibgtgz95IR7M/0jhNhXCGwXESWe5Pv6Nrq1sbZKq9msUzQLRi/hGNnQAzZq8tUm68/N
X-Gm-Message-State: AOJu0YwJUsGQk0t5a0dP9TXu0MlYu5TkMhH0aQCdPZvNQ+cN0I7HKbct
	q9k1RhiMllbHoIkEvu/5g3qXojLzJc7LShHGg/U+ywC3W50aqKEul9SsPeq9ZXo=
X-Google-Smtp-Source: AGHT+IGw+Bsobx4Q6K3W0hODu0TR/LMn3n+Zqc9bqXkYfhbaSKdbCE9B0lHsuQkqXoS1KOQLpUhcbQ==
X-Received: by 2002:a05:600c:3b03:b0:425:7bbf:fd07 with SMTP id 5b1f17b1804b1-427dc515239mr42580625e9.5.1721643158547;
        Mon, 22 Jul 2024 03:12:38 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a8e436sm147993865e9.33.2024.07.22.03.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 03:12:38 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: coresight@lists.linaro.org,
	suzuki.poulose@arm.com,
	gankulkarni@os.amperecomputing.com,
	mike.leach@linaro.org,
	leo.yan@linux.dev,
	anshuman.khandual@arm.com
Cc: James Clark <james.clark@arm.com>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v6 02/17] perf: cs-etm: Allocate queues for all CPUs
Date: Mon, 22 Jul 2024 11:11:44 +0100
Message-Id: <20240722101202.26915-3-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240722101202.26915-1-james.clark@linaro.org>
References: <20240722101202.26915-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Clark <james.clark@arm.com>

Make cs_etm__setup_queue() setup a queue even if it's empty, and
pre-allocate queues based on the max CPU that was recorded. In per-CPU
mode aux queues are indexed based on CPU ID even if all CPUs aren't
recorded, sparse queue arrays aren't used.

This will allow HW_IDs to be saved even if no aux data was received in
that queue without having to call cs_etm__setup_queue() from two
different places.

Signed-off-by: James Clark <james.clark@arm.com>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/cs-etm.c | 53 +++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 28 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index f4a378cb66f6..0fa7dd328783 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1062,16 +1062,11 @@ static struct cs_etm_queue *cs_etm__alloc_queue(void)
 
 static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
 			       struct auxtrace_queue *queue,
-			       unsigned int queue_nr, enum cs_etm_format format)
+			       unsigned int queue_nr)
 {
 	struct cs_etm_queue *etmq = queue->priv;
 
-	if (etmq && format != etmq->format) {
-		pr_err("CS_ETM: mixed formatted and unformatted trace not supported\n");
-		return -EINVAL;
-	}
-
-	if (list_empty(&queue->head) || etmq)
+	if (etmq)
 		return 0;
 
 	etmq = cs_etm__alloc_queue();
@@ -1084,7 +1079,6 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
 	etmq->queue_nr = queue_nr;
 	queue->cpu = queue_nr; /* Placeholder, may be reset to -1 in per-thread mode */
 	etmq->offset = 0;
-	etmq->format = format;
 
 	return 0;
 }
@@ -2797,17 +2791,6 @@ static int cs_etm__process_auxtrace_event(struct perf_session *session,
 		if (err)
 			return err;
 
-		/*
-		 * Knowing if the trace is formatted or not requires a lookup of
-		 * the aux record so only works in non-piped mode where data is
-		 * queued in cs_etm__queue_aux_records(). Always assume
-		 * formatted in piped mode (true).
-		 */
-		err = cs_etm__setup_queue(etm, &etm->queues.queue_array[idx],
-					  idx, FORMATTED);
-		if (err)
-			return err;
-
 		if (dump_trace)
 			if (auxtrace_buffer__get_data(buffer, fd)) {
 				cs_etm__dump_event(etm->queues.queue_array[idx].priv, buffer);
@@ -2924,7 +2907,6 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
 	struct perf_record_auxtrace *auxtrace_event;
 	union perf_event auxtrace_fragment;
 	__u64 aux_offset, aux_size;
-	__u32 idx;
 	enum cs_etm_format format;
 
 	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
@@ -2991,6 +2973,8 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
 
 	if (aux_offset >= auxtrace_event->offset &&
 	    aux_offset + aux_size <= auxtrace_event->offset + auxtrace_event->size) {
+		struct cs_etm_queue *etmq = etm->queues.queue_array[auxtrace_event->idx].priv;
+
 		/*
 		 * If this AUX event was inside this buffer somewhere, create a new auxtrace event
 		 * based on the sizes of the aux event, and queue that fragment.
@@ -3007,11 +2991,14 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
 		if (err)
 			return err;
 
-		idx = auxtrace_event->idx;
 		format = (aux_event->flags & PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW) ?
 				UNFORMATTED : FORMATTED;
-
-		return cs_etm__setup_queue(etm, &etm->queues.queue_array[idx], idx, format);
+		if (etmq->format != UNSET && format != etmq->format) {
+			pr_err("CS_ETM: mixed formatted and unformatted trace not supported\n");
+			return -EINVAL;
+		}
+		etmq->format = format;
+		return 0;
 	}
 
 	/* Wasn't inside this buffer, but there were no parse errors. 1 == 'not found' */
@@ -3263,6 +3250,7 @@ static int cs_etm__create_decoders(struct cs_etm_auxtrace *etm)
 		 * Don't create decoders for empty queues, mainly because
 		 * etmq->format is unknown for empty queues.
 		 */
+		assert(empty == (etmq->format == UNSET));
 		if (empty)
 			continue;
 
@@ -3282,10 +3270,10 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	int event_header_size = sizeof(struct perf_event_header);
 	int total_size = auxtrace_info->header.size;
 	int priv_size = 0;
-	int num_cpu;
+	int num_cpu, max_cpu = 0;
 	int err = 0;
 	int aux_hw_id_found;
-	int i, j;
+	int i;
 	u64 *ptr = NULL;
 	u64 **metadata = NULL;
 
@@ -3316,7 +3304,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	 * required by the trace decoder to properly decode the trace due
 	 * to its highly compressed nature.
 	 */
-	for (j = 0; j < num_cpu; j++) {
+	for (int j = 0; j < num_cpu; j++) {
 		if (ptr[i] == __perf_cs_etmv3_magic) {
 			metadata[j] =
 				cs_etm__create_meta_blk(ptr, &i,
@@ -3340,6 +3328,9 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 			err = -ENOMEM;
 			goto err_free_metadata;
 		}
+
+		if ((int) metadata[j][CS_ETM_CPU] > max_cpu)
+			max_cpu = metadata[j][CS_ETM_CPU];
 	}
 
 	/*
@@ -3369,10 +3360,16 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	 */
 	etm->pid_fmt = cs_etm__init_pid_fmt(metadata[0]);
 
-	err = auxtrace_queues__init(&etm->queues);
+	err = auxtrace_queues__init_nr(&etm->queues, max_cpu + 1);
 	if (err)
 		goto err_free_etm;
 
+	for (unsigned int j = 0; j < etm->queues.nr_queues; ++j) {
+		err = cs_etm__setup_queue(etm, &etm->queues.queue_array[j], j);
+		if (err)
+			goto err_free_queues;
+	}
+
 	if (session->itrace_synth_opts->set) {
 		etm->synth_opts = *session->itrace_synth_opts;
 	} else {
@@ -3494,7 +3491,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	zfree(&etm);
 err_free_metadata:
 	/* No need to check @metadata[j], free(NULL) is supported */
-	for (j = 0; j < num_cpu; j++)
+	for (int j = 0; j < num_cpu; j++)
 		zfree(&metadata[j]);
 	zfree(&metadata);
 err_free_traceid_list:
-- 
2.34.1


