Return-Path: <linux-kernel+bounces-374769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF95B9A6FA2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C4941C21871
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB461E8831;
	Mon, 21 Oct 2024 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GCBn0u8c"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2050.outbound.protection.outlook.com [40.107.241.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BA41F1304;
	Mon, 21 Oct 2024 16:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729528518; cv=fail; b=pB/xVnFTA8IuJf1AdTuu++Q6imJOgK67KlGbk3Z45dTBJfxjD4x+K2jgUp26DmTJnxq9TyDwX9SIioE1M/oy3jhJsw1oJYk+cAPrVyWGg6yBVwKjN0J/Kkh2ddFppcK8BQlNtGdTT6l41SUjFJxLJH462dk2cqEYgxmTA9Nw12U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729528518; c=relaxed/simple;
	bh=cLvwvSMp0DH8d3sHxcL/XCLuHuAD+elAqLXqEW68dU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R5CEHwQb3HqGe1CRubtLIvpFaiXgO4VKAZJwuG8UJg76gbpH/RtpplW2YJgPaGkLWh9qdoXpinbtGtZ9PZFbh4I13BIRs3LzPJuh1sl2ml6tpzWhTJHbeTs9ujGd6AJcJdDuj1YK1vXVE204vw+ltRgpBTCqwy6u7bCFh/nuRxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GCBn0u8c; arc=fail smtp.client-ip=40.107.241.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ix0FZo4R55+f/Uf63lQ2KjIhQiLZNtGYxQJHEKZEKH/pRYxrfDq4Z6n4GgtTuBeMaWwWYaPXepIpMPNRuqCn2b/q/B1BqSfcDPQFAQ6hlcVnNHRwk+wQyPEt/SVDz7Dz0+MRP+3wBFRppesIriJol0kbyj2ar0ZeDMP5dl6akZLfbcj+hYuhUOLNEWPYgckouwHhzRfVrTL8jOOqArWLfiFIeIhoO8s/n/KE/e1YVVZuXSsof1TqWbNWyHYSeDyWnR18RwAcdHnLmjjMs01AJOJ8/RGZB08LHdRAk/yevSA23OUNw2JCEyMVMzUW18VTMkJeq7jujzqVIoH/9uh17g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcP05RJJOy8o+kc7gEhtxGmANZXOrTSweb++UwwWgos=;
 b=PPQURvT6xVplvrTNGR7Ew469R8XxwhSgBaWXetJ7Je8Sd8BtdJqzi1aPUNgDnXRlYT9I84E3UfO3vGhTKlgq+uKqPzHkNigwv3rX+fVylCeeLRQnwBOnPoOPmuG7q/ivjZEAIzuvaRm2LxxoJhJGmFFISDOMKfamoeNxCZBaiK6zuVtbPCahhgzvfrUqvuHp3oVmX5lnHGtjAXtllyUhJtJboHXFLSbOpNTKLkrSPWNrFlwF97H/y6iw1wJql3d9sG0VZJvbzIKqTLkPwG+W4sCARVbdSaFD4C8+z736Q2STCjtSY8UmGh9BJym+vBsvV/rr3UB5wDHN5Yq5xW0/Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcP05RJJOy8o+kc7gEhtxGmANZXOrTSweb++UwwWgos=;
 b=GCBn0u8cP4hcRXh9xDPFH7BqlvcHhdPjo7Kd2IF7U7xvdvtPmBC7HX6SyQiil9gIUoHmTMRSltaaO9Q6ZpnTOcddeoXnbIcXrbqBrbm2GALGZUOyHWxKvA/LHz/F/jDDFCnTvvkH1QEhS7wd/gfvTtnekDhYr8ITxzz8as3DDGyN4tYqaEngBlttGwZUSQYijKep/mGk6xoA+3Mdy9//BmUMu/wFX1F4zL03FxyVgIkgaKA8nCbS/6dy8MDZ4emM97k2mw8ShB4/QpJQiBvkrdec0aKldtDxxVEPl1LfwnvNUBuqKwuMriMIsyLQrqKfaPZ1rcI8c//qSi9rPypaHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8831.eurprd04.prod.outlook.com (2603:10a6:102:20e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 16:35:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 16:35:13 +0000
