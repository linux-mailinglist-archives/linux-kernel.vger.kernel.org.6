Return-Path: <linux-kernel+bounces-270843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F810944615
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1F701C21103
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D006208A0;
	Thu,  1 Aug 2024 08:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fay2Yckd"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2049.outbound.protection.outlook.com [40.107.22.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32A938DEC;
	Thu,  1 Aug 2024 08:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722499349; cv=fail; b=qihlHXuRKPVFO8SG2rbZ9W3Ll0twNLxgvyFwrjc4xiZotYeiJLsJpeMWJj9oI9qENoEvLCKBIrq6FENvCv/i5cIC7UbcbaQhpWjkRQymDJcaJRJv5OPovtXTcd1757BMVVsHiJIT7rjbyJdzSPuBhhVpmJmOA9IjNl+db+44tno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722499349; c=relaxed/simple;
	bh=+vAnaOTE5zHbDxEv/Qvb0cvyqkl98EgAB0124Auj1O4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bQo4yUgEfAD9iZ9iFsiaINNC+ue+g0kRm/4brIWr1vlMVD+YdI9lUXNtsPK4NE8lNmmo57rMbhgTWuHM5FSFOLw3VaWrpqfmbdkozkVG81OGDHSek3ba92+B5EMqRh20KiKrdOSzPHcQGRAd3uym1jhbmr+6832Hy9QeYLObZ4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=fay2Yckd; arc=fail smtp.client-ip=40.107.22.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AAa9niW7kiFJSlV3x0VNTw0Ppx7/nEHfcO7+sB4RPXqs/EQABQLNrfHp/CMXSAgQQTvkFwN9KTR7ioguOMmkNhqV25nMpTkMfWLAhq3lByY69p7vRP6pUruBZrczgKwHoxbQORfF50ycINmPqdPtVTW3lvWe1eejt3fkUHrv4ZY58Jqe4OA1akHZricoSUlOobFWvYa6RdpFaebCdsPziDSYpSL4K1vCesvn0K9FMqdq4+9xC3lTEXibhYuya0wIdj+2KeqaGGdS8T1ahL5WXReZjrzddv1XBT7aiaBjmOzUHTlPYMGuKwYhNSfCQAeRQ9VCIRgCFVs9qcLcX88tSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tNpmcbzJwQgdUW8vv1c1Txh+EMY78wFw4tmfV0bHHqc=;
 b=K79uGoQictKWmWP9aQafLH+Uo40rDzt9kk8baRkDEX5Azg7Q2Nl8BI92IXDePC42Gc38SHESGtYyxy7K/voLgZMh+wLW3PY854PweY5dHGerLBvVc96IcxJb3k4H0fCpimnb7Qs6IM9KHDZNklnbJmQE64vKaB3PLEO23mUDZN1bbvjdvG0FzgRkF2dXlzA52xBZqm0uI7Fk5soAH7KB3TI3//ccyT9ZTox6OgxD8j9UtB04RJVfe0yCXOaVMY94RDXnHuu07O1Hsi674359onSGX44tRPeohs9oT1bZAjZp3Jg8eJv990i/zb1Xx+KmgHcFlm0JNILa05rmEHB6Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNpmcbzJwQgdUW8vv1c1Txh+EMY78wFw4tmfV0bHHqc=;
 b=fay2YckdIVmgjdwH1mM4CAd691Wwywez0GPC0FA0n3r/RGcI2hge0kUV53qIes+PRKtPf51ZRoiX1sCG1JOnJ8a+axBhLP04+H54Hr4aL5Eor7IE3KJ7lJmt4HjZEgygeRN9BhJdSlqZ5lXrnFsM0IHRWgKwJV6+890XP4jLotx6flojz2QCz1Aa9rPhDMxKIjOX1ASKkVLyjuoqOzGU3M8bAcM7/Utf6Z3YHrs/nf/C25DXmJCRmWqoBC0CVr810kzyL+VEPZ8sy1VTH6/XiHlpRDwpGhatoAqrCkaav7QaFhGVtb61RLlKqcingsDC2KV27r12y2UhU+Q5BNBeOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB8PR04MB7036.eurprd04.prod.outlook.com (2603:10a6:10:12f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 08:02:23 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7784.020; Thu, 1 Aug 2024
 08:02:23 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	wahrenst@gmx.net,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] arm64: dts: imx93: add cache info
