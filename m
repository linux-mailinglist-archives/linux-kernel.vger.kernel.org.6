Return-Path: <linux-kernel+bounces-226595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A919140BC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 05:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F356B1F22F55
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 03:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97565EAF6;
	Mon, 24 Jun 2024 03:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPovRjf4"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D5015E83;
	Mon, 24 Jun 2024 03:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719198268; cv=none; b=jJ+y78AZmBuzCzZOF72wrQqfNCvr3lLmYXq1ZdowUYqRzPKdcyFHaRGWgJ5qnsHfxUD9f+njywGepH2iLhQFSb834eQ42oX864ElxyM9n7LuD/suD4H/4wbImnJ9Jsjn2a0Tbs+X3nkVDTvNcASCK1eZJjtM40LJSqj34bakkeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719198268; c=relaxed/simple;
	bh=8SgSh3BVvDcW2Wrj9oTKukbPMt7005OVvY4ng+7QqLU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bsKSX+wAb9qW1tZzYphoDs6Ftnj+77kfrfjqYZSk3jFVcl0yKb6+2YLqF4x5VbYlBxb7h2s+FFMRZwKRNnwaJTKQR+L/CLbUPskAigCDKssM6hqHwcK/sYzmqW0P9WInXreyOQtfmnDE1o2ovO8gFfkQRZ6V9DWDp8PZVHPmjM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPovRjf4; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7eb5dd9f994so138007039f.2;
        Sun, 23 Jun 2024 20:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719198266; x=1719803066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sGbYXEplpjwD5wkMdsIyGjNuNYKckUejQgWaAgd12FM=;
        b=iPovRjf4eP4o0cmNMVvpSeypEeg+7e2xPX8jDyX6ooPy6esoSxZ3crsZ7rmzyslltV
         RAuBsmrclnLpEm4QqxYh2k5pCttxBc6itVPPQvUi1Q9BTgbEyrcjS00ALFfVffJQGfez
         uxk5iSGNl6SfcImAF361an/l1fy1HSWztq/Y7g4DK4D8vRK7KpytKwqY/g4lKrAW73Bh
         oIWsXpx7m1v9smWHArO5+LwcecbYP4HXnNa9jmfRmSltv+0zFWa8VqY/kFw4JUjE5DuX
         pIERhwniEhZznO1TsX6rAqpZtjB7nf7xK/uZjTnFMTNmfW5VfIkk7r2tilNrBk74CmuM
         fJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719198266; x=1719803066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGbYXEplpjwD5wkMdsIyGjNuNYKckUejQgWaAgd12FM=;
        b=stV1RdutS1WYFrWA5opTRSIgnpY02+s7A2h97RiWjJ9CmcLwtTuN24CLKQg015b2Vy
         9kRSSltCl+RA5czlfjX3Ng7Y2eUuULMOfSkSlkt3EniyURUspcvi4yx1i70/8RcraqWD
         gaHFNB8gmVTG8F3gny5xRxq8jdaU03JLe3p3LnEfH0wE4yExDYIoL+a9G7g75skfJhlw
         LM9+AmyEG2CHmdkDPv10AgiBgGFy9SPicLKElBg0u5hpsKs7z2KN0yz/lXNtKR/Lk2+I
         fCq4SDUurMm1UjF1R88GkxN2VPwdvabou/voZSNOEXkKqj/sez2WKUhc2mZP9+uJIHZU
         BxCw==
X-Forwarded-Encrypted: i=1; AJvYcCVZDu0aZoc0MTiqu9LMBvhq8qj2Q5iCs6+k6ET/dD62uipsRhwQxUYVo83TZxbMwg4ZtClkL6uw3tuusFcH03CZmG3NAUACKeGK5mm7XHfuAQ395MIjTFbQCfgFuhnHc3pQxVEgOxVzTVRKKRc=
X-Gm-Message-State: AOJu0Yw5ZcR9lfAXa7N0APGETQbZ9htIO3blLEOq/nL5k813r+Yh+4MP
	xS1hZE+gdRvOGHQSuV5XIZ+guv51ICZ5PnVheKHjXBUfocehxonB
X-Google-Smtp-Source: AGHT+IGGh2r+QdPigrqsEedU7f7SfWPpMbQdG14OFtxKZwvXMRSAK++h7agiUtBE9dxZDM74KmW+Ew==
X-Received: by 2002:a05:6602:14c2:b0:7eb:80dd:83c9 with SMTP id ca18e2360f4ac-7f3a13eb9f6mr555721239f.9.1719198266130;
        Sun, 23 Jun 2024 20:04:26 -0700 (PDT)
