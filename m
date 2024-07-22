Return-Path: <linux-kernel+bounces-258846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB89938D50
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 12:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E53A1C20EBD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DFD16D4F4;
	Mon, 22 Jul 2024 10:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BmfyZEzC"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C50316D4E9
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 10:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721643191; cv=none; b=QzxNMyvb3LqpI93BS0mIw6zT8HAqiyTgmFyWWG31xGsZJ/h7E6gGB629waF6pIaoetvYjsxnK5x8ePmnvLmrKmFCUn9fuhzuExlgq4Ew7to2H+Am2HdFeYB7fD2PIIS/41Blz+FQbR60L1eQ/WeMZm44vJGHr6TdgR1btTVHaXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721643191; c=relaxed/simple;
	bh=Rmx9udRvRCv0Ng1SFnELTkKSgQvIMsfgbQtlWF36fnk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LxAtIWYblbV6h8BrWbETmjqQihqWK/gBRj8WSuCq6IXxmYonztBsPsQt8AFLrxtNlWAaL1fdTcaYZYgaJmfm++aJ6YRFn9eTYOnPXw4lObGwNhUqzniPCMvdfKjlxdvA5ugCdh4Aw7Gq4rDumuQ149M3YMaYnQoQKCoiaXlEXx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BmfyZEzC; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4266f344091so29867285e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 03:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721643188; x=1722247988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPkIquw077gYIEvctFCCllwMLWJh43EU4ppM2MPUVYk=;
        b=BmfyZEzCdg1doVGaUlA3QseTK8BWzyDlbinbMWNvENfS1XuV9FQvvSttYGroFT2UTJ
         uWxOPHAxZWQzyhf/1G5sdUzqrW+YGmW+U9+STytogMyuKLw2TV7UTot7nCZOw+R4R+XV
         pnWhdBn1J3kSxBKPj3K8z4Mbd3glRciPiczK8Sm7+3r9Kj7ks7aSyjwMTV6M93VMEhIs
         yVlnDizHgkt7Ij1meNrD/MbIXbkGnqbIGWUj0Si5XBqfhZxOvurQiUn7s5kc/KptpbXl
         o70UkHj19fe3FNkqjCaJyJmPQW7y5zNb5k26vAuqIATJAOHW1X5fjev4P674WQLnulWS
         uonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721643188; x=1722247988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sPkIquw077gYIEvctFCCllwMLWJh43EU4ppM2MPUVYk=;
        b=WiJ0MNP8skOmODqGctIFE2wAcDR+CRAXUXKSiSu+iumnKbmp10Cgofs0CruLYR9kio
         zTKX5pE8wnMxwNIqb/aQIG2V1ALCxUoarNCXT+ozFKQ97eMYMXyr+TCMGCuGDSDMVMHP
         lhdLWDF17XJOH5x95k0041ysHbz8RsD2Cz+1RHpDvx5kQqoehU8DI5KYG9AfZYRRBI8D
         +7ArlAncO/K6IMw+G882aYlXAwKabcYkUjJHotKk6Z5OqzhDwlgaU87Qg00D377ffSzK
         nxybtpKWig0DL4MYQ0+QC1SEIWEeeWjxTvASPVcKbAwDGpUNrM+oWunevUO9eL//gvng
         7UmA==
X-Forwarded-Encrypted: i=1; AJvYcCWkIWkSxmoDoA6WXChhjOZ1O0LXldpKnuold24aqE27Y8tL/PTau8X3c+t7Z3OT/K2r6L4Puf6IictU+gnT+y5fxxza7qhADf+NjU5b
X-Gm-Message-State: AOJu0YxlDXH4RGWFLaWGtPzYxwX2GPPq8td1VkPxNb+fXwNmR1dfCGmQ
	CdSyYM9+Y6Hcd6h6U2GoVFEtGMqbZaawpkXJt9RKJUu5GdQyta1HDzCu3tZnH/I=
X-Google-Smtp-Source: AGHT+IECJrbMk+SVuzf8P8M9gfHzpogypG1Je+ADnodsc8mmHRR3JgaHvZvv6i1KdtxQ2O7FGguNRw==
X-Received: by 2002:a05:600c:524b:b0:426:6b85:bafb with SMTP id 5b1f17b1804b1-427dc529177mr44503555e9.20.1721643187954;
        Mon, 22 Jul 2024 03:13:07 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a8e436sm147993865e9.33.2024.07.22.03.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 03:13:07 -0700 (PDT)
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
Subject: [PATCH v6 08/17] perf: cs-etm: Add runtime version check for OpenCSD
Date: Mon, 22 Jul 2024 11:11:50 +0100
Message-Id: <20240722101202.26915-9-james.clark@linaro.org>
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

OpenCSD is dynamically linked so although there is a build time check,
at runtime the user might still have the wrong version. To avoid hard
to debug errors, add a runtime version check.

Signed-off-by: James Clark <james.clark@arm.com>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: James Clark <james.clark@linaro.org>
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
index 6298a5c7a651..3b4a5d5ca25b 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -3375,6 +3375,9 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
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


