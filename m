Return-Path: <linux-kernel+bounces-402694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90ECB9C2A90
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 07:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51CB1281DE2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 06:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A28C156F34;
	Sat,  9 Nov 2024 06:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jTLmBXKv"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49CF14D2BD
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 06:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731133129; cv=none; b=HkG5CYdS/cl80sFvkJtoV0kID0TjbFPCH43VISvwYkvieuWrUoxSSAxl9kTYIMjffYFNZ5hBI66J0R0TQO3vb3q4AYFJo0n/J1SnaLA1Ntckl6oEazZxvIHHFA7hJIRL8rWFfVap/ecBnUrjgjx2bAmD1pSSScgT5NUWDMavkec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731133129; c=relaxed/simple;
	bh=Augzyo1sYVN9zYVhVZ4NaRoQNcTkw/sM8pJhd9s/eM4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=hvc3eOlbUlE5YuKSNrRxhp6/Gapij1DfJ5VDIAbR3DxLi5SR9IM54U6UxV/GdFyTjF9mUVAt2n+NVp7qlYs8UqutPrgbyTBu4/iv79s1MEvSB26E5JN116skuMyvJ2pJY5W7bBm5QngbEYEmrGCPpXKTZ82lsg/QcVrj9Zp3k/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jTLmBXKv; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea8a5e862eso35712077b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 22:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731133126; x=1731737926; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f4MoZVp4dieOlqSAjdWWI2h3A4ytuGiHKSKJVgig114=;
        b=jTLmBXKvuI6suxEbRBqjCN+S4bb6Ep/nRP8aiSwJxoH0GZsUEaScHAPMVT37DojoHi
         /a5eH8z4nt1oeGuk7bpHi5oXZy95URKIXPPz8QwXdK0HMuNaR0KIK05h6q3oQVgKPIyo
         qJzmDYi3avPFImXgwOp5FD1yL+4BpNfXz1tJZ0ZzSmWo7iBazIUEeCfpHEV7RmqqdhSN
         HWDi+6LTA6grEBFfCZjF3C5kJLA6Csdv6F13Vd/WT5Sfj/ZDSz9ocoMcxAjMZX3EzLhh
         WhvMIJ6BiyCGqq1dsJg4OYv3Gs09rkEjPWV7tOm4QAY6cr2jfVfr2upo3tskBA053uIF
         HzpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731133126; x=1731737926;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f4MoZVp4dieOlqSAjdWWI2h3A4ytuGiHKSKJVgig114=;
        b=oLVoZVfrKBTfvQha/J/W8bPVeLPXocWLVqMoPLEkv4UWzYoSc3ALXR0m5yAec2w3gx
         JzZ1s1OMxMLBwC5kxVAiSYNaWKmmaWMowZUDRIdWYnQ6Cb7Ud3y3TBdbc7vUsTqr8e7K
         BN9CM/g4/MgdyHDv+ezdVOpb3/v25sQpjww2BEgpl8SaVzr7qOCewWtHFvko5zrVqIUk
         SUb6gZkmhbck/I/iVWi7HxR2iYqX7Hi/IGmYGZpMKcyqGGlIi5Ds6ku8Y4DvhzyRva4R
         tvwfoOedCmEA2CVqNrzf0Rr+Drl8GGKEKjZmAK0jntBhCZBDTSXnJOMtjsPKZrqOVU0t
         b50w==
X-Forwarded-Encrypted: i=1; AJvYcCUwWZLWYGmBUBM3vUbXazqstIqryjuaxcFLms+FR34TpKxqa/y8nGL2pQQKTi+582pjWeeAeutpXsIqs9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUEuQw9S6Zp12qzkKtcDZioPVI4OT0bKRmFe3m2IgAN71WEYtq
	/J1UfedGL9apFa3O3lxyFKZfxWsN66U6Sa8/gKfgeUKIK0vPzRLX9YP1B946Gz4GlyKZO8Yn4DU
	Oh79REg==
X-Google-Smtp-Source: AGHT+IFLb4XAQByOO4JIkgmoGuImEbxVT2BiME7WaRVcEAmSkc6DCftAzVLY1+6duaclE1eArEYgqXodgsLg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc2:d48f:a998:5915])
 (user=irogers job=sendgmr) by 2002:a0d:e545:0:b0:6dd:bb6e:ec89 with SMTP id
 00721157ae682-6eade40bbf7mr880687b3.2.1731133126645; Fri, 08 Nov 2024
 22:18:46 -0800 (PST)
Date: Fri,  8 Nov 2024 22:17:58 -0800
In-Reply-To: <20241109061809.811922-1-irogers@google.com>
Message-Id: <20241109061809.811922-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241109061809.811922-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v6 11/22] perf script: Move perf_sample__sprintf_flags to trace-event-scripting.c
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

perf_sample__sprintf_flags is used in the python C code and so needs
to be in the util library rather than a builtin.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-script.c             | 81 ------------------------
 tools/perf/util/python.c                |  6 --
 tools/perf/util/trace-event-scripting.c | 83 +++++++++++++++++++++++++
 3 files changed, 83 insertions(+), 87 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 22d78a9d8f27..1eda065dcb2b 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1693,87 +1693,6 @@ static int perf_sample__fprintf_bts(struct perf_sample *sample,
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
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_BRANCH_MISS, "br miss"},
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
index beac456260ae..2e9da0b089ef 100644
--- a/tools/perf/util/trace-event-scripting.c
+++ b/tools/perf/util/trace-event-scripting.c
@@ -15,6 +15,7 @@
 
 #include "archinsn.h"
 #include "debug.h"
+#include "event.h"
 #include "trace-event.h"
 #include "evsel.h"
 #include <linux/perf_event.h>
@@ -283,3 +284,85 @@ void script_fetch_insn(struct perf_sample *sample, struct thread *thread,
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
+	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_BRANCH_MISS, "br miss"},
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
2.47.0.277.g8800431eea-goog


