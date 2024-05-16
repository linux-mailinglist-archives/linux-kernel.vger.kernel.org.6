Return-Path: <linux-kernel+bounces-180620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E07D38C70E2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 06:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67DBF28497B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 04:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8DA1642B;
	Thu, 16 May 2024 04:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sXA/O0ag"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9A13D0BD
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 04:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715833210; cv=none; b=KksX1T+qDiBBwLEKCtHmpfRHvfywG+UEi+AX/P+oc38LIYjf1pLpkIdxq4ze/+k+0g0R/4a7J1fAHdHVM/ebpxBaNDVE8NXcWOKtf23O8yTRMh5ZKA0RC/e8g8qosZLc2jb4EskQdgkgveCCV0xSP1B17zH+EfqgRGiFmK2iGp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715833210; c=relaxed/simple;
	bh=tm50rM0/vPAY35AZcNIkh9G+ITQ1yOK+pmrR/wf9O70=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=M9NR1Pccr/6x2ZlPvrWSeZ6r4a9/ArdPjQqbI6CVzssEfRQgDacjFAWNKWb5AsAOzFhVBUpODtXSE7YCT5Xg9B0og6MVIRZiShrHLM6+dBZYmxiUt8kK+TogpvxqiZpjFfkZrlicrfRiReb7yM3wkMOE8uS6s+Vi11FONX0Hi3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sXA/O0ag; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de54ccab44aso14315010276.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 21:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715833208; x=1716438008; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e6nxXyVAqYg+7CILkdLqmh6c58xAPU1gAIUJoi7JwDM=;
        b=sXA/O0agGCg+1UF0X3HIuqhuczwjWjicjB94RD1GtFoRXMM/6rIR8/A3Lg08ST7POc
         n7r6ui04LJHJp2DNfCNJ3U3cCMU2Po2XQz1dXlU6rHY0fH/8IrkOtqTAxTh8R+fx5jEK
         7YZ1+eEufd9ogb8Q/hpn9cEqn5XUftkAu9B271zIw5vIFc9qlG+mhjj3/bc7VTasKhhH
         MELJ6QpT5ioYkF9P/6kpV6k9frLexBxw3qvRu8oZHZkUEjBnDOh3yHfEg3lnoB2KwEEN
         AB1cpWaNHwt+fURgPwJ3ufrD1PV2hWqklx8hkGE85s0bZlBg0x6y9gSLkQGo7VE/QnGF
         Uocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715833208; x=1716438008;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e6nxXyVAqYg+7CILkdLqmh6c58xAPU1gAIUJoi7JwDM=;
        b=AZFdViFT0Cj6hat2CGePis3uxzDJ0234/5Ctj/um7x0LGtS/F90DDZhle3j8tiZkks
         gv8vUg8BxAMJskQUboPFxJMAGBIozoDO3HF+JWHqTmdjtaA2YXFdC33zEj0KnGJmDNom
         0LNPVJSU725tfq04o0C8CsaZLasbX41CVLZ95efJF+2F9Lxg2xffjr4cCAT9z6XelyXn
         9EipzGWSWFX9zVTDjjA54wuL/0gsGylB0nqdy9Uu12+BPzmjIUlAlIrUs2LTqu3k6nnK
         0LXABCk2VFVRfDximHU5VkkGYpPPdvTWBQqLcPM+2e5hadQxuaRq+Ie/vItkzOAH+w8j
         CA2g==
X-Forwarded-Encrypted: i=1; AJvYcCVPhQJHTDCKOwEQhGnWFtKysitA92P2nKspXaDGX9dAJYze3yfumqwtBYB3IuPvIfxUjhx5Hi2JfEsI7U2Q11fhDj8+5NRohO9hgHK5
X-Gm-Message-State: AOJu0YxFDwiixkoSp/akDKTnS5bSXu0AR8M835dhXPhsURBV1ipeq+Ne
	kTU0E3ZY5tS1mVOgoGed7JiaEP4SaEohaejhDN9exe0ZAaKH18lB5LtcNjj6I9SVjyYfVrx3uDk
	2vkyXhw==
X-Google-Smtp-Source: AGHT+IFa1kPJs1KsUvyTEmNoS/ubhW5OW5/ldB9W6PN5lhmb7Eya9ytsv10yFVGmu5YQXG3Ep5oQwmxgecGx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bac3:cca1:c362:572])
 (user=irogers job=sendgmr) by 2002:a25:7486:0:b0:de5:2325:72a1 with SMTP id
 3f1490d57ef6-dee4f192850mr4368968276.4.1715833208535; Wed, 15 May 2024
 21:20:08 -0700 (PDT)
Date: Wed, 15 May 2024 21:19:48 -0700
In-Reply-To: <20240516041948.3546553-1-irogers@google.com>
Message-Id: <20240516041948.3546553-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240516041948.3546553-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v1 3/3] perf top: Allow filters on events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Changbin Du <changbin.du@huawei.com>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Allow filters to be added to perf top events. One use is to workaround
issues with:
```
$ perf top --uid="$(id -u)"
```
which tries to scan /proc find processes belonging to the uid and can
fail in such a pid terminates between the scan and the
perf_event_open reporting:
```
Error:
The sys_perf_event_open() syscall returned with 3 (No such process) for event (cycles:P).
/bin/dmesg | grep -i perf may provide additional information.
```
A similar filter:
```
$ perf top -e cycles:P --filter "uid == $(id -u)"
```
doesn't fail this way.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-top.txt | 4 ++++
 tools/perf/builtin-top.c              | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index a754875fa5bb..667e5102075e 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -43,6 +43,10 @@ Default is to monitor all CPUS.
 	encoding with the layout of the event control registers as described
 	by entries in /sys/bus/event_source/devices/cpu/format/*.
 
+--filter=<filter>::
+	Event filter.  This option should follow an event selector (-e). For
+	syntax see linkperf:perf-record[1].
+
 -E <entries>::
 --entries=<entries>::
 	Display this many functions.
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 1d6aef51c122..e8cbbf10d361 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1055,6 +1055,13 @@ static int perf_top__start_counters(struct perf_top *top)
 		}
 	}
 
+	if (evlist__apply_filters(evlist, &counter)) {
+		pr_err("failed to set filter \"%s\" on event %s with %d (%s)\n",
+			counter->filter ?: "BPF", evsel__name(counter), errno,
+			str_error_r(errno, msg, sizeof(msg)));
+		goto out_err;
+	}
+
 	if (evlist__mmap(evlist, opts->mmap_pages) < 0) {
 		ui__error("Failed to mmap with %d (%s)\n",
 			    errno, str_error_r(errno, msg, sizeof(msg)));
@@ -1462,6 +1469,8 @@ int cmd_top(int argc, const char **argv)
 	OPT_CALLBACK('e', "event", &parse_events_option_args, "event",
 		     "event selector. use 'perf list' to list available events",
 		     parse_events_option),
+	OPT_CALLBACK(0, "filter", &top.evlist, "filter",
+		     "event filter", parse_filter),
 	OPT_U64('c', "count", &opts->user_interval, "event period to sample"),
 	OPT_STRING('p', "pid", &target->pid, "pid",
 		    "profile events on existing process id"),
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


