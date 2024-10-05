Return-Path: <linux-kernel+bounces-351895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E2E991755
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 16:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 716101F221EA
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 14:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831D81547FF;
	Sat,  5 Oct 2024 14:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="mFdjXpYm"
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2128.outbound.protection.outlook.com [40.107.121.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BA381ACA;
	Sat,  5 Oct 2024 14:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.121.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728138374; cv=fail; b=pS8drTtEYT+ubZ748EBI0s2hWuLe1hBFYT0nybq7U4yl0IR93Ia8CwRLEZBUajToJsJrVTexFDDxweDXziDGNM2EgNjsueuPYYsABc2jAFi2zimy6wKwyxaDv7Bk22dq49c+HfcJxq80yJuSBPtanTeFbHaGX2/WP2wFuR0mM2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728138374; c=relaxed/simple;
	bh=joDVS7MRgAx1ydwzpgIwuRaZi4WXYavQ4dH3Qq0p32o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OPVfDLTIsdIXPRBOLq0prlnguJSTtkgDUcK+tyksdaZm6IymAwLukFswYfr6MqPcwyvV54IsxZP+pwWYPubjXX+Aj65qKkuNY9PTd8DzkEA1/WF9yl7bFuOHkPz2UpGFKwEDKiu1HlfCphf9wR8wfxYOQ7BssN6HltsQU5pS5F8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=mFdjXpYm; arc=fail smtp.client-ip=40.107.121.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cHwpMutppUsak14MyKBGUrysb9d7p6RRnbDVOLPzAiTVpE06spY5oH2VKmNJfzO928aRDM4WmY2yU0Cbh12hWFDZqXzv4KLvb4ignXTj33xIFhIm4mDsKP6QInc3/7SAoL6v/xIFtJ9gHSKR2U+vzdrLuz9LYp6fXPMU6pdUssublQa7lZWIa8oMjQi5liI5T6h0oyigDb5qYdqJWizydR3R3m0BlU034bJle/TRXaX1BlzwTwfCjrIbZsfiJDqOQ6l3mMSz1MSPjmjnpu2MMD08rq+erG8hyYM0UiZ0Ov1QZckp/B5mHPztmJRlBQS7kikZnUHRLbNXplDz94U6LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpuG7rEb35fINFSgbvqnbZTCXd6pm64kpC0paqeXLWI=;
 b=t6QEvMMZQYfeLcQvBzKei/7TlAjVmUgdcT/wyTXH35rJ+IBdw8xHqVeUNb4w9bPNadNANosZooaoV5FDLF1mtIwMNcHf+L1cx3i1QtB/0ue7bPB/1etlkB+OjUPZdbbVxMzk+1BYVAcOEJDq6cYJ+o6FQl+TfKVgpnAsGxvErcEqEbvtAr0jagzRvfX985wrkkISi09eEPMnPSKDlohsmucVpPGcylN+E8EolUnp0iO3bYMX1kJjSNgegNgTqSBU/3750Po51LcD5MyAXdI/oKuU/5jb50+HTmwUQXszM2sGKKfQaCGmJL6BfmYVE/9nuxP7fE76s0XdW4Kschw0aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpuG7rEb35fINFSgbvqnbZTCXd6pm64kpC0paqeXLWI=;
 b=mFdjXpYmGrzVbM7Glt0jLqePSUaKUVviQny0IvJSWHh52TxatBq/zNX6lgKpVH6nAQaLUsUSpkM8rZIrxRDjGss03iRR/hr06dj4HfWsFfEG0+flzaFfGD74U/a5qMfhaOod74XJB6mVlXCRYdKYrEOOwnE/vbgHuq8LgRfSB0A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO2P265MB3644.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:1b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Sat, 5 Oct
 2024 14:26:09 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8026.019; Sat, 5 Oct 2024
 14:26:09 +0000
Date: Sat, 5 Oct 2024 15:26:05 +0100
From: Gary Guo <gary@garyguo.net>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas
 Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Mark
 Rutland <mark.rutland@arm.com>, Dirk Behme <dirk.behme@de.bosch.com>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 1/3] rust: implement `kernel::sync::Refcount`
