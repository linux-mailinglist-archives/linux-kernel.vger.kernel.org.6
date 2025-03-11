Return-Path: <linux-kernel+bounces-556643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFDEA5CCC1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A2723B9AE5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3658264A6E;
	Tue, 11 Mar 2025 17:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cf0OoOSa"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BFB26460E;
	Tue, 11 Mar 2025 17:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715407; cv=none; b=NA23T6VY5yRIAMiVCx6PujLyFRFyDg67fpSPW7DoxvVVFIjf3m0RQId6xa4mIfePIb44zQjPZWSeQz6KvcVqKTE9HrS7A8ZE7Pj2LOkNyDDqSjYtnnkTNKdyQi/953j0kSukmHWJd/4e+x4OUfZGC7jntheQof5qpJQ4YcwY19A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715407; c=relaxed/simple;
	bh=jCAxjyGzs4oya9QaR78RpvqzvHqmUmPWVJY26/yTUlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KY/3Ax3xvZokBPkyNfAAm59oZSbap9PzVDRh9HxcV1Z4VGlkL44mcJcW4O7cffhFxCrnhOurWUIx5JsVP3U6jL5I5e8O+ap9CyHw/FXUgifnNa/sdhT5XIle5CC2AHd5hZ2awgzAzGlZlQn3CLUWUwvD31JJy/k8mPvi3BdX2xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cf0OoOSa; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5498c742661so6225348e87.1;
        Tue, 11 Mar 2025 10:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741715403; x=1742320203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/BcF9+5sRTzvu9Wbc78vwyZ0YSIeBA8i4IVXLbkZM8=;
        b=Cf0OoOSaitSYpICxLVNpJCMOWMps5QmElF5BUIhoz72a/dx13CNr0Z/19a6Q27+FSw
         eVNJm9Ceq8vfVZfNLq952OYBLpsOtV0Hb4Pv/Jr/Ek4CU/qS+P5NqZDhVUnu8iZYleQn
         sn6IIg0SvqFz5F1RLeciN4CuwmK9qbwf1mSlgX/MpYk3Z7LubwhEjCT6jXRrzH8cM94A
         BLaCCN/VvEpsX5zKFBVjv6FYdJSLxDHBjeuWrlM9b6xK2shZfbL2kdiGqmNAPIRW8xPo
         xaI4pwjZ4EwQMp4oDWY8W81Mn326z0ku0RECqA2JBM2qbk3fF5/o8r88KO9dqbXO2cBa
         9L8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741715403; x=1742320203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/BcF9+5sRTzvu9Wbc78vwyZ0YSIeBA8i4IVXLbkZM8=;
        b=SIyFdljm88rKEm8XjVvHWHCpo4I4D8YIhXHr5J3XQA1EjZm30Y800eTykb0nWcZrqX
         DM9VPvu7H5YulaNL/YwMoaR909kkSVDJjJW+FyejnmI14P65P4TK16r3GmJmGIHz0Wn2
         glbaJqPBIwKt+p4gjlzsgcqwICiKCu3P4Jwg1b4ANI67LHOI409gvP/Z2UCffzAfzKnJ
         yCBj10scAW5SeyxbVwqETliAT5sQyRRn5veOfeBg1oY42EmcLM9nKoWiQHus/ltateR/
         QzucvENEtU2AQd12AI4KaASIifJI27PUWS59oVCQHAKCwSKRPND05t/JS9/zznGel4ec
         se5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVlGlGZSQtkS7thHRlIa2szC1mrg+ZorvJPFfkFQ6atLKhguFeLgsOEoChbC8lFqq9DQBwfRdHozU8+YCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCm0Lv9EM+JNRMcfR/3vXCLoVkZvQ2qeeHn8Il5Jr5LQeklCwk
	FnTYn85tDIiJheWlxHfv/bo+KVd0/rl83paEErZFAdWRNM+3PkKYNC6bqg==
X-Gm-Gg: ASbGnctRUZt4CiTJ/p+65g5oBZr3WehHM/a+v8PP2lfiEdie8M5ZRB2dzmhfnbuEKw7
	7NmotKu7o7r42xMkrc345r+4K8I5HtySEaRRPhfimPbZSs4cFCjP1lCVSZbJHhs85z+45KbHdbD
	Kk753JJHosm0oj++7uX7R9WRJQA0pJLFFBdFQju9A/SjcDrzym88WdVOTQRhbQ9T1jgLaeXIpsZ
	LuQWGZ3mCuQFm+46GKbhkCqEXt7GtqXdP32jx2at6TkiZNH9KqY50x9P8+6aq/LiED3j6y944PD
	x12M/ijpIn7DuQZOCqscFQPgPFrpeVLDmmkGU/RmzVv9Q6frtMxBt3IdAkgAebomZ9ASp4jl2rt
	nFJvn8mHuoN/0+mFLfDViaw==
