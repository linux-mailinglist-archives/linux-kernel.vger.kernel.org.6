Return-Path: <linux-kernel+bounces-402700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1F99C2A96
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 07:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F5D61C21EF3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 06:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA381946CF;
	Sat,  9 Nov 2024 06:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y3fDoWvs"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B37193078
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 06:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731133142; cv=none; b=WqAiyXAIbG0Yy2d5GzxB2+OFZ90/ClcbXe2QvSxoArIixmQQ0xVAtMKz+GY+kLTdNmHzKWsA3oXXEqCdbsyrvgSg5xv0Gllrw3PgyUMc6N4jt4hj2Gis81T4mTTkh36iGwhei8hHKuPNceDxUPeEbaYYrlC2PlDofY7SD1OkcsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731133142; c=relaxed/simple;
	bh=4UPmvdOjJHxQuYsG0yPx07gvw/66IIUoV1gQ16Uzk7g=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=TD152ZzHoyi9ujdgILmkUKRKjXTcj3x2jqP59cQeKiU1UtqMRiyYC5BgdfFG3LycHAsRNhuPvS/JwJcia0ZCBATzh9Xt6pqo0qujhmRzCvxulFwglgqRUarU5Q74vqt+4NCEpDF15tYSOJHaUzjxbifsbaAkC4AxAqyb9sYlbGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y3fDoWvs; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e330f65bcd9so4289713276.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 22:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731133140; x=1731737940; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Q2ReAKc0amQKBCEhLF6CVvc9yuVwJ/Jj6yfY9rXEp0=;
        b=y3fDoWvs9Ao/B8qetVMInU94Ovid1q9SR48jiai4xxe8lmqKs4iSOkYFX5HlHh+oVw
         9dP5F32p26ZrraZmIGnZ2H/N/KumorXnHBsIu+AsnTIgICAboTpah+w/QDZpeuDy/chp
         cLzybJEQCvRneC4AmmTvLeRiE+IL903AXMYzw24tZ2cJQcHEGxxP9UhA8d/0gbMeE48y
         EdOPxhLTwVnqOa9P3hEN98hLVrz0YEB6giBZ874iRw/3F5I7rLGcKVcSxDeu7KhlptBL
         Kv95R1RUbOcWZcvEfojCIwknR1u7ZWnwXecjNbv0YQ72fsz6WZazQYUDuRQ0yrDT1mn/
         sLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731133140; x=1731737940;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Q2ReAKc0amQKBCEhLF6CVvc9yuVwJ/Jj6yfY9rXEp0=;
        b=w7lVynjKYYbdctVdR6cVqGHbQ3KoRy0o3PHml23vRNgzE88YVQpdQxpxvecwLH2qPq
         UODPkaux8e8lJP8MFm6QRrQlWbwYQ4Civ+b3jmv/sTmpv0R+6h2BzXrJPCUMu6mkTmn8
         bJNB9nSZJAaB+T7BN+ivK0gmuNYFtWCT0byjJ6Dv0iL1FnE75tSTbZAFhbhE9JhVu6Zt
         6UMSAgLAk/w04PqkT1GLJzJPRHV1XfhDP/qMyYYZC/BkjXESjiYQcbEEKk3SIonxqyR4
         tjkfFcctU2ZZPluMUOPaa3g9eQw34QRww+i2qachUMPndBggBr9NUbck2nLSmRkQ8nlc
         O/DA==
X-Forwarded-Encrypted: i=1; AJvYcCXG/TISfgQ3JZLH1EPiiqwnIu7JYIRvZ8YhGBrb90QZcfkCNht7rxocw4F0jMXU+Xx69p4VcKwyWIz++8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXdIJ1NyhJBKIJMW2LsefpTC/VxWrXu+RpJY+mwTlb3Qen8E5w
	qH+MZiKAm9yPMXjq/mAcNZzqfH7Cx22Vrg2Q6pq+2G498V1Bw4XN2461wEtP1A5GzNESE+sYSZu
	802TceQ==
X-Google-Smtp-Source: AGHT+IHh4ZHM0I2UXpNWh/5ymHpo3CJW8uS0Jkit6pBWN+9b5hyD+0SxL1crj5yzx+lyNzbojn1jHM1z2PkW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc2:d48f:a998:5915])
 (user=irogers job=sendgmr) by 2002:a25:d652:0:b0:e30:cbcf:181c with SMTP id
 3f1490d57ef6-e337e0f8f50mr24749276.2.1731133140188; Fri, 08 Nov 2024 22:19:00
 -0800 (PST)
Date: Fri,  8 Nov 2024 22:18:04 -0800
In-Reply-To: <20241109061809.811922-1-irogers@google.com>
Message-Id: <20241109061809.811922-18-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241109061809.811922-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v6 17/22] perf kwork: Make perf_kwork_add_work a callback
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
2.47.0.277.g8800431eea-goog


