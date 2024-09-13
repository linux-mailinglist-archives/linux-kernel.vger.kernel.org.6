Return-Path: <linux-kernel+bounces-328904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27763978AA5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 23:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C0281C230A3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 21:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF0716B385;
	Fri, 13 Sep 2024 21:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="kKiSTl9U"
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021083.outbound.protection.outlook.com [52.101.100.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55514155389;
	Fri, 13 Sep 2024 21:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726263205; cv=fail; b=f+6ZUxkwS3WRnP5bigb1WKdFdtlYy0XYpmCOUwZSQvsyBph65MKCSSzOwrTPm/AekP+O6JqNfjjHwhdjBLS7sY/RoUMYeY2f7gt4sWFghRhNRB0V45AUC0k/kcALwDuJlXeTQtoGnXjeEK/tspeli4Qybw1ZELTWXFafJFqfGOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726263205; c=relaxed/simple;
	bh=6TdmyHHp7u2mExrWD6H0ngh9WBg3ahorWEqUV98L8+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HIhkp9QPTT+VjdEgUO6q1861QjPIRdETwBJKhbwCDviGdFsB/k8yZvyTxydENpk3I21xCEMOZOsluoAzK5A8AWSpIoJozfB/Lz3/aBUA2+BvfyDE/TK2APvMhKpt84Z0MbABxnemnaKUI9h9z1TnGN6ebVA3SfaaV8xufYmu9pU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=kKiSTl9U; arc=fail smtp.client-ip=52.101.100.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eEhDOOFQ1fWyKcPwq2WJr/94vy2nbRm4xoeRuYyxnJpCJopmfDQRKe4n5U2HTlrRTGW8VCibB883mOfxemz/Gu70NyaLSzg8X0seQaIyEmyYgZR/PIiOxeS+EVFYLTeR9yHdKE/NdZQOE6+/KxRt/TU5XRWToyC5rIUOit0nSRIMQHh21lum+tQfMZkazcZrluqa0YzphtY9JLLYOKDpfOtYIr0q6LGueK82VFCZiV2CezuichutkQcSVZnOMxekQGpS7FXabdL+NQ8mB5dyEWXTpYadKjf8MW9XR06msZimKnQSCea0c9sQzsBeZAzronFiitn6lOVcImYMUJYNaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZDJkCxnW4j6s3NWmgCWCa9AnpaggAgjms7EsZyNn08=;
 b=GCKNA3h4DQut2l2fSt8jVOtiAiK6vEG4VU2qtkYM1s8GH8n0NlSz5f5OzDfygKzfov/7zgk8VUQBx+lS8YpwniTOiw2RfdzgPwr5XtxASkS4XCW5k+HWkm/36BXItq1xix1QlB6z6zo2H4BxKxYOVg8xQZ/Kk/82yWbxmDDjS9UPZqd+VHzoj7R23hMHxkuQXnAsMlGkejgbpPHbrGzjOmkQ2uBOdZRYB/2NygkyHUq5DzKGSEtJO1abZTwLDMiDQdYmuJbjlsN2mpOLpvB6RF85G7Q1igG9OV65Qd6zfgn5y3nQKIU5BBm+36k/sNqdLXjMAoi3qjZ4FMjKX7n5qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZDJkCxnW4j6s3NWmgCWCa9AnpaggAgjms7EsZyNn08=;
 b=kKiSTl9Udbc3Yn1qojGfE0FdqizgNDtkWlx3trDOuQ+sTVcyVh7K+ZPCrq2qbhYrA7fzoIeN48oUpN7XzXmO4TG6I7KdzjVikPHSxv9H0NOEkmSBHTcVZKwXK/czfgmy1mTYRaS4epWUaqDTog9fvEiGrmg0zbYzjciM9Yl7exw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO2P265MB3594.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:1a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.20; Fri, 13 Sep
 2024 21:33:20 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%4]) with mapi id 15.20.7962.018; Fri, 13 Sep 2024
 21:33:20 +0000
From: Gary Guo <gary@garyguo.net>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Danilo Krummrich <dakr@redhat.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Finn Behrens <me@kloenk.dev>,
	Valentin Obst <kernel@valentinobst.de>
