Return-Path: <linux-kernel+bounces-391752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF17C9B8B47
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 07:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98A8D282FC8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 06:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE367153801;
	Fri,  1 Nov 2024 06:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3k9YF9IY"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35CF14F115
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 06:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730443514; cv=none; b=lgTptksCW14l7pJXFUIehs934FaVkzmRL844aNUtetWzoQKC5DgsDzJq9hCyL01Seta1QG6lUajCZQWIBqp8C1/nJlsnesQ9AW1ee5GWyiyUlVNDWiBtbJByH6Uj08Fp1TKIeYt5IpQs7pUeycxkvenJHX5mQ0+5Bpbt8XkvMN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730443514; c=relaxed/simple;
	bh=G5ggGuaVpWtCF31Oa4Amy7gU54oA09+xAmXcU0MnLbA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tBoNfrwtA7g96ugZjtXdnBOTUT/KqaBumsZYUfl2SIlFheszq0ae4nEHI0za8pm9TSi65E8A1rOVf5LemYP92Kfz8qMPPCSvjdcVGwMcGSg+dQGRR+9lsZpTGRiZWieW4YAU5/iJEZhuWraRknCUaCphJnzYphcqP6x9fU6oqIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3k9YF9IY; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e35bdb6a31so32752997b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 23:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730443511; x=1731048311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wk7nI7vqLjvU2uvgdGyD/lG4tK8sfViYltbu/ttO3Eg=;
        b=3k9YF9IYsVWUkODi7aZNsemhX9NrNyBWYttF4PX3fB/jsZ8DmGdwponX3umnLHe0k7
         JzgFxfrRi0fQ4b5hAFpTF8HjbyHXK1LD1l1cb/QxXttoiKS6Fu2I88lKKs2vLYDHj+ZO
         ok0OZpkv2vXbEGlnzkgMe+UysxrvUAexKUu4jWCoE0Ww/0JKkAjQ/Sz53hFOBv1SVwbZ
         CmAqVahAIXly92+OtPmoYNdG1e/UIVc9K4+7cq/oUfCbBO8vNvOGQY2WfsGHVJtkyP3Z
         aqDBhJ131Ivik8JalklmDJNjhwU3fCqRTCEq9j/50a5As3E6yEhTQ8vB+/HX9QjllapQ
         8llw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730443511; x=1731048311;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wk7nI7vqLjvU2uvgdGyD/lG4tK8sfViYltbu/ttO3Eg=;
        b=bTEVlpFxHJ8TOUA9y9HMibwAfB/7g9B1XktUp/4FtnAZdnET2pbP3bGBKWSziOmyDe
         MzMI8bmNDRotPBAyGuon/4yaEUhlpienW0ckI8Kw8nh8pXzGL5Ce/HoNZFTCoRNn2x1o
         /CCJCpE+JRornwD2A7nDZmqHq89OGNr0kL8C7oa26pR43LzUWT6VpMZv3h059gfh+Ooy
         8z/Rx4h6Zf7UWZylW4yBRAiloHeK20yYiLZuJcHgGv0sisoOEpJ90Q6BS7Rv+YgZbsro
         GEHMqKnU/KH/sTgHqwykaQ2uPNpc6GjxvYQj2vnsePvwUUygvBXCEF158cHIRBwI+lij
         XMJg==
X-Forwarded-Encrypted: i=1; AJvYcCWTQyB2/JOstNYyqpsSjdPAqqOMbv7ig+ZsvqaAY55Sd5clak7rYlt6r5QgxrZQN48MqC9vGAX5csfz29U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwdBOU6OrkTfnTe1uJMRNZlbrT8yg5fL2xSC2mHL0FPNEJ2LSV
	HefQTfZte36qkMn0/g6X3bGjg1ehtO6mY8Bzef7FTlnr47rhgqqHHz8+R3mbS4gtyw2iANL2cAD
	tursOwDG0bQ==
X-Google-Smtp-Source: AGHT+IH86/LvJL7zohBENkvEob94IEgNdDq7UaeJygoLb+Ctdz9vST1ELgLj+vIeSoahkTX3KjZAQlBtdQ3E9w==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:b1:7045:ac11:6237])
 (user=davidgow job=sendgmr) by 2002:a25:3054:0:b0:e30:d445:a7c with SMTP id
 3f1490d57ef6-e30e5a03f4bmr3398276.1.1730443510674; Thu, 31 Oct 2024 23:45:10
 -0700 (PDT)
Date: Fri,  1 Nov 2024 14:44:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241101064505.3820737-1-davidgow@google.com>
Subject: [PATCH v4 0/3] rust: kunit: Support KUnit tests with a user-space
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
 rust/kernel/kunit.rs | 194 +++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs   |   1 +
 rust/macros/kunit.rs | 168 +++++++++++++++++++++++++++++++++++++
 rust/macros/lib.rs   |  29 +++++++
 5 files changed, 393 insertions(+)
 create mode 100644 rust/macros/kunit.rs

--=20
2.47.0.199.ga7371fff76-goog


