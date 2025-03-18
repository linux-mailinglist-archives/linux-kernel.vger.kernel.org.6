Return-Path: <linux-kernel+bounces-566884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B564EA67DE4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 21:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75C927AD80F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 20:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155982147E6;
	Tue, 18 Mar 2025 20:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyy9uLYk"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E5A21422A;
	Tue, 18 Mar 2025 20:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742328866; cv=none; b=sl4dPq6v2sOiftFOFkeIdyKfvyVzxQ7hgHcAr2evaoEmq5jLXqs1m8Yh4LGTgNZvxMOF+2SldS8pwd1WIpnnStbj8BdAuOJsnpcHndAHgHXqD1yz+hY4uipFdw4k0G8biDqlK9P2S7AJjf+cZzRGnpuiV1dVAR76Y1Xc/pH5YVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742328866; c=relaxed/simple;
	bh=5j8T8fLbwD/lYmKw3WtoojFHPXun1QjbrGOlCZ1Nwsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ujpxcdW6obfxZABgzrZSLk2J858s4ibVE7Bf3jBTSJfpLN38Dw0XJXAMqR/DGmb60cNtXxPHEPlmtrYL0zHdbWUKA/JsHtmfGhWtsXT3txaPsrttYUiqZphOfIGa3Q/9NTJDVkjP/2VhW7Iyq127oAke3aMiaMQqw6+K3ib4Aos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jyy9uLYk; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e904f53151so48165466d6.3;
        Tue, 18 Mar 2025 13:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742328864; x=1742933664; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eu5YGVPzxTPmx7RxIoIVUx7/ZemGARjV+dgoadiAvn4=;
        b=jyy9uLYkqOFw97+mVUx1TtnD1DgJBiTPFVvaUu09tFNw/Oiy2Miobs7X9Mzyz4k1Zr
         dwTIrNCM9flqgblOx5PtoC6aJcugaec4dgy9ktpvoPO5W9K2J3YV4koNTqkx/2nS+slB
         bew2VABi+UQESJ9ECMXMdxWNxqrgfsOoonFHJhu+UArL06ODQOdCI7qai82cZLpfzk70
         c8Y7ZAA2sqM0WgOX8cc5dBUdgJkTC0bRFvg7OLQtmdzf5X+KKI1AsmEg5kW6Ds5E9Z04
         Y4Xy1AGlRzUS4jxT7JVJwRy4/GNlOlDC6j1fwfY22c3Yr4C0Qoquy+dbX1idtJn333ZL
         Kxvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742328864; x=1742933664;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eu5YGVPzxTPmx7RxIoIVUx7/ZemGARjV+dgoadiAvn4=;
        b=tJPiHk8m4Z4mTTjyOJkuLAx9wJzpkFfA/bnj4fgaIbpAl0deFCsyss3gdOTGBvaYwj
         KyTAJhoaDlGHZb8JN4HlbyHjyAaS7QZmyIEKx2bQwYkm2z96uPAxo/5Z35d/Zetwmo2u
         qJfyD3pQN0LJM+VZg/OC9idt6ABeGLmQ8sWbAA8I/S9slXAeS/oCun/JbVi5TvubZ+wh
         xU489LN15secb5usVey8FiO3lq+JQMHBx8RnLO2BEf8G9BE8YrcVEaVlgRwO+2vHWLld
         zZHVjam4t4Q+UF9YOYYnKWa4CgWTzvalajjdn+YqPHSp7ErzrR1LQRcaS5pqcg/PDVCm
         jitg==
X-Forwarded-Encrypted: i=1; AJvYcCUPqzhOvcErb/3OSZZkb+f3r7AEElFIUePC9hgU8iVT97hRGapBPhgEsfBMBT6oNVdW5NQrIlyGLcn3Fiw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg+uaQyybgaEkxgEa4PzjW04HkHlHkZ4CFH7wbZk2lak3WkzMO
	4dglAXGx0vyCAVaRTPfCu2m8m6NuM2JeaOJqP+QzDlLoCgubHzWN
