Return-Path: <linux-kernel+bounces-367239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7654B9A0024
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 06:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3549C286DCA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 04:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E3118BC31;
	Wed, 16 Oct 2024 04:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HUb4LeMs"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BE518BC28
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 04:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729052689; cv=none; b=B6RoWyp5xw7GkAPOL/QT+T/8BHZF/zasemuDyP72dnPjOsgvRIiofE+5GTF3V14w4k4+BBDUAHeHv8nZ+qPV4h9fss1YLxyzLxsgSuTf+hXTDFtCYfik1H4mPQvN1vOh3wwpYfxbSalhBfRDQPeB1vQeGPHNpncK9zA4icEjoDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729052689; c=relaxed/simple;
	bh=sevNlyfEJVFmCq0ytEyhLchplPVQxoaCC3sAsSe1/f8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=KyRfi4+/LpI7khDEK0BBKt4A9rKCP1UGsk+YiyL+Fqn2X7W2/ugb1XhiF0uoKW2lEh4AzTVRB7W751upYDWYYpqG6+mgv4+1pm/kjUPcPDNm/FaEI3cyCsi7Sg+2c4GcIu+1lvfZP/Tq1IBmlcFp/Biu56guZZebBdn7ftG7Pqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HUb4LeMs; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e293150c2c6so7795922276.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 21:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729052686; x=1729657486; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qQyl2EObKlFstHveBm/uzMgWIzegkTZ8/5AcFUtSIFY=;
        b=HUb4LeMs2+Mh/5tKP4SureS+LlKFM0nW9D2y+Ox6j12Hm6z1dqVfeC8hT0SRyrE9Jz
         1KvdmMRpD7M7mBY9ob0SpGK16yvwhB8wICJGQJcVNCDhqPdropIe3tfrj1tcAL1ocgJx
         paZhH0V+qYeSZ4ZpgUVPaeHW5m8LQOBOT2B9IykubBkQVq3RIFAppZEb3vAVRNI7T7id
         TgallTmxgY8xChHZ8MpIjmKgKrI+ahhWm30MHqliWgl7IhkFyaPUdd7pri40Pb3Zk6FZ
         OsbFX1zBl+f2zFuHQpseh93ubpnihNE32lEXc9JoM8lgzcyCwmaRIAO+nXQly3EgIs8e
         hrEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729052686; x=1729657486;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qQyl2EObKlFstHveBm/uzMgWIzegkTZ8/5AcFUtSIFY=;
        b=Wrq5lZiAyDHoqeD6bc0NU/mlfYiW26KfBSP+dDQSGgTeZYlm1+GvQi9va5hcRCgC3C
         QbWQAcOmLaK1Rq21wKuGuTRb4LmPZ4Cwzz2nzw0TyGZQSYEmFvqMlmH9W+OqVtga2C+q
         BKq3kbWx/cTECepsugULNk0InNRcjUtZ1ftDjkbEPOA7I7oY0FxWwu/qK+d7P2yYHqLE
         /lL1wtDp2q/ecjbAGGcv9FLIuVlPBsmqOvrZ8+idZe5urLFZiBESyHCmY6y35ZhDZc0l
         PDw/HjTcGWegC6JKV5N2VXcreT4nfJ6jJumhmsjsSXvVJKVQL/dTHCh9uEcZ12OJ93wV
         FkxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTw1b85w3MhdB8u7QojbQtp/OCz4HjdLEauuqmC6N+PEVTXKiZG6v9VI7qvC2/xYwGxbXhN6TW8FvchLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnnUtkn9c1KAcbvppGGvvGNeXikl3C0iXLOpiHHNItVnDZiClk
	IkqCzcxgqZGLZGab1GurwI9Tro3Hbo/+4i81GbT/nEH/J7vsKE5qSve47FopDw56VLXi32lJs8y
	LZvgvjA==
X-Google-Smtp-Source: AGHT+IFirg7lf86uX0MYsDX47DXOxSEArB6ExV/cuOBucvZo3ssUJELaOGG3Jw59lLKBF1qxYnQ0FIv7XUJa
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a25:aaa3:0:b0:e20:25f5:a889 with SMTP id
 3f1490d57ef6-e29783030e0mr1502276.5.1729052685919; Tue, 15 Oct 2024 21:24:45
 -0700 (PDT)
Date: Tue, 15 Oct 2024 21:24:04 -0700
In-Reply-To: <20241016042415.7552-1-irogers@google.com>
Message-Id: <20241016042415.7552-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241016042415.7552-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 05/16] perf kvm: Move functions used in util out of builtin
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
2.47.0.rc1.288.g06298d1525-goog


