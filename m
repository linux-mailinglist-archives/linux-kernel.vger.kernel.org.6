Return-Path: <linux-kernel+bounces-241284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9764D92795F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1903F1F2128E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE601B14EA;
	Thu,  4 Jul 2024 14:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jedAyiBa"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1A21B11EE;
	Thu,  4 Jul 2024 14:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720105059; cv=none; b=IZNlUK6WWfTu1Nc/3lcSFR1/n/Ckyj/fOH5HVYAkduhADDwU6jz+etsNqxjUR0FYLShgKG86YEl+Nsq7TT3B+V20WCstU7iwyFjZHrKEsh2sqMNEFDFDLx9+9jaTfH/WKyLe4/G7r8gkwY0lnGSdshMzS+xd/bIFLcVBTBw3iG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720105059; c=relaxed/simple;
	bh=AgRx+RE90Nsd+3SC1MJNAZFTOkBW1aGkM1cwxyvfbW0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aphCUT7kqAy+sWTNZkgnnc0YI95E7sM3P3LjZt2m3dm7l8Q/KS6s3riV6JKXzTgXvhCLdNBasBmA59AUOrUWub/l60AxjSZhC9SbXeS1nD5nIonrKfqnS9+zMwy1rTu0zUUWJoNXF6rjoPf/aZwzyy6enkvxEvT1JCnsTccvWzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jedAyiBa; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7f3d3919a4aso25767639f.1;
        Thu, 04 Jul 2024 07:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720105057; x=1720709857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H1IOl0BzF8HgBSBcBwDW60PY7M8R5w3VEjOB+eb5FzM=;
        b=jedAyiBav6BV73Q2RaNJBHoc3R8N+2xmG9UFiOidPWJ+H7bFt5H81NcQdt9bGjZDzc
         N7rQ4C7eiyxaNoFjkC9u3UN+XYAvbKapv7yhP/QcEM1wsFk5blNR8eGhWZR5teKeDlBU
         qUH5NYcbQys7lTTNjshaKpUxOKm10xa8/3ZATzPr7vo9VgMOgM92qKNZad6q+zITn5jF
         u84eXcxQ07+zV9OlNAaa4ZRoAtTRXDHTpJW/2ODejmtDt4rHlTalRO18t5ZK97CjFgHq
         Uay29iZyAtPiDwFdyZITuNGQn5m0XaQ8MpNXePo3/lcWc81wlguMXwM8CwdXoonhUwXm
         aZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720105057; x=1720709857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1IOl0BzF8HgBSBcBwDW60PY7M8R5w3VEjOB+eb5FzM=;
        b=iiQ/U23XJkEy8QAfPj8VDl4VpJSTeAKJvc/Zmx/MT+G9jWE4lB/fRHEdv/ewTvLTjv
         zCtS1LgXu+jVghZi7wmKbztzlysVeA7UhLjoJyX7tQQMAmrf2dCxlq3Gf5kiAD7fA7TE
         RjiHH5Gr7xitZWEsWl3XsQyZCeD5qtAS7oH7sTCOp0fHSkXnNzPSX6W38CUsXWzvsDuo
         HXq5lMxpM54app01R1W5BpxuUVuPIXa5BQJdjJmlOePChABr5xlEZC5+nrBIC7+QfkDZ
         O8QV1Y++6/Ww/mxy32rM7NdnDjwXzvwZUtYi/q50+Bj0lZc4NfYd4MXZWA7PWKDQSweD
         oeGA==
X-Forwarded-Encrypted: i=1; AJvYcCW/o14IXjUr5mWwW5PTgTxnEz43mZXXqhecIwFw8U4BvzKxKLa8RJRm2tpbVk2JbAHCoRPqlNMQlt94EqibcU0rwscG0aGmH5iPsCDSVJ8ToB6ndzSK58GOG58A4Jdl82xr+ccJLjV6yWiRBVw=
X-Gm-Message-State: AOJu0YxXu4aduGlE+4XBizxbn7ZeCJK/34nABMffPu7K1Nn1puboNpBl
	J48snb5NOo8/W3Xa+Rxz0obu4tnxGCin39eVW/sYvzclRypKE/GU
X-Google-Smtp-Source: AGHT+IEycvy1RUeZggngRqiGufk5KXpqiCYij8IVXDZxf8SybcASMYnCrcrSkp5sq8AHJ95p6Pligg==
X-Received: by 2002:a6b:dc06:0:b0:7f6:19bb:7939 with SMTP id ca18e2360f4ac-7f66dec26b9mr240357239f.11.1720105056885;
        Thu, 04 Jul 2024 07:57:36 -0700 (PDT)
Received: from localhost.localdomain (h135-131-130-199.ashwwi.broadband.dynamic.tds.net. [135.131.130.199])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73bb388asm3940867173.5.2024.07.04.07.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 07:57:36 -0700 (PDT)
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
Subject: [PATCH v3 3/4] rust: macros: Enable use from macro_rules!
Date: Thu,  4 Jul 2024 09:55:44 -0500
Message-ID: <20240704145607.17732-4-ethan.twardy@gmail.com>
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

According to the rustdoc for the proc_macro crate[1], tokens captured
from a "macro variable" (e.g. from within macro_rules!) may be delimited
by invisible tokens and be contained within a proc_macro::Group.
Previously, this scenario was not handled by macros::paste, which caused
a proc-macro panic when the corresponding tests are enabled. Enable the
tests, and handle this case by making macros::paste::concat recursive.

Link: https://doc.rust-lang.org/stable/proc_macro/enum.Delimiter.html [1]
Signed-off-by: Ethan D. Twardy <ethan.twardy@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>

diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index 1c4ae5789cfa..3278f7c8aa5e 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -268,12 +268,25 @@ pub fn pinned_drop(args: TokenStream, input: TokenStream) -> TokenStream {
 ///
 /// # Example
 ///
-/// ```ignore
-/// use kernel::macro::paste;
-///
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
 /// macro_rules! pub_no_prefix {
 ///     ($prefix:ident, $($newname:ident),+) => {
-///         paste! {
+///         kernel::macros::paste! {
 ///             $(pub(crate) const $newname: u32 = [<$prefix $newname>];)+
 ///         }
 ///     };
@@ -312,13 +325,28 @@ pub fn pinned_drop(args: TokenStream, input: TokenStream) -> TokenStream {
 /// * `lower`: change the identifier to lower case.
 /// * `upper`: change the identifier to upper case.
 ///
-/// ```ignore
-/// use kernel::macro::paste;
-///
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
 /// macro_rules! pub_no_prefix {
 ///     ($prefix:ident, $($newname:ident),+) => {
 ///         kernel::macros::paste! {
-///             $(pub(crate) const fn [<$newname:lower:span>]: u32 = [<$prefix $newname:span>];)+
+///             $(pub(crate) const fn [<$newname:lower:span>]() -> u32 {
+///                 [<$prefix $newname:span>]
+///             })+
 ///         }
 ///     };
 /// }
@@ -349,7 +377,7 @@ pub fn pinned_drop(args: TokenStream, input: TokenStream) -> TokenStream {
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


