Return-Path: <linux-kernel+bounces-295260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8137D95991F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EFB01F2148F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EEB1FD5DC;
	Wed, 21 Aug 2024 09:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="GuZLUTV7"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2078.outbound.protection.outlook.com [40.107.117.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13101FD5CB;
	Wed, 21 Aug 2024 09:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724233371; cv=fail; b=E7CrHIxu0LgHzq+A9EqC0XeBXhT0E0wYAjpdomyQA0Yp9Ihuwwo72BalREOWyEHZkNvdRRxXVdSOUZRPDsCSM/tclhjNNdPq5II1G2ZnjkM48Wb9UKKV4IcO2nt14yG3QeU+tpSBs+1Rkn4xrWUSCUWDNaBoXxS/6KNC5Ts5dX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724233371; c=relaxed/simple;
	bh=1cxP5pczgJ7valwzodgjXvVTCSFyJVT8lUAovr6nm6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sqXeSbdZLt2LTTJ2WTeGQrDK9q+QQw9gH165ssKFCbHratNjbdPcpzHNGa3iJNNiXfNlETBpxYHHCeiohyyxsbDB2NybegtS8RrcLoTgP4PllO0FOQQSPbgnW3REPxADr/iikrUYh8H74H2+lR7b/+5uC1ErhB0AFYs+CAfk2ZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=GuZLUTV7; arc=fail smtp.client-ip=40.107.117.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pPh+3TOUPDs4Hm3oKBib6DF6OuDwHLHrMuh8lxIMrI0Wg+7X3GPZUsI/XT7KTveFnAwitJdv/UV+nUjQEsUccl2DcK/T/cbDY6qGV0rhDmyhhKhpYo7qhkbFgcCUOtyDrct8Cx7kpJf4G3ekYpGRPcG7mBeTylDNK7MZIGKyye/p3SyU9KFthEIt5XGtQVvGZvQBRlG9Yoo1evzqlLvfbVO22jjcJ171bfyuaQd89BZbU3rCpt0w22aYgz3Rl9/8akzSR5uszDhZOeKTGXP1QOHpITT+fiDT1+APICYSDdkV9NiH1pj3FenGuMn+1w06DozMTNjAlhmFbgj5SRq/Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=deWOYRp1IarhLB5qRFgI0h1ErIRC5JkaB/gNs5HJuG4=;
 b=i14a6Pb54pBgN7SthFzVfsbZMOBuIDC0dbU+Huu9YWce72J1uzaTBCTstrjhn8dY47gdQfsCV2pku0JKrCUwlvMDYFJzrjvEad3NASBAHYMCq5d2xhaugJzic7eAKiw30paBGLaUTZo1LFdoasUukW++ESqAHCXm6zhceSaLfEh+WEs8Oie89gnK9fj1CxnbxtGPtSNwKNpvW0fFO7il1iqspKXnEiSP+HYVB+S5q2eKHfmkUeThIfChTEeWnP2F7uUZqyc51UnX/IhXykH10+6+a/AIjV7XDZC163SWszVPcf15BQpB/Dul8801Y92WuR0SnOR1AGyK9RkHZCzM4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deWOYRp1IarhLB5qRFgI0h1ErIRC5JkaB/gNs5HJuG4=;
 b=GuZLUTV7KOK2V5Ipp6cAcYkL2NhSyr2ID6mRzQ/PoA5GiQ18pkcQeXuufq1JHFawHic1rsd5kp3z4x/+WvUxdsu75D6WsHDZt8+rIAGpSHNbN9sXAIEs+Eerq9DGfhuJybl/KG6MIvMkkT6zoCKWKSGbxaDtX2yt239JgIj9zfJMNjRxl4GMih+tIovV/HnZgLyIICoqemdaASoQcRa/FrUnG9sHgJ8zA8xErXNrpcIthZCygwG0UiSaohTwY/brFvF6ZZ/LxixeJhvhTfOsnfHOkb1fI12f3DEsh0C76qnK4zfeHnI83fKd8IPez1fDNbWCdqpJ7M2uSL9Lp+M5PA==
Received: from SI2PR02CA0019.apcprd02.prod.outlook.com (2603:1096:4:195::13)
 by OSQPR04MB7876.apcprd04.prod.outlook.com (2603:1096:604:29d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Wed, 21 Aug
 2024 09:42:43 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:195:cafe::d0) by SI2PR02CA0019.outlook.office365.com
 (2603:1096:4:195::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18 via Frontend
 Transport; Wed, 21 Aug 2024 09:42:43 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server id 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024
 09:42:42 +0000
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
Subject: [PATCH v13 18/29] ARM: dts: aspeed: yosemite4: add mctp config for NIC
Date: Wed, 21 Aug 2024 17:40:29 +0800
Message-Id: <20240821094043.4126132-19-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|OSQPR04MB7876:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 54289a1b-dffc-4fb4-6901-08dcc1c59abf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zJFwUYKR0NPT6fsJxmxBu+9vnbqjF2v9///Pc5cbmsaoW/NHMBt2DA2KoqJM?=
 =?us-ascii?Q?Nipxr0wQKUzvOfW3msmtjBMSRYsY+vLSmg8xWgmcRZvHSI8jDc59wRUTM+Me?=
 =?us-ascii?Q?jR7zUsMsrU8sCXpE1MOJOXop2vmmsqeAOhvVaJ+vhD4rgEcEsc4IS2eBAOKr?=
 =?us-ascii?Q?iHjq6T0es5oeDvt65ayg85rKSJKQVGO217gXa59B1PQUlHqVShYstJOYt36l?=
 =?us-ascii?Q?Z3IfwfC14iZ/gFi2/vvXL7UZwZ1CQQGTX75NSPFbMhTCdQap7wOb5wFrmsmZ?=
 =?us-ascii?Q?AZupKIOwzL8Cikcl259gaAg0yozH81c+AzqsEAoxGZJi0FB5kTYKxJYQlwBy?=
 =?us-ascii?Q?mPnvCM2U0i9DOCszII5OJKXLd8jYvASJrLjQBkzfQgocawvxvLN7o3J5SLs5?=
 =?us-ascii?Q?T/ydMlEbifrJ8lKHH5CYnVWUdo/TNlr7WGc4hakw/rANnCJtoPukLfZpLnJ9?=
 =?us-ascii?Q?S1iBhkIyT//G3YSWGS2XfzK/PjLD9Y/TEpMHo6g22c4sxBNSmWrvBr2NCuDt?=
 =?us-ascii?Q?ZEW6VrgB8SYZLOjrMiszIFrsAWrupPepI9Rkl8S7qUNoC8oYf0xdylCmVVSo?=
 =?us-ascii?Q?ikjvb99NN+ZM2igfp8U+yQqnEzSummrRcFYbsVY29fDXubL0RXFthfZhZy8m?=
 =?us-ascii?Q?bXtDAGcm1GwyhpACs0O5zGzpAdEEKFmmNXhZN4GaFnFO5ve1BHyupdPINSci?=
 =?us-ascii?Q?bJd1+NrPkLN7pRNA1Gm1UL/4xMD4DlMpG1QebkkzhA3AMmOpA9SmtC86bosi?=
 =?us-ascii?Q?nQqnpAyGraCj8ZqkRL5B7ITQFvv5Z50TDt7XqlKXjxKtJwM9I9KCd+SzTfNx?=
 =?us-ascii?Q?Xt7U913pmTmUvTHcbKKNHMzwal0VjndwhaPlNYeoR0iolC3J2pLUtFjgPcVB?=
 =?us-ascii?Q?FkII5U3fdxLdY9iLfVXe7Fmk5pTR/73S1/+RKFNuIqpWgmWpQfvbvzQteEyF?=
 =?us-ascii?Q?+sTd1SiaAe6I3b6i0bAmnCneta5ieY7xzRz/ASYouD5AYhV1oM30RrMc+zRO?=
 =?us-ascii?Q?k/IAy7Cd8QcX73UGGKS/5qhyYtasSTrdA4Vwc8Nm2s5sWmRHwJlGrVuhTN5W?=
 =?us-ascii?Q?ZKtSAYx8nUicXhjdQA4F0hIT0UZH5HGdToKmWwo8999E3Zow+mGns3LJaFI5?=
 =?us-ascii?Q?GPcbJ838c7fkxvT1uhowPWz07JmRnFkPYfDjKJiZGVopeTCwcqcMhzmPj4oc?=
 =?us-ascii?Q?mpT23MUun+a7jx7DRBmWdNkBeLZzCBWO2g9iw8QwD68J4KLeqShsNnaewP9H?=
 =?us-ascii?Q?3hOrXfsMTqcky23eGg2eFJF80D9yCsNEJd1IHKoooWHHM6SNv2GBHbIP3I8+?=
 =?us-ascii?Q?rR+zzY/vUOafygqINrGtPJ7pcSrtsGUXzd0lNq4uX3gdaXac4HBjY9iprHmK?=
 =?us-ascii?Q?IFBWGAqTLCF47VCke5ampQL+eeCJX+zPv7Sl8T0EYJnjAW5IO4nqcj7UXOZI?=
 =?us-ascii?Q?oYoWulufgeLxhJIt8dIP6XpuqyvGwRjH?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 09:42:42.2471
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54289a1b-dffc-4fb4-6901-08dcc1c59abf
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR04MB7876

add mctp config for NIC

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index b46a0b9940e2..7b8a2384d99d 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1281,40 +1281,64 @@ imux24: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+			mctp-controller;
 			temperature-sensor@1f {
 				compatible = "ti,tmp421";
 				reg = <0x1f>;
 			};
+
+			temperature-sensor@3c {
+				compatible = "smsc,emc1403";
+				reg = <0x3c>;
+			};
 		};
 
 		imux25: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
+			mctp-controller;
 			temperature-sensor@1f {
 				compatible = "ti,tmp421";
 				reg = <0x1f>;
 			};
+
+			temperature-sensor@3c {
+				compatible = "smsc,emc1403";
+				reg = <0x3c>;
+			};
 		};
 
 		imux26: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
+			mctp-controller;
 			temperature-sensor@1f {
 				compatible = "ti,tmp421";
 				reg = <0x1f>;
 			};
+
+			temperature-sensor@3c {
+				compatible = "smsc,emc1403";
+				reg = <0x3c>;
+			};
 		};
 
 		imux27: i2c@3 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <3>;
+			mctp-controller;
 			temperature-sensor@1f {
 				compatible = "ti,tmp421";
 				reg = <0x1f>;
 			};
+
+			temperature-sensor@3c {
+				compatible = "smsc,emc1403";
+				reg = <0x3c>;
+			};
 		};
 	};
 };
-- 
2.25.1


