Return-Path: <linux-kernel+bounces-564939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F17AA65D54
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D20FD7A1FA8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DF91E51EC;
	Mon, 17 Mar 2025 18:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2q/ovPd"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D9C1FA85A;
	Mon, 17 Mar 2025 18:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742237660; cv=none; b=iVTvVcbMmXP2Fc8uNc4c1CXrwWh8DHMHs4zh7yPXOMh4+lKh3H183LllYwO88xTMiONlylTnTafJcs7SqFN3f+054yzudxGSQFELgm+LHQ5/tQzcbj7LtqXyk6blYYuhHTTU22uKguWWwLkAHE9VyEtbv9XkUisH/j3+ANcUN94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742237660; c=relaxed/simple;
	bh=vxvrgclxSGXK143+YdwqKleBIqHOGE8LJjEKOsHLBgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XUC105zH2balJsKfhnHtNQrgR+7Q0xaUW9jmVXKHTZNZalfp1B8gpRWbETr0nHt5RfN8wdSIRyh+zm8yaFjQ43EMngQXNP8+fqQ6OOVlZfgc6GUsWpBDVFKNd2D5Lcv2ja4+aHBP3QqsakORrDKurrvDHTCNoJIzfV/Eoxukg8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2q/ovPd; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5499da759e8so6540931e87.0;
        Mon, 17 Mar 2025 11:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742237656; x=1742842456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBxT3MGZ+hhcADBfYF1XCdcnBcE8PDalZquxlBy/B68=;
        b=N2q/ovPdCtHrluo09I1fmrFhWh68z7PUxPlXSk5CRkiGw32JBBH0cwsN64cAd0WCmT
         PN2LIYvfGWOy5yOvpRMdTON6lhXG1QOqNZSdCYglUbwxcYPdfp8b+jfvfSEl6EEfcQjC
         +6c1PWK5vj6zeWwqdwF6+g+q9g+AG7sOtppQUeEox6NZRCyK+p7nB4qgPPNuGUTnaERg
         oZNgkKHdjKgFq51hWci2zWtmpvomAMu9JRR//I5SnNll5fdTFRNE7L/gMnW+3c21mCiH
         uxPAUjG/vKENP1akdidPKU972qP038/CNNXFhXKHco6rm9KiKi4to1vV1+mpcliJRKRY
         BcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742237656; x=1742842456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oBxT3MGZ+hhcADBfYF1XCdcnBcE8PDalZquxlBy/B68=;
        b=wD0roI9yAl0V3lUE/h6sbLSyLIeOUvUeiNFJrTltELizMq0K1u3JQqPnaB6XSAzLUc
         xGvQXiu4KunrR6ZSr2tEHhOVbBGQAdDEThOU6Uz34U7NqZZsOXWnIF1f8a78LZDNwGg5
         eF/gN5KZdYe5SQhsFgg7A+6I0YYUtdPOv/CJJ+Q7ARf1ooiJAhEb3xIZLKEWnZaRX334
         s1W8AX79WOWLwctGvchsvfHBKFEHRPbyqGU+wp5O2SMHlDObKbeT8XGeIShDACqEJt16
         AZv4iu1rCUi71mRmBPKuVcTEVj8ND/14Zv6+ma4hE+1RPge5m21aVqt8AGbzClQE8C9T
         ZwcA==
X-Forwarded-Encrypted: i=1; AJvYcCUE0pAdF/s0P4tLW67cDo0I/Z/PdPBOU+MVb14N1kxUwDtaxvu1QcEK8xEDLVki9WIPPMN+j9P5/i9VTD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWeTh24L1SZLkJXi8JmRiFOWiPFNas0wKOu+7PA+VgFq1zscRG
	RN2sxFP/51iQsSKH/xuXeIIGKukMiRrbPOKpK20tk6OiS4ptdB2xzlxpLQ==
X-Gm-Gg: ASbGncug/TQIdX7Cq+0I+Hougr5hnJ0V6/Qz5ARHWcfNBAoDmWTEsmwkuOJZ6dNnJri
	neb7C/PD96/JW9G40YEq+dx6rh47ADsqjdyE8j/9+Ca/BxygJLKy81vohqJWa98tRAnNw6UdgqM
	PQNiGDt9898ja3EYrI2SvRijqZwSQOL4h6sJaxw0NwiJSSpn0XCZsSzHUzkaj2+Bm0G9TYjrZxx
	+8BPyw9nOvJsT/AfX5DbbbGBJ3IwcbsgyS2bpB0wj5cXZ8NLjsWlJMsKeHagxf7jIwFsHt3RhmY
	/pPF9ouTAciMeDoe4myJBe85f4o3jwCZV13TVcbHjIQ+KYV3UiLQxSQzfGzJGjd4IeLT6U6pFED
	WO8WzHMJszkx5ryPgfczksw==
X-Google-Smtp-Source: AGHT+IHHzE9MNcmcY799X/6TWw5sD7xGCyUwgJreKaa5Da/XvTSJswDdspqnvoKKyJWsthpl00i5dQ==
X-Received: by 2002:a05:6512:2c99:b0:545:81b:1516 with SMTP id 2adb3069b0e04-54a30582e58mr571697e87.15.1742237656042;
        Mon, 17 Mar 2025 11:54:16 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba865024sm1387506e87.123.2025.03.17.11.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 11:54:14 -0700 (PDT)
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
Subject: [PATCH v15 06/11] rust: dma: add dma addressing capabilities
Date: Mon, 17 Mar 2025 20:52:13 +0200
Message-ID: <20250317185345.2608976-7-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250317185345.2608976-1-abdiel.janulgue@gmail.com>
References: <20250317185345.2608976-1-abdiel.janulgue@gmail.com>
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
index 834d00c1347e..fc66f1764c31 100644
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
@@ -392,3 +420,15 @@ macro_rules! dma_write {
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


