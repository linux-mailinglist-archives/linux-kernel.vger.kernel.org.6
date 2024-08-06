Return-Path: <linux-kernel+bounces-276860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CD494994A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92A311F22629
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF91F15ECED;
	Tue,  6 Aug 2024 20:41:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A18014EC44
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 20:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722976910; cv=none; b=lgQxxVjBApmj5b2PjfI5hMGz11HpVw14caIYnqo0Nt06l4JPexcZnY3ZNndD+dfcFQYtl5sgPiYHV8ZjujCBpx4ub1d8eJRdXD7vHJVV5gV4e6KWGgBUNiTP933kybfKSu/9HrDV2LYKSZ41b4HxYnE0jObzAs01N9mrP0w4SKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722976910; c=relaxed/simple;
	bh=niPuiLHg6vRs8AsgEV9YT2aZx38TJq1qSTOWx4c3pv4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MbAZ/Y2D03cNN02YRil8jb1Hu1t7yp7/p54zEzlLQfZGnSiMqYV6wpiG723TznRAcJh7sJ3ve/fLkDb4H9PSBxxyn0vFfCxHIeimDVaVYJc2GFZxuhsxFyEjX0nT5uX61cPOOmpwsZYnESrTeQUgZrlw8jLxXpp53+iaIQyso0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 762621063;
	Tue,  6 Aug 2024 13:42:13 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D08DA3F766;
	Tue,  6 Aug 2024 13:41:45 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Liang, Kan" <kan.liang@linux.intel.com>
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 1/9] perf auxtrace: Use evsel__is_aux_event() for checking AUX event
Date: Tue,  6 Aug 2024 21:41:22 +0100
Message-Id: <20240806204130.720977-2-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806204130.720977-1-leo.yan@arm.com>
References: <20240806204130.720977-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use evsel__is_aux_event() to decide if an event is a AUX event, this is
a refactoring to replace comparing the PMU type.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/auxtrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index e2f317063eec..c3f0ef4349fc 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -671,11 +671,11 @@ int auxtrace_record__read_finish(struct auxtrace_record *itr, int idx)
 {
 	struct evsel *evsel;
 
-	if (!itr->evlist || !itr->pmu)
+	if (!itr->evlist)
 		return -EINVAL;
 
 	evlist__for_each_entry(itr->evlist, evsel) {
-		if (evsel->core.attr.type == itr->pmu->type) {
+		if (evsel__is_aux_event(evsel)) {
 			if (evsel->disabled)
 				return 0;
 			return evlist__enable_event_idx(itr->evlist, evsel, idx);
-- 
2.34.1


