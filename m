Return-Path: <linux-kernel+bounces-305376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7168E962DBF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A937EB20E09
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E66E1A3BB8;
	Wed, 28 Aug 2024 16:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Hmbgxd1y"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011038.outbound.protection.outlook.com [52.101.70.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A7914B95E;
	Wed, 28 Aug 2024 16:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724862880; cv=fail; b=tAXf2N4J6gMJ/BZk1Npsiliomf1bpVR5loRM7g4Pw7AOf1N7cX7oL1YL2oNpaU6tXraJwiMoJg6DV58qlaD9s6gcewAEqOv2Ro/hqXgoDjHvoY0fkzmOJTArxmtt/dt9nb5KmiwmGi473gxSQxrEWCkyKmPlYCfSoQmlrVASnBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724862880; c=relaxed/simple;
	bh=7Xfpb3Zuw6xK/P01yiehHpPPHhjuQS6pjWEbBd6hNio=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ZOVDR7o59E9sNqeIxCcLByF9xfUpbOmXazfKyCVa6RwDUr+2H7ql2jDfyWJ/SJ7sZSiu8RWoHmdl3h0O75jmmV5GFue2EXDebyeIl2ifwd6mjpJF9aAK/2KeVukxtMJPMIy4Ndhpe1XLcx9Oc5PtKns03NOVlaIkB08a7OWqHAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Hmbgxd1y; arc=fail smtp.client-ip=52.101.70.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hN4ublbCK1AC58UouByKeI7HRQWpL4wQIkJ5n4H6xvRwM7Dw9Cqemn5M0bTYBztFMwbli4vCuVG5BDhFu7YW1zzoYPno1EQDkSrQuP5MjIVeaHQH3pYWZRYVQJ85wgxZwjCRXzh1JMCTJJJIDWAcxxKCTfR+t3FY2a/PSH2tiyqqby8Ssi0vR8KrTqYefFonwEN9Mr2Mx90XclQW6M3v+Qm3n9+MB6tzQ9QABjt6tGtF05nnzkopeYYOaOBUivN08RQpa67LpE1uVaAVy+RxN40IvKMD/+oOBYNqGBKHVA09wkH/lQ+i475XI3ChSXPWNEiK8M+ZvOmXKoC6o7Ey7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7/V1XTZxqZL5rb8FKh1d/c4kF48ZvkIknrcJNv59kQ=;
 b=Tgr7N6Y1nPnL5hvUv2rPMh2piFgP9TZ3H0khwGNF3pt/P5xjxgiDD5De6MXPnVx4Mq00NMwnOSZDtZCDM1MDYKith/ZSornoCOT1aFyRvkTK8yVp74rOx2MFgmh/qZwyKdDP3faIlW1d2Vz0hALsfAuMk4n/3G+4GLGI7c+pGCujwge9EAPVRkmvrDINVACmhFwHiXdrmvvXJUezX+piBydUsNl1WthGXP0j9r1xkfxezRScSth22s9gsjzNbBVmLtMyKACvk3M0/7O87Hq1BVGkf3rOr6pikntiuSDVajnOn5EZ6CvT/n2NNDCSot4VRLcNGKXvDZG7Pg+ls5/FdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7/V1XTZxqZL5rb8FKh1d/c4kF48ZvkIknrcJNv59kQ=;
 b=Hmbgxd1yPVQLYG+6pOiEkp72eOORO2hjTAqdpPDIZpvRrgs4mcPM+KMkwXggo5Ks3hjmm/94B1qFWWv8McXMTQYLnSrdhojPUEjaIU2pBY6qD8IADmX7uMVJCEV0QJcjkYRMnANn85x2CSLWKUS+XVShHfFNzhujUtEFFrk4m11NlM6/6bbi4BLaJbY1BTcACU2M38Vm2TtEP225YZi7nVj2cYmblmlHvPEaLcI8ybzbOsoEzb0GpX+dRcSdELqBH1tl/XmHPEQSygaa81HWDC9S75njzYSyZeawXjbo6s1uXNuIbSkMYCbOfjHHZ5+6PeJJDI34Ix0xJ5QsOadExQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9679.eurprd04.prod.outlook.com (2603:10a6:102:23d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Wed, 28 Aug
 2024 16:34:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 16:34:34 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 1/1] dt-bindings: misc: fsl,qoriq-mc: remove ref for msi-parent
