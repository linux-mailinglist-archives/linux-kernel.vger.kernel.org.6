Return-Path: <linux-kernel+bounces-259826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8F0939DBB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FF111C21DA5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A095154BE9;
	Tue, 23 Jul 2024 09:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="wi6+DiMU"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2069.outbound.protection.outlook.com [40.107.117.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A72415442A;
	Tue, 23 Jul 2024 09:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721726684; cv=fail; b=bTWPB5EQ9fLOs6xFeYR1hWSqfefvDWi66HfVVTVUHmBF3wR/OeKvM+/DJtovqBdSK1rdzr7De0yq8N/PlVFZN+gGwc/qTdpe9jpMVDTpwIopXnKc9SSvJ2MEAQTasI9CDk3YCYyW+zhZ1iw0Ls8ixsPRVqCH6nYLDnyRO/sYgFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721726684; c=relaxed/simple;
	bh=bJyTPwQ6HLIm9WpJFkRqKJv3EdjekWxcOSacyOXtKik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g/NhDUVrWttb/7rkaXMo7aus6OnVBbkCQpx/0xXZPXhVQyeOYB7EPKfRdMZ6fNwZdCme5ED5vcm1I8gswi2VVRmrBtwD0wazSQT7G4z+3gIxw/4h8CeHGQVTSb9LEPPrQQLiPhKkUfcd8d4XBcUzRODvmwd2YNzwxMo7qNVXDGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=wi6+DiMU; arc=fail smtp.client-ip=40.107.117.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RK9HVfJvr62GnSWK41IqK64ZHwRagPMzPjPpzxdpnmj0JeRpTbASEiumCNo8/Q56Fv/1VqPha94uO8uS/EZlin2q1TB2ih/DaZUviYrLGaZjya/u48TOjJbEn3bv8EoqdPBaf+Ra+RIGyfkRVW6CQzZyWa/7kUJRxyaMAlFRcBOW5Imf4+WoVEOof/mSLL2S+rnaVfT/PbhCGcE6Rc6H3kds4+9n8CaSZ7qWSp0di8HXhJMeR9Ot9ouCwdlD7qVg/vm+cBwqJ4XNpZkgg1NfDJi4dhBaPPX1PxcHjOJHVDOuvULBWklAJMWVhzJTD2w9qt5R/x9Fjf2eJu9jlJyDTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQFQ2bKjxnUV6R0l0iLzwvLwa8mKW3x6TIVY3QTprt8=;
 b=ZlGxYrPDxDMOrAVBT6CaDcTvRvSV6nmeSVrpClY6nhlNIEEjAgpDkmEp7QwoxxybQNrDoDo8bazJVjhmPws0p8LfAA2p7S6vvMq9Lio2xC1tJN9/dtWpCFbbsoIn9bB4jVZo/484P4MlfxTOgUhBgkhYRW/5j83RbhrBXTxs+8Tvo70stGJ8+dk7l4wnkXyWSKjwPICj6SVVUB1GrCLBo7pIEuTFie3Asb2cxy+r8cmIXJi3QaKVC+nevHzk4csJJ+UJIDUlTiotZXKlNOvMyRv/dNmEJWQuD0tf/U5RO5WmnInTzu/Do9tDVQYuXdIT00TmmnEw3wx8XJW9BdntpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQFQ2bKjxnUV6R0l0iLzwvLwa8mKW3x6TIVY3QTprt8=;
 b=wi6+DiMUvyaVfZplYhtCP5EahvesTJwZDgjPyKzT0c2o275ctTUNs/822xu0z89HbuH1XW5+uMQzO5YQETiATmQAu3NTMuVbVNKuRuuUtMhveHnpfMWyKokoB0w0pr35sUDdWr5Q9fOXgf9iigkRaIDJtATMCwLd+Hb8riOdMHdmajvdYW4okQ6jE90GcGf14JtEURYfANyWXPucOqo2UgllxmR5aVgis9TFgG1Zfsh4qwde4/qjhKdgdU/qtdIn6rRa9TMbu2MdqNlOsM++p2gUCwqeFDjzjOdZNENavm76AapZ+tTU1QuSdbCdxN1W0Y5uigGbqMKLXPTwpOtpbw==
Received: from PS1PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:300:75::29) by SI6PR04MB7871.apcprd04.prod.outlook.com
 (2603:1096:4:247::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.9; Tue, 23 Jul
 2024 09:24:38 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:300:75:cafe::cd) by PS1PR01CA0017.outlook.office365.com
 (2603:1096:300:75::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Tue, 23 Jul 2024 09:24:38 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.7784.11 via Frontend Transport; Tue, 23 Jul 2024 09:24:38
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
Subject: [PATCH v11 22/27] ARM: dts: aspeed: yosemite4: Revise i2c duty-cycle
Date: Tue, 23 Jul 2024 17:23:03 +0800
Message-Id: <20240723092310.3565410-23-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240723092310.3565410-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240723092310.3565410-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|SI6PR04MB7871:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e8ced7fa-2a0a-49f5-c9e9-08dcaaf94659
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?odWHZuyG1pKtMKkSz0H3SeFg9FBptFZ09zklsQYIS5kovE6KI/AYgRqxmCGf?=
 =?us-ascii?Q?MEOMaSgvt09A3Tymc56/EBTE3kcvv/G6tGUJJ1dpcIuBK1+OXWUVGfjkfWaF?=
 =?us-ascii?Q?90lRLhgG8a77ZxL/2BmlrEml+/+2HarrV8HxoIM+s2pX2Adl1GMrYLg2HkIM?=
 =?us-ascii?Q?uYX+KfWZXLM2vfZSR+C6Lc2uj2zyKow/TLQzo5+13uKPNaau+IkKd1AQjmz/?=
 =?us-ascii?Q?5EPQneOrGjpZFVDI9EJPl7BZckviJuEipmPYNuDUcGmMQnP18SRaSR524wUe?=
 =?us-ascii?Q?MOJYhO899yhC3/JCu0DtOnfPw4b4NmngbMnfSVjH6HewaeeVoUDwUynyh09G?=
 =?us-ascii?Q?znXQKVIFMXWgbRHWU+ASUqwO1If4RY6rq7bc5sAor4ILcqmKcF+OXNYUiHti?=
 =?us-ascii?Q?qsZEzzbgHIdkZusRsH4pPDRdvdT4cYO2RC5vEmrOosXtCNl1kjmpX5jowNt6?=
 =?us-ascii?Q?6et5Iz9X3vjRxnlQTEa0C9b8OFfctIB5Br3fNPAaE9h65JcY8m0luKPIz+E3?=
 =?us-ascii?Q?WccwRnvJNjhg1zKYDwcoGxy4WWwgwcC/APm74kq659QRiLsHYo2vh8qUkhXV?=
 =?us-ascii?Q?F+Gi2zybfwzrRLt5X8ckKAK6kUQ0Zaid58M7dstVWZ1oZmLM7Sh3WKRUQ1Da?=
 =?us-ascii?Q?NZRKWI9luGDjkvCM14BNKPIWJxK/wGiL+IO3fHAW+M9AKAK2Pr0FQTRIgMK9?=
 =?us-ascii?Q?YjoPDIkI0hDRWVgVyeV4D0bOXYjFfu8d1Oee+z/x4Ji7RV8M3DBZEoX5wYT5?=
 =?us-ascii?Q?SQaX/+kZT5TmY4to0FWWgSv3QGUyimcbri0TMfNfPavYjZ7ekS6LrKIkKfG7?=
 =?us-ascii?Q?3XuIAo1Aaa2LvGhED3U0UW7pssqEQYnLBr5lnj+DWe4ZSZhFGSpH0a/9BlqG?=
 =?us-ascii?Q?60wGUHZYdNkW/RavMsKmIs0aBhaqida0twlB8+xqSoUXOKbyixsBBJPGmCNm?=
 =?us-ascii?Q?jaRN0FyLxPIruprPT8DbS/FIFSDJ0+xcbA3SpzYmSORKFKrDddgZOp0MwuDr?=
 =?us-ascii?Q?Pbdw59L83Kw7G39eJZHgQ+UlimDB+fPC+tfo13cHK2rdVpQjweoemGsJ0aoD?=
 =?us-ascii?Q?1jUiCkQkcuzCaa+Xo24gq/egZgTSw1hjYplyRqhdujlkIpZdr1c01zzCmhTL?=
 =?us-ascii?Q?V/3+A/Jj7oiv27otNavBbbxBtS3OJyXmDMA3bGmNQoKe0pNod/621mHNM4pm?=
 =?us-ascii?Q?VF4b2Gb3vLcPZ+uC2irKAiW2eXSXaa5oqg8gYSpKNd3btakApo86frmm2bD0?=
 =?us-ascii?Q?7NUv7z4EvlFXoCGH87Y/gMcvqMEFgFAAah0KduvrDpRrXcyiIEy1j81i77Ga?=
 =?us-ascii?Q?xuk1vywtqNJ7zBva6/4Nk/i1lHDGdOvRUFyvqqKLcwMGtxrfinyD4fTJfukv?=
 =?us-ascii?Q?+mibnSzMBNw+MVzNgTpt0+O2cUekN9WbjVXiOtuJu126/HHf/yz8xiqhwhd4?=
 =?us-ascii?Q?ZnA361vucfLYszWxdDX4Gab1w196d6FN?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 09:24:38.1448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ced7fa-2a0a-49f5-c9e9-08dcaaf94659
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR04MB7871

Revise duty cycle SMB11 and SMB16 to high: 40%, low: 60%,
to meet 400kHz-i2c clock low time spec (> 1.3 us) from EE request

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index c2994651e747..c940d23c8a4b 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -761,6 +761,7 @@ eeprom@54 {
 &i2c10 {
 	status = "okay";
 	bus-frequency = <400000>;
+	i2c-clk-high-min-percent = <40>;
 	i2c-mux@74 {
 		compatible = "nxp,pca9544";
 		i2c-mux-idle-disconnect;
@@ -1314,6 +1315,7 @@ &i2c15 {
 	mctp-controller;
 	multi-master;
 	bus-frequency = <400000>;
+	i2c-clk-high-min-percent = <40>;
 
 	mctp@10 {
 		compatible = "mctp-i2c-controller";
-- 
2.25.1


