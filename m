Return-Path: <linux-kernel+bounces-402687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2C69C2A89
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 07:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A87981F221B4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 06:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDAE14884D;
	Sat,  9 Nov 2024 06:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aJGqfvpE"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E9F146D76
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 06:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731133113; cv=none; b=nOqTjxv+Gfo9kwN9260fgGW++3oOmwY0NdKgV3TP9fNteSBUlR1z4zZPtnjw5TgrIPOm9MW91MJ+7S3TikUb4MqeWk94aPEg+/x0cNjbkAF5paZ1FPcYgKWj85f7UZgGxlXFTxMjF/BsYbOS4VmWPRJv9hb2iKnjZnn52W5R2OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731133113; c=relaxed/simple;
	bh=jjW/Mdo4ZJpee7DWegXh1qo6a5tS0N+f/pHHyUDeYmQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=duHm1J2HDnTkIrB/uqmSkbAUNfDhsDFHk8gO8+3Y27BkufjhVWe5b+mai2KgopkVNFxkcjDUAqfvl0HqjSiqrZH7vumRmx+ixQhbOrlKlrsMcSr130Rpi84rOpA6Gx5Zp8iizPxrcg/giud12znZMvvqU/dM1wdEV0XX7o+UlcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aJGqfvpE; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e292dbfd834so4912810276.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 22:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731133111; x=1731737911; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mKtLelHwLhS+FdJ2cDeNqQNGycDHJZPn6HtFfn+lcrc=;
        b=aJGqfvpEzZ5Z7Njz5rl5JeSQ++2EwJ2zelI8LiKlksDY7/PbfXwIXyK7NBy71tXEtW
         L9dYpAyJPhiBkDiLvDgAq7cfQNtVA0qGsVOPW1QiBdk8NA7y7kTFYWvkeseHT4cRwxOz
         3YaCfny5odP7hdzljA+ryvsyFcVyGgLQWOKXys3G8I4t+YCSDdQi8Ci3TkMG87swafgY
         qYsm5OPlSUwKr98sR8Vh2doi4ES0N9fivIaNZAzvSMOrVY9rPx/70gCzYieH9pY0BPv0
         THjR1/s1aoBY/KOh02lsAAVoqwB+OOeFFzY7rQXVpTad2WHfeMB1vhkyJqhVfiTy4N5i
         wzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731133111; x=1731737911;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mKtLelHwLhS+FdJ2cDeNqQNGycDHJZPn6HtFfn+lcrc=;
        b=Lo04O3N/Gvmkxih5IqXMCdbYargUBeSACQkH5YO8CkF5Ggpai+MtHd1Ctq60g8qg7R
         Rz895vmPKAgV/0JYxJmocK23D0uz+0MmRB/iSJwkjBaDCx1hjg3s1KO1XGQiXpRHNMEt
         1rfuk04QhtNrWMkXMEaKp39dCtwK2+w7Q64P72cV/SqYYwwLChWhqgmDC/x75suzftoo
         lMeFJyOCGl4kAmm+j9F0J4ARgUOOeghB+pqx3tkVqNuuIzgbYveXz5Z1gd6h38N81qQo
         RdNt/uRJTGPFRQQ6HP76AAQ593YprZN7xyV4bUNn3fTwTpH1iYOKNECdf6tFmC+GhwQQ
         Y22Q==
X-Forwarded-Encrypted: i=1; AJvYcCVxTJuZB201LtTilZWltVAGBHT1Od1iZ3criCm4+Yh5W7ztN8+kn9lc9YAI1n5RGbbJNBk5lzrEqn+uHPY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+u0cZQRkMBwP1He+UGXZcuHpX3lgPnuyzv0gnpM/hG14KeXeV
	+W+qKlZ/3mZuUyP+CZ3aNZw7WuITVG5JwASy8gEvcodUxENNLBJPgoZvDaB2S2JGkMnbOLoypZq
	Eh9mPcg==
X-Google-Smtp-Source: AGHT+IGhIeNLPRZK5O/PYT2qqHEwmo4Z8fY+bYdkwDZDWI3k5DZ9o8bTRsCOjM4Mj3m73yhcoJua6oaDQxoH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc2:d48f:a998:5915])
 (user=irogers job=sendgmr) by 2002:a25:aaea:0:b0:e2b:d28f:bf28 with SMTP id
 3f1490d57ef6-e337f844036mr13186276.2.1731133110711; Fri, 08 Nov 2024 22:18:30
 -0800 (PST)
Date: Fri,  8 Nov 2024 22:17:51 -0800
In-Reply-To: <20241109061809.811922-1-irogers@google.com>
Message-Id: <20241109061809.811922-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241109061809.811922-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v6 04/22] perf script: Move scripting_max_stack out of builtin
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

scripting_max_stack is used in util code which is linked into the
python module. Move the variable declaration to
util/trace-event-scripting.c to avoid conditional compilation.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c             | 2 --
 tools/perf/util/python.c                | 2 --
 tools/perf/util/trace-event-scripting.c | 3 +++
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 6b6d4472db6e..5d5a1a06d8c6 100644
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
index e2109f6c7ead..f82e8a968e24 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1307,8 +1307,6 @@ PyMODINIT_FUNC PyInit_perf(void)
 /* The following are stubs to avoid dragging in builtin-* objects. */
 /* TODO: move the code out of the builtin-* file into util. */
 
-unsigned int scripting_max_stack = PERF_MAX_STACK_DEPTH;
-
 #ifdef HAVE_KVM_STAT_SUPPORT
 bool kvm_entry_event(struct evsel *evsel __maybe_unused)
 {
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
2.47.0.277.g8800431eea-goog


