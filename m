Return-Path: <linux-kernel+bounces-405098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D2A9C4CED
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 03:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 372B9B22311
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 02:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B115204946;
	Tue, 12 Nov 2024 02:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ONBBZQGZ"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2057.outbound.protection.outlook.com [40.107.215.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFFB2F2E
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 02:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731380338; cv=fail; b=SWxIi6vjomRH1V8M8I9iW+OVrUufWBRjMRUEfCNawvp7B9KV6NWk2lTwYXTM/oPdj1ull/i+D2CleAQPAQksewGExomizuF482/DFt2Stvb42Avfxb30XCu5VgcsbvG6eq8Iw7EHkGkCq7J3QKMHEkOrU4DPio4QAyYrcfhNx3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731380338; c=relaxed/simple;
	bh=v8BYzZy8H3jbH8DVURKFHwPAQIRpsFshcf8J4B1v4tM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SzKxKPkikslZltZ1AF3H9qVOrPxcCDQ5Qj9wiwlZr26GaAJRulxVrGCImdYugQpzJzRD8YZPCwKRg4E8Th+CoMg1LSfv0cEdjYGfDg/eYJWzKHDktW7fXNmJ7XxUaKoRPeq8XDIu0fIfnkAM7CmSNuFHUQE4eepOlDB4GBL866c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ONBBZQGZ; arc=fail smtp.client-ip=40.107.215.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/HQoL69loJ6tzv4WyS+pac86RB+x2VSHp12VXrdrifYHBahZpnC2Y66Ouh5NNdILzPIvI1mUoaY7F+aBYE4bJUMqFllnnx7/Sv0ov9jfo9d8fpbKdTRCqGWmp3T2VivXe9t/f9Tlk4GcDHqUKZUgEl5gF9A72jtFQXdthuEk++uHTb1v0fjgmlzS3O9spwAzdDAZ5//V9qdOOG5YiD1HDmoGT12horPyyQg9IyRF/2YXW153M1fXWNvowmF/2OylYwxaIVGk8pccriW8wre88sWUz/xhLF1LXCiGS7FmSCjrAl9A5EtadNz7blozYTYk2CiYnmpdELOVIKAmGBZ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFQbfLXLMkaJavXZURiEJX8pgkcXJL2Ume6Cwv4OISM=;
 b=c3ZvXuDXwXFcNb6VrsKCNhHH6E+ZVShe5rIT5O1kQpRt7p7TPh8M5t40YG00ydzBPd1tpgLVcmjMXV5cC8ok4rrMGILGsxGbadwqbabTXQYOZi0uWggMK0Y9BuJJInXU1UygR9pni0dJJogPzaBWd4Dng2LR7kqQVcDAfzUC9noINTociuyHR6Us/Kqsp4jvXrnUu56ii3ohuyOtAlKKf4itODk1aJ8UyltJV59XaGwFtL9g3UxA8qmVHOmKqQdCJh588lY8BMyzveKdBNCsF9J6dkFPZaYxu2EMi9jjW9XJGkJQ9hKVVsVymIRP6qZYzF4vOmy6l2DBrntYTCz0CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFQbfLXLMkaJavXZURiEJX8pgkcXJL2Ume6Cwv4OISM=;
 b=ONBBZQGZqSO7Vs6hupQLxlYZppSJ1vq1LqL+4IOe/hcMtrJOzqWLn2NVIbL4hi0I6JaDCNryqIRwWG58N8sopOWmslNsSGpXs6/8594zAWK3KvXcK1ZkMAqQGchWjS4zwgzV8lrMUIpeejL0OU59TBKfBuGld9oX44CboU4KWzMwro5/T2yZehxD0c61G5rcfTZqJgmoVkwkLc3uQdjOY0iOIYoKcXFNvxFAjtdmz8i8CVwsovcBz//nNHEo8vT1lXCd/6yQM/pHK1/pc5305ueOnLiL/MLBZiHvVV02WkwHCWYVomGk1BYTJudRtNHoXNVTcXGovXDp4AgTe5Tr6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com (2603:1096:405:b5::13)
 by TYSPR06MB6695.apcprd06.prod.outlook.com (2603:1096:400:470::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.15; Tue, 12 Nov
 2024 02:58:51 +0000
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b]) by TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b%6]) with mapi id 15.20.8158.011; Tue, 12 Nov 2024
 02:58:50 +0000
