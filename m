Return-Path: <linux-kernel+bounces-328901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0681C978A9E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 23:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12999B246DE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 21:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8901A14F9EE;
	Fri, 13 Sep 2024 21:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="Tts2sw8c"
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020115.outbound.protection.outlook.com [52.101.196.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383092BB13;
	Fri, 13 Sep 2024 21:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726263154; cv=fail; b=uhu2RK9IVji9ZPU3r+gagqu89vPK4hXp8BtUU1/RiCcE7kJXUvjXWKdOXO7DUHjFHzXtKBVXMLm4TI1QkcuDy061rT0cL+PRv7Or/ALEFXAcV6WRRRoMMje02dZKe+8hXuxx0f8+n5uz5XQckuafi2x0vb7pxi/aRUTFkGHHk10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726263154; c=relaxed/simple;
	bh=uek1ZI6pIhmKUJPiCSyQAoR8XPuWUxf/XM3sdjGd828=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S2YgnGbaN2eGFqUkx8HniVGukbm2iXCE7rf5HxQWyOeo/tT6M9dcwHLHZrx3lDNjsNX4QCwbntx/pm8GHcpFpsa/afWHkzP0qCuA6RqHUrJD6pfUoNEtNzgs5K/jqYZsJOkUQY98ymb8TsKQ1oa3KPRXZe6QkdY1+n4ouxFfwlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Tts2sw8c; arc=fail smtp.client-ip=52.101.196.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FYlHZ1HPULfVCHZ0RHav/VfBf0hPqHf4Y2DiS0NAq0U73+/Ge4smJOcUBDfocYSJw8UFjRAvmkypXesB6En7sGECH1hxGdKkplEJeSm4bpAw5H0rXD+akkdGlCbF3RAbJZrbt1uX5OXqiMdOyesx8bAUfUt3PYkf5ryHLWL1GpK9ilWOdouMKpKf0LexuyP2QGVyIOtgulJO4lGBcowGl993IwjrFxOhK7hx0dx07JNoNB7QqW3sgxhiOlOQGnDLJTvvgHLtbUXOCF40lX+h6jzLkU8f1hXrp7ExJiz9kRpIUus5N1RSVxAz/KENyD8HQr4I/KSpVCPemQf06qXBoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9sT8eLnRPD3R09zIds6avWShMUwpd6aAoXNCTSLiWc=;
 b=OY20IMDDHYj7DtBpT9RGPsDMIvZL8kNSswkNs0BVtxMf91K00J15l6PloVho8qfQDRNGFoFlqwf78ynGc8wGsz937q51Zs9X1nMBomNmtyvQcew0xmIdMMCD5TZuxNzn2FsmJi25Fd3RevhOV4ZbD8R+AEEb2Ufz36ZVppunT/kLDilzXvVjyXlkqrVPDncEp6EZJjM/v+n1RgTM03l+w7grgqg8I01lF8Yrn0JRIC25Mdswu3n5AzKbB8HmkESy3PKxPTS2uG6QqoTllCqyKMRrPOY3kO4BKs4TgudUMDA6TFWLK7IK9c/Qn1bSXE+gKQvrBd1zBGS0m2s88igisg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9sT8eLnRPD3R09zIds6avWShMUwpd6aAoXNCTSLiWc=;
 b=Tts2sw8cHK8g5t+uJ16RVcn/tZ0dzkK+QIc+7pXgBezd/rWLQeFBPw4BMdq8OCVlNXvI3GGbhJ5w3I+my1Ixb1kBfun1qHVFQau9h4w0XJ2mcf7+LxUf9bf0y8IqjKEP/FttIHI1WcsqTTMfXN6dPgP97kItFvio6+/tX9Zt0S4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO2P265MB3594.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:1a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.20; Fri, 13 Sep
 2024 21:32:28 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%4]) with mapi id 15.20.7962.018; Fri, 13 Sep 2024
 21:32:28 +0000
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
	Finn Behrens <me@kloenk.dev>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] rust: map `__kernel_size_t` and friends also to usize/isize
