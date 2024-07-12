Return-Path: <linux-kernel+bounces-250538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0A592F8E2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 12:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E3921C22F82
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 10:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE7715AADE;
	Fri, 12 Jul 2024 10:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nFe1qbbE"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE18D16E899
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 10:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720779761; cv=none; b=RCMSGJkjz/N2Puyd95QpUOrtL37BT3RZQXJog2jCQnGle4y2XC/8q0oe9K2Kn17c6MgxUZY7Us5jEbpoGXm5aVqoiHKh9poRnol00tPLsz6INTLyLJIQBwJtvOIzPUeuvC7pNaYRZvI9ALgf3A0pPBVgNmKbR5gUME3MpUa2+fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720779761; c=relaxed/simple;
	bh=n1V4Mkku0PXIyMtnBnYi1DY09b7H/0UV0oib0b5cUZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H+UKK6ewcXbLLRChcWo2KDzkyTl7K2lGlULbWfiaat8B5Q5CmgX351Obq68th9d+9FmRvpT/D39JCKKm4jrvXblpq0cfUg5ON9S5hu9Vpbmji0xow6AazwC0JPfd8Ububu483+Vb22Atyja7VQoAMw+DxGGlwidMtiyjBJQpslk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nFe1qbbE; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-36798779d75so1627331f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 03:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720779757; x=1721384557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ah9k75BJOaZTXMfLc9XJp4ghTXY2y5r0z+Y/ysHuLQg=;
        b=nFe1qbbETeMHFU+uVv7i9DMOHW7+YCnco88Ds5WoaG8GkCmZvtPAVIxZaWaiu7CKNt
         7Y8huEzfrhi6rX1IWLkcPt8gzR5/4zYLt//uHMJH8PPCogbIWQjnN7hUja/ilVC4LCJ6
         LFMQeYB2IkCSjgfRyZjEEDn0qEP76LkXzAtrVMKPTMnkkgaRqpzZo8EDWEP/0cA3ZuHm
         SlPar8s5PR0/Gh6mfWUPGHIWti+aLRrmOiHEw06+p9Cz4QGaDcTG9tVRZvQYGEBjmAst
         xt4MdsWeM0SlJEX8t1eOEmAC6BSJwXjmzGs50zlnxlzkrSY8MtvV2mmjT6eNpsNb3gs3
         y1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720779757; x=1721384557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ah9k75BJOaZTXMfLc9XJp4ghTXY2y5r0z+Y/ysHuLQg=;
        b=a+Rt/57uoA0HlMUPZK8DMFfUoZncjEryus00s4PT7yDFdtT3HloDZg96lwnwWEq3/U
         HyMdYKu9YpWK9W+b0yinkv0neLj2GXmJMuBeP4jLWi3l9nD8MJnxy+i5959/MAfK2iPC
         5q6KcsO+fL0jQSddyZ7YrfvwwbEpnIyNoQKqw/hcvSjuirlMUkaVgAKLere7/J+rjGjL
         Q7QIpijUYJ8rXlASaH+/cojc3RipC/c3rJ9AAU3GK9v99YAUhsh2+W6ls9v3rFY2r2oW
         XN0Bo15chKdxAhXGWwxaWpX3hIFfhm+IpA7fV/K4OCbtG+VXJh/8klTzUu2PJZlhkcIH
         CD3A==
X-Forwarded-Encrypted: i=1; AJvYcCWQ0qHpQ3MKFw6WS9yhaVpuabi2n+h0gQgLzrjxHeyIRWKcncoYHWLYGw7hV7no1fcYl0k7Saf0Aw+9vCZ79nLFvvPmB2SIjqFGrquj
X-Gm-Message-State: AOJu0Yy1fnx3WtyD2QVSx3r17/EibPYifx36JZ2qBoPbwI4cFvXB8QII
	bmCQ8SQt+SdoBQNGHIYR+iVVss9oyxZonsvcvNmh+pdYKhtdmyF4eSxk5zyjZGc=
X-Google-Smtp-Source: AGHT+IGPEcqwdD8/75nBwHmz7V9EEZVfCM0YjiLJhzeXNzNdPm7q7nELUcwtmZAqeXOP8tC5MYlBkg==
X-Received: by 2002:adf:ae52:0:b0:35f:3189:ddd2 with SMTP id ffacd0b85a97d-367cea961bbmr8483699f8f.35.1720779757207;
        Fri, 12 Jul 2024 03:22:37 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde89164sm9911058f8f.63.2024.07.12.03.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 03:22:36 -0700 (PDT)
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
Subject: [PATCH v5 06/17] perf: cs-etm: Support version 0.1 of HW_ID packets
Date: Fri, 12 Jul 2024 11:20:15 +0100
Message-Id: <20240712102029.3697965-7-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240712102029.3697965-1-james.clark@linaro.org>
References: <20240712102029.3697965-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Clark <james.clark@arm.com>

v0.1 HW_ID packets have a new field that describes which sink each CPU
writes to. Use the sink ID to link trace ID maps to each other so that
mappings are shared wherever the sink is shared.

