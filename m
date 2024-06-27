Return-Path: <linux-kernel+bounces-233011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 733E291B112
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 22:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC169282624
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 20:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F3719EECF;
	Thu, 27 Jun 2024 20:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b="V0zMNYqW"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01rlnn2043.outbound.protection.outlook.com [40.95.54.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D5314D6EB;
	Thu, 27 Jun 2024 20:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.95.54.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719521759; cv=fail; b=RZPuDi/ANoykT6uBOcGHwQDpVBe2xfKCiUHxqrFaQUyn7TzJW1QRZ8Un5PZvV+A/HTXK9YdX0akJwz7QDCeaPslpa0z1H8CUZPoJsRAAikT4n0f+H8ejAco4WqvgfAg74HYDkzRuF04ztN2CXLj993bYs30eNRpwNvBqIYRpneE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719521759; c=relaxed/simple;
	bh=405koqkFLItgqfZWzqnAgNocH96nFaeX4lUWVJeXyFg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MNixyestvd5/Mkjszu6rQS6NXwREO9fFqMQaA0Wa/FlrPltGbtXAMR8A8b/m0iezehgftZggVytUDxGoNZwruoBOAYxBndWvAahzxossLD669claCR/e0y6BqcsXExqMXAOKO0y51wOloHyVtmDcE7o+mEvZfY4CcuffE2ubWl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=taln60.nuvoton.co.il; dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b=V0zMNYqW; arc=fail smtp.client-ip=40.95.54.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=taln60.nuvoton.co.il
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCv7STDAIpmQebJwic405gIMu5WBVS7wXWkupGyRztZgxdX6HIwRtzHfJmq92Nnf+y3H4+K1NpwHU6CFdK/can/gedtc6ACGluUcRs/atoaEl4sR26BTdBDTutIuekhMZdm+nBL+m1ILPOXKJZ/ft6EbZBcfu8He9L+zgo+4+9w7u+BwbZkWcnbGQjBQSHBFe5rakEmZ2YfcwMmdL9x1NWIMACZrvGT1XjE6MmeVJ6CjeHV1e84CkgtM8TZZDk9ut1c8Yb9PjHuMdnZcl3aIsHUiD4kwUzx5xjqwgxTopk7fLxEsY3i36Ui2Ocis+nWpTGZ8e4adreftERvRp8BzAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SphcdK9iAYR8pvG763Yp4p1Pc8+L78yo/9jOfl5U3YU=;
 b=EU3UKtxQvw4xHoiUrqZNEfyxwVyacIeZDXrGBT5XRrrQDApjcRiqAa4RlkyyNRV3PQnuVWAi5HMPKpM1SudrzCBYKcgpJfBq9L6rrNwkb1JMgqUAApnSXMtnb/w1HYewIXxZkepjj0ogmboon4Cf6qalOpjHvzZdQ5I0bTtJ3Qqn+6OuKoRSrl2XyKKTl1O8tzMze0kCSfdAktch2Vom9G2NOZt1iYF60U4d4PeagNro+jfU4TyQOz6UmfEk3yhPF4i/II7DgJiMwJP7qh87PfoqrDt9VIVyaEjAC05Mz9iiKFHvbD/3U1IrQRiep0JJXxS4qzHwe5bjM8arp2mmiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 211.75.126.7) smtp.rcpttodomain=gmail.com
 smtp.mailfrom=taln60.nuvoton.co.il; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SphcdK9iAYR8pvG763Yp4p1Pc8+L78yo/9jOfl5U3YU=;
 b=V0zMNYqWWCn4459/XAzk6dy4YHas+SEokSe7+Q1w6t+2VeTBf3C+8rPGpZuOkV0kdJxJtfgicqvCy2UDFFtuiocK812Od4H5ngxXKNk+cIgCR5gU2CMZxi2cutA4k0Ar8wwTycLemB5Rii03wvMICPvY1gBpmp+lX5JhN08FkoM=
