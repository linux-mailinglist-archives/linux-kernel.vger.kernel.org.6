Return-Path: <linux-kernel+bounces-259825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1AE939DB9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A091F287230
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF7C15444F;
	Tue, 23 Jul 2024 09:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="JG2o5t+r"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2079.outbound.protection.outlook.com [40.107.255.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37EB154423;
	Tue, 23 Jul 2024 09:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721726682; cv=fail; b=jBQujfHUYBXr5zA9CD7jz412MvFxXVFRMurRANpxXJea+WyF3ZdYuH6zswCLd8z+CrDor2O4dYA9fqmkPCqzl/6jfi4izXbyNo4MlDI9eJKldI5O3YyLUwLbWRShRaWgWJWThuJS91nXt/br9pASzFyOwPbuallwptbaJer14Ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721726682; c=relaxed/simple;
	bh=CiwkhpR7VbJ58wUM7Ct53vT3yoEHw3YDSjBZX8BpqGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GR1WB3gKe20FeZhycFilpmxgdNCvDA/UXdkrU7qv+adFKswbTBizuaQwCRiA+AqXKkXdjzvD0lms0PLFXHG9+kHraRYfR4YYrY1eRsEQ7d5IdmZXORVV3Y2b2+m9I7dpqtofx4Gmc+++qTFSPRqoADqVQ5GiHQcTAbMB1/TLK2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=JG2o5t+r; arc=fail smtp.client-ip=40.107.255.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sDus9c8x9qqfoizVgoAHa0kTDQiyTXWt3woZD8Q4WvwZJCz2hDnpr9sxzo3QbnNlMkd7xrXmoD2aIAS9+O+ApA8PAsYtSGB95i6SqTsQhWKvz2N40ni/QVyBMcM8gk/FwlwUAiiGzv0wVkCHHQM6kl6Nl6fRV7hY+Xr2OxydjyT/BecQvvpX7TACDrRpKjP3NFOxud1Q/RTVe/0YNbmrobmT2Dw7x1SpnBuEaWIgUhzeQyBqjyLcwOx2fu0XOWSWbbgjL7odUhCt7RCzAXj/OMRktuoNpU8r1fS65rE9dYJ1vS6W0Y1/DKWNHeDOTxwCLQ7DAOpoFhCLTYulv5JSwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrtsG6giv8Vmzw5ONrss4xcIYIDPtDHUY7eE3zbiJjM=;
 b=DEgIUevDOA0P3+oRPbfBz64oZBPatvjDulyhy5mjo2NR/z3v1qkepj2TPIDcyOEXFoGhQnFzFGa6bZ/Ys7yviDkvwP6LwNt350IoyhQWneL60f8NInJ+ngu6xaLp8EtoBXTbEvLz8zI2+DH1A43Khx069JAcJPg40WI+kZEjeGduCd5jTRsVy5/+x99xglIPcoKjYNVQsZ44cQui3+c2HVUGpB+aDM5I8j4Pl18xyxNJdNlG5WVWwhwWk9BDSZcUtWS635ucFEuDf/+zYUDkQnr44XDQy0Z5FQFNBjEIU3TjvHjxS3VWOHfHNQ12Ob0VnqqjLMMlsJ//HZGu6CL+7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrtsG6giv8Vmzw5ONrss4xcIYIDPtDHUY7eE3zbiJjM=;
 b=JG2o5t+rxUlrVhABJPO7ARlqix4oq/bDfIAFFhN2D9hAhCKnX7eNPlbiXdWjw1cEP2TtWMnXX8i/Pv/8dO7gFxEPrPtrGCc/qzAcU0Os1NNoUol0/GRQ4pPHixp7IUDq7KBwnAMi9vMMHdfdkCRa+SOXNBYpruKN+hQrSePJnhWEUii+bHdNm+N00bhmQ1nnDudybxZM/KCohVljLuirrijA450AWUjQDNVJFb2l3xxd7bAujq+7CWD0nhbrxWceA+fxWbL8lZqkwlAu9pECnR2RFA9asyMAav6Jb8oXJPGdQcp7lOkpYhx1dyt+G92eekjjR6zlM7kLR3RdvwHniQ==
Received: from PS1PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:300:75::19) by SEZPR04MB5873.apcprd04.prod.outlook.com
 (2603:1096:101:7c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.9; Tue, 23 Jul
 2024 09:24:35 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:300:75:cafe::b2) by PS1PR01CA0007.outlook.office365.com
 (2603:1096:300:75::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18 via Frontend
 Transport; Tue, 23 Jul 2024 09:24:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.7784.11 via Frontend Transport; Tue, 23 Jul 2024 09:24:34
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
Subject: [PATCH v11 21/27] ARM: dts: aspeed: yosemite4: support NIC eeprom
Date: Tue, 23 Jul 2024 17:23:02 +0800
Message-Id: <20240723092310.3565410-22-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240723092310.3565410-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240723092310.3565410-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|SEZPR04MB5873:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6bce0241-1dd7-4560-41d1-08dcaaf9446c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BG3AKeoKii1qEBwY1UvNi1jiPiEHqPZNK+iGw50FFV9dU+Xd7IQk+bvuwZld?=
 =?us-ascii?Q?Af4x/N2VQ/MRgT6rRu9WgPwkVVudCB4DWTgMgkgEFEA4kjnYtKQ9TxvV93A8?=
 =?us-ascii?Q?xx3ACZ45MfBqv+nWn/UNyMDMM3+3lbmpauRTxoHpIgl7Am6CgOnL+yZfplcT?=
 =?us-ascii?Q?6NRCr/J6bAUfVMpqys/epNWqS7UV/joNY6aTZW/YlYZiFUuY6eEjvDDeeu5E?=
 =?us-ascii?Q?utP3Gwes46RCiEV2YhFyt5Y/Rx4VufONOb9ouTTzR9AfFxl8T0ZmHNa49kKf?=
 =?us-ascii?Q?foHJHhBa/WwUSoSEl5n/AeTvdc/3NMapSjLH5SG/LV+DLT1NcT384JA3V+rR?=
 =?us-ascii?Q?cI8otbwbHIACiiyQ08KkoTql/9fqCScJUH56LzmXwsvlIziyE6XBXgdeN8HA?=
 =?us-ascii?Q?G9I7KEQVJ7/dqnRovtXQFyX+ghXbb0w7AzB4LT7dMzU4T7vCv9gO6ZCJwCwg?=
 =?us-ascii?Q?DeI49UaXNdEIwbyF0qF+t8AB/wT7ypZj0XO4MvmXYmOH9q+wrgQfYvn/y3QU?=
 =?us-ascii?Q?VYV5CzFwbFBBZookZ2HxwxKgml/gE614yVtxsbM6xiPt/PSfhMGfKBG1V5uR?=
 =?us-ascii?Q?bJ67cJlogfMTVdkaLcxR83iamKi50mHoVRGDLFS0wPtjJNa6mY5B1ujXvis+?=
 =?us-ascii?Q?m+qgrxxO9j9U3A6GYV1wiK4V3+juPBd8NAzVYM1vQrIMMNWHy/zRctwf/GVE?=
 =?us-ascii?Q?UU53Qve2Zwa8UssZRheXREkvTR4JdwlYQoux+XbXYUWYmJT4FsRytJt8a0aq?=
 =?us-ascii?Q?UBYazu1iGp0tg1gzP8qFEhLq+ZP5a4NGKzyEG4XQIKra9MjSSctZfmz547Hu?=
 =?us-ascii?Q?f1aLM9dz+hZJcgXTW4V1+OsXs/WGQq0fwwlPtSjlQRSx+MJYCDuwSI8uE8jW?=
 =?us-ascii?Q?rNXI19hQaJEWN+EkxzZ0V/nUQwbZ+X21I5djCzWscQu0UtfTOMPnTINq/hL0?=
 =?us-ascii?Q?JgIQ+AknVleA9Dn8ZOAs3fAo9mu26eW/0FYUFe2nmkjqSDojc/JZa3GHa8YV?=
 =?us-ascii?Q?Uke1qv/O+gbmIB0S3JFw39hJ9SJWW7BfC4SpiFB8rB91knQwMTYsWRYZ1k0w?=
 =?us-ascii?Q?YZO8++mrL2wjPiN57MLehLGNbuIa8NyM+hzBoXsSBDU9M6JeI4aJSpIuC26w?=
 =?us-ascii?Q?Ut8NA+Gz+DsFejhDfKscfaScGFQeUGk9DkIsj05qLZ3sdwqOe2v3eUw18EY/?=
 =?us-ascii?Q?REG23vAyDHZENSZbdYfK5YSxc+D9MT8DQUNkbZX8rWGSXEY1vhRuTx0S4Sie?=
 =?us-ascii?Q?d4opruOS6moczZW/80g8V1kHpPgLQiHrzYBtyHNFrILu2KVANMs6WBLiuV5J?=
 =?us-ascii?Q?VZTDbouIxxQHtpJbQZ3X8DE7dtafcjsQdM/pYW14EEyMoBEMVNipsi5UfDHH?=
 =?us-ascii?Q?KkFn+BYMwRBwJ2xALDQy1ISi+ENYYrTcyB9xKN7RuwKq3nZYbbvWRiO2jSl6?=
 =?us-ascii?Q?87wwjIzSlrG9Q3rEgQev+bXwmPeRcVRt?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 09:24:34.8791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bce0241-1dd7-4560-41d1-08dcaaf9446c
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB5873

Add NIC eeprom devicetree config

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 49500db53a13..c2994651e747 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1338,6 +1338,11 @@ temperature-sensor@3c {
 				compatible = "smsc,emc1403";
 				reg = <0x3c>;
 			};
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
 		};
 
 		imux25: i2c@1 {
@@ -1354,6 +1359,11 @@ temperature-sensor@3c {
 				compatible = "smsc,emc1403";
 				reg = <0x3c>;
 			};
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
 		};
 
 		imux26: i2c@2 {
@@ -1370,6 +1380,11 @@ temperature-sensor@3c {
 				compatible = "smsc,emc1403";
 				reg = <0x3c>;
 			};
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
 		};
 
 		imux27: i2c@3 {
@@ -1386,6 +1401,11 @@ temperature-sensor@3c {
 				compatible = "smsc,emc1403";
 				reg = <0x3c>;
 			};
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


