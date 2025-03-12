Return-Path: <linux-kernel+bounces-557492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2BFA5D9F9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A44B9188668C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 09:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C190323F260;
	Wed, 12 Mar 2025 09:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0YsvsB/1"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C921A23C8C2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 09:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741773279; cv=fail; b=smmXRfMNFODaz1+IHsEf3q0Z47BqkeoZiJhJa8zFUIQHyPrnjhfhSLIczYmmkaVPCGMRQKz0DCrXFNggmwwnlB7prFrE0IPw+1Eu/6WJzJVgwLZ9K+aF0lGZQGvm0QnVTXIB+DIk0SBAnG09pbw/Lb774jisCNUBunT+YdsOQGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741773279; c=relaxed/simple;
	bh=npIqzhvncJP2vd+1sm0Vjp+jjo+H7m4fnzoMuovAMB8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F97QYHAzR6sSq9Q4dr8Qp6ldy4Ut0ZeNznXOFyAWgj4gANqpyOVE4tzIAB1UKPA/bkrWNCB5J6ouKRk65lsi+gAhu4N/5FjRWdy2oeKwBml6X7vKvhpT++aGDr/HlJD3NwXiAyxpIxzFP+QqbyfMxrcdEJvosRF+7W03Aj+r0Bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0YsvsB/1; arc=fail smtp.client-ip=40.107.236.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yIpyiUosv+BMoAUARlJFnFMve7XdNNoiCoG+hWHZPxKfZ0XykYAsOuNwU/kWya+OZ7VtE5D7cNq82WMHCWeIDFkwVdQQSFgejMrvWS+ek0pAf58/Lmf/Oi1GdzRbenFxNIF5YbfuPmHiXHoOCJGXwrkvjFpW7ZArzOOEWqacrOzXx4tiIqil7dcbS8D5bMa07ULxjJvAhtX2p/BJyv4Q2smFslFClJOPyv5KdPWjgdOL1sRKuoNi3CWykzOqyYXa2NQ4Y2BcshrLJFGug3rgFJ3nzJIhTaMI5MpWmsMJi7iixp+nrDOwGcMJky7sma5bFzvsN7M4iEZbBzWl+mA6dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylMHCKCya+FO1W2HFFT6e/PLUtrQlLiTUzzfeCAfIpQ=;
 b=uJMCrd3qCJoA/mmwvjzA3TrZvwqCLS32jotwEg+B4zNsDRPo3Fadq5Ij8KpfrDgcTxbFlt51RhxJNEcaAOanExXueV3vKJKL3eMpHRJoAKiAUmykl7/oYF61eXr8dC+8SLN0nUAM1tAY7UESOW49cz23xYnqbCZo8gr0AG4njXCIrpudZ66NbRmpdI+aeGaWiVFnwebmtZ2S6DuBjwtouU/EJl1BtxVDGFTWXFqecc1yIm8J1oXNR5s/uQjvwETwPWisu9RiNRwRgbfmrBCFdB6QTxW426s2aSFPhW/Zy2nly+tgN6zsetK4cwpoGNwWezmnP2QPeOYzFSG+BNGL2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylMHCKCya+FO1W2HFFT6e/PLUtrQlLiTUzzfeCAfIpQ=;
 b=0YsvsB/1DOUZs4lPrHBnZcG7mfM6s2+cvqFA6VgM5W4PZTLehTYNcYmdqbGF2MeoOj/j3JDxjEnanuGGmtjpBzI4JIqXJ3D6rWzKbZp1tMownPeehAM7OT51DDV0XEbWXhLiJ+98pdjlF9SmYDCMRFyWqXSTcv3X64EvyiqB/8s=
