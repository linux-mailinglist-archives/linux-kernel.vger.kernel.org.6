Return-Path: <linux-kernel+bounces-409607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B479C8F32
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C88431F21432
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55663171E43;
	Thu, 14 Nov 2024 16:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SZy6P5GT"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBD515B0EF
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 16:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731600475; cv=none; b=tk4PG8U3Lu3BgTctqVSXv7421nuFGRStP9E7A4CiiGLDJVELWR3RqBF/D3UoPecVW5i2yMRUhXNTKi1WFGi1SvIZVwjR9/EyNpKr6ETB2TwEmv7nGxB5E7B5m+kIiC7nTThhayDNvpp/Dx+MXnmzJyi6UNaJOZVppcOLtxhcANE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731600475; c=relaxed/simple;
	bh=bzQ9CRjWdecUHtFTM41DyW8czRtgDd01ddhI7LWZXOw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sLHHOoZzLiTmpV+DH+D1/ZYrX9htox0GekGomJyfbUTHXvneVlcLdh33FqlkuUZ2B7o0pR5j4C6UB895/oALklhq6X9dnVF2XHaM1NwVE0927e9mCqsn3xUCSrgwtM08ldvf5zsW8rUO4QFs4lREC8/KPgY8Bf7iKb5o8bSkx9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SZy6P5GT; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9a0c7abaa6so97722466b.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 08:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731600472; x=1732205272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3cdScFAcgvdlRHopcdKPzeCgYcfuZjBjrzryDpj2HE=;
        b=SZy6P5GT/OqSZe/QYPRkWaTGry9nck/mdkK/ZNEgJHOI/n8imGVOX277m2jXGR2+b5
         mEO3eAs9eCdeQmVEnIianGBo+avAjWOhnnx0DCTnpAUs6MG1+vtFyhbskTjQQcMjsARd
         PcWbNeQA0XwrQLCvhC9K5oshaBqqFEQnbaGvD42vKsRP1cR3+93xVVBoOs6uGR2LvIWY
         JT/W2wA7lnXc6aM4Mi3UkXmZISATa2TK4HrsqbOq2Pr4AIID9e+dt0OyiqLl4EIyFh/J
         PQnS4vUOPwIRVvkbncqxFZATm/r6WLmiKyx5AqJqDW+8QBMCg5sv+IlXGq/+WxHGW8rA
         kl+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731600472; x=1732205272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G3cdScFAcgvdlRHopcdKPzeCgYcfuZjBjrzryDpj2HE=;
        b=F2wztIALiXhM9F+2wdrT4bJsPmE0qvtN3s74a/ZvzS8llheChzUC0rcClaE0K1/eYs
         AJVme/2fr7GCO2E4WUanzI2RZzd7cQtGnyPCCom0aXEKVNrFJfN0BSQctg3UOPvSaqgS
         q81w4fho0z/l6zc4ia14xfkwacssPOaX1LYqoZh40S4iz3LBTk/A9G1EZlWJAvPFXauB
         HaO6w1eIm8c7A3GER7Os9ta2FlFfTYq51ZcI9CH1O6QoCDgkY5y/nP/UUPm+5EiQzlRL
         UquKxehhwEov//m0BQuNHXb8cs9OzkVbW1diQR2WpVTJfibZW4KIYDfDPBJj4eH2o6RI
         2GmA==
X-Forwarded-Encrypted: i=1; AJvYcCVuzoiqY8K6L8B45wrWiEC3Ch/K6Ks3JVqR1L8dagUGiHINux7wh2EFxC0aSQbpwErT+7sRWwiTFADqDhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfRUgzOIBpAm4NT72smSYbYDjgV+/0sX5Z4yTR4/b/Newzlzv+
	Qe8QxhUFBI5eXBM1oYMf9n5aONt7An6Bv4KeKApWQdHJOYgmyNq0/DCSzlc6tL0=
X-Google-Smtp-Source: AGHT+IGHoLs6q08SPM4TqfP2UFLFrJQtplNKocJZiNpyTod0sYUFtC3vT9Nx2DHotVltrf59qYc4fg==
X-Received: by 2002:a17:907:60d2:b0:a99:e1a1:473f with SMTP id a640c23a62f3a-aa20cdefc8bmr294267166b.57.1731600472062;
        Thu, 14 Nov 2024 08:07:52 -0800 (PST)
Received: from pop-os.. ([145.224.90.214])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e046d76sm77456366b.165.2024.11.14.08.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:07:51 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	thomas.falcon@intel.com
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] libperf: evlist: Fix --cpu argument on hybrid platform
Date: Thu, 14 Nov 2024 16:04:48 +0000
Message-Id: <20241114160450.295844-2-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241114160450.295844-1-james.clark@linaro.org>
References: <20241114160450.295844-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the linked fixes: commit, specifying a CPU on hybrid platforms
results in an error because Perf tries to open an extended type event
on "any" CPU which isn't valid. Extended type events can only be opened
on CPUs that match the type.

Before (working):

  $ perf record --cpu 1 -- true
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 2.385 MB perf.data (7 samples) ]

After (not working):

  $ perf record -C 1 -- true
  WARNING: A requested CPU in '1' is not supported by PMU 'cpu_atom' (CPUs 16-27) for event 'cycles:P'
  Error:
  The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (cpu_atom/cycles:P/).
  /bin/dmesg | grep -i perf may provide additional information.

(Ignore the warning message, that's expected and not particularly
relevant to this issue).

This is because perf_cpu_map__intersect() of the user specified CPU (1)
and one of the PMU's CPUs (16-27) correctly results in an empty (NULL)
CPU map. However for the purposes of opening an event, libperf converts
empty CPU maps into an any CPU (-1) which the kernel rejects.

Fix it by deleting evsels with empty CPU maps in the specific case where
user requested CPU maps are evaluated.

Fixes: 251aa040244a ("perf parse-events: Wildcard most "numeric" events")
Reviewed-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/lib/perf/evlist.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index c6d67fc9e57e..83c43dc13313 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -47,6 +47,20 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
 		 */
 		perf_cpu_map__put(evsel->cpus);
 		evsel->cpus = perf_cpu_map__intersect(evlist->user_requested_cpus, evsel->own_cpus);
+
+		/*
+		 * Empty cpu lists would eventually get opened as "any" so remove
+		 * genuinely empty ones before they're opened in the wrong place.
+		 */
+		if (perf_cpu_map__is_empty(evsel->cpus)) {
+			struct perf_evsel *next = perf_evlist__next(evlist, evsel);
+
+			perf_evlist__remove(evlist, evsel);
+			/* Keep idx contiguous */
+			if (next)
+				list_for_each_entry_from(next, &evlist->entries, node)
+					next->idx--;
+		}
 	} else if (!evsel->own_cpus || evlist->has_user_cpus ||
 		(!evsel->requires_cpu && perf_cpu_map__has_any_cpu(evlist->user_requested_cpus))) {
 		/*
@@ -80,11 +94,11 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
 
 static void perf_evlist__propagate_maps(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel;
+	struct perf_evsel *evsel, *n;
 
 	evlist->needs_map_propagation = true;
 
-	perf_evlist__for_each_evsel(evlist, evsel)
+	list_for_each_entry_safe(evsel, n, &evlist->entries, node)
 		__perf_evlist__propagate_maps(evlist, evsel);
 }
 
-- 
2.34.1


