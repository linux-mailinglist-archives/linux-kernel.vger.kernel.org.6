Return-Path: <linux-kernel+bounces-259804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFF2939D6E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62A351C21C8E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB2C14C58E;
	Tue, 23 Jul 2024 09:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="IOjrtLZJ"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2084.outbound.protection.outlook.com [40.107.255.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC1522EE8;
	Tue, 23 Jul 2024 09:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721726605; cv=fail; b=YOseqA7xfacwS8me9n3RZpIG+PoNe6YBdUBTw2MyCN8iaNGpnuQTKL8fc9EpG7fe/w8075VOMGMYviX4pM7BPsvAeR+rEVue6ZHXLQAxRehpwJUBQzLntbZsxF4eE3+/txD99qiPofwICn9aNL9U+BpOwVH2U2smBrH2vrlEozQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721726605; c=relaxed/simple;
	bh=sEZXYPFrJnk8QdfelEPDDrKfSjTTBKHebtfEOSmXvKI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ubPyuIle8t31nlSlpeeWUn6/rQt0EDvcmT3iIHTV8XPCkMKek9mEByxCk+lvTeY18GW4+CGGrtPjdtmnZXV54C9YLlFRJHCkaSZW1Q6q6ITzdtolXAcZTztg6HiBKtKwFKBXlwnN6tvw7eyQotMv5v5ZVvbCRRk7B7qrLwkebQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=IOjrtLZJ; arc=fail smtp.client-ip=40.107.255.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bomz6S5D0g/slSpzO3as0q4MUA0tcK2J80cx/SEGpHRc3VXIE7Dbp1CxqKGuMrgmz9+2dOxYKJyY5jmREtKa0q6cDEnDo4vg+aY24oM6MiwbN7/baX9nzX5ZFPwnZkirEy3Tadoe3ANXdxdfmJyOLTyYPzl6ngZBGtmcbTpGBZXDto5elAqLlgbKCVV0XWTR2cmeAxbm1mivQCL0ZTADYlwMAXlCXe6OB/56e4e0N71GMWqq8qw/1s86iJ23n/XJDbCWl4PNHqXvKlaErdouv16qj4Eeakm3MHKc36LZDWz1SfwmN0XRQ5l+zDxeOepyEtLG8++KYvzp/g/VwXJrxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Ig2d5FwjpJvYwke3+Ux2iJkqCNLAtJhFuRuqP1Z/QA=;
 b=tmbjk+zzO6GR2pvn+ePo2DSDwbNkBJHIIaTYSh3N7Vv6WTsGxMwC4UdlX3ASKI9MSqZTJXmbJgC6Ylgk3Q5xH+FdLyjbhHLiTaMvL0zof/2DvOSkqnCh1gd26tOiBHJ9tQ8xRRVYJsiiI9I3JiwbqXrIy+2liahEFPyxDlOYbxYlEmX2LOSE4blz4GCZtkezNjNKCFgry7Jso0mBLkJJbChXYYObDnyYsw7kna5LyZyyr7Tvb4M6Pk97uSIRD8DuAGSYAyhmKj2vk0rn2IbPHAD7wRCofetnx8B+e3ptgWkvg1/EtNJezmFBmeGiCzFAADAG/2Z2y01v0x2VC1Tsfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Ig2d5FwjpJvYwke3+Ux2iJkqCNLAtJhFuRuqP1Z/QA=;
 b=IOjrtLZJxBtJhZpIk6FwJsp1abSffy/3rehjAaEZbRgedqjcLuBs3DvCEff8WBKeAw8s+HAcNFkwgK2HMmPyca/FUCuNzjg59BW/0kkgaftCGkV9dR6OA7CTRQcnLRgDkyTm2Hc3VHvIwFgvPT6WMaKBI1tQLPZOdQTVWrqAQw4I0IiM1RKUvh5xeEP0fpGatkW3B1RcyMML+IuMpJVCVSlCplVC/9rabHe4sAgNswp9FKVBBNzjPCshTVqjO9jyi3IIM40auTlfBn0/8BZ0923JeOyYrlGOWIRupe7XBIrkT5HHHjTz7YaYX4UsFk+ZIwq2DBmUNK3Z8QJQGjpdyg==
Received: from PS1PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:300:75::19) by KL1PR0401MB6178.apcprd04.prod.outlook.com
 (2603:1096:820:9b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Tue, 23 Jul
 2024 09:23:20 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:300:75:cafe::f2) by PS1PR01CA0007.outlook.office365.com
 (2603:1096:300:75::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18 via Frontend
 Transport; Tue, 23 Jul 2024 09:23:19 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.7784.11 via Frontend Transport; Tue, 23 Jul 2024 09:23:18
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
Subject: [PATCH v11 00/27] Add i2c-mux and eeprom devices for Meta Yosemite 4
Date: Tue, 23 Jul 2024 17:22:41 +0800
Message-Id: <20240723092310.3565410-1-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|KL1PR0401MB6178:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f48e57ba-0f9a-48c4-29ac-08dcaaf91711
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d8y6S3XGKQRr1GgLsPMZWMSprrsixr3qXKszFYmwJ7fvofF+7YTbCzwMlsIH?=
 =?us-ascii?Q?EpatU5v9dq95JYlVbRxMluxxq4K7IzWIloJGO+jR4UcVIc3QBOP4EOsM/yhJ?=
 =?us-ascii?Q?oHfpylDrhvxoKEX2cPIhupBeQ891enK1+POcdZLNsQJON0tRwzXMtKxGLs7X?=
 =?us-ascii?Q?to6vR8fCA2fD+VUKO0HV3h43DsmfsUIKmtlN7XSunCdmELrmsSFIMIJ4pQNF?=
 =?us-ascii?Q?plE89iPzx7Fxrxo94ogl0GYKyJZxfHFjdI5PuIUFjaE00J1iIpNhV+61XhUp?=
 =?us-ascii?Q?hGW/xevFSZM2zmy9uilXrr6LR84CM+YKRVDtkv1YVkv6uD9x7B06xL/RpkD/?=
 =?us-ascii?Q?fhi8Gtc8rEtunPvV3iMPHI93NKpF1jLcbfoZvd511+zfUszigfdzMHULET9d?=
 =?us-ascii?Q?QB1G32RupBHKQ+CWdUW95eFCrzYJUQKGsxp8z3HoK95FPrz62Euq38x/vWMj?=
 =?us-ascii?Q?2eIw+2qPdQA2IjfE0ktRL+l+fkyHE5Ua+V74s1/HpOFs87jviOgykO8E//sZ?=
 =?us-ascii?Q?dcWlnqaEjKjUYwnQwav4+pL8lJD+gsSdEGwU9ZF1aDKOciVyXXdHXfqEcYXK?=
 =?us-ascii?Q?8S2IjzZYxAdkL3OOv1lHGgsk215ynp+ZjXkd1k//UkfivshaewvLS6BTBwfC?=
 =?us-ascii?Q?lprgbZMBlI9Orp65nFpFRfsd1SdW4F2X4EkMkZXSR7IA0A+qBmJLmGoGDPL8?=
 =?us-ascii?Q?VYkZbFE4IQ08AWZEHqO5ECUryhJNQFmxJ8VTQKF32n9IVAC1LiogcudyJGNm?=
 =?us-ascii?Q?W688K+TKkxPqwKXqacEZnAXCFPbq6Bfbvq9XckaT3eJcKtXsbvoO/lQgOucp?=
 =?us-ascii?Q?PuC+sUfFcQ+DUukXkwTCD7c0eYoBS53aXQCRmxWRxpM87rwSbvxYB2hXCjiR?=
 =?us-ascii?Q?EanGm5meDlUdK7zkTzxq/uglOITQKzTM0/M7IRI5mHu2ncX3UuQO13tGWj9J?=
 =?us-ascii?Q?6QRD8kzmYw27Jbj0k9XNW0QZZuP1K4pm1wCHzM6lv+GzK0LAcBlOwuEni/Lk?=
 =?us-ascii?Q?TmV8Lob+BAf/MxBKuvGS2SDPiVXKQQfUBZWThzpJvmJWYMxLVPoa6rDnbLuH?=
 =?us-ascii?Q?dO36Ab5MKzWfHV8iUtLRHLaqGLxsuUd+KfS99cqrV74gu/lakJ0XQS7kI55I?=
 =?us-ascii?Q?HuqfDFBRDJLxC3FFw9LdUx9tKh6D50d1kOPx8o1soox0hJmf443DXCjCm7aU?=
 =?us-ascii?Q?iln3JRVDc02GbmLnaSspBSlWvG3KmxSuhQ2Vons+oln9T825xT8K1nt+4x3U?=
 =?us-ascii?Q?4ByfSoXqLJN1PBpm9N9ZWG2G5UXi+uPznkuF6FeiZji8FQ+qoywMbQTJ1jED?=
 =?us-ascii?Q?tPqGA+QIGO0MV8OKg3uU3XDKP9LImabZIDjCtO3mZmKhlRF3VZjKZKd15pXD?=
 =?us-ascii?Q?k9yBRtIiqC39rxc1agMDC7h/xbmxhEgR663budm5IFX3XMoj1tzp/spz78Ux?=
 =?us-ascii?Q?4XJsr9XamF0fcQ5aGuiXjg54hlfobyrl?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 09:23:18.8159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f48e57ba-0f9a-48c4-29ac-08dcaaf91711
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB6178

Changelog:
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


