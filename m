Return-Path: <linux-kernel+bounces-410963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 597079CF0E7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E80B287302
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF391C75E2;
	Fri, 15 Nov 2024 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTGY3sj/"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8421D5AD3;
	Fri, 15 Nov 2024 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731686454; cv=none; b=n16SKroR5O4kcf1PVI5y06Lycudx5dr6nSq7lEsr1QY21x1jBeQ+K23F5/7cIfBNBOYfXhbuyKifh9PCZYhcqbqhYvmcD+7MVEIu1clK4aTlLTEVojZx6awHot5DsJ3v6IZMuDNtET6H64GfNaUSyzMIOAD0f9yoSDGK+2pzsgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731686454; c=relaxed/simple;
	bh=vAXIWL5Tm5HEkpTkeRvs/PY9xzGMkmxPQXPP5BPzwao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PMHorWw2/ZYaWBv7cJNlLvi6Uq5QBWOmxfo4jVohIXk2kR/D7nWXUOXveGw5YYyhbfCpdv4ZgFIQlbHDF+CsPOOVRPEFZu1TT2oLzuks3Xlvvw3F54OEdO4WuxBks1bkutCalj2K/E3QlGUQSrTWEy+/lHeU/wi23W4KLfidzfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTGY3sj/; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b161fa1c7bso105887685a.0;
        Fri, 15 Nov 2024 08:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731686451; x=1732291251; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X50QSvdQW6opJ3/PyTKFvmBHXrn62CTGlZAsB4b1Dnk=;
        b=VTGY3sj/VYhKkqmHO4NENmAxsMd32mnC+j2A9hVZLHJUAHrKYM4h06giH8z6FKlnMq
         zTLKAAPtHIYMMOX2XGOjRoym+LqcI1L1iUfbxJg2SR5O2Xx/xCUVCQ7qhWELdIfyPv0A
         t/ACxtKY1awhi8B4M9l2QMgB5vJCYqKLc07nqQZtmQOb0qLvTfLwh83c/fnQD9zV6Y+Z
         3KfzCy26OFjEnL2T/H5NUzrCo4VIZ3bAoIfTztBiQvs1M0wEyI6WRCauht4x8+suSc2z
         K8ov0S3Kc90F6aHu87k9TPAl/9cETbKIlZjsrqBRvpgQV6r9maOU8fW+n1d+T+cRC7aY
         A0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731686451; x=1732291251;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X50QSvdQW6opJ3/PyTKFvmBHXrn62CTGlZAsB4b1Dnk=;
        b=uqOdkQym2hDybJFA2i6I6+e4jPELOeekycImaeRnuuCv1Wxp4qKTWztR4UyCKoGndV
         ElqVJNJ23OFe5856SWAAvbxmdgutvcmGbZxNK5Z/j3QVPAsbKA8PYz3GEhPKIp+BUatO
         e1xxYPV8O3lIrr2ryfhiTote71S6E7M5kMr7NOpeOZIqcE5J+ZnPIiiVlQ7GCLTUNKkV
         VDuHZUu799hJxkvs4U9Ifgg9Q/ehXrYLssXmmaj5Cylf/szkrSDPp9vykwAJFAJ0Wlvq
         DxtuYD0bl0ESf8LWx4FOZFBALTIElzFqWa2aOLelutgUxS1tmdSIjEmPKcVnXdObvikg
         VFYg==
X-Forwarded-Encrypted: i=1; AJvYcCWlGudwFeEWBm7F/zaKS34f45PWS+tEDGNhqTRA7AmI92SuqA3+TjpJjVJFI2hFVrTRz3TZ2CJZ8NyqwrA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy09rWQmw2eJ9fvTE99nRwcrUQxDPNvUqr1/9DYx4H6bXj3T1jM
	Z7LdVb1V/NjY4Q6ITXetW5e3DpaFLz7pjGM0H81Wl8ZWotPygrGmyFQx6iKw
X-Google-Smtp-Source: AGHT+IEG++nyV1g12pFTNgO4j1BHuK1yqdxwRxHnI+K6/3Eg7wV2UuiAfVTQPM3kCfSQ3n/Gcprf2w==
X-Received: by 2002:a05:620a:4594:b0:7b1:5f49:6bf7 with SMTP id af79cd13be357-7b3623718e1mr384988785a.56.1731686450038;
        Fri, 15 Nov 2024 08:00:50 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5be7:7c00:edce:cf6f:2815:775e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b35c984576sm171108785a.25.2024.11.15.08.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 08:00:49 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 15 Nov 2024 11:00:44 -0500
Subject: [PATCH v5 1/6] rust: arc: use `NonNull::new_unchecked`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-borrow-mut-v5-1-86204b249667@gmail.com>
References: <20241115-borrow-mut-v5-0-86204b249667@gmail.com>
In-Reply-To: <20241115-borrow-mut-v5-0-86204b249667@gmail.com>
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


