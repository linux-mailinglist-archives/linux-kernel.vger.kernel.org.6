Return-Path: <linux-kernel+bounces-336913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDEE98427D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 219A61F218E3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B613F158DD9;
	Tue, 24 Sep 2024 09:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="EMtWo+Oy"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2040.outbound.protection.outlook.com [40.107.117.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6275016F0EB;
	Tue, 24 Sep 2024 09:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727171083; cv=fail; b=ucMV4cVZmhfzpcijsd3keWXGuxKflx2nna3RziigpvovkZp0W9nfgEM1H5tvW1ysSnUtVKChZHlsYhADLZ093jz6r0UpGlMalty7d/81BcJih+tEHzq9uj22ouBoRY9PNrm5HhGH5/q4omRKhctqHHV3xNrTyqBy6U2Ie4KLOWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727171083; c=relaxed/simple;
	bh=nLjSETuXOkwjJ8komf6ZfOs+f18P6Z4cbyNV9qOdmFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C1VHoyvFEQznSgWvQnP4VX7MEs2aAgRaxV5KbIDHwY3nRDCsFXkDxdayHnCFQtwdjAxa8mWL3dhjJvdaCoda+rdKrfeQmBGmu3+riGUE/DvJDdnpKUIWoEDkO9xzpFcCi0L2OjkfVJZ8iEStf8xjJKvqv5nJiadn2sRl2v08zgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=EMtWo+Oy; arc=fail smtp.client-ip=40.107.117.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=baQLV+Pv8brRzeL+2QZ0El//NSRyMCAQMAI1aMfx4p0W0SgClOdFkHVHgFKzoI3hjdqAhvCjovHoPYcNHesxeJMhIMJAPfYo9l2f2giw5z3VG1YH08jOStBZyquoVPKGeYhj5klm3GkgCRHdONFrbPl8cLTp8e6PwtTxCZT137Lid7EEDTP7ebRfuOcgVONFNHKagH31zdelfphD5yjfa7sQPiAH4gRZ6u46GTeQYajo4KvvG0GuT1TvcCCzltgiWWxCIRaq5auWXka3aEvujEfCOMYIdVGF1ubdXcUkAKbL9+5ixlKpA+SO3NYJrBNVwfSGAC8iiENdkgMidOcHGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kk6GgUvLcnjii1vbRoyfZhv5UaItrJfLB5vufjvVXQ=;
 b=cIAuw1sm+XzS7+YF09QMyeR7cO6kIDQBXFyDa6ZrKoqLghWMl+UDKNXD2TeYd0omsi6C7DgDcrCQnPd8xbVOoxR3qC5F8EW4AzHC9qpP7OYkPjenRDhPsxeTUSjQuafYHeOeu/++8qfTR0h9lXDCjXYmKKP/zAwQJEjvdn5Onb8OJhKJXjeH4q2odPDAKj8z2ffxmQERdMqLiWYshxHHawZ0qDDeKr2biyrWId9tUWQbzKnyDPCB5JWWrk2KLz2KjJsOkeEVwEJr2Ahowsi1aRxMNsB04usDpjXMzxTf8+qkvnJTnegZR5xfi7b4i0affJoQru2Yir+9copAha3V9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kk6GgUvLcnjii1vbRoyfZhv5UaItrJfLB5vufjvVXQ=;
 b=EMtWo+Oy/N+G+hZoY3Np0AEnJivey41W790l+91JvQeSzy0mS3QS97XB9oX9S9T1YFo69Iv7a1bvaPfnBPcvqTzHDXfTgyUf1AAOkERMbHOgFX/zxPOJWzI+zfpY2s9YWj5FkVELgofXgzFiyuGrZ+tz7uD0xInFiKqBq8dptCgHAkelV1z4FqeIs9dN8Pd1fhJCxKtVWHMAVL+QTSYZdavSoV04Bo0m6iW74E+xZRLeCOZeBTSObm/Eheqj2x9lZwxaSurmONdYAMVgk/vHxwsnaJWkOULQdtx15+SHXKgKr9pPiuQrBcKcBSsu0ui+Q2fPO4Xto7hOwwfJRndGTw==
Received: from PS2PR03CA0001.apcprd03.prod.outlook.com (2603:1096:300:5b::13)
 by JH0PR04MB7477.apcprd04.prod.outlook.com (2603:1096:990:6a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 09:44:35 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:300:5b:cafe::16) by PS2PR03CA0001.outlook.office365.com
 (2603:1096:300:5b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.16 via Frontend
 Transport; Tue, 24 Sep 2024 09:44:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.8005.15 via Frontend Transport; Tue, 24 Sep 2024 09:44:34
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
Subject: [PATCH v2 1/2] ARM: dts: aspeed: yosemite4: Revise quad mode to dual mode
Date: Tue, 24 Sep 2024 17:44:29 +0800
Message-Id: <20240924094430.272074-2-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240924094430.272074-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240924094430.272074-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|JH0PR04MB7477:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9d967cd4-445d-4691-577a-08dcdc7d7f58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?erdgqQ3BSBgIR7FDutlTC0LEZBxzQMjatBHd+R+HyFX+5I1nOjT0vYJezKBM?=
 =?us-ascii?Q?CavpvDfbTYPR+w0UmhSMxSNDKpJMUSTP5w2NGdgvncgXjyQ8BwnbSJcdUoWq?=
 =?us-ascii?Q?5L07aY1G5yOiMQdaSwJZg3RsQbNCA3a2sqPZZ5OvsMQjXH3vduGAvSjkuGSD?=
 =?us-ascii?Q?ysoDbPdsPyoxTrL8EtA3SLl0IJnXaCaZYBdTPB627SCVhTI9hlAmDXAqiTLb?=
 =?us-ascii?Q?E0L9rv+mmVEGIUYSVdM1/Hkhk7rjR0wPMGvNacKaiOEw5ufqahwVwN4iWFze?=
 =?us-ascii?Q?ihhMOlywQTUbuK/mGeQvgw2IFxwe0pyKrllmMTXDP01lovsY4mljBVYGsXKA?=
 =?us-ascii?Q?sGfp0K/kI4HiF7JZjnwoqb3WzivQDiDVOSbbOCQsSbGjR/xZYIoSnvAIXTjE?=
 =?us-ascii?Q?DkrMQrSYNkryDaIJ5aXNurir6FezvfV3WedAuWs76jyPD8mzhenSifmq9js/?=
 =?us-ascii?Q?GtekY0xLcNMY3KhTtcSB8T+vJnSpf+bk4ZlFXvM0CvCVoOpU1UbCAcOxP5p8?=
 =?us-ascii?Q?tH7TaSoWD4Anc8Z+c0mIbshockw3jXyH2sawNIqK6tRg5lDU3EB5IraQRDKB?=
 =?us-ascii?Q?3+GLBwxoyv3v/aYL42eFJ4z3Klvy0s14at/u1nQxIT3RC4bvBLxnHWlZkH7P?=
 =?us-ascii?Q?v6gKwjvrWRTxT9ZrbBVWpnjxxdbBbHc7rmr45MVMc9Tf0eR/Sgeq2Z272yHU?=
 =?us-ascii?Q?ks9RL+yfhGNx1/CQWs3FA80cSPTVmeLc6a+6o/wpA0G1tAtNimf45kGLSq1Z?=
 =?us-ascii?Q?JbA7HWnXs3kEnbSKiYw0cEgtIXtQO/0pbAiDQghT0dRukvXYGN+PE4IvnDl0?=
 =?us-ascii?Q?4B7Sl7GoRjAuXJUCbCj9dW7C2AOwsP4YzYyuUGNPCGSvoopo0dgQadpp7SWK?=
 =?us-ascii?Q?aaTSoAJ0HelaQFJTXJieZ38HCMy0923VdFSi+SmNbbZri1Yd6E9GKoamKYyo?=
 =?us-ascii?Q?MlZQk3lAGjgTivo/SpvXflk272WBrY17jWeheHiZf8CBQ775Ku9eDcE8/YQm?=
 =?us-ascii?Q?lGSU+8CI2qs+8s+ooX0Oqfdn2/WnxBBIv2h21SYK6h0h7Roo7sk3zimkXKDp?=
 =?us-ascii?Q?j+hO3YvrLjvgKhpOwt/y9l2MzbKCYYQJKqxlQwlPYyMmWoJsdSRwmvW3EcuD?=
 =?us-ascii?Q?n7gvukY8iyDNjqW8SqyLsHpatkSXl0W0jFl4WCv72keRqWJH+Lq3rB8gJBeg?=
 =?us-ascii?Q?E4MLlTrwfvLGyMCr4gqdqKWGluN0W1eQWEsj8LtNMKOPpMe1+Advcaevn+4d?=
 =?us-ascii?Q?sFKsKKA8N3dXCr/T509c54vhpDr5q7fOjHdAoffwU5IG9EbzFaqg45cFOMsA?=
 =?us-ascii?Q?EGl34XvgpWye3EpvXHdL/m3VuT4aihQU34zJNLUF1uwBYgBxrF2GYuLCK7uE?=
 =?us-ascii?Q?EUd2BDk1bAuVXG5CdxvW98GsNv5EgCRwTa0GGm4AMlMmPmqovdWuUDakxYJ1?=
 =?us-ascii?Q?f12BqrDI1bn8UGMVs2zsrnqjVYwp/iHp?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 09:44:34.2942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d967cd4-445d-4691-577a-08dcdc7d7f58
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB7477

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Revise quad mode to dual mode to keep the write protect feature for the
SPI flash because the WP pin is the same pin with IO2 pin in quad mode.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 98477792aa00..c4af50ba6999 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -105,7 +105,8 @@ flash@0 {
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc";
-		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <2>;
+		spi-rx-bus-width = <2>;
 		spi-max-frequency = <50000000>;
 #include "openbmc-flash-layout-64.dtsi"
 	};
@@ -113,7 +114,8 @@ flash@1 {
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


