Return-Path: <linux-kernel+bounces-402693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C09909C2A8F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 07:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2D2F1C20FB1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 06:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45CC15539D;
	Sat,  9 Nov 2024 06:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bHCyNPeA"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B621547CD
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 06:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731133127; cv=none; b=C4juxQuw91mw0QyGRziPSf+2KV+VMYIlNJA5DE9srK+5+cOoywvARzuA9CGyGMd7KYXB76+nAEtN1ApoIt1QyCt1Ping006xdK1f4L7uOt/TAAXYc4IGScWXpYncCKluEUmYq/JvrCFOdgSijoYjVmxudyW8TpF8gVa2582bc14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731133127; c=relaxed/simple;
	bh=DmhyKML5p5uyc9lw30xgAkik7ISJn6DGddaiJ31l+m4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=BYWuc5DRdE0VwWlTMa7Gqa+P34e7UjpAAkVDlbBdQjSTNTnlZuCiTwIHsSHO986EBP9Et2x5L/qt8dESJHz8vkZHatxn/xMQaUKYrGn12THD2TLyjz8B9ZPSiE/Txm3enwPrI2l2hzamsLQ9E/xeotluaQpzcKVNfkcQCd3hY9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bHCyNPeA; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e59dc7df64so35469867b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 22:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731133124; x=1731737924; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IOrkvPcvHjQedYd3c7yfUgCb4BbIK+zJ8VChcGJxjag=;
        b=bHCyNPeAWm2xGOvuTnrtTRm+1j6k0Dw5XaeNhHC9gSr0m+4C8tmgtGdWs/JmCF1yk8
         5i7F7p64tqTc3s/w7b0F54KcycWPk7fcUZAePcjTbxdM/5aAHbjRQkD4zlIuygiTfdx5
         iR7SP/SgOqtD3Aq6UJtLnAJP3UfsM3IsUJU3yo4FzxUXfwxc48gR3eJOidqg4cwNCcpr
         LZtxYqgo29KHwdEhWw2eezEU99UKutn6+aqUNhTvu30McCYxQb1qC2So2glg1lICNOiE
         x4gImp6f5WHlz0svnLdpDGGYRbIHzI7bPqVmIE30zmqCFGI7bbLDdypH4Kar7DpiLPb1
         n7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731133124; x=1731737924;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IOrkvPcvHjQedYd3c7yfUgCb4BbIK+zJ8VChcGJxjag=;
        b=FDWhUkjuqRR22C5oL4PauDCv63iCklz9MRc8acePgPHH/ne+vqA+nMT69k+XkXhQsY
         Tc36xYkILl4qt2rwtxHlADEqqRQ8pFNpAJzHeGWkDXTpH8v7/f6e6ART3jwKkfqwBhkI
         S3ltC4V7vd74cnNfc+9am76OXIX1jtEEPWnmjbcobzbU4lHJwTwgPOPEmtyqEhONvc19
         1bTCP3/7GPZPaEpf11joTYIfhWw3hIqVhS+3iEKqiJrQdA2bUKhv8TNcI52oZ5XTAfPk
         QeWpPCbjf6qG3RIcKAfPzaF4HkxQOeC4F3s7w+7+qnvtCH6/K65fMGLP19R+kGduQKgd
         NYLw==
X-Forwarded-Encrypted: i=1; AJvYcCWXWX8FHLtrB6glBhBEN3YV89yaZfiF66SY0n6qXZBCXLudqopQINgK6iZjiSJfezBpq2aRq+z4o0dAnF0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws3AycX5t/AKV5Gdp7sw1OLCD4cIeDPQqU34Q3AiERgs177OFF
	gMY7uE1Z0hxO+CntuWcjWDO90PpkKcr1RGxQgYoDrESj/3KurC7Dug4n1USO1A7S4HBVro+MJOS
	UHFFUow==
X-Google-Smtp-Source: AGHT+IHac+QX1KxOp8UsOxuSd1Rqf23eoUA4r9Vn5FImDMoRE/tizKeMfe7trdWWCoUnRf6amqqkLOLu5pII
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc2:d48f:a998:5915])
 (user=irogers job=sendgmr) by 2002:a0d:c302:0:b0:6be:523:af53 with SMTP id
 00721157ae682-6eadc114281mr562767b3.3.1731133124450; Fri, 08 Nov 2024
 22:18:44 -0800 (PST)
