Return-Path: <linux-kernel+bounces-427014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AC29DFB2D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 08:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F9A116415F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 07:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD011F9431;
	Mon,  2 Dec 2024 07:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="STH538Jq"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B281F8EFA;
	Mon,  2 Dec 2024 07:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733124350; cv=fail; b=lE0aMI14cXMUB5AtkNaSWa9T7ZUxYmXzFvT/FhSo1LTv6gfarCYRz6hrfocK5KAENlFOcutzhdV7jl70HXrBP4RZDD+RMGM7FfZyQQSuhoy9JK9qZ1kYlmXUmYnPZ7OjyO5I2qdKoND7HlaCd0coPyRjLehH0MrXOZnCfccaQfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733124350; c=relaxed/simple;
	bh=Ld6ZNT1OcJtovl3l0gUyT3TqH406KUAk4NDowo0Dz9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nv/Dd6GzaSYY9RhbTU/d3ZPenctPiz1av17vCDQhFhHrMwe1RtDfuCjw1vO8aLbdulDKyj+PKAaQ2NQj8VdqedTELrHPdD2Fo6hRWOczG7iIilenUtmo+jOnRWAjaUqRUM67aNZcPifrHb0XU9AF8xwze0t+ZpqWXhVpir+Zfuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=STH538Jq; arc=fail smtp.client-ip=40.107.21.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=byixGU11vBXDXrPhyHpaNAAt/RK/SUTC/GAYKyMrHIpz3qztyELLTxP5+QQY91AWxWATABTd2c1lRXgtRYYZ0zt8acBOGDRimbNlaDbbk1F4XcYj+mJ/xAEo2xjuaQq5sb382/4fQp20l7htWyGWPB+JF45rZpMlSh+O+q3eMxU/tzv0ffAe7Gb7prs9nh9V6h5gLOXUWwqdRZIS7eUa0TF0SXzxn+Fs+b+6iP5CWdtAKdrpkwl+yB6fmVlGz7105RgvcDCrBG6b//IyKO8Up53cqzyYm8dccnufaEfuuNGGF/j6s/hYnqQ3GDlptRp3roXL9qv/r9q+etd7IUOgeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXQtAS/PsVTVPPWEt+Vm1dMCFgJPeXzFRj+s1d2k4l8=;
 b=Gsf5ngCzMg1ts/OMDhJfuHPNFTJfqawhx6w1WZvzpUC4pGrvQZxg3tzIrC5n3u/n6+S7Qk3bRwy8fbWo8RQxrrelIyQvHzNYndVl8yK0bP7P9I6toXTIyL5Aoy79+OuRMatArQYcK6sYQIjgIkCcYqrOvlUjM4r/o3idWicrnZOvaWA/V82/ULemyytC1eWGyo+PayZTydpxCZ3wiaoahSHr7ADP62HYseFkUmQ/EfvKWaGwuVOlQfn3YAOl9HNxAiqQazWjXaNF2pq/jmAljPxuaDk8tTlgvikxHrvfXa5xBOTVYGhn4ym6hrsNrrhWDvpCn0WE+VBsRqXMGzlNIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXQtAS/PsVTVPPWEt+Vm1dMCFgJPeXzFRj+s1d2k4l8=;
 b=STH538JqA7z9c31arLM3WcSdkcpUPTCj1aAk7PIL5rewsiJ3vz7eMWd8mplLIUHi2+Xhjb34XnRD0nNq0caphDacBWD5Zf6OIg13jZvQDMTlOTPW+GL51HaDjjhVr/hV9b2hshHqAmnQ+zYRttZpTGmjYiJy9HasAdFR/yZC/0BjnwF+lwkudX0zJdLyFqp7HTXqnFiXX9YmywEi5NvQgWuja7c27T9yZkHBYVIRV8yB9deVJGjVqqNgsbkEXX3p2kCE5NPgIAuNyY/pQEjsRoBQ8ACSWm58yv57RDZp+/yfXL6I0U20uW2WdAOES6X0FBWdYf03Kkys9PAdhunlIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by AS8PR04MB8803.eurprd04.prod.outlook.com (2603:10a6:20b:42e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Mon, 2 Dec
 2024 07:25:45 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%4]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 07:25:45 +0000
