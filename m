Return-Path: <linux-kernel+bounces-531871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FB3A44623
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E4073B079B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F68D18FDBE;
	Tue, 25 Feb 2025 16:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="ReWoh7pt"
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020104.outbound.protection.outlook.com [52.101.195.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B060818F2FB;
	Tue, 25 Feb 2025 16:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500935; cv=fail; b=Wlb3PRj00OqiK5APJGprKmO7RlCbD+aVsWPoNMKFetiVVjevUYTTvqHq4R0my8zuxBjx9TFExRFgYn9vwR5roeE0uFR7Hh6vwohwApJYKlKw9Mv2JUgsWqD/JPGllyh9wGQaFj6jSDMjpR5ynYsn20iNy3Xy4Aa+w4ITxCAGZhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500935; c=relaxed/simple;
	bh=vlyg1zpV7rxy7YOtvlfVh3y5EJqwnp+MFs1Nufx7WV8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o83TzjoY1ehMq4IyYBgajkdiI7UJdCt9pojDUeyca3gf5ky2ulE2ySI14rUL9wRum4DgcukNIBylkW5b3+D5qntL/z9y5h7go0v/vVmM+5VsTk0N+QHde8e09wOwknnalO2cLBexbt79zeyg+Ej4L0pAuiFFGm431cu3ooYWwXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ReWoh7pt; arc=fail smtp.client-ip=52.101.195.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YGWU6QGGfN7XCiCzusr3c3g4SWdFCmrpkYutaQ45NP7/5+acBB7E4oOxl5p4kPvZESRF1ZT+DzN0MCMmFTYI2lxdLKZOlavAQLvze+Fk+rWVpEB567nj+MxzhFfzry3fKQ//P2gu4sgXyAVKlPeuCj0mGNGdGnXV10Vtm9OmfTe5CISkBtDQaTXaZN23FSnrpdGNkq0wToMg3tfO4kykdEnqtWvhrEDuKvqiEbT9Gbpg3g3+ywe1xrf08vC+ib965StFB+tjHEU/umLII3cNA5yMRc4aFX51zW4CdLPBU2r4ebL6QoPpsaIhXxIZqjefh1wc/9SLKQM781rzVamVOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4S67MEk0nyjtZlka9a0nURpb/hAjOMpKlH+aU0rTng=;
 b=pwE7paj9r8qlASth3a0wdtnc8l5ePZyC52uk8Ok6OQmH/Pzom9d3unI58wjQohEBBuWU8k/n5egGJjsg0gjZfyBKHd9z44m/GHQhGmbRCWYcOk1nimpXrdSuUlgPmy4Nax9WDYF69sjiE2SqRq7jMIV1u1w4nmSKzzwtNThnLPjH8yKHo2MwVHVvpbYsj2K4YeiR18oNPGRX6fPRaHoEzory2VDe+J1Ncwpz2VQ+g8jsdAoM7N6gv8I2kVBHUmnlG4EZv5ON4EO6jLKISrLIBKGPY6ogDMPpxj+5/TIMzncSySLyhQjpdm/ivVhgUpDarOZzRXdx7cN9UPF3Qya2uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4S67MEk0nyjtZlka9a0nURpb/hAjOMpKlH+aU0rTng=;
 b=ReWoh7ptgC8/kVL3UwtRzrsbEwXVIe3Z37MAFlrRb852WBRoE0PfIgswxPzfMcgdj8fSl2pzrloj8HXvl++R7FHsJOVYZrpi3FWkdSc1kclvgj3FvQlft1yubsMg6mrEfcw5zaxQCzRI4eCqbNTs+el/EBRsk/T7CsP/oLqkRhw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWXP265MB2805.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:c5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.17; Tue, 25 Feb
 2025 16:28:51 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%5]) with mapi id 15.20.8489.014; Tue, 25 Feb 2025
 16:28:51 +0000
Date: Tue, 25 Feb 2025 16:28:48 +0000
From: Gary Guo <gary@garyguo.net>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>,
 Jann Horn <jannh@google.com>, Suren Baghdasaryan <surenb@google.com>, Alex
 Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, "
 =?UTF-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin
 <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor
 Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v14 4/8] mm: rust: add lock_vma_under_rcu
Message-ID: <20250225162848.730a420e@eugeo>
In-Reply-To: <20250213-vma-v14-4-b29c47ab21f5@google.com>
References: <20250213-vma-v14-0-b29c47ab21f5@google.com>
	<20250213-vma-v14-4-b29c47ab21f5@google.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0331.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::12) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWXP265MB2805:EE_
