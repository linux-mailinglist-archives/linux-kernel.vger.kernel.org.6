Return-Path: <linux-kernel+bounces-415680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 845B39D39DA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99A88B26F86
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F541A76DA;
	Wed, 20 Nov 2024 11:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4qSMobI"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902FA1A2574;
	Wed, 20 Nov 2024 11:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732103182; cv=none; b=VGWc3W4aG65X2RBF80B6LlGONShXOHJTVKo6m3z/RO+NUL9diOM7tKDV3Hpz5KpsVgenWocXBWG4+UOjozdj9xHzjrJYpCJh6F4UEfaGFERR4m2RnlO6ys66KNfmdACA6A+ai2DbHVogWUh0ohg72bv0oaJv3HXNY1Yz/EJDCOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732103182; c=relaxed/simple;
	bh=vAXIWL5Tm5HEkpTkeRvs/PY9xzGMkmxPQXPP5BPzwao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FY+mks2Pizg2v1b2WpUgqVus0Vd5yOlN4aMQGA8WBElTyJCmQXLNns8xd/3rqt4ac8ByU87EVfHgJ2gZRwaNrNCPR9QBlNKjJcxn1Vp9J8uffs95hMFP4shKHnFzjXo31ZMwWmpURypAdazqCnN2PuT2MhgHd43S0o53JN+BhOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4qSMobI; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6ee9b571665so29640027b3.2;
        Wed, 20 Nov 2024 03:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732103177; x=1732707977; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X50QSvdQW6opJ3/PyTKFvmBHXrn62CTGlZAsB4b1Dnk=;
        b=j4qSMobIc7Zd2lAFSZmrsP5h8kq8fy21ToBwvT4Jumiejhk3POj2EuFRaXc7OdbmTb
         OYL5CfWRlYhTOhxviW8GJUQzcyA1pOmTULJEH89Z3b2x12+WXXjDNF2+g0Q2rTmuJMaR
         IqoGO0sZnhEY/AzrH+J/e/dJ5q+SeWk8wXr6xkmSE6O6CI1ImqSE4fneOQ9bGJGWAt48
         HC2lQbm37mjAv6wladRGIXpUMlZN2PEJ/9FYkVtQT3lXUcz1H0hrkmvZYRPIHTkp0zDH
         EwkGg2iLvr7DhoEv4zuYnOs0wl1PH0vZSVj5HyrLavGOZLQneBFtWk4CFXyvlaLPWV77
         I/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732103177; x=1732707977;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X50QSvdQW6opJ3/PyTKFvmBHXrn62CTGlZAsB4b1Dnk=;
        b=JUEBa6AZDZMTn8SJ1HFJkZLtpAADGIoBxe5SkHPYfimFDuRPPS8sNrbhZ/LDGZgyjV
         SvvvUMO12oiUrQFpWO/AQlkIbBoNc/F1yAjo+izt82XjACeW+lwB54VflwUvwFpE4/Fw
         b4Yfw59bR3JPVmd5x4OkZQvMDN4uWRA7r4lbkyQwCTFFkyJosPkyAWfPdc2OqFOOAO8v
         OQyBzmRaePdn1lgUGVGncvRulonWC8ywAJM6mhS7MRHjutJG5/jcA5pdaplGtqMNRqIi
         xBGcHh07DLlipLWJfRE9Xu7hdWzX8vHipqwqqjpZykIDL9z7gWQUuzsLlrKSL8sEeBlK
         DUkQ==
X-Forwarded-Encrypted: i=1; AJvYcCX15g8oypuXtvCtuvX2wfPYX75+9neilajtbL4fx3ANedJ+FymK5aRaTcjYb+5UdCqWSEomWWLfija4HsA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy12KrfmhsTaDdmFlu/reyEKy7JaRDl61e9PlxYHLDKOtELyZte
	BzYeY80O27pfFjntevAbdWSPVXMB/2fTYwgytO/niOW5nugwrF5g
X-Google-Smtp-Source: AGHT+IGM1Q0T3oM/qQch/jNqcAddd9VPHjOd0zxV+/Z2ATQZmth5lo+0Pfigdkr0Qk8OdPGptqYFQA==
X-Received: by 2002:a05:690c:9987:b0:6ee:a89e:af3b with SMTP id 00721157ae682-6eebd141e35mr28682117b3.9.1732103177396;
        Wed, 20 Nov 2024 03:46:17 -0800 (PST)
Received: from tamirs-macbook-pro.local ([2600:4041:5be7:7c00:8dca:61d2:c8fb:a544])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d4380b6390sm9705696d6.5.2024.11.20.03.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 03:46:16 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 20 Nov 2024 06:46:00 -0500
Subject: [PATCH v6 1/6] rust: arc: use `NonNull::new_unchecked`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-borrow-mut-v6-1-80dbadd00951@gmail.com>
References: <20241120-borrow-mut-v6-0-80dbadd00951@gmail.com>
In-Reply-To: <20241120-borrow-mut-v6-0-80dbadd00951@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

There is no need to check (and panic on violations of) the safety
requirements on `ForeignOwnable` functions. Avoiding the check is
consistent with the implementation of `ForeignOwnable` for `Box`.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/sync/arc.rs | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index fa4509406ee909ca0677b78d5ece966089ce6366..b4e492dd712137c7c39e3de3d39c0c833944828c 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -337,9 +337,9 @@ fn into_foreign(self) -> *const crate::ffi::c_void {
     }
 
     unsafe fn borrow<'a>(ptr: *const crate::ffi::c_void) -> ArcBorrow<'a, T> {
-        // By the safety requirement of this function, we know that `ptr` came from
-        // a previous call to `Arc::into_foreign`.
-        let inner = NonNull::new(ptr as *mut ArcInner<T>).unwrap();
+        // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
+        // call to `Self::into_foreign`.
+        let inner = unsafe { NonNull::new_unchecked(ptr as *mut ArcInner<T>) };
 
         // SAFETY: The safety requirements of `from_foreign` ensure that the object remains alive
         // for the lifetime of the returned value.
@@ -347,10 +347,14 @@ unsafe fn borrow<'a>(ptr: *const crate::ffi::c_void) -> ArcBorrow<'a, T> {
     }
 
     unsafe fn from_foreign(ptr: *const crate::ffi::c_void) -> Self {
+        // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
+        // call to `Self::into_foreign`.
+        let inner = unsafe { NonNull::new_unchecked(ptr as *mut ArcInner<T>) };
+
         // SAFETY: By the safety requirement of this function, we know that `ptr` came from
         // a previous call to `Arc::into_foreign`, which guarantees that `ptr` is valid and
         // holds a reference count increment that is transferrable to us.
-        unsafe { Self::from_inner(NonNull::new(ptr as _).unwrap()) }
+        unsafe { Self::from_inner(inner) }
     }
 }
 

-- 
2.47.0


