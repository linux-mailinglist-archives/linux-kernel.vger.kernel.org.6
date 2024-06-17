Return-Path: <linux-kernel+bounces-216657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D170E90A2B2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 05:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B165E1C20D01
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 03:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EF3D2FE;
	Mon, 17 Jun 2024 03:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="S2TkOIif"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2065.outbound.protection.outlook.com [40.107.241.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8B217C21C;
	Mon, 17 Jun 2024 03:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718593376; cv=fail; b=ZJ08UzJSN70Ts5lh8jS/UNQnnn+uBA0kh0zG5cnd4Gi5jkW4Z70viE37Sc3SmIVNxg52cuyIpMVFY0phzgDScJcm1naQ8SkubE9MZ9HpWKoMaA5jbz3EqGfzhQWrH2Em+GhmTwFP40eOTunQoEnxavxODCisgT/q0H5H7Wdtv3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718593376; c=relaxed/simple;
	bh=RwtMNHqVQhRWJJfpFcEo2hap8WCYsBTsEyaB50jut3M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u5XvbihoNT+9cM4KExwEb7rxSVQM/SWK/MUWhtT6H34LPkByCa2LfWbRQq3q7hFFC5opQPzVDjnZrSAxdxvIfJOz1j3tas8SjDWIeNpc1zSliyjE4bBvKcr1JRh3NjLCtcVVBXpcuyYW/v8eBbEeRKKYuO4ToIqzlwPBvzaTngE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=S2TkOIif; arc=fail smtp.client-ip=40.107.241.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUkGWEnQphU1ghBR2aQlXSfrpFXEHC76l6e8FFQ2B/kxofph27GW5spMD8RcmMzRxesKJffFmobhU9XZlaWGazu7PizvRGXvw5FyeOVi/HAmPsSIWSYlg8I9rHBbP7pi0pQy/VNKf813mOfiYip3B0KFmHpGXlZz+mGKoFetHcvXH+GAqa6Tu1uBieMM6JvYe9abb7dpZe0wGNr4a+kCf9WccanVaT+S68nA2Sk9GJA3wFqI6i9Xk5z3wH12cxAU63faf0RJRIwx38o3SD2qwt5opgHvrca6d7JYuSHvljTFHhGauW2o/Ci2yAcNUXF0DU7TZx/q/6XuzMjf9zekCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrBzqh344KqCQPLIzWfcrtgbgGezFpi9rlCpD2/VuHE=;
 b=EGnLq0J9kWBtBPj32tX8SY+E4u6EF+dwWgA8XD/CoQRXDmWE2ImSvTsuSOywbU3fQsYiU5DvZALm+qP1Z5IOPuwExI7sgJcZ1QsveRkp8vzd0GAfxUY4GSXCkFWKuG7o6YVBMm5I+9VW0zNoG1Nt2yOEmtMVrUmuXa+Q+OBmVGP8WH2wHDJoslrjw5bawT7BNG0+G5BVOHSRiN2AY7a1TyPabDJ/B2JLqGN9uckgqgpdePqWxWF3zwSorF4dOAc9WCpE50+w04ezfPKlJ1GB7N43vYHTQY8js2Yrwm79FLp2WkALbT7nDoJS9Y3QQzP0F/RWvFKmcAIBCOBZUxmTEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrBzqh344KqCQPLIzWfcrtgbgGezFpi9rlCpD2/VuHE=;
 b=S2TkOIifgWu+WCAzb9CsPa2Y7VrHTvOcAvxzaRHoSCmCbQ2C52Em0bpW/xqfTWnS59u0+rQ2AbrGGTuFVC5ZFzrD1Rc4rdtIh0ml+E2CTMaEHsRBh4OzaYiuZErir3fsdnf7gHeS/x9ljKDv8dnutlpkNd/2BRA2LXWvc2aDlo0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by VI0PR04MB10438.eurprd04.prod.outlook.com (2603:10a6:800:21b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 03:02:51 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 03:02:51 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 2/2] arm64: dts: freescale: Support i.MX93 9x9 Quick Start Board
Date: Mon, 17 Jun 2024 11:11:45 +0800
Message-Id: <20240617031145.20057-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240617031145.20057-1-peng.fan@oss.nxp.com>
References: <20240617031145.20057-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::16)
 To AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5941:EE_|VI0PR04MB10438:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f7dbf2d-b031-4992-7eff-08dc8e79f9ee
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|1800799021|52116011|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GH/8k2hbYDmKjNKE2pXs6lk7aXDMcXNDVu6RytoQYIc7ttBdjcjWTsMYvWxu?=
 =?us-ascii?Q?zwtWa4l+CUSlT4t+Uq8sE2tD2oD0FM72cQwP8w1cIMqfUSrqmANv2DjQZnya?=
 =?us-ascii?Q?nD6fIL0CGcXHFU+O8ysOdwT9pqhV05OzTKHi7FuqzTzAVjTfnW83bCXNtXGJ?=
 =?us-ascii?Q?tIFaYf72Tptb3UXVquoZQekFMrKzxZ64YLEE8AgpEsULElnLXTKxz3B37Z4H?=
 =?us-ascii?Q?niIuycUzslWoka8CDVmuUOEGg2zM4oczyk9XaA9upjd7BePb244lprCZwryd?=
 =?us-ascii?Q?RtelTa8DqlfPbdcGYzH2XPfTEYlxKt+SfcZt/C3/MuBggj1K0udKRt0sRPl5?=
 =?us-ascii?Q?wGTmGSDLOErbthvxZoCiRcbsij4uzrgrzc+aDAvRFSsk2RmB2oUrlYEGGSr1?=
 =?us-ascii?Q?nnvFckurLmxa0AAhAZjkGJM+Pve+XU/RYnfDAjCTwzQJZwsA0zMEQC2yEnVd?=
 =?us-ascii?Q?q+oSG44vnI2kngzFyTkhJD2BkaNYALmRIVyt636N/eecFy67YhqVuhYZWrrN?=
 =?us-ascii?Q?UkM9eYklcfI8Fxwum/03i6wYAUcLLEqZ92PlGX6XuXM5F7D5G7XA2+IIRk1X?=
 =?us-ascii?Q?Efebu8KvN0HCAvBhEzbeEevfIF3fgeK9uEOMbB31m4O26GHBnmgdyGDvkJ22?=
 =?us-ascii?Q?JHpma0tGM2Fu3q0J9gbb2Sznhg9bt9Yt1fyqMcuJRhQULX/ejut+ad7mxOcM?=
 =?us-ascii?Q?cQiY0B9+bpwppkTW3i18ae7OoDkCru0KkQ9go/qX34ODZxV4M4/TtzocblaG?=
 =?us-ascii?Q?mRQF8ai1IV7MIfEYjF+CR311jAyXbPbbRRQp2uuxlxEflmtWwI7ZnM6rjBJf?=
 =?us-ascii?Q?00pUvVzsAndCuh62oRUSkANsLCTvcXDvYZsiGdcUcrCFK6dETxQPcrd8yj8j?=
 =?us-ascii?Q?Ec0Sr1yQHkHtuAZq3M5Uq/gJArl4aewX76QnNs59akaFEjPMdk2A83IsEUGm?=
 =?us-ascii?Q?HDq+VuW12tdfspByoBlMb+kHg6kBgtjyPifGrXUThyOFkMjOeX1EfOeDQlie?=
 =?us-ascii?Q?b1FJOqxNg2fLgDfmP9jqF0JbutHGkLllAhiJheXSYPFDDIAolgKdiwD/hki+?=
 =?us-ascii?Q?X82OEfZx2GUJvyjG0tf1uTkml/Knpllvyui+526/Wf9sRU4LWP4VXZ1JBugv?=
 =?us-ascii?Q?BmCIJPy8WLk5RVTA3cRuBraG6RYxrnBHFMyp8kQWrHHjy+3lin0PfiT6moUK?=
 =?us-ascii?Q?K3m0cGavg9KznK/1jo07zJCbQRQ4dMLSs/7A7nH8I3Dq6M4kmm7WLeNKHTiH?=
 =?us-ascii?Q?WuPaop1AdM6ycbxZR742DnuOFqGyKXnTZddyhDEPsnL1A4opczebw/tcR1pm?=
 =?us-ascii?Q?B9rPPlukTe3PMVVkg+StPE+4mVe8JAHZ0pO8Paz2hfmg/gpt8wOTKgc0Dg/k?=
 =?us-ascii?Q?V6iicDw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(52116011)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vWIzasUzjnJ1JyBTEOF5IpufHAAllxAr1gco7dBAJtof+qZ/1hxuic+KTiTy?=
 =?us-ascii?Q?tyGA5B05kBtJupcEqD28zA7zuNYMhGGna+tOJl+sAhuoHfICpp9I1CMN3YaO?=
 =?us-ascii?Q?vq0w60FswDVAqtHIMtOnNX/GwQnga4w/Dbxj/FTrIGdvrFiO3hUb4jOgRUry?=
 =?us-ascii?Q?N9NpIzcEFLUodYKYWJF5376+RNc/ULzUdFAC3pY48pG6H22Q36zXm938CJNg?=
 =?us-ascii?Q?rUDN0MJXp7RL/S6LCBJc1vjgvqrnkSyaAWnJ3WXVGK+Djxv4LkV0Pft7HRo+?=
 =?us-ascii?Q?zKNlwTwDk5tFZttzP/eTEKDEk9LDtLxF0+EcBFnh2+DnUlA5xMn4RYrDlqKk?=
 =?us-ascii?Q?KlKlYFhWumU5NXoN6FboYLLoohXbmqz9mlbJC0RSNEAIbGb2ukC4soWFJX84?=
 =?us-ascii?Q?CDmonzCVXUfyr0+7i27OhJR4qHSjYuKa+5rIbPY1azzT0j2U+SteEdpxJIkF?=
 =?us-ascii?Q?uUI5xUsc5q+STi3TDCWGgJAhGImzDAFCgjaY1lV3/+ei50Ixh1vt7T8EdFoL?=
 =?us-ascii?Q?9SW+xcwQporLiB8PbsZ5TsiRN6QbNkLkBH+y6XQcsO24rcbrgOWjHpQpHolv?=
 =?us-ascii?Q?RCAq1kfLC7/vhNeNr38BmNhqnRxqmrvxcQVAE7vw7n23f5e0EtBDyQG9ALyG?=
 =?us-ascii?Q?OsI49N4dJYCzQdSXUXyWercGbX1LBOp+T4kRqd8siAZJ5svOydCm905EOsWM?=
 =?us-ascii?Q?t3RnwnIQnnOZuYQgkonvVQHkGw5zHkWBfoFlSIl6JYlaXgIfEtMRlGgT5fCV?=
 =?us-ascii?Q?xVcptYTn32d0fEMJQk1yIsCBZ8MrQ2K1EGpGFez/3TbE0D/cvigWGyn0B7wo?=
 =?us-ascii?Q?dpivNjRXs42FEIgsTVO3ZGjQd8pGmB+43/cvhZ6lO3TBg1/Gsr42uCxUIdlb?=
 =?us-ascii?Q?fmnEW+8DaifGjkpdPxcszHbFGDtbAVH+dI+MxgWtPDdplicIROmb8zR6Poru?=
 =?us-ascii?Q?V2qufMeh4+Rm+EwrfY/6ap2npi6MhYKy7SJF4n2JruvI2HVtocbfat+lwzHM?=
 =?us-ascii?Q?u2OwwTNizk6N6k5LbNFypKxLQR4MkZ2x4s8CP4PhgeWQoZBsNRB3Q9gEoUlL?=
 =?us-ascii?Q?uknUtdELRnEajlhy8zbYRBMYObaBNxOXXH1AM8jAgnvuE1XDldwms+qNzfq9?=
 =?us-ascii?Q?zUduq20CzHEpxi9YC9UUjHwLDH10i3RdPHUPi9N4RNLpAXbPgwVuIMJujUJO?=
 =?us-ascii?Q?zneBX6H8F76bIoUJSZfEVyvZiDfGZK7lMClrqcdDoJcMO7Lja6LyGsF8LrsG?=
 =?us-ascii?Q?+Wa1jCpKsEAFh/ONF+eIYWIs+GrXsPSM8xpMv8wCwoXq80oaD8qvckf4ZFKj?=
 =?us-ascii?Q?NahugL3dzJS2mNhJ6EWMCZH0v3iQAFVD1S5Zooi9lQb+mSM2p2vdMY91CVGh?=
 =?us-ascii?Q?mBepj8P8W9U1IMHKdJqc0IzYmxZhqPgZ9VQd5LNsxDbHX10KffQVP1RD3Mf+?=
 =?us-ascii?Q?v210qLC1b6K2Vyq3ZCrSk+pnovFThd3XCk6xtoNRL7lcgz2pZoaksVa37Glm?=
 =?us-ascii?Q?8TCH3ihmEKyBlF8tM3/mfB4DC7nvagTlq9guZaV0CUn6D1ByvOb4sRBFwYjr?=
 =?us-ascii?Q?roXa5Jrk8Ss+NeUQoXshWH9NMi1J8tDVGQUwuPIJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7dbf2d-b031-4992-7eff-08dc8e79f9ee
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 03:02:51.7631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QCJAFS5RX0TXIZDwazzAnv9wxvHySfGZRL/GiMBQ7kO76ifuVnfbCwSxTkL8GS1NvVG3pUz8yVurQOpqt944eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10438

