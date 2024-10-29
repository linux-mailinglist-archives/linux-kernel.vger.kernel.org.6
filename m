Return-Path: <linux-kernel+bounces-387784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F969B55FE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 848EA1F23B0E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 22:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65A720EA31;
	Tue, 29 Oct 2024 22:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xglZCLe9"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B5E20BB49
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 22:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730241913; cv=none; b=DBbMgj3l+X4rmzI0BQ5hy4vSundHqGudG5RSMbUM1mKvqMwJgsgrLsvzZ+HD2iygzERekUhWnlavgWiwEOQ78YRNpLv3nwb+4rnrSRRUqdhDU3Wq7hfVXttbrWWioRQ+AisaERcgblmICW4PCKl+JEVGXVSLHJIMwEZ6J9IBOfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730241913; c=relaxed/simple;
	bh=lW07OjyjtiP7BSeHvWrJwzhwe6xJuxZ4Ci6QSD1wU8E=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=cf1x7/f7vIEXTxEaEhSFp4vEOXQWo4kJlxs8fP+bJtwed4zCJRaPXi75ysJJSVNZQsOUz1avhvQaXEiFcV+SEpzjOac6//X9EBLW8YZKOrNt+mnYvt8ConxkQjFrIqLtdFLyUXOL60NZtZcKD1q+0Fxau7iwo3pvblVanX72vUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xglZCLe9; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea33140094so20088377b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 15:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730241910; x=1730846710; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t8Sn8jdbA+NjEGCeG6Gm1wYYNvd28v2iQntXlq3XUm8=;
        b=xglZCLe902GPEY1YcFGswTibeH3MMl5tzJYPe0OS37yEQNOJvtdqMaaZp/ROW9p8Km
         oQkm5GVTsg+8Ui9XpIqphToyMuJKaqHO38wn8SVxDwrb6OrjmSAJPv3YP5vBC/xoUvr0
         eU0dWXZbGyeaVONhf6RXjLvZsHh6CNDj4mLqxkI/44NQQc46rve32xgPVQH2/aNEvmhg
         Rt2PMb2QvzWtNhxO69665DTrCs5giSO5AQgtDoWSCEmVGFXzLvhrHifN5WD5Nob8/EDN
         RD/Q7VNe0vpeyDwm9BqCWLPdKsExwzD9qVNB6KXTWdCzd4sasWrgnRyTDymbavDCHsNL
         wuMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730241910; x=1730846710;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t8Sn8jdbA+NjEGCeG6Gm1wYYNvd28v2iQntXlq3XUm8=;
        b=TgPsxeDWtqcm8TvU31qfxjhv/tqXb0hb16RuY3UyFXDoyPBV10K5wbIcO5fnXbOum/
         LmH3xzVY9vuqpen6kntb83Vsulll5vfL6CM6/YEYaTk4kWH27ws+Rey5Km3uMal65Z5l
         k+YpDSryAUhn1clT+M3tqwtCOQnlSzYaKkpFtVepsuvdQAsr8AXXsmdsuPI3GvKgUcoi
         QVnoBSIZvayYryVy59ol9bBpSkFlEnfUHWePHpbGu9os4HWA+DuayF86siI4MWws8XXs
         WJ/RC9L1d/q7HAwtlM4bgKITeFYOS0FxJkyQPxgKUmRU1GHpSIK8SFsiNP4Xg9CXQs7q
         eGIQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1COmKy0kTPaOS9IyGFwxeWQRCCnSe8Y8/Not0mF8guSdvr3IZp2EyKM7E0MEkTj+CKUUUAlhadCzniJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPCepD0KfB4tfGd5Gk06qCkdiPYscZRLbIc+zjplge950MZ+BM
	sX+f52NU6nKIk/fQehq8ZAAgdrTai337NnyxJZ6f7yAr/297d/YikB0IiwDldBUlPWFXP+M1TaF
	kA5iCmQ==
X-Google-Smtp-Source: AGHT+IFKiD6Vt5O33DxVSXqakkHGLWhwNffm+KUxsCr8mueF5TZLFaA+FFpMTOgPigeazM/Bd0+g9+cXZ1mG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8991:d3fd:38a7:c282])
 (user=irogers job=sendgmr) by 2002:a81:a884:0:b0:6e7:e493:2da6 with SMTP id
 00721157ae682-6e9d8b16e66mr2352317b3.6.1730241909596; Tue, 29 Oct 2024
 15:45:09 -0700 (PDT)
Date: Tue, 29 Oct 2024 15:44:26 -0700
In-Reply-To: <20241029224431.167623-1-irogers@google.com>
Message-Id: <20241029224431.167623-15-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241029224431.167623-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v4 14/19] perf kwork: Make perf_kwork_add_work a callback
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

