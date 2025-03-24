Return-Path: <linux-kernel+bounces-573198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5547CA6D42B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 07:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71CAE166C2E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 06:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26778195985;
	Mon, 24 Mar 2025 06:24:30 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2096.outbound.protection.outlook.com [40.107.215.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CDA18DB34;
	Mon, 24 Mar 2025 06:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742797469; cv=fail; b=Se4f3N9u1+Tm0Jv1SfVa8tOYIi4N5iX0Hm6YyaiuD7nZN1k6swxLR1cABVkPuQU544ZCD/i+BWgvd5V1sgrHJPBvhaIZ2xVA492FYdVpm8wZsGTwqZPobQNrbmB59ALhZuZvhFPBugHMZlJ/O/M1fveWdlFiWNIsWTubzk4JCUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742797469; c=relaxed/simple;
	bh=B8dr2zDF3Wg5169vFd/yZx0aRdbcGHpjMPvf8YWB9Pk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TuFd6mr3sAKDJmuwuanv+T8QLludJod+HfUh7+Q5tE1uz+H356/Fht+9DURsjwS7wqSoLzwwC9f2/FXYJkGwk1fPPUp3XEtd+TuhLoRhlyRQutCq12u4c+xSKG5ndXT5orklwleUwT1kSz3+2EotUVPq3Bgcg8dkjmyUG+3g7f0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.215.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ViDVa9wElQRldGbMcLszRLhH0oM09guZ4A9AmLQUEeWW44IufyO4dofAD/L4G8qtwFWeGaYri7DquQLbEkK7rYrIJZ5Hq8xoMHZ31tprXGJrC9Z58qRpbFxbp2cWFSDGSwCCnDxba2zMfSbqz4UVZPfpUAoJAQQ74b5YczCmiMcMzv+6Fo4vVjVtagIZ+sFWg6zEKsmaTmjWsVTXXshMXW0JBGKLyC5EicDLlrjXVFs6oX6vQ9OZZup+BlgPWz5gLIvWkOPBzwQJ2Fyif+LglbaUj6viX8XKbGpzC67ySkPIl3TzZzwMkSBtBnPEZnI8DLq3yxMj/Or0vUTtFlNPcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbGUs+KAb7OePr2lKyO/HGGej1xQACFGsy3pf12SQdw=;
 b=ZZwFpNTqYppN9nbSbEcHMjibCvh/Jvu6LgJCf8E7/tHnuR7UzkkhPCwNpjctlJtV+8i3wy2amL3pZ6aWbXD+dUW0GGBGSRmEoLuNwqC2lUqFxUa/YTsaIyLTyp5KrZUa8cuqWlPdtYiWyuyBIHdtzMxnB2A0zskq5rUkCAFzFEn3k9UVX1jpcWvEMv+zmdhCQr1djSi0SekW4BSD/fMc+/wmN8q+iGVTXEhXHd2Yz9IdIWCexZtWaSBBxyq36I7wM11C6r1F+e2BN6RnX8vfz8lDG1nzK4k79j9F2pK4s+glKJSoPwo6yw8/ghHX6Of8Y/ozxCWp6vBgzQ56vkoGPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SL2P216CA0126.KORP216.PROD.OUTLOOK.COM (2603:1096:101::23) by
 SEZPR06MB6612.apcprd06.prod.outlook.com (2603:1096:101:187::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 06:24:22 +0000
Received: from HK3PEPF0000021F.apcprd03.prod.outlook.com
 (2603:1096:101:0:cafe::37) by SL2P216CA0126.outlook.office365.com
 (2603:1096:101::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Mon,
 24 Mar 2025 06:24:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 HK3PEPF0000021F.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 06:24:21 +0000
Received: from localhost.localdomain (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id BE6824160CA4;
	Mon, 24 Mar 2025 14:24:20 +0800 (CST)
From: Peter Chen <peter.chen@cixtech.com>
To: soc@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	arnd@arndb.de
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cix-kernel-upstream@cixtech.com,
	marcin@juszkiewicz.com.pl,
	maz@kernel.org,
	kajetan.puchalski@arm.com,
	Fugang Duan <fugang.duan@cixtech.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Peter Chen <peter.chen@cixtech.com>
Subject: [PATCH v5 3/6] arm64: Kconfig: add ARCH_CIX for cix silicons
Date: Mon, 24 Mar 2025 14:24:17 +0800
Message-Id: <20250324062420.360289-4-peter.chen@cixtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250324062420.360289-1-peter.chen@cixtech.com>
References: <20250324062420.360289-1-peter.chen@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021F:EE_|SEZPR06MB6612:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1aedce0f-0361-47a5-1c1e-08dd6a9c840e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qhQ7kE5lnzjMPQvFY4qn3fwnB3vQETD7YMEz3vUBPNDFQjXwoLdPEdKvsub3?=
 =?us-ascii?Q?fu041unUWepRF3eazS33TyeqQfzkczEkbIm2H/QFDiCRoTIrb0ub3O/6lAc7?=
 =?us-ascii?Q?tyovCfp/U7WTZRs7MOOn+iuLd224I535mowGDAbQ5Gavcc1pX2rYByD2VlwI?=
 =?us-ascii?Q?yAzblVXdoNfaPGVbvXAdGA0LYuepFEu5sLJuDXBnoSOcE8WPCogKR1gfRdi+?=
 =?us-ascii?Q?8ZfWYOmOeLzzlhB1LcuEaIP12sjEqy3VmfpM/KR7G3gDcgRtLX27ueCjkKEy?=
 =?us-ascii?Q?d0+ME7/waihJ5cnXqxwc7XcViFDzGAe8eGQ6vmMixy/QS4eBscDP0MfhNqBn?=
 =?us-ascii?Q?a0t5oRMebrmCHus1QZrYZd/sDUlNcB7i84lCmboTPL5MLT/Xbh7nguSh11nf?=
 =?us-ascii?Q?CYHAtET2lK+5VZeIFFQjEp8KCg0ru5cBvCNJWGKBXDrGdHyOKxsk6j10zLah?=
 =?us-ascii?Q?pOnHGzwNAdkkrfywT0zAR31j4OnEDTshwpd36n6f0Dq7YaxW5TPG+G8kB2mL?=
 =?us-ascii?Q?emRIBldMxewBX5unIOMCzaFG5xlt94eRDXqRUhAPAlGgDD+3GZ67J66Qe00S?=
 =?us-ascii?Q?zsl69dylRqYwu2A91k4mnRvTHTdK3pyntTPUvGEBYXK9h/p74sOTBY5uSkgJ?=
 =?us-ascii?Q?pL3DKRo+A3SuraT+tGmZuyS6D+ce115Ld/fNVrMJCH54ZY5GbGK7G9F2ldKr?=
 =?us-ascii?Q?9/sVb4YAyRGVhL8wGZk2W2ocaBzF14ZNHaOvcHmlKJIevsFzgyRl5UnA+kSi?=
 =?us-ascii?Q?8uD2O02ExGDLS4GxfeSXmBz/tYee/uCGmdWHlQfiHp1G5jDWlg6jB+P4/5/r?=
 =?us-ascii?Q?wZ1lua4DlRSpNYJGz/F9/obd4ZpB3+NEd3RRBZ4CxVpIyIDBAfmdBTxorF2F?=
 =?us-ascii?Q?/klaKPhBeK8pYTDIKcDEaAOcNg4LdYhCj1yUjHbj3FvqvnO6xx3HlOhb5uuM?=
 =?us-ascii?Q?emr4lrRxrY9c0oh2HcsPx1tH/ZyvcHnPT+Asv7BcUQ4nBI+jglw09m5PokEW?=
 =?us-ascii?Q?5pxjTsBahYmj2XVovc51dLswaVs1lM6sWE8THpeRJaH5HHv5SLEQxgaJ4R7y?=
 =?us-ascii?Q?nzu1gKdr0/Zi6HWvjbDMVSkhauwVLeu17kRtsmjFAMGg5QhL4ovUIAP3lY3x?=
 =?us-ascii?Q?KT9CmrVH0rQS4qlh5fRlqCPdnUMcHNItw/9BDCQtUFajqa7FB6HasAAd3o3f?=
 =?us-ascii?Q?fjHofEf+9sSX/Z8xt5fUtk4EKA3J5IeqXilhfXMBTl2kGhkbqcVF78l5SHJO?=
 =?us-ascii?Q?M1a/ZWuj95jzuQyYLqwVrz7oVM0ruYW4bM9UDo5M+Oi+uIGlz/Pm2PPMlIZ7?=
 =?us-ascii?Q?P2bAEWFiPvrvVVWuDwdyeoJPUjJHkyjAJoPMGH3TAcRr1z35AplpSdJDCnyz?=
 =?us-ascii?Q?LBkRDkFqnG5YddTOE558Jr+aB+c6tf4iViGimomyBHBLgvQdOrhtzl0HeA6T?=
 =?us-ascii?Q?w+WpFojsTtp7tS+H+ufGHhnnhLqz1e4Wl/qX0IC66AqTDkMx/he9VQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 06:24:21.7094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aedce0f-0361-47a5-1c1e-08dd6a9c840e
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF0000021F.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6612

From: Fugang Duan <fugang.duan@cixtech.com>

Add ARCH_CIX for CIX SoC series support.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Fugang Duan <fugang.duan@cixtech.com>
Signed-off-by: Peter Chen <peter.chen@cixtech.com>
---
 arch/arm64/Kconfig.platforms | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 02f9248f7c84..abe41db9b9b3 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -106,6 +106,12 @@ config ARCH_BLAIZE
 	help
 	  This enables support for the Blaize SoC family
 
+config ARCH_CIX
+	bool "Cixtech SoC family"
+	help
+	  This enables support for the Cixtech SoC family,
+	  like P1(sky1).
+
 config ARCH_EXYNOS
 	bool "Samsung Exynos SoC family"
 	select COMMON_CLK_SAMSUNG
-- 
2.25.1


