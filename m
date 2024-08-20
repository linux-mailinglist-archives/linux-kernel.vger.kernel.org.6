Return-Path: <linux-kernel+bounces-293764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6602D95843B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B0511C247FF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FFF18E04F;
	Tue, 20 Aug 2024 10:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="cIDetIPo"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2047.outbound.protection.outlook.com [40.107.255.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1AE18C351;
	Tue, 20 Aug 2024 10:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724149294; cv=fail; b=R8CWW9R/q4YyxehncpT1vKxT1gfS51vbmIDAIZxR5KpWt31elPDIEAKasL7to7Weqnuxv3Utjj+4zU5qwUsCyBdWUCsEgXe8Qs625PmQyrCHAW8qXb1VdBROiJjOEnxoxanWdrdNa9qqE4PBmqxVcPJ2PJSgXnlbMgu3yTslUX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724149294; c=relaxed/simple;
	bh=msixm+1vRLk4miQKQ4kRm9nlnwqMHI7QIStQQAlmocM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KD9I+/HVghKgXVnkqimNTXTUK9w576V/n0J75gvb+zWh6JoerUc6NZqCMyIIcn0KLRFkoyfmzEg2VN45dI6E9rWG6YMROhLAscYwM8UxojBsYwtA4lbki84WQsWRdL/ZdaKi0Mkf68oC6DvA41YJL+vGVpVm/VcQONqqNsIcp/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=cIDetIPo; arc=fail smtp.client-ip=40.107.255.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cA2hgjWr6Mnd7JL1BeMJ9BR7IbSBo2+hq1CnGtSU/cXqw5oWrlf+WqjkWapaicJT+2Ols8U+I60LuaHgkphjFhyhyN9gm2z+7jLpwqmSXaLu6a0LhWfCpYfWn5V9HY1ochQvCxFg2Qzk47R8JSwjC8M4QsADDmfixHBFilGHUSPYyQ/a3xJZlR/UN0N7P3wUy1szfmfZFL7ngiHYJ0OUFDdYF/NNnFTpg5IDz/SqoXTTpq4mII10vIH8Ukku9oq+XrNnEKt257sCkz62p9CU0AMhi5gzoU4YSSvXxwhDq55TEUrE3crhsSbrX8id/tCrwUBHXTgrVn/exWOub9+i2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQAOStixf7VQ8B8Sxj/m06L2AAAvU0TXphQw2Xgl0E0=;
 b=eRtnOoqn0qnecAK5pWPvRhWJIwgY6eT99xNMkqy1tfx7OJgMHA5bsPzNrD15R0BUnhDXov9pD6puRHRndGeuh/gM0DDh8r9abhq/5Pp0BNUFZfDaJFSd2SdcSreeYsAi+QcHNUDs6j+Zmjh/kTeVux2QWm8EuxzzSIBbRPw1u1IqvW8Z34CWgoMh46XidZAocxaGHd5Zd5MCb9klvav1Vu01Ja6OxmDndogahSpbzaoaQV9siBpemySV+BIklDYZT6mIRxg9hwWdVSf+Cd2Uqx28X3IGoNbXTdeMQIyo4Rdb4Q84wrhtRUTptGhQ9I/WhQ1IaSynSTyg2a9ok6BNbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQAOStixf7VQ8B8Sxj/m06L2AAAvU0TXphQw2Xgl0E0=;
 b=cIDetIPo/2ohpL9GN9QGtcQAMfoNzmEp0lFe1qGEdEC50mxWahi+YAFrc/9rmNIWWXzQVev4W6d8tk6lHrBQyidPDdmkhTjbixNgdKghOXlKVFxiTBru+ey5wt8/BmQ7lLKzCCOLJhoPJgDy2x+uOdaMbInkNJKXoOxqpVnDOTNWkk0/1SyisR6ptLAH5Ml/XNYt1kJJ1XABa1k+zpGGdjGXLEfA3/vIxmuuSKBGPrJji+4tlST8IBjz/Pdq79+RAbWBgRypzx3NzFvdDrWFcw2LcZzHCtz7/x9zkgAXUtXUMjMpknoIbBiGsFDGMv5YLDnL1lfTCdZoVyU6dSEgPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SEZPR06MB6486.apcprd06.prod.outlook.com (2603:1096:101:179::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 10:21:29 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 10:21:29 +0000
From: Huan Yang <link@vivo.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Huan Yang <link@vivo.com>
Subject: [PATCH] clk: lmk04832: Use devm_clk_get_enabled() helpers
Date: Tue, 20 Aug 2024 18:21:19 +0800
Message-ID: <20240820102119.130298-1-link@vivo.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:4:197::9) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|SEZPR06MB6486:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bb1b6e5-2112-499d-a3ce-08dcc101db27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q0b6KpTQuRPRmFfhXCftq1CNcPB5D1qYkmqT3a3gYNgVFM+I2Q/uc5YkvzlJ?=
 =?us-ascii?Q?MhD1HAhuvkQRb2fUas/3LCxpg/wps4DWceRCelDnJFOG5ft3kArmm1AZ3QkW?=
 =?us-ascii?Q?9Uyr60z7NRQ+DdOYd+p0aJCXVe0PrUVV42HGghrjHVyjE6u6J6CKhPI0Qr0Z?=
 =?us-ascii?Q?6+ZXDk11jZJPghlj003o5vhYZK3RlJRr3fuBs1sLWPtAQyAWlJU7k02w5Pok?=
 =?us-ascii?Q?VYZMr2AxP65/yhTVHt5kJ1lMWJI+DxN6SmMY/W4+CpJ+ZjvGb15kq45YNbU/?=
 =?us-ascii?Q?D80oitiguV15MLblvN82tEnkaluUToQAN5qrz7mX1spUwY6hpo4x2CHgZ2Sa?=
 =?us-ascii?Q?wruXUTerLakYn5FykGwIgW6KyYJmLck0CiPmWKxkQTd1AJt2ohz89CLKovfz?=
 =?us-ascii?Q?nK5s8FMzSo6UoDwfMb013UWtJPf9m3ELZtf5G44r4irnnHA7OHW76NcoM0MK?=
 =?us-ascii?Q?pUPeDYHP52p/UGprMTacnKt1uw9aoqrAxQNnOdW06FdSfY/lZ+we4/URwfie?=
 =?us-ascii?Q?BUJ2asIHo5DeN3k37CrEeOerOW1fLhbUsW0MwJXT5I8atyU8Su2FTNPHIWU6?=
 =?us-ascii?Q?T6uCf1JMnF8meeMpZEbDpJMbza/Pua2vQ9r/Q52BHfmjReuiHj4ue57b/hrk?=
 =?us-ascii?Q?eS484GvPmPWv91qmQn4hyv6rw1Lk/kCXAu1Q2WG2KU/6cOBGct/TXLwe3a0A?=
 =?us-ascii?Q?xgOQPw9yCVD8Wcj0oJiXKaSoI6WrxJlvizq+5MnM587Iec9ox7FkzgRsQKMM?=
 =?us-ascii?Q?e0mRs6edlIo/9fXHC90uvWw8wN3kakF6xD5uUkPYa+HNJoRrGx6vJQZ1Crvs?=
 =?us-ascii?Q?TBagVf/h0qENZNJlD5lCXoM+nuMQpGuyU+bkihUcv9jCzDQuqAED0YqSyi7h?=
 =?us-ascii?Q?OjvAjqaCpchkdAXR9XzZXNjpu044L28R0tnhKfeRQAjumaBvQIr72TS84f9N?=
 =?us-ascii?Q?DUoulHKkrd6teUZ4s1RE0I2wA2YClhYz6raOx4KRJ/YVTBnvDmKljgDmnBI7?=
 =?us-ascii?Q?ua1mCD6RDfOXLwlJ1RdW6OPpy5jLjiH9sU5vMAfzKZ60Y6cz/kSgnMwyF26M?=
 =?us-ascii?Q?hRwxJzdIXl+Dv1QYtyjn5CO2OdZ9O1NeWNqzBVW46113pFJqqZQZHbx8Wrl1?=
 =?us-ascii?Q?raKn7vfZbdNO8ouUJIAGeBHVxRS1ZHy9IbvD6b9zyYz/lFTZRf0HI8WimssZ?=
 =?us-ascii?Q?rm2KWIDKVE1X021miS3i/OrziRsahBFznZF4Vyix1cbiRjMZiibTnHzwgcJv?=
 =?us-ascii?Q?HaJUKSf2g4XyBDDFIjTWhhfPQT8fl+3Q9bZ8mnSQuNrCBHXOcogmUQcrLLWW?=
 =?us-ascii?Q?724iiNLmrqPRdv3AaryJqBl+oSFfICZfFWk19b+0O6CJFQ+8wqzZw4OEgPsc?=
 =?us-ascii?Q?oVnnICJUyP/h6wMvuSFjhLRZA449dnJQNFjevlnhZFyq/3Snnw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8nuBkdXE5COtdozUFZkrCUZVZ3eobARNzOFNXYfxpRnGTRZBVyPE5oXwHwTM?=
 =?us-ascii?Q?VRt9actDEZHPuavSGig1QkZ2g1IelrkzGMJRNDoK8KR95SyyBHuIcDpCwai7?=
 =?us-ascii?Q?mhk0X8eVG5V0g93tLJAt+BA9UZSJ4ugKcKj4Q1BSB4qiOKeSrqhxn1BF5CJO?=
 =?us-ascii?Q?lL69OM9k45GsAoGYDG0GUgTmeCRawBw+9y7YZk8fGAS2FtW7+/rRg68Pj3HK?=
 =?us-ascii?Q?Qeb9RCEBfw/nCb1ptxk9qHlF7c5DFhWIvTja+/HKPPTPkxFtBdL2KYDYjNnd?=
 =?us-ascii?Q?kM/P0aw2yCD+XHisEqeyMNncTXUSjvpJ4d8Nu2wz9xc9NJPNAgWTeAVJdG1a?=
 =?us-ascii?Q?Fo9a2mBXw+OEI3vkzTLLa+hQErnocpblP03GBvgnlCYJoNxzElnKRshs9bv6?=
 =?us-ascii?Q?8tu5wQBcAGE8g1sEzB9nX5T+7JUcvAKErY8rZQC2am37b1zqTtb1L4T+vzDD?=
 =?us-ascii?Q?kUDQgEBrdowoF0XxJE5L0sFH9Az38YbQpqLfRd1KvGJ5hVWHpX7eUYDYcbrV?=
 =?us-ascii?Q?ujR4jrYH6y1TrnsJA5rBiaGz59yntGdGTc86V0Je+sCVJurpKslwuIT0OcL1?=
 =?us-ascii?Q?Wx5npzXCeAbsG7943wBeS3qQYXuGnkuEXBclXNkl/NdwXqdk48IvHFRBuQMi?=
 =?us-ascii?Q?RWCEi76j+r3OuQK+ZWyH8fWeNR2953k2lEZWeRhwG31BtM0z1Q3tmfwB7Dg6?=
 =?us-ascii?Q?75WYI8YTTRgjmWBgB6Mo9jrDD2fqkIzXeBLdWAgSAT8y05N8PaOWRERZXyrP?=
 =?us-ascii?Q?NfNjB1EULXNMmzEt/pSEdemI9zPZUK1/kOFyn5gABFd0AH0mIBKUHJw7pHa1?=
 =?us-ascii?Q?0PA6hU6CwRKZ61gUIuUUGVq8WYdC8EOkGC1cUUHOEHlzRy58qqLrqXrzv5ie?=
 =?us-ascii?Q?hzxexMdHVIE2T525QQZV8mP9Hd/Kjm+TK1G5oLDCnwN0cd7hCSOyVBRlNXfq?=
 =?us-ascii?Q?lG9iEIMgiCNABntFFVh/xQtteJeJhfyBYnPCvT/Dh4bu3rJlXESbXi/tDIbK?=
 =?us-ascii?Q?BF4FmWQLtmMIhNZ9gCWvCFx1pbpIm7Zixx7P5PeaqQFkO9TlNuWGF2RLqPIU?=
 =?us-ascii?Q?VUDsRNxb9RV+q2Z85BIa+woMAwGYZYz/9/W8LnZ/C6m+e8Lrik4rFIorKpyk?=
 =?us-ascii?Q?/E3Goz1kpWo0p1f/3wZaxspO8iZA7DsvCMkVX9OiEfM4PiX/W8FvB0CGylC/?=
 =?us-ascii?Q?zZGKYNrsKBqNHwfSFzf1rOMkoOcUeR0R2PP55fSiZ+RMid/0VPTBayKchGjI?=
 =?us-ascii?Q?D0fz9u6TclUgaWQqHKtTdCmxtQmsmlpbl1a/V1rOvFQ0PQoargSPK2uPQFge?=
 =?us-ascii?Q?uxam8XSE+szP4XIzBc84YBqMYfofGFAqQzZy4yb+4HKRw4ZvTmFe6KVyEpzj?=
 =?us-ascii?Q?pGTpkDdd58glFdWfb3mvsqE8n+90V6x2SE+a3S63te2lPslIHydC8S75oCA0?=
 =?us-ascii?Q?lbqcV8E6JxTq3XANSZk71y+MQDiIeYO3ioZPqZhMozfI/pn6B/M+l1VtAZr7?=
 =?us-ascii?Q?+WPsILymSW4HKACsElDDuACJCqBGnKngR7NItvXX34w2tO4NCdZowDhsiGBZ?=
 =?us-ascii?Q?NUMtxVCfVn01MSSTKeHL5DkovZLXnViQbHp9sktQ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb1b6e5-2112-499d-a3ce-08dcc101db27
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 10:21:29.7160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N+xeyXir5IF+fIzTVBX2pWM9KhfbOBgrqSbCnt2fvnLULan9ewLl3ZaZiJbmhmRnL32MMQ9FSG+NmyArpsIZxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6486

The devm_clk_get_enabled() helpers:
    - call devm_clk_get()
    - call clk_prepare_enable() and register what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids the calls to clk_disable_unprepare().

Signed-off-by: Huan Yang <link@vivo.com>
---
 drivers/clk/clk-lmk04832.c | 43 ++++++++++++--------------------------
 1 file changed, 13 insertions(+), 30 deletions(-)

diff --git a/drivers/clk/clk-lmk04832.c b/drivers/clk/clk-lmk04832.c
index 99b271c1278a..c997e7491996 100644
--- a/drivers/clk/clk-lmk04832.c
+++ b/drivers/clk/clk-lmk04832.c
@@ -1405,16 +1405,12 @@ static int lmk04832_probe(struct spi_device *spi)
 
 	lmk->dev = &spi->dev;
 
-	lmk->oscin = devm_clk_get(lmk->dev, "oscin");
+	lmk->oscin = devm_clk_get_enabled(lmk->dev, "oscin");
 	if (IS_ERR(lmk->oscin)) {
 		dev_err(lmk->dev, "failed to get oscin clock\n");
 		return PTR_ERR(lmk->oscin);
 	}
 
-	ret = clk_prepare_enable(lmk->oscin);
-	if (ret)
-		return ret;
-
 	lmk->reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset",
 						  GPIOD_OUT_LOW);
 
