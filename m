Return-Path: <linux-kernel+bounces-269783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D4E9436D4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 22:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C45AB1F2701A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 20:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD9916C451;
	Wed, 31 Jul 2024 20:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="okc3Ylba"
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2130.outbound.protection.outlook.com [40.107.121.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB7E166313;
	Wed, 31 Jul 2024 20:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.121.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722456134; cv=fail; b=aC4jeKFxNo4XBKx5eZcQ99t0uzBDOMCN28VnKM5ydQyy2NZEOIff+lYvWrh53SJxitspf4BaPC/svZ/gyE3wAB+UXkbM+1IWO78790SWculbddS2sCU7r9oN2Dl5teSkflNaeFGud8ne8kPTQGL0dmCBUC//3b1+A2/B/QtTT/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722456134; c=relaxed/simple;
	bh=qOM/9zcIHG0UbRao4y8S8oEyFvBX/ZHuFPjDbmZ8pw8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B/BaAlZffIeTIJn9+wBLABuQxdpKz2Mg0xL4h2VQlXEjfaOHIF5xXiiDCgfXJVxs/bHhlgB2k7pjhkuG1qjoqRFZkT/8NDRhqBiiCdj3mHSbWJqrXmqntu0N+z2/0Tz7/6o5X8H9jIYKibKpasQ7KNg8KXZGn0U6B8nwYe6xhEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=okc3Ylba; arc=fail smtp.client-ip=40.107.121.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qW1CvhVdUm5iqyoojc7AMnkUlrgW3+/SuTmkozo65Wt8gCCcNcgut5c5+KKwNzNfl/86jcBH2OrXJlpmc+JzlWomp9b2YEHoJSQd0j1K7EZRiaO41PD21l4csvGiC+S3bobrMLtF35NG9ylwoSQgjuzrT09k+fHJi0szrnuS0BK/j0qlTz/gvXqhgZec3TVp6Tn9q8To/HCN3TghvJ33bCAlsZmkdmofxyvyf03cy9BiMRFEmbdWfSjdVipftt7w6YFz7w8O4jDTHwir3t3fidMsgizX9Qa0etX+MQiA4muBqkHXNlDs9cTTBlPrlst/woupG54LUdciX6yHGtSEcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2dSd2ioeK5VcNZm0TY6cWOb3rag/8IgeCbRB0dpII8=;
 b=bMY2eZ6DuijjR2SZoG09dRibZjESBcf+5ELg3+MLoqabjq3u3QBL+a/MNRJaCcvo1LFa0wj8K80HNZHWT5ICUJYLO2qdCVHGr3/y/u3N7j6yVEB/F/25G385B3NCMiQttUATJ20Dn2UaSvLqkcEjXa3jIHgaumenYbyMKLQPQtpJucY7GChxynEAECInP8yM73yxrf7hbL3Jlkab9Lk0cdfxXa7XG93vhyGpHbYauAbwYe+J2Hfpau4dZu5mqPlLoKj3sdhV2R4p16funV664+zSb7PHk3iRzJllVr0KhpxUotwPUaWNYYTifjT7hgnYxwAVNKSfjPucsNYKSOhYTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2dSd2ioeK5VcNZm0TY6cWOb3rag/8IgeCbRB0dpII8=;
 b=okc3Ylbaz76zul/aop8kloioxuSHw7sANhCvRgz5XfSbvxF/06qiI+oWRKVJ+o0WvAHmmtEHJ9Mpxoq3POCOMESwFYBlf43hCGuaGGAcIovkBZSJhQT6fmF+L4iUbcHmi6sO2Ez6vVRPubkb28zup5QVpYgYa4dF8AP4q+h2LTQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB2420.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:93::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 31 Jul
 2024 20:02:09 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%7]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 20:02:09 +0000
Date: Wed, 31 Jul 2024 21:02:06 +0100
From: Gary Guo <gary@garyguo.net>
To: Matt Gilbride <mattgilbride@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, "=?UTF-8?B?QmrDtnJu?= Roy Baron"
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas
 Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Arve =?UTF-8?B?SGrDuG5uZXY=?=
 =?UTF-8?B?w6Vn?=" <arve@android.com>, Todd Kjos <tkjos@android.com>,
 Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>,
 Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan
 <surenb@google.com>, Christian Brauner <brauner@kernel.org>, Rob Landley
 <rob@landley.net>, Davidlohr Bueso <dave@stgolabs.net>, Michel Lespinasse
 <michel@lespinasse.org>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/6] rust: kernel: add `drop_contents` to `BoxExt`
