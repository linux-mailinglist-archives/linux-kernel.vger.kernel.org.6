Return-Path: <linux-kernel+bounces-236135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C05EB91DDD8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 771D2281FF9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5026E1422CF;
	Mon,  1 Jul 2024 11:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7WTeNYi"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1543413D61A;
	Mon,  1 Jul 2024 11:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719833295; cv=none; b=atIu/2+q68cfdM46owEqQRtYRqgErxxRUiWU0ckoD9W0WS9uiU8fypZmjslat3XxWAHa/RFu+/VtI5GBJas1WXSk/UwaOFdS8hw8ik2btBnq/Nip3nTHrhOJpCL0T4FNP1dP7WP42O9Qxp/vRULPZGKef++AZ6+TW+0EnDIOT2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719833295; c=relaxed/simple;
	bh=zOwHp5zjE28cBlQd2S9n+jQz8YtgedZ6fB7JfsiWBiY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lpoqSPucIs4PftGRsUtiLyz+H8ZsE9tWLpPkExnfBaA5746+XGGzjDwc8xjQIAx+8ZOmfSdJ7OiLAS3G51488YOCqXOhWrwwUgKBseuf3oG5P54nQCt1Mkopr3aeuyRg7uqBGJ43r7kzrmE6kF+r1LramhGAVHSQsBUo6uXlAqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7WTeNYi; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7f63db7a69cso49498339f.2;
        Mon, 01 Jul 2024 04:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719833293; x=1720438093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CpoKjCPTwl55bMJqHWtfzuU++BcmcJ+0M6F9gW4qMA0=;
        b=J7WTeNYi7BQkmoESVyzbOXo/LUI1xpaOuRK0Jl6MsK84GUUQrofc5nxYRwwmtON7pG
         7Q5VOdWvBCEVtv1APuNfs8ihCFNuy+eUCg/jIOPq47iEycVXAO/Kma5gCKaTs5PbJqsT
         CLep3UnZW3+iLCi/Ir2naX+caCm+fi7Lve7EYS7lC57iiKZ3tA0mr9RnsLOrHdRA5vef
         x1uvYbBvpiZruyZj+Lqv3rs9oL+1SunrVJFThkXL5xVs8wMEcd129gZ+HYg/raRIl1tm
         rWC10uHlR+dBS0hCxXayKL3H3arLl8vHtD2ly0fFxevSVspLEsw71D5JVIEPaxnNlTVX
         9Yqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719833293; x=1720438093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CpoKjCPTwl55bMJqHWtfzuU++BcmcJ+0M6F9gW4qMA0=;
        b=ju0MNHzwhMVqYDI5OaC2UthMJfT/6YD7eJhdxxbGgy/xf5qrDdHUWekSPrZpzcqUBL
         50t7bO16KI+yzwGfmhUd11lGcep7FGtQwdu1IWxFI/H3n0QDC/Hb2G0KWCrqZmtUpUsD
         MbsU4JcmnhMnA5B5le6Y4waRVLRFN4TahoUwsXqMr5OwAf9btUV8nwWa/Hx3ZIL13KUR
         sPiL4H9dFpdCrDuAeTVzyuQPKURFhKA1kZca8f7M06LhFKPtNxWr4H82oRzm6w4GAWer
         9i/mn+V6RAEnkBctOcBICpQDISvPWgmLHW8u0apmWEps/slB28bR06jZRE5l+t9EH64u
         Npfg==
X-Forwarded-Encrypted: i=1; AJvYcCU0kj4i+oliH3I2eLGkZO4HeuBJmuyAfJdswrGaQDMmRie5pFkGIwx8aevLbDydF74Ow/mK1Q8PFQ8Qe7MNDBP2ZOwfuaH4TBNBWek20umqWT5xCJn0yNINyacHbKbhCJ6hivAsJdCFO13odSY=
X-Gm-Message-State: AOJu0YzLpw77Ov9U541AoebXgYgd+9RMC/DJNiPKAAQcNQPASrv0Nc0f
	CZ04xtZqnhLUCfz+xaSuZE9KEKmX7stAy4EeAgWY0eBDtAb86C8E
X-Google-Smtp-Source: AGHT+IHWxiayB99qjYfYCg9nDiP4lise6uTqBz7aMgVxPan1j1uNQSAtg4t/Zz+c3rwNGlB7KBGUlw==
X-Received: by 2002:a6b:5103:0:b0:7f3:9bde:f44 with SMTP id ca18e2360f4ac-7f62ee6eaf5mr615078439f.14.1719833293096;
        Mon, 01 Jul 2024 04:28:13 -0700 (PDT)
Received: from localhost.localdomain (h135-131-130-199.ashwwi.broadband.dynamic.tds.net. [135.131.130.199])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73e062e3sm2087317173.75.2024.07.01.04.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 04:28:12 -0700 (PDT)
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
Subject: [PATCH v2 4/4] rust: macros: Enable the rest of the tests
Date: Mon,  1 Jul 2024 06:24:26 -0500
Message-ID: <20240701112448.28638-5-ethan.twardy@gmail.com>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240701112448.28638-1-ethan.twardy@gmail.com>
References: <20240701112448.28638-1-ethan.twardy@gmail.com>
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
index 3278f7c8aa5e..fcd123b2c093 100644
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
@@ -221,6 +248,8 @@ pub fn concat_idents(ts: TokenStream) -> TokenStream {
 ///         unsafe { bindings::destroy_info(self.raw_info) };
 ///     }
 /// }
+///
+/// # fn main() {}
 /// ```
 ///
 /// [`pin_init!`]: ../kernel/macro.pin_init.html
@@ -236,13 +265,20 @@ pub fn pin_data(inner: TokenStream, item: TokenStream) -> TokenStream {
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
@@ -405,7 +441,9 @@ pub fn paste(input: TokenStream) -> TokenStream {
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


