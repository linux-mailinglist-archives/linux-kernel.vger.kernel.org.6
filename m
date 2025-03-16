Return-Path: <linux-kernel+bounces-562892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 167B6A63441
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 07:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B79853B46D3
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 06:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D7D194A53;
	Sun, 16 Mar 2025 06:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b="AXVBV/+e"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F015E192B65
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 06:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742106044; cv=none; b=HD1xd0sYZ6D72jHlBqXEPj4UM456t92MRGUNXBDl2Bc/E2JPbMtz3NFylG8qfA3/tdF8qmCEIup188a+1Eudw4CirGNpEeQzSawR9LQ/2OLnKcVbzE8Eorz/X2xuSqci1dHDXe17KgYut4vB4EG4TAVFczM6UEYc4zhPoSrnTNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742106044; c=relaxed/simple;
	bh=XCSzRJywT32yxpHIyrYVntKwh0imphgB2BPgf7j6hI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ldSkM/jqfXyI2qq10DYXXwt6qk86bOOnlIN0xIEKlQeMRONOGC016xhyHr532rYnV+tSMGGdkobFETaRto8DzFQJWGPOaPoFhxpnRokEOueB6sWGaMNP+U9KuLkvMJ/vmHe55gZyy9RmAPqy9OVna1ibUANE1QGmfcSfVYW2eqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=byte-forge.io; spf=pass smtp.mailfrom=byte-forge.io; dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b=AXVBV/+e; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=byte-forge.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=byte-forge.io
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e549b0f8d57so2997086276.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 23:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=byte-forge-io.20230601.gappssmtp.com; s=20230601; t=1742106042; x=1742710842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWYRKcbhjlGMpfeggQ1yU9E4tWuRPqqSollkL7BQFqQ=;
        b=AXVBV/+eX7ya1BWhLt4BgZtLJyQZXZ6ahByDx/tHX4kxdMuCYKkCniR7Ll2eje3UxA
         2Gl3M2iuqyeHfutTb+507VoFMHjQeVryMzxnB0f59ERbt0lyIHtVrQxCYOek9J9iTAif
         /LEgs7uVI483nmSBFTGVewYpvb+1p31CM0FqOOH3wDX4A7R5lGBM+JTOwggTyGapNXsm
         e/dVfPmunGvAYyRwwFJrg/m3govpRwFPz76i8znboKS5ux5rAJhDTH3ukrO2t1UW+d4b
         /AICybTTh3vAasyKSqQCbe0TldcyqzAlNx8UKdCSeInEA1/15LUXeakXhYTiR6I+LVsf
         63Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742106042; x=1742710842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rWYRKcbhjlGMpfeggQ1yU9E4tWuRPqqSollkL7BQFqQ=;
        b=OYryESpYsXkgZBlAuTCFs50jpbcc68TEif/vxhE7kaItWXWjPYXEwLHJ59ucuh4yHQ
         AxFxOv4svzVnZxhoFSYpvSYCBUwUqBet0r+gTLJjQntXIwvuXCWErdj981VIij1zj+wo
         dCPEUpqfCZMXrLMdacKZokTvA2NrJG4bFVorcSBbuZLqF2dwVw1tLnkKCYOow6rJ5loS
         G0VYDUN/pCHKzHFDtSFJktTz4s8RR5Cm9iepw1DnR9czNxHimJbkQld0de3fPeuwPB75
         7SpAx5T0+6KQSVTPQFdVmKjk1HWZpX05RGuNoL4rKlL+JJ7Dsenzn7XKc6p/BuUWW/g5
         p8+g==
X-Forwarded-Encrypted: i=1; AJvYcCWCWqIucGVHLpDKazj2XU/raJSsEvZdHxEPP0Cc4IJFTa9G6J2OoTSERlUvRX3Z8Tx/5Tva40cq398+RM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO06awvKt/46JwzAoBuNJ16TI8bA32MO1oQL8iuB83DJS0aAAQ
	50UWchrGDXNmwYMwdU6Gbm1uXZqrlmOzMt5t/0allGLtGpy+mz0OtzAnThnWowI=
