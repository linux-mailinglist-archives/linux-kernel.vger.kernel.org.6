Return-Path: <linux-kernel+bounces-550704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F09EBA56322
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26D2E16FFE2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8366A1E1DFA;
	Fri,  7 Mar 2025 09:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mKZCWrZ1"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07DD1A8F60
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 09:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741338073; cv=none; b=rNzMoJhyKNHxbcjl1+hpRwLIPw14za7FzzDR2Y4NdYSa7/ktUAP6Ef0eUuocmcduRpmnfLMaeNq3vrGZsROPkxWr/cIh0/h97myHIIPcufwdXdOMsYX1Cg2fZlU3TUCKYp+xm4/GoVx/Lvru2+4Yp9wTOhqkeONhIOLNWAZnPnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741338073; c=relaxed/simple;
	bh=iMdbXayB5JUNNSJLawifPMxoZ1VpVma6vxkKpv+va+Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BewM3pNs3k6c+Zwh/pBiqs71OsJyeZZN9Cq7hr4CpmJTHAucmLMVv64dODrl7KA8Nb9pHNmDl3Yi0es+VwEbuF1ol2eAH/vv1TjRIh1tBOLuPmdZw27EjCP9wMpVcQ9mx4IoBzId1fBVIxkGFN8qM97Z0ki5GCeY59ng9vgaEyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mKZCWrZ1; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff798e8c3bso1733891a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 01:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741338070; x=1741942870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W9oLkDdyozH7DFIHltTjhNH2lFWEIt3IiiUaK9MXB3o=;
        b=mKZCWrZ1Q7Tag1tOgb4Rig42NM8mF1sBJp4Z6iZV6cGeb7viurAlwDPUBkNQ9fMbI9
         WlClCzSj+2sYVi3lSNdHbyLbld+cIe+9aUKaK0DDbUGWCubaJv/yL4gqpZWrDHOr9z8S
         43DiZFe6RcV2VqlxSl22i1BeLOgcdBneXkNE0JSMEzswEceOzUc6TTlWEJ5EUArrfOuT
         XcaKbNyA/v66nVfEAYzRtPSjPz80+jntTZbVLnobqXJ7AnE0ry+wCNGqho+g2XsqtQmU
         MKO4UCXKT7n2tDZakSSIbrcdGXrtYO+Ej3oXKgUHMz//WfStX0cjxqoqYFQUslkEF3L+
         ui4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741338070; x=1741942870;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9oLkDdyozH7DFIHltTjhNH2lFWEIt3IiiUaK9MXB3o=;
        b=gfxQSywiOiqEItaOcu/J/7eCM62dp/OueWPdbDYNOAFzRxNoYFN3bsYyKQCr4I5KGU
         xFwluk+/QbHhWHL3aT0WiERXEQldvMqyEO2K0CM9sPmFvbAueUL0MLo13LxJ5cVyve8E
         3zlgHBa/NX9o5kzcE5ib4gDb/Q+yQu8uvHXeZuESERHENwb9E235FCxYN3sB3V6Qgc0c
         btYuLh/Na29F5l0DQi32YdBcpKdKt5DUplkM+r6r6RL8dcrvc1dzR8mk31ugA0ka1W+l
         ANNrgu3khAs1YVLzKJgMMtp7TogPp2v6SVaFCbEakNbHDLm1DepsDJ/rBoKKrSAhkchx
         l5Sg==
X-Forwarded-Encrypted: i=1; AJvYcCVNyNYO6dtTkpUcnQO1r8pvRQRh4/rZj2ZZnL5hMfkDDLrag2ko+AesUZ9JFzxlddUZLcv3H1QHGuoscjE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy++0tyXpJa/VOXl1+OQJucD681EIbCqOPMhPZWf5h5oSFO3GES
	Ir2KpvUjGkeCt6OmyufqVPr3dWqhTHLTVIjg5vcaR7idy9xgdsachPL8GNxDeMSJD5bmbIrA34t
	CCUz2OTtn3g==
X-Google-Smtp-Source: AGHT+IFl5djYlOHwjsH1jSH3vMvR+qCWMY+8vL27eV6cPylbpxewB7NvBKJd+RxaSKmr6cMghF87lYBWXmdemg==
X-Received: from pjbnd10.prod.google.com ([2002:a17:90b:4cca:b0:2ea:29de:af10])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3883:b0:2fe:d766:ad8e with SMTP id 98e67ed59e1d1-2ff7ce74e92mr3974028a91.4.1741338070117;
 Fri, 07 Mar 2025 01:01:10 -0800 (PST)
