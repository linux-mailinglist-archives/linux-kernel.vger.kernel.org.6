Return-Path: <linux-kernel+bounces-317931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D328396E5AD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 00:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87AB21F24144
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 22:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194B61B6552;
	Thu,  5 Sep 2024 22:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UIeRQDbG"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2048.outbound.protection.outlook.com [40.107.241.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D89B19EEC8;
	Thu,  5 Sep 2024 22:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725574243; cv=fail; b=VThoItHp0i482jOJNVfOWXkCk4qFO52kfBkCGdKACAK0AbNSTI/A3i4NPK7PKYr6h96aA0vdK7VE6ZE29HpkQxNrwcw+8h4+9QfJF19y6pP1Igg0qzUjonXjRtVTVlwiGplfojhrKIFV8y13dD9QKTutPfpb5kYxFO3ujXszv8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725574243; c=relaxed/simple;
	bh=XL7Qg1dI48svMJz8B1VBnk4DZzBlj0y+D50zjXBlCS4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tmAhQ6FSgDzDeqiTItneZPdK8olM/JfMgg4DoMNBRhzp0cvH2ykvM9dLoq7QPJw4WbYlodHRjvC8B4W0rz4JnEdg3es2DbRms7EMt86ZKrkEsw4pl4CRFUZ171eBkpxWqegPn0VSgTndabT4ge/NtrvoJk4W000bkCHq4OIpWrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UIeRQDbG; arc=fail smtp.client-ip=40.107.241.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S/DIOgJIiBFgMGtFqk8nZymCY3XF3Mgk2OT8cdDWSpnMCYq4+qq4+83gdRJXoqlKqoIznl5hBAaoAUrR93OfGJ6NWrSHuhyc1XIvfBgJcprUVuIsj7E6/2mD1BdyPQ5M7x2oB4fCRyrZf2zI6RWwq5+ZgTwwT4O8x1rkA53HPJPOlmZ0zeScz/rklW5jtWTNm8f0lkNFXtMiCp3zwjpbx6BwNsbTcuVSKWssHxZ/2DbcSsyxOtOoDGbYSKp67d3nS/FbPbf3kBqlQEdryQTbFkmRVDlSnH4Va6teDG1eol1AyDzSAq5TQCyAJEztsJrATR5jIbMfq9613p1lKtdpQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tb+bx446XLoxss8DGaUlAJZE8tYWpxRHGo/z+6KSJys=;
 b=liWOm0DkuEc3KdjRo1ZMbWwVyc7Y9przF85SEASX3pde19LUTN+JAM3Qn0qLRIOpsI8X+9CoILDDVotMVlncWwPsHf94djVKI/G13TeJhIRZ+ELBVM3kjHgVs16naxsMeYaelsQjohiIMnLOUYOfN6tSydJBvrh2VntvCcppqGFcbIadBq1v+bqugYMMWYgIjO0caIEp7/PYiDR+0qiMtIMI74qpMFjaZXAwcLugMLHtd3aVT3+V6XtjB0HGpZD2tKTd1m3q/0vTMr4djg1tvmwGHWZK3nUoo6onWYJ+NSRnYRoF5wsCbhMoVfipRlHZpgXEn/2iUOJjrB1t21EGRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tb+bx446XLoxss8DGaUlAJZE8tYWpxRHGo/z+6KSJys=;
 b=UIeRQDbGsqaS5gjcIB1kmw1oeDccLmwplIjT0S/E2a4qFJT9wF79ui7SwriHmPpoK7yd6p3QnVjV/gVBR8EzxP510nc1UJx5LqXA3h/pJDEQkkYfMkcsRZdd0rvCSPMvcyjEWj430gAiICIBaO/DbBsKsB6R3nPv1F3jruQZ4wg0TNZwLGs3hQgVL6j5uBd0I4zZBT7JmsPHpWjl6zCQxBNPeB9MCigoui6//1jql7x2PTR+BI5vJSTy//yfPgMRQF60JuBpbRiEK6VjitNhatGNRe7ZgBgtoTZrW2KGcZNz2BJZWWLYOpvzxuCZWVuoI7uORtg+YUL34LkfECGH7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8959.eurprd04.prod.outlook.com (2603:10a6:102:20e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 22:10:36 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 22:10:36 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] arm64: dts: imx93-9x9-qsb: add I3C overlay file
