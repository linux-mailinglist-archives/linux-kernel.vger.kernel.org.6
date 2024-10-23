Return-Path: <linux-kernel+bounces-377240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EDC9ABBD7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 04:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16B331C22D73
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 02:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE4312BEBB;
	Wed, 23 Oct 2024 02:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fTLqLTSm"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2044.outbound.protection.outlook.com [40.107.103.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EC213BC0D;
	Wed, 23 Oct 2024 02:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729651664; cv=fail; b=s1Jz4Ce8WQjVn1nGbllZK5qNVfpf4LfcJq3WpTw1TwJX0LtEIr5hAWoiGhkK8sCdaeQk50qNEMwD7CMIoUYdt//Lype8RtgqO0tgwyXhB+kX2q7l5fhpf1eGGe2XgGw5G+k3WM2HmaXDHxKrMd58TDbsaODFHNLTMFAmsMbYwxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729651664; c=relaxed/simple;
	bh=dsJUhRf3WFwwdBnoQgPyqzl1gZF/+HiiOZNZZT4YVGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GbSyiWQKKnp/VB+BffkK1nnm69aTpLmIc18LJXLM6Dy2aAVajRIUxnv1XqpoFpvfeE01xPHmN/DGxEe1iZJyRpAdKd3zPby/VZTtCYyuS/pVB6P4btbCAOVXObHADnN2Bt3vYTrvB22EPsMw5z0BPu27qeszs9b3VIcBtJ9ZqV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fTLqLTSm; arc=fail smtp.client-ip=40.107.103.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=usrAm/ADXA5eIUQwk5zDgLsWpnjL3aNMXWU2BwTk6r/NVEaBnsN8s0Y9dMBeDhP8Rl+vo1YZjB67wuZy6LY9EA70qsEpp9q5+eCyWIvumHd0qQgA3FiMoxaDTK2Yq5LaZT4WYyXD+YhY0zrQK9DzZCKjGLTjysuYXsuL783AsvJoyrEtpdeDxe6Or6Rf74yjC9P2hv9vakBh8EzEqHvNH9Cnc5YeECZHUeAN42NQblCirI6QvvNO1D4rFhR5JJbN7Zv7ZVofpOUqS3jEgZcB1iuNZdEywTfQo6WPqPjyGEWVMj76317imaCrdpkAId+ptBJjekP2vuapRsCYu45rTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0n344qQC3f8FUTADAPFjyF7uantGbrmJpV5T7shvyk=;
 b=QYp11jvRc6mLZ27KGHyE6OaZSAk/s9Mim56FuvsCu3k5yaGryy2deSxpBmzspP6bbKJ398m3vKmuV9wn4qTMXsrSwa2zRK4fP+iD09zsKK7zaS643eCDm0tm2S5qf7bNjM/8jz6P/Qjx4gbxetZVHKAXejKWgvTvAPNUggEY92I0TC4DQ8Eq4+eOoQxCBo6NLQ01cFpNRYIPy2FgDYVP1xiSHwqVUTtVz3flfB4i6fyOmcXo8ENMrPzvA1h1uQeH2VGu1aknxkVmRepijey7rV2JFY4i09JIdr2VmoDzF6rQnqsrD2UiH8By0wYkB8fU2VMEiJGcXS2zOAdSQ5mOqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0n344qQC3f8FUTADAPFjyF7uantGbrmJpV5T7shvyk=;
 b=fTLqLTSmVcWNvJC5sUCuEiP/XsCKcH/H1OVGrE9op0zA+fj0RRHoPlf3nChkEbnWVzCeFXX8BgrOV6ciMZ9uOQhaX4NIFITuS3z7AlccZH2pj7/YoB6OwhCa3hl/5pO9T329t8SqzS9+1+SSDoWLwmsf+RUyC08axLZw0gyFIIYtc2IF0XZdDEVmrgiOcAmUN2U4pH5SjwdxaETVqt7qpcpegpVXV2KA6mJGAkbvU4yGqjxLsoTY4HQsOEDGUb+wzNybdO5dVDttHOJgNn3/1noa4cDT7epUv8O0EKHRY4hAwlMmxVsg1RWV1DpRTiK3VM7uWcWRrsDoBtdKv3InBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by GV1PR04MB9216.eurprd04.prod.outlook.com (2603:10a6:150:2b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 23 Oct
 2024 02:47:38 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%6]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 02:47:38 +0000
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
Subject: [PATCH v6 4/4] clk: imx: add i.MX91 clk
Date: Wed, 23 Oct 2024 11:46:50 -0700
Message-Id: <20241023184651.381265-5-pengfei.li_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023184651.381265-1-pengfei.li_1@nxp.com>
References: <20241023184651.381265-1-pengfei.li_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0118.apcprd03.prod.outlook.com
 (2603:1096:4:91::22) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|GV1PR04MB9216:EE_
