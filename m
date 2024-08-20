Return-Path: <linux-kernel+bounces-293678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F04EE95830F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A215B281DEB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA67918C351;
	Tue, 20 Aug 2024 09:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="XvtoS+bI"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2067.outbound.protection.outlook.com [40.107.215.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D1D18B468
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724146934; cv=fail; b=Ywo6wdz/ooGMQzNCVmhUa3eATJp4yDRmVQOg29Ow1522K11YppsBG0a5ucF6ZX5XiGAtjOzAw07my99a826Q/h4MUnngTxybCQ4OYjJorc8wdVcA5Aj7PcEyQMcFk3HnEuvbUg5HvHc7JDM6gG523nBkZ5eDMSNDbiLMPiERHpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724146934; c=relaxed/simple;
	bh=iipEDWqrUCR2TnW+msiiFjFwCVYFv5HxCxAKGTYaG00=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WlKnU+jRUJwqJQFPbRJ2mNg7OaZpxKnODslk+f7uSXNbzY1K7aGNtj+MXpdSAXNXqXWeINi89dPNjWBwWNIXCZO2rcFG9/+/Qn03ecZoOmAxYpseEmSg04NWCU2TQu/5lMmDsfjPzVCM+aRot5cPP0vsveYjs8fEyWGPt94LH+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=XvtoS+bI; arc=fail smtp.client-ip=40.107.215.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TDZ8u9zl0rJMB+6cc82CTJTyypL7LSuwDGA7r0fBSHXfjePviWjtNu6TaefBpLLwd08qkZOR5tq+KKHVV6rq2UnQq6vNdax7Jkn4r1rDuNz9jusOHbpEZC9Obppu3IOX1DlP9uJWSnfeDMmU1hutyURmZWGIMKwjPNzzCzd/VVg1XzdPxxERTg5x173jSvjwegkNIv8i3ld6wrAsGqQ5NkRnBwQEOASv1NAchRlINKgrSTheA1G51rUib1Ot9Om4OTlWBgfQ8b8m7Cmrt+qpGFszxhYmZGEq9caQAyGYlJbXNvItPaO+g2cc1TRXIPLBXSrpkpkl+4VZZP9LD1kQqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmqYpEOoDpqE1uQWJxGJGCfBVzMqHIc43HvE0sON1rg=;
 b=Z8iNoWW6exfz/0vTjA+7hFqsxl32fdV1+NHnKa4dGUs/Pxz/YFaqV66sRy3JJHtv6a47h8J6soov0Rb9bQbHzTi7p2AEsplU44uIQnltpINePUaWJPWYpXbXV0jUdKWJYr6yKbrs3QipwmoE7KA/zKU/yntC5lFHDvG8PPoV7Xn+7dVf1qNQq0P5eL1N8qLqamkJMsq6UJVpEhD8BhfnzgMnK/BLtk3kXA+r1dJz8AeVu91AXpY01wfX9++Gt85+fNS16iCubiFqW1AxGkOihNJp5+MSp6gPQXrVOGx3rlsidXHyNxMzacsxIf4e7yMWJHZV8/JrD5kLc55s9Eumrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmqYpEOoDpqE1uQWJxGJGCfBVzMqHIc43HvE0sON1rg=;
 b=XvtoS+bIrHs9n0ocQZWpphfq0fkz8jxIol8kIiuxejCYhghcFtyE7lUVkKC4lBYL5fuVKTwYMSKXT33mGdUcGglkgIjShCcIE91Q52+IxniwcSsZ+ERJpKgN3C276fPqD71LAIvasl0TdtkvQ9NkoAZK4uyqeeS7r5Dc5GL/a5cGVdnijyX7NP02GoCUkdESI+zn0uZApKa8WFlpbp3Bh0JMYB3mi8ZAkwEWm0Kzclkk1yqPgHNrWiLr+gtp/pU5bQsCjV1Mlep1Us++Dc7clGl3yNVpTr8xc6rK5a1oEkRWaVofV7rpuoqV9/xahHsDfs873Sl+FcpjR29+Kkx+5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by KL1PR0601MB5463.apcprd06.prod.outlook.com (2603:1096:820:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Tue, 20 Aug
 2024 09:42:08 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 09:42:08 +0000
From: Huan Yang <link@vivo.com>
To: Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Huan Yang <link@vivo.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH] ARM: sa1100: Use devm_clk_get_enabled() helpers
Date: Tue, 20 Aug 2024 17:41:18 +0800
Message-ID: <20240820094121.98231-1-link@vivo.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:4:197::9) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|KL1PR0601MB5463:EE_
X-MS-Office365-Filtering-Correlation-Id: ceac2a54-b25b-486b-39d7-08dcc0fc5b99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PJ6R9HqZciqPerTHHB/vMAq0y4fGkfymXYkWyEjt3TbbQq8KUuuE1GLOWBa9?=
 =?us-ascii?Q?cMmPySbqAZS8wtcGnYtnZ4DZqBAzH/ZfzHd2vgkTJCKrxLXMiTtsZ6Chtfsu?=
 =?us-ascii?Q?Nvl/A9ENpKYmi3lkX5OuV8F6zDRQeZfl9u6GKqt/DAweg9ySsIOXJ1be1d3D?=
 =?us-ascii?Q?/T188Bm6lDppUIBBkoFM7lXGMKjEstOiY4Ynkh0RRkj23ZbvVHKKon25cNnT?=
 =?us-ascii?Q?kdYIpLtXtig9sotrjDWdijTe3EBoR/v0BTUF3/L4tpqqBWWD6NPc4O3aDE8C?=
 =?us-ascii?Q?kLO/m6mzqRlrMszRyuJ5svAH6rf1yJXMqdiUur1Hl172cDIZ7XgbLLQX/COg?=
 =?us-ascii?Q?hbVYedMsmHke4GdosfeWLKdlVk9F8Au1jsYc3RrPZt1Yu69fX99KeJYDMqC3?=
 =?us-ascii?Q?i45wgDXbaFM6oGJU0Wyr0fKYYN5kqwRRVUZQzGscRaLW/EXFp93ATehLshea?=
 =?us-ascii?Q?DyqKfDSZuNHFmLpCgXbYeF+J0jh0HMt5jDus5/olj9hSJkxo9SFGDV43Plj9?=
 =?us-ascii?Q?DKz28lEc2lj9uMMdRrwhhMqhxaurWsKNs7woK5DagMAc4kWKcSSwng+dX1lG?=
 =?us-ascii?Q?jz62LsA0z90mPuDYssweGZH2Sq1vCxInBWfjHfqhGq++03SJAtgX/9YXAyXk?=
 =?us-ascii?Q?+X4Tkj5gQwXcD4BJ+LtB0Y5lgQuDTubnERnzz3t3X65brLBHa4s9eaSPRhuX?=
 =?us-ascii?Q?MYD9QujU/DgOqmqLHD42QsYisAHQ7NeJzXkGs1Mmw5mnk4SyhefOaOk3kU8p?=
 =?us-ascii?Q?9z62y+nWc/b/7fLKRS/qA/tNRUML6yXd+UuN5m/VZ97+9HB/RDDWDGSrmIpJ?=
 =?us-ascii?Q?9zAkrdNZzb75tCV4uo5NwL/rmtx3G66k7UhMOUtC93ljUhjOIbbEe9dl5aT0?=
 =?us-ascii?Q?XR80cQJaeesfH+NR1p2Yj/52Gt8xao2l7IQ6TfZCBBKSwIkqgAxt/4SKA5EM?=
 =?us-ascii?Q?eiehXXgSrgi5dOYogkAY+6+HLoEDW+g8jUZnUfqsMjITYenUAMSz4AFW2nff?=
 =?us-ascii?Q?sJajgNQsIz32rUrFCtp67I0E+9qz2LF+Xfm8rv7KPd2mWQ2Np5pwIkytnBXg?=
 =?us-ascii?Q?rDUSYC7Yk+Y1S3zHuGbuSgZqjwX8G85cBCAiR4Dt6lTDXyx0SR9FHVef0f9Q?=
 =?us-ascii?Q?MM3JlhCJ+6k3LzvEK68PC/klQsZNiY0WRsBIvrFwFSHiqjBzRB7wlzfYCtiN?=
 =?us-ascii?Q?MXJ6/W+1lRyigatjT6Hb0Oyl9IQUftpNlrh9ECqkgEbL8Y2wTr/p1vkJ/KWi?=
 =?us-ascii?Q?5umeCOiuRBvrdF+xIX44fNUIAg1ZHe0SVwyhsBosYOzKO4SIhfS1AqsesYgB?=
 =?us-ascii?Q?BLnzgrgphiaXrbW3kRJKeynGKghEQWE1it+Z4RwiqwYUspRHIcKBIhfn0ImL?=
 =?us-ascii?Q?OQJS7iSnqpf54O8qMqpCQ4Amsw31GElNZh0wAmdkwaAfN5zHsA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/TVuPHwBxUD/X9Sf+OX3ro8Fl0+rC0qiO7KE4Kolv4E5+o3XY+x1+MWYXukH?=
 =?us-ascii?Q?u6i6dRE4oBDLOpEKVAHXnnCrsbzkviSiiAjqXlNBNu8Hve5oGt48XyC3pi+2?=
 =?us-ascii?Q?+Xuzx+mYSsBxF63oND0KkamgUaD4MehroSuB7LRrz/KjTI9NwWUP3DvtMAWp?=
 =?us-ascii?Q?JTFPplSiQYBHqhuzalDuLA6u7/yMJrEJyeE4Ysahnw/KRbQKQkkz0IBdO6ab?=
 =?us-ascii?Q?sFBF+m6yjb5CbuRVxJ+8kNntrrMAdCJ9L71gSFUOL7ZsesPgGC6lyyxDHihu?=
 =?us-ascii?Q?NIFHhDyz/u9inN0LgqCHzv7tf53mFFvTExAqr9bdJAxN4OAEg6gN71SxQviK?=
 =?us-ascii?Q?67WmBJlQ5LZIG7RdBbBUbxklOAJgNENWPy6Bgik+H23t7qVmrtTDdPE1EesB?=
 =?us-ascii?Q?9LRQuD9jJJFjUG71ezpSE8ezOUM5nYLgswM4iWJtdVH/NwoRQCWIekaY1eUQ?=
 =?us-ascii?Q?HN2B51lc92jzvMVPMAYNCkSwyymylTnsNQ1k4w5ZwFyir+h1U7wAs8VpRPAh?=
 =?us-ascii?Q?d4ROTDZh3wxzuNsOtSj0cmkpJ1736FpfTvZ3QuB4uCgiyZ+fEK1OoQU4PC0n?=
 =?us-ascii?Q?MMgNpZe+jcpyO3pkTOWKGPbQtvKV0Z92fy/AI17FU5q0scU3EnLBWOIWnKmS?=
 =?us-ascii?Q?wB5S3Mhwj1XreRSB6oIyaReJKaYoeseg5TEJjuuTknESPbwdjap5v1Gzv1ny?=
 =?us-ascii?Q?bkiNKBxN2KsdS0DG2WKwKL+BhGidMUhwQy84YvJbTBuY3nwjReSlZUhWFHlb?=
 =?us-ascii?Q?S0XOzCHnuZNVX1bKIaliFDoG+qmLJEld8lrESUKuNXbxIpO50oUc5e2G7Ct+?=
 =?us-ascii?Q?Vzk5XzwImrqL8l0qVXGuDfj+4mBVvJTv8IfcVchhrh2+OS7Xy29FHFBsw07y?=
 =?us-ascii?Q?SGfo+Bo9/ezwxCqhi0PB7XmN8uQHz6Bt4TxTKs4qvg9pGCIqF8SHatKjy6P6?=
 =?us-ascii?Q?go75s9J+Mf5LpLjbaguD9TME5u6aHaDhNUX33y+ZNX/6u3MibSfJ8VGSX/db?=
 =?us-ascii?Q?HwDS8AsSVBrhWirR67YoN/HKs1EXdrQWzygaviDQn6JCAs2EoTD/8JCgFOnL?=
 =?us-ascii?Q?zsqto3eH2XP3vwlNJh4aSkmHWQeFgQVVctkvpWwcY6Pl3W7Bm2U4cxxxkQDH?=
 =?us-ascii?Q?r+4nznfBry9nFDOjTQyRc0mShz+Hq0IGblPF1ZUPv9JP1BzstEC3AF2CnLqK?=
 =?us-ascii?Q?8fXrPytmXr9S/qieKGxfYWM/CJ7Tb17o6ZlEXnVy7PrPIZfF+pTcCZaO0qbj?=
 =?us-ascii?Q?lSwgZ6ySbsZ7G5aeH4laSsDUb6lwf2l9w9wcRPsXqr0ANhD/iRT+GSa5RJH4?=
 =?us-ascii?Q?aSpxtB9IkBB0kFZohtuuOyAK1lvIJOWSmy9bBnPGstZtElewYi/5oMEGnVDI?=
 =?us-ascii?Q?yz+IqRdqv8nCpuG0PyEQRESWbJuzwjR0Zd2uEHv7VqlhzQCuhdk1z/Z2LngX?=
 =?us-ascii?Q?cGLUkFJ0RcGiwfP8J3BIcL5KnkrKYOSLjWApamWb0Hty6H5EX1R6uESjxcCG?=
 =?us-ascii?Q?GMnlpAeErOKGJhF/p6s2gUAAuxGOk6wx6lgcjwtdoON6yMylt8A/ALJpPwrL?=
 =?us-ascii?Q?uGbkhCXub4UdAhm/ITu1EusJMUw3EJ5uwfY+vQiQ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceac2a54-b25b-486b-39d7-08dcc0fc5b99
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 09:42:08.2241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cpTL7jCAqHDOKc6VqigSC5Q+txnpCIN3aUjZ+Rbg3rYCtd49OQlkaR9ULdRQoXMErncwQ+wZo85jXqvk2fxdLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5463

