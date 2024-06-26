Return-Path: <linux-kernel+bounces-231483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF0B919932
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FD5EB23166
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FB61946B3;
	Wed, 26 Jun 2024 20:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uEYXZzYh"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461A819413E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 20:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434216; cv=none; b=LfbOxwvOK/09qVbrDA3Qpva/HvZGpK2bQsSedk73WxMqsTea9Ix5VbzkIpxqZOBUIIeV36zxkLGiCREh5f45VfpcWjBBtxWXqF7EBUOKcP3OJdHPyYoJQkyW6u6G/tEfDEtEgiy/dBN8DgQa4V8pxoOcUUPxEPSFRupIGZIUoVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434216; c=relaxed/simple;
	bh=tz6IrydlIAL03yTzezHDaA3gvT5YEyeJ8FoCdimUD7E=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=aBMEZuewp5nM0PSX9PvZbRgZQHIJmNdxrYV6IjmI+SUkpXnbtbV94aXRk5Y+XQgIWX2dy3QX1+ckV/R/Ramq7cHdYRMbG8tngyFuLobTOJfJ/ReGP+LoWeV/Be+AluKLma+kgHe7gFYCs0ijXUua6LNnjD1j31DUhqvbMC8ns+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uEYXZzYh; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dfeff1ae480so13556522276.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719434212; x=1720039012; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xUgjNt0xneeMqPZ/Mwlp/Zt17wNAbGBqOmTw4fJjROQ=;
        b=uEYXZzYhIJqWThqjDNjKRSpZ0YCkfJv9TFN3CXDVWHRBc1zLFcTJ9eQTtVVyrdOyhu
         gvJwLWUox09sW3kshN7GZTu3z6Av7+ozg/HzXudw4Z9dmP/eBwQ57pszLRG/VdRdzE2V
         XPv8SASHY863xmgVq107B+O/Osp93ktYIhjPY0XYwByw7X5HSuUhY9rEwbyvN9zXtO+Z
         O2B9lURYSJTQKFayAxB3yPtDZyHeqWuqJUzg10eSQerUWfLVvfDC0UnHP7o+LCcuGTeV
         iUh3SAQ3rLzQwKUyGwhOj40TQjm73zQ5BtC1W9oNnX698iR8FnhNH35K90mpIfOlYvNr
         gEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719434212; x=1720039012;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xUgjNt0xneeMqPZ/Mwlp/Zt17wNAbGBqOmTw4fJjROQ=;
        b=f/r/R+w3W6OdGEPOZzO07daMkcJN1byRXLfYdzpVBkosMWXU3XMqMnfFF7z25rqQ3s
         MSDhAYo9nv0FQpNpLDIoFyjc3GaHBeil8zmpk35GTGN2nBi5la+knbAgH+8jzSbsvf2Y
         9EgT1GsaIJwH9nYffa8UloK/qqdwNgXmBeNVQltAa2UlveRyvZ/vXiPiXcVH+MFlDRFH
         d3taOQP0Xefc+ayuyy/IUcS5JBohEOSEc4JebjM+ErLbq76gv27JxOzrUDI7O+8bROC7
         NqFgvSZsYsBQRGN9qPHadFN5J1xwKRCLqhhPi2ElcdABUoYIPz6Q55r6ybUbofWxNJ6w
         NsuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJXMr++/g8/J87N7IAu89K5DRKjsc1X/nqB0oM8HZM/BiP+VuEn780lkF8f0sDOxQ1cMqb7WaYsMqzDVI6rSz/FKxiMDAJWFKlNx9j
X-Gm-Message-State: AOJu0YwoRx4Q4MddsIScWfOUFynwuDiR5miipRvZN1fDS/2YP6vunKQ+
	JCwfWxQjwwsPpqBK5X8+1nbXpppOkok+OsmoAT/Xt0lVF1FSNEX9Vj6ggVLg2/evIo/TW2oDGXD
	At3l9kQ==
X-Google-Smtp-Source: AGHT+IFkDSWMucqUyPP/weWWjzyS2QYWG8qQwQFISbqoPdxZMm5/69UxoFZkkGsqMZ6C+gcONv53ELx2EAOp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:23a1:25b9:2412:56de])
 (user=irogers job=sendgmr) by 2002:a05:6902:1241:b0:dff:3ec0:71c1 with SMTP
 id 3f1490d57ef6-e0303fbf483mr458676276.8.1719434212285; Wed, 26 Jun 2024
 13:36:52 -0700 (PDT)
Date: Wed, 26 Jun 2024 13:36:08 -0700
In-Reply-To: <20240626203630.1194748-1-irogers@google.com>
Message-Id: <20240626203630.1194748-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626203630.1194748-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v2 06/27] perf kmem: Use perf_tool__init
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

Reduce the scope of the tool from global/static to just that of the
cmd_kmem function where the session is scoped. Use the perf_tool__init
to initialize default values.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kmem.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 859ff018eace..b3cbac40b8c7 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -986,15 +986,6 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	return err;
 }
 
-static struct perf_tool perf_kmem = {
-	.sample		 = process_sample_event,
-	.comm		 = perf_event__process_comm,
-	.mmap		 = perf_event__process_mmap,
-	.mmap2		 = perf_event__process_mmap2,
-	.namespaces	 = perf_event__process_namespaces,
-	.ordered_events	 = true,
-};
-
 static double fragmentation(unsigned long n_req, unsigned long n_alloc)
 {
 	if (n_alloc == 0)
@@ -1971,6 +1962,7 @@ int cmd_kmem(int argc, const char **argv)
 		NULL
 	};
 	struct perf_session *session;
+	struct perf_tool perf_kmem;
 	static const char errmsg[] = "No %s allocation events found.  Have you run 'perf kmem record --%s'?\n";
 	int ret = perf_config(kmem_config, NULL);
 
@@ -1998,6 +1990,13 @@ int cmd_kmem(int argc, const char **argv)
 
 	data.path = input_name;
 
+	perf_tool__init(&perf_kmem, /*ordered_events=*/true);
+	perf_kmem.sample	= process_sample_event;
+	perf_kmem.comm		= perf_event__process_comm;
+	perf_kmem.mmap		= perf_event__process_mmap;
+	perf_kmem.mmap2		= perf_event__process_mmap2;
+	perf_kmem.namespaces	= perf_event__process_namespaces;
+
 	kmem_session = session = perf_session__new(&data, &perf_kmem);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
-- 
2.45.2.741.gdbec12cfda-goog


