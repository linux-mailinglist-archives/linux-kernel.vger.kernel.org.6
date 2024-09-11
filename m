Return-Path: <linux-kernel+bounces-324865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5CF9751C7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B6E2B2747D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD4B18FC9D;
	Wed, 11 Sep 2024 12:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="axJubZzx"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012065.outbound.protection.outlook.com [52.101.66.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F68184537
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 12:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726057116; cv=fail; b=eLJ0C518gc//eBm3yqwVmhaELZ5i6aKG2GRU/kPC6rRN4lP/TiyZ48kxcyPKD5MRQjvAFJJPCoaaeoL8+rW6y5x8F3Y1Y7iEscFg4d0tPuxSnimMjGUM+EMXqYnbqrsjNHdyB/mi8VBYLYtI2MY+ie17vLa7jkU42tgjIF/OOmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726057116; c=relaxed/simple;
	bh=yvHw2IyN5SVdWZZlCeVPAQgHScJvikhymQs/g/dInZk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fcaNFntUOJOjln7ep0DKjJ0OjlOOAZHPBG2jtRE3AjXq2eTYnhI2TAStG2U5GW2gtriIByT2AXnB+Tsmw9x1+GAvfscHnZp0r7oI6vxwhnTW22cLnosdlV7LFYEcoRyyYrkHA/wTB+8YsLs9BXpEk5MQQRjveyk4z468Xj2H588=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=axJubZzx; arc=fail smtp.client-ip=52.101.66.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D40yM07xIrZc9cbzE5I+8VlHSiwhssRLDC7pBA9E3BOQwCWA+ulHKKq/EY6NiYwP0MMBE0DYpHmswVyydca4YPpXor0TMd1n/lqmdPbVoxKugPTqY3J60Z+7y4mai6F4RFGP4FJcwsrJwdedhE78B0/wFt9nhQy9lO26YCezjNMLWHqP7yQtuj8PatB9vu72mIcAUK6ZjCAzA8eZ9ZdrJwBUVxpdkOzTdZ3JKzPgMNHmGgNV2c7XYK+VLb1rcSjK8HKPD4PK542vTF3AQ9UFdtLowqZWKeTXnH6gRRUymUCNIa7IPZKoyDcs6GvGPkz7hAOKf8DeVtMUWde9oGVxnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37DG/eIz3muj4JojFM/K5KBVFnguHdt1G7QOy9kGYl4=;
 b=It0GABjgx3zOvTwr93cZl2kQpC7wr11kay0CqQIzADnIQM8h9AOYT52/v0wP31ytWDeSdHGqtBO3VKNR7hNBPsOqr2idOsu+U52sHSbXebSiEBEEwvTrdKzh5FUtucmy+DnjG2ebuWI0cePvjfqebQ1+XJavmP3aXgAAftZI9einQWvxG89Za8fXr4IOwfAEK1BZSwqN7bp9YWLHGMGatE9DfiqeT+3yvT4E8a4uIqMp38xOJ49anK2ggEmJYUyacKh5lLobW19Ljv0YRfuKhlOkpxHayLRLd9mdL5gdxfja78iU8uGdnZGNExjdfbg62KAzqkW0RoMKRCy7ZtmLrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37DG/eIz3muj4JojFM/K5KBVFnguHdt1G7QOy9kGYl4=;
 b=axJubZzxaIYCRD7Jkcs8EpyaI7b9ldgqKJlYSfShakc1JiinN/jnBjxBogVpy6+qoKEHjw+CqPMd7NTRPe8809/hp3GQfVAed7Lo3YFo+iqW75Uh5w9EZLIe1iDrjPG8Sb93ZgXvuEtcNu22qWa0qa9elRx/ubl/AiY8aJONwjmKyIsUK9MK02AJnFV2b6XDWs1PpdhdYd4RzHeA0QtudW/pIQpSZjySZWVmu5qpbunDKrXDFY3ymOmTXgc1RaFm2EObqNjCEaEBKyE4jAFYdbZf8gt9WM5TVrgUEtQFs4494cXc/t4BGloOpH+tQXIZ+LIneQqHC0pNn49ryiOA2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU4PR04MB10887.eurprd04.prod.outlook.com (2603:10a6:10:592::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.22; Wed, 11 Sep
 2024 12:18:27 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7918.024; Wed, 11 Sep 2024
 12:18:26 +0000
From: Wei Fang <wei.fang@nxp.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	wenst@chromium.org
Cc: aisheng.dong@nxp.com,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH] regulator: core: fix the broken behavior of regulator_dev_lookup()
Date: Wed, 11 Sep 2024 20:03:38 +0800
Message-Id: <20240911120338.526384-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0163.apcprd04.prod.outlook.com (2603:1096:4::25)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU4PR04MB10887:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c19705d-b2a4-4335-7280-08dcd25bd6bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aBl1WdOhLWOU3tEZKuSNp85c8uIw7db2/5hf1CLl+LgNElAClyTV/qhWapnJ?=
 =?us-ascii?Q?AdtzGDEjXdMznbctvWsyQHFICpFmGW0UjYmDkI46bOcmJmOwH1z8QiORaQ1y?=
 =?us-ascii?Q?pwnOMCfeLQiOp4sFNWPLjZaTZdUXX2c1hb0d+fpzb2c/rmF7Tsnz5NT2fDys?=
 =?us-ascii?Q?Qa7GGd9jkPG/WEgQIvI3xxXhEbmxfqEIsM4sPo2Cobs9MrmxchftvyGrG/nC?=
 =?us-ascii?Q?Whh7sEg7L2zBeG2TDXNlHtR7exo/l7/4K8iHw6BIVFhM/E5CaTAbuHL2Ybo7?=
 =?us-ascii?Q?izcWSbb1SqxkTtRmwxi5G562hDhcdRSd62VZwgLJOsiB8o0FUh4IApKl7LEL?=
 =?us-ascii?Q?ZJnbcWUiuT7IDyNiIphtS+d+rb+/S9wWCpNOOZqY8MNWACevK6N7EnvWMSVN?=
 =?us-ascii?Q?KIMOrdh1W9JeX47gueYTC5VoxjwwObSo+XdA9itkhRizcZwiek5QkW8QUI/t?=
 =?us-ascii?Q?8K6Tdpi4NJOewo8NeAHp1gM+DHdvOO/pbtYUnhorw7QPBhm4GVs9bGvE4Mzp?=
 =?us-ascii?Q?eU56MqJg5VVe6nSWBBb+SO/C6MLLXBcvR4a0iWkSjgc6xqlJK5tJplIH+958?=
 =?us-ascii?Q?NQ9RueqAUOqNh6HCqoo0VO8SjY9cxXi5QKCO9yigVDlUoGqm0CxpaNovU/Jl?=
 =?us-ascii?Q?UJ7Q2NbrGGxuKCp1zY9e5XVCeC8ySw4HezUWmyK8gc4kGEPvg5iqdN4/tPRX?=
 =?us-ascii?Q?vGFuT35gmdUghWkizPffYsrypJrW4aDeL8s5JifL6tFjREwITn5M7HgL7TD+?=
 =?us-ascii?Q?13tpYnTcgFDT3iz4DV5T3KY3M5MIdfHlIjDFMABt6jXmKab86HioC0sx9hRY?=
 =?us-ascii?Q?1ylrtyCuaA/YMTQCueA3SrvcsT/FQFzrxE/AzXK0OGKR0LQbS1cousZ97qDB?=
 =?us-ascii?Q?UYnP1roYLFVYGLiTRaY564s156g7nToNxsnM+1p/saDPaNcQe0Ksri/oko1I?=
 =?us-ascii?Q?OGo//KQNL58CW8XBDnQsZOqFXcx5iGxFviCDfnEhPa+N30tnd1R+BjRdPj3U?=
 =?us-ascii?Q?8AJZaEW+pWXjvwEM5DpdFrfqfYvnxUKSDn5ehv7VqrQTfb4lrJEweE47fHx8?=
 =?us-ascii?Q?K3eT9oy/95E5cH/m+qC24GB4oGiHsVTcAvkyJr3lhVuQAqqyBOBG0r0CWJZz?=
 =?us-ascii?Q?0xHjTvfA5X88oHZatGMXCRrVEP6ZW6pMuHSWjW8P+HBe7Ck4MshngIyJuWwh?=
 =?us-ascii?Q?g6WuIkBcjHUhgr9xvmnRDbKMObw3OUSWZV7+XUS0D0YVaF2vjuF9OvQpe43k?=
 =?us-ascii?Q?zpqOsQ4231N9oTVVTuh/RhLd2lTOTj1XFR3C0+3cXCGMDqkV/wkFvQ6iAz64?=
 =?us-ascii?Q?Iq0d05qDwQNntOObPqxZigtzJDzIETjNtp6kXKcrGdK3HJCx8VbdnbhIT/8Z?=
 =?us-ascii?Q?RFbzaaAttaaH8i4/G9IhUi5T0pINmHRaEXVueTSZGPYlAZgo1A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QNSXoCifM5XIYO8DZHctZ4uhyvcV57SsksHANquUuToHVOY++q0QQ8y7QGJ0?=
 =?us-ascii?Q?7ZHDgexXuQGGFAs3JGDBPMLZl+4MrKylRXdp4YRE9ZWSLc1FxajLfRxbzvNp?=
 =?us-ascii?Q?Li1ph4QR3/q7syA9Jn+d5fFp0IQ9iHT+ElYyB81dgrgtzmyBjZZy1jzc6x5Q?=
 =?us-ascii?Q?6NA1IAaqPYMbEDPJUOo4S7WiSOtFD+4z4Ju13rj2j7+xGf42AJWgXJ6efaM3?=
 =?us-ascii?Q?v9UoJ28Q/Gfl94ubuWi+SGsK6k5LNsC2w8msMisaQNbNOpPS3ALm9D5DfOVR?=
 =?us-ascii?Q?mmXxetJEarbjcUJS6kLh9QPbC19Ie17GyREb/TGRbf5vgfbqmdAUEewWnwAt?=
 =?us-ascii?Q?0ncTaoORtSYVbt5Amz9Qqito6aZFsNHBrGwp2RHNRej6E0pf666OkMwPSkc1?=
 =?us-ascii?Q?GhHxxHfV7qsMK1ICppEaV+OSu/0GeZaqm2lh5mHiqEDhKVms3Hl7z8Nkur7G?=
 =?us-ascii?Q?dCZHHyNJaiAwGyDPuiCbxMoJR1hDhQGnv+HLGKkNIxwSAPJ2VIXz3db16LMX?=
 =?us-ascii?Q?ka2s8xBzLOznXSmAqf9mwUjMTgpogc183Ov2izXkM8dKZJp98AY7H1XX2jfd?=
 =?us-ascii?Q?67OyS6GrihKiUgNKk4XrkuiEhdYfwTDs2rhI8Eus4NyPfNjWHHAVB+CEvA2p?=
 =?us-ascii?Q?t6ue+TBOp7S648gEQzGhHVflzxb8I73b1R7luUjZSzFjOzPDHYYfxEglOPvv?=
 =?us-ascii?Q?mzTOGhjBcHeZcOyLcBHVkJYuK6ZtsHidGm7111AyrtRPbKeW6pkZ5l//E28g?=
 =?us-ascii?Q?0sasE09vs0IH3xd+zxjUvoGkglpu+sCbUCXKE3zSWLD0wHMGZEEZUcVO7vHS?=
 =?us-ascii?Q?N7gZ6ZHADA07OqxNCq74n4CzHlgjPxcoLw6NczrX5vWWg3xEAXFhpVeau+At?=
 =?us-ascii?Q?BlH1BCPGrlmyDbHq9sj+DQ9/HTtd4V284v17DCAT+yVcLzRyVrBon9mva5U4?=
 =?us-ascii?Q?ODThRJbybPEOm9SC2LgRdS/DaW0kOlA6N7rnethXQWSVv+4X9LiKBj7nrk89?=
 =?us-ascii?Q?gAhagzadJxI2j2CRU87d5qicE6ThObb7dLl4eBBI6Mm2uEO1d2pGJbHDCpfV?=
 =?us-ascii?Q?nO8kxDKo4k0Y+CgSBAtOszZo/p1jtEZpDLy9Vj5/OI+Gnf/u5mGARA+JRt61?=
 =?us-ascii?Q?MZGxH8Rv5Fjhw8GPLCgjXpqRvhETpmEbQdPO3EA4NJnkPcpbZ6JVFrG/yaK1?=
 =?us-ascii?Q?MRVy1XImnx2D21oTh8S4ULdYeVOfeIDvWgyZEcQ/qXZZkvGXCDui85O9JGbH?=
 =?us-ascii?Q?E7Y0204K7+qvIBNLAsP2PblToDCAS/fvscnw667zASLLudvkuwJLePK75Uyk?=
 =?us-ascii?Q?fmaTtMLoO2x9RSusqyIbpDWdW3MiLRv/idAs/2k1fibisKyC2wn5BTNomlVG?=
 =?us-ascii?Q?fGyUR4UeF2E37Ens0gFehuMvalQq0jOtf/Cj4NowLp2ScYCrpEQezao3TNK9?=
 =?us-ascii?Q?fKYZ6CcLFqtFWCaISlVY7MJSdc1jQ1zCWfaH7BdQNG0Yv0lPgb15aK/RbK5B?=
 =?us-ascii?Q?yAj7oetF1ICGOFO4R393Bbe+a0C79NrnjmM3/Ng/alUsLBdRXziAckBrLe8b?=
 =?us-ascii?Q?VlIESMj6EdQ0QikQEFEHezUSjlaixZ6xmkrqjCTB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c19705d-b2a4-4335-7280-08dcd25bd6bf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 12:18:26.8980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0UfNdZ/c/oLqPhwVYzqO4PZQNVSEi5PbXMnGUYku2LMDrg0WBIogkrtz/mylBW3QZwuLYNQx3UQdF4JiFTzuvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10887

The behavior of regulator_dev_lookup() for non-DT way has been broken
since the commit b8c325545714 ("regulator: Move OF-specific regulator
lookup code to of_regulator.c").

Before the commit, of_get_regulator() was used to get the regulator,
which returns NULL if the regulator is not found. So the regulator
will be looked up through regulator_lookup_by_name() if no matching
regulator is found in regulator_map_list.

However, currently, of_regulator_dev_lookup() is used to instead of
of_get_regulator(), but the variable 'r' is set to ERR_PTR(-ENODEV)
instead of NULL if the regulator is not found. In this case, if no
regulator is found in regulator_map_list, the variable 'r' is still
ERR_PTR(-ENODEV), So regulator_dev_lookup() returns the value of 'r'
directly instead of continuing to look up the regulator through
regulator_lookup_by_name().

Fixes: b8c325545714 ("regulator: Move OF-specific regulator lookup code to of_regulator.c")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/regulator/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 835a5531d045..40dbff4017f5 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1965,6 +1965,9 @@ static struct regulator_dev *regulator_dev_lookup(struct device *dev,
 			return r;
 		if (PTR_ERR(r) == -EPROBE_DEFER)
 			return r;
+
+		if (PTR_ERR(r) == -ENODEV)
+			r = NULL;
 	}
 
 	/* if not found, try doing it non-dt way */
-- 
2.34.1


