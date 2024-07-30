Return-Path: <linux-kernel+bounces-267558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 962EB9412C9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3B7C1C22A47
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD2919E83D;
	Tue, 30 Jul 2024 13:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kybJt7r8"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584271EEE6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 13:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722344800; cv=none; b=QIQxyKuv7q152zdpcTF/F3YQ6G1u88vs/+Pyd77+DmI6Tp9B0WiuAaLni0KAGHFpiIvq+4F2I51fa7VejZQrFBlZlHwTYjMLIrBnzrzNp19Pf2AKVBiDEpd5++y/rWA2S2u5qSABePncAnjNpvTJ9gTe3FMcCDEc4ZAPSGUPHAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722344800; c=relaxed/simple;
	bh=jEounkARTWSXuP9TGoR+2S+iU6PCZFgHt6WY+kyo3Tg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iydIP+/fLYpCcohObT4Eaas3Z6XFNQPC73msAdrKd74cZtaK7UjtlSmtwXU982+Uk5u3hTof519HWTVGIUchCM0VXLaX1TB4FxMvNtqBLqsQ/pqN+pbW1q7NHfG6jY0A7uDlkMZvX2GxR9tStygAPC5weNFIIzxOTZrp76n5rI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kybJt7r8; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e035f7b5976so9313200276.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 06:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722344798; x=1722949598; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LpK9lTVBIoGCidPfD5yJsiZKmR1svodGEUYQV6xMuaU=;
        b=kybJt7r8H8E96x0H9WiDTicUI+oAFTwdEgtv5I82U2VWP61pRUTwp/5f339EeRVNf5
         +Xc1xXQxZIqByqvOgzW6x1hb82RfmJytTCJo1H026ApSWPfLFRDXSRyA1eeKhGwRkYuQ
         kIlNrediDKInfu6YZd29NeMcoqr1EVOp0m9cT4pNe0jcAD1cXG0AMdpNudXtnzfYhyw4
         ptwoZ/QWZ8uWhod73qALT+bnbB9Tt+AC2J4doJe6K7R0Z9RYY8hC8jaeLbSluzXIHpy0
         LHLq8qo+747Ix8lO1RYDPomupMfIfBoZ+vO6uWFhIpFeMcHZtSQCNOhRdOSg6+MlBUi7
         mobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722344798; x=1722949598;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LpK9lTVBIoGCidPfD5yJsiZKmR1svodGEUYQV6xMuaU=;
        b=LXOSkn6uz3/TdUXXUxGm76c3mUQ8KVhpnMx0jtAyJ6UTra0XTA3Fwr5s0oX1qSmEUG
         KVX2/84INDlwZ0adUdYr2eUcpsNSzqRNbseey4o3baYtCyUpQhTklVptM9MVR56QeKGS
         ytqlsKLrGw2mWYzLh0trqdentSuorFnxps72w1g1D5wIE6vOwA7SJoDL38wsRV6FbWVy
         X/itr2O1y421MjDtDbm222q/bhHTWPnFbJQyTpa0U/CCNr5Otaz/WJBd8xR3Q+goQuuQ
         DkbcDZugZquFyL1H5wtEPRPQdNSYcea06hcPzzzozXFCgc7W7gcCfbZvj4V5/V6AD3r2
         bnRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQhO6Vx9kSdy4q2kaeeh3E7jCB7fWdCnVaJYGN5FwjHekgvanyHGbmnkti/KtaTogxWRkEC7/mxZScSCMTZUbxPVwtT0BdRSbk03CH
X-Gm-Message-State: AOJu0YwvEx6OMsjYdT+BCHKyD3DjBo4s6/lmD9RHtrkaZ9PnbeRrGE07
	Ex7nY2qKmZathpdk0WF3Pe4ma2FP1elHIbOfUjlQENcl3sWZbxM/4y+pLjGvOXnzOJihzmMfTt5
	wsDwWIjnGsZjTXw==
X-Google-Smtp-Source: AGHT+IGSTd2Faw/xxTTIOFcjZU6XoSywzCymMkcL6RSxc1cWkvGesZw83sqTekVWN+hk1GX/DwF4g1RUgZ89YD0=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:707:b0:e05:a1df:5644 with SMTP
 id 3f1490d57ef6-e0b9e101779mr28879276.2.1722344798181; Tue, 30 Jul 2024
 06:06:38 -0700 (PDT)