@@ -1422,14 +1418,14 @@ static int lmk04832_probe(struct spi_device *spi)
 				 sizeof(struct lmk_dclk), GFP_KERNEL);
 	if (!lmk->dclk) {
 		ret = -ENOMEM;
-		goto err_disable_oscin;
+		return ret;
 	}
 
 	lmk->clkout = devm_kcalloc(lmk->dev, info->num_channels,
 				   sizeof(*lmk->clkout), GFP_KERNEL);
 	if (!lmk->clkout) {
 		ret = -ENOMEM;
-		goto err_disable_oscin;
+		return ret;
 	}
 
 	lmk->clk_data = devm_kzalloc(lmk->dev, struct_size(lmk->clk_data, hws,
@@ -1437,7 +1433,7 @@ static int lmk04832_probe(struct spi_device *spi)
 				     GFP_KERNEL);
 	if (!lmk->clk_data) {
 		ret = -ENOMEM;
-		goto err_disable_oscin;
+		return ret;
 	}
 
 	device_property_read_u32(lmk->dev, "ti,vco-hz", &lmk->vco_rate);
@@ -1465,7 +1461,7 @@ static int lmk04832_probe(struct spi_device *spi)
 			dev_err(lmk->dev, "missing reg property in child: %s\n",
 				child->full_name);
 			of_node_put(child);
-			goto err_disable_oscin;
+			return ret;
 		}
 
 		of_property_read_u32(child, "ti,clkout-fmt",
@@ -1486,7 +1482,7 @@ static int lmk04832_probe(struct spi_device *spi)
 
 			__func__, PTR_ERR(lmk->regmap));
 		ret = PTR_ERR(lmk->regmap);
