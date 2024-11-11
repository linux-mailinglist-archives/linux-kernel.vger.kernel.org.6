Return-Path: <linux-kernel+bounces-403715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A46789C3980
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 09:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64B312823C7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 08:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3455415CD42;
	Mon, 11 Nov 2024 08:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="MRZpY2PG"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2072.outbound.protection.outlook.com [40.107.255.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D29615A85E
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 08:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731312570; cv=fail; b=jupb/OVKVxG23tU7RWUwK3od7lwqFkq6TdSArhxE3W6LnsoG6n64b0ZxRi23o2ljUgRhFv304Q573nRUNV3CdVkSb576A7UrT68gh/y/mDZHRMfiqy6wJqoFWebIofBQsY4BoVJyuwoiQf9S4hPvALlIu+tp5RkL3RiTn2C/wU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731312570; c=relaxed/simple;
	bh=PeJPJJ2u00GrXl8CuXH6EwUeMcVPQb7FeAUYvDT2Zjs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=QKeI0dx4DP3UhpcOyfV/k05ZDHJxTNm6hRyaqwOL5lMqtl97JUsiMPZVdZCo2vB7hH1t9IVG0s/owSjoHaxw1Aqb72OTYHPhBq1YX96pfVV1WjMjNpvIA83aeqUU35xAqE+OG2jXC4RTEVXnXUeS4OiZHPh54WJQ5u9RFzHFkd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=MRZpY2PG; arc=fail smtp.client-ip=40.107.255.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OSQMfUvMd2TPVJf/qFvTHDWMgL6y1NdFzZpAhr70lGVJsYm8NaaglSQNfs1JysWF4Jjh6Bdqz1XjFHEuFBi/xivPDrMD4vDD43hpQPevSZmTkx5sOmJGIgeccsGbYjpLfEE2FPNp2UQESlDcIFu3WNOk7lMqTKZ1/fwnsACxiEd8oLEOikT7rX69Jufzz+DdfSTmKMN0Lw1cUJIKzuWLm/nv/3rBxsGEBEc10MSB9Dtwwv0y7Lxri0z5soIdCvU3yoyw4xnXmOKRPAflSEWxiRPhN/c73mVLKyr+3yaEYpsI5LngkifnR3WJQg51Xl5cYUe+JWBzRt71ripCTT8syQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HytREAiGmpZ2wbflQy+jQkgYRurZCX3off4juVAwNaw=;
 b=LAeYh9TtfgiKCWMTYR8Q8+wMTpF1YbAgSwOnhTmZFzVwoTPZBlVa1EGaWoDKHfWLDgOEz53Tduf/sE8Vf+YdsgoEQCX5IC3A2UQHWXfGv4UKb4PxEeOV+uwVZxapsiQksKThU6hB7a9pL5DQm79zLdZ/Jm50Y8qJdNE1/+KimHRr5D12uY+ALhfRamPhNceVvKMlOxNfnfYmBYvrCcz7DxvMHEEKrTturhe3VHE6ML7NsuhfJec1KJwmK6UTuZUefYa88929+zQDo/vtyVo2qsKyqdYdjd9ccvNS0cMZOFHlMQClzUI/EJIencLwmHbW7IabypKSFVmdRhxOVVE3qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HytREAiGmpZ2wbflQy+jQkgYRurZCX3off4juVAwNaw=;
 b=MRZpY2PG21lTBrm7PL/jiRGrBJdf2SR799wGo15tWFORlPyUhPmFks5SIeHXqbOX60SyBpLRWGyFw81pbdBnTyH6fKZ3m+8Ynz2Kfiv5IDCqB63mXVwimJ+WYJYM5v184LEurZzONrqwItYtGyPtpNPQCWs7dEDUeGEzQFeU4gsf5jj2pfYXGtcThcBrZU/JzBQmR6CHKNyXibEPWq7hRUtVYYjkcIV4vRRocU+/6zUbemLRDfYv5wtH/qOvm9kejt5bqDrzji3buxtLmX086il15CS8DVf4gtizPcfqjUYrxBZ+Zik8bn2ulHmT5R+b82C534sGq1rlNM9FEAepog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com (2603:1096:405:b5::13)
 by SEZPR06MB6783.apcprd06.prod.outlook.com (2603:1096:101:17f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.14; Mon, 11 Nov
 2024 08:09:21 +0000
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b]) by TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b%6]) with mapi id 15.20.8158.011; Mon, 11 Nov 2024
 08:09:20 +0000
