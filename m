Return-Path: <linux-kernel+bounces-416565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 737819D46F0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 05:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA3D71F2217F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 04:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323E513BACC;
	Thu, 21 Nov 2024 04:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0dV0W+47"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05C0849C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 04:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732164360; cv=none; b=YfFoZKH/X23b9TutV0kkSj5E3QSKrUycE4B2oUl8Tu32JhAmy+E5jKagTVrLaBL8InyuUGtZPwHFbmLGKBIghIIOYddWmx6n0Kg3F0zn7EcQCpQnCzUYdPDTs2GhH4Pe9AZ/gMePHfTjTYkwz4Lxfz3vhEp8krooJKe1MTWaDYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732164360; c=relaxed/simple;
	bh=hnHlCPe3Ij38lk5LYTKDqGJdMedllOn0yNRtCNDzTBQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SrAEry5IFtKmYhNYbFLRHyTwpr9lHbLYDZz5rp0cGEJRmP486UZXdQR7u33MjMNvS7skPN0NXMl0qHg5J3vjf0L0RyyNmyWaAKBSZXQbBVSU4ZIPu67m/K3b1ejHmQY2dN5G+UFNrQcDZv6tBbI3sYP0HfReqsSfrzwyaXAShS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0dV0W+47; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e388c4bd92bso900632276.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 20:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732164357; x=1732769157; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Cogs2EVBRjzSDp3JU3Wnx8u85Le+bSEDTylLBOdqsAs=;
        b=0dV0W+47bLuloWN9b+2oRifdIiFbUPHnBPGznhVhERORCZXr6aPbMXqs0/cMxEHD9a
         zt7Rh3eooqqxM1361No6HI9UZfQBWSnEmeDFmjFRhS/eK5iFLy2mjylmn78iXvFsMLOu
         n3XGrr07loH9KcScSZER5Wg0vtCFBsY5Q9qr0tBlJ1SCMC7Neo19/CAvtN5aW4ubNYmY
         wYPDrq16VjJGUsFizzP1jCTB7HASqgouCMANSyYCIsEsdZCK1hJX+QukmMz/QBZlKWrP
         HTVg1wjzLBcd6dav1XTlNRI6cfO/WCNWxuH8V8xdvXa6Q9zsxF7JY8W9LW+YYGtwP/G1
         79xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732164357; x=1732769157;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cogs2EVBRjzSDp3JU3Wnx8u85Le+bSEDTylLBOdqsAs=;
        b=Y8kMc5o6vaHrFnniiqupBpFUdnD6rT2n+0C9uRdF2fc0aDLK9Ytf6eWDwzvMIDFsUZ
         DFTPYur1tMr7DXfw7X+hoJAPOnrIhxqxkb3UYvCpZ75NADDqhOf/I7iyMWLqpyLSZ0eN
         UFAYv8tvp3HHtBXVAWEwqvksFxM6y+sESEclr5vcn/gM8klOnYdINkN3+q1qaaV8TIII
         WrhefokZfn/LbGHLOTFlQMShx52O5A5IAGRTKdosUBeuwoLTAs/gEYXDxChQP7PppGsm
         m4/1KyRWTAUI8JVBDWy1aGYDD/Gp1VZBSmwDmMWLcK02/4rBV0gN6XkLj+Y7EXn+XQNf
         O3hw==
X-Gm-Message-State: AOJu0YyiHnBgevHAG/yVAgb3+Px5RSRpLhf+wyyMD3TS+5aqsUWhL4EA
	LGgdaLtM65MDf/chZF5i2P89mFYl6+84ihsI2xSYoji9YKVpF5u5xxcwzKhJ8WJ4U+H7z1kT7RM
	D/gyHMQJuG4Aws5+0rA60ddcSFZr+8HyMxdDSQu++azbAjn7/+e8wh45e36BhNW5QNGej/S16LG
	3p2tPPriR30bVS2+yP0QywxZKF9+BP2vJJBQxsDIRW
X-Google-Smtp-Source: AGHT+IGnJF4cN0dj9pPxA+mrV5LuwrOcTvLTa1lewlNwcQfsCne8aFrqZTs1F2CydhHeFYbHk8ScG30GXhg=
X-Received: from colette.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:ce7])
 (user=ctshao job=sendgmr) by 2002:a25:9c83:0:b0:e38:c40:380f with SMTP id
 3f1490d57ef6-e38cb55df95mr18587276.3.1732164356532; Wed, 20 Nov 2024 20:45:56
 -0800 (PST)
Date: Thu, 21 Nov 2024 04:45:51 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241121044551.3899270-1-ctshao@google.com>
Subject: [PATCH] perf lock: Fix parse_lock_type which only retrieve one lock flag
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"

`parse_lock_type` can only add the first lock flag in `lock_type_table`
given input `str`. For example, for `Y rwlock`, it only adds `rwlock:R`
into this perf session. Another example is for `-Y mutex`, it only adds
the mutex without `LCB_F_SPIN` flag. The patch fixes this issue, makes
sure both `rwlock:R` and `rwlock:W` will be added with `-Y rwlock`, and
so on.

