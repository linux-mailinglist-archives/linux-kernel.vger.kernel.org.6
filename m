Return-Path: <linux-kernel+bounces-371081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 708929A3608
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7CA21F25633
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 06:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C6E2905;
	Fri, 18 Oct 2024 06:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Yals7A6q"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2048.outbound.protection.outlook.com [40.107.249.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B83417B506;
	Fri, 18 Oct 2024 06:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729234105; cv=fail; b=GscOPdTVlJKf6NjfRCaa2NXGppBbCVbpBC24ESp/yOSvZoCNzclT9MGN4Un0vF9gu3QpEvJKXNKzu+FOHo4g8nXBqQNgqQylF8PJk2VMbX5s20l+7UtL++Sn4YLD+O70VqE9Vsf4qLw68Y/PMdm3lt8s6wTTN3CPSGu91GpQgQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729234105; c=relaxed/simple;
	bh=je5M/qFybER1RZ6YRcuxJmpD5RAmeDtDTU45nOkiHsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m80f+MXfxjZGG5vblw1fhRyYX/bg1E4rs9CppbywMAZcD1y72D6eG9oV1BZ5pZVJUuEuxRQNZumi0Dc1+9DCvv281UeCG+bK+IW6Rh3OQB0VcxDRHNduod8DpWafB39UpKWDF/VhRVH+jHO5GyrCSdaPgwnZQ6nQwh22owhljSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Yals7A6q; arc=fail smtp.client-ip=40.107.249.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jm/cP8OlLeszRDKGkISguUHN70/QwZUwxNLJ+ykXHwmybWV3LAR2nAU70slCmX/EyMgyeQPrJ3cEETKhJhmR5fyKupKOGXe/pfd3GHkxjbiV7oUb6VRSNulNMGOLDYn1q2e64GVYi15qAmi/lRq3wcWcCGaecepRFeeKchUUZs9mFo4h5sGeNjZX1iKTfHzfCvlCfEdtgHL761iCPZomO4OwzKmsrYvkuy11/YxrPIeWOkzR8igrSPrje1xDbdQc9fOE2D1dBvV22dLHuKkbmP3TrZTqHEj6V9CqHOEIOP2BidcqLm9tqGY4nBmnzAUmBVbjwbwJhGn0tDnfuqv/Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bpbtb0VMf5WoGkQelwI9N+g0tNZACnnCkXDW8hyGLPI=;
 b=RRTkh3jvD7B1BK1UYaX7w6ZFvnzYHQB0AB2FP8/WzWQlJOMrrnlF1vb99B781s6a4eUK8jJG4zOMZNauLcsBOiWv+yn5JepC9b80kO9ZtN8yQdvy6wAs8TTmqGGPQv5BS4uy8yT9+g5Jr8EhavztP90JPUI0EPygFOV9e5WhTnLYcfIfAkZWy1X+L3PYFm2BCvyCvFJN++sRIrU6ZmvMod2t4pdZ5Z9Ii1wfIk0oUEsGlv9YvJayPYRnX3aA4XPjIj/md729iXS8jD3aUxGF8jtsF+YdjBbwbra4TgnSyt3SskpwEH8cNuC4r7Xnsc3vKUFLPCP68c+6DEGS80aBmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bpbtb0VMf5WoGkQelwI9N+g0tNZACnnCkXDW8hyGLPI=;
 b=Yals7A6qUoVsXR/Y7C3XDXXS1SOvt+EwGPKtSpf5xMutJYVYD54uQzGEm2k7V4rjb8GkWK4j04M7wD1Mq497QJNU5v/pq6rv4FsyIqBTQImSCiwbvpCKTN632kpVDjCLjD0ute0krf/0A3UlH9NAbgKbjfmz7pO3SOUuZjlGwES1Tm0N9G177RVjXOIYOcGaavp3Yrn3T1cOUpJn5E9jh4kUNw8BEgvg0mR3a6IRUrKd5N9CxsNHQVDkw4HRftuiPwBbPxPpZHRgzgI5ijHeY9+eIvh1kbeeb+yA1XFzehz6/NcZjiMC4QiTr0w87/Dc9nixmNJQPSzZSAxlfzLaLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by VI1PR04MB9787.eurprd04.prod.outlook.com (2603:10a6:800:1d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 06:48:20 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90%4]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 06:48:20 +0000
