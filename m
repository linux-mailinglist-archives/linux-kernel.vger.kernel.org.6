Return-Path: <linux-kernel+bounces-562886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C2FA63439
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 07:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7105116D6D9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 06:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D8218BC26;
	Sun, 16 Mar 2025 06:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b="phNIalKj"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09461188CD8
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 06:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742106031; cv=none; b=it/7vxCzYUp8yoCFZ/5zSBMJJ5oIsLshYXQODAhZvxQy3OzeNj2+BxWcfq7i2IDL0FPq0CiqMT7i9/sa5u6bh4JbKHQq3ExArr0uu/3Yct+YXFEJnVIEvUtJGEtlqjN+y6eCwkb9+bT274XKSzh/qBw3l+2qPVCayjzAy0y/ZUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742106031; c=relaxed/simple;
	bh=KO/exQTkLkwfgTltyUZcd5X/7Yfmi3eV0OM4DoSLRS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ti2Ax4pE4an6Pi22MVChzDC3K0ujqRA0p5/upsFcGssniysAm6EisyERJkoHmY9AVoRwPn8B8TUbbYIj20c1pk3QucpEZF3xQ0fnGPjWvEhyXFxOhuBqT509KaA987p+5TTD0TzUpV3GtDAu0vW3uCqbWXAvmFDNPONoOgqC2oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=byte-forge.io; spf=pass smtp.mailfrom=byte-forge.io; dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b=phNIalKj; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=byte-forge.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=byte-forge.io
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e6405b5cd9bso1207130276.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 23:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=byte-forge-io.20230601.gappssmtp.com; s=20230601; t=1742106029; x=1742710829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rcfcg5qMvVtXh9IImUjR+2DN3oiPNoX80yC/n4rfVko=;
        b=phNIalKj6EQQBIfMEJ9vZZBv6Dc1GpccKzq8ReRbL329l9cR20mIhqoq1pHleUewfz
         pqxoLobasAMZgWbVPkZ/Vgm+ve2KLU/Bjmhvk3qYuMKQtwoFZtyPmDbwxcZyhdQXTziV
         Eno7T0Lvheg7iytiU2jYk4M/AOJmByF1teD7tsL9zCgwZioRZKwKcqescNuCKqG3nTti
         MTp/McirE6iogOIbcFy654mqpaYvIlRaZSy1ZUR2O9ODAfLeY/egYFVnSV9x0ZE9P+T0
         cNg6vKek/Fl3TO23es8dJ23fHt4UR+IUE6sex8EnssXW7jZ212CoLIf1wQfFvYqq2W9K
         bgvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742106029; x=1742710829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rcfcg5qMvVtXh9IImUjR+2DN3oiPNoX80yC/n4rfVko=;
        b=fePnYfQ1odkNgeLhMuZpEmKFcENYvLiEDpdK+RvWeAikUYIEaIW0UtsFSccZo0w3Ni
         3NXTy6p+L+rLnbJ+UXbWKkbTr79pQ5wWVRhRZIVFE1r0I0sheZshpgtUh+7mAvSQ91DA
         K8RNEKnZbi1ILYgVRwxBC0/de59iYEfV7pwmYv2IIPkMfCjIhmDQWScZ9lyF41BkjokN
         rdBtIWC4zVKKfIEZ5DEZaBV2vOVKi83dJB4TxDMF8dNuaAEN0Deb1H2ha0VBqzZu/OKS
         u9SBX5n5mXInDSbSoTvbpDGvJZZItN4E+0JkkEOhf7vlGExkXvhsB966lvHOSzGj22hi
         xSHg==
X-Forwarded-Encrypted: i=1; AJvYcCVy+V24btynY/TYjpfAKu3f5ytKC72QeSSBcGXyfWUnMQdQumrJ2kqqKKxCoMJEaTUDeXG/1+3qGkDnljE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2BRwXMH9p3VbT/XabNVAvmF2ccEnhD23dldQhwqXGLLPAivvV
	1ig60Z6ZQ5iIy2wcWy2jJ5ibiDZDAxJFivcZdR6HmAZrG+RLrCUdAsE3JG5dSSk=
