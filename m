Return-Path: <linux-kernel+bounces-350710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF31199089F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E09EBB2B145
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14F91CACD3;
	Fri,  4 Oct 2024 15:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="PF22s6LX"
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021089.outbound.protection.outlook.com [52.101.95.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFA81C878F;
	Fri,  4 Oct 2024 15:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728057226; cv=fail; b=IKse7H/deA2Jw2wOQpoUdRysJptW7crBm/T2W5Rvyuj0J4lZvDmdCkU9JgWHX/i3NBM3Zwcjqc2mdI60iKPx3BaLz0f5JvfRb5Bc/xSXMALyy4mB+GED4xK8mk6mdAklD05CIwqWiiviR3/zfuC2BF8UuYDVWh8gYDtb3o3jc8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728057226; c=relaxed/simple;
	bh=Y7JllC9PEwgK9xzji68BUGsRkbxikKUgJsQKauBPB/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aUVo32+t3b0E0hqTttsdK5ginSfk5oPGWy5bIPqKOtBHp0BO0JLyE/tbHUDD8qUMQEhZ2zsvHLH2ihIscpvWCrGuniB7u7vUAd6TaKh3fvJZ0pPTdPTCtS8IhCVtYoDKmNMk2a0dOWz+5TCcWvcelRsR29MO9PTjJ59krtqqC4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=PF22s6LX; arc=fail smtp.client-ip=52.101.95.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NPWFcGbKLRYteFIGSKTa3+vgW1BuDqjv5YtJrHSIEEJLf2M6GPeaxJs2zfq04zNY2rzcrlz7mZ+zXzeXvNzFSkVk4E8yzo08lSwxwfl+ecUdyt8tv/Pz1lmKEbTvFV3s779h+3VjjuizQqUftEwh7tgfDeUcRcXEfufgihldwd2V3w1AmOqm61SPd80gN5O4xFiyJG1R8hNiUiPCJNdQDpimBVfSKVW0IMm69p30h0nKS/RNrLdfi5GE52uOnIFrjUMR5qtLuFsedNn7cE4A706uu11zUGgcn1+55dzNdlstPIzeMn/tvXvGiB5unHjWH/KMYwMOrW4xi50MBzVQsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9uULuog4Thv2ZcmwK0F72qh5vbJC0TcTOhUtt+Zxk4=;
 b=eczndUutWAMmjD0iH+YAfxeOI0D6GesL64PRiv9J9MzfSeoDyJx0pzvBhEHDvl63IsCTOJ1BCgxafyagtD3LQRFJxc9IqBnlDQcte04bgggv+G4fDDNFffLIQ3gDCg4Hnp9PBK5Fm994+GuxlekH8iX28dqGNeOz73BzRnybWaWyp50br/g2i/4/FmnD77Jm/xCqGqnqnSepjNFSqHtapGz5TEtempSa/8VMd6N7O9HgNf7GD3bZtx1Zjsm51vsReqweAJjacCO6H6YO3iCxZevTOPt6OxAKG9Es1wlJv7PlN52ZwQBaDz3MrPPn8IJ4WpmlzMqicvmatsFhtDshXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9uULuog4Thv2ZcmwK0F72qh5vbJC0TcTOhUtt+Zxk4=;
 b=PF22s6LXeDWf+xFawwye7TTPNZz+VWKc90lypduIcoms+0XL8tiN+wPvjFOtYSYlGiDiO8cD23wvsHQjE3ySnnZDJR3SoDbEZvr+/dnq7u5kn8hQiM5CAcejV2znZ3Q0VCFDB6mHjtp3adC84QdrXdTcsC+ZeBsbXYs6cs0eSao=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO2P265MB2557.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:12d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 15:53:42 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 15:53:42 +0000
From: Gary Guo <gary@garyguo.net>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Wedson Almeida Filho <walmeida@microsoft.com>,
	Valentin Obst <kernel@valentinobst.de>,
	Alex Mantel <alexmantel93@mailbox.org>
Cc: Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] rust: convert `Arc` to use `Refcount`
Date: Fri,  4 Oct 2024 16:52:23 +0100
Message-ID: <20241004155247.2210469-3-gary@garyguo.net>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20241004155247.2210469-1-gary@garyguo.net>
References: <20241004155247.2210469-1-gary@garyguo.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P265CA0013.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::19) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO2P265MB2557:EE_
X-MS-Office365-Filtering-Correlation-Id: acebf20f-d75a-407b-ba4b-08dce48cb873
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hcdC7WhUVU47K7paeSCxyUq6xefTEZ4jVBTqeB7c/lQTbVf/4LfIEXFDkhIX?=
 =?us-ascii?Q?IcQF5hI77jzg8SU8Ww3GBSQlU3BS5l/L68ivxIOcVXH25GPN/bHxhzUqEpYZ?=
 =?us-ascii?Q?JXevXocRUIRwspsGofGKuZLZ2V+ieIYvZ2ZlTdqHK4hDp2GtzojfHvJdpN4X?=
 =?us-ascii?Q?qCnrZEfiVEyxTI7+HhIanSOTUo5otKxvvWk39oHwRzWH95gW9bbE92pH3Wc7?=
 =?us-ascii?Q?mnJDyAsC3AVAmS211dGKi4m0pIAL4oA9hi8f9BgcQZBv4/9o9zn6tgZgYiMc?=
 =?us-ascii?Q?eYPb35MUuKmm5vaaGHUoSHlGxQSAhom/3bKGhiyR7r5uJ2TB21+tobQ0V2fZ?=
 =?us-ascii?Q?+XJNtjeblBYMIEvvFYe6Frknw6+eZEt9RPrYkiSwRCXIJHQNjnpjFXlckRkB?=
 =?us-ascii?Q?r/X1mMJGK46ezwgpKroaM2e/PrroN1yxLo0VNnfwPK7UhLZ1QbnNf/slq/Og?=
 =?us-ascii?Q?ojUl2UBE1LFwaHYfsv9lNP+jzOcKS/MQfdVmIwh9LeaEAZmJT9Y9jqttuP25?=
 =?us-ascii?Q?5DBJiQwbHMLrsuyfnVv+WE4UMFoFnQxOgvxoN9mbtxWjn8Va9pVkt9XX30SX?=
 =?us-ascii?Q?YSFlJewaqVedoeXFA8BRzxRRZjSoTf6qOKHcg8nPj2azy6tYmZXYhqsW4wLi?=
 =?us-ascii?Q?7qIyl+xNgJ1pLyl2jN8JrS4k+lrQ4U2xsI68dxIl6y3TcV4s/tE4pNJCPJpp?=
 =?us-ascii?Q?Uu3WA1p+8xqlWpXSrde/c6Z50tu50mpsKxUkgnjhFyL77T1eO4FDCBZIxSa6?=
 =?us-ascii?Q?yduOgcE+g9MjRz7bLbdU4V9HsXEHfEAfd06GZjkGfYB85ii6/hva6seB6R6t?=
 =?us-ascii?Q?TIa4dvdcFUgop4i/q4slsBLxJ+VaWLY7BVYjIy/S388U2/GY9NtefPqZ8Zd1?=
 =?us-ascii?Q?/SKvY75lri+8efBVp+R5QgSPniZ33rKwT3FSQbYHliB9FUN2uprmm6bD2TNF?=
 =?us-ascii?Q?XwMzbsjoCaLnoZKyHq5jD/a9Bm5kLBD+gW0zNZM4Xn4bADir4rC+C11dzyUg?=
 =?us-ascii?Q?NkCLVOvFc3sseMcWykd/DBgXLAqDkq+ck0KE771/Ja+bLH5TAUP73uqbnD+e?=
 =?us-ascii?Q?b5p1ACeUkIMgo7dUeRdzZceUVVOKx1VxD6DjAsMwT2Q6YD5p+2S9hdmopfe9?=
 =?us-ascii?Q?4Gbbqp87tPfqjyLL0BycksNuVkW6GU8It6rEukFoFM55t17tPjvTutTaALnv?=
 =?us-ascii?Q?caYSGQ9/+xRwrQFINo2emXOGC6nw9Bi+Tzk2BLnfogqQ5mp7SclP69Ouhpsi?=
 =?us-ascii?Q?aPKsmTYDSOP6n4JOBk2Pd4wXzM4gwYCJevQARJXKvToyM3JYpLYTF41BfeFS?=
 =?us-ascii?Q?/AlhyTt/XITFR6VPkv15hrqB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nkr0iKkqlfjTng0LcuQxzOFL/LnFASWb0+0llSm7/zQpb/WTc6lzKw5k91cC?=
 =?us-ascii?Q?aPdVSgELWnCNF2MGDsNRIS6DDNxF+fAto/jv4xYyFPp6vy+87lGxrkZOs0Zr?=
 =?us-ascii?Q?qV/7dvQuYmJw7ciH2ybqecrb/hXrGQ5Ttjhyhnj+Mx2DcokOIorRzqWnxClQ?=
 =?us-ascii?Q?z4a3BMesm8RjSrbqmEyZbPX3I3HIRI70S/KpT6g1FyBFYkixblZf+85rxXY3?=
 =?us-ascii?Q?V3gJ+Cq1PcKMT1rKxAmyPx04K2KsLjTRxSQsL4Yc6L1pBWwfSKinBUKqz9aH?=
 =?us-ascii?Q?OA+X13VvMDLAo9pbbkX3K/B4LYjwK1jgMEcI3gm6hptcYYJXsTo56qaAWlC0?=
 =?us-ascii?Q?olxIM4sHnSJZOGKfcInmb7aQpohr4riGyf2UeIQS5e4A0ZBcEqTmMb6ZMoep?=
 =?us-ascii?Q?e1Ngcjld7mNult++YAaTp7HdaANd817bchaMUQXU5ruaxnBu8Bp7hgiGgSmt?=
 =?us-ascii?Q?t8wtJrKNVqZMUgi796PHLqkPa0HHz9fbmqdNoqWgTzin4JeEdoYDAPIkrXXe?=
 =?us-ascii?Q?G3tE1TO8X2UgrHZRFY2KnKJCR9oMv4se9PYnxTYdj8H6nlQRMZAW67RXTw8e?=
 =?us-ascii?Q?D3x164Bahj4Le3Ry0us5DmihDEaHCt+NY5/6RcIndaA3MiViBLyJ+Uz5uyLu?=
 =?us-ascii?Q?3ppILyxyTlMZxZy3TET3QUdUTX/JFFRSqQlR00ENjPTYSLyzxuVMmXFOHW/T?=
 =?us-ascii?Q?zbPs7Ky+U+rrJTGNkiPM6BP/9S+hcL0KNxgFDTw0JOLUM5IMnxW6UIYAz3SV?=
 =?us-ascii?Q?4PLHHGGlQb5cHLRjSBBK3Jtnt+bz3nSTkhfI9P4UsG9DaAOgMpUBQtk/W/6i?=
 =?us-ascii?Q?jErdu+z6AsbzchnpAM2aANpf+HN1F0I0jfTWNSew0hE/gfgoLKSe7JdNshXp?=
 =?us-ascii?Q?Tb73xDHUobnlGdqzHkn/TV60zNId4X6jg3nMJFOxSb4uCVEyECbul00m7r6D?=
 =?us-ascii?Q?mB57ZtNOUuFagRUV7KO29mNohke79RRUicbbLUQ3o1GslnVdhGPwd8zOwyii?=
 =?us-ascii?Q?c8Jk5+cruBBFPRUk7ukcL8yO7HaMKtpvq6a1asarpzPJY42ZJrd+WA9LU2g8?=
 =?us-ascii?Q?aWOLp1UnGgnHfDEGfasl+fHMvN2eWyzFwVvgxYNCKsVYokMF0P/IBZInb+LI?=
 =?us-ascii?Q?1MCDjmP3pjn/X9GBUpdOFcaDx7SggraPS9dzKD29woybk/qfsnxR8QyJh79X?=
 =?us-ascii?Q?pfZrKZvZXES9wRD4ll28iIdaVQBuaWG4A7t76UeffBgOjpM6w5bGV0u9baJh?=
 =?us-ascii?Q?HG0PB5c/+078ZMaSIu90G3fxqEsyfJQ1EhbGeCtQjzc7V3LYYDe/52QOL1RR?=
 =?us-ascii?Q?UJeom8W6CbtpKzQrUS1EhoT6fSL5Y2iG6w0yQH9QRehoZJncVYMza8OgBZS4?=
 =?us-ascii?Q?OZmbJ99TxcYNQAxUU36E3S40EHik4P+lLJhqxqYQwtYgGUXxH0oBQGbCkPpK?=
 =?us-ascii?Q?h3PlV40O3nol9aExeeHa4i8Rzs1/haFp8ppOLf06OoBGzzZMIUJWPGe6N29p?=
 =?us-ascii?Q?dLKYi4OrC28XVaHRedCF9WAerps9XirYvpUpfxzISZFJYhMYhFsfR+EuqOON?=
 =?us-ascii?Q?8M3m3CkNuVpVBzJ9umuDlNpHac0OVGlBjs7Umg75BBOWgjqgK5xnIqzCO3Si?=
 =?us-ascii?Q?2w=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: acebf20f-d75a-407b-ba4b-08dce48cb873
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 15:53:42.2069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3yBPL6cxZ+T2RMp4tr+4RbifpUX7Doy93kv4ma2I0VL/vQQTA1FN9QsdHF8vSFXkmKbpnZHf6G33+JeLF5B6Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB2557