Date: Thu,  1 Aug 2024 16:11:11 +0800
Message-Id: <20240801081111.1492688-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::15)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB8PR04MB7036:EE_
X-MS-Office365-Filtering-Correlation-Id: 95bec647-9373-433d-2c33-08dcb2004679
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TBFq766uOFSHAryBdSXiv/lPdWmvyC/pXXONJm+iqhgw9q5Sx9qwdg2vBS08?=
 =?us-ascii?Q?o9Vv/PIovMwuBKJ0ZMr+oJ6B87MdIEPSX+rSK9ivy19Bssx+e4W2aDFG9NIV?=
 =?us-ascii?Q?wg99Y42vuH1i6UTQwP0SgMRv4+A8zsQ3huuHVt3BCq6WE9cweNS3ycTecg/v?=
 =?us-ascii?Q?kxjzZyBrszAysdhySatFFA673IiDYlJqPPmIAwLEncEuxf6WuXu01m/085/Y?=
 =?us-ascii?Q?o60aBWF7fASlnwbWVbygWjluhlyTGC8HcaFpevQl4OYhlc4/XvmsT7XS4ReQ?=
 =?us-ascii?Q?HkIkNTebyNhQJMcSMsj2bE67rdxMSDVbYbrRVEHQkToDAbvJX980Bi9XCSh/?=
 =?us-ascii?Q?ElU7FS5HJLYB8eAPL89IqRyEy5iFQM5o06HmkVOcFppZsgfuHF+uZUFlrfp1?=
 =?us-ascii?Q?dhkMeq/KSu/St4xL8d7ot7jlyY1JrrFhUa3iC0v3lDCu9tF4agcS2auhq0UG?=
 =?us-ascii?Q?T+BHD6qQv560DOYOcD924Ner8Cudro9f6anbFx7BgFwv9+qfW8Ka5XGkpf6p?=
 =?us-ascii?Q?UEDX6+GjrS/wcyoyzERutt432P+OWMFbBFGYaoXua7hJE0WFvW3z4YeoBwUK?=
 =?us-ascii?Q?KIqQ2ekw/ixJJpOO8oeCKMK05oWPn7fZBwLLjAVr4MhGg34+Ed9V0Y76eoMq?=
 =?us-ascii?Q?JQuEuxGgYM6Gf+gnOfmaUoJaNQ6eMaMTZmfZ7VvsdbJ+SozLxd3jMH+GjcUj?=
 =?us-ascii?Q?M7B8/pbzuP6vilIfvXRDf7n6Oow2rp926f5Xgo1aq2XtH0A2TIA5ciiSKf8O?=
 =?us-ascii?Q?6E7zK3kkG2V46e04kJBDlkLRYISGnHUClZC9yCPZFOMv0oamizgqYModW+vA?=
 =?us-ascii?Q?NSKpm555AyzG+De7aISGnOAL0mlTmHJPGpYXdxbPsLhZDWn1sJwDfJ8cv+yC?=
 =?us-ascii?Q?0b2d12edHeTS0xsm93tWgjsACyGLVyW/s7mnxJB0o1wreWXmmU/eMqdCBtF4?=
 =?us-ascii?Q?j9T0Sat9YI6ETLWPBczGh3aFodZ86BrL3w29KBIUDKF19kkF32KfdPy8NryB?=
 =?us-ascii?Q?8fm+/4HsX/LfuU1peC+NVm/Xwq0BUPgNgVLf/UPoEUkDpT4epEws9EgxucBO?=
 =?us-ascii?Q?aJfI7x+BbHbMmHPxhQNq6vqykxO5tzGGsxpCwxZE9gZXo+Zxnn7UxEyQMSqJ?=
 =?us-ascii?Q?C5DM5kbFMxY9i2myZqynkx8i79luIEN8BF09T617sA8a6jmv3ufiYsNA9jvb?=
 =?us-ascii?Q?vjsChfgiAqpU+NnwTUDc0yqdcGehbNiBqwlfFiBzXyvpArG4/n4JIWemnw+1?=
 =?us-ascii?Q?BWQjk1wduXtpNxKnoNKO5ktl0EHyPyYVn6NrFnSH1WPGT6Td6PoGvk2dHqsM?=
 =?us-ascii?Q?2nwXtehq7Ov9Jl87Mg/Y03aXgsiu1VIPybpu1L7wKi+sbb6NEHDjhi9rzssS?=
 =?us-ascii?Q?okzjK1q8a5iNnpUjjeUIlED2ot/gjRGhmUVSDmhfZD+s83GbKg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vhb0cKLjiUwB7QSN5/F1/GBSYB9YTOKumrDTvSc3dFWxPrnuWJbfF5szyxEq?=
 =?us-ascii?Q?YoYvVnnd9ScOpPhH4hz4MCt0d7rcWqNpz0fhd73NWpcZKbEMDlk5iLvnwegu?=
 =?us-ascii?Q?kVfToWyyMcevBQo9TIZyVdIWs1Xi75uFvm6Q8IYuC6lnOCgzUeMWR1Z+XQTU?=
 =?us-ascii?Q?8vF8LWMtYNsZcYQ4K5e+aHvEv5J+MjjN0MR4rVl+PS9jMpHGL95W9rMEZytr?=
 =?us-ascii?Q?wg2zKkYnmNA9pspIodtTlHcLWnPTCRxmYxKffe8DLvmOZMwGJp4HjY4osB1n?=
 =?us-ascii?Q?T6s3IdVekuicq9dfgLFDN393i18KKMBAOoeWIvW/2+DKof6isVeVp+5cGTAm?=
 =?us-ascii?Q?Odm0uhZivx8l9ZBzrvx1WupSPIwmEO7OADdXuqUyFfTmoeQhcs1VKflsPNZD?=
 =?us-ascii?Q?Va8Ur9R5jvRmBrynY/8NTyD3Mg7ebY3rX/lui7g8WIZLmJ/0Y8vQSNlbWWaQ?=
 =?us-ascii?Q?tj0E2ghTj6eFFk40L6kRLM0ihdzVYgZPjZ9XqsujhfaRf5GTVt/96dmJ1O2b?=
 =?us-ascii?Q?SIv+JSN3nIlR+fWcDM056T1jcq11gao/EuFj83a7wEisSOKUuY04CLdxkPkj?=
 =?us-ascii?Q?jPsZt1jUqL9Pjtt70ns955fgx5SLMGGlCcPP3DeB0MP5/ntV/vJmO87RHtp+?=
 =?us-ascii?Q?YsvwXtml/s28IOBagt1217P6CXxHnh2x7w+0ar3cBa0ZMhWRRluwSHqiLso+?=
 =?us-ascii?Q?xJwK4iV0JPdOuQJqQ/HrApEAEiCQ3gsgctmF+kwwfj9AZ5L0r6FwzRAWiKqM?=
 =?us-ascii?Q?0GOYpJRX/V4k+/Nd+JkfAWNmQCXEgR3+J8+x34lbDkgihdaZ/wWjRtTWlNFP?=
 =?us-ascii?Q?QfaOEnQCDe4TvT+a7fjc/7to3ZQAa11En1NECjzazyLdGSwaMuny2LiWczEg?=
 =?us-ascii?Q?8ubqZpoUjSR+cj5fnSwgfcEyFGFUKHkchTIDm7xuMtu8GlZHfRoPEbQgHYRd?=
 =?us-ascii?Q?oFm3m/2LFOYL8Q8tpmj31XNddBpSeoskR93T7rSLlKjrPJQa2Uo9y1rfIQmU?=
 =?us-ascii?Q?snyNnuWoGR9GdN4/ux5QrWJdWpY0rDU3nBMO4AbUBOSF4IJb/c92WTOM295u?=
 =?us-ascii?Q?QsXtgBHB/wfJAOyIeCqDcGpsEOz2cdjUXsZrI+KKn/5ooTmaCMiauawit2Me?=
 =?us-ascii?Q?tmZEha4CQFWrX+kLE9B6LZ8ZlAk+133TcwhIRb3yYMQenXW18gfE7RVlx9o/?=
 =?us-ascii?Q?MvxeNZpmhkBbUYMtR5fMa1PVhUORya5Bee34SVw+vdE9rrxysakEUO5+ypXX?=
 =?us-ascii?Q?dgMXHdVPub083kUYpLdXrt3jQoZ2YPR2ytn52TmksKdGX9+szTo2CdMx1u46?=
 =?us-ascii?Q?8VBqY+h47D/mtmTOGNnRPPGJBA3SBQdZx9Uo0rdCckv70iUvU60EJJsAwXJL?=
 =?us-ascii?Q?FvCzfa3RDsdC9PnmVEnv7rT0aYBXGCkMP+x/hNDnIjE/YDHCH/404+XsDsA7?=
 =?us-ascii?Q?nXBrCXxOXFEWsjbVNZDcgK8f7IZnggF8Y8gTIk0Nmf2l/iTAC9PsvKCZIIrr?=
 =?us-ascii?Q?6/jX2RvJfABgneL16PSVJSmEFarY2GIQPscyX8UA5kqAjxQ4kUXgpfEBENUZ?=
 =?us-ascii?Q?jMIHuKY4V6QMh6uTxLF3OQvWvEwBTqmZhXdZKIIm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95bec647-9373-433d-2c33-08dcb2004679
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 08:02:23.3405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ILkq3ZSfqpb2C6kFOZpB1JQ/3b432o5WymqZ1Cvp9EA1qOGEIcrkt5y15Pxqzg3XOvAynLh8miQPNM8JwqEHlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7036

