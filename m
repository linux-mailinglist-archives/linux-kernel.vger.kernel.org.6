Return-Path: <linux-kernel+bounces-302887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C859604B3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37DAD1F23AC7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08C9197A95;
	Tue, 27 Aug 2024 08:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ablnBGjz"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077B618BC0B
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 08:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724748174; cv=none; b=YHv5JJosXM7ypFG6be0xSsp1XVxYTwpH0VnDJpBW0ghq4Aa4Or27s/AMQ1vEqO8xqGtpJcrzQC4zY0nXzeMcuq10xiYqNeRgwxN6rF5gqHmFC5FRQaiN1dhC+nM8Uj/PhjidNMcNjWxUUwvc5ohW8wv+ZiCvmVDMwtleLqCmFF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724748174; c=relaxed/simple;
	bh=nSPV8Vu2jTB+1mmMsBZsTzuk8kyInlVIoqksoRkFqFI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=f98ONkB95QjWDpfPrbAD8x54Tvhs4kP0Fjx4/OJFy7DJiyPx12H6RYhJuTOjhdUOhQCvVwgs1P3b81iNKQ8e8thCAZTWcxTPhqX4AGYD0fNtpRgpa5LOcp/gIvH25694zdKGJ9NDQEaGBNzAKTzfh2c/Bmi0g0zpTjxI1HR0KEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ablnBGjz; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-42808685ef0so48835295e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 01:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724748171; x=1725352971; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q4GWtWFEo5xKDMIEdChm0qMn4JHq45UYY4/Y5VkFNFQ=;
        b=ablnBGjzIN5feNPdcrUVjz6+AbUEv7WuYWq7N1u1eVthaXWTrzc6CxFWJUNCNthONe
         DayYLtqp+pK02Rtjjb6J86iSF2Vh070hp3woY2FpP7rYB0w89e7kdiZ4zWH0wd+k2hvt
         C5b36A0Cc6NY1ro/BrkPfaagCLc9QVEv53kNdY07u0jrdfSqZd7f/Tewt8AQBsKhX0Kt
         pxvcMIUKl5k+bPUryzaIsWQ1F0I+2awh+sBHBxAECYFPwkTVZH7mBxsdVTtV+SnvMkf+
         wtTfR7o9CR/RQrTc9+C78m61NLk4STAYgxpJeCa7SPELMBRyAd//vUW7PH5cCajVIX+w
         lthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724748171; x=1725352971;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q4GWtWFEo5xKDMIEdChm0qMn4JHq45UYY4/Y5VkFNFQ=;
        b=X4N4qO58/lzRhz7YNNlq20yaCak9BeOlg6KXxbwcu/wNcNUPp3xGtVhjswRl4nKBuz
         xGr3mmyALNyIoig1laAAr79bK4aKWlRUR21LJ/OCjPEID/azbhabAjjjpC0zPGslL069
         jy0MWbswuoLt/qooIDCJc/spUvsiewPwhJD6tKDmDCTGbEBuN1lGdc2Ej+oWpwBCH2YP
         adVN0C3S64EwftZifiQ9QaMjN2mhM1AV8G+yZHWKRbWG9ZZEdigNA7QTWA6dOJiy4PjQ
         o8eJDnoZP9FEoHGPyjWqWnayQdn62zkWEuxQWvbgmzwCtkdIAPzsWDczWADvrORUXK+d
         CDVg==
X-Forwarded-Encrypted: i=1; AJvYcCX4reqyNCJcbbZgigpWmSPhjbVSbY4O9qVTwR9UpNKAq4Pyfu41qd1gTVJUM4a0xulYPPJw/ACH3WR9JXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1vYthEedi1DXiFgtat7lHYRMZ83rIVqcODrtyv+x9vobMEFE5
	G1Ny3W3SSKlcuLrrdjgf1sbVM2q/0+B+zCY2ywYE3jXEOs9Dz70gumZL3MGutg4bRWlZKTC3xCL
	OcaG2/AYlEr914g==
