Return-Path: <linux-kernel+bounces-383155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CAA9B17E4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 14:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F41B6B21885
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 12:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884A61D5164;
	Sat, 26 Oct 2024 12:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Deg58Wpx"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAC81D2F50
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 12:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729945086; cv=none; b=RsVoAvDYD640b7vhlsJt6ETd1Zd+eOVHuuNrodjS7sup6sf1DPCcPCqKTJ+WXlTOQ0K4w9ExvKjxuQt/7NlpHvLdiJwUFw887BZJuZ/zmF82lNpmyTZsdTHgX1RDMv4AZ+jjjD+3AgvnSenz/eCDbtDn7VYo546HVx6SqkhoW/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729945086; c=relaxed/simple;
	bh=f+Yk5CtSNdB/1Lmu/zKBb9xb884EAaFAdkWSJ9+l47A=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=Psf2ckEbMXqJOeX8cJN6VAebko5SS5KfO07VHavdDPsEmZyB8t016Ba/e7L/2p6rI4U7jVIXaQvdsrxOFg1kAWzEqsDvMvZ1LJiDCguyDFP2FGsWIaRPlL8mcWKzueHmsEeokhRTicyuCUkWh8NptG82EXpZ1YBkJgKF2xOLLt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Deg58Wpx; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2954ada861so5419645276.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 05:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729945084; x=1730549884; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fBcJl01TtjB1sQ+coZ3yEQeNcjr8kffC1BqiKyM+Ja4=;
        b=Deg58WpxuUdeldjva0WZ2Qi6mnOYfCjCqMrOeEpyh4hGln4wyn2LlpVI0xVdGVaHw0
         HoKTCa0oORN1xR0yB890uag0h7AKpP5q+BUCuJ7SQkT9tAlGbeG56QDvkoNM6tpaK+dx
         mye8VYen+7tyQ/s61zeTIYrcfDVGt8oto+/l4W5Wf+QaQDBvAJ5DjDWUe14rmY9AeXSW
         hGM+ILPhaxBZVFWu3sci7epCegS0ff6JnpbKxu4IpxpL5IxP7rsM21TP7D4K5c11MJ+R
         onUCyzRLlNxQbKKmmBLCT2nnUa3inTLSSV0slXgMGJamqO1Qcv1VVIhSaDtK2Xm00+X/
         ojww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729945084; x=1730549884;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fBcJl01TtjB1sQ+coZ3yEQeNcjr8kffC1BqiKyM+Ja4=;
        b=cjn/p9MAFVTFIqwW3A6SKNrTOWH9lNb0Xt6Jf1n2zYiBz7P7yprivHLn4oWgCUY5Nh
         WmdmhAh5yxMbXEWbhk6gSFF/MCSnI2W0IomYr+g7Thc2s7VQ+WC2uaV8Hz1qgwX5gfYo
         0SbcC0xsYPifYjOFbm3P6vIOz3+65L4Km8TpM+SlzNjDwuCxThrPUQ0xs9vquyDiGBST
         hnRWkNPQS9Dmlb7ywfxub8DoNKV5HzVtx1Ei1ZbANPgGLQCU36akoVUTZkXknIg/tsyQ
         tXo9YY4QIefMyGoasWVrkdBYlZLx910lDqxGY76cDrDEUo0OnPRrT03Y/D1UU2vgFU0Y
         v4uA==
X-Forwarded-Encrypted: i=1; AJvYcCXJaGJqPgMLeVcq7TuPDiAV4bZwJchp4SnaBnjutp/6G2efb5fK+3m/MM7AQIoeXkIw7GUoSMHlGPrAqAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh7vp8YwocooL6AJvU/h7gSbJoFym96ZhsMsrA6pPVwL9yO5RW
	jYsrIqAQmePWpzb7ewiq/pnfqV8TYcr2okDinat1kSvOe3JZkxCyWy6AsegPMEy4EEXs1B/q9cc
	jqFX5gA==
X-Google-Smtp-Source: AGHT+IE9zYMgTwSHLGYlj300YfFrmvke8frEqe5oUqwbyU39/+jljEJ0ran0v7PIwH2GumKW+rj4eS6UlTFR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:4bc4:f7cc:83b4:dece])
 (user=irogers job=sendgmr) by 2002:a25:a207:0:b0:e25:6701:410b with SMTP id
 3f1490d57ef6-e3087b792abmr5358276.5.1729945083545; Sat, 26 Oct 2024 05:18:03
 -0700 (PDT)
Date: Sat, 26 Oct 2024 05:17:54 -0700
Message-Id: <20241026121758.143259-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v1 0/4] Prefer sysfs/JSON events also when no PMU is provided
From: Ian Rogers <irogers@google.com>
To: Atish Patra <atishp@rivosinc.com>, linux-riscv@lists.infradead.org, 
	beeman@rivosinc.com, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Ben Gainey <ben.gainey@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Junhao He <hejunhao3@huawei.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

At the RISC-V summit the topic of avoiding event data being in the
RISC-V PMU kernel driver came up. There is a preference for sysfs/JSON
events being the priority when no PMU is provided so that legacy
events maybe supported via json. Originally Mark Rutland also
expressed at LPC 2023 that doing this would resolve bugs on ARM Apple
M? processors, but James Clark more recently tested this and believes
the driver issues there may not have existed or have been resolved. In
any case, it is inconsistent that with a PMU event names avoid legacy
encodings, but when wildcarding PMUs (ie without a PMU with the event
name) the legacy encodings have priority.

The patch doing this work was reverted in a v6.10 release candidate
as, even though the patch was posted for weeks and had been on
linux-next for weeks without issue, Linus was in the habit of using
explicit legacy events with unsupported precision options on his
Neoverse-N1. This machine has SLC PMU events for bus and CPU cycles
where ARM decided to call the events bus_cycles and cycles, the latter
being also a legacy event name. ARM haven't renamed the cycles event
to a more consistent cpu_cycles and avoided the problem. With these
changes the problematic event will now be skipped, a large warning
produced, and perf record will continue for the other PMU events. This
solution was proposed by Arnaldo.

Two minor changes have been added to help with the error message and
to work around issues occurring with "perf stat metrics (shadow stat)
test".

The patches have only been tested on my x86 non-hybrid laptop.

Ian Rogers (4):
  perf evsel: Add pmu_name helper
  perf stat: Fix find_stat for mixed legacy/non-legacy events
  perf record: Skip don't fail for events that don't open
  perf parse-events: Reapply "Prefer sysfs/JSON hardware events over
    legacy"

 tools/perf/builtin-record.c    | 22 +++++++---
 tools/perf/util/evsel.c        | 10 +++++
 tools/perf/util/evsel.h        |  1 +
 tools/perf/util/parse-events.c | 26 +++++++++---
 tools/perf/util/parse-events.l | 76 +++++++++++++++++-----------------
 tools/perf/util/parse-events.y | 60 ++++++++++++++++++---------
 tools/perf/util/pmus.c         | 20 +++++++--
 tools/perf/util/stat-shadow.c  |  3 +-
 8 files changed, 145 insertions(+), 73 deletions(-)

-- 
2.47.0.163.g1226f6d8fa-goog


