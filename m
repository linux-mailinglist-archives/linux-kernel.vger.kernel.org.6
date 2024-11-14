Return-Path: <linux-kernel+bounces-409719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2909C9081
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFDF72852E9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FA119259E;
	Thu, 14 Nov 2024 17:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FuybvMBm"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8ED191F83
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 17:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731603949; cv=none; b=GPuC3LSltxbT6OAdehpks8N/JpKGDwLSKjBcid9GnsrZFhVxY1eSrSIEzYxD09Nf5452KT1TxL3ArPiATY1iRDxedVxpszF6JaBMYnuzp5zT6tqHgCuSp6I7nzy2elO5eOdVEaOLPVpyIHU3xVQ+qQ36KqQgggDEwGbvtN0YcGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731603949; c=relaxed/simple;
	bh=14DKtAy5eJK96PAvjqVZ7KtGyTX5x8J9GCCe8HBRysY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tLFo7AwpoqhJAmArFKoWw8kUuAdrmJ5cPd50E2mgAS2MEJ7yrLHZ6BMK2wwHHkb2qE+AsU5hdn4Si2yVquSCk+ugb9tHvZ0V9UCbdR2nR5zCCPlSNdg+VLtSrZr+wcPuee0+v4rLi6xJIOsBZTsbRuERc4VipxquLjrdQCjpjXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FuybvMBm; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEDHSw8025082;
	Thu, 14 Nov 2024 17:05:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=FFFolayj59SPa6a5ry3K7EO1JG669
	hS35arha73WQKk=; b=FuybvMBmpFPq00BscZSPyuGk9NUKocxQwJoY+Hw4FAjIP
	b/rdZcQGCeqQAFlnY3kjWeRrtGse3jbZ5Sm7Mebv+y7EQIA497Cx4vQDfTupp5bj
	eEND/wtll4rTqI6w2XKb69hfg6N9bbDSFnaUnvOmM164xvGMK8Xo+A8LshcoOnzS
	VMr3vrKOnU7dGCEulF3q7YxzcfqzkttTTr+u1XWdDJAh9GlOYpitEtYad7H4UpaQ
	QidTRx4bwSA2aLApYKVV7GVLATKid0FjLmukHk1MGJXtEH4zhLS+/GGxPwKApOYx
	KBqJyJSPEZU9zd1hc1KBbGyd0IarolvXK8uf2w5lQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0heskys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 17:05:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEH3ROU022745;
	Thu, 14 Nov 2024 17:05:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42vuw1jy6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 17:05:27 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4AEH5QmH032739;
	Thu, 14 Nov 2024 17:05:26 GMT
Received: from sidkumar-mac.us.oracle.com (dhcp-10-39-201-66.vpn.oracle.com [10.39.201.66])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 42vuw1jy5w-1;
	Thu, 14 Nov 2024 17:05:26 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 0/5] Track node vacancy to reduce worst case allocation counts
Date: Thu, 14 Nov 2024 12:05:19 -0500
Message-ID: <20241114170524.64391-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411140134
X-Proofpoint-ORIG-GUID: MtKCEM8yZv4wXPA5BALxi4JO3Ct--jlZ
X-Proofpoint-GUID: MtKCEM8yZv4wXPA5BALxi4JO3Ct--jlZ

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

For rebalancing stores, we also need to track the lowest height at which
a node has 1 more entry than the minimum sufficient number of entries.
This is because rebalancing can cause a parent node to become insufficient
which results in further node allocations. In this case, we need to use
the sufficient height as the worst case rather than the vacant height.

patch 1-2: preparatory patches
patch 3: implement vacant height tracking + update the tests
patch 4: support vacant height tracking for rebalacning writes
patch 5: implement sufficient height tracking

================ results =========================
Bpftrace was used to profile the allocation path for requesting new maple
nodes while running the ./mmap1_processes test from mmtests. The two paths
for allocation are requests for a single node and the bulk allocation path.
The histogram represents the number of calls to these paths and a shows the
distribution of the number of nodes requested for the bulk allocation path.


mm-unstable 11/13/24
@bulk_alloc_req:
[2, 4)                10 |@@@@@@@@@@@@@                                       |
[4, 8)                38 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[8, 16)               19 |@@@@@@@@@@@@@@@@@@@@@@@@@@                          |


mm-unstable 11/13/24 + this series
@bulk_alloc_req:
[2, 4)                 9 |@@@@@@@@@@                                          |
[4, 8)                43 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[8, 16)               15 |@@@@@@@@@@@@@@@@@@                                  |

We can see the worst case bulk allocations of [8,16) nodes are reduced after
this series.


Sidhartha Kumar (5):
  maple_tree: convert mas_prealloc_calc() to take in a maple write state
  maple_tree: use height and depth consistently
  maple_tree: use vacant nodes to reduce worst case allocations
  maple_tree: break on convergence in mas_spanning_rebalance()
  maple_tree: add sufficient height

 include/linux/maple_tree.h       |   4 +
 lib/maple_tree.c                 |  89 +++++++++++++---------
 tools/testing/radix-tree/maple.c | 125 +++++++++++++++++++++++++++++--
 3 files changed, 176 insertions(+), 42 deletions(-)

-- 
2.43.0

