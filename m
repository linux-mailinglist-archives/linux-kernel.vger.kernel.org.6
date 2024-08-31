Return-Path: <linux-kernel+bounces-309885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD13F967182
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 14:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF66F1C215E9
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 12:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D2617D340;
	Sat, 31 Aug 2024 12:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="ro2eQJQ4"
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2137.outbound.protection.outlook.com [40.107.121.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A4D17E473;
	Sat, 31 Aug 2024 12:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.121.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725106720; cv=fail; b=le2QLA2t+MJwSwz1U5ECNV5Fv9hXptVMi/PEgo0tozi+fQoZ+l4Y8wv3ffsLghXLX62qaIqCNeyzgMBt+bEZ0UC1uKHRv/riHcDF7JULpGAiCnf9UKJNWEUkgED+rnlpx5JSyMZ2BVSwMws3VLLvkovne4Z0w+C4KkdRc7pQt2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725106720; c=relaxed/simple;
	bh=CMjqY/OlKwxe8ai4MD7K02kdQIoEdKr6cGBaPgS4PS8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XBANSfNG/UlGOwNPXfuyKR0FQH8PcDtN6raYpE1PN+RGbtOaAxW2GW8rqiPtRMgT/tJgBtAT8UGzuRyVU3zQVJ5cerC0gY0YmpN40SaAy0VfwtWidmJowo5pRgzhS//VNnQSoL1K3xCFvhDJT/y3FXPiVkD3fNY4hGjlr3Y2pjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ro2eQJQ4; arc=fail smtp.client-ip=40.107.121.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qzI7d7uh9jJ9JLIWpp9V/BXEUkHQg0yoP/s34aaAa7dhyzDCQ44sGMGS37jIjcl2QR/cH0qS0rdPHLUEbuPB6kFT0EOM5uM/5pWO7RoqheUHy53j74g3tle+jUXvMl+0QAihCdb8mlP1hRLfIRILTQwqBJdFwab8ZKqiRWZBW+CTUIxx972ANsNFy6awPmNiikY8wlbjWECsNMwJpGXejpmsFgTdAaVcFTKVYeCyMXxCZTCHXeOCi3PPF4xjriM56VF0CVAZnKmjjXBUj3n3I1GAgY7sbF4akDSbb7M9vmIFnNeQaynkmHHGA2KtFtx42uDNx3O5xGLfyEWNZqghRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzjhHmgHm1Kgy7j+mKJnPVMyYg0YsoZjbl0MVC9T7X8=;
 b=HefN4+AiCW4KumrQWkE8PYncGeADYdLlZX+Zf6TWtMndczj1UHetU1pPZ6NS6mpQFoxVLNIcu9/LxbC8yTVMAFE4IELipHWtNkOywYjlVPU/LuP3ws/YTDHPh1ZtC98ByTEySeUqOPyLGKeEd8rqtxg4CbuRdAD12tNsy+iE7hgO4FSuuP103KMnh1FsRswFhmvGrCUuhKCrRNfVZLtIznD5WXpBZI73yywAAZ3SKTo0j0KaMAxvsVnMgDzco6d9BxdsLpzZLYJaOkrAH4jV7QefoUBlIWT4o3epgO2xl+XUxnPlQ9vgEjIAJan6mF+HhzR98zAMgpvAnQjqM3FgxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzjhHmgHm1Kgy7j+mKJnPVMyYg0YsoZjbl0MVC9T7X8=;
 b=ro2eQJQ4WX8631jsoFVHEMYWpTg0MyEFWK+L/dMFu3fz0arsAXIzzcSjJL0W+Qlp6IyZCoJ6SXvttsUqE2PTBcN73QYPYmp4ecKVB/VpV7dvsYcvKiTcVFAeKcyGpXG2qktQjfgxh7/43bOD1IKoJY4sfQ8QAPrZ0Av05sbW4vE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO2P265MB5757.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:26f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.22; Sat, 31 Aug
 2024 12:18:36 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%7]) with mapi id 15.20.7918.020; Sat, 31 Aug 2024
 12:18:36 +0000
