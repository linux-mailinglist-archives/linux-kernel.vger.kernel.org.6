Return-Path: <linux-kernel+bounces-329487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D11A9791F4
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 18:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0966F1F217AF
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 16:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603AA1D095A;
	Sat, 14 Sep 2024 16:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="wb4KPuxZ"
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01on2091.outbound.protection.outlook.com [40.107.122.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A881CF7CC;
	Sat, 14 Sep 2024 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.122.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726329882; cv=fail; b=FmnCSwQmmsyZNpousuW9eT/te5kbJNul+QsOcfKidCkKkxATraTM0iG5bTa8QlcxiyhJmCqHwszoKEEYxx4p/iBBQm+wMnMZXE3EEtjPbe944CCOx8zS7l16VyR71sN9P/rdt+Gt8CgG5+0RLhBndM/v9wLH7GiLwchiCNUYfN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726329882; c=relaxed/simple;
	bh=uhDjm3wnJ/hkUuZXDSZg2fYGbO2lrp7SgXfj8ufOVmY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MfMDMs1QUkcBk/agIoLkP686nev2pUbp/WKIjJv0M4USOdSNT1qkr4tMrYjZfWEINBbWix96RhuliJixPSo12yi8IfuL7tdTVowPkM2+RT78AvNioUCLMiq62SRdJiB03gdILgiCh3PbjmC84CnxSrw3nk2PfUV8j3ig0gebaLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=wb4KPuxZ; arc=fail smtp.client-ip=40.107.122.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CI01WzlTfy9rsARDSYkBWtkj65cC2qPYGT/B+zcvltWC1IyCbZONtADiTchbTFmzvWqOA6yOU54qsisvJN3x4YlSF5xK3N5CfNbxK9TacrRa/wuC8eZH/qfuuYKkwgac0kYYogGuOTgHVWz+DRfqjCid3/ZoMVxONnXtPu0EPK7kGuE903r+/CFj4lyaZNoLbAWij9Jwb4BwyFIh0Zo/Dpi/iCHfXrzdQSLNRdZimvpf4yg0ia2bKCP+KodlurTmpHCx1+KT0fwmC31kX+mPWX8rWgbmKNiN8aePs38zJiyjp6Fy/kq3sOjem2/gBRZQLF3hCwlB+/1D0gMaqne5NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzkA7AJ4d8V5c12HE+uo9lEbjYqgtS7UCSaTZjJ2pZI=;
 b=sppBun/ZLxiKOFLGkvvfFEXBeWb9IWKc8+cUTbYScUorDUVhQCU7w25pctqzNbHl5eUDWaPXsMaKKcaM2c80J/z8prXpz1xdkYe0Fh6I++pL4lJZIG1co9jTA6rXESP3pxLWSX9y6s2tx+QwZ36hxB2pP58F+7m9a1Ur98ovJu59XW+ChQswIh3WCW3O6tgI+imyvh2yCNI9OvwCJ2gx2dXpE0AOeaY3ERZ60zjqNjx34A/qK/4kReSlFzy5gQ+8QhFsi81kHSSfZek8AeMmp26HOAG9M78J4hzkDynl9LXKoGTexuiYDOxhK0U5ntfT7nSVBko1rvBeBih0eoVmnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzkA7AJ4d8V5c12HE+uo9lEbjYqgtS7UCSaTZjJ2pZI=;
 b=wb4KPuxZhE8MIwDN+YMb2KRHBHL6EvEkpfKUoA2tTCPEV2Q6M8jjuppWpQV0M8nDl8xYWbbgEnpClNZyTNmy/3/k66R4pLl87YjFZsQ5CvV3bTqaQGLCHRGIQi3v0TXv345kWgwy434+YMUFzgcBt0lWe60TtvgP7bDm6th+hmA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB2961.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.22; Sat, 14 Sep
 2024 16:04:37 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.7962.022; Sat, 14 Sep 2024
 16:04:37 +0000
Date: Sat, 14 Sep 2024 17:04:35 +0100
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
Message-ID: <20240914170435.2261a324.gary@garyguo.net>
In-Reply-To: <20240914140745.7b0e5d5c.gary@garyguo.net>
References: <20240912-shrinker-v1-1-18b7f1253553@google.com>
	<20240914140745.7b0e5d5c.gary@garyguo.net>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0226.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::15) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB2961:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e1bc03e-b5d6-459c-0771-08dcd4d6eed9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ceisa2+uZ+/AQNb+GpOoBST3PFqcSkZPAU3CcEm+nGE69zABrdYM/OS+8CGa?=
 =?us-ascii?Q?kDDwzowPUIJZi94dVCW4GqYLUgldEXabZF7/pLOfU4qb9RpLQ+1Xw9QoE9fb?=
 =?us-ascii?Q?Yg+K8gZFrHSDYrajd7BGvpq0yOGoMNOln9jdMmCQ3o8H7sl97WzFmuBMAmql?=
 =?us-ascii?Q?5mqA5gy4MbGy0/EStGVCektml3t9Fiiy2Esb++NFbBr4w05HzR/5hASvJlvN?=
 =?us-ascii?Q?XHnUzm7sWLREU8Qzk++jtEZd/RRla1Jdf9erVKEjd4xx0dXwe4kqmF9UXjA5?=
 =?us-ascii?Q?ToH0p5k8GNsks4dIG8w5881rdDeQ0SJbVN/ZpdwkBaP7R67dn+sTqMlm21nZ?=
 =?us-ascii?Q?XrdeqNHSBLeV0UHIN/rfPhcZkPm+iHKvQy60/BGLaNxTxgBdTfave7FX1wgC?=
 =?us-ascii?Q?WPj+50XOAGZH+u52wXs1FFeafI0Pv5fKJ4bYTXCUbOUZRC1GOSvwjoiklEVa?=
 =?us-ascii?Q?zw3BNAx0ojcKHyU1c9tintaIaEjNSFet/wfm+NMN6qlhNmJFKdX5/YdUZL/s?=
 =?us-ascii?Q?eAE4eBmHKyU5U0IZrdambxpwmyxVPF5o+u7xNP3LNPIl9aqWymQS/R+N43An?=
 =?us-ascii?Q?gEJ1ApfcJMzlYM6mwnqnglSKGbRLVHicuuaemsyqGznYxdcfJtf9IovKRILt?=
 =?us-ascii?Q?RQiMvjCEWqWA2wi8DjrgEhlkIPRFNpmRDCTFjcW4e1Ij/kG8uIAIwsaQafg3?=
 =?us-ascii?Q?02ou2QoVlHkNjRPj7fbJ1DDBm09UlPN3uBzPmFAWO7U5QVThA3G6qeIKJXt3?=
 =?us-ascii?Q?QSn2RFjngBgGKLDKjMd4fgQP7MWLYYGMmFplywNcKUoqGLgZ2TLlDGkGJbze?=
 =?us-ascii?Q?BzgYRqM50JI5VTrxbqb9hYIHhT42R5tuPh2C0jQRW/Z4yjCgqsG8dIUEcqDU?=
 =?us-ascii?Q?KYqdXuzqSdTtqR67Q/GBqUUqBpJA3pEzmOZ6H77Ys0hBBr9O+p5qhqnSgXer?=
 =?us-ascii?Q?NL8NxY+N0J9D5Ltsox7i7YbZ/LoC8IreJfHqCKiarE1nw7O4k4Tx2W2AC379?=
 =?us-ascii?Q?CBHTT3T6haD/0wSNH9DMfZ4ZyDHC/4WoquHl4oiG0Bv5SmFw1KqD5CIFYNpt?=
 =?us-ascii?Q?n22CD/bkWPlsd1tIvjq4+X/hKsfrtza2fsjdpZIsHimaEfm0jMaW/Cp138Ho?=
 =?us-ascii?Q?64lyMfJhrFvOcqMqxMmWyXVTTaeYSBFgwl3TaPYZi/3uAKJx/ZZ1zK5HrwY8?=
 =?us-ascii?Q?dKLqQohKu04TH1A/1YTRENfCLh2zG6Xjx405c284yBff7K6CG9o1z0/c4Ulf?=
 =?us-ascii?Q?jpYJrW3/xzKFUzN1a7Nba+2VZMUhgjtqZim30KihIx54es+xw4iYBHDRdkIm?=
 =?us-ascii?Q?JtMBg0QBl0JaYzXczU6nS909WTLkOZqgT2DMeHwyiu2moA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hTFffuSFS7hhSssga0hQR7t/jn8rAP3fGRQJ6GIaiZK2hUttqXPG/3pshpFV?=
 =?us-ascii?Q?BTxygumZdFMBsFcziDBPXLnvMFanLhJxPsEU1pqSFVHnLhCienBsrKm71DCE?=
 =?us-ascii?Q?rqgtrbelPyPjtKLLb3Fn00hOAX/TBWbI2BuOPRoNAIHupxX0s/0yUcVmUcGa?=
 =?us-ascii?Q?MIcPdw3e4xccwyci9nvUpKNk4CZDRjm0kJ8c8oUHL/OHppFGv9uBbtx2Z1jo?=
 =?us-ascii?Q?4B1j8HytEqkDJef5v+tFYYynbl1MbmUqgxW83pkWJo+yqV/2pgAjuwL+dHb6?=
 =?us-ascii?Q?bRIiuxGy/RlyH5jhubC1FHMs54xLLtROzTV+T55IXdLrQaLD17pnI3hA6oSx?=
 =?us-ascii?Q?3awx/M1x8QjyY0OrTliBoBuibr7paZ+g6uX1ecOvsXa3bz4x6gGIoBkr/PQH?=
 =?us-ascii?Q?Gjj9dsYK3l3/Vrnb7zup7LDLzvsJoESukFFhFckoKVx9b6onbZrZos1Yd3kM?=
 =?us-ascii?Q?JTf/R6ShtnnJAnGeoiv90a8nm/vwUlkJSCCiry264GNzqcT9LfHO9TCxt0+H?=
 =?us-ascii?Q?Bn/R6CHaGePXnU3Uj2SdVLpRVwYOD4/kDrje4rfryHdOFvuXP60F0Y8UFAzR?=
 =?us-ascii?Q?aiheGhH917qN9+Y1wk2MnyPICbRaGhMp2ShPBRBkDvCCDpZ2i3WRwLMSZPM2?=
 =?us-ascii?Q?n6KMCUCYez0GZ4V5Mk0oniZ4qXq7jqIvwk35SaTiwRfVNjbDfhUY2VG5oX2o?=
 =?us-ascii?Q?17Oe+TRLevTnVooPzQIhRTduiMtO8UKGLJTcazpNGHFl59RfRGzfGZ/UHMqz?=
 =?us-ascii?Q?fyveA2XkOBHXHCemB1tlDWydtj6Y3wVgKKqRMHYUrLj07zOrCxnZ4bUFLLrE?=
 =?us-ascii?Q?QMpIeUr9w4RC7iuxp8D+20ahtyACUa1P6L7llvSCglHRPlsvOewpjkxstsqP?=
 =?us-ascii?Q?1Cyy/KIEjvzbbV4E65bwvFv/1smnRYv+NZI+/KZqjpXHE1v/TxKymAV+Y6um?=
 =?us-ascii?Q?M6123Dv+CruGrAULdROqHkJFi4Mg94PgtXUZoEACaHbrEvxGobJ1jvFTUAnh?=
 =?us-ascii?Q?qKpKY68OCBlEEx9hG1a3I73o2BKTJ/a2vzSoz0Ey7ThMFdh5THrcpTXsNln6?=
 =?us-ascii?Q?0kF0+jeiqrdz1InMzLSp3J3tTVo1twOEExPWbTFFy4MOtLFGe2hd/q9l+/w7?=
 =?us-ascii?Q?fVga4wLuz9ZcTXHPSpxL4H9niCx9BpzKmchMMC/+GjgUUd8+YDhMeCEf+p2R?=
 =?us-ascii?Q?NxosSq+PPhKVs8n+zcaRc8PD6l2TSigl7ZLmKTIdZ/Kao2Mk6BzZFVql0Ymn?=
 =?us-ascii?Q?zZhk3Gf08YqQIUzPLBt0CWgN+DsMlXxelEje4vL7DzRM5DgaopxFUFCft8Fx?=
 =?us-ascii?Q?oOLktL10J55YvMc+oaac2Y9zr1v9Axc89CRsEQYQI3tfNwEftvvU6NZLHFUa?=
 =?us-ascii?Q?w/4KPZ44BO9HifS9lnVkLWmI6FgVBU74VXQGNBqXGAydf2Cr9o9CYb1COknF?=
 =?us-ascii?Q?Mi1TMfzx13uhCkxJHSimgQy7v99XN4iDdL7E/A4YCWPdklwl3yo9BPDN2yoJ?=
 =?us-ascii?Q?OXeZWAEINKW2DTuhhMWmKtMMwxDlknCaAMcAu/UPMDiqXW/Cz6YuBCI3N7pV?=
 =?us-ascii?Q?V9XvwtqV93fD1F9Edah3uLh5VMkDkUxGQWHRcvfDLjJpcZDBJaYKHbuLEMgW?=
 =?us-ascii?Q?5Q=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e1bc03e-b5d6-459c-0771-08dcd4d6eed9
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2024 16:04:37.6512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bAk1qHLPoHWDQRd2MC/8c16/sD4iXsTtLf4wP4Rw4qgv8VgXjOCPxluIli4cbJ/Epeq4yCUxa0qaSb/mPWwopA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2961

On Sat, 14 Sep 2024 14:07:45 +0100
Gary Guo <gary@garyguo.net> wrote:

> > +}
> > +
> > +/// This struct is used to pass information from page reclaim to the shrinkers.
> > +pub struct ShrinkControl<'a> {
> > +    ptr: NonNull<bindings::shrink_control>,
> > +    _phantom: PhantomData<&'a bindings::shrink_control>,
> > +}  
> 
> I feel like this can just be a wrapper of `Opaque<ShrinkControl>` and
> we hand out `&'a ShrinkControl`?

Correction: I meant `&'a mut ShrinkControl`.

Best,
Gary

