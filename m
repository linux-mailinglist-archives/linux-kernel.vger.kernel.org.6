Return-Path: <linux-kernel+bounces-413586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF47D9D1B4E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 23:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F1C5B230DB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 22:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197AF1EC00E;
	Mon, 18 Nov 2024 22:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d/qE3qxY"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3751EC003
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 22:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731970477; cv=none; b=Mo0mW5Fr5T2IHjWQCC9GqPzAcTGwJ9dhdO+blJHk+pLVx5vGxc26DgSzSag613yDYqW1xkF5EYzHQDDzQyTBbSq+O5N/8Af1vUATil+GrIymnUp4ZtUr5hTt8Tp45Ync6PCG1L6D7JVMHTD9IIh7cxoU3f8SSKp30PLFy5otnCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731970477; c=relaxed/simple;
	bh=jLMv6psh26jQg+qmfgIhNouYWgAxBlI8CM4lBpCniiI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Uh3JpzsEO/jsjeKV83L9X8NkxL2iIQGVTmAlcyp34AkEunZjd1DM/JZ0GVJe83oZFB9yrAk1M3IiqEghVUziYWumwbEsPiZyJq0lVQ/PQgBrV76e7Pw3mjNkwaSS1LjwOC2+XTE1wRiVBMbd+ZP5vm9rapRILXr+DkG/NKZtZ2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d/qE3qxY; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e384d715e96so3091644276.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 14:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731970475; x=1732575275; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FG3Sh83F7FOGs8gw5xePFCnagv+uNMSUGfyFfbaEqMQ=;
        b=d/qE3qxYvq0s3SEdOaqjJUJbxxCqff56nE8M5v2GZzkTynKSP0TOMHF9CH+/0/OMVc
         be0Xg8W+zuERWtviR1l8VK035m+lSLbb4UzQoE63+/hVNHHOj5rMFy8z0eeo1g8eOqZs
         QN1xpNkB8MNXrTc3WjP1FsP5MD/1FUpd5KZ8fB8kB4Mr6OPd8Gt4bLwQejsIURERx/zV
         5exjcs0ztjwtxFg4QnGiSIC/U8+MevsxtR1wNA0xcLztxRH/vC+lG6G/1Q6JbRVKvFZj
         494FSegvlkQB36X/OsX+9T2ScFAS+kk8IovzdP5zscZDCnQblmwsfPEh09II6FCYZm+h
         1RPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731970475; x=1732575275;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FG3Sh83F7FOGs8gw5xePFCnagv+uNMSUGfyFfbaEqMQ=;
        b=scIfchYJoJYCKNkPx0TsqueVQA/iP3a+H1ugume07EBpvvhpHqmrT9JLATKyHndN2b
         qIWYNIPS8EXY+uFNBw3OazXQl3BdI64rSPK3dVrBeB/ZH3h3SRJPL31SrzontV20gDbb
         DpS0X/FmlhnzKblvPYcVNBqQPtIeXVHppEjwzcGH5uUx6Tl2XjvqIGdpn5vO913dF184
         opgjyueuIEbRPvqKCKf8K0+XRk9wweqVkX22aDuzPyIxQau896JG79NKLXrdpDLlMGh2
         65/0NavzNLwzozduxpXTwcKSzJSse748ELKrGLXGBKYj3bxgaLVNaSLAOZZF/Jwnd6iH
         0yFQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9oBmoNlBEUS7+KbdQ3tI2axKsdxYj4YMCg2k1w43MCvQivsmGX0DFxwhqUBLUgpFufzOT2ISOZZtGKY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT11rJSy2XV6G1Sg2TF3yGaqeKJKn8mOoBFmganqRJs/LSejq1
	WD173HtRAgpGUNGei/JMsQlM+vli7Vun60+AN5UaI6KqK8+V9K267D2vT0WkalVBiVpa7G/5l7y
	IC1s4Gg==
