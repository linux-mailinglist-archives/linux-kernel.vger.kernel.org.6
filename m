Return-Path: <linux-kernel+bounces-320511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AECB0970B69
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 03:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6634328405E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 01:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6AD1CD1F;
	Mon,  9 Sep 2024 01:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="jkfqgBLr"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2041.outbound.protection.outlook.com [40.107.255.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2A81C286;
	Mon,  9 Sep 2024 01:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725845886; cv=fail; b=hIdgPAZoCjaA0dWkbxoStJvvSlaZit8fpudF5MPJyh8Wrk7GgcxfId9PPeKmX2pW7F3U25TnspcCi4M3GITLN19VvEmj3ImUOWokofGP1eZ4KS3C9KrjtOyp9VgV4eYC2FSibuHS2PGhK2PsIkw+0SqQAo5mpsQEyqMki8CbmGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725845886; c=relaxed/simple;
	bh=iCIMGv5P01DSjb9h3Ti2lFzYvNUr5k3SYMHX/MsfuoM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JBXMcHBpLfPeI0R7QjfU4WumFkV3DM6hQHDP8I53p3gCAf/yCX675ZDMaNNgTd0cIDnew9gMqIRYEdWs5uHgw8p5GHXs+9BJLGXxNhzTiduPEmcQkNPb3AtDC3oYIprxFIJAKbfpkotRae33L8oWrrOz/9tKU67d4ijOCLbHiKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=jkfqgBLr; arc=fail smtp.client-ip=40.107.255.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hU+znGeQMSnb8rfE2Y3zao1ShXMC5Bi6UtafCXU2yARAfsgx/bKQzToFm9uq9jt/RDNipLW77ZpoDpCNjI7aBlAD9xwSKNDCmmuqyR/rJRLgTvxUaVqxMvHUTdIhYcLmi0Hm69ejOQtdj97TmPdkc96qtIIi2KGry1p1QUnbY424oOepFjNUK+AeV62lk4vadMXammj2Ip8/bwBPRvShN3WnKjcvx86BCkpbLqfDpAhGd1X/VVpRRZYqlYnX88enHng3LyKX8OKnFo0grlWDWBjkSxANLzJcV9J3MdoaPyMGLeQTt04uLgIiPWh3aUdG+WyzwxOavYJojdLzth+9xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WtOm1gxT8Gyb8WrQVSDmxu3qdMr6yZ1Z7qB5y9F9It8=;
 b=Szl7qpCOXo95aSZlgzgoc//0u7TOQvsVu6I4PPhwTwjsbaqpRVajqcVcyIAEB3vvd06Ks6ezHWK2gZb7RXTBx8AfediIrI4xFYx3xIPV/saOWm+jFwZukFi8LtXllxqTU/a0LVsFABCsapFws9JTjh1LMGLDpRRyZTc3yeLhw1SCgY/LvpQH2eJIe5bHluRSiHurOK58F14EJoG9CwkGZfhHSn13MKpKmkImvaHeajmZZt3ucbzp6uBXQwmdreZHaFLTRrXeH78A1ao2hKyTTfmdIdq7BRltEAcnHJDapEguKjJKRS1pF6xacO8qNybBR9J9TuugmMIpwu08JHL47w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtOm1gxT8Gyb8WrQVSDmxu3qdMr6yZ1Z7qB5y9F9It8=;
 b=jkfqgBLrI5qMXmJjgnHILJJrRuPIO6cZGTk38zJ+XvLKjamwfciUzayQdksxPl5g99ux+eieUNLAQO9X68wHJBSDlSR5yQvyIQ+wOV5SucXQc3hohCFcxa3pI81bYQlp/rmUe1nxoYQgrTvLak1jObWKCDUbQyjSM84Ns8i10KTbkPoIZKdhmmIXOnV8mAFUf51obs2FvDwf3gVnyBSWapYEtujAG4Psalafw6oqSTdcYFXPv2/ySoFhX2DFxi25l5LF9IEVOeP5zOlDnaWKCfVrUP6F6lrjkKsXMG7TKEe66G+RZsReBcWgKlhiXHmBL+rCkBicUkeNAmQhkFnWNQ==
Received: from SG2PR02CA0021.apcprd02.prod.outlook.com (2603:1096:3:17::33) by
 SEYPR04MB7776.apcprd04.prod.outlook.com (2603:1096:101:210::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.28; Mon, 9 Sep 2024 01:37:59 +0000
Received: from SG1PEPF000082E3.apcprd02.prod.outlook.com
 (2603:1096:3:17:cafe::7) by SG2PR02CA0021.outlook.office365.com
 (2603:1096:3:17::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Mon, 9 Sep 2024 01:37:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E3.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server id 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 01:37:58
 +0000
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
Subject: [PATCH v17 2/3] ARM: dts: aspeed: yosemite4: add mctp config and sensors for NIC
Date: Mon,  9 Sep 2024 09:37:43 +0800
Message-Id: <20240909013745.3306365-3-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240909013745.3306365-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240909013745.3306365-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E3:EE_|SEYPR04MB7776:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 73733825-2d96-46cb-da45-08dcd0700960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LA0vqQKh6D2Y6B/Z+ORWwWYUjpXH+FXIb1OQb6E/FcZ4bgfb+SL/4VLRuCVo?=
 =?us-ascii?Q?GN+TOxSqGz4atjzKoDDct9TEFCTjXa2PsN5MS7pymZ+F95ApArZ1JnK+jq4u?=
 =?us-ascii?Q?inntrMsJX4U6uhqzwBv49xEnrqNCJVL2PmqTb0Db23ZybUdJ9sQ7qfnCVjkz?=
 =?us-ascii?Q?GYtOWRtGqiTszl6gJC2pWsX3X7cCYcSWJ7Dllbzk/MmJx9x9GUJey1ODg+u5?=
 =?us-ascii?Q?vnjwz6JnLRa+uoFKCQJZ5Ubp+uHeTAodKZ+zcwh5Ne/83re3QQGN/vfDtX7C?=
 =?us-ascii?Q?eiK9Of9k0KKI17hs9Lg+NulwrWxudGpKo/DWepG1ePrymo9tcm2Obq8yE+Mv?=
 =?us-ascii?Q?m+FK8BaSmPxuCv62QRCCDiAINAQ8ueyjP2oS6enhjfC5ZY0dEGGuyqU4DUhf?=
 =?us-ascii?Q?GgDWAEKurfiweEWfir9ZJhNb8hkCdMrE4ZQmj3LVGQ5Dhr/4+QmWqq2DwSOx?=
 =?us-ascii?Q?YBT9yaopq95NtQ1I2e6OtjiHr0UKnlIZLd61thzihKxMXrlwNTXvkxlzu2wf?=
 =?us-ascii?Q?lsWOVHXyLSbAuIeF/w5MsrBnQpLJMuNjsQS0morapWdXSUQ5u3ShtcAikuQN?=
 =?us-ascii?Q?Oen/yI/iTaxyzyjdYLRZlaC+W2qMuXfAV1va/ikXMexn6qvcFL/djERi+uAW?=
 =?us-ascii?Q?LMXy3hmdoUzAK9rA00bm9uMJav4U5bjoNGOkqXtHc4nekyY3lYdlRdz2bqFp?=
 =?us-ascii?Q?uTxUEdxfVw9uTaImAqOZwN+Tc7oLmghZQYEypQl+WbCmZlFEAUJDfAK5fo/p?=
 =?us-ascii?Q?lUuIt7fvndxUMPrhYMu43OvvlLRc+EHaH4Jsp4ls1Pqg29xOvtrrFVLJn7IB?=
 =?us-ascii?Q?xF4c9LyG6RD3rsHf+2Z0R2OlrFaQNcVGVgwDAlrclHA56axv/shqPCIYXUiD?=
 =?us-ascii?Q?nwf0NbzF6SWhx1A7mndibgZyCZndRlSmLTwmgB2SfeaLCWpjWYno9lQ80TPS?=
 =?us-ascii?Q?utH20At2Je/cF72MF1mZgv8tvyp6KuwuUkMQMAK9DUsky0xPc+cSBtZfVySK?=
 =?us-ascii?Q?Z3cBx/bjX/9SpBQTs6xvwCH6WoaFzKNjmq+xA0lTkKXTzIDB0RiDrnqiFbdD?=
 =?us-ascii?Q?Wmru8iP5ALEwp9vMD21pyoXaWvq/iM/4tw6N41c+veI3znLuIcuQVMHGPeAn?=
 =?us-ascii?Q?dTAvrxn/nvzJJrDBxwxYIpIBZ51wUUPSL7GWghTy0a7Yw1gmTbWuALnr/bVl?=
 =?us-ascii?Q?9xXRYA79RXHB04ho6NiSY/nfmuS4d7kk5mxTU5jdPQv4kbfJ1sxwz9w0k2UE?=
 =?us-ascii?Q?FCUPlsQ041+rMrVG37LArvIkohQni8Z0/5GeBhvPcCwRm0fL0it/CP/9nq/Q?=
 =?us-ascii?Q?kcA0n1sNRjg9mS8FwFojrcoddJQt/CsEM+6rlp2S3BypIETN4ucTZvCpNJbL?=
 =?us-ascii?Q?BDh0ByARyrfIczXNYpAQels9BxTrLG+l5Q5Q8fJ1zU+NoExOKwC2OaYySBCu?=
 =?us-ascii?Q?2u4MSPoZt9nJode5b/o1U2zbSi5pXOPD?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 01:37:58.5305
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73733825-2d96-46cb-da45-08dcd0700960
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E3.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB7776

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

- Add MCTP config for NIC and remove the unnecessary MCTP config on bus
15.
- Add 2nd source temperature sensors EMC1403 for NIC.
- Add eeprom for NIC.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 49 ++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 96039ffbf8ef..9ddeccf650cd 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -918,7 +918,6 @@ adc@35 {
 
 &i2c15 {
 	status = "okay";
-	mctp-controller;
 	multi-master;
 	bus-frequency = <400000>;
 
@@ -936,40 +935,88 @@ imux24: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+			mctp-controller;
+
 			temperature-sensor@1f {
 				compatible = "ti,tmp421";
 				reg = <0x1f>;
 			};
+
+			temperature-sensor@3c {
+				compatible = "smsc,emc1403";
+				reg = <0x3c>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
 		};
 
 		imux25: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
+			mctp-controller;
+
 			temperature-sensor@1f {
 				compatible = "ti,tmp421";
 				reg = <0x1f>;
 			};
+
+			temperature-sensor@3c {
+				compatible = "smsc,emc1403";
+				reg = <0x3c>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
 		};
 
 		imux26: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
+			mctp-controller;
+
 			temperature-sensor@1f {
 				compatible = "ti,tmp421";
 				reg = <0x1f>;
 			};
+
+			temperature-sensor@3c {
+				compatible = "smsc,emc1403";
+				reg = <0x3c>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
 		};
 
 		imux27: i2c@3 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <3>;
+			mctp-controller;
+
 			temperature-sensor@1f {
 				compatible = "ti,tmp421";
 				reg = <0x1f>;
 			};
+
+			temperature-sensor@3c {
+				compatible = "smsc,emc1403";
+				reg = <0x3c>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
 		};
 	};
 };
-- 
2.25.1


