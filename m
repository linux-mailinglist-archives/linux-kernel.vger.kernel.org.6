Return-Path: <linux-kernel+bounces-413585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A269D1B4D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 23:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F47FB22F7E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 22:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C581EBA12;
	Mon, 18 Nov 2024 22:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Myh8Isev"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EEB1EB9F2
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 22:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731970472; cv=none; b=WJoq3c7KFoIxU8OWUeb99EkU4bzabm9W4TOndK/aLvXjUI/kJHZBvZEOplNfb6NnZv+7jUdqjSuupHqA2ryF7uz2VXULs4iQnOJx6kN30+ML4ZVXZBAyb4WjelnovZpqbhUAfivaEYevlTDohY+LhF80QPGwOVgdzHzpphymP8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731970472; c=relaxed/simple;
	bh=vA5wDZ8FL6MLUmxSvynTx1BhyBJedSIPLTdOMqvm9LU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=jbIugOkLBrAoA95TWbDOtO4sgMSCT7nZ6KxJrt5H8P5X5833X7o9ZoCMWzc2VP3xgGF4VvcvyD0vbrAtkiXgXje157dilIoaJLUMSrKnYIz/5k1SUn2TVu5wmWbRFdRxGoZBWSefzAgIQ8giPn1zRD3AToAO/ypb+mT4Z1RMgh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Myh8Isev; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e381f195051so533777276.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 14:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731970470; x=1732575270; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=55WiVKsndQFaxxZ4QGA42VCMnpZnpnS70BqjVyyPtNw=;
        b=Myh8IsevvdAU5pnEEY32Bi17LrAQApSh+W/j03qsmboTu2rVyd1f8RyuZFY2Hwz0+0
         tUVW5d8HIv2CsdRuXcnKdteiplgCmHnqxs/jl28dF23qen0gdhwvcDTGaAuJHVanaWwM
         JQnvVkJIoDF9dhSbiUXu0xX/p8JurNnt+GIDcWEvcMY06w+VIn9kGV5BsPTqGTNN5VgW
         o4mt9a1favgmtEI7bfiSwTLcLVjdyQAO5tpn4f0z18yx6zigow67hTGv8PHLL8p1h/2f
         /kvE69rsFNF3V7F0mne0HWkvvabN3YRouO35gwvYefUBw9WwxsU0oi1PI1ZnKCl7bjBS
         y+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731970470; x=1732575270;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=55WiVKsndQFaxxZ4QGA42VCMnpZnpnS70BqjVyyPtNw=;
        b=GE6zHcydpprW6ca6TYxL0+PKNbbvMd32N3w4oOk7+ZoD6m/ZBr35suRbxgmv5Nw+aM
         QjUkniBpYE8iNtgLQ97T0fbbWCBqTFISUASy5dnT1sPBm8bU090OZUkYzrqYzzFxqK9D
         414rn/Y+naZCPr7S9w1lxoWEhF4IE1xxihWfeRu6EE25aSfyM/Wdich8gJYBpwpzTK30
         3HvRNXmh+rkM03jYPoVbCpKg/XTAbXAqBjkcjVmrqZfdz5+QbHdGI7P/4rn2d6iLVAE4
         0uU4iMyDkTgpcRyQ8fa8CQ9qxtc5V0E4jhoIBF594p+IHZBCuYqAbDFZUIPAYi+WrJl2
         RdCA==
X-Forwarded-Encrypted: i=1; AJvYcCXso3zoRTmzY4Eao6DLZ0Y0I1U16q5buyKmFBMNdQBt42xVoHE7ltGh6jtMkokj8nRbgyZ4wmULZJSOYsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZgqs9/kh0qGjHs/7FgcfpKZcUN0KcMxT3jJbQz5YTqbqz4IWo
	wXd0jyo7puV+4otgFad3oaYNzq89rVn3TRX3O+kek5YRX9CW8EJQvmfABf+l0jqzuiknQlKHIR6
	0SlQrtg==
X-Google-Smtp-Source: AGHT+IEnzfOOnKnsl2wElo/yWtr4ZvRaQdLFyQfunTe1jiNtXAdPQKfXDrXow9PDuQmLSZJD3ZO4Ga/aIc2+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:22a4:ded5:5c37:fcc7])
 (user=irogers job=sendgmr) by 2002:a25:df87:0:b0:e38:7793:62b4 with SMTP id
 3f1490d57ef6-e38779367b8mr151863276.10.1731970470161; Mon, 18 Nov 2024
 14:54:30 -0800 (PST)
Date: Mon, 18 Nov 2024 14:53:41 -0800
In-Reply-To: <20241118225345.889810-1-irogers@google.com>
Message-Id: <20241118225345.889810-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241118225345.889810-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v5 3/7] perf trace-event: Constify print arguments
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	James Clark <james.clark@linaro.org>, Dominique Martinet <asmadeus@codewreck.org>, 
	Yang Li <yang.lee@linux.alibaba.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Yang Jihong <yangjihong@bytedance.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Ben Gainey <ben.gainey@arm.com>, zhaimingbing <zhaimingbing@cmss.chinamobile.com>, 
	Zixian Cai <fzczx123@gmail.com>, Andi Kleen <ak@linux.intel.com>, Paran Lee <p4ranlee@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, 
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"

Capture that these functions don't mutate their input.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/trace-event-parse.c | 2 +-
 tools/perf/util/trace-event.h       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/trace-event-parse.c b/tools/perf/util/trace-event-parse.c
index 41d53e1b43e7..9c015fc2bcfb 100644
--- a/tools/perf/util/trace-event-parse.c
+++ b/tools/perf/util/trace-event-parse.c
@@ -99,7 +99,7 @@ unsigned long long read_size(struct tep_event *event, void *ptr, int size)
 	return tep_read_number(event->tep, ptr, size);
 }
 
-void event_format__fprintf(struct tep_event *event,
+void event_format__fprintf(const struct tep_event *event,
 			   int cpu, void *data, int size, FILE *fp)
 {
 	struct tep_record record;
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index 79b939f947dd..2543bf969fdd 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -39,7 +39,7 @@ trace_event__tp_format(const char *sys, const char *name);
 
 struct tep_event *trace_event__tp_format_id(int id);
 
-void event_format__fprintf(struct tep_event *event,
+void event_format__fprintf(const struct tep_event *event,
 			   int cpu, void *data, int size, FILE *fp);
 
 int parse_ftrace_file(struct tep_handle *pevent, char *buf, unsigned long size);
-- 
2.47.0.338.g60cca15819-goog


