Return-Path: <linux-kernel+bounces-168823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 042AE8BBE34
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 23:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9841F1F21E02
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 21:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D966584A56;
	Sat,  4 May 2024 21:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FZ5Jf20p"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B5584DFC
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 21:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714858695; cv=none; b=kJxjnVTk0KC30+pfYH+tfrPzRk4GnLw7ff2f8NtBmQovd8PENH68zIcOIAKCCw1+jH6Si2G9L030HLweIyGYfPMSdbAYAiIEg0KhChGWuKNpLfTzHIY9iGVJHO57QoV4zoEJhHHvLrhiOvkb3lcaMFqd5662oO3ZpOBwn4/O+u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714858695; c=relaxed/simple;
	bh=xOKbK/XEW5Z71mF/Tqq6gbBQH84WAmrfAkW8j273dzA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=nH08i5AAU00wPEHF96P/BpwrnGIA/zR8Fh36Mptw2ACpELKcSLxSe1jE5OxblYSI2oxpFR/20z6Dr0B/gpcb3T6zCcWK4zfbY81WTRBgnh2GJ0u9tXEV/mipofg2IQYGvvuXlhso1JujQIpebL9u600gOLwLRn10pJGHh5Nf3oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FZ5Jf20p; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be25000a4so17248437b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 14:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714858693; x=1715463493; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7v5n6cWeL46h7AfyxdcdGwfAAC4M6kBZfQt4zPWA9SA=;
        b=FZ5Jf20prlKWmG9sUwta/qjvLP/jl07oCLRyJMhhMqbBFG+m0OHGnMy5B2QncgiDsB
         PqYN+Ivg33a/vUs91UCZeK43JmWM3F6zCSH/AgpdxdYPSlwVC4AywLlPXhSKID/+V7Aq
         Da6UsJZ6CVv4QxTUwASkwKC40zIKaud9N3JALYSK7lEUqW6mUfDQlbvha9aMLYQroURt
         Kd+VdTDFKPFPHZG7E5qUgFBHBPTjb3JogkSz0VMfGodFfFdaNHwmp86xOu6u8htPR2C5
         yFmqgycJ7DfTHC5Vxi/0e0XWByK7SfN2YDjrTOKMYNTEZKLsZt3mhdt6ADj6oaXti8qV
         oSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714858693; x=1715463493;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7v5n6cWeL46h7AfyxdcdGwfAAC4M6kBZfQt4zPWA9SA=;
        b=QTKDc1YphoMghDBGqyJmU/Dd3cfb0Ep/6h10kpfemH7+UWxHNg6a2nrkhCPtTuuZwc
         xSikECvtsQC9PvcqfmPDZQ4oaLNIj85ehTLQSBp/XRd5f2nanGex4v/mJzdr7yGaNBHv
         JWeDwWePg5P+7tJOVra9thUYyK3zfPTNQSXrAcOvulp6BL555YN1KORvXFE3EP5uLJBo
         78HJJVNRppV1DQv5uzJFsLaacYRamSOKWtNsE94V7NNg4Xhtz4AoQSUR0kVrj1POXi1K
         Ap8PPy6a/Vr4+FysegjvDQA2B4T4ALPIcP6rmJVPD929kJTRMv4lQsBQFuuzAtFmgvYF
         dZtg==
X-Forwarded-Encrypted: i=1; AJvYcCUSNau3tFG8ncHsUe59MnL+/2a3iHKWtHOlvVBKZuo5ll9n9t2fSImN+Du6ObxG6xs8eGAoJYTo2dxS9mqnuVDi4C4cemNCQErq1F9X
X-Gm-Message-State: AOJu0YxHT2riPvpygnGdkpKrdXIzzGv6jcOjQ4TH50OLhPlgBKyKtP38
	84C5eZZWfj5hSBQFs5PK7OZ02U6AVp053148s3cHxNGchsOPsUxux2WgPww0FU/mN3zAaJentZP
	SIoxJEg==
X-Google-Smtp-Source: AGHT+IFxAV3fnxuxBvs0KgS0E2agDd5tHbixekIl7xBEbQg24AbJNL9XYoOCYwJN2uiBe4LTpUzJz7E5pABd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:566d:1f52:f5f5:c8ec])
 (user=irogers job=sendgmr) by 2002:a0d:d591:0:b0:61b:ea12:d0b with SMTP id
 x139-20020a0dd591000000b0061bea120d0bmr1596460ywd.2.1714858692827; Sat, 04
 May 2024 14:38:12 -0700 (PDT)
Date: Sat,  4 May 2024 14:37:58 -0700
In-Reply-To: <20240504213803.218974-1-irogers@google.com>
Message-Id: <20240504213803.218974-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240504213803.218974-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v6 2/7] perf dsos: Remove __dsos__addnew
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	nabijaczleweli@nabijaczleweli.xyz, Leo Yan <leo.yan@linux.dev>, 
	Song Liu <song@kernel.org>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Ben Gainey <ben.gainey@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Changbin Du <changbin.du@huawei.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Dima Kogan <dima@secretsauce.net>, zhaimingbing <zhaimingbing@cmss.chinamobile.com>, 
	Paran Lee <p4ranlee@gmail.com>, Li Dong <lidong@vivo.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Chengen Du <chengen.du@canonical.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Function no longer used so remove.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dsos.c | 5 -----
 tools/perf/util/dsos.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index c01f0b538e65..89f87a197a44 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -341,11 +341,6 @@ static struct dso *__dsos__addnew_id(struct dsos *dsos, const char *name, struct
 	return dso;
 }
 
-struct dso *__dsos__addnew(struct dsos *dsos, const char *name)
-{
-	return __dsos__addnew_id(dsos, name, NULL);
-}
-
 static struct dso *__dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id *id)
 {
 	struct dso *dso = __dsos__find_id(dsos, name, id, false, /*write_locked=*/true);
diff --git a/tools/perf/util/dsos.h b/tools/perf/util/dsos.h
index c1b3979ad4bd..d1497b11d64c 100644
--- a/tools/perf/util/dsos.h
+++ b/tools/perf/util/dsos.h
@@ -30,7 +30,6 @@ void dsos__exit(struct dsos *dsos);
 
 int __dsos__add(struct dsos *dsos, struct dso *dso);
 int dsos__add(struct dsos *dsos, struct dso *dso);
-struct dso *__dsos__addnew(struct dsos *dsos, const char *name);
 struct dso *dsos__find(struct dsos *dsos, const char *name, bool cmp_short);
 
 struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id *id);
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


