Return-Path: <linux-kernel+bounces-444390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D974A9F060B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 965AE28220B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 08:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006221A01C3;
	Fri, 13 Dec 2024 08:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ymP8Ub48"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C090E19CD08
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 08:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734077445; cv=none; b=YA8FYjNBpAtVejudz/etgGDymujOHqtPHUBzTgV0OSMFk7kppvJ9lIaTd2569LIZcA9Fb7LLajvgpLOKuyXSddILcH3r/GBdUdydvo7LR22DCD420jEMnn4wcD/lxgJXLu5kX9eY8ZSphBRVaGJRLX9zCkH3vA9FGaqJMFwWZ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734077445; c=relaxed/simple;
	bh=gxKp9OWZ1E4bCe3ugvVAK3mWxjhZvuxJxLwyBzRtgA4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=A+te0XrYpht6rDRLDF0XMsW7/KOh1Q380nmOvqgq+UPms+VlkkynOXEd4WcJNpVcGX6YkcGSG4WJnEEltA30c9XBvgzX6Ecd3+cpIn5xjbVc/in0ivC9ZDCpF1oY9L7tGoibadxZVEnqTk0T/VZp9q2LDMbgLeAZF+0OIdAVF1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ymP8Ub48; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-6c8f99fef10so1714829a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 00:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734077443; x=1734682243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rgsXvM3UIer1JGcfauEdf6Z3rvghq4bsXhkaui6/Vxw=;
        b=ymP8Ub48CNKvZ+FivJvbLOd4LzfG5txNhiJhK6DbCujIBO3stkVobn4Cq3FrM6lj0t
         Fy11kdnO0fbxtJgWBFiLkmQ1GT5BliMROcm9hhdRtrCQ+VC2oN2v2HvpqR2xk251X7TK
         7Q0xOAFSjSKnH4tdr93ENp1OxKVhbqSRJ48Yhpja4qtZb2YCzi6Ze+0WSPMLgi0DDNuZ
         hTfTrCuMmzKHl04V5dViuflWRTK8an7e4wLprwY/2Q8jz8m12sfOoBgv90gikgf092hR
         KvlAstL9598I9slo9Om8WbrF9KKrcwNtPCQEaGikRVYctlK5BwqeAViyFglj+Wbogua+
         uIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734077443; x=1734682243;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rgsXvM3UIer1JGcfauEdf6Z3rvghq4bsXhkaui6/Vxw=;
        b=X1dKBvnP+2YZGPqliZxMZQC9gZ9TFDukk3uV6quTKJncuvWijktt6QmGkwrNcC4Byy
         Q/4xuBFOuRUPo/uvouFuhMTBGp+bIVtTntU5mB6mYmUFkQt4PoNhRzaqHg3VlFhTVLPX
         O97ECBp9PQZqme92B9Dgf3HsAKsdUf3w5v3CndYEMkXSKIw6HnSs6U9yVfEeCVEauo6R
         yP2Fs1FvHgRx6/u2f2MIdpi2VgHNV4PGfUL275MlymkUqD1v49UgzYIvH/eH+0Wp3ISE
         A+yBNSDM2VFcHNyRZ0lBw1HziqIyGY6fLfFmAg4hl0z6rm9bzOVpS/faHolN08+vlIsh
         mJzw==
X-Forwarded-Encrypted: i=1; AJvYcCW3JrEstboRGC3zp+snfdYY5v2C7o+oGi9b5R/p0FLWjOypoJMC0QnL1nxJE5cxT81ax/BvIjEMWfzY/UE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlKbUv3M9rrjv2jX1vWMSWpHvSgRYnS4oa7JE3CtghRCThmYHo
	13eqeSBmYILkF226uUtrQ2w0NY4Lyz2qll32djnRpUemGQwO1sCO3HR+IbAlTTdRqgwz2+mYrrS
	ogrlkTUVREg==
X-Google-Smtp-Source: AGHT+IHDu3GVbZ1pnH0VuSdBAIf2UY7StTwtEWlT5mWvGAfTV/jztnEqSKPuIq36u4YTTsz2rnXWppJalLEdnA==
X-Received: from plbjx6.prod.google.com ([2002:a17:903:1386:b0:215:5322:d126])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ce01:b0:215:50fb:ae4a with SMTP id d9443c01a7336-218928bc06bmr30106525ad.0.1734077443036;
 Fri, 13 Dec 2024 00:10:43 -0800 (PST)
Date: Fri, 13 Dec 2024 16:10:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241213081035.2069066-1-davidgow@google.com>
Subject: [PATCH v5 0/3] rust: kunit: Support KUnit tests with a user-space
 like syntax
From: David Gow <davidgow@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, 
	"=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?=" <jose.exposito89@gmail.com>, Rae Moar <rmoar@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Gary Guo <gary@garyguo.net>, Benno Lossin <benno.lossin@proton.me>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Matt Gilbride <mattgilbride@google.com>
Cc: David Gow <davidgow@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

v5 here is a small set of fixes and a rebase of the previous versions.
If there are no major issues, I'd like to land this soon so it can be
used and tested ready for 6.14.

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
 rust/kernel/kunit.rs | 207 +++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs   |   1 +
 rust/macros/kunit.rs | 168 +++++++++++++++++++++++++++++++++++
 rust/macros/lib.rs   |  29 ++++++
 5 files changed, 406 insertions(+)
 create mode 100644 rust/macros/kunit.rs

--=20
2.47.1.613.gc27f4b7a9f-goog


