Return-Path: <linux-kernel+bounces-289379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB4B9545AA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95EA6B23227
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7D5155C80;
	Fri, 16 Aug 2024 09:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="Q4smfX43"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2085.outbound.protection.outlook.com [40.107.255.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CCD13D890;
	Fri, 16 Aug 2024 09:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723800333; cv=fail; b=XxmvN9w8yiCrVaBRZdNvnDW+tJYxhov60wRGgeshrw1e5NlqIzOY+iW2ggTCYh2jRRYJUYO99uw0rnMoiR9GbZxvg7IFdxYb0dEwVlveku+u0aYt3q6Y4FLVSE1E795sdPvXnCAE4GhIGHrQ0Kn9UJ+lYs4PYJqR68C3feSsO08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723800333; c=relaxed/simple;
	bh=/1DEqFeDmabkbZrUgFuqkLrnWSuzI1A1f6Jcr7p7VwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o3OEdsnpdsq8TeEVLodIUe5ZEmofzGscSkWOMMzrapQh4V5t1eKdz8oJGmafGbvkM3pdrzXzj5Qn5TDbe7jgc6fLRJGdismLwjyUuuRqxpyYPuX7vIZ2ASVOqBLukQLlrrl7V+zUcQSeQ3ODIO8qMz2fmXzi3hKUWZjgHyDD6PU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=Q4smfX43; arc=fail smtp.client-ip=40.107.255.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NjU5AhhhYu9xq5je7+GY1r5M5LgzVgSlgyUhB9leGR+yLPrvCfhxVAqm82/NrrIN5/jeg6ZsFJevU8YvLtZR3YM371U4Xi4gKIBCnM3p+B7VjYI1i1l77eV2KFe3eroecv1tB8OT5JFSad18q29pguvxhcjkeqH5ABZ/o4oKNlumUmSeOhoAtwDzNKi7Wi8v9aHqM8OFGFJPazOUGzYWvmNNageqnEGZvPdvCtjblO5QIgL8MjKSAqmL2JqcL79BsYTOo7ASporXsQZSVIlsbJQbfn/ZjIoQrk9A6ITBx/K2q+Rn3ziPz4owyFPb+KdOmRQrhkAE5fm9MqvsJtfBVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZanMQdXX7mf9CZbizY6qTm7CHfPB7I8RHeI6+dlIZ4=;
 b=Ozbaz4a+PT6DNv5QA6IIFRAQwZCNWHLE+c9zBCCWKre7X3Rxl9ejoVKoBq8IOKZBhxaKOGt9smqVdyAS0JctO4xdFeAdxWKjp89iNtXeqCiGmXlvnDbduf6xgqaJnrMYih2GXq2624xSsizbZJ77xp0G7gNt7hOz7CjyPdqsrelm9yqdhM9Yt37l3uxFnMa2RBGt0+CYOMzLOAajhG35g4vhSzSh2c8n5kgxOL7JCw+sydalNZoFjBf/LM7dJZG8KzNFPLqTZUpjOdkbwzkRPZqgavxQc+nWlFfqrnuNAEZsTprf9vIe67oopubujAPB7tP77IC7ZAXzFK6N2Mot5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZanMQdXX7mf9CZbizY6qTm7CHfPB7I8RHeI6+dlIZ4=;
 b=Q4smfX4346/V7lhVcdBt+hnFzpkeNKygbRQEfRKrWgpRb36BD93xmSt7RP7fzad7+Qpq2qhczi9i/txvfCiPn9Sl1hR+mIaQ5wlLZELr2+VrJ3jbhPjxrmvyBR2LzSHKajBbktP77bABLoMom7haPyPpsD9KW147pfwlf1IDEYr5qygJYfER8S0pVKT+fzDYO1H3Xqq8a614rJ85TT2/rNMHjuPgonu2iVeIzMO4dd7dO96KrpM4OU9iS6Av+UyQMujX23FtP93uo2NsTUwuQd8GgyKIft//ok5KXYSeZQpC0OJ8Hb6gf/J9Os/KkCF08e/Tb4sXVK8WiSswXJMIzg==
Received: from SI2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::7) by TYSPR04MB7284.apcprd04.prod.outlook.com
 (2603:1096:400:475::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Fri, 16 Aug
 2024 09:25:24 +0000
Received: from HK3PEPF0000021D.apcprd03.prod.outlook.com
 (2603:1096:4:193:cafe::d5) by SI2PR01CA0053.outlook.office365.com
 (2603:1096:4:193::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19 via Frontend
 Transport; Fri, 16 Aug 2024 09:25:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021D.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server id 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 09:25:23
 +0000
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
Subject: [PATCH v12 13/28] ARM: dts: aspeed: yosemite4: Revise adc128d818 adc mode for yosemite4 schematic change
Date: Fri, 16 Aug 2024 17:24:00 +0800
Message-Id: <20240816092417.3651434-14-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240816092417.3651434-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240816092417.3651434-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021D:EE_|TYSPR04MB7284:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5720e0ce-95f8-4cf0-9f3b-08dcbdd55b87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9EvtsCjlCC111Zl0XA6EcPDWz7KhfeZatCiKbWGh+CQIRdp5T97UyKIMTDDz?=
 =?us-ascii?Q?TAdmx0Ywlu4E8oLSRi1LFZTrUGYMXWDrflX/nIlWJn2FCtdTx29+aLHAJs0P?=
 =?us-ascii?Q?UiyfpK1NABjEgLZAj+FkLfmibh792gHOYziSaIlIqM2ANF/28QSMn6SKlUa2?=
 =?us-ascii?Q?J+cyLN7Xufz32/uAJuAjXVkAkPHnek/FqT1a09FZZj3kaKl687HYVk8ms/H4?=
 =?us-ascii?Q?T2x9XDNSXJ1sjBDLIaJDBB6H4QSOisosXpGeNMAx06ZUQGJx8UNOYF/gEC62?=
 =?us-ascii?Q?JlkuTjtG6mNcr0/s1oPUyFQwWRmgC2tJjMJTQIgsYBPNtbWsRETYs/OcffkH?=
 =?us-ascii?Q?ywgiS8TO8tNN6hLjOibvnFHs+06paA1Qyzfli3pW1mfJvFOudC/+7DMTXfH2?=
 =?us-ascii?Q?fbKXLY2q6wlpMI8Z5uXYUyUbrQpDxLytk6O1nJKCtBspPMwppNhWzfTZArjc?=
 =?us-ascii?Q?nG2+UrLEyNCyOTiwqDtvpB+thtM+FcAj0vJbfh225tQ/VbGu3agqzwfteqUm?=
 =?us-ascii?Q?kYDNV/NQxQ3qBiBNtIoy3BVe2jGeN63v/IIjnzbPZXrBobVsQVB3Wl2cqxPE?=
 =?us-ascii?Q?cHEWDcUISYvUs2+HFHr1jjNrERPPDpXYB0YCoMsx4c3LqLljBTKH9xWrKZVy?=
 =?us-ascii?Q?5347mEnOg1hX3pV3GgWHNeXkzyYckFYItDz2Hb5Dk/AVzc/Wbr7U4GczSht7?=
 =?us-ascii?Q?ir8iJ5TntyIePi7qhqc7glhn3SexNn0RNAYupo8YjHP0iuN68TasahRGthk/?=
 =?us-ascii?Q?LY8C6y2OYfBjm0eDdRzRxFlSBTydBfYSmSzvxyPaCRy6U5C8QVdKBrkZENj6?=
 =?us-ascii?Q?31KbLEGAWipMYYTqEdQCrQQIWvzBbDkJGCD7F35NPFMr7TPJhto136ia2vqs?=
 =?us-ascii?Q?9qbN5jl6bR1QnsYDVUgSBPn1jzQKMzUrNOXozOIRZ5HPduqdS9+oOEIO3ksG?=
 =?us-ascii?Q?SHSqqPWovIyYSfI6JsDKqSPX3bxYuroeNA7jH5Ky+VftEy0oAzNvbzS9Nfha?=
 =?us-ascii?Q?lGMSKr06ZrRDB2j+jGpEAc6IzNJgFovQruXpTiYTm1UtoGMeCrBGCqIPAxbW?=
 =?us-ascii?Q?n2stmIc5G3JZ+8cAZyqS05rYrtn5rmlSk2sYFo+yfbjr+e9WB8uYCXVNnHqc?=
 =?us-ascii?Q?3GoCmi5z/P5ndomF/6m8xsY4C0IYqq6iZnXBB8gFMe1OP7wQVz9W9Uf4Q7x6?=
 =?us-ascii?Q?f0R0B5YOEfI6z+TbeaVkBMJ4bRXZyMyQbn0OC5q5x+BtmTV+SfnqSLNorlOX?=
 =?us-ascii?Q?nHhWZAdG3hEkxbBssGbu1kRMhGrfrwC3xcDiHmiTLiEq0JGGfg/+o6OGgoTh?=
 =?us-ascii?Q?CTz8yg//U5/rqLwcFPLncV1OCjoeh1iuegPCu0RsDOaFiNGyElHCQJ8LAjhh?=
 =?us-ascii?Q?rBBWC4aEw9PEs1lqemQYSV0Xklji1c63Ar7MHhnKsKiuK0hcPS3g0qZr30wC?=
 =?us-ascii?Q?TaWdt8gE2l6OrzvzHGkRC9DKKJheNdVG?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 09:25:23.8722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5720e0ce-95f8-4cf0-9f3b-08dcbdd55b87
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021D.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7284

Revise adc128d818 adc mode for yosemite4 schematic change

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts  | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 2c0c37b3ee5b..1765a0bb70d7 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1018,19 +1018,19 @@ &i2c14 {
 	adc@1d {
 		compatible = "ti,adc128d818";
 		reg = <0x1d>;
-		ti,mode = /bits/ 8 <2>;
+		ti,mode = /bits/ 8 <1>;
 	};
 
-	adc@35 {
+	adc@36 {
 		compatible = "ti,adc128d818";
-		reg = <0x35>;
-		ti,mode = /bits/ 8 <2>;
+		reg = <0x36>;
+		ti,mode = /bits/ 8 <1>;
 	};
 
 	adc@37 {
 		compatible = "ti,adc128d818";
 		reg = <0x37>;
-		ti,mode = /bits/ 8 <2>;
+		ti,mode = /bits/ 8 <1>;
 	};
 
 	power-sensor@40 {
-- 
2.25.1


