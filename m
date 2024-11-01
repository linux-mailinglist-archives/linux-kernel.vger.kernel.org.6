Return-Path: <linux-kernel+bounces-391746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB57D9B8B30
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 07:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50E971F22A8C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 06:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621D614F115;
	Fri,  1 Nov 2024 06:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="esOz+Cu2"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011005.outbound.protection.outlook.com [52.101.129.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FC414B97E
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 06:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730442204; cv=fail; b=cb2aUeuT8HKDBAia3w9Yea2orBYA5DNa5bWWFZ++nZIZQOl0TBePRR01ySQmhsznhWGj6d30N4vpiMdEVWtp6fKITUTKT/PTBh9QnZr6t+SnWRty700YOmVZefdWNH/DoQlHajMQxoyDMvBhlD+Xi6x+yt5eqqQ5IacVDDjbUWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730442204; c=relaxed/simple;
	bh=c9TyAxXtmYJ5JIq7l7jDafkTbJpnkXGo4Euj431YqOo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CjwbdqAEzT2gDUmojj5KGkNs1FOYDHxkFA+pKyDUzT6VC2oqU5GiKhsxqPzFw9pqXHHg8PHyWgR35ga4h8W/MK6KtFhHhpSw6cgO8SBor3cxq1/kKC6XGV+7laY3C0NECP1mrLNpA38XIjxtTnT88yDkqz39wPtYcsQjorHtZ3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=esOz+Cu2; arc=fail smtp.client-ip=52.101.129.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bYAr4KV8fEM0ywRA3f6xyE8O1ZDySrfUiIJg1ODgCJ5vtG73iU7v1EIx0oI5oVEOOGJ4OtVQcq1U/wiLVsPEhdOTRbi57e+9WId9Z3+cZSP0Vn606TRHvA0OIfZD8UrZf4X6E9EMQw8UaQtPlin9e25dXcXS6f7SY3Qy7NpXG2tj+pJKrUH/Tf+2FMBaV7oiRJmGg0dozHtscy4s/cQnLJk+mnwEd/tliP6YaruUXJMpmw1+atkj0R2gQihrzbDwX6xefTL3gSm66Slxywfdfhncs/A7vLK9GxYBjS4jhJyV1uPbyVMOtD8FEiIbrz+KbezSz07pAjmJ0aQXIVLVnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQvtpYf1KpqcRspL1OOTT+H7WJ1YUuLuXrCyZo8EHKQ=;
 b=HEol03gd4ms9NIpWscD+9QcEloS3EijVPpS05/IFKSJWs6DRPmlqtSyl/rvzWglcrvq7U1h6cTfVnl4Dj1CX0cgC9My7PT1XPYqZIHu9n+edWZxl7MdSz+jpe4pIuB+7TQw++uuWd2Re+82Ubi3z6uVPjYw0f2JYLcHk+6cCPZoC1iMEV6TU8vdk0M5Hmt8w3Bt5icHQauxEy+cLyTIXgdJp/t6IXz9jHE8CET+cxdThHGHWWlqdfg64zELt5nM7t8s0W/b5WMTATS2MvqBpE8ncltuEFgQGww6Pi+a5qkSNFYTsbacj/pVe9hn4zhtvtKN4xIIX3pLL/ewVZ3Ke/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQvtpYf1KpqcRspL1OOTT+H7WJ1YUuLuXrCyZo8EHKQ=;
 b=esOz+Cu2UR+vfylt654UqfHORQ5lYrsQkAXyEUyJVXaygxkUngHUG9fY2Z9lrWIFINwBUHYqlWrYqUygmG6MzC3+RIwZuhKdF+3N6Zl9mRnoFdTeSl/84toA4F2CneI52pQP5Cg2seOXc4wEQFYMUJdde5C/kL27TLuSC1Pum3YnYBtATv5HAhi7Q7gR3e1/yVsQx843jqau5igDTVwhjfHhCCaYLq8ItPEYRPpyBLZT8VU/fhwSI38rntkTFInnY5qHBv0jwhFTgYH0TnLcFRU1DKieZxLXb5WLZGKoryZTaXwDTayzNcS9YwkB5iMkZ6DPl+DeMy4U3VhCKbdq/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com (2603:1096:405:b5::13)
 by KL1PR06MB6321.apcprd06.prod.outlook.com (2603:1096:820:e0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.12; Fri, 1 Nov
 2024 06:23:16 +0000
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b]) by TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b%2]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 06:23:16 +0000
From: Chunhai Guo <guochunhai@vivo.com>
To: xiang@kernel.org
Cc: chao@kernel.org,
	huyue2@coolpad.com,
	jefflexu@linux.alibaba.com,
	dhavale@google.com,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Chunhai Guo <guochunhai@vivo.com>
