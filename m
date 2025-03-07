Return-Path: <linux-kernel+bounces-550948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1927A5664F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 758E616D14E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55D7216E24;
	Fri,  7 Mar 2025 11:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJOVcQWe"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE29A2163A8;
	Fri,  7 Mar 2025 11:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741345729; cv=none; b=SkngRfJnOIyuzIp65fKdJHeY9nAU3pSn+6KKifcoNweg7TIKJPDj5DgQ3g7yrd9ZBC5ntJYypaYDdm/py1Hdw04DAVT8rEhjwduMZrTZL11WzUSMbmzxxNuHuGppuuePBtJKQzqEYRxrwYD+++swOXHiQTVO0A8dCGqEw4Afm+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741345729; c=relaxed/simple;
	bh=NFKIAidxnRMlrYELYDQT43QLdnHioABterAjD1+vLGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GwHFiqco5eKrAaOK0NG0slzBftxU92h1i3guHaDyg3m+14ex7mUlRg+qNIEuG875jKAyCaRQMJpya5mZmsogvX2lTuDEGsutgSrN2p+DN9yShUq3Qvbk21KAxpC8XLnwWd+2115/VogZmwtIsPbHMnpPTMANs65l6uTrNnkxgXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJOVcQWe; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-549946c5346so351469e87.2;
        Fri, 07 Mar 2025 03:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741345724; x=1741950524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bna1rbJPQWibEFwv4J1kDTSY5U7INmYTRZbd16nD/nc=;
        b=iJOVcQWeSWibvkunksfU1XYIryqmI1QAv5MN2XiSSDQnKm0Mxw9juMuOwi0HREQGrM
         eIdXQgsLCLalgoRwoRXPdMeeAx3EHk7DZpibxXJHc47Hzu2uOKwhGgp0TSHdn9NIG5P/
         Tr8F0B771ZfP822UwR+ZVWnyatdaiviLEepM2Ugv0t2IsPGij/AvP68o1OfSoUTFdX9w
         pTIz9BCjgwKEfZLpthdhowEehOtkkirLrm6z+GAB0LMRE7dgVCAAV3+i5JCeedpLfujy
         bgh18Vwg1FOQRC8z4hq7Uy4W2IHPjWm2ii3xYnrNRYWLRYIw0J8ffAUJG9zBbGVj49Ih
         y2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741345724; x=1741950524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bna1rbJPQWibEFwv4J1kDTSY5U7INmYTRZbd16nD/nc=;
        b=JOmQitW603PNYdh1tvI0Xyjl5OzcHba7Lui9ut7qvqrTp0KUnDO90zuouHTAr1IOkr
         K/yG/XkMuYeRej79Pyd/nNKOlCd97oUGYzoEfT8EZa49bhdArjk12EDTJno9GSpKNZ4a
         2UGDNXJ+p0qnehTej8UOro+HPZQJArynFJyRMjR46avvS7Jgq5/gtqrJMgDQyosuQ33D
         KtZckrC4ixz4tWmqmodTE0/nVMRibRS9EweR93OFX6tukMz2ul0wBnDLNfn+S1n76lM0
         eq/JjnwjCa3+JGzSnywNLbj1QiiMaRZuIxQUUBwgqBGjgM9RCHtHVNBCpvz4hwU7hb9T
         6WEw==
X-Forwarded-Encrypted: i=1; AJvYcCVEAHfIXO2NNZPAIRA9prPT7HNzgrDqm5APzUjPhneAcSr8Z/Ts9TyrLxVSiyfmoJrnkzYXHup+hgLYZCc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6NVR9yRGv0eyKPthTRxqti0CqyBUDiv7qu+w/5AkSGlf+9hUt
	+r0UasWQ893UaDjrCbPJsPisXjcXtPtHX/CIcCP2K86La4wuYPov3dozhQ==
