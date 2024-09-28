Return-Path: <linux-kernel+bounces-342641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1C0989121
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 21:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13C4F1C22299
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 19:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D05158D93;
	Sat, 28 Sep 2024 19:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="akr/OR4C"
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01on2129.outbound.protection.outlook.com [40.107.122.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD7217736;
	Sat, 28 Sep 2024 19:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.122.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727551821; cv=fail; b=T1mbFMRTyt5HloagAM6zefkmMwHEvRo313p8H9zHR72QL+rhmA0FZjMsqiWowf3jgp+OmH2QFQEbIRYkM127GuakyGCMk57PeYvHtojOG38xHllPB3JYyEnG7A5VJZdyM7yj+Cie6lG51pacZKaG/dU76mElSP/BDOQRLKZERX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727551821; c=relaxed/simple;
	bh=RHQpQw0cWjBDV4eyUy7o/Ep3gefwe6DKy4Fjz1iXPx0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=APzFOz1qhwoU0nsU0gE4r+MWvwK/5JRGm7zX5hqYTDpy47WaAAXuZy7xjDZf6j15VaKGKGNiKklXxkG4FswzhnpKz3LJqNxPfS6B9i2OD8xN52Cuj9M7CYV4I7M422WGhGFzIeiq8HMvzalkvx08xh9llaqP9IymqHVKeFUmUgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=akr/OR4C; arc=fail smtp.client-ip=40.107.122.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qYDOZb3VTgcTry22plJMHU8rS8Xziwx1PWiFvmEvniE2HMAFdavm95kjBvdJGgPiuyxq2iG/rsmCXnbcong0ONti0DrMwF0HHdvAC1HGwNVU6xX+WIZLb1BIU71M1xM9i8o+WBqq3jxg9Mu5n/mHR/7yqM0Ei19hoewxb4JdE5A4dY+JlZQgjyUKbREvWoKTDKwwR5+4iP6pe4S0PZYafOF/5Hdu8g2KTzkRktU64zd5yFKaUZNBmFLf/JQWn2as6CHfaLoMmcNYU4XHecYm35qvRVHrKuAs6MVdd7uEnxlb/lmCkVlBqG2lUNFRAFWzLLLWgs0h69rhlDCicWYaEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLjWABuGfyzdQ2OroRmxlu9nh9Df4HN6Ki/aed8o6XM=;
 b=Qg3cgKwTXPPNW5XpVFq1UQJhJa/RGN6pnorUfWtoBFnqHwso09QjiqLyb4JXA2OvsQuIMsDF+jd7oO2wsyfOVQ1l7D+u8D9M6/kVbyCWt6bJ4LqeG5RnRgyXL/bpRhrHnTRUwOagAt3KYqLAhje0vaeMdrLBKBaMID/eGpYRSgar0C+se+e+A+coLksR0Y1rQL/5Av/42YyjIq1tXwteKwh57B5kX2lRuQXoP39W2x9mbXogkyzTmK9mqg4PxAOs6czOUV4R2dahXy5SSY+6Lj/N/dadRCXVcG8XHNB+zmJ4Y8Q63krqaR0HX1TFLqY+Vo0eXDq4QRACRoUSz9a6qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLjWABuGfyzdQ2OroRmxlu9nh9Df4HN6Ki/aed8o6XM=;
 b=akr/OR4C2RhLF2/MARNVtRx9p9qiiBk7Ry9f+IlklPg1SJ5FT/kal/gBhd/pA8NGYLNLbYEv74L/rG5QGSJAs1qKCfiyYCgfCaopcpmxwQnl97+XTPPFd0VyzQRlr8UV7JmE6/NBZxKA929SabJVIGkrb3ACBOAObB4Pc77tTY4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB6484.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1db::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Sat, 28 Sep
 2024 19:30:17 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8005.024; Sat, 28 Sep 2024
 19:30:17 +0000
Date: Sat, 28 Sep 2024 20:30:15 +0100
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
Subject: Re: [PATCH v7 19/26] rust: error: use `core::alloc::LayoutError`
Message-ID: <20240928203015.2c9292ab.gary@garyguo.net>
In-Reply-To: <20240911225449.152928-20-dakr@kernel.org>
References: <20240911225449.152928-1-dakr@kernel.org>
	<20240911225449.152928-20-dakr@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P265CA0007.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::18) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB6484:EE_
