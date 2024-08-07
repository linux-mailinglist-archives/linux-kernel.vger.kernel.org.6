Return-Path: <linux-kernel+bounces-277351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD02949FA2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 08:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBCBB1F26815
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 06:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6F8198E92;
	Wed,  7 Aug 2024 06:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="L4ODxhAw"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2081.outbound.protection.outlook.com [40.107.21.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EC4198E65
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 06:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723010734; cv=fail; b=q9DR+Qc2CKWcd/w1M5rq4/pE96/9r5P8Kr3xsLYThGySbfkwof0riXzY18cSHP+c8xPP3ObLukJAeGaSSGuCVAUibbi7CCDFA484FqENmaJvygjXaWPiKaKN6mkFC6s6oKRbxlOjL+/L1aGg9p4GfqIytuHhCnsH1qjwHrRK1Tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723010734; c=relaxed/simple;
	bh=sPxdilYMtmbI/gAvV6YsEr63Z9Sv1RfcBAMv3BYkmi0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bohO/sRJETidBHUhUsdPm7T2qojgXWJaioKWOLlikNVT2JHFy7A8psIbf2Ekto8wXk2bFoLoi2zXphHAWkuxcx1CYaz+/Pdlpg9aRpUY4TjaSDajepPpld0N6OdHnNt8HHJ9FT4JsKIGgmx6Jf7BJbzqeuIAp0ASQEIgxBdxzLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=L4ODxhAw; arc=fail smtp.client-ip=40.107.21.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BxFwMEdCbncJTN395FqQsq/SxtNAYHHyhfEIDevYIVEJ/9fCUqzYK+Zw1586tJ4aQ4Y+Rc25GqmMh1IH+AldrGAAnIlRSF6ucetzrVMRCN8zYTElqTTmeDX1RXvSDu9F6qan0GDor22+4a0LikbfUWPV3k5OiSvzEGLb0/0+Ub9HUk2Pva4F8i4FGNQAz+mIb9B5s6MdoPE7XhJYBw0v3L107Lch9gZ1MWoRWXQqFRqvh9vfUUiWaHfkVXcDOfxINpVSuCDBdP2htl7ZNkUirlN2x/zi8i+h7aWpL3vf36441xmjEk8oJkB4qVQrIdgdnukxQDLxnlMhJeSjvCcykw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FiaMPNusbzqsAHu1huq+MIhuyqXg+9HaGk0RCv2jPcY=;
 b=rDiFIaw/EvfuEMvBJIL7WdbQCQbjv5tH1JAyBqCOgtIpgapWgnV/iNFe8FrqJkfVqDm7pCH5+Dfx3Kls8X6clgp2M4hFlsOxfKot1rsC2gy8aWeGSJ1MS7eOLfcpCCaXggSyJnBw7z1+kxIhqEpnBX+XM3aKFxJRNbMY5jmK8R5NXXGATQiwj/vqdeOuMRjonnmuQqFfrz+P0y4fbTO27CJEErg4+GL0IH9mDLnHt5rJb24l3S6ccrcWyHecOTCHo2jTtLdLexKRzda4Bp01RqFW+vmbLPLxvaNKZ0AU/I9Y+HvTuJ9ekvy8dSG5sdo60EBbAxPeWjS/XTb5E3syXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FiaMPNusbzqsAHu1huq+MIhuyqXg+9HaGk0RCv2jPcY=;
 b=L4ODxhAwvb+J+gEKAGN0B4TnRpQSm+xF4tcaKbCmIHbEP/veR9kbuUqs8rhQp+ZtLsoagpgfgWJ45K0+hYm+RYsGbzt58hGCd7yTJmnTXSgLaieeLHugn5812qSWXStWOTrf1Fz33cYvkVuGbFaNedrdFLwrdly3AECRYe4tt3zPb9O5gdcWO3mZzlaaQXURJJqinEFrT1QgLf/jatURGcAinII/NWqX1cVOcUdUtgBgrzu82SUVPe5VOZViQUN7cgBG7X2Jlpk7c0lzGYC6EzS0LDGzxtZay0gyPNku6Bp4KTR457wM1ITS9GtkJ6cIWqdntjC3mW1HWzn7V2h6NQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB5003.eurprd04.prod.outlook.com (2603:10a6:10:1a::19)
 by DU4PR04MB10696.eurprd04.prod.outlook.com (2603:10a6:10:590::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 06:05:28 +0000
Received: from DB7PR04MB5003.eurprd04.prod.outlook.com
 ([fe80::68ea:5937:4fa7:db2b]) by DB7PR04MB5003.eurprd04.prod.outlook.com
 ([fe80::68ea:5937:4fa7:db2b%5]) with mapi id 15.20.7807.026; Wed, 7 Aug 2024
 06:05:28 +0000
From: carlos.song@nxp.com
To: alexandre.belloni@bootlin.com,
	frank.li@nxp.com,
	miquel.raynal@bootlin.com,
	conor.culhane@silvaco.com
Cc: linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-imx@nxp.com
Subject: [PATCH v2 1/2] i3c: master: support to adjust first broadcast address speed
Date: Wed,  7 Aug 2024 14:13:05 +0800
Message-Id: <20240807061306.3143528-1-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::16)
 To DB7PR04MB5003.eurprd04.prod.outlook.com (2603:10a6:10:1a::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB5003:EE_|DU4PR04MB10696:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e1e4978-5052-413e-9e11-08dcb6a6ef78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bH7yaO3KiyIGkAzNoZ+ir1BaV9tmdCtCy1GW21wXo/01/nMG98WeaTuXJvVj?=
 =?us-ascii?Q?G7nV8V0x/gSDQ3itzjiOEXKY+qEBudk15HOcBoWdiC2sv4V6Q8oC7y2h8BSN?=
 =?us-ascii?Q?Q2v9iNvWYLJvIYXiuJTYhIFMl6dsth52HLY5y3bAbFYiXzla8rSfG7LH+tD7?=
 =?us-ascii?Q?37gpx22P4pXbtKSPgSEz1VJgZa5E8LtuRAeVQwPY80iII6AEfz44N2gzjTCP?=
 =?us-ascii?Q?dnbXuGpPZ0ZX5vQ7t8gnIU1WwQZ2KG8WfOq4MnG5tJoXjiD3P71vJdafsvGw?=
 =?us-ascii?Q?luD9bk2+Dc4CyKJo5UKsN7gFmuYzzZWj6ApxNpM1YcRax9z0dxylUx7vK3oF?=
 =?us-ascii?Q?Bj3LPgXs/fvBCEtwUPa6GMw503O0RXa+2T11sXj7adeSEFwsaRUStTzkYiO4?=
 =?us-ascii?Q?G+7O1n9mWEUyMuhlc+S2bAU7xS/tIX0xKoWijYlQofEDiiO7eMa87f1RtlhG?=
 =?us-ascii?Q?Ibx7goVM5uWpEQVJkCIoR372t0n8oKKJ9qymdbAAZpmvv6eA32KrheymZt07?=
 =?us-ascii?Q?SPKFVvSvjTdULnptdRjGfIks8KQxFx9MaMJLqXSWl78XUUHIUH/nt9113pvM?=
 =?us-ascii?Q?3wKjfXk3SjqLg5IhVKRPe4z+pNzs0EsyCawW3cvFUcZLgaqKspqxydVnBm+O?=
 =?us-ascii?Q?7XdBjeBqVV4DIhar7JdKH3HVbe8/+ggyLyaM2b0i7v9wDftACNddp2ngkDT4?=
 =?us-ascii?Q?2CoTslK80ZPqH8jU73aGWYFHI+qHHCOYNV2mqBH7rfjxblZN9KUoDKqNGknL?=
 =?us-ascii?Q?K2QHANs3aClbQr+O8HCgm6iCpEpk27dZF9K7MBopvkkFfNT7d9kFa14mtwft?=
 =?us-ascii?Q?6fhnCNr+Tx2lmOKVwNvqGWB7OrKPvGBrMv830bwE7rgXQV4P0CK1P8698jq3?=
 =?us-ascii?Q?DijHJ1GpICfW+xJHqMZs56/TiAX9zTXUsGvuyh3iJPOJVTkgPBT2MGReNRCT?=
 =?us-ascii?Q?fP4Tt31OWDWJ8ok9b+LLsTYQhx1fyJr5vV0+rlHFMc9VA4FZcqK4qwTiFA3i?=
 =?us-ascii?Q?j9gNaLOdOhnt/EgcgygZTqFpyntKv1Ijf0OTTeqeTF0/4tk5zA0kwz1czfnQ?=
 =?us-ascii?Q?S2l85+Nd9XkpkNoEdHZofuf/FCCY8pYixDvemE7aQF2uhpfNx8kZi+yTZ1Zv?=
 =?us-ascii?Q?EcryAnitQ7eHzXkQzbImmAyAUC6K6cAbevT/dTdGjHi++su/fBi5vUC/o17u?=
 =?us-ascii?Q?JF1ROQGgw5zT19Hq18H4l6nTf17lhI3aA4QGD3MJMuZEgBGlI0gMEXrOD1dG?=
 =?us-ascii?Q?taqZ9EFhXlN7o4Wo/Mf6A/SN72qJDhtR6PBRUokj0gcfiK1xWymWwibh0hzR?=
 =?us-ascii?Q?6kHsjmQP1/Oxa7YOjk1sqcKuTyVG+Nn+y19sO/T3+heWakD6PjP2g36SXoNu?=
 =?us-ascii?Q?41JVh+0oag2gRo1Yuh40HlpPLFBnTyNMZGcbkTv/XwEeugx/5g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5003.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dLC5DajCljROUYk7x8j2wPGUdE7UbuJz0g/cu4epJUctGcAugKUdG4eYXv/l?=
 =?us-ascii?Q?IdTdwcg/sTHurREcyR1F+9jX3mv/9oR3ldRklYrlyS0eSc5tweOHRQkQY7si?=
 =?us-ascii?Q?3F269ofoETO2HHemjbtHSElurc9ZxR60oFRtv6S1sbNu0lLT6JEVDSjEmrqt?=
 =?us-ascii?Q?LEbh1zfXNY/4CcEXEp0qc+3FADo1U340YUdnmddj9ct60lS+zKRFtAxzQHOO?=
 =?us-ascii?Q?BmZ0PCYn4TvN54zKVhWFov2rStUi53d/4/N4QZ/EFy8ArjrJ3vA8wlbjuxNf?=
 =?us-ascii?Q?A75GS030aIVFnb65rX8TogLRrZdZSqkpxoQT9B/DxeAU9w8IZEsqfsi87eT+?=
 =?us-ascii?Q?Wqlo2H6jZKPge/LzajoPJTGHSjROdh5Od6Qei61KKwbLvxRoIxJie4O5rF0T?=
 =?us-ascii?Q?A01I9dtOOlCNMBWcP6wDPkbj4zHlRxm6zLqLI02OqFCM6TQv1SOcAMr5Xioh?=
 =?us-ascii?Q?sTb5ny0HwnbMNDP0qfptdXG54qy2YF0xPKa9NuoFGnkW4Dh6WsQXURz8psVg?=
 =?us-ascii?Q?IHuQV1h441VX9XB+b2H1uIP0CwEgrkz8PCG2dtsFNTkkXWZaegyXEJP+FIem?=
 =?us-ascii?Q?5LSQ2UcIsCmPzBelRwgMAEhr3n8ie5SjbWTZOVF1uVhCSt7OXdop+gIjBDed?=
 =?us-ascii?Q?vN6ZmS6rRqguchox/EF3TXy9I1t1HYxToD0ol7KvDsEMESRlGvMZQnr7YovM?=
 =?us-ascii?Q?DSauNv4V3WKfhqB4ru8UO1/2dTU7SmPAcVxcK9sRHIFTTwIV10dQRppgEmOd?=
 =?us-ascii?Q?1nO5sOw8bIvNrhJmMhqC9G0fb/6az86UbRaX65FAfjm7jysv0lFDWVKdXUvo?=
 =?us-ascii?Q?jCLYWIstD591kBiUly5kOAh+2/Ow5xo/3OCtsFxrT/I+YlHIMVVwqRCR1Vz3?=
 =?us-ascii?Q?FY5SdxAK+Dnn1xHHiGiBrK0Yg83dShSsX8V9cay557j+wtqrQ0T99rsVdkms?=
 =?us-ascii?Q?u26mXcylnij7v7zroaLbGF1NpEIz7Te5EarLEbz6FeuMawygt8V/0Yux5Xrh?=
 =?us-ascii?Q?R6N5WI+HSZmM3bYhEhFoZSBP2qbWaniyA7xqTyTPel8uArtFcBwyYvd02FkV?=
 =?us-ascii?Q?THyw7Ct61PWE9UdqeZ8/+P6DbRMf8HSpTEDf3cu3NcN4uS0kncVVb2wm3bTv?=
 =?us-ascii?Q?adU6g7Uc7uwlgOLflP92hzKrCg7ZybIcN8qwVi4m3ALfKDVNKFwpeaBynE9Y?=
 =?us-ascii?Q?A/F0oYoDaK/OByr9G/zyetl3tR2y9kQ4buz2ZVBqmQyTUnEdHnxwHLjOaofD?=
 =?us-ascii?Q?f6uEvpmaQ5L4EMuAIT8ruiS47tlQr1mL/K6SbCHUrVxqHZTIoGSuF7bcDorl?=
 =?us-ascii?Q?mGJQVinLz4CbfM8gX+fGCd3G1b8jafJ6J9jjkgquoQb56qotzMC+zkBc3PlM?=
 =?us-ascii?Q?+XGKGkFT22CWW6cshcChXpQckTdmVIKHouzwM6XYjaNk8pfU4R5JHafO3yqM?=
 =?us-ascii?Q?RJBp/+Un4gmIh9dvNskm03zxFFghiqgICKqyl/sK++TWjDXKf7sb4POWuTM/?=
 =?us-ascii?Q?zKcQq24XMblBdorMAMhltrlqLNGz1Id0Ja2neGotYIQ3bcNHPhKA9sc4pMi4?=
 =?us-ascii?Q?0NGTlbf8g0/DJtrOQbaMq6GI2M/3H0Ql0IjZlvu1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1e4978-5052-413e-9e11-08dcb6a6ef78
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5003.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 06:05:28.0482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u2xAgZFM73RepRaeqZidTOPYxp70+iuNRupE1kQvr8Pl3X9eh+N/hIAzgNThg+vXt9LcG+6aDunECuQNEwEXSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10696

From: Carlos Song <carlos.song@nxp.com>

According to I3C spec 6.2 Timing Specification, the Open Drain High Period
of SCL Clock timing for first broadcast address should be adjusted to 200ns
at least. I3C device working as i2c device will see the broadcast to close
its Spike Filter then change to work at I3C mode. After that I3C open drain
SCL high level should be adjusted back.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
- Fix set_speed description from Frank's comment
---
 drivers/i3c/master.c       | 12 ++++++++++++
 include/linux/i3c/master.h | 18 ++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 7028f03c2c42..6f3eb710a75d 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1868,6 +1868,12 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 		goto err_bus_cleanup;
 	}
 
+	if (master->ops->set_speed) {
+		ret = master->ops->set_speed(master, I3C_OPEN_DRAIN_SLOW_SPEED);
+		if (ret)
+			goto err_bus_cleanup;
+	}
+
 	/*
 	 * Reset all dynamic address that may have been assigned before
 	 * (assigned by the bootloader for example).
@@ -1876,6 +1882,12 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 	if (ret && ret != I3C_ERROR_M2)
 		goto err_bus_cleanup;
 
+	if (master->ops->set_speed) {
+		master->ops->set_speed(master, I3C_OPEN_DRAIN_NORMAL_SPEED);
+		if (ret)
+			goto err_bus_cleanup;
+	}
+
 	/* Disable all slave events before starting DAA. */
 	ret = i3c_master_disec_locked(master, I3C_BROADCAST_ADDR,
 				      I3C_CCC_EVENT_SIR | I3C_CCC_EVENT_MR |
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 074f632868d9..b8daf09a9a4a 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -277,6 +277,20 @@ enum i3c_bus_mode {
 	I3C_BUS_MODE_MIXED_SLOW,
 };
 
+/**
+ * enum i3c_open_drain_speed - I3C open drain speed
+ * @I3C_OPEN_DRAIN_SLOW_SPEED: Slow open drain speed for First Broadcast Address.
+ *				First Broadcast Address in this speed is visible to all I2C/I3C
+ *				devices on the I3C bus. I3C device working as a I2C device will
+ *				turn off its 50ns Spike Filter to change to work in I3C mode.
+ * @I3C_OPEN_DRAIN_NORMAL_SPEED: Normal open drain speed configured according to
+ *				I3C bus mode.
+ */
+enum i3c_open_drain_speed {
+	I3C_OPEN_DRAIN_SLOW_SPEED,
+	I3C_OPEN_DRAIN_NORMAL_SPEED,
+};
+
 /**
  * enum i3c_addr_slot_status - I3C address slot status
  * @I3C_ADDR_SLOT_FREE: address is free
@@ -436,6 +450,9 @@ struct i3c_bus {
  *		      NULL.
  * @enable_hotjoin: enable hot join event detect.
  * @disable_hotjoin: disable hot join event detect.
+ * @set_speed: adjust I3C bus speed, which is generally used for reducing the speed
+ *		for first broardcast address.
+ *
  */
 struct i3c_master_controller_ops {
 	int (*bus_init)(struct i3c_master_controller *master);
@@ -464,6 +481,7 @@ struct i3c_master_controller_ops {
 				 struct i3c_ibi_slot *slot);
 	int (*enable_hotjoin)(struct i3c_master_controller *master);
 	int (*disable_hotjoin)(struct i3c_master_controller *master);
+	int (*set_speed)(struct i3c_master_controller *master, enum i3c_open_drain_speed speed);
 };
 
 /**
-- 
2.34.1


