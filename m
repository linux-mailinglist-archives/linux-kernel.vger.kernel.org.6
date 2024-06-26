Return-Path: <linux-kernel+bounces-230369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69783917BE8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EBC11C20C00
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E135917836A;
	Wed, 26 Jun 2024 09:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="oGNEDfMp"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2074.outbound.protection.outlook.com [40.107.215.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EBA178371;
	Wed, 26 Jun 2024 09:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719392916; cv=fail; b=sZPW5lnCXr8STolhOl6W5QduggiAC3cxR9aH2DS+xHmyHDdP8n7usPcwypoYeAsslQiqBG9gRvuyzN0QTJ5uOZn14iQtRS/qIl6rZxWCDXF+Zo+FcB/isNtCrTGF2WzjAbk6A2VCnkpm4KW+boLwkdRKPIlpYY8p6FsMoLHzfts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719392916; c=relaxed/simple;
	bh=AzUdi0zJNRywe/hzeEuDOFHkQ4MQRZ8PHccKu/FaOKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AZGN9M4L+l0GCi0YITW1kZrLfebONn0LNkm0a06sBRn5/1KYBVhMjY7cQSENIKfzT8R4tWVx7uNZojr3tIg2GKj6q3Agr8xERTj1Ulq9bPCu+U+awcVsXHCEyiXfNXudK3K/VbEZ73u5GhUBpblRXjHBQGgrFjQEWAC4GGyrTu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=oGNEDfMp; arc=fail smtp.client-ip=40.107.215.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kuU85h6MYZVrSb9cQR/LqExo8AC9NNrze03QDJb0gD/ac6NrC36LuvaJ+hSr8PfxTamJYHsqQRvckletF3KwxautFzZ4fmg00TXX69PlgvyyArPEUBRQtZzTmafEzdnE5pGjm5fqQcPCFbYplmFTZoEBYDvJE6RqHMTvwYLs4sd/idTHlEfE8pXGbM3r0EpFPw3Pok8drLS6q+xEQis6gZOvK5AOMX5DKgoCh3gM/JEabKqPY6fVbfKv2wiOh+2y2meEnXE+kRe6lv4HZbw8bbF/PoADtph2umD9+KT59+G+fS0xhHRWe3wxkPdlQP4uMdAQc7tcdALQZNfL+PlxQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HypuHXBWroWYlUbZ7+/af+Usbe6kheKPtiyQQytzoQE=;
 b=VEFgGWgWddHJKnXdDHrn2ZdUyX14xElARM9rpj/JhobYBnHIYcIKVcCcIXQBVZTwAb/wctS/A+trEaRMhvkVjqHN4++hwLxSTsFK14iY4r4W/i9lIUyslmCySYwOaV//mwNgA3h/2PvRzyA+lhwSIc1Tw0q53Vnvo2mkIA/PBzPE7bXTzxmfHyOUXhfK4hUmAS3lmVt0lj2zfl2r73ZoO8AJZqcEQrC80K34o/98TyS6CpsOX5YdaFq2pHuTODeYd/2mk+72MQOH7yf2uGTAdR3HTRoRItR9S6uG3JWGwexhpL8RTEOypG9xOv56fXXVhGmEFwj06t/cECrs8SwkpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HypuHXBWroWYlUbZ7+/af+Usbe6kheKPtiyQQytzoQE=;
 b=oGNEDfMpsxJMgZqDgn5CQPh9fngqLbf/c6643kA3pAb1JelNKL3ZdLxVv490LFvgPbZvSYKJ+5/np+yHEFAC/EztDmJUWgniWqmQEfMSJSUYbPrc4Wj/WtZG9jJK4llsKTdtDkNDTlQKh/NFpR2T+0+WxF7yiQzk1jvLWbPZkyZSU0qbV0tVmgv+qaP4MWdCBcO9fq//wRxw/xZz4n4NU3KxtPDX11eowPU8jC5r9BgpZvBDqCZqCHvq+Mh6KM+czwA/K4la8plySpBbk2dnmhedTDTsHwIYtFvn1N+5NkqQCI73sqkwOGmXHlCmmFTXIDmtvwfq68eD9ZIJlygWVA==
Received: from KL1PR02CA0002.apcprd02.prod.outlook.com (2603:1096:820:c::7) by
 SEYPR04MB6505.apcprd04.prod.outlook.com (2603:1096:101:be::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.29; Wed, 26 Jun 2024 09:08:28 +0000
Received: from HK2PEPF00006FB4.apcprd02.prod.outlook.com
 (2603:1096:820:c:cafe::37) by KL1PR02CA0002.outlook.office365.com
 (2603:1096:820:c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Wed, 26 Jun 2024 09:08:28 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB4.mail.protection.outlook.com (10.167.8.10) with Microsoft SMTP
 Server id 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 09:08:28
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
Subject: [PATCH v9 08/26] ARM: dts: aspeed: yosemite4: Remove space for adm1272 compatible
Date: Wed, 26 Jun 2024 17:07:24 +0800
Message-Id: <20240626090744.174351-9-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB4:EE_|SEYPR04MB6505:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 255357e1-8018-4c03-b2bb-08dc95bf8af7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|1800799022|82310400024|36860700011|7416012|376012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AYZja8d85ObeszaO/qhUjErlcvD30C8NVHtMkLNxOGX+v00NP7Wkz26YJtwx?=
 =?us-ascii?Q?S8SIBneCAPgwTyLxO981V0fq+VB72kNc9nnVAQAU8OwwrhJMVQa0kMxtKRBj?=
 =?us-ascii?Q?nC5Ux2SGnzLk1j/T3uDCDj2gfU+7eQo2HX211kOazrNnqPBFf4nC/SdYhMG2?=
 =?us-ascii?Q?9D16vUsJwIOTfptQ8RpyzI9nWgpFCOJneOEJYhzCXb8LB1E6/tPVNRuWS0sX?=
 =?us-ascii?Q?PUS7JrjfIfd3qj+rhhLE5gj85iho8JX8mEqxNPULFTzPimn+DRo1GebFCeMV?=
 =?us-ascii?Q?omKVgKP+HqM0wAswHaVg7e7i6InI33lJq4E1vR1TtrqRl4x2bIQ9+/bvR7+d?=
 =?us-ascii?Q?6UJ9wdYw7lI/wTgrRAf/zqkGVAIM+JXbY7A52jlr5eftO32dBMaaY775tozR?=
 =?us-ascii?Q?BdWgxVkO8XUDcYaab170e8sqQ/bZYs9R/pY9XXxAxHWX55eGaQRxcmSnS8fO?=
 =?us-ascii?Q?H4HiOBe5CPxxQhxFXhgefDZ/1UqgwEzqRolyqBbLSVb79S1GixIRuip0/eUl?=
 =?us-ascii?Q?GzA2iV1JFmQlIvQkW6yT1eszGITP8FnOk26cZ97GgU5LvRhRTBtx6fYPIDJp?=
 =?us-ascii?Q?GVjrA4NsfAqwcaCFvpoVT/dNZa8DGk18Qdv+Y/0bBccwoP1bzX+sg3RdUqJ0?=
 =?us-ascii?Q?FHq1idt3RKoWnOPlYvnZkrOS8Qwbc2E1EL8yJXpX3cDgV21oNLSopJGbYseg?=
 =?us-ascii?Q?vtkOInD5nZsTrr92eYkDbLvpRTZK7WD24MiTOemMxe/X6DJx+qzTEu1XWAVE?=
 =?us-ascii?Q?JMxl3UjvS9PItHMHylSKkyfZcLELPHyCQ14H+b1Vm4MGqdAZk9VczAjoiBeF?=
 =?us-ascii?Q?6Z9AZXLW+dTthPFDtiwWyHEsXe/KY/B1fSjISefOPUPz0XtmHI9YcRIIMSWP?=
 =?us-ascii?Q?WQGJsovR1MEdXpqsquqQhdfnR22wzw1eprXBGF6fzL3vCPCosFWIrkLKF2x4?=
 =?us-ascii?Q?3Wk69zzQY4ztkd7Kh90Yi/ASf+KQJt1+ehnpdAzeBIkpcrtcRY8rpk/60yHf?=
 =?us-ascii?Q?AyKcpVugmG4xocRD6o3f5fFNMSjT+umWEd4zPIXRwtKgo665zEKt6nQoNQw/?=
 =?us-ascii?Q?yEdpEZJg51zCqmZSg43ncAalNE8i8w0bJyvI+o8lS48bM4Ld0Rg0qDT19T6A?=
 =?us-ascii?Q?+ZzyL8vcsVFOOt9JeBcsA4rBLDJhiJsrkeRLaCBuzKFyNcIF7JXoDOaeD2ZF?=
 =?us-ascii?Q?JvNyUr5T7FbJnamaPEiUZSORYRh2u3qusMf/7q8cVA8Ayi4anEi+0JYIdsYo?=
 =?us-ascii?Q?RC0taL9LKIa3nggQMuPtDjmvGk7cz6k2hApgrutWqrX/hRVwhI0q5eNojxUi?=
 =?us-ascii?Q?+gyaBbj8meVskzJzEKq9H+mZB8ENJgy3qiUTbM4IOkC7AIiV35YqzvfQ/1aj?=
 =?us-ascii?Q?EuetxcUGTsRca3S6MEzZKUB2wyGChrQxd0+lHdio5Ev0547n9pOvfh77cxh2?=
 =?us-ascii?Q?FNtrjjd62QZZmMRGj1j7azQpt/KX0Au+?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230038)(1800799022)(82310400024)(36860700011)(7416012)(376012);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 09:08:28.0361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 255357e1-8018-4c03-b2bb-08dc95bf8af7
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB4.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB6505

Remove space for adm1272 compatible

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 33dcb2451ae3..ee11b3b8e81f 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -821,12 +821,12 @@ imux29: i2c@1 {
 &i2c11 {
 	status = "okay";
 	power-sensor@10 {
-		compatible = "adi, adm1272";
+		compatible = "adi,adm1272";
 		reg = <0x10>;
 	};
 
 	power-sensor@12 {
-		compatible = "adi, adm1272";
+		compatible = "adi,adm1272";
 		reg = <0x12>;
 	};
 
-- 
2.25.1


