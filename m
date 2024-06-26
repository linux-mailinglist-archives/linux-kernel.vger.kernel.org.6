Return-Path: <linux-kernel+bounces-230387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A93C9917C1E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EA002882BD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81A2185087;
	Wed, 26 Jun 2024 09:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="EsPQfQ+8"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2059.outbound.protection.outlook.com [40.107.117.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87735172BC2;
	Wed, 26 Jun 2024 09:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719392972; cv=fail; b=m0nCRcIdrXygdfqjX3epcTJ2yAPxFNizXXSaFE9/K0heEDVvT19sVW0BgSKc6ZKRpoRC0OamLG4EltVSxpBz9q8XRQkSVZq4rUUC4phxJoVWmzcyn5LLgUQcfluL7lJFqmUW9zBW8K/ejoqhYNKWkGISnLFCS4zsdrBK8QM1AkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719392972; c=relaxed/simple;
	bh=pdoQ8UlRIK9EHRyTxZ4VK0qdAdbJgf+zB1P3lVO6iQo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Is1OpKmU+0JYlNV7kIfN7JVK3bThHhpHKBGG3haIbDg2d8tCXpu9Cs92/2zLjAVoJtO1O2qW8zSGyD78vw3r8NBEy2UWZTEb9vYYISXRSPG9siidMaaYcqpoYY1cVujhOY/ggYNJoGJYWDRUnHJVUBo4bkOPHgnlboUditIOFG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=EsPQfQ+8; arc=fail smtp.client-ip=40.107.117.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VImLdMpeskmehQs/GrUGRUkCLTVcZ/Bq8mfcfpvZbhclWtzQ5bB1BRRpwM1DRwmau69J+K5vNUB/PobaFTN3WoTr8bN9+MgR6WnVVTS0MEFz6MTn8vB0+8YtaT2vj7ucK6ox2P+PzWBfIFupH98EAdySASwUl0azJIX0EDTkhwLjyBtH/NMKcwc9YJC+tTEA0kA0gRkfrDACQPD8o4p/Ah4PvL9WB3n/PtnJAdPbnlRBHwUiKSHY/DwrEUy+EMRXM83QjaZ7RNTMgCqK0UUT+QbC7dYC7ZtrJWxvcEvf316axWlspv+EjNhNn7up3buKhp2uW4Il6lQDVX9kN8EbMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/bQfKhYxgR4PXNMn6B+jPqMYJhYuyz0n/Gf4miQ1Nc=;
 b=e1xhg2N6nrcxztoA+DrBW1erjld+0aC3hxDjctA+ukkFizJByz1Ns2e7MNk7jlAak+aagC8KKxZnyYNzRoZULctGmWCf6BlsNnJX7ZHHSgNGkk59zj0KJRhnsYVSLUkrXJOlSoXnjfIyNl5DpnwUaMXQwU2qVMtMZSOgoqxNa4hfwTZZkCdPN+qotTTcn+f2ckYq0gBoHjBG7e6YDUifHofAvcPJXROmgA9BJtUreBRtM9yhOSrJKUkI05VFS4+JPbyy5PeUH8y4wZ5vq4hYsf1JoQS/UZTosK5izsO9hYjPG4R4A2s+GVxPdjg0ePS/r/jUfHoCqz3qr2fhv+6JPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/bQfKhYxgR4PXNMn6B+jPqMYJhYuyz0n/Gf4miQ1Nc=;
 b=EsPQfQ+88SFBlOVkHfCfKutT6HvPja5zz6MUqekpX3wPSSpWLVjeyCasAy0T97Za5JbvZXAgnj9ApIwgWAwuQPeXDjwWyE/pWqH0RS7Q3d6TbIKH1cxP6Ms8oVj8piNKQU30azopDiKWDI1HX5FAAPibNvtdKzlNq4LHiokN5xqM31eWUVofds/ESE3YeVP0ycVOE7pVr7tCfIjo3UVEtREEHO6bTjaIbME9dlBrXjQ9s4LzWC+ooYhrwQudvW49k87TOfVFm3wMR7p1UWWCZeIj9h4lx0xhbjMENIy4FrfRmAxKrHLHVx6bhChFMHHhmB8E4/pq1/wR98C/DhJeoQ==
Received: from PS2PR04CA0002.apcprd04.prod.outlook.com (2603:1096:300:55::14)
 by TYZPR04MB6636.apcprd04.prod.outlook.com (2603:1096:400:334::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Wed, 26 Jun
 2024 09:09:27 +0000
Received: from HK2PEPF00006FB4.apcprd02.prod.outlook.com
 (2603:1096:300:55:cafe::b0) by PS2PR04CA0002.outlook.office365.com
 (2603:1096:300:55::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 09:09:26 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB4.mail.protection.outlook.com (10.167.8.10) with Microsoft SMTP
 Server id 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 09:09:26
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
Subject: [PATCH v9 26/26] ARM: dts: aspeed: yosemite4: add MP5990 support
Date: Wed, 26 Jun 2024 17:07:42 +0800
Message-Id: <20240626090744.174351-27-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB4:EE_|TYZPR04MB6636:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 26279444-d5e3-4306-1268-08dc95bfadc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|1800799022|82310400024|36860700011|7416012|376012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FOX8j5O98TmwqqG0u8q6ZKFUDZy0cACAjg4OKJLz4LvZbjpXoVCoCnf07JKH?=
 =?us-ascii?Q?JhHcwM+tJ1A9qg0+D27wu2IyAiSUnCLkVjsjkGQMuf8ZSQg6kKRX0ozI1yov?=
 =?us-ascii?Q?5Ts1LVB3Z9vZVYO553xNax3TBtT9TamUfEQOQIMxUUyQgivTFnseopHDy6zt?=
 =?us-ascii?Q?jxJ//aGKZwJDnuz3b+tmbMYELowbwEDNPGCmHoiJgJjew3X24zOdizDh4iMO?=
 =?us-ascii?Q?TdEMB2UwIUtpiqlISuvyNZ2Ee2SsYQ1BKOHSkb7j7LzD31MAndL2mp3xyl6E?=
 =?us-ascii?Q?jQZEMpUuHTDSfQRZnRdkPVJLEBAGXK0Ef46jz1bvxkSKxhAkPLgV8ZJHDBHc?=
 =?us-ascii?Q?gPJQH7ForEu/pRisVEOLRsC4cyBmKggWeY+XhmnsoMkBCvUeeoy3rnSO4pgL?=
 =?us-ascii?Q?hHHqCqRq1RAHAOP/qu/ODnf2lIrdlFeHwXYfpwVMxi+JOHawufa7uF5ZUVe5?=
 =?us-ascii?Q?d6YvUMS/gzo0OlatJwleJCfZVvwJl6ubT0J/qykZeicj6a8v+w3ODXdm/Ml2?=
 =?us-ascii?Q?PvwwoTOKIdQL3PFippMo9ryzj1SHYwcPuOyAB7wa9F6ab/j4e+5ATE+NZUQl?=
 =?us-ascii?Q?Dj0s3rGicrNZvKNMW+qhk9F63vnceHCW+SqXt39C4l7Aa0rOW31PdKohrBkr?=
 =?us-ascii?Q?YF5aAerqM1Xv6uIxcjFcrymEPlpPuPojxiINW331mbdUiekj2tCDrxUJWzm6?=
 =?us-ascii?Q?aRmncBn3BZkQZYLT+sdt6mrdHiqLSyWhEB7IRj+umXpRzsX5Mc1EvUsPK3W7?=
 =?us-ascii?Q?r72Q18S0CnE/cOBFVQBrksfcs1H90zMX/NM7Ck+UgbdQsj4eiq3UCiKDEcNe?=
 =?us-ascii?Q?Ci1WcWqpw04roCPUkPOHM35g3lVu7xusQ/2o+ElijgmwQnqKVX0S/ZCT85ij?=
 =?us-ascii?Q?hriZvqJ1Bx0TJ4vRfIsuy47TlsyXQDi2AhGNbihzig335kJ0d9lf17Kllc+p?=
 =?us-ascii?Q?WWIFbHe+LRk9Bys+Rp6PEIglC55OhrqJ22zMbw6j7ag7PfU5zMqdUd8rIN9a?=
 =?us-ascii?Q?CDqwZBrkZh5LQ80tFFLQw6niuUX4dC+HcSeWMfayEjtQ8jGHfGM4tiGDycKB?=
 =?us-ascii?Q?N8Os7UZxWDylvVoxxcPgcSb3gQtIWJXbwRJ80Rv6tgiBF1W5BdjQw+HrtF0g?=
 =?us-ascii?Q?DYvOL1OUBylDabDKXBJmVl03AIsA+bQP/bcWnBrOg6Fl6yIykX4JO23g/Gsg?=
 =?us-ascii?Q?+HaQKkSajHpk3V2/hNQEGt2ADFsW56rhxQc1agoSNYBp6MIr3r55dnkVFSqj?=
 =?us-ascii?Q?Lx6fMnga4lC2Q6zxOuK6FtI9031ykKlVUjHAKuz/DyauBVn9QF9Wp1dMwzkS?=
 =?us-ascii?Q?xRdew3uNvE/ufer0Fv/do8barRjYnBsWJfy882iZdwlUyJo8ZEXrnJWz/hDX?=
 =?us-ascii?Q?NYEgnrXm2U+zeyCSDEQGHr5OE6kY8tLgUo9gj30s52FFbNKbCg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230038)(1800799022)(82310400024)(36860700011)(7416012)(376012);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 09:09:26.4115
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26279444-d5e3-4306-1268-08dc95bfadc3
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB4.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB6636

Add MP5990 in yosemite4 DTS.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index b0eb38f9aa7e..7ad080e3f432 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -356,7 +356,7 @@ gpio@24 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1281";
+		compatible = "adi,adm1281", "mps,mp5990";
 		reg = <0x40>;
 		shunt-resistor-micro-ohms = <500>;
 	};
@@ -402,7 +402,7 @@ gpio@24 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1281";
+		compatible = "adi,adm1281", "mps,mp5990";
 		reg = <0x40>;
 		shunt-resistor-micro-ohms = <500>;
 	};
