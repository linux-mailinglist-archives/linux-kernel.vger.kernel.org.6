Return-Path: <linux-kernel+bounces-528479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64697A41814
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E98173AFA3E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2C6245002;
	Mon, 24 Feb 2025 09:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YSao2eo1"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2049.outbound.protection.outlook.com [40.107.249.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907F2242916;
	Mon, 24 Feb 2025 09:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740387928; cv=fail; b=rx2uzbSOM8W+GWQI1eyYxznSVEeL5yMzjmXQ9tXXInk3eax5waiy3SN76ouaCrJiyNWDqqqsKZLkhOs561urmLoM5G10tFqt5mQiPV4RbPfK0TslsZwkcb7cmEwIJltaJqR6wgm674efD7okz2lUHxJsY1PdIWB0DvmJBYTsHC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740387928; c=relaxed/simple;
	bh=tOjeEEOqJrJBXrNMC6XSm3VE3ZK/ArDRxHmtjNxbzwA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kwq8aX2D+9U+hYX5wFCVmy3r+G/8OOl6v8LVb6NGjWfRvkZy2vFuJy99k/9oSqixJk7CY9NIx1jisYGLLaH5OuaxcmBnrD4zVk9Dgna4QET12uLrJ/V15+LyYdor7ErmzoGSDle95CuGZiwNpNRey/rIGYVu/44mu0kR7OClIVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YSao2eo1; arc=fail smtp.client-ip=40.107.249.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kc55LITvqbMw16zW6G8yy0V7Ixd0Zsz6aG2OFUKpGFOnI2qZxztB3XqjCwo+Ec2VZ47VeALr+6PNbXU4V9h9xV0PTJjZVBTXz8BRi536O3tESs6KpR+Wq7AUhyET7NJ0RUYFeyIZq/ZWTVQ9lt9iMO23FRQP2U0qgla5Qy2o70MELSj+ZWAAY/6JTI+y29Phlzl0Wg0uDOYWq9ubfG9UWmjFmvDMYlljRxisX+lQ6KlytycNZY+BTCQ4SDt7/McFz4qpWTsdkpBY9uy26o45CHONjrbCySeERGLQhREED5ndvAVjhyOx4aFq/Fm3PUHr/pBaok68doRKPHuwSZm3IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UrqkdIQz1RDVS2elhpAS+oI/jMEAGanNiMr5lkHHl/A=;
 b=nyL1vJ9as84ekZcjEwQKPPo2MAdzZr+PoF6gucXbeXTP20aHmAYg3OQOQ12abbZbj+0gZWj3IMoi+uB394uyrpRLG1ctK7dzRm8/2R6iHxJasaRn4D9yrNBv6x4LjECt/F95ufF8xhBEFn7xt9vYnAJ3fnjtt8m4mkBRiP1e7u4yxzwqpFslx30Fs+AbHwd6JB2yeJ+UTG0fEP87QP6ZolKUHiCnSEaDzCnKDzPpC/rnGxj9Q5uVNy94MYbBYANbVNWqixyuFoO9nxHzx3gjkPCx+BTNdpesPWNo43WWsZ+n4ar9LmlMgyP3tNVvlEpkHHzifGV44bJBx64771OoaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrqkdIQz1RDVS2elhpAS+oI/jMEAGanNiMr5lkHHl/A=;
 b=YSao2eo1t+95+ZhM/RggbZE8eKz+a0fccIPYUiRDca0NfP7kWzr5HEOHZy7f4TZQ8abOSoam69ow9m3eXMqCiDdqs7bLAgBzAbYUE3bshNuG0/eEZjfbN6gE54iNfOV61Q+Bkthffz85rnuiCR37KlRcaWAKr/4QAtz0afj3XEw1+59LFIzTN/aiwTeY1NiJMo0XcgOn9r5xgCHxAVj2jn1HqcM0xxKU9XIiSRsypBjKAOKpR4d5ejd+Gjfnqx4bdHDlBVVJp02GmptEGm8hlQoWjUgT/D9LL58DB0NIKLiQ7VUhTv8ZiCyloTTYZHuuGdMrwzoDNJdBxgAejyXQUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by GVXPR04MB10706.eurprd04.prod.outlook.com (2603:10a6:150:219::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 09:05:24 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891%3]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 09:05:23 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH 1/2] ASoC: dt-bindings: fsl,easrc: Reference common DAI properties
