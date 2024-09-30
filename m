Return-Path: <linux-kernel+bounces-343447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 164AC989B07
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 390731C21207
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989FC17A924;
	Mon, 30 Sep 2024 07:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="EF1OQHw3"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2059.outbound.protection.outlook.com [40.107.215.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569DF176FA4;
	Mon, 30 Sep 2024 07:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727679933; cv=fail; b=fmh/xHOnTtAcVktMl3wJHkLxrugf7uOrisHmcOYvi9c5LAPF4LFis37kFxgC/SXmKTszuVRevx/jcVfpN3MLpVppgi42Ff+SR72UTB9Rcc4TnDuRVG2wcfN5ImesmSqbEgOu9LYNlXCvfXkz5qp55HhP7OgXFMbzRWsop74mbuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727679933; c=relaxed/simple;
	bh=T1wuPJEuLp17k4iwsbs8wFaEos5Ikp7W37+8RoGCtcA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ORlUifIH8wRLVfoOQrZJAqWUAqFOaq/5xpD/xkIIW/KtbCTnr4ZrZBUZlt3T8X1d3DkXE0GBwRt1OBBqLxaw9BreNhxrXbqxGxUu1m8eOLMXrAmzFFtdit07DuLb0ScGLZ4ejhkMntnjb9fbz/VMPd7VZPdHGtv+HRQHEvT3nzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=EF1OQHw3; arc=fail smtp.client-ip=40.107.215.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BDs3lD3LVGd2W0WdxawerSa3FHkPYWiqsY/IEpN0wPRpN5k3+/Ug/b8CcLG9ulmLxJ6d/d/8WfNO2lzTQD5MI2RZejK11MX+/vb4x/0zoR5Q89/ugosz0U6oj2hNvEFmXxNTdF5tuKF04+sxCoH3N21YBR76aFqxnBpegSim3ROK+6NhL5fOXg/2PqXJ6rlWj1+IGVoqA0G/LzQZvKlR4nvSi6exBZfS1wbyOfgWKM1gbBWlY++WoNEtGeMsXEXKxtYLugmM2w2Up2IihzHKTsI371oKLiAllPJrqb/23E4jX7dKEXqmIcqmri1ODwrZs7557SE7DH8zz568zpVu4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rc5wNk6fN5oFtBkyRPurMpzUpnZEhq6lKad6bKMUjIc=;
 b=CAMwd2nnVLXfUauKjXf2nXqP20BLJk9XHwppYl9SBb267yZ/+IdOZChDBk9Uuej1Wf7Oef1aDGfxUhKiguTbl51GPpcz1kafC/iea8vPnVx3O7PnoogmgRBl6+k3kjIcCGgXUet+3R2YVaQFTpY/nskAgu1hdITEtWY8JUkNDowFbzM0b85WUgCZk1pV4WuKb8NyQ2TI5ybS7ATCrp+lKGrpBdzXmuuHY2A0WCavNKraqc0AepbdbHITUR4YC+FfHV8/pyG0z8iV0QNZ1QOFlQ6y+aZZLQ8MAjN4RHhUmxLAzx29AVqFTHdxIX+OrD59vO8PBb66SWo9KoV24tVhGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rc5wNk6fN5oFtBkyRPurMpzUpnZEhq6lKad6bKMUjIc=;
 b=EF1OQHw3PQAdZ+Ipgfe6Wcbu0AsRceeOwkruzp0UlMbXppgLnWumtIVii9Iz76w5x5+MKOzo4ig4clcKtHYwu+I3y6uzk2lrUtqKAQN+gHPS7QsteGnCNOusIyaHiyOznUbJlHuuD2DFK9fyW3w9tzv3dYG/ipkWip9I6sv14g9HBJCt0fWzbAz48tBY8CQ2oAE4W+92b8XPCE+0oRiQp3Lwq49AoseS42h2OTDsY1oDELXj5J0qs0UlZj++nMq8qY3HXMmnzWGSsxZcFWMGCviQASFBEdy8U2z/8s3giLLAtRw69HaBAvyhje+5Er3eP6xg4dQXTeY5M6uDLWtipg==
Received: from SI1PR02CA0049.apcprd02.prod.outlook.com (2603:1096:4:1f5::18)
 by TYZPR04MB7577.apcprd04.prod.outlook.com (2603:1096:405:3d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Mon, 30 Sep
 2024 07:05:26 +0000
Received: from SG2PEPF000B66CD.apcprd03.prod.outlook.com
 (2603:1096:4:1f5:cafe::81) by SI1PR02CA0049.outlook.office365.com
 (2603:1096:4:1f5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.34 via Frontend
 Transport; Mon, 30 Sep 2024 07:05:26 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CD.mail.protection.outlook.com (10.167.240.27) with Microsoft
 SMTP Server id 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024
 07:05:25 +0000
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
Subject: [PATCH v1 7/8] ARM: dts: aspeed: yosemite4: Revise adc128d818 adc mode on Fan Boards
Date: Mon, 30 Sep 2024 15:04:58 +0800
Message-Id: <20240930070500.3174431-8-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240930070500.3174431-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240930070500.3174431-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CD:EE_|TYZPR04MB7577:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2f099954-2b56-4799-f325-08dce11e429e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pNQ/1kEEWDBv36Ae3ePGCedFwEHT9lBJPfMLH+D7qMjxw7NUZTSG9WWE5zEQ?=
 =?us-ascii?Q?/05QlL7brisEOclMSrXLq97rdDBqZLzA1p7Bo20xwJR+pErf/7JVzwUmeaUg?=
 =?us-ascii?Q?bMP+/hSWCNaHidZbOdONL/jEKiE3bKzo8C/8WSYwq1nY5Xex0wYaSAzNOev1?=
 =?us-ascii?Q?C2Cp3mSruQCFf58QcTIJ11KpNJFZQtjOw2r22ir2KjofY5fnK5CQHlDYBoSP?=
 =?us-ascii?Q?xEV9XbxEnH+3g3mWHfmypHxwJrNiaCK2jFZeLQiwtuG3Dlmu1lbmiOtnQZsU?=
 =?us-ascii?Q?Yo1pqGnfWcvFw0a+1iOFmZvCoA1cEtoWOFZJa+qC2A28pViq5Jvl/OYRLJI/?=
 =?us-ascii?Q?cJtYpURPvfcnqRjUTKE9zvdJpJJapw6Ivx7l9RibDR+6YDRbmo4L5jpqRh2S?=
 =?us-ascii?Q?xX6NPB7i7rViuumNGizvbZNQs6RlLVUh1eqMQoxNeyTrw57K5VgA/YDwg5aN?=
 =?us-ascii?Q?iCv7czL6n9TZdk/2AmDFQjLytH1E63ieteExuD3huJ+pjf3LLnZF1UuwZOtj?=
 =?us-ascii?Q?HtrACDWReA9RBWg340CMDWkuAZgIrf/19jkYnp2+42iD2AqFoiygLihYjS+d?=
 =?us-ascii?Q?XZ6Xv4fVZPKoFwcNswd3RzhPxSPv1dzd5tSmZc3cA9Hjng+pkokfPZjXp6Iv?=
 =?us-ascii?Q?ooKVgt1ywolrbx5irUOvORZf2BfIHuiEabbe6vX+0sC7yuSMc2XrrjmnSf3i?=
 =?us-ascii?Q?OCwazbw9B9PGi0IzRDAlpgZq+K5nm8SkcSqy+ZYBPh4204rfdBRZY/MSJYD5?=
 =?us-ascii?Q?RlLdgZUDAHrFguF150GnEqmqUUYZGZ5+0BDeNeec2+ifGBUg3Vp7SfcOIVhK?=
 =?us-ascii?Q?+pYKXYGYddm7YEZLQLWi3Ips1z0QCBFuaQmN2D3XF/pHmFiyM5cDNtP72qD5?=
 =?us-ascii?Q?0uzt84FWm+hsto0IrrMBQP81BQC3vpDHPDcPqZoApxq6sUcRGP1nKnNUe0fH?=
 =?us-ascii?Q?N/8ON7xBv75yn2eU0TVyhd9/7k6Bo5cNobrbOq8ZqZbzMzNXLnybq2JDQLLf?=
 =?us-ascii?Q?Y50+erPVmImWWo/X5ChwxgOzwOC25vd4llvPE/crpPeI6TRJFOoByFNYjjff?=
 =?us-ascii?Q?xbE0ODd/3pSgBw4RUVcc/u1R/rnVO8J83LEGwlMH9fqHOF2YjJ7TeHmWUv88?=
 =?us-ascii?Q?Z3yvwHZo+TYiRYeR4bwDP+oCUWSEr0gmkNRGZrX0nmfQhmX1zWqalPHGyPkD?=
 =?us-ascii?Q?J1MnKhNynxN2mptS2ab+tKHDwRhtydkCM6fC5vdrjGlAjfING1/yAIy2Aztr?=
 =?us-ascii?Q?vh7Mt7ooR9n2hQpDJv5mzO4q11/73WUyitZYBtxEsyKpHkmsQ4c+FFqQo4eq?=
 =?us-ascii?Q?4GkgFof2q2aE/fqHhw0Busc4zjbE3rPxUG+apcm674MGgkJbAnD2x/JajWNo?=
 =?us-ascii?Q?DNtVRwxQgp2zNRHu5yPjP0ceVWkJihr7iFJUUaGSpBxxqPWnq+yQjlYzrzs8?=
 =?us-ascii?Q?SpdQhutLdn4uAdEjwxqxQuemTKulK9M6?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 07:05:25.5405
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f099954-2b56-4799-f325-08dce11e429e
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CD.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7577

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Revise adc128d818 adc mode on Fan Boards according to schematic.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 6a1dccd23225..e235ff7c7a9b 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1173,7 +1173,7 @@ imux30: i2c@0 {
 			adc@1f {
 				compatible = "ti,adc128d818";
 				reg = <0x1f>;
-				ti,mode = /bits/ 8 <2>;
+				ti,mode = /bits/ 8 <1>;
 			};
 
 			pwm@20{
@@ -1221,7 +1221,7 @@ imux31: i2c@1 {
 			adc@1f {
 				compatible = "ti,adc128d818";
 				reg = <0x1f>;
-				ti,mode = /bits/ 8 <2>;
+				ti,mode = /bits/ 8 <1>;
 			};
 
 			pwm@20{
-- 
2.25.1


