Return-Path: <linux-kernel+bounces-413675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A3A9D1D1F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 02:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0BAD1F225FA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 01:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96C112AAC6;
	Tue, 19 Nov 2024 01:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2jLXeoiY"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705821494B5
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 01:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731979069; cv=none; b=bZLLV5oy6s5xffzqTfQ4hSIxsID6ft5e73sxE4IFB3GrNj1i/txPQvRUb/PsP/7Wl0hYi9hz8vqtfhuU/q4gB5kvvp+3WEtdUIJc+3Ce83piQu+w0oaRnZjCxMoA1Ei3bL32Jxp9YoY/EyXxF+/IyTZ0eTP9p6dxu+C6rfXgSWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731979069; c=relaxed/simple;
	bh=mJSrPca5xu9Il6Rd7sHhJRBEViSSDCLuBHlUxLuMNgc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=p4vd95p2niGyWb4OssKYfaGd5DxsdkOUIi5TspEYB1VoqV57SHKQ/ziGWx9LEpaxWw5lu+qVrBa/X0YknQyIB91qxQHgZb+q9PlKVxi+XEDBV+pNJrTEAaaCwOL87tPI2DkWND7Q2QktVrL+BBiJGQiZdAV6Mg/qczAZJC0PJW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2jLXeoiY; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea8794f354so35943097b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 17:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731979065; x=1732583865; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eCE4YtIOIkBMj88bSVv4YKfyltH3locf0NanFOHXWYE=;
        b=2jLXeoiYhWGPfj5xpQky69r0Ii3Dac6G1CuUAaQVeJtpUGBqbD5NQxaz6vvMPupKWv
         pMYYB11rgaF9iOsBHzXzLjFDfAPqeN/vM+ammf+5Kcgs/oxSCHz2orNwLgzfSE5rUzZS
         R8NSEpBS4o6SmB+TcDNXTOhxfXC6gwimKYeNi4KXlNQ0vQuptdoWwKRP+apSvL6eZh/R
         MgGRQzo4ur9iWrGfRl5iCQ+OYagy5085HYBKJ0Vrm1logmW9h5lkVnfxBQ3wjwnjPnfq
         IPjR5SR+i3dNIFfXbhwPkI7YPGIVhhPsRpw3ltxcwiRIvVUyPZDU8kM0F0+P1uwcdx/m
         ekUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731979065; x=1732583865;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eCE4YtIOIkBMj88bSVv4YKfyltH3locf0NanFOHXWYE=;
        b=k/Q1l8OrsuZjZEkzF3+6VZZ7BgsJ6xLK1m5NJAC2bTwKdX29XgFiUsRUYHlblyfEnQ
         qmm50TFwyn2ejcGOXS/6/jc4V/Wv+LnL3KeIF9fRuaBYTzVaPnkGbJ0m2lgQiklQyXRU
         Oaaa7ARHYfS++PaeJyxDaNJQNvWBkPo6mg7HFyZdAwSE2JOtQ+SQytLnE7wLZlA2m30L
         Y1DF+cK+BOlGOkvDAjbyiMHHKrHgemsUNMMrdc27pJjx/pX/9BnB2g0iH7pwZ7JwpNWF
         TZa/zOQpU+NnYTpNC1/Gc/3WVu2qgj3FCpAHbRD3STSk30XcEqFaUV4yd7j35zcIDl+8
         2bdw==
X-Forwarded-Encrypted: i=1; AJvYcCUDAgajzzpO4SU3/OpnTiRuqykhX/v38lMVgOt0l0EjNhKwPKV2VAMRuy8oRrhlipo+AV5C2pkxccpiUM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhvTWFtUqfz2p4jNXH+0P/94YgRX2UTYOxkQsd1c10iHmkf+PZ
	op7cVWQORbGaqf+vK5fT2HkpCU8vnpzcOgfMYzeE2ugmXeKoGh66WECf9i0oiP3H/CvNMv9aitr
	XnudD3Q==
X-Google-Smtp-Source: AGHT+IEOeFgVhKuEfshpZnlgHDjT1x9lft9uTCt8rPStqD2MYO/b9X3X43p9ST6WusPaV/SusARyQ27Xsuep
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:22a4:ded5:5c37:fcc7])
 (user=irogers job=sendgmr) by 2002:a05:690c:80a:b0:6e3:14c3:379a with SMTP id
 00721157ae682-6ee558cd218mr1669157b3.0.1731979065532; Mon, 18 Nov 2024
 17:17:45 -0800 (PST)
Date: Mon, 18 Nov 2024 17:16:32 -0800
In-Reply-To: <20241119011644.971342-1-irogers@google.com>
Message-Id: <20241119011644.971342-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241119011644.971342-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v7 10/22] perf script: Move script_fetch_insn to trace-event-scripting.c
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
index b4deae110dbe..035ce4bc1d22 100644
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
index d157aaa4bb53..3ade7b05def2 100644
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
index 4b7f0592850b..ea32f89b9889 100644
--- a/tools/perf/util/trace-event-scripting.c
+++ b/tools/perf/util/trace-event-scripting.c
@@ -13,6 +13,7 @@
 #include <event-parse.h>
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
index 29cae98695c9..88b178ecab80 100644
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
2.47.0.338.g60cca15819-goog


