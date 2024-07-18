Return-Path: <linux-kernel+bounces-255844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3785193459A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 03:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 669E61C21122
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 01:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921A912C484;
	Thu, 18 Jul 2024 01:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iC3rjNlq"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A803681ADA
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 01:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721264504; cv=none; b=r+A/adBxyAHRafkbJQNWxukv7kqt4huU8d4B7XlzZoEiOGGCP0IWiq6V9NOsduqYO4hFBdkCeXMLswF18836snQR1bTVzDxGPE7WrtCaCrIZ29WW/1I9kjXIk2o75kaKpFXsXopFvoByp/Hn1Nne3SInxRJqMW7iZmNZd3AEzhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721264504; c=relaxed/simple;
	bh=Nt/c1EHasj2QZc8mVbjZQ0vxsj7VTWwQPPvRYVn2ii8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=slAzAeZA9UwVRooE/+63CsoBB5XX18TksivGRWQCgdBaSgyzTrIlwG3Yvl4E8gox+F+MAbTCcqcGD432a8RGSJVd9lZA5YAgx8vpqGxZEpSDhjLjjj7u4TUzHRsbbOOZ7s2FWfbyjO+qNsnFxup1uyW4vQde5PlSrt9EXzjki4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iC3rjNlq; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-65be82a3241so7206327b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 18:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721264499; x=1721869299; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VI+1UrmSH+U4tsTCU1WpnUiPEx/6DVcJnUZK6PtxySs=;
        b=iC3rjNlqtXu2d2djsF0UBPeTT5+7b++di0WS/SZsizZ74v6G8vHppOLITCVRyJMXlu
         kn2WotlbgrBox/E/KSrVHkMzoqs+8X8uhYgA9wO3QgJsiM1gtEXuvtZVXpMvBUsReu17
         kWtKhCuAMuD5Veqxan8G7f6yTqnTNTGcyRP9syna61e406YXghn2ZfZj6Y7aE78YhIQR
         XUG/1I0YRcGs3+wOyui0/aVfUt5jOFZ85yZLZsQuYNU/YIfi61slZGAHIqZQEtNSL2DP
         n8UPpt/nCpu4lHoep+bF9ncH8Axs/xfc8NGL35FauW79WOqCvX9z47KRq5nB4wn22Ftm
         aAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721264499; x=1721869299;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VI+1UrmSH+U4tsTCU1WpnUiPEx/6DVcJnUZK6PtxySs=;
        b=M7zAJ6dITaniHH7Lu/ypQfei56w3TKfDGNe2d1G3vmeJIMWy19bDhB2AmDQsfVNFsN
         M0ea1MippbkkcHM5DkqjShtR4XwoQDCjd1HUE2CoUAdC7UN1GzS8YWu8NboLBviY6Lap
         tqbX/JAMR5dtId9J4e1SfhV6y7pzj14apJBZH5jXVxSyCbDlPQAe0Fimybx3rypnX6VX
         Fmsrod81t7iKc6TgZrKC2TSwQTQTsGrs49QPMw03PWI9kBPeiRX2w67dj5rmKB6Chn8j
         YHte0na5klRwGZiTeKwE84qBIuZCF/0KrvLM88WbF0lVJ7yySaqoiF0+nZmb+tzFPXCk
         nElg==
X-Forwarded-Encrypted: i=1; AJvYcCWaylKGxTY4DvJBUMR7WoyaccT/Mc9tbF5IfZbklflgVuD10jGmCU1Ek7bdHeDp6Qn8gpo4jL0laH5OuYyGat48ul1u/SkwU3uhck4O
X-Gm-Message-State: AOJu0YwDL58BjJb8W/KOO0ibT7rWvEceNOhEq+wZ9GClu0aNV8ShlcC+
	ludrBVHTlaRUU0M33btWPmJmCaOMByevwd4Y/2iz8ZZb6U/IlXEtFWoU0WB6hLJFR9WOlk6He6a
	4CBLOrw==
X-Google-Smtp-Source: AGHT+IGQt5ri8LAL7TX8J0R4Z6KxrCn64uDLn1sYG1dmmUfG8en4e1ioo3g5nWqMwIk/M1O4Qs9bCX+5dLdq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a05:690c:110:b0:65c:1db1:9235 with SMTP id
 00721157ae682-666005395bbmr263907b3.0.1721264498698; Wed, 17 Jul 2024
 18:01:38 -0700 (PDT)
Date: Wed, 17 Jul 2024 18:00:23 -0700
In-Reply-To: <20240718010023.1495687-1-irogers@google.com>
Message-Id: <20240718010023.1495687-28-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240718010023.1495687-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v6 27/27] perf session: Constify tool
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
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
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
2.45.2.1089.g2a221341d9-goog


