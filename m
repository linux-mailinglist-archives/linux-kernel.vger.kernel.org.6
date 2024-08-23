Return-Path: <linux-kernel+bounces-298152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D91AD95C320
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 04:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08D4D1C2259F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 02:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5361DA3D;
	Fri, 23 Aug 2024 02:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jmZaJHdv"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010068.outbound.protection.outlook.com [52.101.69.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AC0111A1;
	Fri, 23 Aug 2024 02:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724379170; cv=fail; b=D8FcCUGWvuwlRjWqrEM7OFoZEDuG56JznYd3RvuRuOpGlQF1YyO0HMcbZ3O6UNh5Fsz9GYDg3cBMw3QIiCrbrLLeW14O6TrIRUVW0tr6YjoPLF1LbVA/DN7lDUiYZ1+fbn6nsc2XU4GTxmFc6/fmfCHGbhMx15Rnre2TAsshiFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724379170; c=relaxed/simple;
	bh=IbE9AQedrOaUZ3CVkOmvuQkEn1vjGXleDHW9jpNARq8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=J5TobH0+klIYgwleSgSK1ksVo8dmWmSrrHVgsldk/earemIzsdC1tdo3rWuiyRh6dU3hWbdBG9JY7RLWIDcaVP2vP3WIwimAx98fTDVx5ihc8L1T6ME/3GVrB0/tYHXUroXSOn/WhwhcgAHNEBh+veV5Ebpsn/Vqm6/JibW3Jqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jmZaJHdv; arc=fail smtp.client-ip=52.101.69.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=todiJ6FSXR+du5lLU7QF7bIV2/urZdV+syK05j/3u49V4KB1tGSsVCVAVSIv2hWs2bE504x3tx8ffCADZaD6TB2rC14JuwPrX0m9q5cMOmurgNa4D144xwca1yH/Nf5D0TaPGnLVTl+GDbEi4BfuN++qjcU7rOI/wXA+hR/W1RyX36Ws2y2P7dpeaFLtO9gzCJ2qMUZYr6ka8sY5J/+uguFFENNOmVRMJbMFaOxUQe4circqHrEEyz7PtA/KTBhmTUFgPB1DVN+iCT7qhQxZm9r0ljmZ4jVJdQoDQ/K6+lqGSS0jZa0mBoUwcu/Ui0gMuN95lXFTtJ/hqoppOiwX6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XveH6RGgkCT5dO1If27/Sum0ki0bg4HOlP0GeEnXA8M=;
 b=EQMfKzV/249sS1fiXb/ssWCjxbGLyHJmujLPb2uMwrpB63Gc7mAun4re1/7NuecCd02yaFzcXdEwVO5Ou6G9+Uhk5E5ooJXmJrfeHO0fUZKhGvyAbPBJVmHOur5+O2+EPrSBTbWc45A8evaNWLj9fbJKn6jgCcVGYcle02/VSRwmzzYnZkjPkZGeFiqABvlIg8o3QfnaiXdL3lxwsjWGGo/I2dpetVyb+x31QjCi4Ls2PT5R//3ht4TGaJz5upriWi8YsN6eDpEDjfHPD9n3Cb5sx7KtNgx9Ymxp/r0llGzGf3MBkKPGINBZmfmy7m79KZ5junM/jv1ydsf7+nfTdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XveH6RGgkCT5dO1If27/Sum0ki0bg4HOlP0GeEnXA8M=;
 b=jmZaJHdvSGTBEkymSFniOnH3CSjaeskMjFxhI5XqdSzJcsXNz/muZLDZtyQWASQoQp+ztnREm/4unIKy3IGKX1bONITGa5yNiRHUBg2rUuHfuU/H4xifqfTEHfb5Y7dY3QKzfLsba1xtkCZZRpWYgEi6bUsAOAjEFAOV6fymC26yEZa0y2sq6xzUwqbLnBbbBWvIPINbMaBAzWL7vSz2XVWirxp7xH+j8ITEkkxqNqoIkzOfSKYqwl6LDTVsnYHIO76EnLbrTgc3fNCo2V8HYg13tEIIfXNnwjSdY3jbo9rCxi5Hsyet4a5MnxXWbCVDmJCljeuqm7voDb0QBizHUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by PA1PR04MB10962.eurprd04.prod.outlook.com (2603:10a6:102:488::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Fri, 23 Aug
 2024 02:12:45 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90%2]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 02:12:45 +0000
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
	festevam@gmail.com,
	alexander.stein@ew.tq-group.com
