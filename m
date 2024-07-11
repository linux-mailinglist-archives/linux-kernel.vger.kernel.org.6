Return-Path: <linux-kernel+bounces-249653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C5E92EE39
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 166C3B234C6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE363171E4B;
	Thu, 11 Jul 2024 18:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2FlNrWio"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8CD17165A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 18:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720720844; cv=none; b=NzOcMBlyaAZmqZqgbX7okGcQ4aFf+UPaFzflGhyVs39K5OAWCg9fe6N7FhChRunLFy6T6ZNRgQdrLNB7BGTD6aitYxnXXcOYmh02qZDpfu7LZNhuVdQEeOR05j0JAyh0ZWdEav+VjAZSlieohMfxHmxaQmOPRjvEC9p3PEPqVJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720720844; c=relaxed/simple;
	bh=QyWrdcj/7yIk1kCDwEAAgyYccYi84Zy4FDV3Stu0DB8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=X5dO4VwWjwPgPlgDGi+EOU0Kh+i8ZxGGfs8jVgr3UMgJfvW5i6mRG+b0AhML4lvO54E/460fB2lohCKzA2EKxHREdTJuHW/CSqBuFM8BtSjE4tWbkupCKTFcNc22JQD64tcanflJw6/KScrg945+Zcf6lvnLqbp2J4NpBgF6rJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2FlNrWio; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e03b3f48c65so1861056276.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 11:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720720842; x=1721325642; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GLiukIuXpfj1RuwI+7tVJ3j4buaKUCfjcNd2gIIAnuE=;
        b=2FlNrWioZ6GI9cljTZm5U4jHQM8L1rnNABWMa43WiG1RxSGG4SkunOpD09phRnnP9K
         euph8Iu13xjNOQGjjbbbgbE8oKuM7sYzT6l3DrN5uRaRxSrK2Djgt1nMNLe4DhiYfaZk
         yU3FVrfRJEJW0PtspKgkackuTKZdxRrt7X1zWfBRHQKlh+wwNtvcBkPZzyZYJav9Y0EK
         jDUHf+2IFgM2n6kdhpulbmoU31pZpfwHH0FoNqLnNtT3siv/vVezSBgCSNvpZ8dHOXH4
         jCGExJo1TEN7fF3dLGrPw0b5Ale9uNr7mxkjfps/+RHWpLtGtqBtAigFx+Ix7LAfIODZ
         /6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720720842; x=1721325642;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GLiukIuXpfj1RuwI+7tVJ3j4buaKUCfjcNd2gIIAnuE=;
        b=Ufssb+YLC+38w/fPPFXdDly6tUofs/gGrvjeSUA5UIl4W+debYv/fhh0Nz3yC2+eem
         4o+HKm9aZIrAbvLpFwGkUzMbDddUcFpUaSz30HPAPJeByu2dUzY4z68nr7bg/5hwiv8s
         2Q4y+xRejqgLwO6n1oxI/BGAnZ26Nq6XMCGVzNuufO78fiRI451N/Z4JlFxtlwv56gV2
         dGJO+Vj7/O8RmVp527JEui1Cf38rxknmougS5Rm6Tq5iNWEY4FIuBYMfj/YVzQSIqeyQ
         wQE45jvNR8U/oCDlI5M1lPf28tS7dqj4x2lBtZpC+0SYuGgtoIkOlFbD8fuLu6ou3clK
         5wNA==
X-Forwarded-Encrypted: i=1; AJvYcCXF0b1KM+gtwizFs0XjmxnonmUNrj1fBBDKXIdHVkgzimvaHMzqrF7VrB12cGt0GgOYrwYsQSnXIcUYXl9AUsLhn/rhrfdlB7syvcaJ
X-Gm-Message-State: AOJu0YxRuFuA0wja14OslZ9KcjNarqkzaxwR7my1V5RQ/oIwpSO+sDbj
	pcbw4/W6T4HEzbQqrc2ohTRexPLVENGlttVblnlFFAyaOmisz6JDsBF8MU/4YM79+9bQhLQHQfv
	BvE1bpA==
X-Google-Smtp-Source: AGHT+IEXF5wj8ayTVT9jirmz9sHwimvl3fY+5kUcaEScOacOHrr5WKsgjJfB+7NPgApJ3Zze2HXsuC0tMBh0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bd08:a1e0:c497:32db])
 (user=irogers job=sendgmr) by 2002:a05:6902:1002:b0:e02:b51f:ceac with SMTP
 id 3f1490d57ef6-e041b1415d3mr391043276.9.1720720841581; Thu, 11 Jul 2024
 11:00:41 -0700 (PDT)
Date: Thu, 11 Jul 2024 10:59:53 -0700
In-Reply-To: <20240711180008.188906-1-irogers@google.com>
Message-Id: <20240711180008.188906-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711180008.188906-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v4 13/28] perf c2c: Use perf_tool__init
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Use perf_tool__init so that more uses of struct perf_tool can be const
and not relying on perf_tool__fill_defaults.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-c2c.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 88c131d05186..cd2bd573bfc3 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -385,24 +385,6 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	goto out;
 }
 
-static struct perf_c2c c2c = {
-	.tool = {
-		.sample		= process_sample_event,
-		.mmap		= perf_event__process_mmap,
-		.mmap2		= perf_event__process_mmap2,
-		.comm		= perf_event__process_comm,
-		.exit		= perf_event__process_exit,
-		.fork		= perf_event__process_fork,
-		.lost		= perf_event__process_lost,
-		.attr		= perf_event__process_attr,
-		.auxtrace_info  = perf_event__process_auxtrace_info,
-		.auxtrace       = perf_event__process_auxtrace,
-		.auxtrace_error = perf_event__process_auxtrace_error,
-		.ordered_events	= true,
-		.ordering_requires_timestamps = true,
-	},
-};
-
 static const char * const c2c_usage[] = {
 	"perf c2c {record|report}",
 	NULL
@@ -3070,6 +3052,19 @@ static int perf_c2c__report(int argc, const char **argv)
 	data.path  = input_name;
 	data.force = symbol_conf.force;
 
+	perf_tool__init(&c2c.tool, /*ordered_events=*/true);
+	c2c.tool.sample		= process_sample_event;
+	c2c.tool.mmap		= perf_event__process_mmap;
+	c2c.tool.mmap2		= perf_event__process_mmap2;
+	c2c.tool.comm		= perf_event__process_comm;
+	c2c.tool.exit		= perf_event__process_exit;
+	c2c.tool.fork		= perf_event__process_fork;
+	c2c.tool.lost		= perf_event__process_lost;
+	c2c.tool.attr		= perf_event__process_attr;
+	c2c.tool.auxtrace_info  = perf_event__process_auxtrace_info;
+	c2c.tool.auxtrace       = perf_event__process_auxtrace;
+	c2c.tool.auxtrace_error = perf_event__process_auxtrace_error;
+	c2c.tool.ordering_requires_timestamps = true;
 	session = perf_session__new(&data, &c2c.tool);
 	if (IS_ERR(session)) {
 		err = PTR_ERR(session);
-- 
2.45.2.993.g49e7a77208-goog


