Return-Path: <linux-kernel+bounces-440241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 553C49EBAA1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B219418867F2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 20:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28BF226884;
	Tue, 10 Dec 2024 20:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FbmL74Ns"
Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B663A153BF6
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 20:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733861342; cv=none; b=JTkTNJ+ZTPma/IiybDIzJj8adyFzwUl6bQu9TSELW7K3o9ciF+ucWd4CCXH9BDYhxlomXAFaYjC2kKugbHOSeh9EIITWhLaXw2X4fjMwlTEzGi3iV7mXkStF6v5Y+RtS/qTq4ksaHt+s/bSFFq5yrdGZO1OFJhazXsa57eKCuHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733861342; c=relaxed/simple;
	bh=twvGOqulnTZXTTOc/6wVLy2ytKDqD5qh/d0+OigPSPw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PUc3Ophy/SXEJTkYBL8yKfgOtQSxBxIazpMJRvOHMWdAne98Yqc7dmSNJMLSCgByQsLBGvbJCUDr2808ZHAtidhP72vAjpfg9H6wcSH8BB+GiJfZw/atW+ujyG0rj+T4+uG042Ve5v2orhRwn8AtyAUNdbDsxV2Tow0XU7SBHYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FbmL74Ns; arc=none smtp.client-ip=209.85.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-oo1-f73.google.com with SMTP id 006d021491bc7-5f2d927fe56so218410eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 12:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733861340; x=1734466140; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EhOjN52ZY8AkC8vGjiEI2+Z+fDENHCEMRgbgi5dltm0=;
        b=FbmL74NsZzFTpOmmIpyOAwJqdWxGct07GKKHwJaASS2MV9s9WMOnfXxxDnsC2lIrQz
         /llHlIIp5AtpmVwR/9LutdXz8M0Ik1kvga5d92VhbrfufSRA6sS8Qq+kqLfVEuhxaFEf
         STk5SaH9CpK3X/9y8t70PIJj3hgETROm98kRfAiDEb8rDCaZtxWkCN4U26wWoyVZObTR
         oRL4UXbdkuka8KNpeYtIi03jCRdMaOl1FXR0mNJ6zykO9ot1IufXzSh0ZmJNpiVCy/w0
         k6ECKvfbxNZQf9u0S9QHheRjwJSXKTx5GFc4iIM7bZ3WS4fCN98fIsAxeVJGAUlaNhF9
         EyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733861340; x=1734466140;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EhOjN52ZY8AkC8vGjiEI2+Z+fDENHCEMRgbgi5dltm0=;
        b=lxdg2vUq4Y8BH9I6+JY7b1TX21WhMGT9rLPAqzHdXvBHR2oo47PTQQfGN59dUXBDEm
         dtEzJKofSWOgRvL9BOsX5ikBonRgCUimUYuCopfW0sDMyi2hJbktnf9uU+KTz2i9BZ4B
         gQTSUWV35kqaHyH8P9pqkUTlml65qZp18u+ad4LDSLmB5RSKEzEg4luvYQUJx2bF5V30
         N/FGs4D17MbPiEY2MoOMQkcjOEyLhxkhXO8NlKS6H6CHe9GBQrZ1xNvkJpp1ss4XXN1D
         Y01wcwt1r+KnfV8cvDIU2eRLYDih7p/qsiH1cGIpZaGBtMhE8Jg56gcM9wKze3+1Mua+
         tt4Q==
X-Gm-Message-State: AOJu0Yx8nSgRndqpTyaalgnuTdvaOQ+k8tzZiP3mgPJJjrm359o4DN1m
	4XnMFP8Uy6xiyx4ixU/UEW5QCi+KiyoOqUdOngItKFNsD3or2r9MP3Z8YcTNB5b3i6OqsWYE2ex
	z7lviATRltbNE4UUmlN71RfkdGjYHFULsTIET0K2TIxKjzwAL6SdzaWCrt76Lr0o8McwG0G5grt
	PyfNdI/Ndo5VEh1SsYGTOK1afi5UwXZlrOyIPcGC8Q
X-Google-Smtp-Source: AGHT+IEzcGfBRAjDKfJ7YuO9iodMgvfYUhXkpH/odofCwurA8CzyEDmjQZfxj0xf6jTICeNt+QiwYr8iwTA=
X-Received: from oabqt5.prod.google.com ([2002:a05:6870:6e05:b0:296:e8a8:44e])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:64aa:b0:2a0:d2d:e60a
 with SMTP id 586e51a60fabf-2a012e62e82mr210744fac.43.1733861339689; Tue, 10
 Dec 2024 12:08:59 -0800 (PST)
Date: Tue, 10 Dec 2024 12:08:20 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.545.g3c1d2e2a6a-goog
Message-ID: <20241210200847.1023139-1-ctshao@google.com>
Subject: [PATCH v5 1/3] perf lock: Fix parse_lock_type which only retrieve one
 lock flag
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, nick.forrington@arm.com, 
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
2.47.1.545.g3c1d2e2a6a-goog


