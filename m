Return-Path: <linux-kernel+bounces-231469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F534919917
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB01C1F223DF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3766B19408D;
	Wed, 26 Jun 2024 20:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lWDiV99B"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2045.outbound.protection.outlook.com [40.107.249.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A251F194AEE;
	Wed, 26 Jun 2024 20:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719433591; cv=fail; b=Vwfgz1utA5b9gkZ/+4I45mPvOWjLckUvVCSgugTm8sUOqjA3pmalumFGSDL590d6vWPFXel9x4dLDLEO0Z/TWLrNeSehegDkeZDL8N+OskQLsaav8pw2a3ge/GL3I+ITToDHVa2aF45nTQbqRdWYjfvdBdOGYDMCTkqqJDoEZwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719433591; c=relaxed/simple;
	bh=sjvgZFr5ZrpWNCYeV+8RS+XjUX75JgVBtLSps4rRwe0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iEWaFp82g0MLEn7A5oh2Gg7XU5M2mrP97xLkbmuSoN/T/y0T3GHIO+yggZ5vh/c1hMbdkdGmvVJO30EhZpZb3DcfvKVV67fItLMWQHGts4xb+yFZW1oSxrMe7HoMDVBIBleO4auU2+9i2+yU44IJUWxk0XMpUHDs+UxjVlT6QP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=lWDiV99B; arc=fail smtp.client-ip=40.107.249.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFVaz47n5S+Ovsd810KP+tny0Jkf3SDicdlruWhSYzfG5Pd5Uy2tLDxKXQrWSCBIAX66q5j+jd4u9ztGQdbDiIJcMTuCNnK98CgqNVuu1Q6E1EEkgcsD/p/ZWSr9RTRfS1MRGaHYV9dhmqdxvP3EGEQfIWA5CZ9X0OIwyhfqNWUv+NobcIkj1Vxxo2jtb99HRxA4saKMNDYXxgEAE9lc6Rh+z1Ee8g3DWIFnp/HF/iQ1cnWG09O79THtfmBInyWPlH7jfr4/pS/dXNxP79bkuUDhDmRYwlV4j741uxeyth38B69vB1FQOC/cblWKs/RUVAQrNcfIaULr4YNnwYJOhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hocmI2lB6xoVnuKqvHscGHzyqympuZ09ImFvGpQYAe4=;
 b=e/T1RaPl+I4iNqkI7MxYrmDb0izeB8nW3WKqA1HEll1zjYZXQKr84KWrBcSE6ZPoNgdUcqlQ5fm9mPm78uaQYFJzNI4ml5Kdj1mtmlzXI5ePQrojaddbwlUxPjGm5hnZ1BmKHf4XbEYeDKTF4q/G7YZu5GazfR88nfrNG4QXtQA2IE1R64YMCRVU3339kf1CJWY1VMSHZHj0fiLMK/m9w5qdUgqHOuWUDOwtshwPlLyvyHMvDGrdR3yVSUxzCqdfR/2lItT7kUs4ct2GWdObEqGdf/gfBxBYgVSX/TGcEHjtcGWNPHOyiFcdxX2FAj7eI3lFRbYi1EsBiyIuYZsTuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hocmI2lB6xoVnuKqvHscGHzyqympuZ09ImFvGpQYAe4=;
 b=lWDiV99BFk74VZaf0iJP9oBRE/ZhfugXneYQxpG6mYp641ZkR89Rxfn5DPjc3Jvh7L2Tgo0ppbfALaKc1d3/syyouP3WOy55hCPHIbcY/XHwuugaDkNJDBHLjQtJgMWUTXG65SDpOQYCqpvzXaRZ7MGcvjtIt2Zew9sVrxHZHwo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10838.eurprd04.prod.outlook.com (2603:10a6:10:581::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.25; Wed, 26 Jun
 2024 20:26:27 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 20:26:27 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 13/13] arm64: dts: layerscape: rename b(q)man-portals to b(q)man-portals-bus
