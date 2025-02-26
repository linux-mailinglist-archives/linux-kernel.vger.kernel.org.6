Return-Path: <linux-kernel+bounces-532777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5335CA4521F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70E7A3ABAAA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 01:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0E218756A;
	Wed, 26 Feb 2025 01:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cixtech.com header.i=@cixtech.com header.b="XAdk3kVy"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2130.outbound.protection.outlook.com [40.107.117.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00C314EC73;
	Wed, 26 Feb 2025 01:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740532905; cv=fail; b=kaXPMIYgndEIzBHkVdlS8EaoLfEAVz2YWJWt57Egugc9fmeZN45HMOrlV1YxU5cAfMLq60P8BzgIUobBGQ628qWnmI5I1TNGnrD6oywALJcT5ZTNaWDbZ1gbEQmCE4bwALmSVMD9AGTXCT+3RUU5McpIJJiN8i/y8pKw66zuwg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740532905; c=relaxed/simple;
	bh=KB0NMbgO03a79xTXx5GKporeC59JkvNcL9mcIwjBK3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qNC24Y19EHqj7IRbBDEA7FKj0NXb7mrHmXFB2y10bzo2B0IdqiPvWhuTTG6CGD2yXS2jve6lqHk/pZu8wlSE+kn1I6XtrCjJZVqcY+Uo8fHM3t5zcuCNimVzEnHt51o5+Jv2XLA+xIflT5CZd2t8y911IX/OyZQTnGkgpVlitUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; dkim=pass (2048-bit key) header.d=cixtech.com header.i=@cixtech.com header.b=XAdk3kVy; arc=fail smtp.client-ip=40.107.117.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BDN1JJmCBkf8UDeDZPHysAxJR7nsHQ/ONoQfrepZf1uVlusW+tsia5Bh409+eIkDVGCnRYuXT0RkiXFEjqD58J9byS3GooUaefx8PPMwg2aAxReGQIyQGV8+Wq5ViMWGCpEsiANrizQkjDEDMjzxNTdVC4WdkzYYBuzk9SfRmS+/z/0rxgLYXwur9xrgK2g1+k5dUuqnVP0HHTlCfa/9bfOYNhOsL8k6jECGAttOlEVXfq7cSRavHaVDx0E95XZXLKVTv81C2P3P/Ej2s/Jc80a3WJcBPZvdSFFbHZWVGcT6fZqFbHYjT1g2KQAMVlZ52WFgAQvpzHlOjWe+NHoQcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASEOde3FKdXXGfs0wJN/vrVK1YqOLY0Hwr6UhkvoauA=;
 b=UeYmSXbN3ttF8r6PUljUgwh/otu2/CvgBUcZw0SFxrLA2y3YDo6ymBMwdTRGAhYuh0yB01NnGlHm7eIlvnZOh7pA+8VXtIjkvsIBsjJvVAj5+w6uFkX6ndxaxA4AEe7bDMjVUC/IIxGCAKj9XXBaXKaUZ4xn3QVfZg0nqeE2dBkLDj8dRTSRdO561n8hIqBJ2tVk6t/zzNGh8xOiP0Cy3ODo2dMGRf1k3jSih6Q3CkMaFS3UKBMP0+ZYNtlyKCiK0TBRM1tb2B3EMiK7Seto0Hi/IVlRx9tNzJI/7Dg6mrtzEWiVrNTlVxwUEpRyZQFDzge4SsV6AnWuhoAhM0oqdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cixtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASEOde3FKdXXGfs0wJN/vrVK1YqOLY0Hwr6UhkvoauA=;
 b=XAdk3kVyqFrIIHUCmE48JqyqUFK4flVznu44PxKcyV7roa47rwszeXnr4aCHJbt0iB95oJQL1fYBFDBDYEKC5N2f1YBGK42BQx7KA820YSnDAMhOGqlWt0YB6bduY0ZZd+t4/YmH+JZM0Vh5H/FVkfCRItUp0Fzv/1XKxNY6ag47HTkpHvDSfPVGyGvqOqGlmdztBa/sEmWb+OzZTnahfVIAMuTe/6L1+BOpppnh/4eMDHMZpLslkCVbRWCXcg5Wpf0AVF0SUmV457utq1N43PFAdbvtP2PXoFGy16OX4bYddaR5cGfrOURhN0fxFva1vEOizKXf9z6NFifULO5Dig==
Received: from SI2P153CA0003.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::20) by
 SEZPR06MB5622.apcprd06.prod.outlook.com (2603:1096:101:c8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.20; Wed, 26 Feb 2025 01:21:38 +0000
Received: from SG1PEPF000082E3.apcprd02.prod.outlook.com
 (2603:1096:4:140:cafe::3d) by SI2P153CA0003.outlook.office365.com
 (2603:1096:4:140::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.6 via Frontend Transport; Wed,
 26 Feb 2025 01:21:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E3.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 01:21:37 +0000
Received: from localhost.localdomain (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 6C3B341604E7;
	Wed, 26 Feb 2025 09:21:36 +0800 (CST)
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
	marcin@juszkiewicz.com.pl,
	Peter Chen <peter.chen@cixtech.com>,
	Fugang Duan <fugang.duan@cixtech.com>
Subject: [PATCH v2 1/6] dt-bindings: vendor-prefixes: Add CIX Technology Group Co., Ltd.
Date: Wed, 26 Feb 2025 09:21:31 +0800
Message-Id: <20250226012136.854614-2-peter.chen@cixtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250226012136.854614-1-peter.chen@cixtech.com>
References: <20250226012136.854614-1-peter.chen@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E3:EE_|SEZPR06MB5622:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0b329291-7978-4caf-f1ed-08dd5603ea52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GWoCZogjXzzVRilZ0CvTj5VChkLxALcBx2i2Oo+7TZ6lTogYxTKNn4ayEWf4?=
 =?us-ascii?Q?wpIuNH8CB22geiCWUBU+pThYxg3t1e7NKPyPSLns8ETz7m3Jpv4ikVhUWBkx?=
 =?us-ascii?Q?zD80sHkKJkKPIJoKe4nKNtV8nHxNIDSV6Q5yy8bUc6gdLFoGsFQKe8OhMytt?=
 =?us-ascii?Q?mb9oSBDLW6yCPGYCpBljLeWuMG69B1+g69kwEjkYIRqgyxRwKtRp2MCv9B6Z?=
 =?us-ascii?Q?I6GaogWpakDFZHOYlv326HHyXlGRZ4kNLF0CXTrJqZ4OxWOuBFIubOR2pCC0?=
 =?us-ascii?Q?HiRa4fDLlXm/olsm2VjSUm09yp1FOrEPQo+Zkefz3yhvH5G+g/V1XbSngFZE?=
 =?us-ascii?Q?/YVjINsnZqSZnspaQLcGGOz3OUpdW7Be/uY/0Vpgf6H7QqM5bXdR0xJCnnOt?=
 =?us-ascii?Q?LBd2jD5Bl2dRlhNGeyaCw2sLaWwZqFc91MqvFyTWSUBBq8poX9B8AXbe+yFy?=
 =?us-ascii?Q?/x85suBxUUrDxhCUSdXN+lYAx0P7YlPL733eT+G3kWeNTL9G9HH60HepmnuD?=
 =?us-ascii?Q?h0+vKXa8DLGiMxccN0Bvavas05ldfr+zISlS6QAgfFeqdy56acM//Jd6jkDI?=
 =?us-ascii?Q?XRNWj86VJwmdLMy/6YbSOVGXSnuPMleB4MMsRRrfKSCeUNjzuvjxa0ICYGaw?=
 =?us-ascii?Q?31NxlUYY4e99lDijqE8BwNvtQpcsAy83u5yX/9b2CuLeq7fFBgocuyS/J9Ro?=
 =?us-ascii?Q?yLp5NU1z57ZUmGEKeujEeIgaUxXoCTaC62DtHeGfBY3tOKf1/aI7aOex99j5?=
 =?us-ascii?Q?/EC0s5ZcjZrCd7Iw/GHmpgD/QRLhZEPr/j0iQ1ayW0HxFGU9MAUiev8ixbpG?=
 =?us-ascii?Q?pWjFltTmn3tV+lIP/NLt+MZfQvwzmWPCfNtK4U/+a4XEH0ga+Kpa3wrIV4v1?=
 =?us-ascii?Q?LI7hxBtYEEuzAXMydwrmpwf00MH0EihrKWvumS+uZIA/4cBLZulXFkSgseNv?=
 =?us-ascii?Q?euCF8+XeMUftyRLyQEKFTw3nfXvGOp9lO7qyOsewQYrx0vaw+POq+dSUbUwO?=
 =?us-ascii?Q?8FOkj9rSPiqoIIFQzK7gPWRLciwPiRj2BwPh+kxMAqWadk6GPg3EmRDRRsLV?=
 =?us-ascii?Q?rRWaXzUGWDTp7WWPMIeiHj97NzkfxT4MNy/aw3yiKNRy6jqMD2qj3QWCY2Lz?=
 =?us-ascii?Q?rCK8sSP8zE0oKQERMEvJhpDyqb3Si3jTBUrBiiIt0YvTTRvJsyTdcZ7yYuSn?=
 =?us-ascii?Q?jrMdR9zjEIkJiAVUZg/N7vpERvs2IUMBv/PzwCTFChuIjIZ3yfLafTCUYvIp?=
 =?us-ascii?Q?OXGwJ0Wm9gynaFiduHuueTEYwJoKR85Ni4QZ5hT3vYIsxvwcuthew8SiZpna?=
 =?us-ascii?Q?//ogEcY+BP+ZUBwga/xY6rvaM/bc7R2r9/QzRlXEoQbBvh9EOSWBW7obh//z?=
 =?us-ascii?Q?RCYBtycOsNWpa5tU9pB2VDNkU1PteuW/npUnwtCURjo09I3vCurDrv7s+HWz?=
 =?us-ascii?Q?xLJgiPCMmBg=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 01:21:37.0798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b329291-7978-4caf-f1ed-08dd5603ea52
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E3.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5622

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


