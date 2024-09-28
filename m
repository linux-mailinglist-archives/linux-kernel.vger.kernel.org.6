Return-Path: <linux-kernel+bounces-342639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 483C698911F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 21:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B15E1C21D4F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 19:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A7A15C139;
	Sat, 28 Sep 2024 19:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="h72YqOzL"
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2113.outbound.protection.outlook.com [40.107.121.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4456317C95;
	Sat, 28 Sep 2024 19:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.121.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727551768; cv=fail; b=JocJzjsKkkjiDjLrrw5AJo2RsDtkwApLZFoYBzzF6mS8guK/XL081TDbQOlhmJ1mQmUUP8G0ZHJRnBMSAC3aqtTq/miiAW+dHSWRUlnzbAh4cTrTTExPiYL4nFmc13MMrtJQ2DfdQwjJQpVBvFLiMuTqTXgSprD04XHegIi1xoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727551768; c=relaxed/simple;
	bh=XClsGhyh13IubyLRn44Xfuopsl0+tYsWNJNB/IfyzVM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R5YByBILvWxMSkl632KTzRlDsukfP507dXkP6Nhk22s5FERHtRZUMOJUXNqp2f1VwIeSH7RAESi0afuPRlNq0XO9Nyz5PTipXqrNrMe9H6GIBF57iLM73LuhoO8OvtL1AkZQWSZrPpllt4R3RTYX8os5Rup9giQkl+RNL+RuTGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=h72YqOzL; arc=fail smtp.client-ip=40.107.121.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d+rCBROYlUdbe+BQABgf4hsfDz528BRmODd2W1kOpbVEeYQBXMl+l8wUGTtkBGujj9DyvrrA42Z52XvIukZx3QQHNwGx+rykpQ8YYVrX5CsNLWuzipH3K3hNTM7yVxWk2LhMwrSB0bMbp8sCCYTq3EHD/qiCZ2y2F+neX+1Pju310Xq6sMweWhtsaD5i6SwSZ3rIi5/sAkYl3XPxmDxZhNd/9VF1RoCTbj6k+/nWdj97bx39FbCaDZQddq1UJE5CqvGLur+sgoUiZx6NuUz8wnBJTi3pcwF0ls+NXj75is1Idx4LrulkabbE4+UhvYb5x1Twf6tou4fCoJ33SnxtJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GzX2kldClVlR1U1Lwvj/f6siZNPHzL23Aaewl74B44=;
 b=Z2PkFlyr9eKPMq7W9KAn1IbDNBquHA/bedbpSFntEDdk052l1Weuvpqhy1VSUHsl1N2bQLrRcx1BYwNoo9l7jkCAH7bJsjoCo/gCB5aJbmmYvDdKI77U3PjK7xupCWmSS+OBKH8EPU9qVlOczFgF6u7/CW5nGX9RQ1MK8XMVHIbYjz4TPjoh9C38QLKtl2Gfg9pqe49kpKiEwYxsiB7kofxqH+X/ZCX9NVBy08kkXdle0oN7i0qG4/gTBoSkfN7hPGOs6f0mAVMt2O3ipZ6HsTuyojVvJ823kcXOtJAs2ERSupReY9Gnxd7IIol+Z6rI+Ae1xJpYOonUb5xaAwSwwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GzX2kldClVlR1U1Lwvj/f6siZNPHzL23Aaewl74B44=;
 b=h72YqOzLAANDPoCbdimx58BlX3po59NP8mnx4g7kKlytSB6T+n9p2nWM9LB9edhuBEzEAjM52i/LriGGo3BPV4RMkqwimsk+LgLwR1/0F6QUiRcTKvn4+rX90VkJMEOtjYweRkz8/W/SXethYf13ukHYK0ljVyB7KQu6Rmh1GKQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB6484.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1db::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Sat, 28 Sep
 2024 19:29:24 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8005.024; Sat, 28 Sep 2024
 19:29:23 +0000
Date: Sat, 28 Sep 2024 20:29:22 +0100
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
Subject: Re: [PATCH v7 17/26] rust: alloc: remove `VecExt` extension
Message-ID: <20240928202922.2495883e.gary@garyguo.net>
In-Reply-To: <20240911225449.152928-18-dakr@kernel.org>
References: <20240911225449.152928-1-dakr@kernel.org>
	<20240911225449.152928-18-dakr@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0021.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::8) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB6484:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b199148-c6ab-4690-3869-08dcdff3dbd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lBuYBEEEkHI4nsgE4DEqJpRrJkL26iWXjohpPnNN/l7EIXuoLLmKWUPd/xO+?=
 =?us-ascii?Q?zXFB1TiFx2Lp12rlhpPYO8esR/y5d1qZdXxjE3tSCsorjGVRgr+RKLc6fmg0?=
 =?us-ascii?Q?GR1vDOyYVPob6GazHmiSdau4HQJkAwjKg6GntRaDz0P/2Pjcg7JzehahzRQ2?=
 =?us-ascii?Q?ND+6l9I1CyZe+HbRagArm0oHt0Q8Y4jGbd4+J7UMXrMNKJYYKeU5VQ+370ip?=
 =?us-ascii?Q?fnmS2UxE7cHk4QJHhUrGA4nhRuBER06YUcBbJQNM3OqLt9hyRtahxgIYPPVM?=
 =?us-ascii?Q?4tFpAiO1a3ERQEfr0oaZN6As28dFbBcdeDX04YR1atBdmLDHbshcnPn/It/z?=
 =?us-ascii?Q?9ZoNyMAr9y3aVIHskauQHcKGoPgfU54HRHEvhkLB0eSw56vyUHuHshw2lft7?=
 =?us-ascii?Q?DIlh5ZRs4a9lbUIxJWY2U45+ZbVUwG+vwBHeLF9se/mp5XzRYh9PLpj7lh1C?=
 =?us-ascii?Q?g5B25fkjbvbxSjidmU8lqbMjwubbDv8LP/IRHwnA2O7YkdkAVvFn/fqF0E8V?=
 =?us-ascii?Q?7S93xhWEG/C2wlVN90lRvXAXeocGLO1lIoZQa69FsIKoBsLZA0xrf5fb3/uv?=
 =?us-ascii?Q?8ME7Jhh4P1JuTIBURsxKpQ4eIUoQwu0EF3D1pOhcInEC0WPnMKcvHNBC5LJz?=
 =?us-ascii?Q?CyfMHl8i8ejCYHFrMK9Mlk0m8ksieEhzKVIo0UlrocG3LWMADOkpSyOZZbWi?=
 =?us-ascii?Q?n6Qf08MCWQO6zYWwnZxyOy3DnHhp3f0s/It+PNizQmM+mEgt3lTw/GllqRR4?=
 =?us-ascii?Q?tnkFLwV8jiZBx6urvV1Hs+DV6Zcy1B+POmOAudGfY4IlaQGgZbGnT769XIA9?=
 =?us-ascii?Q?jgyeigoBU8p2BUgU7Mg4Had31yP3prrzCAz0r/Wy8MUiz7dqbT0ojzHMISvR?=
 =?us-ascii?Q?6H5Ww1HzpPDa1iWyS/T+ozLGkaCVjElL0taGuy7sHX6KNbU6gb3/+DN2H3NL?=
 =?us-ascii?Q?lMxlu9J9lomWiCPQtu4UpYX1BqRZ9hAKR4X7fMBt0xnvFckMs6W3uzya2ba8?=
 =?us-ascii?Q?5Ch53u92zZqej9nJ4tJMPwaRH0XNuzj6JUHGkdGLDdxDrBq/T7E/GvdqdH21?=
 =?us-ascii?Q?E6fGDEw4yZSI0cTvp8XxKs9zhw1/GBQ4Mlf3OekDkgD+2IBfneEO64Zq/34n?=
 =?us-ascii?Q?osnrnQo5qQpfkisMmzMdOygYbWMZf2Ydak+B9x+OaZXpCrEFFpIf8y0ykyRZ?=
 =?us-ascii?Q?xo0gK7HF7qDXpXoBvZTGPafkkrgU6OLKZZGiTNBHJaWRybHXvk//jZ91XVhn?=
 =?us-ascii?Q?s00SG0yNU6FCxRJipAPnAE9i3oDVJVF+JE989MTZKd6NqyYTlYfZ0AofX6Bn?=
 =?us-ascii?Q?S4qwDvtWDuFy639n/8dE/RVF8TG9S4dLt6WQs9T5E1ylIQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DMtj8d/EMUDDYAh36VgmwEhXhQVFVWmDMJYKXada5hFIMAiX7+RGNhyzXezt?=
 =?us-ascii?Q?PQt/sOQcice91odUFdyicTGQuPyTYzb69R8vaivum+TYdj2kLMnaDnsBUdUW?=
 =?us-ascii?Q?xrK8sPXBIbnHi6V42HoiqE+ryb+Yw6KKvSn839Rvmf23Jt64Br5NFMOOJTMb?=
 =?us-ascii?Q?ls+/K+Cn9YCbcSM2Xl6YCifbbK9H3E6sOAl4AFvqL8Z8wmvLgu3GFkHcx/5p?=
 =?us-ascii?Q?8KgPpqb1N96nFgVradtCxKIeQpZiEzq4goFPCkpNb9mFfMRffW3EYySu5JsY?=
 =?us-ascii?Q?iO0JImwyjJKm2ztqS10glK3Pa/HdxovTBCXgkI9TE7s0zrIZu7iIwCxXbjNy?=
 =?us-ascii?Q?MCZ7alBQ9l9DiVKyEcOT6Lfau6sDR9sQhdm+w3e34rLvvRpstm4eKOTZ5RiE?=
 =?us-ascii?Q?stmSoc2nrGCe+t6R3OVK3iJK3QzMQyfTI3hXedkwOrJDkFbMKrMtlJWLJZwZ?=
 =?us-ascii?Q?51oy9V+MRchdR2UNIGOOvs0SkPR2A01AqJ0/zahDuCfoMvLhAb0xV2Yg6woY?=
 =?us-ascii?Q?xsVcMauBARIsBOuH7yZ2m6ExXSogOB1sECr7DtPmIOEUmD1DE6C0Edx8phpV?=
 =?us-ascii?Q?hzz1rHQpBeMTz++O0/J9zAMGXCeZsMKwniKWbF0ddDT4ZBN4b5qJhnDya9/1?=
 =?us-ascii?Q?Rm5n0aKv06qZMV3E5dHC+c3iZdRCiz7uhCxJJT4kVZyDsNEM6EcGkKnUhvrN?=
 =?us-ascii?Q?a0QlTLF6l+0GZfWJMfMIXLYDnKDxZduXP+aJEniIwQ50HF202S/huvhIyos3?=
 =?us-ascii?Q?rYKUmnlIiymegy4dAR12MqMtKVTidEGdiPhiq6inno4vweVPGH592w3oYpn9?=
 =?us-ascii?Q?SGaKZcASq6u4oJFvdLN4364HDI4IjmNuT+a/m1vq5edGPF4PF/IJ/V+Q9okV?=
 =?us-ascii?Q?11Po5zFJqG9MOrjBBNG0opwUBDN79xPucoUUTOxbIAAv8nn49cjRT/B7I5he?=
 =?us-ascii?Q?931f2IhBgIZOgNFXn2NrsmbKcVD2scjn+KMy+44uvexQiKpBeASXleZRpmK/?=
 =?us-ascii?Q?pLSv0wPTsxmmLcwGPV2Bz4kDYBbQeMqQCZR6/BvEOo79ICVoGmh+xkWVBLQ+?=
 =?us-ascii?Q?aY7SP/3dLn8isvMlaLijfRk6YxOhEL8aMWEwb+vA6hjbISzDS5M1PIDmjYpE?=
 =?us-ascii?Q?PRHd1qD52fPq3zSSaTRjS4Hp9OVw5MxJidFCjzqMpbp5bR3nCpV6gTN/d0nt?=
 =?us-ascii?Q?M4GHFRRDkjjtRcok4azghWv6M0YPYoGSEhUdKjLSzKPhlgZsadZQLoitsRcL?=
 =?us-ascii?Q?h2z4S1pmMpUGEyLrX+dAUP4fhU2QShwNborzx4FJwGv7ckgll4LCyu+OoM36?=
 =?us-ascii?Q?PwgDlIyrvtBKpzr7MuVaaz5wgoqel4SxlEJQo1UDDvukUqsPCiBCO9nuQdpa?=
 =?us-ascii?Q?Yc/7cmupz9WHv5Ft/jVb9irKm7pUMZhvkmy/++htsNXN49TukI5qaLsDX5+N?=
 =?us-ascii?Q?C1rJ8RKGlCivly+790W+/bS5xK2ngBkN8K2LWRcHhjDpErBn+reMPjz4jryL?=
 =?us-ascii?Q?QgrhQrDw16CLtwVEQzKCVgPWbYdwka71fzQm14j34VTs5CGGTKBPk7dZRa+i?=
 =?us-ascii?Q?UiBOrIlgalmdvgksY2LqZ38TScZ5OTaA/yRGVMoF?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b199148-c6ab-4690-3869-08dcdff3dbd7
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2024 19:29:23.9348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iaGq9BuLPZF+VZkse19I4mCBuJaV9RdpJo9XhRIPnj+4WdJS/9dJlmjuen4cYB7PKeNEosu5QuExkFukDlD6lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6484

