Return-Path: <linux-kernel+bounces-529557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06321A427D0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBD6D1888B41
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDAC262803;
	Mon, 24 Feb 2025 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ReCAmaSr"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013009.outbound.protection.outlook.com [52.101.67.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA74318B46C;
	Mon, 24 Feb 2025 16:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740414237; cv=fail; b=IKgBH+MsyXrBBtuPIq1fyusrh2kNuKS32bPfchc0uorNKskWrDJCcvf9EkLS2t0RYIQ/ipkT+WwWH7HzQKwxMX4QSB4+0nohbgMxBMgQaXV86JjSEXZkjIuNACGM0nf9SnuWQe6V8RlqfCKM6Hrf1QZjEYaA0cLJJzPwwZB+W44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740414237; c=relaxed/simple;
	bh=YZ/k11m6AlHTT1Xau3Dx4HBykEks/6ZEgPJZWzNg0Po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y6nupOHLJRbEmIpmUqK+UZUdnkM8B56ib6gADVA6DYNRruLw8WvnHNY0wwmqR6E31YH9xo2j/S6nbGDwK9eFhJfdbvZeor8lHUyTwtGErVbeRbiY/HRAgf3yxA4b3iLhaLIKpP3c7nRylkbhOH8VLB/Ijd2jqzeV7s69oQvew4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ReCAmaSr; arc=fail smtp.client-ip=52.101.67.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uw1ZVnaiQKmi9JvWOJIlSabhPpxkWU6o6dNPjicsa4640hpDquJlC5DvmsdfmZrtWMAt7PTVyK0ddzo77kn6GC9T4mWg0MRyVK0FuUmaVtlo1XrKCX/i8ZgoGmUKQmSzPABEnWcCAX0oNeQaMiWdo/1fVIqqJy4UorCKoFktF4N/0dWSjVdTEqITrBQEt33A7Lod5oxexnNw1MmkIg8Whp25ZmDskY3q4Y3/tKMgUuYOs3M/JWLRhnQIc6fqnY5pzXyH5qGo7RsSqZFRf9fwog3E39cThDZem2F5HZpbsakb5JVkv4cb5CSKHtf8jcYQ01BnUejZqjNL9UQHDuDbLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/B6K4P9b3AHHmbKFocfkfCu6qyTh6jNgpNN6ycLXq3U=;
 b=IlZ2MGajPMVIcoKOp/Dok8pNNWjctzEMkCTgJswclqecMOnwHSdN5ugKndGu1NxKJPm9s+RPwgVPEOPp0YnqetfbVpxKbq8dwSwz6+oHxp0bMmMlvii/wkRVGsTGIl6oZ1rJhVLh/oxwx4hfev81kbc2IHW3Bp9uBNA3XwbkC3X8enut73K2QT7ooNnnAn3t/8y9sEZrWrewGdW3rAV5ITzPl8yslY5bAjzYQEFWQCRUR3H4KhHCBqAl9ubRTZBd2Ogho3dcA7BPZ6KqStjvwtOHDfr371iIhxN5JEl/5XbDck28+JUKHRwYOoGf2xnXGIsRWclIaBNIRNgHhWTw6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/B6K4P9b3AHHmbKFocfkfCu6qyTh6jNgpNN6ycLXq3U=;
 b=ReCAmaSrO0TMplKRlIFaDKzIs8b3437Y7Zf1bzxYEhsa2p4BStW41yqc2aLqHscvGT1iYTrVuse/zgywe6393B/A3qpRdTBr/npltbTItWc4IXE6ad7V+MYqr3cSMKld475RyoclicKcKYubvmV/GO8rZmNjfJpK5hUnq/4zdqpaWLAMv0Kq9qnMaxM47sDDLP9RAUpwHX+Ql0hYXOkzqJop5RlxxLRDynw1mA6kD4f7hQuM4Iz+TsKih9wku0l1aOQsVeeKWxG+W+IHqgqKgAlfk01LykZXF8biN8450OUldm7wLQY4qKPN1iv222gfc6EOqBtbLse82hQYWDglTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9914.eurprd04.prod.outlook.com (2603:10a6:10:4c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Mon, 24 Feb
 2025 16:23:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 16:23:52 +0000
Date: Mon, 24 Feb 2025 11:23:43 -0500
From: Frank Li <Frank.li@nxp.com>
To: Stanley Chu <stanley.chuys@gmail.com>
Cc: miquel.raynal@bootlin.com, alexandre.belloni@bootlin.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com, yschu@nuvoton.com
Subject: Re: [PATCH v4 2/5] i3c: master: svc: Add support for Nuvoton npcm845
 i3c
Message-ID: <Z7ydDyr+/tF8uC6H@lizhi-Precision-Tower-5810>
References: <20250224083908.1880383-1-yschu@nuvoton.com>
 <20250224083908.1880383-3-yschu@nuvoton.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224083908.1880383-3-yschu@nuvoton.com>
X-ClientProxiedBy: BY5PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9914:EE_
X-MS-Office365-Filtering-Correlation-Id: d6a3bf8f-69da-48db-f555-08dd54efa05c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K2/GGg3O2TSNKmhk/TjW4NlsNjdaw6dGsPYpN17hNTs2O3mNq3OyfZj36lt8?=
 =?us-ascii?Q?lvnZ7Vfitjl6HHIHaJZfCKox190sXLUcekRx7N9KB8V+UTMQDsrVVHF6X8r6?=
 =?us-ascii?Q?uHH84AJAwp+ROWH9QLeTD6i/eLnOexjcDChtP2u1A3bTbtPHbCWXs4mPtbnO?=
 =?us-ascii?Q?9okXGBY0k3EmTGOohMF6BhPa4x72vp+K3ZAKLA0QU/tpvPqSe2sYtjNMST+u?=
 =?us-ascii?Q?G8X6o5+tpYQlLLzuM5wGBr+3l89bcouf+nirIu3/dqsWXEMXLqNz5EApJ7Eu?=
 =?us-ascii?Q?hNRWFNkZ7fT8IVjE956uq2FySwcpx7AA5eKSxZIjRgfwp2ySdniqhBdsGUeZ?=
 =?us-ascii?Q?0eJvGmG3Zn7A1TVRngPSNzcp8dBZz4rvMbQp8oME64Q9eKx90lHuuA73YQKF?=
 =?us-ascii?Q?YcK2JV2tTprRFpPwQ7orQBfVtVIUVqu1BQNBYMqQhN4JylfO3QH0usA681oS?=
 =?us-ascii?Q?z+JsEGg5ynAfvfdl4KGZwYkjmvZsxBPXL2ke5T4Eat0L8kZgwCneIy/2PxxV?=
 =?us-ascii?Q?gpGOS1anQ5JeOhRu5EciLZkSYBec2X5at3CXhcSEzSOmFXdS/l/YDr5cF9aP?=
 =?us-ascii?Q?HMutmBID5etRmmVL97HTd1CqOELaQ4gZlEmCxuEkbwMQVLSFcd9T2d8it7ry?=
 =?us-ascii?Q?+QjlgKmcB1uSUJD32CLN86oUsmUv5OkBBORnGlwtsTg4KDU2ZamROoX5NiO2?=
 =?us-ascii?Q?Yxq8a0Rdd30FQpTTktbTCq1f5tbGzXu7vLgy3PmcvgCk5hgs334/qXRY5FeA?=
 =?us-ascii?Q?hDdErSmQ2ykgH3e/2krY4mppjwkZT3BBctTssRqD7JkEDQ4PUC7nXgkAQoV1?=
 =?us-ascii?Q?mdq7CtrXARy1Xw1C3zSy0z82R9XpPhOLqrGPlchka4PZeJHcVraO0Db19fwB?=
 =?us-ascii?Q?FElseAsvftHOJzFgpjDjiOYe9mDn/bfwyPGNFPEqE35DsnCnHRB10W5JrB5h?=
 =?us-ascii?Q?fL1mz7ekit15buq1ANhPhvIFTpMAndr0uRHNucN71+7SqPW/Ggk6yNnDbcus?=
 =?us-ascii?Q?qe2X6wfX/qCpmPpbj93EKf7Sr5njm1x/NzXv2MXHFLehPK3R00k7G/osPZ9r?=
 =?us-ascii?Q?uppyDOsidMW3XaPHd0hP86g/9S64SUP1F3x5OEQT4clR8kCwlvMLGpC0SO+3?=
 =?us-ascii?Q?MxJoRGwHeZxSQIwJkpwFQE9BMfGQQdNa6k6U3wEJxNYzPuW/LgjKlWRyEzXf?=
 =?us-ascii?Q?eVvUKtSLqBTahBF06gcPY/lhuAZUGJyNZ9fueMjX9g1Ovik4dN6Yr4E/JC8J?=
 =?us-ascii?Q?KO61iH4lXZRGIcjx8LSpWdyOXPZWdJhHZ7nxtI6mF33E0ebW3jSt4nYVAleb?=
 =?us-ascii?Q?4kutoFkZopT4f+4rtWA/QmlBLIgmgGZLAIe+U35IvO34pZT0pBwPkxPUi3u9?=
 =?us-ascii?Q?rflDjEFe/SRQfRQWhjU7BbnK1aUXTwCvLfq5kXElcIiiXbFzkJ2OE66AeUk1?=
 =?us-ascii?Q?XyVzuFbMDFOjjqay5xLcjfwMneARoNGZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NANx6S9YeCzfupWq1TM3piD8L36aQhdYFAhZVbtFVq4THp2wUrlpY1RXO3aq?=
 =?us-ascii?Q?mGSq3ip0w3Jhfqakrkr/jxccjDWfGH7FoF0DOqF29RfajZhnsmoi1N2Xsm7h?=
 =?us-ascii?Q?Jh+xzVx2VKHfSZ+elNpOjPp9MDr3DQlYdkr6iKLI1wvJJ+c1genqBZ4iMbxO?=
 =?us-ascii?Q?Jwqpyn+REeVbyk3+xZLdbLr3SprLL0Hjrb1ocoYMpOdu+Ckt5mKH3w12htyj?=
 =?us-ascii?Q?WVxZAOW3i8ynjLUI5249CilhXT7fkVHFNaATMKJ7miuL+8gQmQBQszA4akOW?=
 =?us-ascii?Q?zfzkJXidakd5NEWC0PsB22zXio+kzfsS1VBF8jEJ3vVSwXwgx4z5l38YSzDT?=
 =?us-ascii?Q?FOxhzJdYLrMbcqX3FtpRwOF/reZ44eASNKwmS9W7RKkegLmZy/BwS0gXwS/+?=
 =?us-ascii?Q?gTv+Ki8Or7cOUmU+BBSacbhftYB+XUiP/YXf8jH4Jxkb17dW6p6z3XgrzP3L?=
 =?us-ascii?Q?9bxnf72dh6bhA06gtCPhiY3rGcvg2iiusFnZQUliA/d2GBgjXMhSY+T2pA+A?=
 =?us-ascii?Q?61u3qIfw6cl5rcXJeLqf0aPUHjOrRyEH650omsk2J9Mvj7BKZA723z3Zcgy8?=
 =?us-ascii?Q?2GKC1WQhGuCpnmbwsPigQ/nXj7dA73HNLgbd+fqndzwqtVxu7PHUTuKmIZRf?=
 =?us-ascii?Q?/4/V9Z+xeUrIB+bDAVB+SpmpAGY85ik0yWw1w0EEZawY3iW0vUhTvo+S1tiT?=
 =?us-ascii?Q?bYLDZlLez0dQ/h0i5ko4E+alAVZvHV7UxF+PrBlB5Z59C7QrWdtmfnlblm0E?=
 =?us-ascii?Q?1wEmQ8wqbN+S9vhWE+fdAPME7hk8bb6UFZ+c2V0kB8KgUtXyVRDq21dZh1M0?=
 =?us-ascii?Q?syWlaD/m63g0MVCd9QUDQUgNs7hk34l9ty1DGrb56rc0yLKVB5ax4TTteuSh?=
 =?us-ascii?Q?C3E4j4lPqiWAhSV28N/Kbfmx6oLTPXkcgQIcNTV+UXSuH9yx0HXkvZmfcG0L?=
 =?us-ascii?Q?vAlrutTcakFNAx4B+TSTERzymPwCUDUT/zxKFCweKkFBJxgUa0Za6/73x+Vt?=
 =?us-ascii?Q?4B6EgUYCHT13E2CojzwM8EeZqn2NNEqKHCFwVew+nQxvqsKQh9qqRcCQK6+B?=
 =?us-ascii?Q?bbS/xSHJy3aVeXRNujm2MEAIf4dvxIIQDp6eaq83AxJL9t4rCVllNp/iPd6Q?=
 =?us-ascii?Q?7v0f90Y98824pa6FBQ//r5c3HteOP1zx9IxLCg8xoTRr8ZIIlulE5RUOIgrk?=
 =?us-ascii?Q?V+DvmpjMAX2ePREZaSxuBVlBCHwl2KWmAOaWr1ZaV9p13q3bDkn3kSHBIhEV?=
 =?us-ascii?Q?4iqKPpbQZAYFRP+y+SeDpiZylwyLXa2LRlJiLjmeyCI1sJGDrRlWgHUsMhEy?=
 =?us-ascii?Q?ybr0g5PtyhV67IC8sc/w7pHNgz8MRwyXntkrhpeUk/0n1VUVhONIwM4cuQdZ?=
 =?us-ascii?Q?bDTEy4yflYV0b3mxW1Ub0HVEK+1AMZS0S9386ZOPkl9CyA7FKDw1BG1LnoNO?=
 =?us-ascii?Q?TfdXb6bx/fbB0KqkrmgCMp4vHWcKqXxQqvCoZfZo5X00STiH8YmXVSTXqPKS?=
 =?us-ascii?Q?xzXPMD67xm+Z2sq1pscSjQhBVe2otBdpIivdfKUFsx1jSG/jnTbPJgDkHsue?=
 =?us-ascii?Q?1Fs1g/7WI2zxnpd1Pbht6yhzkEdAUpcbdE/KuL3f?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a3bf8f-69da-48db-f555-08dd54efa05c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 16:23:52.3329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pL4/uIC8omrAAedDE4RaqDtDNe3wMpAb7zq0vVC71keDmyrIcyawVE84Wmocs6feiHTY6V/wzCjOPjRy6O5bKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9914

On Mon, Feb 24, 2025 at 04:39:05PM +0800, Stanley Chu wrote:
> From: Stanley Chu <yschu@nuvoton.com>
>
> Nuvoton npcm845 SoC uses the same Silvico IP but an older version.
> Add quirks to address the npcm845 specific issues.

It'd better list issue here.

>
> Signed-off-by: Stanley Chu <yschu@nuvoton.com>
> ---
>  drivers/i3c/master/svc-i3c-master.c | 56 +++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index d6057d8c7dec..8834f87a4767 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -32,6 +32,7 @@
>  #define   SVC_I3C_MCONFIG_ODBAUD(x) FIELD_PREP(GENMASK(23, 16), (x))
>  #define   SVC_I3C_MCONFIG_ODHPP(x) FIELD_PREP(BIT(24), (x))
>  #define   SVC_I3C_MCONFIG_SKEW(x) FIELD_PREP(GENMASK(27, 25), (x))
> +#define   SVC_I3C_MCONFIG_SKEW_MASK GENMASK(27, 25)
>  #define   SVC_I3C_MCONFIG_I2CBAUD(x) FIELD_PREP(GENMASK(31, 28), (x))
>
>  #define SVC_I3C_MCTRL        0x084
> @@ -133,6 +134,32 @@
>  #define SVC_I3C_EVENT_IBI	GENMASK(7, 0)
>  #define SVC_I3C_EVENT_HOTJOIN	BIT(31)
>
> +/*
> + * SVC_I3C_QUIRK_FIFO_EMPTY:
> + * I3C HW stalls the write transfer if the transmit FIFO becomes empty,
> + * when new data is written to FIFO, I3C HW resumes the transfer but
> + * the first transmitted data bit may have the wrong value.
> + * Workaround:
> + * Fill the FIFO in advance to prevent FIFO from becoming empty.
> + */
> +#define SVC_I3C_QUIRK_FIFO_EMPTY	BIT(0)
> +/*
> + * SVC_I3C_QUIRK_FLASE_SLVSTART:
> + * I3C HW may generate an invalid SlvStart event when emitting a STOP.
> + * If it is a true SlvStart, the MSTATUS state is SLVREQ.
> + */
> +#define SVC_I3C_QUIRK_FALSE_SLVSTART	BIT(1)
> +/*
> + * SVC_I3C_QUIRK_DAA_CORRUPT:
> + * When MCONFIG.SKEW=0 and MCONFIG.ODHPP=0, the ENTDAA transaction gets
> + * corrupted and results in a no repeated-start condition at the end of
> + * address assignment.
> + * Workaround:
> + * Set MCONFIG.SKEW to 1 before initiating the DAA process. After the DAA
> + * process is completed, return MCONFIG.SKEW to its previous value.
> + */
> +#define SVC_I3C_QUIRK_DAA_CORRUPT	BIT(2)
> +
>  struct svc_i3c_cmd {
>  	u8 addr;
>  	bool rnw;
> @@ -158,6 +185,10 @@ struct svc_i3c_regs_save {
>  	u32 mdynaddr;
>  };
>
> +struct svc_i3c_drvdata {
> +	u32 quirks;
> +};
> +
>  /**
>   * struct svc_i3c_master - Silvaco I3C Master structure
>   * @base: I3C master controller
> @@ -183,6 +214,7 @@ struct svc_i3c_regs_save {
>   * @ibi.tbq_slot: To be queued IBI slot
>   * @ibi.lock: IBI lock
>   * @lock: Transfer lock, protect between IBI work thread and callbacks from master
> + * @drvdata: Driver data
>   * @enabled_events: Bit masks for enable events (IBI, HotJoin).
>   * @mctrl_config: Configuration value in SVC_I3C_MCTRL for setting speed back.
>   */
> @@ -214,6 +246,7 @@ struct svc_i3c_master {
>  		spinlock_t lock;
>  	} ibi;
>  	struct mutex lock;
> +	const struct svc_i3c_drvdata *drvdata;
>  	u32 enabled_events;
>  	u32 mctrl_config;
>  };
> @@ -230,6 +263,27 @@ struct svc_i3c_i2c_dev_data {
>  	struct i3c_generic_ibi_pool *ibi_pool;
>  };
>
> +const struct svc_i3c_drvdata npcm845_drvdata = {
> +	.quirks = SVC_I3C_QUIRK_FIFO_EMPTY | SVC_I3C_QUIRK_FALSE_SLVSTART
> +		| SVC_I3C_QUIRK_DAA_CORRUPT,
> +};
> +
> +static bool svc_has_quirk(struct svc_i3c_master *master, u32 quirk)
> +{
> +	if (!master->drvdata)
> +		return false;

You's better add drvdata for exist one to keep consistent for all compatibe
string.

> +
> +	if ((master->drvdata->quirks & quirk) == SVC_I3C_QUIRK_DAA_CORRUPT) {
> +		if (master->mctrl_config &
> +		    (SVC_I3C_MCONFIG_SKEW_MASK | SVC_I3C_MCONFIG_ODHPP(1)))
> +			return false;

This helper function should only check quirk, you addtional check for
mctrl_config, which exceed this function scope.  Or you add new helper
funciton check daa_corrupt only, such as  svs_has_daa_corrupt() ?

> +		else
> +			return true;
> +	}
> +
> +	return (master->drvdata->quirks & quirk);
> +}
> +
>  static inline bool is_events_enabled(struct svc_i3c_master *master, u32 mask)
>  {
>  	return !!(master->enabled_events & mask);
> @@ -1868,6 +1922,7 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
>  	}
>
>  	platform_set_drvdata(pdev, master);
> +	master->drvdata = of_device_get_match_data(dev);
>
>  	pm_runtime_set_autosuspend_delay(&pdev->dev, SVC_I3C_PM_TIMEOUT_MS);
>  	pm_runtime_use_autosuspend(&pdev->dev);
> @@ -1960,6 +2015,7 @@ static const struct dev_pm_ops svc_i3c_pm_ops = {
>
>  static const struct of_device_id svc_i3c_master_of_match_tbl[] = {
>  	{ .compatible = "silvaco,i3c-master-v1"},

silcaco_default_drvdata = {};
	.compatible = &silcaco_default_drvdata;


> +	{ .compatible = "nuvoton,npcm845-i3c", .data = &npcm845_drvdata },
>  	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, svc_i3c_master_of_match_tbl);
> --
> 2.34.1
>

