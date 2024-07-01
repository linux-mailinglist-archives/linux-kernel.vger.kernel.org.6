Return-Path: <linux-kernel+bounces-236134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D50F91DDD5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43B9C28108B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791DD1459E3;
	Mon,  1 Jul 2024 11:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFg5eoK2"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCB713D61A;
	Mon,  1 Jul 2024 11:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719833276; cv=none; b=Kb8+qt0dCwWZcOirhyhZz4843/3Ns5YRzPBhGWM2zZDIpecRqTC4DLQW75Yui3FjB8bNgYLbmR9F6IkWfveutUZS472Gfr1yeNbvbwhENTA6FNhZJBThWpc8fXNGrSCGl3wZQ9wr0Syyn+u2gR1cLhX/R9EgJePyKG8OY/sQLME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719833276; c=relaxed/simple;
	bh=AgRx+RE90Nsd+3SC1MJNAZFTOkBW1aGkM1cwxyvfbW0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uQFx7eITrKzLUQfd5yVA/EXA+Q7VvgXpqOrnJkwKRTOqilh8CtiYkVRvJ8bT3CMiAPvTlQ7NTBXCMlLcCS6nOPHtk0qCWNMBvAm2xUO71qPdw+bhFgcUBDSHr9OK8S815c/9nSkwOKVybYDeZ/IpjiJbmenV1qS6m64HSLgt7Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFg5eoK2; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7f3cc78afb6so94666839f.0;
        Mon, 01 Jul 2024 04:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719833274; x=1720438074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H1IOl0BzF8HgBSBcBwDW60PY7M8R5w3VEjOB+eb5FzM=;
        b=PFg5eoK2zLdgq+uxpXnhmMI7XAnUE1nUZ13N183NY1GxEazP93euuQZSyTtcnB8kxD
         9c5B6YXMHa3/4v6O1QUsA1rXIC2rcHrehQFfA6JCLAUYKNTE2fWndEuj5wUxxfKwOVrS
         1Kc8NkZkXmrvMWw6KllXGYORnvxm8KP5MvBsKoUZYleQe9RZW1E5zSQrKbr4+NEQICmv
         k7yteh72IaaQm5MIKlwRIbPwnewL/u6FFZWpr0AgKXFjaei1x2V00LPXxXNBXulHUERr
         36YQ6cEn7xjsOfs6sVF4coQaTwTh+M2bBw3s7DETmbxTtPlyQoaIqYrKRt8IJdmUP8T7
         mt5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719833274; x=1720438074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1IOl0BzF8HgBSBcBwDW60PY7M8R5w3VEjOB+eb5FzM=;
        b=Go3vzgCwtjIl9ukczJG3XkZfYtlmgoEBtYBz+WACjXH0uoQyhc9lbypj6fabYBUk0v
         atOFioSOBX4sCoyZ9149m98B5cmKO7nEoq8ppGrmXxUfTgGio8xz1EAkSGopGIz1zK6J
         MpnBXwtcyxaG8vBYfD82IKDhIXpxkhcYLBS23fT619o0GiZdP4RoOWhXqh7UqaEVi+DL
         nRsNtHm+I2EluiJQUrDr0V4H2l88zFmt4AjUGDXW9j8KaLACAIQG1CvhMSYgxx4+gGPX
         xK/fXOJw00gH+QMVjyWxRyO9LmaGj11MGH0JJ25EelPm0dEJdJdB8iaGhSXtlLEd61j1
         fnPA==
X-Forwarded-Encrypted: i=1; AJvYcCWlQHPns8xIr41bmp+Ol8z3YhJMzVFOY5MR22qWWtGcmwu3fWoer9X4+OmrTRQ+7T5R8Kun3aVU6lpvL8PljIZzV1mleHmmEiB6AO36GZ+PvMliHf3Xq9qBBJ5IxjIn3vQDiCLYC9Ag7gC7CAM=
X-Gm-Message-State: AOJu0YwzbqiMMVlyHKgeMkW+r4X9F1u8v3IgJXfqSOHGQnX+OlsZeRlb
	oObgfjhym4/z53muVNQ7rdcS88a2reHYmRBQAaVRhDrI2aglBgbb
X-Google-Smtp-Source: AGHT+IHdLTIo/Y8vjFuaC1k+wWkzYhKvYsPFjnuNAsi8LLYlEZfwCXcl2azyTDJtjWoBjmvb4YRe4A==
X-Received: by 2002:a6b:740a:0:b0:7eb:6d0a:613e with SMTP id ca18e2360f4ac-7f62ee54728mr480560139f.7.1719833274043;
        Mon, 01 Jul 2024 04:27:54 -0700 (PDT)
Received: from localhost.localdomain (h135-131-130-199.ashwwi.broadband.dynamic.tds.net. [135.131.130.199])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73e062e3sm2087317173.75.2024.07.01.04.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 04:27:53 -0700 (PDT)
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
Subject: [PATCH v2 3/4] rust: macros: Enable use from macro_rules!
Date: Mon,  1 Jul 2024 06:24:25 -0500
Message-ID: <20240701112448.28638-4-ethan.twardy@gmail.com>
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


