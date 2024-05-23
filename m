Return-Path: <linux-kernel+bounces-187238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAA38CCEEF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DAE61C214B7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6F51448F3;
	Thu, 23 May 2024 09:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="qVSr7FMf"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2088.outbound.protection.outlook.com [40.107.215.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89EA13D27F;
	Thu, 23 May 2024 09:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716455921; cv=fail; b=V7aoueeJjvaBRgykeAlOXYBzoCyespj3FEm+8R/VxZ5aX96IvzcUaTpndakFIwvguXYTjGaB02iv8JJEQ8WiFzS0kpAGwL2rOkDZCV1hdSFhuFWYzZLbEabT97KOwhnrLcYwDLX89CPxJxETRJKR21/OeXbn1OJ62HXLhYf0HyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716455921; c=relaxed/simple;
	bh=mDZZJlkVcsKOGKmKvCEVvBfa6/zQ+Wv7iupq0qbeGNY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B11+wZ71mDYbntNHccX/3vQKNhkICgJBRb/Pd78xU+t3JZClLRJ/gi4aLC2rNAkjbmr7ln+KidrCIi/gmx70EBqvDPup59pzUnVsjNSZEjv7EY57Cm2wtY741qMIEXPyRCz5sznvqtxlp/0ZJUfNTavYuZvHo1pud32NgMv9I0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=qVSr7FMf; arc=fail smtp.client-ip=40.107.215.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdYcBMHWL9oGaBvPYqC0BxUwjkapqh7/wLhccuGiUs/k/isxO3DJ0SGYxWxmXQpeJcYfMWrnP+JVDFwtoJEMmZKAx0k/xdcJbcOAAKuiwVhRv8h8q5v1m1+xUZv4kCQ1kLSKyRSOCaO9REjeGb89SUY5Mo8j8JCW6OBPPriH1g5BR18/sy8llSPntLMtvucya9KUIH+eTLQwZXu5RSAALey1gqdYU4pTN/1K86EJ+Ec7hGE3oB9XhdmZ6n1vGrA0N6f0evcPoAYmwzIRC/fUz4+KRh7l3DQMFA8izNy8AzRJ3skXICMSvlGY/OTIi+GfVkX34VQst2DbKkHGi2CYIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/dqJuii+ID5NkttuzvqI67JF2qX2ZPzbFRrGdWVquY=;
 b=La2oelQ9r3M6WVSjWyVptS8Xx7E6LGMoDxQCm1psrFiRuxI+01gYWnu30q8mBWdLrWzIjjGLG5zeeA6zDBPd8Up9whXmxqhTmv7ObeMISmc66HFjXjxLXsleGNVI/epOuNaAlLfzI9l+HPsrg+VLmQxP+hyTMC6UNgprM2eyRFMnTaYiUStNH76nPBpjUDQQT53VImiagvhCpJAdP5v2WgHPQoW0sseUSFbNf/o4AgWdKtW0PBrhAY+Wqtpf0ISzoPA7UCUMcONUYDrUrIspvghjZqNCalT7aaR+fgOxHIWHYPOi8jVqq77dH7xogi5Ix7Xw22xImKLtUeXgsj5JDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/dqJuii+ID5NkttuzvqI67JF2qX2ZPzbFRrGdWVquY=;
 b=qVSr7FMfcHA2Vd/1+Gtv4oq7V5BQfRmpe6jUMUHiX95Ni7Q5KxTm+UGGn12Vhy5PhKVeF4cZ2TVHOarx2NhY2H+i05LlR0vd1+h0HoSqf4UEfaccfuIcuhqcXvJZEIluhhoGnq8A0QW7aM20CxBEMeBqocxCpd1Slc6zSqpp0GRWv375KFPW9G3/bU0jdgRIU1WLzQ9W6JmlFIbAzCV5Ue7q2XbyJtFITzcKRre9B0uo/l4z7Z7jrCUGqqTpYG1VYBfxYMZmAkVF60LmEO/fhHZBQNywOF25yoWiMFr78LjY0ek5dWhDKy9Z/Wf5vTv2KYMYscg6CX+0HZcUJDlMVg==
Received: from PS2PR03CA0024.apcprd03.prod.outlook.com (2603:1096:300:5b::36)
 by JH0PR04MB7175.apcprd04.prod.outlook.com (2603:1096:990:3f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Thu, 23 May
 2024 09:18:32 +0000
Received: from HK3PEPF0000021E.apcprd03.prod.outlook.com
 (2603:1096:300:5b:cafe::91) by PS2PR03CA0024.outlook.office365.com
 (2603:1096:300:5b::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.6 via Frontend
 Transport; Thu, 23 May 2024 09:18:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021E.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server id 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 09:18:31
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
Subject: [PATCH v8 05/23] ARM: dts: aspeed: yosemite4: Revise quad mode to dual mode
Date: Thu, 23 May 2024 17:17:52 +0800
Message-Id: <20240523091812.2032933-6-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240523091812.2032933-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240523091812.2032933-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021E:EE_|JH0PR04MB7175:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4926de34-7d8d-4d0a-d54e-08dc7b0950c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|36860700004|376005|82310400017|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wm1FPgvtuXmPAcPsIldGRRKzvN5WLY8lEtuIB9UmvHlFogBmWAnrdURazsJ+?=
 =?us-ascii?Q?lHZFEcduaMdB69aa/loovST1iFQ1muVIt8ewHZKPC3M2Zj00jISBK9Y0+LbH?=
 =?us-ascii?Q?KUNNGaxAVp+WhoKDQ5t96ufC/p8+FHEe6UfeNXKQggTrPAm/wYAyTHzHz2k9?=
 =?us-ascii?Q?OE83W9tlq40klWRyKnoXYntfKwLNtlwhJ4Rz6Za+LIBMhBXxPB41TwQttjnv?=
 =?us-ascii?Q?+E418XVNuonCLSLscw15FXd4iC5+7Os+eV0M2R0mA+p5xWgqak/w/JL0OjWs?=
 =?us-ascii?Q?l0TaziP5igH3ZdOjmuvC075zZi65mgPW9qTzNGgp/zAtmz5Jesl8t4VpLP0T?=
 =?us-ascii?Q?5V0giWuaiWszI40Fa7ZBdLPvckZpGjg2czGgI0Gl4rg50OG7vyaYf5gOPyJf?=
 =?us-ascii?Q?qlma7502GWjzCIBPoyP6zdQ27+9ykfVuGh26HR6PNPW7VEu0Rn1mfSM+yksJ?=
 =?us-ascii?Q?xKQhb6yZkp3C+QzlIpxs+ccL6d2yythBDtQaF03cauwk8tuGnSK/OPLQaOYw?=
 =?us-ascii?Q?XLI1mhFzDd4K24VWUFvMyLDXr/z1Zp8u00FCpJKRiTa2T6A+ALkxvcC47AMc?=
 =?us-ascii?Q?1SRFFNuHv5q4Zf+E3xgdPAy2Xi9Me22nm1hHZuP+uZywFdpdWx83FoGWO0RB?=
 =?us-ascii?Q?zGlLoaoAMSXQvSrg1LwiYuvaciAZvEPThLu0ktMIFPeVnVs0l4y4T46KxKTp?=
 =?us-ascii?Q?xbARBFQaCpCMOHMRe5ewrj2QzLC34ssCaTkaRDfoqp6P69ZsCdt9f8VozQct?=
 =?us-ascii?Q?Gv4Cfp8Q2HA34X9TZDB8ShScCBoWzZQpvEXThFe0XBmitpIDzV6K4yvLiT3k?=
 =?us-ascii?Q?nXs9M9ZrdDQOlaDZQ9EMeMfMeYWp6auV0nz2ht/wRni8Bv1HZlKiquy9UoW5?=
 =?us-ascii?Q?LI5TN5gKvLyv0aZ1cI3LwsxGUjh2OTFrFLU/l4m/A5XeVanx56sCARzDe4Pm?=
 =?us-ascii?Q?hIJNJXyv0nfjWLqck9p5btMXrtPvdke95xHcydIxwErggvvv+AXJDPvl0dwj?=
 =?us-ascii?Q?vAi45JKQSbpKs/B/iulDp9EfDQE6khh5QkCbSxeybPkN631A/gODNfkYm5G4?=
 =?us-ascii?Q?e0DJ1TPdzU3IXOhmXpbnQMITYVHU7lWrhKI2yzudAJ635tw0jwoRSgWQeKIm?=
 =?us-ascii?Q?f4IYY4MrCkQCojrNKLteofyKoSKwk8/g7suab3WIyI8iZllXMcHVtr3N4mYE?=
 =?us-ascii?Q?k6SPuvSXTA+FfHLeN/F4/jkVBbCEtqt6kdfY6TY6FR7C8QHGB8xWbKNa4OO8?=
 =?us-ascii?Q?hOXTz7HKzs8CyEWiDLpSxxZr8J/eJ5XJp9OE90cDVhlijpSFb3iYqyFOgx3R?=
 =?us-ascii?Q?gXCaYEEQJy7Yv24phPo2N4B5eDWwn9GW3m1j+AtfC1/U/gRRDK0ed0yt/+CP?=
 =?us-ascii?Q?WphuSpKPJWKlyGsWhlFTw24AFga2?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 09:18:31.7513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4926de34-7d8d-4d0a-d54e-08dc7b0950c3
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021E.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB7175

Revise quad mode to dual mode to avoid WP pin influnece the SPI

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index b0643e8aefee..a708e56b7ec3 100644
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


