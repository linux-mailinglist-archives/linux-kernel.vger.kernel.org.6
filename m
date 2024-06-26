Return-Path: <linux-kernel+bounces-230361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DDA917BC2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E5DAB236B5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F8516A921;
	Wed, 26 Jun 2024 09:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="T6oho/y4"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2053.outbound.protection.outlook.com [40.107.215.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C38316849C;
	Wed, 26 Jun 2024 09:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719392885; cv=fail; b=L9Unn25apV53j8MtMkUz9lBFYXdbFlQ9Bkoj9IU8BdYO9jEablrHvpfnGusyG+UwF5zWzVhmc9WnmpfEbOXjRQSbGB+OXEMd8h21llSxy+TORlWZ6LzJo2VwjRd4MqKTGacjQKMrh9Wg2hf3bWchwMt720C6jK0JZ3ZgugZSFuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719392885; c=relaxed/simple;
	bh=g3QlpPOuv2Eq68R1MCgAfCyqN9Jh7IId0/oexsFF0Kk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=d3xZkkmiqt47Axux96mznQj1c2mltO8EGRo4t/kibiQCuWlgxxy3pjUmbGx/5FBiaNgtdiEM2p3cObtheDangQFAX3N3zUtqosV0xjRb9YkRLukveqZtaIlU3fqpwqB/YG8swfLH4LFGh4dPNCVqMLSISr7V5NOkhCN92/pfiBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=T6oho/y4; arc=fail smtp.client-ip=40.107.215.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V//5mvLrls4MzAhnuE/s6GEawAoS3gEWM64FNR4VQhVBB658Gftq7rg4BIUBpSeY+XnvdGItsjUbhXk+OB4hOk7WtWGURkY+InvkJKlHXFMh/ean6sHPtgm78H/fzKkzmIqaIUEJIq+UITI9vfCUCZ5JLiRBEeZ64mOyOCHFmQ36xKesYaMhg2b+IXkiihoo4RNkCc5KJlRMYYa53vy2GmVcmDCiF8IziJA+cIwSFSLhAngllTyfMOFOs5vkwhdM6FBzlwmi261l2iJm6zKyAbDJYMVZ1XN329cKS3qthZXiZrwvvf6R+LKrrol8bf8UD+OHeIaZF0YTtbYalVnLGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31CYjOTVsj1JPdS59aXrPrSDTJGFqo4mbfw2xTuR3OQ=;
 b=hyiK/ionUwPTXbSODy9lNK/9yJyUEG1StUh9ghx8VMmibeEKWaFiqTSyw5q6TiV7wKlSpNlUwjHXch+a1uFsdN2cS9glwYtdOcxL0i69TzPx5LtYiUGdhy1ZGe4qpBIrqmk3ZsEwnCX4THfiz4H/slqRDRo6jgM5O/j2BaRGlOUExPR+Ur3fAvFN/Jw879VCrU3DOSEPN/zlUSxGPng0lhtEbb36lK5lNMmb1vvZdqNkaOPE8K+IFnzzNpCg5MBhHLKosPRM3REYrKIk5f484L04oMRSfc8BI9a0xnmooMyK8FvKXvvyq2zRue0vGDFuuTOsBSFS6nEY6E8fOFUhjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31CYjOTVsj1JPdS59aXrPrSDTJGFqo4mbfw2xTuR3OQ=;
 b=T6oho/y4UKw7zcZIxXNCDyj7NsI3XRfme7ZAvmZ4iiFczqeRFnH0Jc6+8iDeDTmybso73FaDL3uJxefvqKq8KQRGHy7UrhE0kIVmo/X+Sh8baePf/O8WhKWbNbXvpHAAM1FwfJoY4qqK4f6BPkwTR3g1CQd77TY17Hj8ir+xUWzxm53xT+Vw1n3U6CBZ2CCPRaqBagYkNGUZZj2WChWgrGjDZJD/o5HsxlSQYLbFxO6+IacDUA0o3ZOlOtuTWHJNJm6FAHK6cXDmoFU3PsYU4XT8pD3uEydUEqn8TqfR46o5VEHlTJ5BS59oG/34HfzzxNMYO1cGXmfdq3uNtiCApQ==
Received: from KL1PR02CA0001.apcprd02.prod.outlook.com (2603:1096:820:c::6) by
 TYZPR04MB7453.apcprd04.prod.outlook.com (2603:1096:405:42::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.20; Wed, 26 Jun 2024 09:07:59 +0000
Received: from HK2PEPF00006FB4.apcprd02.prod.outlook.com
 (2603:1096:820:c:cafe::2c) by KL1PR02CA0001.outlook.office365.com
 (2603:1096:820:c::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 09:07:58 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB4.mail.protection.outlook.com (10.167.8.10) with Microsoft SMTP
 Server id 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 09:07:58
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
Subject: [PATCH v9 00/26] Add i2c-mux and eeprom devices for Meta Yosemite 4
Date: Wed, 26 Jun 2024 17:07:16 +0800
Message-Id: <20240626090744.174351-1-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB4:EE_|TYZPR04MB7453:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d2f94421-34da-4a6c-67fb-08dc95bf7956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|1800799022|82310400024|36860700011|7416012|376012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wHnqjFToLiaN5KSGxAylKenHdSIUDqWxKQzzArIRsR36Sx44064YQvouZggg?=
 =?us-ascii?Q?u3wnR6C3GkQRpLBHVt1+wwRoo/ASTry4AiONVMHpzOYbmtCtJmZkRAoS1j1D?=
 =?us-ascii?Q?TbJo1anG6qZphbFRXPMFDWi600GZDSZPkVbPrjm8p++Dq1HpxyPto++caO1c?=
 =?us-ascii?Q?Uz9ub24KiGqWNKJR0WjWlDgGyYJnzSxGTcAUr/KS3kODvKzfwFdEBh9aPRFg?=
 =?us-ascii?Q?pKo7o0zdd8PUzijdg0Kouq2qWCfZJatTTNwmbHW4qWfIqNwMOuwd450Z1aSe?=
 =?us-ascii?Q?RyaSpep2wPlT/eEG4Ob8PvHmrMhOTyxDe6v1wvLAAD/lfzZEVS893PBC0rkI?=
 =?us-ascii?Q?BgKutwBLYXSeMCWNUjvdu2Uvxo/WdDVlLs9lfltikxrRP10ag8W1hv/pCsE7?=
 =?us-ascii?Q?9So2ELDLkOiUoLk48D9Extz7vBF5bTyPZ/2kb5BwaGo9tUE96s1PUW6soKQT?=
 =?us-ascii?Q?KeY+MV8D2KWYg8A6+PCcIiJsmcyhk2pEz5FrpdZoI5UmwNE/D5R+0Z9Keptm?=
 =?us-ascii?Q?jkuBEEWjOyzlQ43E66x+zzxtmLI4Q35jUeNeWBq4+Zogl8vtJ1edWzsGgirY?=
 =?us-ascii?Q?gFsZ0U0RL5m15MKG52FBQH+Z8nEnWjdszqO/Av1c2qlBboo5T/irMYGYEQ/k?=
 =?us-ascii?Q?VMcwCEVq5xomIapECewxP84l+Ju4JS3XhM4zPk6BuB3kjrKuwYENIG8dxp8t?=
 =?us-ascii?Q?FTZaUjtwEc8wFVegXc7Wo04giqkLXqSRIy31jjdQm85P1RoKfHExghaG10nO?=
 =?us-ascii?Q?tzY7TY+WA60YADBRGkwO/rdGkmo9+DSOOpdYqWtpDf6pmrPuaenrfRzJd58f?=
 =?us-ascii?Q?i7s9M9+mMPuQkkoKfNKtCcceKOk2cqrVvkjarmYPnQc74MMoAknNKvmlM/+Q?=
 =?us-ascii?Q?CAWDgOB4hid4N4+jIJ0JT2tEE7YFaDZ5Iog3zZyREvxvcDrDb3F0/z0JfinP?=
 =?us-ascii?Q?KerJi/q1kENAuWMR6c2OyguKl9M/9+TKiJR5Cz5Z3t+7LQaA4F08Py2F7xvC?=
 =?us-ascii?Q?wovu5IOPZvEXxRKzYrqjNUuhPlKtbrOpu6+lRFD7WtOckHX9RcqYY9rmbMxv?=
 =?us-ascii?Q?AKcIitfvv/wCcY5A4jU5XxFEqIxesZ1AzjyHRxGlyc9j6h/D/AN2s6r3WN7c?=
 =?us-ascii?Q?DfkV2vKFBaGYJLVCVqgTJnxyd51hkIssXX/y0JyQv+82322V1P6WYwvFswrO?=
 =?us-ascii?Q?roiSU0vUL9cUJzwjGHTYxhoTWRWtBsjyCTJu+lH+lI6EPygq3hLuB46sgOrw?=
 =?us-ascii?Q?tuGwED/GI+3CXtcV75P+UmJsUqoUbRlckGHEJacvSZFCPeJ2UJn/n8ZcLPTt?=
 =?us-ascii?Q?T+7Snzm8ou1k9pL6a57TWV4KoaxuZTR3TSbrnrZfJFMEHBn9XRmhqdQD5+9q?=
 =?us-ascii?Q?CngTL9Mw5CFghc0PsYUxoOMdSznAAiYMKZp9E8WIArojzq4few=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230038)(1800799022)(82310400024)(36860700011)(7416012)(376012);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 09:07:58.3797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2f94421-34da-4a6c-67fb-08dc95bf7956
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB4.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7453

Changelog:
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

Delphine CC Chiu (26):
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

 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 1410 +++++++++++++++--
 1 file changed, 1306 insertions(+), 104 deletions(-)

-- 
2.25.1


