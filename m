Return-Path: <linux-kernel+bounces-376713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD549AB51C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AADBD1C23B6D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E150F1C2435;
	Tue, 22 Oct 2024 17:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T8SDXWF7"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A071BE23D
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 17:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729618265; cv=none; b=qOkbKGSYQ9TjyKUgmDApgiKQFv6MJtX/cGnDUkSyQ6SPjzfdjR50Y7y0egZ/35zo0gUmzk/l2gSQJCGDYZyeHtz2etZkYreOCP1IGxn6DiiHetsKzZz/yB6eZxb0GqQUNAoWTowhZ3cvfSFdaPR3g5IyCHNOZwNIQkwdiiSJUhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729618265; c=relaxed/simple;
	bh=nAZ99nR+Oe5nWC38v3mC/ZyoUxWfealxv/EFhpW8Loo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=O/4a15xgUxCCzFqWCqMFfmgbaRK3Gx3+Fjs7WJf5FOUE6nbuQ0Js9zxie2LTAoEJMyPfkHhiXn9GflAYCY9tIRJG2RasEd/z7Ww3amg78fvjK8kQuC9D/jU8RGXoa1C9poaQZiUxznFtVfE6ZczTn8/ORnDm6YTCJ528GjdZY2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T8SDXWF7; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e3497c8eb0so1053357b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729618262; x=1730223062; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Cw9APxZPsYeIlsd3UwqSQwdAMf/cDuC3cJ8AZxYajw=;
        b=T8SDXWF7gkSd/PqwvajzUwALAmVSkMHO6WjUJdMYzUyGAJ0gkIWnzf90XmWu7pzeww
         C+LXvq8/hb0LImoyLIBPHpnBC71D2nguv29qT7+wX49yDEGsiBLwyDGYGab8DPR+po40
         6X8EsVG/S4GY4OcKiGl28FYIBlmS8C0i8HH80e9fYNSnoDuZh7jUJvC54biqd7uYwPhF
         PEehGeum+6DljbUzFPniBCt+BY7v8ZJa/KHOIC4QQaKxJnGzI1Ouk5pHY+DL0VCGoiik
         t9ootYNhID3PrvVbE2REr1TCGwDS6jw/JI1nANRpS7YdjV0lC36/AbBFCT9510O6z/Kp
         aG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729618262; x=1730223062;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Cw9APxZPsYeIlsd3UwqSQwdAMf/cDuC3cJ8AZxYajw=;
        b=r1vezNfF1KbZmHz3Vaqs8Xt+L3hYKh89OzNNOufTp5McJCP8IuPOiWT/cxHyow1p0I
         rfMU0r/VFoV+CvSlUY/5C8EZXT9gG4c1vL8RyY7n0funWKcEbUoNsreZJB4DfROqdN90
         xBaFFN4jD34Eniel3qBN4Crv9329VdrOMswLhNeYbQ5+sLClFI3MTpjCETCmoNSBo+ne
         YgIk8Wt2/SjcfJ0lwucKjSizwBABuBLSlWCtQPM7k7f7LE81t48dN7pjOlBiTKC7oTpn
         YE6TqUMURSPYy+YymxE9A+ZpFkjmlNpix1V8QShUUzCGW2dzQhzwns7QHiyp3EL5+ym4
         utUg==
X-Forwarded-Encrypted: i=1; AJvYcCXv6xBv1HjZhawrC6ZDJ1CfQYL2S9llnDd4OZDY9vRd8IOmFzgtV7GWrjEetJMCLf+FhX8rSaKKCtvSFiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIDktX8m0HlRjPbgc5fo9iplLv2F3sayC0yXs9OzC6N99B3XSB
	yQWq1dNb92Mdgy8rqmOoFP59d0JWM3UjMlJ0lZLKhPEHSWtueMmlgYRXhSgfy+c/uqR5FkKLwu7
	7rW5nwA==
