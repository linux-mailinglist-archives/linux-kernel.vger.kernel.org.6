Return-Path: <linux-kernel+bounces-309879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D2A967172
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 14:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 911FE283D1D
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 12:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F11717E016;
	Sat, 31 Aug 2024 12:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="JaTQEXt1"
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2118.outbound.protection.outlook.com [40.107.121.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FC46A8CF;
	Sat, 31 Aug 2024 12:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.121.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725105695; cv=fail; b=pDITZ8SaHAVxa3uT5bb9RyN91PxM2l85KwZXgUfXNxQnoo5xE4g/HHy7mFJs/HAiDNadCAv/DQ5bzgtwgWpxlrttWE6EkOPKeoyfFHDtzq4MexjRDlPui/fsmE77BRv6NRxe6xVQMrM57J8pcrrpXqTwDPATK4vTByCl21gB7iI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725105695; c=relaxed/simple;
	bh=MxMaXOR0kFixaRpfJm2bxE8qbJmCxJ4Wt14tCY+p+U4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i5EQydifb+XXVpgjU619BREOnByhSjDb5DegXnsDjb2OKRQD7xSbtlOnWIUCnlVrZ+1crbjJO+lwq597Fq6b7lLOtcgA8z1zfRv6vfoVNdD5N7LoulyuMhTnTj39VNPDgJf/Kb2ahZETSJa2fg5iiWWBxSsggfaOizEGNDRA2Xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=JaTQEXt1; arc=fail smtp.client-ip=40.107.121.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QIWOHY7iu61Q6KuAecg8p1UojI1j+iW4ngjqrw26qhAOTt6l9TxtpRAxkOg4hhkqL+6beczVGpyW3nR3AoVN0TkFkWJG122uRrh2AIVnf/YcGAakuHaS/FDlrCi0RTWkFGBXe4Fw+krqDSoWUWVoSb1Vow+ZKYN/iw19Wm8TAQIkhNeYVcUPs7FzWmeETvAeGjYxZ272FnTKWl2CUlAK8beLiP4sc3hRtDh/4O921lkv0/FnYHnGJ/xEdmj3k8X1HBeILB0VFq8pFlP7SpVaAtLFT3wMqVx0iBgnRNncP6yp0fw52diNtiWiVJAdsDWtFKSwMFNzIK2oUSYhbUgcgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bl7sDsXvH3NpqavzT54ckkMooSMR8unx3x1RpuVxiMM=;
 b=Ycn19HBkQYFCDjRJr1M7hLNeHh8kk0MnH7CDEQU2jNdr0o4rZWconTbnfuM/EefgxYmPiBLbnhs/aPgxdYTdnX0HjTUwsB38rdc6sTgOXPufaMfpuaizj8jNSpupwo3Al449hG2wRX8CyYVkPHhNn+E38YPBdS0ZQLBHG621ZEVCZdj7qfjPPZx1xNBDRhZKJIol0fC2mkNIYcuG8Z1ZsJj2FC//UgJKo1c6VMMYr5Jfohu6Rfga8qtYj5p11ir53QVRMXv0az5h7iM5rPUwMiNXn1R+pd844XiNH3Kt7rypCPGScwYt/QvG2Zemun0+iOg6E1txNOCD0X14fhx9eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bl7sDsXvH3NpqavzT54ckkMooSMR8unx3x1RpuVxiMM=;
 b=JaTQEXt1yc/CCpFboeFC3FHTcaLm51L2L69v/d/EwoH5qWCkIrYw1ejzXc9rmQXiwETDvq+M4IQxhlz5YhxrZ45TC6JXGgkql27Ovx8DYw/Ni9AdNnZ/TJmg+vJGGgvySMwrf0LkmunAk5SLnJuLz7xqhPpv91KPXH7x7j8loes=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB6146.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:247::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Sat, 31 Aug
 2024 12:01:28 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%7]) with mapi id 15.20.7918.020; Sat, 31 Aug 2024
 12:01:28 +0000
