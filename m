Return-Path: <linux-kernel+bounces-422834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D439D9ED1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 22:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87BFD282AA5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 21:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45271DFD9F;
	Tue, 26 Nov 2024 21:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TTSmoWcC"
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D12E1DF96E
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 21:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732656183; cv=none; b=OPyjejyKBdRnZV/mvW//OmxORgkr1FDu54JQh6GupSJjKT+S/1ZX4d/UvylhoWoeIcAH1VxQ4S9pIOkD0N9WdLXLCKh5LINt/jRtlnV2fDTaiPxC3UYqrx03AEPbbnSBa5mFm84AX6sxhij7PnUzVAIZcAIkJNGKFhkBtoTrVag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732656183; c=relaxed/simple;
	bh=uWfG3aFd9L7KcN8o/2ryZod93n0xGj+0UAobnfXWQok=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tPEPRwUJmH/8fJx+el0xX+sdXr2TSoOSAQm6QCVyMLvNEArVz8BgDLz03v241PtNe/ovX4Rbf1Z5AuIzJ3Gbn8PV+H5ji3mkWLpMZV7vqkvwKsajXY4OJMMg8SlR90Cc/p02uodOQliRmPgzVbMAtqsMdWGUzgzRQz+eanmjvf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TTSmoWcC; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-2973ff5c7e5so3336115fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 13:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732656181; x=1733260981; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4CyA4dAp81BoyY8Q+pL46oKmUutuArwSzQiAf9JnH7U=;
        b=TTSmoWcCpLJaU+jj4Z6YJYrWBRg67SNpJrhAjk1CpJ5DKrAM844e1WcvZCou4AhiQ3
         zWstzE+3O8+1hU7RBtpwaXfwQleWgp7M4X4Ti0h33ioYEbpUzd6x8BSb3Q/dpT5R3C/s
         8tabRzRNP4OvpksiBvxy87fEOWyf22FYLZkrfCJRlq7HzQbK6C7ZDtpEsOOGeOxaudAL
         F15Y9YNRv63DnEckvptiXNeBsqQXoLAg4Lh93bR2QgoC3fAfd0LUT7g18ehWTU4D3KYx
         vqZELjFXnVFx4bq/7Py0uBP69OkkowMASCm2/Xmf9DkFLZOkgtM+WkJcBsx6F4k6cZI9
         5tNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732656181; x=1733260981;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4CyA4dAp81BoyY8Q+pL46oKmUutuArwSzQiAf9JnH7U=;
        b=aveVC/isu/xUfAStwZzzQ7aXTqGmusUxPGmaK32ycSCp0Kq9ey+1BUqVXLPJ5r9mvg
         2GgUFiDVnSgWM8IHQxTUXZ89KVGlH5G5jjRPCjyKLueMtVmTbxaGbm84lAReMtHq1JtR
         5+0pBxHf1Mq7E7e0ZbyZ6sCZKXc2gRhmvvyRlaw23DK/TsJt3huTszYMgVijqfW5dzKj
         fQWl+Yo2IzBVFw58sWQautm2EOqoN/+DvD3eWrKOG5K4J6fFJp4hxjAhCFVh/qq1vf3T
         /vVRTydETDbUnQb66wotPAO3QrwBN0fX1OkSZK8HMtrsHG6qbiSiWIPF1Pa+70RV6O/k
         hVHw==
X-Gm-Message-State: AOJu0YzzLjn6UgKw8l9ntCFLxCQrqygt7J6IAzCiy3nMy4zjUuBXfh++
	RnB6HaixHs+9gzRtNMJFV9UFQIcFJZzONT23FZq+aOm2Mh7K+ubwn5T6XyUXsqnzVNk3JnZpL7t
	Y9OJTUATG7pRAsbCPSyCkbXFfBJZPUIQpK/6jPbhE/W5m9Fwzp0Sl/SsU/KZxyIy4D4Stku4Us7
	1jtIZgD+DK+FKaETtDiDWZqhg12TmTsK9BAEPTLDGA
X-Google-Smtp-Source: AGHT+IEpSyqe3GdnLFU3135TtDqH0ZaMLDEV7pZ3XE/nL53nO8kfwk/awIzeHTAYxt60d4LnAGsOHkC+5n4=
X-Received: from oabwd3.prod.google.com ([2002:a05:6871:a583:b0:296:7f65:cd4f])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:658b:b0:25e:d90:fe70
 with SMTP id 586e51a60fabf-29dc44d0c38mr391293fac.43.1732656180729; Tue, 26
 Nov 2024 13:23:00 -0800 (PST)
Date: Tue, 26 Nov 2024 13:22:54 -0800
In-Reply-To: <20241126212255.3793822-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241126212255.3793822-1-ctshao@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241126212255.3793822-2-ctshao@google.com>
Subject: [PATCH v3 2/2] perf lock: Fix parse_lock_type which only retrieve one
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
 tools/perf/builtin-lock.c | 68 ++++++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 23 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index c528aff1c9d5..c1870c287580 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1622,19 +1622,6 @@ static const char *get_type_lock_name(unsigned int flags)
 	return "unknown";
 }
 
-static unsigned int get_type_flag(const char *str)
-{
-	for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
-		if (!strcmp(lock_type_table[i].flags_name, str))
-			return lock_type_table[i].flags;
-	}
-	for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
-		if (!strcmp(lock_type_table[i].lock_name, str))
-			return lock_type_table[i].flags;
-	}
-	return UINT_MAX;
-}
-
 static void lock_filter_finish(void)
 {
 	zfree(&filters.types);
@@ -2356,29 +2343,64 @@ static int parse_lock_type(const struct option *opt __maybe_unused, const char *
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
+		/* `tok` is a flags name if it contains ':'. */
+		if (strchr(tok, ':')) {
+			for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
+				if (!strcmp(lock_type_table[i].flags_name, tok) &&
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
+		 * Otherwise `tok` is a lock name.
+		 * Single lock name could contain multiple flags.
+		 */
+		/*
+		 * By documentation, `percpu-rwmem` should be `pcpu-sem`.
+		 * For backward compatibility, we replace `pcpu-sem` with `percpu-rwmem`.
+		 */
+		if (!strcmp(tok, "pcpu-sem"))
+			tok = (char *)"percpu-rwsem";
+
+		for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
+			if (!strcmp(lock_type_table[i].lock_name, tok)) {
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
+			pr_err("Unknown lock name: %s\n", tok);
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
2.47.0.338.g60cca15819-goog