X-Google-Smtp-Source: AGHT+IGtuMWRFNMgruIuVgXWhTXoVRgKsYTIKD0MW7aN7lQ7+wOBVE2iuGi7hjC9C4W7axsMuYSuGkQ7WUnU+y0=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:600c:2296:b0:426:4920:2857 with SMTP
 id 5b1f17b1804b1-42b9ae488b8mr363105e9.8.1724748170994; Tue, 27 Aug 2024
 01:42:50 -0700 (PDT)
Date: Tue, 27 Aug 2024 08:41:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFORzWYC/3XMQQ7CIBCF4as0sxbDIGLjynuYLhCndBJbGsCmp
 uHuYvcu/5e8b4NEkSnBtdkg0sKJw1RDHRpwg508CX7WBiWVlq0yImWb2YnxnWkVVj+UakmSsRb qZY7U87pz9672wCmH+Nn1BX/rH2hBgcKiJrrg2WB/uvkQ/IuOLozQlVK+Z4nwjKkAAAA=
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4940; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=nSPV8Vu2jTB+1mmMsBZsTzuk8kyInlVIoqksoRkFqFI=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmzZFifK//EYvvrWTQRp/UE7hxakMy1RJ9fhhsC
 lVBjXBsQT+JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZs2RYgAKCRAEWL7uWMY5
 Rt7bEACpo02sg0YeTDjP0UsYtbHLcanhyxMRMedx/+3tJvSDM+yBLJOv3aFVyIGrwoM5A8r8uzs
 4AZ2qs7Mycfk1ndBvsQStiuftFtUaQNiaJPzLjwnFEbKFg8WgPhyGsUekHMWrsoV3WjS7W+Xkh5
 9mTD3D0ZTWRlsxFi6NGmfSSl+ivCSArMNQuFHOwS4ZvHayBMqBbQiO3HZg7SyqbbQVb/WrH/JRO
 a8vaDwXE2Zcxi/7rbafDP6+EqXKlB3V1/WkQGgjCEABdK/xMV3E6jyZXpqLSprzGVuPqO/jA/Ts
 HS3b3NNVMsK9Pi1Y9ctDXMbSgmfqqFt/J6o2Ks2z8Hbga+wFFOEZwBQtgs+oGajb66UjxfqFrD8
 Iq+qgxUokKOYxsMx5EuTCA9lD+rHbKTR1EgMZ1wlpRFzAXGXx0J0tAFZNFxfBF6QhikjlMfCuww
 ee/kWmg+3+zkNlFPt1FGdK40LWXa4Ycxz7Cznji/Bwy9rd7cavubQiwbTbwyrvgmGo0r1nzsa5x
 XJyJhWRZ+OgktCBzzRF1fzwT35AWNbO1ntihUWtQo6Jk0jVuW3+PjMsza4s3zm6stggRO1FJIKF
 5noaSsScj/hjJgRZjMX9ooBMNpimg/aHItAVU2yAcy/yKzZrq79/GHYVQUUeIihlypxivzn1Ieq It1lmXeNZ9E7dag==
X-Mailer: b4 0.13.0
Message-ID: <20240827-static-mutex-v2-1-17fc32b20332@google.com>
Subject: [PATCH v2] rust: add global lock support
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

We don't currently have any support for global locks in Rust, however
they are very useful and I have needed to work around this limitation
several times. My workarounds generally involve initializing the mutex
in the module's init function, and this workaround is reflected here.

Due to the initialization requirement, constructing a global mutex is
unsafe with the current approach. In the future, it would be really nice
to support global mutexes that don't need to be initialized, which would
make them safe. Unfortunately, this is not possible today because
bindgen refuses to expose __ARCH_SPIN_LOCK_UNLOCKED to Rust as a
compile-time constant. It just generates an `extern "C"` global
reference instead.

