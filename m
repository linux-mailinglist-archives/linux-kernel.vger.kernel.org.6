Return-Path: <linux-kernel+bounces-564944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3141A65D59
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 160971892A1A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384E1204F9B;
	Mon, 17 Mar 2025 18:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5+e/fmk"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44E41E832B;
	Mon, 17 Mar 2025 18:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742237669; cv=none; b=FIbZe+GmGmVYHBPEcHiwKOhFsK/PymrSYo4v/aZ3qEHK+29UBy8GRCAgmwwTzB5a0cAw+IkWN5k5VHoLaH/+zmT+WSWVwLfnG+qhtck39Q7bFU+JBh0jf31i5fhEiFq1jXHMS2vyCPK9wb0e7Rn6b0p04g3fiqVINN/50O4jing=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742237669; c=relaxed/simple;
	bh=/7wFbnKC/IXue+Ku51P5u/UhRTtbHQI319bGUuW1U8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NAimXsrBbkGU8c7AxUBpQHB9D9T5Hlh3ZcJGk2NkOZYYbEDq5lv7sxjwh/Gd9eNDORCyCucatilbqTqzdv0JEzZWGtfd7CVqRerlkuRUzeEBsKNeZNWyVT1UvL7j2qD4A40SBW9h/81GJz1rp+xKTnt5mXG9dc4+xTqRcQDhtQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5+e/fmk; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-549b116321aso5300856e87.3;
        Mon, 17 Mar 2025 11:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742237666; x=1742842466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTtaX3vhSb5G36KvfqVCTP+WKBznUgLh6K0dIke/e54=;
        b=J5+e/fmkOSVU+T4HzOW9dyGFEOzjurwdS0edfUpXoqPd6nV2G7rvYA9/GlteVZDrqc
         KTa/BeVmijlJI07nYMHEWbb+MnE8h9odEmL+H4iZT7K2RC0jzyEGXJsLiR2qq20SNURN
         wlH0LavVhDATL51fYz/ARfcLuLd4Rkmd+TB5CzvRY6DYG1tvs1GxgdeTf6bVbCKsLV3S
         G4VXu5cmzzpEzQqgZDjp6GfYCeScvMAkp303CQvhwqwJ4lbcKbNqclE1kx5SYqNodO8Q
         o1p8VFaw9HEjav8Vw5YUEz/AvEHxc1qGJehJuT9SqgEOz//laVNsNtudbyCyM3Mmco9h
         zt8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742237666; x=1742842466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTtaX3vhSb5G36KvfqVCTP+WKBznUgLh6K0dIke/e54=;
        b=fMi2l3u9Y26HRX44V47lTWsVYr0KN1x9y+Ets/eNRVcZXXhxQAXZGkREHpbFfyHw3k
         LAUHVAUQIf/gQ9Cvio60s5B3nP1ofT+rXXcXV7DbjQ6uTnB5QgnOC2YZ1fCQg/NBMEoz
         r53lUQJLAzAxbo4d/Uq0nU5z4WSZd9UPeKgzPsmbnxKkC7faNPtYBsMOFTYVv+FH/lFF
         WZWcSH5Z5yx4NfRND9XqYXS4A/k2clu1I60cTl9+E5cuLZowvazWqMYXTQljv09G0svV
         uT5XoWhC//pnZej6Ozb3k1YUViG3D7StOf1tYEcaQpJZ3wBd6wmzUepPALcLxXHkLNH+
         TLiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjU3WR5BK12noK7AbeRjcZ5hCUd4luBuIgtW0p91Kev2FtupJ29wngQ2cQxRTDsGGYGpYaWNgB80NPDL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt4uUdBM7CWEWmSCXduSeq9uY/cRSIZtmGz9WuPyJD4y/mo0Ga
	pECwZ9W/o/Bw6/vBgqcaNVTlgEFPiJ7HXuNSi4OIKBr9deMhpKNvCzLXGA==
X-Gm-Gg: ASbGncuqbXTyimNfXukPITL72Maq1lgSRsZgJhfewZXo124Wr2aig4CO6+tzANWeIMy
	Qhl2hE3I0vVBY4Xsspai4wjbwByToUoE4Gs+1aZlpPlBijvYJ2xDch7vKjv3NEiYrpNH4IkjhWq
	p9ruyg/3iso9qcfvJrkoRHNCuUIyTVMF0YAFd0K99NZU80PNQ9Mu9jthVw9S6IvEUe+TLyYz2ke
	ylgyblCId8Yz7/PhHH/pt7TyWssPFCEyFvhPtXPYLINJABuvk9rMV/RLrNVyOLPCP7jb2nQoATW
	B8A4gnYwIToofblUNEMtsaUIMoiGkL6lq/dhrKi4xfUzF6OHtwnj08/ycJSTtiUAGB1ttN+10Hp
	73dloUn5bjpueLMThyApYVblyy85u25n4
X-Google-Smtp-Source: AGHT+IFLi8eIWmNCR26IQ1ZzNqzF+yX5evRGaLB3kNs6XdGjVB80bX12ukMhk1Sq94RJg91f1Bo3PQ==
X-Received: by 2002:a05:6512:31c3:b0:549:8f06:8225 with SMTP id 2adb3069b0e04-549c39507ebmr7288403e87.53.1742237665546;
        Mon, 17 Mar 2025 11:54:25 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba865024sm1387506e87.123.2025.03.17.11.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 11:54:24 -0700 (PDT)
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
Subject: [PATCH v15 11/11] rust: dma: add as_slice/write functions for CoherentAllocation
Date: Mon, 17 Mar 2025 20:52:18 +0200
Message-ID: <20250317185345.2608976-12-abdiel.janulgue@gmail.com>
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

Add unsafe accessors for the region for reading or writing large
blocks of data.

Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/kernel/dma.rs | 87 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 6d7aff6b360a..027ef75a461a 100644
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


