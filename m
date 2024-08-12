Return-Path: <linux-kernel+bounces-283767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 716C794F881
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B9331C2221C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669D7198A0E;
	Mon, 12 Aug 2024 20:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VDWH2Ojr"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A1F19E7F7
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 20:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495709; cv=none; b=gfS6iF9pTFoEYp/r2g4vStJ+przFL9htv78dD9tQLglV8AYEJr6YDqGUq4U0flYwygvWYGL+cEOGn9pQ97PyiDRM2uo1hj2wvHkpd3KdlO60DkDElb/SySIgCGcVS0xKGlyjNOtyS2uZBAe5pI/EIX7PKVAVwU7v0xnhKREjFGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495709; c=relaxed/simple;
	bh=cov7foVGktnTU+1VpOC6fkSOoDWyjnwMmCK5fmzw0ek=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=tlVVr88fsAFwIU6zvIVDFfq489B8/xxRjHaQTvPkj1OLBp+oe7yk7nTtLruOw7djSaTWOVS8np4ArB5z1r9k4fUezpaFtkV4QaMG3qzvlLdR4Tuyaj50v8ZTzZeoeDlF7FvdtOnLeQAdtALOv674Jajg1NMHcwxTKrlH3gLWBRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VDWH2Ojr; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0e3eb3fe93so7795476276.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 13:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723495706; x=1724100506; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4wczZj/G5PmxA13DCbaUvl0QUyy3P1R91oRL5UB3198=;
        b=VDWH2OjrDzPAhvhFPrf5ludUp1YB5nxRvb02hug33xWji/hYm3p7lZsLi1aeAyU0gC
         xaHsR+E7+52rTrRzF8Cs3sYk3P1vbokXBQb8C7cxMypxTmdKMndEHBBg8dFILauFaGcQ
         vSM58U3+M3YH5TStvmT4VnoBzxWf1I/ltpfNIP3lTA20SNRukTz9VjYwRAFww79DWYGq
         NxUTulnq5UNdOFWKre0xbtB7YlzxuDx878/V3ue8JVcxZFNlwH6eb62Oh+iHee7dHO2Q
         wv7Hv5Vbt0fmFRv9sldn0l3AIP0uf9OcdoqW98OXF6SZasgU+mnS0WthRHFTbmaGm+kJ
         0dwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495706; x=1724100506;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4wczZj/G5PmxA13DCbaUvl0QUyy3P1R91oRL5UB3198=;
        b=C5rKPM3chiXyDFHDF0TyEvJ5SU3A7kl79wAlv2U3D65HCB7ikGJeGRpXlmHK1xbHx4
         qQDD64pPCnp0aqmDGRR77KVj0gSS7tDxIjMgogEh5H48quv8uijSIa6D2hMR3aCW4FIk
         j8xOzunz2XzFfSYKk02gxjGVoq/sj7a7d8lm4bWOLSoAZvoB2CyNml2woRLNJ+44mrJ+
         gnufMUBQYJSORXAw6DjOyDfJT5YTR2Y2V/WJji/Jz4ZXPNRV2dPQDZDmuH8ORDRTSt1y
         3VKbwOEFYj4BNTCpQ9WqiK5kOa9t4WlxCSvK0HfaaYcyHdubMyLn21jaVwygLwhHp2fV
         rIDA==
X-Forwarded-Encrypted: i=1; AJvYcCXDBX6s0NLDl1hGFVvnPXeHKewrgOmKUTk8pAzAp1zJ9j5kiadoGd2Rf0PBhiYy+mz3zVpc7aoal+LVe8d/5lCIhQoQllRt07GYpLIB
X-Gm-Message-State: AOJu0YwJ28j6eWTAS9CcZeiRvLV8Ly2KCxLyUXro7Fm6lIRT5uNXSTr7
	6WBtmVIxRzziKF4a4NQHnkfWbiVdRXfgk2LyDDfUFyYjiqbi+g440b8wVWW6Pd+tsArEv+UMxN3
	uYH2GwA==
X-Google-Smtp-Source: AGHT+IEEkdfVbmMdg47zJ1xwMISs3qxpK2W4sG4GNErhBkvDAcSIFEm9nvYqC0j8/UjSL/PUOvwkYvjYDWoT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e7f1:b90:720c:35bf])
 (user=irogers job=sendgmr) by 2002:a25:f30d:0:b0:e03:59e2:e82 with SMTP id
 3f1490d57ef6-e113d27c9a9mr2472276.10.1723495706163; Mon, 12 Aug 2024 13:48:26
 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:47:19 -0700
In-Reply-To: <20240812204720.631678-1-irogers@google.com>
Message-Id: <20240812204720.631678-28-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812204720.631678-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Subject: [PATCH v7 27/27] perf session: Constify tool
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
index a8404cc99cfc..d2bd563119bc 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1770,7 +1770,7 @@ static int __perf_session__process_decomp_events(struct perf_session *session);
 static int __perf_session__process_pipe_events(struct perf_session *session)
 {
 	struct ordered_events *oe = &session->ordered_events;
-	struct perf_tool *tool = session->tool;
+	const struct perf_tool *tool = session->tool;
 	struct ui_progress prog;
 	union perf_event *event;
 	uint32_t size, cur_size = 0;
@@ -2200,7 +2200,7 @@ static int __perf_session__process_events(struct perf_session *session)
 		.in_place_update = session->data->in_place_update,
 	};
 	struct ordered_events *oe = &session->ordered_events;
-	struct perf_tool *tool = session->tool;
+	const struct perf_tool *tool = session->tool;
 	struct ui_progress prog;
 	int err;
 
@@ -2250,7 +2250,7 @@ static int __perf_session__process_events(struct perf_session *session)
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
2.46.0.76.ge559c4bf1a-goog


