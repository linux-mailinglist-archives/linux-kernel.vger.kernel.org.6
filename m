Return-Path: <linux-kernel+bounces-241476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9EF927BB4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0D921F2449B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56ECC1B4C46;
	Thu,  4 Jul 2024 17:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B1no5Vrb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BFA1CF3DA
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 17:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720112964; cv=none; b=HUaDQ9UibduVSErIxsVlAmWPMa5lKF4ppKmWLeTcqaxv/+altvH+JLkaiCapZRMxHoyDF91fMyVQPlvoSz7xegw5tY20IuPKYj2gkUttuunb0OG3XODD+4aHYyYrXTANBGvVsRl3FKgO8cLHfWAail+oV7c7/jSy5L9lyx2PG7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720112964; c=relaxed/simple;
	bh=XaoL+c3CKcLGkGaS6dN6gGgH1UcvqowfyMOc7PMR0Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sL3ujwvj5IbtTHofydXTEBJjjGtigR0csOrjY5KY92RnConKEb1Bb3r+LhTFPoXv9Y5w4wqQGwVKXrj0pD3Dt29tyVCpwtZKerJg6bmv1YJSdGACbimZ9uyf6ESPjjzOyySwGeaO3fQ8vBJlYLKVt9uQemRkXDu3zscTVyMEOk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B1no5Vrb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720112962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0zplR95ywjysz6XCCMayD+WP0RtbZS0dmGGMbrdUaAU=;
	b=B1no5VrbLFwm03OavJmIEtIrlou5bN6/P0gd5lAGcDeVXFsmZ68pnByt/BhdmKRGea9+6j
	IT73bhEbfJK6s/JFEvPDCHnZoyZbtGeotu/2QCw7+jY7hYUEjoZ28CACCqz3LJkOQQ6kdV
	rz0+MUGft+RDGDTkBn/qCSxAyV4Rtyg=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-vep26zuAO3CRirSvkoidmw-1; Thu, 04 Jul 2024 13:09:21 -0400
X-MC-Unique: vep26zuAO3CRirSvkoidmw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-52e969d0198so921166e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 10:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720112959; x=1720717759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zplR95ywjysz6XCCMayD+WP0RtbZS0dmGGMbrdUaAU=;
        b=XqJbAU3zs/alIFRtxelZpOstXJ6nlYBLjdsA0QUFVRQrBdfH65aHW+Q7shcw49BG7Q
         nP78bUadZ6ztOXVgsOZubcnxTRLoxdA2wY/K0z7WLfvzCLcqXc20thsLNyiAGvrxxmZO
         JRU3JYdGvOphg/TIxtAVLEXrMkFHnDgyL4zHE7KmG8LtjTz0QoOBLK4MFbNkndU/0lmG
         6JC6FVjmvJ1DsS8nKGLPH7aep1Y3/S+1v6lp1K+Yc+mhWvVBEprUEdZe6nxwo0hphb79
         T+FUOcFAsbFPKY4tlZ+Wb851txoVeXE/F02uZFOXz6nLHWSVYMXPeyHbSSO1x3raMBPU
         hQfw==
X-Forwarded-Encrypted: i=1; AJvYcCUGslvbUW9zpUyJZuICBnFF0HdUtJBiYTZ1WRz6dUIB+DFVcjJJPPLOK27K0HMh6uk812eMxdtLh3dlU4Z3n7KaC6u8FSKdY/CpQag7
X-Gm-Message-State: AOJu0Yxt2F1YA8QOKuyIqRoFb7yV8frVlgotVsrdyiruALmMLYVC1I/P
	JlZIfYijEdfW1B0PlTtl39LIMLiD1kYIpvBMpnmJBG2rroRq2Uzegrzn/CZCAMgO+mE8tXRQ22h
	2RHGRETHYpiGTCUrtIyB4IVoSs1otX0HjlE5MqhcUU19Pj7pTmvop2VHqzFDuMisQu8yWEA==
X-Received: by 2002:ac2:4436:0:b0:52c:df77:6507 with SMTP id 2adb3069b0e04-52ea0641231mr1734208e87.37.1720112959049;
        Thu, 04 Jul 2024 10:09:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn5MmEc0L9zeEIwNR+k6aoMoK9A1IqV3mcSkP+FvZJEBEpoHcx3+B4DzC1hITE2cXFqTfSvQ==
X-Received: by 2002:ac2:4436:0:b0:52c:df77:6507 with SMTP id 2adb3069b0e04-52ea0641231mr1734171e87.37.1720112958598;
        Thu, 04 Jul 2024 10:09:18 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2fc8bcsm30972425e9.44.2024.07.04.10.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:09:18 -0700 (PDT)
From: Danilo Krummrich <dakr@redhat.com>
To: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com
Cc: daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com,
	boris.brezillon@collabora.com,
	lina@asahilina.net,
	mcanal@igalia.com,
	zhiw@nvidia.com,
	acurrid@nvidia.com,
	cjia@nvidia.com,
	jhubbard@nvidia.com,
	airlied@redhat.com,
	ajanulgu@redhat.com,
	lyude@redhat.com,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH 16/20] rust: treewide: switch to `KVec`
