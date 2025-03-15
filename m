Return-Path: <linux-kernel+bounces-562371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C460EA624D1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 03:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F64016A1DF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 02:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8431F18C01D;
	Sat, 15 Mar 2025 02:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnbTyCqP"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C497195;
	Sat, 15 Mar 2025 02:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742006602; cv=none; b=VnNcUK+H5c6CORdDMWG8uBqQstMkBvUwxM8UcKWUT0CWe/KxaQSFWKRgLSv9yfTPh+vNTG0jTp/46QhaPsUnu6Wi1uc+mPK4tYRCult4anraNBBX0qO5SH3iBSbxPMa5UIlCgZG/CzozZwCX5+LJFq15SpVxRHitRKiNm8JY7EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742006602; c=relaxed/simple;
	bh=+v2Pt//ONosKT8MLepWni5uLUszo5NxXf6D0HgTXmiw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3r1HrERsFKFsufGs9umhaSiV/1zUIy5a2h7YqXqp8bai2fmlcGV9XzCMMrQ0h2Keyye5ohIjPb2asM7ElcmaSqDGFIsMNfmNJVOmbBi+STmA9rYAPuc44fRyN3p+Ki5PtMfH5tzudWZ4RwZipa/NhO3lp4toEF2aNq6y7QT7hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnbTyCqP; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-728a274632eso1544024a34.3;
        Fri, 14 Mar 2025 19:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742006600; x=1742611400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AeYqJbrf6I+8xJpb1fpUMZYL3aN7NPBWHbe8L0cMhR4=;
        b=DnbTyCqPSoZjVHhhd+h+OQJj7HIxbt8aMROZuJKZZi3gVQ0acni3KvefaMVeVrjS7E
         r94oYX7IBHnLRmbeZKFpFd9I8C/Qy5kHKbE3oHc3c8wsQlFr9muxkjZCl0YOhGZb4P1f
         +Ya3F0cYf38zrvdwuluda3ufXRgiuaojtLD7ivmc+cv6srkWcoPOb+ZQIhPkhFSqyHXQ
         hA9ppaQBbhDCsOChDFe2Aruvfu2j2wFDLB7a3hfM/7k1pZtq5h+6EQkM2g/sBbbhMKUe
         qeGfb7/rrMGVccneTmYwcdULubiYS+l0njLUzVABaBpZrPdWOI1JT5bW6BiWDlqEiAv7
         NCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742006600; x=1742611400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AeYqJbrf6I+8xJpb1fpUMZYL3aN7NPBWHbe8L0cMhR4=;
        b=bRAf5xf8kSXAc/QXs9yRxGyTX55Mfm25r5yPP3OjTvSgt8zeIr/MtVReAKrFmSwFVg
         5qIgSHtSJY2AF/jTvzolBBKicImJT64QjcOIEcMDGzMifNaPQF/YHROJzfm+rszFwz3P
         9UDOS80cqHYfcR5OrJKXGVaRQhcVODVINeLJoIiOdrXJ4dNV8P/pLJ49ztq1NaMf/YrY
         psdSyyAmPfhk5ApaJeQ7gZyn1ImNhl3dddN+PiE0xvZ6YGlXTzIjKqQV4rCENCSYQ0hC
         7qtXa8fkAT9kpggZUF9AJwI6wgmA0pVb5sLk2yxC6nBXoPNRAgk8QqVF0kigulRV3PuJ
         zaQg==
X-Forwarded-Encrypted: i=1; AJvYcCU0F8goj0RkjEqe76i/DRSLpoStjrd53S3s/4iqli6Lb9Fx+KOMttKrlqZgz+Y3wl6w4yeOkJjsg77MrwuERA4=@vger.kernel.org, AJvYcCV+90cAozN+SYsLKyKIAoP9gxKtcDTmdoGGIBhgLFlKtS35CPx4om/bCrltloFPX7vjYlOtGq8b0Zc=@vger.kernel.org, AJvYcCVwuLeGmiUmw9Nnu7VS/5HbS+m1DBySAwPy1f6e7DyLz9Iq7XRJhy5fSrXNlKg8I6s+ZBml7GkIzFPsIsnV@vger.kernel.org
X-Gm-Message-State: AOJu0YymCYOpGb52ttlViAjFgQURryxNcqO2ROenp9ocMW6NZmr1HRp8
	1QmQTmpIth2MolPA96uh221o0pFPH6njhvwsEOSV521OlI9ID+mm
