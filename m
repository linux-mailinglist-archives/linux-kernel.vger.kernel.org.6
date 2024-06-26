Return-Path: <linux-kernel+bounces-231486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B69E919936
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABD4F284E13
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05867194A60;
	Wed, 26 Jun 2024 20:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uG0PR/Zx"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0758194A5A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 20:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434222; cv=none; b=hu7ZCETFhToZ+D9gnqjQDvlSRJ6bX18jVKtq9u8/0y6caqva3WBo5NvvqG1Sjbt+fs+K3dUWxYICiFo+mmG/nBEsQK+4YCe4eusoCtTSUlCt842brs6IEWSAftpBLPs7yeQ+6e8UUXGlZihDh5Tmj+Qteuf0A864cWykqH7qgzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434222; c=relaxed/simple;
	bh=RFTmrZzGTM9IWPWjHq70q/GKoQrds29ugAT8XNOZor0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=O0cXtZXi/xOaMMpQiBMV20YskJSmLLLcPaQewQ1xmGmxfd57PHuSpGwI4mIVwbVPMSXeJkuH4V2SQpu5HG6Y4Z/QZVsWxyzV4XjCzeXhzM8rdJfzvklsZuSshR3yBGh02c8qW4auZy2cqhL21/06Gj/bPjBn6SK2/uPUaAL0IsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uG0PR/Zx; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02f2c852f3so10746790276.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719434219; x=1720039019; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W+G0HGMTQoy+2+TKDBA5eg+niEy3wMk5iRiA3dPthGE=;
        b=uG0PR/Zxn96VV50kPaOiNhQ9PnN+2+GtKgs7pstJ68kOMELjgxSbjBTOLDfQ26Pfjj
         aq1VocKqA4/EmtvNcu8y06tQ3Bti4MwVO5bmxkuTnNaF9uCEtHTNT+XBsZv7JzBDE/0Y
         7jnXtsr1XC94pTcyLoDnVOAIRHBslqposIPMlkgSzRRru2y0+X7rGf/LYW6BLMFBFW5h
         J8562fE8gtn06PCMcE5vrOAzaF92+4ashp+gljyJtVmQtxl9LIM+W7BODCcSYM5Zna2Q
         9UBtTGR3x35uTMvneadKLrKkXQ12zJ53g31Bju/4zEAYt0XjIYZXDbp3U/CxVEY7JoIT
         w5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719434219; x=1720039019;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W+G0HGMTQoy+2+TKDBA5eg+niEy3wMk5iRiA3dPthGE=;
        b=N/6auzoFqEvK0z/OKX4DFrzZKyRGgBulrLCvaYtZXexom4QkGocuhlNTKuZoJYie1V
         BVpeF2YUpKJxZjH1KyoGTEvBTuXHmQk86O7Dm9spPw4D6U4shlQtGVQxq/LFuVn+qgPu
         VDOqpUlMh19T5MWlelDqQ4K5zzOFkrhrRwDjcFdJ5qyJSZvgy1V+Ub7EIMVXf0h5NHUP
         Cckq8f0T8iDMveizRiR8VeTtUWTJeahvkvWC/EWAOeyBgIvxpKcfQGUICxIg5TP9nByL
         ZmwIjiiAopApLHo9K18rv+z9IEjTiVTfKM9+xLS1jE5wrpdJCUIjIeFF00Ec+nN9KGh5
         x5/w==
X-Forwarded-Encrypted: i=1; AJvYcCXbSDQvrWTMJGIzvIAZhJNg5IRKp5lI5OJguoKv+vxaNiy8chDwBaVY9qrm6RzjxOmG7YEasaIlZoWGfXyNtJ6Q6H8/uHjwy+3DMBJ8
X-Gm-Message-State: AOJu0YyY3InodlrQdkE+GXN0X/GinkbIBZq2syMtKeMOQCPm6BJFLw4a
	5JhCA6NE9Ajn7nfv87US6vEQ1suA8qOWvcP0KllDtDJQE2xVrkd50CScqamQM/JhyjJnlHAyhF9
	w3JPypg==
