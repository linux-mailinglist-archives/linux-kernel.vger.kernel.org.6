Return-Path: <linux-kernel+bounces-387779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A050B9B55F9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 618CD283F73
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 22:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F4C20D511;
	Tue, 29 Oct 2024 22:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O2a3Dhgh"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B7820CCDD
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 22:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730241900; cv=none; b=rcTUXAHJC7yi2qlquL12qNoWS6Bepbhl3X/m5PYsYWVwml7cG4+ufMskvR63QDSFnD3ra/lmUKO9PH2MrIHnoDQILqpQ9T5hyZyDr3KA8r4cw1afVHWet8Pdgj7+MzHFIefo0WI1WicZbaW5INOwnWloNIdoSnU0OOiOjzEE7wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730241900; c=relaxed/simple;
	bh=aO36UEaQorN0wJLMM37nAL3q1wmtiUXsxaeDEmj3NUw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=X9ycdbgxWDjROcCg2jsOkvDyHLp1lJ2MJquyXConcW09vOa0eRWykKfFvmLDvLRnIWK+KNQd44shtK9I0Uw2lZkU+IppLkpb987iWsEzY0Plh4fKQ1BWZhGsZcEDBvs3jXIXk5SHKnjtqHn6mv4iTwGCi60Z9GF+FAOXSQAGzKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O2a3Dhgh; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2946a143efso563301276.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 15:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730241897; x=1730846697; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FvsfdXmE5fY3ABkdgbstYkDwSen4YCtrrcTKLwjDguU=;
        b=O2a3DhghehHUDvLgsOoqrIorjzgMkSp4ffMRxTJ2nbmXLBDODzOQUKRC1Qg9QP+8f9
         Fakiu/rvL5Ko3OEt8mGon1plQp0yrvcdMdYz0AkY/xlXIrDnCJwyt+s5lkynNj0r3iFu
         5t1IjguoiPN1EbREuM2gamIBFuT5PChKmmexuOId+kgt/0JkhyZRdun9IrjwC4Xn5J2K
         6RboSO9yakumnl14Fylbp3fkjhJ7FjBmCkSlK6p73Tcubb2G5rOv3Ih2NkN0wZz/78tL
         Dcz10glCT5jOcPAfLjnGgLYFQxJ1eXOkn1JuAOKkk+wJGQbFrrzt9LqUSbkgIhf2Xr9Y
         NSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730241897; x=1730846697;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FvsfdXmE5fY3ABkdgbstYkDwSen4YCtrrcTKLwjDguU=;
        b=VpmIY/DQ6liQrMsZzc0emWSF3bOEvGO5+RrE0LmVoHUmJBO3crfNfnoeaw9vmcoy6R
         +ucu00q0Ei5BeuvuiWqF4lRsELly3VuP14AtNUDNt9zMWak40d17vJARiSGElNfIPjU0
         tQW7yPtpGG5p26VmY/OU3nispsFFaPF8ZRnwyF2Ee9WWcXYYvgnkyVkpLBnhDX3X9ryY
         9mdiGaJm++fGox0+ClYWYXo8LDYfkxSASXrILF4snKO8PJL99NrrkHtIS1oqNPIv1U0R
         +n9Vd5EGMmpcwV+Rc8qi5CQEP7b6hDBJFzMolWunQCI45NSYbsgYDk9nva0DlZB9/0zW
         zaUA==
X-Forwarded-Encrypted: i=1; AJvYcCVSz+tBFy+VB1jSLYlLNmgUtAKImi7c82HE2bgTSSpN1rTIvMUE2svHqRN6UwhKJ2cTENNSLIkVqiLFjd8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9vzy1qDZGqVtRQqyhiezp8FHUewdMPtMpSzEPXKlyaOEud10q
	y+Zt3GwNa880NSZljGWZqfM5/7axDKm5fjo/hxEUNKfNu5iw4KS4JTiwosOJtR1M7f0El3OTVs7
	3Jms+Jw==
X-Google-Smtp-Source: AGHT+IGstHnLW42vEOqpPUHHb62KZ5zvU+TpLx+NqShj3UN3ugCJjQb7yQN51h7FfvP1Wb6/qwNtUOAB8GF8
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8991:d3fd:38a7:c282])
 (user=irogers job=sendgmr) by 2002:a25:8241:0:b0:e2b:db24:905e with SMTP id
 3f1490d57ef6-e30c1a27054mr33196276.5.1730241897313; Tue, 29 Oct 2024 15:44:57
 -0700 (PDT)
Date: Tue, 29 Oct 2024 15:44:21 -0700
In-Reply-To: <20241029224431.167623-1-irogers@google.com>
Message-Id: <20241029224431.167623-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241029224431.167623-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v4 09/19] perf script: Move script_fetch_insn to trace-event-scripting.c
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
index 93caaad62be5..3311104afd0a 100644
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
2.47.0.163.g1226f6d8fa-goog


