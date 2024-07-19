Return-Path: <linux-kernel+bounces-256975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED5193736E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 07:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C69A1C21AEB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 05:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9B93FB30;
	Fri, 19 Jul 2024 05:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="rxmlZyOP"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2074.outbound.protection.outlook.com [40.107.117.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC5236126;
	Fri, 19 Jul 2024 05:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721368762; cv=fail; b=l45t44jt+IVAtiRJtlVXKAuK2QhXOYJv5txxafUXRiBUQqDpbTX8oALwdfyo+3tHjjixC8MV8/rnJGHYMhLJdnbIO70bpS4y5wWXk5B9TaNmEOydO5kMuLVFsGPMY7MIzSaNxY0WPQc5vdAVnT5skc+qXLA7qHpI6gFlRMcvWIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721368762; c=relaxed/simple;
	bh=wU6uA0IGviytPTzEWcovvnig8CDc0UVwxQZdm4zW5oo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=HtIFz1/o2Z9WeI4IlTfacaCwTJaK5TznTSQ3Q208hzlg5v+zqkFf0GYgI4ajh8uYadHsc0jsXedzQiCFw3//vL40vS9Mxu8o4gyCx7whE1dsk5pwbzaBFUXcdcfsQg/t8MoOAGOIw9MweczFclh1jHaMxQKRIxgQTIF9VQcsP30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=rxmlZyOP; arc=fail smtp.client-ip=40.107.117.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FvM9aRCwB6IK/3WyEHmpBZ2TsR0ywXUAztNLYx0lD4zfXuWYMxANs435whLA1EYtFDtcOUbwrIUBNjAK1c0nAN2k15OdZCbOy/5YTRG1CHGI4OPE+KRl1L7YMLZ51eQkd5UDdzZky5ABqpNTydzT05kBw98SWVhDukAvPybAiMTmosFz5k4cUcpcJUJJHt8foeltXd4wHQXtM0LUsa8rBn1lBP5ZriDENlFAI3nyfaMfgFhCCWBV/GhuDn29qck/UnLMt3MjYEXdaYzhe0kNHR5DLGDHSGCVMDQCZw/NGfSpTu7n02iPy8Ruwxv3gbUShquIRFiwjziqkte8pJwvwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfglE2V8n8TQF8wA6TT/ltpHGJ+hI83lDbWK0kbOWHs=;
 b=K0VbEYzyjJ57zysFO9zqb/AB5C7JSRtE/82up3EttEQse7v2jYglazvdYi+/1L8sEdigVLhHll6pRQ6ry7qkQfxxSI0j1elu7hx7b/UFqk3QusfQm+6euSSo05P5VVJA6rOFyxEdXbjH6BcWgG3FUetpKCHCCJxSPkSHYfLt5N2x0JJxDg+Syr5pVe/NWhPbIPHNGvHEXxKuXb6pi6TG/bJcuuwl/soLnNXv42q0HXX+VOT4c9N0xvUFRnei/11UUlHjdFdTfGxsVvmkVys9xxcYNoftIeLhG+WEdpNg0P0ASXzpy3URGmss9/lTPJmr1ncsL7raZa2s9HsuEQKHUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfglE2V8n8TQF8wA6TT/ltpHGJ+hI83lDbWK0kbOWHs=;
 b=rxmlZyOP04AGKiAiJFvDiXLaAwv5X2m9wB3HO4wHlqX9z1U+LZ1TQmBzZDCE0sTuV/D07CBfUNW3gCTvlvRA+BoskkdSdT9yDiBGjpWr0pjRT/8amTuuKAHjzhuvAWZx3Q1QUi/haW2VmyfBbkSyr6TZUOfvbuj51SyDouMfPO2G2Pw+SpD8bDFR0XUb93BtkBcJDCaVBuNjRhmYSg755kcjp9eqB2D8FMSdWUX9aWw5CNth7AllKOlOSWsaZo9wXMRAIMayTGT1Mq204yeLXl2a5gDQ0H7c+zqyTWDVQp7yC857LVXv/T8hX0gUgSgw9t1SfjeqoWDUIZMJfOVhag==
Received: from KL1PR01CA0075.apcprd01.prod.exchangelabs.com
 (2603:1096:820:2::15) by KL1PR04MB7611.apcprd04.prod.outlook.com
 (2603:1096:820:11c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Fri, 19 Jul
 2024 05:59:17 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:820:2:cafe::1d) by KL1PR01CA0075.outlook.office365.com
 (2603:1096:820:2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Fri, 19 Jul 2024 05:59:17 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.7784.11 via Frontend Transport; Fri, 19 Jul 2024 05:59:16
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
Subject: [PATCH v10 00/27] Add i2c-mux and eeprom devices for Meta Yosemite 4
Date: Fri, 19 Jul 2024 13:58:29 +0800
Message-Id: <20240719055859.4166887-1-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|KL1PR04MB7611:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 364a67e9-cf35-496c-5988-08dca7b7ec87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|34020700016|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U3aZtKZs12FPZ3hVao0zm+kzSYq6QPJVagtViGgAbpN8lUS/p0DdyLwxkXm7?=
 =?us-ascii?Q?Ps3ahR/ZGO+9okIBCxecx2s+nXVvX6D0jvYKmbZO355BSxMtlSlI7svUIUDn?=
 =?us-ascii?Q?us2WLTQeFdq2NMnwfKhU55Ef4gq1JT7qmyG2Xy6JjHQ61IRQHmNZPzs3oOfw?=
 =?us-ascii?Q?5NZQGvAgWUAhdK/EZet6JA0xax1mMZp5q+07ejwCCyiFqgkG/ujoYf9bPQSY?=
 =?us-ascii?Q?4Nq9078qhZ6knq+f0rv8/cjzY0S9lbdNJqk+zkaD/7Hx+yrpTxu8yfTFm2y3?=
 =?us-ascii?Q?GbKaiSSNUvic2YYNPRtpZnAE9sL5j/0+RxPOQ/pxAPSVMC+Se9L5RA9YhJby?=
 =?us-ascii?Q?NV5hkbZwpO7z+yQ+c2+dgzPCti5/tdAwDhu+om4iNlF8bNZ5lUV+ywEjkQgd?=
 =?us-ascii?Q?4MDCnS+4Kfyg0lC51dpHxzVKwLpS8NJYmiU3PO30Q4f+pqx+Uy/YmzVFspjv?=
 =?us-ascii?Q?2Q1Y1iEhOxR91t6DYzNJlSUBbjqXpHLq7kF/ScM2pI4Oe2jqbTpYt1Fe9nIU?=
 =?us-ascii?Q?OnLqjL68Wiuw6qc334RdLj6B240J9vh1HSeFdT2eHQZRv6ZKvZS7rn4xMH7N?=
 =?us-ascii?Q?1rIOvgrrCv0xlcZRZsactnIQOy4YD4XA4gUm8uVPb1lMqD9jweQxyi93+IRm?=
 =?us-ascii?Q?g00Jsa4ClfnoL2W5qbYSHGlT5NAKtawagvWlFwyEu7NQtck9S3SOaepv74y7?=
 =?us-ascii?Q?70XV5T7PkKIYAa3erAuJb/yq9kAocfS6YsX8rpEaQA/A40xveYcLWEKd/jd3?=
 =?us-ascii?Q?F3nfUi6U9mbGdbuO5Aw061/uoIScA9F/BqVhCq/lLw/dk0dqGZC5Xo6mouav?=
 =?us-ascii?Q?F+TnQ10GFnYaQRikJ2rbVdNtOcI959GWyehiviB4VrbIjfpNVfilmkn+SmuE?=
 =?us-ascii?Q?N+CtnAnjpld3Chj4ABwtfFe+4fHziFKpW3wagrYZGgtVjs4U7CetN7/wbtl6?=
 =?us-ascii?Q?Q7sfu4Gg7+9Uifw+mkHB3RKaeX9de1kcQyNr8iBq8aq4H5xBuSb/uOlQ6SEC?=
 =?us-ascii?Q?knUAKoPCtit0erwOOv4TonKtSo3S6gtt0hFx/rGBg7gRmjj94XmBBGMH7E7T?=
 =?us-ascii?Q?S2lC1aw4AWJ1m7hDm6ADOR5QEPQCP1M81es51uz8f0Qc0kNMVHh2BQ215Sbg?=
 =?us-ascii?Q?sm8g6h9zR34Go/Nax432YIfJe02JBwIE/Ys/HnlMeABZphA9Kjzs+qjIdNEb?=
 =?us-ascii?Q?hoEOV/lVHHlwKEx+mTAi791i2Oa2z/GVWe1APHfwGZ67HSWgEbrfvu0G0iho?=
 =?us-ascii?Q?p3hs3kSjwANr0QAUx6vFe0mBcPEkDwMg/K9yu9pvmCc3dVIIwQANsm907hru?=
 =?us-ascii?Q?4uH7BousS0oWftRUsK8HMWvrpbaAVpnKO0yBgbn03MclLSr42mdEa/7x9Uop?=
 =?us-ascii?Q?LG/DfetwBB9tEkoszeZo+MRmxhv29w7Ci27/lYmIElho+CZ3+ZgPhkcGH9c1?=
 =?us-ascii?Q?AdxfdoY+BnT1Lq6YntybJyjDBZrbgUKj?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(34020700016)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 05:59:16.6571
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 364a67e9-cf35-496c-5988-08dca7b7ec87
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7611

Changelog:
  - v10
    - adjust mgm cpld ioexp bus
    - add GPIOO7 name
    - remove mctp driver
  - v9
    - add XDP710 support
    - add RTQ6056 support
    - add MP5990 support
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

Delphine CC Chiu (27):
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
  ARM: dts: aspeed: yosemite4: add XDP710
  ARM: dts: aspeed: yosemite4: add RTQ6056 support
  ARM: dts: aspeed: yosemite4: add MP5990 support
  ARM: dts: aspeed: yosemite4: Adjust ioexp bus and remove mctp driver

 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 1421 +++++++++++++++--
 1 file changed, 1311 insertions(+), 110 deletions(-)

-- 
2.25.1


