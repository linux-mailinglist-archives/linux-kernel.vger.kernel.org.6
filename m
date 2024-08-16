Return-Path: <linux-kernel+bounces-289384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD719545B5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A15531F289E1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D812159568;
	Fri, 16 Aug 2024 09:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="ieXH++6C"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2053.outbound.protection.outlook.com [40.107.215.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D4F143740;
	Fri, 16 Aug 2024 09:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723800358; cv=fail; b=HZ/8HPZBpJCpgfgCNgH9EdYEuZ9jKbA5KLcEEFX9gHoDpTUKCyi4pq7xfp6tHVJcuptKsdhAYftX0IyVUbKttReR4CWNKwTDGUQC2VstEwJchA4qmDvc3yycC8XMFjCCyLcbeEZ7hjLgKXZ0VTOglDrGbOS1HRIul812mnD3nKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723800358; c=relaxed/simple;
	bh=1cxP5pczgJ7valwzodgjXvVTCSFyJVT8lUAovr6nm6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nm9lG1EysDRTPWe19sPLE6kUJcJyYYJHbxwZvLphRgny9UgjOvUG09TnpF6Usfe7auqM690rF5H/Mqjb/pXe+6i9mLl5ECGr3AYysK9WLXahXGJ6vRhwEyt6KDXZR8WbXsW+cxbDXfPYTFCM+6mh5JSuLSHmwhzT/YP3gvuvjSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=ieXH++6C; arc=fail smtp.client-ip=40.107.215.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4Vp7MaUxSJYmSbKs+gNGNk3cMhpv/BQFeIJ2FnZgvgzxh2b5A3WSPSl/hovgve8/pE1EHE38pLiQvQKtcT+72OwI5F303ppm743864sYmyzQaQClsOIunSIHyMLSAZPABVDB2orT3gkFqGCEsixWmW8sbxHMza0zStPKxODEtglNM0qW4NK/a6OmYLMBG3zl7CgWayB1Lp4jglXRUtjDHe7PAi9QYwuQoc04yfdhsOBP/WNkE8Ea1Wbpz2WS+mzJ5dSv/MBuYmxbjdDi06eG+t7KFnWloOIl2p282GI5a6l6Bpm9/qHc02wRAaeVJVXzSWz8MWRzUUS1VYdFWRKSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=deWOYRp1IarhLB5qRFgI0h1ErIRC5JkaB/gNs5HJuG4=;
 b=MxRH+Uko1t88XpnHd17sN0wOD/1+2PmcmJJyPwnSEpVaNUBAvwFF55e9hynoDqBHqt7lxgY9QTW77fOHxhPN39vFk+8BLKakP1Nww3hvEycDl2JzHZojUFoscwI2kRjU2h3IP+60mOkkCsvpzKUThzcSvS/Ru2g8sB2EsrB4mXUAUvd22DxBMVekhNKPpLFXUWbyzKOdk7Us/8tIC09JVp5im6F9VtQ726ZLqa2gGW9ScYj+k8TiOyu2x80pz8JFsQIMgLC4f1CccgHHC8NWB3koQAbQIomM4rXX+uKsherMhTHn9Zl1+vEsaQ8y73/6sd83GyDvE/zqpfv7o2MTVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deWOYRp1IarhLB5qRFgI0h1ErIRC5JkaB/gNs5HJuG4=;
 b=ieXH++6Cxn5WaYK3wI/a/JzqGAnOXySxhqO2moyv0dmudHILc4VRWvhFQw5oIKs5KBEnxyo04TBZPCjFbXiuAdvZCaQJEvpxcIXuPBGx96vGUwzk5fxibZO26a4CXLHGBe201kQ6K9vZvZ00e3YpqSOfPh2/oVJgxkvZXen1EK6WnMBrK6lNZVsieNgs3XQmQIkzfuWt5Bz0DpP0AOBlfAOn35WoOFr3hK4uJQzNhedKUiX1UclutYnS8T2idJhubFJWB1Hs5hrmbXK64wz9XGeRm4wyEd2+nrKqJCmRtjQsAQcRQkeN1ERAy+Oixun4QthEf+iWNRQaoQ8uCJUF3w==
Received: from SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) by KL1PR04MB7292.apcprd04.prod.outlook.com
 (2603:1096:820:101::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 09:25:48 +0000
Received: from HK3PEPF0000021D.apcprd03.prod.outlook.com
 (2603:1096:4:193:cafe::5c) by SI2PR01CA0051.outlook.office365.com
 (2603:1096:4:193::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.24 via Frontend
 Transport; Fri, 16 Aug 2024 09:25:48 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021D.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server id 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 09:25:48
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
Subject: [PATCH v12 18/28] ARM: dts: aspeed: yosemite4: add mctp config for NIC
Date: Fri, 16 Aug 2024 17:24:05 +0800
Message-Id: <20240816092417.3651434-19-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240816092417.3651434-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240816092417.3651434-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021D:EE_|KL1PR04MB7292:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a29d4a29-6cc3-481f-f47e-08dcbdd56a0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mJv2gcv7fRWAQEWgMw1uRX+ud3jSzw5BAS5nF5FqQuSh70O12syBN4VKWrSD?=
 =?us-ascii?Q?B3fcTxdC7Kloeb8/Vjjm/FSC5pgUJ/bU2ggyhywF/VEvHB/Yr7qhs+qpfVO3?=
 =?us-ascii?Q?GT0+krrywswaXrd555PA/b8Rki4yVh6OejMYJ8GmhGV7W4v9VUjqdpJPSWu7?=
 =?us-ascii?Q?dteVaZEDCCk+ExGQlSKcBsRkRDikCRJJ0lIj/bMeg3LswiFI9H4oYgFDQB5W?=
 =?us-ascii?Q?gWrIkNqiiYVQQ2XzT8PdslbZ9b7O7/kABJDsj9RuY3X3Tm6wlX1cqLEy6NY7?=
 =?us-ascii?Q?XiuFkwlQV7iPF84Lu+07+VmbhewMsGLh+ImTk3d4LjhOrlLOK82iRxakd5mJ?=
 =?us-ascii?Q?ytZU7YR3z+8KbxzFa5AGqlbjuPtVhNFsa5zwR57fIqPiadD8sIiGRLIVibne?=
 =?us-ascii?Q?vDtXMBvfgppa5WQfb+NqYo0+iBO79YxXR0NdGhyo+MtXx+5XZDQZGtedpJYN?=
 =?us-ascii?Q?LAJ5YCI2dZfTwogJRvpIh5zdVPCDYGeI3h7zNHJbE6Rz8Nx13LqlY2jH7D+j?=
 =?us-ascii?Q?T67tymqndyThUZH3NOSuSg8+o24K/rPaLYwFJfSKh2/+PEIe34UBwtA7Xd9R?=
 =?us-ascii?Q?7TuRQV2f9MOLKHBM3GPkPUH8/xA/u3d2xO77JMcO+/Bh+0nKGlniKCbhsXc8?=
 =?us-ascii?Q?8VgX9d09UYAFy2Sk4LN9tm1OlHkpNqNgrZUl7ywX+xGXAvLQqhINWsELT6wQ?=
 =?us-ascii?Q?LoPtC4QYXKpefr8S1o1otqrFuCRsppdi5ZHbpWCsaZ1RCK3AKF6dd+nfhARq?=
 =?us-ascii?Q?iGjcTHR1fwqMRsMtEbafDfzQIKEkxcnc+T1gufsJH2D9xRkxDvrbB+otimvk?=
 =?us-ascii?Q?pRRhwEZwLu2HLFTHT2Oa9auGMFRI/TJ8tkql/rCi6QQY6zlaAz+EqNTOn6//?=
 =?us-ascii?Q?A5HELPiDA5hG7fJv1JeAqyVhbnH1fMShhBWIRdJ9JhQ9aWn0jvS1V03V2Bcp?=
 =?us-ascii?Q?12qqxErdVU/vtpJHJc09NsR5rn3ZzrW8UEnshTRsv2LilodUVUA79BYOcLzY?=
 =?us-ascii?Q?35y0W8rA3NtKbYAD8jrl6LxZ27VyqwWLf2Bls4YjW2ACYjf6mm7MRZJCWWue?=
 =?us-ascii?Q?RkPBIGnNM3a75MsFsLKhxd8SX+TN8gbVNUrYVekpRvm9vf5JbDh39uxBRMRU?=
 =?us-ascii?Q?WWt306O9gury7E+/n45OknJn9MojNae/jsShVvO7cn0r3neetP5sExC09zPy?=
 =?us-ascii?Q?OJxoGesZvFyV0ndAIrt13USfU84pV2e0qTa2ZgDP6SzuOb+ZljV47+xD/Jg9?=
 =?us-ascii?Q?obtO7gDlHsZsvRjgAYYR/8brPSbbZ5qb0Rp9893O/IHQJg7sOiKvZn/uca+Y?=
 =?us-ascii?Q?+N4+Vy8+AQJSmB5Em0fm1wody9rWDfCZG8rPTnhwNpo2jx1LORarvMETsKL6?=
 =?us-ascii?Q?1jdMa+5yol7xW9t4Ed05WcgRHixHqU8XVoh65Ozb92FCuMOrsmxhgL6XuVVV?=
 =?us-ascii?Q?lilbU7mWl5u1g19xbczkQhlEjjGP+cS9?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 09:25:48.2003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a29d4a29-6cc3-481f-f47e-08dcbdd56a0e
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021D.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7292

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


