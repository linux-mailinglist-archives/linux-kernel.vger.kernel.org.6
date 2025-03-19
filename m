Return-Path: <linux-kernel+bounces-568013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4E3A68CEB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03B141893ED0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962BF2571B2;
	Wed, 19 Mar 2025 12:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="CSbNCNrV"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011070.outbound.protection.outlook.com [52.101.70.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC582561CC;
	Wed, 19 Mar 2025 12:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742387482; cv=fail; b=IZa299JBuVE++2SMpaZnMFDdSE6HGO8J9nbzgP2Pqa0iW+giBkTZg5pTGj/jtxajKkVhaudMfabsjkkR/PG6fji+4/+K+NHQfN9FuOGd82IMfrR5bU2xsJU3xdhsPjwGPJ8jlc8QSLhiAnzB0vZjPpYousRwI79v7cKpisdBKJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742387482; c=relaxed/simple;
	bh=AzhJjnKN2dcC8okFzeHmSiYP64j7rVp/YMI0nNzlcQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GRfePuneCPWTxAK+45I2uNuHBso446OGR4NpsYRN6riL5lDMcfp1OZpF1UMGNyQa3fCytsaEzGZEhQzOEnpR0hHprT43Y5nIU9koJA63P8LMFKxACs+KZ5UkoH8/UW4sfrTw/ineI2Y9sJxDRtxjNW0ARVvlrLH5Ykm/vc6EEoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=CSbNCNrV; arc=fail smtp.client-ip=52.101.70.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d11xAPKJ8fYMzMjDg+ZpSt+0MiHvByRWli7/+WqvIWA56jXjoIyVaruraUV+dND9iAOYWKaPxv1budxL0YZcrzYVCO1AiJoy0ImF9ZPNJLwZFwnsXsBXBghtNJFJ/aA8QdZA7VGXJEdpnpHfu4nCMFXITup8nl0xtAD6HZIGjFO7Aq1t8JskX1r9HexW8bzxau3xZWj2iPe1wOQ0cVOzKQZfHVqrITA6gRAYJC9213X01ifihiQXIH+bqj2Bbke3eTxLL68V0H2l5HChJlYs1SahbnaE1WgsMdhkfvhFV6bs/337v0iQ7tWWmp6utokApsCAQR1DgCo++G8NIcRooQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5LSs2xA4W1YVe5adU70peFXIrVvvKhiF/CUEmSEGW0=;
 b=AXFLWpydrLHGNo/kQRX2bblgH2/YN8xIqXqMJeGBkdjdhU7Nxqv0SqQ2mG+0spF6pVupKqnCx6aWlu2ibgGASZ0gy4qWvUSyCZX8XuoF7azUR50y8FiHo5RTrn8NowHIQLzTDj+1RVH1/jT5ZLq6RNBLvhBP9lZwZFdHv19EmKtv6gnp39BL03v9opR34kkMqPHllLbJt9XV5KDwZUVRU87X8ewZ3atVwQ1Kp2x39sMoWtfEB5x6cJHqdzhmAZjTNlXupGHNkSqvTCZ3ZYQudpPYek7VpoIJ4DgZ+5EVdx+VDM0zxZPTjBbE2SpTAmzccySbqxAGN63nZeS1woNjDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5LSs2xA4W1YVe5adU70peFXIrVvvKhiF/CUEmSEGW0=;
 b=CSbNCNrVYb2+vj/fKtX+Y29jgxqvGWjr92RTsezPG4D5moc0cFMFN/vGUPAMBDoOI4itKId4PDKZ9xl5mvWDw6vRx1hw54qo5sLVgKQijbR2kSoSCfhYe7deVmcnsHuhFyeSJriPZ9aj0dRA2M2tyTqRzMVU6EPmM5jlXP/+NLY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
 by PAWPR10MB6856.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:33c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 12:31:10 +0000
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4]) by DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4%5]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 12:31:10 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Colin Foster <colin.foster@in-advantage.com>,
	Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Felix Blix Everberg <felix.blix@prevas.dk>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 3/8] mfd: ocelot: rework SPI (re-)initialization after chip reset
