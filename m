Return-Path: <linux-kernel+bounces-346495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E30D98C54B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 826461C24A3C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20C51CCB26;
	Tue,  1 Oct 2024 18:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="NtIPlh1O"
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2103.outbound.protection.outlook.com [40.107.121.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46024321D;
	Tue,  1 Oct 2024 18:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.121.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727807215; cv=fail; b=ky6N//LlydeGgx84FCC0hVntmvtmsTq9MzSW7P4aWhfXzEItKQVmaDEPtaIM4pHNvde87RbxwdyImSW1hqCVmWxsmhYW3c6NdEL2U/niOoYWIix68e9fi0eItgnxJM65j3lMo6eDxLpxx8B5FN9DRuMOJhF9nnZVp0Mz+RHdUR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727807215; c=relaxed/simple;
	bh=gkgVwDXPCOOy3fMCsMDKHJTinkyK2cq48HV0j36GjA0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZTBRioLuwCTeACB1OgkQ6+t/fGcWmu1XzAJnrXC146IBeNHTkNGjb9vGkKkF6i0gc0xy2hnGLAPj6JkXCtOyf239FD2J4ak5ts9j6ETR+tRTcMXjm4ZawCFvqfRP2rYenZX+j3oxVwYcYFyD3VX1JW0uNN8qZeLmDvMWNAHwgzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=NtIPlh1O; arc=fail smtp.client-ip=40.107.121.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4NurdCwZHdZ1yFP+8BxNGz16fIXc7CVfC883BKFSdZRQ/r7XUZyfPzn0E5B14xt7+k6QVD6KHiRa+YP+b5HFQ4enKUY4WAo5kzkz2c9HvVAhxh19hs54HSyUVvVuq9WW7nBdVN050FXY4AK/MIUQkaUP4s8K3pUYAo5jGbcBYVfIEn+7P21xAp9uXjhsqLJtICymg5f7Gqwx8zRJ9TdsQeRDO0zWX+yRpn66lXG/mKvhcWQbUgWj1WItNwwShFB+Rol2obC6rrBfyIWG/F2pR95A9aNpJOIDT85B8wzPTSfFU4TtvZsZd+5zC5to9LgKa1k2Cmle9qyzeWXHxG/AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVvu98EwZP+B+at/XjqVO/xilwz8edCC64+co2kbfJw=;
 b=d6wAXnbXkdnfKgwPOGOyPW3I/q1Xi5xAaOsOPVW2zU8uCswR8pTEt2DQvSMmY3fg/jH629fa+5iWBx1rOu2b/y9gmUCIP/gqxtDOOQ6lMHOLUx2yCZWaZksL5fmkC3Odb8xzsDhscCKIRei8cj6lX7gPC5b3vS/TH0v4qJFI4u3/IEuCbbMWdMXHwSi+fE3jh/0yFi68sBkB7tIIsvPcoVKLCI1SB66FCy1l2Twh3s+JOgtCgQp30Ne8aCQNmwXkY46mWLood7B8VlluuR2DDYJltMgPVF09ib8QIucQUcQIctt5863xJS+D+R2zbGi4rzEs7jrjIHgDC/fMb7P50Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVvu98EwZP+B+at/XjqVO/xilwz8edCC64+co2kbfJw=;
 b=NtIPlh1OMFPgY7wBBpfsq0Qv8CWxnS+Zr8si6CDSEwMUeDOc+f3ZwlcAwI+RzTmCjQS9PTGa1k0bIhpLWOBw3pOeNcT5fZL+aUMWe8ptiO0zX9IZcCNdVEySJX5x0KyK5CDBKWqkHz1c/dL06cD6rBq4y0z2cIBO1P7BskFkxGo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO9P265MB7730.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3a2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 18:26:51 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 18:26:51 +0000
Date: Tue, 1 Oct 2024 19:26:49 +0100
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
Subject: Re: [PATCH v8 08/29] rust: alloc: implement `Vmalloc` allocator
Message-ID: <20241001192649.11426896.gary@garyguo.net>
In-Reply-To: <20241001150008.183102-9-dakr@kernel.org>
References: <20241001150008.183102-1-dakr@kernel.org>
	<20241001150008.183102-9-dakr@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0201.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::8) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO9P265MB7730:EE_
