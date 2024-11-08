Return-Path: <linux-kernel+bounces-402211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BD49C250D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABA7EB2382B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A22233D96;
	Fri,  8 Nov 2024 18:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DwWAUdWZ"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB0319259B
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 18:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731091676; cv=none; b=JeXScrbDJv/I0/gp6ALyqCp60rpMVjxYlRPJkO7qNhDmyTfhhAiWwhKrD1zrJHLf24WTtvGlM1OtyDa1HINsvexr6Zpd6JecVbch5omqFBpmI9pVyAEdwrgxNKWAgxRrsiIO3MCInEWhUOThoEPmOr++Bw5cI2GstO9+eirGMCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731091676; c=relaxed/simple;
	bh=6LmbQELXxQKouTzm2dR1ruovpAw+ncobzPbgDcIN/fQ=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=Oj3kTfmBmn79Auzziwh8JLWuv/XYPGJxbwtaiHTfntCMRRLJfkEdpew3zLRDXmX0cnzA5Ojx/HZ/1/EY5VSraDFcS98t/Q44cNLd8VoLrSHqTBQP29+KUobNxiOD8YXDuLUKBLXrfb0ae1j7ix3WKXYVKs+06rmjp1Tl8POLOWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DwWAUdWZ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6eae6aba72fso12087027b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 10:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731091674; x=1731696474; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sYbic6g8fYbYz/lxOerjmFFUp0LautdATerL7NAvkig=;
        b=DwWAUdWZFR5bEl67z9DStOOqyibAc+SjHtrhhGw8dCSPUFz8Yz4oR4YD+HPQN4dapE
         mHsFZyxwXYG1PzaFIbP7StVgNNTFTwTiMUWiWkMq5XWIC1wQMiB3YXSCEpTcO3SvWptt
         AKGCaTtICyTEIazFQt8qyCS5wpCEwEyCd8a2SJbOeOo8Q/9KXfQ0/TTjuesocrzzHEid
         6KuLCTaE+BMNBCiFY2jOWsKnGhWutd3g5mJEgPdvITCDZI8eBvO7WtT+QBglxYNvd2el
         o/AimvZEEv+BvUUnqqoOQ+HsfnHKqzQJDAPZFUHh6xOIgkPNkKE+9W2rDE/LJhe6nGSo
         SAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731091674; x=1731696474;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sYbic6g8fYbYz/lxOerjmFFUp0LautdATerL7NAvkig=;
        b=PU1T1NPR3MLj2ySRQ1SCJcZzjzI/YFqx6bmxFf461Bpzm839dTQIQKtY4SgRuZPT33
         XE338CxgrXznvWBRZRL7Tc2BLlpubn4Wxwz9QLmQwmXYshRMMoRaWlya3JlNgD/3YfaY
         yNUU5bZjLSdsMDRHbzrNmboqrKC9nj79L0bmQuSxPBiJv3FMU5ExcbEIrDZpn/Akl+DH
         QE8b/vRM6zhfyvXfcEbk2DiKu+2JK3m7x9vvF68oeW7P5QY1bx4F8EiuR+rN6SQEvQce
         WI+yF+1gZ1nVvHOtqMGOCwK2TTd/I+HePoH5yLgx6nVVOXFv3S8Iybt4V2uEPURMZU3a
         eCjg==
X-Forwarded-Encrypted: i=1; AJvYcCU7cVoEnlVdveXYSGl9rl34PZLXSZnTvALCo6DM776Byu1XVJp/QbIxwPEg81AYCaMqYnn6KxJMzcyZLkM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywkt9+5Vp0eErsLeRqjWweHlrX8smNwR1Xu+DV4XditfW6eQIv
	JOcrPdF/3nxb1yx+qwOOU6aULH7Uw7GQF6DVSKS092aGEQBj9IwzEIR6e8a0ZnEC6cik5MYqA5u
	e6hzPPw==
X-Google-Smtp-Source: AGHT+IFVw3cau2nh6WkJX7tgUmWOKqlA+HW6J4EJ3L5pw0bFMLr6+1Gics50g/HEmg0uDIcINH3fE11rYHA1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:6fd2:1e36:6d8c:7c49])
 (user=irogers job=sendgmr) by 2002:a05:690c:288:b0:6e2:1ab6:699a with SMTP id
 00721157ae682-6eaddfea2a9mr419297b3.7.1731091674267; Fri, 08 Nov 2024
 10:47:54 -0800 (PST)
Date: Fri,  8 Nov 2024 10:47:45 -0800
Message-Id: <20241108184751.359237-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v4 0/6] Avoid parsing tracepoint format just for id
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	James Clark <james.clark@linaro.org>, Dominique Martinet <asmadeus@codewreck.org>, 
	Yang Li <yang.lee@linux.alibaba.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Yang Jihong <yangjihong@bytedance.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Ben Gainey <ben.gainey@arm.com>, zhaimingbing <zhaimingbing@cmss.chinamobile.com>, 
	Zixian Cai <fzczx123@gmail.com>, Andi Kleen <ak@linux.intel.com>, Paran Lee <p4ranlee@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, 
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"

The tracepoint format isn't needed to open an event, just the id for
the config value. Refactor the use of evsel->tp_format to use an
accessor that will lazily construct its value. In evsel__newtp_idx
read the id so the config value can be set up/used.

This allows tracepoints to be used without libtraceevent in a number
of tests. Other functionality is enabled without libtracevent, such as
mapping a tracepoint id back to its name. There may be some
performance benefit to code using tracepoints but not using the format
information.

v4. Rebase due to conflict with 9ac98662dbd3 ("perf: event: Remove deadcode")
v3. Whitespace changes, Arnaldo.
v2. Add additional error checking/handling in evsel__tp_format.

Ian Rogers (6):
  tool api fs: Correctly encode errno for read/write open failures
  perf trace-event: Constify print arguments
  perf trace-event: Always build trace-event-info.c
  perf evsel: Add/use accessor for tp_format
  perf evsel: Allow evsel__newtp without libtraceevent
  perf tests: Enable tests disabled due to tracepoint parsing

 tools/lib/api/fs/fs.c                         |   6 +-
 tools/perf/builtin-kmem.c                     |  12 +-
 tools/perf/builtin-kwork.c                    |   3 +-
 tools/perf/builtin-record.c                   |   2 -
 tools/perf/builtin-script.c                   |   9 +-
 tools/perf/builtin-trace.c                    |  79 +++++++++----
 tools/perf/tests/Build                        |   6 +-
 tools/perf/tests/builtin-test.c               |   2 -
 tools/perf/tests/parse-events.c               |  25 +---
 tools/perf/util/Build                         |   2 +-
 tools/perf/util/data-convert-bt.c             |  10 +-
 tools/perf/util/data-convert-json.c           |   8 +-
 tools/perf/util/evsel.c                       | 110 +++++++++++++-----
 tools/perf/util/evsel.h                       |   9 +-
 tools/perf/util/evsel_fprintf.c               |   4 +-
 tools/perf/util/parse-events.c                |  16 +--
 tools/perf/util/perf_event_attr_fprintf.c     |   4 -
 .../util/scripting-engines/trace-event-perl.c |   3 +-
 .../scripting-engines/trace-event-python.c    |   3 +-
 tools/perf/util/sort.c                        |  33 ++++--
 tools/perf/util/trace-event-parse.c           |   2 +-
 tools/perf/util/trace-event-scripting.c       |  10 +-
 tools/perf/util/trace-event.h                 |   2 +-
 23 files changed, 214 insertions(+), 146 deletions(-)

-- 
2.47.0.277.g8800431eea-goog


