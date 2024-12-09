Return-Path: <linux-kernel+bounces-438342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B36139E9FF2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 21:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6157165837
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 20:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3B6198A11;
	Mon,  9 Dec 2024 20:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s5eq7ulT"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7659618CC15
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 20:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733774468; cv=none; b=OpBmyn3VYfan5Woj1iWVL0BYZN3g2X+MUooOlS08Nm4YW3roNRbz/VPRa17JA02qG4NG4Kyp5CpVrOCFysi0vhwKU7FWtGi6x6+WXEc6zLRWGk3ksFJUK3musK4tXc2X/RhXC6O4ChzQG+VtWo+6AI5TXKbzwrG7w+4lNl9oDUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733774468; c=relaxed/simple;
	bh=BaaZxujHgG2t7evwB5rcD5JUaUCQqf9yUP7/6Hi+Q3U=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jDbmOlCkDfuBrtGKBxs1oCLvCZS7VSBtMSMDfO6FI2/rMst+CMbPUrJkvR3qHbW52AZmY98qmj70p2OTeni8ZDgWYlCAtYOvylZfTciSJbEVzyWp49QNeOfGa/utouzfuw0GeNpL+S7s0hattEIVqvxvHdrtUTOk1+2vzcR2tjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s5eq7ulT; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ef728e36d5so3116888a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 12:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733774467; x=1734379267; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UEctiwolqpRNFt6r2cG+m/ALbcflvyW8CFZ6ABOg1Hc=;
        b=s5eq7ulTLxqbYqnDxAc0EJ7hhjl+LhkhcCzMNc2McdKFDQZHtCZYx9svEuP0qMIJ2Q
         fr6gOzU4O4nTez/vekGg9NgvtdxkcYS81RMTAMZ24EFUTDwVyAFca/dXjTGjxmL81Kl6
         5ZGKPsrgEinnEd+5h4ZASy4qJ7tSdoMtiBOJ3pO2ct4sqg5jkTa97aHYj4zQ9qUF6/Hj
         8Sd/wMHdyh236gH6yAI/Ue1Iws0dm834P4O/FacUL2cL1VTb//X/i3zMo64EYNkKPc+O
         i/jxxySn3lvnqPAEmcq+ztEwCvhO7httWhLG2gryhk1NQePkXAXDEq/u7ftpRPuC77h6
         V23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733774467; x=1734379267;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UEctiwolqpRNFt6r2cG+m/ALbcflvyW8CFZ6ABOg1Hc=;
        b=XsRL8ChjR6exrSYCRx8F5P121mohuaESQnLLLisbz3hRuXxT91WBJv0cjotTJFB4gK
         WyMRal+ckagPdIO4ot3PEEuLny/M203C3r70Wh2TYXUQf4AIqx9LevVBe0u2qdcxIH0U
         u/amiQorwFZVk+ik9XAKh7AP4Z+tq22D4cOziZHFYdhcyOj83db+CUHhDuYLYbk9DIE0
         SOl7ouWhQNsH74bH3M/VkXNEJaeWTr7TOPiGjjkWeYMxcr0qIrdHkzdDFuyZ3CwZYPPp
         SV784t3u5+V9buIKy+De5e3ZjwLceb4mba1+lcPfLgtfas2UNm+bAuwXBTq9DjsMZhIQ
         SPfg==
X-Gm-Message-State: AOJu0YymQbG+I0VKoklAXA3cli2xHBRWk6yfyDWXCXUfbOBFWez28eHe
	23zfRaYBICMpbS9SlXCfEMUbbLYo6A9AKfZs5j7VLiVZRKcV1CSQvCBk0JhXXQ5Fn2ACVVTdSq1
	3KZtFG7SL0nDdPviUV7/NNMnH3VyAfR4Go12dy10lJk2V8opPdgI09t+FrwzEw7oMiKiE2hCGy7
	wof/Txhg0YJY5PQIY7DDZcKLjJt5hG144OCYxJXEKl
X-Google-Smtp-Source: AGHT+IHdLQYoqadK/lg7+ZfEvWTFu8V3oOEk4LhVn6dqYlJPQRozBI0ERYxSxCUL0KIQA3czUkz5x4aHcYo=
X-Received: from pjbqo11.prod.google.com ([2002:a17:90b:3dcb:b0:2e2:8d64:6213])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d88e:b0:2ea:61de:38f7
 with SMTP id 98e67ed59e1d1-2ef6ab0cf78mr19092102a91.29.1733774466684; Mon, 09
 Dec 2024 12:01:06 -0800 (PST)
