Return-Path: <linux-kernel+bounces-321191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F599715AA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 001A61C227BC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D7D1B4C4D;
	Mon,  9 Sep 2024 10:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="XPHjx7bF"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2064.outbound.protection.outlook.com [40.107.255.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72C517622F;
	Mon,  9 Sep 2024 10:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725879271; cv=fail; b=OHgzdoYXwP2e13O0fE4adRSHQvYfuLotIMdi0Guh9LP5B3mQtuvvirE4pGSxsj+GaqQ2zrsH5NHMH0Ed/4MkqIIht66dQXtNkiv0PsYcSultONF/4OLGC81YZYV6c76LgeRWtzTZOLb3A0P2ZIDQpywql3gC81bIVAUPBcdgQ7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725879271; c=relaxed/simple;
	bh=89ohsqW193SRCwLEGsiX56lFOdrHaTiaGoc6GIkyF1M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WmyVrI9ShG+U3avOrqGfO/C4cZF84tuTnqcQnRXzuyXqTxJ6xu5Sy9owbUYOBLvkAd+wPa9kzR72KRJOB/hoIvo14eMqKKOS4fQb1fBI05bqz0E5Sz7+Z5+c0j5djEfb/ndz6az5qHjhEakZGibW9xiJ9ZkF2mv67O2P8ESUmck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=XPHjx7bF; arc=fail smtp.client-ip=40.107.255.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EiEcOp/JMZgA0ZNNDKyO6hsC27ZcfYe8XE1U4ipAbVQBc7mypBULthew1WSXQpUwRBbRDC/AfFo3fU+297Wzi/mnDbtmvNiqfm1PcnZD/XlSzpusYtmooNJ7lJdPKp789CNoVqsiekXOzA/EVgKs/5R+urz3rf2eotP5LSYTG81GgEB2NOPR67CJirHzM3pPPcrs3KFG2A3YJzVF+dnJ8UXPnGquL/s4eqpT1VVZS5o7pwPUSR5Je/PK+aMBbs+tmB+iSurS3CWPBqB/D1GDfeK+joGKaCtHwK25jjf7htHuZive9VpvRG4g/14/j+IbXY15u+hJ4VQW/cLkyxuj5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyxc9sKlmeDsPALMNl2AUUmxtSli6e+S+gdb4HFa3LU=;
 b=WZoRz112kJ1oKhKeLUTx2uZdurP3Kw1vQ11iu+hat0hg86ZFgsjrZQQ9lHbn2AOdRSKGx2nJVlY0AbyQK5uxvIcNkqejXIYAIK1Do+S/o6Dcz9xcS2DuWnsMTzG+XgKDmL1fKaEAW4h8CBIptM5QxuXBV3XBoy62JRpV8cICU+aUnUzYRknlz4qnVBx/6xcHW78l2WWI8X5mzK1+fZnsQdlRHbm8bAf54/KVV3xScMdkF8XhqK53MVDP2j9hNUlrvmAGw3s0N19R8NSkLHCu/6jHJvn7H+Zw1ZrlSYJi274WwlKJ1VNFfh7CKa5gptjRFQl36o2nFhiNh2x+fdUq6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyxc9sKlmeDsPALMNl2AUUmxtSli6e+S+gdb4HFa3LU=;
 b=XPHjx7bFDKesyrWWrwRm3ELslHM+g/IKtust7mX9aZxOnAcZRurJw1Fs4Y+n1T2Va68HuLUvY6QJ4OLoCYEiE8OSQMIkt9QcfAkktuhjIBkf8eVt9nYSJH8v7GGFp69J5ihq5PxgygQgpikE70jAAqkJYdzyZ0YpXC2hXYgylWchsvOMrnWyBzdO4054yaTQbmBtwXwYTKnbDCwpA5n/BJ4twqnlT77QUKc0r3febqX61cQYr1QC6rkKb5FXZSNCZORKwW2MmibeFsCAelUlAGw4R7iyDsU/NCJnDK8R8S35X1uttzzLWcHqODq5oDYvVtvia4nIUvVb+DMJsnFoaQ==
Received: from SG2PR06CA0220.apcprd06.prod.outlook.com (2603:1096:4:68::28) by
 TYSPR04MB7552.apcprd04.prod.outlook.com (2603:1096:405:38::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.23; Mon, 9 Sep 2024 10:54:22 +0000
Received: from HK2PEPF00006FB2.apcprd02.prod.outlook.com
 (2603:1096:4:68:cafe::71) by SG2PR06CA0220.outlook.office365.com
 (2603:1096:4:68::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Mon, 9 Sep 2024 10:54:22 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB2.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server id 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 10:54:21
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
Subject: [PATCH v18 0/3] Add i2c-mux and eeprom devices for Meta Yosemite4
Date: Mon,  9 Sep 2024 18:54:15 +0800
Message-Id: <20240909105420.441607-1-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB2:EE_|TYSPR04MB7552:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8677e6cb-c079-4f3b-c420-08dcd0bdc2bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b4u4SJJS+lJ8w4VMZ27gir5r8HtpRciqEptjJtQEVOWEez1xpXosmPPs5dzi?=
 =?us-ascii?Q?l3XMOFwagEmiVIGuKlm9e+zbmEGJrcrdlamx+w9ggKTgT2tR1ctYAk5hdyd9?=
 =?us-ascii?Q?x2ZIAHi7VoDe7ngcEhP7JkuTeiuoeDHhmtKZ2kTSrBh4BzS0iU+S4BSnTltG?=
 =?us-ascii?Q?U/VstLH6CIo+LTsYP3XCASBV1ciLMbSlZGZjsFqA/o/M1342d0WZxGrsRT9F?=
 =?us-ascii?Q?X/RZlH/ILalb/oKQPgQjxbmK0OjpJyzZHGT8fSJLRNXdd0rqzJFs2y9HFu6Y?=
 =?us-ascii?Q?v+NVI5q5GugVjbwbHRf6cLZnllrfUhWYoNrYzh0dPr2gZJT70M5pCXpMNhvz?=
 =?us-ascii?Q?piv9Afu+M3LRQEts18WoEsPVAtsOVRzF0/XlpbN6dxTUFnvR55v1E3WkTm00?=
 =?us-ascii?Q?GkZAB0JOvY4iN1iFs1A4t5c04/Xmm5B5w+L9mCHf/PRGSy+NVA/5hBbOCJ01?=
 =?us-ascii?Q?ROLRCuOqebLSq7IKtMhbzFlF4Sv6Ade0WyDmiSAcopNLph8xbADFX9474HOT?=
 =?us-ascii?Q?KXyHPIwUxGsOLRkPfXXm4BEkF/Wr722ZrDEJ0hN7K6XrYV9mMrlsut+RWocz?=
 =?us-ascii?Q?8EBlPoE4d1hkX0tpZ0N8xQ75q7veRGfTsZAmG5Qeif0xWcVmykdS0fnkCvkw?=
 =?us-ascii?Q?25YRpy3oHE0iq+7Yx76O0UmBk7U+fD57WQ00BQCRFJsqcURroL32Y6X1gH/n?=
 =?us-ascii?Q?laI2N4F877EArDWfQjjDRIHMMlM0M6fx+Q6kf8XrODmwK0c9OGtYdk73z0QW?=
 =?us-ascii?Q?0tF+Po2hFs/SoxtCzFaiuxQJ9pBA2HWn+tPd/KWaWyov9uqWr7HunZ4Ue6f7?=
 =?us-ascii?Q?7FYBAUQj6p3ytNzuCDezLdBl1Eu/Ha1u1uVaTbB4i8rI0vEj6XbpLTf9Io7A?=
 =?us-ascii?Q?aSQgX9vYQrqs+bLm9SOd3g3dY50hRx157lWMP+BzFhtj/w/zpfC721VatLkz?=
 =?us-ascii?Q?ZsjfY3GvkikvOglJ8oDgyFqDhxIaA7iQF/h2+UAtNeg4VhZXkPLkIuORdpH3?=
 =?us-ascii?Q?yKEvLhK+n8stAPJrz98mMVgBPIKsy1E74I/qGX7gcmqcqPBpKTKVmW/FR6DL?=
 =?us-ascii?Q?uuI4SEbI6taTrgKpmEpsI219cMTmiQ/NHVWfWXc3Ho7msagBRPLEB9v2J5wn?=
 =?us-ascii?Q?RMhYYeOsliPwDXVupoUnPQhX4InEe5s7kjd+eYwq8swMLYgoBo5yqcA9PPIw?=
 =?us-ascii?Q?XSPKfScDlCyVDOYR3lOcRSicYZttMN+aeFFFCOBmw0eq6s05LtBpUQxDYsao?=
 =?us-ascii?Q?b/Hx7LDw+CKU2fdITev6Xyi7RXhQ+ZHWSXpdZzEPZ8RaQmLNYmjX0qJGTnzI?=
 =?us-ascii?Q?Tdj/6s/8d0V4oT4X789F5yO6TsgL8I3+PnaaB8i4nRu1UnKJpjj4KRjBLGkR?=
 =?us-ascii?Q?99iwCitHvvQEqOgDS8jPeC5k7VW4j1FU80x9lIpBMYXUr1FwRb4kpxJkWReR?=
 =?us-ascii?Q?BhI8k2XTMc8SRohTMJt4leXEyb9wKAz5?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 10:54:21.2062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8677e6cb-c079-4f3b-c420-08dcd0bdc2bb
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7552

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Changelog:
  - v18
    - Fix warnings for reg_format reporting by dts checking tool.
  - v17
    - Add SoB for the patches.
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

 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 706 ++++++++++++++++--
 1 file changed, 660 insertions(+), 46 deletions(-)

-- 
2.25.1


