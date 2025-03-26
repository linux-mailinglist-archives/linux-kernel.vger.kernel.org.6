Return-Path: <linux-kernel+bounces-577317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BA3A71B75
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 553503B75B1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDD61F4CA3;
	Wed, 26 Mar 2025 16:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="i+rPXoDD"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2053.outbound.protection.outlook.com [40.107.22.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998341E51E4;
	Wed, 26 Mar 2025 16:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743004875; cv=fail; b=ASebnk31/8jN0lqAthGux9X5XWE8wk8cr9usDuIvbA8cB4M+zI663PVNyrm8uros0mCggbqDYihTjw87mkyeOa/bni4zMDTaaczyMYlenqrnVyvpkWPYIVTpA1kbMs1a/TMGQ9J86YrUCesDfj/x+P0bOjV0pS++XE5ftIKtJf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743004875; c=relaxed/simple;
	bh=79/d+QoFlIYqvIB5Jo4/O8w6BXpYiyuzPajBfIG0x4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qEVm9YyDq7yGokvr0ZtifsZolcQv4gyBr/1Ep+ZftNl16BFvfrMHQ6MVAL1nkR6pedY502BqWs64N2B8q484NTmRBEFq1lVCFFB6vV0qVROUc3DO8nR41ml/RXuiIzUyuMLMY8XVqlF6BxDkG8KxZTFYLnwA2gweUeiWvI3NOPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=i+rPXoDD; arc=fail smtp.client-ip=40.107.22.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SddM3levgWQ1lupS48DccJXHMpgD9gsAPQ9HMStwET+PMGMvOCtMJlyrgafzevT/HRauOUYIsxXj1S4FuNM/+ieJu2MAKgnh+6p0AUcaFQJut80QLdIQNONP+a5jl/4IMKMq7DixUpP/IXRz02Dp55w2tPLk2sDPBX15EVuxWhrwkNn0UKCPN39ZQP3X9kMZbiRDMuGAkbBqDqa//qJPJdntpDx6iHT0JBLPPiG9uqdiH4aMl+GrVJr76w4d+7DeXWH+QWlRslqf8kESS8wu1RWNnkXE6vwH+3Tqe0zL/O+MVYjkRPmSPQ6IDvnrkCYzu7K+8cL9l6HkTk/PTuNH0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwGyUuSi+wlAqEGVg81Vs7y18xnMSxl9JJ45ukMXEoE=;
 b=LrBKIjAM0AM5q/orAFIhuLiGEqJjmlImlv1/URVe8dn8XZKuvz+vAwQPgabe1zYa+aviWdFHS9WEIItTIiTm0pR3nu3RzBwJ+IsDwwOQcUcxjqZ5VERhBY/T2tsXmGd95h7UqU/5duOCfl7XweKyfALxKMTGRfXtlqliqj9wYTITXfZu6Xevg0XzJzG5yUK3r5DRz5VOZq+iWDnRG9z0yNDEaY5rgYUg7AWzTF9RK136o6ZuQcHurfHxKSysM2b/7ZGJh1STsVckf+3o7NW7mvZXjUrFEZkIsCdcXUJoinrbucKv7TIJlQeruCdFSgCv6Z7YpX6qZSlYrzZPGPkSlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwGyUuSi+wlAqEGVg81Vs7y18xnMSxl9JJ45ukMXEoE=;
 b=i+rPXoDDD8aQeFI05meHvO3HJe1x/SyEfaaDRHYy+hFHbLRuBVW0FCBFkrpb1VcFqwezcxlgA8cL7wEYuk9P8IerilvZy68zSo1ydvOappVlWDvIGgVtluC2cH9BIlHcKnfpt/GLlrUM/vjnHCYZlLhn1iDgBae4j1Ggb/Wffv9lwHToZwfLHw4h4idby976hvHPkCazqbcK62zefLQ0gsS4+3biS3iUpmOM+xMfl9sxY66032s6yMt4/R41jPAJLiHuEn++bkkm2Welyl4uqsiMb5qxI1QUuBr6O5dZoGpzTDROtmo+zSnW4nhJbwHGj8K3jj63vt/XLWpxBCPyhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8115.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 16:01:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 16:01:08 +0000
Date: Wed, 26 Mar 2025 12:00:59 -0400
From: Frank Li <Frank.li@nxp.com>
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v14 6/6] firmware: drivers: imx: adds miscdev
Message-ID: <Z+Qku6a+CfI/2shk@lizhi-Precision-Tower-5810>
References: <20250327-imx-se-if-v14-0-2219448932e4@nxp.com>
 <20250327-imx-se-if-v14-6-2219448932e4@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327-imx-se-if-v14-6-2219448932e4@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0143.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8115:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d7a2347-eb36-40dd-26bb-08dd6c7f6ba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X9l+XAzlBxUjSb3WOKRBQzuR0i/0ZvmXUj7B/yUFoLwLIuQlmhYKguf7QiH2?=
 =?us-ascii?Q?S2A2VYFvqgnYMAJfPUD8Vqg63FjuxbSbpq7FK/uKj6RsUQieu1Q9THqbKGy1?=
 =?us-ascii?Q?Bpxc9xdhhRVnB7zpejLXjDYFpdGFlO/qmpck12i/WLEnSMWEkmT1XHwnUa11?=
 =?us-ascii?Q?xUhBTS/dMAPHrQCuX58PMm/XmFzjpMIYFmY/aEkkM6nZSlWSlth/f4ULcqZw?=
 =?us-ascii?Q?SiWjDQihigJi68VLbDlrNk3iMB321FjklbgMlkGovL2qEaLyNwzhJbbFmZBR?=
 =?us-ascii?Q?eyL5zGxzIpG2HqFigs4Lp+t9E3NkwqWRBK5qpggpNlw0WNjLOpmPd8wHpu3A?=
 =?us-ascii?Q?XyQurUSZ5zYeFkH3RLbfAbbzxmBiqZM2vMheWUalm/Nk0lbLdIrrsaEsGtTz?=
 =?us-ascii?Q?XKYry8+3AzvsxOIS3eYzBE9aPS+mb4FPMCltUG+ljogZaLf9AcUO/OgfRJ6H?=
 =?us-ascii?Q?oZottXVZg2S/yEs0G8DzzW4llb1CnUmpIMnahtek3kDxC4S40ftTw7wyVW+c?=
 =?us-ascii?Q?zPiRasPzwzLuWqk7QTYn7wd/cYq1mT3pp6FpEiD/cvQ6BMhzv0JcANuEaCtm?=
 =?us-ascii?Q?6f/Wogq2WJS/WSVfiSLSSL7Khbml9McaLqi91LuPUQlDC3Yd5nui5E4vVKId?=
 =?us-ascii?Q?y/Mlhn51qCISKCwhdtl/CVpzqI+JO14bW6lnpXRzw+DCzIsMwSGrvubpMtM+?=
 =?us-ascii?Q?p26tElEqQG79JA72e5jAt0kSgazRrS9Xs1FPI+5cA9CqfPksYZrJL7122hTB?=
 =?us-ascii?Q?/EpV3g3CXniLBNVpH4ly8HsZKYEQAjoommy7kJypOKIvKp/2RXH11wXanDJA?=
 =?us-ascii?Q?xBrecJR1wip0laqjJp5QiCiyBM2tLx0FrxpDawEZ0BL9OkvyypkzBQWzV/Ol?=
 =?us-ascii?Q?AQa5CWmsf4uXiPwsX+f1fL4GlbYi3iIwZWTOxNdX4cb3IYhsd3LKlk/uNyYl?=
 =?us-ascii?Q?9t5RzJb8kAzEURywu3DAIt2V0O26ntQApEZ+eqagVkG1nFUoWTPlIyZPjAC5?=
 =?us-ascii?Q?KSvVb5lMSGRgkoFIQ34lDwzubcHkKO4OaJ8w6YMx5vY722Zws5LmpeAe9hJS?=
 =?us-ascii?Q?jgUc6HDW4iG2qZKkc4wEht8btT1PrJBgLeoo9oFX2T8r2yJUqXHWX7PlHcKE?=
 =?us-ascii?Q?X+aDrgMMeQ2WmM3pk7qpKudCUvw7ZTqS2Z2YFObZuF35YGtCi1expPiK9TNL?=
 =?us-ascii?Q?AApnWXZo3DvzFXVYLuFVeDSbgx0HcSgSX2kg6ntPoHch3Rx6jyNRfuOyu49d?=
 =?us-ascii?Q?skUwoUdDo7Zyf2xjhU9Qhejh+I5koN0D5oWaXi1gwqxLf8lKX3mM3vr/cH/k?=
 =?us-ascii?Q?7fp25OlkindTu656rKR0i/OPWgN7Gvv/OHykBBGNPW3mts1SSvu7Hh8QYUgJ?=
 =?us-ascii?Q?Ki6zVy/oUhDvQe5d8Jqmdhubqr5cFdT6kDVlPZEbJc1nIs/oaSK5gtIFzwqf?=
 =?us-ascii?Q?5GeKz3ivYPsr/4kg17QmsvSsIw+uPBLOns7zi6SnMMb+7jDUttR/s95M53yq?=
 =?us-ascii?Q?ecQHIVzfgFxkfZQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wc26EYVRF+xbm6UcIP3+vqtdjL60RufDbJAensmfRDxIfBHOGZgpRdl/sTS0?=
 =?us-ascii?Q?VS0MK1b9KZLdf4qIeufIY7pTGpVOP6bIu2n6y0xQEqYCQ7bGvJ0RVH9AybAy?=
 =?us-ascii?Q?WGuw6KBd+o6npKSOUC5MgQfu8gKE0mNjxZHjCEHGzeMbJsyMlHXYEylxRDER?=
 =?us-ascii?Q?k3RLEB3TPJbBrekR+dAKX+m2REFOmRe9mYG4W/ZlQf4uuFAJLUiT7mv2g5kR?=
 =?us-ascii?Q?MG5LfveXSy3sB9HaOgoUyiZGtiFJ4OFXuoVTX76u5QQdqbtr/4a+PYKjMB89?=
 =?us-ascii?Q?+2zg9WVdW+0R+N4MB+g8Ck0sMpW+40Gr5HvSNeegCB7bj8d33YnQgCGFO4IL?=
 =?us-ascii?Q?r5n2PqExAeN/gmyWLLPLxRD8x3+SKfgVz5aCG6SaFMqWPgvPAJ1Mm/J712Ng?=
 =?us-ascii?Q?qVVhVEGs49qrMkcAWhWUvNhpRPf8RoLKyyPSjDBEWh0T+PF1zzuqCOUgtjJf?=
 =?us-ascii?Q?Lx4NwJ2r+O+pbqCYk8bYI+t0OCv0ql7WFzQZtRXoa228f64rkApG4FaYPxD2?=
 =?us-ascii?Q?0T8kYkCee61Ana02abYIhP9ajJd8kTir/x2OKVpqpcJ86Qwz2DCLU6Fy0tGf?=
 =?us-ascii?Q?zDIqW8A36pr0t8vGBTfQ7FqbQp5uHgdLUW1L3dHEM5lPNMv6CFtE4doORY2q?=
 =?us-ascii?Q?LsyhK6vsFIVxiKzCCR5MynoIkEer28xqioDjuMjB+vC9xGfT6yAOl2+qzmyx?=
 =?us-ascii?Q?PEe90RiHAe3lSU+H0GbjWGYQhL6GrsLdGSMr7YLCTencl1cxlEL1xqrE3Qxh?=
 =?us-ascii?Q?If1wpe2+LJLaNDF1Rqg53dZCWO2seYeBB8C8L0PhsZQjfwh/WmxjK1ZzzHDa?=
 =?us-ascii?Q?P/faDcr+8qSov3BcYYGFVtwsaptp/YgdxyeRw2HCV2UgZ/rsYee11CJJ/MzY?=
 =?us-ascii?Q?Orwq/H8T6kXnQeApko/NRDHZ4K5qZAX8BAs51/1Wz0RHK1RqnMpgHsGBn/V5?=
 =?us-ascii?Q?YRobGM4PMSeseMXI9hYTsGWFj12V3mWhoZZ2jqfzqTdLpAKK1LR5jNKWjQba?=
 =?us-ascii?Q?fWcU1bNrUu8CwZLlK7+jS3+35MQQlwxR3Qr9IpW0uBPdymsmfbEfOqwZHhvG?=
 =?us-ascii?Q?tOmQhoE1PzR/7JibBV7IKRQA+azGvyUPNWr4PNaWum0kGQ/IpjupyY5Xe7Qo?=
 =?us-ascii?Q?QKsnqd/1i8C6ZBtS0UpAzfR4LFGbt+cYmm1447GCemmAMjURvMTTaX+nEvZb?=
 =?us-ascii?Q?nG64IorVyTcAz29ObDjumbMP1ucPoPDA54UdzFhxRGYxyeb9QjDn55BDgpBK?=
 =?us-ascii?Q?2Jl41CQUJFnPHX5e9uc5mFD7khw+K9w9nBtwvxi6cbqB1M2ERUHYjuURD4/W?=
 =?us-ascii?Q?i5feT2Nl0sYy+6awA0hVRfMr1hXieB2HJc+j0K8xWuKjJjdJ7sW0KfSXComc?=
 =?us-ascii?Q?FknuM3leVIvTZ/GkT08eA6YeuyvtM89woNPdXrWSsl4QXcp8pHkpJHCodLXF?=
 =?us-ascii?Q?UyS74z5HJlNpQCiEHGubdLRmh+F83ZLt/sfjEo90Y6GxDv7G+mVho4gBAh9C?=
 =?us-ascii?Q?tP5P247nB6siC+IdpgxH18tK2MIaRVZ3QKgaKqEnMgqFzhScsTSPn6Pn+vhh?=
 =?us-ascii?Q?inAH80PQsEclrSv4vldhcbWc2utC1GgXWlB9ccMn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d7a2347-eb36-40dd-26bb-08dd6c7f6ba6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 16:01:08.2657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1hmaefHw8w4KQjay639R4cK13Ln508UJG96g6oVmbNNg/xVzxzZqIjz+LA8YZbkmzmbILkIqGKvIegHF7fHAEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8115

