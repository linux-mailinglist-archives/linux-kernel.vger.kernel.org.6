Return-Path: <linux-kernel+bounces-336656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4695A983D9E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA9B9B20817
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 07:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E134A12CD89;
	Tue, 24 Sep 2024 07:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KY6tvBhc"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC35A84A3E;
	Tue, 24 Sep 2024 07:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727161952; cv=fail; b=AwpP8lZAPmGtyHEid/1vGZJEkLqQNs8Ew1P6zSZUc3lyGZZGtowCob3EDDW3VqSKVTE8WfoQZKrI8paOqB0b82fNIYAvQWhM4Ss9ng8cn5P+zR1uLkBaTBtdUpvKDLwi85BFXWB1gS0CAJnwh6QbE3PSojm6M3p9OX7NPsjDBos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727161952; c=relaxed/simple;
	bh=ApGnNLN5DAyc7XoDO5OUmoWiwaeKYOoa34b1Lsv9JY4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ViRUfP3GH2ZhJ/IcBY8rJA2u8bZ/wdP2/EEO3btvyhAh7/FzoQ8v5q6jGsr9BYuFYSQCLgpHj8ryowUKTYFUfUF1GGdWmlFnQXBHq6QtrklgLOK/9pwj5mlEdYb3ymbILInASVH8e2qrOw9VRmqtZ/SeK7lxYKju53M0qyvdofo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KY6tvBhc; arc=fail smtp.client-ip=40.107.20.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eCQRF1ZR78+Zl1ck88fuZ4JleDORa9medpxFgjFfIKX6t+ZYF+UGp2r3EgVIgIK3fNaTyG3nDE+TaJKiC3KM3nIoo07ZDvbPaGLspiCS1UdL7M7nuOjXHHe3HF6ppupwE1WrIrkBjO3CowP8z+eR6OQPMesQO5xA28kRESKdhonSfUxLOkVZPwp8ZVGZPAbcVUF6oRmc++Lm5+OmRGJJIpdenj36FSru3chpRISN4tbQm4OR1l4yR99WKRkSJYbOijLvkQO1DVGlFRjdGJQ7/TIdAvb6r86XtxXSAlUHwOOwIv+0B/epSPSzcWbRQDHKIne+JSIpu1KzrvtXDsZi3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2R3VlQi9iJ7fUELq3tcVsEWBeLodD7ipIjX5AmeQcM=;
 b=zJo9c756MxpYGJzV1OdJUFgi9zGVSdXns/t9MAFkXzPlRpERfJwtfdpktTphQwhCqathf0PDZgXcqb/8HNax09loVs9uHJhLFn9uXesueimYwuk/JelpYwrs1CNH0zrNJm2X3lDtthl0YqwZyyxTwWQIVT7ldyeh1tJYrW8Ri6eMmVQ7q/S/EEisuOlaVv2KvyRAZFxSvGaMGLMyYWCHRl/6HL3e2BEyHNZMVc2I1PwdpwgASvSj8r7yE8iUiRDJaZpTwk5Tkso13LSIptgZwSZKt3Rz7mLjTWrufQZBlRJls09yvQW8fpc/L9btNUAO5qUg9DRaQM5yjerW7oUlwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2R3VlQi9iJ7fUELq3tcVsEWBeLodD7ipIjX5AmeQcM=;
 b=KY6tvBhczxNsPhsZ98hfgzahuuxkn5qBHN5W5KfZ1YdXMs1Vse5O3M2thB/2TioTkL6eEtQMqfAtvSTj+lSKkUHAM3cKD8hezjdvKxpvqzOvznPPHN1i3hdrgwBOye+7+rQxQCTXJmr3nDF5L5etLQOeHirpyh3BVMM1wOISWQKI/jhqCeO1K7jlS033faIsCqQrSnwVGpEEX1cWCjOuA98nsVuWlS36zJOxC+QR7KxVEU+bhD2LWfCXb8GBgUZHpVULEdr5ljP1opPDiIT5iiyyAhz8smsIXCXsPewFQWDQL1Z5txLkOOxkgNhvEOpBwgPavNOk++gcsiwAFHzR3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AM0PR04MB6867.eurprd04.prod.outlook.com (2603:10a6:208:182::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 07:12:23 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90%4]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 07:12:23 +0000
