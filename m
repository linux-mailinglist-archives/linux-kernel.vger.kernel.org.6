Return-Path: <linux-kernel+bounces-342637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA65F98911D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 21:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC183282E35
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 19:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AA815D5CF;
	Sat, 28 Sep 2024 19:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="AvcaeJyd"
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2131.outbound.protection.outlook.com [40.107.121.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195D71420B0;
	Sat, 28 Sep 2024 19:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.121.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727551661; cv=fail; b=GFcJ1qL8QLE3vuvOgkBGZpYEDFOwo69VkxbNoS8V3yRzo6HBh/I/R+7ZwuVcsWHr+aMF6RdpbsuV6w1AtQ/AI8/cWSwGZyRKoafoyw+uCPd8Nd08rtmDuHslKuFJe6DNEmPBGr9tbihwUbl1QovyJZyzBJp4tbYMa96nmE0ptbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727551661; c=relaxed/simple;
	bh=clJULMSImQgHzZHTY2cUi/P9YT3bsPs8xOv6UKLrpkw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d0jsIJmevzYqWvugiQu4WI5GaXVLT7DY7OcHd/wNo6m071wHv2mrcOR9cgNyITrojhgoCFDdCnFgWsHq/lImJFcaqVmIdrir49nYrAHPXLZOXi4btOChKxxl7jT3EKqdS0IRkrmOxuUE5Q91hHM0twbLOc4W8RCc7E22qR8poGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=AvcaeJyd; arc=fail smtp.client-ip=40.107.121.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YbfZTAq4p5TVtcGzRpWDvGKPx2HsPJMKXPVcYYFqsTzSQYIFG1eZgXKtvONIESUKsE8LZV8uDtycVhvxetBDDsqdODqSbs1wT44JBSlIFUnwnj4DjucipjpNVm4y9VuKZq1AmnQDkY2HaRY7hG7ygcRXeJO0QW4hr+2NEixR9ZKoLmlIdZTTK4JgjplibWLIQ9Ouzxv1malI+oxzdzs+3QyXQ8OQixA3RiFDyQwRmx2Uhs5w+S0pQYRAt9b2z2PDHFNiRvpi8AZ77+1mp3X4vkV214H0bsSKa0XB4D6jIVi/ga8clELk56lsugox8BqWM4aoFDkE84V75BbwscZYNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgMlTgXJ9W9PBd/IRjKXfOWYPSG1j4twmY9i9fZlnZ4=;
 b=m7Cw6pVVHjAJD4GjfWbTIw9IkhuVtZt5f7Q/xwkHVU09SutCy7xCr+6Fr7f3kN95x9OIv4fh3Pp8eC1asD8tbDy1a7Te5+uwQnjJjc674FnibDw4h8LUyXUIxwt0Cj/k+KClQufAVo0prlIRBO78m/xMhUZHMSEbTN4Kex1TmAciiMYgd0+KHhUZ9Bwvy/L0HITyvX0GbVnE9iYT9Z8nA56aR/jlXToAYMcU32HTyljlQquN/Hnkbr19UvuMLausp/FRPo9mEJgjaNnpV36qo3thpzgMJSJxndWzdqXuvYFvMy2zc9AOwUXJe+nVvN/IH2kurYEAbh2wNsyHetxC4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgMlTgXJ9W9PBd/IRjKXfOWYPSG1j4twmY9i9fZlnZ4=;
 b=AvcaeJyd5bZSY0xWAZnlT6FzPTiG1aLBJ3jhLkHaG2i62wn9ucWlYi6UlCQCnvMiMflx3wGZgbKZ9Qo3MnzRC/fYmcRZKFzj8jtU9IamUMWqrPSEDiGSx+ibYAaJ6vJ56vYrjuAm8dmy8xLG6Y6wF9jZ7BtmPM2Q1FClPb+nTAE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB6484.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1db::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Sat, 28 Sep
 2024 19:27:36 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8005.024; Sat, 28 Sep 2024
 19:27:36 +0000
Date: Sat, 28 Sep 2024 20:27:34 +0100
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
Subject: Re: [PATCH v7 15/26] rust: alloc: implement `collect` for
 `IntoIter`
Message-ID: <20240928202734.4b518854.gary@garyguo.net>
In-Reply-To: <20240911225449.152928-16-dakr@kernel.org>
References: <20240911225449.152928-1-dakr@kernel.org>
	<20240911225449.152928-16-dakr@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0167.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::12) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB6484:EE_
