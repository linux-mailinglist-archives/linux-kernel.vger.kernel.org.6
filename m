Return-Path: <linux-kernel+bounces-296418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A05CE95AAC8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 04:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0759F1F239F8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 02:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54534125DE;
	Thu, 22 Aug 2024 02:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="cPxE10gM"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2076.outbound.protection.outlook.com [40.107.215.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E784848C
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 02:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724292133; cv=fail; b=A73VmkfIdAEF1nT2JBrB7ltUFG8Qbo1iCnaJs0hcLPvXgviA3B+4kvHL+ki3QnyRmWEiFFej8U+qvRjLyj2b59g7FeUZ1qR5AOexq/JCkTOFx5HM2W6yRTDGCna/SyNfC6PvPleVpUl+yd6xnzoKhqPaqieb9Bi6pjjoRryfWbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724292133; c=relaxed/simple;
	bh=YMSK1xHjolNhM1za3iLGd7ayR5Wpq+haq7APQVZT+DE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TsCwBzpWsJ1WtE5xc/ZotazuGtYVNakIPFMkwRU3u1wKd0Q3Js2OZI7F578WU1tLTo7XZYamd7XILhkM9N5LeV2IGAVP0FjnmuiO2uzkVCKb8ztyxhFv6xYqJ1tPcA0pAwnVom3+SY4vw0iZU/hG0QJmqMZF9lm2LFwVJ4aRJWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=cPxE10gM; arc=fail smtp.client-ip=40.107.215.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o+uFRhel3p7JV5Y1mp2b5unmgcPb29GV4/HQdGox5l3qq7BdM25aKjQJ4ZXONXA42Ry8QlaPTOdpH5Hd4AFo2JUegspq6gECMfY3yeVYbww+y+kqkowUjPo8hYJ7Rd/8xlscz/Zc3UyKBUGsmj40Ji4/Ut9jz+5hnExMQ8RPXzZ4sWBHzRhhxtSMrcf1SMS6z9Y6D+cPlXdkr8aJEAGWicX7flnkgaq8fHoxYbcg2PLLLbfAj45MW1AL6YnIsnM/aE4PSFvoFK70LOwSPq8XRuphmtT1nGjTiHTechVL65Jz1f8KL/gOpwG5Me/NlSOoHers7Wp2zvmwPUFIlLMq3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17FQ08cjMXnO0iLvAg6zqFe9XxbZgU5CIfqbIkUlrBQ=;
 b=OHhSWgYEI/xzne8WPlul2oBvhIis4Gi2fIYdUKAolpBY0466ngm6Gv3qxnGgVD4pYtfbIzQYw+4y6k712qjTyfe2DV1ETQAl3xUehNzSA/hanQyx/Z/CF+/AMAbw4IfZgo5k6R3AC3J80/+ntpC2MenqAuDmV7a7NEphrI/bERZe31t2c4yIt/ArPwNAU0Dxa6u6j0fDGBAESfj6VZojrbFdAJAyYN+F9hfdyxGovOREvca8Kht7IhMvRkNP2aeXVeg/pIEjwAe1pE7CI1KKIpJHuUVOmzcDlKpGhr5KtsoQmajcCxPEBdhril+NTBbwlVgwALXWfOCt+60GVVwyxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17FQ08cjMXnO0iLvAg6zqFe9XxbZgU5CIfqbIkUlrBQ=;
 b=cPxE10gMXXHbpl0HM16bjbjJnixYoVaozllPynwf1LtjZV0IF4mmCVQvaLq+WxKZTR/qkzbt1wev8T74pLigfM/TpxjJ9kigKZ4a5xS/6YZwDci2DF7DlPaomrxfniX5hXdAIpUQbkVmnQ2c5nkD6tBh4bHVweCXByPc92BE0XkKXR01K01KQSWgdgj7gRXaLAHrhQOFlfxpeu3u1VyGSN3hJsL7uHhpd0tO0tfYLso96BjQossm0QDnop4Rdfy9Lz5PWCch3eEj3lOHnqRA3kYpBxhmwdH52Dp/+yDdzN/0r56/UqeBYuLNOhEj16XXU7p69QaZneFK2BcBrevb9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by KL1PR0601MB5654.apcprd06.prod.outlook.com (2603:1096:820:b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 02:02:08 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%5]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 02:02:08 +0000
From: Huan Yang <link@vivo.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Huan Yang <link@vivo.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v3] nvmem: jz4780-efuse: Use devm_clk_get_enabled() helpers
Date: Thu, 22 Aug 2024 10:01:57 +0800
Message-ID: <20240822020157.472053-1-link@vivo.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:3:17::32) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|KL1PR0601MB5654:EE_
X-MS-Office365-Filtering-Correlation-Id: e5a8edb7-c421-40c9-08cf-08dcc24e6d8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?as2C0gKF+DQnWS38zJRHaik1o5D9NSJtsLeGR7ZVyyOJDtQpF6+KKI4V+D/G?=
 =?us-ascii?Q?t8hL+JCaHH8EZz6dEE7YF249rxoDDSvF6GIpUPIafo8STKgCpFr+QjVPffYU?=
 =?us-ascii?Q?3IF+eg27njUb8TH/Y6Ypqm5VH9SRQiqgn6km8mym0DdDTHMSeecBY/QPhf+U?=
 =?us-ascii?Q?HlS9D5mWmmhU05hlCHy4sct2m136H9wiGo48m7c8Gv+V2VEuvW9Hw72zM8PR?=
 =?us-ascii?Q?EQPcunyhwn5i//GVl23gG7GDlhFw9kRINJc5zCTNbGCPtrmhuv2lSUl9ShFC?=
 =?us-ascii?Q?EZquAFNPoDAlxfoa5catbINNPvcbaSSdmXAd0A1l7vVJQuflgGdZjlZKWpSs?=
 =?us-ascii?Q?/fjk4rdIKDDT/DQSd6tNVKhp8bnUYZXwmtQ9QaOZTg6/Wo2p30ZoWLACPErV?=
 =?us-ascii?Q?nb9OiGgRu3M+dexSoybgKOZsJTxNN/aUHW2TmUc8oYRIL9gFdi+WUMXmTXrQ?=
 =?us-ascii?Q?Hi4Vc90ozTrnWBKEwsTknVMqO9gkSA2gNa0RM2GzGdtMKjMTZLklKWpKJEtK?=
 =?us-ascii?Q?FFokVR4WZaci4C8Q1NvrVDMZqQ2amlls7Wq25Jt5fIDFn9CAFlRZ/GHcOp64?=
 =?us-ascii?Q?gtNUMPJduvYecjD2nZT6xuyC0sExyYxUhLudegQSmlXNmzb4t+Nxzup38Z0P?=
 =?us-ascii?Q?NLvQpfBpKXUEhbmUreFbEF/wx/wqC0rMjfguig4/JqSpiXVMrHBtp8qokxUz?=
 =?us-ascii?Q?h2Q8YrRuM2PuYP7YKCnspn9PMPQeFDmoczNAFJRGUraus/N0eB1hnueMxS6f?=
 =?us-ascii?Q?y1ZenKmmchn0ygGUFnxPS5eUf2yF6RweqC5pH6JdrWRAL/zIg3ANYazR7a9Q?=
 =?us-ascii?Q?NHEalPPG0TS/ZiZer1m/N3NVs+Fgy/zLpfaUSXhf6Ko0UWLY5pwmv7OTJRv/?=
 =?us-ascii?Q?d4OCUjVDrmQNW90KZBpMsWGb8qnpKCcwqfegdMM3wjdFa9ORfKcqa7ldcGAK?=
 =?us-ascii?Q?DhxwPYrqEjUqnuNKp614qWkvJiTGB4p5cKWf+jMYbSjmd9L4pQp8lH1nHEqz?=
 =?us-ascii?Q?vZ7kK4Ac6N3p4Uy0pNDF1dA+rWDNG0Ksb3razFmsqZsuvy8zp9XjTEgIMfCz?=
 =?us-ascii?Q?k34yiwmHvBMTy/7ryeB8FcIPERoB4tvDwjB/r+GS8VeNnyQhf30JVrx/+IrQ?=
 =?us-ascii?Q?NzYLJj9/KyC37RJDR3EX8R5PhS6zBnv/HXS1NZrG/2sJAhkS6p8PpYQIDWoy?=
 =?us-ascii?Q?Ku+Sy86x5oVZT/jwdZOeeENdDSRUohSQTj/shExyZ1sIqTESAfISrfiWPfPv?=
 =?us-ascii?Q?PKufjBQkylk1OyAle49zQGR62Lu7PkduUfhDZAJ4Mg0tFVIXrj4az1LjsJ/q?=
 =?us-ascii?Q?/kHreAlGlZ0P81EUPuMXlY7p+HLnoktY8XAP1W98MPo5ny4vCPlC9zdrMR6E?=
 =?us-ascii?Q?cbqPG1A/VfdVxfw3y/QaILl361LKn4IBLj2Gfpvc4eXUzBwv3g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SH3KVCp9euShdYwenP28fjDsyI/0q/rM1ZhGm9VCwUlNDHi0WKBiHbTPce9m?=
 =?us-ascii?Q?XGaCwgS6mTamOh9nFnI80OEQTB98/6s2A75plh5BLDKuZhUPH8yK58Q1ts5T?=
 =?us-ascii?Q?dKGKwXwX8JgzZSJr8qZMvKOWIFG9eQvQDi78dxRnL+Vhc5U0/+r0BJ8L+UnB?=
 =?us-ascii?Q?c5qjQVUxv40IO94gk/vRwWA/JOrBBQD89QT2VemCh/TiRA/H5oyHvVf7mKqh?=
 =?us-ascii?Q?Fy+uNLyHqlzZoz8D+Lnfx4jhzTt9dcXaDP9Dvn8xUFQ5Sg5pZjWTqyAkOZy8?=
 =?us-ascii?Q?HTJp4mf+j3DyyCaBXAPDkmDgPZKE+8+vTPlpst2LP7h/TG1CnRlbsNXiHNl0?=
 =?us-ascii?Q?8aLO1MExP/y+iFGHcjk2w8xNmYGZFnKWHDxIjuKdvMl92o7ci/6+P2x43T/l?=
 =?us-ascii?Q?+HLsf0Ezpl5fccvw0g4SB7+Lp17xl7Vmqr1ZTDNpqrmlFWhQb5WuvhOsJh5C?=
 =?us-ascii?Q?9X97oHe53geMTNtXF91qWLv2h+nlTlOAwM3wIakq27rrPW1mgzICSYxHMA/I?=
 =?us-ascii?Q?fyvE5+RKdd6EexsctkpyiE0LOcc4rBt4kipkrwcxvJscmfdV+2M63Ww6MfgH?=
 =?us-ascii?Q?D2q7M5Nhz4OIP5sClRNsvvM8TQ4+knXNElQNM6JgB7W10fslyXF/S3CBC+9K?=
 =?us-ascii?Q?plgfaJxkwi7kR3MI63a98hAyaeJ5V6GdacwiH6sxrxf4xTzYqa1V/Q5h1PqG?=
 =?us-ascii?Q?ffQzlnsBNZsnseBmb9da8lej+qo+i6AzuHm+N9rtjYryd1oOkx6pFaisqYUB?=
 =?us-ascii?Q?efOEYde2Kv8bDwIlCLSsoOUDndMfofCrodGAo3TFdj509rjjVciSW2PkRfPo?=
 =?us-ascii?Q?7P/FLIkn993vZxoepU9sz+mopfbi2Vc+UQ7JNd0iAAiAT72WtRX4aIVYHgw9?=
 =?us-ascii?Q?x0x9IHk1I19esuv3cDkrSnyr3SWs57xtsAbz01Ypa7r8rwXeLI6eb/14i332?=
 =?us-ascii?Q?zgGleeZlLGzq+HqzCyvX82OJrZZFQ2Wt8vd+Zi1D8jkbG4PWDaMah2kKNswm?=
 =?us-ascii?Q?GOXZadKdqYITYXHjUs/JJdp6u0ONiJEkzfg9i4qViOoja8/2rX5aerggmevv?=
 =?us-ascii?Q?zkGF3qa4sYcVXFZIuaiKeJSALswFBYpMUdz4O9fdqQQNkYN5IsGciOQId1eC?=
 =?us-ascii?Q?Wa/yrSms5n2XZAYnDOiZ0ZRs8PdAmvKmSe22hjF3HSHitpw7/5qf1NZdByxD?=
 =?us-ascii?Q?/JGOWgUgCShEIVDA8CW6OJyfQVSY4erzBg5HHGYktJcS0KhaUMzApEukW9Sm?=
 =?us-ascii?Q?Sk14MDOxvkV8hxQjd0nrcrrnLhjIb1Ke1UhvWnrUwNqL1/Q93I982Qp9aggq?=
 =?us-ascii?Q?6G0YUnAzwIVmw1ujedNEeTsoCEpZInRVv1qbuLOWVf5box27zXxg+/ofnzBo?=
 =?us-ascii?Q?/pmIpy1DuMJgGLUcaPsSVTHSXEBtPStr6qv9y4YjXZep9h7O27XGSJqaFDFm?=
 =?us-ascii?Q?sD2EJTbWSN30I5vFOTZML8dUXpx0Thg/aXbjzBIjotRx72OI+4ibuPMjSfRY?=
 =?us-ascii?Q?iICuprgwG5PislbfiDmkV6wTYqQ+zmyi8AlRAcD3pZlCi57ph7+OzdAvRSp3?=
 =?us-ascii?Q?PbIR5ZXLKn5MWxPqfSg4BC4QVdk6Pl6x3Ze7DhCw?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a8edb7-c421-40c9-08cf-08dcc24e6d8f
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 02:02:08.2715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: olODY8X+EKe1rvgz5iE+JYqOInW3vyoYZ4I19apRDP+loAK5G8UqWyDcPxdvYYPsi/Ag3glIY4C0D4eMc0Z82w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5654

