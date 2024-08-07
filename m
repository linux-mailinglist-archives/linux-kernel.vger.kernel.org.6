Return-Path: <linux-kernel+bounces-277783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E379A94A68B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 031A7B25E79
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597FA1E2111;
	Wed,  7 Aug 2024 10:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="BhEJa00d"
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01on2100.outbound.protection.outlook.com [40.107.122.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974711B8E82;
	Wed,  7 Aug 2024 10:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.122.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723028235; cv=fail; b=lVS1N7IVPJH0HyGz1K0hHRZx7/px3Jgthe1lGsSFu4HaZSqwHkb78/fPgM71gq1Eeq+IvP8sXB+AbLMYWdyjBcs8yIBJZLSsU79eofkc+bq3oB60HBKTTZAVP00npDoVjKAHsBFkRNOa5XQMsZNf2FP77W4QbPET6xt9Z+JsKTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723028235; c=relaxed/simple;
	bh=/8Cq+oIrMxrX/d51x0H9fplNY8jA/5geUq8eTVFTzyE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZydCdH835ZGTzHy5QZ7vevHW7RbDP0DDBHysreTxeSbHMpAs7Ek7gfASUZVIaa9P3c8L6syIbugGtvEWdvaU2aSJ1bwzavGFra0XuLRkKA6AplP4/ZznSGWwWabIsaxQ7r34sjlk88WhUHeOBVku+Bv+S1p4dkiuiKmPl+4rZbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=BhEJa00d; arc=fail smtp.client-ip=40.107.122.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fbFHplZHXPDpyA38F/FCZsPbVO4Y7g0kTVk8tqN+vsFX47J2e6uZCXCxjIBryxHCcPzcj11sFh7mZj65y1SbUuccJ2/U42f6y2ERt2E4lwiy7OKxWycT2jo88H8G74npON8GQLQebMJOxJ+ZLSTxoo67LPSt60jdxYmnE5mJwiliqwu0hMRXJzJ4KPmqb9vsX//BsGa6mEw+VvAuzB0xbqQmqwh3k8V9uOOOPNH3OhxgAxEigUMHr1XcUPGKJV6Oq7ItgIvQAJrnnQjzIDujn8mJAYmJdNlKmPf6jSjkmRHJC4P6vijCIjEej3a8asHARqcAV1+JhHpNlemRsCfMOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7hmOd/TYJ6ribJS+flQ8WW0wgklKSLpgI2nwweAR7w=;
 b=a2jcK57xunqTHn8nZRGE88xmC6lVBpag7j6RxNn914852+Beylor87gHOP2a0t4QEs/1ePC6mFCNQLz/MbsgStP7N3Ap6dkfG3O8c+O3++MHvW/fQoliOOyRygKC6ZjdKLbU4OvSjlP4nqS2Dk53muu5d6gu9zPJmlky2DUQ0W2XfH3ufrnJW4C1t68uPptRlcG1OtMJCZq15D1ZD1+1E4p8sIYM9FbymMjoNif2lu93wxqFJlV+wdDRxmEB29/ZAZPHTxJn83JRx03weW+0ddL3y8ZeP9pybM0vBqlKNo1CwVyuBzTfkQvN9fu36VFiAcz3GU6Pc/wLfGjPKbZgRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7hmOd/TYJ6ribJS+flQ8WW0wgklKSLpgI2nwweAR7w=;
 b=BhEJa00dPbhZGWGR+UCvt5vgUgjN7d0/crkScaMaYkQeC3NJba6nfDhbE0NPaEYl0NS2e/J8AHxwRFcIz+PJE9Twzu9E35NNSxni9CvPe3wdkYIEAnQXWJI0eWNqcqcRi343EIeAzFP3dnjUtDQHF+y6a9a0X6GoXMRlBs/yH2U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO3P265MB1882.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 10:57:10 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%7]) with mapi id 15.20.7849.008; Wed, 7 Aug 2024
 10:57:10 +0000
