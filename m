Return-Path: <linux-kernel+bounces-566881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4A9A67DE6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 21:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF20F421249
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 20:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4960213E9A;
	Tue, 18 Mar 2025 20:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjHSLfcQ"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657111DDC30;
	Tue, 18 Mar 2025 20:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742328863; cv=none; b=Qg1y3t5lo59kwLHONZ8FnhOP6RCgeNIxAUslGAUhE1CTdmHka/zh62ML4QO6LEg+fQAu75ZQv+vHAa6+SRCIwidxejPUoTZUnd1fcJLgk7qdQOdTcF32i2cI8vxYnynQqY2dqJKKDCPPW4lyNtwlfz5GjXR1pHCzCG+cAnXIgdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742328863; c=relaxed/simple;
	bh=u81mPTwzISAqjuJ8U83p3mV3+NpkdOo2hR6Sa918HLY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IgkGzNv9BPcDuoCcKlbmzWq2/E9laPmw7y3NBQxvLtJbhbb5rqA7AsfY9upArhnRVqyprCrbCSkdmUlRlk4ZJkMsToyJ2UBdFbM1apfPg8QKRbFcMekaeP2YF4bC3fncbuoL6NfqlHN0Yt6XkuIRH/pmpzjE4/eF9hZhUGOrqFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjHSLfcQ; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e89a2501a0so58120266d6.1;
        Tue, 18 Mar 2025 13:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742328860; x=1742933660; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i6DXPq4ezx60cnU9aZXHs1sMKK1LCNiHRchniD7m90I=;
        b=HjHSLfcQWPHkufS0SI8jgx1M8nL2IBncnrezKugItTNqFBLONsXa74bHVEkEKeNfQo
         6VpabtLRyvknnG8zsIbj+1AKoXgm6RccvPs6JCSGTNjfSKOXS6XK/BtKxiNstV6t2Sad
         tqSBD+TA0nfGtPJeJvsUXj/WBQg0utJQesNdEuUCaJ1QAyY5JxEjC44sooiv+0Ufj53N
         najKKbdc+e4iDcDPFP6d0jnQ4x0V5x9SftpZwhe+iSil7bRWEDktpWSy+xSvn2rpahry
         vUy6gmZ22KP8wgXyzUU+orm9Dzl4KHyaBN/76R5QqUPO4wNru7ehvU3MPkSVJjoUXM39
         6JLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742328860; x=1742933660;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6DXPq4ezx60cnU9aZXHs1sMKK1LCNiHRchniD7m90I=;
        b=cmRblilgMJy/vHVRAtzXYdBObefULbPFJkKx4uTD8E4uNdGm6onujTwZ+Ja0l58LQN
         GZ2HXAcDDenRyGVbZ1TTSUOYd3xZ3CXK6+RSu/B8nD3qj24p7iWBOI+04s7rltKZpqEk
         s52raDk9BQiA7LR+aTP6BZthlvy3+qKbh4IVTuVQB51BOF8qHp1ZiAPYvo4t/H6FbS2g
         FnbD9Ny2KVKSHUNXeSOArhW1zHoFbFCAv/lkEjhlUJn3nJkeecOpyaUwtG8dLbWkmBHn
         imBQXY+1BW+d8ewGVm0XuEvoezSrM1jaMF1svKwH24UlY/BrJ3WS060NyKKHh3pJbI55
         6GPA==
X-Forwarded-Encrypted: i=1; AJvYcCWxHHP8juy43zuid0a1j8PQlkxUFNVAgnfrSAKS8deCxHfqCKoc52qGPeYAfVf/dEroCO3loPxY67+96/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbeYwZWLM4VLF75azS5706tiTeKW+FowqhQ1YymFbN1m2w6iEb
	iCfdKCgbyP4aZ0/4cSg20r3RJpjxRnqWCUH9QIQbEjsm2w7UxMZV
X-Gm-Gg: ASbGnctqkka9Z4shMXr750xDWq5Q0L6xvg0wsWPqw5hborKAq8amO4vFdCPb8kaDdqH
	ypWZ7FEXDUKQRkpjWQO/PsnjYTQlu3wtL3t7xGFLwG/vOhiilL0xOSbFdOlmEwVgk2qpaNRG87w
	OxGoOrK44ptQ+233/HTe8dUIb6MOAL6GTyf/UbLZnukhnQzOCe2g1Ilj349rlkHrqPrRHyEoAJF
	m55wqVS7q9SDYYxfCq3zx2++2pmp8l/s9w5/wIZhkqSsV1g0gpuTF/DedoUGVAsI1KwUq/S3oM3
	7MgAdSDOmLz0BlxaZtJJoLIOR3Iou3e7hj7vKUQHmdYCxG+yClNww22U0G8EPO12ma6u
