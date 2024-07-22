Return-Path: <linux-kernel+bounces-258842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A041938D4C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 12:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D5A51C2165A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E28E16CD3E;
	Mon, 22 Jul 2024 10:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HELdd4Bf"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7FA16C6B8
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 10:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721643173; cv=none; b=fxTVKoxCQaQZCzAIRzIpRbdVryNVzo3188YiWiWQ4agNK+uTsij36fu5lja3MxkLZFvY9hcyISqYICnaXrQSdHgZHiNdKI1vDvKxpCGGc88l15I2RPa2fKYFhzUozoXuvCo3yJRnWylw79TN2abmVYPO2V3uqYzBRKDcwsizfY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721643173; c=relaxed/simple;
	bh=hZm5v4lUy7L9nPRGtRckJOpExDj6bJxmcmYJyyQH1qw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZTd38TRf19dP1+4pyjhVfUE6EJXJM4Jy4fWikYkxZaA2IEg7EJI0yAmQsyomufFF1w+ujUP6DZejYTQZK0Ab9w8mGVH4BievzP1yz+VfvJBl4FMAN1TlB4oeZouq3cTn4h0zPADDV4xBHY3txX9FkbiqH6T8kMgKMEBOXmJlyZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HELdd4Bf; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4257d5fc9b7so34618765e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 03:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721643169; x=1722247969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9JfofHwzEwCTe8hXQsxnVoSXqGVi/oRZgdmMy1CG2M=;
        b=HELdd4Bf5UcPlxANKWMlqtPyM1CO7f1OQ+Pd2OxeKPUf3Hclh1r3F8vIpptvebw6HO
         Qwj7H5WYj/9pRcfXqs0FztPlP4tZ+GzVzCbk9rv5ScTjUQ/xHMG2J0jkMuxE17jJL6Zf
         lgcbTYILyz2X8GpcXSa0GYhSTRWTOlCicLQ60SSMibDsMo9cjB4GGV5IMhA7yGvXwI8q
         2Jc+H/jk93O8hVXnKQtAqV2/ym28cejP5l/4IzzmuhZn/zucBnoGfI1umWl3GvbZ1bIr
         51YXdMpqmny5ZY8WiVx58Z+OUtFbkwZvvvfqrB3hxddUw6RMdHOONRM1Sj2/fmZmefYA
         7Srg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721643169; x=1722247969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n9JfofHwzEwCTe8hXQsxnVoSXqGVi/oRZgdmMy1CG2M=;
        b=bRAl1lRO2fBb1V31H5G0scHRAj7f5s9DKDTqxDhtlLygFWd9l0Nl+U3Y4H9OYMW8Ut
         uwjQIOWAT7dUvAZoR+QhmDifksh+ANQKKt5B0yl0NHDKUKBTz1JglwKJVqLcxrkae/O2
         nJM53m3zYiAVIX16qFMqJP8bPsT1cN5jyz/35J5TwPc95nX4ic56HZhW2WX7WOk5NSEh
         ObXwIUFFb9woVuJVdpuAW6KW7sWOIhUFfGcdd/Y0UKGVws1tSy4tbgQbnyLMnSQyVivn
         ARwMuKZ0250f/7oHhfYAIhs8LHBpNaWFyIugeBSrZzo+IJIIjV+YmfO6maZtXYa2Brag
         q+ZA==
X-Forwarded-Encrypted: i=1; AJvYcCUIdZMt5apEtnIT9B0MoAFhmllr1LJt9akovNcM8Q6qpZBl7vB9yVG5aXvS/tmMXOtpCDbksKqk8MAfLH9ymfoSaHINY7muh8esS4XC
X-Gm-Message-State: AOJu0YwpXevObYIBBeTEpr1LxaPllr1qSEpgqgbasOR7EkBsuKnrV5yq
	dz2Cl7lRrAwuJye0ARwS+luYIzdlXMewOrEn+jGSxNmFRqfk/B4d0j+3kaR4OLc=
X-Google-Smtp-Source: AGHT+IE9zBak+hMpn3Ph0jYBO/9Gn+nFW62YOmSwj9wIWutOez5hmKoEHjtWh+xuqmKU2HEAtYBw+Q==
X-Received: by 2002:a05:600c:3582:b0:426:6bf9:608d with SMTP id 5b1f17b1804b1-427dc52050dmr42436115e9.12.1721643168649;
        Mon, 22 Jul 2024 03:12:48 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a8e436sm147993865e9.33.2024.07.22.03.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 03:12:48 -0700 (PDT)
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
Subject: [PATCH v6 04/17] perf: cs-etm: Create decoders based on the trace ID mappings
Date: Mon, 22 Jul 2024 11:11:46 +0100
Message-Id: <20240722101202.26915-5-james.clark@linaro.org>
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

