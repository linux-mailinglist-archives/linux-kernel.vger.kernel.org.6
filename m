Return-Path: <linux-kernel+bounces-231468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF38919914
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FE9A1F21C14
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F340194AE0;
	Wed, 26 Jun 2024 20:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WKO+rMpn"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2040.outbound.protection.outlook.com [40.107.249.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9704194AC4;
	Wed, 26 Jun 2024 20:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719433587; cv=fail; b=dv6IPmJe+JVI/I7itLj3vSt2bmOhSsTpcP+i9Qc2tSrt0GkRHnknu3mvpe873QDuUAXMH0Wr2kvtdR0F9YzldODvKUnaIwI3ccsacFA9x5S0gmk3hvlRSn4f/6a6zytoEn7tjq/i+esNr1jmsOQKkF7HM9MsDJEzjCQf4HH6BzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719433587; c=relaxed/simple;
	bh=C2PJLm5S6FsZIOyluBzJUEGreDgBDdya0rvGtvZjpjY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k2vsWyMfRl1uV1bTqVGVTH0UaPvnFB7smDapbWfIiJwKjN4BcPIffzhmtgWyg4Yt+ImYPhXsV05OcDUZ+ojT0Hodo2FPQ23k0liYpApefzuj1H74IgxwNJ7BQYZJHW+78EjR0x187Hcn5ZDSPXEbmRmiMpVTOPMgZTagpTkU1Yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=WKO+rMpn; arc=fail smtp.client-ip=40.107.249.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mS32E0+sG7gbE13aS+BEI7dymCp1rjQboLrtL8FzJNBmUIvD+P/DzcL3SEVnChQVzcwCg8hsPSaiYLpoRUbFcKnFtAZi4dDFVt0Uci6SLlpxMmMj4kRj8RISxDU2khp4Z3en+TNE0Y4su0afLaW75M6GrpRGL5eK0L6L8MJ3O/O6/9pGkKOf90rmNAtzwmLLJ/NHYARxKSWIxtnvGVx9MKTeC6uPNXBmp+hROL6AnnaezxnGDdB5V1SI6u92Cx/qmIpPpd+IxtEXtADzu8ly3lorQ2w/VCloQzNFnGRRu2s+nnKuj4otnTVgopV5SQeKD5Soo/ubHVFoF0gWxyFiWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJo3s9Chk1NTSsMV9Z3NauK0aKfJ2M3/q/sz/8N48vs=;
 b=iNrAZAM14xtPcbb+c05EdvMJY9xi8BybNzQ6n2oOAXoWWMdYikYFYbD5Q1JsyKf9UEHz7n2q1ia168mP66VEK511Ca7VWn0B6277Rsk9KObyxPzbjjkuAmOGVI1bXY+0DxdJgOZaPWDZqpjUq3a2Bwcv/R2BPgdfrj9/LSPDBzL1/Q53IaAaOTshqpV9cqcn0+f9fGiVql3PCatLX/4mYRC6tTXI8t3CbooiD5UqaVzI3ej8Q5KnR3um/lDeNwC3pt1DoDuzoxfp1uAA3diP6PxHi4gqSfS3AIagGCvxATTXYGXiL7lpp0gwFEnOjC44UV0WScgkGFdi61i4P25mUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJo3s9Chk1NTSsMV9Z3NauK0aKfJ2M3/q/sz/8N48vs=;
 b=WKO+rMpneE4TEMJ0t9ljXUn6Cff1BXRfxt/0AhksYazyWTLjEvyntbMAGs/hKmBiDUPRYkMn7TsQkf1TMnuuxWssEZ7/gyhKUlC6Gc5Da7c624SRCGYFJ1nAHh6pPdyzPON0elRA8S0msQUY5D0L1zxgufasxZ616dmgiOAqYcY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10838.eurprd04.prod.outlook.com (2603:10a6:10:581::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.25; Wed, 26 Jun
 2024 20:26:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 20:26:24 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 12/13] arm64: dts: fsl-ls1046a: rename thermal node name
