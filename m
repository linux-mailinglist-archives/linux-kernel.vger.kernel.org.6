Return-Path: <linux-kernel+bounces-554949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BCEA5A3B8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E87DD3AD9CD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 19:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675A723535F;
	Mon, 10 Mar 2025 19:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eQpaMRWJ"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8E521422E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 19:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741634642; cv=none; b=VX8sG4zRbigb3LTDt9IlfGcLW15gQ4FFb5E16WUNjGE73bxpoRrmpnhu3nmPVji+fk9vOBAjwahPCxAYntKXWc1sQk0+91W9QKZq3OVB3WmEDpNHnZNZvO4y+HBVYBAyvgvfANO6I9hd670+bPYkW4/zGwppe4rB4Sdqlm37FG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741634642; c=relaxed/simple;
	bh=IBF/Hw53mk/kxLoojQzHTGPDpYoSnM0LJgRfCo+CXxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LI7L7pKmBofdiXej+568Qk1MsIi/gssBazaYQhGihWgL22haocDZwsgbmcH0g1c48BhucpaUtuuv87P2Z8X6aqMgPAx6hwaqDBFOuDx70aYTb3KEaMctF+jLAxV77J36i3dBTvngRdhjINuqCblydfZJi0qLPoDdcVSm4ZRVsis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eQpaMRWJ; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741634628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rXMAaVXrQ0MJdauHGwB3sTIki68VqN7FkX+wHWA/QGE=;
	b=eQpaMRWJdqK5ySjcyDP+SLpV1lXS11PaIH3FnlTh4oxD0DVUY75Lun3XLlM/taAhwReIDB
	JRVotSfoCiV0MZRnLcMnOQFd0hOoLxxlTMYQV0kA7vhfn9qfiyuSnCO5M86kAtdt4EFKqn
	CWoZYANnYOy8nEZQICYkEwBjzTOSy0M=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf/core: Remove size arguments when calling strscpy()
Date: Mon, 10 Mar 2025 20:23:35 +0100
Message-ID: <20250310192336.442994-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The size parameter is optional and strscpy() automatically determines
the length of the destination buffer using sizeof() if the argument is
omitted. This makes the explicit sizeof() calls unnecessary.

Furthermore, KSYM_NAME_LEN is equal to sizeof(name) and can also be
removed. Remove them to shorten and simplify the code.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 kernel/events/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 823aa0824916..e4b071fc7d74 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8589,7 +8589,7 @@ static void perf_event_comm_event(struct perf_comm_event *comm_event)
 	unsigned int size;
 
 	memset(comm, 0, sizeof(comm));
-	strscpy(comm, comm_event->task->comm, sizeof(comm));
+	strscpy(comm, comm_event->task->comm);
 	size = ALIGN(strlen(comm)+1, sizeof(u64));
 
 	comm_event->comm = comm;
@@ -9033,7 +9033,7 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
 	}
 
 cpy_name:
-	strscpy(tmp, name, sizeof(tmp));
+	strscpy(tmp, name);
 	name = tmp;
 got_name:
 	/*
@@ -9457,7 +9457,7 @@ void perf_event_ksymbol(u16 ksym_type, u64 addr, u32 len, bool unregister,
 	    ksym_type == PERF_RECORD_KSYMBOL_TYPE_UNKNOWN)
 		goto err;
 
-	strscpy(name, sym, KSYM_NAME_LEN);
+	strscpy(name, sym);
 	name_len = strlen(name) + 1;
 	while (!IS_ALIGNED(name_len, sizeof(u64)))
 		name[name_len++] = '\0';
-- 
2.48.1