X-MS-Office365-Filtering-Correlation-Id: cca0afe0-22ff-468d-771f-08dcdff3fbb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZH8KeEIaZjEUDD0xprMDa77hHtmKYGxrzYFvvQhwOJ2S3sr1LE80Z1izLPqc?=
 =?us-ascii?Q?SYuEg/sD1ZROml3JpCRB2L6nKTe7mfmtwrqJzjRIJmvfsCuVCSmHckoj1hvm?=
 =?us-ascii?Q?rfKSDKaEx1k+msRQ1irmqFmPCpViCwyQFxNXWqyZf89sm7A2PjsrvULXvyy3?=
 =?us-ascii?Q?ZHiq32p1BUjSvgcnXQeWPIDerqAgC/nCKfBSmz2b2ACHpmYd4IOk2mw6XLrh?=
 =?us-ascii?Q?hckrJBqgSVer13XZMLgKxKX5GfzxbFqpGebZRfOJFBvMfsonqPH4laCRCC+i?=
 =?us-ascii?Q?nkXj3pMXfM706GDXWyjierRVbFVi9cFJt8kiVVzleWwzaAlZJaPnSuIl95R7?=
 =?us-ascii?Q?I//fuxPWEbYF0VP0YkqNAJ8vYwEPpaOv97fegPtFz7tBgN26lvUGCbKtvq0H?=
 =?us-ascii?Q?+eK3q2bUlaZ0TrmtuL2J8e3VuOMRHDccO5pLcp5vomOcR/g+1GBvMfdRVkqL?=
 =?us-ascii?Q?ks9PVSWmN9HCm3CovYbifD8vNuRgmX0lY6Als+oDZIhepiR/UTnRULbgKMPV?=
 =?us-ascii?Q?j7cC7moTmRuEx66sqX0oGMYgLMP1HJ5WK+0zSsZAri5tU+cYVjsAtW0pj7fT?=
 =?us-ascii?Q?bspFyISBNoG+sxfmhYoPcZKzVj8Cv/CeXDz6qGgEzqz2jOggWHTp1a4cUCQw?=
 =?us-ascii?Q?tfqYNp0AbXB3ZxY9Vca/58kLPMARY/ZaZONxDjI//GM0W6LCSLqGRlOCOPTK?=
 =?us-ascii?Q?5V9FQauw0EAw4reFvyxoPorLZ+hl1jpqrIhOyxUVPGbHDHAeheY2DS2ZhTek?=
 =?us-ascii?Q?06BtOyMs0llczaBmeXrvQ8a1IL3Gwi5GaXMNVNtJ1qdo6yL/W1YVibdRg3eT?=
 =?us-ascii?Q?UAF59kd8TleF0HpGdrBUQ3HwUA7L1PpCyb73OppV1WUCftmK7BlpF3m3aIWY?=
 =?us-ascii?Q?R/qjtZlToIP9d3HTg39eagQ0a4BavMM0xZhW93xLMEODB41k4edsPBB/9FOe?=
 =?us-ascii?Q?xXfldylOb+HD/LHhVR6YQbLKxQgQoLG65sDhmp+WJJo+xEQRp9jLmOcVxCJd?=
 =?us-ascii?Q?/vBCW2LRiP1aZOpNPRUuCmmsrUUrJpMtauUYtWKtDgSxxjrmmKBxIfi64Ky7?=
 =?us-ascii?Q?FoqV+6gj50b5tIbIGd2ABGGadn0PLVMXIXWSe1kgK0r1o5AolYXI35kPeegO?=
 =?us-ascii?Q?YIG213gvu2lF4Tk5n+44dg4TIOtR26d0yDF/hhqBDiJTAGl6P1NrmlaTC5Fa?=
 =?us-ascii?Q?MIQfpu+chIrE8MXfab5fJe9pl+R81TbiIlhpSSf6vSSCkacg8208ARHhURLQ?=
 =?us-ascii?Q?AhdzlkYmr2BZEMMbyCKQiT82BpTZCXPqX6A2MSslh4dahzaDkqbCsY9W++e0?=
 =?us-ascii?Q?jG5aH1B14y+q+jtC6lN7gRJ8twfa6/jTUhNrqjVh9ynuXg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GgzB2iKqfbGSiGz+raIrFVRGRJEZ7cuJLZVYdCGvNSt++bUIvWA7vTGlpu//?=
 =?us-ascii?Q?YTlwCfoTxDWFL1it12R1ADGz3D7kIGpIII1cvN1LNUSys7FvHZqBc/4hrXh7?=
 =?us-ascii?Q?CDDHLYWugXvcKQiC62S4v1CEZ4P+nZB+a5rips/t9ypnYgQvObSwngIgE5oB?=
 =?us-ascii?Q?yDOJaXZgOkp1Q2c1rAMqXqaIxQYHt9GXNr9X3dzbzbeyRx0AKiyAy+0uB4RL?=
 =?us-ascii?Q?dGAdStB/QP1XNeS8OezjC9nR72FaC6pqFV8B1Z60JZ+sGXrwAnyzFXB7lAPk?=
 =?us-ascii?Q?uOjoOGZkljH1xe1PkbFCIama1QYwxChzvVVyh+ZGQhDF45BeZwnklfTn/M/T?=
 =?us-ascii?Q?N9nRsOuJsX5zLcqDqHU9IvxwwaEn7FZ5qLYZdsDqtE83bh6iMy3d9YLoK7CY?=
 =?us-ascii?Q?4gOs3lLEp/01nJVLuhwJNIPJhW1ycBeVoukf2rRKFP3hINntsFhJnyvFTWYe?=
 =?us-ascii?Q?Z2fIuKoa1MkzjQhAVtAHBoFBVPzXhThDUmSEgUeeOddvhcb476gkpknfFTTU?=
 =?us-ascii?Q?LqtNnkyKzMSuShFJeIGngeLHzIU/lj7Ryfj3ToXEpUOH9Uo9gmeInyzdE6B5?=
 =?us-ascii?Q?eOdFmE/Pd0x0Qj4sNpg8Y+LA14js2DGl6vtIjGkjIJqI070c3GpLa0Mi0XOZ?=
 =?us-ascii?Q?7LaMlE3MAcwNv2F8jJEWlEWDxWEbY04YBZzcoZAtNzvge+JlOCnAHE6lb7BO?=
 =?us-ascii?Q?TjqBNMkkvMPkzBfFdCQD2vAmIH77e5vna8Sb3aZx+3WUVGvYuBOJqgB5kkmx?=
 =?us-ascii?Q?ww0GUlHYDFRsAYEse9fqZedIfwt1I2EEkbs1NqxWX4ybLdtCSzbi0DII8fMJ?=
 =?us-ascii?Q?mwM6vBunDfNbWYXSu56gtm9Msm0B/HxQRs53Mw2Sokhyr/LOykVVOY9qSJ+8?=
 =?us-ascii?Q?8tnBgarp9EY/hO1btbRnZGnrxI+dOs8t2lamh5A13ig7cu4+9PMoSdbfxoU4?=
 =?us-ascii?Q?DMdcpIowqZk6xNBnrvqRxz3I+C2EUZa7EM06mOyV+RFnTn+9DgVscaJ+WlVb?=
 =?us-ascii?Q?68vmjK4A1GKWhihv8RcCA36E9VbN2awQgaQbs34+v8zWzStMWCHV1+LHcSWA?=
 =?us-ascii?Q?SDPuYUHdru0n7m51h+rYclYzogDoOqKho2JbK0qX5xZcBi6LzE8ITZlfSWvt?=
 =?us-ascii?Q?SKnw87Hj4FHyPPPTzkyMNIECjkwmJxXIsgfH+TYZcM2w7Hfr0VsjznMnQlxO?=
 =?us-ascii?Q?3BO77G/MJmJj+5k/bSuMzX22gb4kSI7iUw1yZiLlXA3s7O46jf5UYmSzIqCj?=
 =?us-ascii?Q?vPt+hnFIFRlVOVDy+oelFL719RIHv1uwqCQwXNd6tvkHPlsRjpVLpVRLLIj1?=
 =?us-ascii?Q?WrAJB5DmSYhJejKufgJJPRZCQNwYZqTUVsrQf+zCqvEcxx7cRi5voF3irM68?=
 =?us-ascii?Q?nHdGccn28Xxw0eNPD6yxlLWUKJ40jsJh8T+P/epXfHd+7vik+T9cIl9T3P65?=
 =?us-ascii?Q?nSo31sS6mCgERFqmCeIvg5lINtpYLxSMvx4noWn1rn2vTIBoLFFN3pGMQekm?=
 =?us-ascii?Q?lv/ofZ5PNhFkTcyOlsxLkAnJCX2EsW7t1illKxj8fp2qn0MT0k7jl29aYhMG?=
 =?us-ascii?Q?ccu34dZnxai3om6REecabFIucyODi5uY9Nt4ht6R?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: cca0afe0-22ff-468d-771f-08dcdff3fbb9
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2024 19:30:17.4022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gph5TxW+37xTTO1+n4/4TqN6ff53qtdA5R3BjGTpB2tj6+eQHm8L83YXCJ3+kjxs/urjrI4RXikgFaA7ZPLUEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6484

On Thu, 12 Sep 2024 00:52:55 +0200
Danilo Krummrich <dakr@kernel.org> wrote:

> Use `core::alloc::LayoutError` instead of `alloc::alloc::LayoutError` in
> preparation to get rid of Rust's alloc crate.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/error.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index 6f1587a2524e..81b4fc5cf21e 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -6,7 +6,7 @@
>  
>  use crate::{alloc::AllocError, str::CStr};
>  
> -use alloc::alloc::LayoutError;
> +use core::alloc::LayoutError;
>  
>  use core::fmt;
>  use core::num::TryFromIntError;


