Return-Path: <linux-kernel+bounces-181606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0174F8C7E80
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 00:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E0A71F22336
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 22:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7241586C2;
	Thu, 16 May 2024 22:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D/T50K4X"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412C2157467
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 22:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715898132; cv=none; b=flzfqCdBb7OpRvzE0+WAglVcOn34bmAWazf8RQl/1+/REDH2Vg8Wqw3EmuZjxNcMoE8Hz8jKQT9dxg37P/UV1+CHneR0btgeyBPt1hkxuYHRl1bNFdLNrtQR1Hr8v0VWfu7HDA+Y5BFZEnCPgPK+/9sk3KNvBSrSAHB4J0p0+U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715898132; c=relaxed/simple;
	bh=xwIOMlHe1Z7kFcLRG1xSrIudTNqh7gDy2OljfsgpMm4=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=m+VKuieOkrE4fitBkcHu/x6BPfTHRNi9j6/N8P9aBPffBHraUKI+NQ0V4vtbluRyO8/x4Q9IfizeuBrMLCfTa3vq/Mv+ZX3gDYx+TICDKAMUtr06OAWGAIqSgzRTsysdljNxUEbOXcQuxlijsncgt644JeG071yDelJNISI/7Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D/T50K4X; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be621bd84so136029137b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 15:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715898130; x=1716502930; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kS1/X+BHtKjnwKrgy5/KCu8x6nUxO4PCq3/9gh0hd3E=;
        b=D/T50K4XwyucJec1muEoNjdc5G1xUSodYcmBBBuyKGHJBAlEPvOCg6HPB550GE62B4
         68Nm0Y3cHfXmKXoGQ1CKLoiykPYcjFOt5fOqTVsvuqc7xyc1EmquXryMTrVZR7RnEorH
         kiZR5boKkAntdLQ2mdJorXxg5EHzLHmsILsdQGGj8puBSsnQJnn8hS2cvCP9u7AfDV8w
         b1JsSOp5hS2CHSeBcfZpooQ2vswAeZkrDtGrEDR14khsPWvOei4dOZIX2gQ54R2cBHfy
         kQ9kOr8qN14n6SN2uEr9H1j5++RI0EKccg9t2/Qw+gGZDRKoSdTozEtjNEOkNWc+Tu93
         0psw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715898130; x=1716502930;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kS1/X+BHtKjnwKrgy5/KCu8x6nUxO4PCq3/9gh0hd3E=;
        b=JI59vng3Jw6ZmY6MBPRTu39nz03Ciu0a/ogrugbNuDwxAiYS6YIoDq6AGLRxom555x
         7sxLBt6hAQrOQUVBqnKXrJ5Mfx4ke74rY44SCvT0oJS8cSCLvcdUzyGf9UJr7tZI1QDD
         s0mISTGp/f0dsUvwhMLf5fngeNGxNefNAyCKxdBTAeh3P8yDjJLIm6+kLaACnec1dlUw
         bmc2WzcrQPvGuB+z8/WrZeKkiYmE0LxX3lQKUr/9TQLJdEcx1NWjrCqiHyojFouZ8Bhp
         XqkbAu6IBVpww+iwt4nAogNZH98f2oJd6Pc+nad7fFO7wHPwfUrjFuxgbc5lxXbIT3a+
         WGpw==
X-Forwarded-Encrypted: i=1; AJvYcCWisdjhKUVXYl3RSWTsi/L/myip29ArouYez9Ey2uIt6NFlyhWnte2kI9mk0lIldbierSicqXtM8aGeyWRFqznQtHpWtaWl9W4lylO7
X-Gm-Message-State: AOJu0YyDg77Nv6x5hiyIS/yAF3wR/uiZcIWcWisM3JV+pkfkJqTOPNNb
	hVkTaJdpcc4EB97EVUN7eaFtP0FQAL4nz6mzm8e/rrEe7zSUiwprwUthped7Rm8AdQXXKKooHyj
	QEQlt3g==
X-Google-Smtp-Source: AGHT+IGyHj5/KAonqNbCkyv9VaWFytpRqRehbN4/G52bXb5EdLvGUH0dUYwTV/xyGtXdcYO6SvycFQR2EnbF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:9eab:1b1c:e1cb:27f7])
 (user=irogers job=sendgmr) by 2002:a05:690c:360a:b0:61b:e253:31ad with SMTP
 id 00721157ae682-622b014b7a6mr42075857b3.8.1715898130260; Thu, 16 May 2024
 15:22:10 -0700 (PDT)
Date: Thu, 16 May 2024 15:21:59 -0700
Message-Id: <20240516222159.3710131-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v1] perf top: Make zeroing histogram on refresh the default
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Changbin Du <changbin.du@huawei.com>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Instead of decaying histograms over time change it so that they are
zero-ed on each perf top refresh. Previously the option '-z', or
pressing 'z' in tui mode, would enable this behavior. Decaying samples
is non-intuitive as it isn't how "top" works. Make zeroing on refresh
the default and rename the command line options from 'z' to 'Z' and
'zero' to 'decay'.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-top.txt |  6 +++---
 tools/perf/builtin-top.c              | 23 +++++++++++++----------
 tools/perf/ui/browsers/hists.c        |  7 ++++---
 tools/perf/util/top.h                 |  2 +-
 4 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index 667e5102075e..f1524cc0d409 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -124,9 +124,9 @@ Default is to monitor all CPUS.
 --verbose::
 	Be more verbose (show counter open errors, etc).
 