Date: Wed, 26 Jun 2024 16:25:32 -0400
Message-Id: <20240626202533.2182846-13-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626202533.2182846-1-Frank.Li@nxp.com>
References: <20240626202533.2182846-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:a03:331::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10838:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d40220a-309b-4404-7d5c-08dc961e3fb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|366014|52116012|376012|1800799022|38350700012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5HV9E+Khx4dmjRq8FNqa6gz4SDNKXWMYz4+RSBtrXeJRllPg3YOYZjWL1nl6?=
 =?us-ascii?Q?bJzbbkeFzq+jT21EYawuobH4VBRxAQOJ44LmuNOpDNEwy211dlt8SX9rmKIA?=
 =?us-ascii?Q?HBR68ZkgXWiypxLurDfOT89wXZOxntUjXvV7z13o/AhmKYL2gcAF1TcbsQ79?=
 =?us-ascii?Q?VrOxLM8EORdBHNxH5iJ4Czay129wm4OjVVZ4LBxIY9WJVnWlsKsb+lB5F+Bt?=
 =?us-ascii?Q?K70rJqHs0sLYYCkKA2F7Kf+6mO+LTHhEsrKHMENM1j2FhG/QhHi1cvzeJdnS?=
 =?us-ascii?Q?ovNKvgGqdYDDNmNHO2SkABeZvTQoPMbkMXGHMxkbARvPv1095g9JSQEGxLU0?=
 =?us-ascii?Q?gOwKNBJXe+BNhn8+5ot2WEtAFn8nAKIBAJy2BPOHHpJKn62mNLaihLkoZC0A?=
 =?us-ascii?Q?K1NKeR2M3WRCO3tfvIkYCUFWr0wfp+76+Z0MVoI/a8YaCdwVbz7iEamxFSLq?=
 =?us-ascii?Q?7c/HK0jsWVOlLaZ7DiLpsQ+uUpP2HA58pmVcZk/S7QDI2eiTIYmrFIt6ud51?=
 =?us-ascii?Q?gao5Q9Y7j/Vr2bCk2jMGwBLmBjijMNN2HvB9MwUlTu+iPjUIFislGzwgBipk?=
 =?us-ascii?Q?qZOHdjaej0PzWx7D/5gDRBJbLMCq5UzvbqEqV4eHkli7HGVREMA9jVNFGRUW?=
 =?us-ascii?Q?UGE/R9doP0D7zVQyEeP18MoqcVLsThbXxdnBnYxaSjsdp+VOy7wMqK+briub?=
 =?us-ascii?Q?WdHXhY/Lq9GONU/RcdXJVlRGc+lpL4Q1OPi0dUGVreqqthi6QaWhkvReX2We?=
 =?us-ascii?Q?7kyVGMLaZIupuFua74F5k0UOKQSnSv19cpwLwYG14+1Hzb+f6vDVm4HMMDs7?=
 =?us-ascii?Q?7Mc/B+1PsKFUQUalJDktJ/pJkZ2IQaftZ7pNscuR0gZG2Abh21jHC6DvKr5q?=
 =?us-ascii?Q?OdsImLd5yul+1NCvd+xa6vk76gqMmbi7xcZ6J5Z0WZPZgC0FayjK+nZW9Zpd?=
 =?us-ascii?Q?dtiG9WKdkO6TT6LpIWMby4lNZiLZzXOrxtZGYXQWP2eyTqwCUyiLDo4NN82S?=
 =?us-ascii?Q?WfwgaPE/tPsCO9xrFprxSe9X36qfHtdmLruxGhKlPXNkSf7KrIGd0WLCDvXx?=
 =?us-ascii?Q?D43torRNlBDBezGNZrnLFWkFclhIZhPwbha1TVA/atuSL6XVMQImj41ay5vz?=
 =?us-ascii?Q?RYr6WBoJvO5fdtvnp1mOXxonu8+g8c5EzRX+uPdKGOZ4smZNo2AiEbiZR8XW?=
 =?us-ascii?Q?aEuaegOLH5ZRLhMmcxef3Y6ZMYzdOMqeGkABsUhVLd21miKC/XPT6MyVaRI7?=
 =?us-ascii?Q?pRhw14r3DQJT3cbGWKVktWe2JyydDgkDESVd0+OVa0JnRiEgvWwenl5dSdRf?=
 =?us-ascii?Q?UP+8gLZq059bUUrWSSGHZdwP0zq6DAjZVKOPE4Mxc8gV0W6asCFR0n/x3+6b?=
 =?us-ascii?Q?NIZKVYA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(52116012)(376012)(1800799022)(38350700012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d9840t4OXIE2RjJas7jy5p3nlD0NKzHx2u5LAChswVhZiNn0hxMDJETKNICE?=
 =?us-ascii?Q?pYJ9/R44H1pyB8j/540yFeGuLHUPa35pD3c7ocQLojWTgqYg8ssRMC73pIBx?=
 =?us-ascii?Q?ZphcBSrut4LhF4ohh/bCdLDKCTJbBRUkQ+2u1rETxy4zZYl9WEJqEct9NaNq?=
 =?us-ascii?Q?0CYFqfllhIKQIzkHB1V1+m7E8aCS8dHwTjI8jb6r3Ix9bQEM5M4a8J659NGP?=
 =?us-ascii?Q?IKLgWjWtufs2q7Vv8kR7RZlRp/SSDmEZGUEGDwS8uoOags97Bda1LLIlOfWF?=
 =?us-ascii?Q?F1mvEBXbwAKxUXANOQikSilVJ1GMm/pP2yn+cvOKQZoUmTJ0dbj37Wr6Zzgc?=
 =?us-ascii?Q?ZKlemwsfmklnAFW6xWA1lKEELXphIxXoelX4jCLCQjyLbsnd6CJj6FUZ+7nB?=
 =?us-ascii?Q?tSPxOy1MEMhXQTt3TcpMBV1ix9X0jw+5hINOUTScPl3lZn4nEfNbs0cWXhbV?=
 =?us-ascii?Q?/QkRTw3e2dr4MeVi7bfRpegCFJyAVvG3wk1mf+6ZuAT8bSnsWTv39VSRL58A?=
 =?us-ascii?Q?N0A9FP8bIWCg/fMSNvURDTECpWZnAyctiCeVrIsIByxf4KEi7CVJ4rsxhJf3?=
 =?us-ascii?Q?A0YpZI5kHiC6YyY1iETb5t2sN5r0mjVjxGJcV0dC6KA5lvUwDsxXEj/q+S9j?=
 =?us-ascii?Q?bm3IFIglnwO7byg4ueAruIz0M4+YuYuyUxhr1EusncuyvwCbvtezWZ1QGNW2?=
 =?us-ascii?Q?BTwrtMnF+ulKcZaHpNqiltT2z6hF95FbmjdUkQPu9amtUBmCXYI9fmd9dhH5?=
 =?us-ascii?Q?eueMPnKjzE5zRY+425UetWUx6/PY5yYJiarCFVxMPaLTufvTpBa3UYlK7FXQ?=
 =?us-ascii?Q?RHLxF36xk6OSs3WL9u8vO2m6H9St9AUujDJSJHvAqy9ab8kOclgBBp1TtQtZ?=
 =?us-ascii?Q?YQipw6PqwvrAGvGnfHXSxIS+9jwoDzbY5wKW/PABTQfNfvx6M87FlyDu3Bv/?=
 =?us-ascii?Q?1TLabLytTD3Zp2vDwOt71XlFu85TmjCQnMd04lIbtEmcLPZD2lKoLd0Kf7Y/?=
 =?us-ascii?Q?J/xmyNEiewASdrgmsukllZ0xRO9RgQhEJLHzZBcD3VzcIyJLIz0c/Pla9nCQ?=
 =?us-ascii?Q?ZI9U0h9wYNBtuEBSNPv8P7KNYnr2jNpQpEHBZhgYPR0zM7eKAT+wRRPaFkiP?=
 =?us-ascii?Q?E8sIaC2MUlGjrPw3dh+xhSGHZOWVviUbZdNwNxqHTGgtxM4mAw3bauu3p4Z+?=
 =?us-ascii?Q?9HVedm3wm4minzbSAOQUYKmaItqZsuptz4jxt0GXCfd5wc0/30zN6AW5ohuv?=
 =?us-ascii?Q?P1MR8siYUUNncZbCXLIYHazKjh2BxyfYgtS5RLbqI2GnDV29K3pIJRwtfB0/?=
 =?us-ascii?Q?nCCWCIA/hAE4HpSmlstc4YYvPoZ4BrM1ZX/AFelQHdbAJ5xbM7D0rYH86+RW?=
 =?us-ascii?Q?TbmG5DBjTCQ1555mnr0XsL9v0/SW/wbqk5Qd3qxLPiP62Xz6kxb8E9n6Uffo?=
 =?us-ascii?Q?4KB7QcamhOkgmgPRm1/MGCtK5No3DwkVDA5Lr4Y1nddz80rrhkZyFGl5otvq?=
 =?us-ascii?Q?TB5sWqfxzpMmNwhxvQVD1+jzg1rlzbf5sX0Xem4F8Tml5n3+wt066f51invN?=
 =?us-ascii?Q?3V/hVYwlouJrS8PNFQM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d40220a-309b-4404-7d5c-08dc961e3fb5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 20:26:24.3258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wUk4+C4m/vM56kzFS5R2WCq5Zdd7MQh2mgsy4rSGVq3Q0Xm0BeJqrV6X3VQ5qbz0pRMhWq6QnzaEV49GLnfGSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10838

Add thermal subfix for thermal node to fix below CHECK_DTB warnings.

	thermal-zones: '...' do not match any of the regexes:
	'^[a-zA-Z][a-zA-Z0-9\\-]{1,12}-thermal$'

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index f2fd8f984dc38..060b74d3ca58d 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -122,7 +122,7 @@ reboot {
 	};
 
 	thermal-zones {
-		ddr-controller {
+		ddr-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 0>;
@@ -142,7 +142,7 @@ ddr-ctrler-crit {
 			};
 		};
 
-		serdes {
+		serdes-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 1>;
@@ -162,7 +162,7 @@ serdes-crit {
 			};
 		};
 
-		fman {
+		fman-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 2>;
@@ -182,7 +182,7 @@ fman-crit {
 			};
 		};
 
-		core-cluster {
+		core-cluster-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 3>;
@@ -213,7 +213,7 @@ map0 {
 			};
 		};
 
-		sec {
+		sec-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 4>;
-- 
2.34.1


