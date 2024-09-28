Return-Path: <linux-kernel+bounces-342635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C65989118
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 21:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B37151C216B6
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 19:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7651158D93;
	Sat, 28 Sep 2024 19:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="d8rWhPIp"
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020135.outbound.protection.outlook.com [52.101.195.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9601CAA6;
	Sat, 28 Sep 2024 19:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727551223; cv=fail; b=VUwkcPTG/VS5dsgpoW5jxwf8TlwZg2HVvA4q8w9iFWM+rO2XZV1m/8flSYWaZW3y2wNLfw4U/zH8Kb8uZd0lf5t1aZDx+p8AgpZrQixLcpr5TvGkCpfOroG7+e09FAF6bGfH7ezUwjgZXSXIzBvehMHRRU293FKc3rlKUeg7v2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727551223; c=relaxed/simple;
	bh=0XcqIrprdg0DCS7qaS0dfLY4hZHwVe5tMOtv5JtfoTs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dDr/TnQh3a1srpcNiqCILbYwNdPujU4/a8NkavKeiBo/zowhm0KsjuXUB4IFLqVOlD+KwbdwL+ILs0/d+exvFqexTfApM1yLY2DJx5A8CVDX2S8ttBNFLJtMlUAa/bMXNMapwT/V111hArBOV/4ZxkIqXDpJ1LyDgPgCC8KGcKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=d8rWhPIp; arc=fail smtp.client-ip=52.101.195.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TFF23XyF0RINPQStCFDSWVReiwoZmJ7xUQ/f9QBUAryO81b1e+c9WYwrsW9s+YSllInZNH+Upm9RAmYuhebcCQm4pMj78XI0PqqFBvk0ywMpFq78dw8n0voiYJ1LDwHDDhsienlI+2iwmXy7zuJV1LQ1OLcBZQKisC0s5fTQznfgFNmvvS1Kq1uqhIib9Y4UHWZjDM/zSsx1KJLmhiDgcCUJJdSqaH/7sLQeOTLcaobDuZCzdeoeN+H6qBNc43YpuaDkLdQYDILd2Y0O5IX8MgFRejCaGacb3ZfM9AqB6H6GHTDYWGs1kBTAs8dzkqS+mCn9Xfy4GX/B2lAmUR6J+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZ78gI7cH605JnTpkCekm3GIPDjow78+HYqfOLV2ULk=;
 b=i4VNIqeozFV63t9P1slXiby3AkaVru8zZegoHKopzExUQblgfbSQfpBdEGlqWfpfBGN4+hRJK3LmZYL0QqTWr5SdOBgdmvKnDY9VjO04TaUtB8Hs137VAQGfHe/QsvFP7bxZ88Fjm0g8911rlqzD8aGpO3QWGZoG4SOxG1vO0wZm/pGykVXxUMzR4LzJTwMqdCuf3ZEnRZOavDtWiLbVSZxcUPRd2PWxWnuCrzyqr/LFmg27x2xD4UXSl/X+AiwiJHNv38slQTJeXVHpZrrL8cQ3wSJAq7LQ7cKeyl+/uUGQDVRjc3MwyPVBbk40KMngL49Q8qsZ2S4QTcivM48KvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZ78gI7cH605JnTpkCekm3GIPDjow78+HYqfOLV2ULk=;
 b=d8rWhPIp+eoLEf1F90DWblFhssCMTIxwzowrIMzjWg+4gLY32e2GOTF2kyh7WvuU84pM+0HUOG/Kj3HK29ogms6LPppNoUjEnXW0pn3LlAfYpmOjNUWw42k7j6KB8F/YJxSpidzdVUJGXg7yV55GYK9TZckrPgyCU1oOmbraSNQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB6614.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Sat, 28 Sep
 2024 19:20:17 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8005.024; Sat, 28 Sep 2024
 19:20:17 +0000
Date: Sat, 28 Sep 2024 20:20:15 +0100
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
Subject: Re: [PATCH v7 14/26] rust: alloc: implement `IntoIterator` for
 `Vec`
Message-ID: <20240928202015.7a8c0bb9.gary@garyguo.net>
In-Reply-To: <20240911225449.152928-15-dakr@kernel.org>
References: <20240911225449.152928-1-dakr@kernel.org>
	<20240911225449.152928-15-dakr@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0201.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::8) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB6614:EE_
