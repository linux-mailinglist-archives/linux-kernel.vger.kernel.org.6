Return-Path: <linux-kernel+bounces-389838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1351D9B7216
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 02:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C62E9285E55
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 01:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8810178B60;
	Thu, 31 Oct 2024 01:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="btAST+VR"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2681802B
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 01:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730339001; cv=none; b=K4TFX7Oz2wmm7AiFYrP1PDU5Isn4ikKZ2hmdXbRgG/QzEYWeARtYHpQAw7Yb+zt1UUrCzpFi59kwRxt72vIHG7i+6RhJsHFKPleHyz6rCjQYDrdfsZYARxqzLW2CsOAEtuD8OWkJvOwWW997O3VC9gkjQczjcwe0lTXftPIz8RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730339001; c=relaxed/simple;
	bh=YfcM0Xrt0PalwpXImDWKF3dTRPshhIqm6qd/DaBm8gw=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=iOy//EseExYBd//f1+QuRj2SJYUwRJ6s+WwNZ/1Bzu6TXJYkNEe7Lpmqi/cCObmJKy3pJjEwLrz5BxO2XX/XH9Zfapcx6BQ67h6r0kY/Kke2ujMfowamDNrFudu11zcWsQWACTTTtkIf9sGZGMkwSSCh0FaOTxgqd69t8eX2nk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=btAST+VR; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e321d26b38so8917777b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 18:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730338999; x=1730943799; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZtNNxKnf46vb/RPjOvFlimy8+1dXdMuSuVfKG4urPBw=;
        b=btAST+VRnyIQYLexBVagWnf2sxtnzraCHuAfQXB81YkUaE/FPxBuR/vc0F1Bm5WJTn
         BDhq8pvM9RjHP3aqKq17WYvl9i5/M44k0ZPgep20fQtdvANRg3EwHZYoK89+3sKSqS51
         7/AjXMBYRqViPwNtvATrwiaA7Nrgb3WmS0YXO5eBmRlL1+Z6uzu6WXyb9tgtojUa61KW
         QPnhGPfpW1r34ILK93/b/JyyN27z/AhofipV08oaAjlwhyVPnws2awDMVdAfCptURcrA
         9yk1gdfvQWTR94eYgupFm5LasfHta0uSfW168VS/BLEdJzixcWxVuosDQHu1DNxlXOm1
         QzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730338999; x=1730943799;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZtNNxKnf46vb/RPjOvFlimy8+1dXdMuSuVfKG4urPBw=;
        b=Te2GIRsnJmPBnBo/jXgX6Nq0LMDutexQKoEJDo5siyIY4UVLF84/OcDFH1aARtFIR8
         mr9tgf9pWZChiEoAF6qznN00mKt6DSpxbYkMPKigkVfo1Tj+OdQiQHaKFsRxC3YWYtse
         TD/k8aEAsWKTnkTnrmwKB+dBDsDhXw4EZEkV3413xOKe4Agq9wBmqgLdyVJJdljOQ1TK
         Lw3EEPvOza7IT/TzINBZYIINdqv78xijQgOp7+6WkBIizOfwhn1FGj/97ymizZT64pp2
         wqex8u7MT/82P8jgUQ7oHin4VNh14t3kJy5aKuLl0VS2xU6eh4ABojIkiESvwMBSfvbq
         7m3g==
X-Forwarded-Encrypted: i=1; AJvYcCU8nu9yA0kYfafrxWaRrF0hMrncXRnKxisv3S2UKFOgSmWdRZ79uM9j9UaS0NuhzZEb6WlW49b0/36cv3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAxpb9ytqL6AaI8aSirVJa26tHukpLvHp4gItF6UX6ZTyK4rYS
	t8NaCY8wibFGrQJ7XFaET1Hqz0jzIdmB4JFrqbCK4Xm4fuA9FiVUW6/95fGNPoVSPo8R1rQ9Jiv
	b5ZiV+A==
X-Google-Smtp-Source: AGHT+IHP52gG9qo1zc0+AD6vEbyOjx2Zq87cXbTJCMawo9GqyrUTETA4YlZ8aJvCxuAtan7BbQmEMYs4JNIi
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ad0f:67e7:f1a6:84c4])
 (user=irogers job=sendgmr) by 2002:a05:690c:67ca:b0:6e3:d670:f62a with SMTP
 id 00721157ae682-6ea52518e31mr38777b3.3.1730338998359; Wed, 30 Oct 2024
 18:43:18 -0700 (PDT)
