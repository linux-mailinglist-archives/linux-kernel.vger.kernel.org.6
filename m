Return-Path: <linux-kernel+bounces-577659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E876A71FF4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 21:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55EEE178551
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23718258CC8;
	Wed, 26 Mar 2025 20:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksZJiA2R"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3E92571B4;
	Wed, 26 Mar 2025 20:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743019989; cv=none; b=UXGNI7lkgXB5vSo80LuRma13RMMfh9xpxGRo0Qr64TYFHnhk7EpBcZqSD4zINCSXZvo2MuMekaQgqMKcv77RQUxXvetgAuOGZ4d3DxpD3h0L0RhR9z2O//ibVC4xNJECNXKHnYoLOU+W6a8jJDJAaUK/8Kn8aqIchAgJvJ+BDys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743019989; c=relaxed/simple;
	bh=KUEjh4hK5AwiNirfSdvvzr04GjjI9soaojGNwlt+gYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KHHlttO775crTWj1eqj40CJAOZsImGRSaf5WL+RNWFbtyRcMzKVREZrRI4TN7rT/MDYp3DRA/BRun0BqiNwwYjUlnj9o0S8ToW0dwvD6FoA3CvABfbRKYd3dm7idGDOFk9CxUsC3pn3HZie2m/HdkCbYlHkG+RbBN6gfANHuQGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksZJiA2R; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-549b12ad16eso263791e87.0;
        Wed, 26 Mar 2025 13:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743019985; x=1743624785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqPyNQzlsZ2VM/tXZ2FXS0OL5lARsE8hyIi3dCnvYUw=;
        b=ksZJiA2R/2faCBiKS9KC0Ej8oyN+Dsuk6EwDF+tHWJXabKtry6q8nDdmCUb4bRc+dY
         22IW8/A2x8QA8TIpUw/GyJamzB3dpoTajmEDJbDlOVNMJouIOcBJe7W3XExfgY49hD3q
         LFbDcor4lhTF/Eqc3Kgt2Ybg+FZ/fYnda4q3rI2q+CY0a6vD2UnfddDaqYSswwialUVe
         b931wri3FeLyKX6Wqpgw3HMeohHA+wEtTbhK2oZ3me1zCrpPFOuU5PIEJWN+drLeqkKu
         6FhldSWUVApKvAVDKqSOQm+FI407FYSNV21MJlNkeGXhEBQ47fEoi51HurGkh6m+jpAu
         GyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743019985; x=1743624785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IqPyNQzlsZ2VM/tXZ2FXS0OL5lARsE8hyIi3dCnvYUw=;
        b=FiiTQdutKqyv154O7YBvD/aF/kF8/lbBh1z9uv+MurLNHt4DVH9MXvCrT4NgXaeVSD
         4gnnNo4L8mbxNhVwuHa/wuzwK4DdH2VM2E8mnFeMLpPlncysr9pgDnkEYglSD9+F0fd2
         8jN12toIxMVtzyp3JK5zgyGfBNV2JjT2ZNGo8xNPgFQbnSg8l11vPmYrtdn0CvtMwbt6
         S5ro/FfWj/QME5csZn4vRgNgSScap4M/14+8UjfWkOdmBFux8ZZtLmk8c7/MZ/MxZDy5
         kwan64mLipCEYkoGfEGB4I/Rg4HtM18WWtEo39Zi139/hg2jEpES8d9wEu3UvqWD9Ojj
         z/Yw==
X-Forwarded-Encrypted: i=1; AJvYcCWPD6hbbRXm2kGszNUN1e2O3hLZfwRIK04t9kohG1IroKvBTrAjPJt2R9CePbMzT2ITCcAXUnbV+8XNauDLV2c=@vger.kernel.org, AJvYcCWguosVFTWDFCboCcuOiLKVxOqwDjjWqRVIU+jy0h2h9IvWU8GU8KWczTPX8r9EOn5+9IndI0h4JqgtbF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhTWUt05n27xkyiyVWcojGVz5VSHAICXZZWYzg6RolTZ0E6ri5
	/PJidZMeHmx48+ddYtfWN+P+1zOUw0jdngL76xce1rcAGS0ymkPA