X-MS-Office365-Filtering-Correlation-Id: fec68c60-9ccb-428f-43c4-08dcdff295fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bq7QbGJMOQ+opZp8SLEWAQ43y4fli4/cyPKO/tufUqm4ThcmY7Bhwa27+jd0?=
 =?us-ascii?Q?mWDLO8WMimm3vVd22N2eck52uAyLboyLE2R6zgcrD/nbgIXNthgV1mstpzUd?=
 =?us-ascii?Q?Nensv8YTowiaOFN+FKkDaNAHC5qIP5ZxxXwT+RDzNwEhh9XDWTfn7sjvY9DR?=
 =?us-ascii?Q?FKuOSXZgMhhBGq/0OJlLeWxjSvosKErnUclJp4icKD4EZHfLwjIojiQC0XLD?=
 =?us-ascii?Q?2P4iQQjBvi35DGQmwOa00c0KDqM8HrjllKyMgqbsa1fLCSNPkbu0hyNuMVsT?=
 =?us-ascii?Q?JA3GgTZYD8rHaesR2dykl8zsbYTU5Sa8MuVrmg3NwyNxSTP8V0aQGM4rVFgH?=
 =?us-ascii?Q?Rn6j/llxiMfwnVwqElW/udK2G/KiTvk/HL66gnzJ+/6NijNQDQmYoVhDqTUb?=
 =?us-ascii?Q?oFWoMGuTFwMk/XPeihCjEjIK4r4sQLsyDphqkzF9HtIgLLICL7yXwQ62AVBP?=
 =?us-ascii?Q?Qd7A/uuWS6JiE2Or+o2jfBAxFtyMeq0uJsrkhlibVCuiO+w/iQFZzF9LN3gG?=
 =?us-ascii?Q?XcyMWZmCDmZkpQDUIw7rlnAzhsoJWmUBAoeFjdOFBN6w1tbr3tCZoqNfs0tn?=
 =?us-ascii?Q?1a3VkPE5i5pNa+PIDgXrN3iGNz4vZdCeZfKsfkB5hbKfRtGQLlFMXlv1RXgj?=
 =?us-ascii?Q?f7Rjj7UmYiRMvO1wDVJrh5V/l6JWXgzIquLvgedylqnXhJTmUQlnoP2D9SDn?=
 =?us-ascii?Q?PmtW5W4Wb4Hl5m20gUL5qnc3e7Fnvq7+rfkyI5W1I9yQLWgpmJkGcxBZga0G?=
 =?us-ascii?Q?eyZ1yTxKI0A7M53V7Z9ETRXfuMtbgZ+gYyuUv92ef3rcGlWNgVoRt6SBQSH4?=
 =?us-ascii?Q?b/j5B3c9mqDDABfbgMDKsgSwnpLDhO4vJFqInrQ5ERhgaqbr//uRGe0DsNL7?=
 =?us-ascii?Q?L9/IusW/rDfjkeg5NMYuXLUKmOLW7yqrvC0MOaSFAIYUFJ9f6Lxgdd+Oa8xf?=
 =?us-ascii?Q?lw3awncdqCHLy+SgK1ZK1SPwtnwStF04M/G4d0dMjbtfTPy+5WsBDpVvVWKA?=
 =?us-ascii?Q?agS9i8WxbDXeHZM8o2s0RRyjy8YxoTelPuVwTPJ9+M7UvIRWljBKO3fxzFcF?=
 =?us-ascii?Q?Z7eREd8Swb1lt15Nd429ypC2ru/NpPKbK6V6b6K8BXbNAaQYRCgUwPJ6yMHO?=
 =?us-ascii?Q?w7Brd+BfSjLr6EBh8zD+Ic9nVCh7UYF/HZdKLBbkROMHJnC72e2aNcvhtvbm?=
 =?us-ascii?Q?fzfsYO9cCP/Wdev3IxzKq7giRb3jMkhzvoAuQxUquiLzok0ae+Lkblz1AtTH?=
 =?us-ascii?Q?CE4+H5rnC9Vf3Jw396ekBW5NBMsE4sdGkDSaY8b49A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?imZy4bfyIplMeMoibAy+UchdiVVqDzdPTEm3RG8zprOI8Vv6vNx6CynDaFPq?=
 =?us-ascii?Q?1SbzFabOEbTJUACje49FFb0bEDrkJ86kMtkjaGsiYe5qY7oVf+FtySH1PE8V?=
 =?us-ascii?Q?08TA+BfvEcx1BlMdiTcQxND8uabge6gPGbIgtTr/YIR1gop9DWTM4oz4fagd?=
 =?us-ascii?Q?4E8tlvtHdUp6SmAahIqpR06uYZSEHldOAstlL6j8Rl8CyJxwkBAAqP4EYj/M?=
 =?us-ascii?Q?Y016jdJ/gFtLzFhHWPmIRfjvFkhwD68N8+NcsYDwrtnFBmY/C/QrF3yjsHC7?=
 =?us-ascii?Q?UWQXkWkhrlenCrNe4ZbYlI8Ar1M5uRPc95+huzl4xlCHIl6U45nccNqV90A/?=
 =?us-ascii?Q?2zbP9s3KLSQu/VV+rUXeZA6e5wBI/96ntWh3urLZd7c+UprYAe2BuIjxTyVC?=
 =?us-ascii?Q?h0ohzzu7RpYlj6WlVk6/FHe+5mraPoSPrFUmPLgJ7A3328LD7Tj8rIZKHCy9?=
 =?us-ascii?Q?I4qtNjXOOBKEylKX5G59Ei5rglZH2R/KOMf5Px9yBmmJVCffNTU0E1u6ClkT?=
 =?us-ascii?Q?Mr0Xb2dxzD8f+YeBDq9nYz+dlgVsw4lnbCVa97DxmHXT36Vmrsri5at/SfB4?=
 =?us-ascii?Q?sZXDz58RxS1+n7VP3jkq5Ahd9qXpakza/M2KtoqGokVPRk2Og9bC5lOD9zkE?=
 =?us-ascii?Q?rion398siWYJIEMcOR53m2v2D7iONdWS4zB9z3KsgKcNF7J12uFsYnKdtCVD?=
 =?us-ascii?Q?/3LNryoQzW8y17zTzV4ydUhleSIxnDH20xRwBTfOLS5WQDp5KkK6141nea8B?=
 =?us-ascii?Q?OTtRPxOazr725lsVY2AUvK6vDjqXkg6d85dclYSzpH7n6uYSzLCf00m/eTFH?=
 =?us-ascii?Q?UIRdGpZ9hEcCoIaZBhKa1pJiy9YXk0M/h10+zgVnAYBNdJ/VAEiH21+4yK0C?=
 =?us-ascii?Q?tfjWrXcPWtRpdrImOxCRPxvaqsJF0mrNsCc1Lh/k+xp37K4eGeJwMOe48pls?=
 =?us-ascii?Q?Ifi6qPQ07uPfnAzPl83puKMxVHrCq8AikML7VvuJQzaP3Ii15RhY/NkgXCBs?=
 =?us-ascii?Q?gYMRNVwRa5KmXjBazzndUVaHW+YTJwQDky2Kb3U/k10814ZSq97qNL4VEhJH?=
 =?us-ascii?Q?G/3rXqbdlo6B+DNodKUb3LfKcgN++z9DNac5yoLFcX0p7u8I96YKWjNf2JkA?=
 =?us-ascii?Q?t7+fChKCiPjmLu34Gk42mMimy8J1RBETIGljl/J1c+1wxKAQRdYxRa1j7xoX?=
 =?us-ascii?Q?2ZAnOVwDmT8nJluqHd64Gh1fFIoLW3hT+yHin7k6PvQ+/CTgMJNwmvTq/gd3?=
 =?us-ascii?Q?NoV3mQMKDhaUYiuTlkDXfAmFWO0yBOyNSDuevuSc0lziZ6s04bnhYIZbXGn4?=
 =?us-ascii?Q?ZflH37o0XdiDzvPNK7lSS36YEFykUDLCR68q9lCJ4tNmlrPBK+Q3mu3n3Zsf?=
 =?us-ascii?Q?uWilhLzr5OjjqF8lmcdjOiCVgqs+UIzlFcosHkmN3d32+NxjApqTBrf+Eaw4?=
 =?us-ascii?Q?15KoVhZYq1lHAby4f+DB4IRiWdN+0MFx539caYA2X8mOhl50RqOPRF8KG41H?=
 =?us-ascii?Q?/X1THI6UkB4fnga4RobN9xr7wLFfCFKTsfi/zG/KeGG79sdDzSUsDME6FA5O?=
 =?us-ascii?Q?BCgPlKkbVnL+nj4odLr/dLX7TnAv1U1mKL+rVh9Y?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: fec68c60-9ccb-428f-43c4-08dcdff295fe
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2024 19:20:17.6008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1SjhAxEfQwTKInRZhCm+ktoZZM5AbKEkOdH6cC6/WEcsi9Y6QVejzY/XcsMxvcnqOGyk3SjotjflZOqhfutMpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6614

