Return-Path: <linux-kernel+bounces-175297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F28188C1DC1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 07:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE1242840D1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 05:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADFA1635A9;
	Fri, 10 May 2024 05:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4JTSuiMJ"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592ED16132C
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 05:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715319495; cv=none; b=Njs66bkcnEluwblu0Pl61wWkRfLMQyo9IB/02f6ZHSN74gMbbo3WI0GPSsDn3akih52XO1IeSCadWk3873qPLw2mjYP6PJGJ/x97KRaFrpW7Kt3GlsW/b5UVyJ/7sXZalMQmZtZggKP1OfBDXOYzf5/v/rFTfv+DA4kghmEVMw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715319495; c=relaxed/simple;
	bh=vw95n4rn5vnmJbH7gGbwuIcX3seEX/vyVpcGLsRC0No=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=JAlgD+IwZpgGUBhn9z+fqVMWr//t93aV5mdCIbT3PCKror7ikdIq34QLdiWuxv1vnnKmCPRpOYi5MlF5gDk59RqTH18P1RJgGOS9E+rbsF++4GtS5Ve8EbA6H2rFblDnpCRbV5Ja1ryN8Z0a8Vt7gzGETWXqefHsDFNHCNfbnIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4JTSuiMJ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be621bd84so27318457b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 22:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715319493; x=1715924293; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z8mUHoTTwTNDR6VMgnmgQcaPuyAY5QRbZWhXDi0dIfE=;
        b=4JTSuiMJLVY8bHFBZZoTCM9E7syHvTDgq9MDftf/n+P0XVdFSuWNdonxzacEkOVNd6
         ZDQlROgcvIvxPm/FTqUbBsEOsaDJqGr5ytD5b7kYWo0xoGGcLMtr9hi29pjQVRYCnJH2
         In27JKn3VZAAbo0Plw8dfBOT/GBKJUPHcKG3DtMqU1Ass+e4Rn15CY08JibAPTGIgLHj
         OBSMS5ElcN9NyuQ/fPoc+4oh5/2jwBO+4J/HpjnexnBBxUCLLjgErC6/Uho/7QJRWKI8
         HR4DnN9+xKXND0xa8Dx21iKz/B+sfQRRu1lYpCZX5kAmxkakTpnybl8/suD35MgAGfc3
         AVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715319493; x=1715924293;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z8mUHoTTwTNDR6VMgnmgQcaPuyAY5QRbZWhXDi0dIfE=;
        b=VGBp7FCi1MSueG0mabjMiRpc/i34ahBi3p97i1AXsHg1H93/3GUhY5fGKyg4Du8uyp
         RDN5jKScRQFFZhdl5KL1DknwJyBLgga6JobK8KfcNck16zjoGJhErdJ96Xn2yymnsi4u
         V6k7DNsG8+XlxbwC17hss4yUEEV75G00oyaQNgpE6eWoULFWW/aOGDU2TTHw8arWvg62
         x7ElO0crpDVTVHZBlIqHzfQ4MxJP5wruXcIJtCOOGNsFH1yvSQ7QKtR6qiw32HLJa3WX
         5YyDrC9C6pBSqKa+nxYPH9/1f85OI44t2VT41iI+wbTUrm2EV9Vf6JXx7QuHYnUPeLhl
         MG6A==
X-Forwarded-Encrypted: i=1; AJvYcCV/ZPRCSZCdbjyLVkYQXgi13q/7NIuHJnzl3V9yNXZf8PhwFpEebJvyTjwG+w0+IYsfdvI/Dhu9zFBYXUMR6TQfsxTGN0V5pLDkK9Ui
X-Gm-Message-State: AOJu0YxS9zom4X1GRWVklTzHFk8Xp9B6uvKbfNU102BqjvaaEsHwsf1T
	L9etVnQoS1pvg3n+RLLjpaxMF9IwUmXIalCosYqXYyxb1ZI4WSAOYki2VngpFtHIrQmnUJzaeHb
	4/Iy4RQ==
X-Google-Smtp-Source: AGHT+IEuORGK6XeqhS3knqXzuXQaKfa5sKPSvjks/Ef2jBveYaz1Jn8BtFQlW24dzkX+bRKresX4hrFHlWLd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:79ed:c375:51e3:ed39])
 (user=irogers job=sendgmr) by 2002:a05:690c:6010:b0:618:876d:b87d with SMTP
 id 00721157ae682-622b013431emr3642737b3.5.1715319493366; Thu, 09 May 2024
 22:38:13 -0700 (PDT)
Date: Thu,  9 May 2024 22:37:04 -0700
In-Reply-To: <20240510053705.2462258-1-irogers@google.com>
Message-Id: <20240510053705.2462258-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510053705.2462258-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Subject: [PATCH v3 4/5] perf evsel x86: Make evsel__has_perf_metrics work for
 legacy events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	James Clark <james.clark@arm.com>, Yang Jihong <yangjihong@bytedance.com>, 
	Ze Gao <zegao2021@gmail.com>, Leo Yan <leo.yan@linux.dev>, Song Liu <song@kernel.org>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Kaige Ye <ye@kaige.org>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Use PMU interface to better detect core PMU for legacy events. Look
for slots event on core PMU if it is appropriate for the event.

Signed-off-by: Ian Rogers <irogers@google.com>
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
2.45.0.118.g7fe29c98d7-goog