Date: Mon, 24 Feb 2025 17:04:12 +0800
Message-Id: <20250224090413.727911-2-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250224090413.727911-1-shengjiu.wang@nxp.com>
References: <20250224090413.727911-1-shengjiu.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::10) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|GVXPR04MB10706:EE_
X-MS-Office365-Filtering-Correlation-Id: 07789c1f-2ceb-4c3d-4d8a-08dd54b25f46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cJqGhZTJgWA7RZSUPkQQ3LcXq1Ku5HR37oY0SjMRdvgQ4qp25TVl+Kf20igl?=
 =?us-ascii?Q?xUdoLxEoVo3WnlX2gfXtP/eAy9kBXIr2t+FBw+AwnwlDj9wcYojs8RPPLn78?=
 =?us-ascii?Q?Fm25NLAzrOR01JlPmbGRukpKi6lzDVmgiL+zpx9O1K5XAtir+dKYxW4ZKYOZ?=
 =?us-ascii?Q?M5iMccEIluWjKMCch9eVN7pm7bNHsV8NonW/DYtQ80ZPXXCSMAblfiyltsJX?=
 =?us-ascii?Q?axTedDJ0uQWwNkSKOxmGH4YOeeILdP6Ei85ScERBZufNZwkJ0ctZaFsHtoCO?=
 =?us-ascii?Q?gPoZmGeUCsfoVdlbrV34YEO6dr6tHFqbpyybX51f1ppmPuKJdsbfx2meEuh5?=
 =?us-ascii?Q?A1UysBTAhjATd7McDIfpkGAG5GulCg/WZvy7NxlVzEkaG0f8DgM29kkoE9th?=
 =?us-ascii?Q?gunKox9S7S8wmIZtC/X/M4iCvn/V0iu54//s1gKoK3T0EuvLBUwjIQQWVRUr?=
 =?us-ascii?Q?qriZWGIgDs24JM2IBNqwdldMHggv6gQSEUI8G0MQ+U7VdzwAO8f1dVERpOeO?=
 =?us-ascii?Q?02bf4pPEvmPUQovcVX8xLLZ1S8RGqRCcRiYh7xRWCZjiANUydOXQ1wsUHvIz?=
 =?us-ascii?Q?0tPSYQr7L5C/8o+AyR4pXgHwCOo1YmsbDygbf7elXGP9qYRETQRBxZIKzPLZ?=
 =?us-ascii?Q?2PHa0zyEhroLiaYgwj1JvqJEI47Oh/wsUEY3b+liQi5+Uo736Mfq/lpkIBZX?=
 =?us-ascii?Q?IbXL+5VAoiAYNxKwpeRKLkdfvNylTQeRbHLuECZ3zCLP5JB7kqDyWGZydcGk?=
 =?us-ascii?Q?hYjTkHiLstY/8P+nbyn9L8WzbLwRdmd9oqMHQD21jAkc5HbjgrJwUpliaHuh?=
 =?us-ascii?Q?r85DSuAI/4vJTTA25vkRHLuSCfhbtLKnUnoCNjeQe9HzOb+WSc22cVqv//DU?=
 =?us-ascii?Q?4Y59pQhGz5m+g/8p75uf5lCHJXHsw1PkR30Qp4LwOUk7LJpBXUuSUtgL3Xaz?=
 =?us-ascii?Q?j76ku/wRidQFTQB/5vdI7KYN+Sn/O40+yvf3w7pMvwZ7/fkELMqKVCNuI1BS?=
 =?us-ascii?Q?g1zgg8+FN4y1RmQ29hc/9JYcS7iOuq60RjHW4RwhHi9HCQckIVU9oRAIGlpe?=
 =?us-ascii?Q?io/oCpDsio+rhP1a5piGDmf2uj9pr0PbNmDHg2qGTNoxIwuYJi3IQmaXFsdk?=
 =?us-ascii?Q?oa6EEpF6DV4lNLejOAq8JcZkF/+ssi2vMPckNpxrcNc1FgtvIdVP/L/XRsX3?=
 =?us-ascii?Q?iJ04JnmHA4fehJKqkl19VK6tksA/fcuF5D856dJk0V+rIEYLkg+LWmDGMf3m?=
 =?us-ascii?Q?sd11ogl6TC+Jb5UC2S3Ng4YtaK1CcLsegf5YvYWtM74mGrBAS4mXbKbnS5t/?=
 =?us-ascii?Q?PX7y4uS+Gagiu1SodnDlihFxPS3DvGiwwHDdmZ41JyHNdo91Y4Xf1zFBFkRv?=
 =?us-ascii?Q?1YbCXvLT+6VIGx+c5TPAD4ItwvrkLEc6fc8ShlFEXVrO3B/wEsO9CqZbRZoi?=
 =?us-ascii?Q?8n+cUd3zxo371gTer6QE4jd+zuCrOvJ4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hKlbAr3OF/QUuizxhTWBnUBox8fWiXC2ieXWktkH9rY4Ses1499vW6SJ4UPN?=
 =?us-ascii?Q?sSXQ5X4CV1rrDVX9TxKDwqxvg/WwXB2WGElyOJs/oyHC/g8ZhDzCy4/y1mjC?=
 =?us-ascii?Q?fmaVXmncFkbZTzduM7D9R4IDyN96KSu8QyRXvfIDCFJ42/4a4zqWW/VdY3NK?=
 =?us-ascii?Q?FRfTXks2E2yiyjlrxu3BWfgtCSUGnvrgmijNxCDLQemkSXDISudh1rngRxdr?=
 =?us-ascii?Q?5BaDQbp6NzWsoPhGc1TBQJHFl/VUQTjYqsbO2PGFRs7pajTGrxK4XiMWMpkZ?=
 =?us-ascii?Q?/P7lNoyPmmyRixsxhSlrjeG7QEFqORul8JXRI7gHyKTErCVk8kVMkS5nUOC2?=
 =?us-ascii?Q?VxoSWLqtIEyHnKjF/36LvDWrVgWokypKRR3cEd98YMFIyvD2AwwNJukB8R8h?=
 =?us-ascii?Q?PpJwal9CbwNkIYZO3rlt7NeqAmW4nLSXvHcY8DPItpAlebpdCXB51r/+/Aoj?=
 =?us-ascii?Q?yFTj+ljTv8kezffXqzQPnRMaTn+1RwUXqHHPXA7Gzm3ciDdwdig5fcOuXgnh?=
 =?us-ascii?Q?g6u9CCKPYPJRZ/4T6w1YN3eG70BiXkf+J2M+S8+LRWfdeA7eTc47BhfmBEq4?=
 =?us-ascii?Q?j5HBBaqWRwRxavb80CUtf/VameZVsIRI8PXi3zh7Qu+ZzDHz+9kWKdyDu91n?=
 =?us-ascii?Q?eUOZ1aGJVKPtobQd0N5LfhLb/L7MpD1c8KzQsVqAjDuNvchYJ/3g426KoDSp?=
 =?us-ascii?Q?63ALYHq6PPAI1xUbjQJldH0avy9fGb+LQ9Cj67XdUBrNa89irinqW8vHXdHp?=
 =?us-ascii?Q?ITB3qEVMq+y/SuESqBFpIUodoSiuS0/syKKs3anjbRcO19sVCWJylCEsErKb?=
 =?us-ascii?Q?ZY+0LDaJfvrnKTrqFbRI3ejCddqHbRA5/WCMB/PTTdWSJSQfhWZTVofLJznh?=
 =?us-ascii?Q?5lG17Sbb0T+unZ6cesXPIbZ4jRiinPZevWRnqvZnyFKQPQXyIyInxgGhOen7?=
 =?us-ascii?Q?TG6CddBuIMYbfASlRToGTNMyfZRF+Xzs+TDpYClbJ+PQ+bTk5EWhaEMnTkiN?=
 =?us-ascii?Q?myYYTXTQvB5GR4pibtr/369nBocjO/CBWscd2dR3U2yVSIGfu/3jBnWVVqJD?=
 =?us-ascii?Q?MY9wR94VSv/ROX/CPTbmqISjgdcbv6UaPPKcu7qvNofCCZz5jHzR/VVehL9R?=
 =?us-ascii?Q?IRX5cwWFRaeRFj59Di3Eh6F8IWwJ1hhat20caLKPEi9GKWnlgfdejiwL+BI1?=
 =?us-ascii?Q?7FtNWuxS/9+2FCvHsB4NuOo9xQrNfGqwyXdoDhjQYuo9spDi5uEaglanxMNL?=
 =?us-ascii?Q?jCFAqXUUIfKZBjUHVl7SynsJQ4sbw8XpDOAdSEfMDN5hTbAJ8itXdPemUr1+?=
 =?us-ascii?Q?/9nHJmRkc+90YbnQA2vw0EMRaJ+Pa3WJIErgDy2KKm2eKw/SCvzZjV9wmDnO?=
 =?us-ascii?Q?LyHCnmBcT19bf9P2OmX+mrTJzjp84UtSeplmARA9T1oSUfvkvGPHMKKRAwYu?=
 =?us-ascii?Q?fnqKMUH4ZmKOaRvH0RXg0FyKoTcEDRtsog1ppMbMS+CgP/E8INv82+MVpALw?=
 =?us-ascii?Q?tySFfRu1OEeFSlRfBTwrjdUE0btSR/uKdGi0KBkzkPDiRTK7PodxX6cNLIl6?=
 =?us-ascii?Q?asqaUb0/fZ/3PrDH1CtqIymVbitsus919BPvsbvh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07789c1f-2ceb-4c3d-4d8a-08dd54b25f46
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 09:05:23.9498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kaD6UjEJAEZLN2zrbHoAmoQ47cFpolHnMWdXcZatrtVFNZ3BNOb8Qyin8MvkqHTCl3RPuiTnIZmst4QpkHYglA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10706

Reference the dai-common.yaml schema to allow '#sound-dai-cells' and
"sound-name-prefix' to be used.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl,easrc.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,easrc.yaml b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
index c454110f4281..8f1108e7e14e 100644
--- a/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
@@ -80,7 +80,10 @@ required:
   - fsl,asrc-rate
   - fsl,asrc-format
 
-additionalProperties: false
+allOf:
+  - $ref: dai-common.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1


