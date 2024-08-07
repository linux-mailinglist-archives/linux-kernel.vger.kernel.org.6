Return-Path: <linux-kernel+bounces-278388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD41D94AF98
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 20:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E08F71C21466
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C59214036D;
	Wed,  7 Aug 2024 18:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="hyXZ56SF"
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021079.outbound.protection.outlook.com [52.101.95.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3704813BC12;
	Wed,  7 Aug 2024 18:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723054970; cv=fail; b=E/5Cezd0Ox2hR5GGDlhPOqJADCKQ9pcvB/47+RJOyMrItK5OovXkBF2EPUtV9s/TakZ06znpa98iBcIWvzRb1bt/ZTy6KX6kvBqQk9dTH/ctH7bLbybFl+5X8jXVUH+gF12a7OHR9MNbYkFCiM7sIUF0YcnjqShG1X4fjHlz+TQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723054970; c=relaxed/simple;
	bh=SV3QO7ay0H4tErj6z+PeORfwgBti+u/HSvyZrlEJehc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aKxFIWVN1d0Fwb21UwvNeN5q92wgAkcmV2CGHFOkcgPx9R4tUrgizeyOEqCpbe7qJYcGDhkCSTXtmMpEE6hfvsK4vE8NHiJT0PYDZyg3eve4ILDyhjwRSX6/qE+0moQ6S1tbHLOVUh4iffvdPpAROepaNGJMuLRT2Z+BImkOA3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=hyXZ56SF; arc=fail smtp.client-ip=52.101.95.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YRhh88uU/jMbY03LB+WnjkgNkSOl70fi02TDh/rqXdlnZBYrKeKR798M5LT1/7OgslJHk31JA5bQG4IK5uILw4cbGJ1NPlLyGX6RwKCR4KhHI7G2ykPML89r9868+UcP8+eB+3KK8zKLeolVXyqp8crGNCf5reeNYn5TUHFiJWD8nUkxLlFE6p2eVioqA2eAviBsHahyZMRFFxZQQnuMyfB5AJuAJYoCLSenTd+wFcetDRjK5UGcH0hJUuPBCOhwCfIdin/+iLtJfeUXq0cjvXQfrrm7rtAD8+wpUjFxOFcKeD+XOAbjC5sYnOpQv4TKBILgASDnCWaVdb0mWBr1eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEdYYU75HILK2PyvU3eUi97nKbhxgb4BgrorhT4Obfo=;
 b=h+qDdWc+qNttRhoGRLO2dNY+U3lwzy1atvYsDSdHOcs4dT/WXSQ1NEq4eEPyrpd5Six340DlZmiw0oSvAOBmKG5/i9uQ5tQSlm+jaf42lMX3PIp2rdV3P+wPYYvamHbcGMIPh0yCLyD5PavMp/eP218we+uLFTPvAv9d7M5X5PR856R58heaAXhbhk8BeDEO0qOjHlI1SzWr74FYI0M04fhVk+7pNr2XOrCjoAJMHVH5wIlVlihRtsYVTPg2yzTq3tuQgXxmktz4s5fzGHFC0aG3hVD5KPRn7GOBtHlYjpsNM+zKy3kXrOo/s+BbOiHQnbHBJvLwsrpwHFwv6sly4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEdYYU75HILK2PyvU3eUi97nKbhxgb4BgrorhT4Obfo=;
 b=hyXZ56SFfDkCbQAUfNZuvuwHoVfVBborqe7xZI7w3sBSCACcmxQI3ISp9OAxDMGowLt4RaHl2Grs8I709hMJGXhtH22bCmZZHG5Mm8IaSZ6xcg7pAwvsitieKWghwEiGYxeSIxWKNJRjfZhbUECKIIV2RVP9IHbRg48nFlYPdA4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO4P265MB6808.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:348::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Wed, 7 Aug
 2024 18:22:45 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%7]) with mapi id 15.20.7849.008; Wed, 7 Aug 2024
 18:22:45 +0000
