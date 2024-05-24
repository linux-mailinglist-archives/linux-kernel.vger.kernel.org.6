Return-Path: <linux-kernel+bounces-188414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FAA8CE1B7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5532CB2038B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 07:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E0C487BF;
	Fri, 24 May 2024 07:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="W11VllKR"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2053.outbound.protection.outlook.com [40.107.13.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6D66FCC
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 07:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716536881; cv=fail; b=db26gg2lYIckCvfDgobuPGuoHSEsWSfF7V0ziJxInR7o5R3PVLkfCHef7ZRzRE4l3E/3OCw4zWuIhZ9vyF+NlCZG4KS37tjDtLmhi9U5HszNx3hYPvByxPt19Xiwu2NIulf9Upn51OqwgVp2qKi2hHSxDMrhNYyHZh8YwBzwiC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716536881; c=relaxed/simple;
	bh=6GMZakGCtlidiqF7IBTVnqO4OUyJUdo017Xw5FjAJuo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Z+qz8nj9vtnT20+S95omz7+QSDUMKgPUaSRMnGr72r9ozerFWzL6YSqYgD+K0tFLwCofmJRcM86AlxZUGOqaGE+i5VExl41nkSogrvi30Nj0bTd7IM29OeKr21hernAHVpqFWCczFbh9/1NP3q35FcDV+UUDsZZKR0LpgDVNWG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=W11VllKR; arc=fail smtp.client-ip=40.107.13.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UpOx/UyPqm1fJ1SB27JgP5O3Nr80vwigN7fRQVd3TBp/CV7T+b+bK2o2BWiT7BJEK/a0l88z3lwiXMxZmxdwk8GC2hX7ec/SCMrpVDGZhHWo9uSe51Ie7KemgZN5X53w1YzcucJiMVLAdtEzklqfcJNXnvwwn5bGCtwpgWZ48Bb4C2hMlLTg+soYY46WbeVy8eDcq4e+zttk46+Dm70hnas4R9hEDv8PR2kDQqR80Q0VzGKHvqKmLjP/V6v/FaMebj2bN+fIWkOJ+PJcWuuNCVK2npAAYa1CUFPirLME5ReHMvGXKTv4junwZ7QatOhd0VfeiqGqMvY4MMP8Dqb0+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sT49zB2xCkDCe2MHK6qV90scOYjR+/CjmSEWgazEacc=;
 b=aqxLbobfCaaUPsGevNvSl1OitsgAd709iAeuArkEwAo23yucTzXD+ZvFer3oLzdxxT8RGpUp4XCIDD0BaanzCetFIljtVqmMFdYV9ioCQqNncdHyh6HcJ2GvZxAANaRk1Y/JynqUpzr7QdmjfIW0a1MmpP0gOcykSiTPj666hmuKFCbrkT690sCM69AglYkTBCgBnzJhhAUShI6lNSIt/ElhxFUgpnLNPiireT826P4KgXLty4PMqhcCcmdcBcltkfowB1CcycqIPkf7F6kX0Snby/9ZOYMm9TI6f3XApxOQl/BlpHfd53LLH5gyGHUa/qcw/I5R8ENLRjGdRpRYsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sT49zB2xCkDCe2MHK6qV90scOYjR+/CjmSEWgazEacc=;
 b=W11VllKRpzhc47XKpE0IUjRVNKdLqGWAfSUgj1CKxAFRKI5BYItC1j0U2+yVZHpjcHdzWuZIdc1f4s+t6JKbzIF/9Q1kRNcP3I6SX92Tivs1UnzbCLhSwFE2Gb5IeQ5euNgAzAJTa4T8WcujzBYI7RcqtJvB+aefFVsRLSARIbU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 07:47:43 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c%7]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 07:47:43 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Jassi Brar <jassisinghbrar@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Peng Fan <peng.fan@nxp.com>
Cc: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
	Jassi Brar <jaswinder.singh@linaro.org>,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] mailbox: imx: fix TXDB_V2 channel race condition