Date: Sat, 31 Aug 2024 13:01:22 +0100
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
Subject: Re: [PATCH v6 01/26] rust: alloc: add `Allocator` trait
Message-ID: <20240831130122.0faa7651.gary@garyguo.net>
In-Reply-To: <20240816001216.26575-2-dakr@kernel.org>
References: <20240816001216.26575-1-dakr@kernel.org>
	<20240816001216.26575-2-dakr@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0539.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::10) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB6146:EE_
X-MS-Office365-Filtering-Correlation-Id: 667bb4c1-6198-4f82-ea64-08dcc9b4a4eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ez0wvKcJaTfb/2ccPlsBDNCt1oge2VuwqWvc4Q7HuQrPXLUsJgx7LPYYuhYx?=
 =?us-ascii?Q?ekuOOwcQuebaO+0rB1LQfF0NRsJOLow+OdIzShuwDPbZsywERmu9GGvx23sF?=
 =?us-ascii?Q?k16L0N7M6aXKht9R06RGa3brhTOoo15ti8YSBPkaCoogH8S87K9ptLuQZh2z?=
 =?us-ascii?Q?CGm9DrtqG76tauUvWALfL8VaJ5I2bktmzxhDg4p1HmfzpMsvg6AmkO1cRPIr?=
 =?us-ascii?Q?XkTWbCl9jOLZxjinrAd7dInPHF2slqLSpfKzALR1J96unZSjat6JtehitZMy?=
 =?us-ascii?Q?xJ80Et5VRUXRHXAq7gF3dHFsRRL0KLOhdV7UyiiOnMNprgofb+27Nrt36Rsc?=
 =?us-ascii?Q?so4GmBC27rmyGRkdFcxJ08qWoe23U7lJVsOJwuG7LRnrGVMZC+9TtQyhIx9L?=
 =?us-ascii?Q?xjSWRX3HNkytiD+TpbeodFp3qcQtiR9a2dutdshaFtBvVzHYzzRT78KEcpf/?=
 =?us-ascii?Q?xqG3pXMptVHy/n3z9qttFjW5Ut3tacw3O3DYEcQC7XlyDGQrqeK1whxikxcY?=
 =?us-ascii?Q?/03ZF5tBCwdeo8Cvi27SkMd2sliN8Bl8l4cYnsayd9SnME7a+e0PEJrqgAc7?=
 =?us-ascii?Q?ZL41BRnS//XdsnHQ/JdoU2/jaVF47i8bRfh5hI+2nMEW9VJEdiQOkUnV5jrO?=
 =?us-ascii?Q?w3dJyPi2XQuftbyJNoYwDuuD6GRMadTgkd7NCmgbKWg+Cjcz/1HpkivPWGl8?=
 =?us-ascii?Q?U/P9OlNaNb5PpoqJ8lirWpyB2XNBuAtjSceq6iBmJ1LxtPB2thw6cL0NqEm/?=
 =?us-ascii?Q?+H4cbDNfUaMOar27fE5uzOrKEdQ6D3W0I+7QEI7WLvgrZayZD5llcUSZCYzn?=
 =?us-ascii?Q?JNWhQ0BCaos+ugapfaSfax7jDdviy0P7IjFEXj7rli1wqr9lT2JxCvs9SQvU?=
 =?us-ascii?Q?hkqUBVUNKHnXbx1arizA8DoUGm1Ubnnpq7yddQKzqcziPgyqrNfXiUTNWDuh?=
 =?us-ascii?Q?StuSHJg1dANubo78SyV/DpiwXzFx4RJxEc5buLm5wTWr3Wcxo3QTax09d9T4?=
 =?us-ascii?Q?2S3WbyKvylmM215uot1rIwhFowXYETjmPZc/3m3tdbi0vtAlNssqLmR3NV+2?=
 =?us-ascii?Q?ZKgNA3MabC0/6tFvSwgmBoncHBeArsww97o7r8EiFc5of2eVl88XaobEB1PJ?=
 =?us-ascii?Q?kWE0MkOUKRkLWRoj4KwoWvckrh0AVwp08ee/URAfNPz1g2vga+jbTkl/d1SX?=
 =?us-ascii?Q?4/+FMduvYFNXPTtDaZbCzSiYORvlhdv8ORJ+/EYEESgi0+HXBmqBE7lv9UtE?=
 =?us-ascii?Q?AdytlmckFvVLsDCmy96irjcY4LMddIazO5dlBSi+ix1qAaLgmmq9dr5g2doZ?=
 =?us-ascii?Q?+eQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rLuinzzkkb7X4mMUUpaWgdF5RyVZe+D023EIMKVxeyB6YNHAiCes7NYM/xi4?=
 =?us-ascii?Q?rn7fCEBY6m8AaR6xS7QOzyOG4wgOoyX3Uc2sfVHxLdhWDHKKiZomgyNV2izF?=
 =?us-ascii?Q?8TH2CzohW5Jqx0oSDYb/3/vbgZ6O0FFs2fuGZrAhGA0gzIgEOxwSf6r214Uz?=
 =?us-ascii?Q?wLTwL8Zwmy99/oMkj+NxCZ4nj/alD8HVSjbB88/CyJZ1TSsF6ii51pxXJ7vW?=
 =?us-ascii?Q?4tn6218Je6gYqulxnEfNDxn2toSGOgfhJoej0Tlh7hKARyIpEvAxK2UsdJZr?=
 =?us-ascii?Q?uEx7w34IfkW9OCdE1gEMJlZtl8g8zxGKUMxysB4nlKQn68w5s37riKGFP0Mo?=
 =?us-ascii?Q?vH+ZRUka3/FHc8WHzzVXV4UngIJ3AepDLfuxjDTj1F+cHANPgjwqP21j4eGR?=
 =?us-ascii?Q?9EUAGwlvOHCvWxAkYMlykDVSRXrM/EOSmg3wbqTWnnNBgGCaU2EZHUi6zUZm?=
 =?us-ascii?Q?NyHvLMD3uci9FqROp5ewyYYXgf3t4uXYroKnY0OCX5d2iiIyRtn1e5PZxW7q?=
 =?us-ascii?Q?xBi6SLSoyg64Ar4mBXGUvhwrH2lX9olrIoxnbgqamUvwwbG3EzAKFDR12ZYn?=
 =?us-ascii?Q?vCHmxvTtDP12iEUdbutoacsNFEs4gg/cqWmpn2lHsQCTjYWrjJ2IVBmuNml9?=
 =?us-ascii?Q?9mg0Xl2fMr3UOGNhhwEtquvBGQxxONsMxm3QVxZd8D+YdnbHpR8ByiGQDPqU?=
 =?us-ascii?Q?taAYpC5xycShuxpuBYLYCrbGNPLhzFiEYMhVaowSp9G2nu61qx9aJC1NQAr2?=
 =?us-ascii?Q?eKcF3b5vpcMh0ObjVW1ZVApR8wk+MZBlwSh80R8zP4R493VIHqLGq9fmvMAA?=
 =?us-ascii?Q?DIrOIKXXFnbcEhuHSNZTwmFmNwVlp7eBBSguBAWeJobYTqvB6JUQUkfN+8s1?=
 =?us-ascii?Q?iTLxVAbIMYh8ZwKZ23ePRiG0Q//umnqHRICiuM1BCfUhyTRFpMSFsksavolH?=
 =?us-ascii?Q?Ugv26V6zYn0T4prQCWVs+N3HorYV9mrT1sQgqdgSgrI+T1/Kx5JS9rcd3AOt?=
 =?us-ascii?Q?VaKCCIxbhIqe3QiBfjXP2HVq1vj0Wocp01NLioL37fCU99MfX7nkDoT89/Tp?=
 =?us-ascii?Q?w06Bs0WIqdabOlyH5nmT0CX3dsJhHfVF/YdjjsbnL2UL0jRI4MGcHBZL5s8w?=
 =?us-ascii?Q?AlQck96HCjjxLW2pf29oYBT8XH6AFuYxbzXnADQpcgAKYRJ3nEBCk2fvj+Mc?=
 =?us-ascii?Q?WWUjSwxgLc4wjDgyuzZXEEuSh+q25FDzl+z5uOr6ojjoy/ry/r1HKP8IMqa0?=
 =?us-ascii?Q?rk0mmicrxxuE+EsUUdJPMcZu7ZQ2v81x7gShXxk7WOGaHjUO8pLlR1QbgiFK?=
 =?us-ascii?Q?XvUjBkxDvGU4/Yx9Sqz4ys+Mzt4CSA8/jAuJnnYJTCpvA0nSUsFC93ZOd2I2?=
 =?us-ascii?Q?wNF5/+iw5Tak7cSw+LbeDdiqHQF9PKabmEMiTeK35rYaoYT+rPM4AqwPIPsD?=
 =?us-ascii?Q?dNqMQpBUFz6ND9uO7dqfEvokkmtIh8TJAZ/pfgT9v7dc9AHCFlp0NMFCRU3+?=
 =?us-ascii?Q?8lkCSObdlyLI92FUyvrbCY9sFPFnRefZGqKOLkUw53DiJeDewH9NeYMP+euV?=
 =?us-ascii?Q?Ii1hF234PUslhZOXMCJTMPW/I4IA3rNWnGd7tXck1/bOS5N5p1eZt3Y2Y6mu?=
 =?us-ascii?Q?0g=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 667bb4c1-6198-4f82-ea64-08dcc9b4a4eb
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2024 12:01:27.9414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: epntk3LRY23cZ37PJoKG4ipnd4mbW+cccK1zqGQOmANKGINspwggsbt15c8dTSy8DQ33gHdlTZBs6m+nPJ/ruQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6146

