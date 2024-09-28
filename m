Return-Path: <linux-kernel+bounces-342647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3603989127
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 21:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CC20285A9E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 19:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045671586D3;
	Sat, 28 Sep 2024 19:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="ZeQk14iS"
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021099.outbound.protection.outlook.com [52.101.100.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E661DFF0;
	Sat, 28 Sep 2024 19:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727552644; cv=fail; b=kFucvg/0aFeXLqMoqHxppVkqdlam0EFp4WRnVuGJAmFfVtqE0LgOGiJDguktDst8UYSSqsjxICA5CMOgHXnRI/w2MaO65EJ2v6RQhYjFpG8100T5UKKpUlJqZv8vV9xGqQQKQDrX1WaCjWfPDYC6qFIK/onVDPSSQfqlxoB8MQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727552644; c=relaxed/simple;
	bh=dEWxdvl6L1JySZz98mWJTjjKsxYtvCoUFmmqwEtE93M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nKBaVqkmGq4FC3R9AHFxYUoIShUErficNWXxidOla+KInIsbRlWrTWNKAzL8E15Lg3mQQWtFDeWnsV/O8WCPsVrhczVI1TXs4CwpU3gTTT39ZNPLmbMqYVg+RpcNhj8slcjquIeRazM5ZKVXwLPzaabX9JP21l2wMhJO1OGALJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ZeQk14iS; arc=fail smtp.client-ip=52.101.100.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQnnqFt7s8+L3YNqAefyLI5qzf9yFX9Cr2b3VoIwhcXYKvrG5QLo03HdFZ/ncGvZD59qNjSP+PmeiSQV8SbVP07L8GoJeoJfxEt9obzG7Fkx4ukZuoNcbvsl1enFETFdw6n07ddzkFbfRi+jtI/JabNnbIlIn42jhMcPNwkwuZD+00kFBwDudnm0vFW42Fw822pr6XRE8sfaqqWkfQWdKig4yRaQRiT9pC3XSEDuDDsFsbGE4FY/tT6Q1aLvCz0psbe6MRNGQiZ7qhFZrXxKLFCwhdJn24sDS+k2ArLVMkW8EftFjq37Z7DaWWTnEL9Ge7iokGDt56dpB6YrkcRfyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ql62ECD7LH3sK7oghhnOY1pJ6+bl08rbkXuRbt//+Xg=;
 b=FIefgM2uhWDnXyt1gAYFi+70fRMOmEqoYwF6TazMcDPfkuMyr/gzly9ZuHjMr3fgoou7msNl/RZ4R2wkv3XeXASCgMaZdOFDAvQcqgyJiV+iiqkFRN6QTG2CWTAd6kJ6Ei1S9ZorIAkN+QyQhCXIIG4Wx6lOmQkTOh2snWwOyHKoXxwWyT7Z07brJ3j16RkUskq+1TcSc+59tzwKpzK1+mLii46norOv6yIgrDYPM56Gpmz+J9uEslanQlQvI3VXnhJ+b9oaMyev3gYhqUeTGKpocA+55+gjGJI8VJUxdfRqoVP94xzM4E0XKud408GXDAERNL6gLTB52ipju7Fjhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ql62ECD7LH3sK7oghhnOY1pJ6+bl08rbkXuRbt//+Xg=;
 b=ZeQk14iSKVsVQ+JnnTAWZ5/hLVS5UKyBzViMObhw4QRfrKPSFLqEB+hf6lShi+GNBkZpF7REHbfq5AVKtTQC50eIfiOxvpuV9KyxwBZYPj6C4gdPqOsDGcOrgdfWFxIGFNC8B2/vTOugIQQPAtggBrYJ8kKtqvSVkhyRItf7uX0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWXP265MB3240.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:b2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Sat, 28 Sep
 2024 19:44:00 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8005.024; Sat, 28 Sep 2024
 19:44:00 +0000
Date: Sat, 28 Sep 2024 20:43:57 +0100
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
Subject: Re: [PATCH v7 25/26] kbuild: rust: remove the `alloc` crate and
 `GlobalAlloc`
Message-ID: <20240928204357.3a28dada.gary@garyguo.net>
In-Reply-To: <20240911225449.152928-26-dakr@kernel.org>
References: <20240911225449.152928-1-dakr@kernel.org>
	<20240911225449.152928-26-dakr@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0260.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::32) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWXP265MB3240:EE_
