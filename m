Return-Path: <linux-kernel+bounces-295472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A92C5959B61
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD3971C2276E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A3E18991D;
	Wed, 21 Aug 2024 12:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="SZrGqbuf"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010010.outbound.protection.outlook.com [52.101.128.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1E91531D9;
	Wed, 21 Aug 2024 12:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724242310; cv=fail; b=fpKn42PshBQsnsagVFbR7EXsGKGce6u0ruNDvVBQKbUDGOolJ7dp1pTG+n+4t7NZvX6Ww88+pDHKBHhJ9AnvhqIAUuzmM267albkU/rPMe5vOkyTfLAhCantUeUA3mZdGhqa+fcpyBcBFKRWNNT6KsLN7G0WWHf3ea6VKqB4IOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724242310; c=relaxed/simple;
	bh=fGZ6zlJJOxFZIIjCCESUTydWXH+oyDtX7zal4/ijdjI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AqIDro8O4nUovwL2MjwOvIbAsm9YpNfYMW5XbROjKfsghsLEdjI4VbpfmHHhzUoW9h6clxVDKvwZS1Fc/LgkhgMD+dH79dZ4jHKmv7gZsm4qxeRaHAn0MLTCqQuiagIoQRRyFTvemcM2M+wq2f0naSL5hi3chwN1uEtf3Wne4Fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=SZrGqbuf; arc=fail smtp.client-ip=52.101.128.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vc1/QBXe6oQiSKNiOSxtV31B84jLxxp6TKvCqHSj5l6LUTwZLGhU1L8FSIF5nuVTEUC4sM+i3gYcnxkqd7kxSGLWOGs/Bz4i2V8l7hqWGwy6BtbuHwVTdIgJ6YVZb7X3udJx1fJ3AcaK+uFE95syT0jKfEIfgJVuy3CpxG7ZNJBPcRvIlbEbpGcn6jUDQXMch07MEXTu7DugQOnfXEkyMVAIOCsi6jQBe3MQeZXlQy7o7iu1k6OJkVKWXoYw/r4pL72hOJ075nKZz2n2jLJEwv5Cue6JqiWvOIeZ7MMXOzBl6bQAev9IIn3qArTQcjpdrMFpOgbqEOgsaMuN5Hh7KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hr9lUsUOL5FatKa34vJPp7XDyXAr3LjTXLog6sd0XVk=;
 b=YW95F2HkIbVXuPhfgMjoIxaa8hBds61akX8I41WRM6vTxov8t2jlI/sr1XZYmKMFkmvfsbLDO3Gynl6rlqJJKl6BTt+iB0k4SmSvnjmwXDF3xRm8CWV8HOeikw2jq5BZ2DLWvEhxYlmMHMkj+zAq9gwu32jtRtAtjUZXpPk2dKlnqN/V3rjkp50Ki+WClX7IRtgaZz9MijGETTwCcwjFjFdaJrVLBzcwit+ctZPUQHI3H03kRa0Y/8OHJA30zfJcFT+o5WNaa1Z1X3C7BFw9rPkITJWdw7Juop6BQNJKWse1cSFdUcJaQpTyw94+VmS4BKMj8HlkdYh3cjhnEBtoZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hr9lUsUOL5FatKa34vJPp7XDyXAr3LjTXLog6sd0XVk=;
 b=SZrGqbuffy/nVZMIoPf9Trbkzz08PfizSFmnSI5oa7ibV4oINKT/YYBDBPpjndxG31g5F49xw2QbjiZafxbQLWRZVW713KiZPZJ5BrauW497xy7zK+KAmrudrRnjTbljXdxRWLNpIx0spJsyQ2gyZGh0eMnLZ87SskdK0wyjv5Gjj4NX3OtGj/fZ0gtof2iJH4OcWvxxOPplVIxapBy7xjc0pOxUSf2IVt3PoafgS4iCbLPfT7p3lZ+grD1FHI/AA13d0lTCgGEUpwuV3DG1EzX5bECqElKDq9m9GhN5QYgvAl2ndaLf3cFvZaq3TL2IeDy50kkPwOgHUiPBsCouTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
 by SEZPR06MB5667.apcprd06.prod.outlook.com (2603:1096:101:9f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Wed, 21 Aug
 2024 12:11:43 +0000
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd]) by SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd%4]) with mapi id 15.20.7875.023; Wed, 21 Aug 2024
 12:11:43 +0000
