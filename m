Return-Path: <linux-kernel+bounces-231487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 157D0919937
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 478701C227D7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47682194AE5;
	Wed, 26 Jun 2024 20:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Raq4/Ux7"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267C8194AC6
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 20:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434224; cv=none; b=IzaKU75RuZY94GVrucLjcBBYSH/X5hkkQInpgQF10HkFiVdXQMqwcDSym1FURcsVhsu8RhXEIHrq4biM9XG8VERiJJM1+i4pT/RDOHj+uL97GsuG19LMas5GkCf/gAMiC9TqWsxZmbC5A2C+BZtHNGf2aCkBolw2Zl4Uy/HUMOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434224; c=relaxed/simple;
	bh=4MeUin7pNU+7EH/vAMBdA4pzYBDobcDnylKN7J0QNiY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Y0ErvdRO0q7EX/k0hNSBlIzI7eRCInkmc26xYgqjVShtU52MKgaV3MlvKDfJzaR/fyDHg0DzEp/Q3ulbZNGRGeVjM4eRs1gQoRUl/NiQLx5F3DtUxv8b+R/yW6QuyRUaKXiDodPSQaobcrHL+nlzXD69o4RhwOVCSw8CmZqXTRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Raq4/Ux7; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-63a988bdec8so139362377b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719434222; x=1720039022; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D7OMHNdMQjRxTIzl2tG5KSezF1r+KBWLgOtS9uud1dY=;
        b=Raq4/Ux7ZNXCNsuZ42LKzdxNgY8rmoUoztjk045aaGzxCQjuwZqOrd81fEyX9dvMBO
         iYNWQEUwT33/s0rq32z8ppuwOeO1ONtsge90n9NuZ2ULPQX68Lq3CRU7dD/tQ5TLDm4j
         /8pER6My/DIF0k7lKB/9SAvDNele+ws36ghoA5cvVpwbwmSj90IXOvidiaLr2SBGCcok
         fPTzuNMcCJ3DYMWkKrXKcp6lBcKNuErJfiXItEm7JXBS51ZmLWG0O7oZB0g/wFORgy6B
         WHxi0wCrAXJEHbnTZD6i8QkzKvtu7cibQ+1dy+SCTDbxcPkclVQn3jFsq2WJSIsGyjkS
         qy8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719434222; x=1720039022;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D7OMHNdMQjRxTIzl2tG5KSezF1r+KBWLgOtS9uud1dY=;
        b=uRxS3tHM8NHYo40uIe+oV/5hn+nSqksEnqgPhxzHPe03OChmkP56k2OuALps9Dc3pO
         cYOlcLqC76/74lbAnOfWS7PWvnF4k0n312ciIrkOGEFWLmPXHT/07EI85WXTM+PEpKcO
         XhsxxMGmTFSBx63Y7otSVubiQqoa5ixMOoAfojMjZ6M1WFN2xIal2dDYrH4c1YclSOeP
         +DF5Cu0Dp7ues6RAC5OQu/NzE/C6MqLJeeKjrK3dEbl0EqQJOAyjgeaxxSD9Fecg4YDQ
         ugNiEy4uz9w3XooxRSiJ/QiqeqexjThA7pdbW5++X8JFYiXua406AzBOWYNnhmfm7mHY
         lvkg==
X-Forwarded-Encrypted: i=1; AJvYcCVShWEKT9He9V/MjwygjXk7sBuWIuI2Y6tkWqGjAzjWMSru3n4lrqFWA/+aNqDqEVFbxS+Y7McHsjp5JrjCqRszg+ndKWQjVFqtUPIq
X-Gm-Message-State: AOJu0Yxdc6W0rQ0wVhv2xQc3//x1k+0gwrhspEcl89nqNt/zCePnhK7/
	+L08e59oWjxzhaUpz/zZPLBwTzQhFASyYnoBm8tHEPB4fgCakX/6rdGjBMKb0dbs61YHu+uCa4l
	o99SWQg==
X-Google-Smtp-Source: AGHT+IGZVnE+Fch70MEK4rYQnkRBHIJ52T6vwPjRKNsQDQ2mlZBvGgRLnTbFrcJmRq10ailgH9nGrqLTUmBR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:23a1:25b9:2412:56de])
 (user=irogers job=sendgmr) by 2002:a25:aa6b:0:b0:e02:c478:c8b9 with SMTP id
 3f1490d57ef6-e03010e732amr25868276.12.1719434221944; Wed, 26 Jun 2024
 13:37:01 -0700 (PDT)
Date: Wed, 26 Jun 2024 13:36:12 -0700
In-Reply-To: <20240626203630.1194748-1-irogers@google.com>
Message-Id: <20240626203630.1194748-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626203630.1194748-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v2 10/27] perf evlist: Use perf_tool__init
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


