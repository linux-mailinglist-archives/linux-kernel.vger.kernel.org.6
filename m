Return-Path: <linux-kernel+bounces-232001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA7F91A164
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17D54B20B95
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 08:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8AD80031;
	Thu, 27 Jun 2024 08:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UNoc+8v9"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2081.outbound.protection.outlook.com [40.107.241.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8617BB14;
	Thu, 27 Jun 2024 08:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719476802; cv=fail; b=l6i+y0Kgt61Y6e7LP/Dib+mQR1iEN7LMW2jgTv4S1yXjtwhiJAmA5gs9tdxq8dL8Fh5kmp1ZHTgLCsySvGLT3G5tzkxCRSDB4aNOAdQqIM/X0UAoQ0U41ZKmWjhWezTK80W/HUXXHIeQwYog96ppGQYqebuRCZ3knsMyUUHKzks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719476802; c=relaxed/simple;
	bh=XJRfCZS0HiANlY4iXmIvNKB71345nv82WIQ5S+HVgag=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Lc1pu0aUwKEcs3qQ+jn5pPjeMOPwJLxRR72qgYiGBvgIGepqiInwqct5Uhff/uSwWoHID5OBfl/TTR2a1w+kDz3j8XP90oZybiVTJaVOqyQ4ikstL3sFsMFpgUdqHEgsCwD+l8RCBN/SIN050DEdLlBSeGixP/OGd63Jynu58VE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UNoc+8v9; arc=fail smtp.client-ip=40.107.241.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvNs/bWsta7UQ2YAxvcB2pqBm7o/D/GPfAKlw3l9Os6GrL9wzMPSUikfoAvx2RwqRd02lGbe4LvJvExgkVqk8MDpL+98zUMkwoXWh7aJ8VrKIYj3eT3eUliCrHrXV3rnv0e/YeCPvG0FCHTK7iJh//whNnwNcSFB8O/R5YKWp3tLogwrGZLy5uMo5bA2NWXGew8XVYPmfh2RUAwuAXEzPBWbclQuqLfh7yIWEbGWh1sJx5KUm0hb080kpmWn+Ru5Ks6c0gFJZj73qSUcucZEIQKK0MeE29IN4xejWVtMeq9Yz2nDyiMpgTEJTPPp9JCTaqrn+tfHQdQ74hmQBXYc7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9izgsE5ZXtem6NM0fAbNFRgTHS6YuvqBoorAp1+HtM=;
 b=UyfQxDFGXDEVHxkJPjhgQYqc1MtEUkK3N6DFDO4gxwS1eTg68AiUOAco4vbOUhw5TvOe03IeEmBhLBpNKM0fkJ5DIlvJ2Ce5GxiEN4bfX+AYkWmpWyUvl0703ysHz/ycGVkrxOJaAcsndupAx1VOSC6/50uuKhZ3JXa7dXlfIZ5Id32iB3p6e2SewA7tvAX8EYo0pq1tfL9WAX0rUjUgGYJVSJo0nOfA3ce9MxlhN6LZ5CTn1AzNEX3rPJ4h/vd24icYdPSuebU3bdakaWFg9LN6rCYVTTdTgvP3u0Ytd3kp0+cV9skc3KyyLiPeiljYCNETRq6c3DfFx+GTSrTxxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9izgsE5ZXtem6NM0fAbNFRgTHS6YuvqBoorAp1+HtM=;
 b=UNoc+8v99x8sQkzBAyAZXAqp0VMsW7legirI61lI6lR0oeWGboHXhT34/y+wEuc8soCRAaTcp/uBxeajdH033pj3npGDnb5iFssDwgToTkBXAx11+0oGrycmMkDSXsSN3q7zLGHrxf/gQSKNZ8Jjv4zZ1KBDb2Xmq3dhuzHVoZs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by DBAPR04MB7432.eurprd04.prod.outlook.com (2603:10a6:10:1a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 08:26:36 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%4]) with mapi id 15.20.7698.033; Thu, 27 Jun 2024
 08:26:36 +0000