From: Chunhai Guo <guochunhai@vivo.com>
To: xiang@kernel.org
Cc: chao@kernel.org,
	huyue2@coolpad.com,
	jefflexu@linux.alibaba.com,
	dhavale@google.com,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Chunhai Guo <guochunhai@vivo.com>
Subject: [PATCH v3] erofs: free pclusters if no cached folio attached
Date: Mon, 11 Nov 2024 01:25:36 -0700
Message-Id: <20241111082536.441004-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::13) To TYZPR06MB7096.apcprd06.prod.outlook.com
 (2603:1096:405:b5::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB7096:EE_|SEZPR06MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: edab23b2-f521-4887-9a2a-08dd0228257d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EqYLXB7Tm2Xgw+1pYfDY0IHeBUmSho0WR9ae1f7pjwKd2McO4SMDFbUNOZCJ?=
 =?us-ascii?Q?yjRoRZcdy4XbUS9fX1AojbblTXmAUUtHH1h5Qr9vobHAjJ+2BWBbK/kqy6E0?=
 =?us-ascii?Q?V+5yckCWAFM4FaPYoggsrLnkp4/9EiJWIpuZaMgelFAAAVanar/vpp6TFIEJ?=
 =?us-ascii?Q?TXvOsNB2wLNI4vYV+yhU4jDeEGGNeI088SSgPRiPcTF+2CFbOUxYCv2lahL2?=
 =?us-ascii?Q?pDuYYn/F5ZgSqTkRSyUcNGWKe7O6M3dMNV7PeSRX4h/zImRdz3f7sYuQPVuN?=
 =?us-ascii?Q?y645lI9482YFsrR8lvETYcuHm0vmvg5XyFZ3AxJHjB5T62WPJG4D/SwotTbg?=
 =?us-ascii?Q?NNAlUhS9xjyaVRKb76n7oCBIqqmUZFdFJ+xTVWCe9AozSqbI3bsQzlcNr4nZ?=
 =?us-ascii?Q?wSecmcW1cnJ0yZD1v2thtZJ+effdl+mfRy9HojrAFFO19R7B2fvB2wIAqOIL?=
 =?us-ascii?Q?2StqMhpK8oHPnhhzn/8VGHlvJmPqv5Ju0D/NIHu8TuDsdGrStEsanH6wrpMu?=
 =?us-ascii?Q?KevhF5khJJPoEgHVCY8AKdxOtIC1yAnwqoB8ipRfVRrgC3KrswX94xqb8w5y?=
 =?us-ascii?Q?Oj2ohtM4UjFgxzhaZLAfWGrylt4LvHbwPcjPZystiw2QNCyK2/G8Y94k4p8w?=
 =?us-ascii?Q?I2ZtbzWZV8L6MvIUTBLRuypVzuLiqn2zAvTKsDcrBsxbVllkmjJ+7ACvrN+U?=
 =?us-ascii?Q?UPHoicbHBjMed/WVGuWiqFW4Tna7HpKe4C1AIYcGrRTNqe5IfyBqobgBTxzP?=
 =?us-ascii?Q?bJfgp8HNwQTNmnr/IaABDB7RgL9qwMusccAESroFDq1+BGyPLot/HdO7yulj?=
 =?us-ascii?Q?yk1mArA6iUD97zs787IDbZdyV8BNbEG8WrAsWklePDpKaWV+SEX0nYToB9tV?=
 =?us-ascii?Q?1ApjFlbZRwVCAKwP1OjH6x1GVg+4LbqcC+mVgzB54/sxig5lC9HbxKRFRUlh?=
 =?us-ascii?Q?d5lYL30TqAm+WJ/EW0qWqWNAknHUWe0mT8ifA+059rzNU5YvRLPY/KKjOGPI?=
 =?us-ascii?Q?Rj9J2GT9b3SHdlmy8mIRkFAIxU/Q8y4F7Anejpc9m6xpaYxp5WZsnydTZO6T?=
 =?us-ascii?Q?WQAPLI5sXpt/F0lPEO+/OQ4mOSen3RnnYAdd8hg21GCSsVBcyRJ+4JadBiMz?=
 =?us-ascii?Q?fIzkK2vFwC4JBEbWasvLlcMyQ8N2V1U4RG0R6VFTnfcnK+YyvbRa3tod/X/l?=
 =?us-ascii?Q?cBw8AlBqBmRqI5jjlEGriV4g5xwTneZrSVrzSgdfsFmQ3NvxXneP6NLGcVU3?=
 =?us-ascii?Q?EnjvNJKqepVfkyxjH/Q2Pds4DL5szEShNlQ7wJJA/LvKORBY0q6Wc4QuugFC?=
 =?us-ascii?Q?1Ia9PERhYmH70Al7Zg+coKAqklRyij8smK3ei5Gh7nJjY5ZA+VlcxFMJcc1N?=
 =?us-ascii?Q?xFsUFywbxvBQB7CiFykIc/4nyyDG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB7096.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rXQOWAUY/Xld38QtPciEgeb1U5/pbKrkG5Hi5x3bpieQOb0NDtwFQth5iYIn?=
 =?us-ascii?Q?abaemDpAL3QjmszireH7I2nxUr8Qz76wwKmacnCn5NOO62evjYw4EsSGPkjw?=
 =?us-ascii?Q?8zWpbMbPMYG6j4ljKboBK0R5TaIuBAF/+rw5xbJuOIPlo15ty8UEB26k4z93?=
 =?us-ascii?Q?8xdBgDouktdfORvKAuq4tvXx/ksiJ7ol8HhCwj2UVknDx4reMJIcUzBQ8QER?=
 =?us-ascii?Q?oNYC3hw2dpsiUGl4XZ2nHqDaPjjnvul06cXvp7ucDEFybQ20O50YbkpZ3ksM?=
 =?us-ascii?Q?KTcbssP7Y1SUaWNYT7SbNPIoVAy6YPlxFAIqSY85L+gUO2VQ1l5/Ltz4AnzF?=
 =?us-ascii?Q?dU3UDbFmJj9aVUkDC7Vcoye8SVyf3IW5UNLNnizQlsPiDgdKxDZbg03Lhwz+?=
 =?us-ascii?Q?tJxHLj15Csmr+3bEBw0Cc2kLz4xi0fg27d+kBgjXA/GqbelBjSYSRUQdtla5?=
 =?us-ascii?Q?V2FNXsTSc+hGhig1F+MCExBe87dvr0zXA8t4xlI03v7Qn1qPzIxgMVcRukiX?=
 =?us-ascii?Q?1L9vOhe9fwGJ2LpOMgV9OQzMPgCnxlxUlHrSSM6SziLlMT+vyhMVbd75nSX6?=
 =?us-ascii?Q?sfzAtRRE4fB2bVU3b203G3vbxqArAxyxX408Iq/Zrx3Zw9MmhmFBnR25sgyX?=
 =?us-ascii?Q?68wUgkl5k7wZz2skdcd/QjGXlxTy2IMjFDLpBaXeLjtuX4LOd8HhlgQ5N6Gj?=
 =?us-ascii?Q?CySayBY60dU9wpIO256IVBE47V+SWmscMu2VGMCE2m0BmHSu7zDV1SconItb?=
 =?us-ascii?Q?mDQ+A6tCplymSHYWnEB39xJf0dBGa3rnmKFKOxiR4U3M/5+3K7YUCgVDbFes?=
 =?us-ascii?Q?UMs0K/Ggo0WYJd3p2rY4osR/NJhyDnkcX67hlJ2FstbhdVBBQIRkSxg84C9s?=
 =?us-ascii?Q?BD950lKaTJ2jOC8ft0xg6GMpfEGOXwf24IAIoKB2k49vMgvwYhfsCsXP8txj?=
 =?us-ascii?Q?0AtF5kn3zVQpJoBmGZFQPLb4SlB/26GcYWpzUEfrrZKzLdeju7yvdtLVxlZ8?=
 =?us-ascii?Q?TpQBWzAjEdShU3oDBfXBXZY4ZhzethMckElVEvD0+/l9ydNuEf26qaYbPrgp?=
 =?us-ascii?Q?GiuSslDC8xYIMxhgNUpr2sNWQ3JvMj3S2aNCfwDRzwoOjW+FkjOSx2B/toBO?=
 =?us-ascii?Q?dV+esWrQDkCRhlX6CTGV48Awsk1rD+FLrtBB/VVramTurfqJ1Xqbdtr1Sw4m?=
 =?us-ascii?Q?ThvqBWyBO+5IgQecu+kUAWmzoq9w3nM7tXsC0zaFK/fs+lBAmGmLZREb6LAZ?=
 =?us-ascii?Q?Oz4W8Sow5RrV9vfQ74kHbIZEO/UZ3NGlqsheF5Jh5CKJQw6MEn5VNtF4xZC6?=
 =?us-ascii?Q?gphnkZU2HZ+EVg1pLm8NO8LBPNROR+YVFjVZ7f2rQxuRG4cBt0CUdIUch3Bp?=
 =?us-ascii?Q?C4aNJHh+atI3IuH89NyPYzdKRSDMK8GpzL5IXgq8htztXIwY/Ucw1qEADEPl?=
 =?us-ascii?Q?B9ARDItBLLrgSXuUvfPTDh5yUlhDHNagnYwOqsoMbkXxsEM8ZtRvygh5eZuQ?=
 =?us-ascii?Q?ZFXrRet6E837zUwktRUz0DUQ92e8nHNEyUkPaLjtIap/v4xnZyE1V5YGN443?=
 =?us-ascii?Q?itj22eop8Le7Zhwe21y6BhJBuAEr85jdhEQH4J3z?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edab23b2-f521-4887-9a2a-08dd0228257d
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7096.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 08:09:20.9040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9B46LiDSLmAOYVIJ+vcphH5G/H2LB7HmZxjZCyukEuD9eVqldZRHnfaBOJ8theqlwTkH4Reok+osLDQQp3Iyog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6783

Once a pcluster is fully decompressed and there are no attached cached
folios, its corresponding `struct z_erofs_pcluster` will be freed. This
will significantly reduce the frequency of calls to erofs_shrink_scan()
and the memory allocated for `struct z_erofs_pcluster`.

The tables below show approximately a 96% reduction in the calls to
erofs_shrink_scan() and in the memory allocated for `struct
z_erofs_pcluster` after applying this patch. The results were obtained
by performing a test to copy a 4.1GB partition on ARM64 Android devices
running the 6.6 kernel with an 8-core CPU and 12GB of memory.

1. The reduction in calls to erofs_shrink_scan():
+-----------------+-----------+----------+---------+
|                 | w/o patch | w/ patch |  diff   |
+-----------------+-----------+----------+---------+
| Average (times) |   11390   |   390    | -96.57% |
+-----------------+-----------+----------+---------+

2. The reduction in memory released by erofs_shrink_scan():
+-----------------+-----------+----------+---------+
|                 | w/o patch | w/ patch |  diff   |
+-----------------+-----------+----------+---------+
| Average (Byte)  | 133612656 | 4434552  | -96.68% |
+-----------------+-----------+----------+---------+

Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
---
v1 -> v2:
 - rename erofs_prepare_to_release_pcluster() to __erofs_try_to_release_pcluster()
 - use trylock in z_erofs_put_pcluster() instead of erofs_try_to_release_pcluster()

v1: https://lore.kernel.org/linux-erofs/588351c0-93f9-4a04-a923-15aae8b71d49@linux.alibaba.com/
change since v1:
 - rebase this patch on "sunset z_erofs_workgroup` series
 - remove check on pcl->partial and get rid of `be->try_free`
 - update test results base on 6.6 kernel 
---
 fs/erofs/zdata.c | 56 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 18 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 6b73a2307460..c1cb08d536c0 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -885,14 +885,11 @@ static void z_erofs_rcu_callback(struct rcu_head *head)
 			struct z_erofs_pcluster, rcu));
 }
 