Date: Mon, 2 Dec 2024 15:24:44 +0800
From: Pengfei Li <pengfei.li_1@nxp.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de,
	catalin.marinas@arm.com, will@kernel.org, kernel@pengutronix.de,
	festevam@gmail.com
Cc: joao.goncalves@toradex.com, marex@denx.de, hvilleneuve@dimonoff.com,
	hiago.franco@toradex.com, peng.fan@nxp.com,
	frieder.schrempf@kontron.de, alexander.stein@ew.tq-group.com,
	m.othacehe@gmail.com, mwalle@kernel.org,
	Max.Merchel@ew.tq-group.com, quic_bjorande@quicinc.com,
	geert+renesas@glider.be, dmitry.baryshkov@linaro.org,
	neil.armstrong@linaro.org, arnd@arndb.de, nfraprado@collabora.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	ping.bai@nxp.com, ye.li@nxp.com, aisheng.dong@nxp.com,
	frank.li@nxp.com, carlos.song@nxp.com
Subject: Re: [PATCH v3 0/4] Add i.MX91 platform support
Message-ID: <Z01gfuVIIhl0rYwI@pengfei-OptiPlex-Tower-Plus-7010>
References: <20241120094945.3032663-1-pengfei.li_1@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120094945.3032663-1-pengfei.li_1@nxp.com>
X-ClientProxiedBy: SG2PR02CA0075.apcprd02.prod.outlook.com
 (2603:1096:4:90::15) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|AS8PR04MB8803:EE_
