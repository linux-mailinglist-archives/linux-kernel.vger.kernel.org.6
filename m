Return-Path: <linux-kernel+bounces-206139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6BE9004C0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCC2E1F21EE5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF82198E8A;
	Fri,  7 Jun 2024 13:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YbuJM7dA"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2078.outbound.protection.outlook.com [40.107.14.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A9A198A16;
	Fri,  7 Jun 2024 13:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717766712; cv=fail; b=kt5wrwANT9DyyVBa7ha2IORAf0q4wRSp1WaHhhgJsI+G911JoTe7Sgfwsr23xJHV9ZjRouBlmkS3kr03UxM25JY/ZUtT3YCfzqPq/hhonDgbdtDbKTEA2hkZ0JW8H7rnNm/Imy6c4LpU6KkikGi1Aq1VOZL0BcSCsaRpGCT+sJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717766712; c=relaxed/simple;
	bh=VQNhowou5LND/DBWN3G3BOyLOp+FrjkJ/ji5YEcnjrM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I/VVx0++GJ3Za5hFxk9zagobsM1uE89VBrJWxDdiSmN2ROcvZ2Ei9fmT6g8Bl7xNcJBSUEHhQugMbED186HwtOYW2K1qSE/IMAFFiZwMfy3q7pQ6x8Q9np8kDg+6eIG1VSDQj2NLOIFlL2W+IK8mFlUgjMVkO/m4QZba07OyO34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=YbuJM7dA; arc=fail smtp.client-ip=40.107.14.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdoJZeS1Tzd6CE/0W1IQmvy7nYUPN6ipQUhLWWAJiNMdJJTqmfw38yt/s5oeXwCPknFlEVWrLnL/mYiE/akSHXNa6GnyDcSPU9BKHkLB5LVSkDRaF8RUwskJF2DSj6KNiBmPLuSPTsvq64XtFVMId6Ez3lPL+c6H/HqtkzDfeT5uNbAp+DSWeQKdLbJebkLbMQLIaJForOm09pfskaqNfvwkDEzVgmaOpXSMKmxzXh8CP26NyHMPeih8GGsB/OU4O5QyLU48n4/WRdbofiTorhooMzyJ+Z+G4NmRAoiE2Ug+i7RqhAVVv+3JC0tkpGTPiAUQxGEcmqmBnC2d2+RfKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ByH90eB8taO3BG8md0OU6FeBsNRnwEpocs8biU6PytU=;
 b=aZPoothgE9LiTl97zB5JJHK1kGMKN8SSx5eHnSlnM+sgqL8uojnjQ4wXvRyPSk4HGZD+sSxCUuKmxqZqKtS1zZBSxzIP6c76v1rKMrJkWD4TeAMYrxdo5zwtnlbKFJMlyI/CXP9F1O4AYk7jRFF5LBjdoZNdwGYpt5D/nequg8Rb+3QnGKepE6iUdp6SZuTf81RRxKRcs0CjYK8W0oucIXb/XMUWcMb58BYc3qUTp0+tvGCzU+V89MlZ7IrUZF1TeyRh/DGwsDxkAFWdpFZBxqaOVs86sqJear7GtD9E9S24+p2iie7BzKNikbwBT1SVg6ZTXYu4yfQ/ASyQtvameQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ByH90eB8taO3BG8md0OU6FeBsNRnwEpocs8biU6PytU=;
 b=YbuJM7dA34vN1Nt+J7bGTaXDcscnHtWcQ3zbxj4jG6NMpKEYTvHzya08pWOSoIUl18PXSkj7Dwany92hiVp3iPt4tYG6EIgXa6yDuIVyFwQka2vr59OraB9GhlMrDmEVJ++JeVZ76bVs6irKPQbXAf9hPA/xGx0CZzmisse5K7Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by PAXPR04MB8944.eurprd04.prod.outlook.com (2603:10a6:102:20f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 13:25:06 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7611.030; Fri, 7 Jun 2024
 13:25:06 +0000
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
	Peng Fan <peng.fan@nxp.com>,
	Ye Li <ye.li@nxp.com>,
	Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH V3 01/15] clk: imx: composite-8m: Enable gate clk with mcore_booted