Cc: Wedson Almeida Filho <walmeida@microsoft.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] rust: map `long` to `isize` and `char` to `u8`
Date: Fri, 13 Sep 2024 22:29:24 +0100
Message-ID: <20240913213041.395655-5-gary@garyguo.net>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240913213041.395655-1-gary@garyguo.net>
References: <20240913213041.395655-1-gary@garyguo.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0136.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::28) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO2P265MB3594:EE_
X-MS-Office365-Filtering-Correlation-Id: edac7d29-5a91-42de-c547-08dcd43bafdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zy1I59+t8k+NeDXcvRRPSg25O28I57H1RxIAUkIp//SjLbBDxWcyWgw3uiXL?=
 =?us-ascii?Q?gjEhIVpd2lNfKEDrYYM8BhbBvWGe/sc+FhCztZBnu6aUWcXEBytpqj/no5Po?=
 =?us-ascii?Q?PtaeCGw8mCC3MkVWIfU40q9VcrAw/ssqFRbqtr/lTZi9HnJdz1sRGvbwpcXo?=
 =?us-ascii?Q?cKmi4lKlj4XkhywtAbiLCl7FnFOdMPXBWWqlcZW22glsNIk4KtWLpg0qpPSG?=
 =?us-ascii?Q?V4kw3eh3ZnoyPOizNC/+7qbEXOAKceM8ZyYW6hVAQOqC++14PZ6CqsVLcS+G?=
 =?us-ascii?Q?P+Q3upb17i+VBveJzThvsAGpWDk7/2Sf7WgV7AUXlyM57rPjx6N1tICUaRWN?=
 =?us-ascii?Q?H7tP4JA+YUCD6UJ6dqKnhfd+3AA7x1XW4bJVTjp2TirpL+50FeEYxkZOLcOp?=
 =?us-ascii?Q?nMZvgHjALUH0kkX8C6H/ghtst1VRTrwXvzIl/RbxQCBp8PFyizWdxHhPmyZB?=
 =?us-ascii?Q?C5u9GGJ8m2lNCZT5z1uOimm98Kmh1DnvG+S1H7n3uK1O97p6OfS85tFq+1m3?=
 =?us-ascii?Q?UXnGZIeKZh+0TipCuOylJ7AQLd/9HoOviZuggaAwoG7yGRfxH6SbDESRphgp?=
 =?us-ascii?Q?IviG4TcyxIWJevOup5MmiP53qG/lvhdkSdQtB7noTmwL7phxFPi54hIl1nYh?=
 =?us-ascii?Q?YWykKiKsvarYVJE+BoBmuXCbfP7JqJLL0Tb314I1P3o4KQlONFliGeW+XTti?=
 =?us-ascii?Q?nFfiBYIy5VwW8MJuy6ZiZeVF5MZNTiM2BRru4/VZcnwtKgLdWg/xhKND33p9?=
 =?us-ascii?Q?el9eRoJIT6/nYi9JSfsUcuCyQ//7CC8zmI+6qcOy8paF3XsPOPXVQif49sU/?=
 =?us-ascii?Q?skir+WW1TZyLQI9zU8HSDQpF2kRyMf9e2tAw8mUAMWXiQxVc1qIABiY0fAOj?=
 =?us-ascii?Q?LIoPHje1cR9LUTVy8jd9vDQrU+fFYS9bCIbRcHETmhmEhIgK0o+0T4BCUmum?=
 =?us-ascii?Q?6J2uJzfasBu6tAjWaEsngUEOWTbnzftSyScvsk48has4UiLUm9uAwVo90fku?=
 =?us-ascii?Q?8WjpEfrpZLceIhvrKNkfKrS9Mz0yPwoiZhAurZCQ1PiP+Iq6LA2N91OuZpMU?=
 =?us-ascii?Q?/jRQrpQC3fN2TKdZPRtI5lb3FpK1eGw2icBJUxiwf4d81WWGRxKbKsGe9Abd?=
 =?us-ascii?Q?1RWZ+c4B2aQyj6moWkHmgyspsRFZTI4DmsqoLSw/hf/wg3Y2m3oNIGHMrSCF?=
 =?us-ascii?Q?MxQmJ6AuRZCmMQmRq932xU6JPii6PF6aGqh/M9BVYF/IyDyY8icby5HC/idb?=
 =?us-ascii?Q?TblBLWHGfQc1cO5O48F8etAuMkQLLRNts+WciHwAu5fMB6oKtche7B9iTs8H?=
 =?us-ascii?Q?SHKQILPCuTLxNtY97ltggBWek8NJRG+ps5btncj3LW/RPGv/5UQbTH0ApjsW?=
 =?us-ascii?Q?Vfttm2eRO5tfy104x3QvitvhXlZT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?poesxuRvrhd/jZfrgGT1sqKMLQDypEZbPmcMbzBowVKLysf1cDViaZwj+L4J?=
 =?us-ascii?Q?CFo+1/sccd2a+rE2tIqzxqJn0K2VF1YGxBagocprZ36xY//2nY/x0yuQnC6b?=
 =?us-ascii?Q?0oeJT1T+R2pILqGQ8EpMyPfhSwER+qdiDAR7qZrOVQhgLcuJ0IVP0fykVCF9?=
 =?us-ascii?Q?pp53oTS33rd8ofWrga4Kx6JjhyvR0h+7SV1C09xQe55WnJRZuI0FJERuIMbH?=
 =?us-ascii?Q?Lg4mL4w8thOQbHfPxkGI6qN1gLSkxJ971oQ+xN6C+cU6Gs6QCQTl+huyEYHh?=
 =?us-ascii?Q?F7X5PjXZi2s801oGJ4MJU0RMdRKww0heGL9PP73RNhieOGkAIy5luv/R5S5t?=
 =?us-ascii?Q?X962te2OMuBIgNImPDofIAcrdiadiZ++LtqJhtwjvfienWrJpIU0ANJgpZYK?=
 =?us-ascii?Q?pnz8icbzpSpB5vURSDCmZAXIIQ6gOpF7EMQty1lDd+zkTMM68HtKPxGazv9O?=
 =?us-ascii?Q?ox3VBSYusyrcw12jEtlAUK0rN12ff7M8LF0/tZ2KIFNxX1FFgTRD/xE7sj8I?=
 =?us-ascii?Q?hq40nCM4ODSSwrpQcEfvh1CXKeImOobmj3oPlwK8cKYMH24KgDN4u8kw1OJV?=
 =?us-ascii?Q?FH+3O6Jyl08NkDhOQXjxOtZtu5/GZn4oyg+EUmZfWWS0QqeV7FLiDg/MnygF?=
 =?us-ascii?Q?QZiG7Q/iuq7edWTgLd99enNwsYAh9wIJRis/EsWs178W/4he5drURlIRwWk7?=
 =?us-ascii?Q?Lh4B58fMA7LSJhpSTacMojeuKdX2sMjsDBi2FWledyebENSRRFosxWKMvPX7?=
 =?us-ascii?Q?3GbINipA0GjWDrDsaF/VnGUmp/k37QavMnzCbGP2Xsx6FDf+B2Uv3a501ZG9?=
 =?us-ascii?Q?4I9JyPXWQIRV8BpKY+3UsMxrxznVEIMC5QtRmoWbR0PAncWeiMrN5GGKgHF0?=
 =?us-ascii?Q?y3tuhyPbdXfLE1o1pRKQFVzp0k8EReFctCz4rI/2dcCNKK5qaVk0mU2gEZom?=
 =?us-ascii?Q?Vtq+hj47vXdkX26SBUrnMMiKQ6/YPLiY3lhAMGQFO9MBY94PSlL+xE/jbGw1?=
 =?us-ascii?Q?lhFPYxjfPgxyqdD+0Y6jePVKta4+a8u/3jRSdAxpWLC2uvYhekOazGt/qXaS?=
 =?us-ascii?Q?3vPpoAcfgxWibu6EnTOPFO36oVBZVYrKj+n/cMRmvLdl7Boiz9Dx58/Ig1Oc?=
 =?us-ascii?Q?pqhMHaBuEFuv4WqREQOsRLcS7VaXyn8E2/di/242S+q0EENSE88TYboRrQq0?=
 =?us-ascii?Q?0l90w9qsjroJnF0CyAEnZCCLrQud3OP6KFqhv9oblcgl2Rxrz2pK0IdZPMUR?=
 =?us-ascii?Q?BiLEoT4q706pAcofRhXDyJNRAqh8AJbPvkkt3B9HRwV+PPcD1HWmeUeZl4ZF?=
 =?us-ascii?Q?KXhcTBoo/EihfKSjZI+2yS9hpRcD9WoS6V8w9JsonQhYKXJgjVFDJsU9hH/K?=
 =?us-ascii?Q?UgDiuvqdW6Ircze09171aRzlqTTh9eSznmlcYSxNAZDgCnSounD1wTKzf+tp?=
 =?us-ascii?Q?XRMIU4WCbYINafxGmOcr4Mti0I8OWz4sGdZITLUOSVingWj87rtD5GC6CMjP?=
 =?us-ascii?Q?LiRlOAPsdPsgzuhtcafgZkFrIRXWQ1jHaaKHQab7ny2AUknywjZuicSNW53k?=
 =?us-ascii?Q?qWdPS9Zb+yshxntiShlWXdGOVMXtycSTh6F56fvTvKZuWoUDLO6UTgH3hFzD?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: edac7d29-5a91-42de-c547-08dcd43bafdd
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 21:33:19.9855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K6Md6MGNWWXclfojo+3SRTYpaYjQ2AbC/MznLxu4CreNo/FyhKjACpmmcqPJwM8x2/V/fV1JZbXgYTdrlBdPaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3594

