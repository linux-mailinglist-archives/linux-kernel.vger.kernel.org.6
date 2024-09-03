Return-Path: <linux-kernel+bounces-313553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CA296A6F6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 20:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC419287F0C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 18:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CE6192D9A;
	Tue,  3 Sep 2024 18:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jU6CZF1J"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011051.outbound.protection.outlook.com [52.101.70.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873B41925AB;
	Tue,  3 Sep 2024 18:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725389716; cv=fail; b=QVDPN0nvoN2QJyu+Uefv5HfV2h1aKJODrejQdFVJAL+bf7228sLbS9W43gFx06OWLCsbZENXqzIxXnqQUqNURV7L5i+LmYwYAHPxdXbW5aj9FnRFnNqRZUszkfHDsdh+m4UIzuetH4T7tJwiMGbG+xePCSkI9iSs6xW4fGpIILk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725389716; c=relaxed/simple;
	bh=eITXDiPyvD+DaCiG8rJj0L0wWqAezOKaMPU08NyqeeI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BMClbjdOR2/kZZJHCOG5UaLJRbjkAB7eY9+xroBGPIsX4wDgqz+IJN54aRgS7Wzd1kyVm+iAYnr64lbVixvVZSTvGylxRlbDVS77nqPR5KO4g/c6wyUDbf2O77o8/G/2XOZb1pDwzkyIr9swZ4RzKy5/vavl5WM/IMEYbt4tnNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jU6CZF1J; arc=fail smtp.client-ip=52.101.70.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WibAgVbgn5gpBQL1wdlXPWfyoMkg1jihvlMc19wlFNA8BGWtHHg4In0gAatLo8hMsPtEGZY3+6FOx/xxlSBxcPiDbFB0fTm+MgiDj5GPTjJdbFwhfSA1RPmNm7+rvcUGPxRubjyjZiZ6xV46BLsSTtIsoikjxN+m9MdK+JZ5rHDzHaHi7dtSZXjj3QIsS1w9V9uHYmfI2zzOB1z1JLji9bPyqKs9x9ytUCK+r/c18DtokS6o0VcCXYlR2LtcbQP+011SiS9TBhqD1gAsN4q3EULBaiVoWeAyXaEGpADzeZ8Yor+wFIzR2JZsC+KKjZgo8JaL3dVh2+DN5PtlGd531g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zilZFhDUiv8EbmgNRB2VUCQQacaVHMaE4rzaK8lB/c=;
 b=xbEw3kbYSB7qlKFr4ZBdzw4scvqz/cysTB1SQj6s+HMPuco6/82kBT1ON3X3aXeTfqEZWrTXKhyZQyGaTHBZ1+ouAycIKJdxlH000DPwjZpoYHcVzAvpWlAD0NuDalx2aooENqHsdIKLzF0Zu+kybbQdynsdFqQoGIt10ZC7+C67hRpwcjzaBaGx81QFusG3x//av527FH+MoSgKjhaIQqLSsJ1GwNUpIkNXDEvfj2f3plLN0PWCnH576Jz4ayq1Jkilx0ep8kthBvLtyoQ2p3pTxSP3fkXkB6ObxByxrsVIQUYHQ0ESEYcwDbz1WtmSWrahk7TZzGCbXAXAYjntDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zilZFhDUiv8EbmgNRB2VUCQQacaVHMaE4rzaK8lB/c=;
 b=jU6CZF1Jez4267q8FSo4nVUnNcNAmDQmpoTLLzgUjiarn6A6VzbnVg6TykfYpy9ntlBPjx/ciQDnmxtLk5qWdagztxy3JnoE2GbQk4hE7yfOClvMchsTSxLUEidLFqggRjykx3YBy1G7t7ylUHICe0LrwhPYFESIOUUJM5AL9musqJUqo7uJKsefVjgpLCRdr5/Cu81gcQRZE25LNeUt9dp1onM16AVqGjdQV6m1bJ16fn0IUDU8l3+R//bIORYPpBYyukHijJYx4Ph0Nc83rrpIS4RbwZVsipqaQiGhb743cYffAeVrbw8r0ogDQKZnlHL+ZSMV3tHWfigelcFfdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7300.eurprd04.prod.outlook.com (2603:10a6:20b:1c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 3 Sep
 2024 18:55:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7918.020; Tue, 3 Sep 2024
 18:55:11 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v3 3/3] arm64: dts: imx93-11x11-evk: Enable sound-wm8962 sound card
