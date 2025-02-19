Return-Path: <linux-kernel+bounces-522384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77197A3C975
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22B0C170D72
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC90122F38C;
	Wed, 19 Feb 2025 20:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="mwWpr+Hb"
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021086.outbound.protection.outlook.com [52.101.100.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E547922CBF6;
	Wed, 19 Feb 2025 20:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739996247; cv=fail; b=khPJZ7p6TQS/FDy4Iz75MN/OUL6gQ73NadP4J6NwQES19dUIRgvwXBshrtOD5fTKm4wAtLa7WchnlTAq9+sNbVr6RJ8fZccC1ScJ2ezFnO2+w/kqNB+c31IV+50ArQKaOOsc1p3fR0StksXd7NdryiC+6IhMzPXyKk7flhfjHJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739996247; c=relaxed/simple;
	bh=Gkt+zhrxSn1MrnFhafCdvbyG7Nc7xrbQEupBogtPHQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lHp109vpmS5V0gyalS0UEJFJHC52/YPjDqlcvTeg28iq4H7ekVc2gwj20aofaQRtx5oqY75ohex0kgR5Jrybs3BBl8oRqZ4lW2JjD21NnXoUuQAhDOU5tTas69G65Uqo+gO9Gn3Cyw/9jUttQ+lZF7YvtMNqZ3y09s9eODdfzhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=mwWpr+Hb; arc=fail smtp.client-ip=52.101.100.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MMc61Ke759zKXeNdio8HgfaGUVlUPb521nG/4sGB+ZtuLyYJleeRkviSpRI+gOoMoABWlx7pglmlbJcBWNUYrm9GJCxWjiruqUZ1n9jb/gwJSjt4YkS5eAPT8rk+psC9Uu6wWGIPGvUrAc7bW0+gCNQ1v2aBM/um/gWJGitT7ZY4vABU5F+C+7kZl05i+adQ1ZGIbCNhZ3PAqN3j3UvVsVkmmmOv4Of7KhI3Cmj+h+I8UC/Q9/oBXOOuIVOQpMzJ4hcMOujxeOZeSSBmlujWnckJGSo7xBBAnTilWlIHqXWsZrHOGmxPqhWMNdb1+rBu5PJBSJ5EAaxhHGCQmA+azw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6VS7cv9WJnfApSfCAp4D9lnXs5HUDSUGvFwEufAego=;
 b=Nv4Ax3obQO5D5Pby9y04KtBUt9A1jkrw3pKpEXHQJ1qjf4a9Sm3NIt4pbl9zhuM8o9Immas4/R5UQnJ/kXRwp/F0zIuf4C7XM20OM4B+Xb6BkvK0xc/1lwLgk8gj3o0TRmr/kco/sxF2PBc5f4YUkL6o2CaDs72STb3WL4gK8nGuFGv0KmqUzQA4h1GyNwW0LbnYNQcbh4HdqmIIUOSAYcztBC5b+ojlcG7J+i2DvwMl+IopQXZB4ycNdKjm5cR2C7jykZ4vXlKHHQiVbk6xXh6gDhkiIwVO1PaDa/Gkn6A2+fbm3UFOobjtfGu1U7xw/p6awHCi37+dcHeCDK2iFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6VS7cv9WJnfApSfCAp4D9lnXs5HUDSUGvFwEufAego=;
 b=mwWpr+HbagGoEESVIRkLNUh2keWdexCBJIUGyc1WAHYV7gKRbhsvK6FTSHhb7LdZ7oyUfROggSCM/tsRhPpgwkTCOQOki/Za7GfwFVPYJr2gsRBfbrnV9TCikdOvAqPGK5NRqpxWnfn/BKJIMuZ0rzImuR4HKKhdVkqFIpZwrng=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO2P265MB2783.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:13d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 20:17:24 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%4]) with mapi id 15.20.8466.015; Wed, 19 Feb 2025
 20:17:24 +0000
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
	Danilo Krummrich <dakr@kernel.org>,
	Tamir Duberstein <tamird@gmail.com>,
	Wedson Almeida Filho <walmeida@microsoft.com>,
	Alex Mantel <alexmantel93@mailbox.org>
