Return-Path: <linux-kernel+bounces-563168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 687E7A637B8
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 23:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C47B16D13B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 22:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33121F4725;
	Sun, 16 Mar 2025 22:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2GcQZO8"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61661EEA29;
	Sun, 16 Mar 2025 22:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742164330; cv=none; b=O4/0xO5gfEjG+8fR8T81SXLe0zsjFUs3IhrWr67ytyBzx37BWxhQkFRzEH10WNuWPZ9WsGfCBi9i24OwP8LNsjz8NU43aXj1NOHt7CzXos2EKrrvdTXy5LpRDTRp7TPe411vM6BO1wpr5W6ilJM8YoQ5CxLiwM3NU5GsPE3awd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742164330; c=relaxed/simple;
	bh=ZTJ0/WLxbcfAHux5UNNp9XEDxpZbfyMam0DKL2fBUuI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fSmLkH6QKIyjBlrPFfYMKwq+tdAhVMUvURSDbxwdjp5H6QDXLuk6qh0bKJjvVMZGkcGPWphqOKn90HAXeOUTEclK/LhkB3OvrFn2fxO8gUH0V80zLGU09nMVDVNqsSL6uikkhpBWlMAm+wNHiMJ4QqZaZRKyUlmKkhxVM0Iydm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2GcQZO8; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e8fd49b85eso59542066d6.0;
        Sun, 16 Mar 2025 15:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742164327; x=1742769127; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N7vZ5MLc4cyYefzAIVNKTaGSvbVYwxeoBh8a01cbZtE=;
        b=C2GcQZO8duh2o5y8LvuXkbuqgjTWOxjy83IGqzE0SHBz/NOmIL3ULWkvIu4cdMeh5b
         3qjtMSt5c/WspEi6Qw+VVEuRRp1KTsgEC/Bk15vJoBUBD2SgfhIjNJnGSGku+KrXN+Op
         8MFVL/xsajZVE8w3qN/ckvOguMu8wfwdcHrrW746KGoA+/50xUjx5zuvitD9oZyzagSM
         sUuUgMfMRH4NB42zDsVJDkVPTcQbL6Mh3NzdAcc6rXHEJIGkhLrTZK0x4wosOf53yUTA
         0nrC9rz2bmkjhXBE4KY6RlmsnoqEJUCLkibpKmIMin8zCc2wttrS1QmluqCQfxeeNDZW
         wd/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742164327; x=1742769127;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N7vZ5MLc4cyYefzAIVNKTaGSvbVYwxeoBh8a01cbZtE=;
        b=QfTdpNPqgfQ7J9vtMOQ4YuziGRx2qDOSl/abJbftVY2TBZTLoke/vsw3PdxzbCH8vg
         GdeYLHMD0ShJRCvsqoRDZjtbFphYzxo8LKa69hIjf05PzjHr8vy85mRZZ3WRP2hpXiDK
         9iV2bxj2cP3X+9qFtDZ9kgSzbgUv9jslUA1m0/C1RsMplqzC690aTQHfVPAiX/gfgPDR
         6o3gEbSiyaplFno8pMsHuB42SKwTTzI6ZtXLAjGgBMEIKAAHRlXRncbQ5LuXo1jISimD
         js/5nBBbXMypiAVmB8FBBbXARzaexPu7pLMKMT7YVhg0KR23blnrauZKG+MdsZ9dIspc
         Kkdg==
X-Forwarded-Encrypted: i=1; AJvYcCXV+HvCBG0N8Se5IJnS1h8GMbM/x0TC4aHfoBCGglwC6/3sXhMVaDelzdjTA1ipNx+mN3PjkrPllULQbT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ5yB0FU765BH/wkHLFXT26Q8t6qberfRzpBxNkl24Y/i7i/Vi
	7VsQcJKWabyDeJZWm3JBS7w3wTvujADizkLysNxgKOYK7J6bDaPhtnBO2B/brow=
X-Gm-Gg: ASbGncuGsuZ2Dhcbh7kqQKmetpjFaMflixj3wUOT3/7brKsN1RnZeJOj8NbKOmQVimf
	5QlBm/Lt93ngDGC4m2+sTq4iBmjwo3e3Fa3DYKYqduz7lewS3jxNegkLDP9WJn1ePXHXRqHr7Z7
	KDAF7gh9aw4vo+Wap/nkFlJX9oyrjfJhfc1zMIxuen9ldjGDgz6DfTVB6hs7B5eZJYM9hX6OkH5
	4vLhmZ9D6r+d+NyoinfqwsD+YKeLg1Snvtd9GezK7aYyYI09GcPROnYH+3w9Oj9B74SHbztZc3D
	0o0OWXIXa3MTYYt25oxhE7BACaUDCSkfPWDhh1dDZTnH1kdVn11BnBx7WRPP1YqwTydO
X-Google-Smtp-Source: AGHT+IFZUUJ3yeTrDlzQz+Ip6mwwZe/XuUC7UOiiW1UbAk6Xiv99F1p5HHiYTolhzD7WMapit92G0g==
X-Received: by 2002:a05:6214:194b:b0:6e8:90eb:e591 with SMTP id 6a1803df08f44-6eaeaa7493dmr151123786d6.24.1742164326970;
        Sun, 16 Mar 2025 15:32:06 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:ac75:40f2:fdb1:31e5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade3343b8sm48262146d6.69.2025.03.16.15.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 15:32:05 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 16 Mar 2025 18:32:01 -0400
Subject: [PATCH 2/2] rust: alloc: add `Vec::dec_len`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250316-vec-set-len-v1-2-60f98a28723f@gmail.com>
References: <20250316-vec-set-len-v1-0-60f98a28723f@gmail.com>
In-Reply-To: <20250316-vec-set-len-v1-0-60f98a28723f@gmail.com>
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

Add `Vec::dec_len` that reduces the length of the receiver. This method
is intended to be used from methods that remove elements from `Vec` such
as `truncate`, `pop`, `remove`, and others. This method is intentionally
not `pub`.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/alloc/kvec.rs | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index d43a1d609434..5d604e04b9a5 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -195,6 +195,21 @@ pub unsafe fn inc_len(&mut self, additional: usize) {
         self.len += additional;
     }
 
+    /// Decreases `self.len` by `count`.
+    ///
+    /// Returns a mutable reference to the removed elements.
+    ///
+    /// # Safety
+    ///
+    /// - `count` must be less than or equal to `self.len`.
+    unsafe fn dec_len(&mut self, count: usize) -> &mut [T] {
+        debug_assert!(count <= self.len());
+        self.len -= count;
+        // SAFETY: The memory between `self.len` and `self.len + count` is guaranteed to contain
+        // `self.len` initialized elements of type `T`.
+        unsafe { slice::from_raw_parts_mut(self.as_mut_ptr().add(self.len), count) }
+    }
+
     /// Returns a slice of the entire vector.
     #[inline]
     pub fn as_slice(&self) -> &[T] {

-- 
2.48.1