Date: Fri,  7 Jun 2024 21:33:33 +0800
Message-Id: <20240607133347.3291040-2-peng.fan@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM6PR04MB5941:EE_|PAXPR04MB8944:EE_
X-MS-Office365-Filtering-Correlation-Id: f2ba165b-7886-4d9a-28ce-08dc86f53e97
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|376005|7416005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VEB/OAtTp8/hunOr+2X9/TSPWNp+xWAUhagZTA/jPyDgikrBu5oNvKXRM7oP?=
 =?us-ascii?Q?u20F5AdLgzLSD3WVxOScKBgalV3jraFBp5stBM2Rc3ZUuj9JuFyN9uifQQVM?=
 =?us-ascii?Q?GfD0kaPUUVs3dIOpEbUnTpta6jg3+apohi8gMw3wgAapIF5e8lYOTXA5hUp4?=
 =?us-ascii?Q?3s3YAJw92uV0GZw2hZwGukouIZV+zFXtQXpoE9prbU+gUl0gmP4IGcpmvehv?=
 =?us-ascii?Q?w7oskkBG3HjGwI4ucVnOHT2ga/5/Q/oZ/UhaVo9G8UNfoD8KwzjfVpnciiSg?=
 =?us-ascii?Q?z2hRS1NIXG9RhjAHW57cBp08tgyf/+WWSyid9jzhjeHnDSLzvHsQtXL7rZd7?=
 =?us-ascii?Q?D5udqBZuAa/i0z+GzZ5QXfTJbDl8dpw8tohBsefvJOgyjGaIGN6SIppbudDr?=
 =?us-ascii?Q?Ouj2mFRDWimYCbbtNLZpgz4djl4508TZEJknOeZfUWq84Eyi74BLtQOhUmia?=
 =?us-ascii?Q?03tRCjb84nnVge7JfN/EdCYJ0X7DMd8SA4BUUdwtdoTHw3739Zhmk3DbbG2j?=
 =?us-ascii?Q?/mtLt3HUCy5paTSxw316nAcqznQPoBCUOpaWAfsJY+EyHi0wYe98R4v9LmIp?=
 =?us-ascii?Q?jfSqMGC2rZ1razTESrpRrlvBGg7Gl8OiBsfBzvbqBix2pi0WzfA8iRwxD1kz?=
 =?us-ascii?Q?GqYxPlo9wBGnayhk/RqXDBrHRrMSY9Sjs9fP9ykjOHv/DKVo+32bmmXvpc9n?=
 =?us-ascii?Q?YHewJXNsWi9YT3zgM2YNMJIlix9BWnQme1GKSsyWjmMJbscJtqaPDfC4gYKf?=
 =?us-ascii?Q?n4Y3nLdpvOGqJO4Rk+YOlfT3DYkbsaVNMXusK+bgufbW7UVkWeD1xeAVJh2j?=
 =?us-ascii?Q?E02fYyAl4AbLG2DKUDUFwJh7ft9ccXkhXwiNK72BYHYl1PFgY08D9iXvcwl/?=
 =?us-ascii?Q?zKZi5Fzwi3Lwj1LgKXV9MSts8XCRDOPBi1WlSC/+oEnoNT6WFdKW+fkXPW+X?=
 =?us-ascii?Q?9xW2i4Oa113sa7SfRMRfBjghjwyrw44EMgz2muA1jl8/ohA/X3wzGAcRZzx1?=
 =?us-ascii?Q?q8tbI1zhusWbxiNS5fg/watPUv+bajE7Z2ABhK7SJ2PMlJApC6zDkS84dX2i?=
 =?us-ascii?Q?mHCdxuFKlyh24csVsixeTSZBjqf5Hz1Fz2YB5Hg/uA3yavFCLWLOV9IN45Tx?=
 =?us-ascii?Q?7g4S1fHkEDMBBMW9g6W65QyrM6opWkEPImCBKRUJH/55nwQFrTbj2uowfgAM?=
 =?us-ascii?Q?5aySueQipZnZl2aUMIaZr0O0exsyjVkv+YSDlFhPLBe1NPvIk7FE/bQ1dQjI?=
 =?us-ascii?Q?fA9afFDAjizgFsVKVJ/ifZjVyJitMtViaLOT3JBY5Goejv/G+KdGgNuOJQ1g?=
 =?us-ascii?Q?cDPBPtu0/3QLS+cNV/YDoFf0jK8hYIQWXunWwT/+Nub9EE0iDKPlX1KfMawl?=
 =?us-ascii?Q?ePJkBrs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bnTtfvyAIs37RgtqjV0dTlevfyAzbMDHVGQvkrzLN8t5HepljQ93DzcJ+epf?=
 =?us-ascii?Q?tADhkYubUS/XeUAnwG2PYJkLJdYEYhgqpVd4aG81xre3fM6IFLE+LfBev4AE?=
 =?us-ascii?Q?KkHD3VuRHOsLgi82pkFKmef8tV1JmnTzW5EFMGnGOpzuVvIAukeLv/thLMYu?=
 =?us-ascii?Q?T3FD8DuIIeKyNfEnwqpBV8LQvaBUPWeq79UdUcSw9w4zn08EtyhUyJIl5cKb?=
 =?us-ascii?Q?lRQtQAFmRO4K11CFUBx512cks87PsNWRUbDeqO2Jn8sHKdvpmCgSlZFEfP83?=
 =?us-ascii?Q?RWMjxNpe/zPauSaUXQM2c6oZtf/dt/trkdU8uGPeeHnbsnDDxQILbKIpqoRe?=
 =?us-ascii?Q?DEKbVUEahyjcaPF2mXC+3DyvYmfbrCXS+zTS9k2SC528AWXY0Tzv+hJ5tujX?=
 =?us-ascii?Q?m3/BEJs3VvekkdJYvyW7X1lkWbRom+l4TKVANkgC31VIEzVU/JdZhhsKiywN?=
 =?us-ascii?Q?dgWbDN2HdJb9bRrt4dPZ2T0JyG7kPf2D/9nd9SUD7dobT8N5I5OskI/iOwPC?=
 =?us-ascii?Q?BFGYhqz9XTy4tYKNDXraALNhr3dQEJCQHNMh4ica5WH6+ZpluLmihmcgxaYA?=
 =?us-ascii?Q?Bs8SCqTqtjDKO0jyx6s0/Og2+9BfNxYBguS2NcaNQirbGQMjf8YHEeZWpJzT?=
 =?us-ascii?Q?+K+mxMzbyGmWosbqq41UY36gLrCuYYNHvKsWgBVBrl83fDR/dba7qgscjQOK?=
 =?us-ascii?Q?nlOOJZ7sIcpGUI1CSbKsRzwbX8pAX0Tuu95jKcpsp/rSvv34R+z5id2GTWVM?=
 =?us-ascii?Q?jcpiBOjoYW+Aw4UIo5d8znEs4uqX1HLEpzfFXbvJOPwJ0NpvoVWK5e+fw9Gq?=
 =?us-ascii?Q?N+DlRRQer6AzPwLu3WkcGbfWYYpJA1n/w4/ZFIo/D5yxLiDMFaYTgttHwPp+?=
 =?us-ascii?Q?6eS0/ffd3+wBQHrw+98MfRsTUNSSYW+fnvXQf1WJZNng4XziaZA3pI67CpC0?=
 =?us-ascii?Q?WXQ24nD/hpbekDPlxsU1vH8e9zGgmWEQbenPs+J2ACtvq8+9wAabLERlRoEQ?=
 =?us-ascii?Q?MQ34TsVXPXpERbmxePIGoDyD68ye/WqSJN2JpnuiPBJXJZ8FRjGQDWfa5IMq?=
 =?us-ascii?Q?hhD9LGcgJEJyqRvRVNjv2kXffvwVJboZKdiN1JD9e3BKA1ok9CaqTjCnXHfz?=
 =?us-ascii?Q?0V83XQmsr8EGvRejPot9QGkHQrhOPKZFzGXXb4hcbcXv9w/7xCiuN1DwFSl1?=
 =?us-ascii?Q?hzzENCzRlbaTDmGxdGNwMB+Wa0qf4kcauE9vxh+n2gDnNUgLG203WlsqqHfV?=
 =?us-ascii?Q?HrGnhdqSTr3gcrjBPpMnGZJaaaD7eYCKA/nmd18BUVaCiWWGONqnD5I25F2Z?=
 =?us-ascii?Q?ZlJJ9YDvQQib8oWe1zfeHJ0+YQ+q6Vkho6T2/1I/TAnh8qkTFz295SaPu0f6?=
 =?us-ascii?Q?GZiMsHnDilZDg03W/HbjrP36hafQ2FgnvcLP0w6E+vvEMgYVKRvwqNOPXp5W?=
 =?us-ascii?Q?VLaVmJ0VROrlrl/iza8QHNVFeNgF7z+P72SS3FgO0pK65jWIyElBOxFNzcn7?=
 =?us-ascii?Q?EbiYldmwxxLrRcQNOhptFhjG37J3R8dpXpYLu1qRVfE+MLEOR6QDwPruz7jR?=
 =?us-ascii?Q?OFTAotYT34YgxySA/stKat4Oevw/oyEN6QY9cuh3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2ba165b-7886-4d9a-28ce-08dc86f53e97
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 13:25:06.2078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +zyFkNb9qg5CHANMd7E+ZzjNFg6AXarMF+j8x5h5CcXxk2ioZ+FMzI80v+srrKxbAofvKNOzaoIPxuTSco1lFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8944

