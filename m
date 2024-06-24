Return-Path: <linux-kernel+bounces-226596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DD19140BE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 05:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E4B1283BF9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 03:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36ED15E96;
	Mon, 24 Jun 2024 03:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIy+u9cg"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB157179AA;
	Mon, 24 Jun 2024 03:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719198274; cv=none; b=G+IZGdmtfMq4Ljodi2boHk1J3eQJf9Xo/te8w8RU6ui6DnN3iurKQMGNJ8WLUWIh4qZZy+F6ftEdfuPR6Dfttpbuaa1u54BuK3mhm1DQVN6fQDUGQxcIKYFDpHu2cypiPJoNGVehjlLl0fqDVwPR4ZRg/XXh3jsJNsfJ1HevRs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719198274; c=relaxed/simple;
	bh=3lWWzsvgBJXGWIoXBlvl5SoXy4eJAfKs4q5RVI2wRdA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bugn4DOx6aAzKdQFD9jl10T6G08Uc4saBe6Kcro26ksXxtcroLP2oBopf3FVN2q0l+6B/3GSwbfDcwpzVERu1amn2CWR1qc0oFYVqi2Jwmtl+0Q9ZPFEjOpQUiABDghBLDab7T/WIQDzE/j/5rnNz0LnL82j8A9rTf70ew90CJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIy+u9cg; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7eec09cc7f6so151522139f.0;
        Sun, 23 Jun 2024 20:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719198272; x=1719803072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wVanSzZDCxDOZwLyh1W7UweDgQIq9wukQur2GJC15Ak=;
        b=JIy+u9cg7YBulWurmQs6FRvDgKh16dUn8C9DTVuWIrTF6v5iZGFfUwLy1/XO2uGRg/
         4rsF31vN16Ve8NnA9r65BBmG8tbHj6A5TcLZWZRfokOyV5WKoku3/Uvo3Bf/VBEvRQPZ
         b1hKJwJbhs3N5kXLdp18QnLQ1KVR4mTjiMXoukyLObQ5/vOL/k89f36SRxI9dWiTcRN9
         1hh+UZ8MjY9P/1L3w2bzwMGxvsYTD8twPBmGOh9MK8ZplR72CAvp+kGfYSkxIVKeB84s
         vqhNc/DLNXAWvviVEe6W3IJ2JsvaWN29OAPW3DHA1nmoyox8HKMg3VCJrqNG+JRsNHX8
         BH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719198272; x=1719803072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVanSzZDCxDOZwLyh1W7UweDgQIq9wukQur2GJC15Ak=;
        b=nuEwxAkgBQblCFvbL6KGivj1cTkBl1DvijP+1IpT6A1dHTlaEj11IenPHXLGq8cOyF
         gZGiO0NhsyWRFt5WpmBs9Ao8shjmfZ6precBC9Q+Xc2frET9ogzLvNkt580cc+YnduBO
         507tSAnILt1JRXv0/+DwwXVxNke5SeGkJOTUrDaOBwVYeUbncq1fHnF3V9QXKNoJnXuK
         SBbShp8IekzH81aVaZOnHaUuUyXgPxuLJAlw6M7itlM9VJeNj+rLWlJdctkxl9IEkZI4
         TdvRIqqmlPXYnaS9yyQ9Tam8M1HV9h/HO1ttTN79M38ZugrZ5mFY19fAKV6iqOsLKMSj
         dNKg==
X-Forwarded-Encrypted: i=1; AJvYcCUHeNSpcdopJ+87iGDKqG8xN1D9KgmBmyOdgPF0B/7Rq8UrLAxstOJHtsXP2dZt9uaNHp1OhM5i9Nb6+YzFES351jwrtIpMVb5xlw1ABLag4HkSxYoHeZLWAIwubPo2vSP5xNlDO1gP/hdGLVM=
X-Gm-Message-State: AOJu0YxrbArL/T9uqwdaTNdhEboZSF2UClIzqQGn4mGcz5DavVag2ZBi
	NGJjOo4R3Id59n+fYndKWe5tY2UJRHXV4TOm28/JgyI6d3FSSSgSwMo8d07T
X-Google-Smtp-Source: AGHT+IFOCgXtmU1/lMIFPdlku5fVa9Y3JBThRuPD6d69g582ODfVFo9vS2fwrmuLtPoEEWPAN11IPw==
X-Received: by 2002:a05:6602:3f8a:b0:7f1:3ad1:2341 with SMTP id ca18e2360f4ac-7f3a13db517mr526287839f.7.1719198271899;
        Sun, 23 Jun 2024 20:04:31 -0700 (PDT)
Received: from localhost.localdomain (h135-131-130-199.ashwwi.broadband.dynamic.tds.net. [135.131.130.199])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b9ea0957c0sm1045476173.131.2024.06.23.20.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 20:04:31 -0700 (PDT)
From: "Ethan D. Twardy" <ethan.twardy@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	"Ethan D. Twardy" <ethan.twardy@gmail.com>,
	Trevor Gross <tmgross@umich.edu>,
	Aswin Unnikrishnan <aswinunni01@gmail.com>,
	rust-for-linux@vger.kernel.org (open list:RUST),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/4] rust: macros: Enable the rest of the tests
Date: Sun, 23 Jun 2024 22:03:06 -0500
Message-ID: <20240624030327.90301-5-ethan.twardy@gmail.com>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240624030327.90301-1-ethan.twardy@gmail.com>
References: <20240624030327.90301-1-ethan.twardy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the rusttest target for the macros crate is compiled with the
kernel crate as a dependency, the rest of the rustdoc tests can be
enabled.