From: Liu Ying <victor.liu@nxp.com>
To: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	marex@denx.de,
	stefan@agner.ch,
	dmitry.baryshkov@linaro.org
Subject: [PATCH 3/5] arm64: dts: imx8mp-msc-sm2s-ep1: Add HDMI connector
Date: Fri, 18 Oct 2024 14:48:11 +0800
Message-Id: <20241018064813.2750016-4-victor.liu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018064813.2750016-1-victor.liu@nxp.com>
References: <20241018064813.2750016-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0204.apcprd04.prod.outlook.com
 (2603:1096:4:187::16) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|VI1PR04MB9787:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c37aa7e-1595-40b3-6320-08dcef40da71
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?DC+hjYyypfc8mn8WUcZ3YZ5H9A5uUTn5P0bK9dunaBFkaAWMogllYAUC305Y?=
 =?us-ascii?Q?xdV7eF+MG9DayCtdFtYDIMxv1Dh8kfO4qtF9R4Vw372yVPLk9cK6Iz6jIptT?=
 =?us-ascii?Q?RbcmWo/B7qHrCzKzKUGnMDxs6SNs8uF54Mw0HRXKrdS6LmbBHv82SpiU1OwY?=
 =?us-ascii?Q?q0B8vH+/Xl9hEsZ4T19cbZsOFx43yPOriH7EfBAZ2srpJevCkzd08Ilw/peZ?=
 =?us-ascii?Q?2vgVMXUocP4B+Ok6xgJBUgJNvksr0l/KgtghtBraAahDFGkxY5R+3nrARdH4?=
 =?us-ascii?Q?jXwsdF/ug1GJki93+0G5vMCWGNd+T44ziC3/cbo+9cJuB8/hKuQm9x8XLOYe?=
 =?us-ascii?Q?6luiYKSxSr9WtQcpqON2ltIKWOhhm4gyKmU4gzzM+WynADxN0fuamTQiMIEF?=
 =?us-ascii?Q?VxW/JsSr3wM/x+DBykPL5LU01x28WZWKMPlzufpAK1bIjyhSsgU1uCCryNj2?=
 =?us-ascii?Q?7pQK9Va8BNXVMZiyyt4Ud2/KeDijrREsFby+FfzlKNZ9cHsKVaBMNqAScX5A?=
 =?us-ascii?Q?+zAZV7yPW///WNrCKg36DXxxRhbO7yDrbA9NPY8EuofMFjdkjkgsyRumgG2N?=
 =?us-ascii?Q?EPM5Lp1SVoZKBT2BVIBRTNp5RuSJc/6LY5gfQ6ZgCrNJ0QsC4B709STPgEMO?=
 =?us-ascii?Q?uXz/KBQL5WXhsCSx8hp7m3QYQkw+eR0Oz9G0AF1MytybhLRdmnWzLSRQKpVr?=
 =?us-ascii?Q?AmyS9js9q7PoKlw88CH0KqEfeHSwah/1zOsUOY6huAZAeA2avtKzN/BEXnCF?=
 =?us-ascii?Q?OOwnyL4ICAf9TQkmF6QdkaIQ5ACaUmfn20QFnYdKIAO3EwvLo4H/0J5+GYl5?=
 =?us-ascii?Q?dOk6yF+AfGKW1VC5pizTqNlhwFtWPA12rHy+wb91/zhHDKIpH/C7L5W1aBmk?=
 =?us-ascii?Q?eGBlXNx0GX5ZIV/KvPRqYHiLe1NR9VpoW2UekB/2Wryl9QsViwIPHL2G5OaC?=
 =?us-ascii?Q?gvjkV/7Ik+2jRn9sQTnDBNxjLPEfAMt+moXBskVGlar6E2XuEbBr3lhI5mDX?=
 =?us-ascii?Q?3GA70lSBZ3vOBy8JVfCgelwLnJKe3zt+y/0Pp3hAGX9GViCMz5iGSIPT0hGm?=
 =?us-ascii?Q?s0zFisYDuT+2oMQQ6gk5xrGlTY7R0t4Icm4IElxlBBXFSi3y29l3m8lB7/+u?=
 =?us-ascii?Q?MZdn3b4avs8emV+W2SRVbFQFff4PiM6dupaxxr9iX+bCkbiLHHZmze/rI8m2?=
 =?us-ascii?Q?QtVlCxp5R+O/WpgbK8TaN1/M6Ye8UZAlJct8j5e8SjNXuKVb4L7kQkSNn/ka?=
 =?us-ascii?Q?mwz22Y4USPg8AzCh5DxxMb3MMbMzgpwc3uZv0Vx6hE5DmYpMRyMWP8k/jqYI?=
 =?us-ascii?Q?r/qWwIOIwUtypDAoMWpgAnfLPCm8wj6AHInvdlpN0KEgao2Rpg5Adtp5NHmF?=
 =?us-ascii?Q?3cABqWk=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?DSTLyklTSlIqss9l9yLqA7bUy8mYaOb7MOtsJQjPBBus3dRrbDxoP2IfZNKB?=
 =?us-ascii?Q?5CWP+j9thGQF9nJF7sMFCbAfk3/lOpAosQSsxR9y3mArYsVSxVTxPvln3h3M?=
 =?us-ascii?Q?rlsk/XXixsdH9EXmzdYopYys8Cc/IrwzOnva66I1Re8dj3ophH7YizlmB6PT?=
 =?us-ascii?Q?Lr2DHheSHbU9i179vngFs2xCed6fSxEP00v1YeIqtzeEtuMzk0LpdQp2lZIO?=
 =?us-ascii?Q?llj9GTNoh5Br7cOFC24So3eWPellpQlZdFGSUttgBWI64NbO+rQvPrSd598y?=
 =?us-ascii?Q?RAryfFzoa2ug6pVJ7Y+A/ELAg04IUP1Be/9M2/TBUqE7fQzY22eAjo/6t4Zm?=
 =?us-ascii?Q?+7Iewqe3CKjddnMZvnI47rMz1hF63gnAjZCizatRZiGNKd9aQuVnioMw810+?=
 =?us-ascii?Q?BqMmknjF7UdgSYx1dMmXw/+9DxHC/Y/QoMhJhnU2dWzoZfcbka140i49G6BI?=
 =?us-ascii?Q?Q/keISn5pJUGL44OTvVyMzzkdWPvYHF8NJkxWtS9JkqsFnreWbCU60eclPZL?=
 =?us-ascii?Q?w2MxOUtb1AZnTfMUdGLSZ5c3vDJGCjL1ZzibsFmj/T3TqCq7gwFGVTxgN+he?=
 =?us-ascii?Q?UoyRhVkdderPGk0vU/CQSh1dxL44HdgNoqRluTkCQxQVl1vKP+B7lGCVyojs?=
 =?us-ascii?Q?9UDAyoBYuAAxCyhKDfb0w+kjl399S6HXuMt+djqqQZkytF5GQ6gQMPjShNdf?=
 =?us-ascii?Q?vsfpswsfdnyYq/qLOCytiiv0LTg7yHYixk88Nhy2zEwnjVsOcnO0yx2QQSR2?=
 =?us-ascii?Q?2A+3ohKYFWbP79X9LZ3PiaIk48XMRP04K2lThwi4TfRQogbCIJG85PH5hoLX?=
 =?us-ascii?Q?6Oo61ZrnGock1DKAP30A81Nc4WbkZpTX97Cv8gtG33vZmWTTUKcO0WNczwSK?=
 =?us-ascii?Q?LAwaLRrI1Jr7pZuKTDL80o3vDsDN9eB5bFSoiVk3C0Qo4FLCpXmnF9wD4g8w?=
 =?us-ascii?Q?qR/Osn1EuCb/XMS9/2hOmOCcA2e+vFnFTsJdD2o9qBtbEAGDmhvD4xwf63Jc?=
 =?us-ascii?Q?EBNi2ayc4Ctl0wmoIbsY+Loxp6fl9Y7WUH6naA147kX83gjnpawM3wfUNoef?=
 =?us-ascii?Q?4qc0eseaV1MnbfXpegH6Q4FT+A1Zpc6sgIhyINnaNfbyA1lQJS0UgD7nkfcr?=
 =?us-ascii?Q?HoG2lKQHq7g/gyQjSRa2G+UIg9lqr7rk5S3jHXuotCu8RySdSPw6OVlTBJ9a?=
 =?us-ascii?Q?U6+Q9smEUXJzvFthYLfThcJyOFx3oamaRsTBY8WxVzkQ/uwU56vX3mh9aIOl?=
 =?us-ascii?Q?Z15905EsrX1FbD03isr76Gu9vt8CLWP03emUsEarK0dVVuK1ti6GXimGlb8Y?=
 =?us-ascii?Q?dZXaHJwNt7GGYD27jksIjLTZehTyGVxK5j2Eh9LlMakLwyyHv31Boo2l1uw/?=
 =?us-ascii?Q?wpVy92+wO9sF2Tu9rBkbUmZJeGZCagUgVkOHhqNwfXL/PrsCWfBWHkVkVoMy?=
 =?us-ascii?Q?vpkT23eOviqA/nTrt6vD4ARIKz7KaMtcA8KNjJTdefekYUZaEtlW7NToVydX?=
 =?us-ascii?Q?lJKXinTeKOsEDPCQ1C1B5ntYW3m88RUVC+z+pkU+upnFgeoMLksCdfpenXDi?=
 =?us-ascii?Q?byXEOReTgQTelvVvZ4usiaglrbwvLEtX6jQZMqp0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c37aa7e-1595-40b3-6320-08dcef40da71
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 06:48:20.3437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d0hwBtbOFm/rkGMtLORMyc3yqUpUPIH06ZGnok9LAi+otznTTeH+ece35yLTqmJCnfey0xeOVaKAeUQeb+zCkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9787

Add a HDMI connector to connect with i.MX8MP HDMI TX output.
This is a preparation for making the i.MX8MP LCDIF driver use
drm_bridge_connector which requires the DRM_BRIDGE_ATTACH_NO_CONNECTOR
flag.  With that flag, the DW HDMI bridge core driver would
try to attach the next bridge which is the HDMI connector.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
 .../dts/freescale/imx8mp-msc-sm2s-ep1.dts     | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
index 83194ea7cb81..b776646a258a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
@@ -15,6 +15,17 @@ / {
 		     "avnet,sm2s-imx8mp-14N0600E", "avnet,sm2s-imx8mp",
 		     "fsl,imx8mp";
 
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_in: endpoint {
+				remote-endpoint = <&hdmi_tx_out>;
+			};
+		};
+	};
+
 	reg_vcc_3v3_audio: 3v3-audio-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "VCC_3V3_AUD";
@@ -54,6 +65,14 @@ &hdmi_tx {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hdmi>;
 	status = "okay";
+
+	ports {
+		port@1 {
+			hdmi_tx_out: endpoint {
+				remote-endpoint = <&hdmi_in>;
+			};
+		};
+	};
 };
 
 &hdmi_tx_phy {
-- 
2.34.1