X-MS-Office365-Filtering-Correlation-Id: 8329cb52-94ec-4d61-c1db-08dce2469e34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h78eX0yR8LfUuxHjmjplc5gNJ30c/ALEq9n1rc3pJmz0xBPxr8+HBuZEJZ0T?=
 =?us-ascii?Q?CNoYMpkjHpI+tdqbElO0FAReloETnCA9q2bESLRiIX3XzRkD50U+kAdHZnqy?=
 =?us-ascii?Q?IyiKC8rzjSoo+wKxQAh1dpogLYEnInybvz+vpAckbEouVvd7A/u7iBBQnLK+?=
 =?us-ascii?Q?+C8EONIEJZ8vzqlXadMsZgyZW/gZ/qfil/9s4OoSjBVCoEbHiz5Lr2cck6OX?=
 =?us-ascii?Q?OG9yiaSdBdlTfu18RkO4qFvt9HIJh9OlacMWTySI9xUMYt6a0jPMvOb2q1Mh?=
 =?us-ascii?Q?p+mcwdNUnabvOuoDtBsEKzptI/vsjANyoJOJjv7DoDYlMCnStp/N+1g0sK5G?=
 =?us-ascii?Q?TH9T80xbMjLF9dicMNJolOwJb+4Jycb9yoRrcm8GECd/tcA0Q/uy0PQjHnFL?=
 =?us-ascii?Q?NfO4mAyGJ3rHIl47o3b4xm4QjlzAm7zZFK51RbseTuVkEljtbl47laHTO7c0?=
 =?us-ascii?Q?eFK3uj/EEEmUbqiNHv8sj3Cq3k15ej2Sy56GJp9Kn50MMBgBa0VX84tXd43E?=
 =?us-ascii?Q?lTQOpxCv22nTH6tQjRKgOnAhVNIbFx7R36eUHEqJdO2qX9oBhJC4mY1Lfo1N?=
 =?us-ascii?Q?/f6lh0zqo2GmDvw1d6JGo5eWn90PUYlM/l95Oe0awXyQOVYDmG9KHdgUDLYC?=
 =?us-ascii?Q?PxsEwCKwYWZX30E8/CjefzaszNZVXpcrBmdGY2XIsZfbmmDypw/XBFOXoacR?=
 =?us-ascii?Q?lLg5d7uSL4QdFsgn0+wTTM5t47eSN50Xdq5btC9tPHkd2o8qa/Oa76cuaUBM?=
 =?us-ascii?Q?lRI+i/mVT1HEQuYhSkcGtFkhcp1Ilw2n5tiVQgG294N4RmpRJ5zilsHJyass?=
 =?us-ascii?Q?kb34C1HjC7+0gJZ5ZUW2dsKifab+AvebESmJunHZGFbskqOFmVT2m+pWwoRm?=
 =?us-ascii?Q?6yKaV2xNNK3Gi1AV750YsP5QnLKURl0tjGu13ilPHrzkH0NUsQ+FgJ1IVGxT?=
 =?us-ascii?Q?j1kv7Y9jJ1oU4YYAb6CdVg1vB3MkAvEUMe/LFmsyeSDPDIO5uDhQ68r4C2aI?=
 =?us-ascii?Q?bRbirHXg71BmU29a36V9jPzipRAdJ6tr25UMkMoOXk3ELRCfn5pGnXHdkMXX?=
 =?us-ascii?Q?5xzXtpHbJxJbwc4mqllwWaCeHmHnUKdMnni9GM0ycfQe2HNcDqOCT/6NfyYX?=
 =?us-ascii?Q?o5V+mYQRYVItxW/5+8c4iCT7+Ln/vCfY+tjRDOdf/WYBXHwEBQhAi3vgEJ9b?=
 =?us-ascii?Q?N4O7YBbJ3RUkzE2pTgN/Aq1MuUK8TEyh01Gxti6Og9/uyud+v1x0m37rkG7x?=
 =?us-ascii?Q?zcgP4kDGa3eu5dzIzG/sHO0cs/y8y6wbSOtWwavVog=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pu7bUggpPNcP2WTRMz7JKKiJKXMhKdbnBftImjstV7CzQrs1NW6+XufeYvIT?=
 =?us-ascii?Q?ZCnAcBQ1qOeSQ6IwF7A5Oa4k5usi2KHhyhUndxg19TM9QEOVraua0hvedCon?=
 =?us-ascii?Q?AE29/gMI/k2/RVf1A+GhroKXtZOHhWfewH6uhNB+79DtaAsU4zMRBn+4ISqz?=
 =?us-ascii?Q?qmwZjemxTLlUxD7I1JCG5jg2FpETZeA2ivz4kTEe5zNQspiCYoBEwbVZvb/u?=
 =?us-ascii?Q?8GCC3nnsIcWJNYOY4emILpNSTkW/+bYTGvgoyonqkG7cTpA0IHZ94k8GLG9J?=
 =?us-ascii?Q?tuzdhetOjcZg1mEb686Ovg+UwCR20NxtcXNDN9Lby0f/TMHxMukjPYYSLwLU?=
 =?us-ascii?Q?Lp8LYQ4iET4YmGQNbjgR4RMXQ9tAAzRLxXitCeRk51BSpSSkSsfj4K/djYD1?=
 =?us-ascii?Q?g0FKQLtB5E9Ch2NUmGGW3UYOZSyIY9UPm1zmRVvXRhGcJkDw+XGu8cS6yCIB?=
 =?us-ascii?Q?ETFJZr7LYrW6qQQpmwZs2sOLWIpEXE040fgTp8Nm0IHXne/jOfgmK3lkMCs9?=
 =?us-ascii?Q?AYYondg6+qQVtoVP91Sfd/MXAimrOi0Vu+aBy8QRNxV2yVU95lgWlbyrXer5?=
 =?us-ascii?Q?111RG3Dj9voSnDEX2pnU3cWWz0DUrf8aByY2X1WU097oWjSP0i24biIdIoeD?=
 =?us-ascii?Q?SZKAlp+v8JfzBttMCP3tf2HNhLX9YZSu0fYZ4PbSZIAU+HarMITvv03wnONd?=
 =?us-ascii?Q?446cQVgWkNzdxueGQFny8j6PVKbVi0oLPS8LJRB2B9wqpNiyJgT8zt63Fqt0?=
 =?us-ascii?Q?EfEr3gBSCUnQ+7TeLGR7ZeZfxf6jQrAPfriPtotFDM2SB6sOKYygEiy92Gmp?=
 =?us-ascii?Q?DlGF0r71qbRM1g0aUelrf4vb4yhJhfa7iVUXuadCx+DiMsgRE7xJAh/JXNK8?=
 =?us-ascii?Q?yQDf2d68IkcD440fxhe92okJgM6TU+yRIqpM/DjAts682d9rsHAfF064KaFs?=
 =?us-ascii?Q?9+RnEbrfeVvarMtdTFXkMfK2tQZzRX1OY0ZsV4bQRaoMcXM79lO6S4v+9+1x?=
 =?us-ascii?Q?OZYTrSvDEWHb78BTJSSdbBRtIOXf/DusX8HAB192B2jshCgEOrfSUdaoZ2qa?=
 =?us-ascii?Q?sDiZZweppFx/yEt+0RUBo5O2pRWh+4olda/QOPtBUjjbTMKYc3su/7BLzZgz?=
 =?us-ascii?Q?mhl9kDAy+hC5L3ObLlo0uUmN8JhcOpYU5+vQzPrT01k/1sytfebfQuKZc1iq?=
 =?us-ascii?Q?QJYz5TpnMhMxlGxvkPqLeNxNgzDZGvbU7y7V502h3aBgZXHRRk6t/tS5CDnr?=
 =?us-ascii?Q?CpS8afTIkrywnAaYLKCkjEQM+53Hj+K5UNS/vVG3f2DfoSyhcL9Te9HZOh0r?=
 =?us-ascii?Q?rT2nH8uLTG0ZBRWv7Udv3tJ9rlD9JvwdxcOXQ1T/5FzKYlIyfLEQmrY2jJus?=
 =?us-ascii?Q?88qg7QVsAI11ioCWyzN7g3uXb/Pqn3702Q63uLdtxEGiNNWnzs9mlFoiouSK?=
 =?us-ascii?Q?Fn5TXMeHg0tpGiH+yJhlDXd7deiS1jpC+NhzzLiQIxoQ27yteZRf3Hbp36DS?=
 =?us-ascii?Q?EvbzONyNC9Bz25Na/TD7V7Yec2Vx196uf3C8/l9DsjQXDH4G2AvpCCDn/Bls?=
 =?us-ascii?Q?uZQdfxXdGi7OeReblFLpHMiaqMTc0klois4Ra336?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8329cb52-94ec-4d61-c1db-08dce2469e34
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 18:26:51.0753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uTrJ7BVGRZ5qEIDbYHmgKVVCp+affszW+B4EldlCRXI+nNap/6m1seoxRRAa1k8q+6rSdWPtl/RVG2niaUbaVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P265MB7730

