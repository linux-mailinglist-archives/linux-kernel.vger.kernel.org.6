Return-Path: <linux-kernel+bounces-193489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B64D88D2CED
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69E9E28D483
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 06:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58FC15F41B;
	Wed, 29 May 2024 06:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Xqp12v7P"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2071.outbound.protection.outlook.com [40.107.15.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF5B15CD77;
	Wed, 29 May 2024 06:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716962843; cv=fail; b=rx8JxKqvJEsPa6E+jxjDtXx8IKhXt/+iIOj92gCWEgvegv9Yx+2E+tSZZg/NYgRflH6yWcs03+KnJKnAmtBcmtfqcSxR7HhahHLB/Cmua67V2abwOETNWvkAs4YGIdwIy4KKObJAmyiexOYWS6T8osgxYd76KvEA20Nu9VwQ06E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716962843; c=relaxed/simple;
	bh=It43Ej86AgPUX82GcwNta3dMVh3MKkr9csmbqlpfWww=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=cY8pIMPQubP7yAACO2JXLLaYP5SYTZXPEv6dWltFUD6e9STILTiWC86dndGCNlCl0WiNRuFYhmigEj72sXtnokDHjVwv/8wX+E401FcwFDomcqGzG2b0AoTfyqpxO1JoBdvZzzz7S8dotOMfYjVR6p89syrjN5SFyM6/+WGUMcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Xqp12v7P; arc=fail smtp.client-ip=40.107.15.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fvu+IHsWxgMKzT7Y/zqgv6YmCc6TFnf/KxmCllAExuEek/A02nkH/kz3uKFcy7/opDJ2s/e2BBl6zwV9oTDKRghMqvR7oeD5QU6RwRxZJ3zHaR4f66Kdrk06rUevCy4rJeDVEMV+qj6L1pl/isemotID7HY8YP+AjEuWzY3k6cqLWdJfDAJf4rdulnmDXbnhiK94R9wf0+st7ra4KuCt5bwesQ/fKrz92p3pXe/19RJlClsRKlQO1ha622XhUhX82gDZtipQeqIYGUl7t3fcw+/AR5uBKxJRsk1Ls7Xpdf1H4faEMirZAagkqO959D+Iv9iekFD6cPnshTVgU1pKVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mJo5iY4rLSNOhCm94kwwG0uyjRLmAUa4jSdZysES6M=;
 b=N5Jxr5eou2sm4X4O+wyp4rdmf8SHNhnB7Fm8cQNzSzJ2JwY5BguAH63G1CtGXv2kQBFzZsrmWUjQqV624MWhmDpVNvMakkYydzs3oYElijBqNx3mnRKFf54PC0vdZ2hEuth/uXbixWJZ9PFN8MNHEKS49VrOxHTz0gORnqUxNFtZkM2OARlWor3FvXa+OOfLfPXkcltNT4v4sjQTVGtACKlPDWSKR8wERS7G/RFFoMIJdeZGlNFKwuvwFTY7z6j5ksQCDhGPGmwBYzAyVXKOZtq/Z6nJKV29a7SpVmWoAA+i8jYOo2tHvu4Pjzm+rgXnm7KUzuRLn+THOPVwUoRksg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mJo5iY4rLSNOhCm94kwwG0uyjRLmAUa4jSdZysES6M=;
 b=Xqp12v7PmASxkBLL9fMwfazy+kMjX1uDHia+r/DWFIbabb8yCT8bwSjaZ8cBt0TY2yDZzbvFXKEtw+RRhS/li2vuKP/d9GTkO7BpuK+VF91bRFzYXXYvQrm34UOBU1k2+PW8T2svPvCvue3N5Hz6K+rJb+C4H9YRU1qUcOzZ09A=
