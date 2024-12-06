Return-Path: <linux-kernel+bounces-434410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A8B9E666D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 05:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CD4C1645DD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 04:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7301D516B;
	Fri,  6 Dec 2024 04:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aEGG85QZ"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D021CCEE2
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 04:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733460047; cv=none; b=In/3nve9jZ309kktcxrhJd3iQ5DvxVBrOkuNTMGch6obSyyfybjFx1UQuDJKZpFLuy9UhNaC04KeRie4gvmWc38REWXy52g4qluBDLKRK/GHuGtyTD9+4v5R+qqxvFBFzPjL0MfuAWFVBYpkpPwtwDATXGT3aEmxdmrD9RlVZLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733460047; c=relaxed/simple;
	bh=sNrG9Ry1Ixsz3Iw2Cir6bSd/AcmJIt/1w3p+Zn0bR2k=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Gusno5h3r506EO78AZXvvvi6ymZ7nw40YHAJIfskvqj0pgjd2Zgu1VpzQH2u169OQSx0AxxxggJA4CONyw66VFH4/X/sCbw2kTluI5STX4eYmWcRM0paMv4C99EDIHDlLksY0/XRV+M4WfbiAKDkDw9lLXVmY2Sn8Dub2CVrn0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aEGG85QZ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ef66fd6e78so18227267b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 20:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733460045; x=1734064845; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zxiu9g2tnYAaehM/09JR47eYFX/Tpdp15RNfcOT5D1I=;
        b=aEGG85QZnkte0ReldoZqNQ5FkEHDuZDWuhaLPJIX5af3UFwDQJUKiOJ6olL9xAWGrT
         JWyRQCwmciPwz0xbNXTsqfe1MZ6sorSJDOf1kjvxfjC0kYZOKHiZ9xI/dm4VGAgoxAOQ
         f7Xc9nEjPw3jaRykEEqc/NHEV6gxozcobxqWx8mIGwtA9NoDaJzio0SUK0HhKoFAw15E
         qTrxUfqwDmP3aACBqMBJiqMqUbmsNGmzGanrdLPRjPjxDO/BTHxvGibCi2v+Fxch86DA
         AJjNHLEWtMfVveZ4eNMS3A/EQUj9ndBm2SwXO/IK3i87uyVV9+8dDxO19OZvnn71TdSE
         +kTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733460045; x=1734064845;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zxiu9g2tnYAaehM/09JR47eYFX/Tpdp15RNfcOT5D1I=;
        b=C8eRthXnT3yqFV60a5FfpdZTHhgpPUjgUU6tg6Enu6AHbJE3eN/up7TOvNMO/4FapD
         0a9dPn3V0muviiYYcTmmEWlX2XWnk28/EmHzDE1P8iJV3TTZy4nTErGJUpbEtcKvM1V2
         yBY2qH0/orbQyfFrrZON2sSxdMeHIUubRwV6yXd6CAVIuxqyA9TxgB33dGub1fx4ES+e
         fzxhGqjM7BUO/8CCUSA57VSSYmnxanYCeWZ8I+t4EIDB5rzgmv8fqkoNvJ2oURZKd9NN
         IvfNmSJHIwG7zRaV9+Y+Px7APneXMyAouSMbATxXRZXzFJt9kRQcD3qfYrJf+J666gZf
         /H1g==
X-Forwarded-Encrypted: i=1; AJvYcCV/YVd2qPrNjKkPYJ0S3GD0TUSdqxuXdorVccWzgfST7Xz/jObtCDgRmk4rNrw61Dni6TlORCM8SHM4F5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzobWae3rCbNyx0jJZvtXuydAFdXbsiOBJwLdCXFlo6ya0diVzB
	khwugjEBDmtFFxL1nr4AYdgb7mGGUVWxoq/bP8K8gHpT/n2tFUJDymf2+0zMBIyDFipyt2QVx34
	GroSnCQ==
X-Google-Smtp-Source: AGHT+IHoyqw3/FLlGrXxAG+PamnShXsumtQls5He4Er5Rpy3RIlaO66WUpmsOzXBH4IQRbPpNZn7bhv41hiA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:eb75:393:2a8c:1440])
 (user=irogers job=sendgmr) by 2002:a05:690c:700b:b0:6d3:e7e6:8460 with SMTP
 id 00721157ae682-6efe38de0f3mr210687b3.1.1733460045224; Thu, 05 Dec 2024
 20:40:45 -0800 (PST)
Date: Thu,  5 Dec 2024 20:40:30 -0800
In-Reply-To: <20241206044035.1062032-1-irogers@google.com>
Message-Id: <20241206044035.1062032-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241206044035.1062032-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v1 3/8] libperf cpumap: Hide/reduce scope of MAX_NR_CPUS
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Kyle Meyer <kyle.meyer@hpe.com>, Ben Gainey <ben.gainey@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Avoid redefinition of MAX_NR_CPUS as a global constant, the original
definition is tools/perf/perf.h.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/cpumap.c                  | 2 ++
 tools/lib/perf/include/internal/cpumap.h | 4 ----
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index cae799ad44e1..3ea06865d4b0 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -11,6 +11,8 @@
 #include <limits.h>
 #include "internal.h"
 
+#define MAX_NR_CPUS 4096
+
 void perf_cpu_map__set_nr(struct perf_cpu_map *map, int nr_cpus)
 {
 	RC_CHK_ACCESS(map)->nr = nr_cpus;
diff --git a/tools/lib/perf/include/internal/cpumap.h b/tools/lib/perf/include/internal/cpumap.h
index 3cf28522004e..e2be2d17c32b 100644
--- a/tools/lib/perf/include/internal/cpumap.h
+++ b/tools/lib/perf/include/internal/cpumap.h
@@ -21,10 +21,6 @@ DECLARE_RC_STRUCT(perf_cpu_map) {
 	struct perf_cpu	map[];
 };
 
-#ifndef MAX_NR_CPUS
-#define MAX_NR_CPUS	4096
-#endif
-
 struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus);
 int perf_cpu_map__idx(const struct perf_cpu_map *cpus, struct perf_cpu cpu);
 bool perf_cpu_map__is_subset(const struct perf_cpu_map *a, const struct perf_cpu_map *b);
-- 
2.47.0.338.g60cca15819-goog


