Return-Path: <linux-kernel+bounces-526451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5DDA3FED2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B09F1892C72
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D4A2512FA;
	Fri, 21 Feb 2025 18:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="hBwgQMF7"
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021136.outbound.protection.outlook.com [52.101.100.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369441D5AA7;
	Fri, 21 Feb 2025 18:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740162543; cv=fail; b=or5Hxqn1Xdsd6ayZf/gKDHjJweea0iz4hQqBI9MaEDpkD2eJPifytB60WdAIukr+YFNX8eMR6FyUhnwPIswVQZwHSd3MvnbPrq3IH1CiqDsNdo60CjilqfSb+OPDtzef8W0h97L/tU3KpMaboz/9dxIUo1rlyvPzIf86FfYRyLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740162543; c=relaxed/simple;
	bh=YsZfrke/wZqKVkGD5JPl3Vk/pfTPk7yC+c2ENbJUZ5w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AOCUZl1dyc23l2YnHS1+ff4zMFf0m9Guml++sOX3dE7LXw7WPvHPxI9ubrhhr7h2/7ie9hxYIVIVfLftR+jpGWX+Ecd1vFU7kHXoUbUXbazJl+7cZLsIZBDQHdhFuZw4Cxyc5AwuXQW/HYkYvDJ492EFSwfMZy6TL8jq1Yo2BZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=hBwgQMF7; arc=fail smtp.client-ip=52.101.100.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohtTPGD+Zlkkl9/gvp0aQY+fNakEE/15PSvdkEHzJdYZHJG4n+X4q49OCulaAMGL1azFl4ywFnoGXoEulZcNe5Np9sBfInVfnpwsonoNVSvaEWx1sLriW3lJcbIZzfGejAWrumz9na4MmD1BWWo/i1XLxyN4mpzqR7znbJknLq7UeN8S0+D5fpsYdxSkFsSDUtKaybYvzErAjH8Mr14AGE0DG4tqhmdkZ52jvsdhcwdvInYVJDre6N3RFRc7YIQJDyFG1buQnocgy5PGN04cLtKFKko0tKwWcI+9Il7YYIIUEOiZHFM9eujnrL8tQy+gTTN2JxCNd4U466pa5sRjjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgLp3/Fz/x3HE2b/xS2sVghIaVRSr9XpRQipsBgbPfw=;
 b=XTXcWH1RrqRAbIgMrvdnEbC0OrGpGQVogS08pa/mxwfpkJsBCzhCOZZbf5iz/w5ixvuFAdl0elqpNtIler7M1sMtRBzrLB7ytHgu4hf0oYxvT3FbdRbJR57UxxlvB1nzqyfYjDEnyEXcHBQUpMSu7hS+k3TDR8xT63ackkwsA2enaV0wWU0YHHmHiZRIrYOsyB9eDFKApjAI66Ch1YYFEumIS+BULafrJGCQ/majdgLO+uUuVUjVQfW6kQfwj1nXN44JkymkMBV49+SfC6WVnjo95fWZQfYcP41chulz7zoM4WrKjVydCBzuPe/yBU0dxtGE/0ccey6/rSOHZ/mijQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgLp3/Fz/x3HE2b/xS2sVghIaVRSr9XpRQipsBgbPfw=;
 b=hBwgQMF7k+QJW1tMpU+B35MKWTYUlOrj6GwB/pik/bXVD5MuC6lTZnYoPtRp+fw/b55PUZ3Kl9gUJ8OOzwEfMvPpTukA53T8GvishJW6hKvnKwb2uabZKnEny+PDVhRphQkxgtplfI6OJDKYSb3Chm6vVMOQabn/kPm/99SYMxM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO4P265MB6856.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:348::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 18:28:58 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%4]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 18:28:53 +0000
Date: Fri, 21 Feb 2025 18:28:49 +0000
From: Gary Guo <gary@garyguo.net>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas
 Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Wedson
 Almeida Filho <walmeida@microsoft.com>, Alex Mantel
 <alexmantel93@mailbox.org>, Will Deacon <will@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] rust: convert `Arc` to use `Refcount`
