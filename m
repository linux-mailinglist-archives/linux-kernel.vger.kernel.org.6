Return-Path: <linux-kernel+bounces-251081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E07BE930061
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 20:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FBC91C214B1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAA017F506;
	Fri, 12 Jul 2024 18:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SjQrw9WO"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F52E17F4E6
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 18:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720807993; cv=none; b=aZU8/aovDl4Y9+7bFKTqD4VdN3cn0gj4sFADI+ZgEk9IO47iy50q94EaOAYtEwsLdY4qd2px8sJ0n5/r8exYNntbHuVggzFnBr+3+644ysl9RIAxRQcP6hkhmNXRanB2azwzOodcw3//+ZRXDd9ntvtReMnL46M+PaYXKFhkxSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720807993; c=relaxed/simple;
	bh=sUheNSIamO8SvMj19zBLNxCVmjvlLRxDlh7AUAyjtXE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=YOi8HZsA6mlrh6q+D03Iw9jOMIgbp9QwiR5bQhDUverIU2RrtqCsEQ7cLMrwhcCUVgVL7qWFp4yVt1Jgc3cw+h7LFJeuGGhgqzxjwG7DPy59jvdh+EiSVs8MbYbU/Q4SdlCH01tSFw9mk1m3hZxBwGEpT0R71DBfSQfsJFHSd8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SjQrw9WO; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-653306993a8so37569207b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 11:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720807990; x=1721412790; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DzgUQ0L67yHK9ZgYOmZnLIT3MZDT9EVRhOxDmj12OGQ=;
        b=SjQrw9WOhPtCuoJDNhuMHweOV7gQ9mK7LuDbSS2TafyJHxozCGDaudmRZmuvbwNzkC
         AQJtP3//pCleloSeRtPxj3XZdKwarSMcNDYoIarIaEgdr96/GuEnD1zTnpCGFxyrmhl3
         2gCOkgXB7rqukJ2KBjxRGlRvoTAA6GdSoG9EYFsbWlsQvEB47dOfFV5MIDKlp4dAxfA/
         hTCCSuE3slbHIYE2aPyCAyaGw/AwlVdrVrX3PmxztJZl0qbizmktkBKJje/rNrUsjJND
         pjFp8zSSxAkTLqPtKwIL7XayZxHnxx4IQ01voSnVVxzd98/uNFMIIl7JuwCh45ja06uv
         5L7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720807990; x=1721412790;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DzgUQ0L67yHK9ZgYOmZnLIT3MZDT9EVRhOxDmj12OGQ=;
        b=kS16KEgJGdXl2MF6P8lF93TqZBrF6Y6HiB/eNRP5ih8WqCis8292Ud8e5Nv6w3oKuQ
         em/cWiSIs+gu8VPi5hEo1Z4e3INuWP96Nn+lF0KNM2hXfnljo/M1KVp8PXV3bOz2CHkf
         rRMqyENeB436Fu1Xgy0xKj0XALTXQMIgEI2G2yuOZzXvOVB5jHwWm2y/FI4WTSPcWkHx
         4ugc5aByT9Bp++kBEOW9kfTvpCHzvXtbMLuwHni64E6eO+8lzXUsXw+zMxCWoCiVEfYQ
         uFIxb5Pda7BX9Ct7WLHmn8awBz9GSH/ywyAdLhyfE1SMK3udba0St2P4iPhafSN+tYnY
         9dLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjAi/kni5TvUCfmVX3nJzyDcPK6UKfWqnRzi1OEKWuxQy63rirrHmFBJKFPJnifW6s0F88sNZB1vZIe/ImlQYNgB0jFqCsBYjKroZT
X-Gm-Message-State: AOJu0YxhP9RbpAzcdwcHGRFtEE8fPnnqluxUck0pPIJkprj/9L5ihZX4
	mp18wPzdm7oyQdRVp4eOS38lwx8zaT6HPo36uOMiySUtZyux6BSbses//kP/PVQykxdzfp6qv9n
	m0vt8+A==
X-Google-Smtp-Source: AGHT+IHiAKXzsCdcEZM+MFSDfgz1r4L7ozGy4B9BF+4puH4qqiiY89mJfDURywhS/WGVSxBcH3QuZhcuBDvg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:2e7d:d47a:a0c6:e3b1])
 (user=irogers job=sendgmr) by 2002:a05:6902:188a:b0:e03:2217:3c8f with SMTP
 id 3f1490d57ef6-e041b035055mr23746276.2.1720807990114; Fri, 12 Jul 2024
 11:13:10 -0700 (PDT)
Date: Fri, 12 Jul 2024 11:11:08 -0700
In-Reply-To: <20240712181108.475336-1-irogers@google.com>
Message-Id: <20240712181108.475336-28-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712181108.475336-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v5 27/27] perf session: Constify tool
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

Make tool const now that all uses are const and
perf_tool__fill_defaults won't be used. The aim is to better capture
that sessions don't mutate tools.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/session.c | 6 +++---
 tools/perf/util/session.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index ad5da61d2330..0c7cc092887d 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1765,7 +1765,7 @@ static int __perf_session__process_decomp_events(struct perf_session *session);
 static int __perf_session__process_pipe_events(struct perf_session *session)
 {
 	struct ordered_events *oe = &session->ordered_events;
-	struct perf_tool *tool = session->tool;
+	const struct perf_tool *tool = session->tool;
 	struct ui_progress prog;
 	union perf_event *event;
 	uint32_t size, cur_size = 0;
@@ -2195,7 +2195,7 @@ static int __perf_session__process_events(struct perf_session *session)
 		.in_place_update = session->data->in_place_update,
 	};
 	struct ordered_events *oe = &session->ordered_events;
-	struct perf_tool *tool = session->tool;
+	const struct perf_tool *tool = session->tool;
 	struct ui_progress prog;
 	int err;
 
@@ -2245,7 +2245,7 @@ static int __perf_session__process_events(struct perf_session *session)
 static int __perf_session__process_dir_events(struct perf_session *session)
 {
 	struct perf_data *data = session->data;
-	struct perf_tool *tool = session->tool;
+	const struct perf_tool *tool = session->tool;
 	int i, ret, readers, nr_readers;
 	struct ui_progress prog;
 	u64 total_size = perf_data__size(session->data);
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index 7f69baeae7fb..7c8dd6956330 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -43,7 +43,7 @@ struct perf_session {
 	u64			one_mmap_offset;
 	struct ordered_events	ordered_events;
 	struct perf_data	*data;
-	struct perf_tool	*tool;
+	const struct perf_tool	*tool;
 	u64			bytes_transferred;
 	u64			bytes_compressed;
 	struct zstd_data	zstd_data;
-- 
2.45.2.993.g49e7a77208-goog


