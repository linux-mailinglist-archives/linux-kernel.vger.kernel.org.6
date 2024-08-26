Return-Path: <linux-kernel+bounces-300792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F60995E873
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 623E1B20C10
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D7582D66;
	Mon, 26 Aug 2024 06:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="JFgItkIL"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2052.outbound.protection.outlook.com [40.107.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6583D8827;
	Mon, 26 Aug 2024 06:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724653466; cv=fail; b=olemUcK3tUZAnGGBfjAd0mZt/tIuoJ3i24iUHsUWE/UVmTFTCIPHnMIKVsPi08ZryuPy63XCJBqz2GK8jAzbxSP3+D0ir1xsNj0OMUl/x2bUAbHnrY/5kseWmpndscH5kl+pOY+tJCn8hQ9Ad2YZbbfh/X/YYTDFJkmRkizkSYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724653466; c=relaxed/simple;
	bh=NXrwSqyXxq6QyccjkWO2RqYDIP3VMq/Dfn6P2AKr2jM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=CNVhMJZ6zsQ8Hxj5o9IfTVmXGwtezuo5hjgh6tc59MmT5+CPBRFsArcKqGuLoUGLQCUw4XcRPWGbEGQnNVD472xs4y9XYb3yBuU2NH13xt6v8s2Em8tjI6MWACSa4saVbS3uWPMHVB5dZeB7nYaXAGbpn9an6wobDx9hP7VqnkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=JFgItkIL; arc=fail smtp.client-ip=40.107.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2GvEFogdDGjRy5J0eP2qOK2TB9OnaT8HwL+jYRi0dVT9l4ZicAcAjAKXjKoKACugLm1j2HIZ5vd6atWCRrANp2SCoZyytcP/Izicw0nY7nx27AAFfhGfh6XxyVxYD6frR2YmozqFJbFpnfBq+m6HEHCfY5qT9RQiQ0MCpiFUUt+VsG1N3n5fLX8obU84+WIcP1prM5QrfwFWOkjm3oxjTuZbNwBzy3O9Qa7QAjdXkTuX7YYsq9ut7l1AlRsV2r3DwHgMoXDf6ByIX+cn00KTq/PaFVqpQsAO8qB5e2Bv4xeBxfQ0csg9V5fBejEyC88XS1KB19hGZQlJNRoqlluHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9FgqTvY0b3F8ICBNhimnFhtgQoGlAYJ/3xkwVfEip0=;
 b=I0iH/+nvf04MhOW5LOVE5iA3spaxhK/LFIZe+z7s6pCgCYWZAv3uvC+iqeaWkyG8rCNbQLv53Q9LzRUDt5MVgENLr9B856JW/F895luOv94+basRBnyH32zFTe39PVKTp+oAKBMLWMtHAt+w8Pls+X+Gif75tlvF4ijeJcU1Wmr+pqwulzEYKLHZGwNvHecyQWW1kwzPfIUVJKPy27CMOc67XYLo07wBGttuTGXRFanr/BKJbzG2POTBDla0dqShygn+Bpn96iMIqPE9bjAjDWLutVVXZlh+oyNUVd1RMpNsmLRjCEPpsviC/zwbLM8+0+QOBQqRNWFtLTJlvfIlIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9FgqTvY0b3F8ICBNhimnFhtgQoGlAYJ/3xkwVfEip0=;
 b=JFgItkILl5W3XPVj87A2Vj6p9+Xwtyc+aFp5bTcy9wngUOMfQxuf/UffC4gRqIePNx/HKp8F/bG784AmMUbI8JCM6+i1WYknJye9vQyiAXhUJdnudVfcVaOvuiJhYFDNrJgx6Zqttu+DaMEdYxV/i/5ZTGncYKzEY3zYxaLbBt0ujUjXyMlB2jDgMV5eZFr3JgkVzw5FJr132qBf0bAOD2xG+Kh4AZNj8ero7xpTCz5qAAfSTpuwXKsLrn4HSVQpfRqm34KjK6Op7X/naPqaY7J7CM/6QHMUBxkDkFp++RsH4QIxrG4i2HRMH/OXm7bc7u8c80/EW3KU4LpDNVz+Wg==
Received: from PUZP153CA0004.APCP153.PROD.OUTLOOK.COM (2603:1096:301:c2::16)
 by SG2PR04MB5988.apcprd04.prod.outlook.com (2603:1096:4:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 06:24:17 +0000
Received: from HK2PEPF00006FB0.apcprd02.prod.outlook.com
 (2603:1096:301:c2:cafe::8b) by PUZP153CA0004.outlook.office365.com
 (2603:1096:301:c2::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14 via Frontend
 Transport; Mon, 26 Aug 2024 06:24:16 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB0.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server id 15.20.7918.13 via Frontend Transport; Mon, 26 Aug 2024 06:24:16
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
Subject: [PATCH v14 00/31] Add i2c-mux and eeprom devices for Meta Yosemite 4
Date: Mon, 26 Aug 2024 14:23:34 +0800
Message-Id: <20240826062408.2885174-1-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB0:EE_|SG2PR04MB5988:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e97f2991-96b9-4c9a-c18f-08dcc597b5ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KB7l/O7jJ/fwmqRUVtEuOjmCTVS1ePDZnXzZ3pmIRnTFp2VPeXAykaQ7n5H5?=
 =?us-ascii?Q?TcCqYP9mTFKcZYmz2/4RdsK9b2kj1Uy1L7N6kyjrIRZuVlDbtdueOggvs2Hm?=
 =?us-ascii?Q?rdKEw+ydT67htoydIfJjUeJrSruL4BM1L1I4ZrUTUndK8F2LNukm4UOirukF?=
 =?us-ascii?Q?gj+l1Lz4oFKWRn7mptmyDfYwRk/+dAc//CAo+JtGSlvHml1NZ7exukFHk08h?=
 =?us-ascii?Q?vddDn15G1BNoGZiDlJ086uwZOe/Y+kyAsBn3CxBFFwNoa5s9Y22BmwFxvzuU?=
 =?us-ascii?Q?m93RJIqGPx1iInhYA9RiqfdH5rWcbH8Byf1pT5irtuVt4ezBFqkWTclX3gXC?=
 =?us-ascii?Q?BfRsW/3sxkQqR1COHqDOJee3FhUtjiXFpkJNn2vmDi1c7IjDSBLj8Xm9X3Ki?=
 =?us-ascii?Q?XoXBdErTbIxU8uVU2IbuhneGD/RXP27ONisxuh+3dZ+Aw8C2RVwY9I+/hw1B?=
 =?us-ascii?Q?hNduOOO+QzOELv4lf7I8NExsmwzKo4ITz7BqNRhsPR9iS8sTkm7HUgw1K6M0?=
 =?us-ascii?Q?2jiO8Tm59eKLdYNRKIZ4ahJk4/lh3tGZAD9rDsRcWqOUTvr58kXA0ShmCN/Z?=
 =?us-ascii?Q?u7hKS4SnL60lLANw9bju90oz5Gamu5RbBmor6df+kxr7yBWet8tCb636K0ey?=
 =?us-ascii?Q?BLxe0ZQeneXZOWH54z0zRdiXFAvCYg4Zh/Y037gAaNlMNgg9WnYmUfpNd3Os?=
 =?us-ascii?Q?06YKtKjJP77SI814zVsWui2Bo43OQNq8ejWyCqFJtZfxDU49nHRzVPNFHKbh?=
 =?us-ascii?Q?R8Ra0aa5n+EPpnSyaaHmE2Pp7yEahTQA/ef+wbPn+dc0/ok6zdL31ln8WKe+?=
 =?us-ascii?Q?/O2n2UVbVBKGgwIRUt0VZtPhho2PSkx36ls0CZTf5/IrN4iR7qLL1cYudHOl?=
 =?us-ascii?Q?ZB6ulC9TrftvMggdaPZBrzJwHcMZbNBPDCwu/nfg3TjnWllGfwDTr6hSyfuA?=
 =?us-ascii?Q?hAuQ3jqNxr4LKVJnTQbKAis6FP7x1R+qTBUtiC5Qr0meKu0Y5oxne3XMpnfZ?=
 =?us-ascii?Q?1r4Phi0AsXzy19SXcyDvopWf/Cba4vxbQDeZLplvcmB5WPAh6D5yKxcQdmT/?=
 =?us-ascii?Q?kt9pKSuZbI9jkacwUe/3sPD1zGRpTCyKvRydHnTWer2Xtsvy7ogSv3REk2j3?=
 =?us-ascii?Q?5CHBumyXc+lgPkS6MExN7H7czD/QEvivAATxmeSlnG+InCJ4St8IGMp56Oa1?=
 =?us-ascii?Q?WaAZuCXX8u9wAuLQ//QhpXBXWL1U/n9eMBFtLwxjIEEae0tX+tyk54UwAvx+?=
 =?us-ascii?Q?DRUO5gDEpJKjePjLeQYR/GwlnfyPug5SrIoec+0eLbqZD3pCK9KjsZQg+JDy?=
 =?us-ascii?Q?VI80qRKDzEmCkIqpDIeiHtONZoIPWSV5t4QMfG6J/AkaF+ZvZUMym34hYAfb?=
 =?us-ascii?Q?piD5sSNYvEvo37cJZdjPP5YSd3Ko1l0ini5AwaOcEdg8I1j/AptQCIHkrZv9?=
 =?us-ascii?Q?dJSJgikLAUn1ddkwT5wwycoFSjnQGUMP?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 06:24:16.1751
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e97f2991-96b9-4c9a-c18f-08dcc597b5ff
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB0.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR04MB5988

Changelog:
  - v14
    - Add SQ52205 support
    - Add GPIO I6 pin
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

Delphine CC Chiu (30):
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
  ARM: dts: aspeed: yosemite4: add SQ52205 support
  ARM: dts: aspeed: yosemite4: add GPIO I6

Ian-I-Chien (1):
  ARM: dts: aspeed: yosemitet4: add RTQ6056 support on 11 (0x41).

 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 1753 ++++++++++++++++-
 1 file changed, 1657 insertions(+), 96 deletions(-)

-- 
2.25.1