Now that each queue has a unique set of trace ID mappings, use this
list to create the decoders. In unformatted mode just add a single
mapping so only one decoder is made.

Previously each queue would have a decoder created for each traced CPU
on the system but this won't work anymore because CPUs can have
overlapping trace IDs.

This also means that the CORESIGHT_TRACE_ID_UNUSED_FLAG isn't needed
any more. If mappings aren't added then decoders aren't created, rather
than needing a flag to suppress creation.

Signed-off-by: James Clark <james.clark@arm.com>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c             |   8 +-
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c |   4 -
 tools/perf/util/cs-etm.c                      | 155 ++++++------------
 tools/perf/util/cs-etm.h                      |  10 --
 4 files changed, 55 insertions(+), 122 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index da6231367993..b0118546cd4d 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -654,8 +654,7 @@ static void cs_etm_save_etmv4_header(__u64 data[], struct auxtrace_record *itr,
 	/* Get trace configuration register */
 	data[CS_ETMV4_TRCCONFIGR] = cs_etmv4_get_config(itr);
 	/* traceID set to legacy version, in case new perf running on older system */
-	data[CS_ETMV4_TRCTRACEIDR] = cs_etm_get_legacy_trace_id(cpu) |
-				     CORESIGHT_TRACE_ID_UNUSED_FLAG;
+	data[CS_ETMV4_TRCTRACEIDR] = cs_etm_get_legacy_trace_id(cpu);
 
 	/* Get read-only information from sysFS */
 	cs_etm_get_ro(cs_etm_pmu, cpu, metadata_etmv4_ro[CS_ETMV4_TRCIDR0],
@@ -687,7 +686,7 @@ static void cs_etm_save_ete_header(__u64 data[], struct auxtrace_record *itr, st
 	/* Get trace configuration register */
 	data[CS_ETE_TRCCONFIGR] = cs_etmv4_get_config(itr);
 	/* traceID set to legacy version, in case new perf running on older system */
-	data[CS_ETE_TRCTRACEIDR] = cs_etm_get_legacy_trace_id(cpu) | CORESIGHT_TRACE_ID_UNUSED_FLAG;
+	data[CS_ETE_TRCTRACEIDR] = cs_etm_get_legacy_trace_id(cpu);
 
 	/* Get read-only information from sysFS */
 	cs_etm_get_ro(cs_etm_pmu, cpu, metadata_ete_ro[CS_ETE_TRCIDR0], &data[CS_ETE_TRCIDR0]);
@@ -743,8 +742,7 @@ static void cs_etm_get_metadata(struct perf_cpu cpu, u32 *offset,
 		/* Get configuration register */
 		info->priv[*offset + CS_ETM_ETMCR] = cs_etm_get_config(itr);
 		/* traceID set to legacy value in case new perf running on old system */
-		info->priv[*offset + CS_ETM_ETMTRACEIDR] = cs_etm_get_legacy_trace_id(cpu) |
-							   CORESIGHT_TRACE_ID_UNUSED_FLAG;
+		info->priv[*offset + CS_ETM_ETMTRACEIDR] = cs_etm_get_legacy_trace_id(cpu);
 		/* Get read-only information from sysFS */
 		cs_etm_get_ro(cs_etm_pmu, cpu, metadata_etmv3_ro[CS_ETM_ETMCCER],
 			      &info->priv[*offset + CS_ETM_ETMCCER]);
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 0c9c48cedbf1..d49c3e9c7c21 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -684,10 +684,6 @@ cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
 		return -1;
 	}
 
-	/* if the CPU has no trace ID associated, no decoder needed */
-	if (csid == CORESIGHT_TRACE_ID_UNUSED_VAL)
-		return 0;
-
 	if (d_params->operation == CS_ETM_OPERATION_DECODE) {
 		if (ocsd_dt_create_decoder(decoder->dcd_tree,
 					   decoder->decoder_name,
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 582526d9676f..7cce58dca33c 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -348,7 +348,6 @@ static int cs_etm__metadata_get_trace_id(u8 *trace_chan_id, u64 *cpu_metadata)
 
 /*
  * update metadata trace ID from the value found in the AUX_HW_INFO packet.
- * This will also clear the CORESIGHT_TRACE_ID_UNUSED_FLAG flag if present.
  */
 static int cs_etm__metadata_set_trace_id(u8 trace_chan_id, u64 *cpu_metadata)
 {
@@ -700,80 +699,58 @@ static void cs_etm__packet_dump(const char *pkt_string)
 }
 
 static void cs_etm__set_trace_param_etmv3(struct cs_etm_trace_params *t_params,
-					  struct cs_etm_auxtrace *etm, int t_idx,
-					  int m_idx, u32 etmidr)
+					  u64 *metadata, u32 etmidr)
 {
-	u64 **metadata = etm->metadata;
-
-	t_params[t_idx].protocol = cs_etm__get_v7_protocol_version(etmidr);
-	t_params[t_idx].etmv3.reg_ctrl = metadata[m_idx][CS_ETM_ETMCR];
-	t_params[t_idx].etmv3.reg_trc_id = metadata[m_idx][CS_ETM_ETMTRACEIDR];
+	t_params->protocol = cs_etm__get_v7_protocol_version(etmidr);
+	t_params->etmv3.reg_ctrl = metadata[CS_ETM_ETMCR];
+	t_params->etmv3.reg_trc_id = metadata[CS_ETM_ETMTRACEIDR];
 }
 
 static void cs_etm__set_trace_param_etmv4(struct cs_etm_trace_params *t_params,
-					  struct cs_etm_auxtrace *etm, int t_idx,
-					  int m_idx)
+					  u64 *metadata)
 {
-	u64 **metadata = etm->metadata;
-
-	t_params[t_idx].protocol = CS_ETM_PROTO_ETMV4i;
-	t_params[t_idx].etmv4.reg_idr0 = metadata[m_idx][CS_ETMV4_TRCIDR0];
-	t_params[t_idx].etmv4.reg_idr1 = metadata[m_idx][CS_ETMV4_TRCIDR1];
-	t_params[t_idx].etmv4.reg_idr2 = metadata[m_idx][CS_ETMV4_TRCIDR2];
-	t_params[t_idx].etmv4.reg_idr8 = metadata[m_idx][CS_ETMV4_TRCIDR8];
-	t_params[t_idx].etmv4.reg_configr = metadata[m_idx][CS_ETMV4_TRCCONFIGR];
-	t_params[t_idx].etmv4.reg_traceidr = metadata[m_idx][CS_ETMV4_TRCTRACEIDR];
+	t_params->protocol = CS_ETM_PROTO_ETMV4i;
+	t_params->etmv4.reg_idr0 = metadata[CS_ETMV4_TRCIDR0];
+	t_params->etmv4.reg_idr1 = metadata[CS_ETMV4_TRCIDR1];
+	t_params->etmv4.reg_idr2 = metadata[CS_ETMV4_TRCIDR2];
+	t_params->etmv4.reg_idr8 = metadata[CS_ETMV4_TRCIDR8];
+	t_params->etmv4.reg_configr = metadata[CS_ETMV4_TRCCONFIGR];
+	t_params->etmv4.reg_traceidr = metadata[CS_ETMV4_TRCTRACEIDR];
 }
 
 static void cs_etm__set_trace_param_ete(struct cs_etm_trace_params *t_params,
-					  struct cs_etm_auxtrace *etm, int t_idx,
-					  int m_idx)
+					u64 *metadata)
 {
-	u64 **metadata = etm->metadata;
-
-	t_params[t_idx].protocol = CS_ETM_PROTO_ETE;
-	t_params[t_idx].ete.reg_idr0 = metadata[m_idx][CS_ETE_TRCIDR0];
-	t_params[t_idx].ete.reg_idr1 = metadata[m_idx][CS_ETE_TRCIDR1];
-	t_params[t_idx].ete.reg_idr2 = metadata[m_idx][CS_ETE_TRCIDR2];
-	t_params[t_idx].ete.reg_idr8 = metadata[m_idx][CS_ETE_TRCIDR8];
-	t_params[t_idx].ete.reg_configr = metadata[m_idx][CS_ETE_TRCCONFIGR];
-	t_params[t_idx].ete.reg_traceidr = metadata[m_idx][CS_ETE_TRCTRACEIDR];
-	t_params[t_idx].ete.reg_devarch = metadata[m_idx][CS_ETE_TRCDEVARCH];
+	t_params->protocol = CS_ETM_PROTO_ETE;
+	t_params->ete.reg_idr0 = metadata[CS_ETE_TRCIDR0];
+	t_params->ete.reg_idr1 = metadata[CS_ETE_TRCIDR1];
+	t_params->ete.reg_idr2 = metadata[CS_ETE_TRCIDR2];
+	t_params->ete.reg_idr8 = metadata[CS_ETE_TRCIDR8];
+	t_params->ete.reg_configr = metadata[CS_ETE_TRCCONFIGR];
+	t_params->ete.reg_traceidr = metadata[CS_ETE_TRCTRACEIDR];
+	t_params->ete.reg_devarch = metadata[CS_ETE_TRCDEVARCH];
 }
 
 static int cs_etm__init_trace_params(struct cs_etm_trace_params *t_params,
-				     struct cs_etm_auxtrace *etm,
-				     enum cs_etm_format format,
-				     int sample_cpu,
-				     int decoders)
-{
-	int t_idx, m_idx;
-	u32 etmidr;
-	u64 architecture;
-
-	for (t_idx = 0; t_idx < decoders; t_idx++) {
-		if (format == FORMATTED)
-			m_idx = t_idx;
-		else {
-			m_idx = get_cpu_data_idx(etm, sample_cpu);
-			if (m_idx == -1) {
-				pr_warning("CS_ETM: unknown CPU, falling back to first metadata\n");
-				m_idx = 0;
-			}
-		}
+				     struct cs_etm_queue *etmq)
+{
+	struct int_node *inode;
 
-		architecture = etm->metadata[m_idx][CS_ETM_MAGIC];
+	intlist__for_each_entry(inode, etmq->traceid_list) {
+		u64 *metadata = inode->priv;
+		u64 architecture = metadata[CS_ETM_MAGIC];
+		u32 etmidr;
 
 		switch (architecture) {
 		case __perf_cs_etmv3_magic:
-			etmidr = etm->metadata[m_idx][CS_ETM_ETMIDR];
-			cs_etm__set_trace_param_etmv3(t_params, etm, t_idx, m_idx, etmidr);
+			etmidr = metadata[CS_ETM_ETMIDR];
+			cs_etm__set_trace_param_etmv3(t_params++, metadata, etmidr);
 			break;
 		case __perf_cs_etmv4_magic:
-			cs_etm__set_trace_param_etmv4(t_params, etm, t_idx, m_idx);
+			cs_etm__set_trace_param_etmv4(t_params++, metadata);
 			break;
 		case __perf_cs_ete_magic:
-			cs_etm__set_trace_param_ete(t_params, etm, t_idx, m_idx);
+			cs_etm__set_trace_param_ete(t_params++, metadata);
 			break;
 		default:
 			return -EINVAL;
@@ -3211,35 +3188,6 @@ static int cs_etm__map_trace_ids_metadata(struct cs_etm_auxtrace *etm, int num_c
 	return 0;
 }
 
-/*
- * If we found AUX_HW_ID packets, then set any metadata marked as unused to the
- * unused value to reduce the number of unneeded decoders created.
- */
-static int cs_etm__clear_unused_trace_ids_metadata(int num_cpu, u64 **metadata)
-{
-	u64 cs_etm_magic;
-	int i;
-
-	for (i = 0; i < num_cpu; i++) {
-		cs_etm_magic = metadata[i][CS_ETM_MAGIC];
-		switch (cs_etm_magic) {
-		case __perf_cs_etmv3_magic:
-			if (metadata[i][CS_ETM_ETMTRACEIDR] & CORESIGHT_TRACE_ID_UNUSED_FLAG)
-				metadata[i][CS_ETM_ETMTRACEIDR] = CORESIGHT_TRACE_ID_UNUSED_VAL;
-			break;
-		case __perf_cs_etmv4_magic:
-		case __perf_cs_ete_magic:
-			if (metadata[i][CS_ETMV4_TRCTRACEIDR] & CORESIGHT_TRACE_ID_UNUSED_FLAG)
-				metadata[i][CS_ETMV4_TRCTRACEIDR] = CORESIGHT_TRACE_ID_UNUSED_VAL;
-			break;
-		default:
-			/* unknown magic number */
-			return -EINVAL;
-		}
-	}
-	return 0;
-}
-
 /*
  * Use the data gathered by the peeks for HW_ID (trace ID mappings) and AUX
  * (formatted or not) packets to create the decoders.
@@ -3247,21 +3195,26 @@ static int cs_etm__clear_unused_trace_ids_metadata(int num_cpu, u64 **metadata)
 static int cs_etm__create_queue_decoders(struct cs_etm_queue *etmq)
 {
 	struct cs_etm_decoder_params d_params;
+	struct cs_etm_trace_params  *t_params;
+	int decoders = intlist__nr_entries(etmq->traceid_list);
+
+	if (decoders == 0)
+		return 0;
 
 	/*
 	 * Each queue can only contain data from one CPU when unformatted, so only one decoder is
 	 * needed.
 	 */
-	int decoders = etmq->format == FORMATTED ? etmq->etm->num_cpu : 1;
+	if (etmq->format == UNFORMATTED)
+		assert(decoders == 1);
 
 	/* Use metadata to fill in trace parameters for trace decoder */
-	struct cs_etm_trace_params  *t_params = zalloc(sizeof(*t_params) * decoders);
+	t_params = zalloc(sizeof(*t_params) * decoders);
 
 	if (!t_params)
 		goto out_free;
 
-	if (cs_etm__init_trace_params(t_params, etmq->etm, etmq->format,
-				      etmq->queue_nr, decoders))
+	if (cs_etm__init_trace_params(t_params, etmq))
 		goto out_free;
 
 	/* Set decoder parameters to decode trace packets */
@@ -3487,9 +3440,9 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	/*
 	 * Map Trace ID values to CPU metadata.
 	 *
-	 * Trace metadata will always contain Trace ID values from the legacy algorithm. If the
-	 * files has been recorded by a "new" perf updated to handle AUX_HW_ID then the metadata
-	 * ID value will also have the CORESIGHT_TRACE_ID_UNUSED_FLAG set.
+	 * Trace metadata will always contain Trace ID values from the legacy algorithm
+	 * in case it's read by a version of Perf that doesn't know about HW_ID packets
+	 * or the kernel doesn't emit them.
 	 *
 	 * The updated kernel drivers that use AUX_HW_ID to sent Trace IDs will attempt to use
 	 * the same IDs as the old algorithm as far as is possible, unless there are clashes
@@ -3498,12 +3451,11 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	 *
 	 * For a perf able to interpret AUX_HW_ID packets we first check for the presence of
 	 * those packets. If they are there then the values will be mapped and plugged into
-	 * the metadata. We then set any remaining metadata values with the used flag to a
-	 * value CORESIGHT_TRACE_ID_UNUSED_VAL - which indicates no decoder is required.
+	 * the metadata and decoders are only created for each mapping received.
 	 *
 	 * If no AUX_HW_ID packets are present - which means a file recorded on an old kernel
-	 * then we map Trace ID values to CPU directly from the metadata - clearing any unused
-	 * flags if present.
+	 * then we map Trace ID values to CPU directly from the metadata and create decoders
+	 * for all mappings.
 	 */
 
 	/* Scan for AUX_OUTPUT_HW_ID records to map trace ID values to CPU metadata */
@@ -3514,15 +3466,12 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	if (err)
 		goto err_free_queues;
 
-	/* if HW ID found then clear any unused metadata ID values */
-	if (aux_hw_id_found)
-		err = cs_etm__clear_unused_trace_ids_metadata(num_cpu, metadata);
-	/* otherwise, this is a file with metadata values only, map from metadata */
-	else
+	/* if no HW ID found this is a file with metadata values only, map from metadata */
+	if (!aux_hw_id_found) {
 		err = cs_etm__map_trace_ids_metadata(etm, num_cpu, metadata);
-
-	if (err)
-		goto err_free_queues;
+		if (err)
+			goto err_free_queues;
+	}
 
 	err = cs_etm__create_decoders(etm);
 	if (err)
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index f4f69f7cc0f3..a8caeea720aa 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -230,16 +230,6 @@ struct cs_etm_packet_queue {
 /* CoreSight trace ID is currently the bottom 7 bits of the value */
 #define CORESIGHT_TRACE_ID_VAL_MASK	GENMASK(6, 0)
 
-/*
- * perf record will set the legacy meta data values as unused initially.
- * This allows perf report to manage the decoders created when dynamic
- * allocation in operation.
- */
-#define CORESIGHT_TRACE_ID_UNUSED_FLAG	BIT(31)
-
-/* Value to set for unused trace ID values */
-#define CORESIGHT_TRACE_ID_UNUSED_VAL	0x7F
-
 int cs_etm__process_auxtrace_info(union perf_event *event,
 				  struct perf_session *session);
 void cs_etm_get_default_config(const struct perf_pmu *pmu, struct perf_event_attr *attr);
-- 
2.34.1