X-MS-Office365-Filtering-Correlation-Id: cdeaef72-26a5-43e0-0be3-08dcdff39be3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6O4GWAWfNeLjr4YA8tKxOwFcobSMwNI+vUGf3Zp0oBSb1spvgaofnQWjrfFA?=
 =?us-ascii?Q?riI9YG/G35FP88qiCyjNurEB7tNkVe+Q5KRJv8Mn5yQB9OmXYkH3AwWkHQ7X?=
 =?us-ascii?Q?tbWaQ6MIpnTrmyBVQdU7myrJa2+8SlcgzHvzoIH+F+FQqxH8OgxpRBTXiU7q?=
 =?us-ascii?Q?DeNkEdL2H4oBIAoYEUd5YUM2SRtRdDzm36yC7HKYjrlQ+ROuJ7Gjg+D0P5YC?=
 =?us-ascii?Q?qtaZ/hwqc0oyyCAxWbBeW8BDf+NIaNTOB2Lv9zWWiLjYzV8FnyE4jW539TP5?=
 =?us-ascii?Q?YC+Z1Ig9IPi9h+zq7NHgN+0npgBEXjeL+fbBriylUbhAdtB+4Q1Asu16Ny3I?=
 =?us-ascii?Q?gJ+EXzKOgFbf71kqrmc8Hg3R5EAO3mkYvg3kBl66NqiKQ30xmCzb0x6UME5Q?=
 =?us-ascii?Q?z7dRb8z8VGx3kC4VxitOzjYIxSsP20Qpd3ABdk5ZOKi7g8w4zRFzovyBhZA6?=
 =?us-ascii?Q?Grhm+UljWWwxbgsbDcNtewpDJ+Wc31XX2IFY4YCQ9ZksuA+kmv/LfeEEOGXi?=
 =?us-ascii?Q?BNpQ/iAdYK3aS3S5ekiYwltypx+Xt2L5PnRybunKRjBRf3tclpqowsj+wSnC?=
 =?us-ascii?Q?xnnjhyjIPQ442PtvJh21djKsGGsoMV2LzKVeVqj8bsI9NBtUewX0fUQc5kzO?=
 =?us-ascii?Q?ae4oiNwSUWHaL80ZnYFDO7tyCEnlJh+n13UfpCEN5paJfQRZj19NE2ceNp0W?=
 =?us-ascii?Q?XTmbuYPVM3JDE/39IYhm2OG0uvO2iuH31KBvlfMpCUFJQeZGnLvogGazaFyI?=
 =?us-ascii?Q?WFuDGcxySs2pIUYkHfL5JyFnLqjv7XjxP/TdFLUxV1bACRdroMK6V5JCiX9S?=
 =?us-ascii?Q?sHnoYjLebvOajH1iT2q6YHGsLDaX4uSNW8b5GO/ssbsVEQoYefcJMrfCvWbG?=
 =?us-ascii?Q?wWsKJrgWEBRVvT1UKYcoWrXTzVbnTo8VvWgf1nQLWJromizLCwVW/Jvd9Ofo?=
 =?us-ascii?Q?6GYQdejykIMaxOwZ9de8f0OuUZazugi/lEANDl6pG9th+8v0k1hmUdxdKT2a?=
 =?us-ascii?Q?Yyg5Pco6Ix1BDm29GK71mPgorAQ3BHhwbnxu/j9gZeOBmR4M8Qo3sMo+S0hY?=
 =?us-ascii?Q?8X1uk5+QUX+2dBlCEVIPEDSUUdVYldlsH0p6Ti/9bwLRQsgqPMUosEuFAVQH?=
 =?us-ascii?Q?eAE6cdmuqjyMzz9Nz7FKeBcNh78xunmXTeeYlWk/P+7CTQm8MqCgyFI5YTmV?=
 =?us-ascii?Q?SQ4DOzEm/g/3VU3nWl0Eq65K4NvF9OUMWCpYNd/gVdLpfUSIOPEJYH41Ow77?=
 =?us-ascii?Q?Pu8NgGNNkWfWVO9kyfEwQawj3NVnyRcuoEFiFp+N2u/cevr56Sbb1ZcFwVCq?=
 =?us-ascii?Q?fCQq78fFq/qPJksV4MQWzM3vfyltXJQl+8llLL23Qzwn5w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7ZZY4DNZJZl7Sealvvhz3DSB5S7PRpcWMBjNOTT289AJPm6rJiXbodTcRWXF?=
 =?us-ascii?Q?iAzRr4jhmwQxJRg6ADNus+Ppzbp3cdWQG1cvOFA3clI4rVrEIQ/+DMEewjUd?=
 =?us-ascii?Q?l05K/yux/9miKxpQn2KVSgvOEMZ7NnyC4qeOm4xqaIwrhFjaYuSAdkeKuee+?=
 =?us-ascii?Q?DAE8zzdus1NZNOuTcSI07Z7Qtyv0G7qa3tBjdHrJaMDvCBmZFNAB7kBmDwgG?=
 =?us-ascii?Q?/ZHcNmOqgpPvFzFpjsWtudG/Y89CE8Bz+EpYqROmjLipL4BUNz7EKlIJPVw+?=
 =?us-ascii?Q?4YRsOGWSSDfHsbuzL7HD/Za2SGq0lwzXUOhLANNLAGJkTe0ofziGk0k/wWTu?=
 =?us-ascii?Q?W9P3Sh0qpJQ7YnKWxdr9JOiZ4bF9BlcEeNYFRWqKCvD5sdvnRF1KZ7N03xSy?=
 =?us-ascii?Q?z04Zmt+h5x+WRKQ1utockTx6lnm9e5E8NkSQ8DpvsKuQYNPQI6YsLmH2tfdL?=
 =?us-ascii?Q?qExrr+pHap8t6om8T1NGkWw6wZ38vCfXKZM7YS0ZVhZXMshU+cXz5K4/cmVg?=
 =?us-ascii?Q?TJqhGO8rxJIDioddKb8U5IvqUYdgXrTEL7ZAbIog/+iX7J62ozrlsmlg2ji7?=
 =?us-ascii?Q?b+wb1i70fwCiF7vLZy7OFZOovIHvnw06tfOXfgKhY1Pjtnxa26lrw9uG5Us6?=
 =?us-ascii?Q?N0fxr29UNjqxZg7M3qPr5hPWUfad/rAqK0RTUSrpQ/3hw02mWKrQiu3HKYtX?=
 =?us-ascii?Q?A0AvWz0BDHYfRnJllvFGElKyrgaG0slD/M30Z0A9ikXkjgKK9OmSGq9+z78Z?=
 =?us-ascii?Q?htUXhbqenCX4mkzmcfWyitJf/IIJLiJ7NF0c28mmgknMdQB708ZXaprP+uOT?=
 =?us-ascii?Q?2fuSlG8n+i/uJ5f0iudFWmZElYCNJloUmiFysM1eHC9fWDR7rC2UGpdtXX19?=
 =?us-ascii?Q?HlM4RRe0tbwBS72wnxZyMGNTdZk20JbKEVsOg2d1HlI09sj4LXVQlA5yU/rK?=
 =?us-ascii?Q?fGF/9gO+HOkmndhzHAZUbqsgcuG7M+zMsO+c6NBoG59gnMvkPCYRK7ls+fcX?=
 =?us-ascii?Q?POeB0EPXHdZyiozfuRDiLrWn18ux65eQTEAcc0ckhITQWwiWy89s7QP/V+wk?=
 =?us-ascii?Q?zeI7fwaKN6rlPwuS1sRE86EThJ3kBkW+SjVAlmfnDezLBrhk8s/Pwvzg7k2M?=
 =?us-ascii?Q?2ZwQ9OyQ8xC4P2rR9dItJlYdzGptvEO8oammoQYlroreknLrt51nPyl5wRnx?=
 =?us-ascii?Q?EAC1rL/Z9w2CR5dUHk4W0jrWk1YdGuzZwI/FPaWKJtQnXVC35w//aEQjiHoi?=
 =?us-ascii?Q?sLYO/+D7fZN7tZ5t6ljE/9Mtvuy+M0KAdNuKvDUiG9Uvhv4dHoPRajynpqq9?=
 =?us-ascii?Q?5Kw171mca0eQ0Lg1nueKP9o49rsaeLh+R0n+oCzStaHIzZFk0TuIAAS+rekW?=
 =?us-ascii?Q?ZzE/B6SyF8K0K+TtDtfEjq+BbTY4G+/mASQXe/hwWwR9q/+v+izJKXru4vlL?=
 =?us-ascii?Q?lY/BmnKkSVkuA7srX2P0Eye9FcV1gi+iMHbEAmGgskb/ZDvhjFZTKmvNzRCP?=
 =?us-ascii?Q?GPzfZgF6p9hENAnn/+bWxY10MAoVp4m423WTEEWPRN9d7tKVksc4eBhEsywM?=
 =?us-ascii?Q?UuyomEthQGA8+NsTTAvZQtMzh1i4amIMPMDCUtCF?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: cdeaef72-26a5-43e0-0be3-08dcdff39be3
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2024 19:27:36.6473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 90lMiRK5Wb4DbHsrt+tMfdycYTmh/fAW54+Rq4deSO3Mqg1fcN+Qkt6ZWyoWNqKQyi6bvjUKwDGxOcyoDeuCTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6484

