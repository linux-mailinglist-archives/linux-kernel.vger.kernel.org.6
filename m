Return-Path: <linux-kernel+bounces-309002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 907DA966503
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47F2B283A2A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8342A1B3B34;
	Fri, 30 Aug 2024 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="KGYDYcKG"
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020142.outbound.protection.outlook.com [52.101.195.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93E41DA26;
	Fri, 30 Aug 2024 15:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725030602; cv=fail; b=J5MSVsQOhvwsSEK3eSr0HwpQKhybCUcW0UA83Y6+XG//nbalZMoYqWvaG1EBvGmXWFewmZXb6txgaVKBPc0q/bCE5/YFqxdALiwQ3uFLsOMzPfj0kDrPNU/KcoCDdoan3EEohk8h0MXXnMwEGJVz25l7uyUV6duk9sxFMeumdQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725030602; c=relaxed/simple;
	bh=SqLdn6wg8gDpPHc4tus+SR4LgsiO1mgWKnSUvhka1Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TUYC6gddIObqcLqdrpgD4jgtKF7/jEdyUqCr48d13GdgQk+vKOv9wlL73p06BsubAsA/5hK3U1Z012KhrtLXP2EI8XeQIG0vaCmhn5s5UwcpBbHa46hKT83LDSifgTax5EyI91PtoI9ekM++ucRkdSaJ7q6JE8iXyoZW9oWcnUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=KGYDYcKG; arc=fail smtp.client-ip=52.101.195.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZZkIVZdKGaiS2G4fdK9c+66VFcQD7a0MBkI6E6ENoR9Rd0g+Yjrsi6cD0Cj27ixsSyoXx5fKUN4bZxS3xg/hSWEF7Gl7WBmjyGLpt/t8adF6jZaRAvvrbCQ25Cyi6sYidYbo1cJoJw5v+O5THMEEPqU2C54ueJHlcvb++IsI7q/HeiCUZ4C98QakuyPLeBvL8PDSJYVLDNB8UsQwOqrWxzDArGFLxdLqyftWkPRfaw7BSJpKNHRRZtcSSAwYBkR+Iur83qBT1gxUtv1LLkssyNCZOrYIj+qLa1DPwpBg2/7qkf2LVfHc1aovQDEC+45n374mVZ3UBeOjNcdoh9KVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avRO6w+aSXzmNGvskN6tJeOSQPxfaMk0fSWwjDavIp0=;
 b=hN9e7ZO4vuapPJCRZvoYyqSBwu/Nqk3SRMhUhMT/gjvsuWnf5gG/tsQhJKFDK3vAzi1j0XY5I65BbpeLMU2FzYakcVvnnr/J74giMkUdalflPlt5mAHESpQx+BTpzjUuNEKhO8XVl9mtxdw5DGe3xU0v42IwlhCeojYjDXvnk21ziUdU3A9KZMu0ThEu0PgcgZQ4+dnBnmRUrVlvC9GaM6csExUaRJeEHjZ5EyLolZ7rIXKmA/nzAUCN+r2++91JuKl3oQQb0RjUss9UHnWXP173QRcPrdaR/AK+fgiyNXhavzC3bgUEAiiWAMC+G1CXFXqiV0o2rnzWQdFILazLZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avRO6w+aSXzmNGvskN6tJeOSQPxfaMk0fSWwjDavIp0=;
 b=KGYDYcKGXxwf4W2K5OlECk9pJjQ/1ZO6cFcbHwpJyswZHprcRk+Fh65Ex+Uy4rlgJ5u6B7moOXW220YPsPUG9TYIxMCDnqJ2/whA7tl3ZrsKiJpoxNfPYKT2Pk/eXsR4HcC60wsuejsVZrohqH43ARtB4LDVAOgk+9ue+w8H024=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LOYP265MB2112.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:123::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 15:09:56 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%7]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 15:09:56 +0000
Date: Fri, 30 Aug 2024 16:09:53 +0100
From: Gary Guo <gary@garyguo.net>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho
 <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?B?Qmo=?=
 =?UTF-8?B?w7Zybg==?= Roy Baron <bjorn3_gh@protonmail.com>, Andreas Hindborg
 <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: add global lock support
Message-ID: <20240830160953.768e38c2@eugeo>
In-Reply-To: <CAH5fLgh-DYvXobXQVaQ9txYS4Rx8QhjyVvfTphk6vvnUOGzPnw@mail.gmail.com>
References: <20240827-static-mutex-v2-1-17fc32b20332@google.com>
	<10453342-d269-4b78-8962-821ef53d3cb5@proton.me>
	<CAH5fLgh-DYvXobXQVaQ9txYS4Rx8QhjyVvfTphk6vvnUOGzPnw@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR05CA0036.eurprd05.prod.outlook.com (2603:10a6:205::49)
 To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LOYP265MB2112:EE_