From: Chunhai Guo <guochunhai@vivo.com>
To: xiang@kernel.org
Cc: chao@kernel.org,
	huyue2@coolpad.com,
	jefflexu@linux.alibaba.com,
	dhavale@google.com,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Chunhai Guo <guochunhai@vivo.com>
Subject: [PATCH] erofs: clean up the cache if cached decompression is disabled
Date: Mon, 11 Nov 2024 20:15:13 -0700
Message-Id: <20241112031513.528474-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0207.apcprd06.prod.outlook.com
 (2603:1096:4:68::15) To TYZPR06MB7096.apcprd06.prod.outlook.com
 (2603:1096:405:b5::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB7096:EE_|TYSPR06MB6695:EE_
X-MS-Office365-Filtering-Correlation-Id: c4cf2e75-9d68-4a68-6e75-08dd02c5ef47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QZT+0owaTK7D9kJMukaYR+pu4wBdDKnbdOQQbInOCA4IsnlPVQ/Gyj+WZ0b9?=
 =?us-ascii?Q?ad2870Rs583SLAeeVvvfuLoUKwJYoTVvyS03zwGyKZy4yKBuUzUajdTRQb7z?=
 =?us-ascii?Q?Wh2vCeChk2dgdEpmOsnrInksu+3nlxRWrsIoW49FoGQqCRlV1BJpTFlMsCdq?=
 =?us-ascii?Q?IYtecJjnSASk1t2NSYNuP81ANFbPhND6ms53nQRzXGT2t7i2MxnaiwpOAkCL?=
 =?us-ascii?Q?FZ6P7USCvUmbhkQhU2XzPRIDDq9w4Gz1+SLGyo3zggb4uLQk0IsskeWlbMN2?=
 =?us-ascii?Q?Bdm+HMZZ5W6OBfKgZs20wb5vACU0ZL6oZRiMukyOQJlgm+KFWNjFlmX3IHLh?=
 =?us-ascii?Q?j5bYddQvbiW2Wi7Wn/vh1uJBw8o9JjWD6/QwlEfP4IvcSAKmHkRabiuk1lo6?=
 =?us-ascii?Q?oTNiURjEh3r+cuS8yiAe91EqqFGBXXo/kzwCVDKgtd0tQ0FbUIOHyx3KPv6G?=
 =?us-ascii?Q?Dm11uGftUUJUg0EtrEO6R/KghR87BlPdfY8+QMws+uT26bMJAZRZimpIm3eE?=
 =?us-ascii?Q?fmK5ipWI9SYPM4smnBFtP+jejGjmmQ9GKiBsRig8XXxa1MDuAeSdM4J3+1IM?=
 =?us-ascii?Q?fnyMRFNBhHsFychgAt0vQxxls9V7kyCoFvFwRhv7FA2z21LEC44u6NpMd9TC?=
 =?us-ascii?Q?6dsRCXXu8tzpqBglzD+xTyqpce70kv4coqDWZZlXQG7sfks1YTxjj0CcxOFP?=
 =?us-ascii?Q?4yGW/pSUeIHFkaX9BE5DWZ0+8dwalrX3aNyHgWPqNaYhCpep+LDrZbpsb6kZ?=
 =?us-ascii?Q?UNH0MvGIvFH6Q7QIDcDQnZ5DVjDa8IhT1GIMvBgXLOphpNkHqAICKscV3Sq9?=
 =?us-ascii?Q?8Zjc87OkS3LfPe0ro8jXQr6TDPr7ZfzghjWSZFF2a8Ixqfb2cV2ohbvfi0HQ?=
 =?us-ascii?Q?PBAk7I2msRq1c7fP87IWHGdEiD1O9Ddra1Ml16tPhyydVepwkqmV5pmV33mJ?=
 =?us-ascii?Q?ejL5IZl+mqAF+ZfnSmHj8iq14tBpigRUeVoh2SO+Kxt4mDAQeJYtX9HU6n0Z?=
 =?us-ascii?Q?JdQYH2BEDQbgAWI+jScCeIovcdCTGbDmq/Neeru/DeZgU5vlnvmrtt3Xhfpf?=
 =?us-ascii?Q?t+OQhoeGM8X7zpw1tBuaya88K7rl/cBz2wqLs+ZZyj/Z4N2D+S8A0Kr446ST?=
 =?us-ascii?Q?0LghNENsmKyGYmdDx0LKXPGsqOrqWBKqSobFz4k2bFsNPyqeMlaIpVUhslAL?=
 =?us-ascii?Q?Pn5+DMq4pcZ0EK8zbiXQDRfwODDaYb5cphLCUOYKqWGBsIPEyl0SWBx+1Lrc?=
 =?us-ascii?Q?AajqknD+5/IZ6Is4YYxl1lGczzfnPHoXvF0zwPny1F+a+hNwsBNMQTPMzHxm?=
 =?us-ascii?Q?wLhEbmRndld/Ahh33hNzc7jEf1rFm/senD1Jg7smkQkQdRQa13BMu50iWLbc?=
 =?us-ascii?Q?OxYSv3Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB7096.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gTkGHZsRFV+oqqRMxBsjUk2Mp08BkptwYFwlfXJSBlVtGz9jIFqAIRdyc5zl?=
 =?us-ascii?Q?DhiP/FKJ2kbbDr/ZJqXW67n1AslY5T2eqitz9RIEnjFp9Ud1MvzwECSpta7l?=
 =?us-ascii?Q?tQJGPxC3a4fAzgx68VBQL/c417igBvH3zp8ohNj6A0ldSPu5qpLls8VU8KjR?=
 =?us-ascii?Q?+zOB/DcyhVqkfb6Kc292BLfs0tadBxnmcE79oxNtgsE0GeXP364l/PEaAHQR?=
 =?us-ascii?Q?xNbTgI06lu7FgYwzTzHfaDN7gyHZPFSjUpbezKcguNhilmYBSmHsYurOelpt?=
 =?us-ascii?Q?veWMmifCk8FUbmcA7By1ZJTy/2j+u2w+mdxsk9Bf7+5nt7yxEtO31O3j4lf4?=
 =?us-ascii?Q?mO/+gX1VkAtHhTOKE56I26h0YYK1cf5xC3BQ101Bon2h9YGpY0zb+vHqNhtG?=
 =?us-ascii?Q?KQdZwz8nLFfp4a2ezjmiHpkaXKHtCJPhRxHSPTb2k5Fc89oGAtxAsrwJj0f5?=
 =?us-ascii?Q?qd/J1pYzx1WAZD5hm9S7rKdAPzLfHU8iGA5QTFYsRxcxH4Dp9bRN966CjT4a?=
 =?us-ascii?Q?bw3HWy3l074FJXBplWHpP1zP+WShPbnjjmPNA8r1Mj/ySo1xCVFwAJ2JhIKa?=
 =?us-ascii?Q?JaeASTSEzfpX0iO9fZbKyEdIx7wh2jzFU6VTb8WuGKxiVwgv2FdWDvRuo57i?=
 =?us-ascii?Q?Ua8jcCVMwRzE+p6FHr+v4FNJMaiphGyQd287e+TAFjflJ60HFmzpKvGvaEj/?=
 =?us-ascii?Q?jJTc7UQ9faKX3ajMqiC5ktGgHVtVTlp6C8addz0qy4vGzgJW7MJ8KaLSQkkY?=
 =?us-ascii?Q?PEnKLslOq8QwgaSdWKFp1tD8WEScSaI6eeujqC59UcQu37lFnN8zxw/EMRcT?=
 =?us-ascii?Q?4kkpxHs7NE0PSAv+Ye/3Fxygu5dJ84XIool3e1u5ZByc0GrKZmgxpWm7kY5a?=
 =?us-ascii?Q?j7AbvsIYMwKV9M1aWzn/2zVifMSxfAOQcAELUONZzrdxDwnlHBP6VTQZ3h4c?=
 =?us-ascii?Q?HkxJvZqrU2DpiE1pHwvTQ1XEUKp9aKZEMHlbfDvI1ljSCy3mSfP9+EkfoO7S?=
 =?us-ascii?Q?l9Eb/WQ5vxsGHNqHiE2PE73989rsSTE0+o5c+JkO1wmGFhV5xMnzrlT1eU4U?=
 =?us-ascii?Q?elEm7lRRtG/YX7nsWvOB/st30+r+vwTLY+1bOwICdsLpZWezxbYVGJHIVZgO?=
 =?us-ascii?Q?vJzzZ8l4c4RBp4imoF4n9vkt+fjGyXyxWOdLBe35Vw4gqjDUyCmVwOlyxM4B?=
 =?us-ascii?Q?YbxCAeFPeaJVpMQ1XCjgL9kd/3rXxPX8WrYOqgxXl6r7sNuuEtZyBKnRgG1J?=
 =?us-ascii?Q?XSTdDv4TP2sy9lm7cV376OhXQNCAa49RlfNkqW27KPdCj8UbMSWP4VCdueXu?=
 =?us-ascii?Q?Ugwmp+x4NYVk6dt0MK4fpSlQdeMg4Sd6nsSP+6AWuzymvxAS3+YOt07A/Ags?=
 =?us-ascii?Q?Uq6wKtV51Iubc4BDSMlu8vGVRLUTeEddJCDNfzw5Ev9XyWQWhmzv3vY+ZWyH?=
 =?us-ascii?Q?KeKfNd6/9qRBrtPBbYRAitIT68uEiJmNArKnGhYnHhNnEoIMuhrli6Nmq2/l?=
 =?us-ascii?Q?8X/LusfcWVHPFYxY/MJgTeQfD2CZ0iLt1vdt1w8R/nVFG9boBZqzAKFE2Ln5?=
 =?us-ascii?Q?ODwIpKR7pMz8vImm6sqGtvt7sFC1lzWBe1w1Vrpa?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4cf2e75-9d68-4a68-6e75-08dd02c5ef47
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7096.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 02:58:50.5509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OK4O6r5vXQSTtmqCH0mRY34ZvC7Z+udNX+jKoQySoO/oflI9RXNhb1usHnCI6WcQR90kWYnujQh9pP8zngCYtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6695

Clean up the cache when cached decompression strategy is changed to
EROFS_ZIP_CACHE_DISABLED by remount.

Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
---
 fs/erofs/super.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 320d586c3896..de2af862e65b 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -743,6 +743,11 @@ static int erofs_fc_reconfigure(struct fs_context *fc)
 	else
 		fc->sb_flags &= ~SB_POSIXACL;
 
+	if (new_sbi->opt.cache_strategy == EROFS_ZIP_CACHE_DISABLED) {
+		mutex_lock(&sbi->umount_mutex);
+		z_erofs_shrink_scan(sbi, ~0UL);
+		mutex_unlock(&sbi->umount_mutex);
+	}
 	sbi->opt = new_sbi->opt;
 
 	fc->sb_flags |= SB_RDONLY;
-- 
2.34.1


