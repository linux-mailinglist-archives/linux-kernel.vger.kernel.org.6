Return-Path: <linux-kernel+bounces-558531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE568A5E715
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44B063AE6DE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DBD1EEA40;
	Wed, 12 Mar 2025 22:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="PyQsFusJ"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020081.outbound.protection.outlook.com [52.101.193.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5EA1D86F2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 22:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741817743; cv=fail; b=XpQUxWljaEDAupljF9wTdQZdr/Ljj9GVJfHW2r09uzw+svanZdBrRt9Nm9vMZRNfwlxRhcrv4pBBdfqe8s4ACCDPtiTkBoLRpSz6OSX+g1cZKbCXUIl/GOOZV4NFpJA9hmYdgCzq1YSMsx6+bfgnv46eD6ypP2O2D/dOZ/8Ojz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741817743; c=relaxed/simple;
	bh=UJ8jMzxX4JUASapi7z1owaT1A8i/jVgGF3yxP1DYUQs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=S6vVj2cRXgzmxFusKc7lRySzUR98ikZh6pWgj1oonqhegcTtSt6AjuTUhr/lBZg9HlBdR66v5bb2DJ/VWfQhsafVLFj4BVbV7kYtFebvx/RHWt1XV4BJcZRWIPkEmmiavccTiF093yWOwAJZIKXcdPdquiR5cyoFoZvQs/AYltc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=PyQsFusJ; arc=fail smtp.client-ip=52.101.193.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mlc1754dX++c4HB1DMVg/qydXCOR6ccH8ykKXcrOg7NIProLXZe8hV1hm2cmXS13zJuwZLBpUNsuaUFxGnnhHyk+6mpdMYIUNMnWddg+RFze0DOFOkmafIRHIt5VgiM/YQm4oQ7FtEzkS7WxayToUa9gyw0f+9q7OMefU8ALxgeIvEp02ajERyn8kIWPeGdQ8l/BC8lWE/IGlor4/999C43NY+S6C8DCGMYWxoHXX+DLHDhzGDT4/hqVXcqp4bkQtLVq1UVeLgzDdT+IkkanA/iOPgyr+rw1hYS3l6nB1V/OmOeE80EebmPs+ESeFSimm2iKLHRPY8vKUoLj4t7zoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0n4Taklm3c4QYrIruFt44QWnbmlRZ3RcfI3hTY43K1c=;
 b=Zip1oNN9ydT3kANj83ee/J5vZZvCLmFZMUwsQdiqeGrIZYRFHa4eNaEvJw39ClhXDDtoumXqgYuAWHi/tX09+iLb20HDxspSyntb1erh6ScTcBP+710Li2VBJMxhloSDSiT8DobmONRwrpfG4iWe2GWYCr5962biiTSTcvtsLSWqzYTzLoU9M6m44+AAozUFvSfKQmrVnWzOFF4XHmUzYCBCEHOzfSs6AkdvYg3Oo5pkGyi31tFE8pp0/dZ4Vv9mVK7yhloA5TIP8UzWy5c3L0ENOa66NNglCKSGZexqAo78kZnn5xx3kkdG9EgvTYQI7usQwd8o43jUkfdxNIRU1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0n4Taklm3c4QYrIruFt44QWnbmlRZ3RcfI3hTY43K1c=;
 b=PyQsFusJE2hPpupAFQYENFyMjtdGFD50nsEIlIWIbgDYdREDEpJmZTyYJZncEdx7j7gTTYehfpwZ8kZm6NLWKNYhdhbtdlajXBNcPMz4kxi1ohjQ/SFvFH/TboX7TMX7reDddg+/8wzeo7Q7HIZhyiG9l2wA3SuRWMqQJGPGxo4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 CO1PR01MB7353.prod.exchangelabs.com (2603:10b6:303:158::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.28; Wed, 12 Mar 2025 22:15:38 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 22:15:38 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com,
	vbabka@suse.cz,
	jannh@google.com,
	oliver.sang@intel.com,
	akpm@linux-foundation.org
Cc: yang@os.amperecomputing.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [v2 PATCH] mm: vma: skip anonymous vma when inserting vma to file rmap tree
Date: Wed, 12 Mar 2025 15:15:21 -0700
Message-ID: <20250312221521.1255690-1-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY8PR22CA0015.namprd22.prod.outlook.com
 (2603:10b6:930:45::14) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|CO1PR01MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: 758cd20d-8dfa-4597-4fed-08dd61b36b17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qvM0q5f7WqjRNiFXlBD4sdEo91xR5dDBcv0znpMFhJAAXxfgXbh6jElNka7C?=
 =?us-ascii?Q?HwcK/rkJxpkQT21PPh2YuNOU7M8Ufquf21wmVDUCb8RvXxaoKSDVy8TBh6Uz?=
 =?us-ascii?Q?AMbB5QzZ0vwQthXMsYFRgzQBGEH2GIKq+1gYHei+a8e3xoVKe2MeN/1Xp9e6?=
 =?us-ascii?Q?l4DWAV+UhZkFNEyDk3W9mEF6cJCMqBOTHjD2Pg68HmT8ZAhnvO3ehOR4XhxH?=
 =?us-ascii?Q?GGFKKx5n7hQX848t06IK/GU3tlLQavrPEK2HW3Ub9+T9BlUgyRmtU4wWF5lK?=
 =?us-ascii?Q?+giNZl0tBg5iML1Db3HfwtaXwKwdh5Ulo7DidFonye2x5JVAEuzKOA2qkhpH?=
 =?us-ascii?Q?+vDtDF4aDT2hzaGWQBEIah/jnQI1WOyzDtweIk3B7km0wwY/StLsfno4gHOJ?=
 =?us-ascii?Q?rE5GkNtGlNQ9z2gFWMS16sjhRKumqr6cgQ3Ju18/pialFxsjTSMBWwnUFxZ6?=
 =?us-ascii?Q?ZPfr303R3dPzLObBFZnukTkljAPiZjIajzc6w+14XLE+2+fnLoEJ8SZIR1b9?=
 =?us-ascii?Q?EvhMyTMwsj6ZO6kwzU8FM07hhApn/tudDfvBiABF4P5nvV/gqXt/3aaAUFM0?=
 =?us-ascii?Q?MbFZFjplI7xILAd1PtwbbWs5i21MMFHI41wRSOvj4HIMS0NhY0JoW1EyWCKi?=
 =?us-ascii?Q?gmJlyh4JRKme6Biob9AIh1witlNw26gfZaOmt4UkEerqQ9YY5jY9F4NRC5W7?=
 =?us-ascii?Q?kcgnuSWmq9+VXR1jlcQdEdq/Lc0F/0ohN8BYPZS9kqUcmKeGAxRyuYYW1YJw?=
 =?us-ascii?Q?9PgPYV9lRggLeTa0rLyrNJDQj8JzQWrMuCt6q3HJ/UuMgaWHfSHAK3JCVI3f?=
 =?us-ascii?Q?rlgwzNJnMSa3sHbbTcDXqaedxAZlmZanbT9m9Wk1ZgQY2laGFC0HgxV5fZZJ?=
 =?us-ascii?Q?NAFm8jpsXZ+dqxEWIwaDFycbZ+kPm+aiI82SrICViZvvxXU5rFuh+qTxhav3?=
 =?us-ascii?Q?0tJrOoBtir9m8gBjG9Gte27b2Od+X56qYDpBJEfVe8gyGcZVZ7vM9gCq/zYp?=
 =?us-ascii?Q?aqUOnJeojFF5Gj21EM9WfG8de11SLe/jSEQKan30znEKAFGPJtAfp5AJza72?=
 =?us-ascii?Q?cFwAVNDC08rnKnuMVqfuSFU+/3oeBlmnw/1MpxveZtL7VXep27j/+uQ6o2YD?=
 =?us-ascii?Q?BLINS+4/Z4i/8FJtXpkwuQ+G0aJgOjBgnUTvuTOQzS7Qlz8DMSAoH4yFqn5g?=
 =?us-ascii?Q?kt2ruAvITded6UxFSBK8ssCASrzEdZ9XLAy3Tp39SQkxbMOW/jYlSXLMXAqj?=
 =?us-ascii?Q?hgZyeVHHINxL9Md0uvlrl7HCownq8HI1eckILikO7GEcsGdUwJJaoSk1VoNS?=
 =?us-ascii?Q?Lt827d3zwDNHFrmHtzpI+djn/Hu4OY5sU+3Q0GnMkgw05tp3dFfhBOMI4Luj?=
 =?us-ascii?Q?r6ofyNsfD6F/Ginj7OLKl/GIgBF0zTXHkiPHRhz5vQP8CR4rTYlXMo8CRI2l?=
 =?us-ascii?Q?cdx8S4sllQ9dw+2J10nzyxjkE/lJERbq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9ZUnjW/k5QNBzIcW8cIRJEAjR9qlImoE1z9S9aJlBAtR/iOXc2OP2cAu9F4q?=
 =?us-ascii?Q?WbyJBqtUDrsx2unoCUQs5zq8cfCHZ/kBdFaT8nctkhmT/GjqRYrKy9mISZtn?=
 =?us-ascii?Q?+V4JuwfUZv6dMZg0918Ga2WmjbhLgDoQHjeZaV5rLmSQsa8x083MgFN1OwZs?=
 =?us-ascii?Q?PtQ/M29n2Sai4dJklq0u2KGRxTRpFR34OW17c8MIuO1lEBMiqsuh8Fz6PToW?=
 =?us-ascii?Q?MG9Gr0sw27u5HtlqWlbcNHDLSox/gw6Xzih4+eJpfwYpm/j/WmptXz7rq47p?=
 =?us-ascii?Q?GI7pR20w71h/7nFZeFdumDADnoVQR7Mlw8cO/pJgjPEBTbohOaJwxgEQTYNd?=
 =?us-ascii?Q?wmFH5y/iAIzVhCu7vww821S6aaxaxoxTtq8lZrV+HyoSbYf5qiGcbVyI+QwG?=
 =?us-ascii?Q?J3NCOt5wvfQEheQuZyZ7VYUsL7J1yzDMirRJW+f2FzZkyI80nzxXkhqyxSd+?=
 =?us-ascii?Q?Shd7Pv35V/asrSjt060oO72idlc8hv74nRbxwOF0qrIY4mWwfq181/HEVyHm?=
 =?us-ascii?Q?o1RYyrpTak226ZyYuWJwckNU7rMAoJgnaYiyvPWdlDb3OTvvvBddtzz9C43v?=
 =?us-ascii?Q?fvQ8N5DMhm8FD85Yeyh6OAmAy5QyuI/kcehCMgOvNdWVyX0oEs/jzvl+eew6?=
 =?us-ascii?Q?3MNuao6TM287haG+gYXd98nmg025ee58W8H2yJNZwM/PxhqEk1oarP7zeftE?=
 =?us-ascii?Q?DNsgmmGy3DfKSS8NCedSta1e/RHlHf8B2wHlADCYjiuv+cb9nfYDYLghuhEG?=
 =?us-ascii?Q?OdldDQt1WTAzZg2FTtcs9Ia2UlBOQxi1xi+QQY4O/TfbRgLsEANM/k7p6sem?=
 =?us-ascii?Q?bsn0hQyGjitxZdIm50XjmgPlokgNgp0utdXiP4wH6ieFjUAb7L5iPMDcEvkU?=
 =?us-ascii?Q?eiH75n2G2aAzCIq7xe7FoUKKA+u5Y3AZ/pPG1rxL0ioHF5g4cgAqinnf3O9D?=
 =?us-ascii?Q?S2cnQlmfTL7oZx6zPlwwLTkCOv3k9D1Ax0hhW04rOu1PHu4dAwujGYDO9YiD?=
 =?us-ascii?Q?23tsmKxxZxwrdNLZCZajenJXJE4J0XqcT0j2ELWqgvifY7w6Ujr+BQZJG2kU?=
 =?us-ascii?Q?e8rsABh3qqTrOS6e2DAz0OeSFspniKi9G1oVodKD1RUY1rcQWkiNFDAD2HJR?=
 =?us-ascii?Q?+EHxRq6DevPuD14V1+UIF91gIwS8lkP3APR4MFZ5ieG4dNKOFO9wEnFKjfKv?=
 =?us-ascii?Q?5zTFYhmEeJFCgctYRS1gUycgiY5igg8E/desOCP6VI24N13sRhhFNJPlOjDv?=
 =?us-ascii?Q?c/npk/rPCYFhK4O7D8mtYe69U3TWvyOoSkKBF4FLEUasLKEvjL7nR+F+Ou38?=
 =?us-ascii?Q?VUwtAt/1rglKskT3HBuKuzGfDm/ELxCPiTTH70eu5TTHqKyU4qvTtDKepV25?=
 =?us-ascii?Q?Vmt8UuYdiU1rMqGiFDxRH+b6Ae5fHm60AJKv8FSj18GD6Ul4yrcN+UL3pjza?=
 =?us-ascii?Q?4TBf+LZIR+SIWqE0Bor+QIYH+dKftse2AUtoxVEOvXmYR40JK+yJgTDVIcCC?=
 =?us-ascii?Q?vN/00qt+zEewgGT4OSIkRgJEELd6OUDyqhxncMt/udmfFeB2fohIeTiXMwtD?=
 =?us-ascii?Q?x8IHL+HLzLG/ziaBUFifYxiVLlzmTmBDgAxpAEDGHSo+MwENa8xWGuKN6FHL?=
 =?us-ascii?Q?loJvgUq+s8P4d9vHvmNdhZo=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 758cd20d-8dfa-4597-4fed-08dd61b36b17
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 22:15:38.1763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e5HAngUA8I2ReWqvanJ1duk7aaTa2I4WkidHvYSG9eySDGTg+8by3rTM+a5EsIV+FwFK7lc7mJ030y+CCt3fiv0UnDqf4MRQSuyy3uARrKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB7353

LKP reported 800% performance improvement for small-allocs benchmark
from vm-scalability [1] with patch ("/dev/zero: make private mapping
full anonymous mapping") [2], but the patch was nack'ed since it changes
the output of smaps somewhat.

The profiling shows one of the major sources of the performance
improvement is the less contention to i_mmap_rwsem.

The small-allocs benchmark creates a lot of 40K size memory maps by
mmap'ing private /dev/zero then triggers page fault on the mappings.
When creating private mapping for /dev/zero, the anonymous VMA is
created, but it has valid vm_file.  Kernel basically assumes anonymous
VMAs should have NULL vm_file, for example, mmap inserts VMA to the file
rmap tree if vm_file is not NULL.  So the private /dev/zero mapping
will be inserted to the file rmap tree, this resulted in the contention
to i_mmap_rwsem.  But it is actually anonymous VMA, so it is pointless
to insert it to file rmap tree.

Skip anonymous VMA for this case.  Over 400% performance improvement was
reported [3].

It is not on par with the 800% improvement from the original patch.  It is
because page fault handler needs to access some members of struct file
if vm_file is not NULL, for example, f_mode and f_mapping.  They are in
the same cacheline with file refcount.  When mmap'ing a file the file
refcount is inc'ed and dec'ed, this caused bad cache false sharing
problem.  The further debug showed checking whether the VMA is anonymous
or not can alleviate the problem.  But I'm not sure whether it is the
best way to handle it, maybe we should consider shuffle the layout of
struct file.

However it sounds rare that real life applications would create that
many maps with mmap'ing private /dev/zero and share the same struct
file, so the cache false sharing problem may be not that bad.  But
i_mmap_rwsem contention problem seems more real since all /dev/zero
private mappings even from different applications share the same struct
address_space so the same i_mmap_rwsem.  Inserting anonymous VMA into
file rmap tree is also a broken behavior.  It is worth fixing from this
perspective too.

[1] https://lore.kernel.org/linux-mm/202501281038.617c6b60-lkp@intel.com/
[2] https://lore.kernel.org/linux-mm/20250113223033.4054534-1-yang@os.amperecomputing.com/
[3] https://lore.kernel.org/linux-mm/Z6RshwXCWhAGoMOK@xsang-OptiPlex-9020/#t

Reported-by: kernel test robot <oliver.sang@intel.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
v2:
   * Added the comments in code suggested by Lorenzo
   * Collected R-b from Lorenze

 mm/vma.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index c7abef5177cc..2fe99d181cfd 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1648,6 +1648,10 @@ static void unlink_file_vma_batch_process(struct unlink_vma_file_batch *vb)
 void unlink_file_vma_batch_add(struct unlink_vma_file_batch *vb,
 			       struct vm_area_struct *vma)
 {
+	/* Rare, but e.g. /dev/zero sets vma->vm_file on an anon VMA */
+	if (vma_is_anonymous(vma))
+		return;
+
 	if (vma->vm_file == NULL)
 		return;
 
@@ -1671,8 +1675,13 @@ void unlink_file_vma_batch_final(struct unlink_vma_file_batch *vb)
  */
 void unlink_file_vma(struct vm_area_struct *vma)
 {
-	struct file *file = vma->vm_file;
+	struct file *file;
+
+	/* Rare, but e.g. /dev/zero sets vma->vm_file on an anon VMA */
+	if (vma_is_anonymous(vma))
+		return;
 
+	file = vma->vm_file;
 	if (file) {
 		struct address_space *mapping = file->f_mapping;
 
@@ -1684,9 +1693,14 @@ void unlink_file_vma(struct vm_area_struct *vma)
 
 void vma_link_file(struct vm_area_struct *vma)
 {
-	struct file *file = vma->vm_file;
+	struct file *file;
 	struct address_space *mapping;
 
+	/* Rare, but e.g. /dev/zero sets vma->vm_file on an anon VMA */
+	if (vma_is_anonymous(vma))
+		return;
+
+	file = vma->vm_file;
 	if (file) {
 		mapping = file->f_mapping;
 		i_mmap_lock_write(mapping);
-- 
2.48.1


