Return-Path: <linux-kernel+bounces-187256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0D48CCF15
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29D5828783E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B087614F9F2;
	Thu, 23 May 2024 09:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="IM4qHXcL"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010001.outbound.protection.outlook.com [52.101.128.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114BF150990;
	Thu, 23 May 2024 09:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716455978; cv=fail; b=YJyQ8z6KVg2mFwP0fsW43lQOlHUibRAc6iRABFbXOTj9Tmnqi7naqVX5qPe3MoCegniCKWdcJbldArfd8GAmoeEOuKRntfNSq799h+cunp22hJmlfASeONBBthuRj1PNpU0vx9ZEndgDx+Y5FCQLh5NDUW0QN42KYCAWqMmLB+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716455978; c=relaxed/simple;
	bh=tJI+cvMH06IzP+7yRCYlxf6+HolpNLWHXcUzE2JZf+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T9oRpozSCxFQisp0+sbZ7RMAU0HdC+aeQQPROO/QtsoyaQIW2axGx9pX9pGkx4OCtOfivqN5xioZP8MgP1tZtKn5HiVBJAU0MnPSc2eYyj3snHVc/KrHCOjdUCaBFCcZfN1L676M4RjYaYgPDVtLIY8lemeXU726cqcNZ6KyAiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=IM4qHXcL; arc=fail smtp.client-ip=52.101.128.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8S4BGC3UVcEdQUsItsXemDqyvN1E8ubamKruyY/Wui06flMteExlXx0QX45ow5Dyqta6d+IUEjpfyG/QbnJ0oC4LCpJXpJ/Hq5RgJ/uwHWfJCNiG3pGxHm64RQF+0jESrnfWVdFF27i46NcJBVWmSs1jugKWo/0YMWjEmJ9jmIAO20/WrYC/kkRb8aqQO71yV5abOGcrEjnSzkdJwJ8d3yXxqqAzY/cfcl8AD4v9TsEUxGLo5rbAx6b8LQHrvd3LLQEyy5V+D6LsaFSK/aM0f1L4MTQTcorgcFGMk7uc8pv9GmwjPcDcQ04d6sD9hD12uUJ8caq3oJY2ZpvDp1A9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pycQ4ax5A44iPL+OokI9fmS5xofqcN1wFPCwCzTXGbQ=;
 b=ZRNoEtDrlUJFkpLhYtg+zdDjcoLEcjNh4WILK/a0D2oTIA9Z8JSuJunJ54doazvJ8NqhmQgcIlSaqaoKnMNREQQiAhFn5pNjCznzJWWbemucdMzNjvnoUR5vkQH3aQZmTNfPmCwVFp57LPdI8XidS83nffVY2I3KNZ2cqEp9fOZ3gSJTPwiflYoMyYEW02PXzcyzFqg4ykIOsEmGH7gUW8jVmI8t57q2JC3RjRwGkkV4lLRAXqF8UXq/uOk1Xja4qvEjzYrF4w78Jyw7ddFQTMl6xyJV3K5EsOdk1dNhyN+edgyZdRPv5FhInlarMkTyRO7ER0+LjrkLkilydyi1+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pycQ4ax5A44iPL+OokI9fmS5xofqcN1wFPCwCzTXGbQ=;
 b=IM4qHXcL2sAihIRjmAPf4J9vlZWZKMI3Qp0WVPVV+FeRGU/gl9x49jA9rnq6+UQKFLuT95MB9Fqfd3QX0PH3mjQ5scvrpEDsMY7xCryoMMyagNY7ld0t9pPVcJSPvsgfhP8q8tDcHWejmIPRkDiC6NegY9pxllWms0MoX+cr8w6HtjOefIqi4L+q4VUv4/Uk2xUFTq7CXMl4RpKA4tGumQWh8bCktgIhU5LCZvnjHvSrkcVEVDICMU8Oas+sIFnTfnJZdMJXv8RixjwpOeI2Ke5gazn8PHku7qkyATag9wWG+8NtdpQFIB76+Jh7cJ/vKKbh+XCQwjCBszavyYcj2A==
Received: from PS2PR03CA0001.apcprd03.prod.outlook.com (2603:1096:300:5b::13)
 by SEZPR04MB6455.apcprd04.prod.outlook.com (2603:1096:101:9f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 09:19:30 +0000
Received: from HK3PEPF0000021E.apcprd03.prod.outlook.com
 (2603:1096:300:5b:cafe::35) by PS2PR03CA0001.outlook.office365.com
 (2603:1096:300:5b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19 via Frontend
 Transport; Thu, 23 May 2024 09:19:30 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021E.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server id 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 09:19:29
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
Subject: [PATCH v8 23/23] ARM: dts: aspeed: yosemite4: add fan led config
Date: Thu, 23 May 2024 17:18:10 +0800
Message-Id: <20240523091812.2032933-24-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240523091812.2032933-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240523091812.2032933-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021E:EE_|SEZPR04MB6455:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 28c74036-1f35-44ea-b115-08dc7b097379
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|36860700004|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jqOOOYTHQoj42yn1v2xkiEUTOpcSreTvC4m89m+KhQp+CeQh40pL3fP9f+2K?=
 =?us-ascii?Q?c4moz2bhmZPZhntw96FPmoruKZ+ua3t9Pd49/Rdzn5DmlrVuO3BL0ZnX6z3g?=
 =?us-ascii?Q?l2CdmL2eOhtcFZqahGRX6M+lGdtkcAno8XSirJgqxkY8R+N2HpiOSzo9jrwv?=
 =?us-ascii?Q?mAKV7qLrI5PLtzloUdkxonEVbAr5tO0A8P3Dyr9nQhO+uwoSrESCI/89H02t?=
 =?us-ascii?Q?jEHYrPEQsXNd3nuz2yEh+TaWIYNOcELzqXoHmEu+aGY5iVAMA4KVFfzeMcfR?=
 =?us-ascii?Q?tnz21gzLbBUMXf+8nG/LYIHcpRYqCfJL8pHgjwQgSvStqd78Qmi/IqhOgtBe?=
 =?us-ascii?Q?zDU4sYQwnoOU6WOxKo/xZdZurHHE5VdJ14m77yzdRYpI9Wm9VpkNyJy1WdQJ?=
 =?us-ascii?Q?lcnxsQrlMloBpYlnfohYQ1phzdwIqD5rZOrKgfAS4kA4V5FGkSKqM7Qfn8oG?=
 =?us-ascii?Q?/4TbA+ACZ9OuRzgGwX5OeT/0dcFia28TmRXHQkBAgQ10+RRyVotrnYQEjpsr?=
 =?us-ascii?Q?RYNvSaAcaXnUvb1EVwX/31YitpNPH0NqShNHfGdd10zAdwwLLAThEzt/6RlH?=
 =?us-ascii?Q?Ge2Z0vcOvlQEPu+qbYfdu2g5rLHnvRSr50mOpuQQLpe8++3oKd7LjaZypb3K?=
 =?us-ascii?Q?huJhoi0JIsMu8Bb0Jncce6DtRwzZnyutvGDUbJ3Kxsk8zKpEwhNZBS25Sx38?=
 =?us-ascii?Q?7DNPSndckqd5Mdj3lhb6EugO/Y3quzONgmRiFJC5TecvLsxXcs2dN+sAFlGu?=
 =?us-ascii?Q?s9MtqjotMUShd43NTvUaV5oF8feMtEDuCBoQ/MSGEZZD5QqePbXy1Uc+51RP?=
 =?us-ascii?Q?2D5YLRr9pqozvnnK0l54YuYCE6/QypWQr344A7cWjHq3g38Mn5EEyPiB5HK3?=
 =?us-ascii?Q?QqzwSFur+rVbMvb7G7LxjkXIzt9P/OOTgZ/QPXGcMajzjyODtjFNTIxL8Ot9?=
 =?us-ascii?Q?+DQ8hEWQCylG9x6wRtAm+QvTeIIU65Rz3fB0UBKHu56oA1IlGiVxBBQ8qKDO?=
 =?us-ascii?Q?+rdHYQPyry6JB67f1ofA5emg+V+BjHBk80DlBU097po/Z3vVYMpGhrhCKuHW?=
 =?us-ascii?Q?nnTztvGlshjQoVUruqZe0au/o161cB+wGMrvdTH/Ze0IudhdQ9if79DB5Mnp?=
 =?us-ascii?Q?zj766C/t7pu1+tzpXsaqhq0ISevXPx/AuH5Wg8YlxVDoQvhj/Bj1wKN8zI2g?=
 =?us-ascii?Q?ybf/EzAMaZ12Tmg83w6dQxJrOhF4Ow4Jc+ja8P+GPAlEWMgDUtOlFw7j9khY?=
 =?us-ascii?Q?zwcf3muLD28akZsanojOIaa4m/vvcr7LhBHWhhZYQrlXWxl6hIKyLGeFnDTj?=
 =?us-ascii?Q?Yn/WIHDID0fhW8Bise21zxn1bWDY/1AtefllaFXjZbJjDoMdAQ5VOdNcNip0?=
 =?us-ascii?Q?gXWwffs=3D?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(82310400017)(376005)(36860700004)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 09:19:29.9857
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c74036-1f35-44ea-b115-08dc7b097379
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021E.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6455

Set fan led config in yosemite4 DTS.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 152 +++++++++++++++++-
 1 file changed, 150 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 21ca22281ef8..2cbb210ed53e 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -75,6 +75,154 @@ tpmdev@0 {
 			reg = <0>;
 		};
 	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		fan0_blue {
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio0 4 GPIO_ACTIVE_HIGH>;
+		};
+
+		fan0_amber {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio0 5 GPIO_ACTIVE_HIGH>;
+		};
+
+		fan1_blue {
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio0 10 GPIO_ACTIVE_HIGH>;
+		};
+
+		fan1_amber {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio0 11 GPIO_ACTIVE_HIGH>;
+		};
+
+		fan2_blue {
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio1 4 GPIO_ACTIVE_HIGH>;
+		};
+
+		fan2_amber {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio1 5 GPIO_ACTIVE_HIGH>;
+		};
+
+		fan3_blue {
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio1 10 GPIO_ACTIVE_HIGH>;
+		};
+
+		fan3_amber {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio1 11 GPIO_ACTIVE_HIGH>;
+		};
+
+		fan4_blue {
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio0 2 GPIO_ACTIVE_HIGH>;
+		};
+
+		fan4_amber {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio0 3 GPIO_ACTIVE_HIGH>;
+		};
+
+		fan5_blue {
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio0 8 GPIO_ACTIVE_HIGH>;
+		};
+
+		fan5_amber {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio0 9 GPIO_ACTIVE_HIGH>;
+		};
+
+		fan6_blue {
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio1 2 GPIO_ACTIVE_HIGH>;
+		};
+
+		fan6_amber {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio1 3 GPIO_ACTIVE_HIGH>;
+		};
+
+		fan7_blue {
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio1 8 GPIO_ACTIVE_HIGH>;
+		};
+
+		fan7_amber {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio1 9 GPIO_ACTIVE_HIGH>;
+		};
+
+		fan8_blue {
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio0 0 GPIO_ACTIVE_HIGH>;
+		};
+
+		fan8_amber {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio0 1 GPIO_ACTIVE_HIGH>;
+		};
+
+		fan9_blue {
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio0 6 GPIO_ACTIVE_HIGH>;
+		};
+
+		fan9_amber {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio0 7 GPIO_ACTIVE_HIGH>;
+		};
+
+		fan10_blue {
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio1 0 GPIO_ACTIVE_HIGH>;
+		};
+
+		fan10_amber {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio1 1 GPIO_ACTIVE_HIGH>;
+		};
+
+		fan11_blue {
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio1 6 GPIO_ACTIVE_HIGH>;
+		};
+
+		fan11_amber {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio1 7 GPIO_ACTIVE_HIGH>;
+		};
+	};
 };
 
 &uart1 {
@@ -1198,7 +1346,7 @@ eeprom@52 {
 				reg = <0x52>;
 			};
 
-			gpio@61 {
+			led_gpio0: gpio@61 {
 				compatible = "nxp,pca9552";
 				reg = <0x61>;
 				#address-cells = <1>;
@@ -1268,7 +1416,7 @@ eeprom@52 {
 				reg = <0x52>;
 			};
 
-			gpio@61 {
+			led_gpio1: gpio@61 {
 				compatible = "nxp,pca9552";
 				reg = <0x61>;
 				#address-cells = <1>;
-- 
2.25.1