Received: from localhost.localdomain (h135-131-130-199.ashwwi.broadband.dynamic.tds.net. [135.131.130.199])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b9ea0957c0sm1045476173.131.2024.06.23.20.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 20:04:25 -0700 (PDT)
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
Subject: [PATCH 3/4] rust: macros: Enable use from macro_rules!
Date: Sun, 23 Jun 2024 22:03:05 -0500
Message-ID: <20240624030327.90301-4-ethan.twardy@gmail.com>
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

According to the rustdoc for the proc_macro crate[1], tokens captured
from a "macro variable" (e.g. from within macro_rules!) may be delimited
by invisible tokens and be contained within a proc_macro::Group.
Previously, this scenario was not handled by macros::paste, which caused
a proc-macro panic when the corresponding tests are enabled. Enable the
tests, and handle this case by making macros::paste::concat recursive.

[1]: https://doc.rust-lang.org/stable/proc_macro/enum.Delimiter.html

Signed-off-by: Ethan D. Twardy <ethan.twardy@gmail.com>

diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index d8bd34c0ba89..8afed8facb21 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -269,12 +269,26 @@ pub fn pinned_drop(args: TokenStream, input: TokenStream) -> TokenStream {
 ///
 /// # Example
 ///
-/// ```ignore
-/// use kernel::macro::paste;
+/// ```
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
 ///
 /// macro_rules! pub_no_prefix {
 ///     ($prefix:ident, $($newname:ident),+) => {
-///         paste! {
+///         kernel::macros::paste! {
 ///             $(pub(crate) const $newname: u32 = [<$prefix $newname>];)+
 ///         }
 ///     };
@@ -313,13 +327,29 @@ pub fn pinned_drop(args: TokenStream, input: TokenStream) -> TokenStream {
 /// * `lower`: change the identifier to lower case.
 /// * `upper`: change the identifier to upper case.
 ///
-/// ```ignore
-/// use kernel::macro::paste;
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
 ///
 /// macro_rules! pub_no_prefix {
 ///     ($prefix:ident, $($newname:ident),+) => {
 ///         kernel::macros::paste! {
-///             $(pub(crate) const fn [<$newname:lower:span>]: u32 = [<$prefix $newname:span>];)+
+///             $(pub(crate) const fn [<$newname:lower:span>]() -> u32 {
+///             [<$prefix $newname:span>]
+///             })+
 ///         }
 ///     };
 /// }
@@ -350,7 +380,7 @@ pub fn pinned_drop(args: TokenStream, input: TokenStream) -> TokenStream {
 ///
 /// Literals can also be concatenated with other identifiers:
 ///
-/// ```ignore
+/// ```rust
 /// macro_rules! create_numbered_fn {
 ///     ($name:literal, $val:literal) => {
 ///         kernel::macros::paste! {
diff --git a/rust/macros/paste.rs b/rust/macros/paste.rs
index f40d42b35b58..6529a387673f 100644
--- a/rust/macros/paste.rs
+++ b/rust/macros/paste.rs
@@ -2,7 +2,7 @@
 
 use proc_macro::{Delimiter, Group, Ident, Spacing, Span, TokenTree};
 
-fn concat(tokens: &[TokenTree], group_span: Span) -> TokenTree {
+fn concat_helper(tokens: &[TokenTree]) -> Vec<(String, Span)> {
     let mut tokens = tokens.iter();
     let mut segments = Vec::new();
     let mut span = None;
@@ -46,12 +46,21 @@ fn concat(tokens: &[TokenTree], group_span: Span) -> TokenTree {
                 };
                 segments.push((value, sp));
             }
-            _ => panic!("unexpected token in paste segments"),
+            Some(TokenTree::Group(group)) if group.delimiter() == Delimiter::None => {
+                let tokens = group.stream().into_iter().collect::<Vec<TokenTree>>();
+                segments.append(&mut concat_helper(tokens.as_slice()));
+            }
+            token => panic!("unexpected token in paste segments: {:?}", token),
         };
     }
 
+    segments
+}
+
+fn concat(tokens: &[TokenTree], group_span: Span) -> TokenTree {
+    let segments = concat_helper(tokens);
     let pasted: String = segments.into_iter().map(|x| x.0).collect();
-    TokenTree::Ident(Ident::new(&pasted, span.unwrap_or(group_span)))
+    TokenTree::Ident(Ident::new(&pasted, group_span))
 }
 
 pub(crate) fn expand(tokens: &mut Vec<TokenTree>) {
-- 
2.44.2


