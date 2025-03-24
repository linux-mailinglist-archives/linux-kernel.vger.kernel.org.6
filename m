Return-Path: <linux-kernel+bounces-573080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1076A6D2D9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 02:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83D403A6211
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 01:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3585411713;
	Mon, 24 Mar 2025 01:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZXgj1x51"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2089.outbound.protection.outlook.com [40.107.241.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDEBA927;
	Mon, 24 Mar 2025 01:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742780249; cv=fail; b=d1TkPjZZXPQylLV74lghwSbHWrleS7HalTC1KP2R97ud3xuf/wiPF7IRymzAfauaP9oWDR/S7tpZXZqC/1GdF5wh+HmptFjOo3ffCEQtCpEYTKUqtvR+azwjj0QsTACXXsprbnbz2V0AAgg5HZLJ1mW3M1KJ8Vkq9I1MKVmiMP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742780249; c=relaxed/simple;
	bh=0fqgJxh9nVa/K27UcM6bF12WB3YBM7R9PiAf8GPJThI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=uVvqL2wRAhlW+iykOljo9PNYyMRi67f9XxdwIU9tbLoC6l14rdUbFnWe4yojKt1Hu730jA4bZHwBY3avPYuco0VtVXCh7IO79v5tGu+ZN37gqB3LG7xRgns8og19B/0yBg75a+bpZbD2mD8iutXn5GcuQ3YOTOAz+wHRnHcK4/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ZXgj1x51; arc=fail smtp.client-ip=40.107.241.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gapygLRW/0uH4cndzE7kidaBtnqNnAn6inir9tAyMcnymXhO9Lgrp0c3gcY5MBsg7lhMSEGmMdNYq+ac49MXu8yr3aC2E3Z16vF7WGQpXkwG9Pcj+CbXT9jKM1HdpHcwegbSjs1SuJzsZv4tiPcFe/ZHkq+o8+rr//iWZeD/UUePBvKQtYiEj4IytiJRMxuMs4rdvzIiSgaL7+NKNvvmhcnE/8jihF7T5/gO1HMol5C32Ohraj9MIUEt9T0W8zo5nydMefLWCAvVX4S27AdChgAbybLX6hfTOo3UL1yq8trtVRitRCpo8zwcZvVf6qamTZdvhRz/9WnZ45282V3Kng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ba68gg0Z6In0IPo+eUHBXpEP0JN/nbom6PC/6EfA+F0=;
 b=KF4l9COTqxAw6jhPGeLNnvG7BP5+pg5ARvBX4Q+6+teD1ND47RwlxfY6yqEcY7TcvMUKcWIVkNmbX6Mo1RlgLfFlgT06jbhcVy5F5l8qdusSOeWtgeGe15IPl1rwNZsPBer8fDlmDV73oC76d9bq30NNXhTikamWbZOohHh0zCGA6JcvJPe7ohk6w/zQ3XaLKuzDquoBnn3/KggjSW61Kam19FKBznzjGRIiJG5l3MxKNnSiY+rwN1yHSxJSodbnZVqGJSXcqAYrvwCI8jNzcBC/1LG2Oht5wckT9fNaSyvlyP1KbOGPwkAOjmCYX7H9Zzr1nTgywYs9Z+Dj+N0/PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ba68gg0Z6In0IPo+eUHBXpEP0JN/nbom6PC/6EfA+F0=;
 b=ZXgj1x510ID0LGBiBh8da6EEAuOGFVNPAMMpMkBOhgrQp5TVPKWuI2cIyeaMzhvKVlWvbL7n1sIawgImxk7QOU26t3Hjhv7FVG7ioifU/KymrFqpMYW6XHnyDL35yCQzfVDaFTV/6KP7HkCHkskuDH9X7DQ9tPa9wyW/eaK9bkeisOn1Y7x+7CD+XIOSJoH+SQNYt+FudJOBoli3pfQdqfMj8h0xm9AVAkYi/ZMfGN7Vi/gzrGQgDobfEXC2pjk830JaNbaHnrKVh6OUpEuybVtJCN/xs9fLV18+WlVyvSZWRJn4baaI2RhZpkuSsQXIJ1HgD3ywaGkEoX6bAddtBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB11024.eurprd04.prod.outlook.com (2603:10a6:800:260::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 01:37:22 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 01:37:22 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Kiseok Jo <kiseok.jo@irondevice.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org (open list:IRON DEVICE AUDIO CODEC DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] ASoC: codec: sma1307: Remove including of_gpio.h
Date: Mon, 24 Mar 2025 09:36:07 +0800
Message-Id: <20250324013608.628513-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0092.apcprd02.prod.outlook.com
 (2603:1096:4:90::32) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB11024:EE_
X-MS-Office365-Filtering-Correlation-Id: b6ad766d-73cf-4456-cc31-08dd6a746c1e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eWaTPzm0GGjmjO/PHknqXxrZrxAash685N8zG6UNYY5K78CuJRWF4h75sNPJ?=
 =?us-ascii?Q?29zI0SXsEjWjTOcipBW/W65pj0N8b/hcDwR5MRQE4lHYnQEJtmpr+qsCLNAs?=
 =?us-ascii?Q?SvyfmSBTgyLuHnhkCk1rUcgMXEkkxlnDk3JonmolI/d2RQiJWMZYZXNaHh/i?=
 =?us-ascii?Q?b4UcrUZDW/TInueDVxEaiyvV15OiNuzB6AX7RRBtUQ0X8FCdYYnWRt1QsoUn?=
 =?us-ascii?Q?1z02ykuMqgd7FoXSO5ha9jLYBlHdInyVjMNdDRoGy67ia2ftTSKiCKG3w4uG?=
 =?us-ascii?Q?Icjb/+67PwjcIdMYeA7dV0JIsWA/WNyURuoRk++zqkweUmJwjTerMT5PD6/K?=
 =?us-ascii?Q?q4PYH6DYTR4iVkptGUeRDk6cRRMZhYbfpzgyZ46YIVE2eLWQ/HtYdxXHwf78?=
 =?us-ascii?Q?45jRn3dAE2uq83sh/iApW6YjHfR81biz3SSlZthzkl8PMsSa/qGkqvReYxAg?=
 =?us-ascii?Q?fc+4jUslpbV4vX180G+0eB4W56HhMe22MIDZG2j6vCtVBpt8mbkVPF9qBpKs?=
 =?us-ascii?Q?arqbPi3y3IZdzj+iET/diErBEQXx2DTjjkWxWdTiCyJoFhVVIR0Ajtri1k3i?=
 =?us-ascii?Q?6UJakRajs5/DeOaW4jQBza2OsQsKvxQKjoQV2DE/H98ebSlADu4cRPAxA2hr?=
 =?us-ascii?Q?DZv3rDWLfhhCG4GjeWY9PfoIKHLJnRXXSIvZGCo1rgWVlsSGlPl4Aoe3lk5A?=
 =?us-ascii?Q?/fnlbny0IM8OoVZHSuj5KqlZyY6T8KyiMbvPyql0Fx264uYwa0OOZeIu2IuA?=
 =?us-ascii?Q?l63nWUHjJBED2aYh7ZAV3l3lPLuK0U5sL9nQy3egDFV4RCrbdMU21k1+Ricq?=
 =?us-ascii?Q?sM7Gh4JQAbSPxOlphCy4vDDIpWKvgSXVgWxtvK8EjVMI2SDkG+eHRw+TS10x?=
 =?us-ascii?Q?bQVkpmQ15BsscwBxW5TA4oaxwAKQQKdtjc5y2zqZvrwHIkWup7FHLPVIHfVF?=
 =?us-ascii?Q?YQ0IBuCnMtVU1ffo1qrXn4hVeulxsoiKHkR2/NHK7rluKH8YYzgHWU5cZoJ9?=
 =?us-ascii?Q?nLcgBkAKY2HuGRSn+BBbBjSQon3MDhr+yNXZpoYj3BvWy+/kNsgV5sKGNdhn?=
 =?us-ascii?Q?X2ZWzlap5Vozc6RGNLvLGBQNtypDhIPhMoLQRDXmhtjtauejUPwfPKIBWYb6?=
 =?us-ascii?Q?Rb/B0gQPHacB13B/OQjG0BMzRyh4pDnEpwxon5Bw1E5dK0LXcEdcXT6DCtfY?=
 =?us-ascii?Q?VqOj7arzESq2ax5iYwwUsWN8iHrlFmT0DzJLND38QFjoQr2R8MdIqakCTINW?=
 =?us-ascii?Q?Yb6fXYo6AMGcMr+0sDsANqo6NqnyOeLTCwxZjT6QGmM1OUnKI1UotHQ3FZ3S?=
 =?us-ascii?Q?fkv5THVOYAUmcQDrBAqFOSSQbk8tii1Z6EVZvKV2SrQTUPP8i9+j0gAmPc72?=
 =?us-ascii?Q?uDLGBYJWXIvz4FFCDp1DSvG4NxZrTTBDSS0Zq2A5U3CQsQSRkY4knCn8TwBX?=
 =?us-ascii?Q?HeY6b6jfajwdxW1IE7SbB4iRN6WlRAbQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C6Gg+/8wf4l0CXedRNolhvKpeIUJytKUuw+VvNXONQgbNpCKLHcLaf1KwoUh?=
 =?us-ascii?Q?0j3BHd67dPxtSY05aAdJW8URnzQ2FNkOCl4Rd7lh3CZEy+iM5NqM1NYRFN6b?=
 =?us-ascii?Q?3VscuYpAmPmOCfkH0adCH4sRCsYqQYaL/E6OCA8989hSEX1NHM6vQtPGnhId?=
 =?us-ascii?Q?piJG4Ez9M1Zw7RaUSJUySx9AopFy49cvaNsFM1kcjPMgpgX+7DMKVdq6K3Fb?=
 =?us-ascii?Q?3XLF9nmqBFF5OBczl3D4Qi9ZTTKHIrVr+2bI4WA7I3zz1TNkiKtk99aOGGQO?=
 =?us-ascii?Q?p5TSAhudJdbt2UpMqu6fj1geNSPNqKJw3QJBR9buUEHi5YyKYz4spCYeEEna?=
 =?us-ascii?Q?b5B/7mwHdlQfU16NXdclLQHhnPvkquAWQ2+55yf4mSpUavJjbhOb4zBrSQIR?=
 =?us-ascii?Q?Ru4jQa3Z5YfZ1oJBDS/IRBwnK3MNwpZsa5zsvipq2MTMIckqjmCAheNnY2yZ?=
 =?us-ascii?Q?f5zYbTITVFFoDzi8CJcSsL96DkI0cR0DozxJUJcJ7MR9yQnjbEjmQE2SUnSh?=
 =?us-ascii?Q?ltXv9WKPxyW+CFD0JEnPKVaIePG02+g6xqDxsjOCUbVcFKBO/3TwgAG/cA6+?=
 =?us-ascii?Q?O6WJ+y+WJA6P8ETITLCIARMDcNdxgWSCalLiQSgqOSJ1xksABDEjyU7MCyda?=
 =?us-ascii?Q?9/22bW4mtGUB3U5iLYxybTNs6Jvwefphvb4QStNgEJ6nPma9UQgm6ZD8FDdY?=
 =?us-ascii?Q?Vy4RrGr2kkm2Z994dOatzv9W/XdU0vAHIGRVtEibzj5jZB2u0qiogRwopUYo?=
 =?us-ascii?Q?6q8w3ZLGeMTqZom7refkkCXIH64f66kZ71Wrykzck33yLbAl4Axu1MbnGvQy?=
 =?us-ascii?Q?QcjE7/BctImEZs1ShMcl/4Hn3+7jXYc2AlUvSWIeFvimzc/85mnnlrDWZj+a?=
 =?us-ascii?Q?dNuNeHhIe6ZzBEzn9sdQvgKzWcrfLJHxoHneKmDqma2Nlbgy/vDC9EO6/Yvv?=
 =?us-ascii?Q?iY6Y7ItPwlZvsEh7gMb4iA/9T5hAi4OP5+QQc/l5agprwSyQITj6WoKlRvKA?=
 =?us-ascii?Q?eoYZUwcc5BSNUsPmmUtBmQfxYAt7TUwYRO9MA4lJKjQP8OmBiU8hef5jaSla?=
 =?us-ascii?Q?ecbN0NSFK1OV+GtKTMAvNOs95weXD7lPanHTrQmz99qb7uWwLeLzpuFOGG5+?=
 =?us-ascii?Q?4VJAZrE8fZBmAB8TSfOv2VR2iu4jEcBpBXyx8wIpxePvpQfrcTtkb3pYAk0u?=
 =?us-ascii?Q?GtdRACaM0Zb2wfL/8fVTOVxrUPdmLOlTiqg+TEWG5MnmQizhyxQcnkUu8ICP?=
 =?us-ascii?Q?izJ0/P+kK2beEMaSvwkCFYENHInX0FNuYOPlhDbkxim/gQxyC8bHtsPji00f?=
 =?us-ascii?Q?3OHdBXsR00tgrniJYF5hrYFU1zxaB+YqNhFE8sr+l2o05O8vX6ube5JkLi1U?=
 =?us-ascii?Q?qK1W3TO+iFzO/JmyBWySm/TANA68IaEQVgpxPU8R0m6Va1X/RYMtif3B7MoK?=
 =?us-ascii?Q?2hugLgllxodLChqpf10iogCTNbzw2i4ttJa0QV391JZg8fMpk7Pfw6P6qVDm?=
 =?us-ascii?Q?zCUbPVpzTwEfZrFUOWziG7JazQK4iCYoprg9r5OU8608GhQu/Lzb2PXm7suP?=
 =?us-ascii?Q?umhL3tFRrifjGCcGycxC2qtA1pjNubTD/eRUb5aL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ad766d-73cf-4456-cc31-08dd6a746c1e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 01:37:22.2930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jFNTcQo70jFlsoL37vZEVz+ccOyfAhiX2m4QIosZGoMvyCXkiWo6/0LfvtwMIDEwt/GekQOxfzOBfnLdV8XELA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11024

From: Peng Fan <peng.fan@nxp.com>

of_gpio.h is deprecated. And there is no user in this driver
using API in of_gpio.h, so remove it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 sound/soc/codecs/sma1307.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/sma1307.c b/sound/soc/codecs/sma1307.c
index dac17da9cedd..a2b4a6d10dab 100644
--- a/sound/soc/codecs/sma1307.c
+++ b/sound/soc/codecs/sma1307.c
@@ -8,7 +8,6 @@
 
 #include <linux/firmware.h>
 #include <linux/i2c.h>
-#include <linux/of_gpio.h>
 #include <linux/regmap.h>
 #include <sound/pcm_params.h>
 #include <sound/tlv.h>
-- 
2.37.1


