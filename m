Return-Path: <linux-kernel+bounces-187232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 581FD8CCEE2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF96A1F22214
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989A813D29C;
	Thu, 23 May 2024 09:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="g1P5YEXK"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2056.outbound.protection.outlook.com [40.107.215.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9985313C9CA;
	Thu, 23 May 2024 09:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716455905; cv=fail; b=IPEA96UOMVZd5NEoaFjNGd6Sgxl8/DUU8+WQXKpGLJegLcVJKAKwRw0XHO8CtNmuykX8dKT0V31ZkETN4N4atn0JmT7yyhVG2ReDWedFUOY9Oq2NCSaeB4gD7+XaWgYaD3zbTqo59qnBpUczYcVvt6QyJMKz7Bvxicb11vqyqkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716455905; c=relaxed/simple;
	bh=8Jo5wl7rUaEh4gGydjD8qg1kgHPJAUzPcw1QVxEehuI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=jtl9d14ZgCsJFMX/TAd+88AzhESZfX4kbbtXG8T/txZENZllj5n/kt9DRH/23TZw9udRKIBAOXwrq0QdF9j4KATjAmKYINEKnRvj0PhGVzWLVn3mhLaLBhmrbLGb0BKApp3CviVK9TG+rFjZAEqqhnXpM4rfwC/U2e8UevUHRbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=g1P5YEXK; arc=fail smtp.client-ip=40.107.215.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMi8IGiZqqZVXINH/4/gexneYB8X/X46YKEjTA4ZV0685IRBw/CRewI2fFCBUIS1vSxq7bknSBCuoOVhcyRCqDlW1XIPZvOTtbkHfB7OeNmRlMjetdqXTUBKhfVweXaE83IYKr8DOjXTtuIJ9BhrH8D7szwDjPQYrdC63LqB/s+AP+VY6PUSISOTGJu6hD7N3SS+QpvpldMlE30MJYZBPHGwHIg+LPDRQbKiO2Vh26WIlbgfDYSqLf7NML7eHmVsGomg8+bJ2kr0TN/zN7mt8/fNRReTPC0Dtihk+zUmbqDYz3e0KNpe43BowD1grNqxmrzaJZjiTN7BAJkbiO0GFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nRkSH9ZSQPgqn7I08CoWfE+SUL19JFZWfDZFMyYkDg=;
 b=eyRTI0jdqNUkO8dcPk3wz0gx8mTRWA+HTBOcKeE/STAcBegx7b1WEtdTeajl4YE/6fltuwBWsO5prlHgnR5XVNwnzB3le1v+Px2eVhrQS9bqqjWFbHTSW/PU1BjVLF/xeKgRGICtVXiQosJWcIEYtrAgAS+RsFu7HktKP5uPLiwb5LB1YB7JpBzH3K9Bm43pIwzTlu6IuzPnORcOtm22M5rSPcJA3IbliNZCVQrN68OuTu8GYSXaKT2V0gpLNlpelFZ+Ciqq8Pec3oIHutWKTQREgjqOIi9nwlMcPyOnVe3h2ByQsC8PD44MjKSo48yZdKViLSfnPyUNlFMVbsMLoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nRkSH9ZSQPgqn7I08CoWfE+SUL19JFZWfDZFMyYkDg=;
 b=g1P5YEXKBz76Ha0Kk3xVlBfsLBKk/Gi1fL0g2VymSol0QUku/TpBLiH1FMcY4K20ieWiwJTndx0/szHzVHAKL+So6mTlm9zVhB8+DM7IUNCTudEp/DG8dEFb5qAgKrRGBk6626tusTMGQrCxslDTU8YlIvtpLkFz5txXHrhT9b5pRU02oIq7z15mzjjb6OQzsKyWTLuQGR779ndKLHNnEYYPZ7bmmpMT1Q/JfYVWbeczmXa/jN9lLI3e93rKWcOnfZl1qLa1XPyl46ChjOPI0axewlSEp9GLv7o/gdyfgT3k5rs+c7J8vPqjX2ai6T2v7cPRf2ZeNgD1wvvt4QwVdA==
Received: from PS2PR03CA0015.apcprd03.prod.outlook.com (2603:1096:300:5b::27)
 by SEZPR04MB5850.apcprd04.prod.outlook.com (2603:1096:101:7d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 09:18:17 +0000
Received: from HK3PEPF0000021E.apcprd03.prod.outlook.com
 (2603:1096:300:5b:cafe::78) by PS2PR03CA0015.outlook.office365.com
 (2603:1096:300:5b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19 via Frontend
 Transport; Thu, 23 May 2024 09:18:16 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021E.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server id 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 09:18:15
 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz
Cc: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 00/23] Add i2c-mux and eeprom devices for Meta Yosemite 4
Date: Thu, 23 May 2024 17:17:47 +0800
Message-Id: <20240523091812.2032933-1-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021E:EE_|SEZPR04MB5850:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a60028d8-59d1-44de-36a7-08dc7b0946e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|36860700004|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EC13U2q083UUejiSvPtVgpuykQ1MhoK3gCB3buO2HIZq9AIGrE6zVNCMix2q?=
 =?us-ascii?Q?pgpve5MSY18sfqszkptpdYZOZXTFfhqEO+nrZemUKfhwQM5q0gDymU3MFcIm?=
 =?us-ascii?Q?eCgSpLY93MWPIJp+1TZd4GQi7YKZkH2HSkePU7+d7p+KlLtlF39RV3eDf7+b?=
 =?us-ascii?Q?T8P9SlBAE/daK5gU5dX4z1oS0O4D191hxjKyIZjqYUd4SeTZu4MAsNAd6hwY?=
 =?us-ascii?Q?z/nTU1+IK2xGfdexRl4IiplZd/rZqRdcrU+sQL1vXO6kZOG1PhFmLqNBh74N?=
 =?us-ascii?Q?47xpHSvh41PX2WUN6VqJa8RxKykRvqaj4e0HoWxKg8EXODxkKldzvTheC5+c?=
 =?us-ascii?Q?GSJmcMh4Sckqx5mc7pFSfgsKTeiejtVZlatOXdKLOpDw5RucMwkWIxn3Td09?=
 =?us-ascii?Q?bLxi29Py5WrxPea2u9FfyZ1kiYqnrnI82SLnQPpQe7Ri2aOIDAAm4rdl9tnx?=
 =?us-ascii?Q?M+IAXLTrdIECXVbSFneMrkCXM9ZgmAbvvxu+YK2ACVJ+GumpoI+oLt27PhbZ?=
 =?us-ascii?Q?VCDaV1UDBpdCazKdJmAk7Y0acvxuKc7qInPv3BoXd8sERQjCYvg7JN3cvcsR?=
 =?us-ascii?Q?zfFmVSjNRhgLXEOuFobik2hTFuX2OK1t9PwhnORiDVlng62OhHzMtgV4UCwz?=
 =?us-ascii?Q?YLmyj4qzIV/EPmay16T1FpUX5HAVvGgV6romrDL5rlGZAB3nAn4aifW/Cnb8?=
 =?us-ascii?Q?XRRppZ38ecCzZ1lNSxSQ/T7jVLGCrXfi4lxpsq9cYtvbO9E8DIJiqfNfolNF?=
 =?us-ascii?Q?bePxsTL0JQrsvpaRd0FZUcCgyP8ifg/UUO3XUu2iaCpZ3d4kBkIBpcu7ciJ8?=
 =?us-ascii?Q?yXw8VNEMQQti0bplST5LSf2n/aCLauQbGmXirjnsLagxDgNGCyNz5chpfG9Z?=
 =?us-ascii?Q?ExO8fiFkEhHXxNp8MyovOAYrbQ0P/slmSV9rhpTNjyPIdeLG7fBl/tp8/WZL?=
 =?us-ascii?Q?UNqt9AZTqBYICYO0JBXOE/SPSxk14mFjoYgNqzF7AVO/DlUwlf4n9xGgPPpx?=
 =?us-ascii?Q?ybykBTpq0XshCVKfyNjx2fxocaYPfKl7JlXMODcGeF41rTlutt8HsvfuNdI9?=
 =?us-ascii?Q?bcgo/M0gV3e+tQ7PobLVsoApnnpLR77PyJpl08iT0801vMynhOOCY3OnPRzf?=
 =?us-ascii?Q?IYDqvuvv3HM9Qg1Y8wKIJR80cegWbO5xL4QtIIBJMR3FpGnLSb61/0VzKD6Z?=
 =?us-ascii?Q?rj9a1Ic36V7t8N9OPAhApl2uWN+BfmqoRVI3TRMNSbtPac3oO42DGYYWU/iy?=
 =?us-ascii?Q?38/JQpeNwr1qQnYVXUcVMeLFG7UW/DRplcjMoQY05ZTZ0YaCPhs/vZpZpF8Q?=
 =?us-ascii?Q?usyhfvRCwshTUGiTLlemaTxbrX802OzRqe4RdpBLuSyOTIWHgRCwOQCQzbyu?=
 =?us-ascii?Q?gVLZmb3IiW/kULObHv+Q2mhEVs3x?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(82310400017)(36860700004)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 09:18:15.1732
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a60028d8-59d1-44de-36a7-08dc7b0946e2
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021E.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB5850

Changelog:
  - v8
    - add fan led config
  - v7
    - Revise pca9506 i2c address
  - v6
    - Revise i2c duty-cycle for meeting 400khz spec
  - v5
    - Support medusa board adc sensors
    - support NIC eeprom
  - v4
    - Re-format gpio linename
    - Revise i2c device node names
    - Split patches by logic changes
  - v3
    - Correct patch for revising gpio name
  - v2
    - Revise mx31790 fan tach config
    - Add mctp config for NIC
    - Support mux to cpld
    - Revise gpio name
  - v1
    - Add gpio and eeprom behind i2c-mux
    - Remove redundant idle-state setting for i2c-mux
    - Enable adc 15, wdt2,spi gpio for yosemite4 use
    - Revise quad mode to dual mode to avoid WP pin influnece the SPI
    - Revise power sensor adm1281 for yosemite4 schematic change
    - Add gpio pca9506 I/O expander for yosemite4 use
    - remove space for adm1272 compatible
    - enable interrupt setting for pca9555
    - add eeprom for yosemite4 medusa board/BSM use
    - remove temperature sensor for yosemite4 schematic change
    - add power sensor for power module reading
    - Revise adc128d818 adc mode for yosemite4 schematic change
    - Revise ina233 for yosemite4 schematic change
    - Remove idle state setting for yosemite4 NIC connection
    - Initialize bmc gpio state
    - Revise mx31790 fan tach config
    - Add mctp config for NIC
    - Support mux to cpld
    - Revise gpio name

Delphine CC Chiu (23):
  ARM: dts: aspeed: yosemite4: Revise i2c-mux devices
  ARM: dts: aspeed: yosemite4: Enable adc15
  ARM: dts: aspeed: yosemite4: Enable spi-gpio setting
  ARM: dts: aspeed: yosemite4: Enable watchdog2
  ARM: dts: aspeed: yosemite4: Revise quad mode to dual mode
  ARM: dts: aspeed: yosemite4: Revise power sensor adm1281 for schematic
    change
  ARM: dts: aspeed: yosemite4: Add gpio pca9506
  ARM: dts: aspeed: yosemite4: Remove space for adm1272 compatible
  ARM: dts: aspeed: yosemite4: Enable interrupt setting for pca9555
  ARM: dts: aspeed: yosemite4: Add power sensor for power module reading
  ARM: dts: aspeed: yosemite4: Add eeprom for yosemite4 use
  ARM: dts: aspeed: yosemite4: Remove temperature sensor for yosemite4
    schematic change
  ARM: dts: aspeed: yosemite4: Revise adc128d818 adc mode for yosemite4
    schematic change
  ARM: dts: aspeed: yosemite4: Revise ina233 config for yosemite4
    schematic change
  ARM: dts: aspeed: yosemite4: Remove idle state setting for yosemite4
    NIC connection
  ARM: dts: aspeed: yosemite4: Initialize bmc gpio state
  ARM: dts: aspeed: yosemite4: Revise mx31790 fan tach config
  ARM: dts: aspeed: yosemite4: add mctp config for NIC
  ARM: dts: aspeed: yosemite4: support mux to cpld
  ARM: dts: aspeed: yosemite4: support medusa board adc sensors
  ARM: dts: aspeed: yosemite4: support NIC eeprom
  ARM: dts: aspeed: yosemite4: Revise i2c duty-cycle
  ARM: dts: aspeed: yosemite4: add fan led config

 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 1410 +++++++++++++++--
 1 file changed, 1301 insertions(+), 109 deletions(-)

-- 
2.25.1