X-MS-Office365-Filtering-Correlation-Id: 2adb2154-c45c-4ce8-a22d-08dcf30d0e94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nyJZhq4qI5eOmS1WCrvHjr0sA1ZtW/gJ7z7RPvPbkmbS+AYB6gXidbwun+aq?=
 =?us-ascii?Q?HCzsX04aZ44uk/Cf+CXeQeeTmJc0tP+iMaQR99XLqc2PKjANqQncp7jF2fqm?=
 =?us-ascii?Q?pBafbNcWu2D7Zx+o1rXO6Fr2jCyQMTOFxo3CSyaL3eECP08nZD/SdX9vYmhu?=
 =?us-ascii?Q?fbZFgCJpYghngDYfPjZslxaHZEkvZlfnl8W3j8J6P014oku5vKIytv7X0p31?=
 =?us-ascii?Q?KNgRKfJW9TAlMVYgjhwf/rSo3b7l9+tSJeO3I+7HGNWT16Ncel8kO6bZ6Sha?=
 =?us-ascii?Q?bCy3qURfVfoDrWnvdD07abdYMXtc+JOVlfjDVOHceBHw65bG01SRbdKswed8?=
 =?us-ascii?Q?n0P+pbeAiTDjNb5Zv6H8EbsFbF4kTjiTCqJDbi3uWV6kxBf40jJsQYl7QRfG?=
 =?us-ascii?Q?QHQd6arMYBXkg/J1IIBNdVfvabRbXiUQAmP3b189jEjG28iQ5WR8qjLfVysR?=
 =?us-ascii?Q?RAeN2BMafrG+eAqypKfCfkyz1v5KXxjcM03RXpA83DpoCTkvbvKTjJprvXxy?=
 =?us-ascii?Q?iTc07EFXutxf0ASQFeCKTNQwoC7/EP7YD1LYmvoqz2aDsmDMzgTlf2ntjPNA?=
 =?us-ascii?Q?PX1pUShy2NqUQUjvZJEHZztrNNMzxIJarSm6JgL3FhzF5lTp7DxHYEYJEo2a?=
 =?us-ascii?Q?wsnN55ue7Qkhc/4M/zRPv9x2HCPdhKZZxBeM8hIfxwBlzV1iuL/cCQzUzkdB?=
 =?us-ascii?Q?GD5BZCRjhMSHH7Yx3wJ9dOnFUoogHF9F5wGr2WpZaJ46n4DAnOgYfIIVX3Ci?=
 =?us-ascii?Q?X5VLcFROGJS4HMLT211La0shSCnMLQImeUI7dU6M8NT2NmO3A4A/I2NPcSSD?=
 =?us-ascii?Q?/poer5I21n+bFl5j04h/fpgH72zFkGEAry8XRBKMTry0jRLbZ1RDwg4bkviu?=
 =?us-ascii?Q?gJ4kWkMqytHejddp4rV0pntbejXL/yN6dn47a5qVTbW3dFZ/PYeBHP0QnpaU?=
 =?us-ascii?Q?jxBQa0xESBxk+/K/U9MM4aS3hsOtsakb2AylM5snjPBkW0j/JItjrT8tId3T?=
 =?us-ascii?Q?HS2r3SH4qdfcPz6eXkwCqu2nMRLoGu9n/Ikm47igFpDjA4QYknk2k04ZK8Qq?=
 =?us-ascii?Q?//5SUEVcZgPLGLZI9dx2Oyhsa1S00jaxLMLr+vh0Swd5/Jdgw1CcRdhJ0hvw?=
 =?us-ascii?Q?NSYNBZjFynSr2L9uV9puCpJ2BZL/z58XAVUag732x4RPnbfhZYFCp18d3xwu?=
 =?us-ascii?Q?jjYHXxYkE6e/mcUNUrNNjOVaFPqL8mD3OnQ3IpTHafOydHRfcreKn2WYOgVg?=
 =?us-ascii?Q?3uz0kbHJg9Era+CDTSQhrlpETGYAJAGbJgOlwzarA0Yt81hZcETpcCqm98M9?=
 =?us-ascii?Q?4EhkwtbijcM94MwsdVHhEATwCO5C52/cjD7I/lX5isw4oNTXXweTRn0L+jBK?=
 =?us-ascii?Q?OIj2X+HfBd6j6vPvkJCF6krmPK7w?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pihp0AJguZkejKxzdN4Xv6sXG9oYCcarUW3We5/3FHg3NOMM3IWZtzjJX99f?=
 =?us-ascii?Q?JO3AeUXvJW9kJBaeARBuqiPnTGLjHSECQ/hGFaN+uQp7qYCNe3A/ivT6a3QJ?=
 =?us-ascii?Q?GkejFytD/2X5NPsv+iy1YgxIpM0vsJ1c8Q9x58QhT6n2m/A0rzIoDYuKywhS?=
 =?us-ascii?Q?nTdHXqDFsecnJfYRyUJX2RYUR4A1pDQMPREDWB9mVyhoSmj5uyTBSs/1vo0H?=
 =?us-ascii?Q?UhwEo6CX0OXrDoM1SDKEmq7FQa3+jOUUJniTvl3thG/uv3k/7GDEf4OEtYmI?=
 =?us-ascii?Q?cXuVsorrwYZv/7cfCZGKlSd3ssRuktgLb3uQgqARuz9epk7I4InEiifXjEos?=
 =?us-ascii?Q?7ta+/A/as2CZxbfZ4UdlPYlkxDkUnF8kBSpxm/3ZDM2xE7iuJytQHOH65xtS?=
 =?us-ascii?Q?ENSkAwJz8uJxfVstYdqvoz0zAqlCT+p8du/bHLq1rkDIAbt/AHF/qMyx2JY0?=
 =?us-ascii?Q?p+K0DeCZX5VgLsQWLKBfk7JpZZCkli22AkCxhOfuD+L1o+6aLjP8TZW98CAe?=
 =?us-ascii?Q?12zUXe1ss6iKeXwJQ2hxc++fwOsrRhI/r2z4PKpQH2B/pWO8jex9egINu502?=
 =?us-ascii?Q?sVagKkor7uaAODIs0waAr6jKrjVDZDDdGJWlll9LRNC802J6DN24efYJ20Oz?=
 =?us-ascii?Q?cZM7yzhaWUdG87b6n+R3IvQDY2F9SoZxmy5/QvqL3Rmqxo8Pp8f4LLcV1Qqo?=
 =?us-ascii?Q?97t2DTdEeHZdhmiLB4tAOrcYxZyAVow//SYaXH1ovk3wm97OThXJlp6EYcZI?=
 =?us-ascii?Q?Bb3UpD/a0Dvekx4WAFgTKEXFi4HVB4d4zcQnsSZJY1etJy+VWWvQUhmE8mGS?=
 =?us-ascii?Q?k2pZqllq5U2B/iJV5lu36xVjykt9wp4T8XaSk2Y+73ZORGToVQfj7byS0P5R?=
 =?us-ascii?Q?+734fM2dQklsW7s1UhA8/+uy8srlI/YGsEe+N6VjdA7Y680KlgJJUfvkrm0c?=
 =?us-ascii?Q?30LtKGupIxuUYCAJrXn3meRW4CFDzKa8iBA3dZw4mppfAW5qZu9+hlhFiWke?=
 =?us-ascii?Q?xYGUGyf/YwHv6j67i82mB0+Dcwk+M/4aYoQtrfCMCjsSnkcXjTUbMhkPEm00?=
 =?us-ascii?Q?RhOVnYhfYOr54BKEyViMJya/nzSmhxhgwMg44Qv9as2MBwSORLcFCiU0id4O?=
 =?us-ascii?Q?19JorPs2/nQA+djzSvHTRZprHi6CFk0h9VlG3F+HvB+LDjjgoQmjXw2U6KZc?=
 =?us-ascii?Q?HqtHVUavEFy4iL+McQuY5tVx7U41DZ+FHFyGDqOgN1sWXY5ovi/AlAqWC/I4?=
 =?us-ascii?Q?iSdO8xbKL/io8zmpwvZvD+kY6PYW0gvoheI5gHh+VjBNZW2tSFheNSYBtYtX?=
 =?us-ascii?Q?Z70k2Zkcb6CQLbQ/n6BM88q2dNddVmDIxX7XQppgYAbBByXnjAQ05F8J6POz?=
 =?us-ascii?Q?1oi+3zhX9ZJIEVYkB2FhIwmOHrfZ5Ki6uCjzGdf7Ty2sE9ZRM+BLU0Aj9Z/Q?=
 =?us-ascii?Q?gzNWkBI14hUbHlo8q3ugyqzjliM5zsMib7pF+fDA5eFxvcjDkYwVETooCOjM?=
 =?us-ascii?Q?lt02KQmnYVdibQ6IMUqDVHrIZa1P4CnDKujP8DLlCmoxXsLZc5lXbOcyaUCj?=
 =?us-ascii?Q?Dg7y0qvIn4LuY72lJmDTM6oJ1kcwHVQrrF5lMJgd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2adb2154-c45c-4ce8-a22d-08dcf30d0e94
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 02:47:38.7242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DHfhR0OMH3tPrDPVSDzc/JXc+9PYmIqrWWckXjJHG+B8cyCjQyxGf68/AYO5QvpMDL42J8bl5yvAFFPKmyEhCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9216