From: Frank Li <Frank.Li@nxp.com>
To: shawnguo2@yeah.net
Cc: Frank.Li@nxp.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	festevam@gmail.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v2 6/6] arm64: dts: imx8qxp-mek: add cm4 and related nodes
Date: Mon, 21 Oct 2024 12:34:37 -0400
Message-Id: <20241021163437.1007507-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021163437.1007507-1-Frank.Li@nxp.com>
References: <20241021163437.1007507-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:a03:180::18) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a2e5d16-22ec-4407-3351-08dcf1ee5617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sTguTbp0mFJaMQF+0DwtcYrGH53fh+O8A0qYvLLqS2LLwaH/ZgfXPy0xbWyA?=
 =?us-ascii?Q?6kTWhALO4P+Z3EKLV9BqK2UqEEZmNjKhhi0dcFTTlHpQ380BlR1UU1Fo4Y0z?=
 =?us-ascii?Q?wPZGWv4/R7r0i17URsAXpEEl/YjsTZ5h7GdiLLuWSpzwEn+zL+O4MKdl/u5e?=
 =?us-ascii?Q?w5nZSREVgck1uOZ/jigW0iOLmit0Thz049oE4Y8luzJ8eIukAnQyurRY2U33?=
 =?us-ascii?Q?OQWCFMcwS8Q1k5pRLux7THWw5DhK5AjUuaVcwhZfyjvkwgkVTt6Qiq7mhPG2?=
 =?us-ascii?Q?RPCW6kZ3tXJ0nhhDNlTdCjBcsWjXJCymlkLO5YNJgOmvHU2iZgqnmh5CYdQ7?=
 =?us-ascii?Q?UrR5e/F7Wq9HNtEr15qUHafsCps9VSKjNYEc6LfKOtfQDKLg/frMFJP1ROSL?=
 =?us-ascii?Q?pCtcdm5GeFFg2Bm95YQlUJcMRAdZnYa6OcT8MrR3VdA67jtxi9i4dOEGlQMy?=
 =?us-ascii?Q?j3nhQBEhuDyTJSBbUvW+MAz0llr06SR2I/o2o5puQsj5K99E0qQkC3GEzMfs?=
 =?us-ascii?Q?CG4TY1sFfflvn2uZVEmwb+4H1aKinLq61xlcFr9L21pFIsUNW6EAj/h0ErkX?=
 =?us-ascii?Q?GNG+0/GfjdXpQLFBZb/pgXBbm5tT8Igf7gGYuqJs4Ve91x8kc/Y5rlpPpNft?=
 =?us-ascii?Q?8W/dHtF6Be8xSXfUAiYrAslAt8TX/Vj/02WSq88ZVTSwAcHyLYLmqetLCWa3?=
 =?us-ascii?Q?Wdj2kN39iXFHiCSc1miT9wiqsAHlgk2XZIPzKKjcPZpinvUMaDbx6O1wHWwV?=
 =?us-ascii?Q?yS+x3b7IhI0Bl/aApovJMjUTJjinGXfYTgJZGNhHwaFHSgEQimAa2c8qDIY0?=
 =?us-ascii?Q?qrzX3vjNXkQTyhPh6dDdno5juB/8/iefFb9Zh604JDiGl+YWjxA8uDhYIWPT?=
 =?us-ascii?Q?G5+/PQ3WLz2W9HlxS84fIYe7dpS4SheA2dOlgMOz6kNNwIRkrYWF6sGfEP8z?=
 =?us-ascii?Q?ZMBp5SnFobDdh9UwkH2pOqAs80rToZwNmx5aqwfLQY71M6APUQUtezDDRLjh?=
 =?us-ascii?Q?Uie65zl8XHCooihrZ9NYPYnqK+OgZtz8gOF0vnZP7/z128mYWaHPUOx3yBsd?=
 =?us-ascii?Q?jxfs8lJul8VryYe3VEhbiVNTRlVINwxxlf01sirkv8VeTXNhrKvif1pFlxQm?=
 =?us-ascii?Q?wYmlDI7wKwHznF/DIFnu6XCacOqpO4IUH9LIQZ9/8igIoAr7t9J22tvBPxkZ?=
 =?us-ascii?Q?dYVE+0/ja25WLPuEdYhEdP/blPnPtNz2hfDZpFKPGf/hdLfXSz9CvxBiUqLa?=
 =?us-ascii?Q?wmpGlp7GJBYLQhuaWEKEKMn1e25vzTsmLUNfeMlJDBOMezSMTH3vbZfj/XEN?=
 =?us-ascii?Q?mBwHgJi8CKucx7iV+I+DTDcAAkMx0Tq4ijT8VLNFZsM6D5vVZ15Q/n8oz3QM?=
 =?us-ascii?Q?qNJ7iNE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y2/9/xD8qBIom6091Qz5xxXIo668ESPmDY6Fw5dNwF1q8X2xXkr2nuGtFcG/?=
 =?us-ascii?Q?Ck3QPS2tJKGDTa9g3uYTvxInBJgDOYswI5cxrMD8zLgLoV4hfjPO3YlHntBS?=
 =?us-ascii?Q?PjuWijCigbNiv9Rj5imAUYyAtyOgFUtEqlZ8SSnW93KkH5c9OK8VSTuAOkkW?=
 =?us-ascii?Q?AqiupFAMYnymNaE0p4751hu5RHQe/J2g2OFHp1BwldJpwoM6Xj9HDHAV/MPR?=
 =?us-ascii?Q?chEPXW1E5te4leKqyhFIL8sUl/If1DpZzXeb8XUnOvcAHy27cx1Oe3Cmgt+T?=
 =?us-ascii?Q?p0tjRu9Gz2qktEZX6NeBU28AkqJTktMGJxY2IpQLdPzShXvPg6vwQZHEwRZX?=
 =?us-ascii?Q?Qxpc56euZRa514xCVsuCuvRTHiHJcnAMdgxh0H7YEDvvGUB+r6Vn8GDRGJ5d?=
 =?us-ascii?Q?6i8iHhjY4MMAStPbx3mCCoLb7L7RLEZ7PcVuoNbO0HJm/FjNF9R1uX3JJ2/+?=
 =?us-ascii?Q?+94E8n1TM/UyvN3wl/+TcWw7gXpNQcRE9BrofrKPNs+3Ulg3UiRojPnaloFI?=
 =?us-ascii?Q?yc8kxX0YSMJ9qWR6gCawxgoXAvOr53iHgT4wcfwed3L5lPA2FljHVKR9LvUp?=
 =?us-ascii?Q?pWAu+lPJeh3BgNSFZ5c3Wat6OjYdIZuQ9z6iSl90AAkUzUuAXITtg6OeXwH2?=
 =?us-ascii?Q?ptUqIO+ZcgVuxH4rBAGL0n6wmxOk5nCpwCBQ8y1XIazHZBTEBn+0EOcUoX3+?=
 =?us-ascii?Q?FPSCoduXv2tPZrbmwtET50/HTY+jMur34ynxXjTv31jNMULd3fSC64e39Fe4?=
 =?us-ascii?Q?Amh335PfyfRqsODQDGUNvz2zQgprd5iNhDZDV3yq6298c5l/AbC0z7+B/JFw?=
 =?us-ascii?Q?kv4Baov1axJkXrD2yAd0ESnqtstp6qeqTWtj0gUOv8wlWWPH1uiUDkAenbwX?=
 =?us-ascii?Q?H1hF6NfvZxRokq/gdZT20MdePyF9hJJjihhH9K2fahtlw5heknlERdGW7Fc0?=
 =?us-ascii?Q?nXKY4aWWo/A30AYw5BMOjKsgne2D1hm73Ho6Iq36BOdhWPRL4XJmUVNRe9sd?=
 =?us-ascii?Q?lyxit8/Q+lNvy+wsMD9gdwFoUWRTWrkaA1OTf45iLbNyaJgh8QBwscjmpijI?=
 =?us-ascii?Q?Fr6ZYwanXALp33Frls5fQxlJ+0yQe0oBZsN0P/dKVw+58PHqa2+xFe1LnoRr?=
 =?us-ascii?Q?dw9caDf0W3r3QsHE7KVRweuE9dFuvwBEZnd46nGxoFbEsYdXnJI8JhvpLsSA?=
 =?us-ascii?Q?Sm3KVmZi8zMIOHvCfTMYXEOowuOB8ByFnkQG7FpUbFYS7LAKe2wNLkcvH7Bc?=
 =?us-ascii?Q?fqmMu48xQtJVskg0m2px4U+EeFNzy71PF/azbsjTVPNZeYJVoE+eNY0Bnffm?=
 =?us-ascii?Q?qy1FgDTZATuxHIjLfoTVTxfo1MvWSBWrQoVkeDRKmuGx0emBKT5ukIAjBR3L?=
 =?us-ascii?Q?HhlJgiSPWvxZtWXpRK+254K6opTPvp+j7NiY0F34Q/sYA98SKTZMQMIb7u0H?=
 =?us-ascii?Q?q89xNPo2yd3uSLegTFHqCpoLX7TwloVUBAuqSXRKKGHICl90UegmSI89ynJ6?=
 =?us-ascii?Q?G2kVgvj5AsftY80i+xzn/Gl8L6/G1yWVXbbs3YK2iMLlZoydgawzI8y2Boxb?=
 =?us-ascii?Q?6UAiLNb/LSwS46b4hpm0ToyDd5WmfrnXXnQsGL+n?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2e5d16-22ec-4407-3351-08dcf1ee5617
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 16:35:13.2157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8gWYWYVGwJKmbz5BLxIhSHQYMOzOrcvnABJ4Mr+uES5se7ZVuSolXuipReWJtKGJ6cqMElihjGuww4bBUMM2vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8831