Date: Tue,  3 Sep 2024 14:54:49 -0400
Message-Id: <20240903185450.1486505-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903185450.1486505-1-Frank.Li@nxp.com>
References: <20240903185450.1486505-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0033.namprd04.prod.outlook.com
 (2603:10b6:806:120::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7300:EE_
X-MS-Office365-Filtering-Correlation-Id: 4de4b61f-ac61-4a85-aa0e-08dccc49efe4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o2cKTRgssrONesDmw65koxFRkp/znIEfY30uMw1qWa2WPAeQvf6nT2+DJrkg?=
 =?us-ascii?Q?mio4Xl8k+PzZ+AB613KDfu2yofkLZai3P0XR0aFIS1ekl5flw0k5Wmg7YqcD?=
 =?us-ascii?Q?d+nlF6nSayBY2RQ/Exv3laIrYPo+2ZPuUPSBXtk2SaVYIJ6ccWi5lUgCdyOx?=
 =?us-ascii?Q?ZTaP2rc/aui2KRU4nCBJixKMnDR34zKmwfaltfYJ4mgcXInLivie2Aceg2GS?=
 =?us-ascii?Q?7pffpF/E/DuAgivrQUwVtvLuilaYHmWpYLm9PgIHVxPAiaCsKRwPtPHpW2vE?=
 =?us-ascii?Q?A0VK4a3n0gvxJ57tyn28WcbPfC/VmVPf+ha7gHmF23u+09zDOJTaWAxsKbPq?=
 =?us-ascii?Q?CUwSNIJK/g484CSXUANHy6v412SO1Ck5X8dQuJzDWIuEkssyUlPZ9r649OCh?=
 =?us-ascii?Q?GgVTIU4D/Q6sFb3m7djTzgRMbwRPR8jBnf871gptKqJN9Hx2HS5/+jnrsaLs?=
 =?us-ascii?Q?oMl60Lm2nskscEYEk/fBsE4TMwf0ept9MrwG1LpssQ336d7bO6a3iN0y2tzj?=
 =?us-ascii?Q?DgsaIvhhOD1UqpAuHY0LZb7TnJ3R2dV9WiFohQEnVe54FFOgHI/JLXZVxIzE?=
 =?us-ascii?Q?kNLhTcTBJTxZi3rxkbUHnbrOm3oD9BV5M9hi8yJDLdQ7wbmJT9WO4QnTwTy7?=
 =?us-ascii?Q?WODrm4kOG6a+k+0ORT5HvGplUwUyxQqaVAgBZzXI5s22X6hmmOHQ/AbNsWPi?=
 =?us-ascii?Q?MrL/sxY0DRTznbm+/i9jlDEK4s5R9fxf/+0w8E+A9KwDuUMtzon0DDlbMCvv?=
 =?us-ascii?Q?1IlYHtRQ5w6mhDfexNyaqMeaEhMRRokerchvAWPn++IFrGdHObhnn8+Ovx43?=
 =?us-ascii?Q?GYgoKPdV9HCwX8k4sCaSnbwvwxd6OB6X1TAt9sMYwbNtxK+C770s+/y/YPrE?=
 =?us-ascii?Q?EIrw4SspFSHEOkGxTSEaMxQy+iYKpxSmvcqVxDOrjp6iDB8nKz6iTvN7GNmX?=
 =?us-ascii?Q?slZvGaomUJb+8od6ONQI7w6Y3z5ID+Vs2v0vfoi4QJvvaszIP72ngElT9LsU?=
 =?us-ascii?Q?l0OV7HUcufBqwbPGIvYZBY2XSQdfZmmmjbDcn1ICcJMWJCeUJivgsENahCG6?=
 =?us-ascii?Q?MB9oVkd3afY47OPJK+MYCJ4f4ry7rVFX4xpsKsR3qIb00mjjEvL36VnlSuyz?=
 =?us-ascii?Q?BbnMzJBOncmjG7/QEIavZSjKg0yUM+eplerrXfDZqMUZyRp31FHUEf/HfWEY?=
 =?us-ascii?Q?mSy6H19YJ+xZ0anxe8vRtBMOVq44SIA8sT6Kft+KnPyWumb9stW+jacCp1qF?=
 =?us-ascii?Q?uHMd1cyrCFTqf1j2t0BoSC/5cQmkuidlElqgKlrQougW31ndlFbH+6/LxJoH?=
 =?us-ascii?Q?jRD2m2ZqzETgCI+D0y2qYPDe5+FPYafo1r5syIEOG5LETv3l7n1ATj6UML7W?=
 =?us-ascii?Q?cjV5QNw9+YagRL/FHSTWb3ODm3giS8UePFKAZ/5N4hp/6o7dqSNHfH8Uu43a?=
 =?us-ascii?Q?7Wu1qMYObrY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DNi8hjRWQoPOAkTEEwswDkQ01t6Oz4BKyqBtO8vWaDdoABfulnlxwXGNfXR+?=
 =?us-ascii?Q?ymWwWkXxEJFDMQTdiEGOynczfolDm/8CWiitaHP61hpZEig6J0GnJ3a/sNp1?=
 =?us-ascii?Q?+fDLxbRBDY7FyshjUl4+82vVqnFaSL/H34ZmSja5CXbOaG9wTkN2gstMqDld?=
 =?us-ascii?Q?/rU9dhzPSHMA0qRCFsXHX8WU1jZMg1LtvfkjDepZ9tS7G0gVm7z2nKwnA3WX?=
 =?us-ascii?Q?DZcWb24Vx8sAOEDiHOIbCm71FrZOsAcPiZhWbUDQSsH+U+wtYNHlPPQ2eWNX?=
 =?us-ascii?Q?yovFGS94qBoYJNXiSsp5pMBYoiAyjdHSUrwncKL6BxwMGGtoZw/9MPWLESr0?=
 =?us-ascii?Q?98XIKdDs2SM/De48HDuNS/Vr9DFCm3l2/PGRnZoCcBGT/9m7Z8lpDH/p24ou?=
 =?us-ascii?Q?Yj0BFWxUubg3Z5ur4GBFUGBdIP1CJIi/ri9Pw4LJLfVMJ+CJZcdyFivjGb0G?=
 =?us-ascii?Q?0BEa+RFNnpJf3+AGpgdMm+2sQfuojZtB0zn7VUKfdTG6MbEtcV+M38I+dJOi?=
 =?us-ascii?Q?oFYkF2geBrJ/7Sn1XoZwkjz8csmJZ+SRgSo8sVHOQ6yYgwgWeUjVcxvUr4lB?=
 =?us-ascii?Q?aFOqrQrPieTHAP3Gd7k5J3Ka3rAnBtCGIbzHn2oZrh4R2qBmFx23KihTvjx5?=
 =?us-ascii?Q?PSi91AZnKwpJEAACFTZ1B6QvmIQY82uWd6LveufuamwZX7XYxpdczJFN6qEz?=
 =?us-ascii?Q?67Jh2Do/MePNZXK1fnxPNojsD4325A4znLKn3wocfGWczAMigSfmoqP2Ak9f?=
 =?us-ascii?Q?XZQ0/nsi/4AFeescg/EDx6iydnUrN5sGrqTeeYz+hOtxHqbF5tCj67xZMiLQ?=
 =?us-ascii?Q?j+EaaeNJPpOHxIFoMu7WjPk7RJajq+29v02/rO7VWz2J12dmGO3isD1DKceo?=
 =?us-ascii?Q?0ScDoFq09W6+qL/7DJmioz2s2l4dACOFlP42yqcyvtZ1yEeeUa8vi3FEpTYM?=
 =?us-ascii?Q?xpHX6qj2BVc3aiwPiCC3zEKyOWqvAHGyQnxFw0k85tC7Ywefk/DR3i1lQtlF?=
 =?us-ascii?Q?ZOEpfL2DjaZHcQzj71MnJSMxwVuDhLHoAtKi6GwUshSFJ7XNpWR6pAe4q3hs?=
 =?us-ascii?Q?uR7NDxHiISUqwPCY+kcVtAPtphJXdCzMDGY5Qtwa8FkDByD/JuMNqxPk1uvR?=
 =?us-ascii?Q?j9qsSmfBH3SYZYHSmShor8VDIuiOAwgrHjPhN5ksrkMj3wE9+ZLBReD6pGH/?=
 =?us-ascii?Q?a6tOjwL6bmKHxzR+DV4Di3ckVxKU+7UqH3RTasgSnRXzKb96tKZgDoo9WJYu?=
 =?us-ascii?Q?aUmyuwHQTPB7ODPXS+vEbw8eNLxSY8lJJ+j7SaZPGaAP5S4vMS1mC3xm3LFm?=
 =?us-ascii?Q?XbqXDTCPD/vP9mZRQjEIGAOM1MooFmOLVGLpDCrgaR1wMACceO2tnyV3+xLB?=
 =?us-ascii?Q?hBfgbEzy5gsjxQJ5xi+rvilo+WFqeDLy302Zk+41kqQcNw4t6SVkSeKTKykx?=
 =?us-ascii?Q?8+wfzsvtcNA9ihtZy38t5yrdj75X1y/UiJeGM7a/7nNra/D8to96ufFQmNp8?=
 =?us-ascii?Q?mFPz2wmsbElrH+XOyFo/Hfp1QmpnaRDd15vY2FX5fNEgO6p0N4zJ247Eq0SZ?=
 =?us-ascii?Q?aRAI6uXN0/u4jasviMPtGCM+3BEin94qsxBi0YM/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de4b61f-ac61-4a85-aa0e-08dccc49efe4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 18:55:11.0550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1fYe5CryloRmiBom2KhAIpQ4foiw8M9db5lv8lPJwm0OzW/pAP2LdnwSuUKmWK8Df+mmV3BjZNhhIk9DnEmwjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7300

From: Chancel Liu <chancel.liu@nxp.com>

Add wm8962 sound card which connects to sai3.

Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v2 to v3
- update label to adp5585
Change from v1 to v2
- change sai3grpsleep to sai3sleepgrp to fix CHECK_DTB warnings
---
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index 76177b723ef3c..05ee64c9de9f5 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -78,6 +78,15 @@ reg_vref_1v8: regulator-adc-vref {
 		regulator-max-microvolt = <1800000>;
 	};
 
+	reg_audio_pwr: regulator-audio-pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "audio-pwr";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&adp5585 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	reg_can2_standby: regulator-can2-standby {
 		compatible = "regulator-fixed";
 		regulator-name = "can2-stby";
@@ -147,6 +156,22 @@ cpu {
 		};
 	};
 
+	sound-wm8962 {
+		compatible = "fsl,imx-audio-wm8962";
+		model = "wm8962-audio";
+		audio-cpu = <&sai3>;
+		audio-codec = <&wm8962>;
+		hp-det-gpio = <&pcal6524 4 GPIO_ACTIVE_HIGH>;
+		audio-routing =
+			"Headphone Jack", "HPOUTL",
+			"Headphone Jack", "HPOUTR",
+			"Ext Spk", "SPKOUTL",
+			"Ext Spk", "SPKOUTR",
+			"AMIC", "MICBIAS",
+			"IN3R", "AMIC",
+			"IN1R", "AMIC";
+	};
+
 	sound-xcvr {
 		compatible = "fsl,imx-audio-card";
 		model = "imx-audio-xcvr";
@@ -237,6 +262,28 @@ &lpi2c1 {
 	pinctrl-0 = <&pinctrl_lpi2c1>;
 	status = "okay";
 
+	wm8962: codec@1a {
+		compatible = "wlf,wm8962";
+		reg = <0x1a>;
+		clocks = <&clk IMX93_CLK_SAI3_GATE>;
+		DCVDD-supply = <&reg_audio_pwr>;
+		DBVDD-supply = <&reg_audio_pwr>;
+		AVDD-supply = <&reg_audio_pwr>;
+		CPVDD-supply = <&reg_audio_pwr>;
+		MICVDD-supply = <&reg_audio_pwr>;
+		PLLVDD-supply = <&reg_audio_pwr>;
+		SPKVDD1-supply = <&reg_audio_pwr>;
+		SPKVDD2-supply = <&reg_audio_pwr>;
+		gpio-cfg = <
+			0x0000 /* 0:Default */
+			0x0000 /* 1:Default */
+			0x0000 /* 2:FN_DMICCLK */
+			0x0000 /* 3:Default */
+			0x0000 /* 4:FN_DMICCDAT */
+			0x0000 /* 5:Default */
+		>;
+	};
+
 	inertial-meter@6a {
 		compatible = "st,lsm6dso";
 		reg = <0x6a>;
@@ -478,6 +525,17 @@ &sai1 {
 	status = "okay";
 };
 
+&sai3 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_sai3>;
+	pinctrl-1 = <&pinctrl_sai3_sleep>;
+	assigned-clocks = <&clk IMX93_CLK_SAI3>;
+	assigned-clock-parents = <&clk IMX93_CLK_AUDIO_PLL>;
+	assigned-clock-rates = <12288000>;
+	fsl,sai-mclk-direction-output;
+	status = "okay";
+};
+
 &usbotg1 {
 	dr_mode = "otg";
 	hnp-disable;
@@ -778,6 +836,26 @@ MX93_PAD_SD2_RESET_B__GPIO3_IO07	0x31e
 		>;
 	};
 
+	pinctrl_sai3: sai3grp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO26__SAI3_TX_SYNC                0x31e
+			MX93_PAD_GPIO_IO16__SAI3_TX_BCLK                0x31e
+			MX93_PAD_GPIO_IO17__SAI3_MCLK           0x31e
+			MX93_PAD_GPIO_IO19__SAI3_TX_DATA00              0x31e
+			MX93_PAD_GPIO_IO20__SAI3_RX_DATA00              0x31e
+		>;
+	};
+
+	pinctrl_sai3_sleep: sai3sleepgrp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO26__GPIO2_IO26			0x51e
+			MX93_PAD_GPIO_IO16__GPIO2_IO16			0x51e
+			MX93_PAD_GPIO_IO17__GPIO2_IO17			0x51e
+			MX93_PAD_GPIO_IO19__GPIO2_IO19			0x51e
+			MX93_PAD_GPIO_IO20__GPIO2_IO20			0x51e
+		>;
+	};
+
 	pinctrl_spdif: spdifgrp {
 		fsl,pins = <
 			MX93_PAD_GPIO_IO22__SPDIF_IN		0x31e
-- 
2.34.1


