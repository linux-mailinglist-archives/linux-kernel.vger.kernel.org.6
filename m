Return-Path: <linux-kernel+bounces-342628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F0198910E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 20:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 481AC1F215BE
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 18:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF3115AAC8;
	Sat, 28 Sep 2024 18:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="HhuUwPwT"
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2097.outbound.protection.outlook.com [40.107.121.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930231EB25;
	Sat, 28 Sep 2024 18:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.121.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727549690; cv=fail; b=TtE+R8U1Acwjp6+xH6Ojj1XkNe+fRpa6e4OoZzo/xwQK+x5LZoLBIvR1s8gUwbIVjMuCtRSjQGaS8PNB1fFvvo0hmo1yttLjkptpm0MAJsP2FsL3QKuuuMnJ3Ib1A47dKLffLushUiDl0w8MXESKgNNK8+H3fYKKuQTXgU6VWvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727549690; c=relaxed/simple;
	bh=23NW0hSEZc5bUGTBPukzy2rH3E4czM8f1Y/9OS52Wus=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PN/c4tfUwNllnhF8Cf+b4/wz1RodRqg4wU8Penqou9YeYYiPXhqOVrJDVeGRr56h/oosWDjEZFiWo3RfxSBmJ7s2NiaW665C3xnxkEqjWV3cxIma6TYJ3H1cM3iKAEWIQCEyHuPbuQID/ig/3t/3e/+1PSLr6ZDga/PSoliKTj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=HhuUwPwT; arc=fail smtp.client-ip=40.107.121.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rbqw7X+NWMJeH1wUC5Neu7669KhcVjy4RiNUgOsfgzZq6fe9Q207dU/L0YNyRnWsMhuAGQkHoxYc7q8sG+J3dQWJkdKPj17J62plr8Gh39v2Gqv7kRZhetfYAOAFLhBEgBCxu70wCXxWcacc0uFZyeqGlTO1rDNWJGECyeQynNwas8f3vBV6xfBot8DSw8Xf/JCWs0Cd+XgHjSd6HTK7hpSysWj51TyPoo47/9RwTKgYOklcaWO03hfZExv241foQeQcUPUkudtKtJbvHGwqtVv/TkmQp2kXATeYgQKqBt3B+RlrrWCNK5d/AfTUuP4YYtoOk8emdSeqJKI0U9oFKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/GD53aHK1rYVEfq8XTAjiRGPDUg9Q9DScDaiKMnTOI=;
 b=OAYu7QYXZs9qXoFmRPfjcKCl48HgCgdKPBhtg2yrH9+SNvU1TRRF7cYN8zc74VeRMQgMAeBaHUuFbhdC3cOeI+CLHSGYpCvtg1+ZdB1us0OLGUXqS++Nur520Nfb4eKJc1lUBssbrmye7tH4sGnLO4b0sy3+LwW8nQfavxJ7C/dZIoJLdn0Lwc6swQaumvDSxV4nWwI7q4uCtDxiRUw0SlWS0A5rDtmMaG1p0GK1UzSCKp3+trVNmFM8B8NitQO0FojfcVG8SnOzNHWUIPOJyHruMdFxIuKyvgxVrb9mKyqM7LL/4WF95lL4hMRNLytcojaCgdSKhlUnHr3PyroVng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/GD53aHK1rYVEfq8XTAjiRGPDUg9Q9DScDaiKMnTOI=;
 b=HhuUwPwTrkXtxg5KCntjbRDiE4ebzAUhcvc9sE4sygR5LAwFsB+/6/Uh3SoGlXogCaJ8hqFjyAhXhcNF1TJXstIgbtycGx8UqW5ouBbg5D6Pk512GCqJpeO6iTaTEs4iLonj3AxtPO0x5ePAaCbwhZTTrlhiBf04l12fkLjIC9I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO4P265MB6981.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:34e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.24; Sat, 28 Sep
 2024 18:54:45 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8005.024; Sat, 28 Sep 2024
 18:54:45 +0000
Date: Sat, 28 Sep 2024 19:54:36 +0100
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
Subject: Re: [PATCH v7 09/26] rust: alloc: implement kernel `Box`
Message-ID: <20240928195436.7f9c1674.gary@garyguo.net>
In-Reply-To: <20240911225449.152928-10-dakr@kernel.org>
References: <20240911225449.152928-1-dakr@kernel.org>
 <20240911225449.152928-10-dakr@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0338.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::19) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO4P265MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: bfc14057-fa74-43d2-2e74-08dcdfef04ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qjQS8qG5K3OLcUGwfTLxEWaYt5ZmYjC/Sjas9yj3J0Px+8J4Kpsrghb0kHxG?=
 =?us-ascii?Q?mWQySEJTGF+1vauXTNY2tekdZtZBh5IxDVbYBjGn/zm2OvLAKoGpuocDsaLm?=
 =?us-ascii?Q?oFRaKwTwdzIlo2246Gg696k6+sRHfGWdqg7my7a40SYKZSSOFmHUmSWzJoJX?=
 =?us-ascii?Q?ukprE97IKn2vfZqJ36ptI9o58GBvOjT0ie4LmKqCWNwX4JuSTZMJm0rHlKts?=
 =?us-ascii?Q?g0c7xHegFymnWoNuQ2XJOmHyzv/vwfS+t6Zn70YApTAE6UK0J5qyQaHzHZGD?=
 =?us-ascii?Q?b2JgCUlIUz8BMpb9w0yftARRZGxm1ZxDf8SRInj5xQNrpKuiHpSh6Gq28mAO?=
 =?us-ascii?Q?kOP4syc4qxw3YE/rZY3NL8q0RRgWWeJly/ENz2THlsm54IC38B1btAw2TBZ4?=
 =?us-ascii?Q?b68j+wwztG4XdO19ZmcpGkfd8sLI231jkw1aiSgSwoLVoDCgvTil+L7coF3p?=
 =?us-ascii?Q?fM9ACiZw1SwPnBdW3tVVw0EAMHagt+4EOFaognXiVO0AdaNfVIBB/iTKTkuH?=
 =?us-ascii?Q?HfkGzCGQiKH1Drn+fXpLNpboZDhYT1OP6teeOH0Mja5HFdhsyGsXQ4VycLue?=
 =?us-ascii?Q?qR5b7ROTo5M/F8BJWK2yfVfGTEoFmTmjQzt7PubvL+u8vm5eMxQv2/m7KGYq?=
 =?us-ascii?Q?mUoHnnOsqhcvvBBYj1cGgoEgreqd0OGJ052iG9qlrVlmD/xMfJ82TuRqBM6F?=
 =?us-ascii?Q?5s25YEqbtC/ddAxFxZs5wZet1K+U65MTwUqOY98B9NpxvjnvkpQri4hejaRo?=
 =?us-ascii?Q?6ylalU36B6uTg84R3e4CMPwfaf2xn8AcO+7t+rJxkRoHxESVRJMd5LS68fQM?=
 =?us-ascii?Q?PgrAMAgQIgsjHnZxLmype9y4Lkrn/uaG3KArD48ZJ336CjPEqyCEeqNMC4IA?=
 =?us-ascii?Q?gfr+XRiEMRwcw/p2xSO6oF2nRgR6WHlMLwI6dpSJ1YjyzHQGo4AkyiHVCeZk?=
 =?us-ascii?Q?/cgt0+UqbqArPdIjCU+bBXW35kKjK/1vV2VzOGbcy3KBdGCIjZ6ouYd7RcMN?=
 =?us-ascii?Q?O6zEPU98PsNiFRZPF3VJUtm6LMPqu1hyE0fuStbsmtzSxMUEbvk47bbuPpQc?=
 =?us-ascii?Q?FYhvWJm8HfSHogF6ndGHfs+SsG+4tuXVF3Edaqe2bCU1scd5GwgLHMmh2m9E?=
 =?us-ascii?Q?lnySlVGTTfZgQhhzWKlzpOwhGL3x5q/UMFDHZ7p5cY72BPh/nC4Lm4uqdi+A?=
 =?us-ascii?Q?pGXgqVdN2wpUlsHgMA4mtUrRp0bqvhXLsYvxXPzlTLvPrHlVQ6dg+PDZG47l?=
 =?us-ascii?Q?vOY/YpYfW+YzJVduIy9LWwLdnGTm/wCf4HUb0VOZ+g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fy3pRdKQioJ9dOgBdWtiHU7+81s10A0YucpvFAgxZRttU/dY9/9VySnsXpLX?=
 =?us-ascii?Q?POILAxcbSvX72LLo3iEcGJkK0Pn/s0Zb/u1yrsTg4p4D1pqII5jNu8D3cyH/?=
 =?us-ascii?Q?0e/UP2q7HCZBv2s0woIhhRd1Zp7jZNd1iRTHGQpPnLWVxZyNOmGte2e7Fjrj?=
 =?us-ascii?Q?I2KyeTGZ6xOBgeR8/Pk+odHHz78nqrE3iCVOnOrUounTAoJPsgV0c66cUN5R?=
 =?us-ascii?Q?cJ1Gw1Vr/t2DLZVPNuhdjZtn1jM1i/mZdlgPO0UMqF59JF34SRKzsPvsnYMr?=
 =?us-ascii?Q?t92Dmng3Hf3no5lPClFPFVe6MxMsh90ARA27BGJnDgvkseYFZ89eH7D1DiF8?=
 =?us-ascii?Q?N1zWzAkLp3Uj/RFN2lbCaDwRR86efb+LZLiC+bSd+2eFP4qNYNvOYZBjtmYK?=
 =?us-ascii?Q?7nATPsoTlXnfeTCoU8ly2+vY8Mbco3/SyPh4VuC2CPB+kpd8++uWM/4e5osJ?=
 =?us-ascii?Q?nbzdPK+M2KASueCYYnT3cmjT6Z50iQpxjtKtBX0WwU1iohOrnCYCzw14Ep4a?=
 =?us-ascii?Q?bfWvPJcDZKatYSLFDhK9YHzOUS/ewShyURTf3UDlSyqv4IKVajWlObtMFK9T?=
 =?us-ascii?Q?Rc2K2k3ZQl1bK/Lsh6n30YQrIS5ue4jn3faiH2If5+A89PVTrUCnzMbq3tFt?=
 =?us-ascii?Q?kz+Q6EICac3f8YWP/0VOSfOoerwArXH35WK3RHDBs6O4VHxtaUVy6ja9dUvc?=
 =?us-ascii?Q?akUdeUKX8WAmTtJOpwwGn6jY1kYDhUtBpz8ibrod5p9w+jK/+1Wjgbv1VxHY?=
 =?us-ascii?Q?oXjSnJUHYwopILKkzvxiFTz1w4gC8FarQ5kSd8mgc/5Kc2TKL9nhtqoH9M8X?=
 =?us-ascii?Q?bE8B6kDXAecqMWd2eHChH5yoN0wiVQo3cjUQmL+1r7PVendCHWV/UUPE0R9O?=
 =?us-ascii?Q?Yw5G4XwYQdMs4nCclQ7NzohLRvzlfsh19qgYeoVtNUxNUdwzEXMbNf7zPele?=
 =?us-ascii?Q?NTU+HzvBpsKKOmoaOxQs4VDQ7eXiGKJ+3iqQH3h6AhrPSoPymhxYzKDZyT5h?=
 =?us-ascii?Q?yNM8QikAFQWdcPw7EAtLhADJ+b0rwFzupkZR9kSp062lHu/uPoKp0vFuANVc?=
 =?us-ascii?Q?oWqLMLi4xhUkEpboBV1nK46E/s07l2ddWwtyZSUsiP5NFD9qQO5SNfViVb1B?=
 =?us-ascii?Q?mA95R5TeKTKHmXpc1sVrhqeG9RyQhVIbIs8+NlH/wc6KNqDckoXc01MYeZCF?=
 =?us-ascii?Q?exgL7ox8pnRnqk2Ja46cfIcJ+2MyJeGqgvD8wGCaB4KEdHzykc+2XWR1Awh4?=
 =?us-ascii?Q?UrOgh9sJsk/cmDQ5zkyIU7KzeE7Q+MgVA4Skjx3u/eMSxvpqQEqsayaE+sB5?=
 =?us-ascii?Q?elytNeMd5t/aT2Q2JWaXTyVSTOhXn9GwdaM4uPckTikRasDF19uGSKMEFMCv?=
 =?us-ascii?Q?/8tcvKLvFk3NfvI212AmUPr8FAxYc4OhfwdwP+FAVijHBEW5et6Vb8sN/4KI?=
 =?us-ascii?Q?NDLD2E4knIpBJtlGr6aInZ11FXwKhfBGtQBibP/WGPF9LCekyW831bmET4KO?=
 =?us-ascii?Q?qlXxafQRdSs8OAh+esh4NEFQJI5tihGHaxpsEGUh/1XaGQD5KGViuHSbB6Wg?=
 =?us-ascii?Q?/jdpcKnOCUPrgEDUVmqlE5Wi7uUme4YEePqItyMbFN3rfpxTAya/E5nvsTT2?=
 =?us-ascii?Q?eg=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc14057-fa74-43d2-2e74-08dcdfef04ba
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2024 18:54:45.0337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PpPa//6cDdk5xmShd7WJVGzjMCqWvQbbZGhHE6w1NsGZT15xGzZYUUXklUh5yDgoigWbDRJrdUXT+uv8SGPefQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6981

