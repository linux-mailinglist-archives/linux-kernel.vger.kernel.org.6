Return-Path: <linux-kernel+bounces-532783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C968CA45227
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2F447A75BB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 01:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76096198A36;
	Wed, 26 Feb 2025 01:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cixtech.com header.i=@cixtech.com header.b="WaB/s9xh"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2116.outbound.protection.outlook.com [40.107.255.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946034A32;
	Wed, 26 Feb 2025 01:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740532906; cv=fail; b=cEm168PyejbwVwiIPge8pMqnpRlehn/CJjpxq681KOPrVj4H5fzIX6He4nr37rJ+xNEmMhIHAO99HKlF+I0swro9n03ZRq/hGI4NqvqYxRqOe77ifq7HJhPpDMocJvWtzHRtogHvFtvx48mzhnMwXtoXyZDw1i+mP+b2ggFkvzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740532906; c=relaxed/simple;
	bh=C9i3TMoRsOswOFiOQrFYM4v9uBf0GmOMzB1rUpblFLc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FEJeSk3B/NestfaYm4aWeNkLQnBT/RaJnwwck4G3w212GjT+WwQ/mnfBTcgcxca4vl2S6X3Qq5uR4L3AjBD/237GXzW4tOz+fOR/cVfNe2PZS4gUZTmAKW4irIOEUQXg8CWMA7BdDFftrXVFwirC0H3LqxcDebz9XBN8iJqBvbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; dkim=pass (2048-bit key) header.d=cixtech.com header.i=@cixtech.com header.b=WaB/s9xh; arc=fail smtp.client-ip=40.107.255.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=elxjoAQAR0AvcXHTM5iY6TB6kp6cb/o81QZ42au+qEP4lFhfcYDzjoZqsH+Xf6bJCLqyxPhbF6vsQTn9WwGTIa7KnBwKN1pb0+SrEaApFDhEXdbmvCfG/Vp2nnDlTrIplnMiCcYoF4XYBV+x5/9IlPJCKssb3cCw7MRhUuIZ11q5xXFmNRNTNLwCTfIXe9oO0zeqhgL8vMMfOm4Ok/ELh94f9+YbMVivWuDoT0Vu+Fs6jRjB3oxuQR/PBAXng8RrUl/KuUTO4+OZyl6kPlueKuK2K0ONxirVQSFWLQMiSebTL1ZaSWVix/Mg0/C7wzPWMuts7OtrF7ifPuASrfD/gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFA08TbO2kFd2xSr9WBrHPmNr3pE9INY5LPfd1t4DIw=;
 b=yI/upnD5GdZdj8SCuAS97OMzmW7KksZ3tQZIyDJ2jUO4hxuYv2Rxy1rtY19timNv18BZGPfoa9ldMoxxeRIthDRynmaVdH81JU/l25p/ywYCRy8KUYk9PR7TRqAMv2p1BnFqXC7Zhzp+xjnTecymZOAInx/+sPEMc33GUfEPau5ASKGdxy1fVnbs5QksHUkzuEn3YQqemGh+9Hf0bZeONO8xaFMz0P2upvuVY5wgK/0GhbeF+t24hh6GE6lQ9W16g/8SrJax4DXRf4mmbaMw+Qq5NgbTnKxKRddpgB6HTOHDcI4LV64yfyFa0Mru/vkq8kddQdZTLsAqURaTWM2MoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cixtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFA08TbO2kFd2xSr9WBrHPmNr3pE9INY5LPfd1t4DIw=;
 b=WaB/s9xhBjNlNHBbiBgrryLytnWgXNmaYlNdsoecuRAnvO+idX3EoxgJ3j3wGbBNkblZUz27epkv9s5r3ChXEXr3wv8/r/EV/HADoev24VK891kzm5iazTfsJeDDfm8CLzSDAWb6kHPO3DgBcUwOPh+AU23vmxmEgeSb+VwbYWxH1yv7bhI7hIfwFD9OVdJ5U3HrVEgaTdZjLcl8NjOEIXIacnTJUono+0NYc3GtvtCxrK8ZXXRuu6rQZ1NpPbPS1GPdV/FW7A4mRCsJXGrLTZMq9k35PgljEbfwAFpddUtVOnE+U2DgcuetTf36pjbPshtnhVVHh9xaqPHKW08olA==
Received: from SI2PR01CA0021.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::19) by KL1PR0601MB5533.apcprd06.prod.outlook.com
 (2603:1096:820:be::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 01:21:38 +0000
Received: from HK2PEPF00006FB0.apcprd02.prod.outlook.com
 (2603:1096:4:192:cafe::92) by SI2PR01CA0021.outlook.office365.com
 (2603:1096:4:192::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.22 via Frontend Transport; Wed,
 26 Feb 2025 01:21:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 HK2PEPF00006FB0.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 01:21:37 +0000
Received: from localhost.localdomain (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 903614160505;
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
	Fugang Duan <fugang.duan@cixtech.com>,
	Peter Chen <peter.chen@cixtech.com>
Subject: [PATCH v2 4/6] arm64: Kconfig: add ARCH_CIX for cix silicons
Date: Wed, 26 Feb 2025 09:21:34 +0800
Message-Id: <20250226012136.854614-5-peter.chen@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB0:EE_|KL1PR0601MB5533:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 04d51295-56ee-4e4a-7c13-08dd5603eaba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wf9UbNhd+J/FsJJU2y0oVqFp5uHvnuqwEvbZwZvoy7hLIhhHpKLyB8et0ifn?=
 =?us-ascii?Q?yBfL+9kXzV2ArLf4Y2lekA/bzZc46NGVzqyt0uXT3Q7ss+dyw41oiiqXrLA4?=
 =?us-ascii?Q?wG7vIatPt/wKdX1l7Ek2wvxcAImML1SV9jsQhmBdfBZdnTQyCcGDIfIqb45+?=
 =?us-ascii?Q?4+GCWZc7ggRLEgzQlr8mBDs3dowfMkOOJ1Y8sTMsZakT6GQbB0QH0Zcq0sII?=
 =?us-ascii?Q?MLJLuFfbdCGgYL+7zZHPE+7ftpR6aaURVXatFM+7+A+jCxBlP3Up30EedzVw?=
 =?us-ascii?Q?EJHLsz1tmi4+qk0gDUmvHXPl9ihAhyLwBFzN2awwSZTxDZZwnPtKK+SARogY?=
 =?us-ascii?Q?/kBXJWN6HKf/NQzO4Ket/Mpov1kdCoePDBlf6lzLXuFRlIJey024lh19pkHz?=
 =?us-ascii?Q?mRqRCm1793zFG9aHUFNNPOSpIfCuKZhz/Pvda4llQmk8t0XFjuC1mwRXfcOt?=
 =?us-ascii?Q?ZMnysb83uVxLPe3Z4jBPYima9hIVkUmKtwF09QQEtl7c73Ck+kYM1XgfK8cd?=
 =?us-ascii?Q?V5tIaBz78WrZHtgHv0UIujsV+sDFCEm7nQ8DpEmPDYPsmkgSjiKirI6PgbZj?=
 =?us-ascii?Q?3e1mtcYkpOVCBhuS6vAAEzWCOsNwUOK5W62exMRDWPuA1LKRFpGn+uU/3Cjl?=
 =?us-ascii?Q?q1gcqVYgv7uH1gcx44qljH80FIgzVKqydoVCf6ywMj73RKCukyVK3so4JhgP?=
 =?us-ascii?Q?rBK9964AeE9lzLMUFU/TSz4Cg/+vK680vUSsEK3VarMfYbFXeH4jrXpnRsMi?=
 =?us-ascii?Q?PNv5olxkEwU8mgZrqALOxQwSVog0xO87RUyvUyHA/0MLrwDMFnMFb7NoIsRa?=
 =?us-ascii?Q?3Y1HgIN0Tj2I0RNIDqdJFsvWH8iOd46kCFdAJsgRSFMt6yg0f/nO4v9Pyqrg?=
 =?us-ascii?Q?X0mzYCy8OlMIUdA3oDPZVUNuQFz+5qzAWuaMLgMkdVo8Ecpa3leye/2ZYNVY?=
 =?us-ascii?Q?50p5GkLUeOAOZzjM9IoTWiI+Rdkn0Jrs7q94LTIdVK2jJvpdiTxh+7V2FbPH?=
 =?us-ascii?Q?RFhGHSXHHOTdg0GG4xmEwhXC7AkCW5jNkc6DonvwNdmhbRpAAI975l4eKtgT?=
 =?us-ascii?Q?+7pSVOJTn5brJ8kTTMF+oQd2/sbE7K2iPemzLirMvbB1Soxm6dAk3bpFXrrx?=
 =?us-ascii?Q?ZhgKlxnbS3mr8ccoOVwHce8bf8vEjHmlCzh3EVwl5fYv8GF0vXKA9P58p1o5?=
 =?us-ascii?Q?0Rq/zFkoGcoj9pjdexj0NvRGy1+DhGVGmpRElEPxDvRb16AzLbfqiE/QJHax?=
 =?us-ascii?Q?kf26lAhJM6jJJUO0BcWxcUs0inAUw45H2bec+0+cF+GD0pf1s6lYoIITxDYh?=
 =?us-ascii?Q?3KN1UMrK0Vhc2ZGpfwttkn3j+aQXlk+eQnANEY/ePIPxCmTDqQ7KwEvKYGBo?=
 =?us-ascii?Q?pP8ZvWAvfxu5109YALNnZIGDb7nXDguGuzHnkvJmKLbHx1fQQbJU79WxK0jH?=
 =?us-ascii?Q?+RSNA0GTvB30YzubeiEhe29J0Qx8jkPqP+G81iC6vqoOeO7INxHMDg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 01:21:37.7115
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d51295-56ee-4e4a-7c13-08dd5603eaba
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FB0.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5533

From: Fugang Duan <fugang.duan@cixtech.com>

Add ARCH_CIX for CIX SoC series support.

Signed-off-by: Fugang Duan <fugang.duan@cixtech.com>
Signed-off-by: Peter Chen <peter.chen@cixtech.com>
---
Changes for v2:
- Ordered Kconfig config entry by alpha-numerically

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