Date: Wed, 28 Aug 2024 12:34:13 -0400
Message-Id: <20240828163417.1130252-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0083.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9679:EE_
X-MS-Office365-Filtering-Correlation-Id: de8df660-e009-4f5a-4627-08dcc77f4c78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wng/SelePboFrQ4k/EXmIFK79Ga3v6WSAx4hpEpw4VgTV7tzUzuBGcBYO0ws?=
 =?us-ascii?Q?JztTjKEOvN0XeIJrCT2ItpcUKrGGUWbUKVBBA45DfYUeNbWY1lS7p9Q42kAI?=
 =?us-ascii?Q?Q3qRBHa0aCCE6mDvjeAuF4xqo6gRc/GGlAPEf0EMtnOtCSMUmbsro/SSNdXC?=
 =?us-ascii?Q?zx5oiWHd7hCURXnNiZamWN1wRJtRsv1R1fKTmhGfBrlCWXQYgDImaQ3wTTvQ?=
 =?us-ascii?Q?E5yYssWtc9QFJbEMpWGMWNIR+z0UkrfS+bLVCspASyeyz6Vzw15d+H00FFIw?=
 =?us-ascii?Q?66aDI62f2YQ7O17xjkzhf3tCroGuLUigPNB6EPgbf68cDZ5Cue1hG3lKk68z?=
 =?us-ascii?Q?g0pfb7sfX/AAcbFzWxqxgikCx62rGUTnK2WBXWdaTAXeuCBZcE9Fu+UgxvpN?=
 =?us-ascii?Q?yvpFk8EKQb/0FqoSCIJEjpMqdYEXNDA/61iohxYM+ZoOoK13ChLxh4jhccq3?=
 =?us-ascii?Q?RvKKj130Ned1tBMuDwE8+7XcK55xtD1FxXvP1SgTsDSjJBOnpu2W5/voPYrQ?=
 =?us-ascii?Q?q4WmlXPsjd83PTtDvvXlOrFlHoHiy+3SYcvX8DxfSV2v9YnZHpuc1HuQ9s+E?=
 =?us-ascii?Q?I38UFUhKsCuEWKBdSqTz0GxjS7iUFF3lBIDkV8QUWtMcRXNczoahV0rO4WNC?=
 =?us-ascii?Q?Qhlv7V8AVcxtc9uii7g5Bk2JWZXsnzZatmE9Bt/ql3BGhVpaaF4FQY4loF43?=
 =?us-ascii?Q?/765BLNXX7BVMJ11mldSjOzVJ1dWNvPGhlim0Msnxm3l5jO4dHYbKUMRwZcU?=
 =?us-ascii?Q?RSErv1STNIcVCUAoX0xgLwKwfPvuNqVFupe63ldRzUcxp1EiYk3CwD+vV4rW?=
 =?us-ascii?Q?wWu5pqTzxnL7dcdqIYr3NOTcp4KJN1MlyW439/sGA+u7lGJw2WWvE/vbIlOT?=
 =?us-ascii?Q?bnSQCGFXyG5QgYzwZWSViAzxKIbT6yXs0Hck5hg16E2zUQrqie+Vr4BJOUUL?=
 =?us-ascii?Q?kgm8oPi49WJ2XaluGycE+tmSJKhpLYUo2MmuR8ZX2VKt2BcEu2SofiOUgvk9?=
 =?us-ascii?Q?4V7mAVr/NibDffCqDzIgeNUGXa+wLhm/KJozl4y/uPiuJ6r6LXtXUSOqrI7B?=
 =?us-ascii?Q?AI11hb0I8UD0aPIcwD95Oo4wr2zSrQ1PMRYDv1NILFN0JPsI8QpfAeSr+wMP?=
 =?us-ascii?Q?XZQ4opQETUmzAjffn4GXw13pievCsBUp3hXXQGeviof4Sh9eJ63P0QPFJ1af?=
 =?us-ascii?Q?uf1hsg21Z+syT7LK1w0Y62gUez6cz6k7dKBRGvUuBIeI+HhHno86INmZnjem?=
 =?us-ascii?Q?p4ako92wqX0b27sGDRe2Uxo48Kmrq3AqgRb0i5wFJgWni3916nHCbw9Sjfrh?=
 =?us-ascii?Q?O0OHOFN3g7p0Dx6UJvdOdEcZp/bXTggm0cGSOc19Gir1BJAtI6PEM1QBPYQY?=
 =?us-ascii?Q?kloCv98zCfEXgNjOTiMjze1aJ5bxgW3w1NkBvVbuOy3ShtPsog=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0Zd/sS+H6rkTPrTrVHdQp6KmQ5HTvKXoiwZAZYFk7sE6wIX1SA6yizwcUdKE?=
 =?us-ascii?Q?+Wq/0/nSmHnHF4hnmk1Rvqlpr3EJb2V7l/+fjdtQa26NLELFBY58ZZsB8JZA?=
 =?us-ascii?Q?2Iw9s+8+eL6UeLeuKOsmZwS2fNGYbP8dVe9GAxT59fmcP9vNfqSWTIKdUbOQ?=
 =?us-ascii?Q?qvBv3pcuMBnwT7WgCKIy/b0WtlWC1r2AN7ovse4KrIgNAeR9ojGyfo4myrw/?=
 =?us-ascii?Q?9twyEWYMEfPNA5ePB1kR1BV7AIUw6kXVi0jlPWo72+zpuXmBjRjQ+bnFTag+?=
 =?us-ascii?Q?skCP59Psi6aSLyDi2RsMLuh6891oVkLkTgHfV59owtjfeIyLzm/gBSlHIUHu?=
 =?us-ascii?Q?iIUaXFsVht/Kki7G/IT+xtFLSuJa4cLalDU5R5kCu1CeBqFi2oxg1VpQAdO/?=
 =?us-ascii?Q?VW0C5MVYgAwQ5j0NmeriHKeCgBbzJ+F6Jj7WoxO3JmceKQgCWI3ikFm1F/yK?=
 =?us-ascii?Q?1V4fNOBlXlG3sXcAgF+DE12U9oUyRaAJ02bDPv1bbDQ0DLp3h8F67HluOdAd?=
 =?us-ascii?Q?tEVkm/VeUq6EWbXnU21XvWn/OoGyISoj/7w/bzc3anWvb8tSRhiTSDML2DE8?=
 =?us-ascii?Q?/F8LqKMrSqftOHJW8JTWu/4x7eQRz8db37iGgMgJxUrEN1/pcsZj2zvKYWKJ?=
 =?us-ascii?Q?7fD/4thfGqqHtecAkKjSHbmiNkYlrAVVc2wascS8Mn4JFikHzg2uab704AzX?=
 =?us-ascii?Q?dKplB0nO0Bj+abuMhTteGpB2kYthWUqggNTxVRy0jVPXTPMdYtGM6ZyGZJO1?=
 =?us-ascii?Q?7aeL1p6E11ND73peNk3y9ygmI/BH/Ff8i5E+cD2Lg+Kag6yKsFXr/kD9SJBY?=
 =?us-ascii?Q?zXyNI4yArsAXvcnx2ie3LBT7PGvlP5XKuLDv3ILhyxiFkoxMd1j2dX4GxfXj?=
 =?us-ascii?Q?DcD/AdjQI30ys9FTI9jKN9qMoOImbFzlY/RL3pC84a4Sq+c8upsnP4jVV5d9?=
 =?us-ascii?Q?U20bvDjGnOz6Udy/fGvZto9iNY+VNZeFAMkCMu3WkWikULRGUD6aBxcaV0ZU?=
 =?us-ascii?Q?N/ph6lOKoE7Goqz6yqVBPjVu73xqExgab6hScBlA340rZYA8i2gSVopkg9Kk?=
 =?us-ascii?Q?JhCDM+cx9IEGmGJ/g0WvQ5RXY1RtX8Jwrf3utSkUTY8N80202RckECWaca3f?=
 =?us-ascii?Q?TLg/i06A3RNHceXcnunX8sSzGUE8uF1x+Yi7Zshr/OskvJuS37UO07tU/65N?=
 =?us-ascii?Q?LIQR+pIvorjOZ/yusLki3/fk/kEhk8wflcKh0lJ9vb6XpehUpl2R47OEHK38?=
 =?us-ascii?Q?zv30cmpngRxX1neRSCK3D8LqOtLntrzAlHwQyaoPEoxqTOD0vxpbCMi7iJzo?=
 =?us-ascii?Q?BOvPF9hKLfru3+jFNOnqunYgkGl36IXwQS1qHHORQMnTNtMnQOKxfIP4BEFz?=
 =?us-ascii?Q?zD0SW7XKxDVtITwv+VQ4e7iXaUGoRoMI+O23IbMlBHQ86UO08eJl3nLIfGny?=
 =?us-ascii?Q?Tje8dBzJhgN2BRW7ROPBrkKuQf+kfbKyCGoBMRlux56lfUwu+5lF2gchiY4N?=
 =?us-ascii?Q?coX4vHoYtezX75dEc7yUzEth+ws2eobxCi0LxE0d6btuWSRd8r6LXorjdabP?=
 =?us-ascii?Q?upU+ev3hBBZeQFQjTk5V1IwtR2TMv98qCF222sqs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de8df660-e009-4f5a-4627-08dcc77f4c78
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 16:34:34.0361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qa6P7lqoZonEOLr2yFr6B9wz7vsGslXpUNmBqkaOIHaBZtLdgyzc0B3B1UXIVu99LOjg9XKdQZYL6MZ2p2zv1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9679

msi-parent is standard property. Needn't ref to phandle. Add maxItems: 1
for it.

Fix below warning:
  arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dtb: fsl-mc@80c000000: msi-parent:0: [16, 0] is too long

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- add maxItems: 1 for msi-parent
---
 Documentation/devicetree/bindings/misc/fsl,qoriq-mc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.yaml b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.yaml
index 01b00d89a9921..df45ff56d4445 100644
--- a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.yaml
+++ b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.yaml
@@ -113,7 +113,7 @@ properties:
 
   msi-parent:
     deprecated: true
-    $ref: /schemas/types.yaml#/definitions/phandle
+    maxItems: 1
     description:
       Describes the MSI controller node handling message
       interrupts for the MC. When there is no translation
-- 
2.34.1


