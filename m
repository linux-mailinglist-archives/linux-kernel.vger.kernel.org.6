Return-Path: <linux-kernel+bounces-332490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D94797BA65
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 11:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8889FB26E42
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 09:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C086417B425;
	Wed, 18 Sep 2024 09:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="gOeOXZ7A"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2044.outbound.protection.outlook.com [40.107.255.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F315D176AD4;
	Wed, 18 Sep 2024 09:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726653291; cv=fail; b=VOEYYa/O1CmbxtPhrqLth1NnrBiTWuoeQaE4UAuPVBeVOh9RLs7Ve48cCWA1GRbdILEHfzvgSPRBvTepV53T7CG/kYShqMrlPQnkDUdwlBDhy4Juxe2M3cpdXkcNmf+LcFx988HMvmEn7THU2kYMI+xreAAo1S1L0JdBSD/cgwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726653291; c=relaxed/simple;
	bh=wtd7Mofk8UuO3a4JKhjAok96UgvoGiYLtUtGo0lGJuA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Aucm6DxLUmoyTpqw+i7TcltmV9pz8Lh/9Exk7laJBfwgadJLfjgtu0I9p9t1alTgU1QXx0XHxA42C1jZmyvNqP8VFrqDznEsRefQFV88rz1iI//b4/x0YppbapL96R23z96sWpLn+XlCBuU4Abdh31yYY1tzULj1N4CImz8o3Xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=gOeOXZ7A; arc=fail smtp.client-ip=40.107.255.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfvt0J1SRxdffkaRx3cS2dXaDbZTRVNWwPsfVf8ttk/W39s5pG3x70vvyn68PR1EfPvKhTe0hH0CLLWik83iGLLVF1H11vPw8i3iDbvwPvuDTEi+LGhTHMhAMG55B2S+IyiHEf2BEhMA3QIInqGqJcAbJXRKtWmOnIVwWr9asW3cTU90Y2ke2zTCOoveTHJqznff3qRQtuL/a0+3HfyI1Yre23TUTElsFXrio6i8Ya7h0pWGaN1wSwnTTLSQLzYdBaR8WR/wOpRlvOej6a4eoQ/nazrIONex0fczQUHmNBRFW7+sUD0wGHVsIz7iH9cqvqJb6pQeZ8vzXThGYV4KFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7m0wnkY79E+rq1Xji4rog/110+/dvCad1+WnaLGP72k=;
 b=SXznKQ07FzhlqCYKYUb42oRPHkhga1VIFQvSLoCiiTEMEGtSfv8hRaYwegxGJ1VDq5jXOrlWzklylkzDCCsxVaAD4oqzrigw+LaQ0E5RyGqHN04jg4ywYaTSu1q1SnxUFNVfDtN+4ncnVe8C+wmlz76NgT6Y9OvGuG3e8hVcskw+JezNVqotQHUuhlde1kFMCi+EmvLxmjCWpDjIwoF/hYsJQif6KcQOjjlc1zMwJgBdrA5c/dIbiGEIv9Z5dLTLjuLtJlb7OZAE8B4FxXgr3AdVpznGpBQBSV5fquKaH1lqHnlnmrduyK78U5djIxNs9JLDRxLWQ494UCbciCiQhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7m0wnkY79E+rq1Xji4rog/110+/dvCad1+WnaLGP72k=;
 b=gOeOXZ7ANfNZblR+R6re/g+oHzziYZfqN9pJ1gRY50kOUXxc3842EFjcI+oC6+6TqV/7qol7PFrUnSJ8SlK0r89EdfVO3fLJnCbtAVoP6IICnxttWsA/AXawSPPWVyt8YOHPkdW0royaKDW0FT8b9zKcVnDbKU8+EvGlQWWjkRVSx0ahRDC+9hmHhlA1KDUUTig8xjrd8ee/ipn9KAO9KC8NW8w1Sjh55zrwipYIAxyZMiPeKUEvFtJXAHlf3NBjOLqpSbLHO+za8oCHj/ThMXL/MABzBIX5o1BT0XVYhwk7SGSqWJqPYogzikXsFr7TbZwru9Z46FqhkrCNICKo9g==
Received: from SG2PR01CA0130.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::34) by TYZPR04MB7280.apcprd04.prod.outlook.com
 (2603:1096:400:44f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Wed, 18 Sep
 2024 09:54:43 +0000
Received: from SG1PEPF000082E4.apcprd02.prod.outlook.com
 (2603:1096:4:40:cafe::42) by SG2PR01CA0130.outlook.office365.com
 (2603:1096:4:40::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.25 via Frontend
 Transport; Wed, 18 Sep 2024 09:54:42 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E4.mail.protection.outlook.com (10.167.240.7) with Microsoft
 SMTP Server id 15.20.7918.13 via Frontend Transport; Wed, 18 Sep 2024
 09:54:41 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz
Cc: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Guenter Roeck <linux@roeck-us.net>,
	Noah Wang <noahwang.wang@outlook.com>,
	Peter Yin <peteryin.openbmc@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org
Subject: [PATCH v2 0/3] yosemite4: Add power module and ADC on Medusa Board
Date: Wed, 18 Sep 2024 17:54:33 +0800
Message-Id: <20240918095438.1345886-1-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E4:EE_|TYZPR04MB7280:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8cbc5783-0b12-4689-9890-08dcd7c7eb5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|32650700017|82310400026|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tP035RvE8f4zUI3U83Iom2TjQ+Aqnr4e9b6ZdxwAeggUkTaFbIhobEUOh7WV?=
 =?us-ascii?Q?hdIudR/EXh9enEImYaKYVDVMsMImqinto4LHdGQ1ZM/QU8i7WThv1o0WIOmj?=
 =?us-ascii?Q?aUgwm3lp2wNCTi8aGG9rwupjFif3vcW+2I7FpicjSeRAsM4zp90zVRyjkB7a?=
 =?us-ascii?Q?oJX3VSwV5WLfaCu7Pclpbx80RpkWhmm1kE842BVR8CAlIwtQEkPgssF9yb0h?=
 =?us-ascii?Q?PwoWi8jiFaq9rq2WL4aERts62ioGJ5so8V2LzGxGMZJHS+F1CZTvH2RdQPG6?=
 =?us-ascii?Q?cA6PyDhlSB+c85vcQvNDRpozPV/T9r0jxIdZx1hZ8IsR971EsC+64GbZib5P?=
 =?us-ascii?Q?s+2FauoY4+bKd4J8TBLjqi2u7g7+AaVDkLr8H5QfkSxt6eAT+jwbVRxvsP1d?=
 =?us-ascii?Q?ZPqju5DS7bRad1tIDPqu7lGOO17F0v/HpjROhqbK0OxIFsDrFvRngecabKjs?=
 =?us-ascii?Q?Cixr+P4Djj0JBARx3nGl6tNaiS04BkVPoJo2qYCerT7b9tYVFZ90w31B9Lby?=
 =?us-ascii?Q?5zUKehi/lKajKj0Ws+pLPN2L1dCDD0Jh97PhExsBNbmCMesoLLnE7ODE+Ktt?=
 =?us-ascii?Q?jkVSclTkGzDU3kJPHUlXy+43BOhGIEDqr286T8LBhs95QSm2L/XXUQr/CmDE?=
 =?us-ascii?Q?jykM5kENWlW1xmal8OOE4EnXCSjILGzb9Qly2AwQnlKyhO5BMlHR8yYfQC1X?=
 =?us-ascii?Q?xHlU86gPYfNHE+qplZE1um/DG3hmC4PGQWPwPBvpkD84RGVhiLZ/N072i6bs?=
 =?us-ascii?Q?aW+GECTYRRTc7qvwOWInrpHim+w7svX2agTqkn1uPjs4WXklbQnGf3WlU7+H?=
 =?us-ascii?Q?ge9K4xF9Dk/oEtPb8Kgc/5RBWMzZduVSk4u3C76i5OAoJwSjMmPQMvLAnX24?=
 =?us-ascii?Q?t6GfC4jmD2i2ZCDMf5JiKGWYQrmbwlN2Q07TqIid2uNpKxeHSvAF5tRuWJIb?=
 =?us-ascii?Q?81PG6xWhGQDDDn9u6jsmvsan5BTipAkgmydL6WNmOchXEp5Eq+xcRn6eBM/0?=
 =?us-ascii?Q?ouY4Cd0gDvNcVZw7aoVxV8e+wxlJ1bLtTZKywRvV0AlJCfYIkX874N5QMnW6?=
 =?us-ascii?Q?WyiUmbHb5KRC0vsHAMN0lvFQT1OBqxqP85jhzKIGVpTMxgR5xl0Pqj7YmGCp?=
 =?us-ascii?Q?5U+ys3C1mKwvz/OFheMaWLKbH/9VK6srx1Rt94B4iA/8QBzlOfho2AwvXw6B?=
 =?us-ascii?Q?yv221tFFqtYyEObG/FdX/uslM0DsnELQ2WnXzVfiqxPgPtPyWxTcx7dkdPv9?=
 =?us-ascii?Q?cgUeG1tmuOuf1v3Xr/KDcfEin6Gmo97sx4lGRrBq5Tn6jiy4/4QIzl+kLO5O?=
 =?us-ascii?Q?JcSHE22auonXl7TK7w8LzycfEg4JnUXawNRTpbcEjzPQEs/4EH2b6rIGj7CP?=
 =?us-ascii?Q?XVIqLsgTlmY9fiZzPDUk2yxpSE4ei63fVsNTXVEWljaePIOGsH2rzcQRWKdo?=
 =?us-ascii?Q?68ew+Ts9Bg+3atjymvc/n56WyZSNcVr4?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(376014)(36860700013)(32650700017)(82310400026)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 09:54:41.7167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cbc5783-0b12-4689-9890-08dcd7c7eb5d
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E4.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7280

Changelog:
  - v2
    - Add pmbus compatible string in trivial-devices.
	- Add mp5023 compatible string in trivial-devices.
  - v1
    - Add power module and ADC on Medusa Board.

Ricky CX Wu (3):
  dt-bindings: trivial-devices: support pmbus compatible string
  dt-bindings: trivial-devices: support MPS MP5023
  ARM: dts: aspeed: yosemite4: Add power module and ADC on Medusa Board

 .../devicetree/bindings/trivial-devices.yaml  |  4 ++
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 45 ++++++++++++++++++-
 2 files changed, 47 insertions(+), 2 deletions(-)

-- 
2.25.1


