Return-Path: <linux-kernel+bounces-515581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9E1A36676
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 20:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2C316B514
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628BE1C84B6;
	Fri, 14 Feb 2025 19:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FxrHU7PP"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013015.outbound.protection.outlook.com [40.107.162.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9F21A83F9;
	Fri, 14 Feb 2025 19:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739562577; cv=fail; b=WBv/KjUxyWdIXErsPg+rxCwDygdJWQt7FJkbHR6J3qvvUw1r2/JdDecJfaTmMU+ss/lGulav1BPODk0dPHJ5Am8pRrcC0qD6dhSaJoIio+5OGKq+M7ekvHWTV6L9USRrHf1XEpQg9G2ih0QnhCnIUmharBnVwtkSucl96NsUxkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739562577; c=relaxed/simple;
	bh=nWMeH0CmMjUNs2VyH7xjV5VUNCqGUbDBPq9WgVZMIp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JzoAK+l0K7hoGL0H44DIiwJN3qFRvRaMzWhUDh17Ip5D8dsp5aVc1zbhZrmZWVCTUPjbbpnhUcfYep8sZiMQc+bZDj7213fn+2dCP3iyBw5+Ps7VzRnl0NCbHILnqSSa6PmLtmrVyrJ+g+gM1pzPyy8SLIOh7zi7iiP82ce5s4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FxrHU7PP; arc=fail smtp.client-ip=40.107.162.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RvKjGBhfHSWqZC9bqvhFHFrqHkkxgvjqb6c1QL/K7/5VptVmKg/Rlf2anNQKUgmdvQOk4SZ/9rJ5i7ia8+5kjTs9BXRRNcm5UIFnU566CWhsesjE8ZfA8LdmHOFVnsmciJFvOllZdHl4WP3fp8fXMUTyHxnHcElCXJWM7/zRl3kSWyqXwiFANNu9b5V/ZXOnKwypMtZVECk5Okm6DnKBjP7JR8IaYD4aPw2qnoRbGbL+7UpUxQ7qotau5V4sQFYxuYBuOff1mRnw7BJRysRqFFoKTfjk7Mjox6qvciVRIHP6ohVASsJ0piddaenLL6M9ig1RjI2e23QItK+mOv5I5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64ZcGO4VdoszMJfx90Gv2f6LEmIwa5diWhWDXNPbtq8=;
 b=XCbLSEwbAB8RskinwEGmHoBbKP0OGRQO8YweD59sWNNOR0AOW3r9ceSscF0wdtRcht0SKzK8DzPbfv1ENY1CyUnzclt1H7rJJzNI6n6s4kXO0qRNx7UcpvdHnAqLgs8WOrFyFdkYCUtnxySjPoW1x+ZjE+69EzuJHyZVtZ8Q3x6/3B85pB73ezp0CahRrBnr48Ms6kFwSJa/Pdyia2YiC/HP/uMFSP8dc24SfLSX7O/ADcUur5ZOa9oqAqRQOX4gi9E+VUE2HHIw6YXW9PQlzxKDcTLswLCkahXtsSzEdCQTwJU6gofAx1p6YaUCMiCCA5OHFU5fgeTN+fT5sRsCxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64ZcGO4VdoszMJfx90Gv2f6LEmIwa5diWhWDXNPbtq8=;
 b=FxrHU7PPaeFZeAFyP4p5XoKMuG6n2wNgYORasI8ajUyybo/cnMoWy3s0LyjdaiqBFRUyDfejqB8/eQLrumbZysxjH4pv2xuNJMoFmaNbay1AlCkbeoWpl4BvvvddjnMH77DihQFtPJoiAfhfe1BPpQOL55Lc4+wabXQ46sZBGnI2UXqwKdvr+qf2ZClgqvHEVkxPI28KmxDLXdR/0YjQza7sLxhC8n7fqMF/G9041k8IHZdcKOxm3ZmpK6TzupCOZwariFaeNNWcRsfHQeu5FfqrUWLqx0nUOqetM7rgk+y+ygXhibr6VK0LnQbRF4tyRub/X1ECmH5Yzx/QulAm8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAWPR04MB9840.eurprd04.prod.outlook.com (2603:10a6:102:387::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 19:49:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8445.015; Fri, 14 Feb 2025
 19:49:31 +0000
Date: Fri, 14 Feb 2025 14:49:22 -0500
From: Frank Li <Frank.li@nxp.com>
To: maudspierings@gocontroll.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: imx8mm: Add pinctrl config definitions
Message-ID: <Z6+eQlXwHZ+1oxQE@lizhi-Precision-Tower-5810>
References: <20250214-pinctrl_defines-v1-0-fbc86a42ef3c@gocontroll.com>
 <20250214-pinctrl_defines-v1-1-fbc86a42ef3c@gocontroll.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-pinctrl_defines-v1-1-fbc86a42ef3c@gocontroll.com>
X-ClientProxiedBy: SJ0PR03CA0284.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAWPR04MB9840:EE_
X-MS-Office365-Filtering-Correlation-Id: c4adacf2-9356-4b51-277f-08dd4d30b2ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|52116014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lfod96mDXQYB2tR74pNCJKLiNe5WAHVR5BZ6eDVfRiEAiIM2m4BgmlNpCaJ6?=
 =?us-ascii?Q?Z6c81LGrTmeMEA158Z431vPMiv9ld/WF+7kGCZgbr5IJau0db+rPhwqIIFhB?=
 =?us-ascii?Q?FSJs/pjonipaH8IklgppkVrP3+qdDkgWrOqZNtRtylVEXRxlNtH9r/hOdkkA?=
 =?us-ascii?Q?lV05IOCxKTEz+HmuggLgVYImqyo1dFCjlvsO+59c0VDXxZzfB75Gchai0BpC?=
 =?us-ascii?Q?8DebHnDWWoKjzh31FeD8+DIa2XCAsHAnc9rECD+ZGnCy6jx8hmXtXCNOcNp/?=
 =?us-ascii?Q?ddRHfeJO7uzmLd5KpvKqMsY3I0NxFb6eyZlZt35EjOBNm44f5Bnf5h/Nc7Af?=
 =?us-ascii?Q?srnvCW7GURcmP3UpTrKN7jsHyBPr1WuS8bqnQ89u2/FOJS1IoenpQhka3V5W?=
 =?us-ascii?Q?+Jm9M4mB+Vn0i29WIV6Mt++T0rH1tDfazLPY1ZG+CW2acJLmvptsrWB3D1JK?=
 =?us-ascii?Q?MIq18GMZN5+h5XiP2eViFSuhbYQBeyLFhqoBSfXmhLtYqLn9DYPia8Tu5WXm?=
 =?us-ascii?Q?0UJU61UtwV45PNcuIJmUtN0CXVzmsU/tuK9BixQuFg3ivkqfIA/1l5K+N6WB?=
 =?us-ascii?Q?CagqrFzqCdCXWx9aOz5jkPdXe9xay+rsPA5FoOjTTYCtICkf/HbZUOXKI9s3?=
 =?us-ascii?Q?FaCYg5sD5ygOPBaN+UG8M5gK3dPMoaZxhXldiwAum33mIhlyyGAJWZg74N+y?=
 =?us-ascii?Q?D8/bHNrnHK1RKfDSLEyJ/iTYmHdT5qPVp7fKfdrC3flX/WxqDh576AroR5Zv?=
 =?us-ascii?Q?Slbieg/yb65kkiYHHyVIXoY60tGUuJ6H+P1L0WYQoV5Jcc5wR61dCKRobJLX?=
 =?us-ascii?Q?t+vWCS/W6VXpJjyk46FqKWTbUHhDJ5ET9lS21rgayJ8arTv1WDGwi+7ClhAJ?=
 =?us-ascii?Q?a6vFvTghA3IREBQUIjUv2qi2PUdbcJnEogOTHt9KRVs26ovthSWgXHcz23zB?=
 =?us-ascii?Q?5gehGmR2dnUpUSpdZRyyGlrk+/iIEG66zoViszbC75sZ5OUHRVaFOtIdM5ET?=
 =?us-ascii?Q?Rp+Szg4kRU10SGJlYeX8ZyAuQEsTGFqyE7FU/m2a0KjIs+APyw50qV7oixR0?=
 =?us-ascii?Q?R5Qr6n9x3PP4pluZ66UE1m92ehWcdGfiVrJFlEd9TeGtrXI8LrU5QryUQreL?=
 =?us-ascii?Q?tpQpNt8yAUrUTd75OxOWBVU9hONw3Y2/N+MCaxu7VWMtfnqLYrxbBPnBLcC0?=
 =?us-ascii?Q?cx2eaHiq5akTvpuC+KZ3X6jQT4jfev9vUdhEE45+3ZaHQ+wAnysDrQf8Td7S?=
 =?us-ascii?Q?uEmWUXXDqVEAqBUUakAVr1qwoou6fynoCuquuPvh6qJ646RUBnHRoL5I4eB+?=
 =?us-ascii?Q?MWCVIahZovyEwO1u8XQmi6WfN5rm2Om3F+I2P+f/VGGdm1AWrKhnfB9xsg1o?=
 =?us-ascii?Q?6BB+n5OqF9QsvhAcl6FRp+QPUPaTEQZHoUzy+yBWf3cuPLfGtLT62I3CiWSf?=
 =?us-ascii?Q?NbeSzb4nPvsIhsnPGb0e71uBhKW5YV0R?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(52116014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CPbdwbQS6qmXARF1jSr0O3yYvaiAk0sJgS4gFEfHVscucHZB1Uy7+G6FESSM?=
 =?us-ascii?Q?0vjpjy+9TT9+cbiT36I2A8/36aHyTitO+pwrgdHtVSN7hb9RR9cCLi4R+vZJ?=
 =?us-ascii?Q?DZQV411QQ31RHO4fG4dUhysmDZU49UA3fmZXJtSmDSo3uSsblGDdeorhHUc1?=
 =?us-ascii?Q?fgdmHe9QXZQiyF6OwYZ83MlyFQZY6gznzOARkttDm0PbtPP/o1b5de7spuhm?=
 =?us-ascii?Q?4pC/oWYo3UPW7NiaRCnTPtjD92uxbq2Po1gEOViUVBBQo0ONh3m3En6QiF/O?=
 =?us-ascii?Q?6FbJnGBZMtsMQxW86nd/O+//Is16mSs8ciBZ5u47vsZ1qt0SKE2x1x4hGyLg?=
 =?us-ascii?Q?AFZ2aReJ8RrybA0lR/VhZQODgL9lAi5l35MqtftAp84mMAgYOGnsLTud4w6M?=
 =?us-ascii?Q?5Wnv19/jzQYpvEZQ3+4hax6+70mrD59Jp29VaRYWTpVnM6bLFEunnCOCdxa8?=
 =?us-ascii?Q?HQ5YRE0kGbVuLS1sqip/sF62peMB0Y1QyM/qLe152g5R7gj/a8n0eUj+SUFb?=
 =?us-ascii?Q?99CDCjJuksLJ637FNRoEint2Fx1MpEhsSFFRGMAKrVzpx6Cv2oltLZ2yJpo7?=
 =?us-ascii?Q?+ykzKED0RpTkt6/A3mDylg1yiTx7JLWj01jsYN9IX3/ZHAAh73xXNjIicN5P?=
 =?us-ascii?Q?N2x2dQtbSbTfxQqWtWpRo61mJlad1pnJTwuhha7C8Ju9iAO/mpEA5jSKiRP1?=
 =?us-ascii?Q?0WGfMHfWNqtXMJ4aI5Y8d814o2BcnzWz3B+GSAVn93c+vMLMhiZ/zXono2H2?=
 =?us-ascii?Q?lGjf9NEGrSax8M1yIPwQweVqtNABGdNVJi8JasHOd7Xv8HKZB1V1HzLZDpog?=
 =?us-ascii?Q?fwLuzO123KgGwbvbM5aPiCKPGvXEEB58U5TjbDEV/pNtC1WTubX1lx5i27WX?=
 =?us-ascii?Q?rPgBhpUNmk9kzEY4eY9Sb4fd1tYAJJ0qNVSvzuu2+BqPhMLniob36XuBiIgM?=
 =?us-ascii?Q?9NkQU07+8kmp2J12apeHpy63Tt3Cs5pUN1t6IL19xgdeumImCBPr28Gt483A?=
 =?us-ascii?Q?tTvmybrSY2qBWG2HFX46/dS9SZSh3p+k0XPcKxKaCCglBX706Te8HWw2+9he?=
 =?us-ascii?Q?mLjYa3aP1IMrIoJM9YhZvkOVggtERPiTzCPSBvDo63NbCbLehwMwBTx/VIyj?=
 =?us-ascii?Q?zNNrZfmNh61Idf/wZ3oELrR5KN3wiEaCforYr3gFjaJtLEaVOVfsmLbKItwW?=
 =?us-ascii?Q?ZyPZLn3jdspvkkK439AIhJQCvkHASRX00G7Ny96Sci2Q3zZo6DFVramANYNz?=
 =?us-ascii?Q?CW7Q5V5BVtlZMC13tJzt/sE1PzGJIMsRdKTlw3WrZYcg5V/drTLlQbG7pa5L?=
 =?us-ascii?Q?RBUEV0VeYpiJ+5xnYEarYZFbPfcc9tpHQelUcdeEaE8y78fN9FS4PyNM51FC?=
 =?us-ascii?Q?w2um4rr+tfbepOH6xDQgBZdsj6RTtp4TQ9ZRmmi30LG5htfCpEA+/hRCKlIz?=
 =?us-ascii?Q?/xDtwhaQWy754eH8Y9Zi+04iJ4+MTWDj03tYiDh8dtmbKlRIU4+fo4gD5OjB?=
 =?us-ascii?Q?5UYM4w1bnmDclgr2w+YjXNGcbIhf5nMaXZRELnO0WiukxNXNsQAD7qWlnnls?=
 =?us-ascii?Q?w1fyf+OsWSwOJcDs43dJynhPtJAKk3C3bSOjPX7G?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4adacf2-9356-4b51-277f-08dd4d30b2ba
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 19:49:30.9932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: umWEK52oOp54L5RvzeS6jQTWHA+Gmb/gbdED3YHgsUj8OyOVXcvTbUCDu27pYLeZwhW0j/029NS8xa9FBU9Z7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9840

On Fri, Feb 14, 2025 at 04:57:42PM +0100, Maud Spierings via B4 Relay wrote:
> From: Maud Spierings <maudspierings@gocontroll.com>
>
> Currently to configure each IOMUXC_SW_PAD_CTL_PAD the raw value of this
> register is written in the dts, these values are not obvious. Add defines
> which describe the fields of this register which can be or-ed together to
> produce readable settings.
>
> Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h | 27 ++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h b/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h
> index b1f11098d248ed5fc8ac42daed808beebe3bf7bc..b231d5968d07d1e135963b714c3fe80ddd8641ab 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h
> @@ -6,6 +6,33 @@
>  #ifndef __DTS_IMX8MM_PINFUNC_H
>  #define __DTS_IMX8MM_PINFUNC_H
>
> +//Drive Strength
> +#define MX8MM_DSE_X1 0x0
> +#define MX8MM_DSE_X2 0x4
> +#define MX8MM_DSE_X4 0x2
> +#define MX8MM_DSE_X6 0x6
> +
> +//Slew Rate
> +#define MX8MM_FSEL_FAST 0x10
> +#define MX8MM_FSEL_SLOW 0x0
> +
> +//Open Drain
> +#define MX8MM_ODE_ENABLE 0x20
> +#define MX8MM_ODE_DISABLE 0x0
> +
> +#define MX8MM_PULL_DOWN 0x0
> +#define MX8MM_PULL_UP 0x40
> +
> +//Hysteresis
> +#define MX8MM_HYS_CMOS 0x0
> +#define MX8MM_HYS_SCHMITT 0x80
> +
> +#define MX8MM_PULL_ENABLE 0x100
> +#define MX8MM_PULL_DISABLE 0x0
> +
> +//?
> +#define MX8MM_MYSTERY_BIT 0x40000000

Suppose it is SION
See pinctrl driver's IMX_PAD_SION

Frank

> +
>  /*
>   * The pin function ID is a tuple of
>   * <mux_reg conf_reg input_reg mux_mode input_val>
>
> --
> 2.48.1
>
>

