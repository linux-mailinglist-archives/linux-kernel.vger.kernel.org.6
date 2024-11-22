Return-Path: <linux-kernel+bounces-417617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3A69D56B7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 01:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08156B214BF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 00:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5214A01;
	Fri, 22 Nov 2024 00:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x2efRDO1"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4AE4C81
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 00:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732235289; cv=none; b=jIb4+BjSjqMgY6KTrm/ezPCukEKOQk+v48LN7kmM/tND8IXE6Iqnu3kX3C0nuJ9OMLBSVf5unB2P2BWB4fkcRwXxQeitdOdqJwV7FJqkTKCANbqWpqT5yifnG1hi3j9F7klraa6pUHwA44tDLHi0A0gxG0QiMrufG2PsMW7rckE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732235289; c=relaxed/simple;
	bh=zMhLyZx+mtTkqtuZadZoWyisQmR9t6afNXF76z0ekao=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=m1YpDINI9w/uLbJOikfiPqPKUx6w8pstFoe9Lef7ssDc8RtgTO36CBVWF/X5y4z9RL4QPg7Cr7YX87+b5g9X3/H+wcj9WcQrTLJjLtGH42fTmFbDOm9ho//70dN0Ox03v0bjuXnJ59czvv9lyGKraSJVnP6mzRO4TOVHDhlb36o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x2efRDO1; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ee57ae0f61so26038597b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 16:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732235285; x=1732840085; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8LNcJTSYVLQsLtynLEviRGy6UyHb/naX0FxpgaYIjfA=;
        b=x2efRDO1nrCVOLP7DvoGA5vdJRdAXnIxXf8OWSakPOwFZuhcpGo/JTEPHa7+H03bnd
         K8oV23jc4oPu3JwXxlHOQjEhSV4pZW823MGLrz3zFN1D7q8Hm/pyrMkBbNiTOxHbA7rC
         Tber5kVOHfZpT3I8mcI325UqPl6xh9XwnyVeAr20BmcB5VheVsuGFd/EwQ78QIGA4JHL
         4UOSM93LjZHMOp8/uHWAMtDFgJYcFV0J0XYwhuHMYvKUP0dgyxCa7R9ryAMd5wXGAH7C
         Hv0n9nZfiaq9QvEDKR3kL1XFCW5qj5hWRQz972nNrFmQoQ4TWZiBSGMjoHcvcRs/wd/L
         Lq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732235285; x=1732840085;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8LNcJTSYVLQsLtynLEviRGy6UyHb/naX0FxpgaYIjfA=;
        b=hkNhpcMErbaEx/6dFpK/NOfzgPTUYSpawBTksZgMIAKpce2I0Tcb8KqMypd2TkAwI7
         +1QGB6vhHcDFH1OaddRMDMKWNzPpgSe+p5Bxh/tGIngwEzB/DUpbFAqCwkWwj1aZVcMI
         Zz5nYuH7FFW0EPOfggex1hcTibgYrjWRgGpQ2LnO0MQLxWG5VlnsD1FC98YVpoKHokOw
         prw5H6h/DTs0tm9sRmNt+CkDDD+PJaIWh0mek02kuCI/tx6xUqOG9KgGj3iTdKtWC7rV
         VCumOvdhUFLYIc8p5yrpuY2Cd98Fs6lwj0MXpIW39rkAN3M2lxG9Ncd/QRGE47ROaiv8
         qADQ==
X-Gm-Message-State: AOJu0Ywt3YyviryLYKG8oC2s1h1o4LWGQoznfVkvOlg8QkCHofjCjyX2
	vlBluB8v5hMjtDsfnQvthMcRIlG3yc4BorZEIDcaepYhcLDo49OIcfgy2af3mm2ISsntz/kXja7
	c36znOkH0UGlJgzmQgghWlZ0nSWT5IbrpkiCn71k+YNfgkAjbf/A7jMlFhmrXwyBmDHwJL1AAlq
	kMTf/jGGcKK/CUw6qIs/PzB7hv8mfw0zcOj3ka67q4
X-Google-Smtp-Source: AGHT+IHm3c1TNBTr85Nfnq50tkAnVfISvwMop8xRIx2vJkApWPeD4l59UoYnr61V1OMDFb9YL5bl5KWn9W8=
X-Received: from colette.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:ce7])
 (user=ctshao job=sendgmr) by 2002:a05:690c:2b11:b0:6e3:b08:92c7 with SMTP id
 00721157ae682-6eee0779e90mr8197b3.0.1732235284448; Thu, 21 Nov 2024 16:28:04
 -0800 (PST)
Date: Fri, 22 Nov 2024 00:27:51 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241122002752.4179915-1-ctshao@google.com>
Subject: [PATCH v2] perf lock: Fix parse_lock_type which only retrieve one
 lock flag
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

