Return-Path: <linux-kernel+bounces-293686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 590B5958322
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A678EB23D78
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822D918C93E;
	Tue, 20 Aug 2024 09:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="JpldtJtY"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010046.outbound.protection.outlook.com [52.101.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D737618C026
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724147186; cv=fail; b=B4Y6dQJqShsVO0v7FQBkLJE/NumeExD9+r0rrSI6MGHIRrwLl7myolEcHInxeeP5YtgtAyYHyuG0zykV+S6ID2ZlJ+1ZejWceTg/8hCXdMymgiDW/FD7z3A0BtdMk/zeekh+doa8Rip34Ag03CtP3ExaEP5RbX2UxROhvAmW7xY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724147186; c=relaxed/simple;
	bh=9ByILKxqPxG/mUbwCLYaJ3lofNLoDxKlmEy/e+o+6X8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EhKV0hWmAJ23K9TzYvhv2mYwRF0yJTN8bCk6DaGnSwwe8Sg8e4EK5Amb34FgpKdTlpkzQn4JCctAL0WOOVFlSzR193haH89A3Aw1IHVDGKEkLVDsRC+h0sh57heMnNOA08v/RCepkvloRXNwbzUvBv8jlWS8Eb684x6hF8NnGic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=JpldtJtY; arc=fail smtp.client-ip=52.101.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qg7UDNdOJ3FzMgm1F9ozYtmPepL03m4YYqWFgi9oMlSKjRHxGMVciQQFxUBgUqULX22H1tKvDJvJfB3iaxpyuiJDXf94zHc4sQSpexG2oCzlxvliel9KXpDAQnUNrhNl6FRyZErYxqL8f9Vimr5msBFsl5gYrO2ABgteuP6yvyWY39ESM9e9FYzQpji/QV4ugduBZnqJJUBrhhSalqEBU2r4vVO2sg9ph4z58HrXNnn+Q+zRDnY1DzXqkyQKG1o2Dr8/MMFg//uI+IPCSJmDKdn16CB6UILMj0s58FF0zha1CkSQbRCgEAts7DJ1Wy/aN/5tWE/9z9SWdwLMVdQLww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kuIdhZV2jMQJCVpei3n/Mf55P+OEoavc5b9wegB2KI=;
 b=GrKTnj+msKN/w7BCy85kTr3ZXO5R8d5rFTttTjwICqj74D6ttJS3uquFf1+A2aq6D5ttkW/fpMbGlgtsF0NI0z5QlCHZAXPUFk2dm9/YSzXz75zQ0T0dWfbmnJ6AKi4vPSwowM+y4YT8qJ5IjDRwTfrMfjLF/Cu9bLtlGRccCqxSwdyvWy4p8rJMBEA99gXLAV6byZLG4XtyVLQ9gshZJ5edkXPTnsDNusaJtnDOJ4/8jfxQzPW+zpXwHPmRyUb8oL6AUpcQQ1cnE2G4UatWt2/Gm3GmxAJwmqwmSRMkp6R/VhpclOZBIpz2zvH3kNWYM/bNAaf/0YZhoDFHwrJViQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kuIdhZV2jMQJCVpei3n/Mf55P+OEoavc5b9wegB2KI=;
 b=JpldtJtYMooyCKMeoS1qHmOLXBqrjyBmpO95x6aRil6LFGrOyInB7apI0x1aHn9oXuO951bufg3DvDsGg0Hvt66o9BY/h8GU31qJ+41EmVnVW3qUphurHZXIRWZMHB9DPWp8NBCkEcMUG4YSJs/yKH0uLpO9Z5/6jlFy0lz5vtsOEtdow4LZ0JeEu2eWTitKuuOUYcAGyWwu/nPVlT7skOQVmXuPbtzXwydh29T4ILjDlD/1A5EmSQXC3oxR3IZiu7cnt1SVVQAQSuq363G1bSFQRsIrfeCfXA00Rwn5Vo8z/F5weol6pZHfUBdwh7L8488soSlOvFWb0ub1fQofAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SEZPR06MB5829.apcprd06.prod.outlook.com (2603:1096:101:c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 09:46:19 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 09:46:19 +0000
From: Huan Yang <link@vivo.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Huan Yang <link@vivo.com>
Subject: [PATCH] clocksource: ingenic: Use devm_clk_get_enabled() helpers
Date: Tue, 20 Aug 2024 17:46:03 +0800
Message-ID: <20240820094603.103598-1-link@vivo.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|SEZPR06MB5829:EE_
X-MS-Office365-Filtering-Correlation-Id: fe6dbc86-3380-448d-ae7c-08dcc0fcf10e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HH0n3LF8/uzZQXV/qyb1weCCjSboCSWNYDBys3ACmhYEsrZar3rnR0o9q1nH?=
 =?us-ascii?Q?Xi1M1hRhgin0etQkTwnxRPVEZd6d1oG0jwLZR5zu5QkPWZRAsLemVo7/aire?=
 =?us-ascii?Q?4KBkxhe/YciiGuFn0hU9y5NmGRVNwxtP2okbtAxwL3tGDe8/W7ZzeJ+ySPNd?=
 =?us-ascii?Q?xCbPLyfUUh2vJm8yvPn32hATioeT0LRndYlsu60+rG1Ef+f0bbunwPK69SYU?=
 =?us-ascii?Q?yjVwxPJErcGDlBP3rL448fnp9yfWJFxu/ssNiNdedkjUqc9mc/DtRxICoSI5?=
 =?us-ascii?Q?Hk55o7xxBt3dPmHt4vhOmeJnVI8qk/0VzMGe2Uzh5TAqQ11y6Vjwr4hnydgS?=
 =?us-ascii?Q?LZoTNuWQpD6Q8I1uncoS3u1ZLSgpvnuVHxqAPEBhTAOVk1X8XdvSbeWc4ENt?=
 =?us-ascii?Q?wDDFHVnXQwrHUjsN2AXDNe7GKlTxv2DxIVWxo8Oad4ikSBy1dcg82fi2XY/2?=
 =?us-ascii?Q?YVU+CMj13gJ0q68u0b1CuKU0df61le0FbbS72IwBVZYTIIu2Lx/b1s97/z3s?=
 =?us-ascii?Q?dqhUEBOExURxr075JN40HDSSgBz1AYGYh9PXLInfFfMEpDTG1ZrmIF4r/lrH?=
 =?us-ascii?Q?f8ut4A7jo6GzZp6Wjpp09fFOofQQwGygg6w1KtLDy7OOlCW9Qi93u59Qyp3+?=
 =?us-ascii?Q?jgkEijFSZemzAD2kpT8JkPLYbs2tu1Z8wzf2T0t1aEWD6RT33qD+79/Hn00s?=
 =?us-ascii?Q?54ninA7du8KjemIzzTLWXF8OlMxPs7ZYcupwBgU7fwv4DLnmi1g8hD6l2e3a?=
 =?us-ascii?Q?MVcqzQmQFw4wz1nq0TGB0XW/Sa/scXhTUd9Nk0qKDbDjYDqElxCW8DTjnruH?=
 =?us-ascii?Q?G+BiYj6jJfdE4gGzTg51adT96NdszfAfwLAI1LtHe+YRxwh94dknbQp87u7E?=
 =?us-ascii?Q?bOAHywc2K67m/i1ObtrwYp+rKheHC1vyG39cAzCJ6sMlgXhy7iewMRIXt4iE?=
 =?us-ascii?Q?WrWQJmA9Scsvpy4G+Jhpaqjf0nMndXoAxp31NMW33boytmuGqgSdi6BGl8EQ?=
 =?us-ascii?Q?/aRjnVZs8HELnq7GwtCigTSqBeKbra5O1E8C3+r6JM5BpzOVKE7Iz8GvW5tx?=
 =?us-ascii?Q?MnCdrgwfqLF03h11RzF+6D5Q2IzXkohPjbWVQJ6M9u7QiDxX0neDcfmRxgfg?=
 =?us-ascii?Q?hpBIHvk051vcRhBiU9mqDJsJTedArmOAqls0WWP1NCF9lpvdNxNGVqFcKo5S?=
 =?us-ascii?Q?PAnFPSU345JMCqUtsUhjgZoqCocD9FjoX2/A1ECBaL54p+xYMNUIaV98fOnW?=
 =?us-ascii?Q?YTJ7tfqSlwvWH/9ImFAkFLc+nZtQobUQYzWv3h+nuPL1SDLMjD3L5ekkRvIP?=
 =?us-ascii?Q?EuDTZTHt0MhNvHD1OKmFWuOsomstQCwgAlaTxH0fQ6e0cRp/WmYSTwQyf+CF?=
 =?us-ascii?Q?1el0LfkdmKFN42yUT5gemELOeLsc2Q0Kv8QpbhVhB52jK4CDcQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?84+ysDs2TvyE5lkAHf9b7L5egrwXwR9CiRrIt4CkZCHTZUIZN8bL9orJ20UP?=
 =?us-ascii?Q?DKwQaqNgLjrIAgSsrxt84mP9t0QiRj4XXFTB8xF+hGutIJxpdd27zkIsBFMA?=
 =?us-ascii?Q?GofH6ZrblRut+3sD8HEQzD3wa7wpKoeD5spJonGvZHhTn2ZaRpOpXqSyaBiF?=
 =?us-ascii?Q?ydii1aFZaprJVdn8WAYeThkbGhVxaDzBFWCU3/LsZs4Btb2RCLgVpuqgN4UA?=
 =?us-ascii?Q?De/SvfJekwZ7xnNoFERwcn6Gupd6DpRqQRQG8szS4SjRfDwNmcnvYbZ8FQ9d?=
 =?us-ascii?Q?mEBKxAFDbsNwSlrZushnK8bsObc+9dBh406cgB4b4b+eWAOszkrFtCZr97Un?=
 =?us-ascii?Q?AKm/DijBwybF0SXjTkS/FaV69DDJGkN0GvI6M9WqfhAsUon8csUY4RlTbPHg?=
 =?us-ascii?Q?p6C8Kfx4fDhht9sAd5E0Esby0iYOdXiZS250ZqsK9qCrZQhSqrtR54SAZ85a?=
 =?us-ascii?Q?7E6cBskLjGUHRHEifZOVbc0Ys4xYHSJYi6G15sbABC+frRrA49R+U3ec02+o?=
 =?us-ascii?Q?OuDk7Tv0+ek1VpsUogOe93u3mX8cN5vbhQctSIkbnMX9gYSGDWU0aEYxuz85?=
 =?us-ascii?Q?aWbW2g+pPVFRZ884WcpA/xdDDJbI3ZsnEbNkVn5ugOyKswOA08otIWIzY8o7?=
 =?us-ascii?Q?q5mNvAWfeqbZdYlTZa0hr601n1DSjim68xokkrJRNiKIQoYFYsYvT1kit5Dr?=
 =?us-ascii?Q?NJoPUhKNgE4bQx3LquMlSx4FHdkuarhe28KuIRaPnedQSXLGfTTf8KapZEQn?=
 =?us-ascii?Q?6QcMZKjYU7KJ975FW9zC+cib193rCCIoeb8j1Z9kITkV6gTl2l82lWa89MWb?=
 =?us-ascii?Q?B/oRLk/9g6QKxfMgzxErPe30TG/4c9LBcBEd9Iex3XGOe2yTcssnBnC3Q6K4?=
 =?us-ascii?Q?YX4DMBo1CznozyaZU3SeNxxE756RtUPZ1hBfCmigZE/sW5rxQEq6BJQlQUZo?=
 =?us-ascii?Q?z3fF7TNAzrEUhRxgAib8d/g2xTXW6YbPWBWOW0tML9zQvqx7/CpZcqr4Kw8N?=
 =?us-ascii?Q?7EKuMCF79PYxea+kQWFs81DMHEsenyXX+LvAZ2ySuFmVIh//NtY9e2x9Zog7?=
 =?us-ascii?Q?oDFzdbssmSOyGoTbMPTYHppJD7D9huo5VCTTj0NXqk3PUowDB11pViOta50q?=
 =?us-ascii?Q?jqxdx/a4ZRFsLrgXmM2oPNhi8yMel7UHMgOZyD7XTM9vT6eLTIKvbFRl2fEt?=
 =?us-ascii?Q?kJWGr6TWCpQlr3COhEJb2/zjbWM1B5wfE6/d04468jj3bd77ZBES/Q782Jp0?=
 =?us-ascii?Q?hI1bzZBZS0pvX4F0zrBU17kmbRsbPa44xD49iV8QSB2A6DPTF8EIn3UYT1zT?=
 =?us-ascii?Q?4/TpFajqO84XQ06LWBxKOHGAC+D5QOlEYcQVQB4RPoTEa+4H7slKB1b8KEBh?=
 =?us-ascii?Q?KyntKmJ2ldoGEv+2s5e0IPSlA+ewaq61ie+RddgFsE/2G6gBZ49RlYTd1LKm?=
 =?us-ascii?Q?QTfS/Zv8Nln+iTE1krPfjEDSFAWOR3YcuEF5187HJwHf6GUvkjcfZSTuJXP+?=
 =?us-ascii?Q?UIFpblL5c1JRG+mzbQfCbHsJO/NNwg34g3nm3AAFO0jbvdjVJ2oXOaXmWW+v?=
 =?us-ascii?Q?O/vs0da7Wk6nG/08/7pkBqQlfUmrNOIrzZdgV6ry?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe6dbc86-3380-448d-ae7c-08dcc0fcf10e
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 09:46:19.0108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kQrYUrwRz9ohFHdlgWOItGCOpCMQjlj7S2WVqdBBfGaw6cBdJSlpF43MlMt1AUInAAtjLi11X+gU/I/aahXRsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5829

The devm_clk_get_enabled() helpers:
    - call devm_clk_get()
    - call clk_prepare_enable() and register what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids the calls to clk_disable_unprepare().

Signed-off-by: Huan Yang <link@vivo.com>
---
 drivers/clocksource/ingenic-ost.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/clocksource/ingenic-ost.c b/drivers/clocksource/ingenic-ost.c
index 9f7c280a1336..e0ec33307c84 100644
--- a/drivers/clocksource/ingenic-ost.c
+++ b/drivers/clocksource/ingenic-ost.c
@@ -93,14 +93,10 @@ static int __init ingenic_ost_probe(struct platform_device *pdev)
 		return PTR_ERR(map);
 	}
 
-	ost->clk = devm_clk_get(dev, "ost");
+	ost->clk = devm_clk_get_enabled(dev, "ost");
 	if (IS_ERR(ost->clk))
 		return PTR_ERR(ost->clk);
 
-	err = clk_prepare_enable(ost->clk);
-	if (err)
-		return err;
-
 	/* Clear counter high/low registers */
 	if (soc_info->is64bit)
 		regmap_write(map, TCU_REG_OST_CNTL, 0);
@@ -129,7 +125,6 @@ static int __init ingenic_ost_probe(struct platform_device *pdev)
 	err = clocksource_register_hz(cs, rate);
 	if (err) {
 		dev_err(dev, "clocksource registration failed");
-		clk_disable_unprepare(ost->clk);
 		return err;
 	}
 
-- 
2.45.2


