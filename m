Return-Path: <linux-kernel+bounces-329400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B188D9790DA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 15:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 691892845D1
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 13:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D62B1CF7AB;
	Sat, 14 Sep 2024 13:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="SBbx/B+U"
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020104.outbound.protection.outlook.com [52.101.195.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12391CE70E;
	Sat, 14 Sep 2024 13:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726319278; cv=fail; b=S5snTa2VDXHRDqcNQ6sZbpa2cqq0RL75LNRjGZRYjPZDU6Gt4B21BlEKCKH2UyO8ynBkJigKy2+R7OMbFcmGX2fFFvogu/F5lqO5ZBXJ9vQVNKLpRLddmjGgTD4L4/kFjs8yfl602ajaMs0ylWeD2dsVKrHfMg6BCJ5fJ2OV+kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726319278; c=relaxed/simple;
	bh=1FtvblCmXhi+WuqZf6bnifsykQg/TKvXcNWuThQyWIc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H6FqRj6J+U/ufe32ARx34AuPymOvZ4DdupwAd/WYaq/Cgx7qfj7MU+NPeGyE3gTNlSO/QVk15FW6y2ykBOE7QpWjxG55SXB5g9Qom1bf3GyVTtLeprdXhypIgwf3qHWR+4vVQWJTcNSPz3YFVdsrtenBX3m3kyUaD6Qc9FcMtdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=SBbx/B+U; arc=fail smtp.client-ip=52.101.195.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DKKWHNGr1iVnBuux+S3IDE/iKqgSCXzay23K6Rm19v4lYvjx+M6WbPMyHIqmnKPvtb0HIljiIX74lgoBlHJIAOPaGkhqJf7TIPb1bQAHgVTDF2Oa5Jr8IrMxlicgXd5K6ghRDPqvoOCJ0bgq1U4pI42cAzk2yishNfHVcOQ86vLKXT2eZW463fR2NW2TSsqGJvWfdliFMw3c6107RmgfMUkKdMUC5Z0tjH7q5LyG9jJ4xi+3F9UFctoGAetYMcckmOlFjPy5W0yfU4vlX9bep/jIHX4C1dEd14G/8rq5bON5ZqehtSNVA88naU/emH6LyIVNzfZWeq34XOat9nlDtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oo4Ru4s6iRDJKulWRVqbAbtRzxFY95g5aneGPyacngo=;
 b=LkeC8wnsnhadr3wWd5sLWlQbamZayTO0x9VBLV/iVCP3Ojq867iDOATOGIHiog/vc8rpc7stuCz0JR83lLFl/TnLNjZqAA++zcs/LPKA1i+SgqWS3S6+dszjpkcsozdiaz8BatqDU+lfX+k4lSSZIEsKqhCwKJ72mt3nc8ni6HgeVw/GLjKhYtghcdp1jM0Jo9RYi3DdzfaRINx3asrUu3vhuQj/EeVyuwz3ohZM9itUEBOopeeUwbDRA0gUkatkegta/rljEU/Yrpt8oV4kp9i1WznEBGy2S+Ih0Sc8Jgtzb4a9FHbDlxdcpAw7XosOshJLBaWQ0LPnLZCRTqs+5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oo4Ru4s6iRDJKulWRVqbAbtRzxFY95g5aneGPyacngo=;
 b=SBbx/B+UqVXTRJVSlirTOFLuIDOyrtmTnkhBdzkHymV3lNEoGk8da3b1dZgkRC7JZGIJVSYJ5m0fCrL9aE/ao+9E4ORQ3D9PhEdaam+exSFQfmfZwmfQbPf2oO/1LFr8mr3ZsJw/B+9GMHsKNeG89MqHZonv4Ekq65RcghwT5EI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB5239.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:281::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.22; Sat, 14 Sep
 2024 13:07:51 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.7962.022; Sat, 14 Sep 2024
 13:07:51 +0000
Date: Sat, 14 Sep 2024 14:07:45 +0100
From: Gary Guo <gary@garyguo.net>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Dave Chinner <david@fromorbit.com>, Qi Zheng
 <zhengqi.arch@bytedance.com>, Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Boqun Feng <boqun.feng@gmail.com>, "
 =?UTF-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin
 <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Trevor
 Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: shrinker: add shrinker abstraction
Message-ID: <20240914140745.7b0e5d5c.gary@garyguo.net>
In-Reply-To: <20240912-shrinker-v1-1-18b7f1253553@google.com>
References: <20240912-shrinker-v1-1-18b7f1253553@google.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0296.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::13) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB5239:EE_
X-MS-Office365-Filtering-Correlation-Id: 13385162-b9a6-4079-5f5d-08dcd4be3d38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m3IVRbfl3PlbzlqQKrU4A+S3gLtLAyPQONu2Ht9yjJWPs/lE6JeSMKL2pCHN?=
 =?us-ascii?Q?Tv2ZA07vbCmMmDi92L/uO36h40IzqTKwx4FWpeXa8m/D6E4vX9BPRD3nHtku?=
 =?us-ascii?Q?1u9Rfp4ud86uuiBIFe2yauRiWKjp1GptfE4FA2Xrgnp4+JfRLZOnEnpfFKl7?=
 =?us-ascii?Q?0vBdex3Jy4/Lx4/42dcy3EqHkpK4GfTxeKK1BdsHc3pjH+40mUsqt/40y3Yq?=
 =?us-ascii?Q?GVoq2zDYHi/wS0a8Lebr1Jos+SAxoO2qfNnV0CgLz8IesEB2vr/1m2sWwaBA?=
 =?us-ascii?Q?4PagidV1c5hIZoczr1wfIbI3aacXn7aze1dvDdausF7jGVCALNXyEuDhVPr5?=
 =?us-ascii?Q?0D2F4QgPFe5ZVNEMsa1PHQZD1HDBPU5KIk7VtHN364COD1f5j00DOr29VAFM?=
 =?us-ascii?Q?Do1yG8j3LbzjMzwgJZWe1bwWw+Lk+pcFXOsTqlYmQaroBSyzuAgCJFLhQl2z?=
 =?us-ascii?Q?K1vyY17WMJ3etGiW49glHZw30N7lTewwbpBYB6mGaSnShgF/XIztZX4tutEW?=
 =?us-ascii?Q?3YiB+GQerq4GVoyj8czZw0YJnS5v8dxF6LK8ds9XYH41YGxh1ipn4mFZpPk3?=
 =?us-ascii?Q?M4th/aKOeNQaRJoDu62n2E6MyYsmwaM1/pQtDYCCOvEL6GhxgbTDWaVbdGEY?=
 =?us-ascii?Q?TEWauruGNz2HJ+tD7WdRTGfAriVKxM4FXyDPV1KbacPwFkAghowlbijQIfdJ?=
 =?us-ascii?Q?tOVnKPPMbkLYIFY1HdVZiT32Fh34qnaQEf9usZ+PIwXJGhrN/Z3VCjWaqnUR?=
 =?us-ascii?Q?LuVrxOoWeZX90IFcOOeb10cayVZFYbhfa9/CrDvr+ZCtDb819qpQQOlHVYzs?=
 =?us-ascii?Q?/F5NM+51dXArXoB3zgOahjYCh631ARLhgMuXc2tMIgFkab3VFzMZMPtuBTyt?=
 =?us-ascii?Q?s3kdxyqZdoN2Y3n249zFAAtB/sNXsqkzauStFfRuv4IvGXfpd2vCxATuehI0?=
 =?us-ascii?Q?yapQFPUveulZ70dsMEUcPQYTUArg7pcyjMEOG4uho4JO7Dr1lmUm0b4DGNOD?=
 =?us-ascii?Q?YvSl4ct3PeWAVPQ5gUOIiI05BKIn5ufFTzi1kagL/ZLOsv86LeOYcCKUDucc?=
 =?us-ascii?Q?0qkFK6cL5oKzB8hXnqCu8rYc9kIQr89TGomweeCTiRRTz/JXvNE2c0ciQ9HY?=
 =?us-ascii?Q?5qPG8sOKtl9mVxKU4Zaoj8MkrcRtWzMlV4tLPxG0SKsd1kw/9nqUYGDzYqFI?=
 =?us-ascii?Q?VLWclp/zOWnATBj8MN5Jdt//8zJefgvp/5J2aca5sKS32z/gPV5KRrd2o66N?=
 =?us-ascii?Q?XkQULSyD77SNRtVV7n9H5t7UiC8leLdG2uR19IXPDXSuaXrO+801hGZJEKBl?=
 =?us-ascii?Q?47lE6IeawWgUDD+I83JQG96xKMIJxQKd6BOIeL9sma/lWQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+yqtny/leUu6oKXNNgXzUWMTTsdVqLwl3dQgfKFZJ7vIcqsFeIpNcC7AfHTd?=
 =?us-ascii?Q?2T+x1BCYSnw15dgwgvxpPk3Zm6cfgHdCqaef7IzonrTH0WYh/7Hccz4zHcz+?=
 =?us-ascii?Q?iv+PHvpmaPgd9n9Aw5WShwJZocc4/R4ehlhvxED2YLYuvUS33dkS1ZEHvMdi?=
 =?us-ascii?Q?mKCV64CnOJb2NLHGEympiHrs9vcJ4d+AWHmYy1ou0Lr+/80KrxTcMa3JIF/m?=
 =?us-ascii?Q?PzczKvmO27h16XZ4FzZoisBSGwr59pjUgdbIOvw+YVlS2/S5TdyI6Np8kgur?=
 =?us-ascii?Q?XrchxP43hUZ0HU3kV1BWOUXReQjhON+2xxQb58fa0t9v9mIryAp2iaywSqDm?=
 =?us-ascii?Q?OGpvUAl448W9gsRU4+cBPWUyplfTO1ZjZ+HhH2aj/MgdVRApcdp4wR/9dJxX?=
 =?us-ascii?Q?HDbZbWD3Tcuhx0YUpgAhuAROiVbbwR6/4c5RE3WsEwAqUOSeA2XfPipv0zWj?=
 =?us-ascii?Q?pywpwkxpiaNuwjPTxw5o2K+vx4kTwiylpUfjidy7NtiJq8orQm2gxkpiq9Ge?=
 =?us-ascii?Q?ONhuc6YHIz8f3mbXxtKRmXBQ3xvcMLVa9s8dIfJRIj2aDOG5TgP0ELayAryD?=
 =?us-ascii?Q?5mEwhxAtsKxX9SLheh+G/8/52MQyWwdl7KBzDnroJ6xs5SANNAD8TUMll6zT?=
 =?us-ascii?Q?tQCAkRw+BXzd29Sy/QqQuY54zjw/LBSUGU/C3E8zo26CqNdZYz1rYrREzsPa?=
 =?us-ascii?Q?W4vD4mdmSD759DbdRojMsF6Bz2AORBemiHXfzs7dgT+5tsZwt+e+tr7Vea5W?=
 =?us-ascii?Q?0RlbcPnItZqqHQ7hRPnSf5Tkpf7xJlDk0QKXVeRZFOVwCwi+j26xZ069XNyS?=
 =?us-ascii?Q?/mrJlK1mmqw2YFAsKMXne4BeaOI5KfyWkTR9QxJtyLeANZpBPcBO0scOxXPb?=
 =?us-ascii?Q?8jYNiONdhrCzVdsg+vdnRiHp88YnCeCdkZFsdkqLr/AQGPdudLMlovVzsHXs?=
 =?us-ascii?Q?zLmsD0ortU2WxaWKON3V5e+Oddl9JHbU3omRxXOKNlNYus2cY5aKgGt8OX5N?=
 =?us-ascii?Q?bij6MPE9TzSRvaqHYtmq4Q+XkE2bpId1+cnuHEJFZEFHvHM+ar27af8B+5u7?=
 =?us-ascii?Q?zTBGuQ7nZVxKIk/T4gGCLWbk1eDokYtXD1SD+CXYpBZwC9B4dONeDbkwtI2o?=
 =?us-ascii?Q?JaK0i5l2BthMATk87ZlfoExFDMjYzGqNLCF0c2a38NCvFnlEIS4eu05fSb2v?=
 =?us-ascii?Q?5lo5kuPnn5ica3ITrWHQC3XE+vOxL9bULcca9JFHcj8E+hflLCJ8Ho6BbNq+?=
 =?us-ascii?Q?0KBFxYfCAl+OleUE1CU/D1vzbBzXOxOZULsbq/XxVBqQT7NlZQB5yDEuaxTl?=
 =?us-ascii?Q?SbfDYJ0QzovRUAq+8WX5Od2IoR9xR5ga+Lmo4+KP2bFMD9byigDU06J1q3xC?=
 =?us-ascii?Q?zJtbCPTkYYmPKfcoltdBqpRQgDK8ucIA0Z2MphZRAn+VRg1rc3bsMWtny/9x?=
 =?us-ascii?Q?DQpMjP8C5TbVVWz7ZDq9pDhxxoPmyO8nCn9AhLwT2mwDIt4GJWFdedZLtEyV?=
 =?us-ascii?Q?c2rxFhNCKOqVw0djkvRqhIuiCc8acU/c6vvN+JUDS9+uiOmOtdKcyJsJNsIO?=
 =?us-ascii?Q?BdHd3ljJu1xrby1VVLEdtk2HkbbroFLG3Tm3Yzw9?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 13385162-b9a6-4079-5f5d-08dcd4be3d38
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2024 13:07:51.7361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BagPP9p4sjYT2PDgMOlpHYUx0C2cgdjUhC25AFHnwA7RwI8fhCyS6IlS/pZvZEJ+0O29wqojXgaukrhVA+ubCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5239

