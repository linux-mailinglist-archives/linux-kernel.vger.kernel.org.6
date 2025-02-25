Return-Path: <linux-kernel+bounces-532301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD048A44B31
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29E577A370D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D221ACEBB;
	Tue, 25 Feb 2025 19:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PvI0603M"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011056.outbound.protection.outlook.com [52.101.70.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9673E1917F1;
	Tue, 25 Feb 2025 19:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740511340; cv=fail; b=cv4tkG01LmBNqA4a8odfuKdQpHiUfG3uplkD4Y15VuGIFkRnAiFSQGIMTQIHmz83wfx8k6yZlJhErTl9P7GikH2eqVoAsDra6DqB7TieHo7eeIq5XBxm/HyoBz22lmpu5UTaevu0GYOvA5Hqc7byAuYCDi6QYFYTbHa6pr5LT6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740511340; c=relaxed/simple;
	bh=Jr7ITdLqrtABgbrnB5OmMoVyhADnvgQNMRTnRLBUuGc=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ciQBOk+oaIho6p2qSeUuj7uz2CaV8r9W/xkE3PuRXRDY3zeK0N5qUx6rvub9fRAeuouki47aWEdPE5qlDu+vaI00BTbYekBmhE6VTnglbuw463SZe14m+4Rrg3242M5Fh0IOldyigjricqYaNuY/QYNOnS4gdxMcBToKH74ulhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PvI0603M; arc=fail smtp.client-ip=52.101.70.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=if0YrLyn8f6gNbF0oTbO6xeSbwaqUnojQRQE9aQezMUSOeeqADR8ZIWS9ZgehRsDG7rBRqIzbL0hBLUirF9WBsWi6IzLbLG0fs2DTWcNVDdJ9ZtWHp9AT3mCkGt90QSjiTtcW1vrRMuZDw90t1w3o0ggbKadrJMimVW+ptSM1wXatj7wfi7Nyul2JpNpcxNMRAl301BI5d+wbTemhQ58ji+kMlaoIddNmqMgLQUv1kfV3eK5NYoLXFBiczp4mkuXiyRUYIWITYPihUMGE2hy4KzZCdRmPYQDTDJQ7YSm58orq3DSCwGc7xxy1z9co6D6hiISALQ3huRekXrWOXgKmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBWUrDOnwmMbzir+8K4+VgBC5GXBX0hjXcGqY3fD/5Q=;
 b=tINz1MU14LoDSWekvB1gmUXsGkYEphxUm3mqPoEeqMdeIDqnp7TaPWF1Q3qHLft1QrpMryn+Rwo+K5U4ZqfnRZp+PIQI4+lglEV2Fb4Cdh26U5qG26g3pBnQFzsFWdHc2ho8CDB19loRo9uAXQi36Il6gK4+gyPiw0AEljsvCp+PgSyfcsBzUvNQykk/z/hJvmcfLBEkx+E1EZIMtE/rrETz2rggXT0Ti91U1X1Y3ZhQ8Yqw4mhciiXP3Izcjl5o3MD3FGqPogXQCrU51Jlpw3Zol2HD515SUA+kJycG9dO4icfWWJyeI4HrDfGyniWME80We9+U9egTs6N3pEPXYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBWUrDOnwmMbzir+8K4+VgBC5GXBX0hjXcGqY3fD/5Q=;
 b=PvI0603MRPnUZxFZeNUJPob01CCDyiXaFkr9dbKr2POvs9WlqAKNAdo4d5q1DydzTDwd9wnTMfP8Mmy2OCe00rL33vchBhW8E5FpjALaWNCMSLfCmVuTOWO6OlFafmq/SvflcdqTC1QfhH0mrVNwsxjp4RUxbqAzlZBPgRxHcZkSLbPwtUlCHrkY5H3GUecsTxdjhyx8Dw7nJITzYnJed78YzBv1FcdWbfPVvXdAM9xm8yfaQPbJsbskQoRBt/340mDSlP4IPFVz6VnC6uk4mJxFSS3Un98zsjo9eYbcxQzhBcyIZ+NLIum5qBsjz2F0UEAXzZGwkZXPTT3Y3J43TA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8617.eurprd04.prod.outlook.com (2603:10a6:20b:438::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 19:22:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 19:22:14 +0000
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
Subject: [PATCH resend v3 1/1] arm64: dts: imx93: add ddr edac support
Date: Tue, 25 Feb 2025 14:21:58 -0500
Message-Id: <20250225192159.2907320-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0015.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8617:EE_
X-MS-Office365-Filtering-Correlation-Id: 600fad6c-121e-43f3-58e2-08dd55d1b5f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ji9OaOSC1eJNZNgi4RGmq8Pt44r0ZUeaFipYXMK7huhY65DS/p0qj+0ZAtLL?=
 =?us-ascii?Q?d1APJs7oNiCRIvAiwL13ZklQP2f7XaSSOwdclyZ2v8FmllwX/wMqqu7VA4Gq?=
 =?us-ascii?Q?8bKY52JPhjpRjRi0VhFOhuMFC3bvWRWbAonyVh+S/y5VSIC9YNei0EcNTeH0?=
 =?us-ascii?Q?fUkHTwGAPmf5HOPqkpW2dmnI3/2M7kiKF06qtOy7/Z66Yjv5m7YIfJLWyimo?=
 =?us-ascii?Q?lIJFGl+ApwP3P7lRtNirDqvO3mBKE1NXyrP98kpEzc+5YNDte5u+b61lSdI9?=
 =?us-ascii?Q?HCKzM8n+SmRC3THxNJT49rxvrB3NMA7Jgy9csEimS2eImcQDeW8pUzCYDIH4?=
 =?us-ascii?Q?ZAqrvFW7N/d+6F1n/IzuwKA2QrBluBZXnicizzxJHHM1U8ajWxIhm9NdovKr?=
 =?us-ascii?Q?55ZOByRo+bntaB8tahBfuEkpsnWrwem2DSoiO8gbd4nqybF0EhplGaAXOkYb?=
 =?us-ascii?Q?VVUJ2hym7DJ0LQq9RrsjXwrx8GqAzMS3+L0IkyAixvLstkLJtbmKTaFOxeyD?=
 =?us-ascii?Q?FSYq3r1BSvgEGuwlUIGrs6WiaWxSoh10F1KsQGnsB3gt9SwevZ359/A8aQKb?=
 =?us-ascii?Q?Sa/wi6a4cCBTyhSugJZwfTkpg/DRuRnfEOI//zE97VR4cTuLukcaRpcrSpDN?=
 =?us-ascii?Q?fa29UTdoAN2qh1W57ljYWt3QQkagjNSr+6KlDns5r9rU670Y7HylWj0ahVRf?=
 =?us-ascii?Q?puQ7MfCn27dmUnRT3dI70/mgkMzgpYitqJa7sc+EasOkNb1er91oIxtxYDim?=
 =?us-ascii?Q?IEPlFGGgGcyXi2Li+aXWltCniRQHXuVjDI4c0Gg1L+w/yzMDL1W+01VvYmA8?=
 =?us-ascii?Q?3np1MmM837lnJE1qjfygCsSYTjswZjcdIn+FqOq8SA7mWfZ1hG890wqv/L3h?=
 =?us-ascii?Q?ZjZps90YqepE4ZZGoo0437J4e+sbmEUa6z09D804lpH4hYB/IoSzxpL+Wlpn?=
 =?us-ascii?Q?ymveuoaIj+s4E6G7izEo6BmozXMOzhzWPTFlIL/XlolMlzM/qyIEUcSpreHu?=
 =?us-ascii?Q?aLowxuxEk63yTRwo746DOiDdW4+/BDZAtJ06pA/9ouVYEa5rEockkJLrEjbb?=
 =?us-ascii?Q?K5FUxjtrBNG33TAMM1bzC3ZKNk0ukVrgdBU1grdPLCn8R2zG+0ySFffGWpN6?=
 =?us-ascii?Q?3TKMJWTLcX6H7EjMU8BQaCfMkoJ7msZtOMQAVV+q8MeHXFloYUWGB6Skkfi6?=
 =?us-ascii?Q?mCTyV1hCKGpj8iUfim+4xHw+Wue0CMYGxjVoVueUsAurpVYk9MWLu7g3mVTc?=
 =?us-ascii?Q?4Wi9SYKR8NmVRuelPcCHIPbv+oEp6JDPSRMktIJTfEFqKNyGZzIhcnOuaa2f?=
 =?us-ascii?Q?EKA2zi28sqsA/gvOGfSsC1V0qKINZqpPya1hZmitxxWxAeUY6Me9d4f8+qxm?=
 =?us-ascii?Q?hzsFTZFya38JQ4btV7xFXNj8c7+JHZhgyvK9UJFCFZ9G7Bbfxb9/YH71pGNN?=
 =?us-ascii?Q?GWEKAI423FC7XKQJNqO4EMSTI4CMne6K/u8ycv9AcIcDh5WIzMHVxw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XG545XQ6z2xVfCVHqKdAxDLBuklljsnuJ5HPQXgZDeTVGyqZcyefigyCvJOA?=
 =?us-ascii?Q?WmxCFoWE9H9tAezNFs/JJLVU+JkSvRPlQ62oWekGkdo7R73OFvTahMK8HOF2?=
 =?us-ascii?Q?nD8UFRB65D3+xKLxpg7EEOXrCJQxAXKZnSkvS/FP3tXHMl1MUJzRbVLmvQLL?=
 =?us-ascii?Q?k/l8dLV7GK+PbeO5bPCmw1JDYkiPVcUuK+YX44naAGvgoQHSsxN9+ERZUnEL?=
 =?us-ascii?Q?C9OzWD9iIjfHp1QhWjtAE1re+Zld5F5jMyx0tuoMPQsPxRdhketrJ1Rsd0l0?=
 =?us-ascii?Q?5vmCG9HczRDsTOGLiAg6f98V+Iwe8XKpmfTkyeorpC82s21AGnKGQeE7D1Xh?=
 =?us-ascii?Q?jtNSiRbFaJoT7DsFj8Y/KNQ0Kcr1xesjVy4dNYQiJ1mIBmbHQ1so2EjErG1S?=
 =?us-ascii?Q?0g+a2mzpSkqoiUoU/8WqkISaj/wP99gr80Q+hskOfFB6l1bSNXCG7K+UDOXU?=
 =?us-ascii?Q?l6PMsuNuakEHd79qtwGh7y8YSlzjgzlYDnEV2XhPnnHGOfjmdzKsnZ2Ogy2x?=
 =?us-ascii?Q?9Yo8/KrFDxIIfHD4CVUkS3sftq5DneDYajDKzZAjcixtidcGJU6/uo/fxy46?=
 =?us-ascii?Q?rINWg3NLVYZB/+4WHk4Q4zc+Pp7zaxeCl2PvRhJYX2+qE49CrkuKFbkbLK0p?=
 =?us-ascii?Q?BZG0u+DGbn2cU6FapmZt8AH5ALtXFyFDAjXoFvCo0ubKFQ1Z52f8xvjKN6YN?=
 =?us-ascii?Q?X6TBFTLQjoo3PNcW7YB/TZuzR89FXTnns7l2S68WezxiKjhayPQZJ7q+XROz?=
 =?us-ascii?Q?XhBj47XgA884chgfKM8Wb6y7FAWERLioe/bbe9zLas0HndK2e4c1z/e1Ui+M?=
 =?us-ascii?Q?K++JQGMCeFyiIOTLWM2gkMZSJ52JHyEUnTb0KgLAy4QYLYU/+bNxWjQzXO4m?=
 =?us-ascii?Q?br71ooIfiusdpTdi2tFf7Ouoc3zHxK6cG2MDTeUVWajd6z2wRlJR148Ptvnf?=
 =?us-ascii?Q?psychKPDwLW6sIdRCBenV3NFxYEqoqz8uzkV5oHhmIqvq6/6+lfSgZyuJt3c?=
 =?us-ascii?Q?L/c65fmhycCDaw+BS265cSHdz6SdyYUMrduIcS9PJEe9adJ4BmyBvXF+NhN6?=
 =?us-ascii?Q?KX8MQakfh1HjKIBNsqUb+Qb6JvnouTdaWSmmVgiQ8/6e0JehXcKbwpdtMvkM?=
 =?us-ascii?Q?Dk3YaJl8//owiLnpr1SGeEjHf7sLRcjxnehc4qNccJQyxHvRPs/HnLjQAP5F?=
 =?us-ascii?Q?n8h5baTcHUFot4pwTvjtp+n03Ah4JK1Q3/UAXcaZVUc21X2i9NezfWnKlW56?=
 =?us-ascii?Q?UfM9Pkv98RFJLrrGItFDyFyJOR8nWrmuqPVBsOKDzw3zNpzcwCY/ash3fTtc?=
 =?us-ascii?Q?OZQw0vtXdL1SBjDctkzLOVmU96GYB214nw3LSMF7lNik8HcVMt7QZlhm/Vrh?=
 =?us-ascii?Q?ZN6DnVlKLP1kNajhNcfEjuzmxLE7Po75tU2QMPpz5AkVz6rza0h8Nk53oBng?=
 =?us-ascii?Q?Z4R4tNQQXtnIN1p+sSBd5u8mIXv/UDZSth9zVvhOEGJiPB4/AnkNxZd/FnGX?=
 =?us-ascii?Q?LzhQJJCUTjk/lonhXcg2LA27ChVv9fs/JpbUFF4vJsrxbtbOoD280X9lpuYs?=
 =?us-ascii?Q?Yx7CR5i7xyJ5skaFYHPKcoUtHzTT/fckBEqwUjtS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 600fad6c-121e-43f3-58e2-08dd55d1b5f6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 19:22:14.9014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XHJ52bkMItW8YvzkWC6/agFkOVmg8xdaiXlhbgySGB9RRtwsJ9fQmkcgr9ijN8kDxijKVLyc3/37uoAHMpNo7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8617

Add ddr edac support for imx93.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v3
- none

Original thread in https://lore.kernel.org/imx/20241016-imx95_edac-v3-0-86ae6fc2756a@nxp.com/
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 56766fdb0b1e5..64cd0776b43d3 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -1334,6 +1334,14 @@ usbmisc2: usbmisc@4c200200 {
 			#index-cells = <1>;
 		};
 
+		memory-controller@4e300000 {
+			compatible = "nxp,imx9-memory-controller";
+			reg = <0x4e300000 0x800>, <0x4e301000 0x1000>;
+			reg-names = "ctrl", "inject";
+			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
+			little-endian;
+		};
+
 		ddr-pmu@4e300dc0 {
 			compatible = "fsl,imx93-ddr-pmu";
 			reg = <0x4e300dc0 0x200>;
-- 
2.34.1


