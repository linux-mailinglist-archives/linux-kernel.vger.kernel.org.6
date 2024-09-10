Return-Path: <linux-kernel+bounces-322425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 928619728D6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15F4D1F218F3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 05:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EA316C854;
	Tue, 10 Sep 2024 05:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="lmxYR9IE"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2058.outbound.protection.outlook.com [40.107.255.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AED13FD72;
	Tue, 10 Sep 2024 05:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725945240; cv=fail; b=i780D0QPRn2PpOHrw6epPFipgq56r/MypbSjmpuR+QiinFoMAi4VvKSbQE7aCVtdlCEcqBhAwwQRhLMMiOmxiDhWJc3M6pnbBtcmAIgSj+xddTcd/ZxM66w/nTsXhwA4TSS269jJ+vsxIivm9zjUoemdZE+XfkpL4MEK6+NyzIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725945240; c=relaxed/simple;
	bh=MLsRhp8BSLDG7AxBR2//RavxGSTiaHDcOBi3GZbGwpc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Z8EeLU8WrjEX52PjTxHnoJm8DlNnwEeGO2mtDedz8Ol0Qi2AVoxHFaBkCGP6q0gs5Ry3Qv07Ejdf4EpOrX2aOZBiiGUoUQ6ZKEM8RuVUtGKUD6gotCeG0zA7CVIvstXyt0h3ks3YuXvGju+u6HVyM9rDNvU8+dTxa6I65OBgIs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=lmxYR9IE; arc=fail smtp.client-ip=40.107.255.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FP55PAllpecj/ajKIBDS+A+cha5SS5Mnj5IrQ2FMZw1qsUY0upuaOcrlGcg3h7GekOlmv7SdvGe2guyG8/X21uPee5YpK5JjbPbHY1cqmktaJmyjzomFk1dj0kSS8DyHGcOuppsB6wQE5hldTjk/kKhYYk6bCLpi97miBuzf+0ArcNG+TPDt3TeeKA3RkloFLj8RtOe8Jd5YDn4WKAqM5T/BVMK+9iIEtqD/FXGruyRmW2yQQsuioRGIyqk3cg37unNgPxlPnoDFYwU6PVm7ya4sg9aTeyGHO8vTTpRkTmRvjVKlUpOOhQrQoxbqT2ArzrbTUIKgZHkGr8hwFc3ngQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oY/TWRr07SZO2pez9pWuWd/uW1vFIoQquPFI2Sx+KlY=;
 b=JK6zKwOil8gxSEFbLwu+WZsKuD7x2CJ2Wtf5ExveDx1k6GE2jq2nb9ymEYtTcJzKgbNjtAwhf6spXrZPKCsXQ5nYVQ0h95mHa3/zd3AdYHfhTMmjOm19sbk/tVimj2WsF8xRr9K8g916er9U4OCq40Ar5Q0U6Q2O4AHyax521TK6TwNkpdPaM8S1q+8y5736KHUyex6xRY1D22j9TkkrWBpEqqsHAbPrXYC0wGyvG99BJFD9v0OdZlgN8W/sV86zKR0w7ZKnKacDLxHW+4AS6QHGqHX+VmYsIyPhStSj8/8ieSXEoy+A4N8AT86DsPCdcFVYE5w+mbSjmMHmNeSQmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oY/TWRr07SZO2pez9pWuWd/uW1vFIoQquPFI2Sx+KlY=;
 b=lmxYR9IEEDOSRPCNo6QVUAQDQwiT3kuUBjgwZCJsMdrIwjvA5ns/+SLSZKFyx7aLQ2pCYkRFxsZ2aDDYwQh2rb1LuqckcWNxwiM+IwC+Cw0NV2bAjffU+kbNa4M1/IgkmDO+GqgPiaAt9+n9Ck015138cNAbUnNa79IUUmITnMZkGrs/e1uv6dvQxSY2rzm0fAWBhHWl3kHGfSSW8Y3il1axmAXy774TajERNISZayd8EAGhjZDR44+gCu6GCiAb/wujF1aOsz7z/c9e2pkQjOJqrrVRsMUMmFTR+auhsDOQtUxf+UgQOxIPEkMQ2H8oyT0KpWI01DbA7y3SZ8Uv+A==
Received: from PUZP153CA0003.APCP153.PROD.OUTLOOK.COM (2603:1096:301:c2::9) by
 OSQPR04MB7990.apcprd04.prod.outlook.com (2603:1096:604:298::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Tue, 10 Sep
 2024 05:13:52 +0000
Received: from HK2PEPF00006FB5.apcprd02.prod.outlook.com
 (2603:1096:301:c2:cafe::f4) by PUZP153CA0003.outlook.office365.com
 (2603:1096:301:c2::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.5 via Frontend
 Transport; Tue, 10 Sep 2024 05:13:52 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB5.mail.protection.outlook.com (10.167.8.11) with Microsoft SMTP
 Server id 15.20.7918.13 via Frontend Transport; Tue, 10 Sep 2024 05:13:51
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
Subject: [PATCH v1] ARM: dts: aspeed: yosemite4: Revise quad mode to dual mode
Date: Tue, 10 Sep 2024 13:13:49 +0800
Message-Id: <20240910051350.2580971-1-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB5:EE_|OSQPR04MB7990:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 72943a29-e0da-4183-c8ff-08dcd1575c4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jUXa/b8f6HToZuj/RQhq5vKiTr0ni+xrwEu5R7WbwqJct3EIHq7BKI8SXvRk?=
 =?us-ascii?Q?n3+8583ML/4iQBWa0g1KeuEF9ktYiCqKmC7gCoaD8IjRbGziYXn4LUGM/NfW?=
 =?us-ascii?Q?yr36pUvf4inOd1RDH7qzxlE/FIC83bodACCCK1EO0D6Yi9blMqOIJfT9y8Oo?=
 =?us-ascii?Q?mvbreVKEfBLGmrrmH/ZnNr83so7HkHMO4iSK7Ssg342iZK47ZYifHCatVeAf?=
 =?us-ascii?Q?E9yXNIu0Bhg6N1FnQPDKDa4FOkgeOeCTxpdrPUT6tqLRQav9gE9SMk9wlCJ/?=
 =?us-ascii?Q?wR4f2hs2/8Dy+UIjutZhzs6fKeQNGIT8k/aV4kTnRpGBE+dXu+ozFYZ7eqeJ?=
 =?us-ascii?Q?GnPA9oYhE818jwY9r1M/4UoZYtIlGeHX8vuROd6sy0sP/lgxHfMYtSba7duT?=
 =?us-ascii?Q?04VN9AWRfLZhJBn31IPxtKHzwQbuixcgeB19B+Cm7aJSd3X7xN1KiQp9qrYG?=
 =?us-ascii?Q?lZAItma+OCwPF8h2BdcvpBMWm+1ZS5YG2BG45u/rj1xiuVlQMjy9hKpedVS/?=
 =?us-ascii?Q?GBufeiguuShk+/8c4p1Z/dFk23tWj9OZMtPYEv22Re9QfPXamZKmJvaJiXIx?=
 =?us-ascii?Q?FLqvmlH/FCpvoEYfSP97R99LQ9ZM/+IfvO8mQblg8rX7EVumAGiuaai5/SXU?=
 =?us-ascii?Q?iknda3NKVEEMuoBl3rc6zJDkwy4jz7w8u5XlLJlIl0maq49Hba2hv+agZNe9?=
 =?us-ascii?Q?Fl2vjDf0H8BH9tBMvmKWsjeDlxaSOqF8fDSzs9KlyoTxjV/bVx2ZcwlEml07?=
 =?us-ascii?Q?r0EcrqIhb25JaZfR9siEWLT1IpqHHi8uAVtwHmFQYv/jq50mq43Uof+qr7HC?=
 =?us-ascii?Q?w94nVYwHAZ1HPVFcjqwGbaRbjDcxhP0QgcI1vHD0cjyzubanzhgAf4U3PMFl?=
 =?us-ascii?Q?H7bN9L3G0cnSvyiaxxf6GFfbyIshd6lqRU1AUA0106LhggtVQv7jSCdbjoDN?=
 =?us-ascii?Q?fs73wefjLJj/sWKmsq1lxRzqmmO+8fb3De/aqrbVxb8O3SVFzq885Zyv+O3m?=
 =?us-ascii?Q?hKBRXcso8Jg7GjmkdkPvykbhZ9mBmGfr34Qcuxzc8iDJ7X4BPbsO5qve65CE?=
 =?us-ascii?Q?kCXq+YjLjoQlFjVW65UxaA1u2UClFyLlFG9SQD06br7RfFjBYZC3QxR9ZsFl?=
 =?us-ascii?Q?RH9gHeGGA1bjqaLRAaHb8U1uZieNthYA3LGQs2W6RkQtZ6jjAEsvbUDygjhd?=
 =?us-ascii?Q?6NcJo0+fnezmy1Oe6EbhAfRekWnhpjb8QfhttTYfcUX1Y0jl46YSOTn51Mzj?=
 =?us-ascii?Q?pEAGDZG2D0yTLVaxDkuFOYpNiCZFTLbzPikMAeGmEhO1ixOlkSbH3gFdNGmm?=
 =?us-ascii?Q?51MY3DigWGt88Z0BsGjTKvJ/NRwDTReQM17Fs2MK0VsmTA2qSDBSYpsp6OX2?=
 =?us-ascii?Q?EVPfsqcFR/rx0E3qARBv8bjrjBCm17jcB9pKjDlhaM98nDhUuB6gPDP5T3+4?=
 =?us-ascii?Q?jV6TyC/u5w0o/51gICQPzsGZ3K0k46uj?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 05:13:51.8516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72943a29-e0da-4183-c8ff-08dcd1575c4f
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR04MB7990

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Revise quad mode to dual mode to avoid WP pin influnece the SPI.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 98477792aa00..3073ade6d77c 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -105,15 +105,17 @@ flash@0 {
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc";
-		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <2>;
+		spi-rx-bus-width = <2>;
 		spi-max-frequency = <50000000>;
-#include "openbmc-flash-layout-64.dtsi"
+#include "openbmc-flash-layout-128.dtsi"
 	};
 	flash@1 {
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc2";
-		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <2>;
+		spi-rx-bus-width = <2>;
 		spi-max-frequency = <50000000>;
 	};
 };
-- 
2.25.1


