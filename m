Return-Path: <linux-kernel+bounces-387780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B344E9B55FA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C04C81C222F6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 22:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4FD20E02D;
	Tue, 29 Oct 2024 22:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qGm0XGpX"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAFF20D4FC
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 22:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730241903; cv=none; b=QhIQG2IK7rL8rXUXoXAxUEYzjSVrpgqRptRSb1noS5iS7zfy0eBkbyVXnIpWPkzuQmwDI7KiCnNTaP3Lbj4w1Gj0XPatiJNLAyTQmzGhEUWHe0NN3M8ZSG6mj5Rqh4puK4AMslTGRIf26QfcJqFZ6igXk7mYzqwDWK5TEAGSa08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730241903; c=relaxed/simple;
	bh=2RLqSBB/TH3eqXmo+uvGIzA+Ahy1X4l+jKCnNyaVyG0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=oyOdQ5JCSK6iiytGCIcfrHFpM6e4MM1sQYnUb0+iVOj1KnXe4YNyoCb7X36G+J7f7Rt8zHwiHMJxZk3Sx+kkJb9YGysQAZ3A0vYmC48S4JyoxLRe4nFcp10AY1aWd1/zU5zDSL0TKwVxDZ3q5w8ynf/kuG5l6+Wl7ssFabJey4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qGm0XGpX; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e5bdb9244eso100030307b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 15:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730241900; x=1730846700; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YFooUYpvA2QCgKuBD+acIjpV9rrKINB0QYlfb7ETy8k=;
        b=qGm0XGpXxx1ndJAnoMYD42M4xEKYKHRctuOOQezjJ/hz9vxdxPDC0uejnDlHGE/GpQ
         2reQbYzZkL/mkAgChT5X22tA7wGt6byKvmlRP9Q3OhZy2TKAEHm/vuS3WAL3d2TBUUjO
         GoJZhSj9DVcY4DUE6MZyvST0z/KWAiOfF4mGFE5tkDIt3ACqtOVNEPccSNpy8voHzPbF
         6ORybBJuxLk17V3odMlCl1WeOis04rALBfwoxGDSbRyMgZrsPDkwGOUF1WQ6KhrQQ0vR
         mEdQT/Ow5xXrCUvJFX7xYF2waa4JkHN6lBorEEbiuhGxEXdsD3tGKdIHV8toJzVI4lQ9
         KPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730241900; x=1730846700;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YFooUYpvA2QCgKuBD+acIjpV9rrKINB0QYlfb7ETy8k=;
        b=eabvfOFojzrbCuKofpOQd8WnQrDkIDaGD2DbgKeC0syzQlbcsR/ln8YLiTpWEu1glv
         L4Dhak9Ss/c/LKMdUehN2c4VQ2f6lPLWVBscMLTvg7uUvxPDrGOI5aXEYvI/0/0O8gvu
         E9XzQ6ZSHTQHZ4ANKkRHulRtwdiIqWyAcehrqXB9Uc4epTQ06VZScp9/ifTqMs/bk6nM
         m/YIJQwqm0eKFrGtlhyVNr2jAxw30pEgA/EQO9SByIi7COqd2Du28aIN4wG/IUID4LiU
         83OHf+fV/R4byrb4kv2MiDU04lM616I5gLJoBma+FQWWpuXpz1DgW1TwbCcXUQzXpQsr
         TtRg==
X-Forwarded-Encrypted: i=1; AJvYcCXck9ERcbo9XhVX7A1zgdS6k39VACIBx437uITRCzedSXDwlf3hFQRigx00mWTPHEgohTkCjz7BUYMXEu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwSNRQQwGeB6PxyqVmpQMo2YOM0kNDh+w2QckC3gRYzR4/pGJX
	h8dQdiz1amCf4uf40HOhfutUoNR/D3PRjH8xfKhdEI43IEXDyKrmihwSnZt/IokPcpooPxOlKQn
	qHuun2w==
X-Google-Smtp-Source: AGHT+IHsda3l+iVF5g+/UtdYvrqebD+bSxw3aG7nkMqoFu1dOTOBjYF7ur1twgDhzThChjiw9T8T+2Jya7DT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8991:d3fd:38a7:c282])
 (user=irogers job=sendgmr) by 2002:a05:690c:4b0d:b0:64a:e220:bfb5 with SMTP
 id 00721157ae682-6e9d88ad9a3mr7734307b3.1.1730241899913; Tue, 29 Oct 2024
 15:44:59 -0700 (PDT)
