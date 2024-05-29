Return-Path: <linux-kernel+bounces-193878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9F88D338D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 11:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE14D28320E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 09:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0BB17557C;
	Wed, 29 May 2024 09:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="qoxTJSlH"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2082.outbound.protection.outlook.com [40.107.21.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E230C16EC12;
	Wed, 29 May 2024 09:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716976078; cv=fail; b=mxMCf/t67r0gx8jhHTOXfzg65M935jx30TsiQcadBYqJrL+eyqpT5vgMhZMD7QxTwAlZrRZXh56jMDCVcUybUbkPaC824t9U1nl/otRn3S2m1DQ7FZI5tdVATHv3pi6DfMJyjbvFfWZ9WREVB1Hf8YQVk2zjINBsu06KvGnBzgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716976078; c=relaxed/simple;
	bh=QtFI7CreFFbBGPrCfYrDu+3YvF2hDagPnDTWtnn68Xs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=IWRMyMW4VVINggPSU060IPA6QxO2s7KqpqnOw+kiQ1VR6hzdyF5PLtrCAeG2FvYP0XJahgw+is9gt4ltqhXzt+tZe+KH64H2fZXAoGrTIn6yrSHsBNCbMur+t1/TbNtcqAs+I5RD221QXq06HFmIIa4gSLdgp3WDfIElYaTnR4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=qoxTJSlH; arc=fail smtp.client-ip=40.107.21.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFg2suisJvfPuq9j8ubs3zpDf6zVmblSJmcCfNQizytjFg/oFIpfD1rO70ajRx/ZmrLjba9U9zTF+nsyzYfBrC6UyAjrSUV4UBzlPNZjQ8fWMkh9chT2m4ofeQ+kLNe8hA9P1p26PtckvUE+YZM2BRcvVtLFt/CQnaegdNJPGpT1fOYcg8lBMjCbZx/2Z/KY6bp9tqbzsEIOuCitMSPeu8a0eAJrxeDntQdk5Y6qu+U3uovDei4ZwDBycUNDnmniQ/hO2yQfLS2KrCuSe5sUj+FWxqsTFJ2J3SQLbAZIekpAMJ6KbyNHN1RwqJSzW/Yjv8vgr3C6crZGLp3zrC1bpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4tRu2bF+DkzMwBEDj/T9HHanHKPhHWvbUHJifa09Jo=;
 b=Zxo4SgjRZneC4v3GGHknWf/Q6mLfHB9weJs1tO34KvKRoSGCQyF6CVzvgQwur+FHpwbtz9OORVqjRPOJbA/PnW5al7fUxu7scaFQcLH+51/h017FUsr6jp4KP9eG4qayIsOilqO7ahFDkrKcSEFcGP6EPSyuz/YpQ89+hiI92g9JoltPEVdORd1PvnmV3dWdHsMpfd6B6HTfXO5YFRW/39yu0EZqQIABu9GJQl1qVLsm5L9+DT+WZmS8GYztZ1PaZx0uB7hffFpjTjuvW8yHhTY66YLBN9l8xwC0HV/nGGkHW7vxxJbhTFxRLC8Yk+Oxnf4bNBR+pC1K3pnHP9kA2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4tRu2bF+DkzMwBEDj/T9HHanHKPhHWvbUHJifa09Jo=;
 b=qoxTJSlHPcKGaPT1EfVxHNqfHHZJTEYWIURsK3/Ocan8eLuzXuQfExvdOH6WNVjyKl0/lmUEsWU5EVol9wfAt34PHXyrn/fBLogB/7TTFVZ4fjpt8JNIszEwo8hGP5cFC3Z0S4SZ7+DJU7UCp0gCCHUxFxZTfesGbMImw//F7e4=
Received: from AS4P250CA0003.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5df::19)
 by AS2PR02MB10374.eurprd02.prod.outlook.com (2603:10a6:20b:545::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 09:47:51 +0000
Received: from AM4PEPF00027A5D.eurprd04.prod.outlook.com
 (2603:10a6:20b:5df:cafe::e2) by AS4P250CA0003.outlook.office365.com
 (2603:10a6:20b:5df::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19 via Frontend
 Transport; Wed, 29 May 2024 09:47:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00027A5D.mail.protection.outlook.com (10.167.16.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 29 May 2024 09:47:51 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 29 May
 2024 11:47:50 +0200
Received: from se-mail02w.axis.com (10.20.40.8) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 May
 2024 11:47:50 +0200
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 29 May 2024 11:47:50 +0200
Received: from lnxamnaw.se.axis.com (unknown [10.92.129.190])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 690F1AF6;
	Wed, 29 May 2024 11:47:50 +0200 (CEST)
Received: by lnxamnaw.se.axis.com (Postfix, from userid 12778)
	id 5F2E32066B0; Wed, 29 May 2024 11:47:45 +0200 (CEST)
From: Amna Waseem <Amna.Waseem@axis.com>
Date: Wed, 29 May 2024 11:47:44 +0200
Subject: [PATCH v2 1/2] dt-bindings: hwmon: ti,ina2xx: Add
 ti,alert-polarity property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240529-apol-ina2xx-fix-v2-1-ee2d76142de2@axis.com>
References: <20240529-apol-ina2xx-fix-v2-0-ee2d76142de2@axis.com>
In-Reply-To: <20240529-apol-ina2xx-fix-v2-0-ee2d76142de2@axis.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>, <linux-hwmon@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Amna Waseem
	<Amna.Waseem@axis.com>, <kernel@axis.com>
X-Mailer: b4 0.13.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A5D:EE_|AS2PR02MB10374:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e2725f1-ad43-49de-7abb-08dc7fc46814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OERWblIwVFNIa0RBQTZUY29jb05SVTdhOEllTWt3NWltZFVFQjVkNmZaaFRs?=
 =?utf-8?B?QTFSQmY4THZSR0hSQ1l4NmVYTitydGJVcHFDejg2NCtoRXlISUExblpJUWtO?=
 =?utf-8?B?akovblpVL2o5bWEycXY1Qy9vbE9kbUtGM0oyOWU3VFlTbHp3QXQzR1NYazYx?=
 =?utf-8?B?T0gvOFg4QVVOMlIyZGpBcCtDcWhqOVhiM05hU3pGMEl6emFrOVV4RmdtWkpt?=
 =?utf-8?B?UXhQYTB5cHo3NVNtTFFkeitDOGVsZXZvL1R2MkFqMndNMXFWd2tvVTJtcTNi?=
 =?utf-8?B?WlJhaTFwWld3YU54RFNiZU9rVGhaQUxac3Rqekx1QlhTNzRiazdBNzgwdmNw?=
 =?utf-8?B?MTcvS2NPdVI4Ti8rUnZqRnQ0RGVReHo1TFkydHVlT2ZYd2k4dW5sYmFhejgx?=
 =?utf-8?B?b296S3Ixemhpb0lvemV3NVpZU2FTaFcvdzF2bm4rZzNoWFpLM21SdS8yRHBK?=
 =?utf-8?B?UHBxNHg3TEt1cGFwaUw2a3dvY1BWSGdiRWNGRmpVWjBmWTBSNEtsWVhUeDVK?=
 =?utf-8?B?L004bEVwckE5eDJtY0VVWktuaDhQd0JiSVYxcFUvVEVzQ3pTZ0ZLaEZVSW0y?=
 =?utf-8?B?OVJZVU83WDVIeXM1SnRSNFFiam9kbFlSbmtLY0xTSmZxMFA2ZDZITnk2L1Ur?=
 =?utf-8?B?ekdUeWFaOWVMUnF4VjdDT0xOUkpTZTBzb3RBZXhYV051VStSanBTUmtuM2sy?=
 =?utf-8?B?YWE3OTEzalZ2SGNVNzV3a0N2ZXF3K0QzTjJtT0FUWGNsUW9taEYyS0FReXc4?=
 =?utf-8?B?V2FUUTJOdG9XT09hUzQrV0VkbnprQkRXWWovMGMyamhYLyswNGhLaEQxRGtP?=
 =?utf-8?B?OEd4YjNqUS9iV2s0NmMzTXplWFRFQ05MayttRVZ3SXVmSHZraEQ4aWFidHZD?=
 =?utf-8?B?cnBDQjJKUkg1Ujc2cGo4ZjRvMVY1ZHhta0JXak9HM2RLU05HTUFsaE5GZ3hK?=
 =?utf-8?B?SDRnUmEwZEdOTjdTKzhqZDgrL3VKeEl3QndNTHNKeC9YQWJhK2d5T3ltbWRT?=
 =?utf-8?B?eGhGTDJPT0dPalpUbExRbkwydmRhVElvYTE1MmVOdDJWVTMwNTVFdzlSZ3g1?=
 =?utf-8?B?a1BHRGRQb3dHOUFjZzRWTzRMZXBLRlNGcWFWL3FNVlpYNVd2elM5SU9VWkYv?=
 =?utf-8?B?KzBTTkxIQ1hHdDRqWTFmZ3c2VU9KVEg1eElteU9IT2RtWUxuK0dqS0ozM0RH?=
 =?utf-8?B?UjBjZ2JaQXpJbzZ1cTRpU1ZTZWxmaURqY2JZdzNJUVd1dGVZMy9MOWxCb25V?=
 =?utf-8?B?Vm4wSzkwM3VvTlloVUdXaDRUYkhvZG1sMitNSEltODNNSStXS2YzUURJNWdt?=
 =?utf-8?B?RU4wSFJ4UjNDTWJnOUxTTjZNcWs3c21JcVpiTWoxcmpIbjdhWXorb1luUWdt?=
 =?utf-8?B?ekVMM25QOEgvTEI1M1F0L0hESzVKZDF3KzF0emlSekw3MlF6Q0ZqbmtmK2sz?=
 =?utf-8?B?U29WbFE4SEc4MlZ4Y1pIc1Jyd1FKdVhTa1QvcWdSRHRxN0ptemlXdkRnQ3g0?=
 =?utf-8?B?b0dKajV5YW5JNEE5MXdnTVM3bVp6WXFDdEdTamVUWER2eFpDQlZrM2RRVzFY?=
 =?utf-8?B?aEU1K3pBTE85bkJRVEtkSnFETTRkWE1pMUJJVHhZS2s5aFU1QlBBYkEvYWV4?=
 =?utf-8?B?dnpxcGtmQWhhSy9rbU96MU1uNTVkT3hGMExWd0FKNW9LUHdEUjBXMWxkN1dW?=
 =?utf-8?B?V3J0V1VxQ3c5dng5SGJoUkZoSmszcXFLRlRzcU0vMm42KzVIbk53VVN2ZlNW?=
 =?utf-8?B?bml1V2pVTEJ5QVRPdjEvUDlIZnF5TzRQeGg1UW9BSmhQQ2cwL3FZRFVEUWRH?=
 =?utf-8?Q?4pGaBkVa7LUmnkQyAqJGV0IYjbnWq62QSynPQ=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 09:47:51.5945
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2725f1-ad43-49de-7abb-08dc7fc46814
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A5D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB10374

Add a property to the binding to configure the Alert Polarity.
Alert pin is asserted based on the value of Alert Polarity bit of
Mask/Enable register. It is by default 0 which means Alert pin is
configured to be active low open collector. Value of 1 maps to
Inverted (active high open collector).

Signed-off-by: Amna Waseem <Amna.Waseem@axis.com>
---
 Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
index df86c2c92037..5a16d2d94587 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
@@ -66,6 +66,14 @@ properties:
     description: phandle to the regulator that provides the VS supply typically
       in range from 2.7 V to 5.5 V.
 
+  ti,alert-polarity:
+    description: Alert polarity bit value of Mask/Enable register. Alert pin is
+      asserted based on the value of Alert polarity Bit. Default value is Normal
+      (0 which maps to active-low open collector). The other value is Inverted
+      (1 which maps to active-high open collector).
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+
 required:
   - compatible
   - reg
@@ -88,5 +96,6 @@ examples:
             label = "vdd_3v0";
             shunt-resistor = <1000>;
             vs-supply = <&vdd_3v0>;
+            ti,alert-polarity = <1>;
         };
     };

-- 
2.30.2