Date: Fri, 13 Sep 2024 22:29:22 +0100
Message-ID: <20240913213041.395655-3-gary@garyguo.net>
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
X-MS-Office365-Filtering-Correlation-Id: aac52b7e-8ff3-4d11-097e-08dcd43b9150
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aE3n7UxNwvM3o1TQZfxof5IEEAR+iMJAZshLMIFNvEXN31rI+6Vk5EzijbqS?=
 =?us-ascii?Q?JUElTwDU3diVJjqcsr+YThrmqIPz6lV1dnWYMDzLbehGBO1IvBq04nhfrqDd?=
 =?us-ascii?Q?Ugu5huEccN+TK1wS/iUS+H2dwtWPfl/G+E4ap89EGBN45n8S/tvOlJQ5WWCE?=
 =?us-ascii?Q?EBlRFsaCNPu++KbKAPrUxA+XAwc+bRjv6SRr2T1LMBBTY7Y11PcNpS6igoMR?=
 =?us-ascii?Q?5kpjgi4xQVxybFiphSQoyeAO5TWJ893G9S/8knL2tTCo6XDduXeuZ4d0pjaL?=
 =?us-ascii?Q?8F95ipLht3bHlxEEd+H3S2l+m4dS8yZ/nsZjHrNoG1RT6Cjufid49aZvB6GE?=
 =?us-ascii?Q?0vgGPvVqgQGbAmzDMIm718068Am5siZRsgscpbWRtOocbCnToDV7Ttke972q?=
 =?us-ascii?Q?ll83tOODFRpkt8jVzgKfNzyd9tgEiAaUj6OArfBfHf9pKCehFuqU+QvaT8Kz?=
 =?us-ascii?Q?EV8zXPLya8HG7hZqazl/RduWRb7kQusCovr4nsvRFqFzqXDgFP6JFswZ98Pk?=
 =?us-ascii?Q?3Y4hIJc54m2d7MlsuAQUpto08NSv1I1YCiEZEmmAdQsdHgVI1jkfsxkeK1YN?=
 =?us-ascii?Q?jMyyWupG4C4FBXUqdgkwKSsKSKbNeaky6in6u1Z+fvNx/IfA0f66/YdNndZM?=
 =?us-ascii?Q?qD5tcWBHFUaQ41yuU1IVULjwg35cXJjGQfkWUz3DkbWsksveLGK+c16ceBu1?=
 =?us-ascii?Q?8mwEZEDmua93R1mWaULHuEZ5LTx7wMoWh52OU2OixcNi+6JcCGmJH7P1RqQe?=
 =?us-ascii?Q?fsyIBD+cMaxn0S81M4R7LTx1Cnx4goRbX/ykM2+OxTT/UDu1LaWq73scrt/o?=
 =?us-ascii?Q?r1zoqKniBzK/y3vp8QQLCPmINFFKdu2nW1sTdBOblSMC38mMd90bqRIpNt0C?=
 =?us-ascii?Q?iEjm/vg9BKfJ2ciZcSjZsqE1rd5fqHwPkkFOXWTv7ee5haJq48RF4nHNWkut?=
 =?us-ascii?Q?sbCjKgZezKkYW2x/BJa79Ouzwc6xvZdOL9ttSGdUpUdpKeDqxEDy/rIq7K0M?=
 =?us-ascii?Q?nTxRAl4ZlecIntwUBHN9D/cPgVJ8U10hWkpJCfImQdLbskMQpW5kosbujPFf?=
 =?us-ascii?Q?qxD4ZJzCE/GvY9gpJYvkXQznnozYmCapuXaUb3E25QiAl1+eHQ87cjLnHU1d?=
 =?us-ascii?Q?56wmdfJpG9+Si0Rrjo97yciq9NDf1ZSlloYGln4qQvymjU9/JZ/2KAdJzDup?=
 =?us-ascii?Q?UbZE+s7Cq1zcOpCLfKJAsG8cXXDrklbmwVLsx9lSkv1Wwi77g1w8ZjcP1cCm?=
 =?us-ascii?Q?LohfZHznpIcQxn+X5tI4nVCXktmgbtteD5USSb9VHqCdxWdd3V/siL3kj3Am?=
 =?us-ascii?Q?xWWuLZN57MPz75Nz4llieQyLCkVXzbINkV9E9ukltiEoz53Xlc/+AvEOPyc8?=
 =?us-ascii?Q?UX/dGxWhRbbvWEzIrU1QivDdggjD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Atwli1D8ieEZj5wcisMStYMnzHXe3FiPxGE/jY4iCctdnZS89kR7+pFGLoEr?=
 =?us-ascii?Q?SA0rQuK2fwv94FEHUZlh7WipQqxxeXc+46z3pvTlZa4IoxPuVEeJJJOQ2yga?=
 =?us-ascii?Q?1WEPeoT3utZxHpLgiXmrNQYV71kAijIIWCRkCBSD0OPujtUTyDcz2nlB/j0j?=
 =?us-ascii?Q?QvVcaOzI1WijgMb2yMm0TwTpkev/x0AlDnpS8KvuQNJa3ulZMhUL9E6nRTqP?=
 =?us-ascii?Q?0046ww9B1mg1Tw0hlhfb3NuWBKTHTL2C/u7TvbELIVeSvggr4nFihBU2q59q?=
 =?us-ascii?Q?lhyFBzxaAQALra5SxozPoXuF/pSg76IPyC6vFnNvt9jvdBzE2G7mmK7s+NxE?=
 =?us-ascii?Q?3sr6LACk0J608ZKkhmVceQL3ZR9M2cWWUpgx99RFITCBztKYEquv0dkH9X6y?=
 =?us-ascii?Q?4ShK3UIEU5CpTVGc+RCwHIB70G6Pj+1QOuOB937x2oQbLl5NjWt2xMFPtrsI?=
 =?us-ascii?Q?oAJbhzhLoZzKcxFdAxR9ayTr5s0cl9Cpwpuulq2bicqC81C+8sp47x3CNp6j?=
 =?us-ascii?Q?C5cMD5XzvPHEHxl/VZScPs+jTek1T3ppDrsduvMFuYxVshxjtE7iTlyqKPrP?=
 =?us-ascii?Q?METVT6+BZC05AO8ab+6wEENHIDWdMTFJI6iI3bqgsBuSgrsDgG0a4ZlYyg6D?=
 =?us-ascii?Q?mBorEEYQk9JcIufeEgVrk0sNXm1jgyNYRBpsNhww9RklkWoxQ71rT743kXVt?=
 =?us-ascii?Q?7EUlsCbxkm5j/lKpgNSrfnEIexYoVjmQBk5m6VaPxMmwpKHXBrIdF/g5CwyY?=
 =?us-ascii?Q?RHSYkUZNrmq7pgsbSlcWH6PRTnb01PAcJ+OeIkACs36bE4gn/ZhXOQNEspB2?=
 =?us-ascii?Q?5rpGbxpEj1IcAHJeUSvCCqJT9iSCz/Tio2tIeuf549HXC+9GvibTgzzYm0pm?=
 =?us-ascii?Q?4mmXAsj4Ysv2Nq+6dol9VSCB+jGSRx5Fwfob+B85yjs3ppGZWYajlNrxCNHF?=
 =?us-ascii?Q?OLiQCeRJA9fopJotRsQkp3ZMHHI2de7hHnleAHyqA/WvOcpTvdS60Km4mM98?=
 =?us-ascii?Q?GzCSDZrqTpTDt56c7aLldjTIP33ukmUoZPzMV11qn8nos9c25SgpNFWCRH9r?=
 =?us-ascii?Q?GXOMiuTa9UUTzY2x6UhTzsulPg7SDnNn8ebYsQd41ALztGRg1J4BgTJeVDzy?=
 =?us-ascii?Q?P2GOA4+fXUYFJyHtXXZYooV+SzALdm4bV2idFvFhuasri/6s22Duw/q0jLIt?=
 =?us-ascii?Q?tq6ucz69D7fXCXAfPAqoQ+FLdNHWHrqeFjkeX+glnTf3uBEbe0Euaf1mNzA4?=
 =?us-ascii?Q?re0vk8SRrsjXsqwsmRoMl+vQBhayFSw2mlzvy2Ew1zy9L/PE1q9/Q4eMwAxB?=
 =?us-ascii?Q?LniSGXRT/UhWpix8baK6lxfh20gpMhBx4n+p6HJ2uhDxU8slYwrhMFmM6L7Q?=
 =?us-ascii?Q?ZxbASSIThMw7XQ9BYB5SZKo5wGLBmqNBm4U1PRowPuRJdKZtwTGR7ZZKro0S?=
 =?us-ascii?Q?VJatas+IlN+DKlpd3IUdQeKN/4jQ7WwEcj0KCkSD7trOvGIdMcgyQQkGlhep?=
 =?us-ascii?Q?CjhRmFInwjw8wpaWP6XGPAlGGFBu7yUdmbnagRLlxpoF7eEJEYre4J6t5NSz?=
 =?us-ascii?Q?tU59SDoqYopYE1JPhhlGzhjlkg6DnIozueegClqVKTHtpxmGT8V/kJMUww/7?=
 =?us-ascii?Q?Gw=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: aac52b7e-8ff3-4d11-097e-08dcd43b9150
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 21:32:28.7102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QMiitYLM6hbstTZfvvNwygX67h4fpgSNWYA48MJ1Wh6U1zeysJ8io7JUqsF89Sr/e2s+k3BNgv4FyTSiuPxN/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3594

