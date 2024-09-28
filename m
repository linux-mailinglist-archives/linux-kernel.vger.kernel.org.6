Return-Path: <linux-kernel+bounces-342634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC209989116
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 21:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6277A28185C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 19:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6ACF158DC0;
	Sat, 28 Sep 2024 19:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="TTqUKcth"
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022115.outbound.protection.outlook.com [52.101.96.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F168A158D93;
	Sat, 28 Sep 2024 19:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727550906; cv=fail; b=N0uMOAdB/HWhGMdoKnNQHD71DE7azRQGYKRN56bO/WjPV4/6b7PXqpfoG397VGPfg6D3U7Xam79OrZmQp+0tK4w74uQHLw5Uk3xM4RFGUwSmdK2fFXfgn58jv1NsJg1zXELpY/zcQMuysN8f+HBynyguJ+JDiUqctK6HUuWxnN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727550906; c=relaxed/simple;
	bh=0hH1ZJd9TJc6BpaQlh38TNFT8I8is6uzZw8aKPaF520=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VTGDEkhjIyn1fln1ISmczQNCpI13Vh4iwMMPDEUCfAdeY5cAO42ruGyJ1RLexTxFTsP9c6P6hk9eK+2A6Szii1p4robj2vAyn4I7xxbSyx+rpZe33ViOlKkOudHfxG23YEcoAdBR4sPib0xoGOVLS3bqxCQIT5szc9/C2rmaS4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=TTqUKcth; arc=fail smtp.client-ip=52.101.96.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rm77YkHPH+r4DoufAKXYbeKea6+gwQZgywqAVMF3LP2IHV9+uIAml38sMnn+4YFA2IpjK2TZhcA3PwFq+w/hYCzI1EXKZsGNyrxYw82s2POmwasrm5m0XMXsY002v0x9l98S6cIfkUhQAegMT/jXHhE2FYt9UBPCfWSFm6r5ngiOQapEWuE4b8/Wx+Fvqce1Fe0XO9bXuwfRXRaiIcMcr0PZC4dbPfsD2tgAduL7mM5X99mmaspwJ5Oq4IMAFqHz68pMXWkaz9HQ6mqMbegUCicTseyoe7+0DSCYRryl73Qe6lXCv59a4jSLCegF3S3NRVQwGf5gC36VUWM1gTE4iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljXki8CAyCjLfd90WVfr9txRkaoAaFi8iV7E2UP8bwI=;
 b=OOY2+QZctO5s7Ec1jAG7Sa9i08Cfmc+dKu/H2ThALmzqKEfNy6Pu8IeviQMkY2RePkCmm/DhEvxtyE5zuJVhRJ7XcwOfpz+KaK6bVj9UtRp8/XX6XqPpD2iWEacAIqM41jhz4wAYI0yLqMhlIpzAHtWkbBqRBK9UAodgtmh/X393BucTMxyNbDaX9AIyjoivuwZ/FiPg2H35PKb+6YmvlVLyh8Czd6LeDzqFDZ3N5HoB1mQN7rQvyPxgHjA5uAYGNKSK+69fhLhiiDHDumTrHvbA7EEV5v2ISNjLLijDw3tuqrvHw/gszWaX2T96+h4vs8PNEZJJsfhecwk7GRMZ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljXki8CAyCjLfd90WVfr9txRkaoAaFi8iV7E2UP8bwI=;
 b=TTqUKcthwGOYY80fVVhfiVdPwV9YC74CNMihTvVXADCRmvA14ZADyxDY4WvsR8fWdjOkSVHUpxE5Xts2sFpfesdzbWuTfCpe/qa0gZyyirKsDpcizf5wLau61d5ad+VIHua03SeSTpaX7xrJujtZO0gJu0mn7idmEQyHywURTfM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO7P265MB7411.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:41b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Sat, 28 Sep
 2024 19:15:00 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8005.024; Sat, 28 Sep 2024
 19:15:00 +0000
Date: Sat, 28 Sep 2024 20:14:57 +0100
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
Subject: Re: [PATCH v7 13/26] rust: alloc: implement kernel `Vec` type
Message-ID: <20240928201457.0e4c6126.gary@garyguo.net>
In-Reply-To: <20240911225449.152928-14-dakr@kernel.org>
References: <20240911225449.152928-1-dakr@kernel.org>
	<20240911225449.152928-14-dakr@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0017.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::29) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO7P265MB7411:EE_
