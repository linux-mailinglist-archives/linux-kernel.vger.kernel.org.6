Return-Path: <linux-kernel+bounces-256993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AABE89373AF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 08:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 663CF283E0D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 06:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB4313212B;
	Fri, 19 Jul 2024 06:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="xRstw9lQ"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2048.outbound.protection.outlook.com [40.107.117.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646E143ABC;
	Fri, 19 Jul 2024 06:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721368836; cv=fail; b=M+m6/yfUO2I+tl7kfZmD2T2tyXfvjjGhjNi2mZJCgAsJdLolsMvTqm92WIlg5idiYrpa5rZM2QIixIf66CH8ZymMJz9IeNRy7RbhWWP4zKmeSucZtBcLE7ruoetImNBa3iuP8zouSA/rXqEiIgguTOfxCQpGWOkwqWM9IMrcP1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721368836; c=relaxed/simple;
	bh=0/RZfxELZSv5ixlsRWXl29JeFAUJDoCFh+RoEwRg0LE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RuFQ+Ku+VWivs1CELqffHdw1851B4UR/zDcsEyTrEBgcDu4GarK8sTgFeYevQTHoH1lziuaZKxHaqML0OzN65LvQZs7UCQsMiKTRHGrVJGCoEraqPHvnQeRmFgZDIPpMeBm+3Iqqr4qXUGJ9CrQD8IkIAhr1RRWb6owSNrwhWuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=xRstw9lQ; arc=fail smtp.client-ip=40.107.117.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZFgwkmKvzrvW9OdUCVC7UDxofpcZZO6VjVsnZDQcVpdZb6FAkV3/e7lUzpo6rKmySduYDa35GKtmnT2r65l4Axaoff37jBvopXCWNSEKdwX9ab4rs5knEMTZ6U239gasQtHT/PPmKY540uWEkXeRQMpej2Rn20Nvb0K2M7V4rbosN6I++I80JeewaVcoCTq9d83efH6YUP7RcY5cS9KM8azbRfDMFfHqe/xyrdktIqTUdTYoomh9hIZgkJHer+Q8hEW+B+8JBv9rRStf0+bElPdRmaqzg3pDCQuuwzHgC5MmSrZQl8iecqslJydl45hJColpKH0aHInjpXHQEjzlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O16c89fsxykpLXkgqq5cnVpUTCPvI9O9YW+Dewzjs4c=;
 b=curbIA4TwSLa+za7ZtTgBFGw8dZePBaTysePdmeh4h9bX9qyYqOBn8Xten+OvvKBhmDItplZaC6tDitikfKVpI49WjElJLFUtvd2zSCkE01cmtC9W/LFwes0X44S91T8HtIcZ1RTD92g8Imj7j7j50eHKLOkEQMi7CYLJxg7iT8BTvFRk/edNgC3DGGE00J1y6/ZwTnhDRgLagXQ0qbd+0QdqeZyp+3gi+BQly9TGYpINkTAgxhkWOCQOE6AWRCCRabZQP+HGdpIj+GQjo5TBD3ouipLVQlJGz7xAUyhSc9Mzp22KhVIsiXQoLyzoKTvU78IF7J4SJ+/POUHczzIUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O16c89fsxykpLXkgqq5cnVpUTCPvI9O9YW+Dewzjs4c=;
 b=xRstw9lQ2bl0+RLEC8bgQHwQB4remJA381Tos08n8+CMkRyZhjcx2Ryle2EGikwQAfY1CPfP6JcEVQjSZAmKRQxUWVYbto0wGS8Fr7EB9mnljKbLwfVwx+T0Sf7ZK/jrlaAplPNW2YHa39SmseNp3AuMD8pq7SLDHU6qyy/WpgZuWTuwtSWmlyDXfTY6yQOZCtobMg2HDc7eTmdOo385nOLwWzk1Bqmnfy+awQQz+hjTa8EUvTIT5a33BEJCDjBM6yqvVbtVysr/k5ky8VfbcUqKhMcpiuRj++0rOZUeM4MdK9ciejkdQUAMnw3bsXqZ+nQbS0F0kvRcCfuJ4M8RZw==
Received: from KL1PR0401CA0022.apcprd04.prod.outlook.com (2603:1096:820:e::9)
 by TYSPR04MB7445.apcprd04.prod.outlook.com (2603:1096:400:46c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.6; Fri, 19 Jul
 2024 06:00:29 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:820:e:cafe::94) by KL1PR0401CA0022.outlook.office365.com
 (2603:1096:820:e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18 via Frontend
 Transport; Fri, 19 Jul 2024 06:00:29 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.7784.11 via Frontend Transport; Fri, 19 Jul 2024 06:00:28
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
Subject: [PATCH v10 18/27] ARM: dts: aspeed: yosemite4: add mctp config for NIC
Date: Fri, 19 Jul 2024 13:58:47 +0800
Message-Id: <20240719055859.4166887-19-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240719055859.4166887-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240719055859.4166887-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|TYSPR04MB7445:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: eebe68f9-e2de-4deb-2a77-08dca7b81774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013|34020700016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?huw6mk0DBlMRKUdwPvNUJLdUpPEd0jSv2rOKtCrXcfHEvQ/enWeygSBTe3Hy?=
 =?us-ascii?Q?9UhaDzPymENdJYCapQ5ZONRZNlSv4SXbYLXRagZZF4l/wLTbMWy74br4OQhD?=
 =?us-ascii?Q?ajzbqzsRduYx9+nitUxP6Uzs08Av6AaEj8FduJ8hhimLIFTBvGyQ1skePLVe?=
 =?us-ascii?Q?VXpruOnpgNKTQyDi9SSIDJOuh7ZdsxtwSYNqy/mU3liWWtSaQ0f4obZQq1AE?=
 =?us-ascii?Q?KRtbxsBjcblRuLaAEkyvy2w7CJIjLZ/FWsjAaKNukB5A2nQTtX4vwnjH7V16?=
 =?us-ascii?Q?B2TlhbyFFv2zykLlIAlbenW3hUzTShNUH5g39BxVHv55/ugbkNNLOcvYm209?=
 =?us-ascii?Q?j1hPl1GLhxjcxxixClz4+RZbH8gG+8bl/1qmHgIC+VD85x7CH9woiUU6mg89?=
 =?us-ascii?Q?HWGJEVfsr6dUmJ2SCQYSF1M89Uje7WYCkBKJXStwvcV4HHIfhoqLtohpi0MC?=
 =?us-ascii?Q?0l2P8tQOq05Dap+6L4TZXPXmShhL1p3TJ67Dc0oEdgwvfjyJbPXTqsCYoEGF?=
 =?us-ascii?Q?DexZboITBCQ07rvHRRwyFjBRFzrq5C3o7Fl5nAuHFc5oRPP5BDVyOS8pvwVX?=
 =?us-ascii?Q?gG/fY7lLJo0M/FEUjBm/cF83W8N3G3EmNOZV3nWlIfiTYcTgF+ljJ1p7/QDf?=
 =?us-ascii?Q?kmYISJ2qCZxBQV2KW9VgWTC8IKS++LpYiu5JlAj/rY809UUDL/XRVdlO/nqy?=
 =?us-ascii?Q?a3ZqE+QrIRyXffCnWj4lkqt6z9ONx6UcW2EhWfHYEkvLVl6m5UD7qsr/g2pk?=
 =?us-ascii?Q?9iRQihQCpnqnZFsAEsJCH3VOIjV7MZ3O1ICtvMxANsAcyG+DOcT0KG00tXll?=
 =?us-ascii?Q?xImD7uZm/fnaQF3e7ogayhVtvSIxerXXqJMY0oMFSxFhTPvJke/l779p9mpF?=
 =?us-ascii?Q?V84CMv/g73OSpRJNl/fBz+ZfsWQ5uZzEzl8oyUcn20SaUNK00PVATkTf6bZo?=
 =?us-ascii?Q?oNN2ZG7bDQWCDtxuclZyU4pF9lc41G5FMDWbS7Bx11pQlKsoV5l6yj11SjLI?=
 =?us-ascii?Q?/ty6Ow5immNPg4H50rLlE8XvoOIImNa2ephXuKAFdCRSfpWBxKogpGqNtK3B?=
 =?us-ascii?Q?Dp7qxJAWladMPl6lIIK4H6HwaI10eSOmQLU2YRdEwFgLUn2HqR1KB9qpEu64?=
 =?us-ascii?Q?gqiRPgCUt9QHQ1dyZRW1nz2a2bsB780pXrynft4KRvi1HnsnvxaGEvUhX4Xa?=
 =?us-ascii?Q?4aA92XnFRHLqGaAVJ/WWs+dIr/Aqg9VdbO+R+0MNqfhwQIBXRj5NL5gdkGkL?=
 =?us-ascii?Q?LAAeVfim31jJSgxCvuIXxawNTmgYJ3ZkNAwndpfggQuZql3X4N/BwV0g7FWW?=
 =?us-ascii?Q?tk0QA76rgl70RcNyZKIpNUhQG5Qd4U/ybvGEB8UPhXF+ViIOt+2zJtSuwW4R?=
 =?us-ascii?Q?gxK+RobfxWVMWLr7g3iD+bP9X5SEIvC0zPDSdVxmOBMTFI0D74gB1S360I3Z?=
 =?us-ascii?Q?wIeX2PMg51RHeHZkqLuSsM+fVb8R0QGt?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(34020700016)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 06:00:28.6421
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eebe68f9-e2de-4deb-2a77-08dca7b81774
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7445

add mctp config for NIC

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 59615a6958ec..83c9d76f5a11 100644
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