X-Google-Smtp-Source: AGHT+IFPgBFqRdUNc0OqbYf9uzqW5Sjrj+hZeWcniqaLPsnRGHZ9VuKwKOnSdmSpIXhyc4XQq4/vyDgmH9Pw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:57ba:88e0:aaf6:282])
 (user=irogers job=sendgmr) by 2002:a05:690c:6f8d:b0:6e3:c4cb:689b with SMTP
 id 00721157ae682-6e7d4a02590mr1650807b3.4.1729618262496; Tue, 22 Oct 2024
 10:31:02 -0700 (PDT)
Date: Tue, 22 Oct 2024 10:30:03 -0700
In-Reply-To: <20241022173015.437550-1-irogers@google.com>
Message-Id: <20241022173015.437550-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241022173015.437550-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v3 05/16] perf kvm: Move functions used in util out of builtin
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

The util library code is used by the python module but doesn't have
access to the builtin files. Make a util/kvm-stat.c to match the
kvm-stat.h file that declares the functions and move the functions
there.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kvm.c   | 61 ---------------------------------
 tools/perf/util/Build      |  1 +
 tools/perf/util/kvm-stat.c | 70 ++++++++++++++++++++++++++++++++++++++
 tools/perf/util/kvm-stat.h |  3 ++
 tools/perf/util/python.c   | 30 ----------------
 5 files changed, 74 insertions(+), 91 deletions(-)
 create mode 100644 tools/perf/util/kvm-stat.c

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 55ea17c5ff02..6f34099d5fb0 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -615,67 +615,6 @@ static const char *get_filename_for_perf_kvm(void)
 
 #if defined(HAVE_KVM_STAT_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
 