Date: Fri, 24 May 2024 15:56:32 +0800
Message-Id: <20240524075632.1009044-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB8951:EE_
X-MS-Office365-Filtering-Correlation-Id: cd554cac-c413-43e6-70c7-08dc7bc5cb6a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|366007|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NlBum5W8pciNMhxKj3pu4gzc4XnkKSDXeNGHY6XAIS80BqG3vuxadLvFEuvJ?=
 =?us-ascii?Q?42lm37jX91HaztTJFiC7+yd6sfjpGVms/JFap4IgePSh5aBmZjvY2NfVIjde?=
 =?us-ascii?Q?R1gHJc28rBK9U16QNbzQa9/FA/yt2pTTalnqjFDivqKt6/VCj9EX2G5m+PUa?=
 =?us-ascii?Q?GjA+vU8JjLgI98X084SlrXGvCD9cWOCFJawdvxZF1nBA8MpQEuT6bGxh7lEt?=
 =?us-ascii?Q?uWqEAIFIxrAbKfYPnTNF0AQO2H9PXhBIsWiIIuuE89Ufay+cBeYplOVzG/Ix?=
 =?us-ascii?Q?ANK6O9M716tVXCssTG6riQ0ETqpWOE5dHpe3mhMfpNBQMJRQrCQuar6OKmhv?=
 =?us-ascii?Q?92V0DfB9YNqsDcVmmD9y00oBfP445yuKhqLV//qcm0IqD0ltdEMUUhd8rtgF?=
 =?us-ascii?Q?TjmZMTo7ptPN+HoSab39bF/CgEJn7itp0+/EReRjX/O9BXktNomzpcrHup8P?=
 =?us-ascii?Q?EO+TiROUa1bmkQSa5UIYBkmXvAf9HVggmKOkuxgHteNFKknaDgYj9CeTj/HW?=
 =?us-ascii?Q?j2rXgRZRGtUdT1FSe+YXI8mQTa7EnwTvulKhjt/YtfDL9jEPayU9J0fnKoLm?=
 =?us-ascii?Q?xccFdPIvXGaebSEkDNDOYr0DCt1MZrNQWQYMomn1KdmYipGwEG/4fT1Zos95?=
 =?us-ascii?Q?8p9ixfBB2Zv9+rkZXfub2nDGxahVUtrkSY45SRCkEis3p0oOqhFTTL+dPTOt?=
 =?us-ascii?Q?7FJz1xDgKMv8Xzq4yEbghWM02eCck9XWUYfJXuuZKYa10vnd+GfUgRSxcxnA?=
 =?us-ascii?Q?cffhOA+GJTsgxpLQ0QrKqkDxC7x5pijpVVZGRoGXIBqrBAgeoQZkEYdIC8+R?=
 =?us-ascii?Q?/ZdihYPYJmhJmUEpPVOrqcNbkzJ09SOXPCAAuuDjxG1u4XrKpc1HX5NKNv4l?=
 =?us-ascii?Q?xOJ7aUCzgfm01DnLtD+KJ9P1FxtmCcXfTeKr7TltFm/OfWXqEiJxcq5jXQ1+?=
 =?us-ascii?Q?LWTH3ZgykD6rn1S4nYg8hylrLpnP5ORGmRxseCTh7eNGxWOIRV07iW8Fuv7b?=
 =?us-ascii?Q?Se3i3v3wXWVaMf14vsFXHT4DExSawhzcYB3K3KD0woJLYzYjSwSUDGVUdMY6?=
 =?us-ascii?Q?qXiuOwkDXsixX1S/rOy+IUfWxcjJW5iVfIgxu9hcQ+7YWoWi+qqgZz1adz5r?=
 =?us-ascii?Q?RSwRbJmNAd1y/8h+MehwBWn6w8V7lywrUrLXwW7ElKyAFSoOJmPDpSlJXaeP?=
 =?us-ascii?Q?Htc2iTqxQms97uOPFpwIGtCA79CNUQyzBRD51If3MyAksAXgPvcdOEKCJ6n9?=
 =?us-ascii?Q?PeQz3EWe/mAV+B5kB87d+0czUFqA/yBkX0qV6TFHodV88eS2aEXlnwEZp3ri?=
 =?us-ascii?Q?w5yioeFhiIGwsm8iuZE/rnRZtdp0duiAHo6UgYACz3FawA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N/Ht5qFTCfCziOHA0iGRohCB1mDHGH9Uq0xjY8noGlHLYrUE46WdL2xjodeC?=
 =?us-ascii?Q?PeUV7TzP+yo7JKaVVtVwl+7lGtn3TvWyJlg2FQWdM4HALWvJQXgujiYPAj7B?=
 =?us-ascii?Q?FMRcO0LXIFvmdvP727tfoDutTMSUVOP7bxNCjR4ywDtiqzqgLZ3tj/Nbz0al?=
 =?us-ascii?Q?Y3v9mHHJCB5U4d3DaV9mLxl/NM39adVapFZ+Rqk0901wkcMyOc/sMdppEcVK?=
 =?us-ascii?Q?UUUtqKADnhvKvBEHmbZOiVitefpFaTHxS0s3nq4Ds/T2vOSoHKBFImo6XyX+?=
 =?us-ascii?Q?XzPSK/UtR+vEAeFvXCBJ3HE3Ei1RyXgH8sjPOx+W1O58B4/g9dlk/FNQsMTl?=
 =?us-ascii?Q?FJZIiXefalDSEwP83xAs4C2nQzb7o8z4AayOYS7nW0SheA1nptZ506pz0YBN?=
 =?us-ascii?Q?DzoPzDP0WRRq/sAGj96q2pneCH3ICu8SvMF25IpXqGMOtjPnPQ2oXLTI2ryv?=
 =?us-ascii?Q?fQRwBYDll4vzlKkI1py3RrbbVBV8nK/lF6gLERO9JIcdZPYmHC1dIRkYh0BT?=
 =?us-ascii?Q?Pl9D8sQvQaDjRTF8xFpYoFMAx7mBfUvoNVVY7yj6QTxrdbDqxsixiizqaD/B?=
 =?us-ascii?Q?n0QvTQubPVl81/LnSSsHvLw+8qHCCiQahTeDl5XW2/ry72odY3jsd4RhAu+L?=
 =?us-ascii?Q?9dC62HZB1shGZJqAUJBbQbGXf22AxW3kO/qbxPVdIQzNELIwiBCNuCr/cqYs?=
 =?us-ascii?Q?ptBxxSBMhzToK8chwu6oUDneIPuCZHbHevJxsR3u/pVta/1egA/VqWJKx0j3?=
 =?us-ascii?Q?lYjzJQlaFLk92F40ddG6hd6uHAzaSA0yBR95ItaJjmFEsBk2DrauG+u4EmI7?=
 =?us-ascii?Q?vtDp9s+XkYtvHiNHUBXeb8Oxf46re6uxUMmH0a7/Vtcs++0IOkiHI03zuKFX?=
 =?us-ascii?Q?xwgl9xXEHYdlrUczmRzVRllkVaNB2A7g0DKGjYMp1haLTkuHk4Kmx264x5Bi?=
 =?us-ascii?Q?kv1HqI4A6yWgbIS826R1UEI3jp4jfNc2zNNygcMteZm4Tu8ZH39ArPtwLDA+?=
 =?us-ascii?Q?viFmIJdosiBvdGuSK0Kmc8XpRSn3TEgMcp6KK+pehvxVQIM/2yiSw/0mr/Un?=
 =?us-ascii?Q?demI8YLlbqdzsDwF8Aw43hoPPd+Pa8RnP+E7uXu1nnI/0KJLIW98Fsz0tnQg?=
 =?us-ascii?Q?zAFimKn4p2xgwXYdzrUtRi3DDzgiIZLdNx5C7phkBqaULeDhd2HW+u21huYu?=
 =?us-ascii?Q?eLI6Eps0dZSZbAA9y6Cu8/NIgVBiaW65XotAoTTk2idbzrYEN1w0MfoZBboA?=
 =?us-ascii?Q?vipK4F9NtxaMPnOfmHCTHwN1LAospGe/cwCnYb4U68Htx/JK53c5l5pwpYut?=
 =?us-ascii?Q?i52rME40dXgHEbbGLsKZo9jZ6IgzYe1ply4W6mkxgP34c3V5zSkRjfX4d6FH?=
 =?us-ascii?Q?ghZ4hXM+cxunNvYUPPczI/szSN5WOkfSkNfQlsQrW80fPdpMksBjV5cG2Nlu?=
 =?us-ascii?Q?ntg92L2LRcdDIdt2wy+MUzxMPau4VvnsjDCc8Iceb9+OUBk4vOo9hPPSsNkx?=
 =?us-ascii?Q?tVbj3Qd8nIGpjTFnjrjDO/OGikFEfiexjoMror4d/89RmBu9wI5o8D3dwkJ0?=
 =?us-ascii?Q?hIyCEsPUILJK9+w6RGLDBHpWFRjtGkCHqbW7TvX4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd554cac-c413-43e6-70c7-08dc7bc5cb6a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 07:47:43.4032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MjLqagxPpN84F8LbZHngBS/KyJogdsnXIDl0oGeoW5jTzznYS4sWbn43edu5ER0LIah+xTC5QkZOqJhS0/eGyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8951