Message-ID: <20250221182849.21e9d83a@eugeo>
In-Reply-To: <CAJ-ks9=dsrsMD261HEbgHOUMXm=nj-GUymuCtZ8oeDFCx7JtrQ@mail.gmail.com>
References: <20250219201602.1898383-1-gary@garyguo.net>
	<20250219201602.1898383-3-gary@garyguo.net>
	<CAJ-ks9npk8oSFHZHdViR1XhF+A8e2L+P0wCgmjE7mzAxS9WK1g@mail.gmail.com>
	<20250221161439.0e34fba9@eugeo>
	<CAJ-ks9=dsrsMD261HEbgHOUMXm=nj-GUymuCtZ8oeDFCx7JtrQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0027.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::14) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO4P265MB6856:EE_
X-MS-Office365-Filtering-Correlation-Id: e2be0644-e4be-48a8-f922-08dd52a597f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NPteXVNkl4+CEW+9yqlkdGoQlB5SZR/Id6sEVYooKQgxVQRiTQpxlrrzUvdd?=
 =?us-ascii?Q?2ZcngnmKt3J4fBUGk+UNFUegfMnf6EmlhPnHFocpDfsRWXK5zQp2VND5yGce?=
 =?us-ascii?Q?ACUoaq8+XDAq4fkDkr95qBBzxvty4bY3ZQhj/tCJux8/BISaTHN29lQYXzBJ?=
 =?us-ascii?Q?26jcXqc3iCjXQdAohc/18M51h+9aY0Y9leFNEEoHAbASFRd1Sm0A3y9d9X4g?=
 =?us-ascii?Q?SSdQiIn3/a6/rAM15GwcTv7+huZCK3fGAKHM1sCxCHsH0jAvCEizIIRjXUfz?=
 =?us-ascii?Q?uU+iCcC1TzL+NEqDGXf3zXF9bDOK2cdO+3CR+bmiafW5+80+RWltnQU5hfLO?=
 =?us-ascii?Q?MCJBmxwI8GbQj5WOnAWpZATkZ8dHe7lmyLWz+RN8FLcgDSoSFe0QrJ/m1kWl?=
 =?us-ascii?Q?8ZihM+aB5DoRrkWDsDdFy+hInzBKsbnSqGIxcpfczKAMqB972E/ggZV29Bp3?=
 =?us-ascii?Q?LagiROc/TMRGF2FO3vfcV77edrhmPMWbdXNdPtYqqdNYAlVObMUjWGTO4iRf?=
 =?us-ascii?Q?5H3k+OL3daJR0KThBX+3lW4rd9Q8TCf96YPuLFX/M7BMCFwaOpqCKD5aH+fC?=
 =?us-ascii?Q?tMpOOOWGdhgbD4izMvFzOlN8ufXgR84u60fglFUhivTb4sktisQz0jEsLtgy?=
 =?us-ascii?Q?ySLIndfz0BE8NihrWdtX0+dpjjo0tNd1XKUiGI3xj7Qdzm2OHVkrXzx//IVW?=
 =?us-ascii?Q?HUaD8fheZ26t0gkNm0yQtvKGuy8vwpfN1h/71LYTfnUBQugFgiL40Nrr5a9S?=
 =?us-ascii?Q?7Z7GsLw2NeoWa+kqnX6PFKGWXxclnFX03cLu6s0z67HLB1D1uedPMmzipFPG?=
 =?us-ascii?Q?SXHmqu+25E0iRXNfQscsrTVdw+xzyvhL5Isu00lJh8ooqX057bqxI5n3fAwI?=
 =?us-ascii?Q?34+oeVZOL6VTq3g0OrohGcm4PlZwcki1kOnxY4aJBwjihU9jtr+R5iJfKc//?=
 =?us-ascii?Q?Vfzqk05hxFoibNcZsnGXd4u8Soi6ydHPxzrabVhz8a7LSg5E4zF8eGZ+tgG2?=
 =?us-ascii?Q?b+GQ8sCCJmDAvdZ3nXq37HlhB3vMzT5mB7G2ltRuUGGKlBmJq9CjpeYCIADd?=
 =?us-ascii?Q?uC0Ldxkp6siQitzxF9bBNfN/Mdwdt0DjO/wbDEwmg4ncVrGGqYxOtpTMhJKW?=
 =?us-ascii?Q?wjdKMWkU7EvRW803yVeXqSUPqMfErRcWrYvHGqXqFbc1zw93+95TIgG2dxEl?=
 =?us-ascii?Q?GbnFY7/WF7C14HnyHWzRNJ/pg5vCY0H2aFNJY8ErSFA9VhJr3uef1y/M3bA7?=
 =?us-ascii?Q?8TIyZhmk4ZadIldS7yXTPQOgWTTIji/Qsp9H7a4nL5Z4dEISCYfcSc86Mwkx?=
 =?us-ascii?Q?/J1aY6lgLpud0C60h3PfuI8oqv0tR9sMUAdBNhbFNv3lpPbRnv5eCzsvjdEv?=
 =?us-ascii?Q?HhRWTGspBOSHPmotKhPJTyU33i2Y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?as1m1S8meQwutscTrmzJoFpZ7BdxD9JnJ/pPe0Zl6dGWFxrIGlFNQEZ4d086?=
 =?us-ascii?Q?gIMLFHwgg5NetxJWP/ra7pQvs3znZ9wog4TZ0XNCyuU8XwRiLWZ3GwGvk/6Q?=
 =?us-ascii?Q?nK37SSSbGifM7RsaLIYli/Kj52nPal9hSDyhNf42dRorr2NaRa0WTTAXqDTA?=
 =?us-ascii?Q?5av1yczaVawFqKoH6biyU3Ku/fARPdnYtZyqD9WrHHMW7N7+2h3sUi8MufWj?=
 =?us-ascii?Q?vRDuBv3R5OVW3wkRW35keOxSs350jQwKcwdCqF7pICvMkrw3hY4IjjOxuuCX?=
 =?us-ascii?Q?Y14jXsDuLZ9kj/iaJhBn8LHC+HOGt/+U6f93Fn6bo7uefJgcNAWQn9qwDm9o?=
 =?us-ascii?Q?jpDNrfqlLZpJ+tFzqYrn05LADOLABcohiu0U3wueNIweqsf5XFFojqOgB0hV?=
 =?us-ascii?Q?MjOJZeZsETtzpevT96kTq4Bg61ZSuKbpvBWXH0sVOXFlc+dEAHbyTQVB9LCS?=
 =?us-ascii?Q?Or2UUPSlBvx66LwlOgvKteaYzpNL7zb8pH2nSjSQrriLXqjumGKtGlPUYRnU?=
 =?us-ascii?Q?zXGZ+6qnTJ5W9PD4JP5i3D3tl5pRaEOSk1siz8gKhF3+/4M5kww2vBNw40kb?=
 =?us-ascii?Q?H+qzbOblN0NgHp1tWkcOfOn2VsXmm6hgpOw3ZwthM7TZ0Y1LYoiGMd9tAdKK?=
 =?us-ascii?Q?von8t/qeMrW7gVm77BxNj77DiZMVDo3Lo9Wu0TVahP9TkRhNgQy566lYXSJh?=
 =?us-ascii?Q?1MwabMf5fYII0MKYOvw+UQqbaW/dJVu2WJmjIAzZ+NyD4pvjtjUTBXmq7/+R?=
 =?us-ascii?Q?kbRszEn5c91lnRvuNrRE8J3Kg8cQ++ltjIV7WQd7MH1r//E24AcMdDs6+cR1?=
 =?us-ascii?Q?M4AFiZ0Lrj49tXymc+Qkc+RGqjPNiYpEIoRTMLF3BymV5S8/PVGTCGOkm08c?=
 =?us-ascii?Q?k+8Vuc7VJhlS8IQojVJ/ogzYsganEyncKKWNDM83Yc1e2omIreD9GOmqNU/H?=
 =?us-ascii?Q?QPiuZHi8Bt1/cqTse9AriIxNkjiYLh1UBcSJC3mWHthzBT83lTxWXndP5Hxw?=
 =?us-ascii?Q?Bjb2kNJvPWnvSqVdDFgzPb5PTeypRU2zLrBULpoT0cfmlsVq8bYbrMT34NqJ?=
 =?us-ascii?Q?eEuM7we1DEOwq3bEMcdBFrl9zYb/Ay/4zVgjUiUBUlRw905Xzm7OcGF/alWT?=
 =?us-ascii?Q?5JWH3cgvcSwb2JSvmQiQedXpD2lo6a+lbfz6RK7SdU8ZEFQvG4Mi1ChTSJKL?=
 =?us-ascii?Q?HQNZIZJrWuLITu+AwPCZmZEWaaJeCvvj52ECQ9w60ZoJaNMJIKIS86V/G8I1?=
 =?us-ascii?Q?tF8TuVd/s3GXPUwdU16osRX7z4DmsWOPg8UT53A65JM5BEFO53Oc/JZsoMmc?=
 =?us-ascii?Q?Ta4HDULeno5aZGiDDQd6R9JNfLz4Z28YIq4I07jk08f57dZhhoPaBlicKEnT?=
 =?us-ascii?Q?HwF8o7azJbS7E6WjhfRjEyRYHsJYMn3Gnmi7+sooLcLNiuefYLIlgy1PqR6l?=
 =?us-ascii?Q?jbhi96jVV//L6MxKKkCMeEBFX+Kz0e0e6+F7Eh9XZeuN/UnBksK6Lo7iCdfZ?=
 =?us-ascii?Q?6FjRt9T6Syye8r6nXSy4CysIoFWyP8cst9ER4KCNIRMbcxDyAX53Jcax3C9M?=
 =?us-ascii?Q?OCV06FKJcGZZLuXrxsfM36m/URLyWnu4jJRaBSpw?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e2be0644-e4be-48a8-f922-08dd52a597f1
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 18:28:52.9992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSrx68tIq768P2aWKdcyvw4irQLtQlJT/SbNWVZ+kw5aOUg2r0Z51t2z9q46Dk2YpanrVHYjl1bQLpydMqM3EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6856

