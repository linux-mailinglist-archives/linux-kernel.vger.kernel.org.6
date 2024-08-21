Return-Path: <linux-kernel+bounces-295470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 218F5959B5B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C3821F24309
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E2A18A94F;
	Wed, 21 Aug 2024 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="pfOYb3OH"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010045.outbound.protection.outlook.com [52.101.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B0A1D1317;
	Wed, 21 Aug 2024 12:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724242291; cv=fail; b=iD/2kf3Ow5QyTlzsZ1JmJIgtD/rKehDbgPaXFPFLHCX5CxodaX5mrTv/insiP0WtWEdUsmcOCkG2Rsn5Z+oSXUrA41eUrOk7y7h6wkVfNqNfqPt/3yWspJNu6wdWFPtYnR5hrN2mlweCCJFkfpSZr/M8N+Z/VRO/8YyU4Gpr4Kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724242291; c=relaxed/simple;
	bh=4JEh5659lE4oCzyGydPMyjW1bqFusCVtsG62nasmUeo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z7U5MJoMhUjsN0dsTY2sYWr1R4eYqlldPXC1n+W+Zk5UV7awV7qfyBqWIaS3sztwNMxFIr6ItdiUyAm9gFfUTYTPDIyq/GF1WyLEh6/0LbSmvxalh4mt/6CM+u6Bdn+0dF2j4AFfsSMJt9R9qoISyxi+jM2In5Q6fMcYZ29cUG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=pfOYb3OH; arc=fail smtp.client-ip=52.101.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ekg38x9XGr/D300EVQ1txNZ1U7ZFdaTr3AKC9Q4x5PsSDsSOfr4pAthNYQLaiU9rR04Aw3dVz/08/0dPII2KOqI17yPa496jmB6jqDGe4llKI5jgcg1i1vMY1Tmtf9+vqRh+lCzoGpGiHuCOTCOIQ02/eRMd0aQeM/p2CjH2e2D4wi5rvtfuwYLxMZ0HZZf4dJZ/iBMp3gXRmBJMDC4YWbiIc1I5CXMhzEYDucFENPwukraRj4xRUmWK1IJoni6LmWI3Q+Fx89XRAJ3/J56gMjqqv5cU6oVqE0rNm/0mXK5EsiK2wRbZWXYDwYSufU1Cmp/sH/DEgsnkkL2txpnOmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYwqVf5nC1G106y3/JeoEY92jkLlLo2RAUiFL4iAX5k=;
 b=t3Ucl1XkoJCNK5Y5+r/rmp9rskINXn6cdWMrfCfHkCw1Zlz4LV6sYaaNaHgcCa77cTLjAYD98poet7eJJf9lZc4cSO5q0C0iYc/X/VyJtdLoy151IGjHR4T3+2LqbenS4weKQRwP3vpUvY4XhKkYAhVX/xEZiAnlnMGuWsvBYMxrQYdpnkZKTVfISw3JsX/24TKG6ESmn/SfVDAj4rCbpP6qNIWeEq8NWe4P2MmlxqAtlaTGXunf2Sm9EvwMRpBRArkDoYtqelPHSau/+dfFUYF/GmrKn7nY4o1O7zRwmXokr2xZW5fKNbDfR0bQ4fWqlNby4jCykqr/wDB22DwiZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYwqVf5nC1G106y3/JeoEY92jkLlLo2RAUiFL4iAX5k=;
 b=pfOYb3OHyPGw/rNEPld6I6QzJVvd1jR86diaWPcy8jTN+bgaWoXfOyBrEwQad8HbdfTiHWIKlqvwxEddfae8KxGRsisu/35fOk5zPFKf6KQdvGWXxklz/RjTiXtWUZPeK48skFqJzmFrITuaG+MAi7kMZrm2g3U8bOht34yipD041PQT9YHp0easXdzLLI+ql28hoFEH1Vd5O0KKXytJFQjUN04hHNmtbKEpb/bRYdKvQ7SfQ8a1osHwXp7cNOAwi3NWE0XarvSbQvK7gylqeC3lWy/FiNbRJkXZJDZMtHNBfB4Bm8hIrjgBxBQiBrcbR9mYb4T+tgAJAWSfyVIQaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
 by SEZPR06MB5667.apcprd06.prod.outlook.com (2603:1096:101:9f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Wed, 21 Aug
 2024 12:11:25 +0000
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd]) by SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd%4]) with mapi id 15.20.7875.023; Wed, 21 Aug 2024
 12:11:25 +0000
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
Subject: [PATCH 3/5] usb: r8a66597-udc: Use devm_clk_get_enabled() helpers
Date: Wed, 21 Aug 2024 20:10:41 +0800
Message-Id: <20240821121048.31566-4-liulei.rjpt@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: eb0bc62f-4d6b-42c7-c9bf-08dcc1da60df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|52116014|921020|38350700014|41080700001;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nzcr//cfZRl5SNldIGTu+NAG8YLuSv9LPyT0xR+nyFNbOxGCTp74OE41Z4qy?=
 =?us-ascii?Q?2LCD+7NiYnC0nFoo2+7KNFVViFN9IgQZiyVvt7DtUGMiCfsY8sAHbk69RSfe?=
 =?us-ascii?Q?uYy4YMEt0QdgqAonChe4Gk7X2LSrZqGZTLSQpzQGzO0BOo312+ot0igcsx2Z?=
 =?us-ascii?Q?60aEbldkv2ZLDZsAu4f9ZWVhCCb8phMt3SxOnseFNUS+lFKED6n5SZzami8q?=
 =?us-ascii?Q?28wtGvPomr/Aiw64OaXIIouRgaB75uIeMna/ox3KuGBPTPCdvUycrGXWHf3X?=
 =?us-ascii?Q?mozhB31JrAqkX0ia9Kwg2P+B5MUaXGGbSe/JUyri1eAmFh8cdV5c1voy9bV/?=
 =?us-ascii?Q?JuwDqgyNO2upKMjNKa1s0ttTN3q6tNZ6JnzdL+KrABIpFD9KYdaGMEteV/ep?=
 =?us-ascii?Q?84QW+O9HSwQ8gn56mgESxkHaT80QmzebrhXqKJIiaZeFR/j9YFULIr7PeNc2?=
 =?us-ascii?Q?NkuVr5vOYfs05QqYaeFWwQFAw1YVjzgnqjCkfk27zgR2jWuE6MiHf6iMf8Jn?=
 =?us-ascii?Q?Bf/J3dd5YVYvROEhXxTwJesbGYxq0qVrvFgVrQfpQx7cwLZWLzCar/UnfpBE?=
 =?us-ascii?Q?3aH3WOyBGNq9NedQ/cEpFN1hZKqdC2nQoQ99USgouAkCYcPlyXmqmTmcQbCW?=
 =?us-ascii?Q?VFsfGmDaj2/1U1CA2v66wRMr2zAHsrg768d5U6NMYWuKMEjO/Klb3atl2BWV?=
 =?us-ascii?Q?3C2drRcF9YwwzfSjtWY+ZVVVYZmOseJBKoLyJ1SZGnlmLROYt0k4h30Vujk/?=
 =?us-ascii?Q?7K3vZKqGuMBHh4T4Dl3+mbK+0IWVArZ9IBVWWuQol7iPbCx/E7U6Yn+MZ3Qc?=
 =?us-ascii?Q?SXaFuibssjJTbRI3zn8vgwCkxKR4MXdsfGFZVJincKlwhKumg4c4YXZh1rAe?=
 =?us-ascii?Q?F+0Xp5opzV+klkpgF+wsHTKpOE4PBBEu5Qmuba0RSecHw7ozs4ZAleZr2xHh?=
 =?us-ascii?Q?WFjTe8uInK1veuhMEK2RoNk20cTmYSDBglHor6BkWIkS8gg0G6Yi8Q0NIQGI?=
 =?us-ascii?Q?v7CMYv8qjDKyKmlGUsdCTLtRUZuik/9k1BvveT7V1Ahz6EVP4bN5q/laBLlM?=
 =?us-ascii?Q?kKKkFfmQX8cSj+eVAwL1Qomvdj+Xr/RI/UyEX08WJpTtWKGnmp8EstCZ5wqL?=
 =?us-ascii?Q?sOgQX3ZEgYxBKOrzQ7SP16jxsqidQfP4W2Dlhvf0ciSErQVK4Le6UD+LqIpk?=
 =?us-ascii?Q?48rkLqXt444/MqeZramFbedT5jC16nYH7hzGfEG5/vznwZ/G4nzgk0+XePuS?=
 =?us-ascii?Q?x7anySOD/rgYnL0UXfUXj3AbmvWu/DyMgbstwWXOoNbUqo/GUqnlNj/Wwj1z?=
 =?us-ascii?Q?OJHf4IyyEcdFtI68WeomanzMvyub0Xlm/NFeLzY801Fmn3BWmZmNlQNeQoAr?=
 =?us-ascii?Q?UyV49dB1S23DhJTR5a+NlgCBS9NQMPb/6yMgiUT+Q1ic+KIlh5pcANjcZExc?=
 =?us-ascii?Q?RDOw7KKILSb3SiB1/P7bqlWbltUVkDr5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5624.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(52116014)(921020)(38350700014)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?87PvIVu+H1G/bN0I27Tj56MsmNXV2PYHJhAKlOeGCtURjGo0whHEFBfmSsPx?=
 =?us-ascii?Q?kJkk9HhDt+/+tIxS/NaplYwsBu/HljEaxBf+xgUy3yjwYMdiTTHbh3yUiVyR?=
 =?us-ascii?Q?1AeuhvbUgZgHJbvH8eHYMZsf60ulFsPnou8QletuG8NK+49UpvS1KVoCkXEA?=
 =?us-ascii?Q?9Szyf72zjgINelrfiNJYBsiE6+R5HYUFDk75AJG+qQV38lcrU4z6fZwIfqwY?=
 =?us-ascii?Q?RT+fclvoFW0Wjxsuh6uVJRVz54aHioBpqtzKJLWBtD+Z8/p6OQ7Vy+bKpe1B?=
 =?us-ascii?Q?ovtBcuQASCaE+T08alRBjYIVDXYqVV0dzqOrdY0/bgMg4P2UPTHMhb0/e/9y?=
 =?us-ascii?Q?Vx+aJUQfidXjDzb+u8f5WnIWIoSe9xYsHFr7OVhm8GI2rrYOwVixkrFrSsDR?=
 =?us-ascii?Q?C7FNXO+jsvqNYinYELDDn6OnhzzXMF16mZAGntTr8o/9qojX2gR/mX/s5rUw?=
 =?us-ascii?Q?IEb6qayKzLnyx63/wMqOFDOtJ0UoP+f4AyCdvBFgEv0tp9P9nawcmQTeIfTX?=
 =?us-ascii?Q?107egRXaZ0FWe7wWd97TVPyjNEVg+15VOo71SKyCJYp00sYtQhNF3jXMhNOG?=
 =?us-ascii?Q?871wbwJXLgKSVLizKvCHUfHw2K1ynupMo2g0xLXQ4oT/9KFUbwkU8bEHn8bD?=
 =?us-ascii?Q?dBeNh1TqcspFwvwDUHr50jdOIapJc517cEE3gTXuYmqem2G7xXJx518mCwQA?=
 =?us-ascii?Q?kapHIcnvOZyty9JyLKX+bjW++5fXsjYswEpmZP/kuMGXylaPNc9tYxj2o4z6?=
 =?us-ascii?Q?MK2Bri7mTy75u0P51mHe5zyt1uAl64vpuuEbWFeci0ebx3+qleHPfW3WIi0a?=
 =?us-ascii?Q?aQPCZnn1ZgGXKEs2sISFS6XhABec2V14wCwkcSnLwZefmZ1kueV92ZZUJkmP?=
 =?us-ascii?Q?TnbFX3VR2BZFr9GiEaUcBhPnI5DL1xNEZQ9IQdPyha26S09NsM4qdU3YmwKD?=
 =?us-ascii?Q?Zaykx2XBp3fkrkCiDRlOcLf7kKdoJlTAXbqPhKLtL3Nj+4WhyFTOlSq5LJrv?=
 =?us-ascii?Q?oovvJfQicmDC24sBvLrDe5NVScMly1d5lp0zUmyBk4s1lEzh3d6tpoYpCgQP?=
 =?us-ascii?Q?L9O4/8MyHv3Q6EqRiLKvdN8FeOU68p57W+rIAVZXaeMOe+V30o+JBU/lFX3J?=
 =?us-ascii?Q?okTwpawgSCknbcpN7TpK+v8As9gETh0FNKsmoDTIJnGjApfjXYOLQyyXgGbu?=
 =?us-ascii?Q?0GCvL9c8V1c425AESNuTFRmzs/gxQLEcOkyabntO1wsFCugW51ReR2AqPJMi?=
 =?us-ascii?Q?Tl8qJt6ub1xhqX3TK7tanNJNqY4DPRRyKAXycg6G3QL9YNg2lb08CRESCSCs?=
 =?us-ascii?Q?QTgLqB13oJUYSHi38KiKDWmY2UZ7slFntsAWF9bjdvWllFbWUYK2pzyqDow/?=
 =?us-ascii?Q?o1sD1anIVO5VOUXT3o2s5EoPJr4gy8zF/ZC5gYfI5wiG9SifLtn7hM+yMxRo?=
 =?us-ascii?Q?71qYDyqPrT8UlAqEEMP1Z8oMYbxgXA8BY02ICHlIKBO9TNVUXcsc6nMGS05M?=
 =?us-ascii?Q?5uUWcl6brav3UsgHCeQU1AGTAwIkSGWtf6Pny7ZBQNbbwM4H8WHr7LAUC+fG?=
 =?us-ascii?Q?B7AdgrUHVyhX+qzDRcYKK07v4Dop1Di7mGcK+SBJ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0bc62f-4d6b-42c7-c9bf-08dcc1da60df
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5624.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 12:11:25.3827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S/qUDBEhG1LgOcgip+bwHIVP7Yrwj6HBkNfmqAoswJ9fPCgiJ22Vq49MY/SUJdLEEkdm0XjtS2KpGNuQqx3rwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5667