Date: Wed, 7 Aug 2024 11:57:08 +0100
From: Gary Guo <gary@garyguo.net>
To: Zehui Xu <zehuixu@whu.edu.cn>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
 boqun.feng@gmail.com, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rust: Kbuild: Skip -fmin-function-alignment in
 bindgen flags
Message-ID: <20240807115708.394a8eb3@eugeo>
In-Reply-To: <20240731134346.10630-1-zehuixu@whu.edu.cn>
References: <20240731134346.10630-1-zehuixu@whu.edu.cn>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0067.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::18) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO3P265MB1882:EE_
X-MS-Office365-Filtering-Correlation-Id: 86d3ce11-7e1e-4399-71f4-08dcb6cfafbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dxSDmFmHG/fQhy2CPnlv5V+RZnb4BYdJJ/WI6kRGbfop3L55tTw4jt8sGlpK?=
 =?us-ascii?Q?7BiAsYiKLk2ZjhXUfw9jV1JeGKgnECcz/D0onFcEwv7LYVLR6W26M6HEEnsJ?=
 =?us-ascii?Q?BiU9KiHgsl3ilPAlndTQP7nBM5QqOoPCxLJZqxsHUNgywAjlbKAAvmRASzOj?=
 =?us-ascii?Q?Y1VHxI2sJrQ/ltU4NYqEwzY5mvM2r8E/3HImQmr7Rf38jBJ8W/Lzct84k4xW?=
 =?us-ascii?Q?IlmSZ1WaAPvLzROJrHDs5B4wB1vCTQNpWCEgf0Xa+9jhmoxNGJIN1dzPVJkK?=
 =?us-ascii?Q?WF+xRGYbi0x0/rgt8cZdoz7a2sP7Ng0eFsoO6gAGXngOhS9NRZbJKneEXhWy?=
 =?us-ascii?Q?af603OZWyM9piyEKM80lipne1te/G/7Xp0/KeRyCbbmA/oIwNDR80qoRFdH2?=
 =?us-ascii?Q?Rbcnl0vASawKZdHt7RNtlZUVjqpslg9gJsc+iAq7xxLllqhh0IcNPZfbaQoc?=
 =?us-ascii?Q?RN6zG5xJU+1QgHWd5Fa6SYOsWRzDmf8JTttIPgaHuPYlukA3PwFBrB1u5D27?=
 =?us-ascii?Q?p3U+hrfrk99qBOXAKM+28UQ3hy5fXgKrSwKZR8j/6V1xRbz2EG9BfXi8/LDX?=
 =?us-ascii?Q?6l4lUDxTtZG5bsco2a2f+qPYm7sgka/UJBj0zKz2vlSzS88kK4rKs93UBkP9?=
 =?us-ascii?Q?tc/7wiOa9oV4Wnag1PtrUJMitT0ZY3p0Ag2E/faOM+lpl7LzuN3Tj78kV5Hb?=
 =?us-ascii?Q?0a0xEjEzaJC9n3EBk2elAWOqRNlIm6qnKiBrtuxT5T1Ir+EBQs7RjkYiztLi?=
 =?us-ascii?Q?oJOk1M3HDgi8Hoo6560IDTUiV+WwdsHe5mq2S3GMgEx8jKJHIHJ0Wlk5KLZ8?=
 =?us-ascii?Q?VAfuqhaVcGtynmfU1xXYBlQWBE0Mdph5T+fhXUzNGZkjEHpV7fVlqHF/nzhK?=
 =?us-ascii?Q?phnlYFT1sf704CEFXZP4YIlp4saCPAsnIQw/M+7u2OpRRqSp3CfQZOlnu4F7?=
 =?us-ascii?Q?VrgniauKpHaA9dEzleSpE/Gx8YapEd/a/jAtHGkKhYk4MqBjBs5uw1z+XJPE?=
 =?us-ascii?Q?eO8ZtoeglCjNlfDO8zTYTQ2XKBR+zfR92X+1hEVceLuCUSTamUMMriqgxjMn?=
 =?us-ascii?Q?3+nBkFPZMD8TBBce8/dZ+HNkT4t26V+JgCXPSh2kEOpkCjj/b3AWkyCqgwnW?=
 =?us-ascii?Q?8+pEeLbWI+z2/DWQpmN62ZErhgtDuxNvZUwifjOF3HbzLBDyHnqCdiPn0f9k?=
 =?us-ascii?Q?W7jlrXkAGYlJjbu1U1yO96FjcpSOtEZxc39ePIqg8ZGC3QDHZpQMZaVVjNnI?=
 =?us-ascii?Q?1eLZf478KGiT2TkU0yua1mfS1+B4ZsOAQ1kqhitZRxQsnBK9ShGPsUNdKGRs?=
 =?us-ascii?Q?3lk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5Rpt5gID6eXdJ4j0MC0Tqd03zE4ZMFZlxmKfMaUfr1skdez6w698TUaPtMcl?=
 =?us-ascii?Q?Xur1BtCgFeKMV3MItZNnaTdNDZ3/juF58ZpzfXKbyr8CVE3ZvLI0RzHfC9DF?=
 =?us-ascii?Q?gQzhhL4oT6UiXnzgP25FSWCpncbpWhvKuHdJVVhrZ4MdnjQaIt4SO1K6T1Gc?=
 =?us-ascii?Q?qfWeuSRXz5rW5gY3gN/HWmF4izFREe0eUhpTLeOw1TBVbiXus7GlkxwvIpig?=
 =?us-ascii?Q?6SLZqslh8SZOXlz4WAGIQGeJD/RX1fEJ+d/gBTpg3yfLZmnA3/eH5qqm0BJ2?=
 =?us-ascii?Q?vQC9gbWoT5Q1EHie7UA6VvyxOWWsmxLlzfvGVBfoYnwTq1FUSOINNyPZI17s?=
 =?us-ascii?Q?fubYCrEGGc8m3eOVmm2C3fCvea3rSUbIop3my46s7YKkXUtW/oU27oobQ+kR?=
 =?us-ascii?Q?5Ox7tytX/QAprdoelaJ4HB5Nskge2w1O/WYapOO0ZL77JMNx3nKQ8c6iw38U?=
 =?us-ascii?Q?WgI1AoY5H4BxiGhDXLvn5WY1Zckm/dzZk/n84e/80Ho4YnJ5Ltr20DmmjBqp?=
 =?us-ascii?Q?N+i+lomSPSV+yauB78zLGmQoVdgH7pbwdKhCZ9uJw5tWKWlYjn3L+yfMDfAz?=
 =?us-ascii?Q?8XOgSPWsYLzZw1VAGpYqYhGGLPCIURcNDJHpm2VvAHalGufOnVnGdptCtCM6?=
 =?us-ascii?Q?Q2UKBL7eyIBdI4ocFpu131aKKTtzHKyRAvBmvFoNEjwM/NGwk6he0FE84Ouq?=
 =?us-ascii?Q?gBUQhgUXamnKRcVppiaMiAo5UaUDKTiW4nG+V40YhS6OTg8tyQkrHvYWWKdR?=
 =?us-ascii?Q?S5v9bmzyhpkMUGLfeC9emLYNmpfLccZgyFJFzwIHbF2ZF0aC1fLi83fj/fkb?=
 =?us-ascii?Q?fD6dteA5OaFaAp18lU6+WcPqv8whcGg1dmrukOBqHgUI6ORMMIZtDOCVGkes?=
 =?us-ascii?Q?J+y07hmpNiTlT9DzIL+DoRX2+LM3fBaUtso4XZ/0TBkggWyrZ+hXKT8lkiIu?=
 =?us-ascii?Q?8c6XCf00bpEHkkZg7+oyXbMLqwSC2Tuvtyh9n08u2S4/dxOtzMDfDK298spd?=
 =?us-ascii?Q?P6RlymNxFCJ1rGW9lVxfrSN/ACcNIw2Lrxea6LvplHb4YgrPtAxoOfXNUNB2?=
 =?us-ascii?Q?Hgm68r3X37nEIxiHcRmx06RNd3aWvjpAjWNPj454uBDAM2PJxRho+4dEX+Eo?=
 =?us-ascii?Q?ScfzJzd4wsUOZ6sPa/lBRs91Op38XqV87wSJQcTXQxcqEbSG/yysYm/lLJfH?=
 =?us-ascii?Q?HNbO8SbOBNPEaigGMRqdPIZ8DXIeXLg8JjBfLmKGQG9eNLUQqdNdLIxz/HKa?=
 =?us-ascii?Q?a9LCjJ7A+C95jB5i3wXvzSkKHCs4p2o+nsFYMqT4S3kId1Ig6g7HSy0oNXZ9?=
 =?us-ascii?Q?QQVFabyms/3IGaUDCtnCslPWdZ6/YPqKKk9YyDdT//pQPx881XTpMEsqTjwA?=
 =?us-ascii?Q?FQ8zBDA0tE/pMNyoNgiwMPo9ZOlfdDZUBMtg49Pjyo8/BwbAK0E3qNOvPBc3?=
 =?us-ascii?Q?hXGILmNqwyaDpIL8nYTjs+SH+TMPS2uQLiocTkFcyXh2E1Dma2MPaJdg6TIY?=
 =?us-ascii?Q?UzhMpR0f9gFO43clfVdas6J2irZj5aWf5NsO4ID95QUZQ8e/bcXqqIrAO3FM?=
 =?us-ascii?Q?Lf1vbdzTUx4X4GY0JewM2BMpiHO6O6Mw52IjiCWs?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d3ce11-7e1e-4399-71f4-08dcb6cfafbe
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 10:57:10.4005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sdEkUjkVkLg+3m8WEvCi0Q0olXCGMs9PmT2xMENhvSYHKDsi864qCPCd5ve0I61Cgpk2usJ7tCiQsPSwDcAtUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P265MB1882

