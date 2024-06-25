Return-Path: <linux-kernel+bounces-229396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65927916F32
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09CCA1F21F5B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB7817D347;
	Tue, 25 Jun 2024 17:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tBFpHSP4"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0BC17CA07
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 17:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336389; cv=none; b=lpEFMroWMkOmEvPPydew5LlbYxQH1oRYSxPI1UOlFnoEkVPwLbco0lGgdM5FnsxZBFvcggr3rKrC+YWGHEvaCSq1a6WbcYsa8YIV1o+KV9Xeh289FXAiUazqaGbjD/CCFH3Lb11k3TuA3aiU/2+0/O0rsIuWqxPbl0YEVtNu6uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336389; c=relaxed/simple;
	bh=4MeUin7pNU+7EH/vAMBdA4pzYBDobcDnylKN7J0QNiY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=aITShZiL4dM2gio9LVKRPEppf7ZlG7b07T/92YSC2b1MMnf5ok4uWc3qu2zpoIfFt4AobPFxOj3ku2FgFPAtqev6xGcmDrGJSyPtEitTP6EunSOFLDuvHPsT11hSWjJHC2W73BxOptpSNl3ntSeecWdixV7q4QZXBJyNLZuPKxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tBFpHSP4; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-645eb1025b5so37622267b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 10:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719336387; x=1719941187; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D7OMHNdMQjRxTIzl2tG5KSezF1r+KBWLgOtS9uud1dY=;
        b=tBFpHSP4pXvPS5Sd4ZExU2eMmznpZ0liiMHE5rqF8eUmrI1rg/VzH7WCEQfAsSIJvV
         dEAu3GbWpjNmIjEJqGP4qakUyKamzmZ3DhE4A5ziX9jcftxNMM4ManTcv87XnyvbhI7+
         3VxQ4dEE26tuawk1EAnOYSOQlBNV8OWnm1yCbCrGAlIo1j0nr8eAIhg6JcvmuskROC7M
         GsDoh6BFAHsXDTeexBzsWw5oJBfQtlJ0fBbG5oyxWEy+3m7C4tbftZbUPsD9DuFR4aoa
         IN31PkfEQPOiqBgLcLcne3NZgURtUsj0i3YzgnwBRLzCP2sui2EZhv44Hl/SAPicQR6C
         VKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719336387; x=1719941187;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D7OMHNdMQjRxTIzl2tG5KSezF1r+KBWLgOtS9uud1dY=;
        b=SbwjzUdKIDOM1ysRDN6Wj7w+DDR/wnjTfj5IZGRkW7QMOqao18E9f7WkY7kMOmvO24
         ng1SzBP2XnOwTfa05udbcvsQDZRP84/+C9GgxOlDC3ah+nVYh1sGN1APMTHofU6FBZhT
         8ZqYVvOABO3uJ0HMqBkoIkXGDlJsQtaRZcrJ1joA1aOwkPU/kK61kZy8iV9ZH+QAOMJK
         /KTe0m7o6AUj7S8Dgo/FCrCPH77AWst1ZcOLYNMms1Hks4z9PC2kAcyF5EC9BnSHVAp1
         V7Sbz3ebQgAsK25W2jJztoglzG4040QXBGH7c/S+h5r/FTUlnUm3XDhp5bqLAe6AYdcv
         9pXA==
X-Forwarded-Encrypted: i=1; AJvYcCV7VXT5e0y8qHYr15mM9K7Yo2GvCoEemM5MhMXssPd9OA/CV6PBszZuYRJ1beCClA2dwG2wlHsQjy6WbIjyIObzpvMJXYsd9CVElWyg
X-Gm-Message-State: AOJu0YxuHW4hVNLbmcwIIF38GQXNuWEfnPoAfE95RKshoIDbmhodAOTb
	1CmiWdNGj/cok3Vxl/RJgSRQ3+JpoE8eja55vwJfaUFiVmyfkXxtCeFDJAOhyJI6JmpzsaQkMvH
	JWLLsKQ==
X-Google-Smtp-Source: AGHT+IH5h+dU+rx5/EzkOoL79J/aVaZxf4gqHCwS5PQ8xku91EOiUh0yDtxvx/LFGnUXXUyGm4vqfn586d+V
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b4cb:a52b:f9ea:8678])
 (user=irogers job=sendgmr) by 2002:a25:2d10:0:b0:e02:7b18:fd6b with SMTP id
 3f1490d57ef6-e0300f19e7bmr58675276.4.1719336387272; Tue, 25 Jun 2024 10:26:27
 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:25:45 -0700
In-Reply-To: <20240625172603.900667-1-irogers@google.com>
Message-Id: <20240625172603.900667-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625172603.900667-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v1 08/26] perf evlist: Use perf_tool__init
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
 tools/perf/builtin-evlist.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-evlist.c b/tools/perf/builtin-evlist.c
index 7117656939e7..818ab21c3f73 100644
--- a/tools/perf/builtin-evlist.c
+++ b/tools/perf/builtin-evlist.c
@@ -35,13 +35,13 @@ static int __cmd_evlist(const char *file_name, struct perf_attr_details *details
 		.mode      = PERF_DATA_MODE_READ,
 		.force     = details->force,
 	};
-	struct perf_tool tool = {
-		/* only needed for pipe mode */
-		.attr = perf_event__process_attr,
-		.feature = process_header_feature,
-	};
+	struct perf_tool tool;
 	bool has_tracepoint = false;
 
+	perf_tool__init(&tool, /*ordered_events=*/false);
+	/* only needed for pipe mode */
+	tool.attr = perf_event__process_attr;
+	tool.feature = process_header_feature;
 	session = perf_session__new(&data, &tool);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
-- 
2.45.2.741.gdbec12cfda-goog


