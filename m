Return-Path: <linux-kernel+bounces-430525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E01229E321F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 04:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC2AF161487
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 03:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614AE3D561;
	Wed,  4 Dec 2024 03:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="oRQIuCSQ"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013055.outbound.protection.outlook.com [40.107.44.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7905C2F26
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 03:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733283125; cv=fail; b=Y/DcCHsp3ppiIAWWPxSGV0e6IbQ8JaSbeB+Fkw2hqcmz5OfAgNwMJKdyo+Gw91t75eq1n4oNK3IHtHwg7C8RkRfMf6xrmC5z5zazBpDZO5zoyaEiQeUO6TF6C2qK1JbN/uomkvDm3h+c3C/moDzC4AGo2ARSGN6Floyzsu5KxhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733283125; c=relaxed/simple;
	bh=DoQMCWCJ+71QNYGzSBVj1Ki0KWl39pcqbwoprZVVqxI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=AT1uFJIX4c6U6/4zozOzWZRbnqKSUYV7czh4dqMHgjjd9k1ux7pxsPzWnLuutIfr564mB9x+Gtv8tNvF0cEjqrxSw4w6TOkJQF+zWDUE7HIlHgPA42xPlURbM3IxFK/d7DALKdakQSZ0btlHCXRH44FtPX7gg/a9iD0jZoQdTCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=oRQIuCSQ; arc=fail smtp.client-ip=40.107.44.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KFV2L8M9jOJ0CDQDlfBNu50LPOr3/naDUaJpL3tuX0f38X/r5HId17IYp3CGrGFJrI4Sa/t89M+GFm+w+ruG0pBpHVjschU+xREB+11WBcXLBLm2kUKNJ8hMbI/zov8E3G76uwRsSbAKMs77JAyz1kvhf6bx1NMq9NSGOdh1cCx0ivuXxDgCinYrd7ZjVW/SFsyDvi8fZY+Cjl8WIAHmBEmU4bp9G+EBUvZSW8HKbqeLspwW9raS32STS5zGxOA5i1bViMH6CbpVouJH4gra6CSwUc1NQK3wx89uWpliXQST0cEBpMuf7rvTauWSUA1x4KwcnIJpxm2tY0ZYwWHzAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E28iwaN/PEwvcFSAUtHZNjEiQnELjVaCwT/ebZxqc4s=;
 b=G9sxPXjLVERPCJshL+iFn2ncnYk1sQECK6ycauS0ApSwhwaNfc5AL3hOUqYANQJ6mp0VkKNB4Umh8q+Lot7aZLVAIDyPvJeWmYfE5fWr/q7tkwl/JAwkOZIerkl/kB0+InkQGo3CyGZOhpuruiSlWKv05NGw2r1CCkQmnAcg541uj1YsDtKZQ17fRCpaqf2WgUiSm6JPs1GjG+BI35Hixy5epwSAYeQIXc1Atz+1J0xnGvzHCeLzXH2taWXerKqGuMq+/XyozNqiOYc31rIU1KY5Yw9RO7Re4eQX5pL2bW4rKP14cIqzuhLnC72cuPKW5p0ZQ2P6/VT8E8yMsSVqpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E28iwaN/PEwvcFSAUtHZNjEiQnELjVaCwT/ebZxqc4s=;
 b=oRQIuCSQEU5HhUDIQLY35yF7vb3aWxIIUKsS/vSviU3ckLHE6r9O1U+T0jZ2zKuy+kLClSS8Dz6xr+FqOzsVjUdhF2JM9n7fyDhRTc5R/3WQJOgBGTK5WXj+Qk1Vq+kfofWwQ1X74NOFbh9XKaZJ3/COuBL9uDP4mv1uKYnY14Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from PSAPR02MB4727.apcprd02.prod.outlook.com (2603:1096:301:90::7)
 by KL1PR02MB7450.apcprd02.prod.outlook.com (2603:1096:820:117::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 03:31:59 +0000
Received: from PSAPR02MB4727.apcprd02.prod.outlook.com
 ([fe80::a138:e48f:965e:36f9]) by PSAPR02MB4727.apcprd02.prod.outlook.com
 ([fe80::a138:e48f:965e:36f9%4]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 03:31:59 +0000
From: Yongpeng Yang <yangyongpeng1@oppo.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Yongpeng Yang <yangyongpeng1@oppo.com>
Subject: [f2fs-dev] [PATCH V2] f2fs: The GC triggered by ioctl also needs to mark the segno as victim
Date: Wed,  4 Dec 2024 11:31:13 +0800
Message-Id: <20241204033113.4133027-1-yangyongpeng1@oppo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::22)
 To PSAPR02MB4727.apcprd02.prod.outlook.com (2603:1096:301:90::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR02MB4727:EE_|KL1PR02MB7450:EE_
X-MS-Office365-Filtering-Correlation-Id: fa9de367-e99d-4ed7-d738-08dd141435a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1DVFK7/uh0aCYWcmYY09pWlD3C0XZHMc9wkea9hUTk3WkCU89pJiz1XEaMsV?=
 =?us-ascii?Q?mAgPjYMFClaDgV6GPvBaWjiI6jy9m0fplqV6PLLGuMEH3rHUQFMSdpaH9F74?=
 =?us-ascii?Q?ataE0qnFCufjZFPXMi/G+m/GhLDHUuRotN+z4TshuRNDms+xnZX54iQ7Iyhh?=
 =?us-ascii?Q?GsglOvjPXvxdItiDV0+dRppx4GVxVlwUhumoxM0BvMrW4Rx2ivpS6MGxtwE5?=
 =?us-ascii?Q?vtimfr0WhB8yK3A9BIkYV1o7yvJZw8T6kmkqjo3Oqp+YcYOtdg1IT7exbFYP?=
 =?us-ascii?Q?tUOlSEG9CKUb6yw9OiU9aFs9Jhu7D3IHFtRRJ1VzwucNqGzUSZJt63QdhCNz?=
 =?us-ascii?Q?R8GktVSn6X2NXxrUlIaH8+bYPYvwd176UZhEtJj5MeUrLK7p9zlzWgl6uT5v?=
 =?us-ascii?Q?EQbwD6AxBznUbEDqPupyWB2nMmGZMArO+M+1vLsBQwz05phx8iYI9xdikztU?=
 =?us-ascii?Q?qr6v9w0JIS0prP3heWX1XWY7bqPcTK6FmLHF/LtBUXMeCGnasTvlGpB+sxJM?=
 =?us-ascii?Q?qW2tiKzjgOLRddtvDP/JlzHn79MJMIX76hXxYks8tDXzbEZVjLUj/gAM3raJ?=
 =?us-ascii?Q?1G+pXCB5s3KITJx2RBwLoJmU4u/zYMdD7tR04QU/OaWyxLgnnBd8bmGmmL8U?=
 =?us-ascii?Q?+T+6G0eM3YYB3bbPntxJRUKNcZI82I7dijGolk+LXqu8/A6aI7bgI024TnP+?=
 =?us-ascii?Q?6Hlkj69unxfpFY9YYZaP7iQaWOblE6bPytWLynni1Z2QBHRGRQVI0z8xL0hU?=
 =?us-ascii?Q?80GzjZPRbj5/CvBeGkH7r0MzRAEZZgLGX13f7Stm16WXEWKND0FIW23ALjWk?=
 =?us-ascii?Q?IYyV9LljYYCnNkBkXXYiQBvreEwfdp1OWd8hDPFEu3tWjJYYBKBGAR5LKSjL?=
 =?us-ascii?Q?gpoRHly8cMdesZJvmRWf/7BmDr3mkjYzLbtVgZDTerPf/KOzuRpNj6BxSOBc?=
 =?us-ascii?Q?yqag1deeXZYiYRE0jWkyKGbBRzIllamhQcAI3GGCZ59CQ+qcMYwpwYCiihMn?=
 =?us-ascii?Q?uII1Cq39dPJSrBLZScQkvr+akxtGJuMo56LlsPArCYRrNKxr4G9t3MHRANfC?=
 =?us-ascii?Q?dPMudvaePAFJ2Y4UHYKUh/N+gFrJf+uedxoE+03MPnMuQSz9b67ZXfhkcLLc?=
 =?us-ascii?Q?Xg+j6joCRvURD5pv3oPOA01Ia2y/3NhfWvhT2kH0td+Wg2j5mGUte7SlgOS5?=
 =?us-ascii?Q?eKwBwHk9cH0hWuGQVMCoTuRtwNfr31nD8u74wLsoDjxBbAVZqUW/YlTIfpcd?=
 =?us-ascii?Q?ssNMp+9L54EXUgkEd3DK2Qcu3En3O5AACzMxFsCsY2lDnXqeV4nkQMpsDyhx?=
 =?us-ascii?Q?SzZLfmLOXi5rIXcBjQMGgXCwcJY3Jzpj4zwtMkMA1/1IcYDs1oqW016JDbiU?=
 =?us-ascii?Q?mILTUQdzRCeoFhBZoGzsQHL25cVsI6Mo5evbB3dA3jrjm3p/BA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR02MB4727.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rr68PllRk0Qikk3gBtN1yicxG9PixE7aPt/Xh/3f/IqWaFT0IVifwfqSCVVC?=
 =?us-ascii?Q?mEvgD1WjLTHBNILhc7nR0KNT9u4xwG1b6yXFzlPb7837nNlpGXUYmv1KXJIg?=
 =?us-ascii?Q?jy1vcY5IvostWyz6/b5eRtx2/tVtIfUYlBliK306I1pk5kck7ofBEZJutX7c?=
 =?us-ascii?Q?pLtM3qSYgVDwEgRwBlk1o9t54J1x+D1nJHpVz1aYfvEOYocaaK+Rz6JO7f2O?=
 =?us-ascii?Q?7raekUmNv1heZ50eb57bhmgMifgLBkEgdPtwAZ8Tr5xQe5VygZDoGh9Uc+Y5?=
 =?us-ascii?Q?01aZw5AZKeSMTVe03R1KgVkn74/4OyDM+NUAuWvZ6O3J2MHE85aa6kXKBdhr?=
 =?us-ascii?Q?r97Ky2XFUuUTvaVAd8SLY/AQUwCZfRr1A5iYSAt6m1NB+//6r0MSLATTIUc5?=
 =?us-ascii?Q?murO40BCOe55bk135hVS9BdGncSKdA9JfdpvOO7fLK9EmAWg0At4Y9Ys55ae?=
 =?us-ascii?Q?afQzro/92ZXWfNjSXHI7Tkd/r/VwlPOMjYrwoMzRfP0o5ioES3ec/FjChbRP?=
 =?us-ascii?Q?LL5csfEutpbp599GSf1AbCyVVYrjlPKFL2+3nuTti2o3CrYekZF2ylPmCi9B?=
 =?us-ascii?Q?pg2imBCFKAJtV3CLXj8qSAIwg0rWQgcz0oHsi/TqAKPlZXnGS4aOX6LJQDZr?=
 =?us-ascii?Q?RCOPzaII8tID0ur/C8WXj2Qz5CDO3Mwa+qxPvfgzIbkWbwT1f1mjSAJDo6lY?=
 =?us-ascii?Q?Ev9v1of6yjAjCn9Yqa57yk6g4u6yZK6QAaOMx8c+mhZB4oqvgHmttvA/dHe5?=
 =?us-ascii?Q?ecH96uqOdKHvkdIruab2nCpX2Wyfx6+aUVHhSag/TjEsbZjLHIN9pTWy0x/z?=
 =?us-ascii?Q?N/GrKUGaAUjVd/5SY3HJgRg7fHBAVLmmZfzhYw35BQCxKlrtbQMYsHZ8sIgT?=
 =?us-ascii?Q?4PPXCXPCdvy7qjUhRkS2F3gFzyd4EcjjdfsQGws42s104fpl1OX/Y7MADiXs?=
 =?us-ascii?Q?55KKlBnVfI28hf90nCTcbNOVwRbvV1UzH4KnEfYp+tRgCefWvSRfCa3E4VWI?=
 =?us-ascii?Q?Q6oUUheCjn7jtPHk4KefbvlXkC68/tgwuy/DX+Q2tTkpxp7qV8Vpq08ii9Kr?=
 =?us-ascii?Q?lcqWveziKRyzQxIppKVXXHDSXSFfFnA0arURiih1bTRy5zqW/IWOSV+3FiQN?=
 =?us-ascii?Q?po7ewiJrQVKXOO5sxwg/GCCxUq4PmAmbALnXLiG2u1PhbcEBCp1Cm2+FxCLt?=
 =?us-ascii?Q?8klz8IZfJnjfjKXXkO762A2Gj1OykPCZLCUZtqPP3XPAsCBhk7IGWrmhh1yR?=
 =?us-ascii?Q?GIJD6uQvzycjRksu5e+EyGAKo860VEENC1bEXYj0uYTytV2+1PS00b+/Z/yr?=
 =?us-ascii?Q?2VgFl1d8gddymThc6QWJE9oo/4da05LcMy0IMpWfGNm8KOsHVhWj5SfdRsIs?=
 =?us-ascii?Q?FCFOPsOxpHfHYfPfXObWqQPCmyrkwblyON+ok3iZNqKV0GSnP1yKCE1X3gD9?=
 =?us-ascii?Q?wHietkHd+nJK6W8qNwyZzPTKK54Nxv1wZhko5DHvxW64taWFosw/IhqdVyWg?=
 =?us-ascii?Q?F5YtAyQ2ivPowS8BrgLqWBb+DrqTH+mTuJCs+Kptvl5XMhk8d9TquWFWHioa?=
 =?us-ascii?Q?dflv21cDVkmkIQ6NMQG+1I8tJO57HyJZt2SKQ5efDpFxmTSE0aiSJIum6q3g?=
 =?us-ascii?Q?Qg=3D=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa9de367-e99d-4ed7-d738-08dd141435a1
X-MS-Exchange-CrossTenant-AuthSource: PSAPR02MB4727.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 03:31:59.0059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b2FsMIEN0xh1Wtl0SHpx9Ms4UvofXRuB6tezeUVSEK7TqpgGNtF3MysYlE0E2lTRLqVxTsf0u5kLFPnfLurdnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB7450

In SSR mode, the segment selected for allocation might be the same as
the target segment of the GC triggered by ioctl, resulting in the GC
moving the CURSEG_I(sbi, type)->segno.
Thread A				Thread B or Thread A
- f2fs_ioc_gc_range
 - __f2fs_ioc_gc_range(.victim_segno=segno#N)
  - f2fs_gc
   - __get_victim
    - f2fs_get_victim
    : segno#N is valid, return segno#N as source segment of GC
					- f2fs_allocate_data_block
						- need_new_seg
						- get_ssr_segment
						- f2fs_get_victim
						: get segno #N as destination segment
						- change_curseg

Fixes: e066b83c9b40 ("f2fs: add ioctl to flush data from faster device to cold area")
Signed-off-by: Yongpeng Yang <yangyongpeng1@oppo.com>
---
V2: Include an explanation of concurrent scenarios.
---
 fs/f2fs/gc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 3e1b6d2ff3a7..8029369bb71d 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -806,11 +806,14 @@ int f2fs_get_victim(struct f2fs_sb_info *sbi, unsigned int *result,
 			goto out;
 		}
 
-		if (sec_usage_check(sbi, GET_SEC_FROM_SEG(sbi, *result)))
+		if (sec_usage_check(sbi, GET_SEC_FROM_SEG(sbi, *result))) {
 			ret = -EBUSY;
-		else
-			p.min_segno = *result;
-		goto out;
+			goto out;
+		}
+		if (gc_type == FG_GC)
+			clear_bit(GET_SEC_FROM_SEG(sbi, *result), dirty_i->victim_secmap);
+		p.min_segno = *result;
+		goto got_result;
 	}
 
 	ret = -ENODATA;
-- 
2.34.1