The following FFI types are replaced compared to `core::ffi`:

1. `char` type is now always mapped to `u8`, since kernel uses
   `-funsigned-char` on the C code. `core::ffi` maps it to platform
   default ABI, which can be either signed or unsigned.

2. `long` is now always mapped to `isize`. It's very common in the
   kernel to use `long` to represent a pointer-sized integer, and in
   fact `intptr_t` is a typedef of `long` in the kernel. Enforce this
   mapping rather than mapping to `i32/i64` depending on platform can
   save us a lot of unnecessary casts.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/ffi.rs             | 37 ++++++++++++++++++++++++++++++++++++-
 rust/kernel/error.rs    |  5 +----
 rust/kernel/firmware.rs |  2 +-
 3 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/rust/ffi.rs b/rust/ffi.rs
index 1894a511ee171..814d10106b5a8 100644
--- a/rust/ffi.rs
+++ b/rust/ffi.rs
@@ -10,4 +10,39 @@
 
 #![no_std]
 
-pub use core::ffi::*;
+macro_rules! alias {
+    ($($name:ident = $ty:ty;)*) => {$(
+        #[allow(non_camel_case_types, missing_docs)]
+        pub type $name = $ty;
+
+        // Check size compatibility with libcore.
+        const _: () = assert!(
+            core::mem::size_of::<$name>() == core::mem::size_of::<core::ffi::$name>()
+        );
+    )*}
+}
+
+alias! {
+    // `core::ffi::c_char` is either i8/u8 depending on architecture. In kernel, we use
+    // `-funsigned-char` so it's always mapped to u8.
+    c_char = u8;
+
+    c_schar = i8;
+    c_uchar = u8;
+
+    c_short = i16;
+    c_ushort = u16;
+
+    c_int = i32;
+    c_uint = u32;
+
+    // In kernel, `intptr_t` is defined to be `long` in all platforms, so we can map the type to
+    // `isize`.
+    c_long = isize;
+    c_ulong = usize;
+
+    c_longlong = i64;
+    c_ulonglong = u64;
+}
+
+pub use core::ffi::c_void;
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 1090a13c2bd17..b9ad9ff25cddb 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -135,11 +135,8 @@ pub(crate) fn to_blk_status(self) -> bindings::blk_status_t {
     /// Returns the error encoded as a pointer.
     #[allow(dead_code)]
     pub(crate) fn to_ptr<T>(self) -> *mut T {
-        #[cfg_attr(target_pointer_width = "32", allow(clippy::useless_conversion))]
         // SAFETY: `self.0` is a valid error due to its invariant.
-        unsafe {
-            bindings::ERR_PTR(self.0.into()) as *mut _
-        }
+        unsafe { bindings::ERR_PTR(self.0 as _) as *mut _ }
     }
 
     /// Returns a string representing the error, if one exists.
diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
index dee5b4b18aec4..6f77945016579 100644
--- a/rust/kernel/firmware.rs
+++ b/rust/kernel/firmware.rs
@@ -12,7 +12,7 @@
 /// One of the following: `bindings::request_firmware`, `bindings::firmware_request_nowarn`,
 /// `bindings::firmware_request_platform`, `bindings::request_firmware_direct`.
 struct FwFunc(
-    unsafe extern "C" fn(*mut *const bindings::firmware, *const i8, *mut bindings::device) -> i32,
+    unsafe extern "C" fn(*mut *const bindings::firmware, *const u8, *mut bindings::device) -> i32,
 );
 
 impl FwFunc {
-- 
2.44.1


