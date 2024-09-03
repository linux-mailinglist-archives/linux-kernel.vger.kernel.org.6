Return-Path: <linux-kernel+bounces-312700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9F3969A06
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0A951F23DB1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45C11AD277;
	Tue,  3 Sep 2024 10:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L9GCn0gU"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693101A0BD1
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 10:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725358891; cv=none; b=lnfKtnt1MgGKh70+EmNnKXWd8hK70X7gf4xUn9MF9o6+nSTHUcQMpgSWpjzyZvJPnVjUmcaaMDuzkXoBlYOoKTT3XCbDo3ZezMgpv1c2IiP3NC3FsbBD2tfeYUaxixx6pUJzgNXo6S0TNWQvheXgdvZIb1GX/SGeZil90Qthz1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725358891; c=relaxed/simple;
	bh=R1rW+JeCliU9jErQ2ls0dfEKB+GTh0fwrinuUyPU/Gw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iq5CVZ1RMPXfLy31F4mvC5Y+KqX+QG2sQuovDykJsWrZEFQPRv/L5i8KIIEdjLa5rvkk6d59XSwerESQbD5Sp2Ag3Go9L890ZtGJMAE/yKKf+itagca9BBv90OzbuYMQsnDtt2Z1moir1nea5DH0akacETH6ZvEGEorVjaeplro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L9GCn0gU; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42bbffe38e6so27254125e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 03:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725358888; x=1725963688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/sTIhS9Xw4BDPOQB2/gkPZMsu+IQ4A0gbxPA3JWu3jQ=;
        b=L9GCn0gUWwLQA+QfS87oBkg7/MQYMPFMPkx3zuksVNKx3PCpkZ2rlgrtlmTrf8ObVy
         E/Cn9yl3rMmhQ1p4ZpCZI0PBZ1ClPlK++TpC4ocRcqlxjARB4Pnyb/HbTqTLJvEVktkr
         zhaHKMcweplRw55k8fbO1e2nW2Ubao2DkudJ+gv0sVOrI+1OsCsEXiU+AKwo1CA/Ly7P
         xD3h/q6JHJek/w0ZaCEChLS1So1ivqW4MTuvm88Ept5iR6g5M1pkmUBUrYIgMWxUrbq1
         pV+R3CsSAWshDTMdSqD1mc+4VBQQl3yxYdhIdCb4+s9LGcpDOsLnO9U1B/dBSorAYrwM
         U9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725358888; x=1725963688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/sTIhS9Xw4BDPOQB2/gkPZMsu+IQ4A0gbxPA3JWu3jQ=;
        b=cpdds+iAlcTD6LTpgcpAFy0x8j9z3qvpd7Zy8dkW9lFS7zyxMNn6FbAlHsO+3pnlEg
         ouucYFp8k/DUJomqxpLWVadEEeV8SRtgBbjnGnr1bkZLAx5Ue8tEPt9f9SmzY5g3nXr4
         DI/n0IN4BjnGe2eCeaeEpWoqXGjjayz/flDUIO2Hb1BZhWQkpBwkJ80ge8WdGOj2GW35
         XbrrOB0FEmNMQdAYg/+tZaqTClI1N0IXpyflLnLVfAe54nJTCcoJen8gtqYMx4ahHvAD
         BwdHN4fxjFPAZDPXz/xVIbSDvO+A6WK1Pq4ctyiX65LVA0tZQ1cCR7xs6m4NdOdRtma9
         xGjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhj8C18TXD6J2J1s4Tsy6Lio+XabTRy791YRJ24GuvSwYPfYiXycFyzjsWYm8BeIhZsHWAIn+XJBQd6E0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/WUytpQUdYpKfnGooU8tS5lX5TmAhxAsNQKEP/Iub+fPDyOZM
	Rb7QQO3KksqRFbAcrV49AQFoWuV/zSOiC/i8bH0K8DOOVvTKkcz/ov1xlR7s7Z4=
X-Google-Smtp-Source: AGHT+IG/0epOuRWCHiAJ1l6a7W+fQwq6asFnurcKDboZ9mI63Fa4LwFeUnVbm8GzqO8eC/s+nQeayA==
X-Received: by 2002:a05:600c:444c:b0:427:ff3b:7a20 with SMTP id 5b1f17b1804b1-42bb27a9c9dmr134456525e9.27.1725358887488;
        Tue, 03 Sep 2024 03:21:27 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e274ccsm168739995e9.37.2024.09.03.03.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 03:21:27 -0700 (PDT)
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
	Colin Ian King <colin.i.king@gmail.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Yang Jihong <yangjihong@bytedance.com>,
	Howard Chu <howardchu95@gmail.com>,
	Ze Gao <zegao2021@gmail.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/7] perf evsel x86: Make evsel__has_perf_metrics work for legacy events
Date: Tue,  3 Sep 2024 11:19:48 +0100
Message-Id: <20240903102005.78049-5-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903102005.78049-1-james.clark@linaro.org>
References: <20240903102005.78049-1-james.clark@linaro.org>
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


