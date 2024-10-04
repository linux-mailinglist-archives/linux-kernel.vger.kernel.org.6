Return-Path: <linux-kernel+bounces-350708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD2199084F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14B401F21688
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1C31C75E4;
	Fri,  4 Oct 2024 15:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="KrdAqHuh"
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020082.outbound.protection.outlook.com [52.101.196.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B701C8762;
	Fri,  4 Oct 2024 15:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728057221; cv=fail; b=ueWqG+M83E4m2b1weiKRK04Yk43ceEP3xi4UpbBRlu+VhtgR2aGs0VlLOI8tgdFkqZOwkuRyj8TfQ50L6oOPpOXHFfxq9b/o09xYS3WmHZ4rfpFbZu0kPjogbOtsPYLa6TR6I9nGI4RQJUIWq1k6db1imI8P+jj+RFK/0/0Qw4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728057221; c=relaxed/simple;
	bh=34S+Ur0xBG946YMBJk2RT1VEBKupM5oBzb0ugGwopNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QYlAM/2rpioRxs5CbOCeQGOqTJBhiW/obNdT5zvidCT7DQJsbq/YtoroparK0mPY5tKqlVDYOkJboruuy24bMTdp8bcC6vJVR94/J/jfdjKSBqjuvTRy3g4isTWkhIs1ndeWsmaDlC4RQVVEfx1MsiogDNhNWVC/BfDu8cbAlxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=KrdAqHuh; arc=fail smtp.client-ip=52.101.196.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w7BtSDJbMqJVYRAnqHjzChVDXgU648VcLQwActjgqH8hHzRuW1XMf7b4W9MeqrTGRNIuQCblrfd6Moggr+sQzHLRhQoOzYnDkwW3kdLzKz1e1gCG/lx/4Y901soqtUZxMxFyvTHqpQMYGzJHybzgLnQ8Tg+rZLoLt6OXgliUJlasg77/1Pul0a+OmeDOrBaAVqo6SE0RUAhHU45/n7xfoHGuNq88dBx5PlnNPq3T0l9tJ1x2ImN2VLCliO/nNvr9iOXE06kXpcWPOAAJpRi/ZqZOUaC4h1/m0sm0Ca+Rv2B5odYp5RtBr7/GxUw16axl9TMyqaWeR4cKaiVv5o0sRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gVEw9WBbRxm9KiCje7GYA1FtEo7RsiMTkG7GuMPVD4=;
 b=eVy41+yZOBz86QLEr+YtVTge6oAUj2fPycK3Ry6YF0jyraNagESNcB4Tkcjif75HgOkn/RI9D4y2xATdyO9geN2dUuyTzItKrNz8ptVJw6bvHZhp6JOUI1PL7NhPeSBpn2BDm5xz+fIKz8KkxZ7HcIqAHhjbBGJ1pYFrK7ontFCYU0vYgY6Uki3nL/kAzQFs5Is7MNGj+btgJjSQ1E56ICygH62iafnPaQByWwMA2wx4X0/BEDJd+/jcrRlhrbn9Rg+DW+3k3/8k3hsNyLixVkfFdNFA7lQSmqZ9uJmYAvbxC9divF1P8UlrKFzTcB/p1DB0AXIVgO1RBm8Fx5giAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gVEw9WBbRxm9KiCje7GYA1FtEo7RsiMTkG7GuMPVD4=;
 b=KrdAqHuh2Q79ogKAwAhHh7asErw4oGk/iFuefDcNHDKmo8D6kM9ov91flydU32VsLFXgei9asbd1sdahxUpj2aAPEpM49uxOy0o66yCDPAXsA5iHhB9YofjElLwq6GaEz3pT5Otc+7o6FJyxN0AfVcEU08M4oax3NywSUsJFf2I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO2P265MB2557.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:12d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 15:53:36 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 15:53:36 +0000
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
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc: Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Dirk Behme <dirk.behme@de.bosch.com>,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH 1/3] rust: implement `kernel::sync::Refcount`
Date: Fri,  4 Oct 2024 16:52:22 +0100
Message-ID: <20241004155247.2210469-2-gary@garyguo.net>
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
X-MS-Office365-Filtering-Correlation-Id: 85cc8aca-10b5-4fac-7349-08dce48cb51a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KhywDTjiwc8iPO8f46BZJGMER/dvJu+uG/rX2ShctHibZiEkqcqALKiuVzKI?=
 =?us-ascii?Q?bTulHMpS4C7RgVk0fIUNG3nuWIreUrP08C4v+0CEZcRX8hQyL+qUk3v8dwFC?=
 =?us-ascii?Q?iBJNcy+DiWIXeFcKuWePYfJggjlEDAJJ350Qnz1v9mRi+vUg16Z1ClCptzd3?=
 =?us-ascii?Q?00H1v3I2KVhnX6NC99M3jAkioJ8ojySHx9/VkQnmRagmzMAjfqh+pXBBOnYo?=
 =?us-ascii?Q?+/v0L/7YKmOuZDxqBwExx3yFU7qXfZMSVNyJATOMxZ8i0eDjoK2GGho9uTyG?=
 =?us-ascii?Q?4JfP3GZaNooFaZkqLteoRI13Osnc5VlmLJQtyVnEeJWPvXNTIXXFmhHahV4/?=
 =?us-ascii?Q?yUbhE38aZHHJrA3r9K//SQflWpVbZzCQSiqo1hMGH0Dgdg44qRv0tcGUDi1C?=
 =?us-ascii?Q?ibpirqgEAdTiOnBvKg6O73rTfvcFDIgvs0q0L7yZH6XFBKeJMpfPcNg523Xt?=
 =?us-ascii?Q?gwGr5tMhcrM/fc5x3R5MlGw+Mdl8C0ulucnejwme2/0p0/8RVtWKaMPpWQSV?=
 =?us-ascii?Q?Q1bCzt+MQcA+axNkPj+JZmwluCJOZcWZCDvtFdTE0H5JrmOsxKqQa58bBSqa?=
 =?us-ascii?Q?PonOljmkbuhaWgPEBmZVPnxDT0jqtsWT143nNtpHoUg8uJXaRDxnDA/cUPrK?=
 =?us-ascii?Q?iw4RUoi5VMujD+RAsgvvBs9tE+5IAxZ7OPr8VdjJX/M2vwIZtcmiMevAJl96?=
 =?us-ascii?Q?Iv4b9d/xodsju4hGxFwySjxANTvGqJ1IJoBKcPlg29ZA5foAVQhawpKGTFJm?=
 =?us-ascii?Q?9NnD4WMzyYGnHAXgXVcBWKXhwUTi0OpNgrWzDFoiGY7lHQi0wxCeidl7vFLi?=
 =?us-ascii?Q?2DpK92dfHqlN+LQkRiUJX4hPHAcGCpJox2aZ05xqXk8Ur+a0WMPLcNXkVtJX?=
 =?us-ascii?Q?T+PaJf0O4uE0y8qqGdhTWlkV/4FIBDqsrssBFxCvuFG/y26fqc9IYXivEkXA?=
 =?us-ascii?Q?ecf01xqev9qIIOqncoUCz7AQpRm6FWp5OkgwuhCzSSi59XaunHck8qrf5WWg?=
 =?us-ascii?Q?qr2mGbiE6YLkbDJ3ngShAXGhhaGBstC3OZ0h+BXLCDALQVzr5EodwqfttKG4?=
 =?us-ascii?Q?7Xbz3EiH5DkSmkhencpixncIdFY+fm2oP/hU0u4sAjxhC122sAHrQjTcN+B4?=
 =?us-ascii?Q?kv7RBeEpD4lmmeQQ9UDU7tpwnN6rdRseeS5aiW1WeYfgPrPUylEdOtHzYoKV?=
 =?us-ascii?Q?ahVlzXSuLb90g1FHwJZ5kY1LBZ+wnq9RyC+fl0sf1uBSWhR2W80QtvhS2sE7?=
 =?us-ascii?Q?UzgB7vc+dok42FWHKceqzZm7ZUanGp4ok8bTKjgvfw8RmN+C9d3DIec3jjzR?=
 =?us-ascii?Q?bq3IwlpMY20oP5l6iTybfhyz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?myzS9Q19r8XgQBinXLZsQGDiaZFelI/OyJk6mZoJaB9AtM+SEiRidZ/FHx9i?=
 =?us-ascii?Q?TJK+hat1yV48mFKrKqBeogn4QZv4WR40pU5EuJKahdIePpS38Pjn+D170BbP?=
 =?us-ascii?Q?56Yi2l2fHr4/cnwG8wt6K2ldgzAGFRDNDJ2mLz2tr0uHLJyru1W0BsJQivae?=
 =?us-ascii?Q?F3EPrVem0B8q7Onn3nJV7sFrk69/YN6O/8w4QLAElcHGb7o1GSn6GhUU1aGS?=
 =?us-ascii?Q?JSw1tu1/GXe0JRc9H5sXn1a55SygQyI0zplFWhSCssKu1JFcaDCxTbB08gNm?=
 =?us-ascii?Q?Qep/VQ9vhpBEtsEK2lMjR19YQLxEVCrmGYf8qdr4upOKUnpipWF7QtX19u8A?=
 =?us-ascii?Q?KEdomo8zJTg+K/qlOp1HoozOAi3otKswlyC/pn0svhWfletMl1ka0qBV91Fz?=
 =?us-ascii?Q?kkFlEc1mTxOMcWC7iyg0fG+2ii9ePzv7xcwy8V7Iv7cmyQpr2j432y3U+oIb?=
 =?us-ascii?Q?TQqyEnR1uqPHjvHwy23B2wjtAQvPJDer3QRmwYQ5BN3lo9SUD4WKZJfAcUtv?=
 =?us-ascii?Q?oe13FYNNPljVqlsE2PLIBQWE5Ou1dq4LarcGiGJVf1R/CBThhuebt7SAkTfz?=
 =?us-ascii?Q?qLhS+UEG1xuLleLdwbC49KEj4jP+6Fi3NUkjoKxQjUzV9rkoy5QFr/uTff4G?=
 =?us-ascii?Q?cxukDPvqDV66suMmeTtQGyUTplDKPxGkSHwO+bgjMoLdCDSoX1r6eSAkovPo?=
 =?us-ascii?Q?WfdlpAxF4311Cgv1+3uGRNfQyC5Yy84DSh72pPlkUqHr8VbDqJFDgnUHgv92?=
 =?us-ascii?Q?UwiTf0e0KrFlvUnC4i3yqfoV6dSXXLjjb18Ya+S3nAuDZkIoFn3MV62JH8AE?=
 =?us-ascii?Q?K0Jk7ODe3OBsGhyRw6unRmawvs/0XQ5PspGKr2YoC7/DadGAQI9j1UPKm96B?=
 =?us-ascii?Q?24WIoUFyeiG27DsQPTxdT4TSpQ9b0qG8PZDTTXAKM/17O8dK0pszzUu6ycVB?=
 =?us-ascii?Q?N29BHkabpbmW8iD902nX65GngaDB3Ox+DtA53l4ylvh5Jqp9I63942yyp/2h?=
 =?us-ascii?Q?4oQNajoDv5sqQxnyZWS9uWjyJMMBp0tOW5yfDS5DC1IbROELvc15JTV68RGG?=
 =?us-ascii?Q?kFll8RBYfFwDQAC0H+VkpsUXdfrTxo4stSIThcfv5e1saiVVORrdSVr3YPxr?=
 =?us-ascii?Q?QW4Iw3FrOWz6vzN7L632K1wNBMw+4vuK5qoAO2Sfwk3MMfxKQQNvb6745XTm?=
 =?us-ascii?Q?Kxeq3GkV84NkYikEO4k3cqSwC4sndELHGUMirO0xtZGoZA+8LuETvSecaD+8?=
 =?us-ascii?Q?id4CAGClztkPWifBI+FCx7G1x5ByyPMqqWCUoXT8vRWOyqtqTWus9LXy8DHG?=
 =?us-ascii?Q?EaCShmKXnG1Y56Ax3ZGmTAdvfnVVZglGYuuoeTLsoiRfHBMu0wJueNfPePxj?=
 =?us-ascii?Q?UKgHE8u81wAtaQ1aIyYUiggtlWz/Ndv8xvEsQw2ZUeXbfR4x+fcuxFXaCyTG?=
 =?us-ascii?Q?Eg3mM8Raxy3iJ9/swH5P2lanALnKMQyUgcANUJ/CrOei7czNalCj5kBCx95L?=
 =?us-ascii?Q?DWn7gTZ9HIdbeSgEo2Ykvomjf5Ut5d2tWhqaZOLQRtSLtwcJkjM51ny0yVcD?=
 =?us-ascii?Q?VVs/ivGaWPt+lkfOaCppSnZ94nxH1n+EcdCFfSNGswprb2U0PWk1JZ8A/4qb?=
 =?us-ascii?Q?Cw=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 85cc8aca-10b5-4fac-7349-08dce48cb51a
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 15:53:36.6261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3bgH1ulg13djrQkvxlRo4dPQhSvXv/36Z2p9nQ/B2xVOQBGfQxfviPtBB8SgqEMKxAwiIY8ZbSlixJTW1K9mig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB2557

