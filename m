Return-Path: <linux-kernel+bounces-434407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 395389E666A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 05:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A785F163CCD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 04:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3594C19413B;
	Fri,  6 Dec 2024 04:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b6IVDyvz"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2195145B27
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 04:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733460042; cv=none; b=tUq5/ho6u3fcO5RUmqTU1Yy+/Y4K8W5JW8HVd9taJYA+HTfSirQEeIzeEngvrCKn9eAZ8WPC9QRjnpDPjtwFuPnRrYTQa+hK18Z7opA89BPMJLr29Jkm07s8TXS49f/dAfyEGXRas4NxY4cgORZEImlr6POhvKc3QdwdTs4mEHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733460042; c=relaxed/simple;
	bh=5XkvenvJPsMzCCUZr2E+EXPs3CWRFdkwicbk1Xz1hQ4=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=dhEL5iwQfU004n59iwYlvpZFt6VGu1E78QksUc+iR27nY0X35RKFjeICrgrz7eUKlB0Rc63CIrhCvqCnc7i9qhgOhQn+f94p62hDx9BNSm9TxTGW5mzrLLEEHbUCN3ZA12T+M47TVa1ikitoBGSKFDmVhCpUb6tVN+08OoCDrWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b6IVDyvz; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3891f31330so4234169276.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 20:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733460039; x=1734064839; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OswdkkJgMiXs6XmR6rq8xDeMfeIOQYMZDMPotJ12HwM=;
        b=b6IVDyvzFCpTcJny4Nqf/AkDnXmrjaaolzREQBtVU6SBd5ZIcGEXasGozsnHTfCNCG
         TnwxsxBt4say3tw7we0E4qVynbSmTnQBGVJ+wJgMqA4McLgSZA1tuUaJ7U7qF0Q1i/er
         Cnj0ztbgaxfL+I8EUJh29fAktyNz8hW135b6ZjTx5YmczPQrgJXV8p3AlST0ufviMpVX
         qe2AfFiRuT69uKxEUT0FLYZGsfjQhHdlIfeE2S2Z6Q3LMZCycit+mKIcODm1j07eNDoy
         9zn/Kw0VnumRf+ZgQkn0u4ta7KPHInnBf7norfeKrDiXl+cfHwtmr+YaMRka5S06Vb92
         KRKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733460039; x=1734064839;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OswdkkJgMiXs6XmR6rq8xDeMfeIOQYMZDMPotJ12HwM=;
        b=ii+kzp2nDeeW7UYh9k50q/dmh8tPSUD3Ns7gjgRzwkaavY3oYKGMx9Lfycnr06sSCN
         MwNhGM1Bphc71Rekj9nGV5ToHui2F45BqS71hfXdw5nbYp+Mv//lp33WTSpasIon3gVb
         GzZrn0idT8Df/VFrSIEUjum+DSKefFxKt0nw3e3WNcz1xImK1sUHpDCO3/RwejprRc2E
         FPZvuib38pBjGej/yZ++Wl0jE90mmLlba99js3gMlHc6bPx5MKxVjMt81szAt87EVP/h
         vgHTQKY6zkDrj5srKdchrveZ7Cp8dy290ISf6APHDefxM/GdBRhA3TQkvYXyostl9FyS
         Z2ag==
X-Forwarded-Encrypted: i=1; AJvYcCUgOOkTCENuMwWrSRpACnqzW2T0bAcuhZhJ78a2oPWlSoVTq9Z903QHy6zSnthYjdKbfPFzv8RWAcxRz1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyECyzU2dIfTXEnWeI7BGTfkQvrjMoMJhEPiqdLRC2HCvOKiHU4
	erkVqDoOLrw/yMJAqzzOi6YpbSyR9UAusxQNzrATqmGL0MX45SucA7tvlzZ2kHO4e0jUn8oB83+
	nrDavWg==
X-Google-Smtp-Source: AGHT+IHQzMJx7SC2d02JB3ea9r0wWHts1mKvkKVlE8+5V3QWX9tVxLZUEoFSi6pDktZdzIwc8ggfLgCFMw5J
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:eb75:393:2a8c:1440])
 (user=irogers job=sendgmr) by 2002:a25:7b86:0:b0:e39:8506:c03d with SMTP id
 3f1490d57ef6-e3a0b6a149cmr753276.9.1733460038696; Thu, 05 Dec 2024 20:40:38
 -0800 (PST)
Date: Thu,  5 Dec 2024 20:40:27 -0800
Message-Id: <20241206044035.1062032-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v1 0/8] Cpumap improvements for large MAX_NR_CPUS
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

Prompted by Kyle Meyer's <kyle.meyer@hpe.com> report of the
MAX_NR_CPUS value being too small, initiate some clean up of its
use. Kyle's patch is at the head of the series. The additional patches
hide MAX_NR_CPUS as exposed from cpumap.h, reduce its use by removing
perf_cpu_map__read, and try to better size the temporary CPU array in
perf_cpu_map__new.

Ian Rogers (7):
  perf cpumap: Reduce transitive dependencies on libperf MAX_NR_CPUS
  libperf cpumap: Hide/reduce scope of MAX_NR_CPUS
  libperf cpumap: Be tolerant of newline at the end of a cpumask
  perf pmu: Remove use of perf_cpu_map__read
  libperf cpumap: Remove use of perf_cpu_map__read
  libperf cpumap: Remove perf_cpu_map__read
  libperf cpumap: Grow array of read CPUs in smaller increments

Kyle Meyer (1):
  perf: Increase MAX_NR_CPUS to 4096

 tools/lib/perf/Documentation/libperf.txt |  1 -
 tools/lib/perf/cpumap.c                  | 82 +++++-------------------
 tools/lib/perf/include/internal/cpumap.h |  4 --
 tools/lib/perf/include/perf/cpumap.h     |  2 -
 tools/lib/perf/libperf.map               |  1 -
 tools/perf/builtin-annotate.c            |  1 +
 tools/perf/builtin-diff.c                |  1 +
 tools/perf/builtin-kwork.c               |  1 +
 tools/perf/builtin-mem.c                 |  1 +
 tools/perf/builtin-sched.c               |  1 +
 tools/perf/perf.h                        |  2 +-
 tools/perf/util/bpf_skel/kwork_top.bpf.c |  4 +-
 tools/perf/util/kwork.h                  |  1 +
 tools/perf/util/pmu.c                    | 30 ++++++---
 tools/perf/util/session.c                |  1 +
 tools/perf/util/svghelper.c              |  1 +
 16 files changed, 47 insertions(+), 87 deletions(-)

-- 
2.47.0.338.g60cca15819-goog


