Return-Path: <linux-kernel+bounces-298757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3788895CB2A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 13:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EF7AB2214C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E39186298;
	Fri, 23 Aug 2024 11:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="c2MhwvtK"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2087.outbound.protection.outlook.com [40.107.215.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726AF143879
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 11:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724411329; cv=fail; b=CBb3bzjFYbG3iFWvWToK/V77cwf2SyfZEmc718D1CJ2c86PqsJco9GBQsUAZpPU5zug/HF0Mm6mnWLtH5SbCytFgxvfmWK1CjtNG8KG3w57oniEkp4G/mOJaQe2hbFKlvVv9nAcvtWX8OZKH6nksDCah660bjXz9XLVBcn6A0aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724411329; c=relaxed/simple;
	bh=4WG/2GUlJbCtcK9RieVL0R6jyOrC4RvmWuXbhlP/F6c=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fSqO96Y06uMntXesPQPB7gKC4RNcX8PhiKBgGcozRV3G2en/IXwg1g9O6N2tcskQWRPQ8ERJI1g9jf22qlFGG9683KnYevUkKotEw9Wq9TxVN7+ES5vge0TKG5jCQ4R9Mq5J0qjGs9r09VhKoFanmgKbrFFDYdMD4M6+0lKWLdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=c2MhwvtK; arc=fail smtp.client-ip=40.107.215.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IkBrPQjrTNrUf43lvNnTng5S+YC+ISneR3cAe6EU4Ump2F4ZUidSw9xfDR2+MRXSkmKvZUr5HKNvzxVAqnu/uYXDQoYxk7K9V5LySMdv97a8rRWExvFFLXI8fI3CfRHSyEXle5HpluVjBeTNOQ+eTv0ZzzyEP4dBPSnQWNtMp/UxbMoomNPRfUPu2ZcqyhAzDnDhc2qCHASBzbB6fb+8ltBX7OroMmDrU9/6eijReTAMzR846XPOP1fesD6dLRB8znu35WHu9nokD6vYz7EFVCMC0vcssjK8fPsKedx7e/IEV+UsTyhPU3Nt56kz1Bc8emivod8y9BoQyukJrsxUPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhPTkf6yCtN5HuY2CMsD/5hHPrGs8gNORC553GgtcLE=;
 b=XnahZ5ouq93j8pliuncP+4PvhPpTDhbdiOK3kZNABdUVHM3vsaGNGH0UPwausw6RbcYZyjWO1i5yyYQjOwXwT3sFfBBp93Nz2Iidu1WPdQf7Zuvj8xTIgUQ+BltfbC3lFzr/txBe9mvv/7T5B5XwcMZUn6BW3cTEhxZmhA5rCE4yxGYQzb+O6ZdpSIGxqDjSL9zEBYFe+cySppevFHXmSSNaMWMPZPesuXfxXoiHP422VKHv7hzXjkPEfc1kDXIG0cBWMWAKcjhgsRPi3G7MDOr8cNhuvZxZ05isIRH6tU8BgsP5moBk9LHbWPgd8msAg2zCEBqGtHCZdna671NF7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhPTkf6yCtN5HuY2CMsD/5hHPrGs8gNORC553GgtcLE=;
 b=c2MhwvtKEdw8eUs+GwbyR5a/IaIKbr3uaPn3wetlW8gAb9etKxC0lS68YhFm+cot0p4WGX6rvNH5hqsGTLmT2QvWV48Yk2oLpn+OguNL1HuBW0UUL6N3TGit9NHHncScPVzmt24Eeu3rLi7JVASgnYP5fuodrJMO0e/nzkJW4BCk953TfcCWjL51e1/ysnm7/Kht1DrAxDOSrVm60HkfRa0PqL4s1d3PlawRH+KVFDhcQ1QjP2RkCAfiVISdPq0mgfA9ZYM+TqN4jZSf8bp1s3eWUjA9mKl5nmtQoYpvwgY5yxk1SD5ssaTEQ6JEtAsLRd+MIJ++WnEFvbpDV/3T1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
 by SEYPR06MB7043.apcprd06.prod.outlook.com (2603:1096:101:1d8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Fri, 23 Aug
 2024 11:08:42 +0000
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1]) by KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1%4]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 11:08:42 +0000
From: Yan Zhen <yanzhen@vivo.com>
To: vigneshr@ti.com,
	miquel.raynal@bootlin.com,
	richard@nod.at
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Yan Zhen <yanzhen@vivo.com>
Subject: [PATCH v2] mtd: concat: Use kmemdup_array instead of kmemdup for multiple allocation
Date: Fri, 23 Aug 2024 19:08:24 +0800
Message-Id: <20240823110824.3895787-1-yanzhen@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0120.apcprd03.prod.outlook.com
 (2603:1096:4:91::24) To KL1PR0601MB4113.apcprd06.prod.outlook.com
 (2603:1096:820:31::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4113:EE_|SEYPR06MB7043:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f0a89c9-3708-4041-ce48-08dcc363f2c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gcGBr2+f8nw8QH8OmI9MB/ZI7OfigQ4f8pFKrqVVS0UkPf9KvX2dlrUqiEdO?=
 =?us-ascii?Q?wcdAsM6o+JhqhirPAkHZuV5wrjC2L/jdsQyFkKMLzr8RcWul2cVZBkyQwBqf?=
 =?us-ascii?Q?UxsgjMTABTn5ZEPKUEAHsOA6i42yw9Ds2PFI0H22FNmjsDrrFexIqJ4eDt+U?=
 =?us-ascii?Q?M8NsM9qUHtcc2xWhkTUW1YCyG87n1rRCgKfWNODGNppQBrw+id3/BiF69UuP?=
 =?us-ascii?Q?oiX/lsgzDIMnzDMJDi+VnQO5A6tqfOHesR8EmD9d/L/Ctev5IrfbYbu7mdSz?=
 =?us-ascii?Q?Zh7V793N0u7uUQgCzDAJILY0MNCYgdpGRFuTLptLbh/6akEk+BaOfOCtegkp?=
 =?us-ascii?Q?eBfjaM/lZAn+XeAs2dpm2d+QrcKKMjWBN3ksWnJLOzmZoldZhlFBBtmyYzS9?=
 =?us-ascii?Q?KWAP8ZdLSkXNXYEF/04KhtpF3Ybw1PZqLU+5ru+buNxHxosO3/uWnGwyKwQT?=
 =?us-ascii?Q?sSnIILBRLQ6De/AjSSwe5xWDsGJrcaZik5QtYlqNC/haaNw0SBu10pmhZ1Jl?=
 =?us-ascii?Q?7bymr7o6J8pWsmxJL/ez7I2NHD+mPLmcEOeJqzQAiSzab1Xs/XH4IoSGT5+/?=
 =?us-ascii?Q?o8YdyLAGO7RG0vZ7NTPOxyeS13i8DXAUQhiVOzx4kA3V0mJeWuoxONVrvbHv?=
 =?us-ascii?Q?/cZnYfEiqqg3ET7Pv/REjjjpYp5QEmRkQEh+aYBkiqjDb8/dIRxh3Jgdw04i?=
 =?us-ascii?Q?sEAonAW71Rj6ASnGQXTn0DNPkfbUfjJFbZCEBWY00HK94vxiL+4pEw8hvHHq?=
 =?us-ascii?Q?bWxj2k4LB7GqnxE52mUiq+r10qVw7gw+LciPMPlfFgXxUq9unZ2S/cWezVm6?=
 =?us-ascii?Q?tnZak8jU0aeS3Z3FKmX3EpHZmWbZH9qMzSWdI22RZcyKsrC5IeuGoqUPFH/R?=
 =?us-ascii?Q?wXKhwTf1hKOBgxHe4KbaegNDf43YWMlyfbm9Nk4WGlytod7jBf9C1B0KNzl4?=
 =?us-ascii?Q?o/dDOu+i0zVPpbN+tj5cNVJvhnBbfbglLyvzpWDQYLi66z/bpFBK17154KnY?=
 =?us-ascii?Q?/HTrDu1ywTCr1CvqxrRkhmLdPB7IFG4cwBDrjlPaBy0+Jro62F+UVkSyKnFS?=
 =?us-ascii?Q?o/k2c5mpaGbH6ysgUHOArZ/3h7848j5TnqKpgpZ+USlp+5w7llFyHE19gUoX?=
 =?us-ascii?Q?VOUqnJepy6u7xCTOznGkE9OvpMpC55mgW30/wEIRgX3UaJXTcGXjuAhsGafP?=
 =?us-ascii?Q?fZl/CZbOBOWQKqnuoQ347N4xGkKr6IBwiLUQNFYw9AJ+Acriwek0BMyP92o7?=
 =?us-ascii?Q?Uoe8IDls18/2ruRpqhh/wFVrUFMK7gsuWaRBm5RRB6D1LZyUVqedf+L0fU/f?=
 =?us-ascii?Q?Zsk18zxe7ZCD0523f7lMJUdtSYryJ5nmvLJkg9EdnetIDgLt79POB1HBRq6n?=
 =?us-ascii?Q?jmkZ1vAtlbSQRZtjhoLJP7cEwB7I9q+4Tm+T07iR+n6+bhKNSg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4113.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jtYBHmg7u4ZPjaU+pABgSPmxPYUvBM7t6z5HzH8pls2VNo5/TOVF8GI7khjf?=
 =?us-ascii?Q?1pn5RLYhJ7fCmUMYhoDr3CuhErkTvsg1hNkTd5SOwMQzqkvLad7RL/OSPn5c?=
 =?us-ascii?Q?2Whr4Y/a1YDamRRdi8zk9UEQSGtCu5YnC6UrnAelP9DhgxGTdqKI/K2JIDtl?=
 =?us-ascii?Q?n20g5uY9YiLDXqbENN6KZW3rBqipDlstATfpBofi7VOlNE19TvwqLDtExIJ6?=
 =?us-ascii?Q?B4bQhCAgsRcK4WcM4kgsxFXOfID2/N1xG/kNHmnvTOHhwe+Y4qjRtCXUoXV6?=
 =?us-ascii?Q?xKctZ51FoWMAe4p6BpyKMnHjkNEM+IoiB15sTDbt6Tr49sAgakntEGv492KV?=
 =?us-ascii?Q?GfJpGERSyoXBu/ldcRlzRekTdxzz8Vfbm0pe+/KFvFBmsvNEzJ/g14aycro5?=
 =?us-ascii?Q?NCwTw27pHKf/wQ2gPnCKe2InN58ZpN0L7eCYsXFFH9e5UHPJ96j8+HZaapcb?=
 =?us-ascii?Q?1dV6sdOaE25eb7GO5QQnVLBq92IqmokStXJCDQDCV2v4E2OBhpz+CqUNBTcU?=
 =?us-ascii?Q?vcoi91iiAjFKAgFCOwDoh1M3NOWmMBgw3zMBOh+nXOjqKikIPbrdTA36FWzN?=
 =?us-ascii?Q?66q2KNlUZK7e7PjGevwfCNJKs3LSxjB/EOHaDjo/JmSEqnLIhOGCctamBBp/?=
 =?us-ascii?Q?OpemnG5IcSi506uAEs79N8RyIH9x6ncva4UFgAfkfgynr3HFJ+jD4Bzp6DNx?=
 =?us-ascii?Q?PJc7tI8cRkAAHKY+4sbDhnD6Sjq0uaoxejJ8bPOnL0JVjXs13o/WrJs2XVPb?=
 =?us-ascii?Q?7lnw5DcEI2xfcSLpjkqCPMmkjNlKFNVjW6HLW3NjFuV/WEDQ7ZXgI4QifCiv?=
 =?us-ascii?Q?DdZmCoHG9Iqpi305Atbeh+ZiyoGfl2DhW4hwn+2XRVmiPQ6WkJXQ6eywZCw+?=
 =?us-ascii?Q?DJbLh6XWTSb+Euc1YnKn6lZM+pDfo8rdEtF7VaoQCZ6swAnYL/ToILFZXi+O?=
 =?us-ascii?Q?p9agfIKvy2OuPtsdWJw4/EOka+lJko3+YNhsjjS1TnZIwX2udcuJseClUgmB?=
 =?us-ascii?Q?YdFF6vcJNnmHz6kyFrzaYMNopAk5WzD8DbRrYAP1JxS8FujCBk1WvP7ITT7C?=
 =?us-ascii?Q?6T1usSxRpNba5NtGya010x/IsNup8Co4IWy7NGHst8oVvO9RT3rZp8CKDiog?=
 =?us-ascii?Q?qOilCGmxghpoyf/iYKoB0TstNo87RzMJBrgmRjqyySsOzdqrRkGfmnOd9Q0w?=
 =?us-ascii?Q?ncTrz2t7p31cLBX3RGhEWrm1lf2pajEJ0uTeTKz8XtUW9zsCUBe+CpJdY96H?=
 =?us-ascii?Q?4WoSN+dAi0H7GcsyivoSJ6bNw8MSBXzjMzlEdab4IsBWKDg4iVm6PR/rOFs1?=
 =?us-ascii?Q?RMplRfiU1/h1X1XjOQr8qQPha6M4QiCZSwhFaE9ClXqotDpGBDA5/SlCMnVx?=
 =?us-ascii?Q?Z2Z87O3aF4Fk+bQDN+iVoduqcnMuEequEQ7TRrplf3vyaoQjSihry5MMr6Ej?=
 =?us-ascii?Q?9811ZlVA6UM4IDudUtdnA8aEv7Cv9K6rtfCq16gfZgRAi4puNZjY/rqV5rC+?=
 =?us-ascii?Q?9h/13F8L/Sh9i8a3kyQBXxe8DaA61rMJePth2IyxxwML8lIhW5SPREl+YdJp?=
 =?us-ascii?Q?vrsiEnLl5IYzZNNBOf41sLENIKnMIYjTJ8dsfFc3?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f0a89c9-3708-4041-ce48-08dcc363f2c0
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4113.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 11:08:42.2887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6JRjYG9mohbm+KT+DJNYtAFiTFAYExFFbbizGDOJcVmPuZBL5TQ6JqkXaZsfMk1lmsS/XhHg0VUSnLXoxFec7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB7043

When we are allocating an array, using kmemdup_array() to take care about
multiplication and possible overflows.

Also it makes auditing the code easier.

Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---

Changes in v2:
- Rewrite the patch title and the patch description

 drivers/mtd/mtdconcat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdconcat.c b/drivers/mtd/mtdconcat.c
index 193428de6a4b..f56f44aa8625 100644
--- a/drivers/mtd/mtdconcat.c
+++ b/drivers/mtd/mtdconcat.c
@@ -204,7 +204,7 @@ concat_writev(struct mtd_info *mtd, const struct kvec *vecs,
 	}
 
 	/* make a copy of vecs */
-	vecs_copy = kmemdup(vecs, sizeof(struct kvec) * count, GFP_KERNEL);
+	vecs_copy = kmemdup_array(vecs, count, sizeof(struct kvec), GFP_KERNEL);
 	if (!vecs_copy)
 		return -ENOMEM;
 
-- 
2.34.1