This is a wrapping layer of `include/linux/refcount.h`. Currently only
the most basic operations (read/set/inc/dec/dec_and_test) are implemented,
additional methods can be implemented when they are needed.

Currently the kernel refcount has already been used in `Arc`, however it
calls into FFI directly.

Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/helpers/refcount.c      | 15 ++++++
 rust/kernel/sync.rs          |  2 +
 rust/kernel/sync/refcount.rs | 94 ++++++++++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+)
 create mode 100644 rust/kernel/sync/refcount.rs

diff --git a/rust/helpers/refcount.c b/rust/helpers/refcount.c
index f47afc148ec3..39649443426b 100644
--- a/rust/helpers/refcount.c
+++ b/rust/helpers/refcount.c
@@ -8,11 +8,26 @@ refcount_t rust_helper_REFCOUNT_INIT(int n)
 	return (refcount_t)REFCOUNT_INIT(n);
 }
 
+unsigned int rust_helper_refcount_read(refcount_t *r)
+{
+	return refcount_read(r);
+}
+
+void rust_helper_refcount_set(refcount_t *r, int n)
+{
+	refcount_set(r, n);
+}
+
 void rust_helper_refcount_inc(refcount_t *r)
 {
 	refcount_inc(r);
 }
 
+void rust_helper_refcount_dec(refcount_t *r)
+{
+	refcount_dec(r);
+}
+
 bool rust_helper_refcount_dec_and_test(refcount_t *r)
 {
 	return refcount_dec_and_test(r);
diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 0ab20975a3b5..534f098a44eb 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -11,12 +11,14 @@
 mod condvar;
 pub mod lock;
 mod locked_by;
+mod refcount;
 
 pub use arc::{Arc, ArcBorrow, UniqueArc};
 pub use condvar::{new_condvar, CondVar, CondVarTimeoutResult};
 pub use lock::mutex::{new_mutex, Mutex};
 pub use lock::spinlock::{new_spinlock, SpinLock};
 pub use locked_by::LockedBy;
+pub use refcount::Refcount;
 
 /// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
 #[repr(transparent)]
diff --git a/rust/kernel/sync/refcount.rs b/rust/kernel/sync/refcount.rs
new file mode 100644
index 000000000000..4a5b815adc05
--- /dev/null
+++ b/rust/kernel/sync/refcount.rs
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Atomic reference counting.
+//!
+//! C header: [`include/linux/refcount.h`](srctree/include/linux/refcount.h)
+
+use crate::types::Opaque;
+use core::sync::atomic::AtomicI32;
+
+/// Atomic reference counter.
+///
+/// This type is conceptually an atomic integer, but provides a saturation semantics compared to
+/// normal atomic integers. Values in the negative range when viewed as a signed integer are
+/// saturation (bad) values. For details about the saturation semantics, please refer to top of
+/// [`include/linux/refcount.h`](srctree/include/refcount.h).
+///
+/// Wraps the kernel's C `refcount_t`.
+#[repr(transparent)]
+pub struct Refcount(Opaque<bindings::refcount_t>);
+
+impl Refcount {
+    /// Construct a new [`Refcount`] from an initial value.
+    #[inline]
+    pub fn new(value: i32) -> Self {
+        // SAFETY: There are no safety requirements for this FFI call.
+        Self(Opaque::new(unsafe { bindings::REFCOUNT_INIT(value) }))
+    }
+
+    #[inline]
+    fn as_ptr(&self) -> *mut bindings::refcount_t {
+        self.0.get()
+    }
+
+    /// Get a refcount's value.
+    #[inline]
+    pub fn read(&self) -> i32 {
+        // SAFETY: `self.as_ptr()` is valid.
+        unsafe { bindings::refcount_read(self.as_ptr()) as _ }
+    }
+
+    /// Set a refcount's value.
+    #[inline]
+    pub fn set(&self, value: i32) {
+        // SAFETY: `self.as_ptr()` is valid.
+        unsafe { bindings::refcount_set(self.as_ptr(), value) }
+    }
+
+    /// Increment a refcount.
+    ///
+    /// It will saturate if overflows and `WARN`. It will also `WARN` is the refcount is 0, as this
+    /// represents a possible use-after-free condition.
+    ///
+    /// Provides no memory ordering, it is assumed that caller already has a reference on the
+    /// object.
+    #[inline]
+    pub fn inc(&self) {
+        // SAFETY: self is valid.
+        unsafe { bindings::refcount_inc(self.as_ptr()) }
+    }
+
+    /// Decrement a refcount.
+    ///
+    /// It will `WARN` on underflow and fail to decrement when saturated.
+    ///
+    /// Provides release memory ordering, such that prior loads and stores are done
+    /// before.
+    #[inline]
+    pub fn dec(&self) {
+        // SAFETY: `self.as_ptr()` is valid.
+        unsafe { bindings::refcount_dec(self.as_ptr()) }
+    }
+
+    /// Decrement a refcount and test if it is 0.
+    ///
+    /// It will `WARN` on underflow and fail to decrement when saturated.
+    ///
+    /// Provides release memory ordering, such that prior loads and stores are done
+    /// before, and provides an acquire ordering on success such that memory deallocation
+    /// must come after.
+    ///
+    /// Returns true if the resulting refcount is 0, false otherwise.
+    #[inline]
+    #[must_use = "use `dec` instead you do not need to test if it is 0"]
+    pub fn dec_and_test(&self) -> bool {
+        // SAFETY: `self.as_ptr()` is valid.
+        unsafe { bindings::refcount_dec_and_test(self.as_ptr()) }
+    }
+}
+
+// SAFETY: `refcount_t` is thread-safe.
+unsafe impl Send for Refcount {}
+
+// SAFETY: `refcount_t` is thread-safe.
+unsafe impl Sync for Refcount {}
-- 
2.44.1


