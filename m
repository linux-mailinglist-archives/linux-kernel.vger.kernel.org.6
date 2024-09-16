Return-Path: <linux-kernel+bounces-331156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0608E97A93D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 00:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 747131F28794
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 22:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D8A15D5CE;
	Mon, 16 Sep 2024 22:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="DJjJcnhL"
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021081.outbound.protection.outlook.com [52.101.100.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E201613C9A6;
	Mon, 16 Sep 2024 22:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726525852; cv=fail; b=FDheKKAVqF4e9KBg7ydgo93OHJ1iv3uvLvz5CSS79RYZV1cJEW7brvh6j5SfrPBWqvx4stKeefrbY7HSscxJ/lhBzuGYBqfgETB8XNUojljM6p5vyifgXcjChcSR8g7E7/OyAoObuFCgQIpX0SWtyTh+gWh4/bsrNlgs30dQI/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726525852; c=relaxed/simple;
	bh=iJMzKZvRHbvBsWbmJn0Xi8Cgu0MFJHVS/vBAXzeLm48=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fNjVzOndlAx/mi50pergpajMW8vtYfVs+iw7KIB2xXoFG1BhV9BjNdg4caqPWNVLtykihZsHHwyvLjOvwN50b955xxcMo19TzikmsgTHXNmTHSy2cFOwyXZzNZGgB/YxD51217BZJ0RW/ANM/AH0BYLmRBP2Q1s8DWMXG4M7WyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=DJjJcnhL; arc=fail smtp.client-ip=52.101.100.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uy/q06Qy2jUXpOMtG66FoEY5oP6ezRxfAw3nI5JHZQi0YFkC9NG6xyrPOcdFo1/LUxfkh5thV0NKZqepVUPgC3GUPRe1vdMT+tfNDl5vdw9b+fWV+dmFzRBOG+BSC9daCZA+XFvOiN9+hL8vIWXfI/oSuyYaKqwi1/QqRx6lc0MQVyX7PCj62eULCRr8TlxbKvGCYvVMGFQjSmGLktnI/lDV0nSbcPMe+xCqtEGQ+uWopRwlKMSRWtOdBSDbyp3OyCCU2Y+28v6MqobI2A/c+BYmaJTfaaPTlwAntWOqc2matme2RMG7IANe5B95kGhv1tMVTiEbDi+ws9mDqN3mwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVUMrhr+ajcowXqAPpi+EkPq4A4AoFvgQumaLfhpSeY=;
 b=r/e6+20YbmKtaDkBd22UH0ExCXio4UDTFIMC2pQW8ppPwp1YxxUvJMub7F6nnwvfDbKFuEutNAE5pcBH/PrUl9IC66ACQgfD6bFgsdAuPUrx5qCX8FFrnuGaVpeGWQPllJ1aTffBwtk17Wv/tYgdqCTaCxKOmRHXcL9lxCt3yuM2MoKvwIqNEVFdJ2PE5ICUsbTC8BlGjSaT8dJCMUSF39YhbmdWPr2nTTMqlPXKVLfBLKulu+5EOUMbQzanm3FipN95gH+aovuiiQormO7JMTX6bqdLADu0gxD7ntlN18vX2Ac2o1Xwlq+FzsHqbfLpNKcyqZH17JRh8s9rqGaLJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVUMrhr+ajcowXqAPpi+EkPq4A4AoFvgQumaLfhpSeY=;
 b=DJjJcnhLA2IwOIOuh4fbNDIg8S0kiIx7Fk7MOwMIQ3GvHZEVSpmJp5xFQScWDsQ+THKrEh7PN7KS0IzvYHWMZCf/QmEu0fZjUDrIYhSx4q5Uh3o/DzobfMMKBvkqJDm5lquKqoJWlZ6J4xoO+5TgUdWOvsTjnOVHjD1xpWFHnC8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB2626.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.25; Mon, 16 Sep
 2024 22:30:46 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 22:30:46 +0000
Date: Mon, 16 Sep 2024 23:30:43 +0100
From: Gary Guo <gary@garyguo.net>
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>,
 airlied@redhat.com, Ingo Molnar <mingo@redhat.com>, Will Deacon
 <will@kernel.org>, Waiman Long <longman@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun
 Feng <boqun.feng@gmail.com>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas
 Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Martin Rodriguez Reboredo
 <yakoyoku@gmail.com>, Valentin Obst <kernel@valentinobst.de>
Subject: Re: [PATCH 1/1] rust: sync: Add Lock::from_raw() for ZST data types
Message-ID: <20240916233043.4c06abc7.gary@garyguo.net>
In-Reply-To: <20240916220818.567277-2-lyude@redhat.com>
References: <20240916220818.567277-1-lyude@redhat.com>
	<20240916220818.567277-2-lyude@redhat.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0027.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::17) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB2626:EE_
