Return-Path: <linux-kernel+bounces-528014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E621A41280
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 01:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AB773AE81C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 00:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0E717579;
	Mon, 24 Feb 2025 00:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="V9jDSFNc"
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021075.outbound.protection.outlook.com [52.101.100.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D1010F2;
	Mon, 24 Feb 2025 00:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740356880; cv=fail; b=pGoLVfncf6bNOZUKX45e+O1NYtqU1clxHzvknE5pLbELVHqbnCBESCeR7rQvpoGIsQ689DQhYw+3K7sELYTB+EQbNn0Ipg3NnnzEONQC9kN1N9M9hJnryjGM2NUuKBy9k3Yejdq80+UYGq0/Ig8imbjvSxUIsJVRUIbwDlanoz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740356880; c=relaxed/simple;
	bh=OPAOE2jbDvoweIh9wMyM3T/qvA9Ptw2CiA7J0Qk7mcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ap1IR0l16XoVbYnsYlyJXPWnzX3oGDirA6WBnMQ9xpKIijOf2XjA9Eemso5WUD/Vm65jHP9mw/A+SkuKwEX+mExH3anok2ULlMzkkvxrBBov12CbqQd68J4p6od2eNJ/hhGx4ybrv+1GdLRBoUY4btlBJdCzyEPJt41f4+JfVLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=V9jDSFNc; arc=fail smtp.client-ip=52.101.100.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tp1gNuill9GVb+qHIFSbGz/jstsXoBqvllT8fPm9KF5GSZPTBhuwDhMcVie6UIYMobMc3QGDw8dbZwWAhtDmaMOrHLKnyktyygdp9mFU0lK8/JK7Wi+eE6JVbzizD4pfZDIbkNXYOtdZplRNaMYIzy0bbhhFOmwnT56+hDtI1tESjE2rFQlzPSQSW560Op9aSAxJJdX84oPZRPwVkAfBIrn9Osc/hRFrbBlS6Qxxg/sNgFZOvlwvSJLoiMdL13xnao+GZwG+7OMhJeRyzA5Gnw/bZsDCNQYwMK+sZfnxCPBsGnWEeNg1t9w8g1N2H3tSLJkKmcX6QZvuzYQI9KjF/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jsRqGjDslaEvAnRYFgEE6B6BFBa7NJAwDcV02Fd9ce4=;
 b=pSPKZ4X2Y2+WB2FYAO01Rpwznt3l80sCHB7oSlVwAreMI9wdViNRKc7RzKLwZ0HKTjDnzGktVna+vcthxSWHZDkfo7y4R+4c64u8ThS5/Aai/w1GSIuMEXNvVq679FGiMfYKLAC7oJyo1ys5KRAYKBhiSyCh23GHzNNCOgd3n8k0iWKZuUXtQTtVx3jtDtfXXdXX6ttHjPVIRTjJ+Rd7f1W9IQniqn1abJa2y4T6+avqpGHzPWVkSDHYmS6DGxWuwhcNyAagWvEgtXaLBigSvvaiqUfjZc9uVStBltRgsQPuNLhel04D3x8PvlCxPhqcy9sEfA2zMkql4MuQraQ6cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsRqGjDslaEvAnRYFgEE6B6BFBa7NJAwDcV02Fd9ce4=;
 b=V9jDSFNcz0DQCIJl6XDFvnxH+XNoaE9U9/Kz96GTshJjttrnvmKUv/DaR+ClHlnlHYUw5fKgaM2MIFyiBCUBdcv55b7c0fiOs9/Ow2G4Yxh15Ht3YCsgenAI3kPOYIZZpfCCqGW9fjCrEDOSnepEOw7zoEn3el4DrhmXPdIrDTE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB2707.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:a9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.15; Mon, 24 Feb
 2025 00:27:55 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%5]) with mapi id 15.20.8489.014; Mon, 24 Feb 2025
 00:27:55 +0000
