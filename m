Return-Path: <linux-kernel+bounces-301054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C265895EBDF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25B24B25215
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BA113B7AF;
	Mon, 26 Aug 2024 08:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="f2VpBji0"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2087.outbound.protection.outlook.com [40.107.117.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684D213B792;
	Mon, 26 Aug 2024 08:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724660555; cv=fail; b=blVre+nl19WG8Y9oA1pRz8zPAZlzKiY+UoLrwWVSYFHc/nRLU1MIr4SWqTB06QIgs0Ic1KH3Ck7HneiwL3L0L7hzog/eSqGrl+e3uWxqLQD2Xv7P7rIuWw9RVYdOsFmT/yPdiGh+XdTKi5w7MIryIVs5IlN01YsIy8q76LkGIyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724660555; c=relaxed/simple;
	bh=SSmG5Bem7qyikRpOoPuSLc1AvczZr1/Eeugsj3e5GVM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tEy0hxrSHJIOIgX/Co3hfWO+ApiFhKB+73dHfQDpMZoN+CMvjEq8DuawuKMTLhXm2kPxg1u7QLFsXgScTRKKO2qZJEa8n2Q7hQMNVJfJHnPpYjQ8UM2RHzH/KqobR3pGEsMJ/dYhurHHs/8/guUx7NGmEb2KGyeiW3fyxUHwFGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=f2VpBji0; arc=fail smtp.client-ip=40.107.117.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NI7GoHlW1Lhve8MWkpPNn3S3hzqfAaN2vbpxD/X1sFq5z3XTWGawtJifOSSuoXW5GAju3IGAoGq6JOtHDWa862kHrRZ7jIBpmTNGZ4yI03hOLNJt+Ird/hL8zpxRFlJxF2zspaaKEV62X8/WAaOEPzmLh/AZjwMyHKcKgGC+ueUSH6EHSlRKYneOvfileORU46pTlfGwWmNW5O4zBP1eYDrhb7UoWWzr12VbVU9NJsWwdwehE3nJOzq9f4IdCIJvQ6S0tEcWznVD82Oza+SDNC/LyN0OSsZuP4hGjCpnIYrRiCoMB7/kDIbcmHQjeIWYpZAfrVsD4IVEPD16PofxYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qz03x8h02qC6gDrmqTA01oA9enpmey7Xz0yBtUzGqA=;
 b=UN8CmoGK8T/xBYYom+fP0H+iVXM+DmvJ39L925JepGuH9PsTiaitQxao8lOzLxAcpXXXWu7mdSn2so8HNt9XkIbDWuEH4NaNCd/vHWTScLfwu7mRCaHi3I7IdKzpRtC7/S6rzMwaGUI25+3ZDy65/5ESuSFqlYrS64hhFZfCkdeST8G4UyS8MOAAHnR9uCMYr5/KtWx5c93H5SApFjSyfQv4Ajh+c55r/KnPHmZKBNBGkVIpeG1BUsr5so9Io8gIPmEC5u1lFtz1QHmnwLjZ7mTyKXbZof9g3Q+r2qfDdVyHHtHT1VZC6gM4/lIztwowU8xQj/sL2hlpoFMVG8Px/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qz03x8h02qC6gDrmqTA01oA9enpmey7Xz0yBtUzGqA=;
 b=f2VpBji0oG7TWdE2h5zEBfx05DoinIQWuA2sfmZdc/JRLzbxNH+AYgzM/j4xh2ea/X8upa1QLskLS8goCXfVIqmDpNfq8N/Cgdn/R8Kj4IBUGvYbv8b2rgXOeDU9C06ibqDe44eborIdZt+60U39r/6XCxNunrRtGyNdrScGsGC6umK7UyKjYpbdvUVd0Vx3K+GJiVl8/G6IDvMM1Y6M2kAfOptHEz1DjqZyIpuK73NPz0Inex+Qu6NdUy0iOXev4ZaQyg0ZMayK1zo0aL7d+yePNey30M2Nkth8FAvKVi8dAIlQ+I7BSTfRqdqNwvDpDuqTiUKYfyhJ+1yPWqe55A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
 by PUZPR06MB6054.apcprd06.prod.outlook.com (2603:1096:301:104::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 08:22:30 +0000
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd]) by SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd%5]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 08:22:30 +0000
From: Lei Liu <liulei.rjpt@vivo.com>
To: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Lei Liu <liulei.rjpt@vivo.com>
Subject: [PATCH v3 2/5] usb: pxa27x_udc: Use devm_clk_get_enabled() helpers
Date: Mon, 26 Aug 2024 16:22:18 +0800
Message-Id: <20240826082218.2331-1-liulei.rjpt@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826081900.2284-1-liulei.rjpt@vivo.com>
References: <20240826081900.2284-1-liulei.rjpt@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0240.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::16) To SEZPR06MB5624.apcprd06.prod.outlook.com
 (2603:1096:101:c8::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5624:EE_|PUZPR06MB6054:EE_
X-MS-Office365-Filtering-Correlation-Id: 481591dc-2705-4383-723b-08dcc5a83a55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014|41080700001;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I67nQJVehKDnOjTiIl/EFCT1FKS0TQ9vJwdvE6RiKO2ctSWpvMwNr859IRWm?=
 =?us-ascii?Q?PgLi8ur93Qd1OJawbzyYfFlGE7dV/9WVUsuXHSYwQB04iHQ/H35k63Nr5Rb9?=
 =?us-ascii?Q?qeHmGDLu75zMvV4XZaHSLvMOblS9N7A7NawYhXBnYP+1MjwC9XNiAlXhHSYm?=
 =?us-ascii?Q?MLREPdNpUMFu32pFPGavPIrLssbwaw0ngwMVOkTLQHTkr4m1vfkawtOnyAFp?=
 =?us-ascii?Q?qVQrKtjnp6MbOo/GLj3JTsunZhaVBJXO9fUC5U18EOJU8RL6Ajc7wb9N4V+r?=
 =?us-ascii?Q?HkLOPe5bTPSRuxIeY49giRn1JGd/M8tmwBbH4IRmBHfwWMJTRRJpXAlOpxQQ?=
 =?us-ascii?Q?XK0IY8moouItxH8GkNfq8rAIAkWFhNlngjNfV6HUfvU0w10lUSR1MOs3RJhO?=
 =?us-ascii?Q?mjd2elI8oANH23R4i3yg96tbkAAkcrSH0geoR5AtPfEvJBwUGHwml0xrwaMT?=
 =?us-ascii?Q?JS+HcHY844d3qJiK0roebzxb9y89GuS//cO133C1DGiU364srSQ9q/I/Tigk?=
 =?us-ascii?Q?syCEVkBhRqAdAknrZIrPxmOHTcXzwejKnyQhgDUxDMfesFJZJYYr7LiR84Fl?=
 =?us-ascii?Q?ksr1eQzV7Y20PjhLay+QbgK/X+t7RGxzibtRSHSB1hNbFob7rXTSz/3a1ALr?=
 =?us-ascii?Q?zhS1I6a9cHPBZybxRiUdfvxdObpI17g0q6S11PC9pfZDgn5wHGfDsdeVA+Z+?=
 =?us-ascii?Q?inH8ig8+ZF6ctsVe3NxSn/GUQ0FSMP/HmaNTLF+WvIZjjqm5aCmb6gTK1Le/?=
 =?us-ascii?Q?SLaK/qxGCyDVdcXHigUMjhIZRyLk16B268DnRA+oL5dqYkFopOnm4pC5acd5?=
 =?us-ascii?Q?XKGPsuD9Y35t3y4Xwb1btczbMIabT2dEUubWgNyt/O0E2PXHIW91jhAKy/xG?=
 =?us-ascii?Q?uRpZ2qLG6XJYsnKI9MZUNl4pSBdksudwRTnTxWZaeUHIiptq74S0n4HI0uU9?=
 =?us-ascii?Q?xRfBHVrEKtOcgseE4s7IQIkzM/ZbqkNCo6F8o/VLwxI3+khB+USguJ7TGqSz?=
 =?us-ascii?Q?kHpPbmi78GSXrW474a0jWmFnq3KYgfZSI9DmXtRV3LvWR5avliQ+lr3N+Iaj?=
 =?us-ascii?Q?XyYl67FeMlTCteImDN6/znj/cq8ECzkvYpVXEOYQPpLedZJuG8GcBmJVOXK9?=
 =?us-ascii?Q?qF24dPZ0rusCaCpPE38C+rUAClbs/gBSpQngiwlsher7TuIGV+KVXVkJOdpe?=
 =?us-ascii?Q?JM1nGBUP6mO0lLcHrZKEzpKLyUDPyp/zel5sqxb12IyyYU9ojtic4kd+W7bN?=
 =?us-ascii?Q?7VtHdgc2sYr6BEKaYVvs8/uviGpuBMCjve27mqyx+exmGEotWWt7NKgjNZnY?=
 =?us-ascii?Q?Hdwb9IadtpLHs5d7g0+mUJ4T/VRU0blnqPUWHZBfQVE4ykaCn2Md8tB9wJ6l?=
 =?us-ascii?Q?ZLgjc7dIWiWkQNyQYizBtqcwRRZdnxnQZHBnJCal2zaHxIX7J3s06wg5NTAG?=
 =?us-ascii?Q?1Ha+fjI2Cfo02ndfNfzx+hSEvKWXS95T?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5624.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GAyjYmQjrW0DVXATSB3Q+H6v6mmutoiMzAis5Q8bGTlvf5IFfYB5C8tdaX1u?=
 =?us-ascii?Q?Dh8hS7Hek2ts6pOs0+34OyPOGBjZ8zy1EuZoU3vKmlKG4bxl0rooZuCRQOwF?=
 =?us-ascii?Q?Bo92wHhUM+IiE6Iq9OxCapHZtzIsgsiZ5rWHFBBQp5z6djlmsR2abW3tnaS7?=
 =?us-ascii?Q?nRrXmhahP29iqSrZi2Hywj1GDkZndZAMCTe/p7on4GgwwAlND9v9h2ic9sCM?=
 =?us-ascii?Q?+jsNpxcRfbgVskuDj2uR9ckf6ZhOIOX0kupKgJRT/CEzjlZ3kkDmxwlCintD?=
 =?us-ascii?Q?BZ2yJKIpDsMvNbDTZyrMuIVfcUrkccFaRu+y/ZEM6RUYYwTo5CgzwKQeyCQm?=
 =?us-ascii?Q?tKoPqSYPiSTNsfbBxrXcSpjMXPklEnp5QoGZ2vk08frn9m6YVsOvuT7kZ0l5?=
 =?us-ascii?Q?hpU5Z3Ws8+X1Q5Y5DBlxRhE8wdIrxXKjtPrJlpOsuNp9nrLoB3hlbcRtthjG?=
 =?us-ascii?Q?TF5Wqipumlfyj85oHRe0fiFuerolknsPu+cPlpMnqsqdzKNoKTzT/Zs7gVtu?=
 =?us-ascii?Q?Ef7yJaKEhY2wXE0q0MPUu3GfDGmnOy0tg+GyKjjvmC9oRy2zAYUwZnEVpyk2?=
 =?us-ascii?Q?QrArA9/3fyBXLhLkxWbA5j9wefIsGm2u9On5wvyQGtj3NZ5cTqccnQZZJwAC?=
 =?us-ascii?Q?I2FS05V7J85bbTW+iqJkmB3Ev5U9daouvZcsHdBKi4SjlYhLMnCTxnbhHheG?=
 =?us-ascii?Q?omrab16Qe3rK+iTRoPZnWpnSs3dDPLlbDRpZdtl28MufOciRyYSIcg0u36dP?=
 =?us-ascii?Q?bFXEle5lQTbApTdmkUIo/GcR88BTtgAFgufrxoKNau9E8+qZ9RdD8/QStWQ2?=
 =?us-ascii?Q?WzvZCpwOV3bIDLqNo1i/jZzoQM5SGxWxlddw6dwZVbSbuRAnU8pggNoaB/U7?=
 =?us-ascii?Q?7cMf/kMLBpjv3O5uYj1ugLKb/k5DFCAK2vvgwFpWi1pyul1epJFqE/uJ/DtV?=
 =?us-ascii?Q?h4f8LdYq456RI11PvSL2f8GGOjdFadKAEAR7PZNho6SgfW/bBWaf0m5/5Dsp?=
 =?us-ascii?Q?xjY+sTtrCFnC9yZmHX+C0QIzrL9iPI87tkAdoxPqLHD+XoV3yIN1gjmaG+OY?=
 =?us-ascii?Q?LiGP6kppz30v8zjppVkaZtU155Qffit8gNdjYG2dn4+0BHVi5I48xrrbhPSI?=
 =?us-ascii?Q?M+je2xWq4iKROWJI856MQE0WXhOqcO/Ljgo8LRKtRv+AytjRbFsKUD8E+NhQ?=
 =?us-ascii?Q?LIJAFtAnM3VBFW/mjhw+BaMOIQDxu85RwH3ro/b2nY7AbtaTZv19V78HzjWy?=
 =?us-ascii?Q?fGxXWEyQNaCv+2Nw6WVg8jIjqUhrt4IwMPu0q9glMy/4AdDnYuzODa/PJzqm?=
 =?us-ascii?Q?gtBzdV9oxtJL6MobZTWdN1ILXM1zu5nkrmPkzJfHW6B/7p+/9Qg72j/L+Ijx?=
 =?us-ascii?Q?k0ikMu1yB9KFSZf2WLOGqbKgHfCd4BddZ5E42w1tHdVN9fxm1wEmk+NK095i?=
 =?us-ascii?Q?q8uMA0/7N88fu28BAOSPYjDMijWMxBN7eEsaJ9S+QJcvXmzt2UiG2MKeX30h?=
 =?us-ascii?Q?6r9drduXuyJhOEiVpF5DrSkib4kESXr0xsqJbPSzce6p7u0qstOZJQ3SPcaH?=
 =?us-ascii?Q?CIiN8hos8Esl4M4c7p9Zk3uCNCI1efyAfgJ+rgwV?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 481591dc-2705-4383-723b-08dcc5a83a55
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5624.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 08:22:30.6209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vfm6OgEXHV3gciNhj/fK5ALuSEJCDuPodueYxcXvbn3DZYnKhmewt3D2aZU2IUkzyfuZywvtRZ1/s8VT49/Y9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6054

The devm_clk_get_enabled() helpers:
    - call devm_clk_get()
    - call clk_prepare_enable() and register what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids calls to clk_disable_unprepare().

---
v2 -> v3
Fix the email thread.

---
v1 -> v2
Incorrect usage of clk_prepare_enable() should be
corrected to devm_clk_get_enabled().

Signed-off-by: Lei Liu <liulei.rjpt@vivo.com>
---
 drivers/usb/gadget/udc/pxa27x_udc.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/udc/pxa27x_udc.c b/drivers/usb/gadget/udc/pxa27x_udc.c
index 1a6317e4b2a3..0619507d187e 100644
--- a/drivers/usb/gadget/udc/pxa27x_udc.c
+++ b/drivers/usb/gadget/udc/pxa27x_udc.c
@@ -2398,14 +2398,10 @@ static int pxa_udc_probe(struct platform_device *pdev)
 	if (udc->gpiod)
 		gpiod_direction_output(udc->gpiod, 0);
 
-	udc->clk = devm_clk_get(&pdev->dev, NULL);
+	udc->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(udc->clk))
 		return PTR_ERR(udc->clk);
 
-	retval = clk_prepare(udc->clk);
-	if (retval)
-		return retval;
-
 	udc->vbus_sensed = 0;
 
 	the_controller = udc;
-- 
2.34.1


