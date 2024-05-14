Return-Path: <linux-kernel+bounces-178280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 992818C4B60
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 04:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B85151C2115C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 02:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4A7B657;
	Tue, 14 May 2024 02:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kXoH/d9L"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2081.outbound.protection.outlook.com [40.107.241.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1104079D2;
	Tue, 14 May 2024 02:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715655583; cv=fail; b=h3rpgABzTeLE4vAY3rRvEFcC3lYuXZGEixfwPdngrYuZ7UvfngSF+KY9DhD+V7p6zQaHMs2o2m3g2uIUSXTRAsmY69ivFfKkeKS3vRUq6tyO4q1I2bNvnY+n7ix47zaMv3GNYjrIx7wth7gxCdoMKtxbeqbmt4WUkBFgcZDBNTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715655583; c=relaxed/simple;
	bh=TpYFVJCg+fsRyyg7Nu6SBCiRSZwVJJbeZVRIrKL+ub0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=aaJ/9RVQHRNw30Wndmr719/ZjjtPDnVsLKYhbA32m3UX/0w0Nzd4elBxIWqa0JNFxqwSM2s5Q6uol9TrAFY//UN6tK7B9EcQc41AaMzEmTedhcZqMW4FzEFuFxA6lwtllhaN3njEELuo+eZLNAuPbcX83m1TeFzC3XDutreMLro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=kXoH/d9L; arc=fail smtp.client-ip=40.107.241.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=deXKDYIhWrCMwz+vC7pcJl3Li1bNK7Mcos+FUPEroNI8sHPEuSuKUyUyffjUC0cOV260sAVshNEE9IifYKyHgnVdyWUuUJWmhRARm8B7o/ORa1bj1M1G0BLDFbQHKX/vNX7nUMe79qEXTBNriP9SONnYdv4MjLBTU1Tg70FfrLrX6dpn4xF823Vh5Mc8K+ChDGUkpiM7FiR2ePv6PlnXknurlPSKHvqkAM9nTNJyqlrcxQSpWuBfNJ9MJAodc2CWv61rM0RGspb+OZAOo520W7dO68HTrRvYY+PCMK3/oOSiLccXMWqmkJeUqVFrvuENxOu4HGX8xJBQ5snjRH9F8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lId89HD9aDmqso4yTwGwRZMJk+nm/D8EYGo0cEPv5s=;
 b=Aufnb3ErimZS7lJAi1SvqG8HgQxCSlU8br+7v3Tj1PmCOdOLLyUH2LB3R8aaraCoiImQStGjjbRw59AwvkWn7KGXzeZeE/2oZ/QenJtGS8m+qyfvAjFs24avMnLwOV7Qg26Dn96WwENt1nwc9ywVxbWCbgAwyD+RuHHvJKU9gf1GO1oYOOZY26+kpawRQf03zUyniFyDOyDp9RlRBZb2OzT1BSN3f9d7L2/qsfMrgYGZI08WOnGjnKj8UanrWwOivj9s54/DpDFxhcudnc6RlBWPIQHFbUnuJ+ZTz57XZ3ONbiy5AYya8pdtQUlUW0mzuPFS2a9gLFJcfA5GVupH9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lId89HD9aDmqso4yTwGwRZMJk+nm/D8EYGo0cEPv5s=;
 b=kXoH/d9LODYNl/6Gj3TeEmOLhXlLgAZr7kJkQ8/xJd/C6cH5TnUEXNijRZ46LRXej9Zz9PKv4JpGGv6hjLQ1U9QXufBtcf7a1ChZD6OaXmXlmMKP4vnVosHyHER5s0J9i1ZtyNvRou5PDrMMs4mo6APMtRkSiVmuK/eY/Bt4asg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by VI0PR04MB10543.eurprd04.prod.outlook.com (2603:10a6:800:25a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Tue, 14 May
 2024 02:59:38 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90%3]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 02:59:38 +0000
