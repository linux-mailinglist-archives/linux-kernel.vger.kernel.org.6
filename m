Return-Path: <linux-kernel+bounces-190169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D48988CFA7F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 043811C2111F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 07:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733FC39AC3;
	Mon, 27 May 2024 07:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ISgry/iV"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2067.outbound.protection.outlook.com [40.107.6.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED56222079;
	Mon, 27 May 2024 07:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716796239; cv=fail; b=oUbX92HHNCpKIGZvdCh0TCQOnI8aemkLYotDNDTC2Q4E8HQQJMZA/Vc+jJjk0fDfN20iTtU6A/vPVfejC+EfByQ1w2BFiDF0pg2RuA59Yiaq1HLS/KsdOoujGuTGiJq7MbQi0oN70E98dwckKrGYOcIe3Bw2OA8nycsdvgbAEXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716796239; c=relaxed/simple;
	bh=phBvGcHMIgyfL6loc9p7Vw2mZ4WAuVHd753qu1uoV10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jp2BAB856vMJ/qLqSUiNbxAC/BexfNmZ7ftzacnXC6HG7gH9ysckaFXi39lpDk7MJUllVChUThVNJoRezf1bLciso5GKdjOCuX+9m5kKURX5aIxJWr3HKp7mazQuGyF6taHydP1NbgARitHAH1OLmU7m8vLeCPGvvtrsg1YMltw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ISgry/iV; arc=fail smtp.client-ip=40.107.6.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFUrpMu4WzOgoVvpGqZGsCeSON1uaAYNFivDYct64Tk2Ob6cIYgX0Scoo0iVGNdLzab+eGxnYY5HXZ6wIQmyhmYGSQoSWBvic4y/kCHBrZxRmlj8LZInX8NEb3FNvmFltTF+LjndTLnd/rcRvoePbDO5Ho2lk8M6VuKkArvTN+1eYhYhaP2IudjGN+obGzmR1I+E1BJDrlvRSrw8T3meYL9A0QQ+jFUHQYcyX/mNNSlV2O2PcKNFgb1fr7g6FWncpIYSVOJcBAsnZnJ6nO7jlDqOxA5H8HmyhJ1BkjoklhSxc/GiNF4lAPUVztI4ElDiCqKojfgDJt57T4oMBBUO8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63XEgxlPo9CFNy65p+vhwz62dlHiQMICvm+I35mUGAY=;
 b=bhT8eRa6poT0cqsHy5CfKmaUoGN7tt5V3LKPxhHpJyWuw68xIZlq+mUaP9jZ5TZFPWVKiHmDsUbLke8WWnODjW3j+b3szUiPs9+vx1vZSZ+ItBq1eqxw0ldMguXH6uoTwabK76iQOaC07ktZbjdogb5vBMXsvs/7NW7NrTPBUQkySixIotVu99DfnK826WrMA657JJqEFHjU5ek+ZmYkOaNyM8ga1CclUZyUCRNHXuFvKeKxBc6j5E8rjpkXlElNH5GAvz7MPTocZmN7DVrMDCHm9SIbsB/X/8E1S4UgDOli5hnGgO78XdIIzrvLC7NUwF32pprPfEK1bjLLYSlcpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63XEgxlPo9CFNy65p+vhwz62dlHiQMICvm+I35mUGAY=;
 b=ISgry/iVDSpfYKpyEq6H4I0D1lYq6d9d2qi1vJONOGnFegvzxwgoarczgbwILvURkOv6srD2Pxf+8LnPhfbd8KCBKMcjg9K6fGpPvikK5cFJOUNiSS6tMVHBjYPiIw2pTt5Si4S3MymK5ExSlFv7uqUW2cL0gmf0RsX7FuTXuuE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by PAXPR04MB8781.eurprd04.prod.outlook.com (2603:10a6:102:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 07:50:34 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%4]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 07:50:34 +0000
