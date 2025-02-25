Return-Path: <linux-kernel+bounces-531847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3E2A445DA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91B2E3AE825
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A502719046E;
	Tue, 25 Feb 2025 16:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="fIBwNjCr"
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020088.outbound.protection.outlook.com [52.101.196.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F49188736;
	Tue, 25 Feb 2025 16:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500192; cv=fail; b=NYSWx8xoQjaU39ejPedcUYim50spB9LiYpjLCzwes83aE/xj9FiuZ75PFw+GUnvha2BfYc6CFB9TMX2ZnSHCeVdTcPluKpd5bg8VbU2KKX1BNacrqTovonFH7qnmvdFyXzHC1RwdF7CMz3uBbY2Vn14ixUYcTe0AVHlm9/qx0oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500192; c=relaxed/simple;
	bh=5Jim9DIu+QE4r8zjNviGHzYuDMd7EF357tonjg8rEa0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tr1nPAsW3++Wzp6Ckfo6RiZHw0MC6vwfXCHTbnWMLNbqIBlGWXNT6usgzy4y6SxWo/nQ0HHta6rU8IV0RaZUy6Jp26dc5MCMY/SqAn1RRdywNTyegxP0/1YDWi5C6/hQYmSC3i+YCqIePayqNy7mJRoblzIx/JlPJJdknyhTaUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=fIBwNjCr; arc=fail smtp.client-ip=52.101.196.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gSxw8oj+aBmElKDXtN3ti5iYT96p0Cj5VXI1PjM7NZZ8SZqoZdh2Hw4FUYVOtDhvCOvZpP6/ghM1ENAwO36ESt4lJgX7gJY3nlf/7vyQtYurHiKMIZVqKijdBmSQSLFUvD0Ru30qfMuLjfsd/UGB0r346RfJBoWhdOQFCneJRk9DLuw4wYyHuNU9D0rDyxngLByDxkCSwLiftWgydXs8Zt5pjMaCv8YoYiPU8R7uCKALHbHBfEzrW2S3q+bB5rGIne2PoW1zxR1zVy0nKgm0nlB4EnMlLmZoeznkvxImcLxmTP3WGRJc9f283X4mrUBkVygbVTViOI3XZ4Xbl8Oe2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rWhr5QPoKtmgf1z0PRX3k7cPpsYZ51c1iWtVgod2Ik=;
 b=IuDlV2WIvUNF/uqOi4G0x4P35gCCBsLNZ66RLkNWRurja9G2Kki94u3Ds+Azz00AMmZIIg7c6f8qveDSkC8PWjWV/Z39JE4AxT0cg7xHb1UpE0tlIaEQlCGMUIP1GkB708b4W2BLV9fjy/xTZZxCbUTRQ0FR7BUPBNScmPkaZ31cXu7zY3RrAJsPE+njcdCf9BbuG5swydnk87mgPYtf6f5TDH+zfHlmy6WP9Vq2o+cAAGZsFjOhJAahB+bkT4AehEGOoPIs8mpBOK6buQhQh6texlnvudYO/9ZwgXwco6hHkAZPOH3fSWF6zMCsHV8SJ1GDJaUm56yMkg/KMc5LEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rWhr5QPoKtmgf1z0PRX3k7cPpsYZ51c1iWtVgod2Ik=;
 b=fIBwNjCrG4MsAOFWUe2XtGWM5EfBFroBHZ4QopWpPnjE5qbgx+59xSIOFgE7T3hqDr3+c0EQiYNOPWf15ifijXA/3hGn+zkhHZGx6oMvU1031AMjpwEIlU65hf8lAecvWANMoop0Tbg5KRPey+6v3HxRO7tsw2hkVLaS5mkLUIY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWXP265MB2344.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:7c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Tue, 25 Feb
 2025 16:16:27 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%5]) with mapi id 15.20.8489.014; Tue, 25 Feb 2025
 16:16:27 +0000
Date: Tue, 25 Feb 2025 16:16:25 +0000
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
Subject: Re: [PATCH v14 5/8] mm: rust: add mmput_async support
Message-ID: <20250225161625.7b868034@eugeo>
In-Reply-To: <20250213-vma-v14-5-b29c47ab21f5@google.com>
References: <20250213-vma-v14-0-b29c47ab21f5@google.com>
	<20250213-vma-v14-5-b29c47ab21f5@google.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0656.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::12) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWXP265MB2344:EE_
