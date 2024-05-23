Return-Path: <linux-kernel+bounces-187148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0528CCDBF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBC791F2183C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 08:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC4E13D274;
	Thu, 23 May 2024 08:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="Q6AKZOCf"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2052.outbound.protection.outlook.com [40.107.117.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B69B13D24A;
	Thu, 23 May 2024 08:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451447; cv=fail; b=cyOBfjZOSJHcuhMDz3Ud2rVSU3Ft/wpGORvZ3lvWCyqP1oakWeqAhDp9m3HjEZozshFQkCJT4FCDms2c30Cqf/u65oN6F82R4moyrXkYwFiSQH6fPXn/QXAMVb0WL9ZmuZ11hm2ePIrsZCtfs1neUA7gha7AFWw5aBnjMjSPZR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451447; c=relaxed/simple;
	bh=aiaTf8XPpaA3BScB6mYDXX0MorBG0OGd83cATmJc2GQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uay1/AjR/Fo2NYeE4sPoIyMsnLEbOkDKgLj8IlIrqQ+NqH5Q9uY2ssPj0ZxF1A/gL/tbP39ZwZO268kX3g12WzeUszc20Zrav+1MvbRVxzQkqrupNAad4ZZSeSZSbD1+HXVVjBSuMFP+4r+xSzYJNFG22C/KUt7UsKwIvQ5G3zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=Q6AKZOCf; arc=fail smtp.client-ip=40.107.117.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6IDZQpxIRXVXzuhqZ8cuMr14Gl9qoazF4s+i9qtvZTgAn3QFFdeJXPgjMA47fjw88Lq5YUPoUYuLYY65bke9F+58c+YqNu5COtNoLOvy6oYoregyPZWqu5Au62yFNm48Zmc8Kq+u2mjCuJiXSsknGPpFTw8yCIounuAF55MoAVmwkvQU/lUE1kfTHm5z21gMmkAzQNzfzn6Ee/FUmqcluPMW80r2qGZY3oO9ceUKx/HTP0DMHTFTWbEtS1nowFw+CBPYyHTGDvkNrWQ8JRrAEQgmDTt2U08/wYZz3YQHSWpQkvOt87/czNIN3DOvNJMhXbJWAFl/bBR297UP9VlRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DIe7675LKkKmPyG6VqKrZMsMV8GiNtMS1alBZCvnz8=;
 b=hYCNFtZWJjpJSNjMf9dGB9XWc1KeVHXm6fSgRNKET3g/pFTk6t/jN1FixpDnDsuBHDAj5EvPQXIMmCvHj3jBHMxaB5SHr+vJLd9ed2YOGEVDCiYKqMHb/hNoNI1nijW90TCFs3PF/A7eBHpfQ3u3utfCbsR2Il1F/H3GddE7CwHwgVHV1OnvzAu/bmzDC/gqH47lkbWaZV4/UfZZnhmt0H9heA5H1D+EaraPYbsj8xUshYRSef2Rm/KepVbrglfBMyzD/V8hXo9/1EoYgSzmHsZwPIOIz0hDvalDJUSk8ZCeQ6sogDd7ROm+ZpjxML3l9E8FdrL/QroNqa3B1pgydg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DIe7675LKkKmPyG6VqKrZMsMV8GiNtMS1alBZCvnz8=;
 b=Q6AKZOCfIQHkZV2miPwifTX4HAxo7kOkW9gflC54dRj7mTInwY9wUFmI9VVRIsaR21HzzniVITx2rho/n9oMrTkSTnqJsJN231Lq8NE48jddDonCc7avAWOBJG0rUAskvQjHNqZXPk/calEPHuQnIsaM8mfXoJ+XuV3ivdMweSkSsOyeJGOnPeyhE2sywcNarXXV8xQ5EjNpzQMpZ3BnE4dRZ+DJYOg3ocQy3jDMny6Zif0onnV2OAhOK48Gb46sFmFY8d1A/gUQqdpROyom9iP8JuXmSoxgswNzXsyWZIH87kzD9RgvzINyWG0/e1NoWxqXZtX74unSWaLSB4XYuA==
Received: from SG2PR04CA0161.apcprd04.prod.outlook.com (2603:1096:4::23) by
 TYZPR04MB8054.apcprd04.prod.outlook.com (2603:1096:405:ba::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.22; Thu, 23 May 2024 08:04:02 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:0:cafe::fd) by SG2PR04CA0161.outlook.office365.com
 (2603:1096:4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Thu, 23 May 2024 08:04:02 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server id 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024
 08:04:01 +0000
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
Subject: [PATCH v8 03/23] ARM: dts: aspeed: yosemite4: Enable spi-gpio setting
Date: Thu, 23 May 2024 16:03:08 +0800
Message-Id: <20240523080330.1860074-4-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240523080330.1860074-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240523080330.1860074-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|TYZPR04MB8054:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2782b897-adc1-4cc8-b169-08dc7afee8ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|7416005|376005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4dh3Q4+cBBRQONdJPgXIjJFOCWsA4VELgOAfGmBCluyBndyFXpYCuxMeGFX6?=
 =?us-ascii?Q?7evwd7q1CObnu4DIP4uI+Ymq/3BrJ9SPCFcDCkTUMCzYZa8OQmLQdKGeRhC9?=
 =?us-ascii?Q?jUZCP4s2U4iOwVfWX9f+r9zbbSyQ1gO6mS2mMws1IV2l+NDSaUoArr4tP9Y2?=
 =?us-ascii?Q?DKM2bHveMc5Ilh4+7Fn3aE8piDdl+rmtPlFVpahpibX0DjukZtlNDIahxo+j?=
 =?us-ascii?Q?AA45TgkFmZZO0/xwobznTkQTFB3vovJbzdBa3fi1hPKB9RWyoLrzettBdBI1?=
 =?us-ascii?Q?UZmPlbP5UR3lOXuIzCsIncClCAI/7tSx7rbRy9pA4gj3y+xzLdfSeyJDVYXU?=
 =?us-ascii?Q?5qxfgrVosoS0zS5Hkzb0pD5G/nhInMLnVziWdNCbiHLBi1nQiem0/4Ldryjd?=
 =?us-ascii?Q?ChM0lb+fNI6ffW4gfiNP/QmJPVcRena90bJrugxWBeu9fp444soVH+cOIMqB?=
 =?us-ascii?Q?JCKf5ZwK6kgMP/HY8PVEeKMP2G1xfy0Bg1GfV7vj89Z//ZD7K0bfe2zG+8Rk?=
 =?us-ascii?Q?3vyOrsEY113pGrT0G6dAy8hEvnhrMBjP92Kkcd1adxGB56Oc9w0RpQ3cW0U2?=
 =?us-ascii?Q?CkBE46zNzq3V5oZytzygOv35WSxwDAiYbIci2mB+/F450SjF7NpHtH/Hh01j?=
 =?us-ascii?Q?0QcoyWdv38p1paBSdyxqrrM+GOig8rMRWwh/psXm3RAooqYXz2bL4CZIXwXW?=
 =?us-ascii?Q?5rj6U+66SXB8Rh+YpR6X7Q6QcgT6FtCFQ70kP0MJ4axx5iKGSNwOLhBWi4jG?=
 =?us-ascii?Q?/S41D03BaSu9sA+56BgVd0SEyx/e0hA6XnvZqzx+5tOvOIxGMRfHcnLw3dgL?=
 =?us-ascii?Q?lJtPuDxCTLovi9rIX7a8hO4QvJsTCD1F5OaDzsHsK5h+7u4XzWQ4T+2VtYbd?=
 =?us-ascii?Q?AcyPMH1MF0BbpYCSWgNVZNmuYvpso9O2YBPpPV/uEMBztoGevuzNKVBPuYxM?=
 =?us-ascii?Q?xMSM0NE5y/cpaMUpneyV/KroQp/Om7RLwxrOQl041MkQbTURJP+LbvFmJpxH?=
 =?us-ascii?Q?So4XQIIfhSKMCF3urA+kj0iix1fDUrAWx3tWglMFR7i591l7f+XK/X09R075?=
 =?us-ascii?Q?kYMDMeSPoB0JYbCP4n0XuH2IuJ5SRwnk8sV0W044CVGpk78caOEIhoeZlxsa?=
 =?us-ascii?Q?hbBt7q9//Q8hA6mOSt5DQWNXtPPzssLb38G/ziMgUDkFKBJXF5czvVUeMTZk?=
 =?us-ascii?Q?6gGeK6P0785oMxQmNjtdqbuEFrewsBQ07xWWC7Yy5KZyAtSWysrWED0+HqFK?=
 =?us-ascii?Q?rOY0BfDfw0NYI99aTvVCwjK1cAa6PMHB/lbtp1WTNkQq8iosbnPzfRRWYEST?=
 =?us-ascii?Q?AnvXS8mn0UEXTWnFqra+tn5AhS6BZbz0d0y0lMrtyQ74z4NCcQA5LgCdw1Lk?=
 =?us-ascii?Q?zpV4+go=3D?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(36860700004)(7416005)(376005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 08:04:01.7184
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2782b897-adc1-4cc8-b169-08dc7afee8ad
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB8054

enable spi-gpio setting for spi flash

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index dd88be47d1c8..effc2af636a4 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -53,6 +53,24 @@ iio-hwmon {
 				<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
 				<&adc1 0>, <&adc1 1>, <&adc1 7>;
 	};
+
+	spi_gpio: spi-gpio {
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-sck = <&gpio0 ASPEED_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
+		gpio-mosi = <&gpio0 ASPEED_GPIO(X, 4) GPIO_ACTIVE_HIGH>;
+		gpio-miso = <&gpio0 ASPEED_GPIO(X, 5) GPIO_ACTIVE_HIGH>;
+		num-chipselects = <1>;
+		cs-gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>;
+
+		tpmdev@0 {
+			compatible = "tcg,tpm_tis-spi";
+			spi-max-frequency = <33000000>;
+			reg = <0>;
+		};
+	};
 };
 
 &uart1 {
-- 
2.25.1


