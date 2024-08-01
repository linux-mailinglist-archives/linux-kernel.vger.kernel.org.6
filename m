Return-Path: <linux-kernel+bounces-270035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0541D943A74
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 544E2B22996
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 00:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FB314A0A3;
	Thu,  1 Aug 2024 00:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLI33TE1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C0F13210B;
	Thu,  1 Aug 2024 00:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470939; cv=none; b=us9UIvfr3PrbLaUmQqZBfWly0M41JPFUwz8b27WSucD5yFTLr4cuKTNciiAMdfAQ+mdqC6BpghFSiwbwbmzIf5qFJ87nGslU7me/+/pi67A3bFmnQti1c7qDLYUlVDS7ei9BWoQWs6mWYKnP9VFM+CzeU0S6ATLf8eWEGZ6w54g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470939; c=relaxed/simple;
	bh=T1EttxerGLScRoG6GW0jYhIkm3ad2nbCx6FWpPy4fh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WufCPky3xVMxiR0vTLOe39rNhSB/NUEEvpAnZk4rTNgJNzOJHmtHnsdRwTenL/XLKSx906VJOZl0Q9NhgmBYypC4xF9/EOzmRURwM/IDx2sPUmV8QAkbCmO3hgAku4g8S+YFc8XFcc+vMQrmo8IDxzJNPsNurIQfVuRVL4/paXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLI33TE1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C75BEC4AF0C;
	Thu,  1 Aug 2024 00:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470938;
	bh=T1EttxerGLScRoG6GW0jYhIkm3ad2nbCx6FWpPy4fh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XLI33TE11rEBeKAF9x4e/go5ry1nbCbZLeZptgDKd7shye+j1XGZVFWvN8OBlbRcU
	 IZf+fS4ws62sbARE8MZ6EWcmcipdJK54pawAUOjAq2R4mIf1sVEWjK1AZgfQ4VQP0C
	 DtBxVkjCeMhxBet8JfoaEGe6Dg+VO+8ZhqBcTetlWPyBiRKVYGdW/w2KTMUaMvV3Aj
	 QJfuN65H7dfLO4n6fLba59oM/I2rLChWHmee2J1TMmLv4Gn4EJQbfJwfAOcfxavrxO
	 ohhm0Rup6IIUC8X1jSz1lAO0ibZLDPIQCMvhtkhKrsSFVLkdAdkXCBTsfbatXvbTBi
	 vEh4/uwRp5Fjw==
From: Danilo Krummrich <dakr@kernel.org>
To: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	akpm@linux-foundation.org
Cc: daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com,
	boris.brezillon@collabora.com,
	lina@asahilina.net,
	mcanal@igalia.com,
	zhiw@nvidia.com,
	acurrid@nvidia.com,
	cjia@nvidia.com,
	jhubbard@nvidia.com,
	airlied@redhat.com,
	ajanulgu@redhat.com,
	lyude@redhat.com,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v3 23/25] rust: str: test: replace `alloc::format`
Date: Thu,  1 Aug 2024 02:02:22 +0200
Message-ID: <20240801000641.1882-24-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240801000641.1882-1-dakr@kernel.org>
References: <20240801000641.1882-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation of tests in str.rs use `format!` to format
strings for comparison, which, internally, creates a new `String`.

In order to prepare for getting rid of Rust's alloc crate, we have to
cut this dependency. Instead, we could implement `format!` for
`CString`, however `CString` uses the kernel `Vec` type and hence the
kernel allocators, which can't be used for tests run in userspace.

