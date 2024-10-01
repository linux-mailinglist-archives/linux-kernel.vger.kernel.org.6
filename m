Return-Path: <linux-kernel+bounces-346518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F76E98C57B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A2F41C22662
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D331CCB41;
	Tue,  1 Oct 2024 18:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="TnRBCUGu"
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022107.outbound.protection.outlook.com [52.101.96.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BDB1CB321;
	Tue,  1 Oct 2024 18:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727807966; cv=fail; b=C9J3fFv0rxV/yB2E0NhNOAzWj6tOcu5ZZfUq142lfkOz88KyPDbeIxXgsTmm54UbkSbu1bgVxZW3cmxUdtnncBYu2vQ6HMToPpyDGXMhx4UOw4XuHDjhRW0YyL0bz/VGsd8gY3oEy0eKaGpDhSKXWN1z+JCPq6AjlyhMicqwC4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727807966; c=relaxed/simple;
	bh=9G2WDFXyNA8jbs582c2F6OYPDsD38icd0vYUf0fvIfc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qYqe9VWjS6MVSEZqPEmRqU68e/iDh+7PiywMMfcK3o9lYHyGfJoTtBo0TESCepBxmC1daQPbeVK6HA2zt/MyHZP4SMmswx2UFzc9Vwz3/Kv/0BFpNF0XxWlmNCactVKKfUtSh0D6FO9Ce/c8Tw26R2mNC+WsIhgA2yRdi422qXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=TnRBCUGu; arc=fail smtp.client-ip=52.101.96.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wW0CET4DH1la4GWSApHvMwB4XvIk1FTUPgzL3RfxcdZUjQfhfss0yQuQjMVDfS3GTNS86xbxBkGvmyr5OPqEyiNaYNH8AXiQE7Kl/fv4lUcWELKqC48bD+e8vMX8xhmKMmuRdQaFXpempXg+6XWvRZQUglx3e8VjRGn7EqeuIg7pdgTFDeLWHF5X97I3YQ66m8ZZdsMh+CGSvuHAw3gE7ocdFw2vQPB+FsBCdQeP0FdhQQfaRhR1Hjz52iUidqPpl2VJabBF59x+r0jCkiHtAbYExY7XU7mz39KrSZs0tYS8on9VtJC5Y9lV/8Ybw5EUUtHSp8xv93T+o0aiWAHpbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vj8HgHvHSR8y/KgV6NT16AGATHyvzNDq0WVuW2q1Y7s=;
 b=CEvQLGcmwOb5zlCbocsXBDnCtW4NBjmqy0vad/DNjmviuqxhhaCV/CWQkuHlbZDkHeRnkG1OO9JdoQ9tBj30xIoW8mXGHuxwvsrtxESS5JAWuYlsDO3C7gfE4UhuNeqjYk451bJvO4HwCy5VnEyuG+bwS1z1tOE9efGvotMYtVLNXu0E7Bxc0mRGaWnp/qEj/BcXmo6O5Kflr6GMYuGrhxZRoedLPlGhJjAamiGtxB8UOdAeO9WVYRp/8oV+dSqU2OdLG1rivcSEsmoRgT6NRXrCMLspUqjZeJ/uZ7RH25DPrcuGkUH43JG5iEkxLSnY8KSMMTf9D5/unsJA+7r00Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vj8HgHvHSR8y/KgV6NT16AGATHyvzNDq0WVuW2q1Y7s=;
 b=TnRBCUGu1cIv5yJmSt3QZ2xEjzGsOZposKxN76u+dTuqMkrPOclqnG5L1M6pk/3D/ddA9RxZuxJSRwJqjYjwe4HuHXfO5iw7fBRN7z5EiizfU24myRGly4KDPwKoTnvRwggJhn2/I767whLSzlMqE8Nz0aSeQaVH369Q5BSWLuU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB6530.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1e6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 18:39:20 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 18:39:20 +0000
Date: Tue, 1 Oct 2024 19:39:18 +0100
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
Subject: Re: [PATCH v8 16/29] rust: alloc: implement kernel `Vec` type
Message-ID: <20241001193918.7178fad1.gary@garyguo.net>
In-Reply-To: <20241001150008.183102-17-dakr@kernel.org>
References: <20241001150008.183102-1-dakr@kernel.org>
	<20241001150008.183102-17-dakr@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0025.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::13) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB6530:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d423bdf-4023-448f-227d-08dce2485d18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S9b1uAVrBMfNJGJ110xFc/lVWBzF+htmNl0UC1Wb3fP+ZZgDWcmDW64kLiYa?=
 =?us-ascii?Q?yQsCyaVzvIPpD6lXmD9seyXLxAQaQmrlXio6167xGWHxcmOA7HnnbQecDgbh?=
 =?us-ascii?Q?4lspTfeIvxbzo9vYSBFIUUAq3q9ni/BD+rEEBgbO8gpR/GZJbXcOltF4K0eU?=
 =?us-ascii?Q?ihmggMcW1WCzdXU+zaK3XEo13kH7KcDvaKBdPHgV3kDNfM2PlyzQIe2avVop?=
 =?us-ascii?Q?x0AQXfHO1L1A3zQUkBHuIOusHzGK6PTFDFSY5MrRVyP9J/UFZPgojqRmrbVH?=
 =?us-ascii?Q?tFFUgTNXKBqCJJDY9o1Twm9vvoTqnZ+yP+zAwuP8eATfMKmENZiv+Zk9aNKC?=
 =?us-ascii?Q?Hv+xSPJvCpcLjgAnZBuWn/Hj5GM18WeEzRSMR6XV2S73lSUnOuuHxb4ZQ8Ma?=
 =?us-ascii?Q?9x4lwxEzYXNn7t4BqoZ9xxwGKYbhIRD4HyBpqyS4qjnnf6oCIigf4aS9YOmV?=
 =?us-ascii?Q?N4kk2E6eVYO0g9ZUHOLQDGEnFftijcUjUTdPjUNVttWpMa25In38FuQBmWto?=
 =?us-ascii?Q?pJzVWvW+JX+Taiay9buLQ18BhONSe6qR4WLoFv5w+TIz829INLnlmlAIM8bY?=
 =?us-ascii?Q?hZuu81bdA2JMKOKkQ/TdZdHaG+ylgQUjHkevbvOSO31MRuq0rp1gpBHIpQPY?=
 =?us-ascii?Q?tBX5wotc3mYF0CJijT44jHo8QmYGTfCHqWVoscySjJTQH+4ToKxU/ve/QM8x?=
 =?us-ascii?Q?PY0fD0J2j5D7wTFjVQeqqwkmabmGLSfLBMpFRGKMXDoNIxJ2e6qa5xlRJYrK?=
 =?us-ascii?Q?9OQzNgpOoQ8PvFElQa9Ez7olvv//VjBnaMDibjKu69HuPlg1H7p2f2oaInvk?=
 =?us-ascii?Q?QYMHF6eH04NMXfu0a+ysw6SY79E2xgShqtfOVhWIxQBe5MWS/zFui5pkJWcX?=
 =?us-ascii?Q?i8iMQXysnhSRKvGweXHyKqDCzwlZwiQmeXLTEi81LUgtDrK0UBTje9/OnmXh?=
 =?us-ascii?Q?FP7pBx1OhBP/aH8dYy6Nx7MkZgZZyYHgGz/WhXvfbEj90mC0212z0I9OWAEi?=
 =?us-ascii?Q?lATezqZKuviUQmCiBwZwkDw8IHE/j1tCiXWfOqhoVzPxvoFySjJMaZkUY8X4?=
 =?us-ascii?Q?kZOHSbEDDAfrTEp5MHeorLySsJMXKgxE1Cgzd/oLSiLdhNtZ7e6W/k+eiHwV?=
 =?us-ascii?Q?HxFeD5Gv7FNtwHfFoFUgUC3NpUbY6xeF2FFNNQdZkfSjPhbBDLEi3DVMexPE?=
 =?us-ascii?Q?9yEWFmTBr5+aXVd6wXINmMQVCwbs6yhBWFS/G1juPXC/hKduYX4EmxZ6a8kS?=
 =?us-ascii?Q?2qIimaz55bOGVYLvuNYk7aYXtTbPxoYrjC4jOTo0dg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2uzcvUDE0/us3sdpn7hW7oJPdlrAnmyRO9qqs7Rc2rQC0VQpwvSyJIVV8mWj?=
 =?us-ascii?Q?Q5BCKzaPcLUS/kPR9xTeP1WulZde3wp3vEHH/4T5+QVd8ITVnKUD7laDUbAL?=
 =?us-ascii?Q?OVOMAcbog1TirOQKFawyRQKsds99OpcEnIqFf81iUBR3W6COO/ICYQV2zUYB?=
 =?us-ascii?Q?Ol/8q27c/ILuRILGZdBvDGGD5G+roHMWZWDz7qqnNq8ygALUxQQKiyGEC2jI?=
 =?us-ascii?Q?qn9nIedyVNoHQpbeXty8AXXjkak+5r5kdeAPSYT0rAjYv4SB++bROcKshg7v?=
 =?us-ascii?Q?XCrL1OgjhzIcu/TaO0u+kQAl4tH8OT8lWH9H6sOkEIRWu1W52Fgfsm9Eygp4?=
 =?us-ascii?Q?5XFHDelWSRobuWpQf08D6+GaBF1hDcnuyUmqoGa7cwkVfLgq03Z5nDHw6uvy?=
 =?us-ascii?Q?EhihzBXGmz8c48r6IL884c0lmVgw1zdyP/rFCB3i16HbN8o/VCUQ4tYKzm5R?=
 =?us-ascii?Q?PfFk6QMpr03yCd2G9Y1SrHzIui7Ouf//dbangsoMJecdyPKThgRYTu5rV/Qa?=
 =?us-ascii?Q?lfyaCZDbFyZe8XsULV7ZA9k6MIxFKFjh2rdRbvnkBL/8c/zwmKBps40Lolu+?=
 =?us-ascii?Q?11Z90p05QWzGPLSjwEqBJ4+dXDKOOuBickY9jlQa6zqmyKKoUXdq+HntkvqK?=
 =?us-ascii?Q?Nqox1LD6xR03jPkU7pNOIRPCqT+LSBq74ynxmm5utIsQOUINTZ+UiZHfNPy4?=
 =?us-ascii?Q?58sDHyj0Q8z31aUpGUGU76yltdEW1mlg2BipkuJypaH+bq3Hkgi+vSaFLi8U?=
 =?us-ascii?Q?emWP/xeo8NkNvVMIsrZmDejvMB6DCh/rWXBZxaoo3pxhIfcm/Onhuej1HT9N?=
 =?us-ascii?Q?y/zpZgFI2NWtquWep+DH/R5JAjoeqrOT1ldBnpN/tZ8rsdHwBZteZacFm5hu?=
 =?us-ascii?Q?mEn0DPrpJNHzhKHnDG+LpNq6NpUII7/3WLKeVOnLiLrcFzt4MVDSez9ErSbW?=
 =?us-ascii?Q?6CuwYnca2DPuRVcU5Fc+vsC/IkeJK/bIdWWuatRi3HL4os3JrELaDpYtge8b?=
 =?us-ascii?Q?2vxacSUiz0s5SFFVvUaW1cPijlCLO8LeanccnWZ/iMtrMWMPcrf5394CA6s6?=
 =?us-ascii?Q?nQZTeSAK/wginFqtH0UHtn56PIG/sZwGcFjGym1JLpaCBDSGF07/QEoZE3O4?=
 =?us-ascii?Q?yddO7H0cWrpnOfuy0HJlXuNlcjNjOJbYcA5hGDRMWQwD0uvvGgzIxRmJq3Gu?=
 =?us-ascii?Q?7M5DhVtaz64n9wkAjS9gZsz/WasqcNdYJYpBS8bw7+ocGShE70RtYBSrHaDF?=
 =?us-ascii?Q?FmTmcQDogvXORNkA+7QuMXCZSown+M6PUiFvwU26z5uMihYvAzzc06U9rYPW?=
 =?us-ascii?Q?LFEE+jn0MfI4DsBaONuhizH6GarcGPL6bumSmUHCH7sq6RkDDqa5odOa9LDB?=
 =?us-ascii?Q?7dKuI/y8tzwBgxDrbcufIBNHGnkaSP9ulicOiVLX5T1D0SH2qCqbUf8UP/l2?=
 =?us-ascii?Q?13xqeGd9dT1xVQ3QdQtSsTRth3pDxjugdd6zyjStv8P2xfJ4wLabJkKAKI2+?=
 =?us-ascii?Q?wAWidDTzFS0534fQQOWKLKi7TK/BpSDW6vsQEB11q6g9BiH/zHH67aoKh6bJ?=
 =?us-ascii?Q?JnwujXBboFsggvaFEgnwBL6vJR0AE1x25AAy85Md?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d423bdf-4023-448f-227d-08dce2485d18
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 18:39:20.8681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/CaikX+0R8fw36F8NMlGNeuwT6huBfm0JPi0A23+2wyGyVjmM7+OMuvrMfGkNGfeLbygxuPp0rLH1pA3XXV0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6530

