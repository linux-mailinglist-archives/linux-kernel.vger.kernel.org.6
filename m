Return-Path: <linux-kernel+bounces-308361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC05965B85
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17E131C21252
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4782116EB58;
	Fri, 30 Aug 2024 08:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ZmbZXqJM"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2075.outbound.protection.outlook.com [40.107.117.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A385D165EEC;
	Fri, 30 Aug 2024 08:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725007599; cv=fail; b=rlpylWPt39nKfoBIc7hVDYfZPOrh73r/Dl9V9Vd2vzYynzaKH4fukYkGBhzahf208/CKUC0gxUX3kvz6haCCs+AOzrLiOXHOOM/DwM3C+zXOgtRZPIGYnv8ZfCoQBR4roeU8/NaQkSxw44Tu/3dsBZQRYuPp73esJN/zDunxiQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725007599; c=relaxed/simple;
	bh=agxeHUVpg4xhdG0lEqOpV22nXmMkNNsCTB49JdWRMxc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=TYeD6fOMXZO9aZJQcYBN7b+phA4GtPQu9AXp6Il6cypX4PrLPLncgAmA19/BkLXV2sJRexnD2UvXkrx3SaBUcUEbm22jn1+BhceTWg6tZ537tZ+YUdstepaIaX8wXgbqeqYQBhdBtffbWXgc+2qp8q2ZrhjgMm4TphDK906QDAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ZmbZXqJM; arc=fail smtp.client-ip=40.107.117.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sc6djEXBJL6itJqVFDS7v5oYmRn9fXN/k9OdgMXbX8ORU+lJBuma8Ttblw6vxCOk+Y5Qr22DA8sqkBx3/5Xk5LRaK/Zr8FtxIe82L9JRRrpB8Ry6BQ3QWHtyiwua7D6CNsIrddq5JKlPedLiwWxmIGo622Kl1ineERfvv7A/9LqAZLAqc/AAm2msfRSlOdfRST5X4p3C3v69RZxsbHfygkVICOQXOz6QsY+Vf7gL14h+WJA9J9hTh367/ddrTgyy61cZ/WEsb6EvLTPt5pbftPnrrbVc0JG34OejJvbVYYgIeWqPJ16yeTAJBieLb/AIn7yyW9IOBJhTIVQ16mAGVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMeImisvCwNBoGSpOdNQ54Kky4dLURbmqictKQe4csA=;
 b=JE9fS+2n0mLyigXlGvbPCDV2Ci/kRYDjHMoTYv5hatwD5pJJ2EjmwtSxCHz6AmfrUkY0K0JZW/4Av1qd1vBEuUVL9JwHNqfwxOywl1E+TlLEdkVj43eCnTicXFYfZuqQMNXQHxPyua2qcWOvtTMnFNoGW7IEvYTQcITQgASxBGtUbnxNGOAeaG9JX/0c+EyBTgewMWZAZDu/9D8xSt2xFIBTtoYHKT0YfKYnT3LYBnaxND4vpY6qBcGMEkg8MEGV0JZcWCLXS2YYjAOm3WNLiX+DbFx5WMawFiv8LbxB0txJ6xdLut5QOAOtojY8wmw1a4wWbg90HJEHkfNyUipe7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMeImisvCwNBoGSpOdNQ54Kky4dLURbmqictKQe4csA=;
 b=ZmbZXqJMQ1B4sjqk8xO+nTDgTC6WCzuj4cWUUygEb1X4rNBUgo91XY03KhMsdi/M5XFDdUsSJFdwBBNoUpHeKaDZdGxA/5N9LsLJiLICp5hVXAC6ki0lhojzT53ZLRtc56wbastjkaXL1dvV/fOTUDndzTcyG2Jk+peN0uclutDubEA4dY3jRxrilvMdVYiQ8Zd3SolRyxQrCCuk99Y/JOWw3VYPvCdw40cegCfiFuWPiw2EmcK+mssGTIsxR1m9UcXNUwQiv6EGQPS7EqDvOMlPRGMfjEK51SKXcMFcO36NxTkkT2MUWg9w9Wuypf4nnKywoH8M/wYfU8CrAZP1fQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
 by SEYPR06MB6681.apcprd06.prod.outlook.com (2603:1096:101:16e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Fri, 30 Aug
 2024 08:46:34 +0000
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1]) by KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1%4]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 08:46:34 +0000
From: Yan Zhen <yanzhen@vivo.com>
To: ckeepax@opensource.cirrus.com,
	rf@opensource.cirrus.com,
	tglx@linutronix.de
