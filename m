Return-Path: <linux-kernel+bounces-369262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEE39A1AFD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D02AD2857F6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 06:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277991AD401;
	Thu, 17 Oct 2024 06:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dDVr9pSz"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2062.outbound.protection.outlook.com [40.107.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325901AC441;
	Thu, 17 Oct 2024 06:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729147865; cv=fail; b=lyqZajuD08KmzjkkwAu4jcXxWQU9r3j9exaHzdYQjlW2hj4IoVo7EUFBskZgqYny+Yr+Olyn7FCOJDrYYcgF504FU9nLyReC2ZZ1YUOIPcDqVCqu/rY3wC24n4onIHHwF5rtbCc4A+SC5ACGQ5TI3eC1GbSmow3BtlB5j9rbdZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729147865; c=relaxed/simple;
	bh=SOzvdyKWHGf31VXtnMq6Sftwvo/HgydN3PDdAzfMGj0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=XJ6r6WZx/lEpldpKzpYmFVamplkU4Dn8Saows6P2uBlVNsBDhXFe1GHZ4p5XTGkqR22LDN/+0sQTuh2SNlh0pUFT3tjDLqhgglPftCbc0MVi70WyuraVlNnvDcleBB09xgSlDFPW8L6ka0FDexxdOcNpgO/x//RzeY5kY/0a68s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dDVr9pSz; arc=fail smtp.client-ip=40.107.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DBK4zUYY/l9+BabR4SSruDsbgEpQYYIr4bIpx5+KvBI4e/WGcC8VucwKsxL6O2qmKegYXfvPrzUxFcayiSXrJWm01Tantxg8SV12Cf1HIWQC2G5rS89I/jna5se6+gpyQvXe5yCDh2itkO3SZHvQGD8Nh5jDCPrU+ppG6btitUqRnd9F09tUiIqCq6ETJizS3SduGxzLNQ1m8pyOE16mWCw9qQ/Rw6k8owYD21w69V6YtMu1seHR1ir7h3UewQCWHnoLeJnI1K1r3GjdGgJcA0G3Vm7hYj/+bLxCYiCLufd7TdFDR3DTCz6wyIt3WpKMCg7AtZlYx/ZHp1QCx2OFIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QR3ZMPLNsUbtYadLBv71NnLTBwpW7PdZH2OQgm2N3R8=;
 b=Vw/5YloOwarIThmcLJm4mZ7QDf3AXWrDXk8AX6zXwy3DauKk79PJJ6PSTdvXqanyQiPlHUniLvPJ8V9i2VurYOcMQk+P84fWs6a0D6DwcRd4VJ6IvbkBeu3R4BKx5rNJt67Zn5rJuZJ0FTc3TS6q19FP3VNLgsBWqXmYOt04GOoY/z8IJvq7waEJ8OWui734L6lyjOUvuuHGETS8/lxkdGoWyodfr/xiJMR0aVumYYFyFPvcG1uwsZNFI6mlTEa9pzGBzEGJ3GHsau46iHaHp9VBG7gNqbUiqRWEpYVO75BhRnG6QBP4eMZ//Bxi9F1mcHmELkKSZ01vHTZ8FIY09g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QR3ZMPLNsUbtYadLBv71NnLTBwpW7PdZH2OQgm2N3R8=;
 b=dDVr9pSzjKUXok4qcaqX6c3BdqnZe5qV4YAhXFAeVZ8/2v91fhCWGSzqsqQ61ZXTffmK4yAgN3N+qYs0/yIG6QLGOsusD9xEuhxBB3cPWU3rkJBF6bi8SiuVtYnOvaSqT1aiGNn0BzIa2sNZi9ERMWf6OowjjdWdkO6kobUcY0wW7sI+cMboKGH/gXCPAI2OuBl3UReQqNrFkNlbwmD62vjOdFRhZCSLhqxa7ZEXHZGjW3Q5ygbxTMyG2DCS/R9hOU4UeCBxd1Ht2qcuZO1Y7q/paZ4t3XQ/CFqVfvJ4WrlQnatsBIi4bhWBcq2QuN75oOAT/D2bNk+DQt/tDdZtxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by VI2PR04MB10148.eurprd04.prod.outlook.com (2603:10a6:800:224::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Thu, 17 Oct
 2024 06:50:59 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%6]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 06:50:59 +0000