Received: from AS9PR04CA0111.eurprd04.prod.outlook.com (2603:10a6:20b:531::6)
 by DB9PR02MB9780.eurprd02.prod.outlook.com (2603:10a6:10:451::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Wed, 29 May
 2024 06:07:18 +0000
Received: from AMS0EPF000001A9.eurprd05.prod.outlook.com
 (2603:10a6:20b:531:cafe::88) by AS9PR04CA0111.outlook.office365.com
 (2603:10a6:20b:531::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29 via Frontend
 Transport; Wed, 29 May 2024 06:07:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001A9.mail.protection.outlook.com (10.167.16.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 29 May 2024 06:07:18 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 29 May
 2024 08:07:17 +0200
Received: from se-mail02w.axis.com (10.20.40.8) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 May
 2024 08:07:17 +0200
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 29 May 2024 08:07:17 +0200
Received: from lnxamnaw.se.axis.com (unknown [10.92.129.190])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 19A21B2A;
	Wed, 29 May 2024 08:07:17 +0200 (CEST)
Received: by lnxamnaw.se.axis.com (Postfix, from userid 12778)
	id 16E68206972; Wed, 29 May 2024 08:07:17 +0200 (CEST)
From: Amna Waseem <Amna.Waseem@axis.com>
Subject: [PATCH 0/2] hwmon: (ina2xx):Add Suppor for passing alert polarity
 from device tree to driver
Date: Wed, 29 May 2024 08:07:13 +0200
Message-ID: <20240529-apol-ina2xx-fix-v1-0-77b4b382190f@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABHGVmYC/x2MQQqAIBAAvyJ7bsFWM+gr0cFqq4WwUAgh/HvSc
 QZmXkgchRMM6oXIjyS5QoW2UbAcPuyMslYG0mR1Rxb9fZ0owVPOuElGY7l3xrplJge1uiNX/R/
 HqZQPxp8Wg2EAAAA=
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>, <linux-hwmon@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Amna Waseem
	<Amna.Waseem@axis.com>, <kernel@axis.com>
X-Mailer: b4 0.13.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A9:EE_|DB9PR02MB9780:EE_
X-MS-Office365-Filtering-Correlation-Id: 359440f6-13b0-41df-220b-08dc7fa59856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGlDL1dIS3VRbnlkWlpaZUw5SVJ5TXAxSGNyOVpnUGJtWWhjbXBpM1IzbXkz?=
 =?utf-8?B?SGxuZmh3RWNkV1k2NkJSQTVXNENpM3V0UmgvVmE2U3U1a0gxd3o1cGJ6MitF?=
 =?utf-8?B?aFptL0VpNDVHWlIxNStpaWVnNnpoK3cxNVQ0c2hiZy9ZNlhZdGs4R01Kekp0?=
 =?utf-8?B?c0VydEdlNnNYQXFIOW5mcWxPam9DcmxUckk4OVN6V0pqS290dmF2NTNxbHBp?=
 =?utf-8?B?OWxNNmZoRzN2N2Y5N1orcXFQL0tPbVE0Nm1sd2k1SDRyK3NkUDFQYXZoUHEr?=
 =?utf-8?B?UWFFL216U0NVTGdCL0hCTlRJQ0RST0dkTWttemtrRmYwK012SE1ScjhBYWpL?=
 =?utf-8?B?NkZ1Rm9LZG85T1A3anVVMHhzWWVGTnZ5cmdnSFRsTjhtYm5nWlVNV2NHUzlQ?=
 =?utf-8?B?dW4wT2tkSzFOYnBNKzV4NmlEQnpSNmtROHhqVjNiTlJHOXF5WkRlRzR4Umo2?=
 =?utf-8?B?NmgrNVdJTzNacFEwOTN4aEJQSlFaOHZQZkRWb09XcVYvNkdWL28zdnJVTXF4?=
 =?utf-8?B?eVRkMXlmMDNWSEc2RWFjOUVsc25wOGRjd1VGTFVWbkNCL0tLZFN6V2dLcE1W?=
 =?utf-8?B?MUdNL2JvMHQwQ1k2SHdid0hpcUZodm5lTHprN1ZiSWx0ZnFjSHBwRll2UDI2?=
 =?utf-8?B?QkVyaFVJdld1a1NZZm9VUVQrdGN6cVJrUmdzeXMyelZVZ3ZOM1ZXbHZIMWFw?=
 =?utf-8?B?S3MyaFhwN2tZNzBxejdXN2RiNkVzTFBzZlE5UnhHbUN5c1ZiMHBuNXhYblZR?=
 =?utf-8?B?alJkbGVxb3ZrQXNzTmFVK2NNMHVjMzFtVUhSeTl2RmszK1d3cjJFQWk3bUZV?=
 =?utf-8?B?dTZ5UHk4Zk9RN2pmaFZxM05jQ1F4VXg3N3hKVHFWTkRlOE1YMndPZlAwM0Vv?=
 =?utf-8?B?bnBwbmRlWjY4NmVkd3FaeWFXcHo3TTQ2dWoyL0sxRHJ1RDJoSUVHR2ZxWkRK?=
 =?utf-8?B?SFNaZ1A0bHA0dUU1Und1d05BdEFxNUNKOFFiNDlwa2p2TDJVTWc5L1hYSXpQ?=
 =?utf-8?B?bFFkOG95NEtIVGkyZ2JsZXdYUzRKT2ZvVUZwaFNsVDArQXZjRTdVMU9wV3Fh?=
 =?utf-8?B?cGVMeXU2Z1phZWlRTTVzc0s3UFNtWG9CUFFMZDVhTEhxVjU5NXZVRGtzbC93?=
 =?utf-8?B?bFMwQ2FGTW9RSndHMlhLeXc2NWx5ZUo3Y1ppUi83YzRlYzlxaWpBSVhGU1Bu?=
 =?utf-8?B?UDl6UlcvWHBFUEZNTTFZVDNUWS9pYzZCMGFLNlpPdVFBU2EvYnNJSVBwM2FV?=
 =?utf-8?B?c2ZlQUc4SnU1ZGNhSklTVnRwSU1zMW9vY01uV0pJTjN6cUM4ZHVyempCVnBQ?=
 =?utf-8?B?UW9vSmxMUXpyM2JLQmsxZnNreTFWVHhPQjZTQ3BNb0xJZjVTUkg3NGU5MEla?=
 =?utf-8?B?RGhtM1Fqc3VoMzFOWEFsUFBsUXJmSDlWZm5kekVYZnB4ZjRFY1VnVjNiNW42?=
 =?utf-8?B?SlpKcVVGQjZsZld2cythd0psZ3pVMmxQcWxCNmVFQmZ1ZFZJWXVscVppT1Jk?=
 =?utf-8?B?RnBPb21GRzlEQTFyS2Z2eElWaHArd1hNRDdGQy9ibEhhQlpJRXRjeE9JSmJY?=
 =?utf-8?B?QzRCSGR3TXVBemF3ZnM2ZEVGVGlYV1p4WFovTVZWS1VZMHpMdStOblB0dWtV?=
 =?utf-8?B?WHFjdi9qNlVZU1lFazZSbkZoL09oSENLT3B5RkgyMVBpSlhsZzZiZm5uWXV2?=
 =?utf-8?B?S3gwRS9mL2RKV3ZycGsrbEV1RHo0aXVMTktzaVlrQUFWamdvMmFaNHFXNHRw?=
 =?utf-8?B?STVHU056QklJREtCTU50ZjhuSmZCR1BQVm44NlBnSjZ1bHlsRlJOOG9acnJw?=
 =?utf-8?B?endPbGJJdmhUNUFJNzF5ZU9JOEVUbHJCVHEvSnlOaTJKeDBMc1Q0amQ0dEhT?=
 =?utf-8?Q?kHDpHesiuLk6H?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 06:07:18.1412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 359440f6-13b0-41df-220b-08dc7fa59856
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A9.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB9780

The INA230 has alert polarity bit in Mask/Enable register which can be
configured to be active high or active low depending upon the requirements
of the hardware using this chip. The patches in this series adds the support
for passing alert polarity value from device tree to the driver. Alert polarity
property is added device tree bindings and the driver is modified to read
this property and set the Alert polarity (APOL) bit value in Mask/Enable register
of INA230.

Signed-off-by: Amna Waseem <Amna.Waseem@axis.com>
---
Amna Waseem (2):
      dt-bindings: hwmon: ti,ina2xx: Add alert-polarity property
      hwmon: (ina2xx) Add device tree support to pass alert polarity

 .../devicetree/bindings/hwmon/ti,ina2xx.yaml       |  9 +++++++
 drivers/hwmon/ina2xx.c                             | 28 ++++++++++++++++++++++
 2 files changed, 37 insertions(+)
---
base-commit: a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
change-id: 20240524-apol-ina2xx-fix-34e76346cb26

Best regards,
-- 
Amna Waseem <Amna.Waseem@axis.com>


