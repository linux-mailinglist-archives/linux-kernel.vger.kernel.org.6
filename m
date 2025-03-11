Return-Path: <linux-kernel+bounces-556639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBE6A5CCBB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78C347AD081
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B03F263C6B;
	Tue, 11 Mar 2025 17:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcD7O3B+"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3761263F3F;
	Tue, 11 Mar 2025 17:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715400; cv=none; b=OA2/IUfy/R4+x/yBwkNILQ0Fp9b8KZLWqUyEV2L9QpzyonRofoo0tqek6V2Jxamdx/IzjUveW3tbxqIB8adA2EAKOqzxEg7en0AI5BptK3Mob4u1076S7RHqsDMD9bsDTZmsBqVsX4B4dGcGf6Sm7VAKeG9gIMog7Sn6DK4D8ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715400; c=relaxed/simple;
	bh=j4ICurqMmlLInUMYmohM6h+/0kW79Y0dJonUlhaLBYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TghHXbP9TMDFGEKq6v1RrKQvFLe2g2c7hucXuaVhliaW5cKIQOoPcGY8fxNU8lZXcCu3S7mMkRPrTPjsy/Nf8VXsEZ5/nUnZNPBxD5KjAnc5zwpVgkCcYfh/3PD6+9c3fmfUEFFTyBFM61sXpqQKDlQ7CceaPS+UIOj/C0hZOdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcD7O3B+; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30762598511so62039021fa.0;
        Tue, 11 Mar 2025 10:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741715397; x=1742320197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSrzlK5UgeilNXDe6by3qJ/tSZ9bYf/cIKJZFecm9Fs=;
        b=FcD7O3B+6SsDMNw4/xz5VPBhM2qMxvsKVry7fS/GKisfUd741lZl0I5OXm4nxpfqGi
         HWDZd2USyaIStejaGGq1IKUzU0ewSlJ8S0CnNQOuf17R0sr7OwHhXKrjvmlvrRTqcn0C
         3Uh7ARqHUWjiOygSIeBVtscnTse9MqPEphJYdNuRrVg+fh19itUQail2mexUdoA6oVcy
         GtDamkVPBTI+J6/9Mva3W01MC/OM82aAvDbOJHVviRLdG9FEk1rPyMlDVIn8TWY3OHgZ
         asbaFnHIrV6CTBfLwp43m4HtjkhaA6CZ0qJIBrKyQZOLbDlCULtkDRMMony8+N2xX4sx
         cBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741715397; x=1742320197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lSrzlK5UgeilNXDe6by3qJ/tSZ9bYf/cIKJZFecm9Fs=;
        b=ZzFRKXvsAV2K+zJUHMDQTKcqCYJTYxkK0yDPLGEVJFrXgltbF6awdiPvE3eIhCht+p
         V5Fz+kAlvRw2CQenHaI73YSYr80dO+L5b+OjUBQEp+qezh4Zxm0E57IagdnhXtP1/awI
         2SHgZNxiFt+IpryetBP9ln+Xmv9sMWZ/9peDFXlKkq+x7VD+vNe53aVxXjvoBkyk4hdg
         KT1dhbvLMIDFm6XYkRjg3MA6PQwZrw+MBh1xz3N4wDPiAp5e7Z+s+oh81dkywTKbjto8
         c4NASPLuNd2F46fdGvhRl/+hvdGcHTkKbww+R9s/iBM1hlrgLfoEAi95ouypIJ8yZl7L
         Cwlw==
X-Forwarded-Encrypted: i=1; AJvYcCW3koYL38jwLhPV7qieP3vR46cXkXEb+PoTDAK6dYRpL/FRb1PzQzOXTt/YdpwP85Ymr9MVRqpbgOyGyZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEWbAr3q4+4VtZ9E4WtSJQXE1egXCTDE/a9haFL1gsDp5g5Vis
	TceWfgFOgiE0zmh9fbEcWLk5jW+UnpqPBVqYzPR0EII7Kjbqkk5Pk6nbBg==
X-Gm-Gg: ASbGncsrKFHw4ZtKcuE4kA0Nu27v19fyEUszawpngjZLlD57OLOWfJu4tZYVRzuh4CZ
	VuZXqjKdpoL5h+i4ERMZq8jkV1Pkvyq2Z/GtauLcpHVlLlW8178w/qTg3QVUJRw4KEio9BX6pQC
	xzq3hi0hdBMKMnkmg5khhWjQGqmYxWjSXv5vIcJu4WYnOr/3nOwNqy59AcqnNbBNG1CSa4KSjBz
	4GfkBrrsDnMxAniKhxx/wQDr0T8czu9mfr4L3qAmwpVpcrNUdE9G/Q2Ijs2Ns6fkubMBYNg6TMh
	RdsEY8wtfnOfLEhYQAqK03q/c5jYj0bUtr60GZKvBIh8RRMdQDmev20yVnTfAi3v6476GpUscCE
	+oRhUGk7HsZJjmhHSHaTLZA==
