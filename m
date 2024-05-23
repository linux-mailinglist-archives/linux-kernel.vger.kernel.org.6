Return-Path: <linux-kernel+bounces-187254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F70E8CCF11
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1899A1F22FBC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C5314F9ED;
	Thu, 23 May 2024 09:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="Phj55WPM"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2074.outbound.protection.outlook.com [40.107.255.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D5714F9E0;
	Thu, 23 May 2024 09:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716455971; cv=fail; b=m5A6t5ad5kmi0LlaGmCImxu8+qFLqjL4R3Iwj3Zs4Z913F4fxH+egmpB9HSXLjcSByziIAY7leqaos6mSlDGY66EGEkcfOfUIMgbvDlE9YEn976wxy0hdcp4hjf+RWHRq4Jm9X6vdqjs7u4f1eC8aS0VFQfVHMB5DgWOtxQQysc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716455971; c=relaxed/simple;
	bh=B/oZeUxM7Bov5AMZhp/ruSmD6wW9/+CYr54R4FGw1nA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eaxE+RXH1uVdqBap04G9eMHxVU5VOFk1AKa46fRdFJ1QvO3tB/mrlevi7gqQm0kMVlkf6V6ZRxOxacf9aDYYKZSoSTMphOXNfb4vSD69HN6NxoAZyNK8nWoGkgmh9iQRAeg489ehADOrmCJMzHB2L0VyqjdAYiqT3nKZ6bFLdZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=Phj55WPM; arc=fail smtp.client-ip=40.107.255.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXHnk3G06u/dXL25D3po0EvDKyHQR+IcKgq/p5QrpLs7m9yJ5tzuD6jubrq9LjNxs+C7TjCw477mQ09wPJMU29MsMKm7LLYg7M1OIKr1QFyrXQDZSt++XP426BTswUNdk+A5Rni1R09TIlstFxVbDXXuU792O6SbwvtUiJOevJXxJkCPLT6PHsWJf69Pq96pZEMasTOhw4dKoB++7aVdgGVqjdG3Sa32pLpRwnMp5K5EcDP70gtXg/v4gOiE8sv7Wr24X3riUI5A0c8BLTkjAKwrXE0v3GbZDtrGjjqsQ3gGB5v+g07RU/dCNDdTt/wkNlR3kME+Ze48XDklFgKoFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5nLOGzr+7KZfcZvwMsTgIEus1J7dxSLeXUDVhNOLW4=;
 b=L5fh/011mTj6LvUvUCVN0DSeicjv37k+6ruYCdrh71dsmv0KEIySJYsQgXO3lJQnN2pXVD1+0168ZODbgxh1zl+LSWnubb+F7+rkOvlikdQSO5KXyXTbx5teFckdQxTpZTqhpeDavhzDjAr+nSgt1cR3PKXq6ylte9pLMIICiWSvj/LuEaPpckjWC6TF3HQjihj0/4/hJP+BH3aBqyhqqzhdFSCat1rqXnl62Hkp1hFJOk+G0h8YsBGn+lOwzHwjJCavJikTw1zupMHbpq8PyyWxKQ7oXDE2urynEmXjxDgYfG4ItNABHQmXjZ39UohjvFnFVgVYEr3sTEoXrjastA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5nLOGzr+7KZfcZvwMsTgIEus1J7dxSLeXUDVhNOLW4=;
 b=Phj55WPMRf3IFVBYAtC4TXGBtAca6wRwoiIc2ccKHVhtaZUK7g/zqLK9H1y5M9nsWt9xGd76W/UevjdHrAf6sZ6CswLLfQlS8vwiya8ebFSgFDLnBMB2xrqa+AStrAFiSocjwYqHpWi5iB6pl048LdE40vYtgro+GyOmNo4FO63iWaymstAXQ21YylqASY9h7iV28woBGgqUYLF4J/se/M1NQGAVLo7h9e9xV84js1jxMjymGvl6gJVBt5Sk2puNzhvFhGtSD9pG5L3MZxXX2q2fJ43g1jDH3pXkHKyJ0+zbBi//j2Ekys5KkLP/7kthSuMZeY4YCSD+RVrTpuFfgA==
Received: from PS2PR03CA0004.apcprd03.prod.outlook.com (2603:1096:300:5b::16)
 by TYSPR04MB7924.apcprd04.prod.outlook.com (2603:1096:405:91::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 09:19:24 +0000
Received: from HK3PEPF0000021E.apcprd03.prod.outlook.com
 (2603:1096:300:5b:cafe::c8) by PS2PR03CA0004.outlook.office365.com
 (2603:1096:300:5b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19 via Frontend
 Transport; Thu, 23 May 2024 09:19:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021E.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server id 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 09:19:24
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
Subject: [PATCH v8 21/23] ARM: dts: aspeed: yosemite4: support NIC eeprom
Date: Thu, 23 May 2024 17:18:08 +0800
Message-Id: <20240523091812.2032933-22-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021E:EE_|TYSPR04MB7924:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6a959a78-e8e7-484d-78a7-08dc7b096ff4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|7416005|1800799015|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BZRyOlqEMBKEvrJmpIAGRzOmmyEy9+R/lM1MfDTeuK/LvcEm4N0yH6Gd8t50?=
 =?us-ascii?Q?OqNNxAw4QOFNDSBlkOMKdXuBkC4b/qLO0YOXWif8csiaAqcwcWWZKm1Bo9si?=
 =?us-ascii?Q?lvh4XoY6P3bqtiBdH16VKpuS7MRFyEgGsPFyjTQkW1QZyNm1h15f5RyO4j6R?=
 =?us-ascii?Q?ToV2MT/2ejYgpFCirw9e1tz5oVno+moniAVJMrmaklunIf74vV9dPqrfU6FG?=
 =?us-ascii?Q?22HFM0MqdhjpJPmZpoPk5Yyjb4Y6jptjNHFOeITOx79qQ04ckhfFT3ObjRUN?=
 =?us-ascii?Q?3UOglv5aR3EYClRiWQSWGFkazCBXYRJa48L2NTjG+AEMBcAmLphpKAPwB1Nr?=
 =?us-ascii?Q?shVmLgEVEDPbb4AJHLbnJVWI6qALWw8H+Juk3jWJTIwehYUZ2s6/PHxAo+Gl?=
 =?us-ascii?Q?JGIZbio8Lw3ry44fq4POOCHN+hmZVwLuc4X6xHTC9j78nE8XD2mmG8KZ6AF+?=
 =?us-ascii?Q?sXYSGZuHt/rkPzmXyHcVWRhIHT73RV8S0r/DvSp9rIFUkaPqCmhvUU+GpZKj?=
 =?us-ascii?Q?hvaYkTMKkB6oSCvlg+dngSlbCLb/SWvR2Uq5kasmo9io+jIu5PyzoWZtaot1?=
 =?us-ascii?Q?d8JXK16t2U7l7J5IEfOnUtJUdmJ14a+Ird8B6YJvIEPHQ62mKEOj8y1xEJ45?=
 =?us-ascii?Q?Adu5c+EFMG6DSqlQ9qgMYgTtx/5NNY0mZj6jmrRj5Jol9yncRMPXrjXxx6V3?=
 =?us-ascii?Q?WwOAgg0xJizxdqmR56khQI5fHwgeWR5Gq2QWuCLt4QUTltc5wKfw/EMwIlhm?=
 =?us-ascii?Q?YZfN85pawuoYkgks6UcC18NOzUuKzEkeUqCBsYOn0BpTI4dYFbS0ipzju19g?=
 =?us-ascii?Q?fFnhATMt65pKByZPVA+KDWWVcyLFkBNLB4Q/19Xin6QN7kadN1ZvKsByMr/w?=
 =?us-ascii?Q?0fP286s//nlQzZrVO5kk2ssSWOMZQE/xti5ACcMyKNRo+c6FfM0hFbLc6mCM?=
 =?us-ascii?Q?ymh7DQwo/5FMKEWkHt7LS6LnJocpjskqSaYQag3mep9/VBka/WRKneWB1bX5?=
 =?us-ascii?Q?+AfqZIzRDTEW2VGvy5eULDadbhPSmCCs4zUBfGh0kIoLBlZP19bus0izK7j2?=
 =?us-ascii?Q?LG0pyFt2u6oWDydW7W2Bh1zreSMjWrC6FtaNwcQtpZlBLb2FtJiKZY9Lyftw?=
 =?us-ascii?Q?tawRYUqpNHq7eyat6fpKXETFmSZD/UYlFm8eXFR6yn+4iwYvJtTSj2igqv0m?=
 =?us-ascii?Q?M3dR+CwC14Nv8mHpLKfIDDwZCyfb9ys2cyHKH0eOj/UglnEoJIL+RXGH9Uc3?=
 =?us-ascii?Q?unRBNVB72nZHwFAkv3/gR/Tv8A2eKouUWfOp/4NRCoOLH8lAcM43ZsLq92fv?=
 =?us-ascii?Q?NUKs6EigPUeDGS5IhdNpIaxIc0gBs4WqPfItVd9ZW50y2V2StmA7jCL8he9U?=
 =?us-ascii?Q?iFD2bF+cwWImVCEv5+2j3tugsIIe?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 09:19:24.0795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a959a78-e8e7-484d-78a7-08dc7b096ff4
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021E.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7924

Add NIC eeprom devicetree config

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index bacaa2208734..62dfe935cbcd 100644
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


