Return-Path: <linux-kernel+bounces-296988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB9295B19C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 11:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 920152889D0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4D817C200;
	Thu, 22 Aug 2024 09:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="D55dLQxN"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6701C6B5
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 09:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318785; cv=none; b=qZYa5XpK5ZBXe+D2GG1UeBNc5SnnLWLO8hYvosus9FAzM00Spzr845SG52JWET4F4hQXrY/UUHK1HqS0w4+MjnR/IB/vQeDXtHzLwUZOG9zFG1uh8HFs6mrVqcLJiOlVt8+Vf6bS+mkU5lncm6EaAXLShAZC+U1ZjAnHJxffJQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318785; c=relaxed/simple;
	bh=iNvJ6NoGb03q2tohIEwkpHzAqfRUD478Ag/SAcTKQm8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SmsAvxhpIFFXoJyc0d/yESAUd36GYBeOmU8RwaMGyfpNW6JWZtm6Qli7njqYCvN6VcmfBiz6ZJmrSY4gG4lEmqw8e1lwqsMl4OJEimU+KrMzBVIV7xTIRTuZt63XNBkKqhMmMnnQNeHMxQ4xxY8rCVbcr+W/CkMnRHkxObRRkiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=D55dLQxN; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2020e83eca1so5368135ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 02:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724318783; x=1724923583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6tV3CpXt11rxuxZrwX2AsLM/b/1GlsNsyqohk3M36MI=;
        b=D55dLQxNabfMo1OJwcaBFIwoc0zEJ0VnjbcRq3LMogttB6j30kEdcUGdQxO1R9xfeL
         zVPUyILDSmHLBBbDrWVJS3Z7uyl/AuG1lCXE6Lk8R8BziDsLeE1657frfBJj3lQctjnD
         FcmYHb1BEv13PYFjAKO20KUcXWx7dKqZQOJ7dB2qgpFQPEV1k9LSa4qv2Mv0qoznx3aE
         +fHiuZjJ0sKXuA3ar2PrKCVjvx74AMZXHfXCk9i3jRU93P1HwVSR1UW8O66Ql8PHWbpE
         vEu7YMC4bSvEUvaWJCetYLB7qfhyJIhU7sI+u/If3iNVflbfq88sPCzaDTp+ifrPp2gO
         /a6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724318783; x=1724923583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6tV3CpXt11rxuxZrwX2AsLM/b/1GlsNsyqohk3M36MI=;
        b=vT+3+Qu3DgNGZEV5epPnSsbRr1+C6MG54ozSUX9xzKw4CjmUw55EXx7qfsuW2gNL2g
         K3zVqlnkzc+D4MKrG0s28gt6K4VhVA0djlbWfRJ3BzjnbQyjR6tFRwV3oEILn5fqvxJr
         7i4bLoXRG+M6onraedbPHDnh3V6gyefZytpjlgbSfOBaQi9SRi/Q6FwWzRU4EaxGE3rT
         OChltezomALGqapo1ay4FK5ioTrPEPgn+TGoofuB+ZjO6hKp2PlqLUJTmvVZGyV3TJgI
         XlkJxX8dmjRZ9glVWvsLm4pZ9+/QD0MIzEZD/ZWp4/EO4pktiPlig+lmC6p9SpRUwUMh
         X/Dg==
X-Forwarded-Encrypted: i=1; AJvYcCXzUTk+FvyHDlawbogIHlwm9FLe8YToUnevjdF10ZZyaaFsqP8u2gIL2j5vbrA6C/ynEFGSkr9mZULpaBs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfjs1+D9YqWVQDPpIg3nAxV3JROOhfOTmVwe+xgvv+o47nuVLD
	RwY0sk9ur+tXLeqLhGyUcr61Vp3j+j7VjRayX5LreJcqbIpqp7ffAY+P5BNaoubrfXAZV3Vz8Wk
	0
X-Google-Smtp-Source: AGHT+IFclbOnIf5t4k+B3Gvk8Ug1CthBuKsUttj0Qqpm5pJy7vSzne7jNHZ+r+QdUmOxSUBo2q/1xw==
X-Received: by 2002:a17:903:2305:b0:1fd:64ef:da17 with SMTP id d9443c01a7336-203681e3d04mr55001925ad.41.1724318783045;
        Thu, 22 Aug 2024 02:26:23 -0700 (PDT)