X-Google-Smtp-Source: AGHT+IHblh0TlLPZ43+xMrhkpG+KkUIQT9tbXvVKDpewT/2IX8Y/8KH0Ot/MbNxqkdQ9EYAQ8UxUeA==
X-Received: by 2002:a05:6512:3da3:b0:545:296e:ac28 with SMTP id 2adb3069b0e04-54990e67291mr7588998e87.24.1741715403240;
        Tue, 11 Mar 2025 10:50:03 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae4465fsm1921728e87.26.2025.03.11.10.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 10:50:02 -0700 (PDT)
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
Subject: [PATCH v14 09/11] rust: dma: use `dma::Device` in `CoherentAllocation`
Date: Tue, 11 Mar 2025 19:48:05 +0200
Message-ID: <20250311174930.2348813-10-abdiel.janulgue@gmail.com>
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

Require a `&dyn dma::Device` in `CoherentAllocation`, such that DMA
memory can only be allocated with devices on potentially DMA capable
busses.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/kernel/dma.rs       | 16 ++++++++--------
 samples/rust/rust_dma.rs |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index ac3ec0042327..d0c6569cfc70 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -57,10 +57,9 @@ fn dma_set_mask(&mut self, mask: u64) -> Result {
 /// # Examples
 ///
 /// ```
-/// use kernel::device::Device;
-/// use kernel::dma::{attrs::*, CoherentAllocation};
+/// use kernel::dma::{attrs::*, Device, CoherentAllocation};
 ///
-/// # fn test(dev: &Device) -> Result {
+/// # fn test(dev: &dyn Device) -> Result {
 /// let attribs = DMA_ATTR_FORCE_CONTIGUOUS | DMA_ATTR_NO_WARN;
 /// let c: CoherentAllocation<u64> =
 ///     CoherentAllocation::alloc_attrs(dev, 4, GFP_KERNEL, attribs)?;
@@ -178,16 +177,15 @@ impl<T: AsBytes + FromBytes> CoherentAllocation<T> {
     /// # Examples
     ///
     /// ```
-    /// use kernel::device::Device;
-    /// use kernel::dma::{attrs::*, CoherentAllocation};
+    /// use kernel::dma::{attrs::*, Device, CoherentAllocation};
     ///
-    /// # fn test(dev: &Device) -> Result {
+    /// # fn test(dev: &dyn Device) -> Result {
     /// let c: CoherentAllocation<u64> =
     ///     CoherentAllocation::alloc_attrs(dev, 4, GFP_KERNEL, DMA_ATTR_NO_WARN)?;
     /// # Ok::<(), Error>(()) }
     /// ```
     pub fn alloc_attrs(
-        dev: &device::Device,
+        dev: &dyn Device,
         count: usize,
         gfp_flags: kernel::alloc::Flags,
         dma_attrs: Attrs,
@@ -197,6 +195,8 @@ pub fn alloc_attrs(
             "It doesn't make sense for the allocated type to be a ZST"
         );
 
+        let dev = dev.as_ref();
+
         let size = count
             .checked_mul(core::mem::size_of::<T>())
             .ok_or(EOVERFLOW)?;
@@ -229,7 +229,7 @@ pub fn alloc_attrs(
     /// Performs the same functionality as [`CoherentAllocation::alloc_attrs`], except the
     /// `dma_attrs` is 0 by default.
     pub fn alloc_coherent(
-        dev: &device::Device,
+        dev: &dyn Device,
         count: usize,
         gfp_flags: kernel::alloc::Flags,
     ) -> Result<CoherentAllocation<T>> {
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index 1740140faba6..4c7ebf66647a 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -52,7 +52,7 @@ fn probe(pdev: &mut pci::Device, _info: &Self::IdInfo) -> Result<Pin<KBox<Self>>
         dev_info!(pdev.as_ref(), "Probe DMA test driver.\n");
 
         let ca: CoherentAllocation<MyStruct> =
-            CoherentAllocation::alloc_coherent(pdev.as_ref(), TEST_VALUES.len(), GFP_KERNEL)?;
+            CoherentAllocation::alloc_coherent(pdev, TEST_VALUES.len(), GFP_KERNEL)?;
 
         || -> Result {
             for (i, value) in TEST_VALUES.into_iter().enumerate() {
-- 
2.43.0


