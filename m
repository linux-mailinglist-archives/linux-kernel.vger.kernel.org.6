Return-Path: <linux-kernel+bounces-342638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA8A98911E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 21:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E2421C21B3C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 19:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CE515C139;
	Sat, 28 Sep 2024 19:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="po+sEuXS"
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01on2097.outbound.protection.outlook.com [40.107.122.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3FD17C95;
	Sat, 28 Sep 2024 19:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.122.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727551734; cv=fail; b=LuAWc5RFEZbl2VIqf6aQ0FtgHBg+WuyyqMMXxEvDdaIzxmVIofF6YgvQqAiZ+TwUBALUQkQ+RYKSstLNjmlMezGxidmblLkS1Y8CacD1yivZgtWvv2Y18WYrXTZnp8Ux62BsKsE+v/2JjDZcNwYvvbVn3HKH77MDzCTVbmUfYZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727551734; c=relaxed/simple;
	bh=Tl6tc5OeFwsqcnbUJyBVxTP9D43FLCpTATL6AfJ9U3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ryLuCqaGdgafqw/yO7EoHJw32OME0IKn64ouKHUbf+4KD9Nh09F/mS/1wRNUEBzzv8xBbgLI93XLW89y/WlsczyXS/ITp3LWahInJLVJQTEtEBJe+SG042MLcY30f6sSefKKRf+qUKSYIt+dwnPrmvQtBQJJ+j9FWSyPEj8FxkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=po+sEuXS; arc=fail smtp.client-ip=40.107.122.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JceUs/N63fzNfMFubHQ3FukqepJFYG3rFfXi0F/2iMDLHAY4BvOJPD90vruW8qLTdY99NxjsXfhH/396YPJzQ5ok4dXlkYgKhEvy0PSOjvf3vctamthqAEZZv8TJMQSydZcdsVrJ0ynDXTB5EChuDM1Nfv/wpSnRRLavewVVYVAJUvDCJX3GGpt5j//kDa64mMqUJSf7ke6wmCmhvG8H5ohd32UcyTKE5eG7KEIXCSSgVFNFNT8QQWxge4EMKvn3qnjaKQ8LpJN1NYFV5JC5A2Y88uwvTx3SY3dkuWWRHr5KFuZpoD3XjWcWhR9Ds3SHIAYFn1p/Xpn+ykXjDfL2QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eOhyrA5xSBcYrQ6XYTQAj6Uw6oxdHlDRARauLKi88Ks=;
 b=re2I0XGB3tzVIf385RZJdJmmFFng7im0RWFNim3r6oMFSFb6KpYjRrRafh8QuRSBo8FXzps4RILESVmH9Gkb+7qR5/2Ku56VdwgGnfwdyrn/CngaHQuVs8t+Qd1AL0id9VR7vNzRtztNXPxo/UoY2NUAs7S9+5+tGmiKIYIGxRQuylo2b5lifoAQxYcl0zfl1uyl/t4COd0uBedTS38cv0zAdxBIYZA31J7wPNq2bJ6/l/yG+Nk1OvahFcnnkFYzB7DjpMM7Rfmsudci5atvm+ne4LXGBNQxkmd4oPRTZUGzjy90zOqsKfZxovPz30oyXtcbYqCq397qxOIDuTyBCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOhyrA5xSBcYrQ6XYTQAj6Uw6oxdHlDRARauLKi88Ks=;
 b=po+sEuXSnQclXaVcxxsfpW/oeMTDxHvef2OkLyS8escOQ8ItGkVZ0nWqbu78OWOXi4TlYEPUReINeteGY3O6Tz6mzi4Api9xSaU8eO1jslQOeFvae7EmFbYO5ODVPdXWe4tgJ6TNkBxc3nxoiiJeSDJb+lkoRbQVaYhqRI2zRW0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB6484.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1db::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Sat, 28 Sep
 2024 19:28:50 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8005.024; Sat, 28 Sep 2024
 19:28:50 +0000
Date: Sat, 28 Sep 2024 20:28:48 +0100
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
Subject: Re: [PATCH v7 16/26] rust: treewide: switch to the kernel `Vec`
 type
Message-ID: <20240928202848.2814f387.gary@garyguo.net>
In-Reply-To: <20240911225449.152928-17-dakr@kernel.org>
References: <20240911225449.152928-1-dakr@kernel.org>
	<20240911225449.152928-17-dakr@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::7) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB6484:EE_