Message-ID: <20241005152605.6d7d20e1.gary@garyguo.net>
In-Reply-To: <20241005143106.1196fd3a.gary@garyguo.net>
References: <20241004155247.2210469-1-gary@garyguo.net>
	<20241004155247.2210469-2-gary@garyguo.net>
	<2024100505-aftermath-glue-7e61@gregkh>
	<20241005143106.1196fd3a.gary@garyguo.net>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0237.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::20) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO2P265MB3644:EE_
X-MS-Office365-Filtering-Correlation-Id: 12e3d4e1-b0f8-42d8-92ba-08dce549a7db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1Til1FbhnO0ymBcmlMyzh39awcgf2m8TBiCoqo5tiTYuhAjILhBBvez/TSKG?=
 =?us-ascii?Q?ytIwjjJAieWS6MRg4xOnWxcH847Jqltq5roVjBZU6nNIRn/A+idYIVkcaH6i?=
 =?us-ascii?Q?gmKOcK1il1s2h/bgu47+vZ7j8oI52Q2MkI9Yg/pP0f4Y+zpqVP+AxZiJJqnd?=
 =?us-ascii?Q?P4Fu7iadYO4WJNLcQAGcEzPM/Ivd3SRaT7729ERqiIKk65xPye+mkNcxCcHz?=
 =?us-ascii?Q?zeCiquOXGkDUb649Bv8Zg/T++qASjdcGgLaVL6NFcxZBdo/SfpQpwydZBZYC?=
 =?us-ascii?Q?bEnxPeHRudzco+rJQgCMMINCn2VS1DpZThpeLNQYterW9MVKTbYFmW2+bwqB?=
 =?us-ascii?Q?ZYbLH8Lj71e8Z1j03cfEXDKz3hu0x20mYqNbRqeKLEFq0DaDY4uc4HElK/ue?=
 =?us-ascii?Q?T1vzgeMGx0bY2rgprudSFo8Joks2dM95gPx6Nsud8bP1CEugMMf4rMJXbMrc?=
 =?us-ascii?Q?UJj9l2tCxYdmv8dLBShnP6bq14CMKR9XqmuNFe/cW/V5EbWldaRBnHPSh4yJ?=
 =?us-ascii?Q?m1jPbet8D0hhLf5qxXx6ZPuXN/zwAQcslD8j40u0Ie6PJohNqoTgpxea7Vye?=
 =?us-ascii?Q?1Y9m5YBP6DbUlWlpB4iP1pRE+HxN1eISeg5WBE5C6DKLeXkheLxXuSzGIlOk?=
 =?us-ascii?Q?Xn3nGTLgIe7se7A7oRdC/wWOT3LhgZk6ELOWDSIBx/BGkY8QwZpttW2WZ/fY?=
 =?us-ascii?Q?cUbxSQoF4S4PSk87tCpvm/KA/qwgE+2cPXj2h4ZSNgTqP7k9vKf1LaFd4wjv?=
 =?us-ascii?Q?/eAWepZ4+ihIs+sCwTwWz2O6QHENQR8oElONzMY2ag/tRwKlEL+/iLmA+oVp?=
 =?us-ascii?Q?Sgob6LshqgtjvnsaLovjRn2TMQVVwK0p9MRPK4KMcCid3B57AlPoicYidGP+?=
 =?us-ascii?Q?xSXduD/wmx+PuFhVx2VoORFWmIn7G5gyI2nw1Nv78rjZpSJtIiyVcasndJqO?=
 =?us-ascii?Q?31JOwFTcOOZaoFGiTfSoXmH2Dd2kwE+zv1tbV4rK7+8kyudwzoJ/+1ctvjQ1?=
 =?us-ascii?Q?HCsgNFwe0neT5o98L5iP8D/8mICI9Wtug1yCWO6NSh08HSqBEBiTPxgi0Ny2?=
 =?us-ascii?Q?RKRkCM1o8cUsS29lOOmC+Lq0iAMqAx8d28Awpu6FqtZy8iBLD6CYEEe7Fl+Q?=
 =?us-ascii?Q?8QgsAF4o3acIY17H6dh5uzNYkMd3nwh4qI5S4dCbBSDutOz19lhpyoxktBKw?=
 =?us-ascii?Q?7fWpeUERAIJi4jH2vscSvUBw1ATMC0bC3KdHR6F6iTRjOuP9g1sog8JHiodT?=
 =?us-ascii?Q?Pg+UWzl1mqrgghRqvZya7W0jX/59OKYFKwIlILdrtA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4Pgav8vFRy6/8sw1o1tn7aO3ZqYuawlsWCXxQSmFnACsRb3OzxRmBTY8JQ0O?=
 =?us-ascii?Q?y7820zjkUGqBnoafuyGwLYONWtznLe8Rrg65G746QkJsnhqCCIl4DGzy+CzT?=
 =?us-ascii?Q?iEMp8sO+U4RFCbfmnpsZQsgRt9zvrtfUuzBgTxTLwHFNyEWthqp5WM/rhuNe?=
 =?us-ascii?Q?gA/DT95kPevzXl6BLHiwQQtRncxsF0BjyiQd89FlMX+/5KOwmukxV050r4lq?=
 =?us-ascii?Q?QjNBR0DfE9aEVLWXaExrJx/6TaBiGuL7ILMHk6S++n6/rhdZ4ITMoXW7vyTI?=
 =?us-ascii?Q?OFMlJz1EtwfIyDmEgUJZVS3sogBRi9WFYPB1h0xxmWqx+ndb9WC0+4WvUERV?=
 =?us-ascii?Q?QdKzKNTshzsd7O9xLpVtU8Y0fTgGXYKoklCeMjy2LACEdisXTycmJTjzd7Tn?=
 =?us-ascii?Q?tYXL+KnjB5IvTPqXjoJqE6s9wrtuj9owbv5JkmvXUq2D2hqRjvytA2pKSMLO?=
 =?us-ascii?Q?jmBoB1R1WAjf9Rn0HlMCy7xrt8ZwRFXiJT2WQagvXRItbtSZaXtjgomlmLyE?=
 =?us-ascii?Q?uMu8uJi9LcottPw3XPka+d5i/q4s7d/4T4FzYr9qNULfU2LJizTs0Gt0XqZk?=
 =?us-ascii?Q?QeJjocNXtzQTnPtV3qGaeynmJQt5pd5Bh+UQtGC5ykfWNwe5oWZxRWZ1dA2T?=
 =?us-ascii?Q?/s/XwFl8cCZfJnmXECZYSYmsL9w9R4ZS2ET90VPQqfo7/1S/BDeVWETV5RwY?=
 =?us-ascii?Q?bqqOkIXI8ZhRrm2c44mRDfPGSbKz2/wKhjwBti+gL5bfw2C4JwzFydDHxFrd?=
 =?us-ascii?Q?/KxTMNPf4n1KB2R1ldJBq8KDNIdqY5sbIBqfXSfq+x5gWKNed+lE4byGk2Z6?=
 =?us-ascii?Q?Vraxbuv8CUHQLDo0CiKTdWjmcRM3xeiO8p6Yhsu+bi5CWoEwPpabHbGJ82TV?=
 =?us-ascii?Q?SzSgR5Pr0IbQ+k7RpxVhU+/dgXceXmFw2II7YwruB2eA0kHFcfNCeqj+mpKi?=
 =?us-ascii?Q?CPF2Ktl0D1DxM5MjwW1zlPoaEkas0nI0F7h6DgrnOlciST2sgt2xf5chiMLv?=
 =?us-ascii?Q?4tdfumk6qiqr+G6Ytp2/zTnJqGqrS5nt2PXnUOC/dJi4wDPRDpw/s3jpdCmq?=
 =?us-ascii?Q?FDwgTEUpboLElS4/yV6aEi8qvw0ecclj0Hllz4R/EmAZGkCW0lTW4T22bSOc?=
 =?us-ascii?Q?++CaIh/GqepAFEojM5ms/6zJfyFGrbNZQUG4iXlq1fYP30AXaT3EcC/kEQ3x?=
 =?us-ascii?Q?dAbtsgJcvod3a10eX/o/T7qT2NJ+T+R/mHjHO4bJzDgvQxKL8BqS1QeG1I7h?=
 =?us-ascii?Q?FViMp4KCj5/8jZtjDTOFaP25UfzWcMpk5xLN4C01WjOHqchK0ZND0MBrIhP1?=
 =?us-ascii?Q?byJ5wLP37NogFezdJKWl7unlMFMOATVUW0Ea4mHajrCZMLuHD9zl9SWBFZTL?=
 =?us-ascii?Q?dqQ/jMWZDEOBDaVSjyQTdneope8UpIEJ6OTX3+Np2m8FxA7PZaeH15NnqtaO?=
 =?us-ascii?Q?zGQqn8X19UQc2mO5qkQlTBlQHQNJ2hkvpzYFUm5jV6OOB3P/8leBdFjU0FII?=
 =?us-ascii?Q?rkHUK5BSKtTjMupfd9L4lUjiwtII9IbeaH6YLKnpevQ0q3XW3alJu7g2rhMu?=
 =?us-ascii?Q?UCVJ+0kEhj2QcyOCARMM8SC5JHE4NiCF44WYoER34rrjAJlW9zBPACHK0xou?=
 =?us-ascii?Q?4Q=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e3d4e1-b0f8-42d8-92ba-08dce549a7db
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2024 14:26:09.2492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RTep7FlFtscnefAXbM/0qkbm2ckq74Lsj8f5kUB25WH31cuDom4f9zRg9lYpBU15FurZKNENTNaD/gmGX5J8PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3644