Date: Fri,  8 Nov 2024 22:17:57 -0800
In-Reply-To: <20241109061809.811922-1-irogers@google.com>
Message-Id: <20241109061809.811922-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241109061809.811922-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v6 10/22] perf script: Move script_fetch_insn to trace-event-scripting.c
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
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Add native_arch as a parameter to script_fetch_insn rather than
relying on the builtin-script value that won't be initialized for the
dlfilter and python Context use cases. Assume both of those cases are
running natively.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c                       | 15 +--------------
 .../perf/scripts/python/Perf-Trace-Util/Context.c |  2 +-
 tools/perf/util/dlfilter.c                        |  3 ++-
 tools/perf/util/python.c                          |  6 ------
 tools/perf/util/trace-event-scripting.c           | 14 ++++++++++++++
 tools/perf/util/trace-event.h                     |  2 +-
 6 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 11c0ee8c1afc..22d78a9d8f27 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1586,19 +1586,6 @@ static int perf_sample__fprintf_callindent(struct perf_sample *sample,
 	return len + dlen;
 }
 
-__weak void arch_fetch_insn(struct perf_sample *sample __maybe_unused,
-			    struct thread *thread __maybe_unused,
-			    struct machine *machine __maybe_unused)
-{
-}
-
-void script_fetch_insn(struct perf_sample *sample, struct thread *thread,
-		       struct machine *machine)
-{
-	if (sample->insn_len == 0 && native_arch)
-		arch_fetch_insn(sample, thread, machine);
-}
-
 static int perf_sample__fprintf_insn(struct perf_sample *sample,
 				     struct evsel *evsel,
 				     struct perf_event_attr *attr,
@@ -1608,7 +1595,7 @@ static int perf_sample__fprintf_insn(struct perf_sample *sample,
 {
 	int printed = 0;
 
-	script_fetch_insn(sample, thread, machine);
+	script_fetch_insn(sample, thread, machine, native_arch);
 
 	if (PRINT_FIELD(INSNLEN))
 		printed += fprintf(fp, " ilen: %d", sample->insn_len);
diff --git a/tools/perf/scripts/python/Perf-Trace-Util/Context.c b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
index d742daaa5d5a..60dcfe56d4d9 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/Context.c
+++ b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
@@ -93,7 +93,7 @@ static PyObject *perf_sample_insn(PyObject *obj, PyObject *args)
 	if (c->sample->ip && !c->sample->insn_len && thread__maps(c->al->thread)) {
 		struct machine *machine =  maps__machine(thread__maps(c->al->thread));
 
-		script_fetch_insn(c->sample, c->al->thread, machine);
+		script_fetch_insn(c->sample, c->al->thread, machine, /*native_arch=*/true);
 	}
 	if (!c->sample->insn_len)
 		Py_RETURN_NONE; /* N.B. This is a return statement */
diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
index 7d180bdaedbc..ddacef881af2 100644
--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -234,7 +234,8 @@ static const __u8 *dlfilter__insn(void *ctx, __u32 *len)
 			struct machine *machine = maps__machine(thread__maps(al->thread));
 
 			if (machine)
-				script_fetch_insn(d->sample, al->thread, machine);
+				script_fetch_insn(d->sample, al->thread, machine,
+						  /*native_arch=*/true);
 		}
 	}
 
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 3d938fe2de6a..22edadd64e5f 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1317,12 +1317,6 @@ struct kwork_work *perf_kwork_add_work(struct perf_kwork *kwork __maybe_unused,
 	return NULL;
 }
 
-void script_fetch_insn(struct perf_sample *sample __maybe_unused,
-		struct thread *thread __maybe_unused,
-		struct machine *machine __maybe_unused)
-{
-}
-
 int perf_sample__sprintf_flags(u32 flags __maybe_unused, char *str __maybe_unused,
 			size_t sz __maybe_unused)
 {
diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
index ad62d8e5a368..beac456260ae 100644
--- a/tools/perf/util/trace-event-scripting.c
+++ b/tools/perf/util/trace-event-scripting.c
@@ -13,6 +13,7 @@
 #include <traceevent/event-parse.h>
 #endif
 
+#include "archinsn.h"
 #include "debug.h"
 #include "trace-event.h"
 #include "evsel.h"
@@ -269,3 +270,16 @@ void setup_perl_scripting(void)
 }
 #endif
 #endif
+
+__weak void arch_fetch_insn(struct perf_sample *sample __maybe_unused,
+		     struct thread *thread __maybe_unused,
+		     struct machine *machine __maybe_unused)
+{
+}
+
+void script_fetch_insn(struct perf_sample *sample, struct thread *thread,
+		       struct machine *machine, bool native_arch)
+{
+	if (sample->insn_len == 0 && native_arch)
+		arch_fetch_insn(sample, thread, machine);
+}
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index 0520dd269374..0c5becc822f9 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -117,7 +117,7 @@ struct scripting_ops *script_spec__lookup(const char *spec);
 int script_spec__for_each(int (*cb)(struct scripting_ops *ops, const char *spec));
 
 void script_fetch_insn(struct perf_sample *sample, struct thread *thread,
-		       struct machine *machine);
+		       struct machine *machine, bool native_arch);
 
 void setup_perl_scripting(void);
 void setup_python_scripting(void);
-- 
2.47.0.277.g8800431eea-goog


