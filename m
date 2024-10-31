Return-Path: <linux-kernel+bounces-389854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5A89B7229
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 02:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FCAB1C233A2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 01:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7777514901B;
	Thu, 31 Oct 2024 01:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3oit4txH"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C92148855
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 01:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730339036; cv=none; b=GB5bhRzE8kf8EZC4/7IwENiYH3cnUbSbnRwVKHo4bR94O4KknA1eoyr8sBzD1PHZ3Ac345TEja1Qbj2SYmT35fqdE97iiWlAQAzNVV1QXgXs/t4FpPuBdTvCEYlbAGcO2D4iYfrQSQCz/zDWDpc5HyG+bO1jBUqkC9C2Hc76AbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730339036; c=relaxed/simple;
	bh=lW07OjyjtiP7BSeHvWrJwzhwe6xJuxZ4Ci6QSD1wU8E=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=R5B2JDzxv7WnDi/1X3LdxQzlQzD01+sGK+DQ1n46fB/pYQkk6lgLl9kwTtGZtHIp23HYIcQKvGnojPTS2LLFmtqOBAezmi0qlAlr0hyJK3Ay3eLDLW7aVfRk+BCcqsDru7CniRSsffRXN0wRzkjDbBLJwU9XRj2uuvcaO/kh3Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3oit4txH; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2904d0cad0so867369276.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 18:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730339033; x=1730943833; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t8Sn8jdbA+NjEGCeG6Gm1wYYNvd28v2iQntXlq3XUm8=;
        b=3oit4txHj0gb3ZzEWB7LaF7L6IQCTaQP3zQwF0oeuDl8H2aDd3DmRTVnCQAXWPlefd
         CPggBErzmmxzfh9Bm++ErqJE4wXtmWuyLo7AJMcTPusPL05KVi/jr5mv/EFPY8tG50ZT
         RmxWrVA0/i/+rRgPOHxcKgwvJLdEzZkGSMzZUOBjA+s9Hkh2ZI/AQEnw/qubxA9Swayo
         0w0s5tGoWvJemhZDhOuLdrp3wy8UNNPv22AbL/3o2suxI+lRUVMLye0lhyxYXs4UUNfz
         lypU6Y+v4wTyUR4sgwSse+XOnpdWccgaNhS/2gP4GQ1NENWMb/HlOOYF7c7SIboz7xHX
         uY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730339033; x=1730943833;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t8Sn8jdbA+NjEGCeG6Gm1wYYNvd28v2iQntXlq3XUm8=;
        b=qkPqyQzVooifrttsuxSlKJg/j3gDNKSPKxguHKbns4Mf8WH0KWjiyYzctA1W5WqI4v
         gfDj0vgEnjLTJ9NxMPicBnhlt3d6MIYiAJyAipxLHZ0O1Edq8xLAxqGkuCb5Vbx0JF3J
         GX7h5iEOuQ8DC+8jySULiEJ/podilHNzXGOibQmJlwyU/5zdOMlVAMdxu51RIM/xAnAQ
         svVX/QlUzgMWvdKbzDdih77uobNMhMeXSwEzdAEHfEMkhAnH+mFQxfz/wMzemwiLsK3a
         276ZpbqICyMKH30HFdEghZYZHMpNPqlTjVBYTcOs852qd4focHfDynXLbgO/GeZXcCLl
         aQMA==
X-Forwarded-Encrypted: i=1; AJvYcCX9VDxCQ9O0ITim680dz5xm7DzyL0pEJ/3vWBCLT4oKnR2O+0w8xorF/HXexL5YvR6diPQDz5NltscpVVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpqVXBXHAhZRmSlxw9Bn86+gqC43AtXVat4NlByOJSoFJqw235
	0T0lqc6G0/o5h2YIem9E2rYOGHWfiC5R5toVkoaggxaUeahqBPMq0U8iSVHd908vmYAzDEJEbwB
	Ch2p/Xg==
X-Google-Smtp-Source: AGHT+IENQAr4DyjJzfVoLdavjhPbpIIWA4h+VHZAUWU69OewcS/tSnsHo7O4wYPUpEXhUAU71z/C/JUuheGY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ad0f:67e7:f1a6:84c4])
 (user=irogers job=sendgmr) by 2002:a25:ae64:0:b0:e20:2db0:932e with SMTP id
 3f1490d57ef6-e3087bceae0mr63813276.6.1730339033538; Wed, 30 Oct 2024 18:43:53
 -0700 (PDT)
Date: Wed, 30 Oct 2024 18:42:47 -0700
In-Reply-To: <20241031014252.753588-1-irogers@google.com>
Message-Id: <20241031014252.753588-17-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241031014252.753588-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v5 16/21] perf kwork: Make perf_kwork_add_work a callback
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
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org, 
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


