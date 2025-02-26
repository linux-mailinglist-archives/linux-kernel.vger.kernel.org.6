Return-Path: <linux-kernel+bounces-533559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A19EFA45C0A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 772B27A5C83
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEA124E000;
	Wed, 26 Feb 2025 10:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hCJC/TyQ"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D84942A9D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740566497; cv=none; b=BPpdwPMqXNqtOG/NyxQn+LonJd18uTOAUlfXAAHmOwHYIMlQSjgvV2r1qufcrGhyUBpQZZ7Hv5FNebgNp1jM0Rbdi6UcQyLbP5ktGB2rNVsKRszDxkajb2f+OqILBX8Sa/aOCPUbjDA3V4bJheJobqf3d1TbifjWpYjyGlhH4WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740566497; c=relaxed/simple;
	bh=I+I/8/xf34EbwKSApSqeEKtUP8iTESCQ7V0oqUtLUC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j3JufO0m54wwrKPxkQg6lE3FiORlQje2LTZuYDFmPDchr06GSnp/boqF8BPWLmv0/XLvtpbJuuxC/YoqROWr6783RIFfCamJJ2hXFJ6wmnReDBYZQtoP7Hs6cdbpEPw5IWusUydENgOXVV+lUVzJlcE1k8YfaFNdtatiRE7nwTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hCJC/TyQ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38f5fc33602so463539f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 02:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740566493; x=1741171293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojcUEtfO91j+JO9KXm+lQGJj1Y8aR3j+uQwF6xWxzOk=;
        b=hCJC/TyQGw/rzbRVnbIvHgQNTTQUleZ8aCxLtbJeQAfxU+au2ljZYRF/IkWK3ljUV/
         uHEbYUQgJFv4PX7cbe+mgl/iNMFOh/BAhaBRBb5BBtVvTux3wTGkJWydAS8Osc/Jgw+5
         UAE2vpIm9k92TbFiTBc0dUBHVCIYjRP1gnsCdIDgd5HC/tuH+q1UeKg8CAiHvSfxxWxb
         LGJugioIH/XodQBEBOGhxDGDx8RB/jIYJQhl14vD4oMru30JHGrbW01N9U1uZacg+Vsb
         6KI/8JtbWYnwLV8o0WrVC4DYCPpHYl45IJ+O01QR9A41o7PFJkThQ5bZQMEHESOpg9od
         sZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740566493; x=1741171293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojcUEtfO91j+JO9KXm+lQGJj1Y8aR3j+uQwF6xWxzOk=;
        b=dCoyOPqRi9Wr1dZoONWA1Qj+yi7bOVhHBdK6Qbt/5s3LjKtSNAKfXVWh+7AllCHvCq
         kmLit5vsNenr2rOUNzn9eImUBWZIiBYRhpXaLXsng8aO0mNO/NQnAvQQV5WXKITLPHhc
         mSjgB5YdRItnL58TWZPYUgBCkKBc/ip3yHBX7/c+eW372fyNjxFlWYRkB4M1ZX5/I3XS
         PjNrqXNrsGm/otO3NL2IqyypJrTImHKOrw7MAwAZ0q21c9eQxFDgOJSraeyn09sPCswC
         JzXITIZ6nmhZhENMiB+sN2mUiQ7PyfZztT9ct1hR0o/mprwJsKjKnv8cHYg3V8C+h6mB
         fF4A==
X-Forwarded-Encrypted: i=1; AJvYcCVVtRux3C0duRhm3gJv6y60bD833Fgq0OOhM2FprMwmtpjaZk+BKBt4ZsmZv8E2dcXVwt/sKNJDlomd6Gc=@vger.kernel.org
X-Gm-Message-State: AOJu0YysaHRAkF4QVTWfb1hm+jHobB+eBRJ87BJyHkjxpv+13IqKoVBN
	IZh2qPPf9pAT+nKYRiT8r0jF18Ze6xt4/cQCBtql8S9UZhOyie5xsbpZxHBi6g8=
X-Gm-Gg: ASbGncsky1NgaCq7kE4G6g7tbw6KHSt+01Sk/KPDEIaIN0B2wj2vCUsZ5fL3ob08sVX
	NRhXPLQ2JqstaOIFlGaSkxQNCTAHAEzwNUnYblKKxmDOlZqQ02kwhwWUBYDX/GeV7csEtF27dEM
	32qhUN5g53aRU7wtRb/jgEwfEXtM01JRZQoT83aiqQaZweksd/ry6nKBxtYGtz53L0PnvgprJgm
	TxnpGODqS7i3C5p857LT7bjmVq6XbXgAhLobhhIOUkglGJgOOaRrf3OQABc30tn8eYsrZXhxRMw
	vaC++3+0KwFq6q3g/KOEEBvFkXc=
