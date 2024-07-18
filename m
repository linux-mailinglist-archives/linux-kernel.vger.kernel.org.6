Return-Path: <linux-kernel+bounces-255822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A1C934581
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 03:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0B391F240DD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 01:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E8E2BB1B;
	Thu, 18 Jul 2024 01:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EaZ8l/nd"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FB229CFB
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 01:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721264453; cv=none; b=cJgcxcIwmHT8h+kcC9K6l4W0z7mr9tCDbY/DNUT502oi4W1+eEj2uj1I4aIsa3OzAYadMunViyIyg7sNRBkDZ2NyHXPBc6ystT5ipm5xkJKyu78+q+bQn7hONWLYFPkzIsMAJq+5EjlZu6UqBo0cUEs0NXTL4/RxDnTbCHXOgXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721264453; c=relaxed/simple;
	bh=adFJ4x5J0O4JSdSaPCPDVp0aeGz0NJC8hGerl3ETtpo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=k4t0ITeyf/CeH4kT4RGFq7jl91Axub+FmcnzJXU8rGcDgEsJNqtZCfT46siY6mzy3Ucl3jQ72P5m+PWtbynDCkNjfEtXqX2HYNeMj9JG6rxcpq6yzq7t3BNU9Z1g9KFwlocblAoLyc29jP+7xMjC7YdXZgpRdtgalmll2Bc9aKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EaZ8l/nd; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-654d96c2bb5so6393727b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 18:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721264450; x=1721869250; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y0AwPG4o0G47V27ShPbkOoNNhsGypnaaBt/qve64P2w=;
        b=EaZ8l/ndFhzdgfK+/dm+kH2/5UAmvE5LS6yAoreAj84MdwqcGihbARKB7NKAAefEhU
         Q688Lrh0PZ0V9mU3a6kNU/E6NOsUNkDIfdKS4KfZ2kpmpa/0vpIvsh2OMeYfpXz/Domf
         MXjWdQw4u/3gqR4p1I+F+gMHy7uT9IE03qQ/bgRB2tU9bO/7JAvWhdASnuTIqXVAAd64
         yeIwl5nrlKbSjoy/0gQT+Vj3zXM+DnugzwiERno7e2m3PxAURQrUkwLdBCYJRoMKmIre
         jTyokLUN4ffBfRnnFixxHmbPkzhmDZlkHsgZ1cp9XDGKZ+2Ml73nryY4WGGh8RO0rIrt
         ydmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721264450; x=1721869250;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0AwPG4o0G47V27ShPbkOoNNhsGypnaaBt/qve64P2w=;
        b=AjEGP4VIJOM0CKY1DLGDYOhsebDvkowsN6/KZWhU2f3bsxv+prw9GU7o2Kf0qzquAA
         R9eSQoP+BTslf+8OXDtiFTvwT3LoUFAJTHwjjc6IbzA9m43GcemgAGhVzR1rKHdHnVOA
         BKZQnJWWJB2I6y5Um58nlJ20PQBl/qEbgKwD7jn+qpGLZM3ZOyzB+1r5lKPwq12J79vJ
         je0Erdn+q/ji7+N11AFufIsoBTdiqzGlnsQ/VfLvNitQ2DkA+bkkMYCHCoEdR/Dc6gUW
         jtug/e6kLd3yOHM2rlnbcedrzz5I68oF2qoRvbGhGJYSzv1kwh3QsNfDDtIZklBDr237
         280A==
X-Forwarded-Encrypted: i=1; AJvYcCXw0XMB1uYu4k6j4hw+wo2I+P5spVDsoM7Plre4kBEd33zGYPzhczxbY9vJDlJ+Qt/8iwvbqE6+ME9bZmwMeTew/iWdvl/boCBebCSD
X-Gm-Message-State: AOJu0YwSBc9D1GU79lwvdYj+gGpeKP3zWHKu6GFA5elj1Lp9aFNcueqU
	SoAa1NmzXEEUhAbtJZoGGvQc0rBouPnx2T+zf2pvBS59GquAKUY9xJUTye+Uw/v6TKRkDtgBV7u
	HOT/Hww==
X-Google-Smtp-Source: AGHT+IF6Z+ddaWru78kkv+Rbe/2ixIoAa0Oh0Ttd6cumo1XTW3h3Qcnj/31TOiTWD2HXbFwryaFb3vcyoCHV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a05:690c:ec8:b0:665:a4a4:57c1 with SMTP id
 00721157ae682-666015f3170mr275337b3.2.1721264450488; Wed, 17 Jul 2024
 18:00:50 -0700 (PDT)
Date: Wed, 17 Jul 2024 18:00:02 -0700
In-Reply-To: <20240718010023.1495687-1-irogers@google.com>
Message-Id: <20240718010023.1495687-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240718010023.1495687-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v6 06/27] perf kmem: Use perf_tool__init
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
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
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
2.45.2.1089.g2a221341d9-goog