From: Liu Ying <victor.liu@nxp.com>
To: imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	dmitry.baryshkov@linaro.org
Subject: [PATCH] arm: dts: imx53-qsb-hdmi: Disable panel instead of deleting node
Date: Tue, 14 May 2024 11:07:18 +0800
Message-Id: <20240514030718.533169-1-victor.liu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::9)
 To AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|VI0PR04MB10543:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b281fe5-29ff-4a7d-23a3-08dc73c1e464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|376005|7416005|52116005|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?muMA76hbNrBsRDE7ESKXS4nLfEeS3a4wv9ZuobEn9EPhILS7J/OAA6fepLuW?=
 =?us-ascii?Q?ykIohIVnRPkaD1HpNTAKeoS3auGeMZFE9a4NhC9TWxtPr/PHUBRvFjzrBYYJ?=
 =?us-ascii?Q?MZwRhpFjA4aGo4FU8aTxklw3DHmDkMmWgvjFKVrd9PwGtTO9VGDkcgD80A8C?=
 =?us-ascii?Q?fK9THhqn7hzdwGazytNyIgO33Ycm849/60YIOblxS3EBfQbc7vSAZTPSQHQX?=
 =?us-ascii?Q?ep2pvjqhWiN5ApyRzrBbWZqvBKrFx2klT0gYMqZ/zI1GgXrSLXUuXkFym5U7?=
 =?us-ascii?Q?DMgr5FFm/qIa2MyxK5cF+FYANAnnnxIBw/q2qkOGHw/dBEy/TL9dqephMWCi?=
 =?us-ascii?Q?Rft6rr8znrRzKvxc0r/WnJMJmcFb0htVQXrMMVLoVA+/mfhfIVo3Xx4r51W0?=
 =?us-ascii?Q?Wi9TyPxD82M3QTK2ECxRGCR14IVtXECfbT595QK9UlIensQ4qroauwS2cg6O?=
 =?us-ascii?Q?EvppN53VjWchEx122ULKE8jwwQMqGemSEP7+EBDgTLY8GcZR2Dfp/7AZa+lK?=
 =?us-ascii?Q?bgJ9Ecbfe1/4hUxN2ZSdUYbqCaXglkKv8eTvHT5RwltKAV3XN1pa4BuwtS01?=
 =?us-ascii?Q?7oyGKpQY2hopk+aveDbiDFXJ+qFBCj+xFuDtc8RzVOlQRDxvSC6yNZLCWkhW?=
 =?us-ascii?Q?eNSmcCRpoKY/wH14W5Ihg0fa/MKKqGqY70L7gB5EabM8Dd5idnUmb+KMPsMV?=
 =?us-ascii?Q?FvSvB00CaiEB0V+guK487Q547F6EiZUaRIZYcbjQ6rAOynMzv2mjybjAYCvp?=
 =?us-ascii?Q?0qe1rjkc2VvG0R1DIFd/pPF59lYZPNvt7gkBgWoGf54PK3qBvbDGnv8lk8Yh?=
 =?us-ascii?Q?hWBXNnl0tRxT/5vJuBVOPM5b7t+S1H75RRFQsIFxYuO7KAW6/uqazJR2IOHY?=
 =?us-ascii?Q?YDYWVKPGCdC1v1nokIbzvl3N66eK7Yr1ZNlefPod8bJjMbqGWr2X4x19BG+9?=
 =?us-ascii?Q?FMLlPpRG+j1oVie6WGSbpcHhiuBCLtPnlaqF8/ef50pOWU2GMG1c2AxC4zPV?=
 =?us-ascii?Q?dMlE0LChjCwovdUK4jsPP5fpk5rxqXe/9qa15Dbr9SR3E/vYrXWnXyIXn1df?=
 =?us-ascii?Q?1OpJ6JsbkpIyTvZBoxpzoCTEz7MOGBYiAWEEbSV+8GrjerwrKZNJGCXaMuq0?=
 =?us-ascii?Q?tTMd92/+ECYCWsteivr0S9a1ROQq9tkfvrjjT/ldfmdReI9WXWbAsNJquEBi?=
 =?us-ascii?Q?bN6WDJNvrgEsArlmff9MQptlwOmlZPY3IeiCkBIGXlQdLPlscO3NQembwfvM?=
 =?us-ascii?Q?8nyBLD04UK1CckUb96uA6i2VzySrMHeOJFZncNrnYzNDBoJ7XIns558K3aib?=
 =?us-ascii?Q?41T+4VErkerQm3oARLHDhfBLcWqEUlARR/u7e8kI7aGmoQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HZ5ICL68+hN91+1oynSJUNg5aX8dlC39Qt5PAvNEXu3ZPfDUQ8gqzhGjuJXf?=
 =?us-ascii?Q?x6JOpDhjyXx9ApALyMI4vAt2VAtkBTSnxFtH+pcxnNVAXPNuj6z1pLBo3Iyh?=
 =?us-ascii?Q?QUsz7aR6Ed+IradUk3mqZEY0TtzVu54CrQQwPNhkRyamOnxQRHHfglShPIa+?=
 =?us-ascii?Q?eS4KvgYjpRMZZy+YWSjOH6Lang10l8jWuMZPP+nkURhXP/d6jcPDBTBok5Vq?=
 =?us-ascii?Q?P5ElyJO2PKfz6gl0lHQd8EqPWEls1NQztdl/hmvieQHWzfNT3gSiXrllMn54?=
 =?us-ascii?Q?kRX/+DE/tRWSmsYPMKt0ntgyjNVRb2RYw2OW6CTBBjDud0wHR1fUJ3Vs82M5?=
 =?us-ascii?Q?grJ7RNLqegW7UNVJ5IXiNx1XtKimDA6B9qtZbzODEAKBmx+bxOADNC5hiktl?=
 =?us-ascii?Q?w9G8LkXXsNkT4/SguZWs5Q1iK41faA/MdM2Z/ypcA0MHH5MHZ3JhaZ5Typjp?=
 =?us-ascii?Q?/8592PTn74efXi65ITZd9neePbM6j9racydkhSMZ8GrY5rcTkjBU6Dw6qyHp?=
 =?us-ascii?Q?NAqg/aLGLqXU/M2tmNKn0NvY8YiI/FCX2I60c50KBS8RhUjjdu8CkrRNGbZK?=
 =?us-ascii?Q?EwJQZQJc+0GC5976chhzZhOm4A5zRZCkp+KjdZVQysQCD8+xC16Eq7Jmit+B?=
 =?us-ascii?Q?t3OzztKyRxCJTT4D/M7cKmGPZEV1LvlLM03B3puMaewgqk1PR4zxqF8b0hdW?=
 =?us-ascii?Q?9N2y8ngQAg59tv91gyFiu5skP3RTOHtiFDxbIsMJ/Ax8413l04tf9MFvwboP?=
 =?us-ascii?Q?7w94LBJdZHTt4ESoT4zNSRNNJQDM37nQEUN31ORSlw2PVeLiw4YEU90s+FcK?=
 =?us-ascii?Q?+H+PEeMYPs/8OjGJOiX11uuYpATkaAWmOi0cwF9y6ijPfikXxs/Q/L6rhWKy?=
 =?us-ascii?Q?eoW9gbkVkByOIVoVtG28V+l3fBUwxo8mnDGppAMiGbqtFqdG+pclGgdQmMzp?=
 =?us-ascii?Q?sbIG/jx2HQB1mmhBCqGc2HSTIaCbKwz6ztYx3NdrNqAZ3lmKxZgaXU1v/uUB?=
 =?us-ascii?Q?Y8yY45MFCM2YzKz3CA8DJD6jygwwjqu3B/j+trMwWwE1HFzum0scxS+DDQ8T?=
 =?us-ascii?Q?wYYVie92ohDMqzaS16YDUJz2P9JsIw5QDcsX1QHgZZORdLL99SnALB+MRuDC?=
 =?us-ascii?Q?uSUcT4hx1fRX5h73CVz5cXbqajWxRqnbPfJexA8Ikum9i23LRyxm+cy3/k8M?=
 =?us-ascii?Q?COVcRhPukE7aWgqpRCTDrhL9M9j1M26+Be9Uixe0irUdklzUC4ySQv1xCBRx?=
 =?us-ascii?Q?OMALlvNCK9gLOVfbAYt6NDD01ySe5RWRhQBvWBN3QXbUcMOpNIviTN6l+pRd?=
 =?us-ascii?Q?bSqmBiK8PmwcWUIh4k0T3TYmIMY6j8Cpign7e2XYTmPQqd4JmiA0hyiGWz35?=
 =?us-ascii?Q?nEA7vu/hlPaDEUDiPKJvS6YoLWfMWzKP6dZHmr3sT1XhDwS+b+15V07QtpI9?=
 =?us-ascii?Q?iKmhXk01OL6/F3mFgf9zh6HiCCn/CfSEFRhcKT2LvdNmjnCRkCIvBy5UsuoQ?=
 =?us-ascii?Q?BaZiJjOERzrKJA7Fpz9REh9oRRrfxYoViphORukbup0FWM+crg1DVSv6UPfw?=
 =?us-ascii?Q?W3FdGcs9ZJZo3lusxVv5QFuqFIr/eowhUvCgqa+o?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b281fe5-29ff-4a7d-23a3-08dc73c1e464
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 02:59:37.9526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0rpqiOJMiZSmXsdO01upF6uaCoazLz/q3i/m9Grgft4uIvpFpSmQUhW1fTMqw/FeX0U4MNIR9Et9UpLz3poh/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10543