X-MS-Office365-Filtering-Correlation-Id: fa72fcb5-956c-414f-1642-08dcdff3c7a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ax0T0Te1YLnUu+J3fR6jtHvKxmlFOWVUlOuHc1UBuPmo2MIChraudzog9fBd?=
 =?us-ascii?Q?19qEQD4hS79YRgf2BRQAUswlq4MN27DsbpSzWy83GwvyOO6H7fLe6TXijTW8?=
 =?us-ascii?Q?FyYanLsL9gL850hg5LKnSyt5LficVtLtYpgCiW8cOp1u/T3hW8C+1g06hB5e?=
 =?us-ascii?Q?D3KxgH/jJ2yV7dBDfsXXMF7bSbyRONAjGnebs5E5pFp89a+euBHkI0EiSqpW?=
 =?us-ascii?Q?a+3GDyOKusmzZR/EuJ4/EPLIvDarjkTOmPEaohbRL0ImfA2SHEzK0GRPmJnd?=
 =?us-ascii?Q?CDnnrI85yJLd2AA5hDgBgui0o4P1opHR/Z+iOVba1bXWogPgrnv+G0gUts98?=
 =?us-ascii?Q?vSBFD7/FjBBOCr7SbhC/4VIEG6GxO75eGmq8DTIo/PXOj4Y9/f1xN6ApENEw?=
 =?us-ascii?Q?y0xESAJyaTN1qT0QqM5COIvwolUWYp3f5RoEbqW4Sosx1RPGDf2gpgu1aYC9?=
 =?us-ascii?Q?/G2Whkh69SFXWTKBfNZG1wpqEY4cr5zThs/6IzBDjomYj3acA34wMoPaO1KQ?=
 =?us-ascii?Q?Q+gclaKKk5H24IqcAehGOSL6OVcY4LVqAEqEA5oFvM2iNHQTupMSdDGgfILQ?=
 =?us-ascii?Q?YktRAUmooHGUWijERZX/WvpANkbKeYFuT+H0dS3DADvBbgKQK5MysGENbw9V?=
 =?us-ascii?Q?hjb7zx1qRGtXfYMmOxZUtZpivvlIPJgRn9Op5TLUcZf2cfYGGPC8Yt1GACnx?=
 =?us-ascii?Q?OfDJa9TKlk2mx3GKh1aJsBXHodS+xjzn3EZQyAHTb6fzJg43Xp0rYtOYkc4o?=
 =?us-ascii?Q?jNL5WTJpujXmNzT6HQbqnnvqaP0t/yWe+R8TDMFjFYDxwSH1GJOrq7H1xahz?=
 =?us-ascii?Q?m7EuPLxL1RgZb6jJdlDcUNznp8puhMeKx1USiop/FOj1VvsCI+OqLCZqnt/x?=
 =?us-ascii?Q?WQiOm1TKFZTJeDQKa24gltLmAYB7Eeyc9UED2Z8ZRW1RBWhPiaZJSx5nMzmx?=
 =?us-ascii?Q?wrj04KsIDlUgcM+Ss7Wdolll3Cc227N9N5YtNsM77/i5XTXSub1B5vyTBj0a?=
 =?us-ascii?Q?WY7iNMSgWYkx+vWewutJN4BtR6m7IbqekGCnogEfYDG0X+n+4WXPSFrxaDU8?=
 =?us-ascii?Q?XzV739tB6zKNZwJecqU68XgO0THtB4gp21ghKhiwFfomN09/SzBObtOJ1TN+?=
 =?us-ascii?Q?T8Rk8Ivw7dqk51zGS7mpE3gCskWTtZJqnkLo0aae8dHTWX9rRlTDh/iRs/cp?=
 =?us-ascii?Q?QHAp+WbKKVVubAy5xIGIThIr56KaeFhpieJHGhlP4YD6gHKz5DHzyyKPVu8b?=
 =?us-ascii?Q?o1RMAXU3LPCCRs7XsNYtSQiK+V9R5G3iZkw3UTg2cuBIsrh3Sl4HwzLzr+ve?=
 =?us-ascii?Q?kj9ui3jOF49X5xedDJEUGjai66jz2ksmuiywsNPAFPafMg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QkwLQ6kxThpkyoYTUtbaOTRTY+dxHVqAGQA+xYWLczFF2SHy29SFk/91CmOY?=
 =?us-ascii?Q?SeSCjP6xiTVfr+SXilGzgk99o9mKIpMf2Ok0djCI2OVamwzh3mSokV6Dhra9?=
 =?us-ascii?Q?x0iSiLcLIUsR0yv16jnEZW0IxHvxJLC+LtuG/PYWz53lGrOrZGNL6Jm5ofkD?=
 =?us-ascii?Q?m/SR8MWLP3hi8w5aJV+JT+Th2CNzSyLCynTYpzc6s9icvqOImWk6CRoGXB7h?=
 =?us-ascii?Q?VGqJFPZ66yMbDW8BdyvWWw5u5Z4WXyUDkZ/cNUYaHofyt8BUIwBwGjmt6ymB?=
 =?us-ascii?Q?gz+sRp1QwhhU003xZWIBQfLUaIKlv6ztKylWXETO0DbSoDYA1NSnEdyXcxPr?=
 =?us-ascii?Q?sZ7kwl26pAQIaUmeyW7FHBvUYj0FQhHF9ARhZIXiBjnwW4gUCnRYrzfIwd0b?=
 =?us-ascii?Q?vZ2uma9ifyTFFPLkTZfPo8enAFc/wpLq7mNvmRXp8K+AjPmfa2xJlY7pim76?=
 =?us-ascii?Q?gOB7JzP5nAe3HPx+tpt0dOBuB0d/vrnqBgS9SzXtVfxCCjW1CJe0eJTHvANV?=
 =?us-ascii?Q?WG6qyXFwY5Yrc19SK6OFjbndt0GbOGkt0lAwr49mJ3m4Z4tuDXu4LZUe5zC6?=
 =?us-ascii?Q?bQUXDIns52KHcIhw4VlKChRnHIW21NP/rtZ0qsS1KrjJuyJ8WlfDE48L+sBN?=
 =?us-ascii?Q?EdWyprhN96vSzgp+r0EgvQFxKD2A7hA42Pz+K5NTdFXoJo56TjH8MMcsxXxJ?=
 =?us-ascii?Q?SwjiK0HmNLgLRWbVFfzTMw5ttfMhU4TXqnpLy9pfxjZWSSY9F4qLDeJ3LEBa?=
 =?us-ascii?Q?nbg/4OdRD+k/1fGa/ZDfKSCZXJlgPQJqOa4MDGhhvaZW19tl79u5MTQ8BkBX?=
 =?us-ascii?Q?HYd0Fn0c8w2MtbANsW9iN7AGpvwm+3sqgfIxZeNHTIkjjghCvwZt1DdYV5E5?=
 =?us-ascii?Q?rcgMvmmKzNU4Ka4iVsjnI9i5A72DF+5EmJo4XggcejozlLTwWZnHL2YI9DQR?=
 =?us-ascii?Q?Ic7RkA9oJmhNNNbIF7bY/eBdwACpMLrLTRpPGYh5uXvFZg/sGLGk91NFMaV2?=
 =?us-ascii?Q?UvjD35/lkQddPh2EcMSZJstoEzXxjOgmcOpF4FUaUYMqBqC3PXYG9f4trWTg?=
 =?us-ascii?Q?g5CQoYR6YI37+8bevexAhyyLTGSFzar5w/7XITPFUML1R0t+AD9hPNZGQQv4?=
 =?us-ascii?Q?3q3a6rkmRTuTS4qp2O0oD/c2YadHQOPWsjCNNRSLnfDsD45qTq/YVwB+ciRr?=
 =?us-ascii?Q?0Y97hEJOXpmxLm8nfFH4aY+/rpOV50odX9O6so+OZsEI+T23ZBZnU8llPeUY?=
 =?us-ascii?Q?L9/hW64OpDsSfOx4JF/tFWsQImq6fbQfqV+pdrx8NmO1rW5C/4/wasFeo5/+?=
 =?us-ascii?Q?NHijCyQqNnbics8aERM6Es+ZXXyPnC17vZCE35V5cRUSeA3oJ5axHXRsj/xh?=
 =?us-ascii?Q?uTyiicIgwakZCtOHEWYgc1NCoUk3pOeHLnz5d/CQziZQHoczBO4L8+sE25ed?=
 =?us-ascii?Q?7imS3/w6I5LDrs9z+FpOMCL4hOXrwxbNoX/jcvWewHM+gfkD42vLyR3s3p2U?=
 =?us-ascii?Q?djoWO8HzSZAvEqPgszLAPmPPyDuyd+P8WwCaW9NmNMZ/9pp2sJs61TQVkOi6?=
 =?us-ascii?Q?fLmOVfIYZwZRm8XpVU49gHWVa0RV/2oxaXPF5SOb?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: fa72fcb5-956c-414f-1642-08dcdff3c7a4
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2024 19:28:50.0367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: piRBRLrkCEk4YvfJ7oxL5Ux6DmpWWAVtdb4YgOezZo580Nj6CCQvAkDGZTbkzTxx3hQDyMrT4UJD51tMeg30Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6484