Reuse i.MX93 clk driver for i.MX91, because i.MX91 reuses the
Clock Control Module from i.MX93, with only a few clocks removed
and a few clocks added.

For clocks specific to i.MX93 use PLAT_IMX93 to flag them, for
clocks specific to i.MX91, use PLAT_IMX91 to flag them. Others
are shared by both.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx93.c | 63 +++++++++++++++++++++++--------------
 1 file changed, 39 insertions(+), 24 deletions(-)

diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index c8b65146e76e..58a516dd385b 100644
--- a/drivers/clk/imx/clk-imx93.c
+++ b/drivers/clk/imx/clk-imx93.c
@@ -15,7 +15,10 @@
 
 #include "clk.h"
 
-#define IMX93_CLK_END 202
+#define IMX93_CLK_END 207
+
+#define PLAT_IMX93 BIT(0)
+#define PLAT_IMX91 BIT(1)
 
 enum clk_sel {
 	LOW_SPEED_IO_SEL,
@@ -55,6 +58,7 @@ static const struct imx93_clk_root {
 	u32 off;
 	enum clk_sel sel;
 	unsigned long flags;
+	unsigned long plat;
 } root_array[] = {
 	/* a55/m33/bus critical clk for system run */
 	{ IMX93_CLK_A55_PERIPH,		"a55_periph_root",	0x0000,	FAST_SEL, CLK_IS_CRITICAL },
@@ -65,7 +69,7 @@ static const struct imx93_clk_root {
 	{ IMX93_CLK_BUS_AON,		"bus_aon_root",		0x0300,	LOW_SPEED_IO_SEL, CLK_IS_CRITICAL },
 	{ IMX93_CLK_WAKEUP_AXI,		"wakeup_axi_root",	0x0380,	FAST_SEL, CLK_IS_CRITICAL },
 	{ IMX93_CLK_SWO_TRACE,		"swo_trace_root",	0x0400,	LOW_SPEED_IO_SEL, },
-	{ IMX93_CLK_M33_SYSTICK,	"m33_systick_root",	0x0480,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_M33_SYSTICK,	"m33_systick_root",	0x0480,	LOW_SPEED_IO_SEL, 0, PLAT_IMX93, },
 	{ IMX93_CLK_FLEXIO1,		"flexio1_root",		0x0500,	LOW_SPEED_IO_SEL, },
 	{ IMX93_CLK_FLEXIO2,		"flexio2_root",		0x0580,	LOW_SPEED_IO_SEL, },
 	{ IMX93_CLK_LPTMR1,		"lptmr1_root",		0x0700,	LOW_SPEED_IO_SEL, },
@@ -122,15 +126,15 @@ static const struct imx93_clk_root {
 	{ IMX93_CLK_HSIO_ACSCAN_80M,	"hsio_acscan_80m_root",	0x1f80,	LOW_SPEED_IO_SEL, },
 	{ IMX93_CLK_HSIO_ACSCAN_480M,	"hsio_acscan_480m_root", 0x2000, MISC_SEL, },
 	{ IMX93_CLK_NIC_AXI,		"nic_axi_root",		0x2080, FAST_SEL, CLK_IS_CRITICAL, },
-	{ IMX93_CLK_ML_APB,		"ml_apb_root",		0x2180,	LOW_SPEED_IO_SEL, },
-	{ IMX93_CLK_ML,			"ml_root",		0x2200,	FAST_SEL, },
+	{ IMX93_CLK_ML_APB,		"ml_apb_root",		0x2180,	LOW_SPEED_IO_SEL, 0, PLAT_IMX93, },
+	{ IMX93_CLK_ML,			"ml_root",		0x2200,	FAST_SEL, 0, PLAT_IMX93, },
 	{ IMX93_CLK_MEDIA_AXI,		"media_axi_root",	0x2280,	FAST_SEL, },
 	{ IMX93_CLK_MEDIA_APB,		"media_apb_root",	0x2300,	LOW_SPEED_IO_SEL, },
-	{ IMX93_CLK_MEDIA_LDB,		"media_ldb_root",	0x2380,	VIDEO_SEL, },
+	{ IMX93_CLK_MEDIA_LDB,		"media_ldb_root",	0x2380,	VIDEO_SEL, 0, PLAT_IMX93, },
 	{ IMX93_CLK_MEDIA_DISP_PIX,	"media_disp_pix_root",	0x2400,	VIDEO_SEL, },
 	{ IMX93_CLK_CAM_PIX,		"cam_pix_root",		0x2480,	VIDEO_SEL, },
-	{ IMX93_CLK_MIPI_TEST_BYTE,	"mipi_test_byte_root",	0x2500,	VIDEO_SEL, },
-	{ IMX93_CLK_MIPI_PHY_CFG,	"mipi_phy_cfg_root",	0x2580,	VIDEO_SEL, },
+	{ IMX93_CLK_MIPI_TEST_BYTE,	"mipi_test_byte_root",	0x2500,	VIDEO_SEL, 0, PLAT_IMX93, },
+	{ IMX93_CLK_MIPI_PHY_CFG,	"mipi_phy_cfg_root",	0x2580,	VIDEO_SEL, 0, PLAT_IMX93, },
 	{ IMX93_CLK_ADC,		"adc_root",		0x2700,	LOW_SPEED_IO_SEL, },
 	{ IMX93_CLK_PDM,		"pdm_root",		0x2780,	AUDIO_SEL, },
 	{ IMX93_CLK_TSTMR1,		"tstmr1_root",		0x2800,	LOW_SPEED_IO_SEL, },
@@ -139,13 +143,16 @@ static const struct imx93_clk_root {
 	{ IMX93_CLK_MQS2,		"mqs2_root",		0x2980,	AUDIO_SEL, },
 	{ IMX93_CLK_AUDIO_XCVR,		"audio_xcvr_root",	0x2a00,	NON_IO_SEL, },
 	{ IMX93_CLK_SPDIF,		"spdif_root",		0x2a80,	AUDIO_SEL, },
-	{ IMX93_CLK_ENET,		"enet_root",		0x2b00,	NON_IO_SEL, },
-	{ IMX93_CLK_ENET_TIMER1,	"enet_timer1_root",	0x2b80,	LOW_SPEED_IO_SEL, },
-	{ IMX93_CLK_ENET_TIMER2,	"enet_timer2_root",	0x2c00,	LOW_SPEED_IO_SEL, },
-	{ IMX93_CLK_ENET_REF,		"enet_ref_root",	0x2c80,	NON_IO_SEL, },
-	{ IMX93_CLK_ENET_REF_PHY,	"enet_ref_phy_root",	0x2d00,	LOW_SPEED_IO_SEL, },
-	{ IMX93_CLK_I3C1_SLOW,		"i3c1_slow_root",	0x2d80,	LOW_SPEED_IO_SEL, },
-	{ IMX93_CLK_I3C2_SLOW,		"i3c2_slow_root",	0x2e00,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_ENET,		"enet_root",		0x2b00,	NON_IO_SEL, 0, PLAT_IMX93, },
+	{ IMX93_CLK_ENET_TIMER1,	"enet_timer1_root",	0x2b80,	LOW_SPEED_IO_SEL, 0, PLAT_IMX93, },
+	{ IMX93_CLK_ENET_TIMER2,	"enet_timer2_root",	0x2c00,	LOW_SPEED_IO_SEL, 0, PLAT_IMX93, },
+	{ IMX93_CLK_ENET_REF,		"enet_ref_root",	0x2c80,	NON_IO_SEL, 0, PLAT_IMX93, },
+	{ IMX93_CLK_ENET_REF_PHY,	"enet_ref_phy_root",	0x2d00,	LOW_SPEED_IO_SEL, 0, PLAT_IMX93, },
+	{ IMX91_CLK_ENET1_QOS_TSN,	"enet1_qos_tsn_root",   0x2b00, NON_IO_SEL, 0, PLAT_IMX91, },
+	{ IMX91_CLK_ENET_TIMER,		"enet_timer_root",      0x2b80, LOW_SPEED_IO_SEL, 0, PLAT_IMX91, },
+	{ IMX91_CLK_ENET2_REGULAR,	"enet2_regular_root",   0x2c80, NON_IO_SEL, 0, PLAT_IMX91, },
+	{ IMX93_CLK_I3C1_SLOW,		"i3c1_slow_root",	0x2d80,	LOW_SPEED_IO_SEL, 0, PLAT_IMX93, },
+	{ IMX93_CLK_I3C2_SLOW,		"i3c2_slow_root",	0x2e00,	LOW_SPEED_IO_SEL, 0, PLAT_IMX93, },
 	{ IMX93_CLK_USB_PHY_BURUNIN,	"usb_phy_root",		0x2e80,	LOW_SPEED_IO_SEL, },
 	{ IMX93_CLK_PAL_CAME_SCAN,	"pal_came_scan_root",	0x2f00,	MISC_SEL, }
 };
@@ -157,6 +164,7 @@ static const struct imx93_clk_ccgr {
 	u32 off;
 	unsigned long flags;
 	u32 *shared_count;
+	unsigned long plat;
 } ccgr_array[] = {
 	{ IMX93_CLK_A55_GATE,		"a55_alt",	"a55_alt_root",		0x8000, },
 	/* M33 critical clk for system run */
@@ -246,8 +254,10 @@ static const struct imx93_clk_ccgr {
 	{ IMX93_CLK_AUD_XCVR_GATE,	"aud_xcvr",	"audio_xcvr_root",	0x9b80, },
 	{ IMX93_CLK_SPDIF_GATE,		"spdif",	"spdif_root",		0x9c00, },
 	{ IMX93_CLK_HSIO_32K_GATE,	"hsio_32k",	"osc_32k",		0x9dc0, },
-	{ IMX93_CLK_ENET1_GATE,		"enet1",	"wakeup_axi_root",	0x9e00, },
-	{ IMX93_CLK_ENET_QOS_GATE,	"enet_qos",	"wakeup_axi_root",	0x9e40, },
+	{ IMX93_CLK_ENET1_GATE,		"enet1",	"wakeup_axi_root",	0x9e00, 0, NULL, PLAT_IMX93, },
+	{ IMX93_CLK_ENET_QOS_GATE,	"enet_qos",	"wakeup_axi_root",	0x9e40, 0, NULL, PLAT_IMX93, },
+	{ IMX91_CLK_ENET2_REGULAR_GATE, "enet2_regular",        "wakeup_axi_root",      0x9e00, 0, NULL, PLAT_IMX91, },
+	{ IMX91_CLK_ENET1_QOS_TSN_GATE,     "enet1_qos_tsn",        "wakeup_axi_root",      0x9e40, 0, NULL, PLAT_IMX91, },
 	/* Critical because clk accessed during CPU idle */
 	{ IMX93_CLK_SYS_CNT_GATE,	"sys_cnt",	"osc_24m",		0x9e80, CLK_IS_CRITICAL},
 	{ IMX93_CLK_TSTMR1_GATE,	"tstmr1",	"bus_aon_root",		0x9ec0, },
@@ -267,6 +277,7 @@ static int imx93_clocks_probe(struct platform_device *pdev)
 	const struct imx93_clk_ccgr *ccgr;
 	void __iomem *base, *anatop_base;
 	int i, ret;
+	const unsigned long plat = (unsigned long)device_get_match_data(&pdev->dev);
 
 	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws,
 					  IMX93_CLK_END), GFP_KERNEL);
@@ -316,17 +327,20 @@ static int imx93_clocks_probe(struct platform_device *pdev)
 
 	for (i = 0; i < ARRAY_SIZE(root_array); i++) {
 		root = &root_array[i];
-		clks[root->clk] = imx93_clk_composite_flags(root->name,
-							    parent_names[root->sel],
-							    4, base + root->off, 3,
-							    root->flags);
+		if (!root->plat || root->plat & plat)
+			clks[root->clk] = imx93_clk_composite_flags(root->name,
+								    parent_names[root->sel],
+								    4, base + root->off, 3,
+								    root->flags);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(ccgr_array); i++) {
 		ccgr = &ccgr_array[i];
-		clks[ccgr->clk] = imx93_clk_gate(NULL, ccgr->name, ccgr->parent_name,
-						 ccgr->flags, base + ccgr->off, 0, 1, 1, 3,
-						 ccgr->shared_count);
+		if (!ccgr->plat || ccgr->plat & plat)
+			clks[ccgr->clk] = imx93_clk_gate(NULL,
+							 ccgr->name, ccgr->parent_name,
+							 ccgr->flags, base + ccgr->off, 0, 1, 1, 3,
+							 ccgr->shared_count);
 	}
 
 	clks[IMX93_CLK_A55_SEL] = imx_clk_hw_mux2("a55_sel", base + 0x4820, 0, 1, a55_core_sels,
@@ -356,7 +370,8 @@ static int imx93_clocks_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id imx93_clk_of_match[] = {
-	{ .compatible = "fsl,imx93-ccm" },
+	{ .compatible = "fsl,imx93-ccm", .data = (void *)PLAT_IMX93 },
+	{ .compatible = "fsl,imx91-ccm", .data = (void *)PLAT_IMX91 },
 	{ /* Sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, imx93_clk_of_match);
-- 
2.34.1


