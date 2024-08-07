Return-Path: <linux-kernel+bounces-278382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5C394AF85
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 20:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BC46B23CDD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AD31428E6;
	Wed,  7 Aug 2024 18:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="Rzltcsfn"
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01on2136.outbound.protection.outlook.com [40.107.122.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E885013E409;
	Wed,  7 Aug 2024 18:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.122.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723054784; cv=fail; b=RWhfpv7GxNtUhhglzzw3KrhQlPYk2tGAVyak3I+5wzfxc4SIILB6o0aD8YuUYi0LOIzNZTq7xkYFo0CFW9kQoBcQJ0ocp7u1RdP8tvNmRvsPWbtGBuB1PnqAeC9R74XLDSj6PRQOT/04zqNnvVQhkDtcmJhJifOX4BCgxTu32+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723054784; c=relaxed/simple;
	bh=tOLKaWe9Z0t7QFiD7j0DsR2BUIKI9GGmF8CCDG1DjpY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fo/+yxvFZhh+JV5zhl1Y1uYIu7qyeCwIbv6Qu8q3eKXK164/ZlBftY8skI3/bj9yKA5kw7hAatonZI8BcrqOb6ubnjOMpdEE6SfGE/ShWWxN0YRRQ7ZLljFg1DefchOJrEgmqnbCNjQgYfv4BT4BA2CPnxzqI4ez0TvDbpvUes8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Rzltcsfn; arc=fail smtp.client-ip=40.107.122.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o0cpbm3/mDTwFWD6dme3wxXDnS5zmFa98gBwcww3eseUDWzhgyo2ufe3IFWw7lOpYza2bEjDEfu9qdRewAzpBXmSQXijKP+o9iR9ly0eEqMmdpElOBwtjkDT5Q6kyce1p4gSLEyqww9bUHqRSyDZuZklT9j3ffvtsYlq3KUXgUMRFfXUqm28zNzK/IdabCXA02cZbRg86RI9qObbNrb3kor2NsmkOxSWYlwHvCCGTyC0EObgYkKhQmZjgrsgBTKS4LHqyu9vcBpHfcX2tBMAJJ/AY1th3qnAvYEt0XGuv0oRNbOuvzn3PVORkBlwT4kWCHq107ybaQslMAco743z4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/lz8TlEHdHhHKF07WV1LYRilA/JfZiuD8r1DN7m04w=;
 b=t5cVCFc6bUIfiWIlkVH/MeJ0MvLtKhuYgnUsJt/DNDaPIsKyK3yyjaXDWpm6xYkokp+tLmhhJDPGP720YRP/p5Dwum6G0nttm6MwtRnOTN+S/2Am3CVW5mqh7J4uZqwLrjLKd6v+zOVRS/6Ry50rCZ6PtzkA9muyROX3QHbinU9DHWglHkkzru/WDTh9+DvZbJIHPcXOveYjynQgKleT+26lXOczgMiF5Hr7iKqFlOp71xQE3cy/lgBRjEdKH5uwfxhuwGDEoToMcF2yjyDeCuCmtxwN2VGorYUr002v+GWEOyXAK3GggDHQGb3KLsmqjum2N+ynIY29Uy8O21rIpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/lz8TlEHdHhHKF07WV1LYRilA/JfZiuD8r1DN7m04w=;
 b=Rzltcsfnh2ZA2HPEjEKTKEg0OkIAS2C/pbT35yiY8icTUjIC/UwiovRybYWMJOLr7dejj8idlivT/F4dZDBBiYNTtahdSpbrtC/mbkNEPmbIrQgflbH0tTmBqzBiX+OEsMtiUbA/NSrV31e8MRdxHN4CBwAbQaqMph2XfONBW2Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWXP265MB3286.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:d8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 18:19:40 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%7]) with mapi id 15.20.7849.008; Wed, 7 Aug 2024
 18:19:40 +0000
Date: Wed, 7 Aug 2024 19:19:33 +0100
From: Gary Guo <gary@garyguo.net>
To: Danilo Krummrich <dakr@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
 boqun.feng@gmail.com, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org,
 daniel.almeida@collabora.com, faith.ekstrand@collabora.com,
 boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com,
 zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com,
 airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v4 01/28] rust: alloc: add `Allocator` trait
Message-ID: <20240807191933.6e6c2206.gary@garyguo.net>
In-Reply-To: <20240805152004.5039-2-dakr@kernel.org>
References: <20240805152004.5039-1-dakr@kernel.org>
	<20240805152004.5039-2-dakr@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0403.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::31) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWXP265MB3286:EE_