Subject: [PATCH v2] arm64: dts: imx8mp-evk: Add native HDMI output
Date: Fri, 23 Aug 2024 10:12:57 +0800
Message-Id: <20240823021257.1067054-1-victor.liu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|PA1PR04MB10962:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a052528-b431-4004-0280-08dcc31913ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NkW7D0DEwF+qoOi8oU0SwKgPGTy7RRJDjsED1Mu13l5mFGc6mAZUvBMCWpnB?=
 =?us-ascii?Q?qerA3Y6foPZ8nXnNg1VuZT0lPUIjdwSUKqcM5UyxaAyN8jRajdME9Pezu7PA?=
 =?us-ascii?Q?tyVJ5lGe+kJyatK3mqM96zu3/vKiZ1jzZy/IW83Ob9hjq0ub9hYJURCe/yD4?=
 =?us-ascii?Q?wHHI0PddfQUFhuzmma3SCpvGMnmijVy6Fwmp2EOnr9MpM6uOA1uLp46JiAaz?=
 =?us-ascii?Q?0yIivD8TIIxYs2y7PzebwOpL0W/LcF3aKjcY7NanIBPFRljlR+JIxLCgh2Zt?=
 =?us-ascii?Q?v2dPrlQiQRp3kL73t5/TmlVo//ztgEP9a8eJWs2DgPfQNFVwW+0mrE5OBE+P?=
 =?us-ascii?Q?dSXGreu/rFXaqc3xlJOIepNordprw/yO8Rl8vhvqSLFJHJ0uLdapllN0JE/v?=
 =?us-ascii?Q?KjyrtYkPVx3o50tA95nhQqIlLXJGWF+GKCrMrWGSbRnVZVE6jGZB5QcQCreN?=
 =?us-ascii?Q?5LKWR7yTY3wW6VoPgnUD2heF5OiZ7N2Zb6NFQysVzbZnmqNeUjXADcazuQi9?=
 =?us-ascii?Q?vsPQnscerSTTC4JLF5WOa+z+X/SUzka6poFGdF2ua05sJKemLxlC8Vyx+F49?=
 =?us-ascii?Q?3+tJctaYHVYJHZR9cKJHM7Lf6JtqfBSc8aqkrXsj5LUDNiaTEt0bMd+m921r?=
 =?us-ascii?Q?pS9fBwvYMkCvDNZAHb6+ZRFnJnkAgk+4zDJjzWr5EOqXdqer0SyO8LIKSOBE?=
 =?us-ascii?Q?qllU/m1iDdIa1kwm6XvBtAd4dSTnuAa88UQ9ya65KrE6BL2ZaBUhjNCvCqoB?=
 =?us-ascii?Q?sRDp98hZSGCzNYpWFA4pk5RKzutq6aNhG0ePU+H3sf/XosuQwi3fOtkgrJSm?=
 =?us-ascii?Q?qVxJFqwyfvYN8kxuNqDCG8Nq5h+OiKYD4gRw8bczMlgvLzMgfGwYAc6Hr9Qd?=
 =?us-ascii?Q?YNqVK+Lw7/SlO3+4O5Uf4EzKQ+4pMkeGeBIMW9PzhJLz3/jIzN0ZFrDaeunD?=
 =?us-ascii?Q?zcxyMRcOLlALNMvlnbEy/vhd9oA+mlTCHLRa9d0FQnPYUJJ9oQ9t7dtmfUhc?=
 =?us-ascii?Q?L1foISopXSH7asRSEZ+dgiz6TVbHI06baXUtyow3CsHWHzVAhiUX7HSb4ZZV?=
 =?us-ascii?Q?yhhs3M94hvjyNhotW4qkJjIynFlt1CqDU+/cn0L3D8cMewHYOoKvuU3dL+Qe?=
 =?us-ascii?Q?ugEo3qMy23mDIOsl/SOSJBrYltOu5w7KdaDhwiKzIRt0A0c5NVeP3BPprQS0?=
 =?us-ascii?Q?59LRtJOKihQm7nzqoDkEZJOaVIxMQLiejH8sxsL0Wf+nlDPvrVK67IuQnWV5?=
 =?us-ascii?Q?FFzfiVzEOk1y5qDdxCHaQ2J8/P4z2BWsg0xkfOdgv29khJMsb49pkgA5/B32?=
 =?us-ascii?Q?wxpR14E3+yNan3LVn5BmzGkzms9UPM10CUXSuFfNS/LCUlNCh4K7vzVFVnr9?=
 =?us-ascii?Q?Xh5qZU8NPWzu6KAUwfjOO3b8NU2NLzNLXFBlz/w1EVwTe6vDrw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lW0ee+DN1i56vvTO+zfl9sB7t9+ga+1+XvCnxwG4t9eK+n5nIZq/Cw6CqwzN?=
 =?us-ascii?Q?PFop14LpaXSn74jJnmlKvI84FsXCgKKy4WC0ROt5+Nx+3pcNPUnt5svYDcWB?=
 =?us-ascii?Q?cXf746LtuDe+ZHAvdZ8s2qsEq2kuZjRuhZ/Y9PryPmqdtvYWv61wl2Ual/gy?=
 =?us-ascii?Q?G8kn7ANjP0rIgh2MTo6APKgSf/iYVTS1xmvzjtH8zsIKr/K56GXtvEBQnTvk?=
 =?us-ascii?Q?BgV9qEXZ+V8z3KhnsfjeFOmhbMJyBvwer1GngDmCoCVuuRpMkNDMVxf/G9xA?=
 =?us-ascii?Q?jg+ko3d9kGbPlTai0egGeHGm1RvdKVL6oIQ71av0aOvLwZi6G1bJPy+dnX56?=
 =?us-ascii?Q?xUDYn4BWLglh6vBS89LbCbcK0mEuLBh5Ydb/Re1FNRoSGRVZgh/M7/tX+7vU?=
 =?us-ascii?Q?Xn6/oRM2Qx0cu+WYH3OFjfCpunopOjmQfTuhhAoXRlKTNTFIYDxMMja+urFI?=
 =?us-ascii?Q?1oVlRKLoCZCpuW6VNuCuQueVpLu975Mz5HG8G6tfJOv67CUnb92iKUK222gE?=
 =?us-ascii?Q?SzM3ksuJl45BsA3vF2maIqyInGxOfYPHdwztBcEUjUHl4JyxD18XllxIs1XX?=
 =?us-ascii?Q?YBMtKUezpy/6v69qRFrYFzGLDuYg8c7UCdjHzXTi+SINs+zVsNW/8xi1QV/g?=
 =?us-ascii?Q?lsit5Fm7R0P0G4SxkLGc+GILaXCUen0rVMhj0yK+TvmMEyI9L2Cw1CIuXdna?=
 =?us-ascii?Q?A5UBt3rticxVpx021A3bpPqDhwE9Y6r6mVBABsoMNQcQ/sUdulDrlOeAd92X?=
 =?us-ascii?Q?fsWO1k/FgRHeR2dsresmCUjseDq81m1A2KoassHi3wKa2KZlxxmZWIJ3VqKu?=
 =?us-ascii?Q?1d7sWhR40FrlLOhxu/3/M0yxPDxnu5S6xWS8Kd2Kmwh8oSy4lrKzPcE7sCF/?=
 =?us-ascii?Q?4BvHbkw/2QdpFWFyilTTnnrQs16uXibJ7T09ac50/ZmDMVT0rf4e/R+duQbZ?=
 =?us-ascii?Q?X09I7MGuJIinsdHmAhYIt7SmCUnPTb3KP8cJaTrVnf4VjHOBQsub6VWgvciP?=
 =?us-ascii?Q?uKB1j1WJqSv9pdSFRIuiymJyVUfHom4OdZ4O8JyJhs0nYdFODo2a1mqU1LL9?=
 =?us-ascii?Q?nkJynspNw4mHK16/E4WH7pp/VMDonlIB9HDNQQp1toVuhO+rt6OSiA0e7Ezr?=
 =?us-ascii?Q?w81Rtp1FoHILo/GSGPwqIDVgHn8zyB1xEfgG6KsMWP4DNXSrf6Lo6geEhZsA?=
 =?us-ascii?Q?iB6Rv0YUbTYDzCTyHfPxg4Qoq8JXZIuiuxwU3bgV99EbKlX6B74PVWWeoFLG?=
 =?us-ascii?Q?7OIjYhfvU5H0NNvXlx9SZJh6Tv1rI6y/elskCufQKCFgQ3qtfGmybUnZIBKf?=
 =?us-ascii?Q?VA0Uxy7AQdD674UqtbiPwSTV52oZIKqxB7BSr1JpMv8YxEne1JgeO7LEfQuq?=
 =?us-ascii?Q?0SKuHrJ/9gCntyQZLUQ2ucDb/Gbxxc2gvy0D3jZDloSyLU0MrzHOuffbHcFt?=
 =?us-ascii?Q?2DJzqgTYMpSOxzEWPNgBsaKho5EuQcDrT2zGypXwuAmOnQNf7cbr7riJXhuo?=
 =?us-ascii?Q?nfjmaY8+QdC7dRoj0N6vt/lXcNDojL4bNl+VpyzU50bgQ5kKt9h7hT6IpZXa?=
 =?us-ascii?Q?dxSx4AVuKJvYu2ex79/1FXWRQxqfqJCU0JUypktS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a052528-b431-4004-0280-08dcc31913ba
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 02:12:45.5266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FVVcvpuFdtJy6gSOUBNa7kUdnyXQJKCFKpYyRLS1KAt6rYR98LnSnjiTTMpfYSJcBFxyzjTIAeUvdvfnciPN0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10962