On Sat, 5 Oct 2024 14:31:06 +0100
Gary Guo <gary@garyguo.net> wrote:

> On Sat, 5 Oct 2024 09:40:53 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Fri, Oct 04, 2024 at 04:52:22PM +0100, Gary Guo wrote:  
> > > This is a wrapping layer of `include/linux/refcount.h`. Currently only
> > > the most basic operations (read/set/inc/dec/dec_and_test) are implemented,
> > > additional methods can be implemented when they are needed.
> > > 
> > > Currently the kernel refcount has already been used in `Arc`, however it
> > > calls into FFI directly.
> > > 
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Boqun Feng <boqun.feng@gmail.com>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Signed-off-by: Gary Guo <gary@garyguo.net>
> > > ---
> > >  rust/helpers/refcount.c      | 15 ++++++
> > >  rust/kernel/sync.rs          |  2 +
> > >  rust/kernel/sync/refcount.rs | 94 ++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 111 insertions(+)
> > >  create mode 100644 rust/kernel/sync/refcount.rs
> > > 
> > > diff --git a/rust/helpers/refcount.c b/rust/helpers/refcount.c
> > > index f47afc148ec3..39649443426b 100644
> > > --- a/rust/helpers/refcount.c
> > > +++ b/rust/helpers/refcount.c
> > > @@ -8,11 +8,26 @@ refcount_t rust_helper_REFCOUNT_INIT(int n)
> > >  	return (refcount_t)REFCOUNT_INIT(n);
> > >  }
> > >  
> > > +unsigned int rust_helper_refcount_read(refcount_t *r)
> > > +{
> > > +	return refcount_read(r);
> > > +}    
> > 
> > Reading a refcount is almost always a wrong thing to do (it can change
> > right after you read it), and I don't see any of the later patches in
> > this series use this call, so can you just drop this?
> > 
> > thanks,
> > 
> > greg k-h  
> 
> I originally introduced this thinking I can replace Andreas's atomic
> 2->0 operation with a read + set, but ended up couldn't do it.
> 
> The refcount read is still useful to determine if the current value is
> 1 -- in fact, `Arc::into_unique_or_drop` could use this rather than
> decrementing the refcount and then incrementing it again (just doing a
> refcount read would be much better codegen-wise than the current
> behaviour). I'll probably make this change in the next version of the
> series.

Actually `into_unique_or_drop` can't use this because it needs to avoid
running destructor when it races with other threads. The semantics for
that function is better reflected with `refcount_dec_not_one`, which
I'll introduce in v2, and I'll drop `read` in v2.

Best,
Gary

> 
> It might also be useful for debugging, so we can have a `Debug` impl
> for `Refcount` which prints out the current value. But I didn't
> introduce it due to no user.
> 
> Best,
> Gary
> 

