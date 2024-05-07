Return-Path: <linux-kernel+bounces-171983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5738BEB82
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FE691C227CA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8F216D4F1;
	Tue,  7 May 2024 18:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MOdzxAuw"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D0E4C8A
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 18:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715106966; cv=none; b=XZ2hzfeilCuktA0+IrvW2vGGOD614Vec0JjIpqN8U8zxhgA/J75cPmzbaa2/HqQ9bsXYLLPKSAXqKCiWnvLWU+BxfKmbLnKdMzSdqZ8MadGMHH1OcCRsjGTDtiqGmnEIu3BdtZ6jxYX+9Ftie4oe6cxp6uiqjI6MuNi9EDlC2Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715106966; c=relaxed/simple;
	bh=tzWS+kPyt79XbOX+5oaytxEr+MBWVTX6zlqUe/8VBnc=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=YXJDp2bOZpFVJlVYfetZ2Meoy370D3W1/RiH98mg3qQqwQ5mLAYHIiqjXbZjL4rXtR5MgILyFLhOLesDxJcY5Kt6/Zyz/lCnCscqyIC1CKJ4m9Nw0IhC2UQqAIKxNEXxBGI/bkkrvrshTZXMWMsGF+rtBYikNdp5wv2Njweyhew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MOdzxAuw; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de54be7066bso6494543276.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 11:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715106964; x=1715711764; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SxLHBX613BezPFCosUL3vMa1Z1WB1g1HWATAv+V05wY=;
        b=MOdzxAuwvzp28I7qBQQYnY8ctEtXxn2lqCdq8jISugFk2Y7dLx0A5pr67vsHkLRI9y
         b6jWH0E6JUsa3NpjzaTWc5atX9+YwAKmH3LJLzC2MM88RlBw6x4MbkmhfthdxFEtJdKS
         t5/IjtBT2yIhPHAAwVw3Hloonqb+9i2dOEGeaMuoozH+MF3gefA7AkMQ/Pbvc7d3twqe
         kBfK1V+tqK03amzuJVCq9gO+I5SUXae9bXVyzNx7P+RDVicUiUN+rQQrCNfxxRfXufL+
         XQkicNaCxRp02hU22r1VusPVqaVcJGlRm97PJ/ujalmMdlsAX5VJxUsO4QyFbp5fUT2u
         wPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715106964; x=1715711764;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SxLHBX613BezPFCosUL3vMa1Z1WB1g1HWATAv+V05wY=;
        b=OFYU2mjHVSiMsAfOEwUpEQpGONffOcFAjJcVuSCuHJbaSs1DNLGA6jrJclxvbEFuhW
         h/vDlsc/NRp+r8/rlT1l2dWSTkyWYjFSYbBQwBg7kW1PvVToVFcXLkBHTNNpEsT0Hc1e
         t+RQB3vGe65e8Dw4UZiF/eqr6RmNG/ugWd9s6yq39PzL3d6dalxf1tHwvijOdiFG81nP
         PeZBOwJbqdvTvZuJfdzP/uf95YExx19oF9lY7x8uy2x9EHkqqH9G9uTSykTRBpbAr4LC
         p7jI6I7psxBAq57KZMETTkrXyg5+Rh5q3TwctYKFj+WYuzYysAnTt4Pps+tZ7eexXFW/
         V15Q==
X-Forwarded-Encrypted: i=1; AJvYcCWL7k0BXMzLI6Kf3d92uUPm50QMDMGqzpl5BCejldw0Vwcj+FP5nwwas6jBN2ESGAtI8U091d+biTkImEF4e2WTUPD8xveuCti/Hz81
X-Gm-Message-State: AOJu0YxqykQSxS11/Oi7Lt/pTMhezSk9feYdqqy64kp2MKakE1zcccBC
	h5/ah+DCRcojdQ7S6CvxvvxuVyPfU6OYXJgXK1+xTdzE/Y0JkNuOfB7zF7QVGE/3VZw/a3FWVLJ
	2LFbCKA==
X-Google-Smtp-Source: AGHT+IHLQRJTCEv97D7oZ5BJYbjKtKtzp6hp1etnh5mXJgEBM/I0f4k6ffrpTNXBtnPmKqqKpoweO9puZjHH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8095:fd7:9773:b1df])
 (user=irogers job=sendgmr) by 2002:a25:b20a:0:b0:de6:1301:600a with SMTP id
 3f1490d57ef6-debb9da609fmr114708276.9.1715106963603; Tue, 07 May 2024
 11:36:03 -0700 (PDT)
Date: Tue,  7 May 2024 11:35:37 -0700
Message-Id: <20240507183545.1236093-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v1 0/8] Address/leak sanitizer clean ups
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	James Clark <james.clark@arm.com>, Tim Chen <tim.c.chen@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Kajol Jain <kjain@linux.ibm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, Li Dong <lidong@vivo.com>, 
	Paran Lee <p4ranlee@gmail.com>, Ben Gainey <ben.gainey@arm.com>, Andi Kleen <ak@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Remove unnecessary reference counts for structs with no gets.  Add
reference count checking to comm_str and mem_info.  Fix memory leaks
and errors detected on "perf mem report" by address sanitizer and leak
sanitizer.

Ian Rogers (8):
  perf ui browser: Don't save pointer to stack memory
  perf annotate: Fix memory leak in annotated_source
  perf block-info: Remove unused refcount
  perf cpumap: Remove refcnt from cpu_aggr_map
  perf comm: Add reference count checking to comm_str
  perf mem-info: Move mem-info out of mem-events and symbol
  perf mem-info: Add reference count checking
  perf hist: Avoid hist_entry_iter mem_info memory leak

 tools/perf/builtin-c2c.c                      |  13 +-
 tools/perf/builtin-report.c                   |   3 +-
 tools/perf/builtin-script.c                   |  12 +-
 tools/perf/builtin-stat.c                     |  16 +-
 tools/perf/tests/mem.c                        |  11 +-
 tools/perf/ui/browser.c                       |   4 +-
 tools/perf/ui/browser.h                       |   2 +-
 tools/perf/util/Build                         |   1 +
 tools/perf/util/annotate.c                    |   6 +
 tools/perf/util/block-info.c                  |  22 +-
 tools/perf/util/block-info.h                  |  15 +-
 tools/perf/util/comm.c                        | 196 +++++++++++-------
 tools/perf/util/cpumap.c                      |   2 -
 tools/perf/util/cpumap.h                      |   2 -
 tools/perf/util/hist.c                        |  62 +++---
 tools/perf/util/hist.h                        |   8 +-
 tools/perf/util/machine.c                     |   7 +-
 tools/perf/util/mem-events.c                  |  36 ++--
 tools/perf/util/mem-events.h                  |  29 +--
 tools/perf/util/mem-info.c                    |  35 ++++
 tools/perf/util/mem-info.h                    |  54 +++++
 .../scripting-engines/trace-event-python.c    |  12 +-
 tools/perf/util/sort.c                        |  69 +++---
 tools/perf/util/symbol.c                      |  26 +--
 tools/perf/util/symbol.h                      |  12 --
 25 files changed, 370 insertions(+), 285 deletions(-)
 create mode 100644 tools/perf/util/mem-info.c
 create mode 100644 tools/perf/util/mem-info.h

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


