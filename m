Return-Path: <linux-kernel+bounces-295406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 623B7959A91
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16449280291
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753A51B5EA0;
	Wed, 21 Aug 2024 11:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="EbAZ41TZ"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010056.outbound.protection.outlook.com [52.101.128.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0A81ACDEC
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 11:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724239610; cv=fail; b=aq2N39LsW/qRFqSoT4IiLxf//wvi3LNoaQW68DQREQxHU7ZdfMqkpnMcAob6aTorbYR6O3llB1IQh6OH2ky0bnX40lTEJ7HN+U9EBCyg/NibY+Tz50sg+q8KUSFEFEk1rtH91lIFgVQW+Htqq7Xwd/z1HHubBQEr7pRR6HWmLK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724239610; c=relaxed/simple;
	bh=kjNnuds+JoMYsSGxiPDr3mEE0PBomxyiLlASTkObUlA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=TcqVjYMaPAtWHqeS9RLTmsyi23zF1L4a/ZWt9IdZaJdZHbwWfBhPoLn9pDM5Dxls8SGL0jdsEz1nQSzmqsfXkwYbdf48r2GmdzqJ84Z9MGUn2fuxePYNrTvJrA9Z7JJutTq+G2Brw30GCOnVMlb+9b8ZnDHaWYti2TMDlR0qq7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=EbAZ41TZ; arc=fail smtp.client-ip=52.101.128.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=frds6RhpNklm3en6elygyA3bSso9enaVO3JcEkLP8UjHsLYHuzHfZKe4ARhuryUFQPxD8KjK7OZG8IVufUIQn3X4dh9KHuf0VBjd0gVRIl86gkPtVqqUusKfa0vX9IywPx0hjwhOdW47j950nFVL6wHjXjeET04+MuaSdcSAO7/JAf2nxdnVV4o29IcTQFNzNCWJNygIpkSPK0UPhBp405HFLSF7KrlTinATfKwGrERCA5FEHpDkrwSf+bOydP6jZQzX12vMZNwXTv6My2K0UQOmqmQKXuoHzcpbCjt5OV6nkZsFOpWWeXQEeI1sypXH7bMFYvjzD0q89r3ITgnPGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLMbB3OFIk060plPKR0e4ikCwI4iLwwQStE+homhY9I=;
 b=sIScQYIqSt1ByrHpB4TqRYAv68L4eiMNvHajjBGG+ItVzphQSjnOJ6p45nBWedDqjf6OkV5SbhT2Ds9aUBFp4Q3KP1GjJYjzCseUcCaNE1lxEsZaqzX4RB7ofJotxvZBS+rLGqCbWGKsoqv2V5C44v/H4R5r1FtrNrA7ESl/BbDR2q2jIyNq692mLkYOHakFfWI6SyyrpZo3eDm389V8x6ZrVHZLi3muuyVw/bXWMWhOkXLaZ8m/6QRUE82vUWBIL/ixVA3RuWIdVA68B2PcQvTp6QIYrmizvni8McrwhbbwC4D4E2Phs+NMKJhbAlZWSke9w1h2S6H6cwTM8u59Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JLMbB3OFIk060plPKR0e4ikCwI4iLwwQStE+homhY9I=;
 b=EbAZ41TZpGQgVaWC6WTQHSfzKlBAe5AKWbMV9i7/1pNurIyE/xgAvtC8Hi/tQQpVqtIqRggraxDjAuGduM64kbvFwPjbCVV7FhHOzfBfgvTbvaCB6R9uZRAHyXgqhW3xmey9NdUH+ecEtUptXIpp5ZV8EfLx2HSNfwQv4+X5ZXi2JECh8XriEEH2AfdVChbVVxZ0SMTj1gjxtg0kEcHssSCsgj98LzD9SIOdlQLp+wbMlx4fHUJ7FPoiyr8KEc7xflqGpWbyXraHPOzF3q5R5ri0z3FHWIvpaWVW+2CB8Ai7JGCrSyZn4WrRVnz71xku1H4qUfY0dKjguVX9GGp0hA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com (2603:1096:400:82::8)
 by TYZPR06MB5028.apcprd06.prod.outlook.com (2603:1096:400:1c8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 11:26:46 +0000
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70]) by TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70%6]) with mapi id 15.20.7875.023; Wed, 21 Aug 2024
 11:26:45 +0000