--z::
---zero::
-	Zero history across display updates.
+-Z::
+--decay::
+	Decay rather than zero history across display updates.
 
 -s::
 --sort::
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index e8cbbf10d361..8f06635cb7cd 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -266,10 +266,10 @@ static void perf_top__show_details(struct perf_top *top)
 	more = symbol__annotate_printf(&he->ms, top->sym_evsel);
 
 	if (top->evlist->enabled) {
-		if (top->zero)
-			symbol__annotate_zero_histogram(symbol, top->sym_evsel->core.idx);
-		else
+		if (top->decay_samples)
 			symbol__annotate_decay_histogram(symbol, top->sym_evsel->core.idx);
+		else
+			symbol__annotate_zero_histogram(symbol, top->sym_evsel->core.idx);
 	}
 	if (more != 0)
 		printf("%d lines not displayed, maybe increase display entries [e]\n", more);
@@ -292,11 +292,11 @@ static void perf_top__resort_hists(struct perf_top *t)
 		hists__unlink(hists);
 
 		if (evlist->enabled) {
-			if (t->zero) {
-				hists__delete_entries(hists);
-			} else {
+			if (t->decay_samples) {
 				hists__decay_entries(hists, t->hide_user_symbols,
 						     t->hide_kernel_symbols);
+			} else {
+				hists__delete_entries(hists);
 			}
 		}
 
@@ -460,7 +460,9 @@ static void perf_top__print_mapped_keys(struct perf_top *top)
 	fprintf(stdout,
 		"\t[U]     hide user symbols.               \t(%s)\n",
 		top->hide_user_symbols ? "yes" : "no");
-	fprintf(stdout, "\t[z]     toggle sample zeroing.             \t(%d)\n", top->zero ? 1 : 0);
+	fprintf(stdout,
+		"\t[z]     toggle sample zeroing/decaying.  \t(%s)\n",
+		top->decay_samples ? "decay" : "zero");
 	fprintf(stdout, "\t[qQ]    quit.\n");
 }
 
@@ -583,7 +585,7 @@ static bool perf_top__handle_keypress(struct perf_top *top, int c)
 			top->hide_user_symbols = !top->hide_user_symbols;
 			break;
 		case 'z':
-			top->zero = !top->zero;
+			top->decay_samples = !top->decay_samples;
 			break;
 		default:
 			break;
@@ -648,7 +650,7 @@ static void *display_thread_tui(void *arg)
 	ret = evlist__tui_browse_hists(top->evlist, help, &hbt, top->min_percent,
 				       &top->session->header.env, !top->record_opts.overwrite);
 	if (ret == K_RELOAD) {
-		top->zero = true;
+		top->decay_samples = false;
 		goto repeat;
 	} else
 		stop_top();
@@ -1502,7 +1504,8 @@ int cmd_top(int argc, const char **argv)
 		    "child tasks do not inherit counters"),
 	OPT_STRING(0, "sym-annotate", &top.sym_filter, "symbol name",
 		    "symbol to annotate"),
-	OPT_BOOLEAN('z', "zero", &top.zero, "zero history across updates"),
+	OPT_BOOLEAN('Z', "decay", &top.decay_samples,
+		    "decay rather than zero history across updates"),
 	OPT_CALLBACK('F', "freq", &top.record_opts, "freq or 'max'",
 		     "profile at this frequency",
 		      record__parse_freq),
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index b7219df51236..bcc4720f8198 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2305,8 +2305,8 @@ static int hists_browser__scnprintf_title(struct hist_browser *browser, char *bf
 				     " drop: %" PRIu64 "/%" PRIu64,
 				     top->drop, top->drop_total);
 
-		if (top->zero)
-			printed += scnprintf(bf + printed, size - printed, " [z]");
+		if (top->decay_samples)
+			printed += scnprintf(bf + printed, size - printed, " [decay]");
 
 		perf_top__reset_sample_counters(top);
 	}
@@ -3209,9 +3209,10 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 			continue;
 		case 'z':
 			if (!is_report_browser(hbt)) {
+				/* Toggle between zeroing and decaying samples. */
 				struct perf_top *top = hbt->arg;
 
-				top->zero = !top->zero;
+				top->decay_samples = !top->decay_samples;
 			}
 			continue;
 		case 'L':
diff --git a/tools/perf/util/top.h b/tools/perf/util/top.h
index 4c5588dbb131..b2c199925b36 100644
--- a/tools/perf/util/top.h
+++ b/tools/perf/util/top.h
@@ -32,7 +32,7 @@ struct perf_top {
 	u64		   guest_us_samples, guest_kernel_samples;
 	int		   print_entries, count_filter, delay_secs;
 	int		   max_stack;
-	bool		   hide_kernel_symbols, hide_user_symbols, zero;
+	bool		   hide_kernel_symbols, hide_user_symbols, decay_samples;
 #ifdef HAVE_SLANG_SUPPORT
 	bool		   use_tui;
 #endif
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


