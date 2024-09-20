Return-Path: <linux-kernel+bounces-334137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9897D97D2FF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 10:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCA3D1C20DD4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDAE136982;
	Fri, 20 Sep 2024 08:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="FAX5S2vz"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2050.outbound.protection.outlook.com [40.107.117.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C832B2B9BC;
	Fri, 20 Sep 2024 08:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726822217; cv=fail; b=bN3aZUEa7LtNahYn8mlN7kp5MY6eFsxDfF0QRCvMWP4skDtOdevua6wtkz7gcrZtM5OlosyU3GZ/WN5vD7jGwJgRNhwRw8/uebCHnUFqi3wVmRCGkGzRD5tgiJkT2WURfDrf9JZigf3yWk9I5lW67SxOt2P7WuvO5Kmesq4gs1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726822217; c=relaxed/simple;
	bh=QrSHOVFROpzkuvi/S2R/MZWfqDhQDEnfs/kVQmmIDtk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Wc1ZFaA/QILDIBLHOb0EkwLGQbpazEe0tu7buZU8Bb5yrh6mZ/dwfxnLEBL8bIQXgOyCBJYVm81+BOKDM13XUUrhKcWgTzedHlfxHt7QZXCixqL2VK4TzT3nMLYrorL7RG7sWINJNe/7El0M7LBmd2XWHq8gaajXrsxrhDssfOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=FAX5S2vz; arc=fail smtp.client-ip=40.107.117.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=naK1pldSk6qbI0Xg3T7xJC7qaV9OrWbaZpkM4EWBH3gvEmjOuEMzO368VIzjZTwd7fzQlZZtWq3zx87Ae6oebCRdTBuPVrv2f4wMSb5gEZSMILGOGO6zOGTCvuZ3Y11DlxTAeGQty7+CEdkcqbR26Za+D0VEgPT0v5Kkz77dAHml06/aqSxKgHUKiSVSNQldDSxZGXws4nmbqXmK5Id0n9gqXb7kgVMOq6Rc0qGCkLh5pAcqtDoMgfzcvjEWuyVp3yCsrotgqUIljvuYAiMU4f4HQkPOSkxYcrOZdQJB8kGOpSetw0QN0/EdIeNJcOLrqZ3i7LV0bnMyo+Te0rCnJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHvP5SNNJU64H3j5CiQuYovnkukIg1pumSF1+dfbN/w=;
 b=e22/SC1Nmj+JDW/+nt1b3IGQ2+KnKt3NlBRaOss4AlMyRHBjQMyODQEFkwfCKy9pzpfwGkWuPwOyPlrbo/a00YSrJPoAe6wvVrxlykwoW3nAm100rnPW5CLDC5wWrJsD0QvEMPYsHPjt+supetH9jTN4zYukDynbCxiydEHRhWDtmDVTWRIlyZywzVIVvxlAlKJnjmPm0OcgOQqDEgby+4uu2PoB+JBKMURmrKtlgGyJElvEupD47Dvj2d4Fw+iGUlRD+YPUtCtvq0HW2Taba1I/y6lV6SsDMS2qrZk+WyNP4p8S3eNDqCEb4onkHLO//9PZ+nK1AAuocud+0xV6mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHvP5SNNJU64H3j5CiQuYovnkukIg1pumSF1+dfbN/w=;
 b=FAX5S2vztN72tz3A6KdUdyP4wfbveUOWxYSNjNjQoTYUiPtBFjzXNg0PVxxG771gb4+ahQX6HIUnl0g7WrurXJN1vRlgGXwFvkZbSF/fjsmu5xJtNJbu7NM8PsAUutN4Q/So1LII5MnHzHs8IrneBvULcaahzxBpypJ/IxPyd/WzuLcGXsnd4GN9F31J1gL9Crc8JdueGijMmx/xkjoxGB2GSRAlouXeXP6GiGUPScxS2beyzbs2h2PB18kW/6nS3/MtAqsAMkqG4ckVG/im4WQeewsXsgRUdPAKTT/UzRGLeYt1r++LhODBEI3pLFzrOqxyyNyAMIKHo+T2dbmNPA==
Received: from KL1PR01CA0151.apcprd01.prod.exchangelabs.com
 (2603:1096:820:149::7) by TYUPR04MB6692.apcprd04.prod.outlook.com
 (2603:1096:400:355::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Fri, 20 Sep
 2024 08:50:11 +0000
Received: from HK3PEPF0000021C.apcprd03.prod.outlook.com
 (2603:1096:820:149:cafe::a4) by KL1PR01CA0151.outlook.office365.com
 (2603:1096:820:149::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.29 via Frontend
 Transport; Fri, 20 Sep 2024 08:50:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021C.mail.protection.outlook.com (10.167.8.38) with Microsoft SMTP
 Server id 15.20.7918.13 via Frontend Transport; Fri, 20 Sep 2024 08:50:10
 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>,
	Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] ARM: dts: aspeed: yosemite4: Revise adc128d818 adc mode on Spider Board
Date: Fri, 20 Sep 2024 16:50:07 +0800
Message-Id: <20240920085007.1076174-1-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021C:EE_|TYUPR04MB6692:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 93d091cb-ec8b-48e8-b024-08dcd9513c75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sVmX402X/wPF5gx17Ki1O2agvlEcuIhMZsrLPWVCr94CsGseyE2dib/n5dKD?=
 =?us-ascii?Q?GTx99i1+pXxBx93SaV0BIuasiws5XFI7eTGsJtSidWgeuh/rIIsfFIrJRUvl?=
 =?us-ascii?Q?lWAm4JjH+hevkx0mvAV31RgWP6DfPwfU7IBUeE1FjwH1n2pknv4BPqbjzxH7?=
 =?us-ascii?Q?pqJ6tgne3rshwkFgbUGAIzimTt++qnRKhIBj/Ibu1lLb46QaBlIXSpM7/cOY?=
 =?us-ascii?Q?eNBR4B8n6Se9YZe6zqJq1Dkj3O4SAXa1BDFBs59XYppthO0EmH0296NXnnj7?=
 =?us-ascii?Q?BGYdXAMAS3aKcQxKc40knroAKPuNaA0LwDOzPYV6KL1tYPlM4ZGw0xJ20rjH?=
 =?us-ascii?Q?MWpH629sg2/lSFlF9gMp4EdT2Q1K9Jqe8vWFNO6z5FAi6W0Y8gM/FHXmMYr6?=
 =?us-ascii?Q?TssUPmOFQ9dnnibbRdyS7DREllbyasUyMAHTd2HNmCPiRuEc0as9H1SMjvxp?=
 =?us-ascii?Q?bAfYxu2y3ucB82srZFKACCzQ1vo0ZmkJypsH5W0Cc0Pk5LKbXPDka8lXrV71?=
 =?us-ascii?Q?jOeN1i6Gg/wk/zVN7Ji+LWuTchUVmu23LKb5TWMRs6LmF4at8uxD+fzSMO3O?=
 =?us-ascii?Q?Uj2BXnCzS/ibs4Hsdd0QRL5zsVOP9ckX3mFFraSMESuADZ4pv0BKDyC6eRNB?=
 =?us-ascii?Q?eb38RWcR77R7O1uvL8zSCdq+p/iaNRNc6XQoaYGjzu4RrS+7x4/BkgYFeZic?=
 =?us-ascii?Q?DldcZVDOCfDS8GEoZ23WuPbf4cxtH78JyquluUFz6I4LxIm6LN9fCdh87AFS?=
 =?us-ascii?Q?t9Hiy8frLShSoPfH39NtSLszNfZaJhDYCW4Hk4f1ctlje/Ik4+1k2AEZ03QO?=
 =?us-ascii?Q?3M6xFVYhDjZxPxIQvxbVL/EQqncaawdl50ZydMhD8oTw/o6bntZSif6giJsG?=
 =?us-ascii?Q?rQtrT4jGxWb6n+vEUufH4VofC2ecG220e9UQoqWn2YqY8IEaHQstwLeZTmiy?=
 =?us-ascii?Q?m/4pgRj17C4duN+DDDmWJPu38XRbCVStwInaK7rxNdk/GZiPhcDKEj6oJ61R?=
 =?us-ascii?Q?LIMunaIN7dFfbwOc8vj+0D+kHhvRWJQV/38VweQa6sEBaWLbw6is6xbgH04I?=
 =?us-ascii?Q?gzKk5joV+S04gcIbWMERYK5JXN23CrgqZ3B+6i5d3tU868/IMd3Q2JaoBEX8?=
 =?us-ascii?Q?hoqlUU+xCCmtBYwyDrdWYHcvsYd9Z1VRBjfk2uPBfMBFWElYf50u8mbsbV+E?=
 =?us-ascii?Q?zUTuy8sLYh+djFT0VRc5qTsnXqighg724Pp5f5R8eTdLTuB8tUo86pngW9K6?=
 =?us-ascii?Q?NiuB/qJ51H99Ro5eQflZW9l0LbTtSiOYseOjHy1TApywtUqDBM2RPqtcRm/U?=
 =?us-ascii?Q?/QnJl2gZOVsjy9dMwAmAGa9njrzyCWyQ0ftBmuJoikJEBtz3xiZf/MNi1xFu?=
 =?us-ascii?Q?JMZtEudjSWq0hCQJ0lskqXKf/CfEXfK6pt8YHcRD/96xmV12zECxcDhFuXpm?=
 =?us-ascii?Q?14vfODTPAMwXfJKf1iW9NdRhPbSD4LR7?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 08:50:10.6254
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d091cb-ec8b-48e8-b024-08dcd9513c75
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021C.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR04MB6692

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Revise adc128d818 adc mode on Spider Board according to schematic.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts  | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 98477792aa00..84b7dca88ce8 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -385,19 +385,19 @@ &i2c14 {
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