Received: from SG2PR02CA0122.apcprd02.prod.outlook.com (2603:1096:4:188::10)
 by KL1PR03MB8775.apcprd03.prod.outlook.com (2603:1096:820:139::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 18:23:22 +0000
Received: from SG1PEPF000082E7.apcprd02.prod.outlook.com
 (2603:1096:4:188:cafe::1) by SG2PR02CA0122.outlook.office365.com
 (2603:1096:4:188::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.25 via Frontend
 Transport; Thu, 27 Jun 2024 18:23:22 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 211.75.126.7) smtp.mailfrom=taln60.nuvoton.co.il; dkim=none (message not
 signed) header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of taln60.nuvoton.co.il: DNS Timeout)
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 SG1PEPF000082E7.mail.protection.outlook.com (10.167.240.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 18:23:20 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Jun
 2024 02:23:20 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 28 Jun 2024 02:23:19 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
	by taln58.nuvoton.co.il (Postfix) with ESMTP id EA8AC5F64B;
	Thu, 27 Jun 2024 21:23:18 +0300 (IDT)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
	id DB5D4DC0726; Thu, 27 Jun 2024 21:23:18 +0300 (IDT)
From: Tomer Maimon <tmaimon77@gmail.com>
To: <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <tali.perry1@gmail.com>,
	<joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
	<benjaminfair@google.com>
CC: <openbmc@lists.ozlabs.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Tomer Maimon
	<tmaimon77@gmail.com>
Subject: [PATCH v1] dt-bindings: pinctrl: npcm8xx: add missing pin group and mux function
Date: Thu, 27 Jun 2024 21:23:12 +0300
Message-ID: <20240627182312.86382-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E7:EE_|KL1PR03MB8775:EE_
X-MS-Office365-Filtering-Correlation-Id: c9953d63-cce5-4351-4c72-08dc96d6395a
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|35950700016|61400799027|7093399012|48200799018|35450700002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KT5FMkxVkXtvOM3ctkn6quhzhrjNdJAkxzOIpTmu6WaU79QpNFVRWGsAsyNO?=
 =?us-ascii?Q?Ovu1NXeiNcKXoiKUIUDNrU1Mv24Cbxd2k2Rzku2XCQ7mRhNe9kSfrk3P2k3I?=
 =?us-ascii?Q?7Ra4KJshDgyzpalxDe+xk6lw4teHY/WyE6Rc877Uyd8AAlf2m0eyuhvqfyU+?=
 =?us-ascii?Q?Ixxj4Pfcxe6XVy7t6ZZiZRIiOcMBraATZ2my8NzIDmuI2iI5L9ZPkk6GBTUm?=
 =?us-ascii?Q?+sLZGcy0UDfioQ1Q/gAH3IXpNAxZkmvvI/zvm4avk1C0i+5i/T7LDbmTv2X5?=
 =?us-ascii?Q?Jy7sI2cUUgM/1krOYk0QFBlxUbrtAVXblm63f6ZuaKhq7wy1W29I6qK9QlZJ?=
 =?us-ascii?Q?pf3qKV5JXmJth+SjUcWaQXyBHxqltj20EI/BhBiKahyn476Fs/61RcuKKurW?=
 =?us-ascii?Q?Om+GIJnp/o36dVxRzmtp/raN8XYS3039CRyZ5cQckOwBtjFiWdUAy9AvKDG6?=
 =?us-ascii?Q?3u9nwzGjuBcCswiirHBiqUpcneDrPJ8q1SetDePjhxYsgyCWM/zX+O+HZYxd?=
 =?us-ascii?Q?m5I/HQ1fjwX5drjs7pPETy6DWaKlfjt/QGUUwtvpwade16fX41vVbd4jehHh?=
 =?us-ascii?Q?D+XqnJAKrf7rsUkKxvHZK1nexbzFlxNk9SEyQY2xMZ9dpx6AdIfhipTaaJ59?=
 =?us-ascii?Q?h0N+ize7JsjZImtBBOJdEJQbGoLAG599Ufn5XTM0XlvCuSzhX1nu4XVTGb0k?=
 =?us-ascii?Q?SPg0ZRUxbR/IqXEXcadBak/rqyWrkx5HAvB/0dvnYzE2PXTY2XrtqkedM8NO?=
 =?us-ascii?Q?Pa2r6s4S9Y4LBkg+Vq7p0sjFleGibIopwC0m5urBQ8vxxMO1iNfEcsaA0pHU?=
 =?us-ascii?Q?68RMSrrZF9uBHXpi4xHxsx5Hwy/P1HkekR1IGaECYUtc7Xm1jyONxFCXpHxU?=
 =?us-ascii?Q?XzHenn11QgcLdYxuNOjmDiLH9wFlmt9BRj+M9XVJk5fRZWvLR4LuTRcIZFdj?=
 =?us-ascii?Q?ABHQOWWPxyIx/RYYftxKFAwqF+jFIrlpU0kg8Dpu59SI3upjXnfw7PvRL8Kj?=
 =?us-ascii?Q?PpM9shtv3E84sifcWvKBiRBT1dGAXmocNtyDQd75Ngri0mDTVeBf0QU5rloq?=
 =?us-ascii?Q?2fwyMrQXfJ+FlX6bffrdZSTCL25SBPvOSy1afdkeIGtlLL9Bs22GzCtZyWvy?=
 =?us-ascii?Q?spWwxaIr5m7r/CXBuibjzq2axBMZEC+3HZy69NYOsw3uUBfA2jjmpjH4kkR8?=
 =?us-ascii?Q?Z0UY7Ezf2IXmzirFt6DUQRxCkmxR/WI4P36fRVDoRUyWNbsT8MaqzSWbM3l1?=
 =?us-ascii?Q?bAv09la0GcVadiOng33PRrPBqyZYv576aCTABjx4n1tjrAjiKfT8uzFDdvuQ?=
 =?us-ascii?Q?l7yCzYS3hZwSxyE7XPEGQkzuvrW4Xv/G7UMIb7E9Lo107NjOxPJGz0Z3+FlL?=
 =?us-ascii?Q?EoySxNJlLFeyTiDlyR5ggy6YLHaw+TJ5SAKi6FMxawaaSTmbTyR8YKavh48N?=
 =?us-ascii?Q?LtALBLPLon/0szi2n08bv7vQNmRLaMXTJaFu48KP6NGMNyiIBxO3dA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(35950700016)(61400799027)(7093399012)(48200799018)(35450700002);DIR:OUT;SFP:1022;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 18:23:20.8060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9953d63-cce5-4351-4c72-08dc96d6395a
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E7.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8775

Add the following missing pin group and mux function:
smb6b, smb6c, smb6d, smb7b, smb7c, smb7d, bu4, bu4b, bu5, bu5b, bu6,
gpo187.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 .../pinctrl/nuvoton,npcm845-pinctrl.yaml      | 22 ++++++++++---------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
index b55d9c316659..f3c3f910a51f 100644
--- a/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
@@ -85,11 +85,12 @@ patternProperties:
                   smb2c, smb2b, smb1c, smb1b, smb8, smb9, smb10, smb11, sd1,
                   sd1pwr, pwm4, pwm5, pwm6, pwm7, pwm8, pwm9, pwm10, pwm11,
                   mmc8, mmc, mmcwp, mmccd, mmcrst, clkout, serirq, lpcclk,
-                  scipme, smi, smb6, smb7, spi1, faninx, r1, spi3, spi3cs1,
-                  spi3quad, spi3cs2, spi3cs3, nprd_smi, smb0b, smb0c, smb0den,
-                  smb0d, ddc, rg2mdio, wdog1, wdog2, smb12, smb13, spix,
-                  spixcs1, clkreq, hgpio0, hgpio1, hgpio2, hgpio3, hgpio4,
-                  hgpio5, hgpio6, hgpio7 ]
+                  scipme, smi, smb6, smb6b, smb6c, smb6d, smb7, smb7b, smb7c,
+                  smb7d, spi1, faninx, r1, spi3, spi3cs1, spi3quad, spi3cs2,
+	  	  spi3cs3, nprd_smi, smb0b, smb0c, smb0den, smb0d, ddc, rg2mdio,
+		  wdog1, wdog2, smb12, smb13, spix, spixcs1, clkreq, hgpio0,
+		  hgpio1, hgpio2, hgpio3, hgpio4, hgpio5, hgpio6, hgpio7, bu4,
+		  bu4b, bu5, bu5b, bu6, gpo187 ]
 
       function:
         description:
