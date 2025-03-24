Return-Path: <linux-kernel+bounces-574561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A08A6E6AF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 23:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72B58174244
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8176D1F473A;
	Mon, 24 Mar 2025 22:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uVDhdX0b"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FDE1F461A
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 22:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742855724; cv=none; b=V1j+XXt9yCTkUGNkVnLe1CDI9rn4WcZeVNBkMgEJ5tPUIE8rgzn5UVfVugw9AZF+e0wxJw/T56tlJW9QbvZvyzAAWx/LL4DcINpzTE+FipVe6yNWFG29vYrwkZhweNmrAXpEpB+CXk01CRBsMKGtll2poFsoJIbW/H+3joVLBwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742855724; c=relaxed/simple;
	bh=mWIG94RX7F1dn+zKyyhSyvgD24VQRvJZ1y/5BreQhLM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=qdhtpI8i1l3GBYwJlJa5iU0tiaomNrUtueczPrUT0PTZWGaDkKQra7ZPPadg9Ag5JFTlAwSV9NRLziNP+ay0L69jG6hDkYNv5zu49b5a0wTTW3hi+Rlkq/Eay4zSRq5A+EWfrbe7d6XVSlexFKqvzGq4obSNvmeqsJQ1Hf8wGYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uVDhdX0b; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2242ca2a4a5so58028665ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 15:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742855722; x=1743460522; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1fWiVshzRT1OlcqEg0fIi6VxUb2Z3joclrwIJtBaApg=;
        b=uVDhdX0bZK5Y3ctAEE3XYktBytWqBKMIwttd7ZZ8V+BX+e9/+w4nlrqlN3lukcofM9
         /b7sNqEKmYVCPU5zLjVLmXgl+wvRdDDXPTgAD8RPUj7FHFGEDDXCJBjtLc4hucS6NHqV
         yIEHQL1LZjIK4YQMVj2TTWM38mA8iMU2JcN77iCtx6ohn52dDYmfCUQekOJ6HC1vYS/T
         4mifGkepcNc0tq7My9Rbjmg363t0Znarxx+7imZW8fLQx8oWZ8tSSbnsQRGJVo9C1Z+Z
         mwOb3OO2Zf8/VXkn8mCNJLb69GvYi/J9VrLyV/b+q4LTC2uWIO+57M5g+RsMkV/fdg3B
         s5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742855722; x=1743460522;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1fWiVshzRT1OlcqEg0fIi6VxUb2Z3joclrwIJtBaApg=;
        b=tK3m/63xpPl/hgPz/ZwCDuV8q5c5gClgb4WYoyWcjlqt3ajGzsqMqZF2NDpVFIaNag
         S6Jen++3zIRRxiWt6+v/mYZ1ZUFF0QXTWeFukGoUeBdxAaxYUZOIh441dITCoP0DHKDs
         YAZGqM3TUu93E/FigVCAbSagwjT1/3wI7LEVYIoTMvAk6MX12qtkhcoXM2i1sPsMXRBN
         B0sr9T3xbBhVZfna/02fGVk9rh5ZQCHgzPjp7abW2N/R+g0pN+/sQNiLz7SfWkP1yRnP
         bZ5qUnXaJQgbAn+skj+gMRCR7yKyafrXDYWBtckAsLGD3sZoFAuFbewMNQYsAqbhfJ/t
         dDLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWI9raXyLG0WXaK+DPe9/FEr7JHZSrcuo+OCV9E4WfZw4xgESpZa185mIhV6SuU/Octwc+yrmhZv+Xowr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaPnTAvh3/9woPp1+o/Fl8WKYYat2/C9cOjhP5pbw/dqai+iGF
	g78X/tir0WzYym5ARel6VjV9rGD4I3kUBsvPu7J1grefwSqukw2z4vwt5FLd54GMvhO7jcZAxEm
	ppcE3hw==
X-Google-Smtp-Source: AGHT+IFZaRi6pFLVQDhCP2dFjHAi9+j6YTuOnyYcQ6VxSF3qhonUx+/UvuMpMFOip71GMSPUNq6IDDnBl9xw
X-Received: from pfbfe25.prod.google.com ([2002:a05:6a00:2f19:b0:736:b2a2:5bfe])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:b96:b0:736:4a5b:7f08
 with SMTP id d2e1a72fcca58-73905a27818mr21905414b3a.22.1742855722480; Mon, 24
 Mar 2025 15:35:22 -0700 (PDT)
Date: Mon, 24 Mar 2025 15:34:51 -0700
In-Reply-To: <20250324223452.208081-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324223452.208081-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324223452.208081-14-irogers@google.com>
Subject: [PATCH v1 13/14] perf stat: Add mean, min, max and last --tpebs-mode options
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	John Garry <john.g.garry@oracle.com>, Howard Chu <howardchu95@gmail.com>, 
	Levi Yun <yeoreum.yun@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add command line configuration option for how retirement latency
