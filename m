Return-Path: <linux-kernel+bounces-537289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8CBA48A19
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AADFD3A61BE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CD027126A;
	Thu, 27 Feb 2025 20:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FWd8Egt3"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1126426F465
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 20:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740689320; cv=none; b=Jvx9lpFRn7KHFwkBBX1bpIk5R9gz7pMCq6RqYFLuC+ikCYnKXYKmrAEkQISWVbrOhj1GnPIHuUTYqa1uwuYZ8Np3YOj1VcqHa0wLxWr0pRt6Nk9zpZ0als0QhXfOj4goqZXOmrrqvlTrGV4ar9/I3rQh9GqPOo+5fSkf3C8fTs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740689320; c=relaxed/simple;
	bh=wdX2/y07O8mcD32gVDYmGd0m4dsAl4E/iBQ9PeT8v+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CElBBUx0JAF/SUwjcjloI5tMyrlCKrf3fHbe36hHa+9LN1J2/62wrA7jGLyst2zmHkTd8miQMxArada/SdcP+/TYwpmMnefxF96NZ5sI+eZIDmLAwUkJahECv6RGBE4viRYkjaie7WgUa8N1ozqtqoPFAAL/lBOHUOm/IkkoOcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FWd8Egt3; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RJis2U020630;
	Thu, 27 Feb 2025 20:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=vtzYSLWofQEg5GnL4CHfpwShCIiXc
	vD22mMwWpFecxY=; b=FWd8Egt3l4hWqz0dsQBLXhJnRkCt1upQaByRXfDI9rWNZ
	ifDb4vHWs3KuPR2fRoD1sRXQ+FOC+3WiGldyzkUPdxA4NthlIvCZpByM498zHnm1
	W99A7XDQykgoqzcmMPUsFY7uP8SALJnkMdyAAQB8wD9gYMUXfDFjyUP8KfFSEdYM
	dfuoc3kRqNp6U0IcP38102KF+as1uTjvnLgul/Kvc4g/5zyY43ezVL0nttZhA7dd
	lAbXFHpymDg2P0KQda93NFo6mD4PipJDkC+WS3/Ii8qYyY1qBdZhAzlDZmBWfu4h
	1Bd9xX5WAfE9lIHNGHSRWGqyzDyy18t0V+ulp6/Dg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451pscccmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 20:48:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51RJGgf9012623;
	Thu, 27 Feb 2025 20:48:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51dwrx7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 20:48:27 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51RKhrvc030883;
	Thu, 27 Feb 2025 20:48:27 GMT
Received: from sidhakum-ubuntu.osdevelopmeniad.oraclevcn.com (sidhakum-ubuntu.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.250.108])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 44y51dwrvc-1;
	Thu, 27 Feb 2025 20:48:26 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        richard.weiyang@gmail.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v3 0/6] Track node vacancy to reduce worst case allocation counts
Date: Thu, 27 Feb 2025 20:48:17 +0000
Message-ID: <20250227204823.758784-1-sidhartha.kumar@oracle.com>
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
 definitions=2025-02-27_07,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502270154
X-Proofpoint-GUID: 0B2tKnjDNF41CsIjASYpjsewG4mkUtM0
X-Proofpoint-ORIG-GUID: 0B2tKnjDNF41CsIjASYpjsewG4mkUtM0

v2[2] -> v3:
  - add r-b to patches 1,4, and 6
  
  - update function parameter comments in patch 2 

  - remove line that sets mas->depth in patch 2

  - remove redundant code for checking for a spanning write in patch 3

  - rewrite commit message of patch 5 for additonal context and clarity


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
patch 4: support vacant height tracking for rebalancing writes
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
1   :                                                    (12068)
3   :                                                    (11836)
5   : *****                                              (271192)
7   : ************************************************** (2329329)
9   : ***********                                        (534186)
10  :                                                    (435)
11  : ***************                                    (704306)
13  : ********                                           (409781)

mas_prealloc_calc() return value mm-unstable + this series
1   :                                                    (12070)
3   : ************************************************** (3548777)
5   : ********                                           (633458)
7   :                                                    (65081)
9   :                                                    (11224)
10  :                                                    (341)
11  :                                                    (2973)
13  :                                                    (68)

do_mmap latency was also measured for regressions:
command: stress-ng --mmap 4 --timeout 120

mm-unstable:
avg = 7162 nsecs, total: 16101821292 nsecs, count: 2248034

mm-unstable + this series:
avg = 6689 nsecs, total: 15135391764 nsecs, count: 2262726


[1]: https://lore.kernel.org/lkml/20241114170524.64391-1-sidhartha.kumar@oracle.com/T/
[2]: https://lore.kernel.org/lkml/20250221163610.578409-1-sidhartha.kumar@oracle.com/

Sidhartha Kumar (6):
  maple_tree: convert mas_prealloc_calc() to take in a maple write state
  maple_tree: use height and depth consistently
  maple_tree: use vacant nodes to reduce worst case allocations
  maple_tree: break on convergence in mas_spanning_rebalance()
  maple_tree: add sufficient height
  maple_tree: reorder mas->store_type case statements

 include/linux/maple_tree.h       |   4 +
 lib/maple_tree.c                 | 193 ++++++++++++++++++-------------
 tools/testing/radix-tree/maple.c | 107 +++++++++++++++--
 3 files changed, 218 insertions(+), 86 deletions(-)

-- 
2.43.0