X-Gm-Gg: ASbGnct6cjLuB//D3boS4T05FNNxHIJKNRpmFd66LtlCGFWh35WyrVmzGPGmHVeZu00
	Z974MZd+3eH+Yn0m7oWE+5gLs686QRRpdXnYul+y6CUVRDHA5PO0GkH9O0Kr1veuQBdMWga2b72
	mDAqqC2rBb4j9yyOYwxdfdaiXaLjc0l/yF8BqtOBdWCThfg0QVaHsgx9fzO0wOWvyS0MZg9qNuG
	Hh4+jl6ggSTXXWpaMOpu5UAPIEghOATaTp9pKDk8ZXLXZ0L13Jo9ZaWWBXys/a5MwIAr9tT+LPk
	bgApE60pJvla5+LTsVWNJ5/+TmBeVde/jRnBJO9YgCxidX3EqsPtWYdIGmK8Bv0ImTgtemUTJMG
	SyYsrxGeyMVumXW10QubYQ/hCx5Oi7A==
X-Google-Smtp-Source: AGHT+IEvZZyoqiXSlITd7yKQJu0HCSC2ILJh0e5MXsUBSIAaDO1pIE7sYxekJt1DHrP97nJnv13TdA==
X-Received: by 2002:a05:6902:727:b0:e5b:4651:b5c6 with SMTP id 3f1490d57ef6-e63f8927a3amr11125910276.23.1742106028911;
        Sat, 15 Mar 2025 23:20:28 -0700 (PDT)
Received: from Machine.lan (107-219-75-226.lightspeed.wepbfl.sbcglobal.net. [107.219.75.226])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e63e53fd277sm1618673276.11.2025.03.15.23.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 23:20:28 -0700 (PDT)
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
Subject: [PATCH v4 03/16] rust: list: refactor to use `&raw [const|mut]`
Date: Sun, 16 Mar 2025 02:14:12 -0400
Message-ID: <20250316061429.817126-4-contact@antoniohickey.com>
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
 rust/kernel/list.rs                    | 2 +-
 rust/kernel/list/impl_list_item_mod.rs | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
index c0ed227b8a4f..e98f0820f002 100644
--- a/rust/kernel/list.rs
+++ b/rust/kernel/list.rs
@@ -176,7 +176,7 @@ pub fn new() -> impl PinInit<Self> {
     #[inline]
     unsafe fn fields(me: *mut Self) -> *mut ListLinksFields {
         // SAFETY: The caller promises that the pointer is valid.
-        unsafe { Opaque::raw_get(ptr::addr_of!((*me).inner)) }
+        unsafe { Opaque::raw_get(&raw const (*me).inner) }
     }
 
     /// # Safety
diff --git a/rust/kernel/list/impl_list_item_mod.rs b/rust/kernel/list/impl_list_item_mod.rs
index a0438537cee1..014b6713d59d 100644
--- a/rust/kernel/list/impl_list_item_mod.rs
+++ b/rust/kernel/list/impl_list_item_mod.rs
@@ -49,7 +49,7 @@ macro_rules! impl_has_list_links {
         // SAFETY: The implementation of `raw_get_list_links` only compiles if the field has the
         // right type.
         //
-        // The behavior of `raw_get_list_links` is not changed since the `addr_of_mut!` macro is
+        // The behavior of `raw_get_list_links` is not changed since the `&raw mut` op is
         // equivalent to the pointer offset operation in the trait definition.
         unsafe impl$(<$($implarg),*>)? $crate::list::HasListLinks$(<$id>)? for
             $self $(<$($selfarg),*>)?
@@ -61,7 +61,7 @@ unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut $crate::list::ListLinks$(<$
                 // SAFETY: The caller promises that the pointer is not dangling. We know that this
                 // expression doesn't follow any pointers, as the `offset_of!` invocation above
                 // would otherwise not compile.
-                unsafe { ::core::ptr::addr_of_mut!((*ptr)$(.$field)*) }
+                unsafe { &raw mut (*ptr)$(.$field)* }
             }
         }
     )*};
@@ -103,7 +103,7 @@ macro_rules! impl_has_list_links_self_ptr {
             unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut $crate::list::ListLinks$(<$id>)? {
                 // SAFETY: The caller promises that the pointer is not dangling.
                 let ptr: *mut $crate::list::ListLinksSelfPtr<$item_type $(, $id)?> =
-                    unsafe { ::core::ptr::addr_of_mut!((*ptr).$field) };
+                    unsafe { &raw mut (*ptr).$field };
                 ptr.cast()
             }
         }
-- 
2.48.1