Date: Wed, 7 Aug 2024 19:22:43 +0100
From: Gary Guo <gary@garyguo.net>
To: Danilo Krummrich <dakr@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
 boqun.feng@gmail.com, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org,
 daniel.almeida@collabora.com, faith.ekstrand@collabora.com,
 boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com,
 zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com,
 airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v4 03/28] rust: alloc: rename `KernelAllocator` to
 `Kmalloc`
Message-ID: <20240807192243.19edf506.gary@garyguo.net>
In-Reply-To: <20240805152004.5039-4-dakr@kernel.org>
References: <20240805152004.5039-1-dakr@kernel.org>
	<20240805152004.5039-4-dakr@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0005.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::10) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO4P265MB6808:EE_
X-MS-Office365-Filtering-Correlation-Id: 37f5df21-fcfb-4288-7714-08dcb70deef3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YUKuTWiMVykc/9hUoP8nCfsegEpwkrCAiQ1MZ6BMKzTHPNUwqZNy4LD4VMrK?=
 =?us-ascii?Q?YvamagiEJGWrARzCuX3oY4gOtcVPGGyD1o0a3Yn4ED80KrfZi4/9+IauoJvt?=
 =?us-ascii?Q?FlXR8kXCjawItSdara7fvg9yjEdIPpjkZhkK1pJPsF+cJDhxnB4htJ7IUnYB?=
 =?us-ascii?Q?KlSvJN6J2i7lB+zAVkhY9JYG6JHvZnmYX4fNpPRprPmdF2zJFcSSTuTzCbsz?=
 =?us-ascii?Q?oXf7ewppvqVIBcFEJhKAuf1wIEQ9v/i4QMmrY+YQlaB5eyo91ib1P3y+Nso8?=
 =?us-ascii?Q?iVlktsr5ORzjM8NSgOAT6v+IikpRWIRKcnWTdaauIKpGt8AEZgKCec0h1aBB?=
 =?us-ascii?Q?vPArvxLoRr0EjU2O+nKgb984HazIRWmuMvMGX7Bbk3HQcPabU4sfybBe7gNC?=
 =?us-ascii?Q?Nov1jrZjSkGEO1TxvSEKd7rcoHQUwVqy1Ir5em4qnGEIshOhao05arHnpEH0?=
 =?us-ascii?Q?hKMpLaEvzM4+2Im8mefOlqQfGIZTRUYLnt+MiXZoopV/X6m0UDMCz0X0Dltw?=
 =?us-ascii?Q?ApS/6KzTPp/M4NW9awcSzJlqxSdSpTSzjVNaRAzchdztx+8ZG+FFj9SJ4fqF?=
 =?us-ascii?Q?mLMlPxXIRRrwSIBdh1ikowYBeDZTr1KQ0e7uaBqFL8xIcufJ27aPzN0TKf4y?=
 =?us-ascii?Q?LCbm04w4zjY29/XpvGZe7aMxmD33fLM3zagQxgg54De7KCf4qBaFQPBgaUGf?=
 =?us-ascii?Q?J/uzJvsYNKeHZqb3DokzrrDaNFGyJkHFiaEFHv2Lj0ftl/2ZElABdH0m2+fn?=
 =?us-ascii?Q?p/KOuYIEAl51q30PemTMZpU03rOf1Bg8NFJFCpSo17aMXTFiB+q1FEx+ngi1?=
 =?us-ascii?Q?yFz+iNpR8ykboh4hO+LJ0wAOtXNnuEzBzAp/sgnjoByYnWAUnWU4vMKRF5XE?=
 =?us-ascii?Q?kPK6lvhUkQGNyWQIfRGC4UW+7yYjzS+CTMuzqkM+NXJr5vwri4Bj36ENwURR?=
 =?us-ascii?Q?OrOO2R4rd6ojSuVEIFaI6rmPzvcsE/dLuKXQPc9tdpXNMb9WxTCc4nZpjm4a?=
 =?us-ascii?Q?4Ex0TXRlmWBZ1PMBGZB9H3TIIBG39cTX2dODXgWzEnRxKscTNvylj5Cyfnaw?=
 =?us-ascii?Q?2wlTOgWWI6g0jRINqdR+to+xzGFy0SRF1Gu3Ezte4R4BL/WrRzjrpE0CO7aO?=
 =?us-ascii?Q?MSNm1hgfzkB1oTM0KcMQfxTNs2oRyV8BqK5KDJ9s2VgLTLlJ+aWkPjJ3BgVN?=
 =?us-ascii?Q?Wr81zAI1OPpne9UXHmlJtwjgiNmzlzs7RtObhG086+lqGADo9km4jSs89YUl?=
 =?us-ascii?Q?LubokGLY+gF6i7bpW1FhB82URTbQxpa+S4clioaO3ZvC8n5KKQyZM1Au0qN8?=
 =?us-ascii?Q?SYM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+zfgyrfFK7jyYMIbk73D4ee4sAxrS0v3MFfbdSfWXSSiC2/+uTT2HHbVnN/H?=
 =?us-ascii?Q?ZyJt2HNIuP+F2E9FNaj0sl9KTFrgVQKFXkJr/0KDpadEWhAOcEh1VHMj4RTF?=
 =?us-ascii?Q?13EnGieQ6Pb2NzOymzMvP28gNYMOS6/HfthgV/BQQbCCMf2Zs2R+EHfqI/Zn?=
 =?us-ascii?Q?tp7r28tPxnxiu81TvtXhaZySWR3qrXiEod1aZ+NIcEEEOKkVNYaYAKJ1qGG3?=
 =?us-ascii?Q?8liQIFQPJGF81LdXh9IpoPwmnYFzmVhNlDBMAMUyACJAJPjWdq6DZAOiI7MZ?=
 =?us-ascii?Q?ok2BGhunvgusBso2cP2YfJJVCUrEITqFIwfbM4g1QxWOh1gbql6jIzLFO9Bn?=
 =?us-ascii?Q?OpZ3b6RBAdIiNV3vPMAK3TWqDSvtzhbMu5pfmG+6bHQy9eahYagubp94KDQA?=
 =?us-ascii?Q?qBhz2gcUfXLvv3cUGy1EIW9ZNIti2Z44jRJTVwYgLAbEl6eSj/rR/Rjfjoz6?=
 =?us-ascii?Q?zKnO3QsSMilGgMEvRkc7R5G66od506XQMcvrBrMDd4OFbQXoRN3vM1xIHeEg?=
 =?us-ascii?Q?2t4ibNAqwgcdMVQjdRsjsNQ+QUxYHS5VOqthAiXb2URwJN18v4dQFhFV1vji?=
 =?us-ascii?Q?WLFNBmdZU1Q4XmfCKJm/89B7tyEQjza81PrjHewBhTWooCi53wzZZ5MiLg0P?=
 =?us-ascii?Q?MCYKJUScRQAUaRC0NDrDu0+k2dgW94sN3ctgw26LWdRiYcbrO2vZHMDC4cnJ?=
 =?us-ascii?Q?H/6iazaHCUVrjkm9fnsSmLKnaFD3CqLxSZu3d2hwAp7zNp2c3Rf3WPAx5feP?=
 =?us-ascii?Q?bCwb7GADhus6KDi0LSwK6GG6qWnzuSsXEBXAO1+HVd2xCWd43WU7Er+eLBOr?=
 =?us-ascii?Q?NNSxmwNpvrStFThcyZ7Q5zYQLgC/KLXB6X3H62++OltjDHm9fk2Db8TmYduy?=
 =?us-ascii?Q?p874NRaIAzzPIlveQ9nyThFI4ojsnLvL/q1um7UQuN6qJFgqag3KgwEuK2bK?=
 =?us-ascii?Q?4GJJvgnnObC5CIcDUEjWL4U8b18WDFdRomZVw9oFv+1VSAKkVyuRAyuhOxLr?=
 =?us-ascii?Q?p1tOVVYjRCWM+8jskRfJoFLNozmYlitO45fjIQDoOE/QOItoDtjNfu49O3rw?=
 =?us-ascii?Q?hOUqSPil4EVV/D3+ucbpaESuogwFnarAmJiEOpZb8bVJXQsp0iuM6l2nAevk?=
 =?us-ascii?Q?2QcqmAJj4Ouz7oPL3mSThWcX7awJyTtZvDVs6trUU0hR+HpVF5F/TmUcEhWA?=
 =?us-ascii?Q?LvMaBQIQ9zGgZmI7rfLGl7G1UEGB7PmjV2o2UPIUokiGTswnQqJqQ/7Og6/T?=
 =?us-ascii?Q?qLKnbeOXf0vd7FV1iMXZ9cjlRGR+d5bRNbdsguSaX2urmbtgZRVF5hSvs0zP?=
 =?us-ascii?Q?QYM7U7PhM1OxNPWDgSNvSsdFvzeFHvfRkoe/Jzqotc6GcmObuwVzyG9hfw5q?=
 =?us-ascii?Q?OFOtcUsR5ZoH28E75/3wm+++0aUo8nuCv8hvtFGvHVBRxraUkMqC4/A8YWPg?=
 =?us-ascii?Q?XlFuuwg0sPLtIlDaLQfrXhy3FZQ3K96tOkaX19HwKci4YWXqnk3IrrjgUjSV?=
 =?us-ascii?Q?Mbe50TzdbdviuRbIkLEtLwYg/WBOL/6BAWsoQ5kJZjTeE9gczuq4muJJEqeB?=
 =?us-ascii?Q?+3yOYcWQrb0+xBAQ+UbJ74bPMzHoc6RkgQAWO5j/y+h80QyGNzvmkkm3AoFO?=
 =?us-ascii?Q?Sw=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f5df21-fcfb-4288-7714-08dcb70deef3
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 18:22:45.2369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SW/fQcFkv7WiBS9q8p0XjBNk1qFzpt6OTkYebnyDWuumTpq7gwtG/E8b2bi9Co3znEmotYd6JnNX5ut5ZfT28Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6808

