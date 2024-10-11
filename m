Return-Path: <linux-kernel+bounces-361727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB8299AC4C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 21:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D64FC1F257D3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCD11CF5ED;
	Fri, 11 Oct 2024 18:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walterzollerpiano.com header.i=@walterzollerpiano.com header.b="jB77iuDO"
Received: from dd3514.kasserver.com (dd3514.kasserver.com [85.13.129.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3401CEE86;
	Fri, 11 Oct 2024 18:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.129.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728673083; cv=none; b=DH3h7kF3YAD0FuOZwRtowihGecdv1O4nESks4m/PBAmwPM+XSdUSCO9jtKZq88fuofgthriIZn7tpb2gJfX2eKSHUtT9Cy+SwF2vHgh0jPVBAjX47p6psApoS0D70Yiq5X0GyNqZhRJITxor0CYKS1QFsoRpNotmIc8Qz8h+pWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728673083; c=relaxed/simple;
	bh=0q0YdXypHQoS2L7yNMI6p3pr+nIDzO+5+R38LNiFp9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DxVkIc+3OG4QoWW+ueL8MGaXV8rPquXadL2xkw08hk9pekSLWzsMY7K+93TAoVlFPCI9OCbAvir3aSyM7bBqmiCLvB7UkoJLUyIbsdSkxvC06P7v/LCwg6sR1evDEttB4slYzPCpcOK8Vie/q8dbhi3xxNDUBnjyw7PX8Hvcjh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=walterzollerpiano.com; spf=pass smtp.mailfrom=walterzollerpiano.com; dkim=pass (2048-bit key) header.d=walterzollerpiano.com header.i=@walterzollerpiano.com header.b=jB77iuDO; arc=none smtp.client-ip=85.13.129.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=walterzollerpiano.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walterzollerpiano.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=walterzollerpiano.com; s=kas202409051210; t=1728673044;
	bh=WrqJka8i5qDvGJ+Y0RrHzdEvY1FeuQPvghnutR0w8bE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jB77iuDOLObA7y9Apm6haPksllgaOC4FoOGXsaV3JtF0HyQu81s+RVDkxZ5ab6jYu
	 RRIYTWDcH8wNuUKyUADBgFmw/qOz0dNQcV4tvrha5PEbT0eIoyc/IxwPzZVDggQ5of
	 94RCYwohBlrZnqOI6pgpFo6b3PAu819uF++8sQC5TlYwSGbfjEhafY3Sk3iGk7xd6l
	 PCCyFiHoga2U2tAmd1ZiA+w4A7KJRbmf3sBLCi7uGNHYsPCVxxpXQjVni80HFV9tCU
	 6sq0yHJF2G5hXaevOgRbsthYPgj1aJuTUb6k9tQ6SYlxzBEaUWQeQ+N0E1v0nAWRXB
	 +lDQwyrxM2alA==
Received: from [127.0.0.1] (31-10-158-205.cgn.dynamic.upc.ch [31.10.158.205])
	by dd3514.kasserver.com (Postfix) with ESMTPSA id EF40A103AE0;
	Fri, 11 Oct 2024 20:57:23 +0200 (CEST)
From: Josef Zoller <josef@walterzollerpiano.com>
Date: Fri, 11 Oct 2024 20:55:43 +0200
Subject: [PATCH 2/3] rust: macros: add IoctlCommand derive macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-rust-char-dev-v1-2-350225ae228b@walterzollerpiano.com>
References: <20241011-rust-char-dev-v1-0-350225ae228b@walterzollerpiano.com>
In-Reply-To: <20241011-rust-char-dev-v1-0-350225ae228b@walterzollerpiano.com>
To: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Josef Zoller <josef@walterzollerpiano.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=15919;
 i=josef@walterzollerpiano.com; h=from:subject:message-id;
 bh=0q0YdXypHQoS2L7yNMI6p3pr+nIDzO+5+R38LNiFp9I=;
 b=owEBbQKS/ZANAwAIAROd718OBo3IAcsmYgBnCXUSWhbnapsd0DsRQAG42iRnQlj4GIA13ovNl
 CjjQpUIx+iJAjMEAAEIAB0WIQQnwV8chXqnjaC1vcATne9fDgaNyAUCZwl1EgAKCRATne9fDgaN
 yBmuD/0WZF294zFm8cl3uzo3YMELuCJioLsL21Ex5jfgADB5TOSc5LbxDOwKPPFc6STVtIPdtFJ
 1IJI90YpTrHTXEGw8EUrml2+rriy3D2kgncXcOs0nhpRvTlU+S8Peq3pNh2vjxO4/tdFM43+/Jg
 UR7IxoPcvOcbL0/BjwWhDWQIe28ZPpjDG7KcQwY+5Ndo2Pq9rJAGOalpMw3kobcoLZtC394JtL+
 cYg6Yih30qQucvizCOu2haTmDFSq2F+1/2rOMmDu5UurAfZBt0ZJy9mXp86t2sGMJQeFdabYaeQ
 CjP2DY8F9CVzn3kxfpDM9n5OGc7BL57yihnlgOCbe8bJS5YN3/okcBhrQFTdmccuWl+yadCA/5+
 xNQ2+TjMGGq8OJUcRU66NS7JkrxsG8ExpRDYg6yZWB4ss/ZoeyVBCQ/0dN499u1wy6qyRjjyLkL
 dFCymHSwe3TBD5ykmSKDdThPsWGpNrzBE6ZKWBQ6YkptAo/XoSnBuQTqtBweRIm2C+PuK9EA1m+
 6Wl+/tHKCLmp6trcEmD7QSxvprg5COyd1ILOUDAPZbmNCBlZlkntD6YUSDZesKUmxuknp0RYwej
 W8oJp+B1vkveIHdl4Tk5AaZ2xlybXhB+XUieebvOr/IueZfsDEnL2u66AalOChzZQorRSl5X1bo
 HYgcKlJpajrP/Gw==
X-Developer-Key: i=josef@walterzollerpiano.com; a=openpgp;
 fpr=27C15F1C857AA78DA0B5BDC0139DEF5F0E068DC8
X-Spamd-Bar: ----

Provide a macro that derives the `IoctlCommand` trait for simple enums
by converting every variant into a unique command.

The macro can be instructed to use a specific letter or integer as the
code. Each variant is then assigned a consecutive number starting from
0 or a given value. The type of the command, i.e. if it is a read or
write command, is inferred from the variant's associated data: if it
has no data or only an integer, it is neither read nor write, if it has
a UserSliceReader it is a write command, if it has a UserSliceWriter it
is a read command, and if it just has a UserSlice it is a read-write
command. The code and the variant's number and type are then combined
to parse the command from the user-provided cmd and arg values.

Signed-off-by: Josef Zoller <josef@walterzollerpiano.com>
---
 rust/kernel/ioctl.rs     | 190 ++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/prelude.rs   |   2 +-
 rust/macros/ioctl_cmd.rs | 202 +++++++++++++++++++++++++++++++++++++++++++++++
 rust/macros/lib.rs       |  21 +++++
 4 files changed, 414 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/ioctl.rs b/rust/kernel/ioctl.rs
index 03359ab28495b94d98d53db2115bbbcc520c18a3..f6af9c10c0b244b8d8183cf70b4ef5ce9233c935 100644
--- a/rust/kernel/ioctl.rs
+++ b/rust/kernel/ioctl.rs
@@ -73,6 +73,22 @@ pub const fn _IOC_SIZE(nr: u32) -> usize {
 }
 
 /// Types implementing this trait can be used to parse ioctl commands.
+///
+/// Normally, this trait is derived for a command enum.
+///
+/// # Example
+///
+/// ```
+/// #[derive(IoctlCommand)]
+/// #[ioctl(code = 0x18, start_num = 0)]
+/// enum Command {
+///     NoReadWrite,                 // No read or write access.
+///     NoReadWriteButTakesArg(u64), // No read or write access, but takes an argument.
+///     ReadOnly(UserSliceWriter),   // We write data for the user to read.
+///     WriteOnly(UserSliceReader),  // We read data that the user wrote.
+///     WriteAndRead(UserSlice),     // We read data from the user and then write data to the user.
+/// }
+/// ```
 #[vtable]
 pub trait IoctlCommand: Sized + Send + Sync + 'static {
     /// The error type returned by the parse functions.
@@ -114,3 +130,177 @@ fn parse(_cmd: ffi::c_uint, _arg: ffi::c_ulong) -> Result<Self> {
         Err(ENOTTY)
     }
 }
+
+/// Support macro for deriving the `IoctlCommand` trait.
+#[doc(hidden)]
+#[macro_export]
+macro_rules! __derive_ioctl_cmd {
+    (parse_input:
+        @enum_name($enum_name:ident),
+        @code($code:literal),
+        @variants(
+            $(
+                @variant($i:literal, $variant:ident, $arg_type:tt),
+            )*
+        )
+    ) => {
+        #[automatically_derived]
+        impl $crate::ioctl::IoctlCommand for $enum_name {
+            type Err = $crate::error::Error;
+
+            const USE_VTABLE_ATTR: () = ();
+
+            const HAS_PARSE: bool = true;
+
+            fn parse(
+                cmd: ::core::ffi::c_uint,
+                arg: ::core::ffi::c_ulong,
+            ) -> ::core::result::Result<Self, Self::Err> {
+                let ty = $crate::ioctl::_IOC_TYPE(cmd) as u8;
+
+                if ty != $code {
+                    return Err($crate::error::code::ENOTTY);
+                }
+
+                let nr = $crate::ioctl::_IOC_NR(cmd) as u8;
+                let dir = $crate::ioctl::_IOC_DIR(cmd);
+                let size = $crate::ioctl::_IOC_SIZE(cmd);
+
+                // Make sure we don't get unused parameter warnings
+                let _ = arg;
+
+                match (nr, dir, size) {
+                    $(
+                        ::kernel::__derive_ioctl_cmd!(
+                            match_pattern:
+                                @variant($i, $arg_type)
+                        ) => ::kernel::__derive_ioctl_cmd!(
+                            match_body:
+                                @dir(dir),
+                                @size(size),
+                                @arg(arg),
+                                @variant($variant, $arg_type)
+                        ),
+                    )*
+                    _ => Err($crate::error::code::ENOTTY),
+                }
+            }
+        }
+    };
+    (match_pattern:
+        @variant($i:literal, None)
+    ) => {
+        ($i, $crate::uapi::_IOC_NONE, 0)
+    };
+    (match_body:
+        @dir($dir:ident),
+        @size($size:ident),
+        @arg($arg:ident),
+        @variant($variant:ident, None)
+    ) => {
+        Ok(Self::$variant)
+    };
+    (match_pattern:
+        @variant($i:literal, u64)
+    ) => {
+        ($i, $crate::uapi::_IOC_NONE, 0)
+    };
+    (match_body:
+        @dir($dir:ident),
+        @size($size:ident),
+        @arg($arg:ident),
+        @variant($variant:ident, u64)
+    ) => {
+        Ok(Self::$variant($arg))
+    };
+    (match_pattern:
+        @variant($i:literal, UserSliceWriter)
+    ) => {
+        ($i, $crate::uapi::_IOC_READ, _)
+    };
+    (match_body:
+        @dir($dir:ident),
+        @size($size:ident),
+        @arg($arg:ident),
+        @variant($variant:ident, UserSliceWriter)
+    ) => {
+        {
+            let user_writer = $crate::uaccess::UserSlice::new(
+                $arg as $crate::uaccess::UserPtr,
+                $size
+            )
+            .writer();
+
+            Ok(Self::$variant(user_writer))
+        }
+    };
+    (match_pattern:
+        @variant($i:literal, UserSliceReader)
+    ) => {
+        ($i, $crate::uapi::_IOC_WRITE, _)
+    };
+    (match_body:
+        @dir($dir:ident),
+        @size($size:ident),
+        @arg($arg:ident),
+        @variant($variant:ident, UserSliceReader)
+    ) => {
+        {
+            let user_reader = $crate::uaccess::UserSlice::new(
+                $arg as $crate::uaccess::UserPtr,
+                $size
+            )
+            .reader();
+
+            Ok(Self::$variant(user_reader))
+        }
+    };
+    (match_pattern:
+        @variant($i:literal, UserSlice)
+    ) => {
+        ($i, _, _)
+    };
+    (match_body:
+        @dir($dir:ident),
+        @size($size:ident),
+        @arg($arg:ident),
+        @variant($variant:ident, UserSlice)
+    ) => {
+        // Unfortunately, we cannot just do a match guard
+        if $dir != $crate::uapi::_IOC_READ | $crate::uapi::_IOC_WRITE {
+            Err($crate::error::code::ENOTTY)
+        } else {
+            let user_slice = $crate::uaccess::UserSlice::new(
+                $arg as $crate::uaccess::UserPtr,
+                $size
+            );
+
+            Ok(Self::$variant(user_slice))
+        }
+    };
+    (match_pattern:
+        @variant($i:literal, $arg_type:tt)
+    ) => {
+        ($i, _, _)
+    };
+    (match_body:
+        @dir($dir:ident),
+        @size($size:ident),
+        @arg($arg:ident),
+        @variant($variant:ident, $arg_type:tt)
+    ) => {
+        {
+            // We have an unsupported argument type
+            const _: () = ::core::assert!(
+                false,
+                ::core::concat!(
+                    "Invalid argument type for ioctl command ",
+                    stringify!($variant),
+                    ": ",
+                    stringify!($arg_type),
+                )
+            );
+            ::core::unreachable!()
+        }
+    };
+}
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index 4571daec0961bb34fb6956a4e9eda8445954b719..1277d1ec5a476d3e115f6b2ba432b0fbe28941a2 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -20,7 +20,7 @@
 pub use alloc::{boxed::Box, vec::Vec};
 
 #[doc(no_inline)]
-pub use macros::{module, pin_data, pinned_drop, vtable, Zeroable};
+pub use macros::{module, pin_data, pinned_drop, vtable, IoctlCommand, Zeroable};
 
 pub use super::build_assert;
 
diff --git a/rust/macros/ioctl_cmd.rs b/rust/macros/ioctl_cmd.rs
new file mode 100644
index 0000000000000000000000000000000000000000..366a9b1f7ba70ba764b0d78cb32d82125bc7b854
--- /dev/null
+++ b/rust/macros/ioctl_cmd.rs
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use proc_macro::{token_stream, Delimiter, Literal, TokenStream, TokenTree};
+
+fn expect_punct(input: &mut impl Iterator<Item = TokenTree>, expected: char, reason: &str) {
+    let Some(TokenTree::Punct(punct)) = input.next() else {
+        panic!("expected '{expected}' {reason}");
+    };
+
+    if punct.as_char() != expected {
+        panic!("expected '{expected}' {reason}");
+    }
+}
+
+fn expect_ident(input: &mut impl Iterator<Item = TokenTree>, expected: &str, reason: &str) {
+    let Some(TokenTree::Ident(ident)) = input.next() else {
+        panic!("expected '{expected}' {reason}");
+    };
+
+    if ident.to_string() != expected {
+        panic!("expected '{expected}' {reason}");
+    }
+}
+
+fn expect_group(
+    input: &mut impl Iterator<Item = TokenTree>,
+    expected: Delimiter,
+    reason: &str,
+) -> token_stream::IntoIter {
+    let Some(TokenTree::Group(group)) = input.next() else {
+        panic!("expected group {reason}");
+    };
+
+    if group.delimiter() != expected {
+        panic!("expected group {reason}");
+    }
+
+    group.stream().into_iter()
+}
+
+fn parse_attribute(input: &mut impl Iterator<Item = TokenTree>) -> (u8, u8) {
+    expect_punct(input, '#', "to start attribute");
+
+    let mut stream = expect_group(input, Delimiter::Bracket, "as attribute body");
+
+    expect_ident(&mut stream, "ioctl", "as attribute name");
+
+    let mut inner_stream = expect_group(
+        &mut stream,
+        Delimiter::Parenthesis,
+        "as attribute arguments",
+    );
+
+    expect_ident(&mut inner_stream, "code", "as ioctl attribute field");
+    expect_punct(&mut inner_stream, '=', "in ioctl attribute field");
+
+    let Some(TokenTree::Literal(lit)) = inner_stream.next() else {
+        panic!("expected ioctl attribute code value");
+    };
+
+    let lit_str = lit.to_string();
+    let code = if lit_str.starts_with("b'") {
+        lit_str
+            .chars()
+            .nth(2)
+            .expect("expected ioctl attribute code value") as u8
+    } else if let Some(hex) = lit_str.strip_prefix("0x") {
+        u8::from_str_radix(hex, 16).expect("expected ioctl attribute code value")
+    } else {
+        lit_str
+            .parse()
+            .expect("expected ioctl attribute code value")
+    };
+
+    let start_num = if let Some(tree) = inner_stream.next() {
+        if !matches!(tree, TokenTree::Punct(punct) if punct.as_char() == ',') {
+            panic!("expected ioctl attribute comma");
+        }
+
+        expect_ident(&mut inner_stream, "start_num", "as ioctl attribute field");
+        expect_punct(&mut inner_stream, '=', "in ioctl attribute field");
+
+        let Some(TokenTree::Literal(lit)) = inner_stream.next() else {
+            panic!("expected ioctl attribute start number value");
+        };
+
+        lit.to_string()
+            .parse()
+            .expect("expected ioctl attribute start number value")
+    } else {
+        0
+    };
+
+    assert!(
+        inner_stream.next().is_none(),
+        "unexpected token in ioctl attribute"
+    );
+    assert!(
+        stream.next().is_none(),
+        "unexpected token in ioctl attribute"
+    );
+
+    (code, start_num)
+}
+
+fn parse_enum_def(input: &mut impl Iterator<Item = TokenTree>) -> TokenTree {
+    expect_ident(input, "enum", "to start enum definition");
+
+    let Some(ident @ TokenTree::Ident(_)) = input.next() else {
+        panic!("expected enum name");
+    };
+
+    ident
+}
+
+fn parse_enum_body(
+    input: &mut impl Iterator<Item = TokenTree>,
+) -> Vec<(TokenTree, Option<TokenTree>)> {
+    let mut stream = expect_group(input, Delimiter::Brace, "as enum body").peekable();
+
+    let mut variants = Vec::new();
+
+    while let Some(variant) = stream.next_if(|t| matches!(t, TokenTree::Ident(_))) {
+        let arg_type = if let Some(TokenTree::Group(group)) =
+            stream.next_if(|t| matches!(t, TokenTree::Group(_)))
+        {
+            if group.delimiter() != Delimiter::Parenthesis {
+                panic!("expected group");
+            }
+
+            let mut inner_stream = group.stream().into_iter();
+
+            let arg_type = if let Some(ident @ TokenTree::Ident(_)) = inner_stream.next() {
+                ident
+            } else {
+                panic!("expected argument type")
+            };
+
+            assert!(
+                inner_stream.next().is_none(),
+                "unexpected token in enum variant"
+            );
+
+            Some(arg_type)
+        } else {
+            None
+        };
+
+        variants.push((variant, arg_type));
+
+        if stream
+            .next_if(|t| matches!(t, TokenTree::Punct(punct) if punct.as_char() == ','))
+            .is_none()
+        {
+            break;
+        }
+    }
+
+    assert!(stream.next().is_none(), "unexpected token in enum body");
+
+    variants
+}
+
+pub(crate) fn derive(input: TokenStream) -> TokenStream {
+    let mut input = input.into_iter();
+
+    let (code, start_num) = parse_attribute(&mut input);
+    let enum_name = parse_enum_def(&mut input);
+    let variants = parse_enum_body(&mut input);
+
+    assert!(input.next().is_none(), "unexpected token in ioctl_cmd");
+
+    let code = TokenTree::from(Literal::u8_suffixed(code));
+
+    let variants = variants
+        .into_iter()
+        .enumerate()
+        .map(|(i, (variant, arg_type))| {
+            let i = i as u8 + start_num;
+
+            let i = TokenTree::from(Literal::u8_suffixed(i));
+
+            if let Some(arg_type) = arg_type {
+                quote! {
+                    @variant(#i, #variant, #arg_type),
+                }
+            } else {
+                quote! {
+                    @variant(#i, #variant, None),
+                }
+            }
+        });
+
+    quote! {
+        ::kernel::__derive_ioctl_cmd!(
+            parse_input:
+                @enum_name(#enum_name),
+                @code(#code),
+                @variants(#(#variants)*)
+        );
+    }
+}
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index a626b1145e5c4ff00692e9d4e11fdb93500db1a8..5a33ed69b5b0b64f6720fb54e18056af9b2f7a00 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -10,6 +10,7 @@
 mod quote;
 mod concat_idents;
 mod helpers;
+mod ioctl_cmd;
 mod module;
 mod paste;
 mod pin_data;
@@ -412,6 +413,26 @@ pub fn paste(input: TokenStream) -> TokenStream {
     tokens.into_iter().collect()
 }
 
+/// Derives the [`IoctlCommand`] trait for the given enum.
+///
+/// # Example
+///
+/// ```
+/// #[derive(IoctlCommand)]
+/// #[ioctl(code = 0x18, start_num = 0)]
+/// enum Command {
+///     NoReadWrite,                 // No read or write access.
+///     NoReadWriteButTakesArg(u64), // No read or write access, but takes an argument.
+///     ReadOnly(UserSliceWriter),   // We write data for the user to read.
+///     WriteOnly(UserSliceReader),  // We read data that the user wrote.
+///     WriteAndRead(UserSlice),     // We read data from the user and then write data to the user.
+/// }
+/// ```
+#[proc_macro_derive(IoctlCommand, attributes(ioctl))]
+pub fn derive_ioctl_cmd(input: TokenStream) -> TokenStream {
+    ioctl_cmd::derive(input)
+}
+
 /// Derives the [`Zeroable`] trait for the given struct.
 ///
 /// This can only be used for structs where every field implements the [`Zeroable`] trait.

-- 
2.47.0


