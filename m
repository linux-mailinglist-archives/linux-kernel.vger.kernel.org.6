Return-Path: <linux-kernel+bounces-402214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0DB9C2510
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BB61B23F26
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CF11C1F10;
	Fri,  8 Nov 2024 18:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lsJfQ+nV"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBABB1AA1F4
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 18:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731091683; cv=none; b=iS5a5YeECHMBfCJl2e3Kgol9E5msRxy950AYiFp0yd9kThVsh+g3wsfozMpY0lmoX6zeL4ydvkiALW2iD6LCG1lrOlvAyahmKQ06ioDduBTttCW0XEZ30KLIqRVl1xlln/+zOWe0P0I0nLF12gCgAqswFH8qWD8Ogp/Ck4ANdxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731091683; c=relaxed/simple;
	bh=xunf4UD8j9u0pgFlFlHCMfIam9X2Ammz7QNjpmkuuIY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=dMYH5/Gj7BQPLzyYXAP2KW1EABOtozCZ6GcSokBBEDgK1zuQfWKAqWXPxXGZ7m+OukYkZya/eZ6+WX3q4UCoRrdPbnqbVnrUmQwOe/JEZj6SqNPzm+N0LLSvsuXQW5SOPIdDKorF/vRgVlG3TTXsjRMNXD98P4KPpE0LC0/+cbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lsJfQ+nV; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e59dc7df64so30616267b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 10:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731091681; x=1731696481; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lh8Vm/QOELe+otL4qaVRvKv87LkZrYQhVCrXoxQ0vBg=;
        b=lsJfQ+nVBNXjXiJCTTxWWhHGrw5R7Uyk5iD4xMHhxRtXffSFQMM4LXLYoPNUZFFlHf
         gMuBmbbDvtGcg/duAKxSU2hTchSYRMmhirMCnzngota4kLcT2seuTbEdKm8Q3axn00G/
         S5/f2rrZMifE8IRTcpWO74G8MvZWmHs/PracsP7H9xArmjlCmCl+tfbZyHA8NXkU2WaV
         WIO9h7uHXm+YOs5zNvGcyXwOXD+rP5CtE+b5ZEwLYa96dg1pWdrNVBDivmVc/ndPqqVo
         zQwQEBBWe1JekxrtTr5XVI7vxO1/0b5Tx3aaXdhKSN3YCW3MBORH5iLzfnIBwj72dNw1
         ebhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731091681; x=1731696481;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lh8Vm/QOELe+otL4qaVRvKv87LkZrYQhVCrXoxQ0vBg=;
        b=iQDn4u6GxgxBH21+6t+W669rZhUjaKVY/PCYeYo7ydB3IHqFAX3vBypn4xFu6gxhnC
         nXoOfsH7s5AqNuJ/vB7PVHx9sv3FqMDLn8bb+tOD4IyPp/MlYvH/XkrWOHUWjuNtNRdS
         /+/4Pkkulz3ViAjeOH9qis6KvyncJ6GLoRvItMwyA48mHahGslMOm0c2MdANMRtiM46l
         PrhtxYv+YPZQ/0purjFeZue7ivNvOpjYd2gaphzHbBszSQnjdGPTD/OiDkGZ9YJBqHDw
         p4z5T2zq3sT5ZoKxQ5oSC3THcUfeakBR0OltZZNFextGX8XVvONCTmhFSEYMI9XD/RAg
         eEUw==
X-Forwarded-Encrypted: i=1; AJvYcCUZdA5OhX6pOkObvf1OGPag9qwWoCSHLX9JqwabwKCGRDEvu9LNcAemXe8tNNeNJr0ZGi2OSx1vJVwffpc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo3NbD1O6tgHT2qlQ5Qo63RT0/UidWc/Pni4ebvavXeAv6Ig/T
	sdvLc2s4gRHqzsEf25VQjMgewh/O8fhDOF+TyGsyCdG3FibHHKC4yg4J8hi4Z+NZpGlU27zIqe4
	hM6RS4A==
X-Google-Smtp-Source: AGHT+IFPk7Rumt8mMYRdDzGIzXRZaVCwQYz/e0WwSEXkae/UW6D+RBmX2yv8dudXz0wiceaycmFGRt5CNVcv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:6fd2:1e36:6d8c:7c49])
 (user=irogers job=sendgmr) by 2002:a0d:ef05:0:b0:6ea:881b:b545 with SMTP id
 00721157ae682-6eade535166mr659907b3.4.1731091681015; Fri, 08 Nov 2024
 10:48:01 -0800 (PST)
Date: Fri,  8 Nov 2024 10:47:48 -0800
In-Reply-To: <20241108184751.359237-1-irogers@google.com>
Message-Id: <20241108184751.359237-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241108184751.359237-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v4 3/6] perf trace-event: Always build trace-event-info.c
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

trace-event-info.c has no libtraceevent depdendencies, always build it
and use it in builtin-record and perf_event_attr printing.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c               | 2 --
 tools/perf/util/Build                     | 2 +-
 tools/perf/util/perf_event_attr_fprintf.c | 4 ----
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index f83252472921..0b637cea4850 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1748,10 +1748,8 @@ static void record__init_features(struct record *rec)
 	if (rec->no_buildid)
 		perf_header__clear_feat(&session->header, HEADER_BUILD_ID);
 
-#ifdef HAVE_LIBTRACEEVENT
 	if (!have_tracepoints(&rec->evlist->core.entries))
 		perf_header__clear_feat(&session->header, HEADER_TRACING_DATA);
-#endif
 
 	if (!rec->opts.branch_stack)
 		perf_header__clear_feat(&session->header, HEADER_BRANCH_STACK);
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 1eedead5f2f2..609c69995c51 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -85,7 +85,7 @@ perf-util-y += pmu-flex.o
 perf-util-y += pmu-bison.o
 perf-util-y += tool_pmu.o
 perf-util-y += svghelper.o
-perf-util-$(CONFIG_LIBTRACEEVENT) += trace-event-info.o
+perf-util-y += trace-event-info.o
 perf-util-y += trace-event-scripting.o
 perf-util-$(CONFIG_LIBTRACEEVENT) += trace-event.o
 perf-util-$(CONFIG_LIBTRACEEVENT) += trace-event-parse.o
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index 59fbbba79697..a73c74b99a3b 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -212,7 +212,6 @@ static void __p_config_hw_cache_id(char *buf, size_t size, u64 value)
 	}
 }
 
-#ifdef HAVE_LIBTRACEEVENT
 static void __p_config_tracepoint_id(char *buf, size_t size, u64 value)
 {
 	char *str = tracepoint_id_to_name(value);
@@ -220,7 +219,6 @@ static void __p_config_tracepoint_id(char *buf, size_t size, u64 value)
 	print_id_hex(str);
 	free(str);
 }
-#endif
 
 static void __p_config_id(struct perf_pmu *pmu, char *buf, size_t size, u32 type, u64 value)
 {
@@ -238,9 +236,7 @@ static void __p_config_id(struct perf_pmu *pmu, char *buf, size_t size, u32 type
 	case PERF_TYPE_HW_CACHE:
 		return __p_config_hw_cache_id(buf, size, value);
 	case PERF_TYPE_TRACEPOINT:
-#ifdef HAVE_LIBTRACEEVENT
 		return __p_config_tracepoint_id(buf, size, value);
-#endif
 	case PERF_TYPE_RAW:
 	case PERF_TYPE_BREAKPOINT:
 	default:
-- 
2.47.0.277.g8800431eea-goog