Cc: Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] rust: convert `Arc` to use `Refcount`
Date: Wed, 19 Feb 2025 20:15:31 +0000
Message-ID: <20250219201602.1898383-3-gary@garyguo.net>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250219201602.1898383-1-gary@garyguo.net>
References: <20250219201602.1898383-1-gary@garyguo.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0225.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::10) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO2P265MB2783:EE_
X-MS-Office365-Filtering-Correlation-Id: 6464ea83-0c2b-404e-3e0f-08dd51226c1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7OxVu5bfg0vbm3Hs3ROgTkbyHkIAQzQraxIMKAnhG0OYpxBd5Il8rBE5kw1D?=
 =?us-ascii?Q?2xps4vThfKLCcRG4KxXHaePNGgLprwAc3XxF7NMDlrhTsaB3lvJVOFrAxz/0?=
 =?us-ascii?Q?2MSVveqXa4ywNC2NZOKDWuq15EAEQ3xyV2V0dnE/LLDzJRRxUpqwQmkFmh9S?=
 =?us-ascii?Q?owZUAwbVZh07eZe4jTb8rJuLdSr2JHC+ozJ712P9UFTjbiGnN9/fgovxniy/?=
 =?us-ascii?Q?a6F+HoaZZTFLdJv4rHer6r5pfPwnACUjA1cMIrY6XXUTsQxMaudfLhxijKyM?=
 =?us-ascii?Q?Q5GZUWltHDwPma0RkZHMnT0Z2wm/Uk2cFgszXwVYPyxyot2H8FLE5WDb+D/H?=
 =?us-ascii?Q?1e5UugqhOMIeVkfTanbMLuZxkbpoRyQjsv8pOTjpGT0cXSmAyr0ROq2wFDyz?=
 =?us-ascii?Q?bV7x0UdqLLbH9+27ymyi+Df961xuuMMUBKlZI8/SseA+02eEArRbx7Ep4voH?=
 =?us-ascii?Q?Hv6RMlTiCweHy6wlE+RWCAAUNqldimv0JBeaISZujBUm/vfz9NOseq8w5pOH?=
 =?us-ascii?Q?I5u6RyWgEWApPh+jtv4eUSQpYnBkpr2rkzGDODSk569GZlSWboZ3fjaWCq4J?=
 =?us-ascii?Q?Anbx007RmQQCuGorovVF37TwClEzd78Q1qUuniVdUOeENz2BLiqTVAvV5sgk?=
 =?us-ascii?Q?5nQ4TcAJ5O6gja/VfrrIQq2QAgTWj2absXtDsfYObIdUfxoaHea0fO7sbQnY?=
 =?us-ascii?Q?R7yASj9ZshFX37cElFDuJkkYK3+u9V7N/xhI8VNxFyjaMWy/ts8D/dS1fIsG?=
 =?us-ascii?Q?miDRSYnyyBwiR9lZwQZyZIH4ogiYDaaQLyJONnR2NCCJPMqrm6bindcuujTo?=
 =?us-ascii?Q?XGxe/CctB2HjepSP2gN5sa1WurdIAtnQJi2uHGnEV6O8BpnKmCLR9RdyIShk?=
 =?us-ascii?Q?Qc4d9aMGSKzAmIuZpv9fP2PQ1y0UdKBfhT9pHppHLOPlRc2INWXFaf5fEURx?=
 =?us-ascii?Q?6lojyW8FV+B7VKTkMIkg0CNpEZcFQVbklxiP/AXJ/jeFpQiw7w0ZgWTtecp1?=
 =?us-ascii?Q?IuINLerCWOV3J5rA3S07ojHJ7OFrWdzEcGRwg4z+YWICQXdk72QfjAr5Cuou?=
 =?us-ascii?Q?VVpALzoMhPsBgvUlY952/GAeEdib68yYDCgAKvJM+NxvWpIQpKkeEUAXJwG5?=
 =?us-ascii?Q?RlzAcX64GIE2WBiKMK1VSw7N/PdMa0FQh2FdTkEeQ1SxDZDW187b2KJdkmUz?=
 =?us-ascii?Q?15zb5e4TPrQmBlhZ1keJAHB674BN8kIhK+vKYNoahOKTum/e8Qi7P82ZPXsw?=
 =?us-ascii?Q?kq1lmTEY9DDuaSMbI73gqLJZ6MX1geKvT7unWQko8V+cGrToOy5bIDCyiZTD?=
 =?us-ascii?Q?tYwkl1N5ouF28J1gTcpV/OH/zwnqw9vXM2n0278P11aYP6OiLIadsbmNcb4+?=
 =?us-ascii?Q?Y4I9fuOTKtMoskFxb+eDS9Bz18fVJ9wqCAwAfzUeTJBhF31xPq358Mye9eCt?=
 =?us-ascii?Q?4NOz6F5qTW8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sMjQARC4izXPxoAm/NFo00qr3XQFYd9cBoJ1tOSvTm7AYJXQ/MNc2clDmEUW?=
 =?us-ascii?Q?GZh0e/cfbbYRAreATiZdvN1DyQKwFUW5skXOcI8XpKxGrhO/r0OzCj0ZAuvb?=
 =?us-ascii?Q?BpXQHAp7h2fdZpRoGhP6P1lSzIR76Sxduri1uFSsCosbO4Q0VO7fUfjvkzjQ?=
 =?us-ascii?Q?XGW/pYyjzpVR3bf2zUtlQ0aYg5j5c17dxZlqtrU+3FpxNVF8KwGzzpLBVafj?=
 =?us-ascii?Q?U6asXxpYe1065ls/D+ky2cnYPsQ4Pe4Lsio+FfhYHhLk2ddUQdtplHNJz4O3?=
 =?us-ascii?Q?n1zxiG90vOxyD6ml3mdBU1JO3Kojui2sEBY+9qeAMHd/NEwBEZQjJUbnSNz9?=
 =?us-ascii?Q?DeHvjcRCdiKg91d2eUzfpWTOro9biEKcUypCQwPhcF4pelwQGRFZ82fWnLnS?=
 =?us-ascii?Q?f5ssseIwmt1K/ijcbNTwmCpo/8u68p9QCTm6RL3asfyoAiPckTs3GOxtjj8u?=
 =?us-ascii?Q?i36m7+T9s01BFdb7qOZP+oAA4Fe70/fP6hSZh92RTUDcpdz952TrFW0TSNER?=
 =?us-ascii?Q?fqSo0ha0nc2dL0/CLEyFZyrqwcniuEIHoOjEdCxtoRT78mqM+63dO17l+vmO?=
 =?us-ascii?Q?airID0m7clEQ3ILzr7j8i0DzisthOz3eNvViIn2BZzWVUgDiOEfIzcRxorjw?=
 =?us-ascii?Q?pprjBEp1sTRDA91kx4aKOS4/G1MupCEYzEDqi+jpElW6fXr+9SajGZ8UL9MJ?=
 =?us-ascii?Q?VPphCd/O1CuRDsV3SDL390Lck3pwFWwYRCgIgfjtgJYV8nsz5zuOBk1EXS8R?=
 =?us-ascii?Q?fTqAbyY3TmbjkcCrF5Sp+LmB8yN31HM3ammHjxbEtkoBHeIvt7dQgKb2XDL3?=
 =?us-ascii?Q?B9WFrKqtlVT+Q3dZrRBMhd2Atvo4SQVZ46hzR3oLXTqZ77+fhkaa4OLXnCyg?=
 =?us-ascii?Q?TeoCqZ8eLvSRM8/KnsuMtA2SLtRWavAN6dp5yHFA7VHCETJfC6tbZeIRqZkR?=
 =?us-ascii?Q?JHmeqIxWRy+Toq2i2s8GtxrGTksXj+1gnc+kyq+Ftb5PxHAxB0fD/yvkKMG8?=
 =?us-ascii?Q?u+oM4yfPbRyghq1HMBIkWjtkzGBCrh9iiAzFguJQEPUE8VikssdwQ/bWxchQ?=
 =?us-ascii?Q?AKnQ9iyD5MJWU8jMjhkaK9bLKKNkeuOsAg/gq0xJzE8yVD6m1D3bWlQ2SVc7?=
 =?us-ascii?Q?wmKznWzANpdwha5gk5sYxSl+5bpKoKXjd9qVe7sexnGVgCWzjoZerk0PC/IL?=
 =?us-ascii?Q?JSsFROmCYYS+dKaCu6Aui7BAHoqhEZMnf8SlPIlBz6ju605Bs669lEyZnsup?=
 =?us-ascii?Q?J+crpmHziO8Xox4NLMAySPzdvhM27WhfF3060DtPglMK9EHnLq/DlmgMR2fo?=
 =?us-ascii?Q?7RYtmgLT0QNOQToBXITHyglnfUvIQSfK+Hj/SIk15qXiLUc/kR7bnNcTZZrs?=
 =?us-ascii?Q?/G1/j0C7JufzWFiBT76YRtBCxzCC4GdqIxQ8r4Y9fTvUIO4UfvvkBW7jX8fY?=
 =?us-ascii?Q?YWKLe+kGn82tfRpF1TVcguKjBx4lAGsbEKzikganqh2mEoOZ0DXHDje28RzZ?=
 =?us-ascii?Q?PTZDa7n7VEJO3HcRcOGFB4uXA2Uz5do1RF2ied3GMUjzE3BEHUG2+ZDM2YCl?=
 =?us-ascii?Q?NGOmtFqnyGcA2TbQ1rEzNPsKi3P6ZbXCwAyU+sJbnTmFe2JTCPJtaLZbXPey?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6464ea83-0c2b-404e-3e0f-08dd51226c1a
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 20:17:24.1932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tpmJycV16M4iskmogcwpRQivTO1/s4wMRNjIi40QTjtjQxifWc2VjwFv03rgCqBcqaXrkqIr+WHwqfpPj8wS/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB2783