From: Peng Fan <peng.fan@nxp.com>

Add the board device tree with sdhc1/2, cm33, mu, lpuart1, lpi2c1/2,
usb enabled and etc, which to support the i.MX 93 quick start evaluation
kit that provides a low-cost platform to evaluate the i.MX 93 applications
processors in a 9x9mm package.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V3:
 enable-active-high together with gpio property in regulator-usdhc2
 Drop Unneeded okay status
 Drop duplicated mu1, mu2
 put status in the end of usdhc2 node

V2:
 Drop non-sdio per Fabio
 Drop duplicated address-cells/size-cells under lpi2c
 The address/size under port still kept even there is warning when W=1, the
 warning is false alarm.

 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx93-9x9-qsb.dts      | 492 ++++++++++++++++++
 2 files changed, 493 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index c3fef4e4d8dd..d5f1d4b6de4f 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -234,6 +234,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8qxp-colibri-iris-v2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-tqma8xqp-mba8xx.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx93-9x9-qsb.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-11x11-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxca.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
new file mode 100644
index 000000000000..950dece83c24
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
@@ -0,0 +1,492 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
+/*
+ * Copyright 2024 NXP
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/usb/pd.h>
+#include "imx93.dtsi"
+
+/ {
+	model = "NXP i.MX93 9x9 Quick Start Board";
+	compatible = "fsl,imx93-9x9-qsb", "fsl,imx93";
+
+	chosen {
+		stdout-path = &lpuart1;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0 0x10000000>;
+			linux,cma-default;
+		};
+
+		vdev0vring0: vdev0vring0@a4000000 {
+			reg = <0 0xa4000000 0 0x8000>;
+			no-map;
+		};
+
+		vdev0vring1: vdev0vring1@a4008000 {
+			reg = <0 0xa4008000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring0: vdev1vring0@a4010000 {
+			reg = <0 0xa4010000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring1: vdev1vring1@a4018000 {
+			reg = <0 0xa4018000 0 0x8000>;
+			no-map;
+		};
+
+		rsc_table: rsc-table@2021e000 {
+			reg = <0 0x2021e000 0 0x1000>;
+			no-map;
+		};
+
+		vdevbuffer: vdevbuffer@a4020000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0xa4020000 0 0x100000>;
+			no-map;
+		};
+
+	};
+
+	reg_vref_1v8: regulator-adc-vref {
+		compatible = "regulator-fixed";
+		regulator-name = "VREF_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	reg_rpi_3v3: regulator-rpi {
+		compatible = "regulator-fixed";
+		regulator-name = "VDD_RPI_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pcal6524 21 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_usdhc2_vmmc: regulator-usdhc2 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
+		regulator-name = "VSD_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		off-on-delay-us = <12000>;
+	};
+};
+
+&adc1 {
+	vref-supply = <&reg_vref_1v8>;
+	status = "okay";
+};
+
+&cm33 {
+	mbox-names = "tx", "rx", "rxdb";
+	mboxes = <&mu1 0 1>,
+		 <&mu1 1 1>,
+		 <&mu1 3 1>;
+	memory-region = <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>,
+			<&vdev1vring0>, <&vdev1vring1>, <&rsc_table>;
+	status = "okay";
+};
+
+&eqos {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_eqos>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy1>;
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-frequency = <5000000>;
+
+		ethphy1: ethernet-phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <1>;
+			eee-broken-1000t;
+			reset-gpios = <&pcal6524 15 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
+			reset-deassert-us = <80000>;
+			realtek,clkout-disable;
+		};
+	};
+};
+
+&lpi2c1 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpi2c1>;
+	status = "okay";
+
+	ptn5110: tcpc@50 {
+		compatible = "nxp,ptn5110", "tcpci";
+		reg = <0x50>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
+
+		typec1_con: connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			power-role = "dual";
+			data-role = "dual";
+			try-power-role = "sink";
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
+				     PDO_VAR(5000, 20000, 3000)>;
+			op-sink-microwatt = <15000000>;
+			self-powered;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					typec1_dr_sw: endpoint {
+						remote-endpoint = <&usb1_drd_sw>;
+					};
+				};
+			};
+		};
+	};
+
+	rtc@53 {
+		compatible = "nxp,pcf2131";
+		reg = <0x53>;
+		interrupt-parent = <&pcal6524>;
+		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
+	};
+};
+
+&lpi2c2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpi2c2>;
+	status = "okay";
+
+	pcal6524: gpio@22 {
+		compatible = "nxp,pcal6524";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pcal6524>;
+	};
+
+	pmic@25 {
+		compatible = "nxp,pca9451a";
+		reg = <0x25>;
+		interrupt-parent = <&pcal6524>;
+		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
+
+		regulators {
+			buck1: BUCK1 {
+				regulator-name = "BUCK1";
+				regulator-min-microvolt = <650000>;
+				regulator-max-microvolt = <2237500>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck2: BUCK2 {
+				regulator-name = "BUCK2";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <2187500>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck4: BUCK4{
+				regulator-name = "BUCK4";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck5: BUCK5{
+				regulator-name = "BUCK5";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck6: BUCK6 {
+				regulator-name = "BUCK6";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo1: LDO1 {
+				regulator-name = "LDO1";
+				regulator-min-microvolt = <1600000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo4: LDO4 {
+				regulator-name = "LDO4";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo5: LDO5 {
+				regulator-name = "LDO5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
+&lpuart1 { /* console */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&mu1 {
+	status = "okay";
+};
+
+&mu2 {
+	status = "okay";
+};
+
+&usbotg1 {
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	usb-role-switch;
+	disable-over-current;
+	samsung,picophy-pre-emp-curr-control = <3>;
+	samsung,picophy-dc-vol-level-adjust = <7>;
+	status = "okay";
+
+	port {
+		usb1_drd_sw: endpoint {
+			remote-endpoint = <&typec1_dr_sw>;
+		};
+	};
+};
+
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
+	cd-gpios = <&gpio3 0 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	bus-width = <4>;
+	no-mmc;
+	status = "okay";
+};
+
+&wdog3 {
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_eqos: eqosgrp {
+		fsl,pins = <
+			MX93_PAD_ENET1_MDC__ENET_QOS_MDC			0x57e
+			MX93_PAD_ENET1_MDIO__ENET_QOS_MDIO			0x57e
+			MX93_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0			0x57e
+			MX93_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1			0x57e
+			MX93_PAD_ENET1_RD2__ENET_QOS_RGMII_RD2			0x57e
+			MX93_PAD_ENET1_RD3__ENET_QOS_RGMII_RD3			0x57e
+			MX93_PAD_ENET1_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x58e
+			MX93_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL		0x57e
+			MX93_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0			0x57e
+			MX93_PAD_ENET1_TD1__ENET_QOS_RGMII_TD1			0x57e
+			MX93_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2			0x57e
+			MX93_PAD_ENET1_TD3__ENET_QOS_RGMII_TD3			0x57e
+			MX93_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x58e
+			MX93_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL		0x57e
+		>;
+	};
+
+	pinctrl_lpi2c1: lpi2c1grp {
+		fsl,pins = <
+			MX93_PAD_I2C1_SCL__LPI2C1_SCL		0x40000b9e
+			MX93_PAD_I2C1_SDA__LPI2C1_SDA		0x40000b9e
+		>;
+	};
+
+	pinctrl_lpi2c2: lpi2c2grp {
+		fsl,pins = <
+			MX93_PAD_I2C2_SCL__LPI2C2_SCL		0x40000b9e
+			MX93_PAD_I2C2_SDA__LPI2C2_SDA		0x40000b9e
+		>;
+	};
+
+	pinctrl_pcal6524: pcal6524grp {
+		fsl,pins = <
+			MX93_PAD_CCM_CLKO1__GPIO3_IO26		0x31e
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX93_PAD_UART1_RXD__LPUART1_RX		0x31e
+			MX93_PAD_UART1_TXD__LPUART1_TX		0x31e
+		>;
+	};
+
+	pinctrl_uart5: uart5grp {
+		fsl,pins = <
+			MX93_PAD_DAP_TDO_TRACESWO__LPUART5_TX	0x31e
+			MX93_PAD_DAP_TDI__LPUART5_RX		0x31e
+			MX93_PAD_DAP_TMS_SWDIO__LPUART5_RTS_B	0x31e
+			MX93_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B	0x31e
+		>;
+	};
+
+	/* need to config the SION for data and cmd pad, refer to ERR052021 */
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX93_PAD_SD1_CLK__USDHC1_CLK		0x1582
+			MX93_PAD_SD1_CMD__USDHC1_CMD		0x40001382
+			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x40001382
+			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x40001382
+			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x40001382
+			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x40001382
+			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x40001382
+			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x40001382
+			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x40001382
+			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x40001382
+			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x1582
+		>;
+	};
+
+	/* need to config the SION for data and cmd pad, refer to ERR052021 */
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
+		fsl,pins = <
+			MX93_PAD_SD1_CLK__USDHC1_CLK		0x158e
+			MX93_PAD_SD1_CMD__USDHC1_CMD		0x4000138e
+			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x4000138e
+			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x4000138e
+			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x4000138e
+			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x4000138e
+			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x4000138e
+			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x4000138e
+			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x4000138e
+			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x4000138e
+			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x158e
+		>;
+	};
+
+	/* need to config the SION for data and cmd pad, refer to ERR052021 */
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
+		fsl,pins = <
+			MX93_PAD_SD1_CLK__USDHC1_CLK		0x15fe
+			MX93_PAD_SD1_CMD__USDHC1_CMD		0x400013fe
+			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x400013fe
+			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x400013fe
+			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x400013fe
+			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x400013fe
+			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x400013fe
+			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x400013fe
+			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x400013fe
+			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x400013fe
+			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x15fe
+		>;
+	};
+
+	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
+		fsl,pins = <
+			MX93_PAD_SD2_RESET_B__GPIO3_IO07	0x31e
+		>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
+		fsl,pins = <
+			MX93_PAD_SD2_CD_B__GPIO3_IO00		0x31e
+		>;
+	};
+
+	/* need to config the SION for data and cmd pad, refer to ERR052021 */
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX93_PAD_SD2_CLK__USDHC2_CLK		0x1582
+			MX93_PAD_SD2_CMD__USDHC2_CMD		0x40001382
+			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x40001382
+			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x40001382
+			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x40001382
+			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x40001382
+			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
+		>;
+	};
+
+	/* need to config the SION for data and cmd pad, refer to ERR052021 */
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		fsl,pins = <
+			MX93_PAD_SD2_CLK__USDHC2_CLK		0x158e
+			MX93_PAD_SD2_CMD__USDHC2_CMD		0x4000138e
+			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x4000138e
+			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x4000138e
+			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x4000138e
+			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x4000138e
+			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
+		>;
+	};
+
+	/* need to config the SION for data and cmd pad, refer to ERR052021 */
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins = <
+			MX93_PAD_SD2_CLK__USDHC2_CLK		0x15fe
+			MX93_PAD_SD2_CMD__USDHC2_CMD		0x400013fe
+			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x400013fe
+			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x400013fe
+			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x400013fe
+			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x400013fe
+			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
+		>;
+	};
+};
-- 
2.37.1


