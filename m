Return-Path: <linux-kernel+bounces-562979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD9DA6354A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 12:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47F0D1891562
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 11:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642911A3AB8;
	Sun, 16 Mar 2025 11:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxGnJ+kH"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4930510F2;
	Sun, 16 Mar 2025 11:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742123841; cv=none; b=Ghw7EW5jfBBs+JWh6AUEawIHQzKF8IS61cpGx5PwUOGKhXe/qioI5U8bYDNhHozWUBhQO9Ll1tNV3p4ZsQ61PWB9Ovs4ull9IiYzv/C44quOaTg5UvO9GSaHCiXlgHKZ7qyIok6ImRfMKzKOMot6WYme6aXXofaZMuJjOvBGZ3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742123841; c=relaxed/simple;
	bh=o+vu+aWqwGxzBzz8KVW/4xMrqYpsXTf4IdNOLJjmvS4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=slAyDy9XQj/LXsxZSIos4WpEANdsT2JM/RDCvobEB2Atg/NBpsYcZnAh3cti32mVHfwEVD0mOi1Le1Jj4YpJIZV/iMLTTERnTJhqQiAH4tplAYDuRqvJPYi46iVS+fzloqZjmXDey58qhxCkISqVZDbyp2lcXU8mrIJxV2y9EO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxGnJ+kH; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5fe944b3fa0so1565894eaf.0;
        Sun, 16 Mar 2025 04:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742123838; x=1742728638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rG31lQCRCRFDdqfRdvTtPaHQMIPvTMGOzZjBUIipjbU=;
        b=LxGnJ+kHSzEZEqOu074hHArBa42AYkBoSCXFyOqnrgIBoPDyQ4ZeCYvPS6Buyqp26I
         g1SAL7c1dhnbKaJNZ48IT0c9jC4k9aBpr008AXFJWQX6Z4HQccilMj6i1WEqU+WS45tq
         LO36Ms+uUeQSSSoXWtmNMV2GZs7DCRHWD4JyVXLZkStas0ET61mWwET/E5mCvPt/IWIy
         EQ4rksHGsA+19gugOLZFqWpPcck6ceqQq17occtZvP3zRbcH0AC2i+0XogT7gAe0/7hj
         GZ5tAufkOSQyY6gpKShqVsAucLqHaGihF4LBdisT4RFK1kQ/UvWkPoTbATn+3tm6mtwk
         JfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742123838; x=1742728638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rG31lQCRCRFDdqfRdvTtPaHQMIPvTMGOzZjBUIipjbU=;
        b=l17XvVh12oOdBtZ6m0kWHZA2y/jqlyLRNvBb5xSvLfmfb56maUXHzfx4pXmlhcq9fb
         /2BUuFUNW7JDws+mw77yWnPIWnsH3fd5v9imCNwoxQwc0VfnEmQBrIpILZ+WLQvKX2BP
         tt5GOJ0xI4GXJhaj9/L97IHaA0+0X/cFPNpfsaSuhVZfZM6z6uUH5KECHsEO7Sg3/NQX
         r+jrtEk/nEQB6PDKQpzL/3otErfQJQOtcoGrX8zNwWQEmbCtvPvugBJK0hQCylHwpd3H
         AQhacXgK4M972p+u8dgN5M4JcYeEvSK8/oNkywyGoK7dIOELkkvAnFFtK3+iWiqzkj/3
         ClWA==
X-Forwarded-Encrypted: i=1; AJvYcCVz69yUxqGxgx+SkfNsGR8CT2xlmpWHMpEBXl9iyIc+zNviN+iD34N4YQd9Yor6j0mtG4fYeIkbOl8pMCvlq5o=@vger.kernel.org, AJvYcCXMhHAIV7JLtswXqZRlwFGqCpJb1qN7Tx8l6nowXzO5rANftGdHHcY4YLr7ndXuvR5wClh6p+pHyf60qrqO@vger.kernel.org, AJvYcCXt5wnGOGddERK5yzWgETHb74c900t+P+XRPr2h7Tdv5e/Kk4oo4ANNkHje8+tzMFcgNwf0voBZb0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5qi26Ndn3UXE2/JmtKcCHXaRDNA/w2pinwwobLf+lRwH0Qsi1
	sXe677C4MDSMLjPIw4CesoI0s2ePwVdKxcLZYrKq/YUGSEjWdrQ4
X-Gm-Gg: ASbGnctTt/HhZ3D2amCcoZLBTzGO8IALmjGtKd9stc/uq9pmQUV51pKe94gTd9x+d3O
	D9C0rpLwrdixYZwSrYXc6+1+UfhChgW/wQx/eARDk7WvgbMC/eVVjRo/dXGN5SWQfQbv8bgHdL2
	WQH7Nl/ID3Y7l41+uaYnd2It4ha8VJEdLrEGcv7Kjov5UO6q38kXnDjNRnk0iHjoj+HArfiCUiH
	EmVNtyV5Cb30k23B+SMO34FAagFKzrqsWyZ4u4dE/0ZpJaal8JhVwGral5ewsUmUHgJHom2MIa9
	xKBFMQL68sOLrLPDTXz32UyLXlrk04JZVLkcJLAPOdmliV6cx42D0/L5x5FI/w3sEbME235oLXy
	lojDmyo/VWdbGHFjsQoZ7pywZ2x0=
X-Google-Smtp-Source: AGHT+IGXuZj7CrskJpVU66WVbrVD3w1oJfKPbLyD5/hTVj8h9n+BL/mvcQD3fQGQ0RBjIV8G4AgMVA==
X-Received: by 2002:a05:6808:3849:b0:3f9:aeb6:8621 with SMTP id 5614622812f47-3fdee2791bamr4613083b6e.3.1742123838137;
        Sun, 16 Mar 2025 04:17:18 -0700 (PDT)
Received: from my-computer.lan (c-73-76-29-249.hsd1.tx.comcast.net. [73.76.29.249])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3fe832ce015sm715978b6e.7.2025.03.16.04.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 04:17:17 -0700 (PDT)
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
Subject: [PATCH v2 1/3] rust: alloc: add Vec::truncate method
Date: Sun, 16 Mar 2025 06:16:42 -0500
Message-ID: <20250316111644.154602-2-andrewjballance@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250316111644.154602-1-andrewjballance@gmail.com>
References: <20250316111644.154602-1-andrewjballance@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

implement the equivalent to the std's Vec::truncate
on the kernel's Vec type.

Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
---
 rust/kernel/alloc/kvec.rs | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index ae9d072741ce..18bcc59f0b38 100644
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
+    ///
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
+        let drop_range = len..self.len();
+
+        // SAFETY: `drop_range` is a subrange of `[0, len)` by the bounds check above.
+        let ptr: *mut [T] = unsafe { self.get_unchecked_mut(drop_range) };
+
+        // SAFETY:
+        // - this will always shrink the vector because of the above bounds check
+        // - [`new_len`, `self.len`) will be dropped through the call to `drop_in_place` below
+        unsafe { self.set_len(len) };
+
+        // SAFETY:
+        // - the dropped values are valid `T`s by the type invariant
+        // - we are allowed to invalidate [`new_len`, `old_len`) because we just changed the
+        //   len, therefore we have exclusive access to [`new_len`, `old_len`)
+        unsafe { ptr::drop_in_place(ptr) };
+    }
 }
 
 impl<T: Clone, A: Allocator> Vec<T, A> {
-- 
2.48.1