X-Google-Smtp-Source: AGHT+IGIrskUDBhrtLJ6SrsQZPVLptUzfeEFgQD5QeWDh0vtw/4t8hw7rBlRiiUbzBV0cn9Wc/W8UQ==
X-Received: by 2002:a05:6512:3c98:b0:545:2550:7d67 with SMTP id 2adb3069b0e04-54990eaacadmr6700836e87.36.1741715396745;
        Tue, 11 Mar 2025 10:49:56 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae4465fsm1921728e87.26.2025.03.11.10.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 10:49:55 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org,
	daniel.almeida@collabora.com,
	dakr@kernel.org,
	robin.murphy@arm.com,
	aliceryhl@google.com
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kernel@vger.kernel.org (open list),
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	airlied@redhat.com,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v14 06/11] rust: dma: add dma addressing capabilities
Date: Tue, 11 Mar 2025 19:48:02 +0200
Message-ID: <20250311174930.2348813-7-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250311174930.2348813-1-abdiel.janulgue@gmail.com>
References: <20250311174930.2348813-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Danilo Krummrich <dakr@kernel.org>

Implement `dma_set_mask()` and `dma_set_mask_and_coherent()` in the
`dma::Device` trait.

Those methods are used to inform the kernel about the device's DMA
addressing capabilities.

Co-developed-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/helpers/dma.c     |  8 ++++++++
 rust/helpers/helpers.c |  1 +
 rust/kernel/dma.rs     | 46 +++++++++++++++++++++++++++++++++++++++---
 3 files changed, 52 insertions(+), 3 deletions(-)
 create mode 100644 rust/helpers/dma.c

diff --git a/rust/helpers/dma.c b/rust/helpers/dma.c
new file mode 100644
index 000000000000..8eb482386f93
--- /dev/null
+++ b/rust/helpers/dma.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/dma-mapping.h>
+
+int rust_helper_dma_set_mask_and_coherent(struct device *dev, u64 mask)
+{
+	return dma_set_mask_and_coherent(dev, mask);
+}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 0640b7e115be..8f3808c8b7fe 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -13,6 +13,7 @@
 #include "build_bug.c"
 #include "cred.c"
 #include "device.c"
+#include "dma.c"
 #include "err.c"
 #include "fs.c"
 #include "io.c"
diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 7ff797a7ad18..ac3ec0042327 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -5,10 +5,10 @@
 //! C header: [`include/linux/dma-mapping.h`](srctree/include/linux/dma-mapping.h)
 
 use crate::{
-    bindings, build_assert,
-    device,
+    bindings, build_assert, device,
     error::code::*,
     error::Result,
+    prelude::*,
     transmute::{AsBytes, FromBytes},
     types::ARef,
 };
@@ -18,7 +18,35 @@
 /// The [`Device`] trait should be implemented by bus specific device representations, where the
 /// underlying bus has potential support for DMA, such as [`crate::pci::Device`] or
 /// [crate::platform::Device].
-pub trait Device: AsRef<device::Device> {}
+pub trait Device: AsRef<device::Device> {
+    /// Inform the kernel about the device's DMA addressing capabilities.
+    ///
+    /// Set both the DMA mask and the coherent DMA mask to the same value.
+    ///
+    /// Note that we don't check the return value from the C `dma_set_coherent_mask` as the DMA API
+    /// guarantees that the coherent DMA mask can be set to the same or smaller than the streaming
+    /// DMA mask.
+    fn dma_set_mask_and_coherent(&mut self, mask: u64) -> Result {
+        // SAFETY: By the type invariant of `device::Device`, `self.as_ref().as_raw()` is valid.
+        let ret = unsafe { bindings::dma_set_mask_and_coherent(self.as_ref().as_raw(), mask) };
+        if ret != 0 {
+            Err(Error::from_errno(ret))
+        } else {
+            Ok(())
+        }
+    }
+
+    /// Same as [`Self::dma_set_mask_and_coherent`], but set the mask only for streaming mappings.
+    fn dma_set_mask(&mut self, mask: u64) -> Result {
+        // SAFETY: By the type invariant of `device::Device`, `self.as_ref().as_raw()` is valid.
+        let ret = unsafe { bindings::dma_set_mask(self.as_ref().as_raw(), mask) };
+        if ret != 0 {
+            Err(Error::from_errno(ret))
+        } else {
+            Ok(())
+        }
+    }
+}
 
 /// Possible attributes associated with a DMA mapping.
 ///
@@ -374,3 +402,15 @@ macro_rules! dma_write {
         }
     };
 }
+
+/// Helper function to set the bit mask for DMA addressing.
+pub const fn dma_bit_mask(n: usize) -> u64 {
+    if n > 64 {
+        return 0;
+    }
+    if n == 64 {
+        !0
+    } else {
+        (1 << (n)) - 1
+    }
+}
-- 
2.43.0


