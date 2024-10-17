Return-Path: <linux-kernel+bounces-370360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CB39A2B7C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A1371C26D7C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BF31E0DAA;
	Thu, 17 Oct 2024 17:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VUS5cl+y"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D44A1E0DAC
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 17:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729187659; cv=none; b=NwivK51TBXf1YxixMrnTBz7SMnaj3wKluaNjT2iqRmOdZv3A3nYbzbS9H3s3PXYqlwTWi60mWTn7XO0QeM/euaQo+IDoqL2MhTWUYnE8BfjkkPngT5AD+iuBQISUwIBtP500CUKDani/DbBKqM6YBwDlisdiyWSbdf9AOVHjr9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729187659; c=relaxed/simple;
	bh=xxNoLSb6kFTUL1OnMX+2sTQ86EFI5XTgz4LWu0BFnc8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=b7dx0MJxD6tfOdNnz0DmCHZGdE1O4LD+eY6HvCnwtIxU+g7/onfl+dFrNUT2VkInHXgl/UZcFKx5rGbPgLlZSKYSDygGNSS98Soa/X+HVm1AfBfCD1/aptmI2hml209KcQpD+vUq6OIGjFJybfoFnf9cp4vUGg6IzNoMR+y/5DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VUS5cl+y; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e376aa4586so28308747b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 10:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729187657; x=1729792457; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PO/jFnTS1VOsCUFZImr0igUuGTgy/DTrx5IiSFpgwUc=;
        b=VUS5cl+yUoP2TpeznihAmka3Wrb70iK4SYQwvlep4VLO2fkAJAkysaeNAVRh7ECgQ5
         1fHjPYk1AWAGp14sSQaBx7fGI+n3U0Mo91OeUO8bBJCZTnVKAW1KFUIle4nH8mWHgP9t
         XacJt31xqJMI9sN4ALhf1MCUlPcqLHZ1QqaOb6OfQACkBzGL+aWlCXLUsYtiG844iXJa
         pAigQCou+j4q4mPO2soq82OD7hc79m8dWcYQNDYMI9z1Qsx2in9vahdxYY7Sds4qkM6r
         gcxeLgeXjpeZqKzWIeEqzerECPB0S0w1SAun1+6VBDjfydxSWLFtkO2XesgE49aqKXqF
         JwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729187657; x=1729792457;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PO/jFnTS1VOsCUFZImr0igUuGTgy/DTrx5IiSFpgwUc=;
        b=jbQo58azmZfEBjhb3jgSHPMzvJBrZKmGcQhsW9WozAn0XgSvirPcegNs38GBTQDqkm
         ZsqTuBYAc9hxQ/9zLA9hSG/HLR5HTGuQpe9fjD0Kmk3NugT6JSTJWTpSl54LTzNhCVTI
         Y+9aWfyESs5Y/M9r2n+ab3AnWnlu/Qhet8svCflzCkE9NgNCwnVIM2iAzKHYIE86VXtO
         EwH3/Mul8cLzKc8V0TzMKUN+kr26GZpLsXf+ou0NNzkMEQlVYuvhABpng5PJrGbFgnpt
         5hZbynirgMsnBNkP/CfvstZg6TgqZSn/cEXUkrdsntc7g0MMlawJQkTqm2vVvUDoA3yz
         zqYw==
X-Forwarded-Encrypted: i=1; AJvYcCXLloaN9yRkbNhpeLb9DiR1cUvQNKVW2kc5URONPAN5Xl4PT9iO7A70kz8oRyVPiX4zDmZmt9PYK/rHZ5o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1WL+qLdT+3HiIOEE+77SisOu3CmPKLyOiC1Q+TvaZeTrxw2Dd
	nNqp4LrrzArOvQQvCucC5TXgMywJxlsLLYBkuIJwqrv+PYbaxWKbVH40sewhF9/wzC1kKWxFmoZ
	hz+f+tQ==
X-Google-Smtp-Source: AGHT+IGQyAokEHLg7BxgQeLFlntRMpKEp9jucxTE9lGEQ6PxGbHfEPxS4ADwCWI7ULTb1Y0UDNtXj8bqnFar
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:98a5:142e:8c2e:e9e5])
 (user=irogers job=sendgmr) by 2002:a05:6902:1c3:b0:e28:ee84:e4d8 with SMTP id
 3f1490d57ef6-e29783006b4mr4728276.3.1729187656920; Thu, 17 Oct 2024 10:54:16
 -0700 (PDT)
Date: Thu, 17 Oct 2024 10:53:56 -0700
In-Reply-To: <20241017175356.783793-1-irogers@google.com>
Message-Id: <20241017175356.783793-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241017175356.783793-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v5 7/7] perf stat: Disable metric thresholds for CSV and JSON
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
	Yicong Yang <yangyicong@hisilicon.com>, Tim Chen <tim.c.chen@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

These modes don't use the threshold, so don't compute it saving time
and potentially reducing events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index b5e18853982c..7639ecda6c05 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2561,6 +2561,14 @@ int cmd_stat(int argc, const char **argv)
 		goto out;
 	}
 
+	if (stat_config.csv_output || (stat_config.metric_only && stat_config.json_output)) {
+		/*
+		 * Current CSV and metric-only JSON output doesn't display the
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