From: Peng Fan <peng.fan@nxp.com>

Two TXDB_V2 channels are used between Linux and System Manager(SM).
Channel0 for normal TX, Channel 1 for notification completion.
The TXDB_V2 trigger logic is using imx_mu_xcr_rmw which uses
read/modify/update logic.

Note: clear MUB GSR BITs, the MUA side GCR BITs will also got cleared per
hardware design.
Channel0 Linux
read GCR->modify GCR->write GCR->M33 SM->read GSR----->clear GSR
                                                |-(1)-|
Channel1 Linux start in time slot(1)
read GCR->modify GCR->write GCR->M33 SM->read GSR->clear GSR
So Channel1 read GCR will read back the GCR that Channel0 wrote, because
M33 has not finish clear GSR, this means Channel1 GCR writing will
trigger Channel1 and Channel0 interrupt both which is wrong.

Channel0 will be freed(SCMI channel status set to FREE) in M33 SM when
processing the 1st Channel0 interrupt. So when 2nd interrupt trigger
(channel 0/1 trigger together), SM will see a freed Channel0, and report
protocol error.

To address the issue, not using read/modify/update logic, just use
write, because write 0 to GCR will be ignored. And after write MUA GCR,
wait the SM to clear MUB GSR by looping MUA GCR value.