X-Gm-Gg: ASbGncuvVPXvcafESsA1AkgBOebVmjESIR7i+DzfHTNP6maALmvUc0IzZA7S+YWM9sy
	y1BpRxIWf6iruvk6fOn56eI28F0nExitGIyRqhhbLQOJzVnHV7xEHTXFO7aDTBWpXocnykIHu+7
	1XanLNZp9NPm+IFEatDplaauLm7+OQrYOMYxbGQI4kvQWLR7Eo7gwWqrQ3bBnlwhSghKB52IWwJ
	YKvrUmkgfvxetLdFsGD9Y4KADLHrG1vtapK9t94W+rYelINPduA0KKiC2VcUqhzJq07ZJL9AsEX
	6uzUFgj/vhgIBIxcDrLTqlNl2p7J++PdPnoXVOj82XVHlYrAZXs6tzn4OBUt+ACnfvoIzjH04JT
	+m7tTxDEjTnvDnn2pYNOWEA==
X-Google-Smtp-Source: AGHT+IHjaZ7I8vrWUm2jSrf2K7izD3GQ+2svxuHCSAb3JqdODUfWFeX8SdZqFx0ZMpsg2ApCZyJSYg==
X-Received: by 2002:a05:6512:1597:b0:549:8cc8:efed with SMTP id 2adb3069b0e04-54990ebb232mr1066828e87.48.1741345723841;
        Fri, 07 Mar 2025 03:08:43 -0800 (PST)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b1c2a08sm448920e87.223.2025.03.07.03.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 03:08:42 -0800 (PST)
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
Subject: [PATCH v13 4/7] rust: device: add dma addressing capabilities
Date: Fri,  7 Mar 2025 13:06:21 +0200
Message-ID: <20250307110821.1703422-5-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307110821.1703422-1-abdiel.janulgue@gmail.com>
References: <20250307110821.1703422-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add functions to set the DMA mask to inform the kernel about the
device's DMA addressing capabilities.

Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/helpers/dma.c     |  8 ++++++++
 rust/helpers/helpers.c |  1 +
 rust/kernel/device.rs  | 29 +++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+)
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
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index db2d9658ba47..f9d3d4f60ddb 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -6,10 +6,12 @@
 
 use crate::{
     bindings,
+    error::Result,
     str::CStr,
     types::{ARef, Opaque},
 };
 use core::{fmt, ptr};
+use kernel::prelude::*;
 
 #[cfg(CONFIG_PRINTK)]
 use crate::c_str;
@@ -187,6 +189,33 @@ pub fn property_present(&self, name: &CStr) -> bool {
         // SAFETY: By the invariant of `CStr`, `name` is null-terminated.
         unsafe { bindings::device_property_present(self.as_raw().cast_const(), name.as_char_ptr()) }
     }
+
+    /// Inform the kernel about the device's DMA addressing capabilities.
+    ///
+    /// Set both the DMA mask and the coherent DMA mask to the same thing.
+    /// Note that we don't check the return value from the C `dma_set_coherent_mask`
+    /// as the DMA API guarantees that the coherent DMA mask can be set to
+    /// the same or smaller than the streaming DMA mask.
+    pub fn dma_set_mask_and_coherent(&mut self, mask: u64) -> Result {
+        // SAFETY: device pointer is guaranteed as valid by invariant on `Device`.
+        let ret = unsafe { bindings::dma_set_mask_and_coherent(self.as_raw(), mask) };
+        if ret != 0 {
+            Err(Error::from_errno(ret))
+        } else {
+            Ok(())
+        }
+    }
+
+    /// Same as [`dma_set_mask_and_coherent`], but set the mask only for streaming mappings.
+    pub fn dma_set_mask(&mut self, mask: u64) -> Result {
+        // SAFETY: device pointer is guaranteed as valid by invariant on `Device`.
+        let ret = unsafe { bindings::dma_set_mask(self.as_raw(), mask) };
+        if ret != 0 {
+            Err(Error::from_errno(ret))
+        } else {
+            Ok(())
+        }
+    }
 }
 
 // SAFETY: Instances of `Device` are always reference-counted.
-- 
2.43.0