On Thu, 12 Sep 2024 00:52:45 +0200
Danilo Krummrich <dakr@kernel.org> wrote:

> `Box` provides the simplest way to allocate memory for a generic type
> with one of the kernel's allocators, e.g. `Kmalloc`, `Vmalloc` or
> `KVmalloc`.
> 
> In contrast to Rust's `Box` type, the kernel `Box` type considers the
> kernel's GFP flags for all appropriate functions, always reports
> allocation failures through `Result<_, AllocError>` and remains
> independent from unstable features.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/alloc.rs      |   6 +
>  rust/kernel/alloc/kbox.rs | 465 ++++++++++++++++++++++++++++++++++++++
>  rust/kernel/prelude.rs    |   2 +-
>  3 files changed, 472 insertions(+), 1 deletion(-)
>  create mode 100644 rust/kernel/alloc/kbox.rs
> 
> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> index 7a405d6f3034..b1f28334b27a 100644
> --- a/rust/kernel/alloc.rs
> +++ b/rust/kernel/alloc.rs
> @@ -5,6 +5,7 @@
>  #[cfg(not(any(test, testlib)))]
>  pub mod allocator;
>  pub mod box_ext;
> +pub mod kbox;
>  pub mod vec_ext;
>  
>  #[cfg(any(test, testlib))]
> @@ -13,6 +14,11 @@
>  #[cfg(any(test, testlib))]
>  pub use self::allocator_test as allocator;
>  
> +pub use self::kbox::Box;
> +pub use self::kbox::KBox;
> +pub use self::kbox::KVBox;
> +pub use self::kbox::VBox;
> +
>  /// Indicates an allocation error.
>  #[derive(Copy, Clone, PartialEq, Eq, Debug)]
>  pub struct AllocError;
> diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
> new file mode 100644
> index 000000000000..6188494f040d
> --- /dev/null
> +++ b/rust/kernel/alloc/kbox.rs
> @@ -0,0 +1,465 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Implementation of [`Box`].
> +
> +#[allow(unused_imports)] // Used in doc comments.
> +use super::allocator::{KVmalloc, Kmalloc, Vmalloc};
> +use super::{AllocError, Allocator, Flags};
> +use core::fmt;
> +use core::marker::PhantomData;
> +use core::mem::ManuallyDrop;
> +use core::mem::MaybeUninit;
> +use core::ops::{Deref, DerefMut};
> +use core::pin::Pin;
> +use core::ptr::NonNull;
> +use core::result::Result;
> +
> +use crate::init::{InPlaceInit, InPlaceWrite, Init, PinInit};
> +use crate::types::ForeignOwnable;
> +
> +/// The kernel's [`Box`] type -- a heap allocation for a single value of type `T`.
> +///
> +/// This is the kernel's version of the Rust stdlib's `Box`. There are several of differences,
> +/// for example no `noalias` attribute is emitted and partially moving out of a `Box` is not
> +/// supported. There are also several API differences, e.g. `Box` always requires an [`Allocator`]
> +/// implementation to be passed as generic, page [`Flags`] when allocating memory and all functions
> +/// that may allocate memory are fallible.
> +///
> +/// `Box` works with any of the kernel's allocators, e.g. [`Kmalloc`], [`Vmalloc`] or [`KVmalloc`].
> +/// There are aliases for `Box` with these allocators ([`KBox`], [`VBox`], [`KVBox`]).
> +///
> +/// When dropping a [`Box`], the value is also dropped and the heap memory is automatically freed.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// let b = KBox::<u64>::new(24_u64, GFP_KERNEL)?;
> +///
> +/// assert_eq!(*b, 24_u64);
> +/// # Ok::<(), Error>(())
> +/// ```
> +///
> +/// ```
> +/// # use kernel::bindings;
> +/// const SIZE: usize = bindings::KMALLOC_MAX_SIZE as usize + 1;
> +/// struct Huge([u8; SIZE]);
> +///
> +/// assert!(KBox::<Huge>::new_uninit(GFP_KERNEL | __GFP_NOWARN).is_err());
> +/// ```
> +///
> +/// ```
> +/// # use kernel::bindings;
> +/// const SIZE: usize = bindings::KMALLOC_MAX_SIZE as usize + 1;
> +/// struct Huge([u8; SIZE]);
> +///
> +/// assert!(KVBox::<Huge>::new_uninit(GFP_KERNEL).is_ok());
> +/// ```
> +///
> +/// # Invariants
> +///
> +/// `self.0` is always properly aligned and either points to memory allocated with `A` or, for
> +/// zero-sized types, is a dangling, well aligned pointer.
> +#[repr(transparent)]
> +pub struct Box<T: ?Sized, A: Allocator>(NonNull<T>, PhantomData<A>);
> +
> +/// Type alias for [`Box`] with a [`Kmalloc`] allocator.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// let b = KBox::new(24_u64, GFP_KERNEL)?;
> +///
> +/// assert_eq!(*b, 24_u64);
> +/// # Ok::<(), Error>(())
> +/// ```
> +pub type KBox<T> = Box<T, super::allocator::Kmalloc>;
> +
> +/// Type alias for [`Box`] with a [`Vmalloc`] allocator.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// let b = VBox::new(24_u64, GFP_KERNEL)?;
> +///
> +/// assert_eq!(*b, 24_u64);
> +/// # Ok::<(), Error>(())
> +/// ```
> +pub type VBox<T> = Box<T, super::allocator::Vmalloc>;
> +
> +/// Type alias for [`Box`] with a [`KVmalloc`] allocator.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// let b = KVBox::new(24_u64, GFP_KERNEL)?;
> +///
> +/// assert_eq!(*b, 24_u64);
> +/// # Ok::<(), Error>(())
> +/// ```
> +pub type KVBox<T> = Box<T, super::allocator::KVmalloc>;
> +
> +// SAFETY: `Box` is `Send` if `T` is `Send` because the `Box` owns a `T`.
> +unsafe impl<T, A> Send for Box<T, A>
> +where
> +    T: Send + ?Sized,
> +    A: Allocator,
> +{
> +}
> +
> +// SAFETY: `Box` is `Sync` if `T` is `Sync` because the `Box` owns a `T`.
> +unsafe impl<T, A> Sync for Box<T, A>
> +where
> +    T: Sync + ?Sized,
> +    A: Allocator,
> +{
> +}
> +
> +impl<T, A> Box<T, A>
> +where
> +    T: ?Sized,
> +    A: Allocator,
> +{
> +    /// Creates a new `Box<T, A>` from a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// For non-ZSTs, `raw` must point at an allocation allocated with `A`that is sufficiently
> +    /// aligned for and holds a valid `T`. The caller passes ownership of the allocation to the
> +    /// `Box`.
> +    ///
> +    /// For ZSTs, `raw` must be a dangling, well aligned pointer.
> +    #[inline]
> +    pub const unsafe fn from_raw(raw: *mut T) -> Self {
> +        // INVARIANT: Validity of `raw` is guaranteed by the safety preconditions of this function.
> +        // SAFETY: By the safety preconditions of this function, `raw` is not a NULL pointer.
> +        Self(unsafe { NonNull::new_unchecked(raw) }, PhantomData::<A>)

nit: the turbofish here is not necessary.

	Self(unsafe { NonNull::new_unchecked(raw) }, PhantomData)

> +    }
> +
> +    /// Consumes the `Box<T, A>` and returns a raw pointer.
> +    ///
> +    /// This will not run the destructor of `T` and for non-ZSTs the allocation will stay alive
> +    /// indefinitely. Use [`Box::from_raw`] to recover the [`Box`], drop the value and free the
> +    /// allocation, if any.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// let x = KBox::new(24, GFP_KERNEL)?;
> +    /// let ptr = KBox::into_raw(x);
> +    /// let x = unsafe { KBox::from_raw(ptr) };
> +    ///
> +    /// assert_eq!(*x, 24);
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    #[inline]
> +    pub fn into_raw(b: Self) -> *mut T {
> +        let b = ManuallyDrop::new(b);
> +
> +        b.0.as_ptr()
> +    }
> +
> +    /// Consumes and leaks the `Box<T, A>` and returns a mutable reference.
> +    ///
> +    /// See [Box::into_raw] for more details.
> +    #[inline]
> +    pub fn leak<'a>(b: Self) -> &'a mut T {
> +        // SAFETY: `Box::into_raw` always returns a properly aligned and dereferenceable pointer
> +        // which points to an initialized instance of `T`.
> +        unsafe { &mut *Box::into_raw(b) }
> +    }
> +}
> +
> +impl<T, A> Box<MaybeUninit<T>, A>
> +where
> +    A: Allocator,
> +{
> +    /// Converts a `Box<MaybeUninit<T>, A>` to a `Box<T, A>`.
> +    ///
> +    /// It is undefined behavior to call this function while the value inside of `b` is not yet
> +    /// fully initialized.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that the value inside of `b` is in an initialized state.
> +    pub unsafe fn assume_init(b: Self) -> Box<T, A> {

I think this can take `self` and shadow the underlying
`MaybeUninit::assume_init` -- the rationale being that the
`MaybeUninit::assume_init` takes `self` so it cannot actually be used
for `Box<MaybeUninit<T>>`. Rust standard library also takes the
approach (with the unstable box assume_init takes `self`).

Note the argument of `Box` not having `self` methods don't apply here,
as it doesn't deref to an arbitrary type, but rather always
`MaybeUninit`.

> +        let raw = Self::into_raw(b);
> +
> +        // SAFETY: `raw` comes from a previous call to `Box::into_raw`. By the safety requirements
> +        // of this function, the value inside the `Box` is in an initialized state. Hence, it is
> +        // safe to reconstruct the `Box` as `Box<T, A>`.
> +        unsafe { Box::from_raw(raw.cast()) }
> +    }
> +
> +    /// Writes the value and converts to `Box<T, A>`.
> +    pub fn write(mut b: Self, value: T) -> Box<T, A> {
> +        (*b).write(value);
> +        // SAFETY: We've just initialized `b`'s value.
> +        unsafe { Self::assume_init(b) }
> +    }

same here.

> +}
> +
> +impl<T, A> Box<T, A>
> +where
> +    A: Allocator,
> +{
> +    fn is_zst() -> bool {
> +        core::mem::size_of::<T>() == 0
> +    }
> +
> +    /// Creates a new `Box<T, A>` and initializes its contents with `x`.
> +    ///
> +    /// New memory is allocated with `A`. The allocation may fail, in which case an error is
> +    /// returned. For ZSTs no memory is allocated.
> +    pub fn new(x: T, flags: Flags) -> Result<Self, AllocError> {
> +        let b = Self::new_uninit(flags)?;
> +        Ok(Box::write(b, x))
> +    }