On Thu, Mar 27, 2025 at 12:08:02AM +0530, Pankaj Gupta wrote:
> Adds the driver for communication interface to secure-enclave,
> for exchanging messages with NXP secure enclave HW IP(s) like
> EdgeLock Enclave from:
> - User-Space Applications via character driver.
>
> ABI documentation for the NXP secure-enclave driver.
>
> User-space library using this driver:
> - i.MX Secure Enclave library:
>   -- URL: https://github.com/nxp-imx/imx-secure-enclave.git,
> - i.MX Secure Middle-Ware:
>   -- URL: https://github.com/nxp-imx/imx-smw.git
>
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
> changes from v13 to v14
> - moved definition of func se_load_firmware, from 4/6 patch to this patch.
> - split init_device_context to init_misc_device_context.
> - Different value of se_rcv_msg_timeout is required to be set. Receiving the response of 4K RSA operation can to take upto 3 minutes.
>   This long value cannot be set during Linux: boot-up and suspend-resume.
>   Hence, it will be set to default small-value during Linux: boot-up and suspend-resume.
> - func se_dev_ctx_cpy_out_data(), in either case: do_cpy true or false, the clean-up needs to be done and it is implemented like wise.
>   Once do_cpy is false, no need to continue copy to user buffer. But continue to do clean-up. hence cannot return.
>   And every dev-ctx operation is done after taking the lock. Hence, two operations with same dev-ctx is not possible in parallel.
> - func "init_device_context", for 0th misc dev_ctx, which is created at the time of probe, the device memory management is required. hence there is a difference.
> - func "init_device_context", dev_er is replaced with return dev_err_probe.
> - func "init_device_context", devm_add_action is replaced by devm_add_action_reset.
> - removed type-cast from func se_ioctl_get_se_soc_info_handler().
> - used scoped_cond_guard(mutex, _intr, return -EBUSY, &<mutex_lock>)
> - combined dev_err & dev_dbg to one dev_err in se_if_fops_read().
> - removed the structure member "se_shared_mem_mgmt->secure_mem".
> ---
>  Documentation/ABI/testing/se-cdev |  43 ++
>  drivers/firmware/imx/ele_common.c |  70 +++-
>  drivers/firmware/imx/ele_common.h |   8 +-
>  drivers/firmware/imx/se_ctrl.c    | 797 +++++++++++++++++++++++++++++++++++++-
>  drivers/firmware/imx/se_ctrl.h    |  34 ++
>  include/uapi/linux/se_ioctl.h     | 101 +++++
>  6 files changed, 1024 insertions(+), 29 deletions(-)
>
> diff --git a/Documentation/ABI/testing/se-cdev b/Documentation/ABI/testing/se-cdev
> new file mode 100644
> index 000000000000..dad39ffd245a
> --- /dev/null
> +++ b/Documentation/ABI/testing/se-cdev
> @@ -0,0 +1,43 @@
> +What:		/dev/<se>_mu[0-9]+_ch[0-9]+
> +Date:		Mar 2025
> +KernelVersion:	6.8
> +Contact:	linux-imx@nxp.com, pankaj.gupta@nxp.com
> +Description:
> +		NXP offers multiple hardware IP(s) for secure enclaves like EdgeLock-
> +		Enclave(ELE), SECO. The character device file descriptors
> +		/dev/<se>_mu*_ch* are the interface between userspace NXP's secure-
> +		enclave shared library and the kernel driver.
> +
> +		The ioctl(2)-based ABI is defined and documented in
> +		[include]<linux/firmware/imx/ele_mu_ioctl.h>.
> +		ioctl(s) are used primarily for:
> +			- shared memory management
> +			- allocation of I/O buffers
> +			- getting mu info
> +			- setting a dev-ctx as receiver to receive all the commands from FW
> +			- getting SoC info
> +			- send command and receive command response
> +
> +		The following file operations are supported:
> +
> +		open(2)
> +		  Currently the only useful flags are O_RDWR.
> +
> +		read(2)
> +		  Every read() from the opened character device context is waiting on
> +		  wait_event_interruptible, that gets set by the registered mailbox callback
> +		  function, indicating a message received from the firmware on message-
> +		  unit.
> +
> +		write(2)
> +		  Every write() to the opened character device context needs to acquire
> +		  mailbox_lock before sending message on to the message unit.
> +
> +		close(2)
> +		  Stops and frees up the I/O contexts that were associated
> +		  with the file descriptor.
> +
> +Users:		https://github.com/nxp-imx/imx-secure-enclave.git,
> +		https://github.com/nxp-imx/imx-smw.git
> +		crypto/skcipher,
> +		drivers/nvmem/imx-ocotp-ele.c
> diff --git a/drivers/firmware/imx/ele_common.c b/drivers/firmware/imx/ele_common.c
> index f75a8237e353..7978772f034d 100644
> --- a/drivers/firmware/imx/ele_common.c
> +++ b/drivers/firmware/imx/ele_common.c
> @@ -6,6 +6,8 @@
>  #include "ele_base_msg.h"
>  #include "ele_common.h"
>
> +u32 se_rcv_msg_timeout = SE_RCV_MSG_DEFAULT_TIMEOUT;
> +
>  /*
>   * se_add_msg_chksum() - to calculate checksum word by word.
>   *
> @@ -38,32 +40,52 @@ u32 se_add_msg_chksum(u32 *msg, u32 msg_len)
>  	return chksum;
>  }
>
> -int ele_msg_rcv(struct se_if_priv *priv,
> +void set_se_rcv_msg_timeout(u32 val)
> +{
> +	se_rcv_msg_timeout = val;
> +}
> +
> +int ele_msg_rcv(struct se_if_device_ctx *dev_ctx,
>  		struct se_clbk_handle *se_clbk_hdl)
>  {
> -	int err = 0;
> +	struct se_if_priv *priv = dev_ctx->priv;
> +	unsigned int wait;

s/wait/timeout

> +	int ret;
>
>  	do {
> -		err = wait_for_completion_interruptible(&se_clbk_hdl->done);
> -		if (err == -ERESTARTSYS) {
> -			if (priv->waiting_rsp_clbk_hdl.rx_msg) {
> +		wait = priv->cmd_receiver_clbk_hdl.dev_ctx == dev_ctx ?
> +			MAX_SCHEDULE_TIMEOUT : msecs_to_jiffies(se_rcv_msg_timeout);
> +
> +		ret = wait_for_completion_interruptible_timeout(&se_clbk_hdl->done, wait);
> +
> +		if (ret == -ERESTARTSYS) {
> +			if (priv->waiting_rsp_clbk_hdl.dev_ctx) {
>  				priv->waiting_rsp_clbk_hdl.signal_rcvd = true;
>  				continue;
>  			}
> +			ret = -EINTR;
> +			break;
> +		}
> +		if (ret == 0) {
> +			ret = -ETIMEDOUT;
>  			dev_err(priv->dev,
> -				"Err[0x%x]:Interrupted by signal.\n", err);
> -			err = -EINTR;
> +				"Fatal Error: SE interface: %s%d, hangs indefinitely.\n",
> +				get_se_if_name(priv->if_defs->se_if_type),
> +				priv->if_defs->se_instance_id);
>  			break;
>  		}
> -	} while (err != 0);
> +		ret = se_clbk_hdl->rx_msg_sz;
> +		break;
> +	} while (ret < 0);
>
> -	return err ? err : se_clbk_hdl->rx_msg_sz;
> +	return ret;
>  }
>
> -int ele_msg_send(struct se_if_priv *priv,
> +int ele_msg_send(struct se_if_device_ctx *dev_ctx,
>  		 void *tx_msg,
>  		 int tx_msg_sz)

look like below part should belong previous patch, just add "dev_ctx".

>  {
> +	struct se_if_priv *priv = dev_ctx->priv;
>  	struct se_msg_hdr *header = tx_msg;
>  	int err;
>
> @@ -73,7 +95,8 @@ int ele_msg_send(struct se_if_priv *priv,
>  	 */
>  	if (header->size << 2 != tx_msg_sz) {
>  		dev_err(priv->dev,
> -			"User buf hdr: 0x%x, sz mismatced with input-sz (%d != %d).",
> +			"%s: User buf hdr: 0x%x, sz mismatced with input-sz (%d != %d).",
> +			dev_ctx->devname,
>  			*(u32 *)header,
>  			header->size << 2, tx_msg_sz);
>  		return -EINVAL;
> @@ -81,7 +104,9 @@ int ele_msg_send(struct se_if_priv *priv,
>
>  	err = mbox_send_message(priv->tx_chan, tx_msg);
>  	if (err < 0) {
> -		dev_err(priv->dev, "Error: mbox_send_message failure.\n");
> +		dev_err(priv->dev,
> +			"%s: Error: mbox_send_message failure.",
> +			dev_ctx->devname);
>  		return err;
>  	}
>
> @@ -100,21 +125,24 @@ int ele_msg_send_rcv(struct se_if_device_ctx *dev_ctx,
>
>  	guard(mutex)(&priv->se_if_cmd_lock);
>
> +	priv->waiting_rsp_clbk_hdl.dev_ctx = dev_ctx;
>  	priv->waiting_rsp_clbk_hdl.rx_msg_sz = exp_rx_msg_sz;
>  	priv->waiting_rsp_clbk_hdl.rx_msg = rx_msg;
>
> -	err = ele_msg_send(priv, tx_msg, tx_msg_sz);
> +	err = ele_msg_send(dev_ctx, tx_msg, tx_msg_sz);
>  	if (err < 0)
>  		return err;
>
> -	err = ele_msg_rcv(priv, &priv->waiting_rsp_clbk_hdl);
> +	err = ele_msg_rcv(dev_ctx, &priv->waiting_rsp_clbk_hdl);
>
>  	if (priv->waiting_rsp_clbk_hdl.signal_rcvd) {
>  		err = -EINTR;
>  		priv->waiting_rsp_clbk_hdl.signal_rcvd = false;
>  		dev_err(priv->dev,
> -			"Err[0x%x]:Interrupted by signal.\n", err);
> +			"%s: Err[0x%x]:Interrupted by signal.\n",
> +			dev_ctx->devname, err);
>  	}
> +	priv->waiting_rsp_clbk_hdl.dev_ctx = NULL;
>
>  	return err;
>  }
> @@ -160,7 +188,8 @@ void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
>  	if (header->tag == priv->if_defs->cmd_tag) {
>  		se_clbk_hdl = &priv->cmd_receiver_clbk_hdl;
>  		dev_dbg(dev,
> -			"Selecting cmd receiver for mesg header:0x%x.",
> +			"Selecting cmd receiver:%s for mesg header:0x%x.",
> +			se_clbk_hdl->dev_ctx->devname,
>  			*(u32 *)header);
>
>  		/* Pre-allocated buffer of MAX_NVM_MSG_LEN
> @@ -169,7 +198,8 @@ void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
>  		 */
>  		if (rx_msg_sz > MAX_NVM_MSG_LEN) {
>  			dev_err(dev,
> -				"CMD-RCVER NVM: hdr(0x%x) with different sz(%d != %d).\n",
> +				"%s: CMD-RCVER NVM: hdr(0x%x) with different sz(%d != %d).\n",
> +				se_clbk_hdl->dev_ctx->devname,
>  				*(u32 *)header,
>  				rx_msg_sz, se_clbk_hdl->rx_msg_sz);
>
> @@ -180,13 +210,15 @@ void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
>  	} else if (header->tag == priv->if_defs->rsp_tag) {
>  		se_clbk_hdl = &priv->waiting_rsp_clbk_hdl;
>  		dev_dbg(dev,
> -			"Selecting resp waiter for mesg header:0x%x.",
> +			"Selecting resp waiter:%s for mesg header:0x%x.",
> +			se_clbk_hdl->dev_ctx->devname,
>  			*(u32 *)header);
>
>  		if (rx_msg_sz != se_clbk_hdl->rx_msg_sz &&
>  		    check_hdr_exception_for_sz(priv, header)) {
>  			dev_err(dev,
> -				"Rsp to CMD: hdr(0x%x) with different sz(%d != %d).\n",
> +				"%s: Rsp to CMD: hdr(0x%x) with different sz(%d != %d).\n",
> +				se_clbk_hdl->dev_ctx->devname,
>  				*(u32 *)header,
>  				rx_msg_sz, se_clbk_hdl->rx_msg_sz);
>
> diff --git a/drivers/firmware/imx/ele_common.h b/drivers/firmware/imx/ele_common.h
> index a6bf93f0048f..dc7da69c0f92 100644
> --- a/drivers/firmware/imx/ele_common.h
> +++ b/drivers/firmware/imx/ele_common.h
> @@ -12,10 +12,14 @@
>
>  #define IMX_ELE_FW_DIR                 "imx/ele/"
>
> +#define SE_RCV_MSG_DEFAULT_TIMEOUT	5000
> +#define SE_RCV_MSG_LONG_TIMEOUT		5000000
> +
> +void set_se_rcv_msg_timeout(u32 val);
>  u32 se_add_msg_chksum(u32 *msg, u32 msg_len);
> -int ele_msg_rcv(struct se_if_priv *priv,
> +int ele_msg_rcv(struct se_if_device_ctx *dev_ctx,
>  		struct se_clbk_handle *se_clbk_hdl);
> -int ele_msg_send(struct se_if_priv *priv,
> +int ele_msg_send(struct se_if_device_ctx *dev_ctx,
>  		 void *tx_msg,
>  		 int tx_msg_sz);
>  int ele_msg_send_rcv(struct se_if_device_ctx *dev_ctx,
> diff --git a/drivers/firmware/imx/se_ctrl.c b/drivers/firmware/imx/se_ctrl.c
> index 144a727bbfe0..9dbe866b7b13 100644
> --- a/drivers/firmware/imx/se_ctrl.c
> +++ b/drivers/firmware/imx/se_ctrl.c
> @@ -23,6 +23,7 @@
>  #include <linux/slab.h>
>  #include <linux/string.h>
>  #include <linux/sys_soc.h>
> +#include <uapi/linux/se_ioctl.h>
>
>  #include "ele_base_msg.h"
>  #include "ele_common.h"
> @@ -31,8 +32,6 @@
>  #define MAX_SOC_INFO_DATA_SZ		256
>  #define MBOX_TX_NAME			"tx"
>  #define MBOX_RX_NAME			"rx"
> -#define SE_TYPE_STR_HSM			"hsm"
> -#define SE_TYPE_ID_HSM			0x2
>
>  struct se_fw_img_name {
>  	const u8 *prim_fw_nm_in_rfs;
> @@ -118,6 +117,24 @@ static const struct of_device_id se_match[] = {
>  	{},
>  };
>
> +char *get_se_if_name(u8 se_if_id)
> +{
> +	switch (se_if_id) {
> +	case SE_TYPE_ID_DBG: return SE_TYPE_STR_DBG;
> +	case SE_TYPE_ID_HSM: return SE_TYPE_STR_HSM;

If only use once, needn't define macro, just
	return "dbg".


> +	}
> +
> +	return NULL;
> +}
> +
> +static uint32_t get_se_soc_id(struct se_if_priv *priv)
> +{
> +	const struct se_soc_info *se_info =
> +				device_get_match_data(priv->dev);
> +
> +	return se_info->soc_id;
> +}
> +
>  static struct se_fw_load_info *get_load_fw_instance(struct se_if_priv *priv)
>  {
>  	return &var_se_info.load_fw;
> @@ -191,31 +208,785 @@ static int get_se_soc_info(struct se_if_priv *priv, const struct se_soc_info *se
>  	return 0;
>  }
>
> -static int init_misc_device_context(struct se_if_priv *priv, int ch_id,
> -				    struct se_if_device_ctx **new_dev_ctx)
> +static int load_firmware(struct se_if_priv *priv, const u8 *se_img_file_to_load)
> +{
> +	const struct firmware *fw = NULL;
> +	phys_addr_t se_fw_phyaddr;
> +	u8 *se_fw_buf;
> +	int ret;
> +
> +	if (!se_img_file_to_load) {
> +		dev_err(priv->dev, "FW image is not provided.");
> +		return -EINVAL;
> +	}
> +	ret = request_firmware(&fw, se_img_file_to_load, priv->dev);
> +	if (ret)
> +		return ret;
> +
> +	dev_info(priv->dev, "loading firmware %s\n", se_img_file_to_load);
> +
> +	/* allocate buffer to store the SE FW */
> +	se_fw_buf = dma_alloc_coherent(priv->dev, fw->size,
> +				       &se_fw_phyaddr, GFP_KERNEL);
> +	if (!se_fw_buf)
> +		return -ENOMEM;

missed release_firmware(fw); at error path.

> +
> +	memcpy(se_fw_buf, fw->data, fw->size);
> +	ret = ele_fw_authenticate(priv, se_fw_phyaddr);
> +	if (ret < 0) {
> +		dev_err(priv->dev,
> +			"Error %pe: Authenticate & load SE firmware %s.\n",
> +			ERR_PTR(ret),
> +			se_img_file_to_load);
> +		ret = -EPERM;
> +	}
> +
> +	dma_free_coherent(priv->dev,
> +			  fw->size,
> +			  se_fw_buf,
> +			  se_fw_phyaddr);
> +
> +	release_firmware(fw);
> +
> +	return ret;
> +}
> +
> +static int se_load_firmware(struct se_if_priv *priv)
> +{
> +	struct se_fw_load_info *load_fw = get_load_fw_instance(priv);
> +	int ret = 0;
> +
> +	if (!load_fw->is_fw_tobe_loaded)
> +		return 0;
> +
> +	if (load_fw->imem.state == ELE_IMEM_STATE_BAD) {
> +		ret = load_firmware(priv, load_fw->se_fw_img_nm->prim_fw_nm_in_rfs);
> +		if (ret) {
> +			dev_err(priv->dev, "Failed to load boot firmware.");
> +			return -EPERM;
> +		}
> +	}
> +
> +	ret = load_firmware(priv, load_fw->se_fw_img_nm->seco_fw_nm_in_rfs);
> +	if (ret) {
> +		dev_err(priv->dev, "Failed to load runtime firmware.");
> +		return -EPERM;
> +	}
> +
> +	load_fw->is_fw_tobe_loaded = false;
> +
> +	return ret;
> +}
> +
> +static int init_se_shared_mem(struct se_if_device_ctx *dev_ctx)
> +{
> +	struct se_shared_mem_mgmt_info *se_shared_mem_mgmt = &dev_ctx->se_shared_mem_mgmt;
> +	struct se_if_priv *priv = dev_ctx->priv;
> +
> +	INIT_LIST_HEAD(&se_shared_mem_mgmt->pending_out);
> +	INIT_LIST_HEAD(&se_shared_mem_mgmt->pending_in);
> +
> +	/*
> +	 * Allocate some memory for data exchanges with S40x.
> +	 * This will be used for data not requiring secure memory.
> +	 */
> +	se_shared_mem_mgmt->non_secure_mem.ptr =
> +			dma_alloc_coherent(priv->dev,
> +					   MAX_DATA_SIZE_PER_USER,
> +					   &se_shared_mem_mgmt->non_secure_mem.dma_addr,
> +					   GFP_KERNEL);
> +	if (!se_shared_mem_mgmt->non_secure_mem.ptr)
> +		return -ENOMEM;
> +
> +	se_shared_mem_mgmt->non_secure_mem.size = MAX_DATA_SIZE_PER_USER;
> +	se_shared_mem_mgmt->non_secure_mem.pos = 0;
> +
> +	return 0;
> +}
> +
> +static void cleanup_se_shared_mem(struct se_if_device_ctx *dev_ctx)
> +{
> +	struct se_shared_mem_mgmt_info *se_shared_mem_mgmt = &dev_ctx->se_shared_mem_mgmt;
> +	struct se_if_priv *priv = dev_ctx->priv;
> +
> +	/* Free non-secure shared buffer. */
> +	dma_free_coherent(priv->dev, MAX_DATA_SIZE_PER_USER,
> +			  se_shared_mem_mgmt->non_secure_mem.ptr,
> +			  se_shared_mem_mgmt->non_secure_mem.dma_addr);
> +
> +	se_shared_mem_mgmt->non_secure_mem.ptr = NULL;
> +	se_shared_mem_mgmt->non_secure_mem.dma_addr = 0;
> +	se_shared_mem_mgmt->non_secure_mem.size = 0;
> +	se_shared_mem_mgmt->non_secure_mem.pos = 0;
> +}
> +
> +/* Need to copy the output data to user-device context.
> + */
> +static int se_dev_ctx_cpy_out_data(struct se_if_device_ctx *dev_ctx)
> +{
> +	struct se_shared_mem_mgmt_info *se_shared_mem_mgmt = &dev_ctx->se_shared_mem_mgmt;
> +	struct se_if_priv *priv = dev_ctx->priv;
> +	struct se_buf_desc *b_desc, *temp;
> +	bool do_cpy = true;
> +
> +	list_for_each_entry_safe(b_desc, temp, &se_shared_mem_mgmt->pending_out, link) {
> +		// TBD

what TBD?

> +		if (b_desc->usr_buf_ptr && b_desc->shared_buf_ptr && do_cpy) {
> +			dev_dbg(priv->dev,
> +				"Copying output data to user.");
> +			if (do_cpy && copy_to_user(b_desc->usr_buf_ptr,
> +						   b_desc->shared_buf_ptr,
> +						   b_desc->size)) {
> +				dev_err(priv->dev,
> +					"Failure copying output data to user.");
> +				do_cpy = false;
> +			}
> +		}
> +
> +		if (b_desc->shared_buf_ptr)
> +			memset(b_desc->shared_buf_ptr, 0, b_desc->size);
> +
> +		list_del(&b_desc->link);
> +		kfree(b_desc);
> +	}
> +
> +	return do_cpy ? 0 : -EFAULT;
> +}
> +
> +/*
> + * Clean the used Shared Memory space,
> + * whether its Input Data copied from user buffers, or
> + * Data received from FW.
> + */
> +static void se_dev_ctx_shared_mem_cleanup(struct se_if_device_ctx *dev_ctx)
> +{
> +	struct se_shared_mem_mgmt_info *se_shared_mem_mgmt = &dev_ctx->se_shared_mem_mgmt;
> +	struct list_head *pending_lists[] = {&se_shared_mem_mgmt->pending_in,
> +						&se_shared_mem_mgmt->pending_out};
> +	struct se_buf_desc *b_desc, *temp;
> +	int i;
> +
> +	for (i = 0; i < 2; i++) {

2 should be ARRAY_SIZE(pending_lists)

> +		list_for_each_entry_safe(b_desc, temp,
> +					 pending_lists[i], link) {
> +			if (b_desc->shared_buf_ptr)
> +				memset(b_desc->shared_buf_ptr, 0, b_desc->size);
> +
> +			list_del(&b_desc->link);
> +			kfree(b_desc);
> +		}
> +	}
> +	se_shared_mem_mgmt->non_secure_mem.pos = 0;
> +}
> +
> +static int add_b_desc_to_pending_list(void *shared_ptr_with_pos,
> +				      struct se_ioctl_setup_iobuf *io,
> +				      struct se_if_device_ctx *dev_ctx)
> +{
> +	struct se_shared_mem_mgmt_info *se_shared_mem_mgmt = &dev_ctx->se_shared_mem_mgmt;
> +	struct se_buf_desc *b_desc = NULL;
> +
> +	b_desc = kzalloc(sizeof(*b_desc), GFP_KERNEL);
> +	if (!b_desc)
> +		return -ENOMEM;
> +
> +	b_desc->shared_buf_ptr = shared_ptr_with_pos;
> +	b_desc->usr_buf_ptr = io->user_buf;
> +	b_desc->size = io->length;
> +
> +	if (io->flags & SE_IO_BUF_FLAGS_IS_INPUT) {
> +		/*
> +		 * buffer is input:
> +		 * add an entry in the "pending input buffers" list so
> +		 * that copied data can be cleaned from shared memory
> +		 * later.
> +		 */
> +		list_add_tail(&b_desc->link, &se_shared_mem_mgmt->pending_in);
> +	} else {
> +		/*
> +		 * buffer is output:
> +		 * add an entry in the "pending out buffers" list so data
> +		 * can be copied to user space when receiving Secure-Enclave
> +		 * response.
> +		 */
> +		list_add_tail(&b_desc->link, &se_shared_mem_mgmt->pending_out);
> +	}
> +
> +	return 0;
> +}
> +
> +/* interface for managed res to unregister a character device */
> +static void if_misc_deregister(void *miscdevice)
> +{
> +	misc_deregister(miscdevice);
> +}
> +
> +static int init_device_context(struct se_if_priv *priv, int ch_id,
> +			       struct se_if_device_ctx **new_dev_ctx)

You can move init_device_context after init_misc_device_context, it may
let git diff look better.

>  {
>  	struct se_if_device_ctx *dev_ctx;
>  	int ret = 0;
>
> -	dev_ctx = devm_kzalloc(priv->dev, sizeof(*dev_ctx), GFP_KERNEL);
> +	dev_ctx = kzalloc(sizeof(*dev_ctx), GFP_KERNEL);
>
>  	if (!dev_ctx)
>  		return -ENOMEM;
>
> +	dev_ctx->devname = kasprintf(GFP_KERNEL, "%s%d_ch%d",
> +				     get_se_if_name(priv->if_defs->se_if_type),
> +				     priv->if_defs->se_instance_id,
> +				     ch_id);
> +	if (!dev_ctx->devname) {
> +		kfree(dev_ctx);
> +		return -ENOMEM;
> +	}
> +
> +	mutex_init(&dev_ctx->fops_lock);
>  	dev_ctx->priv = priv;
> +	*new_dev_ctx = dev_ctx;
> +
> +	list_add_tail(&dev_ctx->link, &priv->dev_ctx_list);
> +	priv->active_devctx_count++;
> +
> +	ret = init_se_shared_mem(dev_ctx);
> +	if (ret < 0) {
> +		kfree(dev_ctx->devname);
> +		kfree(dev_ctx);
> +		*new_dev_ctx = NULL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int init_misc_device_context(struct se_if_priv *priv, int ch_id,
> +				    struct se_if_device_ctx **new_dev_ctx,
> +				    const struct file_operations *se_if_fops)
> +{
> +	struct se_if_device_ctx *dev_ctx;
> +	int ret = 0;
> +
> +	dev_ctx = devm_kzalloc(priv->dev, sizeof(*dev_ctx), GFP_KERNEL);
> +
> +	if (!dev_ctx)
> +		return -ENOMEM;
>
>  	dev_ctx->devname = devm_kasprintf(priv->dev, GFP_KERNEL, "%s%d_ch%d",
> -					  SE_TYPE_STR_HSM,
> +					  get_se_if_name(priv->if_defs->se_if_type),
>  					  priv->if_defs->se_instance_id,
>  					  ch_id);
>  	if (!dev_ctx->devname)
>  		return -ENOMEM;
>
> +	mutex_init(&dev_ctx->fops_lock);
> +
> +	dev_ctx->priv = priv;
>  	*new_dev_ctx = dev_ctx;
>
> +	dev_ctx->miscdev = devm_kzalloc(priv->dev, sizeof(*dev_ctx->miscdev), GFP_KERNEL);
> +	if (!dev_ctx->miscdev) {
> +		*new_dev_ctx = NULL;
> +		return -ENOMEM;
> +	}
> +
> +	dev_ctx->miscdev->name = dev_ctx->devname;
> +	dev_ctx->miscdev->minor = MISC_DYNAMIC_MINOR;
> +	dev_ctx->miscdev->fops = se_if_fops;
> +	dev_ctx->miscdev->parent = priv->dev;
> +	ret = misc_register(dev_ctx->miscdev);
> +	if (ret)
> +		return dev_err_probe(priv->dev, ret, "Failed to register misc device.");
> +
> +	ret = devm_add_action_or_reset(priv->dev, if_misc_deregister,
> +				       dev_ctx->miscdev);
> +	if (ret)
> +		return dev_err_probe(priv->dev, ret,
> +				     "Failed to add action to the misc-dev.");
>  	return ret;
>  }
>
> +static int se_ioctl_cmd_snd_rcv_rsp_handler(struct se_if_device_ctx *dev_ctx,
> +					    u64 arg)
> +{
> +	struct se_ioctl_cmd_snd_rcv_rsp_info cmd_snd_rcv_rsp_info = {0};
> +	struct se_api_msg *tx_msg __free(kfree) = NULL;
> +	struct se_api_msg *rx_msg __free(kfree) = NULL;
> +	struct se_if_priv *priv = dev_ctx->priv;
> +	int err = 0;
> +
> +	if (copy_from_user(&cmd_snd_rcv_rsp_info, (u8 __user *)arg,
> +			   sizeof(cmd_snd_rcv_rsp_info))) {
> +		dev_err(priv->dev,
> +			"%s: Failed to copy cmd_snd_rcv_rsp_info from user\n",
> +			dev_ctx->devname);
> +		err = -EFAULT;
> +		goto exit;
> +	}
> +
> +	if (cmd_snd_rcv_rsp_info.tx_buf_sz < SE_MU_HDR_SZ) {
> +		dev_err(priv->dev,
> +			"%s: User buffer too small(%d < %d)\n",
> +			dev_ctx->devname,
> +			cmd_snd_rcv_rsp_info.tx_buf_sz,
> +			SE_MU_HDR_SZ);
> +		err = -ENOSPC;
> +		goto exit;
> +	}
> +
> +	rx_msg = kzalloc(cmd_snd_rcv_rsp_info.rx_buf_sz, GFP_KERNEL);
> +	if (!rx_msg) {
> +		err = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	tx_msg = memdup_user(cmd_snd_rcv_rsp_info.tx_buf,
> +			     cmd_snd_rcv_rsp_info.tx_buf_sz);
> +	if (IS_ERR(tx_msg)) {
> +		err = PTR_ERR(tx_msg);
> +		goto exit;
> +	}
> +
> +	if (tx_msg->header.tag != priv->if_defs->cmd_tag) {
> +		err = -EINVAL;
> +		goto exit;
> +	}
> +
> +	if (tx_msg->header.ver == priv->if_defs->fw_api_ver &&
> +	    get_load_fw_instance(priv)->is_fw_tobe_loaded) {
> +		err = se_load_firmware(priv);
> +		if (err) {
> +			dev_err(priv->dev, "Could not send the message as FW is not loaded.");
> +			err = -EPERM;
> +			goto exit;
> +		}
> +	}
> +	set_se_rcv_msg_timeout(SE_RCV_MSG_LONG_TIMEOUT);

you set default TIMEMOUT at suspend, but set LONG TIMEOUT here.

What's happen, if one instance already resumed, and set SE_RCV_MSG_LONG_TIMEOUT

the other instance still in suspend, which will wrong use
SE_RCV_MSG_LONG_TIMEOUT.

> +
> +	err = ele_msg_send_rcv(dev_ctx,
> +			       tx_msg,
> +			       cmd_snd_rcv_rsp_info.tx_buf_sz,
> +			       rx_msg,
> +			       cmd_snd_rcv_rsp_info.rx_buf_sz);
> +	if (err < 0)
> +		goto exit;
> +
> +	dev_dbg(priv->dev,
> +		"%s: %s %s\n",
> +		dev_ctx->devname,
> +		__func__,
> +		"message received, start transmit to user");
> +
> +	/* We may need to copy the output data to user before
> +	 * delivering the completion message.
> +	 */
> +	err = se_dev_ctx_cpy_out_data(dev_ctx);
> +	if (err < 0)
> +		goto exit;
> +
> +	/* Copy data from the buffer */
> +	print_hex_dump_debug("to user ", DUMP_PREFIX_OFFSET, 4, 4,
> +			     rx_msg,
> +			     cmd_snd_rcv_rsp_info.rx_buf_sz, false);
> +
> +	if (copy_to_user(cmd_snd_rcv_rsp_info.rx_buf, rx_msg,
> +			 cmd_snd_rcv_rsp_info.rx_buf_sz)) {
> +		dev_err(priv->dev,
> +			"%s: Failed to copy to user\n",
> +			dev_ctx->devname);
> +		err = -EFAULT;
> +	}
> +
> +exit:
> +
> +	/* shared memory is allocated before this IOCTL */
> +	se_dev_ctx_shared_mem_cleanup(dev_ctx);
> +
> +	if (copy_to_user((void __user *)arg, &cmd_snd_rcv_rsp_info,
> +			 sizeof(cmd_snd_rcv_rsp_info))) {
> +		dev_err(priv->dev,
> +			"%s: Failed to copy cmd_snd_rcv_rsp_info from user\n",
> +			dev_ctx->devname);
> +		err = -EFAULT;
> +	}
> +
> +	return err;
> +}
> +
> +static int se_ioctl_get_mu_info(struct se_if_device_ctx *dev_ctx,
> +				u64 arg)
> +{
> +	struct se_if_priv *priv = dev_ctx->priv;
> +	struct se_ioctl_get_if_info if_info;
> +	struct se_if_node *if_node;
> +	int err = 0;
> +
> +	if_node = container_of(priv->if_defs, typeof(*if_node), if_defs);
> +
> +	if_info.se_if_id = 0;
> +	if_info.interrupt_idx = 0;
> +	if_info.tz = 0;
> +	if_info.did = 0;
> +	if_info.cmd_tag = priv->if_defs->cmd_tag;
> +	if_info.rsp_tag = priv->if_defs->rsp_tag;
> +	if_info.success_tag = priv->if_defs->success_tag;
> +	if_info.base_api_ver = priv->if_defs->base_api_ver;
> +	if_info.fw_api_ver = priv->if_defs->fw_api_ver;
> +
> +	dev_dbg(priv->dev,
> +		"%s: info [se_if_id: %d, irq_idx: %d, tz: 0x%x, did: 0x%x]\n",
> +		dev_ctx->devname,
> +		if_info.se_if_id, if_info.interrupt_idx,
> +		if_info.tz, if_info.did);
> +
> +	if (copy_to_user((u8 __user *)arg, &if_info, sizeof(if_info))) {
> +		dev_err(priv->dev,
> +			"%s: Failed to copy mu info to user\n",
> +			dev_ctx->devname);
> +		err = -EFAULT;
> +	}
> +
> +	return err;
> +}
> +
> +/*
> + * Copy a buffer of data to/from the user and return the address to use in
> + * messages
> + */
> +static int se_ioctl_setup_iobuf_handler(struct se_if_device_ctx *dev_ctx,
> +					u64 arg)
> +{
> +	struct se_shared_mem *shared_mem = NULL;
> +	struct se_ioctl_setup_iobuf io = {0};
> +	int err = 0;
> +	u32 pos;
> +
> +	if (copy_from_user(&io, (u8 __user *)arg, sizeof(io))) {
> +		dev_err(dev_ctx->priv->dev,
> +			"%s: Failed copy iobuf config from user\n",
> +			dev_ctx->devname);
> +		return -EFAULT;
> +	}
> +
> +	dev_dbg(dev_ctx->priv->dev,
> +		"%s: io [buf: %p(%d) flag: %x]\n",
> +		dev_ctx->devname,
> +		io.user_buf, io.length, io.flags);
> +
> +	if (io.length == 0 || !io.user_buf) {
> +		/*
> +		 * Accept NULL pointers since some buffers are optional
> +		 * in FW commands. In this case we should return 0 as
> +		 * pointer to be embedded into the message.
> +		 * Skip all data copy part of code below.
> +		 */
> +		io.ele_addr = 0;
> +		goto copy;
> +	}
> +
> +	/* No specific requirement for this buffer. */
> +	shared_mem = &dev_ctx->se_shared_mem_mgmt.non_secure_mem;
> +
> +	/* Check there is enough space in the shared memory. */
> +	dev_dbg(dev_ctx->priv->dev,
> +		"%s: req_size = %d, max_size= %d, curr_pos = %d",
> +		dev_ctx->devname,
> +		round_up(io.length, 8u),
> +		shared_mem->size, shared_mem->pos);
> +
> +	if (shared_mem->size < shared_mem->pos ||
> +	    round_up(io.length, 8u) > (shared_mem->size - shared_mem->pos)) {
> +		dev_err(dev_ctx->priv->dev,
> +			"%s: Not enough space in shared memory\n",
> +			dev_ctx->devname);
> +		return -ENOMEM;
> +	}
> +
> +	/* Allocate space in shared memory. 8 bytes aligned. */
> +	pos = shared_mem->pos;
> +	shared_mem->pos += round_up(io.length, 8u);
> +	io.ele_addr = (u64)shared_mem->dma_addr + pos;
> +
> +	memset(shared_mem->ptr + pos, 0, io.length);
> +	if ((io.flags & SE_IO_BUF_FLAGS_IS_INPUT) ||
> +	    (io.flags & SE_IO_BUF_FLAGS_IS_IN_OUT)) {
> +		/*
> +		 * buffer is input:
> +		 * copy data from user space to this allocated buffer.
> +		 */
> +		if (copy_from_user(shared_mem->ptr + pos, io.user_buf,
> +				   io.length)) {
> +			dev_err(dev_ctx->priv->dev,
> +				"%s: Failed copy data to shared memory\n",
> +				dev_ctx->devname);
> +			return -EFAULT;
> +		}
> +	}
> +
> +	err = add_b_desc_to_pending_list(shared_mem->ptr + pos,
> +					 &io,
> +					 dev_ctx);
> +	if (err < 0)
> +		dev_err(dev_ctx->priv->dev,
> +			"%s: Failed to allocate/link b_desc.",
> +			dev_ctx->devname);
> +
> +copy:
> +	/* Provide the EdgeLock Enclave address to user space only if success.*/
> +	if (copy_to_user((u8 __user *)arg, &io, sizeof(io))) {
> +		dev_err(dev_ctx->priv->dev,
> +			"%s: Failed to copy iobuff setup to user.",
> +			dev_ctx->devname);
> +		err = -EFAULT;
> +	}
> +
> +	return err;
> +}
> +
> +/* IOCTL to provide SoC information */
> +static int se_ioctl_get_se_soc_info_handler(struct se_if_device_ctx *dev_ctx,
> +					    u64 arg)
> +{
> +	struct se_ioctl_get_soc_info soc_info;
> +	int err = -EINVAL;
> +
> +	soc_info.soc_id = get_se_soc_id(dev_ctx->priv);
> +	soc_info.soc_rev = var_se_info.soc_rev;
> +
> +	err = copy_to_user((u8 __user *)arg, (u8 *)(&soc_info), sizeof(soc_info));
> +	if (err) {
> +		dev_err(dev_ctx->priv->dev,
> +			"%s: Failed to copy soc info to user\n",
> +			dev_ctx->devname);
> +		err = -EFAULT;
> +	}
> +
> +	return err;
> +}
> +
> +/*
> + * File operations for user-space
> + */
> +
> +/* Write a message to the MU. */
> +static ssize_t se_if_fops_write(struct file *fp, const char __user *buf,
> +				size_t size, loff_t *ppos)
> +{
> +	struct se_if_device_ctx *dev_ctx = fp->private_data;
> +	struct se_api_msg *tx_msg __free(kfree) = NULL;
> +	struct se_if_priv *priv = dev_ctx->priv;
> +	int err;
> +
> +	dev_dbg(priv->dev,
> +		"%s: write from buf (%p)%zu, ppos=%lld\n",
> +		dev_ctx->devname,
> +		buf, size, ((ppos) ? *ppos : 0));
> +
> +	scoped_cond_guard(mutex_intr, return -EBUSY, &dev_ctx->fops_lock) {
> +		if (dev_ctx != priv->cmd_receiver_clbk_hdl.dev_ctx)
> +			return -EINVAL;
> +
> +		if (size < SE_MU_HDR_SZ) {
> +			dev_err(priv->dev,
> +				"%s: User buffer too small(%zu < %d)\n",
> +				dev_ctx->devname,
> +				size, SE_MU_HDR_SZ);
> +			return -ENOSPC;
> +		}
> +
> +		tx_msg = memdup_user(buf, size);
> +		if (IS_ERR(tx_msg))
> +			return PTR_ERR(tx_msg);
> +
> +		print_hex_dump_debug("from user ", DUMP_PREFIX_OFFSET, 4, 4,
> +				     tx_msg, size, false);
> +
> +		err = ele_msg_send(dev_ctx, tx_msg, size);
> +
> +		return err;
> +	}
> +}
> +
> +/*
> + * Read a message from the MU.
> + * Blocking until a message is available.
> + */
> +static ssize_t se_if_fops_read(struct file *fp, char __user *buf,
> +			       size_t size, loff_t *ppos)
> +{
> +	struct se_if_device_ctx *dev_ctx = fp->private_data;
> +	struct se_if_priv *priv = dev_ctx->priv;
> +	int err;
> +
> +	dev_dbg(priv->dev,
> +		"%s: read to buf %p(%zu), ppos=%lld\n",
> +		dev_ctx->devname,
> +		buf, size, ((ppos) ? *ppos : 0));
> +
> +	scoped_cond_guard(mutex_intr, return -EBUSY, &dev_ctx->fops_lock) {
> +		if (dev_ctx != priv->cmd_receiver_clbk_hdl.dev_ctx) {
> +			err = -EINVAL;
> +			goto exit;
> +		}
> +
> +		err = ele_msg_rcv(dev_ctx, &priv->cmd_receiver_clbk_hdl);
> +		if (err < 0) {
> +			dev_err(priv->dev,
> +				"%s: Err[0x%x]:Interrupted by signal."
> +				"Current active dev-ctx count = %d.",
> +				dev_ctx->devname, err,
> +				dev_ctx->priv->active_devctx_count);
> +			goto exit;
> +		}
> +
> +		/* We may need to copy the output data to user before
> +		 * delivering the completion message.
> +		 */
> +		err = se_dev_ctx_cpy_out_data(dev_ctx);
> +		if (err < 0)
> +			goto exit;
> +
> +		/* Copy data from the buffer */
> +		print_hex_dump_debug("to user ", DUMP_PREFIX_OFFSET, 4, 4,
> +				     priv->cmd_receiver_clbk_hdl.rx_msg,
> +				     priv->cmd_receiver_clbk_hdl.rx_msg_sz,
> +				     false);
> +
> +		if (copy_to_user(buf, priv->cmd_receiver_clbk_hdl.rx_msg,
> +				 priv->cmd_receiver_clbk_hdl.rx_msg_sz)) {
> +			dev_err(priv->dev,
> +				"%s: Failed to copy to user\n",
> +				dev_ctx->devname);
> +			err = -EFAULT;
> +		} else {
> +			err = priv->cmd_receiver_clbk_hdl.rx_msg_sz;
> +		}
> +exit:
> +		priv->cmd_receiver_clbk_hdl.rx_msg_sz = 0;
> +
> +		se_dev_ctx_shared_mem_cleanup(dev_ctx);
> +
> +		return err;
> +	}
> +}
> +
> +/* Open a character device. */
> +static int se_if_fops_open(struct inode *nd, struct file *fp)
> +{
> +	struct miscdevice *miscdev = fp->private_data;
> +	struct se_if_device_ctx *misc_dev_ctx;
> +	struct se_if_device_ctx *dev_ctx;
> +	struct se_if_priv *priv;
> +	int err = 0;
> +
> +	priv = dev_get_drvdata(miscdev->parent);
> +	misc_dev_ctx = priv->priv_dev_ctx;
> +
> +	scoped_cond_guard(mutex_intr, return -EBUSY, &misc_dev_ctx->fops_lock) {
> +		priv->dev_ctx_mono_count++;
> +		err = init_device_context(priv,
> +					  priv->dev_ctx_mono_count ?
> +					  priv->dev_ctx_mono_count
> +					  : priv->dev_ctx_mono_count++,
> +					  &dev_ctx);
> +		if (err)
> +			dev_err(priv->dev,
> +				"Failed[0x%x] to create device contexts.\n",
> +				err);
> +		else
> +			fp->private_data = dev_ctx;
> +
> +		return err;
> +	}
> +}
> +
> +/* Close a character device. */
> +static int se_if_fops_close(struct inode *nd, struct file *fp)
> +{
> +	struct se_if_device_ctx *dev_ctx = fp->private_data;
> +	struct se_if_priv *priv = dev_ctx->priv;
> +
> +	scoped_cond_guard(mutex_intr, return -EBUSY, &dev_ctx->fops_lock) {
> +		/* check if this device was registered as command receiver. */
> +		if (priv->cmd_receiver_clbk_hdl.dev_ctx == dev_ctx) {
> +			priv->cmd_receiver_clbk_hdl.dev_ctx = NULL;
> +			kfree(priv->cmd_receiver_clbk_hdl.rx_msg);
> +			priv->cmd_receiver_clbk_hdl.rx_msg = NULL;
> +		}
> +
> +		se_dev_ctx_shared_mem_cleanup(dev_ctx);
> +		cleanup_se_shared_mem(dev_ctx);
> +
> +		priv->active_devctx_count--;
> +		list_del(&dev_ctx->link);
> +
> +		kfree(dev_ctx->devname);
> +		kfree(dev_ctx);
> +	}
> +
> +	return 0;
> +}
> +
> +/* IOCTL entry point of a character device */
> +static long se_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
> +{
> +	struct se_if_device_ctx *dev_ctx = fp->private_data;
> +	struct se_if_priv *priv = dev_ctx->priv;
> +	int err;
> +
> +	/* Prevent race during change of device context */
> +	scoped_cond_guard(mutex_intr, return -EBUSY, &dev_ctx->fops_lock) {
> +		switch (cmd) {
> +		case SE_IOCTL_ENABLE_CMD_RCV:
> +			if (!priv->cmd_receiver_clbk_hdl.dev_ctx) {
> +				if (!priv->cmd_receiver_clbk_hdl.rx_msg) {
> +					priv->cmd_receiver_clbk_hdl.rx_msg =
> +						kzalloc(MAX_NVM_MSG_LEN,
> +							GFP_KERNEL);
> +					if (!priv->cmd_receiver_clbk_hdl.rx_msg) {
> +						err = -ENOMEM;
> +						break;
> +					}
> +				}
> +				priv->cmd_receiver_clbk_hdl.rx_msg_sz = MAX_NVM_MSG_LEN;
> +				priv->cmd_receiver_clbk_hdl.dev_ctx = dev_ctx;
> +				err = 0;
> +			} else {
> +				err = -EBUSY;
> +			}
> +			break;
> +		case SE_IOCTL_GET_MU_INFO:
> +			err = se_ioctl_get_mu_info(dev_ctx, arg);
> +			break;
> +		case SE_IOCTL_SETUP_IOBUF:
> +			err = se_ioctl_setup_iobuf_handler(dev_ctx, arg);
> +			break;
> +		case SE_IOCTL_GET_SOC_INFO:
> +			err = se_ioctl_get_se_soc_info_handler(dev_ctx, arg);
> +			break;
> +		case SE_IOCTL_CMD_SEND_RCV_RSP:
> +			err = se_ioctl_cmd_snd_rcv_rsp_handler(dev_ctx, arg);
> +			break;
> +		default:
> +			err = -EINVAL;
> +			dev_dbg(priv->dev,
> +				"%s: IOCTL %.8x not supported\n",
> +				dev_ctx->devname,
> +				cmd);
> +		}
> +	}
> +
> +	return (long)err;

you can define err as long to avoid force convert here.

> +}
> +
> +/* Char driver setup */
> +static const struct file_operations se_if_fops = {
> +	.open		= se_if_fops_open,
> +	.owner		= THIS_MODULE,
> +	.release	= se_if_fops_close,
> +	.unlocked_ioctl = se_ioctl,
> +	.read		= se_if_fops_read,
> +	.write		= se_if_fops_write,
> +};
> +
>  /* interface for managed res to free a mailbox channel */
>  static void if_mbox_free_channel(void *mbox_chan)
>  {
> @@ -247,6 +1018,7 @@ static int se_if_request_channel(struct device *dev,
>
>  static void se_if_probe_cleanup(void *plat_dev)
>  {
> +	struct se_if_device_ctx *dev_ctx, *t_dev_ctx;
>  	struct platform_device *pdev = plat_dev;
>  	struct se_fw_load_info *load_fw;
>  	struct device *dev = &pdev->dev;
> @@ -271,6 +1043,13 @@ static void se_if_probe_cleanup(void *plat_dev)
>  		load_fw->imem.buf = NULL;
>  	}
>
> +	if (priv->dev_ctx_mono_count) {
> +		list_for_each_entry_safe(dev_ctx, t_dev_ctx, &priv->dev_ctx_list, link) {
> +			list_del(&dev_ctx->link);
> +			priv->active_devctx_count--;
> +		}
> +	}
> +
>  	/* No need to check, if reserved memory is allocated
>  	 * before calling for its release. Or clearing the
>  	 * un-set bit.
> @@ -334,6 +1113,7 @@ static int se_if_probe(struct platform_device *pdev)
>  					     "Unable to get sram pool = %s.",
>  					     if_node->pool_name);
>  	}
> +	INIT_LIST_HEAD(&priv->dev_ctx_list);
>
>  	if (if_node->reserved_dma_ranges) {
>  		ret = of_reserved_mem_device_init(dev);
> @@ -342,7 +1122,7 @@ static int se_if_probe(struct platform_device *pdev)
>  					    "Failed to init reserved memory region.");
>  	}
>
> -	ret = init_misc_device_context(priv, 0, &priv->priv_dev_ctx);
> +	ret = init_misc_device_context(priv, 0, &priv->priv_dev_ctx, &se_if_fops);
>  	if (ret)
>  		return dev_err_probe(dev, ret,
>  				     "Failed[0x%x] to create device contexts.",
> @@ -374,7 +1154,7 @@ static int se_if_probe(struct platform_device *pdev)
>  		}
>  	}
>  	dev_info(dev, "i.MX secure-enclave: %s%d interface to firmware, configured.",
> -		 SE_TYPE_STR_HSM,
> +		 get_se_if_name(priv->if_defs->se_if_type),
>  		 priv->if_defs->se_instance_id);
>
>  	return ret;
> @@ -391,6 +1171,7 @@ static int se_suspend(struct device *dev)
>  	struct se_fw_load_info *load_fw;
>  	int ret = 0;
>
> +	set_se_rcv_msg_timeout(SE_RCV_MSG_DEFAULT_TIMEOUT);
>  	load_fw = get_load_fw_instance(priv);
>
>  	if (load_fw->imem_mgmt)
> diff --git a/drivers/firmware/imx/se_ctrl.h b/drivers/firmware/imx/se_ctrl.h
> index f0893c5c9145..bd50caa4f135 100644
> --- a/drivers/firmware/imx/se_ctrl.h
> +++ b/drivers/firmware/imx/se_ctrl.h
> @@ -14,6 +14,7 @@
>  #define SE_MSG_WORD_SZ			0x4
>
>  #define RES_STATUS(x)			FIELD_GET(0x000000ff, x)
> +#define MAX_DATA_SIZE_PER_USER		(65 * 1024)
>  #define MAX_NVM_MSG_LEN			(256)
>  #define MESSAGING_VERSION_6		0x6
>  #define MESSAGING_VERSION_7		0x7
> @@ -21,6 +22,7 @@
>  struct se_clbk_handle {
>  	struct completion done;
>  	bool signal_rcvd;
> +	struct se_if_device_ctx *dev_ctx;
>  	u32 rx_msg_sz;
>  	/* Assignment of the rx_msg buffer to held till the
>  	 * received content as part callback function, is copied.
> @@ -35,10 +37,38 @@ struct se_imem_buf {
>  	u32 state;
>  };
>
> +struct se_buf_desc {
> +	u8 *shared_buf_ptr;
> +	void __user *usr_buf_ptr;
> +	u32 size;
> +	struct list_head link;
> +};
> +
> +struct se_shared_mem {
> +	dma_addr_t dma_addr;
> +	u32 size;
> +	u32 pos;
> +	u8 *ptr;
> +};
> +
> +struct se_shared_mem_mgmt_info {
> +	struct list_head pending_in;
> +	struct list_head pending_out;
> +
> +	struct se_shared_mem non_secure_mem;
> +};
> +
>  /* Private struct for each char device instance. */
>  struct se_if_device_ctx {
>  	struct se_if_priv *priv;
> +	struct miscdevice *miscdev;
>  	const char *devname;
> +
> +	/* process one file operation at a time. */
> +	struct mutex fops_lock;
> +
> +	struct se_shared_mem_mgmt_info se_shared_mem_mgmt;
> +	struct list_head link;
>  };
>
>  /* Header of the messages exchange with the EdgeLock Enclave */
> @@ -87,6 +117,10 @@ struct se_if_priv {
>  	const struct se_if_defines *if_defs;
>
>  	struct se_if_device_ctx *priv_dev_ctx;
> +	struct list_head dev_ctx_list;
> +	u32 active_devctx_count;
> +	u32 dev_ctx_mono_count;
>  };
>
> +char *get_se_if_name(u8 se_if_id);
>  #endif
> diff --git a/include/uapi/linux/se_ioctl.h b/include/uapi/linux/se_ioctl.h
> new file mode 100644
> index 000000000000..29a9b1ec5ec3
> --- /dev/null
> +++ b/include/uapi/linux/se_ioctl.h
> @@ -0,0 +1,101 @@
> +/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause*/
> +/*
> + * Copyright 2025 NXP
> + */
> +
> +#ifndef SE_IOCTL_H
> +#define SE_IOCTL_H
> +
> +#include <linux/types.h>
> +
> +#define SE_TYPE_STR_DBG			"dbg"
> +#define SE_TYPE_STR_HSM			"hsm"
> +#define SE_TYPE_ID_UNKWN		0x0
> +#define SE_TYPE_ID_DBG			0x1
> +#define SE_TYPE_ID_HSM			0x2
> +/* IOCTL definitions. */
> +
> +struct se_ioctl_setup_iobuf {
> +	void __user *user_buf;
> +	__u32 length;
> +	__u32 flags;
> +	__u64 ele_addr;
> +};
> +
> +struct se_ioctl_shared_mem_cfg {
> +	__u32 base_offset;
> +	__u32 size;
> +};
> +
> +struct se_ioctl_get_if_info {
> +	__u8 se_if_id;
> +	__u8 interrupt_idx;
> +	__u8 tz;
> +	__u8 did;
> +	__u8 cmd_tag;
> +	__u8 rsp_tag;
> +	__u8 success_tag;
> +	__u8 base_api_ver;
> +	__u8 fw_api_ver;
> +};
> +
> +struct se_ioctl_cmd_snd_rcv_rsp_info {
> +	__u32 __user *tx_buf;
> +	int tx_buf_sz;
> +	__u32 __user *rx_buf;
> +	int rx_buf_sz;
> +};
> +
> +struct se_ioctl_get_soc_info {
> +	__u16 soc_id;
> +	__u16 soc_rev;
> +};
> +
> +/* IO Buffer Flags */
> +#define SE_IO_BUF_FLAGS_IS_OUTPUT	(0x00u)
> +#define SE_IO_BUF_FLAGS_IS_INPUT	(0x01u)
> +#define SE_IO_BUF_FLAGS_USE_SEC_MEM	(0x02u)
> +#define SE_IO_BUF_FLAGS_USE_SHORT_ADDR	(0x04u)
> +#define SE_IO_BUF_FLAGS_IS_IN_OUT	(0x10u)
> +
> +/* IOCTLS */
> +#define SE_IOCTL			0x0A /* like MISC_MAJOR. */
> +
> +/*
> + * ioctl to designated the current fd as logical-reciever.
> + * This is ioctl is send when the nvm-daemon, a slave to the
> + * firmware is started by the user.
> + */
> +#define SE_IOCTL_ENABLE_CMD_RCV	_IO(SE_IOCTL, 0x01)
> +
> +/*
> + * ioctl to get the buffer allocated from the memory, which is shared
> + * between kernel and FW.
> + * Post allocation, the kernel tagged the allocated memory with:
> + *  Output
> + *  Input
> + *  Input-Output
> + *  Short address
> + *  Secure-memory
> + */
> +#define SE_IOCTL_SETUP_IOBUF	_IOWR(SE_IOCTL, 0x03, \
> +					struct se_ioctl_setup_iobuf)
> +
> +/*
> + * ioctl to get the mu information, that is used to exchange message
> + * with FW, from user-spaced.
> + */
> +#define SE_IOCTL_GET_MU_INFO	_IOR(SE_IOCTL, 0x04, \
> +					struct se_ioctl_get_if_info)
> +/*
> + * ioctl to get SoC Info from user-space.
> + */
> +#define SE_IOCTL_GET_SOC_INFO      _IOR(SE_IOCTL, 0x06, \
> +					struct se_ioctl_get_soc_info)
> +
> +/*
> + * ioctl to send command and receive response from user-space.
> + */
> +#define SE_IOCTL_CMD_SEND_RCV_RSP _IOWR(SE_IOCTL, 0x07, \
> +					struct se_ioctl_cmd_snd_rcv_rsp_info)
> +#endif
>
> --
> 2.43.0
>

