Return-Path: <linux-kernel+bounces-342642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7C5989122
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 21:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B2C8284326
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 19:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA17155392;
	Sat, 28 Sep 2024 19:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="iTy3Mu9U"
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2111.outbound.protection.outlook.com [40.107.121.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23F117736;
	Sat, 28 Sep 2024 19:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.121.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727551857; cv=fail; b=BGOFycCEj7dyz7dFdIIsgX5ZsNk9PJvZyJJLpwp/3Pfw1us27pjJovY3yYgKly31WMK7/9yOfM8P03zstTUU+ko22zAGW/XqX/6utZ0G0syqoeDqigizPQLfrNa7dAsoHLp9ZSihC4TRwSbmcNtzefjkmebaOte8vdfpI6U84WI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727551857; c=relaxed/simple;
	bh=VI6Q52xInN7RrVNCHMck1+z4Y8QajWe0fcb8Yu1ZyQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D26ZfDOflxM6SE7QRbhiDJCB51OrAKUTD60Az132R5MNT0Mzhh2zyN8QZJfxWko4Q8aU38wnNpCoo6WKDwDUjpL0Ks00hNXA6+fsnmb88/Fa0yXlXm11euBLMwC6rzb8cQ88wtCieCvaGOklkj1GOB8WTTbfNK3P6C/8AMB5zQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=iTy3Mu9U; arc=fail smtp.client-ip=40.107.121.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWG0dvPNlSjlGtt6pj/+pQ0Y0P1Vt8d3yVI+/AQ87uMpiOuUX1iN1Gi16tRa8bnq3tGWJKFn9Au6qH+/+MEceCw/mcOxjSH5tz/6/DClNCTNw2WExIVJfhGp18haZHHvcLH1ocdcKJdvjakQuWKHMG8peZaoIJ1BeXuOR9j5eGgbohF88q50f8V6CwY45kDyWcfcJ/90ToCtgucdizZ5RiiJdD6t4Aak1Yhf60LeYRe5ZGPJj6Lnpm1f0ttFMMX293M5vQnoMAqMhKa07J7dTN8dmH9MMbtT80mhetLMl1IpRBbTpE1dweF1BVL+oILvGyrP6GA0vIrZEb8ld25BAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKYrvH7ex/GatcTwd39wQBhmzv2nHq0wC58mRj9COsw=;
 b=JWdYGvDqERul24Ikfv8VykXATPuP4yBDgGh6eKhcMuBnSodzZ/QAgp1eIXJ3NQ4KSnesOS44CpuYH1NeQ9wWPs0qcE1gDqCBwSZdlsSZXkWK7R3mOC6v7vzu73+IknEZNDdotm8POvrv2xiyg/4hRocdAibicB8RW+Q5ULqAeQzV06GZN9nRJfa5mRlaOQoJRW4lDpqdZVqIv+DDxlm+w/tVFXcoAQ9pZVeE4CJXdmUDlS+apV5YskxkCa6qLZpK12FNpuVQPgsu+apXFJjw9e4Irpz3xtqdnyJnFolZs3DGXcwp6lT/TbueXnZkghtj7cKQwp+bT/3LDjCaDXnBZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKYrvH7ex/GatcTwd39wQBhmzv2nHq0wC58mRj9COsw=;
 b=iTy3Mu9UjrL4/L39FdNGn5JyR4qb1ZfrF8rmmTKxnmuATw488xXn198ClCNRJf2aCvLBKu9igjS9Gg/Gz1aZMN8r0OgueaqaqlmV1B7GQqKG7Qv7ZvWMDj5ORynKGwQX/ma3e3ScNbsap6WuavWjfJDr3fv5EeeucOa4hC58zIU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB6484.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1db::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Sat, 28 Sep
 2024 19:30:52 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8005.024; Sat, 28 Sep 2024
 19:30:52 +0000
Date: Sat, 28 Sep 2024 20:30:50 +0100
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
Subject: Re: [PATCH v7 20/26] rust: error: check for config `test` in
 `Error::name`
Message-ID: <20240928203050.55ffd293.gary@garyguo.net>
In-Reply-To: <20240911225449.152928-21-dakr@kernel.org>
References: <20240911225449.152928-1-dakr@kernel.org>
	<20240911225449.152928-21-dakr@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0053.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::19) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB6484:EE_