From: Peng Fan <peng.fan@nxp.com>

i.MX93 features two Cortex-A55 cores with per core L1 Instruction
cache size 32KB, L1 data cache size 32KB, per core L2 cache 64KB, and
unified 256KB L3 cache.

Add the cache info to remove cacheinfo warnings at boot:
"cacheinfo: Unable to detect cache hierarchy for CPU 0"

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 42 ++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 4a3f42355cb8..8f17b1fbfba0 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -69,6 +69,13 @@ A55_0: cpu@0 {
 			enable-method = "psci";
 			#cooling-cells = <2>;
 			cpu-idle-states = <&cpu_pd_wait>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_cache_l0>;
 		};
 
 		A55_1: cpu@100 {
@@ -78,8 +85,43 @@ A55_1: cpu@100 {
 			enable-method = "psci";
 			#cooling-cells = <2>;
 			cpu-idle-states = <&cpu_pd_wait>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_cache_l1>;
 		};
 
+		l2_cache_l0: l2-cache-l0 {
+			compatible = "cache";
+			cache-size = <65536>;
+			cache-line-size = <64>;
+			cache-sets = <256>;
+			cache-level = <2>;
+			cache-unified;
+			next-level-cache = <&l3_cache>;
+		};
+
+		l2_cache_l1: l2-cache-l1 {
+			compatible = "cache";
+			cache-size = <65536>;
+			cache-line-size = <64>;
+			cache-sets = <256>;
+			cache-level = <2>;
+			cache-unified;
+			next-level-cache = <&l3_cache>;
+		};
+
+		l3_cache: l3-cache {
+			compatible = "cache";
+			cache-size = <262144>;
+			cache-line-size = <64>;
+			cache-sets = <256>;
+			cache-level = <3>;
+			cache-unified;
+		};
 	};
 
 	osc_32k: clock-osc-32k {
-- 
2.37.1


