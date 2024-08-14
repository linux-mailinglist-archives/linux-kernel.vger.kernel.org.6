Return-Path: <linux-kernel+bounces-286859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBC5951FB5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B195282E8F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE9A1BD00B;
	Wed, 14 Aug 2024 16:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XkjyJ1iV"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CD81BB6BD
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723652417; cv=none; b=U5A94GoWBx5K6zY6akSSg8PrHIo5pi53wYwbgI0FvfR6wrANeWYVn9MESOXQtaWZKVgcEcKE5CiA/oTUNbEQBoW1Mb8jh3I7eoK6FhizR2WxVTRpD7DQe1pi4SIoTIOBPd/T+gb+u2zhjUPN35J2dQHQN6Brbr+UKIXtBFVu0PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723652417; c=relaxed/simple;
	bh=2LRmV3WNJmaPL1Z04NMziO4RJOq42NFJgYj/p0geTWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KUonATY/qiMb3WQ9mCSz3wLO4QWxTk32OWM1xUplGz42RQu7jZ+T4HbJv17HchkCgvbkMj9/vogH2sWygaWMivc64+IWvmhsZcEvRciYhyrXHvQD6z8yZt0mtTdIL5Gbl0DWAN5rrtyjl7ABpZxCnbwZa3bTWttj0mSVODPNzp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XkjyJ1iV; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EBtc3E028372;
	Wed, 14 Aug 2024 16:19:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=SK/Nu26uetx5TS
	G6GlCyrLf0Bo09xblzpAwAokPxC9A=; b=XkjyJ1iVoTYnhh5654FaMbuCSSsGNG
	7EodH+8YMnAHT+3agpNxBUE2jv1pGq//CY7U3cmRpq3axkc1EBjAbKrj1ilwpL3p
	85jsLQ1R46IwKdqYgrPonvVo6gqXmmJMBw+2ncFL6YuXsZieVXzE3vWHORcy8wpd
	/DHPMJZ/jVXmV+uvQLaAXEhobFS/vaosAcgVNGraQBA8O82hFJZWIMJNzJ1E4j4m
	fWPItB7EYHTr0pQjLIlyzmrvegjO9WXXf6nZYI5QMZf4wHx7bBSXNurZt4Wjhwks
	ytZ51vhdSFj8hcQ3GnH3jbaAFrerZOawaDRSip0Xj9NxoABAF9uw8EEw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wxt10sht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 16:19:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47EEuMDk021125;
	Wed, 14 Aug 2024 16:19:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxngn7hm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 16:19:48 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47EGIvBu035951;
	Wed, 14 Aug 2024 16:19:48 GMT
Received: from sidkumar-mac.us.oracle.com (dhcp-10-65-174-212.vpn.oracle.com [10.65.174.212])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 40wxngn7gt-1;
	Wed, 14 Aug 2024 16:19:47 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, surenb@google.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v4 00/17] Introduce a store type enum for the Maple tree
Date: Wed, 14 Aug 2024 12:19:27 -0400
Message-ID: <20240814161944.55347-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_12,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=1
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408140111
X-Proofpoint-GUID: 24WpDigPHcUZeefFkLGA3z4tHfQ12KSL
X-Proofpoint-ORIG-GUID: 24WpDigPHcUZeefFkLGA3z4tHfQ12KSL

v3[1] -> v4:
    - move up mas->node = null in mas_start() so mas->node is cleared in all cases.
    - don't pass gfp into mas_wr_preallocate().This fixes the libfs error reported in v3[2].
    - change condition of node store so more writes can be eligible node stores.
    - more cleanup of mas_commit_b_node() as most of the function becomes dead code.
    - remove wr_bnode as a store type as it is no longer needed.
    - add a patch to change many write helper functions to be void.

================================ OVERVIEW ================================

This series implements two work items[3]: "aligning mas_store_gfp() with
mas_preallocate()" and "enum for store type".

mas_store_gfp() is modified to preallocate nodes. This simplies many of
the write helper functions by allowing them to use mas_store_gfp() rather
than open coding node allocation and error handling.

The enum defines the following store types:

enum store_type {
    wr_invalid,
    wr_new_root,
    wr_store_root,
    wr_exact_fit,
    wr_spanning_store,
    wr_split_store,
    wr_rebalance,
    wr_append,
    wr_node_store,
    wr_slot_store,
};

In the current maple tree code, a walk down the tree is done in
mas_preallocate() to determine the number of nodes needed for this write.
After node allocation, mas_wr_store_entry() will perform another walk to
determine which write helper function to use to complete the write.

Rather than performing the second walk, we can store the type of write
in the maple write state during node allocation and read this field to
complete the write.

Patches 1-16 implement this store type feature.
Patch 17 is a cleanup patch to change functions that have unused return
types to be void.

================================ RESULTS =================================

Phoronix t-test-1 (Seconds < Lower Is Better)
    v6.10-rc6
        Threads: 1
            33.15

        Threads: 2
            10.81

    v6.10-rc6 + this series
            Threads: 1
            32.69

        Threads: 2
            10.45

Stress-ng mmap
                    6.10_base  store_type_v4
Duration User        2744.65     2769.40
Duration System     10862.69    10817.59
Duration Elapsed     1477.58     1478.35



================================ TESTING =================================

Testing was done with the maple tree test suite. A new test case is also
added to validate the order in which we test for and assign the store type.

[1]: https://lore.kernel.org/linux-mm/80926b22-a8d2-9992-eb5e-27e2c99cf460@google.com/T/#m81044feb66765265f8ca7f21e4b4b3725b18780a
[2]: https://lore.kernel.org/linux-mm/80926b22-a8d2-9992-eb5e-27e2c99cf460@google.com/T/#mb36c6526486638e82518c0f37a428fb279c84d8a
[3]: https://lists.infradead.org/pipermail/maple-tree/2023-December/003098.html

Sidhartha Kumar (17):
  maple_tree: introduce store_type enum
  maple_tree: introduce mas_wr_prealloc_setup()
  maple_tree: move up mas_wr_store_setup() and mas_wr_prealloc_setup()
  maple_tree: introduce mas_wr_store_type()
  maple_tree: remove mas_destroy() from mas_nomem()
  maple_tree: preallocate nodes in mas_erase()
  maple_tree: use mas_store_gfp() in mtree_store_range()
  maple_tree: print store type in mas_dump()
  maple_tree: use store type in mas_wr_store_entry()
  maple_tree: convert mas_insert() to preallocate nodes
  maple_tree: simplify mas_commit_b_node()
  maple_tree: remove mas_wr_modify()
  maple_tree: have mas_store() allocate nodes if needed
  maple_tree: remove node allocations from various write helper
    functions
  maple_tree: remove repeated sanity checks from write helper functions
  maple_tree: remove unneeded mas_wr_walk() in mas_store_prealloc()
  maple_tree: make write helper functions void

 include/linux/maple_tree.h       |  14 +
 lib/maple_tree.c                 | 653 ++++++++++++++++---------------
 tools/testing/radix-tree/maple.c |  46 ++-
 3 files changed, 400 insertions(+), 313 deletions(-)

-- 
2.46.0


