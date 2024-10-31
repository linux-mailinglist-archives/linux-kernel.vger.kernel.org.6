Return-Path: <linux-kernel+bounces-389847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD109B7221
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 02:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E212866CF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 01:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5455823D1;
	Thu, 31 Oct 2024 01:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YiKwCkra"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C164213B590
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 01:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730339021; cv=none; b=l7o+LgeFS15AOf4NcBYFhrOHQUoYgb/FcuBDRvp+Eo1w4WXYDYdUaoELtVqm74E8OSP5SfgGDLc8BmGY67jHbKyMhtAUCvdm2iaIbcBwew5QCRtNAlNc4nFnGl+YwzG1pEIJlfuq/zzEp/uPZFDaBd9Mtn6P+Snh3gLC9SJi4Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730339021; c=relaxed/simple;
	bh=K8MBywRM9VYie83K/Ge+IX+DJ5KQde66JpktMNcoH1U=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ewyr6jr96b8aS2Brl8JmvfSEutIglwrA/kYqOKr1hpGi0zweizLElqMlc/YMSWIzNRvyUXCHmNOTUVp+0EKB66zADCXrdpd1BJLxwKf0vdbbNKtVbgPyJXw4jJobBbapP+5pU8SGIhmiThtBLOAHercQ0iBokmDJs5NmovdfyrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YiKwCkra; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea258fe4b6so9127887b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 18:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730339018; x=1730943818; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R0Dg3ZC4eOFcXD0FKfDkQR9jWSBdCYfi1JBGipnV6Sk=;
        b=YiKwCkrazEkPHk8+2C4h6asLcccUCivPoTiT5guHdGMPfZNIWLgnVJEBAGxtbin1Vo
         qdAbKFE6bziR1umpvfJQOwkSZjd0ICnfTvkrcfRxeBnUv65gPqPMOOEeMS8zy5Oh7dBh
         nxK309cRnlc/9wdvJaadrlEkQRDpTKS4X7dCdLH0ZTjM0tZRzeog5r5+d7zlp15AiBZ4
         R7zQdLGfJ+X84ap608R11WPYoV+maBoPsC7qNB4JoL8jABCx9hhKecgRlX6p/iDJlui5
         RBhQ3I/QCErnHXTwVUqCnaUojtMJPETcIReuz+xarqo2c5GGNy640gz1+/5v3DtewJK9
         fkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730339018; x=1730943818;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R0Dg3ZC4eOFcXD0FKfDkQR9jWSBdCYfi1JBGipnV6Sk=;
        b=WUyroWCUvWjtdW86CZ+JB2nHQQL5Gknua6AXrsFlRCjqBTUjpGHTArbRr73j9hACm9
         5vHXyHa8TFN2FxyNbWSkhnGrI1wqoG1COR39sVHXHATF28tCrwVddb/m2BjoJnu/ZuX2
         end5EHKxeyumoVJSs1Y7PLzqe06vmZub2GuO0KlIV3iaaAs+WupP66UfnaElR9hOuZhq
         rV8CR+phG7Ry+05Z/i40TVZlmWG1+AP5MoYWMXwaABtLgjarELK0OJ1hsFZJgYvLOSRf
         1gjWyA4yQerk344ydxPeJpviSaLqxG9wbJRwSo5a72sCPZJG5yPvqTGgryvMe9ovRgDR
         2NMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlbmHTJx93731qUmFROntkmLQkZRih7jXiyXml+gTPEzCe44ZlBo6rLV0ZFR2VWtxamCq7JBTzRIi4xiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAACqsABviHvDTMwoyWpK+IpZe/4pMBoD3/YnSGwwP2d2WNWXO
	oDUv+aSPkHhcS/T+Qun2vtb2Nrzy9bm0jkysRitA9+OkWTDeVGCjbHPruhPN908nPECgddUww8S
	fOUYKRg==
X-Google-Smtp-Source: AGHT+IF1rP5Msd1P6O0UYnEIUmpAMH6Jbste9JWLyi8Wl1w59KncQO0H7ERpr3LZu+N//L79UZ/6voNz4uwo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ad0f:67e7:f1a6:84c4])
 (user=irogers job=sendgmr) by 2002:a25:4b85:0:b0:e29:68a9:8612 with SMTP id
 3f1490d57ef6-e3087a54ccemr76572276.4.1730339017743; Wed, 30 Oct 2024 18:43:37
 -0700 (PDT)
Date: Wed, 30 Oct 2024 18:42:40 -0700
In-Reply-To: <20241031014252.753588-1-irogers@google.com>
Message-Id: <20241031014252.753588-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241031014252.753588-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v5 09/21] perf script: Move script_fetch_insn to trace-event-scripting.c
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

Add native_arch as a parameter to script_fetch_insn rather than
relying on the builtin-script value that won't be initialized for the
dlfilter and python Context use cases. Assume both of those cases are
running natively.

Signed-off-by: Ian Rogers <irogers@google.com>
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