Testing:
  $ ./perf lock con -ab -Y rwlock,mutex -- perf bench sched pipe
  # Running 'sched/pipe' benchmark:
  # Executed 1000000 pipe operations between two processes

       Total time: 7.870 [sec]

         7.870224 usecs/op
           127061 ops/sec
   contended   total wait     max wait     avg wait         type   caller

         122      1.01 ms     18.73 us      8.32 us        mutex   pipe_read+0x57
          33    149.06 us      8.88 us      4.52 us        mutex   pipe_write+0x50
           5     56.06 us     15.07 us     11.21 us        mutex   do_epoll_wait+0x24d
           2     26.43 us     14.62 us     13.22 us        mutex   do_epoll_wait+0x24d
           2     21.51 us     15.68 us     10.76 us        mutex   pipe_read+0x282
           2     20.57 us     10.74 us     10.29 us        mutex   do_epoll_ctl+0x3d4
           1      8.58 us      8.58 us      8.58 us     rwlock:W   do_epoll_wait+0x255
           1      8.38 us      8.38 us      8.38 us     rwlock:W   do_epoll_ctl+0xb65
           1      8.11 us      8.11 us      8.11 us     rwlock:R   ep_poll_callback+0x35
           1      5.49 us      5.49 us      5.49 us        mutex   do_epoll_ctl+0x6c1

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/builtin-lock.c | 118 +++++++++++++++++++++++---------------
 1 file changed, 71 insertions(+), 47 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 062e2b56a2ab..2692b8e9eb9a 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1575,61 +1575,57 @@ static void sort_result(void)
 
 static const struct {
 	unsigned int flags;
-	const char *str;
+	/* Name of the lock, it is unique and 1-1 mapping to flags */
 	const char *name;
+	/*
+	 * Name of the group this lock belongs to.
+	 * For example, both rwlock:R and rwlock:W belong to rwlock.
+	 * This is used for reverse parsing while user specify the group name (ex. mutex/rwlock),
+	 * And for symbol name in LOCK_AGGR_ADDR mode.
+	 */
+	const char *affiliated_group_name;
+	/*
+	 * This is used for caller type in LOCK_AGGR_CALLER mode.
+	 */
+	const char *caller_type;
 } lock_type_table[] = {
-	{ 0,				"semaphore",	"semaphore" },
-	{ LCB_F_SPIN,			"spinlock",	"spinlock" },
-	{ LCB_F_SPIN | LCB_F_READ,	"rwlock:R",	"rwlock" },
-	{ LCB_F_SPIN | LCB_F_WRITE,	"rwlock:W",	"rwlock" },
-	{ LCB_F_READ,			"rwsem:R",	"rwsem" },
-	{ LCB_F_WRITE,			"rwsem:W",	"rwsem" },
-	{ LCB_F_RT,			"rt-mutex",	"rt-mutex" },
-	{ LCB_F_RT | LCB_F_READ,	"rwlock-rt:R",	"rwlock-rt" },
-	{ LCB_F_RT | LCB_F_WRITE,	"rwlock-rt:W",	"rwlock-rt" },
-	{ LCB_F_PERCPU | LCB_F_READ,	"pcpu-sem:R",	"percpu-rwsem" },
-	{ LCB_F_PERCPU | LCB_F_WRITE,	"pcpu-sem:W",	"percpu-rwsem" },
-	{ LCB_F_MUTEX,			"mutex",	"mutex" },
-	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex",	"mutex" },
-	/* alias for get_type_flag() */
-	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex-spin",	"mutex" },
+	{ 0,				"semaphore",	"semaphore",	"semaphore" },
+	{ LCB_F_SPIN,			"spinlock",	"spinlock",	"spinlock" },
+	{ LCB_F_SPIN | LCB_F_READ,	"rwlock:R",	"rwlock",	"rwlock:R" },
+	{ LCB_F_SPIN | LCB_F_WRITE,	"rwlock:W",	"rwlock",	"rwlock:W" },
+	{ LCB_F_READ,			"rwsem:R",	"rwsem",	"rwsem:R" },
+	{ LCB_F_WRITE,			"rwsem:W",	"rwsem",	"rwsem:W" },
+	{ LCB_F_RT,			"rt-mutex",	"rt-mutex",	"rt-mutex" },
+	{ LCB_F_RT | LCB_F_READ,	"rwlock-rt:R",	"rwlock-rt",	"rwlock-rt:R" },
+	{ LCB_F_RT | LCB_F_WRITE,	"rwlock-rt:W",	"rwlock-rt",	"rwlock-rt:W" },
+	{ LCB_F_PERCPU | LCB_F_READ,	"pcpu-sem:R",	"percpu-rwsem",	"pcpu-sem:R" },
+	{ LCB_F_PERCPU | LCB_F_WRITE,	"pcpu-sem:W",	"percpu-rwsem",	"pcpu-sem:W" },
+	{ LCB_F_MUTEX,			"mutex-nospin",	"mutex",	"mutex" },
+	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex-spin",	"mutex",	"mutex" },
 };
 
