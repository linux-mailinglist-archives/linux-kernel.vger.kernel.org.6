Return-Path: <linux-kernel+bounces-523197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CCBA3D370
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A981F189E3F6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649601EDA1F;
	Thu, 20 Feb 2025 08:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cixtech.com header.i=@cixtech.com header.b="kuXot4T6"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021096.outbound.protection.outlook.com [52.101.129.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D9F1EB1A9;
	Thu, 20 Feb 2025 08:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740040829; cv=fail; b=ufNLojbrNQxrB13DB2WnIB6BzY0iNGhOQ4VQviJATIzyzva1uQ2wa1YsSUa6N/dZ42JfcR2+Q5LR7OXixKqBUq06F1/gyxoiTL+o0fcgljG531v09B1VO+2KOD/KSwC0LZUfqfh9NULkJoRx/xpinT8k73ayFWDV9iHMiHqiu8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740040829; c=relaxed/simple;
	bh=e7hPk0jLH5yvjXhyQItDLsu2jj8s008PyXT1KCsFnwk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJGIe+pzilRJDKkD5HuIUVatqFwu/soN1Y3m2xs3OTxiinDCs6IUsneypHPLG7Nu4pU9DzkyqR391lQE4Ns8t+1s0sIB0ltyz4UOEc63mkQnwd3rmBNyTf9SFn/KrpPoM2/AxxBjeL8H65svwJpBoPdDc4G9STvhci9jczmNCKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; dkim=pass (2048-bit key) header.d=cixtech.com header.i=@cixtech.com header.b=kuXot4T6; arc=fail smtp.client-ip=52.101.129.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jNV7VcBiFDnMWYMUg58ujYHL8zN57NoOhogIqUcWSzRsARb7oaHYBsTzz4mDeT4HXmdjTMavQksMiv8jYN5cfulxSl+S0JgBFhlRquD9xKD/WZIzDJQyWybF2ucC7ZVvhgLBBW8hpR8iW3EKOCFr0izkTiXhsfnP2dwgf+qBKcKPL0u0UPtO65YMS/yOMA26rLVOU3enxXt7Oe7Zk87nNMB+zPChs1Y8bp1DDLbayFA5VWRfW6GfKSsqow3VNA2Qp+7cHM04fD60edmmEQJ7KoJvxCCYjkkeN/BnzseaeTIcsc2Ksy9ID4XFqoUaSc+wGLoCkiwF5x9wWxbseJCoIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haR5tbnvIj2P2bamJeswnPFGYF5HC2vavkyiI1t+w3o=;
 b=B1Fmz4I8tvl2BR3LrD06TB2BGj7toSWzhVyP/M3OFlU77POKYiUkXFMbGp8UIjml4RkiXjxKI5NIH3eX7or10HlXcS1LI8Fi9r8Fbb8bOjrTVr/WNbHRMJLNugMT10LVztEsHjtbMPI2QeblOXjOsPNpNAA/AGkFhUtXsNbMVBIf7LzVQgHHpA4WIsNl4z4hdXWuoRMkkdAgys/zEj8FETy1n6FbN965aQX1sxPCpb/ANzoihzfDMsq29LCDgDBJO7SFoxpC6N8qraPxhFir3NXCGzdZSYjBDjhABKfkYPdBNnEPR0KXTbhzQ0waw4Ed/V3at06vn/L5PVc28KKqgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cixtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haR5tbnvIj2P2bamJeswnPFGYF5HC2vavkyiI1t+w3o=;
 b=kuXot4T6vMkCGn+ThWR9tI7lJvSvrFc9NngXsFuG+/GlNCuRLCAUqNaLUvz6Wz/QT9vqPGTMk66fuho3wA0rKhSBTDbKqIrD03JDyKSVGsjhTAA6ayvL1c4tWMnh4Tv4gHgzmIywVgLEUkkQ4t3Hjxe1R9xnxZG6+G5ZdsOHi2cXYXGjS8TOVuqcUmqteRNavN2QkScTNNyO7vMqMG6L2XnWihhum8tz/+c3pUtCHFFvguIHIiZxPfxKd7R875BI9ETIU+kR88uze9RbQdBVOVja6+XO0EW5EJC3RuJagGIi0iSq312LwtT4amaC1IflNNe0/xe9hVF0ZDPzB41r+Q==
Received: from SL2PR03CA0009.apcprd03.prod.outlook.com (2603:1096:100:55::21)
 by TY0PR06MB5681.apcprd06.prod.outlook.com (2603:1096:400:275::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 08:40:22 +0000
Received: from HK3PEPF0000021A.apcprd03.prod.outlook.com
 (2603:1096:100:55:cafe::9f) by SL2PR03CA0009.outlook.office365.com
 (2603:1096:100:55::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 08:40:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 HK3PEPF0000021A.mail.protection.outlook.com (10.167.8.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 08:40:21 +0000
Received: from localhost.localdomain (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 8A66341C0A04;
	Thu, 20 Feb 2025 16:40:20 +0800 (CST)
From: Peter Chen <peter.chen@cixtech.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	arnd@arndb.de
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cix-kernel-upstream@cixtech.com,
	Peter Chen <peter.chen@cixtech.com>,
	Fugang Duan <fugang.duan@cixtech.com>
Subject: [PATCH 3/6] MAINTAINERS: Add CIX SoC maintainer entry
Date: Thu, 20 Feb 2025 16:40:17 +0800
Message-Id: <20250220084020.628704-4-peter.chen@cixtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250220084020.628704-1-peter.chen@cixtech.com>
References: <20250220084020.628704-1-peter.chen@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021A:EE_|TY0PR06MB5681:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d36628ff-8fb1-43ee-2464-08dd518a366d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xGXHDWFj7zIg6GKr45xEqFDoi1e/UAB1re5ba5gnUXAPXiSXnpt0Sm1zWQ+P?=
 =?us-ascii?Q?CMwF8KzNoYaBN3vA3L6/oTSk45BC6FA9RvdT5T9jP4S+r92xObeBp3B+HFav?=
 =?us-ascii?Q?BXVFNWsoP6rLEJh/CsgMU9ZpPHpc8yBAbiL+4+G54U1APdYjZkxOXIhNC6gH?=
 =?us-ascii?Q?IONbG0reHSChCx935jGnd4rLkAuF8Ui5dbHdXXX0sy0TqMBlsheVCi5kkGWn?=
 =?us-ascii?Q?vZzEB8sPkWiHz+bMcoZS/k4khHDOeQI4aFcg6gDXiXS/DqmQ4PG21/d5tSZ0?=
 =?us-ascii?Q?SjQH9RPoav0obmlvkxEOXpw/xB+bVTG3t2GlAltVwmMt+iN15Ki+7Gwps0MM?=
 =?us-ascii?Q?S9HCf85vgGbzp1aehOyQZuWCRv/ut+wxLyXYzZLO03Idtyu2MkMgWH1K3I9/?=
 =?us-ascii?Q?YN5v9C0LbaqTts9vmeTPKjdLEvCrhyBUgsCo4rlOFd4LnXlOOK+0RXyCDUoi?=
 =?us-ascii?Q?YN19BqJqYlOt62HMrkHfvXBc5RQ8k9HDBItYOAImo4rlEhdkEyHSCyvpIp2O?=
 =?us-ascii?Q?EZw+gxPxTT3aD/cWk3J6Yf50JwgXv7lJGMDaExJiexBGmFaYLhTL8QPJVCgB?=
 =?us-ascii?Q?/EZG+2ri5ff6I0aLNPh/ylI5whUhUU1iH1D09uPdW1coENUGeO0H2LllG7DG?=
 =?us-ascii?Q?kTx5xqewMUhwBqRNi3fOMbQc2vmAQsy3I4cm65081EIBF8Xi+dBj1jeyVimd?=
 =?us-ascii?Q?yTnYeOHKsNKQAj0XeeJNvv+Ivf2Ad6Zfz/rZs0onhhyhc0RdTfIF+tNiRST+?=
 =?us-ascii?Q?ZWrVLZVod7Y8gIIA/jHeyc9+0d8wfdUJ8gC616/CU1OIAw0ugQVKcM6BpUJX?=
 =?us-ascii?Q?PJcKiva1lPAiKAQ7Kpln5PMzwl+5pm9EbOSxMRWrZmbTlFyTNyLTabzG/OW2?=
 =?us-ascii?Q?R2xf3xd1UwlZ6Nl+y12BY0MtA0ds2dzLLSqGAVOuQzCfovwMOC4Fm9Y+0uIs?=
 =?us-ascii?Q?SWvza05E/+/H0Eq9bxFoj5noyAU3iN3Sf3hL7UCZSOcFsh02EajihajwirU6?=
 =?us-ascii?Q?hw0uoIDE2MOk6tAEiiYUKCqRFMCaEMUMcqQaWz/IgtuD+LhNTFR0tey7O8Mx?=
 =?us-ascii?Q?GMJ5Llr448/ym0bTA9cOXmDRx8ynByx5P7z14pmKgYtJijuZkBR09t/SKP3I?=
 =?us-ascii?Q?XcpZ3Ge5OiB1fdxxZuFH2KSUeyQAjDDEaaaB/376sXnWLAtks+O1qK84ZIef?=
 =?us-ascii?Q?gAy/LQPLUORqkAEmDrd1NQ+b2zUOsKeQzoJlV7EPUUcL9kABPfU98wWX3UCk?=
 =?us-ascii?Q?5FuJLoLPvk96+jDH6YeQoljQBUNYr6Mm8QAAKg8fYhYXurx1zur+HaGhkva9?=
 =?us-ascii?Q?duxT7ayH8jMjQDQumoQwrjQkiIz1lMnxMmEo/ISQNZE05QTI1z/qUo+FGE3l?=
 =?us-ascii?Q?zQu9u8srTRI46Av+V/1iO1milYgNq8FpoLSTz8luwc5YgVCzqkGDLidQMYKS?=
 =?us-ascii?Q?OerolKXoUkX8506CIRb89j2v8uksDsgkjm63Qg54dWsfcQ4jQSi8rPQl9NCw?=
 =?us-ascii?Q?8M3NUqur+qXXmwI=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 08:40:21.4437
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d36628ff-8fb1-43ee-2464-08dd518a366d
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF0000021A.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5681

Using this entry as the maintainers information for CIX SKY series SoCs.

Acked-by: Fugang Duan <fugang.duan@cixtech.com>
Signed-off-by: Peter Chen <peter.chen@cixtech.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index efee40ea589f..200d2529c8e5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2354,6 +2354,14 @@ F:	arch/arm/boot/compressed/misc-ep93xx.h
 F:	arch/arm/mach-ep93xx/
 F:	drivers/iio/adc/ep93xx_adc.c
 
+ARM/CIX SKY ARM ARCHITECTURE
+M:	Peter Chen <peter.chen@cixtech.com>
+M:	Fugang Duan <fugang.duan@cixtech.com>
+R:	CIX Linux Kernel Upstream Group <cix-kernel-upstream@cixtech.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/arm/cix.yaml
+
 ARM/CLKDEV SUPPORT
 M:	Russell King <linux@armlinux.org.uk>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.25.1


