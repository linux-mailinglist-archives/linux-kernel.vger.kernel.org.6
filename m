Return-Path: <linux-kernel+bounces-345479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 493EF98B6CB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECBAB281D0C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D123619AD97;
	Tue,  1 Oct 2024 08:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="tR9fxnAb"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2080.outbound.protection.outlook.com [40.107.215.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7780E19CC32;
	Tue,  1 Oct 2024 08:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727770888; cv=fail; b=u2sqlfHrM5KasMIEZulLp2fHHYres8vzEspepVOFeAIXbPpl7/h70aHzl6zKneDr+0HxQdvAi8fIyJxLumHLGKFdlzlSJvjaqSbVs40E/NS1fj9wbqRpCjIBLvGTBOBH3xMhMjqdJENUoTStHqKEASmTXFHytiLv8bBNIs+xFng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727770888; c=relaxed/simple;
	bh=t1Or76TyDWCxXIYztTCFdXpLdyxNOTIjSrmHeKC1jQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UqNpeRD6ckWyOGG2Cg+bv1cWLuWt9ODiGdEFw0UOOjhEgi2YBGU1/2CEgyDmz5HD1SGjylr19LmBYJx/6Ft17BUMA+RIknvGK3CCgMkyk6RW1TCYBoVcxbP1jUfMHSieMkeWDOsRmjbTwvHjaT2c3eqSPAqkATqS8z4b+edvPmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=tR9fxnAb; arc=fail smtp.client-ip=40.107.215.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZpLQO6KDswdo8AO0GpzLo0eSnP9EloPrPz32xAZxF5gm1MbeSJCTbMyNgEQpz4DISSL7ab9X9T48h+O7WXuKBIYaxB0ToH7v4p/kzfjM6MyoeZOiJz4+hgctzgLTJK6Sdrn7IEHiHLyMQLHQGPC7XPWGGzvusoR5furtXfzvk9gpr9hcO3FXod35crt4NLAUG61lIkz3ExpXn/3ilt1QbLIZ6d2kzdPss/DZG7iLjApgWbKXlpUimvopbWRtiy87F7zu0vDk2VZUiN9stoFQVlcDn1+fSelQdU9m5JDUwv/4GA/hlG5o1XgW5JS0MwuAwoZ3gZ2b9H7Q72QA7aZuYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5i/bZoHyJSmMZJxO/mPyILNKiTIbi6Pc5Yof8O1IPjI=;
 b=uImjXzuaqa5LXnkT9fYUv6urX9KlPDbH1hTakgJqZtaWpJv3bXXkrpnpx43/fgoYtZm3aXcXXzYICv7+fgjsAgIuUDGHe2GdfEvQtdQFUeuseQiHF/+Kr/I0orEVfcL9CuProUsgHb2t6zjVMF4nQHgxi7X9Cd1aZQuMbBTpbk2gOy4UG6G4KAB0v72z8ipqGm+iEKNkMqw1xY5VsKzKThDPY60Stgw0PxFOdql4/WZReq/btTe0an+GWektvzj2ocqZjPy0RTjRZ9cHrpP3OSdphp2PPTH2k/eL8MMygXOI6AZRo+kth7LdcrZV7/uSiDYVTGm5JVk2oiDJWajCBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5i/bZoHyJSmMZJxO/mPyILNKiTIbi6Pc5Yof8O1IPjI=;
 b=tR9fxnAbRUn7kY7gTgpDzNxEsJOxNjVzQecATPduGUAS+nyk22tpzMeu/Z21nNopPeP8xXq6i21oQmaIewvSk6r9LP46WyKJLvsctNR7vnudUWYHb+9NEAkp5EWiiTeJ7SaNGmnp8nRxGNtfWO9Bzb3B25ag/HxnxukEHcfU63SX99gASESDAaWFb162WUzKxQu5UFLg7xSSA/jOwFyappB4CiAuofZuqiXIXv1e8JpUS2vbV+uoYZdu2+8E3GiCvM1XVpc4I4ee9IqQAzl8b0ISTJ7qXrvaX2DUXW3ROT638g8h/PJqmpv9tDfIYeoT88wrq8m7Yq0XD23qzJm8FQ==
Received: from PS2PR02CA0090.apcprd02.prod.outlook.com (2603:1096:300:5c::30)
 by TYZPR04MB6787.apcprd04.prod.outlook.com (2603:1096:400:340::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 08:21:20 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:300:5c:cafe::b2) by PS2PR02CA0090.outlook.office365.com
 (2603:1096:300:5c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.34 via Frontend
 Transport; Tue, 1 Oct 2024 08:21:20 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 08:21:19
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
Subject: [PATCH v2 10/10] ARM: dts: aspeed: yosemite4: Add i2c-mux for ADC monitor on Spider Board
Date: Tue,  1 Oct 2024 16:20:52 +0800
Message-Id: <20241001082053.3455836-11-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241001082053.3455836-1-Delphine_CC_Chiu@wiwynn.com>
References: <20241001082053.3455836-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|TYZPR04MB6787:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: bb2f8178-6439-4969-b314-08dce1f2075e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s4+SlLpFQSH4/P/w53BqI8vBGeygydlL9IFPTPp++vSl9eW/VHh6aueVId0m?=
 =?us-ascii?Q?F3PZ+aogww7hkjM8uw0t56esGPA8eoOnguWogGugs97H0tXPeq/7wSxfPwWo?=
 =?us-ascii?Q?um3Qb9jtVSW9CjqJI7RxsxDJSpJUFreOw/UKHSQo9WuA0PPCecIVSXzO+S98?=
 =?us-ascii?Q?2eWNkS4oUQJnYlB0T1LAW5k/vAKT5f+Ex+F5rxW1kIaPtwltsUH4cdDkyxd+?=
 =?us-ascii?Q?m3PRdKrdpwUuE9SCCs1CPoL22o76LOnroCWW7E/mwMYVlk6wZ5VCX4A8IRXW?=
 =?us-ascii?Q?/7rfzkitwM2LhHtUe8sB8JWKkDrG90RO7kl+XRE5cMY/KHQHnYFYoCZ6LdpM?=
 =?us-ascii?Q?oliu/ir8z+1filvc2bssbyJrJMv1hvLPtafA9VBBz1pZSKKQPPN79dafMPv8?=
 =?us-ascii?Q?V1tLkfRljb6VHR+GxqiPzdi+1Op1pfIwemzbc8cOaCQTM8A1WWNhyoUnnLdV?=
 =?us-ascii?Q?2D7u8FejcBkNofwhoU5zHQDXXchny1MCOut615jUUkdRkWYi0HjjvHIhT5sG?=
 =?us-ascii?Q?vmRKE3ZJHOmvnwh1vCsFPyxpaPtUC/n58RUkJyN4T5j4CAW0V2+aEFVFZU3W?=
 =?us-ascii?Q?ypJTnWs4CZ07htSUkFgmygglB1y4kqW8qJkV4k/JeuUC/cVwkQdCWwjioUoJ?=
 =?us-ascii?Q?n7n2ii2f/X44N6XJ+zkB3wvFH70VCVoc1TdUXVvdDfnvwSmV5h8f2jjm4D8h?=
 =?us-ascii?Q?5HCjKTEc7wEX7jqHPV4W5LE0W3wcE3iN1D/krPja9FEGBYOx/IXH9cyiKReM?=
 =?us-ascii?Q?6C0PXf71gaHJnJ1qW5qtceijLjS+w7zmr5RPJmzRCIc7uTvQuaIz9xOCBpRf?=
 =?us-ascii?Q?BDKeXDm8Gg6jMnAVrGM6bx3PkSkJ+PcC+psIk1o+CPaKhXaHjuWMsqFbaqaD?=
 =?us-ascii?Q?EcqBSEkoVnUQNJZfX4p1EefYjPAg2MwBi3zgP8uxz6SiL5GeQYW6FfPCoa99?=
 =?us-ascii?Q?CR60J8FhoAaY9yYBd0GiME/KXi4XhdqdCz6rfX5OKLWIifqqfkyunyC1R9VL?=
 =?us-ascii?Q?Z9YvfdZOXRkBObcRHk9w+52gNw0Y8zUlX7llUXaHZgqqleELsHr/2Bkt32/M?=
 =?us-ascii?Q?Gz1jR6V9GIXRmRUlRY5i7CixIoI4YhrpdhcIkKmYjJTKJ6M+oGJoKJZ+TzfS?=
 =?us-ascii?Q?yr2KPey5HKpn8U8ohsQsmgtxRToMiRk++S3A9nJw5w5mDkxHFn1RrJRq5fpL?=
 =?us-ascii?Q?d4EQLyWrFglS2BIAuEfaOdbtj3PbaD4w+YN8ao1+ioj71JmS99tq7zlzkAZA?=
 =?us-ascii?Q?mnkG4JjfYRi0l2fbFL9q+fr3U2GlMNNiLqhaljqB7ecua9YYKQm+cL0WLxc7?=
 =?us-ascii?Q?cWkWDpnFjnPcgJbrNEdX/Q8RfKH+WZreoHY1qkb4aAwuSfcFoFWddbLcqkn1?=
 =?us-ascii?Q?0mgIHwDmkoVaeQII5ROtZOS8FEXQ5dUosyd1RRdL8uucBl90tihA9VTP3HXe?=
 =?us-ascii?Q?piaUgy42cVOVdeObv2pf9O0K2UrddMmi?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 08:21:19.9406
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2f8178-6439-4969-b314-08dce1f2075e
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB6787

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