On Thu, 12 Sep 2024 00:52:51 +0200
Danilo Krummrich <dakr@kernel.org> wrote:

> Currently, we can't implement `FromIterator`. There are a couple of
> issues with this trait in the kernel, namely:
> 
>   - Rust's specialization feature is unstable. This prevents us to
>     optimze for the special case where `I::IntoIter` equals `Vec`'s
>     `IntoIter` type.
>   - We also can't use `I::IntoIter`'s type ID either to work around this,
>     since `FromIterator` doesn't require this type to be `'static`.
>   - `FromIterator::from_iter` does return `Self` instead of
>     `Result<Self, AllocError>`, hence we can't properly handle allocation
>     failures.
>   - Neither `Iterator::collect` nor `FromIterator::from_iter` can handle
>     additional allocation flags.
> 
> Instead, provide `IntoIter::collect`, such that we can at least convert
> `IntoIter` into a `Vec` again.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

A question is how useful is this? The way this can be used seems
fairly limited: you `into_iter`, consume a few elements, and the
`collect()`?

It feels whatever user this serves, it would make more sense for them
to use a `VecDeque` and just `pop_front()`.

Also, inline comments below.

> ---
>  rust/kernel/alloc/kvec.rs | 86 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
> 
> diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> index e91761c5c52d..686e969463f8 100644
> --- a/rust/kernel/alloc/kvec.rs
> +++ b/rust/kernel/alloc/kvec.rs
> @@ -690,6 +690,92 @@ impl<T, A> IntoIter<T, A>
>      fn as_raw_mut_slice(&mut self) -> *mut [T] {
>          ptr::slice_from_raw_parts_mut(self.ptr, self.len)
>      }
> +
> +    fn into_raw_parts(self) -> (*mut T, NonNull<T>, usize, usize) {
> +        let me = ManuallyDrop::new(self);
> +        let ptr = me.ptr;
> +        let buf = me.buf;
> +        let len = me.len;
> +        let cap = me.cap;
> +        (ptr, buf, len, cap)
> +    }
> +
> +    /// Same as `Iterator::collect` but specialized for `Vec`'s `IntoIter`.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// let v = kernel::kvec![1, 2, 3]?;
> +    /// let mut it = v.into_iter();
> +    ///
> +    /// assert_eq!(it.next(), Some(1));
> +    ///
> +    /// let v = it.collect(GFP_KERNEL);
> +    /// assert_eq!(v, [2, 3]);
> +    ///
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    /// # Implementation Details
> +    ///
> +    /// Currently, we can't implement `FromIterator`. There are a couple of issues with this trait
> +    /// in the kernel, namely:
> +    ///
> +    /// - Rust's specialization feature is unstable. This prevents us to optimze for the special
> +    ///   case where `I::IntoIter` equals `Vec`'s `IntoIter` type.
> +    /// - We also can't use `I::IntoIter`'s type ID either to work around this, since `FromIterator`
> +    ///   doesn't require this type to be `'static`.
> +    /// - `FromIterator::from_iter` does return `Self` instead of `Result<Self, AllocError>`, hence
> +    ///   we can't properly handle allocation failures.
> +    /// - Neither `Iterator::collect` nor `FromIterator::from_iter` can handle additional allocation
> +    ///   flags.
> +    ///
> +    /// Instead, provide `IntoIter::collect`, such that we can at least convert a `IntoIter` into a
> +    /// `Vec` again.
> +    ///
> +    /// Note that `IntoIter::collect` doesn't require `Flags`, since it re-uses the existing backing
> +    /// buffer. However, this backing buffer may be shrunk to the actual count of elements.
> +    pub fn collect(self, flags: Flags) -> Vec<T, A> {
> +        let (mut ptr, buf, len, mut cap) = self.into_raw_parts();
> +        let has_advanced = ptr != buf.as_ptr();
> +
> +        if has_advanced {
> +            // Copy the contents we have advanced to at the beginning of the buffer.
> +            //
> +            // SAFETY:
> +            // - `ptr` is valid for reads of `len * size_of::<T>()` bytes,
> +            // - `buf.as_ptr()` is valid for writes of `len * size_of::<T>()` bytes,
> +            // - `ptr` and `buf.as_ptr()` are not be subject to aliasing restrictions relative to
> +            //   each other,
> +            // - both `ptr` and `buf.ptr()` are properly aligned.
> +            unsafe { ptr::copy(ptr, buf.as_ptr(), len) };
> +            ptr = buf.as_ptr();
> +        }
> +
> +        // This can never fail, `len` is guaranteed to be smaller than `cap`.
> +        let layout = core::alloc::Layout::array::<T>(len).unwrap();

nit: could be `unwrap_unchecked()`. Although feel free to leave it to
avoid an additional unsafe.

> +
> +        // SAFETY: `buf` points to the start of the backing buffer and `len` is guaranteed to be
> +        // smaller than `cap`. Depending on `alloc` this operation may shrink the buffer or leaves
> +        // it as it is.
> +        ptr = match unsafe { A::realloc(Some(buf.cast()), layout, flags) } {
> +            // If we fail to shrink, which likely can't even happen, continue with the existing
> +            // buffer.
> +            Err(_) => ptr,
> +            Ok(ptr) => {
> +                cap = len;
> +                ptr.as_ptr().cast()
> +            }
> +        };

This should be moved to `Vec::shrink_to_fit`. And then this function
can just `Vec::from_raw_parts(...)` and then `vec.shrink_to_fit`.

But my question would be why this function needs to shrink in the first
place.

> +
> +        // SAFETY: If the iterator has been advanced, the advanced elements have been copied to
> +        // the beginning of the buffer and `len` has been adjusted accordingly.
> +        //
> +        // - `ptr` is guaranteed to point to the start of the backing buffer.
> +        // - `cap` is either the original capacity or, after shrinking the buffer, equal to `len`.
> +        // - `alloc` is guaranteed to be unchanged since `into_iter` has been called on the original
> +        //   `Vec`.
> +        unsafe { Vec::from_raw_parts(ptr, len, cap) }
> +    }
>  }
>  
>  impl<T, A> Iterator for IntoIter<T, A>