Fixes: 5bfe4067d350 ("mailbox: imx: support channel type tx doorbell v2")
Reviewed-by: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V1: This patch has got R-b inside NXP and could be directly applied to
    upstream linux, so I keep the R-b tag from Ranjani.

 drivers/mailbox/imx-mailbox.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 5c1d09cad761..38abe07babdf 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -224,6 +224,8 @@ static int imx_mu_generic_tx(struct imx_mu_priv *priv,
 			     void *data)
 {
 	u32 *arg = data;
+	u32 val;
+	int ret;
 
 	switch (cp->type) {
 	case IMX_MU_TYPE_TX:
@@ -235,7 +237,13 @@ static int imx_mu_generic_tx(struct imx_mu_priv *priv,
 		tasklet_schedule(&cp->txdb_tasklet);
 		break;
 	case IMX_MU_TYPE_TXDB_V2:
-		imx_mu_xcr_rmw(priv, IMX_MU_GCR, IMX_MU_xCR_GIRn(priv->dcfg->type, cp->idx), 0);
+		imx_mu_write(priv, IMX_MU_xCR_GIRn(priv->dcfg->type, cp->idx),
+			     priv->dcfg->xCR[IMX_MU_GCR]);
+		ret = readl_poll_timeout(priv->base + priv->dcfg->xCR[IMX_MU_GCR], val,
+					 !(val & IMX_MU_xCR_GIRn(priv->dcfg->type, cp->idx)),
+					 0, 1000);
+		if (ret)
+			dev_warn_ratelimited(priv->dev, "channel type: %d failure\n", cp->type);
 		break;
 	default:
 		dev_warn_ratelimited(priv->dev, "Send data on wrong channel type: %d\n", cp->type);
-- 
2.37.1


