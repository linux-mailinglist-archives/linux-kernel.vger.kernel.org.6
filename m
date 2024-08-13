Return-Path: <linux-kernel+bounces-284887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F69B950667
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF17E284DC4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACAB19CCEA;
	Tue, 13 Aug 2024 13:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mYby9Qpk"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE80919CD01
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 13:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723555523; cv=none; b=Le2Zw9ct9J5GRCrDaPe0nCBFJZeVVB9Ko2ejA/FVnWIFGUH66Cd2IzNxqbduLBhtE3W53OAc8VmZS80eV9pxYFWNLAtdA30MYiLswL/7Vtp15Wn+DV9/FPd08W3RxrHJkAcxSfdUDwAneW6SiAo6yuAZ53sRcfetey2OITEL/oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723555523; c=relaxed/simple;
	bh=IC7oNtwGUsqvqbC9/FQ9oTqKSh9dIXp8Un6RDjHG7os=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BBrRCJ1dPPfjNm83R82DMVz/qEi+dBpc24IrJG8D1BzQC0H1nEEw4m4JUGsRvtlkYQnT+XRsAYqRFwrB99X2LtDbnJdS+bJvZlb7is/zYuqxYI116hsP2s7MM9Lkwf7Kr4Suv5s7s4ys0WkwHb1+nOynnE0oBnf9dRBH9W3Id+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mYby9Qpk; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42808071810so41616355e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 06:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723555520; x=1724160320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zR7iuyHffj9f//oCwmpY+WujZl20YxAEXMdQ/mInORg=;
        b=mYby9QpkdlCVbT27IIehhm5b2994znQvpNqq7ceWWXLIRq/NEp4XONMrv1n0TAZzKN
         am8PHLSIn6kzrR7mfLsE1Pk6wcdHwA0zliJSc5GnmzROyc2GnRvuX1Jaoo+TpPamKFiu
         reDaTHKpPrYvN84QoRKlyEtsE6fz0SahGFXdM8XqTPdvCcaPnzg9PTwQq5jV9NZgbK/D
         eiC5XLmZpc481LSMw3TBwgnwWPrvCVEmSlKj56eRhVEEB/4OXFZ4spPx2bm2WD9fihaP
         SSNrwIceOGAsI9jQBuWiLC0zzV02Nm09s/Wd6EzxTi+sWSVntf+dF/9fXmM6Rv+YBH9U
         lmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723555520; x=1724160320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zR7iuyHffj9f//oCwmpY+WujZl20YxAEXMdQ/mInORg=;
        b=ccYx9ri1p8tqRHDlsH2n1G6qi8P3EOwhNKcm02F0S1IkmTyZZ/LBjVLAsbykSWB9uF
         UII8YsBqEfuQYS10hevJqDuKLDKmfLkF7QynBWp+g1SGaX5BSwTWYPVGVLAmNnw7oM6l
         V9RpM7rXNDJjcC0W8cctjBlV4Bw52+4oH4sYBSiwrNGhVenTW2XAbLFx7vNTojot/dAT
         fuqF0JJvyitwaZV26H5+5tZoCGQlYuLdbHrIegXJMb2vlwIWai4jPS4Bbn2zE9+em5ah
         0C1OZldApUiGvjnvnlSvcaO54jRO8obfhWo213meFReuEOQ5FWAirwADZCOpcuU2+c2z
         yxJg==
X-Forwarded-Encrypted: i=1; AJvYcCX1hFhm8S+0Zzc3R7iTXJ7d29JoN8M3nt7Wpz3cNgdWC/zxcVq0AE79TmTqz2BFy0pTj3gZoO1fRldAZ0FYnNGu0CtFJR2USdTx5UAq
X-Gm-Message-State: AOJu0Yz8BTJMb8SKZP5gjKSiM3zWc6hUfGVsoGyslChH6jafPscKmZ2n
	ExCChkNTfLKS2kBvfpELQztbbaKFoYGFv1XkhLbSdSvNZQJ/j2hKj6ZzNDwWVds=
X-Google-Smtp-Source: AGHT+IE4O1HeOB7Ir8sD2A/JqXloTOsBz328BQAjDg9uiSlJQr+ktC91pK7XIkyLaypNjbj27p76ag==
X-Received: by 2002:a05:600c:548b:b0:427:ff3b:7a20 with SMTP id 5b1f17b1804b1-429d486fea7mr30226825e9.27.1723555520303;
        Tue, 13 Aug 2024 06:25:20 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c738d21sm223186625e9.12.2024.08.13.06.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 06:25:20 -0700 (PDT)
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
	Yang Jihong <yangjihong1@huawei.com>,
	Ze Gao <zegao2021@gmail.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/7] perf evsel: Remove duplicated __evsel__hw_name() code
Date: Tue, 13 Aug 2024 14:23:12 +0100
Message-Id: <20240813132323.98728-5-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813132323.98728-1-james.clark@linaro.org>
References: <20240813132323.98728-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__evsel__hw_name() does the same thing so use it instead.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/evsel.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 19f4d0e71733..ba960a39f104 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -592,12 +592,7 @@ int evsel__hw_name_ext_type_id(struct evsel *evsel, char *bf, size_t size)
 {
 	u64 event = evsel->core.attr.config & PERF_HW_EVENT_MASK;
 	u64 pmu = evsel->core.attr.config >> PERF_PMU_TYPE_SHIFT;
-	const char *event_name;
-
-	if (event < PERF_COUNT_HW_MAX && evsel__hw_names[event])
-		event_name = evsel__hw_names[event];
-	else
-		event_name = "unknown-hardware";
+	const char *event_name = __evsel__hw_name(event);
 
 	/* The PMU type is not required for the non-hybrid platform. */
 	if (!pmu)
-- 
2.34.1


