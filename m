Return-Path: <linux-kernel+bounces-413723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C7B9D1DB3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 02:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D7F71F22674
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 01:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E147713DBA0;
	Tue, 19 Nov 2024 01:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CJ+MFa2L"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2061.outbound.protection.outlook.com [40.107.21.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398EB13C690;
	Tue, 19 Nov 2024 01:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731981520; cv=fail; b=krt50i2REGRr7/ACYHAkRsBjBgm0kTctBo/9DHwWP0qyDpZpiiaQY0mHP7+C8wzjYfycnqp6FzplMbnw3tiX0Z77Ya2sNJPSDC2SR8DvZgrRr1zdP0KLQ7l2sufspqa0IHWbr7tgJp0rDrUJt9h+dnQIfNNOmDibtYxjL79E5oE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731981520; c=relaxed/simple;
	bh=ts17l0f5fTCgM9fWMNkk4fRg79ynFk95bnYonExcHCg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yl14TVjeRx75D7h9zAB6S1+/KLIZR42cTuLbfgzGOdMo9BFz40MHVXKaYdpzgsZBjokQDojqKiRHHTuDIT/f9qPSlPocLdHfxq56fCm/pOx3lJ06di10r/8fjYHhNHAzJ90+auOZzWpSdG02mIHtWOh4HWC50qrNiyBaVVjkfY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CJ+MFa2L; arc=fail smtp.client-ip=40.107.21.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+PcAMjXKWAFq0clQ5fpq1NyvumKiEmVRVwf5u/P8SWLu6YpnKS1opZWEQa7tIV5QObr50vjjSHD6UbRaFOjvbA3NCTXKeCJa7tjVUimbtf51JBxPmWYis/HOoRmDmk+5dZygQkuXG/LoWFY7/jPTQvovz4yr5TUwaq5tL3hBKmziZKMSYgoo5N/4gIxc8TWiv+qKArwfbfjJQ+1ScKpTqh2nx/i+IjQQfrYcqdcmG+3VfQHf/EjDv99cC4MDYRyePkSEsr6O1diwhvbMAQ6gvZ5tPyLnTsYzYbT16es/IUm4KzsIVbR2M3CmlC1jAr2VqBSemFWnIc2HDMcILWucA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwOxG9Cb3/XpIeQrscHtHJtuh14wyC2akJi/ipMiSQg=;
 b=aKB4F2v9FdccYPp7OTb6+Y1SlQaeRX3YtPFydlaaIZXiMN2ufTfqBaCECqkPKVuy51pBz9QpL4B8Mkf3fj/HXYqM2ad3yZrJmarDnAF2AEtLZljrKgGea+D8Fu30uiJmYuohsu/7gM/Ay14ncP8TQMAOTCWR1tBDsYuo1Vh/4CEd7jmCZotAhhrxd695EokUEbx0n+0Y3MvfZAyhiB6h/lKTplOjVbXYa89pRxiTV1+wI7bPt6dP28gK8xA0KVWhyjGUIgR7DcCdB0Z0HBTvi1VGpIvjg4ry10BhkEtUGUAIB2tKmg1VTQJCDQUaZ0jxZrMxkvESC2/MWlrtZyKnoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwOxG9Cb3/XpIeQrscHtHJtuh14wyC2akJi/ipMiSQg=;
 b=CJ+MFa2LMzHqIsuI9/W8Pt8aFh2HSb4HTXy5IYXAOvPqKKIkZAz3Nu9+H6Mn9vyZOa8K/AAdrI98iJcV2BPWIwWjjrWOpo6GkUe5ySn7vTiJX5o39vj8qL1VPgThcmfQV3tUXMXpmz/fZrD62zVC6DjdYrQRIdzrXqaWB0vMzY07oXXta2U/M+ATpAS37QgWpGL3a97YNKjRmEMe/isTvRhJTGgQPcKjFi6LKzFPAH7OvofgOgPUE6BW3+/xMBx0UaRVFNqPL6+u+tcPlG29I8C1lr5tI9AKQPAVIvhc+ezXudo0VF3zhw4ksnVMdXTRkyoK0aqO+PMo1h5XSuspzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by AM8PR04MB7297.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Tue, 19 Nov
 2024 01:58:35 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891%6]) with mapi id 15.20.8158.013; Tue, 19 Nov 2024
 01:58:35 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: abelvesa@kernel.org,
	peng.fan@nxp.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	shengjiu.wang@gmail.com