With `Refcount` type created, `Arc` can use `Refcount` instead of
calling into FFI directly.

Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/sync/arc.rs | 45 +++++++++++++++++------------------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 3021f30fd822..a1fa58b127c8 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -8,7 +8,7 @@
 //! threads.
 //!
 //! It is different from the standard library's [`Arc`] in a few ways:
-//! 1. It is backed by the kernel's `refcount_t` type.
+//! 1. It is backed by the kernel's [`Refcount`] type.
 //! 2. It does not support weak references, which allows it to be half the size.
 //! 3. It saturates the reference count instead of aborting when it goes over a threshold.
 //! 4. It does not provide a `get_mut` method, so the ref counted object is pinned.
@@ -18,10 +18,10 @@
 
 use crate::{
     alloc::{box_ext::BoxExt, AllocError, Flags},
-    bindings,
     init::{self, InPlaceInit, Init, PinInit},
+    sync::Refcount,
     try_init,
-    types::{ForeignOwnable, Opaque},
+    types::ForeignOwnable,
 };
 use alloc::boxed::Box;
 use core::{
@@ -134,7 +134,7 @@ pub struct Arc<T: ?Sized> {
 #[pin_data]
 #[repr(C)]
 struct ArcInner<T: ?Sized> {
-    refcount: Opaque<bindings::refcount_t>,
+    refcount: Refcount,
     data: T,
 }
 
@@ -146,7 +146,7 @@ impl<T: ?Sized> ArcInner<T> {
     /// `ptr` must have been returned by a previous call to [`Arc::into_raw`], and the `Arc` must
     /// not yet have been destroyed.
     unsafe fn container_of(ptr: *const T) -> NonNull<ArcInner<T>> {
-        let refcount_layout = Layout::new::<bindings::refcount_t>();
+        let refcount_layout = Layout::new::<Refcount>();
         // SAFETY: The caller guarantees that the pointer is valid.
         let val_layout = Layout::for_value(unsafe { &*ptr });
         // SAFETY: We're computing the layout of a real struct that existed when compiling this
@@ -199,8 +199,7 @@ impl<T> Arc<T> {
     pub fn new(contents: T, flags: Flags) -> Result<Self, AllocError> {
         // INVARIANT: The refcount is initialised to a non-zero value.
         let value = ArcInner {
-            // SAFETY: There are no safety requirements for this FFI call.
-            refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT(1) }),
+            refcount: Refcount::new(1),
             data: contents,
         };
 
@@ -308,18 +307,15 @@ pub fn into_unique_or_drop(self) -> Option<Pin<UniqueArc<T>>> {
         // We will manually manage the refcount in this method, so we disable the destructor.
         let me = ManuallyDrop::new(self);
         // SAFETY: We own a refcount, so the pointer is still valid.
-        let refcount = unsafe { me.ptr.as_ref() }.refcount.get();
+        let refcount = unsafe { &me.ptr.as_ref().refcount };
 
         // If the refcount reaches a non-zero value, then we have destroyed this `Arc` and will
         // return without further touching the `Arc`. If the refcount reaches zero, then there are
         // no other arcs, and we can create a `UniqueArc`.
-        //
-        // SAFETY: We own a refcount, so the pointer is not dangling.
-        let is_zero = unsafe { bindings::refcount_dec_and_test(refcount) };
+        let is_zero = refcount.dec_and_test();
         if is_zero {
-            // SAFETY: We have exclusive access to the arc, so we can perform unsynchronized
-            // accesses to the refcount.
-            unsafe { core::ptr::write(refcount, bindings::REFCOUNT_INIT(1)) };
+            // We have exclusive access to the arc, so we can modify the refcount at will.
+            refcount.set(1);
 
             // INVARIANT: We own the only refcount to this arc, so we may create a `UniqueArc`. We
             // must pin the `UniqueArc` because the values was previously in an `Arc`, and they pin
@@ -376,10 +372,10 @@ fn as_ref(&self) -> &T {
 
 impl<T: ?Sized> Clone for Arc<T> {
     fn clone(&self) -> Self {
-        // INVARIANT: C `refcount_inc` saturates the refcount, so it cannot overflow to zero.
+        // INVARIANT: `Refcount` saturates the refcount, so it cannot overflow to zero.
         // SAFETY: By the type invariant, there is necessarily a reference to the object, so it is
         // safe to increment the refcount.
-        unsafe { bindings::refcount_inc(self.ptr.as_ref().refcount.get()) };
+        unsafe { self.ptr.as_ref().refcount.inc() };
 
         // SAFETY: We just incremented the refcount. This increment is now owned by the new `Arc`.
         unsafe { Self::from_inner(self.ptr) }
@@ -388,16 +384,14 @@ fn clone(&self) -> Self {
 
 impl<T: ?Sized> Drop for Arc<T> {
     fn drop(&mut self) {
-        // SAFETY: By the type invariant, there is necessarily a reference to the object. We cannot
-        // touch `refcount` after it's decremented to a non-zero value because another thread/CPU
-        // may concurrently decrement it to zero and free it. It is ok to have a raw pointer to
-        // freed/invalid memory as long as it is never dereferenced.
-        let refcount = unsafe { self.ptr.as_ref() }.refcount.get();
-
         // INVARIANT: If the refcount reaches zero, there are no other instances of `Arc`, and
         // this instance is being dropped, so the broken invariant is not observable.
-        // SAFETY: Also by the type invariant, we are allowed to decrement the refcount.
-        let is_zero = unsafe { bindings::refcount_dec_and_test(refcount) };
+        // SAFETY: By the type invariant, there is necessarily a reference to the object.
+        // NOTE: we cannot touch `refcount` after it's decremented to a non-zero value because
+        // another thread/CPU may concurrently decrement it to zero and free it. However it is okay
+        // to have a transient reference to decrement the refcount, see
+        // https://github.com/rust-lang/rust/issues/55005.
+        let is_zero = unsafe { self.ptr.as_ref().refcount.dec_and_test() };
         if is_zero {
             // The count reached zero, we must free the memory.
             //
@@ -649,8 +643,7 @@ pub fn new_uninit(flags: Flags) -> Result<UniqueArc<MaybeUninit<T>>, AllocError>
         // INVARIANT: The refcount is initialised to a non-zero value.
         let inner = Box::try_init::<AllocError>(
             try_init!(ArcInner {
-                // SAFETY: There are no safety requirements for this FFI call.
-                refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT(1) }),
+                refcount: Refcount::new(1),
                 data <- init::uninit::<T, AllocError>(),
             }? AllocError),
             flags,
-- 
2.44.1