With `Refcount` type created, `Arc` can use `Refcount` instead of
calling into FFI directly.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/sync/arc.rs | 65 +++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 39 deletions(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 3cefda7a4372..1f5fbc6b3742 100644
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
     alloc::{AllocError, Flags, KBox},
-    bindings,
     init::{self, InPlaceInit, Init, PinInit},
+    sync::Refcount,
     try_init,
-    types::{ForeignOwnable, Opaque},
+    types::ForeignOwnable,
 };
 use core::{
     alloc::Layout,
@@ -143,7 +143,7 @@ pub struct Arc<T: ?Sized> {
 #[pin_data]
 #[repr(C)]
 struct ArcInner<T: ?Sized> {
-    refcount: Opaque<bindings::refcount_t>,
+    refcount: Refcount,
     data: T,
 }
 
@@ -155,7 +155,7 @@ impl<T: ?Sized> ArcInner<T> {
     /// `ptr` must have been returned by a previous call to [`Arc::into_raw`], and the `Arc` must
     /// not yet have been destroyed.
     unsafe fn container_of(ptr: *const T) -> NonNull<ArcInner<T>> {
-        let refcount_layout = Layout::new::<bindings::refcount_t>();
+        let refcount_layout = Layout::new::<Refcount>();
         // SAFETY: The caller guarantees that the pointer is valid.
         let val_layout = Layout::for_value(unsafe { &*ptr });
         // SAFETY: We're computing the layout of a real struct that existed when compiling this
@@ -207,8 +207,7 @@ impl<T> Arc<T> {
     pub fn new(contents: T, flags: Flags) -> Result<Self, AllocError> {
         // INVARIANT: The refcount is initialised to a non-zero value.
         let value = ArcInner {
-            // SAFETY: There are no safety requirements for this FFI call.
-            refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT(1) }),
+            refcount: Refcount::new(1),
             data: contents,
         };
 
@@ -290,7 +289,7 @@ pub fn ptr_eq(this: &Self, other: &Self) -> bool {
     /// use kernel::sync::{Arc, UniqueArc};
     ///
     /// let arc = Arc::new(42, GFP_KERNEL)?;
-    /// let unique_arc = arc.into_unique_or_drop();
+    /// let unique_arc = Arc::into_unique_or_drop(arc);
     ///
     /// // The above conversion should succeed since refcount of `arc` is 1.
     /// assert!(unique_arc.is_some());
@@ -306,35 +305,30 @@ pub fn ptr_eq(this: &Self, other: &Self) -> bool {
     /// let arc = Arc::new(42, GFP_KERNEL)?;
     /// let another = arc.clone();
     ///
-    /// let unique_arc = arc.into_unique_or_drop();
+    /// let unique_arc = Arc::into_unique_or_drop(arc);
     ///
     /// // The above conversion should fail since refcount of `arc` is >1.
     /// assert!(unique_arc.is_none());
     ///
     /// # Ok::<(), Error>(())
     /// ```
-    pub fn into_unique_or_drop(self) -> Option<Pin<UniqueArc<T>>> {
+    pub fn into_unique_or_drop(this: Self) -> Option<Pin<UniqueArc<T>>> {
         // We will manually manage the refcount in this method, so we disable the destructor.
-        let me = ManuallyDrop::new(self);
+        let this = ManuallyDrop::new(this);
         // SAFETY: We own a refcount, so the pointer is still valid.
-        let refcount = unsafe { me.ptr.as_ref() }.refcount.get();
+        let refcount = unsafe { &this.ptr.as_ref().refcount };
 
         // If the refcount reaches a non-zero value, then we have destroyed this `Arc` and will
         // return without further touching the `Arc`. If the refcount reaches zero, then there are
         // no other arcs, and we can create a `UniqueArc`.
-        //
-        // SAFETY: We own a refcount, so the pointer is not dangling.
-        let is_zero = unsafe { bindings::refcount_dec_and_test(refcount) };
-        if is_zero {
-            // SAFETY: We have exclusive access to the arc, so we can perform unsynchronized
-            // accesses to the refcount.
-            unsafe { core::ptr::write(refcount, bindings::REFCOUNT_INIT(1)) };
+        if refcount.dec_and_test() {
+            refcount.set(1);
 
-            // INVARIANT: We own the only refcount to this arc, so we may create a `UniqueArc`. We
-            // must pin the `UniqueArc` because the values was previously in an `Arc`, and they pin
-            // their values.
+            // INVARIANT: If the refcount failed to decrement because it is 1, then we have the
+            // exclusive ownership, so we may create a `UniqueArc`. We must pin the `UniqueArc`
+            // because the values was previously in an `Arc`, and they pin their values.
             Some(Pin::from(UniqueArc {
-                inner: ManuallyDrop::into_inner(me),
+                inner: ManuallyDrop::into_inner(this),
             }))
         } else {
             None
@@ -396,14 +390,10 @@ fn as_ref(&self) -> &T {
 
 impl<T: ?Sized> Clone for Arc<T> {
     fn clone(&self) -> Self {
-        // SAFETY: By the type invariant, there is necessarily a reference to the object, so it is
-        // safe to dereference it.
-        let refcount = unsafe { self.ptr.as_ref() }.refcount.get();
-
-        // INVARIANT: C `refcount_inc` saturates the refcount, so it cannot overflow to zero.
+        // INVARIANT: `Refcount` saturates the refcount, so it cannot overflow to zero.
         // SAFETY: By the type invariant, there is necessarily a reference to the object, so it is
         // safe to increment the refcount.
-        unsafe { bindings::refcount_inc(refcount) };
+        unsafe { self.ptr.as_ref().refcount.inc() };
 
         // SAFETY: We just incremented the refcount. This increment is now owned by the new `Arc`.
         unsafe { Self::from_inner(self.ptr) }
@@ -412,16 +402,14 @@ fn clone(&self) -> Self {
 
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
@@ -673,8 +661,7 @@ pub fn new_uninit(flags: Flags) -> Result<UniqueArc<MaybeUninit<T>>, AllocError>
         // INVARIANT: The refcount is initialised to a non-zero value.
         let inner = KBox::try_init::<AllocError>(
             try_init!(ArcInner {
-                // SAFETY: There are no safety requirements for this FFI call.
-                refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT(1) }),
+                refcount: Refcount::new(1),
                 data <- init::uninit::<T, AllocError>(),
             }? AllocError),
             flags,
-- 
2.47.2