X-MS-Office365-Filtering-Correlation-Id: dfddfacb-c437-4e1b-f190-08dcdff5e60a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?efzgiIhYW2KW/Y8daTWDrVczPdDKCv+ciiw3VZzphpiiR+YJIdq+2Ebyjcxt?=
 =?us-ascii?Q?cFgB7XWzNj4zyiaZAVIWV4bItZX0Fgv4nLVy0FpJme9rDamf+/SrNh0MZmGV?=
 =?us-ascii?Q?x6uoKQ1B9rmnmr/S/75bZlFj3sq0D3aBUAsRBm+STDUsTXCHgt36lj1gjh3S?=
 =?us-ascii?Q?x6jxjnUsMQ/zZKsKl6CzfzRIPBiZc03gcmwptO5VpToRxEkgCebkbdDxfmzV?=
 =?us-ascii?Q?UyIyKWrt3sb1uo0KYDK6Kfq+/ArfS3F8KjT7fjyTUsw3WL4msJmAaKtEtbAj?=
 =?us-ascii?Q?NMBaErCsQKtCJN8dM9T/35k06vf/Vc4KqfF2iVPWiAWJlQ3z6rPCX4DNd7UX?=
 =?us-ascii?Q?t7yaJZxH6uyxCG/Yu/QttPeS/oFu1o17zbj8P7ICGFTS6+GbzWaodTupu3H1?=
 =?us-ascii?Q?cecovthLWAFWrV/FiHg5Lrf6UKwwOuQ/oj3Aa+V37qaYiPQ4CEaYyn0o4vb+?=
 =?us-ascii?Q?O8p8vZVdtoUk8vIrHE0lwDbAP1c52wkag+Ze6foNTVvp3lUTRMbzGCOz+BCW?=
 =?us-ascii?Q?FzWeIxRfBiqMJnXV0FkIL2DT9i3t9vbWJ5r28ZYjHS6ZW3Zrn5oV8m9qSCSW?=
 =?us-ascii?Q?HFye1Rkon7Rj6MIuWz3ioq6g3HWzxdpzV294V/wQ+TY/6HzkVt/xwybB+Ar1?=
 =?us-ascii?Q?qlGyBjYrUhraHyYhveM9GDbk8FySEYadfw26H+vzlEpavERHBZCzlU4ZIcRC?=
 =?us-ascii?Q?4QhO8tBRQ7S3Z+6WNr5ArBSOHQ11ZwKDoAn8OBDMXHI2oofhyqc0JUbrra8H?=
 =?us-ascii?Q?ymRuJtExPARz0YINLW8Gtvk35oU8Sm7ikN7d5fYwLcAqrC1cpOUBnAkHzWk1?=
 =?us-ascii?Q?XF/pYW1AeY6OtLSfiAl6tuL0/91JRoxieHa1aQhQPujUZpVIksnanHmhkwdJ?=
 =?us-ascii?Q?zK6nC+Td1YzGrGPcgWMlCUGt0OF2MHZR8H+ifWJIiHVyZG8tX6428Tipspx8?=
 =?us-ascii?Q?hIt59FMgeg+eqYS0MKU9y3HJOhwweKP3OZUGc+bvcSsKRv0PFV+bz+iVDFu3?=
 =?us-ascii?Q?ediYxER2niyKsAWjEykwqYrBhnQZBaivypjW5xWh4KQjqrz1FqeoViAZezOm?=
 =?us-ascii?Q?2paemomAewhItO0SH0Tb366CNos4z/b6tgg70YUUdWg5tu1SHJHifpBD5bqg?=
 =?us-ascii?Q?5Gl80kIlq4ESCc8n9q2wT3yDhJlIgEV6gVN9OD8L9nfJJvq42Alh0ePhvl/I?=
 =?us-ascii?Q?rh0jKqrJgQaFWWhccjR/PWaqDGClbmjjiUo6YwchRmZsQMJV/bs0wZ7hWADk?=
 =?us-ascii?Q?HvVPFMwXHIpnf4TVdqV/0ZCjs6/alMWo9/KGgSJiatuXejl4FUbafoYsje/3?=
 =?us-ascii?Q?X7MYfTABp60T55kowhCC7lYCrXlaG9YMVgSPDfLh1VVoVQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hR8IWaMTDwNZXQdrGlQmDxmCTmvD84HElSdBZSKehPkjAW7zLmcydcjMwxeg?=
 =?us-ascii?Q?OrczfvSgpQlAC66kILyieVpi/v9LQl43YjzHmz9WApj2clRzcWOWSq3ZMAb7?=
 =?us-ascii?Q?M682cHbIgqk3yqU+7GatUM9LGv0H4WY2f4aZ5N9BTZ7FT+82EI12XfFjjerE?=
 =?us-ascii?Q?jaDjMAj4mg78JXujGrYs8HVs/W9WemgMDDs1LQ9KGll6RnoKfPzh1M+TizrI?=
 =?us-ascii?Q?emO9HW7p3KcM/IJOOASM9+iuLVqQkaZfu25qGVdmm+k30D+vIjUHc52M2k9T?=
 =?us-ascii?Q?vfSDcg5W5GlGz69+Ps+RO0qVYEslILCKNZ2Cfh616rGyCtBFL1xJ+VuL9B03?=
 =?us-ascii?Q?23UQDM6U39SVmorPWvBhtvirKaKZhBWVakinN916PmcVu4hiJT4M/z68g/aT?=
 =?us-ascii?Q?juNx3ArPjeiEkSA1d0tPu4514GEa8cpVHwJJk2Vf4Ixg83qzrn5hKq8WEKMa?=
 =?us-ascii?Q?3zTgoKPUuXloiOLvFcHWeBvPy9PS3DdzD6QqD0e9DbH5gQjFGod/tgnRUobY?=
 =?us-ascii?Q?JUkW4Y564hiUr/sUSD7XG631BUegKAcNQfi6swSWYTmB4oKUWqivGVTCVdjg?=
 =?us-ascii?Q?L1nocCQqUIQfnS+I97PxeqJQetWg2WHAzoU0HJEOsfnylYQxPNekR/jiS1IE?=
 =?us-ascii?Q?9uSsRuABFZbTT/d55HiIQEqVoEBOz4SkTYrVc142vHGPc/VazmT65U2NO/KJ?=
 =?us-ascii?Q?gch0EbJDAYqR/FcwU2CVUbE0XCvSJXJJV58efm3dyaC+/kUQMsZ1wpsxWA6c?=
 =?us-ascii?Q?L6AaD4nzU4uvo16bHC7OPWe3SE0aeIg6vt6WiDlllixPi8j0fAPPsuto4+8P?=
 =?us-ascii?Q?pSQ8OzYh5CcEl6Sfe0Tl0l0tizWnHXLJ+B1jBfAS68Z0josXDHhHE9JwR9gV?=
 =?us-ascii?Q?UIG6eJLwGw9ndksh3loSHq48v2eWrwCJ+k6rhureLkUuyBmh+2e3qPLlSLVw?=
 =?us-ascii?Q?k6LpKclz9/n+dFkXQ34pM9JV9oyyA1pboukrDILAZjfMr/HdEMQsDLtzUtxU?=
 =?us-ascii?Q?FS6vP0q7Q0Di9GoZwZcjCsLg/3MUcKELiQ6zP2kwaojJYv4VHP9AOhmxNIbk?=
 =?us-ascii?Q?TTTDAaj5JB7jksWbD/k4G85LK9jjhde4Si4fC5Qzl+r83RXaJa2fbaBtm/9j?=
 =?us-ascii?Q?yrWsN7tKMlQOpB3mob6SDo17RdFc0pPjeCw417e791djuAvea6qXBic5LNoK?=
 =?us-ascii?Q?+cwW7pVfXUFjoDL6PjOByf99Juqtb5Kqh55H6jhgICn0z8SbYuKEkfFsW4a1?=
 =?us-ascii?Q?fQBag4YnqXRcwEe+boXBxtCPBHsMZ7qqdSeVx/uQ7rgOvRCOiwYgqaBgrKjV?=
 =?us-ascii?Q?wkQfDZ0dxICtNDdAgRRt1ChIOjG/3wYLzESYmuYtJ/xr2IpqPxGDNJOsKoc1?=
 =?us-ascii?Q?H0qqywXvtExzc1cmg8BB07RMaEiC2mCLquBXLWpGc9NqqvTVX0otBRhzaLaB?=
 =?us-ascii?Q?XAHdVQLRS9Kbogfuk+2/G69PnnYOENoZdVDUiSUoMb7N8XkcrSiSL7jTUNgj?=
 =?us-ascii?Q?RqHw3jwZkqKzI3FN/Wv59SBghJEwjMqn3DTgQBWiyh9x5haXR0Bmo5cRfquc?=
 =?us-ascii?Q?JLmp+OnzP7j8ZYcPaD6UbFWqtQJSDK3oqQkZW6+r?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: dfddfacb-c437-4e1b-f190-08dcdff5e60a
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2024 19:44:00.0388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fAgFWpddQ6zp0NUKoJ/xbUpP79ncrK9yYxt9QCnhqyvk+nmbGbhzhGCR+q5dXpKDo+afmcdALMQEvQQte2EpKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB3240

