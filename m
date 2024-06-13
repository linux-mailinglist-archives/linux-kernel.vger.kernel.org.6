Return-Path: <linux-kernel+bounces-213949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9961B907CEE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 21:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28B0C285774
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289DC81725;
	Thu, 13 Jun 2024 19:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="I3G4d2TS"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2093.outbound.protection.outlook.com [40.107.94.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD42C762E8;
	Thu, 13 Jun 2024 19:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718308230; cv=fail; b=skvqAxHOQIvs3YPcmVWwvoVRYUokKq++7O6ZnmCGyvjLVzgGrMRpATcC/jA3VZmSZi4zWqtJx0qZ9E3fO5pqz80ngwfp/A9JT/dR3hKxTY3JiHOyw/gdMaCfEFdGs7ZCR3ZSvEHgdFduLdsIreBD7ioT3VYWELVOoBL/v+zQO4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718308230; c=relaxed/simple;
	bh=0Rcpe7eN4GUhtinL+TJ7vQT5gGQHrig3XERKD4kNVjs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LztOB7kDVeN5SlclQ8YzYhSYuGOvjGLW8WuT2Y84rr9qMXb+kvFZtc7QKMrCatdzM0aYJtFO53I/iNSYETGXh0FNvnY0VxjcRazsi1IYA+Mk9dZ+63ETQHwRmHBVN9iQypYFlVGTnID3xaj+RfTuMqGSpdL0xea33MdrHB36VxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=I3G4d2TS; arc=fail smtp.client-ip=40.107.94.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbWzcFWQmdVrYCSPBriinSB0dznPHgaf0wuuuuBfBHdYCNm743dPPhTxcdNdPxLOmclb1dvEUlExVQSPZEHu5Gkj8FO0Z6lInEq1jtfUkthvtJOdsOYwE+bJhjIqJkt0vjLeqkUvsiU2eIa66/G5UduYNSJzHQpqba3UUo3oKdiij9WXoYTClbtqH/WK4MDfIV1kWsHR/rNoDbS5fTNeE/IIHits7/DCxu4eIUbOGpRi8Ti6+hmkZNzCM8p+hrxEnuPfn8vbTKAYbRnGk4OYVV31jeOQg8VGl3XF4eHNKBoGkbDnt2fD2Xy4vWJXV/ddARXE94oDFBXr+TkSsf7rcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNALFn/+VGbA0iuMrxkA6dk1dXXdmzLzCXygpX8+BZM=;
 b=X7s3ZkMywXTutYx0OFNPPn2+jax/kA53wFvdM4CJEEtoQjMmAoj3tChxRrfR09IxAlb/mQthzCa2u0FDo2Uh5FitC8Qb7Li5JSVj1dpfHr3floZATo6tEfRQvepbL3P3VIlPN59J6E0WeOLiGfmr1HNpbOy3r37pamgr2IbWi1BNpHCVhYa32Gm66+6bBHVGzepPXp1eR+5SxKG+C81IVJSkPD2mjVTMn69Hy8QtWVxsttbAXkVuh7Xs5tncZyV6i8DHZhMWJd9vV2MlniXUzlCXcKpsl8i4wBKrf0ls5K+0HZpI6xvnHS50+DTIsz/wV9QLbjpLVsXW+OBRiYPyag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNALFn/+VGbA0iuMrxkA6dk1dXXdmzLzCXygpX8+BZM=;
 b=I3G4d2TSiv7uMiqPy6qi4r4IMJJtKl5ZvqI5CgeE1c5ocCqj+sex8IFf7d4FwezDfTHXqleXk+kTqMeVErYams7HKP9NPcWkDnGDWVAiAYujV1HC1d+HjfooQsvNfcXn9h9bIEOXHKepNev9L+tVLCD00IVIICiZ4U/iKK/g27E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SA1PR22MB5636.namprd22.prod.outlook.com (2603:10b6:806:3e2::15)
 by LV3PR22MB5145.namprd22.prod.outlook.com (2603:10b6:408:1d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Thu, 13 Jun
 2024 19:50:24 +0000
Received: from SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45]) by SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45%4]) with mapi id 15.20.7677.024; Thu, 13 Jun 2024
 19:50:24 +0000