From: Pengfei Li <pengfei.li_1@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	abelvesa@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	ping.bai@nxp.com,
	ye.li@nxp.com,
	peng.fan@nxp.com,
	aisheng.dong@nxp.com,
	frank.li@nxp.com
Cc: tharvey@gateworks.com,
	alexander.stein@ew.tq-group.com,
	gregor.herburger@ew.tq-group.com,
	hiago.franco@toradex.com,
	joao.goncalves@toradex.com,
	hvilleneuve@dimonoff.com,
	Markus.Niebel@ew.tq-group.com,
	m.felsch@pengutronix.de,
	m.othacehe@gmail.com,
	bhelgaas@google.com,
	leoyang.li@nxp.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	pengfei.li_1@nxp.com
Subject: [PATCH 2/5] dt-bindings: clock: Add i.MX91 clock definition
Date: Mon, 27 May 2024 16:51:55 -0700
Message-Id: <20240527235158.1037971-3-pengfei.li_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527235158.1037971-1-pengfei.li_1@nxp.com>
References: <20240527235158.1037971-1-pengfei.li_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0118.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::22) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|PAXPR04MB8781:EE_
X-MS-Office365-Filtering-Correlation-Id: 24c029a4-7b7d-487c-09ca-08dc7e21b04d
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230031|366007|52116005|376005|7416005|1800799015|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?hWWjAmZjPuheMLuQv4R/GO7XGxQnwh6xBmxSmb69oB0j1uh0JxxIVpRXhx5o?=
 =?us-ascii?Q?SY8KuJFZqeFfvpCoO9rbmChAGfTOMpfzBoXWXznhrO5PdgisT8a3pLI/jB5+?=
 =?us-ascii?Q?289A51nCEMkW6qo6XiDIyy8g5ZSTTrTz6PUQYcv4f9QZe/ql2EDiOmojnwMn?=
 =?us-ascii?Q?1XLT37kC37Ur5EoyzdPdfNLVShMO0cSzpy7+t8vrqCzn+1Th4Rr/oKeiHqgE?=
 =?us-ascii?Q?DO9Klr6xKODDGNj+zIPGwVbhyGhCra2rFl8uIZeEbKUKlPWyhr+wB0JbvXSW?=
 =?us-ascii?Q?x1oCqPRjlDl5NJKo1dhM5+YoGMszNiWSP7I1BGkYcNy7BfKB1cYzYKuOECht?=
 =?us-ascii?Q?2FgwxoGfLm+XGzuto1tpOPDUb8LpCFA5Veag94foDQdJETCjV7YSwJbLZJc1?=
 =?us-ascii?Q?KgLhPv+zbAJtbqsq61Tr/P66bkvrH/vFMiXea9M3nYqyuiadWYm1OjWpXxz7?=
 =?us-ascii?Q?L2yy1WaaZzn6LqfXEkSj1kJvCOHT9ZP8XUNit8X/9NdHzHlGk2KmzosIEWZj?=
 =?us-ascii?Q?yiBq4jKuqwV1iPNxKsLg98WPLmXGdbcX2dNCH2cm8Iw5QdsB9QzeN1FJAuPr?=
 =?us-ascii?Q?Nhl0uVM5yenBrW22Jvfv/TVOunMyTkd+fgWi4Yr/Sd+ZdSnSaJdGBSxx29sk?=
 =?us-ascii?Q?T2Ezf8VU7BS4VgmXVI/+xLgHXmm7VqQpvn2YQ4sp6YjXFMh+OGuk3pxxNRLb?=
 =?us-ascii?Q?+czEmx/JxRtH133tlCffpdvxjha14rbtYVbjBffQIJEAtRo2usWXyVV/dI6h?=
 =?us-ascii?Q?xOzKZIecsp/4qBwgUtG96Gt9bzbc8PBEt1V02LuMJCRPt2TkPk8xdMjaG0z0?=
 =?us-ascii?Q?XKItUHpRBgRYA0g/J/kvCNMnHiCjusUCUkn7wjert9f2s7XUB1v0T8ObSm02?=
 =?us-ascii?Q?LieSHC3plPCBkH1TuMojIGX7ijvAgoOdQyQE2ob2J+rilk6LrCXpacJMTgnQ?=
 =?us-ascii?Q?zz1BualAPfH2+n5U9KtAhfIp3Mx4cV842mdMoQZ62vHCR0WnIy+m0tjBHvIL?=
 =?us-ascii?Q?PPCKgVgSJvsSDJo1FcLlQhBvE5OlkOQcd3L5ATS6fLZpdWInxBFw4FO6JmPZ?=
 =?us-ascii?Q?LgseUnfLTBR1pVCNOrROwyk9Wv9sS4FHdJ2z1UFpUT0zwV28GwESOksT1oIH?=
 =?us-ascii?Q?0TIBFVCTqLqmZE17Z4/MBRMYaXpZ+OHMysIjDMxhT5tKnoRx8xsrpy02jCBi?=
 =?us-ascii?Q?BuMZ53II47lHan/wgLgMxDH5qUn7mN4tYb7LFMZ8wilMMzpIGS4neVVFEy69?=
 =?us-ascii?Q?dvnZ+JryAV9q34VTkmN4Pzj/zsoD2u55ZymLZcgAXtWIxV8nN19hu/WZGddW?=
 =?us-ascii?Q?g8p8ghFsvAx3lgMk6H6zaFiAYyP4XaJfoeBOs71ESQDDMGF+ZD46RW0dNow2?=
 =?us-ascii?Q?5AxU7z0=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(376005)(7416005)(1800799015)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?5IyLGxMvoNzEFg0VRJj9BuwZar71fomeSdrNw0Khm/1qrwmmkjjIibYGAQZo?=
 =?us-ascii?Q?wtYG+hbPMDCy+H1CSyFcnzVCd7CSNKTTu8cCPYHkWGxc1Qhiu3XLiLHIMrVy?=
 =?us-ascii?Q?cMX/w3JrRWqYy4pnCMS3WrgkHJ5bjfNp02hZCrOOlr9oE6QMKpBJd3QLZXx2?=
 =?us-ascii?Q?zOEcqF1IuhFPSQAvVB8THm1rkUZ2RLtAcQrxFeKFF7EOWoT1+m1jY7XgZhnh?=
 =?us-ascii?Q?WkbC3GcJMqR/4m9m9wnkkw1gmYSV7xWR3UenO8QKn7by2WSpttKSZI/XbhNb?=
 =?us-ascii?Q?gtmn/yC2CKMqhILnzPKDUfPgDEqpRnYyWUeY7C/mHyxMC4RVyQuoo7Bg2uob?=
 =?us-ascii?Q?NVNP+zBsRtLaCaQsb5mgPoEWQech129Bhzj4miuT1jzS62utjfsQYIJ2Nl3K?=
 =?us-ascii?Q?FASKSg+ITrGHBYDHDCtMascxjqcK4/fwdJS+cKnpxhrBnlEWNspyjSweng9g?=
 =?us-ascii?Q?aQsurSJvRRNouLF3MIcBfmFcEFUG+g1uMuR48zFF9I/NQUx37ulCH+tY7bgy?=
 =?us-ascii?Q?YWk1bTW+d72GEQD+WrOI78vDi53zJGA9UPKkYbMr9FMvijcChxgvCRKALLFb?=
 =?us-ascii?Q?tlNsLUXtclUQzkIFxr/6Te7d1ECdfco2WqKxXnNLEr2hs1H0MkIVf101SmlW?=
 =?us-ascii?Q?bBTtiCLPhDbdSi/iTrGYKI54pn8z5ZIDG3wZZs+Zfbhw0hyyDB4eY4lNQWd7?=
 =?us-ascii?Q?efePJzmlByBe8tGfeM5errwV93u/NQnSBQWI3KnrSJ3tG888Ptf5/1xSOaB0?=
 =?us-ascii?Q?R8zrsWv405cXLBSGg1zOKoJ/GfO7oK5JQM8lJZtrdOJKu4145pITTg3ftFZW?=
 =?us-ascii?Q?7e7r+f4Aba7dc9fTVKrfgBWICkafiY4CQlW4SWFR1jUr57tn65Da79hwYt4y?=
 =?us-ascii?Q?WOgN+RmHwT0shHkb/ej1kmdC5BekYDUvNpEQbzupB81hbqYmC6bX+pauaFsA?=
 =?us-ascii?Q?kxbSYBZ8M1xdi88Wop0LFftdd5BWRC33xejTzuEYI8xjsbGB7/vl8sDi0UDB?=
 =?us-ascii?Q?CXM9kCKLOvwRtNJJvFrjnTjuGAJAf3PGXpEW7htiLDrpu/2pPce96xiO/ws5?=
 =?us-ascii?Q?3Cy58TrhRtnx5/EIosuOmlg600I3EVwNXTVZQWo1WfIG0iOkRDuZeMYsKFRn?=
 =?us-ascii?Q?ds0Vo2zbq3dqgRgCX0UnQOoCcWGW6tKO3eUg4MncZuI0f5YNZO2ZPHVhtlSJ?=
 =?us-ascii?Q?BH4fVMg69fZuhgvhYk2RVDQWkShUPbDjkrpzXxUucz37JlTv6ZAK1PPrI3JH?=
 =?us-ascii?Q?t58gwzX45nKTN0AkV1ksGl5RoEVfWt0m+Y0L3Aj2UCy4CVD3RNR5s6Z77z8n?=
 =?us-ascii?Q?aUjiWaIUZNXtOwbb4HPYk2hknZ3m7dWdA33QRxF253vU+eFthy/EPjyD4zt0?=
 =?us-ascii?Q?BBVVzjeEIWqnnjF1HPt9r9dehs3PBV+GdC+iZMfQWXr8olqO+68HDI9HtZEI?=
 =?us-ascii?Q?HHU5VFoIgl4DrzNafWgONYhU3366zsXSOpiPBVIt41DIervWclvdwAyPsMzN?=
 =?us-ascii?Q?cY3cDZlfctYAmPS9hep7woRFKQlEuQYHfbL3/mYqdu34RHjE/R5P96uAQwNj?=
 =?us-ascii?Q?7fuxgprK/7hDMpLxUuCRlH8zCzzqSDex/ndr5iVT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c029a4-7b7d-487c-09ca-08dc7e21b04d
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 07:50:34.3622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dL7bZzcutz44qMQTyaSDNv66Co/irWFc0dU+3Xv8FxgReDwQLWEmQblm1Lv6yRaY/HIcwQlMIr4Y0vdYasWZQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8781

i.MX91 is similar with i.MX93, only add few new clock compared to i.MX93.
Add i.MX91 related clock definition.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
---
 include/dt-bindings/clock/imx93-clock.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/imx93-clock.h b/include/dt-bindings/clock/imx93-clock.h
index 787c9e74dc96..ca0785f35a46 100644
--- a/include/dt-bindings/clock/imx93-clock.h
+++ b/include/dt-bindings/clock/imx93-clock.h
@@ -204,6 +204,11 @@
 #define IMX93_CLK_A55_SEL		199
 #define IMX93_CLK_A55_CORE		200
 #define IMX93_CLK_PDM_IPG		201
-#define IMX93_CLK_END			202
+#define IMX91_CLK_ENET1_QOS_TSN     202
+#define IMX91_CLK_ENET_TIMER        203
+#define IMX91_CLK_ENET2_REGULAR     204
+#define IMX91_CLK_ENET2_REGULAR_GATE		205
+#define IMX91_CLK_ENET1_QOS_TSN_GATE		206
+#define IMX93_CLK_END			207
 
 #endif
-- 
2.34.1


