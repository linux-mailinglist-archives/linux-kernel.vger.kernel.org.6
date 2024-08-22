Return-Path: <linux-kernel+bounces-296925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E08B095B0AA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DA221C21F9E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2186B16D4EF;
	Thu, 22 Aug 2024 08:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="S/wkCrD0"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AAB1802E
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 08:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724315935; cv=none; b=YxDJZG0NLfCF+85YkIAMD+5ihfoz3VN9y8l+/Ykpir1Oi+d1/0AqvP/peJWacagTpa/28gAEnDvlcp0xVaj88xtxpVwmjCk0IChHWOxUUfAw3Iw0qgaJIbcAaYtcBaP5LU8pVD03bDssGCvvNiSW9wiqG9rNaEuqXCldUlczAIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724315935; c=relaxed/simple;
	bh=g63rxuMJg0My3XKsPFmskBD2F9Wgzjk54qZBlYYQwbc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xx3o9fQ9xyNUWIbMpJlfd+sbsjyHWypWluGzNs317riWBhG6X4xgH1ysHArt+wvJo95+14xjJqOWkq/QN37xI1P+xLtIKBtQrle6YHLPjih3LZbrYn5bJYHvpniYG82gnQ/JGPVCT6qZTKjxQAsm2YmetqpjPULTCDN5b+jjLA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=S/wkCrD0; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-201fbd0d7c2so5290435ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 01:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724315932; x=1724920732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b2u1WsAxt5JgAdG/+BbrIkNxjYeux2TdSi6nksps3OA=;
        b=S/wkCrD0vsNcQsN1GTgwsplRIeLDHlBqPOLyb/3jOOI1CH1M6c2lrSho8tBIkc3zD+
         ydqEXNnReLFCgkV7vx5hOGxXmZcdTEJwRSeo2tx/cKEiR+1zCGR2+4Qs2miJfGAoiPZt
         SZ4E8MSuYFDWRx4Gd3oSeIPt5VQfI0ABJUqzWUVQBDsjRPcxNx5aMwyy8uMfa87GXfbd
         9Hs5pkeU1gC2zT9qqklb7eImGjGKyofX4C/QYsjekZXdi4ro+DuT93z3aTnBnA8PSnNl
         JWSChLrDnowOgUYqpM8SVVOC3TL09uySPXOfDf70YdoHkOde6MkM+TZ3B9JsZekIjQVq
         a0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724315932; x=1724920732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b2u1WsAxt5JgAdG/+BbrIkNxjYeux2TdSi6nksps3OA=;
        b=oNUEp92q1B54SPc8bXCWEkf59oSxEfhG7ViAuq3NkJrXjclD4H9TkZU0mOvzAjWxn1
         faiE7nm+lel5b2+sj/YPc0caltEbP2uVcHW+wRW1uzpqIVPdnT5okFzYMnQbMCnAnZxw
         Go36IoE2GY3q/qepzQTVbHVVDKkgUcfbxxrwjW7Xn7NaMHu+wUhATvIJ6e9fU1tkNKD+
         qf751w0LjE3ohnZz6pzHnGNIDCALsj1lrMEvbB+T3oez34mycm153StVU+EEkxvSTIGB
         bQFeZBBInbecYt3o1S1N4fsEMQJY/D6QVmA9GqZPOYkUzOtSlIwOeIpviZe3MBhJ+5/i
         lkdw==
X-Forwarded-Encrypted: i=1; AJvYcCXODyjSw/CBzirPB5OrGiBbM08IyMAHeZt9cDzdtYY3IBCXsb3jZXLMcb+Z7CRBPTRWpCCB1Xr5ENhy3EI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu6SD4n6aTTw14f0HMq4SSS4NMyud9Eocs3OxzcGkE1Fv5Ig8m
	rSF2QERhI+VZEF90SkWW8e1j4lFUXYl9+10Vdpg3hzeMpLzRqY4Qh+XNVAKOadlXwj8xLomFemw
	U
X-Google-Smtp-Source: AGHT+IE6zPuDFiYPZ9j6ugZo61SY5bpPFGgMRvk+dLzDnZlHpisUHQTef0KsNQ2Vz/xKZ70B17VEWA==
X-Received: by 2002:a17:902:da8f:b0:1fd:8c25:415d with SMTP id d9443c01a7336-20367f6ad3bmr63104275ad.36.1724315932202;
        Thu, 22 Aug 2024 01:38:52 -0700 (PDT)
Received: from n37-034-248.byted.org ([180.184.51.142])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855816dcsm7870835ad.112.2024.08.22.01.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 01:38:51 -0700 (PDT)
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
To: mhocko@suse.com,
	akpm@linux-foundation.org,
	mgorman@techsingularity.net,
	hannes@cmpxchg.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	lizefan.x@bytedance.com,
	Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: [PATCH V1] mm:page_alloc: fix the NULL ac->nodemask in __alloc_pages_slowpath()
Date: Thu, 22 Aug 2024 16:38:42 +0800
Message-Id: <20240822083842.3167137-1-hezhongkun.hzk@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I found a problem in my test machine that should_reclaim_retry() do
not get the right node if i set the cpuset.mems.
The should_reclaim_retry() and try_to_compact_pages() are iterating
nodes which are not allowed by cpusets and that makes the retry loop
happening more than unnecessary.

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

3. Root cause:
Nodemask usually comes from mempolicy in policy_nodemask(), which
is always NULL unless the memory policy is bind or prefer_many.

nodemask = NULL
__alloc_pages_noprof()
	prepare_alloc_pages
		ac->nodemask = &cpuset_current_mems_allowed;

	get_page_from_freelist()

	ac.nodemask = nodemask;  /*set  NULL*/

	__alloc_pages_slowpath() {
		f (!(alloc_flags & ALLOC_CPUSET) || reserve_flags) {
			ac->nodemask = NULL;
			ac->preferred_zoneref = first_zones_zonelist(ac->zonelist,
					ac->highest_zoneidx, ac->nodemask);

		/* so ac.nodemask = NULL */
	}

According to the function flow above, we do not have the memory limit to
follow cpuset.mems, so we need to add it.

Test result:
Try 3 times with different cpuset.mems and alloc large memorys than that numa size.
echo 1 > cpuset.mems
stress --vm 1 --vm-bytes 12g --vm-hang 0
---------------
echo 2 > cpuset.mems
stress --vm 1 --vm-bytes 12g --vm-hang 0
---------------
echo 3 > cpuset.mems
stress --vm 1 --vm-bytes 12g --vm-hang 0

The retry trace look like:
stress-2139    [003] .....   666.934104: reclaim_retry_zone: node=1 zone=Normal   order=0 reclaimable=7 available=7355 min_wmark=8598 no_progress_loops=1 wmark_check=0
stress-2204    [010] .....   695.447393: reclaim_retry_zone: node=2 zone=Normal   order=0 reclaimable=2 available=6916 min_wmark=8598 no_progress_loops=1 wmark_check=0
stress-2271    [008] .....   725.683058: reclaim_retry_zone: node=3 zone=Normal   order=0 reclaimable=17 available=8079 min_wmark=8597 no_progress_loops=1 wmark_check=0

With this patch, we can check the right node and get less retry in __alloc_pages_slowpath()
because there is nothing to do.

V1:
Do the same with the page allocator using __cpuset_zone_allowed().

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
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