Cc: linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org,
	opensorce.kernel@vivo.com,
	Yan Zhen <yanzhen@vivo.com>
Subject: [PATCH v3] irqchip: madera: Simplify with dev_err_probe()
Date: Fri, 30 Aug 2024 16:46:20 +0800
Message-Id: <20240830084620.396417-1-yanzhen@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0190.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::11) To KL1PR0601MB4113.apcprd06.prod.outlook.com
 (2603:1096:820:31::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4113:EE_|SEYPR06MB6681:EE_
X-MS-Office365-Filtering-Correlation-Id: 76cf645a-dd8d-47b0-dd43-08dcc8d040c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pESYbvCqoCqBq3QqEoYRFZUYUUgsvkpQScP1/4UVOg9XaDNIcL3Rzk+yuyCu?=
 =?us-ascii?Q?eW/CoXt5/NZG1H8nOqFel5v1sr0AdwTc+GqAC7nT+r32yn8kr7FcRo40t+2r?=
 =?us-ascii?Q?x6b5a6TbujRT3pnLxQKuFDDNX+zIHUwCToXpxJV3JTAtxYdBg/JKS+NbSx68?=
 =?us-ascii?Q?04moZI++/LMZjqhFTB38inMxNrHiIBf504vp3U0cEOBJVHgyX60Mcdg9YI9+?=
 =?us-ascii?Q?qXbWiokS5QagGHfbe/mdMp02NAXrL/OQwwB+A7R7PyMdPP2cWVHNIUgNMVrd?=
 =?us-ascii?Q?LSezpHSfGOUDeQUdD2e0YwuybSHyl+MpmJ7MlVCdakvsQzfonumZxGs3We19?=
 =?us-ascii?Q?OBDyvJ3qfJSt9TIZvQk0gWMm3jT7wqxdWUBP51k7TOXg53CUzRWngw3cmim9?=
 =?us-ascii?Q?h3vADIfglsuyIQ9UH4+behZtpY1ohB5+ivUtwbOq+gzoVkxwc3H/kZOg7fxt?=
 =?us-ascii?Q?2/t+srSsumebzmRHJ6DpnM/J1sahvBf8hJKhmcboSPhqVwSrn1D03zSlcwa1?=
 =?us-ascii?Q?UK58ixttJ10FdmKWZDLQ+fsbqturjOqvar05bNOP6eH4vashrCVMEBTxy2pJ?=
 =?us-ascii?Q?cQPv+4H7qbtFITSa4CbAEda+vSR4h43hcUwkBNPoC78sY1d8iZ3UM1naYlc1?=
 =?us-ascii?Q?d2t9av1S0qPF1YXoYiRf+WKAij6ZCZ3nkiJgWBIuj5xm/2Y5pBbDAajsg7h9?=
 =?us-ascii?Q?KyZFPi2Ai4PUqH0rKU0XKXjdbidf+bSawefGGl/n+zIFn+f2v6QUz+tY32fI?=
 =?us-ascii?Q?uDmow0D7iDOAbJkifaRdKXdjkVIJ8YpyBRAF2NZ814LKFIPvv+2xaXZJBcAh?=
 =?us-ascii?Q?uUqKBrYasVqFn9Ex0zVewDrJ32NX0b9hi23Vyibf3nEWRnbqfH+03GR7QEFq?=
 =?us-ascii?Q?Z8+0k3nD7lsgpjuwsUELDvymmzMjYzsX2fwYIRVX6L0WVv13cgsk1oI8Az2Y?=
 =?us-ascii?Q?w7heAEXPh36E5/m182IsUbb+tksBsWdbhE9NtHfH1IN/B+tdilL6d0mGszCZ?=
 =?us-ascii?Q?0P4ja1I9HCURgvJrtg0J8yNW1cr+YM2OfgsKG/EWr0q/ORvdFwO9q1QwJWIB?=
 =?us-ascii?Q?HykQwqb72p6TLg1m1fOGfQdGlqUkK6SLMamvF9vc2z5pYozKnLw+vQbW93LF?=
 =?us-ascii?Q?ujQ26kzeCaIUpuH0ZheNjZz1k3l/vYQ1dLETusycQXSMJlTOGiav88a8LGaS?=
 =?us-ascii?Q?zpZ0Kk1r/Z1TZcxeVXCEAy/1cARb1zVF85ApRQxOJhkfJqmOdtZyo74IJJBH?=
 =?us-ascii?Q?omEh324olfTWCflqo8aJ+WCeX6IQeFDd+MgDbRJHeFPmpfwcJhFQKMW9bkQo?=
 =?us-ascii?Q?Ya2YiUjoSDYzLq3+vmUE3FQj6xGcygLaZqqTXysUck7hEZJk5qj1IX3f8R4c?=
 =?us-ascii?Q?x9PcCImG6JYk8Iafr7l8mcnZEryFO989ffueSqSC1oWXsmlq1w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4113.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ACVy21Q76aW7WJdm5b/d/M7Ru+E+BxW/H82G12ltfq8y27xZalGScUNQ5Wcr?=
 =?us-ascii?Q?JhhF79EdpWsfk+OjABQssRtC/Zv1y2hA1CJjNLeIq8vkSttZ7NV5L2VY2Lx3?=
 =?us-ascii?Q?WFO2I/QHTXfo0laA8gYHi525zYcVgyNCJ4sv6s9o8+hVitNwrJFGmp9BnMAe?=
 =?us-ascii?Q?1M8fKhzy1PXDFpjQ89FabfQitwUxxPApkl346aDxJcXyhVogGlbx6ZZR1znc?=
 =?us-ascii?Q?nV6pOqpvV9FVcDVBLgkGK5HRwqPVrSrdGwAHCNZr7mZY0yOaj/szhGTW8a3e?=
 =?us-ascii?Q?4E2PbAYv96fI35MM/YzmIt5HSTEQ+qTTwbrneki9XxdylWStp6YxXEtIcAEv?=
 =?us-ascii?Q?k+JOMiAwWEKtMbs/T5kicrOuFkiX0c3wcjXpWWfO09sxXLuf8cxfnI3rsJ5d?=
 =?us-ascii?Q?dMG55vVe9HOBeCIz0tyNvt/ij6orVo5Yiz1c6zRP2cQXfXhmMkq+if0DFICt?=
 =?us-ascii?Q?GPSUtDJ71y+hA9MtZNWRr2cI0+YUUFmLY0TNXy3E7HWn/AnJgU5/QeQD5CvS?=
 =?us-ascii?Q?fdHQMeGf9lHQ4YxpXUYr7w/T1elsfCd4DHNR9N00pLZVfdA1fcUDxIiZkBk5?=
 =?us-ascii?Q?5yej88f26Ym1ZT0m/Lgpb336NFlbpsnffFBiPwBR+x+Ukxr5wh2x+Z0Riepn?=
 =?us-ascii?Q?dZF1HmFCXF8ZQVwRs30S1+d7Q+iHxKwwugrJ+tES0/49ME0YYnSPgO1wYSDj?=
 =?us-ascii?Q?ZnNmexs3KYbw3G7zuYhkKFhYIFOEmQFVFAHy7AMVCPoHvFEDFyS44+LSluG1?=
 =?us-ascii?Q?jEZhlYU2xtUQU2JTyWwlPNMuUePCKuCwpD9QS8s8mLyfMPS3MShIeubi6CU9?=
 =?us-ascii?Q?Nh2Y6Iryrm8RD8RdDHMNeAp/L4E2j5PwQ1vE0BOYPAGJ+tkgvD0LMa7yywOf?=
 =?us-ascii?Q?CebJ8Q6L2ubJo+6qOcSeEv54WtsozwFsVSyqtuKrorGmMkkarmGeJiHyaGNh?=
 =?us-ascii?Q?D+tRZzaR7bmieh72RI229K3eSsNMidQ6v+5JjS27g7IWxa1vxAuzGQkoLV5n?=
 =?us-ascii?Q?MMuL1tAqVQjbezGR2l7pvTDFkYa864oiM/LCMkK6BrOVjH/09aXbJK+AGabl?=
 =?us-ascii?Q?xoP31Uxt7o03wsSvs4wmqNc1+/b4ORLyTknrHl3Zcpe+lVxHlrw7a+L39mKt?=
 =?us-ascii?Q?vegLa9UFNy3Y2+Y3Qx7QnQlviexIjYQgMpBm4Wdwn34DtnZwocYtxpyKfFVM?=
 =?us-ascii?Q?bxVJJFYRBA+3dsDLjTOzWEatm5g+3hBKxlFp/KOhUidcmMtiBYQ9uB7kIlSm?=
 =?us-ascii?Q?vx77PJR+InPG5vYtiAzrX7JfSv0SZ6JS9EfY9QbEynzlrqnnEDJuR//1p33X?=
 =?us-ascii?Q?/Mpg9aRDPz1PM8RwHqm/RRCs3d4yjaD+oQUWQXHwmXzVObGGO1ZLDyIEUGeO?=
 =?us-ascii?Q?ESzjFJOlPb7YzW5Y3v3oUraggv44JVNhI8Jwv2fD/Tkxp/+SOWt4Bh/7y2LU?=
 =?us-ascii?Q?YN3wevbHYKzxVzT/HTKpk7qnEAi0MtTqZRfoDQrAlqeg8NmjoF3Wvm+z7VTE?=
 =?us-ascii?Q?7syirfS8hZ0qX769i10Hdv4ixo0iXOlXeu8T/sMIH4H2yTWzaWfw40OpCA/c?=
 =?us-ascii?Q?8Ij+kqQwK4kK878q0KVF6LVisRMiggWerBZv0e87?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76cf645a-dd8d-47b0-dd43-08dcc8d040c5
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4113.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 08:46:34.6515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2tJKVee23kxPsVX3bZoz10T6xu6mOEA3BAluIezIvQbBxgZwF+uC/UWzhj5KnNmZTCbAXDZgRIdS1xfkuxiIog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6681

Switch to use dev_err_probe() to simplify the error path and
unify a message template.

Using this helper is totally fine even if err is known to never
be -EPROBE_DEFER.

The benefit compared to a normal dev_err() is the standardized format
of the error code, it being emitted symbolically and the fact that
the error code is returned which allows more compact error paths. 

Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---

Changes in v3:
-Rewrite the subject as 'irqchip: madera:'.

 drivers/irqchip/irq-madera.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-madera.c b/drivers/irqchip/irq-madera.c
index acceb6e7fa95..d5ad4466a140 100644
--- a/drivers/irqchip/irq-madera.c
+++ b/drivers/irqchip/irq-madera.c
@@ -199,9 +199,8 @@ static int madera_irq_probe(struct platform_device *pdev)
 		ret = regmap_update_bits(madera->regmap, MADERA_IRQ1_CTRL,
 					 MADERA_IRQ_POL_MASK, 0);
 		if (ret) {
-			dev_err(&pdev->dev,
-				"Failed to set IRQ polarity: %d\n", ret);
-			return ret;
+			return dev_err_probe(&pdev->dev, ret,
+						"Failed to set IRQ polarity");
 		}
 	}
 
-- 
2.34.1


