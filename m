Return-Path: <linux-kernel+bounces-215498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C7F9093AF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 23:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E100F1C21BB1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 21:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F541836FD;
	Fri, 14 Jun 2024 21:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WOx9PaW3"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2053.outbound.protection.outlook.com [40.107.8.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEFD14882D;
	Fri, 14 Jun 2024 21:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718400692; cv=fail; b=MWVJO5bGkN2BuvHvcCHnlo0ue2m9VEr+WDemuVKJ1QPt9iz2NJgBSj0AMoxV+gNvUzhW7xtY9LtpbAy4Dlh84be3EIK97qCjRSZ3FLa284yxcVa36WJh1tT3w8zAmF9Q3SZcR5/DZzQaHpm3g8TYGQG6pI0HGNqG9A3qJLcmriQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718400692; c=relaxed/simple;
	bh=Lb3hvrkmqcvmfxBkj3DP3AJh+ZCrP3UYcYuayN7sArk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=mKoGJ+NdHJQsgSSXOUp57iQNcR1u5mIPW5cMbMbburu7C1lVCkFZC185JLG3hBehA/n3s2k28PssPujG9laTfUtb2WO/5iNQsNuqEAUVmcDpwcqIdbMkFpqr0oVlFvjwiH86zlHaFjOwdnq5JrMeFHSztdeiOzRjV2gaexFfg6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=WOx9PaW3; arc=fail smtp.client-ip=40.107.8.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ca9e8uJlhRZupYYQKZMMuFZpuk+xM9oZ+ba6SUU4yeX9TS4er6rUPr8+570XoTiaKzEVmHK5EGdgvp0dHeAJcGH6+++aKaQDDYl/iJfG/05VFRQO3ko5lWRgQTHXgPyQcjibuxC2mWKmAuiXctg/vxkkQQtgsl6mm4HpjKAe3dQYkVTgdMexdeZ//j+WnlwdHhBInAYQnZRTo+kKx8gV18/7OpEz7FDroIs4nbC6HqpBxXiRRowW0VtNd9PSsOzqkRQl/+VOw0k1/EM2/Rl+p1ADpSMVDDAVFrCLTb2l2vgpWCXEq4U9YSupSYFK2SkWIlx60JMuv905EkEkFq9esg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVgRHfv4zN0uB22pF3kVE8npmFyTn+ScWrwNyF5YDzw=;
 b=nLjcdiHW7xgXCPgiNudQ9NV8wPznhUEWju5zJ4OmQs5yCyurjC8w9sZbOzq9gVcZlqjYiF7rG0yD/CYzLRYoyS6tOu3WeP2qqEjUX/h+gXPA6VawtDf2NEY/AJ+2xW6bvAoshNPXX+Y5zUEv5qd7DWMV9HS1v4veB/LieYXKWQIdmAK4w4PLbZbBqcEpzhlEvTwQF0+hkJL6RWm5trXYFIMVgPybUL92QTUAh8RdpTMC4eiHlOoUgI4HBAyZblOiYtsQpb+29PBRZHU2yVCyvq1DgGohE4jw0U29qUN8IOh3A1rEBm8uOdDhbab4Y76/SMZNfJE4/px7o0mWjE/wPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVgRHfv4zN0uB22pF3kVE8npmFyTn+ScWrwNyF5YDzw=;
 b=WOx9PaW3YNVJw3G6fQNVUNQYX1CP3OpK5zrZeUAhmrXbCmq1o+CRqKT4y5um9BNIDrD0OcUWFkPVlMPoOSmZYylkpwD/EPgASWCLFiK7PDuy7dVnkZ1GAUZ0OvjK+0zVwaZevYV/ZwBxNwL8chNPcsnl0joLkrJsdZWbUoaEULc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10420.eurprd04.prod.outlook.com (2603:10a6:800:21a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.22; Fri, 14 Jun
 2024 21:31:25 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 21:31:25 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Stuart Yoder <stuyoder@gmail.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org (open list:QORIQ DPAA2 FSL-MC BUS DRIVER),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: misc: fsl,qoriq-mc: convert to yaml format
Date: Fri, 14 Jun 2024 17:31:03 -0400
Message-Id: <20240614213109.2518797-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0060.namprd11.prod.outlook.com
 (2603:10b6:a03:80::37) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10420:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fb8c536-e5cf-4b73-ffb2-08dc8cb957be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|366013|52116011|376011|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jfOVntAI4HtssYlX8guLbrrUnq+rAjTkiPoXRaLN6gPezuqfnKIlXMDTMflE?=
 =?us-ascii?Q?eGFs0RVkcNxs4y8Vo79ZnQ8LCwb1/Oh+aVYwIUUnNDSGS+9kiR5IM4h/EYma?=
 =?us-ascii?Q?UZZwhTmgiIDfTp56JHeuqwGTXVb5DElY4uez9w6dcC+jjsdN9eCs/79nlemk?=
 =?us-ascii?Q?g+dbsOTWASMv1nhoHdyW8CF9CPzIOngoayIvk8unZhWjV7hQyC4H258F8waS?=
 =?us-ascii?Q?hfY6PuaDsWfDDKFWDFethickidRPz+gX3F/H0XkqFxJp6GttGTKOYMAYfi/p?=
 =?us-ascii?Q?1bT5naatWte4hkCTKKY8pDdQGIgIPPYuyHANoq/zOKTDSLtKWyrpl8HwnQUE?=
 =?us-ascii?Q?cedSDW90m7H1QbLQB+qg7VgE1iHsZYX+8lmrNk0tzbBNjQd66XTZxtPkiQgo?=
 =?us-ascii?Q?SFXt/s222ppirk+nV2l+pCaA0CdN7LrSubrlHASTYze4PSr120/b7ThqaYl6?=
 =?us-ascii?Q?JXNh5VtemIfx9Vglk3O0SO9rzgrb2DA5u1owk1N0k4zNX5qZcwNIc0MwQsh9?=
 =?us-ascii?Q?ghx4hfuIYvLTnkKL6hLBU+nZuT6hepYTwB7AhAU4o0LbXQTIMp4nso+TjV54?=
 =?us-ascii?Q?LT+Rsf+KBeFG0nnF1JE9Iozjvo9aE8W/rt5MEzBbge6VVCfv3NQwhGi/bwrs?=
 =?us-ascii?Q?H/uzclWBDyDf9N5dw9+kOzzo89M18WAulcdlXRdzJIIOJAO5xK1IRn81xAsz?=
 =?us-ascii?Q?Kv46hgscHpSq62esgvZmj1CnSI5RdezWreU3zCXPOHwjrE2BIDXYm/s3TV7X?=
 =?us-ascii?Q?Gi2yUI0hcWTQOKnQDQ50vw+4tiU5rRWTxunvb5tsNBWs8knoGYFLgeX3ybzK?=
 =?us-ascii?Q?omfaB+s3P9/CXAUlU1oWmdlZ2v6MZb8CERI/eMXqRTGzyELBbdtM5w5fDL5d?=
 =?us-ascii?Q?dN35x0dYd26X0ekxthFBl14zQx3Enw7dDpZS9d/u6uKQ4QxkLONsGQ6Wz19N?=
 =?us-ascii?Q?3ZKWoZC9ZIiFd2RBx7hpYigtbJ/kKbPexoEevLyl0MLTMC5+zpUHYbB41tTl?=
 =?us-ascii?Q?y1BSXVedZbEhV6mVwpUQ2J3AYeKKRQJtMOYyDXIWYV1mK/5Xwgq1CKeVkJMO?=
 =?us-ascii?Q?wz78blPK0DxdhKf9R7tqtiZMGuBYlMIxQccKODRkNOPTnuN2tYJnpqkP7Egm?=
 =?us-ascii?Q?4YPNTBEghERyQf0o3gwfLU49EnbrQ0J4Fot2Vwd1b8F1DAfmnRPqSLEKrKgD?=
 =?us-ascii?Q?qgYH/5qmNi5oqQxOgojaQFzz08lIAMezATdTLmKGEzbZPGdTS+Lgl9GuUQsW?=
 =?us-ascii?Q?jh0EGNNs/7AZ05CaNq05RlIAEVYv5NlFROoX8BdgLWpbzW7p7d0pSOQ9sxOI?=
 =?us-ascii?Q?1nN6//GJqyTgpv5V43LXvIXt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(52116011)(376011)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VeYYQkC0HeekEU4kIz1raRJms2s9BEsVpXik4VxzfSUZDUbt/hgLTdHfQPHB?=
 =?us-ascii?Q?LOb6K9ghB7dbN97VSfgmYPkJmc+Kb69c7DCcCs6i7BNQOTEWqXLEKtr2ggQ4?=
 =?us-ascii?Q?MWpCqMBdOZDKcbAlXqYjdNkbVV938TMN2OksYYEjNKCtGqkAvU4G5Hwk2zGb?=
 =?us-ascii?Q?gvq1BTQBZ8QzRHxoQxMKH6ppIeC5O4MpHlc677hKM9OQ58wzyiHm8Hf1nZ7W?=
 =?us-ascii?Q?1cAjbmPrCh9MLJxFiQF4LjtYRdi9PE1T/k3vcr/Im053LBrswph9/JhR1tPF?=
 =?us-ascii?Q?JhehsRMQle8b9md80gyEHZIOygkr/7MFm1fxr9sptczTZeBoy+yLJ2SwK/GH?=
 =?us-ascii?Q?yQgqPQLTzJJxnT16Y/44I+6z2zwW5JRYBUqxZVpVLE43bFIXhcNHyW03vk5a?=
 =?us-ascii?Q?tBLwGz0t6gVvxkW8El/pBOBHgvmAp7Q0Nco8N3CJ8rgU3YS6x2zMPDlka8hA?=
 =?us-ascii?Q?26RlFABxBW5NeHB1rHcpYIOijQ/l6CpCHDWp4VbfQM9crSA1FL7FlrwiQTyD?=
 =?us-ascii?Q?Xwn2sNUC+/N8/a8cgVusy0ijiBnzCsTIxnI/Rm6PurrpBZ//yMZmO9lNFATB?=
 =?us-ascii?Q?6G0MTb308aa2yPt0r2Z/J3BFRkWqXDmXDm/RCP2Z/5Bs3aJG+1XcN8SGCvy9?=
 =?us-ascii?Q?qWrMLqpwUKPYozkzB5HrrM31ACKMK7E8JHqD8/feSfOQSbxHFttqGM40ZINk?=
 =?us-ascii?Q?x47g4Q0rQL3nKOYC6hCT48r6mDZ0Uzmf650vXcwEpkprZYuxDkN4OR3JKIG8?=
 =?us-ascii?Q?kQFLJAjHg5vqymTcS3cfuOcozljnnvUb77u/tufJz4HL7DRJnME2Qa0PAffC?=
 =?us-ascii?Q?QD3rpJvSAFWfh4ouZDfSu4g+LL4O+zsMm5/MQZmaCQ4eoFMf1GaWxm+PeOSh?=
 =?us-ascii?Q?M/mxBT4yEzMO9DkEGh2RVgyQwOC6HEwuhAex/awHeY1S/RIDhQJKGopvcTmy?=
 =?us-ascii?Q?A5kkT2Ty17sv+/+udjbhmDfGUtLHQXOSDBeDzZVZp1+eESPMKbaWG14hsATb?=
 =?us-ascii?Q?zQnVGDbM3aLhLxh639AUl7BabjFoySlYElzKMhe6+QLy8vuMBKv9GkwB7y+v?=
 =?us-ascii?Q?FFhPcEJ+wEHw8T+Q3ch351SCsMdDxz8tCgsxiOyIT/uwEte7pDorDaSuy8pr?=
 =?us-ascii?Q?Di1i3fRQ/GbcP4r5xbutzeORdsPYHAUYfqENgNqhwgZ3pdIJiNOOUiowo7kX?=
 =?us-ascii?Q?6NWUf9nuIpLO2AA7oZx4JPseZnmuBzgfsMv7moOQDs6bkmYR+97ABqw1DjjV?=
 =?us-ascii?Q?ocK2Hz93qXuGVojl8v/YDxgiP2hfrDA4Y8TPae0oloJtGO3WkpafxPnuX27U?=
 =?us-ascii?Q?rTji4fIt+KR4sWdqkE+WC2gh2lHGbs0zMZ9QUQQJX4yYjkXYvqy+H7SKaCbG?=
 =?us-ascii?Q?QlVzzvdR/j5q6JAft7x5SkwP/d/q/smp1/ssx9sPPDI2DdFYgezonEpDSYTo?=
 =?us-ascii?Q?GRxQL0EDciZSWs9o0Y/1em8HjXNQDGx/uf7Hra2Ls3rCnjBhC5Gm4hH5R+px?=
 =?us-ascii?Q?GQ3IOx/rF7GiLrvAjvVLQhCZDd31ecx9Gbjd1G8KdZKNP123MFOXRN8z1oOo?=
 =?us-ascii?Q?O1r+2UWqBX0UZzKCFClkBq8lOMUccfQCH47DBWEV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb8c536-e5cf-4b73-ffb2-08dc8cb957be
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 21:31:25.2136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o42ahuIFYddkclE05TFvH7vlzxFnmNKgocyJflnQNB2QnZ0FduF1TY0ZA1vBA7Bz2rsMRg8sD9kPAx4+en537g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10420

Convert fsl,qoriq-mc from txt to yaml format.

Addition changes:
- Child node name allow 'ethernet'.
- Use 32bit address in example.
- Fixed missed ';' in example.
- Allow dma-coherent.
- Remove smmu, its part in example.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/misc/fsl,qoriq-mc.txt | 196 ------------------
 .../bindings/misc/fsl,qoriq-mc.yaml           | 187 +++++++++++++++++
 2 files changed, 187 insertions(+), 196 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
 create mode 100644 Documentation/devicetree/bindings/misc/fsl,qoriq-mc.yaml

diff --git a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
deleted file mode 100644
index 7b486d4985dc7..0000000000000
--- a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
+++ /dev/null
@@ -1,196 +0,0 @@
-* Freescale Management Complex
-
-The Freescale Management Complex (fsl-mc) is a hardware resource
-manager that manages specialized hardware objects used in
-network-oriented packet processing applications. After the fsl-mc
-block is enabled, pools of hardware resources are available, such as
-queues, buffer pools, I/O interfaces. These resources are building
-blocks that can be used to create functional hardware objects/devices
-such as network interfaces, crypto accelerator instances, L2 switches,
-etc.
-
-For an overview of the DPAA2 architecture and fsl-mc bus see:
-Documentation/networking/device_drivers/ethernet/freescale/dpaa2/overview.rst
-
-As described in the above overview, all DPAA2 objects in a DPRC share the
-same hardware "isolation context" and a 10-bit value called an ICID
-(isolation context id) is expressed by the hardware to identify
-the requester.
-
-The generic 'iommus' property is insufficient to describe the relationship
-between ICIDs and IOMMUs, so an iommu-map property is used to define
-the set of possible ICIDs under a root DPRC and how they map to
-an IOMMU.
-
-For generic IOMMU bindings, see
-Documentation/devicetree/bindings/iommu/iommu.txt.
-
-For arm-smmu binding, see:
-Documentation/devicetree/bindings/iommu/arm,smmu.yaml.
-
-The MSI writes are accompanied by sideband data which is derived from the ICID.
-The msi-map property is used to associate the devices with both the ITS
-controller and the sideband data which accompanies the writes.
-
-For generic MSI bindings, see
-Documentation/devicetree/bindings/interrupt-controller/msi.txt.
-
-For GICv3 and GIC ITS bindings, see:
-Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml.
-
-Required properties:
-
-    - compatible
-        Value type: <string>
-        Definition: Must be "fsl,qoriq-mc".  A Freescale Management Complex
-                    compatible with this binding must have Block Revision
-                    Registers BRR1 and BRR2 at offset 0x0BF8 and 0x0BFC in
-                    the MC control register region.
-
-    - reg
-        Value type: <prop-encoded-array>
-        Definition: A standard property.  Specifies one or two regions
-                    defining the MC's registers:
-
-                       -the first region is the command portal for the
-                        this machine and must always be present
-
-                       -the second region is the MC control registers. This
-                        region may not be present in some scenarios, such
-                        as in the device tree presented to a virtual machine.
-
-    - ranges
-        Value type: <prop-encoded-array>
-        Definition: A standard property.  Defines the mapping between the child
-                    MC address space and the parent system address space.
-
-                    The MC address space is defined by 3 components:
-                       <region type> <offset hi> <offset lo>
-
-                    Valid values for region type are
-                       0x0 - MC portals
-                       0x1 - QBMAN portals
-
-    - #address-cells
-        Value type: <u32>
-        Definition: Must be 3.  (see definition in 'ranges' property)
-
-    - #size-cells
-        Value type: <u32>
-        Definition: Must be 1.
-
-Sub-nodes:
-
-        The fsl-mc node may optionally have dpmac sub-nodes that describe
-        the relationship between the Ethernet MACs which belong to the MC
-        and the Ethernet PHYs on the system board.
-
-        The dpmac nodes must be under a node named "dpmacs" which contains
-        the following properties:
-
-            - #address-cells
-              Value type: <u32>
-              Definition: Must be present if dpmac sub-nodes are defined and must
-                          have a value of 1.
-
-            - #size-cells
-              Value type: <u32>
-              Definition: Must be present if dpmac sub-nodes are defined and must
-                          have a value of 0.
-
-        These nodes must have the following properties:
-
-            - compatible
-              Value type: <string>
-              Definition: Must be "fsl,qoriq-mc-dpmac".
-
-            - reg
-              Value type: <prop-encoded-array>
-              Definition: Specifies the id of the dpmac.
-
-            - phy-handle
-              Value type: <phandle>
-              Definition: Specifies the phandle to the PHY device node associated
-                          with the this dpmac.
-Optional properties:
-
-- iommu-map: Maps an ICID to an IOMMU and associated iommu-specifier
-  data.
-
-  The property is an arbitrary number of tuples of
-  (icid-base,iommu,iommu-base,length).
-
-  Any ICID i in the interval [icid-base, icid-base + length) is
-  associated with the listed IOMMU, with the iommu-specifier
-  (i - icid-base + iommu-base).
-
-- msi-map: Maps an ICID to a GIC ITS and associated msi-specifier
-  data.
-
-  The property is an arbitrary number of tuples of
-  (icid-base,gic-its,msi-base,length).
-
-  Any ICID in the interval [icid-base, icid-base + length) is
-  associated with the listed GIC ITS, with the msi-specifier
-  (i - icid-base + msi-base).
-
-Deprecated properties:
-
-    - msi-parent
-        Value type: <phandle>
-        Definition: Describes the MSI controller node handling message
-                    interrupts for the MC. When there is no translation
-                    between the ICID and deviceID this property can be used
-                    to describe the MSI controller used by the devices on the
-                    mc-bus.
-                    The use of this property for mc-bus is deprecated. Please
-                    use msi-map.
-
-Example:
-
-        smmu: iommu@5000000 {
-               compatible = "arm,mmu-500";
-               #iommu-cells = <1>;
-               stream-match-mask = <0x7C00>;
-               ...
-        };
-
-        gic: interrupt-controller@6000000 {
-               compatible = "arm,gic-v3";
-               ...
-        }
-        its: gic-its@6020000 {
-               compatible = "arm,gic-v3-its";
-               msi-controller;
-               ...
-        };
-
-        fsl_mc: fsl-mc@80c000000 {
-                compatible = "fsl,qoriq-mc";
-                reg = <0x00000008 0x0c000000 0 0x40>,    /* MC portal base */
-                      <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
-                /* define map for ICIDs 23-64 */
-                iommu-map = <23 &smmu 23 41>;
-                /* define msi map for ICIDs 23-64 */
-                msi-map = <23 &its 23 41>;
-                #address-cells = <3>;
-                #size-cells = <1>;
-
-                /*
-                 * Region type 0x0 - MC portals
-                 * Region type 0x1 - QBMAN portals
-                 */
-                ranges = <0x0 0x0 0x0 0x8 0x0c000000 0x4000000
-                          0x1 0x0 0x0 0x8 0x18000000 0x8000000>;
-
-                dpmacs {
-                    #address-cells = <1>;
-                    #size-cells = <0>;
-
-                    dpmac@1 {
-                        compatible = "fsl,qoriq-mc-dpmac";
-                        reg = <1>;
-                        phy-handle = <&mdio0_phy0>;
-                    }
-                }
-        };
diff --git a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.yaml b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.yaml
new file mode 100644
index 0000000000000..505428d29ec3e
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.yaml
@@ -0,0 +1,187 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/fsl,qoriq-mc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Management Complex
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+description: |
+  The Freescale Management Complex (fsl-mc) is a hardware resource
+  manager that manages specialized hardware objects used in
+  network-oriented packet processing applications. After the fsl-mc
+  block is enabled, pools of hardware resources are available, such as
+  queues, buffer pools, I/O interfaces. These resources are building
+  blocks that can be used to create functional hardware objects/devices
+  such as network interfaces, crypto accelerator instances, L2 switches,
+  etc.
+
+  For an overview of the DPAA2 architecture and fsl-mc bus see:
+  Documentation/networking/device_drivers/ethernet/freescale/dpaa2/overview.rst
+
+  As described in the above overview, all DPAA2 objects in a DPRC share the
+  same hardware "isolation context" and a 10-bit value called an ICID
+  (isolation context id) is expressed by the hardware to identify
+  the requester.
+
+  The generic 'iommus' property is insufficient to describe the relationship
+  between ICIDs and IOMMUs, so an iommu-map property is used to define
+  the set of possible ICIDs under a root DPRC and how they map to
+  an IOMMU.
+
+  For generic IOMMU bindings, see
+  Documentation/devicetree/bindings/iommu/iommu.txt.
+
+  For arm-smmu binding, see:
+  Documentation/devicetree/bindings/iommu/arm,smmu.yaml.
+
+  The MSI writes are accompanied by sideband data which is derived from the ICID.
+  The msi-map property is used to associate the devices with both the ITS
+  controller and the sideband data which accompanies the writes.
+
+  For generic MSI bindings, see
+  Documentation/devicetree/bindings/interrupt-controller/msi.txt.
+
+  For GICv3 and GIC ITS bindings, see:
+  Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml.
+
+properties:
+  compatible:
+    enum:
+      - fsl,qoriq-mc
+    description:
+      Must be "fsl,qoriq-mc".  A Freescale Management Complex
+      compatible with this binding must have Block Revision
+      Registers BRR1 and BRR2 at offset 0x0BF8 and 0x0BFC in
+      the MC control register region.
+
+  reg:
+    items:
+      - description:
+          the first region is the command portal for the
+          this machine and must always be present
+
+      - description:
+          the second region is the MC control registers. This
+          region may not be present in some scenarios, such
+          as in the device tree presented to a virtual machine.
+
+  ranges:
+    description: |
+      A standard property.  Defines the mapping between the child
+      MC address space and the parent system address space.
+
+      The MC address space is defined by 3 components:
+        <region type> <offset hi> <offset lo>
+
+      Valid values for region type are
+        0x0 - MC portals
+        0x1 - QBMAN portals
+
+  "#address-cells":
+    const: 3
+
+  "#size-cells":
+    const: 1
+
+  iommu-map:
+    description: |
+      Maps an ICID to an IOMMU and associated iommu-specifier
+      data.
+
+      The property is an arbitrary number of tuples of
+      (icid-base,iommu,iommu-base,length).
+
+      Any ICID i in the interval [icid-base, icid-base + length) is
+      associated with the listed IOMMU, with the iommu-specifier
+      (i - icid-base + iommu-base).
+
+  msi-map:
+    description: |
+      Maps an ICID to a GIC ITS and associated msi-specifier
+      data.
+
+      The property is an arbitrary number of tuples of
+      (icid-base,gic-its,msi-base,length).
+
+      Any ICID in the interval [icid-base, icid-base + length) is
+      associated with the listed GIC ITS, with the msi-specifier
+      (i - icid-base + msi-base).
+
+  msi-parent:
+    deprecated: true
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Describes the MSI controller node handling message
+      interrupts for the MC. When there is no translation
+      between the ICID and deviceID this property can be used
+      to describe the MSI controller used by the devices on the
+      mc-bus.
+      The use of this property for mc-bus is deprecated. Please
+      use msi-map.
+
+  dma-coherent: true
+
+  dpmacs:
+    type: object
+    description:
+      The fsl-mc node may optionally have dpmac sub-nodes that describe
+      the relationship between the Ethernet MACs which belong to the MC
+      and the Ethernet PHYs on the system board.
+
+    properties:
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+    patternProperties:
+      '^(dpmac|ethernet)@[a-f0-9]+$':
+        $ref: /schemas/net/fsl,qoriq-mc-dpmac.yaml
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - ranges
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    fsl-mc@80c000000 {
+        compatible = "fsl,qoriq-mc";
+        reg = <0x0c000000 0x40>,    /* MC portal base */
+              <0x08340000 0x40000>; /* MC control reg */
+        /* define map for ICIDs 23-64 */
+        iommu-map = <23 &smmu 23 41>;
+        /* define msi map for ICIDs 23-64 */
+        msi-map = <23 &its 23 41>;
+        #address-cells = <3>;
+        #size-cells = <1>;
+
+        /*
+         * Region type 0x0 - MC portals
+         * Region type 0x1 - QBMAN portals
+         */
+        ranges = <0x0 0x0 0x8 0x0c000000 0x4000000
+                 0x1 0x0 0x8 0x18000000 0x8000000>;
+
+        dpmacs {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            dpmac@1 {
+                compatible = "fsl,qoriq-mc-dpmac";
+                reg = <1>;
+                phy-handle = <&mdio0_phy0>;
+            };
+        };
+    };
-- 
2.34.1