X-Gm-Gg: ASbGncsLgavyxkSGrbSWNGrBjuX5IUYnYrLilMTzLnNYezR9KfGAFH5GylmvhD0xXyk
	k7oP2zWlR/GZCRg7gf5gCz/RffCRBbxxL8YWvngnGAJR/NHEDbMQfXnKMzMb1ke56WholdmOAPo
	HKQZVgu+/nXyjOlPmgY6bErjVq1PTXCyX+mUn53TMS4TKenSnTFGbdXNMNeJc7eE/8FbdOMTIHu
	hZu8ZIDK+UL7go1/wtAlEF1lbLpcA46vemNgGmjXSXOmacgfYvHluMDigBww14Ir2GS74Fy/7gy
	UYRUx1krC/sTjnmE8KAfW3WUMiBY8Z5i7PcuwZaRJY+MiGoSdABLkyIkNz0Mhl3YcQZOOMhdLxH
	TD5+EUtb9EJFAZW3DqvErVw==
X-Google-Smtp-Source: AGHT+IG5DWfivJ6phDkqR8mJ7+AXG7ZqtqivCgyez055JfZ+pxmclpEKwBt74y4guotavXKViI0gpQ==
X-Received: by 2002:a05:6512:3d11:b0:545:652:109 with SMTP id 2adb3069b0e04-54b01264efemr392524e87.51.1743019985037;
        Wed, 26 Mar 2025 13:13:05 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad646873asm1872136e87.46.2025.03.26.13.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 13:13:04 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: a.hindborg@kernel.org,
	ojeda@kernel.org
Cc: Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org (open list:DMA MAPPING HELPERS DEVICE DRIVER API [RUST]),
	Marek Szyprowski <m.szyprowski@samsung.com>,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	linux-kernel@vger.kernel.org (open list),
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH 2/3] rust: dma: convert the read/write macros to return Result
Date: Wed, 26 Mar 2025 22:11:43 +0200
Message-ID: <20250326201230.3193329-3-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250326201230.3193329-1-abdiel.janulgue@gmail.com>
References: <20250326201230.3193329-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As suggested by Andreas Hindborg, we could do better here by
having the macros return `Result`, so that we don't have to wrap
these calls in a closure for validation which is confusing.

Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/kernel/dma.rs       | 54 +++++++++++++++++++++++-----------------
 samples/rust/rust_dma.rs | 21 ++++++----------
 2 files changed, 38 insertions(+), 37 deletions(-)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index d3f448868457..24a6f10370c4 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -328,20 +328,22 @@ unsafe impl<T: AsBytes + FromBytes + Send> Send for CoherentAllocation<T> {}
 #[macro_export]
 macro_rules! dma_read {
     ($dma:expr, $idx: expr, $($field:tt)*) => {{
-        let item = $crate::dma::CoherentAllocation::item_from_index(&$dma, $idx)?;
-        // SAFETY: `item_from_index` ensures that `item` is always a valid pointer and can be
-        // dereferenced. The compiler also further validates the expression on whether `field`
-        // is a member of `item` when expanded by the macro.
-        unsafe {
-            let ptr_field = ::core::ptr::addr_of!((*item) $($field)*);
-            $crate::dma::CoherentAllocation::field_read(&$dma, ptr_field)
-        }
+        (|| -> Result<_> {
+            let item = $crate::dma::CoherentAllocation::item_from_index(&$dma, $idx)?;
+            // SAFETY: `item_from_index` ensures that `item` is always a valid pointer and can be
+            // dereferenced. The compiler also further validates the expression on whether `field`
+            // is a member of `item` when expanded by the macro.
+            unsafe {
+                let ptr_field = ::core::ptr::addr_of!((*item) $($field)*);
+                ::core::result::Result::Ok($crate::dma::CoherentAllocation::field_read(&$dma, ptr_field))
+            }
+        })()
     }};
     ($dma:ident [ $idx:expr ] $($field:tt)* ) => {
-        $crate::dma_read!($dma, $idx, $($field)*);
+        $crate::dma_read!($dma, $idx, $($field)*)
     };
     ($($dma:ident).* [ $idx:expr ] $($field:tt)* ) => {
-        $crate::dma_read!($($dma).*, $idx, $($field)*);
+        $crate::dma_read!($($dma).*, $idx, $($field)*)
     };
 }
 
