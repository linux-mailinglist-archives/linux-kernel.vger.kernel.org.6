Return-Path: <linux-kernel+bounces-295243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C10B9598FC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECEEF281B8C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7BA1CDA2A;
	Wed, 21 Aug 2024 09:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="vIzvA6ZK"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010024.outbound.protection.outlook.com [52.101.128.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D747F1CDA02;
	Wed, 21 Aug 2024 09:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724233282; cv=fail; b=X/po2UGLfZzZf6uD2x/QVdMvKmH8kuFnFohZukNWetMHv6rXkh82Pmrne1OizhovhtEpYw9XxAq94ptFxWtMjWDqwpsiRcdSP5Uj+I4eMw/dJBDL3HVkWSQYAYHjsikUE6MPBqybkYvg1++NRYUJ3O665xwJC59QlE6Pk2cUAss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724233282; c=relaxed/simple;
	bh=vYjzz1aYfBH2mFL4yevU0XB2bNSidM/xuT65NQvJtTA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=cu6xUbxC+Fyfmzddxr1KzR7AYL58RSnS183PzLe4WrCbkG/N6v4kW4s4zK9caLn3gvON55rEmAG9nPKvKEgUYpFrflVYE09jQPudbOOcSAbJN50YYAuQ0uuLVVOAZEV76ptjSk0F/QyWflB/F31gilqxNRO1N2CvNSgoOWxrhSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=vIzvA6ZK; arc=fail smtp.client-ip=52.101.128.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=axUtb/Jfxm3B+PF2vXAqB6LKHk+LJ/7BeLZt6maiul1q0YQSOWHfPrUPzerqw4QBQxTgoyd48eYXzAqgQrj0fanZ5JMXFjqpKL4+I9o049O7PdMhnQ1uoWhYhLHym1UUKCf/q2cC4rgJR+yKw5qowXqPaeWFxGVUAz+KZzdPOz+0fpS7JxtQtGfTyxAvtrWHNul7xMWx/lmof1J+tFDAFg6GVlD2gahgTrilCcpwkEZI441ROwsF3/4QgI935+VXSNMBr/AMTmuLojZXlh4PF0gB9fW8XjNi6iMA+6CAJ9+fk4ZT7kDdN/7UytB4GLI32P7zFlZI5WzURUf0b4F6lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djWCQoHVCoKcuHjbZqQuK0GFNl1DzKJBRGUo0YAeUQk=;
 b=coXjJ67uW16ob0MrcVRC6ZexHwugnY1xta4QcXC4l+LcnGXIfsfeLxCKblR/hrLNrNZKdanwIjoSd7eRVa6riV3hegpN8EWKge8NWlGBB9bMBwnzHu8jhAqZHt4wfFnOPVMCL3jV/qJE0xezYalVhVOFztT+sEker2MPde51VScEB9ahw6WtqXInG/MivdjrhdMl/kZoSqHxckQYrIJDM1ZUUC5qr0XlV8i51I0sdPoh8skzUA7rxmkPSGkl8TWutvqmesrg94zs33NPaTZAGTzBzfqL5Axx8EoElTqqxIxGFHQbMwHIiRvnz0+BUKAmifYh+aWWuWFrkNRw7CmDzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djWCQoHVCoKcuHjbZqQuK0GFNl1DzKJBRGUo0YAeUQk=;
 b=vIzvA6ZKEVaO/auT4HbqlIpWpRVeAjlbwTrZJ/GjuBHBlFutBebw2A3dvByU5U0gWqtR35j3wbelRxjJfgfkl2ZEHweVCZipK3PPy1R33jXzghvBYrMMWR+ZXhtYpUS3FbTKLKv18AhlMPte9L+CgSEHfzh0X8NtHXgZKa64KiAQQCdskk6cBTWS2JQ4bulBJBTNg+A3FogE7C/uwd9sqbXEbwWZHmdBtRBYthTVtIh312bYi86ZTEzIrvpMjcNhWsb7QxlVhqR3jbukWXI5nK9qPQcZh9w06JB2XvxNx5sqdA673ArIFRyi06YyTBwUeqVebGh6h67BzMJs9xQeoQ==
Received: from SI2PR02CA0036.apcprd02.prod.outlook.com (2603:1096:4:195::15)
 by JH0PR04MB7976.apcprd04.prod.outlook.com (2603:1096:990:95::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Wed, 21 Aug
 2024 09:41:13 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:195:cafe::e0) by SI2PR02CA0036.outlook.office365.com
 (2603:1096:4:195::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25 via Frontend
 Transport; Wed, 21 Aug 2024 09:41:13 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server id 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024
 09:41:12 +0000
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
Subject: [PATCH v13 00/29]  Add i2c-mux and eeprom devices for Meta Yosemite 4
Date: Wed, 21 Aug 2024 17:40:11 +0800
Message-Id: <20240821094043.4126132-1-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|JH0PR04MB7976:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ea3194f7-99fa-4232-446b-08dcc1c56564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yewKOnJVxie+XVPsWy93hqW0zHM04yN/L0uqOt8ZqAGdJzdr3BxmaJ1b/XhW?=
 =?us-ascii?Q?gNQFfd1quHw1W+OjaGK7vRROI3M+vLyTmLy955h+VZzhbPNpqrWfqhFVKeSR?=
 =?us-ascii?Q?3itCLbt7t06UmFy1h3gHqB16+VcV0A+PGN2HsiCJjcl5BuVs6+TelEdbIL7m?=
 =?us-ascii?Q?9HGLVCqVi/vVUj9UBU0fUR3iYmzSElpTfBe73w2pSlYjnvZlHzk5BAhNpopD?=
 =?us-ascii?Q?JhFvpg//TRuMrlxetnpFV+AoH71tXkqUTHNs1xMDZgDccDThjcSxuxRUe29r?=
 =?us-ascii?Q?BSTAtYISKyz26PIDxcwcgkvK7kzvgpxYnM2CYETULOcPVl+/8206P3FMomWW?=
 =?us-ascii?Q?kMAMrEWs7juxxqfMeZPv8TI+KSnLq/CWqDG0STisGtuAgI17UMMRAv+Ns/5A?=
 =?us-ascii?Q?Zl1kRdmbi5RRZ/woqDpAH77Gvj57FYXETnw3hPp5U9gadi1zFKx3MLIB1yDO?=
 =?us-ascii?Q?vxR2TfYMQS8+o8TEQMe7yljcBahWoSy351EM28gNkfTd/dxuCh2ikZ/SvLam?=
 =?us-ascii?Q?Q3/iFA7Lkgr7xaQauouuLSvsb38/r3C4i1U+z//qbMRnwu+o4KWL//chmXX9?=
 =?us-ascii?Q?ZMi5BRByciivB0j6cYN1PHL3oYS+Tyn+m+7VEJKD4uHK6f3//v02CMZSdNI0?=
 =?us-ascii?Q?Rju2JyLjG5v8pzpkQWX9IEeCWzIXS8nyYBgi7IbLUYfEJQXG4dxR5lVGBPqq?=
 =?us-ascii?Q?oJD67Ae6+0y62ZCUdFySOsikCC7FYe2Nt/9IvVTx2S2TdXVVBpSjHlZUGLIw?=
 =?us-ascii?Q?mn83mUmYzuWqBwi8eiB6Zk1Ug9KFITY3CbJjdOE2N6uDqZklgc0VZaMNwk50?=
 =?us-ascii?Q?j77fWLKKD7pECd/X6p79sMNPZqsSu2PMZUN3vhtU86HgIAFO+/T2CVeFBmp9?=
 =?us-ascii?Q?SAAQ8n6Nj/8AikL1IsnBwntGTH9ITilhvrDDpHM0w3YemZgijCwie2G4ATf+?=
 =?us-ascii?Q?1SdZ7TeR/bq50SXAtAfqb+KDVbhXsWeqRsFCAFatxwkjxT2uJD//okyuatYz?=
 =?us-ascii?Q?t2h8c2AfxehD+MHovndxCHuaq5vQ+DGXx+yyR8GOzzZb5dRG25AOfDx+50vi?=
 =?us-ascii?Q?gJesyFd98pBRSQ0wYJ7PFO4ifjPBjGXIt9BbewkqOzdftVpZ6LA1nvy/BqUT?=
 =?us-ascii?Q?/+fbsKw+zbtqhBqnEHr/9vk9VEYZzgNuHK8Smo9xf7uelv5AjXF9PN8xEHXl?=
 =?us-ascii?Q?ZhPXlkf4UExkD6lRe7yH3pqLUM3HFoX054pcudzzkBOaY+bxpPurcP6OgI2k?=
 =?us-ascii?Q?1NDAKZ7tOvN7tI5exc7eV7yQdj16fM+lFms7psW/kpufy5aIUmsRqO2UW60C?=
 =?us-ascii?Q?kebIxBwkg39NvnNXjulfpV14MKN1ULKZHm+az9Wap3A45XyBhVcWBUZ9trgk?=
 =?us-ascii?Q?nW2FB7bnWUUb16R+RvqE8WuX0mCcc8kd6iyK5DTYOZyA9A3UJHYEkCuvHyfU?=
 =?us-ascii?Q?qPlDqaQSER+hU6zYU7zw8S1WrUgkCpCm?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 09:41:12.6993
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea3194f7-99fa-4232-446b-08dcc1c56564
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB7976

Changelog:
  - v13
    - Add RTQ6056-support-on-bus-11 
  - v12
    - Fix GPIO linename typo and add missing GPIO pin initial state.
  - v11
    - Revise all GPIO line name with bottom line
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

Delphine CC Chiu (28):
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
  ARM: dts: aspeed: yosemite4: fix GPIO linename typo

Ian-I-Chien (1):
  ARM: dts: aspeed: yosemitet4: add RTQ6056 support on 11 (0x41).

 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 1749 ++++++++++++++++-
 1 file changed, 1653 insertions(+), 96 deletions(-)

-- 
2.25.1