From: Lei Liu <liulei.rjpt@vivo.com>
To: Neal Liu <neal_liu@aspeedtech.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Bin Liu <b-liu@ti.com>,
	Lei Liu <liulei.rjpt@vivo.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-aspeed@lists.ozlabs.org,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH 5/5] usb: ux500: Use devm_clk_get_enabled() helpers
Date: Wed, 21 Aug 2024 20:10:43 +0800
Message-Id: <20240821121048.31566-6-liulei.rjpt@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821121048.31566-1-liulei.rjpt@vivo.com>
References: <20240821121048.31566-1-liulei.rjpt@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0069.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::17) To SEZPR06MB5624.apcprd06.prod.outlook.com
 (2603:1096:101:c8::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5624:EE_|SEZPR06MB5667:EE_
X-MS-Office365-Filtering-Correlation-Id: a6ddf385-d6f2-486f-c42e-08dcc1da6bb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|52116014|921020|38350700014|41080700001;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?696MO/WVQtxEfg78n1QlffVBNcABEXvumbU+j+ngDD1/KGrMkVlTpC7J6F49?=
 =?us-ascii?Q?QsngrYK6BtAf8lt32xfrb2d4mFTRmI0MoT2Bc0ERHF3t+JBSs9iwwgX4fCgW?=
 =?us-ascii?Q?2n5iaIcbTkUgZJUbmxPi7cUStO77V/4gwCHvQ9oBirU2AGedBY36OSw9evSj?=
 =?us-ascii?Q?uozw5dhcWupDgap6LnS4eyY/B5CVEdC7iX05WMDarBd902zQ5B7JihqLQKal?=
 =?us-ascii?Q?X1QY3eiiZq+ro4pFzCA/IKTee4pqAoQi+z5R3odA0y21DNLhnEb/3C1LtC/b?=
 =?us-ascii?Q?5ZWE684cTQEbmpokkWnsq8+w17+7ReDIh/tQslNzOTmx5rtRtogRq6Ndk9Os?=
 =?us-ascii?Q?uwHNbytUShEXMNnsdl6eYpNqmigof9fRO/HKLl0bZveQ4dIQdB4mhs0e2Olb?=
 =?us-ascii?Q?GambsvFNkWJCv+Uh6cXEaKN2QXX7pPwHFVrMXoGX9McItFCGVtyK5ZYfxJB8?=
 =?us-ascii?Q?4WAAweDH4Ni2MHTMgoh2sgN898M3IljEXP9sVSWb+JdX7DI43frDJ0qBCDy/?=
 =?us-ascii?Q?kl9SN/hYJdtlrMOAE88wRLNRjJAtFP1/1G7ALjXdQraPQSO4+GDmg05iv9Qu?=
 =?us-ascii?Q?kwT0c2Ga+Hcssj6LQ1xe51JOblvdYWFCj7bPZw44bKN3HtkRxGff9mA8VZGU?=
 =?us-ascii?Q?5A00jA7VGSf5DMJ2W00Lo4Ger08k7ujA3syekTaua0tHT5/drvR1rhtgxrON?=
 =?us-ascii?Q?679ft3I9ONXjEHyEa0OycSLcaINEAKNL3dCoSk4sLUsX/74rgZSKiSsWGYjg?=
 =?us-ascii?Q?0ksxwEUoZj69ETVYen4JR70u+9GPNzV0IHd8Ve0CamwdDCtNKKig4S//LPq/?=
 =?us-ascii?Q?FZ1xwHADSKD7FpvC2AsO2Rc1ef1K+dGx81PYmVx8JPkQUaY+3hcps6ScAUg/?=
 =?us-ascii?Q?DFI0ZCRoplLY8dPtOm5ktQ33Z4WFJ8pMUAE5MStLos53mFJn2F8ykJzk4x9g?=
 =?us-ascii?Q?PtW7UnBKT5pQc/2ql5qZN0l0opFGgoc5kBgYJGpaCQsk2cV5GndUihZ+trnu?=
 =?us-ascii?Q?Aeb0GPDe35alfdRA5rp739xm7s9Gh9M/NpzikDzU67XiZUEuJQuejsnzK5pp?=
 =?us-ascii?Q?L/hD4sVeZVXUGoxrK1o7F7/hX31WiByuj/NJl8wk0OINMPXF61V6qRte5272?=
 =?us-ascii?Q?pRNskyQ6CgIMAaj4Vc1ieWCU1z1KecJXzIsLPxVnzhWh7+YF1vSXNYodCO+f?=
 =?us-ascii?Q?5PHAKKPN3jeumf79kebd61fQkjGpEEj9wAq5oVi2xikzozks95N2S32k19WY?=
 =?us-ascii?Q?iQbDOanrnV9WvVKd7XDCswcRxb4toNfPq2k0Smo7v5bJw/Vz6rdXMO+I4bqk?=
 =?us-ascii?Q?CjL9AsVXfFmpb3hJF/rQQqaTkjyrAJPd055Dlgy2jnZC7kKJwLAy2nSpVHZk?=
 =?us-ascii?Q?DT0ESVzTrODbyHX7bDxksCe2RwBrm+l5BCu+Ocqt+h5nSEsgq08FGmaMfEkS?=
 =?us-ascii?Q?A7yZ7y0i/qnAY1l0IKQiECBYvxuDy1rg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5624.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(52116014)(921020)(38350700014)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hg32QiKcC9kdOioPCQm/oq7phMBuZ3WB2FD34djLIRHmIEoxVmEOTmhawK0C?=
 =?us-ascii?Q?0Hu9R3sMhsvXeF0iXG8rsrDmvwH7zj1hYiP1EDvRBVZ+7Zsqy/h5+JDNGz4W?=
 =?us-ascii?Q?M0JoDAYSmQ94+F5rj/siUjK1gJVWQ0OnnPpAKugFyT6oxMdGsYdQGOKdole0?=
 =?us-ascii?Q?Fmd3uXXl+We8u/L+NNkBf/qOfvJFiW89M4fHgS+058r1BOhV0BlVGxPBYBLu?=
 =?us-ascii?Q?rZYoBVUyliDLwjCpYAEi1Kphd9LubZBhGp/Hq7cpzhoFFmdW5JYEw0w6rmqZ?=
 =?us-ascii?Q?z2+3xX7yFvu+r0/qB7IkWKOiy8CC3wb2Lwrey1Qd/H2ypZAJpca87Kr7WMBd?=
 =?us-ascii?Q?l/EDpaC8FV44aDtne4OWejAGUqFw0GKqLQ4BJAwkeCgLNGapPubX9hVHCtTX?=
 =?us-ascii?Q?034zOc/A6ceJkAwMBD2QGXPG5TPCDTAF4gACq08viuPQEvTneT4BPZQC0a2u?=
 =?us-ascii?Q?oMaHB6kf7Ocq8Sve9XaPXJ2+jhNwWJwtODn3J/jWoIJPtpq9ooN4i7M8VkFh?=
 =?us-ascii?Q?/HjMi830pZKhVi6GakFCujlpP4kw59lNgq/wmhBB7y1TyGAVZy+ZqNBSo81U?=
 =?us-ascii?Q?rJ1DhjOEZazMFKkWfshp1JleXPzq0teyLPwbkQKNWNoFu6+fwdw/pXZgQXqn?=
 =?us-ascii?Q?I1R23kltGI4DP20FwvqI7aUsfmsKaMLIE70sZziPIIgTo2BiJwd+L2Y8hyaZ?=
 =?us-ascii?Q?2K1lL3MP6YUM71Y3jLK+8CBesdbyMf7fggasa6oyUz/UvPxTYrTU5TM9wc0M?=
 =?us-ascii?Q?iD+e3ClVFtepN5EVuo3N1UF7yVxgGj86MUhWuZM9D8cdQqOKnfyzAIEdVKdV?=
 =?us-ascii?Q?ZCDWsKJGZAt2dABmr/YiNHeCqY/xxTT8dNDCi7pBZFAL7ZxHl0z/r1wfnxrm?=
 =?us-ascii?Q?b4BbDTcn48wWrNwLEbYAbYO7l/CQXq3byz9dQDmBbAD7Pl5uYcTD6ksnv6+N?=
 =?us-ascii?Q?km+Xyyx6OqwNOXL29muFPqi6mU+6r4gFVSSnECmI+RmNHN/fX3gbWnKdi9/l?=
 =?us-ascii?Q?Uak/Q3Ra5TsCEMfEiiNkdB/x6OnigGK7CUdxr+cr63wGxAiKxehbgS/1s/FH?=
 =?us-ascii?Q?KubiVJlkg9GDOkOUC/H+eOaGvAjsMjVRrhAGoY4AjOLosE/HQBMwkYq/kRAE?=
 =?us-ascii?Q?QuLJUoZkf6Lw/vgymcIzy+D0+MRDRqBH6Tc/naEtxYuuR55K5ZyLxYBR8dub?=
 =?us-ascii?Q?Vm2POkntKgMfVhDe/pKabmquF/HpQVmmHDaIFLCgxYL9Eh7/mWmkJPvhcnFW?=
 =?us-ascii?Q?MkAH4YV3e3s7je4ZvvuTLT90240O5N1Q54IOilfTIRoAmzvewHeOGy+DNtry?=
 =?us-ascii?Q?VpOPCy2hFJ5IZTCsDGKDltd8SgUGfOPUCoWDodoVo0pBKznvl7xSs/39X49G?=
 =?us-ascii?Q?jZnJaKClY3G6Hruzz2lLrjUDsGpdg8fVHIagfFMZiqQ595cIFmT78PSjTaMv?=
 =?us-ascii?Q?akZQy85HXpFJrBK057Zu1IxQTG5BBSVGx1Z6ae/jeLpKCDljm28X3OYPKFYJ?=
 =?us-ascii?Q?2cqGWP+QWdYuo4ggUzA3nCPq3vU1s7cqKH5uovEe1Yuo/CIl/1iwUXUeJnuU?=
 =?us-ascii?Q?FSTt2KwBGpogQzfszIij1S40ZNqIVZjp/zvXnnZO?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ddf385-d6f2-486f-c42e-08dcc1da6bb5
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5624.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 12:11:43.5801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7En1z/iJdBdBoxS7EU6Ga9CUDZLSsNVTSSetRUu1g++2hPH4/8ys4RK0jTNP1XiKQHsfRgErpBsTm+hSbHlFdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5667

The devm_clk_get_enabled() helpers:
    - call devm_clk_get()
    - call clk_prepare_enable() and register what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids calls to clk_disable_unprepare().

Signed-off-by: Lei Liu <liulei.rjpt@vivo.com>
---
 drivers/usb/musb/ux500.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/musb/ux500.c b/drivers/usb/musb/ux500.c
index c8d9d2a1d2f0..51ce67678c0c 100644
--- a/drivers/usb/musb/ux500.c
+++ b/drivers/usb/musb/ux500.c
@@ -246,19 +246,13 @@ static int ux500_probe(struct platform_device *pdev)
 		goto err0;
 	}
 
