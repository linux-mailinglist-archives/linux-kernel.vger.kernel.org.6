Return-Path: <linux-kernel+bounces-295255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 807C0959913
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD3301C2178E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59541FBF33;
	Wed, 21 Aug 2024 09:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="pnTlAT4q"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010014.outbound.protection.outlook.com [52.101.128.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7289F1FB2DE;
	Wed, 21 Aug 2024 09:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724233338; cv=fail; b=hg26piCdD9lKPc0GLIat3ZU+tzXaxn1r/2b5oR+tnVLkxokUaCX/ph8qVt9X85ZPRA9KhinkwOyRZC7dh25kPVkueqyGqU1f3zvGRpPkr6ctawM4NjO4fODuBfqxIpHOcv8nMFafP+8rSU/2lgRFhAQ6rsF9rPy8qCxX6Z7GoIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724233338; c=relaxed/simple;
	bh=yAhriQXECovPY4CY9G/URMvwVnjt/mWrgCqZ0IcJHTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p2P3nq9KbpynpFu+UNgLcfnfHTe3wAk0hnVrF9igItdBmQAVy8GfwfL9oE/iklddPV3OIXXlszQEm7bO13/+fAZoZ+rdn4Z0M1vpdIof4UxlvVcgHnYpHyazbsKCjXxfkNEDFe5Q8XTObIgtmO4k0hZH9/u3qcUjT9HEk+tGZnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=pnTlAT4q; arc=fail smtp.client-ip=52.101.128.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PEsE/V7/nNFJaS7/q6Goj84rwceiTokkbl65MEid8hOnnSlvNHm4j8OsLBu38VZ9tv+DUcjWXApnvhW1N5v0oVvXQ1FBQdAjKsm3EIBhgLXUwUubbRQJaERNKlCZcaGqXRDCeEr+I17FMTQ/AM3oaT0U1FTIxXDuwL7Ps7vn2Jr1RwcjJKpOXbP8VR0uhPt2XzOdyD45+Vwe3uDOhN8dLofg50jKbyxJ8VhSGyzMilJgFzw7n5/o1VbPyy1xe4NLtsjHSdNwcIkrJ9qKy4QHltlEvV+T9Sfs2gNpKODXLL2OiZzzCNpuV3Fb7MzHRi97uBJsBCvh7yS3+tZ/+zgcNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1Mo5JFgxGn5H6HKsVEDEaSyXk72X/JC48fJnaRvMS8=;
 b=ZGNaj5RxaPKZjbSr2HzhDsa2lnGZIV0K87/igEev2B7TVCfSLm9IeH2ulB0T716PGROh9mwL5rqbuCWnxXEbHg2ysLLGkDE+9cmYeFj8Ra6EZGZz9lnoHYn2mawLm4msyutyWy/SWsAqbwRLsehmqui+xfL0cAXnEoidqouDRUn5rSUBZ2MlBNeFRBeD8b0SPfArHMiXx039glHhPgTy5WfvnmuThoEMuNvDcC8srPc2BExyqbVW7hWneioJAk7Q2HzyXU9k/80OQczx5gbDw7lmUJPg/yXzlFNjFWNU39RyfFnI7DCv4DmqhHTycci8tJGvKhOLV9XSnpZKHXnLfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1Mo5JFgxGn5H6HKsVEDEaSyXk72X/JC48fJnaRvMS8=;
 b=pnTlAT4qL82u9Mj0bQRS1HY76myB786H6m9XbPeYxIEqdoaPXgqRBHd8MrmXsvCMsWAvK118bAN2ZZ2329CYICPAPpd7eRksvXgG3oUR5V9IWPxslrrNltlO23zV5HJKxnlZRhseJ0SVdRRxCjq/XRsnFVTjnrMYz4XmCV2lZ/W9HVA8VUM7Ve5AUDranVvH9bBOEYsxnDrLsdEMdhbkKkLqV9h/NY1+PBnh4HaXhCeHc3zAs0JK+b8eJ9iUrF/293veewIS6kPWXcSdTtA+N/7gNff962TNnZ6HhTEHWalfMocGIZomk0D7RbOkNGAWm1u5ujJI+1ydbL9IE1RVVg==
Received: from SI2PR02CA0024.apcprd02.prod.outlook.com (2603:1096:4:195::18)
 by TYUPR04MB6741.apcprd04.prod.outlook.com (2603:1096:400:351::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Wed, 21 Aug
 2024 09:42:11 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:195:cafe::d1) by SI2PR02CA0024.outlook.office365.com
 (2603:1096:4:195::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16 via Frontend
 Transport; Wed, 21 Aug 2024 09:42:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server id 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024
 09:42:10 +0000
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
Subject: [PATCH v13 11/29] ARM: dts: aspeed: yosemite4: Add eeprom for yosemite4 use
Date: Wed, 21 Aug 2024 17:40:22 +0800
Message-Id: <20240821094043.4126132-12-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240821094043.4126132-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240821094043.4126132-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|TYUPR04MB6741:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b1e7bdc5-25ca-475e-6236-08dcc1c587e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JWgsfTn2pmLd9LELzl+75b6+//Wovq7xReQ9nBbyM7oQBfqgKsC3EgL6TO5z?=
 =?us-ascii?Q?iFuoiGL9Yrr1xps/nsjBHklSTacOQMZWDO1ZYanhPjEugQ9CD76HZEiOVYtG?=
 =?us-ascii?Q?nI0VxQHQFNmIaOOXmMwP3dDaNjY4yZPyZaJEzNz8PK34hjCGcK8TCVS9X8tw?=
 =?us-ascii?Q?NE9hmp6EfkDE+gVrZzYfpBRLnlwMmn7Bd5RQLrzgXLWRKqr8Hu8SbTH5zD85?=
 =?us-ascii?Q?lON/mX4KlZSNdcqHIUGTsBkuIPA6c16qYNSMN6Fu5RCneLaM2sIDuY22JXBy?=
 =?us-ascii?Q?R35qxSVli75sAlzKGWZ7UPRiH2Dbtjagoj27yrTZplc7K1IdYN6/jcMs0saG?=
 =?us-ascii?Q?YGBczODbK8qqB7zWM3mPdrEwAB1/x+OBnIbt6nGCyMSbrSr6DUAGBtSJf9IV?=
 =?us-ascii?Q?n0xTrT+G+eH/dhSPo2b82bmqtsKpRPa3FJbinCisbT+neR9x5+NATqB06Cb4?=
 =?us-ascii?Q?ywkbInIhc56+eu3IISklBPC652HgjylViKiWTUBiGBmFd+XdyW2vGJYDdOqD?=
 =?us-ascii?Q?jC/rUqNolOsfvEik2gR+Zcx10UKlIPSOu2ZUzqsGOX0BXhQeS+5XKoI/pI9d?=
 =?us-ascii?Q?PdYoT6IFWr579gj3zLq6FwecPUEn3S9W+ifiq0szIA2YQH104GK8yYsG3P3/?=
 =?us-ascii?Q?fx5KBi16M0xo5l5uV/WTmfkcTy2znMPQlLkUX7SsUO919eaNy6z1dZ+wBnv3?=
 =?us-ascii?Q?J6yQs2JZT7XuyTjKbd3lkhWI9ZU98h0QUvf8t/KzqISd5jguGW/7ne7tl6pI?=
 =?us-ascii?Q?IX6lqMxGLjZG7U5znoWzcgCi1Upfloi8b4AQikCJ6FNx3RiUcJZzwug7ktX/?=
 =?us-ascii?Q?f2Iy6fULStrXjEQVE3nVthz+DYhNWBQ1pLlCgwq9WoUqIjMnaBAwEvAYSxze?=
 =?us-ascii?Q?ioOylzhIsGDx1Kl8a5vvIe0V5TXjIyVl/8t5de73Fr+tPqFgAzQ/K6iaPBhV?=
 =?us-ascii?Q?Dp7rszcEDB0NNYArp9YABfj43DfJv5pI+Y258xhLZsNr+S7sr4FqzzTRNheI?=
 =?us-ascii?Q?k6TScntMDHN1xRMhQaNrBt/SDr4G11IxL+kN7I642bgHolLGyEEH8CVjh+hi?=
 =?us-ascii?Q?37lF/pYRf4aPZy/VvJXVdmO1wb3wqH+zQXJTp9Mw82Xu+uJ4liQ0xmsmX1QD?=
 =?us-ascii?Q?CT3s9fpW/qM+wgsfQdEoM9P/BcoP1eIt9BIiqnPbGT/2C1xm8AWaPWomAead?=
 =?us-ascii?Q?SbLyO59P3GVtB5TDf151vNtsChsFNvpRJWAv6f6BQQ7FFYctL0VjtHjswr8a?=
 =?us-ascii?Q?2pkrMVlwI4OmLVgb3gCTeeSfeSDq3/qGO9HgwA/yXCFOU3k1s9o4zR1rOZYZ?=
 =?us-ascii?Q?Xm1/a5kbelmnRST4tipvFPASYrHX6t14ww1Y+4c/77E9eCuXR6vcdI5CdBPs?=
 =?us-ascii?Q?UTHdiCfNbHltrbUeDEtOmMXE4YZVRIenXEBjNhkMPpQpn/ELnvn3yWQ+cm4W?=
 =?us-ascii?Q?DzjvihgutJIKMr8YENrKsO46hARHvgP+?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 09:42:10.5593
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1e7bdc5-25ca-475e-6236-08dcc1c587e3
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR04MB6741

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


