Return-Path: <linux-kernel+bounces-543994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D62A4DC3E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 860F13B2FD4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643F0202F64;
	Tue,  4 Mar 2025 11:13:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CAB202C52;
	Tue,  4 Mar 2025 11:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741086782; cv=none; b=R72hCOTBsJ38Fjy21HckBTUrB/Wbjy1F8E7DtgFDtPVvXtfon1DKWPAuLCCyFwf6bZeGStEi5sqGqD7+6GUZE1bCYfB5Bt3lS7PQG/IofstRvpUydrwTVLdtjjN+yGEFPqY7N0OcNS9T0gLs7cK/apcwqxguPQgUv5lwmlaL3EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741086782; c=relaxed/simple;
	bh=Qh42oMYFXFD5ggPBjSt+TSYegIwWv0n+N1/9OzrBj5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VOLxGs4zbjJ1xOr6QfDPIxNOWbLpf5VtESCpcSuSAVID5EiZDHJ783/0iNOgthUuvSob3IjcakoPQbecBizoRvvg4RiWDihZpxB/ezMYS+3a+LIHaZaYCBMWr7vFT29blGLqNGCgM4bV9sU6gcWVkJ6B0ekpQx5PrzXe+ZHkpCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B5F91007;
	Tue,  4 Mar 2025 03:13:13 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 813E13F5A1;
	Tue,  4 Mar 2025 03:12:57 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Graham Woodward <graham.woodward@arm.com>,
	Paschalis.Mpeis@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v4 04/12] perf script: Add not taken event for branches
Date: Tue,  4 Mar 2025 11:12:32 +0000
Message-Id: <20250304111240.3378214-5-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250304111240.3378214-1-leo.yan@arm.com>
References: <20250304111240.3378214-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some hardware (e.g., Arm SPE) can trace the not taken event for
branches.  Add a flag for this event and support printing it.

Reviewed-by: Ian Rogers <irogers@google.com>
Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/event.h                 | 6 ++++--
 tools/perf/util/trace-event-scripting.c | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 962fbc1714cf..c7f4b4b841ca 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -67,9 +67,10 @@ enum {
 	PERF_IP_FLAG_INTR_DISABLE	= 1ULL << 13,
 	PERF_IP_FLAG_INTR_TOGGLE	= 1ULL << 14,
 	PERF_IP_FLAG_BRANCH_MISS	= 1ULL << 15,
+	PERF_IP_FLAG_NOT_TAKEN		= 1ULL << 16,
 };
 
-#define PERF_IP_FLAG_CHARS "bcrosyiABExghDtm"
+#define PERF_IP_FLAG_CHARS "bcrosyiABExghDtmn"
 
 #define PERF_ADDITIONAL_STATE_MASK	\
 	(PERF_IP_FLAG_IN_TX |		\
@@ -91,7 +92,8 @@ enum {
 	PERF_IP_FLAG_VMEXIT)
 
 #define PERF_IP_FLAG_BRACH_EVENT_MASK	\
-	PERF_IP_FLAG_BRANCH_MISS
+	(PERF_IP_FLAG_BRANCH_MISS |	\
+	 PERF_IP_FLAG_NOT_TAKEN)
 
 #define PERF_MEM_DATA_SRC_NONE \
 	(PERF_MEM_S(OP, NA) |\
diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
index 55d7e4e612d5..29cc467be14a 100644
--- a/tools/perf/util/trace-event-scripting.c
+++ b/tools/perf/util/trace-event-scripting.c
@@ -317,6 +317,7 @@ static const struct {
 	const char *name;
 } branch_events[] = {
 	{PERF_IP_FLAG_BRANCH_MISS, "miss"},
+	{PERF_IP_FLAG_NOT_TAKEN, "not_taken"},
 	{0, NULL}
 };
 
-- 
2.34.1


