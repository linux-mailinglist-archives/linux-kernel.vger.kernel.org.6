Return-Path: <linux-kernel+bounces-397166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB55A9BD793
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC6331C227E4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B2721645A;
	Tue,  5 Nov 2024 21:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q5nwL+nK"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EAC21643F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730842028; cv=none; b=nKKRNyrcJTNBLHAnLVutfOaO6sbNv+8FHB0yNzeDnXQ+NyMYzHTmvy4MqG0OkuJfa/6AQzduitUN6+TKelKIDAmalpXTgJOuQwoYUe5nIWt1jO8cjGvhGE0M0M3LC7+dvKGB/CzOnKto9njYFw6bvY/ef+R0R1c1c3wuKlysS38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730842028; c=relaxed/simple;
	bh=fw5FTiisDk5cyhf8wcogBBpQyMSz0nXrYiG3JWj7IaI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Nqbkjpqsca1O3evTOLSYXNXFSe/gcoyjHkHjBQEzURLU12+YB0dL+/hQvhbN6BA+bLHP531XqZUPIV2radGSlEox6RoipDiKcsk8hGp1o+qKH4gGD2u7qbMQzxWJfQM7BJuuYv7sulj9Y8cxMhtnwSn27t525EizC70/s7LJDpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q5nwL+nK; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2e3321aae0so9256245276.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 13:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730842026; x=1731446826; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QCWMpv5edYfDnb5d8WWLsWf6rYHjMo4DKAX+NrFH0Vo=;
        b=Q5nwL+nKC4aChy7+kotvKLU9PuHStTcrtgn2M0YLZnPsyX7+ntetXyVWbl9Fe5H75N
         Me6Hcwl/8MES5fZ/Ja6GQY/mHUX2+QO+zv5fso4NTPNXEdpGyoahEbFo39zK+K/irfsO
         ZXgY2kU112OVu0aOgknwPupNu5Hpf7P/9aoxpTvfUixUJAwcdSSGMXslY4ZklmhRYUfW
         x0ZJebOoSBX/0cmmEALggZOEmR6IwN0HqaQoQ0+allq46tfaX8xw+K0lBbLDRQa58gls
         HoUJvCtdi750PBmfxr07qOVYFj68fEdY3mamolOBGZ23nwaGcSt1SmdUCdRxWVTUet7+
         Bd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730842026; x=1731446826;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QCWMpv5edYfDnb5d8WWLsWf6rYHjMo4DKAX+NrFH0Vo=;
        b=TL+EaJoIsBLhRhEK3EFro8hFRV0jTPKiRlV6J0NoNx/jy7o9JKX0xdT8UWO0Qevm4T
         ssEMxTpZf92rgf7mO+Pkpkjh4f/Bzjo5m9tWhsx9IpAoJw3F6dKCDdF5Jdaw5ljLjrIF
         bm8W8w/w1kgx6fzCCtKPCnOAvJJMWWlGum/GjhY6r0kK+cc399TttyvDYl6kcIFinQVO
         5qCQgdhzFVs+1BYYJK1177xTU8mAYF12ijgKHzZzfWG6Bx0r0f0F9YSxR17mYd8Q1Veg
         i1V/s8RnAABsVhDytnUWFgSnPpCrgY2O31/linaLTHNBuER4/hBAQvbzcISJSWdXAf00
         ee4A==
X-Forwarded-Encrypted: i=1; AJvYcCUIPqPkxqjF7b6c7u2Nw4leanLOcPYVXDd2s2OQUez78V+d0maTpJdipieC9ydNx7pwuPdKNV0wpc/A36w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT1qbq+s9D8GnJxCsnFhxaO9Zknq3waqSmWNuvpsgid+K3zdrI
	H2uF5+pOfD8l1Refs/aDYToqaqh2owKuC9z2tR6rlyA0u4cIZUdnHwtw2f/sVkbcPa3Uues1H9D
	ZCxvdAA==
X-Google-Smtp-Source: AGHT+IGQnG3PzotYn3w5dRLN75V53FPNsdkX1P6AsVE1rPf1lD2zR9HPjWOt2zF3Rm8ZEU/FfDMAT4bvTT97
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ff9e:ab12:75ac:c1a0])
 (user=irogers job=sendgmr) by 2002:a25:acc9:0:b0:e28:eae7:f838 with SMTP id
 3f1490d57ef6-e30e5917b41mr16656276.0.1730842025995; Tue, 05 Nov 2024 13:27:05
 -0800 (PST)
Date: Tue,  5 Nov 2024 13:26:49 -0800
In-Reply-To: <20241105212652.401943-1-irogers@google.com>
Message-Id: <20241105212652.401943-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241105212652.401943-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Subject: [PATCH v3 3/6] perf trace-event: Always build trace-event-info.c
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
2.47.0.199.ga7371fff76-goog