On Thu, 12 Sep 2024 00:53:01 +0200
Danilo Krummrich <dakr@kernel.org> wrote:

> Now that we have our own `Allocator`, `Box` and `Vec` types we can remove
> Rust's `alloc` crate and the `new_uninit` unstable feature.
> 
> Also remove `Kmalloc`'s `GlobalAlloc` implementation -- we can't remove
> this in a separate patch, since the `alloc` crate requires a
> `#[global_allocator]` to set, that implements `GlobalAlloc`.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/Makefile                     | 43 +++++----------------
>  rust/exports.c                    |  1 -
>  rust/kernel/alloc/allocator.rs    | 63 +------------------------------
>  scripts/Makefile.build            |  7 +---
>  scripts/generate_rust_analyzer.py | 11 +-----
>  5 files changed, 15 insertions(+), 110 deletions(-)
> 
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 72b1232b1f7d..529ec5972e55 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -262,18 +262,13 @@ $(obj)/%.lst: $(obj)/%.c FORCE
>  
>  # Compile Rust sources (.rs)
>  # ---------------------------------------------------------------------------
> -
> -rust_allowed_features := new_uninit
> -

Would it make sense to throw in a soon-to-be-stable (or
already-stable-but-beyond-min-rust-version) feature here to not have to
remove the build system support for unstable feature directly?