X-Google-Smtp-Source: AGHT+IEQ2QGIxkeIvd3Szhkc5NsPCnpFpBoYbiua+k8oizbuLHSDGlKUYAOT7qKsDfdfNfoHPoLH9g==
X-Received: by 2002:a05:6214:238e:b0:6e8:f905:aff0 with SMTP id 6a1803df08f44-6eb293dd244mr2379256d6.35.1742328860184;
        Tue, 18 Mar 2025 13:14:20 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([2620:10d:c091:600::1:e903])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade209335sm71301046d6.22.2025.03.18.13.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 13:14:19 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 18 Mar 2025 16:13:53 -0400
Subject: [PATCH v2 1/4] rust: alloc: add Vec::len() <= Vec::capacity
 invariant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-vec-set-len-v2-1-293d55f82d18@gmail.com>
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

Document the invariant that the vector's length is always less than or
equal to its capacity. This is already implied by these other
invariants:

- `self.len` always represents the exact number of elements stored in
  the vector.
- `self.layout` represents the absolute number of elements that can be
  stored within the vector without re-allocation.

but it doesn't hurt to spell it out. Note that the language references
`self.capacity` rather than `self.layout.len` as the latter is zero for
a vector of ZSTs.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/alloc/kvec.rs | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index 18bcc59f0b38..ce58ee66c99b 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -90,6 +90,8 @@ macro_rules! kvec {
 ///   without re-allocation. For ZSTs `self.layout`'s capacity is zero. However, it is legal for the
 ///   backing buffer to be larger than `layout`.
 ///
+/// - `self.len()` is always less than or equal to `self.capacity()`.
+///
 /// - The `Allocator` type `A` of the vector is the exact same `Allocator` type the backing buffer
 ///   was allocated with (and must be freed with).
 pub struct Vec<T, A: Allocator> {
@@ -259,8 +261,8 @@ pub const fn new() -> Self {
     /// Returns a slice of `MaybeUninit<T>` for the remaining spare capacity of the vector.
     pub fn spare_capacity_mut(&mut self) -> &mut [MaybeUninit<T>] {
         // SAFETY:
-        // - `self.len` is smaller than `self.capacity` and hence, the resulting pointer is
-        //   guaranteed to be part of the same allocated object.
+        // - `self.len` is smaller than `self.capacity` by the type invariant and hence, the
+        //   resulting pointer is guaranteed to be part of the same allocated object.
         // - `self.len` can not overflow `isize`.
         let ptr = unsafe { self.as_mut_ptr().add(self.len) } as *mut MaybeUninit<T>;
 
@@ -286,8 +288,8 @@ pub fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError> {
         self.reserve(1, flags)?;
 
         // SAFETY:
-        // - `self.len` is smaller than `self.capacity` and hence, the resulting pointer is
-        //   guaranteed to be part of the same allocated object.
+        // - `self.len` is smaller than `self.capacity` by the type invariant and hence, the
+        //   resulting pointer is guaranteed to be part of the same allocated object.
         // - `self.len` can not overflow `isize`.
         let ptr = unsafe { self.as_mut_ptr().add(self.len) };
 
@@ -793,12 +795,13 @@ pub fn collect(self, flags: Flags) -> Vec<T, A> {
             unsafe { ptr::copy(ptr, buf.as_ptr(), len) };
             ptr = buf.as_ptr();
 
-            // SAFETY: `len` is guaranteed to be smaller than `self.layout.len()`.
+            // SAFETY: `len` is guaranteed to be smaller than `self.layout.len()` by the type
+            // invariant.
             let layout = unsafe { ArrayLayout::<T>::new_unchecked(len) };
 
-            // SAFETY: `buf` points to the start of the backing buffer and `len` is guaranteed to be
-            // smaller than `cap`. Depending on `alloc` this operation may shrink the buffer or leaves
-            // it as it is.
+            // SAFETY: `buf` points to the start of the backing buffer and `len` is guaranteed by
+            // the type invariant to be smaller than `cap`. Depending on `alloc` this operation may
+            // shrink the buffer or leaves it as it is.
             ptr = match unsafe {
                 A::realloc(Some(buf.cast()), layout.into(), old_layout.into(), flags)
             } {

-- 
2.48.1


