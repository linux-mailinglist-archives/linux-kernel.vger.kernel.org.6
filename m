Return-Path: <linux-kernel+bounces-337597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3690984C2D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E42751C21B97
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 20:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3394613D29A;
	Tue, 24 Sep 2024 20:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OI648ksP"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F4713C695
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 20:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727209769; cv=none; b=C7G0JcAW+BrQ0RL2jbAg27IGN7vdDc4HRq4mE4H4La3JzFgRSECB7oQHA/lN5PI3JkHka6nnb1y44SfQtlJmVKhTqoGQ+ocXoH/ee2LUNeuOfkkBXDve8xsnpxHtPvRxOuApYrly5VZt9shM9Vikt58vI4g62TZu/THty6Wvolc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727209769; c=relaxed/simple;
	bh=3IrGM7Vp/camOsTuc8EPn2WJHBOG4EGN8nibf0GF9fc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=NJx6ULX0fgYvW1IGRTR6Y+3cOk5WhhGRQUdBLhWmS/+T+XDUuTAl7TWevTfcHK8lkq+f05c6zEFpcaZo/pLXDgJRYNm6FT/OCUBNbj3PUjMX7LzqKbr6JYRqIJGKWeKklK8uMuydp0oFVMULBg4/hLnJRysnzzSlXZ79Kws0tc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OI648ksP; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e21dcc7044so2942717b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 13:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727209765; x=1727814565; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bMopY+swtlI17FAIY6bYnHr0EteCW+YOytiwPq+8+K8=;
        b=OI648ksPqRAHrJpyOZIXTPLyjEHQnAzvKVzNNsVdhXBrSVgFwhyyQF/+i+IQfqDOgx
         24c8VErC5iJPIu0amo6n1WqZ9XnyjnFz1WSDN1s5PTHe6QqMbx75r11wLuD31G1Lreno
         F7zsXW6tm2vEHCF77TU68eSBMZl1sTmA6LmKPD+6ny9dcr4yIjd/dZa8iZMYQLa39tb+
         UFC7a4KSJF9M0cPWaiwNvMMdkKJ7SD1xr8bMl9Qt7s1Ag1sJ4Ib/QxDzLpqlJhdUqkBY
         fyimiTwVHvmy3kWDaTTs5sRSfrL5X55PVHnf2uvdydFxRQxRo4n5U4bVhKuWuLD5Ihhw
         fujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727209765; x=1727814565;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bMopY+swtlI17FAIY6bYnHr0EteCW+YOytiwPq+8+K8=;
        b=EBFwyC+F9dvr7vtw5QctqLSm5BGxaT1ZA/VEsoj8/gR5zJIVA/kCzPlRmtaLKWEGpp
         WKRHMChl790kur9z/WUenQQp7Z8w+Nohob4bucqZ8PshzFIcdn/8o1kRediRhD8woYM9
         YJWmLIptWXRptmV+Ndzwi6mScQQagfhAPxWXfWFX5YQOWx5bd+mD9nk+JVKyF4qFMfOd
         dZy/sVL8wx6nWeKgjxnJqGyP2ORXyiyXfl6ixZiX1/iivCdIdRIB2n+0vQohZ2EndkgH
         133+NHifxwtqEM0sGcGzWqQ6Wf7zxTF3nM74Gg84e4Fc9SMVm3xQGruG6TI2EMjy1VS7
         HiYw==
X-Forwarded-Encrypted: i=1; AJvYcCVNNTqMyJcQ0uxvnnxla2o85RSdVr9S1qEEvU+QNazTujD8g8wlGxjkssBTLwShw17+yU1Zf5ZbKJBIinM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaQkNjoDPSkZ/gnPxJ55J3o1WoVP4r260jgyEfSf7CijZdfBWs
	Xk/a7Ng/q1rMfxsxN1AV5Jr2uULWlxNUmkq10HpW0pt8nBatdp4YbqPgRRi/K6sallMOAWWBJoy
	CVc6lhA==
X-Google-Smtp-Source: AGHT+IHfUBA0yuvH+ifT9XeZnIbFs7mARF/BoS2vpvQRvI/YN5burzjDqWuIwy3oioa3+gITIXUCrw0SMenn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:965e:4297:88a9:5902])
 (user=irogers job=sendgmr) by 2002:a05:690c:2a93:b0:6dc:7288:a90a with SMTP
 id 00721157ae682-6e21da5cb80mr34247b3.3.1727209765528; Tue, 24 Sep 2024
 13:29:25 -0700 (PDT)
Date: Tue, 24 Sep 2024 13:29:14 -0700
In-Reply-To: <20240924202916.1560687-1-irogers@google.com>
Message-Id: <20240924202916.1560687-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240924202916.1560687-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Subject: [PATCH v1 2/4] perf test: Fix memory leaks on event-times error paths
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

These error paths occur without sufficient permissions. Fix the memory
leaks to make leak sanitizer happier.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/event-times.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/event-times.c b/tools/perf/tests/event-times.c
index e155f0e0e04d..deefe5003bfc 100644
--- a/tools/perf/tests/event-times.c
+++ b/tools/perf/tests/event-times.c
@@ -126,6 +126,7 @@ static int attach__cpu_disabled(struct evlist *evlist)
 	evsel->core.attr.disabled = 1;
 
 	err = evsel__open_per_cpu(evsel, cpus, -1);
+	perf_cpu_map__put(cpus);
 	if (err) {
 		if (err == -EACCES)
 			return TEST_SKIP;
@@ -134,7 +135,6 @@ static int attach__cpu_disabled(struct evlist *evlist)
 		return err;
 	}
 
-	perf_cpu_map__put(cpus);
 	return evsel__enable(evsel);
 }
 
@@ -153,10 +153,10 @@ static int attach__cpu_enabled(struct evlist *evlist)
 	}
 
 	err = evsel__open_per_cpu(evsel, cpus, -1);
+	perf_cpu_map__put(cpus);
 	if (err == -EACCES)
 		return TEST_SKIP;
 
-	perf_cpu_map__put(cpus);
 	return err ? TEST_FAIL : TEST_OK;
 }
 
@@ -188,6 +188,7 @@ static int test_times(int (attach)(struct evlist *),
 	err = attach(evlist);
 	if (err == TEST_SKIP) {
 		pr_debug("  SKIP  : not enough rights\n");
+		evlist__delete(evlist);
 		return err;
 	}
 
-- 
2.46.0.792.g87dc391469-goog


