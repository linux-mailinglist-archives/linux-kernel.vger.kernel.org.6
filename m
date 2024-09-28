Return-Path: <linux-kernel+bounces-342632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AA6989112
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 21:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04C1C1F21BF9
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 19:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18EF166F17;
	Sat, 28 Sep 2024 19:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="havZFxzG"
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2109.outbound.protection.outlook.com [40.107.121.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD6D161326;
	Sat, 28 Sep 2024 19:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.121.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727550019; cv=fail; b=MuPoVgI1Xuwcin1l0IUdANWVqSPnM71R83DRu0FwqxfVca3RSsfZyKB5CmRo1wvbLArNbhSKyG2MXzAPrd0qidCXuCUcXysg/mQqCb6BHo0q5+Amd57D3jSB4WblNYHpCZiBX1hd63cbyHr530WZQ7++1NJ2+aIcqmbmCNn2TXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727550019; c=relaxed/simple;
	bh=GP5Mi/juhULbZu5SWpexbApsz6kzP/6duzO2uOe6cEg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TLTP81naNQXw8nQ+8LEJvwiWpF7gKOtmc/VcZuoT3vpwWKQeA0ItqBoj3xvnzW0H3wpkhCvZAz5Dc2OL/BdWxUhHwOY5qUoAWyfUfb0g+aT4BSol6CVtDuey9pSp+IWQQCjVjvhQePxiFDEAHkXBoaXyxVAJp6moZNX8hwQ8R+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=havZFxzG; arc=fail smtp.client-ip=40.107.121.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hvYvUX4rFMBFuiRgD0RRNaQrR2rEZ0WNIdDTv27HkQI0PrCa9xNKQdf4SOFPFlxD8V/X1MBBbUXPL89cMRs3Wrmrk9KQ7iF7go02LhcuojAvBIYC/dFJSiBRsatsK8QfTyjjOtCpE02GFQveUvL0G2RaHqOJsa52MyjZygcto/tdDmFxK7JQ8qQAnGBUyukTiE9wXR8l2cCAP4HefmoLWiLNFiLGItjTiHp4/2pUY7ADJFykAVpIo+RlzhlrfwlA/FdU6q2EU0DoJJonBU5udG0wUdkGlYRLYYrtmCWdBhmUX6qpli3+mHdh7Vth9iAu9Qz7sKqrMC2itFyCETuw9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqBdho1nae0wGEaFDzgTQFskxqQv3w9R87vkfSQNYDI=;
 b=xfL3uR3DpGQ9D7DAhHNeFoaYZ7Efkw0us6DWn4XC5Ps7BxxWj/viQ9u4oGaAWoA2CdDWf+22U2FnyQdmPYBxjqvaDjCzKdBOlJ9/hIEA6t6ZcTSDf73k3+kIm/LaQB0H7CrNLvnocxu9i6De9X1xnmtpx9NhBDYv/5qGpZ5KXzRdXXaHrCMY68h3zXSb9+GUrP3wilP5j2yPgXexO3CrpscDQh/SvmoRi1WzZNZQD4pqTFKmgCGY+96z65zDjGmps2eCj2LxJbOQLjwCT1/YuO8DDs9rPkooST5PbvtYdxOFXDGx/O8iVsAfwvgaiVDVGYQJWCru8ScNWdNDmAzdJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqBdho1nae0wGEaFDzgTQFskxqQv3w9R87vkfSQNYDI=;
 b=havZFxzGeTGX7gaOylM/vT9FFNUVs+X4VjUiV4pUBHicI3EFAtQs1nPCQ8gsL3JyKFAiAZC2VywNbGsWXbmnEe40fbR0nDa9HqLp+q+ZI8W0UGMwE8FNOEoPQw35qpHAOfd0luGzLty4lcwmZzmFYA+OiFDo8bRPWBJYmE1ySCI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO4P265MB6981.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:34e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.24; Sat, 28 Sep
 2024 19:00:15 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8005.024; Sat, 28 Sep 2024
 19:00:15 +0000
Date: Sat, 28 Sep 2024 20:00:13 +0100
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
Subject: Re: [PATCH v7 11/26] rust: alloc: remove extension of std's `Box`
Message-ID: <20240928200013.6c4ba34e.gary@garyguo.net>
In-Reply-To: <20240911225449.152928-12-dakr@kernel.org>
References: <20240911225449.152928-1-dakr@kernel.org>
	<20240911225449.152928-12-dakr@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0662.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::18) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO4P265MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: 01fc32d8-e66f-4297-43a4-08dcdfefc991
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jCa3mogLD7Kp8AtXIHvBzIFvnHci416EVfcYw06m243zgdE1tyOI/r9ZlTej?=
 =?us-ascii?Q?uZuq1HHo+90Uea7yWeEQeskNrBPbF2ToJ2OY65RVsIaYKlKeNsYRcbUywZZM?=
 =?us-ascii?Q?27z27UyA0UU+EHiQpvGNOihFoxRJamhHJOYeLmfM7mkw2Cig6xq+9ji1Xxi2?=
 =?us-ascii?Q?mA+enwR4HC8SVCt/ScZVV2sHgml8jLseA2oSuJiFSmiqfNYefBO1jA2eBamq?=
 =?us-ascii?Q?NKi2ZRCCBFK67y7vjFo5vywJC4PymOLoQ13AAC5JLpXjpAf7DYo4obIZchgX?=
 =?us-ascii?Q?bFWd+EUpPLjHWrdYxB0/OQab7DWdutVmxQAdZupYc7xx2MEmlUZEAaeksl6D?=
 =?us-ascii?Q?oGh3OGcOhVzjObagR3eqPWTjBwIkjg6INhXD3iQcKs5+Xl77BJRpSBMjmCsh?=
 =?us-ascii?Q?M0hTbB+SZ6RZqMpbUHk5lPpgCQUi7swRZVCLUCVoy9HrzfDFPuTkRmKawb7E?=
 =?us-ascii?Q?vodKDf5fQcHBfLDQ7rTOaU7d7iTu3kCa+NitZ6Cmayr6ArlPhKX7lZWt2SQM?=
 =?us-ascii?Q?yOPwGaofxClkHpFpwH67VlJVOv6aSe/Qekn/lxfcPiMrZZ+UyBjyVT4fP93K?=
 =?us-ascii?Q?FlrcJ5hSgErAkXvAsW7e9w9M2Eie/wUsCEulxim0E0o+alQSJ71yb9YKUI83?=
 =?us-ascii?Q?XLmBmmf4v404dH1TR4g1jt/6Hbg5oBVYpn7YWRSUI74IiJWZO2SUCgRfe/gb?=
 =?us-ascii?Q?93Addqm40FLg+5jXEj1aB4aPQH40QCIpqUlST9NOmiUWyCRNOaDaUdeyH73G?=
 =?us-ascii?Q?Fp3e2G7+L6yPjN9TwMSzktnugJHYEZkHIJ5DZKrqOuJ3NjT/i64/e43M3XTX?=
 =?us-ascii?Q?fFp6zi7Kh+BYPnUvIMJpPzgUmHYRwPSh66qgpzoHOJ1p2+5/wqOswGRX5jD3?=
 =?us-ascii?Q?zh/gccHVix4WuLhDP7G+53Jm3Ejg71T6glAWta83bpBY04fnwrbLg56L5V2D?=
 =?us-ascii?Q?1ir1C4c8WVROG1TZgXRdiq+uxGCTBhDnMw7aOqvPrjC/U/driNJefysUH+w5?=
 =?us-ascii?Q?fVZ1wSYJmzB1khV6ZsJ9XRgIccDF941dEBPgwbRSjOe9m24K1YtpdrqLrfD8?=
 =?us-ascii?Q?x96I36tUtjAhAnEcssJtUiFPrOkbkVrUlxjaMOquCxD2asXsORWJpb/m0gBy?=
 =?us-ascii?Q?jBv9wTqFfcgfygrd/q4rQT2pkEyf3OvYuTmP/gUTL6xDIGMXkzwrZOyZb7D5?=
 =?us-ascii?Q?iizYhM6rFkKi+OsD1XlIZsSPrShXSzfpbXfrRJ2CVdSCVEXV8IFy+JWhsOX7?=
 =?us-ascii?Q?UppH8Kvr4fO5zRC5Uw3EQysDGFnUpdtaeKtYEPj3AQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NgWTpDro5qe33mnfm3ww8KhUKO5H3o3/VDprfCOcYi/rW/8C2Xe8cGuFCI6e?=
 =?us-ascii?Q?trQo+OJzat8zVdmdELOPF82imYp6k4ChOSxGaEeff/8RDOve2RKxfo9Pc6mv?=
 =?us-ascii?Q?zdH/56nH0OLkDtkK5qYQeXVknU01PmgRgYEpvToboZ0biB/3pjPG5cE8X6x+?=
 =?us-ascii?Q?rjImi75YFIGyC9YjHTDeHtgEcqYDgaBPKlMyk/49jIOX8ATQJr6Rlkavd7kd?=
 =?us-ascii?Q?9wyZvKtyJ1Kv1I+cCwQrJRndNZnT48ULwt4pxNqTC1ibF1SKlTgvwa/k+rLP?=
 =?us-ascii?Q?3mmD49xQRoTvh4Xcr8UcDf85IWC+oIw2ShisFQYep5VlLoYqY55JEf5U4fVh?=
 =?us-ascii?Q?F17tVxFc9f9FRSbE+Suz8/ZeQyrsZ5X5o0t50uXBiPmdUs8sBKH9z+HthdOA?=
 =?us-ascii?Q?zo38MMUmYtHuWzl6Ah72wgt4q/17UfkVs7PHGioe04YdlPUOyP4Rx5UCNcvP?=
 =?us-ascii?Q?ha1jNGeo51RZtAFQMYYLOig1hLl5Rw1S9wUwIxLoswlgZ3qI7sWDedn8FsAN?=
 =?us-ascii?Q?d+KP2luSOyqcBHg1ZDlq6hyhC7HgxmFkg6bY9f1x8aYFc8WLEnOEbkmf4Vs+?=
 =?us-ascii?Q?sZlW0DYfhIFsS+3DWbB1c9ojqD+ViCjX/Q/tOiFQdQA90EggtF6YsNc7Zmgk?=
 =?us-ascii?Q?AFwhTfTBPgbWCZx3sHo0wvDjRbVybPlLejjea78mKxy1p63eXIXTtwRMXd11?=
 =?us-ascii?Q?XBV3/fTj0knEvaUHvur/6m++UY0u37aOmgZHf+vEkD6EGmPXL7cizoCp1TPO?=
 =?us-ascii?Q?cNZWt6QW/fWR0R6a67Q5oIusj++m0umV4xY5nx6gK4//52AHNLeRRSBs58ia?=
 =?us-ascii?Q?vNMh/dzIH864SvYlJvZ3lu7CwSKRjA8l3K8Mjdgw2O6G3L+YNqU8NgyBsPo9?=
 =?us-ascii?Q?UNiaQQ7DPUVYhwJSKHeasgWdD9Zk0a+6j3bJNl9Et4+adfZ/nbA+cpcpDDUm?=
 =?us-ascii?Q?Lx9yyJSfpuEmxDuhc4wAbdk+96aDugGU816DjDLWaxhOBeQjX9SfG7x4Lywp?=
 =?us-ascii?Q?o2FJXNCL/FvLciqO1FyvEN+P3NygFRAs6rHunVgs7h6DHt3Sie5iKK8byJ+U?=
 =?us-ascii?Q?U8/GBfzAxpLDpEJDal9NCqNq2tEeGQKXS+iEV/eacLCN+PNjvSKAJyQUZ50G?=
 =?us-ascii?Q?d7ClFktBVjOnhaIOEnEGL6eaYCHe9WvA4i+fYUJy0ZtnURTWOtE68J65Z6ky?=
 =?us-ascii?Q?M66aIKFi3zfJjMGyXAatPTDQ+1qjbpve3SLNM1o9WQFTC/z912w4qv7WAY6y?=
 =?us-ascii?Q?oPYRlB/gBGNErnQjY2n38R1zvDtXUx6CKxV47L27Q8+4fkoqzcCfRIBqPd9a?=
 =?us-ascii?Q?ZdfqNIqkN7HLoFGxB5+m+d8njARSBYADc60KJiUNlJJaKSwCktdVbP9Fjs65?=
 =?us-ascii?Q?IhvrRJ1hH7NBLJKbKwuBlf70pNWx7Ihjr5uwVZ2jNAQdYIr/JPt4LCQSHEIG?=
 =?us-ascii?Q?IdS2LP8XZseMr6+Q3/dxpXTxDjGRzaqD8JZdvZ+IBhEqA0E/cMZYHa/VvIdA?=
 =?us-ascii?Q?dJy+5lYNiTzILbhHR3gc3DYqTn0+75lZ5P3CQHr+4ptRYGrPPCp8xdf3bxgj?=
 =?us-ascii?Q?Eu2/A0Fw7ijB166UorLF8kuN/PEMJEZQ5efpKz9S?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 01fc32d8-e66f-4297-43a4-08dcdfefc991
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2024 19:00:15.2659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ru8T2KCXsQ2vYGFWa9hd8mppWg++GnMp4VheNQuF+zGaImkubB1cid6XgCtDqIt6PDVXtymojROMHyALBeb/Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6981

On Thu, 12 Sep 2024 00:52:47 +0200
Danilo Krummrich <dakr@kernel.org> wrote:

> Now that all existing `Box` users were moved to the kernel `Box` type,
> remove the `BoxExt` extension and all other related extensions.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/alloc.rs         |  1 -
>  rust/kernel/alloc/box_ext.rs | 87 ------------------------------------
>  rust/kernel/init.rs          | 46 +------------------
>  rust/kernel/lib.rs           |  1 -
>  rust/kernel/prelude.rs       |  4 +-
>  rust/kernel/types.rs         | 50 ---------------------
>  6 files changed, 3 insertions(+), 186 deletions(-)
>  delete mode 100644 rust/kernel/alloc/box_ext.rs

