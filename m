Return-Path: <linux-kernel+bounces-194477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E8B8D3CEA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 18:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E03321C255F1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD960199EBD;
	Wed, 29 May 2024 16:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="KMQ6rfsB"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2057.outbound.protection.outlook.com [40.107.103.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB0218411B;
	Wed, 29 May 2024 16:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717000442; cv=fail; b=adsg+f/3sTuAGz+DmeLkkfjlgTCyuZvY422hdkTdE/I8oWapyElqERcf100vk5TAPgQvPc6qKmxbRm5E1v/JHbCp/gp1m+qaeI1ssryNzbtYFIyF/spiBAL4+d7lP9AShoMr5cnlTr2YMefhKva+z+FKOPdAJtnTjpJmPSPY+Xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717000442; c=relaxed/simple;
	bh=GBxKsVElGjIdAM/pQUWKp/DM+kCSr1OxPCFMtbZuqls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BNefm4j39q5z6o9IJQqsoGHMnWf9VdtGB8GysRAf7MDcEkvp5iFC6E1wP1rho8AP9pLevROm8r/Qcyh4vVbp8sgOHliHPp8tRThCHrV2A5uOBqqyjzP9H59qda36zYtFBGKPL0INJSfIR1IYBAgXgAm+PjJ4e6kVo0dJOCXjAPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=KMQ6rfsB; arc=fail smtp.client-ip=40.107.103.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IH19/LzH8Rb3rMIzaSZafHTmMOLCp3J8n2b4GnCih02yZbwRXAzHPwLyI+qDMaC1f0vs9NcAxLcvE435eg83882w917TEJqePVacQVSMv1AI0z6bGeVrZ4dlyeZHnAfPx729/PJHEvNkaMw9zJfG5H0vkG75KG7enwOyVrExxzhgodyWFC/fbyJsDHRSQz2UrCxCCFGzKCHwX0CKG0zzWqraK1/N4Anpk4bFyAKfz2kuDyTVK6If5bdhzpJ/rSJV4hdJlo+kGPuTsmmlOIX7tS68tYRrnUiaRWJPzJWHWFAn5t/S+PuuZ+RU8vbdFtMHAw7Ab3JbIpF6gaSLhD6k5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N0fdbr191pHjPPV9YhE1aBTVerz1WTywQr9eAwRwNRw=;
 b=UrczC8LKt+NfthHyWMwPh7X4Rtw9qVyKyyYJy9vFzw8pC5kotCbRU5kE89nfpmwE86FyywV7C2jhMY8YC7PYOAuASqoFvUE1T+YpH95SB/OED9GKITnAlYpU9JAquJprwwLD2muYHG5AK+8tX07XfxNakNt0PmqPpGMQUgtOUzZI4jGFgQh8JVa57iO6KG8R4K3Tr0kTSQM/u5aNQgQy/7OEJqVujFLMqvmkV6ktx3VgnmyN5ylL9j3kj/PhbrBF6lgRa6aQgUal6HEKlQJEP4Nfk3mlAsV404zyjPBS5qUC5BkSBJXMGBD7MP9Kn9yztxa7RWWdUoGPoZZusSZROg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=alsa-project.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0fdbr191pHjPPV9YhE1aBTVerz1WTywQr9eAwRwNRw=;
 b=KMQ6rfsBDlfznvObfM0dMi8DBbDhv8rVioJ5ZIYirHy4Odj0rDxIbZzgk6XxlRTP2Ifi8lS6BhY9OHaQrHXDhRGkdAXPcaIxa3pQuPBl04lS2OONOjw32idoy3ExMMBUyC9enqeAxrJaXW/UB8IgVmNPp4Vs27dtKAVhkegP1Sk=
Received: from AM0PR04CA0004.eurprd04.prod.outlook.com (2603:10a6:208:122::17)
 by PAVPR02MB9039.eurprd02.prod.outlook.com (2603:10a6:102:2fe::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Wed, 29 May
 2024 16:33:57 +0000
Received: from AM1PEPF000252E0.eurprd07.prod.outlook.com
 (2603:10a6:208:122:cafe::90) by AM0PR04CA0004.outlook.office365.com
 (2603:10a6:208:122::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Wed, 29 May 2024 16:33:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM1PEPF000252E0.mail.protection.outlook.com (10.167.16.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 29 May 2024 16:33:56 +0000
Received: from se-mail02w.axis.com (10.20.40.8) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 29 May
 2024 18:33:56 +0200
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 29 May 2024 18:33:56 +0200
Received: from pc49102-2217.se.axis.com (pc49102-2217.se.axis.com [10.88.7.5])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 375E02313;
	Wed, 29 May 2024 18:33:56 +0200 (CEST)
Received: by pc49102-2217.se.axis.com (Postfix, from userid 9470)
	id 32FD365EA245; Wed, 29 May 2024 18:33:56 +0200 (CEST)
From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Date: Wed, 29 May 2024 18:33:44 +0200
Subject: [PATCH 1/2] ASoC: dt-bindings: tlv320adc3xxx: Add MICBIAS-as-GPO
 properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240529-tlv320adc3xxx-micbias-gpo-v1-1-300d39cecc55@axis.com>
References: <20240529-tlv320adc3xxx-micbias-gpo-v1-0-300d39cecc55@axis.com>
In-Reply-To: <20240529-tlv320adc3xxx-micbias-gpo-v1-0-300d39cecc55@axis.com>
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
X-MS-TrafficTypeDiagnostic: AM1PEPF000252E0:EE_|PAVPR02MB9039:EE_
X-MS-Office365-Filtering-Correlation-Id: c03cb0d0-57fa-439c-025c-08dc7ffd22cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|7416005|376005|1800799015|36860700004|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnJIYkFJLzNPcVJ5eXJMUXV0NFk2QlBaWSs2Y2UzUFl1cFFXYms1dnF1VGI2?=
 =?utf-8?B?WS8wYVNrVzdDWGZJSk5yTGF6YURHekZOaWtUSSt5Wk5iMUQrYTRjVFk1bmZq?=
 =?utf-8?B?UkhhaWhGMnVQeCttSksxUUFacUdaMlg2Rmo5NjNMTFI4eFdQTFFvdHJPd25N?=
 =?utf-8?B?WjY4eTlZeThFZWlJbCt3QXJFT002ekNhZmRHWEdkamdXQ3NrcDBmdHU0TjR3?=
 =?utf-8?B?SUoybWVaQjBlWWRIVEtOeSsvbFR5YVVRSElLWU1iUXFYNkpRaDRSN2d2eFlJ?=
 =?utf-8?B?ajh5dHhiSUdwaUlQWXR0VUFxN0taMGRLVGZrb1VMVnVWdjlSZlBRSHVvRXBP?=
 =?utf-8?B?V2pQYjcycG1SVDMvV3IxYUVMS2FCZ1ArTW9WRDhnMTd6YkkwUm1oL04yeDNR?=
 =?utf-8?B?MlNNVEZkbWVlV1FvOFhnM2JZendlbnRLSjdhc3ZuUllBTHNXZXU0YVpnM1pJ?=
 =?utf-8?B?ZkpWYklValNOZ2NVSWRmWjBNd0tBaHI4TktzT2t6ckI0TXVKWlNOaFBUN1hu?=
 =?utf-8?B?dkp0VWRJRjBNK2JKNkJBQmJoR2kvdUtsZTJMUUVlOHhkeWRkSW5tOHN5cWRH?=
 =?utf-8?B?V2w2eDlJMmRxNFZNMzFjR1JVZGl5TnpXMGM4VXpxdEJnbFdIbTczS1Ixc082?=
 =?utf-8?B?SUVXaWhuZ2o0N3hqTDg0YXJGUEdJcGY2NjRYNCtYWEM0cVN1MW9IS0V2VG85?=
 =?utf-8?B?b2hCUjRZa3RYaHNlLzJNZmlScVBFWk1oZE8yUUY4OTJWSVpiV3NOcGUwNEdK?=
 =?utf-8?B?ZmY4VEcyUXlBMWZwTENValhwbERtejVsY3VoaHg4UzBqTXloU0hqUFptNk4y?=
 =?utf-8?B?b0Q2aUlrbFlyU3ZacnZSVDdnQUt0aUdmbFBibWI5Z05HTFlUeGhtZEVLRXJN?=
 =?utf-8?B?S1hXYWYyMCtadzF5ZEJoTVlWQ1ZlQ3FlRXZYT0VNMDZFeFFaY1FUeCs5VUJ0?=
 =?utf-8?B?b0FCK1k0MVhCNG9UYklZVFBidEVEREhiWTZHOVQ0THZFK0xQcGFpSXAyaUlK?=
 =?utf-8?B?M01La2Rnb3U1WUJYK0VTa0czdDVpejVYOFpISzkvc3ZzZW4xU1p6TnZCcm1a?=
 =?utf-8?B?eG9jR2hnOWdwbFlvQ3RSRW10WDdlOEZCMkZQNkxBaGMzeUZvbk1mVmx2Rzdp?=
 =?utf-8?B?OWtNRnB1dS9xekVaTzhEY1VHSGx2ZVpkRVhRMFJDTjhRbms2bG1hcThMeVI4?=
 =?utf-8?B?VkZxbXRvOXFWVkpIM08zUHYyeDFsa1VwWDUrUEhIUCtZTm9nU3NmWVRIcVFD?=
 =?utf-8?B?YkYrRzFIcVNaK3VFZzF2dzhPUEFWQVBlcTQ3NmFtT0t6WG10NEVZTU14RjRI?=
 =?utf-8?B?dHNpQmNWb2lyWmk0cFpkV0h1SkNEYlFHcmxLZWQ4YjU5am1rVkZNckk2VVlR?=
 =?utf-8?B?VnR5N01NQk1CVEI0cHA3NGp6UDZ5R2ZsNFJTaGlobmx4MEtYanhZQXhsOU92?=
 =?utf-8?B?NCtIWFVqRnBPMmpKYW1tTU1YUjU2RDJoQytaUEwvWjJ0R09lRm1iWFpsUEJB?=
 =?utf-8?B?OXNwMWQ1d2JTZm5hMUFMM2xJdWMyR2J6ZFhUVllNbklrM25SSVo5K0ZVdndH?=
 =?utf-8?B?ZndUSk1vcUhwNkFiSW1uNHc0K1d3YmxIOUNoY2pSVHRFbCtoUnhEcm9Ua3E5?=
 =?utf-8?B?Q2l4VTM4OW1jZUM2aXJuSm5zVEF4UE1sRHBGckJSQnlPbFFlaU42NDlLWFZZ?=
 =?utf-8?B?eDhSZENPN0QzQmF5QUhudGxUcGg3RHVPYlJoa0Yrb0kzcTd5amZ3WmNsVXZC?=
 =?utf-8?B?ZW9IU05HWjRrRU1ZUlYvTXhEQlluN0tuVFJicWdRRmNlb3kraTM2VEF2bTZ0?=
 =?utf-8?B?SURSY0R5OVdMejYwaEltWC9aUHQra2RKWVV3QUp3MSs0amtheUo5cW5nTkVj?=
 =?utf-8?Q?fQ03jhn0CM4xB?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(7416005)(376005)(1800799015)(36860700004)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 16:33:56.6900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c03cb0d0-57fa-439c-025c-08dc7ffd22cf
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252E0.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB9039

Add properties for configuring the MICBIAS pins as general purpose
outputs, with some limitations: The voltage on the pin when activated
may be set using another property to 2.0 V, 2.5 V or AVDD.
When deactivated the pin will float.

Signed-off-by: Ricard Wanderlof <ricard.wanderlof@axis.com>
---
 .../devicetree/bindings/sound/ti,tlv320adc3xxx.yaml  | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/ti,tlv320adc3xxx.yaml b/Documentation/devicetree/bindings/sound/ti,tlv320adc3xxx.yaml
index ede14ca2c07a..4172aced1386 100644
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
+      specified by the ti,micbias1-vg property. When deactivated, the pin will
+      float.
+
   ti,micbias1-vg:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum:

-- 
2.30.2