X-MS-Office365-Filtering-Correlation-Id: 99d8ae0a-6573-4b20-d455-08dcb70d8074
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QdJiUn3rJmDY7aRUCuXVrq/s2KAmF3jBv6tD2xYQ7jMIltIx6J0Isn7/ENt9?=
 =?us-ascii?Q?V99cB27Hght17ARVNMbfVajgYXewCd+r68YEk08pVhZ4CKnz4uMexyLr7u+6?=
 =?us-ascii?Q?AMmns8/NPAKdnariWOufEwpNgOiozd7r6sNryZmu9ixq8Rjm/8SIuePaK2ve?=
 =?us-ascii?Q?5xe3d3F/DeapSBwdAFjaYvyvsIbBrCNNaKidCv6UrRxMV33X11bZPYAYnkir?=
 =?us-ascii?Q?99yHVwWBAhlshvSSTsAMWp/fY4QSFcGPLuASHI2qzoNWu5gvVb3oMN5DDpVU?=
 =?us-ascii?Q?px79QMv20ewQeuq4YDZkMXrmUcNWiWu1UzYyhR569r2ezu0nrdJR3YfRECAk?=
 =?us-ascii?Q?2x1n318oItMTyO9tY1FOx2ZzZm44E2X//401feG7Nzz03RoT/iL5q5Dpkn0z?=
 =?us-ascii?Q?zl9ePeAY6YaR7CFEqP3hU3Oyu5lGxAbUXBj+5BcEUae82hs2OnqV4suAfnHy?=
 =?us-ascii?Q?QLm8UG8AasoQ7xQOZoWW5iivzk28suCuy0M5LRondxwaSqRbGHnnJnqM6Fp3?=
 =?us-ascii?Q?LhLVLJLLBCUKlHxVbZDy8hJTbLmGCbY6JjmsqPpHA17ySDlHZF4t9NAGw9Jg?=
 =?us-ascii?Q?2xpD5vPrzpCmyAcbV4R40mtmuzn/VXXdtTPyOJHPBCFY/djFezUMx00vkWQq?=
 =?us-ascii?Q?P7Td4a7uaYRUo3xsCWAP5UjRmG11jZTK1um2h+yUcjyevEgRw6vxoVh4bfVQ?=
 =?us-ascii?Q?737q+FA6TcTqaKAJXVxd07YtoZMONdRBwXm526TltltQXccA8N+sHGGyd8bI?=
 =?us-ascii?Q?sQ1NFJxpvFLal+xS0d43rWn76cd/1WS3R1Wnq+PpjsaLh2lhJBBhB2agUOEh?=
 =?us-ascii?Q?fYLDM4r8hj1yOnsgUB5BXd9VOSgSuaLtdixnNolpHnRAeh9I7K5jBj1SHzrr?=
 =?us-ascii?Q?NPEy4qxOEfy/3LLOnhntpvfMod6qYyJnzrwZoDxm7Djn0o+uIbPrOn1ZKMlC?=
 =?us-ascii?Q?yvqxG7GXk/tnEB33TPUIdZlJoGrsuHOcYou8UgaQHyyADQPp/L0OQrnPAGXH?=
 =?us-ascii?Q?RQqhkQrFEMnq6Jn0N0vQujy8ITJgpHl1lTwuYq7TaCW6eTyZMf+KILvktzGI?=
 =?us-ascii?Q?Elcb6kc7RRiANepHqzdwqdNegsaV+ZDnOSmRRY0Cmx0GBlNeAWRKvFRkqOiV?=
 =?us-ascii?Q?uetr06MNDqbNlH1B4boXxP20WiMINYXqEJCtjunXNCB4yWvDT2sF8C0j58oM?=
 =?us-ascii?Q?ssHQWWyUxD2O03GnnoQST7TW72UL1hBIUpkMjon27Ysh0Gu0vEItdlmXmToc?=
 =?us-ascii?Q?7LB+PBjXl0RhByJPhQ0EhMFm6MsGswrUCYMSD070R9RfTLPmoOTBLXoU7W0A?=
 =?us-ascii?Q?X0QNlw6+w+zbxzhK1KlK9zax+6m8ENybsGJdq6TYoSKh8Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+K+7gGoKQoemsuyq55wlsrLRqqpsfDqxu48EiBCGoQsrY72eRx1AKhtBmICw?=
 =?us-ascii?Q?FYIRjIJxeHGw+WwrIdEhLR8biXiVW8qlbFx5KOrc70TN7fVHdM5kqjL+ULXG?=
 =?us-ascii?Q?Mg0uhzWySegE1+r8eQ8Od/4ZL+wIETJsmz18M7qO9cP+YSQFB9oxhZnXvrF6?=
 =?us-ascii?Q?74ax2AUMLhSvWk1joal09LS2+Bq6JZRN9SKxzQg9QsHut15VuWH930vGaziP?=
 =?us-ascii?Q?9eQSKQFKTQ85nq/ExnidfB9eCfiR9eK5ieOryGSrhkx/cPkYXazIN0h7pHbO?=
 =?us-ascii?Q?II/YM3dRXvzyKgsj5OXqjtdPG2hmY4LC6SgcsWah7W64dL0HkOiUwnCICphW?=
 =?us-ascii?Q?1pMPzL0JRUhDwTfCObIBxx7cPY22jbk64Ob2kD6r1kFMXPdS0RMV30g8eFZU?=
 =?us-ascii?Q?IOnvrZfaEB58Aywwe50Yx4Awfrd0ikoZ1+KXQ88+A+yCKG/D8WWeBigUMeej?=
 =?us-ascii?Q?gW9Qer0b246wTaWj67nLv0BMAqDQ+sOrM3V+z+Y32ZiMj5bfnGhb/wvTHMqY?=
 =?us-ascii?Q?PCjZUYY766oGgFb87P/j1M7s5CzfTBwCcrfdzGiTUB2AzwbMq+qDssvj0z8b?=
 =?us-ascii?Q?8956h7oJ3lZtVI5FPA04REBJ9hFvLiIu7bzd8lhjKrQrwiZUyaVRczRQToeu?=
 =?us-ascii?Q?QdaYM44DFgCccJN5OlCU/QoYhik7AZDxMwZhmtvfiaN+/7KlNvaOF8Dj0+DO?=
 =?us-ascii?Q?JI6UueJzB/eUvOfAl6c9SyUL1mScZJWtCr3hBwyKJAjJ6HGLUukGuNproB4d?=
 =?us-ascii?Q?ptsY7HYaiXUA1Un/EF7Eqw90+Iijr9m5B7vhvosZQrMlMGLaRBF6HDiexqC8?=
 =?us-ascii?Q?EwQJ07dIeRbsuiI+Jt7OObXly9yLPme9fx4WAHrI3KoLQF4WLP0qekaHbVtS?=
 =?us-ascii?Q?3vCj2lFEBOkCn+X3qn15pfAjGWc330EAnHlbMgRt/Zb9T3vDO+7uHkT7dd1g?=
 =?us-ascii?Q?20QWKpkm8xzDhKL3fPB690FgHz2MqjdkVebR3LSZ9QuXop80SYNjrwo+bOF1?=
 =?us-ascii?Q?uqJEOVoXjIaRZOLju/Nki1MlaerJP5oVwqWGyu55XTF8E4iQFTM3k3ZPz35c?=
 =?us-ascii?Q?HFTCkxPP/AvlA7Kg2e4fF1+1Cmw1Yzpcqr4+KelCdLSmfGuhn0gazFdwL5BU?=
 =?us-ascii?Q?I+/MJLxZLyjaTzc042aCtqnjM4lqGPJyLdeuRIC+nJv1Lwerf+CiWVkdHl9+?=
 =?us-ascii?Q?k215olgbg0PA6yYyeWVUFAOSDF0xTU5vclwoeQk0GZnqssaJANO3EbOp4qUj?=
 =?us-ascii?Q?umyQkGx85M58ZNyKsagAySLbXkr0JwBql+kQ7YUnrCWW5c50v1PLTF+HV1MZ?=
 =?us-ascii?Q?SNNSpGaAk2wUzoGM8c1CqUDgr6PLRpnNjDnj95YY6v6NzZQ4wD+gx0gGz0uR?=
 =?us-ascii?Q?Fc/WQSQT2CmrFCn+Q35AMBMXgvNZf4rCQjoTbCHR1YOUUTXoWo84sHeMPvuO?=
 =?us-ascii?Q?I6CjJW+n49KT6YRA5VWSwh0MCDIU+47kA1a8JlI4+zOBetYBNoRC0tlGagMt?=
 =?us-ascii?Q?8VP1ZNbnrmP4l3cjqJ9UhHKNejpghvUoYZHfwGY70bvvw8gpGFjR3hc3SI7x?=
 =?us-ascii?Q?QDUt1RJcz6dLjl/tQ/u86ZG9pz1iq8CFfNtmMWMAhRbGiPFI/cbYfIS3l0iR?=
 =?us-ascii?Q?zg=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d8ae0a-6573-4b20-d455-08dcb70d8074
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 18:19:39.8693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CwSLEDPKdX6BGUYar26leQ9ioEq7Z6n3oEzCpOegHCi9oBLSaxmlf6fp7muf/NIFeqNR50Yt41wnHL02TlrHyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB3286

