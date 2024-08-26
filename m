Return-Path: <linux-kernel+bounces-300810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6231395E8BA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 876061C2087C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B63C143C67;
	Mon, 26 Aug 2024 06:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="K0eFhO5o"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2083.outbound.protection.outlook.com [40.107.255.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E9A1420CC;
	Mon, 26 Aug 2024 06:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724653546; cv=fail; b=BXxVjkyUMVmBNmu2Bg/po5PnvQIAdhtVbQR58vMK6F5yzzzHhc0mSeEy5g9oLrV/15eDnvkNzcTUh8E+Iozlt1TbFWIM9Cg6cXpSOuWUxdzXnRNjXH+HClzlB7Opkfdwh9oFBfahXVUxRc3RXHtLNBvexwxuHSSOeoW5mnJWqfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724653546; c=relaxed/simple;
	bh=1cxP5pczgJ7valwzodgjXvVTCSFyJVT8lUAovr6nm6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jy4LOHtqJTCMGZnJb4ox5iQX4rIaaAqg6+CsegYmu8rFA6xMp7Ek3UGrrKhXF29uZdSyTEwZTq15iX3KX35aHchzeEW1558sJePj6qRVwjKiw5iCLz+9FE4xOFy0Cgw1MJ1Jfwm+ghzWflwsp1igcrfpDzRec8r4n9q/+H138N4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=K0eFhO5o; arc=fail smtp.client-ip=40.107.255.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AbLTTocnyey02sMD0T7U4M1nqgF8ZRGhY1f8JSg93plDfNu1X0ef+CudK8mABy0OHuD9s7GGycTCduJcVJLhQ+j0HrQ/6ayMiddUv9GewW66nV/T80DkK/hVLnpZoc4IrwvES/K44ZERP3PsjrIulC/htGTQMzMr4wQsuvPFO6KagOcM6kyD0CTdZnJgJLzsBIUUVyXIMc7uc2vAjrod+RPLS2D87QjtQLBR9dsjct7cC9Fvm8t83heHas74ySAedDla7wJswuqLP7VKGEcA7sk167FqRqHT8JXCQ+S4Mm1agR3rsg9ggbXv8UDx4DCb/zfWznLf/NjsFfzCwp7z0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=deWOYRp1IarhLB5qRFgI0h1ErIRC5JkaB/gNs5HJuG4=;
 b=EuJe1tJ6QaGBr/NCrSzNPxZFCbzl89COE+hY6X6h0VFU0X748Uaz7tTldRxuvRLW4Gn2qN0KQdCx1F1PmL+qfM2OCpCkJsZZKM3dZBBa9U0DcR6Rp12figfZ2YJdZmeWmWZGZrmFWedqDLl070iFGXUhp6WlvadMSF27XQ68zYbEfBW/0QUIE1mPxiTtTuKTB9JNZEximwP+eZO9kqa7xroziIPULv1xEBr7mvQ0UBDbhoollp9yeaUsxSTQ0JFTfPzZ7XFm5jO/I9lfZoZRGla9r0BePjkSa8N3CNbaWkg1JF8CcTbDSkbFvqSSIDwXfh/BP53U1bXK4wdwdcgyog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deWOYRp1IarhLB5qRFgI0h1ErIRC5JkaB/gNs5HJuG4=;
 b=K0eFhO5o8bMpy4f9y49uExWnPlqFJAi2hhErY1q/K5aSJWcic9lTmZbxs6IKZPU8CNIW4t/9VA8SjYyZyPFQMRtso2nrCpxjCuGpmHVisVdNFrV9pWL4Tn/drpEt8rusv5dEo4B/Jwdz1f6mWP+u3CyjbZlOIaLSJUyQdGcfXMQ5WBG6eOUtI6Nl0VoAZg2O2M7y1W0YlegTj5W3RWBX+HUy1F6bdCCuWNXzdkefDTfxATW6InBOvCUWpH2y7dw06r3J7ZNESgYcsDi/e05xFvqOj8zI+4s4pMjRNxUL/rjlnpdXw7+/NJ2fxEQEtklebVEA9jxsnppqzJ8mqgVpKA==
Received: from PS1PR03CA0006.apcprd03.prod.outlook.com (2603:1096:803:3d::18)
 by JH0PR04MB8086.apcprd04.prod.outlook.com (2603:1096:990:9e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 06:25:37 +0000
Received: from HK2PEPF00006FB0.apcprd02.prod.outlook.com
 (2603:1096:803:3d:cafe::bd) by PS1PR03CA0006.outlook.office365.com
 (2603:1096:803:3d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14 via Frontend
 Transport; Mon, 26 Aug 2024 06:25:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB0.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server id 15.20.7918.13 via Frontend Transport; Mon, 26 Aug 2024 06:25:36
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
Subject: [PATCH v14 18/31] ARM: dts: aspeed: yosemite4: add mctp config for NIC
Date: Mon, 26 Aug 2024 14:23:52 +0800
Message-Id: <20240826062408.2885174-19-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240826062408.2885174-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240826062408.2885174-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB0:EE_|JH0PR04MB8086:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a4368dd4-7691-423e-e5ae-08dcc597e625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vkQ7hT9kSElz7gKdQGX6jfquluAqkOILJBfr1QMsZ6vYyz8iwJRWwhLNvZ5o?=
 =?us-ascii?Q?q2K4I+UiCIqvhhWimhIAqh/8nCp8RjlZ6aDDZ5dwI29lCnBySdXU3+zclZj9?=
 =?us-ascii?Q?bG+BuqV/oO6mCcDreA7wrl7b/+RHFmFoaJGIrLorq0o+i7Yz0OfHIcb1gq/x?=
 =?us-ascii?Q?7EaJmrc7PbR9JMLduutCFC8xH8SF+GQaNn9E/WK9PSrjvi+l1RUf/jCFwzLg?=
 =?us-ascii?Q?s6+cbmtBFJaVchWyLNSrvlL07WztGR1j2VgpfvV5/ZzL8AbPvGg5SC2OVj6V?=
 =?us-ascii?Q?MNmuglLcwFEKVSAK/EzJlIzmQh8GR09eaKdS9OCMcGPBUEv2W/Uh3elg6/F5?=
 =?us-ascii?Q?Ohob2b57w4NLlF3x//Deuzf914hesfaXpycCSsCJ9E73eWj+TDZeVuIVR8qi?=
 =?us-ascii?Q?fwyLa79slc/tENrdZ7dmrL2n8lJdSCgn10tHp2o5a74LyNH8X4vszqmGtwmU?=
 =?us-ascii?Q?OuCTiJC278RpcyLk81731IS1cVvDrGl6WobEvJq+ofp/w8bawYetEGtYzkZ5?=
 =?us-ascii?Q?zdVy10wgTUOBCN8ZYSujnGk5oGqchLM5K5AoI5ILr4svCJnxf/RLwSveVB5I?=
 =?us-ascii?Q?YQFb3I+i9Te6WkT5sTaMEyNQ5zL1YM8KX8PjbeoL9VlLjJFiPZtwsBQlMO20?=
 =?us-ascii?Q?cnuKPL2kuR+cwOHyxqvMGgrphTntLWJsXn7czBGEjq4l9oVFZsWvdiOOLJaD?=
 =?us-ascii?Q?TTwRoodq8OcS9oafX+Qwj7+IfYFicWVcqKTF3wr2jMey9qzR5QaGYuUf5ow+?=
 =?us-ascii?Q?IimBnFLdrHidjiGhNJhoD18h2AOPpAZ0aGFRvoaVVyIwsKNXxsFTKYXNmVg4?=
 =?us-ascii?Q?CqzPwoAbTrtF6TCT9j/MoDuQF1JXi2HI+mvj2280kQDg3XkgPyWCVG/Hq68f?=
 =?us-ascii?Q?cvj6m92mHKwI0n9sehyBDwiAnRdDeuQuumptNy03MZv2LXiSuI8uIlOuWJqs?=
 =?us-ascii?Q?YVpchid9YYHyN1dWpKYtdXzd7OP8jaYler2EdFuteC40y3fI7fvqEkBHlaKB?=
 =?us-ascii?Q?NU8/toSPmgqy08rrxg1v1XIslTWFxhbn6s+/Ey8A0hE0o6VEdTyElYhfJOFI?=
 =?us-ascii?Q?IPTi7k6ULFROyyNr5P7TIzGBE1/D54eW122z2iz2N/D1WEtT8RqhQiQWItpd?=
 =?us-ascii?Q?S+rtiXgMCmifibR0GuXKMDph+MlfCJ8HgDJObxVHj0Q+QWeZ4c3iWLjb007t?=
 =?us-ascii?Q?/NGI/EUrOOGVdR2iAQ5UdSFie6iHYtnio7v+DPUh3pDvyjXHK6U7+emfTM3W?=
 =?us-ascii?Q?Cxeg1rYzL53GVbqR38MWrVPlBEVUfx24yd8v+Pt0b3gMM4Jg5jmXQTcm8GEt?=
 =?us-ascii?Q?Uam+VjuuDFNiZOIciQaQv4qlVbGX02FVXXUFaiAr7KNzXLDUjl705dewa4AE?=
 =?us-ascii?Q?6cDxhT6KoiUFnzdBm/zUCq6BnJiw1D9cmQWqm0axPQMZ+XtVLEVw6/thImlo?=
 =?us-ascii?Q?4XF11HgJxwYA7wgt+TuFCuxlmNSGd3Mj?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 06:25:36.9557
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4368dd4-7691-423e-e5ae-08dcc597e625
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB0.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB8086

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