On Fri, 21 Feb 2025 12:27:46 -0500
Tamir Duberstein <tamird@gmail.com> wrote:

> > > > @@ -412,16 +402,14 @@ fn clone(&self) -> Self {
> > > >
> > > >  impl<T: ?Sized> Drop for Arc<T> {
> > > >      fn drop(&mut self) {
> > > > -        // SAFETY: By the type invariant, there is necessarily a reference to the object. We cannot
> > > > -        // touch `refcount` after it's decremented to a non-zero value because another thread/CPU
> > > > -        // may concurrently decrement it to zero and free it. It is ok to have a raw pointer to
> > > > -        // freed/invalid memory as long as it is never dereferenced.
> > > > -        let refcount = unsafe { self.ptr.as_ref() }.refcount.get();
> > > > -
> > > >          // INVARIANT: If the refcount reaches zero, there are no other instances of `Arc`, and
> > > >          // this instance is being dropped, so the broken invariant is not observable.
> > > > -        // SAFETY: Also by the type invariant, we are allowed to decrement the refcount.
> > > > -        let is_zero = unsafe { bindings::refcount_dec_and_test(refcount) };
> > > > +        // SAFETY: By the type invariant, there is necessarily a reference to the object.
> > > > +        // NOTE: we cannot touch `refcount` after it's decremented to a non-zero value because
> > > > +        // another thread/CPU may concurrently decrement it to zero and free it. However it is okay
> > > > +        // to have a transient reference to decrement the refcount, see
> > > > +        // https://github.com/rust-lang/rust/issues/55005.
> > > > +        let is_zero = unsafe { self.ptr.as_ref().refcount.dec_and_test() };  
> > >
> > > How come this careful handling is not required in into_unique_or_drop?
> > > At least, the SAFETY comment there is much more mundane.  
> >
> > Because `into_unique_or_drop` doesn't actually remove the allocation
> > (it only decrements refcount for non-zero or turn it into `UniqueArc`).  
> 
> I don't follow. This comment here talks about a race with another CPU
> decrementing to zero; isn't the same race possible between any
> combination of `into_unique_or_drop` and `drop` callers?

Oh you're right. It's indeed the same situation. However I'd want to
avoid repeating justification multiple times, given that this is really
an explaination note to the reader. Do you have any suggestion on how
to organise the comment so I can avoid repeating this multiple times?

Best,
Gary