X-Gm-Gg: ASbGnct8QjQyrDG9BdbLXbthmdKggHhUmRPjFSJuo/eZxAwzmIsjw5s0S4qaQRo3hZM
	An5iggleVc2dYYt0n4Bsv29llmwnMvhwC+UbGM8SMBr813RcO8AGJ9JhzEhRbMUZSWUdDK1ccSn
	kObADs5hlX2gdwKKeTV6aAmEEwoPbTQYiIk1jRZZEeJj/QkQTYzfyk5oWr2poInCAeeLxXf4PNk
	mTdp3GfqIRlUrhCeqTpe+X9ZIYI06FDSjwy6VX2mwwfHeEgzEJnxTbLPWD2yKdQa/p+O4QHWd2V
	40KEPD543qGe6OJjPXHbpTZ7duKbWjXrGB23B/jd+xp577BY5IWoSXRVOUk8iiidQo7YodODwJK
	NonFvBj3G7Oame4X/UEIwWruWvsIP0C2fNqY2vrJI
X-Google-Smtp-Source: AGHT+IFSOVWHkQwNGF06bPHR8xq+yt83PSSunblkIlhWeO8z0Q9hc3KIYwU6WSarQaKOAT4nlhwC0w==
X-Received: by 2002:a05:6902:27c7:b0:e63:44b8:8b62 with SMTP id 3f1490d57ef6-e63f65a8215mr10324365276.33.1742106042038;
        Sat, 15 Mar 2025 23:20:42 -0700 (PDT)
Received: from Machine.lan (107-219-75-226.lightspeed.wepbfl.sbcglobal.net. [107.219.75.226])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e63e53fd277sm1618673276.11.2025.03.15.23.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 23:20:41 -0700 (PDT)
From: Antonio Hickey <contact@byte-forge.io>
X-Google-Original-From: Antonio Hickey <contact@antoniohickey.com>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Antonio Hickey <contact@antoniohickey.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/16] rust: workqueue: refactor to use `&raw [const|mut]`
Date: Sun, 16 Mar 2025 02:14:18 -0400
Message-ID: <20250316061429.817126-10-contact@antoniohickey.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250316061429.817126-1-contact@antoniohickey.com>
References: <20250316061429.817126-1-contact@antoniohickey.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replacing all occurrences of `addr_of!(place)` and `addr_of_mut!(place)`
with `&raw const place` and `&raw mut place` respectively.

This will allow us to reduce macro complexity, and improve consistency
with existing reference syntax as `&raw const`, `&raw mut` are similar
to `&`, `&mut` making it fit more naturally with other existing code.

Suggested-by: Benno Lossin <benno.lossin@proton.me>
Link: https://github.com/Rust-for-Linux/linux/issues/1148
Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
---
 rust/kernel/workqueue.rs | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 0cd100d2aefb..4e27df324d26 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -401,9 +401,10 @@ pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self
     pub unsafe fn raw_get(ptr: *const Self) -> *mut bindings::work_struct {
         // SAFETY: The caller promises that the pointer is aligned and not dangling.
         //
-        // A pointer cast would also be ok due to `#[repr(transparent)]`. We use `addr_of!` so that
-        // the compiler does not complain that the `work` field is unused.
-        unsafe { Opaque::raw_get(core::ptr::addr_of!((*ptr).work)) }
+        // A pointer cast would also be ok due to `#[repr(transparent)]`. We use
+        // `&raw const (*ptr).work` so that the compiler does not complain that the
+        // `work` field is unused.
+        unsafe { Opaque::raw_get(&raw const (*ptr).work) }
     }
 }
 
@@ -510,7 +511,7 @@ macro_rules! impl_has_work {
             unsafe fn raw_get_work(ptr: *mut Self) -> *mut $crate::workqueue::Work<$work_type $(, $id)?> {
                 // SAFETY: The caller promises that the pointer is not dangling.
                 unsafe {
-                    ::core::ptr::addr_of_mut!((*ptr).$field)
+                    &raw mut (*ptr).$field
                 }
             }
         }
-- 
2.48.1