On most architectures, we could initialize the lock to just contain all
zeros. A possible improvement would be to create a Kconfig constant
that is set whenever the current architecture uses all zeros for the
initializer and have `unsafe_const_init` be a no-op on those
architectures. We could also provide a safe const initializer that is
only available when that Kconfig option is set.

For architectures that don't use all-zeros for the unlocked case, we
will most likely have to hard-code the correct representation on the
Rust side.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v2:
- Require `self: Pin<&Self>` and recommend `Pin::static_ref`.
- Other doc improvements including new example.
- Link to v1: https://lore.kernel.org/r/20240826-static-mutex-v1-1-a14ee71561f3@google.com
---
 rust/kernel/sync/lock.rs | 64 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index f6c34ca4d819..cfc5e160d78c 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -7,7 +7,7 @@
 
 use super::LockClassKey;
 use crate::{init::PinInit, pin_init, str::CStr, types::Opaque, types::ScopeGuard};
-use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinned};
+use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinned, pin::Pin};
 use macros::pin_data;
 
 pub mod mutex;
@@ -117,6 +117,68 @@ pub fn new(t: T, name: &'static CStr, key: &'static LockClassKey) -> impl PinIni
             }),
         })
     }
+
+    /// Create a global lock that has not yet been initialized.
+    ///
+    /// Since global locks is not yet fully supported, this method implements global locks by
+    /// requiring you to initialize them before you start using it. Usually this is best done in
+    /// the module's init function.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::sync::Mutex;
+    ///
+    /// // SAFETY: We initialize the mutex before first use.
+    /// static MY_MUTEX: Mutex<()> = unsafe { Mutex::unsafe_const_new(()) };
+    ///
+    /// // For the sake of this example, assume that this is the module initializer.
+    /// fn module_init() {
+    ///     // SAFETY:
+    ///     // * `MY_MUTEX` was created using `unsafe_const_new`.
+    ///     // * This call is in the module initializer, which doesn't runs more than once.
+    ///     unsafe {
+    ///         core::pin::Pin::static_ref(&MY_MUTEX)
+    ///             .unsafe_const_init(kernel::c_str!("MY_MUTEX"), kernel::static_lock_class!())
+    ///     };
+    /// }
+    /// ```
+    ///
+    /// # Safety
+    ///
+    /// You must call [`unsafe_const_init`] before calling any other method on this lock.
+    ///
+    /// [`unsafe_const_init`]: Self::unsafe_const_init
+    pub const unsafe fn unsafe_const_new(t: T) -> Self {
+        Self {
+            data: UnsafeCell::new(t),
+            state: Opaque::uninit(),
+            _pin: PhantomPinned,
+        }
+    }
+
+    /// Initialize a global lock.
+    ///
+    /// When using this to initialize a `static` lock, you can use [`Pin::static_ref`] to construct
+    /// the pinned reference.
+    ///
+    /// See the docs for [`unsafe_const_new`] for examples.
+    ///
+    /// # Safety
+    ///
+    /// * This lock must have been created with [`unsafe_const_new`].
+    /// * This method must not be called more than once on a given lock.
+    ///
+    /// [`unsafe_const_new`]: Self::unsafe_const_new
+    pub unsafe fn unsafe_const_init(
+        self: Pin<&Self>,
+        name: &'static CStr,
+        key: &'static LockClassKey,
+    ) {
+        // SAFETY: The pointer to `state` is valid for the duration of this call, and both `name`
+        // and `key` are valid indefinitely.
+        unsafe { B::init(self.state.get(), name.as_char_ptr(), key.as_ptr()) }
+    }
 }
 
 impl<T: ?Sized, B: Backend> Lock<T, B> {

---
base-commit: b204bbc53f958fc3119d63bf2cda5a526e7267a4
change-id: 20240826-static-mutex-a4b228e0e6aa

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


