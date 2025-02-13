Return-Path: <linux-kernel+bounces-512829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAA9A33E30
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C374D188C81D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72AB21D3D9;
	Thu, 13 Feb 2025 11:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="izHYCjpU"
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021107.outbound.protection.outlook.com [52.101.95.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4677A227E8D;
	Thu, 13 Feb 2025 11:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739446467; cv=fail; b=fvrAxuerUw8MFQWa8EKz9xxkIXJYj9u1DmTESpZDG53+gQ1TCB7DSUioIP33oBS93fkrYWo7+4hgXxLyh7m1TLNTkV/WbWMeU+AFTbaHECaHKfzkbNU4PMiwYAadlXDMJaRwhRQPgIPsz+uKgi69CVwe7yRPcLPYKrI4Hg3hxig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739446467; c=relaxed/simple;
	bh=AfkcTs4yogfBqj1T3bC/L/PVCK2k/yhJx6BOmFuuIBs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kbz9AQMCU/+yt4ebVl+AeVI5dCxHI1SjwNh27B5YL236LIK+lmpfZUlFpykTQNFD85uw4JoTagCSIJcQNk750k7lITqg9qSKDw4phFcLWWB28mFMx0dbxGsABQNV7iBr9391vwsOrQIk8mtppw6aKlgPYuDp0O8kfGF+etwv0+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=izHYCjpU; arc=fail smtp.client-ip=52.101.95.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KjFhhHlsdY6WIr1e0XcuHldWm9B1HMZeBkVnVYeKSZhF2Rnl8qdqBf+pUQgyxGiLNCFl/qAMz4mRLaH/2C5EasX8SG8yVlXgOcgYKSII1h6m3WRtolNlwXZApZZs6OlAQ8YOOpoeUGu/cmJSy84CrRfYY2zyVaxGZp1ABY00h4PMz9s+RhOzV1yj/94YS2nOCw79JEZGlktoNfFdPlsX+YoVdvkYH0LbkVRRjmVYHDw+kdFlF/5RFlYUgeeIRG8BtiQrv3ZClyPHza6lZiup9Y6wnHoVW1SfjoeV+o7SZLssehbHT+1g47FglcUJEDiCBZGfSFmmYOnNEbW/ol00JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rT63bMVqtcLQs06Awy2hF27oZ7CbtVfMpFHG3OEO0UI=;
 b=yu2WYW1LRtNdSN1pAQCSauFYvM4Zgz+3rDC6wNY0jGykNKbt27SkyELZ12sQ+AAjrEOagDb6hQE5iqoCz0pc7m/XXqu7n731WG12rFMG6iwjQriHtEydKfoIuR3lVIPYF5eWuRI6i55eDrb5c1Xw5jvCt1sw3eCVOzS4lUXKQGP37VB0FAwGbd82gPzymmCIEPyCrNemLBTaoITjv1/2IlRQvbzwpd6wFO/19LwlTRLfp8z+AgDRxic5SkhL30ORMqMhmIGQeshrI8a2QrfUY7ZClI4tni9yPe0OmXJYmd43izdwLM9TVy4MSUgT652nl916YYjMF06Okqh1TMq10g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rT63bMVqtcLQs06Awy2hF27oZ7CbtVfMpFHG3OEO0UI=;
 b=izHYCjpUitXTRNF//BDPC+7NGCiYDSAGDTb9xC97GrGYI28wKtXMjY4rP5Ayx1PTSsvEF2Vbf8JObvGZbJTWiaj4oIU+mZbp3XQup/DiLIclCQ3ZpS2D6Psy1MFdGDQvUgjzO4KMf/v/t8oozCy0l3atI3whMk66PjyVMVwsKyc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWXP265MB3461.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Thu, 13 Feb
 2025 11:34:22 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%4]) with mapi id 15.20.8445.015; Thu, 13 Feb 2025
 11:34:22 +0000
