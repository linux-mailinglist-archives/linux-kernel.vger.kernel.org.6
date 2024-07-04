Return-Path: <linux-kernel+bounces-241464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10806927BA3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF7AEB24280
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B061A1B6A53;
	Thu,  4 Jul 2024 17:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJFCrsst"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859891B6A7F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 17:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720112919; cv=none; b=txsKIwbDVgBAvoDcHLkRC3RBpbXytp5qY/4ctGq+NWnzEBRUR6QoN+RbwYKIKJBlroauHpZcHZG6/qK2dzZhFwMzwjSk1yh436b1XxU/4RGOrHBugZGlGy2vOpuV29Hbv/abGbx7JJnt0Kd1nfIzroqbtCKyatAKDWYkH0S06wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720112919; c=relaxed/simple;
	bh=DCq3JdKHMv1BQsHzkac2p/ZW/zPdLP0o1nouh+/SEUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGGa78/1xkkKLdbUQ1Xv8M+DMFt8wNsYhB81GVROWyeacia+W1gyvnplQYOPojIYTnLZQSpcIB+5xYUf+AF/FyTemKDY5uU+js+snh51aHNEI8LcWBshU7uGS/w+9TfTDrpPozaNOxYqusZ7/0CFGh2fk47i2w2J2kH+MYK7sT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WJFCrsst; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720112916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DNNJhnlE4FEesPjTYaQmJVB4plwJ5MVZycKMsnB4Uog=;
	b=WJFCrsstoU3nmRvuX4muh0pOezjohNniLpp035v/VRgw8aOS0mgPjFVhs5MZCBaOEQV5mo
	2NPye1Yc6U96aPAsIhkhaUXEZpZysmoEepfgjxkyifWV7foh7UaX0CWsHUkROv2PUZX2BP
	SdGhnrLYOsJd4DXyrK7JoxZYT73+7uI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-yqdXWKVnN4CZnc-lP7cigw-1; Thu, 04 Jul 2024 13:08:34 -0400
X-MC-Unique: yqdXWKVnN4CZnc-lP7cigw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4257f95fe85so6078245e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 10:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720112914; x=1720717714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNNJhnlE4FEesPjTYaQmJVB4plwJ5MVZycKMsnB4Uog=;
        b=Y00bbwZ2aWn0lsyosyhTG84rtUXVrHgdYekRAa3R7ZsEau8NXgqzV37RQ2mMD4sGUB
         PFIzAhy/fvazkNut1po0OlecgFljtPfZ19X1xLGQFdDxH7YhbebuAeS0wtqYR5AOCKSe
         WLKuX6JCgMgVd4kLbhUGc0ghudmW7Z2crQwJn3GOWVh2WPY6E7BLwcAhokHUdbVLjClU
         XaHGTxRqfaIlHCEn8FcoIHc1dwFArHWFTIILqi2eTsJ9wHC4TkD3g4TOCKOpUHU1rYPc
         ER3nV4JJy6Gn3d0P/ai8IJ4BWm9Gzm0ZZXVIoYyAJWgr6i4lkSzOVhEqfkeyfRyg6tpq
         LACQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCDZVBF9/iLcsdKYi41IWYiAiBREdfBz3EPP89utb1W0DSs46B0i8KSYjOgvzbxxoxqawrog7Bdz3LlmvSM6C+wOHEOMGzVA/fywW9
X-Gm-Message-State: AOJu0YzhbP5U5+ybQJ4EEhNwVSE1R0Ntrwi+vmFRCq3ez+3THmu3DL70
	PA4iTDvgSbQ9V2I2V3fWEzmlVRYrvMY9jOYMvwS1OHu9zotI2fTSAKFTjNDDj5BsDPH+eSh82IE
	XQRRuzSEHo2kCSwFPyZsSGBWl0Kcl1FtPltNCp7lPbYNLO8lykKGKJCcxiRndeA==
X-Received: by 2002:a05:600c:47ca:b0:425:7853:e2db with SMTP id 5b1f17b1804b1-4264a468ab2mr16629595e9.29.1720112913774;
        Thu, 04 Jul 2024 10:08:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1lCENdfe+k6G48i1rTSjNdqGggpx5cLlnXPcGT3EGfuFdPEzBXdckhXeQIDSmC2fNB/1RDA==
X-Received: by 2002:a05:600c:47ca:b0:425:7853:e2db with SMTP id 5b1f17b1804b1-4264a468ab2mr16629445e9.29.1720112913503;
        Thu, 04 Jul 2024 10:08:33 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a283577sm31163725e9.44.2024.07.04.10.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:08:33 -0700 (PDT)
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
Subject: [PATCH 05/20] rust: alloc: add module `allocator_test`
Date: Thu,  4 Jul 2024 19:06:33 +0200
Message-ID: <20240704170738.3621-6-dakr@redhat.com>
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

`Allocator`s, such as `Kmalloc`, will be used by e.g. `KBox` and `KVec`
in subsequent patches, and hence this dependency propagates throughout
the whole kernel.

Add the `allocator_test` module that provides an empty implementation
for all `Allocator`s in the kernel, such that we don't break the
`rusttest` make target in subsequent patches.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 rust/kernel/alloc.rs                |  9 +++++++--
 rust/kernel/alloc/allocator_test.rs | 21 +++++++++++++++++++++
 2 files changed, 28 insertions(+), 2 deletions(-)
 create mode 100644 rust/kernel/alloc/allocator_test.rs

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 8d79cc95dc1e..46ebdd059c92 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -2,12 +2,17 @@
 
 //! Extensions to the [`alloc`] crate.
 
-#[cfg(not(test))]
-#[cfg(not(testlib))]
+#[cfg(not(any(test, testlib)))]
 pub mod allocator;
 pub mod box_ext;
 pub mod vec_ext;
 
+#[cfg(any(test, testlib))]
+pub mod allocator_test;
+
+#[cfg(any(test, testlib))]
+pub use self::allocator_test as allocator;
+
 /// Indicates an allocation error.
 #[derive(Copy, Clone, PartialEq, Eq, Debug)]
 pub struct AllocError;
diff --git a/rust/kernel/alloc/allocator_test.rs b/rust/kernel/alloc/allocator_test.rs
new file mode 100644
index 000000000000..3a0abe65491d
--- /dev/null
+++ b/rust/kernel/alloc/allocator_test.rs
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#![allow(missing_docs)]
+
+use super::{AllocError, Allocator, Flags};
+use core::alloc::Layout;
+use core::ptr::NonNull;
+
+pub struct Kmalloc;
+
+unsafe impl Allocator for Kmalloc {
+    unsafe fn realloc(
+        &self,
+        _old_ptr: *mut u8,
+        _old_size: usize,
+        _layout: Layout,
+        _flags: Flags,
+    ) -> Result<NonNull<[u8]>, AllocError> {
+        panic!();
+    }
+}
-- 
2.45.2