X-MS-Office365-Filtering-Correlation-Id: ba0a8234-958b-4559-a204-08dcdff4109d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p9ucjTbKo5Sr+1t+lEQ9B0vFeaUGgEXKMZUK4gFlKaC3/ROxe0f6GyLN6jm6?=
 =?us-ascii?Q?x3Dc+7/30iz57rWhgevQ3gL+fIStd5a79Fc10vtF7WKTbvwxrqn5zVuP0EYQ?=
 =?us-ascii?Q?7CeT85MCqSG8u/42xHHBxwgdtJCujl+wY0NSLOkKec7rcsclXsXGkJEfS/ex?=
 =?us-ascii?Q?IpDwBfYnjFHalZTwrnM+xkXaoEjuBe99P9ibHosriMnyOVIB2/Z17dXPPuMX?=
 =?us-ascii?Q?P7f/+kLVj74vM8v3wuDRgdiU8Djnrv7/WhMKcj5EsjCjFWBN2ZkPL7qJX0+X?=
 =?us-ascii?Q?HEQuP6ch9O7A2+NO+Ko/X+fNCjKf5/jy2k5J2epKwg0icszqPiyo8VU42Oig?=
 =?us-ascii?Q?NjUD6xWelOdEcDPrM8kKLtRi5yP7idE2J12vUKLPkzw6jOEdif9aZQ8ccwPw?=
 =?us-ascii?Q?O51Z+r1N8rBkzgsCEvY69lq+8w3Bt6mcoeHg+94pies0hWanVP+Gm0TkCP+j?=
 =?us-ascii?Q?x5u7UK5qEDS1mBfb6uHU5EIyqic9hE/wrRqEGCSYS2ShS5wotJrqlllZYyJj?=
 =?us-ascii?Q?gdipsA4tGCjzOzLkIZHcOsBC/3baxGKfhlzk6juZ5sY6aT2BaluIV1H7T20x?=
 =?us-ascii?Q?t/AdjcBFE8GPfrpUvVX6ZnbGc0RLP8ZK+9MrngB11SKDF5skwWbFjVRblDje?=
 =?us-ascii?Q?cfkirx62lvip6cUZzQIaEtvwJWdCfXSFuI8GbUMnD44L5YiJcpSZAY/i4O9q?=
 =?us-ascii?Q?/+TxlJHQBuIyZz3uDcoRO3fnbhn5WOQyxo4+tfbQGCPDclOTDSWXkf6MoENc?=
 =?us-ascii?Q?3GmTKRQ8VRjOLMahfiWuOrBz+KwE9QnuQHrCDuX0s8SstbkJ8Tmd3qEorNDB?=
 =?us-ascii?Q?zVm1iU5OYqM8YdF9n0EgdvlaiAhrOUiXRqDh1wa9lqEcUjYNaOXMh+F0HISg?=
 =?us-ascii?Q?up+sy3At3zFX+5Dm0tVnxOIjR0ST7MvVsHQJ147XrfAV59Yj5CvlNs95Tjqk?=
 =?us-ascii?Q?s8gcfOvzG+n4gXQDB8YRtPOwq4GCdtsMhyUCuTnzLyaDAEJjEaKtzJc97S/j?=
 =?us-ascii?Q?Ob6/XwG6R7GbJsiCWKQRXueyoMU5jeDQvvZBx2vnDledv5SfpE9woUbu9ohi?=
 =?us-ascii?Q?dWdpMz0t3hIv8565bNK67F3aqS0tpXOYkiqEGWs5ffFMiHJXWDVDYa1N4A15?=
 =?us-ascii?Q?fdSYkbHNvzcWN35VpFt8nbL0CLHsVdLdB+f9mSFTvaoj752lT9PTF3xiXOkm?=
 =?us-ascii?Q?/GLJ2UmbTt2mxAvFeHBup6yb+wK21aMzyZN/fqJrznSviK5KlFJ0urzbxoQ8?=
 =?us-ascii?Q?J4YYyo8vu2dbr1wuvJlYE1ZoD2uSQQuDjbY8b2eKGM7KhD/15rQXCIX0RgEV?=
 =?us-ascii?Q?/9bzBpl0tnCF5zoLjqwn6iHBICqxAueVXK2cs19ZSHbrIw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7BHdcdZl+aGuwnK9OEjmj3mTJ8Q/w5ycEdiIena6jhxlNM98ujOEkRxnmhgL?=
 =?us-ascii?Q?RKE+kf5AQPIafj0dNF3PTM5FUykZlz+UFtFxIZlWEt9nql3kVeN4rqeDEf7i?=
 =?us-ascii?Q?tmekYuWzNpmgJGydPPk5Agfa1e54ytZ+0IcJXtyDtRtTUVz9ESlnQJYohntT?=
 =?us-ascii?Q?dwCli0Q71Acyc9XDpmQ3r7v7AesVQj0J36/Gdp3Zcr/SMRcyO+r56PXH/H0L?=
 =?us-ascii?Q?dpOzBsC6vdqrSJC/vzQ2G941xTI5wmQpigyUg0LASo3ggNleJxKIhU4sJMkA?=
 =?us-ascii?Q?6AUrc7R08DPfSeWJ76oJcTlJ51VpFCq/HGJgDzo29U/+q2s3iltGcaTMl2+N?=
 =?us-ascii?Q?X+oMmNveh+Cf38jLjROMhcohtn/ermyK0r78uzq5dvMeuRH/jvQx6QqIF7bN?=
 =?us-ascii?Q?eWeazwU1iozbkm2swwWbKZS0tyY9uQLozFFfSaqHUdyLfBxm5dRUBcjx74ik?=
 =?us-ascii?Q?x+ItGw+1GBSGF40Kj+h9FUXWnYZQlSBPFqtKAdNHMM0xt/OVLf2PljhInajb?=
 =?us-ascii?Q?sUrZK+FkZp8N+6J1pREvyBsTKG10dyxd8RyMaSqeUjPS1E2g8MjJrKZC3s+k?=
 =?us-ascii?Q?aVXyn193/P2f1Z9dXYJxDmJ2fm23nsGy79ZjW3994rU/vM9BGUmRMDFby9IK?=
 =?us-ascii?Q?IyV4Fd7MM3jEubcAiwF3Xi1UOFh7Y1peDMzG+iNM8faDBYZOnZTR0wEcNBuV?=
 =?us-ascii?Q?4IMpi92pSF0u0pxefAvJFP9p0ga8Uu5IgodWSmK2NNMFf/gAEgyz9oJOmhs9?=
 =?us-ascii?Q?94oxFq2rRjA0MjEUTq968cuXrebiiCi7vz26eWqrvhISNfmXs7GPQRRBVDo3?=
 =?us-ascii?Q?bYHVll1HGHBAWiI0kSbxpAaFQbDdLS9H9fqOB5TBVcktLIs8Xp39hEN+ajnS?=
 =?us-ascii?Q?Q/A0ZxmYoXBBepOJMdwNyyWjnKHKUsWYwKrABykZLDpgqCOOMKGEHFL1mzr4?=
 =?us-ascii?Q?ZnyHVF6KjbKLMykP91ZZQcmk7a8XrUQSbftUpN7Y1yRORXpYQZe0cRf3xIIC?=
 =?us-ascii?Q?X5ivT9ay+OKfGu4OULKvUSjUfby1rs1CZRlylcSnRSc3cfMoR6qWNMz0VxT/?=
 =?us-ascii?Q?yqfrr1PZ3QKsNc8YcOkqGD1Ejacws2VQIhdbdJiYUQ6QKDKDn2XElrUwV4Hl?=
 =?us-ascii?Q?2TkYsWQ6ufck5ADJUMe5ZwBHORhq/IvJ7r2wV3GHgnhZVV223ufSoC+hhbzR?=
 =?us-ascii?Q?XMN5FLoRK3/+jWtbgXSXtDpeem6llc+6ZU+6mA72Qr4ha5zzhE+YAep+bZ9i?=
 =?us-ascii?Q?kwr2ETGcr7Umc+w5p8g0+oCe0uzw6Ih8UOTwvtC1LuATDiIrJEObOUfKkLWz?=
 =?us-ascii?Q?qKgV4SHc0XyxbSpjuT2S6jFaFAnx9XlMk6hfRHW7CKBLFFBbTkcK1XkDz/nr?=
 =?us-ascii?Q?jEvln120YbTGOBvzimptq/pIP4j/Af+vhaGq7mB1zVM89CUftSSEvUjCKcV3?=
 =?us-ascii?Q?WCqHbUTPQw4addpVnR/IGbER+FlzByf1DJJV7ghfxjV/kSr4wUEVdepyv60n?=
 =?us-ascii?Q?cWCUFJ75IQ83gA8YC04g5YK8vctNBe/e4ugTe+YNAuXU8FGwh2TV9PM5LnzY?=
 =?us-ascii?Q?YlTQrii7A6DkA4RSX/2/WzHhuIzh+bEaxa2O3ASU?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0a8234-958b-4559-a204-08dcdff4109d
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2024 19:30:52.4856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gaS2gvJvNJDgQxGMEDEIi5q8sUsNfYE16FhK+3nZRbPwS9FrV08XM3LIHCXfjA4CCZqLVVFGqCA2W3H9d7MILQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6484