Signed-off-by: Ethan D. Twardy <ethan.twardy@gmail.com>

diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index 8afed8facb21..6d764099563b 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -102,7 +102,9 @@ pub fn module(ts: TokenStream) -> TokenStream {
 ///
 /// # Examples
 ///
-/// ```ignore
+/// ```rust
+/// # #[macro_use] extern crate macros;
+/// # #[macro_use] extern crate kernel;
 /// use kernel::error::VTABLE_DEFAULT_ERROR;
 /// use kernel::prelude::*;
 ///
@@ -147,12 +149,28 @@ pub fn vtable(attr: TokenStream, ts: TokenStream) -> TokenStream {
 ///
 /// # Examples
 ///
-/// ```ignore
-/// use kernel::macro::concat_idents;
+/// ```rust
+/// # const binder_driver_return_protocol_BR_OK: u32 = 0;
+/// # const binder_driver_return_protocol_BR_ERROR: u32 = 1;
+/// # const binder_driver_return_protocol_BR_TRANSACTION: u32 = 2;
+/// # const binder_driver_return_protocol_BR_REPLY: u32 = 3;
+/// # const binder_driver_return_protocol_BR_DEAD_REPLY: u32 = 4;
+/// # const binder_driver_return_protocol_BR_TRANSACTION_COMPLETE: u32 = 5;
+/// # const binder_driver_return_protocol_BR_INCREFS: u32 = 6;
+/// # const binder_driver_return_protocol_BR_ACQUIRE: u32 = 7;
+/// # const binder_driver_return_protocol_BR_RELEASE: u32 = 8;
+/// # const binder_driver_return_protocol_BR_DECREFS: u32 = 9;
+/// # const binder_driver_return_protocol_BR_NOOP: u32 = 10;
+/// # const binder_driver_return_protocol_BR_SPAWN_LOOPER: u32 = 11;
+/// # const binder_driver_return_protocol_BR_DEAD_BINDER: u32 = 12;
+/// # const binder_driver_return_protocol_BR_CLEAR_DEATH_NOTIFICATION_DONE: u32 = 13;
+/// # const binder_driver_return_protocol_BR_FAILED_REPLY: u32 = 14;
+///
+/// use kernel::macros::concat_idents;
 ///
 /// macro_rules! pub_no_prefix {
 ///     ($prefix:ident, $($newname:ident),+) => {
-///         $(pub(crate) const $newname: u32 = kernel::macros::concat_idents!($prefix, $newname);)+
+///         $(pub(crate) const $newname: u32 = concat_idents!($prefix, $newname);)+
 ///     };
 /// }
 ///
@@ -198,8 +216,9 @@ pub fn concat_idents(ts: TokenStream) -> TokenStream {
 ///
 /// # Examples
 ///
-/// ```rust,ignore
-/// #[pin_data]
+/// ```rust
+/// # use std::{sync::Mutex, process::Command};
+/// #[kernel::macros::pin_data]
 /// struct DriverData {
 ///     #[pin]
 ///     queue: Mutex<Vec<Command>>,
@@ -207,7 +226,15 @@ pub fn concat_idents(ts: TokenStream) -> TokenStream {
 /// }
 /// ```
 ///
-/// ```rust,ignore
+/// ```rust
+/// # use std::{sync::Mutex, process::Command};
+/// # use core::pin::Pin;
+/// # pub struct Info;
+/// # mod bindings {
+/// #     pub unsafe fn destroy_info(_ptr: *mut super::Info) {}
+/// # }
+/// use kernel::macros::{pin_data, pinned_drop};
+///
 /// #[pin_data(PinnedDrop)]
 /// struct DriverData {
 ///     #[pin]
@@ -222,6 +249,8 @@ pub fn concat_idents(ts: TokenStream) -> TokenStream {
 ///         unsafe { bindings::destroy_info(self.raw_info) };
 ///     }
 /// }
+///
+/// # fn main() {}
 /// ```
 ///
 /// [`pin_init!`]: ../kernel/macro.pin_init.html
@@ -237,13 +266,20 @@ pub fn pin_data(inner: TokenStream, item: TokenStream) -> TokenStream {
 ///
 /// # Examples
 ///
-/// ```rust,ignore
+/// ```rust
+/// # use macros::{pin_data, pinned_drop};
+/// # use std::{sync::Mutex, process::Command};
+/// # use core::pin::Pin;
+/// # mod bindings {
+/// #     pub struct Info;
+/// #     pub unsafe fn destroy_info(_ptr: *mut Info) {}
+/// # }
 /// #[pin_data(PinnedDrop)]
 /// struct DriverData {
 ///     #[pin]
 ///     queue: Mutex<Vec<Command>>,
 ///     buf: Box<[u8; 1024 * 1024]>,
-///     raw_info: *mut Info,
+///     raw_info: *mut bindings::Info,
 /// }
 ///
 /// #[pinned_drop]
@@ -408,7 +444,9 @@ pub fn paste(input: TokenStream) -> TokenStream {
 ///
 /// # Examples
 ///
-/// ```rust,ignore
+/// ```rust
+/// use kernel::macros::Zeroable;
+///
 /// #[derive(Zeroable)]
 /// pub struct DriverData {
 ///     id: i64,
-- 
2.44.2


