Return-Path: <linux-kernel+bounces-367243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DA59A0028
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 06:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57D5D286EE4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 04:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5FF18DF69;
	Wed, 16 Oct 2024 04:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k21fa+Qr"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD47918CC01
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 04:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729052698; cv=none; b=p8uGBmns8BEdIthkJh7jEQ4g/LWFI/ImIR1Nux7NvEd8uKeHptEqtmB4ml+9g8y+cMNwO0mnmQWZFD6wfCbKH0xDiw+Ti4wKvNDl5js50bvlJg4HANb9DYy5yhwfkO7qgKNYeIo5Hmcr3wBirYRukgcRIq1yuvnphjZs0a2/IP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729052698; c=relaxed/simple;
	bh=cZb5xvuzqqa8/zADFxb6PqvGhOFZ4T95f/Rcci8bRQI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=RbKK/LMesvqIXYlsPsnJNbmGLabNThfriOI1rLdh7Rgkkdeo5FzVN4FXNLIb1sFJf45rm+CL/5z2t9gWaGJUexePaukBg097J0kuW9XGSFBpUS4KOeTr1oBsBbZEVjTPtbNRfUf+sl/6TwxVp6j2ixst7Hy40Jp/xFlpxh85Ps4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k21fa+Qr; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e28ef71f0d8so9894988276.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 21:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729052696; x=1729657496; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aUanJd9R6GPljwzcW3pIhRSAGsTkrn8IEGI+GvcCVuc=;
        b=k21fa+QroCXwTxf+J0PR1Z1Z2A9elPgdUb894ffPo+gd8tyeq+ZiUY0lTl9oiBKdxJ
         ElaWMymQZdKrtZFzgMqOQ/2v3B4SC7WbXG0z17uxuSuKQffh+I7yd26zg5qYbMeBmIju
         KH9G5mRRT1CWspjsaL6DB5cBewQH3rP18c82JvSZ8Nw7TwiExsKmoEnruixxwhhcL/7d
         KCnie3h4akIUgVkzZaETGMOEQaT2xEK9X2s0J54IsXNvQ5R+HI6G4bPC06644awfVfvg
         ERVrWqMIQ4Jn1A4qvgYutyy9w4fxvrQeHUh3UiFkIBORN6VtbH/khlZCvpTvQgea4kIb
         NTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729052696; x=1729657496;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aUanJd9R6GPljwzcW3pIhRSAGsTkrn8IEGI+GvcCVuc=;
        b=IORNFiKxjAcUgn6jKqvnV/1L5FIM7Ncaw17DdsGwrjvNcfKV+52Xb1wCaobTAUX2m+
         P3TwJKaEqZEVB3Ef0nPW0hHKaHK7QrF2g1MxWduHRzRQixpd68mmta2emcEWnHWLMtE+
         BRj+TXKXqRkSlI7o3pln+kBC7hyLrXJPdHZS/rGbyBSIaPrYr+Bp1iPf+2A3PwgsfD/v
         Oqzbk8vDskYvjS4te/Ubnf2jxrbZnNmGpQJC7G4TyOs+bXFhcXJ6ZtTHIhUplQpyL3Sq
         T0vrzFYYS9tafbJc+iaqbL4wQpkDrqG8TXDuShdh2TR+NN3Gr4X9tYETTcMgW6ikrDle
         PAxg==
X-Forwarded-Encrypted: i=1; AJvYcCUVXCGZtT9LhLvi5iApIJvIivEZ/kyDxGScjPPsi+7ytzsI+Wm7K3uw2WTcjseG58zr4P4/jEq0MUKDrJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxleWV0NrIz2GV8lLCa4POj7P9q7ts89TxP0k117NjCsvTTBEHI
	j7L0jn3Zu4yseIvU3J87qk40hISK1/55R4n1jkTWkS5kxoAfeg6r7nlut+WsFi4SZpJ+a6loCK4
	alo/uzA==
X-Google-Smtp-Source: AGHT+IE92oRUPfuRbjJX6fYqcZzWlqLUcLAT0RFlIRttpeNClwYVe3iHPPYhGgfCJxJOyvIG3xK8nBaMc8sV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a25:ad64:0:b0:e16:68fb:f261 with SMTP id
 3f1490d57ef6-e297830baadmr1307276.5.1729052695722; Tue, 15 Oct 2024 21:24:55
 -0700 (PDT)
Date: Tue, 15 Oct 2024 21:24:08 -0700
In-Reply-To: <20241016042415.7552-1-irogers@google.com>
Message-Id: <20241016042415.7552-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241016042415.7552-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 09/16] perf script: Move script_fetch_insn to trace-event-scripting.c
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

Add native_arch as a parameter to script_fetch_insn rather than
relying on the builtin-script value that won't be initialized for the
dlfilter and python Context use cases. Assume both of those cases are
running natively. Switch the weak arch_fetch_insn to being guarded by
ifdefs as weak functions are outside of the C specification.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-script.c                      | 15 +--------------
 .../scripts/python/Perf-Trace-Util/Context.c     |  2 +-
 tools/perf/util/dlfilter.c                       |  3 ++-
 tools/perf/util/python.c                         |  6 ------
 tools/perf/util/trace-event-scripting.c          | 16 ++++++++++++++++
 tools/perf/util/trace-event.h                    |  2 +-
 6 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index b838470657d4..63a00dad02c6 100644
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
index ad62d8e5a368..543e78b17e5f 100644
--- a/tools/perf/util/trace-event-scripting.c
+++ b/tools/perf/util/trace-event-scripting.c
@@ -13,6 +13,7 @@
 #include <traceevent/event-parse.h>
 #endif
 
+#include "archinsn.h"
 #include "debug.h"
 #include "trace-event.h"
 #include "evsel.h"
@@ -269,3 +270,18 @@ void setup_perl_scripting(void)
 }
 #endif
 #endif
+
+#if !defined(__i386__) && !defined(__x86_64__)
+void arch_fetch_insn(struct perf_sample *sample __maybe_unused,
+		     struct thread *thread __maybe_unused,
+		     struct machine *machine __maybe_unused)
+{
+}
+#endif
+
+void script_fetch_insn(struct perf_sample *sample, struct thread *thread,
+		       struct machine *machine, bool native_arch)
+{
+	if (sample->insn_len == 0 && native_arch)
+		arch_fetch_insn(sample, thread, machine);
+}
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index 81fceaf297ba..e0bb42e6509e 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -120,7 +120,7 @@ struct scripting_ops *script_spec__lookup(const char *spec);
 int script_spec__for_each(int (*cb)(struct scripting_ops *ops, const char *spec));
 
 void script_fetch_insn(struct perf_sample *sample, struct thread *thread,
-		       struct machine *machine);
+		       struct machine *machine, bool native_arch);
 
 void setup_perl_scripting(void);
 void setup_python_scripting(void);
-- 
2.47.0.rc1.288.g06298d1525-goog