Date: Mon,  9 Dec 2024 12:01:00 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241209200104.870531-1-ctshao@google.com>
Subject: [PATCH v4 1/3] perf lock: Fix parse_lock_type which only retrieve one
 lock flag
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org
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

       Total time: 9.313 [sec]

         9.313976 usecs/op
           107365 ops/sec
   contended   total wait     max wait     avg wait         type   caller

         176      1.65 ms     19.43 us      9.38 us        mutex   pipe_read+0x57
          34    180.14 us     10.93 us      5.30 us        mutex   pipe_write+0x50
           7     77.48 us     16.09 us     11.07 us        mutex   do_epoll_wait+0x24d
           7     74.70 us     13.50 us     10.67 us        mutex   do_epoll_wait+0x24d
           3     35.97 us     14.44 us     11.99 us     rwlock:W   ep_done_scan+0x2d
           3     35.00 us     12.23 us     11.66 us     rwlock:W   do_epoll_wait+0x255
           2     15.88 us     11.96 us      7.94 us     rwlock:W   do_epoll_wait+0x47c
           1     15.23 us     15.23 us     15.23 us     rwlock:W   do_epoll_wait+0x4d0
           1     14.26 us     14.26 us     14.26 us     rwlock:W   ep_done_scan+0x2d
           2     14.00 us      7.99 us      7.00 us        mutex   pipe_read+0x282
           1     12.29 us     12.29 us     12.29 us     rwlock:R   ep_poll_callback+0x35
           1     12.02 us     12.02 us     12.02 us     rwlock:W   do_epoll_ctl+0xb65
           1     10.25 us     10.25 us     10.25 us     rwlock:R   ep_poll_callback+0x35
           1      7.86 us      7.86 us      7.86 us        mutex   do_epoll_ctl+0x6c1
           1      5.04 us      5.04 us      5.04 us        mutex   do_epoll_ctl+0x3d4

Fixes: d783ea8f62c4 ("perf lock contention: Simplify parse_lock_type()")
Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/builtin-lock.c | 64 ++++++++++++++++++++++++---------------
 1 file changed, 39 insertions(+), 25 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 062e2b56a2ab..7e36bbe3cb80 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1591,8 +1591,6 @@ static const struct {
 	{ LCB_F_PERCPU | LCB_F_WRITE,	"pcpu-sem:W",	"percpu-rwsem" },
 	{ LCB_F_MUTEX,			"mutex",	"mutex" },
 	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex",	"mutex" },
-	/* alias for get_type_flag() */
-	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex-spin",	"mutex" },
 };
 
 static const char *get_type_str(unsigned int flags)
@@ -1617,19 +1615,6 @@ static const char *get_type_name(unsigned int flags)
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
@@ -2350,29 +2335,58 @@ static int parse_lock_type(const struct option *opt __maybe_unused, const char *
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
+		/* `tok` is `str` in `lock_type_table` if it contains ':'. */
+		if (strchr(tok, ':')) {
+			for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
+				if (!strcmp(lock_type_table[i].str, tok) &&
+				    add_lock_type(lock_type_table[i].flags)) {
+					found = true;
+					break;
+				}
+			}
+
+			if (!found) {
+				pr_err("Unknown lock flags name: %s\n", tok);
+				free(s);
+				return -1;
+			}
+
+			continue;
 		}
 
-		if (!add_lock_type(flags)) {
-			ret = -1;
-			break;
+		/*
+		 * Otherwise `tok` is `name` in `lock_type_table`.
+		 * Single lock name could contain multiple flags.
+		 */
+		for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
+			if (!strcmp(lock_type_table[i].name, tok)) {
+				if (add_lock_type(lock_type_table[i].flags)) {
+					found = true;
+				} else {
+					free(s);
+					return -1;
+				}
+			}
 		}
+
+		if (!found) {
+			pr_err("Unknown lock name: %s\n", tok);
+			free(s);
+			return -1;
+		}
+
 	}
 
 	free(s);
-	return ret;
+	return 0;
 }
 
 static bool add_lock_addr(unsigned long addr)
-- 
2.47.0.338.g60cca15819-goog


