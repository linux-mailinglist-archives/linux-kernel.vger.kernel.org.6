Return-Path: <linux-kernel+bounces-359050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 909159986CE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05D19B24A66
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78FB1C9EB7;
	Thu, 10 Oct 2024 12:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q4f/Cqs8"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012031.outbound.protection.outlook.com [52.101.66.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143C01C9B6D;
	Thu, 10 Oct 2024 12:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728564958; cv=fail; b=VE1RXP0Ci8cWIaNqX/JklJMphdra3VYhDXIvoouw5qVfDBAqU7uy4AZM4rnGkv6niCCy6R2AtQJFPu1uYXNGdi5iz1T4tWzwnMWDue09kdxR2EeC6+BSoRjbQeV3+AOkaZaiWNONfKQV/KQHATcQLjhqyQKUhNoTTJXiRmvwalg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728564958; c=relaxed/simple;
	bh=w+7PmH2jw3uYamet+CKUc461XWr66syAi7NX9iCk7Gc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aMaD14kIRXqoI3Hp0CU61mn4UCUuVOFSd7P/7eI+18+H85uTV/KxrcigleyyWZ0VKRRBBsQB77V5ZnuUcks9xJxYoH7RuQZadmJTdc3vRCpIiu4qDulnuUpRfJlpMI6mSYkIPVKD33P4iga7qvZ00SpG1oImRPWJQc3ADYWLKNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Q4f/Cqs8; arc=fail smtp.client-ip=52.101.66.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dwdONd68btk4LwU2Yw1NBk6JSWMWMHE/wyfTluMpULivzkICEU2JTamzzOGvUlUSOE7C7aGar4ar5031RYPdrsGmifq6dB7+NRH7GmdeEjOkvHpDVySOATb+OKbkNYBEc0nLdWHQSLaNIx+sRfVh4FT/Sx5bNrKBtNDziBbWMR8R8mlCOTxFybaK9YKKI9YTs1hNYu6DfmKIaaPyE44CCDkND1no4AsidXAxJeluBAl8mIaBfoH5Vm+gfztavz1VhrFcM/ppT+UMaPksCjEd732wMQ6lkBqxQr+kHCycpugQ1DjhxGFFjbIGhRkKzFC2DW1NoRpdKaqlOdA7vXoYIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2K9LHKVMmyU2R0ZjVOQLXMNHcYbtARDRqjARPwVmdM=;
 b=op9ROqsnWkOuKrHWA5hU9JC3e+bTInJpnLmIx+porQVZr9ybUdqXJidJx6fXgKIUsR9MSw21N3Vmn3AYsYXFQDTlPy50y09X1VkDsrrEGkrk00JUa0Ea1G4SwV0gzQ1Sx4DSHBndydgAgGjyQ9leVEJKP0aDd5aoxxAEQOEmFaMmvb3wv3q3lO+p2JJSj739gTiDfSaGl6OQM1YCdFUaJm/7AL5yLBSgHUf9AB6YdnHzgRdJFV0D2lH8m8/12QZ5NXOGElSRyf88QBHJfzbsm5nGi190SDIBqeI29H5sEj80mAlgY51fXW4CfnP1OdtPasuiRwOFuo5EYttBrA6EQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2K9LHKVMmyU2R0ZjVOQLXMNHcYbtARDRqjARPwVmdM=;
 b=Q4f/Cqs83hltANl9/INfZrv8CYAA81G4dmzUVa8myzv6psM1PdocvkZWB3TJX7MEqTBRRRZerS13eNrj2NHVCq04ZoTeeK1tTtxALBDRmImwNRO2hPZtvEzXkCnzukTLQHcKFDu7r/zihRd+WF4/nnRXfLgDMuAOwR3HjR83m5YbmgzA/bjYFZkXuTgpHwApSMiH9dKNz/nS5LjAt/+0oaxKNL0pz3DZ3yLFw0vfae4cw3CtUUmPCjiyN+K3Om7xhMPjYKYPMqVtnH3EPDAtb+2v//LzULtKDlYRWn4X7obdXISQ/3K7TrZBaOBTFQQOsRQGWxkstkbaF0NBJzXnyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by DU2PR04MB8776.eurprd04.prod.outlook.com (2603:10a6:10:2e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Thu, 10 Oct
 2024 12:55:51 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%6]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 12:55:51 +0000
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
Subject: [PATCH v3 1/3] dt-bindings: clock: Add i.MX91 clock support
Date: Thu, 10 Oct 2024 21:57:34 -0700
Message-Id: <20241011045736.308338-2-pengfei.li_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011045736.308338-1-pengfei.li_1@nxp.com>
References: <20241011045736.308338-1-pengfei.li_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|DU2PR04MB8776:EE_
X-MS-Office365-Filtering-Correlation-Id: 62f36108-e39e-48e0-fcaf-08dce92ade95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|366016|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nvx/EPGCQexx6clynEGltx2FBb0hsmzqPpQ0sfLOkjYIELPhlbeSGuXih6cL?=
 =?us-ascii?Q?69l1B8aHH/viASjh7fX/kvnkRfys7ApkJjciCg8MvTEsTXPiALSDPFS6mhcy?=
 =?us-ascii?Q?+Ord1V+aI0pdT01AI4sGBXDRiUcqaG1RetPNezUDmOt/+Dy6Seg/csQ7SLfF?=
 =?us-ascii?Q?ehNPYkWn2V+2A8zlzZcl85I//81q760Gb5bxAuZHjSf15LoDNjI93AaZMDsl?=
 =?us-ascii?Q?H4Nu1cAWeEfgEjv0f0NHlu+1277k/z2LcQuEr+xM5+Fy/U+VXLZHqAgphX6X?=
 =?us-ascii?Q?fs8xz0ylx2otavStSN61KSLahtJwndc6dY8IgR+RCWyV7FJRclHKCQO+eGfb?=
 =?us-ascii?Q?SBt70OGW1uaYSHNt4sV3Iq0IgCJTeDMhg7bdpDJdTLeb9stg3oDQEgurslcf?=
 =?us-ascii?Q?Q7ULh7m7ApBFI/U6uBfttXo8dkWRhnceRUgcjHUQ2+jgACHm/T58w8zPcdn0?=
 =?us-ascii?Q?FQc5VguauYnXLqs+YIZEVmPvGtxJdZBtJOvYZiot94cF1nd8tCfj01Cn+97Z?=
 =?us-ascii?Q?R4kOhRoV7yjWDKE1ginitft1aRMmekMUswIb9T1SW1j1/QVaRd1CjYTvHRIG?=
 =?us-ascii?Q?xX8XzGSLoFnDrLPvVLJVDiL3DzDcst04p5j4OsK0jVaaWEfAON3B/N51nQzq?=
 =?us-ascii?Q?2eiKT+wWDTL+MDpbYAu16nxzEPhjuqnyswjc2z5IYla9uysJe7SsYzj5NRJ2?=
 =?us-ascii?Q?nDextcoRvrdyjKzItzFouptAs7i9acYk0SUEtw61mFuSPpvG/tqyRVQVgDsi?=
 =?us-ascii?Q?TbMk8ZfSVy5o9EbOgXNSBhAIROyoTMZihbQp871xpcHmq10jvXxOQ58aqKjx?=
 =?us-ascii?Q?LvFdm+ArKwKghucJk4F53tBe9q+4HiPk8QiHn2IG5iCOu0Ukc3VUdmU1Sl2f?=
 =?us-ascii?Q?KFszlloc2RYCiW2GKGBaOuycyZEqGlKyALT0g3t8xsjSNj+LTFnsNDLL9mEQ?=
 =?us-ascii?Q?cShMlBRK7kBnEWAk0JWnIVOFwluI0CGvoUSYW3hC49W8eLFCiaPK3YwwUhUj?=
 =?us-ascii?Q?RI9Apxbs7ec26SYDAA8T8/mB5mRgWmV+QGYYb8WrL9fvVvBouTKm2IwrpCy6?=
 =?us-ascii?Q?nACeJxQdMvB2VhT1ovjd2PCf1s4wU/uG1weUG0VLbD9P7IU1zTpApY3VT7nJ?=
 =?us-ascii?Q?nrp0PZBb2HfquP2r6Skny06WKEy6THcX4wmNCsRkyu+Bs3uDSIsJnpaxNYUB?=
 =?us-ascii?Q?v7Df1m9s8DkmJDJlNPZHt4M0gHm8JT942XxjiIqLd27dNEcxqzPuoGEPa8kL?=
 =?us-ascii?Q?nK4qTNl5RWnVQnG/C29GdLxu5463ci5Dpmvjng2Y+lCJfTtjinQ8iDjQRYaP?=
 =?us-ascii?Q?Roc4tZ/wH5SrnMeSMIsnUxGasGqzV41UB6OFmUwJ7+5/xT7rI25fFkLa4jTH?=
 =?us-ascii?Q?y9/EV5s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(366016)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X+hmilYlvP11nxNaDENX2TLsn5XM6RjYFTXOCM13Tv+p65GsZpsCRB5s/yvM?=
 =?us-ascii?Q?tYpxn5qHpHyVZbS97RKshlng7YPX/RUSgbgICJohIOmqW1n4yRSsXTV6oSR8?=
 =?us-ascii?Q?eVGy0kbgD6VVpM78gGOoiyhmjZwjCzJXwucBFlCcsz0w3L7RK+HAVk7LmOXJ?=
 =?us-ascii?Q?ziPypfjSnGo3rmhOIEdLjPV4HGf2xcf5ktdoINr9kX/jzZe2edWpPYDglWgi?=
 =?us-ascii?Q?vBt6XhrEp6i3mQAgsmv2onwwub+NhlvnmKdyt7vgHIcdUG+6diQ0NPdlHshH?=
 =?us-ascii?Q?VUyq/IELVV1D2n2TRnZuj7AOMaR2fSpgDZsubCY9F6Zu7Vbd4KJyjI4ZnhMA?=
 =?us-ascii?Q?jb9yXgdkjUU6Vosc/ZxGLOUDHXUpHfNm7wKA81RKftZj/x9vHbCDqrNLDy8Y?=
 =?us-ascii?Q?8OVp5MP7grteHvBxB9zfhY/C8fyTzirbvwmtmsC24DGAkzkB9fgS9CjrTPBF?=
 =?us-ascii?Q?Itjb7sAbhm8PIrBrm2oNcGrczVANal9D2ORaHAkAboC+6XHZxjQV3j5S8L8V?=
 =?us-ascii?Q?5o54O0CteKWGTPIPXLvkkExqw0a+PrOAiMUVtbCN5kUDTVxUknioyA7KIiLA?=
 =?us-ascii?Q?VjvTi4mzwtuK2IdHoYFM2oPIxosdEJm+vvdAgy6rnm0dR+LZfxrRToJCcv61?=
 =?us-ascii?Q?GyMk1Ibd3Rv3+tC8CNbgt/7GqwqjEjj+k/3yuvO12eipQKRTyK0VAIwx1PQ5?=
 =?us-ascii?Q?8uIdv6agTYNmoQp7YFSCHOyLeGmYFvH22mSSMP21XWDLleWeZId9HuzgGoCx?=
 =?us-ascii?Q?uIMZ9YDGd1Ep9tQbGK1t39bPBIF020XIY++/FcJgM56IduU5gufpprpMDB/s?=
 =?us-ascii?Q?1MZnG7uXNF3ZKUe/HsGas+olNbVVCor0G7j6AaqdOZkGsYA8xLcYFyQf69GN?=
 =?us-ascii?Q?4SMrFkYKezKVd3TrDOLNtlj2OF9kqW92CDv+XR6wFMaWxy2OBhxyI8bvMkkD?=
 =?us-ascii?Q?3p0LftatJRlNOkuDZ0MFQQqHCAhbgHjIA7gZMrhORQkALzN+enTOQqUdQs0W?=
 =?us-ascii?Q?1CBIPT04oPO2ea+MRPm+bhbVSoOwmj5UeC+LAEYhSvoe9B6fROWLtsmUJzBi?=
 =?us-ascii?Q?mir0rZVkc18eoiMFh9QlytSP6Skh1xoXT43qFfOMyxqvWIp6YRke65/JqvqP?=
 =?us-ascii?Q?UO3AYjBbSgf796RFJXBgLh8d7BsE4HeTVKYCVh+0W8Gb3MrmPmmAyRGB3N0g?=
 =?us-ascii?Q?szwKyX6WhWv7RxnpKwkJKKN8ZRN/AhGLC8wrbfc6a0B71qjVKnIv08B97U9v?=
 =?us-ascii?Q?+v44WOKumU6K2raSHzh4kEa8dMilVY0Xd+JRaxnWNhShR0WRBw3EVXImcap9?=
 =?us-ascii?Q?1Lpd8IrgglHDeUhZ66qenuAB3ljgVDkyV/qJLsiTpyveeFx8tIv2F7hL2uDi?=
 =?us-ascii?Q?3ujGjRvcHAqV59fz10zKcbT7iCGOQ0uXT/FRaysOg7oJiUg0HRa7zm+X3Tw+?=
 =?us-ascii?Q?K1ce+oQAp3xRuSHf1afvpEa9AtzTkyPPmnNEVxxPas41Hos0+KLqUfG6mtaR?=
 =?us-ascii?Q?Z/5IkiLaR8FifUyX5ghopOfxgiF7H+TqFXz8CrHeEVMbQV7wyqmCDjRWJDhQ?=
 =?us-ascii?Q?IxHaqvvrBAGtLcpBegn4w+aamt8jG1Idb7mVSg5d?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f36108-e39e-48e0-fcaf-08dce92ade95
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 12:55:51.5214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MmkcjlVE41bK+Bj8dZqD3e6rnZxyvL+GwdtYm0ivULreWHA5o3316npDTRyXeIWWcirmcynEBgcMZY5frYAIaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8776

i.MX91 has similar Clock Control Module(CCM) design as i.MX93.
Add a new compatible string for i.MX91.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/clock/imx93-clock.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/imx93-clock.yaml b/Documentation/devicetree/bindings/clock/imx93-clock.yaml
index ccb53c6b96c1..98c0800732ef 100644
--- a/Documentation/devicetree/bindings/clock/imx93-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imx93-clock.yaml
@@ -16,6 +16,7 @@ description: |
 properties:
   compatible:
     enum:
+      - fsl,imx91-ccm
       - fsl,imx93-ccm
 
   reg:
-- 
2.34.1


