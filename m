Return-Path: <linux-kernel+bounces-296586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4783995AC6B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 06:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7FFC1F2534B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 04:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589CA81727;
	Thu, 22 Aug 2024 04:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Kd+pjPZ0"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2061.outbound.protection.outlook.com [40.107.215.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B199877104;
	Thu, 22 Aug 2024 04:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724299707; cv=fail; b=SSpH5L/p6175uQQPL651YlmQCuTQDGUjtsuf7IUUoVLgFV40j26ZB1ZRdqRunukhunjPdj1YLwTWRvdP90NYw4EfnsZDUmzrltCa5n6PUfcnJkxUi9ozGJOCxCAR8I13jT+2Vu5ArFMoZIJ/WPmdtv12mT9yK7CEzRSt84Oox0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724299707; c=relaxed/simple;
	bh=+btn2TRBpk4XTqU7SGe0q9BZGXex+FIb6C6h4nuWKBs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EYKmzNIKV9Xe6Ap0IylAvlrbDKfddcjktyuQhf6zqWkGRQkIkG8fnCTQ05qB0ktlhCYvVJVeCelbN0Npba5Gp7X3NzXAQFhvuROBHvjd+7v4KDSacFig1zxK6NVm2RPeut5bwjuA9gaiNvj/K1+2zGPLXPTyyzt2rEoXO49XpSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Kd+pjPZ0; arc=fail smtp.client-ip=40.107.215.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PmMbXHig04ai/z6L0U1Ybiwdc4H0n/PEYE+XSYWSwRSFD7vUrb10d9/WvwGF70lFfaDCuVGDrkdmiwXZw6Zp59oftVg5hn9z5bP4ax1lQch0GBJJjwHAx5eq1w3/pyQ7S+QutHx6PPzaOamcc+kW2IzrVp4sA8A20834bCtAdJPgRkZ39wBHfUXS5j6cpLIkvtipnzEb+QBRsgMcMcJnr8t76Ne3kUOy25UKUS61yKSFhv2E1NW/gybrfW817rIAZeo6qOhPg66jSEVjIcabTMpTPdIxHIhNyvBF2NHfz+1pvw6RZlj22hiiSwQJBq0uG8GUIe8J1kJZX3cZbdlwTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U66r+/XDGd8ba4fl6mZskdUS0Dc0b0JN/6atOXTbsEA=;
 b=L6tLJcGzej2nxV1+5fv5XtFOEeYWMrU63b1hmrWVYwwD1iDZ53/DAljpJ0kEIXgViJVeGXZmtw+pcBSjSmfzzfMf9jjzebXH53Bh1FkS3w/sMRqww++VaCx41GxsO370JjfXfyxTiUBUMfJgaGERNRFLh28G/2y6WaozZdf81EE/Vh0YkVsurGD/rcvDivwv4yajkd4u09p/ucal26RI+ch2gSDV+m3DEYf7Mv9h3ivT9H9Vmb3bAmA/QdRlMh1/jo9UbRviW6wA5nlw9JlTCt/y3aeTy0T/8WrDhnZ7ssiYxMx34mZbDGP2rGVFx2/eEvJlLdL93/GNKKThhOzbFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U66r+/XDGd8ba4fl6mZskdUS0Dc0b0JN/6atOXTbsEA=;
 b=Kd+pjPZ0XS1QCq37Nj8DYhzSjfLfRJkbecztHCati38bgf+UaS1QGq2DiZwzl2XhV72g9WvxIAZAmDMnIkcF+9619nBHL2lGJiQNNlDd0q4zM/ufxVGZgcqtr+X3zYDBTNee11CR74ifVGNwsEvMRjGfaLChJcR/FjoXnpU6YnTWJkTzIkcOIBOhfNnn+u1pPGG8G4Vt1+3wICAs8MR9O0dreVJqXm20G2Jm616LaZO0s8TyRK0ZXtzshEF8J5dvftENmRp86Hurjo8gaKFCYjpVD9oTIRtdEs2Zcfuxnmcl8zgGpAtO7ke2EDo5pcy2vl6LZ9K0hMI71V3TFwmyiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5620.apcprd06.prod.outlook.com (2603:1096:301:ee::9)
 by TYSPR06MB7134.apcprd06.prod.outlook.com (2603:1096:405:8b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Thu, 22 Aug
 2024 04:08:21 +0000
Received: from PUZPR06MB5620.apcprd06.prod.outlook.com
 ([fe80::b771:8e9f:2fb:ee83]) by PUZPR06MB5620.apcprd06.prod.outlook.com
 ([fe80::b771:8e9f:2fb:ee83%7]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 04:08:21 +0000
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
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-aspeed@lists.ozlabs.org,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: opensource.kernel@vivo.com,
	Lei Liu <liulei.rjpt@vivo.com>
Subject: [PATCH v1 5/5] usb: ux500: Use devm_clk_get_enabled() helpers
Date: Thu, 22 Aug 2024 12:07:30 +0800
Message-Id: <20240822040734.29412-6-liulei.rjpt@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822040734.29412-1-liulei.rjpt@vivo.com>
References: <20240822040734.29412-1-liulei.rjpt@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:404:15::24) To PUZPR06MB5620.apcprd06.prod.outlook.com
 (2603:1096:301:ee::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5620:EE_|TYSPR06MB7134:EE_
X-MS-Office365-Filtering-Correlation-Id: 94715fbf-8259-4c2a-a08d-08dcc2600fb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|921020|38350700014|41080700001;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YtUJD9ZSbVk2UvYVIy7gx2hjh+F9DcB6kJwYc+4h+c4aTdRzdYDco3SF1dIj?=
 =?us-ascii?Q?PaReubtemXRDYYRycFvx2oK/OTqi9mPpLvkPFG7GssdAtDfujT12ottXdk80?=
 =?us-ascii?Q?w3g7daNlSaHTkBI+d3kqNwzWtSEeV72e/p2pGbXlv3OhbzUJDV1+iyiWa31m?=
 =?us-ascii?Q?ZQi2nnOPqZVu05KBJHMY9uak8cm6qHOCpLcXZBQWEYu/B5N8kwRc8rs66Yh5?=
 =?us-ascii?Q?9KRsC1gMa25yJ1lee61w7GhmjVqGT+zIS/IV4+qstP9I6g3DTfITvTXcTYEL?=
 =?us-ascii?Q?3pnm3ckcYpE+r3h4N2YNSkLrMAZ7sXRk0S7eQa6dbrljI1neUthQdCTrn2xG?=
 =?us-ascii?Q?MywvZv82RF/2gWs73QzAV9t/67qG+wmBbV8au9UfktIz1/oqKfxC9+Blj09m?=
 =?us-ascii?Q?K41QZVYGR8wtmG4eG+BWiFV3wYAHJ98gian32g9QQC8XnHJt7PiM161s03eq?=
 =?us-ascii?Q?pqpKzUUgu/qHOiMTT8NssXtPGKkF4tpEHe97Uc4UxttMg/+Lx7SlHaEEf6ha?=
 =?us-ascii?Q?fBaeuiJP8rWUeNlenXFYc48T+peB9K7fsyIi+Ve5HPyU1qdC3V8RpEPnYrsw?=
 =?us-ascii?Q?5vGHHG9CsE+FrHn833+iZJtN9X+wCRosl1cwQdcC5iCQXjDRhTJH+8Rl8E3e?=
 =?us-ascii?Q?K2vvUxPyA7m9z1ASdTcAZCiJ1PtLD3f6giF4HU/ST4DUyDPGueHzjAsCjKmQ?=
 =?us-ascii?Q?mv+1hi2871d8yY0ss32c4S1tUYfFggPF1P7MCIUpb7e7OZWHqD6llHOYf4Jb?=
 =?us-ascii?Q?aW/GeaYTIAmIex1+HkBgfFpkIlQUiZCHZ7UjQnMiT4Ny3EZEJC9ZZQXJjBAZ?=
 =?us-ascii?Q?St2EhTqDl/53Hbvzd4Xh0Dq/QP/gKgtgT+b85D/krHk63QzweaLH8Hfgnbyl?=
 =?us-ascii?Q?L9jeLso2uJ9Bq53oqKFbrp+hlksUyZe+tu26z8nYGWqBj0zTZSDVo/0CHXqD?=
 =?us-ascii?Q?Ixa4eASsx+n7biKd9rQUlSeTh7HGI0wtsJpSEhYXo8VuqiLgM1hKglJDopjF?=
 =?us-ascii?Q?y2WV5fA/FWZPmWeinWzkcivRJ/QyZ27sILQrwvv7hCLdeGsl4APv1h4RhjAx?=
 =?us-ascii?Q?ReJpe+qxuzHPVxHP9LDxMcWlEIPBVNdIoGictFA2uPDytks5aTBICWjtdSH3?=
 =?us-ascii?Q?BKVPHiCXWMh+37mIEV/GCJgjyDXrch8d+sgwN6+tOSqlYRibX3ifAYYdRldD?=
 =?us-ascii?Q?+VCstXA6tlUZp4EsTcaOZJquEzTAtGeylXRLxP1xLlUx1XdapoXe0yowsaPD?=
 =?us-ascii?Q?xrPCyPzDZRULGZkBZAaksbXRFxgjWPvYmyuTOuSYKYax29zzlrN2wP73kCyE?=
 =?us-ascii?Q?z3YAKr1vVX5J7yaAFDEn+OfiwhPFYMekYBnysCPZeFGdt1gtMBc21GcaTHbT?=
 =?us-ascii?Q?tBLx+ZcO7UWVSs2+ylf1eqCCsZOAqo697l1mT4ab7TTKU1fIW/gupb3dOVbh?=
 =?us-ascii?Q?sc7EQw6Ricdt8+uoN1uivlZtzSUIhGpS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5620.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(921020)(38350700014)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SmvJygEqLt5DPe4VR/uBaRcfHbbGknq5yZeN7P7jCgVastEeE/P+YOkC33I7?=
 =?us-ascii?Q?FPD9DaOOBFmjv8t0llZjDWgP/50srOO9KlqW6hIZIHajEfuSOeoSavAIPRxp?=
 =?us-ascii?Q?nP9eVtlpdyKMqQ7h2+w8yVgXzmTmKmYml1Pub6IC5nVVNGHKi2nk5Ma2cw6Z?=
 =?us-ascii?Q?REDl1tZOjzscXxvc3XkJXwbgxEvZiT+8Kf8tU9yHwIGEo0Gq1eHngRYjZOdm?=
 =?us-ascii?Q?yla4w0ohKBoeLGUQSKYETS7N9obN0vbc+v0k/d48o8abSru3u9T0egfS8Lky?=
 =?us-ascii?Q?u4HiJMydoJt4KKp76Ft2+9YZlVAF6dVbk/iQhXz7bquivN8CX3gyYdmM4KGU?=
 =?us-ascii?Q?A+4jra01a/lNESiL7PWVqpfUdP9r8KrJXzY/JRP2X5HOvIhEA3IudgWaW4ua?=
 =?us-ascii?Q?5U6mnTTdtsxoPkd5OuSToRkXgxWHnVlfDBxbrv/cVejO9mqqCkspb6Qy/EPH?=
 =?us-ascii?Q?pecBqbsI7L0ZB797nslHJ81sfdflL8LoXFZDWgMh9p2uEmFM/znZhJoCTTRR?=
 =?us-ascii?Q?cGixtT4YLzyPHWZiRzhKxMSzI8BCMK/gMQj0RjGmRIFxL8j6UHVUwQYm4GlF?=
 =?us-ascii?Q?NDcsRq1mV579UEkYdb3ydgI3ByE6cQlmcIcovzc+kgIWlxP68LNQ9iLgIXBl?=
 =?us-ascii?Q?0HE3STBB76CdBUl7w+Nvz7WDWf+7ru7zpU7QiNSrLuXXEu2etGE7p3O0l/DT?=
 =?us-ascii?Q?OVPoCFNiBanJtXup9+xYk3N5ERpynZ6TI05/qeP8IGyVMFpZ8LoF7Ry54DII?=
 =?us-ascii?Q?8eamsGJ5hf3shueTQodmK+ISQSnm4F8WJdbmxutoogdNWnYleQG9SUQGbGxq?=
 =?us-ascii?Q?j6bqwhcSr+uITvFa656qBWS4wMdgJpwpDGKF1zTWGlZMrS7ynY6LkZmSRyhl?=
 =?us-ascii?Q?GfAUVfg7g7g/PPudBUP0e8LOYKDShZTx1VT+IpFbxVv5MWrAI9hRNZNujcY+?=
 =?us-ascii?Q?vE03JH0hhPyNqYcMPXT5MEmfG5jkeP6lQBDY7tBJ/1sLtrABTD+H3pVV3eX5?=
 =?us-ascii?Q?MYnv4r1cdXjlLa+oKpyEoSBQ/8g9YkgB4JL8iO/gUIQV3++9YeKzcai8cUTh?=
 =?us-ascii?Q?OU4UvIfeaTz0PSpxvuvQCMynuZr6o9+nEOAQ8PmvmJrl7WyxX4wTFxVFbU7g?=
 =?us-ascii?Q?+JYQfp/XyRIcr0nlNEQVhjYsJCe35jXXZd7RtUYJUdT1i2Dj0DrcatCeUWwA?=
 =?us-ascii?Q?Fl+/A/qozkVpaH6vln0OLDuBLZ2oCKfkvvSTDYAUxVwphqeuFPKlm3Ko9Hjp?=
 =?us-ascii?Q?TosysvopYERT5AmXM/ha/yi7Ad+QFZJuITi1mXHuAnYlOzyLIW0ddDmms6l8?=
 =?us-ascii?Q?Bk1mFan61lTLY2gQJuEZwZqK7nQeSC89hdVE1XW6sqwveMY/vyCNVYJtnRMG?=
 =?us-ascii?Q?4IdnkF1MuID39GSZtjL6N992YdG2Dj0OSNsEC9z1SsRlj/X1v4pXPN/Uolmo?=
 =?us-ascii?Q?TYpwpYICnDIfokovPmFwhLDQrO+YVWKhM8fKGrNNXpS7Kq6Ml3GnObblRMHk?=
 =?us-ascii?Q?B0Dm/gpfgQdnkdye+bsR84hEM1u6rKhmswNRGbQB+UBgFGD3qtczVsjcMSSY?=
 =?us-ascii?Q?ZDVLHXdX7gtEINFeK1/zWSSos1LixdKEpHuF/YpP?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94715fbf-8259-4c2a-a08d-08dcc2600fb0
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5620.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 04:08:21.7479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: drOLShEdR5kkhIA08Zggt/RGIQ4Og5XA3vMtcP5oZDYMU69xP+jUebzk/ehtdXm1oAGqxqNaW8w9mANEl32Z/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7134

The devm_clk_get_enabled() helpers:
    - call devm_clk_get()
    - call clk_prepare_enable() and register what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids calls to clk_disable_unprepare().

---
v0 -> v1
Incorrect usage of clk_prepare_enable() should be corrected to 
devm_clk_get_enabled().

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
+	clk = devm_clk_get_enabled(&pdev->dev, NULL);
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


