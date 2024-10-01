Return-Path: <linux-kernel+bounces-346497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3B998C54D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FB5C286F29
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE411CCEC9;
	Tue,  1 Oct 2024 18:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="LoyByCrP"
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2103.outbound.protection.outlook.com [40.107.121.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE59321D;
	Tue,  1 Oct 2024 18:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.121.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727807244; cv=fail; b=NF17qEzTG72p7JD2UfO1mPKx8/XAW3daQ9JhWH6yVbmVcV98nOGPvvlYbWVT2sblhhDA8g8uMTIbd+ZnXM2g/Ay9laTcVjJfoH+43W714bO9kXwnN+5VWMZoW8jg2x+NJw/vn+gz9sCkPWarRDILbTXkkUigYJBug8QRViox39E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727807244; c=relaxed/simple;
	bh=Va+gOZEWihc4qRpd4zqozdAtb5vkW+wpcQbJGyaueGY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZmBhTuMXDfXqJjNVy295cqnnO/Gy3rTkPbVrNXEQEhoBcKwP6T0ND1CYGjY9JzRdVQPESMC8mUYLuQD0XIDpNSKtKICYEoBD9gFhd6fIaOEyOeNl5exF6SyWgAMISpXyBjN00P6p5Ck9O1bqJzRNEUWGGikTMveFUSOcE8qdI0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=LoyByCrP; arc=fail smtp.client-ip=40.107.121.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iYVnEzYovHRhGQd8sn7aGuuwSCykiRFk7Bw4d+jCPY4jKJPqCNwi4pE97I25M3ppuTc8lekJEA9uUyYv0pTki7IkOFw9oqdQIyMC0jA0UNlF45NkDXHxJ+71pZiq9dQ435UTX2m82f2fUEEr0nAfHExcYMjNEOnRFyAiY5edqOnQWoH0BlNHjLFhErNmDy+fshj7NzfNye5VJtS6G6zAq4loAWCmi63ifuqZq9LXmDp/otwG+InFyijfPaHUySVc5f0NcNWGAKaFB5CPQvGaqpJF9t9E1mqWEiwCJQ9p6UaJKtPyNR0i62EAW2mxOFXLfsCOXR/luO5QGMSuq/GqHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X42wn7r+Q4ycOpMcYO4Twff6wTkrkx8sRa5va3v8kDk=;
 b=O1Ot1gu+ucPgTCqol7OWYgjHGBNsLaN/nAxqLi7ip8CWN4ZZreRNrO6B/hLKuhMQS9XpIwnP000hPbZ8SoIs17bbcfxY4r6rrOXBYgFenbSuGaDGk1RYt2dRSNTOXpS+1jUUOHlPgNxzn0+JpkRO/Q3bWZNHbx9dbTsio86m0dl4CWTQZwMLRm523T4cRwGsFK9xqreCLqhyfnihbMNv/3M4HL5RDbvGFygzERVzWiUUXXCiKwfh1BybupaN+rc1k8GbqJOYTqc2pLg43Lg7o7hPqVrQ7JAcjoxweE9lMDVwDVSgbiSVdOXuedTC2NjMYc0wyHNEPWrk/uZ2eRFVLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X42wn7r+Q4ycOpMcYO4Twff6wTkrkx8sRa5va3v8kDk=;
 b=LoyByCrPLM24vkQsa4lXHr8pRtYg33edn2ypqIpjn8J+UvibzzxHKOUvKcBO3J6hniycCbPYUYEzc+AKEPt1cr7puDa5vbI2tjFEWag7MnImlkOgDlNji0Col4boutJKaLYR/qWcn2Q8LULefR4F0K/GwOgQ0R32z2Oi1ZmGOxU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO9P265MB7730.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3a2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 18:27:20 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 18:27:20 +0000
Date: Tue, 1 Oct 2024 19:27:18 +0100
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
Subject: Re: [PATCH v8 09/29] rust: alloc: implement `KVmalloc` allocator
Message-ID: <20241001192718.38a4c150.gary@garyguo.net>
In-Reply-To: <20241001150008.183102-10-dakr@kernel.org>
References: <20241001150008.183102-1-dakr@kernel.org>
	<20241001150008.183102-10-dakr@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0621.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::21) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO9P265MB7730:EE_
