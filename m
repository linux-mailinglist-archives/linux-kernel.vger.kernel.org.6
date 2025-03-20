Return-Path: <linux-kernel+bounces-569060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C464BA69E15
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 03:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4C7119C3A14
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 02:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD0D1E3772;
	Thu, 20 Mar 2025 02:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b="g0EuQedb"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393131D7989
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 02:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742436537; cv=none; b=YLIdtN+t8QeZ2yqedh1rkOGOdfq7neZlU24xD6PybZgi9YT2v7BinZ5eMqTZ9UTr9LxDrx0QnVhkt9P4i75WMvQjT/gtZJ6E/rXBDG8qfY+EO1xwN1B1UfYqdrwE6GgpcbPjFFg6UWjM7erjm9VHUapLozHTnnkFOk8CchsASIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742436537; c=relaxed/simple;
	bh=Ei46/XSjgfzkcjSL5NbmSt9DgtmSmLVGDDGjD5wOnw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MlUzQoDvTIDn/tqIQnXCE2DVWl+lcuJaEJdmdmE2QsjgF0fKfh2dr3vWBUyt5+GoNWBkeynp8REdDSn+SBN6Vp+EL4HfQ0lBlDfMsR1xsiC3V3r9yljjYWiKDe9fHEayszWqVUmRMOonYljpIx8adMxWY3haNpTKgTFHi7IIsU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com; spf=pass smtp.mailfrom=byte-forge.io; dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b=g0EuQedb; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=byte-forge.io
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6f7031ea11cso2970757b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=byte-forge-io.20230601.gappssmtp.com; s=20230601; t=1742436535; x=1743041335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9FHzui9Ab3LHBQvPmz9xI55DK1wU77PLMSFevFbEbg=;
        b=g0EuQedbkYXF6jLrAVInhGwSbXufC1Gtm6eioFieybJU6zQhd9jKz9vfxJJzTCsFkK
         dlFanuhWnCryNh2SY1wyCVrUuTa8jX7Md+Ti5ayHh92RNA/EMc6Y1F4sPjELlhpNwsQN
         97ZDUOvuaJMtaeyRpdFfmm7yN+ghhMGzdVAjB/02k2UkUg3seuNXsODWPOLmFeRJXSYg
         +B+RzrzHrlz9lMOHstD7wtfaeykHYln+z54T9mQ6aRijsTaMJQSXQo1q+TegjFYq+Ked
         3QbeXG0mUtGw8GhIg+W22KPWfQU9pA7Af2GQoRSO3ntMPHF2SMsLOpNs0qJOkiTtwbHe
         c1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742436535; x=1743041335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P9FHzui9Ab3LHBQvPmz9xI55DK1wU77PLMSFevFbEbg=;
        b=tcVncbl1P7iyoTkW/Vb1Jpu7xvo82oUB/quhrqp6MkKpFBEYe4xbKCFBLGdNlUOW58
         ZFXteTGsj8ENhfJlPRZdHnv18clzKnDNyiwlJIUCuVPZAEkJktQWBVCRoOcx5Y8zJzbC
         WQF/EZxNI04YvOk58rzowTfKuCJmdo1/Du4fB48/YQjknyBuy5geQS3yhP5r2ej43dPg
         ixO4LyUCxbbNuio3kPbsIE3Tnq4isHL+trrbFjX3BhoevuWJuxY876iK4/pPMoaXW96d
         SdxhuTG9dqr940WjS/o7tf5UtSEGP6OhgyXZbF8lcsMb3Ld8bxJQLA9AcPUWdowT5hxZ
         ujOA==
X-Forwarded-Encrypted: i=1; AJvYcCUi0fHBq5k3mVnKYG6ddVXldJNawg3E1nSMD3pfRHnmsLVfxrKI9kKE5kuTXetYX9J6BOiG2L92sZheX0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEurnVZeXXEFct9vqwxzKx0iAxFo+1NJcadMIfQP3TcG8YKqdc
	gj4RKeawPpBnVnzjwAC2463yguqWEbqEmUgS2pwCt3t3L12Si7PJWMjqcAAMjEM=
X-Gm-Gg: ASbGncsAnSL8AsDv4EjMLbG5oh4i9CnMFhOInUYb9InomlsfPTZEFIpgOY3Rm7RvtWD
	RGIzoIZFRIdPo5+mdAxI52XQ7QdNYwZCzWMNxmyv9hOwfXpUtRNeo/P0v1PFk0zTlXWlTd/FONa
	j/XR8Pm2ePIWQ7WeVYVs5Fl45hamuuF4mHSnQE18u/aAvl8ITz5iMFSBznnV9rnHgyH7xGsQp+l
	liKSSIAvaiuD3i/pNX3AwhrHwngwkxdWr5NxMZD2L0fY/SpiDHoZJYzMHuUNTaqrpK7LxrOKu/H
	I8Aueb+0BIfAZ0fF3csnxQp6jlQPyhyECE4VznKe+evMp4jVTcRkuY+mSpcZmmt9macPzlxpldZ
	9hNsj8hlK5LVEaDfkik5+I/otut3Vi75IRrnncUWO
X-Google-Smtp-Source: AGHT+IHa6JKiYio8gKv8paGdcIO0IZzOY+f2BKAM9umcVjti6jZO+C9x6PaGEBUZlcxkLfGY6lbIQA==
X-Received: by 2002:a05:690c:6109:b0:6fd:dfcf:2b11 with SMTP id 00721157ae682-700ac6c670fmr18931267b3.24.1742436535429;
        Wed, 19 Mar 2025 19:08:55 -0700 (PDT)
Received: from Machine.lan (107-219-75-226.lightspeed.wepbfl.sbcglobal.net. [107.219.75.226])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ff32cb598asm32826357b3.111.2025.03.19.19.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 19:08:55 -0700 (PDT)
From: Antonio Hickey <contact@antoniohickey.com>
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
Subject: [PATCH v5 09/17] rust: workqueue: refactor to use `&raw [const|mut]`
Date: Wed, 19 Mar 2025 22:07:28 -0400
Message-ID: <20250320020740.1631171-10-contact@antoniohickey.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250320020740.1631171-1-contact@antoniohickey.com>
References: <20250320020740.1631171-1-contact@antoniohickey.com>
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


