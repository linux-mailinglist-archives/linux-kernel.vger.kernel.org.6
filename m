Return-Path: <linux-kernel+bounces-232002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A20391A168
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD5441F2377E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 08:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C7D12D214;
	Thu, 27 Jun 2024 08:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BXFYyNNm"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2081.outbound.protection.outlook.com [40.107.241.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06C77C0B7;
	Thu, 27 Jun 2024 08:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719476810; cv=fail; b=iCtGbWtIEAUwEp2oiY+BpGNzQ55JDKg92h6RnpDYlOtHza5rv+hpCoJd8aSS76i4/+zJa4qwE45gjvqCbAm4R1woAGvxzd/6rfO7fKHPYQFmOQgZfDy8J7p7kJmY/aGIAPXAe8DxH6vpVFZ73cnn7zI3IferpzAqSk00ecdg+1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719476810; c=relaxed/simple;
	bh=/5TolYk+Muhf0OSSf7kbfD/hSmIbDBKsjxn+eqGG1Gc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hzk+T9lI/cJRek+xRGE75RssCrysZ6nwJur+ZlMJdvZZR3Pm/u0mg+YO+MLDA7QQV65iJfRb+f6tM8OPrsG1JiZeOXXq1QyB2If7PbvePrfZZn5yto+ya5iFR7pu8zx+BVJ5kzK8z2THq4+0RvGwYIvkutQODnxCS8Dks1nXEM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=BXFYyNNm; arc=fail smtp.client-ip=40.107.241.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5DqunfUJm63ssiZk1N7GfvuNa4RVEXeWr6hqtAak0FYvzRRefRyXo8WCW0Tos7zk+RRUcRwyhQsj85nF6B/bIyuYCqNk2nJut4DFQV07694asb9c9n8EJ1jHEpB3JN+RSY/b+gRGvkb4bpAVe1I1crs2mOf4sXdvoetxB0aqqyEmJ/BN8pJNrDgrHiX3WPRXiKIpXFVfb8xEKw/xqlGqCoqoeWzjEEL+SjAyHtgEbmaYKlmW7+U5MEgEWo7QOi/6/RUKy5YtIpp9c1Su1J0GXMln48Brb2LO6Yqfpf3fY70wjeyj5MhknilPIefECSzGSS/oi7t910RGejwh9OyOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eH2yKECXTCynWdnuI7zPFelG8JkiJ4ITeyL3pO5lK2Q=;
 b=kfGodI94oFTkwBlFs/u3dVQz48NY8LTGmMhfvr/DLg6FRgdGrzzNCZgwNB4uFZgy8duHb1IJlv/7i84PjDnj7IvaPR9uONhswf5J+hhiw53BRcW4jRWjdsb6wdnJuaqMOuC7WY42gIxJQXoPcBkRCxJ/UlGEkcI6qYfAIht95hIFsiMcPpBBKanAaQD3C7q5eTX8hIwac/CnMGmlDmnhqP4n1otX8nCJHECK6164Xhm44uXMLqDNPpJuW+74cwb4WOWr9aVq9ZYlKpG0eGarrGs6RQQYhd1BCIpEbvdidKRIh4u45YV4IBY1asDynpcMtsBaGaztyS9U6mVavdQc+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eH2yKECXTCynWdnuI7zPFelG8JkiJ4ITeyL3pO5lK2Q=;
 b=BXFYyNNmcPXTjO3HNvrv1tVhqeJRmLMHhRg46neo1C2XOIxF82eftQTsu2f4p8+3xCEqnjq6cch9o75lWroMeucUmDScJlQmi/paoJy/l3R/bmwBvqZfJDBse6FWTKdKzt+xas553v2IO/MnQbt/Y3BTY8jqj81JSqeCdYDtuOM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by DBAPR04MB7432.eurprd04.prod.outlook.com (2603:10a6:10:1a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 08:26:45 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%4]) with mapi id 15.20.7698.033; Thu, 27 Jun 2024
 08:26:45 +0000