events are combined. The default "mean" gives the average of
retirement latency. "min" or "max" give the smallest or largest
retirment latency times respectively. "last" uses the last retirment
latency sample's time.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-stat.txt |  7 +++++++
 tools/perf/builtin-stat.c              | 27 ++++++++++++++++++++++++++
 tools/perf/util/intel-tpebs.c          | 20 ++++++++++++++++++-
 tools/perf/util/intel-tpebs.h          |  9 +++++++++
 4 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 2bc063672486..61d091670dee 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -506,6 +506,13 @@ this option is not set. The TPEBS hardware feature starts from Intel Granite
 Rapids microarchitecture. This option only exists in X86_64 and is meaningful on
 Intel platforms with TPEBS feature.
 
+--tpebs-mode=[mean|min|max|last]::
+Set how retirement latency events have their sample times
+combined. The default "mean" gives the average of retirement
+latency. "min" or "max" give the smallest or largest retirment latency
+times respectively. "last" uses the last retirment latency sample's
+time.
+
 --td-level::
 Print the top-down statistics that equal the input level. It allows
 users to print the interested top-down metrics level instead of the
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 80e491bd775b..4adf2ae53b11 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2327,6 +2327,30 @@ static void setup_system_wide(int forks)
 	}
 }
 
+static int parse_tpebs_mode(const struct option *opt, const char *str,
+			    int unset __maybe_unused)
+{
+	enum tpebs_mode *mode = opt->value;
+
+	if (!strcasecmp("mean", str)) {
+		*mode = TPEBS_MODE__MEAN;
+		return 0;
+	}
+	if (!strcasecmp("min", str)) {
+		*mode = TPEBS_MODE__MIN;
+		return 0;
+	}
+	if (!strcasecmp("max", str)) {
+		*mode = TPEBS_MODE__MAX;
+		return 0;
+	}
+	if (!strcasecmp("last", str)) {
+		*mode = TPEBS_MODE__LAST;
+		return 0;
+	}
+	return -1;
+}
+
 int cmd_stat(int argc, const char **argv)
 {
 	struct opt_aggr_mode opt_mode = {};
@@ -2431,6 +2455,9 @@ int cmd_stat(int argc, const char **argv)
 #ifdef HAVE_ARCH_X86_64_SUPPORT
 		OPT_BOOLEAN(0, "record-tpebs", &tpebs_recording,
 			"enable recording for tpebs when retire_latency required"),
+		OPT_CALLBACK(0, "tpebs-mode", &tpebs_mode, "tpebs-mode",
+			"Mode of TPEBS recording: mean, min or max",
+			parse_tpebs_mode),
 #endif
 		OPT_UINTEGER(0, "td-level", &stat_config.topdown_level,
 			"Set the metrics level for the top-down statistics (0: max level)"),
diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index 0def3419b1e5..5a255eb4f057 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -30,6 +30,7 @@
 #define PERF_DATA		"-"
 
 bool tpebs_recording;
+enum tpebs_mode tpebs_mode;
 static LIST_HEAD(tpebs_results);
 static pthread_t tpebs_reader_thread;
 static struct child_process tpebs_cmd;
@@ -44,6 +45,8 @@ struct tpebs_retire_lat {
 	char *event;
 	/** @stats: Recorded retirement latency stats. */
 	struct stats stats;
+	/** @last: Last retirement latency read. */
+	uint64_t last;
 	/* Has the event been sent to perf record? */
 	bool started;
 };
@@ -141,6 +144,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	 * latency value will be used. Save the number of samples and the sum of
 	 * retire latency value for each event.
 	 */
+	t->last = sample->retire_lat;
 	update_stats(&t->stats, sample->retire_lat);
 	mutex_unlock(tpebs_mtx_get());
 	return 0;
@@ -511,7 +515,21 @@ int evsel__tpebs_read(struct evsel *evsel, int cpu_map_idx, int thread)
 			return ret;
 		mutex_lock(tpebs_mtx_get());
 	}
-	val = rint(t->stats.mean);
+	switch (tpebs_mode) {
+	case TPEBS_MODE__MIN:
+		val = rint(t->stats.mean);
+		break;
+	case TPEBS_MODE__MAX:
+		val = rint(t->stats.mean);
+		break;
+	case TPEBS_MODE__LAST:
+		val = t->last;
+		break;
+	default:
+	case TPEBS_MODE__MEAN:
+		val = rint(t->stats.mean);
+		break;
+	}
 	mutex_unlock(tpebs_mtx_get());
 
 	if (old_count) {
diff --git a/tools/perf/util/intel-tpebs.h b/tools/perf/util/intel-tpebs.h
index fa9e4b047e8d..a47a778be46c 100644
--- a/tools/perf/util/intel-tpebs.h
+++ b/tools/perf/util/intel-tpebs.h
@@ -9,7 +9,16 @@ struct evsel;
 
 #ifdef HAVE_ARCH_X86_64_SUPPORT
 
+enum tpebs_mode {
+	TPEBS_MODE__MEAN,
+	TPEBS_MODE__MIN,
+	TPEBS_MODE__MAX,
+	TPEBS_MODE__LAST,
+};
+
 extern bool tpebs_recording;
+extern enum tpebs_mode tpebs_mode;
+
 int evsel__tpebs_open(struct evsel *evsel);
 void evsel__tpebs_close(struct evsel *evsel);
 int evsel__tpebs_read(struct evsel *evsel, int cpu_map_idx, int thread);
-- 
2.49.0.395.g12beb8f557-goog


