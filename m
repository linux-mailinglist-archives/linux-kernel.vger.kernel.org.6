Return-Path: <linux-kernel+bounces-295271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F854959934
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A51C61F24BEF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066692024C1;
	Wed, 21 Aug 2024 09:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="rvSIQGyN"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2077.outbound.protection.outlook.com [40.107.255.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A602C20189A;
	Wed, 21 Aug 2024 09:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724233423; cv=fail; b=b0WD+pmxh7kRbPSQ1ymsN/IEGJ4R6F42gLqVJMZ6ZI7qNcF/tA3c+7qzaYcSYKvCdbPMB6Lxbgdr5xv3Uuot1qTvZQ7RXAcBKMosNw4bdbWj05GN4IBkRLxWjU9wvfT2hYIrvcSiKiuHHMuKzA0B7TXTEj5kb4dGLz1vmDOK3f4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724233423; c=relaxed/simple;
	bh=cS/9YApVsf8gaHDPQckZ73C8KOJ6xtxMgWUJvm6ZD9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qIbmZUQaeO1EXWLW17ccz61/uKK2V5tNMlrN5r7SMP9Ra4E4pDK3YAgSemTeqqNxnyBcMLI0ngIiu798EnP2GdKXO63X0lqGg0lE719o0QbaT8J4YbEKuOJj+nZsGUL5sf4baUbgZeDb3X02B3W8C+3h/lBGwdVyh76q/Bv52mo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=rvSIQGyN; arc=fail smtp.client-ip=40.107.255.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xdX4MCJ9v7VeEqDCLlQEDLrHfCFDmmp/K4Do9KmvnUqhxCqDqRAVnYVlDFBP7IlL1CI99N/Y/f8hRdH3Dz2PW249jvB1lb3FRA4Jh3dSdIfpmvtbm4enSQ7jeFjBC4nteNw9c5SokH5BDkBFiiibDFHmm08FIeVkEjJ41D297BzBv6UgHkNL0h/Nb6SUG/XBugADFgjarEDnTa8XZiTg/1nTOC7gu/6IUzr34NIqHHlj0gCgSs/hIIesvHeXi2S/2+/wAcLQv/+mh3Sw5aan4R2xLZlkvlh2MO99zxw28rMvz9rnhjcU5iN0RFm0V3lb5r6pVfE3ui6svHafEytleA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJty/Sn8NpSzsj8QpXuqGnw99pNMtTMnmTt569eZCKk=;
 b=eRcLArPU2HWsrukfr9f3P9IsUFyFistlt9mhYfd2mvlw9fDZaF5Mgmuk59jSR2GPWe8dNf8wRqwVoyYYw4H4zpqIhsxa5RNQWkO+wX/IdaJMUO9GqZUKPSsgm/MBpuExKkYp4mtXhsPCligOwylorDaL7d2eaIWdG4TkjwcBhMLO8ZdttEkXGFRcx3JT2MzsFWaVyCSizlZmCRwJY4URKtCZV0F6pXm3OZMuGbmL9ZMppSVTWvVB5iwKJ8U50fgyZ/N/ajzgDkvZORFi55trfkRFCKQF8YM0bOzrXoqdd7z+3qT9ZW971GoLZnetXVHBO27Outg8E3AZWiujHCCL+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJty/Sn8NpSzsj8QpXuqGnw99pNMtTMnmTt569eZCKk=;
 b=rvSIQGyNHLhHkmhn0JfHA4XtVOnv/9Sah1sbNgWQHpfSdVxJj4Twy5f0GTI+IJ3NV0+aJtP4S02TFfeMC4WWVtsn46CIZxvbdS5adH5ixQ10BNeBSR7BlyU+Gh/VAL7NLc5ws9F5bO3ID/dEWR4yzP7H8LOrtCv6dvEzDUB/BuW2C8aGBOnlHMM9EwWLR8+HLJglUHHGKKet9FUUiyOlzjGObb6mruH2c+Xo1R0Brz+FHDQ8fFQk2zPX8zKZzEyN/AC7IXRO8Q+JNDrMhiyiJzhEHKNCoyzfC+GNQXK3Hh7Ofrd9u/XWG7hByRmd+HCWTcQMHwsa66Jy02EkWgrNJg==
Received: from SI2PR02CA0029.apcprd02.prod.outlook.com (2603:1096:4:195::6) by
 SEZPR04MB5900.apcprd04.prod.outlook.com (2603:1096:101:64::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.21; Wed, 21 Aug 2024 09:43:37 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:195:cafe::92) by SI2PR02CA0029.outlook.office365.com
 (2603:1096:4:195::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18 via Frontend
 Transport; Wed, 21 Aug 2024 09:43:36 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server id 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024
 09:43:35 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Ian-I-Chien <Ian_Chien@wiwynn.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v13 29/29] ARM: dts: aspeed: yosemitet4: add RTQ6056 support on 11 (0x41).
Date: Wed, 21 Aug 2024 17:40:40 +0800
Message-Id: <20240821094043.4126132-30-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240821094043.4126132-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240821094043.4126132-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|SEZPR04MB5900:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 60d32d46-dfe2-475e-54d2-08dcc1c5baa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0NFAvM0HyoASkb3Wzz4WVPrHyi6iBA9iCQkRDaai8U1MHwCvAQo2HQq4Qz6Q?=
 =?us-ascii?Q?Dt9HduVP1EUXS4KA68LrM6ujUjMn9iv9KYXZkts5IBVEeCWfSFXHutYR0pyB?=
 =?us-ascii?Q?dWKsKHAbCjGv+tk8GHx3w/a7WRzRz2oTz3xHksfBUeHzhUIR4vWad+9+C4PO?=
 =?us-ascii?Q?t4NpipiL3p37W08vDgo3Q6xwzcbv3Bm0dL9zMFhLEARGWmX06VEPEOQQoMxc?=
 =?us-ascii?Q?KTryaGS+ICi3kLPKcDtT9JF7yE4GK1ndV9kc/jHbtVTH0rA5jQ4S7+4MLELL?=
 =?us-ascii?Q?vRpZbXtvNbn+lOp7HGvRotSVzrTYCAAX4FeixDVWKUuxxIZU/hki1PUe97ET?=
 =?us-ascii?Q?iSnw5pZmzLHcjWzdfqfpc4togr/vx6CDNmORmPcw+Y/da355nMOHNlMk+ucq?=
 =?us-ascii?Q?UpigGstQC9XL2kJ5youaYa+32+Ryuo9eryCUBP6aUeAW+z1DKdGQdj8fziJb?=
 =?us-ascii?Q?0St+sbGc8olA0iAQM52L9kJsx+ViZDg58I7BwCUZW2y6xAY1dJkjdM3/jqdh?=
 =?us-ascii?Q?ZKaK9N0kCkDU2NLaPVV99Y1D2sj2c18fb7MKG7prBPzH4/Oak9W3mab5eouk?=
 =?us-ascii?Q?8Wvb9y22yKtyhxZ6TWooJ2LSJKbEEbY7x1TXrPrlwef7z5P2g2slSmP7XU0V?=
 =?us-ascii?Q?aMjhExBqv5RNVMMBAwc8EfoQzfl8XlybiTNbxGYyT69zAu1v2YgNb3/bSvbp?=
 =?us-ascii?Q?lemgnd4BCFdLzemXqCeIGBK09LjUK5x/dK3KWUKbRQt8YXgUGV0egNTysMFF?=
 =?us-ascii?Q?ruCst721ea4KbeaaVEfXEprJFP/Z5Msa+tbZcJDxr6ivFU5/X/Od1s+XgeHP?=
 =?us-ascii?Q?Itxu8JX+j4ToOCV/eDRrwmDJbnmszDZ8Ado12OySFBQIGpZvp711YTDHkn+C?=
 =?us-ascii?Q?u6OItYSKdtBR1f5brM6poLbuDn2hhSpXP7VXSsQQQEh70kqmMRt9rozRLXQx?=
 =?us-ascii?Q?j3QigtO5iyeFbS3vlD50N6/ed7Omh6vfy/ttFGP5ByN5rokvpD9M9pPaiZr7?=
 =?us-ascii?Q?CIyqlJp/xTtDcKpiEqbd4JOtvmWMpS5jyY1KKoYsqVENlionrneLLbzl8r6Z?=
 =?us-ascii?Q?5TdDvOdJMc3XfVxorscVIgmjXTaeCuUwxk44n3SWetlliy4liw4YhpUlfLef?=
 =?us-ascii?Q?9gdoyuASVJm3o7nb7QJYxHVIl7M+JWrd/OIrVap3RxeRCqKkX/3Py0IO7lqc?=
 =?us-ascii?Q?tSSK+gXXcpkkRjSfJxJP1qtCjc1ZAKU9r8IC4p+5+p7xKzGzeSbVv7iM4v4e?=
 =?us-ascii?Q?MhYOj9J5Saj/NH5otIFtWyiZBbIKeYOF6RxQ8l+JJXKjxf1aEHJQg4R5P08H?=
 =?us-ascii?Q?jZQz0YuhASLzV6kUEJ74jrM2r+FDk/SOK2IL6RcLuTrgQmgmk8TyeUGGhrrj?=
 =?us-ascii?Q?mf1fYPeFS4QEjRK0hIuJFWdJ6ZbHMPwVgIxiACGas96GTV9h7xmxXi8cibt+?=
 =?us-ascii?Q?8CFtMeF/3UsCcPIpgk8bzsDgJ5xq/J/V?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 09:43:35.7633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d32d46-dfe2-475e-54d2-08dcc1c5baa5
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB5900

From: Ian-I-Chien <Ian_Chien@wiwynn.com>

---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 4090725160f9..d056f6d5ff6e 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1081,7 +1081,7 @@ power-sensor@40 {
 	};
 
 	power-sensor@41 {
-		compatible = "ti,ina233";
+		compatible = "ti,ina233", "richtek,rtq6056";
 		resistor-calibration = /bits/ 16 <0x0a00>;
 		current-lsb= /bits/ 16 <0x0001>;
 		reg = <0x41>;
-- 
2.25.1


