Return-Path: <linux-kernel+bounces-295258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF32095991B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 186171C216A1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF211FB2A4;
	Wed, 21 Aug 2024 09:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="vcRqDBBT"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2079.outbound.protection.outlook.com [40.107.215.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4091FCAB7;
	Wed, 21 Aug 2024 09:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724233357; cv=fail; b=ikGKKsgke9MV9AsDmpgzLdcflYPVDGQfIcn1JhyWfCLn1RJE5ThNPn4U+NXQhNxwY1U8luozYkdyXtO3WcdPFUB4UMpRmjXpo5OgxCjS391A0dmFuo+ifZkaMbXimM9C6XSz0CKnVQMVlO8UC6b9spCNBgjnW1jsXfEvL5Q8X4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724233357; c=relaxed/simple;
	bh=hu56h2LWgd/1CIncJ83I1yJVkrtmgD1MtU5pgSkXZW4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YO9rT8n+zjf2dklH4FCIuwI4AJvu+ciR3sjITD8/YaR6Ch+kSI3bL7t8mM/Xo8nvBqLvnWVlaEZOBHV+RNbGd7MG0u1E5tEIbX45VrzBlz0sFAod1X5P/gLhLGwb41dkYUT4/TDDpPsMm37BNo/u+MrG3CID/Ov19GNmYUH8/c8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=vcRqDBBT; arc=fail smtp.client-ip=40.107.215.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XYhdBgMYOFAr5DD0GQ8AP5bznlL1B/Xq9E/1gf9J6b0fb8Ug/uMBZRtQZ+Mwihc+IirYsthWzKcO5AFKa4cjoiqIagify7iU7fxUIwwd7eXmJEHJoZzBJSG01E0tlqUALXRate7PyjXlDEfjV8JVH7b1QP+mmlyTnJfkjBHlfDnLNa9JgCr1D8Y4ZVPq1+wXGlTBZRFtMmSEWOT5PYfgTVn/kIiJ3PlAyyAY3C+FbM//z2FSte9gZDhQvWriJjhhfh2nY6ainlt3V6vJ+XU/yhGdw+9HRPgM9SDFe6/T6GCMXBpbhTdo1CP2dkiDBsTU+pal59xpSCHTOPbS45HvEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lo2LnZejiHLnr3GYBrZTsuUBWpB3Ws7w5C5IaBMRr/o=;
 b=Uj+ZGdQIxBKlWp59eTEEGMwvzut5F4ZTHf70b1GFOXGYuT0ZtYMtRXwpccbCXPE3TJ/xFVFFDYhUhsXQuo67UWUV+DSoqZ9tvOkNsdl/mYOxtVxwVURD5eRlqq4yf7IkznTs8rop9F9DYJbT6P+Hrtl82o8k8IrA7O42nlI0M3gkCfotBjivHe2uaGYPGoC1h4NKWLvpmX86I1DOH016fEL6CMw/fCHdh/vlEDr5MrQ4WONMlcAOXDoTrYvaHl/8hLT8a7kr+XxQhKumzMQ86CU0Ba/LRhjhj8usNUZo5NxRXVPRo0eedTAdik6bA1TyX4C86ailR/FkWo2IK48oQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lo2LnZejiHLnr3GYBrZTsuUBWpB3Ws7w5C5IaBMRr/o=;
 b=vcRqDBBTTbdQqmqEyHor43iQPJp2cjV0ZvbDCalcgRdZpFHXV0saDZxb1FZ48duweMp31tm7FopX8+V3goYPkUdcAI5W160bepvEZwcoIKCYWpNIPcMd/VSv+yAOuK8rKxr/DXBGYKjRxpX0w+HflFbW7U+4j/A9cvn7PHU23omHXPSh1KrRbGuEGroN/p3zcsHsuhOC1M0OP0Hsl8HuSZ9vCFPFtTTZJ/zt1bcWmLgMoIacoyxsMn1tge0M0BL8iiBNc9++f4q4xmxdigmX7eXnJwoPvMfv61FvWgakA8DesLDnZ+vNg1QPZCT1SCpyOWHZ5NIqSoSrJI8kZbkppQ==
Received: from SI2PR02CA0031.apcprd02.prod.outlook.com (2603:1096:4:195::16)
 by SEYPR04MB7797.apcprd04.prod.outlook.com (2603:1096:101:20c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.22; Wed, 21 Aug
 2024 09:42:25 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:195:cafe::e7) by SI2PR02CA0031.outlook.office365.com
 (2603:1096:4:195::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18 via Frontend
 Transport; Wed, 21 Aug 2024 09:42:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server id 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024
 09:42:24 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v13 14/29] ARM: dts: aspeed: yosemite4: Revise ina233 config for yosemite4 schematic change
Date: Wed, 21 Aug 2024 17:40:25 +0800
Message-Id: <20240821094043.4126132-15-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240821094043.4126132-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240821094043.4126132-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|SEYPR04MB7797:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7f231828-1733-40be-f3c0-08dcc1c5900b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7PjzdNKYOUJfGQkrwXU3qlZmtrTFu9HGWfdQXCB2Qbi7uVutnuKYDlnmowG+?=
 =?us-ascii?Q?aLYY4V8PRy38ycDdVGyGwi/8NLuaQlalFsBsUoFhRwHIOQS7tcdXSMBc9w+H?=
 =?us-ascii?Q?KG9jilv9U2yhASv7CAttjmfNkc2VboFD4p9NLug1EJ6u05b8KQpEqSmJP/1J?=
 =?us-ascii?Q?n/CYUUgsUlAK8xtA0AAUkfl3VmtStt5JXDm8AA0g7JUpo0XX3TJaC026GKnW?=
 =?us-ascii?Q?3b0evB5NCGpXpuHK1lCx4A3E1A7K4mnTbOROfhz/b1gsAMZ5Se4CzZLSd20a?=
 =?us-ascii?Q?To5Qvc06JcpkP6/1+RsIax13jRj+4CqQ+l/um2rGxx3d5wlU43qXvcnoPR3F?=
 =?us-ascii?Q?mLAxFmhRC42SFCDnr4cTgC+NE/C1PeaZDkhBePRtKnp3fFJpq1KIZD3yWMEq?=
 =?us-ascii?Q?aE6VB0We6jhSSu19h6NTzRQAdon5CzAurfqGmXhqFaLQB6fF+aI52U6A+qKn?=
 =?us-ascii?Q?GxBv+sTIP/IM46bbjJnuPpZKoDwiQehNw3mDmfCHoUdH9W8pidDqI82aIFkS?=
 =?us-ascii?Q?GmWcySsM+d1U/SZecp2fJLl+54To1ikz2bUIhfet0iEOJjxjYyQ325nW5wZn?=
 =?us-ascii?Q?N2jOHDqpZC694C7BkXpgYzQb3n+1S/9qtbT+vOdqGQge+2vCb+fxp73yoYT7?=
 =?us-ascii?Q?TpVEBtiy725fsPhVJ/wAwUrrGoU4G51LGYafU8lbFZwizxLLBsdTXVdDf9dA?=
 =?us-ascii?Q?NWSwes7ELwYNaRqJlym94l1t9skswz/YtadJSjqeSItoL8uv5ulzr3cHpEit?=
 =?us-ascii?Q?EkOih8muZzQDJyVYIDs2UyQ+vgLpr4w/cBkbSZIl8HNXnVOcLEIhYy0TIVbP?=
 =?us-ascii?Q?9AzkqLsmTIvy4650nQuTVUHTInH+SZ+BY0aUCkNw7ZXN/Jclyx1orWVMYzi+?=
 =?us-ascii?Q?MOuAcfzlszESY+UuEyXSjWv1JZNhSay0+zxBRJYtiTnNbCDkDVXkF1Xct+8I?=
 =?us-ascii?Q?DTBU92KxTC8bPeDIjbzakVvAEG5sa7gc34yQN5VujDi4nww7DsGddMXv1Wef?=
 =?us-ascii?Q?zZAmJw9fR9OJP1vLnSf4fmFGJVykXGqnhwpZMck+52+o5SakNM0Y7rXaJWZ0?=
 =?us-ascii?Q?eqsoMRUxi77ziAcm/QPW0tBGanzYFaesHLuGlbTySfMktNST18UJsNOXrrPq?=
 =?us-ascii?Q?HUhhFUtcukFQFUHFETkW+Wj8/gYZBpESDBReZ86/9Tkl6QMHMJ+nuJ0C8KoJ?=
 =?us-ascii?Q?5NU96xhKuA82yZSVI/wJbaxiJP3wwSbmLDTW9rihaY/bZBVjr95pP9HdlqsB?=
 =?us-ascii?Q?Xuhc+OqLtmmiHK2Kiy8sqY/3Uqmad+YsfQzDWDYXnqE3Dj121fxTLisfgYms?=
 =?us-ascii?Q?kOej2xwSEz9gADy6lBEu2fG31VzIwoebxuUHqfmnClZaqyV4E07oPaJJP2n4?=
 =?us-ascii?Q?SCNbVM+xgNDAdfmFHq5OSZNtqN9L6gDd1UAVJkFlBEmaqkkb5qLjJ4GmmZqY?=
 =?us-ascii?Q?MYrY1arzNv8AJeQB9q/zow+pGOj/IURs?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 09:42:24.2938
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f231828-1733-40be-f3c0-08dcc1c5900b
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB7797

Revise ina233 config for yosemite4 schematic change

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 20 ++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 1765a0bb70d7..df389b506b4b 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1034,28 +1034,38 @@ adc@37 {
 	};
 
 	power-sensor@40 {
-		compatible = "ti,ina230";
+		compatible = "ti,ina233";
 		reg = <0x40>;
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@41 {
-		compatible = "ti,ina230";
+		compatible = "ti,ina233";
 		reg = <0x41>;
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@42 {
-		compatible = "ti,ina230";
+		compatible = "ti,ina233";
 		reg = <0x42>;
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@43 {
-		compatible = "ti,ina230";
+		compatible = "ti,ina233";
 		reg = <0x43>;
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@44 {
-		compatible = "ti,ina230";
+		compatible = "ti,ina233";
 		reg = <0x44>;
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	temperature-sensor@4e {
-- 
2.25.1


