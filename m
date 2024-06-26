Return-Path: <linux-kernel+bounces-231504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E1F91994D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA6B228579B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA611990A7;
	Wed, 26 Jun 2024 20:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QULJJBHk"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A0D198E89
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 20:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434263; cv=none; b=ObClr/TBj10N4m422/VYL+ecqlW2ypOCT6pSgWmOtv7FWPC8IrO8PMkWxdsdE4dyU4CBdyFTdyoWvF24XdVlRCjS/SLj9RfowauKdPXp+Hoq0Y306ByE55J4CL+QvkjZhvnzIswIBvsd3K0CnbgTtWiMn//wJ1zizGqrAVDlwsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434263; c=relaxed/simple;
	bh=WN7MjOnN4Zn7pg1cZh55iymkjdS8QmRhMBO2woXN7eA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=P38HWuy3ZLVv675T6xrMjWsfFo3Ebwiim/UB/N/ds/K3C02AXLHFzfz2L+MnqpUwbLxKFvi5YQs8CWFqCdP2ow1fAL8l0FnQNQ2jNEWZni/W63LDSW5niPlRu4MZU/IPeAHdTbxuu6euedLODTxmkrffVuAVeHmB8rwAFvCBcNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QULJJBHk; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-645eb1025b5so59921467b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719434261; x=1720039061; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TdTCsJGRcQ5KEDk5K6+n46WGlbR1BvI2wSbaM6Bk56E=;
        b=QULJJBHkDX5WsV8ubLs+wTMlFoxiKrexTI9oK9IS0NC7JmoFBdvdDq/1qkysx2QHwi
         HICpQF286F8bQu5uItbEguI7UX1QE+2vBdDvIEohC/kDsJnDuJDRVZdgb6sARJAzFQqF
         25+J6rXDbGOR+Vng3SSxQfc3yZkKKd1UD1EQVUX/IgorYiZEnieZNSPUIGMKG9z7Q7Kc
         ZRkGx/gbVihHv8BQ1Il/Ne/CH+lZIovck/O420rEvZzb3Uk1orH4t/iA/HVavsk6pBa/
         weAKrpr3tEiWW3WTFjYdbvwDnNxmITxuuEweNGXyeYxuL5c06Ed8qnY0GAU7eM5q/RDE
         VyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719434261; x=1720039061;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TdTCsJGRcQ5KEDk5K6+n46WGlbR1BvI2wSbaM6Bk56E=;
        b=QE691A0oE6/+MjSqe8geTT+VXoU7zRzpmq3zFZeJYRmi/LIGiMWRg+xyNRsPe1fpev
         oqs19AVqbMxHn0J/M7SOY0z1zKt5pHCG4Si3Hxa4J1OGnvCE7M4+vWsFDbUE5lTJSRzN
         z9b/b3GmEpNTEiqNHYeD2OL3O87CtheE4YhIRNAPI7f5GtIIAT1DOxwswq8B0eE7ZMDr
         rnqtamtE1PbQnkMOIrkfk0qGZ8L9Ee7UfGwZFLISDGXFat1Aufz1aOxFjkmDKqlhJtnI
         KpfY/tqdJ39QT7MiNAzyPOpmviv7QTVGaMMPlFWnWPDVyg8/fYnvf3FdQBq3UsYBsm2B
         qk1w==
X-Forwarded-Encrypted: i=1; AJvYcCW2OPQLODewHg+G4u2O3KB5YD6fCHxB8svMTuyz6vsU2zOqlHd2ADI4tI7QAWUSDGVAkddQwCPFOBQbJKBjflkl+AAnrHNK9WhfbE3M
X-Gm-Message-State: AOJu0YzmM0n1ur0LHDle6Y3yvo/rAUFizwqFhVKUjLHvSRJ0X1ck2u3B
	Lh94JpuZR41LvUuUa0sPFA9cNH+WelVQKeHgsqifCwv2XsH8zkhPAd4LzGbGRZb21R35QIX6lmG
	BoYaeOw==
X-Google-Smtp-Source: AGHT+IE+TDz0MPCw4fRNjRKEoyr8gpWQlS/FQAQd2Prpi+y2iXax3OXpq7lnsmlMd3V1IIbrXOEA+LsN4GLm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:23a1:25b9:2412:56de])
 (user=irogers job=sendgmr) by 2002:a05:690c:3506:b0:61b:e103:804d with SMTP
 id 00721157ae682-645e60af794mr287967b3.0.1719434261135; Wed, 26 Jun 2024
 13:37:41 -0700 (PDT)
Date: Wed, 26 Jun 2024 13:36:29 -0700
In-Reply-To: <20240626203630.1194748-1-irogers@google.com>
Message-Id: <20240626203630.1194748-28-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626203630.1194748-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v2 27/27] perf session: Constify tool
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Make tool const now that all uses are const and
perf_tool__fill_defaults won't be used. The aim is to better capture
that sessions don't mutate tools.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/session.c | 6 +++---
 tools/perf/util/session.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 54f0ba9b065b..f07ac6dd6762 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1741,7 +1741,7 @@ static int __perf_session__process_decomp_events(struct perf_session *session);
 static int __perf_session__process_pipe_events(struct perf_session *session)
 {
 	struct ordered_events *oe = &session->ordered_events;
-	struct perf_tool *tool = session->tool;
+	const struct perf_tool *tool = session->tool;
 	union perf_event *event;
 	uint32_t size, cur_size = 0;
 	void *buf = NULL;
@@ -2153,7 +2153,7 @@ static int __perf_session__process_events(struct perf_session *session)
 		.in_place_update = session->data->in_place_update,
 	};
 	struct ordered_events *oe = &session->ordered_events;
-	struct perf_tool *tool = session->tool;
+	const struct perf_tool *tool = session->tool;
 	struct ui_progress prog;
 	int err;
 
@@ -2203,7 +2203,7 @@ static int __perf_session__process_events(struct perf_session *session)
 static int __perf_session__process_dir_events(struct perf_session *session)
 {
 	struct perf_data *data = session->data;
-	struct perf_tool *tool = session->tool;
+	const struct perf_tool *tool = session->tool;
 	int i, ret, readers, nr_readers;
 	struct ui_progress prog;
 	u64 total_size = perf_data__size(session->data);
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index 9c9c531052fd..067429d882f4 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -43,7 +43,7 @@ struct perf_session {
 	u64			one_mmap_offset;
 	struct ordered_events	ordered_events;
 	struct perf_data	*data;
-	struct perf_tool	*tool;
+	const struct perf_tool	*tool;
 	u64			bytes_transferred;
 	u64			bytes_compressed;
 	struct zstd_data	zstd_data;
-- 
2.45.2.741.gdbec12cfda-goog