X-MS-Office365-Filtering-Correlation-Id: c220fe16-0cae-4af3-1d16-08dd55b7c1ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qKrP63sjSUFGKFSTerMgO7Az8VsoPLyKlRPLxNFot+O98tbYEWzalVxf1Zuj?=
 =?us-ascii?Q?3eeGeBbRHwlovsHEL2yNnfGYeXh42CU1trrblXtr0rbWiqppLqr/bF5/N5L4?=
 =?us-ascii?Q?wo6P73ptYjvR24mVxajdF95MswoM57/pktO3XgCCrYYZcU9V2rgvs9xLBgTN?=
 =?us-ascii?Q?17Vr8txZ1n27WL8C1OXIJFrmA/JpAb65n2HLBnnl1hNb1NX5mtS6rVvAz6cj?=
 =?us-ascii?Q?QYW+vdp7eCm2tX3vHA+sPkFW4qySqx4Q2+Wo+dMEpF1nU21aVUuaQy8txBuV?=
 =?us-ascii?Q?98M2VTqwAnS/4xqnpIOnCyXuq8/i6AuKIH5bIHOWfFXng/r7nhFDOGxiVgjx?=
 =?us-ascii?Q?mFTnYHoMYHxMstUfo+db7cyc6PRnkLzWx4hM0dyin84l/fC7yL2U81MdLpl1?=
 =?us-ascii?Q?23RflHrhxpHx6KXbymNp77/HyPm0rdc6Bg+UiCsPgA3LIIT3nhV2hjrQHiyn?=
 =?us-ascii?Q?P2742TiIpH5+Z8nAwTxFHOeMBPGD434JPQXC/mDKFFdRq1TElQ5aVaLVmSUq?=
 =?us-ascii?Q?ZOV1iqfufAg6PDvvanjNTAv888EN/wiwY0hXDKdvFaxcwrKTIbWmjATCCOFm?=
 =?us-ascii?Q?blFY5CjBM5Mia9ODpjQMVIThECVh8kXwRk11Jr/qpSxPJ6U8LOQ473zUmIQs?=
 =?us-ascii?Q?jFLkwjwDrFJm1GYRYDAvQ5XJXl2VXIrHhjZs07YFjpPPfUgOG+QmgOmYNvHU?=
 =?us-ascii?Q?BrMgSep7StxENJNKiyhS8aRlnH5QEvlmq/Q8ebHfhlAitMO+tO+Yupc2oYHx?=
 =?us-ascii?Q?fOYE5Qrn8PXm/3rco530thwvFQKlhjV3usC8q/6AzSpnmL6xzSrL9lC3JqSX?=
 =?us-ascii?Q?joBfMfODijggQMts0aGD0rpE+Sic5oR37Xf0Qx+AP7RIwWHYI94kSJHChQDp?=
 =?us-ascii?Q?/payskIO4pEjRzbRrsWEXRFdi+FxFPP6lmOwIT/qwJukDqRMbg1Jie81ece3?=
 =?us-ascii?Q?tRkaRZ/vkf3E7hKS6ZBZTaMro2G4/+Vx+pvXW/QXDSkHNNkeqRqxwFVGO1T3?=
 =?us-ascii?Q?WCxaZ3ikBaCmDHlbkM6NKVrA3m0ZcUojTfu8LiyvkxLUcL0tJHYH0n8k/X5f?=
 =?us-ascii?Q?c+dAuFbs2jL2Yk6ncqQv8dgQA8Y5+MGbXfwBTUe5cEQ96x3ZFBZ1VylpuKn8?=
 =?us-ascii?Q?0B0dIxieJyESaP++RAl8HI7CkKK3m/b8CS8YGZSj38991fSVI1wxJF39Q2Iz?=
 =?us-ascii?Q?Dc72NNk5z6mEpI8gfKbQgSkPTc6J7ifstTnuEHSEOyrUDzbAcibDexXh937+?=
 =?us-ascii?Q?vEAq+9u/P2N0vyA+ja/IRK7Z3uQTyONHddGPBj6XoigsANuR9mBM+NpDXLgN?=
 =?us-ascii?Q?gchLNp2xe5hXQ0sian6yGYutL0cYIb2pdq3Fsvj29sX02bDoXwAzNF47k97U?=
 =?us-ascii?Q?exfdWB/triCeSAXx4WKM4o4t+iOf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?//tV+AhchaeBbUQHTHeeD0seXZu6b6T1HUa1h/fEskV/j/bzAAMJ/aXLQr+9?=
 =?us-ascii?Q?AUyWggGPjPhIG4uGzklMrKmlTl40gz/YXjDoY0NwwXDHgi19f6O2VQdkLuBB?=
 =?us-ascii?Q?fIpFaII76PCC/xlkeVNK4Q6oEXX7yl2EWOXGNleARLcSbMLwIErkCGwfea3H?=
 =?us-ascii?Q?lUrHK1hu2XMqv74ihh8QzVly3Bnr/zMUrU5H9B1D0XX5AQDY8zTn4luvXMzh?=
 =?us-ascii?Q?iKQJvBejtsm7E187UFO/HJfLuB64E5ejVT3N+Pd5zi24LLdYRNhRh+Nuq+vY?=
 =?us-ascii?Q?RAfX5pSByr7RJt+nJILh6V3ZIiVSagy23/0t0yXU5Ec/fjpZwxJMT+cqTsLJ?=
 =?us-ascii?Q?XZEKnPEXA44Ri1Rl6O1LQV6XEwZCoXFmr/AhX5CEK3DLr1X34flWBo/pmD9o?=
 =?us-ascii?Q?kQ+XMddqswrun/xm/IxGBBpZ0AdjGvGU2JQfBn0emWw0hCorJqMKEuuy0e6X?=
 =?us-ascii?Q?qqMgmOnJfa8/VgDXWCP5/ZN6xbWfoefLDp/vN9uBKYPWJIS3O9xynt/s0Q2u?=
 =?us-ascii?Q?8y/X9yhTdIynmltRRdt7y7jj2h80jLoPJRPEMqIo+zA/h9q8Tmm/mboqEj5/?=
 =?us-ascii?Q?0zpIMR9qI0GQzWSTMMWscoxTWIqPbeofRYFWgU22yUGl7XblyTwQA+DYILDJ?=
 =?us-ascii?Q?Jol9Xif+12ZX3v4XHtKFQjIWdyEUz7FnQ/r76Q9k5ltOcZmGGNUpR/mNQUl5?=
 =?us-ascii?Q?gmsBncNIHE4Jpa4LmECoOOxIm8QmRh+ZCRJWzjgOBRTStlwrvLoZQ+4WNCGX?=
 =?us-ascii?Q?480tsP7hg5UPQOhif4+ZFpX1vhQXnn2qUpMo+TcChuZikrb/lmTu3b4DBv9S?=
 =?us-ascii?Q?zdg31VxgIMYP1ld46IK2stBWd5BmBQ92zgl0xzXnVbchZwRGmDorTRjaVc9y?=
 =?us-ascii?Q?RfKQiWRrZnpYzVZlXLniYHfJME2qDX3d7sgKCDbCLSQ48auv1qhCv+tR8T7q?=
 =?us-ascii?Q?YRux79n/jz3ZUiVBkkwihzgdVaCgp4fkjcUl0EYOgcR8U0zkeL4Fc0Lo2Jvn?=
 =?us-ascii?Q?rx4LYyM/DwDFSmNlf478vv/iwhcsG3EJCMeNLpVX5nbgam+mUd6d0wK96Jo8?=
 =?us-ascii?Q?8YaUKYJCFWqZTwURmbeQ1apXtL+dztFaqy+WeVErJOKSKjmha4YQcrOxu3ef?=
 =?us-ascii?Q?Qf7yQWC1k/J98aAKCgZ/K58NhpAWOFEcmIrfU9irINVV7cOIpqbeUssQzW8a?=
 =?us-ascii?Q?gLHjoBdVDxk//EK2ti0XQgWfwjx0tGOkbvRXlyn0gwZFndxQDEWKS7IwjvUi?=
 =?us-ascii?Q?h4CHjlp9w+Q1F4KBqtEH3AvHIitHUReT+FbjbLIXgK52qS7K5RjOvupsJeQs?=
 =?us-ascii?Q?DEicqLo8Ul4hNAoaGYphXdIqrb6s6BkyaK/5uwbGKZagcaezQe/lNayEox6S?=
 =?us-ascii?Q?BNumIUK98O4wgPZ62vRM5/kvISBMn5brVD8IqBDA9sjkEHab3Msl/zvhe5Y4?=
 =?us-ascii?Q?0nIGrgjcZVP/aHhH5ak1MXBJ7sMLAntuKECE2goPAqmSf4Y2YQUo3HWymnHE?=
 =?us-ascii?Q?NO6FLVjskeV5hIzrn1QfpoU2Rbi4+W6/xkf+MF0nqvI0G44UHrIwi7yc/A6G?=
 =?us-ascii?Q?PZniBcB8gFII0Ry3W13O1bxUkHqQGEZzRqwPFAX36Dvx6AjOgNwcNII78Kxz?=
 =?us-ascii?Q?/g=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c220fe16-0cae-4af3-1d16-08dd55b7c1ce
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 16:16:27.6883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KiQ5yoF38wEUf9f6VPFGPpH+4GyMHnO+yPoZk+FKZ2TdfgXQvNq24yaLd3hXJI/OZa6ru7kgPIDmur9NTdVOxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2344