Date: Wed, 19 Mar 2025 13:30:53 +0100
Message-ID: <20250319123058.452202-4-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319123058.452202-1-ravi@prevas.dk>
References: <20250319123058.452202-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0111.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::24) To DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:41::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR10MB2475:EE_|PAWPR10MB6856:EE_
X-MS-Office365-Filtering-Correlation-Id: d7c7247b-47b2-4422-1562-08dd66e1ee09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kSIv8V1Zkqq3JTNAvRZb0PFwflPAFZUutZb26/1gDmp857clY0G0SIsRscD4?=
 =?us-ascii?Q?rI4/KK+5PixQIul/5ArodfRgMLoYGbLjRDfGF82ulp/HFueFQLQTlIyqYMGW?=
 =?us-ascii?Q?i9SGUS82aRMutVi7WrFHIRE/lEwuXquy1+Pc9L3RIMhfRcBMXPxCaT99kYsB?=
 =?us-ascii?Q?cBSo9XEMUvgRIlqaBRWF4qAMtd62lhmNWYDnkhyxik0UfeGgB5OhQjDjT5iA?=
 =?us-ascii?Q?Fh5r7awGEJ5/s5W6J+0NhuwSnqTdUAGzt6tEUgraVVSfgiUy+Rmbnae4N+y7?=
 =?us-ascii?Q?3VVCQskVcb4gu/IUzfPK1Se1/Xppfoh4FR6UzVVVhSWyl6D3oyIjrCf8C3EE?=
 =?us-ascii?Q?ogj7byzfWeZfnqI9D5r3TMhKcxnFLdglkyVPHXqiFCjIndaL4KkRRnKllitM?=
 =?us-ascii?Q?dZTrHVBjUf9IyyRlYvdiSCDQBjLacJD2tHp4l8q7G/wuasa0y3eDU2Entrr2?=
 =?us-ascii?Q?CGDhO1STIG9a8NdXJi2vWBdA3H8N+txWoD9Ourno/wnhxsaXFVI0G3ArQkah?=
 =?us-ascii?Q?nxaaT0isQg7/GTP1ZXa4anTYZC98HjG9+lDPJuETUxE8ggoWmeM+jDV1DXjo?=
 =?us-ascii?Q?rNBlwyLVlkNKKa+yzvVphR/DCvecmxtQdaA3PEmd0ymVLtjsyDGcZx3ebkY/?=
 =?us-ascii?Q?dF4n8Jh8mBGLIZY06EzKNaogikGeR2xLdf/uMhC1WDO8DGkLne1ZnH8Zj+Bm?=
 =?us-ascii?Q?ehObGx1+FWR1/NaqoA55ljYxKB47fNFWPqleBkq9EJHSUwrtJJj5fdeqbI51?=
 =?us-ascii?Q?S7VfkWxdaB38ybDGrKud6QTCU1jCLEhbgfuHFC/fkMCj65TGFdDNaGhpOyV4?=
 =?us-ascii?Q?YBOSpvdgvHXZz2dJhA4+PjetHCMoscMqiJlu8fWQKAYGe5fFXt77Mn+aoMeq?=
 =?us-ascii?Q?yJl3LnA3ls1jMQ6MzWKv5D3lDMBZCCCbGLxVfMf1tpT86FzRU+F7pvivec8J?=
 =?us-ascii?Q?RNCDFImk9Pg9iuyHaKfMsS09T1hcJa3SRGUdQEdk6k9mtKyZ8V74bDmK0Owg?=
 =?us-ascii?Q?JU6d7os96NwhMcY/FBCN62mvpLgMU6gyZzhR8Sst/mX2lbqwm6qle6Gpk6qe?=
 =?us-ascii?Q?1OWzEdMuw69z0yX5+zEQeykDbIpC+os1G04wirzbjjQzbSmcGqX3fkY3GZWy?=
 =?us-ascii?Q?795jkMq+RTc4cr9Us60u34yHYY0/iqJ0Sbr/yevfV/pmkOCtV5KxYQfWTB/z?=
 =?us-ascii?Q?DXcXB4RxvNz04h3YhWui9plJyQzLr9hQL0SvzPLXecbOGsEoNplEUsL7LJeH?=
 =?us-ascii?Q?B4lExFl96AtZfQL5JBmzvHQ1nE0IokxIo4VWaKlaK8qIRNf0W4nHOjv6yiqG?=
 =?us-ascii?Q?um3LG5R7DJKpnB0mT70+yRn44tePV3ZD88a4HTuwpuvM5pI9OwOGJ+3mRLAR?=
 =?us-ascii?Q?NICu0OsWCqQ6+1Rfd39k3RZ5PbIn5ofh0x0IO94S3Olg4JHtVZEfcWx2YsLs?=
 =?us-ascii?Q?pAFXrF4oyydQ/+aybqfsD5x/c6wUsUIW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l7ieRQvqyC8qY4YSSmkFvITI86wVjEeifgIRmibl9IKGgz3UHJkh/dkQmXjJ?=
 =?us-ascii?Q?lG2V1MxKIMwZkJF/irVoMDG495mcszTTmQefFEcJys5ReNXL7tUxuJQYbt+i?=
 =?us-ascii?Q?ivK5db8nQteL3JYXZfTGEor3Mnm7UKExTMB9mSEztw5+lIt3Mh9Auw2MEnGv?=
 =?us-ascii?Q?IapAIZrKNhQLGPHi7qKyLnAxx/DVrOz9OZ4UE32+mGPsja70OiVhl15RRQbg?=
 =?us-ascii?Q?p3r+NpKFoj8WOb2ZtAYTCLsEVk9Vi59PjxDI1rcOjRLulVVcEVMNjV9lATTf?=
 =?us-ascii?Q?xNbAUnXEn77+MkMZjr1dqpT1WPIpkHVHSF0V4zz1sIWYSkwMF9JTQPB+7yYf?=
 =?us-ascii?Q?8HfCtY+zZFD7nB2t5RO6dyTCWYznh/OkBMAEYgfbiFHQ92bArj4YTJ4WDy2T?=
 =?us-ascii?Q?rT6lHtJxTh0ppgWDYj8LfFNOMXHDthERttjPebdolqoByDk2NXQgph7fkWvm?=
 =?us-ascii?Q?A5RC2x4r9k5BtAqedzo9mzRZv0dsqOFECmGsjJnFo0BcggI2ILsuYj6queLN?=
 =?us-ascii?Q?Ay3Kc/E+Hd1ivIcBj9EJxlkDQlw4O6k+yODr8n/l9ScHMag7vKWVcLnr3N2F?=
 =?us-ascii?Q?z1p7yInZE7Zs/eMPBA649Te1rId4YmMKjfqaN0oW8e3yKtsJgSdVZ/Gm1Z6a?=
 =?us-ascii?Q?uLXeZkObVNua+CWPHqjc85lvIDZN+bBvUdFatjikRsqXi4k27im1OSWRsF7Y?=
 =?us-ascii?Q?s1UwKISqOJNb9yv4/D02lffeL6PSdSpF1qIFwtAloceiN8rI9ct18uBuyHll?=
 =?us-ascii?Q?EYftWwBcnnJ5AXfNnCZyFV3q5jKtCy4gkncV/wWhdsXIGGHUZTRRw4qt7441?=
 =?us-ascii?Q?YCIAKURLghG06GaTfX0RReYfcWbVL3hlQSqHboo0yew9GULwWB8wrrii/Px+?=
 =?us-ascii?Q?McO3iUyus2FTGfjgg2LykiPDkFfWJA5APP5lVKYJzNJN7CDQytdXCTYWeFIo?=
 =?us-ascii?Q?hzdT5OKk4rjvqhAIsa3nMmVVoyY65I1tZrhv8ttjnDsJO52LEI+23Utk2Q3L?=
 =?us-ascii?Q?Y8WpMheMLXEwkBej9y0S4mBWZWM6iIaAFTmlZK41sQcEl2X45IbO/fGVqqpE?=
 =?us-ascii?Q?vLEijcQcG2u8eHDouEV8pW1OClUED98Dk3Q3RgxrJun2wZANXYsaV64gBlQA?=
 =?us-ascii?Q?rXW41umWpLVR2Tyoxk7gwIKGdNmn2jwzKaus+BI97GYyH/aItlRG5h7fApl+?=
 =?us-ascii?Q?DNYLVOKjQIbqp0/1viyqe2wHju5MqAo4jINljwvq7YgJvAZ/o5V/0pt2IKeU?=
 =?us-ascii?Q?PbPHQTBWmq5s7t0RfgxyXBBOEFpsck6qXHJGt+mEiJ7ZYopyhWWwpGLY5Xvf?=
 =?us-ascii?Q?wBJHxeGcUcns4dM/b8Ysb3BXaVP6XfkrN0aTbOtdKve+JQJbW2eOmXsyvHQg?=
 =?us-ascii?Q?GPZX+kJqKKooQ8z4xr3Awe9+Eao5Xj0nTFzpzXZjjIZjXG1YbNlKo4s6Lm4b?=
 =?us-ascii?Q?zk5IMfusMgycyYLjzNGFcRIMgh7qh29HGIYxg0hOahRP95iZFbVZxVv3rpPx?=
 =?us-ascii?Q?+l5v3dL24pwvWJcngp+7Ve3sAfJQyfOVK+tT2lZWAQp4EaTu9rdWPpEmQa0l?=
 =?us-ascii?Q?tv0N21xhNGekXQ9qtdrrT/oy+KXaCuiG5V9W+J7np8aGZ5PXjT4OnGVvOSEC?=
 =?us-ascii?Q?kA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: d7c7247b-47b2-4422-1562-08dd66e1ee09
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 12:31:10.5260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cDEe/S5pFhTDCexlb1zR9FTT5pamv4ktGHuYsUPAGWZ6S0ChytH6L+qNcxcizyDBV96N9xqbm9LRBXxctbdso/ZeBrtKR9zDDNP3WjithZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6856