On Thu, 12 Sep 2024 09:54:01 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> Rust Binder holds incoming transactions in a read-only mmap'd region
> where it manually manages the pages. These pages are only in use until
> the incoming transaction is consumed by userspace, but the kernel will
> keep the pages around for future transactions. Rust Binder registers a
> shrinker with the kernel so that it can give back these pages if the
> system comes under memory pressure.
> 
> Separate types are provided for registered and unregistered shrinkers.
> The unregistered shrinker type can be used to configure the shrinker
> before registering it. Separating it into two types also enables the
> user to construct the private data between the calls to `shrinker_alloc`
> and `shrinker_register` and avoid constructing the private data if
> allocating the shrinker fails.
> 
> The user specifies the callbacks in use by implementing the Shrinker
> trait for the type used for the private data. This requires specifying
> three things: implementations for count_objects and scan_objects, and
> the pointer type that the private data will be wrapped in.
> 
> The return values of count_objects and scan_objects are provided using
> new types called CountObjects and ScanObjects respectively. These types
> prevent the user from e.g. returning SHRINK_STOP from count_objects or
> returning SHRINK_EMPTY from scan_objects.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Some suggestions below. I agree with Boqun that we might want a
`kernel::mm` to avoid everything flat in the `kernel::` namespace.

Best,
Gary

