Return-Path: <linux-kernel+bounces-283744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDCD94F866
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E211284147
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3994197A9F;
	Mon, 12 Aug 2024 20:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HRsGmPfd"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAC4198850
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 20:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495661; cv=none; b=dGPyqSQCr0tQEVYxcqCZMqK6XCfZQzmI53SZPuaONzGGbEPCuDIAWQ8TT5mvVFijtwrSYj3vkr2bqcRzvYbEOgpZ8RGO5S7GHnPlisEeFc4j5hviHkzo4/Th9nOX/LqfL0XwM8ZBLhQfnTWG2haiBQd6bixs0XCm0A2MNaQeiV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495661; c=relaxed/simple;
	bh=BZDDhHpINt7zFZ2dnVQIsF8i2MQFy9+sdU32bNgre40=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=PPWxnYeVh7jVj3/3bgxr5EhSuoK6R8txtj1C2PUUwzwjrNtNHFRkRCsBRn+Lc+W3EqY7Ekr/jLKlyauFXYwZSIMWX2EYuP1pcRBCJsqWVbDnd6yZYNrq0sOJ9YGfN5JW7jf12Px5+KHEBrKDzbGWa1AXe1zPlf8UjyiYgwx6GhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HRsGmPfd; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-66a8ce9eecfso77884617b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 13:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723495659; x=1724100459; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GSnhy3Vr2qERdCmMnBMzUq3MwYF2csqFbHWhPN6IO30=;
        b=HRsGmPfdO+9iMJYREoVK9ld2UJo6eoU8RmYnZfDh3AQUreKgH/XLWd/MWyD4GBI6/a
         h5gL8Whuim+2yOpnaL0/2WB38EL26Gr9JDmQp/LgeRipV1YKmWXtuPuLvlzlCTsCPK5N
         d5FQQ8677efOl7ehNpsLtNgjLsylpfQOkOnTS4DZfOngWSJXrgvVpsptp/GLHl4u7uCh
         bh5QIK9iZOXKhYtmGMD5BW9k/VLdzdkjonF/1E4Ida+7mpUn6qtaj9uDH2ab+FakE20x
         +Sv3S+vi1M5NoL2g1Fw2emn8DyPJEm8ijlOeQs2w9DH31KavWot9TyBWa+hhHKG8mAzu
         6Zsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495659; x=1724100459;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GSnhy3Vr2qERdCmMnBMzUq3MwYF2csqFbHWhPN6IO30=;
        b=Pw4rZFdHrAIjr2X/cFYmmk0hFGFJLGffDoQJ9SB7myntLBoskw+1GGnfuvDDqmGkCb
         VHZiP4guBurm9KbkJvrEofOLWRNj9uUMi/gIcHeeqUjn8q4NmpQCwNkryqkJlUFBzmNo
         j4xCbOs8CDMCFKuXQJq7rRu9ohbI29LmCLiV7wzypxx2ntVpl/VloJuc7RrlAUJBjSEI
         FP7fUjRi2PwBZ9PLg8LIwmp2w80/ho+xPmYKeOR7mcUaJ3bCN9CJ4rAm/j57vh6rvWEu
         vhKkc/kiYyHZ4mDfNRNbHt5XeW3D4NG3Vs52Bm9b+8SHpniYEBLbGKuEImg4Omz8VFWy
         Ejnw==
X-Forwarded-Encrypted: i=1; AJvYcCVLk8E/htodR401Q+ya+jm6579Vv36CNNeH95hZg6sbKPe+0hdwwGM7B89gJsFhXZzYD4WBk9TPzeo5eW6heIPYNTUnM4cFM7yGs0Vd
X-Gm-Message-State: AOJu0YySyMy9H/JPlpwJ+aLhFfoQ7+6TpPR/RbgWBsRxfUmzRtyFFEhv
	6xvnDMwJuYsxv3VBAl19jQziRRC9/RsU0ndUFlgXZ368JnemD9qroWdzvEZ5Ls6wM+3jQTnTv+U
	UJObrRQ==
X-Google-Smtp-Source: AGHT+IEblpJwdl6278PFoZ+5cEGAgnioMooSJ+8EN/KwaqJevyVV+yvBEdMZq1rxI0gSMePlMu8pFsWGn/7c
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e7f1:b90:720c:35bf])
 (user=irogers job=sendgmr) by 2002:a0d:ce01:0:b0:6a1:741b:b723 with SMTP id
 00721157ae682-6a9ea8e5238mr117867b3.5.1723495658586; Mon, 12 Aug 2024
 13:47:38 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:46:58 -0700
In-Reply-To: <20240812204720.631678-1-irogers@google.com>
Message-Id: <20240812204720.631678-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812204720.631678-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Subject: [PATCH v7 06/27] perf kmem: Use perf_tool__init
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
2.46.0.76.ge559c4bf1a-goog


