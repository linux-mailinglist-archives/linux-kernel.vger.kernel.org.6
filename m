Return-Path: <linux-kernel+bounces-281041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF6494D241
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B026282CD6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC85198841;
	Fri,  9 Aug 2024 14:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eodXIvoe"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2075.outbound.protection.outlook.com [40.107.22.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9881A196C7C;
	Fri,  9 Aug 2024 14:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723213953; cv=fail; b=TfRpTnoqHMMudYxh2sszLSTjyD2BFI23vO5y+v2nxhtDInDWbta3f1UQAFNxaOZi2ZaD6YQplTZSW8ZTPeLzDRjetHGovCmpg4dSFQJhE1OrfRpSaolHWTF37uKZGI2zclNFUV1erBKpVtjT2lA+rwk7P9UwJdXZD0immLkaabg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723213953; c=relaxed/simple;
	bh=oQjKh0D/BobRMldJAEA4y09m+di2eakwH7TGoTVED7w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m/MYLrh+GQoEGg1kSuYw2jj9QGVOUMyVIEyPl4Xd/i58QKUwlynebIyHOiHTjFWss+vwMNxNAHuJz7/m46hYTw2ahwp99ogJUhWMbE7nbVO+D5oze7TMbZTQFTNcqCa9brex+21LZf55oq2n1dP2+W2XjDPJb65mUqCMjfzFO0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eodXIvoe; arc=fail smtp.client-ip=40.107.22.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=daNp/jocA4xA9su4HigicEts6vhsXldtvjlHCO18NKRyV7rfnUxNgZzRSby2DmkYjhdQfqsc5O/VUHHpjf+BUPSOqK7d5xfrjnsmQFVd+/ln9yzEN3WQaUhj8r1P+wULpycZD3bJFPebT9foq7/6I6UEj+KMsw8+HW3s5IB2ZDA89cfhMc2I0FTyeP6T9oIuxrXdM5FkQxuBq53lgUmDtFlCB04Grxz+MGm5iz/eS96xxrrw+KCayHEKzIefKZSRwzuyi4vFDueSGDgXm5ppjK4oXcDEkWHsvvrPrInwyDL7a4CrdzDX3nPvPjvgFYWBW/srs4871hdJKZJj1OG0Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNSLMga+Vm0erbTAqizYFkJ8m6X4lGvRGVK3W75O84M=;
 b=iSb9GmzIwyd1v3QFVUmjhnmcJi2guwq9C/uRTIiaJitupOmXfJXUCdflucU9Wx0lQZfNtZm3uejBqPfMkttu/82ccVP+9WyyLlXbkJGStpzzky3iwOtOvS/eNiuYB/DC8lguvu2v8rVm7OQqZaO2LIsGMMeCi2HNrYxasIiaEr0LzmUlGZYonOfXYmdWAyZSAYgfZxSTwW2iOihEwM9ym+MaoUQB6IZhA8VJBHC+2fe0cl4KNAzNn/iHuzVmMg0xHztKq7o2qS2rVgWli4EM1iw7pWbx21ThFUrs2msJdOdHtpTdcNP5XmEWD0RbwM1E6Y/pbz1MgmQisEfjm9O/og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNSLMga+Vm0erbTAqizYFkJ8m6X4lGvRGVK3W75O84M=;
 b=eodXIvoeSnyeHryKm1vJ2RJpRdxE7WjmL5xWVGEbO0h+71BUG7lUHgptZFvuKl8h5M/VL8rfydDUQGQNBID81rESOrDJcmD/RReFPtOVHyvLSzrh2u2F37SzCL58D75n+aLnpTzb0Ho8SUF2ryqmc5sFfm/TrxrWlcEpVDPd6a/43OZQuzApK8QDEUUly+YOvx1V06ppnnEHQNY//eRvhjWtzGt6uU1ZTILiJu1e4f/kAGyR77eKfAN9a9t5W4tO0CVm/ljNY1hd+OFDVNIaoUP3cNVK5Df/BZHBbVCfbmJM8SBUW88+vz2zVVcEXSzueTp0lfWVV9W0901g5jsgFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9284.eurprd04.prod.outlook.com (2603:10a6:10:36c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Fri, 9 Aug
 2024 14:32:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 14:32:29 +0000
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
Subject: [PATCH v3 1/1] arm64: dts: imx93: add lpi2c1 and st lsm6dso node
Date: Fri,  9 Aug 2024 10:32:07 -0400
Message-Id: <20240809143208.3447888-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809143208.3447888-1-Frank.Li@nxp.com>
References: <20240809143208.3447888-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0031.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9284:EE_
X-MS-Office365-Filtering-Correlation-Id: ce3bd18c-e3e6-45ea-e180-08dcb88018ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t743+EzPYmBU66g25/uy5cC8divySehcE1aqMOyMRi71BAr+3rnBW5WA1VcR?=
 =?us-ascii?Q?dVsycyqngjLQRROZOq7umt7vDB2PPOW6CfCpqP/TC62QUaxpF+a0AKYrnrFL?=
 =?us-ascii?Q?FxgZSaYxcDisq1WDboRdrkqg/4djKh+crqecdERhySkQ4kXlFAUgC3l4GRGV?=
 =?us-ascii?Q?0ha6xBACnEJfO7WE2jFmFPTYfJsw+os+AE/baDXpY/ZqF4UeRhia5R8rTRrK?=
 =?us-ascii?Q?ud7jACFd3tqS8qrypgrmvL/nYL5LrgF2UfLFsNIFOEntg9lVBxDNcz7I9aE2?=
 =?us-ascii?Q?+crUUHUblFoy7fHCWLfL+ke+V6K3aX50L/XI65fE4fleYBVig5WVsEAaHnT3?=
 =?us-ascii?Q?BH9G2x6ENgT9DXchtoLzB6kUUQ/mONzK6N84fHNEwTpi/axjaoxXrlE9Olqn?=
 =?us-ascii?Q?m93iX5+cI10B+QTCX3wVw4HfIb0FdNKBDY9IGNPoZG0wNfDz43m5H+o21Byt?=
 =?us-ascii?Q?5kq3ZZsJ/lpVxog9vW4l5+GULV2I1T977CS2fnIjA9J5k8ywpeU/CEgiN8ZL?=
 =?us-ascii?Q?BoZpudIB/k84o1zr73utghf6mES6hRmXHdBLHngHhDeFeTpdaCZ5JrOf12P3?=
 =?us-ascii?Q?NsbvcU+gG+AyrHhkvTkTJvWwA0pJsZPFtwayBguuR3fwArPnItK1nFKXZw9h?=
 =?us-ascii?Q?1LXOm5OQdYQIoHpi8gp94Q6+VBXdubUpU7QlSB8tZYDVd2uFKETn7qKZHNDe?=
 =?us-ascii?Q?Z+clYPZfPXg6xzJV3xsQWjI5O0a0rAX3KSacxOamkLCs3DmskSoDAthEFhyY?=
 =?us-ascii?Q?aPNxjDGqtIzOKTMJaugecpj1qMZ/RdEJsJ5Z/SczSNsbH+x5TVW9szV+/8tH?=
 =?us-ascii?Q?pqEjacUxIg1C9HsvVOkN2iVfUBpUH/9uBJKcPo/eB9M+/BQY19SQIfu7ydix?=
 =?us-ascii?Q?DNt8yZXFAzoW0B0PE041dzxjg5vx5ePd5tMS2/xZTCwHuXdkXIVqQ8hkQIqw?=
 =?us-ascii?Q?lAx/3FHXXmEn6j6XN+IcjZalYI3kCNRxJorWGFBeU8LGWEa529+luxulF8yD?=
 =?us-ascii?Q?Qbjl5nCEONut6pq6aoA4bNWoRnFzpuocBOQtMuv91NHluGqZ/ld9f8vHGsLV?=
 =?us-ascii?Q?DnnBvttPJTF3prLTTYXtS1Teb273sl8cBAbRjmtjl3hvYtyoIKRPiNy+Vb/k?=
 =?us-ascii?Q?FjJbnsoTvVCqmUhy1NAlYBh63xrKjh8j7dLIZt6meirqSG7G4DarriAgql7P?=
 =?us-ascii?Q?ASAZNp/argMlJs7tRJua1c4Lco/COGzfWHdqNfG5QAkSQMNdiGm9jW/ffqw4?=
 =?us-ascii?Q?ZUHDxWKlDPpkWyH5fe2tHOaC5P7l7OuTzjQVDtjMA55DNtWBy22NDpx/O5X1?=
 =?us-ascii?Q?cm/SyP4LiH9zNaYmNAw1S4fjFjsy4S5+1OeZSHg/dk2UF3CyhGOhk8ALs0y1?=
 =?us-ascii?Q?nts64JpBx9Z4CKEkW8/VhPSWt6pDHHT9lRHFh9w4K/ecDDalhPUrcisUGndm?=
 =?us-ascii?Q?BKGGW/LciKA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FF5APCimAC0EA/H5ofIpcdP2G7uqp2sdas0Z6fWdR9Ea0qIz6lHk0U7Vbhpj?=
 =?us-ascii?Q?isY9EHV4p0fPLrMYWTq76ghTFBqJENya0qfrQsd5u9qHoczg1sfg7Si1agkn?=
 =?us-ascii?Q?EGFD8N06BtS1afmQAWw8oYLWFtBUOAI8PkMyJO2dGFsuFZRvAcGRxt52bRAi?=
 =?us-ascii?Q?YKyOhY1DLqov6Gg2lU21/GxdzV+aHl5kSP7eohcTPw5V9fnnG0l+sFdg9aoT?=
 =?us-ascii?Q?dcT6EOzSBATygWYLRNufooxAiIeIlrPRWhbG91uaI658VmaMqBLAcQbl7yhB?=
 =?us-ascii?Q?ncMjVpLUEUZYBuOcCQMgxKs4buTOsFM38TyUufJy1bBQ4QbPDTGIjLPaoQ5n?=
 =?us-ascii?Q?AUUAWWHM6jeDt1XsjTFG2vC9g4ZGobE0jVbqVOlH2oyTokDA6N4y71hzCn2v?=
 =?us-ascii?Q?uFvOAdelUUVgi3nvq9GViLKKKHMcUeSkkfcbCmdWT35ImKisUtaZRmbK/exp?=
 =?us-ascii?Q?VpDO543qjkkgjBucRe71ypDi7KW958nBr26T+pRQtamWBTqGl/Lo0pYsoJdg?=
 =?us-ascii?Q?jBgyyuauB2j21da63CddQGIWO69XwpW5ilIW74fkVTnnmhuFjES6KHP8e17Y?=
 =?us-ascii?Q?PYfrIszHtaKoHeQ88lY9bnDGJFLc+Naj2D8RXkZFoGpn5ZMsf/SIPLJi6lnS?=
 =?us-ascii?Q?w2iCTUtwNUP/jgmeo5EqD1HIo7UbdMAe4KPBBkE2TO6rF3O140VFAqqWWPQr?=
 =?us-ascii?Q?V35UVsdLLY42Yl9zGViiKgqnpIG+BO2+WLhkthRQrWuNE411Sv4C34MUl/5E?=
 =?us-ascii?Q?y5RGmz0XhBpY/lt60t/Y7YO1wWW03zTmrx2w7Fh2ekF3yjls2tOMdkcrr2gq?=
 =?us-ascii?Q?Wo6oy17cOkYXmWMZ1hnrHcWWM54L1Xre1r4OaN16l3yKvprDgKSnBhIEHIpv?=
 =?us-ascii?Q?G0AOT8lvmwsig5J3gBbPh1fIqXryRD1WzQD0S8ZPVNIeC7KPcw7m0kfGafWs?=
 =?us-ascii?Q?ERvGlXxJw+5bCgx60KPYcx4/8GZML/54nRnb/60UTnRwZtzQmVi8NgHSjv5M?=
 =?us-ascii?Q?BVDB+jMtECZu3qTM6jDB41Pw2jP1WWuU8aEy8DUdxExSnYxFKfmcPfyBOFpU?=
 =?us-ascii?Q?Wi6nHMRizDQmv4LWl4DhviBo9mCjplwYzdsmY+SUH0lxxucsGPAQeo29YVr+?=
 =?us-ascii?Q?RkEAiYeBOlv8PA9srYyD+g+GFuwQ3lbIbYTo/s84xGmYeepmDSUovK/UdOfk?=
 =?us-ascii?Q?AfQyERNL6PV+eBUFYRklQdh8VGP/bSWYRC5gyF51nyZ42W6HR++j/JgQW8ra?=
 =?us-ascii?Q?/ILaUvNo8vtusYF8pQGGhMmwDaExRK3Hq+m7P0rmuhrH6B4gqwvc6g6HAxY3?=
 =?us-ascii?Q?seLWxgQECzUEA/FlEfyJkLqCmZyKeB+RkvSQu+Z6Hd7lAPu8XMu51xmQRuP9?=
 =?us-ascii?Q?WHgx9eKPR8Rn+pFOWGHUzh5bhOFbpjwsv2C6Pu7107qLcGU+ECOv0t584Ma2?=
 =?us-ascii?Q?q83FrgpZFZJMeD/b4LomtHDmWSbnhFIdOeZ73YiKvnU5gLgiWb2BfB9rMkDT?=
 =?us-ascii?Q?+o6d/AZXFmIQHp4QGMld+r2+Nss4hzZtiTyxlQDQqKzozTA9q0giROpDhU2m?=
 =?us-ascii?Q?VddOB8bwsII3JdcxovazNO2Pnq8gfiyR4L8ze/6z?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce3bd18c-e3e6-45ea-e180-08dcb88018ef
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 14:32:29.5100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: szyuUpr5Q2llb7YF/EuYp1rFf+uQ1beD5i484mz9YX0VRqK/ZzM9leXUwVLEgiFU0G+0OYojkLKrcIblQFgDeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9284

