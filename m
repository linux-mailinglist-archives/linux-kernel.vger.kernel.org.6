Return-Path: <linux-kernel+bounces-362580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E59F99B69B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 20:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A6381F20EE0
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 18:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108BF14A4DC;
	Sat, 12 Oct 2024 18:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="MYFBqgE8"
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020142.outbound.protection.outlook.com [52.101.196.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB90943173;
	Sat, 12 Oct 2024 18:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728758226; cv=fail; b=qlkVNa1Nmc4yXqVu1Jzu5IBcHNFq3ijfxC9HBR7lFvO1+QARjEYpkJwDk9m7ZlBbRQLw0Tk45WboYWnWzb6lE7NvediTiVSaARTasE9HTczmxKdx4MgHey0je48iIFpBTCicHdsJluwq9qiPNk4tulPihuXGItB7cdSg+RGq6XA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728758226; c=relaxed/simple;
	bh=isoi/XuXLKiFIkXw8gw0jkxRABRJ4057Iq3h/vJRKkE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b9DQZOj/1QrWJ3MZz7jHRM4c+TbTrf6/ipX5B4CdfjZoU6sN5AbGsWRbURdDFzxshTE4jDPA+DI0BOhfe7BjLa4GHBGzQB+JX05EOYSVVCtUMOi2tftHPfRupG9MPV3Caktneltndf/2kXjwu5ni4hhpFF404jpKlGlvT8drMGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=MYFBqgE8; arc=fail smtp.client-ip=52.101.196.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rNwObb1Bld1D1PvTq1PE5IgMYudj0uGp0r2blHXRTDkYGR0XeYW89QhxT5EqYuNTinkSycNCnJKMzFxi3mJ8U3XaVYOaO20+65rwHT1zqtQJZoBtd1xV8i3JbHYgOroxmfygjK+XlsLpAouzbTZj5ikza7yBwZHBfzB5ePUG8cmRHeLe6ZJmYsrONAZdqXdSLctxKDPZnA4I8KrykkGWpMR+C5kDsItc+vrLA+covUAox/Jlb2tMshog3/mvHKaq0vGVL7BO5kF1KVPGrT0DrApjTLrrgackLPQdCgA6yUj5soYtM/bdDb27czxeOCbmIjmR5Ggjc8w7wwkoj9B1UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/AWjbMaJkXZywBZSfAwh5EsUEIHe4jq/AEeq2PVo/2g=;
 b=WYB8lyXJFZsPd+4zfpT9oJ7opWRNwIdzWgCOTMbUt+OSQiJuSavrpFLYg8FDkTiIMbm1cejLCvJwFyyKoYy0qYZ3IGrfnS720ZDgDV6uuRyd5wzz8LWX+5AntW7L6vZMGj1VPy3IQeNFcGJzVjgAW6wJaqB++aNL+Knrcp01t9Lus06FjMAbjU4ZyiHM95S2ezQXRE8wvkOg39Dk4aWEN6DXFJSOpfzLJOBdCke4hxe04jIiO+CIBbTO7HDqhw4WzjCX0h3tsrNAFS9D8AdxcJ2vb7ajahG2NqGnpJyMgvKjngkjOA+vYzakrh2mjHSY6bu/v6F+/wPY/I+b89XYXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AWjbMaJkXZywBZSfAwh5EsUEIHe4jq/AEeq2PVo/2g=;
 b=MYFBqgE8mIL4ZXkstbYqQLIdCEvHw1WJw8X4GgSv8MOpdqq4CTaGsvJGsAj/XrCEU4hwpeETFCWnINSEoCG3Rs27ASPPeXzqeTMoSIJlD/fTU4xYjAKP26c6dABIdMXtInzivAEfLv9xXL/aFMeDW4aDJGvTyVNZJe8uczt0XW4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB3668.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:f2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Sat, 12 Oct
 2024 18:37:00 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8048.020; Sat, 12 Oct 2024
 18:37:00 +0000
Date: Sat, 12 Oct 2024 19:36:57 +0100
From: Gary Guo <gary@garyguo.net>
To: Christian dos Santos de Lima <christiansantoslima21@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Miguel
 Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas
 Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>, ~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH v2] rust: transmute: Add implementation for FromBytes
 trait
