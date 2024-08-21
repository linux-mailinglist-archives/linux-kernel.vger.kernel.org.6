Return-Path: <linux-kernel+bounces-295620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F952959F26
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08295285053
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A9B1AF4EB;
	Wed, 21 Aug 2024 13:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NBhOTTpv"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457AA1AF4DB
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 13:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724248752; cv=none; b=oHPm0UIkPUV2Qczuu8PF5wZs0Ky0ccaqTiHh3+bTV6XvflJGQXvIEhsN44y2e75t0Xth95p8sVS61Dbqhc3TQjXJ0+XLy+3xew4bSvVZ6esgJcdH5q1ciaB+AQJZ1gsWRbvh9HKJbeRDyj30vBbZvrFWrNkuz6wD1TPZV2yzmEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724248752; c=relaxed/simple;
	bh=zeizrbF/CHjk9md3lAN+tHn47fwNQrqsBlcGHJzY2IU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AkFXTqB7lwdA0gt2f8AXePEcSvVrE5lzn5noTssddQR4yUP6N+mSzMfZye/uNV3T5pMmfD/TSfzA5mSOQ9plRHYVSJXwYHkpN+2qlWmOIAZq8yO4ozFuMPXo7ywaL8AHnRZMnN5tZoZC97rkVgT/GRUlnJ6bt1X/kUiOZB8eq8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NBhOTTpv; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-713edc53429so2911798b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 06:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724248748; x=1724853548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PBNbK64yzw2AyxYJHrrGwvvkQjpZCMsEQ2kCuZ1Ggdo=;
        b=NBhOTTpvkmn/+jqtHclsxX/+9siDdXs6h2N8WmMCxbeau1kJlK/D7AM104YX1R4aVf
         sqM/bUdzhluHin2V3QMJyxio6k/XwnB9GAz9TGbnvBuoNdW3C3B4/Iy0yzkH6ZRa8JAz
         tmKv1tVO0M3LpTb17NLb9ONnXWSfohOVX73zeCkIsugE4b/oQmenZwuBJITE8waScXWO
         0WM/YqZlFn/OMNe1rIsJnOf4yuFxhhIj1zDAsOzvx6BgB3sXY13bDJdGyV99EbLnvGW+
         GJNt7DfpD7aFUraQEMdXi9Dpy7Fx/6VIU0HEPmZf+atZldu7sK6Pb3w9sZ/ua2dAYJjb
         nHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724248748; x=1724853548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PBNbK64yzw2AyxYJHrrGwvvkQjpZCMsEQ2kCuZ1Ggdo=;
        b=H4GZ9rIj1qem5wLMG1f8+T1Wza+bhJpNMYIzSfzvGkdyi6h01C9xc7ksL7OThEq6P3
         luPCh0u+a67k6GL/Tt/diQK/EkWGgeEeSXOKguLI8v0f6LEeHOOr1emMR2hL2n8BSjel
         /i2kUGfJtjeUYs8VHjcvprU1WEgMSX8WI+ULsB019Zjzcze+dfiHEUUYl6EOnhZUx+OW
         7QsilboyzXS0CY5jS9yu8yVvkEZo/C5lyJI9pjY6IJ7ViZOjEaX2bHawCyC1fEeKcmoB
         hM4aoeJNTD2gC/CN9m/Wpea4twZb+tKBVKGU+HcU0qCKf9QDaeUvtv4XuAN5splcw0wX
         AhaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXesPRbDBDcebxlPIeQooGfScJZmt1vyUCmMiRSBZj05R8DxApUnRlS4XR56WjEqEqxvAwTgzN0kI6JHhU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+eUcsuC/Pf3n6N+jd5ZvmFmW9oiDZXDsJPhjXU32f4rK/3KlN
	sNTOfMEEd5QNevag7lag+E5UHaSbn89VD81n4lTT1xdzSqGNsROFBXd0SIixYHUio3MRfzYQUPp
	RuyA=
X-Google-Smtp-Source: AGHT+IHPZWlsmkTynTb1Cgw8cjJEiAv/gBW203w4nuwmcuaOPH0VfGgeCzR1bzfoJE+xvuEiHkRTOA==
X-Received: by 2002:a05:6a00:2345:b0:70d:244b:cad9 with SMTP id d2e1a72fcca58-714235bc40emr2890345b3a.28.1724248748180;
        Wed, 21 Aug 2024 06:59:08 -0700 (PDT)
Received: from n37-034-248.byted.org ([180.184.49.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b61c6730sm11185445a12.26.2024.08.21.06.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 06:59:07 -0700 (PDT)
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
To: mhocko@suse.com,
	akpm@linux-foundation.org,
	mgorman@techsingularity.net,
	hannes@cmpxchg.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	lizefan.x@bytedance.com,
	Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: [PATCH] mm:page_alloc: fix the NULL ac->nodemask in __alloc_pages_slowpath()
Date: Wed, 21 Aug 2024 21:59:00 +0800
Message-Id: <20240821135900.2199983-1-hezhongkun.hzk@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I found a problem in my test machine that should_reclaim_retry() do
not get the right node if i set the cpuset.mems

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

Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
---
 mm/page_alloc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 29608ca294cf..5ea63bb8f8ff 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4338,6 +4338,9 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 		ac->nodemask = NULL;
 		ac->preferred_zoneref = first_zones_zonelist(ac->zonelist,
 					ac->highest_zoneidx, ac->nodemask);
+	} else if (in_task() && !ac->nodemask) {
+		/* Set the nodemask if the request comes from user space. */
+		ac->nodemask = &cpuset_current_mems_allowed;
 	}
 
 	/* Attempt with potentially adjusted zonelist and alloc_flags */
-- 
2.20.1