Also update the error message to show that overlapping IDs aren't an
error in per-thread mode, just not supported. In the future we can
use the CPU ID from the AUX records, or watch for changing sink IDs on
HW_ID packets to use the correct decoders.

Signed-off-by: James Clark <james.clark@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/include/linux/coresight-pmu.h |  17 +++--
 tools/perf/util/cs-etm.c            | 100 +++++++++++++++++++++++++---
 2 files changed, 103 insertions(+), 14 deletions(-)

diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linux/coresight-pmu.h
index 51ac441a37c3..89b0ac0014b0 100644
--- a/tools/include/linux/coresight-pmu.h
+++ b/tools/include/linux/coresight-pmu.h
@@ -49,12 +49,21 @@
  * Interpretation of the PERF_RECORD_AUX_OUTPUT_HW_ID payload.
  * Used to associate a CPU with the CoreSight Trace ID.
  * [07:00] - Trace ID - uses 8 bits to make value easy to read in file.
- * [59:08] - Unused (SBZ)
- * [63:60] - Version
+ * [39:08] - Sink ID - as reported in /sys/bus/event_source/devices/cs_etm/sinks/
+ *	      Added in minor version 1.
+ * [55:40] - Unused (SBZ)
+ * [59:56] - Minor Version - previously existing fields are compatible with
+ *	      all minor versions.
+ * [63:60] - Major Version - previously existing fields mean different things
+ *	      in new major versions.
  */
 #define CS_AUX_HW_ID_TRACE_ID_MASK	GENMASK_ULL(7, 0)
-#define CS_AUX_HW_ID_VERSION_MASK	GENMASK_ULL(63, 60)
+#define CS_AUX_HW_ID_SINK_ID_MASK	GENMASK_ULL(39, 8)
 
-#define CS_AUX_HW_ID_CURR_VERSION 0
+#define CS_AUX_HW_ID_MINOR_VERSION_MASK	GENMASK_ULL(59, 56)
+#define CS_AUX_HW_ID_MAJOR_VERSION_MASK	GENMASK_ULL(63, 60)
+
+#define CS_AUX_HW_ID_MAJOR_VERSION 0
+#define CS_AUX_HW_ID_MINOR_VERSION 1
 
 #endif
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 954a6f7bedf3..87e983da19be 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -118,6 +118,12 @@ struct cs_etm_queue {
 	struct cs_etm_traceid_queue **traceid_queues;
 	/* Conversion between traceID and metadata pointers */
 	struct intlist *traceid_list;
+	/*
+	 * Same as traceid_list, but traceid_list may be a reference to another
+	 * queue's which has a matching sink ID.
+	 */
+	struct intlist *own_traceid_list;
+	u32 sink_id;
 };
 
 static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm);
@@ -142,6 +148,7 @@ static int cs_etm__metadata_set_trace_id(u8 trace_chan_id, u64 *cpu_metadata);
 		      (queue_nr << 16 | trace_chan_id)
 #define TO_QUEUE_NR(cs_queue_nr) (cs_queue_nr >> 16)
 #define TO_TRACE_CHAN_ID(cs_queue_nr) (cs_queue_nr & 0x0000ffff)