Instead, implement `fmt_assert_eq`, which formats strings into a stack
allocated buffer for comparison with a `&str`.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/str.rs | 66 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 20 deletions(-)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 0b6ffbade521..539be40754f4 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -523,7 +523,6 @@ macro_rules! c_str {
 #[cfg(test)]
 mod tests {
     use super::*;
-    use alloc::format;
 
     const ALL_ASCII_CHARS: &'static str =
         "\\x01\\x02\\x03\\x04\\x05\\x06\\x07\\x08\\x09\\x0a\\x0b\\x0c\\x0d\\x0e\\x0f\
@@ -539,6 +538,33 @@ mod tests {
         \\xe0\\xe1\\xe2\\xe3\\xe4\\xe5\\xe6\\xe7\\xe8\\xe9\\xea\\xeb\\xec\\xed\\xee\\xef\
         \\xf0\\xf1\\xf2\\xf3\\xf4\\xf5\\xf6\\xf7\\xf8\\xf9\\xfa\\xfb\\xfc\\xfd\\xfe\\xff";
 
+    fn format_into_buf<'a>(args: fmt::Arguments<'_>, buf: &'a mut [u8]) -> Result<&'a str, Error> {
+        let mut f = RawFormatter::new();
+        f.write_fmt(args)?;
+        let size = f.bytes_written();
+
+        assert!(buf.len() >= size);
+
+        // SAFETY: `buf` has at least a size of `size` bytes and is valid for writes.
+        let mut f = unsafe { Formatter::from_buffer(buf.as_mut_ptr(), size) };
+        f.write_fmt(args)?;
+
+        Ok(core::str::from_utf8(&buf[0..size])?)
+    }
+
+    macro_rules! fmt_assert_eq {
+        ($str:expr, $($f:tt)*) => ({
+            let mut buf = [0_u8; ALL_ASCII_CHARS.len()];
+
+            let s = match format_into_buf(kernel::fmt!($($f)*), &mut buf) {
+                Ok(s) => s,
+                Err(_) => panic!("Could not format into buffer."),
+            };
+
+            assert_eq!($str, s);
+        })
+    }
+
     #[test]
     fn test_cstr_to_str() {
         let good_bytes = b"\xf0\x9f\xa6\x80\0";
@@ -566,13 +592,13 @@ fn test_cstr_as_str_unchecked() {
     #[test]
     fn test_cstr_display() {
         let hello_world = CStr::from_bytes_with_nul(b"hello, world!\0").unwrap();
-        assert_eq!(format!("{}", hello_world), "hello, world!");
+        fmt_assert_eq!("hello, world!", "{}", hello_world);
         let non_printables = CStr::from_bytes_with_nul(b"\x01\x09\x0a\0").unwrap();
-        assert_eq!(format!("{}", non_printables), "\\x01\\x09\\x0a");
+        fmt_assert_eq!("\\x01\\x09\\x0a", "{}", non_printables);
         let non_ascii = CStr::from_bytes_with_nul(b"d\xe9j\xe0 vu\0").unwrap();
-        assert_eq!(format!("{}", non_ascii), "d\\xe9j\\xe0 vu");
+        fmt_assert_eq!("d\\xe9j\\xe0 vu", "{}", non_ascii);
         let good_bytes = CStr::from_bytes_with_nul(b"\xf0\x9f\xa6\x80\0").unwrap();
-        assert_eq!(format!("{}", good_bytes), "\\xf0\\x9f\\xa6\\x80");
+        fmt_assert_eq!("\\xf0\\x9f\\xa6\\x80", "{}", good_bytes);
     }
 
     #[test]
@@ -583,47 +609,47 @@ fn test_cstr_display_all_bytes() {
             bytes[i as usize] = i.wrapping_add(1);
         }
         let cstr = CStr::from_bytes_with_nul(&bytes).unwrap();
-        assert_eq!(format!("{}", cstr), ALL_ASCII_CHARS);
+        fmt_assert_eq!(ALL_ASCII_CHARS, "{}", cstr);
     }
 
     #[test]
     fn test_cstr_debug() {
         let hello_world = CStr::from_bytes_with_nul(b"hello, world!\0").unwrap();
-        assert_eq!(format!("{:?}", hello_world), "\"hello, world!\"");
+        fmt_assert_eq!("\"hello, world!\"", "{:?}", hello_world);
         let non_printables = CStr::from_bytes_with_nul(b"\x01\x09\x0a\0").unwrap();
-        assert_eq!(format!("{:?}", non_printables), "\"\\x01\\x09\\x0a\"");
+        fmt_assert_eq!("\"\\x01\\x09\\x0a\"", "{:?}", non_printables);
         let non_ascii = CStr::from_bytes_with_nul(b"d\xe9j\xe0 vu\0").unwrap();
-        assert_eq!(format!("{:?}", non_ascii), "\"d\\xe9j\\xe0 vu\"");
+        fmt_assert_eq!("\"d\\xe9j\\xe0 vu\"", "{:?}", non_ascii);
         let good_bytes = CStr::from_bytes_with_nul(b"\xf0\x9f\xa6\x80\0").unwrap();
-        assert_eq!(format!("{:?}", good_bytes), "\"\\xf0\\x9f\\xa6\\x80\"");
+        fmt_assert_eq!("\"\\xf0\\x9f\\xa6\\x80\"", "{:?}", good_bytes);
     }
 
     #[test]
     fn test_bstr_display() {
         let hello_world = BStr::from_bytes(b"hello, world!");
-        assert_eq!(format!("{}", hello_world), "hello, world!");
+        fmt_assert_eq!("hello, world!", "{}", hello_world);
         let escapes = BStr::from_bytes(b"_\t_\n_\r_\\_\'_\"_");
-        assert_eq!(format!("{}", escapes), "_\\t_\\n_\\r_\\_'_\"_");
+        fmt_assert_eq!("_\\t_\\n_\\r_\\_'_\"_", "{}", escapes);
         let others = BStr::from_bytes(b"\x01");
-        assert_eq!(format!("{}", others), "\\x01");
+        fmt_assert_eq!("\\x01", "{}", others);
         let non_ascii = BStr::from_bytes(b"d\xe9j\xe0 vu");
-        assert_eq!(format!("{}", non_ascii), "d\\xe9j\\xe0 vu");
+        fmt_assert_eq!("d\\xe9j\\xe0 vu", "{}", non_ascii);
         let good_bytes = BStr::from_bytes(b"\xf0\x9f\xa6\x80");
-        assert_eq!(format!("{}", good_bytes), "\\xf0\\x9f\\xa6\\x80");
+        fmt_assert_eq!("\\xf0\\x9f\\xa6\\x80", "{}", good_bytes);
     }
 
     #[test]
     fn test_bstr_debug() {
         let hello_world = BStr::from_bytes(b"hello, world!");
-        assert_eq!(format!("{:?}", hello_world), "\"hello, world!\"");
+        fmt_assert_eq!("\"hello, world!\"", "{:?}", hello_world);
         let escapes = BStr::from_bytes(b"_\t_\n_\r_\\_\'_\"_");
-        assert_eq!(format!("{:?}", escapes), "\"_\\t_\\n_\\r_\\\\_'_\\\"_\"");
+        fmt_assert_eq!("\"_\\t_\\n_\\r_\\\\_'_\\\"_\"", "{:?}", escapes);
         let others = BStr::from_bytes(b"\x01");
-        assert_eq!(format!("{:?}", others), "\"\\x01\"");
+        fmt_assert_eq!("\"\\x01\"", "{:?}", others);
         let non_ascii = BStr::from_bytes(b"d\xe9j\xe0 vu");
-        assert_eq!(format!("{:?}", non_ascii), "\"d\\xe9j\\xe0 vu\"");
+        fmt_assert_eq!("\"d\\xe9j\\xe0 vu\"", "{:?}", non_ascii);
         let good_bytes = BStr::from_bytes(b"\xf0\x9f\xa6\x80");
-        assert_eq!(format!("{:?}", good_bytes), "\"\\xf0\\x9f\\xa6\\x80\"");
+        fmt_assert_eq!("\"\\xf0\\x9f\\xa6\\x80\"", "{:?}", good_bytes);
     }
 }
 
-- 
2.45.2


