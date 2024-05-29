Return-Path: <linux-kernel+bounces-193490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 169928D2CF0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3BEC28D4C2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 06:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF56160784;
	Wed, 29 May 2024 06:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="EBQCr/ra"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2049.outbound.protection.outlook.com [40.107.8.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01BE15D5A4;
	Wed, 29 May 2024 06:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716962844; cv=fail; b=AGUqUnQ6zBl+TDM6IMaOSBpfUj3eKVuBvr8797MqNycAcPwXGDKH83bzft+t/fJPO84Rr1fRF1JKl5SuZHObAULECOqzT24o4dC5AVxsCW0QMwIQRkyCavQo/RlIplcfsW8+x5A/UqeCLMBeFfPASI+bwCNU3ynzysGe8RwHyi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716962844; c=relaxed/simple;
	bh=yI6eddubAbsVQ+HgVAdMTT9pHpEt0ixb4KJcY3b/OYI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=XzDo/KF5B9qLfyu53ZoS+moe/Jc0AaCegvIx59wuREOTqMV3F7Jlq6HCbegjMjvR9rQmp/zLfUgWjM3WH2Y2d2pbZj/n3Wstui6TrGmIvXrzSY4/8CH39uyUaAOv0aRr3dSiRJb/aHNtAnxEJ7Dt8tgaYeCtUhcJ0QKocH3mZHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=EBQCr/ra; arc=fail smtp.client-ip=40.107.8.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=femCDfiZkHvY6sRc5FhomfPXnPv0K/JEeZXb6LMD/NJSWRQnxdztsmti4qPsTDjoYLPUgvNauGtZr6HNFzV+PD1xkkdpFICQLsq2VZmDGxzqqTHie/GACzfrfmtf5+haQpL180IWbFZBEKSxLjKhAxE4drymALfCLP0E2vFR7w/KOCL08yVcZevxSdmPfjWB+lrKDDEvBvNu7orO4lVGfFUhosBG1Re27qRxnW/p8gN3EubgLf27ZwqOiUoUCe9OUAgc3YZa83xYTLAfiJkVvrwblcbyUp2cY6ZO+Td/qDNNvfaGmiXEAg8m49kRRbCice1CVvdId2shq/CSIJ/8Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Gv49MuucCYTODADqy4bh4cjAN5zqZsTfGFMtbZ3pPo=;
 b=UAGl9YT6I2ri2bTD5XpAzlsiirzTYZ24Eko8dhzrJ5vRw112LXJwvc6cKkj7qNf5swjfUWcmTP11LfYrDZyp8rXgsSlRz+egxDxbQ+c+bjAqvcoX5mGhXH1067lOc57of80LCR4l4FWfR/LOtqVBAzrXIX+yfw7iTvaLjurY/SWCJ8JlZR56PGbrytSrzdcfbD5WydCeaqNNVFXL1BjxrAu+wTR7lUy86n6g5ToXkJIR2p985N4NvNNm5PNSntrMzyaBfy37vFfbtus/16UhyD20ULJkL2TsIThzHP9Co/93Zkf2ruZqV3RGS1D7qF9at+n6gVL4pI9/Qzwy/95/VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Gv49MuucCYTODADqy4bh4cjAN5zqZsTfGFMtbZ3pPo=;
 b=EBQCr/raKe8+bZXd83LTe5IZagjnxx8hxNQnofgarkUeRsWHXyIVGsD5jFSNxzdLEdaXNNMGvPOqdTQVcHV/HU+M6fSWUCo3dYE8CkHYLEUkD2AFhKqQOW6EbDgo/gpiuqHAk2ALbsqzpvhYoh/W/yaNXiUs2u/zDfQB2YWoUvI=
Received: from AS9PR04CA0129.eurprd04.prod.outlook.com (2603:10a6:20b:531::9)
 by GV2PR02MB8650.eurprd02.prod.outlook.com (2603:10a6:150:74::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 06:07:17 +0000
Received: from AMS0EPF000001A9.eurprd05.prod.outlook.com
 (2603:10a6:20b:531:cafe::58) by AS9PR04CA0129.outlook.office365.com
 (2603:10a6:20b:531::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.18 via Frontend
 Transport; Wed, 29 May 2024 06:07:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001A9.mail.protection.outlook.com (10.167.16.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 29 May 2024 06:07:17 +0000
Received: from se-mail02w.axis.com (10.20.40.8) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 29 May
 2024 08:07:17 +0200
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 29 May 2024 08:07:17 +0200
Received: from lnxamnaw.se.axis.com (unknown [10.92.129.190])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 2516E1E0B;
	Wed, 29 May 2024 08:07:17 +0200 (CEST)
Received: by lnxamnaw.se.axis.com (Postfix, from userid 12778)
	id 1A3D62069D6; Wed, 29 May 2024 08:07:17 +0200 (CEST)
From: Amna Waseem <Amna.Waseem@axis.com>
Date: Wed, 29 May 2024 08:07:14 +0200
Subject: [PATCH 1/2] dt-bindings: hwmon: ti,ina2xx: Add alert-polarity
 property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240529-apol-ina2xx-fix-v1-1-77b4b382190f@axis.com>
References: <20240529-apol-ina2xx-fix-v1-0-77b4b382190f@axis.com>
In-Reply-To: <20240529-apol-ina2xx-fix-v1-0-77b4b382190f@axis.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>, <linux-hwmon@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Amna Waseem
	<Amna.Waseem@axis.com>, <kernel@axis.com>
X-Mailer: b4 0.13.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A9:EE_|GV2PR02MB8650:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d687d43-6ab3-469b-4d4c-08dc7fa59800
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0pUUjNVRHovenkvZngvaUh1K3hMQ2dlbUR6VHZTWUhOenIzYTRKYkhlMzRw?=
 =?utf-8?B?Y1kzbXBRckdBSEFXTStEV3AvaDh4dnIrYi9iWllPc0drWXhZN1ZwYVh0Tlhi?=
 =?utf-8?B?aEZRbm9mSmZsMTN5bmJ3RTZRcXo1aUI1YUpPTWkwKzBaWlNxY1lhUm5Ca1Yz?=
 =?utf-8?B?SEdicFpOa2FWSFZMQTFxSWdpTnlDZUVzYXZLOFc3NFc5SkF2YncrbXdKangr?=
 =?utf-8?B?ZldnVm03bWl4MElKN3IrZ3BEbitHZXdZR2FjZmNqU21SVjBicnNhbFRBaWVI?=
 =?utf-8?B?ZW52UEVLQ0luL3dUZ3hhQWxvTEgzMW1pMFJnMlRWdVFDKy9wSm44Z0I1REhG?=
 =?utf-8?B?aXRHeFdvTVUxc2wwUFllczJmZmxtZlhkdzh1Z3VYcmE1Qkx2ZmpkMVpyam1y?=
 =?utf-8?B?SXZ2SlFvN2QvTi9LTFBYS2UyRzY3TFNLNVAzNlNrSVRMWldyVGVvRkRraFpo?=
 =?utf-8?B?dTYvREVsL1RSeS9wcDN6TEJGNHJqQmx4QnpubWd6VGVscnhKQUZUQkpkUEFs?=
 =?utf-8?B?RlBvbFZKRWZmYlRXZC95eFBIYXFjVDJqNkk5NVpLTlJEbThjTjM0U0t0VXBD?=
 =?utf-8?B?Szd3dmxOQnRKMCs3eDBIMWt0clJwdFNjT0hTMk02elVQOFNTaVZrZGxZcEhi?=
 =?utf-8?B?U2J6TXV5NDJvQ1FBcml2NUY2WUFXSEFTd0VzRVBvaG02N3YrVFdyN2ZhaE05?=
 =?utf-8?B?ejN1WDdLNklwMHV0c25jR1B1OWdFTXlhZTZod0NTWmNiTENjNlgzZHBKc3Nr?=
 =?utf-8?B?cS85RUJJK3p2M0haSFV2a08xQTl2MHhPeXdPbjhVTFFvbUkxZERoaXo4a3Va?=
 =?utf-8?B?dVQ0Zmo2NkNZOUUveUVLcEV1K0RCTTlmNTBwb21ZNzdLYjZzUzB0VXp4Yncr?=
 =?utf-8?B?dWpTV1RtMDN4MDFYT1dQZWhRU1Y0M0NpNXNuQklERUU5RHdpcVJsVnhObUp1?=
 =?utf-8?B?bG4vNnpYbHpzWVdSWm43Zm1IalpCVVduZDdTQ3ZoK1dYNHY5eTRwUVdiSC95?=
 =?utf-8?B?TEw4S1p4YnJKMm1PTEd1QW9EVHhvYzQvaXdWenU4TG1mRUp2KzVvcmR5Yzk3?=
 =?utf-8?B?eFR1ZGx0WFRRanhQRzFjT3dBU3ZHMFJzMFd0Q01rWnJabXZ1YUo4bFVrYVpr?=
 =?utf-8?B?ZW51VGhYMG5uQVl4dytuMHVmUklXSWxDbldnbTZHVXJEM3VBRVVUWW1mbCsw?=
 =?utf-8?B?c0kxdEVCK1dwaE5oR3M1bjBmYjBTYVloV0FOLzNKUnBQdVUremNKVXByOFl3?=
 =?utf-8?B?cmdmS2ZpaExtbEdxcXZHLzYzdmlLcWl0bFduWFJEUW1ZYUJ1T0FPcHQzWmxQ?=
 =?utf-8?B?TmkxWlRveFRuekpIbzRWZUZZUnA2TUlyS3F4S1FUVG04L2xvMFgyaEIxZ1ZL?=
 =?utf-8?B?STNQZ091QjZ6VXdGSmhVYnU3em1McGpBY2RpWll6VHBnVldPV3BlZUhhOWV1?=
 =?utf-8?B?N1NtUGEvQkxHcmkrLzRLNVpDYWtablE5cHZQbjVWM1I0d1cwUFRwTmxKLzlM?=
 =?utf-8?B?bit5amw2M0labTRxYzRhRTczWDF1TzFpd2o4SnZxSXVQbUdjUkFhTjR2RW90?=
 =?utf-8?B?eXFBRjA5QlRtZWtWeVhzTXlqaWJZYmtpOGE0UEY1ZlhnNEdtTGhsVmlLc1Mv?=
 =?utf-8?B?SXlNdFhsYkdycktLWkdLSFJ0djNDRkxYWFo5cHNmallkR0t6VDM5MXdOTDRr?=
 =?utf-8?B?N083WnIrZ0tTRmFNWG54aWNRV0JveE1vVUJIaVozSk9NZ2YwbVRrOTVTWHJ2?=
 =?utf-8?B?OTlzc0ZYK3N3dzFRRmlXZldRY2hDb2RIZVdnOUoxVVo4Qm5KYVRiRjljQ1Y3?=
 =?utf-8?Q?gdH8chEX+pLYYgoc0Pa6i7bQwamzRBs/mMMdI=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 06:07:17.5787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d687d43-6ab3-469b-4d4c-08dc7fa59800
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A9.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB8650

Add a property to the binding to configure the Alert Polarity.
Alert pin is asserted based on the value of Alert Polarity bit of
Mask/Enable register. It is by default 0 which means Alert pin is
configured to be active low. To configure it to active high, set
alert-polarity property value to 1.

Signed-off-by: Amna Waseem <Amna.Waseem@axis.com>
---
 Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
index df86c2c92037..a3f0fd71fcc6 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
@@ -66,6 +66,14 @@ properties:
     description: phandle to the regulator that provides the VS supply typically
       in range from 2.7 V to 5.5 V.
 
+  alert-polarity:
+    description: |
+      Alert polarity bit value of Mask/Enable register. Alert pin is asserted
+      based on the value of Alert polarity Bit. Default value is active low.
+      0 selects active low, 1 selects active high.
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
+            alert-polarity = <1>;
         };
     };

-- 
2.30.2


