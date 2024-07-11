Return-Path: <linux-kernel+bounces-249671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBF192EE5B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAC4D1C209FB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B76217D355;
	Thu, 11 Jul 2024 18:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A62cr04h"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F2316EB4E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 18:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720720877; cv=none; b=WlawUJiJ6YFmG+d5wF15LBXwAfVoTRLJGy1gNy9XFs9Cav0JhRFel/aRbmbdcaXhWwl026Q9k5rpO6MTMF8jayOUOI7YmfZIINZldBQ1R+8liis+qMtol5NckzoZHaJa/RQ+DXH/Ile5INu7HXDEOk1kJVuiJlEqtXT1JtmuHYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720720877; c=relaxed/simple;
	bh=sUheNSIamO8SvMj19zBLNxCVmjvlLRxDlh7AUAyjtXE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ml853xuOMgYeZ6dhOSPtPPbe06gJBvj2yp5NyRrIJgSWdwcLVLV5p7Rm9KkTTNG7s/+Ql+1TvVRtvXYGjGlyC3Xdlez8zckhaLG/Tphh5A9rws3YccWmyK1tooZ3/FC6SwjzmyJn4XFwrO+sDZZqEXpOhlFygKV4sDer1YQihaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A62cr04h; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6511c587946so20063057b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 11:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720720875; x=1721325675; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DzgUQ0L67yHK9ZgYOmZnLIT3MZDT9EVRhOxDmj12OGQ=;
        b=A62cr04hkQQibp8J0OdcECSoPMzacbWQ/GxOr3Az4CjlWJJe12QTN8OUPgQSRlkVhF
         ENyvH1fbqpWq/A5FViAXBwUCHsV9FXQgC4lYX/GN33y6VApwYa9+vs47xiH+vOozn6Vq
         rff/IzHvuo8VlT29alNRbdHzWcyBDzAUo3SeZ5o2OuOSDioa/57NMBFsh2bGG7WChNdB
         fjSEbn5wUDbv3BCVnukhWLAOn5EygM+uc9LV9ttxFn7GAwO7tYNBK+3cy7wPfra5io+o
         TWDdF2QH0Nchz4oAL5oZ/OZWPaYGZiZy22rBGWNTXxy4tMQlC3ak5HoPtTJU7bGVq2Sd
         2NxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720720875; x=1721325675;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DzgUQ0L67yHK9ZgYOmZnLIT3MZDT9EVRhOxDmj12OGQ=;
        b=RBUdPxM/wjK3Llq7wzCEsaLmYEpBaBtw2g+r2iyPHtzFCh8tzzUdQ+DOF4T5AJaAki
         F2UJch4S6reWKp2j+SRhmKWMEOTGdDnDDW0wqUl2gVsEne7ZzHg0f1I7yaQQl7RRw4Y1
         2YM6f2KkwyosrjUf3MTUeEx4VLIZwsbjdS96n2iCJlkY7m9STfXTw+ROzI+ZJrWFX5q5
         QOLb3CFwsmDEfMmEiJ5dd0RYe0Hcy4/Mf0BIFuMSwy7HST7A1ijinGQsl2GyEU2mQvUo
         St3/v5J6QY+l7LZdfk7+C8+YJz5BDzyc5FHYfvWttBSTreTlp2mS0yTcKNCbzNuzWjcI
         Z+TA==
X-Forwarded-Encrypted: i=1; AJvYcCXDphCJ7WMnCKM/oaLBg74td0HonrI+oIMfNJ6Md1jKr2Jl5kN1tpeeqp54zV8yddCkDy7KiROKfCOgM8I/6adM6ZQhiRgxpTLVdZun
X-Gm-Message-State: AOJu0YxOyboNXyUWHNN+4HYSSjj9eDLuRrVZ/WfvaDKuwdzeZ7hzWTDL
	hN92hJdR+DtTDCfgcGqMMyVuO2oPua6jHUK+MEePkp+Bdtb6ssFMlzOfaNp1tOEj1JrqIBl2NrT
	llrF9kQ==
X-Google-Smtp-Source: AGHT+IF6ZsAvtsfjEpCo3Gdjx73peL+tpHFo6fSjhaKLM0gD5zmtULo0VxwhlOW9Ohb+tLATOGzcVSe0U1oD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bd08:a1e0:c497:32db])
 (user=irogers job=sendgmr) by 2002:a05:6902:2403:b0:e03:554e:f396 with SMTP
 id 3f1490d57ef6-e041b05b915mr366242276.6.1720720875256; Thu, 11 Jul 2024
 11:01:15 -0700 (PDT)
Date: Thu, 11 Jul 2024 11:00:08 -0700
In-Reply-To: <20240711180008.188906-1-irogers@google.com>
Message-Id: <20240711180008.188906-29-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711180008.188906-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v4 28/28] perf session: Constify tool
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


