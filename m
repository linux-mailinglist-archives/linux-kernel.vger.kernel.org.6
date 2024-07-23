Return-Path: <linux-kernel+bounces-259809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 004FD939D88
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09ED3B2288B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D067814EC61;
	Tue, 23 Jul 2024 09:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="Bj/MAxbi"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2052.outbound.protection.outlook.com [40.107.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A12914EC64;
	Tue, 23 Jul 2024 09:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721726623; cv=fail; b=HKXae5WAfiAkrKtkknd7c4FDsg3cfQifwEhKklOSLUJKhkekVNhguHOZrRbbB1sM9rgWL89rlFpVeu66RxoDZi5vfCaJ6O8Pba6Oo+q7GT07P80JM9QlXln7U05vPuxKVu/6Ialrw8cs92q0oIvTIsVXaM1cpnZmDNSLKiiR0sE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721726623; c=relaxed/simple;
	bh=k9TQrTgj/bmsUx8/XHB2Q72cYyInledEqhlOsk5dxvE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F5co4xCsK/Bn7h9fERSrN0y/T+Yv1syPYujfDGS9l9aeKrWC2deHKlErCzN8+tHXLu7o5obFTJGNph7nKdJucFOVZk1PSJ7tvZZzaC/EoXcyxmkrDog+OYb0cwOK45BKWXM3qXeNSk7BRbiQhV4u2oRTfIwLNBjXfBqIr9rjr1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=Bj/MAxbi; arc=fail smtp.client-ip=40.107.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gMk6wE10TvvqgbrkuS/mOlrtVDQ+d20lsCM/a3kShFmqoY0Cipliz+qTLIX018u7UG+v736sUs9ipfxFBC2egg8Atz1N5bKeS7wkbxKM681O6Cz7SIFQmvmshGBJgvlMJf9GIz8tZ0ggVTNKShj9LGIwc/Nxm/ACcjl0C93UCuk0Tu8Q3HGJEjJUU6Lg8ePW3blX8awrLDlgkxEaOankTrlVQ7+VQJ7pe3HnE9HD2xatYQTwIieD7GZJxbImu40SnA2DRr+2YQevilrt+90GdUMwP7An0Bw3CHy/KzIz6aDnx/FVUe7gO7u/r4dqIrth38oHse50TRC73cCcwGa1QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTnjvURfXlo53+eVxwkhIqzweQBqIwx6vFyYMB4uolA=;
 b=Wk5034h/SQtLVBOPLmPzWc11u9UTn2IkDXLeHLOXyTXbGWgmgwjLqJzSg69r1qfcUm24k3dkN8skQDb4Sd7HVRHdrcf31s3zp10L2E3kS+7ju80ghWbv8QuzWhBItcll8LzpFMzcp24uTkMv0GFNow8ZulZtzpdBdQoWysFadB8OO1xu/q3z6B4QvSvv1v6bjEu+CB6hMgeFESDBP1odYOTjWnOC/xyTxcU2wD7SDLo9d3jG6Xh6g4rIw6esGMVgol2Iu4kPQO9tMwKzobA9D4XlokFf6pxa/M3a0+qRh646AnWdOO5dXJAAHnY5AO+qhKED+iTlfsJ3zIXv3D2VYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTnjvURfXlo53+eVxwkhIqzweQBqIwx6vFyYMB4uolA=;
 b=Bj/MAxbiEsYVXzE6SRP0pvHP4dVxxcARyAwIYRUKGGddMFUJGdPdBQBFRolZpzMthrp8efeFfxmJEtjcuqXzUTw328PbnSnIAxtgLZqAfIa5badXgfxvoc9iK0naMC0IdcRdfwzWq5x1TMChxWLPKAVuv4O10uI98DR4q221NfUZpgu8rNG5t058DHod6CeOqJxK2R4hD7NuhByzGZEUduQOdHCEIF9K9Kiv+HgXnWqDBmXwZeigF0d5F2BTaCnHM01ECimAda9W2zGqfallRM/CpLuvzUSInPQmHsGyT7FMx4EhVypqwWbPJ6BDQN4n2iitgQpbYoOjUHBy8z0ibQ==
Received: from PS1PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:300:75::13) by PUZPR04MB6315.apcprd04.prod.outlook.com
 (2603:1096:301:fd::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.5; Tue, 23 Jul
 2024 09:23:37 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:300:75:cafe::7a) by PS1PR01CA0001.outlook.office365.com
 (2603:1096:300:75::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Tue, 23 Jul 2024 09:23:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.7784.11 via Frontend Transport; Tue, 23 Jul 2024 09:23:36
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
Subject: [PATCH v11 05/27] ARM: dts: aspeed: yosemite4: Revise quad mode to dual mode
Date: Tue, 23 Jul 2024 17:22:46 +0800
Message-Id: <20240723092310.3565410-6-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|PUZPR04MB6315:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d7582701-5735-44dc-62d4-08dcaaf921c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wld8ag0SODnuyCEs0h6rsx7yokHqJUcINKmJIbtFoD+tGlDnCOVPQAjrGL7A?=
 =?us-ascii?Q?1HiiyhFihDELxj/nZ1/SNEw7Qdqexz9bDqqcLnCzhbexj2NjqKN6Zut06gBS?=
 =?us-ascii?Q?LvKQUrOyNcK7PWz6zD3RUkUuas5LZbtMg4nErF1pyQ3IEfF+Dwi6uXaaKyT8?=
 =?us-ascii?Q?H0CGn410ZfPKbaWaGG5R1yRAtNAl5qa0uuJnfTnE0d+bbispt7e1WuWfVx45?=
 =?us-ascii?Q?4OxKPoBdCBLj4GG2wXd3N2+Wo11MNNFoa44AHMl/SBVwOKEajv79HnKamZtR?=
 =?us-ascii?Q?ZecdaQMZ+fgxu+s9o98bZddPCp1gumAw16JNEhSiOX/6PpI7S7kG1Cj4P+7H?=
 =?us-ascii?Q?2PToZaJNe7aWeqBQKpGTa99lo45gEaEGMXqR4CIMpRnABy0LkedSjAhFOwva?=
 =?us-ascii?Q?RQ6cV2H0TJMg0TiMVOKjhmB2rV+GWN2dE68N5RylEsef+7a5wp1QjH57UBjA?=
 =?us-ascii?Q?xHe5rbJm2Nbc64riGLBeW3GkEmdQ8vCVLG8lMDoHn2y39B9+KHbUfrUFjAC2?=
 =?us-ascii?Q?AoGKCXCj3AcEazYaSamNoGejo/avSxC+b8BWFvwmB7yi5XlFPumVER92NrSd?=
 =?us-ascii?Q?cx+ACYu/9AYo1l/WV7IagiZtmFdpxZKJgIKrB2W5wTn68pCdc9SfiZU6KwN1?=
 =?us-ascii?Q?Ha63dfNorJJAMg2GyZFxg9n9hRSVhea8VW7B5unpTS1VcvVveLUp/asGwFDM?=
 =?us-ascii?Q?zQdXU+1Ndw1MOh+mjR/T45+j62Dc92D43RRdc8HPd+za76jQDUrdvuToXRZr?=
 =?us-ascii?Q?RFJlWaCULHAXIToMPbPbSMyyhp+CiqjNFcDpNHPa2LjPtSkTjuASJ702Aope?=
 =?us-ascii?Q?S4dUd5oEls5HZfQO3qb2Vtj8TVqrHLVbwJ7JQeB7E/1LGkw4hi4XYKxiswDY?=
 =?us-ascii?Q?BC3Q7iJuSVUvc177aacgJuxjsl2aIwTGl0Uoldy3QwYGIgJzDqrs5YZaY96y?=
 =?us-ascii?Q?p9PcBRDDv3p+YZ/oVA6jjfvsvYtT07y7GyNtBrHKkUFNB3hdw+0Kud8Ywz5z?=
 =?us-ascii?Q?V5t7ZA6NDHX2MTkvrivxw2bIv8FvS8pZVjmdVOUOYQBGwW3kEMvYlewgfbrR?=
 =?us-ascii?Q?n8ckOL74/X7nbQTRntlWIJ9DMrP0msb1TuxUqdR9DdZnxFgxuyGaq97kBDGw?=
 =?us-ascii?Q?zsYwlbpz1+wQmmWXGpjEAgkiFPchuHFjf0oLwl1G5fjoM8ssyJU3Pv0L1hGB?=
 =?us-ascii?Q?VUpyFMwI2U/bi+OYwbjWEzW5QIX4MMz1fHdmU3o9X4v5uVcfnfn5U1KbmPp1?=
 =?us-ascii?Q?Pe+KRdgsU1ZmIsK7mxb/nKZgn+4po1dWO7ASv/kxGTPiYW7bjyRf1ZnPyyu3?=
 =?us-ascii?Q?pNZpJ5+Yr0F3POT1teAIiol+U7bSMLY7s78B9FUZFYaO+NLkqYfdrKKtH2he?=
 =?us-ascii?Q?bQBHHpUOI1Ka9WENASPQC4aymdWh3MlbD/V1I8470yVqyQWqciyUKBmrCORs?=
 =?us-ascii?Q?Uto5ISEBduI+t2gS2TqKdecuar6G+zZB?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 09:23:36.7848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7582701-5735-44dc-62d4-08dcaaf921c9
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB6315

Revise quad mode to dual mode to avoid WP pin influnece the SPI

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 51b4e9ae13cc..e5354efbb903 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -149,15 +149,17 @@ flash@0 {
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc";
-		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <2>;
+		spi-rx-bus-width = <2>;
 		spi-max-frequency = <50000000>;
-#include "openbmc-flash-layout-64.dtsi"
+#include "openbmc-flash-layout-128.dtsi"
 	};
 	flash@1 {
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


