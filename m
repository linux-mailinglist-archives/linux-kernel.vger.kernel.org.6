Return-Path: <linux-kernel+bounces-339846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D38ED986B51
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 05:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD3E5B22D5B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 03:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800CF17BB2E;
	Thu, 26 Sep 2024 03:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="eUK9wVDa"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2073.outbound.protection.outlook.com [40.107.215.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FAF170A3A;
	Thu, 26 Sep 2024 03:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727321314; cv=fail; b=du25Q9HqY9lYlcVMF8WuvMKLdTnsnAtiykAG6SuqWUGWknu5uYpeepeK0hXaRNWGLE9K2FO8jogc2l1x6ma1V9Xui4vUEaPKUp08JUjAzHRep9bDUz7rnDZhX2+gAdv+KocyiQrEbeTJPNIQMcWqBN2QKg/WzDBJzBOzTxsS5YY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727321314; c=relaxed/simple;
	bh=LMTUKfaPs3TyUF7nbx+fBz6dvf9OJsmqic7VmsSLvTE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QeUv9MAk66HWMpgyfG0tlgxFAhC35AqRUQwwlxA8E61fzK2VLhtgjgIEMi+8siParzYzTlUl0gDzt9WOu7+ljTrITepx4oNmLjt9Jt9NLqeUvYfAlav7aq+gzCx9lNbAksSJNoCZtKwxspi9GX3nc4gx5TMTiBRkhGTNkgKdhHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=eUK9wVDa; arc=fail smtp.client-ip=40.107.215.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xYxNb8IM1q4L/BvPQMmbG3fSk45WGEbMlqiQUVYAPp9wCmiWfGCCjBYSBmzGhCiXQQjG/Y8BF3W/XhKVG6uWg5jK8LZaFC7Ij0TEM6Z88BIUsjN28cuPdluix3KpyF4FeMKo9lZ8VNraMDArSZdMyLIQYloYXgBFy8o+2MKu5awgdmg+Q3qVkM93eno1qGTw7IDOheIlzGJokIaR1uHLbKI8G+OUYDyAuSMXQjc7zVkEnBQsiehdNtzOZFEgoNRIjaiLvjsOZHNRocx2y/MvFAEXbYAKCxYIwHvy27MJKQnkOpH/Lbjs2K8fwFykAFgWBGyshuNaWs7botF72uFyww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkhNm4uJCDOL7foCeSpsrgWnToIkpcuRqyC+fDGW2xk=;
 b=UGWZUCiBD5Jughd5E0Z+rekpmtcxPU43lZrrPiObc7+9fM1dSY8KpdI4enCajI3sEdp0kRyOTcVjJzvf51nrn2xoPBGBBPMyi5h4Xw9Bq05/Kj9gEn3LtogQrRNSoLv/ifE/0nNF7uWLVGsb44epSfN3D5erRXzN3qpO2UEX5PHG8UKiPZ0OZGisUVeq4IqzPxnydDng52gh9LO4YaCDuVmO5KUlJxpS6qymKWNirn+LzyhBkAnXku/1UGPLQmGwTTM1ztjECOVgzSUfav1XRQ4z2iwBC4m6tWdJ8O+i8zyzllevebwBXzgvJvUrzApY7ewsfTovCFK49c1v7ZtEBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkhNm4uJCDOL7foCeSpsrgWnToIkpcuRqyC+fDGW2xk=;
 b=eUK9wVDahKrmB0NtEkPWs5UtOPJIhQ64ivSRsMyQ/xXAnHcr7vZDhl+Y0ic9sz7i8FrTBuangxGSjDvfGdBZKIEPJ7kZ/yfZwL1v7AP55mS2U9COK3NHtCUq/iz8xQnYA9L8Tqurv1EWjExUewodUp1IftW7gXLn8QacoTcel6lu52ZxK5dnozLUDYeCQv1Ej7/3LjLKNGHX0dWaCiHq73FxQhfRusF1IuNawEw+bhRb7Ah+ZmG+dB9w/vOIDuD2+XRp6vPz5aQqaouKR5VeoZPrnMOsWQUGN7uzPSk56PKrHg1UAVkZIG3aGJ1ufrYO6F9iozRbMYMOkFBmPnXaJA==
Received: from SG2P153CA0013.APCP153.PROD.OUTLOOK.COM (2603:1096::23) by
 JH0PR04MB7678.apcprd04.prod.outlook.com (2603:1096:990:71::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.20; Thu, 26 Sep 2024 03:28:29 +0000
Received: from SG2PEPF000B66CC.apcprd03.prod.outlook.com
 (2603:1096::cafe:0:0:57) by SG2P153CA0013.outlook.office365.com
 (2603:1096::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.5 via Frontend
 Transport; Thu, 26 Sep 2024 03:28:29 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CC.mail.protection.outlook.com (10.167.240.25) with Microsoft
 SMTP Server id 15.20.8005.15 via Frontend Transport; Thu, 26 Sep 2024
 03:28:28 +0000
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
Subject: [PATCH v1 2/5] ARM: dts: aspeed: yosemite4: remove led gpio pca9552 on fan boards
Date: Thu, 26 Sep 2024 11:28:18 +0800
Message-Id: <20240926032821.4171466-3-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240926032821.4171466-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240926032821.4171466-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CC:EE_|JH0PR04MB7678:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c91f758b-d054-45c6-faf2-08dcdddb4a15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EYahwtUKBKXTWc24CbyD9tV8ihKaQ1ULGw8WZjrQTbBXRmbwmvGfywu5Ilu3?=
 =?us-ascii?Q?KVUYuzpE1q61xlyvnEm4za6c7VM//tvYNMJ2wsk0U6QjJjEbkI1l8wO2MiC8?=
 =?us-ascii?Q?wVfOYVrao1nZctQtLJNVASNg81q95LvsVcFFWsfA2YQ4MfKFOkZ3tx6eaLu1?=
 =?us-ascii?Q?iiLn2ikxyN9kzCVWbnZ7q/FfkzR0oC3GPeH7HtpVqgszA70Tgv0RkQb4lc0R?=
 =?us-ascii?Q?JybXBEDu9kQUSf0P3m60OX4/pwVWU+kPUKpEJsQTpY0VuqdPk+zZRkQJSmzl?=
 =?us-ascii?Q?fRLsU70J63C27hcCg4vHOaSMHUPpx5ahH9TboxkOo/zPI4Fj7hFtSc63OKsi?=
 =?us-ascii?Q?5jgQejekLsGxxOFF/ZcjppQG5CHlMlvhhZSMYeua5jG5rBLuk/6ew03ekBed?=
 =?us-ascii?Q?JoYKUFBOwHm5KuHe1ZcVEM4tCLBqAXVpJVpFlv9SoyxHPhzyUEoOHGhkTV0d?=
 =?us-ascii?Q?0H0yeN2rxt/o/1bJ7wVFCmCaV9p0vb/HkyXZfskH7JyuFu39CEUk2XO0Eogl?=
 =?us-ascii?Q?mcr+fWaTqnobmOzufrY6bXW+mW6gNKkfpx92txa+fombJjWPwhFFvKuusb8a?=
 =?us-ascii?Q?8MBREIqoRJCuwlWTcZdBki6AHxKBhqdVPh5UQs2RyDubSmdEr1Zvwf5xAm3E?=
 =?us-ascii?Q?fF2vwtxYPfsrcJ1ndzcI1tLPwi8h01FsXf9Wp6Kh5/EqXVrI7mfnb9Q0rzwn?=
 =?us-ascii?Q?51mIj/eNVQKsuDlqs/klqSsZXLUggMqj+zOpfSeVhmm1WHg4diJDStGucdAd?=
 =?us-ascii?Q?KBZwf+mZvOJj9GLS3MrJvRwd+eagEjVcbiVCC8EUq3sCNspK/eRarLB8vigo?=
 =?us-ascii?Q?+ZZVSZSewjpTIE1trXa12DY02yiL7r7AMPMogjn4431ulVATrqDLV8EWs6Vl?=
 =?us-ascii?Q?s+GNzTFZ7gw1QXqiKshffI1ILnWl+eMxI1grkUtF7HeNe4kimEI785NDqAyy?=
 =?us-ascii?Q?HS0PZQZJZpqu7RTq0YDcclkTHIDx2ERFLY5IlA13HiQSu/OjjnFNPSGuekci?=
 =?us-ascii?Q?GHtGcSTq+O9YKYAdr3hGTTUXDSH4u0TxKHF6zJTnk6OHABzIVq8thddvydHt?=
 =?us-ascii?Q?ka4UNcWATSgCVZvfxOXjITxW7Wl/OmvRdGKKSR8Rw5r70xLuxvjYOIxLGvon?=
 =?us-ascii?Q?1OupYasGbjk7niFKYf2U8j5feczWZsePoTgsHiEQhwOEY/Gn5hHSm8k1HEmq?=
 =?us-ascii?Q?lwYk4YYFbNd2VNrQJkRxvqtNWgXkS+M4+otaXihtV1gbzjVlvA3m/xnY4D3V?=
 =?us-ascii?Q?Pp6kejDlwsbfHPAZr4t5SUYk5QR00qRnSXD4aKyWmaqM2w7M93i5ij1w0IxC?=
 =?us-ascii?Q?Tca2RqF1vzLH7cjMYQd7ekofdO3vIiu61Ov8c8IsT/UM+CQV2wck95vAc9Mm?=
 =?us-ascii?Q?7Uc01mFImCRkJNlUaLKKqJF13014?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 03:28:28.3267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c91f758b-d054-45c6-faf2-08dcdddb4a15
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CC.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB7678

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Remove led gpio contorller: pca9552 on fan boards since there is
no binding document for pca9552 currently.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts   | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 04f6378c2b5f..430c28bdd314 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -525,15 +525,6 @@ eeprom@52 {
 				compatible = "atmel,24c128";
 				reg = <0x52>;
 			};
-
-			gpio@61 {
-				compatible = "nxp,pca9552";
-				reg = <0x61>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				gpio-controller;
-				#gpio-cells = <2>;
-			};
 		};
 
 		imux31: i2c@1 {
@@ -577,15 +568,6 @@ eeprom@52 {
 				compatible = "atmel,24c128";
 				reg = <0x52>;
 			};
-
-			gpio@61 {
-				compatible = "nxp,pca9552";
-				reg = <0x61>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				gpio-controller;
-				#gpio-cells = <2>;
-			};
 		};
 	};
 };
-- 
2.25.1