X-Google-Smtp-Source: AGHT+IGl1aqGhFtUZ1apRuwVVnoRAl8J4uAIA9T+sYV7QTDRk/6WeLhJGKOFjO0Kn4m5EaYRZcmrmTJNmUYv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:22a4:ded5:5c37:fcc7])
 (user=irogers job=sendgmr) by 2002:a25:e0c5:0:b0:e38:22d8:e5f3 with SMTP id
 3f1490d57ef6-e3825d27591mr174594276.2.1731970474602; Mon, 18 Nov 2024
 14:54:34 -0800 (PST)
Date: Mon, 18 Nov 2024 14:53:42 -0800
In-Reply-To: <20241118225345.889810-1-irogers@google.com>
Message-Id: <20241118225345.889810-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241118225345.889810-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v5 4/7] perf trace-event: Always build trace-event-info.c
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	James Clark <james.clark@linaro.org>, Dominique Martinet <asmadeus@codewreck.org>, 
	Yang Li <yang.lee@linux.alibaba.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Yang Jihong <yangjihong@bytedance.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Ben Gainey <ben.gainey@arm.com>, zhaimingbing <zhaimingbing@cmss.chinamobile.com>, 
	Zixian Cai <fzczx123@gmail.com>, Andi Kleen <ak@linux.intel.com>, Paran Lee <p4ranlee@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, 
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"

trace-event-info.c has no libtraceevent depdendencies, always build it
and use it in builtin-record and perf_event_attr printing.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c               | 2 --
 tools/perf/util/Build                     | 2 +-
 tools/perf/util/perf_event_attr_fprintf.c | 4 ----
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index f83252472921..0b637cea4850 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1748,10 +1748,8 @@ static void record__init_features(struct record *rec)
 	if (rec->no_buildid)
 		perf_header__clear_feat(&session->header, HEADER_BUILD_ID);
 
-#ifdef HAVE_LIBTRACEEVENT
 	if (!have_tracepoints(&rec->evlist->core.entries))
 		perf_header__clear_feat(&session->header, HEADER_TRACING_DATA);
-#endif
 
 	if (!rec->opts.branch_stack)
 		perf_header__clear_feat(&session->header, HEADER_BRANCH_STACK);
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index c06d2ee9024c..47522612484e 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -86,7 +86,7 @@ perf-util-y += pmu-bison.o
 perf-util-y += hwmon_pmu.o
 perf-util-y += tool_pmu.o
 perf-util-y += svghelper.o
-perf-util-$(CONFIG_LIBTRACEEVENT) += trace-event-info.o
+perf-util-y += trace-event-info.o
 perf-util-y += trace-event-scripting.o
 perf-util-$(CONFIG_LIBTRACEEVENT) += trace-event.o
 perf-util-$(CONFIG_LIBTRACEEVENT) += trace-event-parse.o
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index 59fbbba79697..a73c74b99a3b 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -212,7 +212,6 @@ static void __p_config_hw_cache_id(char *buf, size_t size, u64 value)
 	}
 }
 
-#ifdef HAVE_LIBTRACEEVENT
 static void __p_config_tracepoint_id(char *buf, size_t size, u64 value)
 {
 	char *str = tracepoint_id_to_name(value);
@@ -220,7 +219,6 @@ static void __p_config_tracepoint_id(char *buf, size_t size, u64 value)
 	print_id_hex(str);
 	free(str);
 }
-#endif
 
 static void __p_config_id(struct perf_pmu *pmu, char *buf, size_t size, u32 type, u64 value)
 {
@@ -238,9 +236,7 @@ static void __p_config_id(struct perf_pmu *pmu, char *buf, size_t size, u32 type
 	case PERF_TYPE_HW_CACHE:
 		return __p_config_hw_cache_id(buf, size, value);
 	case PERF_TYPE_TRACEPOINT:
-#ifdef HAVE_LIBTRACEEVENT
 		return __p_config_tracepoint_id(buf, size, value);
-#endif
 	case PERF_TYPE_RAW:
 	case PERF_TYPE_BREAKPOINT:
 	default:
-- 
2.47.0.338.g60cca15819-goog


