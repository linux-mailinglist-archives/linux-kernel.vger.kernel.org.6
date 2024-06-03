Return-Path: <linux-kernel+bounces-198958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6635A8D7FB9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFF1E1F20DD3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EA982897;
	Mon,  3 Jun 2024 10:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Q/5iLsFK"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2069.outbound.protection.outlook.com [40.107.6.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A6F23765;
	Mon,  3 Jun 2024 10:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717409323; cv=fail; b=b/A68D2MXLiHyghzHRPZ32wH2/Jw5NmXOuBwcqM2N6/DqJo5g54CI3wehh12/Xn5N/bKTWieYtkiqEfK+7PoqtjbCkBeoDO9sWrRygMS8oV72NH9zvIv+XdbEU2TiFR0tFT3fDEOBSFExOc0cB8/MHRdISSNZD5rMX9ZP7URmAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717409323; c=relaxed/simple;
	bh=NSYGQ6kjMWEqewUXduOsUH8DH2sXZvBkzjnCiUcOwYQ=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=EXR1INT5XOPPXpeuU/EkoQ/sfFVg6Q09OSr7ECCitF+WkCSIevpGk0/XDDTytPVKGqRRDMIMX66HwcngvYOO41FoyRKfqFoifwCfByoojG03zJUuqqvceDyiZ1bOnUdBfX9uWByV5iUY2rOpI7fl1ZUkZhF5ueWURUIMcmds+u0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Q/5iLsFK; arc=fail smtp.client-ip=40.107.6.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMxH3odoKsG+J97JWvNnqavfJrxRnufrn1eU+kmwMfV9TXdOK5msHpSq/xjLYf9I19SHBbWvUhEw+6MI+xmJh2AXuYCBC2Fh5lc9BDz/VpEPq+HKjpy7K3aXwLPmYX8vZc4dm+FX6IMOah/jODPnh0EHd57/gee1t5u3L/DDX3Fr7oNb0TuisenmOCquh800barf+3dLyAL0yE3yJvmcbO3GcxTlVrb2zs4ch4Ahn7Uc+K0cDEOdL/XPmYh5sFeSedGK8OjT5xfixhRd1MduEREOFgyI7kLs8AD65S/y8LgcOB8yOyu4i/y0JRoVhGRo6IIm5Jy5xxWVC9rpfchJzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KItyWtJMMzRj68IqwyeTcF64PYrcugezDDZDDP//bZA=;
 b=WcQzJQ6mJ2TBf23XiYG3lfd3gr5rYjSIv9YzbnTEY1a1YXVRMD4Bdskal0juf9RRFIlPH9DgxUctu+usNQc4BwKA5n/YbaTGFSwoozDC1O5lXeuZ2AETne3Fs2kAqNZstbe06ACVOH7wbE64OrhtNkdD0h/k1Vyz2jR4n1i1LYwdJNtjuAwZYijUGkC99bK3SoLAuqHQ+JKlV5WogN+Di21nrCASld9kzzd3nlVwXKFsrBYO3vVxPAFBEzKSel6gdUTtCfodQIzfF4Es2UdJGCo9q8FqHWl6/UH1LZV25AAlABma5Q3RPWFoWrDVbbRzp/f09X60W4NmkatwtAxQ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KItyWtJMMzRj68IqwyeTcF64PYrcugezDDZDDP//bZA=;
 b=Q/5iLsFK3sFGPDOLDBZPns3NGGQnSoE2+btb+GOTOwwjHZV+UKsP2nvMOJkUfOr7kxsHr6fTwroTyMt0qJcOhffl+vb+lb4M7PK4kfNel4P5IYS7AqenylDY6XkWRVQVQ8PETESsupQl1CQtL5bFD+TYCCWTTKr88KC/6xhrUuU=
