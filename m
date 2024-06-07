Return-Path: <linux-kernel+bounces-205778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D9990002D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8E001C20990
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372061667C5;
	Fri,  7 Jun 2024 10:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="VbJAeB0x"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2073.outbound.protection.outlook.com [40.107.21.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646571649DD;
	Fri,  7 Jun 2024 10:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717754472; cv=fail; b=XF+YrTbF6q2uAfdZhB2V/DF3rsm+RZNwRILBHMtOajqqDiEJiUY21DNx+RtBqkv2n/lEFg2KmdufqOrtbsqMqLaEL7h9xc0FDbKL3b3TkSQM71DKxW4Ip1DcpJbVb1hHEzVWPvCGk3d8zOP61TOBCnNixvYpKd+hcvE+akWx7jI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717754472; c=relaxed/simple;
	bh=NBPgb+UzhQBw0u6G9zvmO5y8DRccv1kcnx1jDWil730=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=vDXnf69NuXCUPPVVEQg8Ygs3pDuKtHlf5O65plovdA0rKZtTKzQp7bcrgsed5pUA1yGeHSGmeI75nBnTr/2cd7DjtmEO/as4hG5Bsfmn9xEFQoD7Jw5Zm4gaWf99u4VFK7DCOfq1cS05Yv+cGAY951ChnKCnUHIABpCEVmiMf4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=VbJAeB0x; arc=fail smtp.client-ip=40.107.21.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYxuwfaa/P2zI/ywT/cT2nFXb/3wjYVFjPV0TlT/VwyHuGCl7l+ZXLT3pRaPms+J5adp7MYQWZ1IxnzVQ10OYJ5KqkWbSsPIySJc/UhTmb+Tkmsgw69kki6zQDRQ37wTlXof2fvNln23XGh6W0coV+emOQW3/q4WRs1OHW2YeDsIYyxnZ2+zomjgORiZ5CYlftGK2xG6IeEd2C0uYlZ5L7UtT1TEYkuzu8FZYxRkN/4trBUz8My2rgpItqfwt3VgS+FxtZ+cn3bdpypEyRME0TV4BhVTmLgAjdoVVfihDncoXNLcp2baX25tklsAsD5RwJOx6S2IOTTrNQIHq90X/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljACq7q5QlB36Xv7ftLTEUOSwlDdYX6pftqt9pRwxQ8=;
 b=Zo7jG9bp/XQBYOql5S3GOhSeGetBZbp2V8uYwPHdSrFo5qIw4UaxhKMrfKIsXJYmc3uvMwW27UcxLJ2W2knSA3jzmgo26+Fy3zjJUmkzeSq+Onw2gwEZgv1fSYUiR28p/cAeat1XYhGZfjje4au4Pr0fKmfL/KENAsVVmqgl9h6JkjfT8q8IA/FwEjn36Ldmw9Pi1tfmIMFf+68sEi5UCDvkxz7oKkdjH8sHsxjeGEK63FZCRmMV8P0rRJMu3UlMyrF1nPiDtyPMaxz59cBOuZ1PRHDfkLFcBBj4pEaAfHN3d+L35MTgNo5dwgQ6R+7yO9AbOrJEayvslDu/zKgm3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=alsa-project.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljACq7q5QlB36Xv7ftLTEUOSwlDdYX6pftqt9pRwxQ8=;
 b=VbJAeB0xyYHxU4Xrbnkss3Nfmr4LRQ9FCi3/NQz27rZ2avxdzeiXnqgaTdjGC/OX6h7A4h3l4qeYMkj2WW6DnaDXembl/KnSDFMmb0++uaOMxg7GwogJlZS2PFbomrNHSW2doSD+Do0K/bpjcKDj1DxrQ1WM4Vy02qD0svLU5TA=
Received: from AS9PR06CA0143.eurprd06.prod.outlook.com (2603:10a6:20b:467::20)
 by GVXPR02MB8280.eurprd02.prod.outlook.com (2603:10a6:150:6d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 7 Jun
 2024 10:00:58 +0000
Received: from AMS0EPF00000195.eurprd05.prod.outlook.com
 (2603:10a6:20b:467:cafe::e0) by AS9PR06CA0143.outlook.office365.com
 (2603:10a6:20b:467::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.16 via Frontend
 Transport; Fri, 7 Jun 2024 10:00:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF00000195.mail.protection.outlook.com (10.167.16.215) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 7 Jun 2024 10:00:58 +0000
Received: from se-mail02w.axis.com (10.20.40.8) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Jun
 2024 12:00:55 +0200
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 7 Jun 2024 12:00:55 +0200
Received: from pc49102-2217.se.axis.com (pc49102-2217.se.axis.com [10.88.7.5])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id DAEB13340;
	Fri,  7 Jun 2024 12:00:55 +0200 (CEST)
Received: by pc49102-2217.se.axis.com (Postfix, from userid 9470)
	id D54EA6476FDB; Fri,  7 Jun 2024 12:00:55 +0200 (CEST)
From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Date: Fri, 7 Jun 2024 12:00:45 +0200
Subject: [PATCH v2 1/2] ASoC: dt-bindings: tlv320adc3xxx: Add
 MICBIAS-as-GPO properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240607-tlv320adc3xxx-micbias-gpo-v2-1-b140a45ffffe@axis.com>
References: <20240607-tlv320adc3xxx-micbias-gpo-v2-0-b140a45ffffe@axis.com>
In-Reply-To: <20240607-tlv320adc3xxx-micbias-gpo-v2-0-b140a45ffffe@axis.com>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, Baojun Xu
	<baojun.xu@ti.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Ricard Wanderlof
	<ricardw@axis.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Ricard
 Wanderlof" <ricard.wanderlof@axis.com>, <kernel@axis.com>
X-Mailer: b4 0.13.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000195:EE_|GVXPR02MB8280:EE_
X-MS-Office365-Filtering-Correlation-Id: 7df3793d-0d6a-421b-1396-08dc86d8baea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|7416005|36860700004|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V25HOTNQandDQWpFQnVPMXFDZytIRUNUaHZxQmQ0RW95YU8vY0l6UEFNUHJG?=
 =?utf-8?B?UHc3eThzL0xtandoYkxiWmZMU016UGp6b0s3MitldEw0UDFROGJrZmxzajNr?=
 =?utf-8?B?RXU1aWhML3ZTb0dpTHNIcUFNd1NhSWc1YkRHWlYydXRkdWNYSzhpR2RVZmZq?=
 =?utf-8?B?ajM0SVEra2NUeVVNRjdtR3dJN0ZyVmdOOHJEVHNuNlFsdGUyMmZKY0FrZlFU?=
 =?utf-8?B?dmRxR1BSMkVBeUZBQWYxMytEQTJSZXg0bUV2UU56RlJFblFQUXNqbk9rTXds?=
 =?utf-8?B?aEFRcFQwQ3ZLRDE1TWpOcmRNN1d4OW9VRTlPTklNTnBPd0NjeE8xcklCVWVw?=
 =?utf-8?B?N2NsQXY2b0UxUk80d3Nhb0N4Zk1CTTZ2VEozQVczTm5OVFU4V0ZuSVZoOW9V?=
 =?utf-8?B?QllkblVFY29IZXFVcnJsK2p4Z1JGREVkSUtlaDVIRmJGZTBJdkJqTHRZVHF1?=
 =?utf-8?B?WGMxdENPVXJoK1NmOHBXQ2VOaUdYY3FkcjRqVzNRaXByZUtuWnd2bE5HVzdY?=
 =?utf-8?B?RWg3ZVdxbU9FM1pleXpPUmNtVjMwV2NsRUltQTV1NlY5MmRGdXdrNi9YQWpw?=
 =?utf-8?B?VHVMYkRnaHpSNnA3alJTVWpCaHFlbzJCTzlvcThVdjAxNGY1RTN3ZFVIeUlS?=
 =?utf-8?B?dXQzdDhUZEZKYjNMTDF4cUhsQkZHK2pOTzdQaW9SNGFFOGMrWjBWNVZJUmJD?=
 =?utf-8?B?NWd2djNtMXltbUN4cVdkQ1BBT1c2UitQdmg5ZmkwQ3RHWWp0c2JHS016U0dS?=
 =?utf-8?B?dVcwTURKaUN4OE4rL1BrQWIwRXJqc1VUMEg3ZktPZ0ovc0xobGtTVFVUL3g3?=
 =?utf-8?B?RGVtVi9VSjV5eU5TR2ViaDVmZ09Dd2t4aG9pbFJKUzNpeVFTSjlQajBWemRG?=
 =?utf-8?B?SVhwVVJKU0NCelNzdnZXSHFoUkI1UkliUkQyUGFPVE1zamRVUDRxN1ZsR3ky?=
 =?utf-8?B?ZXJJbWx5WFV5NTdidGN4S0hoVkc4Ym1KMllVUzUyWE1VUlg2SFdtNXRkcnNT?=
 =?utf-8?B?R0FhT2UyUWdVcFQ1bEVqQWFrTG5ZTng3L3dIb09Id2RtUitQcW1US3ZUajg2?=
 =?utf-8?B?VE10ZTl0Y0NXK0NKOWFTVjIwRjBoZG5Sd3d1RGVNcHprSWpIei9yY2U1UjhL?=
 =?utf-8?B?Q2psSCsxSng3M3p1WExkN3J2LzUzSnlpMUpuWXJPY29sT1BURFp4VXNKYkVr?=
 =?utf-8?B?UnJUZFYycWxOS0V5eUorek8xNmM0MDZMVk1COUhPVEV5T29OUk1RdUhvL3Mr?=
 =?utf-8?B?bFlaMDlNdGtOUmlmRDZROHJjMXVNYWVmZTRaMHdYbnZpRFFXRmVycHgycVJS?=
 =?utf-8?B?c29HR0xjL0lDTFZPNkxmMGRianlDRmw0NTM4Smd2ajJmeVk4NnRWeHNKRlUy?=
 =?utf-8?B?U2dza3hyY2hLRHI2dXVjOWdkRjJORnBDVGhXd0tVbUFzbGdmcGhlWXp4VzhO?=
 =?utf-8?B?VXJqZ0tjUmZnZnIrYVBZcitmcGNyM3lkZTZEbkw0VkxpTEEvZkFKY0lENEdo?=
 =?utf-8?B?Z3lzM2NqN0g0ZHRyejZ1T1Vvc1pxWjJ4QjE5RXduSlMvMEppTTZ0QXBsbVJT?=
 =?utf-8?B?VHJ1NExIbW1iZ3NTNXFaK3RkVUpzMWRWeUt6Y2lCWjlPTVE0eGU2cEtjUmxM?=
 =?utf-8?B?N05DdlA1eTNFVDdQMDB0ZkU5Yy9yam1NMEEzZDIzMHoxLzN6RnhxRCtNKzdI?=
 =?utf-8?B?TDk1cndBajJSbE9RV05FcnFYME50M05iZ2x2Zy9ERmZBamtYQ0JPVlhHOStk?=
 =?utf-8?B?dWlvcEZRNmZmeW9sdXRVOUZCZ2pRRzEzbUtRR0dEOTlhQkt2QlJWRktKRHFs?=
 =?utf-8?B?MzBFYktpZE5WME9Mc3dJTEhoRExzTElaNjNNUEdLQTBoNzVQbGtYRHJqMnht?=
 =?utf-8?B?OHhGUEorWUdTT0ozNm5FcXhjT1JxNWtmWUxTZUxUWVJCZlBtaGNnQUtIcXFz?=
 =?utf-8?Q?eJF+MBYw4a8=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(7416005)(36860700004)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 10:00:58.6259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df3793d-0d6a-421b-1396-08dc86d8baea
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000195.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR02MB8280

Add properties for configuring the MICBIAS pins as general purpose
outputs, with some limitations: The voltage on the pin when activated
may be set using another property to 2.0 V, 2.5 V or AVDD.
When deactivated the pin will float.

Signed-off-by: Ricard Wanderlof <ricard.wanderlof@axis.com>
---
 .../bindings/sound/ti,tlv320adc3xxx.yaml           | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/ti,tlv320adc3xxx.yaml b/Documentation/devicetree/bindings/sound/ti,tlv320adc3xxx.yaml
index ede14ca2c07a..b7cae1c65e84 100644
--- a/Documentation/devicetree/bindings/sound/ti,tlv320adc3xxx.yaml
+++ b/Documentation/devicetree/bindings/sound/ti,tlv320adc3xxx.yaml
@@ -82,6 +82,26 @@ properties:
       Note that there is currently no support for reading the GPIO pins as
       inputs.
 
+  ti,micbias1-gpo:
+    type: boolean
+    description: |
+      When set, the MICBIAS1 pin may be controlled via the GPIO framework,
+      as pin number 3 on the device.
+
+      In this mode, when the pin is activated, it will be set to the voltage
+      specified by the ti,micbias1-vg property. When deactivated, the pin will
+      float.
+
+  ti,micbias2-gpo:
+    type: boolean
+    description: |
+      When set, the MICBIAS2 pin may be controlled via the GPIO framework,
+      as pin number 4 on the device.
+
+      In this mode, when the pin is activated, it will be set to the voltage
+      specified by the ti,micbias2-vg property. When deactivated, the pin will
+      float.
+
   ti,micbias1-vg:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum:
@@ -104,6 +124,10 @@ properties:
     description: |
       Mic bias voltage output on MICBIAS2 pin
 
+dependencies:
+  ti,micbias1-gpio: [ti,micbias1-vg]
+  ti,micbias2-gpio: [ti,micbias2-vg]
+
 required:
   - compatible
   - reg

-- 
2.30.2


