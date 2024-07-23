Return-Path: <linux-kernel+bounces-259824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9B5939DB7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8846B2251F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA801153BED;
	Tue, 23 Jul 2024 09:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="LQ4uT2LT"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2077.outbound.protection.outlook.com [40.107.215.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5497614D2A8;
	Tue, 23 Jul 2024 09:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721726677; cv=fail; b=Vfm/yqtrX0/YH7HqhQwhspphOAi+/506/nMVcu+k5QSooew20M70UOCXt4ptk+O2kVyhzhsYymQDwePoZ8V0eFCk2HABeG/bML49tqMQhtTapjx38Jnbgg9hxkVuvoOG+SgQdEQxsNqqNX+2K2RcOdciaA0GBWKJLy9JzGbkeuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721726677; c=relaxed/simple;
	bh=Gb1cMubfab+esZE2lUZ8pmnTHC5wWT80/mJF+02OPjM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U/lSfSOrppLD1e36FjzlGWhMImoKcHdpZ7YRhZxGMhKZE/4eFNFXeKsJ2b+ekCbjpr3OL28XeQTe93BzKNGWftGYCGkiDgR3YDkMZsLXE7fiXSskF4AtMen8PwLQKyU1bhfDcilDCWRcgWtiP6YdfMZ0nzJNX3XFEn37Db4a77A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=LQ4uT2LT; arc=fail smtp.client-ip=40.107.215.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vHC4ifFYzUSn1GHgByqqIZCkqWn0kCWVbbNg01aAlB1JFHHnwEQ+Bz57lT2BkbNETT40AMYH9Z86mrt2LnEYMKlW7Y9dQ59Hz6lginldeWgoyRr0YA+Jj5SSjuGCazB4TCYM9N5xKKJiHAZ2vAsKGYLfMBQj/rPHe5qBL/IcmvPOpPEvQ4E1nfcdgCqFhHNI9OjFMPB0IJ8pSOR35C+nqf7cAXqIvezUrH8iF+zDWqraw8uN2OPlvqVTG4NMDiKA+TXMMNK0vME9YVY4PhFN3nakIgR6MOoW9Xw/hER4SiRJ4pwj/yGBZfYS2N4ZX/b5tOxBUrLarRxw2XgXR7hknA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKDiGhY0qi6Zhw5yz3X3KRvVupBpI62BiZwruuZTFwI=;
 b=dMPqSmBqwZdak77soUMa/BePImS2iRhtIUs57rgbTEEf8cdbB8KRckkVrsAYiyAatlkjXKTLwuKbN7F7oJt7/8L10Udd2vKSGXwkcfDtVt4EDb+GO5FLpUoZ1JE1XLMAM7oRBTy1/Gd0VCtlDoYCbbO7K/iDAjGQDgSyts4q4tMtcGEz+eePbxqWqxzPcjQGiznwif1TZlmtupzgkI5xX1xvDvOEtRFEIMoivdWKoIxGz88reCUeGE8mpdOoNn+ykw9tqSdLpmCca23e2aD7QL5X+WGrCAaLJ0WVAH3gqpprv+d9t2AJdYG8/RlJ/F/doEUtpRROaPOUoyzdvPeX1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKDiGhY0qi6Zhw5yz3X3KRvVupBpI62BiZwruuZTFwI=;
 b=LQ4uT2LTG3kCProoJDomePRNJTBy8s7F3R/xmQlJ8iHn8xt0iGTvWJeH3CGM4aZDScW8ZsIcB5RsHd61N7N+7CNZPtGrxuUzIEd133bA0cKEIQutIzJmGxKO9LaeKhWafR+qtJ6335+79bf4bWd6I1a3QlwYp82JW1M8sEJ/sIoxufS/AxCD5KRBfUtRw9MCyYW0+hiCMPCF56AuWFIgXdBPUqWYO2HnPlJWTsc0SjU57wNxcQVbL/rSGDmNZFLSHIh2Fat/Grj+Os0H+ZIOLZuiKGitcspvs2vtewMGrO/e1SDm0cSz+8yJCD2KmipSNpLhOxG8rupWxareQvV1pA==
Received: from PS1PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:300:75::35) by SEZPR04MB6825.apcprd04.prod.outlook.com
 (2603:1096:101:eb::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.7; Tue, 23 Jul
 2024 09:24:32 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:300:75:cafe::32) by PS1PR01CA0023.outlook.office365.com
 (2603:1096:300:75::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19 via Frontend
 Transport; Tue, 23 Jul 2024 09:24:31 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.7784.11 via Frontend Transport; Tue, 23 Jul 2024 09:24:31
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
Subject: [PATCH v11 20/27] ARM: dts: aspeed: yosemite4: support medusa board adc sensors
Date: Tue, 23 Jul 2024 17:23:01 +0800
Message-Id: <20240723092310.3565410-21-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|SEZPR04MB6825:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4fefe3e4-6e5e-49de-6bd8-08dcaaf94270
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zAl3FXKn4sBd7DG+DDKhGxv9V1KyFztINsh0NWsUZIK+L98MYiFFGhF/iRxq?=
 =?us-ascii?Q?Jg41X9b8TRj/y/0pjP+HdD5YB/U4G/Fx2DlNw6KOP59eZLfDI25qhdsozXA8?=
 =?us-ascii?Q?+9pMnKoJTqb+/kiw+OWmC+F0Gt1TCiQivn7brlUXtKS8IKYueZiyglfTo9iM?=
 =?us-ascii?Q?rZ9DT564PTV9rn6wDFSFXJ44VC4TT/ypcH3nbq9j39nXCWO+D2yc/8Zq/6Me?=
 =?us-ascii?Q?gDha2G58pkOE6wJzIcqkI/dZa7BVzncl4RZuX+Yg3b6bxEk5zUamL87gl5hO?=
 =?us-ascii?Q?r7rqioXX3WKix4i2bZCzl8iEWMwV9XYUTM0CytqG9Xdl37dk5waQxTCeEuA7?=
 =?us-ascii?Q?VWVMo/6yhLQq2a6RWzQD0Ad/KZ/c3uyJ8oHFK0kvEHBPfoGH9lxAxgRxajVX?=
 =?us-ascii?Q?8LHVgEQfyOCRh1XQeIUhY2SjJInNuGzZCWu5jrLze0rjotN3/n2HA1Dsw1WM?=
 =?us-ascii?Q?TJYbcAWC2OnSXyr3MsxQdQz3EclnzzLdSkcDqxWisbLWeveI67KQAZv8C/Kq?=
 =?us-ascii?Q?RTTUWJckdf45h+O2ox1oAIXS+qmTd8acGBqTp54WA5R7VpTvkPyFkAQvEHI7?=
 =?us-ascii?Q?vbpzOUEIYWxDqY/FwQXdRmLQgulrxQGBSeMAh/ZTPwuMHAuPVDvkwwln+nEk?=
 =?us-ascii?Q?ZeoySsSy+wGmYvb0wveKk9E2svkNTD48ZGdH31igMH3ThMxuQv5R7+o10QQ8?=
 =?us-ascii?Q?skOjQNXEbW8NEGAxwaYisM0w6gmo9vZLGK6T8s9wEvexKFINyexqqTaeev33?=
 =?us-ascii?Q?vph5usO05yyrMrIvX14oE6QAF0XWS0Me78DUjuj/oihyRfLquE7DdkNmwVPl?=
 =?us-ascii?Q?TjxxVI4DVi5VW4frxVGBOBlA5d3+gnrUZJJ8i3sjr5+AzBCF10aysm95TUfi?=
 =?us-ascii?Q?5Fin2c9SAfn/ed2e/pDVbi21i6Fa+INpTGa9S7XZlmEkT/99Y511x1rWUGVy?=
 =?us-ascii?Q?jyx2PO0DeYq6Q98DjqOqSvjMgcqrKQXiqlj/6xIdslzroAtanqfcZk159L6a?=
 =?us-ascii?Q?ELR6dVa559mhWKwzwpFgZk1mzHt91ziSJJYGogwO1ysn+x5tWJ2O1Dr8Q5jc?=
 =?us-ascii?Q?12p8UcgH9su7zkAoZk1+aHjTY0nifUnH9otAN8FVccidyrV63PKFNHRKG6mV?=
 =?us-ascii?Q?pc4vkI9f/jVgWtdWddy7luE1dvvyP+GBM/m9YdzsLmVyjpHzMbCa4/pNrzI4?=
 =?us-ascii?Q?aZDagw6czn9fPcDJo8NA2u/p2OOsMbHXi40WmtT6wk4i6n6CreiWJJyNBlG7?=
 =?us-ascii?Q?dYPtobTk6/W41XQGIMO4TnFhIeXSsaJMN9BcFtpgZy0+aZRCDjT6ua6K3Z3r?=
 =?us-ascii?Q?UC7oxlQJW7/Dx3vbQiLy0HITY3CFS0jclAIXYV51KN59wVQGYpVm5N3+cdwj?=
 =?us-ascii?Q?Yg/yJpbFC57xtEt5qsFUtie93AVeBqRewiD3iI4eyPPFxckoqSUiCurEZNKg?=
 =?us-ascii?Q?k5DyxECmXlxHM6FynjCw+jmN3KJuLyf0?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 09:24:31.5822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fefe3e4-6e5e-49de-6bd8-08dcaaf94270
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6825

Add ina233/ina28 support for medusa board adc sensors

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-yosemite4.dts    | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 98eeee49b082..49500db53a13 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -915,6 +915,19 @@ power-sensor@40 {
 		reg = <0x40>;
 	};
 
+	power-sensor@41 {
+			compatible = "ti,ina233";
+			resistor-calibration = /bits/ 16 <0x0a00>;
+			current-lsb= /bits/ 16 <0x0001>;
+			reg = <0x41>;
+	};
+
+	power-sensor@44 {
+			compatible = "ti,ina238";
+			shunt-resistor = <1000>;
+			reg = <0x44>;
+	};
+
 	temperature-sensor@48 {
 		compatible = "ti,tmp75";
 		reg = <0x48>;
-- 
2.25.1