Currently bindgen has special logic to recognise `size_t` and `ssize_t`
and map them to Rust `usize` and `isize`. Similarly, `ptrdiff_t` is
mapped to `isize`.

However this falls short for `__kernel_size_t`, `__kernel_ssize_t` and
`__kernel_ptrdiff_t`. To ensure that they are mapped to usize/isize
rather than 32/64 integers depending on platform, blocklist them in
bindgen parameters and manually provide their definition.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/bindgen_parameters | 5 +++++
 rust/bindings/lib.rs    | 5 +++++
 rust/uapi/lib.rs        | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/rust/bindgen_parameters b/rust/bindgen_parameters
index a721d466bee4b..756307dd59350 100644
--- a/rust/bindgen_parameters
+++ b/rust/bindgen_parameters
@@ -1,5 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 
+# We want to map these types to isize/usize manually, instead of
+# define them as int/long depending on platform bitwidth.
+--blocklist-type __kernel_s?size_t
+--blocklist-type __kernel_ptrdiff_t
+
 --opaque-type xregs_state
 --opaque-type desc_struct
 --opaque-type arch_lbr_state
diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
index 93a1a3fc97bc9..9999c90e8db14 100644
--- a/rust/bindings/lib.rs
+++ b/rust/bindings/lib.rs
@@ -26,6 +26,11 @@
 
 #[allow(dead_code)]
 mod bindings_raw {
+    // Manual definition for blocklisted types.
+    type __kernel_size_t = usize;
+    type __kernel_ssize_t = isize;
+    type __kernel_ptrdiff_t = isize;
+
     // Use glob import here to expose all helpers.
     // Symbols defined within the module will take precedence to the glob import.
     pub use super::bindings_helper::*;
diff --git a/rust/uapi/lib.rs b/rust/uapi/lib.rs
index 80a00260e3e7a..0eca836c0dbbb 100644
--- a/rust/uapi/lib.rs
+++ b/rust/uapi/lib.rs
@@ -24,4 +24,9 @@
     unsafe_op_in_unsafe_fn
 )]
 
+// Manual definition of blocklisted types.
+type __kernel_size_t = usize;
+type __kernel_ssize_t = isize;
+type __kernel_ptrdiff_t = isize;
+
 include!(concat!(env!("OBJTREE"), "/rust/uapi/uapi_generated.rs"));
-- 
2.44.1


