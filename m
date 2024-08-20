Return-Path: <linux-kernel+bounces-293772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4F4958457
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50B0D1C24874
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D9E18E74B;
	Tue, 20 Aug 2024 10:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="CsGXH3r6"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2058.outbound.protection.outlook.com [40.107.117.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5642118E033
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 10:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724149428; cv=fail; b=f7JZpI1F4Vn4GccWmNcnA+SCjZ517WyTU2ocB4Y4N+R35H/q1MwFdkeguhTb6ZZ54xL0ISKx4iuR0HRpLH6D92iC1FO3CQ8zXLNahKS8b7Ow60k9NGl+9gip+8qL9Y4MahBo1gwomu+rSki2p4MWPKA0cQdnIwt4sSCvn2DtErg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724149428; c=relaxed/simple;
	bh=T05WoBjMa6WKWPSX8c18gfl9g2BZkhN0vVEofQ+LVrs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=c4v8xeHNI3qfS9w0YxmmmVYUhSEnTsITLS4LzB+okg+NnpEfAKoKO6rJxnGmVYIAZAzVdrzBozbG2o53e1oBLmFv/Q1XwZzkw46kI2UA2g7Ssqeb7iucOtwE1BAKceksK7oKkSwACL8n5sBdCFjws1le89NMBFV0nTNPeZjh6t8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=CsGXH3r6; arc=fail smtp.client-ip=40.107.117.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CbxoI5N/skfEQv/rQEQ9znpHUIiYOZIS572cKU+qotlZLEgGWxPCeO56+hEk+UPFcEmHO8wUJTcvYyoP09kYKyZhHvRVfIeqarFprrcYJ17DrYgK+OB4pBt5EK4Eh9feNWq6rzHFIupA+gmL8KVnCvUmu1lL3Gg4R8FbbngiAqWDgrbdhABt+wFT91oYqOEdzuaHuZkf+X4h0wX1mZulUOMXsgbB32EYcHXwheRAF95WwdcHLNpr4tsuT8TOd7q9299zIOkZFDg5dfdhLhfLmZVdDnqyIgYzIx+GA4vdbb/P/ABeUFLDQ+S8WFM8NgVumlb2eswUPnwVG6rbkO4eZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8B+rkHm/bxLzwU2PPVAz6xarqgeLJjFxb5jhAlCcrbM=;
 b=eFAXGp+lWyRPSPyyeXSU5MPjD91k65+8smSYqPuUt7Dh7+ff0ZVuPZew9MJ3gFhVtxRLAWxCzLs38sQObAq57UcJJKhDCWYAYZd7OC8rUHLu5XZogav1EEQORM2i4Wkd74fm3CffYhJzj5n+QPVxrcPO0DcFuqA4i1Ulu58EnXDpbM4gIYY5XruBDbMYdT7LBqMhWri0aLSYWnjG6xL+evEYLaIXog554qoKpt4M4wFgRq5l/1lQK6Pr42nRXleIz0YZCXdEd0B762GIMKJZjZGg6GEYf+HQ8QjqHq7F6S9MLBYjP/YZmYGGjdBcAhA3/mcI+1IptDeboYc16bk1Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8B+rkHm/bxLzwU2PPVAz6xarqgeLJjFxb5jhAlCcrbM=;
 b=CsGXH3r6iZHtFOfBeEqXVZAXyms+zTttAHP+YTJq6ZuOF4c4/i9rQo/uJeOMc4exS9g8AnkBkhKOSRXDpkEtJi3uj7/4VYrkk5esYp4jvdaKmvfTyizfCkrSS3I91C8wma7fxzXWVNM8cjwZ5b5Ao3/j62wCEdAVSrAu6jTqk0EjsNp93eayF6GeLDuaNFj7FRY8+vUtDvZ7pri3HJOaKr8p0Q9R5+v2nZNxTTqfRR8ka/kkZ/IU4Wl+q7FZ8O1B7cfKfQdgMswxlOp5vhbPeO8k3bIW6+ch5LtPZNAgCE4l3BZZvkFbcf7GuEtIHAQ1ZCHA8zdM+MmfhWzhijnQ9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SEZPR06MB5247.apcprd06.prod.outlook.com (2603:1096:101:77::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Tue, 20 Aug
 2024 10:23:43 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 10:23:43 +0000
From: Huan Yang <link@vivo.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Huan Yang <link@vivo.com>
Subject: [PATCH] nvmem: jz4780-efuse: Use devm_clk_get_enabled() helpers
Date: Tue, 20 Aug 2024 18:23:33 +0800
Message-ID: <20240820102333.133503-1-link@vivo.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0205.apcprd04.prod.outlook.com
 (2603:1096:4:187::6) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|SEZPR06MB5247:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bed2395-d997-4462-d7c6-08dcc1022aea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KD5QWGjLzwdE6fZMT/qWEn1pfg6+gCIDZjRzIZt2X2b8WVVS44OMnTu1W/em?=
 =?us-ascii?Q?OkxutYOAPjq9GPhRd6c+leqPBO8LU1gw5S4gFY5RQAcpr8PaJJ8lZ5WSlRE3?=
 =?us-ascii?Q?W53HpBHbAfENxgYKCYN5SsCAUQL5Fqh6dq4aYtCueb8+2E1FtVq0lEtmWkmI?=
 =?us-ascii?Q?jWbDrVfLWSBWCqSSVhOEH61y3Bj74pDdxKThTuJVuzA0fVDx9jrqx0KscmrH?=
 =?us-ascii?Q?XLeR2YFp43Y0gYauBpce7jznxD8LxQ6NtmsvQpz98Aot1/DkF542miawJnzF?=
 =?us-ascii?Q?JLtZaO+U/5hIHVsMoncQ44hbV16I0X2bk8E7DCX3Q7M2racCvw8JC9mczmHZ?=
 =?us-ascii?Q?E+7nY5LQ24wxwWLNf5PnWyAWbY2OuY7FGk+OxBiNNGYKTO9Na1l9vUBBENUQ?=
 =?us-ascii?Q?5SrmI/3Bs3pPZXRPrfsYxnSA1i+PRj+5sfEpt/b9bNaqBHmf5tScTVDYIweW?=
 =?us-ascii?Q?uzOrKT5g10LXg6cX+yX1K5aL/rudQvUoewSbCLEPCgkuBmgr3ak7BAfT6xw4?=
 =?us-ascii?Q?m0Frmt17kzV5GH/ZlazQkRc6dtKFbk8l0bnuiwcpPFZLL3cHAQ4dskGEHhYw?=
 =?us-ascii?Q?scaFyQ0JrrI/jldmfbDAvAjcEAEjks4cnkUEdkyDEevdzEEPwO8pFXrTs90N?=
 =?us-ascii?Q?nxJFN8ANOfti4PkLUYmtFkCSCaMIxOLjcNyEw+/VryAj1Kp5TFENvSeyBbaD?=
 =?us-ascii?Q?6E1FaC7m3jCUfkBw+5EieZlvDeZcxZD0surKdQ7b0E9PRqLIBN1Avr6RSz0J?=
 =?us-ascii?Q?kOMUTuambDtGPoJvl/sDSvCf33NHhBIixv5Q7ZloQIsGw/X1lP+WgnnR0B4h?=
 =?us-ascii?Q?RcXHUlxkkrC52a0oII2hj8ntsEnR3x5j10TLMgGzHFATdT5qWAVRqi1EPSfP?=
 =?us-ascii?Q?V9orUQGI9Rk0VYDRZEC8/Xa3MnirYV0hMw1+xUNZp54tx/nsq+yKAAJ0Hyao?=
 =?us-ascii?Q?SPU1BxH1l2YwbnlV6Wv0/6EZDL1/S6VNhPIUmnnLQPM8PAmkWTh+512nTqoA?=
 =?us-ascii?Q?jm3dI28jI2Puw+CKixxMXNXe6oB2U8jTDzg9oWMF29jIwtfsxEk8pxFrS25g?=
 =?us-ascii?Q?2CkIlXMWqnvSvvbCl/dRpPEwVNLh4r0Woc/XSfeW+xXXJnAh7PSCnJnBErpv?=
 =?us-ascii?Q?HGmo/DS1aABcXTOelNML6NXVjJJPEwWFCXGUgFSCLjEjzV5T18VI5a2dTZr3?=
 =?us-ascii?Q?f9dLNcixSVfTcqWCy79ErwnJxIG64nztNPIkaiTuZyFB0YcGblHrCWcFXB43?=
 =?us-ascii?Q?ZDH0O7CKb3Gct3e7yX0m9qLphk0x56jDIS4d+5TT5JDc94eNkfvwxnn5me55?=
 =?us-ascii?Q?iFFS1CdsmR7Q7g86G4bYC124MFf0RerKbY+61nniSNffcb0Xt7fGdUK676fO?=
 =?us-ascii?Q?wyGd5GMWfBpZ8UKUT9VXvMGhDQ3Rbkae9iWsmAaCgimjE2XD6w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CYyCafgY/x2DKAcQYiOXT3ULkSV4SToNDjD/y/XNXng7+/sKBpVo6vlpVnJb?=
 =?us-ascii?Q?3O2PWEwDvDL6cwSQel93euNDCISnWbFF79RogpKJre1CAmT4nxOWtQpPyUMt?=
 =?us-ascii?Q?eBltNZiotGxWRdLa8gR7UZW108mUhcCrxPxxPVvZg+6khdECXSfXbrZ8Xyjq?=
 =?us-ascii?Q?6aLFxxUUBEoqDoOUedTiu8bLxxpRZ7Zt+TnYtmgvX6umdH97wYU0NrgtMktH?=
 =?us-ascii?Q?fm8cu3ie0rOgHG/EkRIij8yoySNl4X8DJE6uGJLSBLB4jybgvltBvZ+PgCfj?=
 =?us-ascii?Q?HUbnS90CIVeprhXC6hoGzXhP4CmkzE2mMqEIb6wNB5lqXZUkN//WAOOWV5jb?=
 =?us-ascii?Q?SqSPTK4IwOrIIV+mi8b7yb22g01E/JQ5DAtd9CQGFCLpP92wmDB8amlWil4A?=
 =?us-ascii?Q?IbS8NtRQ+/557l7nNAKCIWlv7dtLNCNFZsxcpN6tVrM9xOPBxqdVCcmWvMxC?=
 =?us-ascii?Q?zKHqx7cR/beiwaeGs69Oj6YB24UafRtuSsGjQ1MW4sbcy0jXUhN4+qgYlRDQ?=
 =?us-ascii?Q?kkgn31jR5QKiEpRyfMVftFzgphmiEJFFZRjXdCBAWqXQEa/hmAj8/grFE01q?=
 =?us-ascii?Q?Rfh6D+utoGl5OXqDFyWw6Q6WrJUKZPtD+yMHb9TzD50iMt9LI1UnQk5+/Ldi?=
 =?us-ascii?Q?ubloKbbQ38rA+rL/wzJHH9mCg7qd/5PEKYsfloRGCrJ6cEYQIhvuwEcHx/f3?=
 =?us-ascii?Q?r1Uzja+qOTaeJaM6NTgpAvJpnCWF5gPSQOk7bQ1yVM9sS9zXOQU/JTzkLw5s?=
 =?us-ascii?Q?X8jhXh9Sb/vyTJwx3X0fxEZpyAu0W12OqVtteA5OQtX7+aWJ1dtwpTAuK2kT?=
 =?us-ascii?Q?/mNjLcyyaTgocqqjlvAFbED3UnTAfuc+oaynRBPFei7zmr61CFAHpefwHPe7?=
 =?us-ascii?Q?p6ooZRCNqbZ5bVTNaCdLuSxPsRHNibpSAyCL/OWg4YNfFc8HXhQEGeqQlMgJ?=
 =?us-ascii?Q?zSV0wj0ex55siFrA/C1zRO5xb2czUMHOMkN9cnjM4oDtwrwV2RBhxskEIohP?=
 =?us-ascii?Q?6V7qEpgVCA/ve5qF0BXEKKBjoW4hGT4h9h6vqDH6ou4Rdiie4ZhAeM4yw4N5?=
 =?us-ascii?Q?wMqbDSZm+Xc9m/pgvOy90O11LjFpAqIiGLsBNvghqGpbxvEJvsf5w1xn75mt?=
 =?us-ascii?Q?VXpNb/PoO6UgCohffhaJyY+Pj6lxHeBPcePBFmbA7Jg1vkivc52GJ2f5nPXu?=
 =?us-ascii?Q?x1ZNWa+Fqgl5kCtp5dibUEEDho/3nqQYO4Mj+efECFeArO2GNQS/hkzyAQEE?=
 =?us-ascii?Q?vT3nTwG/VG17aSZ9VDDE+wLKN4OdUUq3+SSy0cd+XdAftMnBMmHt30+zbBmx?=
 =?us-ascii?Q?S7CplSnMHRQo3iqdixkbJ0xF+qs/xZ5X3gGh/TiPldV0HZqdywywna3wUddu?=
 =?us-ascii?Q?FiJX5gZ4zF9zcHjnjPrRwUxhHRkj4rUoPo0bdsp8GViXwwzGhd2ZHQinnNnV?=
 =?us-ascii?Q?R6nHBgRKBFp8OwP60YOmT2PC0vQ3CUKCXI5wWlr3ii8KkOTUfBW0mAYn41s9?=
 =?us-ascii?Q?288zmaYCAY+kNlxaiR+H5uPOSU5E0ooAXXIohcN+DsSiNF2QI3Sqm8hOsdsm?=
 =?us-ascii?Q?v2xif6zMKvgljMfUc8tu21TBBmDcdMNoKK3Q7N6E?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bed2395-d997-4462-d7c6-08dcc1022aea
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 10:23:43.5262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZMidITWHsQjHYB7WD1AvCs5hir81sN40j1uHPXoGtyaCS8HHnHyHsvpzMbW1wPy9fmMqg+kVTPZXLGlzkm5unQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5247

The devm_clk_get_enabled() helpers:
    - call devm_clk_get()
    - call clk_prepare_enable() and register what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids the calls to clk_disable_unprepare().

Signed-off-by: Huan Yang <link@vivo.com>
---
 drivers/nvmem/jz4780-efuse.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/nvmem/jz4780-efuse.c b/drivers/nvmem/jz4780-efuse.c
index 0b01b840edd9..2b5badfbf22f 100644
--- a/drivers/nvmem/jz4780-efuse.c
+++ b/drivers/nvmem/jz4780-efuse.c
@@ -131,11 +131,6 @@ static const struct regmap_config jz4780_efuse_regmap_config = {
 	.max_register = JZ_EFUDATA(7),
 };
 
-static void clk_disable_unprepare_helper(void *clock)
-{
-	clk_disable_unprepare(clock);
-}
-
 static int jz4780_efuse_probe(struct platform_device *pdev)
 {
 	struct nvmem_device *nvmem;
@@ -146,7 +141,6 @@ static int jz4780_efuse_probe(struct platform_device *pdev)
 	unsigned long rd_strobe;
 	struct device *dev = &pdev->dev;
 	void __iomem *regs;
-	int ret;
 
 	efuse = devm_kzalloc(dev, sizeof(*efuse), GFP_KERNEL);
 	if (!efuse)
@@ -161,20 +155,10 @@ static int jz4780_efuse_probe(struct platform_device *pdev)
 	if (IS_ERR(efuse->map))
 		return PTR_ERR(efuse->map);
 
-	efuse->clk = devm_clk_get(&pdev->dev, NULL);
+	efuse->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(efuse->clk))
 		return PTR_ERR(efuse->clk);
 
-	ret = clk_prepare_enable(efuse->clk);
-	if (ret < 0)
-		return ret;
-
-	ret = devm_add_action_or_reset(&pdev->dev,
-				       clk_disable_unprepare_helper,
-				       efuse->clk);
-	if (ret < 0)
-		return ret;
-
 	clk_rate = clk_get_rate(efuse->clk);
 
 	efuse->dev = dev;
-- 
2.45.2


