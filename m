Return-Path: <linux-kernel+bounces-440195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D279EB9FD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 20:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88FCF28382B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 19:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98F0214237;
	Tue, 10 Dec 2024 19:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z3FDuwFS"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF2623ED63
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 19:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733858315; cv=none; b=nVK28aQpf+l1MzxjsPY7j/vgmsvuFXpsk7CTWws2zEK8shpOXofDnwBEdJKMENv2zDMszttOXkeJdHa7c7HLkFnl5MKy1v2Na2ll7UiJVwCWyZ1P+6GjVOKkLsg//G9lyiYBOQ9IejhhUt65dmEDgXJ/uKY9JkI4zM/agEBRXns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733858315; c=relaxed/simple;
	bh=zLjyeZbn2azddPUqtc4Ge4NSb+lnbUk5aXLsXnEjA4s=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=YdkXAwc+n+Nx1m6ZHHaBejoYC0vx1TZa8ewV9r3x09WKXHvylplvBrexrWVA4c8Uck7PL4YhHDDl8C0kUy13d4wYjgKGcssQwwRgmR38/u6+KW01UCNuaGj1EbxeYgH/KZ5piZIdGFgU8J35ePZG0jW763vynJwR+OWmu/RS0u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z3FDuwFS; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e35e9d36da3so10153081276.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 11:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733858311; x=1734463111; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IGQhz6dYA9gvKzv6B9FYPbGo1YaUBKUFUvBFQDWzx3g=;
        b=z3FDuwFSvdr1acp1QSmL119mNoX+3jwru5OZdpC2uB2I8IWxzP20UgMC500urqphAl
         QjheibNUhA/GGIKt7n5iNSwPysSA2WdxlLVTkPAbHiJsl1qnwlGc6lK3XcAMKl13NcdT
         2KtRr8mg+M+tCP/qbpDnB/8FC+BSU1NWiCn9TOr09aQfHIHbWhVFsTVKqc1QDkHKqJ3W
         etRflSRGVVjM7V9sAzD+yTOitV051IxPy574DddKKrrhLAWRi+ny/pYcLgJ9+nzP6JP0
         gnm/EwFbAFtXm9eW7NEgjrBOS8234D6ykcPbaaDlKR1+E0Dp40DUw7zZVm0Hu1sD3ijq
         QAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733858311; x=1734463111;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IGQhz6dYA9gvKzv6B9FYPbGo1YaUBKUFUvBFQDWzx3g=;
        b=aMSsYwZuEUyVzswj6ToT2+dXD0kZMAQkicvjOSfteIc/a10NN2xIvs6KhR6rMnP+yA
         Q7iQtvqm7Ox5sTqBGP0UuFBNBEhBV9zZm7a0J3A8MMH2EkHAfgvkd3pT86mueL9Ny1v4
         pl9yPLAugMv+LZFNH0tiA7fMAP0KUj1fav4CNVSdQ2lb2pKhY274JSnO3Ey0OmbAORdT
         3vQrY0EMX5pQvnEjQapV/wdN/3pa/vzmQ4bZLwzWZNdbHfwKPd6ts5dE6wG+l6Bj3kHH
         cbRItsUgaHtNGDiA7K3Al7jJC6QB5eGfKZjS/0QyvQIEQNqVzQcdyjBlUjGAEoBmm8GQ
         FNzw==
X-Forwarded-Encrypted: i=1; AJvYcCUJjGF5tLznnuBcOAPIQ/jjZj3cyYUgWSpsSMZpElt/wMtpKDBhcAaUPLrAVs5Q3h+sXETaetLXXIoetss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd3ABPoEcPlwF3VYH3svL1TvpsUwSfRCj+nawObIO9ROHDLVcU
	4IvHdJSUQmeFSt9miNcfgOBcX7qX7sJq+Kg0DAOrUD5EoSHHLGlpuXOvSAbrH5wpzmgQO1AK491
	q079CXw==
X-Google-Smtp-Source: AGHT+IHT0UvC956VGrh7hk00zt7MvxiV5tXr9zu7jDzJJbYPWSguxL3QtROQgK7WdmBsBkSrxuiEiDPtdP9b
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:cd0f:933b:4048:cd14])
 (user=irogers job=sendgmr) by 2002:a25:b281:0:b0:e39:78c0:3dd with SMTP id
 3f1490d57ef6-e3c8e70147dmr159276.5.1733858311366; Tue, 10 Dec 2024 11:18:31
 -0800 (PST)
Date: Tue, 10 Dec 2024 11:18:23 -0800
Message-Id: <20241210191823.612631-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1] perf intel-tpebs: Cleanup header
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Remove arch conditional compilation. Arch conditional compilation
belongs in the arch/ directory.

Tidy header guards to match other files. Remove unneeded includes and
switch to forward declarations when necesary.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build         |  2 +-
 tools/perf/util/intel-tpebs.h | 30 ++++++------------------------
 2 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 9eb8b1c3df94..c0ccd8ef08e0 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -158,7 +158,7 @@ perf-util-y += clockid.o
 perf-util-y += list_sort.o
 perf-util-y += mutex.o
 perf-util-y += sharded_mutex.o
-perf-util-$(CONFIG_X86_64) += intel-tpebs.o
+perf-util-y += intel-tpebs.o
 
 perf-util-$(CONFIG_LIBBPF) += bpf_map.o
 perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf_counter.o
diff --git a/tools/perf/util/intel-tpebs.h b/tools/perf/util/intel-tpebs.h
index 766b3fbd79f1..63c16e759a71 100644
--- a/tools/perf/util/intel-tpebs.h
+++ b/tools/perf/util/intel-tpebs.h
@@ -2,34 +2,16 @@
 /*
  * intel_tpebs.h: Intel TEPBS support
  */
-#ifndef INCLUDE__PERF_INTEL_TPEBS_H__
-#define INCLUDE__PERF_INTEL_TPEBS_H__
+#ifndef __INTEL_TPEBS_H
+#define __INTEL_TPEBS_H
 
-#include "stat.h"
-#include "evsel.h"
-
-#ifdef HAVE_ARCH_X86_64_SUPPORT
+struct evlist;
+struct evsel;
 
 extern bool tpebs_recording;
+
 int tpebs_start(struct evlist *evsel_list);
 void tpebs_delete(void);
 int tpebs_set_evsel(struct evsel *evsel, int cpu_map_idx, int thread);
 
-#else
-
-static inline int tpebs_start(struct evlist *evsel_list __maybe_unused)
-{
-	return 0;
-}
-
-static inline void tpebs_delete(void) {};
-
-static inline int tpebs_set_evsel(struct evsel *evsel  __maybe_unused,
-				int cpu_map_idx  __maybe_unused,
-				int thread  __maybe_unused)
-{
-	return 0;
-}
-
-#endif
-#endif
+#endif /* __INTEL_TPEBS_H */
-- 
2.47.1.613.gc27f4b7a9f-goog