The devm_clk_get_enabled() helpers:
    - call devm_clk_get()
    - call clk_prepare_enable() and register what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids calls to clk_disable_unprepare().

Signed-off-by: Lei Liu <liulei.rjpt@vivo.com>
---
 drivers/usb/gadget/udc/r8a66597-udc.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/gadget/udc/r8a66597-udc.c b/drivers/usb/gadget/udc/r8a66597-udc.c
index db4a10a979f9..bdbe5ead741e 100644
--- a/drivers/usb/gadget/udc/r8a66597-udc.c
+++ b/drivers/usb/gadget/udc/r8a66597-udc.c
@@ -1812,10 +1812,6 @@ static void r8a66597_remove(struct platform_device *pdev)
 	usb_del_gadget_udc(&r8a66597->gadget);
 	del_timer_sync(&r8a66597->timer);
 	r8a66597_free_request(&r8a66597->ep[0].ep, r8a66597->ep0_req);
-
-	if (r8a66597->pdata->on_chip) {
-		clk_disable_unprepare(r8a66597->clk);
-	}
 }
 
 static void nop_completion(struct usb_ep *ep, struct usb_request *r)
@@ -1876,18 +1872,17 @@ static int r8a66597_probe(struct platform_device *pdev)
 
 	if (r8a66597->pdata->on_chip) {
 		snprintf(clk_name, sizeof(clk_name), "usb%d", pdev->id);
-		r8a66597->clk = devm_clk_get(dev, clk_name);
+		r8a66597->clk = devm_clk_get_enabled(dev, clk_name);
 		if (IS_ERR(r8a66597->clk)) {
 			dev_err(dev, "cannot get clock \"%s\"\n", clk_name);
 			return PTR_ERR(r8a66597->clk);
 		}
-		clk_prepare_enable(r8a66597->clk);
 	}
 
 	if (r8a66597->pdata->sudmac) {
 		ret = r8a66597_sudmac_ioremap(r8a66597, pdev);
 		if (ret < 0)
-			goto clean_up2;
+			goto err_add_udc;
 	}
 
 	disable_controller(r8a66597); /* make sure controller is disabled */
@@ -1896,7 +1891,7 @@ static int r8a66597_probe(struct platform_device *pdev)
 			       udc_name, r8a66597);
 	if (ret < 0) {
 		dev_err(dev, "request_irq error (%d)\n", ret);
-		goto clean_up2;
+		goto err_add_udc;
 	}
 
 	INIT_LIST_HEAD(&r8a66597->gadget.ep_list);
@@ -1939,7 +1934,7 @@ static int r8a66597_probe(struct platform_device *pdev)
 							GFP_KERNEL);
 	if (r8a66597->ep0_req == NULL) {
 		ret = -ENOMEM;
-		goto clean_up2;
+		goto err_add_udc;
 	}
 	r8a66597->ep0_req->complete = nop_completion;
 
@@ -1952,9 +1947,6 @@ static int r8a66597_probe(struct platform_device *pdev)
 
 err_add_udc:
 	r8a66597_free_request(&r8a66597->ep[0].ep, r8a66597->ep0_req);
-clean_up2:
-	if (r8a66597->pdata->on_chip)
-		clk_disable_unprepare(r8a66597->clk);
 
 	if (r8a66597->ep0_req)
 		r8a66597_free_request(&r8a66597->ep[0].ep, r8a66597->ep0_req);
-- 
2.34.1