From: Clark Wang <xiaoning.wang@nxp.com>

The i.MX93 11x11 EVK has a ST LSM6DSO connected to I2C, which a is 6-axis
IMU (inertial measurement unit = accelerometer & gyroscope). So add the
missing parts to the DTS file.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v2 to v3
- remove reduntant address-cell and size-cell
Change from v1 to v2
- update commit message.
- use common node name.
---
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index 2597c5b2eacb4..e845ad896abeb 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -145,6 +145,18 @@ ethphy2: ethernet-phy@2 {
 	};
 };
 
+&lpi2c1 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpi2c1>;
+	status = "okay";
+
+	inertial-meter@6a {
+		compatible = "st,lsm6dso";
+		reg = <0x6a>;
+	};
+};
+
 &lpi2c2 {
 	clock-frequency = <400000>;
 	pinctrl-names = "default", "sleep";
@@ -504,6 +516,13 @@ MX93_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B		0x31e
 		>;
 	};
 
+	pinctrl_lpi2c1: lpi2c1grp {
+		fsl,pins = <
+			MX93_PAD_I2C1_SCL__LPI2C1_SCL			0x40000b9e
+			MX93_PAD_I2C1_SDA__LPI2C1_SDA			0x40000b9e
+		>;
+	};
+
 	pinctrl_lpi2c2: lpi2c2grp {
 		fsl,pins = <
 			MX93_PAD_I2C2_SCL__LPI2C2_SCL			0x40000b9e
-- 
2.34.1