On Fri, 16 Aug 2024 02:10:43 +0200
Danilo Krummrich <dakr@kernel.org> wrote:

> Add a kernel specific `Allocator` trait, that in contrast to the one in
> Rust's core library doesn't require unstable features and supports GFP
> flags.
> 
> Subsequent patches add the following trait implementors: `Kmalloc`,
> `Vmalloc` and `KVmalloc`.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/alloc.rs | 102 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 102 insertions(+)
> 
> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> index 1966bd407017..9932f21b0539 100644
> --- a/rust/kernel/alloc.rs
> +++ b/rust/kernel/alloc.rs
> @@ -11,6 +11,7 @@
>  /// Indicates an allocation error.
>  #[derive(Copy, Clone, PartialEq, Eq, Debug)]
>  pub struct AllocError;
> +use core::{alloc::Layout, ptr::NonNull};
>  
>  /// Flags to be used when allocating memory.
>  ///
> @@ -86,3 +87,104 @@ pub mod flags {
>      /// small allocations.
>      pub const GFP_NOWAIT: Flags = Flags(bindings::GFP_NOWAIT);
>  }
> +
> +/// The kernel's [`Allocator`] trait.
> +///
> +/// An implementation of [`Allocator`] can allocate, re-allocate and free memory buffer described
> +/// via [`Layout`].
> +///
> +/// [`Allocator`] is designed to be implemented as a ZST; [`Allocator`] functions do not operate on
> +/// an object instance.
> +///
> +/// In order to be able to support `#[derive(SmartPointer)]` later on, we need to avoid a design
> +/// that requires an `Allocator` to be instantiated, hence its functions must not contain any kind
> +/// of `self` parameter.
> +///
> +/// # Safety
> +///
> +/// A memory allocation returned from an allocator must remain valid until it is explicitly freed.
> +///
> +/// Any pointer to a valid memory allocation must be valid to be passed to any other [`Allocator`]
> +/// function of the same type.
> +///
> +/// Implementers must ensure that all trait functions abide by the guarantees documented in the
> +/// `# Guarantees` sections.
> +pub unsafe trait Allocator {
> +    /// Allocate memory based on `layout` and `flags`.
> +    ///
> +    /// On success, returns a buffer represented as `NonNull<[u8]>` that satisfies the layout
> +    /// constraints (i.e. minimum size and alignment as specified by `layout`).
> +    ///
> +    /// This function is equivalent to `realloc` when called with `None`.
> +    ///
> +    /// # Guarantees
> +    ///
> +    /// When the return value is `Ok(ptr)`, then `ptr` is
> +    /// - valid for reads and writes for `layout.size()` bytes, until it is passed to
> +    ///   [`Allocator::free`] or [`Allocator::realloc`],
> +    /// - aligned to `layout.align()`,
> +    ///
> +    /// Additionally, `Flags` are honored as documented in
> +    /// <https://docs.kernel.org/core-api/mm-api.html#mm-api-gfp-flags>.
> +    fn alloc(layout: Layout, flags: Flags) -> Result<NonNull<[u8]>, AllocError> {
> +        // SAFETY: Passing `None` to `realloc` is valid by it's safety requirements and asks for a
> +        // new memory allocation.
> +        unsafe { Self::realloc(None, layout, flags) }
> +    }
> +
> +    /// Re-allocate an existing memory allocation to satisfy the requested `layout`.
> +    ///
> +    /// If the requested size is zero, `realloc` behaves equivalent to `free`.
> +    ///
> +    /// If the requested size is larger than the size of the existing allocation, a successful call
> +    /// to `realloc` guarantees that the new or grown buffer has at least `Layout::size` bytes, but
> +    /// may also be larger.
> +    ///
> +    /// If the requested size is smaller than the size of the existing allocation, `realloc` may or
> +    /// may not shrink the buffer; this is implementation specific to the allocator.
> +    ///
> +    /// On allocation failure, the existing buffer, if any, remains valid.
> +    ///
> +    /// The buffer is represented as `NonNull<[u8]>`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// If `ptr == Some(p)`, then `p` must point to an existing and valid memory allocation created
> +    /// by this allocator. The alignment encoded in `layout` must be smaller than or equal to the
> +    /// alignment requested in the previous `alloc` or `realloc` call of the same allocation.
> +    ///
> +    /// Additionally, `ptr` is allowed to be `None`; in this case a new memory allocation is
> +    /// created.
> +    ///
> +    /// # Guarantees
> +    ///
> +    /// This function has the same guarantees as [`Allocator::alloc`]. When `ptr == Some(p)`, then
> +    /// it additionally guarantees that:
> +    /// - the contents of the memory pointed to by `p` are preserved up to the lesser of the new
> +    ///   and old size,
> +    ///   and old size, i.e.
> +    ///   `ret_ptr[0..min(layout.size(), old_size)] == p[0..min(layout.size(), old_size)]`, where
> +    ///   `old_size` is the size of the allocation that `p` points at.
> +

This line seems to be missing `///`?

> +    /// - when the return value is `Err(AllocError)`, then `p` is still valid.
> +    unsafe fn realloc(
> +        ptr: Option<NonNull<u8>>,
> +        layout: Layout,
> +        flags: Flags,
> +    ) -> Result<NonNull<[u8]>, AllocError>;
> +
> +    /// Free an existing memory allocation.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must point to an existing and valid memory allocation created by this `Allocator` and
> +    /// must not be a dangling pointer.
> +    ///
> +    /// The memory allocation at `ptr` must never again be read from or written to.
> +    unsafe fn free(ptr: NonNull<u8>) {
> +        // SAFETY: The caller guarantees that `ptr` points at a valid allocation created by this
> +        // allocator. We are passing a `Layout` with the smallest possible alignment, so it is
> +        // smaller than or equal to the alignment previously used with this allocation.
> +        let _ = unsafe { Self::realloc(Some(ptr), Layout::new::<()>(), Flags(0)) };
> +    }
> +}


