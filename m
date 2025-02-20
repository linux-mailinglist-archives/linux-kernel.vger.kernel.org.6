Return-Path: <linux-kernel+bounces-523194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC68A3D36C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17292171A6B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD6B1EB9F3;
	Thu, 20 Feb 2025 08:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cixtech.com header.i=@cixtech.com header.b="fnlrk/B2"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2136.outbound.protection.outlook.com [40.107.255.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78EC1E883A;
	Thu, 20 Feb 2025 08:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740040827; cv=fail; b=uL2nTeltpMumW1kjLjkadVTJ5hKDWdqiILAZNChSiYPkXEgNY4hWPLyMILUy60Aw2QZdQnAq1fLC/s8L6IvPHLYd9BQ8dOrHo7esXVFInG0X3XL6PK1PVUD4vJLjpQd+ObsM/61K3K6o2We8IvmIj966cK8GOuhZh5ll2VRW/dM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740040827; c=relaxed/simple;
	bh=KB0NMbgO03a79xTXx5GKporeC59JkvNcL9mcIwjBK3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TpoZMdxdKkf3T62nTp6WbrjQCyp8zCoL0+SF1Ka4rG7IBXCIXP4y+Wh1I4gXx5SLq5pNIGnNQLgl5CnMRtquBe9h7WnhE+j1jxt2GMWCxgeqT1BrUREq85x3hkRkCAzYGQaZET5TMjqZMssdpWbgRTSKdX18lST75j/dijys8zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; dkim=pass (2048-bit key) header.d=cixtech.com header.i=@cixtech.com header.b=fnlrk/B2; arc=fail smtp.client-ip=40.107.255.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dndUSacLb2V/wxwLfB4ilIXEkDenpm25t7ssOcBeiV5/N+meGjYaGKIZeu9CBzkP+8f0e4ovD4gyxLs77falqPoMKpO9k9+YbebJFUf8Jp0uq736+xwDWvqKQY1bLCbFJrlLjQEWKnRV+g3ZuNoaA0SPweBpIF1MfEbph2oVcA5js/cWZoIBGWRhLLZeCV/5EYk6LA+thiW869fcJeng2ACEO132l8Z4LdRQU92mOBa+QzU+SyRa44H+/isstB67seji91RlfnWUAz5YhIvPvo3seiUpuKTqATfxJzVDsJ7NvSYmYCk+sUJqvTl4agrOsKfWNpFfQC9zChpSJduuYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASEOde3FKdXXGfs0wJN/vrVK1YqOLY0Hwr6UhkvoauA=;
 b=HHB7FjhEc4zU2HVNjWK64oFY3oHV9dbY2LGSCr913bye5cNVPDS8avbLB0A8Nyt7op8wp5Z3b2FeYb2r+gi16c7b+N0OMg10q4oexrfBnyUI5kaW0ajNacOuAt3zmAVyPUM3/i3fQrqbfdiY98Hz7zDgTZBF9XcXlB5XMOZpL0I5eR21uLWfeWU+F3qwBf+xOJ58UWWIbg969UZ/V2IZ5xgepOefXKdHfK0u6RyVoadZ9UucIu3BZXu1BxW3rv7VEY91lrpXUBm0uuPFzXPuaxY8ajLbtlfe/2yFA22ZpdRA5TpuIyAIaXT6aYOISpCRPkohtPn9c2Ldesh1FI2poQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cixtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASEOde3FKdXXGfs0wJN/vrVK1YqOLY0Hwr6UhkvoauA=;
 b=fnlrk/B2vkPuN2Kt8uj2Z9fdHqgvDyTvLmuqZ4JXoblWawDefPtK0hMGfnp72fpbu5AF3xDXdY/0cpf6B83qHHofw/NiuCzH/NRWgYA7gdKciT+fvUFC0/OX0D1Jaaks+UHRCOidRHZVLPEtAb0XDCXfY3zIGJOclBcN/NXwobhsuPNvXx4jPAErP8yIGH2FK776AMdXwdXNCS1umF+avSLUwiAXDXRoELFh7TKkyqtRF330mjTxebDZEkml+FmcQpQOvK3GeYH0aWSe9hfW8PC1VGxbRHtdT5DxOeOGJeAEEMXw/ZTo7NNLBE1e/ogzSfmli4Mtl5tjitIJHOPoBw==
Received: from SG2PR04CA0160.apcprd04.prod.outlook.com (2603:1096:4::22) by
 JH0PR06MB6603.apcprd06.prod.outlook.com (2603:1096:990:31::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.16; Thu, 20 Feb 2025 08:40:22 +0000
Received: from HK3PEPF00000220.apcprd03.prod.outlook.com
 (2603:1096:4:0:cafe::62) by SG2PR04CA0160.outlook.office365.com
 (2603:1096:4::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 08:40:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 HK3PEPF00000220.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 08:40:21 +0000
Received: from localhost.localdomain (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 8450441C0A03;
	Thu, 20 Feb 2025 16:40:20 +0800 (CST)
From: Peter Chen <peter.chen@cixtech.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	arnd@arndb.de
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cix-kernel-upstream@cixtech.com,
	Peter Chen <peter.chen@cixtech.com>,
	Fugang Duan <fugang.duan@cixtech.com>
Subject: [PATCH 2/6] dt-bindings: vendor-prefixes: Add CIX Technology Group Co., Ltd.
Date: Thu, 20 Feb 2025 16:40:16 +0800
Message-Id: <20250220084020.628704-3-peter.chen@cixtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250220084020.628704-1-peter.chen@cixtech.com>
References: <20250220084020.628704-1-peter.chen@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000220:EE_|JH0PR06MB6603:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b3f68771-6064-4950-fed0-08dd518a3671
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9z9kzpKQTiX5NMPmjap7rPDMhdu5fP05X4BCARJjFCuiqcVmIO7FAlFUSSd3?=
 =?us-ascii?Q?OHWovyMQhojt+Fk3QJ0NKN/hAXH+CCBc4k3DVW/i1fdYsoTFYj3kOR558rzF?=
 =?us-ascii?Q?HIKGeTH/2eV1XqVJ/UiglXZszYI+s2V8b5MDIS1TLOLwZViLcvBHaWvSxd6I?=
 =?us-ascii?Q?54CKApQRQd8C0gS39ZpC8S/r+S7s1fUOBRG/ZOIiQc19Y3t56vymWi9RXXza?=
 =?us-ascii?Q?Dr+0k9YOoXe0BghTam3PEdX0/Pdkpu1HR7aUHRgJZEmcVjSbHJtDf33L2Smz?=
 =?us-ascii?Q?QgA3+Y9tESvgUqgMHYsPhHV7zPPyF39QBjpb2FN2XOOUaFYScgC5ia1rCaPV?=
 =?us-ascii?Q?85B1y0/2YLfXNPCQbKu+XKDhi3DZSzz8Ryp/1M2ywJT7x6aj62QD1H45A0u4?=
 =?us-ascii?Q?rxajQ+WXVHV9Wc2bex0ElaUl6/H6j3XWt5r+b6MaLggQtKCdfCdZ3VNki4bM?=
 =?us-ascii?Q?nLkqxlNcyOrIh1msJKOWrYGVuZtXzgtBumfBdbpLGrG7r3raRQGO42g4fSyA?=
 =?us-ascii?Q?4PG2hf8Y/57Su4b/WqCAEPlYO4XfNLOfsLqJztHPMQ/qgomIN2+bBs7H5WBW?=
 =?us-ascii?Q?gUQQ6xiS23Qrlrwh34GMI2/TkAYlVA8rNY0M+uBwuvyPTQySJJpr/VwoimWM?=
 =?us-ascii?Q?zXuCFyxeMF4yjlg4nlMBXzvmjecxKOaRK23gndQdfpXJz2W9yk/8gmD/8oT7?=
 =?us-ascii?Q?8LsP9/zlAcX01VcPAW7JzwQV/PdBcL20gapc2EnRgPWwwiNBimOtB4jSrcjr?=
 =?us-ascii?Q?K8wYYE1FAT+VHEhOAJHdWmhOy2nXrxnnIooC9xXBIrkmsdV6BR3jx7NKOgB+?=
 =?us-ascii?Q?dG4lsGCgUJv+hRo/Ez0xAieN5hoNFEsAqGjQwpYBSrfy/Prm9n/+0q8WmAvi?=
 =?us-ascii?Q?Yk8KPklDW3P1oJH3jfK2MB74ztNEUyUmPr79bJjP4kUyPQuhU3F6lz80IOBK?=
 =?us-ascii?Q?cfyXDcs8o5ICA2NvvltWkS/mAefd7iAoo5Qyg7Ms3+ZqCO/eOHaOXDfgHRf6?=
 =?us-ascii?Q?nBXdnRLF12BtK/4PUwY+dbCXUlnxl8MbI9feCVKZX4B7X7oTnOpuXtOph/jS?=
 =?us-ascii?Q?JfNHZu8qb5tYsltHBno5C2rYrKbXqHc0Ybr6UbKvUUx/ANAQNWUs5c9oVUns?=
 =?us-ascii?Q?d5p0WJFtEMKT/2SKgUCX9xfvgWc2fRV2P9P58aUyBJO1uywTfJrlGWbIvM7f?=
 =?us-ascii?Q?02EukfEfOHeZCCVKilEoyq6s3koHRQxHO+pNivNPfkV1tQ8WtqMIEH2vFNLy?=
 =?us-ascii?Q?tI4cP2w2w9LuIXsncj9dlQwiMKAfPsbnyYTpwwSVfiowV7Y2ITSzbUu1h1b8?=
 =?us-ascii?Q?CxR+cgodRXrSO9kF3O6wTrRs/lAO99rKnI6ik0PcPECQQZHI4h9d+LCgeUVn?=
 =?us-ascii?Q?U6IzGl7aDwH9eWEBA1juJNyQqPLqd/nejeS9Pn1e+J0Wsur0cWdlJ60ZjcSY?=
 =?us-ascii?Q?3pLKWoQ8eCI=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 08:40:21.4130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f68771-6064-4950-fed0-08dd518a3671
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF00000220.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6603

CIX Technology Group Co., Ltd. is a high performance Arm SoC design
company. Link: https://www.cixtech.com/.

Acked-by: Fugang Duan <fugang.duan@cixtech.com>
Signed-off-by: Peter Chen <peter.chen@cixtech.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5079ca6ce1d1..5e76223e4570 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -302,6 +302,8 @@ patternProperties:
     description: Cirrus Logic, Inc.
   "^cisco,.*":
     description: Cisco Systems, Inc.
+  "^cix,.*":
+    description: CIX Technology Group Co., Ltd.
   "^clockwork,.*":
     description: Clockwork Tech LLC
   "^cloos,.*":
-- 
2.25.1