X-Google-Smtp-Source: AGHT+IGFNPE1mTzElJCJfk3y8lPhljBftC9JeXwX2Xh4efoZ4u/33kjM0V9SfLs8rKr6O0JpSXmbu4IU89Bx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:23a1:25b9:2412:56de])
 (user=irogers job=sendgmr) by 2002:a25:c591:0:b0:e02:d71e:87b5 with SMTP id
 3f1490d57ef6-e0304009b41mr375405276.6.1719434219631; Wed, 26 Jun 2024
 13:36:59 -0700 (PDT)
Date: Wed, 26 Jun 2024 13:36:11 -0700
In-Reply-To: <20240626203630.1194748-1-irogers@google.com>
Message-Id: <20240626203630.1194748-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626203630.1194748-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v2 09/27] perf lock: Use perf_tool__init
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
 tools/perf/builtin-lock.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 6efa9d646637..2c216427e929 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1933,22 +1933,21 @@ static bool force;
 static int __cmd_report(bool display_info)
 {
 	int err = -EINVAL;
-	struct perf_tool eops = {
-		.attr		 = perf_event__process_attr,
-		.event_update	 = process_event_update,
-		.sample		 = process_sample_event,
-		.comm		 = perf_event__process_comm,
-		.mmap		 = perf_event__process_mmap,
-		.namespaces	 = perf_event__process_namespaces,
-		.tracing_data	 = perf_event__process_tracing_data,
-		.ordered_events	 = true,
-	};
+	struct perf_tool eops;
 	struct perf_data data = {
 		.path  = input_name,
 		.mode  = PERF_DATA_MODE_READ,
 		.force = force,
 	};
 
+	perf_tool__init(&eops, /*ordered_events=*/true);
+	eops.attr		 = perf_event__process_attr;
+	eops.event_update	 = process_event_update;
+	eops.sample		 = process_sample_event;
+	eops.comm		 = perf_event__process_comm;
+	eops.mmap		 = perf_event__process_mmap;
+	eops.namespaces		 = perf_event__process_namespaces;
+	eops.tracing_data	 = perf_event__process_tracing_data;
 	session = perf_session__new(&data, &eops);
 	if (IS_ERR(session)) {
 		pr_err("Initializing perf session failed\n");
@@ -2069,15 +2068,7 @@ static int check_lock_contention_options(const struct option *options,
 static int __cmd_contention(int argc, const char **argv)
 {
 	int err = -EINVAL;
-	struct perf_tool eops = {
-		.attr		 = perf_event__process_attr,
-		.event_update	 = process_event_update,
-		.sample		 = process_sample_event,
-		.comm		 = perf_event__process_comm,
-		.mmap		 = perf_event__process_mmap,
-		.tracing_data	 = perf_event__process_tracing_data,
-		.ordered_events	 = true,
-	};
+	struct perf_tool eops;
 	struct perf_data data = {
 		.path  = input_name,
 		.mode  = PERF_DATA_MODE_READ,
@@ -2100,6 +2091,14 @@ static int __cmd_contention(int argc, const char **argv)
 
 	con.result = &lockhash_table[0];
 
+	perf_tool__init(&eops, /*ordered_events=*/true);
+	eops.attr		 = perf_event__process_attr;
+	eops.event_update	 = process_event_update;
+	eops.sample		 = process_sample_event;
+	eops.comm		 = perf_event__process_comm;
+	eops.mmap		 = perf_event__process_mmap;
+	eops.tracing_data	 = perf_event__process_tracing_data;
+
 	session = perf_session__new(use_bpf ? NULL : &data, &eops);
 	if (IS_ERR(session)) {
 		pr_err("Initializing perf session failed\n");
-- 
2.45.2.741.gdbec12cfda-goog


