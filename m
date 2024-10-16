Return-Path: <linux-kernel+bounces-368802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 148AE9A151E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 23:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ECF9B23130
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 21:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99281D2700;
	Wed, 16 Oct 2024 21:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ugeIRybP"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C13125B9
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 21:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729115515; cv=none; b=mZLiZlTrWzlCz8b8DRDEprTCzZzfwXrRtReVlxazP6nAMDY6w9ud8vtQx6I+JcgGWQtz76cd2EohD8KODYyFwQ93Ls7jwR0OHyP3n49I/j0bklqXWGCMTtLPkGHdkbpd8diIH9tk+nsOIVMKaTVYhgx0Hf1bIghd+240Pyd7v/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729115515; c=relaxed/simple;
	bh=5B5zZtVhPu3KcXjmmRnPd3ir3Y6025YdvNPQ0dugF50=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=TS5RxnF28Oc+fJsbmVSLp39A8zOvR3omrRkpamf5f/4Gj2ewyQDXJdqyV+qGPSpvCDfBsCNID35Sl3BM1G8JHYASPyuwGyC+UScmX3RXErxQaugf5ER7/T60EOLa/3hm6kiFcRyasBYWGA/n0M2I6lGqPkHZqlTk+PXrL8mU6N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ugeIRybP; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e28b624bfcso8261247b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 14:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729115513; x=1729720313; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=un/+KbZ/raL6SrexERiPhTBZjrcdtpNN2gh/5Lox+Yc=;
        b=ugeIRybPh6JMN2M0PD3Kcmzq9uILtZhCZgFrJEgd2NR0Q2isS70bRQyYazQQOc4YYz
         6vTPa3ADg8ZCmjSTqUgggzDEIVk41OMtgUKOHj4EmQp2D7hlhRdbZLR0uNA0Uu9DlWR0
         dmc5bdvy8OSPQwIagK1VBPjmQYnOTiKrim1H3OsuJ2ZF+SEc9/96nITSrrB6n4bB/1Ww
         xD+X50GiI2biNuFcCYoctOZfybm/reTyn9r54K6Lh1yzCb32t6XZqXBPaxw6zPbJKG13
         Vu35/waKnbw8mbiTbnasDr4I0aXVYdgND7/8zwd43F0DZKhzgJw5s3wLXH/uhwuIXte3
         A8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729115513; x=1729720313;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=un/+KbZ/raL6SrexERiPhTBZjrcdtpNN2gh/5Lox+Yc=;
        b=ZPu1AhPfvFzpcNW6DNl9xwC7BOF6K72pBdiLpYpwQHmCKoV6MICYJ5W3hZxG8YT17b
         4UWKErGR5hT1kLyBonh8WPydb2cle4BUtn/6rr5ja3b6Y4DHzhZhXp5GAEnYYgwv000S
         3RPuzqjjoh0yk2wY9wCs651yAv1Repe2wp+gC4V9FTzDxzd8L2dKw9gOjmng9VgfkuSb
         0GqwtJoRbNf/Ai7QCckf5f4w0VmIqRSRPToyHtoSD6il0bDc0SI9bvsyeapHljQlQA/5
         Sx6ZkrMIfWhHgVIkk3kScuUk/mdb/HZEzJrS86+/XKeY9eWnzMpUF9dnEkv/gbG11VNc
         M1vg==
X-Forwarded-Encrypted: i=1; AJvYcCURcl5VkLWqMsC+Nn35WvCv4ZBAKVrJzO+lCiFtDMae3WrWs3/4DRJawJrQkAb0eteqElur3RWXO3nmUrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlbjU7kXMn3fgKz0v4OpqEaEsFvQRerD8XZsq/aGlghdGEyyvn
	zkGxAQd6Uu3Nq5GWXSNmnONM4i2gBrtjB7lf685t4OGaKxeGrZI2O1mJAsl5421GrPBzTdhrTtH
	2JDp1Tw==
X-Google-Smtp-Source: AGHT+IEXigOqFWcNIr6ONd5QDFk41xOSSJkIXQuEyJcx7SV8OgGq4bdAOSyhZcuIkwTpfwaTRb1ysaxdRzQd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a05:690c:9a86:b0:6e2:6f2:efc with SMTP id
 00721157ae682-6e3d41c84bdmr1189017b3.5.1729115512794; Wed, 16 Oct 2024
 14:51:52 -0700 (PDT)
Date: Wed, 16 Oct 2024 14:51:31 -0700
Message-Id: <20241016215139.212939-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v4 0/7] CSV/JSON metric thresholds, fix printf modifiers
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Yicong Yang <yangyicong@hisilicon.com>, Weilin Wang <weilin.wang@intel.com>, 
	Tim Chen <tim.c.chen@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Metric thresholds are being computed for CSV and JSON output but not
displayed. Rename the color that encodes the threshold as enum values
and use to generate string constants for a json dictionary
value. Disable metric thresholds with CSV output.

Add printf attribute to functions in color.h that could support
it. Fix bad printf format strings that this detected.

v4. Drop CSV metric thresholds due to formatting variation on
    hypervisors (broken counters) and not as detected by
    tests/shell/stat+csv_output.sh.
v3. Rebase.
v2. Don't display metric-value for json output if there is no unit.

Ian Rogers (7):
  perf color: Add printf format checking and resolve issues
  perf stat: Fix/add parameter names for print_metric
  perf stat: Display "none" for NaN with metric only json
  perf stat: Drop metric-unit if unit is NULL
  perf stat: Change color to threshold in print_metric
  perf stat: Add metric-threshold to json output
  perf stat: Disable metric thresholds for CSV and JSON metric-only mode

 tools/perf/arch/x86/util/iostat.c             |   2 +-
 tools/perf/builtin-sched.c                    |   2 +-
 tools/perf/builtin-script.c                   |   6 +-
 tools/perf/builtin-stat.c                     |   8 ++
 tools/perf/builtin-trace.c                    |   2 +-
 .../tests/shell/lib/perf_json_output_lint.py  |   5 +-
 tools/perf/util/arm-spe.c                     |   2 +-
 tools/perf/util/color.h                       |   9 +-
 tools/perf/util/intel-bts.c                   |   2 +-
 tools/perf/util/intel-pt.c                    |   2 +-
 tools/perf/util/s390-cpumsf.c                 |   2 +-
 tools/perf/util/s390-sample-raw.c             |   6 +-
 tools/perf/util/stat-display.c                |  73 +++++++---
 tools/perf/util/stat-shadow.c                 | 128 ++++++++++--------
 tools/perf/util/stat.h                        |  16 ++-
 15 files changed, 169 insertions(+), 96 deletions(-)

-- 
2.47.0.105.g07ac214952-goog


