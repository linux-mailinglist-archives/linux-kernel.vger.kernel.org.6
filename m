Return-Path: <linux-kernel+bounces-397163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CE59BD790
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C4A31F21C7D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB00A2161F3;
	Tue,  5 Nov 2024 21:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZGA4u84S"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6BA1E0B65
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730842022; cv=none; b=gEtFgYLQXQso4kCXUyxBcxYGShI7OmMxqttl9MECx9+htLUZ3pkiVPyR8LP++ucvId2r5Tt14BrGmfm4sfX6VyHXduwJ+z/3zxGW7I7ref7kfKZVLIhl2/kl8oDDct/I1WjpvXFkWRCLsp/Y1GX+yYdq7D7OP72MYnSxW3vN2dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730842022; c=relaxed/simple;
	bh=HS+/C0e0hpeLfwzCJv/WkWcH4j9dAH0Yg5tqwK/5gPU=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=V2JO35larYHzXpNmseLxjGweFRVFNuQ4d9ZVTtwBINPP6+CSlQa9BQ9wuQIIQDWOdrlgN7qLYYrB5GiNFszUyGs12q+K/MpomKYVO1o8IcBpwlaJF69avrGImdYtljiVhRiJH4MvEQSSs41l1pOhaDhIjVTpedaea+/y26CBtM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZGA4u84S; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea95f530fdso48283197b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 13:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730842020; x=1731446820; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yEmXLOQoeDgbB8Nzdb0EfC34B2gegQNp6g6GHNUgKDM=;
        b=ZGA4u84SXIfLJpYwuF2LASa3niVioxosoiwUM3xa6u4DI/jYHOpAkH/kfU9qDdd8fe
         L54M3PpeuVzHb0tnmVYYlUSy0JHVxprfT8pQOJjUEpHwpefl3CgUY1iNOfkY4orfWR5F
         b9IeLSIX6wUczXpZk3xVO+GCaZOVo1QpgxrXlKxNTKkqnabkw7XTLyKJg2m5WD4OiqYn
         1270siKoJqDuBungx+Q/9qKbnBi2B7pTgHkLGgwCWg+BM49MSDcunLwA9ZQuSedlIX6r
         UXPhPa8yuvsclZljb9RjjtV8mVuzS6Yy3yoXIknjjgmUVW8r8sJkAaH7k3V0O2dg6TXh
         k8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730842020; x=1731446820;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yEmXLOQoeDgbB8Nzdb0EfC34B2gegQNp6g6GHNUgKDM=;
        b=bl9/Gw7UogfMbURM83+7/wKGCnGTffdrQhY2hYlugWn6hUmInMp9OgFKvxHvoTB54c
         xFA702vufH04rSYF6R2/ojwqxbYoj6NmXBhq3+LtntobBANCli15XS0Y21qL2cjNW1s4
         g+xVBz0AIhRJkaz7AnP+KKFfRZEFzU/ELc+9PfEbqMgTn3nzguiwpU6ydzf/uBrT3lUu
         k+WF/lybwQpgtYseLGw4BnROoNjlhvVySoyDtW0bJYLDNJhTBenQCPIahi0L1zoffLzD
         SZ1w9yCuwKI5xqLIImxtO/ogYCVZ2apG8Etzk3WcJu3L1AAMRFu9sMdzFOFXfe+5Z7oZ
         69rQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVkZEydrLZKyQ0CUDOEiqP3dHmdtbBHomfSkqOYz2spErifNtJLmzhYQWcYu+963JjtnvCn8OZYZnZT30=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiSY6EmNPIR7yiqtBLLG6AfzP6FUrNEG9ZeTRVCXipfm6pw9gc
	UWVYvS20RJqWvCTxBYXQzQpj3RL6usM1QuZTvc9kp1bZUS7ypwpg4HZYaYePe3ilQzGt4ahjUm7
	MHxf69g==
X-Google-Smtp-Source: AGHT+IFyefUnXR7fmFIzAhayc6jLgdUhzGuPxNKLUajAPJaO+D+RRXPI25jmigj2QGfwRBN3wwxQksywcvRV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ff9e:ab12:75ac:c1a0])
 (user=irogers job=sendgmr) by 2002:a05:690c:11:b0:6ea:6872:2fe6 with SMTP id
 00721157ae682-6ea68723031mr3708907b3.4.1730842019826; Tue, 05 Nov 2024
 13:26:59 -0800 (PST)
Date: Tue,  5 Nov 2024 13:26:46 -0800
Message-Id: <20241105212652.401943-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Subject: [PATCH v3 0/6] Avoid parsing tracepoint format just for id
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
 tools/perf/util/trace-event-parse.c           |   4 +-
 tools/perf/util/trace-event-scripting.c       |  10 +-
 tools/perf/util/trace-event.h                 |   4 +-
 23 files changed, 216 insertions(+), 148 deletions(-)

-- 
2.47.0.199.ga7371fff76-goog


