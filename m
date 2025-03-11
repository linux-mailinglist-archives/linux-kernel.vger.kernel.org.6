Return-Path: <linux-kernel+bounces-556645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E94FA5CCC3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41CDA17C23D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A947E264F8D;
	Tue, 11 Mar 2025 17:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwoAgrlS"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BD5264A84;
	Tue, 11 Mar 2025 17:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715410; cv=none; b=sFjOVDCROVwtLJzc3Vs8WX3xRDe1XqhJo/ox4wH0czd1C4AN5I9VEMxJM70yRIUSHNc2RD/tWV47QMjz5PWfrRvLu5K+9SScWrnDhVeIdFgMjxUbEMdRKGbiuWjN3vEfnjfiE/9mp+hpAgi4zFdwjrV8GbiakqzNn61kl8pYv1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715410; c=relaxed/simple;
	bh=964LyMRqlPXEPxt4dRUtburkX8rzYyxtJ+Zd6YPN9n8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S7k+3lynup3Xfa5gu6qWnb7Clj1jSPJyn2pajLNMdMx0A4LS/gsTjpV8aWsy1POEjQo1eBjkxZcBAQ7AiJ4f6G3lH3pY/RrzFfeXUdZXRT07PcTa+eXG6LJX1h3pcHCcvv0g6JkLZ28/+7Ow9jj4gYwhdD/5sQOSzja6VkA7yN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QwoAgrlS; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5498d2a8b89so5813146e87.1;
        Tue, 11 Mar 2025 10:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741715407; x=1742320207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uyciabioh/RTBRWZFgAXOHCv2udpm7yTbk+rfqYhebY=;
        b=QwoAgrlS0hZTDzA4IQrgJBKr/u1qc8yDiUQtyDY5M0PkyMipQJ5i/541MRi2YKRYJk
         /MfSK7pQnaIZg1+qV97GYGUbJoKNlHUDiRNYJx9NHIkLmv9yie9u/doFJpKAKlqpmQee
         /rQFygLrk2mAg+QuaP87rQspajvigs181oF/UBdI0lo8wJrUJDMKVU5grF1QR89vJr5Q
         DzFOYpduUToa7VlQTjPG4Iz3Ptk941Aqx+vy8vCvtK0rUwf6dAjJIU6lLO1WfbZZJwDX
         kuWWebeQn/X6p8wFW/CZJf/ETst2xtSN1fU6Lk7SOU/Ovntjulgc+aaBoEW6YF6RFrNh
         RayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741715407; x=1742320207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uyciabioh/RTBRWZFgAXOHCv2udpm7yTbk+rfqYhebY=;
        b=JnBarR6RM+cjHlwMoBiM/wjho8yA+9SmwFE1hraPZvvbcWG2P+eH7vWxbSOVCBiEjN
         I36rfx9tctEQ/dwY4N64/omENQTkq0rcAh6LVxgKLmMg1T87OMQJgnmZxVVCR7SczZfP
         gwHfksY/SL6AiWFn1iFBmdHU/B52woomVaxGCpR6InAjrUfaM43VlKMAFiEwxr0bfUlw
         g/+PDpNAOFmff49KX2KLbiGmXfJLR3fW+SWlltToV7IrbzOHg2EC+12/5bGAIU5+6Bkw
         pXtNdfM5xLjEFj762PUUMwZLBx1ApzGBVsf2QAi5K0rUBKc7sl9v0E8mrbyHVK3Q9ITp
         k46w==
X-Forwarded-Encrypted: i=1; AJvYcCVjgYctFh+1FQOR5jezPRFqbUzKUligcRq5j2M4RpGgXoNloOXzznUfpYIDodJ0M5Ht7oD0wboG3bhCj8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYigqN6UwFxlfG/aDzmKbTyK4WiAbwNHLJmDHgKKso6WZGwHuV
	3l8akpbMJJ5GRLuEE/mXOxNlUnKnhrw+lFz6f+5oe8SPQXPlO4Bw/ZyrnQ==
X-Gm-Gg: ASbGnct9ncA6RnzI8buOgq/1lVJmF2TbvsyiVIiVhb5Pf71FsT61D0Ok9ASQX/3+Mrh
	4/z4ZEbrIWUQGgtGT10ZKxaX7GBxSpVhBFKemM+sXbT/c15TwrwHB5PQLh/zaJMIsa2+ohaOoRz
	Hibuc1NQU0FBpNCbnEHyQ/TZYCmQKHGnn1jq8et1HBCxwujj3Ygu0hJMyFRoL26Q/nxgUV1Dd3V
	cSSjxSm9zhkbOdPhrHcmyIJh2SCC8U8TZT6Sa2YLsFUSm8e9tjyNk36/tgVawRFH4X5T4JOPFos
	etxpJF72NRRAr1l+n94dSL1VF1mcNkNFFzpixTU5/icJf3w+PmYNOUBWzyQS4ZneN9NUnqeUkwk
	3+SBRQZMAO/XygTVOK3WeLw==