Subject: [PATCH v2] erofs: free pclusters if no cached folio attached
Date: Fri,  1 Nov 2024 00:38:21 -0600
Message-Id: <20241101063821.3021559-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:3:17::23) To TYZPR06MB7096.apcprd06.prod.outlook.com
 (2603:1096:405:b5::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB7096:EE_|KL1PR06MB6321:EE_
X-MS-Office365-Filtering-Correlation-Id: dda2d886-21c4-44a0-f81d-08dcfa3dabf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R3GvzyzIY0YqIBeyy/MXXLx3MvX2CS7knMXztNAgJNPfAespsaNhF4bwB5w5?=
 =?us-ascii?Q?FHJAdcth4uGfU9ohIX+kMF073lOR1CE6atglFTvYj1ex8X9LrHI0XpzNRmbq?=
 =?us-ascii?Q?vhPoeePB7LindOf21r79E84tiLlpyo63lqXUdSpunfOZstji77MS5QXIg0gs?=
 =?us-ascii?Q?rJmZc5B3K48C2Ige6qwMmS9cjhnEGiCpF90/wxKvDDdA5/qHq0ABIchXupDE?=
 =?us-ascii?Q?c4Uqu7DVouxid4G3/G6LW7kk8mFKYH7tDTfbAc8+dIZXGXple3uSKvCVt5jZ?=
 =?us-ascii?Q?iEu25DiNrT2Zz/4y6x8oCFvYUwc/2qpy2T5Fk8c6RJ4atNv6TU0GWd7KLBSC?=
 =?us-ascii?Q?af3+D0uEV9ZWmSRZsi9d8agUIZJ7Aqp5ugYYm4hL99/JLg3u8ZDw8OQHONaf?=
 =?us-ascii?Q?wI9jcLBFgl49vv+UmzadG7hre76DJWcxivzu5/bJTbcHt4A/VblvFjM6GT9i?=
 =?us-ascii?Q?inzo49ZXrxEdHixeHROkGRlEk6EfyqieihsutcM9Rqq3e696lThxRibWwUBw?=
 =?us-ascii?Q?1T6Js7qnGN1lX0oT2xH2zk+LWVnzuU2ohBeXGGZ6Rro4wlPm5WAp5sdQO2Dp?=
 =?us-ascii?Q?WSDYV8/9WVyN6VUst31tHFt0HHXFQOgq93ZGaF2aYALyE3rXajcZeveLbZHb?=
 =?us-ascii?Q?diI26pX23Q+ius/OqfUesVwPEYSgNj+uVXlB4EPsj+Il6D7nT74onjotpM/H?=
 =?us-ascii?Q?bXcqZPnrOBun/JxJE2F977gm2UX64i0DGPfaNiPkKotMMSf1y3jrjWhf/d3U?=
 =?us-ascii?Q?LqXgCa5zTOjW3AqBD2fhObetToRHGvkNvTpupnpiWg64zycXPV0gggt3nFcm?=
 =?us-ascii?Q?qRLBHHXqR3KEr3MfeM80fKfdnk8A87iXR3DY1qRlJwqKyoMeHQuFD7DxfDOJ?=
 =?us-ascii?Q?C07NeltjnAjzCHyo2630nG/iHz7xaTv283B/L+W+k9eXuZS8n3MYQjVQO3B4?=
 =?us-ascii?Q?VbqXSDXwfNQbp64tqpZtGmGzuyJWDpRV3fa8SOvn86j6Bf9eaDnYTo8CKL83?=
 =?us-ascii?Q?D24VE+zuqUvOJU6Se47egDCzH8Q8M5CCwJbpzpivnwxvN0iQsZL4lEQELcl+?=
 =?us-ascii?Q?2soM5bdIOr3ZqXOpViNZ7mQTmBvuaY0UiUrYQvx5aPel8ADfJBI8cuecq7yw?=
 =?us-ascii?Q?eMdPePtUdpI0IW4HB2KizWz1ReobD0TAxvBAXK/v6Sdl9Ldq6CmaTxY0MpCm?=
 =?us-ascii?Q?TPFcCLsL4sIP11I+YTx+owKop5c0dYuyMrCxTq9yfNXO/dnE7PBg4Abbpq7U?=
 =?us-ascii?Q?V0T1GTG1CiVi9FbpeH8JEWD3g2xtORVYMFidu/HOxUaS+DS01cD5OnXy9CZ4?=
 =?us-ascii?Q?CT9xfQWKIA6aLxiDJHBaIhEGIgbJXDfjKHQ8KfDNfmj1J2SDwb25uqRW2fWD?=
 =?us-ascii?Q?aWM3sqrrHVb6cpdWvjdBT20lKNOO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB7096.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RrMWwl4UUS73KbO9nbnsI37TTirCpangyv/SarrZ035CYGLxW3oaobWQl4Qu?=
 =?us-ascii?Q?5K+KESttzNseI9xJ2esu4y/lWk7/wz7S+YasYsGYrcA5HH2OqBJ9dKfFUA//?=
 =?us-ascii?Q?iHVkpGKbJ2Vo9ukbRs2GPvxapKkDTyXvAPy9SKSV6dhWE/Dn9GW9V1vb7WZs?=
 =?us-ascii?Q?viS8q+Dv1wuniPjyh6EwQe+mlK33y4xlfiJjrUVm3LCpfZDS+ANir2cas+9k?=
 =?us-ascii?Q?X9/L/TQLZ644KU3/Q/312RFiQwF7kkJXt8MjTZOvjgxycg2TYs98E6I9+my4?=
 =?us-ascii?Q?FNYuF6HojSrenkNdbm0UKS0F+f94/lhLoHrhsBRkS91jaxj1ICY59s3WzQGZ?=
 =?us-ascii?Q?D/kqLnZM2/FspCXR7bO5Sj30DFSEDMrJdGwYMszbb6tR0fQNR+G1/CPVY7mK?=
 =?us-ascii?Q?jXE7F6RHJXRWYayCdl+If2RbSRgQJBQmo8aty8zaZJyxdPgeVTcPE16x93V1?=
 =?us-ascii?Q?6eL7wqb+rL2t2gxYe5eDw/8pWv88DCj5PkKv+mp6Xn5Wne3bUS8oJUwqAvTt?=
 =?us-ascii?Q?kg5xD4knhSuB7RfNSV7fciJtBm2YYgFzgO4xxhOcloKJ2i34nZzkgIlVNh6o?=
 =?us-ascii?Q?eqogL5qPcYY2V8M5ny9KMWXYL6C9MYCeFANbJVvKplYQSz63PtNra5qjbuTd?=
 =?us-ascii?Q?HBaSahLzf1Vn9WZvuVyzmmzxOG3wMvASpw/JjUxXFeVlBrvVd1wqCT8MkxP0?=
 =?us-ascii?Q?aKbC/JwdAkLixHso6DMuCmia78wt0Pb+Ngyu08z5dSGxcJFQTq7dwJbqwbQb?=
 =?us-ascii?Q?DKC/6z88WKY3XOAigwoXSupSovKXKWVpPy5oo2LWTmNiQCVC58PNjAGXUuhy?=
 =?us-ascii?Q?N4ZHdU3GQv3gMXvc8oXXW6JZ8koOSNkNXKq+iSNLKUSSbxeb26ZLTUbpDdIJ?=
 =?us-ascii?Q?hZD58eIPYlVgpsBgpi7+1OH1wkqhBQwKUaWUc9Q2B2WQh+YjlqJjmlAH35eo?=
 =?us-ascii?Q?d7enavqUKZaICIzgWPLZWGV7ut/9WqxoqWySERfCoAX2hL49I/+Rc3ZPFkEc?=
 =?us-ascii?Q?a2ng0+T/F/KOxn/G3zkCV+8ae2FzlqRZTCA8k23qlDmU8aUuztUV50SWlHEq?=
 =?us-ascii?Q?i5LZ0mHnQlCzhp6jGr6u2bGpRr0MlExXNZcKf5Ox1jumdkSsFhH2GmfOiP7a?=
 =?us-ascii?Q?RhVKCe9MILzmPqlS9oTuR424fiqENmNkbMHESp+9vOcjcVVwPIk59RXW9Bw4?=
 =?us-ascii?Q?O5QGxdFTk8ciI50LVE2V1rXXySIKEuEX35u8vW0dNNgkqZeATofF0xreeaVA?=
 =?us-ascii?Q?XCz4pstDGvWJPEKGXTMJSAIa/rKJ3RffVCNfz2oLh7bl4/wJvBqaXT5yNqn8?=
 =?us-ascii?Q?uLQm/41PxqSVDDk72suDDpWlyuI4ETLHxuXaxQsF8imzDdBkAHsIzT6PBmny?=
 =?us-ascii?Q?4TkjcFxHpG7shAt2h2D3GMb02oPyk368zBJVeFNAWwqeNooOUTlKvcogchCz?=
 =?us-ascii?Q?M/8m0KhcsnUSh/g1ttqGvjUdi0MmBoJH7Cd0aDvErVK09mqkEUgLLJPY+dBQ?=
 =?us-ascii?Q?nQKiP9xwnFvwGCmBlm08eWr1vJs1PhYB7pU2mSqX7T8DjRiAdwEjgOPkY7Xj?=
 =?us-ascii?Q?lGsGYFW7BF9OBMKQeXfpzCP50GnGMCi50IzOCOyP?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dda2d886-21c4-44a0-f81d-08dcfa3dabf5
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7096.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 06:23:16.6701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HiAlmyD9Z+kgpQjwavTXLEEgVuMN/jfb/xYrvPcUPobXLJOuGoNFlSohArklEz4FT1IA40kGVMBDJTgqoh+bDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6321

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
v1: https://lore.kernel.org/linux-erofs/588351c0-93f9-4a04-a923-15aae8b71d49@linux.alibaba.com/
change since v1:
 - rebase this patch on "sunset z_erofs_workgroup` series
 - remove check on pcl->partial and get rid of `be->try_free`
 - update test results base on 6.6 kernel 
---
 fs/erofs/zdata.c | 59 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 18 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 4558e6a98336..1a7f56259f45 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -896,14 +896,11 @@ static void z_erofs_rcu_callback(struct rcu_head *head)
 			struct z_erofs_pcluster, rcu));
 }
 