@@ -448,7 +448,7 @@ gpio@24 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1281";
+		compatible = "adi,adm1281", "mps,mp5990";
 		reg = <0x40>;
 		shunt-resistor-micro-ohms = <500>;
 	};
@@ -494,7 +494,7 @@ gpio@24 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1281";
+		compatible = "adi,adm1281", "mps,mp5990";
 		reg = <0x40>;
 		shunt-resistor-micro-ohms = <500>;
 	};
@@ -540,7 +540,7 @@ gpio@24 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1281";
+		compatible = "adi,adm1281", "mps,mp5990";
 		reg = <0x40>;
 		shunt-resistor-micro-ohms = <500>;
 	};
@@ -586,7 +586,7 @@ gpio@24 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1281";
+		compatible = "adi,adm1281", "mps,mp5990";
 		reg = <0x40>;
 		shunt-resistor-micro-ohms = <500>;
 	};
@@ -632,7 +632,7 @@ gpio@24 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1281";
+		compatible = "adi,adm1281", "mps,mp5990";
 		reg = <0x40>;
 		shunt-resistor-micro-ohms = <500>;
 	};
@@ -678,7 +678,7 @@ gpio@24 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1281";
+		compatible = "adi,adm1281", "mps,mp5990";
 		reg = <0x40>;
 		shunt-resistor-micro-ohms = <500>;
 	};
-- 
2.25.1


