Return-Path: <linux-kernel+bounces-574548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B15A6E6A2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 23:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B43463AFF79
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7A51EE7A8;
	Mon, 24 Mar 2025 22:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OpeP+FZi"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208981DE4D3
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 22:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742855698; cv=none; b=JtlpX8hUaMpgZsYHuoQR+SE6lsKVnpaIGo1gX85mo1s2GL3xBlVSyYm7FQosDOCa65ZSfMiRZb283Tur4kesHzKEAWNrOiOdfLlaKFga/PcagwS2T4rqxeEz7012dx0sTlV8Uoy4xjHVcOLoscN9b7LVCxeQyE5HRLqWegu0S74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742855698; c=relaxed/simple;
	bh=L+RibmeajVhS+b4e0cJYwt8F8K8X3TG8cxS5RrxT5bY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=BFblOif0TWFMNk1bjTFMfM0mrmuOsSdPLdXKQcBPmKIk3RBOb+pLi555eJrHT/xjpbbZvuUX3U/4qN8lh+M4hy05JTTdaItqll2OZ2hbFdxV1Z6+423DU3nDi5KJmJjwm6hIQta3SnpUgEd+YLU4BN5404DXKgtNw0DpaIQNecM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OpeP+FZi; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2254e500a73so58920465ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 15:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742855696; x=1743460496; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QxlkY2gDhpAZdJNzCKL1B4UPY7N9UFV3EpWEQYSg7r8=;
        b=OpeP+FZil0Fm+yZEAjZ/zLEviC7VM7BZ+W6dpMnpC/nZ0eNeRxPsA/SaL2UZ4Gkkya
         UXZWqjNlCIYAIQH1evtw3TuhLT0EgdH1m5vw5VbB71/pAFNP2+j4uKdbgR9qyHlmHvne
         /yeFkRhRXb5JDtR89JhT6DZJTyZNfYJFfadKbI+cQT1YBXPrVsAluHFXueH3+C+e8Fut
         5T08lCARrdyOZ5zljy34xw7bR2YLPSOkI6H2DhKZJhJUh8leI1UDb+s7bCp320kF0pDs
         TJD2wFuVICxQA9ohuUywYERfzsesIKYwESvsg/2MtZGSWZal4fa7o4Srj9/T7FchhscK
         65kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742855696; x=1743460496;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QxlkY2gDhpAZdJNzCKL1B4UPY7N9UFV3EpWEQYSg7r8=;
        b=jHcy+RfOeaA+igbnu9GbKsl+FFcs3uD2+Q/6l8NDnoXUJcp+/DIc6Ju0TFE+KHPlim
         sC21dcT+suJHCDkPRFFI8XpJZCuywEluP5mv2roF/VIfADFhRAXPr7NRWGG3cXyJ7lcH
         kXiqrSWPA4eAlr7EiNyRW38afG20OXz8lg2lTwVj6mvmNZAwO9bVEedAfGY3hrJd8uUc
         7hc5Yx8gt6o/TI/ZbyBV0VJbmXmS8eUYvD+qeBcqimIbljanVVIJ6raW3nYp4QpRdCWh
         /RBJvaBeAuGmgXFGgkUehnaFHX6+XmMVEhPelLhu9hs1X8Y1qRkzSgnee5yDcdzcmIRX
         DtuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAHibkuQHeSe0a87ZXJ2CFvSVCQOk+Q41EfkA2h7TAIKG2G7lQqf4NcbqWVN5W8ravYgIsdXR/P3/RdV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEyllgZVr5TTgcOSOcwFdjX8vx1JSHyF+d78tWwzlmNDAXVC73
	Zf0QSsdMQ5tgHHI2z9au0zo4NMxIoUSWcGtHHi73sBZmiMclyS6rp+9a61RtYRwid8iRQiXvV92
	VhTF86g==
X-Google-Smtp-Source: AGHT+IH3069/MwwUYXM1H2i7Bn9Ac37KHz0BYKTX0VzriDzXF6JcEGc/qFoqh9asNK37nqNKauO0S3Bp/KaE
X-Received: from pfnh19.prod.google.com ([2002:a62:b413:0:b0:730:9951:c9ea])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:929b:b0:736:a93d:c9ca
 with SMTP id d2e1a72fcca58-739059763d1mr20709756b3a.10.1742855696362; Mon, 24
 Mar 2025 15:34:56 -0700 (PDT)
Date: Mon, 24 Mar 2025 15:34:38 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324223452.208081-1-irogers@google.com>
Subject: [PATCH v1 00/14] Intel TPEBS min/max/mean/last support
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	John Garry <john.g.garry@oracle.com>, Howard Chu <howardchu95@gmail.com>, 
	Levi Yun <yeoreum.yun@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The patches add support to computing the min, max, mean or last
retirement latency and then using that value as the basis for metrics.
When values aren't available, support is added to use the retirement
latency as recorded for an event in the perf json.

Support is added for reading the retirement latency from the forked
perf command more than once. To avoid killing the process commands are
sent through the control fd. Some name handling is changed to make it
more robust.

Ian Rogers (14):
  perf intel-tpebs: Simplify tpebs_cmd
  perf intel-tpebs: Rename tpebs_start to evsel__tpebs_open
  perf intel-tpebs: Separate evsel__tpebs_prepare out of
    evsel__tpebs_open
  perf intel-tpebs: Move cpumap_buf out of evsel__tpebs_open
  perf intel-tpebs: Reduce scope of tpebs_events_size
  perf intel-tpebs: Inline get_perf_record_args
  perf intel-tpebs: Ensure events are opened, factor out finding
  perf intel-tpebs: Refactor tpebs_results list
  perf intel-tpebs: Add support for updating counts in evsel__tpebs_read
  perf intel-tpebs: Add mutex for tpebs_results
  perf intel-tpebs: Don't close record on read
  perf intel-tpebs: Use stats for retirement latency statistics
  perf stat: Add mean, min, max and last --tpebs-mode options
  perf pmu-events: Add retirement latency to JSON events inside of perf

 tools/perf/Documentation/perf-stat.txt   |   7 +
 tools/perf/builtin-stat.c                |  29 +-
 tools/perf/pmu-events/empty-pmu-events.c | 216 ++++----
 tools/perf/pmu-events/jevents.py         |   6 +
 tools/perf/pmu-events/pmu-events.h       |   3 +
 tools/perf/util/evlist.c                 |   1 -
 tools/perf/util/evsel.c                  |  17 +-
 tools/perf/util/evsel.h                  |   6 +
 tools/perf/util/intel-tpebs.c            | 671 ++++++++++++++---------
 tools/perf/util/intel-tpebs.h            |  28 +-
 tools/perf/util/parse-events.c           |   4 +
 tools/perf/util/pmu.c                    |  52 +-
 tools/perf/util/pmu.h                    |   3 +
 13 files changed, 655 insertions(+), 388 deletions(-)

-- 
2.49.0.395.g12beb8f557-goog