Date: Tue, 30 Jul 2024 13:06:32 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFflqGYC/x3MTQqAIBBA4avErBuwH5G6SrQoG2sgxlAoQbp70
 vJbvJchUmCKMFYZAt0c2UtBU1dgj0V2Qt6KoVVtr0yn0PlAvAv6R5b1JLxYcPUJdaOtM4MajLF Q6iuQ4/Sfp/l9P2hCtGVpAAAA
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2220; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=jEounkARTWSXuP9TGoR+2S+iU6PCZFgHt6WY+kyo3Tg=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmqOVZaPfq/TmW8akkNQvdByFITNP/lMpGaX6Zx
 JhrqcG47RSJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZqjlWQAKCRAEWL7uWMY5
 RiBqEACwAHfImZQ54ckAVJtY5E9fGjzziUgR4Gd9ZthH66+Z5UOeLhcesS9HPsqg4xydZG/eyic
 yQCmPBqQWnfhtEFnyG1fbukZEp2OBESnuk+Ekl8ohEKN2tvG7Gw9yOBHuqyNsZzG7riYWWn25bZ
 EvsbQLN8EKWvBkq+1XSATeQs64TMP/2m0gHHpoRizoVn2JnmJqlfckknB6umXmtJuAJUWcG4KpQ
 2najbjqBjtBxgnccklGhlHYcMcHMTfhi09kbWYsfb8umxH5KfMQfD/9l2m5LAeMHm8OB+iMjJiU
 c68aKE52janaL8/oQMM7As+4bMNEmW44mLcvfh3bvAMRV+urM8FLIjME2LyPV0QFEGRU4+UJYrg
 E3x8LPcgK1Y7DlmtEmDc9gxdHP+uFuWrJCV6Y3SLco7QvENs5Z0TwWT9Nzes04PxWPpKXeJBqqp
 Nage0XOU2YC/eN/L3XzXUWT6wWQfi4hvjFuAw9Qy5lcpXjRPKfwQm9GkekXSdaBe5Bo9+Gpay7+
 DKhlZtpoX31taLcQHuGKmFiERb1jCR/NcSF6yYgl+h4WGPhVufweDV6eaowfE1TNfbYTUAA0BnZ
 eGJ1pLgurxVWwSAIvj9TZhV1oFfZdK/lVt9GMLVI+h+nwE4qZVO4gcRd1SC/IW1LlM4oCkof7Xe NLIB1AZE2VtVayQ==
X-Mailer: b4 0.13.0
Message-ID: <20240730-foreign-ownable-pin-box-v1-1-b1d70cdae541@google.com>
Subject: [PATCH] rust: implement ForeignOwnable for Pin<Box<T>>
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

We already implement ForeignOwnable for Box<T>, but it may be useful to
store pinned data in a ForeignOwnable container. This patch makes that
possible.

This will be used together with upcoming miscdev abstractions, which
Binder will use when binderfs is disabled.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/types.rs | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index bd189d646adb..132ca1113083 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -9,6 +9,7 @@
     marker::{PhantomData, PhantomPinned},
     mem::MaybeUninit,
     ops::{Deref, DerefMut},
+    pin::Pin,
     ptr::NonNull,
 };
 
@@ -89,6 +90,32 @@ unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
     }
 }
 
+impl<T: 'static> ForeignOwnable for Pin<Box<T>> {
+    type Borrowed<'a> = Pin<&'a T>;
+
+    fn into_foreign(self) -> *const core::ffi::c_void {
+        // SAFETY: We are still treating the box as pinned.
+        Box::into_raw(unsafe { Pin::into_inner_unchecked(self) }) as _
+    }
+
+    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> Pin<&'a T> {
+        // SAFETY: The safety requirements for this function ensure that the object is still alive,
+        // so it is safe to dereference the raw pointer.
+        // The safety requirements of `from_foreign` also ensure that the object remains alive for
+        // the lifetime of the returned value.
+        let r = unsafe { &*ptr.cast() };
+
+        // SAFETY: This pointer originates from a `Pin<Box<T>>`.
+        unsafe { Pin::new_unchecked(r) }
+    }
+
+    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
+        // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
+        // call to `Self::into_foreign`.
+        unsafe { Pin::new_unchecked(Box::from_raw(ptr as _)) }
+    }
+}
+
 impl ForeignOwnable for () {
     type Borrowed<'a> = ();
 

---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240730-foreign-ownable-pin-box-515cf790977c

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


