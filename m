Return-Path: <linux-kernel+bounces-295254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EAE959911
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1D51F2125B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66931FBF23;
	Wed, 21 Aug 2024 09:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="snTMrlFh"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010046.outbound.protection.outlook.com [52.101.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8120E1FB2DD;
	Wed, 21 Aug 2024 09:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724233337; cv=fail; b=KEzxm2wG3U1hx9AmEPtuCsS4VkRK5qzxpqa7MbpB3nCegx9z/Hfcp7g5KwwVvXvTael4JgVRXywyygta7YcpdP6EQv/Cuf8gaNW8gszP+Kj5VeXU0LyESDyQGSr+MAAebE+HHaFsuDHvDq7EYcwETesPrw1+w3GrYF6wTlPxaRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724233337; c=relaxed/simple;
	bh=WC/dcjR1tUqtqDip0Xs2AM5RqTGhPS8rf/xSzw8zvQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gh1yraJQNhfzF7D3wkiOWm7opvOZl1hEcWjsokigDEObbsbc21DKwoKREV/7/OGGF4A3t+l3Mgi0B9yd9XMlC9X2rsoIokoPpWZ/wutPLOHLonXG21Nl5aRDMbMp7xgE/r3mg6zpnY+NwS52Mjk9hbUeMwtyeuOsI9mCP1x2tKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=snTMrlFh; arc=fail smtp.client-ip=52.101.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZtbZdDrHHzDSRLugrhzvRa4p1pnSi0ul6PjKResyft/uoo44fjizCdLYZuNe9y1CIuRX9lKuQ/0g6Lh4Diro/ZXUpSKMC/5+mbvhgm61biiS8yJGTGqOQN8pCvTZtDGTy5is/uL7WeO/xa22OC1Qq+lyd0Rq3jeiT1cPvm5icMxC2Y1PD7ZT8EJe5LNGdV2PUqlrlGfxOBNeQCtWYMJdFVLik6Gom/qmLU79+qajGd4YCc9IDSXRWv+9aSuJIUEmJO5378NXMsHYTBi4WHGk0NyRd+tAa4cO1nKwliDfoVxnMJMMXyk9nJzDlrHCYNKoBe82/u4YPtkLN24QKRVaqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKZ5ogJ9/YHI36u51f7OMva5yJpzuLKM9pz7+UUgD64=;
 b=sDDbYMXjF7d5OWlKJMWo3zfJvtBq2biHKOQNfLveCz8xVqO4Nuply0yXU9xO9n05lMkjF4JH9BTFgwQgf6QJIW79hQJm5oxbDfx0m6yYBimJU524SsCRqspy7aFcCwQ9tScKCDbv/L74abH9OSxIMBZZF23izYMzPs9fIaOYXzWHZ1z/OYb4yh/uqxURtefE1rQ3Gu2IJaKJRRJzL7Fwn0IzpRQ0Q0inGlN5B1P9a3PPg5usMjWeyRViId4/XSKgAuF5MQT/PYIT/wVxXn24W+E31KDRW2Gh0Cks4jR2BWA+cjibU7PQF9FqQM+G2JrO0yGpc+l44ad6O08yxUeCJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKZ5ogJ9/YHI36u51f7OMva5yJpzuLKM9pz7+UUgD64=;
 b=snTMrlFhSMRPd8nQSggFW54pk8HOjj1h19S+MFpYlkEyRghfgMuoQaaKs+JPq7Rs0N7bCO7jhhEKFUCX5v1R4A2MGmV90BqjW0M1Iommp+etAb4z6ZziA3g7hN64PlUUHNPDzfQqV1qIQI0FkSov+r5rrLUlG82/d9tnBFsNNNZ6GYUjTN7q/gb0eCqOD0+gnGxk15JVf1uBSp4RnW/lL/eTA8y7AODPFVYQyc41PJ2IAcyaypPkkfsj5/b2pBcFMDv4QqAUGS5lpR2V3MrTefImu6MvnTGaUMnN4ILzghNTIrrEPwVRy7SDFmdRCZn0lhA6jFQ7808aIOExXX2lLQ==
Received: from SI2PR02CA0028.apcprd02.prod.outlook.com (2603:1096:4:195::8) by
 PUZPR04MB6938.apcprd04.prod.outlook.com (2603:1096:301:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Wed, 21 Aug
 2024 09:42:07 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:195:cafe::10) by SI2PR02CA0028.outlook.office365.com
 (2603:1096:4:195::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17 via Frontend
 Transport; Wed, 21 Aug 2024 09:42:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server id 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024
 09:42:05 +0000
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
Subject: [PATCH v13 10/29] ARM: dts: aspeed: yosemite4: Add power sensor for power module reading
Date: Wed, 21 Aug 2024 17:40:21 +0800
Message-Id: <20240821094043.4126132-11-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|PUZPR04MB6938:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3b6864a4-a555-4681-9578-08dcc1c5850e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pqU9UTaNoAG2l1eDOO5Ep/TnvdQJ5HOH7jfftP92rHM2otXKrk4Yt7+Hhkve?=
 =?us-ascii?Q?/6feHxk3R48I4HoG9MRfDG4KDk2pSmqjgc8XvovXh1dnRF+Ioijpe8v9e0Ny?=
 =?us-ascii?Q?xXM4lwVYFC0KdBigRM4cw41uTQU4xJvCHMI/lmWUe8JABUcXORRsYqepxdV+?=
 =?us-ascii?Q?hxMM7sfcvnNf5zGqeph8x7ezcvDw4yKfrNkvtWv63SX5VCCm8Bah0RD0mFgW?=
 =?us-ascii?Q?CorzoKYSz3eem/c1rEapokp5oPXDygNKRQyMXQ3khTvk9Ih7w/JC7g/zMKFN?=
 =?us-ascii?Q?0gxhC/Wg1Mqa+FHUVVBlfNYVvp2k0JHCSp0dJFJJORq1BEppSWjKDxvVQUzo?=
 =?us-ascii?Q?a5reKGYEmRuVwtDO2Fk22yBMuVJOpg6gZQ+DRN/WFZcrSnyi6c1VmSQov5rX?=
 =?us-ascii?Q?YSlUhE05vOFnWlv8f/fdo5zZooDETQmu7H6x775ySdVsYtGS1jcgQo280x0K?=
 =?us-ascii?Q?lnHKW2nAlcbHS0zPDgxNXP4RcoNg0Z+DQVaUb4wBvTvVXVpx6rIbUMpzPAqJ?=
 =?us-ascii?Q?qf0PYhk7nzd/0SvRaegYcc8fiQZ6mmcnPYVnW6kMYnzUfNSnN2ceeftaFxy5?=
 =?us-ascii?Q?g9Nkkw1YEEaYvLBWbZYdwgvrn2cJBRxQfculgwR7ui37luql+BttA5KtqEOY?=
 =?us-ascii?Q?8XjbxE9yEokKHF/Q4hJ5zFGjh1H94oTbpD9TkrCVofoQgOIELr/vCwMOIz01?=
 =?us-ascii?Q?4yYqJzDfNUYwLFzGgJo0opuMOsecpzw2M1p5e7/LMGpC7zGULGYVUbo3A/Qn?=
 =?us-ascii?Q?Pd8NbTnvfto76DHayBeRU5q9bav2kweoZuiVfn1+dXpLQ4BIPpbzgZor9Wuu?=
 =?us-ascii?Q?YonefhFvw1JOl7e6WtuDdVuijF4EKF/Vuw6heIZYPGYb1ehaUFn6WMFvP2iA?=
 =?us-ascii?Q?xA9nQPDpDDOhKY5w1vaqbM9ckHjI+seeDe5G77ASxHnKNvozJZPU8XN5L7kB?=
 =?us-ascii?Q?YqKkUv5IHPLGhp8fxJzbK0y/vM0g08gRP1iNiVbRmwoWrffsHSEYITJBzOHh?=
 =?us-ascii?Q?crtvJgrVs0TZTapwhScWObwto8IY6VVB6iqJ4CJVjxjac0pnJxsGdKU/fdew?=
 =?us-ascii?Q?0V3j0N6OvW0YaRICkwv+Fy/YBuaP/+0FEwgnNELZXSC9asgl6BVW6GkjaMcq?=
 =?us-ascii?Q?uMAw8Gk5BWRpnDiiYzanDxegBv/ROvW5D5eNyioJX5VCyP5amAWXcppiDQde?=
 =?us-ascii?Q?Z/LSp6MI11aR40aqUmwvKrH/twqp44ISYSsPmVXlP0hfZ3zYv1IcDyW43R+k?=
 =?us-ascii?Q?LOWgtTdKdNkB0DDrC+zxD3NDZp+yJK6iLFSm3p/SX8rkrGQ5i0reyMDuBRf8?=
 =?us-ascii?Q?AtxVBwiUAWvpw8/kxCJCsSvJXbE3GTNCYU5oz1/a5rv3K2AXwvoM1h0C3SVI?=
 =?us-ascii?Q?Z9nU3pyRJvdiSk1ALSw4ziqT8U5W0W92vDYCsVCLItxVN2U/9iQo/IGyftpi?=
 =?us-ascii?Q?j9AZAkUdlnl3qAehgl6GdiFRBrcK3Oy8?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 09:42:05.7780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6864a4-a555-4681-9578-08dcc1c5850e
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB6938

Add power sensor for power module reading

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 09bbbcb192f5..139a09de24cf 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -906,6 +906,11 @@ gpio@23 {
 		"HSC7_ALERT2_R_N","HSC8_ALERT2_R_N";
 	};
 
+	power-sensor@40 {
+		compatible = "mps,mp5023";
+		reg = <0x40>;
+	};
+
 	temperature-sensor@48 {
 		compatible = "ti,tmp75";
 		reg = <0x48>;
@@ -930,6 +935,26 @@ eeprom@54 {
 		compatible = "atmel,24c256";
 		reg = <0x54>;
 	};
+
+	power-sensor@62 {
+		compatible = "pmbus";
+		reg = <0x62>;
+	};
+
+	power-sensor@64 {
+		compatible = "pmbus";
+		reg = <0x64>;
+	};
+
+	power-sensor@65 {
+		compatible = "pmbus";
+		reg = <0x65>;
+	};
+
+	power-sensor@68 {
+		compatible = "pmbus";
+		reg = <0x68>;
+	};
 };
 
 &i2c12 {
-- 
2.25.1