On Thu, 12 Sep 2024 00:52:56 +0200
Danilo Krummrich <dakr@kernel.org> wrote:

> Additional to `testlib` also check for `test` in `Error::name`. This is
> required by a subsequent patch that (indirectly) uses `Error` in test
> cases.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/error.rs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index 81b4fc5cf21e..b71fdd0f54c2 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -143,7 +143,7 @@ pub(crate) fn to_ptr<T>(self) -> *mut T {
>      }
>  
>      /// Returns a string representing the error, if one exists.
> -    #[cfg(not(testlib))]
> +    #[cfg(not(any(test, testlib)))]
>      pub fn name(&self) -> Option<&'static CStr> {
>          // SAFETY: Just an FFI call, there are no extra safety requirements.
>          let ptr = unsafe { bindings::errname(-self.0) };
> @@ -160,7 +160,7 @@ pub fn name(&self) -> Option<&'static CStr> {
>      /// When `testlib` is configured, this always returns `None` to avoid the dependency on a
>      /// kernel function so that tests that use this (e.g., by calling [`Result::unwrap`]) can still
>      /// run in userspace.
> -    #[cfg(testlib)]
> +    #[cfg(any(test, testlib))]
>      pub fn name(&self) -> Option<&'static CStr> {
>          None
>      }


