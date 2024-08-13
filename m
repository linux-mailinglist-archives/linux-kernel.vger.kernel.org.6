Return-Path: <linux-kernel+bounces-284884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6942950664
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 050951C225D6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6D319CD02;
	Tue, 13 Aug 2024 13:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MDfVY8Y0"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C0319B5A3
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 13:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723555498; cv=none; b=LuN38+5GgtACpIHpi60rAzZMFCz/TYUppanlNVUEclIG5Up6ZdPr/xdKqT5Ag56p+DFG0QA0d3EHQGSPK+aMAyJxL9BTLz3m7+IaDpRRjNwwCSEd6PVKZniI9NWS7IorAfc0514tFk2eAfYucwpYi5WO63+JYNH9R1oPiosT268=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723555498; c=relaxed/simple;
	bh=169AxUGyTxrsEVYe8bfX3XyoWe92S2PZ842YmAzlLUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IZMHwbeiGL/ykWYpPNnzYUlgqEpXepPvu056gDw8sMMOIXieMVfhALH4pqJivU45UCqBRSHHrmHIsnUW50BTZ++2u/U4p08jNWTmPs40suHXldN2HmtVBMGkC87owWi5lN8opzhmG4agoGCBQ8zNxPlLQO9EA7mnVzI0shQiwZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MDfVY8Y0; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42817bee9e8so41151795e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 06:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723555495; x=1724160295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8nva4x7yooIvcMdEZLd+2R1OWdlEwTPtLBsl8/711k=;
        b=MDfVY8Y0MrmEwRBDochpJdUq/lEnlnyW05js9JdOowF6g3qGhCqwzLAP3N7pdqi8h+
         Q7/WeZWZ81sqn+jS0v3zM/7LbM11eNHc34Eh1M6VFFhVfjmWY0rsnA6wdNxPTZdgkBV+
         uF4AVjP9WkUjjxkqnZrh0XxQwiE6jLDvj3GH3zuojG4YiB1Jki42eB8DD2gYinED8dHp
         1sRhdGu3dIKfZ7TcA+8sUlNhxlXxeFQHAUQgfrIAQTwbp9IJ5mAFViPtITT06eZG2zv3
         DPEiHNoPUHDxIgM/iA3H0NXN0/O/R2SszD6o3Go3wuw2x65VS4zWnofdNnCQzxdk1PiZ
         kvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723555495; x=1724160295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G8nva4x7yooIvcMdEZLd+2R1OWdlEwTPtLBsl8/711k=;
        b=t/OB9JTiYfrpchbrovJPL3EB6sfFOVDNA8Qaz24M+AeTwxlboPBDvGTRzI5URyKFUW
         znq4CoL0cv4IRdl9nS9MCHrJPG0OCxfB7fJPlREc/keu8bgAsq26Hg2JGb8KoXv+G0Vq
         ptF5n17Hjmu0paPW8CgO74zsIKMInD3Nz1jCCTjRk716jb+pjLDuD8+3swOGJ18hlqyZ
         1aXQB9CHyEb4S2DSKXB8Agb20hitk6Ev50AQWje9N7/ST+1ymYo+ACETshw5cbcVF3GH
         LhFAem/FaJ0MxAJf2lRYI4FZwHnTMUoY/lIzg6p6/9vLI3OzFm3bfCC3b29PG23IJAXT
         diEA==
X-Forwarded-Encrypted: i=1; AJvYcCULgvWBzgzK8+rp9S9+6Mje/513N9vvl88e4UirZvuewbXHNNDPHqzWMTzhhhGzQ2d6WHhc7MUqUe0S6517eIRfbEm0XrI9tW9Ujl9h
X-Gm-Message-State: AOJu0Yyn2w3FvJ7xViz8WtF/OiehT1gGWYdBN+YNHZvZMTnEI4v/mqMi
	+M5c1aeN9XIyA1IYi97HtaKrc7tfw16vvScO/WTp4IBH8BR+YG9/dC+lXi3vwOU=
X-Google-Smtp-Source: AGHT+IEB1qfIIkAEbIEcPEEgKpvjsK/gwklipRfgBKtNp6pSHRtCu9iLJZf0fYv5sQNz+N8Z4iTFNA==
X-Received: by 2002:a05:600c:3b07:b0:429:994:41a2 with SMTP id 5b1f17b1804b1-429d47f19f2mr27005205e9.7.1723555494826;
        Tue, 13 Aug 2024 06:24:54 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c738d21sm223186625e9.12.2024.08.13.06.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 06:24:54 -0700 (PDT)
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
Subject: [PATCH 1/7] perf stat: Initialize instead of overwriting clock event
Date: Tue, 13 Aug 2024 14:23:09 +0100
Message-Id: <20240813132323.98728-2-james.clark@linaro.org>
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

This overwrite relies on the clock event remaining at index 0 and is
quite a way down from where the array is initialized, making it easy to
miss. Just initialize it with the correct clock event to begin with.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/builtin-stat.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 1f92445f7480..a65f58f8783f 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1817,7 +1817,9 @@ static int add_default_attributes(void)
 {
 	struct perf_event_attr default_attrs0[] = {
 
-  { .type = PERF_TYPE_SOFTWARE, .config = PERF_COUNT_SW_TASK_CLOCK		},
+  { .type = PERF_TYPE_SOFTWARE, .config = target__has_cpu(&target) ?
+						PERF_COUNT_SW_CPU_CLOCK :
+						PERF_COUNT_SW_TASK_CLOCK	},
   { .type = PERF_TYPE_SOFTWARE, .config = PERF_COUNT_SW_CONTEXT_SWITCHES	},
   { .type = PERF_TYPE_SOFTWARE, .config = PERF_COUNT_SW_CPU_MIGRATIONS		},
   { .type = PERF_TYPE_SOFTWARE, .config = PERF_COUNT_SW_PAGE_FAULTS		},
@@ -2030,9 +2032,6 @@ static int add_default_attributes(void)
 
 	if (!evsel_list->core.nr_entries) {
 		/* No events so add defaults. */
-		if (target__has_cpu(&target))
-			default_attrs0[0].config = PERF_COUNT_SW_CPU_CLOCK;
-
 		if (evlist__add_default_attrs(evsel_list, default_attrs0) < 0)
 			return -1;
 		if (perf_pmus__have_event("cpu", "stalled-cycles-frontend")) {
-- 
2.34.1


