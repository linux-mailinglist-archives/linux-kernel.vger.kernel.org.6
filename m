Return-Path: <linux-kernel+bounces-363088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0387699BDBD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 04:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77C631F21BC2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 02:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E67E84A2F;
	Mon, 14 Oct 2024 02:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="K8gSqAjf"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E9675809;
	Mon, 14 Oct 2024 02:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728872634; cv=fail; b=r9mHK/oWCB4xtCb34Tw1yFfora6Jekz5+6fbSdgqlT9HBPtLU0cFQq8OjQjBoM4+3GpDPWQJwU7kPAFBpOeq1uohBp6//c2BUh0ZRoVtdn1iD12eWn52x0IS/Vuhb8g7RSBc8LXlH14hGDhD126vs97zjBT8aS3RzHUrZSkVwns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728872634; c=relaxed/simple;
	bh=gQT5Ex8gffizdxeEwhJIjboK1q1LfeHy4PmbLwgo/pA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KABvw3/U0Tp/vbb67wwJGWLh6SORmwhAY2HwV+SSn7EWE9/9/fSjBnT6gkprb/MTJ1OHfLZHkHTM/kVRg50GPp8CRVSoBLLgFKLxxlJxisPATujoeK8zMG+1PzSkCRtbKQX8fqxVVHG4yoewiI0lmDk41C+SAWOFBjcOuFL8q4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=K8gSqAjf; arc=fail smtp.client-ip=40.107.20.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WrSNFrOV62Xe8ZM9oD+YY866LnhtAA2OLcC2BlOH0J5nr/G4AezaPvGUXW502p+Y3SSSSTvzVuQQ5clsp3u9atlnZorIrGNislC3FgFTlKk8vscdf4EvU803Y5RhB66rlghxNV1/ZXmiOierYg0K+1gYJjJnjX+S7EWfTge+TGi/PhXFDP6/YB6P95CT7xJXtyK4xudDKnGAvxgVFpDS20iGwQ2ZlYbNucm4nz46TxSvrv73HwO6paohcaKnwvQhxzRj0YnLR4bbRO/riJm/0FuJbrbWpEw+EFrFoaj0du9ek/A1bWrboqvwDqEFnjj36O49egF68j9Pol5hXTZUSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QZH2YX3rWAv4l6hHsJW4LfTksut3YCn6Qp65bhVg3s=;
 b=BClPr7mC+CiIkysKr6g9KkpIkR6YAOHLLlROxOzALVBAga9TOY0rwAlJnmdNkWUk8L+1cB2ia+4nelMtIE9ocMpmxkduNnsp2w0PUZhs/+hcSWI4OWgdhr8hTgfQAwj5VtFZXxVtjWbWXKZFNM4zbCDmdDy6DNkuCFYO4dI9JqpNlaDevpoH7X/HGBrkRkSpFlT270HIF/H0dB2PYbSXuZgA/Zr9WXx6bsWsvBmYNhbf4d3xHmOELZkNmdQSoHsZ3p8NUqTue5VEHpTiuCyEKckPalMDKTgCdNo9AA4rKIQVaak8zIH68/spPyfdTxChrlTVmSR8jUJPGvgCg9/t+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QZH2YX3rWAv4l6hHsJW4LfTksut3YCn6Qp65bhVg3s=;
 b=K8gSqAjfoKGrX4hpHgHtKbsEKRhBxsSR9cPeJooZJl/6tBxrJHr0pQp7BXx3tIdABc8libG9jKg5Iu3Dkh9r05u/ZawPFyyLIBPDg5C882VyIrop6Nkd/Q76uHVMUeVR/0u8OZXzIVsa1P/XrmrRh0m+9SAsLkuDWRFX3j+X5fSFgMRRrqcbRo4fzUkdCf7pidyx1j4QThQuX5K6SzoZGI5oe/gFoKPd6BswMAHMfHu3+DO1rDLb4rclBRE26Om3ZKQXhHaqPKgQp6JG9VDY9txEnIdTm8M3pi8igEnhtykUhNaoC4VKHNHA8N4YOFiRafLujjJXr+9NtoYhyhxnPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by DB9PR04MB9378.eurprd04.prod.outlook.com (2603:10a6:10:36a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24; Mon, 14 Oct
 2024 02:23:50 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%6]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 02:23:50 +0000
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
Subject: [PATCH v4 2/4] dt-bindings: clock: imx93: Drop IMX93_CLK_END macro definition
Date: Mon, 14 Oct 2024 11:24:36 -0700
Message-Id: <20241014182438.732444-3-pengfei.li_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014182438.732444-1-pengfei.li_1@nxp.com>
References: <20241014182438.732444-1-pengfei.li_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:196::6) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|DB9PR04MB9378:EE_
X-MS-Office365-Filtering-Correlation-Id: 0010ee5c-5ab3-4bd8-aebe-08dcebf73da5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AJfFdEgu5AQ5o1GDqihTfyr6gC4vaAOhbUymrrHN9p9Lk5pYTVPA4SgIiZop?=
 =?us-ascii?Q?Ff+0mxg8XgcjNydBKntCLYq+eJMy/KXv+zQlBAbrdqHGBC2cOCBuVB1Y5Qdd?=
 =?us-ascii?Q?M7CsohPGv2A+PO7AVsmBUDPh2CkRw+bjkvruayOOu1ySyBHG3CkAbBeZ00w1?=
 =?us-ascii?Q?rjCFjxwf+MgP1vGmn0KoYmMewAfgccPnMYJ0bBBcfP+eoaIHmgkwXKGpwWj/?=
 =?us-ascii?Q?BTjPio1Pab761FvLgD7W6QzAIoBbTDJR8ssLyLzLR4Oi0cqYILtPXmomIHQu?=
 =?us-ascii?Q?da7uxMSZpQ3nVLMzwfKKtas8zWkUmwWgOxXODXwUxcPNETosyhNPTLAHeVxl?=
 =?us-ascii?Q?WaWbznVZQBNZ9Bi7mlSS97YN/jbB9skWxOFTFUZdZMZDfFuyTw6Aj2WsX0FM?=
 =?us-ascii?Q?bkEvRH7zwwfCNfm8vKsigAlgdhX32fX6PdM8DIwjefburEwA8a76dIIQnCB1?=
 =?us-ascii?Q?adsRZdLZ56ZNogT0ZX62HeExEyHUkReKP+pC1sklY+X9xv8nbWEGDsASy+ic?=
 =?us-ascii?Q?WlmbsNxFiO6lGcpNTKhqUXSjqqz2jZ1Kt5jKFcr6QoM3NEEbZ+46yA4zlQx5?=
 =?us-ascii?Q?VCE3LtsLZSj1Z79tBqj8rc356BddxHAZUbJhCUdkCiI+amVyrYU5IsNNEddC?=
 =?us-ascii?Q?ifEvniaqUNxGHzaV6gWNz1j67cWBAURnoFgIFcxJC6LMVo06aLjIJ+81oNw9?=
 =?us-ascii?Q?U6gLdZUscHVvvSJDR+0Tqk4l3WbIEDx7lZHE8K8ESuofhQmx64h49m0v6xPv?=
 =?us-ascii?Q?R3rbqZjHOm6Z2tTp6aeSrKmR/gxIqsTixod0fVFa/c2+KOOLmY42qqSOhG5Y?=
 =?us-ascii?Q?vnMbtWc00KuOxvPgbcLjO9odl7jVMjq0jzMePoq/cySzkeQyItHdypoQ1eWK?=
 =?us-ascii?Q?Cc8eLbfiUXTbZhuu+1qLwaDjKvfKE4R39l+yx4jaa0gfAFOBZh5sCAfz3wL0?=
 =?us-ascii?Q?QDXl3Ox2erJmXYTBOE4Z22V8IqTN2hPPT3J/RE2+enqe8utFgf4h8oKckw0m?=
 =?us-ascii?Q?DpwqLC26MtLhlJ0zZT+WAlHZ3jiU2GG4+OFHcH1qGk5NbuHjng4JlUlnigqJ?=
 =?us-ascii?Q?tSmpNo+peJ4LTtD/KIAF/rPDRR3+ZW6IiYicNxi0Bk75vgdAzhmh7U2QJcLS?=
 =?us-ascii?Q?HFz4xstsdj6CJWMS3eAt58or05CoakKlxx2zs19JQmsAsLaOP+PZv1uc9Lf5?=
 =?us-ascii?Q?2SSUA4cDwbPH/5HSuHbq7ZcbtF0V60TwhUsKHZo+vz45sB1Z9d5MKsxzjfy+?=
 =?us-ascii?Q?Ko+wtqipf+I7R+8wb+MVSVC18Q0CfaqCCwSaf9/9Qu5vHOSczXNB7OANXjZm?=
 =?us-ascii?Q?VFsR+lPTSZvIVS/llK+2U/ysrwZWnTfNTO8FaKHQe+xrs5TPhOQTUha0boYu?=
 =?us-ascii?Q?9eBP4mU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yHu9sHHWhxtWhem4YXcVi7lykeQR3V82jZVuQej412gHI6UuuOOgycmbp1c9?=
 =?us-ascii?Q?ufyKC0GsaF4ZDqe6relbnuFYWDU8jI0quVuyp49myl9k7un7wqajIcDu8odr?=
 =?us-ascii?Q?cJGyzKZKmoiidTbu8C6xGREkqjgiFx1ValnwPDMeG9ot78xKrBaqRhiunNKe?=
 =?us-ascii?Q?6PU4b/IroVxn0B07efssHwb6ab+laHHxpehOVG+7XMiB6p0ED94BAAhEHJvP?=
 =?us-ascii?Q?cC69eomSAR4B2aqYxGDdsol1Kq+K0giJ5S2FWGioNTVe++5oaalYf1gRwOAU?=
 =?us-ascii?Q?gD9r3qeMdchmYnx989jYNZXYMTYQxGy7WHeOxCKId/dYv/2+5tGV0Zy72GA7?=
 =?us-ascii?Q?lF6VVRyDo7SsPOiZ7+1ygLFUU2ERw2Uda74KeXeyryL6ovZKd81suWs0P0dT?=
 =?us-ascii?Q?tJqx/9z53HfIaTgBQV5JGoOXaoQ3zRQBCkWdht9pKcj9E4EeNM0SqvLn0aQ3?=
 =?us-ascii?Q?g1TtFBgz204fiZcYg3C815CIQhFoDRDOP02XgnO8TEhHXAefhvUaQ50M2Fcm?=
 =?us-ascii?Q?luv09nc1IIw1HHy8p/u/IkIg787iBBvs1LPAHhvT9y2636O68dV7+y1fdPgk?=
 =?us-ascii?Q?VGPMAwuz1W7DveMQhgHs8DaWxkNiPzYPNKAHKXPQWdZ4gWI4s9QmEjsBlD6Z?=
 =?us-ascii?Q?IPtwr4cb7TMt5yFFycxJsGjvbcNh5Dt5bkwMgjqgp7GZo2NpgMyDRpoVK5ES?=
 =?us-ascii?Q?UIbkUmFg4C4W+pwxmqiTPaP0UFaG5Ar1veGXB1JOq1MBVyCypXRwHTdyJNnw?=
 =?us-ascii?Q?sX+tQVjWaCD+Zpy+Z9DDkXqM0ZP2EW+K3kLRZ6HrSQptB7PktvAu6XTIP8H3?=
 =?us-ascii?Q?aaAs48PGzFfgfxqvv2y0GiQfo3POVDON7Q0mXmQSjEywrUsO+xPBhDijKdJy?=
 =?us-ascii?Q?P9xzk0Be69yzcsdPwdyEc7j7Kd3OYul1UbK+u/NfT6lnJUE8z12l7va3UNE3?=
 =?us-ascii?Q?QiDFn8nImiFGqLsJTZ5ZuJEAu3mB5MPOzT1wZsnGa3qdh7T5NKOHdGd0xv47?=
 =?us-ascii?Q?4zhu1IhYQ6GwaTdZljBf6oX/INh2ATng9i6gH3GdF8AGhUTcYc7Ipjmz6h9P?=
 =?us-ascii?Q?q7sF/oo+phQitBHHqAaJwHYgjytnBUaQXxYbB3Ws84iVD693c9WnbPda/tAq?=
 =?us-ascii?Q?Uf7jAD7hFg+OBpa4SJdcZeDq3p0GEz7oZKYro27QhodCJCEZaMnAuZwWvG/d?=
 =?us-ascii?Q?f5Y/ND0A+YLnIKkl+Ncr18PWtHmEYPoXrh2wM4QXA3NlNHJwgJb95WXsehv8?=
 =?us-ascii?Q?hoJ1hv4Z77cucqJnQvjZGZFnxBFayw3HYBdCQZvDKtnI5d/1a7a0JmqSuSVK?=
 =?us-ascii?Q?CKRWXcO6+AfHDA7Ox9T5dy5YgN9jaEsMmd1v2lrRz5zwgPVcieYUWuHSaqSO?=
 =?us-ascii?Q?JG2KLbWQ24rrHLKFm+kZIpifeUsMiG8b0j1mdhxIMzXBLse1qAlEJLXTeAZK?=
 =?us-ascii?Q?CWc2DjPJ+n8m3qghxQQ9otmPtYyOTMCeM+zxf73wuFv2oCyRwZVPdpQWRJtA?=
 =?us-ascii?Q?aoyNHBoJADJfthd4g4iY30OtNuVVrNZAplDx3cr88JFAZ9+K0tQIySLFe/a2?=
 =?us-ascii?Q?cxpJArw4RtNGONH6K/Fnfit4JQ7EEq7Nluvtsyia?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0010ee5c-5ab3-4bd8-aebe-08dcebf73da5
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 02:23:50.7196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xCB0ZVNLGbGkc6fj+xVbwCzuv+RfFzLipVEMUC9euJQv5mD+7vqZko/CcrlBogJLh36Dc0uA/kjrHx0YSmrQjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9378

IMX93_CLK_END should be dropped as it is not part of the ABI.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
---
 include/dt-bindings/clock/imx93-clock.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/dt-bindings/clock/imx93-clock.h b/include/dt-bindings/clock/imx93-clock.h
index 787c9e74dc96..a1d0b326bb6b 100644
--- a/include/dt-bindings/clock/imx93-clock.h
+++ b/include/dt-bindings/clock/imx93-clock.h
@@ -204,6 +204,5 @@
 #define IMX93_CLK_A55_SEL		199
 #define IMX93_CLK_A55_CORE		200
 #define IMX93_CLK_PDM_IPG		201
-#define IMX93_CLK_END			202
 
 #endif
-- 
2.34.1