J17 on i.MX8mp EVK base board is a HDMI type A connector.
It connects with i.MX8mp HDMI PHY.  Add support for it.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v2:
* Change label hdmi_out to hdmi_in. (Alexander)

 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 46 ++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 938347704136..d26930f1a9e9 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -56,6 +56,18 @@ memory@40000000 {
 		      <0x1 0x00000000 0 0xc0000000>;
 	};
 
+	native-hdmi-connector {
+		compatible = "hdmi-connector";
+		label = "HDMI OUT";
+		type = "a";
+
+		port {
+			hdmi_in: endpoint {
+				remote-endpoint = <&hdmi_tx_out>;
+			};
+		};
+	};
+
 	pcie0_refclk: pcie0-refclk {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -408,6 +420,28 @@ &flexcan2 {
 	status = "disabled";/* can2 pin conflict with pdm */
 };
 
+&hdmi_pvi {
+	status = "okay";
+};
+
+&hdmi_tx {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hdmi>;
+	status = "okay";
+
+	ports {
+		port@1 {
+			hdmi_tx_out: endpoint {
+				remote-endpoint = <&hdmi_in>;
+			};
+		};
+	};
+};
+
+&hdmi_tx_phy {
+	status = "okay";
+};
+
 &i2c1 {
 	clock-frequency = <400000>;
 	pinctrl-names = "default";
@@ -604,6 +638,10 @@ &lcdif1 {
 	status = "okay";
 };
 
+&lcdif3 {
+	status = "okay";
+};
+
 &micfil {
 	#sound-dai-cells = <0>;
 	pinctrl-names = "default";
@@ -858,6 +896,14 @@ MX8MP_IOMUXC_NAND_READY_B__GPIO3_IO16	0x140
 		>;
 	};
 
+	pinctrl_hdmi: hdmigrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_HDMI_DDC_SCL__HDMIMIX_HDMI_SCL	0x1c2
+			MX8MP_IOMUXC_HDMI_DDC_SDA__HDMIMIX_HDMI_SDA	0x1c2
+			MX8MP_IOMUXC_HDMI_CEC__HDMIMIX_HDMI_CEC		0x10
+		>;
+	};
+
 	pinctrl_hog: hoggrp {
 		fsl,pins = <
 			MX8MP_IOMUXC_HDMI_HPD__HDMIMIX_HDMI_HPD		0x40000010
-- 
2.34.1