On Mon,  5 Aug 2024 17:19:20 +0200
Danilo Krummrich <dakr@kernel.org> wrote:

> Add a kernel specific `Allocator` trait, that in contrast to the one in
> Rust's core library doesn't require unstable features and supports GFP
> flags.
> 
> Subsequent patches add the following trait implementors: `Kmalloc`,
> `Vmalloc` and `KVmalloc`.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

I agree with Alice's comments that mentioning of NULL is confusing and
should be changed to refer to None.

Some extra nits below.

Best,
Gary

> ---
>  rust/kernel/alloc.rs | 79 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
> 
> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> index 1966bd407017..8a71a589469d 100644
> --- a/rust/kernel/alloc.rs
> +++ b/rust/kernel/alloc.rs
> @@ -11,6 +11,7 @@
>  /// Indicates an allocation error.
>  #[derive(Copy, Clone, PartialEq, Eq, Debug)]
>  pub struct AllocError;
> +use core::{alloc::Layout, ptr::NonNull};
>  
>  /// Flags to be used when allocating memory.
>  ///
> @@ -86,3 +87,81 @@ pub mod flags {
>      /// small allocations.
>      pub const GFP_NOWAIT: Flags = Flags(bindings::GFP_NOWAIT);
>  }
> +
> +/// The kernel's [`Allocator`] trait.
> +///
> +/// An implementation of [`Allocator`] can allocate, re-allocate and free memory buffer described
> +/// via [`Layout`].
> +///
> +/// [`Allocator`] is designed to be implemented as a ZST; [`Allocator`] functions do not operate on
> +/// an object instance.
> +///
> +/// In order to be able to support `#[derive(SmartPointer)]` later on, we need to avoid a design
> +/// that requires an `Allocator` to be instantiated, hence its functions must not contain any kind
> +/// of `self` parameter.
> +///
> +/// # Safety
> +///
> +/// Memory returned from an allocator must point to a valid memory buffer and remain valid until
> +/// it is explicitly freed.
> +///
> +/// Any pointer to a memory buffer which is currently allocated must be valid to be passed to any
> +/// other [`Allocator`] function of the same type. The same applies for a NULL pointer.
> +///
> +/// If `realloc` is called with:
> +///   - a size of zero, the given memory allocation, if any, must be freed
> +///   - a NULL pointer, a new memory allocation must be created
> +pub unsafe trait Allocator {
> +    /// Allocate memory based on `layout` and `flags`.
> +    ///
> +    /// On success, returns a buffer represented as `NonNull<[u8]>` that satisfies the layout
> +    /// constraints (i.e. minimum size and alignment as specified by `layout`).
> +    ///
> +    /// This function is equivalent to `realloc` when called with a NULL pointer.
> +    fn alloc(layout: Layout, flags: Flags) -> Result<NonNull<[u8]>, AllocError> {
> +        // SAFETY: Passing a NULL pointer to `realloc` is valid by it's safety requirements and asks
> +        // for a new memory allocation.
> +        unsafe { Self::realloc(None, layout, flags) }
> +    }
> +
> +    /// Re-allocate an existing memory allocation to satisfy the requested `layout`. If the
> +    /// requested size is zero, `realloc` behaves equivalent to `free`.
> +    ///
> +    /// If the requested size is larger than the size of the existing allocation, a successful call
> +    /// to `realloc` guarantees that the new or grown buffer has at least `Layout::size` bytes, but
> +    /// may also be larger.
> +    ///
> +    /// If the requested size is smaller than the size of the existing allocation, `realloc` may or
> +    /// may not shrink the buffer; this is implementation specific to the allocator.
> +    ///
> +    /// On allocation failure, the existing buffer, if any, remains valid.
> +    ///
> +    /// The buffer is represented as `NonNull<[u8]>`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `Some(ptr)` must point to an existing and valid memory allocation created by this allocator
> +    /// instance. The alignment encoded in `layout` must be smaller than or equal to the alignment

nit: remove `instance` since the methods now have no self parameter.

> +    /// requested in the previous `alloc` or `realloc` call of the same allocation.
> +    ///
> +    /// Additionally, `ptr` is allowed to be `None`; in this case a new memory allocation is
> +    /// created.
> +    ///
> +    unsafe fn realloc(
> +        ptr: Option<NonNull<u8>>,
> +        layout: Layout,
> +        flags: Flags,
> +    ) -> Result<NonNull<[u8]>, AllocError>;
> +
> +    /// Free an existing memory allocation.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must point to an existing and valid memory allocation created by this `Allocator`
> +    /// instance.

same here.

> +    unsafe fn free(ptr: NonNull<u8>) {
> +        // SAFETY: `ptr` is guaranteed to be previously allocated with this `Allocator` or NULL.
> +        // Calling `realloc` with a buffer size of zero, frees the buffer `ptr` points to.
> +        let _ = unsafe { Self::realloc(Some(ptr), Layout::new::<()>(), Flags(0)) };
> +    }
> +}


