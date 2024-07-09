Return-Path: <linux-kernel+bounces-245349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8962492B193
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACD751C2130E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 07:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BC5152E12;
	Tue,  9 Jul 2024 07:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GLGJjFW0"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013035.outbound.protection.outlook.com [52.101.67.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFACA14D705;
	Tue,  9 Jul 2024 07:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720511435; cv=fail; b=jmoURBj+IOSl3Mo8cVEoQBf5MS9xEzTbpPFQ3iFH83Wsfd2WCa6ChoCSaD25+L+8AQOVtC7YZ4O+bJBcAMYEYyCQOPsEANw+qio/5+PP/IEICEbcYFGGsTBinKVG+KT4yjWaINt3ecFTGdzlcKYDIl0XpKV3S9NuwEbLirv69lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720511435; c=relaxed/simple;
	bh=zNY590q6+8yJC3pAAmNOdkFfDBXbKx6fCyVYAo8P5qo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ACRUB96ALfrkJpLwZOKHQzk1mJi5T9vEwKkcBmV7zYHclD5kFA2ZOJlkYOVhRrcHr/I2JVaWtnxm1xNNcPcpe5G6zvt/gmJWof8KA7ACBBl/7e9meKK24RRIsqvM/PBlRupazGtA7GoOLjhwDfCuk1rk4W04HWQVAW5KGq81f34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=GLGJjFW0; arc=fail smtp.client-ip=52.101.67.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXOO8UYq026OPSlp3kxcR4VhxqS70Bi/lAf2JqB9crMReHgyrdIm4wxrkM8AhUis8lRTtVWDTjvVx0ri5ubI8B1J87VncBiQbGqBLqWU/K1OMrnc+fGoTTEoWeV1ne8Ue/HuUZ3MOZ0gMBjlwUCN96TeJ/2FnyRy/ZISx+IqJbmjMFlXc2B1bwl0Bzf/8iN0kWIN1pJtD1WxxeR7WXyLg0S6QftCFT++6ShFzfulJ3lb0xjslJbXiC/rUWsMeJdbeD5uIGqQvrT1Pw/TN2lLeeboafmxUENC9IOfSvKCZk75BV+hJtgW+z1/RND6zoobFeInjprHA8EvG4uEfGCXzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Nr9d1IQk0+V1y6Z8fUPxO9OjKqrugvL4SRS4Hr2be8=;
 b=DPOJjyLTJme6MI+mgerXWhV+nJfWktN1XJgODu2Pk2Fx+OXhd2YNetUvrBwoEdMzXeOgSzkECoX7lqxaaaFf0a1qZNV/2U6+uhWEJtFUcX7cPw4eMEIg7cw68CHjU70zMSWbrx+7wZA5gvkIzLiQD4H9Ifgli12mfKajWJHIv9zw1W/VYQu1lRa7M+FNU9xeFAYtWsT0WovKHW4wjjDpYilQM8yVB1GAXwBXW1fL3bmzSUFyLGiN7QThAMrBJ5GqGRZ2f/qeQ64R8xdmFEq1T4i6dv/WACVymkUtyHx1YyCNIxJICmWctW/eKC0/M7dgUXg3q0D3Q1J0YA8e4PV38g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Nr9d1IQk0+V1y6Z8fUPxO9OjKqrugvL4SRS4Hr2be8=;
 b=GLGJjFW08EfJozyaQ1A/H4ct3B8RW7xhO9aNM66TvcDtpGgEMBPjrYcSTN60UkWVuqRpLLcB//z711tJDQec4BwotNtgr3sO06zBGza6o7PBsnYPjt5vRa0t7jYFT3OA/wrR9F/hkEQC0aBmmKfGy5Zz0FcOhpn0ziI+BnNQx10=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com (2603:10a6:20b:40a::14)
 by AM9PR04MB8652.eurprd04.prod.outlook.com (2603:10a6:20b:43f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 07:50:29 +0000
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::bb21:d7c8:f7f7:7868]) by AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::bb21:d7c8:f7f7:7868%6]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 07:50:29 +0000
From: Wei Fang <wei.fang@nxp.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	abelvesa@kernel.org,
	peng.fan@nxp.com
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: imx95: Add NETCMIX block control support
Date: Tue,  9 Jul 2024 15:36:04 +0800
Message-Id: <20240709073603.1967609-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240709073603.1967609-1-wei.fang@nxp.com>
References: <20240709073603.1967609-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To AM9PR04MB8505.eurprd04.prod.outlook.com
 (2603:10a6:20b:40a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8505:EE_|AM9PR04MB8652:EE_
X-MS-Office365-Filtering-Correlation-Id: d5528b4c-2ff6-4148-ba99-08dc9febccec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oMqg/aitOOJ1dJuBnYYilJbtPA1cuovyXb8O3Mm91G7NQjn0vL4KG9hoGL1Y?=
 =?us-ascii?Q?PbhN7TX/3Elju1OB4DGyVRHY8t4TQhb7+ySfNGScCk6fZhMoAXWYzOAO6owB?=
 =?us-ascii?Q?SW/RjPih+gz1N2l/qbAMujPYtJEtcTSBRx+5ZOcTydwmhj0tt3I8Tce25YbQ?=
 =?us-ascii?Q?BhsaVbz1XooFQr9C61G190DinmeZmdWTd6HUfDMdhTxu7YK7t4wVV3UIJb/C?=
 =?us-ascii?Q?LNwBcl+qBbGyotzy2m6be65Dgs9ivMss71aucAdaLo2Iqs+cHbbicTwt0Hth?=
 =?us-ascii?Q?vBl+EEi9TfLSgrR1+mWNDZ5x9qXHYH9eqOMdqUp2vAY2EiYnupVqTe08MASM?=
 =?us-ascii?Q?Xs/kNt6BNDlPJKfbYRaCARfe5fcCFc/QiKh+CeMD57PPtrftVGUWOvqFX0Nz?=
 =?us-ascii?Q?qHVQ7GVLLJ0pzW0sqT8LTSGs8epOVZ+uU6nmti4laZ4MICQHbp+cxqoad+ot?=
 =?us-ascii?Q?PTfyJVH93UAdGvU4N88doQt/4pyIG+n1S+nefXg7HSrK8+lXf5mogLjK5Obe?=
 =?us-ascii?Q?ruU5EMpAam2Y+4rl+KH5Gw6Lhw1aSJxP9Om1FquPyoxHfrPKlyhHKJINPqGL?=
 =?us-ascii?Q?pVJpQe3t5QkvN80B6Pg3ocn+Qo/TE2J7GilIJhmEViu29aQWUvnlHJNV6Sel?=
 =?us-ascii?Q?Yg/fOBiwRevENtyLrHg3+Kg4PPWVkFH9edbB90+k6NMANKuk1oBeYpKVm0w5?=
 =?us-ascii?Q?ERNk8JzRumIXp9bn+e4MAJDgWPrXKSf6lEY7bnNVLXqNFIThRAZ0KtsV9PPC?=
 =?us-ascii?Q?Sarp8irsPcR1K/n67YSLUZUkeOwhZKZoKZjrhccxuXocVvnm4B3SRQ2vVntY?=
 =?us-ascii?Q?oZhh+mPuMJiL+nMjlPHd51FQ1PfaP7ViRWVybxIyv+O6zROXxRE9aWtYmgsz?=
 =?us-ascii?Q?s/gxRaGIolnqay7GmZEMMysFMLcW99+Leu1pNBJ5b2a9bNUF+5ORE9qiL2o0?=
 =?us-ascii?Q?uiPDcbbEkqtCne2gVCYLUET9sdaQJ52ncw9XDAwFVVPQRbiGYUqdBso3XK7q?=
 =?us-ascii?Q?PUQGZmOrA8E8jVLeWBsK50KOm0/4yCId7+jjOAh2utTfUNzz4cEKU+OwR9t1?=
 =?us-ascii?Q?S20206KvQR57DOm1Jv4QxnWExwfPTbIRtUkvSeQcKBhdrXwLI+msMSMh/eCI?=
 =?us-ascii?Q?Zyhxf/gna+85p9kNtppE0yMWSAsVoWrauD89UVRy9WtNUP7pyBv9s5nHfQHc?=
 =?us-ascii?Q?gBz7T1owBBPUscdezdyQvmXJj9KAUF17EQAq1DqiXNYnokh/F2YW8pleO6gR?=
 =?us-ascii?Q?jtX/eQ32SfUH9DQJLm09ahOh2ZkIj9o9tIw//qRSUgtEcciI3Z8c1iGcZhDz?=
 =?us-ascii?Q?yWW52PP8W2AaSCkCdfApp9YkzM7Z0MM0KlGfucno6CLxFlRgsIj0Yz02/zd5?=
 =?us-ascii?Q?gBALwor1/1lcA3JwsTdL1WRlCoy1QrHp1r627bEONAngCJNeHA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8505.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t32kDEUoAhdfJ9Y7WX+G0Hy4Sbh1ckaRtHcCUpEKa6Z64uaEhx6odltfG0TQ?=
 =?us-ascii?Q?UsnkQ2BLInPM27SSvmL14Z+6MhbJO3z3BPVHdrIwquJUu2OGA6sETLsfrgol?=
 =?us-ascii?Q?tYwxXvq1y45zQjX5XrJv0BSpKmwMyW530GDEESdMcAbqe+MzpxW1ScmvdFhV?=
 =?us-ascii?Q?/bBXekWD/AxiqYjhPU+zBfi95ZcHZuvPMrZ3sHdHJmAasvftkebV/z9+N7DC?=
 =?us-ascii?Q?hA7jGKBKJFaM3+mMJmu5LbTRr5A7r68J30pOxzJbtPHGWBkbl/cvR/k0Yxo4?=
 =?us-ascii?Q?UuLH4tfyRdxVjt4rcPAEdWSJR3yh959I0QDQv5DsMy6zwYzmc+AizQ4SJO9P?=
 =?us-ascii?Q?bZgckJYeQvtmo0Jxosws/PEMlzCV2x7mbeHvryD0/nZ7dprYlyzRnbYDv/JO?=
 =?us-ascii?Q?CgKf7GXDp/XY0xO/05Yv9Q6/Z8yFYR6bOx/7GlK92PnbmiFLzcytaAMa+Cb8?=
 =?us-ascii?Q?Ypoj5LBPxlA1thKvTpbrz3gGk1k25tW2nVyszCQjgMQvH8Ozu9Xqmpz4GkTA?=
 =?us-ascii?Q?/XHP8gaTwU0NjITFVKT4q5EK5gVOyWEPOUhm9JQ++WYcAF7u7ftSRE89qeBI?=
 =?us-ascii?Q?+DfK+mgSSYuMFBQY327BqDWUTuYXP2GH2XMQIip7Td7iN6AdSdVlFSJpQemT?=
 =?us-ascii?Q?ZOyAjRMlCIBRRPTwzPGnKJb5N/XZTUcMYY04ZBdGrNe4fIPXYnDFY6dFhgAY?=
 =?us-ascii?Q?1R/h0l6nMQyiEPo3TSHQ3w8QMukIQ5vzUgiX0XaO7R/jmFEZGmI/3E9rrvd0?=
 =?us-ascii?Q?CDPYpm6xRGK+DGJl6FVKnN4mpO9Di/WyKZBK6qbhz4r6z/xfwOvhTTmgb0P7?=
 =?us-ascii?Q?ECxinXcV1aJtH7p0dtsXTZp+CZv1yVQg3WCyHR+0ZcgEaEe/46hxXu2RD6XR?=
 =?us-ascii?Q?DgR/yYGDXOeQKk1qc9YDrF9rrkjyNn3KXo/YFH6HJhOMJrHW4dkfKC/WiC0l?=
 =?us-ascii?Q?DDY+MYGErxIbEnOV4Z1rwvaGKloAo9RalZltWXk8aXjAcfEgZOMkKcOB5XqJ?=
 =?us-ascii?Q?AVfiX+p89C+i1Ufox96sSPqqbZrBlDUMbo2ZNrDWFS0SobZT4p5o+TEJ1piU?=
 =?us-ascii?Q?TMyCj+m31Zr9HCE/KlaE6UqWTTblsThHF1BYGv87Pm1gSeppRvOgdjji9bhG?=
 =?us-ascii?Q?zlzIWfsRWgKnbjmAXK7cuWo/3qniaF4GQwB2avPsdr6QzdZg+05bL4my6/79?=
 =?us-ascii?Q?nrvZ2OjRj6DMO0lqZ8qj0vRNZmKbLFpcC8F+JCk/bc8mCgFURN8mB5qbvsl4?=
 =?us-ascii?Q?zS4dLxW8dKJYCdl4L/+qR8qSkcDyLsG8omVyYsIZCA6z3De1UH/fDd+Wv09K?=
 =?us-ascii?Q?7Cf2HNgkZN1+1/PM/47kg+shgL9u1oI00jzTNkStM51ADI18OZ5Eygb+wrKC?=
 =?us-ascii?Q?8KPiFK7ozPTJBT2yZgBKcjseKvXwKaoPab/dYOzo5D5LWTP8eGgXowhQbGSh?=
 =?us-ascii?Q?LcLTSi5M+rwtT0zKhcktJVVRDFtZj9EkKvRQBpjfBqTIz6ERHdCOFd8SjzrR?=
 =?us-ascii?Q?/d+/E/82LF9RoYfMtQsCg3S0pHBAoPaW3oaS0PXmkKP3z+wnFjgRIn3P1hSd?=
 =?us-ascii?Q?edaqgdtbt3X4wcyrlnYOCjpIJM0UPNmY6C+6dL3Q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5528b4c-2ff6-4148-ba99-08dc9febccec
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8505.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 07:50:29.0331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CBbZUYL6yHz2L+1AFs23zpBqngFmlso1dlhhPhcXWUHskmrtejS699ASHYuTYEIQgBLVDqyboJtATQgegzNHLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8652

Add NETCMIX block control support.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 1bbf9a0468f6..6e86aa98b431 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1188,5 +1188,17 @@ pcie1_ep: pcie-ep@4c380000 {
 			power-domains = <&scmi_devpd IMX95_PD_HSIO_TOP>;
 			status = "disabled";
 		};
+
+		netcmix_blk_ctrl: syscon@4c810000 {
+			compatible = "nxp,imx95-netcmix-blk-ctrl", "syscon";
+			reg = <0x0 0x4c810000 0x0 0x10000>;
+			#clock-cells = <1>;
+			clocks = <&scmi_clk IMX95_CLK_BUSNETCMIX>;
+			assigned-clocks = <&scmi_clk IMX95_CLK_BUSNETCMIX>;
+			assigned-clock-parents = <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
+			assigned-clock-rates = <133333333>;
+			power-domains = <&scmi_devpd IMX95_PD_NETC>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.34.1


