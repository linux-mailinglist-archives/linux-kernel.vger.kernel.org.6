Return-Path: <linux-kernel+bounces-529945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B47A42CCC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F163D176B8C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F801A23AA;
	Mon, 24 Feb 2025 19:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NXo3ixGe"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2047.outbound.protection.outlook.com [40.107.249.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B08538DE9;
	Mon, 24 Feb 2025 19:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740425608; cv=fail; b=Vt65be/F+PaIAHy/HilLXG1DuidAkVjiuGkxnlBqBGu6SW8fGwEoE79ekZ2MShxKJlRJXsGNWooXUZc1yDjIBzkNHX2OoZe2ACHQw6VRUistO8vrc0JLrAQIIoOMdU+dxzP+FN2ajQ+yDBXuKyj5C0BAwyZ5JhafSgrUEaRxpMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740425608; c=relaxed/simple;
	bh=l5atS8MbDh/TI/KBAhwK6s6yhKf7BcqeugfBB7/kjRA=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=jG2iOKw38+R4ihm8dJGXXNvoP16aKIzv06eaJUddEZYLOHBAWsMYGmP+olF07rRBSIYoFaa3ndmkySv9HfayygS5jkHqjN+ofjbrwQn3Yh577ROHSA8VefBXj1Q2XQpGUqz5Fwt46FBs89gB1Q844KqJpo5VByb3J2oSd8wEIiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NXo3ixGe; arc=fail smtp.client-ip=40.107.249.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F2UVMDtDivB+ryYB8YpuYwwsauBLJy/dZ07WtuaEPk6ZwEhlfDztmAAsPwjL0aEFFiEtKNJhFRB0PjWvX2+QqwPnireDVESrmuxY9jSNZ1Wvv0aXvwNcP4iuj2O8Cprnf6demxBb7Gi3ZxnVUrjHHPltFdzvQC7X4qY1MZhtTl25Skj78SpsnPrQX3iIRnC/LsGFxBIzwEX9V7rTh8vSegKA5GCUtiIEhVkX4KngEwwqemC2O2SAAuLna3NHHNkz8JW/ZlKRQMC7Zu8hanYoiU4+8JkcOs4bLTw82SEuGpiRnqksn79JeloxSEZwxmM788sTuDzVCXanBMOv+yJoaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIttIXAedeu42MO5SEx3eSCSc4jppgjq8uOVY2verPE=;
 b=QxiJn+YUSskDJ0toe3bfQvw4dfsgv9E2kteUvI0xAj9eG9kbHGfpOZEE0fufDVApV/ml7YSU7O+dZ5fjLKUXJjvxjm2t8KCnRTUARTnlccEUsSMFhTkmCja56z2+62sIokyh5OpKAsjrQY+PLGRRcGXQZCzxb1ROljyXcYtJYuBQXbWZJXTeob6tORIv7d69AC/P0NCEx+zhxUOaAFy/RzF84MvrWMBd+6BMh5nNVBUFNxSC+PAoz0DuMxIdHj8sv81tQs/mJBqP0iY89RwnDuJm6/wLpSojB43l/Qsn/N3Ae39c2zNRVbD4XC6N6yOt1DH6j+o/XNhAPbd2PiZdnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIttIXAedeu42MO5SEx3eSCSc4jppgjq8uOVY2verPE=;
 b=NXo3ixGeObY5ouT5mY2F71APx+u71ghpieHMzeTp+3Qb9dDOcR326uVmI8jk1cHLIJUcrPQj1lYeNYyJy+4O+KEm6L7u01QQ39SWiWIn+yLSYbmRL6G122KXpYQsWywDx/Yesg8t1ktRQD4pFw83G+MSOCqJ9gFWVnI81ccmlb4PyOjWd+jaWTkECkA+crKy4tW5tYD/jUaG+NkA6E/HCPH42NqPMkORm8frIlBnmgt0gSUY+8iVIzUqJVc4iLtbgVigiPS7te9Pk2YPxs0OxdLz/QeIUfzMuS0le9vIPgI6jl0vtYGZSZtYNd5IQOeqQWQmEyNmYczhBG1HrHUlJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU6PR04MB11088.eurprd04.prod.outlook.com (2603:10a6:10:5c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Mon, 24 Feb
 2025 19:33:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 19:33:23 +0000
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
Subject: [PATCH 1/1] arm64: dts: im8mq: move dwc3 usb port under ports
Date: Mon, 24 Feb 2025 14:33:07 -0500
Message-Id: <20250224193308.407606-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0105.namprd03.prod.outlook.com
 (2603:10b6:a03:333::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU6PR04MB11088:EE_
X-MS-Office365-Filtering-Correlation-Id: 5546de72-e4dc-42fe-f0ce-08dd550a1a39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|52116014|921020|13003099007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aNI7u/g8PcFwIa3oO50xc6uonmWSViIeryj1S+zyIg/csFTv3mkLAqlNqoKx?=
 =?us-ascii?Q?r7v94V+YYjyg53nwsy78C6VAXXsXlzJ6QGifYdKd43kTBKqwXcRuHw5nOxpZ?=
 =?us-ascii?Q?i3JK8ltMoM4G1nMoUvayOL2SqjBFp/BTOWfGeWshcGb5DcBSo9+Ek4DRL3aI?=
 =?us-ascii?Q?VSMjuHhwd390Ukt4hZbG4Q7MTNuEQ/px8lQ5CInHC2yma0cDt9cCEDHyUysz?=
 =?us-ascii?Q?YU1W7dJwvdSLZOBci50QAfa1WZQ4iC33rQyNWkH0OI0nd1ah/2/TkpvizTr6?=
 =?us-ascii?Q?qZYUqj9MPFLVLGtMH6xZl6AFhmw5pzPjn0aenbwkV8PHE+0NWs7FKqiYausX?=
 =?us-ascii?Q?OJfVeJmErSI9/jkkx3be8U7zQrechSFZCQ3ozcHKaLFTNMMz28R8wYZiMN35?=
 =?us-ascii?Q?aXJ/FrrvKl67giaPjaM+Jgqmhxj36euF2e87bLw9oFg6VTcFruBHwDhbmRrK?=
 =?us-ascii?Q?hAyRYGaA97gyOgNkIZspeCe9wlPpNXOjdatog9aL84TiQ5OaTanlRsB/Py4e?=
 =?us-ascii?Q?wdIXu251glTSnj53fq7CFSk9suihH+0UyelcEEqRHDJYKOEpRdFuZFnMNylh?=
 =?us-ascii?Q?WGNPYiz7HuKw7nrYvnwl/atU3IDwAJLXlxGzp4pGYDIsMQaVu1UHVoZpusgd?=
 =?us-ascii?Q?IKpmFJniZDmUhfhOK9NZ+tmOv+QGwLvjmO8nKLlZ/1OH7fOe9d1Fou2Z2y4t?=
 =?us-ascii?Q?gikMRpEf3BHp2SmDBV54+3gFiPXR7nLtBW5qtwNa7bS327ZEZGFmwHx8Kxx+?=
 =?us-ascii?Q?udES0yomVbd0WP7/7JUxzSR4Hp8tc469J9mrEoCbePeYgY/vNob84EhozM9j?=
 =?us-ascii?Q?oabAtbk/Y4Z2jE+0p00Zw2SPBIhWSAfI4OOop9A/j/8Vn6cz1mJ8fSs0QXZw?=
 =?us-ascii?Q?VrYeo0aqmGtqvbrBcBTHGs/Vp/lsuQ1Sc+jq2hoT1ANuUa0cSvfmy2x6YlC8?=
 =?us-ascii?Q?4Rmzw8FaGCXGZ0dqPr4cISPfD38+vtWM2TZzX//WeRXTAxOz7xdpN2lBGWD1?=
 =?us-ascii?Q?4Zwm2uX9mygEneRX2ZyojYe+hwf1ZA9zEED/+qcT/iaDH9SXr8InFmfFDxog?=
 =?us-ascii?Q?nTtXhwcHhIcD+CbAdjhdifBak/BIYbzI5CluyTV3a7GOup6itpPsZw5xGPHT?=
 =?us-ascii?Q?Rq9ORUFbX/jBTISM02WwyA8Ylup1xZTCCeZFgwT/qQqZzJklRgKrg643JHLF?=
 =?us-ascii?Q?H2dXY0zYrdE40W/9ntMWhibqXHINKTrCo9h1ZNB7mpt1VN6XmJcvus5jKHNf?=
 =?us-ascii?Q?WaD7/3foyhXlMYPp5rhOq5fQzMoqCnkNSezV4PlVRD9w2EXBjcmc6xAPFWoL?=
 =?us-ascii?Q?lMVejNojm/TV5YpTSelvIPumoHEG6BjG7BKnXgXJKkQ/JqtWN5yIuFf/0K8D?=
 =?us-ascii?Q?6BaJvgGXltVA2PYauWf8APBhvZrIst1HGtuo+XhgM2hbDMEcvA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(52116014)(921020)(13003099007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YhkCZ8aOQnmIjVQJtMl8+ZLpQAWOpmwBm9hgOfiMIXFCxAZIxwIdqk8JPFt7?=
 =?us-ascii?Q?2ps71xGohfLl4oXB16G3lgRCHlHuiRklRJr+L5ps/MkD7fMKZbMnlsF05hoQ?=
 =?us-ascii?Q?B/6pJlXjcp9kTrto2c53/t56aNusuqcN4kTTej/Ut4Zn3ECLEdhVNp0TeM2l?=
 =?us-ascii?Q?+SybD5978bdRI8lVSu10M6yZKjLyvlA6O5wU0h4/SUlqvK9jMTkRX6QU/zUN?=
 =?us-ascii?Q?46OcdtoWWv2GH7XT6YasEysMoAgK3CCOaRpbmiX0WdlgYxJck/P0yEdfkYnJ?=
 =?us-ascii?Q?iKNF69iwvbmE8pnHz5S3DSmEOcfdk+ZFz+jho4GeQwuRUsohJvdQ/9+qlTUn?=
 =?us-ascii?Q?O3NNkROc/ylTJ+Ma6qNi1ujVgVq0Wshwxp3CLCO5A8l2iGLuYquZ9IZJizll?=
 =?us-ascii?Q?ueq2QmGxgWQ6fpxWncYoEJ873coIiUNtAK9NHguygxQN1cDpUfskvE9TCSd0?=
 =?us-ascii?Q?EqNRpZew94F8ncvt+jOokku8Joqq4AkdFyANH2V7iy567GRxcx0laLOOj0AF?=
 =?us-ascii?Q?dWeKl4SQI+tHSUn06kNyWRodZkoMLV4ynCR16cPYKhPk9aKDqUaxJ2xHcVCd?=
 =?us-ascii?Q?icmADRy6FngC/hQRsG6ZO7y9MRmimLqiDq6K3axT0y94HgXzB4g+9igQpQkT?=
 =?us-ascii?Q?6/4y7rcVq6Octaz4reMGpCiuzSXpVMppQrsP+Uj+JtRfpBL4JyExzaVizXPh?=
 =?us-ascii?Q?CEuTMuekzmA/wFrLY8/DZQ3v/v92OYVED8OQALz2RHW6FTC2j1hbBdTLdR51?=
 =?us-ascii?Q?5r1yiioVOvrN+Sx/1k6I1v/ag3C+8y204vhCWkwlx+u+IOjVLoxz4G4aT+yN?=
 =?us-ascii?Q?fMzv3oFr/Wa2QgoCRwN8CZG5n7RE4varGNWrlVPnPCQdYlYBcNr5+lSlNdOe?=
 =?us-ascii?Q?A3UTzvAByh/epwYPDXJTiny5nH05x/TGKOs/skv2J6SEZuWheUYLar3gtl+D?=
 =?us-ascii?Q?BAVa14RGVjkP5jzEt3dNNiW4vxXPmhxSEVhqdAk71fbAxTDvGbinTWTCN+ld?=
 =?us-ascii?Q?B1+pLKlELKEFJ1A7YEzl6ycHvj2/5YU7KZq7lWLi8m0bCpUzsrJh7/hX0Mp2?=
 =?us-ascii?Q?Ar1KpIqOOo43e9GhPGJmaOP2eKFhjEnwcRhUd2/QtbI/0UBWzUDRZUjM6Brp?=
 =?us-ascii?Q?LaR4OoYgQbcdX4eQyhCGcw1PrB3NPFvArv/djGGQY+sqsPuoWYeGcxfzAKs/?=
 =?us-ascii?Q?2RBjvA8zsyE7gU6nDfgU1dXeG7lmyyDDZI3Wg32253k5oyeIuyffKnJpA/0p?=
 =?us-ascii?Q?mmziD1Lq76BUax5rkQwwnF/NfdPOSkJxRdQLXxXS3cWt5zRIBLLeCgjDf4Jx?=
 =?us-ascii?Q?xoqotFkvJP24Wr6nPQN/NcAs0H4Pb7gNPgBT8ClZd7wIpvP5BpC6IFpunSgZ?=
 =?us-ascii?Q?LrRYETllqYVCDhutHfHDWcO9+I5AaPW81YkHbtEe70rKy7CfwBSH+mx1oDoA?=
 =?us-ascii?Q?f7zSlkcSsDrxaGJ9/KMQw0AywSIuWlZASfuciUhgzRcIxL0uAGenw1c3I7O8?=
 =?us-ascii?Q?JMYkbuSdso+KTalWXwjbVqwELSY4MdvnSV2qSOtObh0IQIngJsdHVvQ1W9QL?=
 =?us-ascii?Q?SQL6PHc8PsS+V6zULR4spaGkB4Ldd3ByGIbE8i/S?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5546de72-e4dc-42fe-f0ce-08dd550a1a39
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 19:33:23.6295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eiwZGkSniaAXF+J9v4X8oxhfNsPbb23+gsBVhzbDMvI/37Nuyp6DH9AnGKxQ3Ovy45SRnvf3wixClK0AO6AMpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11088

Move port@0 and port@1 under ports to fix below DTB_CHECK warnings.

arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dtb: usb@38100000: port@0:reg:0:0: 0 is less than the minimum of 1
	from schema $id: http://devicetree.org/schemas/usb/snps,dwc3.yaml#
arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dtb: usb@38100000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'dr_mode', 'phy-names', 'phys', 'port@0', 'port@1', 'snps,parkmode-disable-ss-quirk' were unexpected)
	from schema $id: http://devicetree.org/schemas/usb/snps,dwc3.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../dts/freescale/imx8mq-librem5-devkit.dts   | 25 +++++++++++--------
 .../boot/dts/freescale/imx8mq-librem5.dtsi    | 25 +++++++++++--------
 2 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
index 9d8e7231b7c63..d9f203c795197 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -979,24 +979,27 @@ &usb3_phy1 {
 };
 
 &usb_dwc3_0 {
-	#address-cells = <1>;
-	#size-cells = <0>;
 	dr_mode = "otg";
 	status = "okay";
 
-	port@0 {
-		reg = <0>;
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
 
-		typec_hs: endpoint {
-			remote-endpoint = <&usb_con_hs>;
+		port@0 {
+			reg = <0>;
+
+			typec_hs: endpoint {
+				remote-endpoint = <&usb_con_hs>;
+			};
 		};
-	};
 
-	port@1 {
-		reg = <1>;
+		port@1 {
+			reg = <1>;
 
-		typec_ss: endpoint {
-			remote-endpoint = <&usb_con_ss>;
+			typec_ss: endpoint {
+				remote-endpoint = <&usb_con_ss>;
+			};
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index c19ffa8e8a79a..9e0e2d7271efb 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -1321,25 +1321,28 @@ &usb3_phy1 {
 };
 
 &usb_dwc3_0 {
-	#address-cells = <1>;
-	#size-cells = <0>;
 	dr_mode = "otg";
 	usb-role-switch;
 	status = "okay";
 
-	port@0 {
-		reg = <0>;
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
 
-		typec_hs: endpoint {
-			remote-endpoint = <&usb_con_hs>;
+		port@0 {
+			reg = <0>;
+
+			typec_hs: endpoint {
+				remote-endpoint = <&usb_con_hs>;
+			};
 		};
-	};
 
-	port@1 {
-		reg = <1>;
+		port@1 {
+			reg = <1>;
 
-		typec_ss: endpoint {
-			remote-endpoint = <&usb_con_ss>;
+			typec_ss: endpoint {
+				remote-endpoint = <&usb_con_ss>;
+			};
 		};
 	};
 };
-- 
2.34.1


