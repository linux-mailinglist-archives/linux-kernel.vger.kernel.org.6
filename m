Return-Path: <linux-kernel+bounces-433030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F699E5320
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 850681671DC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869561D9A4E;
	Thu,  5 Dec 2024 10:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="US8782mf"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA2B1D2B34;
	Thu,  5 Dec 2024 10:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733396219; cv=none; b=fAe97i2gPa6PGC6r9q4lBgxrRr08xcL2R9Rh9xnO+vg966mhcLy/NHQ6zoKfiJUbzF6zUpHOJosjHFak/gpazehP5FIJzTXYWZCfAyGKOnJr3Q8NAPPbcELAlAbTm73UmwkUyI16GkZNPBfcDvAL+5osafRi9zd8VSTX2PS5ROE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733396219; c=relaxed/simple;
	bh=rxCRMe8fmpkrFbsz1b/1s4n8nYmVrXIgLOyZvw0PtFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ESHHrAd3jS7OZNCO1lF/Ef6dtor70YvGWZGglgH1PH5dgt+cOWAhodhT4wvEpIWV7xgh5sKYIVvSjPR+eDVrG2zKHmNJsak+/f8cbaDMhPPM7IGbGfZqtx8YrDBtQ+26wk+qA/OOZPu73YIaRHSe+czzWiT+hDPvzNOT12aFqHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=US8782mf; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-724e5fb3f9dso634470b3a.3;
        Thu, 05 Dec 2024 02:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733396217; x=1734001017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8ob9R7mHcvJQf+QLbQ/chGGYiFqOfhPZfzKUykJR5WY=;
        b=US8782mfzo+KXOIcEaLgH7hC6tta1i4AKdMi15RuAPG7Y10UdMSa1brF2j+JcnPP2z
         MsfXF9JqPGL7Lm5lvaARFGDtJlYaCYR1leXVEgOp/RC6wXbTJ67AjixhVo7U1TSkDX2F
         7x/6t+noIKfpgWWkUeXAaSn/qge8fNGlYTGCY0XrXabUa2ZZ/ZSlUqRhb+i1Sp5IRjtd
         eSHwBSXftTVzpbuPPrkAYj4T0IKT4faf7ja6ybCq5HHll50UsHnXe6QSjobsbkf/Y3OZ
         D/yXVbV4LNG2UadR/vyyTARMGskQ0pQOiPGsuCStWYBhUwdEoIU47SWb4+egk9wpd2oI
         mnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733396217; x=1734001017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ob9R7mHcvJQf+QLbQ/chGGYiFqOfhPZfzKUykJR5WY=;
        b=ghKMqx8kfV+MF+SP7xxscSevqApWjoI2rgAbPuXOhO9xlon/cr9KD6TfGIAK5lMn9W
         kt4QBvKoFSbHUdGwQ6ciWuO77rX2/wxsO+vRS9znkaaYWn8yPRQ1LMdfp/DO5yqYobW+
         eMdkzRz5rMsQ5COBTIN2X5J4vryjfq1C21qBCGzlbaqhxFpUOlPPSpv0nLivVoO1cSew
         IEv5D3wV7LXdTz/P/3PcoIbUKEvjZVHVbpGgKmoqMTxqbUhFzWcAyzw3z4ujQunuSRHa
         tSnXky1P6+RpqCpqwj1m1sud6asaUOK+vMuEv5wRo8vwTyTiNftSMYABRU6eT3DawvA+
         4GnA==
X-Forwarded-Encrypted: i=1; AJvYcCWQI4MaeT2Jn33Rf52tkprjwgqmMceNpFYTfKLOR0P29E/G6VblgTTvMzOHl/x5G2kGDhcUERFUXACzVw0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv5/onKW4SwAZ8D/RcVhU3Rind4b/izQf9pu23jZNYNsmQ+Z7M
	M8X5rnaPKaQ3WI3koz17a45EzNMUo4W/pnqzbx9YLRxwg18FUSZe
X-Gm-Gg: ASbGncsOl70rUei1oVRikAqT8gtOoCUnDWEc1BuREolZ1jADwdGoBYVqgOkx344qqs0
	df7o6eApZxgKP4zN3qnp5BgnOFLKHoe/1+M4AQfytSuqMozVJwF1u+PCJUoBqI3HG6us1XRQYJu
	iEwI5gPB24N4rbH2AiaHRRsY2/18SHnghaCTrPUS8VwyPnnyJ8S+Ch2ps77hFkVY9rwTBiizef0
	stWfzLHWqa9nWYy976CA5zdw0wy7GJoa2lIf0QHMKoYJSeO4rdHOjsEajxtVeg142j9wSduuTwn
	E6p+Iypk+mcgJM4v+qfDJiaRexGq