Message-ID: <20241012193657.290cc79c@eugeo>
In-Reply-To: <20241012070121.110481-1-christiansantoslima21@gmail.com>
References: <20241012070121.110481-1-christiansantoslima21@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0080.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::10) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB3668:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a0c22a3-7ed1-4623-561b-08dceaecdbdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|10070799003|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eeS1HZJpmi99TsFOB/EV3+yyFVcK88GZsgJKFpXM0ReGtvSnQHf55WB6Lipb?=
 =?us-ascii?Q?fA88V7yn9Zc/73TDHm9jkdo0FUJdGl+uZYOXKFiQARNCseeYiL9DPqBnnNzg?=
 =?us-ascii?Q?imowfJpqU8PonnjNZrInST7FQHKIG4Iz4yiqJYo12kEFjCDdMHXc9WfwNEeD?=
 =?us-ascii?Q?EvJbaRBn/wN8QbaS0PAQDld/grGtATjFEyngWDUdJ/0ieqWs8pP2kB5jwT8K?=
 =?us-ascii?Q?2AFIAc1hnDQbv69w+o+d3o5NsXKM1/joTHaXS2klOgyEcw56VviDsF8E6rGI?=
 =?us-ascii?Q?AdqdbjCcKlVKDrqs5K+bqmT7xj7pLl0JZLoun9VjaNO3tfCuKUGzIFTucek6?=
 =?us-ascii?Q?cJh1FrLxWLzYemMaL8v5BOh+vlVX9E+CIa8NmewSDYBqYwApCeJfMnH+ooxr?=
 =?us-ascii?Q?07uXmTgN3aphacqLyRY0r67mzAAzrZ2fQ+HG57KuMj6U7TwuxQ5nsBe8zSB+?=
 =?us-ascii?Q?etdRKScB0zkGTeJCMKFdSTz/mk08ASMPuZn6bdWMnFuF4f/d4GoVtg+ZWn3z?=
 =?us-ascii?Q?Sth6Xm61wqQtcRxKTCxSdbmL80EchIAzlLip+sUv7pB2TG5APBOt0UzsCNFG?=
 =?us-ascii?Q?560cMv+lP9xB+ZDNyP38+D39lABpXjJstXSlQ5ItoXSyRqTM1xoNFgz7Cq5U?=
 =?us-ascii?Q?V4fNPu5FS3fMqFx9MME9UlrsZ8Uh+i0MTwM+CFUS02xaR9ECplgmwM3wEWeg?=
 =?us-ascii?Q?5rLRNJmgRJcue6A62YKQDIOyoxyijuaJiH5O/6g2p8rubjQ1p627ZI6QoBLj?=
 =?us-ascii?Q?pstzCcntAwk4IHdtGZCoH+fLK1glC0gus0I5olqd2IRVHSCb+TjVulrxB9zx?=
 =?us-ascii?Q?5QFSfXcBzAV0h/YWYc9rvQFhVBxkGclLZ0GN4oJoKNe0yj7blR+ijZ4Rj5DL?=
 =?us-ascii?Q?ZbY9zx+gZ20mOH+r5HZL5XtF6npb8YNDG7uSET4NwC2DUCWtGBWIm/u3vo8r?=
 =?us-ascii?Q?hJixW/hWwrRwtpfYTp/PBynvVmZjbX4XGYeha5v5RLGUIx9RNCz0J2Zi/7QD?=
 =?us-ascii?Q?qu09+VTfLrYiZIKvXHyuZbPc/XBxhqAL5/MTvFCXeDTAJfACUSoBVOU70jAM?=
 =?us-ascii?Q?eQRXsfDAIM+NzrY3WVdtv/oI0frEvdcQqyh+YX/4YiDA7LdKuI68mr53wuQP?=
 =?us-ascii?Q?A8P+J3uFmYH/EB86oTQVTq7Qh5zjU6JEL0ho7sy42DIWS6fJ26fRwKT2fR1T?=
 =?us-ascii?Q?Df8EE+5w6Dm32wAjaSS20dePpQsKsDvFMUiyipqx09pY7MFFlbVih0CQ/eo?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f46XxWFZ6VSyYJTYwHCDPMTLu8w7OcAT1KZFGeYZXMtCRYEoszYidvIandoQ?=
 =?us-ascii?Q?AeuZWbxQq8kgiSfthoAk8CSAszdN5VeTYBd6jxELC4waSyuLzG99CIM/wmr3?=
 =?us-ascii?Q?k7RjQqbGV7peBP/FKhFVgJlqyrxrD9U5rPR2uhA959nWSJKbnfkuw7Y+KijD?=
 =?us-ascii?Q?RD6dof4bjgOCvrbNB2KUF575QJ+tEEcuasiWmI2ttm8uOY94mK/ZuSPusAH0?=
 =?us-ascii?Q?v1NgFN5+FsmKDW/9CEDP/s5tQHRLt7xO32kRKx3f/6a9iwNV2cO5tBQZOQ7J?=
 =?us-ascii?Q?qXn9ZuTTJh//epXeUG2qpuW//VAeC7LN6/xkhNp+eVcbQpQCZuKUCQ1MPgXC?=
 =?us-ascii?Q?Icy+4gePqvy/rKufZ7Jio8+z7NSs93R7nbV70TOHx43848Iq29qlGLQe8H5q?=
 =?us-ascii?Q?Plc9BUSv0vtfs95EzfDI8ydY6eMHbxi0KkpAcwVQ5d5oeoW3eryOm0wwfVL3?=
 =?us-ascii?Q?ewiBsvR5+gcU9og2JYr2KPfxeIwhQf+Fa3L5zqhqy1DPVELGxuMJZ0Jg64WW?=
 =?us-ascii?Q?+ieMsvsBmZMC79TY3PE8iGNQa2fFs4UYZYY6x4Yt58RyUaZHTHxybXQzWabR?=
 =?us-ascii?Q?kFsLnU0ZOd8LW5Rzc7oZG6sZSWZECGWyqCG8SZq1YzhBQmQr1IDNKQwlYosA?=
 =?us-ascii?Q?wR/UByRstFpsdm6TlC2mKWI3fUhOlyxLSVFiQPAyAInpEVnQT0SRObWesnRA?=
 =?us-ascii?Q?mWMx7ArcO/oTuoTtG8ZHs+81ohhAdwc7TVu6u9kXXgMn35R6U/3GsRGbxaJr?=
 =?us-ascii?Q?waBF8V7KfxHW6DwVhkYN8AbSorAOWNbqJewpob+2m0wzzGjgL9jZdlpAEBBX?=
 =?us-ascii?Q?OaIT3TNQA/jyLn0hQSifKl/qEJQkvmDf/PSod7MvNK6qv96pY79HycrO4VJN?=
 =?us-ascii?Q?h3EXSwKX4Qa7MP50dRCdSznaz/CINOBh//pT1lXL0G0KfdKGjzfbuJuNFcBU?=
 =?us-ascii?Q?tYWQjQBtD+/5+KCwVrkE5DHVzS7VgTqxBSpyAT+kf50Za4F7VBY0YPGgr9y2?=
 =?us-ascii?Q?hyHJ7BEPYPxy5roJJQP+YXz9n3rWXSt0yelFS05kaFLmO2h5jFy2Wt4NssXj?=
 =?us-ascii?Q?UnlEoT48mHqBFXmFuuXY6Qugrlk9dUi9xYOoeHCEWn9ZMcJZc7DoKTAEOMBe?=
 =?us-ascii?Q?MsZkL6vmK++Sa2WygXodSOqOLUKbAsIgNdDQgPeYiybVMKygwZu0jmUjPeMp?=
 =?us-ascii?Q?ES9MjKth9RKvjqIjqs2q/uLPTMsE0zr7hegh7cMdnKg3bnUYu7D4uexKa3a0?=
 =?us-ascii?Q?02lsTTQmFPYXWtWI8bzu3b06LD3URW8NflQGjPC3aLn/VhhAtJuP5HlmA/nA?=
 =?us-ascii?Q?N95co2O8DFXhniUOouOi4o+bwo8WJq7raNmCXopZvl+Y5ufZLHhmxoaXYH+b?=
 =?us-ascii?Q?AKKNZkQaJNG5cyr0pdwRqB5TQuOSPbS1Ouf6rgsuyNswGXX6G8oqj4FY03wL?=
 =?us-ascii?Q?TndYFMW93kgPKMa+Ir7zkSPFvKT6zczsiHSjMbsbEVPB7GPeRZ6BsHWFfFjb?=
 =?us-ascii?Q?PMO+WW6g9bijTj2SrWR5L19iYtbsLkd0Ct1cwnHFUDzT/J+9Ex0v4uNRCp43?=
 =?us-ascii?Q?F2GX0UxyjiKLAUB52SQGAwBYwoM+Wz9lIODJ9Rf1YdanTZ70EweCXQ6n5MMc?=
 =?us-ascii?Q?AABEzQFd8yQCcP2HlO75nS4bmATU4/Rrzpubb6Ak4wSB?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a0c22a3-7ed1-4623-561b-08dceaecdbdc
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 18:37:00.3482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VaW30H9Xalwv5giAY6j3ylV+cnsoXM0Wf4EwLi3y5njn+6GCEQmRtkE0FDPlA6CDSq0c3gVPMBaiE9LEBwk9qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB3668