X-MS-Office365-Filtering-Correlation-Id: 60b552a8-2aa6-453c-ccd3-08dd12a2893d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ObCHe6H/ezsBGKr+2kwh4YxCH0fLYyzhwYaQ6Nt2Kea5gTkjagKSrxZ7d5RF?=
 =?us-ascii?Q?PZGXQ0iSlckRzm5ouKv4N0xz30w3VWWu8NZ7hpC9ZKfCDjUG7nni34VThUp5?=
 =?us-ascii?Q?dpjeA2g6aJVEEAsTck5FeZgN+UKw2M9KZ1zoxXR9MA2UhZIQc8JMtefq/8Dj?=
 =?us-ascii?Q?G6xy6QKX8kmX0c2uTZjBCpB4vWZ8tgytUL8/GYK/nXjFZucyu4UWETTrQvhZ?=
 =?us-ascii?Q?Tsr5nswNVdNusjEi/XReAi3P1IZUDel0+8MWn4+ID1IYmRnBnMfmhbyz0tQ+?=
 =?us-ascii?Q?wusQJbelFuCef6uwqPy6N5BF9hcnmh66abDq85X812fxNOxtSu38ZoUYJPir?=
 =?us-ascii?Q?JvBE3XKIfCR23ZAwADP5q9HyW4Y1S5NIy3TQvctPfuVIJ+WpgNsb0yLvKPtZ?=
 =?us-ascii?Q?Jal0t/GSfeA0prtJB/ZApxy+cxqdOQpmGsy5XJ+E3eao87TPBGBC1gH+S2jI?=
 =?us-ascii?Q?inwo75M8qx1Dnyd8MZOeBEA/W7dH9lUw0YNGic9rncj3g1A7+50PXtWE619o?=
 =?us-ascii?Q?k3dmYA9aBbtZ/xpI/4D+NRaVjhs4oqPUemxkUaCTCjC74FHrDTg6lcgBJshH?=
 =?us-ascii?Q?IGMoX6Ue1YCeyA9AhutiLoGi2nixMd9ds+22ZqSgeE+IoQ9eCMYLU7aMF9Sp?=
 =?us-ascii?Q?pp1LrsSYCuVg3y6BQPO5npZyAXyh6Yyf5hDTDNonSdfrKbM8psj5w8p94SnK?=
 =?us-ascii?Q?6RUzuBVQIY/BO9S2FWHxlCdMH1bQ0NH77joqyXpbfPdhnxA3NT3c7jrnGAwt?=
 =?us-ascii?Q?ipwkIBxpdELCupqX4QhkrzFrharp8WK8J2UhAYpfM+7S7jzFwHG5/vF48aIU?=
 =?us-ascii?Q?yRXdN+gxPxIguQ0UYlh01Lm59MUG7OIzrXH/g6hQUU0khzqMOkEBJFGe3RdT?=
 =?us-ascii?Q?GC4sNxewbTYElDT18REMHj1i4w60JHzZzGridSOnmDFLsC67WAdF8vgz3xwb?=
 =?us-ascii?Q?wzjqyj9vYN4AAQn7q9kVb5Z3fxY1/SsABnrsLaQ394YGl6FrXCVguMGgjvmr?=
 =?us-ascii?Q?YSgWSakKT+sy9/MQaxpV5juJhH7UEryRZFa1QA+xQmlmwHAItouIcN99q/u0?=
 =?us-ascii?Q?IMIGVWFztuMjMzxGv6GUXXoo1+f7wZc3bjwnauHj8Un6afttPGZIKlx3Y7lQ?=
 =?us-ascii?Q?PbL3PZ1AXatfvIQvmlu27VCYfTXRdV1RcVA70N8/SIWLcxjbk/5pWFUtdIZq?=
 =?us-ascii?Q?sso21Uffzlza4aTMrOc6La9j1+X72yBLLtwPqmVPf0Y6QIz5OkZ5YA4WBJKX?=
 =?us-ascii?Q?u1m+8dsmAHx4XVH0twCHMW8l2bvadChuG01iul2BIBt4vs5eg3eMGd9zA6sc?=
 =?us-ascii?Q?P1772b3tYGFJsIBUmlfnn4ExjczrVJMPVpfoAURZfnxSTszsJodizKVu4X7h?=
 =?us-ascii?Q?gpNkmx7BCrtocypqWubmBjTMMPkvXK30qcndudNvoYkRvTVLvw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Eu1owu6yQzy+5fxN5Gw0GnIyMhJuYAhO7LaFkdtGucon+zmc0VQt2+I/xSeR?=
 =?us-ascii?Q?/PUKeSf9yL6aiPjeQggZktAUZP+Bvi/HyyFfuhReJizGC4+J41ygmb1wUCfh?=
 =?us-ascii?Q?yTfk+A8ozPnIHiNXjvun5Wyokh7iKrv2VNj2ucq5xqulpHGUNCx+vFU1yvDu?=
 =?us-ascii?Q?1epVSfKKmhRuj275BiKjVEWCmUc2ZpHki4neNjPY7gm/EkL0VZHtUbKBIQp1?=
 =?us-ascii?Q?0oYZ4hNgCcAsthYIYJUbDxJEKAh424DjHivoqCsqYJWNQcPmWEI9McMG6aa0?=
 =?us-ascii?Q?q8uqL475jnT7ZbgWLtVRAuuqXYmd2D7N7qDERCDitS6Io1ZWNba8EwzHWbs2?=
 =?us-ascii?Q?0046jW8PO9AY3rKTvOAalEtxoaRxlntDy6diJ6hncRFGvo8RuzFo7XHxULbs?=
 =?us-ascii?Q?/BsiyHkaaQ+nG7jkuaZqvnp1tOiq88nuHU3XuReO+om0Tc9uXM/11IvotNMR?=
 =?us-ascii?Q?RVD6bz8+vAXio43N+B5aqXEEzlaEkJiY8q7amfu39VaW4oGzcFuXAzcNmG7l?=
 =?us-ascii?Q?pLRafa+VXlOZSjWIc4meww6FfO+Shq8ioqVpIWFqnG6g8Q+gSzY7R0G+vBly?=
 =?us-ascii?Q?0oTvWYRkCfbOhVbYr7Dt1rdPw7MFfeCtMsZstC5zCez/ITCEQXXyxkWVoyKe?=
 =?us-ascii?Q?oNrQm8qeTXCCXfjvJArN/zNKA4iBBsI6nvy7ICmSUIwua+aiu0Xn9FDzZHS7?=
 =?us-ascii?Q?1XHmWKSpnJlwhc2AAv70Qm04CMbMopkOiEr9IoIsb8LIP5KH94j0lq98q2pr?=
 =?us-ascii?Q?mxmAmRfw7p9MRGY49rhFMWjRyKp/QWq8H4Imp9sJOqqZo+VE7+nOGYUcJmhN?=
 =?us-ascii?Q?EQ1yviduux4UOA7HSy1JtVW79yfGhaNSrxSeIQfA1/RGP3JHilV9YXWNi28h?=
 =?us-ascii?Q?NIKVeBYF+g3CzyaNSHsFxtt4GHumXspQbwJgGoOIJytgbJsd8guTRwEqqD9y?=
 =?us-ascii?Q?G5xY/3uTh696mR25Ba+zpsn7gFghWRW7ahM3qyt1G+nKF/UMXM1E+EtDu+PF?=
 =?us-ascii?Q?By3ET9OyJ0U2Jtdf8L7oe5nfcYBv+ZBrAyY/182Gy5SnixnOWBMTurumtELv?=
 =?us-ascii?Q?BbJHkLjJ2aTK4sLUyDYJBfT3wdR6wZWMaJG19ALYFBulcsW5JDVogWpnwtyk?=
 =?us-ascii?Q?EyCH78lrzOBFhbpvE+ZSAFglI78F3N62mJhLEApNeh/EKN3o//1c6sLIx8wU?=
 =?us-ascii?Q?n1n9ySrrl2HhkA7j+yuIckCCd4c39VYhHp4ODtcXZHmoQk1kzLJnmzbUnSlL?=
 =?us-ascii?Q?XtztuCdmpwnzEjkE9rWv6YnfRZm+wtsIpdwQMLH/fzjd3moIpkNeQcjd6Z6Y?=
 =?us-ascii?Q?ShIACQ3OGNXXupKxkbeUG+a2rpBNuK/6/F9F7QNPC4N4EGNoAwJjEtPchSxy?=
 =?us-ascii?Q?GeUXGu3HtqBk0FKnr/JjOZPLZjE0sctTcvIrT9231TgaQr6eH6o7sYPNrSWg?=
 =?us-ascii?Q?5rYiC7woeodoh7+vvUOoTdxi5ylU/5vY+SY3l0DFoaAEa6sdjdYYt0b3Nkdl?=
 =?us-ascii?Q?kXWNBwt4LzOyvUf9N20K+Ecz5/0uuVVqEH1/uclrid5bfZrew4l/kfaOYF48?=
 =?us-ascii?Q?YdniSN/0Gplp8VmcIFS2u6d0efZztnA6fMp/FNZ7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b552a8-2aa6-453c-ccd3-08dd12a2893d
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 07:25:45.7385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6hx2HTklegMDZwY2xnI1gv+W/uZRRbCJbqL7QnXjybGBY70X1ZpTo+6RG//tgPyfTidiUjSa8ZFBjrotZyRHag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8803

