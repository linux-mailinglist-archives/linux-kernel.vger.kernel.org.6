Return-Path: <linux-kernel+bounces-193877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 030F48D338C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 11:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E2771F2873D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 09:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB2D174EE2;
	Wed, 29 May 2024 09:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="QcL+0SJV"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2071.outbound.protection.outlook.com [40.107.13.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2847715FA8A;
	Wed, 29 May 2024 09:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716976078; cv=fail; b=eJJXEGCtZoupT3AVxLvdMz9xucIhAF/0wBl1/mJBL17RL0mCvi+4gXm771Eh3ezxakBiJWJpGzvI7vxCnDJOFzGHHI0ZFUIRfdKo8SDkQr+pxDWtwPg+yeDYky9HNaOEwis0SfrQJGYwT9Dvea3nAJ+A6gOeFhjQfiun3wVV2cE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716976078; c=relaxed/simple;
	bh=2FuTfbP8zlAPC1OSWLFqlXwCGfe1tqulXZF9pZY0Umw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=IJgG+qLTS59BA3M2bgSDMD4PkuP6b0lnkFLK4zJM5G80VsPjeTIn8MPOeT5nOtNKo52sHjUl0k+PhkAOsPhQMlczj+uSHMEJcRd7cNnd1Gp2kGU8MnOx6UJ8fcrvEO2Th7iNoYpns2HSDVR/Y1VFtspD3b2dTauWuY4atDWHeBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=QcL+0SJV; arc=fail smtp.client-ip=40.107.13.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UO/2GZLN0dx9NA7KmiSdBGufpH61+gQIJhjXLRzrPoOiiK1e8jCpFJbfG9h7IRl/bgtCFIW4nTD3BJfaDyyk0h22eN7uXoCyjx/4Vlr66SqRseSbIfoRLxh+8f7tAZGSH2oS0/qlvG/0yyrtJmz6Z2PyPwrsZ8eMOdZz2CcyPn2oMcz3UhJSgN0kTHXFH0kgJkdaF+ldfWxf23UJfRxs/xEIVsKkXj5xYZnI0atZfK6NPwH496hF6nYHrVMRZ1eM7m4Gsz7IQPlfvNir98tUv0RNtMq/AoCyUiX50/ZsYwla3po17hHmgpBo8L29IBeRxcoDW33VoKgNxVh5DL2YUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7b0fIg7fxl2jRGfHlxDRU/BLK0jh0Si0kFxV60/4bKM=;
 b=CRyxF/o80+hJd9en+R8hjJOsUB/uO1kfhC0GttkB7W1vaBj51ObHQt//Fj4zgVl6uYw7tG/KDkbCN0fI8VEr0d7AJqwonE9L/HQiZ1jssy8Z7y+Nhlkx/IVawjbIRRnK3JpuG5WtGOZYLqanM65s8IRBB+u2ox/7O6/boDk4zq2zE7/X9Fc8dY/ETBpM5nSaVQCsIfqg5IbxliUcJVzz6d2FFjpCXpu5bEroKaDHmLJb+/m8HfouOWMttseZSqiZXo8qknDz/Tg8sj7VxSsyiIjgrm1AcUEMwvyvFYzzp7XJCyN7T1q5E890c1JnEE56k00vRp8oarRjmWeZOscCKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7b0fIg7fxl2jRGfHlxDRU/BLK0jh0Si0kFxV60/4bKM=;
 b=QcL+0SJVVQHoeH2/bMPn/FR85rfz3p86PmxWk4r8PSzSeSDkKJLu72jAJgaG1oVW52xW38ricZwZeQRg1iJsEn/7x57LKdC26iBkUsq61sOOmaJwm1fobh7Yi3GP7WqBUTai/g9rJHelIFIvNS3xc+VRiT9t5R3ml6QIga/shng=
Received: from AS4P250CA0007.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5df::11)
 by PA4PR02MB7087.eurprd02.prod.outlook.com (2603:10a6:102:10c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Wed, 29 May
 2024 09:47:51 +0000
Received: from AM4PEPF00027A5D.eurprd04.prod.outlook.com
 (2603:10a6:20b:5df:cafe::c) by AS4P250CA0007.outlook.office365.com
 (2603:10a6:20b:5df::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.18 via Frontend
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
Received: from se-mail02w.axis.com (10.20.40.8) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 29 May
 2024 11:47:50 +0200
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 29 May 2024 11:47:50 +0200
Received: from lnxamnaw.se.axis.com (unknown [10.92.129.190])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 5FF762225;
	Wed, 29 May 2024 11:47:50 +0200 (CEST)
Received: by lnxamnaw.se.axis.com (Postfix, from userid 12778)
	id 5B760206558; Wed, 29 May 2024 11:47:45 +0200 (CEST)
From: Amna Waseem <Amna.Waseem@axis.com>
Subject: [PATCH v2 0/2] hwmon: (ina2xx):Add Suppor for passing alert
 polarity from device tree to driver
Date: Wed, 29 May 2024 11:47:43 +0200
Message-ID: <20240529-apol-ina2xx-fix-v2-0-ee2d76142de2@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL/5VmYC/2WNQQ6CMBBFr0Jm7Zh2Wqmw8h6GRcEikyglrWlqC
 He3krhy+V7y318husAuQlutEFziyH4uQIcKhsnOd4d8KwwkSIsTabSLfyDPlnLGkTMq7UytdD3
 0VENZLcEVvRevXeGJ48uH936Q5Nf+Ws1fK0kUaEyve3Um2YjxYjPH4+Cf0G3b9gHhq8vnrQAAA
 A==
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>, <linux-hwmon@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Amna Waseem
	<Amna.Waseem@axis.com>, <kernel@axis.com>
X-Mailer: b4 0.13.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A5D:EE_|PA4PR02MB7087:EE_
X-MS-Office365-Filtering-Correlation-Id: 7249e3e6-8e39-4bc9-cbaf-08dc7fc467e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDNsWkYyczRWVHhxYWQ0UzFmTFUyK0kveG5BdnpCUElzSnpLZUhxd2NJU3lM?=
 =?utf-8?B?SFhnT1NZU2VxLzlWSXA1Y1RVejluZ1ZuREdtd3dpbGdEMVlzRDI2eEZaYnZT?=
 =?utf-8?B?a0haUWVrN0dYZGRTTis4eWk4OHlVTy9oaFRsbmdsaXhmY0N2MUxNNkRpVHRT?=
 =?utf-8?B?Vi8xZzlnRVFuQ3gzeEJIVHZyNmdPRE4xeU9GcmhRTktCZ3N5d0JtQW5SZjJS?=
 =?utf-8?B?b09Pbzhkc3dUVmRWMEpTNmZCR1RQT3Y2eGZYeXRSMzZxS3BjMitGaXhxY3E2?=
 =?utf-8?B?ckJ2OXVvWWhkNUoySnF3VWZpazFCdFdCdDA5VE1Dbkp5MU90VVJCS013ejZV?=
 =?utf-8?B?NjE4SXR5YmlEQXd1OWROcU9ic21xa0FTTGtmYzRmOC94VjdwYloxeGNjL3dp?=
 =?utf-8?B?RXJlWUtDRFVKL1JEVDVtK1d3Y0ZhYkY3TUVZU29TekxsaDdQSkMvb1BIdW5R?=
 =?utf-8?B?TVRuTFJMZ2tJUEluNExicUIyaFVnOE5ZYVBIRnZ1clBiUGhRWHFmcmx0UzM1?=
 =?utf-8?B?MnRCWUUyZlZGdVBlbzNjaCtYRXlwemtQTU0rWmF6VTFObFJhWmRxQWd4SHhJ?=
 =?utf-8?B?K3pyL3FJN0QxZkF0MXdmbFNhR1dRTzFFTEcwYTBRaTJzTWo3WHAzZjZrNjAv?=
 =?utf-8?B?NkZIMTR0ZlQ1OTFHTStRL1hRTlI5RmY0VHR5RkJMb3FDeFlHL2JyMjZSOFFm?=
 =?utf-8?B?K0hZWWNEdTdaWkZEakxWMldmVlJCN3gzTnF0WnZnRnh4QjNteTVXY2JvZDZN?=
 =?utf-8?B?ajQwc0hQNVA4ODViZjR0VFNSempVbFJNcXJIeEErSkJyNUlmOVhBSzNyNVlI?=
 =?utf-8?B?OStvY2tVR0tKWWlFVzRsaExyZzdmbk1sS3NZZmlib05yZjhQWlpwNG9uRjcz?=
 =?utf-8?B?YUJlQ0w0eHZ1d3B3RDV4alhoRStZQnQrT3NzUjFibUNQRVhoMm94Z2pIS2VT?=
 =?utf-8?B?SEI1QzNLSS9wL2hPZ0lkSUZjRS9LT1U0eWZvbWlXUGZ5cGlZRHdUalllRHh6?=
 =?utf-8?B?eEdTQm1YNjlBbDZ3WGJYSWVBN29XZC83cmV4c3RjclVvTmQrRWRYMTZhVjBE?=
 =?utf-8?B?ckZBM3pXQTE5UUJQL3plZEVLdHVuTGUzZ1ljY3pBTWVyY3FwVmI3OU1BNW55?=
 =?utf-8?B?QzhlOHpGNFlLTjVIbC9pRUNOemZ0eVA4RzViTUFzcmx0RmhUVnUrZVFXOThO?=
 =?utf-8?B?OWM1U2JoNmttUjdQMmpDTnhvOHR4L25sM2c1eEFTY28xaExlbTgyckJvd2hJ?=
 =?utf-8?B?WUJDendGMTJ0OTZSRmw1Q21WcEszaTB4YWYwRUUrK0UrZldKRjA5TGErRjFL?=
 =?utf-8?B?dHR3elNyZ0UweWpkSGI1WEdWSkRhMHFrMTJVYmlDUGY5UDlZS0tYaGxUd0I4?=
 =?utf-8?B?TzZETGs0ZVZuTTU2RWl2NkJLckZIMDhMSHRoZlFWRGhlWGQwMk13cklvK01r?=
 =?utf-8?B?K0lYMlVpM3hBWlZ6NkJlM1g5L0Q0aGJlZldWSDhjY2ZvUVJaK294SkdNNmd5?=
 =?utf-8?B?ZDNFVW0yZ1RockFvSjA3djliaDFOMkVGcEhmUTFmU3pYb21VMEM1SFVyQ3pz?=
 =?utf-8?B?VVgyY3ZReUkzL1ViVUh6emhJbVlSNGtVV0p0ZEt4N2R6UXBoTGVIRUVUUW9t?=
 =?utf-8?B?SEx0UUk1L3IrK0hoWlhZbmlLYm9MT3RJdDBXQ0R1TG1RVjJMOGJNMHZDRjlC?=
 =?utf-8?B?TC9kdlVwZUJmZTdGOFJxTlZFeTBtK3IwcHUzdHM2a3ByVE9KblBRcW1HYTd2?=
 =?utf-8?Q?/G/nxJm24oS4vlKHic6qeJdWOtpDd3MNPawdNbb?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 09:47:51.2820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7249e3e6-8e39-4bc9-cbaf-08dc7fc467e4
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A5D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB7087

The INA230 has alert polarity bit in Mask/Enable register which can be
configured to be active high or active low depending upon the requirements
of the hardware using this chip. The patches in this series adds the support
for passing alert polarity value from device tree to the driver. Alert polarity
property is added device tree bindings and the driver is modified to read
this property and set the Alert polarity (APOL) bit value in Mask/Enable register
of INA230.

Signed-off-by: Amna Waseem <Amna.Waseem@axis.com>
---
Changes in v2:
- Add vendor specific prefix to alert polarity property in binding.
- Minor improvement in description of alert polarity binding property
- Remove usage of mutex while setting alert polarity in Mask/Enable
  register
- Correct indentation
- Link to v1: https://lore.kernel.org/r/20240529-apol-ina2xx-fix-v1-0-77b4b382190f@axis.com

---
Amna Waseem (2):
      dt-bindings: hwmon: ti,ina2xx: Add ti,alert-polarity property
      hwmon: (ina2xx) Add device tree support to pass alert polarity

 .../devicetree/bindings/hwmon/ti,ina2xx.yaml       |  9 ++++++++
 drivers/hwmon/ina2xx.c                             | 27 ++++++++++++++++++++++
 2 files changed, 36 insertions(+)
---
base-commit: a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
change-id: 20240524-apol-ina2xx-fix-34e76346cb26

Best regards,
-- 
Amna Waseem <Amna.Waseem@axis.com>