X-Google-Smtp-Source: AGHT+IHAMwrgImewD1/bVtNoJ5xN7RW44o3I/Y8AAFhh+HBPxgjQKKfm2kmxoEbX6iXvRAUVO0b94w==
X-Received: by 2002:a05:6a00:3a1b:b0:71e:f14:869c with SMTP id d2e1a72fcca58-7257fa67cc3mr14296370b3a.6.1733396217626;
        Thu, 05 Dec 2024 02:56:57 -0800 (PST)
Received: from lordgoatius.clients.willamette.edu ([158.104.202.234])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a29caa61sm983564b3a.38.2024.12.05.02.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 02:56:57 -0800 (PST)
From: Jimmy Ostler <jtostler1@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Filipe Xavier <felipe_life@live.com>,
	Valentin Obst <kernel@valentinobst.de>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jimmy Ostler <jtostler1@gmail.com>
Subject: [PATCH v2] rust: alloc: Add doctest for `ArrayLayout`
Date: Thu,  5 Dec 2024 02:56:27 -0800
Message-ID: <20241205105627.992587-1-jtostler1@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a rustdoc example and Kunit test to the `ArrayLayout` struct's
`ArrayLayout::new()` function.

Add an implementation of `From<LayoutError> for Error` for the
`kernel::alloc::LayoutError`. This is necessary for the new test to
compile.

Change the `From` implementation on `core::alloc::LayoutError` to avoid
collisions with `kernel::alloc::LayoutError`, and modify imports to
explicitly import `kernel::alloc::LayoutError` instead.

Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://github.com/Rust-for-Linux/linux/issues/1131
Signed-off-by: Jimmy Ostler <jtostler1@gmail.com>
---
v1: https://lore.kernel.org/lkml/20241203051843.291729-1-jtostler1@gmail.com/T/#u
v1 -> v2 changes:
- Add third assert where length is smaller but still overflows
- Remove rustdoc markdown codeblock languge signifier
- Change tests to return results using `?` instead of panic
- Remove `#[derive(Debug)]` for `LayoutError`
- Add `From<LayoutError> for Error` implementation
---
 rust/kernel/alloc/layout.rs | 19 +++++++++++++++++++
 rust/kernel/error.rs        | 13 ++++++++++---
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/alloc/layout.rs b/rust/kernel/alloc/layout.rs
index 4b3cd7fdc816..0e053dcc7941 100644
--- a/rust/kernel/alloc/layout.rs
+++ b/rust/kernel/alloc/layout.rs
@@ -43,6 +43,25 @@ pub const fn empty() -> Self {
     /// # Errors
     ///
     /// When `len * size_of::<T>()` overflows or when `len * size_of::<T>() > isize::MAX`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// # use kernel::alloc::layout::{ArrayLayout, LayoutError};
+    /// let layout = ArrayLayout::<i32>::new(15)?;
+    /// assert_eq!(layout.len(), 15);
+    ///
+    /// // Errors because `len * size_of::<T>()` overflows
+    /// let layout = ArrayLayout::<i32>::new(isize::MAX as usize);
+    /// assert!(layout.is_err());
+    ///
+    /// // Errors because `len * size_of::<i32>() > isize::MAX`,
+    /// // even though `len < isize::MAX`
+    /// let layout = ArrayLayout::<i32>::new(isize::MAX as usize / 2);
+    /// assert!(layout.is_err());
+    ///
+    /// # Ok::<(), Error>(())
+    /// ```
     pub const fn new(len: usize) -> Result<Self, LayoutError> {
         match len.checked_mul(core::mem::size_of::<T>()) {
             Some(size) if size <= ISIZE_MAX => {
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 52c502432447..ac8526140d7a 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -4,9 +4,10 @@
 //!
 //! C header: [`include/uapi/asm-generic/errno-base.h`](srctree/include/uapi/asm-generic/errno-base.h)
 
-use crate::{alloc::AllocError, str::CStr};
-
-use core::alloc::LayoutError;
+use crate::{
+    alloc::{layout::LayoutError, AllocError},
+    str::CStr,
+};
 
 use core::fmt;
 use core::num::NonZeroI32;
@@ -223,6 +224,12 @@ fn from(_: LayoutError) -> Error {
     }
 }
 
+impl From<core::alloc::LayoutError> for Error {
+    fn from(_: core::alloc::LayoutError) -> Error {
+        code::ENOMEM
+    }
+}
+
 impl From<core::fmt::Error> for Error {
     fn from(_: core::fmt::Error) -> Error {
         code::EINVAL

base-commit: 1dc707e647bc919834eff9636c8d00b78c782545
-- 
2.47.1


