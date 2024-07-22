Return-Path: <linux-kernel+bounces-258841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9218938D4B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 12:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 786821F21B11
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0660B16C6AE;
	Mon, 22 Jul 2024 10:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MEu0+mTY"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B0916C87A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 10:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721643167; cv=none; b=I8+BLqpvXf82AgjP+3v+1P/0F+sSX+z0v+KaYfA35QK7UxOB+KV2HCXbdV6n/fMKugp7jK60u2JGBP0OaGBe7NgbbDTZsfBckvM8Nhg8uEk/ygvWSxS/nUu1WZfeKhGEMnC4RITvj5FEwYAmKuWPWrp8cA7UON9Wt868QYtzofk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721643167; c=relaxed/simple;
	bh=aOrTfh04jzTSySBjyrhgsHcObtErxSadvHnZV7ok1qY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cy1tVegIVt23kel8pgZNtqD5WNiO1yvSxCYyLtXIZXGpRHXBQKwBZsUPcgKqfBxY5Qaiyw3hZLQYQ7H0fLF5ZHlbCKgmbbz9jahX9401lv4ujSXlbPew0bO1Rv5wMlZB9hRG3HQXoTQKSmDMZvskgixw5UF9tKXgMYf4AYwN2W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MEu0+mTY; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ebed33cb65so47178631fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 03:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721643164; x=1722247964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UyTZOlcer76A5XhM3hkLaXI/Rj6pzVBUq9WV2j3LO94=;
        b=MEu0+mTYT7MKXLx6SZR8klqDavqkbxdGx+iu/TGnikGGWebKLh+D1NTAu6Mzyi4bqc
         t5T5KakL7GZsjBom7TEOoqVEBhdm6uM4gCHfds8gAGx++3ZjHu2oWUrIqE0Oj7YCm3vg
         UPx9lMJc/0b7oczAynRtj3p4O9rS8ognKVBDfjrbJ4dUpqeHStSAe9DuqSK6M5HzlcGS
         +VZp6rctFtOVo+xxKA5/Y3lXhOmI5OKvrL0gazx3MuBlC8bE/dIvz6F91usI6fv/70gx
         O3pbEHQaZjsYoKzyegFixccXB6LqjQj8hnPr6kKBj6aibybRcLZ+WSfriCtg2Y8aWQTp
         bthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721643164; x=1722247964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UyTZOlcer76A5XhM3hkLaXI/Rj6pzVBUq9WV2j3LO94=;
        b=FUSVZCG56b7UCBGinBXg/0bZo3Qx+9ysmBp6Fmu91h9k8dx5EEN3JDSQYThELorunS
         tMmmSTx7Ob47uAWb2PXYYWUmB0pl2wZ5DhcjSfJwxT0Tc0kevv65N3tpo+ZHSNX0ZFam
         zLy3NLdytcoyrt/OeoRdR5x//qaABPspVK++vG8TDTE4+ZakA9gcPdV+PXuUgAOGuKEk
         9d2UF7TwY8vHNzUOdJ8p6JPj9eRtjsjvREbZLeoD2i7y+2jQg2tJYGa+Vpbs08EPNoUe
         wxe1pf+aw2d7AVF+xUcSlMODj3gtNSW0OeaDRH3GAw8wp8DA8sp4q4694IZUawGw5TYN
         0a2g==
X-Forwarded-Encrypted: i=1; AJvYcCVjdXX3Sw0vv+tQJ/sFTXHI1ANL11XbjCYkO2quiiaXKmacMiXF6H1OQX0+b6UMIvcM/0PSyTnRvSfoaVn2wcEmuCwGNP8rQCIeqiXv
X-Gm-Message-State: AOJu0YxPB6ThhhD/nKbG4k3BMtqHJHmZompdMuBlmVnPXRColifT9aE+
	+xBCQM3NKG9TpPGfH3R9FSHNEdcC+lJbos6TJDxT5sGp8PoI8iL04MR99rihPHo=
X-Google-Smtp-Source: AGHT+IGyjiAwryu3AnjZbAxpppbaIgxNg73NMwKF89fMqqgChymsS5YVk+KH7/cyTezhX+t3JK+TMQ==
X-Received: by 2002:a2e:b016:0:b0:2ef:22a4:6415 with SMTP id 38308e7fff4ca-2ef22a464f8mr39298431fa.28.1721643163559;
        Mon, 22 Jul 2024 03:12:43 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a8e436sm147993865e9.33.2024.07.22.03.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 03:12:43 -0700 (PDT)
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
Subject: [PATCH v6 03/17] perf: cs-etm: Move traceid_list to each queue
Date: Mon, 22 Jul 2024 11:11:45 +0100
Message-Id: <20240722101202.26915-4-james.clark@linaro.org>
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