Received: from n37-034-248.byted.org ([180.184.84.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038560902fsm8594505ad.189.2024.08.22.02.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 02:26:22 -0700 (PDT)
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
To: mhocko@suse.com,
	akpm@linux-foundation.org,
	mgorman@techsingularity.net,
	hannes@cmpxchg.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	lizefan.x@bytedance.com,
	Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: [PATCH V2] mm:page_alloc: fix the NULL ac->nodemask in __alloc_pages_slowpath()
Date: Thu, 22 Aug 2024 17:26:12 +0800
Message-Id: <20240822092612.3209286-1-hezhongkun.hzk@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

should_reclaim_retry() is not ALLOC_CPUSET aware and that means that it
considers reclaimability of NUMA nodes which are outside of the cpuset.
If other nodes have a lot of reclaimable memory then should_reclaim_retry
would instruct page allocator to retry even though there is no memory
reclaimable on the cpuset nodemask. This is not really a huge problem
because the number of retries without any reclaim progress is bound but
it could be certainly improved. This is a cold path so this shouldn't
really have a measurable impact on performance on most workloads.

1.Test step and the machines.
------------
root@vm:/sys/fs/cgroup/test# numactl -H | grep size
node 0 size: 9477 MB
node 1 size: 10079 MB
node 2 size: 10079 MB
node 3 size: 10078 MB

root@vm:/sys/fs/cgroup/test# cat cpuset.mems
    2

root@vm:/sys/fs/cgroup/test# stress --vm 1 --vm-bytes 12g  --vm-keep
stress: info: [33430] dispatching hogs: 0 cpu, 0 io, 1 vm, 0 hdd
stress: FAIL: [33430] (425) <-- worker 33431 got signal 9
stress: WARN: [33430] (427) now reaping child worker processes
stress: FAIL: [33430] (461) failed run completed in 2s

2. reclaim_retry_zone info:

We can only alloc pages from node=2, but the reclaim_retry_zone is
node=0 and return true.

root@vm:/sys/kernel/debug/tracing# cat trace
stress-33431   [001] ..... 13223.617311: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=1 wmark_check=1
stress-33431   [001] ..... 13223.617682: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=2 wmark_check=1
stress-33431   [001] ..... 13223.618103: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=3 wmark_check=1
stress-33431   [001] ..... 13223.618454: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=4 wmark_check=1
stress-33431   [001] ..... 13223.618770: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=5 wmark_check=1
stress-33431   [001] ..... 13223.619150: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=6 wmark_check=1
stress-33431   [001] ..... 13223.619510: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=7 wmark_check=1
stress-33431   [001] ..... 13223.619850: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=8 wmark_check=1
stress-33431   [001] ..... 13223.620171: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=9 wmark_check=1
stress-33431   [001] ..... 13223.620533: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=10 wmark_check=1
stress-33431   [001] ..... 13223.620894: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=11 wmark_check=1
stress-33431   [001] ..... 13223.621224: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=12 wmark_check=1
stress-33431   [001] ..... 13223.621551: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=13 wmark_check=1
stress-33431   [001] ..... 13223.621847: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=14 wmark_check=1
stress-33431   [001] ..... 13223.622200: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=15 wmark_check=1
stress-33431   [001] ..... 13223.622580: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=16 wmark_check=1

With this patch, we can check the right node and get less retry in __alloc_pages_slowpath()
because there is nothing to do.

V1:
    Do the same with the page allocator using __cpuset_zone_allowed(). --from Michal
V2:
    Update the problem description.  --from Michal

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/compaction.c | 6 ++++++
 mm/page_alloc.c | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/mm/compaction.c b/mm/compaction.c
index d1041fbce679..a2b16b08cbbf 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -23,6 +23,7 @@
 #include <linux/freezer.h>
 #include <linux/page_owner.h>
 #include <linux/psi.h>
+#include <linux/cpuset.h>
 #include "internal.h"
 
 #ifdef CONFIG_COMPACTION
@@ -2822,6 +2823,11 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
 					ac->highest_zoneidx, ac->nodemask) {
 		enum compact_result status;
 
+		if (cpusets_enabled() &&
+			(alloc_flags & ALLOC_CPUSET) &&
+			!__cpuset_zone_allowed(zone, gfp_mask))
+				continue;
+
 		if (prio > MIN_COMPACT_PRIORITY
 					&& compaction_deferred(zone, order)) {
 			rc = max_t(enum compact_result, COMPACT_DEFERRED, rc);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 29608ca294cf..8a67d760b71a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4128,6 +4128,11 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 		unsigned long min_wmark = min_wmark_pages(zone);
 		bool wmark;
 
+		if (cpusets_enabled() &&
+			(alloc_flags & ALLOC_CPUSET) &&
+			!__cpuset_zone_allowed(zone, gfp_mask))
+				continue;
+
 		available = reclaimable = zone_reclaimable_pages(zone);
 		available += zone_page_state_snapshot(zone, NR_FREE_PAGES);
 
-- 
2.20.1