From: Liu Ying <victor.liu@nxp.com>
To: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Subject: [PATCH] arm64: dts: imx8mp-skov-revb-mi1010ait-1cp1: Assign "media_isp" clock rate
Date: Tue, 24 Sep 2024 15:12:18 +0800
Message-Id: <20240924071218.3578402-1-victor.liu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0189.apcprd06.prod.outlook.com (2603:1096:4:1::21)
 To AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|AM0PR04MB6867:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e2fdcc1-e951-4abb-a36c-08dcdc683c8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yCTWqKOTiRKkt7SJ3l6KVz6IOFHL3BEGITDOmA5HCH15zyJq2d9OiS/E+g41?=
 =?us-ascii?Q?rqiLtYoVdK8OyFb1XohbucaUqdw2ELpCeUetqCTggbCL4kzmDpB1rJOVMLem?=
 =?us-ascii?Q?t8dcPeo98LQ1hfqsOVpjKwxee5Umj5Eo1iCpE4BV98+JfG0bzINiB4dUYbKj?=
 =?us-ascii?Q?i+a2JRUDPOzCVYU2MQKYGgKuIdIYWh01nohHKh+l+u5CZg2sNHvzfWAkM71Q?=
 =?us-ascii?Q?BSURwFcRGWFnrfUJ5gFllglYwZhe3+vqZLBkpxYSP7cBGDInh3cY53b9gxYu?=
 =?us-ascii?Q?Xm/GyAr05S1zt2+ovdVlf0slF3a6O+Z4EtD6eX4kbMnumm1c+2d3QSLBueDS?=
 =?us-ascii?Q?AjchQuCQjhxEYZ9bV9GwyiqCWp4R0YMb8qgHvV12LkBT9ilda0cBLLpKTIoU?=
 =?us-ascii?Q?zEmOUnuX6UUH5pd2OYA6AdXhBxru8d0nJ9iNlAbKgFYtybs9beNATOw5SNci?=
 =?us-ascii?Q?QB1R+TQ89oPx1Otydh1LFwGprDBwCw+GqgS9OpsfmPu45K/ORFVs0GW6RJEj?=
 =?us-ascii?Q?ikvkNqo8xVLkM97xNbWCOWgFrs8IMkggS3208O5o05lxQ0pATGM9n5qvvP1r?=
 =?us-ascii?Q?UWP3q7Eys9RGziij/+35iCXTdmOcgOzHp7WAFg2uN/nQip3FasjltQ4/GLzb?=
 =?us-ascii?Q?tCjSc3HoSLHLBYCufe1ymgtfGpx3FXuz3iROObOseruzm0s2rZaXlyqRnAHp?=
 =?us-ascii?Q?dodlYe+Tw0EADdwNbQ/sjmc1YUI4VwumNKwbhfZFGjOZTs1iOpTNo1opP34S?=
 =?us-ascii?Q?gcgr2Uxv2EnYUvB8Tu6QzeEdVHcKKYZcnXmwBv6sWPrWHmfMUVPyVpnrodPB?=
 =?us-ascii?Q?sxs3FDZupWaPSbBDM4YFmBJqm4S1e0n8fjd4QLINU//gNegAaNE2ZiyhVRDI?=
 =?us-ascii?Q?ljeq35QhHiC8hG6uO2arR+eAy0gygaSdPxrTQTm6thxtjKfWsJBeswJ22Q+J?=
 =?us-ascii?Q?EQXHWEA1tuXnO0xb16IrXtEDl6kV65oR8CT8AIgI/fXEHITIIrB8S4/dfIVq?=
 =?us-ascii?Q?207AKqXA015SXPD9ZsdF9H467OwODpCplRYphk0iQw6j74NlmNVQXvgFytRV?=
 =?us-ascii?Q?F9TdQ6kMuhUxLwT+70Ni5mITbPrggH4JAL+XW7rW7TOG4TnrX/d3RDIhMbMa?=
 =?us-ascii?Q?MjL3Xu7llVecClETEgP151MD1ZRwZMT4ncwYViIGGunhBaQ/Ff/SQ+h/AFFC?=
 =?us-ascii?Q?Qt1tRAo3ZtyWUF2k4Cy2heaY2UWZNABzlSQl0oPGBkbxZqBiAPrEN1f2hZk0?=
 =?us-ascii?Q?P4CGTGhKy3mtt5ZBB2kvKAzN9b9VQnNzmbU2QiJRMzXAkBiHClnCctYtCpiF?=
 =?us-ascii?Q?/ZOc39ORHr5o+mvFP4BtwCMkekl72bUw5ud0Wtx9wzUhzQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oqTKpAq71MthenRsljUhy8VzeWjFBcM7Zza9Fw2cX+i8MWyLHZIwoWm2Siej?=
 =?us-ascii?Q?LPNuTkl878EIIfjLzl2tvSXqbHeOJ2Gm7oZQJ39I+hqdtFqhBaRLOvOf0eHL?=
 =?us-ascii?Q?4qXjnE0U1HtjcRz8O/HP8adm0guqtzsw+oNW1329J7Jf5Fa6i0ZPa5x/RgK9?=
 =?us-ascii?Q?Oeay5gch+GEuOjrA01HIKXIiB5quBbZxeVn60cSEhqkC7P6vGs8uT94NldjN?=
 =?us-ascii?Q?d0A9ElUjj7MDv3ZlSDL7Jdo2D4eYEkVvPItMNljb0qPxf8T5BLbmLlzj0CtJ?=
 =?us-ascii?Q?hr7/ZBqQZTl/jhw003v+fyfsUJ9HF68yLyEOLeWD46ZkeWaeG9w3gaqiWIB5?=
 =?us-ascii?Q?AdV73e8RdULf4IVAz+m/hmJsNCs1ce1n4wz22S5ACTqQC87p2XMEfIKj6xgM?=
 =?us-ascii?Q?XwSrWAvPAffOfO2f0tULKMjCBT1jRFM32h9il9ABZ97R6o4zUo8yZly5405k?=
 =?us-ascii?Q?Xv5FgGDzVdmdwwlCNDGwR9RHu9jx7iBx2enfqb9HQUDn8GbZmZ6cIfZ/HoBC?=
 =?us-ascii?Q?bU5Bn5wvidyJx4aQjqAFX32/lC6KRbWQZ5K9ZwUt1XZmCZ2NPnsEjAVA7jCo?=
 =?us-ascii?Q?tItl93So7yDwWayq5ddnYlFFmHW8Rb7SsAWwvyebX935ffrxuz7D4ETwHos+?=
 =?us-ascii?Q?yd/jxcOoShVvYnNfkEOxQ+7z+C8vmJ300n5ewfsstOiWUkGoc9DS6gSExLaP?=
 =?us-ascii?Q?tGNcsIjvVDeOnDAiUeLT5xjRjgVSAghn12O5/a4rntS3LWjG4lvEV8DX8sEi?=
 =?us-ascii?Q?P3nOjfrI7PNwTcMW2i39jIEp1nbTekw4h3RX4fFXgg2EWAuS48khb4vnWDTn?=
 =?us-ascii?Q?Vj5hLgRYRZM7/yEEKm5tZB6O75huyBug5en/mYZFDoU52SxXxRz5+ol9KLtU?=
 =?us-ascii?Q?ZAXFs6iJ4v94DyNa7Xb7dUWY/CiG/GZL3sRqvpuL2FyvSZp2ShFYg/6pLo3/?=
 =?us-ascii?Q?5EhifQqErZzGvp73rUIETuzYEuqjaTs3Eal5Wj/Dj3JXjk2j7qaSb4gC+uL+?=
 =?us-ascii?Q?P2Y9MN42UpYGt/eY7zw5w1ZvEk7vwcIfJRjAs4GoXXa49v2pHoqlVr3RsNJT?=
 =?us-ascii?Q?dffwm3F6iGoZ6tys+2JAE3UKWn8+8g+TiYYZIzlL0ucP1ythqbbrXlXtZhwB?=
 =?us-ascii?Q?tOqkiQwnj/PR3CzdeOKbYW5/EfXsMWCd+1KeJ0fhjcszw2lIPq1CcfetwXt1?=
 =?us-ascii?Q?9IcXu1cjFSunUWFBubkp3vIjSjoNkYZ74VWIzfO9Da5skxbLFQbkVuhRWdvl?=
 =?us-ascii?Q?94pUfe8C6wHrV1A+LSvJDwaExVpSian7oXyu7/U1tBbgvuFjF4ut9ZIYY24t?=
 =?us-ascii?Q?AYdwSXlVy5GOC8RaVqCM0sNM2DW7fvg8HwBzMW+LIsdnILdIvGAxzid1E6Mn?=
 =?us-ascii?Q?KyMSAvWAkPZxA4ih+oOP7CulATm3KN0lKE/3peQj8j5Am1gS7LrqWR00CJJf?=
 =?us-ascii?Q?9hZHZfK/UPkuYN0zB/PHrrLKu+cLXQydTP4RZE9zuprlIOOWpOGnw3lOCG4E?=
 =?us-ascii?Q?y3+naNKjlOzdI4Z2aCDiuQM5GwWim9MQnMRKsMuSyUbxbwT7evvSLpdI2xkn?=
 =?us-ascii?Q?WFkH/L1+IR5J1zazakQrFEV/3Ir4RODZ3byj9AUE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e2fdcc1-e951-4abb-a36c-08dcdc683c8e
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 07:12:23.2400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 14fPzPjb4l0sYkEX1ppJBczPpJTBo2JHVm02xWPDKUe0DU0AlUfSrihlQnqeSiB3Jl1MCMNNoo7dFWtCAKv7Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6867

