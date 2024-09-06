Return-Path: <linux-kernel+bounces-318477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AC596EE86
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86D581C20D59
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEFE13A3F4;
	Fri,  6 Sep 2024 08:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="AxVaFC6P"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2040.outbound.protection.outlook.com [40.107.117.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F4914A604;
	Fri,  6 Sep 2024 08:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725612531; cv=fail; b=MKIoZ6y1ZPFeV6ww4Qpahe1CsLuMWFPIKgtYb7UeekYJ7ek24eoqFxm0IvlicQjQiFU+u7CN0lYlY9FyayuLAkppY6tc/P4Uyi6bkmpOOgWg+tZLmJTW+lAzb2BBP5ja+9gfoQuq0jitowAGOAGQ6hcJJImA4KSf0m/aKYSm3dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725612531; c=relaxed/simple;
	bh=br+KbSr/R49/jDdaTyxQYWW+Kj1XLp6IRtAvrmWuoc4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SXfls11Mdq+bcd0Q3UEYGpPrtJ4PuSQ+oxNdEPNnv0luBBK4i0UtYiMftXZf8Sp0JY45g9n+V1XCG/uSug1aA94Mk1u9y7baRbyGsc8qpNqLjLoU4lOfiOVxJmcgQpjBvP7agE1a1dsrruOTUxFBrOm4fHnVU3l5u14yLgMZ4lE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=AxVaFC6P; arc=fail smtp.client-ip=40.107.117.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xWFe3Auiprok0dLn9G1s3w8aXnMGzjGeMpj6BqWw22wzf4At42GPUO3n81y24M32ExZFU1L9xUlGl5+BdaNdHSN9nZiVFZBXuYlwqJxv/Z37fz2e/Y5qtMOy4h6+PQ4EIbLMfFSxBiVx6RWQFslzTfSHta1pe2gRhxRoYvpdZ63hJaRgnJ1o61ql1HZYuJadZYPVXX+iExc7zLDpbMwOESMRoeoFUHfoe0iabkiuQjCcflr1DxZUISwyOGFEeznZRMZISLyLQLjZGJcI0hSnWMj6Dc0ktyJP4hgto6PmeG00WVqBauDxPbFuBkBhBKZ0ffIkCasUZaALQZBGMS/+8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KM9+DEJDwWJR1HyxZIJdNOSwggXe+jw9Cyj0xgdURlE=;
 b=CnSVY6SLdjvyRrnh4YNMLboni8/Wts2x6zZpiLi+5AO0ZNdJvaNHehrTaGr6xUjlErPgiE74BLDwJan7OM+sopvCUIDQwlzaCZIh+Av4jK8BFnB4wqtrQ3nV2sH57ODmkf+CZeAyxGWqXiQBNoorsUhp4M1zv3l4CkZ12V2D3zV+KhvhW0ciN4XylHrdTzFNM8dG0tdPBtDSFGMAJjTL7X2H5rRSw9z+kDDwuj64/c0GJ1XMoyub9SQQgVJhWm/3Gj7smOtkAiUq3oTpLxUVZgJOKb3Wzlr4J1LeMJnHD/K9s43gdp9WlahsJ0JQFHLHalzZ2AvtW1yCz5I3Sad4kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KM9+DEJDwWJR1HyxZIJdNOSwggXe+jw9Cyj0xgdURlE=;
 b=AxVaFC6PN3gnxLeqQGEFmZG4fqbxCoZAMxVNJD4SwE+a/cQ/DHbJc2kIimk/c6NNN98zXBVnpGSTlsmVl/vuGj0B6kMZKuIa4WmUBf6+Lp5FzO5twcxYJxR1oAJ+04S4OpGRtPvP6KJOvVxUgpR0OmArAPIcWppI9e6R4cVzv+k4OELXrw8GPID0odRklZRRcIMGpN153wenUwa1vj2CE17b18m2dm94em8xBwRQavUDawMIRCBCiBcL19toSOoUWS2/pEslP9wipK0V1Y3b74tlRxyLKEgbCHj3f7nN0xFWlv5EBPOi5qk91Ynm8p83BkYv3PD/IkGaEZ9+F/y1rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB6332.apcprd06.prod.outlook.com (2603:1096:101:123::11)
 by SEZPR06MB5246.apcprd06.prod.outlook.com (2603:1096:101:76::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Fri, 6 Sep
 2024 08:48:46 +0000
Received: from SEZPR06MB6332.apcprd06.prod.outlook.com
 ([fe80::6b3f:3bee:4364:6919]) by SEZPR06MB6332.apcprd06.prod.outlook.com
 ([fe80::6b3f:3bee:4364:6919%4]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 08:48:46 +0000
From: ying zuxin <yingzuxin@vivo.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org (moderated list:INFINEON PEB2466 ASoC CODEC),
	linux-sound@vger.kernel.org (open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM...),
	linux-kernel@vger.kernel.org (open list)
Cc: opensource.kernel@vivo.com,
	yang.yang@vivo.com,
	ying zuxin <11154159@vivo.com>
Subject: [PATCH] ASoC: codecs: Use devm_clk_get_enabled() helpers
Date: Fri,  6 Sep 2024 16:48:31 +0800
Message-Id: <20240906084841.19248-1-yingzuxin@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0206.apcprd04.prod.outlook.com
 (2603:1096:4:187::21) To SEZPR06MB6332.apcprd06.prod.outlook.com
 (2603:1096:101:123::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6332:EE_|SEZPR06MB5246:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f6d2bca-b6de-4e07-1747-08dcce50b7f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+44F/9GHENm9FHuUnmgxD2eXH9zk/dG7aVGEb1ovJO9xpR/sYbP9RadmD0Sd?=
 =?us-ascii?Q?qgp87ZwBoYJmXT99dht6WRWUKW+aFyiiltoY8IdLBZvHctwpzC9LmkMWp3tN?=
 =?us-ascii?Q?woJpLO5nqYqkWk4jG/i8dzsiuzVGO2kye6Hx7WcYY686TJdu8HRfw+WhQpq6?=
 =?us-ascii?Q?aw/tzuLdMkxKWBL2jd7G1XmbpVV31BxPUaqz1tHgKHkewLGoV7OxGS8jEDSE?=
 =?us-ascii?Q?r78E7v7o0GnlgyR27axaOHy5xe8MKLB2+P34inv8kRZBRtCgL8ry3yMfw9IE?=
 =?us-ascii?Q?c9yvaNq+zIurnKDx/dTCojEhnuw4S9uC1ypTUuX1QHSchU5WAsFl38Qu03uh?=
 =?us-ascii?Q?VmYDDDsyhLHNHOwBYI4JrO6dg8vl4mGTFPxps2nJenC2ZPlcV4n+C5p1mxbM?=
 =?us-ascii?Q?d+C8ETC6fqKUJPZfyoUjZ+gGVsaJwOalCjGGSh8jZ2tr/XX8SumudAQcIHpl?=
 =?us-ascii?Q?hAiPme429XyYzoUjgQ9sJNBfcpATWP3cXR9A1cSqycanfqpTGQuWoQw46Yy0?=
 =?us-ascii?Q?gGiQVzpFLq8ExB+tJ4cctCDZytQD/aICw0T44Ae63VcayHBMKcAcuLv5pvHV?=
 =?us-ascii?Q?ZsByqqqklpL2o+hMsEsyZdDnHY627ryIwb4OZl+CmYWruI7vQpFahtcpPKhr?=
 =?us-ascii?Q?Mze0GWW5EAjSWrF6JUAmLPocBVbE8F5gx9+LO0Fs0IWqNuqj19V0i5mP0iSD?=
 =?us-ascii?Q?uj5pg6f5P/xdR4hkYt+4e+1IeQFzaQeDSynXZtI5/DmAJUAGXxyL22RmB7S/?=
 =?us-ascii?Q?g/ACMoAD2BX17LblrDIxWHdTMs0IV6Hv9LzDpojKRa9ESZOgbO1vd0//94t8?=
 =?us-ascii?Q?Jwk3lx7VTCubvjzpLnb3IwG+SbgEyhJe3wG3j4AT+RPROMkfvmqHhAK6kWwr?=
 =?us-ascii?Q?a8R2sb+/1jQ3POEHsaQfqH4sVeWQzyTGnMQ8hWUsIMDJKS0MhLOmC0iOLbTG?=
 =?us-ascii?Q?vlKhIysiXyXkhQVmvKbbVXJTBlK5lkVP7fgy3oOzo8My1kQNKe4CDbVCC2Ml?=
 =?us-ascii?Q?vWvJXqaZ+V+Je3kvpJjTW/QO+2vm+ommZX7EQyQUetBMaqkYz+TDG8+aL9pp?=
 =?us-ascii?Q?F6mSYPemuOphyQGpz9PQ1dxBKb0Wmr00KRoxxZXp/E6S9pGyMyi77gYVmkDn?=
 =?us-ascii?Q?dqnCkqgVgmRUFwQTpLILOew4SO4I0emn1kPdiZ08zChmt4v1XsieGm/WdGqP?=
 =?us-ascii?Q?rLT23oFbBji66IKBXfIX/xK3L3LVOjHEs+A5Q98Axy9S0RaWRdgZXr3dbDNd?=
 =?us-ascii?Q?PiT2lVhOOwk99GYMckPArKEd7+dEZw+o/XNACorUB1V/UvY7ezUk/kKb7Iny?=
 =?us-ascii?Q?4LnV1FC/NIRTeMt6HoNLBtjkGdMXY8gbGmyyAiZlbkezvUOV+CqglQUqPX5o?=
 =?us-ascii?Q?Wdu9MWQmkSTBLwCsN8BYzFJ0xYSHCyNYs1bYhz/DNruzJxRnLw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB6332.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LFJBtRlIVBJiFrS442y6qqAN4y+CTcINcqtHLb+dT0sAlpAgvGoVNBR4BUBQ?=
 =?us-ascii?Q?VJSd05sX6/pedPodB8wANIdYg83Ak/1nWgyxiBqShNDn25laiK9yOzulxmyv?=
 =?us-ascii?Q?dyrd2XjAaxhe4DS+mylHz1LPbhn6yv87LTmkiEtBi+SNsbh4B5jUrWhJP7yJ?=
 =?us-ascii?Q?KRw8jJ1Q2gv/EarpcpYTWq5DgmzSISGVqMuyPpwKk2OpQasAxAK1R2PgWUdS?=
 =?us-ascii?Q?1Yr71e3Hsa00quUKCWbMYZGxZ+bnEehj+rEBPDeYNfOpdg9fZSvFw8nXwBw2?=
 =?us-ascii?Q?XFZdTmm7zi/NrOInXD72v07fP5QcobK4EdfAq3Sje4kwZ+hWiLMwD/+8H2yF?=
 =?us-ascii?Q?mkiExnVK7b2fXR0oQ6NZLf5MzutH2rIlwZqGUyhCO3d5pC6A95C7VSV1rtXg?=
 =?us-ascii?Q?V8N0TlgW83sK7fLdEkT9FmB2pL3cbTgdKRx+bothUGVF2iGCuwjZSUGTTm3o?=
 =?us-ascii?Q?fKnJPEioaPX5tSw3jU79PoXLIav1j3xuAgo9OZpx03Qh5z3IKiRS4LTCiT4h?=
 =?us-ascii?Q?AfDdTrTv1wEUdkLFB7+s7ckuQ1FmPT8H0pQD91u9h7NLEF3mKt4qqMK3a5yY?=
 =?us-ascii?Q?v7WkX91zCU39CAYGgeo0/eM1gR7a/sH61/8uo1pgOKXDVGNzfmMZuSPYuZUW?=
 =?us-ascii?Q?GU8lRjJ6vTG+F3FBF9EOO+0xR2oXkls02NMhHlH5MsHk9rzzi0Nkb31RboBb?=
 =?us-ascii?Q?NFLE39zXIZwqoMViMGfv8wPFeOT8tF/FJFrAYzH6zND1kNNKLYrz4GyzH8KP?=
 =?us-ascii?Q?JuUjGbLX+1mJIuuudXalD70vNFgwnl3WlH7j5oFh8R1rqXIHovgOU6SMaSSm?=
 =?us-ascii?Q?3g7ARFVACODJ/jtQEHBl/F8cA1jTVzYBQr3g47OZO88G0HXNvHQictRoDYsE?=
 =?us-ascii?Q?5OneovY8BYNvedy+ZeCIZBP3sdU8tWCLnYb+hIoK+hG3mM6bBno1iFC5s+yw?=
 =?us-ascii?Q?ewYRn3vvNXtJozjm9D3eve5l1ircxF8rnxdp5wztL/IOb3YeWuUrHPycb0nw?=
 =?us-ascii?Q?g76GD4hJqAn2yf9yGEOFl2/Ej24YFlPPdx9dQtV9ce0ZBGHJrcPX/VanfV3e?=
 =?us-ascii?Q?92nbg0A2BlxABNq8IE2HsRorSnRTZlryIG1CajJDMwmEw0CqYnqtC9lUOu2K?=
 =?us-ascii?Q?6DrV+2zKGqicfkjyIkPEbcR4jwwjHswxaCB870x8GTS0/KbofYd1HbgFceBa?=
 =?us-ascii?Q?HjV7F9+2HevGhRbOM+kvPjdxZX8SanwW0/pLrSs7TItQO3gITTgFw2I3sQKf?=
 =?us-ascii?Q?xDJPrwDwepnIgNN837Oy8zEn6oZYYontM0+AS+Z/z4CT+n6VNjEw5gK0ZWgG?=
 =?us-ascii?Q?FROxCnfDbsIsgbdxjTwDCEh4RRWVd0ZGP/SoP1g5ig2uz+v9+G1V/R+q29ba?=
 =?us-ascii?Q?aPdFku5PsItn1iuWgqe5VZp8duIQVKVcBRyEZu4UjygIlda3kmHJvt7xtYI6?=
 =?us-ascii?Q?nHGFvePseUiEqqZNouR0e4HjevoclkfPB9hCUah17ZUcLbFdNNKcSrbHUerL?=
 =?us-ascii?Q?aYdj5QQfa6RslPh5VtjlxREM6PocUkxWjCsmzfPFoxDTxXSDVGZSEP3Y5G3w?=
 =?us-ascii?Q?NGoWlf5vDrW0DYKxeLJb/AT7MHv0iOtB8zSsFEp6?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f6d2bca-b6de-4e07-1747-08dcce50b7f7
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6332.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 08:48:46.0771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UpSD2ZLO4Y1fVlicfyiGiBoheIoCllHDg3h7guyDdOeMZDhJuwIdInC8c2OIC65IP/DlDoYW9G6xg3xbiGw1VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5246

From: ying zuxin <11154159@vivo.com>

The devm_clk_get_enabled() helpers:
    - call devm_clk_get()
    - call clk_prepare_enable() and register what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids the calls to clk_disable_unprepare().

Signed-off-by: ying zuxin <11154159@vivo.com>
---
 sound/soc/codecs/peb2466.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/sound/soc/codecs/peb2466.c b/sound/soc/codecs/peb2466.c
index 76ee7e3f4d9b..b67cfad4fc32 100644
--- a/sound/soc/codecs/peb2466.c
+++ b/sound/soc/codecs/peb2466.c
@@ -1975,12 +1975,9 @@ static int peb2466_spi_probe(struct spi_device *spi)
 	if (IS_ERR(peb2466->reset_gpio))
 		return PTR_ERR(peb2466->reset_gpio);
 
-	peb2466->mclk = devm_clk_get(&peb2466->spi->dev, "mclk");
+	peb2466->mclk = devm_clk_get_enabled(&peb2466->spi->dev, "mclk");
 	if (IS_ERR(peb2466->mclk))
 		return PTR_ERR(peb2466->mclk);
-	ret = clk_prepare_enable(peb2466->mclk);
-	if (ret)
-		return ret;
 
 	if (peb2466->reset_gpio) {
 		gpiod_set_value_cansleep(peb2466->reset_gpio, 1);
@@ -2031,17 +2028,9 @@ static int peb2466_spi_probe(struct spi_device *spi)
 	return 0;
 
 failed:
-	clk_disable_unprepare(peb2466->mclk);
 	return ret;
 }
 
-static void peb2466_spi_remove(struct spi_device *spi)
-{
-	struct peb2466 *peb2466 = spi_get_drvdata(spi);
-
-	clk_disable_unprepare(peb2466->mclk);
-}
-
 static const struct of_device_id peb2466_of_match[] = {
 	{ .compatible = "infineon,peb2466", },
 	{ }
@@ -2061,7 +2050,6 @@ static struct spi_driver peb2466_spi_driver = {
 	},
 	.id_table = peb2466_id_table,
 	.probe  = peb2466_spi_probe,
-	.remove = peb2466_spi_remove,
 };
 
 module_spi_driver(peb2466_spi_driver);
-- 
2.39.0


