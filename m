Return-Path: <linux-kernel+bounces-343295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7E7989940
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 04:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 845FC283B0F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 02:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E273C1CABA;
	Mon, 30 Sep 2024 02:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Njc3DuiE"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010021.outbound.protection.outlook.com [52.101.128.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758A61CD2C
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 02:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727663652; cv=fail; b=ayh3Deb0CrPyi7LoCi8SunE7e9mlXXfOR7HdFSq8kkJZgx9gQL7ipyuGURGI3wrHtObLD2SEhQ32JECPIbHXINQSzq2IPuL9f6WPaIQP7jcn6HWxEwwKap7g/iVG3r0d1nlFbQP413O0tE4ydX40oP7Qcg8QBbT8JW81nE0YsTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727663652; c=relaxed/simple;
	bh=pIKU2MJqaJ9rz9qbRQ+oG/QSxcAiNOdjeQJ4bNhJHwk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=T30Nh9LqEGcn0++Km31RgqM8qDH5wRy/bDtm0xr9iv7FOsqM5kbacVmDPPiPD6bNuMNvsvRwi6RFcbwtNIf62ICBVv2m4F20W9ZwDKiaiI0PqouwLj2aSOtnkWi9bObsGNvtoWUwo8aEI1lUfBguy5ez3kYTLgnAIxXJk5q8Yik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Njc3DuiE; arc=fail smtp.client-ip=52.101.128.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MphKJnNk3aWJtYfnGgIr3tMvFE1FLBxIoQKDT/Ul2nYj6nCSxWsgDcuxhS8Qn2KQOxLgbtGKtNcyWXq6PRSb/C9BUsMZk92k8v1DHZTGB6hxPFRipu8U6a1h+nJv65wEDSYUAMJfjdR2OuI7Vl7rpRuOXJ5n2m6EGXtJRSPzTfAWTXxVAzsDaiIZOGJ30d4mcw1fKcAf+aShrAumqQBiFaihwsW2NxzAYWXD+SMsGmR4uO919iKYDKesqBOOPo6Q5iUjSLiDTuNGIo7loRVn7lr4qn9Pwo4JzxKAWd+l9a1UgA7b6wBmZV3mWKB/nK8Wogb8utkgoaPheV6fh8qfBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7G9YcDF/Swzzy4ETF3Lwetk2KGkWIFeWl2DFQ0D39g=;
 b=wER8QwTUKwUzMB/hqnCBZsM1UAK0VjMg5heLf61FM1UCKqM6ChIlydRrQOcSRgyFPILhyJXPEwnqtP4pOgjUlAOxoOYcy0cWJc+JcBwSh21MciCfHmWWoUxX/MNd5yam5tolsXwzelRehHYR7tcHhAbQpJrj5jQEjLgs6AC/0YAP/MSZWCViOvHcV8N2llo35xBdGe/24qtN54T5brcrzyQlOQmiRg/rvWAzU1QRoskd+02VDcqX/yAICNpoHyABGjIk+3fayFUIY0B+TpQR9dIOfZ1L1/hkx7ima5fI7A4IMzAnU/lRRhPaANX1MgMFD8oCyIbbz8tImKrUUkTnJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7G9YcDF/Swzzy4ETF3Lwetk2KGkWIFeWl2DFQ0D39g=;
 b=Njc3DuiEh1Ryizf63zXpNJHgzZRzcjgPbYJbVCJ2w1x2xJcA6jb/J4ktH7axqcWFn6yRf4hpNKnVueMDigqWlprA/KQNRwXCGeR0rw8poqE1+H10xA5bWBsTdNLvuc0gRy2VkB1IUYsq/9GDNVDDEsyOEhHj4nwU7c3lddikzyIirOvW7P76HqdkM29WbBk/NcaePxfr/98Xow6P7QP77o8YxulkxQFhIIBjHUmZDOPJ9/OExgJumc5vkb8xwlxW4OOmpUiWTWuC22lr2dKvVfDoZKXzetLx97t3p1GjUKfY6+2iY1xU+Du0D2VCUw0xX0WYc0w+FDsc+wWbbcmhlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com (2603:1096:101:e3::16)
 by TYSPR06MB6314.apcprd06.prod.outlook.com (2603:1096:400:417::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Mon, 30 Sep
 2024 02:34:05 +0000
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce]) by SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce%6]) with mapi id 15.20.8005.020; Mon, 30 Sep 2024
 02:34:05 +0000