-static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
+static bool erofs_prepare_to_release_pcluster(struct erofs_sb_info *sbi,
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
@@ -911,7 +908,7 @@ static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
 	 * orphan old pcluster when the new one is available in the tree.
 	 */
 	if (erofs_try_to_free_all_cached_folios(sbi, pcl))
-		goto out;
+		return false;
 
 	/*
 	 * It's impossible to fail after the pcluster is freezed, but in order
@@ -920,8 +917,18 @@ static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
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
+	/* Using trylock to avoid deadlock with z_erofs_put_pcluster() */
+	if (!spin_trylock(&pcl->lockref.lock))
+		return free;
+	free = erofs_prepare_to_release_pcluster(sbi, pcl);
 	spin_unlock(&pcl->lockref.lock);
 	if (free) {
 		atomic_long_dec(&erofs_global_shrink_cnt);
@@ -953,16 +960,27 @@ unsigned long z_erofs_shrink_scan(struct erofs_sb_info *sbi,
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
+		if (try_free) {
+			xa_lock(&sbi->managed_pslots);
+			free = erofs_prepare_to_release_pcluster(sbi, pcl);
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
@@ -983,7 +1001,7 @@ static void z_erofs_pcluster_end(struct z_erofs_decompress_frontend *fe)
 	 * any longer if the pcluster isn't hosted by ourselves.
 	 */
 	if (fe->mode < Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE)
-		z_erofs_put_pcluster(pcl);
+		z_erofs_put_pcluster(EROFS_I_SB(fe->inode), pcl, false);
 
 	fe->pcl = NULL;
 }
@@ -1285,6 +1303,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	int i, j, jtop, err2;
 	struct page *page;
 	bool overlapped;
+	bool try_free = true;
 
 	mutex_lock(&pcl->lock);
 	be->nr_pages = PAGE_ALIGN(pcl->length + pcl->pageofs_out) >> PAGE_SHIFT;
@@ -1343,8 +1362,10 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
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
@@ -1390,6 +1411,12 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
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
 
@@ -1412,10 +1439,6 @@ static int z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
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
2.25.1


