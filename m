Return-Path: <linux-kernel+bounces-295471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9F5959B5D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C639B1F238AF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEBA1D130C;
	Wed, 21 Aug 2024 12:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Fb5vbOLm"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2088.outbound.protection.outlook.com [40.107.117.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1A91D1317;
	Wed, 21 Aug 2024 12:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724242299; cv=fail; b=ARB1z6JrYeMhcsCcp4UDjCskB664symUUlR82BztrUOAdP0e1A/4lRK250XxAdufZpGHHaYBcFpe/ykUVNmzX8sfChWOvlCEYicBHgobrt0xEHhrbzIK0eqDZI2LmAfwHC890P1qP7IM00Yey5wJIKnSTvuwc7qphNqu71RdpYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724242299; c=relaxed/simple;
	bh=ezbemOPagKdSPF8hynV9cV5A8MPYmNQytEx6q4svV0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HdKb9oLemDdMlJL4V+DOWbYkBc3jYAtm/3D+p0T7jJKouEmHrPUnwaRQ8hYXn7PhzZSMNFxqCrUbqqSfG+RG+RmaAMN85PczlkVT5CVTQHMvoF3n+c6kctlaE5nP8ezQ1XUhX2ZsPm1GXe1hYetZzIWa+6N21CEN6rTaJ1N7nIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Fb5vbOLm; arc=fail smtp.client-ip=40.107.117.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VWn8B65voyh3hNIf/TReIGjFqMc1hkEMke5msiVy5fXKjEt4FE1okyk0vKGbsBSIscTT0SXykrFBRhlux/vGhiHss2X8Ua1Yp3MJHXKXrwnEM0wRVOtM0c22ZGY+b6bN6E+BGHMhCJ29MDi0AMhC4Dys22uCxJKHJQOibKFyp0kXgjhqr1SklWFDF0JlsT7AusjxjfUBza1wYNRovYueZoyWDsBekxJbj0AMiBwvHjMz4IQJI0LXv7y3M7OVZzTiH6QRXZrLsx53Rg1wgqXgB3DQBUfSuJkIE0BFPT8G3nfyYOkb4aKNCGx2Cz8CWGvPDslKnY1T3LGgjKZ4753o2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dsWSeDLZchiIY6ePE2w9Udp0YVknhkAQDbpJe39jeVY=;
 b=B9Q+KTNAxmPgK6aEx8e2u6lxaMEyguP/JTPWn5J2CR0/dRN8e9lgPBjBEe0CKsSLdA9XmbWs+fl6ouSa+mKjkF3U154gRRDGpOCo3dSXr97Xp9xTUBdOk8ee4uJIUxNjU6I1XA575jDLed3mrZyyIUtGW5JoNNNtW43zbYQr45LUIidxUnTr8xUYDg59Z58vpNn8XSY39lqlkr8TdDhXPtoG6m/Ch2BN0ZtTqhmqTiNaK9xFeAyl6Wb7D7F35jwFVPU4uZoEK1rpQvjTbzXt3cQ9cguyhiInDQCFLzWiXOuuE+n582PmK+9ahcwKdcslsSvMHQAaftlVkiUK/O12qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsWSeDLZchiIY6ePE2w9Udp0YVknhkAQDbpJe39jeVY=;
 b=Fb5vbOLmNBUy7UsoIbHx6n9EY2O+0MxJ8k5eNIqt73DaI+fHQI7Cqqbv0lSfw37trbiVR5Y/+l/1r2AxKZuYRZB+wj1FWMGrPLt79+wrgziRwiJYmLnlv/5FtVXepIlRBQCP2fam3wSxjiF7kEWyxVkZnJcme7yT55P8U0IoIpmawoo1bZ/efOsecxEFiK0zhVK4X1xMX/9y92MInFeuPn6rJa/dCkmvaP5/Z1v2B+vb2VFm0lCjyBGhreDhd2q+AeeSAxf99yJUXw8JCVawz+mxO6navpk9IQ6qNInr+hVOzmtkMHjLaNRkjm6kq44tzUzzMqZnyXkEfONVncKigQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
 by JH0PR06MB7128.apcprd06.prod.outlook.com (2603:1096:990:8e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Wed, 21 Aug
 2024 12:11:35 +0000
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd]) by SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd%4]) with mapi id 15.20.7875.023; Wed, 21 Aug 2024
 12:11:35 +0000
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
Subject: [PATCH 4/5] usb: mpfs: Use devm_clk_get_enabled() helpers
Date: Wed, 21 Aug 2024 20:10:42 +0800
Message-Id: <20240821121048.31566-5-liulei.rjpt@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5624:EE_|JH0PR06MB7128:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c75f13a-b1fb-4630-6566-08dcc1da668e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|921020|38350700014|41080700001;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G5Lb6B80RvC3zNbZwIT3Ko+6s9Xs2YOQOqNUAT7pd5C7HWaxviqn37z2aePB?=
 =?us-ascii?Q?WipAl6MiyNnSTPwGYfmpSTtKWzNdkDKR9GGAWEyBPz/5EGi2R+AdLKg1+yVa?=
 =?us-ascii?Q?39l/soj5x2H/Eie3eJ6C3tlNFLPOQOqmTkMhgFSVPPVhCY1l6iD3II9CCdjp?=
 =?us-ascii?Q?Aqz2HHQjF22fWq4/1bx9eLUDoXbG6KXezaTLQmJlLGBF6ei7nfSt5TyRr8iP?=
 =?us-ascii?Q?akx6GtqDsYLUlVHWlAsRCfp1aRfV6OZ7+lz/nXnBLyhNqoB3XpQeRkSZLU+H?=
 =?us-ascii?Q?BR1DhTLAwaKTXKvl3rWBg2x2kuAeThDDhQ54IKn/Wv0/bsM7nw29ZzybKrUN?=
 =?us-ascii?Q?dp+t5QGK0i6AvfAA2AB26Eqq+VZiQHYfxOhmMj/FORUIxwypCQEHW5NyUu12?=
 =?us-ascii?Q?bzqSHLVV+50okS7lAXtKj+rGZpvXd+I58ZisxfxIYwb1woIK8bRuALnkp9lP?=
 =?us-ascii?Q?Ddv6YHcRioy1ZP5mYs2LlW2F6Sbhue47xg8GpAdpk2jPrNDsLII+Etw4Kken?=
 =?us-ascii?Q?qPP1Fj+o0QZQZl047vqOAndOqqQ84UadXij5l9DBGa/cb9+X6Zu+648pgwxa?=
 =?us-ascii?Q?DXqcfhNENdLOQ8Rot5uk4YociZzCMVAhObBHrvgwIgLmKGFZ0qgiNSA9inUx?=
 =?us-ascii?Q?YhUevyasQbN2Lfe7O6kH9tS5ojVe2OKgzMb8DXFSVWAPOS59aU6Ib3xffgfG?=
 =?us-ascii?Q?hqODkmMTJimq+G8v8IT/LbCaOWFHEhsI/vmixDzsaLhq5SqOmu55euabi9Pl?=
 =?us-ascii?Q?j7L5o/b5zMBNO3ryiOkHoNGD0iv3eXJUZz3RDEOX3Rpd7JEKtnpNf9vlirKw?=
 =?us-ascii?Q?tgogYZ7WZnTuiyYkotH/c71bBCXzcrQXbhipk63M0bffBmVwiQ/9WNTycojj?=
 =?us-ascii?Q?TFnM8xnGWfJjAXL/CPhwTKGWHDAOd7+sMU8Ykaso5byGttL2bJCwE8ZURF9u?=
 =?us-ascii?Q?f6LUTMdmeDkLUMrg+dd1/mxkRZ19Tn97dGYF3si+YRn7wHDfqIEwdry+UIyN?=
 =?us-ascii?Q?qPD/RxFzLh88ikDAro7jRn8HolxN6QhLJzA8ppTVUiPCosDZgpRUpn0sxQeD?=
 =?us-ascii?Q?fhKYLBYLRwrA5qoEQpxbjCE0jfjzZD9bZKGU10oSmbkuhU1C9p6PPQp+cU1a?=
 =?us-ascii?Q?+5M602MKts0ecKs1CkEltqJ4M7MuvG82/+UFK9uI/3exrqn46K4rWnh+MUkl?=
 =?us-ascii?Q?3ijJ4JrlShSBfF9pYcfkgl82bJdZXTQxFtKTfaad4yqqJ/wKWxpDfa96zhmX?=
 =?us-ascii?Q?bPbn8yuRhbv0vYkM6TdnQHG5pyj/D5/tflwN4fGLH+Mp3M/MDcBfNec5GECk?=
 =?us-ascii?Q?UhmI6lcgdUxskIY4vnJLJQWHimDWiXMh4eno3XcQ8CDW20XpN7Kf7pMfRw0c?=
 =?us-ascii?Q?sfiW2wUwSRnDAbzxpSoookjSwW6fAoK2iUAsp3RLrbzrokkQlplVTM7HhPYU?=
 =?us-ascii?Q?KSRhW0qXtCMPxWZUQZYzLiZVPkMlD2Mt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5624.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(921020)(38350700014)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B7rw34+ly8UBlm4Zx90hT82dUiyHQbGxzy6DvMt1ifwOBXgG9URZtqJUWKSi?=
 =?us-ascii?Q?HwFD4gSVoqB4JHGCJ47mBxYvITjqK5OKbNVWHw0lm/9w3m3Yi70w7wTHeO87?=
 =?us-ascii?Q?hGVcamLeQb9qgmV4OjclFzV6xZm+rtfY6TYiZthSfUxqN9WP9vK/Bl6I2MAL?=
 =?us-ascii?Q?qA72rdvdl4jaHncFbPZjjC149GFwdyx+jY+/11NPJboziCPoLtIJLsh8ojnr?=
 =?us-ascii?Q?HbpYAH/n8i58w6UINttj0khuLdfCCcAA80TaVA/+Vskqe5fQ+oARKFRai75m?=
 =?us-ascii?Q?Fws5HhaDS9OeyqLBuJjE4/bm6a7+qmAvRGYAbRNfOVrBDfRWJ1sTr+PQEgoP?=
 =?us-ascii?Q?YlIb3imD4Qgo4P2pkQdoVQxf21Jk0RTnp3fBpgVpWo0WTS9Uo2SbVwcLvudY?=
 =?us-ascii?Q?YyVwbG9QVPisyu4m3LMFrUjH0Ed42KgOCLHRrDh7m6K3Z4Q6U0K0GWeVFKat?=
 =?us-ascii?Q?2mjn4ZaSMRxKt+l+8yXWFU6N7RcK+rTv/zXdrFyby3JKmaxk+0Ex61gpn94B?=
 =?us-ascii?Q?vKMe5zk4VJaralB5/wD6pIccu0MZIRQ7pbkX/w4tlAMpDX6lTDyD9WJucJhd?=
 =?us-ascii?Q?72vP8tTGEVh9KV+yM5NA8+dFKHP1job74QyhWlpGV7lpkaJ5qo3ARWE5TTXO?=
 =?us-ascii?Q?Qr/YM30cDGi6sYuhLylFWNrtT/wYXdp1/CGaliU26ptx5sybcbE4I+sxalyV?=
 =?us-ascii?Q?uJxJ10+ySSwGKlYwV+O6U7KSCWVA3Gm4DOXzHiuswdBhyzJx93zuRne95NEE?=
 =?us-ascii?Q?nzZiEQhCHU0LG1ExRJwZm01MeMUFfjmnS/n9VvsQEyo5AgE72NcGmMJpk17f?=
 =?us-ascii?Q?EOw+Wdis63sEd4T5Ynu6KuTBzGmFHOtAIagcT+PWhUBBjM0TGQYWmSq+epkh?=
 =?us-ascii?Q?WWC/ov+ioqCAuSDzVkeBUuUD/ZI6GZMnsY7+oK/l5I1+fOp2FJBNM683goPm?=
 =?us-ascii?Q?6XBgtvsOq5yu7hJ3V12/wHVCIHro46yanxG/l4/sby/vZU0MX8Qpj7mW5wtd?=
 =?us-ascii?Q?ze9oGk3phTaT7UlGAyMHyPMYfwhIxJ3Ou22cxlwc+9JImX0Z47H1DIxUkhRG?=
 =?us-ascii?Q?4RsXQWwsYtp10Bs6KUjV46fH0WlPeoYlqeWa9ZBNcwALVsAZb8SFB1Hhr4rY?=
 =?us-ascii?Q?Kb//4+6WgcWJeTI5JckGQvt4PcWXmZjZy9XCLd+JDu0AsJyWo9MCRPWriJD9?=
 =?us-ascii?Q?uPSnK6Hj1mzSV00hRIM9doWw6pn7GO3/RIIEt8scCFyD1w5O9SIcyh2lZ+b8?=
 =?us-ascii?Q?E+iecQU1Cz+bSmqHGnrIDC+K/rX5YXVOw7RJJfvL88XzFE19OxSc4qaOlNKp?=
 =?us-ascii?Q?e8i+86IDCs1IvKGX+Lv2j6VrBtq/2AA9NzT2gk+XQ5WUSamRDlfg5fhYDaqP?=
 =?us-ascii?Q?nQqyA2I4Gp5YlOYiWydre3fA0MCzDbQkEpouHOdqZWANS15yd8D4h/X9kU2P?=
 =?us-ascii?Q?wk6JP1rtNZ/4FTjxYscsXYBUlPNdXFkH8nttQ4GDC/bz/ktKdmgBo46ISiRg?=
 =?us-ascii?Q?48afLdkYdxYzgyd2OATHHH4hHoghPlOf9Zv7oIDHqd8WKDZE5jpGgoPn5ndo?=
 =?us-ascii?Q?4ZQpjkv24BhQxAor3/fA0xqryTSksd56R3u1pNiI?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c75f13a-b1fb-4630-6566-08dcc1da668e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5624.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 12:11:34.9206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ntxx0EBxIUiEERee1aCnlqRW/GQ7BFw5hwMoSFe0zI0mvTaKfng3UJAvMuBRGZ3Y8DGsW13m70YQvTf1Y6OsqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7128

