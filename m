Return-Path: <linux-kernel+bounces-393504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F199BA187
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 17:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C0C91C209C2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 16:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F7D1A7265;
	Sat,  2 Nov 2024 16:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4Ca04J5F"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860891A3BA1
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 16:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730566452; cv=none; b=YtgU4yTuAl3sZeEjztt5EqplFsqH1WKkH7D1iwZJkMZKuNyS9Ch6Xj4YPOywdafccNkjLrf5BuQitEWcecsYK6i9ES1wXdO+CB/ZMOjouhgric+87LSS3t3uzWLbEW099ayO4BH2s0GSIqEgKaLukJfTAVlRSMrS+5j2HJPE6uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730566452; c=relaxed/simple;
	bh=uvT7Jt18QdLMEnWuwF5FiFkhA6QSqQ3s+ITWtrpIjkI=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=NZx2WFne8FrQ6TbBP7LPO3529NJW3mnXOT2OYzs68JS8XgIRybdMBcWz4QIKtc2dzs98avg62SSbmdoxK2IwOmyH55YN5kGrprlBE8AsPC7qHuxXoTfkb9tshhjR6MS9Eld/f5QY+OGuyZiDmla3zsXUtFeBShfr+yZpcEZLh24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4Ca04J5F; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e7fb84f99cso60732567b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 09:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730566449; x=1731171249; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0uUEtUE6reGy3hUjf41A625G8CSBp4sF/WXt+DqRh+g=;
        b=4Ca04J5Fkcps73YO1sCJ9nsLRoFRUiDHW/cqQQPawZugl830rkmlRlOILk35VCP22n
         0OYjGBWLpLLZM/aXnZ7Ns5xn/yVlDgP4+adzgQ0gsY3XyWIptHSF5YOhf6YyQhWX2gF/
         Bq4ecxQYnGcWK4rgRIslMZmfUQ+Lbge658Cmz3EC12PTuo+Bvvr3AXUqNuOXRDCrS8GY
         y0UimGRcbD4wpafIhnDYJSEfDjX6j4JYf1Gq1aNSIXZwNEtB/YMHIJzdzlNhjervLTQS
         4gO2qB5TeOaOpxCsiOHf35bo8aSt27nkfLThTgbHY9TkAT+Efm+Zc1M5IAFb/uWe0cSZ
         CKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730566449; x=1731171249;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0uUEtUE6reGy3hUjf41A625G8CSBp4sF/WXt+DqRh+g=;
        b=fl/m3No4uCVr+2zB/4ecIeGCB//JVmWuckpe1oFAVzM9lwqp8wI+JjrjSblZmPlSmT
         aGLhCSHfElHMavpHBtfYIayHYq5FOUUziYjxsJz8U26bgcMa2qBY4QBX4c278GfeWhVe
         otUE3boI42NxzMsoOFE+Bka7ACZmZHoHXpOVWamnQ49UhYPDnCEZm+onPMuMZU11XI1L
         I6VlaE54k8ADtHEPb1xQRLamvyJOcJswANTW4C/anL8XAyPf02TDZj2QlcEuF7vNgWgv
         kRc5VCzW2RTkSXg2s4yCg7On6fgBQ/hPoN/E1Bx6I+FjGYPXLDo019lu8SjeMwZCqc8r
         3biQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4SifDdVcmE/1AcOLIn/qiKZjzEazTtsABdr9n221AC2tzRZ/DDt3qBv1v5SjtzegFrNXc9nawUjkbClU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHMkiKvKrqjSaQycsepKUAaAvckqGArdSi764SFdl+CP9ORa6e
	Emf6UbUX6OLNvZ2sF7k3bRJpA4l3vyb6NYFICoeL2OAe5dNr/gOEVOfNajMG9f/xsgKgyQvb7WB
	T2A9VYg==
X-Google-Smtp-Source: AGHT+IH6yRADeLOdKdN5cqV3LT8ueqp8pTwZmyGD9mGWjX5DLEF7FcbrGLj1y1N1/AolR+sBPyIB/iGB97Ps
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:26a5:cdb5:356c:64a4])
 (user=irogers job=sendgmr) by 2002:a05:690c:11:b0:6ea:6872:2fe6 with SMTP id
 00721157ae682-6ea68723031mr1053497b3.4.1730566449489; Sat, 02 Nov 2024
 09:54:09 -0700 (PDT)
Date: Sat,  2 Nov 2024 09:53:54 -0700
Message-Id: <20241102165400.75785-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Subject: [PATCH v2 0/6] Avoid parsing tracepoint format just for id
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

v2. Add additional error checking/handling in evsel__tp_format.

Ian Rogers (6):
  tool api fs: Correctly encode errno for read/write open failures
  perf trace-event: Constify print arguments
  perf trace-event: Always build trace-event-info.c
  perf evsel: Add/use accessor for tp_format
  perf evsel: Allow evsel__newtp without libtraceevent
  perf tests: Enable tests disabled due to tracepoint parsing

 tools/lib/api/fs/fs.c                         |   6 +-
 tools/perf/builtin-kmem.c                     |  15 ++-
 tools/perf/builtin-kwork.c                    |   3 +-
 tools/perf/builtin-record.c                   |   2 -
 tools/perf/builtin-script.c                   |   9 +-
 tools/perf/builtin-trace.c                    |  80 +++++++++----
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
 tools/perf/util/trace-event-parse.c           |   4 +-
 tools/perf/util/trace-event-scripting.c       |  10 +-
 tools/perf/util/trace-event.h                 |   4 +-
 23 files changed, 219 insertions(+), 149 deletions(-)

-- 
2.47.0.199.ga7371fff76-goog


