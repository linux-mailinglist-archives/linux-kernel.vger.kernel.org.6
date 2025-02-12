Return-Path: <linux-kernel+bounces-510749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C5FA32175
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F0AB3A5382
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3172D205AD9;
	Wed, 12 Feb 2025 08:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HEE+TeAQ"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011032.outbound.protection.outlook.com [52.101.70.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F2F205ACE;
	Wed, 12 Feb 2025 08:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739350296; cv=fail; b=uH2mnPGW8KFIOgBTnfnUIZMrpAKM/xVrbHK6bijN7J+TgO8j2gmGkDdfeSXPb222/CrcyLR++V3IyhSBqOcNS4e+eOXj1x1ii6Vj2Cs1fwKcnZJSS0F738vjvs0sl3M5vr/ga55LC60t8NiOuBXcjCzlWZsmIn4yyqLaRUmHraU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739350296; c=relaxed/simple;
	bh=ZTIgHtfo1Hzh18ywzzTgfsAXlLrLDmAkH0cEiuSIXvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OS1qU4V3juhJiFYzETZiRFiKC8DLJsa+qgID3d5/Bp+KzX4gre+UYfktByAibgFwiQfh3sUJYClj6GouE6j/OnQUONoXvUQZJRk7QVjkbhcs/VBwzCRJ8imsl+ZPfHuOlPBrBoEdO2Q/RACbO3CePIDYRDJKMp/b63mYxbP7RP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HEE+TeAQ; arc=fail smtp.client-ip=52.101.70.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ecz4JvbZQnBmD25dwO6LXfZ5bZohkuXb7eVZeqbDKu/I4Iz7sIF5T3Bx3DN8XyQY0zgoKGq+L4vzeOsw0yc/je5AXR96bW/EM4sc3d6YtIUuXPaOmhzFPiw3E20mV8sMcaOaL6ZBs9b8+T81nqHA16L61gcYRkpalCvCS0V9A00Vz7FOUDCuU85e//tLPRa4KRSCHTE85sIoECpTG9xxLkGEyXXe90GSdxFGtNV6AsKhF5qDICsBbZY8m84JStmHxHVLfYczOr4VdtvN19aPalyxWw8rk14wXRXOedMBaRoHh49p7CpKY3SMOD04Rpc+ikoGFX1sc4hSde4nSpZzfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUf14s6IPUgpxhxjNw0WerozTXYHFMXlf0Il+0ssahs=;
 b=xXp920Si+npuHXwg6LJ/r7NvDXLI3M1CC8KrRyuwwDOADjV5qDeAl5sxUlWCAFHc7sC7yt0dWhdxqc0bz9TtG63NANiLm5xRDAF3fZ7fXmc9aaoTiGI/kzGVmUULKyoJJqHga8qAUma13xzpIy1AiJoOSGthfOKSafzdBdEvuFNwkkrHb/F3oD5AfKjR1doccB78HDaHodNsCYxqkDZMw7pEDwvP3GYBikF1DKKLv8Hd7v8EZa4adSHl2feAGJDq5w3tPiXzkB3HuKkG0++cFJf41LUW23MD8E7jN/3ELnKy5fny9+muJFlW0umYADrQvcZ/BGvUDFAY0pNUcr3kJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUf14s6IPUgpxhxjNw0WerozTXYHFMXlf0Il+0ssahs=;
 b=HEE+TeAQEbmmZDN9sGEpbmqJGkvmOymmkdz5U9D4FnlPj/MpHRC4NWdan/V0vi1Zd7i/W+GSMj9EzZ4zHZbY8N+myqzlrTihMuO8RfmPz4Et+jKlSXg5gnDTFhfXoATndcok6Xl/ycU7RG5EiFFF4sOsA5mK7chqet30hXX+ztI6mdzYMlamWPu/oJhPyhAkD9DciUgMbjs0vo7XoUfskfAIt3n2MuBRTwkynpkjrsCPmj45MES76Kax8o+OKIrcGJZq7/oUn2ajIq0LqSWhZwTqI8llr05A3o0AWWlgtlMOXcEgeTXh8vwWsXuR9VRpBYFCHLwhuIKexoQaRLsh0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::13)
 by AS4PR04MB9576.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Wed, 12 Feb
 2025 08:51:31 +0000
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6]) by AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6%4]) with mapi id 15.20.8445.013; Wed, 12 Feb 2025
 08:51:30 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: shawnguo@kernel.org,
	robh@kernel.org
Cc: s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	festevam@gmail.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	frank.li@nxp.com,
	aisheng.dong@nxp.com,
	daniel.baluta@gmail.com,
	laurentiu.mihalcea@nxp.com,
	shengjiu.wang@nxp.com,
	iuliana.prodan@nxp.com,
	a.fatoum@pengutronix.de,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v4 1/6] arm64: dts: imx8mp: Add mu2 root clock