X-Google-Smtp-Source: AGHT+IEJad4gl+z0QS4ewlzZ4karifVvk4Su2qy2hDsPEF00+XFLaO/pmT6m2hKmYpP7qT9AMIlM2A==
X-Received: by 2002:a05:6512:2393:b0:545:2950:5360 with SMTP id 2adb3069b0e04-54990e5e2a1mr6250883e87.22.1741715406926;
        Tue, 11 Mar 2025 10:50:06 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae4465fsm1921728e87.26.2025.03.11.10.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 10:50:05 -0700 (PDT)
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
Subject: [PATCH v14 11/11] rust: dma: add as_slice/write functions for CoherentAllocation
Date: Tue, 11 Mar 2025 19:48:07 +0200
Message-ID: <20250311174930.2348813-12-abdiel.janulgue@gmail.com>
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

Add unsafe accessors for the region for reading or writing large
blocks of data.

Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/kernel/dma.rs | 87 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index d0c6569cfc70..514fbb27c607 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -253,6 +253,93 @@ pub fn dma_handle(&self) -> bindings::dma_addr_t {
         self.dma_handle
     }
 
+    /// Returns the data from the region starting from `offset` as a slice.
+    /// `offset` and `count` are in units of `T`, not the number of bytes.
+    ///
+    /// Due to the safety requirements of slice, the caller should consider that the region could
+    /// be modified by the device at anytime. For ringbuffer type of r/w access or use-cases where
+    /// the pointer to the live data is needed, `start_ptr()` or `start_ptr_mut()` could be
+    /// used instead.
+    ///
+    /// # Safety
+    ///
+    /// * Callers must ensure that no hardware operations that involve the buffer are currently
+    ///   taking place while the returned slice is live.
+    /// * Callers must ensure that this call does not race with a write to the same region while
+    ///   while the returned slice is live.
+    pub unsafe fn as_slice(&self, offset: usize, count: usize) -> Result<&[T]> {
+        let end = offset.checked_add(count).ok_or(EOVERFLOW)?;
+        if end >= self.count {
+            return Err(EINVAL);
+        }
+        // SAFETY:
+        // - The pointer is valid due to type invariant on `CoherentAllocation`,
+        // we've just checked that the range and index is within bounds. The immutability of the
+        // of data is also guaranteed by the safety requirements of the function.
+        // - `offset` can't overflow since it is smaller than `self.count` and we've checked
+        // that `self.count` won't overflow early in the constructor.
+        Ok(unsafe { core::slice::from_raw_parts(self.cpu_addr.add(offset), count) })
+    }
+
+    /// Performs the same functionality as [`CoherentAllocation::as_slice`], except that a mutable
+    /// slice is returned.
+    ///
+    /// # Safety
+    ///
+    /// * Callers must ensure that no hardware operations that involve the buffer are currently
+    ///   taking place while the returned slice is live.
+    /// * Callers must ensure that this call does not race with a read or write to the same region
+    ///   while the returned slice is live.
+    pub unsafe fn as_slice_mut(&self, offset: usize, count: usize) -> Result<&mut [T]> {
+        let end = offset.checked_add(count).ok_or(EOVERFLOW)?;
+        if end >= self.count {
+            return Err(EINVAL);
+        }
+        // SAFETY:
+        // - The pointer is valid due to type invariant on `CoherentAllocation`,
+        // we've just checked that the range and index is within bounds. The immutability of the
+        // of data is also guaranteed by the safety requirements of the function.
+        // - `offset` can't overflow since it is smaller than `self.count` and we've checked
+        // that `self.count` won't overflow early in the constructor.
+        Ok(unsafe { core::slice::from_raw_parts_mut(self.cpu_addr.add(offset), count) })
+    }
+
+    /// Writes data to the region starting from `offset`. `offset` is in units of `T`, not the
+    /// number of bytes.
+    ///
+    /// # Safety
+    ///
+    /// * Callers must ensure that no hardware operations that involve the buffer overlaps with
+    ///   this write.
+    /// * Callers must ensure that this call does not race with a read or write to the same region
+    ///   that overlaps with this write.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// # fn test(alloc: &mut kernel::dma::CoherentAllocation<u8>) -> Result {
+    /// let somedata: [u8; 4] = [0xf; 4];
+    /// let buf: &[u8] = &somedata;
+    /// // SAFETY: No hw operation on the device and no other r/w access to the region at this point.
+    /// unsafe { alloc.write(buf, 0)?; }
+    /// # Ok::<(), Error>(()) }
+    /// ```
+    pub unsafe fn write(&self, src: &[T], offset: usize) -> Result {
+        let end = offset.checked_add(src.len()).ok_or(EOVERFLOW)?;
+        if end >= self.count {
+            return Err(EINVAL);
+        }
+        // SAFETY:
+        // - The pointer is valid due to type invariant on `CoherentAllocation`
+        // and we've just checked that the range and index is within bounds.
+        // - `offset` can't overflow since it is smaller than `self.count` and we've checked
+        // that `self.count` won't overflow early in the constructor.
+        unsafe {
+            core::ptr::copy_nonoverlapping(src.as_ptr(), self.cpu_addr.add(offset), src.len())
+        };
+        Ok(())
+    }
+
     /// Returns a pointer to an element from the region with bounds checking. `offset` is in
     /// units of `T`, not the number of bytes.
     ///
-- 
2.43.0