Current clk prepare, enable, disable, unprepare is split, this patch use
of simplifies helper devm_clk_getn_enabled, which can avoids the calls
to disable unprepare when remove. move enable from wake to keep it simple

Signed-off-by: Huan Yang <link@vivo.com>
---
 arch/arm/common/sa1111.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index 550978dc3c50..10849ea04071 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -642,8 +642,6 @@ static void sa1111_wake(struct sa1111 *sachip)
 
 	spin_lock_irqsave(&sachip->lock, flags);
 
-	clk_enable(sachip->clk);
-
 	/*
 	 * Turn VCO on, and disable PLL Bypass.
 	 */
@@ -800,14 +798,6 @@ static int __sa1111_probe(struct device *me, struct resource *mem, int irq)
 	if (!sachip)
 		return -ENOMEM;
 
-	sachip->clk = devm_clk_get(me, "SA1111_CLK");
-	if (IS_ERR(sachip->clk))
-		return PTR_ERR(sachip->clk);
-
-	ret = clk_prepare(sachip->clk);
-	if (ret)
-		return ret;
-
 	spin_lock_init(&sachip->lock);
 
 	sachip->dev = me;
@@ -822,10 +812,8 @@ static int __sa1111_probe(struct device *me, struct resource *mem, int irq)
 	 * registers for our children.
 	 */
 	sachip->base = ioremap(mem->start, PAGE_SIZE * 2);
