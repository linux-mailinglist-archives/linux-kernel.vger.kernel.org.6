Return-Path: <linux-kernel+bounces-300803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8805D95E8AA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD2B21C2087E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637EA13B5B3;
	Mon, 26 Aug 2024 06:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="nSe+SLhr"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2049.outbound.protection.outlook.com [40.107.215.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA73213B2A4;
	Mon, 26 Aug 2024 06:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724653513; cv=fail; b=LnPblcZJ1vR21m2fQkY3kaH9M8Heu/0NKHcajKgKNRCVPF2FedCmoq0iBosyQiJLBsDuiKb53iwVsTJLCCoTXJgsfnSO5aGnieNW/3zD5mcgVZjyv+Jm7G/wHZDcNCaP3rmBKMAPN1Z8cEnFS+wFpcs/usR5QnhbtKVv1819yVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724653513; c=relaxed/simple;
	bh=yAhriQXECovPY4CY9G/URMvwVnjt/mWrgCqZ0IcJHTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TvrVZcFmBzt7xaLWoETGiONSrH3mt+bSy0uEtMYSn+sRQbXMg/dH5/h2hGN5t81qzsWWxGttnID7BGmsDmAEpMbY7aAJlZcHAvO7udZB+WCv+geZJFURsxFYHhnj4ogksrUu+JRZ1Zuwt2m4oTSI2dgqO692nlpEIQp4zoqDP8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=nSe+SLhr; arc=fail smtp.client-ip=40.107.215.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJwhykX+aIrY1ClDf5UribRrmTgboKbWaSt3TdqkGQU1oIYFmFxIaRlhnU58F9g/3LdF/oHhw/6LPreBVyrk3e9tAM2w40xNwebM4asU2FA5NiIuZ8ANn/C0tj4zBh7oPjhiA//zxqJrxLJW8DWxwOHtEbc5i1XSEyjowV59QWIBABa4GGjm47oO90PZVmENWk2IS4PKfoJThTH/jFk9RcuOpCNDQ5r0EbLPemwUTjDND1kwD1ZhIKJ/zFGPFPh9Kc9IGVA1T3j3xCEI+xJHl6bbtdHrhkYMhFwqSP4rIwXF7heDroKnWuuP2qLEv+BuGqvUocYKhnAJ6sohEaubFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1Mo5JFgxGn5H6HKsVEDEaSyXk72X/JC48fJnaRvMS8=;
 b=WNFTsfoT4bY/rnSXX22OVX1atnNbIX6DQmH28oossy4jeUH3ErSNdrZEKXL5Y2xVz8bdPFMx2+PoxjPuOh7u5Tro6PPBuatST8ZpZX7FgAzQgGLIc/NMHedwN5s5cii/XK8YMZ+NDc/MpyHuhca9CEB+Yu5VaU01DYaVLNDY0zvyMqbjtmT6L9Dt51TZ9tRWDxUYO9IT7JRELWN9eeP/HSN2j0O3g9Eu4/V5did7ohuPXixKBUvHq9AxwgNJ5AckK1D5dhogU8glLPgiA+A0/bP7qdHlm/IhcLs1veqGQX8Djt0dl9Fj/TGACPxDUVMoHFxfMIy31qosn+mOTP3Oyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1Mo5JFgxGn5H6HKsVEDEaSyXk72X/JC48fJnaRvMS8=;
 b=nSe+SLhr/7mjtGr6+m/e5mEfzkmTiinCzpnpYJpQcZYzefdTZjR5yJobFvVQ+/9UXHlGFQoDj66HJHXc7+/t6kaCojyG9cWhx4YDT3HppNv+g+GNbSCm6NIL+lsQ0phJpa8D2UArqJMEoBR/FbqNHVP4oBuDi61wAgh1ps4NLg2pFl12pQCWxxgZWpXIQ/n54ptjjk4zp+a5F/Fxl3dSsPcViaEvrRYNeI5TZzM1OtJVhEeZC2Hh2lxSJpU8a5j87VdKznogNnLunsFUF9/dHVb1sWWIzs9Nly+Us6IHAJGOWTlns/fxkiPwAVroSOZb7HPWFizMr4q6+jpGmLXrcA==
Received: from PUZP153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:301:c2::11)
 by TY0PR04MB5609.apcprd04.prod.outlook.com (2603:1096:400:1af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.23; Mon, 26 Aug
 2024 06:25:05 +0000
Received: from HK2PEPF00006FB0.apcprd02.prod.outlook.com
 (2603:1096:301:c2:cafe::c5) by PUZP153CA0007.outlook.office365.com
 (2603:1096:301:c2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14 via Frontend
 Transport; Mon, 26 Aug 2024 06:25:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB0.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server id 15.20.7918.13 via Frontend Transport; Mon, 26 Aug 2024 06:25:04
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
Subject: [PATCH v14 11/31] ARM: dts: aspeed: yosemite4: Add eeprom for yosemite4 use
Date: Mon, 26 Aug 2024 14:23:45 +0800
Message-Id: <20240826062408.2885174-12-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240826062408.2885174-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240826062408.2885174-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB0:EE_|TY0PR04MB5609:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 39d93e33-fbe9-45fc-9953-08dcc597d2cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G7dA2fAHzVvbqeoITn2v0M/FVlWOf9wWy1pyhhEchg2Q3RyAqw/ClstJmWib?=
 =?us-ascii?Q?OGcKZzaFj0uKFTSLaelrBl5HqpRj2qAwWI/uxqXxkKXaXtRUqAnLm1AEYS37?=
 =?us-ascii?Q?GAtP0weXjyRkOn6LcimbAqUquiWxzbDIXJuhltlAInhbZg/M4rcMILlzj6mr?=
 =?us-ascii?Q?wE9R/jsPPoRFl8JOYpxU9VWw3HoOnCd65rOdCbNznYkO+zAoKSboWxwrYYTn?=
 =?us-ascii?Q?fSKFvDSf/vcpRXoO6LcnKnUqr/IqwOO/G0nyF6pvfwfdJbNkDL7WWm6Yoa/s?=
 =?us-ascii?Q?RjhuMWWng4NWS8KMXgbN2wsUH2jiLcIXo9BqN73bnTOTVa5fXaqXv9RwjTVV?=
 =?us-ascii?Q?0CsPnO+k/J2njUK8OPE+kJmO/FZ7sKcyxFxmgRNGXuIBfo4i2eP3HxCwRFNj?=
 =?us-ascii?Q?mB8utsLmxXdkP9qYBqc7+QsUs3utWvnNREp1EYChBwkWuItrgNzcDKJKZJSG?=
 =?us-ascii?Q?bc0hGgRkEC/J7VYur3e5QempPJmWLBkQ3ZEO/KiGncfmZGjaT3B610BeMZuP?=
 =?us-ascii?Q?RXRc8kM6hbxGeHvboh6ECuOJzudCasxU872QdjEy2LN5481qta7UueAs4Bj6?=
 =?us-ascii?Q?k0PZai4uLGEHpKksGl1eJcGC9YK2qocjpB+t0vq9Rhqig81hoMBWbr1b2+Nb?=
 =?us-ascii?Q?Y0eOixjXekSO0UavhzSfUy69tC5Ac3xgHozzFWz5xpYOxJ6s2iNgUqiYE0Va?=
 =?us-ascii?Q?FuIGt9IwRLfhVht0/RuCXDyWHOJhw5vs0xfSK/u62LLDDzol9943Yu8igHjF?=
 =?us-ascii?Q?Jj0x6z3OWsBtytZYmTfMxF4rmJ7m+/pceM5sIWxslbUBE6peP2xMtiE2Erhg?=
 =?us-ascii?Q?17cMpXyIjUBhVLZkHSkJICzGjeYfac/QspXB9wjiT3rpNbIQO6iQsBdyIhRg?=
 =?us-ascii?Q?3+jPRCjajLD5uhw30qPyJq2JFsvV5WJ6KFEuNFJ80ROyRBLiiz6LXHANiXhr?=
 =?us-ascii?Q?t+mRhHkMCSxAwP3Xj9ZS9ci+acLjr/KyLoMQfRgxuG9OOfELGXJti2Ss9RTP?=
 =?us-ascii?Q?7jGEsi5p/Pe63+4GuSmkZx5E2nGdWgCKaEmR7toHdCcT3O001N3pc30RURBq?=
 =?us-ascii?Q?SOL51sasXzJpbPFZGJ+6uMAFbPH1apxr9BPRox1ItHd7uYoVEs/ndnEVSL3u?=
 =?us-ascii?Q?SZeN2IdmyMVEk02BrhDWgehSuXDcQgzx+7gN3/zSqAMo7sKKI3z7jr/4hMc9?=
 =?us-ascii?Q?xvKNdPGEKBuFB+YCEfydHJ4XsCXB6L37IvyIRbaXlcup749oue+zl5JHnzTC?=
 =?us-ascii?Q?AiILQVEIeWIvYv4TdjDDD4ETuIZfNfA3y8KjFWIn4uJIyyyV7w2SvDa5xiab?=
 =?us-ascii?Q?pLqaADvx4Hm5P1qXTGe11mIN2Tdws4FrwX8/p7oEefbi86sBfFZEesV83+6a?=
 =?us-ascii?Q?qBnLiJykRUDgxh7tSSLBjJOhVoTGRn1cag5pubwewac3CRJxhsjNz7mGdS1f?=
 =?us-ascii?Q?/2UIB/DXKZ5Kohi+bWeVU2d+t1qTImSg?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 06:25:04.4872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d93e33-fbe9-45fc-9953-08dcc597d2cb
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB0.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB5609

Add eeprom for yosemite4 use

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 139a09de24cf..e83cb51ac19d 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -932,7 +932,7 @@ temperature-sensor@4b {
 	};
 
 	eeprom@54 {
-		compatible = "atmel,24c256";
+		compatible = "atmel,24c128";
 		reg = <0x54>;
 	};
 
@@ -971,6 +971,11 @@ eeprom@50 {
 		reg = <0x50>;
 	};
 
+	eeprom@54 {
+		compatible = "atmel,24c64";
+		reg = <0x54>;
+	};
+
 	rtc@6f {
 		compatible = "nuvoton,nct3018y";
 		reg = <0x6f>;
-- 
2.25.1