Received: from DU2PR04CA0289.eurprd04.prod.outlook.com (2603:10a6:10:28c::24)
 by DB5PR02MB10215.eurprd02.prod.outlook.com (2603:10a6:10:4a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Mon, 3 Jun
 2024 10:08:38 +0000
Received: from DB3PEPF00008859.eurprd02.prod.outlook.com
 (2603:10a6:10:28c:cafe::b6) by DU2PR04CA0289.outlook.office365.com
 (2603:10a6:10:28c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27 via Frontend
 Transport; Mon, 3 Jun 2024 10:08:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB3PEPF00008859.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 10:08:38 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Jun
 2024 12:08:37 +0200
Received: from se-mail02w.axis.com (10.20.40.8) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 3 Jun 2024
 12:08:37 +0200
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 3 Jun 2024 12:08:37 +0200
Received: from lnxamnaw.se.axis.com (unknown [10.92.129.190])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 278DA2939;
	Mon,  3 Jun 2024 12:08:37 +0200 (CEST)
Received: by lnxamnaw.se.axis.com (Postfix, from userid 12778)
	id 21EA02067CB; Mon,  3 Jun 2024 12:08:37 +0200 (CEST)
From: Amna Waseem <Amna.Waseem@axis.com>
Subject: [PATCH v3 0/2] hwmon: (ina2xx):Add Suppor for passing alert
 polarity from device tree to driver
Date: Mon, 3 Jun 2024 12:08:33 +0200
Message-ID: <20240603-apol-ina2xx-fix-v3-0-b9eff3158e4e@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACGWXWYC/4WNwQrCMBAFf6XkbCTZxMR68j/EQ9pu7YI2JZEQK
 f1304IgePA4D2bezCIGwshO1cwCJorkxwJqV7F2cOMNOXWFGQjQ4gCau8nfOY0OcuY9Za40WqO
 0aRswrFhTwDJvxcu18EDx6cNrO0hyXT+t+qeVJBfc2kY36giyFv3ZZYr71j/YmkrwR4eiI0Jnj
 dTQIXzpy7K8Af5t5J3sAAAA
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>, <linux-hwmon@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Amna Waseem
	<Amna.Waseem@axis.com>, <kernel@axis.com>
X-Mailer: b4 0.13.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF00008859:EE_|DB5PR02MB10215:EE_
X-MS-Office365-Filtering-Correlation-Id: aca3ea61-a5e0-4e25-b856-08dc83b52390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|36860700004|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWxFeDFEd0tvMnhzY3Y0djNrZXQ2UEtFNnh6R1ZwMGFoemhqc2daejR0eVFE?=
 =?utf-8?B?Snc2RStQTit6LzRYdUVKUnBqSG1jVk8yVGhWM2N3SHdoOHlFS1lXM1M4Yk9j?=
 =?utf-8?B?ZUUwSkdrNy9lRnVkUkJ0ak9GWU9lbkV0WlR4WUh2MGMyR1NCSmkzcWdDbkZx?=
 =?utf-8?B?eWl0eVV5RWcxVjIrKzkyODFkL0lMdmtmK0xKYTJtYW5BWk5lNXhmR09jd09B?=
 =?utf-8?B?Q1c1QnZzZmlRQldLM1NJTTlQZVRDb2p3RHE5bEVVWlY4YnpQZjQ4aVJoeFBz?=
 =?utf-8?B?ZHVZVEZBdG40SmpVV1RDZm14Q3ZTNnYyM1RJMEluTlZ6VHBXa0YrWFlpU3Vx?=
 =?utf-8?B?YjNhS2pmQTZ0VGxnZlhxOVhCNHFjcjk2ZTExSU9sR2NUM1hkU1FCTmNVMG0x?=
 =?utf-8?B?RHZKc0FVTWZKRUZvR3I4aUJJM3NNWkFaNUFHbS9YTzE4LzF0M2xldnhhYnVt?=
 =?utf-8?B?OHFYSU5jcEl0YnZRV0NSY25iRWhST0Z6dHRpVzRqekxLTDQ2YXlYdCszT25X?=
 =?utf-8?B?WjdoK2ROSW4ydmRWa2gyWTdVUzBrb2FnUmpiOTd2Y3dBNVZtVEcyZllhV0Nj?=
 =?utf-8?B?OUFienlMV0ZKakN6WXAvR0hYZ01EamU1b0xKSGNJTU1LYURINitMVUtSU29K?=
 =?utf-8?B?ckxOdVdsc2tDMWQ2YXZVVk01VnlSeG5wZzVqQk1aYy94UHREVXROcWpTVXNy?=
 =?utf-8?B?TFB0RnIwTmZ1ZWg1cTh3dlZESk1qNVpsYVcydXhOMHVRQVU2bjdtRXpxR1ph?=
 =?utf-8?B?dEplWEptT1I2UWlacTR6WE1nc0UwWW0yanVYRWJXWExtU0hUdFQ0My9JZjRu?=
 =?utf-8?B?OEdvenBiUFhSbTZmbXVmT01mRE9ma0pGaE9WbUdQK3VSSURjeFNmblNOdzAw?=
 =?utf-8?B?bTdQcithdktjL0QrUjlkK3MySkZySVNNNGJIMVlIL2xlRklmc1pienZhUGRJ?=
 =?utf-8?B?cG5VOGU3TzRWaG9kOTNiWFV4UnVRRWQwTjFCNkUyc0YzallKWjFtaTU4a2ZY?=
 =?utf-8?B?MXJIdExGN1RoVUJ6VWthYUVWcVcvSmpZSGhVTCt4QnNSd0ZQZGQ5VmVwenN0?=
 =?utf-8?B?a1M5OUVFK3FlQ0FLRkZtMExQUUtLWnFpendWcU8wYVduU2NicEt5eFlScWly?=
 =?utf-8?B?bzltaUdLOUU1ZlhVNGcyR3dqd2NiR3c5d2ZhWEVxTGxYdHJGR1BUQkJrd05i?=
 =?utf-8?B?S3dXZE5LTWhIR2JaVEVHclFSeW5UUDBJSWpoVFNhbm93UkZkTlJFL0ZXUi80?=
 =?utf-8?B?ZWEzWGhYQk1DdXFDcXF0RDd3RGRxblYvOEZRbCt6NGErQWVsY3FYWUVleTg0?=
 =?utf-8?B?Q3lHRUErdHBFM2h3Rjl1dStUdXY5OUF6QlZKajV2RlB4dnNWZUNiWE03UWdP?=
 =?utf-8?B?dDBubHVjb1UvRUNUTmFZZ055cGxnRVkremQ0UUtCZ21EODhLNHZtV2RIczVG?=
 =?utf-8?B?L0JoMzlhWEtyZWJwNEVwRDljaHRveVQwTDd0b2pBaXRIQ3lDaVNtekNIeFc1?=
 =?utf-8?B?VHBmYkRhTmtkMHdsaTRMRW1HVkIwTG5uQXAvMksxRU1qYTFJVjFDOXlmSUdh?=
 =?utf-8?B?bHhkbTMyMFEwUzByM3lueEhTYTlSSG1maCtCWWtDanNZdGw2enJJT1dRekp1?=
 =?utf-8?B?bEJ2NDFjNXBWeldsazRVNUVkZmc5alAwU2pESDc1OEtFc3ZCQkRpV0k0bmhu?=
 =?utf-8?B?dVUyTktoNjJ2REU1K2V2SU1JbjhuaFBjL2VIcU9zOGhhY3BBa2NrN09BWld1?=
 =?utf-8?B?QVNlbDNjSUVIVndLclFONUwraHplM2R4ZUVmcENqV2RZcmNIQVd6NXdjZWQ4?=
 =?utf-8?Q?iVJ3WdfDFghalC4RV0MRCnGJLhosc1JyJPuTc=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 10:08:38.7992
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aca3ea61-a5e0-4e25-b856-08dc83b52390
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF00008859.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR02MB10215

The INA230 has alert polarity bit in Mask/Enable register which can be
configured to be active high or active low depending upon the requirements
of the hardware using this chip. The patches in this series adds the support
for passing alert polarity value from device tree to the driver. Alert polarity
property is added device tree bindings and the driver is modified to read
this property and set the Alert polarity (APOL) bit value in Mask/Enable register
of INA230.

Signed-off-by: Amna Waseem <Amna.Waseem@axis.com>
---
Changes in v3:
- Convert the alert polarity property in dt bindings to be a flag
- Set alert polarity depending upon on the presence of flag in
  device tree. Otherwise, default value is set
- Make setting of alert polarity to be chip specific since only
  ina226,ina230 and ina231 supports alert polarity setting. 
- Link to v2: https://lore.kernel.org/r/20240529-apol-ina2xx-fix-v2-0-ee2d76142de2@axis.com

Changes in v2:
- Add vendor specific prefix to alert polarity property in binding.
- Minor improvement in description of alert polarity binding property
- Remove usage of mutex while setting alert polarity in Mask/Enable
  register
- Correct indentation
- Link to v1: https://lore.kernel.org/r/20240529-apol-ina2xx-fix-v1-0-77b4b382190f@axis.com

---
Amna Waseem (2):
      dt-bindings: hwmon: ti,ina2xx: Add ti,alert-polarity-active-high property
      hwmon: (ina2xx) Add device tree support to pass alert polarity

 .../devicetree/bindings/hwmon/ti,ina2xx.yaml       |  9 ++++++
 drivers/hwmon/ina2xx.c                             | 35 ++++++++++++++++++++++
 2 files changed, 44 insertions(+)
---
base-commit: a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
change-id: 20240524-apol-ina2xx-fix-34e76346cb26

Best regards,
-- 
Amna Waseem <Amna.Waseem@axis.com>


