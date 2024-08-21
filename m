Return-Path: <linux-kernel+bounces-294841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2864F959345
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 05:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D01A7285C59
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 03:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DD514D428;
	Wed, 21 Aug 2024 03:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="g6zOO46V"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010022.outbound.protection.outlook.com [52.101.128.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A30A3FD4
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 03:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724210319; cv=fail; b=Bsg0/W9Hu5brwhiNPz3m58l4Fvkj2AVULXrJxIjFUjfyiSM6N/oUVMh1UcLkaZIhOVjGtxO0Mf89pNkpduYHsnbvT16mgSWFYxElWb+shTsWNQiLcFvJp7Wk2doH3jYgaA5P69bf77ha6+hJciX+jzea6OsjKBEgBFsiA1ZAZ+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724210319; c=relaxed/simple;
	bh=DkXtxYf1u6LlQ+4mCa0XCLrSXT7a+BUAZqdsJUzbR1k=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pouEIB00aGLIF2zikNAkzEWYnOvd4ZPOCFdehmvcpJ0BzoAfK3oP5FU7eDg4dHnzxwJXFtRCcYa8SgeUT0Fru5f53Y6nws8s0wbP4hXK7tQ1eizPdypG0AQxIE1t6Q8wVzjSZh21s7FMTCw4SHEi3FoC9EbNkWYWQrAa+YNv1Bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=g6zOO46V; arc=fail smtp.client-ip=52.101.128.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lv0wckQwov1z6GBs/zDI/TGGno6i9iL8xKYZ1WV6+LDi1hl2w7OScWfTHFzK49wbNyBbkAnnOj9ZLqs3KQrfelZVEXpY30iuG2se29eTMnxuPgoJKKQZb7oHdZW2yX/RpZx4msTaXEMNYlgJ1Iu1bpD85WkW5REHxbpwXcw42JZGvd/ugTmfl/4+MvHCxYuZ+OP0ty3VbzVR/ISLKXsjlw8gXSUO5pzcquDGsObNRNT/qvQoMgN/cozAb7w0fJEYAMGS9FE+s3BsrNPF0UKm5ilNRnKaytx3c/efkQcHqw/XTpSz83GSl/adzCQo9zaiTeMgtWp0uCnMswAq0nBFHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcnb9OE+uUrqrr1k1BtJnchwr0aFn4mL7DonHdjXWD4=;
 b=W36XVFqpyzIGF05RsVBrUeFC4Kb9v9Ki4gQtoi3sBBjc85oqA+rC9WNSNW6E6rvGlRvBoTM9iSBjbvN4mbBUain1E8ENmf3IBTTLoz9x+9OvCzT3Sh6mC9QOpB+JA+WjUwazv+nFuooM64ZtvfiUxrUtf2hz6obzeTWh88Pheso9N8Spaps8mnk0eo6EoHO7UZT/lDs37wkJJBP1MYuYrqEC5JSU9p3a97myj+wSOplt7JWF9hZCVGGB8193oPyq/AVTxSNbKoZ2TqIQLdMRyyEkBw7eT2TkyFOb2sETViLlfVHVUJaFMsL2CpGg/iD9WCn+IXJkF1YoC4AZ7rYpJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcnb9OE+uUrqrr1k1BtJnchwr0aFn4mL7DonHdjXWD4=;
 b=g6zOO46VX60co8LQDFyQmEQ5VykSNRXfetDQnMrYOzbsfn7y7hc0LTJj4HUctK3jWA1fi33VOwngtVW0vlCwJHufwd5+6k5sqHvOLeAU2NAXv19xXxrmB9DMbINdlH4XI65eb1qZGIOXDdONDbCd4iBPGVWESK/MhCu5Tvk6sV6ImKVcTJUta6WvL+e+v24OWurgniGmous4Y2xaA1wOwVGXbljZlOJYGbBM84Gn/TFqMHLTWvy+0zYSBlf2QXskefg2FPfJ8tIXitUPNMRyrPf9kSJKSWGvCjJMuqQXSYEZlcaYYsOneDS1SwoHSA25uzRMOY62AFPEldbw2XCM4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com (2603:1096:400:82::8)
 by TYSPR06MB6316.apcprd06.prod.outlook.com (2603:1096:400:430::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 03:18:30 +0000
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70]) by TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70%6]) with mapi id 15.20.7875.023; Wed, 21 Aug 2024
 03:18:29 +0000
