Return-Path: <linux-kernel+bounces-526223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8ADA3FBB8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA4117EA0E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF42215162;
	Fri, 21 Feb 2025 16:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IQLwrJzQ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4D020DD6D
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 16:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740155791; cv=none; b=tV69oTkRhCf5CV/I+imcpUjVk9jaFNkphjtWnil7UXV7SrYp/VmvY6UOzNMR2QyBFJVdvGOSSeA4PQt+Jpz6Gr0mlRn15Bg5gkpzFDskSYTQPnqRAPcugRhc9H7KWoGPpELgPN11UvBseg/DO6sRgxSJXzhBnYa4oG3EooaCtDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740155791; c=relaxed/simple;
	bh=6MAplZUA3vCeXdXGwsVe15kAXbNY7+Ik7wAzmDEBwgo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rMWAfTw39M+H21HxugUTD3JbAEkpGVyKz/6X2gcczxzn3BA1ZOl3q7xoF7dXhWTlEy6hK/HdFFO4JPS6OUhujt39Xsj5N9cY0vsrunG6iwlenHLTQFxQbq7TsWx/T84uG4ovT0fVvf+65b71u1+zBLCheuSsHLvK73CiJtEEYcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IQLwrJzQ; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51L8fcY9018599;
	Fri, 21 Feb 2025 16:36:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=649omYDxNDHzRQG2ilV3tHLUDJcol
	gsRVCUcJB/s4q8=; b=IQLwrJzQSbzL+WTOsja4vo9vto1YsuCPSnYUTfxeR41ys
	IeMIMHJGyBlnCmdzdP2Y11XdC4a+mmQXkY4O5ZJEVIARTwGEDwIJBdiZ3ZL1D2IJ
	UJu9FHpcd0qHgC/VJbuIToXDEQxjcO+thbCDZLwav95UzIAzIUnt222SdAAmnymb
	tX4W7InBPXQulBl6MJEPQ8Ycoyv2rQl2CsOa0dTnMtoTDlcZsXY1q6q5N8moPT9w
	vuhtNulg0ZP+RWl2OCB1KkoIxsIoxdWO2LOK4Ayd2AdIACKJ3ePtfkOHaqonuvJc
	krgyLIhAYxayZ1dExzKTY/nMXcXbdT46DRlwGK3Bw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00npq56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 16:36:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51LG6DSI010612;
	Fri, 21 Feb 2025 16:36:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w07gxm6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 16:36:13 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51LGUIXB005786;
	Fri, 21 Feb 2025 16:36:13 GMT
Received: from sidhakum-ubuntu.osdevelopmeniad.oraclevcn.com (sidhakum-ubuntu.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.250.108])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 44w07gxm69-1;
	Fri, 21 Feb 2025 16:36:12 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        richard.weiyang@gmail.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 0/6] Track node vacancy to reduce worst case allocation counts
Date: Fri, 21 Feb 2025 16:36:04 +0000
Message-ID: <20250221163610.578409-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502210118
X-Proofpoint-GUID: x-qf010Q5Zo79Xi2hL3fMVdnP0oSjw9c
X-Proofpoint-ORIG-GUID: x-qf010Q5Zo79Xi2hL3fMVdnP0oSjw9c

v1[1] -> v2:
  - fix comment for vacant_height which refers to depth per Wei 

  - add a patch to reorder switch case statements in mas_prealloc_calc and
    mas_wr_store_entry

  - use sufficient height in spanning stores

  - modify patch 2 to use a counter to track ascending the tree rather
    than overloading mas->depth to have this function.

================ overview ========================
Currently, the maple tree preallocates the worst case number of nodes for
given store type by taking into account the whole height of the tree. This
comes from a worst case scenario of every node in the tree being full and
having to propagate node allocation upwards until we reach the root of the
tree. This can be optimized if there are vacancies in nodes that are at a
lower depth than the root node. This series implements tracking the level
at which there is a vacant node so we only need to allocate until this
level is reached, rather than always using the full height of the tree.
The ma_wr_state struct is modified to add a field which keeps track of the
vacant height and is updated during walks of the tree. This value is then
read in mas_prealloc_calc() when we decide how many nodes to allocate.