On Mon,  5 Aug 2024 17:19:22 +0200
Danilo Krummrich <dakr@kernel.org> wrote:

> Subsequent patches implement `Vmalloc` and `KVmalloc` allocators, hence
> align `KernelAllocator` to this naming scheme.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/alloc/allocator.rs | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
> index e7b7eba84acb..2c1eae25da84 100644
> --- a/rust/kernel/alloc/allocator.rs
> +++ b/rust/kernel/alloc/allocator.rs
> @@ -6,7 +6,7 @@
>  use core::alloc::{GlobalAlloc, Layout};
>  use core::ptr;
>  
> -struct KernelAllocator;
> +struct Kmalloc;
>  
>  /// Returns a proper size to alloc a new object aligned to `new_layout`'s alignment.
>  fn aligned_size(new_layout: Layout) -> usize {
> @@ -40,7 +40,7 @@ pub(crate) unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: F
>      }
>  }
>  
> -unsafe impl GlobalAlloc for KernelAllocator {
> +unsafe impl GlobalAlloc for Kmalloc {
>      unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
>          // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero size by the function safety
>          // requirement.
> @@ -76,7 +76,7 @@ unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
>  }
>  
>  #[global_allocator]
> -static ALLOCATOR: KernelAllocator = KernelAllocator;
> +static ALLOCATOR: Kmalloc = Kmalloc;
>  
>  // See <https://github.com/rust-lang/rust/pull/86844>.
>  #[no_mangle]


