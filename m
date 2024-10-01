Return-Path: <linux-kernel+bounces-346513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 589A998C56E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C507A1C25B07
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8791CDA2D;
	Tue,  1 Oct 2024 18:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="LBp6AJKf"
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01on2092.outbound.protection.outlook.com [40.107.122.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F011CDA18;
	Tue,  1 Oct 2024 18:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.122.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727807504; cv=fail; b=uR929rkeouJ9QHAAQ+/4pp1jEns1F3XK1kwCsUgGWUIsOoyjrXkTOqkkxCKdL6krcDXm0kGyDAFS10lT0G5WIWZacyGZ2uSntHRohJJFkmOmVHocVlaGB6NEUwjKK4WlX96pb80wqrHNgmSmIRfliUL1MV3Qir2RXbm0VkfOn5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727807504; c=relaxed/simple;
	bh=dPf6fhy4DX9L3GgyjJRJSesBGYLMSTm7SFMP9S5WDP4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QEUHseejFdBA8q7Ihu0cwrN70VPw/KiNfmTiFQAa94CTtTaa2TjMyygXdc1KyWOoHRc8BTUhv+UooG6xRYUnSgqQ+u+2OV0TTROVZCKyuZoi+0Q72IwaFByFEU5h4zOf83Cd/P32hXTBxhqR72HsEv/+oP94aqBibnuYfWWE97U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=LBp6AJKf; arc=fail smtp.client-ip=40.107.122.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eKiF6zSp9lBjcRR1UuidhTnL2I3N/NSYfCH8aRYx9UmdBahA+VegXFKGszyn4Gbvci4nTdC3YWlSzdpumvODm1yhD8tOHXHDvGhsAzfVKOoGFLZwDmsvbzvy1/LJLw3aqy2S58CV+E44i0CMBUbzD0WXvPxSgMObB5QJUykl2kjJG8g27rWJCWN1cLT7WXvG3ygwBJ/AIJ9G4ntlhxj9jYoDpzT/YpUo6sM9iWmNLhyOT2/El1kYexHU2jD47R0WGmmAuKFtLH3Pd97fYDTHTqWm3FsosrMXYmuh5AK+GhaOLdj7mLTyu+4osrxsCUgrVXBY6KBe8uVDw+jDNcgw7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLJ0lvliVjO9N4P7uDnIqNVgUULTc9AneUEB/vu3Yko=;
 b=wnwkwhCSHA4JAn/YfyZpAsgBtf6igJitosC/C2Bzfg2fItTZA75UeLcCgCiga95gZpI35ddhjzFHC3xbpiEZpswQfvLRBpwj8fDJMOY2dioLMBMDe0do3siEGdRr7wKWOWMpVswSTA99anh7q5yUqXml4/M4sp6j4/iLNEPebd3IFAjscyuUY0YywgI+9BuV84Yh61mHYz1wdD6bqFMAjJjbsq8L04j7OIeGtR7uW7xR+A/xOjN0vDh6OO/JGLdGHJ4osyTHuAV/lRHguDjkT085AxvwxByICUM6MXkNTCJ3KO+4VG21WCKsIO8Na3780n+78U+uvA1Qwb5CXigqog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLJ0lvliVjO9N4P7uDnIqNVgUULTc9AneUEB/vu3Yko=;
 b=LBp6AJKf3OzxVftCf5suOjQQ1mvzKkPrnEt+MorD+l32QySQJn3IWfEEjTCaUUj+SrcEOMLW8MI7auQ1hm8WuisUUJX90rEIy+3TX3yeryL9AQfklUpSl5aXgmykNXxYbW81pZXRBAAU9zycyb4wozyauyVGZeHqqQ31YdKfEL4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO9P265MB7730.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3a2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 18:31:39 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 18:31:39 +0000
Date: Tue, 1 Oct 2024 19:31:36 +0100
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
Subject: Re: [PATCH v8 15/29] rust: alloc: introduce `ArrayLayout`
Message-ID: <20241001193136.7db65bb4.gary@garyguo.net>
In-Reply-To: <20241001150008.183102-16-dakr@kernel.org>
References: <20241001150008.183102-1-dakr@kernel.org>
	<20241001150008.183102-16-dakr@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0035.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::11) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO9P265MB7730:EE_