We cannot use /delete-node/ directive to delete a node in a DT
overlay.  The node won't be deleted effectively.  Instead, set
the node's status property to "disabled" to achieve something
similar.

Fixes: eeb403df953f ("ARM: dts: imx53-qsb: add support for the HDMI expander")
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx53-qsb-common.dtsi | 2 +-
 arch/arm/boot/dts/nxp/imx/imx53-qsb-hdmi.dtso   | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx53-qsb-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx53-qsb-common.dtsi
index d80440446473..05d7a462ea25 100644
--- a/arch/arm/boot/dts/nxp/imx/imx53-qsb-common.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx53-qsb-common.dtsi
@@ -85,7 +85,7 @@ led-user {
 		};
 	};
 
-	panel {
+	panel_dpi: panel {
 		compatible = "sii,43wvf1g";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_display_power>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx53-qsb-hdmi.dtso b/arch/arm/boot/dts/nxp/imx/imx53-qsb-hdmi.dtso
index c84e9b052527..151e9cee3c87 100644
--- a/arch/arm/boot/dts/nxp/imx/imx53-qsb-hdmi.dtso
+++ b/arch/arm/boot/dts/nxp/imx/imx53-qsb-hdmi.dtso
@@ -10,8 +10,6 @@
 /plugin/;
 
 &{/} {
-	/delete-node/ panel;
-
 	hdmi: connector-hdmi {
 		compatible = "hdmi-connector";
 		label = "hdmi";
@@ -82,6 +80,10 @@ sii9022_out: endpoint {
 	};
 };
 
+&panel_dpi {
+	status = "disabled";
+};
+
 &tve {
 	status = "disabled";
 };
-- 
2.34.1


