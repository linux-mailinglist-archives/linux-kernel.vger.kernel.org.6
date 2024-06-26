Return-Path: <linux-kernel+bounces-231457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCF09198FC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A8A31C21930
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B031192B9D;
	Wed, 26 Jun 2024 20:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fmvx4ibb"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2080.outbound.protection.outlook.com [40.107.22.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515F6192B69;
	Wed, 26 Jun 2024 20:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719433558; cv=fail; b=qMnD4Yx0YPOyf5HdBPPccePIs5HI5m7Hf8CNLZ9x4bgNf+yaRes4lLYyQXbs7WGrCB0U68qZz/DGW6fchh78+RS85VwNn+ThpxnGExyLyEvyOiVfpWNyn1gHEifOn3hPWUOOdVT4m4isnv0yjVFxDAnO+r/rRHmWALV6OZ6OxCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719433558; c=relaxed/simple;
	bh=rf9YHQX0N9fK7joLcT+e3g0gwPNTRP9+zT3rXJpmTrs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=py+TbaKSqpqqOq6nxFN08glb+WWikaP//FfJ9RPbUG6tpc2GUlY9/JQq2wHQphtbvD/jnWV/4mA/UasKCmuQbLtxTTdjrdYQMzpvyCB/lzip+Oj76YblnhuLOrksN7FS/xH/q3Lz580eOjSzc5XIFSitCCAXxSr6Qhtfz11SzWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=fmvx4ibb; arc=fail smtp.client-ip=40.107.22.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTdrVl1hGyO70P7UZAa7+S7qs0ExpfB0VRN3wjZcPHxxQ9UYOTXe4Hfo2e5Qc7srPCf5pNbdsmCv36IzNFHRoW6shfUaMBDCyrsY+wXgxdcOdr10lLoezmE43i/l74d2wCLp+W1jB5ho6loYwHRX8Fx7K/vw4XgVJfvOG8UyZ+5JATqr/Qy4DwvS/B0HIL4PpuSXeGmvZsHU6Lc6So7SwG0tQil4tFidq7h01GrM6kFP0U30FF/XRq8J/V1GUWEKf1fwGjkA08LzsafjrhWYlNUyESu6sLVxmmEyglAbOUD5HEfx/v5WcWkHu6W690WN5cDgg6z5WkYmEIkOdHrlOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzs1VB/TOVJtbaKXdc4U1mKfu+zIVudwIRrzrkc+BE8=;
 b=NZoCMwq71gnUH477TQCbnHY02bQO7X03bnxiQrzQii3LvkVnKIzcU0gJwU1Cfh2zKM5kHSXWFviYcVC8rznTPagkXfMMTS7N8dgofcgpR+V5Q9Q8r67qTG8fQ+fqVNTJXbsHxhV522q6ZDCGgTRB+gS6sRZS5m8rNVFVeohx3KcV39z/3LXuwJ5NZVImaYq70/X6zNiOsq4nz+55ZWmrgIeFhcFNUBWqGIW+BkRR93EqfFgaL+6g1OHN9rda6LwIpi/J0NSB97L+DNLMzt/RxkpHkQiw+92f7Sbe+qJfihDiS5RKm+P/yM7l7R+BC7y4LEj1JUmQ9LbdYqva9zdCgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzs1VB/TOVJtbaKXdc4U1mKfu+zIVudwIRrzrkc+BE8=;
 b=fmvx4ibbuGJJmm5MhyiDwaFUBOu83lVfy1JbVrYFZScyy33an7sD58FQsyXQ/yAZGV6M6qWY8B1fOy2u8qnC1+gwgPU0Kl/WCnPFis7iBxky0bKO9RRxyE+csCfLLXfmPElrwVd0H0QK/+x2uueGG14XhRI98K8sxGrsGhnKjxM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB8012.eurprd04.prod.outlook.com (2603:10a6:10:1e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 20:25:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 20:25:52 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 01/13] arm64: dts: layerscape: rename node 'timer' as 'rtc'