On Tue,  1 Oct 2024 16:59:51 +0200
Danilo Krummrich <dakr@kernel.org> wrote:

> `Vec` provides a contiguous growable array type with contents allocated
> with the kernel's allocators (e.g. `Kmalloc`, `Vmalloc` or `KVmalloc`).
> 
> In contrast to Rust's stdlib `Vec` type, the kernel `Vec` type considers
> the kernel's GFP flags for all appropriate functions, always reports
> allocation failures through `Result<_, AllocError>` and remains
> independent from unstable features.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Thanks a lot for your work. I think this is much cleaner with the ZST
handling offloaded to `Allocator` and overload checking offloaded to
`ArrayLayout`.

Some nits below, although I think we should apply this and then address
the nits with follow up patches (some may also be good first issues).

Therefore:

Reviewed-by: Gary Guo <gary@garyguo.net>

Best,
Gary

> ---
>  rust/kernel/alloc.rs      |   6 +
>  rust/kernel/alloc/kvec.rs | 637 ++++++++++++++++++++++++++++++++++++++
>  rust/kernel/prelude.rs    |   2 +-
>  3 files changed, 644 insertions(+), 1 deletion(-)
>  create mode 100644 rust/kernel/alloc/kvec.rs
> 
> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> index bf143a71d53d..961070daf6db 100644
> --- a/rust/kernel/alloc.rs
> +++ b/rust/kernel/alloc.rs
> @@ -5,6 +5,7 @@
>  #[cfg(not(any(test, testlib)))]
>  pub mod allocator;
>  pub mod kbox;
> +pub mod kvec;
>  pub mod layout;
>  pub mod vec_ext;
>  
> @@ -19,6 +20,11 @@
>  pub use self::kbox::KVBox;
>  pub use self::kbox::VBox;
>  
> +pub use self::kvec::KVVec;
> +pub use self::kvec::KVec;
> +pub use self::kvec::VVec;
> +pub use self::kvec::Vec;
> +
>  /// Indicates an allocation error.
>  #[derive(Copy, Clone, PartialEq, Eq, Debug)]
>  pub struct AllocError;
> diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> new file mode 100644
> index 000000000000..44aade0a653b
> --- /dev/null
> +++ b/rust/kernel/alloc/kvec.rs
> @@ -0,0 +1,637 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Implementation of [`Vec`].
> +
> +use super::{
> +    allocator::{KVmalloc, Kmalloc, Vmalloc},
> +    layout::ArrayLayout,
> +    AllocError, Allocator, Box, Flags,
> +};
> +use core::{
> +    fmt,
> +    marker::PhantomData,
> +    mem::{ManuallyDrop, MaybeUninit},
> +    ops::Deref,
> +    ops::DerefMut,
> +    ops::Index,
> +    ops::IndexMut,
> +    ptr,
> +    ptr::NonNull,
> +    slice,
> +    slice::SliceIndex,
> +};
> +
> +/// Create a [`KVec`] containing the arguments.