X-MS-Office365-Filtering-Correlation-Id: 56c5f514-dd6a-4c56-7c1d-08dd55b97ccb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?poxd4q3wZr3DE8g50UB2VX48Vu+GJ4QnuqWz/eymmaykeG+hhD3OHAMk5V2J?=
 =?us-ascii?Q?8p8J8aKqRBRkuQDN9hZe2Xetp19NjOPean43sy0TD5B1H3mDw/vALCVOKGfq?=
 =?us-ascii?Q?kaNUDxab9OIshdvV/Oc3scdmlf66j1uRe3PonkO6KloKRSqp9+EnekiOOPx6?=
 =?us-ascii?Q?uyLsdQAjIsXzX0OHbx1TIfWD5wDJP4CIx00Ed6AZWScQ5L3z9HC1EFGM/52L?=
 =?us-ascii?Q?bvO56Os7fCsON7FLv+f2EJfwMMvRFXNhTC8bnIhhg4/inGNPCSKLH5Pw068p?=
 =?us-ascii?Q?I2fFzry1M8SfjD7oFMgH00RqTHNDBr/hiRib/slarMgKT3kO26B2D1YoCzfI?=
 =?us-ascii?Q?RfFVOVekOCDmVcWkiFyIiDc5lrmUtuHKWJ20tvuTGYePW2CXXXpTXslZd/KA?=
 =?us-ascii?Q?c+Bb3Gvq2nnJQNhlKZIPIJIPBZtIXfgp8mMP+ci2W+zBnWROVV0nbHD7bcGW?=
 =?us-ascii?Q?xC5GYoELjUiv9NGLWRg30XhkijrP9eCir8AYYajerz1y7T/3KPQeDOiU5DYs?=
 =?us-ascii?Q?aP94n1vlstgdohixilkHK5v1psjOyniTjCVP6RlqEGAbnILacclVHtuZFM7R?=
 =?us-ascii?Q?qiT6sRt8jUV3el/QLm7p9AGMrRPkJ/I8llmtTeLJeheASIpFlMO8Ld3KFGnX?=
 =?us-ascii?Q?tBjqvlYYtxzbxD3DRS24Ai9302gzcRvslf28cYGpOKIZZBtx8y9+gQixg8Wi?=
 =?us-ascii?Q?HAWYUKg+hJOESfaO6K8kdQdGaKonepmiPOpq5iGN72GXV2Sb2tLX2T4c7J4W?=
 =?us-ascii?Q?VCjXfq6oU/NJbk+Wa9QUqAGyUHBcuBCYRPClgRpHgP8piWKF9SHDfgfFZ3fn?=
 =?us-ascii?Q?7HJYUEQZRTvyQAFfdWpdQgcDh4uUQUBCsFwxveSLjlzHpjN77dDYG3ihi9DZ?=
 =?us-ascii?Q?i9TITkTYphyux6+G/wqT15d7qZoUI3may75BEIyjD4/4gr5PG/dxYywZxgUE?=
 =?us-ascii?Q?8ItRXAJfPD+G5ftQBXaZbtLTs0W/z+4MS1cm7qlFPGEwNqDbhKia9GYSZZc3?=
 =?us-ascii?Q?ZrZ9oY8KlGP6eY/zCbFxUEzFeGqdoFot9yv6Yf0nC6KAkfvz308ur00pO6pB?=
 =?us-ascii?Q?WP2RywblXwdjnKd4svZv7RxDbnE+ZPpGODWrwpf8455KqEj72zKwa7zUREAs?=
 =?us-ascii?Q?kcYyqv1M04iVYpf2073Nwa7HlsaqxH+UQ1382CVCHbz10hm9/Ck3T0MakpdD?=
 =?us-ascii?Q?uT3Bxf0pwY2PYwW7kl7bLYwBHvVY3b0gFNgduHauHx93B+IBK+JXDhABJhGa?=
 =?us-ascii?Q?GSpbavK9vx+ohKSX7aVWhAwpVaAUefnF8nX04mcpaITx4JY9wxT/59GNW0gw?=
 =?us-ascii?Q?OQIaBd8QaJBAEuXoippTH/IGJ+3ucXR7ryxrbCcTiCoW4pi0YK6iA2aWufPZ?=
 =?us-ascii?Q?Xfrm3U5wLdHCQcrT+E388hq61CX5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?phlM9WRKjXoskDrIG2WkoWLk4pCM3wfnTmQQRz7iGVybPwxmSUbYvTaolvrO?=
 =?us-ascii?Q?jrG6okZ0cty7UITGQoY9kDNLPfyAqwV5DvcSZ55P9ylMszI3Pa/VYT4Ehruk?=
 =?us-ascii?Q?/9aHfB173dGEOtqFTJOUONyvhR7sFpzZ4BPXrR6yrAy3JPsp9TVbA4bq8ZKC?=
 =?us-ascii?Q?7jvLUMzIOlYzxZmbBx1t9dKwr9dW/OLwmx2DdVyYC3XFuA4kSirHq3jluAat?=
 =?us-ascii?Q?wvKRqIF0qiC+G8p0tEuOQxaose2BKe4QYXlPDzFiVJhvShHV+R9HmdZShSh5?=
 =?us-ascii?Q?ZBvNnLOpG/khNK81fWQpseEVEbyegoptsqvzuUkC07d2FYfF/32658rnEs8i?=
 =?us-ascii?Q?BCdfEZMzUZhDF2Zg9iFej+vqnkpSvIQsoFwN6xWFWp1GR3dBXo/huHlK0n6Y?=
 =?us-ascii?Q?rN/TbqAPJ47YT4n/RmEk0K/yvGvUMh3jYFMgTwWzvlhugmJ6E6x1rZ+1om6i?=
 =?us-ascii?Q?WIbXzrROSQXUvHMcQ7c6aWvWN2APxMJpbcxWl0FYCDIU2yfiXJ0L4Wq+VXKY?=
 =?us-ascii?Q?Wx8T27ju9SXYDGK7LzwqzellAikc6VXaqJ/QudQt+Md/0dwwN9xrFfuvnIfC?=
 =?us-ascii?Q?uOqtDOf+pRzwyO9TfeFuovqWl7mbDdy7OEwwBqlIfAv9h4KmyO35OY+dDxfi?=
 =?us-ascii?Q?rNkI+hHlUlPBtY6UJ5ETX2WtEUTV30r7DbOUwrU3P2BfM6vnY9IaA2noTFDB?=
 =?us-ascii?Q?/9lH6D/FYOjjwGiimJCqCR2wLmImK8EnFFEOaWwLC+TFrVzkA/uIWiw4zaFc?=
 =?us-ascii?Q?jkJLUb7k692Ft9V49GOfPTkfEitXZY+/0bKv2w/fVXDK/yESNPz+kPHVi8t5?=
 =?us-ascii?Q?hpG/VVEvLlNGt4twwqnXs9w3ZdFGWmKTVXOrZDo5ub/l/kSRUC4OE7Vh8vwx?=
 =?us-ascii?Q?gwEqkzCTxQWJwnDFvbKxPeBLeE+pGMcDc6gfizOSA1IyaPY6fZsok9s3NYOe?=
 =?us-ascii?Q?q+WsMTO5qAnmTMvb1Vqf+B3H6PRfg+OmEsCa8SV5rYTPgPltqxWSxyf+MkdN?=
 =?us-ascii?Q?0MpfgLjIZoRdexZ5G7nGtsbEiyHxjgfs82d9q1nrLanUZJnuwanPLJU/c9tL?=
 =?us-ascii?Q?F5Z7KAy/+iTGy/vzAxX4NT5cyV7yWgGxWUXfZ5MNlmcgPjjAU318gxsxVxRP?=
 =?us-ascii?Q?VXLZQwMcgHqVC/PnsEieMjyamJmY/8XQl0xfdyhmYH+AAcT+bduzLokhO9+B?=
 =?us-ascii?Q?1qmWhVMU8JOV66zsA6E6+WSN3WnNR5frJLABFUMUX+wjG7G/7q9VG8sR9Nbv?=
 =?us-ascii?Q?gNy1UyPPyQAAy2H+Gp6j7RnxuDGMNvuoKCqDiRi4E69GQsKt/w2zFo+MzWPM?=
 =?us-ascii?Q?OanLzLs5JEFuFHG+1t01ln7yUj/05BN4cPEyErGGH079NEGWkhgyH3BlcEFk?=
 =?us-ascii?Q?zKJSUoELGvCxOuQxnEFkK1AFCuKIzixuI+sMh+qRJtHWnl4dmgErkunT1Nju?=
 =?us-ascii?Q?muQFdcCOmQK6MWi90nNMd7i9wdktwSWRAn369yeFgxstYBqnvBRDiRJDUL0h?=
 =?us-ascii?Q?+Nhc8E76Qcc3oCUOpc2HZuTblYOhUR5EBH12yF/eKhvUPLBL1a9WGqJEUPYF?=
 =?us-ascii?Q?WKwSHV1FNkRfS0ls7m2LbWwHuAvmlpVeTsThQ6Ym/PioemQudePUB4+GBPmw?=
 =?us-ascii?Q?Fw=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c5f514-dd6a-4c56-7c1d-08dd55b97ccb
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 16:28:50.9064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qgdy2N0bHlJg2ew1vXaDcTftwZaeHoJzEAGG+k42XX5FWHqtZawp5g0RPQLKWQKGGkU4+dgRv7LCZFQH33HiVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2805

On Thu, 13 Feb 2025 11:04:03 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> Currently, the binder driver always uses the mmap lock to make changes
> to its vma. Because the mmap lock is global to the process, this can
> involve significant contention. However, the kernel has a feature called
> per-vma locks, which can significantly reduce contention. For example,
> you can take a vma lock in parallel with an mmap write lock. This is
> important because contention on the mmap lock has been a long-term
> recurring challenge for the Binder driver.
> 
> This patch introduces support for using `lock_vma_under_rcu` from Rust.
> The Rust Binder driver will be able to use this to reduce contention on
> the mmap lock.
> 
> Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Jann Horn <jannh@google.com>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/helpers/mm.c |  5 +++++
>  rust/kernel/mm.rs | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++++