Commit 2d39b78e5716 ("arm64: dts: imx8mp: Add DT nodes for the two ISPs")
added a new phandle to the "assigned-clocks" property of media_blk_ctrl
node just before the phandle for "video_pll1" clock in i.MX8MP SoC device
tree so that "media_isp" clock rate is assigned to 500MHz by default.
However, it missed updating this relevant board device tree where the
relevant "assigned-clock-rates" property is changed to set a new rate
for "video_pll1" clock.  This causes the "media_isp" clock rate being
wrongly set to the "video_pll1" clock rate and the "video_pll1" clock
rate being untouched.  Fix this by assigning "media_isp" clock rate
explicitly to 500MHz in this board device tree.

Fixes: 2d39b78e5716 ("arm64: dts: imx8mp: Add DT nodes for the two ISPs")
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
 .../arm64/boot/dts/freescale/imx8mp-skov-revb-mi1010ait-1cp1.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-skov-revb-mi1010ait-1cp1.dts b/arch/arm64/boot/dts/freescale/imx8mp-skov-revb-mi1010ait-1cp1.dts
index 3c2efdc59bfa..30962922b361 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-skov-revb-mi1010ait-1cp1.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-skov-revb-mi1010ait-1cp1.dts
@@ -71,6 +71,7 @@ &media_blk_ctrl {
 	assigned-clock-rates = <500000000>, <200000000>, <0>,
 		/* IMX8MP_CLK_MEDIA_DISP2_PIX = pixelclk of lvds panel */
 		<68900000>,
+		<500000000>,
 		/* IMX8MP_VIDEO_PLL1 = IMX8MP_CLK_MEDIA_LDB * 2 */
 		<964600000>;
 };
-- 
2.34.1


