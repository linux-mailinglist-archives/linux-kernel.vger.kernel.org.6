Return-Path: <linux-kernel+bounces-187145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A978CCDB9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2026B281BEE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 08:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E81B13CABF;
	Thu, 23 May 2024 08:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="iu6vKAt7"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2040.outbound.protection.outlook.com [40.107.215.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A4D38FB0;
	Thu, 23 May 2024 08:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451436; cv=fail; b=g0VIHUBrhSvK+JXEW3TyxldLdtf/DRZGPlL8mfmD1E7TSEkzLtRg1QPKLdeo9YxBRD1Jo5c4s3RVtjMZRKY0CrkEEa4Z2gBUAdXA5arPd9zNim6y3Tclllg6+hSspVr1MkkZXPvRxhrO8YMK3zXPizvWBAmUxAGoJXnu1uYrY/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451436; c=relaxed/simple;
	bh=8Jo5wl7rUaEh4gGydjD8qg1kgHPJAUzPcw1QVxEehuI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GZ871qRbYD8M71pzA0m1P1RtJd5liyzaXlcHuT7QXEGd0dMjctp0PI7MIfQRxVcYgtC6SHtMdKPotysg8zadBnE3H7ffmUVLNvz2DlxGY7mTmPM/5NPfF/zgAXZCPq72rsP3A+RRGhyWa3t1HAUOokwidrWB7gTuBzG1Bbj8dgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=iu6vKAt7; arc=fail smtp.client-ip=40.107.215.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTEoCZgP7hMoO7WQ/dSIHvfrtCpW61qqDWC1/OwUBHghftR3nTkQTKOieMpsc0SAOCllCA+HVkLf3r58DDA4MaesiZvEDw6ebeTHLYng18kTw0+j0TSG46qtJtVY+69vPgXIM+pin6lzPo6T4sryiWM0kPzgin2FiCl9s6beYwCxa3wmmbqyObW5KzekMR3aCLaKN/xEBX5QouIxmb659qUbkErYbgfepTHOaHN69yAlSmtb2FzIpJJAm5+JO42H0vt1AycTrGa7j8I4nlC0PJd2619xW7bzp8MMM85xBRvOc2FNq9d/MQ0DJkneKjLnkCNwneyd2A0lJ3UWaYiqaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nRkSH9ZSQPgqn7I08CoWfE+SUL19JFZWfDZFMyYkDg=;
 b=Icr85bbayT08rYfGZx+Pgayz54IzcKPqr54UadTM6NXq2vOje5DF+Udegci8Mipx15HIg9Gx/HUYN5pYix7sS1Xvojz8N2up/CjLJSzEJNM3gM7OzmH9Fue5L8C7ao5rMd6EOowlkTilYVNh4GBtskwY+zRMAvw3N5Mrm3zdp7JXZd7e8UTYO/khEwE2WD9OdCMk+ZYZEWx3zlKuCFd0SLbRBNG/lefZ8hKFXOXN7IGeSYI3tSpqlVGFnPuZOBLjlNbNW7FMxCfYHmf/ZC6EFab7af8VwvuXy9GeS9CueI89MN88Y/MZiFa7L+wxrRdLgFo0O/2FHl80hwzpx1VQsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nRkSH9ZSQPgqn7I08CoWfE+SUL19JFZWfDZFMyYkDg=;
 b=iu6vKAt7bxxJ6oSxkrgAWxjlHl33s86bbCt30R/dkmPV+Y3O3k62tnNkqpPY6PBNqtH5nEY0P01KsMYk4Rog/apm7hvtc3Z9daLYhbsQHOOx9nHhShYOt3cC9LXhEjDhdq0oM25/srQIV29GIt+Ad2vXWWJC112fN4RODiRLfulA8MT8vx7MyCc+vol58A1D05qEjRxMgQ91JJqWf6UyXQsy9C2MgkzkY4Gaz6ye7EFuADC9W3BgY9FwKIJpQnxkK4k3cjHqNw5s2lIw65LIn6szGPpJKmxTLC2tbA7ginmH1WiQu0xzgV0+IXrpDcXsNARvNvjwL6CGquPJIB0bxQ==
Received: from SG2PR04CA0168.apcprd04.prod.outlook.com (2603:1096:4::30) by
 PUZPR04MB6181.apcprd04.prod.outlook.com (2603:1096:301:dd::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.35; Thu, 23 May 2024 08:03:48 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:0:cafe::19) by SG2PR04CA0168.outlook.office365.com
 (2603:1096:4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Thu, 23 May 2024 08:03:48 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server id 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024
 08:03:47 +0000
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
Date: Thu, 23 May 2024 16:03:05 +0800
Message-Id: <20240523080330.1860074-1-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|PUZPR04MB6181:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d288abe3-7923-40be-2446-08dc7afee028
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|7416005|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nq49eGKgg9RQ+aBM2LBQoMy0YCVoZmMno/PrGFlkw4WgT0/C6oLO9enxNh6G?=
 =?us-ascii?Q?7exJn4BU/fu/fIh0UMzlT5TmDKxaXAkm2Gs/Z7azqzrkEDUbmFKuEEaHhNH8?=
 =?us-ascii?Q?QkMTG0AQyKiRLAVtl/bvV+gaL3r7nr5VZuKi9mgCp+mEzxyTfRYJrKeVEVnJ?=
 =?us-ascii?Q?VVSX7jkROvexGHArOx4G0T4l+nhig1wwfkjIqvc9vOUcNDAOIP0UQd4sBTTk?=
 =?us-ascii?Q?ZeFARI5dvtIwXh0bEw1R3Tc14urGNCOz+6L6nbjE4l4kFAHR3FoE8uMv8BP6?=
 =?us-ascii?Q?XcXrAW7Z6XJ8pBb+L6TyWoKcVwHYEvzWno9FZXvZZ1h7MsjOXdQ9VqUJD2uc?=
 =?us-ascii?Q?rJ1k5qyiR6WysE3tNXFUqLMFzIt8acNj+vm7u92q0bSA0UZpq07x39lIFZEE?=
 =?us-ascii?Q?CvEzrUe8bDVKi6XIELDzcedgxK4/Pmpr5ebH7Vw0lGtplvk3znOdzjyjOV12?=
 =?us-ascii?Q?LEPYIA+AvKuHbWuHcQMdRQ8LqjmediyPWwbN2f8Isvb36kwnEug7wV6bEEvB?=
 =?us-ascii?Q?aDtlpB6ZwUWaHkTJltAK9s815vzCD7iI8L0XMOOIX5/5iMMa7ditf8p1ZbuY?=
 =?us-ascii?Q?YArnxxPxLuXk9c8k9WY1na5hUATBkGWEeYDlivsTXAWfOnkFbO8xS2zJVoaJ?=
 =?us-ascii?Q?YCPC9ql0Ca5ZJgeIoCc7qhkw4VdmlZAu4IPSw/HmbwLku0EwHf81reqyB+6H?=
 =?us-ascii?Q?b0kh2YWiSo6pnQLZJM0znWWk0FqT9R2UIqoavV/7a4GEeZfQKonj3LnGl8px?=
 =?us-ascii?Q?FJ8IOYuS3/IBk6dVDSiihA8k8vcylF6sIz4Wj7pghANmwrdTyEuEmaVe2cQ5?=
 =?us-ascii?Q?7njmYVH7rdRq2oBiCGGIa/r857KYmiTkY4P+pPe3LK+gXbjBBuNrxi781Xzi?=
 =?us-ascii?Q?NnF/A9taBrBeZjjXQU1YBVOMfAYwGTCqZCChregfmSpRwSi06X5GBejfZCR9?=
 =?us-ascii?Q?zPqII3RBiWIOPUkcVxzwWGLAdhMMAAIBy6FzQjY9DJE9DEXyWZ2vz38InuNl?=
 =?us-ascii?Q?CgYbdPSU6MZQZBqgMxlI6eS8bXWxVNdYSXGorQbq8auYii0KkkcN3ICKM0Vf?=
 =?us-ascii?Q?o62DlbPfWlKFNrwcLd8ry00x8pVbeEYaEzCFICVNk7MsWBmU9dnflxTv1ybb?=
 =?us-ascii?Q?ZOhiwGRix4eb1PRc6Q+Oz3f0Yzr0HE5V6ner9Y1G/iF0KXU9/Jg5rtRhgCYO?=
 =?us-ascii?Q?9XFiRfUPGHnX/HgqDK3XGN//muDNiBipUqUc/DMB90Bh8AjsPSnFLWLETVaN?=
 =?us-ascii?Q?6H7qeXPtn2cKAa0CYjuLmh0ghC6wmNcjT+G2oIQftfO8FUJ02dzHvgushfjQ?=
 =?us-ascii?Q?vRbuS93Lq7AuOzq/3cKFqyBSSyo3auGyteszINO8SStOkP+sdIekzbSYzRLi?=
 =?us-ascii?Q?qYoSUXGX73TsEu4AFKy6UpT80RgP?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(376005)(36860700004)(7416005)(82310400017)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 08:03:47.3589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d288abe3-7923-40be-2446-08dc7afee028
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB6181

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


