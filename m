Return-Path: <linux-kernel+bounces-339216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3F898616C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D305283375
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FCA185B42;
	Wed, 25 Sep 2024 14:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XoC+1Zcz"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC4618594A
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 14:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727273748; cv=none; b=nbLJiYKbESoRqC0znUU/deXOEVSWB9N+Rxi9WTqdb6pPIlJZc7tqjnFg0Rhx1JZ+CQeH6fcEWw9IiRHBfDb8UZrKXg161ctFocGf+kGgcQc5nwXELLY/CaQbJsjckD/6CnTz9vxd1OFSqaFTROLSJz0zomR0HeN/Tz1OXNy7e3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727273748; c=relaxed/simple;
	bh=tQFIl9HVxgRMLxLWuqXaYBHbN0KDyK3jUQQRNUEuuZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pp1/L5atK5HSV8+zEaB5nPMRv2u3u285317sAivKwelkzIl2f4wYCcZ6wNSRxvgq3Ogo8eOat7asAKmhAzZLdeK208Jjpv6KwcU4lg1LvBkmrSnGGaB+nGu/5386rYUkzysYjasV/Ta3KY55qAHcHArUrMhQEJ9Z66+hnjAH6a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XoC+1Zcz; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c5b6161022so6752075a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 07:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727273745; x=1727878545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbrFzlrnUu+8X/JET7kR2akCW+mI8AJmFw0wQB6l0Uw=;
        b=XoC+1ZczM6mkYnoN26f9c9K5Jr39Vm5iC+IvxSIwDrPJBJ5jh/uCClrrRWBGKB9wXW
         OZtqfbPPTOKaCKp2jMfqwH1dO8bTp4FiVCYeMDHr5oLvB6CSOkIpVNFNWL1lRYIdVedc
         LbWs2WogizadA0i2iEKOH6F3lulwZOHV9c00HzqLqi+LPDwErEgeq82r6kuvHzV70Fr7
         uAKUWOkbA4B2e7VfwaisC/aj/foOfhIjTHSG1fVfLCI4O0t9SpM2gJ0sPMMHGzfVDaYd
         6Qd5/i1VrD18Wxy+VfcPjYkbUDpl8FwJlPFWojkdTyW7IVYcLawg0HOHkfjGKdjWO415
         SHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727273745; x=1727878545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hbrFzlrnUu+8X/JET7kR2akCW+mI8AJmFw0wQB6l0Uw=;
        b=XklPgUnI4b4xV683nNdRtvhF0NGUbdiFWxs1LXSfXKKonn1GQysXv9hpkUYRTWLKUh
         eRAJUTOyKn3QSXFe9tRU1cH3xz10ouJc08JbgCs1q5wkUZHZ6XcWYaKl1oaeYgJ1dmum
         Ui9e3+sY7EJp3Gwsc7RS6MP4ube2Hw/YL08fKIncN0N4jQ/mfr+TYTuNG0Y2R3MMuRZU
         6TXuuTQRsAHJ6/yMkM8U9ahsKm+XPcDsW6TX8t0QksIHiZ4fonSK7/p3dZ56H0ln87mV
         I5n29+q67LWP5pHZpt7+U8QomPNUqAuSHcqu7v1bU8KXEGi6yNDrYFWCT0tswHom3mIN
         YExA==
X-Forwarded-Encrypted: i=1; AJvYcCWDe4ok0JL8qKgFCi2eR+/V8ceV52U57He2qCNMmxFiJw9GL9lC1YX99I4wXjiRZ2k54cZX5VH5ySa2M+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnIF+N+u/Ps7cr7vbciMY4Ev1aGatBNBGUNkTzQgODGoHcpu8J
	VPoCaAazFMRIhB1akyCdmJ5zx0KuKa6MhPVEPZTWD/g/Mr8ll4GgPp4X7N+3dQ8=
X-Google-Smtp-Source: AGHT+IFQn8YnDCsIX7UjafdBPe6+oR3SG2XsFVa/A70LleDb3uEn+exPHpjHzg07dI1HfR4LZuzs7w==
X-Received: by 2002:a05:6402:1e8d:b0:5c2:524b:7711 with SMTP id 4fb4d7f45d1cf-5c72073d459mr2550246a12.33.1727273744720;
        Wed, 25 Sep 2024 07:15:44 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf4968f4sm1888005a12.27.2024.09.25.07.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 07:15:44 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: irogers@google.com,
	linux-perf-users@vger.kernel.org,
	kan.liang@linux.intel.com,
	ak@linux.intel.com,
	namhyung@kernel.org
Cc: James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Yang Li <yang.lee@linux.alibaba.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Yang Jihong <yangjihong@bytedance.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Howard Chu <howardchu95@gmail.com>,
	Ze Gao <zegao2021@gmail.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 4/7] perf evsel x86: Make evsel__has_perf_metrics work for legacy events
Date: Wed, 25 Sep 2024 15:13:42 +0100
Message-Id: <20240925141357.1033087-5-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240925141357.1033087-1-james.clark@linaro.org>
References: <20240925141357.1033087-1-james.clark@linaro.org>
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

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/x86/util/evsel.c | 31 ++++++++++++++++++++++++++-----
 tools/perf/util/pmu.c            |  2 +-
 tools/perf/util/pmu.h            |  1 +
 3 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
index 090d0f371891..4a0229d601d4 100644
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
+	if (perf_pmu__is_fake(pmu))
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
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index e32d601b48f1..8993b5853687 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1168,7 +1168,7 @@ struct perf_pmu *perf_pmu__create_placeholder_core_pmu(struct list_head *core_pm
 	return pmu;
 }
 
-static bool perf_pmu__is_fake(const struct perf_pmu *pmu)
+bool perf_pmu__is_fake(const struct perf_pmu *pmu)
 {
 	return pmu->type == PERF_PMU_TYPE_FAKE;
 }
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index f4271395c374..d352d53b8d55 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -281,5 +281,6 @@ struct perf_pmu *perf_pmu__create_placeholder_core_pmu(struct list_head *core_pm
 void perf_pmu__delete(struct perf_pmu *pmu);
 struct perf_pmu *perf_pmus__find_core_pmu(void);
 const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config);
+bool perf_pmu__is_fake(const struct perf_pmu *pmu);
 
 #endif /* __PMU_H */
-- 
2.34.1