> ---
>  rust/bindings/bindings_helper.h |   2 +
>  rust/kernel/lib.rs              |   1 +
>  rust/kernel/shrinker.rs         | 324 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 327 insertions(+)
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index ae82e9c941af..7fc958e05dc5 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -18,6 +18,7 @@
>  #include <linux/phy.h>
>  #include <linux/refcount.h>
>  #include <linux/sched.h>
> +#include <linux/shrinker.h>
>  #include <linux/slab.h>
>  #include <linux/wait.h>
>  #include <linux/workqueue.h>
> @@ -31,4 +32,5 @@ const gfp_t RUST_CONST_HELPER_GFP_KERNEL_ACCOUNT = GFP_KERNEL_ACCOUNT;
>  const gfp_t RUST_CONST_HELPER_GFP_NOWAIT = GFP_NOWAIT;
>  const gfp_t RUST_CONST_HELPER___GFP_ZERO = __GFP_ZERO;
>  const gfp_t RUST_CONST_HELPER___GFP_HIGHMEM = ___GFP_HIGHMEM;
> +const gfp_t RUST_CONST_HELPER___GFP_FS = ___GFP_FS;
>  const blk_features_t RUST_CONST_HELPER_BLK_FEAT_ROTATIONAL = BLK_FEAT_ROTATIONAL;
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index f10b06a78b9d..f35eb290f2e0 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -45,6 +45,7 @@
>  pub mod prelude;
>  pub mod print;
>  pub mod rbtree;
> +pub mod shrinker;
>  mod static_assert;
>  #[doc(hidden)]
>  pub mod std_vendor;
> diff --git a/rust/kernel/shrinker.rs b/rust/kernel/shrinker.rs
> new file mode 100644
> index 000000000000..9af726bfe0b1
> --- /dev/null
> +++ b/rust/kernel/shrinker.rs
> @@ -0,0 +1,324 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2024 Google LLC.
> +
> +//! Shrinker for handling memory pressure.
> +//!
> +//! C header: [`include/linux/shrinker.h`](srctree/include/linux/shrinker.h)
> +
> +use crate::{alloc::AllocError, bindings, c_str, str::CStr, types::ForeignOwnable};
> +
> +use core::{
> +    ffi::{c_int, c_ulong, c_void},
> +    marker::PhantomData,
> +    ptr::NonNull,
> +};
> +
> +const SHRINK_STOP: c_ulong = bindings::SHRINK_STOP as c_ulong;
> +const SHRINK_EMPTY: c_ulong = bindings::SHRINK_EMPTY as c_ulong;
> +
> +/// The default value for the number of seeks needed to recreate an object.
> +pub const DEFAULT_SEEKS: u32 = bindings::DEFAULT_SEEKS;
> +
> +/// An unregistered shrinker.
> +///
> +/// This type can be used to modify the settings of the shrinker before it is registered.
> +///
> +/// # Invariants
> +///
> +/// The `shrinker` pointer references an unregistered shrinker.
> +pub struct UnregisteredShrinker {
> +    shrinker: NonNull<bindings::shrinker>,
> +}
> +
> +// SAFETY: Moving an unregistered shrinker between threads is okay.
> +unsafe impl Send for UnregisteredShrinker {}
> +// SAFETY: An unregistered shrinker is thread safe.
> +unsafe impl Sync for UnregisteredShrinker {}
> +
> +impl UnregisteredShrinker {

I feel like this should have "Builder" in its name. Although I
struggle to come up with a good one, maybe
`ShrinkerRegistrationBuilder`? 

> +    /// Create a new shrinker.
> +    pub fn alloc(name: &CStr) -> Result<Self, AllocError> {

Feels like they should just be named `new`. C-side uses alloc/free pair
but we don't have an explicit free function (just drop), so I think it
should just be called `new` by convention.

Also, would we want `&CStr` or `&str` (or `&BStr`)? This particular
case doesn't really need NUL-terminated strings since you can just pass
%.*s to shrinker_alloc.

> +        // SAFETY: Passing `0` as flags is okay. Using `%s` as the format string is okay when we
> +        // pass a nul-terminated string as the string for `%s` to print.
> +        let ptr =
> +            unsafe { bindings::shrinker_alloc(0, c_str!("%s").as_char_ptr(), name.as_char_ptr()) };
> +
> +        let shrinker = NonNull::new(ptr).ok_or(AllocError)?;
> +
> +        // INVARIANT: The creation of the shrinker was successful.

// INVARIANT: The allocated shrinker is unregistered.

> +        Ok(Self { shrinker })
> +    }
> +
> +    /// Create a new shrinker using format arguments for the name.
> +    pub fn alloc_fmt(name: core::fmt::Arguments<'_>) -> Result<Self, AllocError> {
> +        // SAFETY: Passing `0` as flags is okay. Using `%pA` as the format string is okay when we
> +        // pass a `fmt::Arguments` as the value to print.
> +        let ptr = unsafe {
> +            bindings::shrinker_alloc(
> +                0,
> +                c_str!("%pA").as_char_ptr(),
> +                &name as *const _ as *const c_void,
> +            )
> +        };
> +
> +        let shrinker = NonNull::new(ptr).ok_or(AllocError)?;
> +
> +        // INVARIANT: The creation of the shrinker was successful.

same here

> +        Ok(Self { shrinker })
> +    }
> +
> +    /// Set the number of seeks needed to recreate an object.
> +    pub fn set_seeks(&mut self, seeks: u32) {
> +        unsafe { (*self.shrinker.as_ptr()).seeks = seeks as c_int };
> +    }
> +
> +    /// Register the shrinker.
> +    ///
> +    /// The provided pointer is used as the private data, and the type `T` determines the callbacks
> +    /// that the shrinker will use.
> +    pub fn register<T: Shrinker>(self, private_data: T::Ptr) -> RegisteredShrinker<T> {
> +        let shrinker = self.shrinker;
> +        let ptr = shrinker.as_ptr();
> +
> +        // The destructor of `self` calls `shrinker_free`, so skip the destructor.
> +        core::mem::forget(self);
> +
> +        let private_data_ptr = <T::Ptr as ForeignOwnable>::into_foreign(private_data);
> +
> +        // SAFETY: We own the private data, so we can assign to it.
> +        unsafe { (*ptr).private_data = private_data_ptr.cast_mut() };
> +        // SAFETY: The shrinker is not yet registered, so we can update this field.
> +        unsafe { (*ptr).count_objects = Some(rust_count_objects::<T>) };
> +        // SAFETY: The shrinker is not yet registered, so we can update this field.
> +        unsafe { (*ptr).scan_objects = Some(rust_scan_objects::<T>) };
> +
> +        // SAFETY: The shrinker is unregistered, so it's safe to register it.
> +        unsafe { bindings::shrinker_register(ptr) };
> +
> +        RegisteredShrinker {
> +            shrinker,
> +            _phantom: PhantomData,
> +        }
> +    }
> +}
> +
> +impl Drop for UnregisteredShrinker {
> +    fn drop(&mut self) {
> +        // SAFETY: The shrinker is a valid but unregistered shrinker, and we will not use it
> +        // anymore.
> +        unsafe { bindings::shrinker_free(self.shrinker.as_ptr()) };
> +    }
> +}
> +
> +/// A shrinker that is registered with the kernel.
> +///
> +/// # Invariants
> +///
> +/// The `shrinker` pointer refers to a registered shrinker using `T` as the private data.
> +pub struct RegisteredShrinker<T: Shrinker> {
> +    shrinker: NonNull<bindings::shrinker>,
> +    _phantom: PhantomData<T::Ptr>,
> +}
> +
> +// SAFETY: This allows you to deregister the shrinker from a different thread, which means that
> +// private data could be dropped from any thread.
> +unsafe impl<T: Shrinker> Send for RegisteredShrinker<T> where T::Ptr: Send {}
> +// SAFETY: The only thing you can do with an immutable reference is access the private data, which
> +// is okay to access in parallel as the `Shrinker` trait requires the private data to be `Sync`.
> +unsafe impl<T: Shrinker> Sync for RegisteredShrinker<T> {}
> +
> +impl<T: Shrinker> RegisteredShrinker<T> {
> +    /// Access the private data in this shrinker.
> +    pub fn private_data(&self) -> <T::Ptr as ForeignOwnable>::Borrowed<'_> {
> +        // SAFETY: We own the private data, so we can access it.
> +        let private = unsafe { (*self.shrinker.as_ptr()).private_data };
> +        // SAFETY: By the type invariants, the private data is `T`. This access could happen in
> +        // parallel with a shrinker callback, but that's okay as the `Shrinker` trait ensures that
> +        // `T::Ptr` is `Sync`.
> +        unsafe { <T::Ptr as ForeignOwnable>::borrow(private) }
> +    }
> +}
> +
> +impl<T: Shrinker> Drop for RegisteredShrinker<T> {
> +    fn drop(&mut self) {
> +        // SAFETY: We own the private data, so we can access it.
> +        let private = unsafe { (*self.shrinker.as_ptr()).private_data };
> +        // SAFETY: We will not access the shrinker after this call.
> +        unsafe { bindings::shrinker_free(self.shrinker.as_ptr()) };
> +        // SAFETY: The above call blocked until the completion of any shrinker callbacks, so there
> +        // are no longer any users of the private data.
> +        drop(unsafe { <T::Ptr as ForeignOwnable>::from_foreign(private) });
> +    }
> +}
> +
> +/// Callbacks for a shrinker.
> +pub trait Shrinker {
> +    /// The pointer type used to store the private data of the shrinker.
> +    ///
> +    /// Needs to be `Sync` because the shrinker callback could access this value immutably from
> +    /// several thread in parallel.
> +    type Ptr: ForeignOwnable + Sync;
> +
> +    /// Count the number of freeable items in the cache.
> +    ///
> +    /// May be called from atomic context.
> +    fn count_objects(
> +        me: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
> +        sc: ShrinkControl<'_>,
> +    ) -> CountObjects;

Any reason that we want this new type instead of just returning
`Option<usize>` or something like `Result<usize, ShrinkUnknown>`? Would
the `CountObjects` and `ScanObjects` be used in other places?

If people always use `CountObjects::from_count()` or
`ConstObjects::UNKNOWN` then I think it's better just to eliminate that
type.

> +
> +    /// Count the number of freeable items in the cache.
> +    ///
> +    /// May be called from atomic context.
> +    fn scan_objects(
> +        me: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
> +        sc: ShrinkControl<'_>,
> +    ) -> ScanObjects;
> +}
> +
> +/// How many objects are there in the cache?
> +///
> +/// This is used as the return value of [`Shrinker::count_objects`].
> +pub struct CountObjects {
> +    inner: c_ulong,
> +}
> +
> +impl CountObjects {
> +    /// Indicates that the number of objects is unknown.
> +    pub const UNKNOWN: Self = Self { inner: 0 };
> +
> +    /// Indicates that the number of objects is zero.
> +    pub const EMPTY: Self = Self {
> +        inner: SHRINK_EMPTY,
> +    };
> +
> +    /// The maximum possible number of freeable objects.
> +    pub const MAX: Self = Self {
> +        // The shrinker code assumes that it can multiply this value by two without overflow.
> +        inner: c_ulong::MAX / 2,
> +    };
> +
> +    /// Creates a new `CountObjects` with the given value.
> +    pub fn from_count(count: usize) -> Self {
> +        if count == 0 {
> +            return Self::EMPTY;
> +        }
> +
> +        if count > Self::MAX.inner as usize {
> +            return Self::MAX;
> +        }
> +
> +        Self {
> +            inner: count as c_ulong,
> +        }
> +    }
> +}
> +
> +/// How many objects were freed?
> +///
> +/// This is used as the return value of [`Shrinker::scan_objects`].
> +pub struct ScanObjects {
> +    inner: c_ulong,
> +}
> +
> +impl ScanObjects {
> +    /// Indicates that the shrinker should stop trying to free objects from this cache due to
> +    /// potential deadlocks.
> +    pub const STOP: Self = Self { inner: SHRINK_STOP };
> +
> +    /// The maximum possible number of freeable objects.
> +    pub const MAX: Self = Self {
> +        // The shrinker code assumes that it can multiply this value by two without overflow.
> +        inner: c_ulong::MAX / 2,
> +    };
> +
> +    /// Creates a new `CountObjects` with the given value.
> +    pub fn from_count(count: usize) -> Self {
> +        if count > Self::MAX.inner as usize {
> +            return Self::MAX;
> +        }
> +
> +        Self {
> +            inner: count as c_ulong,
> +        }
> +    }
> +}
> +
> +/// This struct is used to pass information from page reclaim to the shrinkers.
> +pub struct ShrinkControl<'a> {
> +    ptr: NonNull<bindings::shrink_control>,
> +    _phantom: PhantomData<&'a bindings::shrink_control>,
> +}

