Return-Path: <linux-kernel+bounces-171986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E76F8BEB87
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EAB628494C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47CD16E86E;
	Tue,  7 May 2024 18:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JpM5tV+P"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8072116DEB5
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 18:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715106973; cv=none; b=Yi1SWoJSKkv4qfLzLsHUioNWDwfIvfP7yNtt72w0wxryoqq2ToWJajjrOokzITIK7WtG9cqlHcnGaWszzWh3i0ZjhwW24eY5MjtF/Hl/JB/aiK92AsuY92Kxx/zz3OaH1iVMJd6H8a1z3FVXt5FaH25S4B59AXlPe0tJMA8hO68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715106973; c=relaxed/simple;
	bh=e/wJkPb6Up6/3AXzG8MatkSdBcxmtGosq5+MGZvNwTg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=QCZlJmx2ecXee9r53FsdsqvaASJp74amBIewg+NUwtjBztWnN5cSWFPSJCnRLuMQUDPU6xkkApmTkOcCoNDlc1xcN7b8eYQdyvChBjrBcImehviZ6zIyR6ngby5YcOijzfs5E/GrWoTKzcF7R5H1gvABXWGeDHhDmZwUoC8x4Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JpM5tV+P; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de603db5d6aso7220952276.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 11:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715106970; x=1715711770; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GO0hb7v7nG6Id0cJK33WHU2z0Rs2/LAXioCEoSvIAik=;
        b=JpM5tV+P3A+GurGJU8USFa2nRLFzOk6oI1bsorF+oNV500tuVNYYRgTsSWPecf3BoN
         hiMTdWPIEHeaK3WF9LoEukIcToQB7o1OulAeS2raOGiRDNUftE/02r7S7aVn66RIzKJo
         0DK4e5gkW38VO1Yz05VM3TT3N6o/+ZoQqDlEmTkdPvpbOHcQ5ey8Vz7tKraflNwzcb4y
         UpFU1zqHyrqT8zkk0nigF+L5JDldqygvmpjRyAr9tU+duTUiqFV03IxHeg1KsegtKO5V
         iLj7C92CnwsYlXeUiCALI0UWWK9xoj6SB8NMcDT0yyzfoUpof+EV6+46DnQfWg5dWtr8
         PeCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715106970; x=1715711770;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GO0hb7v7nG6Id0cJK33WHU2z0Rs2/LAXioCEoSvIAik=;
        b=qdv6N5AiQ5UsXFSH6ItqMuFGzg0I24wuBZLJobq5eZPArikw4a/fTe0RFO2EdzB2bF
         xOz9kDhJwPFW4bQvNSr471vcM4SUhPru+NmTBsWjepW2vXVLWPnsUFk0htE1XRy2Z23U
         M7QfaW/e1OsE6Rwuf/MqCx6Tz7rgjekMe19Uu2ouV6ZBDAcbTDz1D23GR45cPOFObAT8
         RTakk7zueXoLfYL85Qxa10qFrThan/7/szYOGC8/vYe1mofF507XIqPyqknf9U0F7eT8
         abfAQXmP9/FOdtbpe4ySs5Oc7Islzunh6CzZ+n2YqsjNQRNh8qvPLUlCLE1j+81NBe/2
         xqQA==
X-Forwarded-Encrypted: i=1; AJvYcCUbZ7K6YWFYpVGYSlU3fTmlnQeUAb8PsDwbV6FxJ0QZxyf2i8YtuWBVhhQA4oakaQXs6dWIJoWFT5MkTnr2MKaMtIDaxLNGoEpAlqEn
X-Gm-Message-State: AOJu0YzlDWPB9+AYExsvSqfP2UEAHjchx57XMTZxAXsKdimGxFSJ5xIl
	iaEvdOVzPuKuZx9XuDmE2azot9b7mFLsGzfEv5eJ1mH4ozVAFzFEUouJnwsu87pTnhyRRXDUnW4
	USgLlHw==
X-Google-Smtp-Source: AGHT+IH0+iGDT60xNzG68p+EHdgJrLMckET3iqNIC7831kCnZaCBN3MiSLXMejQERNtTr9eu3idrl3ZvXb4B
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8095:fd7:9773:b1df])
 (user=irogers job=sendgmr) by 2002:a05:6902:100e:b0:dd9:1db5:8348 with SMTP
 id 3f1490d57ef6-debb9e41975mr129612276.8.1715106970500; Tue, 07 May 2024
 11:36:10 -0700 (PDT)
