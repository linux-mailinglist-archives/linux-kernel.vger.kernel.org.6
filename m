Return-Path: <linux-kernel+bounces-241479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B67927BB7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07206286067
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C73C1CFD7D;
	Thu,  4 Jul 2024 17:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F8GPLKmf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79CC1B6A40
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 17:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720112976; cv=none; b=sRn1AEorrIW2W5pkZwlB6U8UDWBJ3mc9tD5hjwf1M0FH/rZUyr8usg8UxKG4CwQMhI1XafYwwugVuh8a+7FSdpxtCHZJbE8e36Vlqlvwiot6G2lMNVgweZCmt8IKdH1EIla+Mep7sT39QDZfbFB5sZKH6x6pij2DTlGj/1bDl68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720112976; c=relaxed/simple;
	bh=cvsHu/vJjyAxWbz9+KjaSEX/C/NPmn7UBj8A7wCyhI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/BgpUCtkYKXrCTGHBIbHn9mgATerb3lx6K+ONBWTvDsCDQffLJcSodYlowME+WBgyp0xtHoO2I6BL0Zf+dODnIp2tb4Zd5OVuySrEFr+HQTeKlGstpO8PvKd5OYNxJL+lojWgKpcWm4VRWfG3I6KWFmfav8V5aZOAlV/YOr9N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F8GPLKmf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720112974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9cZ2nwTd2aT7nnbRR2poBKjvcKIKwkNp4GrT7R6rP9E=;
	b=F8GPLKmf6t6urR4M2L8LbumkpjRzplxh8PkQEqQ1rFM/BfimBgXAkGLU5EFkff6gJizwGO
	68f+aZU/k/zknqyO3UahHOMit+btnw4RApU09Kl/xqPoaQF90FKW4X4GzoCoddzsQiXPo1
	d//ouKpixxsxZDccaHU3MPH/C8SBj9E=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-hqV1gfyINca4OVonAfqUgw-1; Thu, 04 Jul 2024 13:09:32 -0400
X-MC-Unique: hqV1gfyINca4OVonAfqUgw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a7535875ab7so252666766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 10:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720112971; x=1720717771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9cZ2nwTd2aT7nnbRR2poBKjvcKIKwkNp4GrT7R6rP9E=;
        b=cyXU6cJqvslvfLOusCClmWGorBwyEorV0CbVGX5QE4IeEvl7n8Urte1vEm+HqmDhtW
         laL7lj501huzwsbJlmQiVcO8oEkxYmTbDumP0oRS6HtNdniKa1csa4GeEgKLnpWyMArH
         1Rc9eovQaYHKM+3eDcfNY0NHuUku7NE/bR2PXmcBPZBf8YxoEeL6mJWB/IgmgH3qDqMm
         s5tASoOKhcoCkmnJ8AXvqvkzOLaghdVf7LlY9z+JGh83p4CzpdBa89ZAFDu1VN53LI29
         LhMHe2GSFHf0kIXEgJWJ/nN4ZbNXQacbz9iEA3676L0wiYKf0UmQbRe+VwWPuqhfu8E4
         gZag==
X-Forwarded-Encrypted: i=1; AJvYcCUVG3VXfFyOFY5L3eBZ+JUF/ZDY9hbGUagTNj2AzXAuI8VlcY2hZA5b+KfMlY8cuM0WFf5JV2LCpgrU4nTZm//oMyqGSmgtE2oLDOdL
X-Gm-Message-State: AOJu0YwUURn7hkAU1Tp+JQyvA/ECH1FgM/HS6BlAAfdRep8tbp0KOPRp
	Ey6F5R298915gR5C+AIVa9U4G4k28PU9eOOHgJhm6McRFvYLElCWkwmBGoETUrF7Odp8GHjkEaF
	e35wGkPCObKfiZESat9Av74cnEbcQeZPedfUdfNp9I1qCYrja4af/edujDNXJEQ==
X-Received: by 2002:a17:906:81d4:b0:a6f:dbd1:b493 with SMTP id a640c23a62f3a-a77bd99f2f5mr165474066b.7.1720112971548;
        Thu, 04 Jul 2024 10:09:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6h/9S2N8JV3CbfoPhW779ld7L7IuWfJVjGNYBSoxtWjpKcgyMQgQsbtRu2lLBX8zQvOkalA==
X-Received: by 2002:a17:906:81d4:b0:a6f:dbd1:b493 with SMTP id a640c23a62f3a-a77bd99f2f5mr165471166b.7.1720112971168;
        Thu, 04 Jul 2024 10:09:31 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77c0dff4a5sm43957366b.27.2024.07.04.10.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:09:30 -0700 (PDT)
From: Danilo Krummrich <dakr@redhat.com>
To: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com
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
	Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH 19/20] rust: str: test: replace `alloc::format`
Date: Thu,  4 Jul 2024 19:06:47 +0200
Message-ID: <20240704170738.3621-20-dakr@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704170738.3621-1-dakr@redhat.com>
References: <20240704170738.3621-1-dakr@redhat.com>
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
`CString`, however `CString` uses `KVec` and hence the kernel
allocators, which can't be used for tests run in userspace.

Instead, implement `fmt_assert_eq`, which formats strings into a stack
allocated buffer for comparison with a `&str`.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
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


