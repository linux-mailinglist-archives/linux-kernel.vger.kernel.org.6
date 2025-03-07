Return-Path: <linux-kernel+bounces-550950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7016EA56652
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D4653AF13E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B541216E35;
	Fri,  7 Mar 2025 11:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/OCaOPh"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5EB217648;
	Fri,  7 Mar 2025 11:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741345733; cv=none; b=gz/y8ogN23pEWt/+h+vl1wngrIrXG5w8Oy5iD5tUPTsQ6I/TON3Q6K8f0OYKEP+JvCBIYeo6Y4Ad3Y+3Nbc6/5ML3DFMJyE0zz3Y7iamsV/Xmwb/EL//xBDcjSWyN7NnDSGVTpVnkfAIu8M3JF9OTXUqZz0zwqgjC1Uy6T2uXQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741345733; c=relaxed/simple;
	bh=rrOOzkjgFH92AX8ZIQzQ3stuSFWy3mIsSfUxBAk5e5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CnrHL1o7mo9R3+v1g2/jUSp5SjFgu8AFK3ZRIM71UXVwpIeu8/M3uGFH5vwkHqzNnuXVmGjCnEYSVaE5pT56FDQ/p57oOShck1ejhiAywmgSsCZ2syAfvx7U1O6ixRKJFN2b2hLhf2eURfKBAGmkOtvRxRSFLWlh4iGGMA+Q3MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/OCaOPh; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5452c29bacfso1872760e87.3;
        Fri, 07 Mar 2025 03:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741345730; x=1741950530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09GJYTVzja13f3kvBaJ1uBzOOCE24NR3g3J/ynL3xcg=;
        b=k/OCaOPhqgOeAnqEOeg1E5GO59tdtGZ1UXEpaOV2Tpj1JzkdUJQ7K930mGKKRe5kcv
         VK7xE1TpVQdv0QWnxF6URNeO7DFhWNGym7lEo8JpCelOq4Uq23RazEliz4W+Bd8TWwza
         eIAS6PNAAc2NBP5RM7FRHxfYBkE6oHmso0RmLfc9WzVJH8f5fn5dj1+OR+wf8eIyUKtu
         nDeoyWgtAoWMeJKuAIPLYBWtCWokLuHQfHd1j7F1iTL1edYEkXKG8wYrjV+v/1+Sp8yO
         cIH6U5PcFzJjZ2zKBUOQKsDW03tuf+BbuCAD5J6qTovo+2gb1wyxFAN+/tmaeXXTMwTQ
         lLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741345730; x=1741950530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09GJYTVzja13f3kvBaJ1uBzOOCE24NR3g3J/ynL3xcg=;
        b=Lu4AyQmSpVvE7EwO5kEMzRQ48YZggGGQO5/MTVMTOtBO/QwZDLll3xKSiOLdJQbf0+
         7ApLB16dbD40UrT3+oRJ/PJ80LK7ClWgTvdqHGeCuClP3TvPvwOGECbCZQK6vTUkMeX0
         rbfMBJ8DBUU7slYymndcJr7No2r7XnAGPGDwlQkScupVdwGTdx3RRvmV0jLl8mrPzG2j
         ee+GuTzpZ51/4EJZoSTht3aEJhdIjcrvVVyb2FmT+6KiGuWKy4wNQdlv43CZAdvWlxkJ
         7p9Ug+YnzsFOr1pOnUC1ejhiGeopkiAWNkRIBZChYSAM4//jdKDf9Qdkg0jh/5jsdbci
         fT2g==
X-Forwarded-Encrypted: i=1; AJvYcCX7/9+gOefbSMIEPVy1an3s4DG7GMNCyjFxo6zqpClCc8G4R3edew1Vz/WUi+Q8aLOLIYMWyDPD0qDjZPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR3ptBGyvA+9aknvHXn/pknu9KHAHmQaahgagwLEGfhosR5LKp
	TH7ZJODlPNIvIMd/MMIIE3Sy3hAU2BvpFIw5z53HHj8DDP/nYAJA/jFlvQ==
X-Gm-Gg: ASbGncsDdP+8GYCuQ5aY6g8aVcDq4RItYzIID6TyES/nSglxHYLDKHWWivnHUNdNGhq
	/pBp7IoNdmlkGoL9FsfziSK6oBmgnN2WyRWnwixX9tDu83zAUyt6YzV6MIQuido5+ssmi9dGagD
	abgeLJ9AwHq47pyP1DfMYxmiZDocZJGi24uxK8ZqUNTKj1RUZNYL8QT6e76c4AJBiDDXnVWipEx
	SR3DSb3Tph16g4xT+aQ6SX1XjM2vflX+d1VoJRg5FdyV5XzAJcL5YSvFGl4laLzB/SMAARkDhFR
	BByyvaZwOhA77SnRKVkKs8GXANMID4+sZAsXgOZeOX0DWxhswuXN2ooUVraYC+udOhWsvDyuQP7
	fT4q5R3hGVpd52QtM6Fc/jA==
X-Google-Smtp-Source: AGHT+IGdooSiaMhwC//4GREgXUoEIs+EBOffQpNGTyIYeDlunWJEPmlHzlIklF2/tY9bs8/u3NaQHQ==
X-Received: by 2002:a05:6512:159a:b0:549:5c5f:c0c0 with SMTP id 2adb3069b0e04-54990eaca02mr905585e87.41.1741345729577;
        Fri, 07 Mar 2025 03:08:49 -0800 (PST)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b1c2a08sm448920e87.223.2025.03.07.03.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 03:08:48 -0800 (PST)
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
Subject: [PATCH v13 7/7] rust: dma: add as_slice/write functions for CoherentAllocation
Date: Fri,  7 Mar 2025 13:06:24 +0200
Message-ID: <20250307110821.1703422-8-abdiel.janulgue@gmail.com>
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

Add unsafe accessors for the region for reading or writing large
blocks of data.

Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/kernel/dma.rs | 86 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 8a250242641c..cee7adc2fc22 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -213,6 +213,92 @@ pub fn dma_handle(&self) -> bindings::dma_addr_t {
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
+    /// Performs the same functionality as [`as_slice`], except that a mutable slice is returned.
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


