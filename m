Return-Path: <linux-kernel+bounces-376708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5B49AB517
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDF341C22D49
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332001EB48;
	Tue, 22 Oct 2024 17:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wuLL8zyO"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10C61B141D
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 17:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729618251; cv=none; b=TbwP9IEg+lDhUVqZJSKoFOrtYudGGYyKnQnJqgznXVTdTxIGA3P1o2FwVWNb6B3IYrL+BWsofzkFcMA0Yd1+MXXqtkM1NnLnZQndtKW2OBiFFjD5/o/HPoBSUJcW/BWnvQFOCx6CLy8616HppBMRYP4PKg7tIe0gQr7OxI08qRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729618251; c=relaxed/simple;
	bh=swdELWAxqmRkH1w5SyEIlsFbGcO181LmtSgPanp2BfI=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=ZU9KUsSZ8rUa+Q0S2WMfWFuCh370tNMdQ1xvjdMpasblGHd2n9pBVcYr5ntzwzbGbYyf34PhAEzHwhv9uJNsu14e9wgI/OQC9cM4ELI6a6tGzg2V5wkxpIsMUgw1x2kElHF/Xg6+1djgE6nwBZs4CTt9m+AY1hg3e8r6aWay1XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wuLL8zyO; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e383ba6763so102505317b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729618249; x=1730223049; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ibtm1EDFpB8HMQFY8v0qVADM/438Ul1MlokLBKds7Rs=;
        b=wuLL8zyO8VOP7p4cjoTxKlI6PKbUKk6f22SwKx2to/DvTdboSEqXYQBq603JUojjyX
         9N7a/pFUwT6SjtjBwrCxLb8ItXmlzhz4j05zH7UD/HxyCMDA/PG0eFGJnHdmZ2OuzlV4
         kM5o1HuOF9S8+2D38rJnoAhx8FZBAajaDWdgGSsu5Cb0gnGMlq3/R9gX4IZMonX5AygW
         tI2HVPcWAJR7qmORlgq741cD0tDft6QM3MTZizF8Q5owop1H3/1MlHFXGU8Ey26fjq5I
         9TdtoP3nbUWXImGr2Nxg1b4jT3vWBLg8WDMkLoQsbxOapAM4ohdL5Bp5Fgr3qR4dhxyP
         b66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729618249; x=1730223049;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ibtm1EDFpB8HMQFY8v0qVADM/438Ul1MlokLBKds7Rs=;
        b=AL9v/4DnyXIduFI0apsi6xOOP8/hP7k3U1fhc7nPQEALQ4kWDzpSEvHnYXoDcUZUg+
         MiyAIncUpbUEc9wwlowvZqHDs2l4e57CkuOryaqjbi3NdlM6Qsal6cT9yT6ITomghFZ+
         31Vz4pKEPeI+GBHSdSXzwEPtBmHKS6244MTdhligG68LMuwXloGmg9kowRvEyha9Gg6k
         xrX+kEXXyiJXo0HAtLqfchIcYEU9v/Xk2DRl3FfY6d3d7+dHC9FhDgifSu+Cx2ZTw9aA
         hgXCvaYLkRzCHX2tUIiQumnt/9dqMO57a/7xXa011xQ1B0xqkRz/8gyiXXUo0/usKIJ/
         Nkrg==
X-Forwarded-Encrypted: i=1; AJvYcCVjyB6/RsPTx5PwzO31J0ItWmOkJtlfEg9EEvnuzdHv5TUaiqRSAwEOtwLELTDWsltJh+5ndp75Df6PM7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRGVbtr5dB9RYAGM1VNpCc69/F/FKjsgfAHCwnFjAxTW6Oni5W
	yySZ8nDisFboZRktpzxR1il9crS18kgTNL0828C9tE3MXR9rq+nVbSICl+3d8O/VP9eZzYV9clx
	PXsUu8A==
X-Google-Smtp-Source: AGHT+IEFXyNCAzgoq+kgwxIq1rq5ezEZZlTQ6BSlu6m/O5kal1uKWFPOa89M36L0WpnHNM3xDpKzKPwNNJW2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:57ba:88e0:aaf6:282])
 (user=irogers job=sendgmr) by 2002:a05:690c:4d45:b0:6db:c6ac:62a0 with SMTP
 id 00721157ae682-6e5bfc0440fmr4189887b3.5.1729618248898; Tue, 22 Oct 2024
 10:30:48 -0700 (PDT)
