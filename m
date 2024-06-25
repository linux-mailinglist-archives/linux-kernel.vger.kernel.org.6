Return-Path: <linux-kernel+bounces-229412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 614C7916F44
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 178F8283175
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AE1181B80;
	Tue, 25 Jun 2024 17:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xLc3JCJm"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E227180A83
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 17:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336427; cv=none; b=PHBlEtLXWgRFLh3NjftsncJcbuvzUEj9Nw94SJPnPEM4M4uSAvAfGwkVsw0IFea4hro4clPqgDpeaXjZ4jEf2njACn1OsSmCPsXj29rBL0hg2Axb5VF78YoMv4nrhV9aAbJlxgvJSCRx6YSoc14D8nl06KsMee/nukl9HYECRzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336427; c=relaxed/simple;
	bh=k7QXVgVjC5ziryU8iqEZw+jIGB8CNwx93bpexssSTVM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=V3zUpssxab8K27yWm8L2g7LTwwalBDrC8yY1U3T6qYcvMGs2z0UM0xP5Da80uNUzIIVpPOfTgzC/HrY21yQiNr4FQPiC6kAfDwjw68XPSv5SJcWw9T/EbGgxFplsx+JzkK+cVZjdFiPvEdXxjTKTrKO/smDaNIQQH/ajecof7fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xLc3JCJm; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-645eb1025b5so37634237b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 10:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719336425; x=1719941225; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wAL+qN5eeqrm/YV9CC2nA0bNTj605bqM/+2MNtl5Dek=;
        b=xLc3JCJmqV2S0+8H7YZV6O1/pqmfnOeYtGfsAmzxk8Yiv9PIrIUmyW+ZRH8MtZkt/c
         GNVlSZvCDEo6rMfEmLeEBDpvWcIzdPMR4POANFLh3E6FTyKRxfmx4sR97GScZInxpDOk
         Kpud/mWlellw1BKYPu6l+gflkxdOntKqtPguIKQl83FW5RojcpaOkhZl7xuh16G+AnFl
         QWdBsXYmgHRgiqdco1x0HTH6q8KKoG/Nq8DglP+lmXJWp4gxgdSb3+2BuRcV0mLpyX0O
         /fpX+rlxKK65jeHCUG/QtaeaB7JBWhNiX8QjeS6L6AvR+5zgUqgYukOPMH00etCFpydq
         2rEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719336425; x=1719941225;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wAL+qN5eeqrm/YV9CC2nA0bNTj605bqM/+2MNtl5Dek=;
        b=Z5gx0IWCsdMtzgofrwbmtL3iUIoabt5iDIQrArBMCx+rXQ3Jxq5SXBLgVuS7qdebQ7
         AJ0nJVCVk8a/1h7Owgpb52UECLTcYXBcrmyoQfSXqYM06leCRHueGzAm5WpgUq81/ztu
         WSmKiF1peroW2zJKAkNyIVbVbxEGuTN81tmVkpppSEoCEPeRiBFI1DZoENUt1O1xRt3z
         Xr8P1YCLxVHibIZjeTUBROnuKV9rahQOVRVFUCMW1rNc7GhtYxrkiMck8VJCLTlYcMg4
         LyLBdptHAGwDqNJl9/RsUYrpBGVJIt/BjjfSIThdG96u/giFl/iXTkqEqhvq4k1gUL+B
         kHJw==
X-Forwarded-Encrypted: i=1; AJvYcCWVMvvL+JX/Y1xR9jZyYGGWA1bGaZGAluJ0yNpeZV4jENpcYCc1bWmCqQ3DpxU9J69eFIDO4gg0W1N5v+n8PgvjcsEn3P/t+yKRL5tv
X-Gm-Message-State: AOJu0Yyg9rljFjCwkUiH1GhLtYpTA2pTvl7zjsb+xHRiIyx/DTSKmrCx
	dMUUQX/5H/bFo3vgaR+9AI7FFFa98fEBcBDSNRSRPyNyE4UJc1YZE7XWJ8IEFo3lldYiHKOjXz0
	LqHVxAA==
X-Google-Smtp-Source: AGHT+IGD6NROzE2EHc5jjqSHDQHS8KekgYNdRcbDS/mIM8HTKqE/Qyr/e8zZMvz4P4dAQ8k6OBlvKbOYHFCe
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b4cb:a52b:f9ea:8678])
 (user=irogers job=sendgmr) by 2002:a05:6902:1201:b0:e03:2583:13e4 with SMTP
 id 3f1490d57ef6-e032583168cmr45685276.8.1719336425108; Tue, 25 Jun 2024
 10:27:05 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:26:01 -0700
In-Reply-To: <20240625172603.900667-1-irogers@google.com>
Message-Id: <20240625172603.900667-25-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625172603.900667-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v1 24/26] perf kwork: Use perf_tool__init
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
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Use perf_tool__init so that more uses of struct perf_tool can be const
and not relying on perf_tool__fill_defaults.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kwork.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index 8ffaa80a2d1d..6a4281b8fd10 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -2322,12 +2322,6 @@ int cmd_kwork(int argc, const char **argv)
 {
 	static struct perf_kwork kwork = {
 		.class_list          = LIST_HEAD_INIT(kwork.class_list),
-		.tool = {
-			.mmap		= perf_event__process_mmap,
-			.mmap2		= perf_event__process_mmap2,
-			.sample		= perf_kwork__process_tracepoint_sample,
-			.ordered_events = true,
-		},
 		.atom_page_list      = LIST_HEAD_INIT(kwork.atom_page_list),
 		.sort_list           = LIST_HEAD_INIT(kwork.sort_list),
 		.cmp_id              = LIST_HEAD_INIT(kwork.cmp_id),
@@ -2462,6 +2456,11 @@ int cmd_kwork(int argc, const char **argv)
 		"record", "report", "latency", "timehist", "top", NULL
 	};
 
+	perf_tool__init(&kwork.tool, /*ordered_events=*/true);
+	kwork.tool.mmap	  = perf_event__process_mmap;
+	kwork.tool.mmap2  = perf_event__process_mmap2;
+	kwork.tool.sample = perf_kwork__process_tracepoint_sample;
+
 	argc = parse_options_subcommand(argc, argv, kwork_options,
 					kwork_subcommands, kwork_usage,
 					PARSE_OPT_STOP_AT_NON_OPTION);
-- 
2.45.2.741.gdbec12cfda-goog