Date: Mon, 24 Feb 2025 00:27:45 +0000
From: Gary Guo <gary@garyguo.net>
To: Ventura Jack <venturajack85@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Kent Overstreet
 <kent.overstreet@linux.dev>, airlied@gmail.com, boqun.feng@gmail.com,
 david.laight.linux@gmail.com, ej@inai.de, gregkh@linuxfoundation.org,
 hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev,
 linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com,
 rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <20250224002745.7d7460a7.gary@garyguo.net>
In-Reply-To: <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
	<20250222141521.1fe24871@eugeo>
	<CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
	<6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
	<CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
	<CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR04CA0085.eurprd04.prod.outlook.com
 (2603:10a6:20b:313::30) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB2707:EE_
X-MS-Office365-Filtering-Correlation-Id: d6678cdc-33b6-42ba-0f32-08dd546a1526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HUF10OjywrY7fg7xScUzA0hdracTbN98pn0WxUiqYSbk4fpNnUAV9C6HEA6r?=
 =?us-ascii?Q?w2WzTyb8J0L7JdqUNvOVO/VEJcOYD6jCHWAlirQGnIFTByaObOeOplS5nrFx?=
 =?us-ascii?Q?rwBZZbRtzdUT9r26w1+MH4kSNe1/sCQSHn/pW4pmiXyVNlxMwz6Y1Q/h3KK5?=
 =?us-ascii?Q?iUvhaHcOJoW+Wfy6U3K1/mai7y28AQyQ+fp/P9oSQgT4ILBFp40J4qz+Q7DM?=
 =?us-ascii?Q?BkdghqNhgIPq6KdOWD8ykBwaD41t+FNwGcNvyl2i0C7WL7MQeKdnxw1D9fTw?=
 =?us-ascii?Q?rKeESpVxm3FxPoryuGFqMeknhA/BaNXNb6pHgkUejrHDqiZSVn+QHNOS/wfW?=
 =?us-ascii?Q?+dBIAWjG5LPw/wPzxcqfv+X5OlB7i1o+x04jnlrfQ7jXk0HBZQJfv91aGPPq?=
 =?us-ascii?Q?E6QU7CgriGU8mDqXRmp0YvGfrrQqnC7M+KHCe7s8126mD0MXC90EFgSfxd/u?=
 =?us-ascii?Q?gPEgcelznj6LEb59/aolHYSe0P2S0gLdcMHuVbNf1g7Yu3EP75mz/ZCvoAKO?=
 =?us-ascii?Q?j3B/IjdDm7sGFsTdI9Phs2gdmGiwiIwS7T4g42rQ3YpTd92ni4SIm67lnJF/?=
 =?us-ascii?Q?pglAumn/GSvLtEwiVSgnBb668kneYUmYP8vxVUERFvQiUAUjdGvAUyCninDq?=
 =?us-ascii?Q?M6+/TsDLtwEBObKOY3XgvHDxPimeMCvkl6eZpMGRdSCxRWu3HjuvsRf8kWeH?=
 =?us-ascii?Q?ZUXF7XaCo8v/xvataQkIRa9hpUz5cSfHB9VaIPfCsujNaKmmIJdNFc7KecuE?=
 =?us-ascii?Q?ELWXyf0CiQMjXLKPO5/Mm+4kbS7ziaAeHR23thU8V+S8IMhg/dE2r1PBz0F6?=
 =?us-ascii?Q?HtQ18APe96VKRKog5fplO7V7HA+EOnwutvDtIoQO8AF3MyjIxaYdmTkRNDMC?=
 =?us-ascii?Q?LY0stVG2GbjPLEgENsG25p8+T+rDSEQy81dFY40aDybz0iEeskO8JVyAsMxn?=
 =?us-ascii?Q?+yYycO9VQyMSwp1T7jqjvXPGXlLKB4ZdMCkMGyqn3GjGCmp07jJyLxD5gau0?=
 =?us-ascii?Q?c+6Grx63NQ79Ii7qzlQeQbhgjWIAXlEAB5+eXIQQxHOrTcXTFADouW4hwIU8?=
 =?us-ascii?Q?g4E1t7gaG1EQTwr4dXgtatg9noXGUpxuKFzfHpz4C1Hl8HX9+udUM65ixYHH?=
 =?us-ascii?Q?eFranGzX0FKGcIVoaCqvlxGsZ90Shtr2GZEZxOX0lQyEjShxDCMQmSCVMPKz?=
 =?us-ascii?Q?LpLzcyP5S9L/utk/R/HxqZHKHxBB9xpOOfMKWOIQBNjoMD4p/jFqyCItUbwx?=
 =?us-ascii?Q?BiwCOtq+aeTVvB7QdA3a1stpgCZRwM4L4ddXnsQkNWM5Gi2Cq4mkqxxCNTMS?=
 =?us-ascii?Q?yS1JS2S+/e6cykbYV+hlXS7C?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j0Wgr5bUnwXtaIBKtSCqNM/jd509hooTjThPQa1g83wDN9t0P5eauhtfB4bW?=
 =?us-ascii?Q?Qznj26XKozZ0THeuVv1dEHe7ASaB1fAvNAPfTR8P7BQJwo2Rj2jjyX3+Oi3v?=
 =?us-ascii?Q?g7c89mpWBWdgw7OM9/Xgtkweqoh7VwpOQd+eNP/L5gQntPFeOS+dWAiuDBzg?=
 =?us-ascii?Q?ckh1oCMgDefhrlSAmpIJBLH1oq6w2S37cU6J2sQcsEcQrCTff8d+8JTFAJRg?=
 =?us-ascii?Q?7eXOd/Q2KYxLfHRILCBzo3EKpoa2FlAluypp9z7NSmmYQMZ/3Wl7yrfpkmSO?=
 =?us-ascii?Q?6QEaXKXyxWVQi8ifuu4VMAs5Lk64+hU+SCLjAHrKWICchvE9o3fSPBmo+g2r?=
 =?us-ascii?Q?uWfjoEY/PjH/V4LYNsnZUt1SFCoGkydkDCH5nJMlXmSzmjLsXXMFMLc9k2tu?=
 =?us-ascii?Q?L+1ttP6SeRi3K6vuQcOlfjlVsjq7kV17rtLuEmJg73AISHpqFtE2FMO3aHGC?=
 =?us-ascii?Q?MjP/YNh8FCieXL89PbSypA0UJTRTT0yE+sUAIdUN3RKFEa4Yl48/eALxZCWC?=
 =?us-ascii?Q?S9BWXUmzHcztAR6CrbKpwZD5VFWAwXEsh+wrXKAHd8WHWJltuocoE479o1aG?=
 =?us-ascii?Q?CpV8Q2YW5XfTH618IUcMSSRvvSIDhqXg35Wc/LOh2QZh75mE+xUYCuWl2vx3?=
 =?us-ascii?Q?tfo9EfJB+ZEjYdv9R/3O4rlSo+gODkIM9SlUjSkPWmcUynC8gA/o/ZdHDg3g?=
 =?us-ascii?Q?ktmegcl9vH+ME5z1caHjz7HZqwXCTV3JVacaTSfebZwLv2SQor1i4DcoxLtV?=
 =?us-ascii?Q?GyjrvvSgfR2iqi5c13kHDieF5zPIRJHPbDXcm1ZwIhZsn3yiRCFJCFz1xRb1?=
 =?us-ascii?Q?/5NMuNppbrTc2xnrXPNTyEASzBHuS+hH6Rxlv00qamCqYDXIhOhcEPNK3WTa?=
 =?us-ascii?Q?BEjsyLRn9hTp500FEbAmhwGnP2v52pgClUq0+/M3Rk8J2NTplXijGK8DVn+W?=
 =?us-ascii?Q?JpDssgkoinIeB53KD0EBRu7Hl1uIrPaL0sx8bKwqEgt5+RfjTmCsNX3/I/8k?=
 =?us-ascii?Q?L+5iNlUSJlcDqrUOGkEto1DSIsYuw9vhRQlWdP/YE/mcTFN4OWpO2m3m1GrZ?=
 =?us-ascii?Q?6suKwDYAC6OvH9R+nYQlxVx1ojUmDRjH//SmerdpfyQOv75gSVR3rktdwq4Z?=
 =?us-ascii?Q?f8oZPwE0nOwhijzfcZUeOr/KhKSJZVB4RCHHfGZ8TLhxpYXKZJb73UeFwkzW?=
 =?us-ascii?Q?oKvOIz2Zfj2I8rhtl1IXOmSE2P/tzKZGCyeHTCgK1oPN7F9a+vX8eMc+lT3e?=
 =?us-ascii?Q?VY4rRAL4JqtEx9IscnQ3v+atwYzl7suzerde0OgCCbDhBtGDVY2yoeQKdk2u?=
 =?us-ascii?Q?RHYXy5nIJJ7vEEHbEK/hza3ax+9A5vkESWz9AbFbRL03+g+mulNiF/pWowQF?=
 =?us-ascii?Q?85IbnMXFT37+npZJd1TXRmQcpS3AI61n4h5jrODH3djMKkG+Caxe7t/acVJO?=
 =?us-ascii?Q?SZF/9uuqOHGs3VZsdnDBavFi6lXJERD9ekA0Hi9YQrXaIemhT7EUhorva0hH?=
 =?us-ascii?Q?7Uciolg8akAA3lAZ28/8soXB9Y/4R3WFGyUQGQ5bRF3LkvmgkjSBRDyw6EtI?=
 =?us-ascii?Q?0bKRvxPOWt95OIgulfbyeV/GTr2d//gJPvflApL9ZHDk1HrqP50XKGGYRxzG?=
 =?us-ascii?Q?CA=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d6678cdc-33b6-42ba-0f32-08dd546a1526
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 00:27:55.5867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dd9rvC0i4BbBLhzmP2UM8apAzohRWcsnShscz307Ofen7U/HlMi1fuJ3jGBKUPRWb7cKGhO4P08hYi1431xmOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2707