As the comments in ocelot-spi.c explain, after a chip reset, the
CFGSTAT register must be written again setting the appropriate number
of padding bytes; otherwise reads are not reliable.

However, the way the code is currently structured violates that: After
the BIT_SOFT_CHIP_RST is written, ocelot_chip_reset() immediately
enters a readx_poll_timeout().

Since the code in ocelot-spi.c implementing those reads still insert
the padding bytes in the spi transfer, any read done after the reset
is effected, including the "final" read that should confirm the
self-clearing has happened, is most likely garbage:

Say we are using 1 padding byte; after the
reset is completed, the device doesn't wait for 8 cycles before
sending data (because CFGSTAT.IF_CFG has been reset to 0), so the
result is going to be something like 24 bits from the actual register,
shifted 8 bits, followed by 8 bits of whatever state the MISO line is
in when not being driven explicitly.

Now, some of the registers blocks (DEVCPU_QS and DEVCPU_ORG) are
documented to have access times of 0.1us, but the reset register is
located in DEVCPU_GCB, thus has access time 1us, so it seems there is
no way around doing the reads of the SOFT_RST register with the
correct value set in CFGSTAT.IF_CFG.

So rework the code to let the underlying bus define an ->init_bus
callback that the core can call after setting the soft reset bit, and
before polling that bit for being clear.