Date: Thu,  4 Jul 2024 19:06:44 +0200
Message-ID: <20240704170738.3621-17-dakr@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704170738.3621-1-dakr@redhat.com>
References: <20240704170738.3621-1-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we got `KVec` in place, convert all existing `Vec` users to
`KVec`.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 rust/kernel/str.rs            | 12 +++++-------
 rust/kernel/sync/locked_by.rs |  2 +-
 rust/kernel/types.rs          |  2 +-
 samples/rust/rust_minimal.rs  |  4 ++--
 4 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index bb8d4f41475b..0b6ffbade521 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -2,8 +2,7 @@
 
 //! String representations.
 
-use crate::alloc::{flags::*, vec_ext::VecExt, AllocError};
-use alloc::vec::Vec;
+use crate::alloc::{flags::*, AllocError, KVec};
 use core::fmt::{self, Write};
 use core::ops::{self, Deref, DerefMut, Index};
 
@@ -790,7 +789,7 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
 /// assert_eq!(s.is_ok(), false);
 /// ```
 pub struct CString {
-    buf: Vec<u8>,
+    buf: KVec<u8>,
 }
 
 impl CString {
@@ -803,7 +802,7 @@ pub fn try_from_fmt(args: fmt::Arguments<'_>) -> Result<Self, Error> {
         let size = f.bytes_written();
 
         // Allocate a vector with the required number of bytes, and write to it.
-        let mut buf = <Vec<_> as VecExt<_>>::with_capacity(size, GFP_KERNEL)?;
+        let mut buf = KVec::with_capacity(size, GFP_KERNEL)?;
         // SAFETY: The buffer stored in `buf` is at least of size `size` and is valid for writes.
         let mut f = unsafe { Formatter::from_buffer(buf.as_mut_ptr(), size) };
         f.write_fmt(args)?;
@@ -850,10 +849,9 @@ impl<'a> TryFrom<&'a CStr> for CString {
     type Error = AllocError;
 
     fn try_from(cstr: &'a CStr) -> Result<CString, AllocError> {
-        let mut buf = Vec::new();
+        let mut buf = KVec::new();
 
-        <Vec<_> as VecExt<_>>::extend_from_slice(&mut buf, cstr.as_bytes_with_nul(), GFP_KERNEL)
-            .map_err(|_| AllocError)?;
+        KVec::extend_from_slice(&mut buf, cstr.as_bytes_with_nul(), GFP_KERNEL)?;
 
         // INVARIANT: The `CStr` and `CString` types have the same invariants for
         // the string data, and we copied it over without changes.
diff --git a/rust/kernel/sync/locked_by.rs b/rust/kernel/sync/locked_by.rs
index babc731bd5f6..b94517231fcc 100644
--- a/rust/kernel/sync/locked_by.rs
+++ b/rust/kernel/sync/locked_by.rs
@@ -43,7 +43,7 @@
 /// struct InnerDirectory {
 ///     /// The sum of the bytes used by all files.
 ///     bytes_used: u64,
-///     _files: Vec<File>,
+///     _files: KVec<File>,
 /// }
 ///
 /// struct Directory {
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 0b2a3ce538a6..5ef52d46a386 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -155,7 +155,7 @@ unsafe fn from_foreign(_: *const core::ffi::c_void) -> Self {}
 /// # use kernel::types::ScopeGuard;
 /// fn example3(arg: bool) -> Result {
 ///     let mut vec =
-///         ScopeGuard::new_with_data(Vec::new(), |v| pr_info!("vec had {} elements\n", v.len()));
+///         ScopeGuard::new_with_data(KVec::new(), |v| pr_info!("vec had {} elements\n", v.len()));
 ///
 ///     vec.push(10u8, GFP_KERNEL)?;
 ///     if arg {
diff --git a/samples/rust/rust_minimal.rs b/samples/rust/rust_minimal.rs
index 2a9eaab62d1c..4aaf117bf8e3 100644
--- a/samples/rust/rust_minimal.rs
+++ b/samples/rust/rust_minimal.rs
@@ -13,7 +13,7 @@
 }
 
 struct RustMinimal {
-    numbers: Vec<i32>,
+    numbers: KVec<i32>,
 }
 
 impl kernel::Module for RustMinimal {
@@ -21,7 +21,7 @@ fn init(_module: &'static ThisModule) -> Result<Self> {
         pr_info!("Rust minimal sample (init)\n");
         pr_info!("Am I built-in? {}\n", !cfg!(MODULE));
 
-        let mut numbers = Vec::new();
+        let mut numbers = KVec::new();
         numbers.push(72, GFP_KERNEL)?;
         numbers.push(108, GFP_KERNEL)?;
         numbers.push(200, GFP_KERNEL)?;
-- 
2.45.2


