Return-Path: <linux-kernel+bounces-230367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC04917BDE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA01F28471F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810021684A2;
	Wed, 26 Jun 2024 09:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="cwhaJAsx"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2043.outbound.protection.outlook.com [40.107.215.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBB4171E7D;
	Wed, 26 Jun 2024 09:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719392908; cv=fail; b=VRcja/EFUAr2KRQLsmPV3AzBD4Ytb4oZvxRD/XfwAK3httL7ucWbnagNf+bfhsBwJ/nm9cFcYaiopjQ9lg+qi2Hgxj6b8YB71PMB2mw0PcvifBgVjpkWYUwSqTjqXJ4b1HzC+rEqTuikGs0RwFWt6hDKcouq1+YTEf0wwjhjhDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719392908; c=relaxed/simple;
	bh=p46/iEbtucdsAZ5iLyBpexuMThuhsad8XBAxzF3ngFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RgZuAwGxsG9pXsLmTL4Bmlk2QJthkqq9RZCzKYsdtFI8ljCNUDu7TUhyJ7Z0W7aCwr7UAmLr6BvO4oLEwW+mgyWrLn+V9N2TdQR2VRVy2qr/bxUZGkINsS6RTnMMKdignHWZ9OkMQucAMZf5xyTPnZvqavntEyJ/7lpb11iusY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=cwhaJAsx; arc=fail smtp.client-ip=40.107.215.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lb9+BptxOXCGIcAiwcI4HAwyVkJQR9R0Z7l/TESPFpytPY048QJKM5HIRabFJdqZHahXHWxRqdlfr1vNWWOPYRSUnCj4lC4NlDQp8IlXJuUgQ6X9Pj4JAdgtJXvgUopaMx3hpvpBBjueVRFQu2qvvCFIINyiDey3T7tDbZ8FAeW0kRS9XBhMFRAVSib0TPopkBLXPeTYUBLAikf9AJYUkwROcpuS22ExYgJHRHbAyRF27ut7UhjCM5MCA2M1rvTE4+gbHy1q79SrrhNPzJQengJfYcvaFTG16cJF5XtPA1gMDrb2/DCR/mbY+0zhhQ4K3wIg0H+qxmwjJfSLOKAm0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFKimFjZ/HhebE08E0uoD3C7UlaPmpkE4lfEBFrj+a8=;
 b=eRjkGD6b3bmpl6d1296KD3s47gAICQdh9y0d2/SlDFNULr6gsAHp+3rm6AvSI9IsvZxScvo2A7hEeQJ4Vp+/OJeOlumwcJQoC1QHxpQWGbMiJOFS0GWFKfC2Bhpuntt4SbDpe4+6x5aMtUbMRHMQGwvVN275lwNMPMbPuUmz6sKLClGcrG5RcFe/5Sp5fAmK7iFenInnSYnXCRPeyNOMZPfeQevvFIm8USOeGxTSnc6X7m4WJjSF2UxGzxN24NUOYtnJP/PshH8eN2NoACBty+BlpyEYR5O3iO5J575DWXs6+Q/FgoigFBThFx0cYY1xCNnKYn0yTyVvYckpoJR42g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFKimFjZ/HhebE08E0uoD3C7UlaPmpkE4lfEBFrj+a8=;
 b=cwhaJAsxQIqtJ0dahEw9JlfOsLYQKB7s8soA7MggXwF3TVLWmCAw8JKnkrw6UHWXKJCjopgbLGALtlf60pAHi2Dw7H6JM2q53qjw+/TR8WXtNjPyW5piwUTlIdkRmu6CdYqb1ToXIc1a5RwA1Rc6V5PTzgYjh/YkdU2YiJX4nLqs+U4iJFa0JUSUJRYwJqMhAifnpy2zIrO9AbqTtXKB3WJJ4tVHNqa+/cyGkipuIz5Mpzf4aJShaeWI0qP63CpfXNlzjzu6f0+Tb2wpt7f4LNYxCLvTM3kl8+13TbATBFeZkPlnZI8eufrDYqg+Ymw9S3xFFnpHwv5VXWtP61EZ4g==
Received: from KL1PR02CA0002.apcprd02.prod.outlook.com (2603:1096:820:c::7) by
 TYZPR04MB7179.apcprd04.prod.outlook.com (2603:1096:400:451::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22; Wed, 26 Jun
 2024 09:08:21 +0000
Received: from HK2PEPF00006FB4.apcprd02.prod.outlook.com
 (2603:1096:820:c:cafe::66) by KL1PR02CA0002.outlook.office365.com
 (2603:1096:820:c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Wed, 26 Jun 2024 09:08:21 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB4.mail.protection.outlook.com (10.167.8.10) with Microsoft SMTP
 Server id 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 09:08:20
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
Subject: [PATCH v9 06/26] ARM: dts: aspeed: yosemite4: Revise power sensor adm1281 for schematic change
Date: Wed, 26 Jun 2024 17:07:22 +0800
Message-Id: <20240626090744.174351-7-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240626090744.174351-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240626090744.174351-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB4:EE_|TYZPR04MB7179:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1e41d5d4-9e4f-4b03-a930-08dc95bf86a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|1800799022|82310400024|36860700011|7416012|376012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+gFbMUp9kuaxTQgT4qdQgbby5T7NjxrsmYN4//qvOKgjlF+SYv2/n0iZShIn?=
 =?us-ascii?Q?EDYmlBzZvq0ExzqFbdHkim36JaXTIrHr7n/MP4nbB3WOgL24CWZ8k7yVhTok?=
 =?us-ascii?Q?GUJxIPqegwOV7iw1to2HYRxeSAf4/5iTBhqbUwzFN8LAKGwSMGVSPTTYHUyr?=
 =?us-ascii?Q?Xog//Qr8pP5V36Dslm75awJgBv89lbv+johzxR/dRDpULbURM/eEmW8Rqj9z?=
 =?us-ascii?Q?ivr7+abdXObe1vfH7O7ZNbCNF5hvqhFGA2ONmHAbNeIWfjgN5ze098IsOIan?=
 =?us-ascii?Q?dAJiTwPfq57gSY8lJA6j+8+okCuDm2UBz+Uc7Z7fPbSnFVkYLLQDhXyeCg8k?=
 =?us-ascii?Q?6pPuLDCmNRYWgfYaTZLJLcODPS2UWRSF7HsXZn0KG019V6OZrXug1Zbqnbx6?=
 =?us-ascii?Q?9LM/zFs1M8D09QRaSr/3ee8vd5BC0dQvoM+81UkbapQy3gUX9Gx1HuMRZaMK?=
 =?us-ascii?Q?dPBXiq0oURiV+Uw3lxAexR1YGUFRvT6jk/adxzdjeCnbIBi8723T0Qq7wOav?=
 =?us-ascii?Q?8LngCNuvyIoll8HBs5l4zKn6uDoC0c/5C3j4dN+Eyq/iG7uhq+P72T9fC9Z3?=
 =?us-ascii?Q?jJohOQG9BXbV/c1AbWYg+rfx84h2jTuyaUl2bDjvMx7kxJ1+GCqe2gPJjZti?=
 =?us-ascii?Q?r+NY2CbmprVx483kAjN/sp3TA40oIl3BL4REpVXHMhNOXFaq6FvAqMmOdcjx?=
 =?us-ascii?Q?gunHoVBPL/wzLJp6PEznYKFMJIc5ISlIaggXDvVy7WqWL3SU/RPs4M/sWxj7?=
 =?us-ascii?Q?drjj5bxHvdNcGe+/H9jZCZx4eofx8LJ/djS6THsZKVTaO4L85g/vlnPu2bSF?=
 =?us-ascii?Q?GHVsKQYAj0KqQUTZ7T1pDw4Rz1QnVfm0rzxJGAZTv6Xs2hPd7cXSu8mGeG4V?=
 =?us-ascii?Q?LFh0svIY4xiJTgWnaIGxiwEoJjCIeSAZdDO8zmIKxLgXFYXiHa35WkdJQQ1P?=
 =?us-ascii?Q?0PB5Qliq6HSR/4shZyCUPYGIAIzIUdc2LcNEHVbqdqZsorAgcYBcVaeq0bzs?=
 =?us-ascii?Q?VCmiQRIVv8M2IT2zglLaZj3S44Lp/njknNoEibqeCNlUDaF7Nv4jp1siGU1S?=
 =?us-ascii?Q?Q6q2TxAGjHbC7U27xDgFejd+zKzDbIFIUEjegjQtjylNDT6yqHA/olyS7lGF?=
 =?us-ascii?Q?Q8zS2UA1LctcYBOOvOtmb104LhmE03QKYF8Go+pMf0Np+zU6HSLLgzvQ9Jon?=
 =?us-ascii?Q?yZAkUHuL6bMEpzxdI9V7hVX4FKOK4cfJ5NofHrAPBe49p3H4JF8CkC0c/kct?=
 =?us-ascii?Q?pf701et65fIfpT+lEK9fpdsX5L6/ABhhqVMRgUlbtvNQtYtBfzs3kOsrjKHY?=
 =?us-ascii?Q?TKkIegGbUDENZruxtZDZeY6D+7K5+Eq6MnYWsIZEbhe6WGt+cqQffhhdOkxV?=
 =?us-ascii?Q?DUnU0F35YHIBwgDUdRX03Qs1PS78UrbfPJkI2gP+KChWcbTr4g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230038)(1800799022)(82310400024)(36860700011)(7416012)(376012);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 09:08:20.7548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e41d5d4-9e4f-4b03-a930-08dc95bf86a0
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB4.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7179

Revise power sensor adm1281 for yosemite4 schematic change

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 24 ++++++++++++-------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index a708e56b7ec3..f0f714c7bc77 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -176,8 +176,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -193,8 +194,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -210,8 +212,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -227,8 +230,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -244,8 +248,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -261,8 +266,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -278,8 +284,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -295,8 +302,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
-- 
2.25.1