Date: Thu, 13 Feb 2025 11:34:20 +0000
From: Gary Guo <gary@garyguo.net>
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Cc: a.hindborg@kernel.org, alex.gaynor@gmail.com, aliceryhl@google.com,
 apw@canonical.com, arnd@arndb.de, aswinunni01@gmail.com, axboe@kernel.dk,
 benno.lossin@proton.me, bhelgaas@google.com, bjorn3_gh@protonmail.com,
 boqun.feng@gmail.com, dakr@kernel.org, dwaipayanray1@gmail.com,
 ethan.twardy@gmail.com, fujita.tomonori@gmail.com,
 gregkh@linuxfoundation.org, joe@perches.com, lukas.bulwahn@gmail.com,
 ojeda@kernel.org, pbonzini@redhat.com, tmgross@umich.edu,
 walmeida@microsoft.com, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] rust: macros: change author field to array
Message-ID: <20250213113420.5d2b7d97@eugeo>
In-Reply-To: <20250212194857.192057-1-trintaeoitogc@gmail.com>
References: <20250212194857.192057-1-trintaeoitogc@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0296.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::20) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWXP265MB3461:EE_
X-MS-Office365-Filtering-Correlation-Id: eaa6a9ee-cd2b-485f-9a40-08dd4c225c88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VDvMHBuUp1oGZ3vsRRIMLSFsFpPuufsMKoXgwXnfJT6+S8bkKUhYs2MmQ6Z1?=
 =?us-ascii?Q?jXeGdwKhcrnj4meGEZKvO4SMqI67igZk7OCjCqIdXBRU4jqsPaCWwl/gIO9m?=
 =?us-ascii?Q?NAi2l4fKKPpmSmr3qh1Z5xPnpBic88h1aISBPpPp2ox7mTCkLwmGWTTxDO9/?=
 =?us-ascii?Q?wTRTUACefoRnzZGYKEOsT2wySwesT5GT238wovnK+U0eK1Dw+1FBmfPEeSjB?=
 =?us-ascii?Q?Oh91OqA7rcV5jOyW+R781F4D7lNZIvYI77j2IjAKIOO9NVeSe8nVTQixUHZK?=
 =?us-ascii?Q?GcIVcF6Bgg/70ucvLvhWI/wliRgftgh6k1VQt/5sUYCc5WHNaGfl4b5oJI3C?=
 =?us-ascii?Q?GHPeLFhb7r1f6ntEbbr/Msq3F8TUp0rHAnrpwZTUCk2+sy3KknV7+jkHGx10?=
 =?us-ascii?Q?ldgFBf/JWK0MNfYoN3ln9PWz18qWYKpC2z31mtoWWvihlPkIz9mcc7ncVUY7?=
 =?us-ascii?Q?y+ITwFn84DixQkaJ9YHoFZC1sTeyrGQ2egcjQspGQfejD2p/XEcfOw0/cs3g?=
 =?us-ascii?Q?fB0VRAHrQTbj4eMloDBzhoxQZVV/aDWPVt7ya2pCkFq4O3WDLGceCdh462Ya?=
 =?us-ascii?Q?euBzHQNX5TF92NjJ5SYQuR6e43kTIpfbLLUv7UNirTUBjPuYjVnek5stdb3Q?=
 =?us-ascii?Q?1jASYEzLi42NADKbYTZNxiSpUf76+xxvxlagKMgupRuS0871imHbR2PKx7yQ?=
 =?us-ascii?Q?pNs8cz2MBs0A/K+CFnAWoRpJev/4dtheL/4lDEfHZF5YS1wyXvCW0TUaunIn?=
 =?us-ascii?Q?vPtw8l0A1z2ITsrTZh4S804UwqoNrDIA8K5ddxk+PYpDk/rCWNZedNuCaDdN?=
 =?us-ascii?Q?ZjdJD9ie1wwIo8OGSqdwf+bCsA9/7FgPY3MwcZ9kB0A3+DDqNdCbIJ2nhYLT?=
 =?us-ascii?Q?iaqitGKZxdxKCGbPXUN4l/dN4YSaKQm37MgSIOD9q+d5cb2ycw61u1zYfI1W?=
 =?us-ascii?Q?2ZiY313NZLz4rP63TrjMV8pjWkKdWamWqOuf1LdKhqnKQ1NjMvoLl1IeqIWk?=
 =?us-ascii?Q?bPpaqDyv5GxwK3HwagYCfyH5ZP9DM08A1Tz4Q59lMI9SypuonteeYAB5/iPW?=
 =?us-ascii?Q?gbMMhAAC/JeT7vmWFsGQ74kH38Q0h5sJnww8x4MK5Vm8FLm1tpDBCw5pJK+8?=
 =?us-ascii?Q?8C/goLvT0IA5ZcdTmczHHBDS3jRZxuFCWmf3aZG5Kw4/OMOInaAb0LaYBGSa?=
 =?us-ascii?Q?d2TyDQkMFHeKpLvcVxxqgwNRdlpWYG2dTduvtX1Gjdn7HMO4Ym6Q9nt6NFHQ?=
 =?us-ascii?Q?3jXZToUUqvPacFMBSjWhHRPpghtci7ReWLEfHQD4JVjb4dXMTcnoJW2FYTXB?=
 =?us-ascii?Q?N8W9Sk9k/VMfUTinojI/SY+XvajqjIkj54TFsU29FZcQfbyRvOkZ5FDP0BAD?=
 =?us-ascii?Q?fyfhwwcxGkA1u2aMX6/W2PJIJvQT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S6HxNLXgKLtmwyzRvxLu0N+G//cmclBv8KYqYc2ONkDjeXi+eZTtbk1iHsd5?=
 =?us-ascii?Q?v0codO2veQDc56SpGztHgVb45Uy/A7IaydurQL75819FhSSjLtW2C03kE9HF?=
 =?us-ascii?Q?lut4mTpl3qxsQyqkLefG34t6xSIGWU1NyBdsYvw9t0WOu1HZ7LNiD5UOYx0h?=
 =?us-ascii?Q?6UrsBKKdqTjJOlGAAI5DbqS4HakOmf03GaCBAdEYlswOUa2DduMe4398OBNv?=
 =?us-ascii?Q?w8n1JMQd8n/RZqYfdsY+zzSzKyyJja+B7FxezjMVUBpfM0ljBCn03Fhbuplr?=
 =?us-ascii?Q?rpYU2vXkYy9ViYSpNE8ZObmrfTdn0JvpDtVG84t/pvW/YR4V1RxLBVVqtx3q?=
 =?us-ascii?Q?W3szPyoTGPoFL3FhnfkRynlncAu6ny1oIYAEtmv7XHlZrzSvdj11ywQUazTc?=
 =?us-ascii?Q?sToRi3QJ0beiWe8LDu9M1xo+MHOl9xzMHs4J3zTZGthTgR08UDZ86pf4uIUy?=
 =?us-ascii?Q?TCdCm4I3TVj5AgvzP3dq1KLWCPzqRYig9R9GvsTLRUI7pweqi9Qcmg4tTIH7?=
 =?us-ascii?Q?yVd3TBn2uywQ1IIMySgryr6wKIoUxXJhwOwcpu2jyubKctsKwaARzWGX2Kfb?=
 =?us-ascii?Q?xtRHnFR3iEelpjkZhFEBa7IQNa7mSNj5Q7yVSuGI4XdgNWIFK0ccauOxJxYY?=
 =?us-ascii?Q?Q9V3enem8W7eLJBCAbPuJK6KJhh2bzwsbpjiyDbMoSTkO9D3T0a9xQnOUj6D?=
 =?us-ascii?Q?RCM8kwGYIbDZKu5AfgJ9RTOXYloGoSs6o0p+lpvd9O+W05snwag234AsIRKU?=
 =?us-ascii?Q?ShcAoix8//MI4rNDUAwYexqjXPlai4AHNUvI+5BlSqeC7PEfPohduKOtmNrp?=
 =?us-ascii?Q?ZXknJaQaPJEvsE0v2K/Ys4Rz2lZxUNQYX4ffV7WmGw9EBIXOcAipKm7W0ZDh?=
 =?us-ascii?Q?nsjNbPR0wN8Q6lSFxQYCcERER/MeV1RjkUQ9zA3JUiF37j+lDFKyQ89usDiC?=
 =?us-ascii?Q?UepFmoIMj2WHCCvqFGfmjkJ99wENQAKMPscBI58tErR1uErsImCJsAxfDce1?=
 =?us-ascii?Q?u+thevKfgqeTQxUiMsplmOVCK9pqw+/JZlYA8xaqMRcm+1qK9DGyEK8vB8HA?=
 =?us-ascii?Q?vqqtYGbXfpkrTaOwUmVmAuwoug24v3NpKhSk/xmMzmp/FSxXrRJjBfLAYm7O?=
 =?us-ascii?Q?Ri+9FCRodFP5vg5Sy7pa7nS7ieFprXNNlzx3wUX7Fu7DijufPpiZnvvEFy3W?=
 =?us-ascii?Q?dGr+saiNMopJJ0/Ks+E0btVQcgTm55YVq1iwHz2yhh9vJbPIcx7I1gemAyTo?=
 =?us-ascii?Q?dUuoUUvxc6g16M8f8VIHC2QCgWv/n+jZcrVPkOPddLYwKj9NNB9X5Bpjktv0?=
 =?us-ascii?Q?GyNh1FyKG+MLt1BvZ309jKj/kHp1Q3icSrdhd5jLx6pTbgwShYSk0iJ+Ra80?=
 =?us-ascii?Q?VHXOLopSzurOmmuM9zuYYzK1mQg4hZGSvQR1a0nXARhxsOOY1hZCQAl+6Hdx?=
 =?us-ascii?Q?OyLup/RTk82HSYfiMieP8gfP4DHWVL59aB3Ozm5/F8XVpmDcw+v8OBSQEyeP?=
 =?us-ascii?Q?O1MKJsLVMrq97p0pyT6RcV7Q9CQQuhggui7BkITk0u2LSN6NJXaw/3xDrio1?=
 =?us-ascii?Q?ZkYN571Ftz5Enm2C0ZNh5SGgqu5mNxpkA27jSs35?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa6a9ee-cd2b-485f-9a40-08dd4c225c88
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 11:34:22.3231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uFfBgSqhb/XP8Nwv0X8tdoiJMHU4Gg6h13QXq0qpE8g0g6oU7VeJpTVBVne+zGdoqEbJ+0PEs/LOhZICbA0nSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB3461

On Wed, 12 Feb 2025 16:48:56 -0300
Guilherme Giacomo Simoes <trintaeoitogc@gmail.com> wrote:

> The author field don't accept multiples authors. Since this is
> necessary, in commit 84703117fd98 ("rust: module: change author to be a
> array") was change the author field for accept a string array.
> In modules that use the author field, change its value to a string
> array.

Spelling out commit SHA doesn't work for patches because it will change
when applied.

Also, this patch needs to be the same commit as the one changing
macros, otherwise the tree won't compile when bisecting.

Best,
Gary

> 
> Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
> ---
>  drivers/block/rnull.rs           | 2 +-
>  rust/kernel/net/phy.rs           | 4 ++--
>  rust/kernel/pci.rs               | 2 +-
>  rust/macros/lib.rs               | 4 ++--
>  samples/rust/rust_driver_pci.rs  | 2 +-
>  samples/rust/rust_minimal.rs     | 2 +-
>  samples/rust/rust_misc_device.rs | 2 +-
>  samples/rust/rust_print_main.rs  | 2 +-
>  8 files changed, 10 insertions(+), 10 deletions(-)

