Return-Path: <linux-kernel+bounces-228946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3C59168F5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 151301F270D8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B7615F3E8;
	Tue, 25 Jun 2024 13:33:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81851158D83;
	Tue, 25 Jun 2024 13:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719322406; cv=none; b=hcUufM/zKWElDqUUfsfqWYA4j1N3fRs/tdo83SmpKaz26hAO21sfM6KaQbyIZR/WB2fAvN5byUu8eYpQaA1+/bSsjDu98c9j48Jf+syPloUlJQU4i9hvEnPFfbwj0kG6mfS/zbn9WLcS0aIBJqMyMyMq2w0Edwk+YpevV6uVW74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719322406; c=relaxed/simple;
	bh=sFCq76/ReKigOw24t2/rKzVdHlb+dXBaVLMq8dLOOwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V41iwUBiVE5afVVOyJwmJYbunJVHvxJRXJQcCFc7OAYIrozktb1ezoFNLgkVkDAbfPnJmymFP7tTPSp9vdPPgAdsBpbfH4Cg8CAn1jWvha1Ug3SyO8ag5GIqd24CugJWSkkR8vGdMThd3bb9Eu5SAfCScsCvMqRVOm808G7gr0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4CA8DA7;
	Tue, 25 Jun 2024 06:33:48 -0700 (PDT)
Received: from e127643.broadband (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 70ECF3F73B;
	Tue, 25 Jun 2024 06:33:20 -0700 (PDT)
From: James Clark <james.clark@arm.com>
To: coresight@lists.linaro.org,
	suzuki.poulose@arm.com,
	gankulkarni@os.amperecomputing.com,
	mike.leach@linaro.org,
	leo.yan@linux.dev,
	anshuman.khandual@arm.com,
	jszu@nvidia.com,
	bwicaksono@nvidia.com
Cc: James Clark <james.clark@arm.com>,
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
Subject: [PATCH v4 08/17] perf: cs-etm: Add runtime version check for OpenCSD
Date: Tue, 25 Jun 2024 14:30:51 +0100
Message-Id: <20240625133105.671245-9-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625133105.671245-1-james.clark@arm.com>
References: <20240625133105.671245-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

OpenCSD is dynamically linked so although there is a build time check,
at runtime the user might still have the wrong version. To avoid hard
to debug errors, add a runtime version check.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/build/feature/test-libopencsd.c               |  4 ++--
 tools/perf/Makefile.config                          |  2 +-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c     | 13 +++++++++++++
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h     |  1 +
 tools/perf/util/cs-etm-decoder/cs-etm-min-version.h | 13 +++++++++++++
 tools/perf/util/cs-etm.c                            |  3 +++
 6 files changed, 33 insertions(+), 3 deletions(-)
 create mode 100644 tools/perf/util/cs-etm-decoder/cs-etm-min-version.h

diff --git a/tools/build/feature/test-libopencsd.c b/tools/build/feature/test-libopencsd.c
index 4cfcef9da3e4..d092a0c662f4 100644
--- a/tools/build/feature/test-libopencsd.c
+++ b/tools/build/feature/test-libopencsd.c
@@ -1,12 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <opencsd/c_api/opencsd_c_api.h>
+#include "cs-etm-decoder/cs-etm-min-version.h"
 
 /*
  * Check OpenCSD library version is sufficient to provide required features
  */
-#define OCSD_MIN_VER ((1 << 16) | (2 << 8) | (1))
 #if !defined(OCSD_VER_NUM) || (OCSD_VER_NUM < OCSD_MIN_VER)
-#error "OpenCSD >= 1.2.1 is required"
+#error "OpenCSD minimum version (OCSD_MIN_VER) not met."
 #endif
 
 int main(void)
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 7f1e016a9253..2d21be42820e 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -141,7 +141,7 @@ endif
 ifdef CSLIBS
   LIBOPENCSD_LDFLAGS := -L$(CSLIBS)
 endif
-FEATURE_CHECK_CFLAGS-libopencsd := $(LIBOPENCSD_CFLAGS)
+FEATURE_CHECK_CFLAGS-libopencsd := $(LIBOPENCSD_CFLAGS) -I$(src-perf)/util
 FEATURE_CHECK_LDFLAGS-libopencsd := $(LIBOPENCSD_LDFLAGS) $(OPENCSDLIBS)
 
 # for linking with debug library, run like:
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index b78ef0262135..5e1b4503aab1 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -16,6 +16,7 @@
 
 #include "cs-etm.h"
 #include "cs-etm-decoder.h"
+#include "cs-etm-min-version.h"
 #include "debug.h"
 #include "intlist.h"
 
@@ -835,3 +836,15 @@ const char *cs_etm_decoder__get_name(struct cs_etm_decoder *decoder)
 {
 	return decoder->decoder_name;
 }
+
+int cs_etm_decoder__check_ver(void)
+{
+	if (ocsd_get_version() < OCSD_MIN_VER) {
+		pr_err("OpenCSD >= %d.%d.%d is required\n", OCSD_MIN_MAJOR,
+							    OCSD_MIN_MINOR,
+							    OCSD_MIN_PATCH);
+		return -EINVAL;
+	}
+
+	return 0;
+}
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 12c782fa6db2..2ec426ee16dc 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -107,5 +107,6 @@ int cs_etm_decoder__get_packet(struct cs_etm_packet_queue *packet_queue,
 
 int cs_etm_decoder__reset(struct cs_etm_decoder *decoder);
 const char *cs_etm_decoder__get_name(struct cs_etm_decoder *decoder);
+int cs_etm_decoder__check_ver(void);
 
 #endif /* INCLUDE__CS_ETM_DECODER_H__ */
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-min-version.h b/tools/perf/util/cs-etm-decoder/cs-etm-min-version.h
new file mode 100644
index 000000000000..c69597e9d0af
--- /dev/null
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-min-version.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef INCLUDE__CS_ETM_MIN_VERSION_H__
+#define INCLUDE__CS_ETM_MIN_VERSION_H__
+
+#define OCSD_MIN_MAJOR 1
+#define OCSD_MIN_MINOR 2
+#define OCSD_MIN_PATCH 1
+
+#define OCSD_MIN_VER ((OCSD_MIN_MAJOR << 16) | \
+		      (OCSD_MIN_MINOR << 8) |  \
+		      (OCSD_MIN_PATCH))
+
+#endif /* INCLUDE__CS_ETM_MIN_VERSION_H__ */
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 49fadf46f42b..2385d5ed5ea5 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -3369,6 +3369,9 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	u64 *ptr = NULL;
 	u64 **metadata = NULL;
 
+	if (cs_etm_decoder__check_ver())
+		return -EINVAL;
+
 	/* First the global part */
 	ptr = (u64 *) auxtrace_info->priv;
 	num_cpu = ptr[CS_PMU_TYPE_CPUS] & 0xffffffff;
-- 
2.34.1