Date: Tue, 29 Oct 2024 15:44:22 -0700
In-Reply-To: <20241029224431.167623-1-irogers@google.com>
Message-Id: <20241029224431.167623-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241029224431.167623-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v4 10/19] perf script: Move perf_sample__sprintf_flags to trace-event-scripting.c
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

perf_sample__sprintf_flags is used in the python C code and so needs
to be in the util library rather than a builtin.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-script.c             | 80 ------------------------
 tools/perf/util/python.c                |  6 --
 tools/perf/util/trace-event-scripting.c | 82 +++++++++++++++++++++++++
 3 files changed, 82 insertions(+), 86 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 3311104afd0a..1eda065dcb2b 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1693,86 +1693,6 @@ static int perf_sample__fprintf_bts(struct perf_sample *sample,
 	return printed;
 }
 
-static struct {
-	u32 flags;
-	const char *name;
-} sample_flags[] = {
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL, "call"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_RETURN, "return"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CONDITIONAL, "jcc"},
-	{PERF_IP_FLAG_BRANCH, "jmp"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_INTERRUPT, "int"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_RETURN | PERF_IP_FLAG_INTERRUPT, "iret"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_SYSCALLRET, "syscall"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_RETURN | PERF_IP_FLAG_SYSCALLRET, "sysret"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_ASYNC, "async"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_ASYNC |	PERF_IP_FLAG_INTERRUPT, "hw int"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_TX_ABORT, "tx abrt"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_TRACE_BEGIN, "tr strt"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_TRACE_END, "tr end"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_VMENTRY, "vmentry"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_VMEXIT, "vmexit"},
-	{0, NULL}
-};
-
-static const char *sample_flags_to_name(u32 flags)
-{
-	int i;
-
-	for (i = 0; sample_flags[i].name ; i++) {
-		if (sample_flags[i].flags == flags)
-			return sample_flags[i].name;
-	}
-
-	return NULL;
-}
-
-int perf_sample__sprintf_flags(u32 flags, char *str, size_t sz)
-{
-	u32 xf = PERF_IP_FLAG_IN_TX | PERF_IP_FLAG_INTR_DISABLE |
-		 PERF_IP_FLAG_INTR_TOGGLE;
-	const char *chars = PERF_IP_FLAG_CHARS;
-	const size_t n = strlen(PERF_IP_FLAG_CHARS);
-	const char *name = NULL;
-	size_t i, pos = 0;
-	char xs[16] = {0};
-
-	if (flags & xf)
-		snprintf(xs, sizeof(xs), "(%s%s%s)",
-			 flags & PERF_IP_FLAG_IN_TX ? "x" : "",
-			 flags & PERF_IP_FLAG_INTR_DISABLE ? "D" : "",
-			 flags & PERF_IP_FLAG_INTR_TOGGLE ? "t" : "");
-
-	name = sample_flags_to_name(flags & ~xf);
-	if (name)
-		return snprintf(str, sz, "%-15s%6s", name, xs);
-
-	if (flags & PERF_IP_FLAG_TRACE_BEGIN) {
-		name = sample_flags_to_name(flags & ~(xf | PERF_IP_FLAG_TRACE_BEGIN));
-		if (name)
-			return snprintf(str, sz, "tr strt %-7s%6s", name, xs);
-	}
-
-	if (flags & PERF_IP_FLAG_TRACE_END) {
-		name = sample_flags_to_name(flags & ~(xf | PERF_IP_FLAG_TRACE_END));
-		if (name)
-			return snprintf(str, sz, "tr end  %-7s%6s", name, xs);
-	}
-
-	for (i = 0; i < n; i++, flags >>= 1) {
-		if ((flags & 1) && pos < sz)
-			str[pos++] = chars[i];
-	}
-	for (; i < 32; i++, flags >>= 1) {
-		if ((flags & 1) && pos < sz)
-			str[pos++] = '?';
-	}
-	if (pos < sz)
-		str[pos] = 0;
-
-	return pos;
-}
-
 static int perf_sample__fprintf_flags(u32 flags, FILE *fp)
 {
 	char str[SAMPLE_FLAGS_BUF_SIZE];
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 22edadd64e5f..77e02fcc51dd 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1317,12 +1317,6 @@ struct kwork_work *perf_kwork_add_work(struct perf_kwork *kwork __maybe_unused,
 	return NULL;
 }
 
-int perf_sample__sprintf_flags(u32 flags __maybe_unused, char *str __maybe_unused,
-			size_t sz __maybe_unused)
-{
-	return -1;
-}
-
 bool match_callstack_filter(struct machine *machine __maybe_unused, u64 *callstack __maybe_unused)
 {
 	return false;
diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
index 543e78b17e5f..1734967d7f70 100644
--- a/tools/perf/util/trace-event-scripting.c
+++ b/tools/perf/util/trace-event-scripting.c
@@ -15,6 +15,7 @@
 
 #include "archinsn.h"
 #include "debug.h"
+#include "event.h"
 #include "trace-event.h"
 #include "evsel.h"
 #include <linux/perf_event.h>
@@ -285,3 +286,84 @@ void script_fetch_insn(struct perf_sample *sample, struct thread *thread,
 	if (sample->insn_len == 0 && native_arch)
 		arch_fetch_insn(sample, thread, machine);
 }
+
+static const struct {
+	u32 flags;
+	const char *name;
+} sample_flags[] = {
+	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL, "call"},
+	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_RETURN, "return"},
+	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CONDITIONAL, "jcc"},
+	{PERF_IP_FLAG_BRANCH, "jmp"},
+	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_INTERRUPT, "int"},
+	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_RETURN | PERF_IP_FLAG_INTERRUPT, "iret"},
+	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_SYSCALLRET, "syscall"},
+	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_RETURN | PERF_IP_FLAG_SYSCALLRET, "sysret"},
+	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_ASYNC, "async"},
+	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_ASYNC |	PERF_IP_FLAG_INTERRUPT,
+	 "hw int"},
+	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_TX_ABORT, "tx abrt"},
+	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_TRACE_BEGIN, "tr strt"},
+	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_TRACE_END, "tr end"},
+	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_VMENTRY, "vmentry"},
+	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_VMEXIT, "vmexit"},
+	{0, NULL}
+};
+
+static const char *sample_flags_to_name(u32 flags)
+{
+	int i;
+
+	for (i = 0; sample_flags[i].name ; i++) {
+		if (sample_flags[i].flags == flags)
+			return sample_flags[i].name;
+	}
+
+	return NULL;
+}
+
+int perf_sample__sprintf_flags(u32 flags, char *str, size_t sz)
+{
+	u32 xf = PERF_IP_FLAG_IN_TX | PERF_IP_FLAG_INTR_DISABLE |
+		 PERF_IP_FLAG_INTR_TOGGLE;
+	const char *chars = PERF_IP_FLAG_CHARS;
+	const size_t n = strlen(PERF_IP_FLAG_CHARS);
+	const char *name = NULL;
+	size_t i, pos = 0;
+	char xs[16] = {0};
+
+	if (flags & xf)
+		snprintf(xs, sizeof(xs), "(%s%s%s)",
+			 flags & PERF_IP_FLAG_IN_TX ? "x" : "",
+			 flags & PERF_IP_FLAG_INTR_DISABLE ? "D" : "",
+			 flags & PERF_IP_FLAG_INTR_TOGGLE ? "t" : "");
+
+	name = sample_flags_to_name(flags & ~xf);
+	if (name)
+		return snprintf(str, sz, "%-15s%6s", name, xs);
+
+	if (flags & PERF_IP_FLAG_TRACE_BEGIN) {
+		name = sample_flags_to_name(flags & ~(xf | PERF_IP_FLAG_TRACE_BEGIN));
+		if (name)
+			return snprintf(str, sz, "tr strt %-7s%6s", name, xs);
+	}
+
+	if (flags & PERF_IP_FLAG_TRACE_END) {
+		name = sample_flags_to_name(flags & ~(xf | PERF_IP_FLAG_TRACE_END));
+		if (name)
+			return snprintf(str, sz, "tr end  %-7s%6s", name, xs);
+	}
+
+	for (i = 0; i < n; i++, flags >>= 1) {
+		if ((flags & 1) && pos < sz)
+			str[pos++] = chars[i];
+	}
+	for (; i < 32; i++, flags >>= 1) {
+		if ((flags & 1) && pos < sz)
+			str[pos++] = '?';
+	}
+	if (pos < sz)
+		str[pos] = 0;
+
+	return pos;
+}
-- 
2.47.0.163.g1226f6d8fa-goog


