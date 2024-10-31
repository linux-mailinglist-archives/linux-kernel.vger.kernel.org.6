Return-Path: <linux-kernel+bounces-391278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD38E9B84AC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C2D5283B3F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043821CC16B;
	Thu, 31 Oct 2024 20:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WQ2DHxEm"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2079.outbound.protection.outlook.com [40.107.22.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753401B3B2E
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 20:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730408046; cv=fail; b=CvAIsTGpveFmK6QByogTOYQuTuTWBZ2UFm4bafbEEDvsCoqkXjLGhf3UCbMtKoKJILmb6ElY1j5Cn1Z4bAfgcWgzrXBtulhRTEITqdULkNME2QWoFDmE48gD9CQUhb1duu6gL9WlBV0uUTT7F+gPiXmSIjldPVX4BjD/j59SYos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730408046; c=relaxed/simple;
	bh=JC/rVaHCly3fhsq5f7KH0mE3kQeoGnsFzUUHT3l5fqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QUEEMnolaTF9dUdqbBFSETnsF9E3TVmtTFjuFQsuCOHjNZNGFI/Wikl3jmuW28ZHoO06oKc73qRiPzgPv1pCnsxQS5fhJIlDJqidJQHx1juVih0J3Et37QuBihtoV1S73JAXEjRhvcK/5vnpLgouI+8YDReuT553sbPl0RfgLOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WQ2DHxEm; arc=fail smtp.client-ip=40.107.22.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0RI8KzJaQZNcFsjuwHBRX8sf97TNRgBg+kYxk/Axy5aveqLDqB56DdIT2XFO7SfZ82kkxDrIiqxi1C0EQNX3EoVQ9YBuHQmNRtsaqtrVVpPSnMwuaercZhuE0iF+GLieLQAO+gyhng50wbKc9dvJ+OT5uOca6Edlyhh/zZJ1f9D4i6xs+pRxb8vJiPV2OmyIw7f+0l2eesjZNkR/dGxID4URdF/dFsVLPJHo6WQKmVtvJibkJ1RUzUg2DpiPrV12Gg4Ibcxuuf3wse8Uw7aSjI0J3+5SElGKFfxXjvkGolJKiuVujjiqgj/1+Ig5DhA1R/nvsbdPI5s3ZsPzv5mOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TfJg/OTzZ6JjzT4yUQl6uT3zr7x16Ej9SR+Ys+a3+pw=;
 b=MKjTDJBvlKblU7M2LCozHDvx0IK5SzMtmpKb+EMiJdMwyMzmRcsPidbHfvYREMcPxPsJsAdLwavlyVqE6dIo5CNkRWtc2grLC16nrZ2QZ5OVZluhK3CtiBwi1Hz+fbRmOEsyy/ZpCvOQ6M+RBieyXm26JzdsfIbU0CgiboYFgB1pVdETk+C8+T7czaNbciqDLrjkI9MWd3qFvQoKQkxG3EVoPzOgcYKxu7jdMaq2wp0xyqwso79kzI2bMx1RxtMJ/DuN+y3D62E9iNlNpIA5vXZhcrKIb29loHJrkO9TMMvvmlrvruFqfcLxrTDHyMb08OlHd7TCBwbieLOjQ/dmew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfJg/OTzZ6JjzT4yUQl6uT3zr7x16Ej9SR+Ys+a3+pw=;
 b=WQ2DHxEmkplIUFDYn+Jiyq/k3NbeLAYd7Y4Muavkt2ew6PFz7ZpbgDqZZ89dNR7aKMN2p/JHUDjNq5VXeYL38JhlUVuOl6NeWJRquKOBTyAAGGAmpphd48SOQUJpHtH9jzkBPxr+vhoijD7ZSD4Gs/LK1pUlfYTvi3DvBIAkElZh1BtnmufZaBaw+MKLBQuPsrZ1Av9CE+Hi0dif8YgL8LTvVd1ndtoRmKmNirzwrJRnuVofz9kgql5j1MBxtjIh4l7wqOpOeWs+QqxitebpJMjmyzs2+AugftlfuPOuJ5Rtg/fymlTQ/Q2nLq+yJfTZc3ogeoYlVkiG+ZBiSpu6OQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7676.eurprd04.prod.outlook.com (2603:10a6:10:20e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 20:53:55 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 20:53:55 +0000
Date: Thu, 31 Oct 2024 16:53:46 -0400
From: Frank Li <Frank.li@nxp.com>
To: mtk25126 <defa.li@mediatek.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
	mingchang.jia@mediatek.com, yuhan.wei@mediatek.com,
	hao.lin@mediatek.com
Subject: Re: [PATCH] i3c: Remove redundant lock in i3c_device_uevent
Message-ID: <ZyPuWh6+aXZjApjq@lizhi-Precision-Tower-5810>
References: <20241029020950.31053-1-defa.li@mediatek.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029020950.31053-1-defa.li@mediatek.com>
X-ClientProxiedBy: SJ0PR13CA0134.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7676:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c4fb8b1-60dd-4115-e39b-08dcf9ee2203
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sjmergGOBUmUfkzMXJXDgL9TrhAezOya2fosysXIa+mp8DmO6o44GBC2Y4Os?=
 =?us-ascii?Q?KZ89hD3Rri0ITGzqRbywdOQwHpaYwn0nYBPbYTw1yem28bUShf0V6vsrs/Wu?=
 =?us-ascii?Q?aZMzjvZviHBzczGHsbgaKntZ61LYqt7UGGGTcoWWqjkn6ESKxDX1EFkqeH0l?=
 =?us-ascii?Q?ep4f8f+uF9yajj1IWCN4byv8b9emF9nRn0Qa/lj4fDx31Im3jbPDX6/TgoN8?=
 =?us-ascii?Q?tOgaYD8G0PwnAI+L/S6mZk5tjFvPR+lDBYnBaZ6R79BhcxssLmed0v2/LGRE?=
 =?us-ascii?Q?C5wjSkK14eVWHVyIMbro3O/rudUS+XMtB/k/rQ9/4F4L0iwWpJuCXftQZzb2?=
 =?us-ascii?Q?demi45NKahAshIZE0MFxH4y9XnvStbiAZkew6aKxprxBy3/9XCOPyilw4l8/?=
 =?us-ascii?Q?KNNvliRYP6MaIJD4pJ4kmCYD4njGQzJ/nAKUjCf/BVFitt+EZSxkYBW75JJn?=
 =?us-ascii?Q?U/fSK065MKChr2DOaqq9xHwK7YaxcFoidRo+kN2cx0/AEhxP9cGllwGUoiQ2?=
 =?us-ascii?Q?tmXpC7NGSSKtq+3Pw1xZrpzrXFwsWVMmSWmCxRuKbJ7puXeM7LdiQacRgtay?=
 =?us-ascii?Q?nTmD5vG0ZhWBaPzwr8k/d0l/c3pr65GFchaSgd/DFPTi9anJLDoopFu0HY8l?=
 =?us-ascii?Q?xIY7KdtKkjnYutpeHM2P+PKgFBcxL9JJ58YPcK7IB3hvtFPW6dc3frdi3808?=
 =?us-ascii?Q?j7V8eT37qtWEZe6FMOtgxZKVWsL73raWjUCBMO8VPJn0Necomif72bJPDL9c?=
 =?us-ascii?Q?lDBGXP6l1s1nC/d6qoOKY1DyHVPHkFsOaf15Jbtgn6MVpZMUO3RrHKTwLHDe?=
 =?us-ascii?Q?yxb/7d+qekbCDFpeyA756F8NEPmLY28ykfqphU1riBHxXJBRNF3S2bfFykiN?=
 =?us-ascii?Q?xAIcXimtDeG0HMlsm/gUbXtWGfBjyvfQ/ov+Crk62OgFT82gxaaAxknX8qpX?=
 =?us-ascii?Q?WUxoJ1AzdYT1DbHiF6Kv4uWq0ozrmkatnEbY+Z6isqhke1u2X55tSivQnFCI?=
 =?us-ascii?Q?/fxa2yETGBjJKfmDTgVucQtM86kQs2DDSdBxMQecLtnBU4Cmx1KTB//3Cqdw?=
 =?us-ascii?Q?QAoyhGNqth9qwpHMc7WITImqHLwmvtyJu4+r+07zoT1tgw7VlI21ewpF/x3d?=
 =?us-ascii?Q?vPQC7YpnxfmEz5yDr0L4aYUi3gGR/QWCule4zXtBzOxntHfStqL5+wAD/BDq?=
 =?us-ascii?Q?qRwJ+w/D4kX3Z/qs+DfmFDqxZho2TsiUZOQlliZBdqyFMIpyU9kCl66Mp71Y?=
 =?us-ascii?Q?RpYx40RoZ38fJN0giDGIdQELaiVoR5dJOy5+S7WAa2gTRf29OplgZlOoG4tu?=
 =?us-ascii?Q?rjBPsJUmoVmHzJjBLESRsEYx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KLetaskONARInh9MwxWJRR4ZhypGNCuVQ1mHwdqgeK72nQP4+jrPn3KnhN3U?=
 =?us-ascii?Q?jD9t4ihqnkJoSEIwS9QTmpGYcsUZgu5yrLMd5op6WzBb5wpDcxjxqWGNGG7c?=
 =?us-ascii?Q?KJ+fJDFeQQuwfSQTgELTpL0wcREaZZ296BjNjaH1VNPD7Dw7goY4yG4yF2yG?=
 =?us-ascii?Q?85K6/R/Tu2WEBtKSAYvVVoUKWb5Ldwok1p1H8/xDzYrWzX3Syr+c2vySWGVl?=
 =?us-ascii?Q?zgO5pFIaVh5DCvuuRyjf0cbozu1j3bg+UXEbxga3uzh9LeBC6g/wtOUU2YID?=
 =?us-ascii?Q?B27OuLwBGMAGfXVIwMLf1g5RiiCiDOa/bOZ+h4JhuWVasdLDghreK1CzDrdl?=
 =?us-ascii?Q?n9sPmHyYHhGTjs9LOC18x+Z34hOqc7dtoFpMqTgvwH5HAy11PLeyEjwZl94+?=
 =?us-ascii?Q?JtVNjXkHz6coJfn2+8mbJU+k47MtQhft2OTT6smUpSJqaFWfbUg6bOh/YbSB?=
 =?us-ascii?Q?JkercUlnw8vxcAUL566AF4Erf4TjVoXDN6YYfStfJnIC262JJmR6p19hs4Sr?=
 =?us-ascii?Q?n3vTC/lS4tUgWMAjZqwz6QEjuJSa0woCKiWEnm99u9zZlGfeYW4uECRhR84d?=
 =?us-ascii?Q?lPrjaqihJPl2gF9+rzsVQdaztQCEr/9kx2wqDiEyU4BGr3GBv8JUzXVRr3JX?=
 =?us-ascii?Q?LzfY3lhqwL4b1kxsqY3RzTlkvQbVvVEfT6f3vT5CWCSBew72UQpbSlINSCQP?=
 =?us-ascii?Q?E0KL6fK+rPDO2Govyy+H1PrY1ov0p5u7B0c2z9bHSOdLOpzQdSbcK1R0QTdV?=
 =?us-ascii?Q?/W/w4eSSGdLqqAPJ7cS2chOOBWenmbCUpx68GmKAZ68WLcUz3UFSTmvdbDtf?=
 =?us-ascii?Q?j5MATJ058a0hq8sQmdUt63c8g8bPWB2ZjIr45eyALjQCc5FmhHC6SFMckl9Z?=
 =?us-ascii?Q?ZAIqbvkJkq7mYj1Ff1GMUj8lK4gJfRNyh1g4v+WxKbi1nQRjGtGhgkLl+FCe?=
 =?us-ascii?Q?2p5U0AuvmBlyobnI/nMGfXHwCr2tQZZRFshBw00PVg+lPYYIT11oTqrvHCai?=
 =?us-ascii?Q?59E6d7Bw86l/vYAqqKPoTGQfpM/Eytu/rBSp9xypjwFihl7ezNpZ3ur5qvGt?=
 =?us-ascii?Q?hNmyTXq83PJGGwFfcuDeojaPPt4BPnedtS8qYGyEpqlsyhrOouS0NXIKz3PD?=
 =?us-ascii?Q?OkCC5bxne+CHo6k/CQF8gkhj3Y3YskYlrsHtZcDf94/UkD3mBl7a+Kh9NjsF?=
 =?us-ascii?Q?Vm7qzsMcL05fC3WA25IRwH32qhdxAo1n4XcV+rERD6N3XuYG7NmGY9pwKVAk?=
 =?us-ascii?Q?geWY0dZ6edeeGbPewSpPTN7wpGMHgGPTWkYOyiOIKl6gil43nEROPEUAUiMs?=
 =?us-ascii?Q?N74jq/Z2UdPu5IJTUKb63O0JGRPIx/Q0Ho+B45gC5vZ87Cwjpctp9MWbWy7n?=
 =?us-ascii?Q?9YCJuYAK4MDgKMkCLIzqvoRV6E95xgaJoROuPE62TKtKus8HThM0OLxW4bs1?=
 =?us-ascii?Q?x1qARf12dO/qdIEM/31Xk+BtkqHIIbFQZm/B4a4zaiG/k4x8bj+y85xhSo7X?=
 =?us-ascii?Q?m0Lup2hruFfeXuNn0nbrlCKj3Uxxt55oSofjuWYZztUZNXEpHbaR4su9yj/O?=
 =?us-ascii?Q?8DV8nNMCOAHVdxcDvTxw7kKYs6WSARy1zN+dK4jC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c4fb8b1-60dd-4115-e39b-08dcf9ee2203
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 20:53:55.0209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ufblpoTbEGp+Ix0M6/1e+/WG6XR6HPiOklgeStIw2KN73IlznU56btAW8tCQD5jnZvrWM19tWu8Wr2xiNgaKBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7676

Your patch have not remove "lock", just use cached data i3cdev->desc->info
instead of call i3c_device_get_info().

So title should like

Use i3cdev->desc->info instead of call i3c_device_get_info() to avoid deadlock

On Tue, Oct 29, 2024 at 10:09:40AM +0800, mtk25126 wrote:
> We encountered the following lockdep warning.
> The i3c_master_register function recursively acquires &i3cbus->lock twice,
> which may cause a deadlock.

A deadlock may happen since the i3c_master_register() acquires
&i3cbus->lock twice. See below log.

According to your dump message, it should happen every time.
>
> Remove the logic of obtaining i3cbus->lock when using the i3c_device_uevent
> function to obtain the i3c_device_info structure.

Use i3cdev->desc->info instead of call i3c_device_info() to avoid lock
twice.

>
> ============================================
> WARNING: possible recursive locking detected
> 6.11.0-mainline
> --------------------------------------------
> init/1 is trying to acquire lock:
> f1ffff80a6a40dc0 (&i3cbus->lock){++++}-{3:3}, at: i3c_bus_normaluse_lock
>
> but task is already holding lock:
> f1ffff80a6a40dc0 (&i3cbus->lock){++++}-{3:3}, at: i3c_master_register
>
> other info that might help us debug this:
>  Possible unsafe locking scenario:
>
>        CPU0
>        ----
>   lock(&i3cbus->lock);
>   lock(&i3cbus->lock);
>
>  *** DEADLOCK ***
>
>  May be due to missing lock nesting notation
>
> 2 locks held by init/1:
>  #0: fcffff809b6798f8 (&dev->mutex){....}-{3:3}, at: __driver_attach
>  #1: f1ffff80a6a40dc0 (&i3cbus->lock){++++}-{3:3}, at: i3c_master_register
>
> stack backtrace:
> CPU: 6 UID: 0 PID: 1 Comm: init
> Call trace:
>  dump_backtrace+0xfc/0x17c
>  show_stack+0x18/0x28
>  dump_stack_lvl+0x40/0xc0
>  dump_stack+0x18/0x24
>  print_deadlock_bug+0x388/0x390
>  __lock_acquire+0x18bc/0x32ec
>  lock_acquire+0x134/0x2b0
>  down_read+0x50/0x19c
>  i3c_bus_normaluse_lock+0x14/0x24
>  i3c_device_get_info+0x24/0x58
>  i3c_device_uevent+0x34/0xa4
>  dev_uevent+0x310/0x384
>  kobject_uevent_env+0x244/0x414
>  kobject_uevent+0x14/0x20
>  device_add+0x278/0x460
>  device_register+0x20/0x34
>  i3c_master_register_new_i3c_devs+0x78/0x154
>  i3c_master_register+0x6a0/0x6d4
>  mtk_i3c_master_probe+0x3b8/0x4d8
>  platform_probe+0xa0/0xe0
>  really_probe+0x114/0x454
>  __driver_probe_device+0xa0/0x15c
>  driver_probe_device+0x3c/0x1ac
>  __driver_attach+0xc4/0x1f0
>  bus_for_each_dev+0x104/0x160
>  driver_attach+0x24/0x34
>  bus_add_driver+0x14c/0x294
>  driver_register+0x68/0x104
>  __platform_driver_register+0x20/0x30
>  init_module+0x20/0xfe4
>  do_one_initcall+0x184/0x464
>  do_init_module+0x58/0x1ec
>  load_module+0xefc/0x10c8
>  __arm64_sys_finit_module+0x238/0x33c
>  invoke_syscall+0x58/0x10c
>  el0_svc_common+0xa8/0xdc
>  do_el0_svc+0x1c/0x28
>  el0_svc+0x50/0xac
>  el0t_64_sync_handler+0x70/0xbc
>  el0t_64_sync+0x1a8/0x1ac
>
> Signed-off-by: mtk25126 <defa.li@mediatek.com>
> ---
>  drivers/i3c/master.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index 6f3eb710a75d..bb8a8bf0c4c7 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -282,7 +282,8 @@ static int i3c_device_uevent(const struct device *dev, struct kobj_uevent_env *e
>  	struct i3c_device_info devinfo;
>  	u16 manuf, part, ext;
>
> -	i3c_device_get_info(i3cdev, &devinfo);
> +	if (i3cdev->desc)
> +		devinfo = i3cdev->desc->info;
>  	manuf = I3C_PID_MANUF_ID(devinfo.pid);
>  	part = I3C_PID_PART_ID(devinfo.pid);
>  	ext = I3C_PID_EXTRA_INFO(devinfo.pid);
> --
> 2.46.0
>
>
> --
> linux-i3c mailing list
> linux-i3c@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-i3c

