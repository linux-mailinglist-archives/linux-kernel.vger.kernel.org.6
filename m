Return-Path: <linux-kernel+bounces-332494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C46AD97BA70
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 11:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 573C81F278A7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 09:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D94188A2E;
	Wed, 18 Sep 2024 09:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="NVx/Be0j"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2050.outbound.protection.outlook.com [40.107.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C98018786C;
	Wed, 18 Sep 2024 09:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726653304; cv=fail; b=imsj6hEUinj1e19/kIptj6NJ1q/TyY7QidltBcvFmuKNifxBVSv3WwWiRnOgHGj/87vOTVEkrYZcrKL4vGPIgvdWd7E7IISGSbe6e4nRQFeinz/jEd2PUw9Hn2Cdf2ncIX2O8ARub3Hik+azt2Cd0DlD6oRqSQiM2wg36to5MUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726653304; c=relaxed/simple;
	bh=mIsFmPNF1WsQ90uQuJHjT8XHiotMUZdUbTD19LPGRVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jSfHuItvUVs0Ow2g7BNhN7jAv4e+IBC+QCIf9mNkqOrFwsH6gFlBhdI6vg0UkzY+ALq3QGEaSzgUy3bVxELs+mYhc6m/WvU3MZ4sLv3Rn/R1sg/Yr7EJmQdffTS37l6meASfcSZDJ3LjCKArxsSr1/q+KmjBUNx4H/8ale22Ew8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=NVx/Be0j; arc=fail smtp.client-ip=40.107.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EoShRBzApfqe6hvPlsSp7J49HBHHkD2tyVRqtwR+oOEumBkLXvkrh1CofDK2Rjcs0BDcZhofMfb54uzy2mzX7uZ7bgUo3v/pmyl2g6gi/mb3b8TPfzki/4mUZasPR50YpuhE8tqdhWym6Sdphg6T99ZiTSALsrX0DAIrapZvA1XFXnZtuvxYuxrArTZUHKmBgvX/LdY1fxr3K31VuvjJy1vDtdXAlPOm6lXFnr9B3PWBCpvWjKoL2YHyvRLj3oMwp5XJBBAe9USaWjWIkWg4zwHNyJkG4e9QQdy9uh2QWCjJarPzvbt0rTxrejkMca3/D5DlOmtEMXy5Tz/xxT+0RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82UjMnDviUCfoXJpruXdvSFIJEpdlnWeojGSnk0G3CI=;
 b=sVIftR+mVjKQwdgTGylNGnpLnpNJGAOTJIIS3c8RWCXi+pqpm7rlkAoNU5ZB1a7N3kYX9W4c/0FMT4z7DrvU2loTOkVdDeWYF3KWAhPCV5PlFyqivDCXnJBY9+KkC4GVJNJbCEI7RI/e6dTq/xCDF88WixGYSRhKjO+LieJS2AQhC+b/Die5AvcaeaZr40OVJmP834T7Xmzwo9fLys086yGGKqgFmf0NlpH0KGpGh9KiYxSE83NRGP4wJByQDPx7t8un8PJSqi+bPFtfKPHmLtFpM0x14YXTk8tHLROg18yhLiNgXB/2v16ggOMbsXbMJJvywPO6IhH6auJItw3iig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82UjMnDviUCfoXJpruXdvSFIJEpdlnWeojGSnk0G3CI=;
 b=NVx/Be0jCVjU2EJ3DlppFWKvQiHb3LAbi66f3E3ScF3r/TSQ87wG1pqqbeEe77GYhZXRNNpdIshc/wDFFlGfDJc3rFLf3/8NCx3oeFLzHOjXNC4Gniz7nrC0zj8lZOtlAkQiIdZ5Lhk3D0jeSJkGmvjruSoh+SYn4GUiz9pF9b/i5nAw+bYjm+2cGXi6QZU5XWEjjKB9awd9lUuVUPXiTTzI5G0cfW4xE0ApKmTSzceDLGV6NrF6StEGA922Ii4DNl1IFaitWxpNegpPIltbFeWjWHHSIIqAE8U354wQGuI4PEnVUK7lSWRcmNBtIMOWdiUALXSugT2INE/O6g6iMQ==
Received: from SG2PR01CA0115.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::19) by TYZPR04MB5608.apcprd04.prod.outlook.com
 (2603:1096:400:1cc::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Wed, 18 Sep
 2024 09:54:55 +0000
Received: from SG1PEPF000082E4.apcprd02.prod.outlook.com
 (2603:1096:4:40:cafe::14) by SG2PR01CA0115.outlook.office365.com
 (2603:1096:4:40::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Wed, 18 Sep 2024 09:54:55 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E4.mail.protection.outlook.com (10.167.240.7) with Microsoft
 SMTP Server id 15.20.7918.13 via Frontend Transport; Wed, 18 Sep 2024
 09:54:54 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>,
	Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Noah Wang <noahwang.wang@outlook.com>,
	Peter Yin <peteryin.openbmc@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org
Subject: [PATCH v2 3/3] ARM: dts: aspeed: yosemite4: Add power module and ADC on Medusa Board
Date: Wed, 18 Sep 2024 17:54:36 +0800
Message-Id: <20240918095438.1345886-4-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240918095438.1345886-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240918095438.1345886-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E4:EE_|TYZPR04MB5608:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f6c87104-e1bd-43a7-a5e0-08dcd7c7f2e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|32650700017|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?riBDxNBfuY6P+HW0MJCzSZvDWwb2yoUQH5AJV3+HnJkUg5Qp2NQEoybUn+1m?=
 =?us-ascii?Q?84gPcrXLxUQHOc/A84ZHO4ff7Tb6hlNCNL2NOImUFbQHlTg2OMONTikPUqZA?=
 =?us-ascii?Q?/MW0XIxCaxuuwW/Yxh/YRRfFL5KZjr9vLX3239zXTEeky2lYXepi4PC2T1at?=
 =?us-ascii?Q?/vL7rNcZycvY5pCq+F2z0KcyGgFk6nMZRnxOrxuddPXKY5m+0Azo5qqIW9lV?=
 =?us-ascii?Q?9ugKtwtEgC6ynuD0Xdonvvq1WoMJvpAkfTa/ShDWO65lKS6mdonthDvA0gi9?=
 =?us-ascii?Q?d8fwSgR01X8IRqD3tqeDwCSLsCCpACErK1kz/9tus8gx24UVUCuv9moYRuHo?=
 =?us-ascii?Q?UwB8M7meU2KrfZ6zZyWwD+9r4e6KL3O53oIt6V5Z1118mbeuNGv9LvWJwgxl?=
 =?us-ascii?Q?gkjIQ4+9R0nPItWmzeVVntfL6dYlBmTJZLlsAMt2HDyT69pUxa6Eob18bM2b?=
 =?us-ascii?Q?hqicHw1c8vw6u8866q6NRAzw9OyLbr9VriiO6JuRw9890N20aW6/nCu3aE//?=
 =?us-ascii?Q?ZCctluYOeMopEaMZbWz2jj+3SZIhnOk7aSZAH2XsfLTPCmurNhdqtCk/utD4?=
 =?us-ascii?Q?EzqduVFFS+ir6bdnZf67PRiKTu7LQ8xCQOaWi7ZenqIIlcGZChA8hiUK+rr+?=
 =?us-ascii?Q?iA0ZjLJpdj3No+xpo94ghEYAsylgo3d08H2Tt22ZT9UPfmaSbn3gYCdCNZSd?=
 =?us-ascii?Q?eV/g4lbYYUBeNIXLwNYauMp6OlFWsWCMzRlyYD/8tDdsmF/ZURdBdVP7V0tD?=
 =?us-ascii?Q?KFF08pwYovURm861ztxvHe+WYhWleI0YKrUVox4PcwoHRqeXJQCT5tQXhphz?=
 =?us-ascii?Q?g87G1BrfI7gkev5fpw7ygV9G6Mt7MLu01bSDdHGakEvowrPFznhIj/opWUyY?=
 =?us-ascii?Q?ChyNC/qvj+UCKUnOQ1qL6+inUg33ugVHEZGnTqfqthJpa3IggsuSFuB1t7+J?=
 =?us-ascii?Q?1ZTvGbsBFmBU/t/t/7L+FS21rst+zxfJhyUiPeHzg8q2/zIFEsHEK3J5WpBZ?=
 =?us-ascii?Q?SKj7OR0c777sSk4O4QHFHpQoqSBT5y8GgyV7UPxNGVdLQO2nlJ1KcRRxkHh1?=
 =?us-ascii?Q?/5z18JiJM9dPvDUNigvk+MUSj88X2PMatAIjq1GVOmmjvP45TfE1eV2FN7Nh?=
 =?us-ascii?Q?7PvpxybWQS1kAHYq9iMsX3kQn7OhFsaiF0C/qmLOujKZlHKX3dmA2O9oaaj+?=
 =?us-ascii?Q?LrWaNxQIK1Yqo09FNJ3QRhngr3eofGYhJkxmZsSruviJEu/Dg5XKSHvsU6xI?=
 =?us-ascii?Q?lbSwY1D5RtgOA0TSET+6C1DH053qQ5UrUOOZguelLaWSPbgZ/LRyRZaJ5MWk?=
 =?us-ascii?Q?LhcJjPMN4JVybPjfKcdOCtoUDai1ocb/ULdq0UmAx9MW0Q4NhKmM8UjHqMSZ?=
 =?us-ascii?Q?MqhZ6qDmCYb7lOjjfYyqyUxfQiEUeCr0UGtyIKlAVCr067Qk/7xbNrkLxkYP?=
 =?us-ascii?Q?Fz5luEZDo3keq+ZA06VZ3JUWr6cl6jF7?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(32650700017)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 09:54:54.3262
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c87104-e1bd-43a7-a5e0-08dcd7c7f2e1
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E4.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB5608

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Add RTQ6056 as 2nd source ADC sensor on Medusa Board.
Add power sensors on Medusa board:
- Add XDP710 as 2nd source HSC to monitor P48V PSU power.
- Add MP5023 as P12V efuse (Driver exists but un-documented).
- Add PMBUS sensors as P12V Delta Module.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 45 ++++++++++++++++++-
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 98477792aa00..e486b9d78f61 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -284,15 +284,25 @@ &i2c10 {
 &i2c11 {
 	status = "okay";
 	power-sensor@10 {
-		compatible = "adi, adm1272";
+		compatible = "adi,adm1272";
 		reg = <0x10>;
 	};
 
+	power-sensor@11 {
+		compatible = "infineon,xdp710";
+		reg = <0x11>;
+	};
+
 	power-sensor@12 {
-		compatible = "adi, adm1272";
+		compatible = "adi,adm1272";
 		reg = <0x12>;
 	};
 
+	power-sensor@13 {
+		compatible = "infineon,xdp710";
+		reg = <0x13>;
+	};
+
 	gpio@20 {
 		compatible = "nxp,pca9555";
 		reg = <0x20>;
@@ -321,6 +331,17 @@ gpio@23 {
 		#gpio-cells = <2>;
 	};
 
+	power-sensor@40 {
+		compatible = "mps,mp5023";
+		reg = <0x40>;
+	};
+
+	adc@41 {
+		compatible = "richtek,rtq6056";
+		reg = <0x41>;
+		#io-channel-cells = <1>;
+	};
+
 	temperature-sensor@48 {
 		compatible = "ti,tmp75";
 		reg = <0x48>;
@@ -345,6 +366,26 @@ eeprom@54 {
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