@@ -109,11 +110,12 @@ patternProperties:
                 smb2c, smb2b, smb1c, smb1b, smb8, smb9, smb10, smb11, sd1,
                 sd1pwr, pwm4, pwm5, pwm6, pwm7, pwm8, pwm9, pwm10, pwm11,
                 mmc8, mmc, mmcwp, mmccd, mmcrst, clkout, serirq, lpcclk,
-                scipme, smi, smb6, smb7, spi1, faninx, r1, spi3, spi3cs1,
-                spi3quad, spi3cs2, spi3cs3, nprd_smi, smb0b, smb0c, smb0den,
-                smb0d, ddc, rg2mdio, wdog1, wdog2, smb12, smb13, spix,
-                spixcs1, clkreq, hgpio0, hgpio1, hgpio2, hgpio3, hgpio4,
-                hgpio5, hgpio6, hgpio7 ]
+                scipme, smi, smb6, smb6b, smb6c, smb6d, smb7, smb7b, smb7c,
+                smb7d, spi1, faninx, r1, spi3, spi3cs1, spi3quad, spi3cs2,
+	  	spi3cs3, nprd_smi, smb0b, smb0c, smb0den, smb0d, ddc, rg2mdio,
+		wdog1, wdog2, smb12, smb13, spix, spixcs1, clkreq, hgpio0,
+		hgpio1, hgpio2, hgpio3, hgpio4, hgpio5, hgpio6, hgpio7, bu4,
+		bu4b, bu5, bu5b, bu6, gpo187 ]
 
     dependencies:
       groups: [ function ]
-- 
2.34.1


