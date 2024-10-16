Return-Path: <linux-kernel+bounces-368539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB0D9A1106
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 19:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12D971C256B3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC247216A13;
	Wed, 16 Oct 2024 17:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yxf9k3vJ"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EC5216A14
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 17:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729101254; cv=none; b=Wy9wjyQx+OR/sYMm8RLp2cQ6+sZsAtZGEo6wlA3kM0tG5MxuUGc+1AnoZ0jfEsiCWoX2AxB1hB1gX3EL2BXCcKG/9f4sr1HQ5cDFYwQZA4lWHF4aCgyOJTl9GHZgu14+Eee9iyJk6xAnTh3dC9k47sLhACMOxGu4YfEHL3oJZLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729101254; c=relaxed/simple;
	bh=fee7TAq/eP5tzXna+g+K/Sx9L8xSc4L9m1SCV2eHqNc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=hed/04vo+HjNOT+0oAAS2REuRxJuBvMCyUHzftkuIzWhUn0Go2WR9FzH9DKrKSWEFj9gNBcAPmCulqQw3ohCHijbZNtaiaBmg6MN0CSUWgqMrgXNL0LkDBGyMcOlOLo0+4P438odZME4E55wM2y7RMUrmo5eTjJvBA1g4ZR1hAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yxf9k3vJ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02b5792baaso74641276.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 10:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729101252; x=1729706052; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vsMWssyTOvP1WMheCN0DpJ+nfzBtD5CMizHYReN/aDk=;
        b=yxf9k3vJeI89kk2mvr1QoC68znsICyXQbdgq4uYwVWntBuvmuJFvi0LrAfQhlB9aCa
         Xa1+qB1UeFMsfRykBb8jq0vnFBFp9T7VDKxOk67ZvwGMx51XYfflJKeIh6YZ90JyLuBt
         tJX38ulotvqeL3gRkDWkg+gVM8ObLXXQ+hkEeoHF2R5vrtNRuHOEz4FqO7eF3Em08KPc
         fArljDBAiqF0Ce89RFkms11f2fisiYnIUbddwEt5naQw5NzpGWmFf7wwwgn4aQR57d1e
         2KAsBRRyVsr2tpNui2GVSrbZvjccyDROog2xgY12XMtFAs9PuyVbtT9EBEIJRPJQy9Nr
         O8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729101252; x=1729706052;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vsMWssyTOvP1WMheCN0DpJ+nfzBtD5CMizHYReN/aDk=;
        b=AOBPDC1TsuXeAAc/sf3GmXBFY89304nwCJOoTIsKmVSoifH+tjwB+6Eiq1bl+BVfQ6
         bpXlarKWZa0EFKGbtb4aaEHnLD+CoH6MqkR0Y1zvcCTBmyyg3Z3NtDbSAuQ+Po6eHu9e
         4wWdqAiVy6iPI3rdEoSg5QrnJ+53Eq0WShbXzYeVBuhj+3mofZxrZeNxFKpsS8B2iCvN
         MvMVB30fHIWijth+KZR/UID9bJ0+p97AREtA34N/lkPGhXXJxV4MfxDpQcEL4J/5WS2S
         homl02WOTLmMD1tjI7WVrgilPnhlFrrHo2hP19FmEiQZTrS5Ykrz8NelTRCVoDHfCMkV
         jFgw==
X-Forwarded-Encrypted: i=1; AJvYcCW2JuTh2hsg4pCeRRiIH9VjwQeFSqGQy6t+wQF4NKj9/vsrOscK4etK9r5M3+zPpcPj5sFMz1wb0+s+ERw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN8a1NYj/cBHPgfJqGHs+Z0eSQvC3Bgm4exb3wEyhfUFLROPvz
	z7aBJoHN3geWqk5LewfBW79q2MVZ4grBJMTS50yFvl1yB4oS8u1y7hVpN2t9KZM4Tot8gUQHPf2
	E3l1ejg==
X-Google-Smtp-Source: AGHT+IGwzJ8F80Se119mAueQ7bqO735E4nJLUizxWDlBOxLr87KBzIrWBt25r2jhZ9ZswgpsimkIQAxCJR04
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a25:a2c4:0:b0:e25:caa3:9c2e with SMTP id
 3f1490d57ef6-e297858905emr5272276.11.1729101251943; Wed, 16 Oct 2024 10:54:11
 -0700 (PDT)
Date: Wed, 16 Oct 2024 10:53:50 -0700
In-Reply-To: <20241016175350.116227-1-irogers@google.com>
Message-Id: <20241016175350.116227-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241016175350.116227-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 8/8] perf stat: Disable metric thresholds for CSV/JSON
 metric-only mode
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Yicong Yang <yangyicong@hisilicon.com>, Weilin Wang <weilin.wang@intel.com>, 
	Tim Chen <tim.c.chen@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

These modes don't use the threshold, so don't compute it saving time
and potentially reducing events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index b5e18853982c..60d747c2e0e3 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2561,6 +2561,14 @@ int cmd_stat(int argc, const char **argv)
 		goto out;
 	}
 
+	if (stat_config.metric_only && (stat_config.csv_output || stat_config.json_output)) {
+		/*
+		 * Current metric-only CSV and JSON output doesn't display the
+		 * metric threshold so don't compute it.
+		 */
+		stat_config.metric_no_threshold = true;
+	}
+
 	if (stat_config.walltime_run_table && stat_config.run_count <= 1) {
 		fprintf(stderr, "--table is only supported with -r\n");
 		parse_options_usage(stat_usage, stat_options, "r", 1);
-- 
2.47.0.105.g07ac214952-goog