X-Gm-Gg: ASbGnctOiIyOwP7H7I19i1oFurV4o9aVugf2+Q0e40cGlOvu2AyT4lS1k7oGz8Df4an
	YVJOJVv13KWqGMIsm8AqqxT413o+LDQiUN0m/ga0xBcJST7Vf4wGu+SVe9p5wvx/nMN6GP9XA8M
	Lkhih5FvsSVaPG7+gLE5xLcMbzIofenqhF4FFi1QGQZV6E4bzokJ4QCxFe8ipLFgLRH78RsA+s0
	b5h0ynGIqhSIHPCZwDnO0/CMke43qAXERqJIVWM3Y+GNt1PhXSLgRDhP42gnEFASA/d+1dyAZYZ
	0LIPOM3NklX1m4zaoPga5WRuiUJ9XVnUm5poTGo3dlnUaPhwSKLE5hqrKd6SRJRC+RFQ
X-Google-Smtp-Source: AGHT+IF5HMBrmpCRvADAPabd+SHnZF9gFvMFpSy+kXHGIuXkWZrA76UwPEqMrAbNFAMIrTmOdwLK7w==
X-Received: by 2002:a05:6214:d46:b0:6ea:d604:9e5b with SMTP id 6a1803df08f44-6eb29279e79mr2548976d6.2.1742328863565;
        Tue, 18 Mar 2025 13:14:23 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([2620:10d:c091:600::1:e903])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade209335sm71301046d6.22.2025.03.18.13.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 13:14:22 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 18 Mar 2025 16:13:55 -0400
Subject: [PATCH v2 3/4] rust: alloc: refactor `Vec::truncate` using
 `dec_len`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-vec-set-len-v2-3-293d55f82d18@gmail.com>
References: <20250318-vec-set-len-v2-0-293d55f82d18@gmail.com>
In-Reply-To: <20250318-vec-set-len-v2-0-293d55f82d18@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>, 
 Andrew Ballance <andrewjballance@gmail.com>, 
 Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Use `checked_sub` to satisfy the safety requirements of `dec_len` and
replace nearly the whole body of `truncate` with a call to `dec_len`.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/alloc/kvec.rs | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index 97cc5ab11e2a..6f4dc89ef7f8 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -489,25 +489,18 @@ pub fn reserve(&mut self, additional: usize, flags: Flags) -> Result<(), AllocEr
     /// # Ok::<(), Error>(())
     /// ```
     pub fn truncate(&mut self, len: usize) {
-        if len >= self.len() {
-            return;
+        match self.len().checked_sub(len) {
+            None => {}
+            Some(count) => {
+                // SAFETY: `count` is `self.len() - len` so it is guaranteed to be less than or
+                // equal to `self.len()`.
+                let tail = unsafe { self.dec_len(count) };
+
+                // SAFETY: the contract of `dec_len` guarantees that the elements in `tail` are
+                // valid elements whose ownership has been transferred to the caller.
+                unsafe { ptr::drop_in_place(ptr) };
+            }
         }
-
-        let drop_range = len..self.len();
-
-        // SAFETY: `drop_range` is a subrange of `[0, len)` by the bounds check above.
-        let ptr: *mut [T] = unsafe { self.get_unchecked_mut(drop_range) };
-
-        // SAFETY:
-        // - this will always shrink the vector because of the above bounds check
-        // - [`new_len`, `self.len`) will be dropped through the call to `drop_in_place` below
-        unsafe { self.set_len(len) };
-
-        // SAFETY:
-        // - the dropped values are valid `T`s by the type invariant
-        // - we are allowed to invalidate [`new_len`, `old_len`) because we just changed the
-        //   len, therefore we have exclusive access to [`new_len`, `old_len`)
-        unsafe { ptr::drop_in_place(ptr) };
     }
 }
 

-- 
2.48.1