Date: Tue, 22 Oct 2024 10:29:58 -0700
Message-Id: <20241022173015.437550-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v3 00/16] Python module cleanup
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
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch builds upon:
https://lore.kernel.org/lkml/20241015000158.871828-1-irogers@google.com/
as those patches remove a util to test dependency assumed to be
present for "perf build: Remove test library from python shared
object."

The patch:
 - removes workarounds for Python 2 module support due to long
   deprecation and challenges in developing new code;
 - constifies variables and parameters to functions;
 - removes python.c stub code which existed due to missing functions
   that are defined in the builtin-* files, in general the builtin-*
   code is moved into util;
 - remove bench and test perf C code from the python module;
 - adds parse_events to the python perf module.

v3. Move is_directory_at to patch 6 rather than patch 7, respond to
    review feedback on the list from Namhyung.
v2. Add the bottom 4 bullet points - 13 more patches.

Ian Rogers (16):
  perf python: Remove python 2 scripting support
  perf python: Constify variables and parameters
  perf python: Remove unused #include
  perf script: Move scripting_max_stack out of builtin
  perf kvm: Move functions used in util out of builtin
  perf script: Move find_scripts to browser/scripts.c
  perf stat: Move stat_config into config.c
  perf script: Move script_spec code to trace-event-scripting.c
  perf script: Move script_fetch_insn to trace-event-scripting.c
  perf script: Move perf_sample__sprintf_flags to
    trace-event-scripting.c
  perf env: Move arch errno function to only use in env
  perf lock: Move common lock contention code to new file
  perf bench: Remove reference to cmd_inject
  perf kwork: Make perf_kwork_add_work a callback
  perf build: Remove test library from python shared object
  perf python: Add parse_events function

 tools/perf/Makefile.perf                      |   7 +-
 tools/perf/bench/inject-buildid.c             |  13 +-
 tools/perf/builtin-kvm.c                      |  61 ----
 tools/perf/builtin-kwork.c                    |   3 +-
 tools/perf/builtin-lock.c                     | 137 +-------
 tools/perf/builtin-script.c                   | 303 +-----------------
 tools/perf/builtin-stat.c                     |  27 --
 tools/perf/builtin-trace.c                    |   1 -
 tools/perf/builtin.h                          |   6 -
 .../scripts/python/Perf-Trace-Util/Context.c  |  20 +-
 tools/perf/tests/stat.c                       |  16 +-
 tools/perf/trace/beauty/arch_errno_names.sh   |   3 +-
 tools/perf/ui/browsers/scripts.c              | 177 +++++++++-
 tools/perf/util/Build                         |   2 +
 tools/perf/util/bpf_kwork.c                   |   2 +-
 tools/perf/util/bpf_kwork_top.c               |   2 +-
 tools/perf/util/bpf_lock_contention.c         |   2 +-
 tools/perf/util/config.c                      |  27 ++
 tools/perf/util/dlfilter.c                    |   3 +-
 tools/perf/util/env.c                         |   2 +
 tools/perf/util/env.h                         |   2 -
 tools/perf/util/kvm-stat.c                    |  70 ++++
 tools/perf/util/kvm-stat.h                    |   3 +
 tools/perf/util/kwork.h                       |   6 +-
 tools/perf/util/lock-contention.c             | 170 ++++++++++
 tools/perf/util/lock-contention.h             |  37 +--
 tools/perf/util/path.c                        |  10 +
 tools/perf/util/path.h                        |   1 +
 tools/perf/util/python.c                      | 264 ++++-----------
 .../scripting-engines/trace-event-python.c    |  63 +---
 tools/perf/util/stat.h                        |   3 +-
 tools/perf/util/trace-event-scripting.c       | 176 ++++++++++
 tools/perf/util/trace-event.h                 |   5 +-
 33 files changed, 767 insertions(+), 857 deletions(-)
 create mode 100644 tools/perf/util/kvm-stat.c
 create mode 100644 tools/perf/util/lock-contention.c

-- 
2.47.0.163.g1226f6d8fa-goog