Date: Wed, 30 Oct 2024 18:42:31 -0700
Message-Id: <20241031014252.753588-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v5 00/21] Python module cleanup
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

This patch:
 - removes workarounds for Python 2 module support due to long
   deprecation and challenges in developing new code;
 - constifies variables and parameters to functions;
 - removes python.c stub code which existed due to missing functions
   that are defined in the builtin-* files, in general the builtin-*
   code is moved into util;
 - remove bench and test perf C code from the python module;
 - adds parse_events to the python perf module.
 - improves upon some of the existing python perf module functins.

v5. Rebase. Fix NO_LIBBPF and NO_AUXTRACE related build failures
    caught by Arnaldo and the build-test. Fix NO_AUXTRACE x86
    arch_fetch_insn in the process, which was incorrectly using an
    empty weak symbol stub.
v4. Rebase. Fix the parse events evsel to be embedded in a
    pyrf_evsel. Add __str__/__repr__ functions to evlist and
    evsel. Throw an exception for a bad evlist index.
v3. Move is_directory_at to patch 6 rather than patch 7, respond to
    review feedback on the list from Namhyung.
v2. Add the bottom 4 bullet points - 13 more patches.

Ian Rogers (21):
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
  perf x86: Define arch_fetch_insn in NO_AUXTRACE builds
  perf intel-pt: Remove stale build comment
  perf env: Move arch errno function to only use in env
  perf lock: Move common lock contention code to new file
  perf bench: Remove reference to cmd_inject
  perf kwork: Make perf_kwork_add_work a callback
  perf build: Remove test library from python shared object
  perf python: Add parse_events function
  perf python: Add __str__ and __repr__ functions to evlist
  perf python: Add __str__ and __repr__ functions to evsel
  perf python: Correctly throw IndexError

 tools/perf/Makefile.perf                      |   7 +-
 tools/perf/arch/x86/util/Build                |   2 +-
 tools/perf/bench/inject-buildid.c             |  13 +-
 tools/perf/builtin-kvm.c                      |  61 ----
 tools/perf/builtin-kwork.c                    |   3 +-
 tools/perf/builtin-lock.c                     | 137 +------
 tools/perf/builtin-script.c                   | 304 +---------------
 tools/perf/builtin-stat.c                     |  27 --
 tools/perf/builtin-trace.c                    |   1 -
 tools/perf/builtin.h                          |   6 -
 .../scripts/python/Perf-Trace-Util/Context.c  |  20 +-
 tools/perf/tests/stat.c                       |  16 +-
 tools/perf/trace/beauty/arch_errno_names.sh   |   3 +-
 tools/perf/ui/browsers/scripts.c              | 177 ++++++++-
 tools/perf/util/Build                         |   4 +-
 tools/perf/util/bpf_kwork.c                   |   2 +-
 tools/perf/util/bpf_kwork_top.c               |   2 +-
 tools/perf/util/bpf_lock_contention.c         |   2 +-
 tools/perf/util/cgroup.c                      |   2 +-
 tools/perf/util/config.c                      |  27 ++
 tools/perf/util/dlfilter.c                    |   3 +-
 tools/perf/util/env.c                         |   4 +
 tools/perf/util/env.h                         |   2 -
 tools/perf/util/evsel.c                       |  19 +-
 tools/perf/util/evsel.h                       |   2 +-
 tools/perf/util/intel-pt-decoder/Build        |  18 +-
 .../intel-pt-decoder/intel-pt-insn-decoder.c  |   3 -
 tools/perf/util/kvm-stat.c                    |  70 ++++
 tools/perf/util/kvm-stat.h                    |   3 +
 tools/perf/util/kwork.h                       |   6 +-
 tools/perf/util/lock-contention.c             | 170 +++++++++
 tools/perf/util/lock-contention.h             |  37 +-
 tools/perf/util/path.c                        |  10 +
 tools/perf/util/path.h                        |   1 +
 tools/perf/util/python.c                      | 338 ++++++++----------
 .../scripting-engines/trace-event-python.c    |  63 +---
 tools/perf/util/stat.h                        |   3 +-
 tools/perf/util/trace-event-scripting.c       | 177 +++++++++
 tools/perf/util/trace-event.h                 |   5 +-
 39 files changed, 872 insertions(+), 878 deletions(-)
 create mode 100644 tools/perf/util/kvm-stat.c
 create mode 100644 tools/perf/util/lock-contention.c

-- 
2.47.0.163.g1226f6d8fa-goog