From: Shen Lichuan <shenlichuan@vivo.com>
To: o-takashi@sakamocchi.jp
Cc: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Shen Lichuan <shenlichuan@vivo.com>
Subject: [PATCH v1] firewire: Correct some typos
Date: Mon, 30 Sep 2024 10:33:44 +0800
Message-Id: <20240930023344.7535-1-shenlichuan@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To SEZPR06MB5899.apcprd06.prod.outlook.com
 (2603:1096:101:e3::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5899:EE_|TYSPR06MB6314:EE_
X-MS-Office365-Filtering-Correlation-Id: 189dd84d-fa94-46df-51ed-08dce0f85a15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tDOaxE5uMtVsPHvOp8mHuxgP455jmmAfrlxSe18Z+rJIXS1edDVxZHFe3B8y?=
 =?us-ascii?Q?Su5XRlsXRiIjuVgFt8+7saF54AfKt1aEEQaL/8nZ1Vh6WyBal96lPBhPfMEe?=
 =?us-ascii?Q?n1Od0eXcuXinZKghBpI2ugnKi+VRBuTJwsQyxMQJLfHJm2npZE+lXlNAyhKo?=
 =?us-ascii?Q?HpGxo4rbaTIUNvVnHfpQTrF3XQmEtUaFgjbFbY8J1MBBEoKHYqB8gn5MDDyf?=
 =?us-ascii?Q?dniY3UhaZfya3BvQ5s5V6GUIJpIU3VROzA/JmLk1ulAb9DmtVf4p0Io3GpEt?=
 =?us-ascii?Q?fr9E+ZfIKkB9hzXp3dLOuQUHHDs7ugspihtzS3/gVtHBamuSzODBPAIjHpy7?=
 =?us-ascii?Q?Q+VHsuoeDghzMJSxwR4KoKmwK+fDJwaMZApfDKvtQtSlqWzbpHNjrGOrPGoR?=
 =?us-ascii?Q?ujeT73YAKxIHHZHw7lpsrGZbk82rIIUlGJiNyOHYiuvEZSsohtbvrT5ZxGi1?=
 =?us-ascii?Q?gHLXXiaCN34ewRTBqpUk2TEgmWP5rwLssO8bKbiIopKSGpSdo/HcyVfRiUbH?=
 =?us-ascii?Q?aKVkiLk04YFGKhbudK1nfDmY6WEUXQISb6u4kh1OBBuu/K9G25z6lSWP+e/e?=
 =?us-ascii?Q?A5vcDArkU+LCkC98Aw0txcYIEKwR5KTLjLIxrTBzftBB+wnqFXkh52fKZIRh?=
 =?us-ascii?Q?z/ncfVehVN7Hm25e7V/Sel3wqJSdl7p8IKB7F2y8P2UAxFJqB+fwUlPQvomc?=
 =?us-ascii?Q?8fd2OShRRVX3NUaQJ6NAzPbCXnCHeOE3uXoUGLanF+2O8qy8J3WLFHhMw72d?=
 =?us-ascii?Q?Rzrh21sK4wSol7bDrM1cs7QoHcOjeFDOMJ2xQt24vKlwLRuDTR253JShBjVZ?=
 =?us-ascii?Q?PqEM8MLyPC+zasBuJCpPbtf0skqlYcRqXT/FtR0jtOBmbYgpZF8hANfiJFXw?=
 =?us-ascii?Q?qLH/Zy0DhGvulU6O8g7J8UlRVQq0NNub8MiEsRuMNN0epQ24CD33zrhWzElG?=
 =?us-ascii?Q?e5MG93xCHhWjWT4sj2owgjH3+yjWUd9KXTyQvJ13yMZaeeqTcv3u2l66J0Ma?=
 =?us-ascii?Q?nb/u7zrCDH8GL7KnVtIH+0ALQm2XqU2jzI785mpK4pRF8x4ewHDNS1W32FCr?=
 =?us-ascii?Q?v58yhbSuYshblQ/i4U627ofU0N08riOhTvfrvaUjvcs2UNy+Q9GD+xFmc3Wa?=
 =?us-ascii?Q?z3QVoQobNq/llpvNbxEpvDbZ2NTnek+30Cdyubd/tyyN6vsmLtFu+cjCV3HV?=
 =?us-ascii?Q?n9BECPzddLyUTvJO1GKQfh8aPsNcepe1X/WjgiC6+bycItZO5RYYW6HpL2ah?=
 =?us-ascii?Q?j/1U8eUTng8cQCqPD9aDfGtjDea4w/nzA3H9Q3E6MmWF4bere+kI2hduarF4?=
 =?us-ascii?Q?vKxoa+dztGJwPJTRbHQtTHNx3tkQ9UzxQfe0EQLDxThwo3/nXp25tJfKanOn?=
 =?us-ascii?Q?DNno30ZDywMbWhXNocbtjbKoiO9+Yoviz2a5+UPT9+D4wEWyog=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5899.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gjQB8aRmJhKlKmR5xo8hqCLV+a80Jz0Ewr5uFW2Q868c0Gt0y8fV79WUI9bo?=
 =?us-ascii?Q?hu7baM16fWxRDI0KChqMbbCBO4aMyLi926U6yIcYzvKLMHK1y/r0mVWJ1+sk?=
 =?us-ascii?Q?vs5pmsmJ3BTTsxRL1IRK+GcgWlH33yylf9MXwPlUk2f7AmhuuYMy2jmPtdzM?=
 =?us-ascii?Q?lDw30KoV9ONgvEFpmBb0H+CyhoD3qd9eYnRIfjtMcMdqtEWA4f/pkajW44wp?=
 =?us-ascii?Q?bY/UG1KWkDjtxbatQbM6HFunjVptEd8BnlsOy5Gc+zlz4Mc7hHTdT2JDgeFG?=
 =?us-ascii?Q?k36Nkf+LBy/yepQZAK11NNC/ve7zXqqTUyFT4fO0exK23NHGYqcbw8lyUCV2?=
 =?us-ascii?Q?95DZ6qnZ2n+AnXvyeDhuREQfUDmWzd6M3ZEWNkkDbNflDbHYNpKYgxkBbR6i?=
 =?us-ascii?Q?DTkJTYoxibfiu102O3/fUDPI7wwfesf2Cp0DcDBuJKhblncTFXodUKiYPt4O?=
 =?us-ascii?Q?X/FcHN0TokoS8nsMe/lP8xgKFs9pU0SBbWMr0qFFGlHjyvLuR6JyGwhoDhlr?=
 =?us-ascii?Q?Wt8km9ZtNprPGPCer8LbBNREMOKb60aFEMUEjp8zONMswXSNND9ZdUovZHkV?=
 =?us-ascii?Q?Ek+nLDMyY/ZaQEXztojx6dzzew4MbYw+YD75huj4RbJOukUHXPwNSLmRUpNf?=
 =?us-ascii?Q?N80YSKInGXi0Ua7hAInHw4kosFCtFGrGOk4EewHpPL7c4o82fT/7Y/lyhjl6?=
 =?us-ascii?Q?NFiRqlj59iZ5oZVK9P/cOdljVWRTzTdViWMUiMvu55L8CCLgg9+SEIXklo5M?=
 =?us-ascii?Q?umhuu1E1KP2K4B+xS9LxseN8ru4sSFhs+dPV5HbGzLtqkshAZhf+fiYowx/S?=
 =?us-ascii?Q?egmEAZ5h1K0aaT/DoPrbtgPSchph7wQaEt1/FLQcms6GQe60HWvEROs9wkxN?=
 =?us-ascii?Q?ZpoKtvvaFYBG1riOHNQiTd0jTj8zryOCgHFhL7pq3xdVAd82Q+BXKtl38afd?=
 =?us-ascii?Q?YK7qV/vqfxWrY69jIhGIvqMTINCVGLFnRoydb+/wxpueqKUiEMZZRg66sMuE?=
 =?us-ascii?Q?oOCPY7CjpPbEs812phmc/St/4MvzNJbb/OsY99YohYRf1XAm1oacXoYpwOdF?=
 =?us-ascii?Q?pkdbeoFdFNV9U78/RDAPbiYfBxJ3c59WVxi4W0jF4ZBSbLPohq8JP+LEIGZv?=
 =?us-ascii?Q?yRAzIH10kkSvjYrSxbTseGvaCRTTiSwFZz0Ggo6ep/aX+bJgNnoTcTbuTQwC?=
 =?us-ascii?Q?Nani8kqikJXiE/yUTq73Ac/4ZVHue7rUjxGTGWkOfzlutLsLTUhhN41SZjNs?=
 =?us-ascii?Q?aOpucwygc/DWgsyIyxMQq3LPDPhAcF+gfC3zqV7kCkL1md2Mm2RYoci5G+rE?=
 =?us-ascii?Q?CkeM4NaZ8ei7wy5pZSysZlRHiuv1UP0o8MgER2mzox7kavlMN1q9Dcq0iMbT?=
 =?us-ascii?Q?2ccgSb8yVItEQ3jJR77gNx7gIvaEX0Jmi3ji5cMlQkLYuRayzpYsI91oe35y?=
 =?us-ascii?Q?e0DPbeorCgQpeYjnoW1Fv4hl9nlDO5oZ+pzmh2OogKMF/NKwIcFKIlZ8OYc0?=
 =?us-ascii?Q?8+EDBtakpHtV9VTXcbppgGySN/sa+PVWmditVFge7den1na0EmSF5B0a287K?=
 =?us-ascii?Q?+Jz8nQ8tQCEfjD8zzotQ2t6LfUdbJiHm1dv4P3i/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 189dd84d-fa94-46df-51ed-08dce0f85a15
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5899.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 02:34:04.9437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EA/f26TaeoDgH/S6Pp85aK7wNMNiW9uh2fb907zEQ+t8TVjbAn2K5k6zstWVu4cuMGsw98f3NJZToG0JDpsVow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6314

Fixed some confusing typos that were currently identified with codespell,
the details are as follows:

drivers/firewire/core-topology.c:59: containted ==> contained
drivers/firewire/core.h:83: reenable ==> re-enable
drivers/firewire/ohci.c:1387: apppends ==> appends
drivers/firewire/ohci.c:2216: superceded ==> superseded
drivers/firewire/ohci.c:2617: litte ==> little

Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
---
 drivers/firewire/core-topology.c | 2 +-
 drivers/firewire/core.h          | 2 +-
 drivers/firewire/ohci.c          | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-topology.c
index 6adadb11962e..baba31933667 100644
--- a/drivers/firewire/core-topology.c
+++ b/drivers/firewire/core-topology.c
@@ -56,7 +56,7 @@ static struct fw_node *fw_node_create(u32 sid, int port_count, int color)
  * two cases: either the path goes through this node, in which case
  * the hop count is the sum of the two biggest child depths plus 2.
  * Or it could be the case that the max hop path is entirely
- * containted in a child tree, in which case the max hop count is just
+ * contained in a child tree, in which case the max hop count is just
  * the max hop count of this child.
  */
 static void update_hop_count(struct fw_node *node)
diff --git a/drivers/firewire/core.h b/drivers/firewire/core.h
index 0ae2c84ecafe..9b298af1cac0 100644
--- a/drivers/firewire/core.h
+++ b/drivers/firewire/core.h
@@ -80,7 +80,7 @@ struct fw_card_driver {
 	/*
 	 * Allow the specified node ID to do direct DMA out and in of
 	 * host memory.  The card will disable this for all node when
-	 * a bus reset happens, so driver need to reenable this after
+	 * a bus reset happens, so driver need to re-enable this after
 	 * bus reset.  Returns 0 on success, -ENODEV if the card
 	 * doesn't support this, -ESTALE if the generation doesn't
 	 * match.
diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 7ee55c2804de..4dbd20360223 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -1384,7 +1384,7 @@ struct driver_data {
 };
 
 /*
- * This function apppends a packet to the DMA queue for transmission.
+ * This function appends a packet to the DMA queue for transmission.
  * Must always be called with the ochi->lock held to ensure proper
  * generation handling and locking around packet queue manipulation.
  */
@@ -2213,7 +2213,7 @@ static irqreturn_t irq_handler(int irq, void *data)
 
 	if (unlikely(param_debug > 0)) {
 		dev_notice_ratelimited(ohci->card.device,
-				       "The debug parameter is superceded by tracepoints events, and deprecated.");
+				       "The debug parameter is superseded by tracepoints events, and deprecated.");
 	}
 
 	/*
@@ -2614,7 +2614,7 @@ static int ohci_set_config_rom(struct fw_card *card,
 	 * ConfigRomHeader and BusOptions doesn't honor the
 	 * noByteSwapData bit, so with a be32 config rom, the
 	 * controller will load be32 values in to these registers
-	 * during the atomic update, even on litte endian
+	 * during the atomic update, even on little endian
 	 * architectures.  The workaround we use is to put a 0 in the
 	 * header quadlet; 0 is endian agnostic and means that the
 	 * config rom isn't ready yet.  In the bus reset tasklet we
-- 
2.17.1