`parse_lock_type` can only add the first lock flag in `lock_type_table`
given input `str`. For example, for `Y rwlock`, it only adds `rwlock:R`
into this perf session. Another example is for `-Y mutex`, it only adds
the mutex without `LCB_F_SPIN` flag. The patch fixes this issue, makes
sure both `rwlock:R` and `rwlock:W` will be added with `-Y rwlock`, and
so on.

Testing:
  $ ./perf lock con -ab -Y mutex,rwlock -- perf bench sched pipe
  # Running 'sched/pipe' benchmark:
  # Executed 1000000 pipe operations between two processes

       Total time: 8.425 [sec]

         8.425402 usecs/op
           118688 ops/sec
   contended   total wait     max wait     avg wait         type   caller

         194      1.68 ms     44.16 us      8.66 us        mutex   pipe_read+0x57
          10    423.03 us     44.27 us     42.30 us     rwlock:W   do_exit+0x365
          54    254.67 us     58.87 us      4.72 us        mutex   pipe_write+0x50
          21    146.64 us     11.54 us      6.98 us        mutex   pipe_read+0x282
          10    141.27 us     20.62 us     14.13 us     rwlock:W   release_task+0x6f
           5     58.92 us     16.37 us     11.78 us        mutex   do_epoll_wait+0x24d
           3     29.81 us     17.66 us      9.94 us        mutex   do_epoll_ctl+0x6c1
           4     26.82 us     11.02 us      6.70 us        mutex   do_epoll_wait+0x24d
           2     18.32 us     12.49 us      9.16 us     rwlock:W   do_epoll_wait+0x255
           1     11.34 us     11.34 us     11.34 us     rwlock:W   ep_done_scan+0x2d
           1     11.02 us     11.02 us     11.02 us     rwlock:R   mm_update_next_owner+0x4e
           1     10.60 us     10.60 us     10.60 us     rwlock:W   do_epoll_ctl+0xb65
           1      9.90 us      9.90 us      9.90 us     rwlock:W   do_exit+0x365

Fixes: d783ea8f62c4 ("perf lock contention: Simplify parse_lock_type()")
Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/builtin-lock.c | 93 ++++++++++++++++++++++++++-------------
 1 file changed, 62 insertions(+), 31 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 062e2b56a2ab..052dbf423efd 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -15,6 +15,7 @@
 #include "util/lock-contention.h"
 #include "util/bpf_skel/lock_data.h"
 
+#include <string.h>
 #include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
 #include "util/trace-event.h"
@@ -1575,8 +1576,13 @@ static void sort_result(void)
 
 static const struct {
 	unsigned int flags;
-	const char *str;
+	/* Name of the lock. */
 	const char *name;
+	/*
+	 * Name of the group this lock belongs to.
+	 * For example, both rwlock:R and rwlock:W belong to rwlock.
+	 */
+	const char *group;
 } lock_type_table[] = {
 	{ 0,				"semaphore",	"semaphore" },
 	{ LCB_F_SPIN,			"spinlock",	"spinlock" },
@@ -1591,42 +1597,38 @@ static const struct {
 	{ LCB_F_PERCPU | LCB_F_WRITE,	"pcpu-sem:W",	"percpu-rwsem" },
 	{ LCB_F_MUTEX,			"mutex",	"mutex" },
 	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex",	"mutex" },
-	/* alias for get_type_flag() */
-	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex-spin",	"mutex" },
 };
 
-static const char *get_type_str(unsigned int flags)
+static const char *get_type_name(unsigned int flags)
 {
 	flags &= LCB_F_MAX_FLAGS - 1;
 
 	for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
 		if (lock_type_table[i].flags == flags)
-			return lock_type_table[i].str;
+			return lock_type_table[i].name;
 	}
 	return "unknown";
 }
 
-static const char *get_type_name(unsigned int flags)
+static const char *get_type_group(unsigned int flags)
 {
 	flags &= LCB_F_MAX_FLAGS - 1;
 
 	for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
 		if (lock_type_table[i].flags == flags)
-			return lock_type_table[i].name;
+			return lock_type_table[i].group;
 	}
 	return "unknown";
 }
 
-static unsigned int get_type_flag(const char *str)
+static unsigned int get_type_flags_by_name(const char *name)
 {
 	for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
-		if (!strcmp(lock_type_table[i].name, str))
-			return lock_type_table[i].flags;
-	}
-	for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
-		if (!strcmp(lock_type_table[i].str, str))
+		if (!strcmp(lock_type_table[i].name, name))
 			return lock_type_table[i].flags;
 	}
+
+	pr_err("Unknown lock flags: %s\n", name);
 	return UINT_MAX;
 }
 