X-MS-Office365-Filtering-Correlation-Id: 08350fa0-7ad6-4157-060a-08dcdff1d86b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ng7oX99PcwqlGs7ppKOIRFfAMOFROK4kMcgx5gc5tnEoip5pvaCADYGl5711?=
 =?us-ascii?Q?n6J1tNp66dx6EsZxrWk7jbAKh+VWVkGKj8H8jkHesHzN+MxUk8Oo/oQur/nU?=
 =?us-ascii?Q?knpRfW+as3bZPNEMdVHvj2brg6HGxWGC4yZvjN05RO04xB/U5bHylLdNJtJg?=
 =?us-ascii?Q?WaMDnq9wlHPR8j67E/iFmLpJjsec+Pfo3Tp7tdcJfsbxUZl+gxGfJzliT7kq?=
 =?us-ascii?Q?ms8HAMK2S5Ww7MqZVssM2tyUA2Y2i6VsUeIG4tByQbBxzPXNnt446fkM8zxf?=
 =?us-ascii?Q?81USKV5eeHuDErmyL0V0o3fkt5thX/gLyz0pvg/zdEQmWCt7awfSNjEUrleV?=
 =?us-ascii?Q?Z/WeW6ccP3Xy8xifiEULqA9bb4MQ2y0aU6smASR5aqYSbiIpWDYlwHmcfP1H?=
 =?us-ascii?Q?Dl7XF4YoLlI0RCz2i2Ut3gIbHoNsT+TnCAQlF0dSVRK/Y5eVZsTKi+wNTHmk?=
 =?us-ascii?Q?45vtoefbK4vrvnaqMiHqku0/nfYv8P0oaowVInclZamBprDzhVZQq6agzaDP?=
 =?us-ascii?Q?D3yWwodyVlUxhRclE/kSRUrp5iap7DUwlJjXaqG7AYjR1+ycc4ZKyfFjVfIW?=
 =?us-ascii?Q?CrdmR5n3LqkpC14m28DCiRXgTHVstm5QPU/CHpVofAltJb70bc32PfBUG0el?=
 =?us-ascii?Q?/kdQKyJkZnOMWBm1+mzdpTskMZSRmseE7TBut1QhYdlspKy4LmZoBZxhU+YK?=
 =?us-ascii?Q?mUVX2ubarrOG4kavx6E44jDZfXiWV3f7h1Mjm060v0FM0RP3hEVC1JTwpdXj?=
 =?us-ascii?Q?dj3k1g/wSahbio1zBjNYYAWj91wnJ9Uy47PFURkIpLSzCrWUHbH30SpnIJas?=
 =?us-ascii?Q?kebVvGNihN14H7Ni7nY1bVpGJjLOAu+KjOQPCa3IE3caVbtvbo2bFETQi8No?=
 =?us-ascii?Q?MaAO6+PlRzj4Dj/JrI05gPKqMGuJH4QzzN1q+KWroUrI+qVdnHruiU4Iqyoe?=
 =?us-ascii?Q?nED/1iXeRGuLVxlM0xFvSsSlt/A7cdb0wuz70yIkx+FEmaQ3txrbptpYpUzE?=
 =?us-ascii?Q?A05bKSTycQ1Oo3G6+5A6L5LUdxbYWHrSr/f8E0DhL4Fl9+ATeCPc3mYsB8EE?=
 =?us-ascii?Q?QldTAF99aIr3uOEmiHYef2TVECjfwmDcCpkhWx6NZaGW8af+yH8UaaxDQIZe?=
 =?us-ascii?Q?hXQt/IWEUFnybO4PCqnUxW7aWoUwLonZ1rrj0tRRjgMpmV/ePFoWCZCozVKY?=
 =?us-ascii?Q?zyHHAeyZMInoHDN5qeC/sWZwwMWHY+JMZ9qu4hdYkFDu+9bGzJVIn/asoDFU?=
 =?us-ascii?Q?TRM9zXE5ZpnB4OG7Y64cPUHe9EU60P9EdP6a4rOANA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9vY8XjPfE7RnOygILFQOK2r7PyRIJISh3uL+WLAIuw3m66ZniWrP9aQ9YCKr?=
 =?us-ascii?Q?MWDROyBtoBB3fMDzkx/1ae6hffoR6KUT7/nE9tAAsGOcJYK/fkFLbuO1TIjM?=
 =?us-ascii?Q?c+nyoGACA4eQIuxWsF9RKFPS9wWPzp1kT6dkjH0usZznL2sGwOyMYo9OYbva?=
 =?us-ascii?Q?IiULUViBzCTMsZhHgAaiZ/JoT5xDfOXVajqUtcwvJD9fbmKSkCLUcX/8adN4?=
 =?us-ascii?Q?edaDXlbk5HzrAlK0fyeMv7qkgxhCqpgMLCfACuNR5SJ0vHzQYlThfgdefGaH?=
 =?us-ascii?Q?GPPEr6PvpvdYu6L0YF7I67vp+zncoMQAfegBxOKoFw37OQ524Cxk7GPE2j3b?=
 =?us-ascii?Q?8XwVxPzaMhhMeElsRXSP55KYEInYhS1cZjvDpp5pzZGmy4SJKZwflyOBCtYR?=
 =?us-ascii?Q?90/wRm/pWAeZN2OJ+GAC1FTrTD+RRHwki/n6y1VUbeGMAU8VIkAE8BkOaSXP?=
 =?us-ascii?Q?AmFciETo0sXrnB37p8PXgpUfQhuBFFemI9sdkZUXjZJFt30tiMURY/oEUvYA?=
 =?us-ascii?Q?UUWBLN/GUaQhKnh4+dCn7QSeZQBHHkC/wse4P3Tu6TUQSA0kMBcxjKJ1oWdK?=
 =?us-ascii?Q?oSxBp7I3ZPePzlQx4097cD044ftbiVXoCTcp9zX7xc9frQ9ctHgqucdXJqwK?=
 =?us-ascii?Q?Ly7jlCLE3ZU3LsSWWjDmMYWWQe7u05zg5LFZyQTpjZlzFu6OX6wBNdl1DyN6?=
 =?us-ascii?Q?SXH5szjyPqwvYUzWd9L3iKCANKKJCH46s9XFVzF4rbmqO2FbNJsKKl5Jwlnn?=
 =?us-ascii?Q?xjpSn+sJKPMdDiKXVBww8P7rcBD/HL1eUtcVVmGxXUOQ49izP4SsrfYATmjC?=
 =?us-ascii?Q?uBPLZzYyx/uJi6Oiy+lsDRTkDy+/fzfU//FoZQENYOacXxxG/Y5Yy2BGqGMy?=
 =?us-ascii?Q?SjiKteb6myKpX1TtHWYba+pvLJ6D4MPYH8zXmHv+8WQ/zlMgFXFk+9v0tQ5x?=
 =?us-ascii?Q?UM1iZjocBDRfETLlqs9gFC+SqgdQaK9DVczmTZ2f4KLV26oYMqIRoHHdpzOP?=
 =?us-ascii?Q?OOVBGhNPOTv5AobqZYXm/+ZAnzky8D0tVv9aHyBJrUZAoVjifb6GOICKR/jH?=
 =?us-ascii?Q?kkZaTRlQoY7pL42hMdcdd1wihYru5cb4WwWm+pNaLIrJkSnFwNMV6+g4etCv?=
 =?us-ascii?Q?4O90ln9ExpJDfvOWdaGs+YgpOyA0jjNGSjPTlMOYg9ZWHCuX9PqK8Hjc1e00?=
 =?us-ascii?Q?0pCOLjSuf2N4c3xnL70i6iirwtpcsvG56CKbQnAIYf+9tFjv6KpfgBO3XW+2?=
 =?us-ascii?Q?1bIUKd5rLVwiUlUQ6a+jco1+C/qF+fbZUzVZuW9OvPnBZY/8Gk3kiKdqy4rT?=
 =?us-ascii?Q?PUJUQHx4ugOiAXs1g7nsB4LzapkzB5NCpBqiZE+L+Uvbn3vu3DmaAMQuMgW3?=
 =?us-ascii?Q?rYnU36cvma+1bPSDvuyDEcUL9Z7t+kcPtkVqeftqJdZVBCbOsXtJXkOyu3FH?=
 =?us-ascii?Q?DmJbGR6SEsR02A7DdN/23x/vsMbOLVzlvjSNaPnFCkhfHRk8H43+9sMZin85?=
 =?us-ascii?Q?mm2lCghJi+LqCrNvN5B6FQl8jaYItnYzsYlj6LfGSj5XinDYZEL1YmqXcTuf?=
 =?us-ascii?Q?vVrJnA9wl89zrCy1VscjxdCqUzaaTOmcptP8EkqJ?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 08350fa0-7ad6-4157-060a-08dcdff1d86b
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2024 19:14:59.2088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uvZcL23aFK5MwnRgAp68jpf99YLIjd/44GEEX6e0nWVQ3e2SgeZXYRghjYR3jjFcuHg6W6DEiWVIo47lOiHeWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB7411

