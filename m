Return-Path: <linux-kernel+bounces-249642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B391792EE2D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2EEFB226D0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6308516DEA3;
	Thu, 11 Jul 2024 18:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wJUOL54z"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C65F16E861
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 18:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720720822; cv=none; b=pJnD8tMkRm2r6E+x9arnI0JkiL4lxd+A70NLZzLA2zPvWRjt6KjQJIY3wTDHLUf2UmQjy+hsC9zr2/5q52gAcrgfNFnFZWgfqvqqShzgVXlmhdx3MpmqmvzSIB2DO0RDEQ4qO7Gncc70vNwwC4lK+Om5IOzxbxauJGvrZrtnd1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720720822; c=relaxed/simple;
	bh=MIIPAWLI0WoNL5OJW6h8lhVqWFcyLLZdhSdtRXLZ1T4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=pWjPmKwN1KqTo7Xh8k9QREN1vyrwwxXzikTZhwjy9qHpiKTRLzwMUACD7mzpMVrEFpr9Ums93+kRI9UL2g+AYG3AnJ5B0SueOBxZTtmLmKXVe/gTROIM3JnpEDIQPHxcfmIlXyU+pvrqGQiyzMhE5vAMpHMvXRCBI27a9loBjiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wJUOL54z; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-651e54bb41bso17348037b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 11:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720720820; x=1721325620; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EzUK4p38UkhKDsbfF93yQRR2GPAzqU4EO+HGDDPIb8o=;
        b=wJUOL54zlCKWRgBqG0vTrTEPJ3JIkhvVC41EjvZJfmkJySztLfVuaDvlvkQwl04Sn7
         hxgT2+7wPQCZwAlmo1qlaShC2ionI6xOTYDgdxvJQkq7+Tsu3Mf5p1kdQYBD7yQk/UvX
         aXfaaNqixyvguJ0AmMkExaHSdB6QL2Gzc6JjM3aKgzfkBP41XqdtTtiJ4tLsnACQrV3B
         W2YuItARD6B3x8ekdnjthDwLC9qqhoYAviPBtAF/pXQaUHOI4I/q3k/zRy5Edkcn+xPy
         cSsA5p6worJY4XMEFkTW6JGZxPECdjwA6qQZ9AmVj82zMAl7b/0HtlzTMhmOZ6Ictc8E
         5yQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720720820; x=1721325620;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EzUK4p38UkhKDsbfF93yQRR2GPAzqU4EO+HGDDPIb8o=;
        b=QWvzRv4LQW5PWThd8g1VF9p9cJBP3LdS7z7XQxbmqmSJPILFV6CGAviT1fXaSZc2+6
         Pi8LMEFVfseLLCT0pdEs0zMXMU+H/4MvYd2EQ6HieaUepFFegnc5qF4e9ZSFA5dONRhL
         Pabv5XyqGGgs4pAiVrof2jWyGey7TlZNMOFX/ISjNb4yr4HfauDtkChJ0Q1OrlzoMOYr
         NFgyZXoZXL+Dt97Gs0iJeqkp0b0jHSuhneslniVDacVWGtcIxll8yrOlUbb8eW1+Guj/
         tmuG3T6fPI8Ef/NCqJ6EvJ5r57Mjn2r8etJx+QhO9wAvKHtNaOsLYnbmi1HtsSxZibDJ
         3C+w==
X-Forwarded-Encrypted: i=1; AJvYcCVbbTXpci7cg7G7+O0LJSOek4YZgsOUzJUVm+YgdB5d6rl9oP7+jqG+HnbDJp3cx9YrWpcOTU8DYzWyt1rjLQ6P9NGJGZKPviMLrkgi
X-Gm-Message-State: AOJu0YyktUZ67ZF7akjcGZW6kHJZeyliLDo1D5MfaVwJtZc19WiQV3T/
	csKNaQyZhlc5MufQgi1i0ID7evi/cRc9ujlhzSm2UA6HB2b0HQFKzpA2WKbSu0R86qPu1iObtGd
	7q+jCSQ==
X-Google-Smtp-Source: AGHT+IGk7HjCBqWpD+d/XmopT/Hsmtv7wH1IyWS+4QZ4y11/DDN/Lx4J0Msqdj8IwaEOMsdGEitrp70cKoog
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bd08:a1e0:c497:32db])
 (user=irogers job=sendgmr) by 2002:a05:6902:a07:b0:e03:b5d0:2aa2 with SMTP id
 3f1490d57ef6-e041b1e255amr599255276.13.1720720820135; Thu, 11 Jul 2024
 11:00:20 -0700 (PDT)
Date: Thu, 11 Jul 2024 10:59:43 -0700
In-Reply-To: <20240711180008.188906-1-irogers@google.com>
Message-Id: <20240711180008.188906-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711180008.188906-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v4 03/28] perf cs-etm: Fix address sanitizer dso build failure
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

cs-etm.c had been missed from having accessor functions added for the
sake of reference count checking. Add the function calls and missing
dso accessor functions.

Fixes: ee756ef7491e ("perf dso: Add reference count checking and accessor functions")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cs-etm.c | 10 +++++-----
 tools/perf/util/dso.h    | 10 ++++++++++
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index c53812f343e9..7fd976ea954b 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1013,7 +1013,7 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
 	if (!dso)
 		goto out;
 
-	if (dso->data.status == DSO_DATA_STATUS_ERROR &&
+	if (dso__data(dso)->status == DSO_DATA_STATUS_ERROR &&
 	    dso__data_status_seen(dso, DSO_DATA_STATUS_SEEN_ITRACE))
 		goto out;
 
@@ -1027,11 +1027,11 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
 	if (len <= 0) {
 		ui__warning_once("CS ETM Trace: Missing DSO. Use 'perf archive' or debuginfod to export data from the traced system.\n"
 				 "              Enable CONFIG_PROC_KCORE or use option '-k /path/to/vmlinux' for kernel symbols.\n");
-		if (!dso->auxtrace_warned) {
+		if (!dso__auxtrace_warned(dso)) {
 			pr_err("CS ETM Trace: Debug data not found for address %#"PRIx64" in %s\n",
-				    address,
-				    dso->long_name ? dso->long_name : "Unknown");
-			dso->auxtrace_warned = true;
+				address,
+				dso__long_name(dso) ? dso__long_name(dso) : "Unknown");
+			dso__set_auxtrace_warned(dso);
 		}
 		goto out;
 	}
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index d72f3b8c37f6..878c1f441868 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -280,6 +280,16 @@ static inline void dso__set_annotate_warned(struct dso *dso)
 	RC_CHK_ACCESS(dso)->annotate_warned = 1;
 }
 
+static inline bool dso__auxtrace_warned(const struct dso *dso)
+{
+	return RC_CHK_ACCESS(dso)->auxtrace_warned;
+}
+
+static inline void dso__set_auxtrace_warned(struct dso *dso)
+{
+	RC_CHK_ACCESS(dso)->auxtrace_warned = 1;
+}
+
 static inline struct auxtrace_cache *dso__auxtrace_cache(struct dso *dso)
 {
 	return RC_CHK_ACCESS(dso)->auxtrace_cache;
-- 
2.45.2.993.g49e7a77208-goog