+#define SINK_UNSET ((u32) -1)
 
 static u32 cs_etm__get_v7_protocol_version(u32 etmidr)
 {
@@ -241,7 +248,16 @@ static int cs_etm__insert_trace_id_node(struct cs_etm_queue *etmq,
 		int err;
 
 		if (curr_cpu_data[CS_ETM_CPU] != cpu_metadata[CS_ETM_CPU]) {
-			pr_err("CS_ETM: map mismatch between HW_ID packet CPU and Trace ID\n");
+			/*
+			 * With > CORESIGHT_TRACE_IDS_MAX ETMs, overlapping IDs
+			 * are expected (but not supported) in per-thread mode,
+			 * rather than signifying an error.
+			 */
+			if (etmq->etm->per_thread_decoding)
+				pr_err("CS_ETM: overlapping Trace IDs aren't currently supported in per-thread mode\n");
+			else
+				pr_err("CS_ETM: map mismatch between HW_ID packet CPU and Trace ID\n");
+
 			return -EINVAL;
 		}
 
@@ -326,6 +342,64 @@ static int cs_etm__process_trace_id_v0(struct cs_etm_auxtrace *etm, int cpu,
 	return cs_etm__metadata_set_trace_id(trace_chan_id, cpu_data);
 }
 
+static int cs_etm__process_trace_id_v0_1(struct cs_etm_auxtrace *etm, int cpu,
+					 u64 hw_id)
+{
+	struct cs_etm_queue *etmq = cs_etm__get_queue(etm, cpu);
+	int ret;
+	u64 *cpu_data;
+	u32 sink_id = FIELD_GET(CS_AUX_HW_ID_SINK_ID_MASK, hw_id);
+	u8 trace_id = FIELD_GET(CS_AUX_HW_ID_TRACE_ID_MASK, hw_id);
+
+	/*
+	 * Check sink id hasn't changed in per-cpu mode. In per-thread mode,
+	 * let it pass for now until an actual overlapping trace ID is hit. In
+	 * most cases IDs won't overlap even if the sink changes.
+	 */
+	if (!etmq->etm->per_thread_decoding && etmq->sink_id != SINK_UNSET &&
+	    etmq->sink_id != sink_id) {
+		pr_err("CS_ETM: mismatch between sink IDs\n");
+		return -EINVAL;
+	}
+
+	etmq->sink_id = sink_id;
+
+	/* Find which other queues use this sink and link their ID maps */
+	for (unsigned int i = 0; i < etm->queues.nr_queues; ++i) {
+		struct cs_etm_queue *other_etmq = etm->queues.queue_array[i].priv;
+
+		/* Different sinks, skip */
+		if (other_etmq->sink_id != etmq->sink_id)
+			continue;
+
+		/* Already linked, skip */
+		if (other_etmq->traceid_list == etmq->traceid_list)
+			continue;
+
+		/* At the point of first linking, this one should be empty */
+		if (!intlist__empty(etmq->traceid_list)) {
+			pr_err("CS_ETM: Can't link populated trace ID lists\n");
+			return -EINVAL;
+		}
+
+		etmq->own_traceid_list = NULL;
+		intlist__delete(etmq->traceid_list);
+		etmq->traceid_list = other_etmq->traceid_list;
+		break;
+	}
+
+	cpu_data = get_cpu_data(etm, cpu);
+	ret = cs_etm__insert_trace_id_node(etmq, trace_id, cpu_data);
+	if (ret)
+		return ret;
+
+	ret = cs_etm__metadata_set_trace_id(trace_id, cpu_data);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int cs_etm__metadata_get_trace_id(u8 *trace_chan_id, u64 *cpu_metadata)
 {
 	u64 cs_etm_magic = cpu_metadata[CS_ETM_MAGIC];
@@ -414,10 +488,10 @@ static int cs_etm__process_aux_output_hw_id(struct perf_session *session,
 
 	/* extract and parse the HW ID */
 	hw_id = event->aux_output_hw_id.hw_id;
-	version = FIELD_GET(CS_AUX_HW_ID_VERSION_MASK, hw_id);
+	version = FIELD_GET(CS_AUX_HW_ID_MAJOR_VERSION_MASK, hw_id);
 
 	/* check that we can handle this version */
-	if (version > CS_AUX_HW_ID_CURR_VERSION) {
+	if (version > CS_AUX_HW_ID_MAJOR_VERSION) {
 		pr_err("CS ETM Trace: PERF_RECORD_AUX_OUTPUT_HW_ID version %d not supported. Please update Perf.\n",
 		       version);
 		return -EINVAL;
@@ -442,7 +516,10 @@ static int cs_etm__process_aux_output_hw_id(struct perf_session *session,
 		return -EINVAL;
 	}
 
-	return cs_etm__process_trace_id_v0(etm, cpu, hw_id);
+	if (FIELD_GET(CS_AUX_HW_ID_MINOR_VERSION_MASK, hw_id) == 0)
+		return cs_etm__process_trace_id_v0(etm, cpu, hw_id);
+	else
+		return cs_etm__process_trace_id_v0_1(etm, cpu, hw_id);
 }
 
 void cs_etm__etmq_set_traceid_queue_timestamp(struct cs_etm_queue *etmq,
@@ -882,12 +959,14 @@ static void cs_etm__free_queue(void *priv)
 	cs_etm_decoder__free(etmq->decoder);
 	cs_etm__free_traceid_queues(etmq);
 
-	/* First remove all traceID/metadata nodes for the RB tree */
-	intlist__for_each_entry_safe(inode, tmp, etmq->traceid_list)
-		intlist__remove(etmq->traceid_list, inode);
+	if (etmq->own_traceid_list) {
+		/* First remove all traceID/metadata nodes for the RB tree */
+		intlist__for_each_entry_safe(inode, tmp, etmq->own_traceid_list)
+			intlist__remove(etmq->own_traceid_list, inode);
 
-	/* Then the RB tree itself */
-	intlist__delete(etmq->traceid_list);
+		/* Then the RB tree itself */
+		intlist__delete(etmq->own_traceid_list);
+	}
 
 	free(etmq);
 }
@@ -1081,7 +1160,7 @@ static struct cs_etm_queue *cs_etm__alloc_queue(void)
 	 * has to be made for each packet that gets decoded, optimizing access
 	 * in anything other than a sequential array is worth doing.
 	 */
-	etmq->traceid_list = intlist__new(NULL);
+	etmq->traceid_list = etmq->own_traceid_list = intlist__new(NULL);
 	if (!etmq->traceid_list)
 		goto out_free;
 
@@ -1113,6 +1192,7 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
 	etmq->queue_nr = queue_nr;
 	queue->cpu = queue_nr; /* Placeholder, may be reset to -1 in per-thread mode */
 	etmq->offset = 0;
+	etmq->sink_id = SINK_UNSET;
 
 	return 0;
 }
-- 
2.34.1