@@ -1732,7 +1734,8 @@ static void print_lock_stat_stdio(struct lock_contention *con, struct lock_stat
 
 	switch (aggr_mode) {
 	case LOCK_AGGR_CALLER:
-		fprintf(lock_output, "  %10s   %s\n", get_type_str(st->flags), st->name);
+		fprintf(lock_output, "  %10s   %s\n",
+			get_type_name(st->flags), st->name);
 		break;
 	case LOCK_AGGR_TASK:
 		pid = st->addr;
@@ -1742,7 +1745,7 @@ static void print_lock_stat_stdio(struct lock_contention *con, struct lock_stat
 		break;
 	case LOCK_AGGR_ADDR:
 		fprintf(lock_output, "  %016llx   %s (%s)\n", (unsigned long long)st->addr,
-			st->name, get_type_name(st->flags));
+			st->name, get_type_group(st->flags));
 		break;
 	case LOCK_AGGR_CGROUP:
 		fprintf(lock_output, "  %s\n", st->name);
@@ -1783,7 +1786,8 @@ static void print_lock_stat_csv(struct lock_contention *con, struct lock_stat *s
 
 	switch (aggr_mode) {
 	case LOCK_AGGR_CALLER:
-		fprintf(lock_output, "%s%s %s", get_type_str(st->flags), sep, st->name);
+		fprintf(lock_output, "%s%s %s",
+			get_type_name(st->flags), sep, st->name);
 		if (verbose <= 0)
 			fprintf(lock_output, "\n");
 		break;
@@ -1795,7 +1799,7 @@ static void print_lock_stat_csv(struct lock_contention *con, struct lock_stat *s
 		break;
 	case LOCK_AGGR_ADDR:
 		fprintf(lock_output, "%llx%s %s%s %s\n", (unsigned long long)st->addr, sep,
-			st->name, sep, get_type_name(st->flags));
+			st->name, sep, get_type_group(st->flags));
 		break;
 	case LOCK_AGGR_CGROUP:
 		fprintf(lock_output, "%s\n",st->name);
@@ -2338,41 +2342,68 @@ static bool add_lock_type(unsigned int flags)
 	unsigned int *tmp;
 
 	tmp = realloc(filters.types, (filters.nr_types + 1) * sizeof(*filters.types));
-	if (tmp == NULL)
+	if (tmp == NULL) {
+		pr_err("Failed to add lock flags: %u\n", flags);
 		return false;
+	}
 
 	tmp[filters.nr_types++] = flags;
 	filters.types = tmp;
 	return true;
 }
 
-static int parse_lock_type(const struct option *opt __maybe_unused, const char *str,
-			   int unset __maybe_unused)
+static int parse_lock_type(const struct option *opt __maybe_unused,
+			   const char *str, int unset __maybe_unused)
 {
 	char *s, *tmp, *tok;
-	int ret = 0;
 
 	s = strdup(str);
 	if (s == NULL)
 		return -1;
 
-	for (tok = strtok_r(s, ", ", &tmp); tok; tok = strtok_r(NULL, ", ", &tmp)) {
-		unsigned int flags = get_type_flag(tok);
+	for (tok = strtok_r(s, ", ", &tmp); tok;
+	     tok = strtok_r(NULL, ", ", &tmp)) {
+		bool found = false;
 
-		if (flags == -1U) {
-			pr_err("Unknown lock flags: %s\n", tok);
-			ret = -1;
-			break;
+		/* `tok` is a lock name if it contains ':'. */
+		if (strchr(tok, ':')) {
+			unsigned int flags = get_type_flags_by_name(tok);
+
+			if (flags == UINT_MAX || !add_lock_type(flags)) {
+				free(s);
+				return -1;
+			}
+			continue;
 		}
 
-		if (!add_lock_type(flags)) {
-			ret = -1;
-			break;
+		/* Otherwise look up flags by lock group */
+		/*
+		 * By documentation, `percpu-rwmem` should be `pcpu-sem`.
+		 * For backward compatibility, we replace pcpu-sem with percpu-rwmem.
+		 */
+		if (!strcmp(tok, "pcpu-sem"))
+			tok = (char *)"percpu-rwsem";
+
+		for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
+			if (!strcmp(lock_type_table[i].group, tok)) {
+				if (add_lock_type(lock_type_table[i].flags)) {
+					found = true;
+				} else {
+					free(s);
+					return -1;
+				}
+			}
+		}
+
+		if (!found) {
+			pr_err("Unknown lock flags: %s\n", tok);
+			free(s);
+			return -1;
 		}
 	}
 
 	free(s);
-	return ret;
+	return 0;
 }
 
 static bool add_lock_addr(unsigned long addr)
-- 
2.47.0.371.ga323438b13-goog