On Thu, 13 Feb 2025 11:04:04 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> Adds an MmWithUserAsync type that uses mmput_async when dropped but is
> otherwise identical to MmWithUser. This has to be done using a separate
> type because the thing we are changing is the destructor.
> 
> Rust Binder needs this to avoid a certain deadlock. See commit
> 9a9ab0d96362 ("binder: fix race between mmput() and do_exit()") for
> details. It's also needed in the shrinker to avoid cleaning up the mm in
> the shrinker's context.
> 
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com> (for mm bits)
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/mm.rs | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
> index 618aa48e00a4..42decd311740 100644
> --- a/rust/kernel/mm.rs
> +++ b/rust/kernel/mm.rs
> @@ -110,6 +110,48 @@ fn deref(&self) -> &Mm {
>      }
>  }
>  
> +/// A wrapper for the kernel's `struct mm_struct`.
> +///
> +/// This type is identical to `MmWithUser` except that it uses `mmput_async` when dropping a
> +/// refcount. This means that the destructor of `ARef<MmWithUserAsync>` is safe to call in atomic
> +/// context.
> +///
> +/// # Invariants
> +///
> +/// Values of this type are always refcounted using `mmget`. The value of `mm_users` is non-zero.
> +#[repr(transparent)]
> +pub struct MmWithUserAsync {
> +    mm: MmWithUser,
> +}
> +
> +// SAFETY: It is safe to call `mmput_async` on another thread than where `mmget` was called.
> +unsafe impl Send for MmWithUserAsync {}
> +// SAFETY: All methods on `MmWithUserAsync` can be called in parallel from several threads.
> +unsafe impl Sync for MmWithUserAsync {}
> +
> +// SAFETY: By the type invariants, this type is always refcounted.
> +unsafe impl AlwaysRefCounted for MmWithUserAsync {
> +    fn inc_ref(&self) {
> +        // SAFETY: The pointer is valid since self is a reference.
> +        unsafe { bindings::mmget(self.as_raw()) };
> +    }
> +
> +    unsafe fn dec_ref(obj: NonNull<Self>) {
> +        // SAFETY: The caller is giving up their refcount.
> +        unsafe { bindings::mmput_async(obj.cast().as_ptr()) };
> +    }
> +}
> +
> +// Make all `MmWithUser` methods available on `MmWithUserAsync`.
> +impl Deref for MmWithUserAsync {
> +    type Target = MmWithUser;
> +
> +    #[inline]
> +    fn deref(&self) -> &MmWithUser {
> +        &self.mm
> +    }
> +}
> +
>  // These methods are safe to call even if `mm_users` is zero.
>  impl Mm {
>      /// Returns a raw pointer to the inner `mm_struct`.
> @@ -161,6 +203,13 @@ pub unsafe fn from_raw<'a>(ptr: *const bindings::mm_struct) -> &'a MmWithUser {
>          unsafe { &*ptr.cast() }
>      }
>  
> +    /// Use `mmput_async` when dropping this refcount.
> +    #[inline]
> +    pub fn into_mmput_async(me: ARef<MmWithUser>) -> ARef<MmWithUserAsync> {
> +        // SAFETY: The layouts and invariants are compatible.
> +        unsafe { ARef::from_raw(ARef::into_raw(me).cast()) }
> +    }
> +
>      /// Attempt to access a vma using the vma read lock.
>      ///
>      /// This is an optimistic trylock operation, so it may fail if there is contention. In that
> 