On Sat, 12 Oct 2024 04:01:21 -0300
Christian dos Santos de Lima <christiansantoslima21@gmail.com> wrote:

> Add implementation and documentation for FromBytes trait.
> 
> Add new feature block in order to allow using ToBytes
> and bound to from_bytes_mut function. I'm adding this feature
> because is possible create a value with disallowed bit pattern
> and as_byte_mut could create such value by mutating the array and
> acessing the original value. So adding ToBytes this can be avoided.
> 
> Link: https://github.com/Rust-for-Linux/linux/issues/1119
> Signed-off-by: Christian dos Santos de Lima <christiansantoslima21@gmail.com>
> ---
> changes in v2:
>      - Rollback the implementation for the macro in the repository and add implementation of functions in trait
> ---
>  rust/kernel/lib.rs       |   2 +
>  rust/kernel/transmute.rs | 120 ++++++++++++++++++++++++++++-----------
>  2 files changed, 88 insertions(+), 34 deletions(-)
> 
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index dc37aef6a008..5215f5744e12 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -18,6 +18,8 @@
>  #![feature(lint_reasons)]
>  #![feature(new_uninit)]
>  #![feature(unsize)]
> +#![feature(portable_simd)]
> +#![feature(trivial_bounds)]
>  
>  // Ensure conditional compilation based on the kernel configuration works;
>  // otherwise we may silently break things like initcall handling.
> diff --git a/rust/kernel/transmute.rs b/rust/kernel/transmute.rs
> index 1c7d43771a37..bce42cc7265e 100644
> --- a/rust/kernel/transmute.rs
> +++ b/rust/kernel/transmute.rs
> @@ -2,6 +2,7 @@
>  
>  //! Traits for transmuting types.
>  
> +use core::simd::ToBytes;
>  /// Types for which any bit pattern is valid.
>  ///
>  /// Not all types are valid for all values. For example, a `bool` must be either zero or one, so
> @@ -9,15 +10,58 @@
>  ///
>  /// It's okay for the type to have padding, as initializing those bytes has no effect.
>  ///
> +/// # Example
> +///
> +/// This example is how to use the FromBytes trait
> +/// ```
> +/// // Initialize a slice of bytes
> +/// let foo = &[1, 2, 3, 4];
> +///
> +/// //Use the function implemented by trait in integer type
> +/// let result = u8::from_bytes(foo);
> +///
> +/// assert_eq!(*result, 0x4030201);
> +/// ```
>  /// # Safety
>  ///
>  /// All bit-patterns must be valid for this type. This type must not have interior mutability.
> -pub unsafe trait FromBytes {}
> +pub unsafe trait FromBytes {
> +    ///Get an imutable slice of bytes and converts to a reference to Self

missing space after `///`.

> +    unsafe fn from_bytes(slice_of_bytes: &[u8]) -> &Self;

There's no safety section. The only reason for this being unsafe is
length mismatch? I would rather have the impl perform length check and
return an Result type. If there's a case where length is known, people
can use `unwrap_unchecked` instead.

> +    /// Get a mutable slice of bytes and converts to a reference to Self
> +    ///
> +    /// # Safety
> +    ///
> +    ///  Bound ToBytes in order to avoid use with disallowed bit patterns
> +    unsafe fn from_bytes_mut(slice_of_bytes: &mut [u8]) -> &mut Self
> +    where
> +        Self: ToBytes;
> +}
>  
> +//Get a reference of slice of bytes and converts into a reference of integer or a slice with a defined size
>  macro_rules! impl_frombytes {
>      ($($({$($generics:tt)*})? $t:ty, )*) => {
>          // SAFETY: Safety comments written in the macro invocation.
> -        $(unsafe impl$($($generics)*)? FromBytes for $t {})*
> +        $(unsafe impl$($($generics)*)? FromBytes for $t {
> +            unsafe fn from_bytes(slice_of_bytes: &[u8]) -> &Self
> +            {
> +                unsafe {
> +                    let slice_ptr = slice_of_bytes.as_ptr() as *const Self;
> +                    &*slice_ptr

I don't think we want a manual implementation like this for each type
(even if it's abstracted behind macros). I'd suggestion take
inspiration from zerocopy's KnownLayout type:
https://docs.rs/zerocopy/latest/zerocopy/trait.KnownLayout.html

Best,
Gary

> +                }
> +            }
> +
> +            unsafe fn from_bytes_mut(slice_of_bytes: &mut [u8]) -> &mut Self
> +            where
> +                Self: ToBytes,
> +            {
> +                unsafe {
> +                    let slice_ptr = slice_of_bytes.as_mut_ptr() as *mut Self;
> +                    &mut *slice_ptr
> +                }
> +
> +            }
> +        })*
>      };
>  }
>  
> @@ -28,44 +72,52 @@ macro_rules! impl_frombytes {
>  
>      // SAFETY: If all bit patterns are acceptable for individual values in an array, then all bit
>      // patterns are also acceptable for arrays of that type.
> -    {<T: FromBytes>} [T],
>      {<T: FromBytes, const N: usize>} [T; N],
>  }
>  
> -/// Types that can be viewed as an immutable slice of initialized bytes.
> +/// Get a reference of slice of bytes and converts into a reference of an array of integers
>  ///
> -/// If a struct implements this trait, then it is okay to copy it byte-for-byte to userspace. This
> -/// means that it should not have any padding, as padding bytes are uninitialized. Reading
> -/// uninitialized memory is not just undefined behavior, it may even lead to leaking sensitive
> -/// information on the stack to userspace.
> +/// Types for which any bit pattern is valid.
>  ///
> -/// The struct should also not hold kernel pointers, as kernel pointer addresses are also considered
> -/// sensitive. However, leaking kernel pointers is not considered undefined behavior by Rust, so
> -/// this is a correctness requirement, but not a safety requirement.
> +/// Not all types are valid for all values. For example, a `bool` must be either zero or one, so
> +/// reading arbitrary bytes into something that contains a `bool` is not okay.
>  ///
> -/// # Safety
> +/// It's okay for the type to have padding, as initializing those bytes has no effect.
>  ///
> -/// Values of this type may not contain any uninitialized bytes. This type must not have interior
> -/// mutability.
> -pub unsafe trait AsBytes {}
> -
> -macro_rules! impl_asbytes {
> -    ($($({$($generics:tt)*})? $t:ty, )*) => {
> -        // SAFETY: Safety comments written in the macro invocation.
> -        $(unsafe impl$($($generics)*)? AsBytes for $t {})*
> -    };
> -}
> -
> -impl_asbytes! {
> -    // SAFETY: Instances of the following types have no uninitialized portions.
> -    u8, u16, u32, u64, usize,
> -    i8, i16, i32, i64, isize,
> -    bool,
> -    char,
> -    str,
> +/// # Example
> +///
> +/// This example is how to use the FromBytes trait
> +/// ```
> +/// // Initialize a slice of bytes
> +/// let foo = &[1, 2, 3, 4];
> +///
> +/// //Use the function implemented by trait in integer type
> +/// let result = <[u32]>::from_bytes(slice_of_bytes);
> +///
> +/// assert_eq!(*result, 0x4030201);
> +/// ```
> +// SAFETY: If all bit patterns are acceptable for individual values in an array, then all bit
> +// patterns are also acceptable for arrays of that type.
> +unsafe impl<T: FromBytes> FromBytes for [T] {
> +    unsafe fn from_bytes(slice_of_bytes: &[u8]) -> &Self {
> +        //Safety: Guarantee that all values are initiliazed
> +        unsafe {
> +            let slice_ptr = slice_of_bytes.as_ptr() as *const T;
> +            let slice_len = slice_of_bytes.len() / core::mem::size_of::<T>();
> +            core::slice::from_raw_parts(slice_ptr, slice_len)
> +        }
> +    }
>  
> -    // SAFETY: If individual values in an array have no uninitialized portions, then the array
> -    // itself does not have any uninitialized portions either.
> -    {<T: AsBytes>} [T],
> -    {<T: AsBytes, const N: usize>} [T; N],
> +    //Safety: Guarantee that all values are initiliazed
> +    unsafe fn from_bytes_mut(slice_of_bytes: &mut [u8]) -> &mut Self
> +    where
> +        Self: ToBytes,
> +    {
> +        //Safety: Guarantee that all values are initiliazed
> +        unsafe {
> +            let slice_ptr = slice_of_bytes.as_mut_ptr() as *mut T;
> +            let slice_len = slice_of_bytes.len() / core::mem::size_of::<T>();
> +            core::slice::from_raw_parts_mut(slice_ptr, slice_len)
> +        }
> +    }
>  }