X-Google-Smtp-Source: AGHT+IHeEQGMuScqdt+otMxEcTZ0w/KlZkRLRkmqcLWLGizQi7xw1jIAhR1WxzNLVabB3EHEyGVDUA==
X-Received: by 2002:a5d:6486:0:b0:38f:2c10:da1e with SMTP id ffacd0b85a97d-38f6f51db8amr15902752f8f.27.1740566493501;
        Wed, 26 Feb 2025 02:41:33 -0800 (PST)
Received: from pop-os.lan ([145.224.66.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd86c93bsm5080832f8f.26.2025.02.26.02.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 02:41:33 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	irogers@google.com,
	namhyung@kernel.org,
	cyy@cyyself.name
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Yoshihiro Furudera <fj5100bi@fujitsu.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
	Junhao He <hejunhao3@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] perf pmu: Dynamically allocate tool PMU
Date: Wed, 26 Feb 2025 10:41:00 +0000
Message-Id: <20250226104111.564443-2-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226104111.564443-1-james.clark@linaro.org>
References: <20250226104111.564443-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf_pmus__destroy() treats all PMUs as allocated and free's them so we
can't have any static PMUs that are added to the PMU lists. Fix it by
allocating the tool PMU in the same way as the others. Current users of
the tool PMU already use find_pmu() and not perf_pmus__tool_pmu(), so
rename the function to add 'new' to avoid it being misused in the
future.

perf_pmus__fake_pmu() can remain as static as it's not added to the
PMU lists.

Fixes the following error:

  $ perf bench internals pmu-scan

  # Running 'internals/pmu-scan' benchmark:
  Computing performance of sysfs PMU event scan for 100 times
  munmap_chunk(): invalid pointer
  Aborted (core dumped)

Fixes: 240505b2d0ad ("perf tool_pmu: Factor tool events into their own PMU")
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/pmus.c     |  2 +-
 tools/perf/util/tool_pmu.c | 23 +++++++++++------------
 tools/perf/util/tool_pmu.h |  2 +-
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 8a0a919415d4..6498021acef0 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -268,7 +268,7 @@ static void pmu_read_sysfs(unsigned int to_read_types)
 
 	if ((to_read_types & PERF_TOOL_PMU_TYPE_TOOL_MASK) != 0 &&
 	    (read_pmu_types & PERF_TOOL_PMU_TYPE_TOOL_MASK) == 0) {
-		tool_pmu = perf_pmus__tool_pmu();
+		tool_pmu = tool_pmu__new();
 		list_add_tail(&tool_pmu->list, &other_pmus);
 	}
 	if ((to_read_types & PERF_TOOL_PMU_TYPE_HWMON_MASK) != 0 &&
diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
index 3a68debe7143..9156745ea180 100644
--- a/tools/perf/util/tool_pmu.c
+++ b/tools/perf/util/tool_pmu.c
@@ -490,17 +490,16 @@ int evsel__tool_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread)
 	return 0;
 }
 
-struct perf_pmu *perf_pmus__tool_pmu(void)
+struct perf_pmu *tool_pmu__new(void)
 {
-	static struct perf_pmu tool = {
-		.name = "tool",
-		.type = PERF_PMU_TYPE_TOOL,
-		.aliases = LIST_HEAD_INIT(tool.aliases),
-		.caps = LIST_HEAD_INIT(tool.caps),
-		.format = LIST_HEAD_INIT(tool.format),
-	};
-	if (!tool.events_table)
-		tool.events_table = find_core_events_table("common", "common");
-
-	return &tool;
+	struct perf_pmu *tool = zalloc(sizeof(struct perf_pmu));
+
+	tool->name = strdup("tool");
+	tool->type = PERF_PMU_TYPE_TOOL;
+	INIT_LIST_HEAD(&tool->aliases);
+	INIT_LIST_HEAD(&tool->caps);
+	INIT_LIST_HEAD(&tool->format);
+	tool->events_table = find_core_events_table("common", "common");
+
+	return tool;
 }
diff --git a/tools/perf/util/tool_pmu.h b/tools/perf/util/tool_pmu.h
index a60184859080..c6ad1dd90a56 100644
--- a/tools/perf/util/tool_pmu.h
+++ b/tools/perf/util/tool_pmu.h
@@ -51,6 +51,6 @@ int evsel__tool_pmu_open(struct evsel *evsel,
 			 int start_cpu_map_idx, int end_cpu_map_idx);
 int evsel__tool_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread);
 
-struct perf_pmu *perf_pmus__tool_pmu(void);
+struct perf_pmu *tool_pmu__new(void);
 
 #endif /* __TOOL_PMU_H */
-- 
2.34.1