-static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
+static bool __erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
 					  struct z_erofs_pcluster *pcl)
 {
-	int free = false;
-
-	spin_lock(&pcl->lockref.lock);
 	if (pcl->lockref.count)
-		goto out;
+		return false;
 
 	/*
 	 * Note that all cached folios should be detached before deleted from
@@ -900,7 +897,7 @@ static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
 	 * orphan old pcluster when the new one is available in the tree.
 	 */
 	if (erofs_try_to_free_all_cached_folios(sbi, pcl))
-		goto out;
+		return false;
 
 	/*
 	 * It's impossible to fail after the pcluster is freezed, but in order
@@ -909,8 +906,16 @@ static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
 	DBG_BUGON(__xa_erase(&sbi->managed_pslots, pcl->index) != pcl);
 
 	lockref_mark_dead(&pcl->lockref);
-	free = true;
-out:
+	return true;
+}
+
+static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
+					  struct z_erofs_pcluster *pcl)
+{
+	bool free = false;
+
+	spin_lock(&pcl->lockref.lock);
+	free = __erofs_try_to_release_pcluster(sbi, pcl);
 	spin_unlock(&pcl->lockref.lock);
 	if (free) {
 		atomic_long_dec(&erofs_global_shrink_cnt);
@@ -942,16 +947,26 @@ unsigned long z_erofs_shrink_scan(struct erofs_sb_info *sbi,
 	return freed;
 }
 
-static void z_erofs_put_pcluster(struct z_erofs_pcluster *pcl)
+static void z_erofs_put_pcluster(struct erofs_sb_info *sbi,
+		struct z_erofs_pcluster *pcl, bool try_free)
 {
+	bool free = false;
+
 	if (lockref_put_or_lock(&pcl->lockref))
 		return;
 
 	DBG_BUGON(__lockref_is_dead(&pcl->lockref));
-	if (pcl->lockref.count == 1)
-		atomic_long_inc(&erofs_global_shrink_cnt);
-	--pcl->lockref.count;
+	if (--pcl->lockref.count == 0) {
+		if (try_free && xa_trylock(&sbi->managed_pslots)) {
+			free = __erofs_try_to_release_pcluster(sbi, pcl);
+			xa_unlock(&sbi->managed_pslots);
+		}
+		if (!free)
+			atomic_long_inc(&erofs_global_shrink_cnt);
+	}
 	spin_unlock(&pcl->lockref.lock);
+	if (free)
+		call_rcu(&pcl->rcu, z_erofs_rcu_callback);
 }
 
 static void z_erofs_pcluster_end(struct z_erofs_decompress_frontend *fe)
@@ -972,7 +987,7 @@ static void z_erofs_pcluster_end(struct z_erofs_decompress_frontend *fe)
 	 * any longer if the pcluster isn't hosted by ourselves.
 	 */
 	if (fe->mode < Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE)
-		z_erofs_put_pcluster(pcl);
+		z_erofs_put_pcluster(EROFS_I_SB(fe->inode), pcl, false);
 
 	fe->pcl = NULL;
 }