Date: Wed, 12 Feb 2025 10:52:17 +0200
Message-ID: <20250212085222.107102-2-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212085222.107102-1-daniel.baluta@nxp.com>
References: <20250212085222.107102-1-daniel.baluta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0003.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::9) To AS8PR04MB8247.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8247:EE_|AS4PR04MB9576:EE_
X-MS-Office365-Filtering-Correlation-Id: 023d3701-d9bd-431f-8b32-08dd4b4271c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hxqXLBy937JVQmTQnWfYlFxQPvlsZFDjv4vl/S72iFBCya25ZiU8Eqa/4wEh?=
 =?us-ascii?Q?rrKATYt2yUF+JJhcI7c+KI0vzfbf7Lfhv+bMwurIc0dgZQMuw5SfBZgeqXru?=
 =?us-ascii?Q?sZTwjG8ZpkgUMaEQdTdZtnIcKXL2qggOUljwxoNSa+zJZdxIJ4KbSFJbkJgG?=
 =?us-ascii?Q?MsA3kzabzeekFHNSZOdMFzPSrQogHl3SCaet+UWJRN+WpTQGfIYSio9izDeM?=
 =?us-ascii?Q?XQ9SqtBENRJq2o3Ndevvw91V3A2OEvOkGh0yrDunzAPC/EEyiFFKs+8mACuL?=
 =?us-ascii?Q?tq87UaKXSz2HZ701KujlAu4eCNUHOyhasiFpqecdr8WuiTh/v+HYQ+PD7gmF?=
 =?us-ascii?Q?COS0S2UZjUpGF3eEBXMiHQHe1L6zKYi8kqnc8wcgPtoqJjCXeajYHMGRB+IQ?=
 =?us-ascii?Q?YALtCQxx3HCWKx1vFL2GjxUxfX70dWjPM631tLwKNBBCV4tKkP7hT+j9Va47?=
 =?us-ascii?Q?FTzFiNFJDegrmFj9XSZ8ZhXbhRw3M9pQ6FG3zk43qWXY7OFmRqidsYQ6oYGM?=
 =?us-ascii?Q?joByyOiPlenRoB/taLW3RsrHllEXZc9MbqDOBRGYc72YymsWl3FjQreGUqzV?=
 =?us-ascii?Q?EejqI9EUo6Dsf4PK+/DeDRDAc17gXVEN5T83t5xItxrBSqgnmQUKCdKsTTZo?=
 =?us-ascii?Q?7EkC3h6VX6DlXWMBc4wQe7/pBo47uiHliGleDiwH2/2aN0xZfFp6tgbDbTCP?=
 =?us-ascii?Q?LyxuJpD9dtwJTZ5nMJm6Pu3FgShlOpM5rsF8nSAxz+DTdKEW+Puz0Vlt16ho?=
 =?us-ascii?Q?HWF17jjJoWSpWVKDEmSEOOHM6RtsjAR+atpt90wEQZcbafqeU18ze51N/F+I?=
 =?us-ascii?Q?QKTeCZbOpR3QPfwP1e3Fk6T9l8Sx6aMxOi9KVnEVngUvIUmfbxxXzFf/P9xk?=
 =?us-ascii?Q?P4QAvRr/XwlHqqgVnnmPe1+97eIS+osURBPmEnD43L99CdHw9+o4/LIXvvQe?=
 =?us-ascii?Q?fFleT3fh/tl/U1FZf1Xln9HWu2P6hXq6CO4wnim39tK68gTli1utXYaTUYRr?=
 =?us-ascii?Q?OeePVUuS9Qa5UFG4O2D9CT4dovrqZ69xLRNv1SVXtAJvs7dr9Ht3V0SFK1Nl?=
 =?us-ascii?Q?JGNIUFHWqaoLHeazuPA6DDsG1wMkPWIBjA0E5H+a/F5ltsERJdbRLGL2oXMY?=
 =?us-ascii?Q?3ThyiAgTP+awyvC9KvzEEq2Q+3V8b0HpxgkE0kNf2aIJsDM6WAFQfznY8j73?=
 =?us-ascii?Q?feL4oA94SVZvyxb6Hjx28Ad+IAlBbM81L68WaaP0BLoFQEyp22tOgGpjA39j?=
 =?us-ascii?Q?a2BsGIs4m44gc5+s98mpY75UQM5rZR7ZOYn2wsrrWoPHbcNaG6TLqjU40qTO?=
 =?us-ascii?Q?qwA4DDMDHMpW/jFaoQZCJnGVVKXCB9anlI7yeQ/mMgfkjdyBTW40VMMP01ZC?=
 =?us-ascii?Q?24XlW4PToPLHxUGwczTaYBGAOTRhqoypBJGEaIEWDZGt/Y9NbktkSc2JYq2G?=
 =?us-ascii?Q?NrUe8u85LGpzwM+wz4iHL+VLjbENmN4G?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8247.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p06jVmJXI2Wb0mU03He85sU35jH+ImU93rd3zNRFEcfJ725qvxSrzKFPESkd?=
 =?us-ascii?Q?0Gz+5UH1uSGYp4z51r24BMlswhJ25fx21Dk36ShhYlCPheLwBCc5hhe7+6Zp?=
 =?us-ascii?Q?mcr5jJbB9kUJOU96IlojSeWxJWAg/DK+ujcrUXhxTPpUSCMkwqroEaMNSDTr?=
 =?us-ascii?Q?zy7JOjEKQwoCzGM/4XKnvhzKT66o9W0sO8q5/z66pjmxxc4zy6kJYz8hVZBI?=
 =?us-ascii?Q?/7SfpJFhehiwCt2Z0qbnIAut3T6Tml5lDRhWMonN3WRQHp4GZEhvLl+KNRBg?=
 =?us-ascii?Q?ZNrh6ae5r4+390pFwcRx0LeEYUwybhHv73pnWelQbyW9UwP9cRRQSPz8LaMv?=
 =?us-ascii?Q?EebveLHncCOLllgHmw7smH6bCBP1WujmdURliXGzC3+rtlyTaOROOm6++AGF?=
 =?us-ascii?Q?im45o2lXGOO13BW2DO+MK/DoqDKaTVWpbVtp9kvfao9hup8rB9efZmoc10vL?=
 =?us-ascii?Q?ZuyzQcMkLf17h2SSFutfJRwtZ/XfR4TkrkFclkECvjB8RvbOfQ8aTTIpQ8zm?=
 =?us-ascii?Q?GjzpucH/ZVDv1juXi+Mpcr/Z4RzrWyKZhIPhJZ1ohflrbFwqDCF+dXP1sXUF?=
 =?us-ascii?Q?DgbJXBFqB3GNGAOhZpq/Q0Ku/wwo+5F4J+Wu5PXN0+s/JiYD6ZuNVfACpued?=
 =?us-ascii?Q?wEKk5LKpdmnyerLSxQJs8ZA6zMxmHXzCYMJgPh35J4rKDtzZlp/Oy+32sYXM?=
 =?us-ascii?Q?54v1WgaqYx+P9mNYZggGCssm5NMhjWA3muvnFtUWzthgUrxSkk37g8YfwR9x?=
 =?us-ascii?Q?vMTcb1lshT1Ou5/QVv6cbpMqKIglfKDCGipW2KKuYjUhSIbZsL1VJihnJlQZ?=
 =?us-ascii?Q?fFLlwbRgW9cpFavybzvo8TqP0LxOElefVZggXoO9M0UsrdWUG3bNCeDHhIjs?=
 =?us-ascii?Q?qWwRdo9K81XS4WfW34upl42iCBW8yPDabsvvngpEBIvEy53yG/hi83dvdRYv?=
 =?us-ascii?Q?glGsco3M4JDe7361FCpahhh9Bt1+O+Qyu1lai7ti7iTnV15zIWCstWG2dG7V?=
 =?us-ascii?Q?qFAGU82+31Psu69Klb5yvjwHiNm5attvrC06XKtlG953ldYxzq1uiKmkv5xZ?=
 =?us-ascii?Q?4CTjQGDOdHbyw/hMz6djOAl26qwbLRRN4qDrEY3CiQy6FF2Qv5+L4f3TQkno?=
 =?us-ascii?Q?AjMRYEFLR3ylgLuhd1eeSTzg1AWLWKU8/zKcg1/5WW1iBM3AR/uI4E/0CDRW?=
 =?us-ascii?Q?pXE7zxmlPfWc8pdTok41hT9LfIHtnBmzpxJdsSob2MiDFDCsuywqu15Ihtvo?=
 =?us-ascii?Q?PPMfLIt/UyrU9Fb2r3XE6++2vQDaTExHSMIDO91DcZ+555UUGTZbaHwmaf9G?=
 =?us-ascii?Q?o8ZWjP6SwCrK/0wTsfYDkEqYZWoVr4gwag94HXyCHZYPB2XNxf/+P3SNiY0Q?=
 =?us-ascii?Q?lVMlXtREbuL7pYHsk4UkkP3YKIAm4ZY7zRwTLXrUG2i4CKGzA8RZEYGls8vf?=
 =?us-ascii?Q?NK+U809ROL5XY+LqVzbjf5B1yLjkgXPaNDZqtx+CeRNYtkx6wFIdUByQbJTH?=
 =?us-ascii?Q?Gxa6kdABleaFU8B/42mMThdqJJVBS4bAxvYbMwHnPB1QddzQI66wPnNFNL+8?=
 =?us-ascii?Q?mGxftZni4jgNFxn4CtzjiF8Grl6tmdFvLAZL2Bke?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 023d3701-d9bd-431f-8b32-08dd4b4271c9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8247.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 08:51:30.8633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jFh8x/3JUVMPMybv2aMhoUUStE4gf+2GolIclVUk9c1LCI41Ev3Ow4H2gE7ySSBXlHRTIB5J6P63UWuNiFBSqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9576

Enable MU2 node and add mu2 root clock.
MU2 is used to communicate with DSP core.

Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index e0d3b8cba221..00924e0836db 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1252,7 +1252,7 @@ mu2: mailbox@30e60000 {
 				reg = <0x30e60000 0x10000>;
 				interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
 				#mbox-cells = <2>;
-				status = "disabled";
+				clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_MU2_ROOT>;
 			};
 
 			i2c5: i2c@30ad0000 {
-- 
2.43.0


