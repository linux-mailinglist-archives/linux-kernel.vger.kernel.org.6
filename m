Return-Path: <linux-kernel+bounces-251064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 094CA930043
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 20:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF51D284747
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12CE17C232;
	Fri, 12 Jul 2024 18:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sJevOxMw"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDDB17C208
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 18:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720807967; cv=none; b=tpl06o863UZhWC8hdksceQsicvArPMPpV2Kff6F4jWeYKcOPbzb0hHdxiRpWUsH3KdXTGgKuGHgMJdDmDm7d+uae7R9BAimSeCRwxtnf+lwVR0IAKr8/4Ua9QkhkcDtVO8kHDlkEArC7fHL8M3SbABdkIWeUvTf3RKlKBKc10jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720807967; c=relaxed/simple;
	bh=Oatp9vP9864WSMM6h8L2eaSDz2osyW3W6s5tTUlCsXc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Wt18QXEo7V2s+D8DPLYw7jOtbB24qKxB4TZi0UC8vIKlCKP/pgfXEiFVSzNw0QsRqbNEm8Ch80+WN81wWW23gd9JOf0G90Dg1gVE6VKQXBneuCgnlOOeH72Fa+4xzpdqCHwb5feT9sx4ITGL6bhtIc13UOYWZEh0wwRq6JcdB8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sJevOxMw; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-65b985bb059so39750457b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 11:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720807965; x=1721412765; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GhKzAhRYOz6Ff/7gM3raH2p2+7D3XZwc5l/hw9g7Qeo=;
        b=sJevOxMw3gvebegY6KUhx5Yc7gmhNzCyc4XsuZY52Axk8uInIYgcFstMGW5Qm59unI
         HWsZHLFJ8POlHw1NhHDhww9V10tiuu9P6Oz6fBSvIr7ziEwFDnW9QjjOp9YG2MEMUIlJ
         Zw6kQcwh3xkWHaxinH4jaGorIV/fioX42IWmApxmLxq9uMEnQAexsliEAl70EPkO1tKP
         dDC0kPKhlglkq64s5ODFEZtpx+lD0E6mAujEny03OIAssxqY6nlI1kXrBMY/TjyGoA8d
         CBIRAO5JgaFr28/bfXSgEQKA91FSV9gGhGzNFsud3bTtLMtrKfrq1AD+qV8YNFKHgPJr
         yABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720807965; x=1721412765;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GhKzAhRYOz6Ff/7gM3raH2p2+7D3XZwc5l/hw9g7Qeo=;
        b=XlWJhvtdOIu3h+PApffDnSY7aGsOunYNgjvYyOOY1AW1+GFYewrsXJc08TKiYdfpW+
         X4VPB6wTaOFJtu53xSKUnUJKt8Cz9SvRTY4D85BClUcuvopgMA1pGPWEjxH7118s0Xmr
         PRbnpW/ke3DjsBwqxstHwztjwpNEs9tgtElrM7LoBr6N2fDcxZUI9IM8nkKmmEaqKoHz
         7PhXQa5Thb4zQllVPtMekiodJIY9VPydAxwNhOOphZdR6hU++27WMK5nGeRz1bjSpoLJ
         lPTgC80d7b82SjUsDxFMdiK/V5jrT3Zf2yEpLt2CZNJ8HJ95QpANRJUg5hEZuEAKisY0
         X6nw==
X-Forwarded-Encrypted: i=1; AJvYcCVlQ/NdwG8iB9H9dVFZFNXzqL3B9h4MYdaCssE7BJYXaZUswjIf182qiWpHt/bnUldApR//xOKE9nWCMxwj9BNP4WoFECseWZMdDT8A
X-Gm-Message-State: AOJu0YyXqB3zH7lAuBnEODo56VyVkIcsmZhejNAGN+6wboiDLzDahdKh
	Lr0xwrltvJRwFNLBu+HLCIX7/V0p8/PzbE1T1KHwKbQuBmjRxn4rsY+xV03mhvknPqv80RbXecA
	oFT5fnQ==
X-Google-Smtp-Source: AGHT+IFhYPk2jTBuMlhB8gOtTxMBnApQKnxVWvq+XTICOK0WnJmqAo1AkbwwG2wHV+rrMbesLDOHGcXiSffq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:2e7d:d47a:a0c6:e3b1])
 (user=irogers job=sendgmr) by 2002:a05:6902:114b:b0:e05:74ca:70ce with SMTP
 id 3f1490d57ef6-e0574ca77fbmr459024276.4.1720807965562; Fri, 12 Jul 2024
 11:12:45 -0700 (PDT)
Date: Fri, 12 Jul 2024 11:10:57 -0700
In-Reply-To: <20240712181108.475336-1-irogers@google.com>
Message-Id: <20240712181108.475336-17-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712181108.475336-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v5 16/27] perf stat: Use perf_tool__init
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
 tools/perf/builtin-stat.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d460c46f15fd..a3d77a55d17f 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2271,15 +2271,6 @@ static const char * const stat_report_usage[] = {
 };
 
 static struct perf_stat perf_stat = {
-	.tool = {
-		.attr		= perf_event__process_attr,
-		.event_update	= perf_event__process_event_update,
-		.thread_map	= process_thread_map_event,
-		.cpu_map	= process_cpu_map_event,
-		.stat_config	= process_stat_config_event,
-		.stat		= perf_event__process_stat_event,
-		.stat_round	= process_stat_round_event,
-	},
 	.aggr_mode	= AGGR_UNSET,
 	.aggr_level	= 0,
 };
@@ -2322,6 +2313,15 @@ static int __cmd_report(int argc, const char **argv)
 	perf_stat.data.path = input_name;
 	perf_stat.data.mode = PERF_DATA_MODE_READ;
 
+	perf_tool__init(&perf_stat.tool, /*ordered_events=*/false);
+	perf_stat.tool.attr		= perf_event__process_attr;
+	perf_stat.tool.event_update	= perf_event__process_event_update;
+	perf_stat.tool.thread_map	= process_thread_map_event;
+	perf_stat.tool.cpu_map		= process_cpu_map_event;
+	perf_stat.tool.stat_config	= process_stat_config_event;
+	perf_stat.tool.stat		= perf_event__process_stat_event;
+	perf_stat.tool.stat_round	= process_stat_round_event;
+
 	session = perf_session__new(&perf_stat.data, &perf_stat.tool);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
-- 
2.45.2.993.g49e7a77208-goog