Message-ID: <20240731210206.2b56b432.gary@garyguo.net>
In-Reply-To: <20240711-b4-rbtree-v6-1-14bef1a8cdba@google.com>
References: <20240711-b4-rbtree-v6-0-14bef1a8cdba@google.com>
	<20240711-b4-rbtree-v6-1-14bef1a8cdba@google.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0043.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::17) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB2420:EE_
X-MS-Office365-Filtering-Correlation-Id: da515b5c-8360-4428-4927-08dcb19ba8dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qNGfbaVgcQYQCAi5ZTe8GDMCIl2wz95xC63LPEeNMo/S6nGM8dRF+wt7yEhT?=
 =?us-ascii?Q?cLfxAjKc5okI2e+r7gt0fYPMkBHodO0duwUNXmkzqATTyhj4pAhUZtkni3iU?=
 =?us-ascii?Q?bnY/ewEC1Ba/nwrMBPFUh8MaXAOcv2Lto6ASPx8YReZxRSFx+HeInXihFIAm?=
 =?us-ascii?Q?0RHUWslgP/tR27dKXrSbFWmMiIWeqnG0timtV1HKM7il40y0T+VNGO8L4AGW?=
 =?us-ascii?Q?Ag9UdRvdAPOlq4SpHZJVTrtbK3bQ1WOuMnMXZo7aP4AHNv7AvcO3X76Bid4O?=
 =?us-ascii?Q?/ClQygDGba/7zEgF4HLpuXkYvF7kE1BVVGh/AXiOd4W7foI0o7AQGjyqvJnx?=
 =?us-ascii?Q?alJBVyL/N7qN5pg/hAn58TqEqisnVIVLX1E1KOraovs/K7BOLNPdckOKPQB+?=
 =?us-ascii?Q?mpIzPvTQch6hIWscB1kzY9sV8wmhXgpw6sZbWMPAhsCmRuQi+J4UKwlv8jrT?=
 =?us-ascii?Q?obH/0LYps2qDJmR1v7tI9sxt3WYJu98d9eTOtgAUWeWuhar2oRokTrhU47PX?=
 =?us-ascii?Q?U/TbZPJepkQIqaFEVhwmg252orc7r4QdhTtn1fUMYpipx02HvxMwKuMWA3qb?=
 =?us-ascii?Q?sxRG3orxSTeqvURLvRCBdjnp9XuDe86yJ0DXNCQ6eaijmTFKQlMco9Cp1HiT?=
 =?us-ascii?Q?5GUFlI9uPO/88JjCN3D166RBG8CCSASH464sBYIFAaHoAKT/BKRttSIVA4Gt?=
 =?us-ascii?Q?7TAia/ap24JoZ+Iwvewbg1jM9lpCmuYaGz69cazEYfgAbxq0gmNtaopCpSBn?=
 =?us-ascii?Q?X2QFyJ/G2re3k610XHLoSmDSdc01JBT8+nyy1TDereWZ/P15tDIJA2x/4GvZ?=
 =?us-ascii?Q?4FFfNMqXnQhYaTkJUP7o/BEV0/cKPyNvFrQv4kmKkvoz9yBoc+tSP8rQ19es?=
 =?us-ascii?Q?ujA8sdHrTC3YACg0HS3W9sr2pCyPM7ywcacZLKehkPn2mLdyTjfwkMjyneYQ?=
 =?us-ascii?Q?R1Q5isDw5WxZjna8N0r6z1aC8xe0d8wbgolM/gT6HETye6y9n6w6hmZuIEnP?=
 =?us-ascii?Q?koNuQOq78ibNhgMXui+YHlFWwt2++SiIkFiz8Wn7hU76oYfXwskDhgDfq+Gw?=
 =?us-ascii?Q?0XcTDVOs0tLJ5QVOrzMCX9QXHSMzDV5MwGLWfiBWRT7AzkRmdtS5MClz+iWk?=
 =?us-ascii?Q?daUmeuOZlmhtz7unXLh+FdDlbG0FluDgXoULFngEzBWtTIb0hyE36y8iBpLh?=
 =?us-ascii?Q?r+zSUSZ1AqcTiP74MOy/qf9+wQS1cc1mKZlc5vwvlH87jPoS90klhYFS1AaN?=
 =?us-ascii?Q?FdlG/wCUEyXLhD+GiDxLcEauR493tUATAeTBQd5sTP/1qDOhGohnErx6UNWG?=
 =?us-ascii?Q?heY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SqWCyS7vgvclF0LOt8U12QKqicZ1R/Wh3crutg+SC/IBnaDg+6eaEXob9RY+?=
 =?us-ascii?Q?Mio9qQTec6DiWnJTK2vJATs2f/MjZL78BGPdo4iMMUaiNZgOGZh5gI18jmAr?=
 =?us-ascii?Q?pdRiVit9YIxuA2Y7bgerPIp0KRi0qiefDhiQRAPVktQE3mtRSEBXSJdzCaM7?=
 =?us-ascii?Q?SVUiYOJ4yz0LIirdnldYRBp0AQBQY2QvCPnFiWMs2UtDVawqBvajw3UMFs0P?=
 =?us-ascii?Q?htxxHV1vquvfnUPxTmkXtEPadle3oQ/akcaYWHG9w3bX8LtcjyedHJPUJZAp?=
 =?us-ascii?Q?pE+c0Lup1LRmBAJZtWCeI2/ht9Ytvn3/QWvqSvUSxjmum1l8OFgG77e6r50n?=
 =?us-ascii?Q?VJTF1FdhSokahs8/oaiNrPHDTaVXElHM3i9Hj1KCdu1MuyWqNg4Ez6lGpw2A?=
 =?us-ascii?Q?VWjnGXMJ2QMFi7nFUSqyr9GrJorLhwI92aW1Gs7phS698Qle7wG9cl/K0Zdr?=
 =?us-ascii?Q?jf9a2VnOkJ7eWKGb6dqAj8iLe+EVgJR90sVsxpr6K07DmWvgU1vnHibsfyyL?=
 =?us-ascii?Q?+T6cfmxXZLziKmVolYrwHUJDvD1rlvKWT0DfCqEpiJU4vsAiGvpwqiJkR8F5?=
 =?us-ascii?Q?/8WtoLjK8S7ENz5yEfkrBK1wlGp5sSDc8u7D68NoEJsKLJHgxMglkoRB6+wK?=
 =?us-ascii?Q?5W7C3uR2gfciF2GARcwyF2ilP6z/b+4EXVKBOepWOyYXsASISDwMcJtX0R9B?=
 =?us-ascii?Q?C8/kHsBYF07EslxBowK0gEsfq7Q4OahxajlvA3P1P4C7pR7eYSpIIyNqhk2s?=
 =?us-ascii?Q?sbvq3qDHx3zPSOmWXD7Dvj3K2zE1aiDsOyhCIdkd7ZlbIcAukjDRQk+Z/+RZ?=
 =?us-ascii?Q?YTNgWlWeU7ndue1JdCdfRixGrawEJyuX+/TwBbZvBC9YsZSeqcDEf36bM/Q7?=
 =?us-ascii?Q?VeeJFngOWnpygv7GRfSeMCHI9KPf0wn7fI/UsUfa0+RxTf8nbFvme/ZEqMPa?=
 =?us-ascii?Q?UkjTtMp7IDIGifiMpL7k89Z++JnMX9hONG+r3XGtDR/mh4gfSFQ/fYM2rZTY?=
 =?us-ascii?Q?WLfd7hJds8+SivwEuHinIy/Na8FdAh24HBS0FmGC5HSKDupXBYCFS+3tp+rp?=
 =?us-ascii?Q?p+Mg+tUAu5y1BvZ5FuVy6GxzXQPpGNwFeK3QaTIZnYzpfP7dWHbvnxUTYlp9?=
 =?us-ascii?Q?o7e7ck5VkanwYAY/o3EkrFkS/C2MwXf88dYNLaReyitGdkDF84p/ubcXuwjp?=
 =?us-ascii?Q?se+zgP4m5KJa4tzip0Gf3rHt13f6qMv4xwiukVPRCQxzON6WNJ65X+DH0sBW?=
 =?us-ascii?Q?T6JhmnB4w12L38u38Jb0Wopm9bh1PEGsqF57W/aFfGEoGW5L4spWuDJ8nIvg?=
 =?us-ascii?Q?5KtLkEzlYp4/I17FOuHDeZqYK/mkzS+LCSZP8lcpmIdqrDnw4D6JoqY3jzvs?=
 =?us-ascii?Q?JWD1jtly83qcf9S3E/3Ib28EkRPFMVu8GW+nRCxiMf9HdB1PDlw9MEyBtr7R?=
 =?us-ascii?Q?Ow4fTb8kwVK3EyD/PKRdeeBwVNzAA5/R4GQJHVXYTa0RO1nZeIJndB+HVfiX?=
 =?us-ascii?Q?jI84YcPrTwa+lZxM7/FL0Ik4zTMidOl3WRqoyzK1nOtOATWjsSyK5vCEtYwE?=
 =?us-ascii?Q?FwOQf1C8R65w+eecTtgYfFm8s8XBsJLxdKzwZ5zU?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: da515b5c-8360-4428-4927-08dcb19ba8dd
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 20:02:09.1897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Y7VGjpnDA7lOSRcc8HLreYvXmXgLcyR9TCR3OiD7kI9mInI/haVE9DjzqYeS0wfjoqrEDS7irdb4fi05k/DYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2420