X-MS-Office365-Filtering-Correlation-Id: 14dd4767-bb28-45db-cf87-08dcd69f3555
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ktYZQyAs6sKomnexQsOdfIwFpTcgO1y+5oc8NEC4T9JuBhqFBxm5rIxe7GRi?=
 =?us-ascii?Q?sfwfnHp6ywlo7QFuEWKv7V+duxqL0GJRq7priEvcsjxoPoVbgFlNjx6C900o?=
 =?us-ascii?Q?/gTuhl7kuzkEB1+A9SsXoHZ6J6b7ROqJC8tXaTqQT3IPW1y/Ak33J4GHrk9r?=
 =?us-ascii?Q?cs+KkbdCzjCZbvVvbLNNfzWaohcE680aIoLfL6UExvkZhVnOjkeAUoCA3qNe?=
 =?us-ascii?Q?goxAO8c2eEnsVgjNMJPm63+ohdBwIOxqetVOVbx6Y5mqbiRid3CeBwpG9qtY?=
 =?us-ascii?Q?i6Dd385DtrRCrUAhwKZKU6chjPHSg/OFFYvwl+fR/wyuAoe+ObXFhiIptz61?=
 =?us-ascii?Q?VrdyIxjbkuTJvqFaetaygBGN27nOS32QI0KDy0WilgjjiMKwgaAj4lpl1ymR?=
 =?us-ascii?Q?/m969AD8H+lNCwEGiwZSTRwbR4LIZOLBQ28x1dfI4m94QSFVEdqycTkd9j9I?=
 =?us-ascii?Q?QVhLjMCU0RTNBymQc0jY6xxt846U0atSPpBDa7mrQcfWwZpuMJRMK5yjQOpl?=
 =?us-ascii?Q?eXzaIgFpL/CVmtsbhYlQzUtIYmmNUoeFPdNJBQBCASHmrjgU1+CzKJOrIr0+?=
 =?us-ascii?Q?AEjxEM0PKZ4uL9abXBQ2j7TxqQNJ59Wy7NXL9ABN4jlgP1efP6Z3qOtnj6uw?=
 =?us-ascii?Q?e3LQ8J0Th/Re4pelxPJJL30LNLM+RxqGjyhXBNG/b22q8DdJzy/aFXefkjcC?=
 =?us-ascii?Q?VwqvpmRwq90ux+VcL5YgtVG4IX2g6XVZMgs5/QSo9x8mj5AdWl7LlFkPH0nO?=
 =?us-ascii?Q?rq2qmT7wR33NqAVdocO39ojEJyAY3pMIoOCaLs8YxqHskokCTEBG9wqtfYZE?=
 =?us-ascii?Q?XBJNf3PwYT+F1Se8YXGL9660iWn2+h1izhNJiQXxvdGBCnSglmDzWbuCf22o?=
 =?us-ascii?Q?onE1UljogPYDQ5AuBLTEXGFO3/WfmMMUEIiKZ/4Dl6pwfAb54j3pSQYuLIDw?=
 =?us-ascii?Q?OkZsNklivpO05Z061Tx4yHBv8oK33+cOsLx1Isrg7+cLF1+sLuK1sbTisrmz?=
 =?us-ascii?Q?oRTmqmZ0t6r7IBPh+XPLOiVTWKbOJhiojxeE+JAc8BX2lTptjVRSDZuus97P?=
 =?us-ascii?Q?NqbTZiHtKd4MtQffwtSLDZZXD5bJcI98mMTpM44Cuhn8BZjvrLWMPDt/nZuN?=
 =?us-ascii?Q?YtHHcYROM5zUtodMyOJvTya+GlHWrTjoZKxWp+ouciHLc4MpD5QQSKSV9/ff?=
 =?us-ascii?Q?BlV9nFiWOtzDh39XoReEF95/01Tr/XbkZRJw5dksnZcdXHXp7GIsEU6vP1xY?=
 =?us-ascii?Q?E0dZTiwq86JmIMYqe3IW89otXn3Z5bhIheymcV/MtsidPphc7Wyg87qCfGsS?=
 =?us-ascii?Q?RoXKhNgmK44GTFaqtQvvPmCSTXMWKAZdEd1OOZow1BCgUg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sTVe7Muf0y2WKZzUVu2OhFh9nN+3XZxzqRDmV1lj2UC+FIZjMCnU+3VtokKY?=
 =?us-ascii?Q?NIyBY5N2DZwL/Ck03izQXIf5OWA7Yjy3CAtEKIFFInsrqjs/KVlscH3CaADD?=
 =?us-ascii?Q?VT1WsZMoPUjG2B0IEwpv9n09QGJvt8aoXyU/7ipS1S5FBMst6s3TirkGDNGN?=
 =?us-ascii?Q?uDSh/4TzXhS2JL8tkZcfrEtfj2IKTXaq1jUFBCv+XOdKz3za6G6zlBvaoXDe?=
 =?us-ascii?Q?7jjUf2PYNji4n/L6OPq0TO/JTBUvvYS+bRnyquI1IPS5qwk0OfdU8NF/JPi8?=
 =?us-ascii?Q?rNJstspn7/nN9TCWjhYXl00UdzKC4VzERg6W+9sUS50kDxdgHgRUKjBLMvb2?=
 =?us-ascii?Q?sa4n58PSmRABXml29tHRMN+zoDgPIcO93U2X4SSMAqFilINnSpYtDyV+9aOu?=
 =?us-ascii?Q?3Feib4dakSISw8Qqpw8vwQLlePben+Bo6SpuBWoj0A++0nipgg67IWGEjVBd?=
 =?us-ascii?Q?U/vPHR9DH5xuP3aVaVNsZkK3IiIch0DZiXQxtyLZCpl45RNwQLZ9Ze0Yx5jd?=
 =?us-ascii?Q?Ciao4nesogZlyODyQzG1oKoAS8ELt1PtBkvaBK5FJ6O4RJ42JjivMqXG15+D?=
 =?us-ascii?Q?r5GPxObKn7v+UgQasnnOB6ZpYcEolR3VM7wYzo/CADuBrhdYwPxjS/BtaK5E?=
 =?us-ascii?Q?5Ag9MlzoRH3C86vd3CezUJyl0HCP1Gu3bR1iYS/nlhAcowbPXdqw+oCgtAhR?=
 =?us-ascii?Q?K5TkVF+GyR6PXqw5NU/sPJtcS3tm/3iclwaPEOEh/XAc0Nt0JEa1VAE//EqH?=
 =?us-ascii?Q?gGRi/JjVIah4nha1jtrCMvZJq/jKCAoqu2dDA70TIA4jLRMnxl1IOSEjEqtf?=
 =?us-ascii?Q?eb5OHRqK2TrL7VAIGne3/BsvLwndcevNHTseME1QGhKLu6Kh8hJETcCQg5Nq?=
 =?us-ascii?Q?tqUdxWUFP6b8sClYsO5WTOjSdPH2auPoLnKySVwykyiZVh7A/x+LeiKSccy8?=
 =?us-ascii?Q?qq4KfVJN6MzI6OaifJAWcZbdimw4QaFJqUyGOm/k8+bIxPjt/jH6pUMQYnw4?=
 =?us-ascii?Q?POJJb+MUbVaCMnvy7pqUWTBTjX3GX6zqX4hJU/47+hPf4wEf1mIPykRv+Yts?=
 =?us-ascii?Q?Bq3vS3TvyY+o9xGlDRy3WgDlY1OKs9ZkK6L9wRk1/RIGsScVe5QAyqw+I1jv?=
 =?us-ascii?Q?fbSbhFzm6KXpr1u8+8rQfUWoGCZ9feJbIKwGUus9lN+H28Xzls5jTin3S7LJ?=
 =?us-ascii?Q?fzrrxSRmDj5n2mmAcukrlX/Aib/7s5YD47FIH93CqyHId39nMhxBiOQvXO4l?=
 =?us-ascii?Q?J3Y9wOuT5/i686Krd0fdq25SZkfDEBE2w4xVY8LMd0nF9XkfID1eKkyzsWUh?=
 =?us-ascii?Q?ZlSKtEJqZsh+VIth8ppFS1uZH+WC6OmpVLJL4tQ0+8EeAVeTk9bBr/CUzSpB?=
 =?us-ascii?Q?ppOX9YOHIMdk60szkuEU3xY2LACDY0rfMprzUryNmX47rOFH5cMXjU0LvTu5?=
 =?us-ascii?Q?nLdrwIBHEtzDAklj+aJqjsU10qvYlGURcICVl3Vbl2w1j+SJDJVSJTe/Dzq0?=
 =?us-ascii?Q?0In1t083iP6oXnSMFjMN6jImvtuNKD+iBJUNUYqLAIXW4ndaPb1/xZECEC9J?=
 =?us-ascii?Q?2q0ISVJCMKXmAeS3ppJ3m6dG0aV7f3MH1nyxO9maSdNySau15KzeXWHMA5k1?=
 =?us-ascii?Q?1w=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 14dd4767-bb28-45db-cf87-08dcd69f3555
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 22:30:46.4040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Abrp7ulrvJHDEzcFz1eKVKomt4FYxDivLcdrmYQH2GiVbVme+EurgbX0qHD/l27RbDIlJYz86bd/CIFs+XFKqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2626

