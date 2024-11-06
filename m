Return-Path: <linux-kernel+bounces-399062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C389BFA59
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 00:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB24B1F22B79
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 23:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1FD1DE8A6;
	Wed,  6 Nov 2024 23:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b="MWfoRhFh"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108231D966A
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 23:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730936730; cv=none; b=fB3Z74iQktriBVAGzswwQKXKJqmdSxMBT6mCRgvaBJXAKOAtJGnpR5wyfXNT/E6N1wDkEpsB4seRbR76HqOAnavsHtyNVxG6mCMp1+lGxpOCdwHaxYM3dNWSezKoDvQQDz1R23/weqjB1sQwiPa7vpnim2fml83wzK/RJT4U10k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730936730; c=relaxed/simple;
	bh=Qfirc4O31/ZM0gFfIfa1xSrbiS63G6QjT5cC1qr0Dto=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RzTTiJD09e4TY1o/VO9s3Jt4B/HJUZcNCfEs5P1t6LCgo1LSpiIEiGmutgLIbhbyG+9NheDqLKVe839UFqo0Uk/2dBY6aIJ6v1LWkRtEeOoHt+2yZ2b3nKYO7jZ/1ztu38y8wKpzwJVyAu722u4iSJPnLcc9JaO1x4ltbv1753k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com; spf=pass smtp.mailfrom=engflow.com; dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b=MWfoRhFh; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engflow.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-83ab694ebe5so14192539f.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 15:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=engflow.com; s=google; t=1730936726; x=1731541526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ptJC94diYWOUdvMtH8z3GbtBqdTfvSWNLK4dH6tAaKg=;
        b=MWfoRhFhDpNqmQBQZsy3r4RJ70C6XYo0FdlhupqUINiaC5Ry+MiVXF6BhW/2aimp27
         Xaf8xjbEkl/XfOazdEa14laUvQ/JMBhlcwFAUQ2s+KRVr51A9OgYAIlxKxlB8UwSxGFP
         nzv3DCwhS1hONMvBJqfUTnSCyzpgSQY+YvgVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730936726; x=1731541526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ptJC94diYWOUdvMtH8z3GbtBqdTfvSWNLK4dH6tAaKg=;
        b=VdeR1MUD4dR91AXdev6DRvgIbd3FKFu27Q9QZVMfplekmbl2o9hLh09sSr/AoBJwxj
         +HmLqRJ4Wut5VQ87RCfKatWOr7FYQTMwVh2pPIO0c0jmruUJgljJXA0KIZzLLeXB5u6+
         FfkeM4zjy//oW/Vmhqixixrxr0gSgaTlwJr6dShy8vECJ68bCe8rGbq6KkOeGy8781FR
         2Fo7LjMLznkt5oFlcHwz42QioUPAzFbt22JDDV7bwiKTi4L2fAzb4x+sB5O81QrccjkU
         DYHpFhUWQICkscwjuB4c0vz2XH544NXl80BejhFS7qA5NHpumLNSvNIUi7bAuouPDhbI
         bKbg==
X-Forwarded-Encrypted: i=1; AJvYcCX3Qh7pRwQrB1vYgz55If6g2GK95GhUhGJHKClQ0XcbcfEoQ/IR40KfQJj1U/7hbvYnsmMmxL4dJ3g2PSM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkx8Q1P7Qzgs55a1+0/d73tBZWhNJXTZmjM/fTkk8pQgIXh84Z
	iw9kXWwx6UETowLsaqc7gBHfesnqzYgTJRlIBJq4xitFxh2imOSjOWJHCUPpoJ8=
X-Google-Smtp-Source: AGHT+IH5eRb7TmUcP7kRbCY2LBcoVcAb3ol/Ro6z2gFuEKQC361+qx8U8LRIAjY3kCj2oElyLAjt9w==
X-Received: by 2002:a92:cdac:0:b0:3a2:6cd7:3250 with SMTP id e9e14a558f8ab-3a4ed29dcdemr417202125ab.10.1730936725982;
        Wed, 06 Nov 2024 15:45:25 -0800 (PST)
Received: from benjamin-test-build-vm.us-central1-b.c.engflow-remote-execution.internal (209.179.154.104.bc.googleusercontent.com. [104.154.179.209])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a6eac8c5c0sm127745ab.6.2024.11.06.15.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 15:45:25 -0800 (PST)
From: Benjamin Peterson <benjamin@engflow.com>
To: 
Cc: Benjamin Peterson <benjamin@engflow.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Subject: [PATCH 1/2] perf trace: do not lose last events in a race
Date: Wed,  6 Nov 2024 23:45:17 +0000
Message-Id: <20241106234518.115234-1-benjamin@engflow.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a perf trace event selector specifies a maximum number of events to output
(i.e., "/nr=N/" syntax), the event printing handler, trace__event_handler,
disables the event selector after the maximum number events are
printed. Furthermore, trace__event_handler checked if the event selector was
disabled before doing any work. This avoided exceeding the maximum number of
events to print if more events were in the buffer before the selector was
disabled. However, the event selector can be disabled for reasons other than
exceeding the maximum number of events. In particular, when the traced
subprocess exits, the main loop disables all event selectors. This meant the
last events of a traced subprocess might be lost to the printing handler's
short-circuiting logic.

This nondeterministic problem could be seen by running the following many times:

  $ perf trace -e syscalls:sys_enter_exit_group true

trace__event_handler should simply check for exceeding the maximum number of
events to print rather than the state of the event selector.

Fixes: a9c5e6c1e9bff ("perf trace: Introduce per-event maximum number of events property")
Signed-off-by: Benjamin Peterson <benjamin@engflow.com>
---
 tools/perf/builtin-trace.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d3f11b90d025..f6179b13b8b4 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3096,13 +3096,8 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 {
 	struct thread *thread;
 	int callchain_ret = 0;
-	/*
-	 * Check if we called perf_evsel__disable(evsel) due to, for instance,
-	 * this event's max_events having been hit and this is an entry coming
-	 * from the ring buffer that we should discard, since the max events
-	 * have already been considered/printed.
-	 */
-	if (evsel->disabled)
+
+	if (evsel->nr_events_printed >= evsel->max_events)
 		return 0;
 
 	thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
-- 
2.39.5