perf_kwork_add_work is declared in builtin-kwork, whereas much kwork
code is in util. To avoid needing to stub perf_kwork_add_work in
python.c, add a callback to struct perf_kwork and initialize it in
builtin-kwork to perf_kwork_add_work - this is the only struct
perf_kwork. This removes the need for the stub in python.c.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kwork.c      |  3 ++-
 tools/perf/util/bpf_kwork.c     |  2 +-
 tools/perf/util/bpf_kwork_top.c |  2 +-
 tools/perf/util/kwork.h         |  6 ++++--
 tools/perf/util/python.c        | 12 ------------
 5 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index c1daf82c9b92..fabfcb74800b 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -1846,7 +1846,7 @@ static void process_skipped_events(struct perf_kwork *kwork,
 	}
 }
 
-struct kwork_work *perf_kwork_add_work(struct perf_kwork *kwork,
+static struct kwork_work *perf_kwork_add_work(struct perf_kwork *kwork,
 				       struct kwork_class *class,
 				       struct kwork_work *key)
 {
@@ -2344,6 +2344,7 @@ int cmd_kwork(int argc, const char **argv)
 		.all_runtime         = 0,
 		.all_count           = 0,
 		.nr_skipped_events   = { 0 },
+		.add_work            = perf_kwork_add_work,
 	};
 	static const char default_report_sort_order[] = "runtime, max, count";
 	static const char default_latency_sort_order[] = "avg, max, count";
diff --git a/tools/perf/util/bpf_kwork.c b/tools/perf/util/bpf_kwork.c
index 6c7126b7670d..5cff755c71fa 100644
--- a/tools/perf/util/bpf_kwork.c
+++ b/tools/perf/util/bpf_kwork.c
@@ -285,7 +285,7 @@ static int add_work(struct perf_kwork *kwork,
 	    (bpf_trace->get_work_name(key, &tmp.name)))
 		return -1;
 
-	work = perf_kwork_add_work(kwork, tmp.class, &tmp);
+	work = kwork->add_work(kwork, tmp.class, &tmp);
 	if (work == NULL)
 		return -1;
 
diff --git a/tools/perf/util/bpf_kwork_top.c b/tools/perf/util/bpf_kwork_top.c
index 7261cad43468..b6f187dd9136 100644
--- a/tools/perf/util/bpf_kwork_top.c
+++ b/tools/perf/util/bpf_kwork_top.c
@@ -255,7 +255,7 @@ static int add_work(struct perf_kwork *kwork, struct work_key *key,
 	bpf_trace = kwork_class_bpf_supported_list[type];
 	tmp.class = bpf_trace->class;
 
-	work = perf_kwork_add_work(kwork, tmp.class, &tmp);
+	work = kwork->add_work(kwork, tmp.class, &tmp);
 	if (!work)
 		return -1;
 
diff --git a/tools/perf/util/kwork.h b/tools/perf/util/kwork.h
index 76fe2a821bcf..29352ca1d497 100644
--- a/tools/perf/util/kwork.h
+++ b/tools/perf/util/kwork.h
@@ -251,12 +251,14 @@ struct perf_kwork {
 	 * perf kwork top data
 	 */
 	struct kwork_top_stat top_stat;
-};
 
-struct kwork_work *perf_kwork_add_work(struct perf_kwork *kwork,
+	/* Add work callback. */
+	struct kwork_work *(*add_work)(struct perf_kwork *kwork,
 				       struct kwork_class *class,
 				       struct kwork_work *key);
 
+};
+
 #ifdef HAVE_BPF_SKEL
 
 int perf_kwork__trace_prepare_bpf(struct perf_kwork *kwork);
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index c52da509ae58..6e2ff0076daa 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -16,7 +16,6 @@
 #include "thread_map.h"
 #include "trace-event.h"
 #include "mmap.h"
-#include "util/kwork.h"
 #include "util/sample.h"
 #include <internal/lib.h>
 
@@ -1297,14 +1296,3 @@ PyMODINIT_FUNC PyInit_perf(void)
 		PyErr_SetString(PyExc_ImportError, "perf: Init failed!");
 	return module;
 }
-
-
-/* The following are stubs to avoid dragging in builtin-* objects. */
-/* TODO: move the code out of the builtin-* file into util. */
-
-struct kwork_work *perf_kwork_add_work(struct perf_kwork *kwork __maybe_unused,
-				       struct kwork_class *class __maybe_unused,
-				       struct kwork_work *key  __maybe_unused)
-{
-	return NULL;
-}
-- 
2.47.0.163.g1226f6d8fa-goog


