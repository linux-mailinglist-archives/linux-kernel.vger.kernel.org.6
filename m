Return-Path: <linux-kernel+bounces-386600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E769B45A4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 212E4283BC3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2501EE021;
	Tue, 29 Oct 2024 09:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wf7+CFGW"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6991E1042
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 09:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730193874; cv=none; b=Or8F0sIAAkLeVCWJa2QsaozcBKNh3kRA7rXHb/k6Uf7L/vnm5z9UTW0I2jxDpvCHladXCNA+y/HXp0C7oENw1K3fTLB5J3GPawcMBT4u4ri9zwgbVwDUuYKtrL1xy7azC4+lNS/tgulAePJ7OP7/yjkf6AjMnmxFjA7jpzDw7Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730193874; c=relaxed/simple;
	bh=UTc6KxPryWSJ7soBdBEQQsIFrovCwOrroDeykYKubkA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kvMj+Vao8zOWtEK3JjXnhadkuzd1/I+HtP4LZsLoi9F68epopgRHTL6rvQYiH1mQWLzxdsw4t0gvVoDK+oWHcMjPOl/sAnIUvDHBkBx/JphW6CW6Ih/3ZB4yNfsO45VIfw0kwpdLi7kDigFOAKEa8w/DeTU0X0h13eXdBT/bEfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wf7+CFGW; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e290947f6f8so9361786276.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 02:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730193871; x=1730798671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lOv1XNqhzSTi2v1xjBl65HyN11WbqhoetLuPTUihhNM=;
        b=wf7+CFGWiGFsCLaWMGtdp6N05yholN3SpkS+Vjb2leNNAKobeKr3s+/pQ9nVpUqPCw
         cTfJrlK+tMykNbqoLcWcS5E2W7wEerJxCzfqbm3Awp/aZ0Z2QuWiGFB6JTpV5u7DI4UC
         ylDJAQe8udwFNnY7h/bbvyFooPJ3bk66+e51z3fo/o38/PY28gaY9iFUgMV3TYrGCAl+
         E4MwKcUIzTvN+pKYO9qoU6plzWvMMdne2AW6OA+KPwwaO9F9B4Dll2RcOERSfjvMQY7f
         YsV/IMrJWRE7wqVf9jaG/Bpp8jdKrbF9YIYLCDNxP+K24fgVvFMdgQEr8uPDFpNVNgNT
         oUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730193871; x=1730798671;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOv1XNqhzSTi2v1xjBl65HyN11WbqhoetLuPTUihhNM=;
        b=jNgjsW/ZnmxNeHLf8dFkK/tyAWcopYkKqpHw/xdT936QuPu859iXxxySzeqAOnMSB7
         OzLEZ6zPb9EPciSoxoy4tlQ1Y1g1UXnFS45MkNPmAMfGAKRbCD4LkJ5XN2VwxPH0q7Bj
         oEO/egX5Loyx6cUX7M4jMa7Hr/+2FQiOA6Z67zdARh7VMw1pslziiRt+lVLfRC0HPEN6
         LdT36pjLxLTOTQxPehSaOfjUjL8vFjdJlEpIVBiKud5xzsJVwjIzXd6RcD1UBplzmQ07
         ASxIzKRmItBuZO5RFTWs2b+2WIdCfvx0iZmis/zMZAum/O7KJtnVV7NYRYiz/my/OWwq
         9sNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF107LmsmOr6yg2vcgghY5N3cbGV5lQlP6+cYKOhbXlzgsZg/8pvIYEOrdmHcZbwo+C8+KZmopwG98WSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrmDXs90fqJRV8B+61jX1Uyp5NRb8HepUaPPx/3ZhMoK68yve3
	z6YNhltq/LmgM1ndCDtpn7nZsh/OyqeZWC+5JYzSLlmHFULzC4DgkiscBPebVjOpe9b27zQSmGM
	n/UysvrjRjg==
X-Google-Smtp-Source: AGHT+IG/46UeBOug7p4Ly1YH4lLjvx8EExzDPr//o0o5DvNHCO5mK2Ewif9tZkVgP9PjRPWZ0rP5D9bCD72H4g==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:b1:7045:ac11:6237])
 (user=davidgow job=sendgmr) by 2002:a25:9086:0:b0:e29:74e3:616c with SMTP id
 3f1490d57ef6-e3087a4f19cmr7832276.3.1730193870982; Tue, 29 Oct 2024 02:24:30
 -0700 (PDT)
