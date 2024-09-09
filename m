Return-Path: <linux-kernel+bounces-322037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4264C972323
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2100285496
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 20:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCCC1898E2;
	Mon,  9 Sep 2024 20:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V56SBLbd"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011029.outbound.protection.outlook.com [52.101.65.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA9173440
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 20:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725912345; cv=fail; b=OncxV0hCbiEM9avHh74r+kMxRJVD3DpKoAZ8f+F1Gc2JJSlJn6+V8jdSe/VMGSAPEj4di/YLEt9rPN1OPoDAkUXjaOMroHNcIahvVPJuQvipOzrRJ0x88PX9BhBu/ml9VTxDzzzTzI9ATl86UwArvlR6bEBg3jcT/5+5jhGPPM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725912345; c=relaxed/simple;
	bh=w4779O2JSL4XB36/SWfUXrbyO2NmRKaQSGWmZRT5Zlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sFmg5pnVPMl/jkXopXv23Y/wsPFAiXPlR7GcyYkSt3yAChBJOfFGbTKRJyLJAM8mty/9oB9i0IVH+tYs7CJlFyJJZo3L8UxOUI/KdHe6Mu0V+n/JNC3lEDZEwvIPz/casY6D3eeKUK8Nx60uTg0XfdVFtz1POPAn8PIBiMk/YGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V56SBLbd; arc=fail smtp.client-ip=52.101.65.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7jr+9jUwQlFzK82S1qCPyBQYX/dfmjREH/WBOPXazT5/jqXGam5TQNt2SqI8s+/Hv6oOBbrQm/RfCYGVu4J45BfQQDDkWYxCzCujOqLQObUTCS2cV3XCkAR/hcwkhkgg7z1NsUjpfbBjnIAhOm65V0XGYGxU4tCtZF8ZVkwuqjkb6mG2pfFIHUpscTGDviYWDt7GnIKBsS9mDcAa+zlBnOZTdXw7mJoX/P5ca7VvGkgLS44h4DdWEJGLbIvC1tk+ENmaCqEqtDTRYlQtwLXyu8oLlztvqp8coCtZTkgHD1K4KcJLaaU0zzyOoNexv7kqX3euGoUG/yYVy9XTaTGcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=esxWwAM3u6C2+N2BxOlCsQZXZWe7GmXxUKB9MrOBlbk=;
 b=k5Et84BLK54pPWM1NVs5PffZKJMpZVYtiTJ5t1tiZ9guXYn0bm7oeNWvtw3szBrj9ltlJXiC8kx9VKTgEZ9TCfIV58FtUruZ5zx9eqzcZrZ2N+TvvUh69c/Koxt3KP5NVKWkrHtjGpb+V8xcHl+k/mKi2VaGiT2VrJarBmAJOo6S8b9wVaJr/CAMK8r3hsAvTLt2n8wKkqKZfhUz9/wUrXy3JshMiuJMnvNwJMMxcGJT6Rfxt9rg2UKnykrY4cQHZUEWWbRpI41nGy++F6eHMmyWrMbwiezoS73N6hAZ5r0TJrPadjwXNhwWpxHkN9LzbEzHOvQ+kHbkhChPzn9New==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=esxWwAM3u6C2+N2BxOlCsQZXZWe7GmXxUKB9MrOBlbk=;
 b=V56SBLbdyCt3m0SG6/49vaA63XJFfncQWVKjPYwIq3zctI83hhz99ETJbHhJR7r0VKzjq6fM40LSQjW0ZAXu8drAmzGINZUbv+rREqKsvbZCyzQp7p8By9NoxIDJ8c1s9dee3yCAuC8T2ZdNUbYCzYFNsC3qOf+4JFtZdaxWLjQZQDhk3InAqZE4IuW1H5RSI1Qm6IAT8STJYm1wc6GxSe7Fdok3eF5rNolaPyBE1sKm2lY+3upbJjzynIMp0RDDZ6tGhBE+VuAVyFbNfo6imkWIG78QOZ8EBm2LHJ/P48lA736JmTHOOqFNXXTLPOUY33ovCKh1retVB13STjKNVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8572.eurprd04.prod.outlook.com (2603:10a6:20b:437::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Mon, 9 Sep
 2024 20:05:40 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 20:05:40 +0000
Date: Mon, 9 Sep 2024 16:05:32 -0400
From: Frank Li <Frank.li@nxp.com>
To: alexandre.belloni@bootlin.com, miquel.raynal@bootlin.com
Cc: arnd@arndb.de, bbrezillon@kernel.org, boris.brezillon@collabora.com,
	conor.culhane@silvaco.com, gregkh@linuxfoundation.org,
	imx@lists.linux.dev, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com,
	pthombar@cadence.com
Subject: Re: [PATCH v2 1/1] MAINTAINERS: I3C: Add Frank Li as nxp I3C
 controller driver maintainer
Message-ID: <Zt9VDJ546znNR7AT@lizhi-Precision-Tower-5810>
References: <20240815141609.4089406-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815141609.4089406-1-Frank.Li@nxp.com>
X-ClientProxiedBy: BY3PR10CA0026.namprd10.prod.outlook.com
 (2603:10b6:a03:255::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: 59876a12-056e-45df-9ea8-08dcd10ac74f
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?4sRbWC5eT6BCZO0lrm4Frl+i8FdzoQB3cXVZK49pe81JA9a6/b2bWdq46CsQ?=
 =?us-ascii?Q?LsaD6L600kuVrV5/IM2G4euRKsoifVNPvMnvkWpeFAk3Az2jCUeHRtQUU3kS?=
 =?us-ascii?Q?hTSBge5/8w4AeIIYIRTwnMtfqNmi0c3Z6KR/TXi9GAY1uq9vFVNksKeqfDHT?=
 =?us-ascii?Q?UNl5Nf/uKlkpkq0YJ2SbM9vvQ3n/IvYqiRBj3wdlfgyAn4dQw+GB1LKVNFgw?=
 =?us-ascii?Q?WJOt6XrZM8luhefm6dNJBTh/O3EwrJEOWEAA00EaAf5zyWtnrksxRAQNiorB?=
 =?us-ascii?Q?Yq268RHitDZiUr8OrHMetqjphwBu0nIbSIwp437gXetd8PpOcuqrGSuJyarE?=
 =?us-ascii?Q?6gHIesGIFDMVTkM7JWvg++WbxPVvh5fho8pS8ungAbR+zxdNbiJ/UAL/lapn?=
 =?us-ascii?Q?gWZiNCkrWtUKtfvVQXY9gkdQmt7q6OxWzT5MkKehT6Lw6H52ehF9IP3bOE1B?=
 =?us-ascii?Q?kZXOZGbsVTxbMVTUss58XchkEDKupU20751SwwjTnRDuFiZbFmU/9FKGWrCS?=
 =?us-ascii?Q?7eDjX8r8uHLqgHT4o6o/0W+wTfjddscR1qWmG4KktrbzYpVM2oahyat7liRY?=
 =?us-ascii?Q?aSspyXdzHxpy/qVzyOvNyL2TskT4TuW52coLrXgGMXaQ9jQWQx3mvGZcP21w?=
 =?us-ascii?Q?Y/dLquPAg/FpvsDUlTmISrx7cEmPtKJH4ObXr1Vq4LIbhJnZt2rdOSJNF847?=
 =?us-ascii?Q?SLjCBKi1gFzBJCqiPjMvtxb57ERNk/mo83oARpxdCc6YtIMOn3jmXq+VXgie?=
 =?us-ascii?Q?6kJH5EXGJzOIqS/kAIqBy2ihOtfTgFm1S0kfZUdgbQORaFLx/JEZTx+v0jo5?=
 =?us-ascii?Q?c/8qRt8/+GACVTq/y26V8ilPI6mUeergsjEqhHeWTeJVKEZru3Wg5fBzybum?=
 =?us-ascii?Q?Zfp942k0VDhJkyzCKYb+qnKlAl4wIEVl8olsL5xLbnSnMZ/2Zx+EoYL3Adqf?=
 =?us-ascii?Q?PcdwxkdZ+pfeGTO4kD4r6HgSH3VWvqNN8y5bgGO9QwHjwqCwzDzwKGKTcvh3?=
 =?us-ascii?Q?Vcz1BR9YrcD7kvTI44ZGcwHYUxgmvYzROEBigJty0FY+dw0sEscs/SLIiUAJ?=
 =?us-ascii?Q?1W8nGUw8QKSNi+PVwwf5lpr2I3V+/X2GqmWyzYQS1JNdPSEeKQ5RoVNNOW7+?=
 =?us-ascii?Q?WxbI3l6V41ughWhJLhve2GCb/f4v99JdtqD3qgZk42FXp7kC/PXAhAeLCQIE?=
 =?us-ascii?Q?83MIRqM5k8ACAJI5JY3rlJTXmdt/vn5GkOA5bu5xmA3n6fdhyxnC6+ATRrKd?=
 =?us-ascii?Q?JXXgXkkHHqPNTnyrAZ3OtSAlDcu9mxMgbqmGNU7YMbkDttDupXGo4DsqpS1r?=
 =?us-ascii?Q?9dRw81sMHOIRScCWsHJ73QEEFqxUfv0kJJYerl3EiZ3PU2RxEfIg1UXg7FGs?=
 =?us-ascii?Q?Bxs5ituWbPHGp6lYOAqWtdBnAin2XutD4F+ZswPpQP329/vTUA=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?JW8DcnceCvVGT5ymMIsLTqIc0S1N8A4oNTJvb2Tab5qtb+8A8R3DFqACNvLu?=
 =?us-ascii?Q?uaOD5jbmlcSPtz//thmS8/lAQmtPfFe3GPjv2mg885R5FI0CFsBDTV0ToIrQ?=
 =?us-ascii?Q?omAH46dJJWjyoFGhNLDZsrsjIyWjpYf74fEaAkRkDu6YrloKOGi3X1lNfiJo?=
 =?us-ascii?Q?c2EclvewzF6rp8WZlJVUrr3FpEgx8egWmxDFAPuffWkEhFGsj/4/+LRuZy0s?=
 =?us-ascii?Q?moMYCzg9EczpLAWq66YA5nE1QplHph4YBSINoAuD9cWEM7zmNu2dPvN9PWUL?=
 =?us-ascii?Q?X6jvl6GglWWaZPVf9khJExyr4HIdeq7qewMEVpFzslwO9ACJX6NBWWJKRkvx?=
 =?us-ascii?Q?F9XFrm6JaA76SjO2xc+d+4DHePQ8lmf23cL4MqLF2Kk9jDjtqB9cmZPrP330?=
 =?us-ascii?Q?mJeXsNbH5K2jyAQVPCJbOSTxs1EqHnhGlAeVwdQhw0UtaGhgS1DEfMGcC3MF?=
 =?us-ascii?Q?pERbfhr4FmDMpIRuRvbV+2ruJZqIDviAAmyRhMVeqmnP+jf5efO6mLe83XLf?=
 =?us-ascii?Q?LXzt7DgyxNbig9bV2QWBzj7JUStUz9SGOyLCdIY+AIJaPnxYCDejTg7qyJ2I?=
 =?us-ascii?Q?c0d6sgMwZH6TxzBr/GC2kfVBASOpqF6o+mldKE98e0Nq/KHUhpg78UJojNTm?=
 =?us-ascii?Q?F+SOYFDAQSf9GMTDsorO641q6C/8SJMRatUZbdPSmKUv+k+vmJbcBzkjw05J?=
 =?us-ascii?Q?fy3qoNId7VU/zEhmQobAoy2eaXCdNOeuKbRs6XBhKstF9Q/GcB4KRzpAUDCu?=
 =?us-ascii?Q?U4Wt2c3eL7WbiHqNBuubeL4NoCjb8QMUEY8+E3VCa9tbpmFLfEXOex/ekpJl?=
 =?us-ascii?Q?n3PbMVQ5mVImtt1yYWjpM9XtWR8HIyLompRYMHHNgoWRfp8aUU/YZLBu9eyq?=
 =?us-ascii?Q?brsNV0tVIfk4B5ro+N8DSS1upKSlyTb8hTMLiJRsHId1h5m4x2rf6VCEj+9X?=
 =?us-ascii?Q?lQDNA3Jhz6NYh+23LoOtlzwSDsAK8f7CqhNQgmf22M960MzaoKd842gTDD3h?=
 =?us-ascii?Q?h33Qz5AbOnmT8RvL0KMga8XZMl0GNO/0KOUd4/9CuEbFkPPzXSDxnzp9bqvO?=
 =?us-ascii?Q?PENBVx8eyZMGD9gqK95pshK75dYsv7yXwUtHzrZ6b10LooaG0s5eDYPbIU4/?=
 =?us-ascii?Q?3lpnjG2JWaiEOUiVve4Q7Aib+4Z2KTw0k6tEEhRE8hEVINNiBESXKqlMVmOa?=
 =?us-ascii?Q?DBabVbR5iphSaSJ5mZuyL6DYyx8U3bVQVjHNA2LXT+T1AM+SpHXsKx0rR6+v?=
 =?us-ascii?Q?YnnmcmmByss6Y/AJ4ZMJDQvVhGqgLPntnTAhRkwFToWFYwP93fkdu5xcMuAv?=
 =?us-ascii?Q?zCFBfu3DeiQf7/W/bf716BMNlIR98q54KzQOQ8/kJAopSVUTHealJGemEqIr?=
 =?us-ascii?Q?3MaHZnHneGJt3BGf2rJEHRo9lXoJoW00G8698L+ntJqwqNGZyi2LPXzBB2m6?=
 =?us-ascii?Q?CBFVLc/eTVe2aCoDBmJa8gV8KMj8fj5U+OHZc3Lf5MV/+cUOnvmL4f5d/1p5?=
 =?us-ascii?Q?A8C29Rsb266td1gRDvVkObi9vz1sG9RM7tXrzgrCab1Gn4opBM8eOwcN72tz?=
 =?us-ascii?Q?A98rLQSRyrpD4T+qo1o=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59876a12-056e-45df-9ea8-08dcd10ac74f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 20:05:40.5232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 10Rq++1WEcP3a2flzRAOvVLbFaDRZhpVHQfjriVVAh9Ld4LHfmGChUglmMdUSRBRjOUyM+kzSVsds5FF5D3Xpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8572

On Thu, Aug 15, 2024 at 10:16:09AM -0400, Frank Li wrote:
> Add Frank Li as NXP i3c controller driver as maintainer and add mail list
> imx@lists.linux.dev for it.
>
> Add Frank Li as I3C subsystem reviewer.
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

Miquel:
	Any comments?

Frank

> Change from v1 to v2
> - Added to exist item
>
> Recently, I submit many i3c related patches and become familiar with i3c
> protocol. So add me as svc-i3c-master.c maintainer.
>
> I reviewed other i3c patches. So add me as i3c subsystem reviewer.
> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2b96899a78890..077e37eb018ce 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10708,6 +10708,7 @@ F:	drivers/i3c/master/dw*
>
>  I3C SUBSYSTEM
>  M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
> +R:	Frank Li <Frank.Li@nxp.com>
>  L:	linux-i3c@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  C:	irc://chat.freenode.net/linux-i3c
> @@ -20961,8 +20962,10 @@ F:	drivers/video/fbdev/sm712*
>
>  SILVACO I3C DUAL-ROLE MASTER
>  M:	Miquel Raynal <miquel.raynal@bootlin.com>
> +M:	Frank Li <Frank.Li@nxp.com>
>  M:	Conor Culhane <conor.culhane@silvaco.com>
>  L:	linux-i3c@lists.infradead.org (moderated for non-subscribers)
> +L:	imx@lists.linux.dev
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
>  F:	drivers/i3c/master/svc-i3c-master.c
> --
> 2.34.1
>