From: Nathan Morrisson <nmorrisson@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de,
	w.egorov@phytec.de
Subject: [PATCH v4 1/2] arm64: dts: ti: am642-phyboard-electra: Remove PCIe pinmuxing
Date: Thu, 13 Jun 2024 12:50:11 -0700
Message-Id: <20240613195012.1925920-2-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240613195012.1925920-1-nmorrisson@phytec.com>
References: <20240613195012.1925920-1-nmorrisson@phytec.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0374.namprd03.prod.outlook.com
 (2603:10b6:610:119::34) To SA1PR22MB5636.namprd22.prod.outlook.com
 (2603:10b6:806:3e2::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR22MB5636:EE_|LV3PR22MB5145:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d52725c-5bcc-497b-a0c7-08dc8be2111e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|52116009|376009|7416009|1800799019|366011|38350700009;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?luxCUIeRPxJfNYSaGDosqh5rmvzm0FPT7puNtL/2Vk6ID2SVkIQ9jajU5hqs?=
 =?us-ascii?Q?RL0CXGEbyq4EWU/c8PYXDbTTglMRKjHpVzlB/at4ZueszNqSQ+S5RaAiaOVB?=
 =?us-ascii?Q?RyakaqfJVMQmbeYxKJYiytwHEpm6rjyRpCCCeMmm97gHA76G5JR+zYbb8Wrs?=
 =?us-ascii?Q?XOG0//djTfzJmS76/ZY91QWov5Nl5kUGJoUUWeKKP4h7cQSeDzYhac5RtgZB?=
 =?us-ascii?Q?t9iCNh+ON8xSdUo5rpwbmmZCQrNzE+4KmFiGEx2/vQwLLLV+5XootsUXc+as?=
 =?us-ascii?Q?0DRt7CqZvIi1m6nG0bPvOBsQt6fpCKUTAI2lW3FoKUE8Uwq60nd/oj1kmoIk?=
 =?us-ascii?Q?xltaLoKiBQY6JsgjUgub206VcG84NXlcLwgyA8qkQ+rK01jynpfUdIi6Z4vS?=
 =?us-ascii?Q?gmTrx9aohjX7yQRNAacbDX3Nr1UDxHIYKD/0DsD+X2OcAqLNe5JPscZPv52l?=
 =?us-ascii?Q?NnCfXbwKYnonlYkbQ+6ugV35fMMHT7AJExVFNn8F8DGJd7393+fatUFyFEN4?=
 =?us-ascii?Q?1/NmigZd3PMQqnnchZc1b22HqIihzZeuJZY1zPMWN7BM36PgDgG3xTvd0IlO?=
 =?us-ascii?Q?ya3LdBCliApd59cGn93SjTMyUd/If4xvSo8PpBCUVe6YKWNflnc82LDbC8Az?=
 =?us-ascii?Q?WmXppV3EH6rLROGOw3UTRfCKtO3aziyi3T+cs0daQt8mZqqBmxbqyzhz1TQA?=
 =?us-ascii?Q?BNe6zgtlLMwb82bZzeHprx47Qc4P7VB4eD2GzuQDsFlp1tAjm9f68mHoeUth?=
 =?us-ascii?Q?sGat8Y+StlmSkrJNcrtwaCDHNt/b7jQZWEhzAPSTaZPFHDZqY5epjFp5xECk?=
 =?us-ascii?Q?SUiSoZNGTqUIC8sHNtILeGfGV/ltkAYCX0UyJ2268Ecyt08LO9XX6kdXmK5A?=
 =?us-ascii?Q?kqCRYaVbEjSJQHqnHDRh1ldYOlUW3ty/yfKYUfM3TuT1Gz0GaT5/D1R/vWM3?=
 =?us-ascii?Q?u2t/EsoIKzP0bqpDADNhIBjzLrOdoEsBKbo7Ieo968q6O8eukFiuC1cssyp1?=
 =?us-ascii?Q?33NFQ6WTnMO1CDEr6ZdcQMo//4FggbuTyh+CNEXoQ+1PG+fHpSJiBcDrHMPc?=
 =?us-ascii?Q?eE3AMNP3xaHhGCbm/upZ3fOYmoPXLp56uu8lhzzvWtaflBsbNCsorXALlDSM?=
 =?us-ascii?Q?2E70hjFe1IHQyrNYnFSK4CIipm4PMc/3jkDq1sBE/cbr8/UWdGXtBC2OxDDn?=
 =?us-ascii?Q?iFv+XtkpQUpz1XsXknoemlWOHVUojluwQ+/7HoNBWGr/PyR+O7V9vRRP2DuK?=
 =?us-ascii?Q?TcAju3V6+FxYbim0E8SoKigK7Ai1ruDOGSF/zkIbqmtiHOAVhXHx0tfq7+3C?=
 =?us-ascii?Q?mTPan60fngOVfNLrZ8zjqgsRfeaMSLQn7yALg9q+XRboiK33874751ifExDK?=
 =?us-ascii?Q?RaCFNQA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5636.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(52116009)(376009)(7416009)(1800799019)(366011)(38350700009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5Kni9Qa+Z/3aP90OTIrEuN6ybYivYMN6CVvAJTChfOu3p0LYU1rKGZDokLMU?=
 =?us-ascii?Q?okK7TVtSGruX4COGA6FAdeD3tPyON3EZzv/ykGVBMF2ihPE9tRrn406NGSg4?=
 =?us-ascii?Q?0QdZt5kLc99OmD3WHEhwQAyugd5xVrcD5QlzDQWTkaMOuemY22TWcDfARpVz?=
 =?us-ascii?Q?XP68YoVgFxcO/UWRrPxDbB/Voa7LuI9MoJMBUuH+taI/7korvhHkJ4AxDih9?=
 =?us-ascii?Q?NM8It3pJmoJXoev4XYWjYMcIJL8Tetl4x8n/U33bhc7WwlUTHYV8cOvFbF3o?=
 =?us-ascii?Q?a76QwaRjJQ49MhAhxr/yDwJmB8lVko63LR5MhYGSRbVcN9ZvhNZQOuPvgIeG?=
 =?us-ascii?Q?NS+suIV/cUeMo2OTEXwB9EkJALJ43yrEt8uWJgIm2v7lC51w6MaCA6Z2xq7d?=
 =?us-ascii?Q?m6pZRWuxKriTuwgOQYFWZInI04QHvaDm2RVfNRYdTkWE9zJAzjjW8UnwUnxM?=
 =?us-ascii?Q?rFM4sFKsnpSc1iuCee6lFzpdF/9FPgOjQVqvqT9Ggi8N85w4YnLv2NsAH2yi?=
 =?us-ascii?Q?lSTnq0x3e5MKhrR1/f+wN81YcXQDwN7f4lPnPq+9Maweyx90+alSnyi3ZREa?=
 =?us-ascii?Q?RMnEJhQkQzKc7TLWGv0idkKoODfNdM0Wo9khVZMziv/VUbu1vmvNx/HQMQaC?=
 =?us-ascii?Q?X5iqB2/MrZPAWEKnVxRenW5tinYgq9XpldamwpnLWoQKmfW0qJgrs1kkI0Sy?=
 =?us-ascii?Q?eYOGoAY5lMQ0REKy+4IgjxivcBcEpeZufJ3RiO9G6rVrfFF/QFmZTBC7U/ik?=
 =?us-ascii?Q?TDiLRt04orb29Vp+wRJrrGaii1LWLrSMulQrlt70YNXnFSz936maJJw2Lh/c?=
 =?us-ascii?Q?36petAFqhRlocTCs1HhqONW0bTFEDVOr3NqOx2ECgXrVz97bZsA8VpOlzPnK?=
 =?us-ascii?Q?qQpytknc1arMWWMMDWLM9eV/8RwYnS9KNjegTn2TmwsE4uZykfCeF0ncdcbZ?=
 =?us-ascii?Q?I6OgDmMP9O9MO5uTBOWor/+D83HC1igmvl1LSR442nuzWFzlY6aSSpZ1OQ31?=
 =?us-ascii?Q?0878JZq7VD78YcwlNl39DIhS3W4eJeVsyaW4M56ezpwa+E86okLA3K18Vcsm?=
 =?us-ascii?Q?Db7uEJDKITt1fyYesYHijAqQ6rm5WC2G1I5A59O8LVhR/APnDtT9m0SNaZ+D?=
 =?us-ascii?Q?oxDpXOhnRMkLPfVLtDTzKLX5uhp0MqpCFabvIhu+axUUvnkpFrZFSvT7HMer?=
 =?us-ascii?Q?XOQQD2QTLKNEE8nif3dy76jmGNnjivwl1kEP+Eg8hvX+UeCvGhEGIUThmEcm?=
 =?us-ascii?Q?J/Dgzv/tZrm3tu/z5UVreREqwlxdOnnm7u2tM4O+LFsanq+N6+N32tyXeEYp?=
 =?us-ascii?Q?kDattdfMbKANAnHuXvtBMmw7xJl1y3fQAv3bMEZ4dEzPa7MTIeGYcG/70Ufl?=
 =?us-ascii?Q?LndTNZ+DWsK2O03OFjxx9uX+Par5dJ4C9llI4qa19fMABbK8at8oYkTTDzsZ?=
 =?us-ascii?Q?kbfZ+gp+N2qGQhGMEYcbuDCDMXNIsNOlo9tu3v5iTvM8BXa21+ySfgf7imGQ?=
 =?us-ascii?Q?8yEaRhRCOtOv/Y9BgBljnB9gVFDLof/puVXloKAPeq5bDtuzKVSTP7i0sjO+?=
 =?us-ascii?Q?AEiHqcmF+NUvCm8F/O45VYZL/DrU3u6HOwkcG9DV?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d52725c-5bcc-497b-a0c7-08dc8be2111e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5636.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 19:50:24.7297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0AE6bdMrtK+z5lQAAJJ9qLluu06SpCuDdLLiGKO4Ujkh/4YXazLfBmcVMmVfT4XpCQQZcFkqBi+iXTgUQ/Xa/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR22MB5145

Remove pinmuxing for PCIe so that we can add it in an overlay.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
Reviewed-by: Wadim Egorov <w.egorov@phytec.de>
---
v4: No change

v3: No change

v2: No change

 .../boot/dts/ti/k3-am642-phyboard-electra-rdk.dts    | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
index 6df331ccb970..30729b49dd69 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
@@ -190,18 +190,6 @@ AM64X_IOPAD(0x02a8, PIN_OUTPUT, 0)	/* (E19) USB0_DRVVBUS */
 		>;
 	};
 
-	pcie_usb_sel_pins_default: pcie-usb-sel-default-pins {
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x017c, PIN_OUTPUT, 7)	/* (T1) PRG0_PRU0_GPO7.GPIO1_7 */
-		>;
-	};
-
-	pcie0_pins_default: pcie0-default-pins {
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x0098, PIN_OUTPUT, 7)	/* (W19) GPMC0_WAIT0.GPIO0_37 */
-		>;
-	};
-
 	user_leds_pins_default: user-leds-default-pins {
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x003c, PIN_OUTPUT, 7)	/* (T20) GPMC0_AD0.GPIO0_15 */
-- 
2.25.1