From: Yu Jiaoliang <yujiaoliang@vivo.com>
To: Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v2] platform/chrome: chromeos_laptop: Use kmemdup_array instead of kmemdup for multiple allocation
Date: Wed, 21 Aug 2024 19:26:29 +0800
Message-Id: <20240821112629.596298-1-yujiaoliang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0273.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::12) To TYZPR06MB4461.apcprd06.prod.outlook.com
 (2603:1096:400:82::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4461:EE_|TYZPR06MB5028:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f675e3e-e296-4c82-2a50-08dcc1d4237f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lrAMQoiYgx/p06QidSkCexVduNeMTTvAD6AC3SMaOCKqmIHpB9WkA7KGwDfH?=
 =?us-ascii?Q?kM+XleuqDr9TF8vVwILf7j/+m3WOoLysPfrwCKd1eKoMhtb/ie3xZRJUsp6P?=
 =?us-ascii?Q?XF5rnjeZhPGJiz2xslbFMcHn8YR6MCkEQ/I5BvBttmmefY3sVRcBZmhwzfG0?=
 =?us-ascii?Q?dHXaGNhtCMXOjgWZRY9fMOa9V9eR1gjRRAWJz9EP+dxKmB3MzYfjJAKjKQox?=
 =?us-ascii?Q?SSFRRHhmEjW0vMp4HQOUsJFl/M7hXR2CaxrrXLcCcEwV068OZ3jvS42S/sKz?=
 =?us-ascii?Q?oQkxSYQQPGh4x6aDu4+ZPOACjLBdqOeMXKlx4/44K6gjc8tWtX5j9pt/RjxL?=
 =?us-ascii?Q?Hve2tVV6zfTwdgyMMoz3s1yWav+mG09ncTHoa4Pe8u6PzXJ5ZpMMYjN4sl92?=
 =?us-ascii?Q?UipOIOIu1wc4WozcywQ1foKSd7koFw/qmFtL5dvSz+glu40oublHluVb1ZZa?=
 =?us-ascii?Q?ZvFsL8F+Y3Wml3/1RmzJY3XQA7yIMJYslNFiDIfwYC6wFhwYVHb/PIsZs8At?=
 =?us-ascii?Q?Bq391qpaaBbZJCPY/rkXDMi70vbn6agtLZigYOOot8V1spLgwoJMwr3elXga?=
 =?us-ascii?Q?97hTCYpapG+dZ28vpWhh26HGo9fp8nST3+gdB9FRAAmBaO8qG3shZ1iL6Zfg?=
 =?us-ascii?Q?nPLaJWfzodncTUNCO/wSR1ebJUuZUi8zL+3Z/9YeQY8K6WGGSwLZv5BfIscU?=
 =?us-ascii?Q?TQ0qbyqLDEccKbZrfGZVmjWF7agI5M8Aes04Hdp8ZfrP5ZjXFTVXRR8U+2Bh?=
 =?us-ascii?Q?1yL+7CBkyrs1k9y4AWrlzLOs3PPa/TG1uzNA0p65De5L2UgOMQ0cyz0z42Q/?=
 =?us-ascii?Q?CzVZsjsIDLqW3TdF98bpPGVmCL324PUJhOx7Qb/jS+6h161Z3G/nLVCv3r9U?=
 =?us-ascii?Q?/KPvJkSC6OD2EWJ4OK6/lQOHoNy/9OOF5ygrhl3kQ/1rr5DMu+JbLVAD9dhU?=
 =?us-ascii?Q?YwNT/Pkwr+pFQHhoIksQx9esXtQC3XihaHPohx2xHSw/oFRJe+1/WsCoTC2h?=
 =?us-ascii?Q?alB8qczcKnT4jmcTGYBSpqrI+k33yz2JNGSKvocHxfRWDEI8PEE3bsC1jYlx?=
 =?us-ascii?Q?H2sZhXu/UYmopBzegn+4z2SIUzGegHPgWacFUR9S8UelPK8GOewV5+pMhog6?=
 =?us-ascii?Q?UPlMA0rkyG/5nAJKbQgYsjMi67Jsm4hDYt1xS0BlTrE7s91ohf9zYYiO8yq+?=
 =?us-ascii?Q?RHwwxIh/sCx5sGDZTtrKBnLeQXW28U0imzL9PNyrbH96Sxioui0XZ3Qtdjl0?=
 =?us-ascii?Q?V2x3IQkKyRalRPgOp7ho73DlPgWfvo04NtQGnRZI1XRqfRoYd5HLsKn38T3N?=
 =?us-ascii?Q?REgS08Xt2uC8qdXn1iN53kOoHuv9KAIY/0zL21IeVJf8Dh7N/0JGsckFBE9d?=
 =?us-ascii?Q?f6RGtrytlz4QjELv12IjXrOsW9zQB8ypc9h3C1LUL1l3HFk6pg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4461.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OUpSPglj3shKt01NLYZGA5cV4Ll7XhAAs8H69ctv0AOH0YZRpHI86l/TuROS?=
 =?us-ascii?Q?iZRts3adIYhQIbS00vfedveYdjEjcpSC1JZB02WQY133vDzv6Y7NTvVNL+d6?=
 =?us-ascii?Q?1ADRD3qU96RHXGda+efUeoDLXCAPmyp5BTANK238PivZaTBbnu3Ac0Uqu8bm?=
 =?us-ascii?Q?+2MWBSFykfipF7YmbV97cNwO+GGG3TlUa0G3+7ZmX00qG3at3Vskw9WCVzUq?=
 =?us-ascii?Q?To5hMBcDZsPHb7XFEROxpTE1InsfBdbt/Rpfd8Ir0hP7JT3FbENm6wvjj4v4?=
 =?us-ascii?Q?NMvMeV13oQUTB5hQBnY3tqPQsyvu4F0ho9+DmhOvB1WSy3PFojUrJ9h3c0CY?=
 =?us-ascii?Q?QqoJX2eq42uzpBhfYu2nxnlQ4Q+KbxE732xEEgXXgbUoRiAAMhO2OOnsjNb0?=
 =?us-ascii?Q?7Up2mqqpLS3kE4Sq3wdj/zWx7qcrcMibE2w4RltFRLjwblJFshktUwU4JWpK?=
 =?us-ascii?Q?0yot6arbNImdhcJmZ1FSFvBuBOTILuFRt+0db4YkrXzDAC/wKzU+JWlHoDAv?=
 =?us-ascii?Q?y9ES4VItZf8Z5Km+xLF+II8STuDkL1MuNK5U4k2hkaNfRtFtmfO+bUfKvSgM?=
 =?us-ascii?Q?7bHAOf1F9YOeS5vm5LKRTjwlNiZyf97c8pBwRBW7EMNoog9ytn0kW2rDGqIQ?=
 =?us-ascii?Q?P90ZzTYrk6k3CqYIo8TBOdLfk7d2wHVOi4cMeZYORPEILJ4b8YL1y9DE/n78?=
 =?us-ascii?Q?3wz7GOI8tS+OAnncfbMJTULA3rZxVsxn5ELV4trR6D9Nk6cRMvSBfI6V9dxu?=
 =?us-ascii?Q?CxjqiNE3zX7CT1beXJjVYGglSNpqsh4cvQkkI0Pr25Z6TRWgJdZrmu3rv40n?=
 =?us-ascii?Q?WPaoPKUzJWwDrT3uBtsdADJvk/3N6ggyXf1twk65G1+Q+Irx6bBsSHRO2UPH?=
 =?us-ascii?Q?fMopSkaFi63BmSOVblqQ9JTtCGZvYl0QpOoqSUz5+LClr6BM1FNXRLO0ibF5?=
 =?us-ascii?Q?1P8eaVfcf9e0GFUNJ+pX/2ZqgcqSHstsZsMNYxm7RYThVDlasZRS8tcDT4XK?=
 =?us-ascii?Q?BqYlb/BCJWzWiBd1+RFbzCXgpiDFVRbDx2x6BYw2kQrSEGPYTAnTUB7C6CDb?=
 =?us-ascii?Q?8z9zQiEgtASFa/58qbDmwD7e3D58BAPxtF6A4uLFILnUixB26RUtyxvZlozQ?=
 =?us-ascii?Q?/NgaG0X5xKKfc7FZO/uZzMk/1k/YsYVJvBJxMyPmGs+wZpinEkLgkJtzi4An?=
 =?us-ascii?Q?EsvB/1Z1WfxbtUw0uSKqQBqlyPctSSYmtMEstImRLXd1yhzTotea9smjGQBx?=
 =?us-ascii?Q?7yPVJRu1rqm4CFLzZA9Ck8yD9NjBkd7pN2EcusoyA4FnjelXUyT+A5zPByjY?=
 =?us-ascii?Q?13z1D8pho0XEr6rzzWioRSTWyvfpNkNvycsnehIxM/4uMfJr9hYAaepLFzpz?=
 =?us-ascii?Q?vL56iIWyB+/oXHpPvnd7QLypO/yH/5qReQBFx2Dsz5vGYUe+w5f1bO0esc0x?=
 =?us-ascii?Q?B0NpbfWVXqMzJgsEuTeI9Cu7NUpihVyAMP1ksUVH2s+NSjeuiNBdStGJ9lDs?=
 =?us-ascii?Q?sKamqDB/5kmTlRzogsjRo8yiOtt0wWw/fegYYS6N33ToDIAXKvL3iVSL3Bj8?=
 =?us-ascii?Q?UbsX5/nH56MgYoWjAirqWMIPFDo8+hnU5EbAk0jp?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f675e3e-e296-4c82-2a50-08dcc1d4237f
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4461.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 11:26:45.3986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/6wCj+BRs17ed3KZDz3IoeYaQApelgkGWnp0nHzSv7TuKHsQPylHa9RBfaCbTz/e/Z6o+wT1rmXziEzZsWEWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5028

Let the kememdup_array() take care about multiplication and possible
overflows.

v2:
-Use sizeof(*i2c_peripherals) instead of sizeof(*src->i2c_peripherals)
-Format code

Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
Reviewed-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/platform/chrome/chromeos_laptop.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/chrome/chromeos_laptop.c b/drivers/platform/chrome/chromeos_laptop.c
index a2cdbfbaeae6..3ab668764383 100644
--- a/drivers/platform/chrome/chromeos_laptop.c
+++ b/drivers/platform/chrome/chromeos_laptop.c
@@ -749,10 +749,9 @@ chromeos_laptop_prepare_i2c_peripherals(struct chromeos_laptop *cros_laptop,
 	if (!src->num_i2c_peripherals)
 		return 0;
 
-	i2c_peripherals = kmemdup(src->i2c_peripherals,
-					      src->num_i2c_peripherals *
-					  sizeof(*src->i2c_peripherals),
-					  GFP_KERNEL);
+	i2c_peripherals = kmemdup_array(src->i2c_peripherals,
+					src->num_i2c_peripherals,
+					sizeof(*i2c_peripherals), GFP_KERNEL);
 	if (!i2c_peripherals)
 		return -ENOMEM;
 
-- 
2.34.1