Cc: linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: clock: imx93: Add SPDIF IPG clk
Date: Tue, 19 Nov 2024 09:58:03 +0800
Message-Id: <20241119015805.3840606-2-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20241119015805.3840606-1-shengjiu.wang@nxp.com>
References: <20241119015805.3840606-1-shengjiu.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::26)
 To AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|AM8PR04MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: 07b78bfe-643e-4334-0ab5-08dd083dad57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1jxc5j3RU60toGocb5OKiHVryFKYGNECB8MXvrrLHVoV0qi0QeFltelgkEbR?=
 =?us-ascii?Q?irDwRv4PUrSiCkCLEhiEwVcqXdxANUBEFLM0Ucn0QhU4TFp5G9ilm88hXNQ1?=
 =?us-ascii?Q?USoUbwxaySYjkuEHAO6fTK+eNG3yY0PYKvoPTr3vr7Tfz8e0si0l5A3AXh3Q?=
 =?us-ascii?Q?8aqTlLk1jJ1pxi2tjCfz2RU1vF2u9o4fAeIcNCHt/NtDULXxvtUwqGzZMQFe?=
 =?us-ascii?Q?HsdprAjYnezo5T4CyyytlpW9kXagfUQxy8wAE8f+VVCyT4+4EJBvV4OLRk8o?=
 =?us-ascii?Q?hEkV2OCeFvJ4mI4RPUEXtRO3sM21bATW311g+U9hyoADaaEikHYHUtXLFybw?=
 =?us-ascii?Q?LI5POdew4e+h3QHCVInpHlKkL0JvIey/WtJ6M9cWBSt5fEO1FexkoeElvJfx?=
 =?us-ascii?Q?LSDpJt0NDV40brQpLrtw1fWBBIyBOVMg07crBbp+iWyq7MqAF4ED8zeyvEvD?=
 =?us-ascii?Q?mTpwU11PiC1InzKk2weCa1a4n42qXvKMLbmNXaM0rEAKqakefJ5OJyAArjKZ?=
 =?us-ascii?Q?Ha0IP+9uFDvpfXWbd/52M4ZE8JsUHa0Jb+1A6aCTgQuoTGN8PSKmbAlpZYT4?=
 =?us-ascii?Q?Q29EiS7/spd7b75O1irzUjjDwQRzeWyktpicZVrTK0aih714VBTp5bvA+jf3?=
 =?us-ascii?Q?fN+GoUmvnWjg8AJfrOfLTaEWa9FEC3GPK9FiVbmtm9wm3sIR3sTzQ1KOXNFl?=
 =?us-ascii?Q?n5Uo0ZnJZyhcscyWmOUwRHJwlJZbUa61OvC5U65569xow//jpJHsftsBsd0a?=
 =?us-ascii?Q?QXCR2sn4ZrajQ1gdzkZfNEMLDVA2lEFShyKPgNQZZXjQWFObbj3/P8gLwypO?=
 =?us-ascii?Q?0znAw2NvHhmFFkNxKTQKG+DTaTT0tZ9KV4VxGbKKUqlEv6reko/TDBLnr7oE?=
 =?us-ascii?Q?gsp+kQAoaqCQ+HpT4az5P/obTHk8lvvtVDaDxQJwlzGkNQDczdQ/9VnkXqY9?=
 =?us-ascii?Q?g3/1w4/vIsiUNkh7CaMZvv52hCuow5e5ZKPoL2vwrWD+o1YmrqBAsPDm/u1j?=
 =?us-ascii?Q?ilv211X2sgI3GXeJok3U9EluVL7ye0mPIGDxoVa8r8hbUzrBy05MBBjkVB8O?=
 =?us-ascii?Q?cX9lIdoVNWtZATMY04BYcu8zN6IKNIhd4L5wxxFU6qhpSI0j4kG01S5ic3RN?=
 =?us-ascii?Q?mbV62HpSNPxD+pQ25GrBmp7OIpI2k/hLqnLMeR999WvyB3yBopUm65srrKxy?=
 =?us-ascii?Q?DQ2ZwdRkJ6KWNDGKPK3oK7GyK89YFx/QV+BiiBtWxTFjzbE+zsVsM0ZUrEZ9?=
 =?us-ascii?Q?EX309MgzFJgTWxZyEq5jXY75WUOZF2y45Lxi8OQPv5EFSdokF8UNkjDZWfU7?=
 =?us-ascii?Q?sW80PsDCYkHXFgqhPox+In8ywLOGCdZ71y1RLHvs7XmFYHlY8L9JdWuD8ZaF?=
 =?us-ascii?Q?k6w3cJqnhMX7bT/Kaza6X3FPFFa+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QI5otxZc4LMiLQ5jRVK289mQkD+gfH82VOGTjS1jOWcScHbQ3oG6FoLB81Bs?=
 =?us-ascii?Q?ugcOC9p3vJIZu+KHG3MFEi9u0wwYB5LyqpcstOY15rvLoWrKxQXnJERDwhNL?=
 =?us-ascii?Q?LIMwTNdisPT4i5cKdPNvJUzMGhw2TW/IgO3cX9bXgRK7VjOIMUYVt/1I4Iby?=
 =?us-ascii?Q?uEDpB+e48tegHbkr4JFaQ6ZjzC91O2XBJD8tb+DEjSHo7wUo0IXDKzqLt4sD?=
 =?us-ascii?Q?21ciZF0hZe8coTlO268HfjHmYwsxBNqnk/OJnZskL3jxR2/mP3iBeoW+NuUO?=
 =?us-ascii?Q?VpZ/pBiWlcrF7zFGgnxplI5anINqBQqMq2VJk8r5yFM9Xt5u7Dokf3S5UQf+?=
 =?us-ascii?Q?FZ0Xg0A4ZX82o55b4xMdj9BO9FTSJ6+L0c2aIc95DL5B/ydQKlOilyid8gYZ?=
 =?us-ascii?Q?kj37lZOKadnLxXZ6MwRrg805944SGaPfyYLzWcvQ1tqwbEXTHzv4fH5IbR/R?=
 =?us-ascii?Q?FYpTI8+GzAAFRUGro8qxbGCNLEhiLse+ax+B1DnijutsfYK9pvqvSP+aawS1?=
 =?us-ascii?Q?dvbWfzWFg+Fzcr0yFwPZ6uR7MceF2txZ2fueMz/KTf6UBAjAB7rYMM4ij1tj?=
 =?us-ascii?Q?UlBkhvhfSSYi4N8BUzZUjxCtEWIsuAGVhcoUVEEfD+K51zo7+UQt6kWzrhP6?=
 =?us-ascii?Q?5jKx76/KuwcMXiyTAM+iIpxs2DaF4w+dMEv3ckFnNp1UjoJB8KPWxVBuW0tl?=
 =?us-ascii?Q?y6ndGNd6HGoekF8S+g227LoizXTPXaPYw/gC8E6g6ib6OTHidyBFCAkLJ2WZ?=
 =?us-ascii?Q?BcbDqNggT8v413VNBG8Javg8FokU99ANpc93E4JyqxK7n4zxkCLk7mN+n08G?=
 =?us-ascii?Q?F1/xpdrlZL0xDG8N7NN8qeBF9Nfy4gfJG7F/zieGrdmFc8mAB+kPEcNP1VYW?=
 =?us-ascii?Q?xQZ+oWyyqbDuugFtkVLjm8Xubnd/H2XICwb77wfwVlD4j18xp//h/Y8HD7vO?=
 =?us-ascii?Q?TjoDJ0Gtfjr/vVtsoRw1hIW6/r9KpLpGxeWn+8pXA++8L6aLUfTBuL18FckJ?=
 =?us-ascii?Q?5h4Yu5+p90qFa8wuku0W2brYbQz/u/StXw9+FTjlv+pDLqqjPMxS/3kz8Skt?=
 =?us-ascii?Q?ykxc7gxfTBdIhra4FY7iuYtV4uhkZXSj5oxtEqoNVVU5q5guIimlyiXsKOKN?=
 =?us-ascii?Q?Gi3VC7Sg8TCNKCIaXpB1jr0IzJy3sHi0aPLKb8B65cbIQwcxIBDUYxVDBUZE?=
 =?us-ascii?Q?/RKagXc2H1hroCH+OnOjdTc5GEnve4KBJW+rknOHbXhcUOgHwplp4QAL46GF?=
 =?us-ascii?Q?m3mZSgSN5nghfRJHljiyzDhqPaacu8oFH/YVhUg3hZzUA3p7bPoS0/Kz/jYN?=
 =?us-ascii?Q?JrnH2HQGNc6ZM0pn/esTqx0h1kanKfu9NA1kwIaQN/whK6hIkpha2bLYv4ad?=
 =?us-ascii?Q?k6qMTjyyZFhuAh4vCh4HybFsBchASPVJJkeU2Bc9ytjD42r/BsOCrHpOXOiW?=
 =?us-ascii?Q?FXBnPf7UpMzBmeqN+QFYfSwWnTDaoUiZLEsmjzO+T3l4Tze68Fjb5WWL4nY5?=
 =?us-ascii?Q?CgsxGmW2yyjsHYjzx+tChXniHdvUg3MSzXzUpqB31NRu1/FSgJJqEN8we46h?=
 =?us-ascii?Q?LDxckmGEv6L124pt1LhYPHxkT2mjXSWNp5t/exog?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b78bfe-643e-4334-0ab5-08dd083dad57
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 01:58:35.4195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y7znP1rRoKvzqJgppwqeatAAKOQGW8DsMf2T/L8+Nz8vfDLDr0BwfouByLF/AeDNxucH0zZX4lc5OW5Ty9qO6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7297

Add SPDIF IPG clk. The SPDIF IPG clock and root clock
share same clock gate.

Fixes: 1c4a4f7362fd ("arm64: dts: imx93: Add audio device nodes")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 include/dt-bindings/clock/imx93-clock.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/imx93-clock.h b/include/dt-bindings/clock/imx93-clock.h
index 6c685067288b..c393fad3a346 100644
--- a/include/dt-bindings/clock/imx93-clock.h
+++ b/include/dt-bindings/clock/imx93-clock.h
@@ -209,5 +209,6 @@
 #define IMX91_CLK_ENET2_REGULAR     204
 #define IMX91_CLK_ENET2_REGULAR_GATE		205
 #define IMX91_CLK_ENET1_QOS_TSN_GATE		206
+#define IMX93_CLK_SPDIF_IPG		207
 
 #endif
-- 
2.34.1


