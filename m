Return-Path: <linux-kernel+bounces-187245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3583A8CCEFE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE7B31F22899
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D6F14A62D;
	Thu, 23 May 2024 09:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="ZAFjKShc"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2057.outbound.protection.outlook.com [40.107.215.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7565E14A4F4;
	Thu, 23 May 2024 09:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716455945; cv=fail; b=VCvvqmqv7c16V4HMiOEMEO3vK+IPO/v3qCq5kOdMx2B5lvT/jba1xTnszFprysOixMCvR5QRISkqXkOs1lAsqCzmYs7+ft0X1bYBSaZhbZrz3kIiRrSj2ygyRjokoMFtPEAfrwCnVTzzX+2h25blnllXzTOsf/Rua6vBztLXi8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716455945; c=relaxed/simple;
	bh=gOTtY0AKzJ5lAs89ZBm4Azt5lpi8hiQG+0fSEaBa1jA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MGRZQpPoYli9VojqBfaZpT62Grb9WhA+SKzsi92e4r0h/5JZ5FBHdFPMKwe4sbF7dsa1YPyejcKL/V1lZRGMO4x7U8iG9+Rwg9lTeex+6dTmKT2y3dHL0FtVjjoigkGoM/UPlx7gcqnGjxyLX7GAyEz9bHHPS+8xwWassc41Z80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=ZAFjKShc; arc=fail smtp.client-ip=40.107.215.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7jMhcRxBBl5jP9red3K/6nACEba3VLbyt13tPBLHc3/0CYJeneAwFX8QwrYV8EBzZOssAv1Z4IS8u9ZQzlThEROpXm989+9z2HAxJHAeNNV9d60gawpzPgJYe8VAIDKCsHNevyRYOCWN3js6blIHo0w5c9BjkUrodB8WOmGDjiBLlck8Wzx3XC7cJKuHj4ZnzN3ZRIdThm44OlRbQuFm9dlwn9i1zPD1utYeVWvUp10XzsEQ3iSiOKcdOFg2d+jq4rLdtceBDRFpdiMNdbw8zENFwOjG5OLksuGFgZAc8UrKluCdYeb5MKZVXbbzYDyxd2LLNg6SgW94296P6V7AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vQQ3x+PmWObjM/+/9aZu+RrnQuFpeCkTBq+qesncHc=;
 b=Esprz2xTj5dQniTvz7n7iv/syfxyBdjzwKsQP95yWtsEmysfoS1inI85FKqiKqMzdpCFzcTtooW3rgTW0EP4A87WiRx2Qq1cABc0L7q2dHUFgPzebTCDOI1IGdlSeZlMVOQY+XnBEktCR3/j+WCT38wY/Q9lHHUh7cbOskXlI9foLN7J8NYrRU2aQlGnijvoVNevCsHhaJy4U87H6BoQcNgw9/tJNO2sey3xGTn76cJwZtI9iRtS8fhaCZQuYbEqwxwqWJvL7inOiJ+3Ps0L5xK8SWuyj5IAbezHMHTaIt43WlZ7WAMNsidvl3jTxokH8rUy+Gok7nuewPiEl038tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vQQ3x+PmWObjM/+/9aZu+RrnQuFpeCkTBq+qesncHc=;
 b=ZAFjKShcWROEvYTLMG/LVtFh1vCW2+illqCdTxAvo9bQqFrVMw4fkV7dVabxFExBoCz/HhxBbxA3bgclK+C0uZ8c7IMFOIFZt8ufYyVPdegvQOyEbS1X28tS1T/KYegmCT2fKmW+2rontYdw1C9gzf+bfVnuAJldaCjf3nHPsITyJ9X2xax93f9el772xj3+MvNQG8qUnPuy15vX//7mjqijZJqWogOHiOWRGt1aVEEtw+6LrNvtxvNdi9S1cFFzaEan5gqk56ZLgbfqDoBufLf5UGP2NSp4ygDwrveVMwSkv7u8TLIrgv893RPaVhFuLVFBTqPJMcimk9nmFCXQag==
Received: from PS2PR03CA0021.apcprd03.prod.outlook.com (2603:1096:300:5b::33)
 by JH0PR04MB7479.apcprd04.prod.outlook.com (2603:1096:990:6e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Thu, 23 May
 2024 09:18:59 +0000
Received: from HK3PEPF0000021E.apcprd03.prod.outlook.com
 (2603:1096:300:5b:cafe::bb) by PS2PR03CA0021.outlook.office365.com
 (2603:1096:300:5b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19 via Frontend
 Transport; Thu, 23 May 2024 09:18:58 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021E.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server id 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 09:18:58
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
Subject: [PATCH v8 13/23] ARM: dts: aspeed: yosemite4: Revise adc128d818 adc mode for yosemite4 schematic change
Date: Thu, 23 May 2024 17:18:00 +0800
Message-Id: <20240523091812.2032933-14-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021E:EE_|JH0PR04MB7479:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5cf6aea5-effc-4a30-3f57-08dc7b0960c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|36860700004|82310400017|7416005|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zHl577SSN/w7+Cp/nA9YiN+pqMcYmPXK5yh3lIVhcjYgM9RGnhoTRa9fL9Y/?=
 =?us-ascii?Q?sQSieKVAqljHVl241Z4MUqv0IEHpXahx3lHE1TOwM7RmjCT7uN8LyvrbgjmA?=
 =?us-ascii?Q?WZgc+KGJgRV5HsCAicVs6Acc/io3s6ApK+QlVIHPApFIEPrLXbwc/Lr5MEWC?=
 =?us-ascii?Q?oHLIEFDD8ZB7mWb8qPYvso5wNNYU1RTNWOdxQPjkrXhHpdeOvo+BUANrH2hE?=
 =?us-ascii?Q?D0ptCojMzCTPl6oYitcKNsPgv15mRgu+H2tHLA+xNY2lNNFgwnfYy6qszUbq?=
 =?us-ascii?Q?PXEOG4hIWXjmGUOnpEAUgzpIJDuV9nIgzg7BjxX5iNQB43MjPlgLbS3CdFpt?=
 =?us-ascii?Q?N2y9SH7PzwuN+X3LjvH3wmAgJhokn4xZiFT9Wgil+IUQxlIzbzvro/C3kl3E?=
 =?us-ascii?Q?MizOkMyiE/Lxkx374KoXY/xZ2TXa6t3s8Hj61hKrSaGa5rRW6UBcEs8/dD8S?=
 =?us-ascii?Q?ETEtIWqOK3mtS+l95wZZzYfvCQoNtRXOj+S2hNNMXw4nJtyHFE3NzWNEvsY1?=
 =?us-ascii?Q?1Pxf0y32Ex+HYPcZfjGeXLb5B7Lj9wahydbejYQRa9XsC6X5wBMZBpVPMqay?=
 =?us-ascii?Q?uKDO3CZmY0ymK0QWi7k0txv4pexWbuwo3ccXySal5i/ZaS0tlfhTdAhl9Fln?=
 =?us-ascii?Q?ZMT9w7mCvLvqKtsRoKja1dIjRtUSeAaBzuaXwtDGATeFG1JS7TxkhrZbW7ve?=
 =?us-ascii?Q?1DgZ5MEyJt4+8QP+mHA8J3Yt4nzD6f6/KWBuXSY9d7UFsGH0CbZZSmNYkve3?=
 =?us-ascii?Q?rXAcBSgB+I8rqIRvsbnbkZIux/uiMJhxj7U0FS1fY7iC8iYGXhoJafmbuTnv?=
 =?us-ascii?Q?Ee/xhVHUL2CRt8jkuVQyKiAurbaagFpKTcf/Uv93f2kieaoPl8+maUIfRAWf?=
 =?us-ascii?Q?4KVe/ITBbz+m0+V6TKd9HRhXT/gGe5o02HJGikBeE/eh6Q6B40rRZzcxvZvL?=
 =?us-ascii?Q?8oLSxBpeMbHW1maTWuWX7hQjBhX6OcuoeH3SRpcgTX/76ETne0NkzfaaAACu?=
 =?us-ascii?Q?zkD4aJKWe9GE7gqcOX95aLAe0tTIoWh/5ND2J8vVK6frH7vhnQFd0G3Ot3C8?=
 =?us-ascii?Q?L6rIt1UIlbBNd+tL6gpdtncF7GHzZ1YrwPOW3k8BhJXQpXpJh/HrGMDS+zoA?=
 =?us-ascii?Q?Utnzd9syrS/fit4hwu1SqV8O93facznWzjs9E+YL1cWmzyicGdNEH9K0pZfx?=
 =?us-ascii?Q?Fx4mZsVHZWEZN5qff+UJRz7vehtBF7Ut8DMfkqbm+twroxMLf9893ckvx3JQ?=
 =?us-ascii?Q?qljkOFZHvsWUImvucj3rP/+d2zfnb5WT3iv62SzW1w3RkGLQZi0AUbkbz6j4?=
 =?us-ascii?Q?w3oo/1q18XEwvzznHkq+xWidaRqMw/Dg1NEkBj/xQ+d1yYz98kc+HtEKyplw?=
 =?us-ascii?Q?uJS06uk7AmIEvQZHuMzV2IzAR1Xv?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400017)(7416005)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 09:18:58.6107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf6aea5-effc-4a30-3f57-08dc7b0960c6
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021E.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB7479

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