Received: from CH0PR03CA0093.namprd03.prod.outlook.com (2603:10b6:610:cd::8)
 by PH0PR12MB7983.namprd12.prod.outlook.com (2603:10b6:510:28e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 09:54:32 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:cd:cafe::8c) by CH0PR03CA0093.outlook.office365.com
 (2603:10b6:610:cd::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Wed,
 12 Mar 2025 09:54:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8549.1 via Frontend Transport; Wed, 12 Mar 2025 09:54:32 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 04:54:31 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 04:54:31 -0500
Received: from xhdnipung41x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 12 Mar 2025 04:54:27 -0500
From: Nipun Gupta <nipun.gupta@amd.com>
To: <linux-kernel@vger.kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <derek.kiernan@amd.com>, <dragan.cvetic@amd.com>,
	<arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC: <praveen.jain@amd.com>, <harpreet.anand@amd.com>,
	<nikhil.agarwal@amd.com>, <srivatsa@csail.mit.edu>, <code@tyhicks.com>,
	<ptsm@linux.microsoft.com>, Nipun Gupta <nipun.gupta@amd.com>
Subject: [RFC PATCH 2/2] dt-bindings: add device tree binding for silex multipk
Date: Wed, 12 Mar 2025 15:24:21 +0530
Message-ID: <20250312095421.1839220-2-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250312095421.1839220-1-nipun.gupta@amd.com>
References: <20250312095421.1839220-1-nipun.gupta@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|PH0PR12MB7983:EE_
X-MS-Office365-Filtering-Correlation-Id: e0619b5c-918f-49f5-ab8e-08dd614be36d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cStxdXI2K1R4Sm0xUEpWS25ETHI0cUJBaUlWaTNRMkIwb3VESUxraHBmYmFy?=
 =?utf-8?B?R1BhbjNxWi9RbDVDM1BmYURRRDJheUMwT0M3c29URkFIaHhSUmptRDFHUEZl?=
 =?utf-8?B?aVlyNksyb0tQTUsrOE9NR2lzd2YvMTdXY1BXTHZKNkhpbTl2VlgzTThYNmV0?=
 =?utf-8?B?L1RWK2tWRGNRQlZGQWtSWXpCS3AraGV0U1RadFE1MDJLeDJyNEhzb0pmSjBx?=
 =?utf-8?B?ai9haWFzcm9rKzdORUVTWXZuS2hmdUlkRzVIVUtCMjZVWmxhdy9NdHF4d2dU?=
 =?utf-8?B?TTFoSjZEcS9MZVA4ckdQdU1hTkFXWGJHeFZVcHVBQWwwdDRkVFFzaGJxZUxC?=
 =?utf-8?B?d0xFZEJVK0lzSmxWWG80VG42Yk9sK0g2MkdaK3dQUUs1b0U2OEFod3BHK1U4?=
 =?utf-8?B?akhPTFQ5dUtrWnZjSlg2M0NuVjNvNTl3NTBTYWRYcWpaT0ZvQ3I4R2xvRXgx?=
 =?utf-8?B?cXF0TFVRL2tFVlg5alQxVGNvRUUvVUpzNmYrMFNkNlRiOXJEZkdwMXI5eHY4?=
 =?utf-8?B?ZCtEenVXTWZKeld3TG1KR0N2ZlV4dFJtZ3FFWnRjcS9SdS9XSnM2OVVtZG5m?=
 =?utf-8?B?ODdGYTB4SVNlZU5VUmZNbU9ldUo5SW11NmRCS0R4WEd2bjdDbFRVV3p3ek03?=
 =?utf-8?B?eE8vbzR2YVJOTHI2SUNGZ1FFZ2dmcW5JRUFLazJyeG5pOGd6cXg3Z21WUkZi?=
 =?utf-8?B?QVNLSUF2NHBmTDh6NDNGK0Zjek9IeXhtanFNN0x1M0d6Q2JCaEM1N2tPSG16?=
 =?utf-8?B?bHJ1Umt5NGZ2V1JZS3lTdmJVc201UXZ2S1VzOE9pR2FENFRqNVJZVE1POGJj?=
 =?utf-8?B?VEhXOUJrd1gwdndIcFcwUERJMlh5UTBvVDZnZTQrOUtXUXNuL1laeWlxOWlI?=
 =?utf-8?B?V2dDdC91cFBoUXljaHcwMFhxT3MwbU5DS1ZvOHM0ZUlwb3l2MCsxaFI2dnE3?=
 =?utf-8?B?bXdmRDM4cWJGdm9yaHFhNHpEZnNDa21OY3U2SmdHRThIZ2tjSEJqNlI0eGxo?=
 =?utf-8?B?NFpnTzhVeVpDQlN6eXFlRFJFOU9TZmhzQWpCZm1QRis0bzU5a3F3Y05LWmFL?=
 =?utf-8?B?V1BTRk5Bc25xQnBycldpOFlnam95UG85NmdSeXFtMWdTckc0ckFIVUJGVGRR?=
 =?utf-8?B?WUhUYzJqMEJmUHZtOXIyUFFQRDJVcmFqb3luNmduckY3ZGVWVEd5SjVFbkpU?=
 =?utf-8?B?NCs4dXAwSkk4YS85a3h5WDY1RlZJdld2TTQ2RGFacjFwVUJEeDJ5WHNpdS9K?=
 =?utf-8?B?Rjk3UVE0NzRxL1NYRWo3Z3pBalppZHJwMkVSNm9aMWl6TGJVdHZ2OXBEY2xR?=
 =?utf-8?B?MFNUNzZ3dFZzQlpoVU9pLzhMWm14VCtXcVptUjNJMFlzNVJiQ3pqTmZUQkVu?=
 =?utf-8?B?NUNCYk9samlNbGtNcnVia2xDT0pTdGQzRXhTMTN5MzBaL1VRMnF0eFBBVlpB?=
 =?utf-8?B?NVlZb01jV2pIcmRYdWxWMmFpQWlvU3VZaVlOZGZnVGtVTHlDNjVqNWRmRWhJ?=
 =?utf-8?B?ZnN4MVRpTnk1U3NxQ1lValpnbzlwdEYvV3FnbzdHTEVaQUVFZzhsdWVSbW5V?=
 =?utf-8?B?UStETlZrWWxSUWhEZHpwcVg3RmkyWnhlZ3ZwUVFrTkw3YmFKMnJWOTFJRGh3?=
 =?utf-8?B?OXc0MzY0eDlmK3ZmNVBGZFBMOFUwM0JqZXRsS3F1VGd4aURDUnIxN2ZxTDdV?=
 =?utf-8?B?MXZTMFpZMmZzSk1wVGdRVjAvSlhzZ3VlbHY3bFJQZGhhUVpHTDdXRU9Kd0RJ?=
 =?utf-8?B?bm4xZ1M1dS9SbnJLVENyOGxpN2J5cFNRVlZId3pDRFpWTDJaWUNzWDkrejE0?=
 =?utf-8?B?d3AxMDI2dzZGa3doTWpQb3pseWMxazN2V1ZmZ2JFMWxvVHljcitwTUpPVURa?=
 =?utf-8?B?Q0xzaENvSFQ3djJTZ2ptZXAybHMyV1ozR3lZK2dkdktJa0JxK1p3aHJzTXFm?=
 =?utf-8?Q?5z4oX1tdPzSChiL6hORxy9cqKc1dHRbu?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 09:54:32.1754
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0619b5c-918f-49f5-ab8e-08dd614be36d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7983

Add binding documentation for Silex multipk device node with compatible
string as 'silex,mutlipk'.

Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
---
 .../bindings/misc/silex,multipk.yaml          | 50 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/silex,multipk.yaml

diff --git a/Documentation/devicetree/bindings/misc/silex,multipk.yaml b/Documentation/devicetree/bindings/misc/silex,multipk.yaml
new file mode 100644
index 000000000000..6951886734ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/silex,multipk.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/silex,multipk.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Silex MultiPK driver
+
+maintainers:
+  - Nipun Gupta <nipun.gupta@amd.com>
+  - Praveen Jain <praveen.jain@amd.com>
+
+description: |
+  Silex Multipk device handles the Asymmetric crypto operations. The
+  driver provides interface to user-space to directly interact with the
+  Silex MultiPK device.
+
+properties:
+  compatible:
+    const: silex,mutlipk
+
+  interrupts:
+    maxItems: 1
+
+  reg:
+    items:
+      - description: PKI Queues memory region
+      - description: PKI TRNG memory region
+      - description: PKI reset memory region
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - iommus
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    multipk@20400000000 {
+      compatible = "silex,multipk";
+      interrupts = <0x00000000 0x0000009b IRQ_TYPE_LEVEL_HIGH>;
+      reg = <0x00000204 0x00000000 0x00000000 0x00010000>,
+            <0x00000204 0x00020000 0x00000000 0x00000050>,
+            <0x00000000 0xEC200340 0x00000000 0x00000004>;
+      iommus = <&smmu 0x25B>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 04d82d0a7d55..478366f79433 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21696,6 +21696,7 @@ M:	Praveen Jain <praveen.jain@amd.com>
 S:	Maintained
 F:	drivers/misc/silex_mpk*
 F:	include/uapi/misc/silex_mpk.h
+F:	Documentation/devicetree/bindings/misc/silex,multipk.yaml

 SILICON LABS WIRELESS DRIVERS (for WFxxx series)
 M:	Jérôme Pouiller <jerome.pouiller@silabs.com>
--
2.34.1