On Sun, 23 Feb 2025 08:30:06 -0700
Ventura Jack <venturajack85@gmail.com> wrote:

> - In unsafe Rust, it is the programmer's responsibility
>     to obey the aliasing rules, though the type system
>     can offer limited help.
> - The aliasing rules in Rust are possibly as hard or
>     harder than for C "restrict", and it is not possible to
>     opt out of aliasing in Rust, which is cited by some
>     as one of the reasons for unsafe Rust being
>     harder than C.

The analogy is correct, you can more or less treat all Rust references
a `restrict` pointers. However it is possible to opt out, and it is
done at a per-type basis.

Rust provides `UnsafeCell` to make a immutable reference mutable (i.e.
"interior mutability"), and this makes `&UnsafeCell<T>` behaves like
`T*` in C.

There's another mechanism (currently under rework, though) that makes a
mutable reference behave like `T*` in C.

RfL provides a `Opaque` type that wraps these mechanisms so it
absolutely cancel out any assumptions that the compiler can make about
a pointer whatsoever. For extra peace of mind, this is used for all
data structure that we share with C.

This type granularity is very useful. It allows selective opt-out for
harder to reason stuff, while it allows the compiler (and programmers!)
to assume that, say, if you're dealing with an immutable sequence of
bytes, then calling an arbitrary function will not magically change
contents of it.

Best,
Gary

> - It is necessary to have some understanding of the
>     aliasing rules for Rust in order to work with
>     unsafe Rust in general.
> - Many find unsafe Rust harder than C:
>     https://chadaustin.me/2024/10/intrusive-linked-list-in-rust/
>     https://lucumr.pocoo.org/2022/1/30/unsafe-rust/
>     https://youtube.com/watch?v=DG-VLezRkYQ
>     Unsafe Rust being harder than C and C++ is a common
>     sentiment in the Rust community, possibly the large
>     majority view.
> - Some Rust developers, instead of trying to understand
>     the aliasing rules, may try to rely on MIRI. MIRI is
>     similar to a sanitizer for C, with similar advantages and
>     disadvantages. MIRI uses both the stacked borrow
>     and the tree borrow experimental research models.
>     MIRI, like sanitizers, does not catch everything, though
>     MIRI has been used to find undefined behavior/memory
>     safety bugs in for instance the Rust standard library.
> 
> So if you do not wish to deal with aliasing rules, you
> may need to avoid the pieces of code that contains unsafe
> Rust.
> 
> Best, VJ.

