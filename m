Return-Path: <linux-kernel+bounces-389519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 265149B6E03
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 585C31C23188
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 20:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAEB213EFE;
	Wed, 30 Oct 2024 20:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrOqaIKM"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1717B1E0E00;
	Wed, 30 Oct 2024 20:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730321206; cv=none; b=VH/vZRQEWR7yQaxwME44Pe7WeM1bVQ+MAF6ELKhtjIRmkfR4RUNRGLOWyS4zXeRx6m8aMMgcfllcQi/5orYUP4yTXIrbgCht/fLIbgKY1RMVU17ZKlOPbJZrA5tbgbIE5YNEpQOw2xbEoBbNaZ8MesjxjzWxsBVKsXLnbjL8qtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730321206; c=relaxed/simple;
	bh=40p+/HOYoLdKJbIi3DVyqIKdZaL43t2+nJwCNcWYA4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n13WGOD6vlImO7DyVIpCKTLlA6rXGio8WELPMGFwpP2yrHSULpvRUHYQlrKIIAJJ99ZYE/nVzU7+s2v+BR16gSZ6004gKere0zgGt55uiZZEZdjf/rt/YL8ajAl3kWpreEigXx57V3+9VIjYWqtxbLuIs2loYEv9RO270Dr6liM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrOqaIKM; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-460c0f9c13eso2747491cf.0;
        Wed, 30 Oct 2024 13:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730321203; x=1730926003; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g9pxM7GSlQsnOFAYSPFhITHq3a0Hq6vT58aRnViDCJU=;
        b=lrOqaIKMqrkiQa3mL0m/Orrk6aDY+TDoNkw/PIbNyFwTrhoh4EcLyPoD13nKgPeHaK
         7MGR082m2qVRlDoY321XXfpXcMwFQfXsi2zOFokB6LkmFv1I4sNoz87HKWWQw71EPhNh
         l3pvkWAajqCI4OTAKg+VpVd1Y7tZttNQ9hND2wVdklC36rYvtW2OaDizXP0NBRha3loc
         M0cJl0aMWfkORFv6znNlwK6WpUBranJ+b71y5RCpqfPyk7AHyibovykCDzczgG5mICi+
         LlIBNndE5lQmNDGAYy9nfGBvguU4BVpXafo2xOTBpSrFXASX3sq0nJhUOS7Z28+RXg/D
         4Y5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730321203; x=1730926003;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9pxM7GSlQsnOFAYSPFhITHq3a0Hq6vT58aRnViDCJU=;
        b=eoDnN6iCQi5pysdjnZnSh2a8XEj6aaR7mKCRgRMGmpmvuGcFcrscwYAxwPVkbySFIl
         Vf/2o3SF+8z62CFv2GQmxaJvv76cWJxGtaxGVri71B/+6Kt26Old7DNY32E9LWuL3NlH
         YMIHv2uiTZfIdP34vc7TmtlbrG7AYk1XuWrnlGgfSxn8leBJFT6qzd3sNxLJp3VNeVvZ
         SBR4cM/i5DB8ZwVxhl3MWgg7lUkdtVGm82jVS/dhxY8+glSmntCA/9ugwtAoTbRHhrzc
         3P0q0wJA/sDoan53uRYYrY53fIOhpBEHSoihwvl0KwoVFj9BI1BmQFRXOSWAzXimDSIO
         3EAw==
X-Forwarded-Encrypted: i=1; AJvYcCUgiy/cwxJngmgtAsbLoZdLZXtr0TVh+XXJqZTrY04V2j6Cw33aZnYy/KYC3FO7jkqIqj6Gf1a9SRbYTGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpcjOeg+g0UvjKs8N34Mihg2LOjwaH1eAWzsB4iPD7boaBQGZT
	DS5K72xBa54mIo+wEWlIIq1Qq7ZxHMvjrmVtZliNs91aBklUcCb2
X-Google-Smtp-Source: AGHT+IGj3b90yotioykYulkfcN9+U/CaxZK8I1LzOjP3NRMbrgJPylhnsSkMQRNwMfL52FxzhI8gZg==
X-Received: by 2002:a05:622a:54f:b0:460:59b1:d80 with SMTP id d75a77b69052e-462ad32d7cbmr866061cf.21.1730321203032;
        Wed, 30 Oct 2024 13:46:43 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:89dc])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ad0c72efsm271271cf.50.2024.10.30.13.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 13:46:41 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 30 Oct 2024 16:46:38 -0400
Subject: [PATCH 1/5] rust: arc: use `NonNull::new_unchecked`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-borrow-mut-v1-1-8f0ceaf78eaf@gmail.com>
References: <20241030-borrow-mut-v1-0-8f0ceaf78eaf@gmail.com>
In-Reply-To: <20241030-borrow-mut-v1-0-8f0ceaf78eaf@gmail.com>
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

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/sync/arc.rs | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index db9da352d588f65348aa7a5204abbb165b70197f..4857230bd8d410bcca97b2081c3ce2f617ee7921 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -337,9 +337,9 @@ fn into_foreign(self) -> *const core::ffi::c_void {
     }
 
     unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a, T> {
-        // By the safety requirement of this function, we know that `ptr` came from
-        // a previous call to `Arc::into_foreign`.
-        let inner = NonNull::new(ptr as *mut ArcInner<T>).unwrap();
+        // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
+        // call to `Self::into_foreign`.
+        let inner = unsafe { NonNull::new_unchecked(ptr as _) };
 
         // SAFETY: The safety requirements of `from_foreign` ensure that the object remains alive
         // for the lifetime of the returned value.
@@ -347,10 +347,14 @@ unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a, T> {
     }
 
     unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
+        // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
+        // call to `Self::into_foreign`.
+        let inner = unsafe { NonNull::new_unchecked(ptr as _) };
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


