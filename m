Return-Path: <linux-kernel+bounces-445397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2FD9F15A4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 20:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A603F188CD70
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4831E766F;
	Fri, 13 Dec 2024 19:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eLnfceOY"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2071.outbound.protection.outlook.com [40.107.21.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73EB1684AC;
	Fri, 13 Dec 2024 19:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734117372; cv=fail; b=j/0qCZCx4myV78cBKTu3NrJn/IABuIqaVzM7cWkFE5MLeyIPZWZjMojkKpEAuji3DhxB5tsHY79c9qvVQ16v6Zt9F1B8cnW+XMovRXHxGDrgbxtT+TdcUgIC3/KgIl92+BYJ6XtDXKXLGSr04SdRX/VUrwjyZuoxLEI58oNWF6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734117372; c=relaxed/simple;
	bh=XXBzy/KPwBi8Pf5aTBaUuG6pXxhRWYMlzCa/VOmFKAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SEBsXUaoxwy+6VWfXMRgWqApHabj+OAFKzY/lRSYOEVPlO2eCu6/1YhqjVmLzrEWQQR0HW+mG2MuSTjvDVP5dL92iwXNz536mhs8LbNnCsyc7vyVlkKzyuiQY3v6uzU2wAiLksWl1D+fywO0Up9GBtUm0+jXY2clUUIojrNfcyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eLnfceOY; arc=fail smtp.client-ip=40.107.21.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IzHxFpn7tS81ksUC+QrSyUJIX5NyYOuwmcS0FqNbYqLRCJoqutzMbwBsXkU1yPvep2ZcWa+cjDmWT+C76CoJGSgSQf5+9AggYYrW8HK8GZGh5Yft5fyudAa97fGJ/trsG5mEZEibtveWBNaqxVO413TTst+BJB8sIaSdtUDSeoDF14myy4EYm+RbeVOS20/gTBFVyvsDB48z0HuBtCnUSokIjPgehYuvuLZL49TnGYQm9OMtrUW5VHiUQD6Sy5UvgLrqKkb/kPxL0PqaEmKy0acRcNhGJESXNYjHqHDcqAPapGrmQVBUEVkCA6u0b+Wheabituu2E7AsGh1qzyoHpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIMA+2ro8VUVz8RMhsf3vzFftYnVWB2Ok7agit3Hqu8=;
 b=IVQ38j4aNvVXflguHe8IOsDNC9uSiek/dYAuPm82u38R84m68DH0miDTvkQfuhBJkv3rS1usOZTIZUsuv7PR1Fm3OgCu5Z277qRUOWQ6buXn56zard52SFwmS2XyWcR8LIN+N5Xa7mUPPOJmkvvIsHtboun/FuRIck54eB002mC8EzVKCfX8bOBdBlb5FCnvh4pUC7tAlI+XrSp2BmKdcYba2L2C/UUHcZS13vKsTUNMQV9p4El7X1ic3PYCg0ugsE0d+c/ZkgeG892m6vJCVTIDf6XgsPn5dbVHgHXMIJU+wCPTwb0MX4uv4nv5hz7zx631Y79xziQArrz8/OkqWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIMA+2ro8VUVz8RMhsf3vzFftYnVWB2Ok7agit3Hqu8=;
 b=eLnfceOYZBZGQHG7QIbb1QCLxDqbxUNPwdUldbseoIaTADhOwaTA8CwOYeWI2e6JBoPdgCEbj6EySVn3bLIFIpNGTBnZbwjNrxTPC12UWLz9RB9lVahw/MgMyxlbWfCFt/gFNVgWycImzhUs0t+VkAkkqnfsataBhRt28NvkNagwoTQtWz9ksH+hZy4ngS7x1ZV/T6gnEzUvPOWo3e5wdMN1vRvSeB2RW+1bcK/nNytRfJNvdLedWAfDQrUYlLdNj4cI/Dc9po/qe0XGQVVDekPsyYe1V8tGHgQm8Y/FoAIcrNIWpxZYqGout/uYdKg6cAzVySb62KyI5SWl3Hw+kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8881.eurprd04.prod.outlook.com (2603:10a6:20b:42c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 19:16:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8251.008; Fri, 13 Dec 2024
 19:16:06 +0000
Date: Fri, 13 Dec 2024 14:15:56 -0500
From: Frank Li <Frank.li@nxp.com>
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	NXP S32 Linux <s32@nxp.com>, Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>
Subject: Re: [PATCH v2] arm64: dts: s32g: add I2C support
Message-ID: <Z1yH7BFbYuJ++Vd1@lizhi-Precision-Tower-5810>
References: <20241213142250.2532559-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213142250.2532559-1-ciprianmarian.costea@oss.nxp.com>
X-ClientProxiedBy: SJ0PR03CA0070.namprd03.prod.outlook.com
 (2603:10b6:a03:331::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8881:EE_
X-MS-Office365-Filtering-Correlation-Id: 19b70b3e-d618-40d3-5bd7-08dd1baa9786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aM7S2HaDcDUkHA32wwBw/0ihO73c5STOxtG3bi1dIQg8Lokw16dwA7rAreVU?=
 =?us-ascii?Q?4b9cf2shbxtS+1R4xEbC7yk0/lY8eDYvkf6j4gJcgBhgKxQ7ofx8t8T/Tw7V?=
 =?us-ascii?Q?qhqMyr9Zsdrb7/D90oXyhYYjHgt6s4oPV5kxpZ1fYnW6WHh5Y+f1sUSD/gWC?=
 =?us-ascii?Q?J+h9Ohc70maqeSUiwe+KbxiH1lEEsNBJ5QKZUNezYUhfN33ouJK28ZO2gdVA?=
 =?us-ascii?Q?gwa6pPvwn8PTRP7uM4dvXDKP24NH1YKMbqdCetJ/3o2FvEgwjPa9cyvIag1m?=
 =?us-ascii?Q?EAgxLB46r/COrGOd5zh5epCVXxwseMjq+jIyQtNv3hMGDXioJe/hrty+HB0x?=
 =?us-ascii?Q?3EMgpnoDXSXmKOEJHy5sDlk+v27pIuP6zD/DMi+40kAO7sV6/x0WX/JNO7WR?=
 =?us-ascii?Q?10xCs4FWgkn0z52EUF3qFZiRYKD3MqB3lRMcyWd5NhV4ZZx9fIi0m1MGoJx/?=
 =?us-ascii?Q?RKre08+KZK6YYA+PAupMxpKnkjp4K3tvAH7WZ1SIg2rHWiORPpDYlDZ895pG?=
 =?us-ascii?Q?vXeSOHgNTKEQU+n9FipqLKYCP6Gwmwks0HwlDjJUczPFZAWwLwlrsGX3IYXu?=
 =?us-ascii?Q?XhJ99te8helF2Mddd0Eg2QPyfaQmsuoTELuoIPli9UpjipqvO19SDKSpCYnU?=
 =?us-ascii?Q?1QhF0z5XyMQw2BezW1F7+aGbb5gGuTH9U1BJ6whkafIPGkKEcz3VzjbfpX1b?=
 =?us-ascii?Q?PCDyuk9Mt7JwG+/tgKIhqVA9f++YLXn8rH81vU5hMxFZe1Igm8v3DE7PtJr5?=
 =?us-ascii?Q?JWZN7wWocfXl8PIpANNXEg5K8wj6GQTejEqGYJUcxRaRJnKcasHgIIvrd8eu?=
 =?us-ascii?Q?21KucvE3G1+JyXvPrrkEKxwAyWXILDqFaPbbMP9iVbtwQTxLGFgKXdydjrcH?=
 =?us-ascii?Q?upytrq8Sco3ksom3/4FANOj8/5RDpbIIVii+CpAzXjdSZAT3Gjrixr+HEouH?=
 =?us-ascii?Q?92LkSTxTZZoJouy8QnoqigJDhtI1XTYcSxPNt8bDEeJLLiyOXtb24gtZ2nFh?=
 =?us-ascii?Q?jCyr3jf5GfwDaAPRxHFptmz+PyNTK55k7JZWDoorIgZSll0k8ayuzalTmMy4?=
 =?us-ascii?Q?5+C+O5ecXQgryaFVjZWzb52ylt8aaP6WoDkFyVFXCdhmwekdPYbZ7CF1sc7o?=
 =?us-ascii?Q?n6mOWt3ZuMZmRiMjfY14tYUgzYZI5HYUHJDxD5pGq1H6SvXO5wHpDjQ3hP+Q?=
 =?us-ascii?Q?lv6WHgNuRKFdEheAa6CWTYpgQ3qiuxgG7U1M6UXnIQUjs5oPkMCUwQhD0QHV?=
 =?us-ascii?Q?ZqBVpDl5D7kGQ4mc5ZGRvLE/kF5Mgu01s0vOemxGqbqGrxfw1yt4BQN6xbJN?=
 =?us-ascii?Q?B7VbUggOm9pBVVAwcUUgRsrtIqPj1H0cZymKx0uYiktm1XCe/DROFTvFZqX/?=
 =?us-ascii?Q?5YyeT6y4uJnOvU2CPbv9tAd8t0BGM/ym2wY7SLo8SmjfVAaW3uj6htk72C0J?=
 =?us-ascii?Q?VNY9XiDy/313qyqupcU0Nw/dM/bk003p?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P1FpT5wjo5eVdtQjZqi8c4bokHKVh0avBnFx2Ced+5rFHI5CSbX0OfK+Tw4J?=
 =?us-ascii?Q?xE8rAVfMy9jxSFsv8YpnTXJzcxpRvkieloB0NKpX31XGzGvPTTtnXuD2eYGs?=
 =?us-ascii?Q?TW2CFWHTBRLw4xYHQmws/fCfgbGRk6/vnIRRuCjFyupWDKv7zpjfpR3HijT+?=
 =?us-ascii?Q?+awnwHb4URvL0YOI0cOtzNE6F7mW/RGus3jsyHYbKuzQOpbGUmnNYkdXR+iL?=
 =?us-ascii?Q?vs/lW9GC17T9CuX4IR/TDTGCHLC6xWYiDzy0xBStivs76DQxf8yDvxNw3t4l?=
 =?us-ascii?Q?HKllFTVgAsO/7BzVv4/UI9okOHAXRTsQIsTIp8pryJF90pFGRp2+c94IK6xB?=
 =?us-ascii?Q?Ius4ynth4OVEynIhXVbbAdP3epvv1PlOTzDaq2wJtyDceX3RyOjoGfndU7ys?=
 =?us-ascii?Q?7mz7+OpNrrE82GK9UBhXRvbNx0WkR422uwMi6O2k8jZtkOIE1VdPwd/tVKgM?=
 =?us-ascii?Q?OMkkPEQD0FFVwVCb4iEKotZAsUtjAlR7enzfTckOMkXL9Uqx7aKzDeGQxwqD?=
 =?us-ascii?Q?IPtxemRSiW4IOCaLyio5DfO7YrjnezDs1e3cK9+DVOKagbTT4Nm3mRisqzNe?=
 =?us-ascii?Q?1VDIHMrOCe/BmIHemyMXC039ySlGZu7H7X/fRK0LiV5cgZueDAoDR/vL0x7t?=
 =?us-ascii?Q?DTZ0YZWhLkW9kUGQ016Q5booJxNKNMIu69QXtf6GNtFUKk6m7QMeR6MZxkd/?=
 =?us-ascii?Q?AauZloEEoc6VeokLU343iIjFoC4py+8fgjyXkzFrUZFGLurdAb1VFDLKOF3W?=
 =?us-ascii?Q?F5RPaQIlB9EcwGBAtwkJba/8fN9Edh0oyb8fbpgIXo0AxyQRDxP9gk4XAJDV?=
 =?us-ascii?Q?iWb/sFOvS5QXbuC16K/OWHLGmVBnznl6GRVYy8QM+R7uvPGWXUCrMNmPQE1B?=
 =?us-ascii?Q?CmrSkTMOKwypCHml0TFepnfzT9cVkgXAuI3J3XHMd4Zkpe4uzQm5816syRie?=
 =?us-ascii?Q?vu4nE8bMTeaHoqUBA6DjYU0uEcyhVsXnnJw/vSjW7VgSJBpBW/MzbTdktJAp?=
 =?us-ascii?Q?M5EphssoN2rmrJ5mW2qcxSmFJMJ1o7mRPwhvn69Ej5ehGnEux2SOppp2WuAH?=
 =?us-ascii?Q?kfaFrxuJXnRUzJyMYpLcYqkhY48HH2bmznObuKKT5E8oR47h2ZlKeEp2Juqf?=
 =?us-ascii?Q?YhIvvY5YRH67xdVcDG7FHTBUOO47SvbLvqTSO/KfmaDk3lO+s4ZgGDus+DAb?=
 =?us-ascii?Q?EGG5LoGZwLTWzTy1ByqS3YlKfiyS+yNaHuLAqN0CuZhJ39zWaiqWURXlptGd?=
 =?us-ascii?Q?whgzZwjD+GVE+yH37lUehfXkcuC0QuHAxJokp8cOtORl+erJtJfheI3qfIuN?=
 =?us-ascii?Q?iaC1Ul31/Yd7bS5DSggEfVf9spA1fy8cIuD0UHPkbsgr0ltXAJzqNO5oJITI?=
 =?us-ascii?Q?nuXhPVOmsD18wRsnB2Ome71zyl944CO7/YGXsTLDmRV5g36PY2G/3bdIdJ4M?=
 =?us-ascii?Q?w8T17M5PzFIQ7zIIE5ffST3z5a57rX8vUwYUPJghevpptmqE+F7YOD9SCIyz?=
 =?us-ascii?Q?QrhNouTBiswoFaJ4WGp61PSbLyjDAwn2N5gSRN8PNDc7CKQNt3siqjILqsCk?=
 =?us-ascii?Q?1EvoUrMYNsCWoRc/wwWfMT5+zR1BQiRo7h+nEkfu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b70b3e-d618-40d3-5bd7-08dd1baa9786
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 19:16:06.3117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H/TcJLwiFTvR5/g5zPiKWseu+ZMG2VmDACU1Lg/u8O8hoMUaNZiJjIzHCivcW9rbyFASAyjHgZhkWWXIhs9AHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8881

On Fri, Dec 13, 2024 at 04:22:50PM +0200, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>
> Add the I2C Devicetree nodes and pinmux for S32G2 and S32G3 SoCs.
>
> With respect to S32G2/S32G3 SoC based boards, there are multiple RDB
> (rdb2 vs rdb3) and EVB (for G2 vs for G3) board revisions. These versions
> are quite similar. The common part for the EVB revisions will be
> centralized in 's32gxxa-evb.dtsi' file, while the RDB commonalities will
> be placed in 's32gxxa-rdb.dtsi' file.
>
> This refactor will also serve for other modules in the future, such as
> FlexCAN, DSPI.
>
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> ---

Change log here!

>  arch/arm64/boot/dts/freescale/s32g2.dtsi      |  45 ++++++
>  .../arm64/boot/dts/freescale/s32g274a-evb.dts |   1 +

Shawn require board dts should be seperate patch

>  .../boot/dts/freescale/s32g274a-rdb2.dts      |   1 +
>  arch/arm64/boot/dts/freescale/s32g3.dtsi      |  50 ++++++
>  .../boot/dts/freescale/s32g399a-rdb3.dts      |   9 ++
>  .../boot/dts/freescale/s32gxxxa-evb.dtsi      | 150 ++++++++++++++++++
>  .../boot/dts/freescale/s32gxxxa-rdb.dtsi      | 126 +++++++++++++++
>  7 files changed, 382 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/s32gxxxa-evb.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/s32gxxxa-rdb.dtsi
>
> diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> index 7be430b78c83..0e6c847ab0c3 100644
> --- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
> +++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> @@ -333,6 +333,33 @@ uart1: serial@401cc000 {
>  			status = "disabled";
>  		};
>
> +		i2c0: i2c@401e4000 {
> +			compatible = "nxp,s32g2-i2c";
> +			reg = <0x401e4000 0x1000>;
> +			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clks 40>;
> +			clock-names = "ipg";
> +			status = "disabled";
> +		};
> +
> +		i2c1: i2c@401e8000 {
> +			compatible = "nxp,s32g2-i2c";
> +			reg = <0x401e8000 0x1000>;
> +			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clks 40>;
> +			clock-names = "ipg";
> +			status = "disabled";
> +		};
> +
> +		i2c2: i2c@401ec000 {
> +			compatible = "nxp,s32g2-i2c";
> +			reg = <0x401ec000 0x1000>;
> +			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clks 40>;
> +			clock-names = "ipg";
> +			status = "disabled";
> +		};
> +
>  		uart2: serial@402bc000 {
>  			compatible = "nxp,s32g2-linflexuart",
>  				     "fsl,s32v234-linflexuart";
> @@ -341,6 +368,24 @@ uart2: serial@402bc000 {
>  			status = "disabled";
>  		};
>
> +		i2c3: i2c@402d8000 {
> +			compatible = "nxp,s32g2-i2c";
> +			reg = <0x402d8000 0x1000>;
> +			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clks 40>;
> +			clock-names = "ipg";
> +			status = "disabled";
> +		};
> +
> +		i2c4: i2c@402dc000 {
> +			compatible = "nxp,s32g2-i2c";
> +			reg = <0x402dc000 0x1000>;
> +			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clks 40>;
> +			clock-names = "ipg";
> +			status = "disabled";
> +		};
> +
>  		usdhc0: mmc@402f0000 {
>  			compatible = "nxp,s32g2-usdhc";
>  			reg = <0x402f0000 0x1000>;
> diff --git a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> index b9a119eea2b7..c4a195dd67bf 100644
> --- a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> +++ b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> @@ -7,6 +7,7 @@
>  /dts-v1/;
>
>  #include "s32g2.dtsi"
> +#include "s32gxxxa-evb.dtsi"
>
>  / {
>  	model = "NXP S32G2 Evaluation Board (S32G-VNP-EVB)";
> diff --git a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> index aaa61a8ad0da..b5ba51696f43 100644
> --- a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> +++ b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> @@ -7,6 +7,7 @@
>  /dts-v1/;
>
>  #include "s32g2.dtsi"
> +#include "s32gxxxa-rdb.dtsi"
>
>  / {
>  	model = "NXP S32G2 Reference Design Board 2 (S32G-VNP-RDB2)";
> diff --git a/arch/arm64/boot/dts/freescale/s32g3.dtsi b/arch/arm64/boot/dts/freescale/s32g3.dtsi
> index 6c572ffe37ca..666e4029e588 100644
> --- a/arch/arm64/boot/dts/freescale/s32g3.dtsi
> +++ b/arch/arm64/boot/dts/freescale/s32g3.dtsi
> @@ -390,6 +390,36 @@ uart1: serial@401cc000 {
>  			status = "disabled";
>  		};
>
> +		i2c0: i2c@401e4000 {
> +			compatible = "nxp,s32g3-i2c",
> +				     "nxp,s32g2-i2c";
> +			reg = <0x401e4000 0x1000>;
> +			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clks 40>;
> +			clock-names = "ipg";
> +			status = "disabled";
> +		};
> +
> +		i2c1: i2c@401e8000 {
> +			compatible = "nxp,s32g3-i2c",
> +				     "nxp,s32g2-i2c";
> +			reg = <0x401e8000 0x1000>;
> +			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clks 40>;
> +			clock-names = "ipg";
> +			status = "disabled";
> +		};
> +
> +		i2c2: i2c@401ec000 {
> +			compatible = "nxp,s32g3-i2c",
> +				     "nxp,s32g2-i2c";
> +			reg = <0x401ec000 0x1000>;
> +			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clks 40>;
> +			clock-names = "ipg";
> +			status = "disabled";
> +		};
> +
>  		uart2: serial@402bc000 {
>  			compatible = "nxp,s32g3-linflexuart",
>  				     "fsl,s32v234-linflexuart";
> @@ -398,6 +428,26 @@ uart2: serial@402bc000 {
>  			status = "disabled";
>  		};
>
> +		i2c3: i2c@402d8000 {
> +			compatible = "nxp,s32g3-i2c",
> +				     "nxp,s32g2-i2c";
> +			reg = <0x402d8000 0x1000>;
> +			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clks 40>;
> +			clock-names = "ipg";
> +			status = "disabled";
> +		};
> +
> +		i2c4: i2c@402dc000 {
> +			compatible = "nxp,s32g3-i2c",
> +				     "nxp,s32g2-i2c";
> +			reg = <0x402dc000 0x1000>;
> +			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clks 40>;
> +			clock-names = "ipg";
> +			status = "disabled";
> +		};
> +
>  		usdhc0: mmc@402f0000 {
>  			compatible = "nxp,s32g3-usdhc",
>  				     "nxp,s32g2-usdhc";
> diff --git a/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts b/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
> index 828e353455b5..5f8739c068c6 100644
> --- a/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
> +++ b/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
> @@ -8,6 +8,7 @@
>  /dts-v1/;
>
>  #include "s32g3.dtsi"
> +#include "s32gxxxa-rdb.dtsi"
>
>  / {
>  	model = "NXP S32G3 Reference Design Board 3 (S32G-VNP-RDB3)";
> @@ -39,6 +40,14 @@ &uart1 {
>  	status = "okay";
>  };
>
> +&i2c4 {
> +	ina231@40 {
> +		compatible = "ti,ina231";
> +		reg = <0x40>;
> +		shunt-resistor = <1000>;
> +	};
> +};
> +
>  &usdhc0 {
>  	pinctrl-names = "default", "state_100mhz", "state_200mhz";
>  	pinctrl-0 = <&pinctrl_usdhc0>;
> diff --git a/arch/arm64/boot/dts/freescale/s32gxxxa-evb.dtsi b/arch/arm64/boot/dts/freescale/s32gxxxa-evb.dtsi
> new file mode 100644
> index 000000000000..a44eff28073a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/s32gxxxa-evb.dtsi
> @@ -0,0 +1,150 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * Copyright 2024 NXP
> + *
> + * Authors: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> + *          Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
> + *          Larisa Grigore <larisa.grigore@nxp.com>
> + */
> +
> +&pinctrl {
> +	i2c0_pins: i2c0-pins {
> +		i2c0-grp0 {
> +			pinmux = <0x101>, <0x111>;
> +			drive-open-drain;
> +			output-enable;
> +			input-enable;
> +			slew-rate = <133>;
> +		};
> +
> +		i2c0-grp1 {
> +			pinmux = <0x2352>, <0x2362>;
> +		};
> +	};
> +
> +	i2c0_gpio_pins: i2c0-gpio-pins {
> +		i2c0-gpio-grp0 {
> +			pinmux = <0x100>, <0x110>;
> +			drive-open-drain;
> +			output-enable;
> +			input-enable;
> +			slew-rate = <133>;
> +		};
> +
> +		i2c0-gpio-grp1 {
> +			pinmux = <0x2350>, <0x2360>;
> +		};
> +	};
> +
> +	i2c1_pins: i2c1-pins {
> +		i2c1-grp0 {
> +			pinmux = <0x131>, <0x141>;
> +			drive-open-drain;
> +			output-enable;
> +			input-enable;
> +			slew-rate = <133>;
> +		};
> +
> +		i2c1-grp1 {
> +			pinmux = <0x2cd2>, <0x2ce2>;
> +		};
> +	};
> +
> +	i2c1_gpio_pins: i2c1-gpio-pins {
> +		i2c1-gpio-grp0 {
> +			pinmux = <0x130>, <0x140>;
> +			drive-open-drain;
> +			output-enable;
> +			input-enable;
> +			slew-rate = <133>;
> +		};
> +
> +		i2c1-gpio-grp1 {
> +			pinmux = <0x2cd0>, <0x2ce0>;
> +		};
> +	};
> +
> +	i2c2_pins: i2c2-pins {
> +		i2c2-grp0 {
> +			pinmux = <0x151>, <0x161>;
> +			drive-open-drain;
> +			output-enable;
> +			input-enable;
> +			slew-rate = <133>;
> +		};
> +
> +		i2c2-grp1 {
> +			pinmux = <0x2cf2>, <0x2d02>;
> +		};
> +	};
> +
> +	i2c2_gpio_pins: i2c2-gpio-pins {
> +		i2c2-gpio-grp0 {
> +			pinmux = <0x150>, <0x160>;
> +			drive-open-drain;
> +			output-enable;
> +			input-enable;
> +			slew-rate = <133>;
> +		};
> +
> +		i2c2-gpio-grp1 {
> +			pinmux = <0x2cf0>, <0x2d00>;
> +		};
> +	};
> +
> +	i2c4_pins: i2c4-pins {
> +		i2c4-grp0 {
> +			pinmux = <0x211>, <0x222>;
> +			drive-open-drain;
> +			output-enable;
> +			input-enable;
> +			slew-rate = <133>;
> +		};
> +
> +		i2c4-grp1 {
> +			pinmux = <0x2d43>, <0x2d33>;
> +		};
> +	};
> +
> +	i2c4_gpio_pins: i2c4-gpio-pins {
> +		i2c4-gpio-grp0 {
> +			pinmux = <0x210>, <0x220>;
> +			drive-open-drain;
> +			output-enable;
> +			input-enable;
> +			slew-rate = <133>;
> +		};
> +
> +		i2c4-gpio-grp1 {
> +			pinmux = <0x2d40>, <0x2d30>;
> +		};
> +	};
> +};
> +
> +&i2c0 {
> +	pinctrl-names = "default", "gpio";
> +	pinctrl-0 = <&i2c0_pins>;
> +	pinctrl-1 = <&i2c0_gpio_pins>;
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	pinctrl-names = "default", "gpio";
> +	pinctrl-0 = <&i2c1_pins>;
> +	pinctrl-1 = <&i2c1_gpio_pins>;
> +	status = "okay";
> +};
> +
> +&i2c2 {
> +	pinctrl-names = "default", "gpio";
> +	pinctrl-0 = <&i2c2_pins>;
> +	pinctrl-1 = <&i2c2_gpio_pins>;
> +	status = "okay";
> +};
> +
> +&i2c4 {
> +	pinctrl-names = "default", "gpio";
> +	pinctrl-0 = <&i2c4_pins>;
> +	pinctrl-1 = <&i2c4_gpio_pins>;
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/freescale/s32gxxxa-rdb.dtsi b/arch/arm64/boot/dts/freescale/s32gxxxa-rdb.dtsi
> new file mode 100644
> index 000000000000..50fe6aaa1605
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/s32gxxxa-rdb.dtsi
> @@ -0,0 +1,126 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * Copyright 2024 NXP
> + *
> + * Authors: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> + *          Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
> + *          Larisa Grigore <larisa.grigore@nxp.com>
> + */
> +
> +&pinctrl {
> +	i2c0_pins: i2c0-pins {
> +		i2c0-grp0 {
> +			pinmux = <0x1f2>, <0x201>;
> +			drive-open-drain;
> +			output-enable;
> +			input-enable;
> +			slew-rate = <133>;
> +		};
> +
> +		i2c0-grp1 {
> +			pinmux = <0x2353>, <0x2363>;
> +		};
> +	};
> +
> +	i2c0_gpio_pins: i2c0-gpio-pins {
> +		i2c0-gpio-grp0 {
> +			pinmux = <0x1f0>, <0x200>;
> +			drive-open-drain;
> +			output-enable;
> +			input-enable;
> +			slew-rate = <133>;
> +		};
> +
> +		i2c0-gpio-grp1 {
> +			pinmux = <0x2350>, <0x2360>;
> +		};
> +	};
> +
> +	i2c2_pins: i2c2-pins {
> +		i2c2-grp0 {
> +			pinmux = <0x151>, <0x161>;
> +			drive-open-drain;
> +			output-enable;
> +			input-enable;
> +			slew-rate = <133>;
> +		};
> +
> +		i2c2-grp1 {
> +			pinmux = <0x2cf2>, <0x2d02>;
> +		};
> +	};
> +
> +	i2c2_gpio_pins: i2c2-gpio-pins {
> +		i2c2-gpio-grp0 {
> +			pinmux = <0x2cf0>, <0x2d00>;
> +		};
> +
> +		i2c2-gpio-grp1 {
> +			pinmux = <0x150>, <0x160>;
> +			drive-open-drain;
> +			output-enable;
> +			input-enable;
> +			slew-rate = <133>;
> +		};
> +	};
> +
> +	i2c4_pins: i2c4-pins {
> +		i2c4-grp0 {
> +			pinmux = <0x211>, <0x222>;
> +			drive-open-drain;
> +			output-enable;
> +			input-enable;
> +			slew-rate = <133>;
> +		};
> +
> +		i2c4-grp1 {
> +			pinmux = <0x2d43>, <0x2d33>;
> +		};
> +	};
> +
> +	i2c4_gpio_pins: i2c4-gpio-pins {
> +		i2c4-gpio-grp0 {
> +			pinmux = <0x210>, <0x220>;
> +			drive-open-drain;
> +			output-enable;
> +			input-enable;
> +			slew-rate = <133>;
> +		};
> +
> +		i2c4-gpio-grp1 {
> +			pinmux = <0x2d40>, <0x2d30>;
> +		};
> +	};
> +};
> +
> +&i2c0 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;

I remember I have said "#address-cells" and "#size-cells" should be in
dtsi to avoid copy it at each board dts file.

Frank

> +	pinctrl-names = "default", "gpio";
> +	pinctrl-0 = <&i2c0_pins>;
> +	pinctrl-1 = <&i2c0_gpio_pins>;
> +	status = "okay";
> +
> +	pcal6524: gpio-expander@22 {
> +		compatible = "nxp,pcal6524";
> +		reg = <0x22>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +	};
> +};
> +
> +&i2c2 {
> +	pinctrl-names = "default", "gpio";
> +	pinctrl-0 = <&i2c2_pins>;
> +	pinctrl-1 = <&i2c2_gpio_pins>;
> +	status = "okay";
> +};
> +
> +&i2c4 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	pinctrl-names = "default", "gpio";
> +	pinctrl-0 = <&i2c4_pins>;
> +	pinctrl-1 = <&i2c4_gpio_pins>;
> +	status = "okay";
> +};
> --
> 2.45.2
>

