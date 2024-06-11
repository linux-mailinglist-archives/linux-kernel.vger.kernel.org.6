Return-Path: <linux-kernel+bounces-209582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BF49037FB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B47C51F2590B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 09:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02681179204;
	Tue, 11 Jun 2024 09:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="R767LD11"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2060.outbound.protection.outlook.com [40.107.6.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B221D178CCF;
	Tue, 11 Jun 2024 09:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718098603; cv=fail; b=VkYJ2cEk0Ti+Rg+tOrfgQ1DaWZQ+AkukZPVmhbanbyB69GQZvS7ruxUoroPHpwI/DZWcVHg6rZYTIHtz7vk+HDYUrqEyifz/p94nWcApFzqTE53yySe6Nj9W5MiV7QUGFZysf2lgDo5ImrTdmB7/vKCzEl8TTmgZJfXRIgox5ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718098603; c=relaxed/simple;
	bh=D52XoW+saOgGhGOkmenEkpqbXGlWZn5LbATvdSjlatA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=o30mqFtGo72zb3nwaDJ57RU2KoXTNGOeV7YV+JiInEq20tMrRzVXV0CBPS93+veRGIKEHtj3+kfgtwLJn+LxGj81M9+9QJIdtZhdEzFcjNJWoZ2bED1Lt94AyuRTLGpR+U3YMVtohuzGAgmfgzaoMfbizyStXytsVdaGDwzl9J4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=R767LD11; arc=fail smtp.client-ip=40.107.6.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQspR9AI34TPolaxNpzGIXs4XQGtEht+AdVQLWBTneOgu8ohRyfSreONxElRNgSRWY7SsZC+aHUh2ugP7q8caetnHagUS6icazv5+k8FrXR1ySATOBUbWSBRcSTtgx5vbMXvRSFOoCSou7RNv6OSx/B9UquzNWC5op0iEaF99Q99zSytu0dwFgg1gcfBQowxfHVjXMcCd79BpnKCAIq/R5Z0ltDRPHbJnQKuBU5Za3mp5yLKH3NaQ+8BaVsxbwHH4u8QkrBcU928Ix2uTgNzgqkK95RdN9MrBXb4e70a131KByoRtcc51L/BAinLAjm0IXMIjV4sIya7gzaiUh9zaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSQpQesB4/wae/5o3oqujPQk9IM2ahfa4m9o8EsZ9YY=;
 b=gQPlcDjAlnSxGwSUErcVgatbebqRnRT5b2NQq0/8WqH7I3zN/QNtmc+IjqDszkmXHOdrORhyCvTl6zf3vg2Dtlrw+0kG99x5uuJcM98+2soX32OeP6f54ogp5KTwX4gIrQ3MJ+SMWiRj+d/A1lr2craissLklDpPgx9GRYSDgjzrGd6otDcIzTIHQWFJWXM84bZDMRlTX3uZVBjh1Ezo5+0+tkqhuTa2m4jvfP996NVZPIb8BW2Y7eOuloxkYVyx65fYKSjcbvm/78C1JVey/X68OrKst3iMlOS6K444u6rIk9Qm1RekjhcCgCcj7yHGVFNhsEuPCrsg0F7AejKJSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSQpQesB4/wae/5o3oqujPQk9IM2ahfa4m9o8EsZ9YY=;
 b=R767LD11Um3J/nvtdqEnru4yS1cWrWIFP4jWvzTe29bszTNBIrrLc+BAt0vhHOQ4UxVZxTqPIiyjoADQzo7pCeFmXY0GTC+3PjZ8IhIZHC/9JoBbPp1wSxt1CFLyPTnIlcmhTexP7R8bkxQRlbqMCqt0QI+5CuXC1945d3FIq+A=
Received: from DU7P195CA0023.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::7) by
 GVXPR02MB11111.eurprd02.prod.outlook.com (2603:10a6:150:217::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 09:36:27 +0000
Received: from DU6PEPF0000952A.eurprd02.prod.outlook.com
 (2603:10a6:10:54d:cafe::bc) by DU7P195CA0023.outlook.office365.com
 (2603:10a6:10:54d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.17 via Frontend
 Transport; Tue, 11 Jun 2024 09:36:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF0000952A.mail.protection.outlook.com (10.167.8.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 09:36:28 +0000
Received: from se-mail02w.axis.com (10.20.40.8) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:36:28 +0200
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 11 Jun 2024 11:36:28 +0200
Received: from lnxamnaw.se.axis.com (unknown [10.92.129.190])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 453C7E2;
	Tue, 11 Jun 2024 11:36:28 +0200 (CEST)
Received: by lnxamnaw.se.axis.com (Postfix, from userid 12778)
	id 3FC8B206ACE; Tue, 11 Jun 2024 11:36:28 +0200 (CEST)
From: Amna Waseem <Amna.Waseem@axis.com>
Subject: [PATCH v4 0/2] hwmon: (ina2xx):Add Suppor for passing alert
 polarity from device tree to driver
Date: Tue, 11 Jun 2024 11:36:24 +0200
Message-ID: <20240611-apol-ina2xx-fix-v4-0-8df1d2282fc5@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJkaaGYC/4XN0QrCIBTG8VcJrzP06HTrqveILnQ7NqG2MUOMs
 XfPDaJoF11+B37/M5GAo8dAjruJjBh98H2Xh9zvSN2a7orUN3kTYCBZAZKaob9R3xlIiTqfqJC
 olZCqtqBIVsOI+bwWz5e8Wx8e/fhcH0S+XN+tatOKnDKqtZVWlMAr5k4m+XCo+ztZUhH+cMgcE
 RqtuIQG4YeLD1dMbLnI3FbonOBFiRK/+DzPL93iZnwrAQAA
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>, <linux-hwmon@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Amna Waseem
	<Amna.Waseem@axis.com>, <kernel@axis.com>
X-Mailer: b4 0.13.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000952A:EE_|GVXPR02MB11111:EE_
X-MS-Office365-Filtering-Correlation-Id: d6346247-3818-469e-db51-08dc89f9f897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|36860700004|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUlBTlVVQWs2eGJhUTdsOG5lTDRVdm0yZVpxUmNqMFZKNTlNM2ZGMW1qaGFH?=
 =?utf-8?B?TjN5Q2RwZGZJYlBIS3lvRkduRkptQWxsbGppMVl4eHNIeTlPL1AzeUwrR2Fi?=
 =?utf-8?B?SnJzaVA2L0hyWEhZa1VoRHR1LzZlQzhzUzk5THlTckxNTWlLT01vTHZGekxT?=
 =?utf-8?B?RDhDc1JFa0ZzTXJ6Z0JaRVFrdC83VjFycS9yaElXZ0FhTzkrMzVxblg4T05X?=
 =?utf-8?B?UEREcmEyWGVZVkc2ZUZRMmlHRVhDMWdtbUQ1S3RXZUhZRHFOZWo1aFpMcFlQ?=
 =?utf-8?B?TjdsZlRHSkxtUTR3Qm9WczNwNTE2c2dnRXZiREYwUEw4TW1qeGh5NXZjVzZV?=
 =?utf-8?B?eEhEUXJlQVBXUEVXQktXQ1VnamoxVnFqNFFmY3VCZ0ZBWlEvYzRZaE51ckEz?=
 =?utf-8?B?Q3UrWTIzeFJqVEdhdWdBWGtwSEwvVWxLK3pWTEMvSzJsQzNTR3lsUFBhenBQ?=
 =?utf-8?B?Vm0wbXVuMjRORDdBSWFBVzd0MmVRNlJLSkk5SkZ1VHRPYTBZVE5XYVQ3M0t6?=
 =?utf-8?B?ZWFJcEVMa2phUWtoY1B3WU9JbEQ3Q3c5Mk9WcVNDSEpUMC9sMVRkVzhmSGFQ?=
 =?utf-8?B?c3JndTcxMkc0aDVDelh1OTlYWVVEWEpLa0FNQTB2RmlWeUdFNFlBVVhoTXMx?=
 =?utf-8?B?eFpTWkFYNmRuUTcvSEVHdnE0QXdrdTlURE5DakFZTkxBNXFFU0V5VGY1YVpQ?=
 =?utf-8?B?NCs0SmdNSTc4cmZObkpIbTNPMFVSNnZGL2JRY1Y5Ti9WUkpDSUFDbGRJODRp?=
 =?utf-8?B?V3hqeGV2L1BnSHlIeFlOUmtuRWZwcVBzNzNZNHBUNG93TzIwQlZMa1kyVzdD?=
 =?utf-8?B?U1NDcDFCZ2svR0kxcC8xUmc0bW8vT0dwWVVUTll2WnBPMjVuUXFRVFo0U2dL?=
 =?utf-8?B?NUFDUUVYNEZTU2ZmMEo4L2hzdWtXRE55dGhCSGk1QVpjc1pNVkZYMlA3TUxI?=
 =?utf-8?B?TnV2L1RrbTJ6dG9LZTR3TklETFFzcGlGREVhMUpBTXZCVjFKNzcxcFloeDdO?=
 =?utf-8?B?RGpudWc2TytFSEFLY1ZrN3lubndSelhkdlN5SDFnL3JNMkVncVZYdXhVVnFi?=
 =?utf-8?B?QXpqOERQTWNaVmZpSXRXQzgxZW1nQlpnN1ArNW5oMjZuWlhFN20yUHJUQ29C?=
 =?utf-8?B?YW8vdWVJVVF4S0dRMkx2VXY4cFZ5Uk5RRzdvVnZ2T3UreGkreTVhZ3NhWC9S?=
 =?utf-8?B?ZzJlMUw5bjlmWCtiRnRtcUFoajhZVjFTdW9mS3YvTzUzMzRnbi9kVHV1TEJh?=
 =?utf-8?B?aEJzRmlXcGlUSzR4U2NkdVB3QkEwaUFweURMVy84ODhGYjZQNWxkVU9DcE9R?=
 =?utf-8?B?dlpIOVVtV0xCM3FIejBFTExGZmRkZlFVMVpuS0ZGUzFSSVk2ZDJualEyMzFS?=
 =?utf-8?B?YmtHSkU1S1A0Z0Y0Qmk2bDI2RHVITGVKcWpuVWMwbmpCTk9YY0VZQ1JHbjBN?=
 =?utf-8?B?bWlsclZ0eVBNVmpQTGNKeEpHM0RyRDFSblBWbng1VzJxbW9kOVJvSEplOWVR?=
 =?utf-8?B?N2dEeGhmS1Q4eENVVkpYMlZic2NMTXZSL2RpQWlZYUZha3MyRkdxQXZTSlFN?=
 =?utf-8?B?V0JnLzc0U3pCOWpCV2t4aGNseTg0WFRwclFFWG1Lbm05UmRWRHFwU25ENE5J?=
 =?utf-8?B?MVdITkhkMTFyMS9MQmhySlFkZHF6c0NJS0V2M054NXBvRHBKdnJUVSszalpM?=
 =?utf-8?B?SDc3VTVpUXpEYkV6L2FzN1ZFMmp6NTJESW1ITDdkeFp6enZLd1dreS9uTWky?=
 =?utf-8?B?S0p2S2o4NmxnNG1QRmZwTzRBcmpUM0Flc0xNclV4SjU1ZkpyTFdxN2o1MWUw?=
 =?utf-8?B?eStjRUJ0RkNRSG5xVmljT3psVWtVODh3aFJsYzdWY2xQZ3IzbDVBSWo1clVL?=
 =?utf-8?B?TzBnRzlmbHhHYTE5aUlSa3Z2b3N1bUJvRkkwcmJKTVVvM1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 09:36:28.9550
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6346247-3818-469e-db51-08dc89f9f897
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000952A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR02MB11111

The INA230 has alert polarity bit in Mask/Enable register which can be
configured to be active high or active low depending upon the requirements
of the hardware using this chip. The patches in this series adds the support
for passing alert polarity value from device tree to the driver. Alert polarity
property is added device tree bindings and the driver is modified to read
this property and set the Alert polarity (APOL) bit value in Mask/Enable register
of INA230.

Signed-off-by: Amna Waseem <Amna.Waseem@axis.com>
---
Changes in v4:
- Remove unnecessary checks while setting alert polarity bit
- Link to v3: https://lore.kernel.org/r/20240603-apol-ina2xx-fix-v3-0-b9eff3158e4e@axis.com

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
 drivers/hwmon/ina2xx.c                             | 32 ++++++++++++++++++++++
 2 files changed, 41 insertions(+)
---
base-commit: a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
change-id: 20240524-apol-ina2xx-fix-34e76346cb26

Best regards,
-- 
Amna Waseem <Amna.Waseem@axis.com>