Note that we do have somewhat of a catch-22: We cannot read back the
REG_GCB_SOFT_RST register to know if reset is completed until
CFGSTAT.IF_CFG is reinitialized, but even if we are always allowed to
write to that register, if it is possible to write it "too soon",
before reset is completed, that re-initialization might be in
vain. The data sheet is unfortunately silent on how much time a soft
reset might take, and I simply assume that the re-initialization can
be done after 100us.

This also serves as preparation for implementing mdio management,
lifting some of the initialization steps from ocelot-spi.c to
ocelot-core.c.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 drivers/mfd/ocelot-core.c | 8 ++++++++
 drivers/mfd/ocelot-spi.c  | 9 +--------
 drivers/mfd/ocelot.h      | 2 ++
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/ocelot-core.c b/drivers/mfd/ocelot-core.c
index 78b5fe15efdd2..9caab83138e59 100644
--- a/drivers/mfd/ocelot-core.c
+++ b/drivers/mfd/ocelot-core.c
@@ -110,6 +110,14 @@ int ocelot_chip_reset(struct device *dev)
 	if (ret)
 		return ret;
 
+	if (ddata->init_bus) {
+		fsleep(VSC7512_GCB_RST_SLEEP_US);
+		ret = ddata->init_bus(dev);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Error initializing bus after reset\n");
+	}
+
 	return readx_poll_timeout(ocelot_gcb_chip_rst_status, ddata, val, !val,
 				  VSC7512_GCB_RST_SLEEP_US, VSC7512_GCB_RST_TIMEOUT_US);
 }
diff --git a/drivers/mfd/ocelot-spi.c b/drivers/mfd/ocelot-spi.c
index 97e4061e3dff7..37828dd3ee95e 100644
--- a/drivers/mfd/ocelot-spi.c
+++ b/drivers/mfd/ocelot-spi.c
@@ -215,6 +215,7 @@ static int ocelot_spi_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	spi_set_drvdata(spi, ddata);
+	ddata->init_bus = ocelot_spi_initialize;
 	ddata->init_regmap = ocelot_spi_init_regmap;
 
 	if (spi->max_speed_hz <= 500000) {
@@ -264,14 +265,6 @@ static int ocelot_spi_probe(struct spi_device *spi)
 	if (err)
 		return dev_err_probe(dev, err, "Error resetting device\n");
 
-	/*
-	 * A chip reset will clear the SPI configuration, so it needs to be done
-	 * again before we can access any registers.
-	 */
-	err = ocelot_spi_initialize(dev);
-	if (err)
-		return dev_err_probe(dev, err, "Error initializing SPI bus after reset\n");
-
 	err = ocelot_core_init(dev);
 	if (err)
 		return dev_err_probe(dev, err, "Error initializing Ocelot core\n");
diff --git a/drivers/mfd/ocelot.h b/drivers/mfd/ocelot.h
index 4f602611a5a86..5aa6589b9038e 100644
--- a/drivers/mfd/ocelot.h
+++ b/drivers/mfd/ocelot.h
@@ -12,6 +12,7 @@ struct resource;
 
 /**
  * struct ocelot_ddata - Private data for an external Ocelot chip
+ * @init_bus:		Bus-specific initialization callback (optional).
  * @init_regmap:	Bus-specific callback for initializing regmap.
  * @gcb_regmap:		General Configuration Block regmap. Used for
  *			operations like chip reset.
@@ -25,6 +26,7 @@ struct resource;
  *			data of a SPI read operation.
  */
 struct ocelot_ddata {
+	int (*init_bus)(struct device *dev);
 	struct regmap * (*init_regmap)(struct device *dev, const struct resource *res);
 	struct regmap *gcb_regmap;
 	struct regmap *cpuorg_regmap;
-- 
2.49.0


