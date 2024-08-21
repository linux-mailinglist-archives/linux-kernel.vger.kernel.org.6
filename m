Return-Path: <linux-kernel+bounces-295267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B4C95992D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC014B24E63
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC80200964;
	Wed, 21 Aug 2024 09:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="39PxuzxU"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2043.outbound.protection.outlook.com [40.107.215.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683A01FFA8C;
	Wed, 21 Aug 2024 09:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724233404; cv=fail; b=s45cIT4O10TMGd0iCuulQ9GE0/Zb1nljhblwH1/v9xj0OgMTD6ibGlIv4l9Kp72IdV5kzz64IcGWKsu9rhgApYfw2Syy1qYmyg4Q5WBe4j04E+JEQ8c2ZSyKQkTZlbCUKnaXytj70DCkXZY95xEwnpAdWlsqEtscyG7Ak9H8xNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724233404; c=relaxed/simple;
	bh=n1VEhUcraB2L6lx1OzD6PjBTJW2T0K4J34nm/ZXFIVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bVsLlVsY9BRn4B5vwrTgR9xqZngYV6wDweTFsonHyFumKabl9HHvJ24S1734JrHByzGlpk01cNfG0g2s+w3eXdTN7Isywi9qA2tUauhdOBtlvGl6Co8uaxhJK92GotQqCVml9joK0CZmTa84Doj92QvESeMHlpEbugCY3ENfTuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=39PxuzxU; arc=fail smtp.client-ip=40.107.215.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vuy/7dTxTzFS2kVpDbTeVi/vBZv9kVgJStEYYbJfumlOjyT0vwNqo1QPai9nEQ1rQLKvFOJteXafT+WrYVyz2MpW72MRpIshaPONwi9dc10Fwt6hj9cY6USH/WCsnK6ex9hAqZbdBcKuPiwX7olDIsCdrkVjTSuug/R6yitUjn1IwxGn30kJjLlc/e/8F1Is+75kKxTe7jTdmr4rjHwJBNHW9vyNNtCoGj9PibyEBWcUfi7nSObOrFFduzQzuwsbBKVNfU5H/feEY95vRULCyoEtgQEoVCPtK21VNhj7eqnzJtB0TI6PPDdAs86opaEasYEu581l90VJiJaAsk99Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LgT/6R4EC/XEEfY2gUrLR0f3dvDaYSzSpR2s+GBhOIk=;
 b=kpjGfUbglupy1qVAUTnKfHDwAMo5EPkwpQH3Mt20UtUxkOD8HUfVH3MKXNnoOuWDFSmhWE4drvvwAx1YUoMh5kcSDqeUpU9MaXLXAJ/0G+N8h+y0ORREI8nPlE+8Aq7gCIwCLM0Cgs+/4ccGvvHiAbzYXBq5kUMXNPh5XL/DGsXOMcd/YT66qYHPocIu5LIY2DklBYbWoyPhZJHNCICNRe81tF8fsNSdZ8EQvZG4vjJyna7ZV6TWfx04w8DbZ7RZbdTxRa8X4JRk1HnfNVRzuAaoOER0gRhZqHMnpCFl7xZ9uMROdRRI8RIGEYt3/AXnmDeEn4EJITRlkvUz65T5qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgT/6R4EC/XEEfY2gUrLR0f3dvDaYSzSpR2s+GBhOIk=;
 b=39PxuzxU0gu0L4Yx6EDtzez+Jx0mKDW29PRqoOSDpD0sBMSKClNQBvJvynMAQODUFZQEwLlBN4czSJtgZ0BDQl7kEhVVvhhbYqayKiZm0Lsayf52VP+9QLvRQFr6mVrd/XwFuF4nEwHpr8JZZQ6olH6sUYj3R87QzeJeMeRhW6Jv7zCq4Wy/ftmHR2aQUfzSETAfWGzVgRFBupnkFl29Z71772WJQmQ4n/5jyiqp+nseGGH1HmbsHmnnp/uQDWv+zAovh5J46tN5tH48Cb7nbxPeqYimnw3qu2bPBK6oys9FnTSaWvdV4XvfQ8wBaQNJqQj9nryYt2rnknrj9+4HIQ==
Received: from SI2PR02CA0034.apcprd02.prod.outlook.com (2603:1096:4:195::9) by
 TYZPR04MB5680.apcprd04.prod.outlook.com (2603:1096:400:1c7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Wed, 21 Aug
 2024 09:43:17 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:195:cafe::1a) by SI2PR02CA0034.outlook.office365.com
 (2603:1096:4:195::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18 via Frontend
 Transport; Wed, 21 Aug 2024 09:43:17 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server id 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024
 09:43:16 +0000
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
Subject: [PATCH v13 25/29] ARM: dts: aspeed: yosemite4: add RTQ6056 support
Date: Wed, 21 Aug 2024 17:40:36 +0800
Message-Id: <20240821094043.4126132-26-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|TYZPR04MB5680:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2efe3abf-fa7a-4051-3738-08dcc1c5af27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kbz5FwFLYjnx44rs4qQyvRjkYSlqJXwLq5XYGe6nwWNPs+L1XTG6uL82GdnG?=
 =?us-ascii?Q?WfFporzUzdF39Wg7O4pgRvg1A+8SbfKwTa8PuEp/wjDiC7SKA/AKd0LEhmyW?=
 =?us-ascii?Q?Q6Ufl1W2pQ4seuaxN2mtlTeO4GEnMYsWsjL7NcIDMrjSgG1iujhdwOoGubr9?=
 =?us-ascii?Q?eEOaHamEpFeyZtINzTFZvH8Elnk7IJjEavoZ1iwXkysApOxAtaw97lwaJcOf?=
 =?us-ascii?Q?rwpqLDm3gKPPQclRNSQjhYvELOzsMfK68FV73tTCIzIJQ297kJ9W99Zqunmz?=
 =?us-ascii?Q?hOV33tq1fcWx5RBgS3Ovk0IQ4DDgmTdVB0P8FJqOeTNooLiA3ICWbe46Qfvn?=
 =?us-ascii?Q?qdE0VJNcqOMGnaeZxz6PatA0dqQlj7te7uvhpD697ExlSaeWzRElHBQ8aow9?=
 =?us-ascii?Q?gCntPe6rCkNP/XAQTs9yaQhd/Ldyv1+LJtHjDVD7npk4Dh43ZDUGZOCv8auf?=
 =?us-ascii?Q?SdSXJfryyaOvJQtApgCizBQ4Y+fAceJ7oCrDkM/pn8xy1tc3lz0R1mGdM9Hi?=
 =?us-ascii?Q?ct0cMPMzwTTooeYGYiGnpdzjzBIizoCpNKBqz0uMzbgTOmp/6v3IeHl1tv9r?=
 =?us-ascii?Q?VUoSSNacHeq/aOdKkwqXgZsNt6rXnFxyfHx5IwcNDv9x/NMqDdzp7WOGjYDT?=
 =?us-ascii?Q?tyyrb1roco+LysLwYej5Pc5sLIBjE+Z3woxjlEoBz7AhVOJLvNvAmPyTVatG?=
 =?us-ascii?Q?7vq1yiLJzzcaJnDrwx8Bq3ZmoJJaITGMPQIScgy6d8K+fAdkPUDf9our6vrW?=
 =?us-ascii?Q?POUf2g7G/VMhYrXAuOVKTSLOAHM+V2Uqzw11Gu0NtQd41J2LcdKQ1Npewu27?=
 =?us-ascii?Q?K5OLYlb74qMq3HH5fUWZ2Sj0OVd3HyqLj7aZaAv86fLVS6nI9QwCQmLCD3O8?=
 =?us-ascii?Q?3GLdQySUkPmoXJhh+fatGmbCFfILTY5x4WtohuNSDd1Iey4F/4sBTXkFuTRJ?=
 =?us-ascii?Q?ah9U+XiaB9XtZlm8cD7dQki8qpuyNtk9hc0MSOnuVGeec3+mxBQO6/wAtdC7?=
 =?us-ascii?Q?fm+86s8jk2ncbZl5VxaJSmodll5mAyemehxtxEZb3V94TNX/+UeaOYX/O3PZ?=
 =?us-ascii?Q?2IxG/njn/iVHk+jDSRdDhkuXjY28BxPVbXqxMj3Zj5EPZy1IpFBQOZZd5kz2?=
 =?us-ascii?Q?8itSKeKVWoeh8Vyv6oixMa1sdIeMn4WmHxei8fQ3ErV+Xi8HRhg/3LsT6WWk?=
 =?us-ascii?Q?CnE6eyII17eC3OhK2P3AUxtZQ8BfDlEoE1ZsYiqdoFqL+FTdbpxvcLytR+Vz?=
 =?us-ascii?Q?2rauOgZqXKm8ZfAuhEJI9Sn2Nq8G0ry8YQt6X1cuWwFz/POPVkMluUR9bmCb?=
 =?us-ascii?Q?RIfgLUslR6eo6/lOi5TwifpKlxFnlFzId8tYiiInXnjNCw88Mlt7CbzCsMJ/?=
 =?us-ascii?Q?L0dR2qncZYA1BBlzltxmwZbLUxVjyovBFg1LAJhJ5j+y4iWn9Qi2YY9Dh7Lz?=
 =?us-ascii?Q?JmhvCZvRHcjyCWB8o3bIvqs2orc9ZMT9?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 09:43:16.4037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2efe3abf-fa7a-4051-3738-08dcc1c5af27
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB5680

Add RTQ6056 (spider board 3rd source) support in yosemite4 DTS.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts  | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index f73719b3c2f1..03a1e41312e3 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1240,35 +1240,35 @@ adc@37 {
 	};
 
 	power-sensor@40 {
-		compatible = "ti,ina233";
+		compatible = "ti,ina233", "richtek,rtq6056";
 		reg = <0x40>;
 		resistor-calibration = /bits/ 16 <0x0a00>;
 		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@41 {
-		compatible = "ti,ina233";
+		compatible = "ti,ina233", "richtek,rtq6056";
 		reg = <0x41>;
 		resistor-calibration = /bits/ 16 <0x0a00>;
 		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@42 {
-		compatible = "ti,ina233";
+		compatible = "ti,ina233", "richtek,rtq6056";
 		reg = <0x42>;
 		resistor-calibration = /bits/ 16 <0x0a00>;
 		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@43 {
-		compatible = "ti,ina233";
+		compatible = "ti,ina233", "richtek,rtq6056";
 		reg = <0x43>;
 		resistor-calibration = /bits/ 16 <0x0a00>;
 		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@44 {
-		compatible = "ti,ina233";
+		compatible = "ti,ina233", "richtek,rtq6056";
 		reg = <0x44>;
 		resistor-calibration = /bits/ 16 <0x0a00>;
 		current-lsb= /bits/ 16 <0x0001>;
-- 
2.25.1


