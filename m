Return-Path: <linux-kernel+bounces-560915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32679A60AF2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB009189AC02
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B065519C54A;
	Fri, 14 Mar 2025 08:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Kyt1n/sJ"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBAB2AD25;
	Fri, 14 Mar 2025 08:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741940032; cv=fail; b=KouXiGkdKwn/ATDJuwmCQw9GH8FoL4j7NsTDCrzz9141avyGl48RYSirfsu5Ggig2+jEMGGOT4B12KiLIf00wUWjV3FFXv8pNMkqKgAMn0Yfe7vHJdiCKzKerJHR2Cxiga2ZWz4a0t0H/yMOEf4Czi7n0oW0/xbmpZqWSudJzak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741940032; c=relaxed/simple;
	bh=yqGH3UI0iS4969Rz5p75QFtiVhLL+7aiN3pA7ChIUo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aIE9Tg/s8G47x4BlNgffnAWgLiXQQBBhkjsto5D0dvWM1RhQhtzw22Ly3BkDXIGM6peUUM5PCx696ho4tbTwBZRRTK6JuC/6/GLepBxiGcFD5ffzcOHEWKyubqMe30kkiBKKWUdfzPKRoVNg4s45PBW0rb8//lq0NWpaYiITIh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Kyt1n/sJ; arc=fail smtp.client-ip=40.107.20.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ASH9FUKwHcmG5ikUU5s+LrTlnV48RyoHYFDQSsVkJxmIBoR+zHEz+OKMYTeSJw9C+aV5NTwBUuvUay7vABjNtMkYpUaQaGuGeqfbPdqyKp+N00lZ8KHzPXqvwGY9CFo/Sq5tbZmYIaruIl97NE/8pr+ojl0k3AiQda3ppf6VRZzlcWVoXyhysnuFvVnEV8XL8BgM4l/lM6h8nJLWGk/NrC/oVTWqZAE6pBNkZag49xE2zXeLL3pvanFd6TabuxPWnr5UAbCSM/Boj+D0u0c74gNpOlLi4n+PGs1uOuoyjmVOmNv1domT+drLgNkcPy5hwL6dDvJQfa2Uy8+VPqRM/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqGH3UI0iS4969Rz5p75QFtiVhLL+7aiN3pA7ChIUo0=;
 b=WDYEv9QjnUQvjd8Shg/IcdEC0yZuI+xgPQJ4xuTqtLZKZXWpkZAxkBN0UM87BHFteajd/8WSK2icdET9DP3fm6gDSrUZi8LyNDwRCzT5GIdvRp1Tl0uiNVSX7buHdbG0p/MTfjkC8QK/p5sQG4vVoBwNkpey8+XaOhhCjA5KlUJizFvy7Rf0E+QLoz5gD9hzPSiJFJWzkNtZjryzV3zvCmbEbbRIgwEP44ItDQZOB1JND+E9mx9HSXuC5d0Q9ZZQNt0N31RFWzm2DAoUf4PdKADVlm9nWCuFiI2ZZKvFDj80csFoxlQDYtmQON81IWk7z68LNL2rW6Mykng6LD1Evw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqGH3UI0iS4969Rz5p75QFtiVhLL+7aiN3pA7ChIUo0=;
 b=Kyt1n/sJrpLEYYNjyCp+vWjmO/E2mGxuzPcAVgmH/aw4UabfrohjGeWGatWwBSCG6mIJlRqCkfvfiz+s4e1xPKLcbRXWeiHsK6/heDrQpSzhN+t8lgDnXMfPC0WgFBfih3bfCubl7AvbkS+F/pzCJOjm50tMCwJYF/YWdUq7JmPLih5FcP/Zf/Golymecxo09QxqKNqSRTo19WsfOXWCwwT+EJoyrPPSZXfEPeSHLXAMEBN6E/d7Cav2N4dDFVsghRVr55ohpcmHVNnaONgn6hiiu1s5rcqNSSC4bvW4nTSDqyYM8esclV5NfNA0XYfsF22NOE9EdmTv5yPkdxrkRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10193.eurprd04.prod.outlook.com (2603:10a6:150:1a4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 08:13:47 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8534.025; Fri, 14 Mar 2025
 08:13:47 +0000
Date: Fri, 14 Mar 2025 17:21:29 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
	Peng Fan <peng.fan@nxp.com>, Abel Vesa <abelvesa@kernel.org>,
	linux-amarula@amarulasolutions.com,
	Fabio Estevam <festevam@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v10 14/18] clk: imx8mp: rename ccm_base to base
Message-ID: <20250314092129.GC12210@nxa18884-linux>
References: <20250306112959.242131-1-dario.binacchi@amarulasolutions.com>
 <20250306112959.242131-15-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306112959.242131-15-dario.binacchi@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:4:186::11) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB10193:EE_