The devm_clk_get_enabled() helpers:
     - call devm_clk_get()
     - call clk_prepare_enable() and register what is needed in order to
      call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids the calls to clk_disable_unprepare().

Due to clk only used when probe, no need to save it into jz4780_efuse.

Signed-off-by: Huan Yang <link@vivo.com>
Reviewed-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v2 -> v3: remove unneccessary suggested tag, add v2 marked reviewed tag
v1 -> v2: remove clk pointer from jz4780_efuse

 drivers/nvmem/jz4780-efuse.c | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/nvmem/jz4780-efuse.c b/drivers/nvmem/jz4780-efuse.c
index 0b01b840edd9..99c43c93f4a5 100644
--- a/drivers/nvmem/jz4780-efuse.c
+++ b/drivers/nvmem/jz4780-efuse.c
@@ -62,7 +62,6 @@
 struct jz4780_efuse {
 	struct device *dev;
 	struct regmap *map;
-	struct clk *clk;
 };
 
 /* main entry point */
@@ -131,11 +130,6 @@ static const struct regmap_config jz4780_efuse_regmap_config = {
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
@@ -146,7 +140,7 @@ static int jz4780_efuse_probe(struct platform_device *pdev)
 	unsigned long rd_strobe;
 	struct device *dev = &pdev->dev;
 	void __iomem *regs;
-	int ret;
+	struct clk *clk;
 
 	efuse = devm_kzalloc(dev, sizeof(*efuse), GFP_KERNEL);
 	if (!efuse)
@@ -161,21 +155,11 @@ static int jz4780_efuse_probe(struct platform_device *pdev)
 	if (IS_ERR(efuse->map))
 		return PTR_ERR(efuse->map);
 
-	efuse->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(efuse->clk))
-		return PTR_ERR(efuse->clk);
-
-	ret = clk_prepare_enable(efuse->clk);
-	if (ret < 0)
-		return ret;
-
-	ret = devm_add_action_or_reset(&pdev->dev,
-				       clk_disable_unprepare_helper,
-				       efuse->clk);
-	if (ret < 0)
-		return ret;
+	clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
 
-	clk_rate = clk_get_rate(efuse->clk);
+	clk_rate = clk_get_rate(clk);
 
 	efuse->dev = dev;
 
-- 
2.45.2


