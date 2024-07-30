Return-Path: <linux-kernel+bounces-268102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D970594206E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48A38B220DC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCA818C93D;
	Tue, 30 Jul 2024 19:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YzWqJxxg"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E6D18C906
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 19:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722367072; cv=none; b=eCSFMxumBfMCS9C6LHw2eADjicXe1e4+w8FRejJW9taT8uhmi+EaCpFVXcG3X/VUzlbYd2RBC/zh8bUiR9vl5sBsjA/gjC2TyAim5f0OOLv9EhVq3g98k6YWxZsSQ5YS5sCMe+qpz02GTYuBuYbggLsg4ITHjd44H3DRD/8C130=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722367072; c=relaxed/simple;
	bh=QZOrbrVSFvz40nx9vDHmvHb3Af1cw8vhwpVnG+d/kxE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=AOYnr9W9NMRrW3ePLRIdxks+XO6AF9AFAAvLusLurSwmpluAbmbR6MPZd9pjOr+UXayF1URcRfzQQuEL6/YEPY2ZIKObqaNi+J14MfqUrch06QLg3z1ylLrcTgknRfwkqY+Gu2LHCmcQiB9miqaJS69O2nG5n29taqDFtEurKy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YzWqJxxg; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6799b9a2161so107137747b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 12:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722367070; x=1722971870; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BPOVxn1MOz4Po+ahQmLNc9pZpMQMX4IsBrGFVJB/LRE=;
        b=YzWqJxxgRFxdxXg3Lmmj3IxwAPoQ7Mi64HcRupHOb99I+XND+2tAsuOCabiEEqn2QE
         Trp5wOfFo/hfjr01//30VXLy1bXFv058lwZy0cPPUWSOLJZRCufEONBkHcU23scOgV9k
         DwDBohP2WWCP//lS6z6BaM0ozeRbx59SSmkaiIZLOb+aqeEKLY10aR8m2YFw9Xehfkv3
         WPZAWMNgGkwkraL7V7ZOrpHtjj8HoIjMbgNm39O9wvpbxQE13uXVCNwtDF1AT40It86x
         y4wYiP1AkjgNHEgl1EkdJBZ4KBG9JhjeFgZeUUI73FmSp3DGXrQKYe9rGhmA28HWukxH
         nF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722367070; x=1722971870;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BPOVxn1MOz4Po+ahQmLNc9pZpMQMX4IsBrGFVJB/LRE=;
        b=lkprjJa2F5hb36g13H8EBSl9YSxLi6DK98y1gJ2VLp+mvpZqRzbJ+1I96myxdRqjXx
         DTvpUDt12/oWtSUtt4oeB26XIeabG7XPE2j9iNTJzSg+akIoighUMkaCMwL6+VqUNsYT
         EsfDKllQvb8QvgL/g6U3KNkxCoxOFJOnqrvP9YElTBGcRrYWYZpqSNAUi6TvnoxFU39s
         ugi/vpeeRdqPU8EaE2ZTgvJyOHuwNNukpNYPt5/SY6IZ5FzNzX94N1pYTkaahYz3/s8F
         M5DRLmsrh4x3MzwOINSSUvyVS3uiCeffRfzTu6VGvpn9CXq3AcKBmuXhnjE798UIrfj+
         /qYw==
X-Forwarded-Encrypted: i=1; AJvYcCXQKVXCwmcE+tk8BzOqer3OlPtY0gpf6GDMHBLq8xDjplzCwxKMlxQYV8C18DiqXve8sG5Dd/TbsS3gdMGpFTa8F35H3dsCpcUnigfs
X-Gm-Message-State: AOJu0YyMxcfmEv8wQ96v0FsTKrwRJ3vKzBdR39D4UHp3Nm80ZA2A655I
	/0SDO6MiRNUVzvYfub72apcE9K3sholcMGJ+N/KeTOsiZAhpwkjX/q3/mkJnjkBGjlM3+Ylqzmm
	UDK0ngg==
X-Google-Smtp-Source: AGHT+IE5r3aHVdMBwAXY58Lu8fOyOfcpigXAVj2XKFlPB3GWt+T338Emu07Q9s4GHku0J9t9skoC6tDz/JFV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b07a:93d0:1b64:3771])
 (user=irogers job=sendgmr) by 2002:a05:6902:18c1:b0:e05:6026:f741 with SMTP
 id 3f1490d57ef6-e0b5442a26bmr802456276.2.1722367070046; Tue, 30 Jul 2024
 12:17:50 -0700 (PDT)
Date: Tue, 30 Jul 2024 12:17:43 -0700
In-Reply-To: <20240730191744.3097329-1-irogers@google.com>
Message-Id: <20240730191744.3097329-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240730191744.3097329-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Subject: [PATCH v3 1/2] perf jevents: Use name for special find value
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Sandipan Das <sandipan.das@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, philip.li@intel.com, oliver.sang@intel.com, 
	Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"

-1000 was used as a special value added in Commit 3d5045492ab2 ("perf
pmu-events: Add pmu_events_table__find_event()") to show that 1 table
lacked a PMU/event but that didn't terminate the search in other
tables. Add a new constant PMU_EVENTS__NOT_FOUND for this value and
use it.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: John Garry <john.g.garry@oracle.com>
---
 tools/perf/pmu-events/jevents.py   | 6 +++---
 tools/perf/pmu-events/pmu-events.h | 9 +++++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index ac9b7ca41856..731776e29f47 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -906,7 +906,7 @@ static int pmu_events_table__find_event_pmu(const struct pmu_events_table *table
   do_call:
                 return fn ? fn(&pe, table, data) : 0;
         }
-        return -1000;
+        return PMU_EVENTS__NOT_FOUND;
 }
 
 int pmu_events_table__for_each_event(const struct pmu_events_table *table,
@@ -944,10 +944,10 @@ int pmu_events_table__find_event(const struct pmu_events_table *table,
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
2.46.0.rc2.264.g509ed76dc8-goog