From: Pengfei Li <pengfei.li_1@nxp.com>
To: krzk+dt@kernel.org,
	robh@kernel.org,
	abelvesa@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	ping.bai@nxp.com,
	ye.li@nxp.com,
	peng.fan@nxp.com,
	aisheng.dong@nxp.com,
	frank.li@nxp.com
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] clk: imx93: Move IMX93_CLK_END macro to clk driver
Date: Thu, 27 Jun 2024 16:24:24 +0800
Message-Id: <20240627082426.394937-1-pengfei.li_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0128.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::33) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|DBAPR04MB7432:EE_
X-MS-Office365-Filtering-Correlation-Id: 532a1c10-938a-49c0-18ef-08dc9682dc13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JYu0sXIi7Za0F5zuxWKHJct5dJI8JCrtg2KwsxImw/zpjHWiO3XtBgU7XRYs?=
 =?us-ascii?Q?ErxrN9Eo3DjH0X3x72vWYkR+2WnSURg+jeSr84UAl2XUXHiWMwdgh2dUZkGe?=
 =?us-ascii?Q?cM2BWNb8llyKXYEgXctqwIzwftm54ToVHkbXRT9jvP5EZw97H+2no29odVlc?=
 =?us-ascii?Q?2ggSUZ7oA3dn3ULzx/QmXiYgzhGPs4PSpOs9A22LXrfRmiiHmj4xs+WwJgMI?=
 =?us-ascii?Q?7FReHMPha9ftOr5TtITZP/zkspiF6fgSB7xwVdeWzLsVlF9dzPzh8sn7jPUe?=
 =?us-ascii?Q?IWNKVatXao21wvehhX2kNRrFsbp703zsBGisdfZb3XxnYXnoXqPxp/+sgptZ?=
 =?us-ascii?Q?YmQ+OzFaIyQyHO+Btkdw9Xc5AefqFkur5ruPSZmCcvuIFk0yxLoEfSlFHoO8?=
 =?us-ascii?Q?SOpwqc40a8Gi7+sPUUk/9REXZIc8Me05miv6ILiLlU4J55cLc1jLL5GcmrlR?=
 =?us-ascii?Q?6VyKaLcwEKPev53FFZZ+X3R24RCfjPUuOYuHZhAZc4rmf6VUZBMWVv9r2hTI?=
 =?us-ascii?Q?C7Mbh75eC1nKavN7BsUeCH2/667QZMtiOYTS34LIufUz4f+LQIbjoYU1MLEU?=
 =?us-ascii?Q?kVbVbbSb3bmlGbQhPH6wk7nU5Lv/VW6a6kruZY+Dqoj5DIIx57wqU5XSSnPM?=
 =?us-ascii?Q?FD6wV7KCHQtQopBeIYy/64B95jx6yRxVpawQqTLsSM25rx5U3V4QxYMEEeEc?=
 =?us-ascii?Q?t/m10OmnnjkMHzeseTs71MlCZ2F2/Spi/6phEBpjZdxIG9DXPTsodHIWXifd?=
 =?us-ascii?Q?9NGQjQLfvSe1ZIvnrjvIwcoUC03XDLfzQzKa5RJxx3dyIq7Uc9LKoAqPBdzq?=
 =?us-ascii?Q?aO9SqLENR+gjywxF4OommQGnZHABTdcr4q8Wy2z6XTp6uXUKH3N0T9KpvbF/?=
 =?us-ascii?Q?ZzvWE1xXEtQ92BSyZBuSqtOdNjRnlFCu61Y9oG4PJ6Y7UZ9k9eEo1TvwlKCD?=
 =?us-ascii?Q?jDRqen7Sj95x/Cq5iYKq86BpbPtqQkcaaPsJKeIha2O6bhRsiCaKnxyXz4f5?=
 =?us-ascii?Q?I0WeUxkzVFFTuJQERY6bMhgETY3kCXlUqjxU+4RE9ztDEdAzEJDjw6eDL7Bc?=
 =?us-ascii?Q?kCQVBVE7WNEcgn2UzLS2BkjqUWmcyMsnvVkuAJ/c/+g1dgc2w2yowKi3P5sb?=
 =?us-ascii?Q?8zpFq0cVY+lW4/2RNOMgqFHlqLtFQHuFSKa13Fz/byW3QDc4qJL+gwHHMzn3?=
 =?us-ascii?Q?pyC4uIvJdKacezLOggINvmgsqdWtooDQj94wwGKF+OBLO+spPxV7eVfRpxhv?=
 =?us-ascii?Q?R4KT3M8CrhEGZgJCjiKHSnvCXuoktHidwgKGeg4fktVbb3ZThTFZRyiz7mNe?=
 =?us-ascii?Q?IPFDhp0lrEdT5z39sIqezWk+AZOOLGd7uGmy+Tj7AOPo160CGkj87dhfK/sp?=
 =?us-ascii?Q?yyIv6gSSM5iINvqF8MeFZ+fXOkkp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OHLJhIU9XxoRyzgVeg+XDNioyCPbB1lG4eXo963qvzVLPPi9wkN8caQxqprI?=
 =?us-ascii?Q?q0n9mPrJ/ivdGtwtFuuqd5s+Zke+roUnt5VvdzbGejL8sQsyMtF+lgy5HgxS?=
 =?us-ascii?Q?fttvaJIGJ4tFBKpmtG0SSt9O76KkewfoUYnVXho+gDx0ATvCDfp7bgUgEmoe?=
 =?us-ascii?Q?2xqagD/+c5xnOqHae2lRKxRNcejYWVm8pW0YyoIDlmG6EvwRShoWMyU1dYKn?=
 =?us-ascii?Q?i0WMz3qyIqNCKSwSjNPO6KO9AN8H2ci/9M7wTQvSCQY7aIGjK0JNys9n7JxX?=
 =?us-ascii?Q?lx1fu9lYrIkb0CoyHyG2AbW9P2Bu/8p0YSQ8DFXie+c6pkUQf9bHCrHRcm2g?=
 =?us-ascii?Q?Q97Lht3BPz3mA9gi9AncYPcPUwRfqy5H6mzFgGDb7m6/DER88VdZLTme++g0?=
 =?us-ascii?Q?A9SL8VpyTiPHDwckyzsyvDp3HI29Txl+8JTKLtKyV7WSyP1FqrwzoU1BOxZa?=
 =?us-ascii?Q?wW/VPYVWzqaCdTpNGDiRk1FRjxPG/O+HliJe45vrfs0xWV1FzfnxxI6sNk0o?=
 =?us-ascii?Q?TjAL7iL51iJd3C5sh7Vjn9q/p1IPEqSYtK8WFRcsl9ZZ6GGitgtZesuBJkZz?=
 =?us-ascii?Q?1KwXvnJol8tAR5/trglxuGKEpwiFRN+KqKTSTLiVlLNgqyx9mOAmS7+LsuGY?=
 =?us-ascii?Q?AbJQZZ7d3aHftZ1Atbs5qYadzTWDxH/kMxUxMhX0rerXuaCdWvY+9eD3Uigv?=
 =?us-ascii?Q?prbSzpiCB8+W2YUCqvhql499Sb9sOWZuqJOpeoHKgVcRLran6rGUsapuNsxu?=
 =?us-ascii?Q?d3eMiT3bKdNSeWgLVJFi9pWObUhY8PjAvZSyn1daEnMalfAEnr6T0lmq54b9?=
 =?us-ascii?Q?sIwfd99HYIDOWYR3AyISgUF9dcMz6K4momhz2eFsIhT/uFoT7ZPP+u1PIuAF?=
 =?us-ascii?Q?hoHuR+hWbXAxs6yAeLi6NN+O8HqE0cBamr8yoio4r7aNz6NZmN0rExZIE/ZO?=
 =?us-ascii?Q?0E/R/D6KenGfhfRfgffoC9XiBXIc9mH6CtnBDo5Koi61Oi6GDw6KEfC90Xm8?=
 =?us-ascii?Q?HUKFp6Kmi/DcmXSZGGwq/G5X+tOl3pGF8+ocTBs87EE0akK9dZ1fTxmAWvBr?=
 =?us-ascii?Q?Dva0C7QXLriLq9Oo4nv+LYp4x626VrU9hip69CPrE563ePXKWQLbYOQcAhwp?=
 =?us-ascii?Q?axg3zVm5nMEF3+8bufoxsNnY1yvA34Nky/V5Wj7m7YSDhOdYkP+V0h1bCOHR?=
 =?us-ascii?Q?anQJ5/cKX2e8Hzdp5TB2uH54YNJGVGILVBSnbnwstmTmpKalXWW3RNdiaqDF?=
 =?us-ascii?Q?VXu/MCzvvsRpt8zVRdIDT700UZJpBa8D7JbMkmGjcNK1yQ79iUBw9kEdT0t0?=
 =?us-ascii?Q?wpJjCts6frgZ8feeGCBuWjwjvisWuKbODg7f44eDfPPhmH6qCNdI+wCE4ffv?=
 =?us-ascii?Q?MutI3/ctiiqAhmd4V6VKlL5ZRFApcjP8/vVqod1ebcO5hWTumXWbW3lfwPbj?=
 =?us-ascii?Q?j4WiByC2v3pfQs3SVlfwFKPB34wiAhvKCdh5fgGqYCnl9KIB/4uEwgDi6e1y?=
 =?us-ascii?Q?4s+WIkqiUojnINNDOsXSt5MCMOF5VcEFvrIzrnbaeo9ekV71hOxKNTERbDoU?=
 =?us-ascii?Q?y4vsrZahYlTn63QtMKIbeWQ16DGwfIIOi9Osuf0E?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 532a1c10-938a-49c0-18ef-08dc9682dc13
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 08:26:36.6441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+84E1zsps3xTUve+rddbFJ2+dhT6d0OALHG8/tnHnBezw8WsbcLDu/NssGJc+SCmV5FWf1/kXBu3eDS4UGfbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7432

'IMX93_CLK_END' macro was previously defined in imx93-clock.h to
indicate the number of clocks, but it is not part of the ABI, so
it should be moved to clk driver.

---
Change for v2:
- Use pre-processor define to simplify code.
- link to v1: https://lore.kernel.org/all/20240625175147.94985-1-pengfei.li_1@nxp.com/

Pengfei Li (2):
  clk: imx93: Move IMX93_CLK_END macro to clk driver
  dt-bindings: clock: imx93: Drop IMX93_CLK_END macro definition

 drivers/clk/imx/clk-imx93.c             | 2 ++
 include/dt-bindings/clock/imx93-clock.h | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.34.1