Date: Tue, 29 Oct 2024 17:24:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241029092422.2884505-1-davidgow@google.com>
Subject: [PATCH v2 0/3] rust: kunit: Support KUnit tests with a user-space
 like syntax
From: David Gow <davidgow@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, 
	"=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?=" <jose.exposito89@gmail.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Rae Moar <rmoar@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Benno Lossin <benno.lossin@proton.me>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Matt Gilbride <mattgilbride@google.com>
Cc: David Gow <davidgow@google.com>, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This series was originally written by Jos=C3=A9 Exp=C3=B3sito, and has been
modified and updated by Matt Gilbride and myself. The original version
can be found here:
https://github.com/Rust-for-Linux/linux/pull/950

Add support for writing KUnit tests in Rust. While Rust doctests are
already converted to KUnit tests and run, they're really better suited
for examples, rather than as first-class unit tests.

This series implements a series of direct Rust bindings for KUnit tests,
as well as a new macro which allows KUnit tests to be written using a
close variant of normal Rust unit test syntax. The only change required
is replacing '#[cfg(test)]' with '#[kunit_tests(kunit_test_suite_name)]'

An example test would look like:
	#[kunit_tests(rust_kernel_hid_driver)]
	mod tests {
	    use super::*;
	    use crate::{c_str, driver, hid, prelude::*};
	    use core::ptr;

	    struct SimpleTestDriver;
	    impl Driver for SimpleTestDriver {
	        type Data =3D ();
	    }

	    #[test]
	    fn rust_test_hid_driver_adapter() {
	        let mut hid =3D bindings::hid_driver::default();
	        let name =3D c_str!("SimpleTestDriver");
	        static MODULE: ThisModule =3D unsafe { ThisModule::from_ptr(ptr::n=
ull_mut()) };

        	let res =3D unsafe {
	            <hid::Adapter<SimpleTestDriver> as driver::DriverOps>::registe=
r(&mut hid, name, &MODULE)
	        };
	        assert_eq!(res, Err(ENODEV)); // The mock returns -19
	    }
	}


Please give this a go, and make sure I haven't broken it! There's almost
certainly a lot of improvements which can be made -- and there's a fair
case to be made for replacing some of this with generated C code which
can use the C macros -- but this is hopefully an adequate implementation
for now, and the interface can (with luck) remain the same even if the
implementation changes.

A few small notable missing features:
- Attributes (like the speed of a test) are hardcoded to the default
  value.
- Similarly, the module name attribute is hardcoded to NULL. In C, we
  use the KBUILD_MODNAME macro, but I couldn't find a way to use this
  from Rust which wasn't more ugly than just disabling it.
- Assertions are not automatically rewritten to use KUnit assertions.

---

Changes since v1:
https://lore.kernel.org/lkml/20230720-rustbind-v1-0-c80db349e3b5@google.com=
/T/
- Rebase on top of the latest rust-next (commit 718c4069896c)
- Make kunit_case a const fn, rather than a macro (Thanks Boqun)
- As a result, the null terminator is now created with
  kernel::kunit::kunit_case_null()
- Use the C kunit_get_current_test() function to implement
  in_kunit_test(), rather than re-implementing it (less efficiently)
  ourselves.

Changes since the GitHub PR:
- Rebased on top of kselftest/kunit
- Add const_mut_refs feature
  This may conflict with https://lore.kernel.org/lkml/20230503090708.252431=
0-6-nmi@metaspace.dk/
- Add rust/macros/kunit.rs to the KUnit MAINTAINERS entry

---
Jos=C3=A9 Exp=C3=B3sito (3):
  rust: kunit: add KUnit case and suite macros
  rust: macros: add macro to easily run KUnit tests
  rust: kunit: allow to know if we are in a test

 MAINTAINERS          |   1 +
 rust/kernel/kunit.rs | 191 +++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs   |   1 +
 rust/macros/lib.rs   |  29 +++++++
 4 files changed, 222 insertions(+)

--=20
2.47.0.163.g1226f6d8fa-goog


