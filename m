Return-Path: <linux-kernel+bounces-283746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 469F794F869
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3BB6B21937
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01321991B4;
	Mon, 12 Aug 2024 20:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qmf96BCn"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E641991AF
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 20:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495666; cv=none; b=rJuIQQPiOigaVek7wIMgVb/hCbs8TpTrKLY75hjMYzLKco28hzXwO4eLbICdB1bWrDrc7R8HejHpAnhcamQsW+DGF6PxWl3I6iDsAgDLJA6iUgTfQc2pT9XsSgw8/Wx7lvvWkaPoWntsYEmZMyCdC9jFFJFn+SinzrrZptyXyy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495666; c=relaxed/simple;
	bh=4ncXrGc1Au04Ko4PXQputCjfxFfaB5t1gf5Cq17G4fQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=YiUwM0qfj4Iy5OuRyzbMU8DDKDHJPpPK4C8fI941E0qNC4vrLUl2s+jrJMdaiVUsgS9prb+pl0+4f4tA0bRrk5GafB1cjTphxV0FVJ9S+atm9OF9mpxvp0zX25TaZqN1BOAAK9MSVXNH+ZSzdF9gyvC3PhryrZqhTHX2EGfvhKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qmf96BCn; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-64c3f08ca52so101329207b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 13:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723495663; x=1724100463; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q+ZE4hGaGGR3pP4ZqeWSlnNcqmSzC0PMM/ghgc3Fa7Q=;
        b=qmf96BCnoJNr1es71K9IvY84wXpSu7ENbUEjWhgtrOE0+A/oxuXY1e7PKFn5vSZY7F
         MSej6VGdvIA5zw6+oKOGSecu8PDlmNvLiPl98aG99WAd0IyIZLyuRtdG8OMwWpt2jkQ0
         cC3ognT1bHGbLUHv94in0I0yRwjmgvPUY+Gp83eJu0ipDgEYRJ7dxq/WpVHHx2lTeUY8
         HlOUikl71Xwjb+IXVl+sZllFsMHJ0WEVNoxWI2BPNKy2fAzv3GFQ9rKlhor3PzWMvAxq
         QC/X6UbFqOJ+3JxHMguoMc4yJMmqNFJ1ZreVhK7qi35nsQngKC2HdCKJJ6dFjg/Uqc7y
         Xzfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495663; x=1724100463;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q+ZE4hGaGGR3pP4ZqeWSlnNcqmSzC0PMM/ghgc3Fa7Q=;
        b=pJBIa0OCrzVtmnDP6Cn0EyBx8r/GYPBDfYynNCVVNPwAU/i+r+8dMj6c9gW4JkJlLw
         iJVjbTWDsuXqXwcXEQTVWfZ5pkcXeNl+S+BjTRPL1TjhOQH9od4inSPP83uRcOIj5RPR
         I1TOzMwOzqASen8CzqAqIKLuYTVkWrKVgLSXkSeZe9te9I83EyX5cctbFbVJgKbXCzWS
         dj7MaBYkqsWUqlMlRij5+iFCindjQAu0s0/96/K41Wm1nSCN0TgGyRFIJQzn0mQxjjw/
         Ml1jeDiRYgp137NunFGAYqQu2LjFCWpPTYErVwwKRpLZRpv6zEoNc900CwN5QPvv27AG
         h9qg==
X-Forwarded-Encrypted: i=1; AJvYcCUjBSZR8MUW236m4AITLcvF2tkuwksx329kKCuO5Mxxl0jIRgrKh46wMV/dQ14txWcBDYdxLNwZ7q6XKQRUOO0OHCkF4rs+ciik1hh0
X-Gm-Message-State: AOJu0YwByj7UJmIl5fJJHYKaxBfGkTBv4PYuso7b/9v7+IBBV496QzQE
	DM7/n7toarWihStRe06U6AkGvCUYIlwpRGJ4tfDlut7YPb6TBPNUFkyVfm8KGfDGDJCcvOa5Fc2
	wrNolHw==
X-Google-Smtp-Source: AGHT+IEerIYYJMTu/WL1AAclxKU7AxacYY9i7Q1kNURomiSUM/HLMAaiSiuWQSgOAjqMtefBIzHzejkjQcGm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e7f1:b90:720c:35bf])
 (user=irogers job=sendgmr) by 2002:a0d:fc03:0:b0:646:3ef4:6ad2 with SMTP id
 00721157ae682-6a978785122mr109817b3.9.1723495663340; Mon, 12 Aug 2024
 13:47:43 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:47:00 -0700
In-Reply-To: <20240812204720.631678-1-irogers@google.com>
Message-Id: <20240812204720.631678-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812204720.631678-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Subject: [PATCH v7 08/27] perf kvm: Use perf_tool__init
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

Use perf_tool__init so that more uses of struct perf_tool can be const
and not relying on perf_tool__fill_defaults.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kvm.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index a3b903cf4311..692267b1b7e8 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1603,19 +1603,17 @@ static int read_events(struct perf_kvm_stat *kvm)
 {
 	int ret;
 
-	struct perf_tool eops = {
-		.sample			= process_sample_event,
-		.comm			= perf_event__process_comm,
-		.namespaces		= perf_event__process_namespaces,
-		.ordered_events		= true,
-	};
 	struct perf_data file = {
 		.path  = kvm->file_name,
 		.mode  = PERF_DATA_MODE_READ,
 		.force = kvm->force,
 	};
 
-	kvm->tool = eops;
+	perf_tool__init(&kvm->tool, /*ordered_events=*/true);
+	kvm->tool.sample	= process_sample_event;
+	kvm->tool.comm		= perf_event__process_comm;
+	kvm->tool.namespaces	= perf_event__process_namespaces;
+
 	kvm->session = perf_session__new(&file, &kvm->tool);
 	if (IS_ERR(kvm->session)) {
 		pr_err("Initializing perf session failed\n");
@@ -1919,14 +1917,13 @@ static int kvm_events_live(struct perf_kvm_stat *kvm,
 
 
 	/* event handling */
+	perf_tool__init(&kvm->tool, /*ordered_events=*/true);
 	kvm->tool.sample = process_sample_event;
 	kvm->tool.comm   = perf_event__process_comm;
 	kvm->tool.exit   = perf_event__process_exit;
 	kvm->tool.fork   = perf_event__process_fork;
 	kvm->tool.lost   = process_lost_event;
 	kvm->tool.namespaces  = perf_event__process_namespaces;
-	kvm->tool.ordered_events = true;
-	perf_tool__fill_defaults(&kvm->tool);
 
 	/* set defaults */
 	kvm->display_time = 1;
-- 
2.46.0.76.ge559c4bf1a-goog