X-MS-Office365-Filtering-Correlation-Id: 556601e8-29f9-40ad-a555-08dcc905ceac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EntAku08aWQ8YGMUKQDT0uD4jUDbwNicZwJ3A6XjqO49S7BaGAfws85/gM1Z?=
 =?us-ascii?Q?KqJrtgISdktGzaoYjy+Aa42lg9DDFndnZM7Tat+Kv32mUygVbuexW/USM7Mt?=
 =?us-ascii?Q?VwU1QOVQADzbOpMVTGq0aJUpDcxmD0rTt8bkRQJqMdhJYhVVT5lq9i6+tGRB?=
 =?us-ascii?Q?S/XmJb90n1RUBaDLqQSuJYxCTnONFBVRpYIkjaV49idVd2Z/QhyUEPVpEonJ?=
 =?us-ascii?Q?i+FhMEWdGd4hpE6TviTj/A3ZJiUVv94i+MsG/fMhMeG2QrGvraEO/DLql5uv?=
 =?us-ascii?Q?DlpGTzwyPEnN4SmsaYTpENGfC3+bIuENrd2CFx6AJ3wtRQm1JxiiPFPgUwAI?=
 =?us-ascii?Q?Em/4z5jrahRn6OI7V6AjvZOg+wnfEviv7AzgPgGVVVGn1EU6i4p1S5Vx7yyH?=
 =?us-ascii?Q?/gBf6nmSYv3xmvRuD0p1FY41f5U+NqbG+IaqxEBKO1/njImtot0CfoS2PvwD?=
 =?us-ascii?Q?82lwpTuNaq3S39BnwkdERd+ywLoPiDiwq6yp/VV04I0zq+M3h5Lv08sDSm6t?=
 =?us-ascii?Q?9Cwwzk0NeK+82tYbf1JDE7HO3ct2ublwNoa3JV4fRXn80+g7xsRNG1tQ3rfZ?=
 =?us-ascii?Q?buMRRAyxLzsZdmVlGXlCINgmni0ohpaExM2Gr+P2f0BrULcSq3MJL9BVIu3t?=
 =?us-ascii?Q?jpNF3iiEOgaFvi1YBVmMaZTf4uqge+tOBA6lhzrCL4vSirGYFFnI3gF4VIF8?=
 =?us-ascii?Q?XXoRXz5k2hozeXKaK/v9z7izCuL+U6Bm0tkLHmDF+P0ygrOuxo1EfWbC9BQW?=
 =?us-ascii?Q?Mt0kKaW7wPV2eKrF8EQVwINtaphCydnNbRtZhiDoP8VscaKH+FYu7ESpLu7D?=
 =?us-ascii?Q?4NeMsqay1Rj+AcxwwTbSr2Knyp/v5jYOBr0SUXNnEEWxTmVg9ncJYo6ORkuf?=
 =?us-ascii?Q?ixP48J/pkcRLVHMf8jv/iXE/Z7c2IiSsnBqU97RI8VdqiId7bWh84bi9TX2l?=
 =?us-ascii?Q?oLt3uMk7dxtxygjH8BAXx0l7RU1/Y0UdIzU1RY/RsDCxoSrKQiUBBWlF8KE7?=
 =?us-ascii?Q?sRNN308anx6Rohh0UlpuKeKtYAXfOoHSG7xfXJ3I9hubdBa48amQeGVAEeP5?=
 =?us-ascii?Q?AQoCGJnQoXVFWtfDf3iXazdNi+K+Uu2/WG9K/ccaZFBWRL1oNxQWDzhmE4Rt?=
 =?us-ascii?Q?40Ffe0zeY/9wjRaPkFHaDcVurESYFeUOr1fI0QVKpKKsIJ2Qe2Y/3bfFRGFi?=
 =?us-ascii?Q?L/wfaU6oMBM618WHHLZau/+nvGRu4Pzp6Mq4Hl/EsDPli6GR49YZCqjeORNK?=
 =?us-ascii?Q?b9XTJ0xSkB25sg9Gc/aQv8WZuH7CPcBH5rEj0C0RyQ/aGP/BFgp1M/b9Bi2/?=
 =?us-ascii?Q?u2ytniYMH5kLnRIcaLOitttlMAu+WuxsVRufg8GkIE5HeA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HRVJ4u2v6eLo3lYCLCRbmVB1WycPJ7lJxZ4U/lOhAcLtw7amhLX7EmvcQ7mS?=
 =?us-ascii?Q?xa9N8TLVH2Jb0NvJld6jcLXd7Xi/oNaVkal2Glg65Z+GljfdxKzgDI9UNzaS?=
 =?us-ascii?Q?YFnIxIAgcK87ZSO3GJ+QQwNLb4g59qnND1WE46De04eYkQ2u1H1f95s7oAvg?=
 =?us-ascii?Q?shz3BL8Z67sGZ3uGW9Xax0hWVb1Gnrvba4R8TO6gp9Y5+J6E0HO9fKmCxE86?=
 =?us-ascii?Q?q0hj1KjogcKv7XHF55t4QheaOvkrwtyeTZo5bfLjSGJnLhEDtmqUbaZfftG6?=
 =?us-ascii?Q?YCXVS6JM0HmCu5El/q3z0Wlp7Uy78aoB9VfaxeHOh1alf9n9CdAmWJFl7HFH?=
 =?us-ascii?Q?hVCyjWCDJ4PujVGKpBYdqPkY3wXet2O9i8C1rno5Yxgz5I0yW2ulNGY6qPyd?=
 =?us-ascii?Q?LFgFFeCbEkZ2+G5KDnHJ1d6WpEEpWh6oM1zPJXZYcKPbk9KAwuKwTzH2rJ5E?=
 =?us-ascii?Q?BvvUYRAR2hqVCVaEz4UIqc4CHDBESgBSl215gcd03m7rs57NWsi86t+Yn/JY?=
 =?us-ascii?Q?eciUdJS1zwVr5YKRq7DeF9LVjKSGlqGw61jUyUxHwcjy6xKhpMbdru0Trgtb?=
 =?us-ascii?Q?9aPEZXULFQSrxENeEAhh+RD4AHNK4+yqCyg2KU+vkrOprTGOCkbNzmvffV3x?=
 =?us-ascii?Q?EDxxXewp5I5o1uyDe4hSUkxUxCy8X6jRKvOEIPb8QZqQ0wy2L9M87xreIpcE?=
 =?us-ascii?Q?L8JlvsL15ZBeF9sYDjl/BmSDndQXwyhUR/to0aoXTl+x1R7JYromsyGvaBim?=
 =?us-ascii?Q?gSOW7ljkh0wUfU853bUJNhDakqGuq3YBhtWz0pUXjCSvH6rj/Dd01rpX6GAI?=
 =?us-ascii?Q?8eQci44++kQ5soft2eU34LPNozWFlHhhSAO7sRK0/YbAfYnnTvQ1WofKoxqb?=
 =?us-ascii?Q?8bel5PY7UmDcOsf7Geb8xo5EOdXiVyfh3qt5MDDqXOpCJDRAi9cQ/JBl+/lH?=
 =?us-ascii?Q?hKO+sW3b9fo7/iKF0Q1dEnv5s2KKDx644OyZ/hJLbKlebDfjooSun7+8jt91?=
 =?us-ascii?Q?/tQVTdtpXCwJDRPeoSEfGakAhStxEd6rL+DRyqQ3K4se8lIx2y9uQAYbVben?=
 =?us-ascii?Q?wZMMdePoNHsKaOOII5BXP8+SHS6qiixjq37KtIVUNNshef7YHwApt142mipE?=
 =?us-ascii?Q?/AY4gB+EalU6gcvlvD2PWmti0RQ/A1Oh+c5gffzIixas8LnlkFcbUwRwqX5u?=
 =?us-ascii?Q?CFh+tNLC1iMVT7XHqm7lGUnhJvrJRNo0+nVfRYzz/92Z6/V3yLucoh1B/Hes?=
 =?us-ascii?Q?kKIHcxCy9l05rFrfeU6dTzzf5s6aXXjTqVcWPNfZN2SPRZDklKrro9YY8hI9?=
 =?us-ascii?Q?XBDlgq+6Yt/9I1yrH8b4gT1Act51mL7IwjwyztD1BDKw7wFZRh2MOh0FxOcL?=
 =?us-ascii?Q?FVlBRZ04jetnSfsxVkLMGksrcUzNamVvyD1lU/SC5KN4Rde9gvyOP53yJWcG?=
 =?us-ascii?Q?4wBLsmnRS/rYd7OMRnEivh0+hUivyR034R2JWMX8dqeapMSf9Zb79MlYvNRH?=
 =?us-ascii?Q?n7ThPgAXUfMJ5xYblrlr1+St3aFIhWSJZLN+vXEqk4iKurg9mt1n+AgEAjnY?=
 =?us-ascii?Q?IYlDv94EpjJLBEZUt2mS6RQsuKaUfcbXSjkTLU1y?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 556601e8-29f9-40ad-a555-08dcc905ceac
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 15:09:56.0495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SPu6dvAHYz+mzELYa92z08fRe3sd4a+a+fRjxxpNjm1E1Q8emfPfbDeQl+WRO8srsk3DXvLa4khsmyhtbS4LJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP265MB2112

On Fri, 30 Aug 2024 07:34:00 +0200
Alice Ryhl <aliceryhl@google.com> wrote:

> > > Due to the initialization requirement, constructing a global mutex is
> > > unsafe with the current approach. In the future, it would be really nice
> > > to support global mutexes that don't need to be initialized, which would
> > > make them safe. Unfortunately, this is not possible today because
> > > bindgen refuses to expose __ARCH_SPIN_LOCK_UNLOCKED to Rust as a
> > > compile-time constant. It just generates an `extern "C"` global
> > > reference instead.  
> >
> > Ideally, we would have support for static initialization in pinned-init.  
> 
> I don't think traits work with const today, so pin-init would need an
> entirely different mechanism? If you're talking about using
> CONSTRUCTORS, then I think it's an undesirable solution. C code can
> define static mutexes without load-time initialization hooks. We
> should be able to do the same.

I think I actually prefer using constructors to unsafe.

Best,
Gary

