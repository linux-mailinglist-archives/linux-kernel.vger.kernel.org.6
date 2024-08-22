Return-Path: <linux-kernel+bounces-297349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE04495B68F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 15:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFEAD1C2081B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 13:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645D813C90A;
	Thu, 22 Aug 2024 13:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fXys8XYv"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E782E1CB141
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 13:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724333217; cv=none; b=X6ssrDIzkxvqDFgS7TOfZIkUruwBhgpljSKw/fJgBNE4HSagZsT1EvFptCAK/1cyoBuCWfVa9dz6S0TnWcnzeC89VNXFt1sXmKIJa/jTaDcgcTUDspyBYVQl5wGTDP7604/NJmEYJCtKQ+jNDLc6fPn8nYdqmYpIFFk0bmJOEFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724333217; c=relaxed/simple;
	bh=R1rW+JeCliU9jErQ2ls0dfEKB+GTh0fwrinuUyPU/Gw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RgvkgzJDB7ed4ODnGmXiu1TGzE0zlRbSDiu9XAu7A0s6rgd7JZ+iB8YYz/MZUtixQQw2NLSsdO4kSPwvzXqOT8BUVObeLaJPlySFvzHZquPF5FMT3g6wQ8Dh3hbqgW2vDxR8VJKSM2J7Y8IaYI33P0Z83+s5F949dSFdFMsSdGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fXys8XYv; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7a9cf7d3f3so120227866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 06:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724333214; x=1724938014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/sTIhS9Xw4BDPOQB2/gkPZMsu+IQ4A0gbxPA3JWu3jQ=;
        b=fXys8XYv4hQZOPhsxzu1D5eWtiz21j0GVw5aD5yRGlKL3TJrisfjN/hK4IuW7TDJaK
         Gpej2osy7or6PMEHcGvbqUOJBlBh/VmcEmuvMUrMafVUr7OI/e9DSjMWZqZ9J0MQ5IKD
         m2Ht20+Es3m7beNAP3xbeUGcWYqov9/N2nA7rot3dlNa6QgAlSNXhffSjDLxnXfqnb6P
         DxAd37XsVcVUScsKqncxLSgZgWmWUsk/Tv2raFOZvxTZgwf2njlJ8N03ZAS0kBHGccbe
         wR73yva4HEx/MGv4kAZ2LvEKeWgRGnx3zcj4O4MSpAFjN/spmugffe0SLS/TolzE0XBj
         heYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724333214; x=1724938014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/sTIhS9Xw4BDPOQB2/gkPZMsu+IQ4A0gbxPA3JWu3jQ=;
        b=q+IBj3dEjLBhSEOSqZw0vh7rRSD2/CYmvIgUJH/sPDmClnCkN7cYn6MZz+t6MkgP8o
         aRIGRsytJ4qH65kukrhmQzCLGuS1lI2QLEJ6cx5EBI+5yuXG3xCr0jEc7c5y415B8IsE
         tB0CuQ8yCAfL8Q+J0j/9AQ8Z/12h60c/2uJdWibQxGFwGrlmkpEbZZw/IHLcYWm/1VeI
         edq/z+042YitrQf5ZooOmTlBZNrNeXfQnisY6N7PLlORB431DBJ9Ls/po//vY+T+MTUi
         QZiK8xaUhO5VB7phFCaNZeBNvMFHN7Rns/fATHSix5BVput/XZYqmqjaRAry09toqCLM
         ZCGg==
X-Forwarded-Encrypted: i=1; AJvYcCU2F3lA3IQZz3VZmayZCUeuWkzKG+qg+RCrv0WeBhIrzQL0NOWsQA9+TTRDKrRNw1FuPPcR1FS1fcp/+nY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx78UlUfNm3mOMFkE9WmPa7Ti9Edf4Q8VhljsWKFetieull7mgW
	VLCF+9UE2eYr1/edNhnngXLGFzYkIRWd6U2eoY0eiOr/yIQEq1Gc2pF/RzXNwOM=
X-Google-Smtp-Source: AGHT+IHjm7Q+JoZgcM2Zph/tZNRKj+q2DW0doo5EcFiHyW+jdSlZaqVjNw0PmuMr+kvtWO0dxJNqxw==
X-Received: by 2002:a17:907:d3c7:b0:a7a:ab1a:2d64 with SMTP id a640c23a62f3a-a866f9d2811mr428685466b.58.1724333213916;
        Thu, 22 Aug 2024 06:26:53 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4365a9sm119497766b.125.2024.08.22.06.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 06:26:53 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: irogers@google.com,
	linux-perf-users@vger.kernel.org
Cc: James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Colin Ian King <colin.i.king@gmail.com>,
	Yang Jihong <yangjihong@bytedance.com>,
	Ze Gao <zegao2021@gmail.com>,
	Yunseong Kim <yskelg@gmail.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/7] perf evsel x86: Make evsel__has_perf_metrics work for legacy events
Date: Thu, 22 Aug 2024 14:24:48 +0100
Message-Id: <20240822132506.1468090-5-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822132506.1468090-1-james.clark@linaro.org>
References: <20240822132506.1468090-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ian Rogers <irogers@google.com>

Use PMU interface to better detect core PMU for legacy events. Look
for slots event on core PMU if it is appropriate for the event.

Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/x86/util/evsel.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
index 090d0f371891..1eaae8819c5e 100644
--- a/tools/perf/arch/x86/util/evsel.c
+++ b/tools/perf/arch/x86/util/evsel.c
@@ -21,7 +21,8 @@ void arch_evsel__set_sample_weight(struct evsel *evsel)
 /* Check whether the evsel's PMU supports the perf metrics */
 bool evsel__sys_has_perf_metrics(const struct evsel *evsel)
 {
-	const char *pmu_name = evsel->pmu_name ? evsel->pmu_name : "cpu";
+	struct perf_pmu *pmu;
+	u32 type = evsel->core.attr.type;
 
 	/*
 	 * The PERF_TYPE_RAW type is the core PMU type, e.g., "cpu" PMU
@@ -31,11 +32,31 @@ bool evsel__sys_has_perf_metrics(const struct evsel *evsel)
 	 * Checking both the PERF_TYPE_RAW type and the slots event
 	 * should be good enough to detect the perf metrics feature.
 	 */
-	if ((evsel->core.attr.type == PERF_TYPE_RAW) &&
-	    perf_pmus__have_event(pmu_name, "slots"))
-		return true;
+again:
+	switch (type) {
+	case PERF_TYPE_HARDWARE:
+	case PERF_TYPE_HW_CACHE:
+		type = evsel->core.attr.config >> PERF_PMU_TYPE_SHIFT;
+		if (type)
+			goto again;
+		break;
+	case PERF_TYPE_RAW:
+		break;
+	default:
+		return false;
+	}
+
+	pmu = evsel->pmu;
+	if (pmu == &perf_pmu__fake)
+		pmu = NULL;
 
-	return false;
+	if (!pmu) {
+		while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+			if (pmu->type == PERF_TYPE_RAW)
+				break;
+		}
+	}
+	return pmu && perf_pmu__have_event(pmu, "slots");
 }
 
 bool arch_evsel__must_be_in_group(const struct evsel *evsel)
-- 
2.34.1