On Thu, 12 Sep 2024 00:52:52 +0200
Danilo Krummrich <dakr@kernel.org> wrote:

> Now that we got the kernel `Vec` in place, convert all existing `Vec`
> users to make use of it.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Similar to `KBox`, please add in the commit message about why `Vec`
doesn't have a default allocator type.

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/str.rs            | 12 +++++-------
>  rust/kernel/sync/locked_by.rs |  2 +-
>  rust/kernel/types.rs          |  2 +-
>  rust/kernel/uaccess.rs        | 17 +++++++----------
>  rust/macros/lib.rs            |  6 +++---
>  samples/rust/rust_minimal.rs  |  4 ++--
>  6 files changed, 19 insertions(+), 24 deletions(-)
> 
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index bb8d4f41475b..209ad1bb1a49 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -2,8 +2,7 @@
>  
>  //! String representations.
>  
> -use crate::alloc::{flags::*, vec_ext::VecExt, AllocError};
> -use alloc::vec::Vec;
> +use crate::alloc::{flags::*, AllocError, KVec};
>  use core::fmt::{self, Write};
>  use core::ops::{self, Deref, DerefMut, Index};
>  
> @@ -790,7 +789,7 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
>  /// assert_eq!(s.is_ok(), false);
>  /// ```
>  pub struct CString {
> -    buf: Vec<u8>,
> +    buf: KVec<u8>,
>  }
>  
>  impl CString {
> @@ -803,7 +802,7 @@ pub fn try_from_fmt(args: fmt::Arguments<'_>) -> Result<Self, Error> {
>          let size = f.bytes_written();
>  
>          // Allocate a vector with the required number of bytes, and write to it.
> -        let mut buf = <Vec<_> as VecExt<_>>::with_capacity(size, GFP_KERNEL)?;
> +        let mut buf = KVec::with_capacity(size, GFP_KERNEL)?;
>          // SAFETY: The buffer stored in `buf` is at least of size `size` and is valid for writes.
>          let mut f = unsafe { Formatter::from_buffer(buf.as_mut_ptr(), size) };
>          f.write_fmt(args)?;
> @@ -850,10 +849,9 @@ impl<'a> TryFrom<&'a CStr> for CString {
>      type Error = AllocError;
>  
>      fn try_from(cstr: &'a CStr) -> Result<CString, AllocError> {
> -        let mut buf = Vec::new();
> +        let mut buf = KVec::new();
>  
> -        <Vec<_> as VecExt<_>>::extend_from_slice(&mut buf, cstr.as_bytes_with_nul(), GFP_KERNEL)
> -            .map_err(|_| AllocError)?;
> +        buf.extend_from_slice(cstr.as_bytes_with_nul(), GFP_KERNEL)?;
>  
>          // INVARIANT: The `CStr` and `CString` types have the same invariants for
>          // the string data, and we copied it over without changes.
> diff --git a/rust/kernel/sync/locked_by.rs b/rust/kernel/sync/locked_by.rs
> index babc731bd5f6..b94517231fcc 100644
> --- a/rust/kernel/sync/locked_by.rs
> +++ b/rust/kernel/sync/locked_by.rs
> @@ -43,7 +43,7 @@
>  /// struct InnerDirectory {
>  ///     /// The sum of the bytes used by all files.
>  ///     bytes_used: u64,
> -///     _files: Vec<File>,
> +///     _files: KVec<File>,
>  /// }
>  ///
>  /// struct Directory {
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 53d3ddc0b98c..bf1a96d5e1f8 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -135,7 +135,7 @@ unsafe fn from_foreign(_: *const core::ffi::c_void) -> Self {}
>  /// # use kernel::types::ScopeGuard;
>  /// fn example3(arg: bool) -> Result {
>  ///     let mut vec =
> -///         ScopeGuard::new_with_data(Vec::new(), |v| pr_info!("vec had {} elements\n", v.len()));
> +///         ScopeGuard::new_with_data(KVec::new(), |v| pr_info!("vec had {} elements\n", v.len()));
>  ///
>  ///     vec.push(10u8, GFP_KERNEL)?;
>  ///     if arg {
> diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
> index e9347cff99ab..bc011061de45 100644
> --- a/rust/kernel/uaccess.rs
> +++ b/rust/kernel/uaccess.rs
> @@ -11,7 +11,6 @@
>      prelude::*,
>      types::{AsBytes, FromBytes},
>  };
> -use alloc::vec::Vec;
>  use core::ffi::{c_ulong, c_void};
>  use core::mem::{size_of, MaybeUninit};
>  
> @@ -46,7 +45,6 @@
>  /// every byte in the region.
>  ///
>  /// ```no_run
> -/// use alloc::vec::Vec;
>  /// use core::ffi::c_void;
>  /// use kernel::error::Result;
>  /// use kernel::uaccess::{UserPtr, UserSlice};
> @@ -54,7 +52,7 @@
>  /// fn bytes_add_one(uptr: UserPtr, len: usize) -> Result<()> {
>  ///     let (read, mut write) = UserSlice::new(uptr, len).reader_writer();
>  ///
> -///     let mut buf = Vec::new();
> +///     let mut buf = KVec::new();
>  ///     read.read_all(&mut buf, GFP_KERNEL)?;
>  ///
>  ///     for b in &mut buf {
> @@ -69,7 +67,6 @@
>  /// Example illustrating a TOCTOU (time-of-check to time-of-use) bug.
>  ///
>  /// ```no_run
> -/// use alloc::vec::Vec;
>  /// use core::ffi::c_void;
>  /// use kernel::error::{code::EINVAL, Result};
>  /// use kernel::uaccess::{UserPtr, UserSlice};
> @@ -78,21 +75,21 @@
>  /// fn is_valid(uptr: UserPtr, len: usize) -> Result<bool> {
>  ///     let read = UserSlice::new(uptr, len).reader();
>  ///
> -///     let mut buf = Vec::new();
> +///     let mut buf = KVec::new();
>  ///     read.read_all(&mut buf, GFP_KERNEL)?;
>  ///
>  ///     todo!()
>  /// }
>  ///
>  /// /// Returns the bytes behind this user pointer if they are valid.
> -/// fn get_bytes_if_valid(uptr: UserPtr, len: usize) -> Result<Vec<u8>> {
> +/// fn get_bytes_if_valid(uptr: UserPtr, len: usize) -> Result<KVec<u8>> {
>  ///     if !is_valid(uptr, len)? {
>  ///         return Err(EINVAL);
>  ///     }
>  ///
>  ///     let read = UserSlice::new(uptr, len).reader();
>  ///
> -///     let mut buf = Vec::new();
> +///     let mut buf = KVec::new();
>  ///     read.read_all(&mut buf, GFP_KERNEL)?;
>  ///
>  ///     // THIS IS A BUG! The bytes could have changed since we checked them.
> @@ -130,7 +127,7 @@ pub fn new(ptr: UserPtr, length: usize) -> Self {
>      /// Reads the entirety of the user slice, appending it to the end of the provided buffer.
>      ///
>      /// Fails with [`EFAULT`] if the read happens on a bad address.
> -    pub fn read_all(self, buf: &mut Vec<u8>, flags: Flags) -> Result {
> +    pub fn read_all(self, buf: &mut KVec<u8>, flags: Flags) -> Result {
>          self.reader().read_all(buf, flags)
>      }
>  
> @@ -291,9 +288,9 @@ pub fn read<T: FromBytes>(&mut self) -> Result<T> {
>      /// Reads the entirety of the user slice, appending it to the end of the provided buffer.
>      ///
>      /// Fails with [`EFAULT`] if the read happens on a bad address.
> -    pub fn read_all(mut self, buf: &mut Vec<u8>, flags: Flags) -> Result {
> +    pub fn read_all(mut self, buf: &mut KVec<u8>, flags: Flags) -> Result {
>          let len = self.length;
> -        VecExt::<u8>::reserve(buf, len, flags)?;
> +        buf.reserve(len, flags)?;
>  
>          // The call to `try_reserve` was successful, so the spare capacity is at least `len` bytes
>          // long.
> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
> index ab93111a048c..8d4ac914b48b 100644
> --- a/rust/macros/lib.rs
> +++ b/rust/macros/lib.rs
> @@ -242,7 +242,7 @@ pub fn concat_idents(ts: TokenStream) -> TokenStream {
>  /// #[pin_data]
>  /// struct DriverData {
>  ///     #[pin]
> -///     queue: Mutex<Vec<Command>>,
> +///     queue: Mutex<KVec<Command>>,
>  ///     buf: KBox<[u8; 1024 * 1024]>,
>  /// }
>  /// ```
> @@ -251,7 +251,7 @@ pub fn concat_idents(ts: TokenStream) -> TokenStream {
>  /// #[pin_data(PinnedDrop)]
>  /// struct DriverData {
>  ///     #[pin]
> -///     queue: Mutex<Vec<Command>>,
> +///     queue: Mutex<KVec<Command>>,
>  ///     buf: KBox<[u8; 1024 * 1024]>,
>  ///     raw_info: *mut Info,
>  /// }
> @@ -281,7 +281,7 @@ pub fn pin_data(inner: TokenStream, item: TokenStream) -> TokenStream {
>  /// #[pin_data(PinnedDrop)]
>  /// struct DriverData {
>  ///     #[pin]
> -///     queue: Mutex<Vec<Command>>,
> +///     queue: Mutex<KVec<Command>>,
>  ///     buf: KBox<[u8; 1024 * 1024]>,
>  ///     raw_info: *mut Info,
>  /// }
> diff --git a/samples/rust/rust_minimal.rs b/samples/rust/rust_minimal.rs
> index 2a9eaab62d1c..4aaf117bf8e3 100644
> --- a/samples/rust/rust_minimal.rs
> +++ b/samples/rust/rust_minimal.rs
> @@ -13,7 +13,7 @@
>  }
>  
>  struct RustMinimal {
> -    numbers: Vec<i32>,
> +    numbers: KVec<i32>,
>  }
>  
>  impl kernel::Module for RustMinimal {
> @@ -21,7 +21,7 @@ fn init(_module: &'static ThisModule) -> Result<Self> {
>          pr_info!("Rust minimal sample (init)\n");
>          pr_info!("Am I built-in? {}\n", !cfg!(MODULE));
>  
> -        let mut numbers = Vec::new();
> +        let mut numbers = KVec::new();
>          numbers.push(72, GFP_KERNEL)?;
>          numbers.push(108, GFP_KERNEL)?;
>          numbers.push(200, GFP_KERNEL)?;