I feel like this can just be a wrapper of `Opaque<ShrinkControl>` and
we hand out `&'a ShrinkControl`?

> +
> +impl<'a> ShrinkControl<'a> {
> +    /// Create a `ShrinkControl` from a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The pointer should point at a valid `shrink_control` for the duration of 'a.
> +    pub unsafe fn from_raw(ptr: *mut bindings::shrink_control) -> Self {
> +        Self {
> +            // SAFETY: Caller promises that this pointer is valid.
> +            ptr: unsafe { NonNull::new_unchecked(ptr) },
> +            _phantom: PhantomData,
> +        }
> +    }
> +
> +    /// Determines whether it is safe to recurse into filesystem code.
> +    pub fn gfp_fs(&self) -> bool {
> +        // SAFETY: Okay by type invariants.
> +        let mask = unsafe { (*self.ptr.as_ptr()).gfp_mask };
> +
> +        (mask & bindings::__GFP_FS) != 0
> +    }
> +
> +    /// Returns the number of objects that `scan_objects` should try to reclaim.
> +    pub fn nr_to_scan(&self) -> usize {
> +        // SAFETY: Okay by type invariants.
> +        unsafe { (*self.ptr.as_ptr()).nr_to_scan as usize }
> +    }
> +
> +    /// The callback should set this value to the number of objects processed.
> +    pub fn set_nr_scanned(&mut self, val: usize) {
> +        let mut val = val as c_ulong;
> +        // SAFETY: Okay by type invariants.
> +        let max = unsafe { (*self.ptr.as_ptr()).nr_to_scan };
> +        if val > max {
> +            val = max;
> +        }
> +
> +        // SAFETY: Okay by type invariants.
> +        unsafe { (*self.ptr.as_ptr()).nr_scanned = val };
> +    }
> +}
> +
> +unsafe extern "C" fn rust_count_objects<T: Shrinker>(

nit: I think we currently (at least in phy and block mq) use
<callback_name>_callback as the `extern "C"` function name.

> +    shrink: *mut bindings::shrinker,
> +    sc: *mut bindings::shrink_control,
> +) -> c_ulong {
> +    // SAFETY: We own the private data, so we can access it.
> +    let private = unsafe { (*shrink).private_data };
> +    // SAFETY: This function is only used with shrinkers where `T` is the type of the private data.
> +    let private = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
> +    // SAFETY: The caller passes a valid `sc` pointer.
> +    let sc = unsafe { ShrinkControl::from_raw(sc) };
> +
> +    let ret = T::count_objects(private, sc);
> +    ret.inner
> +}
> +
> +unsafe extern "C" fn rust_scan_objects<T: Shrinker>(
> +    shrink: *mut bindings::shrinker,
> +    sc: *mut bindings::shrink_control,
> +) -> c_ulong {
> +    // SAFETY: We own the private data, so we can access it.
> +    let private = unsafe { (*shrink).private_data };
> +    // SAFETY: This function is only used with shrinkers where `T` is the type of the private data.
> +    let private = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
> +    // SAFETY: The caller passes a valid `sc` pointer.
> +    let sc = unsafe { ShrinkControl::from_raw(sc) };
> +
> +    let ret = T::scan_objects(private, sc);
> +    ret.inner
> +}
> 
> ---
> base-commit: 93dc3be19450447a3a7090bd1dfb9f3daac3e8d2
> change-id: 20240911-shrinker-f8371af00b68
> 
> Best regards,