From: Peng Fan <peng.fan@nxp.com>

Bootloader might disable some CCM ROOT Slices. So if mcore_booted set with
display CCM ROOT disabled by Bootloader, kernel display BLK CTRL driver
imx8m_blk_ctrl_driver_init may hang the system because the BUS clk is
disabled.

Add back gate ops, but with disable doing nothing, then the CCM ROOT
will be enabled when used.

Fixes: bb7e897b002a ("clk: imx8m: check mcore_booted before register clk")
Reviewed-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-composite-8m.c | 53 +++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
index 8cc07d056a83..f187582ba491 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -204,6 +204,34 @@ static const struct clk_ops imx8m_clk_composite_mux_ops = {
 	.determine_rate = imx8m_clk_composite_mux_determine_rate,
 };
 
+static int imx8m_clk_composite_gate_enable(struct clk_hw *hw)
+{
+	struct clk_gate *gate = to_clk_gate(hw);
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(gate->lock, flags);
+
+	val = readl(gate->reg);
+	val |= BIT(gate->bit_idx);
+	writel(val, gate->reg);
+
+	spin_unlock_irqrestore(gate->lock, flags);
+
+	return 0;
+}
+
+static void imx8m_clk_composite_gate_disable(struct clk_hw *hw)
+{
+	/* composite clk requires the disable hook */
+}
+
+static const struct clk_ops imx8m_clk_composite_gate_ops = {
+	.enable = imx8m_clk_composite_gate_enable,
+	.disable = imx8m_clk_composite_gate_disable,
+	.is_enabled = clk_gate_is_enabled,
+};
+
 struct clk_hw *__imx8m_clk_hw_composite(const char *name,
 					const char * const *parent_names,
 					int num_parents, void __iomem *reg,
@@ -217,6 +245,7 @@ struct clk_hw *__imx8m_clk_hw_composite(const char *name,
 	struct clk_mux *mux;
 	const struct clk_ops *divider_ops;
 	const struct clk_ops *mux_ops;
+	const struct clk_ops *gate_ops;
 
 	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
 	if (!mux)
@@ -257,20 +286,22 @@ struct clk_hw *__imx8m_clk_hw_composite(const char *name,
 	div->flags = CLK_DIVIDER_ROUND_CLOSEST;
 
 	/* skip registering the gate ops if M4 is enabled */
-	if (!mcore_booted) {
-		gate = kzalloc(sizeof(*gate), GFP_KERNEL);
-		if (!gate)
-			goto free_div;
-
-		gate_hw = &gate->hw;
-		gate->reg = reg;
-		gate->bit_idx = PCG_CGC_SHIFT;
-		gate->lock = &imx_ccm_lock;
-	}
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		goto free_div;
+
+	gate_hw = &gate->hw;
+	gate->reg = reg;
+	gate->bit_idx = PCG_CGC_SHIFT;
+	gate->lock = &imx_ccm_lock;
+	if (!mcore_booted)
+		gate_ops = &clk_gate_ops;
+	else
+		gate_ops = &imx8m_clk_composite_gate_ops;
 
 	hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
 			mux_hw, mux_ops, div_hw,
-			divider_ops, gate_hw, &clk_gate_ops, flags);
+			divider_ops, gate_hw, gate_ops, flags);
 	if (IS_ERR(hw))
 		goto free_gate;
 
-- 
2.37.1


