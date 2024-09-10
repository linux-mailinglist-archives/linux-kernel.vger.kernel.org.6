Return-Path: <linux-kernel+bounces-322692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7FD972C63
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E77D31F25DAD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CB9186E21;
	Tue, 10 Sep 2024 08:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="TeykFZUH"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2052.outbound.protection.outlook.com [40.107.215.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8074514A4C3;
	Tue, 10 Sep 2024 08:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725957680; cv=fail; b=jOdgCAdsHVTbMP17zC2+xHZvy7ehZ83I3W68Cb7DHSxz+/rL2dbqcipkRAb3Q6Up012hiO1Ea+OsB3i/zQy2PySC2zrklWaZ7Bv+s+bjoZtx6h4/mR9hjOLCyZ/3I4zse9lS105TFmNPfMrtvNHwgpLdleq8vssqbo4zyAkx1nY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725957680; c=relaxed/simple;
	bh=GCm9PrtosBiGPC8B3WGTcnyeJ+2oRvFD9J9NpUbVMWE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=mN6ZiTApR3PSOyAKQCKTT5CT6Mmx0DNFIPubweFunV4tKskCA2v21ARG1715oHUZ4QPKIyg6u4qTfwxioAy8o0GkIkk6tpSF08Zo+zfJKl8ib9m00a2IFkRtQBfUHd4/UF5XdgQLutxtRZP69M1bRiqxAE55Yknd8v2LE6R7VS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=TeykFZUH; arc=fail smtp.client-ip=40.107.215.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hd8jaIHX7/6oretVxZKt4K3+TJ/1koqEm62gDiD4iGybSUw/NbNVvG4+9Douffav1mfv2acRrAOxocNN9QXTi5EiS+pJTsXkguiWeAgeoVGq6VZFxbwSc0pES/9SWfTrEbpNYJ7/tvy3suaEkVAYlxq7XPO+kqH6UIvZo96Epq1notL1dSAinSkWvl6HE1fTmr1dWsI8bOVOTK0+JKtmHuVuWNJU85XwDHAUFoMylCC4LRh+JRHf7Q1zNNMSuOY59x0xliOB0QfKhRLpe8DKjo+pqGrq6lHsFhCGhm624Yjvg1oi8B2bkMqOC4iQ0KUKGE4Hmv7yADRfEYz56FKSsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZ2MMSRPMIp7S0T5v6dauvcCf9kw2fsivDjeJnxpNI4=;
 b=uSFNzE/+U8ZjVuooX+DLhDRc3rHu46jzosL6WmdGZ/pf3GzKMXsNjYLfMbYCFQFHsBC9opxgCwSvrnq55j/0QurG4Gal7aOp95nU6W7rAVxAQZttrxcCY+UhGMGAI3h/B8v4h7ChLPhLEQno3b/OUEF1/m86fuWsVTTuYpP75X/TcQlL5HxdphGDql2vKLS9i8sA4DO0sclAw8VJ9SR9GbmL57fgbl/zrjp5Ke3lU5FLEGjGzQpPA+QvV9jD9A/864zVFySjVia0GcTP1Sy7vl1lIMFf+NuZoznBor6zdaQgZTughm9Mc67TZsAm9MVAgr/fnN8mFcfThlL01JwSVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZ2MMSRPMIp7S0T5v6dauvcCf9kw2fsivDjeJnxpNI4=;
 b=TeykFZUHe4X8vHQCNynSwxYZVNRUZcAeiF1OR60mjK8udPYdszrSzB4ILsAbWgcuvFufZtJjz+fKxd09JyCOsiQv+KpmcbuJMkd+Wmvw8X70psfs483qvBzxTtZCxcaoHIL8ofvhG2OGkPIoG+skpu4mFaKULc6/tlCcs8UOTJ64BdI+L5HeFMnKE1jOpRvSnorVuHoSjtvP+4CYyTjLhSOp994IpFaZ9M8VuUdHq3P+dTVrOKh6TECdKuuAihAXNIY484nN0Wt5sMUovQZxK4zlgrWVoUWv0k2/tHy8tzIJLCrhA7Y+UwhYydABtrJrV6w2RFjSfqiPO+voGyudFw==
Received: from PU1PR01CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:803:15::22) by TYUPR04MB6763.apcprd04.prod.outlook.com
 (2603:1096:400:350::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 08:41:12 +0000
Received: from HK3PEPF0000021F.apcprd03.prod.outlook.com
 (2603:1096:803:15:cafe::33) by PU1PR01CA0010.outlook.office365.com
 (2603:1096:803:15::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Tue, 10 Sep 2024 08:41:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021F.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server id 15.20.7918.13 via Frontend Transport; Tue, 10 Sep 2024 08:41:11
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
Subject: [PATCH v1] ARM: dts: aspeed: yosemite4: Change eeprom for Medusa Board
Date: Tue, 10 Sep 2024 16:41:09 +0800
Message-Id: <20240910084109.3585923-1-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021F:EE_|TYUPR04MB6763:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 66952d2c-12a6-44b2-0c0f-08dcd17452c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bz8ix8r0ELABTMVtHC5ZRVv8RX/weueCHfwawWupsjcmZI8IoJoWlrcWUD0P?=
 =?us-ascii?Q?qzNhPAOgpSFCjf3qJNN/tUht1vS/IBkFYMjYqL7EVnm3c3eaJspj4d2z2WZh?=
 =?us-ascii?Q?MAcWqkNpsnHQ6t8AbS6sJ8y3mJ7KhCQcAtvbExYTS2pB2iWcUhKlvfVQSBt4?=
 =?us-ascii?Q?GiOgZA1LBb1AszfG6W6IswlYbFp2xpi1rbJIpzO2smkQz+z5Tg560zXtfghY?=
 =?us-ascii?Q?ld+NG4HT9jiCY73c5jCoZ7NfXEGL6B8dAvAKUwzBuDhsySbQiJ3vwIZQWxgB?=
 =?us-ascii?Q?fGZSmSsbYC62Ss0c16tQ9XSx+5lb9AjEVKydui9zdXqx0VnkMMdBmyTP3zuG?=
 =?us-ascii?Q?aXpnlRrqYYFUUvk9Bit0LAwI7kErk8eLG5CVcDPMQ/B44xbkd83l3upObfFm?=
 =?us-ascii?Q?2kLD1FccE3tTWMF5+d8/Q190TlzZ5vovSXRcWPVSpkHoubyyE07fRp5FNidH?=
 =?us-ascii?Q?jiuxglQAgEPcFTkdwCVoJpVfBDB9GooSrdBuxHl63QifsjPhTLQ0PaVZhIuF?=
 =?us-ascii?Q?4+jSKcQuD1LE7oc9oDb/XnyjFoO3VsHnFDtX+qPKi/mq6Ku9nwaQJCZFyUV1?=
 =?us-ascii?Q?WzZYUcIm5VEnp0W+HkjtQMV7WhtqYNlp6NH62i4yRyBJR9Tr8Qy9bIlDOHTL?=
 =?us-ascii?Q?n6l3NyA/IFjGbN6oGaLI06enYsQkfEHXVa+w8qAOSCaTumNt9DyAhJHdmcnk?=
 =?us-ascii?Q?c5zQIWwONCoZhLZuEQ90QtY/OXH0a7DG6Z5qy714UuVgGidLNaPfn7piRrZ8?=
 =?us-ascii?Q?tG34aewVfbJBV2CKXwth8nzww8d60NYO2UR4w06Qpx9wyBEQ4H/N5so6BbjQ?=
 =?us-ascii?Q?v+YRzsUbG+mD8RSsVj7E01mgP8W6JQsEVYa4oAVcalNeP4E2Sxx5aTE9QHly?=
 =?us-ascii?Q?1z9FyN1q46JE8I0a6tRpHN6NG319RUrvJSkgRIRRZo3JgF8og5D9ROAZza3M?=
 =?us-ascii?Q?yV87u6/vayg8bykaXnPIrX14axbSDe4Ao003Rgrj/KahcHyy08Yd+EmvhjFS?=
 =?us-ascii?Q?Qou3PlefIfx89cWhQVW8NL3CHrVeoff37jJcMTG9FKrf/SbYoJMc+evMR9jB?=
 =?us-ascii?Q?OvwZtJGN/MxlAf3WmCCjGtbcSaLlPksWtgNZrpYY+Og+Q2WmxJwSJTPNrC2m?=
 =?us-ascii?Q?b6jm4B3HyxBAhGPGZWJpAge3TgYr+XLDkbdyNfTRhaM/VJ456H3HrqcH6AYK?=
 =?us-ascii?Q?5ptqQ4Mnux5PP4ID6dt1gOWNK3Ku5RyMqfV2WZViwMJvyaYgYFZenP0vnN1h?=
 =?us-ascii?Q?roAYKpIx3gWSvZ+VvGqDkcqk4HoPfM0VFzQxKKtRySh5r6o3IGZOSXPtVnTi?=
 =?us-ascii?Q?sGa8wmLeV6a+YJZWWCx6qy8wsrMMGwxk+1VLXi932umLLt/6NYyIqguYcnVq?=
 =?us-ascii?Q?r5UGSM/rv1Btl1ifqs+O7ULPZkdh3e3cOCZ2605JOGRwdQEX3i2RImWfXxYU?=
 =?us-ascii?Q?rQ+iKDstRNbGytsjBhCtzOPMsatz4Uwp?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 08:41:11.2480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66952d2c-12a6-44b2-0c0f-08dcd17452c5
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021F.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR04MB6763

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Change eeprom on Medusa Board to AT24C128 according to hardware change.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 98477792aa00..398ffca58135 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -342,7 +342,7 @@ temperature-sensor@4b {
 	};
 
 	eeprom@54 {
-		compatible = "atmel,24c256";
+		compatible = "atmel,24c128";
 		reg = <0x54>;
 	};
 };
-- 
2.25.1