On Wed, 31 Jul 2024 16:43:46 +0300
Zehui Xu <zehuixu@whu.edu.cn> wrote:

> GCC 14 recently added -fmin-function-alignment option and the
> root Makefile uses it to replace -falign-functions when available.
> However, this flag can cause issues when passed to the Rust
> Makefile and affect the bindgen process. Bindgen relies on
> libclang to parse C code, and currently does not support the
> -fmin-function-alignment flag, leading to compilation failures
> when GCC 14 is used.
> 
> This patch addresses the issue by adding -fmin-function-alignment
> to the bindgen_skip_c_flags in rust/Makefile. This prevents the
> flag from causing compilation issues.

This patch itself looks fine to me, so

Reviewed-by: Gary Guo <gary@garyguo.net>

We use -fmin-function-alignment for GCC and use -falign-functions for
clang. These options affect codegen only so it's fine to ignore them
for bindgen.

Although it appears to me that we currently don't set function
alignments for Rust codegen. Maybe that's worth considering adding?

- Gary

> 
> Link: https://lore.kernel.org/linux-kbuild/20240222133500.16991-1-petr.pavlu@suse.com/
> Signed-off-by: Zehui Xu <zehuixu@whu.edu.cn>
> ---
> Since -falign-functions does not affect bindgen output, we do not
> need logic to add it back to the flags. Thanks to the community's
> help, especially Miguel Ojeda. Hope this patch is free of problems
> and can be submitted smoothly : )
> 
> v1:
> * https://lore.kernel.org/all/20240730222053.37066-1-zehuixu@whu.edu.cn/
> 
> v2:
> * Added -falign-functions to bindgen_extra_c_flags when skipping 
>   -fmin-function-alignment to maintain function alignment settings in GCC 14
> * Used reasonable length and moved email content out of the commit message
> * Used "Link" tag instead of "Reference:" and removed empty lines between tags
> * Specified the base commit
> * https://lore.kernel.org/all/20240731034112.6060-1-zehuixu@whu.edu.cn/
> 
> v3:
> * Removed logic from patch v2 which adds -falign-functions
> 
>  rust/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