On Thu, 12 Sep 2024 00:52:53 +0200
Danilo Krummrich <dakr@kernel.org> wrote:

> Now that all existing `Vec` users were moved to the kernel `Vec` type,
> remove the `VecExt` extension.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/alloc.rs         |   1 -
>  rust/kernel/alloc/vec_ext.rs | 185 -----------------------------------
>  rust/kernel/prelude.rs       |   5 +-
>  3 files changed, 1 insertion(+), 190 deletions(-)
>  delete mode 100644 rust/kernel/alloc/vec_ext.rs
> 
> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> index e8fbae2adadb..aabdf80e4f7b 100644
> --- a/rust/kernel/alloc.rs
> +++ b/rust/kernel/alloc.rs
> @@ -6,7 +6,6 @@
>  pub mod allocator;
>  pub mod kbox;
>  pub mod kvec;
> -pub mod vec_ext;
>  
>  #[cfg(any(test, testlib))]
>  pub mod allocator_test;
> diff --git a/rust/kernel/alloc/vec_ext.rs b/rust/kernel/alloc/vec_ext.rs
> deleted file mode 100644
> index 1297a4be32e8..000000000000
> --- a/rust/kernel/alloc/vec_ext.rs
> +++ /dev/null
> @@ -1,185 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -
> -//! Extensions to [`Vec`] for fallible allocations.
> -
> -use super::{AllocError, Flags};
> -use alloc::vec::Vec;
> -
> -/// Extensions to [`Vec`].
> -pub trait VecExt<T>: Sized {
> -    /// Creates a new [`Vec`] instance with at least the given capacity.
> -    ///
> -    /// # Examples
> -    ///
> -    /// ```
> -    /// let v = Vec::<u32>::with_capacity(20, GFP_KERNEL)?;
> -    ///
> -    /// assert!(v.capacity() >= 20);
> -    /// # Ok::<(), Error>(())
> -    /// ```
> -    fn with_capacity(capacity: usize, flags: Flags) -> Result<Self, AllocError>;
> -
> -    /// Appends an element to the back of the [`Vec`] instance.
> -    ///
> -    /// # Examples
> -    ///
> -    /// ```
> -    /// let mut v = Vec::new();
> -    /// v.push(1, GFP_KERNEL)?;
> -    /// assert_eq!(&v, &[1]);
> -    ///
> -    /// v.push(2, GFP_KERNEL)?;
> -    /// assert_eq!(&v, &[1, 2]);
> -    /// # Ok::<(), Error>(())
> -    /// ```
> -    fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError>;
> -
> -    /// Pushes clones of the elements of slice into the [`Vec`] instance.
> -    ///
> -    /// # Examples
> -    ///
> -    /// ```
> -    /// let mut v = Vec::new();
> -    /// v.push(1, GFP_KERNEL)?;
> -    ///
> -    /// v.extend_from_slice(&[20, 30, 40], GFP_KERNEL)?;
> -    /// assert_eq!(&v, &[1, 20, 30, 40]);
> -    ///
> -    /// v.extend_from_slice(&[50, 60], GFP_KERNEL)?;
> -    /// assert_eq!(&v, &[1, 20, 30, 40, 50, 60]);
> -    /// # Ok::<(), Error>(())
> -    /// ```
> -    fn extend_from_slice(&mut self, other: &[T], flags: Flags) -> Result<(), AllocError>
> -    where
> -        T: Clone;
> -
> -    /// Ensures that the capacity exceeds the length by at least `additional` elements.
> -    ///
> -    /// # Examples
> -    ///
> -    /// ```
> -    /// let mut v = Vec::new();
> -    /// v.push(1, GFP_KERNEL)?;
> -    ///
> -    /// v.reserve(10, GFP_KERNEL)?;
> -    /// let cap = v.capacity();
> -    /// assert!(cap >= 10);
> -    ///
> -    /// v.reserve(10, GFP_KERNEL)?;
> -    /// let new_cap = v.capacity();
> -    /// assert_eq!(new_cap, cap);
> -    ///
> -    /// # Ok::<(), Error>(())
> -    /// ```
> -    fn reserve(&mut self, additional: usize, flags: Flags) -> Result<(), AllocError>;
> -}
> -
> -impl<T> VecExt<T> for Vec<T> {
> -    fn with_capacity(capacity: usize, flags: Flags) -> Result<Self, AllocError> {
> -        let mut v = Vec::new();
> -        <Self as VecExt<_>>::reserve(&mut v, capacity, flags)?;
> -        Ok(v)
> -    }
> -
> -    fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError> {
> -        <Self as VecExt<_>>::reserve(self, 1, flags)?;
> -        let s = self.spare_capacity_mut();
> -        s[0].write(v);
> -
> -        // SAFETY: We just initialised the first spare entry, so it is safe to increase the length
> -        // by 1. We also know that the new length is <= capacity because of the previous call to
> -        // `reserve` above.
> -        unsafe { self.set_len(self.len() + 1) };
> -        Ok(())
> -    }
> -
> -    fn extend_from_slice(&mut self, other: &[T], flags: Flags) -> Result<(), AllocError>
> -    where
> -        T: Clone,
> -    {
> -        <Self as VecExt<_>>::reserve(self, other.len(), flags)?;
> -        for (slot, item) in core::iter::zip(self.spare_capacity_mut(), other) {
> -            slot.write(item.clone());
> -        }
> -
> -        // SAFETY: We just initialised the `other.len()` spare entries, so it is safe to increase
> -        // the length by the same amount. We also know that the new length is <= capacity because
> -        // of the previous call to `reserve` above.
> -        unsafe { self.set_len(self.len() + other.len()) };
> -        Ok(())
> -    }
> -
> -    #[cfg(any(test, testlib))]
> -    fn reserve(&mut self, additional: usize, _flags: Flags) -> Result<(), AllocError> {
> -        Vec::reserve(self, additional);
> -        Ok(())
> -    }
> -
> -    #[cfg(not(any(test, testlib)))]
> -    fn reserve(&mut self, additional: usize, flags: Flags) -> Result<(), AllocError> {
> -        let len = self.len();
> -        let cap = self.capacity();
> -
> -        if cap - len >= additional {
> -            return Ok(());
> -        }
> -
> -        if core::mem::size_of::<T>() == 0 {
> -            // The capacity is already `usize::MAX` for SZTs, we can't go higher.
> -            return Err(AllocError);
> -        }
> -
> -        // We know cap is <= `isize::MAX` because `Layout::array` fails if the resulting byte size
> -        // is greater than `isize::MAX`. So the multiplication by two won't overflow.
> -        let new_cap = core::cmp::max(cap * 2, len.checked_add(additional).ok_or(AllocError)?);
> -        let layout = core::alloc::Layout::array::<T>(new_cap).map_err(|_| AllocError)?;
> -
> -        let (old_ptr, len, cap) = destructure(self);
> -
> -        // We need to make sure that `ptr` is either NULL or comes from a previous call to
> -        // `krealloc_aligned`. A `Vec<T>`'s `ptr` value is not guaranteed to be NULL and might be
> -        // dangling after being created with `Vec::new`. Instead, we can rely on `Vec<T>`'s capacity
> -        // to be zero if no memory has been allocated yet.
> -        let ptr = if cap == 0 {
> -            core::ptr::null_mut()
> -        } else {
> -            old_ptr
> -        };
> -
> -        // SAFETY: `ptr` is valid because it's either NULL or comes from a previous call to
> -        // `krealloc_aligned`. We also verified that the type is not a ZST.
> -        let new_ptr = unsafe { super::allocator::krealloc_aligned(ptr.cast(), layout, flags) };
> -        if new_ptr.is_null() {
> -            // SAFETY: We are just rebuilding the existing `Vec` with no changes.
> -            unsafe { rebuild(self, old_ptr, len, cap) };
> -            Err(AllocError)
> -        } else {
> -            // SAFETY: `ptr` has been reallocated with the layout for `new_cap` elements. New cap
> -            // is greater than `cap`, so it continues to be >= `len`.
> -            unsafe { rebuild(self, new_ptr.cast::<T>(), len, new_cap) };
> -            Ok(())
> -        }
> -    }
> -}
> -
> -#[cfg(not(any(test, testlib)))]
> -fn destructure<T>(v: &mut Vec<T>) -> (*mut T, usize, usize) {
> -    let mut tmp = Vec::new();
> -    core::mem::swap(&mut tmp, v);
> -    let mut tmp = core::mem::ManuallyDrop::new(tmp);
> -    let len = tmp.len();
> -    let cap = tmp.capacity();
> -    (tmp.as_mut_ptr(), len, cap)
> -}
> -
> -/// Rebuilds a `Vec` from a pointer, length, and capacity.
> -///
> -/// # Safety
> -///
> -/// The same as [`Vec::from_raw_parts`].
> -#[cfg(not(any(test, testlib)))]
> -unsafe fn rebuild<T>(v: &mut Vec<T>, ptr: *mut T, len: usize, cap: usize) {
> -    // SAFETY: The safety requirements from this function satisfy those of `from_raw_parts`.
> -    let mut tmp = unsafe { Vec::from_raw_parts(ptr, len, cap) };
> -    core::mem::swap(&mut tmp, v);
> -}
> diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
> index 80223cdaa485..07daccf6ca8e 100644
> --- a/rust/kernel/prelude.rs
> +++ b/rust/kernel/prelude.rs
> @@ -14,10 +14,7 @@
>  #[doc(no_inline)]
>  pub use core::pin::Pin;
>  
> -pub use crate::alloc::{flags::*, vec_ext::VecExt, Box, KBox, KVBox, KVVec, KVec, VBox, VVec};
> -
> -#[doc(no_inline)]
> -pub use alloc::vec::Vec;
> +pub use crate::alloc::{flags::*, Box, KBox, KVBox, KVVec, KVec, VBox, VVec};
>  
>  #[doc(no_inline)]
>  pub use macros::{module, pin_data, pinned_drop, vtable, Zeroable};