For example, I know that const_refs_to_static might be added here
soon-ish.

>  # `--out-dir` is required to avoid temporaries being created by `rustc` in the
>  # current working directory, which may be not accessible in the out-of-tree
>  # modules case.
>  rust_common_cmd = \
>  	RUST_MODFILE=$(modfile) $(RUSTC_OR_CLIPPY) $(rust_flags) \
> -	-Zallow-features=$(rust_allowed_features) \

I think this actually allow all features instead of allowing none.

>  	-Zcrate-attr=no_std \
> -	-Zcrate-attr='feature($(rust_allowed_features))' \
> -	-Zunstable-options --extern force:alloc --extern kernel \
> +	-Zunstable-options --extern kernel \
>  	--crate-type rlib -L $(objtree)/rust/ \
>  	--crate-name $(basename $(notdir $@)) \
>  	--sysroot=/dev/null \
> diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
> index d2bc63cde8c6..09e1d166d8d2 100755
> --- a/scripts/generate_rust_analyzer.py
> +++ b/scripts/generate_rust_analyzer.py
> @@ -64,13 +64,6 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
>          [],
>      )
>  
> -    append_crate(
> -        "alloc",
> -        sysroot_src / "alloc" / "src" / "lib.rs",
> -        ["core", "compiler_builtins"],
> -        cfg=crates_cfgs.get("alloc", []),
> -    )
> -
>      append_crate(
>          "macros",
>          srctree / "rust" / "macros" / "lib.rs",
> @@ -96,7 +89,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
>      append_crate(
>          "kernel",
>          srctree / "rust" / "kernel" / "lib.rs",
> -        ["core", "alloc", "macros", "build_error", "bindings"],
> +        ["core", "macros", "build_error", "bindings"],
>          cfg=cfg,
>      )
>      crates[-1]["source"] = {
> @@ -133,7 +126,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
>              append_crate(
>                  name,
>                  path,
> -                ["core", "alloc", "kernel"],
> +                ["core", "kernel"],
>                  cfg=cfg,
>              )
>  