Date: Thu,  5 Sep 2024 18:10:19 -0400
Message-Id: <20240905221020.2159230-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0008.namprd10.prod.outlook.com
 (2603:10b6:a03:255::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8959:EE_
X-MS-Office365-Filtering-Correlation-Id: 12aa5864-fdfa-40f9-0c6c-08dccdf79159
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xbt2SH0jBGD1OKvHd+ynMXt9qBUAuUyLYreEtTMf+N1Nku5MgWlT3PJAGv1M?=
 =?us-ascii?Q?Nx0ZjSMXENIohJbLatTYzfjhMau3gU6G713C9zzjL70h2uK5XfAoxVR70v13?=
 =?us-ascii?Q?A308AhHc/MKycGZQDg5U64DyxCzi5IbX4SHu5T/BWz3t/l2qDCSHhns7/8GE?=
 =?us-ascii?Q?agAQIhTpMfGfq0jrFbQuxmQkC3ANdEZzUH10lCLo5L5+4ztc+r2fhAlYqw2L?=
 =?us-ascii?Q?bFv/cZIogx9WpsSLXfNAHKmVqBWpi5y5PurhlrGGAANigqLxYs3ZNYPGNEFw?=
 =?us-ascii?Q?mKZELtzKKdnQ6LOL67i95mDuwclCNUv1PQjjC8g/rWFV6AuNA13ZLqsz7M6b?=
 =?us-ascii?Q?oRG66+2lc2u1PXNlACXH2yGP0iP3N/CoCE7evS/HKFhuiZLdFWzMyRwxUE3k?=
 =?us-ascii?Q?NrelRo5W5cfeP/N2xJRdMQcRqJRQE8d8SJVGq741loQ9tsde3wpHxMGIfxjr?=
 =?us-ascii?Q?COQ4jsp4xu05FloTbbwFXJKPQHO9dOOt1Z/H8eyy74LfEPtlExKGG16J0t8s?=
 =?us-ascii?Q?UpBSNwJM65pcicsppn043Mw8yie2czkzHN2IkbtkHHhRPxSGKXYr8gFRsYuq?=
 =?us-ascii?Q?YdroYiywRlOxST8187QxcvEW6ovZiXmXw64e4l1M1cma5YY752jvb3Ee9owR?=
 =?us-ascii?Q?/5RyHBW/HlYjYpF421WS1FfEcr9WimpxAweCBNi1UWmsuvUDpBwNytVE7pLt?=
 =?us-ascii?Q?m0/6CmSnpHYzt65dGeq6IV6taM89cxES6jdxguv+jR0K1NNShFRJ4vDOgPQH?=
 =?us-ascii?Q?6513FTbIBjMwRbKKGi7Ey0ZkcyayHL6+4Io4Lg6KYvZc/qC7klr2N989v22/?=
 =?us-ascii?Q?+xk2c3LvuUFNE9mXC8Bs5t+YKzePSBzMFfJLl7xCbL95SScAN2hSETycMDJc?=
 =?us-ascii?Q?s3blqwLEj+7W93Eb5PzqonMmGaOo2lNiGKe2k1bXZnjae0K+I1eyD1i7A3qp?=
 =?us-ascii?Q?RjtFTO7ZNHKmmt43bpgwjkg/3JZd4E82W+e0//aZISZzn28dM1DSHh+yp2T3?=
 =?us-ascii?Q?/JiURqmQ/dRmMQzvC1T/bIH3FTFIr8Ov6Y9T/Co1dZXzpmim0qR7/TElo5+H?=
 =?us-ascii?Q?4F22/FAs0kJVOFHo+WmLcQuJZAEbk7RYQLf9sF9OUdmud+kOHk2tZ2jxXOO1?=
 =?us-ascii?Q?FFXtjj+mNgPBwKG8E2v6V2MA5YkqvetrvBv7XXyCAhFmyMpdtQYBOI6DJ8Dw?=
 =?us-ascii?Q?WWHryQtLSj6wbwSQJXv6mUaEGEm5jVzX36nS/n8qTRWV76cpFhUD85qTRwi8?=
 =?us-ascii?Q?3tHxf/nCVVX2zdBztCd6XWzMsxkepdgJ9pqTkNfxC81qhd0dxmTHI3jvXYRh?=
 =?us-ascii?Q?WG22vUKhRv5jvkeRnRQAnThMYfR+FQ3PBLRGoMh6sD3FRRQmtgopkD18wpCZ?=
 =?us-ascii?Q?k5A2Va3WH5F2JfYT/shMzHITtLUDANNLrY1tO/TxA+Ulr/4RVjnk6GcxcBTZ?=
 =?us-ascii?Q?fIZ7vK/zhSM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CYLi4mFOSIugTS73lzphBO1L46OTn1y7geeK6ewQZ9fNdMuV4j8V1PQwepmd?=
 =?us-ascii?Q?ANFCUYtuD0gOLkdEJekHpmoSE36ccWneuNBJwR8f6PParbjRILzeSfQOckdU?=
 =?us-ascii?Q?EVVfHbCf4oo1hHycb5TPNfBa/ZoJx0lR1wnj+usMvBP74TpCcHH0Inh9yQbH?=
 =?us-ascii?Q?LZf+3SG824wvA8JUAAgPFNryezvQJuxVsCVR1Q38PZGUjxy/I1J2F/SQRKU7?=
 =?us-ascii?Q?cwqlOWWQ2yRrPTSZ3MiWTwH2T8bNstXWELW+bOQoB1XA/DZovApk0K24qoOn?=
 =?us-ascii?Q?ESKUVzm5N9/a02wPM0kMXDRHCHTmfV3s6WGkjCN0VHpNCUq/5xg1NcZKXMV2?=
 =?us-ascii?Q?O+DYu4wt9Ycn1FpVkqFWl5iKgSorEmQ3iMeZIn9do1+oI3JigQO6NmmMRtCJ?=
 =?us-ascii?Q?ltTq8HJxg60e6YO87mCRFPL/E11CXnvtN3gTYJMdVkBu7gNxUOyzeeB87vKI?=
 =?us-ascii?Q?SnNZ6XUGzy6kdt3UVTbdfg8WjAw0tutPV54kDsiiNW3TGdOaNRsXRMEqT3rs?=
 =?us-ascii?Q?NNFsiyQkyZQ4t2VQQh+A6Qz1QrU2ArX8A7vfFPkQnq4UojJcbRSlYovHZKF7?=
 =?us-ascii?Q?KXoBkdHUK54+cVZbZtTYw2ac6VHD7WQ99QHoUmfOBIOnfvciRFWGBxi4LKfm?=
 =?us-ascii?Q?nSzIxDwIv4l18haej05Zjc/F77deUj28gb6EF/s7/ZoR7EmoTsVqv80ewYgq?=
 =?us-ascii?Q?fbx59bzgD3ahNDV/4tCvLMqQfbK8Q4fLXj+M6YjDv6jZGPSjYpljC+ryzGE0?=
 =?us-ascii?Q?YExZxYmRwbAiUCTtJbwU1WDmHoTuWQnSMYDo8MkNMrrqHDFGMZB5YFGvug8g?=
 =?us-ascii?Q?Ftmthz/J/GQBWvcXqd6u62eVU7++Rww19u6vx8MKtm6qJWsfKtxV8lzheK00?=
 =?us-ascii?Q?5WWcVfAftFk99Ke28yW4NdhLv4/eOjDqoG2Kz1ch9cJJQX9fUJUU2zvfE4KL?=
 =?us-ascii?Q?WClOhmWiJjoIRA/va10cBeZDIbjByTSm+Pi4jYdw2kQYHjxRvXrUNYe5j8Hm?=
 =?us-ascii?Q?1GDuREH3UaS4g+eihKaFL1wGh5rslsxO9NjS8axZfz495UuJONUnN4/t3qsF?=
 =?us-ascii?Q?l5Iy5jqmEdSBfCBMdjKd7Yg3ulGI6UMQHX8TDuFTtKHcrJtvDx7vC7/dIvO3?=
 =?us-ascii?Q?ZIeZRsXKAtHxjurxY9wOsxvkUNhW48fIHuOQKkqk4x7tZrddBWP0VuZVayw9?=
 =?us-ascii?Q?KqzGRtOAOemSKjUpIolhOdRnyMDOhXEL0PrR03woAeQXNVB5yZ4j5TwbK1sd?=
 =?us-ascii?Q?9sohXKR1YhitW6fsW8+w8OQRnh72qhBlQq2ezN7xG/+ducrbEFKy/RvSrxLZ?=
 =?us-ascii?Q?2Hd8n1ZiWB/oZVjf48iirA2rqZeitc8Ag5Qyg5AELa4E1VeIyWZyd7jtfttv?=
 =?us-ascii?Q?rvpMm00FXFUpf1amhEU+ML3JESJb37Tt+QqmQCErMa540ykfz4yXzO4Atd2V?=
 =?us-ascii?Q?p6l1tXhQq8AZ6X9qcYgIWOsgISlt+uuQLw28Ozap67QR4+gvAc9sBc71xtkk?=
 =?us-ascii?Q?rsw9gRPV7dwa5DnWRamfNjQ79p6VJReVWjiQX9USFXD/WaZW8u+IdDGOVU6J?=
 =?us-ascii?Q?FfFfx2Hg4LDGVz0EGX0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12aa5864-fdfa-40f9-0c6c-08dccdf79159
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 22:10:36.1438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z8vsDDnV4BI2Z0ZMq+vKq+x9in7arh58vn2aJmg62MJHzVGazqUmSuTQdB4UOEHQxi0Sb3n7kKDKMC5Eis5AIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8959

Add an overlay file to enable I3C support on the i.MX93, replacing I2C1
with I3C. I3C is compatible with I2C, but it has not yet been enabled in
arm64's defconfig. This overlay allows users to conveniently utilize I3C
on the imx93-9x9-qsb platform until I3C and its driver become more mature
and ready for full switch to I3C.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |  4 +
 .../boot/dts/freescale/imx93-9x9-qsb-i3c.dtso | 73 +++++++++++++++++++
 2 files changed, 77 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-9x9-qsb-i3c.dtso

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 9d3df8b218a2e..032f07adc0c53 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -240,6 +240,10 @@ dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-tqma8xqp-mba8xx.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-9x9-qsb.dtb
+
+imx93-9x9-qsb-i3c-dtbs += imx93-9x9-qsb.dtb imx93-9x9-qsb-i3c.dtbo
+dtb-$(CONFIG_ARCH_MXC) += imx93-9x9-qsb-i3c.dtb
+
 dtb-$(CONFIG_ARCH_MXC) += imx93-11x11-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-14x14-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-kontron-bl-osm-s.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb-i3c.dtso b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb-i3c.dtso
new file mode 100644
index 0000000000000..94d562fa8077d
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb-i3c.dtso
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2022 NXP
+ */
+
+#include <dt-bindings/clock/imx93-clock.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/i3c/i3c.h>
+#include <dt-bindings/usb/pd.h>
+
+#include "imx93-pinfunc.h"
+
+/dts-v1/;
+/plugin/;
+
+&lpi2c1 {
+	status = "disabled";
+};
+
+&i3c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i3c1>;
+	#address-cells = <3>;
+	#size-cells = <0>;
+	i2c-scl-hz = <400000>;
+	status = "okay";
+
+	tcpc@50 {
+		compatible = "nxp,ptn5110", "tcpci";
+		reg = <0x50 0x00 (I2C_FM | I2C_NO_FILTER_LOW_FREQUENCY)>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
+
+		connector {
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
+};
+
+&usb1_drd_sw {
+	remote-endpoint = <&typec1_dr_sw>;
+};
+
+&iomuxc {
+	pinctrl_i3c1: i3c1grp {
+		fsl,pins = <
+			MX93_PAD_I2C1_SCL__I3C1_SCL	0x40000186
+			MX93_PAD_I2C1_SDA__I3C1_SDA	0x40000186
+		>;
+	};
+};
-- 
2.34.1