@@ -368,24 +370,30 @@ macro_rules! dma_read {
 #[macro_export]
 macro_rules! dma_write {
     ($dma:ident [ $idx:expr ] $($field:tt)*) => {{
-        $crate::dma_write!($dma, $idx, $($field)*);
+        $crate::dma_write!($dma, $idx, $($field)*)
     }};
     ($($dma:ident).* [ $idx:expr ] $($field:tt)* ) => {{
-        $crate::dma_write!($($dma).*, $idx, $($field)*);
+        $crate::dma_write!($($dma).*, $idx, $($field)*)
     }};
     ($dma:expr, $idx: expr, = $val:expr) => {
-        let item = $crate::dma::CoherentAllocation::item_from_index(&$dma, $idx)?;
-        // SAFETY: `item_from_index` ensures that `item` is always a valid item.
-        unsafe { $crate::dma::CoherentAllocation::field_write(&$dma, item, $val) }
+        (|| -> Result {
+            let item = $crate::dma::CoherentAllocation::item_from_index(&$dma, $idx)?;
+            // SAFETY: `item_from_index` ensures that `item` is always a valid item.
+            unsafe { $crate::dma::CoherentAllocation::field_write(&$dma, item, $val) }
+            ::core::result::Result::Ok(())
+        })()
     };
     ($dma:expr, $idx: expr, $(.$field:ident)* = $val:expr) => {
-        let item = $crate::dma::CoherentAllocation::item_from_index(&$dma, $idx)?;
-        // SAFETY: `item_from_index` ensures that `item` is always a valid pointer and can be
-        // dereferenced. The compiler also further validates the expression on whether `field`
-        // is a member of `item` when expanded by the macro.
-        unsafe {
-            let ptr_field = ::core::ptr::addr_of_mut!((*item) $(.$field)*);
-            $crate::dma::CoherentAllocation::field_write(&$dma, ptr_field, $val)
-        }
+        (|| -> Result {
+            let item = $crate::dma::CoherentAllocation::item_from_index(&$dma, $idx)?;
+            // SAFETY: `item_from_index` ensures that `item` is always a valid pointer and can be
+            // dereferenced. The compiler also further validates the expression on whether `field`
+            // is a member of `item` when expanded by the macro.
+            unsafe {
+                let ptr_field = ::core::ptr::addr_of_mut!((*item) $(.$field)*);
+                $crate::dma::CoherentAllocation::field_write(&$dma, ptr_field, $val)
+            }
+            ::core::result::Result::Ok(())
+        })()
     };
 }
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index 908acd34b8db..cc09d49f2056 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -54,13 +54,9 @@ fn probe(pdev: &mut pci::Device, _info: &Self::IdInfo) -> Result<Pin<KBox<Self>>
         let ca: CoherentAllocation<MyStruct> =
             CoherentAllocation::alloc_coherent(pdev.as_ref(), TEST_VALUES.len(), GFP_KERNEL)?;
 
-        || -> Result {
-            for (i, value) in TEST_VALUES.into_iter().enumerate() {
-                kernel::dma_write!(ca[i] = MyStruct::new(value.0, value.1));
-            }
-
-            Ok(())
-        }()?;
+        for (i, value) in TEST_VALUES.into_iter().enumerate() {
+            kernel::dma_write!(ca[i] = MyStruct::new(value.0, value.1))?;
+        }
 
         let drvdata = KBox::new(
             Self {
@@ -78,13 +74,10 @@ impl Drop for DmaSampleDriver {
     fn drop(&mut self) {
         dev_info!(self.pdev.as_ref(), "Unload DMA test driver.\n");
 
-        let _ = || -> Result {
-            for (i, value) in TEST_VALUES.into_iter().enumerate() {
-                assert_eq!(kernel::dma_read!(self.ca[i].h), value.0);
-                assert_eq!(kernel::dma_read!(self.ca[i].b), value.1);
-            }
-            Ok(())
-        }();
+        for (i, value) in TEST_VALUES.into_iter().enumerate() {
+            assert_eq!(kernel::dma_read!(self.ca[i].h).unwrap(), value.0);
+            assert_eq!(kernel::dma_read!(self.ca[i].b).unwrap(), value.1);
+        }
     }
 }
 
-- 
2.43.0