The global list won't work for per-sink trace ID allocations, so put a
list in each queue where the IDs will be unique to that queue.

To keep the same behavior as before, for version 0 of the HW_ID packets,
copy all the HW_ID mappings into all queues.

This change doesn't effect the decoders, only trace ID lookups on the
Perf side. The decoders are still created with global mappings which
will be fixed in a later commit.

Signed-off-by: James Clark <james.clark@arm.com>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  28 ++-
 tools/perf/util/cs-etm.c                      | 215 +++++++++++-------
 tools/perf/util/cs-etm.h                      |   2 +-
 3 files changed, 147 insertions(+), 98 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index e917985bbbe6..0c9c48cedbf1 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -388,7 +388,8 @@ cs_etm_decoder__reset_timestamp(struct cs_etm_packet_queue *packet_queue)
 }
 
 static ocsd_datapath_resp_t
-cs_etm_decoder__buffer_packet(struct cs_etm_packet_queue *packet_queue,
+cs_etm_decoder__buffer_packet(struct cs_etm_queue *etmq,
+			      struct cs_etm_packet_queue *packet_queue,
 			      const u8 trace_chan_id,
 			      enum cs_etm_sample_type sample_type)
 {
@@ -398,7 +399,7 @@ cs_etm_decoder__buffer_packet(struct cs_etm_packet_queue *packet_queue,
 	if (packet_queue->packet_count >= CS_ETM_PACKET_MAX_BUFFER - 1)
 		return OCSD_RESP_FATAL_SYS_ERR;
 
-	if (cs_etm__get_cpu(trace_chan_id, &cpu) < 0)
+	if (cs_etm__get_cpu(etmq, trace_chan_id, &cpu) < 0)
 		return OCSD_RESP_FATAL_SYS_ERR;
 
 	et = packet_queue->tail;
@@ -436,7 +437,7 @@ cs_etm_decoder__buffer_range(struct cs_etm_queue *etmq,
 	int ret = 0;
 	struct cs_etm_packet *packet;
 
-	ret = cs_etm_decoder__buffer_packet(packet_queue, trace_chan_id,
+	ret = cs_etm_decoder__buffer_packet(etmq, packet_queue, trace_chan_id,
 					    CS_ETM_RANGE);
 	if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
 		return ret;
@@ -496,7 +497,8 @@ cs_etm_decoder__buffer_range(struct cs_etm_queue *etmq,
 }
 
 static ocsd_datapath_resp_t
-cs_etm_decoder__buffer_discontinuity(struct cs_etm_packet_queue *queue,
+cs_etm_decoder__buffer_discontinuity(struct cs_etm_queue *etmq,
+				     struct cs_etm_packet_queue *queue,
 				     const uint8_t trace_chan_id)
 {
 	/*
@@ -504,18 +506,19 @@ cs_etm_decoder__buffer_discontinuity(struct cs_etm_packet_queue *queue,
 	 * reset time statistics.
 	 */
 	cs_etm_decoder__reset_timestamp(queue);
-	return cs_etm_decoder__buffer_packet(queue, trace_chan_id,
+	return cs_etm_decoder__buffer_packet(etmq, queue, trace_chan_id,
 					     CS_ETM_DISCONTINUITY);
 }
 
 static ocsd_datapath_resp_t
-cs_etm_decoder__buffer_exception(struct cs_etm_packet_queue *queue,
+cs_etm_decoder__buffer_exception(struct cs_etm_queue *etmq,
+				 struct cs_etm_packet_queue *queue,
 				 const ocsd_generic_trace_elem *elem,
 				 const uint8_t trace_chan_id)
 {	int ret = 0;
 	struct cs_etm_packet *packet;
 
-	ret = cs_etm_decoder__buffer_packet(queue, trace_chan_id,
+	ret = cs_etm_decoder__buffer_packet(etmq, queue, trace_chan_id,
 					    CS_ETM_EXCEPTION);
 	if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
 		return ret;
@@ -527,10 +530,11 @@ cs_etm_decoder__buffer_exception(struct cs_etm_packet_queue *queue,
 }
 
 static ocsd_datapath_resp_t
-cs_etm_decoder__buffer_exception_ret(struct cs_etm_packet_queue *queue,
+cs_etm_decoder__buffer_exception_ret(struct cs_etm_queue *etmq,
+				     struct cs_etm_packet_queue *queue,
 				     const uint8_t trace_chan_id)
 {
-	return cs_etm_decoder__buffer_packet(queue, trace_chan_id,
+	return cs_etm_decoder__buffer_packet(etmq, queue, trace_chan_id,
 					     CS_ETM_EXCEPTION_RET);
 }
 
@@ -599,7 +603,7 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 	case OCSD_GEN_TRC_ELEM_EO_TRACE:
 	case OCSD_GEN_TRC_ELEM_NO_SYNC:
 	case OCSD_GEN_TRC_ELEM_TRACE_ON:
-		resp = cs_etm_decoder__buffer_discontinuity(packet_queue,
+		resp = cs_etm_decoder__buffer_discontinuity(etmq, packet_queue,
 							    trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_INSTR_RANGE:
@@ -607,11 +611,11 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 						    trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_EXCEPTION:
-		resp = cs_etm_decoder__buffer_exception(packet_queue, elem,
+		resp = cs_etm_decoder__buffer_exception(etmq, packet_queue, elem,
 							trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_EXCEPTION_RET:
-		resp = cs_etm_decoder__buffer_exception_ret(packet_queue,
+		resp = cs_etm_decoder__buffer_exception_ret(etmq, packet_queue,
 							    trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_TIMESTAMP:
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 0fa7dd328783..582526d9676f 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -116,16 +116,18 @@ struct cs_etm_queue {
 	/* Conversion between traceID and index in traceid_queues array */
 	struct intlist *traceid_queues_list;
 	struct cs_etm_traceid_queue **traceid_queues;
+	/* Conversion between traceID and metadata pointers */
+	struct intlist *traceid_list;
 };
 
-/* RB tree for quick conversion between traceID and metadata pointers */
-static struct intlist *traceid_list;
-
 static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm);
 static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
 					   pid_t tid);
 static int cs_etm__get_data_block(struct cs_etm_queue *etmq);
 static int cs_etm__decode_data_block(struct cs_etm_queue *etmq);
+static int cs_etm__metadata_get_trace_id(u8 *trace_chan_id, u64 *cpu_metadata);
+static u64 *get_cpu_data(struct cs_etm_auxtrace *etm, int cpu);
+static int cs_etm__metadata_set_trace_id(u8 trace_chan_id, u64 *cpu_metadata);
 
 /* PTMs ETMIDR [11:8] set to b0011 */
 #define ETMIDR_PTM_VERSION 0x00000300
@@ -151,12 +153,12 @@ static u32 cs_etm__get_v7_protocol_version(u32 etmidr)
 	return CS_ETM_PROTO_ETMV3;
 }
 
-static int cs_etm__get_magic(u8 trace_chan_id, u64 *magic)
+static int cs_etm__get_magic(struct cs_etm_queue *etmq, u8 trace_chan_id, u64 *magic)
 {
 	struct int_node *inode;
 	u64 *metadata;
 
-	inode = intlist__find(traceid_list, trace_chan_id);
+	inode = intlist__find(etmq->traceid_list, trace_chan_id);
 	if (!inode)
 		return -EINVAL;
 
@@ -165,12 +167,12 @@ static int cs_etm__get_magic(u8 trace_chan_id, u64 *magic)
 	return 0;
 }
 
-int cs_etm__get_cpu(u8 trace_chan_id, int *cpu)
+int cs_etm__get_cpu(struct cs_etm_queue *etmq, u8 trace_chan_id, int *cpu)
 {
 	struct int_node *inode;
 	u64 *metadata;
 
-	inode = intlist__find(traceid_list, trace_chan_id);
+	inode = intlist__find(etmq->traceid_list, trace_chan_id);
 	if (!inode)
 		return -EINVAL;
 
@@ -222,30 +224,108 @@ enum cs_etm_pid_fmt cs_etm__get_pid_fmt(struct cs_etm_queue *etmq)
 	return etmq->etm->pid_fmt;
 }
 
-static int cs_etm__map_trace_id(u8 trace_chan_id, u64 *cpu_metadata)
+static int cs_etm__insert_trace_id_node(struct cs_etm_queue *etmq,
+					u8 trace_chan_id, u64 *cpu_metadata)
 {
-	struct int_node *inode;
-
 	/* Get an RB node for this CPU */
-	inode = intlist__findnew(traceid_list, trace_chan_id);
+	struct int_node *inode = intlist__findnew(etmq->traceid_list, trace_chan_id);
 
 	/* Something went wrong, no need to continue */
 	if (!inode)
 		return -ENOMEM;
 
+	/* Disallow re-mapping a different traceID to metadata pair. */
+	if (inode->priv) {
+		u64 *curr_cpu_data = inode->priv;
+		u8 curr_chan_id;
+		int err;
+
+		if (curr_cpu_data[CS_ETM_CPU] != cpu_metadata[CS_ETM_CPU]) {
+			pr_err("CS_ETM: map mismatch between HW_ID packet CPU and Trace ID\n");
+			return -EINVAL;
+		}
+
+		/* check that the mapped ID matches */
+		err = cs_etm__metadata_get_trace_id(&curr_chan_id, curr_cpu_data);
+		if (err)
+			return err;
+
+		if (curr_chan_id != trace_chan_id) {
+			pr_err("CS_ETM: mismatch between CPU trace ID and HW_ID packet ID\n");
+			return -EINVAL;
+		}
+
+		/* Skip re-adding the same mappings if everything matched */
+		return 0;
+	}
+
+	/* Not one we've seen before, associate the traceID with the metadata pointer */
+	inode->priv = cpu_metadata;
+
+	return 0;
+}
+
+static struct cs_etm_queue *cs_etm__get_queue(struct cs_etm_auxtrace *etm, int cpu)
+{
+	if (etm->per_thread_decoding)
+		return etm->queues.queue_array[0].priv;
+	else
+		return etm->queues.queue_array[cpu].priv;
+}
+
+static int cs_etm__map_trace_id_v0(struct cs_etm_auxtrace *etm, u8 trace_chan_id,
+				   u64 *cpu_metadata)
+{
+	struct cs_etm_queue *etmq;
+
 	/*
-	 * The node for that CPU should not be taken.
-	 * Back out if that's the case.
+	 * If the queue is unformatted then only save one mapping in the
+	 * queue associated with that CPU so only one decoder is made.
 	 */
-	if (inode->priv)
-		return -EINVAL;
+	etmq = cs_etm__get_queue(etm, cpu_metadata[CS_ETM_CPU]);
+	if (etmq->format == UNFORMATTED)
+		return cs_etm__insert_trace_id_node(etmq, trace_chan_id,
+						    cpu_metadata);
 
-	/* All good, associate the traceID with the metadata pointer */
-	inode->priv = cpu_metadata;
+	/*
+	 * Otherwise, version 0 trace IDs are global so save them into every
+	 * queue.
+	 */
+	for (unsigned int i = 0; i < etm->queues.nr_queues; ++i) {
+		int ret;
+
+		etmq = etm->queues.queue_array[i].priv;
+		ret = cs_etm__insert_trace_id_node(etmq, trace_chan_id,
+						   cpu_metadata);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
 
+static int cs_etm__process_trace_id_v0(struct cs_etm_auxtrace *etm, int cpu,
+				       u64 hw_id)
+{
+	int err;
+	u64 *cpu_data;
+	u8 trace_chan_id = FIELD_GET(CS_AUX_HW_ID_TRACE_ID_MASK, hw_id);
+
+	cpu_data = get_cpu_data(etm, cpu);
+	if (cpu_data == NULL)
+		return -EINVAL;
+
+	err = cs_etm__map_trace_id_v0(etm, trace_chan_id, cpu_data);
+	if (err)
+		return err;
+
+	/*
+	 * if we are picking up the association from the packet, need to plug
+	 * the correct trace ID into the metadata for setting up decoders later.
+	 */
+	return cs_etm__metadata_set_trace_id(trace_chan_id, cpu_data);
+}
+
 static int cs_etm__metadata_get_trace_id(u8 *trace_chan_id, u64 *cpu_metadata)
 {
 	u64 cs_etm_magic = cpu_metadata[CS_ETM_MAGIC];
@@ -329,17 +409,13 @@ static int cs_etm__process_aux_output_hw_id(struct perf_session *session,
 {
 	struct cs_etm_auxtrace *etm;
 	struct perf_sample sample;
-	struct int_node *inode;
 	struct evsel *evsel;
-	u64 *cpu_data;
 	u64 hw_id;
 	int cpu, version, err;
-	u8 trace_chan_id, curr_chan_id;
 
 	/* extract and parse the HW ID */
 	hw_id = event->aux_output_hw_id.hw_id;
 	version = FIELD_GET(CS_AUX_HW_ID_VERSION_MASK, hw_id);
-	trace_chan_id = FIELD_GET(CS_AUX_HW_ID_TRACE_ID_MASK, hw_id);
 
 	/* check that we can handle this version */
 	if (version > CS_AUX_HW_ID_CURR_VERSION) {
@@ -367,43 +443,7 @@ static int cs_etm__process_aux_output_hw_id(struct perf_session *session,
 		return -EINVAL;
 	}
 
-	/* See if the ID is mapped to a CPU, and it matches the current CPU */
-	inode = intlist__find(traceid_list, trace_chan_id);
-	if (inode) {
-		cpu_data = inode->priv;
-		if ((int)cpu_data[CS_ETM_CPU] != cpu) {
-			pr_err("CS_ETM: map mismatch between HW_ID packet CPU and Trace ID\n");
-			return -EINVAL;
-		}
-
-		/* check that the mapped ID matches */
-		err = cs_etm__metadata_get_trace_id(&curr_chan_id, cpu_data);
-		if (err)
-			return err;
-		if (curr_chan_id != trace_chan_id) {
-			pr_err("CS_ETM: mismatch between CPU trace ID and HW_ID packet ID\n");
-			return -EINVAL;
-		}
-
-		/* mapped and matched - return OK */
-		return 0;
-	}
-
-	cpu_data = get_cpu_data(etm, cpu);
-	if (cpu_data == NULL)
-		return err;
-
-	/* not one we've seen before - lets map it */
-	err = cs_etm__map_trace_id(trace_chan_id, cpu_data);
-	if (err)
-		return err;
-
-	/*
-	 * if we are picking up the association from the packet, need to plug
-	 * the correct trace ID into the metadata for setting up decoders later.
-	 */
-	err = cs_etm__metadata_set_trace_id(trace_chan_id, cpu_data);
-	return err;
+	return cs_etm__process_trace_id_v0(etm, cpu, hw_id);
 }
 
 void cs_etm__etmq_set_traceid_queue_timestamp(struct cs_etm_queue *etmq,
@@ -856,6 +896,7 @@ static void cs_etm__free_traceid_queues(struct cs_etm_queue *etmq)
 
 static void cs_etm__free_queue(void *priv)
 {
+	struct int_node *inode, *tmp;
 	struct cs_etm_queue *etmq = priv;
 
 	if (!etmq)
@@ -863,6 +904,14 @@ static void cs_etm__free_queue(void *priv)
 
 	cs_etm_decoder__free(etmq->decoder);
 	cs_etm__free_traceid_queues(etmq);
+
+	/* First remove all traceID/metadata nodes for the RB tree */
+	intlist__for_each_entry_safe(inode, tmp, etmq->traceid_list)
+		intlist__remove(etmq->traceid_list, inode);
+
+	/* Then the RB tree itself */
+	intlist__delete(etmq->traceid_list);
+
 	free(etmq);
 }
 
@@ -885,19 +934,12 @@ static void cs_etm__free_events(struct perf_session *session)
 static void cs_etm__free(struct perf_session *session)
 {
 	int i;
-	struct int_node *inode, *tmp;
 	struct cs_etm_auxtrace *aux = container_of(session->auxtrace,
 						   struct cs_etm_auxtrace,
 						   auxtrace);
 	cs_etm__free_events(session);
 	session->auxtrace = NULL;
 
-	/* First remove all traceID/metadata nodes for the RB tree */
-	intlist__for_each_entry_safe(inode, tmp, traceid_list)
-		intlist__remove(traceid_list, inode);
-	/* Then the RB tree itself */
-	intlist__delete(traceid_list);
-
 	for (i = 0; i < aux->num_cpu; i++)
 		zfree(&aux->metadata[i]);
 
@@ -1055,9 +1097,24 @@ static struct cs_etm_queue *cs_etm__alloc_queue(void)
 
 	etmq->traceid_queues_list = intlist__new(NULL);
 	if (!etmq->traceid_queues_list)
-		free(etmq);
+		goto out_free;
+
+	/*
+	 * Create an RB tree for traceID-metadata tuple.  Since the conversion
+	 * has to be made for each packet that gets decoded, optimizing access
+	 * in anything other than a sequential array is worth doing.
+	 */
+	etmq->traceid_list = intlist__new(NULL);
+	if (!etmq->traceid_list)
+		goto out_free;
 
 	return etmq;
+
+out_free:
+	intlist__delete(etmq->traceid_queues_list);
+	free(etmq);
+
+	return NULL;
 }
 
 static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
@@ -2207,7 +2264,7 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq,
 					      PERF_IP_FLAG_TRACE_END;
 		break;
 	case CS_ETM_EXCEPTION:
-		ret = cs_etm__get_magic(packet->trace_chan_id, &magic);
+		ret = cs_etm__get_magic(etmq, packet->trace_chan_id, &magic);
 		if (ret)
 			return ret;
 
@@ -3124,7 +3181,8 @@ static bool cs_etm__has_virtual_ts(u64 **metadata, int num_cpu)
 }
 
 /* map trace ids to correct metadata block, from information in metadata */
-static int cs_etm__map_trace_ids_metadata(int num_cpu, u64 **metadata)
+static int cs_etm__map_trace_ids_metadata(struct cs_etm_auxtrace *etm, int num_cpu,
+					  u64 **metadata)
 {
 	u64 cs_etm_magic;
 	u8 trace_chan_id;
@@ -3146,7 +3204,7 @@ static int cs_etm__map_trace_ids_metadata(int num_cpu, u64 **metadata)
 			/* unknown magic number */
 			return -EINVAL;
 		}
-		err = cs_etm__map_trace_id(trace_chan_id, metadata[i]);
+		err = cs_etm__map_trace_id_v0(etm, trace_chan_id, metadata[i]);
 		if (err)
 			return err;
 	}
@@ -3277,23 +3335,12 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	u64 *ptr = NULL;
 	u64 **metadata = NULL;
 
-	/*
-	 * Create an RB tree for traceID-metadata tuple.  Since the conversion
-	 * has to be made for each packet that gets decoded, optimizing access
-	 * in anything other than a sequential array is worth doing.
-	 */
-	traceid_list = intlist__new(NULL);
-	if (!traceid_list)
-		return -ENOMEM;
-
 	/* First the global part */
 	ptr = (u64 *) auxtrace_info->priv;
 	num_cpu = ptr[CS_PMU_TYPE_CPUS] & 0xffffffff;
 	metadata = zalloc(sizeof(*metadata) * num_cpu);
-	if (!metadata) {
-		err = -ENOMEM;
-		goto err_free_traceid_list;
-	}
+	if (!metadata)
+		return -ENOMEM;
 
 	/* Start parsing after the common part of the header */
 	i = CS_HEADER_VERSION_MAX;
@@ -3472,7 +3519,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 		err = cs_etm__clear_unused_trace_ids_metadata(num_cpu, metadata);
 	/* otherwise, this is a file with metadata values only, map from metadata */
 	else
-		err = cs_etm__map_trace_ids_metadata(num_cpu, metadata);
+		err = cs_etm__map_trace_ids_metadata(etm, num_cpu, metadata);
 
 	if (err)
 		goto err_free_queues;
@@ -3494,7 +3541,5 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	for (int j = 0; j < num_cpu; j++)
 		zfree(&metadata[j]);
 	zfree(&metadata);
-err_free_traceid_list:
-	intlist__delete(traceid_list);
 	return err;
 }
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index 4696267a32f0..f4f69f7cc0f3 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -252,7 +252,7 @@ enum cs_etm_pid_fmt {
 
 #ifdef HAVE_CSTRACE_SUPPORT
 #include <opencsd/ocsd_if_types.h>
-int cs_etm__get_cpu(u8 trace_chan_id, int *cpu);
+int cs_etm__get_cpu(struct cs_etm_queue *etmq, u8 trace_chan_id, int *cpu);
 enum cs_etm_pid_fmt cs_etm__get_pid_fmt(struct cs_etm_queue *etmq);
 int cs_etm__etmq_set_tid_el(struct cs_etm_queue *etmq, pid_t tid,
 			    u8 trace_chan_id, ocsd_ex_level el);
-- 
2.34.1


