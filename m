Return-Path: <linux-kernel+bounces-532778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3B9A45221
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D2DD17F00A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 01:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D3118BBAE;
	Wed, 26 Feb 2025 01:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cixtech.com header.i=@cixtech.com header.b="Gy9Derky"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2134.outbound.protection.outlook.com [40.107.255.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B2E151991;
	Wed, 26 Feb 2025 01:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740532905; cv=fail; b=UQrz3syuNt2c9FIZ779uZiyQLUJqrA6Dd217x6s4LaPFu8ePCBjj57lmfn+iRvcZywH8qwECl07udQI1fQeKXGtMaD/Mzj1M9F5zr2LK1JJRwFP/Mhbt4EzJFXO3atsfOx4ggH46bqF/npLXSQW1dZOwEfL+2iqKnFKCJK0WuNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740532905; c=relaxed/simple;
	bh=e7hPk0jLH5yvjXhyQItDLsu2jj8s008PyXT1KCsFnwk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kkOEAGZrgUPhJxQTqOyC1KSm1AVP0o4dF9lqnfK8lzchH1MYjq5PFOFpP8XKLExc1eBG9CZmsrOdtlDvlRj6DtcNcLl0vC3itIWzrNPpS+MAMYNlYQP7QZ5p7SGkRuRH35+3tg+il6Fmy+spmHeAxf0JTu1Szj1gWht4AlMyXCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; dkim=pass (2048-bit key) header.d=cixtech.com header.i=@cixtech.com header.b=Gy9Derky; arc=fail smtp.client-ip=40.107.255.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VdA2WZ7T7S6nAVHhSlUZ+LXpNmXvkiRQzfWhYL85zFvTjHB50YhS0tJokcuzCHvRd/CriUyDtZQ2n5KUOVYoytAjMj2hwt9X1hU1cO1k1Xh61nvHVnMTYq5n5XjjFZqDpzTEd2SMuMJiUnxjXEgp0I6Tlc1sVu5lDqmxVo/M9JPjq6WzMCsD+Fwv8bjpJwfadakAazo61+ifH2a99oufSEC3Wk0mQj5cBRiF7xpAAjaiHQcxRn5kV1Bq165IPx1OH2TI8Ugfd5dpch2otOCcZyGvedEPj5TSvAVTmUHQbv2TkTipv5SYsqcnb+/hPRUOwzQ4fjlqTTyDOgrPGOnrqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haR5tbnvIj2P2bamJeswnPFGYF5HC2vavkyiI1t+w3o=;
 b=O8ege4UbBBY8et+PEejj+Y5KtKGey4Z+LQskwJfRN16yQQpbfOPMr8G7WM7pHhtU7PRBL/AzLhdvDuNqB2Njf1mTzpE8GwZFokh3ERyNVfOP9ArwhIV0+0oC+cQ9c+Q8mUCHlpj+vcxd/A2ozfOsAl12YutWUvGuTfjd1TBQenMXw92CWhkW9MIjOwuY/jH7v40dpaOLqaoddnv8lJ+cYjP/PeRjfKzMELLOeGPMXvbsWhsiG+Oy0qXVAIQvjGCpCGHeNBPWFKGTdzyjWd1MqrBc0GFiuWTkVCfGi416+ZTka8dPwoZSjcQ+L1QrfYigUhc13Lr6BaBLUYJ11IqHuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cixtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haR5tbnvIj2P2bamJeswnPFGYF5HC2vavkyiI1t+w3o=;
 b=Gy9DerkymE3lN4kJ3f0SWLFB7rAKwwt6V5f54onDr/bVOj/IJYjzUm1nCx3RV0WI7wT4Qxc8ZArlLPlnjLy+7ow7eOk5Rd1LHOQw65kzHWP5CWdET9eh2aI4WL9JuLSgprrl4cfOSb+RX9Ugn4aSZh64Lajz2WFx5UxOP2+/1vbvB/ngaq7Omw3dopxipCW2VzylCjbj8Qm8ZYpE0/ddhBEiQ2E34xciKsJ5sLL8JGxsz68nS6HJqoWwVwTqSvQ8w2Jzgw7zmvqKnrBI/+LFDhti6VoMgkzOcyPNzR4HcAXz4yQicqzaiWzHWa3mACPcRExImv8sLIO1yAU+2XLVpA==
Received: from SG2PR02CA0035.apcprd02.prod.outlook.com (2603:1096:3:18::23) by
 SEZPR06MB5199.apcprd06.prod.outlook.com (2603:1096:101:73::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.19; Wed, 26 Feb 2025 01:21:38 +0000
Received: from SG1PEPF000082E6.apcprd02.prod.outlook.com
 (2603:1096:3:18:cafe::ec) by SG2PR02CA0035.outlook.office365.com
 (2603:1096:3:18::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Wed,
 26 Feb 2025 01:21:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E6.mail.protection.outlook.com (10.167.240.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 01:21:37 +0000
Received: from localhost.localdomain (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 7FAE941604F8;
	Wed, 26 Feb 2025 09:21:36 +0800 (CST)
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
	marcin@juszkiewicz.com.pl,
	Peter Chen <peter.chen@cixtech.com>,
	Fugang Duan <fugang.duan@cixtech.com>
Subject: [PATCH v2 3/6] MAINTAINERS: Add CIX SoC maintainer entry
Date: Wed, 26 Feb 2025 09:21:33 +0800
Message-Id: <20250226012136.854614-4-peter.chen@cixtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250226012136.854614-1-peter.chen@cixtech.com>
References: <20250226012136.854614-1-peter.chen@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E6:EE_|SEZPR06MB5199:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3e9a61a1-1968-412d-9bc9-08dd5603ea66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rcPpuw5vv8OcMbDP4hlTBoWvmA8DtMdjHiVIBr5x+I1mh+rPfQXrTNQpZtwZ?=
 =?us-ascii?Q?A8yi+Dbye+oS4z8e0Ca+w2E1RKr5GRWWaDYBxHbyjE8+Rr2OIE90Cn8ThVPL?=
 =?us-ascii?Q?18+4L0qlUrW+BffqBvjyX+tPNcWRrJk3f3y9eVUuRLuIqJIu+EOcFhOCGpnx?=
 =?us-ascii?Q?ztFdD42GAoKacUX+8OEsxH4an4zIJcgbJ5wbx+i5DO3DwDJ9P6sgZf42WMtf?=
 =?us-ascii?Q?8022EZBzqvPxIF2KChZDrY9tIVqbKDUS0sL7BjZUDuAFEuw+FitDfr0tpCZd?=
 =?us-ascii?Q?308ah2y/L0X86ni7US0+oY4cnTCm8ewaEex80y5T9nSOZ/8E6jrPCfYG98IW?=
 =?us-ascii?Q?nIKqvSsxCJZdFK1ClcCp418UvZeSSBahB1eS2JUDw2eYGC+7YIqiT0lvqZEq?=
 =?us-ascii?Q?Qxk2ObcRgySm3/8lJF4b+Fku3fv97ukbzvNhGsuYQlXHmVUsY5pUBRx/iWop?=
 =?us-ascii?Q?u2F76r2kjMLX7GfiNEcl2XeTf4LVewvr4dIvFoodOGsL6+OtaOBDFd4lVSTp?=
 =?us-ascii?Q?ZcYhA5CWcSCJszOEBHlqGOqcYBOC0fwZtUfRW7UxC+lvWcSkOkEtbsTKmPnC?=
 =?us-ascii?Q?nIShQJurzyROpvcAwNwAqXQA74mMACFIkx4AVfz1xPceCPioIWq8dGJE33m+?=
 =?us-ascii?Q?bp3H3WTo2sTVWuhR8Dz6y6hx6PDopHi9KrByOtBSM82NqEju7WcpMfBWXoSP?=
 =?us-ascii?Q?e/sj029/LkbgPAXa8LoIulJo72kj+Fbk9XOrxMefUckNvJ/5PcUrhP115uX+?=
 =?us-ascii?Q?QCVxEJ5DVsPQ4xXamKz2gRBZlKf/hf4Wa6syvoTlZSC6YLcxko1LQuT3hL3Q?=
 =?us-ascii?Q?lVlfIwgaFG7H0FRt0r8geTnYeldWQNWSjDdV107/Ov1tPYUy4NVmE8e6WKjV?=
 =?us-ascii?Q?pztQsViFhfjVCGYgR/ustuAaFW/GR4f7CoZjxkkJIeIXZBecREI+eIT9t5CH?=
 =?us-ascii?Q?RzZKhElLcW50Mxyg5jE94HeGD4ptX4pxhnU4tfEmVnSq3H2A5S2UF+n5gkQ1?=
 =?us-ascii?Q?sTRpFzD7J1wwRwV+sk8wB52g0ujK93UYLSkLANbSjLPhpWxTjcKMow904qct?=
 =?us-ascii?Q?yDClyfgNVKm6kYKtl7yMenXho6ICpXOqp1M/NcngAnuoJdu7EjVy0g+hhxyl?=
 =?us-ascii?Q?KfdlhJ2+Na4lXzKGfO2PrvAaTmUnlh5fSe+1/yHrPU0gbnluxo+aB/tJgZIC?=
 =?us-ascii?Q?VeC3ux4XH69dCjAXfXbuesdRpL78HXUasGz314JiwBcGpIV2Z8ZyvhLgajy5?=
 =?us-ascii?Q?fVZ4nOs+qHCaIz5uNae/r6ve/9IdPur2YtWzBC+pgEaWN1vlwSA0hjccpUkN?=
 =?us-ascii?Q?/cAc1wGKEJJ0nw2Q1/7CS02CtL+YSbirRldiF4vz1SXM8+oUAKaiwja1j8xW?=
 =?us-ascii?Q?jpfvobf3k/J/VY+LNKRNsmCd4S/AtQfvFaNe+el5QY/WyYczBUx9KhmXsKFD?=
 =?us-ascii?Q?exrVzs8wDX9Xm4/dkHEQpcKNT4Br+yi6daPoeyvvcPSEHXp3M8pTIIokq6Xn?=
 =?us-ascii?Q?17ZPopMUuZXs2SA=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 01:21:37.2243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9a61a1-1968-412d-9bc9-08dd5603ea66
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E6.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5199

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