On Tue,  1 Oct 2024 16:59:43 +0200
Danilo Krummrich <dakr@kernel.org> wrote:

> Implement `Allocator` for `Vmalloc`, the kernel's virtually contiguous
> allocator, typically used for larger objects, (much) larger than page
> size.
> 
> All memory allocations made with `Vmalloc` end up in `vrealloc()`.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/helpers/helpers.c              |  1 +
>  rust/helpers/vmalloc.c              |  9 +++++++
>  rust/kernel/alloc/allocator.rs      | 37 +++++++++++++++++++++++++++++
>  rust/kernel/alloc/allocator_test.rs |  1 +
>  4 files changed, 48 insertions(+)
>  create mode 100644 rust/helpers/vmalloc.c
> 
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 30f40149f3a9..20a0c69d5cc7 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -22,5 +22,6 @@
>  #include "spinlock.c"
>  #include "task.c"
>  #include "uaccess.c"
> +#include "vmalloc.c"
>  #include "wait.c"
>  #include "workqueue.c"
> diff --git a/rust/helpers/vmalloc.c b/rust/helpers/vmalloc.c
> new file mode 100644
> index 000000000000..80d34501bbc0
> --- /dev/null
> +++ b/rust/helpers/vmalloc.c
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/vmalloc.h>
> +
> +void * __must_check __realloc_size(2)
> +rust_helper_vrealloc(const void *p, size_t size, gfp_t flags)
> +{
> +	return vrealloc(p, size, flags);
> +}
> diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
> index 4f3c3ab7c7a2..f341e9ed5b7c 100644
> --- a/rust/kernel/alloc/allocator.rs
> +++ b/rust/kernel/alloc/allocator.rs
> @@ -15,6 +15,7 @@
>  
>  use crate::alloc::{AllocError, Allocator};
>  use crate::bindings;
> +use crate::pr_warn;
>  
>  /// The contiguous kernel allocator.
>  ///
> @@ -24,6 +25,15 @@
>  /// For more details see [self].
>  pub struct Kmalloc;
>  
> +/// The virtually contiguous kernel allocator.
> +///
> +/// `Vmalloc` allocates pages from the page level allocator and maps them into the contiguous kernel
> +/// virtual space. It is typically used for large allocations. The memory allocated with this
> +/// allocator is not physically contiguous.
> +///
> +/// For more details see [self].
> +pub struct Vmalloc;
> +
>  /// Returns a proper size to alloc a new object aligned to `new_layout`'s alignment.
>  fn aligned_size(new_layout: Layout) -> usize {
>      // Customized layouts from `Layout::from_size_align()` can have size < align, so pad first.
> @@ -63,6 +73,9 @@ impl ReallocFunc {
>      // INVARIANT: `krealloc` satisfies the type invariants.
>      const KREALLOC: Self = Self(bindings::krealloc);
>  
> +    // INVARIANT: `vrealloc` satisfies the type invariants.
> +    const VREALLOC: Self = Self(bindings::vrealloc);
> +
>      /// # Safety
>      ///
>      /// This method has the same safety requirements as [`Allocator::realloc`].
> @@ -166,6 +179,30 @@ unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
>      }
>  }
>  
> +// SAFETY: `realloc` delegates to `ReallocFunc::call`, which guarantees that
> +// - memory remains valid until it is explicitly freed,
> +// - passing a pointer to a valid memory allocation is OK,
> +// - `realloc` satisfies the guarantees, since `ReallocFunc::call` has the same.
> +unsafe impl Allocator for Vmalloc {
> +    #[inline]
> +    unsafe fn realloc(
> +        ptr: Option<NonNull<u8>>,
> +        layout: Layout,
> +        old_layout: Layout,
> +        flags: Flags,
> +    ) -> Result<NonNull<[u8]>, AllocError> {
> +        // TODO: Support alignments larger than PAGE_SIZE.
> +        if layout.align() > bindings::PAGE_SIZE {
> +            pr_warn!("Vmalloc does not support alignments larger than PAGE_SIZE yet.\n");
> +            return Err(AllocError);
> +        }
> +
> +        // SAFETY: If not `None`, `ptr` is guaranteed to point to valid memory, which was previously
> +        // allocated with this `Allocator`.
> +        unsafe { ReallocFunc::VREALLOC.call(ptr, layout, old_layout, flags) }
> +    }
> +}
> +
>  #[global_allocator]
>  static ALLOCATOR: Kmalloc = Kmalloc;
>  
> diff --git a/rust/kernel/alloc/allocator_test.rs b/rust/kernel/alloc/allocator_test.rs
> index 4785efc474a7..e7bf2982f68f 100644
> --- a/rust/kernel/alloc/allocator_test.rs
> +++ b/rust/kernel/alloc/allocator_test.rs
> @@ -7,6 +7,7 @@
>  use core::ptr::NonNull;
>  
>  pub struct Kmalloc;
> +pub type Vmalloc = Kmalloc;
>  
>  unsafe impl Allocator for Kmalloc {
>      unsafe fn realloc(


