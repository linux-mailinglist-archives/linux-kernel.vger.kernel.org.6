Return-Path: <linux-kernel+bounces-389855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E4C9B722A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 02:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5831F2149F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 01:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E281482ED;
	Thu, 31 Oct 2024 01:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DSp2Neo+"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2D1811E2
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 01:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730339038; cv=none; b=h99EZh2hhjoioW3W6V+GYtroLI9tvPANtTvWXof7bUH+QBPgfqKB1f1eKz6Qc7pJtYCvzNNPoNqRYqmk/qmcN/JbW5cK/fbk0CS9DTGgv1eOjTlKA+K7t9d1mnoblT1PzGqQ4ZlZJ5li6dnSWcPMU205tWmDgtUSKmLWc3dOI+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730339038; c=relaxed/simple;
	bh=iNS6gSj7D1lsvc1g5KMcNyPf5WgHbLQ5ta+6ZtnweO0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Gu2anBOhLnt5nzjq5k4wz4nDuuobWzXgsdAqfW/Q/+eUeHPCkOZzxI/SfNRTUicmKF7B9pc90iHRlDoFF3fdbmdpce/sWn0uA+/tY2mgpY/09KfJtHOvzzH9KM9nVChEMpogd2UAdQD4qTfiF89yb8NrWaKtRT8eSz5S6QcB4pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DSp2Neo+; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e321d26b38so8923517b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 18:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730339036; x=1730943836; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T1shwZLFPVJttCYQn91hD7eEDXA/86MDDB/52gfDhUo=;
        b=DSp2Neo+xiRs/wFkiWZcJixKMwL1LxRUr6m+pCnnOrUwPbHOSr5CRrFc0bamSuLWMn
         dEvVxlUFOPiJCEUDq7/8sRD3CQG2lQfhtcMw7rB6e4Ntx18NomM4ZqTaCi3N1ucy7xEG
         ws1S0h1aXajA+X0dFxRyPuy2Zra6Vb041LYH6aulnMwJpMswEuVuwXQg4HnEz0EFdMnV
         5Tf+xt7GUanxF7Baz4MM0LY23+8IVqEriJLEwTgDsEyr0L1Xc7Z7446z7afbsZ7kW+hu
         rbWMXVxaKRpl7BeQyXenzf0VUhF0IObRyDoH1ug1PprFEQuHOUtkXgeT94LOi6r8WQ55
         G7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730339036; x=1730943836;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T1shwZLFPVJttCYQn91hD7eEDXA/86MDDB/52gfDhUo=;
        b=JMjGv041auoFZgqUpVJ7igCRipjaCv4dLHUwAtxLiS7enkG3zV0NmSlJXJd1c7dWJa
         3yEb0SQbtVoPVt9VPsDmmKpg1DWEPtaPt58hOM8NT7+oD1kSQuFmBjbWb0cuOkoDOx80
         M1j/DXvGWaNRgiEwBPeaW4P+JC0z+z5vPPaY8FHy3nd0G4a8tyvY8wgV114zhYEJJJr5
         bNj24om2+hIO6MwqHULaXSTVNOpI2MtRMWIBAV+Po3BHOw8tA9dSOAl20xcIl0N6UnX8
         /1sFxzqq1+f77IKeG4BVh1qbuROFf3HsXU6kylOe3zuY1pMimHf/Wh638NO+xOOz4mL5
         4c/g==
X-Forwarded-Encrypted: i=1; AJvYcCVioXpufnoeHuVXmucwjzpbCiBwAqVa7HrHnXrx+cFGDeIITSYQkW6J/jLVzNBMDYxlHuezkXwJ7RdoSr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGvBMz9lrYrXLp9I91no9tpFma4oW2kZBbKQQjJV+mTwxGWv7q
	M0xOrS7FSRkuQwBxzuwGa06BNGDp1wLc74gYlJKu2fidnYxTTEUyR1a3OvOPxNoamqYQ7SCsIvu
	bvlNUQQ==
X-Google-Smtp-Source: AGHT+IGu87SVB/Gw+solzkrJxkcfsXWl4gq0Heu8eKvryWBGXThh2EwRPmXV+WR3Z9DmPGB5Ok76MC+czjoK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ad0f:67e7:f1a6:84c4])
 (user=irogers job=sendgmr) by 2002:a05:690c:4c09:b0:6db:b2ed:7625 with SMTP
 id 00721157ae682-6ea521c92b4mr45007b3.0.1730339035759; Wed, 30 Oct 2024
 18:43:55 -0700 (PDT)
Date: Wed, 30 Oct 2024 18:42:48 -0700
In-Reply-To: <20241031014252.753588-1-irogers@google.com>
Message-Id: <20241031014252.753588-18-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241031014252.753588-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v5 17/21] perf build: Remove test library from python shared object
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

With the attr.c code moved to a shell test, there is no need to link
the test code into the python dso to avoid a missing reference to
test_attr__open. Drop the test code from the python library.

With the bench and test code removed from the python library on my x86
debian derived laptop the python library is reduced in size by 508,712
bytes or nearly 5%.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index ef1b39b5042d..2059f1c4b78d 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -487,7 +487,7 @@ endif
 EXTLIBS := $(call filter-out,$(EXCLUDE_EXTLIBS),$(EXTLIBS))
 LIBS = -Wl,--whole-archive $(PERFLIBS) $(EXTRA_PERFLIBS) -Wl,--no-whole-archive -Wl,--start-group $(EXTLIBS) -Wl,--end-group
 
-PERFLIBS_PY := $(call filter-out,$(LIBPERF_BENCH),$(PERFLIBS))
+PERFLIBS_PY := $(call filter-out,$(LIBPERF_BENCH) $(LIBPERF_TEST),$(PERFLIBS))
 LIBS_PY = -Wl,--whole-archive $(PERFLIBS_PY) $(EXTRA_PERFLIBS) -Wl,--no-whole-archive -Wl,--start-group $(EXTLIBS) -Wl,--end-group
 
 export INSTALL SHELL_PATH
-- 
2.47.0.163.g1226f6d8fa-goog