-static const char *get_type_str(unsigned int flags)
+static const char *get_lock_caller_type(unsigned int flags)
 {
 	flags &= LCB_F_MAX_FLAGS - 1;
 
 	for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
 		if (lock_type_table[i].flags == flags)
-			return lock_type_table[i].str;
+			return lock_type_table[i].caller_type;
 	}
 	return "unknown";
 }
 
-static const char *get_type_name(unsigned int flags)
+static const char *get_lock_affiliated_group_name(unsigned int flags)
 {
 	flags &= LCB_F_MAX_FLAGS - 1;
 
 	for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
 		if (lock_type_table[i].flags == flags)
-			return lock_type_table[i].name;
+			return lock_type_table[i].affiliated_group_name;
 	}
 	return "unknown";
 }
 
-static unsigned int get_type_flag(const char *str)
-{
-	for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
-		if (!strcmp(lock_type_table[i].name, str))
-			return lock_type_table[i].flags;
-	}
-	for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
-		if (!strcmp(lock_type_table[i].str, str))
-			return lock_type_table[i].flags;
-	}
-	return UINT_MAX;
-}
-
 static void lock_filter_finish(void)
 {
 	zfree(&filters.types);
@@ -1732,7 +1728,8 @@ static void print_lock_stat_stdio(struct lock_contention *con, struct lock_stat
 
 	switch (aggr_mode) {
 	case LOCK_AGGR_CALLER:
-		fprintf(lock_output, "  %10s   %s\n", get_type_str(st->flags), st->name);
+		fprintf(lock_output, "  %10s   %s\n",
+			get_lock_caller_type(st->flags), st->name);
 		break;
 	case LOCK_AGGR_TASK:
 		pid = st->addr;
@@ -1742,7 +1739,7 @@ static void print_lock_stat_stdio(struct lock_contention *con, struct lock_stat
 		break;
 	case LOCK_AGGR_ADDR:
 		fprintf(lock_output, "  %016llx   %s (%s)\n", (unsigned long long)st->addr,
-			st->name, get_type_name(st->flags));
+			st->name, get_lock_affiliated_group_name(st->flags));
 		break;
 	case LOCK_AGGR_CGROUP:
 		fprintf(lock_output, "  %s\n", st->name);
@@ -1783,7 +1780,8 @@ static void print_lock_stat_csv(struct lock_contention *con, struct lock_stat *s
 
 	switch (aggr_mode) {
 	case LOCK_AGGR_CALLER:
-		fprintf(lock_output, "%s%s %s", get_type_str(st->flags), sep, st->name);
+		fprintf(lock_output, "%s%s %s",
+			get_lock_caller_type(st->flags), sep, st->name);
 		if (verbose <= 0)
 			fprintf(lock_output, "\n");
 		break;
@@ -1795,7 +1793,7 @@ static void print_lock_stat_csv(struct lock_contention *con, struct lock_stat *s
 		break;
 	case LOCK_AGGR_ADDR:
 		fprintf(lock_output, "%llx%s %s%s %s\n", (unsigned long long)st->addr, sep,
-			st->name, sep, get_type_name(st->flags));
+			st->name, sep, get_lock_affiliated_group_name(st->flags));
 		break;
 	case LOCK_AGGR_CGROUP:
 		fprintf(lock_output, "%s\n",st->name);
@@ -2333,6 +2331,7 @@ static int parse_max_stack(const struct option *opt, const char *str,
 	return 0;
 }
 
+
 static bool add_lock_type(unsigned int flags)
 {
 	unsigned int *tmp;
@@ -2350,29 +2349,54 @@ static int parse_lock_type(const struct option *opt __maybe_unused, const char *
 			   int unset __maybe_unused)
 {
 	char *s, *tmp, *tok;
-	int ret = 0;
 
 	s = strdup(str);
 	if (s == NULL)
 		return -1;
 
 	for (tok = strtok_r(s, ", ", &tmp); tok; tok = strtok_r(NULL, ", ", &tmp)) {
-		unsigned int flags = get_type_flag(tok);
+		bool found = false;
 
-		if (flags == -1U) {
-			pr_err("Unknown lock flags: %s\n", tok);
-			ret = -1;
-			break;
+		/* Traverse lock name first. */
+		for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
+			if (!strcmp(lock_type_table[i].name, tok)) {
+				if (add_lock_type(lock_type_table[i].flags)) {
+					found = true;
+					break;
+				}
+				pr_err("Failed to alloc lock: %s\n", tok);
+				free(s);
+				return -1;
+			}
 		}
+		if (found)
+			continue;
 
-		if (!add_lock_type(flags)) {
-			ret = -1;
-			break;
+		/*
+		 * If `tok` can not be found in lock name, look up the lock affiliated group
+		 * instead. A group would contain more than one lock flag.
+		 */
+		for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
+			if (!strcmp(lock_type_table[i].affiliated_group_name, tok)) {
+				if (add_lock_type(lock_type_table[i].flags)) {
+					found = true;
+				} else {
+					pr_err("Failed to alloc lock: %s\n", tok);
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