X-MS-Office365-Filtering-Correlation-Id: e2f8d571-3235-4d5a-0c60-08dce246afa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TSzQ6xcryqcA7GvlP4VA/O9U6x0pSgzcvjkhr0Wz8KP/jyzfTZE0nAEGnW1F?=
 =?us-ascii?Q?CawseGgijSJWc3R/bU1Qqn6wsIXRDGab79q3E9RbSqg77bmz6xHxqzWqoB3s?=
 =?us-ascii?Q?DmU6saCOts8YhTy2qlgtWUgGzATQmnWPX6FeTB30805pOdPL1k1Qg4HzvWnu?=
 =?us-ascii?Q?9qIz/oWHQWKmsgp38qQiRTtY2ybpfhrmz3GmiEGpb+hIae3Pt3n8YGHYmR6U?=
 =?us-ascii?Q?/LgdSKdFfi7RoLqQfrz0pl94Rg3Bc5dHKngQAUNlQd5jKYgGLvYNrEj2g28N?=
 =?us-ascii?Q?TdaXsbuzmLzt1i5mpumwQKatxcOApU7B73WJhI8WuMIUA1HaDUCIY8uB25Vi?=
 =?us-ascii?Q?nGDvYfmtepPZ9MU5ncMBFlt+hCKDOtbyg0e1M8Hkm2Zfji+9yCFIYRyyu0du?=
 =?us-ascii?Q?JmX491CupX4eHD8VF8Vcx/Yjegs+vM9q6we88VNTiPBHMRhB/aPNGEJ2vB7w?=
 =?us-ascii?Q?cGh2DH0eh2JlJoUYrmA81ka4MLFuKoH6q830jPjfyZGjpMgB5aEbUvPlUNBa?=
 =?us-ascii?Q?pLNCvsmEtfrdJQy9m/4vUOpe87AOmfTTGuz4m7BIv4RawQEArJp58CCpS+zg?=
 =?us-ascii?Q?4QpZQzlKhxO+F49oY/b5VCc63M34elJA7GBucI7HRcxlpfZuqJq1/8zXwGHg?=
 =?us-ascii?Q?g5r9KwK0f10lJxAUU3zFjdVnKg1g5S1SaiW/zEgI9eIFNb383USQSbbnlUvC?=
 =?us-ascii?Q?k2jtZ9pq21BbMfoRzexE9EO+2T3poo8saGUIhs+upu1Gemtm/G8K0Rm0lpLB?=
 =?us-ascii?Q?9PR1eej95q10nEquWGks2HyqQAuWtuMlsHLJGKXvsKlh0h9Z730hA2qEME5S?=
 =?us-ascii?Q?zGbJaEnKILa1AMQgp1S58OyvN1FKan9BBTAcg9u7qaWxWbjylXt+QBfHKrbT?=
 =?us-ascii?Q?kNQHOT9E6waHMJYFuQ4lcOJioVOVp+ZpQBRxEUo09UHXILGD+B/4zpqCxGQD?=
 =?us-ascii?Q?Y4NL6+SwKhz9H4gQd9z6cnrowHDvlzPNmvI+X5RJFkaBK/ZiuxSqhtjEh/ZQ?=
 =?us-ascii?Q?U5W9H0CEp0Vtfm9rAXvdZ4wsPK8n+bBYOBqAlk9hO6L4ODZR07QJnJ4P9XMl?=
 =?us-ascii?Q?zd2C3MxtmU8BDgwr+gddINym+Ww79MM2BFsV0PWhfJ5mFR/kSAoN7LbhdraP?=
 =?us-ascii?Q?pK2an3u7fktoj/CTshqr08ynqefhKXW0cNJFJIx1CgFwpngLtJpf9Ui22Q+7?=
 =?us-ascii?Q?RYbWqURUp8O+HmjKwhpEBSma8BH0kjFPfjQxVDcjiiuf8ZOtHG5rrXpalLjS?=
 =?us-ascii?Q?dJ6E5Vlm3M0fAZdbliELbKFDLeyVmamkWobhjFV5mQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lM6CJke+Ko8jAgplkajqvPNOWQJ3IT2QLkoNcIj0WiXlEWQwd6+tLd6ZgmOA?=
 =?us-ascii?Q?QOFfPhRF89SKxceCH+CX5Bh+O/P9HLC5HMweoZux93XvNKb7gfcbJe5Qp+eE?=
 =?us-ascii?Q?5qjeWfFhSRSCV6j7aCwAdwJYCqAup1FVGR8P4yKfouVwqWAk42OiXfw2PgIf?=
 =?us-ascii?Q?89ab5VVi3BZNSOuXMfesBRq73sg3SeGeDjwtoshDM5J5wbQY3zmYFOWFb2NU?=
 =?us-ascii?Q?cSWGh//h0isYxGXyEYb4ug9DazQYVZIk01rxt/5Ff90xvl4C9n20wuybU76S?=
 =?us-ascii?Q?4+DXtekRnGocOakMvjaxkq8wRC4gaY2kt8dFO5nHfKk5B5ISrk1rt6tuzpTn?=
 =?us-ascii?Q?JxmA9XDnToV01Nb5TzDWlmy17j0L7GAY5uCmtJHbnN9ZgObjyWgpALsmiy+D?=
 =?us-ascii?Q?AGB8fp/nOWEhV7NFkiD6AG4iAJQ20hcYAVSeJ9tBmri18GUhUgU90UZO/HFl?=
 =?us-ascii?Q?AUolP5vNv6tVvDZeEP5NIUshLwZeXyL6qzNUUwjxr4JBuUT8sjgM/TB4ws20?=
 =?us-ascii?Q?gZOzN/uvK7rcGd0NtFLNWtebc12SiKp1XtZ+TqVJx4iKSY6ew147ECiNwG9P?=
 =?us-ascii?Q?XnDkYF/gl4lgT0cT6pZ/3fC6iIqo9ROqMCPszS9K5HuNvQE5GYonUsT5ntBw?=
 =?us-ascii?Q?TpN45qb0ZYVOtxSzy5SEkgeKCYiLsMtzncGJ5baYmfKEZECXZ97Isd3k4lhu?=
 =?us-ascii?Q?cL/jUpKW8Kg+SafOjeuTFBud2gjmo6FYUPQRW81t5EUSp0Kr5Agyw1tntH6C?=
 =?us-ascii?Q?EomyKz2mP2i9Oqi0ol0xEZUDIALsYvxvAl9pqm4xUBKvx0RjRlwFz0FPP/rn?=
 =?us-ascii?Q?RdDkcTgEYBM4hw4qmswQPNirY7a1L9LYZ7DphQHOScop7DjAe5z3YF8Y4pZr?=
 =?us-ascii?Q?r/UaxZ/pHK4Yz2tDn6RE2WAPGb3nnAeBja0g83WVB9AhN+7Zc2V9Q/YffOa1?=
 =?us-ascii?Q?YxVD+eTie/nUjiMinucR9Q73HMDfTzcbKWKiV1SIpiqfOgD4PDYH1ekUTe0D?=
 =?us-ascii?Q?YxLbtjGrgnPZA1aklzjFSACul7A0vHjtwTDNv7isg+5o3S0st2TYMsMFFgLk?=
 =?us-ascii?Q?0tnKpRKtKnSH4ddwcgGd1IEM62pvUc/GZLCCjchHFRoIenwd7/t4GG1/uYg4?=
 =?us-ascii?Q?ZvohuieckprF0EFG3S26UjDfCxnXVfHfYYMCbllaaPzQBcc8t/5IRgtxcYQV?=
 =?us-ascii?Q?H6VU757ZE/YUXFxOJrq3+PhDRbhteELCVg3wPgGf0cmmfnPOUnJI3wx8CBOg?=
 =?us-ascii?Q?H2KLXF2fZEgQg1utptz6yVjXcaaDtWQ14r7gUsirKO2CdXGwpQkf15Y1aZqO?=
 =?us-ascii?Q?xqNJBGiG4sPJu846N7cBOOlpIKHY9mCc7NKkHWXuR/MY8f7qWKsC7/OR7Huv?=
 =?us-ascii?Q?R15lLjrMkax8n5eY44SM7qjcJoXC0bdQh0sFPaI3X1URY0tQi0IOKT85TFwJ?=
 =?us-ascii?Q?tSUwZl+8ChpQR2ZqfITJ9QV/MpWOAbbFPT7EC8N89qE/MHFWK4EhhLrtBga6?=
 =?us-ascii?Q?UDGb+RS7IYeDsH2630zMc0nPkmxLmBGsauQ/qzwwGapdC7KpzU5z75LCv9WV?=
 =?us-ascii?Q?I0+CmI6Lebe+x9HOet3KWI3XnHFcLSL+FvI1788n?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f8d571-3235-4d5a-0c60-08dce246afa7
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 18:27:20.3397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CJb0ZFBfdHyPi2NXH8rX4G5Eu92x7Gsp5VIrK6msP2ePdJ1R6/t6whbVMUcz1OuA+9YJn+JMEtKgaAwKzgXUBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P265MB7730