On Thu, 12 Sep 2024 00:52:49 +0200
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
> ---
>  rust/kernel/alloc.rs      |   6 +
>  rust/kernel/alloc/kvec.rs | 638 ++++++++++++++++++++++++++++++++++++++
>  rust/kernel/prelude.rs    |   2 +-
>  3 files changed, 645 insertions(+), 1 deletion(-)
>  create mode 100644 rust/kernel/alloc/kvec.rs
> 
> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> index 1d0cb6f12af9..4fb983b63d46 100644
> --- a/rust/kernel/alloc.rs
> +++ b/rust/kernel/alloc.rs
> @@ -5,6 +5,7 @@
>  #[cfg(not(any(test, testlib)))]
>  pub mod allocator;
>  pub mod kbox;
> +pub mod kvec;
>  pub mod vec_ext;
>  
>  #[cfg(any(test, testlib))]
> @@ -18,6 +19,11 @@
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
> index 000000000000..631a44e19f35
> --- /dev/null
> +++ b/rust/kernel/alloc/kvec.rs
> @@ -0,0 +1,638 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Implementation of [`Vec`].
> +
> +use super::{
> +    allocator::{KVmalloc, Kmalloc, Vmalloc},
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
> +    ptr::NonNull,
> +    slice,
> +    slice::SliceIndex,
> +};
> +
> +/// Create a [`Vec`] containing the arguments.
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
> +/// `Kmalloc`, `Vmalloc` or `KVmalloc`), written `Vec<T, A>`.
> +///
> +/// For non-zero-sized values, a [`Vec`] will use the given allocator `A` for its allocation. For
> +/// the most common allocators the type aliases `KVec`, `VVec` and `KVVec` exist.
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
> +/// - `self.cap` represents the absolute number of elements that can be stored within the vector
> +///   without re-allocation. However, it is legal for the backing buffer to be larger than
> +///   `size_of<T>` times the capacity.
> +///
> +/// - The `Allocator` type `A` of the vector is the exact same `Allocator` type the backing buffer
> +///   was allocated with (and must be freed with).
> +pub struct Vec<T, A: Allocator> {
> +    ptr: NonNull<T>,
> +    /// Represents the actual buffer size as `cap` times `size_of::<T>` bytes.
> +    ///
> +    /// Note: This isn't quite the same as `Self::capacity`, which in contrast returns the number of
> +    /// elements we can still store without reallocating.
> +    ///
> +    /// # Invariants
> +    ///
> +    /// `cap` must be in the `0..=isize::MAX` range.
> +    cap: usize,
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
> +    fn is_zst() -> bool {
> +        core::mem::size_of::<T>() == 0
> +    }
> +
> +    /// Returns the number of elements that can be stored within the vector without allocating
> +    /// additional memory.
> +    pub fn capacity(&self) -> usize {
> +        if Self::is_zst() {

Better to ensure everything ZST related is const to avoid putting load
on optimizer.

The Rust standard library defines a trait `SizedTypeProperties` and an
associative const, but you can also just do:

	if const { Self::is_zst() } {

(and change is_zst to const).

You might need to add `feature(inline_const)` since it's stable in 1.79
and we have MSRV of 1.76 (the trait method doesn't need new feature gate).


> +            usize::MAX
> +        } else {
> +            self.cap
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
> +        Self {
> +            ptr: NonNull::dangling(),
> +            cap: 0,
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
> +        Vec::reserve(self, 1, flags)?;

Not sure why this isn't `self.reserve(1, flags)?`?

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
> +        Self::reserve(&mut v, capacity, flags)?;

same here.

> +
> +        Ok(v)
> +    }
> +
> +    /// Pushes clones of the elements of slice into the [`Vec`] instance.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// let mut v = KVec::new();
> +    /// v.push(1, GFP_KERNEL)?;
> +    ///
> +    /// v.extend_from_slice(&[20, 30, 40], GFP_KERNEL)?;
> +    /// assert_eq!(&v, &[1, 20, 30, 40]);
> +    ///
> +    /// v.extend_from_slice(&[50, 60], GFP_KERNEL)?;
> +    /// assert_eq!(&v, &[1, 20, 30, 40, 50, 60]);
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    pub fn extend_from_slice(&mut self, other: &[T], flags: Flags) -> Result<(), AllocError>
> +    where
> +        T: Clone,
> +    {
> +        self.reserve(other.len(), flags)?;
> +        for (slot, item) in core::iter::zip(self.spare_capacity_mut(), other) {
> +            slot.write(item.clone());
> +        }
> +
> +        // SAFETY:
> +        // - `other.len()` spare entries have just been initialized, so it is safe to increase
> +        //   the length by the same number.
> +        // - `self.len() + other.len() <= self.capacity()` is guaranteed by the preceding `reserve`
> +        //   call.
> +        unsafe { self.set_len(self.len() + other.len()) };
> +        Ok(())
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
> +        let cap = if Self::is_zst() { 0 } else { capacity };
> +
> +        Self {
> +            // SAFETY: By the safety requirements, `ptr` is either dangling or pointing to a valid
> +            // memory allocation, allocated with `A`.
> +            ptr: unsafe { NonNull::new_unchecked(ptr) },
> +            cap,
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
> +        // We know `cap` is <= `isize::MAX` because of the type invariants of `Self`. So the
> +        // multiplication by two won't overflow.
> +        let new_cap = core::cmp::max(cap * 2, len.checked_add(additional).ok_or(AllocError)?);
> +        let layout = core::alloc::Layout::array::<T>(new_cap).map_err(|_| AllocError)?;
> +
> +        // We need to make sure that `ptr` is either NULL or comes from a previous call to
> +        // `realloc_flags`. A `Vec<T, A>`'s `ptr` value is not guaranteed to be NULL and might be
> +        // dangling after being created with `Vec::new`. Instead, we can rely on `Vec<T, A>`'s
> +        // capacity to be zero if no memory has been allocated yet.
> +        let ptr = if cap == 0 {
> +            None
> +        } else {
> +            Some(self.ptr.cast())
> +        };
> +
> +        // SAFETY: `ptr` is valid because it's either `None` or comes from a previous call to
> +        // `A::realloc`. We also verified that the type is not a ZST.
> +        let ptr = unsafe { A::realloc(ptr, layout, flags)? };
> +
> +        self.ptr = ptr.cast();
> +
> +        // INVARIANT: `Layout::array` fails if the resulting byte size is greater than `isize::MAX`.
> +        self.cap = new_cap;
> +
> +        Ok(())
> +    }
> +}
> +
> +impl<T: Clone, A: Allocator> Vec<T, A> {
> +    /// Extend the vector by `n` clones of `value`.
> +    pub fn extend_with(&mut self, n: usize, value: T, flags: Flags) -> Result<(), AllocError> {
> +        if n == 0 {
> +            return Ok(());
> +        }
> +
> +        self.reserve(n, flags)?;
> +
> +        let spare = self.spare_capacity_mut();
> +
> +        for item in spare.iter_mut().take(n - 1) {
> +            item.write(value.clone());
> +        }
> +
> +        // We can write the last element directly without cloning needlessly.
> +        spare[n - 1].write(value);
> +
> +        // SAFETY:
> +        // - `self.len() + n < self.capacity()` due to the call to reserve above,
> +        // - the loop and the line above initialized the next `n` elements.
> +        unsafe { self.set_len(self.len() + n) };
> +
> +        Ok(())
> +    }
> +
> +    /// Create a new `Vec<T, A> and extend it by `n` clones of `value`.
> +    pub fn from_elem(value: T, n: usize, flags: Flags) -> Result<Self, AllocError> {
> +        let mut v = Self::with_capacity(n, flags)?;
> +
> +        v.extend_with(n, value, flags)?;
> +
> +        Ok(v)
> +    }
> +}
> +
> +impl<T, A> Drop for Vec<T, A>
> +where
> +    A: Allocator,
> +{
> +    fn drop(&mut self) {
> +        // SAFETY: We need to drop the vector's elements in place, before we free the backing
> +        // memory.
> +        unsafe {
> +            core::ptr::drop_in_place(core::ptr::slice_from_raw_parts_mut(
> +                self.as_mut_ptr(),
> +                self.len,
> +            ))
> +        };

Comment: this can be `core::ptr::drop_in_place(&mut *self)`. The
standard library plays safe with raw pointers because it has
`#[may_dangle]` on T. However I think we should keep the code as is.

> +
> +        // If `cap == 0` we never allocated any memory in the first place.
> +        if self.cap != 0 {
> +            // SAFETY: `self.ptr` was previously allocated with `A`.
> +            unsafe { A::free(self.ptr.cast()) };
> +        }
> +    }
> +}
> +
> +impl<T, A, const N: usize> From<Box<[T; N], A>> for Vec<T, A>
> +where
> +    A: Allocator,
> +{
> +    fn from(b: Box<[T; N], A>) -> Vec<T, A> {
> +        let len = b.len();
> +        let ptr = Box::into_raw(b);
> +
> +        // SAFETY:
> +        // - `b` has been allocated with `A`,
> +        // - `ptr` fulfills the alignment requirements for `T`,
> +        // - `ptr` points to memory with at least a size of `size_of::<T>() * len`,
> +        // - all elements within `b` are initialized values of `T`,
> +        // - `len` does not exceed `isize::MAX`.
> +        unsafe { Vec::from_raw_parts(ptr as _, len, len) }
> +    }
> +}
> +
> +impl<T> Default for KVec<T> {
> +    #[inline]
> +    fn default() -> Self {
> +        Self::new()
> +    }
> +}
> +
> +impl<T: fmt::Debug, A: Allocator> fmt::Debug for Vec<T, A> {
> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> +        fmt::Debug::fmt(&**self, f)
> +    }
> +}
> +
> +impl<T, A> Deref for Vec<T, A>
> +where
> +    A: Allocator,
> +{
> +    type Target = [T];
> +
> +    #[inline]
> +    fn deref(&self) -> &[T] {
> +        // SAFETY: The memory behind `self.as_ptr()` is guaranteed to contain `self.len`
> +        // initialized elements of type `T`.
> +        unsafe { slice::from_raw_parts(self.as_ptr(), self.len) }
> +    }
> +}
> +
> +impl<T, A> DerefMut for Vec<T, A>
> +where
> +    A: Allocator,
> +{
> +    #[inline]
> +    fn deref_mut(&mut self) -> &mut [T] {
> +        // SAFETY: The memory behind `self.as_ptr()` is guaranteed to contain `self.len`
> +        // initialized elements of type `T`.
> +        unsafe { slice::from_raw_parts_mut(self.as_mut_ptr(), self.len) }
> +    }
> +}
> +
> +impl<T: Eq, A> Eq for Vec<T, A> where A: Allocator {}
> +
> +impl<T, I: SliceIndex<[T]>, A> Index<I> for Vec<T, A>
> +where
> +    A: Allocator,
> +{
> +    type Output = I::Output;
> +
> +    #[inline]
> +    fn index(&self, index: I) -> &Self::Output {
> +        Index::index(&**self, index)
> +    }
> +}
> +
> +impl<T, I: SliceIndex<[T]>, A> IndexMut<I> for Vec<T, A>
> +where
> +    A: Allocator,
> +{
> +    #[inline]
> +    fn index_mut(&mut self, index: I) -> &mut Self::Output {
> +        IndexMut::index_mut(&mut **self, index)
> +    }
> +}
> +
> +macro_rules! impl_slice_eq {
> +    ([$($vars:tt)*] $lhs:ty, $rhs:ty) => {
> +        impl<T, U, $($vars)*> PartialEq<$rhs> for $lhs
> +        where
> +            T: PartialEq<U>,
> +        {
> +            #[inline]
> +            fn eq(&self, other: &$rhs) -> bool { self[..] == other[..] }
> +        }
> +    }
> +}
> +
> +impl_slice_eq! { [A1: Allocator, A2: Allocator] Vec<T, A1>, Vec<U, A2> }
> +impl_slice_eq! { [A: Allocator] Vec<T, A>, &[U] }
> +impl_slice_eq! { [A: Allocator] Vec<T, A>, &mut [U] }
> +impl_slice_eq! { [A: Allocator] &[T], Vec<U, A> }
> +impl_slice_eq! { [A: Allocator] &mut [T], Vec<U, A> }
> +impl_slice_eq! { [A: Allocator] Vec<T, A>, [U] }
> +impl_slice_eq! { [A: Allocator] [T], Vec<U, A> }
> +impl_slice_eq! { [A: Allocator, const N: usize] Vec<T, A>, [U; N] }
> +impl_slice_eq! { [A: Allocator, const N: usize] Vec<T, A>, &[U; N] }
> diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
> index d5f2fe42d093..80223cdaa485 100644
> --- a/rust/kernel/prelude.rs
> +++ b/rust/kernel/prelude.rs
> @@ -14,7 +14,7 @@
>  #[doc(no_inline)]
>  pub use core::pin::Pin;
>  
> -pub use crate::alloc::{flags::*, vec_ext::VecExt, Box, KBox, KVBox, VBox};
> +pub use crate::alloc::{flags::*, vec_ext::VecExt, Box, KBox, KVBox, KVVec, KVec, VBox, VVec};
>  
>  #[doc(no_inline)]
>  pub use alloc::vec::Vec;


