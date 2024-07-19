Return-Path: <linux-kernel+bounces-256979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AA393737E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 08:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0524C1C2200A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 06:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005C2433A4;
	Fri, 19 Jul 2024 05:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="iEtgAlU9"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010046.outbound.protection.outlook.com [52.101.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837FC43144;
	Fri, 19 Jul 2024 05:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721368778; cv=fail; b=G3P2czrz5byAauInM88g9VqMi35EMNTnVwMD7//rsYulUx+h1JuV2Gi8uu6sOQl69sPDCW0AhZVs2WFDxFbtFMG9w0M8rtTLOT09IhTf2b1E7AZRDi6EbinQzZf9HjYbvqsIpe/AAtCF1Pf5a1ez/kUu0nlm6x3JO6H7Fa/NcNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721368778; c=relaxed/simple;
	bh=v8A+lpCk2uYYWBD3hEpdnkWDTM2NUZHCqXbrsIQNIGo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M1Rl1lBma6D6JR9g+d21v9xbwfZie+PQVYkMFJ0i5IJRt0nOeMllGnk3T9d2Ng0RgaPkHcs0zRcAbKrM/0IPTpEKEdan+dLCae39Q4qvQsgM5/IwKZip9jJBFDSpxYHDUleMIHk/gfPLybYtgfY6QxX1spH3EvjKDu/r6Uuqbu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=iEtgAlU9; arc=fail smtp.client-ip=52.101.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aPUWFlXt/ujhd0yw974DYC4yB5woQsVO27W6qDbx/eesd6xhQYj/KFwgRy41lQJ3d22uJFwVz4XwLaLrXnFxFvoPodL9buQgNovB0um4OCZ6E1lFSuN7En5FSb5FdbFjGuaSeJTquRNl27f9YN7/FYjD1Ge3xXRTZdtEBNgT12UKoQ+7JXH5qwugJrercEpOvnAJmdPiXtUmXvaUfVbWfdlpy+1ljRdFzd6z5mXbEcS8KOk9WWCswHWcxdv5wIiXsRe7sDEMHGah3riTEvoTteNeCqKYzT8G3TlLX1AhK+ZD42R9we4tt5QFd1r1CwRC7XABHeKvXuiYe+ukeFk5JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+DlfI1otun1CAydzoG/8ZXnTLi77JYQ8A3Djz4rKnY=;
 b=ci2oYbAZrUG/4somhujU0iVNG/QINd0Yf6ZXX7/twfqazLHxWrmUWc7kX1/7rsJyzKpQcyM9cvNMpklgbsafWN+p7OH6Wy9vLJ6RYp/GmjGhkFTj4mp9vwO/d3gqCpA5bZaVyTZG3M23glubIPRJCL39iN98fiDJzuzXmWmmUHDeiReH0rLatH4xqHlZGkYTI6EYePaL3U+Zkz4dedlimVUhBo2aozh27Je/HS7dWiE1fbjHd2oT9vjzTi3at1ITrpdwSQHzgnx8LdCAur5vZoRsRtOlk6nkLXogYCY+geUwkiEvRHevrW5vcvdqZQ49FvgPnUbtBpblYmdTkjgspw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+DlfI1otun1CAydzoG/8ZXnTLi77JYQ8A3Djz4rKnY=;
 b=iEtgAlU9h+HHwDAbr8dRAnuNNznM8xERA1cy0CXAbrRMt3qWcjziSsjGA6DMCT43aXJlNpPHi2zIc74FDYkinM2rq2l3GR4cHbTrp8TO1STC8yyWGNaJCkrObz6HO4djuMkWuto6Q92K7RyBKyL8dp8GI7kH3DCcvnOKXzcwb0o07dmWLSO9RuynBcSPjbRzVPDsRpaPLX4MXLG7NLoDQEoGtDwlR0pGeX/PEt4kyjYQrRuUugyNPYjhFsdG780zugSNYqr9UA2SVFnyHyt5mU6zvO6wCrvvZafd+Bujjy62u/VFzM8lMUXWHArbc3SAA7j8wC9TTyZ1ZoCSexasog==
Received: from KL1PR0401CA0020.apcprd04.prod.outlook.com (2603:1096:820:e::7)
 by KL1PR04MB8119.apcprd04.prod.outlook.com (2603:1096:820:147::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Fri, 19 Jul
 2024 05:59:32 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:820:e:cafe::94) by KL1PR0401CA0020.outlook.office365.com
 (2603:1096:820:e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Fri, 19 Jul 2024 05:59:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.7784.11 via Frontend Transport; Fri, 19 Jul 2024 05:59:32
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
Subject: [PATCH v10 04/27] ARM: dts: aspeed: yosemite4: Enable watchdog2
Date: Fri, 19 Jul 2024 13:58:33 +0800
Message-Id: <20240719055859.4166887-5-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240719055859.4166887-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240719055859.4166887-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|KL1PR04MB8119:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8141994a-07bb-483f-9033-08dca7b7f5b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|34020700016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YoaVjwSadrE1dpD9lpDBUa9WvoFVcGrNSfr41kyj2jET+y+89dhSGzxM1+gs?=
 =?us-ascii?Q?4n+UxlblI7RbzSJGrP9Yjy3CXCdqic7SxSBtyisrh9rn8FD+o4vef3TQuKfd?=
 =?us-ascii?Q?oATkrfKDvUTLDHMF+NtBT7xrx1CMeRLAKQrdsF32/HIXE6oYxSoivEtJXCpp?=
 =?us-ascii?Q?4YI3p+ta0HUz69cNkr8kLX2M9MAowM3dsQcSJj4IaRoCBly9IWVgYpWd5vhN?=
 =?us-ascii?Q?MqMOwUxoGaOY/PbumpfNTZOAy6l0ARPE1Rwyx788yqw3A8SR47yg/NWHvnMc?=
 =?us-ascii?Q?Wv99Uky/32mlS/eby4FEE6EcCBo7fSEKGBnyp6u8CzOxmsgX1WGY1kAE3Bcc?=
 =?us-ascii?Q?Jq/h5LMbr3hBKKHvJiIJfo7oOb+gElgWy/tFvgA8yQvfsPYjsY/dc2YOTPbv?=
 =?us-ascii?Q?/pxmMp/51bqj1e2SvrMMX/C1mS2Xbh9AIG37NkNF8l7VYKL9XoR1PrPcEDEy?=
 =?us-ascii?Q?noEPz0GtGIDpz0z6QXUW4Zy3dFVGqUjEdG7CfkYc/8cp4ar8MlHtd2ImI3g3?=
 =?us-ascii?Q?I+V+eiaYo9cgEWSEqLXziXZ81hxLkcfK3+f5UKewxT6oM6bwkz3gHKvHYBhP?=
 =?us-ascii?Q?T+acPmTP//LMZ4G2XMKlUr4fVSRoLzLYqu3bfAlGR6qCJFcQl6cHLAbgCpA2?=
 =?us-ascii?Q?zbgBdN22HFWhrCbG3X9UoEaIXdgQEsBMW2J6/Ci1ihvxOqXE0HAONxJBrMmO?=
 =?us-ascii?Q?rbXNWmO6KL4W6QGVAEpJrBMchJyQQfoTp0D+1NNqscDUGbAIqlVXkX0d/1oe?=
 =?us-ascii?Q?gqown5UTEU5mHyqRwQTqd3UKb0iC5vcqKBBgYInel32jXGUOkB7EIRj0Kqjj?=
 =?us-ascii?Q?Q4uJdsmyfZtoi0X7Axn+AR2shkWyQFLPAL9R/crWSniaXaVHqFxgYqob5Rui?=
 =?us-ascii?Q?zyIyR63vR0/NfRXYFzJUUCgdB07dytcWjHoLNlPBiojqnVqBH/sRDrAjJ/Tt?=
 =?us-ascii?Q?Qlaal8FOUSMPAf2qDFbcv8u/D2E2eMGf7IonaZLH3HjJ/3Jkl3ro1Uzy3ZcX?=
 =?us-ascii?Q?YkOpn+KtTSUEO21qPajBvlH+MLKWrCVl+baJNr2AoLPN87xD2NODlZ0kqGf2?=
 =?us-ascii?Q?yL0OFpS8ibqbDR9BnnS/P/7zZP0uNUSVpkvUqfq9AOcjzKr9dKhsyZJn9ipH?=
 =?us-ascii?Q?sQvSnJPYRHVXMlyAlCM2NqFD6SIe2+dqC+lB8V4/UVun7xk7I4NEBw+iQV2y?=
 =?us-ascii?Q?whK/Mmo9g0kSD+ODO/YTu8NX3j5oAQ4+BF+XTtdv1omESlqr73dXycgLq/2q?=
 =?us-ascii?Q?QZnqM0huUZhx7Yy4RbxkbPdZ6VMUjRsMJFW2dQLULr2jID/s3BFYrgIX9GdN?=
 =?us-ascii?Q?XCsqTCUbY9UDDa4LrotLMLpE5VarFgc6rQ5q5B0jFpIoJ3dRFgEFHMn6NOPb?=
 =?us-ascii?Q?105dYgF5KJTBWDrRd4wmFrDyzTJAdnKtIQXbvYSMlHNX5JAXRSNHFKoaUWFt?=
 =?us-ascii?Q?DDpPOsWMwDeRQps1BovgGU5lc5prNdI8?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(34020700016);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 05:59:32.0009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8141994a-07bb-483f-9033-08dca7b7f5b8
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB8119

enable watchdog2 setting

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index effc2af636a4..b0643e8aefee 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -120,6 +120,13 @@ &wdt1 {
 	aspeed,ext-pulse-duration = <256>;
 };
 
+&wdt2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdtrst2_default>;
+	aspeed,reset-type = "system";
+};
+
 &mac2 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.25.1


