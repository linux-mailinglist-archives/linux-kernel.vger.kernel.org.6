Return-Path: <linux-kernel+bounces-187244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF448CCEFD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2305285BB9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6280C14A617;
	Thu, 23 May 2024 09:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="BBYhTapJ"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2068.outbound.protection.outlook.com [40.107.215.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2E314A4ED;
	Thu, 23 May 2024 09:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716455944; cv=fail; b=CrOmJbE2+/IJMTzY+9Z4ODOoUPXf8GrWxz4nU9o2YWedOGyyTwKy/MqHjIw/GhOah+nwLX90Tpy32MDUqPnLYWI7L7LZ09qWQF9JEP/ciWdXpJLwClCrIfVIM+6wO674tIW6UmOlBiMY7J0KVaIrGeIcWTpqA11zLGzQeFY2ev0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716455944; c=relaxed/simple;
	bh=H+ztG9nn4KGO+7HjT0nWeoYZCKeBbNIFW1aM6ZekDjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mo2eAxs31eW38qhOLQsEYi5n7eUzJ1Ks/9QMUecRV29VahnzrlHF0TBsTGIsZy+6f8LfZ037xZzSBt1cpOrUY1ra/2h8DZF4BWDm/z2mip263gZo57oLiV+9hyrbHGL+1FkP0aGjQUsG9QOTilyQNd8qzAcn9B9q8kbywK6iF4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=BBYhTapJ; arc=fail smtp.client-ip=40.107.215.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrFWg/sk6WEO1FcJoc2lxF5TJ3NgyQ3S+NMbwTsP/kTaAcpJD/zccbxW3fg1JxIJJ1IPmiyiTsdOqWWeALnjwDDn+Cu+LYCcleZ/DvbPAKKL/evZ+x13pCX8yq9uBm9TeBLOFM63CDEct4eBv9dbfwL/hT4Sx5bHdDJGLb4bLftl1f9ew31DQD2+REa9InNauAdvpMIBJZm8U9RSvkTapc8g2KJqxpD0updL+TRiRP6YwE5s8sRnDI82zW36MX8OJ393cJin9U7rBqO4x0aR7oHSeWCb1Y+w/57XcGAyx8s6p6+EUHJseV9welG6K9bbIXq7+tOMcsHUyjyXJjAewg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Q5MeEW03FNC2r/kxYIzAJUQLLsW+EcYLhskSOMMcDo=;
 b=U6vdKG7cY39fQWzOGoDoMpGDYt0uFC3QpqeipWaM93FdN+j7IliWXsgkWVCIQ7ILJjrMKy4V7qAmN99YLZ9/BGhmN22d/4vGituf/h7YVCJTW26Cshf0dsqumM8Ju1nV08BVM7OHJkb8LhOkZJmi3TSsxhS8XT7JH5PKpauJEtRh12TtOQugGjEidXpeaN67JLY1WM/x3czD0uHWNyiV07dOkqsCoYK/l6qKFfw1+P7EWi1LohwO6I5S9D0xwDSjG2KC6A/m8esxJvTt1/ZiSI9FB+HM+bxVc416n/o1hAopPHJp6unGBHDJb7aGodeTifo7IVdpkkiJ+j0sxGViQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Q5MeEW03FNC2r/kxYIzAJUQLLsW+EcYLhskSOMMcDo=;
 b=BBYhTapJ3sj1ECJkzcuqIQm1+ZbE9Osx6KeI9sRxaYCt/qLGcVjXZLOq1kadKWeFj5LHpJG9wtpR97hiL77JOZMxKjBTobLNhsM636V6Yzmk1+uI3a89s4MM1zms5lyv2RVOi+sMHUgwXQ4MBq+8t0v6sYZFvGSkKBciLMdZcIeIn4lNYWRopfWcchgiJzFngfzYaDEoZD6QxSJBFYKyWmsvqgjIRL1+Y6IMnlGNSGO0D2v01PTjgYYK0uQh1T22CKctAH6s+8pykw+qF/r7K2WRwDq4M5UKtSDNEolnauG2qFJY2X/hxZeRs65FRYBjqox5Hxr3LnrZPj4zBtgxYg==
Received: from PS2PR03CA0005.apcprd03.prod.outlook.com (2603:1096:300:5b::17)
 by TY0PR04MB6265.apcprd04.prod.outlook.com (2603:1096:400:27f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 09:18:56 +0000
Received: from HK3PEPF0000021E.apcprd03.prod.outlook.com
 (2603:1096:300:5b:cafe::8) by PS2PR03CA0005.outlook.office365.com
 (2603:1096:300:5b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19 via Frontend
 Transport; Thu, 23 May 2024 09:18:55 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021E.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server id 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 09:18:55
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
Subject: [PATCH v8 12/23] ARM: dts: aspeed: yosemite4: Remove temperature sensor for yosemite4 schematic change
Date: Thu, 23 May 2024 17:17:59 +0800
Message-Id: <20240523091812.2032933-13-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021E:EE_|TY0PR04MB6265:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: def4b947-885d-41b3-2e30-08dc7b095eee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|376005|1800799015|82310400017|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xJrZF8974VzOezmZkZu/snHQjMuRmUlBLSeLQ/hGiwy96VuCGHqhubKEHunp?=
 =?us-ascii?Q?laVid+uxW8U5W6jKLY7r5TpxehyJn/arwChS4g0JggtS0ShlzYjfq11W+6ks?=
 =?us-ascii?Q?dS3HYaGF/hWgGMytO7iMlthufrdomZccsMv2+JwCj2kwIPZxSNdnG1U/ZQP6?=
 =?us-ascii?Q?4hbA/l9x9Mk+0rTJ7fX5DF3OSFmX9PiWzb+/bsdH+SGAwHGmeYgB9sqCA4f+?=
 =?us-ascii?Q?unwhpWUIG8VIYraYJgQ/7yK92QK0AbAWIp0jGtUpZ0Tu3At3TX4UKoisgOE1?=
 =?us-ascii?Q?WrnsljLUt6b2h6r6gKnMVL3KoMr//mtfKX5Hp40Cnb1T2FncnRuNvtgywPYE?=
 =?us-ascii?Q?l/FLOOcJWxGnBSy/zFw5222GAF5ojSokxVHR0FANtNxWpE8ASkgLiZLpXbiC?=
 =?us-ascii?Q?nkK2wk8M/BxW7Xuqu0cM3lCGrcV7qu/bzHnHUsQwblLplGcn6xVkAEyHlQJF?=
 =?us-ascii?Q?/XiMad/ddzkd1bf/fSk4DdCcBR7zD5aeBx2cnd54Xwwtu5geJMuVB6ObnAvI?=
 =?us-ascii?Q?Sj/fr7HsJBYIF241LrSwjV6ReL+jwFGjPPAOBjAgJ/76NOw29rr0WOjhNiLo?=
 =?us-ascii?Q?so97oX7O++qxCFv80VbXSQ8Dutcaw9fiHHsQRnAzEzliW5UfzeO8DsY4Jg4T?=
 =?us-ascii?Q?0GvBd/WOyMk2fjFs0zcwV9jdiNDkDvSlS6jybM9m/T6VDCkyktRSxTMV655S?=
 =?us-ascii?Q?+dr51xzPCTtHiudio1mmnWSljiYMBLHerwyaIxonR4y2vkM/ktl58L7ipsyy?=
 =?us-ascii?Q?in5WP/s53/mFPqXLYqmClQwHu80kHlxTOdvgBEHAB7aZPIcMIyF2TXuOwIjn?=
 =?us-ascii?Q?hxTA9gh+LUFENr8FbVeKSQMwKlMJ2cgCOw1cMPv1y/bf/NBBf8jNE+K1pflI?=
 =?us-ascii?Q?ue2G75E5LPrp2yS1qbn9qr1kaGaxwgM3+LZUtE4U6rMgo+w2Q5XKmCEZ5C9v?=
 =?us-ascii?Q?e5Aiflu1uPsEVzbsOp+9fz+BCxNLIwTBElYab6J9OhLUG0zHRZf2VocvzDup?=
 =?us-ascii?Q?7F5oq6NGvsuPvEVm+GmO4hIDCRWGrYQq4rsuJMFZWlRne7/L9Kbx2L5aUORe?=
 =?us-ascii?Q?4heHqEfnK5SwPUnmgZaPI2ocUgimi/06q61020gJl8SPSl+L2xZkS9BrW6I7?=
 =?us-ascii?Q?l6s3Di7eb5XPe6CRMIJ/aLtbMswFt+0VGLd7pkpWy9KBJO2Q4WlVTPcL/cV4?=
 =?us-ascii?Q?5/1soyei8eWo0b+8a1S1mp5Nc7O00aeg5GxROH5IfNkSlTzXNkhyvcKgZ4dv?=
 =?us-ascii?Q?bQ3FurQHCaSX4MTvvAjxrKg8jxEQonn2YkZ4XErucCDONVY+cQYiaxDHedNK?=
 =?us-ascii?Q?YNvXXjPviR6y95mxNkzjM+6JIbKaxMVmb5IAHEBPQPIqdVXBcOtXD9s33wRW?=
 =?us-ascii?Q?dNZzARZPWVIKIr3Wq+OvRzS7VdH8?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(82310400017)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 09:18:55.5170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: def4b947-885d-41b3-2e30-08dc7b095eee
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021E.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB6265

Remove temperature sensor for yosemite4 schematic change

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts  | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 9a14f0220cf6..8f3bbdd1bbc5 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -921,16 +921,6 @@ temperature-sensor@49 {
 		reg = <0x49>;
 	};
 
-	temperature-sensor@4a {
-		compatible = "ti,tmp75";
-		reg = <0x4a>;
-	};
-
-	temperature-sensor@4b {
-		compatible = "ti,tmp75";
-		reg = <0x4b>;
-	};
-
 	eeprom@54 {
 		compatible = "atmel,24c128";
 		reg = <0x54>;
-- 
2.25.1