X-Gm-Gg: ASbGncs+fYz4ci1QM25PFzbCsbpUBFNq1JVZr4qAPppXYPFM0lMS3ipXccUbOsKs46q
	wLzWWzLqHTE3r3e4HMaM7wywzL9l06493wQUpfW3i88RBJbaazhPQdtctrKEwZsrytRm2K6ICPf
	bgCmybs8rmcoe2GP+nh87BBsH/Kq9YJxDB77f1HaNdG+6focZz4o0+mQwe8giLH8Wb21zb3ET56
	KE3UqPyml+pBNA7xv7gj40UZxXB46yzh+5CJdh4oXq8zMg7PbZGLXIgYGJimQfpKaY6GmoWGkbX
	iKE2frHTmk2VJDJ0YJwTeAEMbJaxgM4Izx/hCO2JXE31e+eDaUodqUpcq6yWL4nwTtQYQY8cbCX
	FV0QfCHGF4+Tn3ug0
X-Google-Smtp-Source: AGHT+IFyEBBnvYzkXYuE6/AMMpI3VNwP3HqbWsB1HV45tb/drP1bhozEjDZ54crecAv68ZJodxXxoQ==
X-Received: by 2002:a05:6830:dc9:b0:72b:872f:efca with SMTP id 46e09a7af769-72bbc5423ddmr3120313a34.27.1742006600316;
        Fri, 14 Mar 2025 19:43:20 -0700 (PDT)
Received: from my-computer.lan (c-73-76-29-249.hsd1.tx.comcast.net. [73.76.29.249])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-72bb26bb82dsm882990a34.32.2025.03.14.19.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 19:43:19 -0700 (PDT)
From: Andrew Ballance <andrewjballance@gmail.com>
To: dakr@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	corbet@lwn.net,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	andrewjballance@gmail.com,
	acourbot@nvidia.com,
	nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH 1/3] rust: alloc: add Vec::truncate method
Date: Fri, 14 Mar 2025 21:42:33 -0500
Message-ID: <20250315024235.5282-2-andrewjballance@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250315024235.5282-1-andrewjballance@gmail.com>
References: <20250315024235.5282-1-andrewjballance@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

implements the equivalent to the std's Vec::truncate
on the kernel's Vec type.

Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
---
 rust/kernel/alloc/kvec.rs | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index ae9d072741ce..75e9feebb81f 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -452,6 +452,42 @@ pub fn reserve(&mut self, additional: usize, flags: Flags) -> Result<(), AllocEr
 
         Ok(())
     }
+
+    /// Shortens the vector, setting the length to `len` and drops the removed values.
+    /// If `len` is greater than or equal to the current length, this does nothing.
+    ///
+    /// This has no effect on the capacity and will not allocate.
+    /// # Examples
+    /// ```
+    /// let mut v = kernel::kvec![1, 2, 3]?;
+    /// v.truncate(1);
+    /// assert_eq!(v.len(), 1);
+    /// assert_eq!(&v, &[1]);
+    ///
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn truncate(&mut self, len: usize) {
+        if len >= self.len() {
+            return;
+        }
+
+        // [new_len, len) is guaranteed to be valid because [0, len) is guaranteed to be valid
+        let drop_range = len..self.len();
+
+        // SAFETY:
+        // we can safely ignore the bounds check because we already did our own check
+        let ptr: *mut [T] = unsafe { self.get_unchecked_mut(drop_range) };
+
+        // SAFETY:
+        // it is safe to shrink the length because the new length is
+        // guaranteed to be less than the old length
+        unsafe { self.set_len(len) };
+
+        // SAFETY:
+        // - the dropped values are valid `T`s
+        // - we are allowed to invalidate [new_len, old_len) because we just changed the len
+        unsafe { ptr::drop_in_place(ptr) };
+    }
 }
 
 impl<T: Clone, A: Allocator> Vec<T, A> {
-- 
2.48.1


