Return-Path: <linux-kernel+bounces-289391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD619545C3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 347681C24338
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2BA15C121;
	Fri, 16 Aug 2024 09:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="SwjdKo1V"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2041.outbound.protection.outlook.com [40.107.117.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CC215B552;
	Fri, 16 Aug 2024 09:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723800390; cv=fail; b=DTNNDJqRPWIEQTyxb+H36Gvu1LTu5a0rZVAxvZUKyHQe66UE1YYytGeyNY5IpPnzEbGOxKES/Bf4U+/jtSFStqeviplkGpwfk1IzhNlpFpQg66VmYqE3Zn0AvIUQeQkJStN7hV/Dn35hnlsmQRqBTOf2USf9T+NVV/uS91uQF44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723800390; c=relaxed/simple;
	bh=n1VEhUcraB2L6lx1OzD6PjBTJW2T0K4J34nm/ZXFIVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Io32zXduXK3wm9jb29D7efU6FlySsQ8xSdVQap97K/qNL9SCdcd7hUgmMwQSF/0p++Kz5pCp6sPE9+yV9tSG2ySPmdbn2tOaHDZEdUgSuVhBPXUNZ1p/qoJJl/kh+gqF9rwGSn8vsEIwym7RIPRXHDeNkcDMCkvQmzPgZu03mGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=SwjdKo1V; arc=fail smtp.client-ip=40.107.117.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f3gygpX9yzbzGVsx6bZ8ZYzGW4Yl6QOJwAFKmfFsXo7o77FXsevgZIFlPcvgnCFLyqsYr6QB1+XZVpYVs1BBWLQuxs7KmwJ4a2ajfk749Tk1Dv7eVUaMgaGTY/L+jbXITGky2hE1N8WcEzYVQGX43t6PMvZ3jtNg5NG6R5aHvafbub4wfTMi/uWc0vPOFIRDQnSswAV0MZvhMx+bzqTL0WbKWVLxt/br0pRR1ngartfEJ3/9zvKLaI8bB0LDo1S2w6OOwpwgZLp57a6FqIiLUXui//YyFmI+Znj/s8g2I7NQQ17gz+rx6UIL35haHO3LhhPQSCg9O+MdssxGxgsZig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LgT/6R4EC/XEEfY2gUrLR0f3dvDaYSzSpR2s+GBhOIk=;
 b=T3sa4j4E+3GWcDtLSMKK3ML//g96xAe9+r5DPLP/8+HpIET2mzzmOkoOyDRDbazqE9rrvbchcVcx6j0QJCBpKFd24GtZLayIOZLJrNusW/0w5f0lw2rFqM0Pt/CxDDWtoewQdWRfaEg9zGXDitnEDxH4G5G8dIDiWleeqGNpawx5MnOkkGXk97PoxlV5M7RtKox0Lqdm/bRAR5Ifnn1XV7n8rLkHCgvMtNtHR6FJhD4Z0FseEBA3Nar8UuMbZNZNjjAWMuLF0g8q1NCk7YVdK12EvGSjtaA6WyTfg4aTT/Lb96kse+3ejXfG1nBzGDIXE8vOT0fch76XnvMoJvW18g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgT/6R4EC/XEEfY2gUrLR0f3dvDaYSzSpR2s+GBhOIk=;
 b=SwjdKo1VrSpIMD624itRJLxuP8Lo79z0lTX7aCYCHDNiVrIKMJLK+3K2HiqMoScxhK2r4zvImhsXQfcn8idQsDp+z7KjQ3hXe3yUr+EV+s0wW0PfZCDfF+ESocpGsyUX44HjMzxRvPLP+ydryVL9htlGWxUE5LJaVEdjeQY6LQi3rmlZZsmWXdIu9RvGsuKHV40EfhoTYHkY9JbW01DyZ+/jQeI1Olk+oPuM8UMCDecuX13k2FNI0OksNwUsvC9f95TKcTBl7UaYabBap2x2HjBYQa0ipn1ZlXDYlyhR1QKWWUmfxzuoKqA73Tw8eUDxgrzHdV4TCVlZF9WMyNWZ5A==
Received: from SI2PR01CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::14) by SG2PR04MB5770.apcprd04.prod.outlook.com
 (2603:1096:4:1d8::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.16; Fri, 16 Aug
 2024 09:26:19 +0000
Received: from HK3PEPF0000021D.apcprd03.prod.outlook.com
 (2603:1096:4:193:cafe::a9) by SI2PR01CA0040.outlook.office365.com
 (2603:1096:4:193::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19 via Frontend
 Transport; Fri, 16 Aug 2024 09:26:19 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021D.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server id 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 09:26:19
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
Subject: [PATCH v12 25/28] ARM: dts: aspeed: yosemite4: add RTQ6056 support
Date: Fri, 16 Aug 2024 17:24:12 +0800
Message-Id: <20240816092417.3651434-26-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021D:EE_|SG2PR04MB5770:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7a7e7030-eb0f-49e1-4124-08dcbdd57c9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ds55klNxofkZvtW2+EPbhwlvN6vozG2F1iFaPhW42KmAGQWXylKZ5Q9zjS5Q?=
 =?us-ascii?Q?VmCsOLBUDzN4HA1A9PrcDAiIs64AevrL2Z1+kwrrGJD7l9VjLM/7E4JNZHs4?=
 =?us-ascii?Q?5kI6wnxlhf4RPEkT+o+BOQAJ1sINt/kMD1MwUduuNgY1+gaZ/DzhXZFhsAzw?=
 =?us-ascii?Q?I82D0aadTb4KtnGJJovAQMl+IxDfhH1HDD1WdNd3Qt8Qo+zrlkcmDOyKHSnl?=
 =?us-ascii?Q?QaA0vaLBP7Gi7R2lxVmfRClsn2F/Y6jsjr302cp2lKWqZIUgqmihftQUUgpO?=
 =?us-ascii?Q?RXBERiz01wI4M9+ABjRCbZZXB4a+uIjn05xcdLE+2wcCJPBa0e4vc+J4F7pT?=
 =?us-ascii?Q?WXfPctuSkhwTVVGV2gbybyWuV50UW0qkclk+CyqSSOO7RzIDou2iH8o/+DPx?=
 =?us-ascii?Q?CEb6wEOxC/SyqwBXa/vj2+TsqDKP0gU5eTTWaGVVe2BOK9Bbk2C/UxhPf/AJ?=
 =?us-ascii?Q?JnxKmpicvFlwZR8dscyrWJepsjTXX9i/ZMGieIQ2Dh6kVRNoOaKcQ0h4Qm0S?=
 =?us-ascii?Q?GIiLToWhzf28qgInpdjqgTZTSv44MyhdNBVj7Ja9+uLB/qAE/0zgXeHtQkej?=
 =?us-ascii?Q?N7l0fq0i6QamMjym+8LrT9+Re1JqIwoS1MZN/i7lm+h0H/TTD/EXthsfIHxM?=
 =?us-ascii?Q?rM0t+fDVXswuHhMBWWVbilAtoA0zWV1PKI+zurr4MItD1i/1kLugRl0dzbIF?=
 =?us-ascii?Q?v9uXw/zFVG+PZ3Q81h3BOwnHFGEsvI+FsSily52hod/AJru1zg+WBnWvCGMQ?=
 =?us-ascii?Q?t5QFutMNysX9HyvUUggQg05yRIkoCedaIDvsj1CRGg8EYr+NdY8iE3PIJ6/R?=
 =?us-ascii?Q?OD4xdiFklZIh3E0z1fcBM/GPfZP6PNL9ZgWDzlrmxDsNUyhdpBsDEpXTsqHP?=
 =?us-ascii?Q?Oz2zlzyf5gDBHmyayTN/YLl90XZST0yNKexEMGa/f5sWqdZt/bOoOFJKoXgm?=
 =?us-ascii?Q?ve4BGn0V2f+q0YINzP03KYbawcdeForVV+EXD+8h30hzClGLUk7qvoROuqXE?=
 =?us-ascii?Q?ju/G6/gCLLgapAPGzL2+Teio09El0cdEXC6iiWlBOo7LXs39hM2p4CrzVYSy?=
 =?us-ascii?Q?7yN8fXvgdfaXSo4x+hSegP1bcjvnc9sEtH7sL5s6BGpUzn1IEYN8Cn+ktmOg?=
 =?us-ascii?Q?FE38fCROfke3kK0g3Dtc/sI3MCN0xYLDVp681zYJak9F4G3D5OuL9lhHc1C6?=
 =?us-ascii?Q?DYYPLezsHA0UxYHGxJb82LZD4NhftjryXDl8q6wQrDvC0KaqZGd7v64Xl6qt?=
 =?us-ascii?Q?uMKyKH6mA8WaBR6YNufN2ORNgj6+gpZ4eUsLITyzMWBl4bge7JWDXdtirWzp?=
 =?us-ascii?Q?EcrYZCXik1Vo8Jlq5SrKMd2mj0wGpMDeYYprVYaGg4Ore6X9keiNYxpBo2fE?=
 =?us-ascii?Q?g4JfhCJZGjwePCVD/13A6dXqKPnE3cGesZbJ+sZuAqhSCpTAgXnBmViQHsr+?=
 =?us-ascii?Q?XJOZDSEngvFQQM3p6giDre/uy/dOJ3hn?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 09:26:19.3410
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7e7030-eb0f-49e1-4124-08dcbdd57c9c
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021D.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR04MB5770

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