On Mon, 16 Sep 2024 18:05:46 -0400
Lyude Paul <lyude@redhat.com> wrote:

> A few of the APIs I've been writing bindings for (KMS in particular) rely
> on the user manually acquiring specific locks before calling certain
> functions. At the moment though, the only way of acquiring these locks in
> bindings is to simply call the C locking functions directly - since said
> locks are not acquired on the rust side of things.
> 
> However - if we add `#[repr(C)]` to `Lock<T, B>`, then given `T` is a ZST -
> `Lock<T, B>` becomes equivalent in data layout to its inner `B::State`
> type. Since locks in C don't have data explicitly associated with them
> anyway, we can take advantage of this to add a `Lock::from_raw()` function
> that can translate a raw pointer to `B::State` into its proper `Lock<T, B>`
> equivalent. This lets us simply acquire a reference to the lock in question
> and work with it like it was initialized on the rust side of things,
> allowing us to use less unsafe code to implement bindings with lock
> requirements.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  rust/kernel/sync/lock.rs | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index f6c34ca4d819f..f77cb178840b2 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -6,8 +6,8 @@
>  //! spinlocks, raw spinlocks) to be provided with minimal effort.
>  
>  use super::LockClassKey;
> -use crate::{init::PinInit, pin_init, str::CStr, types::Opaque, types::ScopeGuard};
> -use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinned};
> +use crate::{init::PinInit, pin_init, prelude::*, str::CStr, types::Opaque, types::ScopeGuard};
> +use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinned, mem};
>  use macros::pin_data;
>  
>  pub mod mutex;
> @@ -81,6 +81,7 @@ unsafe fn relock(ptr: *mut Self::State, guard_state: &mut Self::GuardState) {
>  ///
>  /// Exposes one of the kernel locking primitives. Which one is exposed depends on the lock
>  /// [`Backend`] specified as the generic parameter `B`.
> +#[repr(C)]
>  #[pin_data]
>  pub struct Lock<T: ?Sized, B: Backend> {
>      /// The kernel lock object.
> @@ -117,6 +118,33 @@ pub fn new(t: T, name: &'static CStr, key: &'static LockClassKey) -> impl PinIni
>              }),
>          })
>      }
> +
> +    /// Constructs a [`Lock`] from a raw pointer.
> +    ///
> +    /// This can be useful for interacting with a lock which was initialised outside of rust. This
> +    /// can only be used when `T` is a ZST type.
> +    ///
> +    /// # Safety
> +    ///
> +    /// - The caller promises that `ptr` points to a valid initialised instance of [`State`].
> +    /// - The caller promises that `T` is a type that it is allowed to create (e.g. `!` would not be
> +    ///   allowed)

I think "allowed to create" is quite vague. Is `IrqDisabled<'static>`
something that is classified as allowed to create? It is not an
uninhabited type, but it does have invariants associated with that.

Do you have a need for `T` to be arbitrary type, not just `()`? I would
prefer to see this being an impl on `Lock<(), B>` if you do not have a
specific need for arbitrary ZST types.

Best,
Gary

> +    ///
> +    /// [`State`]: Backend::State
> +    pub unsafe fn from_raw<'a>(ptr: *mut B::State) -> &'a Self {
> +        build_assert!(
> +            mem::size_of::<T>() == 0,
> +            "Lock::<T, B>::from_raw() can only be used if T is a ZST"
> +        );
> +
> +        // SAFETY:
> +        // * By the safety contract `ptr` must point to a valid initialised instance of `B::State`
> +        // * We just asserted that `T` is a ZST, making `state` the only non-ZST member of the
> +        //   struct
> +        // * Combined with `#[repr(C)]`, this guarantees `Self` has an equivalent data layout to
> +        //   `B::State`.
> +        unsafe { &*ptr.cast() }
> +    }
>  }
>  
>  impl<T: ?Sized, B: Backend> Lock<T, B> {


