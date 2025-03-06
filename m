Return-Path: <linux-kernel+bounces-549422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1863BA5525C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AECA3A59F0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB51256C68;
	Thu,  6 Mar 2025 17:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dzZakfiV"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012060.outbound.protection.outlook.com [52.101.66.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF99B13635B;
	Thu,  6 Mar 2025 17:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741280905; cv=fail; b=ke1KMZlw+2AS5lI60w0ZeENz6TZd9cRe1Se+dXoLLejozQl9m6TSSRnQ4P7la7iNF6CN+HCmOkvJmVpTEmeUcB2EPqNThqRV+uz7UVd7OAdKsUCFxazGDSb26KgJ/zv21YC/gcZv547kqXoLitUZiNQK6B5RkPpco2kBphDyVZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741280905; c=relaxed/simple;
	bh=xZWmdP6BxHHSWwtS55A5hIPplH1MWxj6iys9PRJAgNA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=XLiB8jtSGlmOqFWNUB57SzdEDs2JKTW83JBDNu1ltGZ8OAtP6w22dgecDKZE4FhfyZVfLNSTSF19HMCByBgOZsRJwWxWeqCyy8lkI4lSKek5o7ooOI8PWDZBU8uCln1I3ay/Rn1fo8k3CcrdJxo3Im0nuCZcbj8v/GjURPmoACs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dzZakfiV; arc=fail smtp.client-ip=52.101.66.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jDf5Fs5k//mrt3DWfUUhIqUdRiDQ2uehgCRGFUj88G3pBdnjgBHthc+Y+BmGAmN5S5yTxo+Gv0QBxfRZDu48nJ1hTBSf8TUJz0cnM0iRK22siHS8cwrlojUX9X6TO4EFTQGqbYeyZ6clh/kKkKoD+sDxWZu8Yaox6P0D9OPhxhgQLwIHuwJwFT+tFUrXCrIPMOrq+oM67XFbfnSUJvaFPCpC4ICd4CXvRCuuXpl8fpX0wuRRaBulVcAQmhPvpsa/I3XbV7f3b9ICYDTgxTHtabXdUmn7Z1NB/53JePz8vfe7Jmrpr4wfDWtcDlb7hB2p10r8Xk3cow5t6mYUX+7HCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qyNgi+TvYUCr7rDVKo5mSfVfDdgHvSvA9jrP6K5VLio=;
 b=FvEoSoUlRAEKc7HMPukX+xasBYXiOqmyAwDPsNY2dAIjiovgAvRBoBQ6lhj2OKI1yCD01Bjh3idme5A0RzHHYFrQBUh2gdMN1tKJNFeuZ8McAboaZCxC68KpTpyPBInkCwjdA/PXp5cntpXh/Aia4uTXB4PBbwQSqILVZHtjgrEUPpFO5yRFIwjHm2K1apiWJ+a31CijUZVQeSDvqVzJjNkC/+P3fLj7GD31ZXxXac0Uf7HM6aZlS7nPhc/1791WIvqifc6xTd6plyXA4L23VGI20B4fXHlqePdc8kgd3lMKOQmO6Opj+XKXZju0W5s+9agitr/y6Fh7GJLliLlJkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qyNgi+TvYUCr7rDVKo5mSfVfDdgHvSvA9jrP6K5VLio=;
 b=dzZakfiVBHZ9/MlFnmotAtnTb1q25oNd/HBuzGSppSsDelqwXkvEq/87H+LR3RDCBEsnGF2a7G+Br2l/TMcjPG/V66Bp4jfMM1zoYgH48/1yF++GFfl8Lv08HWQ+0vQ3pnoPKEhwCS3Kzb18o8REc+84TR4eTDZmpSFF8WMTTMmQrk4jgKBxyyNyvUWOprdrB7HRYtqpL012CQ5wL2P06CVHoMil4BmLOUBhLOw2s7ENqUvYx3GzfogoA379oPYKsPz7WVI2RM9sTXkP3uy7TtpwWQXv8t1CWmzXf6LfNRt9dlqT5GiZO445WC8BTh8YbPD9NTMDvlQWLOel4MECaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB9179.eurprd04.prod.outlook.com (2603:10a6:10:2f6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 17:08:21 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 17:08:21 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	linux-kernel@vger.kernel.org (open list:IRQCHIP DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Cc: imx@lists.linux.dev
Subject: [PATCH] dt-bindings: interrupt-controller: fsl,irqsteer: Add i.MX94 support
Date: Thu,  6 Mar 2025 12:08:10 -0500
Message-Id: <20250306170810.239489-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0120.namprd13.prod.outlook.com
 (2603:10b6:806:24::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB9179:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c7cbc55-939e-459c-261d-08dd5cd17f62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eG/UxtqCWoRyBtixtrFUCXUMGSgi0KGKtgWuS1CViEdv63ZHy97rD1L0oZ6U?=
 =?us-ascii?Q?Mg9rIFsQg08WgsjVXnrvQputlq6OOykKXAJnX7iwvsCIVdQF2OLCaVIRBzDl?=
 =?us-ascii?Q?ba/V1uI7FtytktESSzJ8lwSfk55fFcf6lZedw+I8NgirwAb/rqk7loMOVv3s?=
 =?us-ascii?Q?PsYf1TI2T6A6weRegRbPKhmwH3z9FOqz4LM6kOrSk7aWH7XYNqqGZeNgaeLB?=
 =?us-ascii?Q?beMXyqFxsy79BS8cBjIRWFj7KedrW9CtYbjapQC5TywX7+bxThSVYswcPBoD?=
 =?us-ascii?Q?f5UFQh4R8dMgsfkmwzBvbk2UkfrMgDiCigf4nxH7U48iewO7hMcPRYmrdwhc?=
 =?us-ascii?Q?t873CpIFNYPbmhhU/6xeZ0kMOnTFRSiwT8iVBERA/cOjTmVQhm7/y65Gmqj6?=
 =?us-ascii?Q?kPEUXYspY8s/rg5pPgpZFmuXKwWX80gvL+qs9uTXmX1fCsPGUmG8QQJNsHYr?=
 =?us-ascii?Q?2w6id2oNaSikjCIH/ZT2WLxySLNgiczuEotPBIlLJrBKVlFA8pceGVp4xRN5?=
 =?us-ascii?Q?kwIx1Nw5D64GNNowfCI1qxSKEHHx/2UVkYjSPCPvi7wVzmqdMmqQTJlU8RQU?=
 =?us-ascii?Q?XJwCocjqmVFMbp3wK6RPdLQjJ+Nw133gHTiHYU34eeWrnvg2awg6CWQI9wl/?=
 =?us-ascii?Q?Tt10H4iGLDN1jClpdo9Uri7iVL9ch1uTCz+EOpaxxQIxYd+dVlgrEVT5HNzJ?=
 =?us-ascii?Q?hSeNELB3FZCL2BVacSnyBUfH0asKgpEP6lezRmNYbDKGHj5+eDl2/ZzalRsp?=
 =?us-ascii?Q?IXjPRA7q9p0OLnpeFh5MsvkXtaMvcpHepYtyHLcAtq1oU3w20t3G68AGqW1R?=
 =?us-ascii?Q?dV6VVITVdJ6kTqaFic0hdJKeoBYdvQ0/02Nl6NkA72NVAfiFknxjitazQEga?=
 =?us-ascii?Q?jMza27Gt6QicEeMmfTFg6knxgFF9hWmFV4Rf398CdQRVWSokd6g4HqPINzY9?=
 =?us-ascii?Q?+siWLbD/jW2LdgQi++1E+ROffeyEkm0fVUJriZTtCIHvErmfYkN+C2IE0ymz?=
 =?us-ascii?Q?wF8xtUrbYriAUU09t1DYztvcnYNVpJPBb26Jzg2t9wG6YYuy718J87PlhPsS?=
 =?us-ascii?Q?yDWpLPFTqGNRhaPwfWdldPEbR2ftbKvC89d7m+5bxjxTOOi/UxMSbfsy2OWY?=
 =?us-ascii?Q?59ihJSYCnvTvV3sq1A//FyxfJ/aLPmIiDqTMN5pFIlkKeXjepT7gQVeZonbs?=
 =?us-ascii?Q?dQOkLp3NMrPcNzL71ZsikLGm2kLNHy3PHqHDqAsw0+eb4HsIcPBpR7vmg594?=
 =?us-ascii?Q?9ei9Hx8xFurtbPz/+xlCuYpmrmqH5unlxWjibAO5AImms3gL5OVJoejWVEmy?=
 =?us-ascii?Q?MBQIwGeMYYVO5Hw5KyK5X2pCBHnYp4jc18Fb44DIKxot4BRVBAuN4Nuy4Aw3?=
 =?us-ascii?Q?Mf40J7Niw1awyATnrREZEAgSEoeRx7V//i0bDNqUCCuvA5Z4SZlBG/U3DGJu?=
 =?us-ascii?Q?J0UPcjrLs/XHzXstiMdp5WNE6UtN72J4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hHeTc6tKbS8qLNlxXMPjVZC51JTmPzhRk5yZnNWENI+FpykeGIeKvE9gDzJl?=
 =?us-ascii?Q?CEDSJryWJNcSXbZ5jXHfDOU6S7EQIly8yaZvRdP/csRoizCfEVRvcpKizr2H?=
 =?us-ascii?Q?YYcFEGvbxiq1XuZ5eFlK+N0wNRiI4h9tx03Eg2QZuqYOxl/4j/sOKEYuuqhP?=
 =?us-ascii?Q?EgcduwWpOSmZBsZOWY1D3XlKXcUf4Vtq14E4qnyWSTsPwZGy25mfFLlzEbed?=
 =?us-ascii?Q?WAmcMQ+Ialox8fQrPz7QO/yACEGyHFvEV5mK/NE0jLUgHDgl7Wwz1haFtX74?=
 =?us-ascii?Q?rbkE4ftkg8Qs84vjuUTezb/+iMAs6lhODJ+pnGz9jMqUKkRgQDVG4sehDVd4?=
 =?us-ascii?Q?5pK0wgorwl2Y9eI2D+KpjcLPMuTswCXX5wMW2sp9v5TsdT2g7Wq6Kg/J3fDV?=
 =?us-ascii?Q?JuyH82vQXC5qC0a/n28ypKyQ2Dhuw5wi/I/mT72Lnabon0yVHQK7rf9moCsq?=
 =?us-ascii?Q?6W73+DXXS58q5lBtsKodjJosn9y7Z7tRukxpoWcyHu4reDNOa8MoxL8RD1hk?=
 =?us-ascii?Q?/ddlkb4dqjy4fwgQvHY+Z6/caLGzJabEX5Cxg29xflpTXoT7ka+aBtJ4CcAX?=
 =?us-ascii?Q?vjM1Xk4Aw36zV8fIhwh5RNjiysMX50w3PLGSxupG3vbXl3evz6CXYvz0FGG0?=
 =?us-ascii?Q?j7p0YzwDP2kNC3mAKJz+0fvhH/YKfIkwbQK9iqlRS/lVjpxdx2qiPt0eUlQY?=
 =?us-ascii?Q?9Nr5frcCFXip2BulGpBnW7ots0h2wNbwXkugFip7BkiApOB02a3c8Sn8gcqb?=
 =?us-ascii?Q?ATar7fpvWciW8D7p1DgK1xuVGtUd+SlR/hS9Gtto+4i2cgZZ+etr1eMbsHKP?=
 =?us-ascii?Q?0yIO+QTypr01SPo9RaK3YBHBba67rbXwUxdybW+XnhpGPSHAXRq7CDp6BqYK?=
 =?us-ascii?Q?wtmLguOMfvmh11dRtljQ0URwIyfJZ0MrdR6Qne2Si/8SMNZhFxOb6zthNCx+?=
 =?us-ascii?Q?ZRtJYCCMReduMB7l2bYlBIUwi1H8Nv9iQhNMa9KVnbzSwC3r3wLyDC7iHumK?=
 =?us-ascii?Q?9zp8bstZcTbSGj2OihgZsE4CFDwQB1XbO579Lsu+b85QiFcBHOaaXTG/dxBE?=
 =?us-ascii?Q?hV50du1SI5aMj1eDD+kGk44B0BJ5V+dTOi0f9N4/AxDWkGaXUkudqhL+/PYs?=
 =?us-ascii?Q?K7+YRfTyPmleBLzx24fckhRJbHjlQ4csLGhehX7sFdjZm7UnG8Raz4fe1+Rp?=
 =?us-ascii?Q?KxFpseFeGtACN/KEm2fbdjE57V5KaVJnkaJKZBDaex1S64DuVcOxL6DV5/+K?=
 =?us-ascii?Q?a191WOngkkvXtVEI8K58qW8rl2GaGNlFsiSuQkVTpSPiNf6KGx1tvg1g/wW7?=
 =?us-ascii?Q?ludP3RVI0Kk/EerQoepxI8AEoFfmKQxPzxpiVoE71jhNbwOL3dKBoD8VXuV6?=
 =?us-ascii?Q?wUTbjMSbiL3wAvEekZzEW5oMmy9YE/z1A/2AQvVxY1iIOkUjDY/5iQERluCP?=
 =?us-ascii?Q?nvn0ekIjQaYTArztfPv0Op8J7Xbb6W1lsYX9rJvHg1YuVxBHeNYmgrB98kcy?=
 =?us-ascii?Q?o27HBIKPRV+aCor5V9Nge7P+FTtQg55wU9VQJPb6nrUPY9s5fwHPErX4ZIr+?=
 =?us-ascii?Q?RkqAmsoooVOIw4LJzTymykiaYPqTB8JqlI0CDYQs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c7cbc55-939e-459c-261d-08dd5cd17f62
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 17:08:21.4635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RajERYah/GByqmJKhJjIG51URQGXKdtpyXAjclxowAAc+8MxjNR9RLBvds9Put8bDrQgaUseVxEs2N5iSHXs3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9179

Add compatible string "fsl,imx94-irqsteer" for the i.MX94 chip, which is
backward compatible with "fsl,imx-irqsteer".

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml   | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
index 6076ddf56bb5a..c49688be10581 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
@@ -19,6 +19,7 @@ properties:
               - fsl,imx8mp-irqsteer
               - fsl,imx8qm-irqsteer
               - fsl,imx8qxp-irqsteer
+              - fsl,imx94-irqsteer
           - const: fsl,imx-irqsteer
 
   reg:
-- 
2.34.1


