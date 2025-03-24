Return-Path: <linux-kernel+bounces-573433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A8BA6D724
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 10:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48D147A474B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 09:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED251F5851;
	Mon, 24 Mar 2025 09:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GL5CkBs3"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2071.outbound.protection.outlook.com [40.107.102.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0882C3FD1
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 09:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742807895; cv=fail; b=W3OmIj1GyIyUxG+BS9rZ5PVsir3Jpk1UQ5oDXdV4bu9dOrUzqGMdGPhKIRLUjp64UvXssyO8h4tF0gikaRMjN9Yl4WSS2r9sFOb80sY3VFfVNjRKJrNKBD3r4NS9J0DLwFQXz6FtXqeH54K7zc//TiGCSk0ex42Ive/NmOJ2E30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742807895; c=relaxed/simple;
	bh=wD8NyGSjfmzpP3YGoj3X9QvvZM7qYSaber4ZgLcO/R4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CM5Ni4DmiyxXy1s6PjMDR7/fzHThIsU+19wSt2Vc4UlUrW/06d73Nr6R+7vc529T2T18F2cz05g4MuaOLIinlZrDzrFNS45BSfLKMXLHyVPQdBQjiSuoBiO8GlfJJZyk6YLhCEJM7NIjRHnOovuGx05akSW2vkM6c1zucsfZKLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GL5CkBs3; arc=fail smtp.client-ip=40.107.102.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mD7F2KGAiaUEsGljcfbJb7hTqv5oOO9wheDqwVKuOJxk7MToOx3Dzlz8+KGS5/+GbCRXnMp84iTaJr7TLNi9dMYst1EDzeLYRXhfxuaOEyxXluQyhZdh/wtp3nXw0KgsONnCRKnGo52x1v6O3xHP23gjdzjB0rHdVucOLS/ZzBz7kPZZxCvA7OkgL8AOI3cyIP5ON4HBbViHS955+vR4Ag7lJKCBNDzIVwuczZjJHQiXZ2kmFUOUV1BDGki55AVPSfkaM/MQkTbtLpRKPDEXEA3uYjRtRVb4KjMJkPlkt4fFX+WcnL4HqzKlhrvwCRoVCnrXXFUZQEOAonmmOd9GGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIKSVSRPyqOhAhvHkwkGwSIG0UVjH25Y/o4X0nazSxo=;
 b=DO6Eqk1WtNyLrcqcC67cN7ry+HfuK8RN1wTuy2CvVZ+h5D0hXbotmq+z6YdlenQ6R+7Eizr079oCblsUOJNlPg5561OuV1DLCb/MeGciopsFIEYvkBnA273bTCCSmtp+Bth3im4bCNpDvsJ+pzkMLIbpmuHi1x8QdnhJ2CFD0o/uGq/TEiPgveMf4BmLQjTMA74qPyQU7K/Y0lhx7XxaxVWJK8ceHKjLElKXxVxWaLxkleMqUuLIXLt2R5g2PMgb58sJT8Ihnre5POSy2LNbkLVzPBxuMTsFyaBWLuIc/Ojs61+jWb5q1jDCVU2dcnhU1C+idGDQlOkW4KxCg82A6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIKSVSRPyqOhAhvHkwkGwSIG0UVjH25Y/o4X0nazSxo=;
 b=GL5CkBs3jYXlBDdUFpcATRTY0w/tVGeh5oEOgE1dc5eyCmNDWCdCjBfE8/DUPeOFHBJwZJz8USG3OqKinyc8aKwUTapjA6opYeRuDjzGhvlQEuGwtWEqRBgayhhIImDfJ+Opd6z0TS8SHoXlP+ceojaBV++N0daPIa5EaZLIwnZNRbgv0zN3zJ7SEXLB+oxMxNcSfsajfFMq0zpFPFzq3I2G0ZbAxEDmDNWv4FMAJ/8wrHiP3MPxXmKv28eXnZom+18uNb+YLwP7mmUTR/l2q37DjUPylHTSiy6xgd5us/BCaE1DtiiUDPfUCnEOLy/xumpa1p/rxDVZHg4kfphcww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by IA1PR12MB7760.namprd12.prod.outlook.com (2603:10b6:208:418::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 09:18:10 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 09:18:10 +0000
Date: Mon, 24 Mar 2025 10:18:01 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: initialize built-in idle state before
 ops.init()
Message-ID: <Z-EjSZvyTFVryOao@gpd3>
References: <20250324085616.26810-1-arighi@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324085616.26810-1-arighi@nvidia.com>
X-ClientProxiedBy: ZR2P278CA0005.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::10) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|IA1PR12MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a625443-8d6e-44e8-1566-08dd6ab4cbb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JOp1sHiGrP6MB8zCFQ+AJUqW++77wDDDEkZ8ZS3v0yHYD1HfqOxtP+k2xHZE?=
 =?us-ascii?Q?gJ+vW4Bbr0pX3KddBl1EgCjbOWP3ECbhdvwsB1/Qm3ZShMH91YVe97OlHBKl?=
 =?us-ascii?Q?EnwftL4Ees16f1UIU4fCmsTfYeVwK0esMzryN390mYAzJN7xt5DIe9B/PBQT?=
 =?us-ascii?Q?ovj8EWopDstlatTKDZGy6ZxwYGNeu3dN/i/Nf387Liw3DYIwRKRGm1GfUND4?=
 =?us-ascii?Q?HfpUp4CkYwh1Ses7hdRwfQd/p5+xsXXR4vI+ZGfMslH7v75sXoWu6JrmrsKZ?=
 =?us-ascii?Q?HnVblQdn4tKn7a9adx8vFstjfl6sYQ+5KfbkGvDrNte4iLuNIP7a835cSsf+?=
 =?us-ascii?Q?FiZAkPp4K8pGp1XAuM98hrqsZHyrS5mvyt81E0rO1Yb47UkEVtwY9Jx7eHKj?=
 =?us-ascii?Q?1rp3b7IXJkuyfh9NcYDd6UMPhhsEWQu/sDCHpo1bbcCtJIqiuuk+HmktmYZo?=
 =?us-ascii?Q?CxfRsB4ZHd5nIEnK2/UPpSvd6N0eAPwpM4gh/ykrGOUXWl/469DVTTS/d8vv?=
 =?us-ascii?Q?FxjsiFb/ivK+mGmrd0oPGPSlfFbnYsdGm0g2t0Qnl4bHzJzaAePQQEL9TvD9?=
 =?us-ascii?Q?/xJz/8vMNohBfZJpq0rzMfZZ5nFgRQegNn/dq2II37sNxsxJCfAejlLiCAzS?=
 =?us-ascii?Q?en89bf8eRzAVmEKegL6VCp1fKh0N4RkEwXAH+RJDxsRq5GLEpYAO59SbybRu?=
 =?us-ascii?Q?uNbD5W0lTfJfx1NYJrZ3N5IplrVCUH8SkAgLULoQ4tZ+3qo5nDA4PD/3OVGa?=
 =?us-ascii?Q?Ic6iwzqFuiVP4vM35a6MiltuPIu3pS40Vr2i9gMWvasw8yRz3eomHY1yotGS?=
 =?us-ascii?Q?wmuDOc2B9S80LITa3evhlxL546quLUhWE8itj+kP8IPEzYx+sZPo2ZYnesTe?=
 =?us-ascii?Q?GxsVinNLkNBaWi1GE7JE/jXSfthpwenvHU4TgZy8+X9yjPa7yFsr68sSAbyc?=
 =?us-ascii?Q?z8Pv57n4NSCBCwSr9UhqVdEkAtDta6aM6K1huhnJLOyMOfzKYDMQ/UMYPCQo?=
 =?us-ascii?Q?4dC5sJv2b7u03bMgl/1RHHKJiF3T+MOWQquao+WbgZBqSU1AIkdhD4Q9Foaz?=
 =?us-ascii?Q?2XChJg1fInoVqjla4lCcIx3wEU6Tmi8CraUh6TPOtcgqrbxbgymaEoNfQYKh?=
 =?us-ascii?Q?NHioIcobuHMGaA2Xc5xLVzmw+jKEy7s02sOSw9etXzEXO8J/C1zTRmoxHWhz?=
 =?us-ascii?Q?mCIWYVrUiTS6y2z0JAdxoFMaDLv3yqXU50O9/2ZWncgi8/FRJ7UTV2TMqCfG?=
 =?us-ascii?Q?Ko8xwqwwphIrWM0EZN65lxTdq5ab98KEH/QRMvBigHABgnybqT4u8XvQlFKp?=
 =?us-ascii?Q?K2otd9lwsUSLZG0Uo6m/j+T4XF+hCCGs6JJwNgVFqOdDls6CAtm4sHkrGSeo?=
 =?us-ascii?Q?yt2ZSX3jBHZ7ZllcaW70V9wqMWw8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jDo+sGJzL1PNxtlSP7ZGD1ggcUlz/ZqBL2FKLwXde7fBc5CAkbLqO3cR55Gp?=
 =?us-ascii?Q?7NB8zXR8iyULXEQkp7cjjJURRiiz2aa1dnHq99P3EWjDDBrZwOO2TMStNA/J?=
 =?us-ascii?Q?ukUjAVX6Hh8WjXMdncbG7iUOhkVC7N5QpvTDiqSxjFZAFiQyrley3wHodxpu?=
 =?us-ascii?Q?DQgeKwZBWDnMKRrdenQ4rid3M+bouY6Oq/h9pQoZ6K+XUV1G6ouVn50kRNKh?=
 =?us-ascii?Q?HWeZZXvvx3LFaUEEqbaPS1ylNFo5dmL7ZHSrsEz7KdC1fCPCZjhf+ZjuBFpO?=
 =?us-ascii?Q?SjMjbEPkLMBs/x5b4f2ALfbf+wHdkRzT7/ADf7K8DuL22ARiH3gSLP6ydSB0?=
 =?us-ascii?Q?dyqHev2sxpdu+GcjZxyIsmcLddQ07DYBOsJlwpi1fDoVDKf5GTHn3Z0QGbpL?=
 =?us-ascii?Q?/QkD1gpKOTEQR3y6J64hhLrRyG20rfcSPX2q/YN+6Z8wMMy37lpoT9qcyHrw?=
 =?us-ascii?Q?oLuj87t2NXu7mUFTJ5glYH2Mp+j1F4/oA9YRJh0kG4PCnCwr/Ti9pYwxl4la?=
 =?us-ascii?Q?Vg+P/lE64pTN/O0atPYF9f9m8JgZHLoxu8kyrXgvcB8RGqwcicenX7pWJO/E?=
 =?us-ascii?Q?cnTR5lLbCYtfSFXE2TZ0DOOseF//ZAO7ZLEHfRPuq9HSrTF8tnDvpk3bnAqs?=
 =?us-ascii?Q?tcx18+KtiiAJ5wY0nEk3lm7EjuA2fYvU9/mvDqYDerfVXxkkbhUcEd3IBCon?=
 =?us-ascii?Q?XWW1Ar2GG5pAX3zcDRALoMME7dfPwLnExg4hZu9TbVYGyoyG5p6D3c7MFNiU?=
 =?us-ascii?Q?DwupXDpV/m8uAvcD7W4yV8QHKuovkEpdYdyIlICmHfz2X7ikYOew374+IyEd?=
 =?us-ascii?Q?xgOM6k8rJdGFYKSwKcM/RebOY+GNpYBuO5WfaurX/Ms+NR/U4dEygG1CRsZL?=
 =?us-ascii?Q?NI70ksacFKrWHmxgv7H9QTc7ov5cy1tg2ZfSJiGrAHTyeHY/luuIcqX4TujD?=
 =?us-ascii?Q?ZJxmWNX2JWaUmymmFQAoHrfTT97DOfN3Psanh0nW9MZymArFwfOGowFEgUTR?=
 =?us-ascii?Q?a2XIhO15dk9YVXfE9qESOEUNBussuHfkMGNOjTe9UPdLG6Ain/kLNMAnjR9Z?=
 =?us-ascii?Q?V4x3gQOPdxwKmBaFiuXLEVYGG42VVtPu0x6FrcrtxWg1kN46J4URXJPc73Al?=
 =?us-ascii?Q?FkPOK6TEWTh1UdoQtNYicphF53LchC+nsforsoAJwWWt/AxD+gFg1JFrDT8N?=
 =?us-ascii?Q?C4RvfQgTlE72AuuD81Mjt62tdB9h32dClOy9n/gau3T2nKixoiCnquthsX11?=
 =?us-ascii?Q?39suMYDbdpBtHOOmpdJ/aEBeDJH44yXQBYFA6ui05zoclZ9SEoE62GEdcNmq?=
 =?us-ascii?Q?o+ouFxuI19AqNTSuh2lXS7BdoRojQFxrLIk9F59Vqi9QvzfX0z9GTrGxtJBc?=
 =?us-ascii?Q?D47uYPr19ss+Xebui79tTZd/VgfuG+Ka/+2CPUifTjQi3y2aRu15g6afHJ9z?=
 =?us-ascii?Q?AeuE7vOgZRT4Og11y5/G/Ju91z8AQSg2vyEYp0TrM3OBoMTJZZKeeFLjJ91x?=
 =?us-ascii?Q?MBNrOIR+WqKsgNN0K4ZTcOlPSwqoFsidW3YWbN+HpyM7U9YJIg7di+YBRz0r?=
 =?us-ascii?Q?33l6j3hraJT7fnWu6XgMO3lqI/bdh0R/XbTI7x0c?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a625443-8d6e-44e8-1566-08dd6ab4cbb8
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 09:18:10.6131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qtY6X2Nu2/y1jyfxW/xM0Gueekj97dGpH9XdtbUPyWjPovjhkaeZfSahyRYUMNV0H53iJRCiEi/UuoyvsU3vBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7760

On Mon, Mar 24, 2025 at 09:56:16AM +0100, Andrea Righi wrote:
> A BPF scheduler may want to use the built-in idle cpumasks in ops.init()
> before the scheduler is fully initialized, either directly or through a
> BPF timer for example.
> 
> However, this would result in an error, since the idle state has not
> been properly initialized yet.
> 
> This can be easily verified by modifying scx_simple to call
> scx_bpf_get_idle_cpumask() in ops.init():
> 
> $ sudo scx_simple
> 
> DEBUG DUMP
> ===========================================================================
> 
> scx_simple[121] triggered exit kind 1024:
>   runtime error (built-in idle tracking is disabled)
> ...
> 
> Fix this by properly initializing the idle state before ops.init() is
> called. With this change applied:
> 
> $ sudo scx_simple
> local=2 global=0
> local=19 global=11
> local=23 global=11
> ...
> 
> Fixes: d73249f88743d ("sched_ext: idle: Make idle static keys private")
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Sorry for the duplicate email, please ignore this one.

This is the right one targeting sched_ext/for-6.15:
https://lore.kernel.org/all/20250324085753.27112-1-arighi@nvidia.com/

-Andrea