On Thu, 11 Jul 2024 16:20:57 +0000
Matt Gilbride <mattgilbride@google.com> wrote:

> From: Benno Lossin <benno.lossin@proton.me>
> 
> Sometimes (see [1]) it is necessary to drop the value inside of a
> `Box<T>`, but retain the allocation. For example to reuse the allocation
> in the future.
> Introduce a new function `drop_contents` that turns a `Box<T>` into
> `Box<MaybeUninit<T>>` by dropping the value.
> 
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://lore.kernel.org/rust-for-linux/20240418-b4-rbtree-v3-5-323e134390ce@google.com/ [1]
> ---
>  rust/kernel/alloc/box_ext.rs | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/alloc/box_ext.rs b/rust/kernel/alloc/box_ext.rs
> index 829cb1c1cf9e..557895db4f48 100644
> --- a/rust/kernel/alloc/box_ext.rs
> +++ b/rust/kernel/alloc/box_ext.rs
> @@ -4,7 +4,7 @@
>  
>  use super::{AllocError, Flags};
>  use alloc::boxed::Box;
> -use core::mem::MaybeUninit;
> +use core::{mem::MaybeUninit, ptr};
>  
>  /// Extensions to [`Box`].
>  pub trait BoxExt<T>: Sized {
> @@ -17,6 +17,20 @@ pub trait BoxExt<T>: Sized {
>      ///
>      /// The allocation may fail, in which case an error is returned.
>      fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocError>;
> +
> +    /// Drops the contents, but keeps the allocation.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::alloc::flags;
> +    ///
> +    /// let value = Box::new([0; 32], flags::GFP_KERNEL);
> +    /// let value = value.unwrap().drop_contents();
> +    /// // Now we can re-use `value`:
> +    /// Box::write(value, [1; 32]);
> +    /// ```
> +    fn drop_contents(self) -> Box<MaybeUninit<T>>;

Should this have signature `fn drop_contents(this: Self) -> ...`? Box
types normally don't have methods to avoid shadowing functions that the
pointee may have.

>  }
>  
>  impl<T> BoxExt<T> for Box<T> {
> @@ -53,4 +67,12 @@ fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocError> {
>          // zero-sized types, we use `NonNull::dangling`.
>          Ok(unsafe { Box::from_raw(ptr) })
>      }
> +
> +    fn drop_contents(self) -> Box<MaybeUninit<T>> {
> +        let ptr = Box::into_raw(self);
> +        // SAFETY: `ptr` is valid, because it came from `Box::into_raw`.
> +        unsafe { ptr::drop_in_place(ptr) };
> +        // SAFETY: `ptr` is valid, because it came from `Box::into_raw`.
> +        unsafe { Box::from_raw(ptr.cast()) }
> +    }
>  }
> 

Best,
Gary

