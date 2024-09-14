Return-Path: <linux-kernel+bounces-329607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2157897936E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 23:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8589A1F223EE
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 21:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BC21487C8;
	Sat, 14 Sep 2024 21:55:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59D213DDA7;
	Sat, 14 Sep 2024 21:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726350926; cv=none; b=Pv5hIgAIarxDFww2Pp+VQel347f9uwFNAniR2+6LJsM74zXnUFzfU5TwMb7mmCMecLUlJBprwaZiEjBy4h2OrqnIIq7CndTLviIUpzOo+R7vYpQ9AmDidrQt+omrPjp7byJC36iXry9nUqIwJANl7O6inSY8bCWdVeRkH0teebY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726350926; c=relaxed/simple;
	bh=ML3kt6uULPwU3f260Hrr/Ahh7vokh2zqjUQ1OzJCg8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jm5P2u4Icj+pxQAX7tsymzOEZNUrmDuvuNcmwJq3P9OR3g60ApUL8665Ucy4zJc6elyR2fOfx3naveMvo7t5OFU3ifjs/wlygIWIe5OMCbsnSn0R54KCN7TDpHMpj000v2pp8NZygk6dWWVu2LhTXVrOvRCe9JzPvwuzxdvi+hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EF1716A3;
	Sat, 14 Sep 2024 14:55:53 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 38FE03F66E;
	Sat, 14 Sep 2024 14:55:22 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	Will Deacon <will@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2 4/5] perf arm-spe: Support metadata version 2
Date: Sat, 14 Sep 2024 22:54:57 +0100
Message-Id: <20240914215458.751802-5-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240914215458.751802-1-leo.yan@arm.com>
References: <20240914215458.751802-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit is to support metadata version 2 and at the meantime it is
backward compatible for version 1's format.

The metadata version 1 doesn't include the ARM_SPE_HEADER_VERSION field.
As version 1 is fixed with two u64 fields, by checking the metadata
size, it distinguishes the metadata is version 1 or version 2 (and any
new versions if later will have). For version 2, it reads out CPU number
and retrieves the metadata info for every CPU.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe.c | 95 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 92 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 70989b1bae47..17782cb40fb5 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -78,6 +78,10 @@ struct arm_spe {
 
 	unsigned long			num_events;
 	u8				use_ctx_pkt_for_pid;
+
+	u64				**metadata;
+	u64				metadata_ver;
+	u64				metadata_nr_cpu;
 };
 
 struct arm_spe_queue {
@@ -1016,6 +1020,73 @@ static int arm_spe_flush(struct perf_session *session __maybe_unused,
 	return 0;
 }
 
+static u64 *arm_spe__alloc_per_cpu_metadata(u64 *buf, int cpu_size)
+{
+	u64 *metadata;
+
+	metadata = zalloc(sizeof(*metadata) * cpu_size);
+	if (!metadata)
+		return NULL;
+
+	memcpy(metadata, buf, cpu_size);
+	return metadata;
+}
+
+static void arm_spe__free_metadata(u64 **metadata, int nr_cpu)
+{
+	int i;
+
+	for (i = 0; i < nr_cpu; i++)
+		zfree(&metadata[i]);
+	free(metadata);
+}
+
+static u64 **arm_spe__alloc_metadata(struct perf_record_auxtrace_info *info,
+				     u64 *ver, int *nr_cpu)
+{
+	u64 *ptr = (u64 *)info->priv;
+	u64 metadata_size;
+	u64 **metadata = NULL;
+	int hdr_sz, cpu_sz, i;
+
+	metadata_size = info->header.size -
+		sizeof(struct perf_record_auxtrace_info);
+
+	/* Metadata version 1 */
+	if (metadata_size == ARM_SPE_AUXTRACE_V1_PRIV_SIZE) {
+		*ver = 1;
+		*nr_cpu = 0;
+		/* No per CPU metadata */
+		return NULL;
+	}
+
+	*ver = ptr[ARM_SPE_HEADER_VERSION];
+	hdr_sz = ptr[ARM_SPE_HEADER_SIZE];
+	*nr_cpu = ptr[ARM_SPE_CPUS_NUM];
+
+	metadata = zalloc(sizeof(*metadata) * (*nr_cpu));
+	if (!metadata)
+		return NULL;
+
+	/* Locate the start address of per CPU metadata */
+	ptr += hdr_sz;
+	cpu_sz = (metadata_size - (hdr_sz * sizeof(u64))) / (*nr_cpu);
+
+	for (i = 0; i < *nr_cpu; i++) {
+		metadata[i] = arm_spe__alloc_per_cpu_metadata(ptr, cpu_sz);
+		if (!metadata[i])
+			goto err_per_cpu_metadata;
+
+		ptr += cpu_sz / sizeof(u64);
+	}
+
+	return metadata;
+
+err_per_cpu_metadata:
+	arm_spe__free_metadata(metadata, *nr_cpu);
+	return NULL;
+}
+
 static void arm_spe_free_queue(void *priv)
 {
 	struct arm_spe_queue *speq = priv;
@@ -1050,6 +1121,7 @@ static void arm_spe_free(struct perf_session *session)
 	auxtrace_heap__free(&spe->heap);
 	arm_spe_free_events(session);
 	session->auxtrace = NULL;
+	arm_spe__free_metadata(spe->metadata, spe->metadata_nr_cpu);
 	free(spe);
 }
 
@@ -1267,15 +1339,24 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	const char *cpuid = perf_env__cpuid(session->evlist->env);
 	u64 midr = strtol(cpuid, NULL, 16);
 	struct arm_spe *spe;
-	int err;
+	u64 **metadata = NULL;
+	u64 metadata_ver;
+	int nr_cpu, err;
 
 	if (auxtrace_info->header.size < sizeof(struct perf_record_auxtrace_info) +
 					min_sz)
 		return -EINVAL;
 
+	metadata = arm_spe__alloc_metadata(auxtrace_info, &metadata_ver,
+					   &nr_cpu);
+	if (!metadata && metadata_ver != 1) {
+		pr_err("Failed to parse Arm SPE metadata.\n");
+		return -EINVAL;
+	}
+
 	spe = zalloc(sizeof(struct arm_spe));
 	if (!spe)
-		return -ENOMEM;
+		goto err_free_metadata;
 
 	err = auxtrace_queues__init(&spe->queues);
 	if (err)
@@ -1284,8 +1365,14 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	spe->session = session;
 	spe->machine = &session->machines.host; /* No kvm support */
 	spe->auxtrace_type = auxtrace_info->type;
-	spe->pmu_type = auxtrace_info->priv[ARM_SPE_PMU_TYPE];
+	if (metadata_ver == 1)
+		spe->pmu_type = auxtrace_info->priv[ARM_SPE_PMU_TYPE];
+	else
+		spe->pmu_type = auxtrace_info->priv[ARM_SPE_SHARED_PMU_TYPE];
 	spe->midr = midr;
+	spe->metadata = metadata;
+	spe->metadata_ver = metadata_ver;
+	spe->metadata_nr_cpu = nr_cpu;
 
 	spe->timeless_decoding = arm_spe__is_timeless_decoding(spe);
 
@@ -1346,5 +1433,7 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	session->auxtrace = NULL;
 err_free:
 	free(spe);
+err_free_metadata:
+	arm_spe__free_metadata(metadata, nr_cpu);
 	return err;
 }
-- 
2.34.1