Add cm4 and related nodes.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- fix nodename by replace _ with -
- change nodename "gpu_reserved" to "memory"
- use tab instead of spaces for indent.
- remove unneccesary status="okay"
---
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 6fb454fdc5b5e..b01413f73d643 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -21,6 +21,20 @@ chosen {
 		stdout-path = &lpuart0;
 	};
 
+	imx8x_cm4: imx8x-cm4 {
+		compatible = "fsl,imx8qxp-cm4";
+		mbox-names = "tx", "rx", "rxdb";
+		mboxes = <&lsio_mu5 0 1
+			  &lsio_mu5 1 1
+			  &lsio_mu5 3 1>;
+		memory-region = <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>,
+				<&vdev1vring0>, <&vdev1vring1>, <&rsc_table>;
+		power-domains = <&pd IMX_SC_R_M4_0_PID0>,
+				<&pd IMX_SC_R_M4_0_MU_1A>;
+		fsl,entry-address = <0x34fe0000>;
+		fsl,resource-id = <IMX_SC_R_M4_0_PID0>;
+	};
+
 	memory@80000000 {
 		device_type = "memory";
 		reg = <0x00000000 0x80000000 0 0x40000000>;
@@ -85,6 +99,48 @@ reg_usb_otg1_vbus: regulator-usbotg1-vbus {
 		enable-active-high;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		vdev0vring0: memory@90000000 {
+			reg = <0 0x90000000 0 0x8000>;
+			no-map;
+		};
+
+		vdev0vring1: memory@90008000 {
+			reg = <0 0x90008000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring0: memory@90010000 {
+			reg = <0 0x90010000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring1: memory@90018000 {
+			reg = <0 0x90018000 0 0x8000>;
+			no-map;
+		};
+
+		rsc_table: memory@900ff000 {
+			reg = <0 0x900ff000 0 0x1000>;
+			no-map;
+		};
+
+		vdevbuffer: memory@90400000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x90400000 0 0x100000>;
+			no-map;
+		};
+
+		gpu_reserved: memory@880000000 {
+			no-map;
+			reg = <0x8 0x80000000 0 0x10000000>;
+		};
+	};
+
 	sound-bt-sco {
 		compatible = "simple-audio-card";
 		simple-audio-card,bitclock-inversion;
@@ -405,6 +461,10 @@ &lpuart3 {
 	status = "okay";
 };
 
+&lsio_mu5 {
+	status = "okay";
+};
+
 &mu_m0 {
 	status = "okay";
 };
-- 
2.34.1