-	if (!sachip->base) {
-		ret = -ENOMEM;
-		goto err_clk_unprep;
-	}
+	if (!sachip->base)
+		return -ENOMEM;
 
 	/*
 	 * Probe for the chip.  Only touch the SBI registers.
@@ -843,6 +831,12 @@ static int __sa1111_probe(struct device *me, struct resource *mem, int irq)
 	/*
 	 * We found it.  Wake the chip up, and initialise.
 	 */
+	sachip->clk = devm_clk_get_enabled(me, "SA1111_CLK");
+	if (IS_ERR(sachip->clk)) {
+		ret = PTR_ERR(sachip->clk);
+		goto err_unmap;
+	}
+
 	sa1111_wake(sachip);
 
 	/*
@@ -851,7 +845,7 @@ static int __sa1111_probe(struct device *me, struct resource *mem, int irq)
 	 */
 	ret = sa1111_setup_irq(sachip, pd->irq_base);
 	if (ret)
-		goto err_clk;
+		goto err_unmap;
 
 	/* Setup the GPIOs - should really be done after the IRQ setup */
 	ret = sa1111_setup_gpios(sachip);
@@ -902,12 +896,8 @@ static int __sa1111_probe(struct device *me, struct resource *mem, int irq)
 
  err_irq:
 	sa1111_remove_irq(sachip);
- err_clk:
-	clk_disable(sachip->clk);
  err_unmap:
 	iounmap(sachip->base);
- err_clk_unprep:
-	clk_unprepare(sachip->clk);
 	return ret;
 }
 
@@ -928,9 +918,6 @@ static void __sa1111_remove(struct sa1111 *sachip)
 
 	sa1111_remove_irq(sachip);
 
-	clk_disable(sachip->clk);
-	clk_unprepare(sachip->clk);
-
 	iounmap(sachip->base);
 }
 
@@ -1048,6 +1035,8 @@ static int sa1111_resume_noirq(struct device *dev)
 	/*
 	 * First of all, wake up the chip.
 	 */
+	clk_enable(sachip->clk);
+
 	sa1111_wake(sachip);
 
 #ifdef CONFIG_ARCH_SA1100
-- 
2.45.2