On Tue,  1 Oct 2024 16:59:44 +0200
Danilo Krummrich <dakr@kernel.org> wrote:

> Implement `Allocator` for `KVmalloc`, an `Allocator` that tries to
> allocate memory wth `kmalloc` first and, on failure, falls back to
> `vmalloc`.
> 
> All memory allocations made with `KVmalloc` end up in
> `kvrealloc_noprof()`; all frees in `kvfree()`.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/helpers/slab.c                 |  6 +++++
>  rust/kernel/alloc/allocator.rs      | 36 +++++++++++++++++++++++++++++
>  rust/kernel/alloc/allocator_test.rs |  1 +
>  3 files changed, 43 insertions(+)
> 
> diff --git a/rust/helpers/slab.c b/rust/helpers/slab.c
> index f043e087f9d6..a842bfbddcba 100644
> --- a/rust/helpers/slab.c
> +++ b/rust/helpers/slab.c
> @@ -7,3 +7,9 @@ rust_helper_krealloc(const void *objp, size_t new_size, gfp_t flags)
>  {
>  	return krealloc(objp, new_size, flags);
>  }
> +
> +void * __must_check __realloc_size(2)
> +rust_helper_kvrealloc(const void *p, size_t size, gfp_t flags)
> +{
> +	return kvrealloc(p, size, flags);
> +}
> diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
> index f341e9ed5b7c..d0a8819c6741 100644
> --- a/rust/kernel/alloc/allocator.rs
> +++ b/rust/kernel/alloc/allocator.rs
> @@ -34,6 +34,15 @@
>  /// For more details see [self].
>  pub struct Vmalloc;
>  
> +/// The kvmalloc kernel allocator.
> +///
> +/// `KVmalloc` attempts to allocate memory with `Kmalloc` first, but falls back to `Vmalloc` upon
> +/// failure. This allocator is typically used when the size for the requested allocation is not
> +/// known and may exceed the capabilities of `Kmalloc`.
> +///
> +/// For more details see [self].
> +pub struct KVmalloc;
> +
>  /// Returns a proper size to alloc a new object aligned to `new_layout`'s alignment.
>  fn aligned_size(new_layout: Layout) -> usize {
>      // Customized layouts from `Layout::from_size_align()` can have size < align, so pad first.
> @@ -76,6 +85,9 @@ impl ReallocFunc {
>      // INVARIANT: `vrealloc` satisfies the type invariants.
>      const VREALLOC: Self = Self(bindings::vrealloc);
>  
> +    // INVARIANT: `kvrealloc` satisfies the type invariants.
> +    const KVREALLOC: Self = Self(bindings::kvrealloc);
> +
>      /// # Safety
>      ///
>      /// This method has the same safety requirements as [`Allocator::realloc`].
> @@ -203,6 +215,30 @@ unsafe fn realloc(
>      }
>  }
>  
> +// SAFETY: `realloc` delegates to `ReallocFunc::call`, which guarantees that
> +// - memory remains valid until it is explicitly freed,
> +// - passing a pointer to a valid memory allocation is OK,
> +// - `realloc` satisfies the guarantees, since `ReallocFunc::call` has the same.
> +unsafe impl Allocator for KVmalloc {
> +    #[inline]
> +    unsafe fn realloc(
> +        ptr: Option<NonNull<u8>>,
> +        layout: Layout,
> +        old_layout: Layout,
> +        flags: Flags,
> +    ) -> Result<NonNull<[u8]>, AllocError> {
> +        // TODO: Support alignments larger than PAGE_SIZE.
> +        if layout.align() > bindings::PAGE_SIZE {
> +            pr_warn!("KVmalloc does not support alignments larger than PAGE_SIZE yet.\n");
> +            return Err(AllocError);
> +        }
> +
> +        // SAFETY: If not `None`, `ptr` is guaranteed to point to valid memory, which was previously
> +        // allocated with this `Allocator`.
> +        unsafe { ReallocFunc::KVREALLOC.call(ptr, layout, old_layout, flags) }
> +    }
> +}
> +
>  #[global_allocator]
>  static ALLOCATOR: Kmalloc = Kmalloc;
>  
> diff --git a/rust/kernel/alloc/allocator_test.rs b/rust/kernel/alloc/allocator_test.rs
> index e7bf2982f68f..1b2642c547ec 100644
> --- a/rust/kernel/alloc/allocator_test.rs
> +++ b/rust/kernel/alloc/allocator_test.rs
> @@ -8,6 +8,7 @@
>  
>  pub struct Kmalloc;
>  pub type Vmalloc = Kmalloc;
> +pub type KVmalloc = Kmalloc;
>  
>  unsafe impl Allocator for Kmalloc {
>      unsafe fn realloc(


