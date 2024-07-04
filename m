Return-Path: <linux-kernel+bounces-241285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A313927960
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B118EB24F56
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E601B120E;
	Thu,  4 Jul 2024 14:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzJ3Q9u7"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D66E1B1204;
	Thu,  4 Jul 2024 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720105068; cv=none; b=ClpBc44vR6BEEPIOyN8gUSk/MMHqI/d8EAdHhambjAK9qe7mnaADA6f2OVB8K07JID51VPleFN30lCNNN0Jovj9ys8Nq1Dx7uQBFHiuM81oUgDf2FIqJnsu9IgOEHdYdmqfLONvjaN1PqIfwyDiNUY07wXYg/qa6FKihcaYUa2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720105068; c=relaxed/simple;
	bh=tIdZYPxmJW4E0hW6Pl84dUGKRz0hq/errAVHljq1tM8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ny4wdL5fLLcupfS8QzknGKJ1TQntYF5ROkL8XEbAOjwknU9V+RYfwjmCezgaLVTpDz9VvzkXXetPAA42HSujxmLGxcFeaf+Ox8OdfRZTAt+ghRWodAT4NwK4FWsMJ4KCJNX7q0XKJYXnlIESzUyAvYEIu/UsVZOViE/HDCfu+aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WzJ3Q9u7; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3833cd120e5so2996485ab.1;
        Thu, 04 Jul 2024 07:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720105065; x=1720709865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5fctaVAQ0sznMfei827CWV0YvJyDf9holFy0vo6SoIg=;
        b=WzJ3Q9u7QLb6z33b2kIqt0J1pBrZOu3STL1YCVVwb9vze9fCCqMEVRo3mhmda6fCRY
         KAO3jRYTsuP9v5FrlryTVPqYRYYZARetDgcEGQ1QtSU6omFO+k/9bWkQL3CCO//cgz/+
         2x2pQm+LcRm6fVIqEJyEkxAHJQD5Qi4Pe+oXghQ9ISk2YCH/CA+OnnrqI/hoSfMrh80f
         A874CVNSLnuj8AKUcbFEnpmyFBnZOOd2YhW2C9PHmA4IHtPhLX3j+Wha8Mp7xM9aIen8
         s8jUuMpuCxs/QsKn3/ilmFJWa0E/UUGWuMOcrkXZaPmhq/yRydlmh3Gkn3J9mcG2N60f
         lBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720105065; x=1720709865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5fctaVAQ0sznMfei827CWV0YvJyDf9holFy0vo6SoIg=;
        b=oURtcfdG93wPaL8tbfaK/8HqqvU9DWt1Tcb32W9dDCP+ac+SDSXhQcuuBkaXZd0TC9
         LOZyc6J/F+UDZccKEah23rVsllrGqlCask5Y6vezkYht5Zg1Md6RKXFQjuh3nLFR8rln
         5SbmTkLznjJypU2oe0bta4luhFagI0UGiBr866XRQtKG+xof6YkWOonVGrlIGAWpKtm0
         RvLTzNpyUGEYWR5ssFY5SldqsNvX4eHIhrk82bxkY11a9dPMfsiitxvFjHg9gN6QfIKC
         5sOvoklYDvpz+0I3KEzuYU2ObJWmF072C4mSgTthwWG+rvXzWQ4jYSnGdrX3BaDQ04xV
         BNoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSCPnvZqdfshZgXt0TOekaEavrXqi8mxSMHPmyc7eKYc03Ujqca77p5EMDhMbd6LfcLLxQNXIOY8f6bWN8bi+9zwf8oRFZVV/5eF4MIJ9vvi88N+0URR4MyFZ7+sERYB7XDapAGGJjPT+XrJs=
X-Gm-Message-State: AOJu0YxLKe0SUENWyAv/38hMDjfZMLEFNg4lEAuGORNWF2YRtD7+njRc
	1emKyzeX2F/lcLIdSLTlcL5yMEPNJuqlDrlNrcDCDWAEbc3mf+aa
X-Google-Smtp-Source: AGHT+IHF/3Xb/rvxqzMr2y4ttn2MOVLHOmLw+ef2wq2Yox/+TeekF94oApSViMpjVahzbes9MMD9oQ==
X-Received: by 2002:a05:6e02:1aa7:b0:381:1509:7487 with SMTP id e9e14a558f8ab-383cbec00e5mr8882015ab.7.1720105065517;
        Thu, 04 Jul 2024 07:57:45 -0700 (PDT)
Received: from localhost.localdomain (h135-131-130-199.ashwwi.broadband.dynamic.tds.net. [135.131.130.199])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73bb388asm3940867173.5.2024.07.04.07.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 07:57:45 -0700 (PDT)
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
	Aswin Unnikrishnan <aswinunni01@gmail.com>,
	Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org (open list:RUST),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 4/4] rust: macros: Enable the rest of the tests
Date: Thu,  4 Jul 2024 09:55:45 -0500
Message-ID: <20240704145607.17732-5-ethan.twardy@gmail.com>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240704145607.17732-1-ethan.twardy@gmail.com>
References: <20240704145607.17732-1-ethan.twardy@gmail.com>
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
Reviewed-by: Alice Ryhl <aliceryhl@google.com>

diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index 3278f7c8aa5e..16ab53634099 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -101,7 +101,9 @@ pub fn module(ts: TokenStream) -> TokenStream {
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
@@ -146,12 +148,27 @@ pub fn vtable(attr: TokenStream, ts: TokenStream) -> TokenStream {
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
+/// use kernel::macros::concat_idents;
 ///
 /// macro_rules! pub_no_prefix {
 ///     ($prefix:ident, $($newname:ident),+) => {
-///         $(pub(crate) const $newname: u32 = kernel::macros::concat_idents!($prefix, $newname);)+
+///         $(pub(crate) const $newname: u32 = concat_idents!($prefix, $newname);)+
 ///     };
 /// }
 ///
@@ -197,7 +214,9 @@ pub fn concat_idents(ts: TokenStream) -> TokenStream {
 ///
 /// # Examples
 ///
-/// ```rust,ignore
+/// ```rust
+/// # use std::{sync::Mutex, process::Command};
+/// # use kernel::macros::pin_data;
 /// #[pin_data]
 /// struct DriverData {
 ///     #[pin]
@@ -206,7 +225,15 @@ pub fn concat_idents(ts: TokenStream) -> TokenStream {
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
@@ -221,6 +248,7 @@ pub fn concat_idents(ts: TokenStream) -> TokenStream {
 ///         unsafe { bindings::destroy_info(self.raw_info) };
 ///     }
 /// }
+/// # fn main() {}
 /// ```
 ///
 /// [`pin_init!`]: ../kernel/macro.pin_init.html
@@ -236,13 +264,20 @@ pub fn pin_data(inner: TokenStream, item: TokenStream) -> TokenStream {
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
@@ -405,7 +440,9 @@ pub fn paste(input: TokenStream) -> TokenStream {
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


