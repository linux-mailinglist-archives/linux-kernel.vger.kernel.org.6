Return-Path: <linux-kernel+bounces-290563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C2C9555CF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 08:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2C6BB22556
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 06:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC9C13CFA3;
	Sat, 17 Aug 2024 06:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FAj2ohnl"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D055B13CFB8
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 06:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723877106; cv=none; b=Ocvf1/VO6dSRtKbaxg21uvBgf9pWElLXpRyUDjK1x14SaAZAgMt1HGs3fqbQM1l2c+jrL1veUXnLWLCv+aqxhQNJPqavOF8SN0r4ma8bz2p04nGy2I7xlqB7gjdraxv7ksvgKlV+iTFST/1lvo1ElFCSrcDWo8de6GPa4JMaZPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723877106; c=relaxed/simple;
	bh=8O1Y6scYhFyMobEhQv8IUwAJvsd4pajhjp1TTW88UH8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Qqi3yho+mjdQSUKuK5h42kLcJVTvp5liuR2gIRt7r4ZpGm8Cy/qciZlC6H85VkYJw6wF895e09fY7w8Mc6s63BO/NBZx+T0By2j/SYEioRiDg8b92pizH1fjYLqYLF4WL1MulxudwUfanBj8yDHgIrsTb0PNpqYD2biYy29uEVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FAj2ohnl; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6b46a237b48so11848487b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 23:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723877104; x=1724481904; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mqApkqpthfyxrYsLzWSBaC2fZccyqsDwIPuPbR5JMvQ=;
        b=FAj2ohnlzB9VygWL/EvZj2BLGj5zVsb9Mt+6+EaW4pFQ1z0X81CASUOwAwELKK28qB
         +s0brJ1CfCG9jneXcGPbnyhWgcpat11CImHsUPN14DmmOLNEHW18f6R1WjdIoiWJbnMO
         ZNptJ33p3+g/yM4h4Q+mzLK8D/IPWuIBTSR4JWepiVOBCZ6oJSvil7OBc5651rI52819
         iRbD8GXonWtz3cv13JAjgT6/pW5HiUCIrIBERDJyYrFnWMadqGYy3tjxdLc2nZTRyXkP
         V7Zy+LF1yad20MJaTvmz02Q39mUM/2c/9vviG2a7a5o0qYF4gdkAs9LX0ZoYRarXaHsP
         9BwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723877104; x=1724481904;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqApkqpthfyxrYsLzWSBaC2fZccyqsDwIPuPbR5JMvQ=;
        b=hq4R2ZwK/rLPNgExdX8dUWwB6Pt/QAlcMcyvsoOxrChSEYk4EgRef7Qh8yQ6sn02pB
         OXeYuPg1op9yjYEnhg+J0syMqjpr2Trq885EGXjzTxSsB36XlUYKHphzVL0k2bugIPS0
         SFObgo5kz3XlvvFQE8mP07Gznxstm3cqrzm9eYkq1mtnA1/gJnD+4Q4WqUMvZuMio2nM
         NskEXlx5+qZDf5IAFsKbolk36wRIHuj0ksoX6srgkJMoDMCpnmlSHucc2Imrr95iP/7R
         nFnWsQ2nGw6Hr0PiHzHqxA2gcCJmY8Zlz46Z40eDlDz07C8cJCrqe7zVOHt7Bf4ufeoS
         ABlQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+GXeCiUN0Bt22RKVIUslDGmSr+Odv6uvx5hoy6XDYEW4V2DdtAmtuqOcKlyRnVTiJD8oMKwK3A9kiRRMlWGF5ZptR23Q1pRnbE2DC
X-Gm-Message-State: AOJu0YzJ2GKyYGWf5+Zz+rw8TsJ210BmgxO0yoAKmz+o7UJYPZ0Eg3Td
	WZKf4pzXc1oDZz6/usZsHYVZX3L+7AfxWUwIxkn1P1A8AZEn+v4DRtWLIL/qk5N8Zp5SV87eyLB
	owBolzg==
X-Google-Smtp-Source: AGHT+IGg3LRJosB9auNcaghrQgueNTv/MMX58STgLkl4G0wV2VDI1N2aFQK4MBeoUYtE82hs2DHfVEmhWdmH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:78c9:5e58:734f:c59f])
 (user=irogers job=sendgmr) by 2002:a05:690c:4c82:b0:6b2:7ff8:ca3 with SMTP id
 00721157ae682-6b280074fafmr1410557b3.4.1723877103765; Fri, 16 Aug 2024
 23:45:03 -0700 (PDT)
Date: Fri, 16 Aug 2024 23:44:30 -0700
In-Reply-To: <20240817064442.2152089-1-irogers@google.com>
Message-Id: <20240817064442.2152089-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240817064442.2152089-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Subject: [PATCH v1 01/13] perf synthetic-events: Avoid unnecessary memset
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Casey Chen <cachen@purestorage.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Yunseong Kim <yskelg@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Anne Macedo <retpolanne@posteo.net>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Make sure the memset of a synthesized event only zeros the necessary
tracing data part of the event, as a full event can be over 4kb in
size.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/synthetic-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 7f884d70de81..0a7f93ae76fb 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2200,7 +2200,7 @@ int perf_event__synthesize_tracing_data(const struct perf_tool *tool, int fd, st
 	if (!tdata)
 		return -1;
 
-	memset(&ev, 0, sizeof(ev));
+	memset(&ev, 0, sizeof(ev.tracing_data));
 
 	ev.tracing_data.header.type = PERF_RECORD_HEADER_TRACING_DATA;
 	size = tdata->size;
-- 
2.46.0.184.g6999bdac58-goog