X-MS-Office365-Filtering-Correlation-Id: ecfe4436-4b4b-4249-9c26-08dce24749f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gTERS1b00WL5ZRSR6B1aXZY0H2nPrrlGHxwpS941VApb0O4aNA7FiqnPa/xM?=
 =?us-ascii?Q?rsgjhCBLy1cGY6auz04SSpDyIUvs3VPOsx5zuTCsmHTiqsFv1aL4KaMdnw69?=
 =?us-ascii?Q?H+mrKuUaICiIP/a7fiCZhcBOmEdOS21zFRehOy4VFabGL0/V14lQac3/4B8f?=
 =?us-ascii?Q?iFW1YxmUBrav0z64qEmh/O4P/UL3Plm1A32S2rtJf4DqjGXbZHNASFJSojgU?=
 =?us-ascii?Q?SZ2ttCt26iq4lobZqCtpP4TPT2sxM+5xHNtCFoFnydjcd8Rp7Qe39LJElaSN?=
 =?us-ascii?Q?VGb9JOQuWHjIiueXnjRN0WZvX9EKqvzN0Cv5hfqcBhs3ar909gzR1TQ185X1?=
 =?us-ascii?Q?kK1OExP6QFbMBKKreCa/a9bR+25heU3jZIaRjtsV0sWW0t5aFMezqAtoykAE?=
 =?us-ascii?Q?oMJBByFJ2fhnSyzJkuiaalwRnj0o9ftQjXWGVXLLNtous3P7lBzYyWPabdo0?=
 =?us-ascii?Q?5UDPPx7YRqETQwXRuA+WOdCoxfa9qx3UwFwRAcxG3P1JhMBShjG77W+USonS?=
 =?us-ascii?Q?F3NomGspdRFpI5SFFBBdYpAjVWXy6lDBjwtGfazqBqnfGM4SVKcEKJpSzhl3?=
 =?us-ascii?Q?9iBH3waobRNOGtlBBVW2CKaTavKvhvka81+s31dqcOZ6ZYMOC2SYRO/M2Kb6?=
 =?us-ascii?Q?97yHOgZnDDR36sVkQtZ/UJYA+fqpzO+VgP0IBiJHDRwSzcgxIB4x7kUsS3ab?=
 =?us-ascii?Q?N5hLeMRsS5KmUTLCF9LFS6as7k+TjcifWtkOhaDFNnagNUEK6Nu/MGvSg3uM?=
 =?us-ascii?Q?Msvvqssvm+bNdtrjQ4Ax4icPxeD+XMcm93KQli10JRIjsYgyk7ypwxHYp/jR?=
 =?us-ascii?Q?2Tazj1mCNX603abVhoBGddFFfaiQuDDzzzzY+lkkJXr7W3BABmO+zC8EGRds?=
 =?us-ascii?Q?2LmP2WXPqbsKu3ScBbZySNz3QLFp8So7WgeN3uh21HCSuViMOZlHxfdCRS2a?=
 =?us-ascii?Q?+x5YHQREeFaTcaum1SlKPsOzr3I1u+KhnN5hUYvmxX5vUl4LVVSGoI3o4x/0?=
 =?us-ascii?Q?n8E7m9qCIKFWCYQJr/fWCmaRroQIJaGSmXa2RjQ3OTn6ZZJ5TO9FiahccLle?=
 =?us-ascii?Q?xv4Xb/f3l0IJ5ai2TF9t+EHEnWnMTOg5mVSmRmjvtLkujweSnu37lNHS09Z5?=
 =?us-ascii?Q?aGfL1dhAXE2uxAahhVtEkm31a3pT7MaUc7ZPBlxUYvPZkocmQLGPRAMRHuU5?=
 =?us-ascii?Q?Vi+hNxFAHs0Hw9Sw3H9CBGYiGbbRNCor3qzeHwoAQs09OpNVThNhP9kT2SaK?=
 =?us-ascii?Q?Gl7R78Z/HQDGff+EPGoDN+4F82JZCuOeuLlpqg9/Ag=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U2SNEB8Wr0tEQMKFaV2DIabCug9qOVQGrNBQSm0u0nrifMwe9DDbZhyIRPlY?=
 =?us-ascii?Q?CvH4johSrkQH7VH5K48IHWcHvnB47u8Z7uj7qv6zk0QzhYHAI06w7hSJJ2JM?=
 =?us-ascii?Q?7QmeUlr8jMPrOWRshQK0fLTWlpsWBE/hcpesSqx61ksGZrLFxrTt7owh+NO6?=
 =?us-ascii?Q?VkQVjssrRqHGYWePSTX+HZHywm44lvj3TbV1xJ5FP3m/wVE6xUmBzP3XWOX9?=
 =?us-ascii?Q?EjGLdD+zWcYl/VP0ZWOYrANq0GbBF1RugqxZp+1TWupASTCaWdsdhpNfDkEq?=
 =?us-ascii?Q?x7Xk6/JqrOEWIT6xPpzI4r7QWJXyLtyxuhyKrv1Gc5zHbhlFLQ2DCUmYNpSP?=
 =?us-ascii?Q?Q//5CcnFM7ZVSZYGr3iy9Ms6B93f9noce2B+e1jwOem0NvJNpBgK3E83MPYH?=
 =?us-ascii?Q?5BezLAek36S+hqVh7I4bM8UGKFd7IaaVJ/x6nWVE7B/A6p41u4doCwl00Y1z?=
 =?us-ascii?Q?1aHDBjztRnYGrX5gA95XRcSNgfg9t+9H5dw/tj/K5NuXXZpUbzlevzVthfbO?=
 =?us-ascii?Q?6dTDUBxFWvU8M76qAKf37AdoucDaGY5Y/N/wzeGgZbPHxVL2tuF5NCxazJ6M?=
 =?us-ascii?Q?oqthl397aQWSSXe/LBycgf0xxyMbmEQkMbT+hKPVHj+NDr8PdlcQtcMj6yA7?=
 =?us-ascii?Q?fy4DxxsqnqVIWhXO3QyoCoHfk6PgW7yo/vXK/YKCIBJc13OCjUz20dXbMfk6?=
 =?us-ascii?Q?X9O7AA9saYrjM7eKia9MdIAfXz1MDZAftPDuzvXYGUdlCDTG0G2J1vb8qiPe?=
 =?us-ascii?Q?tITu6MfsKwB2q26ko3C6KoaSoiKVvmvue5qk37t6zffBH2ydWsV1YZ4LvtH1?=
 =?us-ascii?Q?lXT0xkTsTmKQll89uT81qNJP2/KhY5dPT/1Fr82mmlsnN+rzgpHtmNccMV5R?=
 =?us-ascii?Q?WkU+ktTQ7tzYO0JoFyVuuge3MvV4dxBw3cXQkJWlQyVAQmgBWhLAShdi+ycI?=
 =?us-ascii?Q?a0gpEEaNABAKgaVigqD36OYGC0vJRcWb7NbhTorgJv5AUQhYu6sopDusRt8s?=
 =?us-ascii?Q?ahTyJsJtDhTg4HUMBEJxuBx9wvy/zvYjM5QXvEjKxvcBvsrhl9/mGdYrU2cF?=
 =?us-ascii?Q?pwwgxONcisWn9R3oTVa5kjbeLXS1InSThO8Rho4r4JehSUxItotLBE7gwNB7?=
 =?us-ascii?Q?WEvLgb2LukLD6OjG/QfZcsDBU2K6XJ5HX37HYhToZgM4199xo24RhboSwMRy?=
 =?us-ascii?Q?RKueUeYpBnxnO4TRVbPHwi3mfSAjVn/HhvQGz2ySTdo8xaocYk0efmwM1+pl?=
 =?us-ascii?Q?VnBiITfZ7mejdLucgTIN9qauabsViOEtrLEtLyRwe/j3ZdPgqzf4pZ4+U0yv?=
 =?us-ascii?Q?1LU3wTgIl8t7Hf5Io+OFQxgtozHMewwglfUC2/k0S6zsyiLebAKHHfG0Qp+P?=
 =?us-ascii?Q?8tjCFZMNZTjB+SJXOD5xcP1sAX3k9vKaUYY8X/TEQna1dE0GYTkaLIMRTmwH?=
 =?us-ascii?Q?qlwIbO55GEzSsTRZ98RMovJAbxYT2hBwp2YobcEfW3SnUtszW9pbkczoA3xZ?=
 =?us-ascii?Q?XGolyVypmiuPEZHmUb0y47tyBt8x15N5eGM8V2QUr/EbUiLO6PvFGRR5ezLK?=
 =?us-ascii?Q?zJjpdTOdu86GHxIqC34ci2M4SCwGDqsyka5M+jLT?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ecfe4436-4b4b-4249-9c26-08dce24749f0
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 18:31:39.1787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f5UcI5U4yPUwtoIE9z1MmsqGkU/2TQcOOBQ028tsbnX/ODZANEqi2T9lvrnWx2LBEJUbOrNPihIb4sZdVCPdhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P265MB7730