The devm_clk_get_enabled() helpers:
    - call devm_clk_get()
    - call clk_prepare_enable() and register what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids calls to clk_disable_unprepare().

Signed-off-by: Lei Liu <liulei.rjpt@vivo.com>
---
 drivers/usb/musb/mpfs.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/musb/mpfs.c b/drivers/usb/musb/mpfs.c
index 29c7e5cdb230..06faf5ab22e6 100644
--- a/drivers/usb/musb/mpfs.c
+++ b/drivers/usb/musb/mpfs.c
@@ -159,19 +159,13 @@ static int mpfs_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	clk = devm_clk_get(&pdev->dev, NULL);
+	clk = devm_clk_get_enable(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "failed to get clock\n");
 		ret = PTR_ERR(clk);
 		goto err_phy_release;
 	}
 
-	ret = clk_prepare_enable(clk);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to enable clock\n");
-		goto err_phy_release;
-	}
-
 	musb_pdev->dev.parent = dev;
 	musb_pdev->dev.coherent_dma_mask = DMA_BIT_MASK(39);
 	musb_pdev->dev.dma_mask = &musb_pdev->dev.coherent_dma_mask;
@@ -184,7 +178,7 @@ static int mpfs_probe(struct platform_device *pdev)
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata) {
 		ret = -ENOMEM;
-		goto err_clk_disable;
+		goto err_phy_release;
 	}
 
 	pdata->config = &mpfs_musb_hdrc_config;
