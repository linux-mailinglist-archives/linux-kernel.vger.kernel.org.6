Return-Path: <linux-kernel+bounces-206145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1989004CC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7A021F23B8A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594BB19A2B3;
	Fri,  7 Jun 2024 13:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="D58s5gTX"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2063.outbound.protection.outlook.com [40.107.20.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996A019A2A2;
	Fri,  7 Jun 2024 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717766743; cv=fail; b=A38kaEwB34knBOGGVkHx7evkYYMxSOGOtQbmAByOLNlXZunMTZxxTnr+Uj9CI6pJzMTpxF4Ho0hMNB+Z4jwqcf8iVv5t6GPP9waLaMyFvpATcAAv8F2odm6uVq6QeJU45ist+/47foXO4Vokd5lUfzAuoY7pRdxoZpCzowxoVxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717766743; c=relaxed/simple;
	bh=CoA2pIchVz+nF0UGmwhkGPv53uR54MYaXPWMnd1m1ig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=koYHgAi7/rSzeYDfab4UEbrnUWwM5ZLKxjQ27T46kVht7awZOJuCvF2zQ7EpeVNbf3OUoc6hON9YrI7BGTcx6XnrY3zBioQBZzpgRiJ2JLIVb2NIb9N2buwEvYcddnkvhRaxEjU1NTw5ZpUhbcLA5Ipe7o9yY0jYDMLIUmIy9z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=D58s5gTX; arc=fail smtp.client-ip=40.107.20.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmWxFwa3H4QIXetO5tUQQVybySUhYTQSGw8VKAvhmRXgN2XA+JMYDvYrFPNN0n/57E5IkF2vo4+kuGXgv9LYuSltsQheA0L1oPleEfwdH6PV0Hx5w2ccuWBWsP0j6TKkZBSdrJb0Y6rXYdT2HW5OSpTWInhc1km4wAWccQHLUIWp+gHmbZI0Qm8JbRULlRaor5V4XlYGPDojj5BAbHQCK/SC9VccoGehv6Onm3IlI923orIU0hqkyL4RxOxbNhwHMcxb8dpgOqHTuISDRLYPgQ5fl/KJbh2T99ZDUzpbWJrXvfxnc1Y2vTm7Cct+EqxdHQciThow4NwbZmQ7RaigPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Xn+IT81wV5cTyz4USGrnh/ChDNJlpXbvwJEfxkiinw=;
 b=YHzY1d4kCnjZrjBLNyVbsFinZb4A46rysU28CGTyTF2wqkvg6EOTFQYMxvpsVM/6qoIURKO+mN5e4OGJO6ncM6MGe3R6nkN5ng5OKSOHNtar1ESpAqxRRuDPpKnzrqIx3Zpy2g/b1nobXOafxJixqBwpa7UgrHlbTlDvzfRU3XfpvdImc+CZEuoAAcKUHWBTgDDn73mgUdXH8UhYB53Z7ePi7dKIsLUzOh0ffkGE+/hAoybER41vbgwdlzWFF/7Zzhuyd6FRFd5pr3Tk7XSPqRKcBliS27Vh9x6v2b4NOL0fvykXZippEAoW7yCNp1e4Rtg8zflCLqr9vEUleXLw3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Xn+IT81wV5cTyz4USGrnh/ChDNJlpXbvwJEfxkiinw=;
 b=D58s5gTXa7/CUJ2ARu2F2Gqx1doJgVYaoEQY5RvFwZu5wqsRiD6CKHHgqmhI2mpR96i7XmY4gIuEWcsNX+BMKbvovzicg2lEaBf4IEOf/4e6G4EVOJ/cvmw7X1Iqb1jpbSIi87KYtmKy6zDwMoHOQZnTewJ29gseRB+pnZTOCEw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by DU0PR04MB9249.eurprd04.prod.outlook.com (2603:10a6:10:350::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Fri, 7 Jun
 2024 13:25:38 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7611.030; Fri, 7 Jun 2024
 13:25:37 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: abelvesa@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 07/15] clk: imx: Remove CLK_SET_PARENT_GATE for DRAM mux for i.MX7D
Date: Fri,  7 Jun 2024 21:33:39 +0800
Message-Id: <20240607133347.3291040-8-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240607133347.3291040-1-peng.fan@oss.nxp.com>
References: <20240607133347.3291040-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To DB7PR04MB5948.eurprd04.prod.outlook.com
 (2603:10a6:10:8b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5941:EE_|DU0PR04MB9249:EE_
X-MS-Office365-Filtering-Correlation-Id: 97a60e7f-f154-4cd7-5a5a-08dc86f551aa
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|7416005|366007|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e4CiSN9TYN4SzFLhq32nkm6ln6sFjbeEADqnpVCSNoFfaUUWEeASEGgp26PA?=
 =?us-ascii?Q?WtwHJPaygQjtUMVoXNOqU28+0ZkbRTdta1zOiYKZu8d40NBr3f5RpSwvPArf?=
 =?us-ascii?Q?v2kGTEZtbfj15Hx6D18qakFQRKoXJ+jxzhp5wDwAtuykJnFqlpOq8d6D0SRw?=
 =?us-ascii?Q?suHK/oaalwqNS4/ZG2rmI8+kulH213FVFKUyrn10yKvwxdR4znlAP1d5iB57?=
 =?us-ascii?Q?z9egjtE+0yXLY6aXX0WimgdR2usI8ELq5W5IKr+LRAO5xlUvuF6Np5V11Rvg?=
 =?us-ascii?Q?xOmlmwXeQq029LFyNzwJBPfMLlrbhC8A2WJXT6JVYyh0S5KCucf5q8z0LhdG?=
 =?us-ascii?Q?Qt6aFJ5d+xhOweQMnyMBI6Agls1EiRaAyzToa8hlKfdHoDdsELY5DfSST/jb?=
 =?us-ascii?Q?9jDyMJO6KijtYLtSTOZxCm+ovDAZVC66EVLFMatFf9tyIza3Kie0+qgDwvO0?=
 =?us-ascii?Q?WoHvSzi7eJgMCGfavn3MI8Cb01ejTBVGgPvDqm+q0vYXHTJ+gK0RuJlQYwsl?=
 =?us-ascii?Q?hwTy0Wp6h2YjIe3dAwsx/TxkaS/2r28cob17ZN/C2aBHOQwuH6oUSY2MYusY?=
 =?us-ascii?Q?dQzWgJErUanuEtR1I/59vHs1WOpMTnj9fX0bfTdkHzJjPWaMMptv2stRf4qL?=
 =?us-ascii?Q?EFMQf+dRBvJr3aDHsuDebHgr4HDINFTTgqiA0F6xVthfz8rr6ZIhcak/h2/Y?=
 =?us-ascii?Q?EnY6k3nCAlUwLCWiHhvmFK/0e+1Zzp/zF4Uy3p0TukbrliqJ43J8yWcOZ6Z9?=
 =?us-ascii?Q?MA0kb1YANW9LjllYt+htiHdGbn1zamVptJYCqU4OU+04B3GbtZlo2Kick0Rr?=
 =?us-ascii?Q?AoPg3fO7FKoJPnvEa/jCdQUyVMAIcw/zI9bZqW/KMJ0KZBd7DIaGw7ELVfTO?=
 =?us-ascii?Q?1MW+x/arI4TKsioQrkh215pWfWemZANwYx7TqYe7g9xcLyVdYZD9GiCxBxSG?=
 =?us-ascii?Q?JyGRmIodVJND3+ftZJb9bQ+rn9qVSpO7DuVhjeh1WjHLJp0Npg1QQWOzq6F9?=
 =?us-ascii?Q?hxtOcYPnMjFPereigbC4mKztWV023hUvb8EZsbartxeltu6uxEqV8lp1pZyu?=
 =?us-ascii?Q?71Meax1HqAW3wwOi2XLEwU9iEeIP9blvavT2fLrDHKeRJ8OuLGnKR3+zEzNY?=
 =?us-ascii?Q?Z3L7BeRTAXft6XgFbOv0uRJKhG9aCE4j/ncJwAufisDb2/rYOxMJU0qw6tAZ?=
 =?us-ascii?Q?6avfl8MD2qVWYM1gS59rd9V4w9Dhss2r5X7Hz5W+xOvawIv8u2MYdWhQ2whj?=
 =?us-ascii?Q?YT96mYP//OZAUDCUe45zYAPjZP8QBw4EukkDaut6+kZTpou9UYkYtYbrjTWA?=
 =?us-ascii?Q?vfshhRenFHr+LMGRMU9A79qLMuWhnYJCdf4r2ilgApLthkmBnzFYcfzCPfrr?=
 =?us-ascii?Q?JrcxBgw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(366007)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PKNglZWRb8U2eg/Yp2sCzUubvFu3wZ0QZC6qUGZ08wXIrnVhBjZeR6vPJjBP?=
 =?us-ascii?Q?J6e/qKNNnM/VsAsdjbvmqmgEQZ+hB1NYgPWRZAfS3sa88a2ICDO7j1Lzqb/S?=
 =?us-ascii?Q?iuf0c5+xTAkM6SoDccH8ORj7rnBSNQzpcVWOHawTJ0KvFyEuyyQrUAM37+gd?=
 =?us-ascii?Q?kOB4ErS+J7BJ87dN+2ZLeOg9Sjg8GBwjGUKmLv8DdePG0pD7XfOjCpVME/Uw?=
 =?us-ascii?Q?BfRkNCyBpglOSPUNlfxVZky5MNAdEiK1C/xZRzVb5rc1dUD66koZXvQroSjK?=
 =?us-ascii?Q?LekJk1WABSZzpRVqbLY4hD8xZaB2M0vFuSM5OIHqVLC5jeYA9Ixbhr9SFyFE?=
 =?us-ascii?Q?y29YUKugAUs06Zztckn5v/HCfcOssvD7LDMXQN7fAV8nUzPop2g7pj/NJ/4l?=
 =?us-ascii?Q?3uGAH+4hbslmaiCFkXE80EpEDOfyLhJB2fe5GJFqOI96lbpwiIWudoXL6xfG?=
 =?us-ascii?Q?WNt+M82rjGbFyVV2pvp4+whK42NWLO4oHMznFilFT7SxHEuojJlZZOM4atnt?=
 =?us-ascii?Q?4y5D30V66z0D3i09y6Gp8tIH6zDKLq+KLnBKmWkqoitWsBoF77qBDa+riDLP?=
 =?us-ascii?Q?yx03CjFXrKapkm+Q0hCcWbta1eY/lrlYULJ6IeEfbjpPTXkU4PhZDDSzo0//?=
 =?us-ascii?Q?rMZVorL4HDiGzpK+iIn5GHg8bS43QBX3ZWPZnpGupHBKaV2s1FTU6fSUPQq6?=
 =?us-ascii?Q?YRMZc/lg427dgUofG8gxgY2inmcd4jGl7Iifvib28rs+W3uN7blK9EOkUuSr?=
 =?us-ascii?Q?WV567P+BhmaGs76X+sOOV20/XqyxZH9CXAWMtdWWCiT8IGREZpRca762zRis?=
 =?us-ascii?Q?e3JwyxhhSLdMq7Wm4ArjUKcSukpapSMOGcwUXjZCFRCpw6+fdclJaLdgCKK2?=
 =?us-ascii?Q?hX1J35pcqaETzAtVMh1blQ86OUuZya+RMZ+OgOWnW+O2kf0X6xNwVUJzYbZI?=
 =?us-ascii?Q?KjYwsFNxaQdsN3qR4C1GSwSUpHuhiTlBTzGqdvoMooBvdMSzFwGc6swUb59L?=
 =?us-ascii?Q?cH4BOlyvtQmg4RcITyGvP9gpAxzcxVWP0n4MMRf9lVlHA6GfFh5p9BILSjd+?=
 =?us-ascii?Q?ryxdTVC/4NJ3oLc9Wq4ojqYG/yKSamwaEWRCNS4j6aKEVoKw35U0KTRPj5XY?=
 =?us-ascii?Q?iQOWQFbwhmv9SOEzhk9oow6xNULOvSh18Os8t4E0NtCG0grtyhmD20+HE+ys?=
 =?us-ascii?Q?Nuibm6I2+YlGc4ExGnY/5f0qMDwb2Pb07ohW1EE6/+w20cjlU+o4GRbZiqKP?=
 =?us-ascii?Q?pq+OTj0DAN7+smbCMhVyhX4zpakTWIw1hvIwReD1AroXubeNLNFogXVZeYRz?=
 =?us-ascii?Q?CgBoZNkA2Pi8FcnZS666Z6/SQQVSVVQ65lAcJKu8s12O+P1RpBHnDFP+Uhwc?=
 =?us-ascii?Q?BxLA/QEA99k44Fw4YU8EkvCMBJyp7pkMh5ry87ZeEYUQt1k4IcYioYMTvtnZ?=
 =?us-ascii?Q?VkyWtFkru9ukM6HQurmr7/MNm7xhLv+uptR0Ufdwtpp8hPgcFyu+fHOkfQQV?=
 =?us-ascii?Q?ZoPAth2s2ax9n8XMKqAKdubC9J7r8Kq+Yj9xSN43nBV1T62TEfrFi9NfL646?=
 =?us-ascii?Q?hCpOxQmDUOdaJDPvj+LhpPgFwsZoalChLDS1Uufm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a60e7f-f154-4cd7-5a5a-08dc86f551aa
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 13:25:37.9426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NVh7LkloHRDkAzqlQ4TPZWF6Dq9HPF7YHFKF+F2jimacXIIyhG+C7Y6u4g4bHOyHk3q/RObuG/qCt4G9FBGPnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9249

From: Peng Fan <peng.fan@nxp.com>

For i.MX7D DRAM related mux clock, the clock source change should ONLY
be done done in low level asm code without accessing DRAM, and then
calling clk API to sync the HW clock status with clk tree, it should never
touch real clock source switch via clk API, so CLK_SET_PARENT_GATE flag
should NOT be added, otherwise, DRAM's clock parent will be disabled when
DRAM is active, and system will hang.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx7d.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index 2b77d1fc7bb9..1e1296e74835 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -498,9 +498,9 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	hws[IMX7D_ENET_AXI_ROOT_SRC] = imx_clk_hw_mux2_flags("enet_axi_src", base + 0x8900, 24, 3, enet_axi_sel, ARRAY_SIZE(enet_axi_sel), CLK_SET_PARENT_GATE);
 	hws[IMX7D_NAND_USDHC_BUS_ROOT_SRC] = imx_clk_hw_mux2_flags("nand_usdhc_src", base + 0x8980, 24, 3, nand_usdhc_bus_sel, ARRAY_SIZE(nand_usdhc_bus_sel), CLK_SET_PARENT_GATE);
 	hws[IMX7D_DRAM_PHYM_ROOT_SRC] = imx_clk_hw_mux2_flags("dram_phym_src", base + 0x9800, 24, 1, dram_phym_sel, ARRAY_SIZE(dram_phym_sel), CLK_SET_PARENT_GATE);
-	hws[IMX7D_DRAM_ROOT_SRC] = imx_clk_hw_mux2_flags("dram_src", base + 0x9880, 24, 1, dram_sel, ARRAY_SIZE(dram_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_DRAM_ROOT_SRC] = imx_clk_hw_mux2("dram_src", base + 0x9880, 24, 1, dram_sel, ARRAY_SIZE(dram_sel));
 	hws[IMX7D_DRAM_PHYM_ALT_ROOT_SRC] = imx_clk_hw_mux2_flags("dram_phym_alt_src", base + 0xa000, 24, 3, dram_phym_alt_sel, ARRAY_SIZE(dram_phym_alt_sel), CLK_SET_PARENT_GATE);
-	hws[IMX7D_DRAM_ALT_ROOT_SRC]  = imx_clk_hw_mux2_flags("dram_alt_src", base + 0xa080, 24, 3, dram_alt_sel, ARRAY_SIZE(dram_alt_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_DRAM_ALT_ROOT_SRC]  = imx_clk_hw_mux2("dram_alt_src", base + 0xa080, 24, 3, dram_alt_sel, ARRAY_SIZE(dram_alt_sel));
 	hws[IMX7D_USB_HSIC_ROOT_SRC] = imx_clk_hw_mux2_flags("usb_hsic_src", base + 0xa100, 24, 3, usb_hsic_sel, ARRAY_SIZE(usb_hsic_sel), CLK_SET_PARENT_GATE);
 	hws[IMX7D_PCIE_CTRL_ROOT_SRC] = imx_clk_hw_mux2_flags("pcie_ctrl_src", base + 0xa180, 24, 3, pcie_ctrl_sel, ARRAY_SIZE(pcie_ctrl_sel), CLK_SET_PARENT_GATE);
 	hws[IMX7D_PCIE_PHY_ROOT_SRC] = imx_clk_hw_mux2_flags("pcie_phy_src", base + 0xa200, 24, 3, pcie_phy_sel, ARRAY_SIZE(pcie_phy_sel), CLK_SET_PARENT_GATE);
-- 
2.37.1