On Thu, 12 Sep 2024 00:52:50 +0200
Danilo Krummrich <dakr@kernel.org> wrote:

> Implement `IntoIterator` for `Vec`, `Vec`'s `IntoIter` type, as well as
> `Iterator` for `IntoIter`.
> 
> `Vec::into_iter` disassembles the `Vec` into its raw parts; additionally,
> `IntoIter` keeps track of a separate pointer, which is incremented
> correspondingsly as the iterator advances, while the length, or the count
> of elements, is decremented.
> 
> This also means that `IntoIter` takes the ownership of the backing
> buffer and is responsible to drop the remaining elements and free the
> backing buffer, if it's dropped.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

A small nit below, with it fixed:

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/alloc.rs      |   1 +
>  rust/kernel/alloc/kvec.rs | 181 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 182 insertions(+)
> 
> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> index 4fb983b63d46..e8fbae2adadb 100644
> --- a/rust/kernel/alloc.rs
> +++ b/rust/kernel/alloc.rs
> @@ -19,6 +19,7 @@
>  pub use self::kbox::KVBox;
>  pub use self::kbox::VBox;
>  
> +pub use self::kvec::IntoIter;
>  pub use self::kvec::KVVec;
>  pub use self::kvec::KVec;
>  pub use self::kvec::VVec;
> diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> index 631a44e19f35..e91761c5c52d 100644
> --- a/rust/kernel/alloc/kvec.rs
> +++ b/rust/kernel/alloc/kvec.rs
> @@ -14,6 +14,7 @@
>      ops::DerefMut,
>      ops::Index,
>      ops::IndexMut,
> +    ptr,
>      ptr::NonNull,
>      slice,
>      slice::SliceIndex,
> @@ -636,3 +637,183 @@ fn eq(&self, other: &$rhs) -> bool { self[..] == other[..] }
>  impl_slice_eq! { [A: Allocator] [T], Vec<U, A> }
>  impl_slice_eq! { [A: Allocator, const N: usize] Vec<T, A>, [U; N] }
>  impl_slice_eq! { [A: Allocator, const N: usize] Vec<T, A>, &[U; N] }
> +
> +impl<'a, T, A> IntoIterator for &'a Vec<T, A>
> +where
> +    A: Allocator,
> +{
> +    type Item = &'a T;
> +    type IntoIter = slice::Iter<'a, T>;
> +
> +    fn into_iter(self) -> Self::IntoIter {
> +        self.iter()
> +    }
> +}
> +
> +impl<'a, T, A: Allocator> IntoIterator for &'a mut Vec<T, A>
> +where
> +    A: Allocator,
> +{
> +    type Item = &'a mut T;
> +    type IntoIter = slice::IterMut<'a, T>;
> +
> +    fn into_iter(self) -> Self::IntoIter {
> +        self.iter_mut()
> +    }
> +}
> +
> +/// An [`Iterator`] implementation for [`Vec`] that moves elements out of a vector.
> +///
> +/// This structure is created by the [`Vec::into_iter`] method on [`Vec`] (provided by the
> +/// [`IntoIterator`] trait).
> +///
> +/// # Examples
> +///
> +/// ```
> +/// let v = kernel::kvec![0, 1, 2]?;
> +/// let iter = v.into_iter();
> +///
> +/// # Ok::<(), Error>(())
> +/// ```
> +pub struct IntoIter<T, A: Allocator> {
> +    ptr: *mut T,
> +    buf: NonNull<T>,
> +    len: usize,
> +    cap: usize,
> +    _p: PhantomData<A>,
> +}
> +
> +impl<T, A> IntoIter<T, A>
> +where
> +    A: Allocator,
> +{
> +    fn as_raw_mut_slice(&mut self) -> *mut [T] {
> +        ptr::slice_from_raw_parts_mut(self.ptr, self.len)
> +    }
> +}
> +
> +impl<T, A> Iterator for IntoIter<T, A>
> +where
> +    A: Allocator,
> +{
> +    type Item = T;
> +
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// let v = kernel::kvec![1, 2, 3]?;
> +    /// let mut it = v.into_iter();
> +    ///
> +    /// assert_eq!(it.next(), Some(1));
> +    /// assert_eq!(it.next(), Some(2));
> +    /// assert_eq!(it.next(), Some(3));
> +    /// assert_eq!(it.next(), None);
> +    ///
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    fn next(&mut self) -> Option<T> {
> +        if self.len == 0 {
> +            return None;
> +        }
> +
> +        let current = self.ptr;
> +
> +        // SAFETY: We can't overflow; decreasing `self.len` by one every time we advance `self.ptr`
> +        // by one guarantees that.
> +        unsafe { self.ptr = self.ptr.add(1) };
> +
> +        self.len -= 1;
> +
> +        // SAFETY: `current` is guaranteed to point at a valid element within the buffer.
> +        Some(unsafe { current.read() })
> +    }
> +
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// let v: KVec<u32> = kernel::kvec![1, 2, 3]?;
> +    /// let mut iter = v.into_iter();
> +    /// let size = iter.size_hint().0;
> +    ///
> +    /// iter.next();
> +    /// assert_eq!(iter.size_hint().0, size - 1);
> +    ///
> +    /// iter.next();
> +    /// assert_eq!(iter.size_hint().0, size - 2);
> +    ///
> +    /// iter.next();
> +    /// assert_eq!(iter.size_hint().0, size - 3);
> +    ///
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    fn size_hint(&self) -> (usize, Option<usize>) {
> +        (self.len, Some(self.len))
> +    }
> +}
> +
> +impl<T, A> Drop for IntoIter<T, A>
> +where
> +    A: Allocator,
> +{
> +    fn drop(&mut self) {
> +        // SAFETY: The pointer in `self.0` is guaranteed to be valid by the type invariant.
> +        unsafe { ptr::drop_in_place(self.as_raw_mut_slice()) };

`as_raw_mut_slice` is only used once? It's better to construct the raw
pointer directly so there's no need to refer to some other place when
reviewing unsafe code.

> +
> +        // If `cap == 0` we never allocated any memory in the first place.
> +        if self.cap != 0 {
> +            // SAFETY: `self.buf` was previously allocated with `A`.
> +            unsafe { A::free(self.buf.cast()) };
> +        }
> +    }
> +}
> +
> +impl<T, A> IntoIterator for Vec<T, A>
> +where
> +    A: Allocator,
> +{
> +    type Item = T;
> +    type IntoIter = IntoIter<T, A>;
> +
> +    /// Consumes the `Vec<T, A>` and creates an `Iterator`, which moves each value out of the
> +    /// vector (from start to end).
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// let v = kernel::kvec![1, 2]?;
> +    /// let mut v_iter = v.into_iter();
> +    ///
> +    /// let first_element: Option<u32> = v_iter.next();
> +    ///
> +    /// assert_eq!(first_element, Some(1));
> +    /// assert_eq!(v_iter.next(), Some(2));
> +    /// assert_eq!(v_iter.next(), None);
> +    ///
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    ///
> +    /// ```
> +    /// let v = kernel::kvec![];
> +    /// let mut v_iter = v.into_iter();
> +    ///
> +    /// let first_element: Option<u32> = v_iter.next();
> +    ///
> +    /// assert_eq!(first_element, None);
> +    ///
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    #[inline]
> +    fn into_iter(self) -> Self::IntoIter {
> +        let (ptr, len, cap) = self.into_raw_parts();
> +
> +        IntoIter {
> +            ptr,
> +            // SAFETY: `ptr` is either a dangling pointer or a pointer to a valid memory
> +            // allocation, allocated with `A`.
> +            buf: unsafe { NonNull::new_unchecked(ptr) },
> +            len,
> +            cap,
> +            _p: PhantomData::<A>,
> +        }
> +    }
> +}


