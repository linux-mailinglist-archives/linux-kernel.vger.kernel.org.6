Return-Path: <linux-kernel+bounces-346492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A0798C548
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E04E6285D56
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441461CCB34;
	Tue,  1 Oct 2024 18:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="pnRZfL06"
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020095.outbound.protection.outlook.com [52.101.196.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2E01C9B65;
	Tue,  1 Oct 2024 18:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727807133; cv=fail; b=BwMzBCPKGqDsuxdzvquN1ux3dOowgnhCAPxvBPwcz+n41souI1oX3SykerSp+Qy47DnEtV9iqAHvGM+39NzeR3K+12J2NLBz6PR7J9tLhwwKQ9Gy6yl1G2xMJXnBhJ206HoDB6rJlkE1rEjA8hdrpPtwJf7L8/gVmkmPOsdKuIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727807133; c=relaxed/simple;
	bh=B6BDEBj/leWI4KrSXB9JIOYUrXw+NibHkq1X2EKDs5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=StEXK30q4+H1yBsT63UhUFbqlQDqFHONdeuyQqKONDLRHZODP4nKUeW2znfoAVpwa7tL9sr+/pd/fK4D20tP+qsF5Kkbn4Eg0jD6jDQM9avi/4TZVi9Ic+KbuGBfitQvVYyFz22yQn8HNtgDa6wWfLWRBOf4srfTd/WMG2VydN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=pnRZfL06; arc=fail smtp.client-ip=52.101.196.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W8XO5tTPCQ+W7bLL6BkTrkunz6WQ9oOBEnw1QF0HRRP35c6YPr2MvC2naiB2Uzk/aZn0ju//yOLJBcqp24efk0lwStnqU1/PEdT3OjA7/JG+jEEjYQHyrdn4EfJoMgNH9sMb8DYGHOux0lXFX5jGLPRom44JERoTVsGQlg97QNZnACOk2mIvLwp38O4bsVah5IvDHydHzu4Z25/cf7IVmlg7ODqyJ/XvqQRQPuztIqO7l97bgGGWoW0FsNy5UAT90vxUDk/VqPPdGbF3/W4VgZKHyQVt4fR9lWb180Ta7xo2AHdQqX2pDz4XjbbEE+v4lBuXYEODVI5/aHBk4FMsgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSGhgzuD7A7v0PqfWXTFrLaJi9+VbXNuQo365NTmOf0=;
 b=GSDIn1VN9ISuqNos1U8MvQfZbljO2ekx7r/wrTj1xo+2b/S33ecVGg3EHM8OOAkhQF9f4+Ga/OofcvzT6ZwtBILe3Sd/kShXQxxW003Jj4puVRHR2Xa5S64KeHFWa7jSHV3Xy/c+RRYcm4DooO5XL3GZXqQkHRjpZDpS858zCiiPTXXrMTL1Fnoq3URGVP2q8W8M6aslyPPwzAXYQeffoaF+MucUc3M3Yg1QDrhM4MDkpLto7ut9FgUnkWEevjOC7nEJF+n0/FtlulPREKNvkx3xw9FkVJipaKljsPqYyvnxwfnDAWKx7mD7xHGeOwxRygn2C6kDC2CDQH1P8yHwTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSGhgzuD7A7v0PqfWXTFrLaJi9+VbXNuQo365NTmOf0=;
 b=pnRZfL06D1sXtPdVL8vYmL9TDpK9ecq5E8paGU3oIE2MXVtca1lVp1j+GmQ6EMD/MPGi6sweKBiBT3RCy+fcPfTPeEU+2cM5NbcpBKu2U1xFk6BFGE6byydqGfyDeYGLTT4ejEDd9qOO0zBg9RilQpETF3GwKWLuL1VQxUco/Jc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO4P265MB6618.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 18:25:28 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 18:25:28 +0000
Date: Tue, 1 Oct 2024 19:25:26 +0100
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
Subject: Re: [PATCH v8 04/29] rust: alloc: implement `ReallocFunc`
Message-ID: <20241001192526.0cdf9dfb.gary@garyguo.net>
In-Reply-To: <20241001150008.183102-5-dakr@kernel.org>
References: <20241001150008.183102-1-dakr@kernel.org>
	<20241001150008.183102-5-dakr@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0510.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::17) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO4P265MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: e5c55445-04f8-4294-2116-08dce2466d0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0pwO8zsMTeswKVwzktCOkLVER3F4XopxOM8XFF3mwoGSV+gV/D7H+Qk66CGD?=
 =?us-ascii?Q?K5pkZYNZP3JoPi9h8W23CEq+lV3vUcInYE/gdVVmzz8Nq1eP4hTOyXWubXOO?=
 =?us-ascii?Q?devQLRXYGLauI68InVa02VzpODvEW9nmgMdbgLCtA8lmuzwEpcKtfLKB8Fmh?=
 =?us-ascii?Q?5DFYuLDWUAQnup0C183cJu63cDlLAj6fjFNdl+QqtleJe7gnYAtdsapdfvyT?=
 =?us-ascii?Q?9EyT7dzkb5bXBcYwspbWgtHRmj6jDnNqj+LHxTS2Gkm03U5P3TzJUEzjI1ck?=
 =?us-ascii?Q?PMGyv5YAaIT1bZNtxMASDAIfgt2eYsaCOBAbARHCW14XlSo3Z9TMlOPoQznA?=
 =?us-ascii?Q?TfKYrKxvSdZHK4Zo5ebtFiDa+/yxbN1lycWmRdsDyL4mG1f3f5H4nmEwE4mA?=
 =?us-ascii?Q?KojWJXXGmluzhENt8vp635IblAaCjYu+n4pEPnjsMBKMXgTEIk4S1pb79ztH?=
 =?us-ascii?Q?KRo1uO0RA5KHh47j0bz/tXjL9Vc9mO0ZhDrtqdaKybkAT/IknHN8695xmk/P?=
 =?us-ascii?Q?T6h4D1ZBvfJsJLdrES+6dNlffZMvRJx5B2cdtwQZbfRVYAJ27CJs9UdHUMJZ?=
 =?us-ascii?Q?809isZ/ILQvcfaF6pHYbuVwu40XcXs2+MdX5IZPjbl+ROnr+Jr1Xn2rhQXzv?=
 =?us-ascii?Q?sjqCJ1OBlLBDiZxEHPVkApCXC37OKRi9gGMRRiVdX3rbc/Nn3TiAcS4DyRZH?=
 =?us-ascii?Q?3Zzc3NVTAswI/fOYG5F/YUW9roT4dkVJaMEYLrKjOgvirX3vey2XCuZIOyd7?=
 =?us-ascii?Q?Y+wTpNREotqiayNMpC5GYcrgErsKNL/9OW4FbD3K836jlWTNNpC8puXSfkE+?=
 =?us-ascii?Q?G8gOwQZlHRdXpYU5Ajf9HpYNzxAaxJ+tpb8LM7h0N5YBNdxEcDhOcFplh6pn?=
 =?us-ascii?Q?+b7k8m4D/8KuuRBhzdT43ovOT+was5ELnxvQHPX7goN9N6K/ok7/fgBAR7ew?=
 =?us-ascii?Q?6xL0XmPxg/VP84+X5tHciXpvHd1V1vqZGRzGleOaQvVCid8YlbS9wD4vQ76Z?=
 =?us-ascii?Q?5ol+DHbzNX3OfuU54mp2obDVS87Gnnn/wFOh40S19ODs7ZPauuVGG4w9kjhk?=
 =?us-ascii?Q?MvlRCaQ3hoAamH6kbRUp15aDcxGg4CiLhYXDNcy0vpjkNS5/YquVCEr5TZPX?=
 =?us-ascii?Q?PoHbGFkqr49XhW1ENIvgBFEXrZuDxAkSdjRMNzlzs/pr4vUChmNYVnNykrUC?=
 =?us-ascii?Q?rqTvRY3pjNl0kLQFU8rLuMH8qHzMn+Etl09aW9R4Toe/r41n4o/xFR1fBA46?=
 =?us-ascii?Q?UlTjUwYseg0xFwTM2PBqewsg0RZFATLxvxUqSQMlIQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k+4uUZXYwl+LdklkfxX1EOsVs5dU0PMIG1WFes6IyNrWuuwF8mKjDbs1npQi?=
 =?us-ascii?Q?hSJGrz05CX4Atf5/0e3Uwp7mW80UzumfceQhT/mXF1/tm+D53VxzBk0Xzh3O?=
 =?us-ascii?Q?Dl5VQ0kFUbfzQ6B9yCzmgZWXCiKmiGwPpuh2JdULNMSa2OaKK07uhenr1ckP?=
 =?us-ascii?Q?rqrd3qApF4FITNTD2jc+GfT7RRIuMacl7gP237nbMwU0zcgz99lP6ZSqwr14?=
 =?us-ascii?Q?1w7vUclGUsP+QjvMUd5a0EGaCDW9yDRcHLP4sa5SlR2RN8KKIfzirfv7fJ1L?=
 =?us-ascii?Q?mkh8zUS54kUcX7c6o/3cQZDjsl6TaqGK5RdTEA4GpF7gCe2I11WMfhkbpA7Y?=
 =?us-ascii?Q?GeaKxiSGjNJVIj7ZzDDGzD1D+UNmjyqBNMXm/5Ja/TGO6kyae07cTP0XaHzl?=
 =?us-ascii?Q?jAt81Kd1PYtqykJlbyyNXs6+oWepbAUOzJQdxf4bIrCA1Qojw9JTfzAHMtjL?=
 =?us-ascii?Q?AU50/w/hBGCRpeR6P1Lr9sN2Y71idqN1xpVYxmY0LG/YQUYd2pK+YKThpEID?=
 =?us-ascii?Q?gq2duqi4l/00zoV1c9PqSFnrVZxtx7GH1avlmUS3vW5B+/Eb563Dym9IMSBk?=
 =?us-ascii?Q?94/9SJx+AHt9C7gS62VZivmlswE4J3cw1epCAeiAYXZFsQyCfIEOSeUZ1jKt?=
 =?us-ascii?Q?6BmpZc6ofXDr0HmuSUG8GPvh4IJbhAoOq99KJyV+vSdpzXs+8LZ7O7aq0S5i?=
 =?us-ascii?Q?2+GqN8YCbxcf3t8lbBK9Oudm+VtX8KOFl+3yfYk4b7jIE6IlbLbq7XDUXVAI?=
 =?us-ascii?Q?ir4Uq2MUAjd+YnKW0xCPuH6O6BwMJ85hIxc5yeHMyBhHFb7XDBZ5QgRazSx9?=
 =?us-ascii?Q?53uu/sH+LBRJGXuj8l9mYEIzqZCaQyuoFPfu2V8COAknJQEso+V1wbFuJzng?=
 =?us-ascii?Q?hKn6deWYCT5jhoSO2AfzdefQfCvMWWwIhHJ09MsaTIMPKBdx0ekHz2zYZIa1?=
 =?us-ascii?Q?ag8MucNGFXhcBpCLj4qKGOZdJYw7XzBLXwOMEhGysCqsqRwYLpHNKVMjLxA5?=
 =?us-ascii?Q?wsZ0grGIoG0RiTAH8w2eggA+sxmePir9QTh03BG6jGddi9X1oyKqc7lJ8HN7?=
 =?us-ascii?Q?IbV7azo6f3T5XesHylvgLjpM3f1CBhZf/WFEu0XnsnQIEHYOvSSSIJE2IY7M?=
 =?us-ascii?Q?TMDRwBrmneHWCmZK3Fu4/HPa8tWsXiiVN8j0xZw8+ubWg+fdp3LI+uP1ugDe?=
 =?us-ascii?Q?++PKTRZW6jLqP+CQZzDZm7cL3Ih2Sk2qiE/JHdsAOPMNNeTclzXttWloBvYK?=
 =?us-ascii?Q?d25KBAVZs4bqp5ZZxOrXiDdZbKrq/s5/TrruQTbZZrXiRS5omD4VHUIVfbqH?=
 =?us-ascii?Q?10LqspzDqowDfSRhlqo1/nn7tfEoFdVJnNjVtWaEumYrkELgDElPjz06BWR6?=
 =?us-ascii?Q?huHpTHJ06t6lL0M0BpYLHzkvDFqH5kCOVgHIhTvVg1vs9XBZdeXjVD9k9R1T?=
 =?us-ascii?Q?94xKbuB/nSgxpFCTOFxxD531Nc9R5FQoPgkHvPCLb7SPG58OXHhS6eRp/gwb?=
 =?us-ascii?Q?YK8vwtc0/+hxkt74kgbs5jd72oT2p01yPOb0+/VsQBE8KLBTbnoNjbsqUWVa?=
 =?us-ascii?Q?1Ot7BAElHOcqvq9+xj6GwEwJQdjoz/2PGZxR3IY0SfD7zoXQ0RFrWEZzC+2C?=
 =?us-ascii?Q?6g=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c55445-04f8-4294-2116-08dce2466d0c
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 18:25:28.5919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c5gZIknyFVb85znHicu/e8e6oxfk8PLyzQoak1nyafSCk29+zxS+zHO7j/Y6rV1wN01n1ioDiw+P144hykYvtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6618

On Tue,  1 Oct 2024 16:59:39 +0200
Danilo Krummrich <dakr@kernel.org> wrote:

> `ReallocFunc` is an abstraction for the kernel's realloc derivates, such
> as `krealloc`, `vrealloc` and `kvrealloc`.
> 
> All of the named functions share the same function signature and
> implement the same semantics. The `ReallocFunc` abstractions provides a
> generalized wrapper around those, to trivialize the implementation of
> `Kmalloc`, `Vmalloc` and `KVmalloc` in subsequent patches.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/alloc.rs           |  8 ++++
>  rust/kernel/alloc/allocator.rs | 70 ++++++++++++++++++++++++++++++++++
>  2 files changed, 78 insertions(+)

