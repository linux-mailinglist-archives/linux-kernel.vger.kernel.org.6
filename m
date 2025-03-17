Return-Path: <linux-kernel+bounces-564942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EA2A65D57
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC77B1896480
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2932046A4;
	Mon, 17 Mar 2025 18:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjWeU1Vr"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4EA2036F5;
	Mon, 17 Mar 2025 18:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742237665; cv=none; b=WNdRa97GyS+aoVbXTubDQXeC6sF6G35SFqhdVt+aylr/MBDvVMC8zejgEGBxkdbNhvLyBPbc9mLCuYeDNxeP3CLwsrQxZzmNXD4+1sZwjYJtGemfdRudQty8nv9ZCuKzp0tApoou+D1ni7pnguSALndRmn3wEMdQtsQIQakc8Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742237665; c=relaxed/simple;
	bh=AFXc+JDAFlfaLW6k8nRKqG1H7IeQzzuskvkR8ls2d24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tllymchJfFQZh75pAO9QxRpUvRSuvpssnf4cG+O/hm3RNkTlcgW56e4KS0WG6Tt7ZJEm66R9Q/TULgAk58iFEVWNOn/hVpNLoMFhiEcNNLR+jagCOcot0UDXxB+QWHbzbMXV50npCWdbgPTJwHMYntubPJzkgpTwZYr/Sqi45i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjWeU1Vr; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54963160818so5865899e87.2;
        Mon, 17 Mar 2025 11:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742237661; x=1742842461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thgHd6wCi9ljuTgZv1q/rgFzzZU0rxSovW0BQEj3yDA=;
        b=AjWeU1VrT3H9vemNxtxJ457OLPT7HSmvNYGzhAoFH9/Or9pFaliLpCHp+KKUJ0nYWt
         nrWrBccA6GVkJQMGJKzm+iDA5dkhWotw57YBq1/0pxtWzyndOXOoM/luGN+5BlZk1bBj
         8w2hCRIh0BIR7Kw7qQ48d2W6PiQv8lWq/Cl01K3GCVjY35mhqNPe7X90pgfk/DteMtFv
         oucodC/ipPbl7YDLi846RETT6fpXmKcRBlCIeyaAmT/Ipn3eLwqpQv5TUK4hvJd64TNH
         nz0kkibCZBziIU0H0o6d+WmMpDbXm9ufeJPPds8UoYvFTrCpJgWdTYDBjbd8lpXEm3ch
         DPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742237661; x=1742842461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=thgHd6wCi9ljuTgZv1q/rgFzzZU0rxSovW0BQEj3yDA=;
        b=qN0sFdg1vrqRr+mcWrRIEAvcGZ2WMseigeirq70b69ayBMq3hEI36MyqietP2MS0il
         LBFJasa1DxBeZaOJ0R3s+D7Zggl0fc1Vinukj/ckWFR3x8PKEo6fAtxne7Ix+wZrNeAz
         azvdbVo0JpZMnAP+pUYd1pLZwhcxgwEqWrTBN3h3sPeAmalQHzu0ZH2TKiC/0tYe4bhp
         Dt2uOciggAGsG1Za4oIZyic3mHZKiGH56Er/MwU+w6ZEQgkZiV9bvK68Y1DgTGJZk1u0
         btRQBkoDMz+ORgVD6S5pGZa3xdka/LfPRmLmjXfU1LBs0cNAxMxHDfjR9r40B4NaH66y
         KKQg==
X-Forwarded-Encrypted: i=1; AJvYcCVS32WFG3cbcTOS/jxnQ9+8nzqBNxIiPncTL5IYRVsycFfrIRi4sIeHMf4jj4sLdvafYwo9F3t8sQa9zuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YycgyCaWfS2APv3AX2Gl+420P7HKfznjVymmnggXu5CloimBblK
	hLS1CxDfVQkaGFAWxYfI7QKgJlzvhCfeY4BEjbk3d1UMPi7q9KWBQZqGPg==
X-Gm-Gg: ASbGnct1F8ODnJL+mRZKjdWZsJS/iaqK0Q4SOvtcUnsMrgVkZmCo928jzmWUachmaJp
	lRtjOt5JVNDyUPQD+r1lUoptEAOShB1KmJUdyyqtCO6FPL8KHoHAe6mXg20uznoU/DEarB3PzzE
	gYgIu8OknF8tufi0vs1xEYKfNNQSzv1tJrfW86RJcq0jJmXdv+3fEQPXAc7ZvncQyXmBXa6owwW
	d9UqJeq4WowIyVNTjS98W0oAdCbSFHxolUKBn8CpVSgXTpjnfJrlxAE9XxMDT20CCyGTBdfTkWz
	tLv5XRrDK2tOeGnSCigaD43I2t3AddvKMSk1I5L2/57e8lSl759ur4yTJ7nRGRVc6yO4s0Eein0
	uuLonIMnvMz/AEA+0fPMZWw==
X-Google-Smtp-Source: AGHT+IEzcHIx5VvRKJa7vTMmQW77VymKl7dWS5EAvgPjCayjuDwj//mTZSHgbw6h1YANjwJF/oLHJQ==
X-Received: by 2002:a05:6512:3ba4:b0:549:b13a:5d7f with SMTP id 2adb3069b0e04-549c39905d3mr7606610e87.41.1742237661377;
        Mon, 17 Mar 2025 11:54:21 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba865024sm1387506e87.123.2025.03.17.11.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 11:54:20 -0700 (PDT)
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
Subject: [PATCH v15 09/11] rust: dma: use `dma::Device` in `CoherentAllocation`
Date: Mon, 17 Mar 2025 20:52:16 +0200
Message-ID: <20250317185345.2608976-10-abdiel.janulgue@gmail.com>
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
index fc66f1764c31..6d7aff6b360a 100644
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