From: Yu Jiaoliang <yujiaoliang@vivo.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v2] intel_th: Switch to use kmemdup_array()
Date: Wed, 21 Aug 2024 11:18:07 +0800
Message-Id: <20240821031807.3781853-1-yujiaoliang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0061.jpnprd01.prod.outlook.com
 (2603:1096:405:2::25) To TYZPR06MB4461.apcprd06.prod.outlook.com
 (2603:1096:400:82::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4461:EE_|TYSPR06MB6316:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d4d261c-6b21-45d6-34c2-08dcc18fee02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3sWFF7G1MJig4gpb+Oz6JTz+hMlAgi/mbFu9QbVtJ11n1wrCSj9TfRWOpPQp?=
 =?us-ascii?Q?xfZp7M4d78aty7woEOjCjQJGgj14kSjIhLQygk1874RsJt6w0+4pgxXa8POU?=
 =?us-ascii?Q?pHDSK9nK6K+NY1dpInbTs+y5RBRCryPk030C1UKFSapqdZosgramCwEyrfpq?=
 =?us-ascii?Q?l5HW2WdHT+JcsNH62lKxG+hZ3pHNaGqaEnleBHeSxJEUHppsL9u2PG+cZVzq?=
 =?us-ascii?Q?ox98QnOtTVAYYYyw2pRr6k1xHpmi/atrsGsD8xq1bH/o89HY26zlh8nU94NR?=
 =?us-ascii?Q?Pouh5t093FiA3jtemG/+jP71xQZw3PhnzYkc9Sgg2VdcwCyIvDlMg5lJWDNm?=
 =?us-ascii?Q?J8FY9B5Dy5k7RwybgLDj43PCPgJY8iOs0YdaQcE6+fhnrShaE8rCJJ/tnYf+?=
 =?us-ascii?Q?M8K77kiMQJ4GbWGAqTIj+T02gXg7+cXJ/OgdYZk4S1EKTtz4sRHsHGtlL2sg?=
 =?us-ascii?Q?XZK9ECd/nh82B8gYh33kX9LCiT9mwjowJS1DCdkUBSA+vEN/ioS0pOohJjrh?=
 =?us-ascii?Q?C3CXVyeXMW/ewpKKypxbIeddiszPhD7A6RzYGJrKeducFjVVc5nvRHPStD98?=
 =?us-ascii?Q?4P9JwTXzApJEck5kFp8Dh7Uh3kv/3zukPZqdKe+6sZS0U0uPKvBkJoytQ/fX?=
 =?us-ascii?Q?oIqYC5hdIy13UtcaObzgHmcCERqQu7/OhEfJCoLLSPqEIsbsEYpIpZ1z4eEa?=
 =?us-ascii?Q?qSTuZri6VrmxCIdHGUvPMKOelBFIErR2OxmXtesI+JugVBJTCmgZbMaUyol5?=
 =?us-ascii?Q?kWX4iYynGtISY/DWb5Taw8GYseBvn6okfrFbpO2Qjv6Olw4Tv0K9c+0lc9H0?=
 =?us-ascii?Q?+d5kgQtULUECYcL9066qYHBj5396bcNUz7AVfZugQBRpzzeBKr/+M9umo49d?=
 =?us-ascii?Q?wnTqo/84kSMd6ACfBFdoEEv9NIZt72+07uqXXMyICoRPKhpGqxgJ9r0sL9Yt?=
 =?us-ascii?Q?qlHxb1lv5J/gL2GUhpDsgb9FCEg3x4aGcsdcsWSl1/rVYhTAmW4mj6ZK5vdv?=
 =?us-ascii?Q?xy33lJwf35fahZy9w13pOvsBik4ZO21gTx7ivO6RTkwrLH3D7JO2K4mwTp1u?=
 =?us-ascii?Q?b3U4FAGvTEHklA+Nj8SRmmak7BxVUi7XrrRpRuv4cm9gMHxiyOcsHvW0gLkl?=
 =?us-ascii?Q?fcV64pt74F1rJC4m60uyuA5spzuKXcrnBl4hBhWrHUxVtRcggqa7HIYDv9tN?=
 =?us-ascii?Q?DMl1H8wUIkvOU3iX8m8nVrFrqfAiMHSaMIrkXzJPVRqBRA4Z0uEo5JsnDKrN?=
 =?us-ascii?Q?0GiyTgaFsMzE9q94dNs48MOaF4QbhXDngwwM0eW73cEE3yWJIKjyoMySZzEH?=
 =?us-ascii?Q?dt2F/n99AJVvgiGhMCDO17XzLIj849HK3qS8lh87jJE7LW4IxEFSCc7NotfE?=
 =?us-ascii?Q?HCkU7tmkxI8zfNdQcGSHYkXsgrq1z1oN0kqtk07DRYut+iFBUg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4461.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uc2UhO+xubnzH4vFwF6bTqWJuAidCbVFii/SO2jtWSxdaUoQA5lsUkKrgGvk?=
 =?us-ascii?Q?pZNh+UgBOEcX9xzLUn0IP9n1I6woVavzRf4yO3WTgxIHTVsJWt1O+r/seT6+?=
 =?us-ascii?Q?b0UoZkY+LzM7d6uukPXECIE91FSBzxKJHwblBYCwYkWl2TBHSU16iQHHw6+s?=
 =?us-ascii?Q?m2HaYIRXRgE4vcAVFUVoWG5reoh5ILkNhTebch6q9WG3EIYoy6LOCrcgJaH5?=
 =?us-ascii?Q?bnWsaoShhpC2I8dAjlmORT98chzJaZIgSzYfZXTLkKFt9MizNAigEzdHeeZH?=
 =?us-ascii?Q?/VpReEobZovQ7hGdvzw7b0y6M6aIRupUp8UYE5sM/S/nNGaKKqsg15/Inaem?=
 =?us-ascii?Q?VMMkv834rLWL8Tj+jlE42AvYgzb9yycsMzmLdEaJ3F6xNq91ZxWilQ8bFWSa?=
 =?us-ascii?Q?r177YzaE4xZk/PH2tOVzYZB2hotZRe/yDkycO6XVUHF2U/eM3Cpg8isEO773?=
 =?us-ascii?Q?yvxxDGXzXbV2PFaBukDT2nt52+liwxE3yAlLIuKSvUl1FwMp3/yfdRrPcYql?=
 =?us-ascii?Q?MPg2Iapfb7s785RYnwGb5tavk6K5ySsUykwiSrdtEBtMxoTzR/N79rexFGgo?=
 =?us-ascii?Q?lYCwbgiDLc8PyYzPl+gIeT+E/YEQxWyUuE+JQlO94B6pw/D+UdqyhdZzOSeR?=
 =?us-ascii?Q?7/iS1vt2U9C9Q/sfUzf1sDvMak7COTYmoW651PTAM3n5sRjUEgNX/DK+y1Vq?=
 =?us-ascii?Q?q6wx1wk488XjxngXPAKfoo1bh/WvQIiJGaq0Lsa8A2hOOa9r/jh4IAR3rdHg?=
 =?us-ascii?Q?SFoNOGQyorCx5l41JFF/bQoMiFJO74A8PmZbHx8Kj9Yl1pJEmB9Gf3yu8r0L?=
 =?us-ascii?Q?RzpnSnI2EUMXmyQV+5Flxx80UH5x3b3DBD+WFfk1m3YgmQDQHBVJGWsIf7Wz?=
 =?us-ascii?Q?tlVv0l74BHo+UCBWcYM46vV5eNfejmKMIIdfsAdDhtpzAGV0xyeMkNgpKiyC?=
 =?us-ascii?Q?OADIvjNF88lKHUf3/ezLMvaQISRX5sBwzPIC7RIcL0E/aNK/OfE5Nr4TqOZw?=
 =?us-ascii?Q?YtXyiXjNgpmRwR5lqegwToFJEURupbQwV7FXTDTIDPQrjrLQC3RWXXPDdHKz?=
 =?us-ascii?Q?md3I8ZK2Pk1A8zLuLIUwUOBx5zcNPnxmwFE7utLtF+hYme31aQ9DoP5XFQhy?=
 =?us-ascii?Q?tzSMVkYwJWyPhZDzyDn9C7GtgwiwRhkygDz5F+kMniD4F7MPg9OWu+BSkS+5?=
 =?us-ascii?Q?yrOL1nAJAO8gmxCHZeELRMVF5bADVEAhgttbYQK84knIuNcjbib94agIO2LG?=
 =?us-ascii?Q?wyyI61/PsuwG5r8NcQv9LsDNryNe7bjwbtTM7u+EjEsyHJ34O6o8YbQBA9hS?=
 =?us-ascii?Q?68orAwvcAqCc5s6+6oRMFP3W6qqY9tTlrb6ymN0xadOZpb6RrF23aS0FTc0Q?=
 =?us-ascii?Q?TMD/VDxB5laPTkFnt8Bw8fffgCxVluFhTfIisww9tqBs9ZVgbAiM6ZplAOBa?=
 =?us-ascii?Q?LgkW5mj70XKOz18utPlD1zZ4z9jq7i/cOZw5HYDckOV8hzgbGI31m/i5L2qU?=
 =?us-ascii?Q?w3vKipLx1vuPFk7EQCvZuO5I9bj2xTrVD6xqn1c/cGjEEGD++W3L6SAgh+ft?=
 =?us-ascii?Q?sw36qb1ZXVd4ayBwTB8KcaSPnIDzarVKlqjIDKXg?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4d261c-6b21-45d6-34c2-08dcc18fee02
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4461.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 03:18:29.8970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rtyw0QoL/XiTNuOfe3Ex1rr09KVg97wSi5INrLlmDwYBcPIpMluFcM8vJcNpYu+GTDFLtxz5WI1zZcGdGGE8fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6316

Let the kememdup_array() take care about multiplication and possible
overflows.

v2:
- Leave one blank line between the commit log and the tag section
- Change subject to intel_th

Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
---
 drivers/hwtracing/intel_th/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index d72993355473..df72037c1c86 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -408,7 +408,7 @@ static int intel_th_device_add_resources(struct intel_th_device *thdev,
 {
 	struct resource *r;
 
-	r = kmemdup(res, sizeof(*res) * nres, GFP_KERNEL);
+	r = kmemdup_array(res, nres, sizeof(*res), GFP_KERNEL);
 	if (!r)
 		return -ENOMEM;
 
-- 
2.34.1


