Return-Path: <linux-kernel+bounces-189229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA2E8CED68
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 03:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32D66281C8F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 01:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29E115C3;
	Sat, 25 May 2024 01:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uy402Tw5"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A1E63A
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 01:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716600640; cv=none; b=LTlR3H4WojHGBlPw+NFxDiasj5AsKzI7BNriH0cQMpI89zT3/VCcuE10QFwF9J8T5KiOq12Nu9IR5ks+mmpCy//9DDZA/FZ9oDXjOBz6xgcRhL82LQbMiiiB8C4idJRKv5PkYgqjIfOR3DMoWSFNbnHrv67fdlvmACyvcV9aJWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716600640; c=relaxed/simple;
	bh=Ts0dqe6K6uKFuGxzf0I0eXV77lX2kybuRrr/f6Fr+ws=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=HLyWsEAu2u//tNPFVQTLTom9tx9cG0ZjqgLhFe4ih4tgoNpOzW/W+nzWS4eDytjv8pe35gdbWj2KcNoyaFmO6guVq/Ih/ycSjryY+6N0daWsJ2VwO9vC/SjXTL6iG2xKbK828ve2uEqMOcAEfCtdMaB0Qa/NAQDt99s4fVeX8+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uy402Tw5; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62a052ffe31so8782457b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 18:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716600636; x=1717205436; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QPb6Q+KRqvfktX5EPKrvPHvH0PQLcGsMH8/fhQZA9+w=;
        b=Uy402Tw5gMQqz+wVu8Oa1n8rR9zS1JoNzGqJVKgg8ZguZPR1zoI7+qzAO3fOS6Pkvn
         ta5/QmQZ+ZixmIXhSgzpOedAM6zgHLKz4eWgnhbrC1GAz4tK7f6JzMTssPgrP3gV71fr
         DnGmvszc+9j2NMgHoXYBv4Babbh56uOKQF1eS2m5DUSdbRRgQ6wYK/b9RYSNwP4KonmY
         99XtnQBpP7BFVHWcNkqZpzHd1BB7Mwpwwpu/YxV5mYGmLBhsPfX/NM4YztECW59H9giP
         a1pf2cBT1QJ4hzj4XzMSar7dNtuN9xZViBlhR6E7DIqtrcS4h14cqECX4DZK0qB4F4Cs
         YZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716600636; x=1717205436;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QPb6Q+KRqvfktX5EPKrvPHvH0PQLcGsMH8/fhQZA9+w=;
        b=wEH7mac7Wn7oaTiQ9wSn6rTS583Ed7Jlv8ABfoIf7d/4QglkpLu9UTUOM+HFhtYJ4C
         UotwjcD+fRqb2cey0mCMyh+fhswl/w3F4c3BcomxrV+72wc5Zom2uHo6l3rmq3EXL0v4
         ngUyleJi8JqYqFEAuZIGXTvfVdSfRXV7hB9Umt6A4w6/YZ6aUwTRkzrGMO5/N5zeJVpc
         q9EexvTmYMGq5nnUmDhanZ+pl18P1pERHYgL6S4meuWjpJj3IMVkZ9fTVn0rWeaEyfvm
         Z/T1GhXHbGijof3i7uhMF8tTm6B2CCkdDUPHRJxETcmei5LslgpYTWhZmnSz4avFBdwX
         nAuw==
X-Forwarded-Encrypted: i=1; AJvYcCXaGDIC0DU4VXWRFjqtxYbqUaGdguXOaqrDFgOxXB4aE87jpGua8qeaNcEXTO10FQSzQaaIXm/JBGQiQZ1wMl/NZ6PfmsdqIEW8G/Gu
X-Gm-Message-State: AOJu0YwPn7+cvD2o+Pm/OXGP7pEA68mP9BktA1dEHb3zcQTmOUqw/DJd
	5ndgkRARtIJslRl77E6f3BaF5M3UlLIHj6niZwpNvCSsIh1iLbnONkrU4lqHUxzI6gxhA0B37CG
	hRlTf7w==
X-Google-Smtp-Source: AGHT+IGmkF3+V0Ozuy5EbuioYBt68G7Q+xND22wXwzK3iViocRlXZg7Tm+LKiaDwSTzMv31osrsbToh9E09B
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b0b5:95af:a29:375e])
 (user=irogers job=sendgmr) by 2002:a05:690c:600b:b0:611:5a9d:bb0e with SMTP
 id 00721157ae682-62a076284d6mr9246757b3.4.1716600636541; Fri, 24 May 2024
 18:30:36 -0700 (PDT)
Date: Fri, 24 May 2024 18:30:20 -0700
Message-Id: <20240525013021.436430-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Subject: [PATCH v2 1/2] perf jevents: Use name for special find value
From: Ian Rogers <irogers@google.com>
To: Weilin Wang <weilin.wang@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	John Garry <john.g.garry@oracle.com>, Sandipan Das <sandipan.das@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

-1000 was used as a special value added in Commit 3d5045492ab2 ("perf
pmu-events: Add pmu_events_table__find_event()") to show that 1 table
lacked a PMU/event but that didn't terminate the search in other
tables. Add a new constant PMU_EVENTS__NOT_FOUND for this value and
use it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py   | 6 +++---
 tools/perf/pmu-events/pmu-events.h | 9 +++++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index e42efc16723e..7cc16ff96dc8 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -905,7 +905,7 @@ static int pmu_events_table__find_event_pmu(const struct pmu_events_table *table
   do_call:
                 return fn ? fn(&pe, table, data) : 0;
         }
-        return -1000;
+        return PMU_EVENTS__NOT_FOUND;
 }
 
 int pmu_events_table__for_each_event(const struct pmu_events_table *table,
@@ -943,10 +943,10 @@ int pmu_events_table__find_event(const struct pmu_events_table *table,
                         continue;
 
                 ret = pmu_events_table__find_event_pmu(table, table_pmu, name, fn, data);
-                if (ret != -1000)
+                if (ret != PMU_EVENTS__NOT_FOUND)
                         return ret;
         }
-        return -1000;
+        return PMU_EVENTS__NOT_FOUND;
 }
 
 size_t pmu_events_table__num_events(const struct pmu_events_table *table,
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index f5aa96f1685c..5435ad92180c 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -70,6 +70,8 @@ struct pmu_metric {
 struct pmu_events_table;
 struct pmu_metrics_table;
 
+#define PMU_EVENTS__NOT_FOUND -1000
+
 typedef int (*pmu_event_iter_fn)(const struct pmu_event *pe,
 				 const struct pmu_events_table *table,
 				 void *data);
@@ -82,6 +84,13 @@ int pmu_events_table__for_each_event(const struct pmu_events_table *table,
 				    struct perf_pmu *pmu,
 				    pmu_event_iter_fn fn,
 				    void *data);
+/*
+ * Search for table and entry matching with pmu__name_match. Each matching event
+ * has fn called on it. 0 implies to success/continue the search while non-zero
+ * means to terminate. The special value PMU_EVENTS__NOT_FOUND is used to
+ * indicate no event was found in one of the tables which doesn't terminate the
+ * search of all tables.
+ */
 int pmu_events_table__find_event(const struct pmu_events_table *table,
                                  struct perf_pmu *pmu,
                                  const char *name,
-- 
2.45.1.288.g0e0cd299f1-goog