-		goto err_disable_oscin;
+		return ret;
 	}
 
 	regmap_write(lmk->regmap, LMK04832_REG_RST3W, LMK04832_BIT_RESET);
@@ -1496,7 +1492,7 @@ static int lmk04832_probe(struct spi_device *spi)
 					 &rdbk_pin);
 		ret = lmk04832_set_spi_rdbk(lmk, rdbk_pin);
 		if (ret)
-			goto err_disable_oscin;
+			return ret;
 	}
 
 	regmap_bulk_read(lmk->regmap, LMK04832_REG_ID_PROD_MSB, &tmp, 3);
@@ -1504,13 +1500,13 @@ static int lmk04832_probe(struct spi_device *spi)
 		dev_err(lmk->dev, "unsupported device type: pid 0x%04x, maskrev 0x%02x\n",
 			tmp[0] << 8 | tmp[1], tmp[2]);
 		ret = -EINVAL;
-		goto err_disable_oscin;
+		return ret;
 	}
 
 	ret = lmk04832_register_vco(lmk);
 	if (ret) {
 		dev_err(lmk->dev, "failed to init device clock path\n");
-		goto err_disable_oscin;
+		return ret;
 	}
 
 	if (lmk->vco_rate) {
@@ -1518,21 +1514,21 @@ static int lmk04832_probe(struct spi_device *spi)
 		ret = clk_set_rate(lmk->vco.clk, lmk->vco_rate);
 		if (ret) {
 			dev_err(lmk->dev, "failed to set VCO rate\n");
-			goto err_disable_oscin;
+			return ret;
 		}
 	}
 
 	ret = lmk04832_register_sclk(lmk);
 	if (ret) {
 		dev_err(lmk->dev, "failed to init SYNC/SYSREF clock path\n");
-		goto err_disable_oscin;
+		return ret;
 	}
 
 	for (i = 0; i < info->num_channels; i++) {
 		ret = lmk04832_register_clkout(lmk, i);
 		if (ret) {
 			dev_err(lmk->dev, "failed to register clk %d\n", i);
-			goto err_disable_oscin;
+			return ret;
 		}
 	}
 
@@ -1541,24 +1537,12 @@ static int lmk04832_probe(struct spi_device *spi)
 					  lmk->clk_data);
 	if (ret) {
 		dev_err(lmk->dev, "failed to add provider (%d)\n", ret);
-		goto err_disable_oscin;
+		return ret;
 	}
 
 	spi_set_drvdata(spi, lmk);
 
 	return 0;
-
-err_disable_oscin:
-	clk_disable_unprepare(lmk->oscin);
-
-	return ret;
-}
-
-static void lmk04832_remove(struct spi_device *spi)
-{
-	struct lmk04832 *lmk = spi_get_drvdata(spi);
-
-	clk_disable_unprepare(lmk->oscin);
 }
 
 static const struct spi_device_id lmk04832_id[] = {
@@ -1579,7 +1563,6 @@ static struct spi_driver lmk04832_driver = {
 		.of_match_table = lmk04832_of_id,
 	},
 	.probe		= lmk04832_probe,
-	.remove		= lmk04832_remove,
 	.id_table	= lmk04832_id,
 };
 module_spi_driver(lmk04832_driver);
-- 
2.45.2