This should mention that it allocates using `GFP_KERNEL`.

> +///
> +/// # Examples
> +///
> +/// ```
> +/// let mut v = kernel::kvec![];
> +/// v.push(1, GFP_KERNEL)?;
> +/// assert_eq!(v, [1]);
> +///
> +/// let mut v = kernel::kvec![1; 3]?;
> +/// v.push(4, GFP_KERNEL)?;
> +/// assert_eq!(v, [1, 1, 1, 4]);
> +///
> +/// let mut v = kernel::kvec![1, 2, 3]?;
> +/// v.push(4, GFP_KERNEL)?;
> +/// assert_eq!(v, [1, 2, 3, 4]);
> +///
> +/// # Ok::<(), Error>(())
> +/// ```
> +#[macro_export]
> +macro_rules! kvec {
> +    () => (
> +        $crate::alloc::KVec::new()
> +    );
> +    ($elem:expr; $n:expr) => (
> +        $crate::alloc::KVec::from_elem($elem, $n, GFP_KERNEL)
> +    );
> +    ($($x:expr),+ $(,)?) => (
> +        match $crate::alloc::KBox::new_uninit(GFP_KERNEL) {
> +            Ok(b) => Ok($crate::alloc::KVec::from($crate::alloc::KBox::write(b, [$($x),+]))),
> +            Err(e) => Err(e),
> +        }
> +    );
> +}
> +
> +/// The kernel's [`Vec`] type.
> +///
> +/// A contiguous growable array type with contents allocated with the kernel's allocators (e.g.
> +/// [`Kmalloc`], [`Vmalloc`] or [`KVmalloc`]), written `Vec<T, A>`.
> +///
> +/// For non-zero-sized values, a [`Vec`] will use the given allocator `A` for its allocation. For
> +/// the most common allocators the type aliases [`KVec`], [`VVec`] and [`KVVec`] exist.
> +///
> +/// For zero-sized types the [`Vec`]'s pointer must be `dangling_mut::<T>`; no memory is allocated.
> +///
> +/// Generally, [`Vec`] consists of a pointer that represents the vector's backing buffer, the
> +/// capacity of the vector (the number of elements that currently fit into the vector), it's length
> +/// (the number of elements that are currently stored in the vector) and the `Allocator` type used
> +/// to allocate (and free) the backing buffer.
> +///
> +/// A [`Vec`] can be deconstructed into and (re-)constructed from it's previously named raw parts
> +/// and manually modified.
> +///
> +/// [`Vec`]'s backing buffer gets, if required, automatically increased (re-allocated) when elements
> +/// are added to the vector.
> +///
> +/// # Invariants
> +///
> +/// - `self.ptr` is always properly aligned and either points to memory allocated with `A` or, for
> +///   zero-sized types, is a dangling, well aligned pointer.
> +///
> +/// - `self.len` always represents the exact number of elements stored in the vector.
> +///
> +/// - `self.layout` represents the absolute number of elements that can be stored within the vector
> +///   without re-allocation. However, it is legal for the backing buffer to be larger than `layout`.
> +///
> +/// - The `Allocator` type `A` of the vector is the exact same `Allocator` type the backing buffer
> +///   was allocated with (and must be freed with).
> +pub struct Vec<T, A: Allocator> {
> +    ptr: NonNull<T>,
> +    /// Represents the actual buffer size as `cap` times `size_of::<T>` bytes.
> +    ///
> +    /// Note: This isn't quite the same as `Self::capacity`, which in contrast returns the number of
> +    /// elements we can still store without reallocating.
> +    layout: ArrayLayout<T>,
> +    len: usize,
> +    _p: PhantomData<A>,
> +}
> +
> +/// Type alias for [`Vec`] with a [`Kmalloc`] allocator.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// let mut v = KVec::new();
> +/// v.push(1, GFP_KERNEL)?;
> +/// assert_eq!(&v, &[1]);
> +///
> +/// # Ok::<(), Error>(())
> +/// ```
> +pub type KVec<T> = Vec<T, Kmalloc>;
> +
> +/// Type alias for [`Vec`] with a [`Vmalloc`] allocator.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// let mut v = VVec::new();
> +/// v.push(1, GFP_KERNEL)?;
> +/// assert_eq!(&v, &[1]);
> +///
> +/// # Ok::<(), Error>(())
> +/// ```
> +pub type VVec<T> = Vec<T, Vmalloc>;
> +
> +/// Type alias for [`Vec`] with a [`KVmalloc`] allocator.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// let mut v = KVVec::new();
> +/// v.push(1, GFP_KERNEL)?;
> +/// assert_eq!(&v, &[1]);
> +///
> +/// # Ok::<(), Error>(())
> +/// ```
> +pub type KVVec<T> = Vec<T, KVmalloc>;
> +
> +// SAFETY: `Vec` is `Send` if `T` is `Send` because `Vec` owns its elements.
> +unsafe impl<T, A> Send for Vec<T, A>
> +where
> +    T: Send,
> +    A: Allocator,
> +{
> +}
> +
> +// SAFETY: `Vec` is `Sync` if `T` is `Sync` because `Vec` owns its elements.
> +unsafe impl<T, A> Sync for Vec<T, A>
> +where
> +    T: Sync,
> +    A: Allocator,
> +{
> +}
> +
> +impl<T, A> Vec<T, A>
> +where
> +    A: Allocator,
> +{
> +    #[inline]
> +    const fn is_zst() -> bool {
> +        core::mem::size_of::<T>() == 0
> +    }
> +
> +    /// Returns the number of elements that can be stored within the vector without allocating
> +    /// additional memory.
> +    pub fn capacity(&self) -> usize {
> +        if const { Self::is_zst() } {
> +            usize::MAX
> +        } else {
> +            self.layout.len()
> +        }
> +    }
> +
> +    /// Returns the number of elements stored within the vector.
> +    #[inline]
> +    pub fn len(&self) -> usize {
> +        self.len
> +    }
> +
> +    /// Forcefully sets `self.len` to `new_len`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// - `new_len` must be less than or equal to [`Self::capacity`].
> +    /// - If `new_len` is greater than `self.len`, all elements within the interval
> +    ///   [`self.len`,`new_len`) must be initialized.
> +    #[inline]
> +    pub unsafe fn set_len(&mut self, new_len: usize) {
> +        debug_assert!(new_len <= self.capacity());
> +        self.len = new_len;
> +    }
> +
> +    /// Returns a slice of the entire vector.
> +    #[inline]
> +    pub fn as_slice(&self) -> &[T] {
> +        self
> +    }
> +
> +    /// Returns a mutable slice of the entire vector.
> +    #[inline]
> +    pub fn as_mut_slice(&mut self) -> &mut [T] {
> +        self
> +    }
> +
> +    /// Returns a mutable raw pointer to the vector's backing buffer, or, if `T` is a ZST, a
> +    /// dangling raw pointer.
> +    #[inline]
> +    pub fn as_mut_ptr(&mut self) -> *mut T {
> +        self.ptr.as_ptr()
> +    }
> +
> +    /// Returns a raw pointer to the vector's backing buffer, or, if `T` is a ZST, a dangling raw
> +    /// pointer.
> +    #[inline]
> +    pub fn as_ptr(&self) -> *const T {
> +        self.ptr.as_ptr()
> +    }
> +
> +    /// Returns `true` if the vector contains no elements, `false` otherwise.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// let mut v = KVec::new();
> +    /// assert!(v.is_empty());
> +    ///
> +    /// v.push(1, GFP_KERNEL);
> +    /// assert!(!v.is_empty());
> +    /// ```
> +    #[inline]
> +    pub fn is_empty(&self) -> bool {
> +        self.len() == 0
> +    }
> +
> +    /// Creates a new, empty Vec<T, A>.
> +    ///
> +    /// This method does not allocate by itself.
> +    #[inline]
> +    pub const fn new() -> Self {

Missing // INVARIANT here.

> +        Self {
> +            ptr: NonNull::dangling(),
> +            layout: ArrayLayout::empty(),
> +            len: 0,
> +            _p: PhantomData::<A>,
> +        }
> +    }
> +
> +    /// Returns a slice of `MaybeUninit<T>` for the remaining spare capacity of the vector.
> +    pub fn spare_capacity_mut(&mut self) -> &mut [MaybeUninit<T>] {
> +        // SAFETY:
> +        // - `self.len` is smaller than `self.capacity` and hence, the resulting pointer is
> +        //   guaranteed to be part of the same allocated object.
> +        // - `self.len` can not overflow `isize`.
> +        let ptr = unsafe { self.as_mut_ptr().add(self.len) } as *mut MaybeUninit<T>;
> +
> +        // SAFETY: The memory between `self.len` and `self.capacity` is guaranteed to be allocated
> +        // and valid, but uninitialized.
> +        unsafe { slice::from_raw_parts_mut(ptr, self.capacity() - self.len) }
> +    }
> +
> +    /// Appends an element to the back of the [`Vec`] instance.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// let mut v = KVec::new();
> +    /// v.push(1, GFP_KERNEL)?;
> +    /// assert_eq!(&v, &[1]);
> +    ///
> +    /// v.push(2, GFP_KERNEL)?;
> +    /// assert_eq!(&v, &[1, 2]);
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    pub fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError> {
> +        self.reserve(1, flags)?;
> +
> +        // SAFETY:
> +        // - `self.len` is smaller than `self.capacity` and hence, the resulting pointer is
> +        //   guaranteed to be part of the same allocated object.
> +        // - `self.len` can not overflow `isize`.
> +        let ptr = unsafe { self.as_mut_ptr().add(self.len) };
> +
> +        // SAFETY:
> +        // - `ptr` is properly aligned and valid for writes.
> +        unsafe { core::ptr::write(ptr, v) };
> +
> +        // SAFETY: We just initialised the first spare entry, so it is safe to increase the length
> +        // by 1. We also know that the new length is <= capacity because of the previous call to
> +        // `reserve` above.
> +        unsafe { self.set_len(self.len() + 1) };
> +        Ok(())
> +    }
> +
> +    /// Creates a new [`Vec`] instance with at least the given capacity.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// let v = KVec::<u32>::with_capacity(20, GFP_KERNEL)?;
> +    ///
> +    /// assert!(v.capacity() >= 20);
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    pub fn with_capacity(capacity: usize, flags: Flags) -> Result<Self, AllocError> {
> +        let mut v = Vec::new();
> +
> +        v.reserve(capacity, flags)?;
> +
> +        Ok(v)
> +    }
> +
> +    /// Creates a Vec<T, A> from a pointer, a length and a capacity using the allocator `A`.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// let mut v = kernel::kvec![1, 2, 3]?;
> +    /// v.reserve(1, GFP_KERNEL)?;
> +    ///
> +    /// let (mut ptr, mut len, cap) = v.into_raw_parts();
> +    ///
> +    /// // SAFETY: We've just reserved memory for another element.
> +    /// unsafe { ptr.add(len).write(4) };
> +    /// len += 1;
> +    ///
> +    /// // SAFETY: We only wrote an additional element at the end of the `KVec`'s buffer and
> +    /// // correspondingly increased the length of the `KVec` by one. Otherwise, we construct it
> +    /// // from the exact same raw parts.
> +    /// let v = unsafe { KVec::from_raw_parts(ptr, len, cap) };
> +    ///
> +    /// assert_eq!(v, [1, 2, 3, 4]);
> +    ///
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    ///
> +    /// # Safety
> +    ///
> +    /// If `T` is a ZST:
> +    ///
> +    /// - `ptr` must be a dangling, well aligned pointer.
> +    ///
> +    /// Otherwise:
> +    ///
> +    /// - `ptr` must have been allocated with the allocator `A`.
> +    /// - `ptr` must satisfy or exceed the alignment requirements of `T`.
> +    /// - `ptr` must point to memory with a size of at least `size_of::<T>() * capacity`.
> +    ///    bytes.
> +    /// - The allocated size in bytes must not be larger than `isize::MAX`.
> +    /// - `length` must be less than or equal to `capacity`.
> +    /// - The first `length` elements must be initialized values of type `T`.
> +    ///
> +    /// It is also valid to create an empty `Vec` passing a dangling pointer for `ptr` and zero for
> +    /// `cap` and `len`.
> +    pub unsafe fn from_raw_parts(ptr: *mut T, length: usize, capacity: usize) -> Self {
> +        let layout = if Self::is_zst() {
> +            ArrayLayout::empty()
> +        } else {
> +            // SAFETY: By the safety requirements of this function, `capacity * size_of::<T>()` is
> +            // smaller than `isize::MAX`.
> +            unsafe { ArrayLayout::new_unchecked(capacity) }
> +        };

Missing // INVARIANT here.

> +
> +        Self {
> +            // SAFETY: By the safety requirements, `ptr` is either dangling or pointing to a valid
> +            // memory allocation, allocated with `A`.
> +            ptr: unsafe { NonNull::new_unchecked(ptr) },
> +            layout,
> +            len: length,
> +            _p: PhantomData::<A>,
> +        }
> +    }
> +
> +    /// Consumes the `Vec<T, A>` and returns its raw components `pointer`, `length` and `capacity`.
> +    ///
> +    /// This will not run the destructor of the contained elements and for non-ZSTs the allocation
> +    /// will stay alive indefinitely. Use [`Vec::from_raw_parts`] to recover the [`Vec`], drop the
> +    /// elements and free the allocation, if any.
> +    pub fn into_raw_parts(self) -> (*mut T, usize, usize) {
> +        let mut me = ManuallyDrop::new(self);
> +        let len = me.len();
> +        let capacity = me.capacity();
> +        let ptr = me.as_mut_ptr();
> +        (ptr, len, capacity)
> +    }
> +
> +    /// Ensures that the capacity exceeds the length by at least `additional`
> +    /// elements.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// let mut v = KVec::new();
> +    /// v.push(1, GFP_KERNEL)?;
> +    ///
> +    /// v.reserve(10, GFP_KERNEL)?;
> +    /// let cap = v.capacity();
> +    /// assert!(cap >= 10);
> +    ///
> +    /// v.reserve(10, GFP_KERNEL)?;
> +    /// let new_cap = v.capacity();
> +    /// assert_eq!(new_cap, cap);
> +    ///
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    pub fn reserve(&mut self, additional: usize, flags: Flags) -> Result<(), AllocError> {
> +        let len = self.len();
> +        let cap = self.capacity();
> +
> +        if cap - len >= additional {
> +            return Ok(());
> +        }
> +
> +        if Self::is_zst() {
> +            // The capacity is already `usize::MAX` for ZSTs, we can't go higher.
> +            return Err(AllocError);
> +        }
> +
> +        // We know that `cap <= isize::MAX` because of the type invariants of `Self`. So the
> +        // multiplication by two won't overflow.
> +        let new_cap = core::cmp::max(cap * 2, len.checked_add(additional).ok_or(AllocError)?);
> +        let layout = ArrayLayout::new(new_cap).map_err(|_| AllocError)?;
> +
> +        // SAFETY:
> +        // - `ptr` is valid because it's either `None` or comes from a previous call to
> +        //   `A::realloc`.
> +        // - `self.layout` matches the `ArrayLayout` of the preceeding allocation.
> +        let ptr = unsafe {
> +            A::realloc(
> +                Some(self.ptr.cast()),
> +                layout.into(),
> +                self.layout.into(),
> +                flags,
> +            )?
> +        };

Missing // INVARIANT here.

> +
> +        self.ptr = ptr.cast();
> +        self.layout = layout;
> +
> +        Ok(())
> +    }
> +}