For rebalancing and spanning stores, we also need to track the lowest
height at which a node has 1 more entry than the minimum sufficient number
of entries. This is because rebalancing can cause a parent node to become
insufficient which results in further node allocations. In this case, we
need to use the sufficient height as the worst case rather than the vacant
height.

patch 1-2: preparatory patches
patch 3: implement vacant height tracking + update the tests
patch 4: support vacant height tracking for rebalacning writes
patch 5: implement sufficient height tracking
patch 6: reorder switch case statements

================ results =========================
Bpftrace was used to profile the allocation path for requesting new maple
nodes while running stress-ng mmap 120s. The histograms below represent
requests to kmem_cache_alloc_bulk() and show the count argument. This
represnts how many maple nodes the caller is requesting in
kmem_cache_alloc_bulk()

command: stress-ng --mmap 4 --timeout 120

mm-unstable 

@bulk_alloc_req:
[3, 4)                 4 |                                                    |
[4, 5)             54170 |@                                                   |
[5, 6)                 0 |                                                    |
[6, 7)            893057 |@@@@@@@@@@@@@@@@@@@@                                |
[7, 8)                 4 |                                                    |
[8, 9)           2230287 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[9, 10)            55811 |@                                                   |
[10, 11)           77834 |@                                                   |
[11, 12)               0 |                                                    |
[12, 13)         1368684 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                     |
[13, 14)               0 |                                                    |
[14, 15)               0 |                                                    |
[15, 16)          367197 |@@@@@@@@                                            |


@maple_node_total: 46,630,160
@total_vmas: 46184591

mm-unstable + this series

@bulk_alloc_req:
[2, 3)               198 |                                                    |
[3, 4)                 4 |                                                    |
[4, 5)                43 |                                                    |
[5, 6)                 0 |                                                    |
[6, 7)           1069503 |@@@@@@@@@@@@@@@@@@@@@                               |
[7, 8)                 4 |                                                    |
[8, 9)           2597268 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[9, 10)           472191 |@@@@@@@@@                                           |
[10, 11)          191904 |@@@                                                 |
[11, 12)               0 |                                                    |
[12, 13)          247316 |@@@@                                                |
[13, 14)               0 |                                                    |
[14, 15)               0 |                                                    |
[15, 16)           98769 |@                                                   |


@maple_node_total: 37,813,856
@total_vmas: 43493287

This represents a ~19% reduction in the number of bulk maple nodes allocated.

For more reproducible results, a historgram of the return value of
mas_prealloc_calc() is displayed while running the maple_tree_tests
whcih have a deterministic store pattern

mas_prealloc_calc() return value mm-unstable
1   :  							 (12068)
3   :  							 (11836)
5   : ***** 						 (271192)
7   : ************************************************** (2329329)
9   : *********** 					 (534186)
10  :  							 (435)
11  : *************** 					 (704306)
13  : ******** 						 (409781)

mas_prealloc_calc() return value mm-unstable + this series
1   : 							 (12070)
3   : ************************************************** (3548777)
5   : ********                                           (633458)
7   :  							 (65081)
9   :  							 (11224)
10  :  							 (341)
11  :  							 (2973)
13  :  							 (68)

do_mmap latency was also measured for regressions:
command: stress-ng --mmap 4 --timeout 120

mm-unstable:
avg = 7162 nsecs, total: 16101821292 nsecs, count: 2248034

mm-unstable + this series:
avg = 6689 nsecs, total: 15135391764 nsecs, count: 2262726


[1]: https://lore.kernel.org/lkml/20241114170524.64391-1-sidhartha.kumar@oracle.com/T/

Sidhartha Kumar (6):
  maple_tree: convert mas_prealloc_calc() to take in a maple write state
  maple_tree: use height and depth consistently
  maple_tree: use vacant nodes to reduce worst case allocations
  maple_tree: break on convergence in mas_spanning_rebalance()
  maple_tree: add sufficient height
  maple_tree: reorder mas->store_type case statements

 include/linux/maple_tree.h       |   4 +
 lib/maple_tree.c                 | 193 ++++++++++++++++++-------------
 tools/testing/radix-tree/maple.c | 130 +++++++++++++++++++--
 3 files changed, 240 insertions(+), 87 deletions(-)

-- 
2.43.0