Date: Tue,  7 May 2024 11:35:40 -0700
In-Reply-To: <20240507183545.1236093-1-irogers@google.com>
Message-Id: <20240507183545.1236093-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240507183545.1236093-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v1 3/8] perf block-info: Remove unused refcount
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	James Clark <james.clark@arm.com>, Tim Chen <tim.c.chen@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Kajol Jain <kjain@linux.ibm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, Li Dong <lidong@vivo.com>, 
	Paran Lee <p4ranlee@gmail.com>, Ben Gainey <ben.gainey@arm.com>, Andi Kleen <ak@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

block_info__get has no callers so the refcount is only ever one. As
such remove the reference counting logic and turn puts to deletes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/block-info.c | 22 +++++-----------------
 tools/perf/util/block-info.h | 15 +--------------
 tools/perf/util/hist.c       |  4 ++--
 3 files changed, 8 insertions(+), 33 deletions(-)

diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
index 895ee8adf3b3..04068d48683f 100644
--- a/tools/perf/util/block-info.c
+++ b/tools/perf/util/block-info.c
@@ -43,26 +43,14 @@ static struct block_header_column {
 	}
 };
 
-struct block_info *block_info__get(struct block_info *bi)
-{
-	if (bi)
-		refcount_inc(&bi->refcnt);
-	return bi;
-}
-
-void block_info__put(struct block_info *bi)
+struct block_info *block_info__new(void)
 {
-	if (bi && refcount_dec_and_test(&bi->refcnt))
-		free(bi);
+	return zalloc(sizeof(struct block_info));
 }
 
-struct block_info *block_info__new(void)
+void block_info__delete(struct block_info *bi)
 {
-	struct block_info *bi = zalloc(sizeof(*bi));
-
-	if (bi)
-		refcount_set(&bi->refcnt, 1);
-	return bi;
+	free(bi);
 }
 
 int64_t __block_info__cmp(struct hist_entry *left, struct hist_entry *right)
@@ -148,7 +136,7 @@ int block_info__process_sym(struct hist_entry *he, struct block_hist *bh,
 			he_block = hists__add_entry_block(&bh->block_hists,
 							  &al, bi);
 			if (!he_block) {
-				block_info__put(bi);
+				block_info__delete(bi);
 				return -1;
 			}
 		}
diff --git a/tools/perf/util/block-info.h b/tools/perf/util/block-info.h
index 96f53e89795e..0b9e1aad4c55 100644
--- a/tools/perf/util/block-info.h
+++ b/tools/perf/util/block-info.h
@@ -3,7 +3,6 @@
 #define __PERF_BLOCK_H
 
 #include <linux/types.h>
-#include <linux/refcount.h>
 #include "hist.h"
 #include "symbol.h"
 #include "sort.h"
@@ -19,7 +18,6 @@ struct block_info {
 	u64			total_cycles;
 	int			num;
 	int			num_aggr;
-	refcount_t		refcnt;
 };
 
 struct block_fmt {
@@ -48,19 +46,8 @@ struct block_report {
 	int			nr_fmts;
 };
 
-struct block_hist;
-
 struct block_info *block_info__new(void);
-struct block_info *block_info__get(struct block_info *bi);
-void   block_info__put(struct block_info *bi);
-
-static inline void __block_info__zput(struct block_info **bi)
-{
-	block_info__put(*bi);
-	*bi = NULL;
-}
-
-#define block_info__zput(bi) __block_info__zput(&bi)
+void block_info__delete(struct block_info *bi);
 
 int64_t __block_info__cmp(struct hist_entry *left, struct hist_entry *right);
 
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 55ea6afcc437..b8a508cd0b14 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -631,7 +631,7 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
 			 */
 			mem_info__zput(entry->mem_info);
 
-			block_info__zput(entry->block_info);
+			block_info__delete(entry->block_info);
 
 			kvm_info__zput(entry->kvm_info);
 
@@ -1341,7 +1341,7 @@ void hist_entry__delete(struct hist_entry *he)
 	}
 
 	if (he->block_info)
-		block_info__zput(he->block_info);
+		block_info__delete(he->block_info);
 
 	if (he->kvm_info)
 		kvm_info__zput(he->kvm_info);
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