Date: Wed, 26 Jun 2024 16:25:21 -0400
Message-Id: <20240626202533.2182846-2-Frank.Li@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB8012:EE_
X-MS-Office365-Filtering-Correlation-Id: d4ced0f6-7dae-40ef-454b-08dc961e2cdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|376012|1800799022|52116012|366014|38350700012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FOpRlbzpqqRqwzv31P1t529eir3zopJWCY+yWW7uQvYWP+jigeYzgf7Yry0s?=
 =?us-ascii?Q?Ve1lZeV40qpTmlyaQPlHDOZrIuuDu+kaRYo5uxdnjqKiNQjFqe0i+gzBr7vM?=
 =?us-ascii?Q?7SYkpRuL1p+Gy/4+wtW4Cfrkh+lpEu6PkMGKWP/XYgmNopdL6fADOZfn7sob?=
 =?us-ascii?Q?Run+Bvf/B+2sQ7qo992fKK6XmIkKRVEuw78cN+xl2YVu+kVceZzEbAo7UH7X?=
 =?us-ascii?Q?7qRsN8OZ9RgYvNbe2YIv68iR9LK55P80K0ORNAOFBct43OJNtYhpnTbUHd37?=
 =?us-ascii?Q?sg7oMGP7BUAbhXiuP7nJEcMI9enUepkvYU7j/gWsWEgWd+MYWbEraCW+7erj?=
 =?us-ascii?Q?Tf8aL1oxqvSpGYOh7800iJ8iRhdq9rAHF0IxM3UAzeTiTcotM/6TuVzWX428?=
 =?us-ascii?Q?sJ2LOpSZTZj1j0QAgzJPYBX1FiSKJW4+gdGpgc92eyrLVLO5WBuhQRnCzGkq?=
 =?us-ascii?Q?sV7kXpaTUhsoxSZwab5FbNf63QDzPC3lYJE3x206b8QPlZMfIMMjehs7dDs/?=
 =?us-ascii?Q?BVDRU1TjoyP/O8tOIK7Kg0sAY7B+UJvMvdRKS02SBZYPmFMkeKV13TbkKvUq?=
 =?us-ascii?Q?wGed+lr+ySDZY7EYe0aVZSYqKJAHFNC+z5jH+yvothFbGV6GzZ0gl7SiKCc1?=
 =?us-ascii?Q?RtLrYep4nRUwREFI20RVLqUOS04L3q2e3qKcTGvIPSOBI37ecql7mVdE+Aqd?=
 =?us-ascii?Q?GE6pBh/cqpwM/cEKbgBaE11IQN+8HarFzUYdCPlLRgZsxff/svn3lOOzn9bw?=
 =?us-ascii?Q?3p58eEfqYYfSp/isC4gBXE2lrHlq5jASpDYdKNG6JCCN3n9sVkS4etXjQiOx?=
 =?us-ascii?Q?vvNjdq9TkPTPp/z60uTjywdujOv1L/UPP37aXNGFIXVhqKPYw71Kj3YUwOTt?=
 =?us-ascii?Q?YhDM0B9xT/edIFGDQ9eFKWnmGiqiC/yJJpQP5vN8jP4KLK3lGv2lF+uvBN3Q?=
 =?us-ascii?Q?teKpckVgrE/CJTjYwsQtg18K9gXOchK5nv3DhlYla6Y2en/x1XjWVHnGMn1v?=
 =?us-ascii?Q?fLrJvMLpAU4uqvPwj6qljQCXpQwPEfGpsvYAWLAkIdpZkEVFdDBEck6GKArW?=
 =?us-ascii?Q?ApVa7moI5xl5ivTskm24S3FdUylpsytfmhkePwHftNM8xpQ4IYyp8Vm3IQD8?=
 =?us-ascii?Q?dyGUvPaxPgtUjzHr62lVOo0DaAzYKgvSJOVfbCh4i6jXt5uoEgTiQjGPTqty?=
 =?us-ascii?Q?oWqeMZ/7LHxZi7rac3wzwvkjoG/p3Uoav8O6FG5ShueyWUDBZO9R8Ns46XE1?=
 =?us-ascii?Q?w6S6OqsQUwnzkaeHd4XWCzz5IMm6QRY0bzSiMcMh4I2NcWoa3DddP5t/5lIv?=
 =?us-ascii?Q?3TEnHlIDqo+h6sVsQeEwE2kT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(376012)(1800799022)(52116012)(366014)(38350700012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?krAZ5EjEj1bOAovV9KBypo07o+b7CXKZplZRTUKoQIpdDiq21FBNowZ0eBOd?=
 =?us-ascii?Q?jN24sklMFNGIMmpAZoIKfBF3GsIOEXgqDHv1hURt+48ZXY8eWIedcxmull7s?=
 =?us-ascii?Q?bRohygrTTLd6PhGUgHbRE6uv9xhLfWifsNc+jodovdTHbwLYqSLOW5OcrOhq?=
 =?us-ascii?Q?svH7NQW4+/g5IApyVIKOKawU0HgrdblIk7NbxspxvaLPWy2S2zGk0apr67t4?=
 =?us-ascii?Q?dYk9/d71tmFMfXGTaiUkN6Oi6jQh7X+a3WUzHYOiuMG0qZE5gtQrFN7O+coI?=
 =?us-ascii?Q?BknuCyTVk5RYYpted62uMOYoPdFtdPiyZM1vZ9hc/BCzAGvhDE9S3PrxXET6?=
 =?us-ascii?Q?E7gfpY388+Ip/xJR0uju+dALcOJ0Y1ER2tgv4OM7uOlsD0QAHVBmwgaEQVze?=
 =?us-ascii?Q?undpgyEINqa0BOtZm4s1nbCMoSiP27Kt8B0lut1ptNhkf5vtHH0KwD3mmbX4?=
 =?us-ascii?Q?5otRgoXMykPlLIOXzMgnVtQ971l4eiv62YwNoeZC8/VCvalurbzfFRa9N15O?=
 =?us-ascii?Q?HrTgT1PgzRBUbMLfVxwmuiHXCL98GFANFHhOjOHCUSkSKIdC8+YpCB0mXTYt?=
 =?us-ascii?Q?MfwFzLVL6F0Nn0xVI6wUZis73yxCD+vOoUVUcioxUGQip4bulse6kSJ4mX/A?=
 =?us-ascii?Q?YqZYjpsHZ05VY3fHa6GJL6C+rJqb4+BNl05ARkkN9f+ygejcbn1+TN5ozEFf?=
 =?us-ascii?Q?La30V8YPtGC70KbM/qpE89sCmGdm7K0zpNW3LDzYcmEH7HjU4e+YO0yem3/c?=
 =?us-ascii?Q?moiQ+dJFxb2xUlwPqzY8QTPOKvK43nXIMxctRl6chTAxLH2mBRuBTKTKjWRq?=
 =?us-ascii?Q?GdtvtuXloiYZxUc6Ri2lg5VKMA16SlCTAP1K/QiQVXWBSB1XSqDlUVIGB4cZ?=
 =?us-ascii?Q?bwDs2V9gAfiGAdbMNDxKsBRfoCSwhLpEZldybEWI978bRpfoAf07FA+pzpwh?=
 =?us-ascii?Q?QSPBb69wfZSryT6y0FC5FabYtextKe84s9Dk0+1NpFJ1v6LE88ZgGwnmv0e/?=
 =?us-ascii?Q?aOS1lzcCsOnpFfjDWFylMAJ+QnlODnyMG8N8tGknmPgXk7O0qGJ3SsyBae3c?=
 =?us-ascii?Q?uApHWLd7+kxSQbhF5rkfJuPBrOq0hF/ookk+x/aDlAx0uM/isQUq2ZJtPvjm?=
 =?us-ascii?Q?/jxTOoyg/yRb3kVU4/tS6indS4dsd+6qI4FFDxJ+KumhUVeHPtKvPXNik8EW?=
 =?us-ascii?Q?dvsBe+NgTMNZz6USGoG22oTblvIWckOFZNqUO5yWAc7JZBIS6+hj/2yzOdUj?=
 =?us-ascii?Q?EN237t5CR6pNDgJEBTyWV/qeKqtMZhhfw1OoSuxH2NEPZZH2BoBRbBvcSkUK?=
 =?us-ascii?Q?x+hiT1clwS1ntYb/b7CpYVbe4UkVyHjn8ihbcimNcH12ie1IvXWxho95JvtU?=
 =?us-ascii?Q?U22/PG6M144Ie2h/FwJjOtHsm7P6OnNLEL8s6nNUjibq1ZZdA5hhxEhTzFwQ?=
 =?us-ascii?Q?oKN/tvrHShwi2YSOleRXKvsv0BdNkOanVDrOvCCwBct3ccrTpftQAs9f3gH0?=
 =?us-ascii?Q?NEgd/q7sA1L7aXjWATyy9FBvMac9ltGew0uj0G2LskqyuqSYd+POSIR8SDmj?=
 =?us-ascii?Q?DL2/WsoQjvpZA+DJ2q+W89QcmXefDaAtJDvYW63+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ced0f6-7dae-40ef-454b-08dc961e2cdf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 20:25:52.7255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xz8rYulyn9d26r+J4SLZGVeuA3QtXVxim/SYcLnXNlo2OkFnc9soRE+FTfDnbCU8c6CQNRMFXh7plcvXbtVG1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8012

ftm_alarm is rtc. Correct the name as 'rtc' to fix DTB_CHECK warning.

timer@29d0000: $nodename:0: 'timer@29d0000' does not match '^rtc(@.*|-([0-9]|[1-9][0-9]+))?$'
        from schema $id: http://devicetree.org/schemas/rtc/fsl,ls-ftm-alarm.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 4 ++--
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index b6824d6bc9391..2e1cddc11bf47 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -564,7 +564,7 @@ rcpm: power-controller@1ee2140 {
 			#fsl,rcpm-wakeup-cells = <1>;
 		};
 
-		ftm_alarm0: timer@29d0000 {
+		ftm_alarm0: rtc@29d0000 {
 			compatible = "fsl,ls1012a-ftm-alarm";
 			reg = <0x0 0x29d0000 0x0 0x10000>;
 			fsl,rcpm-wakeup = <&rcpm 0x20000>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 744ed5feb8f0b..4188faa59368e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -1326,7 +1326,7 @@ rcpm: power-controller@1e34040 {
 			little-endian;
 		};
 
-		ftm_alarm0: timer@2800000 {
+		ftm_alarm0: rtc@2800000 {
 			compatible = "fsl,ls1028a-ftm-alarm";
 			reg = <0x0 0x2800000 0x0 0x10000>;
 			fsl,rcpm-wakeup = <&rcpm 0x0 0x0 0x0 0x0 0x4000 0x0 0x0>;
@@ -1334,7 +1334,7 @@ ftm_alarm0: timer@2800000 {
 			status = "disabled";
 		};
 
-		ftm_alarm1: timer@2810000 {
+		ftm_alarm1: rtc@2810000 {
 			compatible = "fsl,ls1028a-ftm-alarm";
 			reg = <0x0 0x2810000 0x0 0x10000>;
 			fsl,rcpm-wakeup = <&rcpm 0x0 0x0 0x0 0x0 0x4000 0x0 0x0>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 534b832440207..caf765593547b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -990,7 +990,7 @@ rcpm: power-controller@1ee2140 {
 			#fsl,rcpm-wakeup-cells = <1>;
 		};
 
-		ftm_alarm0: timer@29d0000 {
+		ftm_alarm0: rtc@29d0000 {
 			compatible = "fsl,ls1043a-ftm-alarm";
 			reg = <0x0 0x29d0000 0x0 0x10000>;
 			fsl,rcpm-wakeup = <&rcpm 0x20000>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 30061c80f1cc1..f8c9489507e7a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -940,7 +940,7 @@ rcpm: power-controller@1ee2140 {
 			#fsl,rcpm-wakeup-cells = <1>;
 		};
 
-		ftm_alarm0: timer@29d0000 {
+		ftm_alarm0: rtc@29d0000 {
 			compatible = "fsl,ls1046a-ftm-alarm";
 			reg = <0x0 0x29d0000 0x0 0x10000>;
 			fsl,rcpm-wakeup = <&rcpm 0x20000>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 01c2c2b474205..81b80b6b27d31 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -1041,7 +1041,7 @@ rcpm: power-controller@1e34040 {
 			little-endian;
 		};
 
-		ftm_alarm0: timer@2800000 {
+		ftm_alarm0: rtc@2800000 {
 			compatible = "fsl,ls1088a-ftm-alarm";
 			reg = <0x0 0x2800000 0x0 0x10000>;
 			fsl,rcpm-wakeup = <&rcpm 0x0 0x0 0x0 0x0 0x4000 0x0>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 89a5f4d05a7b5..dac33a3eab841 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -1226,7 +1226,7 @@ rcpm: power-controller@1e34040 {
 			little-endian;
 		};
 
-		ftm_alarm0: timer@2800000 {
+		ftm_alarm0: rtc@2800000 {
 			compatible = "fsl,ls208xa-ftm-alarm";
 			reg = <0x0 0x2800000 0x0 0x10000>;
 			fsl,rcpm-wakeup = <&rcpm 0x0 0x0 0x0 0x0 0x4000 0x0>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 58c3a3a9744d6..40159f58c6f94 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -1086,7 +1086,7 @@ rcpm: power-controller@1e34040 {
 			little-endian;
 		};
 
-		ftm_alarm0: timer@2800000 {
+		ftm_alarm0: rtc@2800000 {
 			compatible = "fsl,lx2160a-ftm-alarm";
 			reg = <0x0 0x2800000 0x0 0x10000>;
 			fsl,rcpm-wakeup = <&rcpm 0x0 0x0 0x0 0x0 0x4000 0x0 0x0>;
-- 
2.34.1


