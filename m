Return-Path: <linux-kernel+bounces-387774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2D09B55F4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 538B21F23A31
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 22:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA03C20B21E;
	Tue, 29 Oct 2024 22:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HGft9Nfd"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0055620C025
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 22:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730241889; cv=none; b=ZMV2dIb/TQcDQ/6m2SGclUz/kTaSowW7urTeJnwJFaryxOYbGoFL2wbAlMrWEpwVVStJRWkJOLXqyLGb03y+9LVdb1Yw/1VfEmbp5nGq5rSj05WjdNScMfhPuiKF1WbDu8BuVVCaZVzX6ssDEgAWzbOviGxjJNcguwjPMQ0E0dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730241889; c=relaxed/simple;
	bh=bgAMnten7yUv77lry4kHbLHEtlNNVxnv2bZhCLDu2bk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=RAFONoEEi0M5h8YdBrPomvdDoqy36BO9m6CripchI0wqQTN6aEY5rTdJOEUf/rZJUkCxqABqgnx7aHFDxEkWujLMKA3GKg1G1kBaEdx/QWuLZs4iZDJm+kAspQRNX5Qb5xDmUJW/BlnUVdLlJPAVcJz9aDIktOp32VnHbjboMQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HGft9Nfd; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e291ac8dcf3so10425387276.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 15:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730241886; x=1730846686; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dn03tO6yjk+hHI/uxx4ev1BNOlrfTOa71VTpKPW70Iw=;
        b=HGft9Nfd98oTkw4ke7KdjOGf1sLw+WmzDf5miRr4m87aOHnpLqh/4u7td+cC+CvbmZ
         rT33+nMOMu85KXB/8N594wZnhSnWIuaVpP9GoWRjTeHYVFa6I9RXa1DBQLZNzIqdmfhd
         mKZdethPBF/flhPSFJB533G/ZPaLlxKZfsG22vKOll4TQOihStPl1ewa9waTALUXfps8
         OhsIA7IZTM0CjbWfdKTqkB9alC1nIoWaMvQpsCaPWsMOqrQ6WZVELIMjXqMCAKfuDsbW
         rXTboAtoXzYQxxoWuDbB5jkmO8WW4apCi1SSX980la/PCSsxMFnq2TWJCsBD49K2l6Ki
         mNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730241886; x=1730846686;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dn03tO6yjk+hHI/uxx4ev1BNOlrfTOa71VTpKPW70Iw=;
        b=NF3sagp0QfPYCc1qqTQDkGXOt3wqU5F8R+UYun/JdSYG0llH4KxMfsLGkIxZCqgAsR
         Il6chdZM9HQrjwtV/VxLKyhAOpIWOSGpm56zDs9dtiK5nseBx2K4ukK9vT4GbXxJ8e3x
         1KdH2n26rASC/V2Q8BaToIzkFTg/OC7EBaUAxWksLRjMNF04sWb07uWmEN61ql+M0oqk
         6noWpRcxkFvbmhjm6pRjiDzw4naurI6qUoCGqFYWAmw6m4GFhI12xt5gmuK/+nurQV7Y
         7W2wLaKttYOcrwhH2x/PakZbGr4VLoRoqLdwArEWGSWxPItsI/Qq8P3gXtjm2Ku8v+W0
         u0pw==
X-Forwarded-Encrypted: i=1; AJvYcCUTmqcCP4QshHCC4rJsHqC2QlbABJHfZk4icFgmJvdPWu8dZCXjjh9H5KRpyD8wcmC32MovZoMZIId5OSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEV6dkbfKlArnSu+DuY/9BYAkMdHIM/D9BclQNrxetng1cvtLv
	NcKvM6mDUqXl4mKECMnQqEmqAXZdgkPEq9zwFcyoQp0JIy4RM2lAJar+VbcrEbe8hVgVwgVmnyW
	gAKB3mw==
X-Google-Smtp-Source: AGHT+IExA3JFVO57o5s1aC/oywbSW2IzrWYHiZ5NZUiXTsoJ3RexOTnxGKyv3IbKPCltwR6LNnBfyO+G729l
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8991:d3fd:38a7:c282])
 (user=irogers job=sendgmr) by 2002:a25:d80e:0:b0:e2e:3328:7a00 with SMTP id
 3f1490d57ef6-e3087a548eemr49327276.3.1730241885935; Tue, 29 Oct 2024 15:44:45
 -0700 (PDT)
Date: Tue, 29 Oct 2024 15:44:16 -0700
In-Reply-To: <20241029224431.167623-1-irogers@google.com>
Message-Id: <20241029224431.167623-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241029224431.167623-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v4 04/19] perf script: Move scripting_max_stack out of builtin
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

scripting_max_stack is used in util code which is linked into the
python module. Move the variable declaration to
util/trace-event-scripting.c to avoid conditional compilation.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-script.c             | 2 --
 tools/perf/util/python.c                | 2 --
 tools/perf/util/trace-event-scripting.c | 3 +++
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 8c5d5cecfba4..ff30fe466189 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -92,8 +92,6 @@ static struct dlfilter		*dlfilter;
 static int			dlargc;
 static char			**dlargv;
 
-unsigned int scripting_max_stack = PERF_MAX_STACK_DEPTH;
-
 enum perf_output_field {
 	PERF_OUTPUT_COMM            = 1ULL << 0,
 	PERF_OUTPUT_TID             = 1ULL << 1,
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 974578a04099..298f43981fc5 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1306,8 +1306,6 @@ PyMODINIT_FUNC PyInit_perf(void)
 /* The following are stubs to avoid dragging in builtin-* objects. */
 /* TODO: move the code out of the builtin-* file into util. */
 
-unsigned int scripting_max_stack = PERF_MAX_STACK_DEPTH;
-
 bool kvm_entry_event(struct evsel *evsel __maybe_unused)
 {
 	return false;
diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
index bd0000300c77..8abb7a7b6888 100644
--- a/tools/perf/util/trace-event-scripting.c
+++ b/tools/perf/util/trace-event-scripting.c
@@ -16,9 +16,12 @@
 #include "debug.h"
 #include "trace-event.h"
 #include "evsel.h"
+#include <linux/perf_event.h>
 #include <linux/zalloc.h>
 #include "util/sample.h"
 
+unsigned int scripting_max_stack = PERF_MAX_STACK_DEPTH;
+
 struct scripting_context *scripting_context;
 
 void scripting_context__update(struct scripting_context *c,
-- 
2.47.0.163.g1226f6d8fa-goog