From: Pengfei Li <pengfei.li_1@nxp.com>
To: krzk+dt@kernel.org,
	robh@kernel.org,
	abelvesa@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	ping.bai@nxp.com,
	ye.li@nxp.com,
	peng.fan@nxp.com,
	aisheng.dong@nxp.com,
	frank.li@nxp.com
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] clk: imx93: Move IMX93_CLK_END macro to clk driver
Date: Thu, 27 Jun 2024 16:24:25 +0800
Message-Id: <20240627082426.394937-2-pengfei.li_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627082426.394937-1-pengfei.li_1@nxp.com>
References: <20240627082426.394937-1-pengfei.li_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0128.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::33) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|DBAPR04MB7432:EE_
X-MS-Office365-Filtering-Correlation-Id: 22c66be0-436b-4e76-a4bb-08dc9682e17d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MqQz69IWmQvUdjR+df6BSqOPSnE6I5hZbk/8grFrkTt2t+bRWxGRwD9nOy7I?=
 =?us-ascii?Q?FukFGpNH4mixD4ZUU6mOC793Zc/2ckB48cj8XimzYx3dWKME5zjaVVKDwK7W?=
 =?us-ascii?Q?3x0qJW83JbmkufZwkfoJ0R6ss/z71BQXMCaOm43EqK0QqWkKtR4dUo8Qd2p4?=
 =?us-ascii?Q?ic53OxLr3yuOeCaeiTdQOMsr5ZgHcwLvaPoJqUL/cTJekNdMeV1tRq26Aff3?=
 =?us-ascii?Q?YKGYfKNnI4XhC1bAGk8L8mqez2/C9t0AI5ACIqijHYKxq9hO6OSlSMfplwLm?=
 =?us-ascii?Q?9ZE2vwUHmbedf5bxazMrYlkZVinQSR3BmD3uYB7qNfglgVdftimCCmqAgchR?=
 =?us-ascii?Q?HTrTf5mHOI9Zat9qt4ru1QlkzSKpra/6vpkxzLhyrsJlvUjF8Ld/ulqmf1zP?=
 =?us-ascii?Q?ftnt4ggKNCchdUkfzogHvIMWnOzhZQ1I6A35RRdEH7n2EKTGSIbJ6uhHjm2s?=
 =?us-ascii?Q?X7LKdwJjengarFoXeoNWPyT/o6qxsQUdzeUt4riQ19r5GqRD3gMifnikXTt5?=
 =?us-ascii?Q?vRB74saDp904WecmCYEtw9tml5GQFtkrQhD8TKKcUN9a8Eb6b+X6zNP/WOKY?=
 =?us-ascii?Q?ABJuXUDfx83gv2EOoGaT6Fp/kx02IM0X7LUlY89Ym6zJsBnfCpv6t9IIuTOt?=
 =?us-ascii?Q?Kort6FG7X8GWz5mim+htrx12Zf2cgo5jgM/QncLQSlHw2jRCEyrecs3XoZhO?=
 =?us-ascii?Q?2TaX2SbnjGGxTL7U1chiDMAub10cw1vnEzasr0sC2f3QjEsjp+5Lv4FWn/N/?=
 =?us-ascii?Q?TMXcabye3H69hUAjHVi6olZ3U+O01AKdhjj7MKtubtNEbPgUkcwVGcNbejTV?=
 =?us-ascii?Q?fHgW+ZsKXmrkw4KlZ8/QtRUZvnyfyGltAh4wUEJTBdaungl8j+s5jJ/+V0vR?=
 =?us-ascii?Q?61uz0WbbFkT8iiPeHqfXoU3VFdLK0Mxyqtdh+QX9R+cm06ulw7JhvTKexZxW?=
 =?us-ascii?Q?I/IAz4cP1tTEXTZYooPhYwoa5yg4j1FcsNbL9oDJ/Jmf4hzZR6PZEtiFTavG?=
 =?us-ascii?Q?iwwdgpabZo9ezZ200qM49dfgmT+STbVbu/o08Ah0feaBzCBxuLqLLrO1F05I?=
 =?us-ascii?Q?sbtbdFHls/cTVUQYj+zU4RECss6dloA3uKa39desp64p9SLP6hT0d+6dgO63?=
 =?us-ascii?Q?HdZeEA5hMfJZ3jDU9tE6/JkzAksM8LdORnqjM8hzl+YSddXu3umO2+wqrwW1?=
 =?us-ascii?Q?gNsiU+ELbrZQWetkG0ElLf4F/TzWtlRwHbt5gqmQyixouH/G5TknZsABi6+9?=
 =?us-ascii?Q?iVA24ljjQnE71yZtET3B7fltRPn/Bb70cQ47/pRfFI6xEIhJxOBNFS0C+uuO?=
 =?us-ascii?Q?5nQWuhL2THtaxUw8COmPZ3JrsFcUtkX8FQZBHzd9xogNuXiDB79w82WcT4bL?=
 =?us-ascii?Q?79Y9rRcBfz0BkaeqqVU5pRQV9XEQvZS6RW4smO8KmSEKrzURdJR9m0vUamHm?=
 =?us-ascii?Q?2C+c7e9hfIM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tuY8xlQfv9daw2+vPyzEzOvTs2BYCuWg34Ve4V19H/UuRmV5CIYWWno3ifJj?=
 =?us-ascii?Q?9lU4kuWV6bpMWt1kfJWmhwNZx9IAKOC2ZS8keVdaTiclpgUJW2+JYkfwrWkX?=
 =?us-ascii?Q?f1xQt3OfBO4Qwbp8KrPclnjFaoW9mWBArYbOj2MHP0lDLhQy1tAMoEGPGHp2?=
 =?us-ascii?Q?Ok/OvUsfPvICkWTCoMPsu0C0JyCItxRQPsAn33t8z19aKSwxUcDecasLcWXu?=
 =?us-ascii?Q?yPWf30eXFA29Res0y9YL3aqVjbSPdIK5ZOi8al4srLoGaHv/tHg2fbCUsm5k?=
 =?us-ascii?Q?34CjwbM9gXhDNLmNGbCgz6eAiAfWiD1MbFPlvioQh4LQej1C3m39ZemDgorS?=
 =?us-ascii?Q?8TZVHWOrtlk/x68KwkEF/p3JcJRGnEDBy5BCiWLKxWVDQvwLavs51oX7lk/o?=
 =?us-ascii?Q?bo8X41U8kw9eK1kDiF6olUnloXhIdVs94zaUt3y+kuXWdPDkirzS4cCWWq41?=
 =?us-ascii?Q?XJ8kJa9gBNeSylhJVx5ajla2IAnXYXPZjrXiCX2ew1xNVJplQyln+muTxunt?=
 =?us-ascii?Q?qG6ElN2EOEfjvm3lhzUlvklI2cO5bPRs60fieY0NW+LevgL8UpYC4Wn1CWNv?=
 =?us-ascii?Q?MiTXklYfiIRI0orNcDY7rcJNJ8tXvZNGoiafXsPJ3i3vgSOPm6kJtXVDBDny?=
 =?us-ascii?Q?g6ib/g8F/B3XmnBAJz94YgmexUQU2EUUMhMjXr9aFzc6GuYJY/2VUTBSowoU?=
 =?us-ascii?Q?L4u66xEu+Zwy0AzZhNf+XLUm60xx9xmJ0eZdphx20YIPBandFZ9aDQhAHIR1?=
 =?us-ascii?Q?X27nInTlFzBxQURUMYAhdWkvBW49dn0eNGCwxcKUK+Sye8ZyxlH+ojn1J4OL?=
 =?us-ascii?Q?5m7yq6PCyQ8mSBExi1gJzfVR1lFzbfS5JIGoy1J5p2rc3UmzAwJ9D2WPtoNa?=
 =?us-ascii?Q?8d3RgfYHOIQ4RXGXkp5isleLcrf2k0EE1CHo2xSS4mIe4EjTQ2UhpElu/bRX?=
 =?us-ascii?Q?MEcsmUz/zSkRW32Vh9KpMJMVKPK8SV37Xlf3kCxXlLcLn9wFRH04oLG1oLbD?=
 =?us-ascii?Q?OgYGvX0W48bNjdasIgseqcD23qdYE0kNZoEbf2TdRuTjT7LWEYIyjZfhfcFA?=
 =?us-ascii?Q?XFVngfjMWZZOH8bBj0aOsv4/QNn9G8g7rLMOP6u8qdNKchGooHURKZHenljP?=
 =?us-ascii?Q?u1BgalquvMkGDMu039xoyuvs5nNKCQYzMCk0ewpLhD275f1Tq0jmG6lGRjEj?=
 =?us-ascii?Q?J+DkYawdpLEHQhSoUM7po8FjEThk/6ZkSoKsOj3fQgrXKWGbmD17jQGuKdah?=
 =?us-ascii?Q?gFEM74Jm6QFhjMviIz6NMiZclfeNy3OlVbLjcM8sThFlnjY8JHVCNaRDpncg?=
 =?us-ascii?Q?uCf1HCbDgtMnNJknezG9opWkooek8Jz8q4gHJFbpwooDWzZr6p6wIaMtSf1m?=
 =?us-ascii?Q?iJmCDNV3CVdt3CTnEnPKlTQBjpmGVPHsrI0Fp9DeNrxKSgCNiF4Ehb37LGSh?=
 =?us-ascii?Q?31pEVwOnbsY6UfXzJoWbY2hyRYBeNGkfKauJSkyIASeaEJ/rL4qjzQjhHOPY?=
 =?us-ascii?Q?aytbh38QpM4D2pHRAZGk286g5jsHutK4HnmeBO2XjpjCr7ViUzDEZk0bSALm?=
 =?us-ascii?Q?xPMr3AUbL/Ma1qLz5SOW/sI5wud344IGCdwcFyR+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c66be0-436b-4e76-a4bb-08dc9682e17d
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 08:26:45.7511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEsIQF6I7hGF1CWQvPQ999ZePhWBDBZN7Cwc0urM/DcMqGE16vo1iaxnbzlYwOL91CwQOqeDJEqYVkyksoLKug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7432

IMX93_CLK_END was previously defined in imx93-clock.h to indicate
the number of clocks, but it is not part of the ABI, so it should
be moved to clk driver.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
---

Notes:
    Change for v2:
    - Use pre-processor define to simplify code.

 drivers/clk/imx/clk-imx93.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index c6a9bc8ecc1f..c8b65146e76e 100644
--- a/drivers/clk/imx/clk-imx93.c
+++ b/drivers/clk/imx/clk-imx93.c
@@ -15,6 +15,8 @@
 
 #include "clk.h"
 
+#define IMX93_CLK_END 202
+
 enum clk_sel {
 	LOW_SPEED_IO_SEL,
 	NON_IO_SEL,
-- 
2.34.1