Date: Wed, 26 Jun 2024 16:25:33 -0400
Message-Id: <20240626202533.2182846-14-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: a8c4e30c-241b-4b7b-bba9-08dc961e415d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|366014|52116012|376012|1800799022|38350700012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lUG1OXJu+O+1DSMBLpk7uDhigXGzv9Ijo0HNXI/wBfGLCjP1/9a2T0OKt9Gk?=
 =?us-ascii?Q?ntPVVro2wgybLut7sVbcnD0EpHy/mZC2icKoMm3uEw/iMqmthcYWTYreLMWT?=
 =?us-ascii?Q?wLWYbvj44ywWppVfQbsPtswR++cqogItuW6OI9ujNBzGhPjqeStmxUQcoI8y?=
 =?us-ascii?Q?ElgU6pnoXOcmpOWbkRq83u6E5dV7BEANXR8jp8K2FEA9t2Eg4AwiIAYkEPGX?=
 =?us-ascii?Q?qZHtPwST7D21vnT2dhaN54YwGRY+zHHfWp0BLkja7gnSboks77g25h3tXbfb?=
 =?us-ascii?Q?/cmPu0Tp5MI68NsZNCoHqn40j8aOgKpofMLZmOrl5q3oCGT6Ipjeg6+Q0/nY?=
 =?us-ascii?Q?ODfFYnsIE/Br/DtIfKYhK21B+pVEwSuVTXuzW3U3geAXTwat9O1MDK1e378K?=
 =?us-ascii?Q?IfSA9+Lu2i8duKKKR3W/DlXwwXfaTU1FY+X0lsaBGbY3+QovTlLCWX5xAOvI?=
 =?us-ascii?Q?3P71OPQv5FM5M77XRwSsYUEMETltmwafw8fTYLFZnQ7d25Xm5doYPlSl+df6?=
 =?us-ascii?Q?vbUtiGjBlfIc2qOCnR1NPwcMeuWMWUUxHMHphQJABOLYTYLQTznUmQHx6yHY?=
 =?us-ascii?Q?Jj+sET+zxfnAL56Zh+D98Fj6YPazput7H7pQiYZHiOhNSbJibztquPhsAObf?=
 =?us-ascii?Q?p+rZHaakk1kO2RQNQZlwgTC9MBd5F+cI2LgFMVpp6+Qyb+vBSAH215fqlAHu?=
 =?us-ascii?Q?JqutW4ySVCF8WSW3p1Rys+6jYOHU7RISXNAKVCLdKvxCdip1NhfTWt+ADL7h?=
 =?us-ascii?Q?fPccJJRUKb7NF2pjBFbMy0swtv3jEtuB1UyJqccubw057E7KX0+8OoZTaFGf?=
 =?us-ascii?Q?pUM8GQ8iUa6Mqzw7ZRiJGaYhGnxKWtYF4t+GOfb1qnEh+v2zcV9pg2vU/i8K?=
 =?us-ascii?Q?bUCal4RVUPyb6Aleb9SP6Mp/B9LLqGGq0u399kDHlZqoH/fiv7DDbfzTY/jE?=
 =?us-ascii?Q?5BShIARW991PXVynLLyORafkTDLiwTznkmMeUGmAH0y4lJwOidkd5VNI6Exy?=
 =?us-ascii?Q?+Biw0o7HOnW7u0mLWp7MFnly6GXlR20JYsIBomqdWVu1f7ZxzDlblawrlH5/?=
 =?us-ascii?Q?itWv7xIegxLC9AOWR9znmHUA1gQ+SMB3RJuHU7T4HRRm96yEkMJfawCBaffl?=
 =?us-ascii?Q?t2ao+Cc5xK8sif7KNf01w8zEA9pxn9t/wA55EY8ECVMQgx6n7A25eNdKQYvU?=
 =?us-ascii?Q?0lrQjKiMmnR4/Iy9AEm2/O1nTdFtBTlayLJwri/NilIbm1e9Crp/jAfLdqN6?=
 =?us-ascii?Q?K5yzH+9XQseqDQ6jm5WeXitbEanZTaVbrlK8XUmpQiGwOdFcQQK/LByOKSQR?=
 =?us-ascii?Q?O5qA6u5URWUXgHuNC6qKX/zZ/AP5c5vRtMnNaNa5lz0pO6a/aqjBtvbJXyhx?=
 =?us-ascii?Q?Exvwy9E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(52116012)(376012)(1800799022)(38350700012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4weDn2Wn//KNJsQuPsvyZ2JlL72M7IYi4mcH045wnj3soNa5677dou3Ycc9R?=
 =?us-ascii?Q?y51FJowpsl7mxQ0Mg6oQCZcNU4B5N4cqirfZGs+SWN1q9X4q6Em/+WDeyXBp?=
 =?us-ascii?Q?kRHHpTN6uctNyroGT4djYPhiRHxLz362Il96nq2ikDEHALKWZJeXRnqYx5ud?=
 =?us-ascii?Q?VqUirDsl2jYelkVfEi61TWimEdXHlB8Ms8MQCiOZRZgV46oC47VJmu8PCcxS?=
 =?us-ascii?Q?S49kXf8/WOgoej6DOhOS5fk7SR559TSume6cBuCjOhxpZ28TXiORiuHosD4C?=
 =?us-ascii?Q?YpDzlfqA8O8LwQ9tY4qUDMck8koz2DTE7OynhYlZ/A8RpIMYPU3WUBv0eRSI?=
 =?us-ascii?Q?rHJryJkzz6vD6S0VOswHoKNpUM0v7GIQoIi+2eEIv78a+VQsZqoRR0t7G0LZ?=
 =?us-ascii?Q?fHdvg4ujS11oSMPtKzuQzA76ycHW5yorf7vtoh5bBTkhcITONJMQEQk4c+qK?=
 =?us-ascii?Q?972C9pBMrTaXG7J4dvm/CcXqtcsTUICDqmvJAfM8X3l33MfDM7owYwrAmsP6?=
 =?us-ascii?Q?ecknfhPr/Uq1wUKiAC/kmEbpr2OnNZLerasFfhhDh2f/75xQ0gcqr9R3AbYi?=
 =?us-ascii?Q?kYSMFgSWlC3doAU3sa97WTBT4vbYGVkxjE14VQPh3Jr9SmNibaFFcAcRsFkQ?=
 =?us-ascii?Q?7dyuz7elN1/W0vk90nyNK1uuz+qHa7u7Qfth0CiYZOkBIFYJVJWsS4jxuLeF?=
 =?us-ascii?Q?EXjjDlbGEEsQYlv26vo/Fn1eoZnFlHRnOqSNhaHuZtFtrftcDfS3D9rWNAvO?=
 =?us-ascii?Q?ecU7HwgsYo7ypRGwJp1LrWKZmf0nvbCx/PCZz8fYIXyCeI6Yx/w8zm3ywlK8?=
 =?us-ascii?Q?EgNuCqtHba2CsvTxk8BAtNrm8slIx29Z7orOkkdaJPgT4kWwTOMzBmDNITxi?=
 =?us-ascii?Q?Zsd5ntkDtsMW6Xjibw4l47hrl2u/XfL0NaZaJQco3Vi7dABOI7EkKH3L1uLw?=
 =?us-ascii?Q?PZZGAMsR6vJCgCL3xVgNGqMSbV5/LrPgII96qhIMlrXncjMlGibUcW8uGqhd?=
 =?us-ascii?Q?KkRGp3EWZ7PpXc4abwp1VxSMEj3GRbLriwMRdrNAb5BlvMcRV8RaG29J/0Cv?=
 =?us-ascii?Q?lRushIDLi1PZOlYcFr0L8ZrOHi2e6C+9KDBv/F9jwEiqvIktfsYPcGcxuL5h?=
 =?us-ascii?Q?NuZwHC/IWYQ4cATGnHht15FY+Qt0Z7D8TjYJW8CuQ74OgCHz/enWT8BA8Izc?=
 =?us-ascii?Q?OetfcddVXO5bd3voO7UIOuPGQPEXtNHp1N54oX080GlbX2SoBwl6D4rbU+oG?=
 =?us-ascii?Q?fPSjoHsasaad+a+wkbRiVgrQ7VWTCTFpz+Nht+PDuENZSCOlVMVpuunQRY10?=
 =?us-ascii?Q?vADwio+cIv5UGk9/frucp4qs4Py71JaC9eVd+Dc7W0KyW4y2nNG75ivK+E8n?=
 =?us-ascii?Q?Yth70b+89PQXPiK7sAeo1UsFdu4CCit6zuVe+5/+Ruy9NXSYtVGJ/WwB9Jb1?=
 =?us-ascii?Q?yfWON9aDSabtffhyy2okwn34qaK3ia/2Qs6AnKcn++vWokvY6Ip+/xazMqXG?=
 =?us-ascii?Q?9Wx/W/3fVbeyWIjmT9HQ5yn10yQWqQc2KjySW8t7/4Y3gbWeB/1YaHECfnB0?=
 =?us-ascii?Q?1TungtJid3qf9h1oT/I=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c4e30c-241b-4b7b-bba9-08dc961e415d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 20:26:27.0798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3iM8+b637XNQDULtuAm3kJqLQQ3+gttQ92KJjWsY6MCGNaaDLOWYf1U9nZxCra3oYSzeKSQLAjlAi6B+Tu4/lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10838

Rename b(q)man-portals to b(q)man-portals-bus to fix below CHECK_DTB
warnings.

arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb:
  bman-portals@508000000: $nodename:0: 'bman-portals@508000000' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 4 ++--
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index bfb5841456d76..8f8cfc96790cc 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -505,11 +505,11 @@ bman: bman@1890000 {
 			memory-region = <&bman_fbpr>;
 		};
 
-		bportals: bman-portals@508000000 {
+		bportals: bman-portals-bus@508000000 {
 			ranges = <0x0 0x5 0x08000000 0x8000000>;
 		};
 
-		qportals: qman-portals@500000000 {
+		qportals: qman-portals-bus@500000000 {
 			ranges = <0x0 0x5 0x00000000 0x8000000>;
 		};
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 060b74d3ca58d..200e52622f998 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -409,11 +409,11 @@ bman: bman@1890000 {
 
 		};
 
-		qportals: qman-portals@500000000 {
+		qportals: qman-portals-bus@500000000 {
 			ranges = <0x0 0x5 0x00000000 0x8000000>;
 		};
 
-		bportals: bman-portals@508000000 {
+		bportals: bman-portals-bus@508000000 {
 			ranges = <0x0 0x5 0x08000000 0x8000000>;
 		};
 
-- 
2.34.1