-void exit_event_get_key(struct evsel *evsel,
-			struct perf_sample *sample,
-			struct event_key *key)
-{
-	key->info = 0;
-	key->key  = evsel__intval(evsel, sample, kvm_exit_reason);
-}
-
-bool kvm_exit_event(struct evsel *evsel)
-{
-	return evsel__name_is(evsel, kvm_exit_trace);
-}
-
-bool exit_event_begin(struct evsel *evsel,
-		      struct perf_sample *sample, struct event_key *key)
-{
-	if (kvm_exit_event(evsel)) {
-		exit_event_get_key(evsel, sample, key);
-		return true;
-	}
-
-	return false;
-}
-
-bool kvm_entry_event(struct evsel *evsel)
-{
-	return evsel__name_is(evsel, kvm_entry_trace);
-}
-
-bool exit_event_end(struct evsel *evsel,
-		    struct perf_sample *sample __maybe_unused,
-		    struct event_key *key __maybe_unused)
-{
-	return kvm_entry_event(evsel);
-}
-
-static const char *get_exit_reason(struct perf_kvm_stat *kvm,
-				   struct exit_reasons_table *tbl,
-				   u64 exit_code)
-{
-	while (tbl->reason != NULL) {
-		if (tbl->exit_code == exit_code)
-			return tbl->reason;
-		tbl++;
-	}
-
-	pr_err("unknown kvm exit code:%lld on %s\n",
-		(unsigned long long)exit_code, kvm->exit_reasons_isa);
-	return "UNKNOWN";
-}
-
-void exit_event_decode_key(struct perf_kvm_stat *kvm,
-			   struct event_key *key,
-			   char *decode)
-{
-	const char *exit_reason = get_exit_reason(kvm, key->exit_reasons,
-						  key->key);
-
-	scnprintf(decode, KVM_EVENT_NAME_LEN, "%s", exit_reason);
-}
-
 static bool register_kvm_events_ops(struct perf_kvm_stat *kvm)
 {
 	struct kvm_reg_events_ops *events_ops = kvm_reg_events_ops;
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index fa508e113dd0..2a2f7780e595 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -120,6 +120,7 @@ perf-util-y += spark.o
 perf-util-y += topdown.o
 perf-util-y += iostat.o
 perf-util-y += stream.o
+perf-util-y += kvm-stat.o
 perf-util-$(CONFIG_AUXTRACE) += auxtrace.o
 perf-util-$(CONFIG_AUXTRACE) += intel-pt-decoder/
 perf-util-$(CONFIG_AUXTRACE) += intel-pt.o
diff --git a/tools/perf/util/kvm-stat.c b/tools/perf/util/kvm-stat.c
new file mode 100644
index 000000000000..38ace736db5c
--- /dev/null
+++ b/tools/perf/util/kvm-stat.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "debug.h"
+#include "evsel.h"
+#include "kvm-stat.h"
+
+#if defined(HAVE_KVM_STAT_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
+
+bool kvm_exit_event(struct evsel *evsel)
+{
+	return evsel__name_is(evsel, kvm_exit_trace);
+}
+
+void exit_event_get_key(struct evsel *evsel,
+			struct perf_sample *sample,
+			struct event_key *key)
+{
+	key->info = 0;
+	key->key  = evsel__intval(evsel, sample, kvm_exit_reason);
+}
+
+
+bool exit_event_begin(struct evsel *evsel,
+		      struct perf_sample *sample, struct event_key *key)
+{
+	if (kvm_exit_event(evsel)) {
+		exit_event_get_key(evsel, sample, key);
+		return true;
+	}
+
+	return false;
+}
+
+bool kvm_entry_event(struct evsel *evsel)
+{
+	return evsel__name_is(evsel, kvm_entry_trace);
+}
+
+bool exit_event_end(struct evsel *evsel,
+		    struct perf_sample *sample __maybe_unused,
+		    struct event_key *key __maybe_unused)
+{
+	return kvm_entry_event(evsel);
+}
+
+static const char *get_exit_reason(struct perf_kvm_stat *kvm,
+				   struct exit_reasons_table *tbl,
+				   u64 exit_code)
+{
+	while (tbl->reason != NULL) {
+		if (tbl->exit_code == exit_code)
+			return tbl->reason;
+		tbl++;
+	}
+
+	pr_err("unknown kvm exit code:%lld on %s\n",
+		(unsigned long long)exit_code, kvm->exit_reasons_isa);
+	return "UNKNOWN";
+}
+
+void exit_event_decode_key(struct perf_kvm_stat *kvm,
+			   struct event_key *key,
+			   char *decode)
+{
+	const char *exit_reason = get_exit_reason(kvm, key->exit_reasons,
+						  key->key);
+
+	scnprintf(decode, KVM_EVENT_NAME_LEN, "%s", exit_reason);
+}
+
+#endif
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index 3e9ac754c3d1..4249542544bb 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -115,6 +115,8 @@ struct kvm_reg_events_ops {
 	struct kvm_events_ops *ops;
 };
 
+#if defined(HAVE_KVM_STAT_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
+
 void exit_event_get_key(struct evsel *evsel,
 			struct perf_sample *sample,
 			struct event_key *key);
@@ -127,6 +129,7 @@ bool exit_event_end(struct evsel *evsel,
 void exit_event_decode_key(struct perf_kvm_stat *kvm,
 			   struct event_key *key,
 			   char *decode);
+#endif
 
 bool kvm_exit_event(struct evsel *evsel);
 bool kvm_entry_event(struct evsel *evsel);
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 298f43981fc5..ab67abf3b607 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1306,36 +1306,6 @@ PyMODINIT_FUNC PyInit_perf(void)
 /* The following are stubs to avoid dragging in builtin-* objects. */
 /* TODO: move the code out of the builtin-* file into util. */
 
-bool kvm_entry_event(struct evsel *evsel __maybe_unused)
-{
-	return false;
-}
-
-bool kvm_exit_event(struct evsel *evsel __maybe_unused)
-{
-	return false;
-}
-
-bool exit_event_begin(struct evsel *evsel __maybe_unused,
-		      struct perf_sample *sample  __maybe_unused,
-		      struct event_key *key  __maybe_unused)
-{
-	return false;
-}
-
-bool exit_event_end(struct evsel *evsel __maybe_unused,
-		    struct perf_sample *sample __maybe_unused,
-		    struct event_key *key __maybe_unused)
-{
-	return false;
-}
-
-void exit_event_decode_key(struct perf_kvm_stat *kvm __maybe_unused,
-			   struct event_key *key __maybe_unused,
-			   char *decode __maybe_unused)
-{
-}
-
 int find_scripts(char **scripts_array  __maybe_unused, char **scripts_path_array  __maybe_unused,
 		int num  __maybe_unused, int pathlen __maybe_unused)
 {
-- 
2.47.0.163.g1226f6d8fa-goog