Date: Sat, 31 Aug 2024 13:18:34 +0100
From: Gary Guo <gary@garyguo.net>
To: Danilo Krummrich <dakr@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
 boqun.feng@gmail.com, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org,
 daniel.almeida@collabora.com, faith.ekstrand@collabora.com,
 boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com,
 zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com,
 ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 05/26] rust: alloc: add module `allocator_test`
Message-ID: <20240831131834.180cd71b.gary@garyguo.net>
In-Reply-To: <20240816001216.26575-6-dakr@kernel.org>
References: <20240816001216.26575-1-dakr@kernel.org>
	<20240816001216.26575-6-dakr@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0204.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::11) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO2P265MB5757:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ee15dc3-543c-4a90-8668-08dcc9b70a24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RbNM2UYuFI11V77YVHZiYt4LPpO6O09/OuL9z8dYlMWGGhtY1p02FY5ZMqeC?=
 =?us-ascii?Q?trnWMYp0Tg1GMFSlu8NGxRJUOeEtZNGZodtSKtS2TzNkcFv7R3DRHJsynXQs?=
 =?us-ascii?Q?SIO/OR+TNrhJ2VupSA2k18MLnB0PumfCEh/MdpzeQB4vkahAJQHqfBUM//k0?=
 =?us-ascii?Q?Q6TEr7UbRbVl4jmjLmb443e2avaQGCcTyMjN0TN43clt/jYILn205hp+zCV7?=
 =?us-ascii?Q?IaRfJDGgATHmoskDfV696WRDsC1mAUC5a+aZA9tIhtBd1kK+CGdktAk1y7kt?=
 =?us-ascii?Q?MTLbcynsTZnFqyKIdU4pq6vb++oJPmTfvdIJBgvJppqmdHhNYYL0qZs5Gvg5?=
 =?us-ascii?Q?Sz5Ae/Cpati9SfinA6TRs8ZG8Bj5rYpOGvHufZPK+RKZen29EBX7rOnEvi3N?=
 =?us-ascii?Q?spdKK/BqOpRtPYRG+pG8AR3pQDBbsOPtP5A9cYlmV8/kSHSXuUiE6wny9usV?=
 =?us-ascii?Q?mXSOx0zXP/I8k/IZ119rpLrvjYn/SAL2Is7ESRbo7L9MVd4ehq2pv3dEBerK?=
 =?us-ascii?Q?jviQ9JjNx0FbzDSu11PjF4zMMIb1CNBFnqczPwwCREb3O18iXuE0v6lSkq8f?=
 =?us-ascii?Q?N/CIZiCQWNzx2d+7GitOESvlVgbk43rq6sBylFflJHHmdUERcXvCGP1aqrcu?=
 =?us-ascii?Q?dCZG/yv9+5U7YpDj3r53ZW0SBHP5Kk6wDrzUgz+R6frPloomcw3pUx3yVpS/?=
 =?us-ascii?Q?G+kdrpfE+NVKrqOCtV73M74cGpE1JQ80XGNJJzCXLZuRqwmGM8yCLsNsAxs8?=
 =?us-ascii?Q?h5JVV+b5gjtOyFT9oEvym+eXt4akAhH3IjWQrHuwUSd2GHafjPNkKPo9OAeR?=
 =?us-ascii?Q?ahknIjBOyTcgB4zZqo7xLNbT8Y5mDkprQXZbThc9Tu5qY1EKPjlmxcm3toXZ?=
 =?us-ascii?Q?vDLtk1ldH2LWjpPx0EHAIU7SJliwmeUuaCwavYZKqzI+rRUUenJQQv9avGXX?=
 =?us-ascii?Q?PQJQWpZxQYyYQil7uaI2gruoBIdGM2LYJ+uNmckBAUCY87uA6RUzFpVY3ywG?=
 =?us-ascii?Q?fbBJmLb8rvCmAWAUC1sD6Sf6EqBFiXLeMny5OKJaoM/aukYel8KnLUSpGJjA?=
 =?us-ascii?Q?o9kLin/8tYGIyearhICZc807JILA2nrVDMnZQpMvQHqJXbqZ+BlTdjD7AllS?=
 =?us-ascii?Q?asD9K9lR2gKODBZuRkxYN6W0v/KG3gmjbUqFl8F+GkVeI9rKZZQci+qsingz?=
 =?us-ascii?Q?tgTmd7Xx3CgWtn7llYjic/d/I1t5toWlvcVdSm6dYSmkminm31wSUK/jphqq?=
 =?us-ascii?Q?+UYyyhtpxTYOR8eAK7HMWDnpGRD2iXrpyqh3ab6A86QrUW1Kn194xnAzo8tD?=
 =?us-ascii?Q?FSpBTycyv7hOjGVDx7mfAzFYgRfdB7HRLD9CcRyHBzrosg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MXvXcVZ1YwEKhCuVaZaeXC5/taKjsXinrAZk6+bnvq2QYR596/YZs1Yz4SiZ?=
 =?us-ascii?Q?cSpo6/sFa0bWUweJ60sivDJetoUWqxwAoipTOZE9z+ebcUT0HCjr+9X4GUa8?=
 =?us-ascii?Q?ndHsCaLd+7/oDpQLjzv8PGy/oK4aTCJZU32bK/pfiy1CLhngaVf/Jy18UleD?=
 =?us-ascii?Q?7EGvGBb6TYr0oqc6kv/W5MkWZb6bibXW6V69RlEmOyPJkQAss8tY8ymBPCDY?=
 =?us-ascii?Q?jPaESS/0ubb8paKAsC17Ix00ukGC/BY5XoYXquaksdkumAK0unl+07oS6bBx?=
 =?us-ascii?Q?KjEe/hfw8mjDUIqKy3VU6BFiCZ8rp2pDViK23hNeTbfqc02nv1M74cP12Vld?=
 =?us-ascii?Q?ulWBH0tSpQE1Bbv/GDQlDIx7M1A9pM9e+YLZoCu1tCnxhgkeV24slet+X0Qt?=
 =?us-ascii?Q?5Oy+6+HbGyKH18Y+ql76gsYw4zCEX20a5xXsFYfkCIxxlbaDbMoKA0VKr1Mz?=
 =?us-ascii?Q?l3A1MC61rJA3AW70lKqQ5vplIwk1Xu15bOLiIx2vcWA6g9DqeiG+puR1B2GG?=
 =?us-ascii?Q?+V/U44Ug4cJZ1QdGo0dog+Vs/0HM237LZfF1rQWFEJFPyDQlf/PaaXedhwIX?=
 =?us-ascii?Q?H20VEFknoePPPn1DY8APxXl1WdS17+38wkR63hnQGcSVA6T8wBvYemKjMOJe?=
 =?us-ascii?Q?Goai46hjKhM6EWTQ6AMTQu8jMsTflKOjMaD1NAKM7oNyDiN3f6VraasekQao?=
 =?us-ascii?Q?u3PlEUdVN2+4/2zadlq7CZftRxTxdSNSqXzWUB7ZydT3ewquNZ9f9UsM9seu?=
 =?us-ascii?Q?mbrpf7g7/38Y78kS/588fg3QUFlSbdmvS2Ry8LaKrom6Tj4ZrXRNVEN99rsU?=
 =?us-ascii?Q?HCUHpB5fhcUhhbDhLGRWsI9ZgxuDH3q49D17VwGJMNyc7VYjXfPHrt8dNCmm?=
 =?us-ascii?Q?yXQrFF6XuYiiQD/l9a5UMJCis96l+AWXCJOxVojlOUcwsnzENAmbzY9AQ7c7?=
 =?us-ascii?Q?4yzfGS1cmxymfzY6DAWN1PgvLW3ylGGSCT9ML2rn7C4jDforoSxQ2ReJK0Vm?=
 =?us-ascii?Q?HzZWC38M12pRBlnzmlRwkiGM1luAMZy5wNLwzB7Pb+5S+Bhd1i2M40IEYnXB?=
 =?us-ascii?Q?86kjAU3JgatC7yFTVYK3bo9tVjarc3Y18NvTnACzAFtgOdOkl5mcVMocOqET?=
 =?us-ascii?Q?GYLD2ARnAmTd2sQUxMiGc4rff25AL/xmW7dly4OJdbc4nOH3y1pYM6LQuvhv?=
 =?us-ascii?Q?t94CSZf5y1g6sVZTiM/aIHi9/1zHwLAPfi6AbXwo2t9o0oxKLwnusf2G7YRd?=
 =?us-ascii?Q?bZrEPl+Q1U4xloXxUyNlOuH3ydXZSs1dQFfQpc7I8dV2BvjrJkFABsfI57B8?=
 =?us-ascii?Q?8mPYT43wncYJW0BCKuNopdd6X2ufs9+Lvn+HzScTmBz9AstyiYC2LxtzQaGp?=
 =?us-ascii?Q?LEU9rSMyw4nzJ4zO1BkUbiCcYwAhIj4cgHtPlYsHESbkvxHePX8i/SuaWLBm?=
 =?us-ascii?Q?U2MFWul8ccSFBnwl90GHEXTxvFuVJ/D2g1rGu3Ezv/IVdnnXnGc4BoDLtwQH?=
 =?us-ascii?Q?uqYu397KW195HPdn7rhm91lnFE6uBjA4OxSRFg7AdTZ18G9zIt/2cR8i+i37?=
 =?us-ascii?Q?4AODOG6TClpSaQYQNTn3t58NCDzOuOTZXBjBfyk/f8nUO2XV5Y6MkAYPXFDd?=
 =?us-ascii?Q?8Q=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee15dc3-543c-4a90-8668-08dcc9b70a24
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2024 12:18:36.7559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GXdsqhA73AfEjqq+uvL1HtgcxwsqrKO1goMo5GRK37D321ssmML14mYuLTisQUI1O9kNezjv0FIi/6AtXZZGZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5757