@@ -1274,6 +1289,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	int i, j, jtop, err2;
 	struct page *page;
 	bool overlapped;
+	bool try_free = true;
 
 	mutex_lock(&pcl->lock);
 	be->nr_pages = PAGE_ALIGN(pcl->length + pcl->pageofs_out) >> PAGE_SHIFT;
@@ -1332,8 +1348,10 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 		for (i = 0; i < pclusterpages; ++i) {
 			page = be->compressed_pages[i];
 			if (!page ||
-			    erofs_folio_is_managed(sbi, page_folio(page)))
+			    erofs_folio_is_managed(sbi, page_folio(page))) {
+				try_free = false;
 				continue;
+			}
 			(void)z_erofs_put_shortlivedpage(be->pagepool, page);
 			WRITE_ONCE(pcl->compressed_bvecs[i].page, NULL);
 		}
@@ -1379,6 +1397,12 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	/* pcluster lock MUST be taken before the following line */
 	WRITE_ONCE(pcl->next, Z_EROFS_PCLUSTER_NIL);
 	mutex_unlock(&pcl->lock);
+
+	if (z_erofs_is_inline_pcluster(pcl))
+		z_erofs_free_pcluster(pcl);
+	else
+		z_erofs_put_pcluster(sbi, pcl, try_free);
+
 	return err;
 }
 
@@ -1401,10 +1425,6 @@ static int z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
 		owned = READ_ONCE(be.pcl->next);
 
 		err = z_erofs_decompress_pcluster(&be, err) ?: err;
-		if (z_erofs_is_inline_pcluster(be.pcl))
-			z_erofs_free_pcluster(be.pcl);
-		else
-			z_erofs_put_pcluster(be.pcl);
 	}
 	return err;
 }
-- 
2.34.1


