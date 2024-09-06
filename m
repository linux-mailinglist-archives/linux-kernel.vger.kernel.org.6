Return-Path: <linux-kernel+bounces-318514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E0396EF0B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C49621C21D78
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3CC1C7B8B;
	Fri,  6 Sep 2024 09:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="038rEfWG"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2073.outbound.protection.outlook.com [40.107.215.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F71248CFC;
	Fri,  6 Sep 2024 09:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725614690; cv=fail; b=XJToGBcWNekCXO6o1fKujFMvlcL8sqcQfrgxWvcmeuVNdth4n10x4LPPLBcji7d2RsmqDskMz0XnXH/UHhTTemgZ15NrPLVTuyowSPgspzjZ9eJDNMWe5EqmLpyBnR2UeBsshad+Ye3tjlewOzFHxxMoS6SKeTdEwRJ5sEffefw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725614690; c=relaxed/simple;
	bh=dPQeFs93Q+eSYrhCW8+3iho7PCagjXGT+uamF3p38jk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Odq+DmdjIQXf97hu0ViqoFy8kAMJTva/Pq6rEhHIPisXEgjVfppzb/g2DpTcGYSOR7rGRmZO0XnczmGOjRnwNQPVmCj5bB2TFirpuD03+rf/kogamAty8Fd5fqONgSnnHuvSNjwVxHf4S6+1mf2KJ8pSSx3IkyGcnXAM6/h05no=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=038rEfWG; arc=fail smtp.client-ip=40.107.215.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iIm1QnBLvprcm6H5UQK9AktYsT6noRgSERmdWlPEnR9tN4vYfAkdonbGEiGR4Kd1WVHbmCEZq15GuFQwDRiDhwx6r1lmnQzSwPMVM6JSXcXNOqXu/QWrvb5aI4yZctPkSK4iypncG1c3g+wvNiAaECnwqJ9+1DNdKOhECckG6yjnTI6ZYunAuMrTpbVpeX329V0eI0Nfhz9kcATsmYJncZ891mm80EJZdGB93PTHHqiGV4koGfuwSjN0cB/4ngX8uCRLgMJl5QHWZEFq1aIxCUno02e0W7FAIiQqRDYdogeivgszzLCAC+w1Jj0K9up13u3sVOMFwL9rjiMhoBvkdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hI7+xEttF9Yn1v7vJLp69QaRV+Te1Nj2rUrMt/ApZU=;
 b=kzC4Ih2gTkLua6Wduy3QiRK4Cpj6hNMl9x3OCXiKVgZYnvOzLc7rdhDGbtoe3/QMDkSZNOAlMMOxWiKDm4xcyqggsBmfR8OgJ1IRARwUtpwOfsKbVXfdFzswX9PK8WtBuwiL/zzSm82P2zWM6bz5M/e3zS4DmS/rZ52gonbmBRRW8VTz2LutiFo6EH5yPP2Nwka9qpPUgUIJceQ5iqbVYsV3DHANfi1Ri52bXNzA9OVsdUPG6m3JHW5zOg+wSss+urF2wEyOROekazrEbWkWOK7vg66bCNh+kUUwF1gyA7JD++/AdivJRo3CQCdsNKE3D9XuOsU5FWlImIreQ6KhdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hI7+xEttF9Yn1v7vJLp69QaRV+Te1Nj2rUrMt/ApZU=;
 b=038rEfWG8qf4twZaP8nZIJKVC//Ty8P7SvP0zj4OL/HknSNs0s/q/jHarlKCK7gu4r445khgdqLB8v6Ho0L+o/VLa+qDthpSB4fWqNCUINRlNnVKQQkv3tGtqCD7kJH8ghsXhJpIUHZhjb9eagXNCwySYLvtkvd4In4XI8pxtzhu2mq5+kHXQ0cBu4Kx6t93aO1Cp69Z5XacBjlsWjaUcmYmSQmkvHuxjmXxnYGVBQbFFVd0txbjwnDOpNHULCL5u/aw7G0HLP79CNQC0PxLCoDxUs0FeKTylQilEVGZ82W/99jijEJ1UmHbhA1fecNTEJLL3iNRjjgSerE1jhLdvA==
Received: from SI1PR02CA0028.apcprd02.prod.outlook.com (2603:1096:4:1f4::6) by
 TYZPR04MB7456.apcprd04.prod.outlook.com (2603:1096:405:3c::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.28; Fri, 6 Sep 2024 09:24:41 +0000
Received: from SG2PEPF000B66C9.apcprd03.prod.outlook.com
 (2603:1096:4:1f4:cafe::46) by SI1PR02CA0028.outlook.office365.com
 (2603:1096:4:1f4::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17 via Frontend
 Transport; Fri, 6 Sep 2024 09:24:40 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66C9.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server id 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 09:24:39
 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v16 0/3] Add i2c-mux and eeprom devices for Meta Yosemite4
Date: Fri,  6 Sep 2024 17:24:34 +0800
Message-Id: <20240906092438.1047225-1-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66C9:EE_|TYZPR04MB7456:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 712c8d26-cb06-47cb-51ae-08dcce55bc47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E9d+UFUxyWNGQcUUfZXNCmk9izp7XROozvZK5RKnCgZtLO+f6pJx6ipIuS9X?=
 =?us-ascii?Q?MprqQT8ANkmQy0LYmI0+hqDafcJkPynZIAw+TvTB1MTu/pkx36113TFuS0oI?=
 =?us-ascii?Q?F0lYu3uUkg4uiISxqK5xh0An5irI1M6woH1wztEbF2o31H7bLZEFQWjskxJ8?=
 =?us-ascii?Q?AwtLs5K2OA6pZQN9C2oBDAJ64z3rFHFXrFnxIgNUKMuWUv3Ii7COLPqH2es5?=
 =?us-ascii?Q?L+143G1z1jYbCA/21E4Ns8KqE7Y+mDaLs045keU64Vp7sF6d5wOEn2K53X5u?=
 =?us-ascii?Q?4xwDy0eGbdjcvDt6Ps9GNNE2pVSZjoChZIDOdyEyXkIIH9hpQJ89j9hUohkF?=
 =?us-ascii?Q?k1fhGXCDCsls5BUs6JwKJsZiNNsrxhqy8gD5u/qfW0hAvNrlyTxi18YLlMjX?=
 =?us-ascii?Q?ayAuymV9PL8CsECdUvm5bggnb+XNp0yOO8pTD1GCZw180qT8qVq780KBENVr?=
 =?us-ascii?Q?AmVJ2SUl5hHAmbAvVp8+TXLbzT8XjC6tSVs64q00YA+8hwEmUTLznrsGLDnI?=
 =?us-ascii?Q?Ux+44c4Jc9PeLecuZYqrpMxHBnYe8cXHq2r9cHdYHX6Kt9Z5+IAO6dyNS0gc?=
 =?us-ascii?Q?paHe7xTZtry8HTl/grhmNoWGlIMPfS02XnxYCRDpdVmPB0h8OcngBzHB6o/X?=
 =?us-ascii?Q?YvTvNXdT2oy+Yz/tawtKud1d74kegcDL1aJLMvtuIxxT0JR9yhIAO4yr4Ryq?=
 =?us-ascii?Q?CwUEkJpbjeRO6F9eRowMNA+SC49gGFFmgabadfES7K/E1TYJn67saDqvCOXg?=
 =?us-ascii?Q?88+LgxaAWMOP3+/hlNSwOgDZJ+QrqU05lZvqsWT1HU5ejHoY9hXBZaVPFYBH?=
 =?us-ascii?Q?zsG/5hRmO5gA5bzkR0uhGqu0oLRFlkaEtlevLenOGa2ikg5Mz/LXyDXKECS/?=
 =?us-ascii?Q?AUs0roPDG/AlAFIGKplddcLQoXfSdy8eOYNWZYdc/QA1Aj5U68abAcx+VF5/?=
 =?us-ascii?Q?+KuJEbv4XiGMxxGBh+g85xV5X6Ubk5wT0X6plyeQpd8fmDhsbh08tH3+7Nao?=
 =?us-ascii?Q?wiAd03Mrt+5hO/s565He6jpsvN4s6KO8j0pNzIe/OJWuoZXqnVGOSfSF4XUQ?=
 =?us-ascii?Q?d2tEU6Q+URAuXi4PYkhB4r8Yok+YUp4L4sUgQVqnvS6t9/fvYZNgcc2YPtrc?=
 =?us-ascii?Q?r1qRUhPMFqZcolHJCrKiHDCi7NoOtaU7HvW4G+1rHngSuIImAnahOyWkzI3B?=
 =?us-ascii?Q?Fa+awwR7/V6Y6mhZUz/+0z6SaFDOVp704CWX7PtHsXTscCh19uYhY/6pVx5q?=
 =?us-ascii?Q?v3yqbOqxSOKPimoKi2XKOcIiTUdgli2Nd2edFEdLB5f5sbTRzgavB5Q1X4Wt?=
 =?us-ascii?Q?aGFHM0vNWMyoEzAG2jAyg+xseVELNj3ik8PUZeoxWTB4hUNpHuYtuu0UY2he?=
 =?us-ascii?Q?xfROiNxSNnfv6Vk72A10qZVF+7p+Zb9olJWfLQlnRwDlApO5zwlDLKm8rfnZ?=
 =?us-ascii?Q?e0BpVfmxnHEOu/CwvwbrabwEs+ioGVbq?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 09:24:39.9851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 712c8d26-cb06-47cb-51ae-08dcce55bc47
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66C9.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7456

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Changelog:
  - v16
    - Reorganized the patches.
    - Add i2c-mux and resolve the dt-validate errors.
    - Revise Yosemite 4 devicetree for devices behind i2c-mux.
    - Add mctp config and sensors for NIC after i2c-mux on bus 15.
    - Add fan led config for BMC to control according the status of fan.
  - v15
    - Add ISL28022 support
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

Ricky CX Wu (3):
  ARM: dts: aspeed: yosemite4: Revise i2c-mux devices
  ARM: dts: aspeed: yosemite4: add mctp config and sensors for NIC
  ARM: dts: aspeed: yosemite4: add fan led config

 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 650 ++++++++++++++++--
 1 file changed, 609 insertions(+), 41 deletions(-)

-- 
2.25.1


