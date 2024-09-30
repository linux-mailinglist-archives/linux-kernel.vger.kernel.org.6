Return-Path: <linux-kernel+bounces-343448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EB9989B09
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 493561F224F6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5ED1433D2;
	Mon, 30 Sep 2024 07:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="OCtoybFy"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2044.outbound.protection.outlook.com [40.107.215.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9295E17A5A7;
	Mon, 30 Sep 2024 07:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727679936; cv=fail; b=IEHPWyzQ0Zqd+QOmtHBbV7Ha70fQYQx9SLnSo7x8f6WwseOfwqi+pRDv95GuYmp7Ki4g+jcIONr6Wp8hIkz0HjRaHfotAqt/z9L2/E/gCQtGf4QKBu2KKNF+UISQSlFjT4gcU1SckAqiSLxUOwF3pXoja1PaHbiSV1fMd8CGblg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727679936; c=relaxed/simple;
	bh=t1Or76TyDWCxXIYztTCFdXpLdyxNOTIjSrmHeKC1jQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NRoPVfndbmQU3EVzwdSPz9zs1DPl6a0fgQx1BghlmmAwZReRVkynp6gbXoJM1fLODJQn6E3bm/tDwlQzr6HIAr68QdqZZuDNNM0SJvAL/LRoZRL6nD5fcw3r2hIH6tS8NkfF70dykDIEttn7qoZU1OjPR5kPRGS9T1zodnEz9Ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=OCtoybFy; arc=fail smtp.client-ip=40.107.215.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GWpY+X0sDZUvMYfm4IU7QTi7xYg3ppgnZwP7wTAGrXScvkkSRqPtXlwEEchmmXrAL2onqp0p4c42bPlvX3ly6MHAXzZlVGsNdONvHLy9FZAvpbNPwtNa1ukSsAAoLvg9Cyz5A11xdnb4k1HKjkaN7L/ROX9GMThNq7W7Mgg8KLcXAoUOYCKcmppQnkTnr9asKyrpA6caUW7Kxizv3ea+Q+91K+NiMFSPgQY5CxywiIk1CPWyCAd9WBr+fjBPtxLl8g0o3LB0ykR3Z5Ujt5JbO9LNr05hhZUTfFLgnhGoXB97Dus9oK5Az3SghmbfhsKIQS02lxMNwwqmHboqvAOj0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5i/bZoHyJSmMZJxO/mPyILNKiTIbi6Pc5Yof8O1IPjI=;
 b=R/tWfHxS7GMUrU4BO+qJx3MzUAENUKWPDjBonkchBdpv8SnsFrQhneFGUqlRD9lKx9LldlXvz829b1xC8DMwA4TY3TFzyEzaUb2Mtq8IuYdgPscb/oc1XU6ND+EiN2YX4wmAJ4W0DeqCTyQ2KO87Y7QpDwm4tR4gq8v8dmztrhUWOANRsbDgvQXXbQYKqed6fH33aP6VDnKrZKwP+Z8v1W7hN6RV1TZqeL0a9ag5/r4Ec1e6LrTQ2DHxUg9O0OkaWgG7sa8HCZWOBw52TwKvB0NYC4sl/2hDUJ8Qwtg9VYNYAxV+0AcwSsy/lhLO9tL4AqQiiyknsb15LQv0U/Qr2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5i/bZoHyJSmMZJxO/mPyILNKiTIbi6Pc5Yof8O1IPjI=;
 b=OCtoybFyj7Y2nTGSyV14TyNds0RuxHjwp7RyrH1EIaCWWDd/sj+knep254GW7CKhiYdsRKVQTrXhi3jdu/DEIK0dX1PEObp8z3V3Q1s0bmvKF1bJ42FB5i4JWukbXZlrg/4ubnI6d8a75vngTpEnCoR6LXKtaPsf4M1Uqmji64wCabHtHsVlhJ9K0msm79av0DaO8+qPeESXDHyKpgapY4eraC3sDc0qs67Eb6Ahvs79zM3v/k+tB9jjJKN5JSHIYujJuaYa97YG5oGPmNZhwmKajFTkQwKDfk9lmlH69YocmyfcL7EU5ATm5y5Sm/9Z0On/IfZJekCGBMBmMcnctg==
Received: from SI1PR02CA0050.apcprd02.prod.outlook.com (2603:1096:4:1f5::12)
 by TYSPR04MB7284.apcprd04.prod.outlook.com (2603:1096:400:475::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Mon, 30 Sep
 2024 07:05:29 +0000
Received: from SG2PEPF000B66CD.apcprd03.prod.outlook.com
 (2603:1096:4:1f5:cafe::66) by SI1PR02CA0050.outlook.office365.com
 (2603:1096:4:1f5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.34 via Frontend
 Transport; Mon, 30 Sep 2024 07:05:29 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CD.mail.protection.outlook.com (10.167.240.27) with Microsoft
 SMTP Server id 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024
 07:05:28 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>,
	Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 8/8] ARM: dts: aspeed: yosemite4: Add i2c-mux for ADC monitor on Spider Board
Date: Mon, 30 Sep 2024 15:04:59 +0800
Message-Id: <20240930070500.3174431-9-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240930070500.3174431-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240930070500.3174431-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CD:EE_|TYSPR04MB7284:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9029b5d4-ccf0-47e3-8ffd-08dce11e4461
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HSOdtiy39268n7G+r/9/bY2ocd+kRBKqYoE8dZfGMadrV8L0YViMsqlVn7MD?=
 =?us-ascii?Q?u8luCFNsbIUESTjmD7tWZxepWXlI3f8+ZgEwFPu8IwZtmE2hi2TRJuY2Ylq2?=
 =?us-ascii?Q?RUJwMhcNDpb3ULDP1kKqdK4cz9cbMYiOxSmrRsopBNtaAqhmf57wIzGROhmA?=
 =?us-ascii?Q?kSUJt36kjpQlRc+EzZ0ThbQmXM5/gIuYdKSVt/2+g59ZjKZb/nsZAv9SEfva?=
 =?us-ascii?Q?wMvYKvgf49CovuldTEhFmZIi3qOdrZiu8k1Z59RSvFQ5D2kbTccbbR3unn2O?=
 =?us-ascii?Q?2DqHGWM5TuykVrqx/bPhLfBOj/l54eTmOVtsYKMdwq0QerKQMCfdCj6jHssM?=
 =?us-ascii?Q?1wVnTd1W8NQ1eJF7FEHBMXKTcKBLq1aH149Oha5EqA6BZmtnfuvra4kBHsZa?=
 =?us-ascii?Q?acpIJz/77Oshve0zbsbtbq9p/qFohWFvZUMXZZkaZSApb29fWQl6Py1vXRiD?=
 =?us-ascii?Q?Ue8PL5u8eJ8zBnSK5Gq6J6Y/hxJ9Q9Jk63cnhPTQ2Zg374jkMhfN85mUrGlm?=
 =?us-ascii?Q?+0wLckC7d/I3fXECmzwXxwDU5grmv79c9gRLMJdUbdWD3qSHlikkBzVmcr2D?=
 =?us-ascii?Q?n4AuNtCBLpOFcbKskvfUn7+Q4mJwYOgFK6YXmWboCoxKqARYSm8lSwOM9/5u?=
 =?us-ascii?Q?Qlsy0ihr7+1Ff9D8gs/fKQisBzYUb0gzAsPe0z0lAwzSwMyTBQXL13b8fmoy?=
 =?us-ascii?Q?cfYV80K+fojDxiSOWVw8Ja3U88878+LKYWt0dZgPsb3uKwuz/PJYEiAaHpEa?=
 =?us-ascii?Q?lXhGeCr2Tfem1ZqUU3MUb9s6dGXXzFFFxjiq+FALg5OwsIA5H8Tkk3N41H5W?=
 =?us-ascii?Q?r6lgCme/h7D0gkBJy+NSfwMwCvtxdX/BIq78c85iQ4zROR/1bmdjWQFhyCUF?=
 =?us-ascii?Q?xgVH5GVfCi8RK5x4pNNzQ2A7Mel5KOfMRRlc+IOTs0VedKPfmFByP25Hz+Ny?=
 =?us-ascii?Q?0TReuo+ZkGWMZ1NKzc77PbgoPsYsT1wfooq2mCNfjbqSHtzWecsdvO08axTq?=
 =?us-ascii?Q?Tib3hHf8HMXLxB3XOPvbMG5aPBF+Q4Gj73wVusSfeHm9iHvhI4c5fObKqgZz?=
 =?us-ascii?Q?2ScSX3alGtTt/VCPcI6XKc50y2dmjmT7jaSFoDT/bPPVafbCuSTmlnrFISch?=
 =?us-ascii?Q?QxqKPdfPpbgXEzXtSRW3WVSMzdA6AnwLAH1JQWRSQNaNbOyLPIa5G7icXF9j?=
 =?us-ascii?Q?ryy2urAyKEELhLF68y/WAuYwGtTMAxDHPK+mhsVsbG5npMYTKU1nqqwKDoH5?=
 =?us-ascii?Q?ZbMSt76gt//+QB6WKpVw+7t46FZqDmAv8Px/uwpmjHoqi8XSDDh4f7bbiviV?=
 =?us-ascii?Q?akF+dfKBcmDT5skxrUwQ2XlSHoRm8F0+FNOeKDm0xzyyt72yOEhXTly8xNv2?=
 =?us-ascii?Q?N+DHKARoUaTVwCYcyN18434euK7oHC3l6Izmdg3kLZRauV+Mdmp5vyTHjDWS?=
 =?us-ascii?Q?0x3gs9RFnuSEikmjXz6JDVkf/oIf73BT?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 07:05:28.5562
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9029b5d4-ccf0-47e3-8ffd-08dce11e4461
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CD.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7284

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Add I2C mux for ADC monitors on Spider Board.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index e235ff7c7a9b..ec2d8a783ac1 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -34,6 +34,8 @@ aliases {
 		i2c29 = &imux29;
 		i2c30 = &imux30;
 		i2c31 = &imux31;
+		i2c32 = &imux32;
+		i2c33 = &imux33;
 		i2c34 = &imux34;
 		i2c35 = &imux35;
 	};
@@ -1128,29 +1130,25 @@ eeprom@51 {
 
 	i2c-mux@73 {
 		compatible = "nxp,pca9544";
+		reg = <0x73>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-
-		idle-state = <0>;
 		i2c-mux-idle-disconnect;
-		reg = <0x73>;
 
-		i2c@0 {
+		imux32: i2c@0 {
+			reg = <0>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			reg = <0>;
-
 			adc@35 {
 				compatible = "maxim,max11617";
 				reg = <0x35>;
 			};
 		};
 
-		i2c@1 {
+		imux33: i2c@1 {
+			reg = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			reg = <0>;
-
 			adc@35 {
 				compatible = "maxim,max11617";
 				reg = <0x35>;
-- 
2.25.1