On Tue,  1 Oct 2024 16:59:50 +0200
Danilo Krummrich <dakr@kernel.org> wrote:

> From: Benno Lossin <benno.lossin@proton.me>
> 
> When allocating memory for arrays using allocators, the `Layout::array`
> function is typically used. It returns a result, since the given size
> might be too big. However, `Vec` and its iterators store their allocated
> capacity and thus they already did check that the size is not too big.
> 
> The `ArrayLayout` type provides this exact behavior, as it can be
> infallibly converted into a `Layout`. Instead of a `usize` capacity,
> `Vec` and other similar array-storing types can use `ArrayLayout`
> instead.
> 
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/alloc.rs        |  1 +
>  rust/kernel/alloc/layout.rs | 91 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 92 insertions(+)
>  create mode 100644 rust/kernel/alloc/layout.rs
> 
> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> index ebe58247504f..bf143a71d53d 100644
> --- a/rust/kernel/alloc.rs
> +++ b/rust/kernel/alloc.rs
> @@ -5,6 +5,7 @@
>  #[cfg(not(any(test, testlib)))]
>  pub mod allocator;
>  pub mod kbox;
> +pub mod layout;
>  pub mod vec_ext;
>  
>  #[cfg(any(test, testlib))]
> diff --git a/rust/kernel/alloc/layout.rs b/rust/kernel/alloc/layout.rs
> new file mode 100644
> index 000000000000..a9c987aad8fb
> --- /dev/null
> +++ b/rust/kernel/alloc/layout.rs
> @@ -0,0 +1,91 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Memory layout.
> +//!
> +//! Custom layout types extending or improving [`Layout`].
> +
> +use core::{alloc::Layout, marker::PhantomData};
> +
> +/// Error when constructing an [`ArrayLayout`].
> +pub struct LayoutError;
> +
> +/// A layout for an array `[T; n]`.
> +///
> +/// # Invariants
> +///
> +/// - `len * size_of::<T>() <= isize::MAX`
> +pub struct ArrayLayout<T> {
> +    len: usize,
> +    _phantom: PhantomData<fn() -> T>,
> +}
> +
> +impl<T> Clone for ArrayLayout<T> {
> +    fn clone(&self) -> Self {
> +        *self
> +    }
> +}
> +impl<T> Copy for ArrayLayout<T> {}
> +
> +const ISIZE_MAX: usize = isize::MAX as usize;
> +
> +impl<T> ArrayLayout<T> {
> +    /// Creates a new layout for `[T; 0]`.
> +    pub const fn empty() -> Self {
> +        // INVARIANT: `0 * size_of::<T>() <= isize::MAX`
> +        Self {
> +            len: 0,
> +            _phantom: PhantomData,
> +        }
> +    }
> +
> +    /// Creates a new layout for `[T; len]`.
> +    ///
> +    /// # Errors
> +    ///
> +    /// When `len * size_of::<T>()` overflows or when `len * size_of::<T>() > isize::MAX`.
> +    pub const fn new(len: usize) -> Result<Self, LayoutError> {
> +        match len.checked_mul(size_of::<T>()) {
> +            Some(len) if len <= ISIZE_MAX => {
> +                // INVARIANT: we checked above that `len * size_of::<T>() <= isize::MAX`
> +                Ok(Self {
> +                    len,
> +                    _phantom: PhantomData,
> +                })
> +            }
> +            _ => Err(LayoutError),
> +        }
> +    }
> +
> +    /// Creates a new layout for `[T; len]`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `len` must be a value, for which `len * size_of::<T>() <= isize::MAX` is true.
> +    pub unsafe fn new_unchecked(len: usize) -> Self {

nit: this can also be const, although this can be added when need arise
(or one may use `new(...).unwrap()` in const context, since it doesn't
actually generate a call to `BUG`).

> +        // INVARIANT: By the safety requirements of this function
> +        // `len * size_of::<T>() <= isize::MAX`.
> +        Self {
> +            len,
> +            _phantom: PhantomData,
> +        }
> +    }
> +
> +    /// Returns the number of array elements represented by this layout.
> +    pub const fn len(&self) -> usize {
> +        self.len
> +    }
> +
> +    /// Returns `true` when no array elements are represented by this layout.
> +    pub const fn is_empty(&self) -> bool {
> +        self.len == 0
> +    }
> +}
> +
> +impl<T> From<ArrayLayout<T>> for Layout {
> +    fn from(value: ArrayLayout<T>) -> Self {
> +        let res = Layout::array::<T>(value.len);
> +        // SAFETY: by the type invariant of `ArrayLayout` we have
> +        // `len * size_of::<T>() <= isize::MAX` and thus the result must be `Ok`.
> +        unsafe { res.unwrap_unchecked() }
> +    }
> +}