X-MS-Office365-Filtering-Correlation-Id: bb5fd1a4-ca82-4a3a-4d6d-08dd62d024fd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|366016|376014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QB3JmticT1EUyah9y9As/LzZtHOXbPCQoRS3HvVkZkAYcCBYJL5RdnpGUwj0?=
 =?us-ascii?Q?7FH9T6J/m7G/uq0ZeQE4oOrmIb6mqAK9UffaUxw0l229RnmoDwWM5FP60Ycq?=
 =?us-ascii?Q?wmeyiU4qz8Ruxu/nZ+hNMT8l2DCl8IDYUxhZlIhxuP0aWGgwOaepWCLbNPDZ?=
 =?us-ascii?Q?Ia3Jbnn4O+5KV6T9tL0NwXTzJlxZw46o6Oycmqh9j1Gxn7pEXSo1R0cA+FeV?=
 =?us-ascii?Q?BEKIis/xFUO+cjtavGiquRdLzsFJhDjB3ocLrUcq1GfBlOvqxPrIyGyrxksK?=
 =?us-ascii?Q?TmKFBzPTXrntpM3UoWHrFseuElbMx9RipNap6cbqrwlwJUkSp/M9CfGTycj2?=
 =?us-ascii?Q?DEcUXhMRLIZ08EyFoJdQSZ4hY6hDvXzSlBgamKALSb4zqsOU/L9vtVVT7Uwf?=
 =?us-ascii?Q?ZM7iMtxJIWwMFeEswd7vm2bJrC0+6zHwli3EwcBcurW1jOlsVTFiSlvUpDRS?=
 =?us-ascii?Q?TyGO53honaQhsBK+3L54dy7jJf8pNfHblu4/s2JKAOdXryZg2saM9iR/gM69?=
 =?us-ascii?Q?6vkSmThC8fY+xj8zz16dg8T6MMFdfcj3E4nut0qphwUFpef6Rh7X6kY0CdEx?=
 =?us-ascii?Q?9YMaNUKiiHjysmPFXTMbEhb9We7jgr8d8GDjBz0mFOp6ODouqz8VualwutvY?=
 =?us-ascii?Q?iX2Xfr81PtkiZGJHETOY5lAE1PDLH5+3SuQ8JIKZxQaMfzsy/ESOAPiKGyc+?=
 =?us-ascii?Q?g1/l7uFJEFto/g+VatkAXoqug2fj6B7enaPu5QxLtknyyw7IpFvDoFpM9Gvz?=
 =?us-ascii?Q?k8hm+c7OCqW5WGA3XUdn0NvMj7sL+cEWnc2rj/eKtqGZD3pf0fEJ00n9jek6?=
 =?us-ascii?Q?1LClGDfrEQmFFqtuXZqPpfVzIBx1LIN8J2ClgpnQLD6S6/t4Up6UmJski1LB?=
 =?us-ascii?Q?sENW7fNPRUjZgyLtzRCZt6/SSzYFyoiuoZPb/Dj541uOnwADCb+hvUDYmS7B?=
 =?us-ascii?Q?7Xd/drkfj/cxntp14ZbG/ai7BVaGCxxdxT91UozEZab805yn/S/VWIz/ia5/?=
 =?us-ascii?Q?WzIb7bUKdCyJTsnEDUflOY8lddi3rv37iSDpYDAIr4zAn/XP0WAjDarX0r1I?=
 =?us-ascii?Q?jUbRfDuDh31HZskc9CCBfIWx3VGMW6RLwuQzs23l1Ls7TW0sOAMGyCPEccWq?=
 =?us-ascii?Q?Tw1rIWoxo/fftF4vQ/Sj2i4pKlJLA8/lv2hGtP+eaBcqUQTV/KDy6bAXR7hV?=
 =?us-ascii?Q?yJzc8QzxUNy50sXISoLqeaCeKSAdigs8v4LDlaBOJMkXUCTEu6TSDPHfAjGp?=
 =?us-ascii?Q?b7ncPYMceGuTNUkx9rGJcyeAARyClUeDP0Vlm26l1GDoXIwdDiqCt+P2Y7qi?=
 =?us-ascii?Q?kdCejjqQskVsBEA1IKappd+PZtErR9laQ70iZS37ohVUmtSe+mIoUi5TBe04?=
 =?us-ascii?Q?ndkih7bebbcJ0I3rEsnVd7kn3BI/SDkMe1dcE7u7hqgWLxQ6Bie++Cd1kx8G?=
 =?us-ascii?Q?HvBJlqo/rCZpR27zNy1bfP9kBjVqgjOm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(366016)(376014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HqSkGLVt61jPSVsO3sxwjsq+ouPBiqqCRdaZzsm14YglHtz1mZSWamv5EZ4w?=
 =?us-ascii?Q?MIROBnHbY++VVgm66Hy2OPo3bt5mUJ5e7FRMsWovqmvAPdNrM0k2/GHu9ex+?=
 =?us-ascii?Q?SRRXPvCUlHO2Otm98KGVuGNlIzXcy6KWEW50O/PBTOQpUp2FTTrpIjbCAF5C?=
 =?us-ascii?Q?o9Ob1l6F4Uz/xwmBFXj1IDJfWDguGaovdXhkrNcx4u2yPEjovVfv6HCz9Mlg?=
 =?us-ascii?Q?HujqJPXeQaxhgaf3aHuQPYcdDHjW6epfB81GZM+m7YZvghheQA8o4aSAKa6s?=
 =?us-ascii?Q?mYvXoV5cACUXvA80nWd6T654qNkW+mRDHudvFkbXzt2v+fFEgscUE5xt0jEp?=
 =?us-ascii?Q?jbhhHSZfLjCB8wklzdB0/5ylo3bWZaT/qEzcNpjzIDGg4rxk8W/CnDyFxuUS?=
 =?us-ascii?Q?dz4qRSsgy3HIz4vSn/t9UAt6PwDAGf9UzbUn3+i2YhqUJz+jEtMKuVrwugSS?=
 =?us-ascii?Q?qFA51G3RA+s0rTVxlEogaL21Az52BxrbfU8v0w1ZdESfUK3SJxUZVtxJLIhb?=
 =?us-ascii?Q?8/4J8tV6thEVDvqwsQ6ObghUGsGWQGTT0kiUXQkPNkafZCmZkfLVBo7Uh8r4?=
 =?us-ascii?Q?qc5fhNTlZ0W1GiqBwubpITe+y9OKzHZLFwCZez08d8XAxrrm7jAj4ibPbamS?=
 =?us-ascii?Q?koLtQyi5nWqvRctAu74gOFCQSzfz4x8BEXAbJHipNNfsbybkURxsdpiKJMYr?=
 =?us-ascii?Q?sBj/T08/NxRK4BZFAguUIJVbf5RDN2YjuuswySLX/uanxQg6EEGZ/Euuuooq?=
 =?us-ascii?Q?gHmXKhYk18VlfyUxkBRpQPQLFkU1WeRjRXe+TdJgqPSHI7aZGqJMcRUsDnqX?=
 =?us-ascii?Q?RPraj4JierLVrt1muKVkO9GjYLSxUG8j6jQyyaJa3+cA8jTeTndeL0CKPcQI?=
 =?us-ascii?Q?ZZ+NPLW+qsYYfNhI+AeJQhJqebZ3iHXtbwqrON8tArOWhfD2uQHugSxaIEuE?=
 =?us-ascii?Q?m4dYGxoU9V7rMsvz7TzONWtMD67jvhNlPrOPdW/0pdeg1X7IkdbfzN9tDpsC?=
 =?us-ascii?Q?43QIj8WfVNarAJ0GfQw6iqCyscuAnHq0lo6oUK4mCvaV/LFXqMpXv4OcXGiy?=
 =?us-ascii?Q?lT1j9Tqgx5Py+iUPPo0CcTQsvI3g19P6TrnBbFnfvoHhtzKe0RWJMdqTVnT8?=
 =?us-ascii?Q?c0pI6N1qNbTCuCkojRDDpJOFcGpCfBQwgOcWGlGr5N/rUgg/c6DxqN0doRVs?=
 =?us-ascii?Q?moaqn2H2v5Im04oG0NHIiZsoaow6cAoC8gtj/ftVyMw49bmnk9cmppiJFujF?=
 =?us-ascii?Q?3pScU1upjzf12kNHYbrrVZFWDWyVwBmdCbTPfLYb1xnvw/At2673cvZPSvy0?=
 =?us-ascii?Q?CD+sRWfhgj3RQTk61uIU+8PtkLSCIkmB2LBtenfF8I5XdtkwTXkeunpDC1mO?=
 =?us-ascii?Q?ZE/KPHnt00othPqvVvZIVKpO2yG3EBU3/yGsXafhNP5V43ymAb288QP0SLsU?=
 =?us-ascii?Q?V+BqPi8qfysuvyhzE52ya9jj36C0lNrJQ6tRXCpclXx2dRmc7gMxuGPM6w9H?=
 =?us-ascii?Q?iWB4HZm1JmMG8srFPY0XYFgZGrDKdokdVjbza7hGFd5b4PQiVef5lLeJ4jah?=
 =?us-ascii?Q?AJT3F4RpWl88Osm+GWREqJxLnEV6vwiM0CoycIXt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb5fd1a4-ca82-4a3a-4d6d-08dd62d024fd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 08:13:47.1285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8HfS+UA29tGO++bZbCPfqLiB/d+B17VOQRorzRHItBx4qjBndOyMDROS9/FFNZPpTluBlWgCzUeAR5rpaoRUKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10193

On Thu, Mar 06, 2025 at 12:28:03PM +0100, Dario Binacchi wrote:
>The old code also accessed the anatop address space and therefore used
>the variables anatop_base and ccm_base to distinguish between the two
>address spaces. However, now that a specific anatop driver exists for
>the i.MX8MP platform, the variable ccm_base can be renamed to base, as
>is usually the case for the variable pointing to the memory region
>managed by a Linux driver.
>The patch does not introduce any functional changes.
>
>Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