-	clk = devm_clk_get(&pdev->dev, NULL);
+	clk = clk_prepare_enable(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "failed to get clock\n");
 		ret = PTR_ERR(clk);
 		goto err1;
 	}
 
-	ret = clk_prepare_enable(clk);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to enable clock\n");
-		goto err1;
-	}
-
 	musb->dev.parent		= &pdev->dev;
 	musb->dev.dma_mask		= &pdev->dev.coherent_dma_mask;
 	musb->dev.coherent_dma_mask	= pdev->dev.coherent_dma_mask;
@@ -276,26 +270,23 @@ static int ux500_probe(struct platform_device *pdev)
 	ret = platform_device_add_resources(musb, pdev->resource, pdev->num_resources);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add resources\n");
-		goto err2;
+		goto err1;
 	}
 
 	ret = platform_device_add_data(musb, pdata, sizeof(*pdata));
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add platform_data\n");
-		goto err2;
+		goto err1;
 	}
 
 	ret = platform_device_add(musb);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register musb device\n");
-		goto err2;
+		goto err1;
 	}
 
 	return 0;
 
-err2:
-	clk_disable_unprepare(clk);
-
 err1:
 	platform_device_put(musb);
 
@@ -308,7 +299,6 @@ static void ux500_remove(struct platform_device *pdev)
 	struct ux500_glue	*glue = platform_get_drvdata(pdev);
 
 	platform_device_unregister(glue->musb);
-	clk_disable_unprepare(glue->clk);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.34.1