On Wed, Nov 20, 2024 at 05:49:41PM +0800, Pengfei Li wrote:
> The design of the i.MX91 platform is very similar to i.MX93.
> The mainly difference between i.MX91 and i.MX93 is as follows:
> - i.MX91 removed some clocks and modified the names of some clocks.
> - i.MX91 only has one A core
> - i.MX91 has different pinmux
> 
> Therefore, i.MX91 can reuse i.MX93 dtsi.
> 
> ---
> Change for v3:
> - Add Conor's ack on patch #1
> - format imx91-11x11-evk.dts with the dt-format tool
> - add lpi2c1 node
> - link to v2: https://lore.kernel.org/all/20241118051541.2621360-1-pengfei.li_1@nxp.com/
> 
> Pengfei Li (4):
>   dt-bindings: arm: fsl: Add i.MX91 11x11 evk board
>   arm64: dts: freescale: Add i.MX91 dtsi support
>   arm64: dts: freescale: Add i.MX91 11x11 EVK basic support
>   arm64: defconfig: enable i.MX91 pinctrl
> 
>  .../devicetree/bindings/arm/fsl.yaml          |   6 +
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../boot/dts/freescale/imx91-11x11-evk.dts    | 875 ++++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx91-pinfunc.h | 770 +++++++++++++++
>  arch/arm64/boot/dts/freescale/imx91.dtsi      |  70 ++
>  arch/arm64/configs/defconfig                  |   1 +
>  6 files changed, 1723 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx91-pinfunc.h
>  create mode 100644 arch/arm64/boot/dts/freescale/imx91.dtsi
> 
> -- 
> 2.34.1
> 
> 

Hi Rob Herring,

I haven't received any comments from others about this version of the patch set, is this patch set applicable?

BR,
Pengfei Li