From: Pengfei Li <pengfei.li_1@nxp.com>
To: krzk+dt@kernel.org,
	robh@kernel.org,
	abelvesa@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	ping.bai@nxp.com,
	ye.li@nxp.com,
	peng.fan@nxp.com,
	aisheng.dong@nxp.com,
	frank.li@nxp.com
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/4] Add iMX91 clock driver support
Date: Thu, 17 Oct 2024 15:51:33 -0700
Message-Id: <20241017225137.1158924-1-pengfei.li_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0042.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::11)
 To DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|VI2PR04MB10148:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f0d6464-27ba-4a29-9ed3-08dcee780ecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F/Ow6cNbu9o84vkqx4mUfvil2sQLlZfZerCvBLiohnz/BkPbHNMFDG9iPMBR?=
 =?us-ascii?Q?81aKLRhns/o9NxxZJzjvkSHrBnAEwM5rRUPBi63djuLxWv5WB7OC+YNmZt25?=
 =?us-ascii?Q?JW6z+o009/6PwgP/9WOC66Xns8oHOjJdC9RrsBfbdPQuGSwcsk1B+6CJVr5e?=
 =?us-ascii?Q?bAFjBa8PlNDX+P2KYyDIxEts1yWX/ltBJOu2zxi/HNRQtJGHf35r6zTeaUel?=
 =?us-ascii?Q?Xs/EEZQPY0JgBnBZ0Li5QuGY6Aab2pXD8gHHIeBm80AKM8TvbXECSGFXx6Sb?=
 =?us-ascii?Q?hs0X4tebcxbmhr36Pqx1EblWB2A2XjjgACcR2k5gGXFh/AdDVf6n/3kc5pIL?=
 =?us-ascii?Q?WWsuZ8oFwouhsotWVjhsANpUsgYGMYsq0PDs7A18p+T42oEqv/VOUxbcyaSb?=
 =?us-ascii?Q?KEn9YKYYj+qofHjNrvRiy3wFHtYnTlKYUv1VXf6wF75jAXC8gBD3blI1Uk8D?=
 =?us-ascii?Q?VaCt8a+PtaAq6qFCf2WvnPBl+irh/7Q1ke5D4agEjvWQlD1VUbybwkTaIrJm?=
 =?us-ascii?Q?YUZPE2wIfBZjzl2s9HRFdX2y626KXjMeZcPbZwzf0/iyhcZPfo/7AQ314Soq?=
 =?us-ascii?Q?S3L2lVfzIUhpS3I3kKoxC/HuKWcXwQOljn1TywtoM88ntNHa8huqiMbWwGUz?=
 =?us-ascii?Q?KouReGreQBq3/Xedzt6nohOD23VRE5UAHIHhDASQIO3Uahcp8uDst3xm+UHt?=
 =?us-ascii?Q?HYfdCPaZaB+PFD3FjwgIdxZJ9CoFA3GwT13J0QswFxau7N1H2qjYQecrH8Aj?=
 =?us-ascii?Q?sDhLOvvyUt0OgsUPonYw4o3cR6rW8WtI09KKDOq8/kI0Bl6vaq1Q2oAF5grA?=
 =?us-ascii?Q?Eg7JhMd0NWpEwHgBp9/cb9ofqnqr3Ymj+e2gagWDPJYRUa9/DjbKbJgxhjbX?=
 =?us-ascii?Q?7JOQvllcIn7+zbGfenFrA8ir5HJUYPTQlrmHd6RXur7LqW+TWV8dR6SenEWc?=
 =?us-ascii?Q?VpU/osyZdb2g4CnbAk3HtXvImfo1LGiO7JmVfrSEqaKQUjy/FfZmjlibop4/?=
 =?us-ascii?Q?77x2YncfWkK2Ax3Q0jZQjlUFslAJyGwrGpqv31XP/T7tWp3jDsZR5G3Y/0kA?=
 =?us-ascii?Q?qbwsPP4rFvs4RiEDsdIvE5a9dVR6iICaNL1uzDj7kK1JqDbI1xzyGEMT6N9/?=
 =?us-ascii?Q?+7sP7byo0S7A91zgqBHCsBURrD+lef1BlhZxUSCAMp3KK0TUJ2xP58xFhMHe?=
 =?us-ascii?Q?s77YZPN8wvaJ+SlGAMSoovPJf89Y2xdVupjJhw0m+t6HKSpY42HDCOrBvdpN?=
 =?us-ascii?Q?bT0kQOkbbyAGuDFsg+aUtbfhlur3zJ2L/JXsg+wwlNdl+C+mhROcFOcYf7fr?=
 =?us-ascii?Q?DeHtIkFsb/1ZavG6aOHY6qr9YPl33o5+v+P3xLzW0xUSei24vGq1KiaavzZN?=
 =?us-ascii?Q?0jF8BpPhQ1QQstuB5IdspP8wTcXM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1zNrEY3pF2pEMrRdGh+6ZAmttEgofwMCCb6Rs3QURq6l9vEyL0yayAxBgKmN?=
 =?us-ascii?Q?xONo1E7yMvxF4FU3+SxJ4ckq/xt51y8gV5HLeCfg8f1rxsAiigfBg4+pRmNx?=
 =?us-ascii?Q?yXi5Q9BpVGR7rzYinl+6Pc3UazSNkkTq/COoV5Vv0JX5Fa/y7pKbb3+3wLM3?=
 =?us-ascii?Q?4//Jk4io5XRApA2Dh7vy90FNqWyov3dO62UW7tnCutMT4G0hQpSBIDxaXBFM?=
 =?us-ascii?Q?a0M8ExKQQJp6BCgV7D4kseLFZTACAzu8+b6BfFFAjOufZlpFdXIclq/1iPDW?=
 =?us-ascii?Q?SZz7STPUuFsb2tkXIc5g2hA5D+3YhgDE613MKy2UAroZ7r7L9xq12rXWkJMZ?=
 =?us-ascii?Q?l7Ezz2KjF66TpIeVeexPD72aUXLNyWMH4IFGkSjYt/iVFEp8TXKMmHsZE30R?=
 =?us-ascii?Q?pjUl+qzQZu8YDbIr0LcvkJx7K3IpidDlhdN9aReZ4T12H/bpJU74uH+alSk1?=
 =?us-ascii?Q?8NMOHscrcLAaGgmqIlZlgm/bRWtJ/85QmYza/lyRf9DTWADQ/nWaQbe95czm?=
 =?us-ascii?Q?Si+Vc33EReSgogMlxP51+HgcHO8Yj9Wt2NiqGgGcdD1YaDk8nVVdHimB9jDq?=
 =?us-ascii?Q?egyXDrJWnIS3zbB0+mFnzeAb+UftmhS//524jW8nuQEjNFfPfp05jKOm0ie9?=
 =?us-ascii?Q?GcYCjNYH+ot1FlBqt7F7zL7QOXWEybKH20Hvb937oNBfM06jJkntlmQYFFWH?=
 =?us-ascii?Q?Q9EXynf7f9xLzyhIv1Ez3TYKPZZzdbN5gbTdGDLEUzQjRyL6ZfW1B8ehkvzi?=
 =?us-ascii?Q?pfUSep2QvWvfb7D4ZAwXCmgGphIGiIVJXA+qEul3+hjpd1J3K+uG08yMOAAC?=
 =?us-ascii?Q?nXW90U7breEuDecy+oJ7MwB3jQ+gCyN89NxFLCVVaNoQB6iH8laTM1liC+nf?=
 =?us-ascii?Q?6U6YXXI0piHbaBbJF1v50DvgeYb5p/5/RADka5B3eUJrBBIrPCt/bXeejyPC?=
 =?us-ascii?Q?3yOMRl0fk9CW9K0o/HENp0JgcGETp1GXnPoS7ytoGthVUaQpunOx/ptG/W76?=
 =?us-ascii?Q?rkVgwQEww3WuGAfBA1ofL/IswUYxR5MXPj4I6Rbmar3iSu88cgM317osWuwA?=
 =?us-ascii?Q?A7/mDOOXzkm6+x+NK2yZ0z1F6mQjJ1pBp1c/lh8qn3yvw8X2XguRsXs5rX/x?=
 =?us-ascii?Q?rbl0h049Hg2syjC4XjFTvpoTXjYf24pNTjpiTZUmzzZx1iPXGo9YUVwYKHQ8?=
 =?us-ascii?Q?Prwvc1x+WPPHDd3WN9yWIHjBQx0HIaOl3wXJb3SUf2lGdfXofvJhPHh8hv8Y?=
 =?us-ascii?Q?Oy1OqZgwxqtjYnopET9cjJkah3pzww7zIlQOJf4zztEum/bC9ymSx+dPuv/A?=
 =?us-ascii?Q?6pkINBjlSOEUhe5gLk+zc8vKLBr0F+SboXRxOVvTEyWu5XWsOec3W0g2LwIz?=
 =?us-ascii?Q?I3+MRNygHnJZi6g2doKHIqr53BjnvDDP3YgsT5xAS+dGrSl5AyJOMYSsPkPs?=
 =?us-ascii?Q?tqlrbcGbns8yx8DfgKvfDf70Qy7pqimE4zGNa7FREMeBvIVWHpegZPGWJp/0?=
 =?us-ascii?Q?0kpFvbbAkPKC6tRWnAz3I2Rqv6Zozrb5eigoyQbWRhydVlwzXMiRNt91CUTX?=
 =?us-ascii?Q?kIDXvUzGKKTcLPBqjx4vP3LQUMFqBjA0nFtgiQwe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f0d6464-27ba-4a29-9ed3-08dcee780ecb
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 06:50:59.6385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PQsItGBbJC+34YpMO7KeB5fgb1nmQofupvi/lG7STku8CWxRh23KmkbaJ8za0D4sBctLr9UWSbPI6GrgRjD+OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10148

This patch set is to add some new clocks to binding header and driver.

IMX93_CLK_END was previously defined in imx93-clock.h to indicate
the number of clocks. However, it is not part of the ABI. For starters
it does no really appear in DTS. But what's more important - new clocks
are described later, which contradicts this define in binding header.
So move this macro to clock driver.

---
Change for v5:
- update commit message for patch 4: 'clk: imx: add i.MX91 clk'
- link to v4: https://lore.kernel.org/all/20241014182438.732444-1-pengfei.li_1@nxp.com/

Pengfei Li (4):
  clk: imx93: Move IMX93_CLK_END macro to clk driver
  dt-bindings: clock: imx93: Drop IMX93_CLK_END macro definition
  dt-bindings: clock: Add i.MX91 clock support
  clk: imx: add i.MX91 clk

 .../bindings/clock/imx93-clock.yaml           |  1 +
 drivers/clk/imx/clk-imx93.c                   | 64 ++++++++++++-------
 include/dt-bindings/clock/imx93-clock.h       |  6 +-
 3 files changed, 47 insertions(+), 24 deletions(-)

-- 
2.34.1