On Fri, 16 Aug 2024 02:10:47 +0200
Danilo Krummrich <dakr@kernel.org> wrote:

> `Allocator`s, such as `Kmalloc`, will be used by e.g. `Box` and `Vec` in
> subsequent patches, and hence this dependency propagates throughout the
> whole kernel.
> 
> Add the `allocator_test` module that provides an empty implementation
> for all `Allocator`s in the kernel, such that we don't break the
> `rusttest` make target in subsequent patches.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/alloc.rs                |  9 +++++++--
>  rust/kernel/alloc/allocator_test.rs | 19 +++++++++++++++++++
>  2 files changed, 26 insertions(+), 2 deletions(-)
>  create mode 100644 rust/kernel/alloc/allocator_test.rs
> 
> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> index 477dbe3c5a2f..91a367a58f36 100644
> --- a/rust/kernel/alloc.rs
> +++ b/rust/kernel/alloc.rs
> @@ -2,12 +2,17 @@
>  
>  //! Extensions to the [`alloc`] crate.
>  
> -#[cfg(not(test))]
> -#[cfg(not(testlib))]
> +#[cfg(not(any(test, testlib)))]
>  pub mod allocator;
>  pub mod box_ext;
>  pub mod vec_ext;
>  
> +#[cfg(any(test, testlib))]
> +pub mod allocator_test;
> +
> +#[cfg(any(test, testlib))]
> +pub use self::allocator_test as allocator;
> +
>  /// Indicates an allocation error.
>  #[derive(Copy, Clone, PartialEq, Eq, Debug)]
>  pub struct AllocError;
> diff --git a/rust/kernel/alloc/allocator_test.rs b/rust/kernel/alloc/allocator_test.rs
> new file mode 100644
> index 000000000000..4785efc474a7
> --- /dev/null
> +++ b/rust/kernel/alloc/allocator_test.rs
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#![allow(missing_docs)]
> +
> +use super::{AllocError, Allocator, Flags};
> +use core::alloc::Layout;
> +use core::ptr::NonNull;
> +
> +pub struct Kmalloc;
> +
> +unsafe impl Allocator for Kmalloc {
> +    unsafe fn realloc(
> +        _ptr: Option<NonNull<u8>>,
> +        _layout: Layout,
> +        _flags: Flags,
> +    ) -> Result<NonNull<[u8]>, AllocError> {
> +        panic!();
> +    }
> +}