@@ -203,7 +197,7 @@ static int mpfs_probe(struct platform_device *pdev)
 		dev_err(dev, "failed to register usb-phy %ld\n",
 			PTR_ERR(glue->phy));
 		ret = PTR_ERR(glue->phy);
-		goto err_clk_disable;
+		goto err_phy_release;
 	}
 
 	platform_set_drvdata(pdev, glue);
@@ -211,27 +205,24 @@ static int mpfs_probe(struct platform_device *pdev)
 	ret = platform_device_add_resources(musb_pdev, pdev->resource, pdev->num_resources);
 	if (ret) {
 		dev_err(dev, "failed to add resources\n");
-		goto err_clk_disable;
+		goto err_phy_release;
 	}
 
 	ret = platform_device_add_data(musb_pdev, pdata, sizeof(*pdata));
 	if (ret) {
 		dev_err(dev, "failed to add platform_data\n");
-		goto err_clk_disable;
+		goto err_phy_release;
 	}
 
 	ret = platform_device_add(musb_pdev);
 	if (ret) {
 		dev_err(dev, "failed to register musb device\n");
-		goto err_clk_disable;
+		goto err_phy_release;
 	}
 
 	dev_info(&pdev->dev, "Registered MPFS MUSB driver\n");
 	return 0;
 
-err_clk_disable:
-	clk_disable_unprepare(clk);
-
 err_phy_release:
 	usb_phy_generic_unregister(glue->phy);
 	platform_device_put(musb_pdev);
@@ -242,7 +233,6 @@ static void mpfs_remove(struct platform_device *pdev)
 {
 	struct mpfs_glue *glue = platform_get_drvdata(pdev);
 
-	clk_disable_unprepare(glue->clk);
 	platform_device_unregister(glue->musb);
 	usb_phy_generic_unregister(pdev);
 }
-- 
2.34.1