Date: Fri,  7 Mar 2025 17:00:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250307090103.918788-1-davidgow@google.com>
Subject: [PATCH v8 0/3] rust: kunit: Support KUnit tests with a user-space
 like syntax
From: David Gow <davidgow@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, 
	"=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?=" <jose.exposito89@gmail.com>, Rae Moar <rmoar@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Gary Guo <gary@garyguo.net>, Benno Lossin <benno.lossin@proton.me>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Matt Gilbride <mattgilbride@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Tamir Duberstein <tamird@gmail.com>
Cc: David Gow <davidgow@google.com>, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

This is v8 of the Rust/KUnit integration patch. I think all of the
suggestions have at least been responded to (even if there are a few I'm
leaving as either future projects or matters of taste). Hopefully this
is good-to-go for 6.15, so we can start using it concurrently with
making any additional improvements we may wish.

This series was originally written by Jos=C3=A9 Exp=C3=B3sito, and has been
modified and updated by Matt Gilbride, Miguel Ojeda, and myself. The
original version can be found here:
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

Changes since v7:
https://lore.kernel.org/rust-for-linux/20250214074051.1619256-1-davidgow@go=
ogle.com/
- Reworked the SAFETY comment for addr_of_mut! use with statics in
  kunit_unsafe_test_suite!() (again)
- Removed the second mocking example, which was causing confusion.
  The first example of in_kunit_test() should be clear enough.

Changes since v6:
https://lore.kernel.org/rust-for-linux/20250214074051.1619256-1-davidgow@go=
ogle.com/
- Fixed an [allow(unused_unsafe)] which ended up in patch 2 instead of
  patch 1. (Thanks, Tamir!)
- Doc comments now have several useful links. (Thanks, Tamir!)
- Fix a potential compile error under macos. (Thanks, Tamir!)
- Several small tidy-ups to limit unsafe usage. (Thanks, Tamir!)

Changes since v5:
https://lore.kernel.org/all/20241213081035.2069066-1-davidgow@google.com/
- Rebased against 6.14-rc1
- Fixed a bunch of warnings / clippy lints introduced in Rust 1.83 and
  1.84.
- No longer needs static_mut_refs / const_mut_refs, and is much cleaned
  up as a result. (Thanks, Miguel)
- Major documentation and example fixes. (Thanks, Miguel)

Changes since v4:
https://lore.kernel.org/linux-kselftest/20241101064505.3820737-1-davidgow@g=
oogle.com/
- Rebased against 6.13-rc1
- Allowed an unused_unsafe warning after the behaviour of addr_of_mut!()
  changed in Rust 1.82. (Thanks Boqun, Miguel)
- "Expect" that the sample assert_eq!(1+1, 2) produces a clippy warning
  due to a redundant assertion. (Thanks Boqun, Miguel)
- Fix some missing safety comments, and remove some unneeded 'unsafe'
  blocks. (Thanks Boqun)
- Fix a couple of minor rustfmt issues which were triggering checkpatch
  warnings.

Changes since v3:
https://lore.kernel.org/linux-kselftest/20241030045719.3085147-2-davidgow@g=
oogle.com/T/
- The kunit_unsafe_test_suite!() macro now panic!s if the suite name is
  too long, triggering a compile error. (Thanks, Alice!)
- The #[kunit_tests()] macro now preserves span information, so
  errors can be better reported. (Thanks, Boqun!)
- The example tests have been updated to no longer use assert_eq!() with
  a constant bool argument (which triggered a clippy warning now we
  have the span info).

Changes since v2:
https://lore.kernel.org/linux-kselftest/20241029092422.2884505-1-davidgow@g=
oogle.com/T/
- Include missing rust/macros/kunit.rs file from v2. (Thanks Boqun!)
- The kunit_unsafe_test_suite!() macro will truncate the name of the
  suite if it is too long. (Thanks Alice!)
- The proc macro now emits an error if the suite name is too long.
- We no longer needlessly use UnsafeCell<> in
  kunit_unsafe_test_suite!(). (Thanks Alice!)

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
 rust/kernel/kunit.rs | 171 +++++++++++++++++++++++++++++++++++++++++++
 rust/macros/kunit.rs | 161 ++++++++++++++++++++++++++++++++++++++++
 rust/macros/lib.rs   |  29 ++++++++
 4 files changed, 362 insertions(+)
 create mode 100644 rust/macros/kunit.rs

--=20
2.49.0.rc0.332.g42c0ae87b1-goog


