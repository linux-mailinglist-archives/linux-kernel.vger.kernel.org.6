Return-Path: <linux-kernel+bounces-187158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2922A8CCDD5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC97528107E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 08:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609F714601A;
	Thu, 23 May 2024 08:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="qfuxwC0e"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2056.outbound.protection.outlook.com [40.107.117.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FC9145B33;
	Thu, 23 May 2024 08:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451485; cv=fail; b=aJQFMTMAkDYOaZu2bdnAENCPQtwaxGgDYGkf3bdkYl0BRSMda33nuiD1V9uM9YdhuGdMVom1pjVaQoH/SsYhrgeJuUMhvNHlH25y9AD4UHC01wA414wxPnUcnG+XWDeE5y03dGQzxl6TED2v/fQAfQw+Fk8FIA5IKTbbNHFFCvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451485; c=relaxed/simple;
	bh=gOTtY0AKzJ5lAs89ZBm4Azt5lpi8hiQG+0fSEaBa1jA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fYD7HizDi8Y+4NiT3D+nol05yL8RMhhXXXsay+O40WxLwkCHuaru+uxq+TuXd6fIbAetkNZwtJ4CJVGLlUsrP1LYDfq7k3cQa4Oq+t4UA6fZJJY6DDJdmQ/zSHfjwXc8f26J5B3lu+bA9tBaAXoLN5TgK5L93DhXVP2R1lUlmrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=qfuxwC0e; arc=fail smtp.client-ip=40.107.117.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ceOuv/YX5+nuMe+Xjd3JrcXOo0JNqSE9tag5TQF4tnhd3BGcvrFdmPBiAteZ/0JxxD5bFGO+7ibiKYJJ38WPNJayHIWkOGBkCu9wrrmNxngN0Q9bcu8rU0kRlBfsM/SkmMziNv+CtroXimQ5x9LL9f7XPMoU8y/Cu/pE2hjt1wD9Q8znyy/DwsrPQvKDzPncQ6tfUfPiOWnAJkk+bGop+VvS8Ri0g3tH21ScnNpQ83PgEujEBkkvwNRFICBW45OXz3lpuf4eUS1pNxPEXplDcejVixxjw974T1QsHMAZsImBQmbTNVEQFo68nnsmPuk6jyWkX3cJwcQYPl6dzVFCwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vQQ3x+PmWObjM/+/9aZu+RrnQuFpeCkTBq+qesncHc=;
 b=jdODsdDvYLpSAmljEv2eXgwPyudu1go6qAv5MJhmC5W58tHOGOohFnAza2ELIQ8epefPChGHonnA3NKy7r4vFpmedZiMegp6+2IznhfhWgXgdIzFtNPXDyVpmue2oHE3ToSU4WK/ylIr514BHm2RDki2/Q79yG2XUtYpLux8AagEhTSjq2b95oiFQGJiy0xadnXiwbd/gkktjJQWidMgc8tnBc0sADf+xhbOr+XsNsUT4hdajmSvs/tyorZiQ/f+ZRNL7Tj4vUQa5gTHS6W0E7PoaAtd7J3cDPLj7o+CO1LIpKIC4og/CkI8F0vtjOtT38szHOFS3zjf+DeNSDh2FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vQQ3x+PmWObjM/+/9aZu+RrnQuFpeCkTBq+qesncHc=;
 b=qfuxwC0eKOpQduTpbH/O2usggAmT1tl9fT/uok8nu8rYUbWqKhzymygG+tAo9dgRzPaTVq0nOMZlmw4/OQH3M+KxPrZ7koaLG9ISn61bqVBuNcS8jFpig9QkyHTcHl5n6lrfYI+IX2Hpc3Yph8cUvuzYlZAh3elJ3cQe8sKl0LcIV4r+wcEgazHpIiWMkgpcIKFhqZDBv11TQftH9PtZbpfzBLc/ggePcxc+5QH+h+icksLlWqsmXEdc8cDHNd6n/fHMd9cC62RPLUkKf+HILiG7tTUGC84BzibZ2pzZ66kXTo2sk8EKSKRAZhdU1eYc4TfaaPDhNUUyD6es+nZUbQ==
Received: from SG2PR04CA0174.apcprd04.prod.outlook.com (2603:1096:4::36) by
 SEZPR04MB5946.apcprd04.prod.outlook.com (2603:1096:101:65::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.35; Thu, 23 May 2024 08:04:37 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:0:cafe::49) by SG2PR04CA0174.outlook.office365.com
 (2603:1096:4::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Thu, 23 May 2024 08:04:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server id 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024
 08:04:36 +0000
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
Subject: [PATCH v8 13/23] ARM: dts: aspeed: yosemite4: Revise adc128d818 adc mode for yosemite4 schematic change
Date: Thu, 23 May 2024 16:03:18 +0800
Message-Id: <20240523080330.1860074-14-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240523080330.1860074-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240523080330.1860074-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|SEZPR04MB5946:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 28bf7d02-0752-4a65-05a5-08dc7afefd5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|36860700004|82310400017|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?owujsYG4mMfD21hkIt6B2ndgZE7DVlFs8Rgun/ZbLcBm+l9Z+deTayGiknCN?=
 =?us-ascii?Q?GDHl7zS7prJUEt5JJhybPD6usHuh62h883MRDt/7nymXY9tdr7diESlwBoio?=
 =?us-ascii?Q?K7eCscZlbs67MBz6M3Td7iEaFpZ9omkZnq+tpAswgBXQamZvC1QRkge6iy9N?=
 =?us-ascii?Q?iuO4Vrtf467vjRLzEocRHrpTzExiSGzGGXlsqpjQx3QdN9dwtwbtmDHOwe1h?=
 =?us-ascii?Q?7KB6ppl2gtnjjSDVz5I5UyiYNL8Gu4vEev9mJeuGRy9+UCD/WAzETFnKV95U?=
 =?us-ascii?Q?VFHL3iB4tZwavstTnhaMgEpGhEKyUzUUuSWq0DXhd/CbZLW4MvUjXzaiTeOg?=
 =?us-ascii?Q?aSnxxiTSztgdfIVNgC+3cuR9X0UEweGfzTCMpWZtiJyPm095IYTzKHjxKxNY?=
 =?us-ascii?Q?RkwU2A3sg13evQX4xboCTZEZivFaq0mvkR0ev8hJQ4T1UpkotGIJEEwQ2HcS?=
 =?us-ascii?Q?9hi2diG87HqhbmHw3lfv9x3lxNIr8TwVB02vDCF8QZjA20oe9D45RuOMZf6z?=
 =?us-ascii?Q?YM5X0sX82Wdg/ymaNX+my0MfATCrv2qmyL+48g7aC85FkZTqQJ2jxigKBwWy?=
 =?us-ascii?Q?56VDnBYQU1EMKdb01QvOMgaRnMDIhGiRlzu9sckJlQ7w+YTxANzodnjDj9O4?=
 =?us-ascii?Q?Kkmhqmi0Y0Jx4xBm+Y84xagUwYY1r0F/737KcMpjKDVi7Z5QguW8I7NniIF+?=
 =?us-ascii?Q?ishPSCsllf2f9W8lP+uZFUn7sxElz2e2B8awTIryZghvahOMFGbrJ6bmzg4l?=
 =?us-ascii?Q?iq9NTVJotYn4EbVxRGbTw9Tu38NUQRSULQjc2VMam9GR4uEqm+MDggqHFuHW?=
 =?us-ascii?Q?Wqh4ro74LMeOTqs3UIZCsR+2gxn8a9/B9Pnw6GEhvvZUbLPgkY3a5NXfxaO4?=
 =?us-ascii?Q?Kwoz2DoeWGB7FldPwDK9vEVFx4dOLCJFSGo5yNt82pkFrsOy5Ego896Rf6ks?=
 =?us-ascii?Q?MVFVqqwco5fAlFeitEY+jPv3CzZJ4QOJZ1zUQuM4B19tOfyqwjpHuA/WkTWw?=
 =?us-ascii?Q?Gx0eTac7bVb93GkDKJGDCdNeeD8uHPS6WKq4GwGuvW8qOyuzoYsXb5qctIdz?=
 =?us-ascii?Q?W7ihm75JMsuVTzEY8Fjr37zI4XPWvLZSIfbFDL+NyR1b3vnr5Y9++rAbbKey?=
 =?us-ascii?Q?WNrJ6BmCQwrMU5PU2WCfOQayzcLrPeMNUq/kvTmMV15S6Y9hNwzXI+AsZWi/?=
 =?us-ascii?Q?Z4wnL1v/+XSDruI60lt2JeuCQ6r4SqfPPMKTOzndb1rU6B8IVo9sXRegHKOU?=
 =?us-ascii?Q?ZuZR6f7JwWbequsY04KVUvzAxRzWx7C6/P72ljreMrZ+oRPIikuxBxXjDYxH?=
 =?us-ascii?Q?Qng/j72XPRhHd1+OxdVpBeg7aTYcql0zUp660lRqnU5DhjLleipBXXmD7OdB?=
 =?us-ascii?Q?IP8nmSRoaTkAmX02ZXJbN/qAF71d?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(7416005)(36860700004)(82310400017)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 08:04:36.4219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28bf7d02-0752-4a65-05a5-08dc7afefd5d
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB5946

Revise adc128d818 adc mode for yosemite4 schematic change

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts  | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 8f3bbdd1bbc5..0c7d85ff4360 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1018,19 +1018,19 @@ &i2c14 {
 	adc@1d {
 		compatible = "ti,adc128d818";
 		reg = <0x1d>;
-		ti,mode = /bits/ 8 <2>;
+		ti,mode = /bits/ 8 <1>;
 	};
 
-	adc@35 {
+	adc@36 {
 		compatible = "ti,adc128d818";
-		reg = <0x35>;
-		ti,mode = /bits/ 8 <2>;
+		reg = <0x36>;
+		ti,mode = /bits/ 8 <1>;
 	};
 
 	adc@37 {
 		compatible = "ti,adc128d818";
 		reg = <0x37>;
-		ti,mode = /bits/ 8 <2>;
+		ti,mode = /bits/ 8 <1>;
 	};
 
 	power-sensor@40 {
-- 
2.25.1


